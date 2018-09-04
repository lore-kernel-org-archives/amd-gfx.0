From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: two KASANs in TTM logic
Date: Tue, 4 Sep 2018 16:05:47 +0200
Message-ID: <63c23f00-92dd-2311-5dc9-21e29b3bbb8b@gmail.com>
References: <62eed98f-e37c-6a72-3553-cfd10b13e49f@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1996661711=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <62eed98f-e37c-6a72-3553-cfd10b13e49f-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis-5C7GfCeVMHo@public.gmane.org>, "Daenzer, Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1996661711==
Content-Type: multipart/alternative;
 boundary="------------076ECA0CE8B295C149C77725"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------076ECA0CE8B295C149C77725
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

The first one should already be fixed.

Not sure where the second comes from. Can you narrow that down further?

Christian.

Am 04.09.2018 um 15:46 schrieb Tom St Denis:
> First is caused by this commit while running a GL heavy application.
>
> d78c1fa0c9f815fe951fd57001acca3d35262a17 is the first bad commit
> commit d78c1fa0c9f815fe951fd57001acca3d35262a17
> Author: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> Date:   Wed Aug 29 11:59:38 2018 +0200
>
>     Revert "drm/amdgpu: move PD/PT bos on LRU again"
>
>     This reverts commit 31625ccae4464b61ec8cdb9740df848bbc857a5b.
>
>     It triggered various badness on my development machine when 
> running the
>     piglit gpu profile with radeonsi on Bonaire, looks like memory
>     corruption due to insufficiently protected list manipulations.
>
>     Signed-off-by: Michel Dänzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>     Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> :040000 040000 b7169f0cf0c7decec631751a9896a92badb67f9d 
> 42ea58f43199d26fc0c7ddcc655e6d0964b81817 M      drivers
>
> The second is caused by something between that and the tip of the 
> 4.19-rc1 amd-staging-drm-next (I haven't pinned it down yet) while 
> loading GNOME.
>
> Tom
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------076ECA0CE8B295C149C77725
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">The first one should already be fixed.<br>
      <br>
      Not sure where the second comes from. Can you narrow that down
      further?<br>
      <br>
      Christian.<br>
      <br>
      Am 04.09.2018 um 15:46 schrieb Tom St Denis:<br>
    </div>
    <blockquote type="cite"
      cite="mid:62eed98f-e37c-6a72-3553-cfd10b13e49f-5C7GfCeVMHo@public.gmane.org">First is
      caused by this commit while running a GL heavy application.
      <br>
      <br>
      d78c1fa0c9f815fe951fd57001acca3d35262a17 is the first bad commit
      <br>
      commit d78c1fa0c9f815fe951fd57001acca3d35262a17
      <br>
      Author: Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org">&lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</a>
      <br>
      Date:   Wed Aug 29 11:59:38 2018 +0200
      <br>
      <br>
          Revert "drm/amdgpu: move PD/PT bos on LRU again"
      <br>
      <br>
          This reverts commit 31625ccae4464b61ec8cdb9740df848bbc857a5b.
      <br>
      <br>
          It triggered various badness on my development machine when
      running the
      <br>
          piglit gpu profile with radeonsi on Bonaire, looks like memory
      <br>
          corruption due to insufficiently protected list manipulations.
      <br>
      <br>
          Signed-off-by: Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel.daenzer-5C7GfCeVMHo@public.gmane.org">&lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;</a>
      <br>
          Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a>
      <br>
      <br>
      :040000 040000 b7169f0cf0c7decec631751a9896a92badb67f9d
      42ea58f43199d26fc0c7ddcc655e6d0964b81817 M      drivers
      <br>
      <br>
      The second is caused by something between that and the tip of the
      4.19-rc1 amd-staging-drm-next (I haven't pinned it down yet) while
      loading GNOME.
      <br>
      <br>
      Tom
      <br>
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
    <br>
  </body>
</html>

--------------076ECA0CE8B295C149C77725--

--===============1996661711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1996661711==--
