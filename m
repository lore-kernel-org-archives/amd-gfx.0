Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95879C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 16:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F86410E787;
	Thu,  8 Aug 2024 16:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HCBfz5NA";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6FE10E787
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 16:00:36 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2cd2f89825fso941876a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Aug 2024 09:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723132836; x=1723737636; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FF3ErR7XyDdmRrXc+Eibz88LgdwMHIouRj2LKrhKpc4=;
 b=HCBfz5NAusUefN8O1k8sZc4sFttsJYYWn23HgxIZGpXT0rpeXUcGgl5INv8YKrAs6P
 jnCmzgZfJqBMGVfpY55YeBnuEVOrl1jovDj6DvggKcjlCJrHy0NYQtbC+230jssAfKEP
 fO+5FQLZunZ0e38tG2ZpdeNJvxk34jpQ3HFt8ztE2H9UXIMwTss8Mf0GbcZSpLecpmg1
 QAj1092BtBHIpyMHZclw4tKAlB2tjAXDKX3arcaTObqiwSc1OaVDAJB4F+oGqVyPmokB
 xsjs3CT2PgmhpsQa34pt5po0FAmizlVlBLA0jH9z7AUudpXR2Veh7+YJ38AzbylswW5d
 diRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723132836; x=1723737636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FF3ErR7XyDdmRrXc+Eibz88LgdwMHIouRj2LKrhKpc4=;
 b=f4vRcLpp0XBab4of+nq8Xkt2yOzM509vLNcoCqGjOZDfcrSMVDudBOTv9Y1rMweTnU
 0Rb0ASqfEvUBkFXL0ivPKCkhS+V3cQvxkD/DlSudIKHQAiVv9Ef5sxvvYYPVS3OqnBrc
 W7z4DJr/yu8Rlq45uX11yVLsaW8yMbhy24V9n6v8wMWj7YwK2ocJEdonGM5We+mZnMCq
 Cy74eIkOlVKQHPD0aeXMwIPpHUSYdp5jfV1hTm6GYfHg38CC/nb6yZ/Ekb3tt43TmhnV
 AmFtKSp3xcg/0QOkT+mQuzKKPGXvoIKBqaxM2uFUNGafBrjjy+JUOqlxduTlXKTpV1J7
 tijg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiwA+ocZ88Fmlf5KBl3dt2QsUeAeMf06PXpQHKskGQdlXFF4jdo6kE+nRV98z9AWTqTUtYll3/3ucbLijyGyJHEe/URcTc5GhDCvfe/w==
X-Gm-Message-State: AOJu0YzpnyZkQatRHn8TJU6UfpF47skEIfeZ6M3kVqJjF6JnOxlJmFsX
 virD2lPGMY/Ndnq+YKhJXx/RPngB7YwdF1Vxcl0TTrByCHx84UCyKfrEN7QlPrgYk3WiH6TCBO0
 iUd89BfaCRmDfVyRkTxTlZMxG8nQ=
X-Google-Smtp-Source: AGHT+IHo0+sI0NH8pOMLH7d+rcg1wkhXo7lVfPvHCnUYJc1Bw8/Js4WYVQpt7fbxtAg/HEjNchhtNuk9shgIMceWHO4=
X-Received: by 2002:a17:90a:ac8:b0:2cf:c972:7c22 with SMTP id
 98e67ed59e1d1-2d1c33b60b4mr2861078a91.10.1723132835665; Thu, 08 Aug 2024
 09:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240807120217.2863917-1-sunil.khatri@amd.com>
 <20240807120217.2863917-6-sunil.khatri@amd.com>
In-Reply-To: <20240807120217.2863917-6-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Aug 2024 12:00:23 -0400
Message-ID: <CADnq5_OA9zxcJCoXRrSjfcfxYNEqsDn9=8Wvn=oFm3oR_ywJ+Q@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] drm/amdgpu: fix ptr check warning in vcn_v3 ip_dump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Aug 7, 2024 at 8:02=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> Change condition, if (ptr =3D=3D NULL) to if (!ptr)
> for a better format and fix the warning.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index c2278cc49dd5..6d74da7b7ffb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -359,7 +359,7 @@ static int vcn_v3_0_sw_init(void *handle)
>
>         /* Allocate memory for VCN IP Dump buffer */
>         ptr =3D kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32=
_t), GFP_KERNEL);
> -       if (ptr =3D=3D NULL) {
> +       if (!ptr) {
>                 DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
>                 adev->vcn.ip_dump =3D NULL;
>         } else {
> --
> 2.34.1
>
