Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23548C3DA4A
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Mar 2025 04:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0C8910E11D;
	Sat,  1 Mar 2025 04:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JUdA/iPx";
	dkim-atps=neutral
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com
 [209.85.222.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD0410E100
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Mar 2025 04:11:40 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id
 af79cd13be357-7c0a3d6a6e4so257846985a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 20:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740802299; x=1741407099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1wY0mHhBmAKRs6odGi4S8/JAa2ikLRSW1NS8BlolIIQ=;
 b=JUdA/iPxVW2P1ZtW+/EG4D7diiugpUnug+OE0sFFgg1fFNLjak/a4Y4KEWg6oneJhK
 gdvyUtJ8FrGTVerIleJrjKnrRU9Yr+N6PcqwU2Y8umIiff820WpXR+k7ZybhBoMC5IVd
 BSv8CpZ9yOyWhVpPew3PcF6mQWBUIqVZr7X2zgiNNtoj5C+i6/+mEpSwikqORGfV+yTS
 SnNC5bH4PdqNmUsVgx2mKDa8u4AP3TeEG8qd2Fx9BCnaDnBZwh6ylmzzi26XKRqqroZp
 FNvbP7YHEplfFkFKbfHkImF+IRkKjzdek8N+zelBDrNRTI2p/Tuwy3VBQqyeFyG3/wiN
 Hh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740802299; x=1741407099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wY0mHhBmAKRs6odGi4S8/JAa2ikLRSW1NS8BlolIIQ=;
 b=LhJ6j+uaILC0+DX8RJ24sG64fSFcrFaxCMGeVunNBPYpoyXFNKbPPwcrm1ZPY7JIGe
 1WAG9GN8bd1uvSTgIo6ps+6DIHbn4NmJL3hcwCapL9em2pBs83f7kt8a18IirVnmFkJl
 /nen5X1hcVeOYuTYik14sMo/h1lQeF7+d9SA0Ogo2SxMQX/ryko925SoqVAZz7TWYrHR
 bd+YqldrfWoW0WwzMxV4PfRg2AccLm67gkgAVhmE30WVHB/kvUs6TC8UdPzhDQK9hoPa
 cGXHhXJzNcfwIOeI9vKjktqafteI3IPax0UzAA3NFeHZyD+uzG+2HgSi8CCvH47vMUKD
 tnfw==
X-Gm-Message-State: AOJu0YwhSw+C/ntAuaw+VG+mWFFQNcczSo3VADmOAYKNAbeBCsin324g
 tt1Enr8QHNsB67ug9azibOBD0RqRSCdR+POug8NkK38FXg2m33wXcLh0Kg==
X-Gm-Gg: ASbGncvxj8g5i9NWKTKZXlbZF+tdZi94DZkmYEK+jFIA9TMLlEOasaErv8BuWEc74C8
 V4/vNOGTuVkNBsS5vC80FcTq5Cf1/ETCccvPHzguRh91qvqsV1eWyrldaulD58gE84UfmzAPhm1
 6kq4zak+DJiHFQxRBS1n0uXhIURnc1baJiGr60w72x5C+YpDCjbluP3xII5TXB93ylPAeYWs1Kx
 lfj/zwwuZ7TIUBjXirsJwIQvhwtIfUOnFbqAniFquftZQ9PtI7HampwyDoHXeROcgjWIEvBd37K
 5JtGSNQDE307eFWu5oj5ITRBBH425XVqao16/3KxkSomG19Yb8e1Ic7REL0ujgm7zss=
X-Google-Smtp-Source: AGHT+IFwt2ov4R6mPizUnFEcfE12X0RGcgHHTVFYFNezLnX8UC3ZxB9NFk+NVl9X6bTKmPYogSPtGw==
X-Received: by 2002:a05:620a:c44:b0:7c0:b2ab:2693 with SMTP id
 af79cd13be357-7c39c677674mr877800085a.49.1740802299169; 
 Fri, 28 Feb 2025 20:11:39 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c36ff0f386sm327973085a.60.2025.02.28.20.11.38
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 20:11:38 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdgpu: complete
 dce_v6_0_set_crtc_vline_interrupt_state() in DCE6
Date: Fri, 28 Feb 2025 23:11:21 -0500
Message-ID: <20250301041121.9661-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250301041121.9661-1-alexandre.f.demers@gmail.com>
References: <20250301041121.9661-1-alexandre.f.demers@gmail.com>
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

dce_v6_0_set_crtc_vline_interrupt_state() was empty without any info to
inform the user.

Based on DCE8 and DCE10 code.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 2ccb450b35a6..f8a743aade52 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2968,7 +2968,51 @@ static void dce_v6_0_set_crtc_vline_interrupt_state(struct amdgpu_device *adev,
 						    int crtc,
 						    enum amdgpu_interrupt_state state)
 {
+	u32 reg_block, lb_interrupt_mask;
 
+	if (crtc >= adev->mode_info.num_crtc) {
+		DRM_DEBUG("invalid crtc %d\n", crtc);
+		return;
+	}
+
+	switch (crtc) {
+	case 0:
+		reg_block = CRTC0_REGISTER_OFFSET;
+		break;
+	case 1:
+		reg_block = CRTC1_REGISTER_OFFSET;
+		break;
+	case 2:
+		reg_block = CRTC2_REGISTER_OFFSET;
+		break;
+	case 3:
+		reg_block = CRTC3_REGISTER_OFFSET;
+		break;
+	case 4:
+		reg_block = CRTC4_REGISTER_OFFSET;
+		break;
+	case 5:
+		reg_block = CRTC5_REGISTER_OFFSET;
+		break;
+	default:
+		DRM_DEBUG("invalid crtc %d\n", crtc);
+		return;
+	}
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		lb_interrupt_mask = RREG32(mmINT_MASK + reg_block);
+		lb_interrupt_mask &= ~VLINE_INT_MASK;
+		WREG32(mmINT_MASK + reg_block, lb_interrupt_mask);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		lb_interrupt_mask = RREG32(mmINT_MASK + reg_block);
+		lb_interrupt_mask |= VLINE_INT_MASK;
+		WREG32(mmINT_MASK + reg_block, lb_interrupt_mask);
+		break;
+	default:
+		break;
+	}
 }
 
 static int dce_v6_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
-- 
2.48.1

