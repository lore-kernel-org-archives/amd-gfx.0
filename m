Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAA7C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 09:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01FF221F9
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="S/raARFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01FF221F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B5CA89949;
	Wed,  4 Nov 2020 09:39:21 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6B989306
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 09:39:19 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c17so1919502wrc.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2020 01:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=WUh7dQWB3Nw4YHmsebd1sLvvR/X71RnH4ab67Gv3wYk=;
 b=S/raARFJ/vaZ/Ot/IUwOIIlvXRpY2Yj4QIDnS33b2kN7/FIp3DkPR6yL6JXbOFtsun
 XCGQSHFeCkqm2rg/AGhFB1YHhvcd74hi+9A2IjEavLqPvuIl+cevnOkI1m7EnVPlArCM
 cnKSbnROs+/8v+9Q4NV02VA0gdUpsunZ5mcu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WUh7dQWB3Nw4YHmsebd1sLvvR/X71RnH4ab67Gv3wYk=;
 b=HWLTM0x8SEjuUDtofZFUI918lSWmPywsCR5FNR2qsDdeZ6cfs+y+sK5JyB7xPl3XK+
 H1C0oDgb8OVXF7XrcrqL3RD8u91c53s+rvXmRmccr967gIds2yyLIZQ+Nxymfp8VPHpn
 L84oW/bc8GkDmyAbwKFAcXgH6kpHSb51EayZd1/bqVgpfQXjfKZqNcviofctj0sh1oyl
 oBK43KhV2wredE8z+g5823YQRNpsRCmcH6KQGlKXCSW/4EdcaGwE+UjB3sd1FLxHoH+l
 Bi1CEIkzvgHs/kIN/68I/hv8W41vGl/MsgMEGFV0QjFIoRYkiuQLXGV6eh0AlErKXYT4
 3eEg==
X-Gm-Message-State: AOAM530vMgX9yTIXt7mNzH/dlWMMATinV1YXf0C0IxDjsdaqRq6BKAG5
 1SQ/PXupr9m+0PZJh5llY4Mx1w==
X-Google-Smtp-Source: ABdhPJxtU2fGVmmga0pww//IrX9t9qSL0oYjjC+akH8rJdZ27h5vdHBm9PUbTdi9DWr7TK8A6MJtGQ==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr30219067wrt.137.1604482758184; 
 Wed, 04 Nov 2020 01:39:18 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f17sm1784106wrm.27.2020.11.04.01.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 01:39:17 -0800 (PST)
Date: Wed, 4 Nov 2020 10:39:15 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/virt: fix handling of the atomic flag
Message-ID: <20201104093915.GL401619@phenom.ffwll.local>
References: <20201103215450.815572-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201103215450.815572-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: Alex Deucher <alexander.deucher@amd.com>, daniel.vetter@ffwll.ch,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 03, 2020 at 04:54:50PM -0500, Alex Deucher wrote:
> Use the per device drm driver feature flags rather than the
> global one.  This way we can make the drm driver struct const.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Can we merge this through drm-misc-next so I can follow up with the
drm_device constification series there? Otherwise I need to sit on that
for another few weeks until all the backmerges are done.
-Daniel

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index d0aea5e39531..8aff6ef50f91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -47,11 +47,13 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev)
>  
>  void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>  {
> +	struct drm_device *ddev = adev_to_drm(adev);
> +
>  	/* enable virtual display */
>  	if (adev->mode_info.num_crtc == 0)
>  		adev->mode_info.num_crtc = 1;
>  	adev->enable_virtual_display = true;
> -	adev_to_drm(adev)->driver->driver_features &= ~DRIVER_ATOMIC;
> +	ddev->driver_features &= ~DRIVER_ATOMIC;
>  	adev->cg_flags = 0;
>  	adev->pg_flags = 0;
>  }
> -- 
> 2.25.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
