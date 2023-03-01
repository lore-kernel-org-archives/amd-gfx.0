Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AC5C64ED6
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 06:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AAB10E18F;
	Wed,  1 Mar 2023 06:10:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1790E10E18F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 06:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgtrGgz+CGZD70wCkhpy7DBgtnvrrU4FvXB6jBNUBrwa79WSIickJfkoex4tSmOMLcpvc7qwqRaCYw3+UVI2d+q7u3X6V9/Zp9fm/iseevtGd7CMcZfdN1VKyNcREoxWG4NaObs/uj1akH1OZ/nCrbcx/HUxn7RQ3Z1B81khOerpXROy2TNKCerjZf1iwc+b+GJ7kWJnwhyGiOHF4wQjovSZrYtFqzZoRKihTRWD/SVmb4ULtLb6eTyxqD7GT5G2o7oa/xpKF2i4sNE5QKqV8GJCqxdf9dAlv5mwwSE7aLGLMA+Fy0vXi8y2/cE34UXw0MZiSMKC0TV1yr0pPneMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZvC9by1teErO4s26VN38OdUOl8albUxHIas71OxI04=;
 b=kzZ+ND5koEhu4erAj2cYd2pDNP3rZqeoZ8HlA/j1TyGPtpjcPE/M78eBSTBqFMwwBZP/YkDs57kyxQ6QVRntKiMOjUh6UMgmw5H7/M93dZ+3x6AbFFvkS/XKNqWU7DY6kYQFuBEyk4AnYltdA08FwTM2vseWuvUwSPZvPGu+iaC8vYBeaZjede5Poqzyl6F9YFw3p8JWN65W5gWwa1bpODtK97zImiGinlVmePoHMPzGf8S0pA2A8Gv4gsVt3MViKnG//j1IFIE+n0ylm1UKKATmCjd67r/UtD1dGo+qvgI0wosPi665auoBP7gXSHLfsi8sRU8TmvzzFKR9XiuYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZvC9by1teErO4s26VN38OdUOl8albUxHIas71OxI04=;
 b=HhKerSc/HPmDUkbC9kF89usP+QOvpSojJAcF4iSUc6b1kTWPHuq81QJvt1O9PSkLkGH+maF4IZVyB8XYXhnMiSLxGyg5LhG3hWILYtsoplueuEZxprlvEuTbkESgXy0mzm6ObWfki6LGghyfQzRXpeob0UQT12GZ9HOvWiiufZw=
Received: from CY5P221CA0123.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::18)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Wed, 1 Mar
 2023 06:10:15 +0000
Received: from CY4PEPF0000C981.namprd02.prod.outlook.com
 (2603:10b6:930:1f:cafe::21) by CY5P221CA0123.outlook.office365.com
 (2603:10b6:930:1f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 06:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C981.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 06:10:14 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 00:10:13 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Enable ecc_info table support for smu v13_0_10
Date: Wed, 1 Mar 2023 14:10:01 +0800
Message-ID: <20230301061001.16542-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C981:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: be6965b2-82b6-4696-132a-08db1a1b9fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tsy1t8LHzliuqKi2Az6H83RLNA4nha7MDbtU94Pw38C3ARTCk2njmPpl3ILMKIHLAaFulyxS8hrDzOqE5xKN+Bge6dgebid3zUbtbcadDx21I1ETx5JSaYll9pud6nKVd1ccWUym8BYCHD3wSYME92V/PaSPsUhf4xazobPzG6DXGY/pjDmiUkaUBbArlLyRbF1hCPpOntKVV+jbx/+UiYDj7Y0mBCn537PAbMsSFeRTp/pMQE4AgeaK2AO1dC8v19HKxO8pmJyiGj4RE63qTOuZzauQnVmHhm2P1FgSKhfCftmAEdTj4Oa6oiD0HTLl8PkOeyEmSAor4bJbJxFmMW8jthfZH2zOJHN6Wq2l7LXbwODas1GLk1saRq9jCnTw+wInWs8Prmlja9U/ZElHOPQyPGNnLw5NkEWyRp5qaURDwKHYPFVbrvflbXYsWkWQzfQYNdSYv6YaZEvaMSVgFX4xRuEJouqTBn4WsP2i3aYDT24RKfvkmroRG7mG7QKl5GJB9BJKu91SoiLE+lwtooR5b3UNfeiUyaszhuJXvW0pvhEkOjGZCI3Xi7yAY2Ltwg+2ACfJ3NwFaOLaqokNlg8wVV5KamTPOXALFhUvbM2eg2C2VGpaeXeQAtQ1F4Erp3vP/3Y/UCEfTNoJaJ54enjzjRGKveyydlD8zrsSo+6DuMB+beOXUMMN7CeseicnoeF1G9nh/mh6arjgvBNpYMdKg3TInJk8aPqDaKuUIOw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(36756003)(40460700003)(316002)(478600001)(2906002)(7696005)(8936002)(5660300002)(44832011)(70586007)(8676002)(41300700001)(6916009)(4326008)(36860700001)(40480700001)(82740400003)(70206006)(186003)(86362001)(356005)(81166007)(2616005)(16526019)(1076003)(83380400001)(82310400005)(6666004)(26005)(426003)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 06:10:14.7019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be6965b2-82b6-4696-132a-08db1a1b9fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C981.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support EccInfoTable which includes umc ras error count and
error address.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 923a9fb3c8873c..27448ffe60a439 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -46,6 +46,7 @@
 #include "asic_reg/mp/mp_13_0_0_sh_mask.h"
 #include "smu_cmn.h"
 #include "amdgpu_ras.h"
+#include "umc_v8_10.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -90,6 +91,12 @@
 
 #define DEBUGSMC_MSG_Mode1Reset	2
 
+/*
+ * SMU_v13_0_10 supports ECCTABLE since version 80.34.0,
+ * use this to check ECCTABLE feature whether support
+ */
+#define SUPPORT_ECCTABLE_SMU_13_0_10_VERSION 0x00502200
+
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -229,6 +236,7 @@ static struct cmn2asic_mapping smu_v13_0_0_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(ACTIVITY_MONITOR_COEFF),
 	[SMU_TABLE_COMBO_PPTABLE] = {1, TABLE_COMBO_PPTABLE},
 	TAB_MAP(I2C_COMMANDS),
+	TAB_MAP(ECCINFO),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_pwr_src_map[SMU_POWER_SOURCE_COUNT] = {
@@ -462,6 +470,8 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
 		       AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_COMBO_PPTABLE, MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE,
 			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	SMU_TABLE_INIT(tables, SMU_TABLE_ECCINFO, sizeof(EccInfoTable_t),
+			PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetricsExternal_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
@@ -477,8 +487,14 @@ static int smu_v13_0_0_tables_init(struct smu_context *smu)
 	if (!smu_table->watermarks_table)
 		goto err2_out;
 
+	smu_table->ecc_table = kzalloc(tables[SMU_TABLE_ECCINFO].size, GFP_KERNEL);
+	if (!smu_table->ecc_table)
+		goto err3_out;
+
 	return 0;
 
+err3_out:
+	kfree(smu_table->watermarks_table);
 err2_out:
 	kfree(smu_table->gpu_metrics_table);
 err1_out:
@@ -2036,6 +2052,64 @@ static int smu_v13_0_0_send_bad_mem_channel_flag(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v13_0_0_check_ecc_table_support(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t if_version = 0xff, smu_version = 0xff;
+	int ret = 0;
+
+	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
+	if (ret)
+		return -EOPNOTSUPP;
+
+	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 10)) &&
+		(smu_version >= SUPPORT_ECCTABLE_SMU_13_0_10_VERSION))
+		return ret;
+	else
+		return -EOPNOTSUPP;
+}
+
+static ssize_t smu_v13_0_0_get_ecc_info(struct smu_context *smu,
+									void *table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct amdgpu_device *adev = smu->adev;
+	EccInfoTable_t *ecc_table = NULL;
+	struct ecc_info_per_ch *ecc_info_per_channel = NULL;
+	int i, ret = 0;
+	struct umc_ecc_info *eccinfo = (struct umc_ecc_info *)table;
+
+	ret = smu_v13_0_0_check_ecc_table_support(smu);
+	if (ret)
+		return ret;
+
+	ret = smu_cmn_update_table(smu,
+					SMU_TABLE_ECCINFO,
+					0,
+					smu_table->ecc_table,
+					false);
+	if (ret) {
+		dev_info(adev->dev, "Failed to export SMU ecc table!\n");
+		return ret;
+	}
+
+	ecc_table = (EccInfoTable_t *)smu_table->ecc_table;
+
+	for (i = 0; i < UMC_V8_10_TOTAL_CHANNEL_NUM(adev); i++) {
+		ecc_info_per_channel = &(eccinfo->ecc[i]);
+		ecc_info_per_channel->ce_count_lo_chip =
+				ecc_table->EccInfo[i].ce_count_lo_chip;
+		ecc_info_per_channel->ce_count_hi_chip =
+				ecc_table->EccInfo[i].ce_count_hi_chip;
+		ecc_info_per_channel->mca_umc_status =
+				ecc_table->EccInfo[i].mca_umc_status;
+		ecc_info_per_channel->mca_umc_addr =
+				ecc_table->EccInfo[i].mca_umc_addr;
+	}
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -2111,6 +2185,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.send_hbm_bad_pages_num = smu_v13_0_0_smu_send_bad_mem_page_num,
 	.send_hbm_bad_channel_flag = smu_v13_0_0_send_bad_mem_channel_flag,
 	.gpo_control = smu_v13_0_gpo_control,
+	.get_ecc_info = smu_v13_0_0_get_ecc_info,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.17.1

