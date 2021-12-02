Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E4DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 835176E945;
	Thu,  2 Dec 2021 03:10:18 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D516E932
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNuOgkQzhb2YjeyrTzhwe2QsgphNi/BkJrm4YvdQ/i1RK45nhIBYPpYV+vtH5bJbnEn0FAizF1IsOuOZHulhp+P0V6A5cLSZUil2IXRyKcW9JxccYAPpOSqAxJR3b4BPSEXrFdMVLj1SwL5jKxEUgNb33Ng+mQYdI4Ffehc7PMpn7KLd9yIWnbtAf0JVv1GPUsEsMv7iq56OMF1GYlsKEY0L4d1qNNN0Tn2A0LKjfRbFbLwrwPZszkVzzTkEv2lB1V84a3HOl2Ag134Zj8vi6AYYCsp54zwaSCtOsaah04K348gJuy1YI50h99TR2z/otuO9zcO8H3IpgM2WMyvIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVwhkd4h+glHVZuHcdM346HkRaOsI34VYbWEDXbmG7c=;
 b=BEGzUhzemlLBQoUoKMwqFF1ATXQsmJOnQK+5ZThorcWSh+AbSt/bCYQ+2ukpLILRU0/M+DrIUC6Kb3+rBCrvE1bWcTBc5cn4nQ+TUrQ3ZA0QqYiD6jvW8VfYDdXEvBQpkqfBOjFsvIcYA5mj9EpBFPUIl9UVvmFmdnr5Ndy8JrNQO9+rluBoLun2FfsKNziWOdd8AvZrvJZ28+77gFknkQu+AK6y/5GEky5w/dorWbD1m4OeFJEt/pDx9dHK9zZVTosacDOZAkfrmwO96hybU3+uCykHqTf+qyT98CZkwe8IqaO8kauHjG+3x54bOkFLT3crmjv+DShFSEojG/2JJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVwhkd4h+glHVZuHcdM346HkRaOsI34VYbWEDXbmG7c=;
 b=Tr+prTN5BHef4o0lT0uxRRXfHRorhDxHIoCfdxmP8b8zfI1d2gPfuwleCVEXSheFDCCh2rU5q35JmjXg1GSkYFEGFfbbxtGsHVCf8Lq/OiHD2gkDT+1Ms22g9t9mgiLXsHsDeuizscL/+VRglpDrYM42tRFZY1O0EW1IPzwvWwA=
Received: from DS7PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:3b5::16)
 by SJ0PR12MB5455.namprd12.prod.outlook.com (2603:10b6:a03:3ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 2 Dec
 2021 03:10:13 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::40) by DS7PR03CA0041.outlook.office365.com
 (2603:10b6:5:3b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:13 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:10 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 06/17] drm/amd/pm: do not expose the API used internally
 only in kv_dpm.c
Date: Thu, 2 Dec 2021 11:09:19 +0800
Message-ID: <20211202030930.1681278-7-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211202030930.1681278-1-evan.quan@amd.com>
References: <20211202030930.1681278-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3003233e-f53a-4117-a97c-08d9b54141ca
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5455:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54556A671CC466FEEF9972ECE4699@SJ0PR12MB5455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnNZFBoWjbYENuSfJHdJ1qn/cSnl3Sy8Iy6id8a9pTxd+x9Eku4WN6f41wvJ1u4Vhw3bjtwgBH95aFqcZ2LERVo8p4HUdJ9xYHIEFzAXU0LkrTowuuGUOF7WO9VxDDmbQ2rG5YgghYGqiArsbJQ0MfHJ0QUynwrZBz05AKxflrBEdYQ0y4XBQixR+k2BwLaE4OxCUbtQaA3BEc2fZ8FX6vQhWYW6rkl9wc4KIGDdUXQdFAQXszoOIr23Wyrp+qLYQnEYTp8mAVtXKQrefNqN4pZHnro0FwgZq0hq5q2mwWgH5YcBevIWPbfWZ/34o5J358l99E3OJ+ty4By4oEDZb5ZJoiTFKZfK9fDCO8V46E1Y7ie3ZlG+x9KcEF0/h9qUnnIFi2uDTGxhtiiVgNBHOgfw+CkYkPyjtYVmRxA/CqsAe1JUsGEKcehyt9Qg80MHRxeXyXzuGZ60h6y33DsD+SDnsBxLfKzvOm+yZslhR1IvCaPX7Hn1q9NNZCc9kd/U9R68DtD1OlTnm98sEiR0PHrwc4hNXm1Ij39zgm1GI70Em+al/dQtOOq1t+zAl6f1urJGdrORfhiMrgCdxQ+wLa/CpdI6e/uv3EiGGAy4kQ6mUeL72ghPzb3zf4iNJJ0Q69sUo6WzvVQ5pMZzsUfweX9r4qtyjboEPdEXyq/BBZayFTjDhlXQXFfwP9N4nSKUAqQ2YJkEA8BEIZ5yxAL8WMhjzzPkp+MyO4FZHMVyY8JFIpSaG/wkVgUdguDgPApUttJogwDVDB0Mgr84ZNvXBnRYvdmClNsujeYG0W4qaYE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(426003)(36756003)(356005)(40460700001)(7696005)(26005)(83380400001)(70206006)(508600001)(6916009)(4326008)(47076005)(5660300002)(70586007)(1076003)(8676002)(86362001)(81166007)(2616005)(44832011)(54906003)(186003)(36860700001)(8936002)(336012)(2906002)(82310400004)(16526019)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:13.0157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3003233e-f53a-4117-a97c-08d9b54141ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5455
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

