Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF36CC5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 08:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC7B1132C1;
	Fri,  8 Mar 2024 08:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yonsei.ac.kr header.i=@yonsei.ac.kr header.b="PTG/l9JX";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA4A710F67B
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 01:18:32 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-609f1b77728so13723587b3.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Mar 2024 17:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yonsei.ac.kr; s=google; t=1709860712; x=1710465512;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xt5WAG+4hJ6ULM9okRDGY2ZPZVXn/3ChZW6R2yGPgbs=;
 b=PTG/l9JXZhGuZpSG/7rkejgCBa6C9SCV2M+T1gHpft3MSO4Q4B667N5mGk4icyFm5A
 nNlZTHSwYBB18MMnITClvTpr6UKGPCRTC+4XVhqG/j0Q4tG9YShIAsooTnSqGahIHbi1
 BRRfuAQgSdekc/beFV/94xX3Yt4eUKIFlmISig/6ShjlVTbLbAUF+p+xD4kdrKnbcVKs
 qNUk2yrpAn31SR66EIbLFJr2IW3iGYADlemUMJtJpIu1aLp7Z9jDWVd7LwaRs5lmobDE
 mswnc119iROV1mh4MaBs56NGaevdT+nVqm7kPOCZpKUUg0HGTxEO2rZy5uo8NDM5QzQo
 gm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709860712; x=1710465512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xt5WAG+4hJ6ULM9okRDGY2ZPZVXn/3ChZW6R2yGPgbs=;
 b=H9Dp+Hc5oyhFm58wWJndnVj0WFuNGmFQovCKveUyq1TqvZAqM8z9LvO8KAZOPAigyi
 l/lS/0MNaxD5cWf24QbBIfC3zM2MnIpVxlytVDX1X5iVWzUM0f8vrKfCGwQy/kuBQHDN
 OIjkmRpi8u+QfLyW2uXIq7udyYWO5BEljJfXlSOlUpxukTmbJzhPfbhkv0255A/bDaq+
 kG3LLIENCTAdpkc8QQAC37EHjix/TRwdJ7QRNDLiwnI2zi2RyCqKL0C/hZOhiofi8r3u
 Po56pxpj3b+ui/RMSrEtzpRO/DEG8KjtPBQp9a0bNUD/0FKoebxS88LuzYmLjTjEWvWQ
 hbfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5oXqiXnZ9Y5+TLq7XCY1Ekw002ey8ZSioMfmlaEb82dRQ7I9D99TFPlBoOUGYTpMyeKuQMPao+qqW08/dMDHW5Vi9ixR5SN9zYSKjvA==
X-Gm-Message-State: AOJu0YwzeiUY4eahvLTHaPYvugIwecDKXnbjEb2sJt+NXCeBFdUwQVMh
 Cp9mm+7gLfSGkinBrgjStwrRlGbUhJsl8z2fBikq6QstEL2MFLud4G2SC1cKRz7zN3q3sqCVXpC
 uBq+oHPhTPPlpSTI/1y+MsSkPzd+7qUTAbVWmAQ==
X-Google-Smtp-Source: AGHT+IHBOLy2i1cKdrhkISuluK31U1Gdl33vay9w0RoeJe9aBrX2CoRisABiIQYugIpAeip5Tex7X786dXM1HVAKPeM=
X-Received: by 2002:a81:a088:0:b0:60a:568:2928 with SMTP id
 x130-20020a81a088000000b0060a05682928mr131746ywg.14.1709860711902; Thu, 07
 Mar 2024 17:18:31 -0800 (PST)
MIME-Version: 1.0
References: <CAKc8oVUXUHUYQSDYDZ3XqpfwcmOwoxii5+SkyteXoZSPRwshfQ@mail.gmail.com>
In-Reply-To: <CAKc8oVUXUHUYQSDYDZ3XqpfwcmOwoxii5+SkyteXoZSPRwshfQ@mail.gmail.com>
From: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
Date: Fri, 8 Mar 2024 10:18:21 +0900
Message-ID: <CAKc8oVU8C-MRVa640603R2Gi7BRZ5P8ZN_uJoruDzR_A8xg71Q@mail.gmail.com>
Subject: Re: Reporting a slab-use-after-free in amdgpu
To: Xinhui.Pan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: Dokyung Song <dokyungs@yonsei.ac.kr>, amd-gfx@lists.freedesktop.org, 
 jisoo.jang@yonsei.ac.kr, vitaly prosyak <vprosyak@amd.com>, 
 "yw9865@gmail.com" <yw9865@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000594c9a06131bf8be"
X-Mailman-Approved-At: Fri, 08 Mar 2024 08:26:38 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000594c9a06131bf8be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
thank you for patching the first bug we have sent!

Just a quick touch base with you, to ask if there has been any update on
our other two bugs.
They were each sent with emails titled
"Reporting a slab-use-after-free in amdgpu" (this one)
"Reporting a null-ptr-deref in amdgpu".

Thank you!

Best,
Joonkyo


2024=EB=85=84 2=EC=9B=94 16=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:22, J=
oonkyo Jung <joonkyoj@yonsei.ac.kr>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> Hello,
>
> We would like to report a slab-use-after-free bug in the AMDGPU DRM drive=
r
> in the linux kernel v6.8-rc4 that we found with our customized Syzkaller.
> The bug can be triggered by sending two ioctls to the AMDGPU DRM driver i=
n
> succession.
>
> In amdgpu_bo_move, struct ttm_resource *old_mem =3D bo->resource is assig=
ned.
> As you can see on the alloc & free stack calls, on the same function
> amdgpu_bo_move,
> amdgpu_move_blit in the end frees bo->resource at
> ttm_bo_move_accel_cleanup with ttm_bo_wait_free_node(bo, man->use_tt).
> But amdgpu_bo_move continues after that, reaching
> trace_amdgpu_bo_move(abo, new_mem->mem_type, old_mem->mem_type) at the en=
d,
> causing the use-after-free bug.
>
> Steps to reproduce are as below.
> union drm_amdgpu_gem_create *arg1;
>
> arg1 =3D malloc(sizeof(union drm_amdgpu_gem_create));
> arg1->in.bo_size =3D 0x8;
> arg1->in.alignment =3D 0x0;
> arg1->in.domains =3D 0x4;
> arg1->in.domain_flags =3D 0x9;
> ioctl(fd, 0xc0206440, arg1);
>
> arg1->in.bo_size =3D 0x7fffffff;
> arg1->in.alignment =3D 0x0;
> arg1->in.domains =3D 0x4;
> arg1->in.domain_flags =3D 0x9;
> ioctl(fd, 0xc0206440, arg1);
>
> The KASAN report is as follows:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in amdgpu_bo_move+0x1479/0x1550
> Read of size 4 at addr ffff88800f5bee80 by task syz-executor/219
> Call Trace:
>  <TASK>
>  amdgpu_bo_move+0x1479/0x1550
>  ttm_bo_handle_move_mem+0x4d0/0x700
>  ttm_mem_evict_first+0x945/0x1230
>  ttm_bo_mem_space+0x6c7/0x940
>  ttm_bo_validate+0x286/0x650
>  ttm_bo_init_reserved+0x34c/0x490
>  amdgpu_bo_create+0x94b/0x1610
>  amdgpu_bo_create_user+0xa3/0x130
>  amdgpu_gem_create_ioctl+0x4bc/0xc10
>  drm_ioctl_kernel+0x300/0x410
>  drm_ioctl+0x648/0xb30
>  amdgpu_drm_ioctl+0xc8/0x160
>  </TASK>
>
> Allocated by task 219:
>  kmalloc_trace+0x211/0x390
>  amdgpu_vram_mgr_new+0x1d6/0xbe0
>  ttm_resource_alloc+0xfd/0x1e0
>  ttm_bo_mem_space+0x255/0x940
>  ttm_bo_validate+0x286/0x650
>  ttm_bo_init_reserved+0x34c/0x490
>  amdgpu_bo_create+0x94b/0x1610
>  amdgpu_bo_create_user+0xa3/0x130
>  amdgpu_gem_create_ioctl+0x4bc/0xc10
>  drm_ioctl_kernel+0x300/0x410
>  drm_ioctl+0x648/0xb30
>  amdgpu_drm_ioctl+0xc8/0x160
>
> Freed by task 219:
>  kfree+0x111/0x2d0
>  ttm_resource_free+0x17e/0x1e0
>  ttm_bo_move_accel_cleanup+0x77e/0x9b0
>  amdgpu_move_blit+0x3db/0x670
>  amdgpu_bo_move+0xfa2/0x1550
>  ttm_bo_handle_move_mem+0x4d0/0x700
>  ttm_mem_evict_first+0x945/0x1230
>  ttm_bo_mem_space+0x6c7/0x940
>  ttm_bo_validate+0x286/0x650
>  ttm_bo_init_reserved+0x34c/0x490
>  amdgpu_bo_create+0x94b/0x1610
>  amdgpu_bo_create_user+0xa3/0x130
>  amdgpu_gem_create_ioctl+0x4bc/0xc10
>  drm_ioctl_kernel+0x300/0x410
>  drm_ioctl+0x648/0xb30
>  amdgpu_drm_ioctl+0xc8/0x160
>
> The buggy address belongs to the object at ffff88800f5bee70
>  which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 16 bytes inside of
>  freed 96-byte region [ffff88800f5bee70, ffff88800f5beed0)
>
> Should you need any more information, please do not hesitate to contact u=
s.
>
> Best regards,
> Joonkyo Jung
>

--000000000000594c9a06131bf8be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div><div dir=3D"auto" style=3D"font-family:&#39;-apple-system&#39;,&#=
39;helveticaneue&#39;;font-size:15px;font-style:normal;font-weight:400;lett=
er-spacing:normal;text-indent:0px;text-transform:none;white-space:normal;wo=
rd-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-c=
olor:rgb(0,0,0);color:rgb(0,0,0)">Hello,=C2=A0</div><div dir=3D"auto" style=
=3D"font-family:&#39;-apple-system&#39;,&#39;helveticaneue&#39;;font-size:1=
5px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:no=
ne;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"=
>thank you for patching the first bug we have sent!</div><div dir=3D"auto" =
style=3D"font-family:&#39;-apple-system&#39;,&#39;helveticaneue&#39;;font-s=
ize:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorati=
on:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,=
0,0)"><br></div><div dir=3D"auto" style=3D"font-family:&#39;-apple-system&#=
39;,&#39;helveticaneue&#39;;font-size:15px;font-style:normal;font-weight:40=
0;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:nor=
mal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);bo=
rder-color:rgb(0,0,0);color:rgb(0,0,0)">Just a quick touch base with you, t=
o ask if there has been any update on our other two bugs.</div><div dir=3D"=
auto" style=3D"font-family:&#39;-apple-system&#39;,&#39;helveticaneue&#39;;=
font-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-de=
coration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:=
rgb(0,0,0)">They were each sent with emails titled=C2=A0</div><div dir=3D"a=
uto" style=3D"font-family:&#39;-apple-system&#39;,&#39;helveticaneue&#39;;f=
ont-size:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;text-dec=
oration:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:r=
gb(0,0,0)">&quot;Reporting a slab-use-after-free in amdgpu&quot; (this one)=
</div><div dir=3D"auto" style=3D"font-family:&#39;-apple-system&#39;,&#39;h=
elveticaneue&#39;;font-size:15px;font-style:normal;font-weight:400;letter-s=
pacing:normal;text-indent:0px;text-transform:none;white-space:normal;word-s=
pacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);border-color=
:rgb(0,0,0);color:rgb(0,0,0)">&quot;Reporting a null-ptr-deref in amdgpu&qu=
ot;.=C2=A0</div><div dir=3D"auto" style=3D"font-family:&#39;-apple-system&#=
39;,&#39;helveticaneue&#39;;font-size:15px;font-style:normal;font-weight:40=
0;letter-spacing:normal;text-indent:0px;text-transform:none;white-space:nor=
mal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,0,0);bo=
rder-color:rgb(0,0,0);color:rgb(0,0,0)"><br></div><div dir=3D"auto" style=
=3D"font-family:&#39;-apple-system&#39;,&#39;helveticaneue&#39;;font-size:1=
5px;font-style:normal;font-weight:400;letter-spacing:normal;text-indent:0px=
;text-transform:none;white-space:normal;word-spacing:0px;text-decoration:no=
ne;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"=
>Thank you!=C2=A0</div><div dir=3D"auto" style=3D"font-family:&#39;-apple-s=
ystem&#39;,&#39;helveticaneue&#39;;font-size:15px;font-style:normal;font-we=
ight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,=
0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)"><br></div><div dir=3D"auto" =
style=3D"font-family:&#39;-apple-system&#39;,&#39;helveticaneue&#39;;font-s=
ize:15px;font-style:normal;font-weight:400;letter-spacing:normal;text-inden=
t:0px;text-transform:none;white-space:normal;word-spacing:0px;text-decorati=
on:none;background-color:rgba(0,0,0,0);border-color:rgb(0,0,0);color:rgb(0,=
0,0)">Best,=C2=A0</div><div dir=3D"auto" style=3D"font-family:&#39;-apple-s=
ystem&#39;,&#39;helveticaneue&#39;;font-size:15px;font-style:normal;font-we=
ight:400;letter-spacing:normal;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;text-decoration:none;background-color:rgba(0,0,=
0,0);border-color:rgb(0,0,0);color:rgb(0,0,0)">Joonkyo</div></div><br></div=
><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=
2024=EB=85=84 2=EC=9B=94 16=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:22, J=
oonkyo Jung &lt;<a href=3D"mailto:joonkyoj@yonsei.ac.kr">joonkyoj@yonsei.ac=
.kr</a>&gt;=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"ltr">Hello,<br><br>We would like to report a sla=
b-use-after-free bug in the AMDGPU DRM driver in the linux kernel v6.8-rc4 =
that we found with our customized Syzkaller.<br>The bug can be triggered by=
 sending two ioctls to the AMDGPU DRM driver in succession.<br><br>In amdgp=
u_bo_move, struct ttm_resource *old_mem =3D bo-&gt;resource is assigned.<br=
>As you can see on the alloc &amp; free stack calls, on the same function a=
mdgpu_bo_move,<br>amdgpu_move_blit in the end frees bo-&gt;resource at ttm_=
bo_move_accel_cleanup with ttm_bo_wait_free_node(bo, man-&gt;use_tt).<br>Bu=
t amdgpu_bo_move continues after that, reaching trace_amdgpu_bo_move(abo, n=
ew_mem-&gt;mem_type, old_mem-&gt;mem_type) at the end, causing the use-afte=
r-free bug.<br><br>Steps to reproduce are as below.<br>union drm_amdgpu_gem=
_create *arg1;<br><br>arg1 =3D malloc(sizeof(union drm_amdgpu_gem_create));=
<br>arg1-&gt;in.bo_size =3D 0x8;<br>arg1-&gt;in.alignment =3D 0x0;<br>arg1-=
&gt;in.domains =3D 0x4;<br>arg1-&gt;in.domain_flags =3D 0x9;<br>ioctl(fd, 0=
xc0206440, arg1);<br><br>arg1-&gt;in.bo_size =3D 0x7fffffff;<br>arg1-&gt;in=
.alignment =3D 0x0;<br>arg1-&gt;in.domains =3D 0x4;<br>arg1-&gt;in.domain_f=
lags =3D 0x9;<br>ioctl(fd, 0xc0206440, arg1);<br><br>The KASAN report is as=
 follows:<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>BUG: KAS=
AN: slab-use-after-free in amdgpu_bo_move+0x1479/0x1550<br>Read of size 4 a=
t addr ffff88800f5bee80 by task syz-executor/219<br>Call Trace:<br>=C2=A0&l=
t;TASK&gt;<br>=C2=A0amdgpu_bo_move+0x1479/0x1550<br>=C2=A0ttm_bo_handle_mov=
e_mem+0x4d0/0x700<br>=C2=A0ttm_mem_evict_first+0x945/0x1230<br>=C2=A0ttm_bo=
_mem_space+0x6c7/0x940<br>=C2=A0ttm_bo_validate+0x286/0x650<br>=C2=A0ttm_bo=
_init_reserved+0x34c/0x490<br>=C2=A0amdgpu_bo_create+0x94b/0x1610<br>=C2=A0=
amdgpu_bo_create_user+0xa3/0x130<br>=C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc=
10<br>=C2=A0drm_ioctl_kernel+0x300/0x410<br>=C2=A0drm_ioctl+0x648/0xb30<br>=
=C2=A0amdgpu_drm_ioctl+0xc8/0x160<br>=C2=A0&lt;/TASK&gt;<br><br>Allocated b=
y task 219:<br>=C2=A0kmalloc_trace+0x211/0x390<br>=C2=A0amdgpu_vram_mgr_new=
+0x1d6/0xbe0<br>=C2=A0ttm_resource_alloc+0xfd/0x1e0<br>=C2=A0ttm_bo_mem_spa=
ce+0x255/0x940<br>=C2=A0ttm_bo_validate+0x286/0x650<br>=C2=A0ttm_bo_init_re=
served+0x34c/0x490<br>=C2=A0amdgpu_bo_create+0x94b/0x1610<br>=C2=A0amdgpu_b=
o_create_user+0xa3/0x130<br>=C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10<br>=
=C2=A0drm_ioctl_kernel+0x300/0x410<br>=C2=A0drm_ioctl+0x648/0xb30<br>=C2=A0=
amdgpu_drm_ioctl+0xc8/0x160<br><br>Freed by task 219:<br>=C2=A0kfree+0x111/=
0x2d0<br>=C2=A0ttm_resource_free+0x17e/0x1e0<br>=C2=A0ttm_bo_move_accel_cle=
anup+0x77e/0x9b0<br>=C2=A0amdgpu_move_blit+0x3db/0x670<br>=C2=A0amdgpu_bo_m=
ove+0xfa2/0x1550<br>=C2=A0ttm_bo_handle_move_mem+0x4d0/0x700<br>=C2=A0ttm_m=
em_evict_first+0x945/0x1230<br>=C2=A0ttm_bo_mem_space+0x6c7/0x940<br>=C2=A0=
ttm_bo_validate+0x286/0x650<br>=C2=A0ttm_bo_init_reserved+0x34c/0x490<br>=
=C2=A0amdgpu_bo_create+0x94b/0x1610<br>=C2=A0amdgpu_bo_create_user+0xa3/0x1=
30<br>=C2=A0amdgpu_gem_create_ioctl+0x4bc/0xc10<br>=C2=A0drm_ioctl_kernel+0=
x300/0x410<br>=C2=A0drm_ioctl+0x648/0xb30<br>=C2=A0amdgpu_drm_ioctl+0xc8/0x=
160<br><br>The buggy address belongs to the object at ffff88800f5bee70<br>=
=C2=A0which belongs to the cache kmalloc-96 of size 96<br>The buggy address=
 is located 16 bytes inside of<br>=C2=A0freed 96-byte region [ffff88800f5be=
e70, ffff88800f5beed0)<br><br>Should you need any more information, please =
do not hesitate to contact us.<br><br>Best regards,<br>Joonkyo Jung<br></di=
v>
</blockquote></div></div>

--000000000000594c9a06131bf8be--
