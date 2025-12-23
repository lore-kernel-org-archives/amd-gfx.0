Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B0AE6F07B
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 09:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F1110E06E;
	Tue, 23 Dec 2025 09:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wf862qza";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5566F10E06E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 09:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvyN5k6x92oVjdy7HNuo+XEx6veF9P39nVCZrFmOzGCaSFzWpgY8AaNs/oALEWs76Av+DNY++qqkDikQgFLDr21hxC8STApawJ0tLwuAPlmr9Fqs/s0FMt9Qb9CgKqQQD49YqJeNOmwtn/iM02yTdulpyJQNCdqKnFaEBNzpJFEMevOEC/75UQm0f147nD39f3cTDfkcM8tnR42smeam0LYat65ig7fnAadRZW/1HDgx0C4v/P+T0eXiWq9GIJ62I5skRFdGYepJJ5yWKQtmEWG/zU3E+6lOvn4rF8nOLjPavhlwmA97ImA2Oi+IvDRvGJc8fZUSo65BtKp/+h/Q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at7a1fPKDz7Ck/lm4b5VvhTMS50TbosGSqDT9cfP5xA=;
 b=fS5wK0vQ7zTt6JmikILPbwtXXmIBIF+P7yYd7AYcpGvDJwAETc0mQxAq1VVhNtJifAsTGMHOYQEhVDUtadvcEhhrd0ruo6rpYjtCue0NOPMBq8g7LnAI4yjzeUNWOd94YfcuTIvOf5SYWbmydfp4w+ouBD1bDzhebphZtnx88LYe500hROS3NoKpiiWWSsx3zGBNjnHVwG6ZL9jag57NtHN2vAAYWSOsWxBzLBfxuBZysLpbHtXLoxdmA6FZ0WqWTgHjH5AsHY4OmnZDfHKuOogtv72G64gdG2lhQVROl/M8Q3zjiK6RsAtyZY8iz+gl0UDwMQ6eqCJK2TOqpFA51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at7a1fPKDz7Ck/lm4b5VvhTMS50TbosGSqDT9cfP5xA=;
 b=wf862qzaU+75bXPcCjfJm0ereyvOF0mwxoLk5vn+nKsBof9kKA/2AS591eBOtVMr87LNY7KN7Qb8pm7oXIErc46vdmBzZ30riFW9hrBn8lbWw5JsF39SiDVicgTDpktEvK7wXCsg427i6d2suq9y8IUrGxVObM2Pgl6Hb+uzfJ0=
Received: from SJ0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:a03:39c::19)
 by PH7PR12MB6540.namprd12.prod.outlook.com (2603:10b6:510:213::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 09:51:16 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a9) by SJ0PR03CA0344.outlook.office365.com
 (2603:10b6:a03:39c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 09:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 09:51:15 +0000
Received: from yzha-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Dec 2025 03:51:11 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Hawking.Zhang@amd.com>, <Frank.Min@amd.com>
CC: <haijun.chang@amd.com>, <ZhenGuo.Yin@amd.com>, Yifan Zha
 <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Update MQD initialization to accept separate
 sizes for GFX and compute queues
Date: Tue, 23 Dec 2025 17:50:01 +0800
Message-ID: <20251223095000.2558799-3-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d778a0d-a192-4830-2445-08de4208d099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yTV6piRQkfDUw+iEeX/QzyHG/4ZqF/pfX7UMQ0f+gbPQxm8FBe4OX6/CdClH?=
 =?us-ascii?Q?t+ftxrH7XNfRiwKwKUuolWT9nNiKqBWoDPQ/DEOJNwDDzNHPnsfSdxTaqD4+?=
 =?us-ascii?Q?vWTIsSf03cADS0xXzx1f162D0OmC/ww1Oyu7eE6rLVLF3VchSK9Mwtquh0Ng?=
 =?us-ascii?Q?M+2MMsU8w/sBKUmN0DWAa7XVjZeXF6PYqZB49cOZJVBUVnxihl8gIFIVp7ms?=
 =?us-ascii?Q?Mv51w68kSUi1n2AMol7CsvoH3Lpr8H6uMB7H3JxQXuvLFEIt5l7eiWj6haCG?=
 =?us-ascii?Q?WOKnZZD1+YKxXjiHZN8i1Ze0zxUHxqfgQ58rjqgnmyfqK84jK3gqjHDAVQFz?=
 =?us-ascii?Q?EJnpTGilwyaG0ikB2ns9iDUtStNvFHEKae3lnxn9QToW4PqamATrS7zR2OyM?=
 =?us-ascii?Q?dvrISvwHF/2PjsjUHS+alRTH4w9jaSyxxNKOI4OslOwcWjCbOA+3sVq57lAc?=
 =?us-ascii?Q?fAUndH6wYe5G/M9aH/niVBCkCd9+UCm3JIFIxlvMdKT4tv+fe5btU3tjoXIi?=
 =?us-ascii?Q?WadIKz0jeDo7LLxNtImcv/xiad/AjQRMhPQibb/ex8afRxuRMO51GiES79bH?=
 =?us-ascii?Q?QRvDyfH1pmVCGWaRMjFrK/g6JnAaPhaeWGWN8cR8glq0x9M2jwJWnqBGojbR?=
 =?us-ascii?Q?lzZfHnLmyYVtTuhXIo7V0qU2MVTrXEvzn3oz0Fi1xMQ3vYj5xXh3bRIaVIgw?=
 =?us-ascii?Q?/QSuMzy1W1FrcK1DhGVrIelMg8mo3R/Kt8rm08pPGwrtYEAwx4gZDnh+5S1N?=
 =?us-ascii?Q?9y2BJvIXd7a1Qfs9p40dNAp8Zyb2cufnL2rEZHy/2w3FRaLwzQsvSDRceDYn?=
 =?us-ascii?Q?fiiJriHLFtcTZgAqp9/abSlBEFasV3TT+e3nKu4KpXNHXEMYHKt9NGqL+xRI?=
 =?us-ascii?Q?FpscOuQk+q6ChB9fGFaCqUIEQ1GxVPuHq2K8OKZFURU6CycTJPNAgpoB2V0z?=
 =?us-ascii?Q?pMkyiHLsLLc8YXzE70MKFk3jKfbrGLtlcGAhFB5BiAyt1WpPUWToG3T66TL1?=
 =?us-ascii?Q?W5JRHEmmYNRLPIyQn4EvaCz2lxmZ53LqMoHpX39AFpqXe3lR93eU79BheuI+?=
 =?us-ascii?Q?Cq0iGcW8j2Z9XvhUfvaVGgh6we5Ym/1eGmpPnbdN01AyhcSBreLza6OMRpht?=
 =?us-ascii?Q?sIYd4YhKLNxnL5Lk7xwm8DFXoGB9kdUcUNfq6CtCTOpN30iKN4bio47EBUkU?=
 =?us-ascii?Q?FwKomdaLehpjJ1HOsqUKh8IgN19wlgUzPixrRbp28H2ht8P+Wz2vQNahU6KA?=
 =?us-ascii?Q?DazEvvKVw5KsoZuFOuEx167h4uFepkMHVfURxferFxS4jExKs6KOsOGUeOHu?=
 =?us-ascii?Q?4fKMj9h/ZyU3M4u/FnMxOQNdHXvGxjkHFJgszdIhJskqLpwO9Rq88co2vzsd?=
 =?us-ascii?Q?b6SaIwQ9zCz9Wc5++JgG69kvCOBroaQiBoDSPZd0hkq08c/Po+Ue0Pc8eRgu?=
 =?us-ascii?Q?pUBcFsve/GetqY2UuhKne1oO8241c6BEZAh3g6HON5Ft0DlNdGQdl+osvwLV?=
 =?us-ascii?Q?XmovZIsg0W3ugxSYG9ci+b2jbLeJFG/9vIt9hn/e0Lq8efbkTU36mGh0xOOa?=
 =?us-ascii?Q?UzOG4UkiYYwvbh43Kzo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 09:51:15.8971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d778a0d-a192-4830-2445-08de4208d099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6540
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

[Why]
Enable separate sizes for GFX and compute MQD,
preventing memory corruption issues when different rings share contiguous memory.

[How]
Update MQD initialization to accept separate sizes for GFX and compute queues.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 25 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c |  4 +++-
 9 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6abe5103a78d..14bd75dfd8c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -379,13 +379,18 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 
 /* create MQD for each compute/gfx queue */
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
-			   unsigned int mqd_size, int xcc_id)
+			   unsigned int gfx_mqd_size,
+			   unsigned int compute_mqd_size,
+			   int xcc_id)
 {
 	int r, i, j;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
 
+	if (!gfx_mqd_size || !compute_mqd_size)
+		return -EINVAL;
+
 #if !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
 	/* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(10, 0, 0))
@@ -399,7 +404,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		 * deallocated and gart_unbind, to strict diverage we decide to use VRAM domain for
 		 * KIQ MQD no matter SRIOV or Bare-metal
 		 */
-		r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+		r = amdgpu_bo_create_kernel(adev, compute_mqd_size, PAGE_SIZE,
 					    AMDGPU_GEM_DOMAIN_VRAM |
 					    AMDGPU_GEM_DOMAIN_GTT,
 					    &ring->mqd_obj,
@@ -411,12 +416,14 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		}
 
 		/* prepare MQD backup */
-		kiq->mqd_backup = kzalloc(mqd_size, GFP_KERNEL);
+		kiq->mqd_backup = kzalloc(compute_mqd_size, GFP_KERNEL);
 		if (!kiq->mqd_backup) {
 			dev_warn(adev->dev,
 				 "no memory to create MQD backup for ring %s\n", ring->name);
 			return -ENOMEM;
 		}
+
+		ring->mqd_size = compute_mqd_size;
 	}
 
 	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
@@ -424,7 +431,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
 			if (!ring->mqd_obj) {
-				r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				r = amdgpu_bo_create_kernel(adev, gfx_mqd_size, PAGE_SIZE,
 							    domain, &ring->mqd_obj,
 							    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 				if (r) {
@@ -432,9 +439,9 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 					return r;
 				}
 
-				ring->mqd_size = mqd_size;
+				ring->mqd_size = gfx_mqd_size;
 				/* prepare MQD backup */
-				adev->gfx.me.mqd_backup[i] = kzalloc(mqd_size, GFP_KERNEL);
+				adev->gfx.me.mqd_backup[i] = kzalloc(gfx_mqd_size, GFP_KERNEL);
 				if (!adev->gfx.me.mqd_backup[i]) {
 					dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 					return -ENOMEM;
@@ -448,7 +455,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		j = i + xcc_id * adev->gfx.num_compute_rings;
 		ring = &adev->gfx.compute_ring[j];
 		if (!ring->mqd_obj) {
-			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+			r = amdgpu_bo_create_kernel(adev, compute_mqd_size, PAGE_SIZE,
 						    domain, &ring->mqd_obj,
 						    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 			if (r) {
@@ -456,9 +463,9 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 				return r;
 			}
 
-			ring->mqd_size = mqd_size;
+			ring->mqd_size = compute_mqd_size;
 			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, GFP_KERNEL);
+			adev->gfx.mec.mqd_backup[j] = kzalloc(compute_mqd_size, GFP_KERNEL);
 			if (!adev->gfx.mec.mqd_backup[j]) {
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 				return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 585cc8e81bb2..c5970aafa49d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -581,7 +581,9 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 			unsigned hpd_size, int xcc_id);
 
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
-			   unsigned mqd_size, int xcc_id);
+			   unsigned int gfx_mqd_size,
+			   unsigned int compute_mqd_size,
+			   int xcc_id);
 void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id);
 int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 41bbedb8e157..4d4820adac4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4973,7 +4973,10 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v10_compute_mqd), 0);
+	r = amdgpu_gfx_mqd_sw_init(adev,
+				   sizeof(struct v10_gfx_mqd),
+				   sizeof(struct v10_compute_mqd),
+				   0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3a4ca104b161..968098b20a02 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1860,7 +1860,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v11_compute_mqd), 0);
+	r = amdgpu_gfx_mqd_sw_init(adev,
+				   sizeof(struct v11_gfx_mqd),
+				   sizeof(struct v11_compute_mqd),
+				   0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6cd16f016c37..ecb04e387111 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1576,7 +1576,10 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v12_compute_mqd), 0);
+	r = amdgpu_gfx_mqd_sw_init(adev,
+				   sizeof(struct v12_gfx_mqd),
+				   sizeof(struct v12_compute_mqd),
+				   0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 86cc90a66296..db96fac75b95 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1229,7 +1229,10 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 				return r;
 		}
 
-		r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v12_1_compute_mqd), xcc_id);
+		r = amdgpu_gfx_mqd_sw_init(adev,
+					   sizeof(struct v12_1_compute_mqd),
+					   sizeof(struct v12_1_compute_mqd),
+					   xcc_id);
 		if (r)
 			return r;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index a6b4c8f41dc1..c35bea99df5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -2013,7 +2013,10 @@ static int gfx_v8_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	/* create MQD for all compute queues as well as KIQ for SRIOV case */
-	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct vi_mqd_allocation), 0);
+	r = amdgpu_gfx_mqd_sw_init(adev,
+				   sizeof(struct vi_mqd_allocation),
+				   sizeof(struct vi_mqd_allocation),
+				   0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7e9d753f4a80..10802e26f371 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2427,7 +2427,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	/* create MQD for all compute queues as wel as KIQ for SRIOV case */
-	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v9_mqd_allocation), 0);
+	r = amdgpu_gfx_mqd_sw_init(adev,
+				   sizeof(struct v9_mqd_allocation),
+				   sizeof(struct v9_mqd_allocation),
+				   0);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index ad4d442e7345..f76a0de617f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1139,7 +1139,9 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 		/* create MQD for all compute queues as wel as KIQ for SRIOV case */
 		r = amdgpu_gfx_mqd_sw_init(adev,
-				sizeof(struct v9_mqd_allocation), xcc_id);
+					   sizeof(struct v9_mqd_allocation),
+					   sizeof(struct v9_mqd_allocation),
+					   xcc_id);
 		if (r)
 			return r;
 	}
-- 
2.43.0

