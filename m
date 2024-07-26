Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA7FC3DA7F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 07:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D52B10E942;
	Fri, 26 Jul 2024 07:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UquicRM4";
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEFDD10E91A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 05:00:24 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-267b7ef154aso563210fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 22:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721970024; x=1722574824; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lC/1+Rq9M2/d/DfolWrO+hBIeAhWV2SjsyoElLtfCCw=;
 b=UquicRM4hscMO1V57JEfvu4nwMmRYO7scXqt0h+DaCF01eseMcq3r8oAUH/PXwtlns
 IxKAHYw5G6CCXcsUZAWbtLJED4otgIZ+Q78iUR6WWtePVGKVxViWuqi2zx6ymTIbxpsQ
 hddXGePUqWwKXaVg+t1QINukJcqcRgG4dLEVCtbpL764Ky+Aht2S0DR0CZeaOUOdYT6z
 WMjllfB0ITtYziQlzZDoPPUmrsJYvNsz/4r+vxnknXP3kFRzABsGwzY3yhqWgjIuDL3N
 RiiooLJ6pilDNuttwqEdFTW/6vJQ2Ca9ncu8HXt6hKKwc2SLnD3fl2b2dB3rWq7OFhlN
 bhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721970024; x=1722574824;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lC/1+Rq9M2/d/DfolWrO+hBIeAhWV2SjsyoElLtfCCw=;
 b=lfExyUW3QpKhfy6/hVKZvgtH8W4MYlMo29I5aXdIfrrk59RMJb4l6YmC8sfDjKuvjW
 CZdYmZ69Hz5+8c2ViqJ5dFQBQwWx6fv+32gjHvcaXPYVfHaxs1NPy7rIpwQcikqVrmND
 uFI84QzgPr6Lqp66+VUyFig24Zi4nUdLKmt3cFvMQbQOnFg339Ou1FWbdzlfJB4T45Qe
 TJYmpwevQ9Oh0Ndbf65hUkfI8M59+mqYHeFauXucSCsD8tizxGNCEiIUW5RBfTST6xqr
 h0p5zPOU6+xv3igNhjfleoSqeTTt3VqQyYS3G7s5zgwHb5srSQ4/jGEGInjHygLIPqaY
 3E0g==
X-Gm-Message-State: AOJu0YxxN91SL2pz0zkr+j/fFYiKnef98yKHLnqSBYTk6DDntwfJx7Sz
 3B1mz3ZptICm09C2X/2iz02UQEtskNHmaFBomISRq2MFMDqPT/Uj83eZTlojbR4=
X-Google-Smtp-Source: AGHT+IGRTqQNDG+u6uZVytOJKshruMWW9eOlO1urAOeN0oHe0rUfaj3k9JsV+dZb/WXeI5F8YoAr2Q==
X-Received: by 2002:a05:6870:2104:b0:25e:2923:a379 with SMTP id
 586e51a60fabf-264a0c5dbd0mr6213263fac.16.1721970023816; 
 Thu, 25 Jul 2024 22:00:23 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:71d:9448:a412:cafd])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093072b795sm627936a34.42.2024.07.25.22.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 22:00:23 -0700 (PDT)
Date: Fri, 26 Jul 2024 00:00:21 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chaitanya Dhere <chaitanya.dhere@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: DML2.1 resynchronization
Message-ID: <91d2f01d-b38c-4674-90d2-f297733bb6af@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 26 Jul 2024 07:40:26 +0000
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

Hello Chaitanya Dhere,

This is a semi-automatic email about new static checker warnings.

Commit 2563391e57b5 ("drm/amd/display: DML2.1 resynchronization")
from Jul 2, 2024, leads to the following Smatch complaint:

    drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:3854 CalculateSwathAndDETConfiguration()
    warn: variable dereferenced before check 'p->UnboundedRequestEnabled' (see line 3698)

drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
  3697	
  3698		*p->UnboundedRequestEnabled = UnboundedRequest(p->display_cfg->overrides.hw.force_unbounded_requesting.enable, p->display_cfg->overrides.hw.force_unbounded_requesting.value, TotalActiveDPP, NoChromaOrLinear);
  3699	
  3700		CalculateDETBufferSize(
  3701			&scratch->CalculateDETBufferSize_locals,
  3702			p->display_cfg,
  3703			p->ForceSingleDPP,
  3704			p->NumberOfActiveSurfaces,
  3705			*p->UnboundedRequestEnabled,
  3706			p->nomDETInKByte,
  3707			p->MaxTotalDETInKByte,
  3708			p->ConfigReturnBufferSizeInKByte,
  3709			p->MinCompressedBufferSizeInKByte,
  3710			p->ConfigReturnBufferSegmentSizeInkByte,
  3711			p->CompressedBufferSegmentSizeInkByte,
  3712			p->ReadBandwidthLuma,
  3713			p->ReadBandwidthChroma,
  3714			p->full_swath_bytes_l,
  3715			p->full_swath_bytes_c,
  3716			p->DPPPerSurface,
  3717	
  3718			// Output
  3719			p->DETBufferSizeInKByte, // per hubp pipe
  3720			p->CompressedBufferSizeInkByte);
  3721	
  3722	#ifdef __DML_VBA_DEBUG__
  3723		dml2_printf("DML::%s: TotalActiveDPP = %u\n", __func__, TotalActiveDPP);
  3724		dml2_printf("DML::%s: nomDETInKByte = %u\n", __func__, p->nomDETInKByte);
  3725		dml2_printf("DML::%s: ConfigReturnBufferSizeInKByte = %u\n", __func__, p->ConfigReturnBufferSizeInKByte);
  3726		dml2_printf("DML::%s: UnboundedRequestEnabled = %u\n", __func__, *p->UnboundedRequestEnabled);
  3727		dml2_printf("DML::%s: CompressedBufferSizeInkByte = %u\n", __func__, *p->CompressedBufferSizeInkByte);
  3728	#endif
  3729	
  3730		*p->ViewportSizeSupport = true;
  3731		for (unsigned int k = 0; k < p->NumberOfActiveSurfaces; ++k) {
  3732	
  3733			DETBufferSizeInKByteForSwathCalculation = (dml_is_phantom_pipe(&p->display_cfg->plane_descriptors[k]) ? 1024 : p->DETBufferSizeInKByte[k]);
  3734	#ifdef __DML_VBA_DEBUG__
  3735			dml2_printf("DML::%s: k=%u DETBufferSizeInKByteForSwathCalculation = %u\n", __func__, k, DETBufferSizeInKByteForSwathCalculation);
  3736	#endif
  3737			if (p->display_cfg->plane_descriptors[k].surface.tiling == dml2_sw_linear) {
  3738				p->SwathHeightY[k] = MaximumSwathHeightY[k];
  3739				p->SwathHeightC[k] = MaximumSwathHeightC[k];
  3740				RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k];
  3741				RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k];
  3742	
  3743				if (p->surf_linear128_l[k])
  3744					p->request_size_bytes_luma[k] = 128;
  3745				else
  3746					p->request_size_bytes_luma[k] = 256;
  3747	
  3748				if (p->surf_linear128_c[k])
  3749					p->request_size_bytes_chroma[k] = 128;
  3750				else
  3751					p->request_size_bytes_chroma[k] = 256;
  3752	
  3753			} else if (p->full_swath_bytes_l[k] + p->full_swath_bytes_c[k] <= DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
  3754				p->SwathHeightY[k] = MaximumSwathHeightY[k];
  3755				p->SwathHeightC[k] = MaximumSwathHeightC[k];
  3756				RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k];
  3757				RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k];
  3758				p->request_size_bytes_luma[k] = 256;
  3759				p->request_size_bytes_chroma[k] = 256;
  3760	
  3761			} else if (p->full_swath_bytes_l[k] >= 1.5 * p->full_swath_bytes_c[k] && p->full_swath_bytes_l[k] / 2 + p->full_swath_bytes_c[k] <= DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
  3762				p->SwathHeightY[k] = MaximumSwathHeightY[k] / 2;
  3763				p->SwathHeightC[k] = MaximumSwathHeightC[k];
  3764				RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k] / 2;
  3765				RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k];
  3766				p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
  3767				p->request_size_bytes_chroma[k] = 256;
  3768	
  3769			} else if (p->full_swath_bytes_l[k] < 1.5 * p->full_swath_bytes_c[k] && p->full_swath_bytes_l[k] + p->full_swath_bytes_c[k] / 2 <= DETBufferSizeInKByteForSwathCalculation * 1024 / 2) {
  3770				p->SwathHeightY[k] = MaximumSwathHeightY[k];
  3771				p->SwathHeightC[k] = MaximumSwathHeightC[k] / 2;
  3772				RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k];
  3773				RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k] / 2;
  3774				p->request_size_bytes_luma[k] = 256;
  3775				p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;
  3776	
  3777			} else {
  3778				p->SwathHeightY[k] = MaximumSwathHeightY[k] / 2;
  3779				p->SwathHeightC[k] = MaximumSwathHeightC[k] / 2;
  3780				RoundedUpSwathSizeBytesY[k] = p->full_swath_bytes_l[k] / 2;
  3781				RoundedUpSwathSizeBytesC[k] = p->full_swath_bytes_c[k] / 2;
  3782				p->request_size_bytes_luma[k] = ((p->BytePerPixY[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
  3783				p->request_size_bytes_chroma[k] = ((p->BytePerPixC[k] == 2) == dml_is_vertical_rotation(p->display_cfg->plane_descriptors[k].composition.rotation_angle)) ? 128 : 64;;
  3784			}
  3785	
  3786			if (p->SwathHeightC[k] == 0)
  3787				p->request_size_bytes_chroma[k] = 0;
  3788	
  3789			if ((p->full_swath_bytes_l[k] / 2 + p->full_swath_bytes_c[k] / 2 > DETBufferSizeInKByteForSwathCalculation * 1024 / 2) ||
  3790				p->SwathWidth[k] > p->MaximumSwathWidthLuma[k] || (p->SwathHeightC[k] > 0 && p->SwathWidthChroma[k] > p->MaximumSwathWidthChroma[k])) {
  3791				*p->ViewportSizeSupport = false;
  3792				dml2_printf("DML::%s: k=%u full_swath_bytes_l=%u\n", __func__, k, p->full_swath_bytes_l[k]);
  3793				dml2_printf("DML::%s: k=%u full_swath_bytes_c=%u\n", __func__, k, p->full_swath_bytes_c[k]);
  3794				dml2_printf("DML::%s: k=%u DETBufferSizeInKByteForSwathCalculation=%u\n", __func__, k, DETBufferSizeInKByteForSwathCalculation);
  3795				dml2_printf("DML::%s: k=%u SwathWidth=%u\n", __func__, k, p->SwathWidth[k]);
  3796				dml2_printf("DML::%s: k=%u MaximumSwathWidthLuma=%f\n", __func__, k, p->MaximumSwathWidthLuma[k]);
  3797				dml2_printf("DML::%s: k=%u SwathWidthChroma=%d\n", __func__, k, p->SwathWidthChroma[k]);
  3798				dml2_printf("DML::%s: k=%u MaximumSwathWidthChroma=%f\n", __func__, k, p->MaximumSwathWidthChroma[k]);
  3799				p->ViewportSizeSupportPerSurface[k] = false;
  3800			} else {
  3801				p->ViewportSizeSupportPerSurface[k] = true;
  3802			}
  3803	
  3804			if (p->SwathHeightC[k] == 0) {
  3805	#ifdef __DML_VBA_DEBUG__
  3806				dml2_printf("DML::%s: k=%u, All DET will be used for plane0\n", __func__, k);
  3807	#endif
  3808				p->DETBufferSizeY[k] = p->DETBufferSizeInKByte[k] * 1024;
  3809				p->DETBufferSizeC[k] = 0;
  3810			} else if (RoundedUpSwathSizeBytesY[k] <= 1.5 * RoundedUpSwathSizeBytesC[k]) {
  3811	#ifdef __DML_VBA_DEBUG__
  3812				dml2_printf("DML::%s: k=%u, Half DET will be used for plane0, and half for plane1\n", __func__, k);
  3813	#endif
  3814				p->DETBufferSizeY[k] = p->DETBufferSizeInKByte[k] * 1024 / 2;
  3815				p->DETBufferSizeC[k] = p->DETBufferSizeInKByte[k] * 1024 / 2;
  3816			} else {
  3817	#ifdef __DML_VBA_DEBUG__
  3818				dml2_printf("DML::%s: k=%u, 2/3 DET will be used for plane0, and 1/3 for plane1\n", __func__, k);
  3819	#endif
  3820				p->DETBufferSizeY[k] = (unsigned int)(math_floor2(p->DETBufferSizeInKByte[k] * 1024 * 2 / 3, 1024));
  3821				p->DETBufferSizeC[k] = p->DETBufferSizeInKByte[k] * 1024 - p->DETBufferSizeY[k];
  3822			}
  3823	
  3824	#ifdef __DML_VBA_DEBUG__
  3825			dml2_printf("DML::%s: k=%u SwathHeightY = %u\n", __func__, k, p->SwathHeightY[k]);
  3826			dml2_printf("DML::%s: k=%u SwathHeightC = %u\n", __func__, k, p->SwathHeightC[k]);
  3827			dml2_printf("DML::%s: k=%u full_swath_bytes_l = %u\n", __func__, k, p->full_swath_bytes_l[k]);
  3828			dml2_printf("DML::%s: k=%u full_swath_bytes_c = %u\n", __func__, k, p->full_swath_bytes_c[k]);
  3829			dml2_printf("DML::%s: k=%u RoundedUpSwathSizeBytesY = %u\n", __func__, k, RoundedUpSwathSizeBytesY[k]);
  3830			dml2_printf("DML::%s: k=%u RoundedUpSwathSizeBytesC = %u\n", __func__, k, RoundedUpSwathSizeBytesC[k]);
  3831			dml2_printf("DML::%s: k=%u DETBufferSizeInKByte = %u\n", __func__, k, p->DETBufferSizeInKByte[k]);
  3832			dml2_printf("DML::%s: k=%u DETBufferSizeY = %u\n", __func__, k, p->DETBufferSizeY[k]);
  3833			dml2_printf("DML::%s: k=%u DETBufferSizeC = %u\n", __func__, k, p->DETBufferSizeC[k]);
  3834			dml2_printf("DML::%s: k=%u ViewportSizeSupportPerSurface = %u\n", __func__, k, p->ViewportSizeSupportPerSurface[k]);
  3835	#endif
  3836	
  3837		}
  3838	
  3839		*p->compbuf_reserved_space_64b = 2 * p->pixel_chunk_size_kbytes * 1024 / 64;
  3840		if (*p->UnboundedRequestEnabled) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Everything check if enabled is true

  3841			*p->compbuf_reserved_space_64b = (unsigned int)math_ceil2(math_max2(*p->compbuf_reserved_space_64b,
  3842				(double)(p->rob_buffer_size_kbytes * 1024 / 64) - (double)(RoundedUpSwathSizeBytesY[SurfaceDoingUnboundedRequest] * TTUFIFODEPTH / (p->mrq_present ? MAXIMUMCOMPRESSION : 1) / 64)), 1.0);
  3843	#ifdef __DML_VBA_DEBUG__
  3844			dml2_printf("DML::%s: RoundedUpSwathSizeBytesY[%d] = %u\n", __func__, SurfaceDoingUnboundedRequest, RoundedUpSwathSizeBytesY[SurfaceDoingUnboundedRequest]);
  3845			dml2_printf("DML::%s: rob_buffer_size_kbytes = %u\n", __func__, p->rob_buffer_size_kbytes);
  3846	#endif
  3847		}
  3848	#ifdef __DML_VBA_DEBUG__
  3849		dml2_printf("DML::%s: compbuf_reserved_space_64b = %u\n", __func__, *p->compbuf_reserved_space_64b);
  3850	#endif
  3851	
  3852		*p->hw_debug5 = false;
  3853		for (unsigned int k = 0; k < p->NumberOfActiveSurfaces; ++k) {
  3854			if (!(p->mrq_present) && (!p->UnboundedRequestEnabled) && (TotalActiveDPP == 1)
                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^
This checks if the pointer to enabled is NULL.  Probably *p was intended.


  3855				&& p->display_cfg->plane_descriptors[k].surface.dcc.enable
  3856				&& ((p->rob_buffer_size_kbytes * 1024 * (p->mrq_present ? MAXIMUMCOMPRESSION : 1)

regards,
dan carpenter
