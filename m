Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D3ECE79A1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 21:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9F110E08C;
	Mon, 25 Sep 2023 21:35:59 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8329410E08C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 21:35:56 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1dcfb21f9d9so2314702fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695677755; x=1696282555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psoiBMj3GlJdtmLzqT3TPkRR2EbmCfwuvjP9ypDy26s=;
 b=dj5o0tX7NFk00XL8JdgSghhr1vu5lSBaS+i8SsMK3wIG+iFtRqVy48nc0a/4Cg27gK
 gGPffCqChJHDrtVs7AMryGZyEHbHREidbdPyRTgvTtatWqtWjNcGeBCnA6XuPHBp+ivD
 UgJHTvQsz85fwJLfc5ywIEMievmy5bIJGU9CsXSzyp1SVExvpuvk+jtcbrZ6TLCo11eO
 J8DaxbXq/MHIdJChxTE3/HmG7XLxf+lzfu+485pNkcWMkTMS6KKeiFJfBkJtOT19mv14
 7Odplhx7ODVRTyMprB5jtjZgqUYYu6vxs/H+hcmmE8CCkRHUmNKuT5lXrZdNzu76hjsJ
 YrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695677755; x=1696282555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psoiBMj3GlJdtmLzqT3TPkRR2EbmCfwuvjP9ypDy26s=;
 b=U8o3Bfba7ZCZ/luNcRpcdV63EZ7Yp5lWcsvSIcT20Fe1DOjTq3IjxQ4RRyeQwoX3Fv
 GL8F0qrYz+rmuNvMGiIjeM6oygQDJEZ5PkZ9k4aFqgUp6Rv9CfSmRsCzD/8VEZWMJq+k
 lqwfY0cZcPBrPJjwhAT143U+MzgtRQXDgyISOtGVSZUwqGYMBvozxYxTX7v1kfV8nY2b
 9i73phojtcVfyUdVBgz7NIYeytOG7eBDIn8+rsGEsvLicAiJjE4pvKpxpiNvoiivWv7l
 qLAcEAACBCa/HrLXuYwkve82w06/XFGkyKqpSUPN/IMWknaHPEio9c1o1wEzQol7gHVm
 8WQw==
X-Gm-Message-State: AOJu0YxCMU5SXRtxYz0rpYTO8sXluYdC/aokf3DMcQ8MXmsBHyCG2lAH
 PxGclDSjKikK5l/INU+S+Mxtk61T2/XpiQ27ooE=
X-Google-Smtp-Source: AGHT+IHcD+rD56ZRBzyzbDhIetxRxT0xv8TKcw3/eaIABbqgiExg+R8jLOm7EX4JKM3hgGGmj8nXKBjf/MUE7sYAZEE=
X-Received: by 2002:a05:6870:8452:b0:1d6:564d:cfbd with SMTP id
 n18-20020a056870845200b001d6564dcfbdmr10363113oak.14.1695677755587; Mon, 25
 Sep 2023 14:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230925195207.124850-1-mario.limonciello@amd.com>
In-Reply-To: <20230925195207.124850-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Sep 2023 17:35:44 -0400
Message-ID: <CADnq5_Mk1DYYqgiPPvschG3Z4WTWebn9G6+n48kFhAWR0KOY2Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Some cleanups related to missing microcode
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 25, 2023 at 4:41=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> I recently found a noisier experience than I expected with missing
> microcode.  As a result I found that some microcode wasn't being loaded
> in early_init and some messages were unnecessary.

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Mario Limonciello (8):
>   drm/amd: Drop error message about failing to load DMUB firmware
>   drm/amd: Drop error message about failing to load SDMA firmware
>   drm/amd: Move microcode init from sw_init to early_init for SDMA v5.0
>   drm/amd: Move microcode init from sw_init to early_init for SDMA v6.0
>   drm/amd: Move microcode init from sw_init to early_init for SDMA v5.2
>   drm/amd: Move microcode init from sw_init to early_init for SDMA v3.0
>   drm/amd: Move microcode init from sw_init to early_init for SDMA v2.4
>   drm/amd: Move microcode init from sw_init to early_init for CIK SDMA
>
>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c             | 11 +++++------
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c            | 11 +++++------
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c            | 11 +++++------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 +---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c          |  4 +---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            | 11 +++++------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            | 11 +++++------
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            | 11 +++++------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 --
>  9 files changed, 32 insertions(+), 44 deletions(-)
>
> --
> 2.34.1
>
