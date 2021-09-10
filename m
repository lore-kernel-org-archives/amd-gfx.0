Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868ADC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4811F61153
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 09:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4811F61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57556E9A8;
	Fri, 10 Sep 2021 09:10:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3406E9A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 09:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cipGso/+FSWy1Noh7Oiqw8KGC3Dmi8i/DCTIeyKY12A0v1gaI97YxPFprZL83Z6rQ9VUdahxZYfVtwjMOK3jf9mq6kjAtO7n4WVz8og8DTscHzCSBw7shksxrcQIIVFCi3CdpHW7GmRk0hyc6hIV4ao1DBNmNz+C1yLrqYz1SSf8DNjOj0tXzpzctpVIeJYvkCJVVmSZ0+6yL6YCCq7nPeyKdIynTuRBXqIHyD16slXYzNBBxf9tjBdDgGp5P3ZgtNXQJ6dbedtVaisx6W2As+qi8XD5JGwXpwpHjwMBdx+rTnAkLP099Qcc9aJH32w36IPNKHfk4nm6e7Us4wsnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=PdXunOcyOTrG2DS1EyZqYflpjnMA/g89h2fplREe4eU=;
 b=NC6CRmuAFtoDD5yppjKr3aNXKa5kcZQuES9lFMxAeoIu4fEeFSNzBORq7HK8zNGgRK7EcqVvKDJOURrvP9TZXlWF9JZG0cJb2UUFhEJU6wrBUc4LgSfXKwlPMwRHWSwZNoVv/tvmAZEsgIlzg4qGO01vVsoT7dhtK/Y1+MEMmfOQ2N+3Ym2RyEsifpK/HxY7dcJmvnzBiZtfU64odOvoyLVO2S8Q3tlisnjJQ7UM8GeMp++1+kWxH2XYSSD90m5NtW5XQkOj5VYd80J1ujznPPQNJWdK0pTjiG3kl06V07J5QBiXdWAr4ncPRjMHmHUn8DuDknS5hdPMxIWbCQHKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdXunOcyOTrG2DS1EyZqYflpjnMA/g89h2fplREe4eU=;
 b=e9nckTvcHuZMOwOFJMHiXt5fJqLu+c+fLLRVy4bi8TuPeCMZllVKJDQ57FrtVWdovlOcQWXP0Y2xKnp27mjhWDk/wkuG5fLEdjY2QOd1AmyNjC3Qx/ch60mEOBEPe1q9Si4ZY71Vcvvkl6W+xNycKnaLPdYz3SAnpB+N5cOwpJ0=
Received: from MW4PR03CA0275.namprd03.prod.outlook.com (2603:10b6:303:b5::10)
 by MWHPR12MB1950.namprd12.prod.outlook.com (2603:10b6:300:110::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 09:10:07 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f9) by MW4PR03CA0275.outlook.office365.com
 (2603:10b6:303:b5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 09:10:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 09:10:07 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 04:10:05 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Lang Yu <lang.yu@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu: add some pptable funcs for cyan
 skilfish(v3)
Date: Fri, 10 Sep 2021 17:09:46 +0800
Message-ID: <20210910090946.969839-3-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910090946.969839-1-lang.yu@amd.com>
References: <20210910090946.969839-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c623231a-f367-4d81-6a4d-08d9743ac8d8
X-MS-TrafficTypeDiagnostic: MWHPR12MB1950:
X-Microsoft-Antispam-PRVS: <MWHPR12MB19500AC0007FE60143976CB3FBD69@MWHPR12MB1950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRntfA5kV4t2a0fSJrFtD3iO08VXyhba+/fqidc07CHCtsNC+zBE0bc1RecoKHyzdlcEbnc8NHueeY4hree1z8jcuDeGGIzohE+3cJrcUhbaRsS/rzi2CYe/wbiYko0lc9CCLP44X5vOJGNbEYSfVFCDUZaqOIeZWAoToXFRE+yIkPtlxuXpLEMnLU3OxH9XPHOqB3N8om8YrRGgsh7+HqobUag7MjG6nuiAYekAAdDubRYhJqef+oAWArxSWhM4dxkoxL0A+wm8WZMKtVx6KvbvYuCHYUPaI9EqEDlf2Q9rTw0ZimXmbZvsqs0Vq4+OWVk452+TglI1jW/KvGr4PYQYwtYXywM3YTMCN9mgqyl7vXNyxQLbHDL41k32ar0Cu4H4Vy8PBz7ijKqGJuaXCvttEtdbVvyGqKYpg2MxHArP0uFHHr4CmMlyKW2yUHrd8V6LTJ7fVZJ0ZlKJPpRWOXixDSNPfZxBTCSuhZS4pGa9fhnj+HywTv03ddYPmWwjLiVcsJUf8odnYgBEPMOcQRDeoY9ugYVZ5Duo1JZkWXTLiibACmrMp4wrzs5LmZcx1J1UJg0ouiPAZr5cRzIIqKu0pdPpOpib7EcnwCqBoc8z17vR9QMmfOJCTKdwITLIV/nsods5FvO4iVafvYU3KeF4DEmVw/VsmAhsw9d3vq35LCLhduI6dbLHuk6qYEs0k8EV32ph8WfsvtcM6qGiUckTN6LPTaTXn6gdU6HqpsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(1076003)(186003)(16526019)(26005)(4326008)(8936002)(36860700001)(70586007)(70206006)(82310400003)(478600001)(316002)(44832011)(54906003)(36756003)(86362001)(426003)(336012)(30864003)(82740400003)(2616005)(5660300002)(2906002)(81166007)(7696005)(47076005)(6666004)(8676002)(6916009)(356005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 09:10:07.4438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c623231a-f367-4d81-6a4d-08d9743ac8d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1950
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add print_clk_levels and read_sensor pptable funcs for
cyan skilfish.

v2: keep consitency and add get_gpu_metrics callback.
v3: use sysfs_emit_at() in sysfs show function.

Signed-off-by: Lang Yu <lang.yu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 347 ++++++++++++++++++
 1 file changed, 347 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index b05f9541accc..e1fab030cfc5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -44,6 +44,12 @@
 #undef pr_info
 #undef pr_debug
 
+#define FEATURE_MASK(feature) (1ULL << feature)
+#define SMC_DPM_FEATURE ( \
+	FEATURE_MASK(FEATURE_FCLK_DPM_BIT)	|	\
+	FEATURE_MASK(FEATURE_SOC_DPM_BIT)	|	\
+	FEATURE_MASK(FEATURE_GFX_DPM_BIT))
+
 static struct cmn2asic_msg_mapping cyan_skillfish_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		0),
@@ -52,14 +58,354 @@ static struct cmn2asic_msg_mapping cyan_skillfish_message_map[SMU_MSG_MAX_COUNT]
 	MSG_MAP(SetDriverDramAddrLow,           PPSMC_MSG_SetDriverTableDramAddrLow,	0),
 	MSG_MAP(TransferTableSmu2Dram,          PPSMC_MSG_TransferTableSmu2Dram,	0),
 	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	0),
+	MSG_MAP(GetEnabledSmuFeatures,          PPSMC_MSG_GetEnabledSmuFeatures,	0),
+	MSG_MAP(RequestGfxclk,                  PPSMC_MSG_RequestGfxclk,		0),
+	MSG_MAP(ForceGfxVid,                    PPSMC_MSG_ForceGfxVid,			0),
+	MSG_MAP(UnforceGfxVid,                  PPSMC_MSG_UnforceGfxVid,		0),
+};
+
+static struct cmn2asic_mapping cyan_skillfish_table_map[SMU_TABLE_COUNT] = {
+	TAB_MAP_VALID(SMU_METRICS),
 };
 
+static int cyan_skillfish_tables_init(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
+				sizeof(SmuMetrics_t),
+				PAGE_SIZE,
+				AMDGPU_GEM_DOMAIN_VRAM);
+
+	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
+	if (!smu_table->metrics_table)
+		goto err0_out;
+
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err1_out;
+
+	smu_table->metrics_time = 0;
+
+	return 0;
+
+err1_out:
+	smu_table->gpu_metrics_table_size = 0;
+	kfree(smu_table->metrics_table);
+err0_out:
+	return -ENOMEM;
+}
+
+static int cyan_skillfish_init_smc_tables(struct smu_context *smu)
+{
+	int ret = 0;
+
+	ret = cyan_skillfish_tables_init(smu);
+	if (ret)
+		return ret;
+
+	return smu_v11_0_init_smc_tables(smu);
+}
+
+static int cyan_skillfish_finit_smc_tables(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+
+	kfree(smu_table->metrics_table);
+	smu_table->metrics_table = NULL;
+
+	kfree(smu_table->gpu_metrics_table);
+	smu_table->gpu_metrics_table = NULL;
+	smu_table->gpu_metrics_table_size = 0;
+
+	smu_table->metrics_time = 0;
+
+	return 0;
+}
+
+static int
+cyan_skillfish_get_smu_metrics_data(struct smu_context *smu,
+					MetricsMember_t member,
+					uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
+	int ret = 0;
+
+	mutex_lock(&smu->metrics_lock);
+
+	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
+	if (ret) {
+		mutex_unlock(&smu->metrics_lock);
+		return ret;
+	}
+
+	switch (member) {
+	case METRICS_CURR_GFXCLK:
+		*value = metrics->Current.GfxclkFrequency;
+		break;
+	case METRICS_CURR_SOCCLK:
+		*value = metrics->Current.SocclkFrequency;
+		break;
+	case METRICS_CURR_VCLK:
+		*value = metrics->Current.VclkFrequency;
+		break;
+	case METRICS_CURR_DCLK:
+		*value = metrics->Current.DclkFrequency;
+		break;
+	case METRICS_CURR_UCLK:
+		*value = metrics->Current.MemclkFrequency;
+		break;
+	case METRICS_AVERAGE_SOCKETPOWER:
+		*value = (metrics->Current.CurrentSocketPower << 8) /
+				1000;
+		break;
+	case METRICS_TEMPERATURE_EDGE:
+		*value = metrics->Current.GfxTemperature / 100 *
+				SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = metrics->Current.SocTemperature / 100 *
+				SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_VOLTAGE_VDDSOC:
+		*value = metrics->Current.Voltage[0];
+		break;
+	case METRICS_VOLTAGE_VDDGFX:
+		*value = metrics->Current.Voltage[1];
+		break;
+	case METRICS_THROTTLER_STATUS:
+		*value = metrics->Current.ThrottlerStatus;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	mutex_unlock(&smu->metrics_lock);
+
+	return ret;
+}
+
+static int cyan_skillfish_read_sensor(struct smu_context *smu,
+					enum amd_pp_sensors sensor,
+					void *data,
+					uint32_t *size)
+{
+	int ret = 0;
+
+	if (!data || !size)
+		return -EINVAL;
+
+	mutex_lock(&smu->sensor_lock);
+
+	switch (sensor) {
+	case AMDGPU_PP_SENSOR_GFX_SCLK:
+		ret = cyan_skillfish_get_smu_metrics_data(smu,
+						   METRICS_CURR_GFXCLK,
+						   (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GFX_MCLK:
+		ret = cyan_skillfish_get_smu_metrics_data(smu,
+						   METRICS_CURR_UCLK,
+						   (uint32_t *)data);
+		*(uint32_t *)data *= 100;
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_GPU_POWER:
+		ret = cyan_skillfish_get_smu_metrics_data(smu,
+						   METRICS_AVERAGE_SOCKETPOWER,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
+		ret = cyan_skillfish_get_smu_metrics_data(smu,
+						   METRICS_TEMPERATURE_HOTSPOT,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+		ret = cyan_skillfish_get_smu_metrics_data(smu,
+						   METRICS_TEMPERATURE_EDGE,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDNB:
+		ret = cyan_skillfish_get_smu_metrics_data(smu,
+						   METRICS_VOLTAGE_VDDSOC,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = cyan_skillfish_get_smu_metrics_data(smu,
+						   METRICS_VOLTAGE_VDDGFX,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	mutex_unlock(&smu->sensor_lock);
+
+	return ret;
+}
+
+static int cyan_skillfish_get_current_clk_freq(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t *value)
+{
+	MetricsMember_t member_type;
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		member_type = METRICS_CURR_GFXCLK;
+		break;
+	case SMU_FCLK:
+	case SMU_MCLK:
+		member_type = METRICS_CURR_UCLK;
+		break;
+	case SMU_SOCCLK:
+		member_type = METRICS_CURR_SOCCLK;
+		break;
+	case SMU_VCLK:
+		member_type = METRICS_CURR_VCLK;
+		break;
+	case SMU_DCLK:
+		member_type = METRICS_CURR_DCLK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return cyan_skillfish_get_smu_metrics_data(smu, member_type, value);
+}
+
+static int cyan_skillfish_print_clk_levels(struct smu_context *smu,
+					enum smu_clk_type clk_type,
+					char *buf)
+{
+	int ret = 0, size = 0;
+	uint32_t cur_value = 0;
+
+	smu_cmn_get_sysfs_buf(&buf, &size);
+
+	switch (clk_type) {
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+	case SMU_FCLK:
+	case SMU_MCLK:
+	case SMU_SOCCLK:
+	case SMU_VCLK:
+	case SMU_DCLK:
+		ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, &cur_value);
+		if (ret)
+			return ret;
+		size += sysfs_emit_at(buf, size, "0: %uMhz *\n", cur_value);
+		break;
+	default:
+		dev_warn(smu->adev->dev, "Unsupported clock type\n");
+		return ret;
+	}
+
+	return size;
+}
+
+static bool cyan_skillfish_is_dpm_running(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+	uint32_t feature_mask[2];
+	uint64_t feature_enabled;
+
+	/* we need to re-init after suspend so return false */
+	if (adev->in_suspend)
+		return false;
+
+	ret = smu_cmn_get_enabled_32_bits_mask(smu, feature_mask, 2);
+
+	if (ret)
+		return false;
+
+	feature_enabled = (uint64_t)feature_mask[0] |
+				((uint64_t)feature_mask[1] << 32);
+
+	return !!(feature_enabled & SMC_DPM_FEATURE);
+}
+
+static ssize_t cyan_skillfish_get_gpu_metrics(struct smu_context *smu,
+						void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v2_2 *gpu_metrics =
+		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int i, ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	if (ret)
+		return ret;
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
+
+	gpu_metrics->temperature_gfx = metrics.Current.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.Current.SocTemperature;
+
+	gpu_metrics->average_socket_power = metrics.Current.CurrentSocketPower;
+	gpu_metrics->average_soc_power = metrics.Current.Power[0];
+	gpu_metrics->average_gfx_power = metrics.Current.Power[1];
+
+	gpu_metrics->average_gfxclk_frequency = metrics.Average.GfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.Average.SocclkFrequency;
+	gpu_metrics->average_uclk_frequency = metrics.Average.MemclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.Average.MemclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.Average.VclkFrequency;
+	gpu_metrics->average_dclk_frequency = metrics.Average.DclkFrequency;
+
+	gpu_metrics->current_gfxclk = metrics.Current.GfxclkFrequency;
+	gpu_metrics->current_socclk = metrics.Current.SocclkFrequency;
+	gpu_metrics->current_uclk = metrics.Current.MemclkFrequency;
+	gpu_metrics->current_fclk = metrics.Current.MemclkFrequency;
+	gpu_metrics->current_vclk = metrics.Current.VclkFrequency;
+	gpu_metrics->current_dclk = metrics.Current.DclkFrequency;
+
+	for (i = 0; i < 6; i++) {
+		gpu_metrics->temperature_core[i] = metrics.Current.CoreTemperature[i];
+		gpu_metrics->average_core_power[i] = metrics.Average.CorePower[i];
+		gpu_metrics->current_coreclk[i] = metrics.Current.CoreFrequency[i];
+	}
+
+	for (i = 0; i < 2; i++) {
+		gpu_metrics->temperature_l3[i] = metrics.Current.L3Temperature[i];
+		gpu_metrics->current_l3clk[i] = metrics.Current.L3Frequency[i];
+	}
+
+	gpu_metrics->throttle_status = metrics.Current.ThrottlerStatus;
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v2_2);
+}
+
 static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 
 	.check_fw_status = smu_v11_0_check_fw_status,
 	.check_fw_version = smu_v11_0_check_fw_version,
 	.init_power = smu_v11_0_init_power,
 	.fini_power = smu_v11_0_fini_power,
+	.init_smc_tables = cyan_skillfish_init_smc_tables,
+	.fini_smc_tables = cyan_skillfish_finit_smc_tables,
+	.read_sensor = cyan_skillfish_read_sensor,
+	.print_clk_levels = cyan_skillfish_print_clk_levels,
+	.is_dpm_running = cyan_skillfish_is_dpm_running,
+	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
 	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
@@ -72,5 +418,6 @@ void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &cyan_skillfish_ppt_funcs;
 	smu->message_map = cyan_skillfish_message_map;
+	smu->table_map = cyan_skillfish_table_map;
 	smu->is_apu = true;
 }
-- 
2.25.1

