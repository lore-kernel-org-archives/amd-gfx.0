From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: How to catch wild writes to system memory, and IOMMU errors
Date: Wed, 15 Feb 2017 10:42:18 +0100
Message-ID: <64bcb5c8-b44c-9880-353c-1ac61a5982a6@vodafone.de>
References: <0f5edda6-e162-78a9-d065-6f53254f5fa1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1241155923=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0f5edda6-e162-78a9-d065-6f53254f5fa1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1241155923==
Content-Type: multipart/alternative;
 boundary="------------2DB39FD7F56AEBC3EE707773"

This is a multi-part message in MIME format.
--------------2DB39FD7F56AEBC3EE707773
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Uff, well that's quite a problem you ran into here.

IOMMU might not help here, cause when it would be the GPU we would have 
made a mapping once and then the page in question is never unmapped (IIRC).

To confirm if it is really the GPU writing those bytes I would add a 
trace point to amdgpu_ttm_tt_populate() to see which pages the GPU got 
assigned.

If the page with the corruption is not in that list it is unlikely (but 
not impossible) that the GPU is the one doing the corruption.

Good luck,
Christian.

Am 14.02.2017 um 14:20 schrieb Nicolai Hähnle:
> Hi all,
>
> on an amd-staging-4.9 kernel with lock debugging and KASAN enabled, I 
> am seeing a bug where I suspect that the GPU may be writing into 
> system memory where it shouldn't.
>
> I can reproduce errors fairly reliable by running a parallel piglit 
> run on 8 cores with Tonga.
>
> See exhibit1 and exhibit2 for two of the errors that were reported. As 
> you can see, poison data of a dead object was overwritten.
>
> If that was done by a use-after-free in kernel code, I would expect to 
> see a KASAN error about it, but I don't. Furthermore, the pattern of 
> overwritten values is quite unusual: single bytes, with 8 byte stride, 
> many times all of them the same value. This is the kind of pattern 
> that could fit GPU writes to an 8-bit texture.
>
> See kasan-corrupted for another type of report that I've seen. This 
> report looks like KASAN's internal data structures were corrupted, 
> leading to a crash.
>
> Needless to say, while I can reproduce those crashes fairly reliably, 
> they are totally non-deterministic.
>
> So the question is how to figure out where the bad memory writes happen.
>
> I noticed that the IOMMU on the system was disabled by the BIOS, so I 
> enabled it, in the hopes that that would catch bad GPU behavior.
>
> Well, this leads to lots of IO_PAGE_FAULT message during the amdgpu 
> module initialization (see dmesg-iommu). When running piglit, however, 
> I get the same type of random memory corruption errors / crashes as 
> before, and no IOMMU errors.
>
> Any ideas on (a) what kind of tools could be helpful in tracking this 
> problem down (if any...), and (b) where in the code the problem lies?
>
> I suspect something's wrong with GART mappings when buffers are moved, 
> but that's pretty vague...
>
> Thanks,
> Nicolai
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------2DB39FD7F56AEBC3EE707773
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Uff, well that's quite a problem you
      ran into here.<br>
      <br>
      IOMMU might not help here, cause when it would be the GPU we would
      have made a mapping once and then the page in question is never
      unmapped (IIRC).<br>
      <br>
      To confirm if it is really the GPU writing those bytes I would add
      a trace point to amdgpu_ttm_tt_populate() to see which pages the
      GPU got assigned.<br>
      <br>
      If the page with the corruption is not in that list it is unlikely
      (but not impossible) that the GPU is the one doing the corruption.<br>
      <br>
      Good luck,<br>
      Christian.<br>
      <br>
      Am 14.02.2017 um 14:20 schrieb Nicolai Hähnle:<br>
    </div>
    <blockquote
      cite="mid:0f5edda6-e162-78a9-d065-6f53254f5fa1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
      type="cite">Hi all,
      <br>
      <br>
      on an amd-staging-4.9 kernel with lock debugging and KASAN
      enabled, I am seeing a bug where I suspect that the GPU may be
      writing into system memory where it shouldn't.
      <br>
      <br>
      I can reproduce errors fairly reliable by running a parallel
      piglit run on 8 cores with Tonga.
      <br>
      <br>
      See exhibit1 and exhibit2 for two of the errors that were
      reported. As you can see, poison data of a dead object was
      overwritten.
      <br>
      <br>
      If that was done by a use-after-free in kernel code, I would
      expect to see a KASAN error about it, but I don't. Furthermore,
      the pattern of overwritten values is quite unusual: single bytes,
      with 8 byte stride, many times all of them the same value. This is
      the kind of pattern that could fit GPU writes to an 8-bit texture.
      <br>
      <br>
      See kasan-corrupted for another type of report that I've seen.
      This report looks like KASAN's internal data structures were
      corrupted, leading to a crash.
      <br>
      <br>
      Needless to say, while I can reproduce those crashes fairly
      reliably, they are totally non-deterministic.
      <br>
      <br>
      So the question is how to figure out where the bad memory writes
      happen.
      <br>
      <br>
      I noticed that the IOMMU on the system was disabled by the BIOS,
      so I enabled it, in the hopes that that would catch bad GPU
      behavior.
      <br>
      <br>
      Well, this leads to lots of IO_PAGE_FAULT message during the
      amdgpu module initialization (see dmesg-iommu). When running
      piglit, however, I get the same type of random memory corruption
      errors / crashes as before, and no IOMMU errors.
      <br>
      <br>
      Any ideas on (a) what kind of tools could be helpful in tracking
      this problem down (if any...), and (b) where in the code the
      problem lies?
      <br>
      <br>
      I suspect something's wrong with GART mappings when buffers are
      moved, but that's pretty vague...
      <br>
      <br>
      Thanks,
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

--------------2DB39FD7F56AEBC3EE707773--

--===============1241155923==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1241155923==--
