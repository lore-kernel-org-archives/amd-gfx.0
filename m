Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E449CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 05:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46ED91122C3;
	Thu,  6 Jan 2022 05:58:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8B41122BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 05:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjuzCDKSRgADsBrh8pECX4h/9FdjgroaFITb+Zf06GYoF+9b7FI5ZeMXNNGCqM6Iuvd8HbfEewHrkW2U6N+eKmcrSLbkPm0B4zX9as21ReF/H1Mr6adbo6ksXxRRLgUrNALow9SklHreSQLcdtytO4YViIe12nT9nofcZVUKcsVJFQAwoLcTDDHYq1mX8HLUNzOuXjMnmVOQDcXa1fpt2QX3h0fmfcvFC5Ms+ZzpcpYzKgdAtCbmd/CWx+afuqtsJrtuqYxCrcSfI882StlNLSS4yAAJfQS5ieuaSDo7gaClRLNcbmP/eDaRbj5bCb+kXhZvZo02v86uGM2BB+D0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygEvJJPYtmNA9Us+55jEsW3kEVXnHCc92PxDyv2BSUU=;
 b=kCBt2ft+JmDiHOUMIgLSR6GUkwWw7fq5Ok1w9C/hr7pgFa/6hb+IMY51b/ZW9ixAXtZ/q6r7MshpUKcuDjnidaaZlk1QvwM0vMVjj+ihZ3/DzvIF5HKVT0IVSrqD4D+gZbNnkScVGniY6om6WE/TG7yLRl2jfIfjmOaeJI49ARvUVLHz1TBHLF02PE/L6ip3o4FsDtN1mJXDK8J6COHQ43IL0DDQTfUGhyadr93CqYUGdTZuOjmrNrMyN1yTCcuBa7hqO/esi5RkotNgqy42pEtSXOiqPd1tXupCrSKSlfNx05eoulj6cr5oObuPa6QodUxwewc/gUDJPq8VrS6pYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygEvJJPYtmNA9Us+55jEsW3kEVXnHCc92PxDyv2BSUU=;
 b=ay8HMiqNeZFgKQGmklJiVGaGK05A8Ov4fZv++T/hTgAmtR5NQmIKooOC1p6Ea54Uqjt1QUn9oNAkn4xs4Ycem1GqypJFUZFbPICpaVLnQ7tBguZatZjJw+bx0uJ+WOJupdrrS2SOPgKwgvU84OBkt/qqBY9IvZEdQpklzIGSsyY=
Received: from BN6PR2001CA0043.namprd20.prod.outlook.com
 (2603:10b6:405:16::29) by DM6PR12MB4810.namprd12.prod.outlook.com
 (2603:10b6:5:1f7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 05:57:56 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::7f) by BN6PR2001CA0043.outlook.office365.com
 (2603:10b6:405:16::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Thu, 6 Jan 2022 05:57:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.9 via Frontend Transport; Thu, 6 Jan 2022 05:57:56 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 23:57:54 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
Date: Thu, 6 Jan 2022 13:57:28 +0800
Message-ID: <20220106055732.3073780-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220106055732.3073780-1-evan.quan@amd.com>
References: <20220106055732.3073780-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a04bc953-897d-4503-496c-08d9d0d97c55
X-MS-TrafficTypeDiagnostic: DM6PR12MB4810:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB481094E14B9F0DAFAF71F249E44C9@DM6PR12MB4810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kjQNxFDg8E8MNOIwjIv2XUI5Cby6YxnOsg/zE90BIVZtfS1LmCtc85ZeUTdd1PeLZj77CwRCGm+1cOO0pj7B7RVJyUyUMqp5Jn7ahIB825dYlItHVaKIUbz6u/3wWdkN7Bhob3CY3RcEvE6eYuXimFiqxotqsVCefRUzSa3TY/xi/HUXK7jcB0RufQ8vHPiCiNXfVoLmHhzr/dW/YeEgY4n4dlbEX7D2hJORZkU/XtmTzfZt7gBQGs5PzyIDGveuZWOr65h7atEuLJJL/9Aw30OvgFdOhgduFyYNFJ1hWmMKjQYl11EvIEphFJYiQinQ9IT3TZVIjBHz+wJJFsX3WDSoMLTplRnfWKH7RJK1UEEcMLuOmkO7vO4sFjQZOdsyaMcZNEoDScZeVewi4VIXJqFNMspTJLCCOkhs4HWjRBWbtxIGs5zDuilGtiZtCqwXdCnvuwzE+t86FM/hd1d/1oLkWUlNMLuLmhDXwE+mc8x1FJHCMHZgM8VTK7Why6B1iECD5e3+SVfp3qZK3mmKBJKmP2YsrGp+nA6sNnRZjKNY8Q5mXW8h73beH3a/zg7+dZWYJLIKnRSTwMQmcR9nS55NNF1CXkdsqpZx2UTsR7YptzLCIt4aBFv78WKjq3b1znLIVW6Rz9TsN6UrFUHYADm2GvioHX136VBkLEIWi7k2YM44nQYZul6Hq1u4/dIRfJ4uel8Lj7FD9TFTV2jD5uuPTXenbedGUIuMnrma50LlEjJyvFhjkshzP1uGUPep86C0kvFpoXkS3550KWfrEyxtw/96qH9PcavvBIRR3Kw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(86362001)(19627235002)(508600001)(7696005)(1076003)(2906002)(186003)(81166007)(83380400001)(6916009)(426003)(2616005)(356005)(4326008)(16526019)(44832011)(8676002)(6666004)(82310400004)(5660300002)(70586007)(336012)(70206006)(54906003)(26005)(8936002)(36860700001)(47076005)(30864003)(40460700001)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 05:57:56.1611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a04bc953-897d-4503-496c-08d9d0d97c55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
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
index ecbc768dfe2f..f0136bf36533 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -956,7 +956,6 @@ static int smu_sw_init(void *handle)
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
index f065d95b117a..014fb88daa04 100644
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

