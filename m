Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB58F8D779
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 20:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BAE10E8DC;
	Thu, 16 Apr 2026 20:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OnPWO5CM";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44BAC10E946
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 20:26:52 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-483487335c2so92395715e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776371211; x=1776976011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7v8asej3aIPf5LQk8m7WQpG2Ya1GZYm2stHDSRntWU=;
 b=OnPWO5CM3fZpOGN2U4xQKXxYkTnJrLKfZoAu9DNTYNg3Hvfqu+kkGBCbR4by4XTxAX
 VY0SaEctPCGtydmtADM5QKXjCBIb1Bo/7W57Q0k8dr32rADJ5Oe8SuYan6SnmVdNRlrd
 6DiHLrFCQYrg0WjHvlYsVcbzXn4wS4+ctDdkXgQqdn8w/lgfk2EZ9J/EMyITg3b6fLxb
 dU6UNjxqgHLUj1/puhRistmECMiwjziFpjlfbbwVAt140J690cwqpwLMHkcACDuq9BJx
 YDVRpraO89KqIa2MJKxUfODwaGzS/hE+TcprQgZ6BW6EynaCdVhuTLvmIiOFNJ2DGtUE
 ulEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776371211; x=1776976011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W7v8asej3aIPf5LQk8m7WQpG2Ya1GZYm2stHDSRntWU=;
 b=OvJ9qqJObTuckQXXyAfMq3Vl4jA4y1LdjjP6vSdq1LsXV5vh7Hys8UQE+NdTOW/rE+
 cqT78Zy8bBkTZnwU4lyELF/BuPPADWulW1YoWAo3arQ+qIZHLbITK04vXJufC9hKqy4I
 lx5BN7PJdRCMjUT1hybznQTXZQSk2pvF3FJMO8Qp8pgsAUS9Ixk29RB13/hrvkJMJrIX
 xbD6l87ei5FCPQFbfuRSMinwKRrHMzgA6hznvIQSKtck8YpL2nxuqUNcyp6FEBk8ErCR
 6QydlaqIPlIeWpLV1idnI7p8KyaI+31mPQHn2IaQJVn9kf1SpyJ6jWUSJtKJISrWjsiZ
 70sQ==
X-Gm-Message-State: AOJu0YyVbc6LePdQumQdc+7myVMggMI9REA1lnRkt8ZZuNul37g6uPTx
 zAJjOHe5SoY+wVmQESX6kQdHRsYPk9ZXSfYmRtHBVIC7T+Y2/iFuDf8jj9Q+Eg==
X-Gm-Gg: AeBDieuceW8K/+6M7Yy/Bqd+v2r8RhZjhpEs97iaxZJEdcELUWqrbOuC72WfBUa0DMc
 J8omBK/55+0/EbUijxTCeq7yU/IqJnute/TOBioiitNaWYFF+LWYImZlQRE0qzv970MfINuZctW
 28LUu5qYH7LyeEqQpntqqEA7SNzMlX0X/dVSfsXtNOg0iyvAcenYv3BSg4Twkncf+bqt5AgBa4p
 ks5Lsia1GySKpSxJ/LyGG3LUNSwpfQlC1wGPSn2L5rJkjq0ne/d4U6YyhAEn3gqsac3gMYKG1e9
 wn3Gcav8KbuobNHGSMfc4hCPI2n1JkYcZW7BYs1ATQwJzCwS9nRTVrtquU7Q9PC3JGsE8IT5uPy
 K/5YgGIQjySCtFl/g2KkAESh6Z4h54hIKkqoTkEHxQMW6AiLg2u03tWksmQMzjrsS6Bu+1kyqsT
 e4e+vYStdeM6YWhchVOGMSWYjYYudRD+/NlPlmvbUwfgxIIQx+AF+g1Gg23LzSa+MTF2K05MIAB
 B42DQ==
X-Received: by 2002:a05:600c:4f0e:b0:488:945a:ed63 with SMTP id
 5b1f17b1804b1-488fb6e8491mr2270695e9.0.1776371210639; 
 Thu, 16 Apr 2026 13:26:50 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581b9fbsm76941355e9.5.2026.04.16.13.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 13:26:50 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/7] drm/amdgpu/uvd3.1: Don't validate the firmware when
 already validated
Date: Thu, 16 Apr 2026 22:26:41 +0200
Message-ID: <20260416202643.25350-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416202643.25350-1-timur.kristof@gmail.com>
References: <20260416202643.25350-1-timur.kristof@gmail.com>
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

UVD 3.1 firmware validation seems to always fail after
attempting it when it had already been validated.
(This works similarly with the VCE 1.0 as well.)

Don't attempt repeating the validation when it's already done.

This caused issues in situations when the system isn't able
to suspend the GPU properly and so the GPU isn't actually
powered down. Then amdgpu would fail when calling the IP
block resume function.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/2887
Fixes: bb7978111dd3 ("drm/amdgpu: fix SI UVD firmware validate resume fail")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index fea576a7f397f..efb3fde919ee3 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -242,6 +242,10 @@ static void uvd_v3_1_mc_resume(struct amdgpu_device *adev)
 	uint64_t addr;
 	uint32_t size;
 
+	/* When the keyselect is already set, don't perturb it. */
+	if (RREG32(mmUVD_FW_START))
+		return;
+
 	/* program the VCPU memory controller bits 0-27 */
 	addr = (adev->uvd.inst->gpu_addr + AMDGPU_UVD_FIRMWARE_OFFSET) >> 3;
 	size = AMDGPU_UVD_FIRMWARE_SIZE(adev) >> 3;
@@ -284,6 +288,12 @@ static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)
 	int i;
 	uint32_t keysel = adev->uvd.keyselect;
 
+	if (RREG32(mmUVD_FW_START) & UVD_FW_STATUS__PASS_MASK) {
+		dev_dbg(adev->dev, "UVD keyselect already set: 0x%x (on CPU: 0x%x)\n",
+			RREG32(mmUVD_FW_START), adev->uvd.keyselect);
+		return 0;
+	}
+
 	WREG32(mmUVD_FW_START, keysel);
 
 	for (i = 0; i < 10; ++i) {
-- 
2.53.0

