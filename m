From: zhoucm1 <zhoucm1@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: refresh per vm bo lru
Date: Thu, 29 Mar 2018 16:37:35 +0800
Message-ID: <14672700-82d7-c9d8-1086-84a4d8a711bc@amd.com>
References: <20180327101654.1118-1-david1.zhou@amd.com>
 <20180327101654.1118-2-david1.zhou@amd.com>
 <6afa6cca-d59c-9e64-f891-c43a741069d4@gmail.com>
 <a9d42a8a-b9b5-1d89-f95e-e678829a8260@amd.com>
 <192b6077-88e7-f0f0-6923-b91e3ad5e97b@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1806595741=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <192b6077-88e7-f0f0-6923-b91e3ad5e97b@amd.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "Zhou,
 David(ChunMing)" <David1.Zhou@amd.com>
Cc: "dri-devel@freedesktop.org" <dri-devel@freedesktop.org>, amd-gfx <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1806595741==
Content-Type: multipart/alternative;
	boundary="------------2E06F6D8F0E6878CDF47196F"
Content-Language: en-US

--------------2E06F6D8F0E6878CDF47196F
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年03月28日 16:13, zhoucm1 wrote:
>
>
>
> On 2018年03月27日 21:44, Christian König wrote:
>
>> How about we update the LRU only when we need to re-validate at least 
>> one BO?
> I tried this just now, performance still isn't stable, sometime drop 
> to 28fps by accident.
>
> I also tried to check num_evictions, if eviction happens, then update 
> LRU, also sometime drop to 28fps by accident.
>
> When BOs change, we not only need keep LRU order, but also validation 
> order in vm->evicted list. Any other ideas which can keep these order 
> but not increase submission overhead?

With more thinking, we need to add new LRU design for per vm bo, we need 
to make sure the order when adding to LRU. How about the below idea:
0. separate traditional bo list lru and per-vm-bo lru. Traditional lru 
keeps old way, per-vm-lru follows below design.
1. TTM bdev maintains a vm/process list.
2. Every vm_list node contains its own per-vm-bo LRU[priority]
3. To manage the vm_list lru in specific driver, we will need add 
callback for it.
4. We will add an order for every per-vm-bo in that vm/process.
5. To speed up per-vm-lru sort, we will introduce RB tree for it in 
callback. The RB tree key is order.

This way, we will be able to keep the per-vm-bo LRU order.

What do you think of it?

Regards,
David Zhou
>
> Regards,
> David Zhou
>>
>> BTW: We can easily walk all BOs which belong to a VM, skipping over 
>> the few which aren't per VM BOs should be trivial.
>>
>> Christian.
>>
>> Am 27.03.2018 um 13:56 schrieb Zhou, David(ChunMing):
>>> then how to keep unique lru order? any ideas?
>>>
>>> To stable performance, we have to keep unique lru order, otherwise 
>>> like the issue I look into, sometimes F1game is 40fps, sometimes 
>>> 28fps...even re-validate allowed domains BO.
>>>
>>> The left root cause is the moved BOs are not same.
>>>
>>> send from Smartisan Pro
>>>
>>> Christian K鰊ig <ckoenig.leichtzumerken@gmail.com> 于 2018年3月27日 
>>> 下午6:50写道：
>>>
>>> NAK, we already tried that and it is really not a good idea because it
>>> massively increases the per submission overhead.
>>>
>>> Christian.
>>>
>>> Am 27.03.2018 um 12:16 schrieb Chunming Zhou:
>>> > Change-Id: Ibad84ed585b0746867a5f4cd1eadc2273e7cf596
>>> > Signed-off-by: Chunming Zhou <david1.zhou@amd.com>
>>> > ---
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  2 ++
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 +++++++++++++++
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
>>> >   3 files changed, 18 insertions(+)
>>> >
>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> > index 383bf2d31c92..414e61799236 100644
>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> > @@ -919,6 +919,8 @@ static int amdgpu_bo_vm_update_pte(struct 
>>> amdgpu_cs_parser *p)
>>> >                }
>>> >        }
>>> >
>>> > +     amdgpu_vm_refresh_lru(adev, vm);
>>> > +
>>> >        return r;
>>> >   }
>>> >
>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> > index 5e35e23511cf..8ad2bb705765 100644
>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> > @@ -1902,6 +1902,21 @@ struct amdgpu_bo_va 
>>> *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>>> >        return bo_va;
>>> >   }
>>> >
>>> > +void amdgpu_vm_refresh_lru(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm)
>>> > +{
>>> > +     struct ttm_bo_global *glob = adev->mman.bdev.glob;
>>> > +     struct amdgpu_vm_bo_base *bo_base;
>>> > +
>>> > +     spin_lock(&vm->status_lock);
>>> > +     list_for_each_entry(bo_base, &vm->vm_bo_list, vm_bo) {
>>> > +             spin_lock(&glob->lru_lock);
>>> > + ttm_bo_move_to_lru_tail(&bo_base->bo->tbo);
>>> > +             if (bo_base->bo->shadow)
>>> > + ttm_bo_move_to_lru_tail(&bo_base->bo->shadow->tbo);
>>> > +             spin_unlock(&glob->lru_lock);
>>> > +     }
>>> > +     spin_unlock(&vm->status_lock);
>>> > +}
>>> >
>>> >   /**
>>> >    * amdgpu_vm_bo_insert_mapping - insert a new mapping
>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> > index 1886a561c84e..e01895581489 100644
>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> > @@ -285,6 +285,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device 
>>> *adev,
>>> >                          struct dma_fence **fence);
>>> >   int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>>> >                           struct amdgpu_vm *vm);
>>> > +void amdgpu_vm_refresh_lru(struct amdgpu_device *adev, struct 
>>> amdgpu_vm *vm);
>>> >   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>>> >                        struct amdgpu_bo_va *bo_va,
>>> >                        bool clear);
>>>
>>
>


--------------2E06F6D8F0E6878CDF47196F
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018年03月28日 16:13, zhoucm1 wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:192b6077-88e7-f0f0-6923-b91e3ad5e97b@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <p><br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 2018年03月27日 21:44, Christian König
        wrote:<font size="2"><span style="font-size:11pt;"><br>
            <br>
          </span></font></div>
      <blockquote type="cite"
        cite="mid:a9d42a8a-b9b5-1d89-f95e-e678829a8260@amd.com">
        <meta http-equiv="Content-Type" content="text/html;
          charset=utf-8">
        <div class="moz-cite-prefix">How about we update the LRU only
          when we need to re-validate at least one BO?<br>
        </div>
      </blockquote>
      I tried this just now, performance still isn't stable, sometime
      drop to 28fps by accident.<br>
      <br>
      I also tried to check num_evictions, if eviction happens, then
      update LRU, also sometime drop to 28fps by accident.<br>
      <br>
      When BOs change, we not only need keep LRU order, but also
      validation order in vm-&gt;evicted list. Any other ideas which can
      keep these order but not increase submission overhead?<br>
    </blockquote>
    <br>
    With more thinking, we need to add new LRU design for per vm bo, we
    need to make sure the order when adding to LRU. How about the below
    idea:<br>
    0. separate traditional bo list lru and per-vm-bo lru. Traditional
    lru keeps old way, per-vm-lru follows below design.<br>
    1. TTM bdev maintains a vm/process list.<br>
    2. Every vm_list node contains its own per-vm-bo LRU[priority]<br>
    3. To manage the vm_list lru in specific driver, we will need add
    callback for it.<br>
    4. We will add an order for every per-vm-bo in that vm/process.<br>
    5. To speed up per-vm-lru sort, we will introduce RB tree for it in
    callback. The RB tree key is order.<br>
    <br>
    This way, we will be able to keep the per-vm-bo LRU order.<br>
    <br>
    What do you think of it?<br>
    <br>
    Regards,<br>
    David Zhou<br>
    <blockquote type="cite"
      cite="mid:192b6077-88e7-f0f0-6923-b91e3ad5e97b@amd.com"> <br>
      Regards,<br>
      David Zhou<br>
      <blockquote type="cite"
        cite="mid:a9d42a8a-b9b5-1d89-f95e-e678829a8260@amd.com">
        <div class="moz-cite-prefix"> <br>
          BTW: We can easily walk all BOs which belong to a VM, skipping
          over the few which aren't per VM BOs should be trivial.<br>
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
            otherwise like the issue I look into, sometimes F1game is
            40fps, sometimes 28fps...even re-validate allowed domains
            BO.<br>
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
                      href="mailto:ckoenig.leichtzumerken@gmail.com"
                      moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>
                    于 2018年3月27日 下午6:50写道：</span></font></div>
              <br type="attribution">
            </div>
          </div>
          <font size="2"><span style="font-size:11pt;">
              <div class="PlainText">NAK, we already tried that and it
                is really not a good idea because it <br>
                massively increases the per submission overhead.<br>
                <br>
                Christian.<br>
                <br>
                Am 27.03.2018 um 12:16 schrieb Chunming Zhou:<br>
                &gt; Change-Id:
                Ibad84ed585b0746867a5f4cd1eadc2273e7cf596<br>
                &gt; Signed-off-by: Chunming Zhou <a
                  class="moz-txt-link-rfc2396E"
                  href="mailto:david1.zhou@amd.com"
                  moz-do-not-send="true">&lt;david1.zhou@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  2 ++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15
                +++++++++++++++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +<br>
                &gt;   3 files changed, 18 insertions(+)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
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
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; index 5e35e23511cf..8ad2bb705765 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt; @@ -1902,6 +1902,21 @@ struct amdgpu_bo_va
                *amdgpu_vm_bo_add(struct amdgpu_device *adev,<br>
                &gt;        return bo_va;<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; +void amdgpu_vm_refresh_lru(struct amdgpu_device
                *adev, struct amdgpu_vm *vm)<br>
                &gt; +{<br>
                &gt; +     struct ttm_bo_global *glob =
                adev-&gt;mman.bdev.glob;<br>
                &gt; +     struct amdgpu_vm_bo_base *bo_base;<br>
                &gt; +<br>
                &gt; +     spin_lock(&amp;vm-&gt;status_lock);<br>
                &gt; +     list_for_each_entry(bo_base,
                &amp;vm-&gt;vm_bo_list, vm_bo) {<br>
                &gt; +             spin_lock(&amp;glob-&gt;lru_lock);<br>
                &gt; +            
                ttm_bo_move_to_lru_tail(&amp;bo_base-&gt;bo-&gt;tbo);<br>
                &gt; +             if (bo_base-&gt;bo-&gt;shadow)<br>
                &gt; +                    
                ttm_bo_move_to_lru_tail(&amp;bo_base-&gt;bo-&gt;shadow-&gt;tbo);<br>
                &gt; +             spin_unlock(&amp;glob-&gt;lru_lock);<br>
                &gt; +     }<br>
                &gt; +     spin_unlock(&amp;vm-&gt;status_lock);<br>
                &gt; +}<br>
                &gt;   <br>
                &gt;   /**<br>
                &gt;    * amdgpu_vm_bo_insert_mapping - insert a new
                mapping<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; index 1886a561c84e..e01895581489 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
                &gt; @@ -285,6 +285,7 @@ int
                amdgpu_vm_clear_freed(struct amdgpu_device *adev,<br>
                &gt;                          struct dma_fence **fence);<br>
                &gt;   int amdgpu_vm_handle_moved(struct amdgpu_device
                *adev,<br>
                &gt;                           struct amdgpu_vm *vm);<br>
                &gt; +void amdgpu_vm_refresh_lru(struct amdgpu_device
                *adev, struct amdgpu_vm *vm);<br>
                &gt;   int amdgpu_vm_bo_update(struct amdgpu_device
                *adev,<br>
                &gt;                        struct amdgpu_bo_va *bo_va,<br>
                &gt;                        bool clear);<br>
                <br>
              </div>
            </span></font> </blockquote>
        <br>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------2E06F6D8F0E6878CDF47196F--

--===============1806595741==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1806595741==--
