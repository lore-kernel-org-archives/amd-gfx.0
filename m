Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E40C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 18:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EB861154
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 18:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B7EB861154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ECDE6EA77;
	Wed, 13 Oct 2021 18:20:48 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD6E6EA77
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 18:20:46 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 62-20020a9d0a44000000b00552a6f8b804so4253807otg.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hiy2L543+OOFHcrIJlhRdDTSEae9Bgj8fBEnl5ZOrBk=;
 b=ZHD7lpBx5uFFXy34Z+WtQLA6Z3qziB3OwW1x7G5nT0EKBVNQCyCyZy/kqI0pBXTtY/
 j4deK0E3WDKHSLOj7FubQsz380PyESSzV1hEmFKBFCkecn9heXVgzoO2OJl+CzFvrdye
 IuvoqYkm80n2rYjcqm5B1SeFbnDcrNQMFQkqouSWE3LBrq/8fI8nOyy65up6sYWpcEOP
 9irxPXBpzJ4upPPmW8pfJ+9ZspFvg947ZaSZKip5oSA2EwuZHbxI3oKmkBL4U7h7go2A
 WqKk/gi4yvp51NgdslOyWDqugeo8nVxnKpYRtpiZfmhHJFt/pLfHsnw6a+JiN5K+HToS
 TSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hiy2L543+OOFHcrIJlhRdDTSEae9Bgj8fBEnl5ZOrBk=;
 b=UYyzczuCHz8KeDViiJl5uBxRs8sySJLxwnOK6eIIsmlj9nOn35r9NE9SQuL+OWs1sj
 7DCipVNvM++JNoC3kfNfYMEnoehffEBvyGqJkIrlfXXfYoPmfpNlPz2w20ghv3QRO0zm
 sJaB2GH3TwJT9dEmcir4PnEykC6RiXb7A5CPjIxXQ1DcHgNGKVRBh61ZIidyoTiKBo4v
 J4R1rg8iMoS7g9wsTrLW7EIZskyLEByYV81gEui5eeMidjwv1BI0LZA6l5Zrjp92zGY/
 y9/pJGkLg9zeYEXYXXnxusbTxSG/6pH74RPj+3kewQhL2yKCsZj8jq1fB5L6IWgGSANc
 etqQ==
X-Gm-Message-State: AOAM530HmGuGAgplPQj891SIca6VOLhUFL4L9sQaCYCRBvge8ZqBdz4T
 wKR8XGqKqOlHz//aWwP3NQLFBwyGlxiD8IX88y6e+lOducI=
X-Google-Smtp-Source: ABdhPJxHJRcuQ+j6U7YV3NDzeW8mqzl/OTDTdvtTMJHng5mRT0AYkzlP4GzrCeuei0zesj417Esc6Luuqtz4lXBPT8s=
X-Received: by 2002:a05:6830:23ac:: with SMTP id
 m12mr644132ots.357.1634149246250; 
 Wed, 13 Oct 2021 11:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211011150217.165699-1-alexander.deucher@amd.com>
In-Reply-To: <20211011150217.165699-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Oct 2021 14:20:35 -0400
Message-ID: <CADnq5_M3PZzbDoiirQ-59BapS0bMPwwTuuyT=ACbTyVd0+6EQw@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdkfd: protect hawaii_device_info with
 CONFIG_DRM_AMDGPU_CIK
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

Ping on this series.

On Mon, Oct 11, 2021 at 11:02 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> hawaii_device_info is not used when CONFIG_DRM_AMDGPU_CIK is not
> set.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 064d42acd54e..31e255ba15ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -114,6 +114,7 @@ static const struct kfd_device_info raven_device_info = {
>         .num_sdma_queues_per_engine = 2,
>  };
>
> +#ifdef CONFIG_DRM_AMDGPU_CIK
>  static const struct kfd_device_info hawaii_device_info = {
>         .asic_family = CHIP_HAWAII,
>         .asic_name = "hawaii",
> @@ -133,6 +134,7 @@ static const struct kfd_device_info hawaii_device_info = {
>         .num_xgmi_sdma_engines = 0,
>         .num_sdma_queues_per_engine = 2,
>  };
> +#endif
>
>  static const struct kfd_device_info tonga_device_info = {
>         .asic_family = CHIP_TONGA,
> --
> 2.31.1
>
