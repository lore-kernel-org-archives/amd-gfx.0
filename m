Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7322C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 23:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A65F10F378;
	Wed,  2 Sep 2026 23:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i00EpQPC";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5568A10F378
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 23:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMhsXFlo3m5LiYJed0HYuESwFVDoTdhp2X9r8fiWi++W7117mQsVw2csJdMwCvhXS2SyuvHFSJMAp0llKUkz+oebR/hgpkmyB8I96jL1EKHPo5KTzDm3Fd1Nodg+CJh9fNpVg4iIYMeicPhJ++Yh6TWBe1I0uLDYfg5ye34UWdx0a/NGVUhb4o/6GHHLoNAd3fkyFPEsbx8MFiBXXH1A9Q4UyeCB8NbniMn8LLHu+vq5+PZ3JYCtvJN3Is+kctyd36FNvdWbcvQlPL7C437eYQnhFIkUzCnjK84Cr0W8XXvg0ubA9spXvY6dndDmdlTODDHmP0q7vcIizf9exyVozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bvZIowLa4ELFaqe2Z+V0R6F+b3MzkE8QZnKJa7XDMU=;
 b=S3GXqHWuOdmWPDmX0gLIC2O/rtAV/rRI2Un/rdjF2VDHFYnI8Uk49NrBySVGXPbSCnQrqkvVz606HbUotT6/BDbACxSFGNQ4BeI/HIH4HUygQizBt9e9rttUS8c/gxFV/S+bw/XMEUilgCFVAh8YDbrrNMJi0dK72b1CIlMLjJaoqj7/QlexU6ZjAgs16rPxH0GMUfLYANDsXLfR4evQbmcGiLW2tawEejMItWWbB/AO71MrtSdjcoVHo0xpar7HYqrn8vhwy0U610RUveeVOne3XbWHolD0obq4vPI9yONgc3PH3RntsFWFxJhupQTF/DjFOGFM0Wb9cfFrdloJtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bvZIowLa4ELFaqe2Z+V0R6F+b3MzkE8QZnKJa7XDMU=;
 b=i00EpQPCM+cIXMYqNV7KbUF5+zBvi0sABkYYGtO5gYr6eMgXr7hwJkc8Ni250zu75FWgekbgpexTHagveU2bz0KQMd3cZAvif4VZZKGsR0eynYakeVnxFAo+UzU2xhIJoIXaC0dm+PZZdnh2Vtr/nOSwZXkKKdZqrgSg7nC9Wz4=
Received: from CH0PR03CA0422.namprd03.prod.outlook.com (2603:10b6:610:10e::19)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Wed, 2 Sep
 2026 23:08:27 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::7) by CH0PR03CA0422.outlook.office365.com
 (2603:10b6:610:10e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 23:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 23:08:27 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 18:08:25 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: fix NULL deref in SDMA HQD debugfs dump on GC
 12.1
Date: Wed, 2 Sep 2026 19:07:45 -0400
Message-ID: <20260902230745.3093556-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902230745.3093556-1-Harish.Kasiviswanathan@amd.com>
References: <20260902230745.3093556-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa3972e-0da8-4fb6-54dc-08df094718af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: K/CQNX+Txl0FhPF/VKtvTM1a2t+EKFfTHrhI+IEIUdYN4QipCLJNnJo+r3xie6cu3sb87u4gfBNmEK1bravNo/RT3/ArVAH02wvKns+DILNh/z27m4Q6UtCUWqJKh5X0TBaMC5dceVXoDgKeIuNy78YX5q/d4y91KXQ2mvmtzkc2GhL9xWLNKh5hB9d/S48h00oOlMh6/x/SG9aPFDZC0+5Mra3hZE7miknOuXOxLIaeSkgcuRtZS9EjKOkJfsFvt+Q9H2LadvWdNjElonkr+FjWLFlNvoLOxxa4lNsdqbOyRHmZIwyYUGD+zfIMJNvlCTFVF+IjgGbTMCl7Bt1jQ2RA+599n7wAJ4+5fohh5JUsZJeUy+uranR7caw6rjUhGvrAQx4KPVZz5ZIH2dYPqtr+cfLDSjQND7XKtthTbz2/Ev/qgALNoHHtXjLeEJW/b5GI3H8GEhCWf439Ixpem3Rka5Fdp8GLzHbe87Wmct+GXezAG2PArTiRSty9OTEOLMYSqgUJ4lkCGwk92a1qJu8kLclASd8nbG402lFIIcevZCwSvyUH4x6xViflw7RvY8blfY8qC2R0XQgZ2sosyK42hDSdT+Qwsn4Rf8yOtJZktfhtwQLYXzYXiM5VyxGcJszvXsPn8SuUPQZiFVVZ+Pns+y2nhm7HcvNn1/i0kZ8/RaC1PZXJd+ezPzQkJR/4gAIp47DSgUgj85CLLXRYOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6rNJyrz+cgmCc3BjfqJ307vmvZPtR+ysYmDC7Ipfqg28Bbrz3I5hNjk5CzYTcgSGynoLuUFYCJNbI+EUFKnCrff758sxoC8K6PUjlqoFtxTZkrmGYcvPs+kB7iERsLoHIx5r4OgDf48STvGKSjtEUW0jYir/BpuwzANvcvPK5yIujqI06xWgQYYsN4mJa4mgOFvmqRNtbHdK4hrH+uAzjE3+AbZgeJxf9bCD6fv7SkAEXnoo9DzXNB8W9pex0xcwSjU0NdJUCJ4r9v5u4wSv85nAPY+pFF6JjViYYZypl1q1i77RoLJzEY/m4MiCIONKrawCnSmbK+55nuMHjhdVmkVzqhydkvYNPohuqZHMkLdGUzYDAm4xyLqwXYU8eLjqtMtT9ML17+n29oDpcldbUYjZ9nmphzLyxKuPyAPaAzOXEADrmYD+88soJF8tvRDx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 23:08:27.0809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa3972e-0da8-4fb6-54dc-08df094718af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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

Reading the KFD HQD debugfs node (dqm_debugfs_hqds) on a gc_12_1_0 part
oopses with a NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: hqd_sdma_dump_v12_1+0x6a [amdgpu]
  Call Trace:
   dqm_debugfs_hqds+0x2da/0x360 [amdgpu]
   kfd_debugfs_hqds_by_device+0x74/0xa0 [amdgpu]
   seq_read ... __x64_sys_read

get_sdma_rlc_reg_offset() assumes an interleaved layout where the second
SDMA per XCC lives in a separate SDMA1_HWIP register aperture. On
gc_12_1_0 that aperture does not exist.

Rewrite get_sdma_rlc_reg_offset() to mirror sdma_v7_1_get_reg_offset():
base the offset on adev->reg_offset[GC_HWIP][xcc_id][0] and add the
per-instance SDMA1 offset for the odd instance.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c  | 44 +++++++++++--------
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 ++++
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
index bda9578c4035..ec095003667f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12_1.c
@@ -77,25 +77,21 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				unsigned int engine_id,
 				unsigned int queue_id)
 {
-	uint32_t sdma_engine_reg_base = 0;
-	uint32_t sdma_rlc_reg_offset;
 	uint32_t dev_inst = GET_INST(SDMA0, engine_id);
+	int xcc_id = adev->sdma.instance[engine_id].xcc_id;
+	int xcc_inst = dev_inst % adev->sdma.num_inst_per_xcc;
+	uint32_t sdma_engine_reg_base;
+	uint32_t sdma_rlc_reg_offset;
 
-	switch (dev_inst % adev->sdma.num_inst_per_xcc) {
-	case 0:
-		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0,
-				dev_inst / adev->sdma.num_inst_per_xcc,
-				regSDMA0_SDMA_QUEUE0_RB_CNTL) - regSDMA0_SDMA_QUEUE0_RB_CNTL;
-		break;
-	case 1:
-		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1,
-				dev_inst / adev->sdma.num_inst_per_xcc,
-				regSDMA1_SDMA_QUEUE0_RB_CNTL) - regSDMA0_SDMA_QUEUE0_RB_CNTL;
-		break;
-	default:
-		WARN(1, "Invalid SDMA engine id %d\n", engine_id);
-		break;
-	}
+	/*
+	 * On SDMA v7 (gc_12_x) all SDMA queue registers live in the GC_HWIP
+	 * aperture. The second SDMA per XCC is reached by adding a fixed
+	 * offset (regSDMA1_* - regSDMA0_* == SDMA1_REG_OFFSET
+	 */
+	sdma_engine_reg_base = adev->reg_offset[GC_HWIP][xcc_id][0];
+	if (xcc_inst != 0)
+		sdma_engine_reg_base +=
+			regSDMA1_SDMA_QUEUE0_RB_CNTL - regSDMA0_SDMA_QUEUE0_RB_CNTL;
 
 	sdma_rlc_reg_offset = sdma_engine_reg_base
 		+ queue_id * (regSDMA0_SDMA_QUEUE1_RB_CNTL - regSDMA0_SDMA_QUEUE0_RB_CNTL);
@@ -141,8 +137,7 @@ static int hqd_sdma_dump_v12_1(struct amdgpu_device *adev,
 			     uint32_t engine_id, uint32_t queue_id,
 			     uint32_t (**dump)[2], uint32_t *n_regs)
 {
-	uint32_t sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
-			engine_id, queue_id);
+	uint32_t sdma_rlc_reg_offset;
 	uint32_t i = 0, reg;
 
 	const uint32_t first_reg = regSDMA0_SDMA_QUEUE0_RB_CNTL;
@@ -150,6 +145,17 @@ static int hqd_sdma_dump_v12_1(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (last_reg - first_reg + 1)
 
+	/*
+	 * dqm_debugfs_hqds() iterates engine_id over
+	 * node_id * get_num_all_sdma_engines()..+get_num_all_sdma_engines().
+	 * On partitioned devices that range can address a logical SDMA engine
+	 * beyond the instances that actually exist on this node; reject it
+	 */
+	if (engine_id >= adev->sdma.num_instances)
+		return -EINVAL;
+
+	sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev, engine_id, queue_id);
+
 	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 3ec6a73af22e..2ec337334dc5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -4107,6 +4107,15 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 		     queue++) {
 			r = dqm->dev->kfd2kgd->hqd_sdma_dump(
 				dqm->dev->adev, pipe, queue, &dump, &n_regs);
+			if (r == -EINVAL) {
+				/*
+				 * SDMA engine not present/mapped on this
+				 * device; skip it instead of aborting the
+				 * whole dump.
+				 */
+				r = 0;
+				break;
+			}
 			if (r)
 				break;
 
-- 
2.43.0

