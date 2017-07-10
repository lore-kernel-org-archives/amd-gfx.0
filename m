From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Regression in amd-staging-4.11
Date: Mon, 10 Jul 2017 09:55:00 -0400
Message-ID: <68b41ca7-d86b-62b4-ca50-03feacfeb712@amd.com>
References: <932178.77331.1499684449106@mailxchange.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2013574183=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <932178.77331.1499684449106-NM1PAhYDU/Oo9dU1Uvar1Q@public.gmane.org>
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
To: Martin Babutzka <martin.babutzka-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============2013574183==
Content-Type: multipart/alternative;
 boundary="------------49C956D8764AD3055FEFB695"

This is a multi-part message in MIME format.
--------------49C956D8764AD3055FEFB695
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the info, is it possible to provide dmesg log for this issue ?


On 07/10/2017 07:00 AM, Martin Babutzka wrote:
>
> Dear AMD graphics developers,
>
> I am one of the guys that regularly builds your amd-staging kernels and
> makes them available for the lazier people. By this we get a nice
> preview of DAL/DC and you get some free beta-testers.
>
> One of the users describe a regression here:
> https://github.com/M-Bab/linux-kernel-amdgpu-binaries/issues/8
>
> Unfortunately the bug details are limited but I can give some
> additional information to pin the bug down:
> All kernels <= 4.11.3+ (merged with amd-staging-4.11 at Fri May 26
> 18:19:03 2017 +0200) are reported to be working and the regression was
> introduced with the kernels >= 4.11.4+ (merged with amd-staging-4.11 at
> Thu Jun 8 19:44:44 2017 +0200). I attached a list of your commits that
> were merged in this time range. The other attachment is an X.org log
> with the trace when amdgpu should be loaded to run a R7 370 GPU.
> The kernel based on amd-staging-4.9 is not affected.
>
> I hope this helps you to find the regression. Just tell me if I can
> provide further details or testing.
>
> Kind regards,
> Martin Babutzka
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------49C956D8764AD3055FEFB695
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>Thanks for the info, is it possible to provide dmesg log for this
      issue ?<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 07/10/2017 07:00 AM, Martin Babutzka
      wrote:<br>
    </div>
    <blockquote cite="mid:932178.77331.1499684449106-NM1PAhYDU/Oo9dU1Uvar1Q@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <p>Dear AMD graphics developers,</p>
      <p>I am one of the guys that regularly builds your amd-staging
        kernels and<br>
        makes them available for the lazier people. By this we get a
        nice<br>
        preview of DAL/DC and you get some free beta-testers.</p>
      <p>One of the users describe a regression here:<br>
        <a moz-do-not-send="true"
          href="https://github.com/M-Bab/linux-kernel-amdgpu-binaries/issues/8">https://github.com/M-Bab/linux-kernel-amdgpu-binaries/issues/8</a><br>
      </p>
      <p>Unfortunately the bug details are limited but I can give some<br>
        additional information to pin the bug down:<br>
        All kernels &lt;= 4.11.3+ (merged with amd-staging-4.11 at Fri
        May 26<br>
        18:19:03 2017 +0200) are reported to be working and the
        regression was<br>
        introduced with the kernels &gt;= 4.11.4+ (merged with
        amd-staging-4.11 at<br>
        Thu Jun 8 19:44:44 2017 +0200). I attached a list of your
        commits that<br>
        were merged in this time range. The other attachment is an X.org
        log<br>
        with the trace when amdgpu should be loaded to run a R7 370 GPU.<br>
        The kernel based on amd-staging-4.9 is not affected.</p>
      <p>I hope this helps you to find the regression. Just tell me if I
        can<br>
        provide further details or testing.</p>
      <p>Kind regards,<br>
        Martin Babutzka</p>
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

--------------49C956D8764AD3055FEFB695--

--===============2013574183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2013574183==--
