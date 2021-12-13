Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74BCC433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D34C10ED08;
	Mon, 13 Dec 2021 03:52:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE27D10ECFB
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=armmX0ElP/aB9Wcnokhpp6/bURY7l03v9qFcoKV09bZ1N6yOFO7wLSjbZ+qZy/sHFeBJWY9XdLaHXX70xDAvcS4v9QLY6ElcHipDvyWiN3pDb7Rr5A/wk9akpD6dmkrArsLviJvFbHX8EbpGxK4EZRZQeMYa7AME3+OQP+FjmMPdxseO4T6cqrWATd3/niJRp33f0/lGWdH247quvAw5oakXjabjTy+Z9mpdggDzJDoOwwUu7YPhgqmNaXfvzIuFdAmwyhlWj4k09JWBRIMZdf+sY0ToaPnu7NIpuF0tDD8mv9JuBX93XX1t6ZfVl/7XvUe9dBYJVcP99eb/Ue7dsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf+NeXZ52LHJ1HVsvfbnxyyn7LHxAcsx7RZyl8i2Y+8=;
 b=kmKoYT1Rk92P6F4vVdLxanv9Xc2RrAadazMdYDc9hfnTzPsVibkysS84Qk36AFYfRsm/TNaCO+wTU65Cqm948GKbc2PtdhO6Ftc6WhVGPdwtzeOtZmSizlB8Yqb64pomRMB9Yu30Qk/9PZ6OtzDg9uRKiamoRRVwD+rWGAQlKsv/0u1KOpcC5UePk4jNwPVwVVo/PQpBCHvAJCskV+pWJdFxPxHHAyRbaHy2uEjYhJ1F6rdoeioVscVpt3py+CU0LGula/xtwinCYLzQktkHItDfptfsIrEJ0IGRRZE8+75exYqCq261xrwLxKY7as/5CqadQEkeqBFjYVJRUeDzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf+NeXZ52LHJ1HVsvfbnxyyn7LHxAcsx7RZyl8i2Y+8=;
 b=ROXPk4ckYfMcv5rqP8QPyFiNXHI1lfazevztt7OOrtWOmPs8yXGarXfqWv2N9qKfy8pdqD2QLLqHXeFwyF+JH4zL38TWEp5ZVtXa2hserHMtc7+2dp/36Cd+qX9zw/5DphkxzFL4T7oOzSAp8UG1Xc/IqqnqPnnSpRJfHZBKaDM=
Received: from DM5PR16CA0043.namprd16.prod.outlook.com (2603:10b6:4:15::29) by
 PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Mon, 13 Dec 2021 03:52:52 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::23) by DM5PR16CA0043.outlook.office365.com
 (2603:10b6:4:15::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13 via Frontend
 Transport; Mon, 13 Dec 2021 03:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:52:52 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:52:50 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 06/16] drm/amd/pm: do not expose the API used internally
 only in kv_dpm.c
Date: Mon, 13 Dec 2021 11:52:13 +0800
Message-ID: <20211213035223.772700-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dddb8e28-bb2a-4d29-4de3-08d9bdec09d3
X-MS-TrafficTypeDiagnostic: PH0PR12MB5420:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB542069ED9E9628F827D31CAEE4749@PH0PR12MB5420.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNaJ3rZPo6sRyISWKh75eFv+4i5zbeAUyEoClePCowQtOUxcoUY37TkgJJ5Aka05JETNCspxC2l+K0pN2HPvzxiEOauiPQADE1yV5eD+6ZXBq/x45uNKERjmXWgQo5ZvGe7nLr6HwjqFyX4M7+YAJW3zKa2Ja6r05BoyTXrxd0dc1BEw1mkdPDz6RKvVMT/WCbJsuGcYXoZYXgenfucTV56P3qhrNk7YCp/iunyFz9keRYqgv4+duUaIjEIdRDRKbGFr7xVRApBUpqHbEfE2KxNiQ16DpL+iu3mNmz36+CSE8bM5IzgFUfUGlrmuF6uO6+yfG7ojHKR7PoXLhddjc7Diw3sBUakdPbJu6FyfrKUZXlTri3Jks2tXgJk1qdVB4YnHhvrE/pkOxZgwjeGOkQCgsf90lxaFel38ZVq6Qaq2KITyVYa+CFEb0/vXxxyZeT9DFCTmh3kgJwVewL/SdzE+HljKhPgrfvBXXJ8pjAUmx2VGmJA9cCdAzFQMIHwQdxxeSxuKhNLBqwoFHZTB1ULZi07h7CUP1DKRhiRMb0lJ3M8evw9blgK6H/UeOPACM0NbvUhu4RmIHftUBUhqc2iUBFwvxL6YHbsMQrXRSVfPqesxXDoUj2Brpc2Kz75Rp9N+FeFKngMXd/7HzKdWZ91n91ayCZp5TCsp1yJe0XpH06023AAHIpae31LHnhMqVXP6gwjMRNTjwHakyp36ozg4O9si4+h41NRIWpS457AL1K/sbeJ2IGQCj1pYhn3gnbRenGtXoeAGt8kl2Px99u5DoqbPMQw06C4i1Jki2kE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(5660300002)(36756003)(83380400001)(7696005)(44832011)(82310400004)(4326008)(6666004)(8936002)(86362001)(1076003)(2906002)(426003)(40460700001)(54906003)(16526019)(70586007)(316002)(47076005)(70206006)(186003)(81166007)(356005)(2616005)(336012)(8676002)(36860700001)(6916009)(508600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:52:52.3629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dddb8e28-bb2a-4d29-4de3-08d9bdec09d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5420
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move it to kv_dpm.c instead.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I554332b386491a79b7913f72786f1e2cb1f8165b
--
v1->v2:
  - rename the API with "kv_" prefix(Alex)
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 23 ---------------------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h   |  2 --
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c | 25 ++++++++++++++++++++++-
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0f9e109941f1..d356c444a034 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -209,29 +209,6 @@ static u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
 	return vrefresh;
 }
 
-bool amdgpu_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
-{
-	switch (sensor) {
-	case THERMAL_TYPE_RV6XX:
-	case THERMAL_TYPE_RV770:
-	case THERMAL_TYPE_EVERGREEN:
-	case THERMAL_TYPE_SUMO:
-	case THERMAL_TYPE_NI:
-	case THERMAL_TYPE_SI:
-	case THERMAL_TYPE_CI:
-	case THERMAL_TYPE_KV:
-		return true;
-	case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
-	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
-		return false; /* need special handling */
-	case THERMAL_TYPE_NONE:
-	case THERMAL_TYPE_EXTERNAL:
-	case THERMAL_TYPE_EXTERNAL_GPIO:
-	default:
-		return false;
-	}
-}
-
 union power_info {
 	struct _ATOM_POWERPLAY_INFO info;
 	struct _ATOM_POWERPLAY_INFO_V2 info_2;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f43b96dfe9d8..01120b302590 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -374,8 +374,6 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
-bool amdgpu_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor);
-
 int amdgpu_get_platform_caps(struct amdgpu_device *adev);
 
 int amdgpu_parse_extended_power_table(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
index bcae42cef374..380a5336c74f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
@@ -1256,6 +1256,29 @@ static void kv_dpm_enable_bapm(void *handle, bool enable)
 	}
 }
 
+static bool kv_is_internal_thermal_sensor(enum amdgpu_int_thermal_type sensor)
+{
+	switch (sensor) {
+	case THERMAL_TYPE_RV6XX:
+	case THERMAL_TYPE_RV770:
+	case THERMAL_TYPE_EVERGREEN:
+	case THERMAL_TYPE_SUMO:
+	case THERMAL_TYPE_NI:
+	case THERMAL_TYPE_SI:
+	case THERMAL_TYPE_CI:
+	case THERMAL_TYPE_KV:
+		return true;
+	case THERMAL_TYPE_ADT7473_WITH_INTERNAL:
+	case THERMAL_TYPE_EMC2103_WITH_INTERNAL:
+		return false; /* need special handling */
+	case THERMAL_TYPE_NONE:
+	case THERMAL_TYPE_EXTERNAL:
+	case THERMAL_TYPE_EXTERNAL_GPIO:
+	default:
+		return false;
+	}
+}
+
 static int kv_dpm_enable(struct amdgpu_device *adev)
 {
 	struct kv_power_info *pi = kv_get_pi(adev);
@@ -1352,7 +1375,7 @@ static int kv_dpm_enable(struct amdgpu_device *adev)
 	}
 
 	if (adev->irq.installed &&
-	    amdgpu_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
+	    kv_is_internal_thermal_sensor(adev->pm.int_thermal_type)) {
 		ret = kv_set_thermal_temperature_range(adev, KV_TEMP_RANGE_MIN, KV_TEMP_RANGE_MAX);
 		if (ret) {
 			DRM_ERROR("kv_set_thermal_temperature_range failed\n");
-- 
2.29.0

