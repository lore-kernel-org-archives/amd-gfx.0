Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85058C36005
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76ED410E851;
	Sat, 22 Mar 2025 01:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lPpXEaZ4";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738D610E855
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:17 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7c54b651310so398689885a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608036; x=1743212836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=97a57FFucYk6i0P8dY0xsS4aMg003QyZQ+q8Q+4QQfA=;
 b=lPpXEaZ414HfwA3Hwq1HIQfhp/nojXd2GYZmCC96qE5mxL6m3PM4WJ2P+8/3y2LU3G
 5e4Kb56WYuiMhJU7nyotU57GhbaQasB2FHnIqKK5270asnuQ3dydKKeJcMc+zp58r7lQ
 e7e09m6Qt1xgWD7dR0ZjlJYKw4SFU3sxbQVv+Sj4K3uFtIA4uB42bgb//YMWocltbCRD
 RqzsqX6ZX0JCU/8+gU0amV0k1fQC9K771Eu3ufv3vKd1ME2+/6O/s9df463QDQTriKYT
 /OW+Xc++++UYUwOl9PPu/i59rsS2ES34EzucF1XquXUe1yFOyimDV1YHHv9iMKLKMmo6
 36Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608036; x=1743212836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97a57FFucYk6i0P8dY0xsS4aMg003QyZQ+q8Q+4QQfA=;
 b=BfL5MYzBiTYgGwYM7U16qDDxeykZDyQnuL1L1QJ2XjX7GW+28ZiRgpgvoKNPDHpGsi
 7mRumz7g/8rllb4fd2EymGURPe1oJHas4Y4Bv6X85Cj8jU4XC5ZJAutHYN8eAJYFYJHY
 UdFZHu7N13qAv2taxStw5y1VMrGfSf2jU+rpx71NsK6sUxeIHQj0gCfDmnAz1fzviUX9
 10BJJA/VxNSJcvhWLUXUTka0Acd6kMECPWwcw1BZ/2W07WhiapBfRvstOHjTVnCQC3FA
 twwPIDVng1mMG+6IGM7fHEyQjMxqylFl74/Pb0tRKFnbev86A9dHx1XVnCroIqZXWIqz
 Ubyg==
X-Gm-Message-State: AOJu0Yw8motbO0+C366gyCzhmpIHmLmjZHICNO9WDTguTuD6tdzzr2Uo
 a4mCLzj2jnqp7RTUWitzr8zGnEHo6wcwPcM4hSJhBqVg/ACv0wYi/IYLXw==
X-Gm-Gg: ASbGncvZ2SPCaM8JwlToZTBhIc6nfNctmkI2EyrLOdGPgK4KzNi9Q37+sx/OkmB8ZuN
 6f4shAxtKFyTIWGtWrNl5b1EuguUkp9K6PGLQLeBoYzWgKDp1JIOywWOs492zgz/IQLOcXCIl0r
 Mib/UzXxUhsxV4Ff2i7lsyc4G/nMyk5tHC4HQpFmKsaOorAvqYNA3ALxxX47qqCPIlyoFRuMmo2
 n20zLv9rbxg960sx4zJOjn9SqSX4SvxgVV3/GwfiNdDWNctBaXMnLdqCflmcgM9X3gxgLWoFZRH
 RYP1qjTs69MAQ4prAP4pdZDwtZ8fiEK4COMI7cuhBjfxTzS34CAOa3wCPWVeXk4tF4E=
X-Google-Smtp-Source: AGHT+IHKXSw+dJrEw0NyR7ApIG/cEb4qxnn8beSMZb3uhpy4or/m9N4W9XQB9l2kER7U/Sm5IQGlhA==
X-Received: by 2002:a05:620a:454c:b0:7c5:99e8:9377 with SMTP id
 af79cd13be357-7c5ba2383c3mr831659385a.57.1742608036366; 
 Fri, 21 Mar 2025 18:47:16 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.15
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:16 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/18] drm/admgpu: move si_ih.c away from sid.h defines
Date: Fri, 21 Mar 2025 21:46:47 -0400
Message-ID: <20250322014700.62356-6-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

They are properly defined under oss_1_0_d.h

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si_ih.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 94468c87122a..234bb76d12f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -214,7 +214,7 @@ static int si_ih_resume(struct amdgpu_ip_block *ip_block)
 static bool si_ih_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 tmp = RREG32(SRBM_STATUS);
+	u32 tmp = RREG32(mmSRBM_STATUS);
 
 	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
 		return false;
@@ -240,23 +240,23 @@ static int si_ih_soft_reset(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 
 	u32 srbm_soft_reset = 0;
-	u32 tmp = RREG32(SRBM_STATUS);
+	u32 tmp = RREG32(mmSRBM_STATUS);
 
 	if (tmp & SRBM_STATUS__IH_BUSY_MASK)
 		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_IH_MASK;
 
 	if (srbm_soft_reset) {
-		tmp = RREG32(SRBM_SOFT_RESET);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
 		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(SRBM_SOFT_RESET, tmp);
-		tmp = RREG32(SRBM_SOFT_RESET);
+		dev_info(adev->dev, "mmSRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
 
 		udelay(50);
 
 		tmp &= ~srbm_soft_reset;
-		WREG32(SRBM_SOFT_RESET, tmp);
-		tmp = RREG32(SRBM_SOFT_RESET);
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
 
 		udelay(50);
 	}
-- 
2.48.1

