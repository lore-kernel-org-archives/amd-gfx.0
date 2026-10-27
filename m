Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF43606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vavppMHW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D662C10E02B;
	Tue, 27 Oct 2026 19:59:46 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011012.outbound.protection.outlook.com [40.107.208.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB9B10E02B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 19:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwsZXGag0/tO+a94LjKm8jKdw+CjDM63uA55oH94CcniG+BZhNpibIjgJ+nxNA8XQFjU/t+hOEWFHKfMXU3pKAg7Jm5FdNJB81KexHbQrtSgohpXs7pFbZ4/O09FX/LDjayFNW9Ci+izQ5xe1Hv4yVbgklJ7PlDHwNgzNJ6oSkzv+ap1ZKC/HgROwOh+rnjfzcDtAyCvnbnlrBVvBd/qAfo8NbAO42v7RombttyUTuzn/0/Hz7GRhdBnj9eSXGSS1U0eYQ1WIncWMd5j2p/mzWo4znTq3PTzrmKb1p6poR6QiSPrQPu2KF5BlcUFKPkIw7BAessOe9z4kmcZfBq/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KaArUG2n9XQqX0aPeeYGdAmCABffEsAEOCZN3ulV8Y=;
 b=grHJ2MxPtHY1QtLX/VoK8sB5P917SbF71xjdm7TwWoeuZWNP8azCX5ggWLyEL4SIuvdoLAc6UaTpNltpvaNp5D7hPXrh/+K/8MVEHExqPQvfm2ACtgBeXBAFtJK+wPxUaaVLCcn97Ot2sLoZPlW5A5XvmvM+ShTgL1aXmPqUVClsiKsDPUFx+O/mAPz2Pq05RIpUM2k4rhNy1MJLg9FiX3Dx1Dxdg/QpRijRapzTaa/G4SfW8KXH4yXspgjOklOMTibdIqPX5IWquUnqD4ykDtwNNusSuUnIePeAp+dop0FOjo0mvHyhQ2sjOomQXpr9vfjy0HheRrH2OAm97ApxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KaArUG2n9XQqX0aPeeYGdAmCABffEsAEOCZN3ulV8Y=;
 b=vavppMHWTX0Q56qvKFVIYvbfbWu2V9LCi1/bPXux7vk/9RwYo890k6RyZDLqYeAEVhd08uGSTlRp9Iay4/IMrKC2aNrg19px6+iHUhNrFeKJ42ZvBiTSJHwAFniXNOmKhM24jS7DbeQi5lLapbx9R3/usicmoFgVfc9xnezg02g=
Received: from SJ0PR05CA0083.namprd05.prod.outlook.com (2603:10b6:a03:332::28)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 19:59:31 +0000
Received: from PH5PEPF0000002E.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::2d) by SJ0PR05CA0083.outlook.office365.com
 (2603:10b6:a03:332::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Tue, 27
 Oct 2026 19:59:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002E.mail.protection.outlook.com (10.167.243.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 19:59:30 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 14:59:29 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 1/8] drm/amdgpu: Add UALink loopback infrastructure
Date: Tue, 27 Oct 2026 15:54:14 -0400
Message-ID: <20261027195913.1794477-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027195913.1794477-1-mukul.joshi@amd.com>
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002E:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: e82af914-cef3-4633-e7de-08df3464d071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|261022105027099003|6133799003|18002099003|261026121527099003|22082099003|3023799007|261021123027099003|56012099006|11063799006|10067099003|261021121427099003|261009223027099003|261022075727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: +3vqOEtKHTfHRHoDdzA4/bB/NXGSdSWeBC/026P7zdn8bizwrKNlNb5el1u8vyty+pagk5/7Aa4COWCRYHFbg/y6QR9mtu2gDJk2PG/iaWM+y0Qq7JwIrOV6ATF8x5qFPvRsSRw4PX2RBOntqdtrwb7+vxZOPrQLhYSQdPv2UoKHWKff5uEAvtw0/soKH82rFhVfjfcgFFHy+FJoW+rhIE916p/MInd2LoTaY363Hj7dHOvzK/LDIZQoiClFW/R/4LcE40mHU62guxTMgu2HbHfvriXAnUzGC7Fn70G/ujAvI7CxYj2lVe15+5chaaIh0pACYRuCXhwrgfpO4uW1GL2XWLtfwdUfG4T6ev9URrAHY+edo8XcZIsHpqVibFY968xD6Tefo819GfiWwZmSl1z3tZii0OuliEkLr+ZG7JwHV4IL+/b3lVWO9t/viZExLY0cN7ybsWF7DF2ipg9g5ENgij4cn154THM1CWrvj4C84laoQk2IG0ISsXcXX6A6u9qOhZMReo8ak7ve/7YSdQ/d3SaYrrJW4vaMYCa+IQibK05lxjj7y8tO0O+np0kNg1fw7ML0o3jju+30V/XSeV6p5W4OWzm/9X6QX9gQHX5YWVgrp5sdAUiFPCGsh+gSPGWVuAZwXmSzId03DdPCfdpHn9+dcaI9/ehmh5YSJGP/j0+bq3GpgwY5LvOkyWBGPl1ezdXBcLBxyKp+WbHnNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(261022105027099003)(6133799003)(18002099003)(261026121527099003)(22082099003)(3023799007)(261021123027099003)(56012099006)(11063799006)(10067099003)(261021121427099003)(261009223027099003)(261022075727099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4SsHIEg+vKgPIQVUioEXFM2OOJ9lVbz3jx/4Au4+Nsp1kStCXfkj0MnmnDwQ3gkbLYCdCkT5Cf4/nZCJ0rj0DZc9qz6F0uZgHp/n90tKRo3TCUMDNu3tKNx+i0DgUAPSG9HpvwD8VDptgKb8jeDCIbwdp/drIZSOOq2dPHbdnyocP9ONNGW7/p0hTIuERmIf51ImMco4NvfEfrmHh4ImJaZPZKEe+KJBuRClyMkAnNiYqXPC4yllqlEFUGyo90kVVyOg3IQYU7HYd9yyJ6jeRxC5BGr6TrqKjXbPA+i0F7Jk1Rpr7tvt6oDnz5D5dkxG3OUjY53/H8Ax6C7h4R9lvGTRqOCIgRoQEKovyASh474y6Kf0wtayd91FTi2Fmsk8JqWJh946ElmgQzZMX4LGMtumW2cANjH4fTs9eqrnPwZgJxvUM4sN1tZdoY6tMbFR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 19:59:30.7278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e82af914-cef3-4633-e7de-08df3464d071
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
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

- Add amdgpu_ualink_loopback_init(), which allocates the ordered
  workqueue used to emulate exporter->importer messages, and destroy
  it in amdgpu_ualink_object_fini().

Loopback is not enabled yet, and outside loopback both helpers return
ppod.accel_id, so there is no functional change.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1-v2:
- Drop the change in find_peer_adev() as its not needed (Lijo).

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 99 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h | 29 +++++++
 2 files changed, 109 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ca6432610f71..2cd6dc71ab9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -89,8 +89,34 @@ static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
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
 
@@ -472,6 +498,14 @@ int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 		__amdgpu_ualink_activate_vpod_locked(adev);
 	}
 
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
@@ -1028,6 +1062,31 @@ static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
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
@@ -4487,11 +4546,6 @@ static bool amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
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
@@ -4837,7 +4891,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 	u64 timeout = msecs_to_jiffies(2000);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
 	struct dma_fence *fence;
@@ -4956,7 +5010,7 @@ static void amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
 static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 dst_accel_id = ualink_accel_id(adev);
+	u32 dst_accel_id = ualink_exp_accel_id(adev);
 	u64 timeout = msecs_to_jiffies(2000);
 	struct amdgpu_bo *bos[2];
 	u32 n_bos;
@@ -5241,7 +5295,7 @@ static void amdgpu_ualink_metadata_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
 
-	dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
+	dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
 	amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
 				      &remote->rptr_cpu_addr);
 	amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
@@ -5288,7 +5342,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	}
 
 	dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
-		ualink_accel_id(adev), ualink_addr_mode(adev), status);
+		ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
 
 	/* Alloc metadata structure for all GPUs */
 	metadata_size = sizeof(struct amdgpu_ualink_metadata) * AMDGPU_UALINK_ACCEL_MAX;
@@ -5361,12 +5415,12 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
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
@@ -5392,7 +5446,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 						     ualink_tlb_wptr_offset(adev, accel_id);
 
 		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
-			accel_id, ualink_accel_id(adev), metadata[accel_id].rb_size);
+			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
 		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
 			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
 		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
@@ -5806,7 +5860,14 @@ static void amdgpu_ualink_get_wb_addr(struct amdgpu_device *adev,
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
@@ -5981,19 +6042,19 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
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
@@ -6164,7 +6225,7 @@ static int amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *interrupt;
 	struct amdgpu_ualink_ring *shootdown;
-	u32 src_accel_id = ualink_accel_id(adev);
+	u32 src_accel_id = ualink_exp_accel_id(adev);
 	u32 dst_accel_id;
 	u64 npa, flags;
 	int r = 0;
@@ -6287,7 +6348,7 @@ static void amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
 {
 	u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
 	struct amdgpu_ualink_remote *remote = to_remote(adev);
-	u32 src_accel_id = ualink_accel_id(adev);
+	u32 src_accel_id = ualink_exp_accel_id(adev);
 	u32 dst_accel_id;
 	struct amdgpu_ualink_peer *peer;
 	struct amdgpu_ualink_ring *ring;
@@ -6374,7 +6435,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
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
2.55.0

