Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42ADC4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 04:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6210E10E702;
	Wed,  8 Nov 2023 04:22:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F63310E385
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 04:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAKPBzSvypqRN78A3TLJxH3cMMhgIlJm2bPWeD3O2vWR1aBIQ/5XaZHj9ebZ2Or6N/2bgZi+DSIs5TsAkXzP/GTZpfKUAT3i5SAyDxRWrCm5hjGrVjWNcZubjF3WD8Li9PgLRvd4sT9yi2Ita4Cv/oGVV28uwWQaLBeFRMnGF9ZPD3jlW22XKM3vNnsdmUNLBxfUnr2fnamgPcAHahHMMs44SuPHG5HXWpCod+EGoYxhdjxTu9gOjPhiVGI5oLwdSi5mmxuzHuUPe7gy+Uc2aFRAVFFEmQ+qrxhrII4CMKCO6cVH8Fi6M7z9ZujZdFuffnQz6sHxntu2YIyfivB0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc0WriONIikjXahYejRtouE26sw4VtWW+jTWiW34EbM=;
 b=MrmocujqWQTyGkIIZa1R0/KvrTz2z1YFisbmMe0Oqn5cMQGpPuUKnQxbu0vDRZHTlOimmsKLcveKrhDLMtY7W+/qpzd7BzARoSKmQg6efVfxHcLqvUI77MgmdUkUK0b6e/SmfmQ1y3DUJaY+0pm6vXqL+dOsJUbzJ8mJqQiL/7UWT50mPhypCG7dkj2skTazJVvZukAyLVnfo+XC6UvkHdZPB8miLlCvM6o3rlI/X84xCYu1NiavarCelEDnEsABhOyYHHeARHx5SByqCT3HyPSv/AxuvGEKIGdyS98UhYLVypMBLJuWz9oc7KTU+9j1D2qoJ6Z3BhKYsJnpbb9upA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pc0WriONIikjXahYejRtouE26sw4VtWW+jTWiW34EbM=;
 b=RWWG12j+Z+tMXARHLgkZFeC4/wiXcvEEcCn0ah1gfOA3AvOwVnmv8h6U6eKx6Ri04PeqKeZbmKzjDPxwqtBN+b74c1JMtJGetEELVfelT80LlH8ilgSdDAaKuChFQrR2JCrTgn/m5lMVCHTj5MQZw7TKiU+0oZLVpaK/TvT2k+w=
Received: from DS7PR07CA0019.namprd07.prod.outlook.com (2603:10b6:5:3af::7) by
 IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 04:22:30 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::ba) by DS7PR07CA0019.outlook.office365.com
 (2603:10b6:5:3af::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 04:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 04:22:29 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 22:22:27 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/4] drm/amd/pm: Add pm metrics support to SMU v13.0.6
Date: Wed, 8 Nov 2023 09:52:06 +0530
Message-ID: <20231108042207.528357-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108042207.528357-1-lijo.lazar@amd.com>
References: <20231108042207.528357-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4da842-8700-472a-e351-08dbe0125246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pau1HUmfIGy4ZeGm+ooZniLg2lm+tQhLkeUqoR2f04fEoM9q55Sa+FxxMtKpJUQPxmxukfnSRFz2+ILVN/ng2pQlpXN53tghvqPiVYLFlIkB7hZyR+1/rRDiJ/yZF6i9Yi3qena2nYclgmjElL6oHISmH8oYExdsjD4x8rTVCdiild+kAbMdjciBltEi1QJWwlPmmkUMPcllbwsIBC+PQGEF0UdmVOChHTx4vhWkGbh03g2szno4oBz1/b/CuAtDi8JjEADvhQh6si7MQSn6vQbzPm5xBpOSk3r9jsYcDnXZvWYqcXNkshBzNSVH1SavNQIeD0xdTbwOUt1LxROwFJ1M1lviFIhBXBWCWlPYPoRnKdRFVhMrda38uVF3jEez3eatVBJ44CDA8lX9474P7v6TJHigqaB7pQ1FHx0FcQqcaMdHX71pjyYd3uUQ8cSZ+c6Fq1ZdS+j8E2VsWgjikQRUJiv5X4l5Z5lN8WH1FDAlgmjqXpJP15ASoFHdG56Xc0w7XawWLHYV/MSKdL0opJZroffAvdIKQgTlGDbQJJolUMa7TfkjFYHANfv95VSoAHvIAFmWMJClURsQOPhy+qGSheAsUEw1RK1OB/qVrhb+bYSS8GlzgKxDy5AzMLk0wXoV97W4StTjR8FKzUs9yvRP6ivOg9Uw+4fQnC21GELfCLNS5qkqTXv7Cfj4SgW8EibvYnhAR91PdGvl/EqCQ0aJmXFJdxdzkOwqVzxZ2T1FxloWcl6aiTYsqZRoJjXZ0vNCHIKWYF28sV6iRpPlrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(8936002)(4326008)(8676002)(40460700003)(6916009)(316002)(70586007)(70206006)(54906003)(41300700001)(2906002)(44832011)(86362001)(5660300002)(83380400001)(426003)(81166007)(336012)(356005)(47076005)(2616005)(1076003)(26005)(82740400003)(16526019)(36860700001)(40480700001)(36756003)(7696005)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 04:22:29.6686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4da842-8700-472a-e351-08dbe0125246
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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

Add support to fetch PM metrics sample from SMU v13.0.6

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 20f66e696f87..cecd210397d6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -128,6 +128,7 @@ struct mca_ras_info {
 #define P2S_TABLE_ID_A 0x50325341
 #define P2S_TABLE_ID_X 0x50325358
 
+// clang-format off
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -136,6 +137,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(DisableAllSmuFeatures,		     PPSMC_MSG_DisableAllSmuFeatures,		0),
 	MSG_MAP(RequestI2cTransaction,		     PPSMC_MSG_RequestI2cTransaction,		0),
 	MSG_MAP(GetMetricsTable,		     PPSMC_MSG_GetMetricsTable,			1),
+	MSG_MAP(GetMetricsVersion,		     PPSMC_MSG_GetMetricsVersion,		1),
 	MSG_MAP(GetEnabledSmuFeaturesHigh,	     PPSMC_MSG_GetEnabledSmuFeaturesHigh,	1),
 	MSG_MAP(GetEnabledSmuFeaturesLow,	     PPSMC_MSG_GetEnabledSmuFeaturesLow,	1),
 	MSG_MAP(SetDriverDramAddrHigh,		     PPSMC_MSG_SetDriverDramAddrHigh,		1),
@@ -179,6 +181,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(SelectPLPDMode,                      PPSMC_MSG_SelectPLPDMode,                  0),
 };
 
+// clang-format on
 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] = {
 	CLK_MAP(SOCCLK, PPCLK_SOCCLK),
 	CLK_MAP(FCLK, PPCLK_FCLK),
@@ -436,6 +439,41 @@ static int smu_v13_0_6_get_metrics_table(struct smu_context *smu,
 	return 0;
 }
 
+static ssize_t smu_v13_0_6_get_pm_metrics(struct smu_context *smu,
+					  void *metrics, size_t max_size)
+{
+	struct smu_table_context *smu_tbl_ctxt = &smu->smu_table;
+	uint32_t table_version = smu_tbl_ctxt->tables[SMU_TABLE_SMU_METRICS].version;
+	uint32_t table_size = smu_tbl_ctxt->tables[SMU_TABLE_SMU_METRICS].size;
+	struct amdgpu_pm_metrics *pm_metrics = metrics;
+	uint32_t pmfw_version;
+	int ret;
+
+	if (!pm_metrics || !max_size)
+		return -EINVAL;
+
+	if (max_size < (table_size + sizeof(pm_metrics->common_header)))
+		return -EOVERFLOW;
+
+	/* Don't use cached metrics data */
+	ret = smu_v13_0_6_get_metrics_table(smu, pm_metrics->data, true);
+	if (ret)
+		return ret;
+
+	smu_cmn_get_smc_version(smu, NULL, &pmfw_version);
+
+	memset(&pm_metrics->common_header, 0,
+	       sizeof(pm_metrics->common_header));
+	pm_metrics->common_header.mp1_ip_discovery_version =
+		IP_VERSION(13, 0, 6);
+	pm_metrics->common_header.pmfw_version = pmfw_version;
+	pm_metrics->common_header.pmmetrics_version = table_version;
+	pm_metrics->common_header.structure_size =
+		sizeof(pm_metrics->common_header) + table_size;
+
+	return pm_metrics->common_header.structure_size;
+}
+
 static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -443,6 +481,7 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	struct PPTable_t *pptable =
 		(struct PPTable_t *)smu_table->driver_pptable;
 	int ret, i, retry = 100;
+	uint32_t table_version;
 
 	/* Store one-time values in driver PPTable */
 	if (!pptable->Init) {
@@ -461,6 +500,13 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 		if (!retry)
 			return -ETIME;
 
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsVersion,
+					   &table_version);
+		if (ret)
+			return ret;
+		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
+			table_version;
+
 		pptable->MaxSocketPowerLimit =
 			SMUQ10_ROUND(metrics->MaxSocketPowerLimit);
 		pptable->MaxGfxclkFrequency =
@@ -2889,6 +2935,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.log_thermal_throttling_event = smu_v13_0_6_log_thermal_throttling_event,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
+	.get_pm_metrics = smu_v13_0_6_get_pm_metrics,
 	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
 	.mode1_reset_is_support = smu_v13_0_6_is_mode1_reset_supported,
 	.mode2_reset_is_support = smu_v13_0_6_is_mode2_reset_supported,
-- 
2.25.1

