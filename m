Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FBBC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 08:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D4410EE11;
	Tue, 25 Jan 2022 08:57:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE5710EE10
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 08:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdqkCWXP+nCwd1jXUuI5Hsn9pzOdzWSeQuIyZFVNmkkuHPVYYgtcmnIUr32y56fCi1Fozf02nto6aG6fLD08v/FwTnVPFWzfC0jFm2UPElKN7ep6jRe+g/w6Kf9YY8zU1lYpUX6hpfcpgJM3QFA5yKP8EPd2mLcTMBlL5xY/i4lU7/G40jBKENpTqHxEuqBEDs3ooBlmM7pweS+tdw1QL5zygoseCHZE5CTNZ1te7StedQTKnJTuwe4gkM+MkN5wK74VMxQ62FcnU+4cxPbRh7j+LtXup3SRbjaXdbq47kZFvVAJb2ggRQ7RbA2cvNo7lHScWv+SBw4q9rgaUd6yow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRsot1xwovLyZVLrX7PULBgxntx3AH4lZXnovqL8Agk=;
 b=lbTuD9xPrxgyclrCl08KplsLI7iWJobh50vA1jP23+qasS6urNgcDIaUJyxLhCyHNBe+NLzZIvDYy+CF794Cgdmy70cJD+uhXxZSH1AE2OEdIkXAEKRw/pJTiKe0zpOtTpywJ/rcQwNuA3RS3UigOjDz7uWDEOsEd/RYdYMpG1uHwVCwNGhyjwUnQnF914rw/WfKoOQ9U8DXvb3qTl1ks7KSFyGIGvjryPoxMigolDj6hcCt8ZNFVSa03YZh4mQS5y4SVu1chgZ05rK3XAgAZB2XKfORCabgxBQ8Y3jazIu9+mZNg+XJk6d8de83S34znJkMhsN/9wSih88OWhc5mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRsot1xwovLyZVLrX7PULBgxntx3AH4lZXnovqL8Agk=;
 b=RjhnpOTJi8OPgSnJj1ftgUf7hA4C6I0/LgQZGtKlTTdiaWHN4gPgeu/clWVvZfb2r8kCs/h38H4snno2YQykU1WFEt5wV+qmAGQy2+U0aLPqbVdq+fdmextNZk2vL7CbI5lyZDCNttIFSgifkJRchv100ehSHZe4y3fL1Q2Xupc=
Received: from BN6PR16CA0018.namprd16.prod.outlook.com (2603:10b6:404:f5::28)
 by CH2PR12MB4646.namprd12.prod.outlook.com (2603:10b6:610:11::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 08:57:14 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::d8) by BN6PR16CA0018.outlook.office365.com
 (2603:10b6:404:f5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Tue, 25 Jan 2022 08:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Tue, 25 Jan 2022 08:57:14 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 02:57:12 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: fix the deadlock observed on
 performance_level setting
Date: Tue, 25 Jan 2022 16:56:14 +0800
Message-ID: <20220125085614.101348-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220125085614.101348-1-evan.quan@amd.com>
References: <20220125085614.101348-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76abb099-eb66-4281-6d58-08d9dfe0ae80
X-MS-TrafficTypeDiagnostic: CH2PR12MB4646:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB464672ADC00DF9116D04F6F8E45F9@CH2PR12MB4646.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+7inySHlPGfbQSq8XYHRdCLY6jbtAbr+pGJAcuvuzZqc8kmP6UIi1DX+JPYND/V2AnV3V9xsMmFOEgcpYKvPjnbi7CtgbUIleVvklpWCVVIpYzRZYYPLIDYDVnb5H0eb0g8BuwS5ie+Exw/E+GZ9RAvSmjfNpRRQcYOJjxEdG3K+cpfwjYzagwPAHrgFYGEdGw0jsPIEJfwVQdf5u7hHxPir12RdxHmJO6xOBxDDYqsirTrDBwBSm0rQlV5qtNanwtJz590YbLlSuSszhT4WhtnaRG0Stp2K0mK6SOk6WC1esxdn2RlKArz+DsnBd9zy3N/bBt7Vc7b8QImHgf3Js+cQ63i/YrgKlHFrsb2XoHvTHwjY+Z8OEEvYhxI9tQ6pYxFHDKLPp9ZgufAVZBnBY9aS+m863eep8aBqZkxCEjlsJT5UNDVw8A9G7YKWSQtwhTuwD2rrLYuZ8q0fsjOy7LUpGB1bPwcjXZ+8RfRWlyt4MEciUALY0Hnmn81N15EZs460X1wJ7st49lLaE0x+UaHAACq5vIp2dUAvc2J7I6LZg/RaZ+fy2iRYOfV0GofMDbhU3hrePHwjVDfs5xfQeTuTJ+pyltCDmXP9x9RYWxz81vJGJI2xqw+2fY3vfdAzf5wsOx5TYdIHlCCiiQeayMCb+JrCSuaboew8C2o5AE7KrGolmUenul1dDE3BOKKSI+WBCRp9KAq7ftn+EA05AZvugFRZ9q+YHFvKTSUgIt9ARUXg0iicxuOyfOGSKi0gjnwuL1jSc2Yx4tdY944WzbKsLyyK77zDMq9avyi6S4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(336012)(47076005)(16526019)(186003)(26005)(8676002)(1076003)(508600001)(426003)(44832011)(6916009)(82310400004)(2906002)(2616005)(8936002)(40460700003)(83380400001)(356005)(36756003)(54906003)(316002)(86362001)(7696005)(70206006)(36860700001)(81166007)(70586007)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 08:57:14.2643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76abb099-eb66-4281-6d58-08d9dfe0ae80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4646
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

The sub-routine(amdgpu_gfx_off_ctrl) tried to obtain the lock
adev->pm.mutex which was actually hold by amdgpu_dpm_force_performance_level.
A deadlock happened then.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Id692829381dedc6380f5464d74107d696f7abca1
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 50 ++++++++++-------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5fc33893a68c..ef574c96b41c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -692,25 +692,16 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 		amdgpu_dpm_compute_clocks(adev);
 }
 
-static enum amd_dpm_forced_level amdgpu_dpm_get_performance_level_locked(struct amdgpu_device *adev)
+enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	enum amd_dpm_forced_level level;
 
+	mutex_lock(&adev->pm.mutex);
 	if (pp_funcs->get_performance_level)
 		level = pp_funcs->get_performance_level(adev->powerplay.pp_handle);
 	else
 		level = adev->pm.dpm.forced_level;
-
-	return level;
-}
-
-enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
-{
-	enum amd_dpm_forced_level level;
-
-	mutex_lock(&adev->pm.mutex);
-	level = amdgpu_dpm_get_performance_level_locked(adev);
 	mutex_unlock(&adev->pm.mutex);
 
 	return level;
@@ -725,23 +716,16 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK |
 					AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK |
 					AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
-	int ret = 0;
 
 	if (!pp_funcs->force_performance_level)
 		return 0;
 
-	mutex_lock(&adev->pm.mutex);
-
-	if (adev->pm.dpm.thermal_active) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (adev->pm.dpm.thermal_active)
+		return -EINVAL;
 
-	current_level = amdgpu_dpm_get_performance_level_locked(adev);
-	if (current_level == level) {
-		ret = 0;
-		goto out;
-	}
+	current_level = amdgpu_dpm_get_performance_level(adev);
+	if (current_level == level)
+		return 0;
 
 	if (adev->asic_type == CHIP_RAVEN) {
 		if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
@@ -755,10 +739,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 	}
 
 	if (!(current_level & profile_mode_mask) &&
-	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	    (level == AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
+		return -EINVAL;
 
 	if (!(current_level & profile_mode_mask) &&
 	      (level & profile_mode_mask)) {
@@ -780,17 +762,19 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 						       AMD_PG_STATE_GATE);
 	}
 
+	mutex_lock(&adev->pm.mutex);
+
 	if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
-					      level))
-		ret = -EINVAL;
+					      level)) {
+		mutex_unlock(&adev->pm.mutex);
+		return -EINVAL;
+	}
 
-	if (!ret)
-		adev->pm.dpm.forced_level = level;
+	adev->pm.dpm.forced_level = level;
 
-out:
 	mutex_unlock(&adev->pm.mutex);
 
-	return ret;
+	return 0;
 }
 
 int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
-- 
2.29.0

