From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] [RFC]drm: add syncobj timeline support v5
Date: Wed, 19 Sep 2018 09:21:51 +0200
Message-ID: <cd57779c-ab9b-c12e-8287-f858ce850500@gmail.com>
References: <20180914103747.23663-1-david1.zhou@amd.com>
 <a5d2d299-4360-4267-046e-40b550239524@amd.com>
 <29f4106d-1d10-075c-b90a-61b2da7c6957@amd.com>
 <2bea4bc7-ce1f-e1ff-8308-d932d108f237@gmail.com>
 <0231250d-0ed0-e99b-84c6-166b47a0b9cc@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2044623861=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0231250d-0ed0-e99b-84c6-166b47a0b9cc-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org, Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Rakos <Daniel.Rakos-5C7GfCeVMHo@public.gmane.org>
Cc: Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============2044623861==
Content-Type: multipart/alternative;
 boundary="------------80BD5A70FAE7A5B08233B562"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------80BD5A70FAE7A5B08233B562
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.09.2018 um 05:20 schrieb zhoucm1:
>
>
>
> On 2018年09月18日 16:32, Christian König wrote:
>>>>> +    for (i = 0; i < args->count_handles; i++) {
>>>>> +        if (syncobjs[i]->type == DRM_SYNCOBJ_TYPE_TIMELINE) {
>>>>> +            DRM_ERROR("timeline syncobj cannot reset!\n");
>>>>
>>>> Why not? I mean that should still work or do I miss anything?
>>> timeline semaphore spec doesn't require reset interface, it says the 
>>> timeline value only can be changed by signal operations.
>>
>> Yeah, but we don't care about the timeline spec in the kernel.
>>
>> Question is rather if that still makes sense to support that and as 
>> far as I can see it should be trivial to reinitialize the object. 
> Hi Daniel Rakos,
>
> Could you give a comment on this question? Is it necessary to support 
> timeline reset interface?  I only see the timeline value can be 
> changed by signal operations in Spec.

I think the Vulkan spec is rather irrelevant here. We added the reset 
operation because of drivers which wanted to re-use an existing syncobj.

That is still a valid use case even when Vulkan doesn't have an 
interface for it.

Christian.

>
>
> Thanks,
> David Zhou
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------80BD5A70FAE7A5B08233B562
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 19.09.2018 um 05:20 schrieb zhoucm1:<br>
    </div>
    <blockquote type="cite"
      cite="mid:0231250d-0ed0-e99b-84c6-166b47a0b9cc-5C7GfCeVMHo@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <p><br>
      </p>
      <br>
      <div class="moz-cite-prefix">On 2018年09月18日 16:32, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:2bea4bc7-ce1f-e1ff-8308-d932d108f237-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
        <blockquote type="cite" style="color: #000000;">
          <blockquote type="cite" style="color: #000000;">
            <blockquote type="cite" style="color: #000000;">+    for (i
              = 0; i &lt; args-&gt;count_handles; i++) { <br>
              +        if (syncobjs[i]-&gt;type ==
              DRM_SYNCOBJ_TYPE_TIMELINE) { <br>
              +            DRM_ERROR("timeline syncobj cannot
              reset!\n"); <br>
            </blockquote>
            <br>
            Why not? I mean that should still work or do I miss
            anything? <br>
          </blockquote>
          timeline semaphore spec doesn't require reset interface, it
          says the timeline value only can be changed by signal
          operations. <br>
        </blockquote>
        <br>
        Yeah, but we don't care about the timeline spec in the kernel. <br>
        <br>
        Question is rather if that still makes sense to support that and
        as far as I can see it should be trivial to reinitialize the
        object. </blockquote>
      Hi Daniel Rakos,<br>
      <br>
      Could you give a comment on this question? Is it necessary to
      support timeline reset interface?  I only see the timeline value
      can be changed by signal operations in Spec.<br>
    </blockquote>
    <br>
    I think the Vulkan spec is rather irrelevant here. We added the
    reset operation because of drivers which wanted to re-use an
    existing syncobj.<br>
    <br>
    That is still a valid use case even when Vulkan doesn't have an
    interface for it.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:0231250d-0ed0-e99b-84c6-166b47a0b9cc-5C7GfCeVMHo@public.gmane.org"> <br>
      <br>
      Thanks,<br>
      David Zhou<br>
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

--------------80BD5A70FAE7A5B08233B562--

--===============2044623861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2044623861==--
