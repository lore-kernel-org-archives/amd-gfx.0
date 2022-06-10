Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447F5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 06:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C286312B2B5;
	Fri, 10 Jun 2022 06:26:18 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D140F12B2B5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 06:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=innC1ws18F+BFioh8YYvg6GTpJnzmfIpCimaCkyQMvx3rDcmD+J15rIp35mN/L/LPfhxuQ4GqUFgP7p8vxQG4N3Mp670cbgg5yPzsTrbbNE74tEPRh45Bl0uN8ESjE0/5+9JL9SY1SQkrNCM2Wd3j+k+tdOyAGHaE1B91v8eolrOrlN8FSXLe/M4SccjRG9qgBDfwCp5AdienujLbwE/NVD4ORSY1/f+Dx1x+yhLG6juqSkeA3hahwRpRtwbSUl+vKulFbM6oET97FeShnI+EA9BvyJtehPRePAyAXM66VH7I/p/OG9UT/Pgr2ynodl/Q/QvtcjcXezVfNMbdD+3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhdF4j0hY0wChcKOeKPozwKGB8G+JCKDJQYU2/H0V3E=;
 b=SuBSqjzXEeZP46w1R8hA6xNbHDLNnqpV1BzYbhAcv/KtYCVGgewPW5DGwfJogUg+FThkFWE8PS8IG2CnKqg4YmcVSuPp01JMUiQn1LgmSDSfUk/glhNHyjhmySsSl2eRhxzAlOeogveSFBqKhMmiC8kbs9l9seA7dNqCM9VPeFd9J1PEbhtw1jyv6xyXK/PdMDtw9excsQd/Gek+Q5MYJW3GWxgcg3eXYgXTwS8OeMI/HoubtmFafc0gA2ZP0GRtsKiXkaTY0iiER/VTO5mQUrCDpTuPD/UMVoZ1Zbu1FrHN2PBFQXZNVCK2ASOdsDKv/9A8TxUitIoY3T7FruFkmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhdF4j0hY0wChcKOeKPozwKGB8G+JCKDJQYU2/H0V3E=;
 b=O7wEexT9QFko56hH7tLTkSKitIvAAyL4mAiYzGfwhnMBcUpDguXotbIoGKWOc90KjQ+SQHxS+1QVhR8gbgr81BK7s2DqeCjOHTpAhoajNbsTP3zLa4kcrUwfb//7GV0w70VWL0eGalQDFjpVuraPeSlSxce8+ONHLYt7BJ72brA=
Received: from DM6PR13CA0055.namprd13.prod.outlook.com (2603:10b6:5:134::32)
 by BN8PR12MB2867.namprd12.prod.outlook.com (2603:10b6:408:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 06:26:16 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::dd) by DM6PR13CA0055.outlook.office365.com
 (2603:10b6:5:134::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.11 via Frontend
 Transport; Fri, 10 Jun 2022 06:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 06:26:15 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 01:26:07 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: enable MACO support for SMU 13.0.0
Date: Fri, 10 Jun 2022 14:25:39 +0800
Message-ID: <20220610062539.3666611-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220610062539.3666611-1-evan.quan@amd.com>
References: <20220610062539.3666611-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f42b605f-d099-4df9-171b-08da4aaa1f64
X-MS-TrafficTypeDiagnostic: BN8PR12MB2867:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2867B94654E1B15D2BC28FACE4A69@BN8PR12MB2867.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wm2JIQKowR5+YuRk0B90uXrEH5Ufyf7Ux2Sz7JD/dQo+3f7tNlNTjBzaIyx1GDX6+kdjpieBWrmDKE+BEHJD7Gk+UDmtOG4C4y2k/kz5gbFulp0mdUPcWxVSHU6g/f9UdIarzKnIzt95SEVHT04xZEvw8Zzu1TMzbeMIPYkDNtIzuxsq6i8X3HiJuTBDMvLhqEVUgm3clfgxNY31s0PXo6QDOFgqum3uhihcIaTT2fryWL25lS93g8Jxy0ODKN0aQTMRKfxt/gef1vbK2CpWnODZLrqDO4gvmjH/a8dNIt0xQrR2i5AA6+F0ewOz9LrWve5I+s3GTQu4tShwxIoQ8406x18+7W4yRBo9CXHWC5QJ7e+rpldvjpRPUgiSGCvhoZvubYdpgys9Jdyts4Oh4zzgOL0lwsGuj2e5sTobOWWmAmpafFcdscR9StyN4T6o2vPU6i613Io0Af0hMvGjtA+khg2FbyE6eJPuuNxjuxzSxARqR7VaaFfYnP4BKlA+RtsGodRmnT3bNIAUoW8FOMhUDdWxgVeFAISCU5z+UswIMVS5eUVxyZGX9KkgF//3pern0FwzSzDWsBhW1K8zKFHSCfclLNcxY5MR3HITCoeD3O8sVdwtjRjIg51BFzoqXTWUxnXVJsdaVE9kIjHSUc1SCVWBCGC3aqczOIHUyM9A7LaOO9T7j1+5o5QQ7QfVEWnlZZHnLJqdUpj1U82qLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(8936002)(82310400005)(316002)(16526019)(186003)(26005)(6916009)(336012)(83380400001)(47076005)(426003)(2616005)(508600001)(36756003)(2906002)(81166007)(54906003)(86362001)(356005)(7696005)(1076003)(36860700001)(40460700003)(44832011)(5660300002)(4326008)(8676002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 06:26:15.6801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42b605f-d099-4df9-171b-08da4aaa1f64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2867
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
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Evan Quan <evan.quan@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable BAMACO reset support for SMU 13.0.0.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I67696671c216790a0b6d5b84f7d4b430d734ac3c
--
v1->v2:
  - maximum code sharing around smu13.0.0 and smu13.0.7
---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  3 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  3 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 52 +------------------
 3 files changed, 7 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index fba0b87d01fb..f18f9605e586 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2271,7 +2271,8 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      0,
+						      smu_baco->maco_support ?
+						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
 		ret = smu_cmn_send_smc_msg(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 495713e4ebd4..6fb2b072a730 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -325,6 +325,9 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	    powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
 		smu_baco->platform_support = true;
 
+	if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_MACO)
+		smu_baco->maco_support = true;
+
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 693bb6bda350..96ae5ff8e19e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1551,54 +1551,6 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 	return ret;
 }
 
-static int smu_v13_0_7_baco_set_state(struct smu_context *smu,
-			     enum smu_baco_state state)
-{
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	struct amdgpu_device *adev = smu->adev;
-	bool is_maco_support = smu_baco->maco_support;
-	int ret;
-
-	if (smu_v13_0_baco_get_state(smu) == state)
-		return 0;
-
-	if (state == SMU_BACO_STATE_ENTER) {
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-						      SMU_MSG_EnterBaco,
-						      (is_maco_support ? 2 : 0),
-						      NULL);
-	} else {
-		ret = smu_cmn_send_smc_msg(smu,
-					   SMU_MSG_ExitBaco,
-					   NULL);
-		if (ret)
-			return ret;
-
-		/* clear vbios scratch 6 and 7 for coming asic reinit */
-		WREG32(adev->bios_scratch_reg_offset + 6, 0);
-		WREG32(adev->bios_scratch_reg_offset + 7, 0);
-	}
-
-	if (!ret)
-		smu_baco->state = state;
-
-	return ret;
-}
-
-static int smu_v13_0_7_baco_enter(struct smu_context *smu)
-{
-	int ret = 0;
-
-	ret = smu_v13_0_7_baco_set_state(smu,
-				       SMU_BACO_STATE_ENTER);
-	if (ret)
-		return ret;
-
-	msleep(10);
-
-	return ret;
-}
-
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_7_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_7_set_default_dpm_table,
@@ -1653,8 +1605,8 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.baco_is_support = smu_v13_0_baco_is_support,
 	.baco_get_state = smu_v13_0_baco_get_state,
-	.baco_set_state = smu_v13_0_7_baco_set_state,
-	.baco_enter = smu_v13_0_7_baco_enter,
+	.baco_set_state = smu_v13_0_baco_set_state,
+	.baco_enter = smu_v13_0_baco_enter,
 	.baco_exit = smu_v13_0_baco_exit,
 	.set_mp1_state = smu_cmn_set_mp1_state,
 };
-- 
2.29.0

