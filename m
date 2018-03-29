From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: refresh per vm bo lru
Date: Thu, 29 Mar 2018 20:46:46 +0800
Message-ID: <b3040d09-1901-11a1-1090-7acb529c139e@amd.com>
References: <20180327101654.1118-1-david1.zhou@amd.com>
 <20180327101654.1118-2-david1.zhou@amd.com>
 <6afa6cca-d59c-9e64-f891-c43a741069d4@gmail.com>
 <a9d42a8a-b9b5-1d89-f95e-e678829a8260@amd.com>
 <192b6077-88e7-f0f0-6923-b91e3ad5e97b@amd.com>
 <14672700-82d7-c9d8-1086-84a4d8a711bc@amd.com>
 <d7dad640-edd0-5aa3-9165-b19d44525a5b@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0558480891=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d7dad640-edd0-5aa3-9165-b19d44525a5b-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "dri-devel-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org" <dri-devel-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org>, amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0558480891==
Content-Type: multipart/alternative;
 boundary="------------B73A9429760229B8D30F696C"

This is a multi-part message in MIME format.
--------------B73A9429760229B8D30F696C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2018/3/29 16:59, Christian König 写道:
> Am 29.03.2018 um 10:37 schrieb zhoucm1:
>>
>>
>>
>> On 2018年03月28日 16:13, zhoucm1 wrote:
>>>
>>>
>>>
>>> On 2018年03月27日 21:44, Christian König wrote:
>>>
>>>> How about we update the LRU only when we need to re-validate at 
>>>> least one BO?
>>> I tried this just now, performance still isn't stable, sometime drop 
>>> to 28fps by accident.
>
> Can you give me the code for that? I probably can't work this week on 
> that, but I can take a look next week.
just git send-mail to your amd mail.

>
>>>
>>> I also tried to check num_evictions, if eviction happens, then 
>>> update LRU, also sometime drop to 28fps by accident.
>>>
>>> When BOs change, we not only need keep LRU order, but also 
>>> validation order in vm->evicted list. Any other ideas which can keep 
>>> these order but not increase submission overhead?
>>
>> With more thinking, we need to add new LRU design for per vm bo, we 
>> need to make sure the order when adding to LRU. How about the below idea:
>> 0. separate traditional bo list lru and per-vm-bo lru. Traditional 
>> lru keeps old way, per-vm-lru follows below design.
>> 1. TTM bdev maintains a vm/process list.
>> 2. Every vm_list node contains its own per-vm-bo LRU[priority]
>> 3. To manage the vm_list lru in specific driver, we will need add 
>> callback for it.
>> 4. We will add an order for every per-vm-bo in that vm/process.
>> 5. To speed up per-vm-lru sort, we will introduce RB tree for it in 
>> callback. The RB tree key is order.
>>
>> This way, we will be able to keep the per-vm-bo LRU order.
>>
>> What do you think of it?
>
> No, we need a single LRU for per VM and not per VM BOs to maintain 
> eviction fairness, so we don't really win anything with that.
If following original LRU design, the bo should be moved to lru tail 
when bo is used, so that keep the last used bo is in lru tail.
All per vm BOs are used for every command submission, then after every 
CS, we should refresh the lru, that is required by original LRU design, 
but as your NAK on it, it will introduce much CPU overhead for CS, they 
are inconsistencies.

For per vm case, if we don't want to introduce extra overhead, the 
per-vm-bo order shoud fixed in lru to avoid refresh LRU for every CS.
so my thinking for lru is:
VM1-BO1---->BO2--->BO3--->BOn--->VM2-BO1--->BO2--->BO3--->BOn--->VM3-BO...

Regards,
David
>
> Regards,
> Christian.
>
>>
>> Regards,
>> David Zhou
>>>
>>> Regards,
>>> David Zhou
>>>>
>>>> BTW: We can easily walk all BOs which belong to a VM, skipping over 
>>>> the few which aren't per VM BOs should be trivial.
>>>>
>>>> Christian.
>>>>
>>>> Am 27.03.2018 um 13:56 schrieb Zhou, David(ChunMing):
>>>>> then how to keep unique lru order? any ideas?
>>>>>
>>>>> To stable performance, we have to keep unique lru order, otherwise 
>>>>> like the issue I look into, sometimes F1game is 40fps, sometimes 
>>>>> 28fps...even re-validate allowed domains BO.
>>>>>
>>>>> The left root cause is the moved BOs are not same.
>>>>>
>>>>> send from Smartisan Pro
>>>>>
>>>>> Christian K鰊ig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> 于 2018年3月27日 
>>>>> 下午6:50写道：
>>>>>
>>>>> NAK, we already tried that and it is really not a good idea 
>>>>> because it
>>>>> massively increases the per submission overhead.
>>>>>
>>>>> Christian.
>>>>>
>>>>> Am 27.03.2018 um 12:16 schrieb Chunming Zhou:
>>>>> > Change-Id: Ibad84ed585b0746867a5f4cd1eadc2273e7cf596
>>>>> > Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
>>>>> > ---
>>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  2 ++
>>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++++++
>>>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
>>>>> >   3 files changed, 18 insertions(+)
>>>>> >
>>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> > index 383bf2d31c92..414e61799236 100644
>>>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>> > @@ -919,6 +919,8 @@ static int amdgpu_bo_vm_update_pte(struct 
>>>>> amdgpu_cs_parser *p)
>>>>> >                }
>>>>> >        }
>>>>> >
>>>>> > +     amdgpu_vm_refresh_lru(adev, vm);
>>>>> > +
>>>>> >        return r;
>>>>> >   }
>>>>> >
>>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> > index 5e35e23511cf..8ad2bb705765 100644
>>>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> > @@ -1902,6 +1902,21 @@ struct amdgpu_bo_va 
>>>>> *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>>>>> >        return bo_va;
>>>>> >   }
>>>>> >
>>>>> > +void amdgpu_vm_refresh_lru(struct amdgpu_device *adev, struct 
>>>>> amdgpu_vm *vm)
>>>>> > +{
>>>>> > +     struct ttm_bo_global *glob = adev->mman.bdev.glob;
>>>>> > +     struct amdgpu_vm_bo_base *bo_base;
>>>>> > +
>>>>> > +     spin_lock(&vm->status_lock);
>>>>> > +     list_for_each_entry(bo_base, &vm->vm_bo_list, vm_bo) {
>>>>> > + spin_lock(&glob->lru_lock);
>>>>> > + ttm_bo_move_to_lru_tail(&bo_base->bo->tbo);
>>>>> > +             if (bo_base->bo->shadow)
>>>>> > + ttm_bo_move_to_lru_tail(&bo_base->bo->shadow->tbo);
>>>>> > + spin_unlock(&glob->lru_lock);
>>>>> > +     }
>>>>> > +     spin_unlock(&vm->status_lock);
>>>>> > +}
>>>>> >
>>>>> >   /**
>>>>> >    * amdgpu_vm_bo_insert_mapping - insert a new mapping
>>>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> > index 1886a561c84e..e01895581489 100644
>>>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>> > @@ -285,6 +285,7 @@ int amdgpu_vm_clear_freed(struct 
>>>>> amdgpu_device *adev,
>>>>> >                          struct dma_fence **fence);
>>>>> >   int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>>>> >                           struct amdgpu_vm *vm);
>>>>> > +void amdgpu_vm_refresh_lru(struct amdgpu_device *adev, struct 
>>>>> amdgpu_vm *vm);
>>>>> >   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>>>> >                        struct amdgpu_bo_va *bo_va,
>>>>> >                        bool clear);
>>>>>
>>>>
>>>
>>
>


--------------B73A9429760229B8D30F696C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">在 2018/3/29 16:59, Christian König 写道:<br>
    </div>
    <blockquote type="cite"
      cite="mid:d7dad640-edd0-5aa3-9165-b19d44525a5b-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div class="moz-cite-prefix">Am 29.03.2018 um 10:37 schrieb
        zhoucm1:<br>
      </div>
      <blockquote type="cite"
        cite="mid:14672700-82d7-c9d8-1086-84a4d8a711bc-5C7GfCeVMHo@public.gmane.org">
        <p><br>
        </p>
        <br>
        <div class="moz-cite-prefix">On 2018年03月28日 16:13, zhoucm1
          wrote:<br>
        </div>
        <blockquote type="cite"
          cite="mid:192b6077-88e7-f0f0-6923-b91e3ad5e97b-5C7GfCeVMHo@public.gmane.org">
          <p><br>
          </p>
          <br>
          <div class="moz-cite-prefix">On 2018年03月27日 21:44, Christian
            König wrote:<font size="2"><span style="font-size:11pt;"><br>
                <br>
              </span></font></div>
          <blockquote type="cite"
            cite="mid:a9d42a8a-b9b5-1d89-f95e-e678829a8260-5C7GfCeVMHo@public.gmane.org">
            <div class="moz-cite-prefix">How about we update the LRU
              only when we need to re-validate at least one BO?<br>
            </div>
          </blockquote>
          I tried this just now, performance still isn't stable,
          sometime drop to 28fps by accident.<br>
        </blockquote>
      </blockquote>
      <br>
      Can you give me the code for that? I probably can't work this week
      on that, but I can take a look next week.<br>
    </blockquote>
    just git send-mail to your amd mail.<br>
    <br>
    <blockquote type="cite"
      cite="mid:d7dad640-edd0-5aa3-9165-b19d44525a5b-5C7GfCeVMHo@public.gmane.org"> <br>
      <blockquote type="cite"
        cite="mid:14672700-82d7-c9d8-1086-84a4d8a711bc-5C7GfCeVMHo@public.gmane.org">
        <blockquote type="cite"
          cite="mid:192b6077-88e7-f0f0-6923-b91e3ad5e97b-5C7GfCeVMHo@public.gmane.org"> <br>
          I also tried to check num_evictions, if eviction happens, then
          update LRU, also sometime drop to 28fps by accident.<br>
          <br>
          When BOs change, we not only need keep LRU order, but also
          validation order in vm-&gt;evicted list. Any other ideas which
          can keep these order but not increase submission overhead?<br>
        </blockquote>
        <br>
        With more thinking, we need to add new LRU design for per vm bo,
        we need to make sure the order when adding to LRU. How about the
        below idea:<br>
        0. separate traditional bo list lru and per-vm-bo lru.
        Traditional lru keeps old way, per-vm-lru follows below design.<br>
        1. TTM bdev maintains a vm/process list.<br>
        2. Every vm_list node contains its own per-vm-bo LRU[priority]<br>
        3. To manage the vm_list lru in specific driver, we will need
        add callback for it.<br>
        4. We will add an order for every per-vm-bo in that vm/process.<br>
        5. To speed up per-vm-lru sort, we will introduce RB tree for it
        in callback. The RB tree key is order.<br>
        <br>
        This way, we will be able to keep the per-vm-bo LRU order.<br>
        <br>
        What do you think of it?<br>
      </blockquote>
      <br>
      No, we need a single LRU for per VM and not per VM BOs to maintain
      eviction fairness, so we don't really win anything with that.<br>
    </blockquote>
    If following original LRU design, the bo should be moved to lru tail
    when bo is used, so that keep the last used bo is in lru tail.<br>
    All per vm BOs are used for every command submission, then after
    every CS, we should refresh the lru, that is required by original
    LRU design, but as your NAK on it, it will introduce much CPU
    overhead for CS, they are inconsistencies.<br>
    <br>
    For per vm case, if we don't want to introduce extra overhead, the
    per-vm-bo order shoud fixed in lru to avoid refresh LRU for every
    CS.<br>
    so my thinking for lru is:<br>
VM1-BO1----&gt;BO2---&gt;BO3---&gt;BOn---&gt;VM2-BO1---&gt;BO2---&gt;BO3---&gt;BOn---&gt;VM3-BO...<br>
    <br>
    Regards,<br>
    David<br>
    <blockquote type="cite"
      cite="mid:d7dad640-edd0-5aa3-9165-b19d44525a5b-5C7GfCeVMHo@public.gmane.org"> <br>
      Regards,<br>
      Christian.<br>
      <br>
      <blockquote type="cite"
        cite="mid:14672700-82d7-c9d8-1086-84a4d8a711bc-5C7GfCeVMHo@public.gmane.org"> <br>
        Regards,<br>
        David Zhou<br>
        <blockquote type="cite"
          cite="mid:192b6077-88e7-f0f0-6923-b91e3ad5e97b-5C7GfCeVMHo@public.gmane.org"> <br>
          Regards,<br>
          David Zhou<br>
          <blockquote type="cite"
            cite="mid:a9d42a8a-b9b5-1d89-f95e-e678829a8260-5C7GfCeVMHo@public.gmane.org">
            <div class="moz-cite-prefix"> <br>
              BTW: We can easily walk all BOs which belong to a VM,
              skipping over the few which aren't per VM BOs should be
              trivial.<br>
              <br>
              Christian.<br>
              <br>
              Am 27.03.2018 um 13:56 schrieb Zhou, David(ChunMing):<br>
            </div>
            <blockquote type="cite" cite="mid:smartisan1522151762126">
              <meta name="Generator" content="Microsoft Exchange Server">
              <!-- converted from text -->
              <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
              <div> <font color="#333333">then how to keep unique lru
                  order? any ideas?<br>
                </font><br>
                To stable performance, we have to keep unique lru order,
                otherwise like the issue I look into, sometimes F1game
                is 40fps, sometimes 28fps...even re-validate allowed
                domains BO.<br>
                <br>
                The left root cause is the moved BOs are not same.<br>
                <br>
                <span id="x_smartisan_signature" style="font-size:0.8em;
                  display:inline; color:#888888">
                  <p dir="ltr">send from Smartisan Pro</p>
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
                          href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                          moz-do-not-send="true">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>
                        于 2018年3月27日 下午6:50写道：</span></font></div>
                  <br type="attribution">
                </div>
              </div>
              <font size="2"><span style="font-size:11pt;">
                  <div class="PlainText">NAK, we already tried that and
                    it is really not a good idea because it <br>
                    massively increases the per submission overhead.<br>
                    <br>
                    Christian.<br>
                    <br>
                    Am 27.03.2018 um 12:16 schrieb Chunming Zhou:<br>
                    &gt; Change-Id:
                    Ibad84ed585b0746867a5f4cd1eadc2273e7cf596<br>
                    &gt; Signed-off-by: Chunming Zhou <a
                      class="moz-txt-link-rfc2396E"
                      href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org"
                      moz-do-not-send="true">&lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                    &gt; ---<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  2
                    ++<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15
                    +++++++++++++++<br>
                    &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +<br>
                    &gt;   3 files changed, 18 insertions(+)<br>
                    &gt;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                    &gt; index 383bf2d31c92..414e61799236 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                    &gt; @@ -919,6 +919,8 @@ static int
                    amdgpu_bo_vm_update_pte(struct amdgpu_cs_parser *p)<br>
                    &gt;                }<br>
                    &gt;        }<br>
                    &gt;   <br>
                    &gt; +     amdgpu_vm_refresh_lru(adev, vm);<br>
                    &gt; +<br>
                    &gt;        return r;<br>
                    &gt;   }<br>
                    &gt;   <br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                    &gt; index 5e35e23511cf..8ad2bb705765 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                    &gt; @@ -1902,6 +1902,21 @@ struct amdgpu_bo_va
                    *amdgpu_vm_bo_add(struct amdgpu_device *adev,<br>
                    &gt;        return bo_va;<br>
                    &gt;   }<br>
                    &gt;   <br>
                    &gt; +void amdgpu_vm_refresh_lru(struct
                    amdgpu_device *adev, struct amdgpu_vm *vm)<br>
                    &gt; +{<br>
                    &gt; +     struct ttm_bo_global *glob =
                    adev-&gt;mman.bdev.glob;<br>
                    &gt; +     struct amdgpu_vm_bo_base *bo_base;<br>
                    &gt; +<br>
                    &gt; +     spin_lock(&amp;vm-&gt;status_lock);<br>
                    &gt; +     list_for_each_entry(bo_base,
                    &amp;vm-&gt;vm_bo_list, vm_bo) {<br>
                    &gt; +            
                    spin_lock(&amp;glob-&gt;lru_lock);<br>
                    &gt; +            
                    ttm_bo_move_to_lru_tail(&amp;bo_base-&gt;bo-&gt;tbo);<br>
                    &gt; +             if (bo_base-&gt;bo-&gt;shadow)<br>
                    &gt; +                    
                    ttm_bo_move_to_lru_tail(&amp;bo_base-&gt;bo-&gt;shadow-&gt;tbo);<br>
                    &gt; +            
                    spin_unlock(&amp;glob-&gt;lru_lock);<br>
                    &gt; +     }<br>
                    &gt; +     spin_unlock(&amp;vm-&gt;status_lock);<br>
                    &gt; +}<br>
                    &gt;   <br>
                    &gt;   /**<br>
                    &gt;    * amdgpu_vm_bo_insert_mapping - insert a new
                    mapping<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                    &gt; index 1886a561c84e..e01895581489 100644<br>
                    &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                    &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                    &gt; @@ -285,6 +285,7 @@ int
                    amdgpu_vm_clear_freed(struct amdgpu_device *adev,<br>
                    &gt;                          struct dma_fence
                    **fence);<br>
                    &gt;   int amdgpu_vm_handle_moved(struct
                    amdgpu_device *adev,<br>
                    &gt;                           struct amdgpu_vm
                    *vm);<br>
                    &gt; +void amdgpu_vm_refresh_lru(struct
                    amdgpu_device *adev, struct amdgpu_vm *vm);<br>
                    &gt;   int amdgpu_vm_bo_update(struct amdgpu_device
                    *adev,<br>
                    &gt;                        struct amdgpu_bo_va
                    *bo_va,<br>
                    &gt;                        bool clear);<br>
                    <br>
                  </div>
                </span></font> </blockquote>
            <br>
          </blockquote>
          <br>
        </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------B73A9429760229B8D30F696C--

--===============0558480891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0558480891==--
