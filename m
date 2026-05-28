Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6101CCD6E44
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 13:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017A010F1A9;
	Thu, 28 May 2026 13:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JP5M27mw";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04EF210F1A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 13:35:04 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1363f6f7535so217976c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 06:35:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779975303; cv=none;
 d=google.com; s=arc-20240605;
 b=id3u9y25RmaSeG2u0Em4FVwoVnUGBeGbISSLDu4o//mw6gOh27ZxMtSp5fVdpXpIVy
 JZ43wvQyCQXftNexV/a6TII6nY6WuKvrEEa5+vLRO3aWpR9pBfMpjatkmV068T1KBttk
 iy8yE6fDhWqsHMeAqbVjiUTqoXyJZN8WQzM8aswkJa0XOt33h87a/w17nUWTCqgSBwOX
 73atOcO/GoHUvnArN8rRJd1PnrJ/+SSsociggS39AKanzgAKwOq0cacAwVI5zX46Bmv/
 RXJJx8j0VTAKgLXNUyYG7yC2dnKC67jM5XRkvGPs8elCDIRWG3tOJEely0fFTa3uCTyg
 4QQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+gDquEiE2Pzn3EZqeMxEBphJxI3S81tdreou4Kx2Lg4=;
 fh=RTfDhAmlsQtLaCIa6XQrJDNPPwq88KWFxfnRLILnjpc=;
 b=XxP8ZSruzqkseWYeJY0VfQWbP+aiFg4yK/vpyhVspTSnPlrn5B5AS7jtD3G8dkrhvC
 4gWkw5liuX4U2LDWcXwO7LlXWtX3beQBKO/xMIzR/HKY4hpGqOvono74FY0m/W29OkPA
 PpV0bEPfAMm3h1+tI18oQ96XjzNesnIO8Xp2CwfAMcvtUXAfZjyXIBXNYE7NqyYL0ExN
 C6JN+/nNwq4JWbdQVd461fvjqjC4LpqPFpI5UwbzwDwz5SisPY4mq+s7tiRqiADSVq9d
 i1Xh6hDo0hFe2M3lYsIpRkZxWLxvkYW0m+KPZiqSo3Rz4y/ZXWmyAIxITdRoMJf+9fJ5
 nc2Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779975303; x=1780580103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gDquEiE2Pzn3EZqeMxEBphJxI3S81tdreou4Kx2Lg4=;
 b=JP5M27mwH0/RykUoqIv4ynlEgxICtcO/nla2QostTHs6Dszf29IHzL4x42leteFxZN
 GEzNkucbDkPVZG2oIysZUSXW8PiUcuGhPyZnyhjSRvzreKjMCegFnu7Lila7ZXUkpDAS
 w9PcCuHWcadh+56Ij3pYPmO5fskEq/eVTYupznEsbmbSU/sq5LD2AShGRuLjbpA4Cafr
 OxlfY8CKerrM0xqlVPz9EKHTkWvfsAem0x0b406nxV10xE8uC50wYE3EljGsnBFLGS0M
 NIIxxtF9q3Kuv75+IV1QcFJ29EiPdzirvDyuLWjakxl98uo/soBHMRbFV3NBGVA24QkF
 TWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779975303; x=1780580103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+gDquEiE2Pzn3EZqeMxEBphJxI3S81tdreou4Kx2Lg4=;
 b=T/JucMYhemxWvnUScL7/xcyCcTDN/arhNTTwkXJRktT06a6bhyp/4Qmy0gUqQFaXoV
 u7EMC07fIQmbRkGy+fBvP828Jo2s2x6+bfpZN5bACdOiUzvEW9CWDlzTGGx8tARn8nVm
 ujyUJx1Y6513NfW6i65WF4amlndJhhuNS1J+/TPCy/pC9U2+T7U9mOSycxz/tCCqyoqt
 2GFqMBTnDcMVwfHA5f/H749OBuQ4ATj30U0NCQ4tPp+W/KknRfPO0hPbU3ZOYYf16cbY
 rIcBFi2k822ChGUpmdqqYLGC4/VSHPk1mbfXMUI8g2GzVQm+g05aFB6qnaP+hgLVfzKc
 vipA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Cu7L29wZPfCnLxhmCfR0QHbZBkupg3vDd5AUsk/shP73cQzR22gD4+2P16jmMGM2fPoZdlHWJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAOcUrsP6eRYXPVLH4xRQp4HLsTp3lKyJeLrz1LrzGaDkXQWfh
 9Bs0bxwwxi+YNEcz5sGSmWVebswFuuua6t30Ka6ChhO8mBYXtnKM8Ck5a0/obsGr9uoBeVJWT/Y
 z0c5hVwKKYOe7GfQHJm82WTx0n4ElF6G81AFP
X-Gm-Gg: Acq92OGF1IrHZVRx3RDiaiaygeR9CvUDzMkZN9Gg8DXEfkH/EAyza/nq0y+8miEzm6e
 k2xRYFW1WefgCwI1cG7NAXlL1eypiQsjmEzfHil+1yLfzurGRT5AehpGF9BfBdbD/RY1av6GNUB
 A4B76Pn+aeWEofBFWke9aD8DOULlIsgm6z6wk3Q2AmvEIdEV/tyTCX28LUx/3q6c3b2HNNODvng
 LnG5A6vS2Ek3Jc+kQBmsY0kDx23nl+8Ecn9B2aS9j9Xc1HtiHvTDqt4JpqHiizqR2LDSAjeQUO2
 4oHAad3MiCJR+4QY4GJFoYmTQCH4mErh2oDLQFkb7DiO9tDUqu0tYy7QVXXZ9LFPqp/EsMvQev+
 JR4sS
X-Received: by 2002:a05:7022:2202:b0:12c:888b:aa92 with SMTP id
 a92af1059eb24-1377c94af3fmr717780c88.1.1779975303197; Thu, 28 May 2026
 06:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260528064206.12358-1-Pratik.Vishwakarma@amd.com>
 <20260528064206.12358-7-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260528064206.12358-7-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 09:34:51 -0400
X-Gm-Features: AVHnY4Ix7rnYdImcZvY5cqlUKAXjSHmhCSp_cJ4eMY6eR8pnLOHhBl5SHxRuT5o
Message-ID: <CADnq5_N7R-_p_TTLmbXUg03JZ+orVLMNpPFD8PTkR5GouUxhBg@mail.gmail.com>
Subject: Re: [PATCH 7/8] drm/amdgpu: Add support for SMU 15.0.5
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Thu, May 28, 2026 at 2:49=E2=80=AFAM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> Add SMU 15_0_5 and SMUIO 15_0_5
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 1af18c820d4f..de3c3d3939a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2348,6 +2348,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struc=
t amdgpu_device *adev)
>                 amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
>                 break;
>         case IP_VERSION(15, 0, 0):
> +       case IP_VERSION(15, 0, 5):
>         case IP_VERSION(15, 0, 8):
>                 amdgpu_device_ip_block_add(adev, &smu_v15_0_ip_block);
>                 break;
> @@ -3325,6 +3326,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_de=
vice *adev)
>                 adev->smuio.funcs =3D &smuio_v14_0_2_funcs;
>                 break;
>         case IP_VERSION(15, 0, 0):
> +       case IP_VERSION(15, 0, 5):
>                 adev->smuio.funcs =3D &smuio_v15_0_0_funcs;
>                 break;
>         case IP_VERSION(15, 0, 8):
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 337f9acacef0..ae44437af86b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -801,6 +801,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>                 smu_v14_0_2_set_ppt_funcs(smu);
>                 break;
>         case IP_VERSION(15, 0, 0):
> +       case IP_VERSION(15, 0, 5):
>                 smu_v15_0_0_set_ppt_funcs(smu);
>                 break;
>         case IP_VERSION(15, 0, 8):
> --
> 2.43.0
>
