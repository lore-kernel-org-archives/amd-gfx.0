Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820D9C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15C4C10EA3F;
	Tue,  3 May 2022 20:09:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46EB10EA21
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuQky0Lp2kBkG0VBRXeysR+zSqbQM+xT3gyiziXHAFUvg00plhabzy1661dH4BZq9oaMDqrS4CgjjJxlhg78nE6YvHPf8n2TFq5tvN7DI0Hk8n5zlJgId5ptQibsrr/7oZQ13vX/4iKjATE2Dixoo9V+zbiVdrMESnK9PVtYTMlaWK6a1R7v+yGVnRo589bBuQepajwgRu/HPabnKKWD+43zVCNzos5MmU/0vYvmpHDjLO8/Lxepvh6Lcvth61z6FPFRdsh2xoFC17EAQgRs1+kSut8CrcDFy6dL88BZQvHjpWxkhtwWDD1ajabXX050IePUX+M6LVWdDhspwoW7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CztX9GOSi4zr5R/HC0d8OMfmA6yvNsZ9Vd/LEWLGVw=;
 b=gHWqaJ1Hb0A8WTlcrpDZJfcVoq8kUldMFKRR6jyvAE+XnZJyz/8dZvhr9e+lRTbqQ3JW49l0XGBXTh4HQa92Krb0NEcFIyzu9cHLVx82IHlELBy4WDzf84OR1t4SU+f4R0ChlGohszz0FvVYa8sPf8DUa+Kjy6OisqemN9DJHiQwvpOircSXfYDsEMFCP7zSszLaHLdQm0jCPFZK8sJgnVNF/SCtHw+rBWLFv+XzDbQIYO8xwgbBVU9sRlCtHJB6O1ovKhuSWAlnwyVlefU8n0kT+chUZ/X4EhgnTvS18edyxhr6WfWGrBiaf2gJVGFoBOre60KNzi/lRkSd0/DJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CztX9GOSi4zr5R/HC0d8OMfmA6yvNsZ9Vd/LEWLGVw=;
 b=hkon7fJz8EadPscrl0ebL0xS/2rvHkDpFpeUEUOn/3b503DxN4iwJXRbUspBT3h5nRsNXwanuq7nmh50DC/atehJtmTJkpqkLMZmnyb4sOWOEyF7hh27L9QNsVqj2vSBhDmKauDubMAYyYmYW22kDuDhAMSykV9VelYcywyr8jo=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 BYAPR12MB2615.namprd12.prod.outlook.com (2603:10b6:a03:61::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 3 May 2022 20:09:16 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::a4) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 3 May 2022 20:09:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:09:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:09:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable gfx ulv feature control for SMU 13.0.0
Date: Tue, 3 May 2022 16:08:41 -0400
Message-ID: <20220503200855.1163186-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200855.1163186-1-alexander.deucher@amd.com>
References: <20220503200855.1163186-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5ab8c24-d896-4e82-a796-08da2d40cc95
X-MS-TrafficTypeDiagnostic: BYAPR12MB2615:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB261583421863AC8B7639308AF7C09@BYAPR12MB2615.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAajFHC1VEvCjP0gWVfvhdxg8mAcBOOSuPtBTGD7e2IhOCq801fzWsrnj8HsAKmV7etARebe29AGcawWLJJsUfS5nY42rO3EHmOoc4fJd/gHUdn+8EJh0gDmTcLCwIqvz4gheIlKXFw89lwsDu+Q3GUP9AfoAfhvauJdbBUyFpt8jYlZNVtUaX64Kp9/zN/4+/qYW8pRiZ2wHrTkUyDlZy+OQh/bs+N09b5UVO1BP/g9PRw4AcGzxpqDyC/nHpDTujVjKv98Lh731pNAs7PPDp2VgsokVVClewtB90BpW8lOa1PgotZBRGG4OBpBnIJtxRTgbBBpajjlhm4d8pr11E1hpuBLOLL2SHwJu3oeAUV0JVMAjUOHOIMzfcc/KnUyJxyVMydKiXTsO5L/RWmtSPrQKgmQ7Q7ftQI5O/cFjLk0VQ4LVRjucybr25afssrkZL7TpxtpDD86MEV/0KEXo1OucJEBfjpoBkTwRb4ZtqIvw1JHHy0nCfyrPSADxu4pKC5rEntwEmyPAmKh9/XVQbJixdUx51RGVgArvNCVaYaRJtxMo2598atrjgXBXKyfEyH+ZfP6JtiQxRAHsJkGJxfNjgHC2B84SVaf0/RSt6X3YJaLfq3D8np6aO3mwFOwSiSyK6oC+t/MZY3pRgOrh2AUszbBAFYfhDxBBZ7TShYjup4JebPXQ60TSqX78QFruTEy2F7+M2/hdkPX7KFq3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(508600001)(40460700003)(186003)(36860700001)(1076003)(70586007)(70206006)(8676002)(6666004)(356005)(16526019)(26005)(7696005)(4326008)(81166007)(66574015)(47076005)(426003)(336012)(54906003)(316002)(6916009)(2906002)(86362001)(5660300002)(8936002)(36756003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:09:15.8769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ab8c24-d896-4e82-a796-08da2d40cc95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2615
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Fulfill the interface for gfx ulv control.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 11 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index e33686a12df2..39b51f7a2c1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -278,5 +278,8 @@ int smu_v13_0_run_btc(struct smu_context *smu);
 int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 				 bool enablement);
 
+int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
+			      bool enablement);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index da458e146252..4729cdcdb210 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2184,3 +2184,14 @@ int smu_v13_0_deep_sleep_control(struct smu_context *smu,
 
 	return ret;
 }
+
+int smu_v13_0_gfx_ulv_control(struct smu_context *smu,
+			      bool enablement)
+{
+	int ret = 0;
+
+	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_GFX_ULV_BIT))
+		ret = smu_cmn_feature_set_enabled(smu, SMU_FEATURE_GFX_ULV_BIT, enablement);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index eda0f59f07ae..b410420178ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -149,6 +149,7 @@ static struct cmn2asic_mapping smu_v13_0_0_feature_mask_map[SMU_FEATURE_COUNT] =
 	[SMU_FEATURE_DS_VCN_BIT] = {1, FEATURE_DS_VCN_BIT},
 	[SMU_FEATURE_DS_MP0CLK_BIT] = {1, FEATURE_SOC_MPCLK_DS_BIT},
 	[SMU_FEATURE_DS_MP1CLK_BIT] = {1, FEATURE_BACO_MPCLK_DS_BIT},
+	[SMU_FEATURE_GFX_ULV_BIT] = {1, FEATURE_GFX_ULV_BIT},
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
@@ -1580,6 +1581,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.deep_sleep_control = smu_v13_0_deep_sleep_control,
+	.gfx_ulv_control = smu_v13_0_gfx_ulv_control,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.35.1

