Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F9BE7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1FA10EE03;
	Thu, 12 Dec 2024 14:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PnKeK5xY";
	dkim-atps=neutral
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE8210EE03
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 14:45:35 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21644db9f3cso1098215ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 06:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734014735; x=1734619535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GQ1hT6Yz0Nih4hsn1roT8m/e30NyFhRNz04TSe5ebE=;
 b=PnKeK5xYrNcTv9dsatD37OjhipUi3hdw3mU9Ooxij02YyMEPgcF98+MBoVwXqAUKIi
 OKCL1PP0fopQ6qie9xIOGqL18E2TQWMfrmRdapASgtuzJ9k/1ge+Bjx0rw2Hb8S2uobN
 YYZesMjc8wRArKMbyXktXl2jdU03a2doxuapjfUp+50dJ+XDOKVu9FfTA5BalYmNXEZj
 culC997HHULSXOI2iSQY10IWNY41B3UBX7/CJdSKdvq6FxUFHigXz5Ccen/FFiclB/l0
 /UfZrOyDiTA6WA11ASaVGfa7DoJ5x65ZA4WCyEt8bSMbwjSgKqK8opSNBABTjCo5ctmD
 JrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734014735; x=1734619535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GQ1hT6Yz0Nih4hsn1roT8m/e30NyFhRNz04TSe5ebE=;
 b=YEMIA+/Ye4IXF4p8sZRZ3it/4nfbS7Fg0NwYD1EyTK+KWELcDDFj+WsrNeO0+d/9Za
 QCH+qCPa2W00ZLYlBfxrgZHY0pC0trpg6pBl0b1I6aQKF4RCllCsiCFeQDEdtOHKoFlA
 OcmQc8I0n9DEQobQckrAmVC1ivQ5R1HzT4r3I2mVIsaxLwPvIdAYLsZXKoTPz7ouBDUV
 hSVXAh4szYH2KyE4eYm/mU7SSrVQDTLeaaiv4u2Sb5yDL+z/hbppjJZAxAkOPzHb7nQv
 9bB9+QwcQc/bjS7KbdGBKNTU78lfjzp30U+4sjo+s6xekQXaEAA4Dx7DMIkCsQQ33Y0z
 9CGg==
X-Gm-Message-State: AOJu0YymvHhUYll3T7sUetkvd7Xygf27VQQwE0gsBlehf4Rubo+zF+t+
 lQVYfnqepiws7BxXki4ENls7PX2vkcbxpzfwWQtdVlHtTmge6+LrRnqlNhDUOn9J+kgB0JV7VKX
 6WUnQCjUb2DIAGUIAAUukRJfCIGE=
X-Gm-Gg: ASbGncvrNTpK4IA6Loim3VPpo9ptMb59aWJbRjAZoXaiKKQqZ9T87iuQyNOi1jmljLU
 CZawYNr2zeiuX/DtkEsJovC4Ne0r/4mOzbzMx0g==
X-Google-Smtp-Source: AGHT+IHR3UyPfrsIfksVlqCrOr7nDL1nUQeU6tp7uoaa6gPLGzdDLdBGgy7EMSzQNmaVGSE9FD6t9G3U/k17DlF+noY=
X-Received: by 2002:a17:902:d4c2:b0:215:a81b:42e1 with SMTP id
 d9443c01a7336-217783c26bdmr39422235ad.8.1734014734876; Thu, 12 Dec 2024
 06:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20241211214822.28160-1-bokun.zhang@amd.com>
In-Reply-To: <20241211214822.28160-1-bokun.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Dec 2024 09:45:22 -0500
Message-ID: <CADnq5_OOFwdP4RdZN-+7JOgBSvjjSjwcjGa03ajkwFrsCToU8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: reset fw_shared under SRIOV
To: Bokun Zhang <bokun.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Dec 11, 2024 at 4:48=E2=80=AFPM Bokun Zhang <bokun.zhang@amd.com> w=
rote:
>
> - The previous patch only considered the case for baremetal
>   and not applicable for SRIOV code path. We also need to
>   init fw_share for SRIOV VF
>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>

Fixes: c4b519b70d9f ("drm/amdgpu/vcn: reset fw_shared when VCPU
buffers corrupted on vcn v4.0.3")

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: If26a377a2fe8f2aa09bfa21fc54bf26e80fd564c
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index eeade7366e82..ecdc027f8220 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -957,6 +957,8 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_devic=
e *adev)
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
>                 vcn_inst =3D GET_INST(VCN, i);
>
> +               vcn_v4_0_3_fw_shared_init(adev, vcn_inst);
> +
>                 memset(&header, 0, sizeof(struct mmsch_v4_0_3_init_header=
));
>                 header.version =3D MMSCH_VERSION;
>                 header.total_size =3D sizeof(struct mmsch_v4_0_3_init_hea=
der) >> 2;
> --
> 2.34.1
>
