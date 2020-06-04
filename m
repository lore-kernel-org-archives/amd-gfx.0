Return-Path: <SRS0=gI7v=7R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B68C433E3
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697112072E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2020 04:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cit/cdRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697112072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8C86E187;
	Thu,  4 Jun 2020 04:47:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65606E175
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2020 04:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVWGzT/fHnkaYasngI41+wqedDqf8nW+ZPIYZmEj+a1b11tKvOCZYuJUoG08Yl95jSGXk7zDidHEJLgrpQhCg7Gxe9ZM6Lq0jIZXkRoRkPcGSpwbGKG7cyClhEHunOMJHpJR6pLqZyoJitA2q1L94Q3Gdbtz0pi+vhk0B1ZJGEgd/Kt6i2xlFya2+VDdHUYOTMrYvuOs+5tOBbpk5ft6rBwpo/q40yvqR2icvFbFzzLQrK78wKX9Feu8WtW8BruLz0nUJISP3LPWXsUhOWJtV69F8KeHzbFx6oKa5EwrqBTZCigEIryjvY3Sb4H/BE8uuAMuLNGR5lkbaYjDVXuMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoREszht9nBNiOe/49HjtvWoyEM+nr/SnuDVBPI/qUE=;
 b=MvvPjn0qZUqctVPinIlv/uJt42YmN825d/VxefYo1nGOs1FuNTw7XM0LrHO1x4rP/6gHZvENCKqUjNoMs3ms2UCXA3mKbl4Vy6csVhEO6P4xHamLS5TNsejN9De7L+KK5yOjT7XsmRxC58eS8zrqoJpuvR307oKFlWJJtkcd8gCTsp33rGBNmsyCysk1DTDzKRJqsp75reqOEhkHN5vqimNoBoZ5Fkd8z1WFO9BDeOZdtoejKWUT0TCeRJcb7iCn9xhYpb4apjfDIgaFIPA64YCFmB8E+7edpIcoYM9ykBmBEpk0vW6UY37PewTjhHiF9pFfSggCyXFOsgWj6t4vvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoREszht9nBNiOe/49HjtvWoyEM+nr/SnuDVBPI/qUE=;
 b=Cit/cdRIaYNZqaGNPnMj3SfjETC/FumDKBATC5ZvISqg2E0MN99ZyuaWub8LSvNXfUw7YEm/TonDqidq7J49YY4SSkWdvuC7fD+9pZBtLxt1g93Ykbd3vNrCl5V/+m5Vy257IKS1Vk1A4ovix8gcbp8oXGZ2msD4vfgUHOiuNPc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3002.namprd12.prod.outlook.com (2603:10b6:5:117::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Thu, 4 Jun 2020 04:47:05 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3045.022; Thu, 4 Jun 2020
 04:47:05 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/16] drm/amd/powerplay: clean up the overdrive settings
Date: Thu,  4 Jun 2020 12:46:10 +0800
Message-Id: <20200604044619.18658-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200604044619.18658-1-evan.quan@amd.com>
References: <20200604044619.18658-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::35) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0071.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Thu, 4 Jun 2020 04:47:04 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1f7b854-0473-45dc-ea24-08d80842548a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30026E6F58C38FA2029031E0E4890@DM6PR12MB3002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgfTBXHBPp23EemireCctVatiojB6u6boKBGCmfn1y8JnTPyNA+iAKnF1PM0unlXkrR5bswdvGPjiQzqZTGRjTTHidQYk3+SYB9yGVNbnq3gzME4re/r1+UpBddsyUdY872gJuzQnojQ+xBvm04HFOA6SC9TFQ+v8cjf2M5aqj970STPYtDWGmJzAWbv800my1jKsNsw5+QQd9EUvTcK6ijfnGAOWI2TS6sPQg0GVAkBjmdStMs5s91CMsrihQr4MD/PJnJ0utlAowNsaYUFUY05IWxXoDpqDgVkFLFTUFg9IpiSUaWZU0QI0CGt77uJ75eZ4KuDMD3CgE3jc3MAug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(7696005)(1076003)(52116002)(36756003)(2616005)(26005)(316002)(16526019)(83380400001)(6666004)(6486002)(86362001)(5660300002)(186003)(956004)(6916009)(4326008)(66946007)(2906002)(44832011)(8936002)(66476007)(66556008)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MYX6kjZVZpaVDJbh/umdlmZsj0pbMxRytzYEcG/ORCShpz4V1R0IfW/MGr+IperLYHOA18DBHUD1rbYmhwFJrfFkYkt94XQJm+0ByG/dqle52/mdgBBu3JFxKmiA0jRu8NaRMhAY2lOiXzmef76C3Z1MgXntEns6uvZP9Pd2Sekbfx20NuDPGXyU99Awr5YPsyoTwqQc9orY0ZGONp1GtNmLGoPMAzgtqD0ehEGFPXxDoNO1XvZMo9JsfW/JERqMmaIfgznXSvG3lUXbbIRk3FNq9gosRDcU8Bk6U7jF5JBckKChSs7e8TaUfymWcmBV8536Db7zg1RGED2jqbC2VML6qX+EH5DDQGG1LyXGHdecXvfFx0VXnHek+aaD94qZVAEG1rQnHDAuD535rmpXNYMXREZZA0IG39+t+arKK5AVU+9IAnYy5qkntyzA2Q8fbpd6zftLT6REUklwRjGZwM9Nn1HIDugoy0Pm3JLmMsmBZbGqhkP6xd3f+p7WyCgP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f7b854-0473-45dc-ea24-08d80842548a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 04:47:05.3947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8T/s0zGccU+fzFrFP02OBBYgUbaOn7iAexTM8Zw5ZImnC5bbAncr04q7Jd/SoSO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3002
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Eliminate the buffer allocation and drop the unnecessary
overdrive table uploading.

Change-Id: I8ba5383a330e6d5355cea219147500c1b4a43f47
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  2 +-
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  2 +-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  2 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 74 +++++++++----------
 drivers/gpu/drm/amd/powerplay/smu_internal.h  |  4 +-
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 20 -----
 6 files changed, 38 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index de9e52ad9e25..cd7a3d3efa23 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1197,7 +1197,7 @@ static int smu_smc_table_hw_init(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	ret = smu_set_default_od_settings(smu, initialize);
+	ret = smu_set_default_od_settings(smu);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 69ad51161635..b2de042493ad 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -480,7 +480,7 @@ struct pptable_funcs {
 					     uint32_t *value);
 	int (*get_thermal_temperature_range)(struct smu_context *smu, struct smu_temperature_range *range);
 	int (*get_uclk_dpm_states)(struct smu_context *smu, uint32_t *clocks_in_khz, uint32_t *num_states);
-	int (*set_default_od_settings)(struct smu_context *smu, bool initialize);
+	int (*set_default_od_settings)(struct smu_context *smu);
 	int (*set_performance_level)(struct smu_context *smu, enum amd_dpm_forced_level level);
 	int (*display_disable_memory_clock_switch)(struct smu_context *smu, bool disable_memory_clock_switch);
 	void (*dump_pptable)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index e9c71e5a8093..c442fc992d2e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -259,8 +259,6 @@ int smu_v11_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 
 int smu_v11_0_override_pcie_parameters(struct smu_context *smu);
 
-int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize, size_t overdrive_table_size);
-
 uint32_t smu_v11_0_get_max_power_limit(struct smu_context *smu);
 
 int smu_v11_0_set_performance_level(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 110845922724..4c1c4af2249b 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1969,55 +1969,49 @@ static bool navi10_is_baco_supported(struct smu_context *smu)
 	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
 }
 
-static int navi10_set_default_od_settings(struct smu_context *smu, bool initialize) {
-	OverDriveTable_t *od_table, *boot_od_table;
+static int navi10_set_default_od_settings(struct smu_context *smu)
+{
+	OverDriveTable_t *od_table =
+		(OverDriveTable_t *)smu->smu_table.overdrive_table;
+	OverDriveTable_t *boot_od_table =
+		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
 	int ret = 0;
 
-	ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
-	if (ret)
+	ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_table, false);
+	if (ret) {
+		pr_err("Failed to get overdrive table!\n");
 		return ret;
+	}
 
-	od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
-	boot_od_table = (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
-	if (initialize) {
-		if (od_table) {
-			if (!od_table->GfxclkVolt1) {
-				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
-										&od_table->GfxclkVolt1,
-										od_table->GfxclkFreq1);
-				if (ret)
-					od_table->GfxclkVolt1 = 0;
-				if (boot_od_table)
-					boot_od_table->GfxclkVolt1 = od_table->GfxclkVolt1;
-			}
-
-			if (!od_table->GfxclkVolt2) {
-				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
-										&od_table->GfxclkVolt2,
-										od_table->GfxclkFreq2);
-				if (ret)
-					od_table->GfxclkVolt2 = 0;
-				if (boot_od_table)
-					boot_od_table->GfxclkVolt2 = od_table->GfxclkVolt2;
-			}
+	if (!od_table->GfxclkVolt1) {
+		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+								&od_table->GfxclkVolt1,
+								od_table->GfxclkFreq1);
+		if (ret)
+			return ret;
+	}
 
-			if (!od_table->GfxclkVolt3) {
-				ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
-										&od_table->GfxclkVolt3,
-										od_table->GfxclkFreq3);
-				if (ret)
-					od_table->GfxclkVolt3 = 0;
-				if (boot_od_table)
-					boot_od_table->GfxclkVolt3 = od_table->GfxclkVolt3;
-			}
-		}
+	if (!od_table->GfxclkVolt2) {
+		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+								&od_table->GfxclkVolt2,
+								od_table->GfxclkFreq2);
+		if (ret)
+			return ret;
 	}
 
-	if (od_table) {
-		navi10_dump_od_table(od_table);
+	if (!od_table->GfxclkVolt3) {
+		ret = navi10_overdrive_get_gfx_clk_base_voltage(smu,
+								&od_table->GfxclkVolt3,
+								od_table->GfxclkFreq3);
+		if (ret)
+			return ret;
 	}
 
-	return ret;
+	memcpy(boot_od_table, od_table, sizeof(OverDriveTable_t));
+
+	navi10_dump_od_table(od_table);
+
+	return 0;
 }
 
 static int navi10_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TABLE_COMMAND type, long input[], uint32_t size) {
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index d2b0b9b2f841..9dce366a6f5f 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -70,8 +70,8 @@
 	((smu)->ppt_funcs->system_features_control ? (smu)->ppt_funcs->system_features_control((smu), (en)) : 0)
 #define smu_init_max_sustainable_clocks(smu) \
 	((smu)->ppt_funcs->init_max_sustainable_clocks ? (smu)->ppt_funcs->init_max_sustainable_clocks((smu)) : 0)
-#define smu_set_default_od_settings(smu, initialize) \
-	((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu), (initialize)) : 0)
+#define smu_set_default_od_settings(smu) \
+	((smu)->ppt_funcs->set_default_od_settings ? (smu)->ppt_funcs->set_default_od_settings((smu)) : 0)
 
 #define smu_send_smc_msg_with_param(smu, msg, param, read_arg) \
 	((smu)->ppt_funcs->send_smc_msg_with_param? (smu)->ppt_funcs->send_smc_msg_with_param((smu), (msg), (param), (read_arg)) : 0)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 377986a1d492..5f3125ec5850 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1906,26 +1906,6 @@ int smu_v11_0_override_pcie_parameters(struct smu_context *smu)
 
 }
 
-int smu_v11_0_set_default_od_settings(struct smu_context *smu, bool initialize, size_t overdrive_table_size)
-{
-	struct smu_table_context *table_context = &smu->smu_table;
-	int ret = 0;
-
-	if (initialize) {
-		ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, false);
-		if (ret) {
-			pr_err("Failed to export overdrive table!\n");
-			return ret;
-		}
-	}
-	ret = smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->overdrive_table, true);
-	if (ret) {
-		pr_err("Failed to import overdrive table!\n");
-		return ret;
-	}
-	return ret;
-}
-
 int smu_v11_0_set_performance_level(struct smu_context *smu,
 				    enum amd_dpm_forced_level level)
 {
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
