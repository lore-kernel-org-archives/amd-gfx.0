Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663E1C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 05:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E116C10EBF6;
	Mon, 17 Jan 2022 05:42:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CF210EBF6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 05:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/9wpc//ricryywm38YCAYh64DHEzZ48SbyDtrs8u3nDVsGLHkH/YbgBcNO/PnUt36fiuKLcwJEM6BPmXbgQIKvrH73SWVHdWLsXWC9hzW8X84papkuX7iNorhJCIuC64Tz5aU0mZO6mPF2xsXgIZqKOX/Q65aLkyLS9FtB2LxNrzK+/QsQgnf47UCOdOOWkSju9pcg/OXzaGo9i+2DyeH7cfHX8feBmY6/XbuCguUgGxSt9WC6R53TFvNMreUTwvNlBPIyLC4JwrtBYpuzz53D5aS0b3ZxXVr0onSSDTnP3rg4FCko3HqRt4+6Srvnkjo+CxI4p0uRiLoz20OMbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHEEMQxLlAxwBSHg24NORyKUjHk3JAXYo3ZQLlAEmqQ=;
 b=ArrLrOVYPn3XQL9epwAReoI0wfmboQ3L8ho0UND4dVRdA3e8bfkqHE6Yk6UFDfB2EKI3F26PPIXolTSltHYvsbVD2q4xjrWL3Y8FlpWDyxHiCsScw3v30NbUJ2uN+Vlxy+EMYwmXYjObpS8FCW4p9eVnT8hitBB/3Lu7Cdp6g2xMwI32RgUb8MvkUTmQIVqIHEufHdwanHrNUoCzuK+W1Xj6VAbH6FGiOZPnlKOPlavDTsw7RbFiT3S8zcX0JbeVrgBT7IUtZZbiiIhqepup8UFuCIMa80IJFrTOdRg3Twk19a5KNhx6wGH/AupSBtNRndNYuqPI06bNP+BQ7N6eQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHEEMQxLlAxwBSHg24NORyKUjHk3JAXYo3ZQLlAEmqQ=;
 b=JRFfoOBqCCurd1HWXGbPnFHV1O/+OqDV5JyKhOsk5UsT3SYlWSP7JmTv1SJcQES+DsaLMScAe5ruYgsUfBHxJz9PfHhNIElgUY04xOOIXYRCg3/7eE51YvWMFAiQTxZKo0jOEF0/yNirkJn9f9SivMqZTcAh1eC3fU47W2CgYZI=
Received: from BN9P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::7)
 by DM6PR12MB3786.namprd12.prod.outlook.com (2603:10b6:5:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 05:42:32 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::aa) by BN9P223CA0002.outlook.office365.com
 (2603:10b6:408:10b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Mon, 17 Jan 2022 05:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Mon, 17 Jan 2022 05:42:31 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 16 Jan
 2022 23:42:27 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
Date: Mon, 17 Jan 2022 13:41:47 +0800
Message-ID: <20220117054151.124838-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220117054151.124838-1-evan.quan@amd.com>
References: <20220117054151.124838-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 803591cb-1d6b-4424-eb44-08d9d97c2805
X-MS-TrafficTypeDiagnostic: DM6PR12MB3786:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB37866494B7841C1238F30ABDE4579@DM6PR12MB3786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9IVehGQFT16FUmk29ZcqcnM1iuJnorKhHyapMTQruve2UMuV4YSrTA1lwrikr+ikDgV1KbYBPyalYw0PyMZvFYO9UFO2vsrRhCzTD3MNj8xneW666fYa9C4cQh2LOUThgnfu4WMs0kjGDXc0ko4NSBghgq9qFHrCiLHyluG9ebGM9E+8jMjgVhBcFdhBhFUIdZpOx60YkjFV0ZN9qbypWeJuYS4Y55Q+lPxZ00uszibYCgjFNj1mowcZadYX7wWy9VZ/YC11XEkNW2U9sJqCn7Q4BVhEukxrJmWwUz29D83KuGMYNDw3pFhc6R2xsSdv066GZecI2tEH37y6mhotto4WqMZdxrKCRopqIhxy4T7Mk5UftjKTUYVd9XpISUvIACOexPTys1lA8X9xbjqyvkHiWDqu3+DqNZvMakZTzpwpmVSZRhL/r8VaLwYPQinijTSGLPByFJmu0RFF71TPbTL/Zu0hpABap/TCgaDqNKQkvMmeZdlEGBHfAbjYPfw1SmH9ZjTj3jxBf5l++f57CfGw7yCLKR7AiK23vVksSaKsUzf7Rl52uTIh1jPrcRnGTH5anCFxWH4WJZhy8HHp6BHrjLSq4fIm6nDW1EJKn2lyCuyigtkH2j7ARdZ9clA4iAmxyNZv5B4YVlsm4YLytvTj0tD0g5Y5yzsDFvMdYZWrF7N9QQnX7GnCsyXCpvPWpuOmdzyM5aqW7eEe39yvSIOlvObz2brpCaK6nfs5nOjBJc8Kn0LegiwjWrU2lc6Xqj6OgESwWghuq+jKhmQ2K2BjS9Dj5fR+VUBUgAE+k0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(82310400004)(4326008)(36860700001)(8936002)(6666004)(5660300002)(30864003)(19627235002)(36756003)(6916009)(81166007)(7696005)(26005)(2906002)(70586007)(186003)(316002)(1076003)(336012)(356005)(40460700001)(44832011)(47076005)(2616005)(86362001)(426003)(54906003)(508600001)(8676002)(83380400001)(16526019)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 05:42:31.9659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 803591cb-1d6b-4424-eb44-08d9d97c2805
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3786
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
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Evan Quan <evan.quan@amd.com>, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As all those related APIs are already well protected by
adev->pm.mutex and smu->message_lock.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ic75326ba7b4b67be8762d5407d02f6c514e1ad35
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |   1 -
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  14 +--
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  10 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 112 +++++-------------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  28 ++---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  14 +--
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  23 ++--
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  10 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  21 +---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   4 -
 12 files changed, 70 insertions(+), 195 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1a560d2702db..3123efe339ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -955,7 +955,6 @@ static int smu_sw_init(void *handle)
 	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
 
 	mutex_init(&smu->sensor_lock);
-	mutex_init(&smu->metrics_lock);
 	mutex_init(&smu->message_lock);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index c3efe4fea5e0..63ed807c96f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -487,7 +487,6 @@ struct smu_context
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
 	struct mutex			sensor_lock;
-	struct mutex			metrics_lock;
 	struct mutex			message_lock;
 	uint64_t pool_size;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index addb0472d040..3f7c1f23475b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -602,15 +602,11 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -693,8 +689,6 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 2238ee19c222..7ae6b1bd648a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -150,13 +150,9 @@ cyan_skillfish_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -200,8 +196,6 @@ cyan_skillfish_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index fe17b3c1ece7..fdb059e7c6ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -546,15 +546,11 @@ static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
 		(SmuMetrics_legacy_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -624,8 +620,6 @@ static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
@@ -638,15 +632,11 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 		(SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -719,8 +709,6 @@ static int navi10_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
@@ -733,15 +721,11 @@ static int navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
 		(SmuMetrics_NV12_legacy_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -811,8 +795,6 @@ static int navi12_get_legacy_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
@@ -825,15 +807,11 @@ static int navi12_get_smu_metrics_data(struct smu_context *smu,
 		(SmuMetrics_NV12_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -906,8 +884,6 @@ static int navi12_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
@@ -2708,20 +2684,14 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_legacy_t metrics;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       true);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					true);
+	if (ret)
 		return ret;
-	}
 
 	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_legacy_t));
 
-	mutex_unlock(&smu->metrics_lock);
-
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
@@ -2899,20 +2869,14 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       true);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					true);
+	if (ret)
 		return ret;
-	}
 
 	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_t));
 
-	mutex_unlock(&smu->metrics_lock);
-
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
@@ -2977,20 +2941,14 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_NV12_legacy_t metrics;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       true);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					true);
+	if (ret)
 		return ret;
-	}
 
 	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_legacy_t));
 
-	mutex_unlock(&smu->metrics_lock);
-
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
@@ -3058,20 +3016,14 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_NV12_t metrics;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       true);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					true);
+	if (ret)
 		return ret;
-	}
 
 	memcpy(&metrics, smu_table->metrics_table, sizeof(SmuMetrics_NV12_t));
 
-	mutex_unlock(&smu->metrics_lock);
-
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
 	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 93caaf45a2db..2241250c2d2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -525,15 +525,11 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 	uint16_t average_gfx_activity;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -633,8 +629,6 @@ static int sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 
 }
@@ -3564,14 +3558,11 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 	uint16_t average_gfx_activity;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       &metrics_external,
-					       true);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					&metrics_external,
+					true);
+	if (ret)
 		return ret;
-	}
 
 	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
 
@@ -3661,8 +3652,6 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
 				smu_v11_0_get_current_pcie_link_speed(smu);
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 5cb07ed227fb..c736adca6fbb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -273,15 +273,11 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_legacy_t *metrics = (SmuMetrics_legacy_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -335,8 +331,6 @@ static int vangogh_get_legacy_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
@@ -348,15 +342,11 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -410,8 +400,6 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 25c4b135f830..d75508085578 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1128,15 +1128,11 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_AVERAGE_GFXCLK:
@@ -1201,8 +1197,6 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 2546f79c8511..1661a958421f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -571,15 +571,11 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       NULL,
-					       false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu,
+					NULL,
+					false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_CURR_GFXCLK:
@@ -653,8 +649,6 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
@@ -1592,17 +1586,14 @@ static void aldebaran_get_unique_id(struct smu_context *smu)
 	uint32_t upper32 = 0, lower32 = 0;
 	int ret;
 
-	mutex_lock(&smu->metrics_lock);
-	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
+	ret = smu_cmn_get_metrics_table(smu, NULL, false);
 	if (ret)
-		goto out_unlock;
+		goto out;
 
 	upper32 = metrics->PublicSerialNumUpper32;
 	lower32 = metrics->PublicSerialNumLower32;
 
-out_unlock:
-	mutex_unlock(&smu->metrics_lock);
-
+out:
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
 	if (adev->serial[0] == '\0')
 		sprintf(adev->serial, "%016llx", adev->unique_id);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index caf1775d48ef..451d30dcc639 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -310,13 +310,9 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	mutex_lock(&smu->metrics_lock);
-
-	ret = smu_cmn_get_metrics_table_locked(smu, NULL, false);
-	if (ret) {
-		mutex_unlock(&smu->metrics_lock);
+	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	if (ret)
 		return ret;
-	}
 
 	switch (member) {
 	case METRICS_AVERAGE_GFXCLK:
@@ -387,8 +383,6 @@ static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 735e1a1e365d..d78e4f689a2a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -964,9 +964,9 @@ int smu_cmn_write_pptable(struct smu_context *smu)
 				    true);
 }
 
-int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
-				     void *metrics_table,
-				     bool bypass_cache)
+int smu_cmn_get_metrics_table(struct smu_context *smu,
+			      void *metrics_table,
+			      bool bypass_cache)
 {
 	struct smu_table_context *smu_table= &smu->smu_table;
 	uint32_t table_size =
@@ -994,21 +994,6 @@ int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
 	return 0;
 }
 
-int smu_cmn_get_metrics_table(struct smu_context *smu,
-			      void *metrics_table,
-			      bool bypass_cache)
-{
-	int ret = 0;
-
-	mutex_lock(&smu->metrics_lock);
-	ret = smu_cmn_get_metrics_table_locked(smu,
-					       metrics_table,
-					       bypass_cache);
-	mutex_unlock(&smu->metrics_lock);
-
-	return ret;
-}
-
 void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
 {
 	struct metrics_table_header *header = (struct metrics_table_header *)table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 67a25da79256..f0b4fb2a0960 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -101,10 +101,6 @@ int smu_cmn_write_watermarks_table(struct smu_context *smu);
 
 int smu_cmn_write_pptable(struct smu_context *smu);
 
-int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
-				     void *metrics_table,
-				     bool bypass_cache);
-
 int smu_cmn_get_metrics_table(struct smu_context *smu,
 			      void *metrics_table,
 			      bool bypass_cache);
-- 
2.29.0

