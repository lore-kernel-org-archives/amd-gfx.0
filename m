Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F1BC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F62A6F381;
	Tue, 30 Nov 2021 07:43:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A836F381
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhuxXfK4AhGh3AiUhyBzvkxo5xtKkqbUCokpLu+Ob/k26jvDJKSXdQ/Xg4Mk6gJaudholLhIud7IMEAl1G4SXYSJ5uJ5QZH045Ehry4bJMuJcQieIxsYs7K5SmCz7TBKGg4J0UhgxaLjuw6q1QIrajbN6SQsmLWIsWfWpNGZEReWwHjbk41VsBGIUv1b/KJ8WLHyqGvxb6/D/CivfIFild4zMOODuAd0Zc0vLSKlmLguzA07D/P2GgkTBRT1/V/iruD2tjJ7YVrRKfFswfyW5fkL3Id0ZhUiDPmUfAzKPO8/OUmF8RjlbTZuRT9AXR7TARuWLEMDoOJkOLnD9nw+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN0lhrPl8e0iFdgPM1zkCfs3YMQ4+kHkuQB4hGatiLA=;
 b=RUWlhRR26PNVxu3Ez0MbofvXaRe/bRQOzCo5yH+QUbyvz88uR81NAVGkTKa7oO9tuKOJSMPONSqBn8ipvsJKbZI8cbw2bNKpoANC43tDJDae+75n31TUar43N58+e/Ji4bKNPTtsocctnijiliTx47RgRBrGFLKVGkIyH8mjPCW/L8VMdwTt4slgswHG541RitzIdAIGs5bzh4RcOO0dMuAX/e27uRrxaXjTDKvipPHZSrskB3/60THaraMUgR8N/4KOmEuI4WdfbQH83Q5WSvHoW/OtRkaBs7M/XV/HH/szzn7xLPBli95bH/wujU9a3vQ0j0saqFEkH4y0iemO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN0lhrPl8e0iFdgPM1zkCfs3YMQ4+kHkuQB4hGatiLA=;
 b=TnAr0qC+q2ISuHjRe6pm5DJQ9xx4CIaRRpp+EWsz85BEQj0UKrXuOWkRT7y8gZR2LGqBUFL8UJq2kh9lAiWTsIj3R02HODG1pf3kSzO+koqfJEMfSpNZUGEZYpoAdhGZD8NHheLCkKo70Cd8AOwy0ENotzKuVGizcrpGUp43JnU=
Received: from BN6PR11CA0005.namprd11.prod.outlook.com (2603:10b6:405:2::15)
 by DM6PR12MB4713.namprd12.prod.outlook.com (2603:10b6:5:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Tue, 30 Nov
 2021 07:43:36 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::1) by BN6PR11CA0005.outlook.office365.com
 (2603:10b6:405:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:36 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:33 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 06/17] drm/amd/pm: do not expose the API used internally
 only in kv_dpm.c
Date: Tue, 30 Nov 2021 15:42:48 +0800
Message-ID: <20211130074259.1271965-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5f9866a-4d77-4654-a264-08d9b3d51df3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4713:
X-Microsoft-Antispam-PRVS: <DM6PR12MB47137131A56E7198971452FFE4679@DM6PR12MB4713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q981SUSK+myESa8MkSMMZeSTcVom8h3nyUi5vcNWl4+txm6d7wloAbQeHjCK40Is4LEzIkP1cNF4nooiXchIDXyNdtPcVsX4YiPOEFgbOB9ve1iHgUgYEpacd4/+kM8RD4JW4ImbYeXRWwBEguE8zzDcgIuPQAVWUsosb9Ca5U0ObNwzZeM6OvXrqw2/L+OIgNTtzcEIllhHK5o/bPm//PtfhJLodQEzMtRef0W/hsQfxINp9Mpmv6Ya09kGf0rfvIewrdab6wWFXojAdNk/OwIJ3rNmklcn3QFBsaX4fFBGykW9iGrcHnC+77p9XvI5oX3oj8tVYi7q6M8mCBcxFqS7ezRu5cLduTc/csx/B0vYaDAyIqWQGi96sMsBKdJA1/f8vBQ80u+Q2vfBdYtuB8zxLuuWGCkgW11e5i9bbpOjjNUoeF8tA5JMNNZ6hFztExs2RNmMG4/y9cPUa7K43nrOE64j4m1Mq8X6vu6HvqmJi1BZpjsp91DUucYTwmRxhhIjibUxoh2y72XNlGky0kAtxaMS0q2OpocGnJEcBFVooWldQ2rOpZaiT/F/ezqw84dKX9IjL86WNXDKzOZiO1hX16j6eEjlc38HwKwdnj/yxVsIcyjD4Mkzb+BrQNrczuFi93oapnsEo44lt8VgOWcnwKoK6LfwEMQ6ACEsCn8AjzXN+HG4CMY0RVSKZBQTGDjfctNTJj06/3dGFffWiPWM1KbmmeGRgacNVZuhpaCY+DoaM3WlLomrnHpq2P467XbDN+C1RSIpyzrpB4qARK2UXcNpllsgu47L5UBuY20=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(7696005)(4326008)(6666004)(5660300002)(356005)(44832011)(426003)(336012)(86362001)(2616005)(47076005)(16526019)(54906003)(70206006)(26005)(70586007)(6916009)(82310400004)(36756003)(508600001)(83380400001)(8936002)(2906002)(186003)(1076003)(8676002)(81166007)(316002)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:36.1118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f9866a-4d77-4654-a264-08d9b3d51df3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4713
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
index fbfc07a83122..ecaf0081bc31 100644
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

