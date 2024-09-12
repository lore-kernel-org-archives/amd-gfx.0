Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2494DEED63A
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Sep 2024 19:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC7410E078;
	Thu, 12 Sep 2024 19:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wd25jw3H";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE9210E078
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Sep 2024 19:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOBN4VQzzymBj2CLu3k74Pwqcu2UhiFmWfC5ca3pr8ynW5+jZW5QOd39/bemBeZld2nqP6yN9rzuQ8eT6zhO6qvlvzfGRm6kJDf3R28AvYudiESkuRPRf1QQrwNJEuK+TqfteaFpR1ZlBsei3Db4CkZnwde/oUH6H1xYwjIfU4tsqMjCQLyLwuujibs6Hne17Z77Nhabz/IP22Ko/UJEcIXb+8Soz4KtjK1A2vw0unPaQuipt59cUDxGxMspm7eS468tIKSfGHx0jkRexQ7+rVF3e+K2hXryy2ntP9MTaNs9FVmw9IDHfA8Ew7VBxcBGAb5xGz94gZ9qV0sVu20N0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNJ10OL9FhBMnO0WIuGiI7EGyxWPBujZJbn9cn4yGT4=;
 b=HtK0djwHunmwQYNPribCyRZ6mjhhs1Rj57Z2lFvYYIvdneuPB3GOkzjTK/VJkBiizs1fBLHpevdE1TPT/SWy8Gh+IAw2Hk2h9PppnB7CYWXD8w3kWOVsmU2Xh+jG2UiWc3uWn3E8e4HA/J/0pdni0QiIcgjR8C80qwaeKbqnZ01qh3sanCkkhh0axHeLlHruucVBMStXORbB7mr/Jf0PJi7zKXsYhVw3q7tvudVtBntmMNpocPwtVZ75rPYhBlZjwMWmYwmtwTFQxybwlKTFOSw/CFDY3PzNaQrDzhr6bztuoNlnWlyeFiJmsLn6wtII5skksvOdPTPLDxNQseh8tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNJ10OL9FhBMnO0WIuGiI7EGyxWPBujZJbn9cn4yGT4=;
 b=wd25jw3HRayG9v06ygJZRy1wdgkP66z1cdARPSaVz9thHyK5tqirvWTi6M8uhq17SIiXe3akbeZ76f4aK9WRbavDizSyt1yh/hbPMMLveK8OTinL1pRAgu8fTgv8Q8NHDIOGXQxflU7EgComo1CVX68hcKgUOHh7r7VgSbw+APQ=
Received: from DM6PR04CA0003.namprd04.prod.outlook.com (2603:10b6:5:334::8) by
 CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.28; Thu, 12 Sep 2024 19:24:30 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::f) by DM6PR04CA0003.outlook.office365.com
 (2603:10b6:5:334::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:24:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:24:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9.4.3: set additional bits on MEC halt
Date: Thu, 12 Sep 2024 15:24:08 -0400
Message-ID: <20240912192408.2382609-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: c6097d2d-073d-4f6b-f787-08dcd36084a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/iHzrOaKLWseaFkpnOMBqVOXnv5Dmqd2QeP/Ec702N8gHgLTJ9pRP7yemzMa?=
 =?us-ascii?Q?TOya8ceFzK49gVl7EZ3mvDeIkS1/7nwGvs+NY+nki+1DhXCsF6ztw6ejp1ju?=
 =?us-ascii?Q?m8SfwBhfGw7r8C6LDMN0FjVdi4iUWob7pUnU7WzE+teaxp0/bweFiOvz3p/Z?=
 =?us-ascii?Q?TwUCNFebh6n32Q4BHMuyECog/Q1PQ6AnpC9zC4/kfaVFs3+lSfo4GOjQ7lVv?=
 =?us-ascii?Q?oiWJ9F9UilLzczIBIOVwt7koJWxYqIzPR1vlLLfmsu4ydsfiOMZcsMlj3Q40?=
 =?us-ascii?Q?yh9wnAJfH1vGcCKYvyXwAALrjBSfnjHdHxyDZEgH6prnDLS8E1uT0taXdZ3T?=
 =?us-ascii?Q?7f9KUABWFEeFeyKvLniLosdDtUZmflYdVl5/UE2rKLChdjOJ+2j7a7+hqng1?=
 =?us-ascii?Q?nTDr1o54wrD1hzAW+5QdDlU1N0lYIWecYyiQP82f94IC0pdaoYqPbvBLnX67?=
 =?us-ascii?Q?3KCXJ5MUD1O3w+F/Mxx8DPn+nc17MlKVJMHatvbhunqKP9G4NaDvDVYjjA/I?=
 =?us-ascii?Q?WxLCjK7BIT4868Bo4gg3dVkVM81EzrIyHbah1rg4S1eP0VPFmsDkrdU3CPRF?=
 =?us-ascii?Q?JmlOnbVnS8hTjna00BnHhODF4TwvYctBWiCAGmWalx9q/h5fejUgNunw4Jfi?=
 =?us-ascii?Q?1bViNjOfqHX13NPpm6kKL3i+IChEEj4MSx3tH8fzUiVzVvnPAK3lHeEJS7XP?=
 =?us-ascii?Q?DMf35Smg9c9o2TZk+k4dG5WWr8e7jJfVNu8Wej4dZUBtsEfOHt1+aX3aCS2D?=
 =?us-ascii?Q?eKofyaw8FvCemSWg8mA0oYw8JXh44zp387lz4+7SaJfRNbymbVkI4bVlxzrM?=
 =?us-ascii?Q?prj5WJ4Y6yOnRLvckgVv9zpNnN9KUmwct6H4OlN5CRCieeww28jX7H4avz+7?=
 =?us-ascii?Q?VGULjCithVSd/v0YaurcE46rdaohp52c/kto35MvQLVd398JCJvHX23dybup?=
 =?us-ascii?Q?LJU1fOzMc7NV8H/ywn9cqGRlVSRuvTPDE0TpRfJei1AdhARwa+6Gp/j5yFr6?=
 =?us-ascii?Q?0fz65iV5YyCU8gKUxwVRkLCT0Hns8Xnvb9lu09GPKv/n6YQmrAetwB3XDMsF?=
 =?us-ascii?Q?XALv6YHKL/nLw4oYNLlDTzSOEjO8AAsBB6J1FXMXHfjnpy7JfQCXJjpJ3RFo?=
 =?us-ascii?Q?Lvkn44A/3fudIJNK7gb+i95eNGpw+7l/10u0sI7N2ghXFSkm/wxx1fjTxKpy?=
 =?us-ascii?Q?mlD9bY8Xiu1eb//mNzxj3iwo9ehi3Pb0dyfyHkPyBYWEQ3Zt83dh8vWm+5o9?=
 =?us-ascii?Q?0X5QjdotZUrS+l6Mntoe5FPNvSixLmNa8CtebsZ0BzhEVVm9FwFmUOzUB9N7?=
 =?us-ascii?Q?aX+ObserGG9v7VJliV1pQ6aul9r17IO6qgL4Ufo76PxJeeoMjxDi7uG1t1D8?=
 =?us-ascii?Q?Bsod+9TQdudQzOXWRbfPrLLIBgRVv1eUruHFDijmVLnndkDFLNOtJnm6o7+L?=
 =?us-ascii?Q?arD1Mppb75FSt7cA35VlbJffSBw+TiZJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:24:27.4661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6097d2d-073d-4f6b-f787-08dcd36084a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
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

Need to set the pipe reset and cache invalidation bits
on halt otherwise we can get stale state if the CP firmware
changes (e.g., on module unload and reload).

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 1cc748aaff3b..b865281b4132 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1703,7 +1703,15 @@ static void gfx_v9_4_3_xcc_cp_compute_enable(struct amdgpu_device *adev,
 		dev_info(adev->dev, "GRBM_STATUS=0x%08X on unhalt\n", tmp);
 	} else {
 		WREG32_SOC15_RLC(GC, GET_INST(GC, xcc_id), regCP_MEC_CNTL,
-			(CP_MEC_CNTL__MEC_ME1_HALT_MASK | CP_MEC_CNTL__MEC_ME2_HALT_MASK));
+			(CP_MEC_CNTL__MEC_INVALIDATE_ICACHE_MASK |
+			 CP_MEC_CNTL__MEC_ME1_PIPE0_RESET_MASK |
+			 CP_MEC_CNTL__MEC_ME1_PIPE1_RESET_MASK |
+			 CP_MEC_CNTL__MEC_ME1_PIPE2_RESET_MASK |
+			 CP_MEC_CNTL__MEC_ME1_PIPE3_RESET_MASK |
+			 CP_MEC_CNTL__MEC_ME2_PIPE0_RESET_MASK |
+			 CP_MEC_CNTL__MEC_ME2_PIPE1_RESET_MASK |
+			 CP_MEC_CNTL__MEC_ME1_HALT_MASK |
+			 CP_MEC_CNTL__MEC_ME2_HALT_MASK));
 		adev->gfx.kiq[xcc_id].ring.sched.ready = false;
 		dev_info(adev->dev, "GRBM_STATUS=0x%08X on halt\n", tmp);
 	}
-- 
2.46.0

