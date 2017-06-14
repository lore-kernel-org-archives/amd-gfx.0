From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Question about porting VCE1 to amdgpu
Date: Wed, 14 Jun 2017 18:37:01 +0200
Message-ID: <c3b779e6-3a65-770d-5ba5-40cd293ded3e@vodafone.de>
References: <CAPEhTTGyy4jehNXhe93h=kB29ThOxctWzuaiwrfjkyDVu5wMww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0994883641=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPEhTTGyy4jehNXhe93h=kB29ThOxctWzuaiwrfjkyDVu5wMww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0994883641==
Content-Type: multipart/alternative;
 boundary="------------903F2BB307729213D73BB00B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------903F2BB307729213D73BB00B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

> - Would we need a different firmware version with a different "hdr" 
> for the amdgpu driver?
Yes, we should probably release the latest one instead of reusing the 
one used with radeon.

BTW: Does VCE work on CIK? Alex, don't we run into the same issue there 
as well?

> - Wouldn't it be better to continue loading the driver while having 
> VCE disabled IF we fail when loading or validating the FW? Completely 
> failing to load the driver for this reason seems overkill IMO, since 
> nothing has been loaded in memory and no registry have been modified 
> up to that point.
UVD and VCE are actually needed for correct power management. When the 
blocks fail to initialize you usually sooner or later run into problems 
with power management (e.g. stuck inside a certain power level).

> - Would it be a good idea to send a patch as a RFC so some of you 
> could help me finish the job and maybe pinpoint where the last 
> modifications need to be done?
Well you could, but to be honest without AMD releasing new firmware that 
is most likely a futile effort.

Regards,
Christian.

Am 14.06.2017 um 18:22 schrieb Alexandre Demers:
> Hi,
>
> I've been working on porting VCE1 from radeon to amdgpu in the last 
> few weeks. I'm pretty much done and I've enabled the functionality to 
> see how it goes. However, I ended up with an error on the firmware 
> validation (size doesn't seem to fit), thus failing completely in 
> loading the driver. I'm testing on a R9 280X (Tahiti).
>
> Three questions then:
> - Would we need a different firmware version with a different "hdr" 
> for the amdgpu driver?
> - Wouldn't it be better to continue loading the driver while having 
> VCE disabled IF we fail when loading or validating the FW? Completely 
> failing to load the driver for this reason seems overkill IMO, since 
> nothing has been loaded in memory and no registry have been modified 
> up to that point.
> - Would it be a good idea to send a patch as a RFC so some of you 
> could help me finish the job and maybe pinpoint where the last 
> modifications need to be done?
>
> Thank you!
> Alexandre Demers
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------903F2BB307729213D73BB00B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">- Would we need a different firmware
        version with a different "hdr" for the amdgpu driver?</blockquote>
      Yes, we should probably release the latest one instead of reusing
      the one used with radeon.<br>
      <br>
      BTW: Does VCE work on CIK? Alex, don't we run into the same issue
      there as well?<br>
      <br>
      <blockquote type="cite">
        <div>- Wouldn't it be better to continue loading the driver
          while having VCE disabled IF we fail when loading or
          validating the FW? Completely failing to load the driver for
          this reason seems overkill IMO, since nothing has been loaded
          in memory and no registry have been modified up to that point.</div>
      </blockquote>
      UVD and VCE are actually needed for correct power management. When
      the blocks fail to initialize you usually sooner or later run into
      problems with power management (e.g. stuck inside a certain power
      level).<br>
      <br>
      <blockquote type="cite">
        <div>- Would it be a good idea to send a patch as a RFC so some
          of you could help me finish the job and maybe pinpoint where
          the last modifications need to be done?</div>
      </blockquote>
      Well you could, but to be honest without AMD releasing new
      firmware that is most likely a futile effort.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 14.06.2017 um 18:22 schrieb Alexandre Demers:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPEhTTGyy4jehNXhe93h=kB29ThOxctWzuaiwrfjkyDVu5wMww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">Hi,
        <div><br>
        </div>
        <div>I've been working on porting VCE1 from radeon to amdgpu in
          the last few weeks. I'm pretty much done and I've enabled the
          functionality to see how it goes. However, I ended up with an
          error on the firmware validation (size doesn't seem to fit),
          thus failing completely in loading the driver. I'm testing on
          a R9 280X (Tahiti).</div>
        <div><br>
        </div>
        <div>Three questions then:</div>
        <div>- Would we need a different firmware version with a
          different "hdr" for the amdgpu driver?</div>
        <div>- Wouldn't it be better to continue loading the driver
          while having VCE disabled IF we fail when loading or
          validating the FW? Completely failing to load the driver for
          this reason seems overkill IMO, since nothing has been loaded
          in memory and no registry have been modified up to that point.</div>
        <div>- Would it be a good idea to send a patch as a RFC so some
          of you could help me finish the job and maybe pinpoint where
          the last modifications need to be done?</div>
        <div><br>
        </div>
        <div>Thank you!</div>
        <div>Alexandre Demers</div>
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

--------------903F2BB307729213D73BB00B--

--===============0994883641==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0994883641==--
