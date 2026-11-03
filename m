Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB49F606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YgbqzrkL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2AE10F31B;
	Tue,  3 Nov 2026 02:32:20 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC8810F31B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xetp5Guop6buKU0t5j55d5AINLR+rm0yLqIjrhgAoP7t/t5YaWv3wHI0flitrt2MW7rV0gWcDUHNJJChe0plzLva695GuLwH/h3gucb8h4vyZqUYv8VdnbI8Nknc8TmBI61xcxhlc3gb1Oo414htVLERGsXho+7/MwXzL2ZR1L66OjU3x1KBVoeuoHhIAny1IrNfgyjrlkS9BSuepul5P2JAw5hMmHNU9xvkli5T/i86P1iJk8K+luUScjZ4P2abMIQA2kXr554PUde0a/m7pN8MVj5EeL1XTMt6LHY4fZOxt+E09gLUP/P5QYDhv775ocJY2Vo3DJC+4svEoOOjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbgYYc1gD1Q22OYlSKAEA0u9+YC3Arux0e1ob2KVZEw=;
 b=wiup25hJ6LU3VzfNBLAtZ+pjCRaKpvVYaizl8LjbuFgPwmBPW1jeaVF2m6mK/OZltcNmIBJtXeVsVj0MwGTJYSm/igBA/HXEd6kOv57DSZ6ZFU9J7bri1vU38eBxP6OW8/9RzyQKlNE3YaSIm5/XoNbfUdlZhyJn50Xbz0vF8NnfxANVSlZvzydMc743JYx3s40pVw8y/tAOB3xg1aH5c5EPnpzaAGXcPdJHRs5dkRE1MOAK40MQM569xnM8Gxt9fDk7ZZ9o0wigR1XxkuHgyyjAEGT8rkR2rECfja4BOkTvPO5C+TIgntPEsHb5542usbjdhHEMWnlzafLOFDoX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbgYYc1gD1Q22OYlSKAEA0u9+YC3Arux0e1ob2KVZEw=;
 b=YgbqzrkLMCLPbvAjgowW/0iIarnGSiHS0SwYwtWXWXnczz/1KpIx4+otIY4Eg1r8OSI5EtiyahOwoxZpnq9EeyIDWZ11Bc79g34/k94oRkGA6lxfCy41PTWfmIIaULwei2q/r1NGC9Gb10lPQzJT0QmkZEcw5Fe6IAwJ/pdeV0U=
Received: from CH0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:610:75::15)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Tue, 3 Nov 2026
 02:32:05 +0000
Received: from CH01EPF000BE943.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::97) by CH0PR04CA0100.outlook.office365.com
 (2603:10b6:610:75::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 02:32:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE943.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 02:32:05 +0000
Received: from tuf-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 20:32:00 -0600
From: Apurv Mishra <Apurv.Mishra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Bing.Ma@amd.com>, <Benjamin.Welton@amd.com>, 
 <James.Zhu@amd.com>, <Jason.Tang@amd.com>, Apurv Mishra
 <Apurv.Mishra@amd.com>
Subject: [PATCH v2] drm/amdkfd: Force perfmon clock on for profiler PMC
 requests
Date: Mon, 2 Nov 2026 21:31:45 -0500
Message-ID: <20261103023145.61021-1-Apurv.Mishra@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE943:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: c55da284-21cd-4b7d-4a76-08df3952a6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|261102123227099003|3023799007|18002099003|56012099006|11063799006|5023799004|261009223027099003|261021123027099003|261021121427099003|261028144727099003|261022105027099003|261022075727099003|261022115727099003|10067099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: fFCkGFMvm+qRar2wStCQc5bC6zMUgiL85b/u+1NvxSC0OX9+TkLKpmfBrfi7HRpEpHL6cyuJ+AIcha92VMZqwEuqfi1drTv4hBiIznMt8woZqMEefh2WcKHQUPcAkh3gwx6EEEP/dH+T7oa+NbFVD7YhxrUiPUvNnq+qNw+6xSqp8Hy2IIFCDr3tUAq0mG3btdVV7+ObkavZVeN+L5w9xg3yvojzWZA+QlPmATq+80BYOoQE2uoC6V659uS0aPRxfpGrxyiuXH+rqfQxgjPWO6H+hC1rtMzvgmlR5O8+AuAc9ygUsHwLbytdWdj3/brzttAekzM1jaa9Fd/L7G5hyUGUsJFJ1RcSYNdUXXuBNB8EQpUV64witlRTnhuYDzRfZxm8HU9yk73dAiB+RQ0uyNZQAITkjlVX3l2kRJds65JFSw9qAJQDGv6hcQ5x30Mn90FWxoDyzwDzCTknxNaNyMAud9g+ClocRIoW4u6vVFaw42oBOxNQNu6ZMzZqRP3LiOgA6tnv1AnE40q5qlXhCR4auG7q7kW8aiDO7o4cwLvs4P6rDZt92KroG9VvekOMzG/hTPr2v0eFpVUNEsIrD+grsJJ9UvC2QHGSMQQ4HKpGElkf86YUIgScqf/9R/c2H1vttM5u7W5B4Mnl8k9NvdpDxLGKJ7j208WmxVVmAkY5tlNLf6K6JiMYpIrov5vN8MwL52I67i+Hq/qSC1Mwxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(261102123227099003)(3023799007)(18002099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261022105027099003)(261022075727099003)(261022115727099003)(10067099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vSht49lt3R4ATdfhTVIOOybYDvI+owtfIlR+MIjY4oKHplznbkqRKMz5LtDV5HIPQJ4GPyA4WXjdALxlnXTk1JtGiFX+Ol/yiQIkoqJdfkU3bL/Dz00yA5QMlW87Yx/vC6FVTbhIUirQBmuVSJQW6D5zSNbXg1NQSiRfTFnkjCBn4ZAjjLX/1N0F/rZCO5UWuJYOjIFnIZshuhLlo4ZDVEymM1ngEZCj88kaz6+yIiVosGggzMQtYUBFfjYCuoDBMAhbY0PxLKa1aeFKMvIDO2hSWJ4KB7oLHOl5lXW7shUTUnWVZ4ivbOIRRDaqm2qPuWvyImwu59tGAPFyYaXgIiX7RKmr6wDndz6fnoPOStPkQRZ11t9wflQt6tEpU4sJk4esSOO+yMDGyBvent3TzLSCRlP+IIbkAFfO546U5tlIGn5eB8nM+8gNyl5Eyxtz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:32:05.7869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c55da284-21cd-4b7d-4a76-08df3952a6c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE943.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 because
RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing
workaround (STABLE_STD) needs root and pins clocks.

Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the
perfmon clock on per XCC, keeps GFXOFF disallowed while held, and
restores the previous state on last release, resume and reset.
perfmon_clk_mutex serializes it with the GFX clock gating sequences
and the soc21/soc24 stable pstate hook.

Use it from KFD_IOC_PROFILER_PMC, after binding the process to the GPU
and under reset_domain->sem:
- lock=1 (device mode, CAP_PERFMON): held until unlock or exit.
- lock=0, perfcount_enable=1 (dispatch mode): no CAP_PERFMON needed,
  held until lock=0, perfcount_enable=0 or process exit.

No DPM change, no new ioctl, no struct change. Bump
KFD_IOC_PROFILER_VERSION_NUM to 2.

v2:
- Take GFXOFF outside perfmon_clk_mutex to break a pm.mutex lock cycle
- Replace the racy defer() with amdgpu_gfx_perfmon_clk_update(), and hold
  perfmon_clk_mutex across the GFX clock gating sequences
- Bind the process to the GPU before forcing the perfmon clock on
- Take reset_domain->sem before profiler_lock
- Release a dispatch-mode hold with lock=0, perfcount_enable=0

Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 89 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 11 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 28 +++++--
 drivers/gpu/drm/amd/amdgpu/soc21.c         |  2 +
 drivers/gpu/drm/amd/amdgpu/soc24.c         |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 63 +++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 20 +++++
 include/uapi/linux/kfd_ioctl.h             | 11 ++-
 12 files changed, 261 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 44091ac12fa9..04422c1e1f86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2779,6 +2779,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
+	amdgpu_gfx_perfmon_clk_restore(adev);
 
 	amdgpu_device_fill_reset_magic(adev);
 
@@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->srbm_mutex);
 	mutex_init(&adev->gfx.pipe_reserve_mutex);
 	mutex_init(&adev->gfx.gfx_off_mutex);
+	mutex_init(&adev->gfx.perfmon_clk_mutex);
 	mutex_init(&adev->gfx.partition_mutex);
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a6f95ff47d24..c9c4c3d4e88d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1015,6 +1015,95 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable)
 	amdgpu_gfx_do_off_ctrl(adev, enable, true);
 }
 
+/*
+ * Force the perfmon clock on, or restore the saved state; @save records the old
+ * one. Called with perfmon_clk_mutex held and GFXOFF disallowed.
+ */
+static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev,
+					   bool force_on, bool save)
+{
+	int i, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	for (i = 0; i < num_xcc; i++) {
+		bool on = force_on || test_bit(i, &adev->gfx.perfmon_clk_restore_mask);
+		bool in_safe_mode = adev->gfx.rlc.in_safe_mode[i];
+		bool was_on;
+
+		if (!in_safe_mode)
+			amdgpu_gfx_rlc_enter_safe_mode(adev, i);
+		was_on = adev->gfx.funcs->set_perfmon_clk_override(adev, i, on);
+		if (!in_safe_mode)
+			amdgpu_gfx_rlc_exit_safe_mode(adev, i);
+
+		if (save)
+			assign_bit(i, &adev->gfx.perfmon_clk_restore_mask, was_on);
+	}
+}
+
+/*
+ * Refcounted override that keeps the perfmon clock on for profilers. The last
+ * put restores the previous state. Each hold keeps GFXOFF disallowed, as a
+ * GFXOFF exit restores the register. Returns -EOPNOTSUPP if the ASIC can't do it.
+ *
+ * GFXOFF control takes pm.mutex, which clock gating holds around
+ * perfmon_clk_mutex, so it must be called without perfmon_clk_mutex held.
+ */
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable)
+{
+	int r = 0;
+
+	if (amdgpu_sriov_vf(adev) || !adev->gfx.funcs ||
+	    !adev->gfx.funcs->set_perfmon_clk_override)
+		return -EOPNOTSUPP;
+
+	if (enable)
+		amdgpu_gfx_off_ctrl(adev, false);
+
+	mutex_lock(&adev->gfx.perfmon_clk_mutex);
+	if (enable) {
+		if (!adev->gfx.perfmon_clk_override_count++)
+			amdgpu_gfx_perfmon_clk_program(adev, true, true);
+	} else if (WARN_ON_ONCE(!adev->gfx.perfmon_clk_override_count)) {
+		r = -EINVAL;
+	} else if (!--adev->gfx.perfmon_clk_override_count) {
+		amdgpu_gfx_perfmon_clk_program(adev, false, false);
+	}
+	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
+
+	if (!enable && !r)
+		amdgpu_gfx_off_ctrl(adev, true);
+
+	return r;
+}
+
+/*
+ * Program the perfmon clock for clock gating. While overridden, only record
+ * the state for the final restore. Called with perfmon_clk_mutex held.
+ */
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id, bool on)
+{
+	lockdep_assert_held(&adev->gfx.perfmon_clk_mutex);
+
+	if (adev->gfx.perfmon_clk_override_count)
+		assign_bit(xcc_id, &adev->gfx.perfmon_clk_restore_mask, on);
+	else
+		adev->gfx.funcs->set_perfmon_clk_override(adev, xcc_id, on);
+}
+
+/* Re-apply the override after resume/reset reprogrammed clock gating. */
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)
+{
+	if (!adev->gfx.funcs || !adev->gfx.funcs->set_perfmon_clk_override)
+		return;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->gfx.perfmon_clk_mutex);
+	if (adev->gfx.perfmon_clk_override_count)
+		amdgpu_gfx_perfmon_clk_program(adev, true, false);
+	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)
 {
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f5fb2e585e8a..1bfd12dd3956 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -362,6 +362,9 @@ struct amdgpu_gfx_funcs {
 				 u32 queue, u32 vmid, u32 xcc_id);
 	void (*init_spm_golden)(struct amdgpu_device *adev);
 	void (*update_perfmon_mgcg)(struct amdgpu_device *adev, bool enable);
+	/* set the perfmon clock, returns its previous state */
+	bool (*set_perfmon_clk_override)(struct amdgpu_device *adev, int xcc_id,
+					 bool on);
 	int (*get_gfx_shadow_info)(struct amdgpu_device *adev,
 				   struct amdgpu_gfx_shadow_info *shadow_info,
 				   bool skip_check);
@@ -500,6 +503,11 @@ struct amdgpu_gfx {
 	uint32_t                        gfx_off_residency;  /* last logged residency */
 	uint64_t                        gfx_off_entrycount; /* count of times GPU has get into GFXOFF state */
 
+	/* perfmon clock override for profilers */
+	struct mutex			perfmon_clk_mutex;
+	uint32_t			perfmon_clk_override_count;
+	unsigned long			perfmon_clk_restore_mask; /* per XCC */
+
 	/* pipe reservation */
 	struct mutex			pipe_reserve_mutex;
 	DECLARE_BITMAP			(pipe_reserve_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
@@ -632,6 +640,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
 					u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable);
+void amdgpu_gfx_perfmon_clk_update(struct amdgpu_device *adev, int xcc_id, bool on);
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_common_if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index a7ed4923857b..a01244621fa3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -365,6 +365,8 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v11_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on);
 
 static void gfx11_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
@@ -1110,6 +1112,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
+	.set_perfmon_clk_override = &gfx_v11_0_set_perfmon_clk_override,
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 };
@@ -5457,23 +5460,29 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
 }
 
-static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
-				      bool enable)
+static bool gfx_v11_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on)
 {
 	uint32_t def, data;
 
-	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
-		return;
-
 	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
 
-	if (enable)
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
-	else
+	if (on)
 		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+	else
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
 
 	if (def != data)
 		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+	return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v11_0_update_perf_clk(struct amdgpu_device *adev,
+				      bool enable)
+{
+	if (adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK)
+		amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);
 }
 
 static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,
@@ -5680,6 +5689,8 @@ static void gfx_v11_0_update_coarse_grain_clock_gating(struct amdgpu_device *ade
 static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */
+	mutex_lock(&adev->gfx.perfmon_clk_mutex);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	gfx_v11_0_update_coarse_grain_clock_gating(adev, enable);
@@ -5701,6 +5712,7 @@ static int gfx_v11_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 	        gfx_v11_0_enable_gui_idle_interrupt(adev, enable);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ec1e142549c5..9e754c25b15c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -289,6 +289,8 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_0_userq_priv_fault_work(struct work_struct *work);
 static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on);
 
 static void gfx_v12_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 					uint64_t queue_mask)
@@ -952,6 +954,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v12_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
+	.set_perfmon_clk_override = &gfx_v12_0_set_perfmon_clk_override,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 };
@@ -4045,23 +4048,29 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
 }
 
-static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
-				      bool enable)
+static bool gfx_v12_0_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on)
 {
 	uint32_t def, data;
 
-	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
-		return;
-
 	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
 
-	if (enable)
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
-	else
+	if (on)
 		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+	else
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
 
 	if (def != data)
 		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+	return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v12_0_update_perf_clk(struct amdgpu_device *adev,
+				      bool enable)
+{
+	if (adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK)
+		amdgpu_gfx_perfmon_clk_update(adev, 0, !enable);
 }
 
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
@@ -4335,6 +4344,8 @@ static void gfx_v12_0_update_sram_fgcg(struct amdgpu_device *adev,
 static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
+	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */
+	mutex_lock(&adev->gfx.perfmon_clk_mutex);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 
 	gfx_v12_0_update_coarse_grain_clock_gating(adev, enable);
@@ -4356,6 +4367,7 @@ static int gfx_v12_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v12_0_enable_gui_idle_interrupt(adev, enable);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index f812d6d81e9c..958b4ad39d9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -215,6 +215,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
 					 bool enable, int xcc_id);
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on);
 static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
 static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
 	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
@@ -888,6 +890,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v12_1_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v12_1_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v12_1_update_perf_clk,
+	.set_perfmon_clk_override = &gfx_v12_1_set_perfmon_clk_override,
 	.get_xccs_per_xcp = &gfx_v12_1_get_xccs_per_xcp,
 	.ih_node_to_logical_xcc = &gfx_v12_1_ih_to_xcc_inst,
 };
@@ -3471,28 +3474,36 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct amdgpu_device *adev,
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
 }
 
-static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
-					  bool enable, int xcc_id)
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on)
 {
 	uint32_t def, data;
 
-	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
-		return;
-
 	def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE);
 
-	if (enable)
-		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
-	else
+	if (on)
 		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+	else
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
 
 	if (def != data)
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CGTT_MGCG_OVERRIDE, data);
+
+	return !!(def & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK);
+}
+
+static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
+					  bool enable, int xcc_id)
+{
+	if (adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK)
+		amdgpu_gfx_perfmon_clk_update(adev, xcc_id, !enable);
 }
 
 static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
 					     bool enable, int xcc_id)
 {
+	/* RLC_CGTT_MGCG_OVERRIDE is shared with the perfmon clock override */
+	mutex_lock(&adev->gfx.perfmon_clk_mutex);
 	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
 
 	gfx_v12_1_xcc_update_coarse_grain_clock_gating(adev, enable, xcc_id);
@@ -3515,6 +3526,7 @@ static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, enable, xcc_id);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, xcc_id);
+	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 599d47e1d38b..ed10c258703c 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -520,6 +520,7 @@ static void soc21_init_doorbell_index(struct amdgpu_device *adev)
 static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
 					  bool enter)
 {
+	mutex_lock(&adev->gfx.perfmon_clk_mutex);
 	if (enter)
 		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	else
@@ -527,6 +528,7 @@ static int soc21_update_umd_stable_pstate(struct amdgpu_device *adev,
 
 	if (adev->gfx.funcs->update_perfmon_mgcg)
 		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
+	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index 6c8b8ed4a44d..46d746dd37b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -302,6 +302,7 @@ static void soc24_init_doorbell_index(struct amdgpu_device *adev)
 static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
 					  bool enter)
 {
+	mutex_lock(&adev->gfx.perfmon_clk_mutex);
 	if (enter)
 		amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	else
@@ -309,6 +310,7 @@ static int soc24_update_umd_stable_pstate(struct amdgpu_device *adev,
 
 	if (adev->gfx.funcs->update_perfmon_mgcg)
 		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
+	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7fcfc150a7fc..e4fb9f5aa3b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3343,20 +3343,29 @@ static inline int profile_lock_device(struct kfd_process *p,
 
 	mutex_lock(&p->mutex);
 	pdd = kfd_process_device_data_by_id(p, gpu_id);
+	/* Bind for the runtime PM reference before programming the perfmon clock */
+	if (pdd && op == 1)
+		pdd = kfd_bind_process_to_device(pdd->dev, p);
 	mutex_unlock(&p->mutex);
 
+	if (IS_ERR(pdd))
+		return PTR_ERR(pdd);
 	if (!pdd || !pdd->dev || !pdd->dev->kfd)
 		return -EINVAL;
 
 	kfd = pdd->dev->kfd;
 	ptl = &pdd->dev->adev->psp.ptl;
 
+	/* Before profiler_lock, which reset takes in kfd_resume() */
+	down_read(&kfd->adev->reset_domain->sem);
 	mutex_lock(&kfd->profiler_lock);
 	if (op == 1) {
 		if (!kfd->profiler_process) {
 			kfd->profiler_process = p;
+			amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
 			status = 0;
 			mutex_unlock(&kfd->profiler_lock);
+			up_read(&kfd->adev->reset_domain->sem);
 			if (ptl->hw_supported_state == AMDGPU_PTL_HW_SUPPORTED) {
 				status = kfd_ptl_disable_request(pdd, p);
 				if (status != 0)
@@ -3372,8 +3381,10 @@ static inline int profile_lock_device(struct kfd_process *p,
 		}
 	} else if (op == 0 && kfd->profiler_process == p) {
 		kfd->profiler_process = NULL;
+		amdgpu_gfx_perfmon_clk_override(kfd->adev, false);
 		status = 0;
 		mutex_unlock(&kfd->profiler_lock);
+		up_read(&kfd->adev->reset_domain->sem);
 
 		if (ptl->hw_supported_state == AMDGPU_PTL_HW_SUPPORTED) {
 			status = kfd_ptl_disable_release(pdd, p);
@@ -3385,10 +3396,52 @@ static inline int profile_lock_device(struct kfd_process *p,
 		return status;
 	}
 	mutex_unlock(&kfd->profiler_lock);
+	up_read(&kfd->adev->reset_domain->sem);
 
 	return status;
 }
 
+/*
+ * Take or drop this process's dispatch-mode perfmon clock hold. Taking it again
+ * is a no-op. Dropping returns -ENOENT without a hold, and for the device lock
+ * holder, whose lock == 0 must still unlock.
+ */
+static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id,
+				    bool enable)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_dev *kfd;
+	int r = 0;
+
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, gpu_id);
+	/* Bind for the runtime PM reference before programming the perfmon clock */
+	if (pdd && enable)
+		pdd = kfd_bind_process_to_device(pdd->dev, p);
+	mutex_unlock(&p->mutex);
+
+	if (IS_ERR(pdd))
+		return PTR_ERR(pdd);
+	if (!pdd || !pdd->dev || !pdd->dev->kfd)
+		return -EINVAL;
+
+	kfd = pdd->dev->kfd;
+
+	/* Before profiler_lock, which reset takes in kfd_resume() */
+	down_read(&kfd->adev->reset_domain->sem);
+	mutex_lock(&kfd->profiler_lock);
+	if (!enable && (!pdd->perfmon_clk_req || kfd->profiler_process == p))
+		r = -ENOENT;
+	else if (pdd->perfmon_clk_req != enable)
+		r = amdgpu_gfx_perfmon_clk_override(kfd->adev, enable);
+	if (!r)
+		pdd->perfmon_clk_req = enable;
+	mutex_unlock(&kfd->profiler_lock);
+	up_read(&kfd->adev->reset_domain->sem);
+
+	return r;
+}
+
 static inline int kfd_profiler_pmc(struct kfd_process *p,
 				   struct kfd_ioctl_pmc_settings *args)
 {
@@ -3396,6 +3449,16 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
 	struct device_queue_manager *dqm;
 	int status;
 
+	if (!args->lock) {
+		/* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON needed */
+		if (args->perfcount_enable)
+			return kfd_profiler_perfmon_clk(p, args->gpu_id, true);
+
+		/* Drop a dispatch-mode hold if there is one, else unlock as before */
+		if (!kfd_profiler_perfmon_clk(p, args->gpu_id, false))
+			return 0;
+	}
+
 	/* Check if we have the correct permissions. */
 	if (!perfmon_capable())
 		return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d8631847f0eb..32c3c23d6d14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -886,6 +886,8 @@ struct kfd_process_device {
 	u32 pasid;
 	/* Indicates this process has requested PTL stay disabled */
 	bool ptl_disable_req;
+	/* Holds a dispatch-mode perfmon clock override until released or exit */
+	bool perfmon_clk_req;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index dd938788bdd9..7ba1c4ab283b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1176,12 +1176,32 @@ static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
 
 static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_process_device *pdd)
 {
+	struct amdgpu_device *adev = pdd->dev->adev;
+	int puts = 0;
+
 	mutex_lock(&pdd->dev->kfd->profiler_lock);
 	if (pdd->dev->kfd->profiler_process == p) {
 		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
 		pdd->dev->kfd->profiler_process = NULL;
+		puts++;
+	}
+	if (pdd->perfmon_clk_req) {
+		pdd->perfmon_clk_req = false;
+		puts++;
 	}
 	mutex_unlock(&pdd->dev->kfd->profiler_lock);
+
+	/*
+	 * Nothing is held on the kfd_create_process() error path, which holds
+	 * kfd_processes_mutex and so must not wait for a reset.
+	 */
+	if (!puts)
+		return;
+
+	down_read(&adev->reset_domain->sem);
+	while (puts--)
+		amdgpu_gfx_perfmon_clk_override(adev, false);
+	up_read(&adev->reset_domain->sem);
 }
 
 static void kfd_process_destroy_pdds(struct kfd_process *p)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 749d196e2114..34f3ffaf1c66 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1557,7 +1557,16 @@ struct kfd_ioctl_dbg_trap_args {
 	};
 };
 
-#define KFD_IOC_PROFILER_VERSION_NUM 1
+/*
+ * KFD_IOC_PROFILER_VERSION_NUM history:
+ * - 1 - initial version
+ * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until the
+ *       lock is released or the process exits. lock == 0 with
+ *       perfcount_enable == 1 forces it on without CAP_PERFMON and without
+ *       locking, until lock == 0 with perfcount_enable == 0 or the process
+ *       exits
+ */
+#define KFD_IOC_PROFILER_VERSION_NUM 2
 enum kfd_profiler_ops {
 	KFD_IOC_PROFILER_PMC = 0,
 	KFD_IOC_PROFILER_VERSION = 2,
-- 
2.43.0

