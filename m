Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A955C63797
	for <amd-gfx@archiver.kernel.org>; Sun, 15 Jan 2023 15:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E6C10E380;
	Sun, 15 Jan 2023 15:41:27 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BC210E37F
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Jan 2023 15:41:25 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 k44-20020a9d19af000000b00683e176ab01so14886910otk.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Jan 2023 07:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XOuan4LsCgRqpEescxEfB9Yp34m7vUZ9ubhoTXItw4M=;
 b=jMF3nUMXCg3r1DdU4FI+GyRQa9irIGqSBlh21rN4Mg1OfJ6ZGgY0zg4pVw0y/1xMMx
 l24WJXPXwNTx4cPnAJSB0e93RcD4dcUmZRbynKME9AUdh53+2HzPF3XqG7CLRfdG6cYp
 kXcSjzyva6FVS1KGsABBHHIeELl/trM9JQTD6X42xPro96oJWJODWaNQZ7HsmSfkIRTv
 5+1fAQ3GtvDQsAybPkmg/anKM0s0V6eL/Wv7l6CZTxcMsEw33DyY7Z2nQukPIcGIqas/
 H5hKLnHaWKxT5vvM1vU7KSJpq+8qjWUBDs9nDs1+QXJ+wf2QiF2jVH+LItPHPaRq51TD
 lWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XOuan4LsCgRqpEescxEfB9Yp34m7vUZ9ubhoTXItw4M=;
 b=yUrRG0JCUZJIgtGaQRi5CpxtlO/1xSKXqWIcge+Uo60FbheGLNbS6JpHZwb/Na9k01
 SWp8ZJuacTaZ+IWcPmm/Te8JhW8R9qPawWuvhzHc6ithtuVtxKfg9hMcJD59yMqp8tP2
 7sPEn6nWyuEPQloOcTYL8UQB2pLoivwTz0wxJw6PLPF+SOIzme9LjRP1ZYsnP105MBTM
 7xns/tKpqVYe1KJA6+15N1Kp3pYbxGT+cGY2+++fhcAjdbFndFi5x/kwk7qjDeNKD7YB
 nEOPlRM+wgf2JAW3LZhqrYXje9VP0w6d10Pq9bunmAjupOQcJ27v4Wnapy7sWQQg4koP
 dE2A==
X-Gm-Message-State: AFqh2ko4pL1nfinY8c7hc7Ixp+ZOD70Xn01S9L5Uo4ULIogCFLIYe7nh
 i2Mw1A/Zdn2A5YRutga8tgAOyoqGUBtNkapzEb4WM+Dc
X-Google-Smtp-Source: AMrXdXsvCm0L3a6rXWdIpHsKCh8Pcs3U8DOcCWI02xYQSSQvWWfBVXTypomNenlrlIT1yHlxpsEcDJUtLR/wgdlftEk=
X-Received: by 2002:a9d:62d1:0:b0:675:cde9:90b9 with SMTP id
 z17-20020a9d62d1000000b00675cde990b9mr5738407otk.123.1673797284579; Sun, 15
 Jan 2023 07:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20230114030148.139-1-mario.limonciello@amd.com>
In-Reply-To: <20230114030148.139-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 15 Jan 2023 10:41:13 -0500
Message-ID: <CADnq5_P5kQ99vwLviYh+Gsr=DJ+8zRb4LYbFe1yCT_j7XZcaWA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix renoir/green sardine MP0 IP version detection
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
Cc: Alex Hung <Alex.Hung@amd.com>, Nicholas Choi <Nicholas.Choi@amd.com>,
 Ekene Akuneme <Ekene.Akuneme@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 13, 2023 at 10:02 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The existing codebase never had a case for detecting MP0 version on
> Renoir and instead relied upon hardcoded chip name.  This was missed as
> part of the changes to migrate all IP blocks to build filenames from
> `amdgpu_ucode.c`.
>
> Consequently, Renoir tries to fetch a binary with 11_0_3 in the filename
> and since it's supposed to have "renoir" in the filename fails to probe.
> The fbdev still works though so the series worked.
>
> Add a case for Renoir into the legacy table to ensure the right ASD and
> TA firmware load again.
>
> Reported-by: Ekene Akuneme <Ekene.Akuneme@amd.com>
> Reported-by: Nicholas Choi <Nicholas.Choi@amd.com>
> Cc: Alex Hung <Alex.Hung@amd.com>
> Fixes: 994a97447e38 ("drm/amd: Parse both v1 and v2 TA microcode headers using same function")
> Fixes: 54a3e032340e ("drm/amd: Add a legacy mapping to "amdgpu_ucode_ip_version_decode")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 47549d659d9b0..c03824d0311bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1087,6 +1087,8 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
>                         return "navi10";
>                 case IP_VERSION(11, 0, 2):
>                         return "vega20";
> +               case IP_VERSION(11, 0, 3):
> +                       return "renoir";
>                 case IP_VERSION(11, 0, 4):
>                         return "arcturus";
>                 case IP_VERSION(11, 0, 5):
> @@ -1104,12 +1106,7 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
>                 case IP_VERSION(11, 5, 0):
>                         return "vangogh";
>                 case IP_VERSION(12, 0, 1):
> -                       if (adev->asic_type == CHIP_RENOIR) {
> -                               if (adev->apu_flags & AMD_APU_IS_RENOIR)
> -                                       return "renoir";
> -                               return "green_sardine";
> -                       }
> -                       break;
> +                       return "green_sardine";
>                 case IP_VERSION(13, 0, 2):
>                         return "aldebaran";
>                 case IP_VERSION(13, 0, 1):
> --
> 2.34.1
>
