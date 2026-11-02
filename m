Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E64606A598
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wR40OQpu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185A710E637;
	Mon,  2 Nov 2026 16:02:39 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1C310F03E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch2lSK18vZZkgjxTbZQJkghdEAizLOYEMauFIVkC5mJ8pd8haPoU2CcJBQzA7Vw2EsjivOO29AG6YIB9Fd0yIt+lWCx94PTo/HJCA6wwLn7eK9pRg33wV2jaHGErbBm6dJdTktnSMvxAlwtnXL4dAY3nJBHpqObGEtl/UVoXTwtNmqBRzQMLhbZpo8Tsqc136/Q/SysHdxCf0TO1RaPgg4o1fOtkIbxVb50yV4BXT6/o5Trt1yz8ax3wzZoQ+KbNnpE0iddNN6WYz0RSPi3hYDXT2wDapzFWTKMYVaJyMqwu63FfHKhCfVpUy7Cnw3s4DqiR3zPh+5x9U+3OfeBzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0lE2UYwPF8OYYsQbKaC0h9qD28g6ged5stgVLYlEhw=;
 b=TOBLkHAn55OH/4zOrIieDYtEK/z/fTTE3KbcGY9uuDuM3+W0hAnkVuwWTtNoNDWG9bmlD+dgoIpKT3MR7yE+KTjnEJLgEbnQ+ei7K8egBsJLdvYfKAsCypIKVHhNRZBntvOpeREGLzt9R9ydgIwG4rFJbG2DIp+zZVhao/2ae+bch0UuZCxwj7S708ZRi4WW6l780UBsQgi2RzplaAg+prCFLwtICaNrC0phbDJW8yQLTS9R5Tg4XsOBA4GqY11RMvhHWidYxGlwMFSi5zYDQe4jJZQihyMDv9Dz70duFOHIviBTStlgEMYkPmVL1A9pz8pnfXBl5ifBFTusPmBddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0lE2UYwPF8OYYsQbKaC0h9qD28g6ged5stgVLYlEhw=;
 b=wR40OQpuiShDYXPybk7EPs7Nb8Wr9mVoEp+/V5WY69OQ6qa2Xd2wVRbCLppQlEd9TIRBWaNUV3xBdoiFyyiivhZQed2L0MUGRtxj2hBwLsK/jQPAMzm1pv+Ts+dmp0IZFZf+N09/OTszv2IaPWDb5lUZS9I9QDw/QPnWoT2K15A=
Received: from PH7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::28)
 by SA5PPF3C36BFCB5.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Mon, 2 Nov 2026
 16:02:03 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::79) by PH7P222CA0015.outlook.office365.com
 (2603:10b6:510:33a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 16:02:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 16:02:02 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 2 Nov
 2026 10:02:01 -0600
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv3 1/8] drm/amdgpu: Add UALink loopback infrastructure
Date: Mon, 2 Nov 2026 10:47:47 -0500
Message-ID: <20261102160125.2743750-2-mukul.joshi@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SA5PPF3C36BFCB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 7791e408-07fe-463b-7c8d-08df38faa20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|22082099003|261102123227099003|18002099003|261102130727099003|3023799007|261022105027099003|5023799004|11063799006|261021121427099003|10067099003|261022075727099003|261021123027099003|261009223027099003|261026121527099003|261028144727099003|261026140227099003|56012099006;
X-Microsoft-Antispam-Message-Info: frXyMg111oE/YeTuvKayBHg8F3llFdL9BN9GxQqBfL7RGDYo3LhJNsFWyb5paZWpgavGg/kbMsEvqZqv3AtzhFEhZvf+GOKOSH+xcIhKvGnkfqAE2vepdEbVGWp3S5rPsXtT4+hntVwV6T1ri28UD7TyhHKfvt8145E3rY3Rz98PqBQwoAvcqpLdRM6Pdy6Vzq78iyervAH5camf+pSs8L3+Lg/aORmA90W+QIENdPa2szDferhT8ZgLb/8C4vZLVMmnCAN663JR5zpieLmjbLScIhPjE8rNIL2GzLzE3scq/ZM168RRRWOip9jdLgXZ9CT7hIN5RU6v2q4DXISa96Yf6CNzotibOt/tnvPbsquMWFNpcCFGUuyVqm0deEIIdqbmnWmp50VkBvtmUpZyKVUqHlXJL07GBZapTJEJ2GB7yua3sRIUYdJ0TkuZWDpVU2dZbBHS1MAMbK62T0dpDGfVtV67T4U9FqDuQoRTvjlOg4Ef1eDxvXP3djZn3mnywOtN3mcvL2G42rH1rB4ykNYNFbtXJI1XwRoYUWcXfPpOTxssrlBkc0eNEyFpM90zF3XvwtcWTBmtmrJz/OKkjBPfToClzMahBXZBUnwNOJN86MgMSOkqJBhKXeW5yJYLkvh6fq3jDMfp7rZqUAPIAM5gjjJeXaIjKVFqQ5LDgYB9W5HLhCQx/Lv4gZpLbPCEhTWp7P1z2YwOmIsntKBKCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(22082099003)(261102123227099003)(18002099003)(261102130727099003)(3023799007)(261022105027099003)(5023799004)(11063799006)(261021121427099003)(10067099003)(261022075727099003)(261021123027099003)(261009223027099003)(261026121527099003)(261028144727099003)(261026140227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DFkJit3979dYM3ufY9I+iL82/DlAYjK79Jl7tpFjhYJzorNWkDwEU/0hIvUqYzRwb1SaRU1v3s20evw3KhFCeVEPopYwwanaaL1oubbPMoyEfkaS8RrVFooOFl/8aInUCtKehVxgC+L9vdSDw2g99J3K3zTrCV+0KNlbLRD75F1atx9Us/Y75Ge0SAaVwpN64evcwRx0kPX1CfEIgvOqhMDWR0FJSOSNu72DfoisPbr6gOUDSI214SFXeiv5+VhqR5TsoF3+d/O+XXxqzX6RnZaHQacLTYyMTtIMScbvtb0e8x9LHRusdfsVyPxM2SPrk30Y2nk72bfYLHbkXEogMHXrDZyIYqyP2loV2632gaaIt/wm4gYTl8kmicHzgbFReuUip5Z5M9LtQ0WxE6elvNWwSadYa2raPga1KLZHgiGMwPb9EQtJ+zUuV9mRHF2O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 16:02:02.0433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7791e408-07fe-463b-7c8d-08df38faa20e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5
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

Add the infrastructure for UALink loopback mode, where a single GPU
plays both the exporter and the importer role under two fixed
accelerator IDs:

- Add struct amdgpu_ualink_loopback to track the loopback state, along
  with the fixed exporter and importer accel IDs.

- Replace ualink_accel_id() with ualink_exp_accel_id() and
  ualink_imp_accel_id(), which return the exporter and importer accel
  ID in loopback mode.

- Add amdgpu_ualink_loopback_sw_init(), which allocates the ordered
  workqueue used to emulate exporter->importer messages from
  ualink_ip_sw_init(), and amdgpu_ualink_loopback_fini(), which
  destroys it from ualink_ip_sw_fini().

Loopback is not enabled yet, and outside loopback both helpers return
ppod.accel_id, so there is no functional change.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Drop the change in find_peer_adev() as its not needed.

v2->v3:
- Update src_accel_id to the correct value in amdgpu_ualink_peer_remote_init()
  and amdgpu_ualink_peer_remote_fini().
- Add the loopback teardown in amdgpu_ualink_loopback_fini() and call it
  through ualink_ip_sw_fini().

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 128 +++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  29 +++++
 2 files changed, 133 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ca6432610f71..a98d5bbf0622 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -89,6 +89,41 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
 	return 0;
 }
 
+/*
+ * amdgpu_ualink_loopback_sw_init - allocate UALink loopback resources
+ *
+ * Allocates the ordered workqueue used to emulate exporter->importer
+ * interrupts in SW. Does nothing unless loopback mode is enabled.
+ */
+static int amdgpu_ualink_loopback_sw_init(struct amdgpu_device *adev)
+{
+	if (!adev->ualink.loopback.enabled)
+		return 0;
+
+	adev->ualink.loopback.wq =
+		alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
+	if (!adev->ualink.loopback.wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * amdgpu_ualink_loopback_fini - tear down UALink loopback mode
+ *
+ * Destroys the workqueue allocated in amdgpu_ualink_loopback_sw_init().
+ * destroy_workqueue() drains any pending self-interrupt work first.
+ */
+static void amdgpu_ualink_loopback_fini(struct amdgpu_device *adev)
+{
+	if (!adev->ualink.loopback.wq)
+		return;
+
+	destroy_workqueue(adev->ualink.loopback.wq);
+	adev->ualink.loopback.wq = NULL;
+	adev->ualink.loopback.enabled = false;
+}
+
 static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
 {
 	if (!adev->ualink.info)
@@ -1028,6 +1063,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
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
@@ -1533,19 +1593,21 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ualink_ppod_setup *ppod_setup;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_ualink_info *info;
+	int r;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	ppod_setup = kzalloc(sizeof(*ppod_setup), GFP_KERNEL);
 	vpod_config = kzalloc(sizeof(*vpod_config), GFP_KERNEL);
 	stations = kzalloc(sizeof(*stations), GFP_KERNEL);
 	if (!info || !ppod_setup || !vpod_config || !stations) {
-		kfree(info);
-		kfree(ppod_setup);
-		kfree(vpod_config);
-		kfree(stations);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto err_free;
 	}
 
+	r = amdgpu_ualink_loopback_sw_init(adev);
+	if (r)
+		goto err_free;
+
 	info->ppod.accel_id = 0xffffffff;
 	info->ppod.bandwidth = 0xffffffff;
 	info->ppod.latency = 0xffffffff;
@@ -1568,10 +1630,18 @@ int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->ualink.stations = stations;
 
 	return 0;
+
+err_free:
+	kfree(info);
+	kfree(ppod_setup);
+	kfree(vpod_config);
+	kfree(stations);
+	return r;
 }
 
 int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
 {
+	amdgpu_ualink_loopback_fini(ip_block->adev);
 	amdgpu_ualink_object_fini(ip_block->adev);
 	return 0;
 }
@@ -4487,11 +4557,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
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
@@ -4837,7 +4902,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	u64 timeout = msecs_to_jiffies(2000);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
 	struct dma_fence *fence;
@@ -4956,7 +5021,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	u64 timeout = msecs_to_jiffies(2000);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
@@ -5241,7 +5306,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 
-	dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
+	dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
 	amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
 				      &remote->rptr_cpu_addr);
 	amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
@@ -5288,7 +5353,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	}
 
 	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
-		ualink_accel_id(adev), ualink_addr_mode(adev), status);
+		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
 
 	/* Alloc metadata structure for all GPUs */
 	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
@@ -5361,12 +5426,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
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
@@ -5392,7 +5457,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 						     ualink_tlb_wptr_offset(adev, accel_id);
 
 		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
-			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
+			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
 		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
 			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
 		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
@@ -5806,7 +5871,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
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
 	uintptr_t wb;
 	u64 npa;
@@ -5981,19 +6053,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
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
@@ -6164,7 +6236,12 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *interrupt;
 	struct amdgpu_ualink_ring *shootdown;
-	u32 src_accel_id = ualink_accel_id(adev);
+	/* This sets up the send rings (local sender -> each remote dst). In
+	 * loopback the HW-served direction is importer -> exporter, so the
+	 * local sender is the importer; the skip below then skips the importer
+	 * and sets up the peer[exporter] ring that the HW path needs.
+	 */
+	u32 src_accel_id = ualink_imp_accel_id(adev);
 	u32 dst_accel_id;
 	u64 npa, flags;
 	int r = 0;
@@ -6287,7 +6364,10 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
 {
 	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 src_accel_id = ualink_accel_id(adev);
+	/* Mirror peer_remote_init: in loopback the local sender is the
+	 * importer, so unmap the peer[exporter] send ring that was set up.
+	 */
+	u32 src_accel_id = ualink_imp_accel_id(adev);
 	u32 dst_accel_id;
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
@@ -6374,7 +6454,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
  */
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 {
-	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
+	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_exp_accel_id(adev),
 		ualink_addr_mode(adev));
 
 	adev->ualink.msg_ctl->send_halt(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 85c9a9634a4b..0b1e8dd38666 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
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
@@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
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
@@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
 	/* For remote interrupt and shootdown */
 	struct amdgpu_ualink_remote *remote;
 
+	/* UALink loopback mode state (see struct amdgpu_ualink_loopback) */
+	struct amdgpu_ualink_loopback loopback;
+
 	/* handle irq from ualink client of remote GPUs */
 	struct amdgpu_irq_src irq;
 
-- 
2.56.0

