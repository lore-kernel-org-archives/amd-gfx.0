Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56F3C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 16:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5986610E79E;
	Tue,  4 Mar 2025 16:40:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m3l7AlDi";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3DD10E79E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 16:40:06 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2fe99d5f1e8so1410379a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Mar 2025 08:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741106406; x=1741711206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6Q/yhKyTdN4uAn5KbNxuoKnSKSTP22ERN1QCoeLNAM=;
 b=m3l7AlDigkEReQ2AEfiTLeZHkif8cSOLuvHMJUJ859h6cipnU12/tLcy8XfcrE1OUM
 /NS989ybL6Heuv0q/h2htBRv89FQkSrcyE9+k+5l7mXMIuUuRwOf0MzBxIML25BCrKrW
 fne0eHAaTYc/GN6/ARddaLSENDV1wei3fvprfEl6MiJuVxuCwlWYR4gdHqAtpiwndQ4k
 bBS+y26vsNLUbjB78mGNf3p6HFAvI3KtcuGbf978ML+WKOC4hQGQQpvmvYteXcHnQP+r
 Wy7+8Fvkv7REfUDSHPOsGdCv3EePVgA7Pf2f5St6A4Ul35XBYsQ9eOgL6xzzvye2SMcV
 6u9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741106406; x=1741711206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H6Q/yhKyTdN4uAn5KbNxuoKnSKSTP22ERN1QCoeLNAM=;
 b=IkVecnzM+12WEl+cu8NurG/UhXHiRT4P4kFwIVRSpuVMR0J4Nv4PWnMbmgj/aBCpCO
 DI10wQ0qoefbZJLj4E0FX3mhkhUO+9iPhitVAWg8Ly9yXijzDUFgfTU8wQ0Mf5nnG5lW
 7ZrXELBhkZeVNPnNJcqVXEhwWcuQ0rZIbnbr86PKnHK2bOwDUerpEQWBI/ninPG0PV+g
 VNAF0RYo0nJ7O109GUkd7CsQcPLCT+aqd/mJCtnulUmwGBO2HgE4fpQ5Yor2x5Cc5ED2
 WFLGQBdRhkqVW12shJWOO3KaSJGeOqTmMnia7lXU8o6UZ4AzVIcYLyWltFDHDxdPWqMc
 tDlA==
X-Gm-Message-State: AOJu0Yyy+bYwqWGD1x3ZzQYYfkTuGEpFBFqAmggelymciFdJH5fyePHP
 fzn2+OxrNvlzRJL2mkeBRBBcVTz4QyMaEsH/MJ0j0YO+fJp6CXcciv6pxPsV7i2vEcsxW6UW6E2
 eOIHEAA2QzwGdbpX1nTy3iVx711G3lw==
X-Gm-Gg: ASbGncvBd3P0eMeKw0VOGzQBC3MAnkEpNpYluJgpVGoJQU+LvcJ6rpfBeq9dJ8UAZm2
 4U2DrSrWcVSncUZzv5dG7j3RZvWm/tX2xX2QbK4axkZGVH5RFNsyemeADyyqheI3NQMJMiGUJD4
 PQs6n9AynReesfUyiMapO24jXsgw==
X-Google-Smtp-Source: AGHT+IEzHKARCJtR22ih+aCxkfjdbYLiWtSCpDBWZvH6yHab0E4BtNBS/p7lhZRaqChcscaWCV0V1pb3XhNLKpaiyKU=
X-Received: by 2002:a17:90b:3e8c:b0:2fe:b1b7:788 with SMTP id
 98e67ed59e1d1-2ff35307414mr681487a91.3.1741106406320; Tue, 04 Mar 2025
 08:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20250304161930.6268-1-victorchengchi.lu@amd.com>
 <20250304161930.6268-3-victorchengchi.lu@amd.com>
In-Reply-To: <20250304161930.6268-3-victorchengchi.lu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Mar 2025 11:39:53 -0500
X-Gm-Features: AQ5f1JpRwW2OukwwFlzlq7XpcyS1WDxImNabkN4_XDiUcCbPgkWHpNd8VtJx60I
Message-ID: <CADnq5_OGp0K-aSECET=mRxnc1JspWDzAY1cptHgvpyoXSqwTiw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Do not set power brake sequence for
 Aldebaran SRIOV
To: Victor Lu <victorchengchi.lu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, horace.chen@amd.com
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
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Mar 4, 2025 at 11:20=E2=80=AFAM Victor Lu <victorchengchi.lu@amd.co=
m> wrote:
>
> Aldebaran SRIOV VF cannot access the power brake feature regs.
> The accesses can be skipped to avoid a dmesg warning.
>
> v2: Remove redundant asic type check
>
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 1f0f03108a82..d345285ea885 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4045,7 +4045,8 @@ static int gfx_v9_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2=
))
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2=
) &&
> +           !amdgpu_sriov_vf(adev))
>                 gfx_v9_4_2_set_power_brake_sequence(adev);
>
>         return r;
> --
> 2.34.1
>
