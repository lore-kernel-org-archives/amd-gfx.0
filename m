Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB76C9832F
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 13:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE5610E5EE;
	Sun, 27 Sep 2026 13:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WJAH0+W8";
	dkim-atps=neutral
Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com
 [74.125.230.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6CD10E049
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 15:16:40 +0000 (UTC)
Received: by mail-lr2-f34.google.com with SMTP id
 38308e7fff4ca-3a65a351692so6417221fa.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Sep 2026 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790435798; x=1791040598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fqPVpQ+V1zmPGZnUc7U8magacWwW56Enx58NJaEH+aw=;
 b=WJAH0+W8mvC6HLtubXqkZHOGR763Eum1kcSSsC8ot+cBIrz8GELyhzVg7iwAkXVtiV
 /zwqPPc+LpoyAT5JxIA6182hTJ4tI77eaOaOYBrNZec7wnbwV0oduuvKnp3ZBeB2JbOQ
 ZQ4+mwOSYkSy0pAEUKNS5Z3C6rm1uxrzngyr4RtNQ3gKE6K1wfC3QP3bK6VDAFlyP3cS
 GbaIBki9jbGM/qcXNSdBz28oTmVAVW9TlSZnKOH5cMKNONYNp9GPxd2oQyR7Wih1awwP
 EnwCFBdCLW8UMmftaCVWXKngh7YAeDoe01OuDAipDer/Qrv7P3tRHsqicp6YoHzjT7el
 WxGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790435798; x=1791040598;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fqPVpQ+V1zmPGZnUc7U8magacWwW56Enx58NJaEH+aw=;
 b=wgkQgFv0qM4hovUnB6x9igEf+kFA8plsRrefQA/B0JuJVDsSB1oLIo4BHUXOjX3RS2
 9Z1He/2AO5xFI15FhwCfmxk/qyve4ho5UEEldKuq3jeqlWICfcKfHIb3NK7nVQkJgnVB
 BKUKbhpsa4eR2ZJlLvR2l3eyN26URmsAtDL/tBLiIJ2vm2mLtA0KB2X10dA0PoJPyQQQ
 Fbhn5lh81W5n7HZ/LivqSMSlCByO4dfgNJyjk8qBixYHvl4dOm86mtpR0e/4BPkqudgP
 jiWci9C3JRpOy7QfamVHCyKsPwEwabZW5NKI7nx5DxoLUhNDbkJXqxfd/LnKMH+QKc06
 3v1w==
X-Gm-Message-State: AFuF++nbgwSSk0HTDqKG/r4K58TjpbtmBdlm7dIydxEiLIUE++w5+ov9
 lZY+CWb6fBMRcvz49HsdSXA/PQLZDxzo4WJB5vTFEhOf3qcwgneWssK8d0oLsg==
X-Gm-Gg: AYBFou1dt3UNMHIJY5Bk2xs9KJxy3fRZ3f42XjzAbHlqyutgZWHC7A1stdqAD5p4Uqs
 NwxVVUEBpFdoyZz4a0TYh6h/zuyFA4PUGIdyFYliI8WJXtLpzazQ9MOmFZwUwQc4GMeMwtz8n1U
 qQ6FlITW5jqi1+dTxDpltDwzBEy4UfllDgfeKRrxVmvAnugmViUr57fE6xRFUsGEWG9+1GrIpnr
 M50x7K9CJsaG1P7cEMFgHJPaIQ/d6CL/yaUqGcQtWiv9VHlP2EqpJJj/SP7Aasc0/fGitMwxhDI
 aSJWJS+9HLqDu9JSXkRn4LUmgfjobQ9YOvaMKp2P2QTWyWVAKhClxw/i0fv6i6XxU8lM/4AdWeq
 WmQAYRpYIKo795RamivaSk3r/428vZJReaRb5hSNq2GU6xfiC7NCp3aGQbPrXgaOuVyPldtzt4W
 Kh2rSn4L1skJ9LBxWeYbZoHjuf+khazPmcUrO17UQS/N3cNAo7FxXdJ2+clePlsh+/oWJHX/xCW
 FVm/V8B3TimArciFDkRbQwJaCd+haiIksppJkba5VgnV8NbmWns/zLZr/S7xc0rQ6A=
X-Received: by 2002:a2e:be11:0:b0:3a3:2ff2:f818 with SMTP id
 38308e7fff4ca-3a63c30cc59mr25951381fa.13.1790435798233; 
 Sat, 26 Sep 2026 08:16:38 -0700 (PDT)
Received: from imachy
 (2001-14ba-a00e-3d00-71de-74d9-568f-7b2c.rev.dnainternet.fi.
 [2001:14ba:a00e:3d00:71de:74d9:568f:7b2c])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8e6b0795bsm1277051e87.64.2026.09.26.08.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 08:16:36 -0700 (PDT)
From: Teemu Haila <teemu.haila@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 Teemu Haila <teemu.haila@gmail.com>
Subject: [PATCH] drm/amdgpu: defer the probe on iMac20,
 2 when init times out before a reset
Date: Sat, 26 Sep 2026 18:16:19 +0300
Message-ID: <20260926151619.85213-1-teemu.haila@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 27 Sep 2026 13:26:05 +0000
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

On iMac20,2 the Radeon Pro 5700 (1002:731b, Apple subsystem 106b:021a)
fails to initialize on approximately half of all boots. The SMU replies
to GetSmuVersion and GetDriverIfVersion, then does not reply to
EnableAllSmuFeatures:

  amdgpu 0000:03:00.0: SMU: No response msg_reg: 6 resp_reg: 0
  amdgpu 0000:03:00.0: Failed to enable requested dpm features!
  amdgpu 0000:03:00.0: hw_init of IP block <smu> failed -62

A second bind of the driver recovers the GPU each time (86 of 86
failures). The failed probe has loaded the PSP. On the second probe,
nv_need_reset_on_init() reads a sign of life in MP0_SMN_C2PMSG_81, so
the driver does a mode1 reset and a vPOST before it initializes the IP
blocks.

A reset on init is not possible on the first probe. If the driver tries
a reset on init, psp_v11_0_mode1_reset() times out on
MBOX_TOS_READY_FLAG, because Apple's firmware does not load the PSP, and
the probe fails. The PSP is then still not loaded, and a later bind
cannot recover the GPU.

Because of this, on this board, return -EPROBE_DEFER when
amdgpu_device_ip_init() fails with -ETIME, this attempt did no reset on
init, and the ASIC now reports that it needs one. The failed init
unwinds as before. When the driver core probes the device again, the
probe takes the existing reset-on-init path. The decision uses only
local state: the retry has reset the ASIC, so it cannot defer again,
and a first attempt that did not load the PSP does not defer.

The retry is not done in amdgpu_pci_probe(). adev is devm allocated and
amdgpu_device_init() is not re-entrant, so a retry there needs a second
adev for the same pci_dev while the first is torn down.

The driver core probes a deferred device again only when another driver
binds, or when the deferred probe timeout expires. On this board other
drivers bind during the SMU timeout, so the retry starts almost
immediately. If no driver binds, the GPU stays deferred and the kernel
writes no "probe failed" line. dev_err_probe() records the reason, and
/sys/kernel/debug/devices_deferred shows it.

Tested on iMac20,2 with v7.2.3, built against the 7.2.3 headers: 30 of
30 boots initialized the GPU without user space intervention. The first
probe timed out on 14 of them, and each deferred retry succeeded after
a mode1 reset.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5726
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Teemu Haila <teemu.haila@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index fa67de6..600479d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3746,6 +3746,40 @@ amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
 		       apple_gmux_detect(NULL, NULL)));
 }
 
+/*
+ * On some Apple boards, the first probe after the pre-OS driver times out in
+ * SMU hw_init.  A reset on init recovers the ASIC, but the PSP does the reset,
+ * and the PSP is not loaded on the first probe.  The failed probe loads the
+ * PSP, so a retry resets the ASIC and succeeds.  Because of this, defer the
+ * probe on these boards instead of failing it.
+ */
+struct amdgpu_probe_retry_quirk {
+	u16 device;
+	u16 subsystem_vendor;
+	u16 subsystem_device;
+	u8 revision;
+};
+
+static const struct amdgpu_probe_retry_quirk amdgpu_probe_retry_quirks[] = {
+	{ 0x731b, PCI_VENDOR_ID_APPLE, 0x021a, 0x40 }, /* Radeon Pro 5700, iMac20,2 */
+};
+
+static bool amdgpu_device_probe_retry_quirk(struct amdgpu_device *adev)
+{
+	struct pci_dev *pdev = adev->pdev;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(amdgpu_probe_retry_quirks); i++) {
+		if (pdev->device == amdgpu_probe_retry_quirks[i].device &&
+		    pdev->subsystem_vendor == amdgpu_probe_retry_quirks[i].subsystem_vendor &&
+		    pdev->subsystem_device == amdgpu_probe_retry_quirks[i].subsystem_device &&
+		    pdev->revision == amdgpu_probe_retry_quirks[i].revision)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3761,6 +3795,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 {
 	struct pci_dev *pdev = adev->pdev;
 	int r, i;
+	bool reset_on_init = false;
 	bool px = false;
 	u32 max_MBps;
 	int tmp;
@@ -4037,6 +4072,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 *  E.g., driver was not cleanly unloaded previously, etc.
 	 */
 	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
+		reset_on_init = true;
 		if (adev->gmc.xgmi.num_physical_nodes) {
 			dev_info(adev->dev, "Pending hive reset.\n");
 			amdgpu_set_init_level(adev,
@@ -4110,6 +4146,14 @@ fence_driver_init:
 	if (r) {
 		dev_err(adev->dev, "amdgpu_device_ip_init failed\n");
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_INIT_FAIL, 0, 0);
+		if (r == -ETIME && !reset_on_init &&
+		    amdgpu_device_probe_retry_quirk(adev) &&
+		    amdgpu_asic_need_reset_on_init(adev)) {
+			dev_warn(adev->dev,
+				 "init timed out before the ASIC could be reset, deferring the probe to retry with a reset on init\n");
+			r = dev_err_probe(adev->dev, -EPROBE_DEFER,
+					  "init timed out before the ASIC could be reset, deferring the probe to retry with a reset on init\n");
+		}
 		goto release_ras_con;
 	}
 

base-commit: a24db07159cdd27eba171278366670e9a6c9643f
-- 
2.55.0

