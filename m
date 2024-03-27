Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C775C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 11:11:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2239210FA1D;
	Wed, 27 Mar 2024 11:11:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="19II69Sw";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EEA110FA1C
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 11:11:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF/bXgf9tNgnKKBWSwdhlURP+JXKfCyOVU8yXHG02gFe4Cl2ieWCq43s/1z8GkeRyh1g8V5NEmXR5y70lYQ1PDPeBQjEKDFcnJ7G1WAMgvNFPzIfFp2CDYpQmEifooVtCY9P8HCdqJi5Iq48aVPqTK9r5dIA7qcYgakJPsevAqHORdrg5Aywjms1Yfd/iILU45a3zN39YIhXNEvzwAJIaxYWaw7G2WAxmaXQOVjDrDoXA/lfoIRdus0Fzyy3lB/C1F2nNAAwO73WfXJjYGgVDUUs4Ku6A+hVhdSHqiDiMlPPipeZZVO31M+JwW1MTTGaAA/nbQ6sTY5mjUVf0KKWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOkz+cA9DqPiJ+iP7B9FwO8x34z+qoxIuAhz1yrWpOU=;
 b=K4MZi27nYub14t/Y4iU1lCQzquWe8xpx6rypqY+3MjVYuO1+iy+E7hDrP9QKeeRnXO3ybK6bMbZqXqhhVhD27krZ1Se7G9WNBXWaTX5HVmrs9VSQ3qspKSQ4Ir/SY6r81Wsd7f95rpi56om9UEmIL9QGGr2ahGrbfClLSo2f1eYNvRs47a7IfAr+tnyuyI9uJatZEOpSNtUY3SFud877GMzbfpkNpvxCJIdkMAozQz5hQU7UcWIeQpcnDb9viLCT1s90RXBSGdyDBqKVkXRaDnM/+J5/KOeRCU549R1fG0DudqGSxCqvtmWTvfiSiwpDmsV0YJ3ja2Ob9tRrHqmAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOkz+cA9DqPiJ+iP7B9FwO8x34z+qoxIuAhz1yrWpOU=;
 b=19II69Sw67YIjgO9s49TDiWmvaimM/ZPgRbdDFvSGMgszoTTZa0NuJEJZi/Qu6g9UAgZbUW4iwmZI/l3C1xHyndGX860uYDqJNIFPABaB3dq8XK83D0Y6PBEQU95dnvLNAlUdFXHmY+CcmF7zbCwwu2SIvfKZFlagfK87Od7nyA=
Received: from BN8PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:60::42)
 by LV3PR12MB9185.namprd12.prod.outlook.com (2603:10b6:408:199::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 11:11:27 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:60:cafe::52) by BN8PR12CA0029.outlook.office365.com
 (2603:10b6:408:60::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 11:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Wed, 27 Mar 2024 11:11:27 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 06:11:25 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v3 5/5] drm/amdgpu/pm: Check AMDGPU_RUNPM_BAMACO when setting
 baco state
Date: Wed, 27 Mar 2024 19:10:09 +0800
Message-ID: <20240327111009.2994297-5-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327111009.2994297-1-Jun.Ma2@amd.com>
References: <20240327111009.2994297-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|LV3PR12MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 392e51d3-98ed-45e0-3c90-08dc4e4ea5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWxQPASGtqKrC+igvsqPZPF1IN1ooSmlKSD0VDNbFq1ubMDR6m2Am5YCo4IZmVNqIqQ/M/5OCodOXufJIiXSAYyrBY6tks3Ha2Mhv9DkG+mWGunvzk9w4Ynj6rSUZ6ziDEYoKqFdhgQbhW21yElu8bc/O2oM0IWrsvc0IP7WUxPc0AnwkCkoCIyRAdPqMgfMTWr51eHlYxOuJYXxiZaAd8pbvqTbSqOiRfZ4lCbp/MYgJkQrEljqpHQ7IakPkVBe9omozX0pPFO5tk71LcQXOLkJYc7fcagKr5E41ufOeZU0ggpLay0NibCDNfOJuiOvTNRQ3eP9f8MY3TlZ3ppFjAQn4KOUj2TMsW7rPnbQLN4ORWk+mAvetX24bswAM65A9tM6tbAILKrCNkThBMZ01B5BNIjvvCzEddyV2mgiTS1ZDwc8g7tgpdEMadCQtEYvTQStqzzuRFKppFpbUpYNCWB7J5EaXwH51BnsNjCY3PgqHf4V6rahoDlGDhcYW8RgvDgG1y/yp3gWyrK6UyIlG9KWY5r6tftEmRbJwTVl/BNMMG4JBy14MZ1YZmUJyGrIh1GXsrFpG7wK/lQ8+A5FJUtLvaNIjk91SFUF/0GGPoRxOZphQtNxA9JdOQa+uBRmAn5WVtUFWhm6bGv5J3A2iK/xPjPtJTbA7JhJcVfdnAw1FcWs601k7aH/zi5OAUoAfqL9mmPvRPqSGZ70j87Ki3vUrawubbd1eA0mAFNmv8TvHBMsQGbqejMJ7KeyTWXa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 11:11:27.7371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 392e51d3-98ed-45e0-3c90-08dc4e4ea5eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9185
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

Check AMDGPU_RUNPM_BAMACO intead of amdgpu_runtime_pm
when setting baco state.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 5 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 8407ca4fdc17..9d5ab2ea643a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1607,7 +1607,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		case IP_VERSION(11, 0, 11):
 		case IP_VERSION(11, 0, 12):
 		case IP_VERSION(11, 0, 13):
-			if (amdgpu_runtime_pm == 2)
+			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								      SMU_MSG_EnterBaco,
 								      D3HOT_BAMACO_SEQUENCE,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 7277cc72d7f5..a8d34adc7d3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2247,7 +2247,7 @@ static int smu_v13_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      (smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
@@ -2292,13 +2292,12 @@ int smu_v13_0_get_bamaco_support(struct smu_context *smu)
 
 int smu_v13_0_baco_enter(struct smu_context *smu)
 {
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+				(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
 	} else {
 		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index d9ecb1da24cd..76746b5392e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1633,7 +1633,7 @@ int smu_v14_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      smu_baco->maco_support ?
+						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
-- 
2.34.1

