Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D743BF99C89
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2026 21:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7412710E12C;
	Sat, 18 Apr 2026 21:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mu+ZIkc8";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2071210E0AB
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 21:49:41 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so25673785e9.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776548980; x=1777153780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e2SdoQd7Rf/AVZ+H9WfFvQxL2+GPqYyp91jbCZiaPkY=;
 b=mu+ZIkc8JxvjP4XzKPMbv7Wy6/DCwNBAfx2Cwb5e4+Orap4lopAYe774CTnq0sU8J3
 /VfV1sQdX9XCm8i8i7WIwtXH5nbtGsJ1H3Y4Zae+uuTtQsJGv3vWyPTTDCqAWgA0/TBr
 HajrhwBYo6Sn1MFnwVYEhqSzuQN0QBteYWJVXKUcq5Ixbz6la7GZ+eGSS6oNncT/Y7jO
 +YVs7YsQ17nE79JGQgsFUoqwMNsGA2HhaHLha5k8unGDsa++eigeSpUBge9eoQu2cWm2
 YidRSk8M5FxOQQ2jwk0j8mc8xQKjnHsAyAdL6L4rzJwK4UDeedd5tEqEA+4IV4IjmF5t
 VDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776548980; x=1777153780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e2SdoQd7Rf/AVZ+H9WfFvQxL2+GPqYyp91jbCZiaPkY=;
 b=RBq/q6KIQ8qQmgRvBY9yZ5uFSJygihA5xvEYRKWG6Fp4x1QTc2Kp11rYHQN87DFDWl
 UUHs36uarTAkL04n2Dx2JTrJwkw5WIia7AB80YFd59N21ozw8N1dDgE8IUVJluyWeY+S
 w16TjL1K8FxB399SOA5j++/DsbivTdaAutG8L5buI8PLedPe06F3tWL3s52Qx0UIKj0u
 5t5Q2k5+9uQe+VSypJ/OhrAO7VdkAQ/Sg80ba6TfQQE+9iY2J40KMOMO6dHwQv8zWKKJ
 faVwEUEi0yiyiPTln8kCbQN04WfnsDdau+jSnIbCbABNo6ofAJvGjJDJfwxMSAK3yY+b
 PHXw==
X-Gm-Message-State: AOJu0YzRLANkhGO1HbKBLo9zR7Hnh+4XVxXMs9y9Zix+TtgsdkzM46s3
 vhGKGr5Iofok43kKnD+kO1OiWruuZNTuFWdRHs+SCi6NNXW7VDBo+Z5yDQ5tFw==
X-Gm-Gg: AeBDievpu/cjqXKVWoz4lwWaz004BwFrk3DbKiEuZ+Ngy1XtK94U1pLj8cSg3ETeJDB
 taoTDQdHxz8DoecesLRLaDY6QaU2WNcpEIaK0jSLcnLjUrH7sPfu8xO9XHLA12FdcZ5qomaoMmr
 eAUgoofeyvoyvXDg5K5gz8G5leiKJhQxXiVgHH9W/Gg2kJwSG96gwDfn47f2YPBAs2asZeHw9mH
 AAwQ/358JEH9sKtEEMd0uyweTJKByP0hSkLd3+GwB+GsYhyKql8IeBPWFS8LLhkIToKRvr08d1x
 NscQtQ1cfyU1O+RBKdXd15JcLXGU74geoUwq4d4wsrYJHTUmCpFP1bIoWQ8TG0e9yDvRkUbSy/T
 Ooy3ZgHx6mm2sDMbrQ9cwogoJZiCZqr7pl34A4VRI9sO2zHvY7JLClZ4T53B/ydx8MqF8cHupNx
 gkBylqPcgvtqxU+24Zuw4C68Auvcx9T8xv3zEoi1F4NDqFIblEnHGQWf7MiX1JGogqcxZwcrKsd
 Y4Eog==
X-Received: by 2002:a05:600c:5246:b0:488:a639:b787 with SMTP id
 5b1f17b1804b1-488fb74fc0dmr119095195e9.11.1776548979487; 
 Sat, 18 Apr 2026 14:49:39 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm171531905e9.2.2026.04.18.14.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 14:49:38 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/4] drm/amdgpu/uvd3.1: Don't validate the firmware when
 already validated
Date: Sat, 18 Apr 2026 23:49:31 +0200
Message-ID: <20260418214933.230912-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418214933.230912-1-timur.kristof@gmail.com>
References: <20260418214933.230912-1-timur.kristof@gmail.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
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

