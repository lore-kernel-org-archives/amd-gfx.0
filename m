Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB01C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 05:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2F32072D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 05:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utQmRKY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2F32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D786E156;
	Thu,  5 Mar 2020 05:23:07 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 019D76E156
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 05:23:06 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id j1so4274838wmi.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2020 21:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xUwklg5RwJcK7MDXT66JqrdtiTsCdNy9L/9/3F5esLg=;
 b=utQmRKY+60a09laAhFdQGeCIGAXJY1IYyuRzdisSYAtA9G3XkpBW1nTirAm9YqcM1f
 kskWFTurGV/9qqakWQIYhUK2zC2NPow3FRziTvDSBrcTluC9N0UUSFUYQiGbhQtb801f
 48LrG4V/sb/GOwXJrHo+9lWLECo36BHWpEQULdd/z3G+HZOkJvbk01t9aS49hBVcFCWZ
 wHSTWhcsyjlUnuITaP9EqbJfWcJws96buKrgAeJ0ZoKBlxbSihXtdnI3IU3SPN/Eqnkl
 EgWtznj0H5ql+vHzUxIsw4OqHrqTekzhU6rpqVLgV5pD+10NLZ/trzA1KyUfj3jM7QSh
 dU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xUwklg5RwJcK7MDXT66JqrdtiTsCdNy9L/9/3F5esLg=;
 b=OMQEgMGo34XaKnEXzqhHRwA/Ro8BG5UOnG33GhT2QySZQ9owG3rXaV9sXZcCYAKPsE
 jx4PvmrRi6rkbGqrUO3vcicdLiWTDvma0XCBuFM5xSZVwvEPnbFCgAGcHtICrzuyHRsd
 ifF+3BwgL0/y2PHbUaSQF8bzIbG3zusOenkVBl6H1V/btmJ2eyj0PVyAq7p4S294G1I5
 vf3sBnnAinAszg9BeNKP9BZDj2rBA+1/9DP+r9M76qVXLhE0iI7R98O9sK90yJY+d5qx
 RPUIg6tASRig4wYvXMfe0dC76d86m9+34fCVuYBMyrgX1opB7YlhUcW3OX9klw1fBXPQ
 sglg==
X-Gm-Message-State: ANhLgQ0gNymFZho/Nawdeke++PrJmChaONZX6SinDV8ufNHrOZTut/+9
 ltf0XSH14XeVOV2bQXg0WNiLvUhwlYdByvRA68O4Rw==
X-Google-Smtp-Source: ADFU+vs/3UZsGfY2wGEz6F2TCFOFL0vyEy6A+QC1RLfuoOld1A23BqiubstgaoDMK4Yxw54FsE+e/YwYOrAE5TuLfQE=
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr7249882wmc.39.1583385785517; 
 Wed, 04 Mar 2020 21:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20200225203224.1129396-1-alexander.deucher@amd.com>
In-Reply-To: <20200225203224.1129396-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Mar 2020 00:22:54 -0500
Message-ID: <CADnq5_MGixxj8tdOhb7Tg1hNEGGd7Ue0bgCEtKOYaD7n-u0K8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/display: fix pci revision id fetching
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aly-Tawfik <altawfik@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, Feb 25, 2020 at 3:32 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> From: Aly-Tawfik <altawfik@amd.com>
>
> Use the pci revision id rather than the asic silicon revision id.
>
> Signed-off-by: Aly-Tawfik <altawfik@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0c55d44c9d5b..92166150bf9f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -902,7 +902,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>
>         init_data.asic_id.chip_family = adev->family;
>
> -       init_data.asic_id.pci_revision_id = adev->rev_id;
> +       init_data.asic_id.pci_revision_id = adev->pdev->revision;
>         init_data.asic_id.hw_internal_rev = adev->external_rev_id;
>
>         init_data.asic_id.vram_width = adev->gmc.vram_width;
> --
> 2.24.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
