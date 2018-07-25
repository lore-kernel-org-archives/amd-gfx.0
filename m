From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] gpu/drm/radeon: Do not evict VRAM with disabled HIBERNATE
Date: Wed, 25 Jul 2018 12:09:20 +0200
Message-ID: <59b3af36-904c-bec5-40c6-9922dc6d1de4@gmail.com>
References: <495ce9ce-3111-d613-4202-d312a9c12242@molgen.mpg.de>
 <e913459a-8d1f-7f79-0b91-b60030ac7c03@gmail.com>
 <1525c8cd-75b8-9b1b-1e43-ca18c5a507bb@molgen.mpg.de>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1182621335=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1525c8cd-75b8-9b1b-1e43-ca18c5a507bb-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
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
To: Paul Menzel <pmenzel+amd-gfx-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1182621335==
Content-Type: multipart/alternative;
 boundary="------------0763612F6CE426887DAFFAC5"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0763612F6CE426887DAFFAC5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.07.2018 um 11:34 schrieb Paul Menzel:
> Dear Christian,
>
>
> On 07/25/18 10:34, Christian König wrote:
>> Am 25.07.2018 um 00:15 schrieb Paul Menzel:
>>> From: Paul Menzel <pmenzel-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
>>> Date: Wed, 18 Jul 2018 18:15:44 +0200
>>>
>>> Improve commit d796d844 (drm/radeon/kms: make hibernate work on IGPs) to
>>> only migrate VRAM objects if the Linux kernel is actually built with
>>> support for hibernation (suspend to disk).
>>>
>>> Link: https://bugs.freedesktop.org/show_bug.cgi?id=107277
>>> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> Signed-off-by: Paul Menzel <pmenzel-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org>
>> At least a step into the right direction.
> There is also the *nohibernate* keyword for the Linux command line.

Well in general it would be better to get that information from the PM 
subsystem during suspend.

IIRC in amdgpu we already distinct between suspend and freez in 
amdgpu_device_suspend().

So that information just needs to be passed on to amdgpu_evict_vram().

On radeon it is probably a bit more work to implement this.

Regards,
Christian.

>
>> nohibernate     [HIBERNATION] Disable hibernation and resume.
> I need to investigate, if that can be considered too.
>
>> Patch is Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>, but we
>> are also going to need one for amdgpu.
> Indeed. I can prepare that too.
>
>
> Kind regards,
>
> Paul
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------0763612F6CE426887DAFFAC5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 25.07.2018 um 11:34 schrieb Paul
      Menzel:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1525c8cd-75b8-9b1b-1e43-ca18c5a507bb-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org">
      <pre wrap="">Dear Christian,


On 07/25/18 10:34, Christian König wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Am 25.07.2018 um 00:15 schrieb Paul Menzel:
</pre>
        <blockquote type="cite">
          <pre wrap="">From: Paul Menzel <a class="moz-txt-link-rfc2396E" href="mailto:pmenzel-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org">&lt;pmenzel-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org&gt;</a>
Date: Wed, 18 Jul 2018 18:15:44 +0200

Improve commit d796d844 (drm/radeon/kms: make hibernate work on IGPs) to
only migrate VRAM objects if the Linux kernel is actually built with
support for hibernation (suspend to disk).

Link: <a class="moz-txt-link-freetext" href="https://bugs.freedesktop.org/show_bug.cgi?id=107277">https://bugs.freedesktop.org/show_bug.cgi?id=107277</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a>
Signed-off-by: Paul Menzel <a class="moz-txt-link-rfc2396E" href="mailto:pmenzel-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org">&lt;pmenzel-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org&gt;</a>
</pre>
        </blockquote>
        <pre wrap="">
At least a step into the right direction.
</pre>
      </blockquote>
      <pre wrap="">
There is also the *nohibernate* keyword for the Linux command line.</pre>
    </blockquote>
    <br>
    Well in general it would be better to get that information from the
    PM subsystem during suspend.<br>
    <br>
    IIRC in amdgpu we already distinct between suspend and freez in
    amdgpu_device_suspend().<br>
    <br>
    So that information just needs to be passed on to
    amdgpu_evict_vram().<br>
    <br>
    On radeon it is probably a bit more work to implement this.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:1525c8cd-75b8-9b1b-1e43-ca18c5a507bb-KUpvgZVWgV9o1qOY/usvUg@public.gmane.org">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">nohibernate     [HIBERNATION] Disable hibernation and resume.
</pre>
      </blockquote>
      <pre wrap="">
I need to investigate, if that can be considered too.

</pre>
      <blockquote type="cite">
        <pre wrap="">Patch is Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>, but we
are also going to need one for amdgpu.
</pre>
      </blockquote>
      <pre wrap="">
Indeed. I can prepare that too.


Kind regards,

Paul

</pre>
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

--------------0763612F6CE426887DAFFAC5--

--===============1182621335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1182621335==--
