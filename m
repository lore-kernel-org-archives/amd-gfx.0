Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEB9C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 03:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B236E947;
	Thu,  2 Dec 2021 03:10:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF4B36E95A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Dec 2021 03:10:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD37axys8AJ/i9lSIgdXElFGPsNaGTGOojnIrsYslHieP77Hue0cvFmIlikpXBEVjYX3pvXQLrgNEnjcJ6FhCamcjJXzR6OolYHz0PU1Esloyqpn9kYAg5jqbjVF038ZpvcyI1BV2EuLARtdRYeCn5F9VPnE4nPfsky3oBCbIC5bMRvieRzsKpxT6BJ0BG+850zf03qvgzJrfNNsMzAW00yLQPOS2Tzz9dnRL57GDkH0ZgIvIZjQ0QHRyiFkILv57P77k4PSfFX778FysZZBYJ+rjFhnFdirA+zarPO2JYw9knkCJ3bDhEGetuWxOiXAm4mO5YBkCrRR7xtKljy/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj7x69+r5nWRl89imGLMJ57BVXCyQcOq3vSiTZlkmS4=;
 b=ijVxIDHSXsOpt2vHfQGqbHk1CXrsl0EyVVNE/zrHp5kQm5Q056hCRrPfc7Te3l5ypGV5Ue7sGRVotMTN4DtPFP0ZdlY0rw3rMcwmGy3phxuMkKhyi+MDmRCvY5VcSS/qUUN+2gi19eDocYBhUltXxr+a3bwHcCZkIDy7LRqz4+/E9IWTy1J4HSj/hNTV8jwtkqTwvgy5ltfjMtRKo9Cc25HRqQd7k7QjxWUNtpKJfVBM+bcNkyVpl5yfswd0Y1lEfMWCBrDpal9HOqv0Qfvmh/cYNVD+/tSpPuiEsE6CPR2YWE3sz4bdots5/c0WylrznAFbe9vcjSfL+F9ux2JAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj7x69+r5nWRl89imGLMJ57BVXCyQcOq3vSiTZlkmS4=;
 b=iaEkegF/l3FPRVzQN7pUQnEjsST3uMyQaCM9r9TJ+9EU/ps/CBhOQRaffCgt9loYDr5sVU+6lNSHKzMsL6au4uv/yhzGmVHKgyt0rdWuZlMvnF9+vjY6YNs5JHhdII4qC4Dqkci+6wdL6LCzyuIL3MqXOH+JA5XI4dBdGJRJYM8=
Received: from DM5PR08CA0038.namprd08.prod.outlook.com (2603:10b6:4:60::27) by
 BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 03:10:29 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::43) by DM5PR08CA0038.outlook.office365.com
 (2603:10b6:4:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Thu, 2 Dec 2021 03:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 03:10:28 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 1 Dec
 2021 21:10:22 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 11/17] drm/amd/pm: correct the usage for
 amdgpu_dpm_dispatch_task()
Date: Thu, 2 Dec 2021 11:09:24 +0800
Message-ID: <20211202030930.1681278-12-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5bbb6bff-0bca-4637-04a7-08d9b5414b36
X-MS-TrafficTypeDiagnostic: BYAPR12MB3240:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3240393632263F254C00C341E4699@BYAPR12MB3240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cWUqBzNANikGPsqZ7lI/wIfbCSxsYcyZnjWPM5HNumHAjSaH9hnftJnkeKRZ/WfcGQWfd9PnUx2gU1zY29CNpn5ZR8qHwFJF9CXlQhO+b2e7JxzPpNemGaUXxLpe/IQ2DDv7SSEZeqPoJfdm2EKrzeRuYUmm2MD0Nz61zT5BYKZYJpRpVH9B0M5yfMRF93u8HaE4OZpA5LD2f4HCEPCujpCLrpuJWXuZ9qwjFJIJpnXltTlUn5qEDtiuqN6/TTmhHmoeoALcVpjmUwnlHSJtEAUr70Jn1LG0uMovntIjj8Lx3jtIKjgkuHe12PvpXkxDDbJ810zmyhY6pIPyKaf9auivrkKJTtxJwi60f0TiVSvLdpmTdUrBb8H1CjzJaQQQRkbnEAtgodzVGPhXqY38039QURixWavNAlBjwYJscf4LXHdaxqDNCYCXmN2kn+DV0zNEPoSXy7zwFp9CByLc4VOnNajHEx1z79uFUN02H6shCd91vwi6kQgkE0niZuXDH8xapNbNzzR7apM/duYbxidDPFwN87vVb2kwsbG7CPo0iTDmKkoniIknaUCuo6brfEa6OICM8MdTPPlG2iP5lQDGZLcUYYok5OpNMjVZqwDYUN2Kz2WLgC8Tb3WSsLJrEoqdZ0pypC2EE1Sr5eI4ujHxe3gEbIZDx8dIb7YjhpRQLlQS8EAMn2CXljrASOP7whg+6Rp5wwDWuU6leFrfuh/YUK9aiziBOz/YrDDbo4XCQsQS6Ij/2tBzEhRIfKcWrOcTpozVU7BNUEhTOlJFPXgYgn8EMqvuT4Na/MPJVi4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(36756003)(2616005)(8676002)(86362001)(336012)(26005)(47076005)(16526019)(1076003)(7696005)(2906002)(8936002)(70586007)(5660300002)(426003)(82310400004)(4326008)(70206006)(54906003)(44832011)(316002)(83380400001)(356005)(186003)(81166007)(40460700001)(6916009)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 03:10:28.8080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbb6bff-0bca-4637-04a7-08d9b5414b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3240
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
index 16371879cfc1..45bc2486b1b4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -551,8 +551,6 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 				enum amd_pm_state_type state)
 {
 	adev->pm.dpm.user_state = state;
-
-	amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
 }
 
 enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
@@ -720,13 +718,7 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
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
@@ -746,13 +738,7 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
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

