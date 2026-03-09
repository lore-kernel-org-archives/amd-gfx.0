Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95433F417F3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 369BF10E523;
	Mon,  9 Mar 2026 14:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y8Wd/NJa";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FC210E523
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGZH34KZc/MB734zWvIrMqXx3H6N0opbjatvyHQfIS37a3x8Gq7JxIqyKd0R+ztIHSfwlZLsKa0Q0tza1DwDlOERZZGo73dqJ9ZCnXIFnvOliLV7rqInAiBFEYRa4R7OltslcSMPGFpqIsbAvOE52X5fqGxy9xh+pWaxRGk37KBRGMfpY5Qr02Sge1CHXQ8MHduz3FXeXqchKt5tb1swHwoQyrnA8I6d5982vWstZ6d2itCHEw4ipzQdUWCTw6z+o/lZ/l/YJqGUOvov5IMRAr7J+2lXWODHhG9eYIQ/i7+9lOzfemt3zHdW6uGCjku8xuub3VRQy/l/cZOprElORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H09BoB8bVoVeiQSBuR+LXxn/vp7QdMRHZvNVE2jvCMs=;
 b=Gh3kLk1BHQsntSZHfA4FgR+/sfEcoMFN94HF4JvqaGidkv9TwBmpTH6cEYt6PnOBaMYAJZj9xa8DQwYPWkyOEBZHJCaaB3QCTeYWNkt8trIlk7DbxhsXwfvOR4Y5KKW8yXSPkERfZ6ONavL9JXs0FA8tuxJhSgnkilrcaBjBB0lSXNf4QRKRU4wd8xpwTn5G0FqGMm53bdqAciwpXcJKQmbHcKDMkxvIOhCoxGQzEydnvE9IX6U5E+p8qYW/bzB2h6fOYQ3w8RvrPYOu8sB3tttAzLme7NgCbdCE2QalUr71AaP5vIDydi0EVFsZw6veELtpsVRL1uflp5/pjelp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H09BoB8bVoVeiQSBuR+LXxn/vp7QdMRHZvNVE2jvCMs=;
 b=y8Wd/NJagDOpeXJEwBPDAW8NWv03LQpgiTBNIvWy5HPwur25VQizRjVmE18cRtt//t5ow4JJEqH00sQxf4RZn0iRcZ2HN7J+E9/JoVZID99ZHG9Dj/BAHtV2rgi0PPmMDF8ngTdlT9ibbFtqOUwq3AQUjRc+ST0CMNlYqo1seCE=
Received: from BY3PR10CA0014.namprd10.prod.outlook.com (2603:10b6:a03:255::19)
 by SN7PR12MB6669.namprd12.prod.outlook.com (2603:10b6:806:26f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:57:08 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::89) by BY3PR10CA0014.outlook.office365.com
 (2603:10b6:a03:255::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 14:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:57:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Feifei Xu
 <Feifei.Xu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Retire get_xgmi_info callback for gfxhub v12_1
Date: Mon, 9 Mar 2026 10:56:23 -0400
Message-ID: <20260309145629.2844495-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|SN7PR12MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: afc406bc-be17-4d3f-f36c-08de7dec228d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: DgjMY0yA0gQ2EKgjW/1b3r5Ev38WkRN25vGQki/q5mgQUnTEdxXZlBbNnfbeXUtdxDkf4FXhVqR+Tz6TFJFE8wxwJMKW9Os5lwlW4ERVGZ3lqyC5pZGFdIKJhSltTnTSbGopcHXE0wBGqWZjYR6m401DRjR8erjNYR2A/QTb09dMEQimmd7Uxoj1o07C4UVlN2tu0A9tYSUUBUeIHc6A0ptUMVbUlI9Z0syr34CxdV8QHhupdpI9d3auEpxmUWBysoHm6OuL5RoW9Q/mydQ0joWc/8SXMwxpGUNTNCSm38jVMcJjUTTSjSEFd8fjkE/VwolGjSXnty9MvWQaeZ2uurUZS8NWbgAJiNeEfAAGt5a77D27WighY//5tO4pTpPfAHoaQtu3WbA7K/VTRF2hlLcNDYDnJo3IepwN5cA2L1uly8rIGv17FeYzLeYgmnOKX6rJb8RQmfCTzu6K5OyKdx+TXSvYwmWgFRh/IPfg+O2slFeB7q09BjBEWBQatI9F7G1ehvJRlcn/NhPjJqnYuKwf1qpZEN93wPcOLGo2rzHilXEKA1r/IKClM8GUr6LncjNKU5BsY5uAAexk1cNfKiPy32YFjlrruhL/3bEHxwknHe5TJw+wG8FjQkA1KGkESjnROz8OSDS8MkJaD7aF7coIxZbva4/fzYL5QLrqD7GzyFSk9ER+duUJZsWbBsp5SIdCkL8akhyEX3Ua2lF6j6HnkMySy58CnQIRSAr8oWA99ysL5R1bZbppVsO7ntqDrKBwMjvfOCJEzbZ1YoD7wQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YllBBqst+ImKyFreLKsr7okIVjXIrV38TPOf5Csa/9M6ZQy4bc82Fbpmwz65frZ3Q3cbdbUSz+amO8DnoLhTiih9OJiWHCNRDGwPbbQ1BNZOJqAcoMzBhG+rMQTsUl1XEKnc1AwBU/N6vb70zSBwOHJVKIszCioCXJNBsVqR/rUEvTnd5CQkCFuTVXuRFWEyTm36dkEW5bkAGX5xTWrl2xVwCsXnE2R+lulf5b500vF+sC34giSU9Vi8qRntkeT3DWj+iIoWv4hEZF/Ra7CuyGyd2/HM7HrEewqnb9cxHQosUjyhBTd3vClLHc4jxMxty8r7DrhelPckWa/pR/rYvk0sJVAwnoepHw+QADJc1HTLH6apiZt6Dm9vE4ZHlTTlM/Ih0VwgRtxl8jUy7M8bAPUWNDJQaWeeEzDKIRZcObcPoImYtwtBMNYs4keqhzV4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:57:07.7840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc406bc-be17-4d3f-f36c-08de7dec228d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6669
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

gfxhub v12_1 is not always on. querying xgmi info
from it may not work consistently

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 42 -----------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index d086c23e4c2da..3544eb42dca60 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -822,47 +822,6 @@ static void gfxhub_v12_1_init(struct amdgpu_device *adev)
 	gfxhub_v12_1_xcc_init(adev, xcc_mask);
 }
 
-static int gfxhub_v12_1_get_xgmi_info(struct amdgpu_device *adev)
-{
-	u32 max_num_physical_nodes;
-	u32 max_physical_node_id;
-	u32 xgmi_lfb_cntl;
-	u32 max_region;
-	u64 seg_size;
-
-	xgmi_lfb_cntl = RREG32_SOC15(GC, GET_INST(GC, 0),
-				     regGCMC_VM_XGMI_LFB_CNTL);
-	seg_size = REG_GET_FIELD(RREG32_SOC15(GC, GET_INST(GC, 0),
-				 regGCMC_VM_XGMI_LFB_SIZE),
-				 GCMC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
-	max_region = REG_GET_FIELD(xgmi_lfb_cntl,
-				   GCMC_VM_XGMI_LFB_CNTL,
-				   PF_MAX_REGION);
-
-	max_num_physical_nodes   = 8;
-	max_physical_node_id     = 7;
-
-	/* PF_MAX_REGION=0 means xgmi is disabled */
-	if (max_region || adev->gmc.xgmi.connected_to_cpu) {
-		adev->gmc.xgmi.num_physical_nodes = max_region + 1;
-
-		if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_nodes)
-			return -EINVAL;
-
-		adev->gmc.xgmi.physical_node_id =
-			REG_GET_FIELD(xgmi_lfb_cntl,
-				      GCMC_VM_XGMI_LFB_CNTL,
-				      PF_LFB_REGION);
-
-		if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
-			return -EINVAL;
-
-		adev->gmc.xgmi.node_segment_size = seg_size;
-	}
-
-	return 0;
-}
-
 const struct amdgpu_gfxhub_funcs gfxhub_v12_1_funcs = {
 	.get_fb_location = gfxhub_v12_1_get_fb_location,
 	.get_mc_fb_offset = gfxhub_v12_1_get_mc_fb_offset,
@@ -871,7 +830,6 @@ const struct amdgpu_gfxhub_funcs gfxhub_v12_1_funcs = {
 	.gart_disable = gfxhub_v12_1_gart_disable,
 	.set_fault_enable_default = gfxhub_v12_1_set_fault_enable_default,
 	.init = gfxhub_v12_1_init,
-	.get_xgmi_info = gfxhub_v12_1_get_xgmi_info,
 };
 
 static int gfxhub_v12_1_xcp_resume(void *handle, uint32_t inst_mask)
-- 
2.53.0

