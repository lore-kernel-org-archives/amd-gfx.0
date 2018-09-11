From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix the dead lock issue.
Date: Tue, 11 Sep 2018 08:40:29 +0200
Message-ID: <c67be83d-aecd-a291-a564-15f1fe501680@gmail.com>
References: <1536634293-26099-1-git-send-email-Emily.Deng@amd.com>
 <bf049e4b-321f-33b4-dad2-708269515e90@amd.com>
 <BN7PR12MB2644CEE78E8E6D658D1A686E8F040@BN7PR12MB2644.namprd12.prod.outlook.com>
 <fcbc7544-d08d-4051-c554-f1f9cecb87e1@amd.com>
 <BN7PR12MB2644E374B512DC7EF10CA6D08F040@BN7PR12MB2644.namprd12.prod.outlook.com>
 <be67e50d-f161-c7da-256e-149ed1b56f26@amd.com>
 <83f7a45f-1aee-a2a8-bc82-f3433157c6cb@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0492797015=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <83f7a45f-1aee-a2a8-bc82-f3433157c6cb-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0492797015==
Content-Type: multipart/alternative;
 boundary="------------CC180E0FFEF80A18C9FCB369"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------CC180E0FFEF80A18C9FCB369
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

That won't work correctly. The TTM BO is unreferenced in a couple of 
more places which we don't have control over.

To make it even worse we actually can't take the reservation lock during 
GPU reset because the reservation object might already be destroyed when 
we remove the BO from the list.

I will take a look at this myself today to find a solution which should 
work.

Regards,
Christian.

Am 11.09.2018 um 07:41 schrieb zhoucm1:
>
>
> On 2018年09月11日 11:37, zhoucm1 wrote:
>>
>>
>> On 2018年09月11日 11:32, Deng, Emily wrote:
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of
>>>> zhoucm1
>>>> Sent: Tuesday, September 11, 2018 11:28 AM
>>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; Zhou, David(ChunMing)
>>>> <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the dead lock issue.
>>>>
>>>>
>>>>
>>>> On 2018年09月11日 11:23, Deng, Emily wrote:
>>>>>> -----Original Message-----
>>>>>> From: Zhou, David(ChunMing)
>>>>>> Sent: Tuesday, September 11, 2018 11:03 AM
>>>>>> To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>> Subject: Re: [PATCH] drm/amdgpu: Fix the dead lock issue.
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2018年09月11日 10:51, Emily Deng wrote:
>>>>>>> It will ramdomly have the dead lock issue when test TDR:
>>>>>>> 1. amdgpu_device_handle_vram_lost gets the lock shadow_list_lock 2.
>>>>>>> amdgpu_bo_create locked the bo's resv lock 3.
>>>>>>> amdgpu_bo_create_shadow is waiting for the shadow_list_lock 4.
>>>>>>> amdgpu_device_recover_vram_from_shadow is waiting for the bo's resv
>>>>>>> lock.
>>>>>>>
>>>>>>> v2:
>>>>>>>       Make a local copy of the list
>>>>>>>
>>>>>>> Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
>>>>>> ++++++++++++++++++++-
>>>>>>>     1 file changed, 20 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 2a21267..8c81404 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -3105,6 +3105,9 @@ static int
>>>>>> amdgpu_device_handle_vram_lost(struct amdgpu_device *adev)
>>>>>>>         long r = 1;
>>>>>>>         int i = 0;
>>>>>>>         long tmo;
>>>>>>> +    struct list_head local_shadow_list;
>>>>>>> +
>>>>>>> +    INIT_LIST_HEAD(&local_shadow_list);
>>>>>>>
>>>>>>>         if (amdgpu_sriov_runtime(adev))
>>>>>>>             tmo = msecs_to_jiffies(8000);
>>>>>>> @@ -3112,8 +3115,19 @@ static int
>>>>>> amdgpu_device_handle_vram_lost(struct amdgpu_device *adev)
>>>>>>>             tmo = msecs_to_jiffies(100);
>>>>>>>
>>>>>>>         DRM_INFO("recover vram bo from shadow start\n");
>>>>>>> +
>>>>>>> +    mutex_lock(&adev->shadow_list_lock);
>>>>>>> +    list_splice_init(&adev->shadow_list, &local_shadow_list);
>>>>>>> +    mutex_unlock(&adev->shadow_list_lock);
>>>>>>> +
>>>>>>> +
>>>>>>>         mutex_lock(&adev->shadow_list_lock);
>>>>>> local_shadow_list is a local variable, I think it doesn't need lock
>>>>>> at all, no one change it. Otherwise looks good to me.
>>>>> The bo->shadow_list which now is in local_shadow_list maybe 
>>>>> destroy in
>>>>> case that it already in amdgpu_bo_destroy, then it will change
>>>> local_shadow_list, so need lock the shadow_list_lock.
>>>> Ah, sorry for noise, I forget you don't reference these BOs.
>>> Yes, I don't reference these Bos, as I found even reference these 
>>> Bos, it still couldn't avoid the case that another process is already
>>> in amdgpu_bo_destroy.
>> ??? that shouldn't happen, the reference is belonged to list. But 
>> back to here, we don't need reference them.
>> And since no shadow BO is added to local after splice, we'd better to 
>> use list_next_entry to iterate the local shadow list instead of 
>> list_for_each_entry_safe.
>>
>> Thanks,
>> David Zhou
>>>> Thanks,
>>>> David Zhou
>>>>> Best wishes
>>>>> Emily Deng
>>>>>> Thanks,
>>>>>> David Zhou
>>>>>>> - list_for_each_entry_safe(bo, tmp, &adev->shadow_list, 
>>>>>>> shadow_list) {
>>>>>>> +    list_for_each_entry_safe(bo, tmp, &local_shadow_list, 
>>>>>>> shadow_list) {
> because shadow list doesn't take bo reference, we should give a 
> amdgpu_bo_ref(bo) with attached patch before unlock.
> You can have a try.
>
> Thanks,
> David Zhou
>>>>>>> + mutex_unlock(&adev->shadow_list_lock);
>>>>>>> +
>>>>>>> +        if (!bo)
>>>>>>> +            continue;
>>>>>>> +
>>>>>>>             next = NULL;
>>>>>>> amdgpu_device_recover_vram_from_shadow(adev, ring, bo,
>>>>>> &next);
>>>>>>>             if (fence) {
>>>>>>> @@ -3132,9 +3146,14 @@ static int
>>>>>>> amdgpu_device_handle_vram_lost(struct amdgpu_device *adev)
>>>>>>>
>>>>>>>             dma_fence_put(fence);
>>>>>>>             fence = next;
>>>>>>> +        mutex_lock(&adev->shadow_list_lock);
>>>>>>>         }
>>>>>>>         mutex_unlock(&adev->shadow_list_lock);
>>>>>>>
>>>>>>> +    mutex_lock(&adev->shadow_list_lock);
>>>>>>> +    list_splice_init(&local_shadow_list, &adev->shadow_list);
>>>>>>> +    mutex_unlock(&adev->shadow_list_lock);
>>>>>>> +
>>>>>>>         if (fence) {
>>>>>>>             r = dma_fence_wait_timeout(fence, false, tmo);
>>>>>>>             if (r == 0)
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------CC180E0FFEF80A18C9FCB369
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">That won't work correctly. The TTM BO
      is unreferenced in a couple of more places which we don't have
      control over.<br>
      <br>
      To make it even worse we actually can't take the reservation lock
      during GPU reset because the reservation object might already be
      destroyed when we remove the BO from the list.<br>
      <br>
      I will take a look at this myself today to find a solution which
      should work.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 11.09.2018 um 07:41 schrieb zhoucm1:<br>
    </div>
    <blockquote type="cite"
      cite="mid:83f7a45f-1aee-a2a8-bc82-f3433157c6cb-5C7GfCeVMHo@public.gmane.org">
      <br>
      <br>
      On 2018年09月11日 11:37, zhoucm1 wrote:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2018年09月11日 11:32, Deng, Emily wrote:
        <br>
        <blockquote type="cite">
          <blockquote type="cite">-----Original Message-----
            <br>
            From: amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a>
            On Behalf Of
            <br>
            zhoucm1
            <br>
            Sent: Tuesday, September 11, 2018 11:28 AM
            <br>
            To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>; Zhou,
            David(ChunMing)
            <br>
            <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
            <br>
            Subject: Re: [PATCH] drm/amdgpu: Fix the dead lock issue.
            <br>
            <br>
            <br>
            <br>
            On 2018年09月11日 11:23, Deng, Emily wrote:
            <br>
            <blockquote type="cite">
              <blockquote type="cite">-----Original Message-----
                <br>
                From: Zhou, David(ChunMing)
                <br>
                Sent: Tuesday, September 11, 2018 11:03 AM
                <br>
                To: Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
                <br>
                Subject: Re: [PATCH] drm/amdgpu: Fix the dead lock
                issue.
                <br>
                <br>
                <br>
                <br>
                On 2018年09月11日 10:51, Emily Deng wrote:
                <br>
                <blockquote type="cite">It will ramdomly have the dead
                  lock issue when test TDR:
                  <br>
                  1. amdgpu_device_handle_vram_lost gets the lock
                  shadow_list_lock 2.
                  <br>
                  amdgpu_bo_create locked the bo's resv lock 3.
                  <br>
                  amdgpu_bo_create_shadow is waiting for the
                  shadow_list_lock 4.
                  <br>
                  amdgpu_device_recover_vram_from_shadow is waiting for
                  the bo's resv
                  <br>
                  lock.
                  <br>
                  <br>
                  v2:
                  <br>
                        Make a local copy of the list
                  <br>
                  <br>
                  Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">&lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;</a>
                  <br>
                  ---
                  <br>
                      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
                  <br>
                </blockquote>
                ++++++++++++++++++++-
                <br>
                <blockquote type="cite">    1 file changed, 20
                  insertions(+), 1 deletion(-)
                  <br>
                  <br>
                  diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                  <br>
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                  <br>
                  index 2a21267..8c81404 100644
                  <br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                  <br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                  <br>
                  @@ -3105,6 +3105,9 @@ static int
                  <br>
                </blockquote>
                amdgpu_device_handle_vram_lost(struct amdgpu_device
                *adev)
                <br>
                <blockquote type="cite">        long r = 1;
                  <br>
                          int i = 0;
                  <br>
                          long tmo;
                  <br>
                  +    struct list_head local_shadow_list;
                  <br>
                  +
                  <br>
                  +    INIT_LIST_HEAD(&amp;local_shadow_list);
                  <br>
                  <br>
                          if (amdgpu_sriov_runtime(adev))
                  <br>
                              tmo = msecs_to_jiffies(8000);
                  <br>
                  @@ -3112,8 +3115,19 @@ static int
                  <br>
                </blockquote>
                amdgpu_device_handle_vram_lost(struct amdgpu_device
                *adev)
                <br>
                <blockquote type="cite">            tmo =
                  msecs_to_jiffies(100);
                  <br>
                  <br>
                          DRM_INFO("recover vram bo from shadow
                  start\n");
                  <br>
                  +
                  <br>
                  +    mutex_lock(&amp;adev-&gt;shadow_list_lock);
                  <br>
                  +    list_splice_init(&amp;adev-&gt;shadow_list,
                  &amp;local_shadow_list);
                  <br>
                  +    mutex_unlock(&amp;adev-&gt;shadow_list_lock);
                  <br>
                  +
                  <br>
                  +
                  <br>
                          mutex_lock(&amp;adev-&gt;shadow_list_lock);
                  <br>
                </blockquote>
                local_shadow_list is a local variable, I think it
                doesn't need lock
                <br>
                at all, no one change it. Otherwise looks good to me.
                <br>
              </blockquote>
              The bo-&gt;shadow_list which now is in local_shadow_list
              maybe destroy in
              <br>
              case that it already in amdgpu_bo_destroy, then it will
              change
              <br>
            </blockquote>
            local_shadow_list, so need lock the shadow_list_lock.
            <br>
            Ah, sorry for noise, I forget you don't reference these BOs.
            <br>
          </blockquote>
          Yes, I don't reference these Bos, as I found even reference
          these Bos, it still couldn't avoid the case that another
          process is already
          <br>
          in amdgpu_bo_destroy.
          <br>
        </blockquote>
        ??? that shouldn't happen, the reference is belonged to list.
        But back to here, we don't need reference them.
        <br>
        And since no shadow BO is added to local after splice, we'd
        better to use list_next_entry to iterate the local shadow list
        instead of list_for_each_entry_safe.
        <br>
        <br>
        Thanks,
        <br>
        David Zhou
        <br>
        <blockquote type="cite">
          <blockquote type="cite">Thanks,
            <br>
            David Zhou
            <br>
            <blockquote type="cite">Best wishes
              <br>
              Emily Deng
              <br>
              <blockquote type="cite">Thanks,
                <br>
                David Zhou
                <br>
                <blockquote type="cite">-   
                  list_for_each_entry_safe(bo, tmp,
                  &amp;adev-&gt;shadow_list, shadow_list) {
                  <br>
                  +    list_for_each_entry_safe(bo, tmp,
                  &amp;local_shadow_list, shadow_list) {
                  <br>
                </blockquote>
              </blockquote>
            </blockquote>
          </blockquote>
        </blockquote>
      </blockquote>
      because shadow list doesn't take bo reference, we should give a
      amdgpu_bo_ref(bo) with attached patch before unlock.
      <br>
      You can have a try.
      <br>
      <br>
      Thanks,
      <br>
      David Zhou
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <blockquote type="cite">
                <blockquote type="cite">+
                  mutex_unlock(&amp;adev-&gt;shadow_list_lock);
                  <br>
                  +
                  <br>
                  +        if (!bo)
                  <br>
                  +            continue;
                  <br>
                  +
                  <br>
                              next = NULL;
                  <br>
                             
                  amdgpu_device_recover_vram_from_shadow(adev, ring, bo,
                  <br>
                </blockquote>
                &amp;next);
                <br>
                <blockquote type="cite">            if (fence) {
                  <br>
                  @@ -3132,9 +3146,14 @@ static int
                  <br>
                  amdgpu_device_handle_vram_lost(struct amdgpu_device
                  *adev)
                  <br>
                  <br>
                              dma_fence_put(fence);
                  <br>
                              fence = next;
                  <br>
                  +        mutex_lock(&amp;adev-&gt;shadow_list_lock);
                  <br>
                          }
                  <br>
                          mutex_unlock(&amp;adev-&gt;shadow_list_lock);
                  <br>
                  <br>
                  +    mutex_lock(&amp;adev-&gt;shadow_list_lock);
                  <br>
                  +    list_splice_init(&amp;local_shadow_list,
                  &amp;adev-&gt;shadow_list);
                  <br>
                  +    mutex_unlock(&amp;adev-&gt;shadow_list_lock);
                  <br>
                  +
                  <br>
                          if (fence) {
                  <br>
                              r = dma_fence_wait_timeout(fence, false,
                  tmo);
                  <br>
                              if (r == 0)
                  <br>
                </blockquote>
              </blockquote>
            </blockquote>
            _______________________________________________
            <br>
            amd-gfx mailing list
            <br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
            <br>
            <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
            <br>
          </blockquote>
        </blockquote>
        <br>
        _______________________________________________
        <br>
        amd-gfx mailing list
        <br>
        <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
        <br>
        <a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
        <br>
      </blockquote>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------CC180E0FFEF80A18C9FCB369--

--===============0492797015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0492797015==--
