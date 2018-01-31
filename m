From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] [WIP]drm/ttm: add waiter list to prevent allocation
 not in order
Date: Wed, 31 Jan 2018 11:54:07 +0100
Message-ID: <ff405b17-7f7c-3a9e-030b-28dcfc256546@amd.com>
References: <20180126102247.17923-1-david1.zhou@amd.com>
 <2beeea26-9426-6956-fbc7-ada52088b6a6@gmail.com>
 <5a6b20fc.024e650a.6778d.4aafSMTPIN_ADDED_BROKEN@mx.google.com>
 <b1a6305e-1ff8-430b-8b72-c08d469de73b@gmail.com>
 <8ba40eb5-095b-2a95-d73a-16c141eb64a9@gmail.com>
 <5a6b2b4c.c441650a.c40de.5db1SMTPIN_ADDED_BROKEN@mx.google.com>
 <acdfee36-ae2f-b90f-cab7-ebe8fd40fbd6@gmail.com>
 <e3ed22b7-ca1a-09d0-47a0-204affef780f@amd.com>
 <a6d78bba-bbe9-769b-f9d3-665cdd8c04da@gmail.com>
 <cdb7726b-a82d-494c-a98c-ca0100f323cc@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1214789432=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cdb7726b-a82d-494c-a98c-ca0100f323cc-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1214789432==
Content-Type: multipart/alternative;
 boundary="------------08D0791B8C85E311360F9030"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------08D0791B8C85E311360F9030
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> So I think preventing validation on same place is a simpler way:
> process B bo's place is fpfn~lpfn, it will only try to evict LRU BOs 
> in that range, while eviction, we just prevent those validation to 
> this range(fpfn~lpfn), if out of this range, the allocation/validation 
> still can be go on.
>
> Any negative?
That won't work either. The most common use of fpfn~lpfn range is to 
limit a BO to visible VRAM, the other use cases are to fullfil hardware 
limitations.

So blocking this would result in blocking all normal GTT and VRAM 
allocations, adding a mutex to validate would have the same effect.

Regards,
Christian.

Am 31.01.2018 um 11:30 schrieb Chunming Zhou:
>
>
>
> On 2018年01月26日 22:35, Christian König wrote:
>> I just realized that a change I'm thinking about for a while would 
>> solve your problem as well, but keep concurrent allocation possible.
>>
>> See ttm_mem_evict_first() unlocks the BO after evicting it:
>>>         ttm_bo_del_from_lru(bo);
>>>         spin_unlock(&glob->lru_lock);
>>>
>>>         ret = ttm_bo_evict(bo, ctx);
>>>         if (locked) {
>>>                 ttm_bo_unreserve(bo); <-------- here
>>>         } else {
>>>                 spin_lock(&glob->lru_lock);
>>>                 ttm_bo_add_to_lru(bo);
>>>                 spin_unlock(&glob->lru_lock);
>>>         }
>>>
>>>         kref_put(&bo->list_kref, ttm_bo_release_list);
>>
>> The effect is that in your example process C can not only beat 
>> process B once, but many many times because we run into a ping/pong 
>> situation where B evicts resources while C moves them back in.
> For ping/pong case, I want to disable busy placement for allocation 
> period, only enable it for cs bo validation.
>
>>
>> For a while now I'm thinking about dropping those reservations only 
>> after the original allocation succeeded.
>>
>> The effect would be that process C can still beat process B 
>> initially, but sooner or process B would evict some resources from 
>> process C as well and then it can succeed with its allocation.
> If it is from process C cs validation, process B still need evict the 
> resource only after process C command submission completion.
>
>>
>> The problem is for this approach to work we need to core change to 
>> the ww_mutexes to be able to handle this efficiently.
> Yes, ww_mutex doesn't support this net lock, which easily deadlock 
> without ticket and class.
>
> So I think preventing validation on same place is a simpler way:
> process B bo's place is fpfn~lpfn, it will only try to evict LRU BOs 
> in that range, while eviction, we just prevent those validation to 
> this range(fpfn~lpfn), if out of this range, the allocation/validation 
> still can be go on.
>
> Any negative?
>
> Regards,
> David Zhou
>>
>> Regards,
>> Christian.
>>
>> Am 26.01.2018 um 14:59 schrieb Christian König:
>>> I know, but this has the same effect. You prevent concurrent 
>>> allocation from happening.
>>>
>>> What we could do is to pipeline reusing of deleted memory as well, 
>>> this makes it less likely to cause the problem you are seeing 
>>> because the evicting processes doesn't need to block for deleted BOs 
>>> any more.
>>>
>>> But that other processes can grab memory during eviction is 
>>> intentional. Otherwise greedy processes would completely dominate 
>>> command submission.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 26.01.2018 um 14:50 schrieb Zhou, David(ChunMing):
>>>> I don't want to prevent all, my new approach is to prevent the 
>>>> later allocation is trying and ahead of front to get the memory 
>>>> space that the front made from eviction.
>>>>
>>>>
>>>> 发自坚果 Pro
>>>>
>>>> Christian K鰊ig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> 于 2018年1月26日 
>>>> 下午9:24写道：
>>>>
>>>> Yes, exactly that's the problem.
>>>>
>>>> See when you want to prevent a process B from allocating the memory 
>>>> process A has evicted, you need to prevent all concurrent allocation.
>>>>
>>>> And we don't do that because it causes a major performance drop.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 26.01.2018 um 14:21 schrieb Zhou, David(ChunMing):
>>>>> You patch will prevent concurrent allocation, and will result in 
>>>>> allocation performance drop much.
>>>>>
>>>>> 发自坚果 Pro
>>>>>
>>>>> Christian K鰊ig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> 于 2018年1月26日 
>>>>> 下午9:04写道：
>>>>>
>>>>> Attached is what you actually want to do cleanly implemented. But 
>>>>> as I said this is a NO-GO.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>> Am 26.01.2018 um 13:43 schrieb Christian König:
>>>>>>> After my investigation, this issue should be detect of TTM 
>>>>>>> design self, which breaks scheduling balance.
>>>>>> Yeah, but again. This is indented design we can't change easily.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>> Am 26.01.2018 um 13:36 schrieb Zhou, David(ChunMing):
>>>>>>> I am off work, so reply mail by phone, the format could not be text.
>>>>>>>
>>>>>>> back to topic itself:
>>>>>>> the problem indeed happen on amdgpu driver, someone reports me 
>>>>>>> that application runs with two instances, the performance are 
>>>>>>> different.
>>>>>>> I also reproduced the issue with unit test(bo_eviction_test). 
>>>>>>> They always think our scheduler isn't working as expected.
>>>>>>>
>>>>>>> After my investigation, this issue should be detect of TTM 
>>>>>>> design self, which breaks scheduling balance.
>>>>>>>
>>>>>>> Further, if we run containers for our gpu, container A could run 
>>>>>>> high score, container B runs low score with same benchmark.
>>>>>>>
>>>>>>> So this is bug that we need fix.
>>>>>>>
>>>>>>> Regards,
>>>>>>> David Zhou
>>>>>>>
>>>>>>> 发自坚果 Pro
>>>>>>>
>>>>>>> Christian K鰊ig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> 于 2018年1月26日 
>>>>>>> 下午6:31写道：
>>>>>>>
>>>>>>> Am 26.01.2018 um 11:22 schrieb Chunming Zhou:
>>>>>>> > there is a scheduling balance issue about get node like:
>>>>>>> > a. process A allocates full memory and use it for submission.
>>>>>>> > b. process B tries to allocates memory, will wait for process 
>>>>>>> A BO idle in eviction.
>>>>>>> > c. process A completes the job, process B eviction will put 
>>>>>>> process A BO node,
>>>>>>> > but in the meantime, process C is comming to allocate BO, 
>>>>>>> whill directly get node successfully, and do submission,
>>>>>>> > process B will again wait for process C BO idle.
>>>>>>> > d. repeat the above setps, process B could be delayed much more.
>>>>>>> >
>>>>>>> > later allocation must not be ahead of front in same place.
>>>>>>>
>>>>>>> Again NAK to the whole approach.
>>>>>>>
>>>>>>> At least with amdgpu the problem you described above never occurs
>>>>>>> because evictions are pipelined operations. We could only block for
>>>>>>> deleted regions to become free.
>>>>>>>
>>>>>>> But independent of that incoming memory requests while we make 
>>>>>>> room for
>>>>>>> eviction are intended to be served first.
>>>>>>>
>>>>>>> Changing that is certainly a no-go cause that would favor memory 
>>>>>>> hungry
>>>>>>> applications over small clients.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>> >
>>>>>>> > Change-Id: I3daa892e50f82226c552cc008a29e55894a98f18
>>>>>>> > Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
>>>>>>> > ---
>>>>>>> >   drivers/gpu/drm/ttm/ttm_bo.c    | 69 
>>>>>>> +++++++++++++++++++++++++++++++++++++++--
>>>>>>> >   include/drm/ttm/ttm_bo_api.h    |  7 +++++
>>>>>>> >   include/drm/ttm/ttm_bo_driver.h |  7 +++++
>>>>>>> >   3 files changed, 80 insertions(+), 3 deletions(-)
>>>>>>> >
>>>>>>> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c 
>>>>>>> b/drivers/gpu/drm/ttm/ttm_bo.c
>>>>>>> > index d33a6bb742a1..558ec2cf465d 100644
>>>>>>> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>>>>>> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>>>>>> > @@ -841,6 +841,58 @@ static int ttm_bo_add_move_fence(struct 
>>>>>>> ttm_buffer_object *bo,
>>>>>>> >        return 0;
>>>>>>> >   }
>>>>>>> >
>>>>>>> > +static void ttm_man_init_waiter(struct ttm_bo_waiter *waiter,
>>>>>>> > +                             struct ttm_buffer_object *bo,
>>>>>>> > +                             const struct ttm_place *place)
>>>>>>> > +{
>>>>>>> > +     waiter->tbo = bo;
>>>>>>> > +     memcpy((void *)&waiter->place, (void *)place, 
>>>>>>> sizeof(*place));
>>>>>>> > + INIT_LIST_HEAD(&waiter->list);
>>>>>>> > +}
>>>>>>> > +
>>>>>>> > +static void ttm_man_add_waiter(struct ttm_mem_type_manager *man,
>>>>>>> > +                            struct ttm_bo_waiter *waiter)
>>>>>>> > +{
>>>>>>> > +     if (!waiter)
>>>>>>> > +             return;
>>>>>>> > + spin_lock(&man->wait_lock);
>>>>>>> > + list_add_tail(&waiter->list, &man->waiter_list);
>>>>>>> > + spin_unlock(&man->wait_lock);
>>>>>>> > +}
>>>>>>> > +
>>>>>>> > +static void ttm_man_del_waiter(struct ttm_mem_type_manager *man,
>>>>>>> > +                            struct ttm_bo_waiter *waiter)
>>>>>>> > +{
>>>>>>> > +     if (!waiter)
>>>>>>> > +             return;
>>>>>>> > + spin_lock(&man->wait_lock);
>>>>>>> > +     if (!list_empty(&waiter->list))
>>>>>>> > + list_del(&waiter->list);
>>>>>>> > + spin_unlock(&man->wait_lock);
>>>>>>> > +     kfree(waiter);
>>>>>>> > +}
>>>>>>> > +
>>>>>>> > +int ttm_man_check_bo(struct ttm_mem_type_manager *man,
>>>>>>> > +                  struct ttm_buffer_object *bo,
>>>>>>> > +                  const struct ttm_place *place)
>>>>>>> > +{
>>>>>>> > +     struct ttm_bo_waiter *waiter, *tmp;
>>>>>>> > +
>>>>>>> > + spin_lock(&man->wait_lock);
>>>>>>> > +     list_for_each_entry_safe(waiter, tmp, &man->waiter_list, 
>>>>>>> list) {
>>>>>>> > +             if ((bo != waiter->tbo) &&
>>>>>>> > +                 ((place->fpfn >= waiter->place.fpfn &&
>>>>>>> > +                   place->fpfn <= waiter->place.lpfn) ||
>>>>>>> > +                  (place->lpfn <= waiter->place.lpfn && 
>>>>>>> place->lpfn >=
>>>>>>> > + waiter->place.fpfn)))
>>>>>>> > +                 goto later_bo;
>>>>>>> > +     }
>>>>>>> > + spin_unlock(&man->wait_lock);
>>>>>>> > +     return true;
>>>>>>> > +later_bo:
>>>>>>> > + spin_unlock(&man->wait_lock);
>>>>>>> > +     return false;
>>>>>>> > +}
>>>>>>> >   /**
>>>>>>> >    * Repeatedly evict memory from the LRU for @mem_type until 
>>>>>>> we create enough
>>>>>>> >    * space, or we've evicted everything and there isn't enough 
>>>>>>> space.
>>>>>>> > @@ -853,17 +905,26 @@ static int ttm_bo_mem_force_space(struct 
>>>>>>> ttm_buffer_object *bo,
>>>>>>> >   {
>>>>>>> >        struct ttm_bo_device *bdev = bo->bdev;
>>>>>>> >        struct ttm_mem_type_manager *man = &bdev->man[mem_type];
>>>>>>> > +     struct ttm_bo_waiter waiter;
>>>>>>> >        int ret;
>>>>>>> >
>>>>>>> > +     ttm_man_init_waiter(&waiter, bo, place);
>>>>>>> > +     ttm_man_add_waiter(man, &waiter);
>>>>>>> >        do {
>>>>>>> >                ret = (*man->func->get_node)(man, bo, place, mem);
>>>>>>> > -             if (unlikely(ret != 0))
>>>>>>> > +             if (unlikely(ret != 0)) {
>>>>>>> > + ttm_man_del_waiter(man, &waiter);
>>>>>>> >                        return ret;
>>>>>>> > -             if (mem->mm_node)
>>>>>>> > +             }
>>>>>>> > +             if (mem->mm_node) {
>>>>>>> > + ttm_man_del_waiter(man, &waiter);
>>>>>>> >                        break;
>>>>>>> > +             }
>>>>>>> >                ret = ttm_mem_evict_first(bdev, mem_type, 
>>>>>>> place, ctx);
>>>>>>> > -             if (unlikely(ret != 0))
>>>>>>> > +             if (unlikely(ret != 0)) {
>>>>>>> > + ttm_man_del_waiter(man, &waiter);
>>>>>>> >                        return ret;
>>>>>>> > +             }
>>>>>>> >        } while (1);
>>>>>>> >        mem->mem_type = mem_type;
>>>>>>> >        return ttm_bo_add_move_fence(bo, man, mem);
>>>>>>> > @@ -1450,6 +1511,8 @@ int ttm_bo_init_mm(struct ttm_bo_device 
>>>>>>> *bdev, unsigned type,
>>>>>>> >        man->use_io_reserve_lru = false;
>>>>>>> > mutex_init(&man->io_reserve_mutex);
>>>>>>> > spin_lock_init(&man->move_lock);
>>>>>>> > + spin_lock_init(&man->wait_lock);
>>>>>>> > + INIT_LIST_HEAD(&man->waiter_list);
>>>>>>> > INIT_LIST_HEAD(&man->io_reserve_lru);
>>>>>>> >
>>>>>>> >        ret = bdev->driver->init_mem_type(bdev, type, man);
>>>>>>> > diff --git a/include/drm/ttm/ttm_bo_api.h 
>>>>>>> b/include/drm/ttm/ttm_bo_api.h
>>>>>>> > index 2cd025c2abe7..0fce4dbd02e7 100644
>>>>>>> > --- a/include/drm/ttm/ttm_bo_api.h
>>>>>>> > +++ b/include/drm/ttm/ttm_bo_api.h
>>>>>>> > @@ -40,6 +40,7 @@
>>>>>>> >   #include <linux/mm.h>
>>>>>>> >   #include <linux/bitmap.h>
>>>>>>> >   #include <linux/reservation.h>
>>>>>>> > +#include <drm/ttm/ttm_placement.h>
>>>>>>> >
>>>>>>> >   struct ttm_bo_device;
>>>>>>> >
>>>>>>> > @@ -232,6 +233,12 @@ struct ttm_buffer_object {
>>>>>>> >        struct mutex wu_mutex;
>>>>>>> >   };
>>>>>>> >
>>>>>>> > +struct ttm_bo_waiter {
>>>>>>> > +     struct ttm_buffer_object *tbo;
>>>>>>> > +     struct ttm_place place;
>>>>>>> > +     struct list_head list;
>>>>>>> > +};
>>>>>>> > +
>>>>>>> >   /**
>>>>>>> >    * struct ttm_bo_kmap_obj
>>>>>>> >    *
>>>>>>> > diff --git a/include/drm/ttm/ttm_bo_driver.h 
>>>>>>> b/include/drm/ttm/ttm_bo_driver.h
>>>>>>> > index 9b417eb2df20..dc6b8b4c9e06 100644
>>>>>>> > --- a/include/drm/ttm/ttm_bo_driver.h
>>>>>>> > +++ b/include/drm/ttm/ttm_bo_driver.h
>>>>>>> > @@ -293,6 +293,10 @@ struct ttm_mem_type_manager {
>>>>>>> >        bool io_reserve_fastpath;
>>>>>>> >        spinlock_t move_lock;
>>>>>>> >
>>>>>>> > +     /* waiters in list */
>>>>>>> > +     spinlock_t wait_lock;
>>>>>>> > +     struct list_head waiter_list;
>>>>>>> > +
>>>>>>> >        /*
>>>>>>> >         * Protected by @io_reserve_mutex:
>>>>>>> >         */
>>>>>>> > @@ -748,6 +752,9 @@ int ttm_bo_mem_space(struct 
>>>>>>> ttm_buffer_object *bo,
>>>>>>> >                     struct ttm_mem_reg *mem,
>>>>>>> >                     struct ttm_operation_ctx *ctx);
>>>>>>> >
>>>>>>> > +int ttm_man_check_bo(struct ttm_mem_type_manager *man,
>>>>>>> > +                  struct ttm_buffer_object *bo,
>>>>>>> > +                  const struct ttm_place *place);
>>>>>>> >   void ttm_bo_mem_put(struct ttm_buffer_object *bo, struct 
>>>>>>> ttm_mem_reg *mem);
>>>>>>> >   void ttm_bo_mem_put_locked(struct ttm_buffer_object *bo,
>>>>>>> >                           struct ttm_mem_reg *mem);
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> amd-gfx mailing list
>>>>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>>>>
>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>
>>>
>>>
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>


--------------08D0791B8C85E311360F9030
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">So I think preventing validation on same
        place is a simpler way:<br>
        process B bo's place is fpfn~lpfn, it will only try to evict LRU
        BOs in that range, while eviction, we just prevent those
        validation to this range(fpfn~lpfn), if out of this range, the
        allocation/validation still can be go on.<br>
        <br>
        Any negative?<br>
      </blockquote>
      That won't work either. The most common use of fpfn~lpfn range is
      to limit a BO to visible VRAM, the other use cases are to fullfil
      hardware limitations.<br>
      <br>
      So blocking this would result in blocking all normal GTT and VRAM
      allocations, adding a mutex to validate would have the same
      effect.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 31.01.2018 um 11:30 schrieb Chunming Zhou:<br>
    </div>
    <blockquote type="cite"
      cite="mid:cdb7726b-a82d-494c-a98c-ca0100f323cc-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <p><br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 2018年01月26日 22:35, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:a6d78bba-bbe9-769b-f9d3-665cdd8c04da-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <div class="moz-cite-prefix">I just realized that a change I'm
          thinking about for a while would solve your problem as well,
          but keep concurrent allocation possible.<br>
          <br>
          See ttm_mem_evict_first() unlocks the BO after evicting it:<br>
          <blockquote type="cite">        ttm_bo_del_from_lru(bo);<br>
                    spin_unlock(&amp;glob-&gt;lru_lock);<br>
            <br>
                    ret = ttm_bo_evict(bo, ctx);<br>
                    if (locked) {<br>
                            ttm_bo_unreserve(bo); &lt;-------- here<br>
                    } else {<br>
                            spin_lock(&amp;glob-&gt;lru_lock);<br>
                            ttm_bo_add_to_lru(bo);<br>
                            spin_unlock(&amp;glob-&gt;lru_lock);<br>
                    }<br>
            <br>
                    kref_put(&amp;bo-&gt;list_kref,
            ttm_bo_release_list);<br>
          </blockquote>
          <br>
          The effect is that in your example process C can not only beat
          process B once, but many many times because we run into a
          ping/pong situation where B evicts resources while C moves
          them back in.<br>
        </div>
      </blockquote>
      For ping/pong case, I want to disable busy placement for
      allocation period, only enable it for cs bo validation.<br>
      <br>
      <blockquote type="cite"
        cite="mid:a6d78bba-bbe9-769b-f9d3-665cdd8c04da-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <div class="moz-cite-prefix"> <br>
          For a while now I'm thinking about dropping those reservations
          only after the original allocation succeeded.<br>
          <br>
          The effect would be that process C can still beat process B
          initially, but sooner or process B would evict some resources
          from process C as well and then it can succeed with its
          allocation.<br>
        </div>
      </blockquote>
      If it is from process C cs validation, process B still need evict
      the resource only after process C command submission completion.<br>
      <br>
      <blockquote type="cite"
        cite="mid:a6d78bba-bbe9-769b-f9d3-665cdd8c04da-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <div class="moz-cite-prefix"> <br>
          The problem is for this approach to work we need to core
          change to the ww_mutexes to be able to handle this
          efficiently.<br>
        </div>
      </blockquote>
      Yes, ww_mutex doesn't support this net lock, which easily deadlock
      without ticket and class.<br>
      <br>
      So I think preventing validation on same place is a simpler way:<br>
      process B bo's place is fpfn~lpfn, it will only try to evict LRU
      BOs in that range, while eviction, we just prevent those
      validation to this range(fpfn~lpfn), if out of this range, the
      allocation/validation still can be go on.<br>
      <br>
      Any negative?<br>
      <br>
      Regards,<br>
      David Zhou<br>
      <blockquote type="cite"
        cite="mid:a6d78bba-bbe9-769b-f9d3-665cdd8c04da-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <div class="moz-cite-prefix"> <br>
          Regards,<br>
          Christian.<br>
          <br>
          Am 26.01.2018 um 14:59 schrieb Christian König:<br>
        </div>
        <blockquote type="cite"
          cite="mid:e3ed22b7-ca1a-09d0-47a0-204affef780f-5C7GfCeVMHo@public.gmane.org">
          <div class="moz-cite-prefix">I know, but this has the same
            effect. You prevent concurrent allocation from happening.<br>
            <br>
            What we could do is to pipeline reusing of deleted memory as
            well, this makes it less likely to cause the problem you are
            seeing because the evicting processes doesn't need to block
            for deleted BOs any more.<br>
            <br>
            But that other processes can grab memory during eviction is
            intentional. Otherwise greedy processes would completely
            dominate command submission.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            Am 26.01.2018 um 14:50 schrieb Zhou, David(ChunMing):<br>
          </div>
          <blockquote type="cite" cite="mid:smartisan1516974623698">
            <meta content="text/html; charset=utf-8">
            <div name="smartisanmessageid" id="smartisan1516974623698"><font
                color="#333333">I don't want to prevent all, my new
                approach is to prevent the later allocation is trying
                and ahead of front to get the memory space that the
                front made from eviction. <br>
              </font><br>
              <br>
              <span id="smartisan_signature" style="font-size:0.8em;
                display:inline; color:#888888">
                <p dir="ltr">发自坚果 Pro</p>
              </span>
              <style type="text/css">
<!--
* body
	{padding:0 16px 30px!important;
	margin:0!important;
	background-color:#ffffff;
	line-height:1.4;
	word-wrap:break-word;
	word-break:normal}
div
	{word-wrap:break-word;
	word-break:normal}
p
	{word-wrap:break-word;
	word-break:normal;
	text-indent:0pt!important}
span
	{word-wrap:break-word;
	word-break:normal}
a
	{word-wrap:break-word;
	word-break:normal}
td
	{word-wrap:break-word;
	word-break:break-all}
-->
</style>
              <div class="quote">
                <div style="margin:0 0px; font-size:105%"><font
                    style="line-height:1.4" color="#629140"><span>Christian
                      K鰊ig <a class="moz-txt-link-rfc2396E"
                        href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                        moz-do-not-send="true">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
                      于 2018年1月26日 下午9:24写道：</span></font></div>
                <br type="attribution">
              </div>
            </div>
            <div>
              <div class="moz-cite-prefix">Yes, exactly that's the
                problem.<br>
                <br>
                See when you want to prevent a process B from allocating
                the memory process A has evicted, you need to prevent
                all concurrent allocation.<br>
                <br>
                And we don't do that because it causes a major
                performance drop.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                Am 26.01.2018 um 14:21 schrieb Zhou, David(ChunMing):<br>
              </div>
              <blockquote type="cite">
                <meta content="text/html; charset=utf-8">
                <div name="smartisanmessageid"
                  id="smartisan1516972869817"><font color="#333333">You
                    patch will prevent concurrent allocation, and will
                    result in allocation performance drop much.</font><br>
                  <br>
                  <span id="smartisan_signature" style="font-size:0.8em;
                    display:inline; color:#888888">
                    <p dir="ltr">发自坚果 Pro</p>
                  </span>
                  <style type="text/css">
<!--
* body
	{padding:0 16px 30px!important;
	margin:0!important;
	background-color:#ffffff;
	line-height:1.4;
	word-wrap:break-word;
	word-break:normal}
div
	{word-wrap:break-word;
	word-break:normal}
p
	{word-wrap:break-word;
	word-break:normal;
	text-indent:0pt!important}
span
	{word-wrap:break-word;
	word-break:normal}
a
	{word-wrap:break-word;
	word-break:normal}
td
	{word-wrap:break-word;
	word-break:break-all}
-->
</style>
                  <div class="quote">
                    <div style="margin:0 0px; font-size:105%"><font
                        style="line-height:1.4" color="#629140"><span>Christian
                          K鰊ig <a class="moz-txt-link-rfc2396E"
                            href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                            moz-do-not-send="true">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
                          于 2018年1月26日 下午9:04写道：</span></font></div>
                    <br type="attribution">
                  </div>
                </div>
                <div>
                  <div class="moz-cite-prefix">Attached is what you
                    actually want to do cleanly implemented. But as I
                    said this is a NO-GO.<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                    <br>
                    Am 26.01.2018 um 13:43 schrieb Christian König:<br>
                  </div>
                  <blockquote type="cite">
                    <div class="moz-cite-prefix">
                      <blockquote type="cite">After my investigation,
                        this issue should be detect of TTM design self,
                        which breaks scheduling balance.<br>
                      </blockquote>
                      Yeah, but again. This is indented design we can't
                      change easily.<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      Am 26.01.2018 um 13:36 schrieb Zhou,
                      David(ChunMing):<br>
                    </div>
                    <blockquote type="cite">
                      <meta name="Generator" content="Microsoft Exchange
                        Server">
                      <style>
<!--
.EmailQuote
	{margin-left:1pt;
	padding-left:4pt;
	border-left:#800000 2px solid}
-->
</style>
                      <div>
                        <div name="x_smartisanmessageid"
                          id="x_smartisan1516970199102"><font
                            color="#333333">I am off work, so reply mail
                            by phone, the format could not be text.<br>
                          </font><br>
                          back to topic itself:<br>
                          the problem indeed happen on amdgpu driver,
                          someone reports me that application runs with
                          two instances, the performance are different.<br>
                          I also reproduced the issue with unit
                          test(bo_eviction_test). They always think our
                          scheduler isn't working as expected.<br>
                          <br>
                          After my investigation, this issue should be
                          detect of TTM design self, which breaks
                          scheduling balance.<br>
                          <br>
                          Further, if we run containers for our gpu,
                          container A could run high score, container B
                          runs low score with same benchmark.<br>
                          <br>
                          So this is bug that we need fix.<br>
                          <br>
                          Regards,<br>
                          David Zhou<br>
                          <br>
                          <span id="x_smartisan_signature"
                            style="font-size:0.8em; display:inline;
                            color:#888888">
                            <p dir="ltr">发自坚果 Pro</p>
                          </span>
                          <style type="text/css">
<!--
* body
	{padding:0 16px 30px!important;
	margin:0!important;
	background-color:#ffffff;
	line-height:1.4;
	word-wrap:break-word;
	word-break:normal}
div
	{word-wrap:break-word;
	word-break:normal}
p
	{word-wrap:break-word;
	word-break:normal;
	text-indent:0pt!important}
span
	{word-wrap:break-word;
	word-break:normal}
a
	{word-wrap:break-word;
	word-break:normal}
td
	{word-wrap:break-word;
	word-break:break-all}
-->
</style>
                          <div class="x_quote">
                            <div style="margin:0 0px; font-size:105%"><font
                                style="line-height:1.4" color="#629140"><span>Christian
                                  K鰊ig <a class="moz-txt-link-rfc2396E"
href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" moz-do-not-send="true">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
                                  于 2018年1月26日 下午6:31写道：</span></font></div>
                            <br type="attribution">
                          </div>
                        </div>
                      </div>
                      <font size="2"><span style="font-size:11pt">
                          <div class="PlainText">Am 26.01.2018 um 11:22
                            schrieb Chunming Zhou:<br>
                            &gt; there is a scheduling balance issue
                            about get node like:<br>
                            &gt; a. process A allocates full memory and
                            use it for submission.<br>
                            &gt; b. process B tries to allocates memory,
                            will wait for process A BO idle in eviction.<br>
                            &gt; c. process A completes the job, process
                            B eviction will put process A BO node,<br>
                            &gt; but in the meantime, process C is
                            comming to allocate BO, whill directly get
                            node successfully, and do submission,<br>
                            &gt; process B will again wait for process C
                            BO idle.<br>
                            &gt; d. repeat the above setps, process B
                            could be delayed much more.<br>
                            &gt;<br>
                            &gt; later allocation must not be ahead of
                            front in same place.<br>
                            <br>
                            Again NAK to the whole approach.<br>
                            <br>
                            At least with amdgpu the problem you
                            described above never occurs <br>
                            because evictions are pipelined operations.
                            We could only block for <br>
                            deleted regions to become free.<br>
                            <br>
                            But independent of that incoming memory
                            requests while we make room for <br>
                            eviction are intended to be served first.<br>
                            <br>
                            Changing that is certainly a no-go cause
                            that would favor memory hungry <br>
                            applications over small clients.<br>
                            <br>
                            Regards,<br>
                            Christian.<br>
                            <br>
                            &gt;<br>
                            &gt; Change-Id:
                            I3daa892e50f82226c552cc008a29e55894a98f18<br>
                            &gt; Signed-off-by: Chunming Zhou <a
                              class="moz-txt-link-rfc2396E"
                              href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org"
                              moz-do-not-send="true">
                              &lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                            &gt; ---<br>
                            &gt;   drivers/gpu/drm/ttm/ttm_bo.c    | 69
                            +++++++++++++++++++++++++++++++++++++++--<br>
                            &gt;   include/drm/ttm/ttm_bo_api.h    |  7
                            +++++<br>
                            &gt;   include/drm/ttm/ttm_bo_driver.h |  7
                            +++++<br>
                            &gt;   3 files changed, 80 insertions(+), 3
                            deletions(-)<br>
                            &gt;<br>
                            &gt; diff --git
                            a/drivers/gpu/drm/ttm/ttm_bo.c
                            b/drivers/gpu/drm/ttm/ttm_bo.c<br>
                            &gt; index d33a6bb742a1..558ec2cf465d 100644<br>
                            &gt; --- a/drivers/gpu/drm/ttm/ttm_bo.c<br>
                            &gt; +++ b/drivers/gpu/drm/ttm/ttm_bo.c<br>
                            &gt; @@ -841,6 +841,58 @@ static int
                            ttm_bo_add_move_fence(struct
                            ttm_buffer_object *bo,<br>
                            &gt;        return 0;<br>
                            &gt;   }<br>
                            &gt;   <br>
                            &gt; +static void ttm_man_init_waiter(struct
                            ttm_bo_waiter *waiter,<br>
                            &gt; +                             struct
                            ttm_buffer_object *bo,<br>
                            &gt; +                             const
                            struct ttm_place *place)<br>
                            &gt; +{<br>
                            &gt; +     waiter-&gt;tbo = bo;<br>
                            &gt; +     memcpy((void
                            *)&amp;waiter-&gt;place, (void *)place,
                            sizeof(*place));<br>
                            &gt; +    
                            INIT_LIST_HEAD(&amp;waiter-&gt;list);<br>
                            &gt; +}<br>
                            &gt; +<br>
                            &gt; +static void ttm_man_add_waiter(struct
                            ttm_mem_type_manager *man,<br>
                            &gt; +                            struct
                            ttm_bo_waiter *waiter)<br>
                            &gt; +{<br>
                            &gt; +     if (!waiter)<br>
                            &gt; +             return;<br>
                            &gt; +    
                            spin_lock(&amp;man-&gt;wait_lock);<br>
                            &gt; +    
                            list_add_tail(&amp;waiter-&gt;list,
                            &amp;man-&gt;waiter_list);<br>
                            &gt; +    
                            spin_unlock(&amp;man-&gt;wait_lock);<br>
                            &gt; +}<br>
                            &gt; +<br>
                            &gt; +static void ttm_man_del_waiter(struct
                            ttm_mem_type_manager *man,<br>
                            &gt; +                            struct
                            ttm_bo_waiter *waiter)<br>
                            &gt; +{<br>
                            &gt; +     if (!waiter)<br>
                            &gt; +             return;<br>
                            &gt; +    
                            spin_lock(&amp;man-&gt;wait_lock);<br>
                            &gt; +     if
                            (!list_empty(&amp;waiter-&gt;list))<br>
                            &gt; +            
                            list_del(&amp;waiter-&gt;list);<br>
                            &gt; +    
                            spin_unlock(&amp;man-&gt;wait_lock);<br>
                            &gt; +     kfree(waiter);<br>
                            &gt; +}<br>
                            &gt; +<br>
                            &gt; +int ttm_man_check_bo(struct
                            ttm_mem_type_manager *man,<br>
                            &gt; +                  struct
                            ttm_buffer_object *bo,<br>
                            &gt; +                  const struct
                            ttm_place *place)<br>
                            &gt; +{<br>
                            &gt; +     struct ttm_bo_waiter *waiter,
                            *tmp;<br>
                            &gt; +<br>
                            &gt; +    
                            spin_lock(&amp;man-&gt;wait_lock);<br>
                            &gt; +     list_for_each_entry_safe(waiter,
                            tmp, &amp;man-&gt;waiter_list, list) {<br>
                            &gt; +             if ((bo !=
                            waiter-&gt;tbo) &amp;&amp;<br>
                            &gt; +                 ((place-&gt;fpfn
                            &gt;= waiter-&gt;place.fpfn &amp;&amp;<br>
                            &gt; +                   place-&gt;fpfn
                            &lt;= waiter-&gt;place.lpfn) ||<br>
                            &gt; +                  (place-&gt;lpfn
                            &lt;= waiter-&gt;place.lpfn &amp;&amp;
                            place-&gt;lpfn &gt;=<br>
                            &gt; +                  
                            waiter-&gt;place.fpfn)))<br>
                            &gt; +                 goto later_bo;<br>
                            &gt; +     }<br>
                            &gt; +    
                            spin_unlock(&amp;man-&gt;wait_lock);<br>
                            &gt; +     return true;<br>
                            &gt; +later_bo:<br>
                            &gt; +    
                            spin_unlock(&amp;man-&gt;wait_lock);<br>
                            &gt; +     return false;<br>
                            &gt; +}<br>
                            &gt;   /**<br>
                            &gt;    * Repeatedly evict memory from the
                            LRU for @mem_type until we create enough<br>
                            &gt;    * space, or we've evicted everything
                            and there isn't enough space.<br>
                            &gt; @@ -853,17 +905,26 @@ static int
                            ttm_bo_mem_force_space(struct
                            ttm_buffer_object *bo,<br>
                            &gt;   {<br>
                            &gt;        struct ttm_bo_device *bdev =
                            bo-&gt;bdev;<br>
                            &gt;        struct ttm_mem_type_manager *man
                            = &amp;bdev-&gt;man[mem_type];<br>
                            &gt; +     struct ttm_bo_waiter waiter;<br>
                            &gt;        int ret;<br>
                            &gt;   <br>
                            &gt; +     ttm_man_init_waiter(&amp;waiter,
                            bo, place);<br>
                            &gt; +     ttm_man_add_waiter(man,
                            &amp;waiter);<br>
                            &gt;        do {<br>
                            &gt;                ret =
                            (*man-&gt;func-&gt;get_node)(man, bo, place,
                            mem);<br>
                            &gt; -             if (unlikely(ret != 0))<br>
                            &gt; +             if (unlikely(ret != 0)) {<br>
                            &gt; +                    
                            ttm_man_del_waiter(man, &amp;waiter);<br>
                            &gt;                        return ret;<br>
                            &gt; -             if (mem-&gt;mm_node)<br>
                            &gt; +             }<br>
                            &gt; +             if (mem-&gt;mm_node) {<br>
                            &gt; +                    
                            ttm_man_del_waiter(man, &amp;waiter);<br>
                            &gt;                        break;<br>
                            &gt; +             }<br>
                            &gt;                ret =
                            ttm_mem_evict_first(bdev, mem_type, place,
                            ctx);<br>
                            &gt; -             if (unlikely(ret != 0))<br>
                            &gt; +             if (unlikely(ret != 0)) {<br>
                            &gt; +                    
                            ttm_man_del_waiter(man, &amp;waiter);<br>
                            &gt;                        return ret;<br>
                            &gt; +             }<br>
                            &gt;        } while (1);<br>
                            &gt;        mem-&gt;mem_type = mem_type;<br>
                            &gt;        return ttm_bo_add_move_fence(bo,
                            man, mem);<br>
                            &gt; @@ -1450,6 +1511,8 @@ int
                            ttm_bo_init_mm(struct ttm_bo_device *bdev,
                            unsigned type,<br>
                            &gt;        man-&gt;use_io_reserve_lru =
                            false;<br>
                            &gt;       
                            mutex_init(&amp;man-&gt;io_reserve_mutex);<br>
                            &gt;       
                            spin_lock_init(&amp;man-&gt;move_lock);<br>
                            &gt; +    
                            spin_lock_init(&amp;man-&gt;wait_lock);<br>
                            &gt; +    
                            INIT_LIST_HEAD(&amp;man-&gt;waiter_list);<br>
                            &gt;       
                            INIT_LIST_HEAD(&amp;man-&gt;io_reserve_lru);<br>
                            &gt;   <br>
                            &gt;        ret =
                            bdev-&gt;driver-&gt;init_mem_type(bdev,
                            type, man);<br>
                            &gt; diff --git
                            a/include/drm/ttm/ttm_bo_api.h
                            b/include/drm/ttm/ttm_bo_api.h<br>
                            &gt; index 2cd025c2abe7..0fce4dbd02e7 100644<br>
                            &gt; --- a/include/drm/ttm/ttm_bo_api.h<br>
                            &gt; +++ b/include/drm/ttm/ttm_bo_api.h<br>
                            &gt; @@ -40,6 +40,7 @@<br>
                            &gt;   #include &lt;linux/mm.h&gt;<br>
                            &gt;   #include &lt;linux/bitmap.h&gt;<br>
                            &gt;   #include &lt;linux/reservation.h&gt;<br>
                            &gt; +#include
                            &lt;drm/ttm/ttm_placement.h&gt;<br>
                            &gt;   <br>
                            &gt;   struct ttm_bo_device;<br>
                            &gt;   <br>
                            &gt; @@ -232,6 +233,12 @@ struct
                            ttm_buffer_object {<br>
                            &gt;        struct mutex wu_mutex;<br>
                            &gt;   };<br>
                            &gt;   <br>
                            &gt; +struct ttm_bo_waiter {<br>
                            &gt; +     struct ttm_buffer_object *tbo;<br>
                            &gt; +     struct ttm_place place;<br>
                            &gt; +     struct list_head list;<br>
                            &gt; +};<br>
                            &gt; +<br>
                            &gt;   /**<br>
                            &gt;    * struct ttm_bo_kmap_obj<br>
                            &gt;    *<br>
                            &gt; diff --git
                            a/include/drm/ttm/ttm_bo_driver.h
                            b/include/drm/ttm/ttm_bo_driver.h<br>
                            &gt; index 9b417eb2df20..dc6b8b4c9e06 100644<br>
                            &gt; --- a/include/drm/ttm/ttm_bo_driver.h<br>
                            &gt; +++ b/include/drm/ttm/ttm_bo_driver.h<br>
                            &gt; @@ -293,6 +293,10 @@ struct
                            ttm_mem_type_manager {<br>
                            &gt;        bool io_reserve_fastpath;<br>
                            &gt;        spinlock_t move_lock;<br>
                            &gt;   <br>
                            &gt; +     /* waiters in list */<br>
                            &gt; +     spinlock_t wait_lock;<br>
                            &gt; +     struct list_head waiter_list;<br>
                            &gt; +<br>
                            &gt;        /*<br>
                            &gt;         * Protected by
                            @io_reserve_mutex:<br>
                            &gt;         */<br>
                            &gt; @@ -748,6 +752,9 @@ int
                            ttm_bo_mem_space(struct ttm_buffer_object
                            *bo,<br>
                            &gt;                     struct ttm_mem_reg
                            *mem,<br>
                            &gt;                     struct
                            ttm_operation_ctx *ctx);<br>
                            &gt;   <br>
                            &gt; +int ttm_man_check_bo(struct
                            ttm_mem_type_manager *man,<br>
                            &gt; +                  struct
                            ttm_buffer_object *bo,<br>
                            &gt; +                  const struct
                            ttm_place *place);<br>
                            &gt;   void ttm_bo_mem_put(struct
                            ttm_buffer_object *bo, struct ttm_mem_reg
                            *mem);<br>
                            &gt;   void ttm_bo_mem_put_locked(struct
                            ttm_buffer_object *bo,<br>
                            &gt;                           struct
                            ttm_mem_reg *mem);<br>
                            <br>
                          </div>
                        </span></font><br>
                      <fieldset class="mimeAttachmentHeader"></fieldset>
                      <br>
                      <pre>_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                    </blockquote>
                    <br>
                  </blockquote>
                  <br>
                </div>
                <br>
                <fieldset class="mimeAttachmentHeader"></fieldset>
                <br>
                <pre>_______________________________________________
dri-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/dri-devel" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a>
</pre>
              </blockquote>
              <br>
            </div>
          </blockquote>
          <br>
          <br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
          <br>
          <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------08D0791B8C85E311360F9030--

--===============1214789432==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1214789432==--
