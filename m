Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC5FC87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 13:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5232410E545;
	Mon,  4 Aug 2025 13:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fnV+xuPN";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8EA10E53E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 13:42:02 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-458bc3ce3beso11755125e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754314921; x=1754919721; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tsC/qgiY+Z2JJJsgXTIx3HSug3pvIom3Qzy91d2FNw0=;
 b=fnV+xuPNHMW4pNM9sqSSJxsMrRpdlSLZmGTzkJQ30OZOVoXWGFmIi9Fxdw95dTXpBk
 bH6iw8O88Q6HXb90S3zMnYjNbMj0yOaEJ6su86xYQrDxFUrHGKwlJJJ6Nkgi/DZxbRxv
 vl9Ncd+5K/PqA4jV/IDnUlQAD3zFDP/JZrfeS62PRs7kKXO4tPScYsR1pEIKAmLEHOe9
 8j/wZlImZd7nDR2mGEg1mkiupwJGPI9zPqcUB1aL/V1qRFYuaA/WTAXHMN1/Ym02nVTE
 yOfQMDylppq/k0s5Ilb84vT4/epQ2RoeynW2Kq8PizoEWYUlvSALLVFB7zwnywwcZhyb
 z9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314921; x=1754919721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tsC/qgiY+Z2JJJsgXTIx3HSug3pvIom3Qzy91d2FNw0=;
 b=n+TZ2Q0MJwyVcCAu1dYGoGXX/FuB4x6OkCBwXC+rkHmQQYwYc5+zP0hol88iLwjbt8
 YgBkPaqdLLq7kHSNpy8IOJlWAXtAMgpeJTiwA+BFpIduyVfNZck3XNGYB+UQZnKOr1Pf
 2KcDlAqMvFChn13J6NjxUW9AZ3ReZjKLtGuQ1tCD1/Tz4HHEGORgq2NfxEQc27WHiFcx
 qpLDqKFCeQrq7sN5RXhm4/NpHKYo/3UaCI9T6pmgcXmkJ+zHTrUqEJkY+7sjYbSd/hdJ
 EUz4OLxR3W5a1aRbh5g5PgfrZmNOpS3qzMUDh48oupHbEqwAJzDh0tJpuExMVNzuH3ck
 DLHw==
X-Gm-Message-State: AOJu0Yy92YxDy2tXwn4RCRhsH/J1Vw2cA4KQvrBuc5v7NKfYGyhSbTX4
 WjVRMA8czk/F8/Wb+Y3bZqBgj1KYpJieoWXTZqvZAimelRa5nl5/izDxFai6CA==
X-Gm-Gg: ASbGncvDrJ9w2K2RoVDXgVStLSVaNdH5FnHjwF1lU3C6QXK3Ge+uV4N2U2ExJpuJgPm
 GL0KNx9Klyc5OOE6M/TJmI9Mzij1AFRc93Wgp+GuTokxoeFXmg0Cr6j+nhCIk5RFM1v1CBdvTqD
 OUCdOicRnwrtcRzY+z/vKg0ibJ/qIjpWhP88PjM9v422INCEAmbK5GG7LRLSKJTstKGH159AUja
 WpBYWggUyDrcLo7pAOaCgas+hInsBpcbc85iMvUJQHGA3MLgtWxH34vdhDhdXBvgc7febbTMOcK
 dkl5CTe7+UrZDE93/xYUuC/9zkz32Q/zoEeHeEXX9RjbtDp1ghuZlxQUtn8wU/J4plVz7ZeMwE1
 Wilq3/nlwUcMGqVn6rosUK/DI2o0hY1mTfTwY4axSXX9DLYo2diUZxqgyLWvtHB8zEhoBy9cTnj
 sNs50z3EV8aH9fd0hhmeL+wk88cyc2zvz5Boci
X-Google-Smtp-Source: AGHT+IEKdW4PFtlARBbwfxSfq5EzUvGA54tHVLaD+8oKpOhxoKhzlrxVX1WkBhB5W43erBk9kOl5iQ==
X-Received: by 2002:a05:6000:420b:b0:3b7:90c7:3277 with SMTP id
 ffacd0b85a97d-3b8d94708d4mr6887836f8f.17.1754314921195; 
 Mon, 04 Aug 2025 06:42:01 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee621adsm172056395e9.30.2025.08.04.06.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:42:00 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/6] drm/amd/pm: Fix SI DPM issues with high pixel clock
Date: Mon,  4 Aug 2025 15:41:54 +0200
Message-ID: <20250804134154.95875-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804134154.95875-1-timur.kristof@gmail.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
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

We define "high pixelclock" for SI as higher than necessary
for 4K 30Hz. For example, 4K 60Hz and 1080p 144Hz fall into
this category.

When a high pixel clock display is connected, always disable
memory clock switching to solve some flickering that can be
observed on Tahiti and Pitcairn on 4K 60Hz displays.

When two high pixel clock displays are connected to Oland,
additionally disable shader clock switching, which results in
a higher voltage, thereby addressing some visible flickering.

Ideally, these issues would be solved by introducing something
like dce_calcs, but we don't have that for old GPUs, so
ad-hoc fixes become necessary.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index e9f034ade214..7bfe39a7d653 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3443,12 +3443,14 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 {
 	struct  si_ps *ps = si_get_ps(rps);
 	struct amdgpu_clock_and_voltage_limits *max_limits;
+	struct amdgpu_connector *conn;
 	bool disable_mclk_switching = false;
 	bool disable_sclk_switching = false;
 	u32 mclk, sclk;
 	u16 vddc, vddci, min_vce_voltage = 0;
 	u32 max_sclk_vddc, max_mclk_vddci, max_mclk_vddc;
 	u32 max_sclk = 0, max_mclk = 0;
+	u32 high_pixelclock_count = 0;
 	int i;
 
 	if (adev->asic_type == CHIP_HAINAN) {
@@ -3476,6 +3478,41 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 		}
 	}
 
+	/* We define "high pixelclock" for SI as higher than necessary for 4K 30Hz.
+	 * For example, 4K 60Hz and 1080p 144Hz fall into this category.
+	 * Find number of such displays connected.
+	 */
+	for (i = 0; i < adev->mode_info.num_crtc; i++) {
+		if (!(adev->pm.dpm.new_active_crtcs & (1 << i)) ||
+			!adev->mode_info.crtcs[i]->enabled)
+			continue;
+
+		conn = to_amdgpu_connector(adev->mode_info.crtcs[i]->connector);
+
+		if (conn->pixelclock_for_modeset > 297000)
+			high_pixelclock_count++;
+	}
+
+	/* These are some ad-hoc fixes to some issues observed with SI GPUs.
+	 * They are necessary because we don't have something like dce_calcs
+	 * for these GPUs.
+	 */
+	if (high_pixelclock_count) {
+		/* High pixelclock displays need higher memory bandwidth.
+		 * Disable memory clock switching in order to:
+		 * - Solve visible display flickering
+		 * - Avoid starving other clients of the memory controller
+		 */
+		disable_mclk_switching = true;
+
+		/* On Oland, we observe some flickering when two 4K 60Hz
+		 * displays are connected, possibly because voltage is too low.
+		 * Raise the voltage by requiring a higher SCLK.
+		 */
+		if (high_pixelclock_count > 1 && adev->asic_type == CHIP_OLAND)
+			disable_sclk_switching = true;
+	}
+
 	if (rps->vce_active) {
 		rps->evclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].evclk;
 		rps->ecclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].ecclk;
-- 
2.50.1

