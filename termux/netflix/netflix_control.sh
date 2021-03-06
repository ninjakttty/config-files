
NETFLIX_KIDS_MOVIE_IDS_FILE=$CONFIG_FILES_DIR/termux/netflix/netflix_kids_movies_ids.txt
NETFLIX_MOVIE_IDS_FILE=$CONFIG_FILES_DIR/termux/netflix/netflix_movies_ids.txt

function netflix-rnd()
{
    # You should define a txt file with list of NETFLIX movies ids
    # NETFLIX_MOVIE_IDS_FILE
    open-url "http://www.netflix.com/title/"$(shuf -n1 $NETFLIX_MOVIE_IDS_FILE | awk '{print $1}')
}

function netflix-kids-rnd()
{
    # You should define a txt file with list of NETFLIX movies ids
    # NETFLIX_MOVIE_IDS_FILE
    open-url "http://www.netflix.com/title/"$(shuf -n1 $NETFLIX_KIDS_MOVIE_IDS_FILE | awk '{print $1}')
}


function netflix-search()
{
    search_item=$1

    am start -n com.netflix.mediaclient/.ui.search.SearchActivity -a android.intent.action.SEARCH --es "query" "$search_item"
}