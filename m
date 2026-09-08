Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01B3C79F99
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 13:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E7910EBD8;
	Tue,  8 Sep 2026 13:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=aicharmers.com header.i=@aicharmers.com header.b="pCdMo5pn";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3632D10EA25
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 07:26:09 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cbb8b54fcf8so4467376a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 00:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aicharmers.com; s=google; t=1788852369; x=1789457169;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9p6gnFadNyB/qeih9jsIAGctpC57sjAwmCrr2gNlVmQ=;
 b=pCdMo5pnUakXK0JsvDI6kPpAgVrUOl2AniTf8/N1slCM95GnejoRIobOyDJUtYCzWM
 h4azqmzJGYdCYqTAhTZ+YJ8eRTRud41XQHe95sarxu4xUiD/InFjWko9SOGrYDHFImT5
 mJmqEj9VpS8CWtWvL7u4X6y8fA1uWCmOlgPgu/HXSiwEfLpMstcxWRVRGHdxkzATb9lA
 Zdox/XM3RUQTxURW4mO4mFL8uacs4MGrxN8p2wNFp7D9Iqz4X2+GVkRdnE/5misG92r8
 dwC22cdQC5/E9x4ge4vARjovcYk132yMOrCf6vLLIQM39bI8SRB4u9aR802u54TyuvbI
 fPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788852369; x=1789457169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9p6gnFadNyB/qeih9jsIAGctpC57sjAwmCrr2gNlVmQ=;
 b=GfSUZIi4oFASLlu4Qmn10cAr1jehTRy480fbRsBITMrARgBnfx7KiSyyM1qlT7H/Qk
 i84IhNOGdhjQ1J4yUAVSEWJUKL7Fs0wUQm3ohL9o230hr/dTIadLw6C1LCOfykTG5uEZ
 rl3STuwcONVlN/lO+xBXYn6h7hpaw+kXUGZ8vZBOqTDvYfMX15Zh7EslLEmBx0RJ9Zb6
 4F5JmfyBpRlXxYBXkU3+EYZvhXtS7O16SrBEAJcZQEFSi3wjHlR7jvIyvEPER8rjuOlh
 cn49qHXwYCpEUD02wzxEh3GR96iKTt1zxNyVTGRTvx9V/yA1bRVM2q1+t7GDUEB/ZNs0
 7dmw==
X-Gm-Message-State: AFuF++n5VqTl7cxf7DCnf+Y4D/v7Gx2Zj3aWUEh1J4Hj52ngcL2dAW+J
 uWh9gqimOC3mgdAA8Og/nxxDzQ7FKCLlXpVtrZpqmqcRO/fr8Ay9lhtCQDDrUEo259omeLVzr80
 IZ9gN
X-Gm-Gg: AYBFou1ClJCGvpYJAHZ6cGRjrDSaGX6kbMM8Pg7/JLbud4OP3A972UWmEyC+AiPfYik
 IlNVRtVjtZv/L/tAw3KkC/3XLWyd+ZRM9Ao86aRYSMJ+iyjLd0K+L7t/0YS0x00GP5pj5v8twFJ
 wqNS2oT61GCvPOPw72BXR9HmZJ/4klFIUJmblzE2Rrnzoj9Df/mwKIAveC+5oSNmKnMOSPJmXz+
 u1ckjI5j3/RUg+N040G0l39c7rh1rtQQ84jE0YgSl5D8BSFhKC1YsS0v25DvHWNeG1tjCgfe94c
 LLXuS/O3a57dxXwDl/Cc6KagyJwdpxgXSqC3TGxjyx/WtrF9ogqET5t+lsBhO0q9WAX01ggHjVW
 g648c9xdYe3tgPpXZqIOgNkrXE6kPzXfI4xv1KM8n6eB/zIQXMOQ2GcnAWhhNcqGzfQXJTiQQxR
 QjUp7ZxrMkhhabjRzlnai6fSpbI1Xe4RUuc+910T7q9bhtVhyrjHkp80N5ZBoxMTCvuM37iH1S/
 I3987L3AIDYhZeLL/X3IrkqE9tULNMWWA6+VotciLfhHAsusxr7V4IGA3MV3wmSuMPLPmzL0aAe
 p9w3YPuXgcq4/nFVTGhI9XGixKkS4SEaxFRPafOOXg==
X-Received: by 2002:a17:90b:5344:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-39b261b1a47mr44358365a91.13.1788852368553; 
 Tue, 08 Sep 2026 00:26:08 -0700 (PDT)
Received: from ip-192-168-20-24.ap-southeast-2.compute.internal
 (2403-5803-1750-0-3d77-e76e-aa73-3d48.ip6.aussiebb.net.
 [2403:5803:1750:0:3d77:e76e:aa73:3d48])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa33e96sm33210752eec.12.2026.09.08.00.26.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Sep 2026 00:26:07 -0700 (PDT)
From: Ed Schofield <ed@aicharmers.com>
To: amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
 0218
Date: Tue,  8 Sep 2026 17:25:34 +1000
Message-ID: <20260908072552.67798-1-ed@aicharmers.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 13:03:20 +0000
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

On the Apple 1002:7340/106b:0218 revision 41 board, enabling UCLK DPM
with EnableAllSmuFeatures can time out and leave amdgpu without a DRM
device. Omitting only UCLK avoids that timeout; enabling it separately
immediately afterwards still timed out in a local experiment.

Defer UCLK enablement to the Navi post-init callback, then verify the
firmware bit and refresh the supported-feature bit, memory DPM table
and sustainable clock limits before the UMC workaround and UMD setup.
Validate the PPT memory states consumed by DCN20 before that callback.
Keep both memory-voltage features enabled and respect PP_MCLK_DPM_MASK.
Limit the change to the board and revision tested locally.

Based on Atharva Tiwari's delayed-UCLK proposal for Apple board 0219.
This adaptation uses the Navi callback and updates driver clock state;
it does not change T2's existing 0219 allowed-mask workaround.

Link: https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg149770.html
Link: https://github.com/t2linux/kernel/issues/19#issuecomment-5537823876
Assisted-by: LLM
Signed-off-by: Ed Schofield <ed@aicharmers.com>
---
This is a board-specific follow-up to Atharva Tiwari's August 25 delayed-UCLK
proposal for Apple 0219:
https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg149770.html

T2 review: https://github.com/t2linux/linux-t2-patches/pull/60
Hardware report follow-up: https://github.com/t2linux/kernel/issues/19#issuecomment-5579537553

The affected machine here is iMac20,1, PCI 1002:7340 / 106b:0218, revision 41,
with SMU firmware 53.38.0, interface 38. The original-policy control times out
in EnableAllSmuFeatures (message 6, -62). Omitting only UCLK avoids that
timeout. Enabling it immediately afterwards also failed in an earlier local
experiment; Navi's post-init callback is the point tested successfully.

The patch refreshes driver state after enabling UCLK because initial table
setup ran while that feature was disabled. DCN20 also consumes the PPT memory
states before post-init, so their count and nonzero frequencies are checked.
Both memory-voltage features remain enabled, and the public MCLK-DPM policy
still takes precedence over the workaround.

A direct control on this AMD staging base used the same kernel image,
configuration, firmware, boot parameters and 6,434 companion modules, with
only amdgpu rebuilt from the pristine upstream source. Comparing the two
extracted initramfs images found exactly one changed file: amdgpu.ko.zst.
The first unpatched warm boot passed rendering and video checks. The second
reproduced the EnableAllSmuFeatures timeout (message 6, -62) and left no bound
AMDGPU driver. Linux remained reachable over SSH. Warnings in amdgpu_irq_put
followed during GPU error cleanup. The control series stopped at that point.
Restoring the exact patched module/initramfs recovered GPU initialization,
hardware rendering and all 60 VAAPI/software frame comparisons on the next
warm boot. This demonstrates an intermittent GPU initialization fault on the
upstream base, not an inability of every unpatched kernel boot to reach Linux.

The experimental implementation passed 40 warm and ten cold boots on this
machine. The extracted production implementation has separate T2 7.2.3 warm,
rendering, video, sustained-render and public-policy checks. The production
T2 patch also passed prescribed AC-connected and AC-unplugged cold starts,
with operator-confirmed 60-second intervals and rendering/video validation.
An intervening start was corrected to AC-connected when the operator clarified
that he had not unplugged it; the actual unplugged test followed.
The T2 build also passed a ten-minute, 2 GiB-budget
Vulkan memory test with a load/idle/load transition and a normal boot after
system updates and initramfs regeneration. This AMD staging variant has a
successful W=1 object build, full kernel build and extracted-C ASan/UBSan
checks; it has now passed ten warm boots: two attended boots, including
recovery after the failed unpatched control, and eight further unattended
boots. SMU initialization, SSH, hardware rendering and all 60 VAAPI H.264
frame comparisons against software decoding passed on every boot. Console
login was visually confirmed on the two attended boots.
All four memory states (98, 500, 625 and 875 MHz) were available, with both
memory-voltage features enabled. This build has only the proposed GPU fix
on AMD staging, without the T2 patch collection. Rust was disabled after an unrelated Rust DRM
preparation failure. This is AMD staging hardware coverage, not a boot of Linus's current tree.
No AMD staging cold, suspend/resume or full desktop test is claimed. The staging
boot also logged an applesmc probe failure (-5), Bluetooth initialization
errors and the previously observed boot-time MCEs. The T2-patched SMC driver
initialized successfully after returning to the protected production kernel.
USB storage and wired Ethernet provided the boot and SSH path; this test does
not establish full T2 device support.

Is the Navi post-init callback the right place for this sequencing quirk, and
are there additional clock-state consumers that should be refreshed? The
predicate is deliberately limited to the tested subsystem and revision.
The related 0219 board has an existing T2 allowed-mask override and needs
separate evidence before combining the cases.

Codex assisted with investigating the initialization sequence, writing the
patch and tests, and preparing this message. The session progressed from
reproducing the GPU boot failure to isolating UCLK timing and extracting a
board-specific fix with public policy and error handling preserved. The
patch contains an Assisted-by trailer. The host checks use extracted C with
mocked firmware; the T2 hardware results are recorded separately above.

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f8ca5eb9a..4e8fb9e7c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -60,6 +60,18 @@
 
 static int navi10_init_ppt_limits(struct smu_context *smu);
 
+static bool navi14_needs_late_uclk(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev = adev->pdev;
+
+	return pdev->vendor == PCI_VENDOR_ID_ATI &&
+		pdev->device == 0x7340 &&
+		pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+		pdev->subsystem_device == 0x0218 &&
+		pdev->revision == 0x41 &&
+		(adev->pm.pp_feature & PP_MCLK_DPM_MASK);
+}
+
 static const struct smu_feature_bits navi10_dpm_features = {
 	.bits = {
 		SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
@@ -356,6 +368,11 @@ navi10_init_allowed_features(struct smu_context *smu)
 		smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_ALLOWED, FEATURE_MEM_MVDD_SCALING_BIT);
 	}
 
+	/* This board times out if EnableAllSmuFeatures includes UCLK DPM. */
+	if (navi14_needs_late_uclk(adev))
+		smu_feature_list_clear_bit(smu, SMU_FEATURE_LIST_ALLOWED,
+					   FEATURE_DPM_UCLK_BIT);
+
 	if (is_asic_secure(smu) &&
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 0, 0)) &&
 	    (adev->rev_id == 0))
@@ -470,6 +487,25 @@ static int navi10_store_powerplay_table(struct smu_context *smu)
 	return 0;
 }
 
+/* DCN20 consumes these PPT states before the post-init UCLK enable. */
+static int navi14_imac_check_uclk_states(struct smu_context *smu)
+{
+	PPTable_t *ppt = smu->smu_table.driver_pptable;
+	unsigned int count, i;
+
+	if (!navi14_needs_late_uclk(smu->adev))
+		return 0;
+
+	count = ppt->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels;
+	if (!count || count > ARRAY_SIZE(ppt->FreqTableUclk))
+		return -EINVAL;
+	for (i = 0; i < count; i++) {
+		if (!ppt->FreqTableUclk[i])
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int navi10_setup_pptable(struct smu_context *smu)
 {
 	int ret = 0;
@@ -490,6 +526,10 @@ static int navi10_setup_pptable(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = navi14_imac_check_uclk_states(smu);
+	if (ret)
+		return ret;
+
 	return navi10_init_ppt_limits(smu);
 }
 
@@ -3219,6 +3259,41 @@ static int navi10_enable_mgpu_fan_boost(struct smu_context *smu)
 					       NULL);
 }
 
+/* Rebuild memory clocks before the UMC workaround and UMD clock setup. */
+static int navi14_imac_late_uclk_enable(struct smu_context *smu)
+{
+	struct smu_11_0_dpm_context *dpm = smu->smu_dpm.dpm_context;
+	struct smu_dpm_table *table = &dpm->dpm_tables.uclk_table;
+	PPTable_t *ppt = smu->smu_table.driver_pptable;
+	struct smu_feature_bits enabled;
+	int ret;
+
+	if (!navi14_needs_late_uclk(smu->adev))
+		return 0;
+
+	ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT, true);
+	if (ret)
+		return ret;
+	ret = smu_cmn_get_enabled_mask(smu, &enabled);
+	if (ret)
+		return ret;
+	if (!smu_feature_bits_is_set(&enabled, FEATURE_DPM_UCLK_BIT))
+		return -EIO;
+
+	smu_feature_list_set_bit(smu, SMU_FEATURE_LIST_SUPPORTED,
+				 FEATURE_DPM_UCLK_BIT);
+	table->clk_type = SMU_UCLK;
+	ret = smu_v11_0_set_single_dpm_table(smu, SMU_UCLK, table);
+	if (ret)
+		return ret;
+	if (!table->count)
+		return -EINVAL;
+	if (!ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete)
+		table->flags |= SMU_DPM_TABLE_FINE_GRAINED;
+
+	return smu_v11_0_init_max_sustainable_clocks(smu);
+}
+
 static int navi10_post_smu_init(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -3227,6 +3302,12 @@ static int navi10_post_smu_init(struct smu_context *smu)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	ret = navi14_imac_late_uclk_enable(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to enable late UCLK DPM: %d\n", ret);
+		return ret;
+	}
+
 	ret = navi10_run_umc_cdr_workaround(smu);
 	if (ret)
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");

base-commit: c22f9a61e288580824edbbc3ae5a29c9a338594f
-- 
2.55.0

