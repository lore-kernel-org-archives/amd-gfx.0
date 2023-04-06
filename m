Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23866C761A6
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 12:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7D710E310;
	Thu,  6 Apr 2023 12:45:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8C010E310
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 12:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DefM3ayjGII6IgpCUtQ4E+P+zG1AJUnjlfH8kIi4uKgKAIcJdvEXps/lzLe6RUHequU83FSpzNmB++3ai/MAke/HkNxF2ucz5OvpmG0Re8mMxEL4Cl8Qpj5uYymAhmwqiDCtnv8uJrsvydsnRN7n/Aux/BkD34Ywa4yrEv8aRRal0cyDGPpow12cFXuoAex7ZhwlzBfru2uPekHop8KVK7QteNS7/6ux3yxpNm37yCuzwqEgnqincQB9O7WZQeK4rFDHkBfqk9Z51ZNDm+HCsrV2vwMJLzURMAMvyqKWnCZ6wROVPd7fq5VZorr3bgHVY7NjDH0vL20gkT+7aAKTlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkBotXHQm1XNIfiD14p4LgL7L5nXNr+iCbymId747Pk=;
 b=PkmwlkbzliDlRBIIc0gpb6bSOG4hTkS+6xowpi73knT3x3Z3ANRVC3Ms6naj/sq/y5MXvhHbS2cBtSLvsNDmqxPe1ZcHW8ZOyqy592AxMmuzPMJXGYJUhQSBa/Sg+QD/MXx1EsLT+kWuYYwVSNxXSLBcG6LyW0xk6+gmHMFwFgLlpdfQOj6p+mO8IcIIgkQiqXs/bJE9oKHgt//dWcKYbgHhJcz4k0ZW2EPgJa89Lk+S+4pflRT0FitN735aCAv84KOmAkIx/iUXbRr9TLN8Dls2G+ypt5lJg9d8sqJT8kNTEEJKRY47REesM0ZSqx/Iup6oBkD35cdkWJ4geM9iVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkBotXHQm1XNIfiD14p4LgL7L5nXNr+iCbymId747Pk=;
 b=iGgvCKQ8cOYb7iBwJY+NimZ8+O4xPO8YjUpC8S0GPryQhdMMI2bO7xYACCXER3cDIJrnwTgEX1zIl0KRm+g9+YTjC/7UvZZaUm/9s9UQbHcBbTvB4TEFesqHGlaQFwwJglOWcUi3P0tb8nWRCJZ5Y2UEKOqHizpfWm/DalXfuuA=
Received: from BN9PR03CA0325.namprd03.prod.outlook.com (2603:10b6:408:112::30)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Thu, 6 Apr
 2023 12:45:24 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::5c) by BN9PR03CA0325.outlook.office365.com
 (2603:10b6:408:112::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Thu, 6 Apr 2023 12:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.31 via Frontend Transport; Thu, 6 Apr 2023 12:45:24 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 07:45:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 05:45:23 -0700
Received: from archlinux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 6 Apr 2023 07:45:21 -0500
From: Wenyou Yang <WenYou.Yang@amd.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <Xinhui.Pan@amd.com>, <evan.quan@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH v5 2/2] drm/amd/pm/vangogh: Send SMT enable message to PMFW
Date: Thu, 6 Apr 2023 20:45:14 +0800
Message-ID: <20230406124514.2906870-3-WenYou.Yang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406124514.2906870-1-WenYou.Yang@amd.com>
References: <20230406124514.2906870-1-WenYou.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT010:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a1ca40-6bdc-4035-55f2-08db369cca7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diOax6CZ52vr2ZSemL/dU+Mwd7ssKpnh3rBmG/2/8niP5COR5fL4AWeGM2bR1AUCtjGqXiYyMTqnXMKyjeZ0uDMh12SitS+c4KmgboOqd9+cNtbvaWF+ohfZfo/xUEQe9cQI+FmKTvaxIps5bd1dMYQnlO4QwWMK/qGe1gLpLlxLumG5NW+XLEP4Mcpin8tBmulryFeBGYGBG020ucanjsoJcloe//OQhhPkIh4ICDTucwOluVEM7rNrxynT0a47VndvkZj6iGRG2xO+GbGVF8cMCDFbRbkNz25TaKLYjcoEZzKxJO1HwG9kBO8ZLa0wvKkcoCto+PARf5IWuD4gVIxv5v1SvJzi3rQ9N+2bYl/QIB+AKwRSyZPH2jAb6Vdq3PT+KeVgANGwq0Obxg/JOKT4xErIzqp2RoTqOb0e6/6yLp4hFo++38h8SxnyWoQQ8RJxBVIYNn/FAxAl0QQKDGvtGC8+C66/I2OqPEOIMkWQIOO/i0htwzR/nk8hfy2wsWL5jYo5mqFPeixpm8tEKwOvG1JIDTbg4jWICmhc3Gm0D6Js7Q2aRsjMgWnyVj+7maH5sXGwTozrsrDOfUF4EaQkKxYZM9+RRGPG93edEGvHtQdTJW8nebGJWPRuhBTfl2Rsr5TZgOe8eKhQ2e714C/AHcnfi7eoatdsmEiDyZZ/6TYJKxr84w9UroqynpOgjnm3W/OT8NZjq9/U4hkGy042N2xmygOwUTYXd3K5hYo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(6666004)(36860700001)(2616005)(336012)(2906002)(83380400001)(426003)(110136005)(186003)(54906003)(478600001)(316002)(7696005)(6636002)(26005)(1076003)(47076005)(15650500001)(4326008)(36756003)(41300700001)(40480700001)(82740400003)(70206006)(8936002)(81166007)(86362001)(356005)(5660300002)(40460700003)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 12:45:24.2401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a1ca40-6bdc-4035-55f2-08db369cca7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
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
Cc: weiyuan2@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 Wenyou Yang <WenYou.Yang@amd.com>, kunliu13@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the SMT state is changed on the fly, sent the SMT enable
message to the PMFW to notify it that the SMT state changed.

Add the support to send PPSMC_MSG_SetCClkSMTEnable(0x58) message
to the PMFW for Vangogh.

Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 32 ++++++++++++++++++-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
index 7471e2df2828..a6bfa1912c42 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
@@ -111,7 +111,8 @@
 #define PPSMC_MSG_GetGfxOffStatus		       0x50
 #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
 #define PPSMC_MSG_LogGfxOffResidency		       0x52
-#define PPSMC_Message_Count                            0x53
+#define PPSMC_MSG_SetCClkSMTEnable		       0x58
+#define PPSMC_Message_Count                            0x59
 
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
index 7433dcaa16e0..ca1ff97f3353 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
 	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
 	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
+	MSG_MAP(SetCClkSMTEnable,		    PPSMC_MSG_SetCClkSMTEnable,						0),
 };
 
 static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
@@ -460,6 +461,7 @@ static int vangogh_allocate_dpm_context(struct smu_context *smu)
 
 static int vangogh_init_smc_tables(struct smu_context *smu)
 {
+	uint32_t smu_version;
 	int ret = 0;
 
 	ret = vangogh_tables_init(smu);
@@ -477,9 +479,24 @@ static int vangogh_init_smc_tables(struct smu_context *smu)
 	smu->cpu_core_num = 4;
 #endif
 
+	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (ret)
+		return ret;
+
+	if (smu_version >= 0x063F0600)
+		smu_smt_timer_init(smu);
+
 	return smu_v11_0_init_smc_tables(smu);
 }
 
+static int vangogh_fini_smc_tables(struct smu_context *smu)
+{
+	smu_smt_timer_fini(smu);
+	smu_v11_0_fini_smc_tables(smu);
+
+	return 0;
+}
+
 static int vangogh_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 {
 	int ret = 0;
@@ -2428,12 +2445,24 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
 	return ret;
 }
 
+static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool enable)
+{
+	int ret;
+
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetCClkSMTEnable,
+					      enable ? 1 : 0, NULL);
+	if (ret)
+		dev_err(smu->adev->dev, "Set CPU SMT state failed!\n");
+
+	return ret;
+}
+
 static const struct pptable_funcs vangogh_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.init_smc_tables = vangogh_init_smc_tables,
-	.fini_smc_tables = smu_v11_0_fini_smc_tables,
+	.fini_smc_tables = vangogh_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
@@ -2474,6 +2503,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 	.get_power_limit = vangogh_get_power_limit,
 	.set_power_limit = vangogh_set_power_limit,
 	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
+	.set_cpu_smt_enable = vangogh_set_cpu_smt_enable,
 };
 
 void vangogh_set_ppt_funcs(struct smu_context *smu)
-- 
2.39.2

