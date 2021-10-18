Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D040EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 13:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993A1613DA
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 13:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 993A1613DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3753A6E0AA;
	Mon, 18 Oct 2021 13:36:23 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E566E0AA
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 13:36:22 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 x33-20020a9d37a4000000b0054733a85462so4372585otb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BJQ4Hx6igR/GK+gKVlCduHCVPYYZDLUizkAUlSuP4Lk=;
 b=FG2ntu2KHHHpADfFwvbsaEHnbsT7gxuPeZDhodr2kimzX3YNmV+CU22s6YDW7wMwCk
 mOi5Q4LJxZkPEbvSWy9RKsOGM2+BNPfQVHVM5opbRiDBpRCUOMMcPVegb2aBrNbrgdmi
 B+tc8eW/ufhU+JKS+aobKKC1P1f71zBfqnbLANIrxj3mEmSVYENsg6BwFX0zqIqJ6KMX
 +XPbqUQyxRVCQn59FUSaDGhGNjWBTjf91rSCr3YJ84Ah1ewz0uLY9k+M/cNEAU0im7ek
 yhSuN36+YilkU8MRVqOapsg+Yga0YNp+olslZmshHprY/JL668Qigg9uRYr9Y+tygLbt
 ZlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BJQ4Hx6igR/GK+gKVlCduHCVPYYZDLUizkAUlSuP4Lk=;
 b=cVWcBrTRewqJ1w0G0lTqItaAOVzmHMZsqLvMppW7ysb8VyOc1M4shPy10Lmm3jFibn
 odOVV6Z8i9lpIb3wOkeloI42hMHPr0KZVQEJY3tH02oUIw2EJXNS6sn6dK1Qk/ivRKNO
 05dOUsh8ML0yROnxdbQAeDbt8lTueUw92XwHZtXoBZGQZZ+LZxa2NVYOt6qf8AO7ubSW
 R6FWjA+mR+nsYexRO6WkjAjLzbxLFZPGGRY6ErgLKbWvVe+mGuq0UYjAegXhKJTpnjmJ
 ojogCui5F6OeoKKWvVjATU8rLbtGRNvMpb9MRp2J9Zk8caMmMAahHFW9zgOj0sJZ1RT3
 MySQ==
X-Gm-Message-State: AOAM532RGmDiNc+eduSJKTdhE/cryf6MJuL5jLW3JU569GaS7+pZ7CgL
 jruOxyJTAiiDxxlB577eQFIwMDEkD0F7MjP3vQI=
X-Google-Smtp-Source: ABdhPJy5ETyCXd2L1tAxnsUPKzsSn8l88O5wbo8x1aTTt/eKq95Kai6t4ZWLsdntz2Igzr6DxE1e4GxDyiBA8Z9ISH0=
X-Received: by 2002:a05:6830:23ac:: with SMTP id
 m12mr22401395ots.357.1634564181512; 
 Mon, 18 Oct 2021 06:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <1634337100-12682-1-git-send-email-Roman.Li@amd.com>
In-Reply-To: <1634337100-12682-1-git-send-email-Roman.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Oct 2021 09:36:10 -0400
Message-ID: <CADnq5_PqKjh7dZoAf9B428pYFG-amOFADeYqZR=McB37Avv3FQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fully switch to dmub for all dcn21 asics
To: Roman Li <Roman.Li@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Siqueira,
 Rodrigo" <rodrigo.siqueira@amd.com>, "for 3.8" <stable@vger.kernel.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 15, 2021 at 6:33 PM <Roman.Li@amd.com> wrote:
>
> From: Roman Li <Roman.Li@amd.com>
>
> [Why]
> On renoir usb-c port stops functioning on resume after f/w update.
> New dmub firmware caused regression due to conflict with dmcu.
> With new dmub f/w dmcu is superseded and should be disabled.
>
> [How]
> - Disable dmcu for all dcn21.
>
> Check dmesg for dmub f/w version.
> The old firmware (before regression):
> [drm] DMUB hardware initialized: version=0x00000001
> All other versions require that patch for renoir.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1735
> Cc: stable@vger.kernel.org
> Signed-off-by: Roman Li <Roman.Li@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ff54550..e56f73e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1356,8 +1356,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>                 switch (adev->ip_versions[DCE_HWIP][0]) {
>                 case IP_VERSION(2, 1, 0):
>                         init_data.flags.gpu_vm_support = true;
> -                       if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
> -                               init_data.flags.disable_dmcu = true;
> +                       init_data.flags.disable_dmcu = true;
>                         break;
>                 case IP_VERSION(1, 0, 0):
>                 case IP_VERSION(1, 0, 1):
> --
> 2.7.4
>
