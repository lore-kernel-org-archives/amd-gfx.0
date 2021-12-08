Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1C7C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3C56E08C;
	Wed,  8 Dec 2021 02:37:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C552D6E073
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:37:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab1DJuomxWXFzug5nJFhqAJ4eBwULX2H41XyzYcZ6eRUE12LF0nOI9gpWJZ3y7GMlHKXYfXsVr2vyI4r4PGnLlclVRh2IPhk8sug2+cZpVsjYB6gCtB6J2mVR5eSvfMmletXjyLuyokWyAfpHjhLtGPzgKhTpA8a//0s4/ieu4O/sMg9XMWlXUJ2gd4TPM+7VZv9/Q664Z/rZZdjy+0f9+chF+CftvqwSJWA0QJnoEylgcY+OuDXIlUkF19fRUnNtxFbjYaYaZ6caEz+KMlEBPSKeTajGmVLKjH7PHJ9qEP4yAyM+ViMWZIEkMu8k5M+H13rJeLFUZ5+Rl72lF34Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUMqke6HkuNvDjgtTvgxv+8AUUu83+DVlNnvOiM/8gM=;
 b=PNFC/HxOsousPcs51d8xNXzuAvepGupdyD1aPcRWh1q6ng7fqmoTbbmVB8tpeekf83hItaFrma2tewnGn1zrAtWt7iz60fh6sdYEora7ucbVWFXgBCzHi+FRQWNmdKWOe7sYAeQy/AESU7Ehl2UsgKjuvfDFqtShFDcb6ZL7N19Ttmy12/y94EqfWvfiaZNm/dFYnsLd+kuCkwt2WmUM1qXW08pRSqfFsKHAMpe+ENlzlAsoYm7jiVHXTUEPgMEYuVn91o0Z7wJPDlTMuGQ/jdOrbSIbCBq4sRPc1p8Eyl3X0z/nnNjQHKCoWXfWemlp4BLLLrq0Lt1e+Q0Ho0WaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUMqke6HkuNvDjgtTvgxv+8AUUu83+DVlNnvOiM/8gM=;
 b=0dR8y8DxNxktQH+fJL4EVGq1nYfGngU+dZP7DMWdkvSKtXu1SfWYgxJZDINWgS/uAH96tDRHFk6qyQN+cBt4MMhRnm9LuNgK4N+DyMycjgMYFaDG5iNhW1591M6j50Pn0pwlTEO7MgsrhJ8E+AjjfY2MRFITFUBsGwQmvGWlnj4=
Received: from MW4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:303:b6::21)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 02:37:40 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::59) by MW4PR03CA0076.outlook.office365.com
 (2603:10b6:303:b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Wed, 8 Dec 2021 02:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:37:40 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:37:38 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amd/pm: drop unneeded smu->sensor_lock
Date: Wed, 8 Dec 2021 10:37:04 +0800
Message-ID: <20211208023707.1814122-5-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ebddd9a-91d8-4880-6f66-08d9b9f3b483
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29986A79C49E1989D75BBE60E46F9@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvAq3gp0yy5rmmaolnik2wWB0EkXDusPyMHzeNnniFziTpnzXPbtk8GstxyvwKhq/JHac8HcrRwtjJ/LVsDEppXEVot/jcTatBFwxFE23BvszmZIesDvdVF6zDMd8ZzwLFjEVv7fawWRV+QXrD3QZUQPkOELaRTa4BAFh8vkl+wL+61xasHTf8Pf75FlHiXnlUm+dUVVkSYLtBkYI1FVOJNGvX0fUfNdoSxXKpyiVGmFDg/vf6bXPr6VcoMKbNVcPNPXrsA8rjpPtF+muikSzQ0a2oBAItHPfTIgD9q1I7xd9RNdRkODk72aVC9O3SRbxYTfo4nchnJ5zKC1DW0WS83+pJVI4d2mHNT+e/ovcDq36xnqfvneOTKVlq0hYVW1OzvweMcvt0wZ0Fn1a6GDssZxFKhR1QthlNEnFdUR2xtcIsle0z2K3hlF9yxdohtOo4LtthrnyRgOu312V0g3t7BHsInmxh/RHA1/YxJmFEr/1zrZnvhyhaglFQEKR8y5WTh5qYxjzt918Y4sSUNXF3dlconrYYtbOMXcMAIcNzWAlTX/V9soYSOFPM9MaVWL7E7w2a4Gq2XJ5A+UW36IDZewP0rVEccRW1Py2SfJ5UCO+6l0+D+gUDTgIWc0dSdxG3YYE99J59meY8QKQ380ZvkyCnzVMcwCKcpJxF+c6UMMJzOGQEWBnFv3CRAxw8PL6mWqgCysGWs9gXLpvI2fs7P9K9471YLZMVZfRKCIQgIEfbMt4VQBgRUzrHCDRDnXMarx94N+NaCaOBPZRF+6vkiGojPrJtzwtbCN4mreq6Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(70206006)(70586007)(426003)(6666004)(1076003)(186003)(36756003)(16526019)(36860700001)(86362001)(356005)(81166007)(4326008)(2616005)(8676002)(26005)(7696005)(82310400004)(316002)(6916009)(47076005)(54906003)(8936002)(40460700001)(508600001)(336012)(44832011)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:37:40.4568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebddd9a-91d8-4880-6f66-08d9b9f3b483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
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
Change-Id: I20974b2ae68d63525bc7c7f406fede2971c5fecc
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 4 ----
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c         | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c      | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    | 2 --
 10 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1bcf91129e4d..f9886423eec3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -955,7 +955,6 @@ static int smu_sw_init(void *handle)
 	bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
 	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
 
-	mutex_init(&smu->sensor_lock);
 	mutex_init(&smu->message_lock);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 2083ce7a298f..f0d7953ffdc9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -485,7 +485,6 @@ struct smu_context
 	const struct cmn2asic_mapping	*table_map;
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
-	struct mutex			sensor_lock;
 	struct mutex			message_lock;
 	uint64_t pool_size;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index e3ead20ddb44..5ffc8733e3dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1123,7 +1123,6 @@ static int arcturus_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 		*(uint32_t *)data = pptable->FanMaximumRpm;
@@ -1184,7 +1183,6 @@ static int arcturus_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 7ae6b1bd648a..2acd7470431e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -209,8 +209,6 @@ static int cyan_skillfish_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
-
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
 		ret = cyan_skillfish_get_smu_metrics_data(smu,
@@ -261,8 +259,6 @@ static int cyan_skillfish_read_sensor(struct smu_context *smu,
 		break;
 	}
 
-	mutex_unlock(&smu->sensor_lock);
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index fdb059e7c6ba..21354cb4ddec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1964,7 +1964,6 @@ static int navi10_read_sensor(struct smu_context *smu,
 	if(!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 		*(uint32_t *)data = pptable->FanMaximumRpm;
@@ -2024,7 +2023,6 @@ static int navi10_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 2241250c2d2a..a938511362a8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1605,7 +1605,6 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 	if(!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 		GET_PPTABLE_MEMBER(FanMaximumRpm, &temp);
@@ -1666,7 +1665,6 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index c736adca6fbb..721027917f81 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1494,7 +1494,6 @@ static int vangogh_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
 		ret = vangogh_common_get_smu_metrics_data(smu,
@@ -1556,7 +1555,6 @@ static int vangogh_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index d75508085578..e99e7b2bf25b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1209,7 +1209,6 @@ static int renoir_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
 		ret = renoir_get_smu_metrics_data(smu,
@@ -1277,7 +1276,6 @@ static int renoir_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 77f91c3d2ba3..9fdaa3552a82 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1150,7 +1150,6 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MEM_LOAD:
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
@@ -1189,7 +1188,6 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 451d30dcc639..bd24a2632214 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -395,7 +395,6 @@ static int yellow_carp_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
 		ret = yellow_carp_get_smu_metrics_data(smu,
@@ -463,7 +462,6 @@ static int yellow_carp_read_sensor(struct smu_context *smu,
 		ret = -EOPNOTSUPP;
 		break;
 	}
-	mutex_unlock(&smu->sensor_lock);
 
 	return ret;
 }
-- 
2.29.0

