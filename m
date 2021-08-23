Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36849C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 04:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BBD61248
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 04:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0BBD61248
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E36F89C54;
	Mon, 23 Aug 2021 04:32:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0E489C54
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 04:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIOA1rXwPt8UV01m8AyYzuOGnXDu3cbP6c/rfxyqRg+HKTcxfvPm6oVjiQbRY4QvKAMsuF2yhqHQ5U8cLXUgXeHiqhk6++PNMhzgHZe3DfVxqRzpUc1xzQ/RXMrBs+EtbGkwL3biNNLkjYyjADQtOVpzRZW+dmH7gOnZlW/3rsA5ImwIUgMIJlSuKjYTJwKYYUW+afTI2/XR+sdU+gRK+e4cUXK1XZkxSOomaGkB/xTMqw0NpO5EoJmkMJvyJKSnp1x5hXVGTwYQlFcOWmh9uRVt31//wDRaxhdz3T6rtePDKhTVvGryrc7qYvpW1wjWCPbXaqtIfYQg1O3R1ZcYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw+yB3YrzM/AKc666hEP4ha8SirY41SZuuA2AWWFo5o=;
 b=H4QTyfAs/fPjdnj0JxNzdePCJiDThD7bruUK9XKHXIJaS0MMN09F6+lANm8fp7Pd1aIrZWgku1qo0ZdG4cH1c0iN4o0ONsXu7BdlfxIVdKYiePT1kGH05H7vsYDVS3vcnmvdLURZ77GNPW4KqMT0yG02V7z+u4JWS/I0+yaZSV2vcc9z/cOEcirT9ucTkWVtdtyW5QjjCmsFYa/kg57mmO/Voq2L+jYUuaVqT5J19Psb55moezxpIfnq1whDYS4YgcQyW/pY6JlsRMGeTeC9fEmtnUa0mWHrNptUYA+V9WEliJqbPtFf+sRh2ZYwra6ZLwHgT7QWkUb3GKft7A+7GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw+yB3YrzM/AKc666hEP4ha8SirY41SZuuA2AWWFo5o=;
 b=dF8eb3CjjpN+9GIr635xFZcfiHOxHV4AbSbalmS1yOXrLUFidTuKFzPWOMiO/GzuINb19VcojXHnWtGcTn51xlDkTlGPZyE/HSZJ3DABwqkhVOS5duHC3RcAO7HBJJ3i+XLujAXc8QUtPsL3IeJYoCs0UyKdYQI+tiKhSVVf3QM=
Received: from BN0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:408:ec::34)
 by DM5PR12MB1401.namprd12.prod.outlook.com (2603:10b6:3:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 04:17:55 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::5f) by BN0PR04CA0119.outlook.office365.com
 (2603:10b6:408:ec::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Mon, 23 Aug 2021 04:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 04:17:54 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 22 Aug
 2021 23:17:51 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 <James.Zhu@amd.com>, <Leo.Liu@amd.com>, Evan Quan <evan.quan@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: correct clock/power gating sequence on
 UVD/VCE suspend/resume
Date: Mon, 23 Aug 2021 12:17:34 +0800
Message-ID: <20210823041737.48921-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67acabb1-ce44-432a-6515-08d965ecfad9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1401:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1401AC52D2C941C524082C1CE4C49@DM5PR12MB1401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+YG3GAtOs+6Y2cmiurHm0mgxlTAPXUOL8st7hCZQQBs2eRqfB6e5U6jvxHBMTBRFZOySd+AyItNhcHmbU1h4tfu985vAorN56P3o/K7WflafQ5rAFtdwbqWUYn7EaJ5W5oMKIXYSuAX7+jyn5/NAIPqfyPVgI7Ra65CvGBcTDk6glJSAr7wDDC+/pjSwnOM0sfyEZgw7x2efNXUZxFXzeTVzui5icRO1LxIE1q0liULxGPZf6WshY9VDFiC/AyBm0014lKuIzFCV00HA+Oeq6dLNffVq+N5PvS/aHfb4fksov4TmQJCcs1M3NDNgKq/SMdzb6y9kIXm+l0L3b4rzlpXuUcUpPEyszA0bJZfEAzhN15GkidBSMv5w88w1eKXvwLTpaBbZiRWhzTfCIRQS5+noL8Uc+ZZHw25jGIYBUKM7Rk3z/uLau7fBVxB7ZooXpSbtlkgQZ8AFeEoGXJzFAbfs/2gratHkBGT3kRB7jHIq0ntjI0fjL1+9McGxndDLmeiMecOgpkaOC8KIQhiQEAsNjNxISsJbp2sgEVyqa2z2rDKGmxKE6GYoc68+ZxDlTLuVL1kedYy7teTWliuTCSHVeg+y56P5qrIBaMS4HzK17O1QISxB4gqMe1an0q/0POGDWrlCCwaiOSUjqpr4oUu4Sk2EccZZUrZuo6Eih2q+xN67/3ZVpiUy4szqd1EO7Q3JJZQsNGQ9MMuvabYFRENslFaX2e39mVqXEZCwJFI3OjbLQPEYy6/9QF9yuxsm3DHFi2PEDBZQt+Av0XCQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36840700001)(46966006)(54906003)(36756003)(478600001)(316002)(8676002)(336012)(8936002)(4326008)(26005)(1076003)(6916009)(47076005)(186003)(2616005)(44832011)(5660300002)(16526019)(2906002)(83380400001)(81166007)(70586007)(86362001)(6666004)(70206006)(34020700004)(82310400003)(426003)(356005)(82740400003)(7696005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 04:17:54.4444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67acabb1-ce44-432a-6515-08d965ecfad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1401
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The clocks should be gated before power. And reverse sequence should be
used on ungating.

Change-Id: Iab09f1f616560ff1083b75e95bfc6433d05d7f98
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  8 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  8 +++----
 .../powerplay/hwmgr/smu7_clockpowergating.c   | 24 +++++++++----------
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 24 +++++++++----------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 445480b50f48..859840ac5f0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1238,10 +1238,10 @@ static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
 		} else {
 			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 			/* shutdown the UVD block */
-			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_PG_STATE_GATE);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_CG_STATE_GATE);
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+							       AMD_PG_STATE_GATE);
 		}
 	} else {
 		schedule_delayed_work(&adev->uvd.idle_work, UVD_IDLE_TIMEOUT);
@@ -1262,10 +1262,10 @@ void amdgpu_uvd_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_dpm_enable_uvd(adev, true);
 		} else {
 			amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
-			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_PG_STATE_UNGATE);
+			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+							       AMD_CG_STATE_UNGATE);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 7ad83da613ed..21b4fc48d33f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -344,10 +344,10 @@ static void amdgpu_vce_idle_work_handler(struct work_struct *work)
 			amdgpu_dpm_enable_vce(adev, false);
 		} else {
 			amdgpu_asic_set_vce_clocks(adev, 0, 0);
-			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_PG_STATE_GATE);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_CG_STATE_GATE);
+			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+							       AMD_PG_STATE_GATE);
 		}
 	} else {
 		schedule_delayed_work(&adev->vce.idle_work, VCE_IDLE_TIMEOUT);
@@ -376,10 +376,10 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_dpm_enable_vce(adev, true);
 		} else {
 			amdgpu_asic_set_vce_clocks(adev, 53300, 40000);
-			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_PG_STATE_UNGATE);
+			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+							       AMD_CG_STATE_UNGATE);
 
 		}
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
index f2bda3bcbbde..e1f85f777eac 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
@@ -118,22 +118,22 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	data->uvd_power_gated = bgate;
 
 	if (bgate) {
-		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_UVD,
 				AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
+						AMD_IP_BLOCK_TYPE_UVD,
+						AMD_PG_STATE_GATE);
 		smu7_update_uvd_dpm(hwmgr, true);
 		smu7_powerdown_uvd(hwmgr);
 	} else {
 		smu7_powerup_uvd(hwmgr);
-		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-				AMD_IP_BLOCK_TYPE_UVD,
-				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
 						AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
+				AMD_IP_BLOCK_TYPE_UVD,
+				AMD_CG_STATE_UNGATE);
 		smu7_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -146,22 +146,22 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	data->vce_power_gated = bgate;
 
 	if (bgate) {
-		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_GATE);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_VCE,
 				AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
+						AMD_IP_BLOCK_TYPE_VCE,
+						AMD_PG_STATE_GATE);
 		smu7_update_vce_dpm(hwmgr, true);
 		smu7_powerdown_vce(hwmgr);
 	} else {
 		smu7_powerup_vce(hwmgr);
-		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-				AMD_IP_BLOCK_TYPE_VCE,
-				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
 						AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
+				AMD_IP_BLOCK_TYPE_VCE,
+				AMD_CG_STATE_UNGATE);
 		smu7_update_vce_dpm(hwmgr, false);
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index b94a77e4e714..a6147db548ca 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1957,22 +1957,22 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	data->uvd_power_gated = bgate;
 
 	if (bgate) {
-		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
 						AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
+						AMD_IP_BLOCK_TYPE_UVD,
+						AMD_PG_STATE_GATE);
 		smu8_dpm_update_uvd_dpm(hwmgr, true);
 		smu8_dpm_powerdown_uvd(hwmgr);
 	} else {
 		smu8_dpm_powerup_uvd(hwmgr);
-		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
 						AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
+						AMD_IP_BLOCK_TYPE_UVD,
+						AMD_CG_STATE_UNGATE);
 		smu8_dpm_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -1983,24 +1983,24 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	struct smu8_hwmgr *data = hwmgr->backend;
 
 	if (bgate) {
-		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_GATE);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
 					AMD_CG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
+					AMD_IP_BLOCK_TYPE_VCE,
+					AMD_PG_STATE_GATE);
 		smu8_enable_disable_vce_dpm(hwmgr, false);
 		smu8_dpm_powerdown_vce(hwmgr);
 		data->vce_power_gated = true;
 	} else {
 		smu8_dpm_powerup_vce(hwmgr);
 		data->vce_power_gated = false;
-		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
-					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
 					AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
+					AMD_IP_BLOCK_TYPE_VCE,
+					AMD_CG_STATE_UNGATE);
 		smu8_dpm_update_vce_dpm(hwmgr);
 		smu8_enable_disable_vce_dpm(hwmgr, true);
 	}
-- 
2.29.0

