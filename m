Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB928C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 16:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FB661213
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 16:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98FB661213
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3993873219;
	Thu,  4 Nov 2021 16:35:32 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFABD73219
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 16:35:30 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id x70so10153214oix.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Nov 2021 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=An++C1SSs9BVk4b5PeMs3Ss0SCY1JWsjf5YfOb13ZgI=;
 b=jtQ1FxSLBDwH961XYn8GbdcIo7+OnQoTWca2R+bzMzjHpCqoT1IBniD/M1n7NaChaS
 tFH1iJkwgXJCUch61yFVpsZseMiaTOBZuvQoLSO1ETqtJLPAV/dXJjL5jSzgJXP9WSP6
 JXXkrf7DJmmPulb/ROM1VIw08FQ61ORpMIRbZulA4HBouEesiC6BFDHBCE1IiVC/beEQ
 7v7s+EXiXqJ2C3Ao48abM4vz/lx35jr4AYa2ODjD8f8KGfKu1g4ssp8smUYv7814/l0W
 oXSfm8QhjVnKCN4mGA5Ij3xjEJzNrbUfptH8zh5Kt1j4FSzUQBlmWL73kLNHbqoWS/8M
 /GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=An++C1SSs9BVk4b5PeMs3Ss0SCY1JWsjf5YfOb13ZgI=;
 b=yR7mSua0dWLHSsVLQqB1PxyR5ODOZpk+enOz9DscoEvX+2T4CHoLfWZrtzr4p4953F
 4YgKCSdWZSk+QGW2IzTH5xiEyAsDGR9q1MTcdNa8f98WL5pcifq12cFPfPUWUH4yoMFR
 A2Jjusg08SmEUcARGZxSVB3KRHzidyXBwBvu+/KgAgjnzXEJml9sv6Eapd96aZd4inxL
 GwDdCU45dIoiG9N7u85DKuQr33/XNuZONdz3QRaxUx060zNvHBvvXV+6Ntq5jaJkCxpU
 vMWZFfBq9/yfgorU/YS950MdwwNgLNrPkHVf1Ov2e8nfazH60yMX6gW22ILzEiOr/aQ+
 fi3A==
X-Gm-Message-State: AOAM5321w1Z/zGOk0lfJuKxp/JGFtIhvjp6fb3NnpwEWgkCTN6pY+jTr
 ucqHngT299CWCUwq2RYRFFB9J3+tXkXm+Qjqwr+UlziJ
X-Google-Smtp-Source: ABdhPJz9BI2rHWogwEWDa3AQ13tgp5bW94vP1gZK2J8LlVu16+W6dvwLZy/edeV2VyaXcElGiMEQHrXGTaMm3HdhDA0=
X-Received: by 2002:aca:e08a:: with SMTP id
 x132mr16944703oig.120.1636043729981; 
 Thu, 04 Nov 2021 09:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211104160856.26220-1-mario.limonciello@amd.com>
In-Reply-To: <20211104160856.26220-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Nov 2021 12:35:19 -0400
Message-ID: <CADnq5_Pv6T4_9KqTcxBDdQhVmeEzgrvzS=GfsC+oUv=uON7wWw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Correct DPMS disable IP version check
To: Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 4, 2021 at 12:09 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Previously there was a check based on chip # for chips that aligned to
> >=CHIP_NAVI10 to have RLC stopped as part of DPMS check.  This was because
> of gfxclk being controlled by RLC in the newer designs.
>
> As part of IP version checking though, this got changed to match IP
> version for SMU.  Because Renoir designs also include smu11 that meant
> that even GFX9 started to stop RLC earlier.
>
> Adjust to match GFX IP version instead of SMU IP version to restore the
> previous behavior.
>
> Fixes: a8967967f6a5 ("drm/amdgpu/amdgpu_smu: convert to IP version checking").
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Good catch.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 821ae6e78703..01168b8955bf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1468,7 +1468,7 @@ static int smu_disable_dpms(struct smu_context *smu)
>                         dev_err(adev->dev, "Failed to disable smu features.\n");
>         }
>
> -       if (adev->ip_versions[MP1_HWIP][0] >= IP_VERSION(11, 0, 0) &&
> +       if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0) &&
>             adev->gfx.rlc.funcs->stop)
>                 adev->gfx.rlc.funcs->stop(adev);
>
> --
> 2.25.1
>
