Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B554606A327
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NfUspiYC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCA010E450;
	Tue,  3 Nov 2026 02:23:09 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E76C410E450
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 02:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd0V1pQRGSjwZkp9n/nQB/0kfJSgPA6C8DE+QB31gu3icFxsE+9p7C5SBTbVU/GulxgdTST2uYnZoQUVMEPSGn3J2s8mWffQnO+odtlkqIjTR0VwMQoPlTMGVumGYh19QdOOGyadRdRZkcwTAw1nl2U4gV5XQNJAPaZiPA+H/IcoBnwd2iekEoi2C3apME2EC4QGmezxjxEqlrsKdoO/cPXoWNgblJ5ctkse+6JqNCmYbG702dcVidQad9wi5b+YE8q2vkgMKQeFzhEQ6d5r3oOQElCihbtPNBa6jbXgc+7umeXJvIQZqhYiU4ndnOy0NdlMIVw8RbAmho2fFxw6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKNk7Tppki7uK+SYLvKd0Br0D08t8GhcXYWZZ4+LR/Q=;
 b=mkohd4R55U93+E9Lti04wAPeBXmgahs+bSv7BjXj99YaB+R3gSszPSIrK4K5qjrVQ7bZl44j9kCYHYWmL3kaD5jNoZ+aneHcJ4Rtw8zx4bOZ+HQTYQODGxfFJH+cQwjKsiMMzhYgg+WD3YIF0Lm0BG9lYioPk6JQeXUuHyxjpZ+PMco/02/ZaALxAWogIA0GkoxlSXfBn9lcNnVF3r5wyzpB8l69CbWMHgQArXJxpfPTWN+HWc8RY7ia/5HTLbC50athasRliykkn7EtHqbmcaifans+QDEOikc6uVEgITE2ArEJ67vyGqOGbBCOCz2qeaQut6wlRQvWKEEG4J9XCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKNk7Tppki7uK+SYLvKd0Br0D08t8GhcXYWZZ4+LR/Q=;
 b=NfUspiYCZRR71nKEkaZQuso6WUJaLo//DXCcLCARVG2kx9O3irzA3xdLznh/4jN2anEwu7mXV7PI3JuLyFXuBEqQp7J+UhGQDv/6O3hRPN1O1MtxXvhX+5OBMOoky/p963+7ApN21q95AGh3/PAUYjdKY29B/9meK7+atnPaW0g=
Received: from BN9PR03CA0924.namprd03.prod.outlook.com (2603:10b6:408:107::29)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:22:56 +0000
Received: from BN5PEPF00046988.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::a1) by BN9PR03CA0924.outlook.office365.com
 (2603:10b6:408:107::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 02:22:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF00046988.mail.protection.outlook.com (10.167.245.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 02:22:55 +0000
Received: from tuf-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 20:22:55 -0600
From: Apurv Mishra <Apurv.Mishra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Bing.Ma@amd.com>, <Benjamin.Welton@amd.com>, 
 <James.Zhu@amd.com>, <Jason.Tang@amd.com>, Apurv Mishra
 <Apurv.Mishra@amd.com>
Subject: [PATCH v2] drm/amdkfd: force perfmon clock on for profiler PMC
 requests
Date: Mon, 2 Nov 2026 21:22:35 -0500
Message-ID: <20261103022235.60665-1-Apurv.Mishra@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046988:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 5341dea5-28ab-43cd-f237-08df39515ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|261102123227099003|18002099003|3023799007|56012099006|5023799004|11063799006|261022075727099003|261026121527099003|261021121427099003|261026140227099003|261022115727099003|261022105027099003|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: VkIv2N+skHQM3OMIaJzsDF7xf98FlhFmwjx00XTLVGsmDEGuEBdxL5pM+xq6OQFZwLGSkkAqss2uWfkcdsjoWwsNyx5NxD9EgmxsF6RiiIKApuEFFmyV/uFLgnHf3UtMYHwT1uW00kAUe4IcQeHM/gnX+V+nX8ZX0XG+nQTVnY/VBXNDLevpQ5vS7/q728t/mJzJgJ1FXA5uvj54FTlQHXEznNVjRatTtyZUW2REtcQFs7CrTEizoFlxFyWKW51B2AD/VQUNclEWj4HCKv5p07CTuhgADv/we3wEpPLJlxZWx+EAK5yqMpXdUmuWQ84EKWEFQ3pYdk3LF61nkmkWcp4j6H46js8aIsJGhvYiBWc1NwXdCATK0X3fAwq3/Z3A8DJwUEpow79MY1Zgv3Hhphgl3MWRcEO3wXLKak51XH+JngyMWSENWKTgTrG3ejR8sRdKsSD7znQEa13B3/k+jEsgzBbgXbdeTs1O+zwZZZjPVKEKDgGIm//iIbc8Vi+At2q8Fj7AemH5AExkOxjacfkwehgZ02pahTaGUzR310ICrdEH5ZdGVc3QR3Rv463XDmXxOusweT5qeM3Pafu8yyhksjJ4hKkNQRnBo2wnn5e9wwn73SP9x6pVt62hN1aYzY0V5WJWMIGe33nyygJoDZU1WYVWu2Vxg/FsFMgE+S7lGHjE0brdv1apB8Aw2eovA9QrLyMGmE0PEJRN8k8rMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(261102123227099003)(18002099003)(3023799007)(56012099006)(5023799004)(11063799006)(261022075727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022115727099003)(261022105027099003)(261028144727099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Vhk77/GKwIyc5VJP+7Dii5k0F3aIisVIRz66cPU9HwVkvl070soDOi7zmnvWkJylrPvAR3BVy2H4jc4smw9SQe/hz9DN6Mq3v+y3YR0l/CsSGCxESzywUvq452KndP+9KJR44aGjEVsrVhqago3QJqowDhopAGrEuLBSzAV4usfaeQB5PgbUj0Fa11CglBTmBvFwYg/guT29NuUsrgEa8JqTKLHP8c0y/qQGfFBudSEwM2QvwJBycOYJV/CFPNfJyl6Z7s12MQBPrntdIUVHgS6PUiLt5aogVOnfN3S4CXGagCJaAg9Zi0AoGQCNXe/Vv3tjcws59CMHHWeNZvClk1xIfTUvjFhadwb11lPeZT7MT34Jg9Hti97YGYsD0GATwyUMM9GHQtBEbJFjiA7kOjzelCsXTHUsFf3CjvqpRM74lbPjANFnCFKO7asYZN1A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:22:55.7716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5341dea5-28ab-43cd-f237-08df39515ef4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046988.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
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

Change-Id: I45a76007861d8f322e63bb5b29bf1ef5d7b7e0cb
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

