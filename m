From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm: rename null fence to stub fence in syncobj
Date: Wed, 22 Aug 2018 17:10:43 +0800
Message-ID: <4a4f9302-bf25-96c3-c870-32492ddc7134@amd.com>
References: <20180822083857.19216-1-david1.zhou@amd.com>
 <a2518f6e-28cd-f41b-d0bc-9047860ac901@gmail.com>
 <1db43111-55fd-ba68-1d5c-6ecbd19ad65e@amd.com>
 <a586e4f3-0fbb-e530-6a20-fe6d32302771@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2066323226=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a586e4f3-0fbb-e530-6a20-fe6d32302771-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============2066323226==
Content-Type: multipart/alternative;
	boundary="------------EDD62764169CE875B01BFBEC"
Content-Language: en-US

--------------EDD62764169CE875B01BFBEC
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年08月22日 17:05, Christian König wrote:
> Am 22.08.2018 um 11:02 schrieb zhoucm1:
>>
>>
>> On 2018年08月22日 16:52, Christian König wrote:
>>> Am 22.08.2018 um 10:38 schrieb Chunming Zhou:
>>>> stub fence will be used by timeline syncobj as well.
>>>>
>>>> Change-Id: Ia4252f03c07a8105491d2791dc7c8c6976682285
>>>> Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
>>>> Cc: Jason Ekstrand <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>
>>>> ---
>>>>   drivers/gpu/drm/drm_syncobj.c | 28 ++--------------------------
>>>>   include/drm/drm_syncobj.h     | 24 ++++++++++++++++++++++++
>>>>   2 files changed, 26 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_syncobj.c 
>>>> b/drivers/gpu/drm/drm_syncobj.c
>>>> index d4f4ce484529..70af32d0def1 100644
>>>> --- a/drivers/gpu/drm/drm_syncobj.c
>>>> +++ b/drivers/gpu/drm/drm_syncobj.c
>>>> @@ -187,39 +187,15 @@ void drm_syncobj_replace_fence(struct 
>>>> drm_syncobj *syncobj,
>>>>   }
>>>>   EXPORT_SYMBOL(drm_syncobj_replace_fence);
>>>>   -struct drm_syncobj_null_fence {
>>>> -    struct dma_fence base;
>>>> -    spinlock_t lock;
>>>> -};
>>>> -
>>>> -static const char *drm_syncobj_null_fence_get_name(struct 
>>>> dma_fence *fence)
>>>> -{
>>>> -        return "syncobjnull";
>>>> -}
>>>> -
>>>> -static bool drm_syncobj_null_fence_enable_signaling(struct 
>>>> dma_fence *fence)
>>>> -{
>>>> -    dma_fence_enable_sw_signaling(fence);
>>>> -    return !dma_fence_is_signaled(fence);
>>>> -}
>>>> -
>>>> -static const struct dma_fence_ops drm_syncobj_null_fence_ops = {
>>>> -    .get_driver_name = drm_syncobj_null_fence_get_name,
>>>> -    .get_timeline_name = drm_syncobj_null_fence_get_name,
>>>> -    .enable_signaling = drm_syncobj_null_fence_enable_signaling,
>>>> -    .wait = dma_fence_default_wait,
>>>> -    .release = NULL,
>>>> -};
>>>> -
>>>>   static int drm_syncobj_assign_null_handle(struct drm_syncobj 
>>>> *syncobj)
>>>>   {
>>>> -    struct drm_syncobj_null_fence *fence;
>>>> +    struct drm_syncobj_stub_fence *fence;
>>>>       fence = kzalloc(sizeof(*fence), GFP_KERNEL);
>>>>       if (fence == NULL)
>>>>           return -ENOMEM;
>>>>         spin_lock_init(&fence->lock);
>>>> -    dma_fence_init(&fence->base, &drm_syncobj_null_fence_ops,
>>>> +    dma_fence_init(&fence->base, &drm_syncobj_stub_fence_ops,
>>>>                  &fence->lock, 0, 0);
>>>>       dma_fence_signal(&fence->base);
>>>>   diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
>>>> index 3980602472c0..b04c492ddbb5 100644
>>>> --- a/include/drm/drm_syncobj.h
>>>> +++ b/include/drm/drm_syncobj.h
>>>> @@ -30,6 +30,30 @@
>>>>     struct drm_syncobj_cb;
>>>>   +struct drm_syncobj_stub_fence {
>>>> +    struct dma_fence base;
>>>> +    spinlock_t lock;
>>>> +};
>>>> +
>>>> +const char *drm_syncobj_stub_fence_get_name(struct dma_fence *fence)
>>>> +{
>>>> +        return "syncobjstub";
>>>> +}
>>>> +
>>>> +bool drm_syncobj_stub_fence_enable_signaling(struct dma_fence *fence)
>>>> +{
>>>> +    dma_fence_enable_sw_signaling(fence);
>>>
>>> Copy&pasted from the old implementation, but that is certainly 
>>> totally nonsense.
>>>
>>> dma_fence_enable_sw_signaling() is the function who is calling this 
>>> callback.
>> indeed, will fix.
>>>
>>>> +    return !dma_fence_is_signaled(fence);
>>>> +}
>>>> +
>>>> +const struct dma_fence_ops drm_syncobj_stub_fence_ops = {
>>>> +    .get_driver_name = drm_syncobj_stub_fence_get_name,
>>>> +    .get_timeline_name = drm_syncobj_stub_fence_get_name,
>>>> +    .enable_signaling = drm_syncobj_stub_fence_enable_signaling,
>>>> +    .wait = dma_fence_default_wait,
>>>
>>> The .wait callback should be dropped.
>> why?
>>
>> fence->ops->wait(fence, intr, timeout) is called by dma_fence_wait(). 
>> If dropped, how does dma_fence_wait() work?
>
> You are working on an older code base, fence->ops->wait is optional by 
> now.
Sorry, I still don't get it. My code is synced today from 
amd-staging-drm-next, and it's 4.18-rc1.
I still see the dma_fence_wait_timeout is :
signed long
dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long 
timeout)
{
         signed long ret;

         if (WARN_ON(timeout < 0))
                 return -EINVAL;

         trace_dma_fence_wait_start(fence);
         ret = fence->ops->wait(fence, intr, timeout);
         trace_dma_fence_wait_end(fence);
         return ret;
}

.wait callback seems still a must have?

Thanks,
David Zhou


>
> Christian.
>
>>
>> Thanks,
>> David
>>>
>>> Apart from that looks good to me.
>>>
>>> Christian.
>>>
>>>> +    .release = NULL,
>>>> +};
>>>> +
>>>>   /**
>>>>    * struct drm_syncobj - sync object.
>>>>    *
>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------EDD62764169CE875B01BFBEC
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
    <div class="moz-cite-prefix">On 2018年08月22日 17:05, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:a586e4f3-0fbb-e530-6a20-fe6d32302771-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">Am
      22.08.2018 um 11:02 schrieb zhoucm1:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2018年08月22日 16:52, Christian König wrote:
        <br>
        <blockquote type="cite">Am 22.08.2018 um 10:38 schrieb Chunming
          Zhou:
          <br>
          <blockquote type="cite">stub fence will be used by timeline
            syncobj as well.
            <br>
            <br>
            Change-Id: Ia4252f03c07a8105491d2791dc7c8c6976682285
            <br>
            Signed-off-by: Chunming Zhou <a class="moz-txt-link-rfc2396E" href="mailto:david1.zhou-5C7GfCeVMHo@public.gmane.org">&lt;david1.zhou-5C7GfCeVMHo@public.gmane.org&gt;</a>
            <br>
            Cc: Jason Ekstrand <a class="moz-txt-link-rfc2396E" href="mailto:jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org">&lt;jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org&gt;</a>
            <br>
            ---
            <br>
              drivers/gpu/drm/drm_syncobj.c | 28
            ++--------------------------
            <br>
              include/drm/drm_syncobj.h     | 24
            ++++++++++++++++++++++++
            <br>
              2 files changed, 26 insertions(+), 26 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/drm_syncobj.c
            b/drivers/gpu/drm/drm_syncobj.c
            <br>
            index d4f4ce484529..70af32d0def1 100644
            <br>
            --- a/drivers/gpu/drm/drm_syncobj.c
            <br>
            +++ b/drivers/gpu/drm/drm_syncobj.c
            <br>
            @@ -187,39 +187,15 @@ void drm_syncobj_replace_fence(struct
            drm_syncobj *syncobj,
            <br>
              }
            <br>
              EXPORT_SYMBOL(drm_syncobj_replace_fence);
            <br>
              -struct drm_syncobj_null_fence {
            <br>
            -    struct dma_fence base;
            <br>
            -    spinlock_t lock;
            <br>
            -};
            <br>
            -
            <br>
            -static const char *drm_syncobj_null_fence_get_name(struct
            dma_fence *fence)
            <br>
            -{
            <br>
            -        return "syncobjnull";
            <br>
            -}
            <br>
            -
            <br>
            -static bool drm_syncobj_null_fence_enable_signaling(struct
            dma_fence *fence)
            <br>
            -{
            <br>
            -    dma_fence_enable_sw_signaling(fence);
            <br>
            -    return !dma_fence_is_signaled(fence);
            <br>
            -}
            <br>
            -
            <br>
            -static const struct dma_fence_ops
            drm_syncobj_null_fence_ops = {
            <br>
            -    .get_driver_name = drm_syncobj_null_fence_get_name,
            <br>
            -    .get_timeline_name = drm_syncobj_null_fence_get_name,
            <br>
            -    .enable_signaling =
            drm_syncobj_null_fence_enable_signaling,
            <br>
            -    .wait = dma_fence_default_wait,
            <br>
            -    .release = NULL,
            <br>
            -};
            <br>
            -
            <br>
              static int drm_syncobj_assign_null_handle(struct
            drm_syncobj *syncobj)
            <br>
              {
            <br>
            -    struct drm_syncobj_null_fence *fence;
            <br>
            +    struct drm_syncobj_stub_fence *fence;
            <br>
                  fence = kzalloc(sizeof(*fence), GFP_KERNEL);
            <br>
                  if (fence == NULL)
            <br>
                      return -ENOMEM;
            <br>
                    spin_lock_init(&amp;fence-&gt;lock);
            <br>
            -    dma_fence_init(&amp;fence-&gt;base,
            &amp;drm_syncobj_null_fence_ops,
            <br>
            +    dma_fence_init(&amp;fence-&gt;base,
            &amp;drm_syncobj_stub_fence_ops,
            <br>
                             &amp;fence-&gt;lock, 0, 0);
            <br>
                  dma_fence_signal(&amp;fence-&gt;base);
            <br>
              diff --git a/include/drm/drm_syncobj.h
            b/include/drm/drm_syncobj.h
            <br>
            index 3980602472c0..b04c492ddbb5 100644
            <br>
            --- a/include/drm/drm_syncobj.h
            <br>
            +++ b/include/drm/drm_syncobj.h
            <br>
            @@ -30,6 +30,30 @@
            <br>
                struct drm_syncobj_cb;
            <br>
              +struct drm_syncobj_stub_fence {
            <br>
            +    struct dma_fence base;
            <br>
            +    spinlock_t lock;
            <br>
            +};
            <br>
            +
            <br>
            +const char *drm_syncobj_stub_fence_get_name(struct
            dma_fence *fence)
            <br>
            +{
            <br>
            +        return "syncobjstub";
            <br>
            +}
            <br>
            +
            <br>
            +bool drm_syncobj_stub_fence_enable_signaling(struct
            dma_fence *fence)
            <br>
            +{
            <br>
            +    dma_fence_enable_sw_signaling(fence);
            <br>
          </blockquote>
          <br>
          Copy&amp;pasted from the old implementation, but that is
          certainly totally nonsense.
          <br>
          <br>
          dma_fence_enable_sw_signaling() is the function who is calling
          this callback.
          <br>
        </blockquote>
        indeed, will fix.
        <br>
        <blockquote type="cite">
          <br>
          <blockquote type="cite">+    return
            !dma_fence_is_signaled(fence);
            <br>
            +}
            <br>
            +
            <br>
            +const struct dma_fence_ops drm_syncobj_stub_fence_ops = {
            <br>
            +    .get_driver_name = drm_syncobj_stub_fence_get_name,
            <br>
            +    .get_timeline_name = drm_syncobj_stub_fence_get_name,
            <br>
            +    .enable_signaling =
            drm_syncobj_stub_fence_enable_signaling,
            <br>
            +    .wait = dma_fence_default_wait,
            <br>
          </blockquote>
          <br>
          The .wait callback should be dropped.
          <br>
        </blockquote>
        why?
        <br>
        <br>
        fence-&gt;ops-&gt;wait(fence, intr, timeout) is called by
        dma_fence_wait(). If dropped, how does dma_fence_wait() work?
        <br>
      </blockquote>
      <br>
      You are working on an older code base, fence-&gt;ops-&gt;wait is
      optional by now.
      <br>
    </blockquote>
    Sorry, I still don't get it. My code is synced today from
    amd-staging-drm-next, and it's 4.18-rc1.<br>
    I still see the dma_fence_wait_timeout is :<br>
    signed long<br>
    dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed
    long timeout)<br>
    {<br>
            signed long ret;<br>
    <br>
            if (WARN_ON(timeout &lt; 0))<br>
                    return -EINVAL;<br>
    <br>
            trace_dma_fence_wait_start(fence);<br>
    <font color="#ff0000">        ret = fence-&gt;ops-&gt;wait(fence,
      intr, timeout);</font><br>
            trace_dma_fence_wait_end(fence);<br>
            return ret;<br>
    }<br>
    <br>
    .wait callback seems still a must have?<br>
    <br>
    Thanks,<br>
    David Zhou<br>
    <br>
    <br>
    <blockquote type="cite"
      cite="mid:a586e4f3-0fbb-e530-6a20-fe6d32302771-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Thanks,
        <br>
        David
        <br>
        <blockquote type="cite">
          <br>
          Apart from that looks good to me.
          <br>
          <br>
          Christian.
          <br>
          <br>
          <blockquote type="cite">+    .release = NULL,
            <br>
            +};
            <br>
            +
            <br>
              /**
            <br>
               * struct drm_syncobj - sync object.
            <br>
               *
            <br>
          </blockquote>
          <br>
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
    </blockquote>
    <br>
  </body>
</html>

--------------EDD62764169CE875B01BFBEC--

--===============2066323226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2066323226==--
