Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A917DC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Oct 2022 06:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44ACB10E0E2;
	Wed, 12 Oct 2022 06:34:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB73D10E0E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Oct 2022 06:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+o8e4qsxMFivZQ3FBMXcrjE1t3UsGA02WMf8lANWjVRWG+CvuY+vBzrB6tc/i/Wxahs1JihS7cF9NrLQ4VebtMumfF2IBXaTBEm7UQuCIBUSH5wU6m+A+UQhYs9nh0oXkUsjaG9NY/37P0OPkfK4pDqVlWCQ/PJ2jT4dI2L0Oora/DkdV3TApNuDicmg2L4/MK3mJHh6zPHFy4+bmp6i2ONodKeLnAkxoSU9HlzbUnQOpwQxxK3fBp89jzxudXSp8FsL3QMXN4oSrYWolz2z5yoJB5jXS/bycQZ9HgrHEU2bRniVfLPoBNkOueh7vCpYAN4aNRjZz7ebJZ+Bbyd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfKQZzy0iGJiJdt/urwms+7/kcwXKx73h0+kIfQge+I=;
 b=iSX3qdsFZOv74wOoMq1+lUBVduTk08xLycPGILlZ4mxopoipEn67V/j/BvKIvSf8Z9NNRWKWEuFOLIiqS4p8OeeaOkh6zSFqMv0ZHxZr/Oia/gOkvaCM/RUZSjkEIEWur4BmtORQ1wc6NyFXahyLGNRMHfuf/T1zUEy/LJbZryNEd622iFUis73/u3nK9FSiNNRwYiB/xxRFLvp0vR/a0ws1CZE63No4JWYdLuT4fXJqB5UQ6EWQWq4gWkyawnE2R3TfOn49KbKuHm7Ay++S8tSlfpjThzP3ygz170WCSRI8HI/IjBjj9e+mNikTdMiUVyYNbaExMVQdyXRUpbWM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfKQZzy0iGJiJdt/urwms+7/kcwXKx73h0+kIfQge+I=;
 b=PrDB3OAE3qCPK0+/MYFvaNyn7OQ8tJIsL25dqZbRrAX1t8EWT33RavK7qKafaf1k9uILButu3oafm5bXygMsLHGYYlSxeiOHDM8DO5yoWb+KawVV1db9MUgJvCfizXTXoA2frZQ0ecjoj16LuFtA50ZUgVZb605tUVIFx37XXCQ=
Received: from BN1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:408:e2::35)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 06:34:26 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::a8) by BN1PR13CA0030.outlook.office365.com
 (2603:10b6:408:e2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20 via Frontend
 Transport; Wed, 12 Oct 2022 06:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 06:34:26 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 01:34:23 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 1/3] drm/amd/pm: fulfill SMU13.0.0 cstate control interface
Date: Wed, 12 Oct 2022 14:32:53 +0800
Message-ID: <20221012063255.67878-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad4f58d-49a3-493d-eafd-08daac1bcf34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rpYQOzSCC+1ZInaoCdYHSuny5OlmhnRDa6yCEfEQh/UwUtiQckPIjdwf9RKM3p+tWZjo4AuvorrU891dabi8cm3p4kVRnFeESf9vJwGcX3mP2RXmjsiioiOgOzN7eSezP+TixRVgDllWRQgzQ3ke1/pMrKRtnL26UGKeTUvOdESrtJRb4UEEqWqMJ5Ed4wiyN+tO7tLA/zqw4zGch6uwu1OVvOcnR5aIvVTuJRrK7IsbdItA1gFQgIS2LtkDBXZ+QZkANXpEycsGnnufwGj5KX3x4HHsyAP8MrZnOfgGZulY2X+qiUFadSHCtzsZJCyVuvl3J/1kVxywyJBt4NcdDiq3zig05jNC0g4H0PfERpZlOjJo2/+qjGVP5QW64o6nMMqwg+yLPlpCAj/mkRM459ltiAV0dCH+UIT8fuHLUaPo5hZpdnHBrgaEwz1E0E+UNbLRGl2nhGBe94yI4mTv6w30v0EJzn+rzd1NODrwojuQaVJBzPI4t9x3eqI0vp+4x7kVp0MUht7GkCg1/iGpVeiD3g3/iCrDi7J+2gtiooBGcegTl7ljU7rY6M9K8Kk1ZdFvUxP/32C1iQztbx+SmHkuBgUapv3Auu/m3lUG4rGhwx0rRJ+6rVP1SBdA/6bhzx9xBGoDVWNF2tPZzCcxhGGrm84NwJZmBvi9VdGXUx8JgmnZTTTAe18EL5Ul/TYXOCfMx3qngNfTeRIrZOsoZCDwVtr7Z0VPg0PdjxwJQmBELlvcj/KwyXGtq/GIyx5ET+KfUm/HfitGqAb01pzSc3WGhRg1rtDQfKFQ1gDj04zQ87K9XKCGYUGNil6ZA2B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(81166007)(356005)(86362001)(40480700001)(36756003)(40460700003)(70206006)(82740400003)(36860700001)(4326008)(70586007)(316002)(8676002)(5660300002)(336012)(41300700001)(54906003)(2906002)(47076005)(6916009)(82310400005)(44832011)(1076003)(426003)(8936002)(186003)(83380400001)(16526019)(2616005)(478600001)(6666004)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 06:34:26.6480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad4f58d-49a3-493d-eafd-08daac1bcf34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill the functionality for cstate control.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Change-Id: I2b7253898503b8051bbf90f429b46221410146b0
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 1d454485e0d9..29529328152d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -119,6 +119,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
 	MSG_MAP(Mode1Reset,			PPSMC_MSG_Mode1Reset,                  0),
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
+	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -1753,6 +1754,15 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_0_set_df_cstate(struct smu_context *smu,
+				     enum pp_df_cstate state)
+{
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_DFCstateControl,
+					       state,
+					       NULL);
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -1822,6 +1832,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.mode1_reset_is_support = smu_v13_0_0_is_mode1_reset_supported,
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_0_set_mp1_state,
+	.set_df_cstate = smu_v13_0_0_set_df_cstate,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

