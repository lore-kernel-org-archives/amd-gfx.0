Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A387C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 13:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6903D10E250;
	Thu, 13 Oct 2022 13:50:59 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A5B10E249
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 13:50:55 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 cb2-20020a056830618200b00661b6e5dcd8so68092otb.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GLKEIkf69T6/41YJhZRH9+trk97p+dvXNbCeOoIw+68=;
 b=ZnFPYqXgAp1//BrvhSO0GE99gosuXNrcLDTqG2bwQZKTYxukfa/RjV2ex3RWRSVYwo
 K7NI/cS2zs88PvNS4yBsXTiXSrhPCMLzDAe/b9n//n7u4dcRGoeOSx9h00vRadQa7eXG
 Cug1hFnYcgUcVRS19b/rVG4u5qxY64hLW5wpJYqVB9g+ZrdxCJenuH/OdvpCQIiCEwT5
 jRLykP73xCMH2asNVVV1Inbh5aLWl5C7DV30oqHHwvNEOBigJDuSszr/XvPrSGclpbAH
 0rzY4diZtPUY7erenbXcrDG0Qrec0TePxE2PfKiLzfNU/6Z2v81fRqpaicHAg5bfRHTb
 VXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GLKEIkf69T6/41YJhZRH9+trk97p+dvXNbCeOoIw+68=;
 b=crDSVBCCGI2uZvpdzZB/FdQ8pWO0QEimw2CDL6xj1gG2oxObpO+FRD2EppOTfzbmKK
 M93dFP8p6udddRsEqCJ7G/GvEDCAtqwDzOij42rM/Supab8YluOVORAyU3BOXE+hJ2ES
 s90qGF5ULAv7Btj3EroKBj4fHP1jbI8YYXbPKMTWt8aBM4NGijcplC9zXXXjizVuuUvF
 urMSjDiQHLdYTVTS1qHXBzkPSfTU99o7JZTREz8mMxI/y49DrqDZ4wMvbITvyFH0fNkL
 Xo2RF/OSvYEVdOLzAhWHZHd5gNXObJQTxcqE5uKuaj2U+9E85faPsseGJ6079blMMpoo
 zd0w==
X-Gm-Message-State: ACrzQf3RJ7TaxcMuKIeSiAtWULEYBV7/kkIJ/o3qVCyU/bjky4DLw6Gr
 9OHH5pa6p4EhzZboVZ+ThjWxXN2jKGhnJxNHVHM=
X-Google-Smtp-Source: AMsMyM4D+/shIZv7ID3EmKxLAsDhL6sZc4XDg9aWizpRDABAopA5wBv+Lk3y+5FnF62sVHa69is4Kr4isekU3yjkNo4=
X-Received: by 2002:a9d:6645:0:b0:661:b778:41b8 with SMTP id
 q5-20020a9d6645000000b00661b77841b8mr28824otm.233.1665669054288; Thu, 13 Oct
 2022 06:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221012093608.1496302-1-zhenguo.yin@amd.com>
In-Reply-To: <20221012093608.1496302-1-zhenguo.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Oct 2022 09:50:42 -0400
Message-ID: <CADnq5_NaHddp=Lhdjw6sXSvshp+urSSh=iYaQfqksUq8B3fboQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Init pm_attr_list when dpm is disabled
To: ZhenGuo Yin <zhenguo.yin@amd.com>
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
Cc: jingwen.chen@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 12, 2022 at 5:36 AM ZhenGuo Yin <zhenguo.yin@amd.com> wrote:
>
> [Why]
> In SRIOV multi-vf, dpm is always disabled, and pm_attr_list won't
> be initialized. There will be a NULL pointer call trace after
> removing the dpm check condition in amdgpu_pm_sysfs_fini.
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> RIP: 0010:amdgpu_device_attr_remove_groups+0x20/0x90 [amdgpu]
> Call Trace:
>   <TASK>
>   amdgpu_pm_sysfs_fini+0x2f/0x40 [amdgpu]
>   amdgpu_device_fini_hw+0xdf/0x290 [amdgpu]
>
> [How]
> List pm_attr_list should be initialized when dpm is disabled.
>
> Fiexes:894483d76ada ("drm/amd/pm: Remove redundant check condition")

typo.  Should be:
Fixes: 894483d76ada ("drm/amd/pm: Remove redundant check condition")

Either this patch or reverting 894483d76ada is fine with me.  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 948cc75376f8..236657eece47 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3362,11 +3362,11 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>         if (adev->pm.sysfs_initialized)
>                 return 0;
>
> +       INIT_LIST_HEAD(&adev->pm.pm_attr_list);
> +
>         if (adev->pm.dpm_enabled == 0)
>                 return 0;
>
> -       INIT_LIST_HEAD(&adev->pm.pm_attr_list);
> -
>         adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
>                                                                    DRIVER_NAME, adev,
>                                                                    hwmon_groups);
> --
> 2.35.1
>
