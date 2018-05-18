From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add rcu_barrier after entity fini
Date: Fri, 18 May 2018 12:35:47 +0200
Message-ID: <bc3fbefd-957a-9b89-8096-22b44f6dc3d2@amd.com>
References: <1526551432-12599-1-git-send-email-Emily.Deng@amd.com>
 <ec5de5ac-f9b8-53e5-0db4-3e0791469b40@gmail.com>
 <CY4PR12MB112526B02190A3D892CCB84F8F900@CY4PR12MB1125.namprd12.prod.outlook.com>
 <BN6PR12MB11210121E65A155D901B94AE8F900@BN6PR12MB1121.namprd12.prod.outlook.com>
 <3f9070bd-ebce-77d4-5979-6ce383885064@amd.com>
 <BN6PR12MB1121DDBFDB283E01AC198B038F900@BN6PR12MB1121.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0074021186=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1121DDBFDB283E01AC198B038F900-/b2+HYfkarSgw6z4+5+8kgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0074021186==
Content-Type: multipart/alternative;
 boundary="------------23816A0F7E451F50FCE99EE1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------23816A0F7E451F50FCE99EE1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Ah! So we have one RCU grace period caused by the scheduler fence and 
another one from the hardware fence.

Thanks for explaining that once more, that was really not obvious from 
reading the code.

But this means we could we also fix it by moving the 
"dma_fence_put(fence->parent);" from drm_sched_fence_free() into 
drm_sched_fence_release_scheduled() directly before the call_rcu(), 
can't we?

I think that would be cleaner, cause otherwise every driver using the 
GPU scheduler would need that workaround.

And drm_sched_fence_release_scheduled() is only called when the 
reference count becomes zero, so when anybody accesses the structure 
after that then that would be a bug as well.

Thanks,
Christian.

Am 18.05.2018 um 11:56 schrieb Deng, Emily:
> Hi Christian,
>         When we free an IB fence, we first call one call_rcu in 
> drm_sched_fence_release_scheduled as the call trace one, then after 
> the call trace one,
> we call the call_rcu second in the  amdgpu_fence_release in call trace 
> two, as below.
> The kmem_cache_free(amdgpu_fence_slab, fence)'s call trace as below:
>     1.drm_sched_entity_fini ->
>     drm_sched_entity_cleanup ->
>     dma_fence_put(entity->last_scheduled) ->
>     drm_sched_fence_release_finished ->
>     drm_sched_fence_release_scheduled ->
>     call_rcu(&fence->finished.rcu, drm_sched_fence_free)
>     2.drm_sched_fence_free ->
>     dma_fence_put(fence->parent) ->
>     amdgpu_fence_release ->
>     call_rcu(&f->rcu, amdgpu_fence_free) ->
>     kmem_cache_free(amdgpu_fence_slab, fence);
> > -----Original Message-----
> > From: Koenig, Christian
> > Sent: Friday, May 18, 2018 5:46 PM
> > To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Subject: Re: [PATCH] drm/amdgpu: add rcu_barrier after entity fini
> > 
> > Ok, I'm lost where do we use call_rcu() twice? Cause that sounds incorrect in
> > the first place.
> > 
> > Christian.
> > 
> > Am 18.05.2018 um 11:41 schrieb Deng, Emily:
> > > Ping......
> > >
> > > Best Wishes,
> > > Emily Deng
> > >
> > >
> > >
> > >
> > >> -----Original Message-----
> > >> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On
> > >> Behalf Of Deng, Emily
> > >> Sent: Friday, May 18, 2018 11:20 AM
> > >> To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org <mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>>; amd-
> > >> gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> > >> Subject: RE: [PATCH] drm/amdgpu: add rcu_barrier after entity fini
> > >>
> > >> Hi Christian,
> > >>       Yes, it has already one rcu_barrier, but it has called twice
> > >> call_rcu, so the one rcu_barrier just could barrier one call_rcu some time.
> > >>      After I added another rcu_barrier, the kernel issue will disappear.
> > >>
> > >> Best Wishes,
> > >> Emily Deng
> > >>
> > >>> -----Original Message-----
> > >>> From: Christian König [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> > >>> Sent: Thursday, May 17, 2018 7:08 PM
> > >>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org <mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org>>; amd- 
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> > gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > >>> Subject: Re: [PATCH] drm/amdgpu: add rcu_barrier after entity fini
> > >>>
> > >>> Am 17.05.2018 um 12:03 schrieb Emily Deng:
> > >>>> To free the fence from the amdgpu_fence_slab, need twice call_rcu,
> > >>>> to avoid the amdgpu_fence_slab_fini call
> > >>>> kmem_cache_destroy(amdgpu_fence_slab) before
> > >>> kmem_cache_free(amdgpu_fence_slab, fence), add rcu_barrier after
> > >>> drm_sched_entity_fini.
> > >>>> The kmem_cache_free(amdgpu_fence_slab, fence)'s call trace as
> > below:
> > >>>> 1.drm_sched_entity_fini ->
> > >>>> drm_sched_entity_cleanup ->
> > >>>> dma_fence_put(entity->last_scheduled) ->
> > >>>> drm_sched_fence_release_finished ->
> > >>> drm_sched_fence_release_scheduled
> > >>>> -> call_rcu(&fence->finished.rcu, drm_sched_fence_free)
> > >>>>
> > >>>> 2.drm_sched_fence_free ->
> > >>>> dma_fence_put(fence->parent) ->
> > >>>> amdgpu_fence_release ->
> > >>>> call_rcu(&f->rcu, amdgpu_fence_free) ->
> > >>>> kmem_cache_free(amdgpu_fence_slab, fence);
> > >>>>
> > >>>> v2:put the barrier before the kmem_cache_destroy
> > >>>>
> > >>>> Change-Id: I8dcadd3372f97e72461bf46b41cc26d90f09b8df
> > >>>> Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org <mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org>>
> > >>>> ---
> > >>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
> > >>>>    1 file changed, 1 insertion(+)
> > >>>>
> > >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > >>>> index 39ec6b8..42be65b 100644
> > >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > >>>> @@ -69,6 +69,7 @@ int amdgpu_fence_slab_init(void)
> > >>>>    void amdgpu_fence_slab_fini(void)
> > >>>>    {
> > >>>>           rcu_barrier();
> > >>>> +        rcu_barrier();
> > >>> Well, you should have noted that there is already an rcu_barrier
> > >>> here and adding another one shouldn't have any additional effect. So
> > >>> your explanation and the proposed solution doesn't make to much
> > sense.
> > >>>
> > >>> I think the problem you run into is rather that the fence is
> > >>> reference counted and might live longer than the module who created it.
> > >>>
> > >>> Complicated issue, one possible solution would be to release
> > >>> fence->parent earlier in the scheduler fence but that doesn't sound
> > >>> fence->like
> > >>> a general purpose solution.
> > >>>
> > >>> Christian.
> > >>>
> > >>>>          kmem_cache_destroy(amdgpu_fence_slab);
> > >>>>    }
> > >>>>    /*
> > >> _______________________________________________
> > >> amd-gfx mailing list
> > >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> > >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------23816A0F7E451F50FCE99EE1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Ah! So we have one RCU grace period
      caused by the scheduler fence and another one from the hardware
      fence.<br>
      <br>
      Thanks for explaining that once more, that was really not obvious
      from reading the code.<br>
      <br>
      But this means we could we also fix it by moving the
      "dma_fence_put(fence-&gt;parent);" from drm_sched_fence_free()
      into drm_sched_fence_release_scheduled() directly before the
      call_rcu(), can't we?<br>
      <br>
      I think that would be cleaner, cause otherwise every driver using
      the GPU scheduler would need that workaround.<br>
      <br>
      And drm_sched_fence_release_scheduled() is only called when the
      reference count becomes zero, so when anybody accesses the
      structure after that then that would be a bug as well.<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 18.05.2018 um 11:56 schrieb Deng, Emily:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1121DDBFDB283E01AC198B038F900-/b2+HYfkarSgw6z4+5+8kgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from rtf -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font face="Calibri" size="2"><span style="font-size:11pt;">
          <div>Hi Christian,</div>
          <div>        When we free an IB fence, we first call one
            call_rcu in drm_sched_fence_release_scheduled as the call
            trace one, then after the call trace one,</div>
          <div> we call the call_rcu second in the  amdgpu_fence_release
            in call trace two, as below.</div>
          <div><font face="Times New Roman"> </font></div>
          <div> The kmem_cache_free(amdgpu_fence_slab, fence)'s call
            trace as below:</div>
          <div>    1.drm_sched_entity_fini -&gt;</div>
          <div>    drm_sched_entity_cleanup -&gt;</div>
          <div>    dma_fence_put(entity-&gt;last_scheduled) -&gt;</div>
          <div>    drm_sched_fence_release_finished -&gt;</div>
          <div>    drm_sched_fence_release_scheduled -&gt;</div>
          <div>    call_rcu(&amp;fence-&gt;finished.rcu, <font
              color="red">drm_sched_fence_free</font>)</div>
          <div> </div>
          <div>    2.<font color="red">drm_sched_fence_free</font> -&gt;</div>
          <div>    dma_fence_put(fence-&gt;parent) -&gt;</div>
          <div>    amdgpu_fence_release -&gt;</div>
          <div>    call_rcu(&amp;f-&gt;rcu, amdgpu_fence_free) -&gt;</div>
          <div>    kmem_cache_free(amdgpu_fence_slab, fence);</div>
          <div><font face="Times New Roman"> </font></div>
          <div>&gt; -----Original Message-----</div>
          <div>&gt; From: Koenig, Christian</div>
          <div>&gt; Sent: Friday, May 18, 2018 5:46 PM</div>
          <div>&gt; To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></div>
          <div>&gt; Subject: Re: [PATCH] drm/amdgpu: add rcu_barrier
            after entity fini</div>
          <div>&gt; </div>
          <div>&gt; Ok, I'm lost where do we use call_rcu() twice? Cause
            that sounds incorrect in</div>
          <div>&gt; the first place.</div>
          <div>&gt; </div>
          <div>&gt; Christian.</div>
          <div>&gt; </div>
          <div>&gt; Am 18.05.2018 um 11:41 schrieb Deng, Emily:</div>
          <div>&gt; &gt; Ping......</div>
          <div>&gt; &gt;</div>
          <div>&gt; &gt; Best Wishes,</div>
          <div>&gt; &gt; Emily Deng</div>
          <div>&gt; &gt;</div>
          <div>&gt; &gt;</div>
          <div>&gt; &gt;</div>
          <div>&gt; &gt;</div>
          <div>&gt; &gt;&gt; -----Original Message-----</div>
          <div>&gt; &gt;&gt; From: amd-gfx [<a
              href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              moz-do-not-send="true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
            On</div>
          <div>&gt; &gt;&gt; Behalf Of Deng, Emily</div>
          <div>&gt; &gt;&gt; Sent: Friday, May 18, 2018 11:20 AM</div>
          <div>&gt; &gt;&gt; To: Koenig, Christian &lt;<a
              href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org"
              moz-do-not-send="true">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;;
            amd-</div>
          <div>&gt; &gt;&gt; <a href="mailto:gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              moz-do-not-send="true">gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></div>
          <div>&gt; &gt;&gt; Subject: RE: [PATCH] drm/amdgpu: add
            rcu_barrier after entity fini</div>
          <div>&gt; &gt;&gt;</div>
          <div>&gt; &gt;&gt; Hi Christian,</div>
          <div>&gt; &gt;&gt;       Yes, it has already one rcu_barrier,
            but it has called twice</div>
          <div>&gt; &gt;&gt; call_rcu, so the one rcu_barrier just could
            barrier one call_rcu some time.</div>
          <div>&gt; &gt;&gt;      After I added another rcu_barrier, the
            kernel issue will disappear.</div>
          <div>&gt; &gt;&gt;</div>
          <div>&gt; &gt;&gt; Best Wishes,</div>
          <div>&gt; &gt;&gt; Emily Deng</div>
          <div>&gt; &gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt; -----Original Message-----</div>
          <div>&gt; &gt;&gt;&gt; From: Christian König [<a
              href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
              moz-do-not-send="true">mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]</div>
          <div>&gt; &gt;&gt;&gt; Sent: Thursday, May 17, 2018 7:08 PM</div>
          <div>&gt; &gt;&gt;&gt; To: Deng, Emily &lt;<a
              href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">Emily.Deng-5C7GfCeVMHo@public.gmane.org</a>&gt;;
            <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              moz-do-not-send="true">amd-</a></div>
          <div>&gt; <a class="moz-txt-link-abbreviated" href="mailto:gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></div>
          <div>&gt; &gt;&gt;&gt; Subject: Re: [PATCH] drm/amdgpu: add
            rcu_barrier after entity fini</div>
          <div>&gt; &gt;&gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt; Am 17.05.2018 um 12:03 schrieb Emily
            Deng:</div>
          <div>&gt; &gt;&gt;&gt;&gt; To free the fence from the
            amdgpu_fence_slab, need twice call_rcu,</div>
          <div>&gt; &gt;&gt;&gt;&gt; to avoid the amdgpu_fence_slab_fini
            call</div>
          <div>&gt; &gt;&gt;&gt;&gt;
            kmem_cache_destroy(amdgpu_fence_slab) before</div>
          <div>&gt; &gt;&gt;&gt; kmem_cache_free(amdgpu_fence_slab,
            fence), add rcu_barrier after</div>
          <div>&gt; &gt;&gt;&gt; drm_sched_entity_fini.</div>
          <div>&gt; &gt;&gt;&gt;&gt; The
            kmem_cache_free(amdgpu_fence_slab, fence)'s call trace as</div>
          <div>&gt; below:</div>
          <div>&gt; &gt;&gt;&gt;&gt; 1.drm_sched_entity_fini -&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; drm_sched_entity_cleanup -&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt;
            dma_fence_put(entity-&gt;last_scheduled) -&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; drm_sched_fence_release_finished
            -&gt;</div>
          <div>&gt; &gt;&gt;&gt; drm_sched_fence_release_scheduled</div>
          <div>&gt; &gt;&gt;&gt;&gt; -&gt;
            call_rcu(&amp;fence-&gt;finished.rcu, drm_sched_fence_free)</div>
          <div>&gt; &gt;&gt;&gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; 2.drm_sched_fence_free -&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; dma_fence_put(fence-&gt;parent)
            -&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; amdgpu_fence_release -&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; call_rcu(&amp;f-&gt;rcu,
            amdgpu_fence_free) -&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; kmem_cache_free(amdgpu_fence_slab,
            fence);</div>
          <div>&gt; &gt;&gt;&gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; v2:put the barrier before the
            kmem_cache_destroy</div>
          <div>&gt; &gt;&gt;&gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; Change-Id:
            I8dcadd3372f97e72461bf46b41cc26d90f09b8df</div>
          <div>&gt; &gt;&gt;&gt;&gt; Signed-off-by: Emily Deng &lt;<a
              href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">Emily.Deng-5C7GfCeVMHo@public.gmane.org</a>&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; ---</div>
          <div>&gt; &gt;&gt;&gt;&gt;   
            drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +</div>
          <div>&gt; &gt;&gt;&gt;&gt;    1 file changed, 1 insertion(+)</div>
          <div>&gt; &gt;&gt;&gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c</div>
          <div>&gt; &gt;&gt;&gt;&gt;
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c</div>
          <div>&gt; &gt;&gt;&gt;&gt; index 39ec6b8..42be65b 100644</div>
          <div>&gt; &gt;&gt;&gt;&gt; ---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c</div>
          <div>&gt; &gt;&gt;&gt;&gt; +++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c</div>
          <div>&gt; &gt;&gt;&gt;&gt; @@ -69,6 +69,7 @@ int
            amdgpu_fence_slab_init(void)</div>
          <div>&gt; &gt;&gt;&gt;&gt;    void
            amdgpu_fence_slab_fini(void)</div>
          <div>&gt; &gt;&gt;&gt;&gt;    {</div>
          <div>&gt; &gt;&gt;&gt;&gt;           rcu_barrier();</div>
          <div>&gt; &gt;&gt;&gt;&gt; +        rcu_barrier();</div>
          <div>&gt; &gt;&gt;&gt; Well, you should have noted that there
            is already an rcu_barrier</div>
          <div>&gt; &gt;&gt;&gt; here and adding another one shouldn't
            have any additional effect. So</div>
          <div>&gt; &gt;&gt;&gt; your explanation and the proposed
            solution doesn't make to much</div>
          <div>&gt; sense.</div>
          <div>&gt; &gt;&gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt; I think the problem you run into is
            rather that the fence is</div>
          <div>&gt; &gt;&gt;&gt; reference counted and might live longer
            than the module who created it.</div>
          <div>&gt; &gt;&gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt; Complicated issue, one possible
            solution would be to release</div>
          <div>&gt; &gt;&gt;&gt; fence-&gt;parent earlier in the
            scheduler fence but that doesn't sound</div>
          <div>&gt; &gt;&gt;&gt; fence-&gt;like</div>
          <div>&gt; &gt;&gt;&gt; a general purpose solution.</div>
          <div>&gt; &gt;&gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt; Christian.</div>
          <div>&gt; &gt;&gt;&gt;</div>
          <div>&gt; &gt;&gt;&gt;&gt;          
            kmem_cache_destroy(amdgpu_fence_slab);</div>
          <div>&gt; &gt;&gt;&gt;&gt;    }</div>
          <div>&gt; &gt;&gt;&gt;&gt;    /*</div>
          <div>&gt; &gt;&gt;
            _______________________________________________</div>
          <div>&gt; &gt;&gt; amd-gfx mailing list</div>
          <div>&gt; &gt;&gt; <a
              href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></div>
          <div>&gt; &gt;&gt; <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
          <div><font face="Times New Roman"> </font></div>
          <div><font face="Times New Roman"> </font></div>
        </span></font>
    </blockquote>
    <br>
  </body>
</html>

--------------23816A0F7E451F50FCE99EE1--

--===============0074021186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0074021186==--
