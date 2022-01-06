Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF631C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jan 2022 05:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360DD1122BD;
	Thu,  6 Jan 2022 05:58:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8211122BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jan 2022 05:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQMzGcVWuyFHcRhEhEAJwZkf4mPazSuSVFQuCRgy9sGIosguF2t3lOWhmMx1tJdx5x2vKepJ8jsph1d0Zz14fJtXkUEX/R7RzzbaH1+t0duASdc6EvTZ05ae1L+6mCW4x3VvBiZfch/AYfoY5U9X83HFWOt+fBDKr4MB0BuBMJg96wagbr31TY6zI3f3LXSQiANxA2EOj6zvKanUNCE8zM9SDwxcvPGKWXJdfjUhXAnE/KP/DrNmQWvRYsmJLlPdSbFG0vggeebYHIT88dfJoGKQV3wSQsrzooejaqb01ClUHQ9ChgwwRODf9q6v20rcQc/oR6N4+BtXKL1CdVmKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHKX3lijCZZqV85cGShzTOpAppQzTERihrIUjzSCFNk=;
 b=Dq1TeP9MjUF7i3qSi9yI50yd4FJDjTFAwr5lVagEIWMjAHMgEVoadMUkmwTTFeT3VHIWwqFoWKHLTbO9bK6X00Tico/KkLZhsmIN4sGQXpAPmShRykTxXdqn0qMUHlOYqKc0dWQz7a3lTTUIa6DAtr9vSdvNZu6w2Ry5IXFLpp7Ia8qLSJWbpkwzF54CQOTnF8PPqoLZ73q0+F9mVD6gWpE9dGr17nQtPk97y4kIrCI0y+LixTgrS4KEy+8CZx3ZEeqhXZ7rHnQRFZTW+W2OJezOXp7JPhBcTEMh2PtAsX8XwgwOrSrEURZPbHGfBW+5HnS0VB719++FU02dzQs0LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHKX3lijCZZqV85cGShzTOpAppQzTERihrIUjzSCFNk=;
 b=wEMWmzTlSUNaKUytBpeBOUHtmtoUJLuzowgbWKyjAbCCRShi9fcntHgG8sNpW0DxTf9mGucl/NLskL7ueceupeoRPts+EdegOmNTG/adXq1meCsHYU1N+2SPwy9IYHhef0kPfGw66UEfiM7fOFdrTgDxq59tSmAjRq4HG7Lfp0g=
Received: from BN1PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:e0::17)
 by SN1PR12MB2416.namprd12.prod.outlook.com (2603:10b6:802:2f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 05:57:57 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::bd) by BN1PR10CA0012.outlook.office365.com
 (2603:10b6:408:e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 05:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 05:57:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 5 Jan
 2022 23:57:55 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/7] drm/amd/pm: drop unneeded smu->sensor_lock
Date: Thu, 6 Jan 2022 13:57:29 +0800
Message-ID: <20220106055732.3073780-5-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 69f8fc8e-1771-49f6-86a6-08d9d0d97d13
X-MS-TrafficTypeDiagnostic: SN1PR12MB2416:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2416323E0D355597FFAC9072E44C9@SN1PR12MB2416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/mu5W5djaYDNEeeKG9mAp+yETSlt47sCjPoYQg6tJFFg9L1vyf2vhQaQ7SaNgMPuc0ydWBJTMiTx5DGT7Mzat+Ps7xve/Dz1KG5uiv1fQdMsp7B2t0U9PzSkiDs2n/mPfZI88mH6AIYM8ivN6jEah7HYm5o+yUUek6zD2nkrC5iCEXBVxOPaBxvnLUNrWXzm8G7iEq9RvXysz45xupcbJTeIQ0nYfF6KSb+5nOJEw8s0ZR5JrkSNcSa6fzGNnlIBFw+taVQN0auHTgJGYDicbK46Ddzog7JGNOGhckGGUSdpov3/LjLiUBIGt6JHxhcSlrLAvkP54DPqnS/NAVLwvlmncEozaUVEz8Gksvi3yBr7IzWVoN/G2MHXKi4N0Py8TzAw4fTCQUUPaemGYZq1eSQkII0u4hfkJ6y+tcFL948Md5JjdfzwX0ZehfZlP+N1CGA84YArJbF+Y9dC5CCpj+8h5oPhXvjZmxK4bRtSuSHidZ9rbN8RyXlG7rSHEz8J8TAAaF69kBghcX5UtNgcl4QKgH9Rxos2FsVWACDunCpf5DwNEnkBDZ0YdtIwNfChlzEMPACIH2pLt2pCKtOk9G8wRUFjfmc9lKUP8hpaldQiJu/c4qTJQb6ZBaBDGH/CAbZIpEif5Jspbunm/kOHCvnUdWOldYkvIEJRqvEgWDTBMVfuJ95061nTbk9ni2Cpco1uIK2iQ78r27sRbNBPMspLYeGsUHVjRCeL2POLBL67eWK5zAe/S2KJ1JxuASLQgyM9xuMDYQFpEpBIPCx2MCfauKGUgAhmWaYPll4IDQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(36860700001)(70586007)(8936002)(356005)(316002)(2906002)(4326008)(336012)(70206006)(81166007)(36756003)(8676002)(26005)(54906003)(47076005)(186003)(1076003)(16526019)(44832011)(86362001)(82310400004)(2616005)(40460700001)(6666004)(508600001)(5660300002)(83380400001)(426003)(7696005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 05:57:57.4079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f8fc8e-1771-49f6-86a6-08d9d0d97d13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2416
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
index f0136bf36533..23354dd1f4df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -955,7 +955,6 @@ static int smu_sw_init(void *handle)
 	bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
 	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
 
-	mutex_init(&smu->sensor_lock);
 	mutex_init(&smu->message_lock);
 
 	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 63ed807c96f5..2cef7ff46010 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -486,7 +486,6 @@ struct smu_context
 	const struct cmn2asic_mapping	*table_map;
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
-	struct mutex			sensor_lock;
 	struct mutex			message_lock;
 	uint64_t pool_size;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 3f7c1f23475b..ad529e0f45a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1113,7 +1113,6 @@ static int arcturus_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
 		*(uint32_t *)data = pptable->FanMaximumRpm;
@@ -1174,7 +1173,6 @@ static int arcturus_read_sensor(struct smu_context *smu,
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
index 014fb88daa04..041bb430a186 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1141,7 +1141,6 @@ static int aldebaran_read_sensor(struct smu_context *smu,
 	if (!data || !size)
 		return -EINVAL;
 
-	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MEM_LOAD:
 	case AMDGPU_PP_SENSOR_GPU_LOAD:
@@ -1180,7 +1179,6 @@ static int aldebaran_read_sensor(struct smu_context *smu,
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

