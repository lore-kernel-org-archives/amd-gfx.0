Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB86C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518FD610A1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518FD610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175F06EA9F;
	Tue,  1 Jun 2021 18:14:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05AB6E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 18:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwIFTeoPtYXrfINeZKGzJvjLmC7BlPpY+R1/yg5+x5GkV9mP1qHqGTb7HEBAvsyJYLhauKyf8y8Nx86NcNEw2RjuZGftytB8VXuTFBmKZrLtFPvGcIWl9/eZUCTN6R/7JpWhc0roIyhqDxTHe0HxBkiSwnfibHoT5HoqLj3Kfi13cYbhRwozt6aqI64UZ/UlTMkLLHrxvjCUCexxgUP4d0xk2fwXGjHGMGYjS/I+sRVHaawSVrK01Z8zZSADU22TxtpaHIiMfUcHo/hZsHzdlDcORloDm19Y0gX8Ir4Ft48JSW8jTm+KnJBpmj4uLuezZRn6XfQ2WqZiVxoonHTY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIi5NWbwFnK217SsUQmBaKq4pfIahRGFEIk4onz16uc=;
 b=UoPqEXiEd+KTYoMBgXN0a85e4Gzh2H96KhwV9ZrfTtyIpjXvL2WgcCt7YCG8BP+Pdxk+u0455XTglGLvyzGzzdVXoGz6l8AwuqGyaI0glY7y47AGPCLb3ip97MFNhxB05JlLhgX/4RcH/d7hhSBmtWJA5RQoB7XaKVjl2G0gLkrSZVLnLZijSYnUO+7gf38gF6H4KzwFg4VadFFR034p75Venro8x/cKAlgDA0zI5KTwXD2k/m4bniEXBi6P8k3BwRcdAC3VsM+zDdrjLoWIJOb8/jknc11slJW4X7T88oUr5sTmAcIqq+rwChr/ltEqiKUVwubY4zg148OnnMUWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIi5NWbwFnK217SsUQmBaKq4pfIahRGFEIk4onz16uc=;
 b=1R5HHv9CQvBfcJ+JRsDyqWRq5tc+Cdhu25rqcaID4Bz9ztWUTAziCNaQiWGqYamOriQX/iBvzAYbGUEh8lZo0R5Pv/hibWFC9SVhIKT6Be6dSFI45zLNc1eEKWc83NfBYWTiJgYI8XGiddsSHFIbe8EeO8dr+Z8rT65JFk9cUPU=
Received: from DM5PR21CA0056.namprd21.prod.outlook.com (2603:10b6:3:129::18)
 by BL1PR12MB5191.namprd12.prod.outlook.com (2603:10b6:208:318::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 18:14:04 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::21) by DM5PR21CA0056.outlook.office365.com
 (2603:10b6:3:129::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.3 via Frontend
 Transport; Tue, 1 Jun 2021 18:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 18:14:04 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:14:01 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/8] drm/amd/pm: Add sienna cichlid throttler translation
Date: Tue, 1 Jun 2021 14:12:28 -0400
Message-ID: <20210601181231.24773-5-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210601181231.24773-1-Graham.Sider@amd.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589ee397-dcbe-4971-eb4e-08d925290a2d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5191:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51911BA334D53415B05FA2788A3E9@BL1PR12MB5191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHSRILlazZ7eqWbhHB1tf+TyttX6IAB/RCOLbyzvKQpPMhe2Sh8q3sbQFqNbJJ881J+nGGN/MS547kTGa+26Exa5pjet5kk7D+/zir3zVHwQZZ9gDwPmXJ/ZcqfqbtwVMMq/juuxxD9scCRQF0Kd62QX3rzUNLJwQF/Imu8DFWyroVp3o6K/87kN9S19bYb/b1jGzblVMb/EUdI25cpCG5YYadat1VSiSUfTFCeCsASn2NCqJ2OLwDMSlGtf0ZjmT6AgCSodsXCF9eVXHZB7h2rBpDj2e8cV6mhAfsszoZHXfQ0c5w+UaIM+sGP51/wGDjlLc4I9J22UuC9yM6Acexy/fRYStn/cjlssmQuNjM9l6oF544am43oOyHIU1EOgc/ntbTq6IkQEQj4F90QdcE/x9fAQvrLMWRWfwT6Y/NZMKr0R4daYHlKFhOUw7tGO7pcSQNLtdMr2WjnDwOXgC4FcT6dPnKTrTo5c9Yfih5A+FdwUGz/AQL0wPCXbiCwZyj9xt965SsxY7OZijnEcOiBR8vMi0TtQdfS69l1W4wmWP6VLDMrwhneP4qhb5oloM7p8EaBuxD+z8gck5N3ODUfpZCsD27w73HGglBJMn89PS8czXGCvewlMjlmwTXCGRzm6hS06gYfoqvU/16mMu0MfWRTbdCOnxFfz4f2DcqPcfrdV65KC7nONyReSucOP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(46966006)(5660300002)(83380400001)(1076003)(47076005)(336012)(426003)(82310400003)(86362001)(6916009)(478600001)(8676002)(36860700001)(16526019)(8936002)(82740400003)(70586007)(6666004)(70206006)(356005)(4326008)(54906003)(2906002)(186003)(81166007)(36756003)(2616005)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 18:14:04.3274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589ee397-dcbe-4971-eb4e-08d925290a2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5191
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
Cc: Lijo.Lazar@amd.com, Harish.Kasiviswanathan@amd.com,
 Graham Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform dependent to independent throttle status translation
for sienna cichlid. Makes use of lookup table
sienna_cichlid_throttler_map.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 46 +++++++++++++++++--
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 75acdb80c499..c26983a860ff 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -239,6 +239,27 @@ static struct cmn2asic_mapping sienna_cichlid_workload_map[PP_SMC_POWER_PROFILE_
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t sienna_cichlid_throttler_map[] = {
+	[THROTTLER_TEMP_EDGE_BIT]	= (SMU_THROTTLER_TEMP_EDGE_BIT),
+	[THROTTLER_TEMP_HOTSPOT_BIT]	= (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_MEM0_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
+	[THROTTLER_TEMP_VR_MEM1_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TEMP_LIQUID0_BIT]	= (SMU_THROTTLER_TEMP_LIQUID_BIT),
+	[THROTTLER_TEMP_LIQUID1_BIT]	= (SMU_THROTTLER_TEMP_LIQUID_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_PPT2_BIT]		= (SMU_THROTTLER_PPT2_BIT),
+	[THROTTLER_PPT3_BIT]		= (SMU_THROTTLER_PPT3_BIT),
+	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
+	[THROTTLER_PPM_BIT]		= (SMU_THROTTLER_PPM_BIT),
+	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
+};
+
 static int
 sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 				  uint32_t *feature_mask, uint32_t num)
@@ -434,7 +455,7 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table)
 		goto err1_out;
@@ -453,6 +474,19 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 	return -ENOMEM;
 }
 
+static uint64_t sienna_cichlid_get_indep_throttler_status(
+					const unsigned long dep_status)
+{
+	uint64_t indep_status = 0;
+	uint8_t dep_bit = 0;
+
+	for_each_set_bit(dep_bit, &dep_status, 32)
+		indep_status |= smu_u64_throttler_bit(dep_status,
+			sienna_cichlid_throttler_map[dep_bit], dep_bit);
+
+	return indep_status;
+}
+
 static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 					       MetricsMember_t member,
 					       uint32_t *value)
@@ -3617,8 +3651,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 					      void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetricsExternal_t metrics_external;
 	SmuMetrics_t *metrics =
 		&(metrics_external.SmuMetrics);
@@ -3632,7 +3666,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics->TemperatureHotspot;
@@ -3667,6 +3701,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
 
 	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			sienna_cichlid_get_indep_throttler_status(metrics->ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
 
@@ -3689,7 +3725,7 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
 }
 
 static int sienna_cichlid_enable_mgpu_fan_boost(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
