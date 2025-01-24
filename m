Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF84C02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 16:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4469F10E9F1;
	Fri, 24 Jan 2025 16:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dpsR53ke";
	dkim-atps=neutral
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com
 [209.85.167.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D61510E9F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 16:32:06 +0000 (UTC)
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-3eb96351ba1so120109b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737736325; x=1738341125; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q/Bg1dQxYvzkArxhH3aHxEQuXxgLD4r37N1WnNMJBVA=;
 b=dpsR53keEKYWwsPYDSCIqp0PPznE3lx1caxy2kZDiR1ozpNGVX81oBOIM/PKPsl1s+
 s3zSFNeR5yeJJc23LzHnAk/VOsRyGHz4f0I9esBSi1Gq9D28wQEjLI0jbUemr0TrGQw9
 Y+iZg0Pl1Hx2ynpCGcncZzCKChAPFW8pUHlqp7shYWyW6eL8dw5W0T8ASPUJxXrAhVyc
 msHdN6TgFjH9OCI5/0znDSwZUUKBKDuJz7226aKg+xPd2tDCrfIfmB8QHdey/qW1UTAz
 8zCg8ZIggJ971cJF2N0gO2oWC31fjW2ecYR2i7FVtgOO5gY9Nr6EkDUSCPOcGeSuBDK3
 YCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736325; x=1738341125;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q/Bg1dQxYvzkArxhH3aHxEQuXxgLD4r37N1WnNMJBVA=;
 b=tr4beBvVL6MzTZYhjjm1vCrdwGSOn5ADSehBWz7wq6prXFRDmvwhTi+Gw81MvgRwnl
 lJxTlMvWh3ij11MKXO2XXdPAhSXgnU5fmIlQSCz+SHUiD0pb8ESn5hLtUtF5EeYn52nc
 NR9kF+LkRhvF3+sAtfXWr3SQ4i61FYxCCBNwNgbxNaj5nQRpGrxJOpe0T5n/d52p8xuN
 IkcqF7VUbh/xKBXTtt4OIuqYI2nlFQL94Svrl61chRosyWVW6sCp0P9SeJwq+tRzSIeL
 Oth+cFa7DC1TEbIWkJv64Rvhkb/qRFWUfSLExTSFFIpDWYd/Xtlry+dV6+y4vJDr0mja
 UH1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzJipaT5Trg0PpD3ANV4F3TT269OalCDhIrYawnvegg3sLe5/R5EcX68Iu7aA3mk50BQsXtrhi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEd0uuGXils/IpzbQ2Lrg/S63D++h2GGJjtniRR5uz1ZaP0RES
 1rpeGfaCJ6Oq8vO68qFtYmKxF1uKP0J65nv7Jtg7GU9pSgqAlU/lU8VlOYCqvmT0jhZLSPRRWHQ
 ACgiblqZ/Mk3sazo7GdNfek9S52w=
X-Gm-Gg: ASbGnctGotwEudbnsY1mJmpMR3reVsv42G1Vcoz4RKc6GYBWFRUmQJbGF4OlsHvcQcW
 4EdIKZ4fs8LhUkci9LywZ7PQdaJ+qOCY504UELb0TIQoflkpW5+xa1HfkKu+ySvA=
X-Google-Smtp-Source: AGHT+IH+qnoiZemXYbQHYocyhrA2YTV3fGyVT4ZnQN2cG44CSS8liwRDwfGaS/Tn927oS+RzwnNIL45wPh3FA7320ak=
X-Received: by 2002:a05:6870:7027:b0:296:92c6:60b0 with SMTP id
 586e51a60fabf-2b1c0b19e65mr5907973fac.7.1737736325077; Fri, 24 Jan 2025
 08:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20250124063425.3091080-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250124063425.3091080-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 24 Jan 2025 11:31:29 -0500
X-Gm-Features: AWEUYZkhzYjpXXcYeQi0vPhoxVc-UUfKMuBh6JB_0YZH1kTzxTzMDPL98dyi5Fw
Message-ID: <CAAxE2A4UjeVL1DBYer-Mgn8ufmcmSkBPU1JyZcW_5ghcHD-q3w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: Enable cleaner shader for
 GFX10.1.1/10.1.2 GPUs
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000005ea4cb062c7644b5"
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

--0000000000005ea4cb062c7644b5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Does this commit really enable it though? Or is it just for sysfs?

Marek

On Fri, Jan 24, 2025 at 1:42=E2=80=AFAM Srinivasan Shanmugam <
srinivasan.shanmugam@amd.com> wrote:

> Enable the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide data
> isolation between GPU workloads. The cleaner shader is responsible for
> clearing the Local Data Store (LDS), Vector General Purpose Registers
> (VGPRs), and Scalar General Purpose Registers (SGPRs), which helps
> prevent data leakage and ensures accurate computation results.
>
> This update extends cleaner shader support to GFX10.1.1/10.1.2 GPUs,
> previously available for GFX10.1.10. It enhances security by clearing
> GPU memory between processes and maintains a consistent GPU state across
> KGD and KFD workloads.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 1878c83ff7e3..938f7d60a0ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>         }
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(10, 1, 10):
> +       case IP_VERSION(10, 1, 1):
> +       case IP_VERSION(10, 1, 2):
>                 adev->gfx.cleaner_shader_ptr =3D
> gfx_10_1_10_cleaner_shader_hex;
>                 adev->gfx.cleaner_shader_size =3D
> sizeof(gfx_10_1_10_cleaner_shader_hex);
>                 if (adev->gfx.me_fw_version >=3D 101 &&
> --
> 2.34.1
>
>

--0000000000005ea4cb062c7644b5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Does this commit really enable it though? Or is it ju=
st for sysfs?</div><div><br></div><div>Marek<br></div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Fri, Jan 24, 2025 at 1:42=E2=80=AFAM Srinivasan Shanmugam &lt;<a href=
=3D"mailto:srinivasan.shanmugam@amd.com">srinivasan.shanmugam@amd.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Enable=
 the cleaner shader for GFX10.1.1/10.1.2 GPUs to provide data<br>
isolation between GPU workloads. The cleaner shader is responsible for<br>
clearing the Local Data Store (LDS), Vector General Purpose Registers<br>
(VGPRs), and Scalar General Purpose Registers (SGPRs), which helps<br>
prevent data leakage and ensures accurate computation results.<br>
<br>
This update extends cleaner shader support to GFX10.1.1/10.1.2 GPUs,<br>
previously available for GFX10.1.10. It enhances security by clearing<br>
GPU memory between processes and maintains a consistent GPU state across<br=
>
KGD and KFD workloads.<br>
<br>
Cc: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com" ta=
rget=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
Cc: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com" target=3D=
"_blank">alexander.deucher@amd.com</a>&gt;<br>
Signed-off-by: Srinivasan Shanmugam &lt;<a href=3D"mailto:srinivasan.shanmu=
gam@amd.com" target=3D"_blank">srinivasan.shanmugam@amd.com</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 ++<br>
=C2=A01 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 1878c83ff7e3..938f7d60a0ee 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4795,6 +4795,8 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *=
ip_block)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IP_VERSION(10, 1, 10):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IP_VERSION(10, 1, 1):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case IP_VERSION(10, 1, 2):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gfx.cleane=
r_shader_ptr =3D gfx_10_1_10_cleaner_shader_hex;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gfx.cleane=
r_shader_size =3D sizeof(gfx_10_1_10_cleaner_shader_hex);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (adev-&gt;gfx.me=
_fw_version &gt;=3D 101 &amp;&amp;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--0000000000005ea4cb062c7644b5--
