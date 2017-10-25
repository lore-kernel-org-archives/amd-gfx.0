From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: KASAN use-after-free report during piglit run
Date: Wed, 25 Oct 2017 17:51:30 +0200
Message-ID: <bb31e238-502c-eda7-5bcb-302ef6c04c15@gmail.com>
References: <e9df6a9b-19bc-4b2f-eeb2-a06ebb2f22c2@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2119625592=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e9df6a9b-19bc-4b2f-eeb2-a06ebb2f22c2-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============2119625592==
Content-Type: multipart/alternative;
 boundary="------------0719DE9E814DF0ECCE27F0EA"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0719DE9E814DF0ECCE27F0EA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Going to take a look tomorrow.

Christian.

Am 25.10.2017 um 17:43 schrieb Michel Dänzer:
> KASAN caught another use-after-free on my development machine today, see
> the attached dmesg excerpt. There haven't been any related changes in
> amd-staging-drm-next since yesterday, so maybe userspace is just
> tickling the kernel differently (e.g. piglit runs some more tests in
> parallel now). It's not reproducible every time, but it just happened a
> second time (with an amd-staging-drm-next commit from about a week ago).
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------0719DE9E814DF0ECCE27F0EA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Going to take a look tomorrow.<br>
      <br>
      Christian.<br>
      <br>
      Am 25.10.2017 um 17:43 schrieb Michel Dänzer:<br>
    </div>
    <blockquote type="cite"
      cite="mid:e9df6a9b-19bc-4b2f-eeb2-a06ebb2f22c2-otUistvHUpPR7s880joybQ@public.gmane.org">
      <pre wrap="">
KASAN caught another use-after-free on my development machine today, see
the attached dmesg excerpt. There haven't been any related changes in
amd-staging-drm-next since yesterday, so maybe userspace is just
tickling the kernel differently (e.g. piglit runs some more tests in
parallel now). It's not reproducible every time, but it just happened a
second time (with an amd-staging-drm-next commit from about a week ago).


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
    <p><br>
    </p>
  </body>
</html>

--------------0719DE9E814DF0ECCE27F0EA--

--===============2119625592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2119625592==--
