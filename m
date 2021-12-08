Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4916CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DAB96E0B8;
	Wed,  8 Dec 2021 02:37:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED726E073
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQXrx7v46U23BVGldQbr+qtx+O9gCHOlyttwvz6gsafC7lF1muCstGS2g4VSZlJErlnLqUREDLE4xPgB0sj1zYmx4BaQ6L+0S3PnX3j55YCOohnLsjd7kRsxxALkgLK3cfN4jMXbYlYcxZbmwM7BSp2HkOekyN70jskYRzudw90TYglBSzcPLNv8ohPCrXoF9tfUQIZ4ScRdzmOY7aHo1ejkaxC2SUebNVSAt7UEm+U/j9Ccn89E+SShcvZk0gyvJyLf/q1IL0AO1oj2twCNCKZjBhBGwFaGZUtOTeh3aZb3F/z5Yz59MJ4yvA1BMLkVRXALyeQORBgCBFVShUDZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBmX+wIfsvkkpUfudJx2d45n4rmtLyXcwYS6ezTk8pc=;
 b=AZ+AaAC6Opx6DyiJaRN2tAonEgm1XuyJ35BrNx+2Bv9UpFEUZbHm+ZOB+/leGhscEZ/De8g8wgTYTMvoz/2I+XmVfKzH+OQ9oxKmQWFvw+jmclHCIG/+g5VEtCB1k5h7iJCe+Y6MtHbNmgv+ha8UbQSib/Nrd5VrFCCtQAoPv16TRPBgzVCMMygVHnCGOII1xdkHJQUzMtd3BRCSqFSd3SCNbAFLspfUVQJBYEHs6+Vb1wQG67GkzB/GjPFnAeWBa1PdPCgv3pC3NBbiiK437G+Grb9l9dEpy//uPorZg5MXovRn8hCCqkzstkIW3aaIQGIWVOJwOY3VPuJ1q80duQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBmX+wIfsvkkpUfudJx2d45n4rmtLyXcwYS6ezTk8pc=;
 b=I7aWoMSJxuQbIM3L2ys0wEW3ZN7ZjGrX0z3Tb3e96p++60mS/4IQj6sd/9Hl4+wZs4McdZKXITndL9ypIXItX5V0TEpSmfXQjPZAv20+4aM5Bd5IPXUDaRQYeFxA9ZSQ4dRy6zyYNKqmj0r4gs2FNPfCsDCAA4NvNkFzyLgCnBY=
Received: from MW4PR03CA0071.namprd03.prod.outlook.com (2603:10b6:303:b6::16)
 by DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Wed, 8 Dec 2021 02:37:39 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::dc) by MW4PR03CA0071.outlook.office365.com
 (2603:10b6:303:b6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 02:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:37:38 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:37:35 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/7] drm/amd/pm: drop unneeded smu->metrics_lock
Date: Wed, 8 Dec 2021 10:37:03 +0800
Message-ID: <20211208023707.1814122-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211208023707.1814122-1-evan.quan@amd.com>
References: <20211208023707.1814122-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c02485f-2673-4b0b-1ea1-08d9b9f3b383
X-MS-TrafficTypeDiagnostic: DM5PR12MB1226:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1226F59D813649F427A5E0B2E46F9@DM5PR12MB1226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iiPaGoUDCGMGf4Ifx6DZY2eN+QkSx5g1UIaBdu9DXB8+6zN1A2KrydR+dljCD7h7zP0xI7aqVYoj6eOsQ8aS96/yNrLhW+ByMmD5vbNzZ2tBqY0d+DwT7M8bwgYhe3oJzOsU2g/6vTGwfTgV6QJ6RJsg2dwDa7k2pxhIDUWIKknNP0A3Pv/y3PzDLbwRslJOqoj+iGv2dGzn3ZnujT1II2geogXV4+2cFhBV89bynC1DIGoXeBH6dx5+r33X/ZqJNKZ4p0s+/LdU5vycNtII6pnUrD3pjJARRuhKqw5d6U7/rYRDmrWU3vXW2os74SMS1osx2cuexeRZGHdx8vDJ9wpRTEK8PwBFoNMbqqr6vRybwyI9wq9SdrTBE21OGH3swpXJQjeMVnwRGteE2xI2BWG8HYIzU4xPW3sLuBANPxl88JdSgOxn4SHog1EuNtcJGwsQssiPyTI8necWx7ROSV7sVSGpIQnIxrN5YVbsCuXmGs//Z4vHmXMqtbagKL+/C85IW1Xehvar9bqfSIf4CxgNmEymQv0FQquYfchtGBGHo/o6Ol1CwQ490pI14YSauxQ4/RbppGTyWzZHwQzEhhpY2QjPmdJ9Fotrhge4x70ORYMQdEmIxu2G209HTCPUGqV4mCSf/liI+13bUZPgkRMZHEajf0OaVEtPbNkEyteGSYncXIZt66awWIIcb7WthmtPKgkrP7HogDN8wJW/Rp+zURqZWVerK5uDho4VkI4u8N3fwf28y6P14Hr40uiMiutLxUQIyQPievqMf7vsSK0AKDXcpK/7LS3YIHBc8y4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(4326008)(336012)(47076005)(70586007)(19627235002)(5660300002)(6916009)(8676002)(40460700001)(6666004)(1076003)(2906002)(2616005)(426003)(82310400004)(8936002)(36860700001)(44832011)(70206006)(30864003)(16526019)(508600001)(81166007)(83380400001)(86362001)(26005)(7696005)(54906003)(186003)(316002)(36756003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:37:38.7760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c02485f-2673-4b0b-1ea1-08d9b9f3b383
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1226
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
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
index a4fb6cf1413e..1bcf91129e4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -956,7 +956,6 @@ static int smu_sw_init(void *handle)
 	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
 
 	mutex_init(&smu->sensor_lock);
-	mutex_init(&smu->metrics_lock);
 	mutex_init(&smu->message_lock);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8e7305d45b31..2083ce7a298f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -486,7 +486,6 @@ struct smu_context
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
 	struct mutex			sensor_lock;
-	struct mutex			metrics_lock;
 	struct mutex			message_lock;
 	uint64_t pool_size;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 8eb8bb934d4a..e3ead20ddb44 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -612,15 +612,11 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
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
@@ -703,8 +699,6 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
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
index a938977fdae8..77f91c3d2ba3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -580,15 +580,11 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
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
@@ -662,8 +658,6 @@ static int aldebaran_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->metrics_lock);
-
 	return ret;
 }
 
@@ -1601,17 +1595,14 @@ static void aldebaran_get_unique_id(struct smu_context *smu)
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
 	sprintf(adev->serial, "%016llx", adev->unique_id);
 }
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
index 048ca1673863..289aa77ba7bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -942,9 +942,9 @@ int smu_cmn_write_pptable(struct smu_context *smu)
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
@@ -972,21 +972,6 @@ int smu_cmn_get_metrics_table_locked(struct smu_context *smu,
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

