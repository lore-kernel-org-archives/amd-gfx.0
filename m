Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8523BE7490C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 20:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B07B10E237;
	Mon,  2 Oct 2023 20:21:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDFC10E237
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 20:21:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OApkY4nCxdQ9aI5SZBg9WhJQAFcFjEqFLLbR31UTYqkx24+xOEP+QcGZkl04g4oCnD5AFsUG66xR4D7Yr+lgjXixjWN0WxxX3zgOQbao87niHsfgsnF+OfYqY6SLUVwaq9ZrimS6aetB13FMpTTRgJ2hdCcsY1r0QE3xV8UJ4M4VXfv9XGCHvoUDLJ2pvThDKHhKKeGxjRvzwB9SEZf3uewW+pXEbl+ipHmbgXQ+kcxYc8uYsUhziofqrh8AVH14mMkAafyYEO3rGwpJPU2jG8scOVyKxIsK6PqglC9ZEI84OTrsf9kXr7fG3Jvh2u1Dq+wK/MH+Ohlw7Vp+r6IUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzeZDWMhtZ+Ek5hOhHc5f70ngtZRlHf9Cdz2h4ITi4Y=;
 b=O0oYHE5SXtIhP/ZoOBbwaekN4yWMV0qCvvcUZx/NzxfPqJwXovLJU25ZYrlIX9gXnqqE9cGHqAZj9uZRhBoTw/5oxoRfQyGIVpAecheJDa3gEI5fRiAK6i/yf9e8QT7GVPjNnmgsHWwAHsV0IEVQiWjiscxV4b53V/S2HoG3RzbnzS3DtG+tXCwKWTggN5QOWHesoccTeQvbf4jrtgd7Q6DkbA4r/uC5C4QYqbDXDSeee4ML37YzBginGOxcIEaZrFJMg1B/WXASFuoteCnV0VV5dEIRFGT/Ymptca124gABoQHhbPDP+5c15epslCaCqfM4zh+1ZIZ8RO5iJW74Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzeZDWMhtZ+Ek5hOhHc5f70ngtZRlHf9Cdz2h4ITi4Y=;
 b=ustVE7vsnONr1JL4GwjqRDaSD8AN3qdWWnUrXt4jxDJaDydwUNsH4ZsQZziTVzSj0sb84Ju3uJ7UvoRa2CAaH7NctnHNJv8UPbrtl5YpfEV1emjswEyBE5Dvx9mPUFC+jeYywUmO7D9FTM7+8IsJQzfu4xZ5+YKkRC8GpmZrru4=
Received: from CH0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:610:cc::29)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 20:21:31 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::8a) by CH0PR03CA0084.outlook.office365.com
 (2603:10b6:610:cc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 20:21:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 20:21:31 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 15:21:29 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [Patch v2 2/2] drm/amdgpu: Use ttm_pages_limit to override vram
 reporting
Date: Mon, 2 Oct 2023 16:21:17 -0400
Message-ID: <20231002202117.2690645-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002202117.2690645-1-rajneesh.bhardwaj@amd.com>
References: <20231002202117.2690645-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: f25a6433-64a1-4856-96ef-08dbc3852a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbHoUTSfYKzFO3Gd2xBo1AEI8aZSl39U6bFnGKkhOtTOGB16MlDNozRUZqJb9HxTHU19GkuQ8rRrGvtNFJ1eNXi0C+MAqj4S1Oyq3TVDd+UGb86U06m+CbgmowmKwFxLDbQbp+3TyRXATIDcKTNg9qS83IGSki17gvhZy/c6AE1G6z3ONqT2axRRpdJ/OKcL12GD5QmejjOjGC7KXAbbcjmAdnRBI+xmYzAD0Aop8VeS71ZP6i7xIvWnwhlGVbJNhECJP+A8vlGpr7fbwEIjQXt/sAw3vuewSAusMO2NxbKLP1GNyAM4oQKEubwO6KeeajTtQmyCcUBZrx/Oyz30ViF5i516iMPYYEmMkNIZ2AQzkUMQBFnSmNYCpmdcREPu4IHfKRRcDOaqtr45C7srCBQu+PWYWvyQRe4Z/g0TsEgfEWZmMCF2MCFDh39x9TOScun8Q14oaSDuu95Q3xafiZ0nZxvzmceIn4Nr0d7F8IO/ukXVx2XLTKXXXlXpHrh1hmkODiKlacUKC4d0BIZpnx+WJ6RdjJE18KCfBa0KiC2klAiq7XdazSg292Er5ek/ybNcjZaE/gCBMITeVF/ylSXFoE6k3dT/gesZgzlwiNt1Um45NR1ntQGnF0ZJBPOQP9ci9FT3wAw2aPE3HEWZWcfeVJSihDR4B/xQOcwTOWgEcGPCUYGL+dHSRWqBUxYBRG6xUoryyRt9UGhNBRzlCcKV0J7IK1us++UWtY5A33T2a6/H4IKZZXDY8NfaZ3XdFBr6PpGkhDFPlC/GsugOUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(7696005)(6666004)(83380400001)(356005)(82740400003)(86362001)(47076005)(36860700001)(36756003)(1076003)(81166007)(2616005)(26005)(16526019)(426003)(336012)(44832011)(40480700001)(2906002)(5660300002)(4326008)(8676002)(8936002)(70206006)(54906003)(6916009)(70586007)(316002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 20:21:31.0307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25a6433-64a1-4856-96ef-08dbc3852a53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
Cc: philip.yang@amd.com, felix.kuehling@amd.com, lijo.lazar@amd.com,
 christian.koenig@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GFXIP9.4.3 APU, allow the memory reporting as per the ttm pages
limit in NPS1 mode.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 +--------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 38b5457baded..131e150d8a93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -28,6 +28,7 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_dma_buf.h"
+#include <drm/ttm/ttm_tt.h>
 #include <linux/module.h>
 #include <linux/dma-buf.h>
 #include "amdgpu_xgmi.h"
@@ -806,10 +807,24 @@ void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev)
 u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 {
 	u64 tmp;
+	int num_nodes;
 	s8 mem_id = KFD_XCP_MEM_ID(adev, xcp_id);
 
 	if (adev->gmc.num_mem_partitions && xcp_id >= 0 && mem_id >= 0) {
-		tmp = adev->gmc.mem_partitions[mem_id].size;
+		if (adev->gmc.is_app_apu && adev->gmc.num_mem_partitions == 1) {
+			num_nodes = num_online_nodes();
+			/* In NPS1 mode, we should restrict the vram reporting
+			 * tied to the ttm_pages_limit which is 1/2 of the system
+			 * memory. For other partition modes, the HBM is uniformly
+			 * divided already per numa node reported. If user wants to
+			 * go beyond the default ttm limit and maximize the ROCm
+			 * allocations, they can go up to max ttm and sysmem limits.
+			 */
+
+			tmp = (ttm_tt_pages_limit() << PAGE_SHIFT) / num_nodes;
+		} else {
+			tmp = adev->gmc.mem_partitions[mem_id].size;
+		}
 		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 268ee533e7c1..b090cd42f81f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1896,15 +1896,14 @@ static void
 gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 			      struct amdgpu_mem_partition_info *mem_ranges)
 {
-	int num_ranges = 0, ret, mem_groups;
 	struct amdgpu_numa_info numa_info;
 	int node_ids[MAX_MEM_RANGES];
+	int num_ranges = 0, ret;
 	int num_xcc, xcc_id;
 	uint32_t xcc_mask;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	xcc_mask = (1U << num_xcc) - 1;
-	mem_groups = hweight32(adev->aid_mask);
 
 	for_each_inst(xcc_id, xcc_mask)	{
 		ret = amdgpu_acpi_get_mem_info(adev, xcc_id, &numa_info);
@@ -1929,12 +1928,6 @@ gmc_v9_0_init_acpi_mem_ranges(struct amdgpu_device *adev,
 	}
 
 	adev->gmc.num_mem_partitions = num_ranges;
-
-	/* If there is only partition, don't use entire size */
-	if (adev->gmc.num_mem_partitions == 1) {
-		mem_ranges[0].size = mem_ranges[0].size * (mem_groups - 1);
-		do_div(mem_ranges[0].size, mem_groups);
-	}
 }
 
 static void
-- 
2.34.1

