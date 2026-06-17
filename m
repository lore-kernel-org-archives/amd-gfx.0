Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F7CCD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB5610F0C4;
	Wed, 17 Jun 2026 19:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zl8/r0dx";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B5310F0C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:36 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490b12270b3so323365e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723675; x=1782328475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rm23iLNdnwsL1/xCpCbMdWtzf7F8B8Msu4cxXA/8soU=;
 b=Zl8/r0dxx5kicw+BXfQnpw9C/8DcVM0VjIOSmtnMdeVOldrzZ5FKBzAVy3vewdwakt
 Oj2k2mqu6o4d4m8RbcJpyXwU1551RiB2lqB5e8VaLoMyraGnwJlMhszMQUBGf7NsW73Z
 aFsXoi+J8AZeSZCJrWnQhLJvgbGHk69ON7JlEZpnyPAATo195X5QD7c5iVZ2AmmBoRCf
 AoeU2ndeoOlo6XpHcWJ38aDbMCVtONDoMZLPL5pzw5awrOW93yW0yd8uhL6n6EEDswKV
 uRRr1rwoB9Rb7q49D3FGBdVgUqFp45JGPnmwZg+xjxU7pNk0msA+MEv87L9HwTcLSx9Q
 DcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723675; x=1782328475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rm23iLNdnwsL1/xCpCbMdWtzf7F8B8Msu4cxXA/8soU=;
 b=YYABltE8uUWnZn/cRUuraiowOaDzjVbBOCQe6w5adJQPm783eG6q7Bng9F40sjFZEY
 EYZbpwegzFDQUaugBYw8ADZ7jgowbJHZIMdSLrHteB3TtljNZO06c0z6XKcqRUQ4/tIi
 mZV/Q/2HeyPop2n15IiXDVkRUoYm0lrNOH5YOjQl7lDeBseBEvsY1UP4OTtXEBlgH+t2
 Rb4DGzNBoGggQwSvj0DUUhfjYQ7FFJU7RpIvxIzqMT7gfaljsEu08wu1+WrZPwKwChLl
 N3WxkakVF1iN0pRMPAZguLpUEeIXPjh0UW5asMoApIDDjgzz3kJOm+0KS3s0uh2Z9OpL
 dMMQ==
X-Gm-Message-State: AOJu0YzEn2PybZe1N3aloSH+VXPr7uYyioffLBQUFK/lSRLeSwONP846
 YyNLxOigKg13/noLXXNvXzfyfEvCf1NPpydy9EOoB+Icch/k7g/vbG/D+ZEqzQ==
X-Gm-Gg: Acq92OGBmXXHEdijV8O6l9+0qkXFhRsTCpCoJUNuRW1e71Mn0pth5ZDvh2OJ7MgR6ab
 lL8ICzG0/Dyuh5BILV2P6xqjWAEIp+P4RK4XzAa+W9sWpTgCw88SpDU1RREU5kLzqwjIKu0QvIY
 jclmL4Kgqqd/kBda0Y3ZPgjgeKlJt1oJ0jfkUTIaBckbq/DqRyr+tnm2MEG1JLjhp5gVePH18bW
 Lu2uTUYfRhO2L9h4zUaw5ES5txiQQxeD4j0BkTSChpk8TPCJto+dGxNF07Cb+Gpdcruuy/h3VmG
 I9WswO0TrtKGsNFtAwbjwt/skb7OgNdnWjZJkZsV/g0j98pQtOJI4W72sWrDHmS2kjbY90HSEnb
 WH5NAEPEvBqrJelszf65f9Qa0CxGK14oiaTmfqJegT+kFt7ZQiKnRJQSxtVq5WyqQ3mAPqvuq80
 WR+EJsFhpjf3Fr5ZPVySWCIuSW1RazVsJbRwIDj7+JAI2eak4GdA3Sug==
X-Received: by 2002:a05:600d:8450:10b0:490:b202:4772 with SMTP id
 5b1f17b1804b1-49234100b9bmr61084285e9.2.1781723674973; 
 Wed, 17 Jun 2026 12:14:34 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:34 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/17] drm/amdgpu: Clean up defunct soft reset from ASIC reset
 code path
Date: Wed, 17 Jun 2026 21:14:13 +0200
Message-ID: <20260617191428.1784083-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
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

Soft reset means resetting IP blocks individually using
a hardware interconnect (SRBM or GRBM) without assistance
from firmware.

Soft reset is a useful tool for implementing GPU recovery,
eg. it is already successfully used for SDMA queue resets.
It should be used by a GPU recovery method instead of
being called directly from the ASIC reset code path.

Currently, this is only used on Carrizo and Stoney,
but doesn't work well and fails on those chips.
A subsequent commit will add a working GFX8 recovery
implementation after the cleanups.

Note that this commit only cleans up the ASIC reset path,
which also unblocks more opportunities for cleanup for
the various IP blocks. Those will be done in subsequent commits.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 173 +--------------------
 drivers/gpu/drm/amd/amdgpu/cik.c           |   7 -
 drivers/gpu/drm/amd/amdgpu/nv.c            |   6 -
 drivers/gpu/drm/amd/amdgpu/si.c            |   7 -
 drivers/gpu/drm/amd/amdgpu/soc15.c         |   9 --
 drivers/gpu/drm/amd/amdgpu/soc21.c         |  12 --
 drivers/gpu/drm/amd/amdgpu/soc24.c         |  11 --
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      |  10 --
 drivers/gpu/drm/amd/amdgpu/vi.c            |  22 ---
 10 files changed, 2 insertions(+), 258 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index cb4fa9c111eb..7c5ca9e44d54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -586,8 +586,6 @@ struct amdgpu_asic_funcs {
 	/* invalidate hdp read cache */
 	void (*invalidate_hdp)(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring);
-	/* check if the asic needs a full reset of if soft reset will work */
-	bool (*need_full_reset)(struct amdgpu_device *adev);
 	/* initialize doorbell layout for specific asic*/
 	void (*init_doorbell_index)(struct amdgpu_device *adev);
 	/* PCIe bandwidth usage */
@@ -1355,7 +1353,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
 #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
 #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
-#define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
 #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
 #define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71a6b18ccf23..df7e0f2b3ccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4685,161 +4685,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 	return 0;
 }
 
-/**
- * amdgpu_device_ip_check_soft_reset - did soft reset succeed
- *
- * @adev: amdgpu_device pointer
- *
- * The list of all the hardware IPs that make up the asic is walked and
- * the check_soft_reset callbacks are run.  check_soft_reset determines
- * if the asic is still hung or not.
- * Returns true if any of the IPs are still in a hung state, false if not.
- */
-static bool amdgpu_device_ip_check_soft_reset(struct amdgpu_device *adev)
-{
-	int i;
-	bool asic_hang = false;
-
-	if (amdgpu_sriov_vf(adev))
-		return true;
-
-	if (amdgpu_asic_need_full_reset(adev))
-		return true;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].version->funcs->check_soft_reset)
-			adev->ip_blocks[i].status.hang =
-				adev->ip_blocks[i].version->funcs->check_soft_reset(
-					&adev->ip_blocks[i]);
-		if (adev->ip_blocks[i].status.hang) {
-			dev_info(adev->dev, "IP block:%s is hung!\n", adev->ip_blocks[i].version->funcs->name);
-			asic_hang = true;
-		}
-	}
-	return asic_hang;
-}
-
-/**
- * amdgpu_device_ip_pre_soft_reset - prepare for soft reset
- *
- * @adev: amdgpu_device pointer
- *
- * The list of all the hardware IPs that make up the asic is walked and the
- * pre_soft_reset callbacks are run if the block is hung.  pre_soft_reset
- * handles any IP specific hardware or software state changes that are
- * necessary for a soft reset to succeed.
- * Returns 0 on success, negative error code on failure.
- */
-static int amdgpu_device_ip_pre_soft_reset(struct amdgpu_device *adev)
-{
-	int i, r = 0;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].status.hang &&
-		    adev->ip_blocks[i].version->funcs->pre_soft_reset) {
-			r = adev->ip_blocks[i].version->funcs->pre_soft_reset(&adev->ip_blocks[i]);
-			if (r)
-				return r;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * amdgpu_device_ip_need_full_reset - check if a full asic reset is needed
- *
- * @adev: amdgpu_device pointer
- *
- * Some hardware IPs cannot be soft reset.  If they are hung, a full gpu
- * reset is necessary to recover.
- * Returns true if a full asic reset is required, false if not.
- */
-static bool amdgpu_device_ip_need_full_reset(struct amdgpu_device *adev)
-{
-	int i;
-
-	if (amdgpu_asic_need_full_reset(adev))
-		return true;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if ((adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC) ||
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) ||
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_ACP) ||
-		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) ||
-		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP) {
-			if (adev->ip_blocks[i].status.hang) {
-				dev_info(adev->dev, "Some block need full reset!\n");
-				return true;
-			}
-		}
-	}
-	return false;
-}
-
-/**
- * amdgpu_device_ip_soft_reset - do a soft reset
- *
- * @adev: amdgpu_device pointer
- *
- * The list of all the hardware IPs that make up the asic is walked and the
- * soft_reset callbacks are run if the block is hung.  soft_reset handles any
- * IP specific hardware or software state changes that are necessary to soft
- * reset the IP.
- * Returns 0 on success, negative error code on failure.
- */
-static int amdgpu_device_ip_soft_reset(struct amdgpu_device *adev)
-{
-	int i, r = 0;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].status.hang &&
-		    adev->ip_blocks[i].version->funcs->soft_reset) {
-			r = adev->ip_blocks[i].version->funcs->soft_reset(&adev->ip_blocks[i]);
-			if (r)
-				return r;
-		}
-	}
-
-	return 0;
-}
-
-/**
- * amdgpu_device_ip_post_soft_reset - clean up from soft reset
- *
- * @adev: amdgpu_device pointer
- *
- * The list of all the hardware IPs that make up the asic is walked and the
- * post_soft_reset callbacks are run if the asic was hung.  post_soft_reset
- * handles any IP specific hardware or software state changes that are
- * necessary after the IP has been soft reset.
- * Returns 0 on success, negative error code on failure.
- */
-static int amdgpu_device_ip_post_soft_reset(struct amdgpu_device *adev)
-{
-	int i, r = 0;
-
-	for (i = 0; i < adev->num_ip_blocks; i++) {
-		if (!adev->ip_blocks[i].status.valid)
-			continue;
-		if (adev->ip_blocks[i].status.hang &&
-		    adev->ip_blocks[i].version->funcs->post_soft_reset)
-			r = adev->ip_blocks[i].version->funcs->post_soft_reset(&adev->ip_blocks[i]);
-		if (r)
-			return r;
-	}
-
-	return 0;
-}
-
 /**
  * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
  *
@@ -5134,20 +4979,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 
 	/* Don't suspend on bare metal if we are not going to HW reset the ASIC */
 	if (!amdgpu_sriov_vf(adev)) {
-
-		if (!need_full_reset)
-			need_full_reset = amdgpu_device_ip_need_full_reset(adev);
-
-		if (!need_full_reset && amdgpu_gpu_recovery &&
-		    amdgpu_device_ip_check_soft_reset(adev)) {
-			amdgpu_device_ip_pre_soft_reset(adev);
-			r = amdgpu_device_ip_soft_reset(adev);
-			amdgpu_device_ip_post_soft_reset(adev);
-			if (r || amdgpu_device_ip_check_soft_reset(adev)) {
-				dev_info(adev->dev, "soft reset failed, will fallback to full reset!\n");
-				need_full_reset = true;
-			}
-		}
+		need_full_reset = true;
 
 		if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
 			dev_info(tmp_adev->dev, "Dumping IP State\n");
@@ -5600,8 +5432,7 @@ static void amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		drm_client_dev_suspend(adev_to_drm(tmp_adev));
 
 		/* disable ras on ALL IPs */
-		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev) &&
-		    amdgpu_device_ip_need_full_reset(tmp_adev))
+		if (!need_emergency_restart && !amdgpu_reset_in_dpc(adev))
 			amdgpu_ras_suspend(tmp_adev);
 
 		amdgpu_userq_pre_reset(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 29954c7d61b0..77e120a72815 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1876,12 +1876,6 @@ static void cik_invalidate_hdp(struct amdgpu_device *adev,
 	}
 }
 
-static bool cik_need_full_reset(struct amdgpu_device *adev)
-{
-	/* change this when we support soft reset */
-	return true;
-}
-
 static void cik_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
 			       uint64_t *count1)
 {
@@ -1971,7 +1965,6 @@ static const struct amdgpu_asic_funcs cik_asic_funcs =
 	.get_config_memsize = &cik_get_config_memsize,
 	.flush_hdp = &cik_flush_hdp,
 	.invalidate_hdp = &cik_invalidate_hdp,
-	.need_full_reset = &cik_need_full_reset,
 	.init_doorbell_index = &legacy_doorbell_index_init,
 	.get_pcie_usage = &cik_get_pcie_usage,
 	.need_reset_on_init = &cik_need_reset_on_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 72edf5326b05..77557ee3ca16 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -507,11 +507,6 @@ void nv_set_virt_ops(struct amdgpu_device *adev)
 	adev->virt.ops = &xgpu_nv_virt_ops;
 }
 
-static bool nv_need_full_reset(struct amdgpu_device *adev)
-{
-	return true;
-}
-
 static bool nv_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 sol_reg;
@@ -595,7 +590,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs = {
 	.set_vce_clocks = &nv_set_vce_clocks,
 	.get_config_memsize = &nv_get_config_memsize,
 	.init_doorbell_index = &nv_init_doorbell_index,
-	.need_full_reset = &nv_need_full_reset,
 	.need_reset_on_init = &nv_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index c26cb3e8bff6..b104469c38ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1509,12 +1509,6 @@ static void si_invalidate_hdp(struct amdgpu_device *adev,
 	}
 }
 
-static bool si_need_full_reset(struct amdgpu_device *adev)
-{
-	/* change this when we support soft reset */
-	return true;
-}
-
 static bool si_need_reset_on_init(struct amdgpu_device *adev)
 {
 	return false;
@@ -2019,7 +2013,6 @@ static const struct amdgpu_asic_funcs si_asic_funcs =
 	.get_config_memsize = &si_get_config_memsize,
 	.flush_hdp = &si_flush_hdp,
 	.invalidate_hdp = &si_invalidate_hdp,
-	.need_full_reset = &si_need_full_reset,
 	.get_pcie_usage = &si_get_pcie_usage,
 	.need_reset_on_init = &si_need_reset_on_init,
 	.get_pcie_replay_count = &si_get_pcie_replay_count,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 87b398dd0769..ed3fd58b78d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -721,12 +721,6 @@ void soc15_set_virt_ops(struct amdgpu_device *adev)
 	soc15_reg_base_init(adev);
 }
 
-static bool soc15_need_full_reset(struct amdgpu_device *adev)
-{
-	/* change this when we implement soft reset */
-	return true;
-}
-
 static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
 				 uint64_t *count1)
 {
@@ -878,7 +872,6 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
 	.set_uvd_clocks = &soc15_set_uvd_clocks,
 	.set_vce_clocks = &soc15_set_vce_clocks,
 	.get_config_memsize = &soc15_get_config_memsize,
-	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &vega10_doorbell_index_init,
 	.get_pcie_usage = &soc15_get_pcie_usage,
 	.need_reset_on_init = &soc15_need_reset_on_init,
@@ -899,7 +892,6 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.set_uvd_clocks = &soc15_set_uvd_clocks,
 	.set_vce_clocks = &soc15_set_vce_clocks,
 	.get_config_memsize = &soc15_get_config_memsize,
-	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &vega20_doorbell_index_init,
 	.get_pcie_usage = &vega20_get_pcie_usage,
 	.need_reset_on_init = &soc15_need_reset_on_init,
@@ -920,7 +912,6 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
 	.set_uvd_clocks = &soc15_set_uvd_clocks,
 	.set_vce_clocks = &soc15_set_vce_clocks,
 	.get_config_memsize = &soc15_get_config_memsize,
-	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &aqua_vanjaram_doorbell_index_init,
 	.need_reset_on_init = &soc15_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 93c002e511c7..6af81c27b986 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -461,17 +461,6 @@ const struct amdgpu_ip_block_version soc21_common_ip_block = {
 	.funcs = &soc21_common_ip_funcs,
 };
 
-static bool soc21_need_full_reset(struct amdgpu_device *adev)
-{
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(11, 0, 0):
-	case IP_VERSION(11, 0, 2):
-	case IP_VERSION(11, 0, 3):
-	default:
-		return true;
-	}
-}
-
 static bool soc21_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 sol_reg;
@@ -550,7 +539,6 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs = {
 	.set_vce_clocks = &soc21_set_vce_clocks,
 	.get_config_memsize = &soc21_get_config_memsize,
 	.init_doorbell_index = &soc21_init_doorbell_index,
-	.need_full_reset = &soc21_need_full_reset,
 	.need_reset_on_init = &soc21_need_reset_on_init,
 	.get_pcie_replay_count = &amdgpu_nbio_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 265db9331d0b..620970de6eb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -238,16 +238,6 @@ const struct amdgpu_ip_block_version soc24_common_ip_block = {
 	.funcs = &soc24_common_ip_funcs,
 };
 
-static bool soc24_need_full_reset(struct amdgpu_device *adev)
-{
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(12, 0, 0):
-	case IP_VERSION(12, 0, 1):
-	default:
-		return true;
-	}
-}
-
 static bool soc24_need_reset_on_init(struct amdgpu_device *adev)
 {
 	u32 sol_reg;
@@ -330,7 +320,6 @@ static const struct amdgpu_asic_funcs soc24_asic_funcs = {
 	.get_xclk = &soc24_get_xclk,
 	.get_config_memsize = &soc24_get_config_memsize,
 	.init_doorbell_index = &soc24_init_doorbell_index,
-	.need_full_reset = &soc24_need_full_reset,
 	.need_reset_on_init = &soc24_need_reset_on_init,
 	.get_pcie_replay_count = &soc24_get_pcie_replay_count,
 	.supports_baco = &amdgpu_dpm_is_baco_supported,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 5f05c8e68297..4d93f28145d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -223,15 +223,6 @@ static int soc_v1_0_read_register(struct amdgpu_device *adev,
 	return -EINVAL;
 }
 
-static bool soc_v1_0_need_full_reset(struct amdgpu_device *adev)
-{
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(12, 1, 0):
-	default:
-		return true;
-	}
-}
-
 static bool soc_v1_0_need_reset_on_init(struct amdgpu_device *adev)
 {
 
@@ -271,7 +262,6 @@ static const struct amdgpu_asic_funcs soc_v1_0_asic_funcs = {
 	.read_register = &soc_v1_0_read_register,
 	.get_config_memsize = &soc_v1_0_get_config_memsize,
 	.get_xclk = &soc_v1_0_get_xclk,
-	.need_full_reset = &soc_v1_0_need_full_reset,
 	.init_doorbell_index = &soc_v1_0_doorbell_index_init,
 	.need_reset_on_init = &soc_v1_0_need_reset_on_init,
 	.encode_ext_smn_addressing = &soc_v1_0_encode_ext_smn_addressing,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index a256320b92f3..5715b6b596af 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1328,27 +1328,6 @@ static void vi_invalidate_hdp(struct amdgpu_device *adev,
 	}
 }
 
-static bool vi_need_full_reset(struct amdgpu_device *adev)
-{
-	switch (adev->asic_type) {
-	case CHIP_CARRIZO:
-	case CHIP_STONEY:
-		/* CZ has hang issues with full reset at the moment */
-		return false;
-	case CHIP_FIJI:
-	case CHIP_TONGA:
-		/* XXX: soft reset should work on fiji and tonga */
-		return true;
-	case CHIP_POLARIS10:
-	case CHIP_POLARIS11:
-	case CHIP_POLARIS12:
-	case CHIP_TOPAZ:
-	default:
-		/* change this when we support soft reset */
-		return true;
-	}
-}
-
 static void vi_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
 			      uint64_t *count1)
 {
@@ -1437,7 +1416,6 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 	.get_config_memsize = &vi_get_config_memsize,
 	.flush_hdp = &vi_flush_hdp,
 	.invalidate_hdp = &vi_invalidate_hdp,
-	.need_full_reset = &vi_need_full_reset,
 	.init_doorbell_index = &legacy_doorbell_index_init,
 	.get_pcie_usage = &vi_get_pcie_usage,
 	.need_reset_on_init = &vi_need_reset_on_init,
-- 
2.54.0

