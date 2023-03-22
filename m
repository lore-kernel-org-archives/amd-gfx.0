Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2803C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Mar 2023 05:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43E1710E279;
	Wed, 22 Mar 2023 05:48:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2660110E299
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Mar 2023 05:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJio4rCG41BqoBgO7DVaysJWfkFrO/zJ/cU+mrDJYIa3F3Svjk96PbM1dTzvJrVfyZvhC4JGHbh3dMfUigwPHATaa5v17nVyZd97Qjh4OrS4CcLzm8nwobkjzMwrP1vqBQN1mJKZo/blbH2zqGwiG0VF/vHh/EkRKX/XkpYHGNOpmnK81EUMqu+VRrQ3BObX/shst+JkJ5I3HX2E/iEpwSl8M5OPyPbLImVRCRjTfbOE3LePSlhQXWokW9tBJ+Z25I8fCuvAmiQD2Bwv5Wk7RPcJEj/aps3U23lkFxNfwXJs+5QZQTKUnWJaTaTMfPdlYm5Wg3SS9aFweBf62ecUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uib1Q83WH6fKzOEibd8vbfqsde8Vfj31/mJCiiCk1cY=;
 b=FndPNrjuUxNweZpi2DL02jfnUbbxWHXMbIHLaYjoRnjaNbnjJcjRrGvj8QUgCYRv81ooM4eOW2uItinfhspc155bi/+mRBYIcKsC/B8lxoy7vz2kixM8RKvyodM42Af06hUgcDOoZkJjm+OHeWMXI0sb0wGDDV3yAMfZxTiqwSYMJYYMD7HrBsWIc9VJBdeNVruwofzKdcnBM8ygoRCwzgKKwwvJfjFH0IZkVltxzwetvlBvizmNBgm4u2WRrQT2FMR3zQDYgglFlGoPknQp8unOw3g5nDzHWNLypArX5vlppl69LM8B78DNglWudUS1M2IBRwF4toQiCGxyRTP//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uib1Q83WH6fKzOEibd8vbfqsde8Vfj31/mJCiiCk1cY=;
 b=0Ysz0g+dW8v4YFRbemuyi89mktbmP4DVyzw1jrYgFQwhXmDG11GJxnKTlQ8tbqxZmVpnhEMIZpBBHEk3nFl9eaU320LBaxdamUS0XHCe1GCFe7HsGW6IV94mLba5mGvIFj7nLON3nM9vg7ynp6hwCqnz0fNqHrtTiGkBeYvHDOs=
Received: from DS7PR03CA0298.namprd03.prod.outlook.com (2603:10b6:5:3ad::33)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:48:29 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::e1) by DS7PR03CA0298.outlook.office365.com
 (2603:10b6:5:3ad::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 05:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 05:48:28 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Mar
 2023 00:48:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 22:48:19 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 22 Mar 2023 00:48:17 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>
Subject: [PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT enable message
Date: Wed, 22 Mar 2023 13:48:08 +0800
Message-ID: <20230322054808.1555230-4-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322054808.1555230-1-WenYou.Yang@amd.com>
References: <20230322054808.1555230-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 235d74f0-ea30-4198-fcb2-08db2a990fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8BYkR+chBLeTijNxyQZa/b3bQVYOciVGEK87S5vIdEsXJat4EroicVirAQus425+4wEQnJ7nfSpdLwJ0b3RzTV5xb4N8eWi2FLh21Qty8WOzmooAXYOIir97e6I6hWZfEWXVyZwRP2W9/3puIf03E0pPOe6LeQVy8BATgxAkHY2fBrCbmvDaz0IasfqsAtbNZhsV8KF4svB36WOPirZiqv0pCl+x4sxfO1m67z8OnoHhtFp/kpO9b1wCrhjUadRkpX9fFz/cOwwNGPlpihWyPN9ZwTTR6kA6cQXt7UaV8zX2Okz6dp3IyA/gU5sEXYvrcabdz3BUvm7kcqRTdUvDuAMn5clvYUlILooilUUH3dTntG6uxgwV0mVZP6AQIyhGScJI/05LFAiLtv0xh0AKrIqOIzj0YuGAwcYAwMtYW2IlOTrncH+hlyrA2qZAXRB/ZKyO+16isk3ZJJ4OlmLICLqi4LZnQeFV2w8T8PNyepZactPFW2O4a3qmPa5OpB792syzUlmo1ZqBSHlpWBFBRg0eJQh6h9fILNdyRzp1w4qZ65yQhAxiSlxNkG6mTSj4Onaj9fd6/lEe6QB8dgOEpx9xdy12l5TNDirz6mq5rKCHteVEqFXMEMUvo/JaAA1M5blN510BvQCBIlPGGAy/JeoatPlnQo5xBqhNFKo1Us7p04wUZ00lMLBD8jKNPg7L+f+yDGKPPCs0QYEUxZ2uH5X0WjYdXLGsizbeU+CZFM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(2906002)(15650500001)(82740400003)(81166007)(356005)(426003)(40480700001)(7696005)(40460700003)(478600001)(83380400001)(47076005)(86362001)(36756003)(82310400005)(186003)(54906003)(110136005)(4326008)(6636002)(316002)(8676002)(6666004)(41300700001)(70586007)(5660300002)(70206006)(2616005)(26005)(336012)(1076003)(8936002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:48:28.8024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235d74f0-ea30-4198-fcb2-08db2a990fef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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
Cc: Wenyou Yang <WenYou.Yang@amd.com>, ying.li@amd.com, kunliu13@amd.com,
 amd-gfx@lists.freedesktop.org, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the support to PPSMC_MSG_SetCClkSMTEnable(0x58) message to pmfw
for vangogh.

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..2b182dbc6f9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -111,7 +111,8 @@
 #define PPSMC_MSG_GetGfxOffStatus		       0x50
 #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
 #define PPSMC_MSG_LogGfxOffResidency		       0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_SetCClkSMTEnable		       0x58
+#define PPSMC_Message_Count                            0x54
 
 //Argument for PPSMC_MSG_GfxDeviceDriverReset
 enum {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..820812d910bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -245,7 +245,8 @@
 	__SMU_DUMMY_MAP(AllowGpo),	\
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
-	__SMU_DUMMY_MAP(GetMetricsTable),
+	__SMU_DUMMY_MAP(GetMetricsTable), \
+	__SMU_DUMMY_MAP(SetCClkSMTEnable),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 7433dcaa16e0..f0eeb42df96b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
 	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
 	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
+	MSG_MAP(SetCClkSMTEnable,		    PPSMC_MSG_SetCClkSMTEnable,						0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -2428,6 +2429,23 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
 	return ret;
 }
 
+static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool enable)
+{
+	int ret = 0;
+
+	if (enable) {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetCClkSMTEnable,
+						      1, NULL);
+	} else {
+		ret = smu_cmn_send_smc_msg_with_param(smu,
+						      SMU_MSG_SetCClkSMTEnable,
+						      0, NULL);
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
@@ -2474,6 +2492,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.get_power_limit = vangogh_get_power_limit,
 	.set_power_limit = vangogh_set_power_limit,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
+	.set_cpu_smt_enable = vangogh_set_cpu_smt_enable,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.39.2

