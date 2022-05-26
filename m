Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EE4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 18:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F8A10E33D;
	Thu, 26 May 2022 18:00:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86ECD10E33D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 18:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyhHyEv7Cb4iToTGYLmsNLB2Pz4JcD5tZuzprKWKlf15AoOktgpoebPBmtqoN3/P26xHIrIDAfMSPPemERS47wMSakXLna3MlrWPuu9l2SaDyPcREA5qvB1cD4qJA1KAGjtA/R2Km4FavDM6Az22bWWvpeidXIU7/fqBYmvcVKZiE/1Ap4quO7frbttrTxjrPq4QuiMbSX64q9xkvhv/ta03ZYEd8jGv2Ln5TYmsjJ6cNK42nbLp8l0Xy5gdDrmHaZwNvrYfGp/DihWkHqyO16rnDQxEYXRI4ZhGZMDRDKg6kz/pioxV7Ivt1kvewU/G5SNXU5/M4q08kF90dUUasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1M8zdu0t5H3oh7/K+eYquP241GycQL4yDqFO/z9T00=;
 b=WROHBDaRT+WsW3fkQNqOr1zS8dRPdGLP5Nh8prZT17zwaIjGVTeH+RmrM8sjnfYG65VUFq7MV1o7EqTDqTShd+I0tCKwGO8GGPwXE9IIFZDR+gdg0POguSCk7j2tU7IJfV9XnlHF3NkbYRyx/uWeJ8pUhWR7VXiqeRAW97ii+k4JROrRac17wG7KBgRA5hI6uhR4940iQirnyyQ4gQI7DIWxqlDjbXKK4r0pyzoAM5seWEhPyeEZfGs2AYtLGqY2UE01S+DtXHqhnwo0FR0OXA+g4bEawBm6EhtwfUhVy3XRM4fNgW5Vv/yQNFLD39FhMUyKlhd4aPERvB/H4HaatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1M8zdu0t5H3oh7/K+eYquP241GycQL4yDqFO/z9T00=;
 b=LZ6k7eaZ7raVsS/eq6jKsd2CMOoxE3cSJBRSu7d9cpVzEYPYUOU6Wcyk4nbYZKhuP1fXzkRZBf6xP1nLEdR6726u37nKHgi8Uw2J4J9uoXTgHLF2SLrw3EuUB1gDTtero04lTri5QlwfE21hfcikUjd7LtPno5rIkHhYRb49TuI=
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by MW2PR12MB2442.namprd12.prod.outlook.com (2603:10b6:907:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 18:00:42 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::e6) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 18:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 18:00:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 13:00:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/swsmu: add SMU mailbox registers in SMU context
Date: Thu, 26 May 2022 14:00:26 -0400
Message-ID: <20220526180027.3044740-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220526180027.3044740-1-alexander.deucher@amd.com>
References: <20220526180027.3044740-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9850c6bb-c959-4716-dd57-08da3f41a650
X-MS-TrafficTypeDiagnostic: MW2PR12MB2442:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2442C6943FDDF7F7D787202FF7D99@MW2PR12MB2442.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocHd1aXGXICwzwDrNj5VFV5Nq19lSbH3WxWcZzPv8R4/YINvVAVt8fUNiPLYp3lo3GMtGQCH9RAcFp7JRaT4iJMuFWJQYq/w+LxyzqekrdGcLSel92xsHhHnsIkaV6dshaQqfz8U4btIqYE6o27YpS6iMSNI6v6ajYnohDHz3FWu0svFOYctP/JtPHQjzMHs/cHGY6lCAbidoPN7RlipsMAkpTefsMKXXOqIVTYr61FEw6Wf6dU/o7PIRu4+4WuvWEemM3ICMpvKjbelrwhzTOmoycVgHEGMeGdEURzxcX4NMiRnuADGHtMmO5PfXLTjiP7e6uyLdIYibWaYXmKsYYlyu8qc8rx/G/pzWyg4KsLfgIpoxob5rDPX1AZzPZ4508/STe59nUU7r+KzwRuUiIzi1p3S/LSwLrG+Xqft5+CaZyo/BgUlt82RAyp1CU9l2xQW7LwfFONlDbFVwEyQbldDw+5gC3TekW9z1XesrVL419cXEaQ5/PLWTL8M6GXQcdLSEBikonz9baIfoTOaJWluYsPXrx++xilqnwBYdBA0hExWDQ7MD/QkXutgUFWUDqvRtnqUfGBhFFRp3uy6EbFsramTq4UX96wi5weXlewgsSqZsnzJHEgFG/bzndsN/1G4PxgjLhN4Q8JWV/C43U514QHJgqaKyOFRGPuL7+zHhX3zkuolQKJd0ExCwfIQB9tjzu1O3Dpt/hPgoCBglQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400005)(15650500001)(6666004)(186003)(36756003)(16526019)(36860700001)(40460700003)(316002)(47076005)(5660300002)(336012)(426003)(70206006)(70586007)(8676002)(4326008)(2616005)(1076003)(508600001)(2906002)(81166007)(86362001)(6916009)(83380400001)(356005)(8936002)(7696005)(30864003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 18:00:42.1306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9850c6bb-c959-4716-dd57-08da3f41a650
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2442
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So we can eventaully use them in the common smu code for
accessing the SMU mailboxes without needing a lot of
per asic logic in the common code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h  |  4 ++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h   |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   |  2 ++
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  1 +
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |  1 +
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  9 +++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  1 +
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    | 14 ++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 18 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   | 14 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   | 14 ++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  1 +
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   |  1 +
 17 files changed, 86 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a6a7b6c33683..36af1f417dcd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -563,6 +563,10 @@ struct smu_context
 	struct stb_context stb_context;
 
 	struct firmware pptable_firmware;
+
+	u32 param_reg;
+	u32 msg_reg;
+	u32 resp_reg;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index acb3be292096..a9215494dcdd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -316,5 +316,7 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable);
 
 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
 
+void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 036fd2810ecc..f60dcc4f7e75 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -298,5 +298,7 @@ int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
 				uint32_t size);
 
 int smu_v13_0_set_default_dpm_tables(struct smu_context *smu);
+
+void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 201563072189..bfabcd3c45aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2509,4 +2509,5 @@ void arcturus_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = arcturus_table_map;
 	smu->pwr_src_map = arcturus_pwr_src_map;
 	smu->workload_map = arcturus_workload_map;
+	smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index f1a4a720d426..ca4d97b7f576 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -591,4 +591,5 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
 	smu->message_map = cyan_skillfish_message_map;
 	smu->table_map = cyan_skillfish_table_map;
 	smu->is_apu = true;
+	smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 5f22fc3430f4..0bcd4fe0ef17 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3580,4 +3580,5 @@ void navi10_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = navi10_table_map;
 	smu->pwr_src_map = navi10_pwr_src_map;
 	smu->workload_map = navi10_workload_map;
+	smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6b452e3f5ee3..f6f21b516fd6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -4357,4 +4357,5 @@ void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = sienna_cichlid_table_map;
 	smu->pwr_src_map = sienna_cichlid_pwr_src_map;
 	smu->workload_map = sienna_cichlid_workload_map;
+	smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b87f550af26b..974b8fe1dbb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2197,3 +2197,12 @@ int smu_v11_0_restore_user_od_settings(struct smu_context *smu)
 
 	return ret;
 }
+
+void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 5551e1426ef5..e2d8ac90cf36 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2213,4 +2213,5 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = vangogh_table_map;
 	smu->workload_map = vangogh_workload_map;
 	smu->is_apu = true;
+	smu_v11_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 012e3bd99cc2..85e22210963f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -41,6 +41,15 @@
 #undef pr_info
 #undef pr_debug
 
+#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
+
 static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                  1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,                1),
@@ -1447,6 +1456,8 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	smu->ppt_funcs = &renoir_ppt_funcs;
 	smu->message_map = renoir_message_map;
 	smu->clock_map = renoir_clk_map;
@@ -1454,4 +1465,7 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
 	smu->workload_map = renoir_workload_map;
 	smu->smc_driver_if_version = SMU12_DRIVER_IF_VERSION;
 	smu->is_apu = true;
+	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index fb130409309c..2e6a93869be8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -2117,4 +2117,5 @@ void aldebaran_set_ppt_funcs(struct smu_context *smu)
 	smu->clock_map = aldebaran_clk_map;
 	smu->feature_map = aldebaran_feature_mask_map;
 	smu->table_map = aldebaran_table_map;
+	smu_v13_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 7be4f6875a7b..6fd3216b91d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -60,6 +60,15 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_0.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_7.bin");
 
+#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
+
+#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
+
 #define SMU13_VOLTAGE_SCALE 4
 
 #define LINK_WIDTH_MAX				6
@@ -2386,3 +2395,12 @@ int smu_v13_0_set_default_dpm_tables(struct smu_context *smu)
 	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0,
 				    smu_table->clocks_table, false);
 }
+
+void smu_v13_0_set_smu_mailbox_registers(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+
+	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 5c74a72577c6..418480e0c077 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1651,4 +1651,5 @@ void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v13_0_0_table_map;
 	smu->pwr_src_map = smu_v13_0_0_pwr_src_map;
 	smu->workload_map = smu_v13_0_0_workload_map;
+	smu_v13_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 5a17b51aa0f9..8ccda593fc50 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -43,6 +43,15 @@
 #undef pr_info
 #undef pr_debug
 
+#define mmMP1_SMN_C2PMSG_66			0x0282
+#define mmMP1_SMN_C2PMSG_66_BASE_IDX            1
+
+#define mmMP1_SMN_C2PMSG_82			0x0292
+#define mmMP1_SMN_C2PMSG_82_BASE_IDX            1
+
+#define mmMP1_SMN_C2PMSG_90			0x029a
+#define mmMP1_SMN_C2PMSG_90_BASE_IDX		1
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 
 #define SMC_DPM_FEATURE ( \
@@ -1034,9 +1043,14 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 
 void smu_v13_0_4_set_ppt_funcs(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	smu->ppt_funcs = &smu_v13_0_4_ppt_funcs;
 	smu->message_map = smu_v13_0_4_message_map;
 	smu->feature_map = smu_v13_0_4_feature_mask_map;
 	smu->table_map = smu_v13_0_4_table_map;
 	smu->is_apu = true;
+	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index b81711c4ff33..47360ef5c175 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -42,6 +42,15 @@
 #undef pr_info
 #undef pr_debug
 
+#define mmMP1_C2PMSG_2                                                                            (0xbee142 + 0xb00000 / 4)
+#define mmMP1_C2PMSG_2_BASE_IDX                                                                   0
+
+#define mmMP1_C2PMSG_34                                                                           (0xbee262 + 0xb00000 / 4)
+#define mmMP1_C2PMSG_34_BASE_IDX                                                                   0
+
+#define mmMP1_C2PMSG_33                                                                                (0xbee261 + 0xb00000 / 4)
+#define mmMP1_C2PMSG_33_BASE_IDX                                                                   0
+
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
@@ -1049,9 +1058,14 @@ static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
 
 void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu)
 {
+	struct amdgpu_device *adev = smu->adev;
+
 	smu->ppt_funcs = &smu_v13_0_5_ppt_funcs;
 	smu->message_map = smu_v13_0_5_message_map;
 	smu->feature_map = smu_v13_0_5_feature_mask_map;
 	smu->table_map = smu_v13_0_5_table_map;
 	smu->is_apu = true;
+	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_34);
+	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_2);
+	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_C2PMSG_33);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 4e1861fb2c6a..bdea7bca3805 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1594,4 +1594,5 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
 	smu->table_map = smu_v13_0_7_table_map;
 	smu->pwr_src_map = smu_v13_0_7_pwr_src_map;
 	smu->workload_map = smu_v13_0_7_workload_map;
+	smu_v13_0_set_smu_mailbox_registers(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index feff4f8c927c..70cbc46341a3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1203,4 +1203,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context *smu)
 	smu->feature_map = yellow_carp_feature_mask_map;
 	smu->table_map = yellow_carp_table_map;
 	smu->is_apu = true;
+	smu_v13_0_set_smu_mailbox_registers(smu);
 }
-- 
2.35.3

