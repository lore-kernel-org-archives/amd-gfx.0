Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5419FC83F09
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 06:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA3610E0D8;
	Thu, 10 Jul 2025 06:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k+rMbFNX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA06310E0D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 06:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVfdK08NqH68MaToHCMipbKp0/T2cPxTsOLsnLOsNkUHF9NjhfEvYhCynlZfQCI9JCojR6xcgObaRqQplbn7ckct/ri5odDNMfkIApQnG3xz4F9RYIg0R2eiM64yWYCiImBQV7NHKRcSJos79RKWLVqwZeCfHwmqva5lT9cAPF0BZPQ9yTY1jtvvlhly5HtHqd+WbJZV/LtrOj8QwvyxGpwRrqxYl8C+HuOAw+uD+lArAsQhbjcCvgGKMeeSCFHM2h88w35yQwoAkxQAimuf5sDw/X+KiKm482ZUsyjA8PqstJ380Irhm56IADHHoAGrSP//a/iiptzQwIZMcPJRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coocd1QMKMIC2ijNqydzdTH+mwl8eQDN2VRC8Ara4bc=;
 b=Zuqlf1EGc+DM45wZ0ue9l61WEPeMtRZ9p5bi/If8+Wnxi/YD0w5TGJYWE4L5jiuidix5vp1EjKj1sXHh5EVmNtjyWUM8uGEvL/7jLMbH76YC3RXRMmJOE0n1jnvPD3kSRjJbucNiPXcq1aR/bMhW5R+ApVn6gWF7vXXGDiMXdU2koV4AI/rI43s1uNevydFASv3GSOTIKW2YBqVf2EGHLMrukWSX6WJDt23RFhBZH2EFW6I6HFvboO3MNtCNdu6nGdvgPXMh2HTZ2iJkIOfpi5671scn4boW0oKeR7sAFHvlrrS0kI2lYKuTzRYsst4dkvEo//uMvhz1mWpA/S3Q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coocd1QMKMIC2ijNqydzdTH+mwl8eQDN2VRC8Ara4bc=;
 b=k+rMbFNXGnmxYO7hwYTpPCz7KXD34NXpuUWZztfeDXSphxlMvqYpL0tXoUQmrPJfqX17CECP/uTNf8Hj/dfaIgHJxpxG+0o7W5/9VQur/16sJzxMHMVGBVdEb5eqnXc5tAvvi8r+4M4mlGBeooXAl2P0wKCL5RjSSi8zNwQzOxo=
Received: from BL1PR13CA0289.namprd13.prod.outlook.com (2603:10b6:208:2bc::24)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Thu, 10 Jul
 2025 06:44:32 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::1f) by BL1PR13CA0289.outlook.office365.com
 (2603:10b6:208:2bc::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.5 via Frontend Transport; Thu,
 10 Jul 2025 06:44:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 06:44:32 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 01:44:30 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, "YiPeng
 Chai" <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: query the allocated vram address block info
Date: Thu, 10 Jul 2025 14:43:55 +0800
Message-ID: <20250710064355.670983-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c941684-d66e-47af-cb0b-08ddbf7d3a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jz2NuRpFXAJgu3p58Bxm/C8sM8vCpzQxbgbIB88FydKGfKAHPOtBE+o82GzG?=
 =?us-ascii?Q?LdEi7Sf6lHXyQk30Gk/4D+xFE4YoGCfI/YvOBIUlHMQD5QzHXCse/ZMYJakC?=
 =?us-ascii?Q?gUAo3AuLqIT5QBlyoANL7WEdwSXatr3iCVDQ7i6wCB/X19l8aVbgiqNcjQtA?=
 =?us-ascii?Q?Qa/aVtupEtb9LReXh+Dx31Y0EhoOirRdocYNOEH+P3dUSMGeDk+i3JEPNfA9?=
 =?us-ascii?Q?n7F+R7UOKli8f/dDMTZpfjh96bvWe9Ef/sTeFSVcWs6yYVR11dAJSp+UBGf1?=
 =?us-ascii?Q?8WL+kP+PM8ejkdq2lERWfmhz5qaZVxUvIRVKceeEXkaL6PEk+GaNvneRO74q?=
 =?us-ascii?Q?uwccEKuERwUuOsm8zFQ6DnlkMjFkYUJcu6QmAP8ApISH6i5Q1RxK6xUB7mHK?=
 =?us-ascii?Q?ZthUlS+LZev0LcL2xwbayYuPr5wZd02lciCnr3brv3XixlarhvrTe5liy1vT?=
 =?us-ascii?Q?BAGqZq40ip2U8+MIRSU9uZYqHJhGkAI8qQ6+sv9y95lyfMCKwrkRkaXoFADo?=
 =?us-ascii?Q?1DpfByt6S/BQq7/JRQpHS0vtgpTJ3Dy0pJDMg/dsR5dv+4oWjaY3+7BPXMoQ?=
 =?us-ascii?Q?t1zcBceMttCbAXMjwjv4HyMcL7zfpDFXz/m7yGaQhcHTs1YypYbo/p9rpDF9?=
 =?us-ascii?Q?QCRDGNtxS64xS+5hILGogYbzDlyJsUArN1kJX2DlPr9vUWGTXjNgJ2nOEu1u?=
 =?us-ascii?Q?jsRs0tSggXq8IaRn/2WLv2zpWwQf+xgS7QCgyu4NchI/0ySDPhKhDO1vsVvc?=
 =?us-ascii?Q?pqmhGE0npzoZt22ZSa3GFJvBbdV7bDUsdBUFptgzdAVYOxnPce3yUXYXN5od?=
 =?us-ascii?Q?jZ1U1KFnD5ZRyLy+wJRoCPw2S+lmTMDpgaRvx5I7NCJPap76zUeXpgX3j1FQ?=
 =?us-ascii?Q?sBeQRBy3RQE3+xANZIxMFsho0tFvlVyiNLUiHYbs2ePBYGspy+LerSW3bMZz?=
 =?us-ascii?Q?kei6HBXQNZKG4EFpuiusqJSvAoRtufOpP5zNbE7+KuOdsCLKpH3qBZaQiwza?=
 =?us-ascii?Q?t6D1wa8UZZFhdybqF2im+bO4zUWa8q0y5klrkqES1fyduirEs1bmDbgUEpV1?=
 =?us-ascii?Q?/c7cQFicu6s0ISC4jhr6n//z2sD7D0qfc1ot1Ei37bZaeYUDqaOETIgLaIKO?=
 =?us-ascii?Q?rT6uyG4iDIfGsydrKtxPk/AbqCeD7Gpi4pO7ER7YR0ne7f4d58y+FpADt6wr?=
 =?us-ascii?Q?babYH9f3e/nCeo8DlyJOAaVINQSMKcPjb0gI9HKaF/8NJ+MM43qm2Hxi3K3D?=
 =?us-ascii?Q?NZ9qKcL8OJCcT6klLxI04TAtOGYERJ5Y+wmOHbEUBCbrC0+IVDQGmDXaVaxQ?=
 =?us-ascii?Q?ZFsbnVkHlWztd/3ye2fUS8vwVoJc9RyQ0tzdrPg5P43b8MXx/U4jfZOld+EV?=
 =?us-ascii?Q?o71XFp3OkIhjtZbnVXBKYkrlhqU+u1Wz5+XWyDr6H005OCCiAwZpXQlAed4n?=
 =?us-ascii?Q?9LZCuuGuxwnoDB1R6FAO70luSBmBl+2GbX33tKqiuob/CfUz6g5JhppNRHG1?=
 =?us-ascii?Q?BBACBaHMQQM81b3eCEwz4F6puUP+os40QzYs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 06:44:32.6350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c941684-d66e-47af-cb0b-08ddbf7d3a52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302
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

The bad pages that need to be retired are not all allocated
in the same poison consumption process, so an interface is
needed to query the processes that allocate the bad pages.
By killing all the processes that allocate the bad pages,
the bad pages can be reserved immediately.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 38 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h | 17 +++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index abdc52b0895a..4bf3e99f47fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -396,6 +396,35 @@ int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 	return ret;
 }
 
+int amdgpu_vram_mgr_query_address_block_info(struct amdgpu_vram_mgr *mgr,
+			uint64_t address, struct amdgpu_vram_block_info *info)
+{
+	struct amdgpu_vram_mgr_resource *vres;
+	struct drm_buddy_block *block;
+	u64 start, size;
+	int ret = -ENOENT;
+
+	mutex_lock(&mgr->lock);
+	list_for_each_entry(vres, &mgr->allocated_vres_list, vres_node) {
+		list_for_each_entry(block, &vres->blocks, link) {
+			start = amdgpu_vram_mgr_block_start(block);
+			size = amdgpu_vram_mgr_block_size(block);
+			if ((start <= address) && (address < (start + size))) {
+				info->start = start;
+				info->size = size;
+				memcpy(&info->task, &vres->task, sizeof(vres->task));
+				ret = 0;
+				goto out;
+			}
+		}
+	}
+
+out:
+	mutex_unlock(&mgr->lock);
+
+	return ret;
+}
+
 static void amdgpu_dummy_vram_mgr_debug(struct ttm_resource_manager *man,
 				  struct drm_printer *printer)
 {
@@ -568,6 +597,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 			remaining_size -= size;
 	}
 
+	vres->task.pid = task_pid_nr(current);
+	get_task_comm(vres->task.comm, current);
+	list_add_tail(&vres->vres_node, &mgr->allocated_vres_list);
+
 	if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS && adjust_dcc_size) {
 		struct drm_buddy_block *dcc_block;
 		unsigned long dcc_start;
@@ -645,6 +678,10 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
 	uint64_t vis_usage = 0;
 
 	mutex_lock(&mgr->lock);
+
+	list_del(&vres->vres_node);
+	memset(&vres->task, 0, sizeof(vres->task));
+
 	list_for_each_entry(block, &vres->blocks, link)
 		vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
 
@@ -917,6 +954,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	mutex_init(&mgr->lock);
 	INIT_LIST_HEAD(&mgr->reservations_pending);
 	INIT_LIST_HEAD(&mgr->reserved_pages);
+	INIT_LIST_HEAD(&mgr->allocated_vres_list);
 	mgr->default_page_size = PAGE_SIZE;
 
 	if (!adev->gmc.is_app_apu) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
index b256cbc2bc27..f5ac0eeb092c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h
@@ -35,12 +35,26 @@ struct amdgpu_vram_mgr {
 	struct list_head reserved_pages;
 	atomic64_t vis_usage;
 	u64 default_page_size;
+	struct list_head allocated_vres_list;
+};
+
+struct amdgpu_vres_task {
+	pid_t pid;
+	char  comm[TASK_COMM_LEN];
+};
+
+struct amdgpu_vram_block_info {
+	u64 start;
+	u64 size;
+	struct amdgpu_vres_task task;
 };
 
 struct amdgpu_vram_mgr_resource {
 	struct ttm_resource base;
 	struct list_head blocks;
 	unsigned long flags;
+	struct list_head vres_node;
+	struct amdgpu_vres_task task;
 };
 
 static inline u64 amdgpu_vram_mgr_block_start(struct drm_buddy_block *block)
@@ -69,4 +83,7 @@ static inline void amdgpu_vram_mgr_set_cleared(struct ttm_resource *res)
 	to_amdgpu_vram_mgr_resource(res)->flags |= DRM_BUDDY_CLEARED;
 }
 
+int amdgpu_vram_mgr_query_address_block_info(struct amdgpu_vram_mgr *mgr,
+		uint64_t address, struct amdgpu_vram_block_info *info);
+
 #endif
-- 
2.34.1

