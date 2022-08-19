Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3BCC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 19:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC74918BC84;
	Wed, 24 Aug 2022 19:17:22 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF2610E328
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Aug 2022 20:42:54 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id c185so5975589oia.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Aug 2022 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=3za8w/Kh9FMUewNDWqQO2iVNWIziP8AFXCV79g21n2k=;
 b=UHnfXMJJKlAvdQKQ59O4K//Z9WfN5sMBplv4AFhn/Eu8MzNe7UONz7P0tvheu/QBTG
 G/S1K45C9SiiO6ZxSHoRBVY5spgi2nRtMXxJZwzdU8mwtgz+yBG44FEqnyyC4GW/0VSU
 7Ews3q/82sBfBQvBz5Q3Hr+60o3HxiH3eL7FRAsL8e8kaLR8PXL4zvh0YmRpzBBgFW4w
 zLOC3j2JUut95C/La15P6WPSOtoenMBKdq1SXftS7vhtpI8Zze9aR411BLl689GPYykS
 NKxzs8kpBb2svmMLJTHZil+C5QxCuTdqsv5VlnF6u4Uo8VYNoR7c9szNRtX0TRIhoKGv
 DQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=3za8w/Kh9FMUewNDWqQO2iVNWIziP8AFXCV79g21n2k=;
 b=43d9QQQ50+P5etV4lSXXhL2tD5B+UyCBGB+yc9WTMkFt14SHlcadTIeYdXT760Ua0u
 rWxLnBJ90EX5Otnj7TU23OZNB0/Emtur3+WMUIJ5VTq1hvA+ZL1cvD55XqjxgEqHFzzF
 qlfTDORaQIzpAYWyHFP//pD5mvlTYCakAcfOSF71R0dlpYBYh0t2aa7YNGnG4KZJZdX2
 pwPUJcYmOa9xD50DPoFSa6xNSbLnB8+Qog9cmWD2joz4RjBAdapbCyx2YRCMoO3xRXzV
 S1UPazsYpNWyOQamVBUc38CXpQ+7iFyW7c83W4UatSdJ5DyPv2VlM+sNQyn3lGhIR5I8
 Au6g==
X-Gm-Message-State: ACgBeo1aGfoTRk6MeblkXO7rFJ1v1RVtbKZrmI+HU3vJypbWRN1D83Hd
 M434p1qIOem/Qj7zp5jFaqI88KLEN4jz4Ti6/U0=
X-Google-Smtp-Source: AA6agR7q/Lm31gLo/QOMvS74Iq7XygvfV4TP2eMYd+xuhUQ1gXHISYyxI78BXNJluylXLeg50gW4O9HMAo8eZf5uzpk=
X-Received: by 2002:a05:6808:1491:b0:343:7543:1a37 with SMTP id
 e17-20020a056808149100b0034375431a37mr4170866oiw.106.1660941773836; Fri, 19
 Aug 2022 13:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220719183436.1705006-1-alexander.deucher@amd.com>
In-Reply-To: <20220719183436.1705006-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Aug 2022 16:42:42 -0400
Message-ID: <CADnq5_M_U+XPHq9yfkkj+W6wi0nRDHKa4LkNmnEi_ZvDXv+6DA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: use proper DC check in
 amdgpu_display_supported_domains()
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

Alex

On Tue, Jul 19, 2022 at 2:35 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> amdgpu_device_asic_has_dc_support() just checks the asic itself.
> amdgpu_device_has_dc_support() is a runtime check which not
> only checks the asic, but also other things in the driver
> like whether virtual display is enabled.  We want the latter
> here.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index c20922a5af9f..b0fa5d065d50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -514,7 +514,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>          */
>         if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>             amdgpu_bo_support_uswc(bo_flags) &&
> -           amdgpu_device_asic_has_dc_support(adev->asic_type) &&
> +           amdgpu_device_has_dc_support(adev) &&
>             adev->mode_info.gpu_vm_support)
>                 domain |= AMDGPU_GEM_DOMAIN_GTT;
>  #endif
> --
> 2.35.3
>
