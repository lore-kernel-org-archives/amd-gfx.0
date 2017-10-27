From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: display warnings due to recent commit
Date: Fri, 27 Oct 2017 13:48:45 +0200
Message-ID: <dddedad1-2c7b-67c8-0982-7da4b66db273@gmail.com>
References: <34eb4b13-8c81-d63e-96e5-381262c63847@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0256526963=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <34eb4b13-8c81-d63e-96e5-381262c63847-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0256526963==
Content-Type: multipart/alternative;
 boundary="------------ED403675D6A0C3634F48C6FA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------ED403675D6A0C3634F48C6FA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Looks like the DC code can't correctly take care of the difference 
between CZ and Tonga.

Harry how should we handle this? Either not set the bit on older 
hardware or fix DC to just ignore it there?

To be honest I would prefer not to set a bit at all and just always 
program the relevant bits on hardware which supports this.

Regards,
Christian.

Am 27.10.2017 um 13:25 schrieb Tom St Denis:
> The following commit:
>
> [root@fx6 linux]# git bisect good
> aa7187c5c640559ebc02caa0191c0db46b55b4a6 is the first bad commit
> commit aa7187c5c640559ebc02caa0191c0db46b55b4a6
> Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Date:   Thu Oct 26 12:00:36 2017 +0200
>
>     drm/amd/display: enable GPU VM support
>
>     Just set the bit so that DC does the hardware programming.
>
>     Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>     Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>
> :040000 040000 c6d725acce6507b6d9381667d828e8e0d4683af7 
> 2dfcfab32ef3e7d24a31eb420dd1186cf973cd7d M      drivers
>
> Results in the (attached) dmesg logs on my Tonga system.
>
> Cheers,
> Tom
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------ED403675D6A0C3634F48C6FA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Looks like the DC code can't correctly
      take care of the difference between CZ and Tonga.<br>
      <br>
      Harry how should we handle this? Either not set the bit on older
      hardware or fix DC to just ignore it there?<br>
      <br>
      To be honest I would prefer not to set a bit at all and just
      always program the relevant bits on hardware which supports this.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 27.10.2017 um 13:25 schrieb Tom St Denis:<br>
    </div>
    <blockquote type="cite"
      cite="mid:34eb4b13-8c81-d63e-96e5-381262c63847-5C7GfCeVMHo@public.gmane.org">The
      following commit:
      <br>
      <br>
      [root@fx6 linux]# git bisect good
      <br>
      aa7187c5c640559ebc02caa0191c0db46b55b4a6 is the first bad commit
      <br>
      commit aa7187c5c640559ebc02caa0191c0db46b55b4a6
      <br>
      Author: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
      <br>
      Date:   Thu Oct 26 12:00:36 2017 +0200
      <br>
      <br>
          drm/amd/display: enable GPU VM support
      <br>
      <br>
          Just set the bit so that DC does the hardware programming.
      <br>
      <br>
          Signed-off-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>
      <br>
          Reviewed-by: Andrey Grodzovsky
      <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org">&lt;andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;</a>
      <br>
      <br>
      :040000 040000 c6d725acce6507b6d9381667d828e8e0d4683af7
      2dfcfab32ef3e7d24a31eb420dd1186cf973cd7d M      drivers
      <br>
      <br>
      Results in the (attached) dmesg logs on my Tonga system.
      <br>
      <br>
      Cheers,
      <br>
      Tom
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

--------------ED403675D6A0C3634F48C6FA--

--===============0256526963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0256526963==--
