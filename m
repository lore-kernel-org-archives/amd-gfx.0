Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AE9CD6101
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 16:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF7210E10B;
	Mon,  9 Oct 2023 16:21:37 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3752810E10B
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 16:21:35 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1dd78b46995so2292018fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Oct 2023 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696868494; x=1697473294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7bP8phnEYMWqwNBtZ2+L0CHdo6DQQ8YdTxRq88zcYY=;
 b=hfFk20w+OcZ/E61u1YXgxvGYLDr9h4ORT8/Eznybt730C9Xd3aCvSzHcc30g9hORhc
 xR0kUFpmreRVak/fXClCuTLnYlijJhRoEeNM65ulDCXisauMZoB5GsmyuAUwH5pFEDP3
 ZyadjSQLL5yxFRTn87zud5Ufqnaa0sfmkjx/dLShU4px9OrScvMAXeWV/AIUZVVIzGZ8
 DOosm1w2ivxRcN+vwuwsu1k116B3qaVok7RCuv96IZI9sQw37FBAX5AmArxT+GSG8MkK
 3gReAxs+8PNwr4kRbZoQHQTxU2qUT68lacZ3+EE6UvEQ06BnaGFpn/auwoCoq63wgZLs
 b4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696868494; x=1697473294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7bP8phnEYMWqwNBtZ2+L0CHdo6DQQ8YdTxRq88zcYY=;
 b=F1ewIGTwR4O7bApGHCVU6UWKbcwCF9xO8/Nn8Y7jBkIUWSiJAsPf8kQegqic2Qh4Qo
 uoTm/LFvM7DzcoRTxODIGFq99WwB55fyhImtt8HTIc99SFCbGyxVa2ZkmHfMiemt6DF7
 fL0eIlFQPosRDXuq/kJMrrALJxq9WBLPdGu7Ny/QS4ZydceJ3DJ1kXfQoCoILz6VyScc
 +wkr11XbU1exM1XcoyGcBrLviDL2MTlZU8AYATLqUfAI+JPKRMdcQm969/pO2lfWEsAh
 ceKgUfWlmq0teK/8PmwBu3Dy7o12vVOU8Xeh0rzWeokqcwGGXRhYwCT68qdyCcD8k2Pf
 9gmQ==
X-Gm-Message-State: AOJu0YwgIKMuy80o0QW1b+CLLTaZNOnOhaxMWjNUbvj1bU+8bU6Ba9nG
 qhHI+/ta2TpaF2eqni+HI0nu2pRHnAed5a+V9FwmWz4mxMA=
X-Google-Smtp-Source: AGHT+IFE8PE/qtuGz1KOVLIeXipy71+Lj3kFIVxa3jjaPQ+4IgEf2IL2oiMP7LcxbPFlNCi7XSN4Bwsy/XpShgzH09A=
X-Received: by 2002:a05:6870:d695:b0:1d0:f5bd:6e9 with SMTP id
 z21-20020a056870d69500b001d0f5bd06e9mr15121309oap.22.1696868494274; Mon, 09
 Oct 2023 09:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231009145933.164871-1-srinivasan.shanmugam@amd.com>
 <20231009152122.172858-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20231009152122.172858-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Oct 2023 12:21:23 -0400
Message-ID: <CADnq5_PNdiQw5bBFGUA9XbiWexmPLxDeoDN99Xih4U54gZxoHA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Address member 'gart_placement' not
 described in 'amdgpu_gmc_gart_location'
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 9, 2023 at 12:17=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:274: warning: Function parameter =
or member 'gart_placement' not described in 'amdgpu_gmc_gart_location'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>
> v2:
>  - s/in/around
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 60c81c3d29d5..47772f233a4d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -264,6 +264,7 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *=
adev, struct amdgpu_gmc *mc
>   *
>   * @adev: amdgpu device structure holding all necessary information
>   * @mc: memory controller structure holding memory information
> + * @gart_placement: GART placement region around VRAM

GART placement policy with respect to VRAM

WIth that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>   *
>   * Function will place try to place GART before or after VRAM.
>   * If GART size is bigger than space left then we ajust GART size.
> --
> 2.34.1
>
