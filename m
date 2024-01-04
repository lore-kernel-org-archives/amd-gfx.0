Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C13C47074
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 14:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258D610E2CF;
	Thu,  4 Jan 2024 14:16:43 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456F810E2CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 14:16:42 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-203fbbff863so198508fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Jan 2024 06:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704377801; x=1704982601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECoa2sluMYZfoCNR+bLvb8/iITWmOTNyx3ruNLtEdJ8=;
 b=DE8qjZJP47eqCPzWFWzZ4jGwIqIi87YdrHF/sYiv3OaUuKMnvwDEveHUhDgKj3jbqv
 90v2We2aQIaSYsL0ls3ZHTDkFPsepqO8qRsfI5IDC4oWZ1RYJwgDPxBrVB9DRDc/ORQX
 IGz85xKYOazaNTyrGBqNLBtP4fvOtA6OGA/mIK1UU8iNwkI89hNib+HIF9kOQYbmrN6x
 sGNdKTQqOjgQ+ZDQXKAaYUqdSUzc19pB0ZFRJkvy77bZv6znCA8FuUXnUXuk8CkS6Cb9
 4swiz1CmzmXW/Db7MpcKDmxBXc9Zt5SeQAXht/P3byo7hh+/70jkRnvOfsXJyStZQwkj
 /uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704377801; x=1704982601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ECoa2sluMYZfoCNR+bLvb8/iITWmOTNyx3ruNLtEdJ8=;
 b=RYsHweQM8st/AXMBUFf4Usc5GQbQZFCfXqqpmDWD+euulL87bk1lyzYvonvqECR+qZ
 JzcwgSBlezvICCAXneBJ3ZcN3BkeC1pyYeDfCOEqiCfaKo/WooqpgOCeR3sd6xxT+Iy0
 ZgErS7q0HV6yIM7GZEXp9d5Y8TtuO+Me4uDDeR2ATeKX08oUSAfFahWt8bhVAYi4y2vo
 YCL2c//42TrXzysPtmfIf8YUCVASjK9yYqJG6yH46yEmzcnv8OI3rA9wOFtA49hkTGGS
 B+rBsiq5ZLWQ9vDprXNtnacO+f0NMccF13KPJ4U8Mdm/D3XdNizMX5fMsuALCMOHo9JS
 aeEw==
X-Gm-Message-State: AOJu0Yz0UBCKt42E7pyYvHtbCGjc7iyoZVCCixsg8/IwadmidVavhSnL
 aq7Tcj3p5ZP/Q7e3uNhjht/DzTtkUkAkQg+LigncL2P/
X-Google-Smtp-Source: AGHT+IEyIigMO+SHYFH9WpC0xfEJrUt9lQIMp5z8l503dEZyBqa0+dPegebpI0RzKyPaoaueMyD2WpO9AZMZDIelvu0=
X-Received: by 2002:a05:6870:658d:b0:205:c7ca:fbf6 with SMTP id
 fp13-20020a056870658d00b00205c7cafbf6mr168046oab.49.1704377801424; Thu, 04
 Jan 2024 06:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20240104092637.2353130-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240104092637.2353130-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Jan 2024 09:16:30 -0500
Message-ID: <CADnq5_PHRC3j9FVYE3vPMhTbf7RxnW6gA0PJBD+RA9YFQEGHMQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix '*fw' from request_firmware() not
 released in 'amdgpu_ucode_request()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 4, 2024 at 4:46=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:1404 amdgpu_ucode_request() war=
n: '*fw' from request_firmware() not released on lines: 1404.
>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>    - Fix some indendations.
>    - release the fw only when ucode validate fails.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.c
> index 1f67914568f6..d30c39cd8bb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1395,12 +1395,15 @@ int amdgpu_ucode_request(struct amdgpu_device *ad=
ev, const struct firmware **fw,
>                          const char *fw_name)
>  {
>         int err =3D request_firmware(fw, fw_name, adev->dev);
> -

Leave this new line.  With that fixed, patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>         if (err)
>                 return -ENODEV;
> +
>         err =3D amdgpu_ucode_validate(*fw);
> -       if (err)
> +       if (err) {
>                 dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name=
);
> +               release_firmware(*fw);
> +               *fw =3D NULL;
> +       }
>
>         return err;
>  }
> --
> 2.34.1
>
