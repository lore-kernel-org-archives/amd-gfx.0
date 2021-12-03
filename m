Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34628C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 03:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A81DF6EB76;
	Fri,  3 Dec 2021 03:06:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95B5F6EB73
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 03:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B35m+9gbykePDR6rJBjhl/fWsNvTKb57r/tTflT254kvCKryznZXjuNg8c3MzQB+jYZ48CU1F1yxAxa0gHj0smwjLsGWknvta+B8vQBw01YnZgNRfv8K0gBv0W7LDg3pqTSpWHFRCMJ+49tbVdhRKKFS58K5LtWt9BWr1T9Mq0h6mGtVkb3gt+hn5Y+s3db2rKxpiIR7S9D8zieK4pnXiwuBy4F6Q3YyYp5KNPCk6pSwdWMK1coSosgc+m1qq3baW2cK9ByV8OcgTg00Cfb5f+3GVNDkelT8f0VdmyfjpUpIvs1kfTCO0AiHOfVRXDmaByTAFW17ZzYjiEHi4G+yOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVwhkd4h+glHVZuHcdM346HkRaOsI34VYbWEDXbmG7c=;
 b=g1sbTOcNB6brRF1rvlEL0s4vswG48OfsLNimkaffy2QbaJd9HpNiciQa3x/KGRp5APSLBjJLe0YO+JHL1BoGb+jQGn3gnU3Bjnjcftbz19elq8ndrKI06QlXrBn3RPD6uOUZzt/tTc8gAXl3QEhQwZ6kpCxxy++k00CWC0Y/qY33XWbwpMjXQD+z2cKd4TJnexKsRfNt8mqlnnBN7922b/rKm5vHDrP1MCjnjMrRkaB9Ftcf08x+HsnTTKmwN18NSLuLBnCZUJRQB/NDREf5b282RGNbgEGDMDAs8jeEWKwV19FpULZ3w4bQK+RgNIxPo8CrmKxPytOzgufLKiS3Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVwhkd4h+glHVZuHcdM346HkRaOsI34VYbWEDXbmG7c=;
 b=eYIs7B9xcKz0fACVLVN7yzvgr9kvJ1t07uo7x5ar5ODndaLbsxlQL2UfltBF/VsWUK04u9/Ia7mJUYfqFzn5p7NwWK2A3fNsKunTIqA73lB0LYqEkwU7U3al7Trzk/9Vcz4BzTbwtWxNq8QwThWR3AkVB9bd2nZ7B+SdV9x8Gug=
Received: from MWHPR19CA0057.namprd19.prod.outlook.com (2603:10b6:300:94::19)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Fri, 3 Dec
 2021 03:06:12 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::64) by MWHPR19CA0057.outlook.office365.com
 (2603:10b6:300:94::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Fri, 3 Dec 2021 03:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 03:06:11 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 21:06:09 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 06/17] drm/amd/pm: do not expose the API used internally
 only in kv_dpm.c
Date: Fri, 3 Dec 2021 11:05:29 +0800
Message-ID: <20211203030540.1710564-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211203030540.1710564-1-evan.quan@amd.com>
References: <20211203030540.1710564-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7d587f5-0ae0-483d-f1a4-08d9b609dc88
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4416EEAE9E5B0B4CEFE65B2BE46A9@SA0PR12MB4416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8yS8/1txhH5IOZzdwi2XNDREhMJCkskiOE6Lms+y84o/04j1K1GxjeSjwtAeF1fMG06LdIgoIR8rXnM9g2BS/612jZ5I+omx6d/3QMgi/xWTVntSny4bmB3dhqteAtbuck6vSiv5lvr15N3F+aQSgRj8yFLTia3E2hOeHUpNDlR2vivCIwONvLewYALgYdB/2c9hCVbxYiC+0qN4XIxiQPBZpHgEmx8SBQFPoYCn1jQCEojZTOFW57Nqa1OxJvnj8HBb2cvvnMPPerxS77Ds0IWlt8KkMXxZQNgb5xksPF/pR9Qibm1HAu8fhh0k7ABpzFHDTFHQDCknPImNNSz6dPFCVyylPvhsJbY5lTLmpWH7MLyaAyDrq4ayfKYMiw/CZpJo/DBWLf/cS8H582iUtoGx1ttVV3l6USMYtSMKgowUjtdT4uXzhZ2GAkBZLUnDW/mrHOaQDEfSv+UcQW+lTVDj3slj8kf08M93YygzX6aOyciVbbHvjYoKmoWGn3FwtaqtvGqiMj8fvZwWZld+ZbPG7O7KoDGnplpF+aPS33Ll1xEhdEL4R1vhPA2P/eoFtGu55mrJJyjXc/MwezeX/0IZi0ObWuLrTn4XDhbykv6AvM1rE1wV21dmCHCSLAbZZZ5vGZGyp15/7L6BQHq8sOFquR9w0Yd3oXYkQ2ZeJycwwSGKq1L1bEqGmRNNH+iqJXezanWtxtG/Gvv7NrF6jfHX2MNNrqUzwKdwcd7wsIA2QJaJwynIZlm4YtNHu8erM1z+9Xo6iP1iKox6pbyGkYM4yL18e27SyG2CyFwp9w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(6916009)(54906003)(70586007)(316002)(6666004)(1076003)(4326008)(356005)(26005)(508600001)(2906002)(8936002)(36860700001)(7696005)(8676002)(86362001)(16526019)(40460700001)(82310400004)(83380400001)(5660300002)(426003)(44832011)(336012)(2616005)(36756003)(186003)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:06:11.8840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d587f5-0ae0-483d-f1a4-08d9b609dc88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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
index b31858ad9b83..efe6f8129c06 100644
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

