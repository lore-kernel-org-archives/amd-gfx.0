Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1A606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Z1WFcizR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C40410E1D7;
	Mon, 26 Oct 2026 18:47:49 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A573010E1D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 18:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZKouO2PrAAcd1adoIMoEyh3eWk9DDyHr6WMvDgB+lc0MnXUXluVTLcwZjRePZ3UPSS2L/YjNDrdtyR8wvp9ZclhW2fcutl6WUYzS5uqtlYtEFKHJ36vw/CmpkG8nmocqNJb6hVsH5iEdKDORUTBy00qOQyMMgqF9OZZAYxMcSIq+UoowDOPB6l0S68dCtXMmAUpgUifZWOVLQ3CwnL8A2UkS1ZeYeRLTFcpJ5jcPxUNkP2yncc24M/2T6KBVc4voaFbI7S1xIx/1QUVmhT1ow95a2kUlz/O+PsCxlcuFYX+yjJr6+mYon3xvP1t4rKk8wizD2Re/McqOkbjFWHeHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzF8Nr6ZOdKLL7/sY8132+CzKP/eKJICz12FGbcY5n0=;
 b=EqML4luqys01CGQ9U0J/Dzx301IGMbvY1r1QhLZT6dSZaESqDl8VFzj2HyIIxVFC/cOiqu+HbUacqFzESvb+olkVrjrxkttbLDOp+7gnz2Snd+knw3xZ68TGaJK3HqjNdlFHahYtpxe8S7NSdLLgcOP80joGRKyE175YXJul3G5e7p/OlNghf38gLLSx/l/rQUxQzgH1c/gyiJvA+zH4BZBObK27ovmJ4hmZedhnAOqdkBNcynM2SUuk/aZC2f8TBUMfcTuv4ICwH6efdQG/U0ykp+IBEWcKZbxz23ehKldmSxAiaXHXA25NZbILqUerQVoZvzUjfYXC0es+dNuyHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzF8Nr6ZOdKLL7/sY8132+CzKP/eKJICz12FGbcY5n0=;
 b=Z1WFcizRE8hS8eCM67LwrZOUpVG1VxvB8HtFi/UdgLpMFo4CwYP1Z+pwinaWt5VdwdRw1rngrlbWvSEEbG/aHTz9jJ8ZuOaCLt6fBFjyDAcxZdeZMJmjI/KsFRLMIcSyS7cNW7sZZ5zc/zmdI3iWMFdt3eT+nAZnERZ7Yu5lu9Y=
Received: from SJ0PR13CA0231.namprd13.prod.outlook.com (2603:10b6:a03:2c1::26)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Mon, 26 Oct
 2026 18:47:29 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::16) by SJ0PR13CA0231.outlook.office365.com
 (2603:10b6:a03:2c1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Mon, 26
 Oct 2026 18:47:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 18:47:28 +0000
Received: from tuf-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 13:47:27 -0500
From: Apurv Mishra <Apurv.Mishra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Bing.Ma@amd.com>, <Felix.Kuehling@amd.com>, 
 <Benjamin.Welton@amd.com>, Apurv Mishra <Apurv.Mishra@amd.com>
Subject: [PATCH] drm/amdkfd: Force perfmon clock on for profiler PMC requests
Date: Mon, 26 Oct 2026 14:47:07 -0400
Message-ID: <20261026184707.103933-1-Apurv.Mishra@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a58dcc1-ec06-416d-4b26-08df33919597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261026121527099003|11063799006|5023799004|56012099006|261009223027099003|261021121427099003|261022105027099003|261022075727099003|261009221227099003|261021123027099003|10067099003|18002099003|3023799007|261026140227099003;
X-Microsoft-Antispam-Message-Info: 1gXeLlQpC9AU6RWOTAjrkWP8bVRW4vHANA1VDvg2Jv927eLhucIZ619sH4OKVpbIFG/WZmEHAXYZnlbxtCYS4vQHD63worDeUSCnlQTHtI9Lzz8ZZQVUjcItru++D1VXhhB90s4CFeT4//b6FT3vSpZpNgbgc9Sb84dqvUztPw9zeiOmJrlSPkkpXFEQJTlfI4SQyKDd7StutthqBhdb5zNnnPGe/pmYvaoWKEptGvx1NPODDe9LmbI8NzP1rcaqx1CuRN+a8UeLToQNUrER13x2jOgTLpyGX+Q8H/zmfcU/K0ReJF10JKB0amDNVcYsz2SAoVFg+wBElDJjq/LqPK33DJ2A8hPfs5TMeYzO/4wKIcjWEQmjNI6UMheWqgv/zWrwsByuCbvvqopBXTh4GAeMTslW6wbr2EYiZ6IxwfIB3ktGNmV0PCykJimCNnJ19HXTXVonmedglG4gQXdWMP0OoR+rJ7oTGqoQgK0ZTnwgiXzZdMdg2bmx/ROdptpuFpJGPPW2sDyp9j2WDwdYtPT+sfkNxqREm65JIkSvymXHxdKoSRWx79Ni2PaSpR9puUXHcBm5yUHhI+mYBizgdrOJypPedmbE56uMwsgwrEiTmkL0sNPSrmio5hByFYlGybM/ABAn4m2DQRzs/qGk2LLofvfKguWegk/a0nStNFfqXG9idBmh4S7VNIr9kREFxTYZuSuuCQb7WhLHgKqpwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261026121527099003)(11063799006)(5023799004)(56012099006)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009221227099003)(261021123027099003)(10067099003)(18002099003)(3023799007)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e+p0s8iocTSFFykELLGnkaYP4LLB/f0o5K8HzJoUj3tj8aq0SRR/l72tVN0lAtocoIy/nmYsaPcQEFfy2TjUR75omkaw/CEJVGDh/Cv/Hua32lm8bl/pbMJ/Fwd/6RsjQndUwQ/Y0ZtzjxTAmg8HQMc+Lw02S+K9jbsp8nPnN66tij2BzzR6VfA35TW2bkQDNb+bSGbUGUbSZrdoag+AzrDBeBBAFoYcwN3BNUHMmv1oaUmj0mYZvjToNd47c5b/cFpOqCANDk1Rh0dQg9yuJhEA9ZuJ4mF40cfkb00rnpG8FeP7MbnwRbYPmugHhZ6nbCZSKrbEHSJ1GHkUzap2V4QZtkpvMkIbwBQKSDr+gkDy3GuLWSH81AWkds4WRt6BFKB/wS5h2vm1iea1+DsAARLfA61bkNmWWNbl90LKGCPfpcz5TYdOTWClNdyf9va4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 18:47:28.1630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a58dcc1-ec06-416d-4b26-08df33919597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Counters and SQ/PC sampling read 0 at DPM AUTO on gfx11/gfx12 because
RLC_CGTT_MGCG_OVERRIDE.PERFMON_CLOCK_STATE is gated, and the existing
workaround (STABLE_STD) needs root and pins clocks.

Add a refcounted amdgpu_gfx_perfmon_clk_override() that forces the
perfmon clock on per XCC, holds GFXOFF off while overridden, and
restores the previous state on last release, resume and reset.

Use it from KFD_IOC_PROFILER_PMC:
- lock=1 (device mode, CAP_PERFMON): held until unlock or exit.
- lock=0, perfcount_enable=1 (dispatch mode): no CAP_PERFMON needed,
  held until process exit.

No DPM change, no new ioctl, no struct change.
Bump KFD_IOC_PROFILER_VERSION_NUM to 2.

Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 79 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    | 11 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 28 +++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 28 +++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c     | 28 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 30 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   |  5 ++
 include/uapi/linux/kfd_ioctl.h             | 10 ++-
 10 files changed, 198 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5069042b5279..551051c5e6d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2773,6 +2773,7 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
+	amdgpu_gfx_perfmon_clk_restore(adev);
 
 	r = amdgpu_dpm_reapply_umd_profile(adev);
 	if (r) {
@@ -3822,6 +3823,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->srbm_mutex);
 	mutex_init(&adev->gfx.pipe_reserve_mutex);
 	mutex_init(&adev->gfx.gfx_off_mutex);
+	mutex_init(&adev->gfx.perfmon_clk_mutex);
 	mutex_init(&adev->gfx.partition_mutex);
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0ae6e990c310..b1b3fbb49a9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1015,6 +1015,85 @@ void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable)
 	amdgpu_gfx_do_off_ctrl(adev, enable, true);
 }
 
+/* Force the perfmon clock on, or restore the saved state; @save records the old one. */
+static void amdgpu_gfx_perfmon_clk_program(struct amdgpu_device *adev,
+					   bool force_on, bool save)
+{
+	int i, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+	amdgpu_gfx_off_ctrl(adev, false);
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
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
+/*
+ * Refcounted override that keeps the perfmon clock on for profilers. The last
+ * put restores the previous state. GFXOFF is held off meanwhile, as a GFXOFF
+ * exit restores the register. Returns -EOPNOTSUPP if the ASIC can't do it.
+ */
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable)
+{
+	int r = 0;
+
+	if (amdgpu_sriov_vf(adev) || !adev->gfx.funcs ||
+	    !adev->gfx.funcs->set_perfmon_clk_override)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&adev->gfx.perfmon_clk_mutex);
+	if (enable) {
+		if (!adev->gfx.perfmon_clk_override_count++) {
+			amdgpu_gfx_off_ctrl(adev, false);
+			amdgpu_gfx_perfmon_clk_program(adev, true, true);
+		}
+	} else if (WARN_ON_ONCE(!adev->gfx.perfmon_clk_override_count)) {
+		r = -EINVAL;
+	} else if (!--adev->gfx.perfmon_clk_override_count) {
+		amdgpu_gfx_perfmon_clk_program(adev, false, false);
+		amdgpu_gfx_off_ctrl(adev, true);
+	}
+	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
+
+	return r;
+}
+
+/*
+ * While overridden, record the requested state for the final restore instead
+ * of programming it. Returns true if the caller must skip the register write.
+ */
+bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev, int xcc_id, bool on)
+{
+	if (!READ_ONCE(adev->gfx.perfmon_clk_override_count))
+		return false;
+
+	assign_bit(xcc_id, &adev->gfx.perfmon_clk_restore_mask, on);
+	return true;
+}
+
+/* Re-apply the override after resume/reset reprogrammed clock gating. */
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev)
+{
+	if (!adev->gfx.funcs || !adev->gfx.funcs->set_perfmon_clk_override)
+		return;
+
+	mutex_lock(&adev->gfx.perfmon_clk_mutex);
+	if (adev->gfx.perfmon_clk_override_count)
+		amdgpu_gfx_perfmon_clk_program(adev, true, false);
+	mutex_unlock(&adev->gfx.perfmon_clk_mutex);
+}
+
 int amdgpu_set_gfx_off_residency(struct amdgpu_device *adev, bool value)
 {
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 5939e1fb3b24..1690eb3e37bf 100644
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
@@ -503,6 +506,11 @@ struct amdgpu_gfx {
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
@@ -635,6 +643,9 @@ void amdgpu_gfx_handle_priv_fault(struct amdgpu_device *adev,
 					u8 me_id, u8 pipe_id, u8 queue_id);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
 void amdgpu_gfx_off_ctrl_immediate(struct amdgpu_device *adev, bool enable);
+int amdgpu_gfx_perfmon_clk_override(struct amdgpu_device *adev, bool enable);
+bool amdgpu_gfx_perfmon_clk_defer(struct amdgpu_device *adev, int xcc_id, bool on);
+void amdgpu_gfx_perfmon_clk_restore(struct amdgpu_device *adev);
 int amdgpu_get_gfx_off_status(struct amdgpu_device *adev, uint32_t *value);
 int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 void amdgpu_gfx_ras_suspend(struct amdgpu_device *adev, struct ras_common_if *ras_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 315dfd806d56..0a80dacd0932 100644
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
@@ -1147,6 +1149,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
+	.set_perfmon_clk_override = &gfx_v11_0_set_perfmon_clk_override,
 	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 	.detect_hung_queue = &gfx_v11_0_detect_hung_queue,
@@ -5499,23 +5502,32 @@ static void gfx_v11_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
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
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
+	    amdgpu_gfx_perfmon_clk_defer(adev, 0, !enable))
+		return;
+
+	gfx_v11_0_set_perfmon_clk_override(adev, 0, !enable);
 }
 
 static void gfx_v11_0_update_sram_fgcg(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index d334fb805020..8774dfd64022 100644
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
@@ -957,6 +959,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
 	.select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
 	.detect_hung_queue = &gfx_v12_0_detect_hung_queue,
 	.update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
+	.set_perfmon_clk_override = &gfx_v12_0_set_perfmon_clk_override,
 	.get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
 	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
 };
@@ -3938,23 +3941,32 @@ static void gfx_v12_0_unset_safe_mode(struct amdgpu_device *adev,
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
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
+	    amdgpu_gfx_perfmon_clk_defer(adev, 0, !enable))
+		return;
+
+	gfx_v12_0_set_perfmon_clk_override(adev, 0, !enable);
 }
 
 static void gfx_v12_0_update_spm_vmid(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 1589fc6413af..0b9e41c26182 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -211,6 +211,8 @@ static void gfx_v12_1_update_perf_clk(struct amdgpu_device *adev,
 				      bool enable);
 static void gfx_v12_1_xcc_update_perf_clk(struct amdgpu_device *adev,
 					 bool enable, int xcc_id);
+static bool gfx_v12_1_set_perfmon_clk_override(struct amdgpu_device *adev,
+					       int xcc_id, bool on);
 static int gfx_v12_1_init_cp_compute_microcode_bo(struct amdgpu_device *adev);
 static void gfx_v12_1_xcc_update_medium_grain_clock_gating(
 	struct amdgpu_device *adev, bool enable, int xcc_id, bool force);
@@ -746,6 +748,7 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v12_1_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v12_1_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v12_1_update_perf_clk,
+	.set_perfmon_clk_override = &gfx_v12_1_set_perfmon_clk_override,
 	.get_xccs_per_xcp = &gfx_v12_1_get_xccs_per_xcp,
 	.ih_node_to_logical_xcc = &gfx_v12_1_ih_to_xcc_inst,
 };
@@ -3155,23 +3158,32 @@ static void gfx_v12_1_xcc_update_sram_fgcg(struct amdgpu_device *adev,
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
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK) ||
+	    amdgpu_gfx_perfmon_clk_defer(adev, xcc_id, !enable))
+		return;
+
+	gfx_v12_1_set_perfmon_clk_override(adev, xcc_id, !enable);
 }
 
 static int gfx_v12_1_xcc_update_gfx_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 6c710e4a5220..8e3104ce181a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3410,6 +3410,7 @@ static inline int profile_lock_device(struct kfd_process *p,
 	if (op == 1) {
 		if (!kfd->profiler_process) {
 			kfd->profiler_process = p;
+			amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
 			status = 0;
 			mutex_unlock(&kfd->profiler_lock);
 			if (ptl->hw_supported_state == AMDGPU_PTL_HW_SUPPORTED) {
@@ -3427,6 +3428,7 @@ static inline int profile_lock_device(struct kfd_process *p,
 		}
 	} else if (op == 0 && kfd->profiler_process == p) {
 		kfd->profiler_process = NULL;
+		amdgpu_gfx_perfmon_clk_override(kfd->adev, false);
 		status = 0;
 		mutex_unlock(&kfd->profiler_lock);
 
@@ -3444,6 +3446,30 @@ static inline int profile_lock_device(struct kfd_process *p,
 	return status;
 }
 
+static int kfd_profiler_perfmon_clk(struct kfd_process *p, uint32_t gpu_id)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_dev *kfd;
+	int r = 0;
+
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, gpu_id);
+	mutex_unlock(&p->mutex);
+
+	if (!pdd || !pdd->dev || !pdd->dev->kfd)
+		return -EINVAL;
+
+	kfd = pdd->dev->kfd;
+	mutex_lock(&kfd->profiler_lock);
+	if (!pdd->perfmon_clk_req) {
+		r = amdgpu_gfx_perfmon_clk_override(kfd->adev, true);
+		pdd->perfmon_clk_req = !r;
+	}
+	mutex_unlock(&kfd->profiler_lock);
+
+	return r;
+}
+
 static inline int kfd_profiler_pmc(struct kfd_process *p,
 				   struct kfd_ioctl_pmc_settings *args)
 {
@@ -3451,6 +3477,10 @@ static inline int kfd_profiler_pmc(struct kfd_process *p,
 	struct device_queue_manager *dqm;
 	int status;
 
+	/* Dispatch mode: perfmon clock only, no lock, no CAP_PERFMON needed */
+	if (!args->lock && args->perfcount_enable)
+		return kfd_profiler_perfmon_clk(p, args->gpu_id);
+
 	/* Check if we have the correct permissions. */
 	if (!perfmon_capable())
 		return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f0ce5fc4a138..f753ecae842f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -895,6 +895,8 @@ struct kfd_process_device {
 	u32 pasid;
 	/* Indicates this process has requested PTL stay disabled */
 	bool ptl_disable_req;
+	/* Holds a perfmon clock override until the process exits */
+	bool perfmon_clk_req;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ac18c2be6ecb..7a8da8d36962 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1180,6 +1180,11 @@ static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_proce
 	if (pdd->dev->kfd->profiler_process == p) {
 		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
 		pdd->dev->kfd->profiler_process = NULL;
+		amdgpu_gfx_perfmon_clk_override(pdd->dev->kfd->adev, false);
+	}
+	if (pdd->perfmon_clk_req) {
+		amdgpu_gfx_perfmon_clk_override(pdd->dev->kfd->adev, false);
+		pdd->perfmon_clk_req = false;
 	}
 	mutex_unlock(&pdd->dev->kfd->profiler_lock);
 }
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 564faefe6978..d7fb52c30df0 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1558,7 +1558,15 @@ struct kfd_ioctl_dbg_trap_args {
 	};
 };
 
-#define KFD_IOC_PROFILER_VERSION_NUM 1
+/*
+ * KFD_IOC_PROFILER_VERSION_NUM history:
+ * - 1 - initial version
+ * - 2 - KFD_IOC_PROFILER_PMC lock also forces the perfmon clock on until the
+ *       lock is released or the process exits. lock == 0 with
+ *       perfcount_enable == 1 forces it on without CAP_PERFMON and without
+ *       locking, until the process exits
+ */
+#define KFD_IOC_PROFILER_VERSION_NUM 2
 enum kfd_profiler_ops {
 	KFD_IOC_PROFILER_PMC = 0,
 	KFD_IOC_PROFILER_VERSION = 2,
-- 
2.43.0

