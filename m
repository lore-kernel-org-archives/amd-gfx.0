Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859FCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 03:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0D06EC01;
	Fri,  3 Dec 2021 03:06:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6D96EC08
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 03:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SizQ/GFxROCznuof7p3tV7Mtxxax4kWNlmmNvdZfm0PT6174duzxxDcwF7/wNL7xp8kXD+NNvfxOKwwQ2debYAeOQPtupAWqvmDklcrJMywRQ1yuRGfE91Tte3Alg7ev30uIVPuUaaY6SEJVMboz3J9BF9QJopHVUj3YvyAaREngqubLovOjkPHWQYp52mCCjTK+lV8yzgYoHznACT03VS4bjuaM9IDE09AN2SLcVGySYy8ohTK5hqM3LvoYNkRiIaUl42jEaC5vPkGvqjBTIGFZML9QtUXUvICUXD2+SnJCklanmVUXGtK89Dq0jAt1bPsF6vPMT0l2+3dLXRYVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAJZ6o0SmHBuVu9VxagepmLKDH13IcQVpQ3Tveszl8E=;
 b=SuLMvkf1aZpYcNbVApom/KidibwrYFeL7aii+oL1UGIIano2iGfxm95OO0WGcXbuF3Ce9B59Sw0KKloayuLeVK7rLO97xYlcUyuZDANy97HxOvcaZ07r8JcS6PADs6PfM9CbXjDc6M97mIAK13BnI9TIUUO4H62PyfgLTxJbzsjBXUUXiOlUPXjFCNpALjVcfSQcaw/18Iu9XYdRxH+v843PJRYnW9cGXuObHWLIsGrTXI7TDXBsdZCMRwiq0qXN++pNtejrWVpjI2rGoNb7JYvqkZvZk+O2xj6NrXuJWh/+D4b/69rr4LcRt5i/d1QQRWObLZjZKNeVXY94v6Ja4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAJZ6o0SmHBuVu9VxagepmLKDH13IcQVpQ3Tveszl8E=;
 b=CL0mJ+rRC0wv4bR0P8vgqkuFUITntsmliW3jJR7qdLkKgXovgeu0Ix8dMsYA1SxRgAhjNsP1Ia3oD4fYQ8OvluW1xSG8LFTBVPtuIGTrUBk0jahWeaD9mFn214CTbEW7eX4ly4x6lQUCryvVszUCpVv/kweiqDJoZPIHItSsIGc=
Received: from MWHPR12CA0071.namprd12.prod.outlook.com (2603:10b6:300:103::33)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 03:06:23 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::f4) by MWHPR12CA0071.outlook.office365.com
 (2603:10b6:300:103::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Fri, 3 Dec 2021 03:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 03:06:23 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 21:06:20 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 11/17] drm/amd/pm: correct the usage for
 amdgpu_dpm_dispatch_task()
Date: Fri, 3 Dec 2021 11:05:34 +0800
Message-ID: <20211203030540.1710564-11-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14340925-8a7f-4266-3adf-08d9b609e355
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534A188A909BBDD315FD0ADE46A9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cH0sPPGMcvZSaptXK5Fj5VegQtX1CUxbpoS3CtCKf3PwZ/KEO1+2POh2mN7B5N7GJ0m4iNeJcCY8FR6ctGKLBvU/Nz2r0wfqVDgOnCQC2vc1vAKceEDK2xSRnMn5Ek8nBzXBTrTcv3P7gQRS1PuNuVEoR8Wnor7CDSdMlfcb6hadGrumv4FbbBYGl5HYYBnfC/7Q+V7/MWZttM+mmNW7nxOT3uuL5tkxxUW7KFAXAWRUDRBREcJsn4iDu4BD8x9Id4DDowPMM0E7+BjZAtzHGoXmsPIVZwuIttHufM1Nbzj7jG9Y3xkKSgUO4ePZFW/icqHWKKHnUOOTIpe4SKJQAW666P2g9yp4j45vs548jq6p5aoHAJ+/cqm2tid020ix4X4qyqVebqOOrBCnGKfT+B1FuxMD2qKzdwUdi2BYWyYzd5Cmw/rS94YSmviiNskcHV1XFIIWacbF4ajf5viD12KuMRKIckFvNwL7MpMlfNbSvlZBiWOH83XsiybZ2obrTICojM1QGyDLnxHaRzIchu+H0NxMAwTieNUb02jmlxMGZ2kO7AEXCYfJlfA8NXLAtysJ2k+NtcsTd6XwAS31krbVRflriiQmqYCTXU0AHZYAg4OgS6ZnDzBQQ2cGPrqq6xyd69ZnTjSKysX52ETJzqT951mEVN3y9W7CeNwwdfJUp+lPnmPF0A5lJmPCmK2ikKXlE1Vs1/oEiTREfV7L4TdbAobdXy/8RuWQ431sfgTHKbAjudi7M5XVHi0rZNJNEzP0tZZc1ZdeSnraTEpBs2Z0CcDawzTvfCd83PitpFU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(36756003)(2616005)(8676002)(82310400004)(316002)(44832011)(54906003)(6916009)(2906002)(47076005)(336012)(426003)(36860700001)(8936002)(5660300002)(40460700001)(6666004)(70586007)(86362001)(16526019)(83380400001)(26005)(7696005)(508600001)(4326008)(81166007)(356005)(1076003)(186003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:06:23.3047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14340925-8a7f-4266-3adf-08d9b609e355
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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

We should avoid having multi-function APIs. It should be up to the caller
to determine when or whether to call amdgpu_dpm_dispatch_task().

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I78ec4eb8ceb6e526a4734113d213d15a5fbaa8a4
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 18 ++----------------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 26 ++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6d9db2e2cbd3..32bf1247fb60 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -554,8 +554,6 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 				enum amd_pm_state_type state)
 {
 	adev->pm.dpm.user_state = state;
-
-	amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
 }
 
 enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
@@ -723,13 +721,7 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
 	if (!pp_funcs->set_sclk_od)
 		return -EOPNOTSUPP;
 
-	pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
-
-	amdgpu_dpm_dispatch_task(adev,
-				 AMD_PP_TASK_READJUST_POWER_STATE,
-				 NULL);
-
-	return 0;
+	return pp_funcs->set_sclk_od(adev->powerplay.pp_handle, value);
 }
 
 int amdgpu_dpm_get_mclk_od(struct amdgpu_device *adev)
@@ -749,13 +741,7 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
 	if (!pp_funcs->set_mclk_od)
 		return -EOPNOTSUPP;
 
-	pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
-
-	amdgpu_dpm_dispatch_task(adev,
-				 AMD_PP_TASK_READJUST_POWER_STATE,
-				 NULL);
-
-	return 0;
+	return pp_funcs->set_mclk_od(adev->powerplay.pp_handle, value);
 }
 
 int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index fa2f4e11e94e..89e1134d660f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -187,6 +187,10 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
 
 	amdgpu_dpm_set_power_state(adev, state);
 
+	amdgpu_dpm_dispatch_task(adev,
+				 AMD_PP_TASK_ENABLE_USER_STATE,
+				 &state);
+
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
@@ -1278,7 +1282,16 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
 		return ret;
 	}
 
-	amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
+	ret = amdgpu_dpm_set_sclk_od(adev, (uint32_t)value);
+	if (ret) {
+		pm_runtime_mark_last_busy(ddev->dev);
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	amdgpu_dpm_dispatch_task(adev,
+				 AMD_PP_TASK_READJUST_POWER_STATE,
+				 NULL);
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -1340,7 +1353,16 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
 		return ret;
 	}
 
-	amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
+	ret = amdgpu_dpm_set_mclk_od(adev, (uint32_t)value);
+	if (ret) {
+		pm_runtime_mark_last_busy(ddev->dev);
+		pm_runtime_put_autosuspend(ddev->dev);
+		return ret;
+	}
+
+	amdgpu_dpm_dispatch_task(adev,
+				 AMD_PP_TASK_READJUST_POWER_STATE,
+				 NULL);
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
-- 
2.29.0

