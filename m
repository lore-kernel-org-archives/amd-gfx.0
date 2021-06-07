Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDE9C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6221961153
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 13:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6221961153
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEDDB6E8D1;
	Mon,  7 Jun 2021 13:45:26 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED856E8D5
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 13:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8V9emKQxezv+XOZEiIjXaIS84mHO/TtZC5SDnJS2+Lk2SLJC0etqbAdY+p190aijCfiWkTu0bU0WjQt0HLwT4I/N9Uhhtbk57hUz6AwerNifAug19BmFh50k4IjNAaF0dcOVrxcXty00LcSs5d/h7pGMKTF2dSfNnY9sGeX/5uEtJXXvHl45bRgEbq3nWXrLNgZ1nsWVZ27rPUbhX66E7895BCigG1Q8u9Wzhu601qs6BhTgIk4mv/2bDxr0TmRM+LWhHanI2FaBDDFbRlI2/6/LEZqriIKrW1Yf4OlrrKOcSNZN9rmXU7r8i4hO4ggNwhSzgc/yyGfkqQPgBHGsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sPCiWHBeubiN6nuSUitAEQ75gp9BvBX1dlngNb2pqg=;
 b=X9w8O8Ok8CP8Fflmefhe6zzX8HdyJzasBYsVGGJVGFSAZ8TWAE1/JHz+1G2jMSRhAndkH0m/9PR5bpzMlytbVjK2ADXUtV+Aa2Oo2/MD2hOu8mNHJ+gTg8rbcI4PJ65603as1nKLxmGBAmQs2nUtTg2Ykab33Qn6Eu8d0WxIGgdfdSaZhlRy5RC2ECB7q1AHvLpV3kMZ0WoNcTOIB3/ScbJevaKbuehzhLLksOZ9g/Y1gSCA0Em9BdAO2CYBhUiqpLMU7UTWD7cADfGr56z7bMsTSkqe5PE4c7lIWJUCuHW+RetZgFfpJn0JmPq9ZLC62x1QlxAUzSRKxCkcSU3v0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sPCiWHBeubiN6nuSUitAEQ75gp9BvBX1dlngNb2pqg=;
 b=yPCp8ts8DBGh8NaqMgKtvUWyabhpfikR0TeQRkHl1feVDCQ1EPtRV8RkxHp+4CXkiNTzReUIOYAm0jumtzZXlnggKjcsn0FymPixb5ZBNFA0yHq/kXnsxyqLdeNVE+07+uGqKpk1RxtkzEmz+DBuu/vm99yZou53phwMqe1hw1w=
Received: from BN6PR18CA0005.namprd18.prod.outlook.com (2603:10b6:404:121::15)
 by DM6PR12MB3882.namprd12.prod.outlook.com (2603:10b6:5:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Mon, 7 Jun
 2021 13:45:21 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::bb) by BN6PR18CA0005.outlook.office365.com
 (2603:10b6:404:121::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend
 Transport; Mon, 7 Jun 2021 13:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 13:45:20 +0000
Received: from grasider-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 08:45:18 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 9/9] drm/amd/pm: Add aldebaran throttler translation
Date: Mon, 7 Jun 2021 09:44:39 -0400
Message-ID: <20210607134439.28542-9-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210607134439.28542-1-Graham.Sider@amd.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c487397-95b9-411f-a0eb-08d929ba7e4d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3882:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3882A366300C942D5CC06B9D8A389@DM6PR12MB3882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LgFdqGQb5HKbTLM/WuCmO97IX/Dor6PCO2qacBEuktaNmtnLsk0RBt0q9c545UAlf9CQSbNOPP06BoSJDIvFTPnwSGAs/aKlnpMVtqJPP7xgIEcptjAZqw+jwd+FK92ZsZx+wkYtipUJV3v2CXeaC+R958vBpa/5U54LpOo88DxAO5QhjvDmM+NQ9VC0XPUED2MGXaf0I28lJNb9g6/SoP0b0vS1EAZR+5Z149/RDRIe2/ahlZujgL1jgt5FCW02RQDwnUgzivUcnMyR495Sq8dofgVvxHqb7Ut/gDLtFidOz41Z4szc5fl6uFrH4oXl9494kQytFw/EsCTJHe2ybfNzqYmd0c4m+YGtyo77ZabWWiya3BQxkXkfAlDbgN4dNk0WBt3GWSqVRP3ygIQcufc9fRTHcJXJT2cXuFMHLkQ3EeifnVvG6hTvEShagSkGLc/Dl9q2TDLlKF8y1JA7cr4B0cAs5P+770nMQeu2pIIYAUhd3psNzaqvl90s5lDyPrp9yI/QX85x5/ZVYIustIO1u9GuY2oyq/KwsyC2jLM1Pf75LNFBW9grnuftNbHRJSx91zUyhgL/TT+DFlc5sLLUEWu1KDpYRK/lBSOa117+zTJNWmOZSng3+0epVqFunfqxBw1lcBPky3lm5s73SBNBiGuLbonOVkGxaessz+7kFa3eugUoFgjIW9741wf2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(46966006)(478600001)(47076005)(8936002)(4326008)(36860700001)(2616005)(356005)(426003)(6666004)(8676002)(36756003)(82310400003)(82740400003)(2906002)(5660300002)(336012)(83380400001)(6916009)(86362001)(54906003)(70206006)(1076003)(186003)(26005)(7696005)(16526019)(70586007)(81166007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 13:45:20.8879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c487397-95b9-411f-a0eb-08d929ba7e4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3882
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
Cc: Harish.Kasiviswanathan@amd.com, Graham
 Sider <Graham.Sider@amd.com>, Elena.Sakhnovitch@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform dependent to independent throttle status translation
for aldebaran.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 7a1abb3d6a7a..0845d4b30a0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -191,6 +191,20 @@ static const struct cmn2asic_mapping aldebaran_table_map[SMU_TABLE_COUNT] = {
 	TAB_MAP(I2C_COMMANDS),
 };
 
+static const uint8_t aldebaran_throttler_map[] = {
+	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
+	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
+	[THROTTLER_TDC_GFX_BIT]		= (SMU_THROTTLER_TDC_GFX_BIT),
+	[THROTTLER_TDC_SOC_BIT]		= (SMU_THROTTLER_TDC_SOC_BIT),
+	[THROTTLER_TDC_HBM_BIT]		= (SMU_THROTTLER_TDC_MEM_BIT),
+	[THROTTLER_TEMP_GPU_BIT]	= (SMU_THROTTLER_TEMP_GPU_BIT),
+	[THROTTLER_TEMP_MEM_BIT]	= (SMU_THROTTLER_TEMP_MEM_BIT),
+	[THROTTLER_TEMP_VR_GFX_BIT]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
+	[THROTTLER_TEMP_VR_SOC_BIT]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),
+	[THROTTLER_TEMP_VR_MEM_BIT]	= (SMU_THROTTLER_TEMP_VR_MEM0_BIT),
+	[THROTTLER_APCC_BIT]		= (SMU_THROTTLER_APCC_BIT),
+};
+
 static int aldebaran_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -213,7 +227,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_2);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -1713,8 +1727,8 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 					 void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_2 *gpu_metrics =
-		(struct gpu_metrics_v1_2 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int i, ret = 0;
 
@@ -1724,7 +1738,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 2);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -1755,6 +1769,9 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
+							   aldebaran_throttler_map);
 
 	gpu_metrics->current_fan_speed = 0;
 
@@ -1776,7 +1793,7 @@ static ssize_t aldebaran_get_gpu_metrics(struct smu_context *smu,
 
 	*table = (void *)gpu_metrics;
 
-	return sizeof(struct gpu_metrics_v1_2);
+	return sizeof(struct gpu_metrics_v1_3);
 }
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
