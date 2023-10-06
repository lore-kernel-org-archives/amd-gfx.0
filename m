Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AF7E92FE4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 05:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDC210E00B;
	Fri,  6 Oct 2023 05:22:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DE3510E00B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 05:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhrrhgl+5bFygBeHzitBRPO2WQaFAQAgXNOLyQb/7oPqDQGQW7p1yUcKYLaq9fCYfMyh6YxAiFjcKcDMddyS2HIuCqBAIiblChfPVFG9QXVRXkN2YVnilmUPy2BjIq4knUl7N+m6f6JXojH6NtgAmvSvk7mWSIEWhKlW9Uog09C7C4eoOUIpXuLb0+QIMXn4yo0ZbDFeUP5m93ErDuaOttDd5jnaN0+1/ipW0lOR5OgSznOj4km/8mpbBgqA7u/JCQw/4cLdIcck5Xz+0Azp55ZlES/kw2a/08Jt9Nh+b6B1QaIj3qZ5xLcgXZ3uy388E43X/R7iXBcGWjZ6+g6pDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhV0o9cJZg1eFrs3fhTKKbMG8OFKjxpo2XQjMWgg5M8=;
 b=nTqbjmvy3SJQfRxxFhK6EcLLttMOUAJRCQQ5U/u74bc92dxjjG8ixYHY2PBqjZF5UzVrHoCHD9/MfwDFD6CSTyVAfiIvwyiognEJm6xZ7l15NzX/R9QRWegZIw3XRTF8Zdc+zEkZhK+0+y9tMsUogGMBJ5/7YmRSLiucPqhDTYGwvBfHkI2ys6ylwpY6oR3WG9hopNjAnEChYh66UQXlrj5SV3qxGJJTdeH19/FDE9JpiWFZ+pgkI/Ec7F0t/DK5v9fbusKFXCwWYUwplkY7NFPcU+P+gwvNgP5oeQNQnv2y2XKW8slcR9+wsjHqZrFSiATxtCJK0vniQNTnQyP+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhV0o9cJZg1eFrs3fhTKKbMG8OFKjxpo2XQjMWgg5M8=;
 b=1nt2rr6tPUgvOm9EXfY0COWKG6E6zaT7cAXgmg3Tu0s0QJjPvMdgebCYUC+LZ9nrxjfq4s4ciBgH0Lx1GQsln7lprhI7sdtzzEhl4Bmg3ZQJ6LPDqHqVJBQjy+NCVdKQ9UZ51zZORebPQ/jr4d8wLSxrZ2IlypOLThcYg7AK6Ec=
Received: from SN4PR0501CA0055.namprd05.prod.outlook.com
 (2603:10b6:803:41::32) by SA1PR12MB7271.namprd12.prod.outlook.com
 (2603:10b6:806:2b8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 05:22:19 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::a9) by SN4PR0501CA0055.outlook.office365.com
 (2603:10b6:803:41::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 05:22:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 05:22:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 00:22:08 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/4] drm/amd/pm: Add pm log support to SMU v13.0.6
Date: Fri, 6 Oct 2023 10:51:48 +0530
Message-ID: <20231006052149.1566154-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231006052149.1566154-1-lijo.lazar@amd.com>
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9ef4ec-1964-412e-cb35-08dbc62c3609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGDaagAJVRk0xImaHQHZ+nqJ4qzTQ6UWnVKaZrAS5wVnUeTyAh8nI8P8O51iq341ApwprDTCENy/zRoGqITurTEN3xfo0+wAikA7DgWmNEYsEmQv1zghCkXMVeH09np3nKulEhb/Fv2KYj1+grm9V1badY/IwmUnppN0Wx92Tj1hEkA3nf74kRi25iDKO+uPK4HyNRIC8S0PDkK1VN9kArgvvcVhPkdJymrpdMoAvK0HwCsaA71XIHRp8JIkr4xcAMLnFcCAD6HdsMZydS+PTw574XnQZuL+bdwcVUNsaHOiU65VwPXyDr7qsTzV9Tl/kESMj4n1OTHzOStzKqk+2F/zocWz8FOq4T7bP/7ZQ6u/3Z4H7rHcDHgcOC7iZ/i6XnkrQEO5NXyJpOtDzqZOml0OEy4FU5BQn/K0LtD9wEFN/Hhv1IKlRf8Rp6IWQce+N7hzmZHn3EEcq8FdcjyAte0qsT7NYeM+lcKwZIa2eCVzOeSSgGNWOoXA3evaV2qH4LHGMNOj5/Wf7K77DCuRuAZUAJS6H31BdaSWjas7bdkCv6akoxwK0WwazPgsADwwJUC+jF1RL1z/Mi8XlgLB3rljExjuUYvZ7bqaA+iVnXwUgxeD3dtZ4pdmpznTxSigu6T0i/XW4n7KlHjG/PqfEUu7HnPDR2eo5RZBwYx5Pj4B/k75F0gziB0WRdVLpHgAAuc6FzKTX2OyS/MYU+zMVXV9gNl+pfniBu2Zpk5COVk91t9g8xYVWjW6JqVAenb9IOsi0XVQHywPhRlBcdFIKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(6666004)(7696005)(478600001)(82740400003)(81166007)(36860700001)(86362001)(356005)(2906002)(6916009)(47076005)(83380400001)(16526019)(426003)(316002)(336012)(26005)(2616005)(1076003)(70586007)(36756003)(8936002)(4326008)(41300700001)(54906003)(44832011)(5660300002)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 05:22:18.9904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9ef4ec-1964-412e-cb35-08dbc62c3609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
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
Cc: Alexander.Deucher@amd.com, kevinyang.wang@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support to fetch PM log sample from SMU v13.0.6

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2: Check if input buffer has enough space to copy log data

 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  4 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 59 +++++++++++++++++++
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 0d84fb9640a6..01bc92875f3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -253,6 +253,7 @@ struct smu_table {
 	uint64_t mc_address;
 	void *cpu_addr;
 	struct amdgpu_bo *bo;
+	uint32_t version;
 };
 
 enum smu_perf_level_designation {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index 509e3cd483fb..891d03327ffa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -91,7 +91,9 @@
 #define PPSMC_MSG_QueryValidMcaCeCount              0x3A
 #define PPSMC_MSG_McaBankCeDumpDW                   0x3B
 #define PPSMC_MSG_SelectPLPDMode                    0x40
-#define PPSMC_Message_Count                         0x41
+#define PPSMC_MSG_PmLogReadSample                   0x41
+#define PPSMC_MSG_PmLogGetTableVersion              0x42
+#define PPSMC_Message_Count                         0x43
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 4850e48bbef5..6ea9adabe30f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -253,7 +253,9 @@
 	__SMU_DUMMY_MAP(QueryValidMcaCeCount),	\
 	__SMU_DUMMY_MAP(McaBankDumpDW),		\
 	__SMU_DUMMY_MAP(McaBankCeDumpDW),	\
-	__SMU_DUMMY_MAP(SelectPLPDMode),
+	__SMU_DUMMY_MAP(SelectPLPDMode),	\
+	__SMU_DUMMY_MAP(PmLogGetTableVersion),	\
+	__SMU_DUMMY_MAP(PmLogReadSample),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index bf01a23f399a..e5f84d8dec80 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -172,6 +172,8 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(McaBankDumpDW,                       PPSMC_MSG_McaBankDumpDW,                   0),
 	MSG_MAP(McaBankCeDumpDW,                     PPSMC_MSG_McaBankCeDumpDW,                 0),
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
+	MSG_MAP(PmLogGetTableVersion,                PPSMC_MSG_PmLogGetTableVersion,            0),
+	MSG_MAP(PmLogReadSample,                     PPSMC_MSG_PmLogReadSample,                 0),
 };
 
 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] = {
@@ -337,6 +339,61 @@ static int smu_v13_0_6_get_allowed_feature_mask(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v13_0_6_setup_pm_log(struct smu_context *smu)
+{
+	struct smu_table_context *smu_tbl_ctxt = &smu->smu_table;
+	struct smu_table *table = &smu_tbl_ctxt->tables[SMU_TABLE_PMSTATUSLOG];
+	uint32_t pmlog_version;
+	int ret;
+
+	if (!table->size)
+		return 0;
+
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PmLogGetTableVersion,
+				   &pmlog_version);
+	if (ret)
+		return ret;
+
+	table->version = pmlog_version;
+
+	return 0;
+}
+
+static ssize_t smu_v13_0_6_get_pm_log(struct smu_context *smu, void *log,
+				      size_t max_size)
+{
+	struct smu_table_context *smu_tbl_ctxt = &smu->smu_table;
+	struct smu_table *table = &smu_tbl_ctxt->tables[SMU_TABLE_PMSTATUSLOG];
+	struct amdgpu_pmlog *pm_log = log;
+	uint32_t pmfw_version, log_size;
+	int ret;
+
+	if (smu->adev->flags & AMD_IS_APU)
+		return -EOPNOTSUPP;
+
+	if (!pm_log || !max_size)
+		return -EINVAL;
+
+	smu_cmn_get_smc_version(smu, NULL, &pmfw_version);
+	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_PmLogReadSample, &log_size);
+	if (ret)
+		return ret;
+
+	if (max_size < (log_size + sizeof(pm_log->common_header)))
+		return -EOVERFLOW;
+
+	amdgpu_asic_invalidate_hdp(smu->adev, NULL);
+	memcpy(pm_log->data, table->cpu_addr, log_size);
+
+	memset(&pm_log->common_header, 0, sizeof(pm_log->common_header));
+	pm_log->common_header.mp1_ip_discovery_version = IP_VERSION(13, 0, 6);
+	pm_log->common_header.pmfw_version = pmfw_version;
+	pm_log->common_header.pmlog_version = table->version;
+	pm_log->common_header.structure_size =
+		sizeof(pm_log->common_header) + log_size;
+
+	return pm_log->common_header.structure_size;
+}
 static int smu_v13_0_6_get_metrics_table(struct smu_context *smu,
 					 void *metrics_table, bool bypass_cache)
 {
@@ -549,6 +606,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
 	};
 
 	smu_v13_0_6_setup_driver_pptable(smu);
+	smu_v13_0_6_setup_pm_log(smu);
 
 	/* gfxclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.gfx_table;
@@ -2799,6 +2857,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.log_thermal_throttling_event = smu_v13_0_6_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
+	.get_pm_log = smu_v13_0_6_get_pm_log,
 	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
 	.mode1_reset_is_support = smu_v13_0_6_is_mode1_reset_supported,
 	.mode2_reset_is_support = smu_v13_0_6_is_mode2_reset_supported,
-- 
2.25.1

