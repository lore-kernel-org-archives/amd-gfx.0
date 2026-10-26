Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23913606A321
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VuC4Vyoc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B856D10F1B4;
	Mon, 26 Oct 2026 23:03:23 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F8410F1B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:03:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsclbsjndPvC6VAbMweRjACKpofLc9c+37XVdAmBJx9yuBk+n5QyB9lnnB1ilGACJXRlpOq7qd/mctCyRjQucieEC3NUcQCrs0e/FJVY0ipqI2oXDOgpBfuDswQpguFJoLR2QZMhJsPXhhJEqSBdsrLT7Z5cyWg6Iwug24pvymul/P1Bd9JhIzwBZzT3Uo4OGZiUKdV9KBQ41i75LRCAV0R9AqRcrBQe+5vfIs5Ss2gN5oRUXabeTQzd+Knv2oxmhw8Gaxz8aX2W99fVWAcJnVIYoaGnzCBJ7UWH1Wz2UmxPky1UbInQdPyR0iRi/U/ooiz7CfNLJWRePhtMgaawZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJVb7Wn1fBfFcD2cP6Kt1prhoH4BnKnTXBdHMohh3AQ=;
 b=SzkhHiR0gPGYc5vM1a3T9KcVV2GjXHCGJu2GlA21xB8Khht9LMVHhyqt9xokQwWB6qG/aUgarc4Cw57MEkY5wVlAfFqpZv0aWGrmJzIhdIwf3c28/8Q4fnYtYdfqmQd6tez93PSHOuOq8qMl93WCNk/A/xAuMrRG0lGLH+2dzUGpx0IrSXoYPjX7304dM2+/vWoAGqcFruCbzivwstL8ny4AAs9TaMxtDg+LVo9pCqC2GC3SwLdydRfZPwVipMzs1AHFTtFmJfD+FgsSwgeMVgxkm0/bAQzGhrjoFSIvkDix2k9f66gZFb47cOBCRS2s1duWFrSDRbdt7F5/7Pgpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJVb7Wn1fBfFcD2cP6Kt1prhoH4BnKnTXBdHMohh3AQ=;
 b=VuC4VyocA+tHsOyJnkGnPw+bNEJ/zyLlOPma65uf0/6QgLDZWBbPExdpZhBK086n1lbuzIJe9gqQbCA25FeyYcNcx0dmbtBGfy1Y9FOROHvjSJp30ROI0g8ewko3lGZeIL4JJb0yiRbq2vCHLzQqnlrvrA0OaHdL5oxZMszpfc8=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 23:03:03 +0000
Received: from BN3PEPF00022BBD.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::d) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 23:03:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBD.mail.protection.outlook.com (10.167.248.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 23:03:02 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 18:03:02 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: Add UALink loopback infrastructure
Date: Mon, 26 Oct 2026 18:59:23 -0400
Message-ID: <20261026230248.1597606-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026230248.1597606-1-mukul.joshi@amd.com>
References: <20261026230248.1597606-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBD:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf504b9-80e3-482a-ca02-08df33b549ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|261026140227099003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261022105027099003|10067099003|22082099003|18002099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: V32ahwOaQoNLtYP7lRKCa1PVSFZAF485vfRxUaavr7bExNNmQyng1zYKoXztRtmCPFr4gOau92pIVoNMQDYh61Tj5bLSUQfmGtRGwdsLkR/oX4XQ+Ua6knUuh6Fy+5pJzZ5QgaxDNHZ7gy39LjKukzU7UWa58wCAurRXkS8fBMtVejqArWVQxWw43Itxo2I2ztUxdUjrvz8+jBHDwm/uy78U4mS8JgQKVnfGScyBIpTffZcM3TCb2/4D5+ws5K7uwBYm/J6104EuNbYWEF9HpCrQxZF2ICF2Iu1v63goVGlSxYXKTcu3L2LGHSIFYiMtQ2/s23DqeAjr21ZGEB6gnY2J0sZ4oa1TXnKn8y0esexaV0uFGHpCj0ALrAdW/oosp//0WE1WCEimhYUZFzU/V3KGt4xS4/9qYvWOdw1rzKFltGjOpvcg7JiPF4KfMqlCdMdb+j5FjHXHLtcn7mTeiUkW1TjBUSc1IzknLDCF0qhMscKJGZQDkhf73+QD7IsJcvJp33eJj78IUFsu4pn6YdQgZ6Uj2JoNAccQXXWYAqpdsrzeNesTRaYhgb7hjtECuo9TyOzxnzDW/6/NysIuRRXfzC4nJa2mn6aLvJ7pm4ThW/X/W1QThOQ3iP9M0dfbYG3MJKBDTKT3KTBs6yaPmP4iS8Y04q4IoA79HXbK89BhcISl46GGEXT0eF8mk+AiVlZbzT6Tr6ftSuqgs86IaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(261026140227099003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3N+ct+a2doSQH87BBnZNUnpdrmViY50ZJUvKKEnikrIfRzXcKP8b71F871i+BaVvvuJ/cBrmMMPMn8S9Jfov7Ioh4RdenxF79YViP3b9NbjvWAXyIZvgDbYDivVFKMSCqLsa+KHWcvO5JwJbtz5Yxqzrip70udMiMOiUvWK9bI2Dz6qE3cCsPqhWqpoKKVrNpbl6XaD0ZdwfU/s9uUnea9GpoqE9nCXJEfXmGS9zfXmH3R1DQvnC5bAmeZom+ItcaYjsaJRE9yNOTBZ7H4ZiukUEKqZrZInaU6kq6FVCJcvO4iGxryCgplfWyzFuSzerfjvzPLml2jHF7oErqU8DMBbLz7gkvbVUWdjmmbNPxM9zQ8eIXPUXvHFJBqj10tWsXnykM73JpnQFq2E+wVh9AGC9RkECG+OJMOVhebX6agJuA74OvGrS6i8B+j7j7yDl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 23:03:02.9594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf504b9-80e3-482a-ca02-08df33b549ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550
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

Add the infrastructure for UALink loopback mode, where a single GPU
plays both the exporter and the importer role under two fixed
accelerator IDs:

- Add struct amdgpu_ualink_loopback to track the loopback state, along
  with the fixed exporter and importer accel IDs.

- Replace ualink_accel_id() with ualink_exp_accel_id() and
  ualink_imp_accel_id(), which return the exporter and importer accel
  ID in loopback mode.

- Make find_peer_adev() resolve both loopback accel IDs to the calling
  device.

- Add amdgpu_ualink_loopback_init(), which allocates the ordered
  workqueue used to emulate exporter->importer messages, and destroy
  it in amdgpu_ualink_object_fini().

Loopback is not enabled yet, and outside loopback both helpers return
ppod.accel_id, so there is no functional change.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 117 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 +++++
 2 files changed, 124 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 2ae14e83f6b4..288c07274254 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -88,8 +88,34 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
 	return 0;
 }
 
+/*
+ * amdgpu_ualink_loopback_init - set up UALink loopback mode
+ *
+ * Called once loopback mode has been detected. Allocates the ordered
+ * workqueue used to emulate exporter->importer interrupts in SW.
+ */
+static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
+{
+	adev->ualink.loopback.wq =
+		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
+	if (!adev->ualink.loopback.wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
 {
+	/* Tear down the loopback self-interrupt workqueue allocated in
+	 * amdgpu_ualink_loopback_init(). destroy_workqueue() drains any
+	 * pending self-interrupt work first.
+	 */
+	if (adev->ualink.loopback.wq) {
+		destroy_workqueue(adev->ualink.loopback.wq);
+		adev->ualink.loopback.wq = NULL;
+		adev->ualink.loopback.enabled = false;
+	}
+
 	if (!adev->ualink.info)
 		return;
 
@@ -479,6 +505,14 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 	psp_ual_query_station_config(&adev->psp, adev->ualink.psp_if_ver,
 				     &adev->ualink.info->station);
 
+	if (adev->ualink.loopback.enabled) {
+		r = amdgpu_ualink_loopback_init(adev);
+		if (r) {
+			dev_err(adev->dev, "Failed to set up UALink loopback: %d\n", r);
+			goto error;
+		}
+	}
+
 	r = amdgpu_ualink_drm_client_create(adev);
 	if (r) {
 		dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
@@ -1044,10 +1078,22 @@ UALINK_IDBITS_STORE(vpod_config, vpod_active_accels, vpod.active_accel_bits,
 		    AMDGPU_UALINK_ACCEL_MAX);
 UALINK_ENUM_STORE(vpod_config, addr_mode, vpod.addr_mode);
 
-static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
+static struct amdgpu_device *find_peer_adev(struct amdgpu_device *adev,
+					    unsigned int accel_id)
 {
 	unsigned int i;
 
+	/* In loopback mode @adev is alone in its physical pod and owns both
+	 * the exporter and importer accelerator IDs. Resolve them to @adev
+	 * itself. This also keeps resolution scoped to the caller's pod for
+	 * 1P4G, where every loopback GPU reuses the same accel IDs (0/1) and
+	 * a global scan by ppod.accel_id would be ambiguous.
+	 */
+	if (adev->ualink.loopback.enabled &&
+	    (accel_id == adev->ualink.loopback.exporter_accel_id ||
+	     accel_id == adev->ualink.loopback.importer_accel_id))
+		return adev;
+
 	for (i = 0; i < mgpu_info.num_gpu; i++) {
 		struct amdgpu_device *peer_adev = mgpu_info.gpu_ins[i].adev;
 
@@ -1059,6 +1105,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
 	return NULL;
 }
 
+/*
+ * Physical accelerator roles.
+ *
+ * Outside loopback a GPU owns a single accelerator, so both helpers return its
+ * ppod.accel_id and the exporter/importer distinction collapses. In loopback
+ * the one physical GPU plays both roles: the exporter owns the MP nHT and
+ * receives all HW traffic, while the importer is the (virtual) HW sender for
+ * the importer -> exporter path.
+ */
+static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
+{
+	if (adev->ualink.loopback.enabled)
+		return adev->ualink.loopback.exporter_accel_id;
+
+	return adev->ualink.info->ppod.accel_id;
+}
+
+static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
+{
+	if (adev->ualink.loopback.enabled)
+		return adev->ualink.loopback.importer_accel_id;
+
+	return adev->ualink.info->ppod.accel_id;
+}
+
 static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
 					 u32 accel_id)
 {
@@ -1145,7 +1216,7 @@ static void activate_local_vpod(struct amdgpu_device *adev)
 	for (i = 0; i < info->n_local_accels; i++) {
 		accel_id = info->local_accels[i];
 
-		peer_adev = find_peer_adev(accel_id);
+		peer_adev = find_peer_adev(adev, accel_id);
 		if (WARN_ON(!peer_adev || !peer_adev->ualink.info))
 			/* info->local_accels is corrupted? */
 			continue;
@@ -3809,7 +3880,7 @@ static int amdgpu_ualink_local_import(struct amdgpu_device *adev,
 	int fd;
 
 	mutex_lock(&mgpu_info.mutex);
-	peer_adev = find_peer_adev(remote_acc_id);
+	peer_adev = find_peer_adev(adev, remote_acc_id);
 	mutex_unlock(&mgpu_info.mutex);
 	if (!peer_adev) {
 		dev_err(adev->dev,
@@ -4488,11 +4559,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
 			     AMDGPU_UALINK_ACCEL_MAX);
 }
 
-static inline u32 ualink_accel_id(struct amdgpu_device *adev)
-{
-	return adev->ualink.info->ppod.accel_id;
-}
-
 static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct amdgpu_device *adev)
 {
 	return adev->ualink.info->vpod.addr_mode;
@@ -4838,7 +4904,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	u64 timeout = msecs_to_jiffies(2000);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
 	struct dma_fence *fence;
@@ -4957,7 +5023,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	u64 timeout = msecs_to_jiffies(2000);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
@@ -5242,7 +5308,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 
-	dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
+	dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
 	amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
 				      &remote->rptr_cpu_addr);
 	amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
@@ -5289,7 +5355,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	}
 
 	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
-		ualink_accel_id(adev), ualink_addr_mode(adev), status);
+		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
 
 	/* Alloc metadata structure for all GPUs */
 	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
@@ -5362,12 +5428,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	}
 
 	if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
-		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_accel_id(adev);
+		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
 
 	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
 		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
 
-		if (accel_id == ualink_accel_id(adev))
+		if (accel_id == ualink_exp_accel_id(adev))
 			continue;
 
 		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
@@ -5393,7 +5459,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 						     ualink_tlb_wptr_offset(adev, accel_id);
 
 		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
-			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
+			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
 		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
 			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
 		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
@@ -5804,7 +5870,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
 				      u64 *wb_npa, u32 type)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 accel_id = ualink_accel_id(adev);
+	/* The GPUID encoded in the write-back NPA address is the routing target
+	 * the remote writes the rptr back to, i.e. THIS GPU. It must be the
+	 * physically-owned accel_id: outside loopback that is our own accel_id,
+	 * and in loopback it is the exporter (the only id the single GPU owns
+	 * and can receive on). The importer is only a logical source id for the
+	 * forward path and must never appear as an NPA GPUID.
+	 */
+	u32 accel_id = ualink_exp_accel_id(adev);
 	u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
 	u64 wb, npa;
 	u32 offset = 0;
@@ -5978,19 +6051,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 						   &peer->shootdown, &tlb_wptr);
 	if (r) {
 		dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed %d\n",
-			ualink_accel_id(adev), remote_accel_id, r);
+			ualink_exp_accel_id(adev), remote_accel_id, r);
 		return r;
 	}
 
 	if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr == tlb_wptr) {
 		dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same as remote %u\n",
-			ualink_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
+			ualink_exp_accel_id(adev), int_wptr, tlb_wptr, remote_accel_id);
 		return 0;
 	}
 
 	dev_dbg(adev->dev,
 		"accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr 0x%llx 0x%llx\n",
-		ualink_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
+		ualink_exp_accel_id(adev), peer->interrupt.wptr, peer->shootdown.wptr,
 		remote_accel_id, int_wptr, tlb_wptr);
 
 	amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
@@ -6161,7 +6234,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *interrupt;
 	struct amdgpu_ualink_ring *shootdown;
-	u32 src_accel_id = ualink_accel_id(adev);
+	u32 src_accel_id = ualink_exp_accel_id(adev);
 	u32 dst_accel_id;
 	u64 npa, flags;
 	int r = 0;
@@ -6284,7 +6357,7 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
 {
 	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 src_accel_id = ualink_accel_id(adev);
+	u32 src_accel_id = ualink_exp_accel_id(adev);
 	u32 dst_accel_id;
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
@@ -6371,7 +6444,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
  */
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 {
-	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
+	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_exp_accel_id(adev),
 		ualink_addr_mode(adev));
 
 	adev->ualink.msg_ctl->send_halt(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 3e4f2d18c83c..cbff60193383 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -93,6 +93,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
 #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN		0x1
 #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN		0x2
 
+/* UALink loopback support.
+ *
+ * In loopback mode a single GPU loops UALink requests back to itself for
+ * manufacturing testing. The GPU exposes two fixed accelerator IDs: it acts
+ * as the exporter on one and the importer on the other. Loopback is enabled
+ * with the amdgpu.ualink_loopback module parameter.
+ */
+/* Fixed accelerator IDs used by a loopback GPU. */
+#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID		1
+#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID		0
+
 enum amdgpu_ualink_conn_state {
 	AMDGPU_UALINK_CONN_NOT_READY			= 0,
 	AMDGPU_UALINK_CONN_IN_PROGRESS			= 1,
@@ -321,6 +332,21 @@ struct amdgpu_ualink_msg_ctl {
 	int (*send_halt)(struct amdgpu_device *adev);
 };
 
+/* UALink loopback mode state.
+ *
+ * When @enabled is true this single GPU acts as both exporter
+ * (@exporter_accel_id) and importer (@importer_accel_id). There is no second
+ * physical GPU, so exporter->importer messages cannot be delivered by the
+ * (single) MP nHT and are instead emulated in SW by feeding them back into
+ * our own IRQ handler via @wq.
+ */
+struct amdgpu_ualink_loopback {
+	bool enabled;
+	u32 exporter_accel_id;
+	u32 importer_accel_id;
+	struct workqueue_struct *wq;
+};
+
 struct amdgpu_ualink_mgr {
 	u64 npa_size;
 	u32 psp_if_ver;
@@ -335,6 +361,9 @@ struct amdgpu_ualink_mgr {
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
 
+	/* UALink loopback mode state (see struct amdgpu_ualink_loopback) */
+	struct amdgpu_ualink_loopback loopback;
+
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
-- 
2.55.0

