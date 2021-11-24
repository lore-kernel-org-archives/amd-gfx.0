Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46815C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 14:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1FEB6E4C5;
	Wed, 24 Nov 2021 14:22:44 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F996E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 14:22:43 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 b5-20020a9d60c5000000b0055c6349ff22so4435840otk.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 06:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PBiIGOtGF8PvgA1ZL7i3xoZsahrLbucyHlZHcGzkpZI=;
 b=DQr7yrv4wnqVBj+GvNybhIYhv4KqQpebZql6wRA0xKCGTC87XzEFEu6oNYorUKNfjp
 u3ytxoMBYzt2oh4FBoP74r6ETtO3qovRcMPa4Qeee0ktf6+PgpPF7CHsJvyn+rzg//AR
 i80Ez2NRZwI10DM9SG+C9hnQdiFuBHpJX00gShKbmo5da82hKjcoZp8H/Rpfl/jPm/97
 9EeSdQ9UYlRmsblwv4iWI8kdAyIZ0yr2gViQsWBhDZ5Zs1+ShzVGdaolWrwpnfHni2g6
 jfZoExvQ/UVTUGo3Q0jG2sOj/2DfQkN+f7ZubhhyqCBLexWZFsNZffCM6O+HnLsV8TI0
 ryvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PBiIGOtGF8PvgA1ZL7i3xoZsahrLbucyHlZHcGzkpZI=;
 b=dRAjEiwUXTEOD6am2JTJxoF/kmLOWuKIbaGSCzS1WT4SBVtgZ2QPOHM0JTOEAj2+KH
 LABy3NYutZu1ohqdr9nig+09uGMU5T64XZ7bxwyR4JHZDAg9wIs19UZe2/CKOC312veu
 AHY9c6qfD9fu39wZEUWpkQiB3xvtCgv+rT8LAHD91ogGnl1GHtXxQA1a90QtZqnawakI
 VsFCqDeGYmFyCVTijBzg/rQ4Aef1yk0/sUR7ODVPN/WDcZzre+1npB4ibkX6MgBWsXp8
 /8XGULSDv4VofXbROEDV5h2xHu5CJyPbvTKuKK94cthy7RP8ibsa/fEDo1dMQq8aLG3q
 18sg==
X-Gm-Message-State: AOAM531WFzDME2vdmxjajncrDkdJhY1LTnNPIS5PJQpCg1xGVr77onyi
 ivhk+bdKFqtP0yxh1WZr7GuNs8mTwNjuAEHzTmI=
X-Google-Smtp-Source: ABdhPJx7RZKQFITN+ewF0lbDUjpHzWxGRHqoigyvix/EbHKeYMqc6bTi0pZg5AOZeXRD32o7bv8ntkW5fe04xJbXJgM=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr13619198otn.299.1637763762439; 
 Wed, 24 Nov 2021 06:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20211124142036.22491-1-Jane.Jian@amd.com>
In-Reply-To: <20211124142036.22491-1-Jane.Jian@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Nov 2021 09:22:31 -0500
Message-ID: <CADnq5_P1=kz9dDwLtH98sHGgt6=C5Y=U1EoouGJktwFW0pBG7w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
To: Jane Jian <Jane.Jian@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Jingwen Chen <jingwen.chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 24, 2021 at 9:20 AM Jane Jian <Jane.Jian@amd.com> wrote:
>
> [WHY]
> for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia bandwidth feature),
> which will be mismatched with original vcn0 revision
>
> [HOW]
> add new version check for vcn0 disabled revision(3, 0, 192), typically modified under
> sriov mode
>
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 503995c7ff6c..3f9b7b0bab3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -923,6 +923,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>                                 amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
>                         break;
>                 case IP_VERSION(3, 0, 33):
> +               case IP_VERSION(3, 0, 192):
>                         amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
>                         break;
>                 default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 4f7c70845785..585961c2f5f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -135,6 +135,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>                 break;
>         case IP_VERSION(3, 0, 0):
>         case IP_VERSION(3, 0, 64):
> +       case IP_VERSION(3, 0, 192):
>                 if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
>                         fw_name = FIRMWARE_SIENNA_CICHLID;
>                 else
> --
> 2.17.1
>
