Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E7FC61DE4
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 06:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEEA510E09A;
	Tue,  1 Sep 2026 06:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c30l8Cm4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010024.outbound.protection.outlook.com
 [40.93.198.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A9F10E09A
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 06:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4WF+QMxr7rxvl82jaLrnRxt2niF39OMho7z6VdpcjMKh/Gnzhq4JUQsM/RoB3Jc5OLhhOLBYk1hToA+UqGEIOl5rFWDGsdIO+7/U+3YtBlSFgtWkS+myap7ddkt+PJp8nxZNBf5zfu/AdibT+aLRLbzE1iw1V0bXLgvYGdLf2WTAPUDOm0nO+zC2z8k6wl/m/4VZ/8cJq6gymHccIJPDQdX+4wU6hViydPu6DoxwQq1fVpgEeLap5ToI/Kq6d+3o0G2ziUY2/6CuGT++MGV2aRTVgZpl/pjDCKD6Puq/gKgIAstFuSTchGzqUufiCkSfTnFKTsCShK6wGAP9CMn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIBpmRFEZ1+kSC3zKrRAt8uR5olnQK50P+e0ItPtb6Q=;
 b=NCUk3weOqeoZkoLu6/Srxf61VVc1JDOC588bkPQeRHTpdS9lhQ5VtAHn2cK9o/M1EKVttKdcGHmOcG3ZksdLUdW4/DOtLcrIBp1g0E3yMp0VQ6IB/JZSCsocHeHPHojQPLWqVsmYCdz/nEsEl9uue55tHh5oGNLFgTgbevXiCn8V0z6G+pHdy9Vqd04C0FeVwW/zLz6JMGZ7X2aJEylsvv9fzOcDrt1/xeh57geY3UkKTt8qvfOONL84rHZ9xR3PJF6ZHWPtBvXCyzG8bAj7P/CG+UckJSUKEO2rTXXjEyopb5QF4nBrX81GHAB8admvE4IFGuLImgE/GYthcww/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIBpmRFEZ1+kSC3zKrRAt8uR5olnQK50P+e0ItPtb6Q=;
 b=c30l8Cm4kPCIFwjGLITCUUj3lP22yLsET2wjddErYqY8WW3tETUC+UGwKYbveMNiBuhRZACrBb2+RPY7quWkUOaEkcEhBVIgs5PalWpq3x/vp2pRBr1Zi2KUSs93x3ELCq0GfjCJCDtz1U4ekiScTgbxvhGWWjVcMFyx9tZFMlE=
Received: from DS7PR03CA0238.namprd03.prod.outlook.com (2603:10b6:5:3ba::33)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:19:30 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::23) by DS7PR03CA0238.outlook.office365.com
 (2603:10b6:5:3ba::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 06:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 06:19:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 01:19:27 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH] drm/amdgpu: Remove gfxoff calls in GC v12.1
Date: Tue, 1 Sep 2026 11:49:08 +0530
Message-ID: <20260901061908.3881527-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e7d220-7c19-4c6d-5fa6-08df07f0faef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: eyBlceBvdc+MbI7n96nyLJnT2CNiDUvqlqsA3qYQIlSpED38NzgLhLWDgHbM0Kdy/i7zJD/vtiS9+7YWopqdBBCIyOgPHO+tT26NZxvkAAStnJrR97Kt/rAHDKPgdJ/Bq96m/N1iRIvGUR2vCllp8EX91Cjooq60dOHez4SDMTY22Pwl78DOMzpljhOyKYjmSicxnpVVgtCG91ql9tFdS93lQKlIFc2+M0w5dZHhOxI+DjurdbGwzxXXIkM5vrwn/q8kIFIkKDRO0YHvbZnO/ShCSpZrMVkhHoP5mbzYyx2E6SbGtBpgfbSOR3OSa5P4GRqNKqDpdmWkj1TDexOl9i2AcxvAOMLoMGMjfaAbpQx9MckFKTfCL/pHDfSvSluKn1mbpYYLDmcelYxbP9b00eEPfP2RIl0Ni5sV52PXD2zqcM8CLAzmMovnXvCq8OjqW4LefvMTGSZZCgsFtP2Qn4iDaha88KewzFxkobNFRGK0Uo+eGuqyGJQ/KPXHhzipB31iQgiPAv4rMtfJdtH2RwPP5i+WwkOp+hl+oPZi5WcElfTA2KU7+0OrBqW8uqdeApCcGdzqiPuKmwlQ9cTJZeGCT0tiIXVlJqS29UngcGjOTJghRyRcxnxYNAC46AhyiWENFjWovvPCb+i9SFUqawrj2FLYgKvTHUTGtcAsRSt5UDiPWJZ23x9Zo0WadJjpZEnkJbKLNPQAKn8FFuQDig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w9CtvCZsYsEAQlAtwi6xwcfDKBfStNA+ulL0RCBQDeD3/m6g2Kri8p18jmYWtmjOd351dSXSNCdgdh3uvu3lGvZ4tskQeS8yd1DyHFqkpoua9Kx5P1ZyV+rMquC0YNbSQZxCFc1OJPkGhqCA11CATdcXgtLKklsnTbv+2liksnzXCrSQVJ1ToGDkf0ExHlRh/5yHv6xAl6RxUvBkB279VbTsO5oM8ozqq9Rjla8HDFyRO4uZaO7M4kqgyFwNNcdAqQZe87d+sK0+j8tHNCqvqTbyYNpJl7HVDU3YnQ8o44W+6Nz5zovBZ1RZAnXblNbV1L14Vg5v3w8rjViqip3Oofs8uNiVf58q9uritZIw1N4domFKc5RZWCJn32saGeSZ0t00fYFFzbntagC0YyBYEf8OjHFCeZNffgWal9n8xCJibI895RoxhRpNxz7ln4h8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 06:19:29.2682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e7d220-7c19-4c6d-5fa6-08df07f0faef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
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

The calls are redundant as GFXOFF is not there on GC v12.1.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d60cd64d444e..937fe1f1897e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1384,7 +1384,6 @@ static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	amdgpu_gfx_off_ctrl(adev, false);
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
 		xcc_offset = xcc_id * reg_count;
 		for (i = 0; i < reg_count; i++)
@@ -1392,7 +1391,6 @@ static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
 				RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_12_1[i],
 								   GET_INST(GC, xcc_id)));
 	}
-	amdgpu_gfx_off_ctrl(adev, true);
 
 	/* dump compute queue registers for all instances */
 	if (!adev->gfx.ip_dump_compute_queues)
@@ -1401,7 +1399,7 @@ static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
 	num_inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
 		adev->gfx.mec.num_queue_per_pipe;
 	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
-	amdgpu_gfx_off_ctrl(adev, false);
+
 	mutex_lock(&adev->srbm_mutex);
 	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
 		xcc_offset = xcc_id * reg_count * num_inst;
@@ -1428,7 +1426,6 @@ static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
 	}
 	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
-	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
@@ -3310,20 +3307,7 @@ static void gfx_v12_cntl_pg(struct amdgpu_device *adev, bool enable)
 static int gfx_v12_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 					   enum amd_powergating_state state)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	bool enable = (state == AMD_PG_STATE_GATE);
-
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
-	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-	case IP_VERSION(12, 1, 0):
-		amdgpu_gfx_off_ctrl(adev, enable);
-		break;
-	default:
-		break;
-	}
-
+	/* No powergating state for GC v12.1 */
 	return 0;
 }
 
-- 
2.49.0

