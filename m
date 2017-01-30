From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH libdrm 0/3] some -pro patches for integration
Date: Mon, 30 Jan 2017 09:38:13 +0100
Message-ID: <0bc5373b-854a-8a31-c503-4b73a63bd1f2@vodafone.de>
References: <1485632972-4790-1-git-send-email-notasas@gmail.com>
 <d25c24a2-e1d1-f8a8-f4e7-e91948f81e01@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1787586068=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d25c24a2-e1d1-f8a8-f4e7-e91948f81e01-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1787586068==
Content-Type: multipart/alternative;
 boundary="------------5F8A088DA4E66D0619E05C28"

This is a multi-part message in MIME format.
--------------5F8A088DA4E66D0619E05C28
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Am 29.01.2017 um 23:51 schrieb Edward O'Callaghan:
> This series is,
> Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>
> On 01/29/2017 06:49 AM, Grazvydas Ignotas wrote:
>> I've taken several patches from amdgpu-pro libdrm that look useful
>> to me and I think can be applied already. The only things I did was
>> rebasing, fixing some typos and dropping Change-Id.
>>
>> Alex Xie (3):
>>    amdgpu: Free/uninit vamgr_32 in theoretically correct order
>>    amdgpu: vamgr can be a struct instead of a pointer
>>    amdgpu: vamgr_32 can be a struct instead of a pointer
>>
>>   amdgpu/amdgpu_device.c   | 24 +++++++-----------------
>>   amdgpu/amdgpu_internal.h |  4 ++--
>>   amdgpu/amdgpu_vamgr.c    |  6 +++---
>>   3 files changed, 12 insertions(+), 22 deletions(-)
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------5F8A088DA4E66D0619E05C28
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
      <br>
      Am 29.01.2017 um 23:51 schrieb Edward O'Callaghan:<br>
    </div>
    <blockquote
      cite="mid:d25c24a2-e1d1-f8a8-f4e7-e91948f81e01-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">This series is,
Reviewed-by: Edward O'Callaghan <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;</a>

On 01/29/2017 06:49 AM, Grazvydas Ignotas wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">I've taken several patches from amdgpu-pro libdrm that look useful
to me and I think can be applied already. The only things I did was
rebasing, fixing some typos and dropping Change-Id.

Alex Xie (3):
  amdgpu: Free/uninit vamgr_32 in theoretically correct order
  amdgpu: vamgr can be a struct instead of a pointer
  amdgpu: vamgr_32 can be a struct instead of a pointer

 amdgpu/amdgpu_device.c   | 24 +++++++-----------------
 amdgpu/amdgpu_internal.h |  4 ++--
 amdgpu/amdgpu_vamgr.c    |  6 +++---
 3 files changed, 12 insertions(+), 22 deletions(-)

</pre>
      </blockquote>
      <pre wrap="">
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

--------------5F8A088DA4E66D0619E05C28--

--===============1787586068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1787586068==--
