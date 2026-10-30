Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2F606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hiV9kjE3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D812810E0EB;
	Fri, 30 Oct 2026 01:26:15 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17D6710E0EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 01:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCrXt39bS1kWGzjfebuqCgc5577IszM4k56fDWgZmAgJ8x1HpegbNK/u2v0tbrGTw9Ghv2DyuA4p8TGtDg9tQYI3myKlrf2ijPs9Xyx+2CsdJryBmP8xz0gYdGEMtO/f4wsGf+DqH7TFLNK6NBa1EG/NFdOfwHPbfO/uIn3nORA6e31E1U7yw2woUcjSOqp9LpUwZLUUvWRA46bFaJhU9BpnQ4+D5oUDo4f0eUSzNfpUbNO/wLP820EdV5oHKLyrZoLOuCM5YClB80B8e64ZiL+2SeIsLxHpK8TVH+Mfm3H0oEbNrWmLGtv97dqBCTWtvn6O8Oq2523bA45hR1QP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpgQBP4y2nKTqgj1LbEMRK6maNed7kLpPPJ+djcV8Xo=;
 b=nY8ku5qIqYHfy+ZXBI994WHb1m3pbx99wt6Icznwt/EmmBqoM4sPyugQ98KVOsj2KKRTHtevVqJ3jpqEpfQ8OYu079vQMwi8zB7WP2ojgJ2LIZkIee9WGaRBgwHmttKDoZ+egfgnvk/1eVJUXSz9jHnIpEjejG+6gBOAmBjkGZeYbDk6EZwpQgoVL+Ce3/9BtKQrtnuYZIQGzG8CyGBdJ60hfcrZGxkUrxknH4lxVMJo7p5yB05V4/Tpy9sNHytaCbj2QAJMgzLs7GkHUl8rvZoOmcoiUcaRyUoVQ17tCwvRrvXN40o0G+ulOB/GxKauxhDUSs3oxRvR2evXG+dM/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpgQBP4y2nKTqgj1LbEMRK6maNed7kLpPPJ+djcV8Xo=;
 b=hiV9kjE3ZJn6+XzZT5OhNVf6KVIdguXYlWm8jLotxarhLeu9rk/U93CNWSesidi180AT2ZLSAFCgbaUvPS4PV9mf215DpAFJ+gU/oeCCr8iE2slUQd40apCk7lul9TiepEoi9ojT6paDK3jZrAHNFEDT+7J0S7Cm67QecdmkSuI=
Received: from PH7P220CA0039.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::26)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 01:26:05 +0000
Received: from PH1PEPF00062F24.namprd02.prod.outlook.com
 (2603:10b6:510:32b:cafe::af) by PH7P220CA0039.outlook.office365.com
 (2603:10b6:510:32b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Fri, 30
 Oct 2026 01:26:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH1PEPF00062F24.mail.protection.outlook.com (10.167.243.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 30 Oct 2026 01:26:04 +0000
Received: from alex-sierra-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 20:26:02 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Lijo.Lazar@amd.com>, <Mukul.Joshi@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add GL2 HT threshold debugfs placeholder for
 gfx12.1
Date: Thu, 29 Oct 2026 20:25:48 -0500
Message-ID: <20261030012548.3262507-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030012548.3262507-1-alex.sierra@amd.com>
References: <20261017165716.2829539-1-alex.sierra@amd.com>
 <20261030012548.3262507-1-alex.sierra@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH1PEPF00062F24:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1c14cd-0a54-4cec-9075-08df3624c411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006|4143699003|261028144727099003|261009220027099003|261021121427099003|261022105027099003|10067099003|261026121527099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|261026140227099003|260925021911599003|260925022911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: dhAEWQn1u62BViEBVQxjT5M8LFnuNGjPqnv0Ml/lMxs15KvbUs6emXqcUzTrpqW0G0+JFpmEMPi18YQJvUbVvNQxlkZwonwhDsWDKDO6zK1TMixh9BDzm4ui3y1gHOoQasBwR6Ar6KOccrY/s5k2I5InLZCYNmdN3uloZd6kXIB7dphXvCcyNDtyPYkFu2Z1xqnAzRPGLaPhHwurdX3vizfCTid6rneFbuiLGG6AqlG4k8289nyEHzu345jAdvLRUd5JK/8FDyJQKqpODXW5H478MS4rni4zMWfzEyN7pAM5oung3lq7+ENbM1WoizAaRzSlseLsCLZPeCf0NIKuGGDq+B5+UnxGcZtpzxG4LtkLvuQJL3Pd1Kg9MyMWo6QkRgkm71eik4uUworz47RWWyegX8ExdWELB1lpoHv8WRCJctrfzo9MskpbF+nRGceNyoAuNw/DT6+eqL+7eB6F087cG/fH9ZpR03Q6zKDNklWKzO+1bp/ELyimr8vQS31L30y0FF1IZtsnxlTvak3suG35po1YzyIlfc8FbnukvxrA8YkqEKUDTzFUAU4BWH1M/tBezykGq3NJufGFsfCFzDVF8mTeRKRdqwAqpFAks+8SP1qu4eF2CX3ws+4/MMwLyKpHw51KxxMZtiOA2LoHSPUV0L88FoXCr78iI40eWUuB9AdwKVyTlD9Kl7g6GxLJRiS9L95YThPCSfWvU7mV8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261028144727099003)(261009220027099003)(261021121427099003)(261022105027099003)(10067099003)(261026121527099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(261026140227099003)(260925021911599003)(260925022911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xfKyf0zlLfVxPiin1Pila0TasT+cpR677QCfPtjXPUraYhnUc71hzJ7nTc9WkrZmO42Ye8zJanaTAzBpvrO0u3l3wkZwc7EOcCxvVbvkuLIRDyp0uX6odMoQ8Qs3yVGEyf1wV/k5lPKY8blyFLFaVoBT3gdQcYwfBQKdk/2lJSjdCvzZveD0FKFL7nsIdO9tLsn0ipyy3YV8qFzOoHvo8FLB3/A2Q8HVzI0folLI8ask9wura6qwN9gBBwipaeX9NFRZ11ChY3Yrb+4Ua7Yx5Qfs1HXzJ19cFtgvmKtbJskcvTHB0vnTTJI4gxSo6tcOuF00CqLmsVfQQohcyj6BtHR8p/53HF38Go5nodt6WRk4jfvwWiNCSQap7wYgomnVGtgXSZFj1dZ3WKNpNI5qsW1nz2gF17DkNH8WZZzP5kKYDYstXiHA3JAq21IE42+t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 01:26:04.4978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1c14cd-0a54-4cec-9075-08df3624c411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH1PEPF00062F24.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

Expose the GL2 high-temporal residency threshold
(GL2C_RESIDENCY_CTRL.REG_THRESHOLD) through a new per-device debugfs
file, /sys/kernel/debug/dri/*/amdgpu_gl2_ht_threshold.

A read returns the current threshold as a decimal number; a write parses
a decimal value and range-checks it against the field width. The get/set
logic is implemented as gfx_funcs callbacks in gfx_v12_1, so the file is
only created on ASICs that support the feature (GC IP >= 12.1.0).

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     | 92 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h     | 12 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      | 51 ++++++++++++
 4 files changed, 156 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index eb04583357df..6c2e39de7bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2216,6 +2216,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	amdgpu_debugfs_jpeg_sched_mask_init(adev);
 	amdgpu_debugfs_gfx_sched_mask_init(adev);
 	amdgpu_debugfs_compute_sched_mask_init(adev);
+	amdgpu_debugfs_gl2_ht_threshold_init(adev);
 	amdgpu_debugfs_sdma_sched_mask_init(adev);
 
 	amdgpu_ras_debugfs_create_all(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1bbb3d646cfe..1047339295e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -3327,6 +3327,98 @@ void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev)
 #endif
 }
 
+/*
+ * debugfs to read/write the GL2 high-temporal residency threshold
+ * (GL2C_RESIDENCY_CTRL.REG_THRESHOLD). The value is expressed as a decimal
+ * number; writes are range-checked by the ASIC set() callback.
+ */
+#if defined(CONFIG_DEBUG_FS)
+static int amdgpu_debugfs_gl2_ht_threshold_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	u32 threshold = 0;
+	int r;
+
+	if (!adev)
+		return -ENODEV;
+	if (!adev->gfx.funcs || !adev->gfx.funcs->get_gl2_ht_threshold)
+		return -EOPNOTSUPP;
+	/* Only SPX/DPX partition modes support GL2 residency control. */
+	if (!amdgpu_gfx_gl2_residency_mode_supported(adev))
+		return -EOPNOTSUPP;
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	r = adev->gfx.funcs->get_gl2_ht_threshold(adev, &threshold);
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	if (r)
+		return r;
+
+	*val = threshold;
+	return 0;
+}
+
+static int amdgpu_debugfs_gl2_ht_threshold_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	int r;
+
+	if (!adev)
+		return -ENODEV;
+	if (!adev->gfx.funcs || !adev->gfx.funcs->set_gl2_ht_threshold)
+		return -EOPNOTSUPP;
+	/* Only SPX/DPX partition modes support GL2 residency control. */
+	if (!amdgpu_gfx_gl2_residency_mode_supported(adev))
+		return -EOPNOTSUPP;
+	if (val > U32_MAX)
+		return -EINVAL;
+
+	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
+	if (r < 0) {
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+		return r;
+	}
+
+	r = adev->gfx.funcs->set_gl2_ht_threshold(adev, (u32)val);
+
+	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+
+	return r;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gl2_ht_threshold_fops,
+			 amdgpu_debugfs_gl2_ht_threshold_get,
+			 amdgpu_debugfs_gl2_ht_threshold_set, "%llu\n");
+
+#endif
+
+void amdgpu_debugfs_gl2_ht_threshold_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev_to_drm(adev)->primary;
+	struct dentry *root = minor->debugfs_root;
+
+	/*
+	 * Only expose the file on ASICs that implement the GL2 HT threshold
+	 * control. This is currently gfx12.1+ (GC IP >= 12.1.0).
+	 */
+	if (!adev->gfx.funcs || !adev->gfx.funcs->get_gl2_ht_threshold ||
+	    !adev->gfx.funcs->set_gl2_ht_threshold)
+		return;
+
+	debugfs_create_file("amdgpu_gl2_ht_threshold", 0600, root, adev,
+			    &amdgpu_debugfs_gl2_ht_threshold_fops);
+#endif
+}
+
 int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 1b01dacddd25..34db5e7e4165 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -398,6 +398,12 @@ struct amdgpu_gfx_funcs {
 	 * persisting GL2 cache is accounted and programmed. SOC-specific.
 	 */
 	u32 (*get_num_gl2_instances)(struct amdgpu_device *adev);
+	/* Get/set the GL2 high-temporal residency threshold
+	 * (GL2C_RESIDENCY_CTRL.REG_THRESHOLD). Only implemented on ASICs that
+	 * support the feature; used to expose it through debugfs.
+	 */
+	int (*get_gl2_ht_threshold)(struct amdgpu_device *adev, u32 *val);
+	int (*set_gl2_ht_threshold)(struct amdgpu_device *adev, u32 val);
 };
 
 struct sq_work {
@@ -607,6 +613,11 @@ struct amdgpu_gfx {
 
 	/* Persisting GL2 cache request accounting (gfx12.1+) */
 	struct amdgpu_gl2_persisting_mgr	gl2_persisting;
+
+	/* Placeholder software shadow of GL2C_RESIDENCY_CTRL.REG_THRESHOLD
+	 * until the real register access is wired up (gfx12.1+).
+	 */
+	u32				gl2_ht_threshold;
 };
 
 struct amdgpu_gfx_deferred_entry {
@@ -755,6 +766,7 @@ void amdgpu_gfx_csb_preamble_end(u32 *buffer, u32 count);
 
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
+void amdgpu_debugfs_gl2_ht_threshold_init(struct amdgpu_device *adev);
 
 int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index c3a165ca5998..7efd4f2e26eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -56,6 +56,13 @@
 #define GL2C_RESIDENCY_CTRL__RESIDENCY_WAYS__SHIFT	0x0
 #define GL2C_RESIDENCY_CTRL__RESIDENCY_WAYS_MASK	0x0000000FL
 
+#define GL2C_RESIDENCY_CTRL__REG_THRESHOLD__SHIFT	0x4
+#define GL2C_RESIDENCY_CTRL__REG_THRESHOLD_MASK 	0x000003F0L
+
+#define GL2C_RESIDENCY_THRESHOLD_MAX \
+	(GL2C_RESIDENCY_CTRL__REG_THRESHOLD_MASK >> \
+	 GL2C_RESIDENCY_CTRL__REG_THRESHOLD__SHIFT)
+
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 
 #define regCP_HQD_EOP_CONTROL_DEFAULT                                             0x00000000
@@ -782,6 +789,48 @@ static u32 gfx_v12_1_get_num_gl2_instances(struct amdgpu_device *adev)
 	return hweight32(adev->aid_mask);
 }
 
+/*
+ * Read back the current GL2 high-temporal residency threshold
+ * (GL2C_RESIDENCY_CTRL.REG_THRESHOLD).
+ */
+static int gfx_v12_1_get_gl2_ht_threshold(struct amdgpu_device *adev, u32 *val)
+{
+	*val = adev->gfx.gl2_ht_threshold;
+
+	dev_info(adev->dev,
+		 "GL2 HT threshold read (placeholder): REG_THRESHOLD=%u\n",
+		 *val);
+
+	return 0;
+}
+
+/*
+ * Program the GL2 high-temporal residency threshold
+ * (GL2C_RESIDENCY_CTRL.REG_THRESHOLD).
+ *
+ */
+static int gfx_v12_1_set_gl2_ht_threshold(struct amdgpu_device *adev, u32 val)
+{
+	/*
+	 * REG_THRESHOLD is a PF-only register. As with RESIDENCY_WAYS it must
+	 * never be programmed by a guest in multi-VF mode, where it would
+	 * disturb the shared GL2 policy of the other VFs.
+	 */
+	if (amdgpu_sriov_multi_vf_mode(adev))
+		return -EPERM;
+
+	if (val > GL2C_RESIDENCY_THRESHOLD_MAX)
+		return -EINVAL;
+
+	adev->gfx.gl2_ht_threshold = val;
+
+	dev_info(adev->dev,
+		 "GL2 HT threshold write (placeholder): REG_THRESHOLD=%u\n",
+		 val);
+
+	return 0;
+}
+
 static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v12_1_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v12_1_xcc_select_se_sh,
@@ -795,6 +844,8 @@ static const struct amdgpu_gfx_funcs gfx_v12_1_gfx_funcs = {
 	.set_persisting_gl2_cache = &gfx_v12_1_set_persisting_gl2_cache,
 	.xcc_to_gl2_instance_mask = &gfx_v12_1_xcc_to_gl2_instance_mask,
 	.get_num_gl2_instances = &gfx_v12_1_get_num_gl2_instances,
+	.get_gl2_ht_threshold = &gfx_v12_1_get_gl2_ht_threshold,
+	.set_gl2_ht_threshold = &gfx_v12_1_set_gl2_ht_threshold,
 };
 
 static int gfx_v12_1_gpu_early_init(struct amdgpu_device *adev)
-- 
2.34.1

