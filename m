From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Raciness with page table shadows being swapped out
Date: Mon, 12 Dec 2016 19:22:48 +0100
Message-ID: <c59a9faa-ae45-eecf-5648-ba8143bc2b53@vodafone.de>
References: <9153dde6-9087-94b0-a062-dd223e5f381a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1649314847=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9153dde6-9087-94b0-a062-dd223e5f381a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1649314847==
Content-Type: multipart/alternative;
 boundary="------------9803D8A781C5384692306545"

This is a multi-part message in MIME format.
--------------9803D8A781C5384692306545
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.12.2016 um 16:20 schrieb Nicolai Hähnle:
> Hi all,
>
> I just sent out two patches that hopefully make the kernel module more 
> robust in the face of page table shadows being swapped out.
>
> However, even with those patches, I can still fairly reliably 
> reproduce crashes with a backtrace of the shape
>
> amdgpu_cs_ioctl
>  -> amdgpu_vm_update_page_directory
>  -> amdgpu_ttm_bind
>  -> amdgpu_gtt_mgr_alloc
>
> The plausible reason for these crashes is that nothing seems to 
> prevent the shadow BOs from being moved between the calls to 
> amdgpu_cs_validate in amdgpu_cs_parser_bos and the calls to 
> amdgpu_ttm_bind.

The shadow BOs use the same reservation object than the real BOs. So as 
long as the real BOs can't be evicted the shadows can't be evicted either.

>
> The attached patch has fixed these crashes for me so far, but it's 
> very heavy-handed: it collects all page table shadows and the page 
> directory shadow and adds them all to the reservations for the callers 
> of amdgpu_vm_update_page_directory.

That is most likely just a timing change, cause the shadows should end 
up in the duplicates list anyway. So the patch shouldn't have any effect.

>
> I feel like there should be a better way. In part, I wonder why the 
> shadows are needed in the first place. I vaguely recall the 
> discussions about GPU reset and such, but I don't remember why the 
> page tables can't just be rebuilt in some other way.

It's just the simplest and fastest way to keep a copy of the page tables 
around.

The problem with rebuilding the page tables from the mappings is that 
the housekeeping structures already have the future state when a reset 
happens, not the state we need to rebuild the tables.

We could obviously change the housekeeping a bit to keep both states, 
but that would complicate mapping and unmapping of BOs significantly.

Regards,
Christian.

>
> Cheers,
> Nicolai
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------9803D8A781C5384692306545
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Am 12.12.2016 um 16:20 schrieb Nicolai
      Hähnle:<br>
    </div>
    <blockquote
      cite="mid:9153dde6-9087-94b0-a062-dd223e5f381a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
      type="cite">Hi all,
      <br>
      <br>
      I just sent out two patches that hopefully make the kernel module
      more robust in the face of page table shadows being swapped out.
      <br>
      <br>
      However, even with those patches, I can still fairly reliably
      reproduce crashes with a backtrace of the shape
      <br>
      <br>
      amdgpu_cs_ioctl
      <br>
       -&gt; amdgpu_vm_update_page_directory
      <br>
       -&gt; amdgpu_ttm_bind
      <br>
       -&gt; amdgpu_gtt_mgr_alloc
      <br>
      <br>
      The plausible reason for these crashes is that nothing seems to
      prevent the shadow BOs from being moved between the calls to
      amdgpu_cs_validate in amdgpu_cs_parser_bos and the calls to
      amdgpu_ttm_bind.
      <br>
    </blockquote>
    <br>
    The shadow BOs use the same reservation object than the real BOs. So
    as long as the real BOs can't be evicted the shadows can't be
    evicted either.<br>
    <br>
    <blockquote
      cite="mid:9153dde6-9087-94b0-a062-dd223e5f381a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
      type="cite">
      <br>
      The attached patch has fixed these crashes for me so far, but it's
      very heavy-handed: it collects all page table shadows and the page
      directory shadow and adds them all to the reservations for the
      callers of amdgpu_vm_update_page_directory.
      <br>
    </blockquote>
    <br>
    That is most likely just a timing change, cause the shadows should
    end up in the duplicates list anyway. So the patch shouldn't have
    any effect.<br>
    <br>
    <blockquote
      cite="mid:9153dde6-9087-94b0-a062-dd223e5f381a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
      type="cite">
      <br>
      I feel like there should be a better way. In part, I wonder why
      the shadows are needed in the first place. I vaguely recall the
      discussions about GPU reset and such, but I don't remember why the
      page tables can't just be rebuilt in some other way.
      <br>
    </blockquote>
    <br>
    It's just the simplest and fastest way to keep a copy of the page
    tables around.<br>
    <br>
    The problem with rebuilding the page tables from the mappings is
    that the housekeeping structures already have the future state when
    a reset happens, not the state we need to rebuild the tables.<br>
    <br>
    We could obviously change the housekeeping a bit to keep both
    states, but that would complicate mapping and unmapping of BOs
    significantly.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote
      cite="mid:9153dde6-9087-94b0-a062-dd223e5f381a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
      type="cite">
      <br>
      Cheers,
      <br>
      Nicolai
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
    <p><br>
    </p>
  </body>
</html>

--------------9803D8A781C5384692306545--

--===============1649314847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1649314847==--
