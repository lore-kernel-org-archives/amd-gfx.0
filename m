From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove duplicate evict_vram in suspend path
Date: Mon, 10 Oct 2016 09:19:35 +0200
Message-ID: <eee7ef68-df69-0e74-0201-259112081d4a@vodafone.de>
References: <1475696538-24754-1-git-send-email-alexander.deucher@amd.com>
 <5f17b1d4-b088-4ed7-06b7-86b4c85bd4f0@vodafone.de>
 <CAAzXoRKnei7U3hvUCosvpOB8z9kM6CL1Lg5GduyzfUpW9ZrxKQ@mail.gmail.com>
 <9a09b439-600b-ed25-4d1c-3ee12848a6d8@vodafone.de> <57FB3F3A.7070902@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0760506936=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57FB3F3A.7070902-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0760506936==
Content-Type: multipart/alternative;
 boundary="------------0EE3D4DAD240D1B37B369540"

This is a multi-part message in MIME format.
--------------0EE3D4DAD240D1B37B369540
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

APUs have a problem with that as well when we try to suspend to disk 
because the kernel has no idea that he needs to backup the stolen VRAM 
as well.

I discussed that with Alex internally as well and our conclusion is that 
we could work on this, but it's probably not worth it and potentially 
causes more trouble than it fixes.

It's probably a better idea to give the suspend/resume and eviction code 
some more testing and hardening and add comments here and there why we 
do things like we do them.

Regards,
Christian.

Am 10.10.2016 um 09:11 schrieb zhoucm1:
> We can make it dGpu specific if APU has no problem.
>
> Regards,
> David Zhou
>
> On 2016年10月10日 15:09, Christian König wrote:
>>> i'm a trailblazer of bad ideas at times :-) hehehehe
>> Well, I know this because I had the same bad idea earlier and spend a 
>> lot of time bisecting why it broke :)
>>
>> Christian.
>>
>> Am 09.10.2016 um 19:54 schrieb Tom St Denis:
>>> Yup that's what I said in another part of the thread :-)
>>>
>>> i'm a trailblazer of bad ideas at times :-) hehehehe
>>>
>>> Tom
>>>
>>> On Sun, Oct 9, 2016 at 11:13 AM Christian König 
>>> <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>>>
>>>     Am 05.10.2016 um 21:42 schrieb Alex Deucher:
>>>     > Looks like fallout from a rebase or merge.
>>>     >
>>>     > Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org
>>>     <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>>
>>>
>>>     NAK, this is done on purpose and is for evicting the GART table
>>>     using
>>>     memcpy.
>>>
>>>     Tom wanted to remove that as well and it makes resume then fail
>>>     horrible
>>>     on dGPUs.
>>>
>>>     We should probably add a comment why this is necessary.
>>>
>>>     Christian.
>>>
>>>     > ---
>>>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
>>>     >   1 file changed, 3 deletions(-)
>>>     >
>>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>     > index 45259b5..c2f70be 100644
>>>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>     > @@ -1956,9 +1956,6 @@ int amdgpu_device_suspend(struct
>>>     drm_device *dev, bool suspend, bool fbcon)
>>>     >
>>>     >       r = amdgpu_suspend(adev);
>>>     >
>>>     > -     /* evict remaining vram memory */
>>>     > -     amdgpu_bo_evict_vram(adev);
>>>     > -
>>>     >       pci_save_state(dev->pdev);
>>>     >       if (suspend) {
>>>     >               /* Shut down the device */
>>>
>>>
>>>     _______________________________________________
>>>     amd-gfx mailing list
>>>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------0EE3D4DAD240D1B37B369540
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">APUs have a problem with that as well
      when we try to suspend to disk because the kernel has no idea that
      he needs to backup the stolen VRAM as well.<br>
      <br>
      I discussed that with Alex internally as well and our conclusion
      is that we could work on this, but it's probably not worth it and
      potentially causes more trouble than it fixes.<br>
      <br>
      It's probably a better idea to give the suspend/resume and
      eviction code some more testing and hardening and add comments
      here and there why we do things like we do them.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 10.10.2016 um 09:11 schrieb zhoucm1:<br>
    </div>
    <blockquote cite="mid:57FB3F3A.7070902-5C7GfCeVMHo@public.gmane.org" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      We can make it dGpu specific if APU has no problem.<br>
      <br>
      Regards,<br>
      David Zhou<br>
      <br>
      <div class="moz-cite-prefix">On 2016年10月10日 15:09, Christian König
        wrote:<br>
      </div>
      <blockquote
        cite="mid:9a09b439-600b-ed25-4d1c-3ee12848a6d8-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org"
        type="cite">
        <meta http-equiv="Content-Type" content="text/html;
          charset=utf-8">
        <div class="moz-cite-prefix">
          <blockquote type="cite">i'm a trailblazer of bad ideas at
            times :-) hehehehe</blockquote>
          Well, I know this because I had the same bad idea earlier and
          spend a lot of time bisecting why it broke :)<br>
          <br>
          Christian.<br>
          <br>
          Am 09.10.2016 um 19:54 schrieb Tom St Denis:<br>
        </div>
        <blockquote
cite="mid:CAAzXoRKnei7U3hvUCosvpOB8z9kM6CL1Lg5GduyzfUpW9ZrxKQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
          type="cite">
          <div dir="ltr">Yup that's what I said in another part of the
            thread :-)
            <div><br>
            </div>
            <div>i'm a trailblazer of bad ideas at times :-) hehehehe</div>
            <div><br>
            </div>
            <div>Tom</div>
          </div>
          <br>
          <div class="gmail_quote">
            <div dir="ltr">On Sun, Oct 9, 2016 at 11:13 AM Christian
              König &lt;<a moz-do-not-send="true"
                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;
              wrote:<br>
            </div>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">Am
              05.10.2016 um 21:42 schrieb Alex Deucher:<br
                class="gmail_msg">
              &gt; Looks like fallout from a rebase or merge.<br
                class="gmail_msg">
              &gt;<br class="gmail_msg">
              &gt; Signed-off-by: Alex Deucher &lt;<a
                moz-do-not-send="true"
                href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                class="gmail_msg" target="_blank">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br
                class="gmail_msg">
              <br class="gmail_msg">
              NAK, this is done on purpose and is for evicting the GART
              table using<br class="gmail_msg">
              memcpy.<br class="gmail_msg">
              <br class="gmail_msg">
              Tom wanted to remove that as well and it makes resume then
              fail horrible<br class="gmail_msg">
              on dGPUs.<br class="gmail_msg">
              <br class="gmail_msg">
              We should probably add a comment why this is necessary.<br
                class="gmail_msg">
              <br class="gmail_msg">
              Christian.<br class="gmail_msg">
              <br class="gmail_msg">
              &gt; ---<br class="gmail_msg">
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---<br
                class="gmail_msg">
              &gt;   1 file changed, 3 deletions(-)<br class="gmail_msg">
              &gt;<br class="gmail_msg">
              &gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
                class="gmail_msg">
              &gt; index 45259b5..c2f70be 100644<br class="gmail_msg">
              &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
                class="gmail_msg">
              &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
                class="gmail_msg">
              &gt; @@ -1956,9 +1956,6 @@ int
              amdgpu_device_suspend(struct drm_device *dev, bool
              suspend, bool fbcon)<br class="gmail_msg">
              &gt;<br class="gmail_msg">
              &gt;       r = amdgpu_suspend(adev);<br class="gmail_msg">
              &gt;<br class="gmail_msg">
              &gt; -     /* evict remaining vram memory */<br
                class="gmail_msg">
              &gt; -     amdgpu_bo_evict_vram(adev);<br
                class="gmail_msg">
              &gt; -<br class="gmail_msg">
              &gt;       pci_save_state(dev-&gt;pdev);<br
                class="gmail_msg">
              &gt;       if (suspend) {<br class="gmail_msg">
              &gt;               /* Shut down the device */<br
                class="gmail_msg">
              <br class="gmail_msg">
              <br class="gmail_msg">
              _______________________________________________<br
                class="gmail_msg">
              amd-gfx mailing list<br class="gmail_msg">
              <a moz-do-not-send="true"
                href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                class="gmail_msg" target="_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br
                class="gmail_msg">
              <a moz-do-not-send="true"
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                rel="noreferrer" class="gmail_msg" target="_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br
                class="gmail_msg">
            </blockquote>
          </div>
        </blockquote>
        <p><br>
        </p>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">_______________________________________________
amd-gfx mailing list
<a moz-do-not-send="true" class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a moz-do-not-send="true" class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------0EE3D4DAD240D1B37B369540--

--===============0760506936==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0760506936==--
