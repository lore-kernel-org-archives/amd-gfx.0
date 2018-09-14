From: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH 1/2] list: introduce list_bulk_move_tail helper
Date: Fri, 14 Sep 2018 10:53:19 +0800
Message-ID: <20180914025228.GA17902@hr-amur2>
References: <20180913112208.1353-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180913112208.1353-1-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Sep 13, 2018 at 01:22:07PM +0200, Christian König wrote:
> Move all entries between @first and including @last before @head.
> 
> This is useful for LRU lists where a whole block of entries should be
> moved to the end of an list.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Bulk move helper is useful for TTM driver to improve the LRU moving
efficiency. Please go on with my RB.

Series are Reviewed-and-Tested-by: Huang Rui <ray.huang@amd.com>

> ---
>  include/linux/list.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index de04cc5ed536..edb7628e46ed 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -183,6 +183,29 @@ static inline void list_move_tail(struct list_head *list,
>  	list_add_tail(list, head);
>  }
>  
> +/**
> + * list_bulk_move_tail - move a subsection of a list to its tail
> + * @head: the head that will follow our entry
> + * @first: first entry to move
> + * @last: last entry to move, can be the same as first
> + *
> + * Move all entries between @first and including @last before @head.
> + * All three entries must belong to the same linked list.
> + */
> +static inline void list_bulk_move_tail(struct list_head *head,
> +				       struct list_head *first,
> +				       struct list_head *last)
> +{
> +	first->prev->next = last->next;
> +	last->next->prev = first->prev;
> +
> +	head->prev->next = first;
> +	first->prev = head->prev;
> +
> +	last->next = head;
> +	head->prev = last;
> +}
> +
>  /**
>   * list_is_last - tests whether @list is the last entry in list @head
>   * @list: the entry to test
> -- 
> 2.14.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
