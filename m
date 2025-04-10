Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934CEC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 17:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194F810E013;
	Thu, 10 Apr 2025 17:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iNdFHzrq";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF1A110E013
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 17:07:18 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff73032ac0so148964a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744304838; x=1744909638; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioZFBgGuf+FlLyGjg2GpynZWIFxXwxdwD4NZb4DTiEE=;
 b=iNdFHzrq4RiEpL+o7VLvhe0xTB3ai9f8hLVwiuqN7jGT+bortpkXgJsD1swMgW3dLK
 tHEhST890LU8Liz8YPFXTv3I1Xni0JFgV0dKmpo2BJxafV7VgM0guP1UIRrDzJlal6Tu
 wvihnqQUsl1hankB520y2WTFYTdbqTislempcQdMII4ABE9WX1kV4gwNfqNwaatvNqe1
 iLx7i4kJjlb+yZnh+srHeZVm36FX+Vbgil7d04A5QDJOD7Czh5FFihhBphKg28Olul4i
 Id78QQXkG71omygdpdCaLG2vsEdj0S3n/wkvuYOEqN78VgyNND/MEGdNRzMAKzddvJU+
 kxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744304838; x=1744909638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ioZFBgGuf+FlLyGjg2GpynZWIFxXwxdwD4NZb4DTiEE=;
 b=gCkv/ffCqh99q863n9aCPWbb3ltKJz8a08/JO+DOjFLMmtRSHi9Rz2pmv1C5vR2um/
 O4o7fONbOHWPE3dyToBoY5HeSfjBIIVVwb2HNnuaR3kt5AhR5V4W3Eqca+Rt6FPYnXm2
 hxKa7s9Y8KM6muHE0EPrUyMkvy+IjwpQf4Pj/au3d6f2QqcYi7yAEuoChjApQzp5Wx/s
 lWlKN26Bs9sPc02EwmKnjV15h/PF4XHaDk6b8Qog/sJXyP5haODoFTTBrLyO5n10minj
 +Pwi0XL9eGggtcLNIQoWhLmaRBmSXINodbu86iUV49J9cwpK7n2++QkOPJsTIJoDnZTD
 +Wow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1XjFxCw77i1dNzKMUTx5Y8DmZsMt8OTZyVVsGOTgQLFrIr5Kvu+v0fJXKZnAe/8UTUlR3G234@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzyJY8t74LtZOwMHlmMs8JpkRuA/42Utz21hB9thK0TjOs/OyMw
 wGdH/ZpOp/lyow0yA+jK7L2IlW/zzTTcFrPMZXAaSdCFsudo2pSlvZ9g53Ex7EeHh6oI5Qpuw0F
 AIjcCjMaQ1FJm62iKLut5yRJUYSQw2w==
X-Gm-Gg: ASbGncuZ+nIaflIWsJCdhUJBju+ug4RDIjSzfok9XcYqnRVkvZjErjaXWXLgnCHVSB+
 y1Ejr0GqsL/u4NzCsEr6ECpq4Kvlg/js279UUdmImy2sIqU4KRM0nrQZHs2ZWsGcv7knvl/HMjW
 nLYvSgDs93WADFqJVgt0WurA==
X-Google-Smtp-Source: AGHT+IGUmWIQ7OlnUPlvv3qdUTi/Wpy1hK+p3azNbA2Leitg2BRw3ykYzxFxJrqitV+1c5gYMg/iGKuMDicahNTcZOs=
X-Received: by 2002:a17:90b:4b0f:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-306dbc1f301mr4082805a91.3.1744304838066; Thu, 10 Apr 2025
 10:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250410164512.2750-1-Arvind.Yadav@amd.com>
In-Reply-To: <20250410164512.2750-1-Arvind.Yadav@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Apr 2025 13:07:06 -0400
X-Gm-Features: ATxdqUHwlulE2GJUh1xL8FBTcj7xD1xj6VZgFiE78gtfcPi5F7e0MAshyy7hz7o
Message-ID: <CADnq5_O5raon_r50sYjiRdy7MBRUO5AwkCLBVv3w087s=2OKtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] drm/amdgpu: Add fw minimum version check for
 usermode queue
To: Arvind Yadav <Arvind.Yadav@amd.com>
Cc: Christian.Koenig@amd.com, alexander.deucher@amd.com, sunil.khatri@amd.com, 
 shashank.sharma@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 10, 2025 at 12:52=E2=80=AFPM Arvind Yadav <Arvind.Yadav@amd.com=
> wrote:
>
> This patch is load usermode queue based on FW support for gfx11.
> CP Ucode FW version: [PFP =3D 2530, ME =3D 2390, MEC =3D 2600, MES =3D 12=
0]
>
> v2: Addressed review comments from Alex.
>     - Just check the firmware versions directly.
> v3: Firmware version checks only for Navi3x(by Alex).
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

For some reason I haven't gotten any of the 2/2 patches for any revision ye=
t.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 91d29f482c3c..460bb06d2ee1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1632,7 +1632,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         case IP_VERSION(11, 0, 3):
>  #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>                 /* add firmware version checks here */
> -               if (0) {
> +               if (adev->gfx.me_fw_version  >=3D 2390 &&
> +                   adev->gfx.pfp_fw_version >=3D 2530 &&
> +                   adev->gfx.mec_fw_version >=3D 2600 &&
> +                   adev->mes.fw_version[0] >=3D 120) {
>                         adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
>                         adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
>                 }
> --
> 2.34.1
>
