From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Adjusting memory speed according to display
Date: Fri, 12 Aug 2016 09:32:55 +0200
Message-ID: <0adc3acc-ea5e-bed1-f903-634eddda25a2@vodafone.de>
References: <DB3PR08MB0281EA56C2099894FA675529E91F0@DB3PR08MB0281.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1477712540=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DB3PR08MB0281EA56C2099894FA675529E91F0-aD6Q2MAZY6U/irYQV7fBLikoKrxaZxrJvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: Jarkko Korpi <jarkko_korpi-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1477712540==
Content-Type: multipart/alternative;
 boundary="------------3D92A5E052BE8234E8C4665B"

This is a multi-part message in MIME format.
--------------3D92A5E052BE8234E8C4665B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

To output audio over HDMI you need to output a video signal as well.

This creates additional pressure on the memory bandwith because the 
hardware now needs to handle two video signals instead of one.

You need to connect your screen to the output of the amplifier to avoid 
this.

Regards,
Christian.

Am 12.08.2016 um 03:45 schrieb Jarkko Korpi:
>
> I have rx480 which I connect into 1920x1080 pc screen via DP and audio 
> into external amplifier via HDMI. This causes rx480 to raise the 
> memory speed to 2000 while doing really simple tasks like watching 
> youtube. I really dont need thatkind of speed for memory. And I am not 
> aware that it's possible to change between 300mhz 2000mhz memory 
> speeds, but gpu supports this in steps which would be really great for 
> memory too. I only need the audio data submited to the amplifier. Is 
> it possible somehow to form a patch that it somehow recognizes my 
> amplifier and understands that I am sending audio that I dont 
> need/want it to max the memory speed? I would be really happy for such 
> patch for personal use. If it's too hacky to be merged into upstream.
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------3D92A5E052BE8234E8C4665B
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">To output audio over HDMI you need to
      output a video signal as well.<br>
      <br>
      This creates additional pressure on the memory bandwith because
      the hardware now needs to handle two video signals instead of one.<br>
      <br>
      You need to connect your screen to the output of the amplifier to
      avoid this.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 12.08.2016 um 03:45 schrieb Jarkko Korpi:<br>
    </div>
    <blockquote
cite="mid:DB3PR08MB0281EA56C2099894FA675529E91F0-aD6Q2MAZY6U/irYQV7fBLikoKrxaZxrJvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>I have rx480 which I connect into 1920x1080 pc screen via DP
          and audio into external amplifier via HDMI. This causes rx480
          to raise the memory speed to 2000 while doing really simple
          tasks like watching youtube. I really dont need thatkind of
          speed for memory. And I am not aware that it's possible to
          change between 300mhz 2000mhz memory speeds, but gpu supports
          this in steps which would be really great for memory too. I
          only need the audio data submited to the amplifier. Is it
          possible somehow to form a patch that it somehow recognizes my
          amplifier and understands that I am sending audio that I dont
          need/want it to max the memory speed? I would be really happy
          for such patch for personal use. If it's too hacky to be
          merged into upstream.<br>
        </p>
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

--------------3D92A5E052BE8234E8C4665B--

--===============1477712540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1477712540==--
