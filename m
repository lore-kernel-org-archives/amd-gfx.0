Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A873C35FFF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 10:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA27D10E783;
	Fri, 21 Mar 2025 10:34:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WO9lEXtG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BE8210E783
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 10:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjvyHbEvrwX3Bn1QErTO3BxKThEWAm3UPQU8m9yvBAbnHeQkldtw9Y5JLn2deQA2BzJT99pOKnEi0yCE95+yqiJ+WrUIoGcunAlppTvM1wv+TMlgpN/Q0jKLYXYO4xDogDnvJxbC6KjNTRdVoReMw/HTvRUlwm8nHmHAm6p8E8OzWjRvpMheeUVLS5q2ChcR73Pu0vC+ADicVa963ujrUb3XIkwm5ya2No+ZWkL2BhQxB+vtOZqvSv4gVbsQaAR8shlqFmKSdryww90w413WlF/HzGsn8j7LFmHyNK3gP7l1ywvhuKMWg7kc76QOi5zkrArPfJ60YQa+WN4PIi2P5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qHka2ysJemvawH6oQUnfQ6MJjPmy267tewfzlAbbi4=;
 b=C3rXumoTvxR191KQpVSfscmJgdp2lbtgmNnnDkGwZ1yS1ekifHEIOwK0hCECwMLPH5PPSJcror9q/3APCJvJNl0ErPySGM7d3vBOyI3WwX9zo0UUbs8bfE97YjyZIGEsnD6kddZ+nvJdaqIH/zv/rYwa10vzYt5CZG71LlRRwdM9DxmJqDCWoX3BHTUVRiSWW/wvSvek6dPXDPURM71HZEC99vgADnvHIJOQvzKjKXh0AL5J3qz0JErBfKyyIppOTYZAiH7lpDqo13w8GCs0F4/e/dD4KMpF+y0JQSVYWd8W1BOJlLla2iZ8/8V6Kkkwee8IcMfknSIaiCgDBOQB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qHka2ysJemvawH6oQUnfQ6MJjPmy267tewfzlAbbi4=;
 b=WO9lEXtGP976ivxeZWKMnkHWs9fZU8sfFW+iGGCbet0tAEbyI6m9DILSKfW/J4CgU2LB5VpkVrVEM0UPcSPGH9tfkz2e4Wq9gXgxNSPtpEPv31onXcUYQwZVcf14A3JokHqrDGjB42RDmFBOkcZlSLgApv7n6mXTwrF6yL6p/lY=
Received: from DM6PR14CA0057.namprd14.prod.outlook.com (2603:10b6:5:18f::34)
 by DS5PPFF8845FFFB.namprd12.prod.outlook.com (2603:10b6:f:fc00::66a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 10:34:13 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:18f:cafe::bf) by DM6PR14CA0057.outlook.office365.com
 (2603:10b6:5:18f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 10:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Fri, 21 Mar 2025 10:34:12 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 05:34:07 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amd/pm: Update feature list for smu_v13_0_6
Date: Fri, 21 Mar 2025 18:33:46 +0800
Message-ID: <20250321103346.1284734-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DS5PPFF8845FFFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d17ef47-7c12-44f3-2a68-08dd6863ec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cjFTf6Hnsw73/j9Q0EIiLXm4WaJt4Qwh0ec40oYj0XERmzx9iiojn2Zrzizg?=
 =?us-ascii?Q?qrbw0ntiuPl4gwdRdiAUmd/OzIyt5pqOlclGmOhq1RacQGMKis5zR9vM/7Vr?=
 =?us-ascii?Q?T2/ZQ7hPQqj3kLf28JVGBDuoOsS7KjmzR9v6Jlrv3KDjfr2uG9QIDmA92KHg?=
 =?us-ascii?Q?btN6GcOa9u690p6GL5SwEwI1p5aRplG4/jI37qIY6mUxMFc7/ZOoGpLOn8HK?=
 =?us-ascii?Q?OMmq4Z4l72XYBiATHQyVhgubCq2c45+JDU2Lk5uO0ML9uPJc+ZSWpp//IUlQ?=
 =?us-ascii?Q?nqczTtu6IdQ0YM3AWgf9TYToUAmbiGVa7u8jiaista0Iu8ktMhlANrEUZnqP?=
 =?us-ascii?Q?vQszwHps4+yUgVz7THUtzye579ZJ+2O2tF8KOOxoWlSjdSZ5iEQSITAnDdRm?=
 =?us-ascii?Q?kTaYU3ci02fAbjXYOOEavLG2gSeGaE95y0yHGhAenWG0DGIWstRUi6VJMua9?=
 =?us-ascii?Q?iq4amG0Ro+gfcT/N/7vvfZjs6NBmlTn5xPUrKLRE6V96Jso9keODAMHZUIjF?=
 =?us-ascii?Q?ScoYzY9uYstTyIGb6Hx2vnkZFxP1gJWIDliHqjP2q+WTLTQ6FZQ9LX+6WmEy?=
 =?us-ascii?Q?wini2ga57J5KF5AgizFIsongfQdPTU9ELjtKD00luNr9s/AtbeWkkaa7nnqF?=
 =?us-ascii?Q?SeiEvkHASHH79yCBuLjGQ7ILaKfxqPADmcDIRGv27ar1eVxhtnxEyzSXc2pB?=
 =?us-ascii?Q?fiLfMv+i8hSXjfe9ho/i3rkce7KPiJ0/CFykvJYX92QrzyS5aHOZ/p8f8Min?=
 =?us-ascii?Q?VJXw5e63B0MS+ZWP+vama6mDg2/VMeBZSKhClrt5zwR0VDAK5qL9aise/b/B?=
 =?us-ascii?Q?RkOX3/yb1fKtHMKuHY99jSCGM073WRSbwxh8iP75dZpNJneNoiU1923n/RKm?=
 =?us-ascii?Q?sxPZFyxHrND9GRgnr9Ms34Q9Qz4GVFIisrlYgu2Ofdzm6SSBuwSwyK3XAxnX?=
 =?us-ascii?Q?05sS2DfOuET341O2DCKh5wNtrO3nYVx6xFznF6yHWxG2PsbuYIw3ildf/Zv9?=
 =?us-ascii?Q?HvEfqoEqExt5bhl2SmEraSLZ5wd3PDPyhUe/YxEnZwglXwkOqeNnwSMuPW2z?=
 =?us-ascii?Q?yZQrvpH63N+eeHzM3TfVEek4IMbW2A2nLXd8UPdjVCxPaRPDML0E0trJAEWC?=
 =?us-ascii?Q?7LFkBxSu0LJMP8G3K6r9sET1TTAqP+Kh6Y8WW6edrD5vtVnATZs3K8wWlUrh?=
 =?us-ascii?Q?vvwvHlbaSI6xXQf7owdsbknhQx2o71vZW07fZ2ZV2ULJpEMiBcbkkHRMKToa?=
 =?us-ascii?Q?uAYIGCOMgd+Dsw4av32L/hHMITfa9LGngx7/55zDP6aYrY5BZBwCuq/5TvoJ?=
 =?us-ascii?Q?EGghqiy3hN1dgjAJjIZnqxNvE1HlKaStNUOA6sRBzB5sL0nlv0jvbEoJR+ps?=
 =?us-ascii?Q?bNbTxgP9WdyLGw/NWJJxGw1klqPtDnB/WE/1V9QEKDmrw0Yib5py6fUun8QY?=
 =?us-ascii?Q?27R5AiCKP+3I/fbFb27APlgE3A3o4ZUKk+mVTxWYyMkDBeuYjtlpIosJCchf?=
 =?us-ascii?Q?5m5LDa0MWDsocfM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:34:12.7089 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d17ef47-7c12-44f3-2a68-08dd6863ec15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF8845FFFB
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

Update feature list for smu_v13_0_6 to show vcn & smu deep
sleep feature enable status

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f2837dadd897..682646068000 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -231,7 +231,11 @@ static const struct cmn2asic_mapping smu_v13_0_6_feature_mask_map[SMU_FEATURE_CO
 	SMU_13_0_6_FEA_MAP(SMU_FEATURE_FW_CTF_BIT, 			FEATURE_FW_CTF),
 	SMU_13_0_6_FEA_MAP(SMU_FEATURE_THERMAL_BIT, 			FEATURE_THERMAL),
 	SMU_13_0_6_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,	FEATURE_XGMI_PER_LINK_PWR_DOWN),
-	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DF_CSTATE_BIT, 			FEATURE_DF_CSTATE),
+	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DF_CSTATE_BIT,			FEATURE_DF_CSTATE),
+	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DS_VCN_BIT,			FEATURE_DS_VCN),
+	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DS_MP1CLK_BIT,			FEATURE_DS_MP1CLK),
+	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DS_MPIOCLK_BIT,			FEATURE_DS_MPIOCLK),
+	SMU_13_0_6_FEA_MAP(SMU_FEATURE_DS_MP0CLK_BIT,			FEATURE_DS_MP0CLK),
 };
 
 #define TABLE_PMSTATUSLOG             0
-- 
2.46.0

