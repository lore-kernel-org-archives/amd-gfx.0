Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D0ECCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F77610E4BA;
	Mon,  3 Nov 2025 22:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kHgj3ojc";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 753BA10E4BA
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:23:57 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-63b9da57cecso8426655a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208636; x=1762813436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yThTFgTs5HBWG1CTssJb4tIaYMuDGPR66w4ax2GtJcI=;
 b=kHgj3ojcoz+46YPdqdyMYx37TbRtN2XJDLJRde2zAvDHuRISqNxw71Qlnl55x1X5mq
 0SrkL6s5mbPrGamArjNu0cc8R5joOlC9d355UKDq2YRZCYU4N1dytoHBNKDUo7yrM+K6
 eVO1GmX9QjacCNZiexIOMPG6/BVVeLcqj7f8R45tEpyibPyzLbmHNKm3QpHjyW0yYd+a
 0awm0Bg9bX1FapVo5fc9CNwGSAiJ1emXRUcc+j8OoK3TtybbVs/qxOdKiM7ogYPGvz20
 ZXUKES0y5f2r13zWf6m+mVRs0qEskqO8jX+EX7X9q7bPtJ0TDeX3OVgdU/L8AKfFjijE
 iYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208636; x=1762813436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yThTFgTs5HBWG1CTssJb4tIaYMuDGPR66w4ax2GtJcI=;
 b=hCmao+ztKQRrvKS66go0ZHeMZpZidJagxLQzczROTZ/qskh9mld5j8xADVLlGWRihC
 7UeyLIOciuwIPKnjPYLNEx/MG1GSFkxfoLHuYr7Gg6ERVKCpR1BBISTiAW/Gqt4G1fv1
 AHTQ6IxvEgaT1LLSs7Mo+C6KFYfF7v73GXI9v9dlmjbmTFmKq9hqWyRLTSwz2+q9O5iL
 bBzqMnAkmUMfitWgyCvI23XvXgSZGvHV9qiKZtzSICr9bPctyzzDN5Zbr9K272mCOipz
 yEhbON1d/P6siLGb3u4c9DG+5FKgZqvLvH0tO5imOjNyqR3LCyzPCkR8+/YuodbNvWYf
 C+ZA==
X-Gm-Message-State: AOJu0YxrcMflcJ1fAm2wbuxfwW+BiRfL0qConNCvbzcVG6YS2VLd12O5
 STX/jUP8VOh7qRwDavsSz5dshvW0dzYavFnt1rBPCMyTtxur8axcJRStq1dpe4QG
X-Gm-Gg: ASbGnctHMYY37qfeBsWldpho8RFrv+lTxAbSMU3ujExOA/SPXqwfaCCRygOJp0RPYng
 08Pm+M1TVcB3M5tTSQXPoss/QJTPxQGtqlDqO6KZDyqTS3XLXn4bWEzGpB/hP+EKjvH/HopK1ze
 P9j8bR42Gzs4LrXQKT5CNtJbObzyRGSvYxpo0a1/ZI0a2hCTaStK5eC6kuKcjiUSU/AS9W6yHRa
 SqoZbFOl+YHvqtmDwekG/AEnaG3rqQAsT57t9d1Nz9+1BUiYo9esZLVzjgjK5DXeNk3NQz34oIG
 ipnXT2APy9P52akL3i+30S7fSM/P3JPsqs5iolZ9kUs2abYQkuOnrbQqhF4mXkZouIWN28iaSKA
 39/gFpZLeg/pDjnY7tPj3I0eFRgHARJMd0zg0rkVSZFEXLd5wdLhRCGiEFINpxZWi2VvJbsACdt
 XJOqBvCP3i7/uA2peia0MzOlmNLuX9iA==
X-Google-Smtp-Source: AGHT+IFXras91M3zbaYQVR3V39rNXyqjPbau9SS0llW9EKNH4vuqzW5QgV2oEyH4JzRcL9BW3TyJSg==
X-Received: by 2002:a05:6402:358f:b0:640:7f9c:e90c with SMTP id
 4fb4d7f45d1cf-6407f9cf5e4mr11685908a12.27.1762208635862; 
 Mon, 03 Nov 2025 14:23:55 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:23:54 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 03/16] drm/amdgpu/gmc6: Add GART space for VCPU BO (v2)
Date: Mon,  3 Nov 2025 23:23:20 +0100
Message-ID: <20251103222333.37817-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Add an extra 512 pages (2 MiB) to the GART before GTT.
This space is going to be used for the VCE VCPU BO.

Split this into	a separate patch to make it easier to bisect,
in case	there are any errors in	the future.

v2:
- Reduce extra space from 16 MiB to only 2 MiB
- Keep total GART size at 1024 MiB

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 499dfd78092d..683bfe7f2770 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -214,6 +214,9 @@ static void gmc_v6_0_vram_gtt_location(struct amdgpu_device *adev,
 	amdgpu_gmc_set_agp_default(adev, mc);
 	amdgpu_gmc_vram_location(adev, mc, base);
 	amdgpu_gmc_gart_location(adev, mc, AMDGPU_GART_PLACEMENT_LOW);
+
+	/* Add space for VCE's VCPU BO so that VCE1 can access it. */
+	mc->num_gart_pages_before_gtt += AMDGPU_GTT_MAX_TRANSFER_SIZE;
 }
 
 static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
-- 
2.51.0

