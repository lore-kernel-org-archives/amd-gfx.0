Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB0AC47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20EC613D1
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20EC613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C786E8CC;
	Fri, 28 May 2021 20:01:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C106E550
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:01:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzMefT9E+1NWikL/E5mgdQIQ0501hmdfLtWcNyeVfv4/CLl6Pwb/09vfTTz/Rbw0D4LsRbcKzPn4FmKkwdGQNGLMN1mz5UwtmHHa9FCS9wvjMG9ea8I9phxKHtjflNk7y4qJ5rvnakojfPyRpDqDGiBTURWCH2LnkQqHwOkuZFraY1citl+Rb3OtRuzIL+kJv8pZPKtzSHXBqYQraSz4RI4peaq6V+LWknzysOG/zwqfbfpXzGoByXdmVF+i+L6O0xEq6oLyKesF3NQ3a744eRwW6FpmoriEePd5g0NDzKNkuoz9a3hfz0iwQ8QZw/20tWj6XJO7Xlt0Q0ooOQ2BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt/UXXm41uYKUO4PQkQ0lbQKqjLZaqdaN/FExXWZWgw=;
 b=mAlEI0h2nQpvqSX90BQe0pyvFvbgKSmruRG1bdFHl1U/FOKrxyngLj3VS5afs1L4gInv4tKQfnmJmqMhRWuXLdVeNaKJU0wMbrFCnhMYs6SH3VsBL8IX2u5AWE5e0ERo3T7WPjTNH2LPabyINpRUMBRUy3HI0JBFTkiIg7NdJe/T1z+2/LltQu3ml/HMA6hBwWtSjWEYavNZEvEWkLHydmYHmfatBO1rbHWv5nvD8J6v+rJHrK2ZNGuK192Uwoxc10DEIZqeclq5hsiXOdXKhdAjn9i8s2+z1kvspkfHCTcfl7veLn6wo5G6QTSx29NJYl9HKWY8FkOyzZ46t2oiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt/UXXm41uYKUO4PQkQ0lbQKqjLZaqdaN/FExXWZWgw=;
 b=K+VQYrV+dhg5zLSsgTUyRB5DUl77toyK/KmbBhcW437mFQQPL1/2890yt+Yw9Mz8G3kbn5SDF3UGkLk1eMJvN2DS5MnFlx3pUjhzChtz5GkB3OpSl3ClI22lZxA1Yh2+JJkK3UIs41qq8qzAv0rlZ8dGRz6wzDlepeV9/+6PdmU=
Received: from MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15)
 by BN9PR12MB5383.namprd12.prod.outlook.com (2603:10b6:408:104::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 20:01:17 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::e3) by MWHPR03CA0005.outlook.office365.com
 (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 20:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:01:16 +0000
Received: from grasider-dev.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:01:15 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/8] drm/amd/pm: Add arcturus throttler translation
Date: Fri, 28 May 2021 15:58:10 -0400
Message-ID: <20210528195815.2615-3-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210528195815.2615-1-Graham.Sider@amd.com>
References: <20210528195815.2615-1-Graham.Sider@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7871bf20-26c2-47c5-55d2-08d922135a95
X-MS-TrafficTypeDiagnostic: BN9PR12MB5383:
X-Microsoft-Antispam-PRVS: <BN9PR12MB538303E0D650195F84BEA8368A229@BN9PR12MB5383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xTcMvQh7wKoD6QvaBm+ExmLr+P+sP1o/eX0OQyH5B0+YOPTeloXZTTCdus3isMDV2pB0jVa2LzCiNNg8uYQNYMn7cqoX/N6ZBwvhRL6YmovJLc9doJLXWSaRBCWrJda8KqzM2GNGp7KRHZ3TxJCx1ZdVYuKM7vGi+P4F2v8M1t+zcC6ovyijzgV1E9t7BYTdUuX2VbqAPENMEhkccpjUkJ3sctn8/gORRirg8pRwC6YD8K4fl6+xhbA4zOuddVw/hMqHnQdOTLfB7rz4ulUVWjR2VfkjQySuARO629S7mJngW19XRxWkV2YbYbY8iSBZ6bEMupSgIJUno2POL+fkxmvyFme6vSpZ5AUVUelbCxS+ECXUP5WSBvsy4xSLqx17G5Lt9CpfH53ewD+RKBB1BSwSrjfLrwf8C8w8u3MwVyxdo6IVboGQfI2ejPCnB7rbpJPQMgov/ifRPWPUIxQ6k8DBM+xx775wOXj2b4MXr6ZwRYsyeFXrC9xLyAxGcRAe7bYC3mwRmsQe+vzMx7rliqDDRxrN0sE13cWnoPCE0INsLiYG4AHg09bbNk4XxnMfnGYc3AuBGB5rMAy0lUZMcdlFDOY7QejXIrxF9veK24SFtrGLZoVHPHgo9JzVamPyFbCRqE6zJ/byBStQYOsK+9ZGe7QP4/AzaAPJlhrclHs+tABiW+ypPc8Sg8thTsg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966006)(36840700001)(356005)(81166007)(83380400001)(6666004)(82740400003)(186003)(8676002)(47076005)(316002)(8936002)(16526019)(336012)(6916009)(54906003)(86362001)(26005)(5660300002)(36860700001)(426003)(2906002)(2616005)(70586007)(70206006)(82310400003)(36756003)(1076003)(478600001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:01:16.7446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7871bf20-26c2-47c5-55d2-08d922135a95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5383
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
for arcturus.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 58 +++++++++++++++++--
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 1735a96dd307..ecc046c929fe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -237,7 +237,7 @@ static int arcturus_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
@@ -540,6 +540,52 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
 	return (abs(frequency1 - frequency2) <= EPSILON);
 }
 
+static uint64_t arcturus_get_indep_throttler_status(
+					uint32_t dep_status)
+{
+	if (dep_status == 0)
+		return 0;
+
+	uint64_t indep_status = 0;
+
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_EDGE_BIT, THROTTLER_TEMP_EDGE_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_HOTSPOT_BIT, THROTTLER_TEMP_HOTSPOT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_MEM_BIT, THROTTLER_TEMP_MEM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_GFX_BIT, THROTTLER_TEMP_VR_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_MEM_BIT, THROTTLER_TEMP_VR_MEM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TEMP_VR_SOC_BIT, THROTTLER_TEMP_VR_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_GFX_BIT, THROTTLER_TDC_GFX_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_TDC_SOC_BIT, THROTTLER_TDC_SOC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT0_BIT, THROTTLER_PPT0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT1_BIT, THROTTLER_PPT1_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT2_BIT, THROTTLER_PPT2_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPT3_BIT, THROTTLER_PPT3_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_PPM_BIT, THROTTLER_PPM_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_FIT_BIT, THROTTLER_FIT_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_APCC_BIT, THROTTLER_APCC_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_VRHOT0_BIT, THROTTLER_VRHOT0_BIT);
+	indep_status |= smu_u64_throttler_bit(dep_status,
+			SMU_THROTTLER_VRHOT1_BIT, THROTTLER_VRHOT1_BIT);
+
+	return indep_status;
+}
+
 static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 					 MetricsMember_t member,
 					 uint32_t *value)
@@ -2275,8 +2321,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 					void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	struct gpu_metrics_v1_1 *gpu_metrics =
-		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
 	SmuMetrics_t metrics;
 	int ret = 0;
 
@@ -2286,7 +2332,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
 	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
@@ -2315,6 +2361,8 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
 
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+	gpu_metrics->indep_throttle_status =
+			arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
 
 	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
 
@@ -2327,7 +2375,7 @@ static ssize_t arcturus_get_gpu_metrics(struct smu_context *smu,
 
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
