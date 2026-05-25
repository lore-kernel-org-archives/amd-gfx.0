Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E012CD5BD0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB12F10E2D2;
	Mon, 25 May 2026 11:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bV/Y6ZNr";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B4110E2B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:45:17 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49040362e4aso38309945e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709516; x=1780314316; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJu6SMu1v5icLTZuoKFGCejvwnBt1QXyQY4jbQr6tKI=;
 b=bV/Y6ZNr6Xvqbis9PGhwotcJodIk1KCSTVSw4pO7psf4VfHhDGwgHNNadHuuWcMegz
 BG//UOhI1fyNSydmRUAFaeaIwOsk/+8Fi7RZ8iHJMGUfwjfv0b/o75ZNVTfwaye9sRf3
 c77TV2LqaInv/As63UxhvqQeUs3dt/3I+3Qr779/1EFwPnrMIwDweLZmS7twIprK/9Ou
 O2NuDTxPA39THxKF6DemlaehwKfzEG4aFtwe0hKOZ8Q4hWFyWdhxDYczGy8wjJX1DIqd
 C1TsvK0PwrK8nG+82IZfQBYL09zsv8Yp06qMXH+rOG3gv1bltx1cdWGmky8zFmuOdhmF
 POLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709516; x=1780314316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xJu6SMu1v5icLTZuoKFGCejvwnBt1QXyQY4jbQr6tKI=;
 b=UqQl6GCL2t7iTKzE9YXYyZwwWLApeslqgCsTYDnVaDw5JIoPoEt5RqHHd8eHFPZOLC
 yTz9lujKUqa1/SyuoEeYRFuVcmx9IkLn0brLKvleGzVa7QfYhM1iyExRRe+77xKCtzad
 2ZAYL3jia9fURlsgGTMvnjhrZOyRt1qSS+VPBc7Qv3M/e95LS3yljvLS4CjEzyHSzhX/
 wjgmOPg/J2rOcxTWrr+05zUgCGa0+AlTR3iZCTlGRz5p7v1wKhR2y2Ufx9HMmFhv1fva
 GL1ZaoJDZzcpQMtNBKzHWkgvrFPCfrUNKw1uJigwGWPnWaBzvjPrIcOfySg+EsEVHdwP
 4kHQ==
X-Gm-Message-State: AOJu0YxY8nYiVtk+Rt3AvnZ/7Qb2f9qN4E/FMMD0JPB0g7ZVu52Z+8qW
 09KxEWmossbmnSsA+JwOGsDs7Aw9CRpiC98H7k7GIZlHI24LnlK4vTPDi0Z5Nw==
X-Gm-Gg: Acq92OHU1MZqH76H1bSj1M4NP2cD5L+t06EnjnRyZAzrX0M5/S98tFHBKFy6E9tL0R2
 E2HxOCqGbcpBUxLvY8fXSBHxXs13ZtDzBg/TR+OuXlipHmQkQnQHPLjs5TFDEI8RQQmbj6VojLp
 ZfnYKvVCN+lnandGjJ4ekX+3Q6CjK9AIVlbIioEB/BIKwv7TnZs8tJlh6MjV0i7dL1vH1iARLrH
 AU7xRD8Urj15DH2rmT1mKU/jHEggRE1bfCbNzlqAu+Vj61FFbiFtKe0E76AL7yiQmhA9+IVKwTN
 s2VDaWtgIn4eXVjeTKil+QSo5yi5X5Hi5ZNRTq9TlUu9GFHpkjw+yRSHmOuWrcsEiASdsd2XhSb
 BEdUsSRrxww4co99F5lpJiYIGbeDO2EnC6hp57t86sGHaGT1vyojAYcbOd7aUWrs1qtWRnvInpR
 BBBfbWLsCImpnPlNFnCqfCQ4ozWk6RLMz4ThHLGBB/i2vnmoPN/SPowCy7Elpafyunyt7VuiNwd
 +E=
X-Received: by 2002:a05:600c:6995:b0:490:482c:4384 with SMTP id
 5b1f17b1804b1-490482c44ddmr223160365e9.24.1779709516360; 
 Mon, 25 May 2026 04:45:16 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm365533885e9.7.2026.05.25.04.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:45:16 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/7] drm/amdgpu: Enable retry CAM on Navi 3 dGPUs
Date: Mon, 25 May 2026 13:45:07 +0200
Message-ID: <20260525114507.24566-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525114507.24566-1-timur.kristof@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
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

The retry CAM can filter interrupts which occur repeatedly,
such as page fault interrupts when retry faults are enabled.
This makes processing those interrupts much more efficient,
because the CPU won't have to deal with processing the same
interrupt repeatedly.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 18 +++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 16388e3caea3..2a226b4c9e09 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -108,13 +108,16 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	bool write_fault = !!(entry->src_data[1] &
 			      AMDGPU_GMC9_FAULT_SOURCE_DATA_WRITE);
 	uint32_t status = 0;
+	uint32_t cam_index;
 	u64 addr;
 
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
 	if (retry_fault) {
-		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, 0, 0,
+		cam_index = entry->src_data[2] & 0x3ff;
+
+		int ret = amdgpu_gmc_handle_retry_fault(adev, entry, addr, cam_index, 0,
 							write_fault);
 		/* Returning 1 here also prevents sending the IV to the KFD */
 		if (ret == 1)
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 333e9c30c091..0a87c3126d1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -307,6 +307,11 @@ static int ih_v6_0_enable_ring(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void ih_v6_0_retry_cam_ack(struct amdgpu_device *adev, u32 cam_index)
+{
+	WREG32_SOC15(OSSSYS, 0, regIH_RETRY_CAM_ACK, cam_index);
+}
+
 /**
  * ih_v6_0_irq_init - init and enable the interrupt ring
  *
@@ -392,6 +397,16 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
+	if (!(adev->flags & AMD_IS_APU)) {
+		/* Enable IH Retry CAM */
+		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, CAM_SIZE, 0xF);
+		WREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL, tmp);
+
+		adev->irq.retry_cam_enabled = true;
+	}
+
 	/* enable interrupts */
 	ret = ih_v6_0_toggle_interrupts(adev, true);
 	if (ret)
@@ -800,7 +815,8 @@ static const struct amdgpu_ih_funcs ih_v6_0_funcs = {
 	.get_wptr = ih_v6_0_get_wptr,
 	.decode_iv = amdgpu_ih_decode_iv_helper,
 	.decode_iv_ts = amdgpu_ih_decode_iv_ts_helper,
-	.set_rptr = ih_v6_0_set_rptr
+	.set_rptr = ih_v6_0_set_rptr,
+	.retry_cam_ack = ih_v6_0_retry_cam_ack,
 };
 
 static void ih_v6_0_set_interrupt_funcs(struct amdgpu_device *adev)
-- 
2.54.0

