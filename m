Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A251C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3150F613BD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 18:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3150F613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C086E0F8;
	Tue,  1 Jun 2021 18:14:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F72C6EAD5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 18:14:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jy/ZFYjEt9sR/BF2mvjwFyHTbV62N48jYdmOS2b0f3R+pUEIFRLUrgCKes6q8S4H0p4X32TDMcShoGO/zTR4VuBcpTQmVoLmiwHCS3L7ErrMZeRwgwwqTehhlGVBXpvs8GGQ8hMuYvxVOXmOnwp9k0jftvFfWFSt5A0YPLLAVP1dCFkjNvIkohVTsez1RYmFOKv/vNgNDDMxUD8AyzwitqFrVJuBLm2S2ZVc5AoK+uD9gxeeQ9culTyZjtauQ/uhGjLE1XFokV9V/N6peCZwg3aSkUTvWPwbp0orF2x8tEi2r3CyWLzjhUMr07mAsg3F3f52mTcRU9ci17ULgfscNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS+H3AR7MiITxc1Rk1Lp+m8v21QlQPrJECmHBYKSTDU=;
 b=K/WzbZm4sA/fIQ2L5o0kvL/0pz3FOy0O8x6ahU6ul66xCc8JP7IxhBRcpdqovN1RDIHlLrsOjT8hzKwwQOyb2cHfdk+TwJJ7xIi9xDi819EZ2F7+dCTOGfCJV/syD8mn22y3z4AYXaReO7fqaqXcu019dCoKfd6bOpskX1x1RIkXLC8yfvXrtALPGF0pzA/vRddRki8UxvxKhxf4NuGMZpeKaDQOhENedNmIE/eAn2WX5hjuuixjL3D0SFqINOln86bzrFBSM/JXx45AfNmEFI8duO9CtpZOZCGgOWe+z4LWLqZ3i81jgHdjSIxPiF54bCZS9dwJaoMGT7ogOEgs4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS+H3AR7MiITxc1Rk1Lp+m8v21QlQPrJECmHBYKSTDU=;
 b=eab9KIq8Umx5kPx8XJKpCFwdIS/KfOXF4sStavK5LFsG9WEOxTvhlWTqeDQVYiBbNPpFdT+JOObdf8j1XPUVyb6aWX7dih/LpuVF2HoFveyzTgVe0ntuns//Gfa2qzc2VZT0slgaFJQveBX6xG+U7gQ+1dhe1IHHVYq64se4K1I=
Received: from DM6PR14CA0055.namprd14.prod.outlook.com (2603:10b6:5:18f::32)
 by MN2PR12MB4848.namprd12.prod.outlook.com (2603:10b6:208:1be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 18:13:59 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::db) by DM6PR14CA0055.outlook.office365.com
 (2603:10b6:5:18f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 18:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 18:13:59 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 13:13:56 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/8] drm/amd/pm: Add arcturus throttler translation
Date: Tue, 1 Jun 2021 14:12:26 -0400
Message-ID: <20210601181231.24773-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210601181231.24773-1-Graham.Sider@amd.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a9c7336-feb5-4603-0487-08d92529071e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4848:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4848AD8D9E4EDAF2350AA58F8A3E9@MN2PR12MB4848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lqs2v04pMcUwM/GNhTlZNcWVaeWVQhwfpQBiKjixvcDQVT/6nFOPq3pUrUK9Eit/5diBykf0o7zmuDiiXn94gKE3wP5j7OOwIFU8TJ0lc82waWxmgl2DbdxezfR3q1Pi1SfkxzfXMvH+tTCsxI1Lx43Z35yWe7bT/blCaX2FA8eXElbCW7q/o5aMTsNUnIOex6lOhRQ5gpHMzjkYaBf8rqNQKmXMlJOKCt9+hPMMQxu3KkH95F/jgc44ntJ5tRxFDTkA5NOMfTpGvSiUTkTSPpUcXpCnf44IC1r9y16LmWmxCUpb/u36+Meh4KutTzGhqMbwdb48jm6SquMNEEJERU3iFrc8QFuqFiCIpjrONJdKPv8B793f8Khvnz0G0WtrprQv/FSsPafHJndlQqLHB6mwA2HkLhfIQpd68byINztiPRM0PfbVrGSGBn8o8nvrEvYV49FCZ5o59OLSP2KREKVTpuU9Tr+ztMTi+WPA7MOm4soWpGkYt8qRxD4DcdiK8XSuwH1Q0xqRD/ygdUMQZIKXGfZMbLHheonC3InnCMfktIZcK2GnLl84ures81tvnw9xGrFN2AknIjTbqTLINSj4NOAtxW2QqnkGSneAPIzS9DPASwuyPqSVa3gFjwl4fxIJzoTfV9whan52kv5HmnMm/rkvmZSQxmB0Pf/9d3mvIBaZyTxWUNB/EhwDfLBE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(36840700001)(46966006)(5660300002)(2906002)(82740400003)(82310400003)(356005)(8676002)(336012)(316002)(86362001)(36860700001)(26005)(36756003)(6916009)(1076003)(70586007)(186003)(81166007)(8936002)(6666004)(54906003)(83380400001)(478600001)(2616005)(426003)(47076005)(4326008)(16526019)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 18:13:59.2010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9c7336-feb5-4603-0487-08d92529071e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4848
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
for arcturus. Makes use of lookup table arcturus_throttler_map.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1735a96dd307..c0bfd5634fca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -211,6 +211,26 @@ static const struct cmn2asic_mapping arcturus_workload_map[PP_SMC_POWER_PROFILE_
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
 };
 
+static const uint8_t arcturus_throttler_map[] = {
+	[THROTTLER_TEMP_EDGE_BIT]	= (SMU_THROTTLER_TEMP_EDGE_BIT),
+	[THROTTLER_TEMP_HOTSPOT_BIT]	= (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_MEM_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_PPT2_BIT]		= (SMU_THROTTLER_PPT2_BIT),
+	[THROTTLER_PPT3_BIT]		= (SMU_THROTTLER_PPT3_BIT),
+	[THROTTLER_PPM_BIT]		= (SMU_THROTTLER_PPM_BIT),
+	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
+	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
+	[THROTTLER_VRHOT0_BIT]		= (SMU_THROTTLER_VRHOT0_BIT),
+	[THROTTLER_VRHOT1_BIT]		= (SMU_THROTTLER_VRHOT1_BIT),
+};
+
 static int arcturus_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -237,7 +257,7 @@ static int arcturus_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -540,6 +560,19 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
+static uint64_t arcturus_get_indep_throttler_status(
+					const unsigned long dep_status)
+{
+	uint64_t indep_status = 0;
+	uint8_t dep_bit = 0;
+
+	for_each_set_bit(dep_bit, &dep_status, 32)
+		indep_status |= smu_u64_throttler_bit(dep_status,
+			arcturus_throttler_map[dep_bit], dep_bit);
+
+	return indep_status;
+}
+
 static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 					 MetricsMember_t member,
 					 uint32_t *value)
@@ -2275,8 +2308,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 					void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -2286,7 +2319,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2315,6 +2348,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2327,7 +2362,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_1);
+	return sizeof(struct gpu_metrics_v1_3);
 }
 
 static const struct pptable_funcs arcturus_ppt_funcs = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
