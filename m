Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D2BC433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Nov 2022 04:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7E810E25B;
	Sat, 19 Nov 2022 04:42:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BFBE10E25B
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Nov 2022 04:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdHcs32MWe1mfv6tOb5uf7r7fdI13uru15ccx27ExZS91UeT4hrpmKn+salvzXlZBghvJO1nqP1CE81l76MSOrkha/Kr3TFaIVqBNVCXtYk6kIWQp7qeJ9QERO6XCQ1LwhU9ikc0TRoykNvwqZ/FgM3Rd1TjHM7Z22fiIGHGgxHhUm1Pm5tvM50OucD9CrFM9E9/EBPBeeK7InE06ZE5afdUvvCAVPuxMnWrKDvy5xosRR4sSEUnV4DwsaqtYZS0Y2wYAH7NRWlyQZ8BS+5zl4jFSnc/XtWkkw45NSPYNh3vLZo9/++YV5psnbkdxrYgaJG5LRu7pruBTJ+94CdTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twNAvoTYVsb6kNGcquuFKTjion+kP2VMN3KGDgXpoDE=;
 b=mdWPZFhPO3VRMDcOHkr45/U2PEwttcY37zU2nVcxdz7yi/NwjPA6UNL8rs8aG+6UuPoEm4byZkvhtEFYlDiu/kkE8MXHWN/9cjw1P85GztZKRxOyWlHr96udiyf70o6CVXzX0/ZU7FdBNkuKN7wPw23fZKaZXElV+kg7iX4lbErD8eO3oSsvuWwtCEVh6AVJzI/IzvqK+zns1r6VvT5dZnNZF9MuL7NcM3uN0MIaJdO5VD1U+3MPv46oarxNi20HChsRhMLnTdv5uMynO7l3WgcTNGDKfaak35RSN/lcv8DvXIx3WrCIAcUxfG7X9SiIUzxlSbyvV7cqHBkCnvSFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twNAvoTYVsb6kNGcquuFKTjion+kP2VMN3KGDgXpoDE=;
 b=prXi6rjNwPbOc3KVSma9+U5dB4Cq98VZRVnRTcROtYvh8F4DXeMZ+0bjtTt7+yOI6+wVoYEeYUekNxraqbmV6JEi2gQJFGNJ3yZp/+Ft1loNwqMd1UBGpMCXO5x0QyVJHus1zGMZ9ILTSQTspXv/sID4yaltfdbKeNR3NNfKg7M=
Received: from DS7PR05CA0082.namprd05.prod.outlook.com (2603:10b6:8:57::23) by
 DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.9; Sat, 19 Nov 2022 04:42:46 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::44) by DS7PR05CA0082.outlook.office365.com
 (2603:10b6:8:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8 via Frontend
 Transport; Sat, 19 Nov 2022 04:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Sat, 19 Nov 2022 04:42:46 +0000
Received: from candice-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 22:42:44 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Enable bad memory page/channel recording support
 for smu v13_0_0
Date: Sat, 19 Nov 2022 12:42:09 +0800
Message-ID: <20221119044209.3881428-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c91eaa-e180-4c16-bf49-08dac9e88115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaHvf9WU/KvSUHgYshEXaLKrOEMkc0XgIbbpgw59elRdUSUfPvhteKM8V+oTHDqL5DrJbIqv4yZFKIIMz3irPSRPvscF4ABCtY+Ht6srZipHAq+LA+yOY0pNmwQlUIGVvDw7mBgzucKsz43rZBoq6s2EkyYDk+cFZ31tDSCEgFTNT024FEDWbONTE4ZnHNHR8uGr7sisiO4Yi/7i6p1ukTjQHTpsXQ4yMugSrnfWCS1A/pj5o5HYsAECDVpueZ5aTsyJS90EalzFfZx4rOBgPEGp8qgiqAAthoqQBLkKzTJB0q8n8NHaImJhOGIiCqw7WWIZ3mZcW8+sAvdpJGKhUkiE0/3PgcrO5JHMIThbsGbhB1eHL87jK7abT34ac5UBQ6j/etObXZIxll3ovWVYbkHvygzpBH1e/VuCeMOGZJ/aBqimyqaQTO3vm6XYSt3RKE62zPQyQ2zgF8vgj4hyA76aEoHG/Zw2ffVbuwBxZ/6dBwFdDBzWWHeIKoqcrKI+xdF6M4uveszhlsQQvGeS/tHTXxMHXKq1dinW8NO7qVIyd1l0YdulKkRO9WENm9YbtKUMFlVEZgOK8dPLuRro/do0QfyPFIJj2q3v9on143w0Yb1R4btgxph1mKvnyKW458DOLqNOlk3GjjImPfHJj1nGCnAWPmvhW1RISBZ68PdjwamtuxwHbfQ7TOmG0QjB+G4WRvnJJR0M5YaV4uEdwj88LZCNmZQCN8vfH2OkgSI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(356005)(6916009)(81166007)(316002)(8676002)(2616005)(47076005)(186003)(426003)(336012)(54906003)(1076003)(40460700003)(5660300002)(44832011)(16526019)(8936002)(36860700001)(2906002)(83380400001)(82740400003)(4326008)(70206006)(70586007)(40480700001)(36756003)(41300700001)(478600001)(26005)(6666004)(7696005)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 04:42:46.0534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c91eaa-e180-4c16-bf49-08dac9e88115
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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
Cc: Candice Li <candice.li@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Send message to SMU to update bad memory page and bad channel info.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |  8 +++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 39 +++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
index 9ebb8f39732a0e..8b8266890a1002 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
@@ -131,7 +131,13 @@
 #define PPSMC_MSG_EnableAudioStutterWA           0x44
 #define PPSMC_MSG_PowerUpUmsch                   0x45
 #define PPSMC_MSG_PowerDownUmsch                 0x46
-#define PPSMC_Message_Count                      0x47
+#define PPSMC_MSG_SetDcsArch                     0x47
+#define PPSMC_MSG_TriggerVFFLR                   0x48
+#define PPSMC_MSG_SetNumBadMemoryPagesRetired    0x49
+#define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
+#define PPSMC_MSG_SetPriorityDeltaGain           0x4B
+#define PPSMC_MSG_AllowIHHostInterrupt           0x4C
+#define PPSMC_Message_Count                      0x4D
 
 //Debug Dump Message
 #define DEBUGSMC_MSG_TestMessage                    0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 58098b82df660c..a4e3425b1027c2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -239,7 +239,9 @@
 	__SMU_DUMMY_MAP(DriverMode2Reset), \
 	__SMU_DUMMY_MAP(GetGfxOffStatus),		 \
 	__SMU_DUMMY_MAP(GetGfxOffEntryCount),		 \
-	__SMU_DUMMY_MAP(LogGfxOffResidency),
+	__SMU_DUMMY_MAP(LogGfxOffResidency),			\
+	__SMU_DUMMY_MAP(SetNumBadMemoryPagesRetired),		\
+	__SMU_DUMMY_MAP(SetBadMemoryPagesRetiredFlagsPerChannel),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5bcb61f77e4193..87d7c66e49ef28 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -141,6 +141,9 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(PrepareMp1ForUnload,		PPSMC_MSG_PrepareMp1ForUnload,         0),
 	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
+	MSG_MAP(SetNumBadMemoryPagesRetired,	PPSMC_MSG_SetNumBadMemoryPagesRetired,   0),
+	MSG_MAP(SetBadMemoryPagesRetiredFlagsPerChannel,
+			    PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,   0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -1838,6 +1841,40 @@ static void smu_v13_0_0_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_54);
 }
 
+static int smu_v13_0_0_smu_send_bad_mem_page_num(struct smu_context *smu,
+		uint32_t size)
+{
+	int ret = 0;
+
+	/* message SMU to update the bad page number on SMUBUS */
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+					  SMU_MSG_SetNumBadMemoryPagesRetired,
+					  size, NULL);
+	if (ret)
+		dev_err(smu->adev->dev,
+			  "[%s] failed to message SMU to update bad memory pages number\n",
+			  __func__);
+
+	return ret;
+}
+
+static int smu_v13_0_0_send_bad_mem_channel_flag(struct smu_context *smu,
+		uint32_t size)
+{
+	int ret = 0;
+
+	/* message SMU to update the bad channel info on SMUBUS */
+	ret = smu_cmn_send_smc_msg_with_param(smu,
+				  SMU_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,
+				  size, NULL);
+	if (ret)
+		dev_err(smu->adev->dev,
+			  "[%s] failed to message SMU to update bad memory pages channel info\n",
+			  __func__);
+
+	return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v13_0_0_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v13_0_0_set_default_dpm_table,
@@ -1908,6 +1945,8 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.mode1_reset = smu_v13_0_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_0_set_mp1_state,
 	.set_df_cstate = smu_v13_0_0_set_df_cstate,
+	.send_hbm_bad_pages_num = smu_v13_0_0_smu_send_bad_mem_page_num,
+	.send_hbm_bad_channel_flag = smu_v13_0_0_send_bad_mem_channel_flag,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

