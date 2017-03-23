From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Thu, 23 Mar 2017 17:05:27 +0100
Message-ID: <d476dcba-048d-ad4b-b080-49e31e6fb25b@vodafone.de>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
 <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
 <CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0890243744=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com>
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
To: Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>

This is a multi-part message in MIME format.
--===============0890243744==
Content-Type: multipart/alternative;
 boundary="------------8640DDB2470F0614B0A2E787"

This is a multi-part message in MIME format.
--------------8640DDB2470F0614B0A2E787
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

> Understood -- I thought you might not want to take this patch, but I 
> went ahead and sent it out because Christian requested it, and it 
> seems like he doesn't think VRAM bos should ever evict back to VRAM at 
> all?
No, I've requested reverting the patch for now because it causes an 
obviously and rather severe problem. If you guys can quickly find how to 
fix it feel free to use that instead.

> Is my understanding of the original commit correct in that it tries to 
> rewrite the eviction placements of CPU accessible bos so that they are 
> either size zero (fpfn and lpfn = start of inaccessible VRAM) or they 
> are in inaccessible VRAM (fpfn = start of inaccessible VRAM and lpfn = 0)?
That for example could work as well, but see below.

> if these sorts of evictions are desirable, would it make more sense to 
> treat CPU inaccessible/accessible VRAM as distinct entities with their 
> own lrus?
Actually I'm pretty sure that it isn't desirable. See the evict function 
doesn't know if we try to evict BOs because we need CPU accessible VRAM 
or if we just run out of VRAM.

This code only makes sense when we need to move different BOs into the 
CPU accessible part round robin because they are accessed by the CPU, 
but then it is actually better to move them to GTT sooner or later.

Regards,
Christian.

Am 23.03.2017 um 16:31 schrieb Zachary Michaels:
>
>     Was userspace maybe performing concurrent CPU access to the BOs in
>     question?
>
>
> As far as I know Julien has demonstrated that this is not the case.
>
>     I hope we can find a better solution.
>
>
> Understood -- I thought you might not want to take this patch, but I 
> went ahead and sent it out because Christian requested it, and it 
> seems like he doesn't think VRAM bos should ever evict back to VRAM at 
> all?
>
> Is my understanding of the original commit correct in that it tries to 
> rewrite the eviction placements of CPU accessible bos so that they are 
> either size zero (fpfn and lpfn = start of inaccessible VRAM) or they 
> are in inaccessible VRAM (fpfn = start of inaccessible VRAM and lpfn = 0)?
>
> In this case, to me it seems that the simplest fix would be to iterate 
> using i to rewrite all the VRAM placements instead of just the first 
> one (rbo->placements[i] instead of rbo->placements[0]). In the case 
> where RADEON_GEM_NO_CPU_ACCESS is set, the second placement will be in 
> CPU accessible VRAM, and that doesn't seem correct to me as there is 
> no longer any sort of ordering for evictions. (Unfortunately I'm not 
> currently in a position to test whether this fixes our issue.) Sorry, 
> I meant to make a note of this originally.
>
> Also, I don't claim to understand this code well enough, but I wonder: 
> if these sorts of evictions are desirable, would it make more sense to 
> treat CPU inaccessible/accessible VRAM as distinct entities with their 
> own lrus?
>
> I should also note that we are experiencing another issue where the 
> kernel locks up in similar circumstances. As Julien noted, we get no 
> output, and the watchdogs don't seem to work. It may be the case that 
> Xorg and our process are calling ttm_bo_mem_force_space concurrently, 
> but I don't think we have enough information yet to say for 
> sure. Reverting this commit does not fix that issue. I have some small 
> amount of evidence indicating that bos flagged for CPU access are 
> getting placed in CPU inaccessible memory. Could that cause this sort 
> of kernel lockup?
>
> Thanks for your help.
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------8640DDB2470F0614B0A2E787
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">Understood -- I thought you might not want
        to take this patch, but I went ahead and sent it out because
        Christian requested it, and it seems like he doesn't think VRAM
        bos should ever evict back to VRAM at all?</blockquote>
      No, I've requested reverting the patch for now because it causes
      an obviously and rather severe problem. If you guys can quickly
      find how to fix it feel free to use that instead.<br>
      <br>
      <blockquote type="cite">
        <div>Is my understanding of the original commit correct in that
          it tries to rewrite the eviction placements of CPU accessible
          bos so that they are either size zero (fpfn and lpfn = start
          of inaccessible VRAM) or they are in inaccessible VRAM (fpfn =
          start of inaccessible VRAM and lpfn = 0)?</div>
      </blockquote>
      That for example could work as well, but see below.<br>
      <br>
      <blockquote type="cite">
        <div>if these sorts of evictions are desirable, would it make
          more sense to treat CPU inaccessible/accessible VRAM as
          distinct entities with their own lrus?</div>
      </blockquote>
      Actually I'm pretty sure that it isn't desirable. See the evict
      function doesn't know if we try to evict BOs because we need CPU
      accessible VRAM or if we just run out of VRAM.<br>
      <br>
      This code only makes sense when we need to move different BOs into
      the CPU accessible part round robin because they are accessed by
      the CPU, but then it is actually better to move them to GTT sooner
      or later.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 23.03.2017 um 16:31 schrieb Zachary Michaels:<br>
    </div>
    <blockquote
cite="mid:CAOfP2NDoHof0UhQbz53N9WW8jLH3yC_e+ESrTbdd9Ldb6RYg=Q@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">Was userspace maybe
              performing concurrent CPU access to the BOs in question?</blockquote>
            <div><br>
            </div>
            <div>As far as I know Julien has demonstrated that this is
              not the case. </div>
            <div> </div>
            <blockquote class="gmail_quote" style="margin:0px 0px 0px
              0.8ex;border-left:1px solid
              rgb(204,204,204);padding-left:1ex">I hope we can find a
              better solution.</blockquote>
            <div><br>
            </div>
            <div>
              <div>Understood -- I thought you might not want to take
                this patch, but I went ahead and sent it out because
                Christian requested it, and it seems like he doesn't
                think VRAM bos should ever evict back to VRAM at all?</div>
              <div><br>
              </div>
              <div>Is my understanding of the original commit correct in
                that it tries to rewrite the eviction placements of CPU
                accessible bos so that they are either size zero (fpfn
                and lpfn = start of inaccessible VRAM) or they are in
                inaccessible VRAM (fpfn = start of inaccessible VRAM and
                lpfn = 0)?</div>
              <div><br>
              </div>
              <div>In this case, to me it seems that the simplest fix
                would be to iterate using i to rewrite all the VRAM
                placements instead of just the first one
                (rbo-&gt;placements[i] instead of
                rbo-&gt;placements[0]). In the case where <span
                  style="font-size:12.8px">RADEON_GEM_NO_CPU_ACCESS is
                  set, the second placement will be in CPU accessible
                  VRAM, and that doesn't seem correct to me as there is
                  no longer any sort of ordering for evictions.</span> (Unfortunately
                I'm not currently in a position to test whether this
                fixes our issue.) Sorry, I meant to make a note of this
                originally.</div>
              <div><br>
              </div>
              <div>Also, I don't claim to understand this code well
                enough, but I wonder: if these sorts of evictions are
                desirable, would it make more sense to treat CPU
                inaccessible/accessible VRAM as distinct entities with
                their own lrus?</div>
              <div><br>
              </div>
              <div>I should also note that we are experiencing another
                issue where the kernel locks up in similar
                circumstances. As Julien noted, we get no output, and
                the watchdogs don't seem to work. It may be the case
                that Xorg and our process are calling
                ttm_bo_mem_force_space concurrently, but I don't think
                we have enough information yet to say for
                sure. Reverting this commit does not fix that issue. I
                have some small amount of evidence indicating that bos
                flagged for CPU access are getting placed in CPU
                inaccessible memory. Could that cause this sort of
                kernel lockup?</div>
            </div>
            <div><br>
            </div>
            <div>Thanks for your help.</div>
          </div>
        </div>
      </div>
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

--------------8640DDB2470F0614B0A2E787--

--===============0890243744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0890243744==--
