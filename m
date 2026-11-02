Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CC606C3F2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=w1FvmBTV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505C110E64B;
	Mon,  2 Nov 2026 16:02:27 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040DC10E648
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTpeEFkc9czKKqYy5/KndMeTV16h8VL+Yp9HGx6YXJGoa+BysdUu3kjIlFYUQ8C9FwXKKDwcgOBxlZ1GHh1RYgqKXmKykMols0jMqoznKF0bdfOBcgoG8k54LlBx+auPirjpNTvaXt7wJWs+X9DSLbfou+POSVYIvH2nPDxFBf7V8lkIzLHIBDrlDX3r5mVc3TEej0H2Y2zN+ce8uWl1x2ruSKlNgVb/kjz3r1ejGTQHNs7K2VndGG9BNDwsrvszgfnMmA6LfIFfboVuS+0MjUOzOuR6fPZODmchXUQLayG0PouBCu6+reM+pDwHkUhI8sF2KfdASKJ+yiUcJzyveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Kps/geFK0JfHGCl8YDiLQhs/amfPSYTHKhwvkVLG6Q=;
 b=BQMthwQq9zRSTvZa2UKMGdbbcbHmKlXELJcUNCicBs73OR845Ds4y4nrfDaUaUwYzI3CKTuwgyyemsyyhBmaq4i96q/DfJc4pm9b8qENxNaVopBDCy+66LyZuhnzw4ng04NcunkVtfcBm7F/v8nfqlQLTYyfCN+9fbKeCsvlCa7qbEN0NcAmEUEurHUmseozZbmWaUhzbOYeHYhS1bQ/gXrIplTrs2CzCwKKfRx2o1LBOGdSgAMkT4F1AG98ONq4ZT1Yq2IwjvkywGbxsWPqx8k1IZbsOama0BjelzVdR1muedosJX+w/YPGu0g3aAi5GFRnvXKwuIoHIRQMKWepfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Kps/geFK0JfHGCl8YDiLQhs/amfPSYTHKhwvkVLG6Q=;
 b=w1FvmBTV3xAoZCEuBTsHaEzrFZvdN9UsKmXj9nkcbkkS546r7jdIHUExBlQTyXdHFp1IktaeL6FH8rkE2ZidDzAf0WlVT/1bbNpxcZTETeP+KeQLLeTopG819ECsCsf5HviHOgyu01yIW8y6bhsNOgisNJqym+M2+DpEb3juB9E=
Received: from PH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::8)
 by SAWPR12MB999268.namprd12.prod.outlook.com (2603:10b6:806:55d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 16:02:18 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:510:34a:cafe::65) by PH5P220CA0001.outlook.office365.com
 (2603:10b6:510:34a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 16:02:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:02:17 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 10:02:17 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCHv3 6/8] drm/amdgpu: Enable UALink loopback mode
Date: Mon, 2 Nov 2026 10:47:52 -0500
Message-ID: <20261102160125.2743750-7-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102160125.2743750-1-mukul.joshi@amd.com>
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SAWPR12MB999268:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1c5a07-c5bb-4a60-6746-08df38faab65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|261028144727099003|261102130727099003|261026140227099003|11063799006|5023799004|56012099006|10067099003|22082099003|18092099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: gKFmf2SfEm2KHS4kvoaWhsiDWZVw96xZcmBQ4AWQSLtLKbe69NfrMwq2H9HeZRslt6BwSxWNgn9Bqj3S9ZkbD94djnSZ7Cj/lUVp3hTi77vY7naJ1xWeTifey515A4aXtbhAcrUYX8jm5WCrfZtdfxG588/CfselZOE6TriZ/+QkA3ywI2TZS+Qb3jOMEq+F86B0mMT4mvkZiHqPdJs1N8KXoXGyrXSt8OnT5tktzbhhstiEoYnoZGE506tbSJiCgqrXU9opDJ6H1pmqsdIFTU+305xs9H5sIexcB84S688qcADhdZbglDMOHja0X0r0Oh8pnqE/02/R6ry0Q+yabhFXBkd6r50n56ciIUBhPxQ+bfrhSw2oGAN0IkRR/19/j1GmLyZ7TM0Wz2gl8ZuQia9v7zWbtkZSosUDP18mHPH78t46R2KrG1tyTdDEDZd27F1phKLHau5d9DX7djKCpLQYe01pFaURkHA+voLLu4WNrpSaeytUT+/p8kiups8QsfR0kID0q8yTDW/3xR1b5ix9LTxruN1agUNVA2ixsmVbgrJcMAXzAcn3Gw8XA+6+UQX6zXjbD1XfU/FEYzzJPsQdmtXXV7s3C2loL7SM6EnXrMRWKStvD/mRZ2MhlUkIUytwQn9C/B5ES2zYzcMZOohRXQKM0jP/KchTX9cGzZk+XEknX68Si1FQ93zmWB2fv1poIk/ukp/ME7s557Wj5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261102130727099003)(261026140227099003)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18092099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YIGrsXd8S8/qPngzWKbdNOJzVqnF0m62M+QIeJiMjcBsLeosglzYCOdQdos6BQ9yAm8x41brJI1j1tu9+/aunQ+jbD44+qfUdfwtBfzsBFcz/M+FqQnGD7SjT2a5ajyqyzcA7Cdt8Kza5+OFJXP3/v0eYf3QBRgXi4k6tHcrDU8eXpgERi/kLlc17WbxtWP9BaJ1L6NRWVFdaXa+qgq6i7ng6BiIFckia3pvyVbvA24+fUK3ypoxu08vXYJvt0RLZLiX6wB1dzQYY0sgQaN6g/uyi2L2Gm6mgZhUOfzgZOxaz0b8sx0Pn3RC6VUMumtjFlVjSX5+7XiW6zydejHs1FZ33cnjgF30gi0pAevoKsKZNvdQqP8/R/3baByectxgAcUJl9bggW20AxshUWe+niyKGJmmYKdwPYeVle5R/iT2J7zmOHNzVk81Qt4/UFm+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:02:17.7109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1c5a07-c5bb-4a60-6746-08df38faab65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999268
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

In UALink loopback mode a single GPU acts as both the exporter (accel
ID 1) and the importer (accel ID 0). This lets the existing tests export
a BO and import it on the same device, traversing the UALink HW
pipeline.

Add amdgpu_ualink_loopback_detect(), the single place that decides
whether loopback is enabled. It runs from sw_init, before any per-peer
setup, so the loopback workqueue is allocated with the other one-time
allocations. When loopback is enabled:

- There is no user-space agent to configure the pod, so synthesize the
  pPod/vPod configuration with both accel IDs active instead of
  querying it from PSP. Loopback only supports the source-aliasing
  address mode.

- Activate the device directly instead of through the cross-GPU vpod
  activation path, which needs peer GPUs and a user-space vpod commit.

The mechanism that requests loopback mode is added separately, so
amdgpu_ualink_loopback_detect() leaves loopback disabled for now. The
normal activation path is unchanged when loopback is not enabled.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com> (v2)
---
v2->v3:
- Update all static info inside amdgpu_ualink_loopback_populate_info().
- Drop the amdgpu_ualink_loopback_requested() as amdgpu_ualink_loopback_detect()
  is enough to detect and set loopback mode.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 143 +++++++++++++++++++--
 1 file changed, 132 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 74bc8a907f5b..2e1e0a677e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -63,6 +63,7 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 static int amdgpu_ualink_loopback_self_interrupt(struct amdgpu_device *adev,
 						 u32 sender_accel_id, u32 dw0,
 						 u32 dw1, u32 dw2, u32 dw3);
+static void activate_accelerator(struct amdgpu_device *adev);
 
 #define STRIP_NPA(addr)						\
 	(((u64)(addr) & ~AMDGPU_UALINK_NPA_ADDR_GPUID_MASK))
@@ -93,13 +94,120 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
 }
 
 /*
- * amdgpu_ualink_loopback_sw_init - allocate UALink loopback resources
+ * amdgpu_ualink_loopback_detect - detect UALink loopback mode
  *
- * Allocates the ordered workqueue used to emulate exporter->importer
- * interrupts in SW. Does nothing unless loopback mode is enabled.
+ * This is the only place that decides whether loopback mode is enabled.
+ * There is no mechanism to request loopback mode yet, so it stays disabled.
+ */
+static void amdgpu_ualink_loopback_detect(struct amdgpu_device *adev)
+{
+	adev->ualink.loopback.enabled = false;
+}
+
+/*
+ * amdgpu_ualink_loopback_populate_info - synthesize pPod/vPod config for loopback
+ *
+ * In loopback there is no user-space agent (AIFM / xncmdclient) writing the
+ * UALink sysfs nodes to configure the pod, so populate adev->ualink.info
+ * directly. The layout is fixed and known: a single GPU alone in its own
+ * physical pod, presented as accelerator ID 1 (the exporter) and also owning
+ * accelerator ID 0 (the importer). The values are made self-consistent so
+ * check_vpod_info() would pass and amdgpu_ualink_metadata_init() programs the
+ * importer's ring buffers / GART NPA mappings / MP nHT receive metadata.
+ *
+ * This must run before any per-peer setup, since it sets the accelerator IDs
+ * returned by ualink_exp_accel_id() and ualink_imp_accel_id().
+ */
+static void amdgpu_ualink_loopback_populate_info(struct amdgpu_device *adev)
+{
+	struct amdgpu_ualink_info *info = adev->ualink.info;
+	u32 exporter = AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID;
+	u32 importer = AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID;
+
+	adev->ualink.loopback.exporter_accel_id = exporter;
+	adev->ualink.loopback.importer_accel_id = importer;
+
+	/* Physical pod: this GPU is presented as the exporter accel ID in its
+	 * own pod. ppod.size must be large enough to contain both the exporter
+	 * and importer accel IDs. ppod.id must be unique within the system
+	 * (matters for 1P4G, where every loopback GPU is its own physical pod).
+	 */
+	info->ppod.accel_id = exporter;
+	info->ppod.size = max(exporter, importer) + 1;	/* == 2 */
+	uuid_gen(&info->ppod.id);
+
+	/* Virtual pod: mark BOTH the exporter and the importer active so the
+	 * per-peer setup (amdgpu_ualink_metadata_init()) programs the importer's
+	 * resources for the importer accel ID. Loopback only supports the
+	 * source-aliasing address mode.
+	 */
+	info->vpod.id = 0;
+	info->vpod.size = 2;
+	info->vpod.addr_mode = AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS;
+	bitmap_zero(info->vpod.active_accel_bits, AMDGPU_UALINK_ACCEL_MAX);
+	set_bit(exporter, info->vpod.active_accel_bits);
+	set_bit(importer, info->vpod.active_accel_bits);
+
+	/* Only the exporter (this GPU's own accel ID) is a local accelerator;
+	 * the importer is reached through the (loopback) remote/NPA path.
+	 */
+	info->n_local_accels = 1;
+	info->local_accels[0] = exporter;
+
+	/* Mark the pod vpod-configured so the activation path proceeds. */
+	info->accel_state = AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED;
+}
+
+/*
+ * amdgpu_ualink_loopback_activate - bring up the UALink manager for loopback
+ *
+ * The normal activation is driven by the sysfs vpod_config/commit path via
+ * activate_local_vpod(), which derives the local accelerators from peer GPUs
+ * and runs a cross-GPU integrity check. Neither applies in loopback (the
+ * importer is not a separate GPU), so activate this device directly.
+ */
+static int amdgpu_ualink_loopback_activate(struct amdgpu_device *adev)
+{
+	mutex_lock(&mgpu_info.mutex);
+	activate_accelerator(adev);
+	mutex_unlock(&mgpu_info.mutex);
+
+	if (adev->ualink.info->accel_state < AMDGPU_UALINK_ACCEL_STATE_ACTIVE) {
+		dev_err(adev->dev, "UALink loopback activation did not reach ACTIVE\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * amdgpu_ualink_loopback_init - set up and activate UALink loopback mode
+ *
+ * Called from late init once loopback mode has been detected. Synthesizes the
+ * pod configuration instead of querying it from PSP (there is no user-space
+ * agent to configure the pod in loopback) and activates the device.
+ */
+static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
+{
+	amdgpu_ualink_loopback_populate_info(adev);
+
+	dev_info(adev->dev,
+		 "UALink loopback enabled (exporter accel %u, importer accel %u)\n",
+		 adev->ualink.loopback.exporter_accel_id,
+		 adev->ualink.loopback.importer_accel_id);
+
+	return amdgpu_ualink_loopback_activate(adev);
+}
+
+/*
+ * amdgpu_ualink_loopback_sw_init - detect loopback and allocate its resources
+ *
+ * Detects loopback mode and, if it is enabled, allocates the ordered
+ * workqueue used to emulate exporter->importer interrupts in SW.
  */
 static int amdgpu_ualink_loopback_sw_init(struct amdgpu_device *adev)
 {
+	amdgpu_ualink_loopback_detect(adev);
 	if (!adev->ualink.loopback.enabled)
 		return 0;
 
@@ -499,15 +607,28 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 	if (adev->ualink.mgr_state != AMDGPU_UALINK_INIT_HW)
 		return 0;
 
-	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
-			       adev->ualink.info, &cfg_state);
-	if (r)
-		return r;
+	/* Loopback synthesizes its pod configuration instead of querying it
+	 * from PSP, and has no peer GPUs or user-space vpod commit, so it
+	 * cannot use the normal cross-GPU activation path either.
+	 */
+	if (!adev->ualink.loopback.enabled) {
+		r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver,
+				       adev->ualink.info, &cfg_state);
+		if (r)
+			return r;
 
-	scoped_guard(mutex, &mgpu_info.mutex) {
-		amdgpu_ualink_info_set_accel_state(adev, adev->ualink.info,
-						   cfg_state);
-		__amdgpu_ualink_activate_vpod_locked(adev);
+		scoped_guard(mutex, &mgpu_info.mutex) {
+			amdgpu_ualink_info_set_accel_state(adev,
+							   adev->ualink.info,
+							   cfg_state);
+			__amdgpu_ualink_activate_vpod_locked(adev);
+		}
+	} else {
+		r = amdgpu_ualink_loopback_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to set up UALink loopback: %d\n", r);
+			goto error;
+		}
 	}
 
 	r = amdgpu_ualink_drm_client_create(adev);
-- 
2.56.0

