Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE63C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CE1C6F3AA;
	Tue, 30 Nov 2021 07:43:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388716F3AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgKsRCZpg8VCqFr2aEwzJcrvK55EGpOJ0Fzv34cPkDwt7feWj76q+qdl0k2+x5sUoSsYFwdKf+s+7G3YXr3jcSeLOQLyK9LWMV1EtJgPDo0LewCLkf5P0eF8L7eijrP4utMbg0yc5/bUDZr6B27Su5VA1P49QNSeu3fu630j+7m2J/OwqJyb9PUM1gzDLWGWGy2rysw3/WpYmGtUEaZIe1f02o8T8Rt3+YZyQNw7pO717MTnxOmQZWpMJ6CWUI+CdM2rEW6WFfyYYTtE1VkYshLpiafQYruzdXvA+5+Pug24rO4s0aaVjety14Uqi/eddXhIMRjreXZmwGvgqnTfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DKcw/oKW3z/eM5T/q0PJI9H0iFU2xZYLslUGdAS7hw=;
 b=ZQlTksEBDQe9TljYx/nMxpqdVz3yZGvpOiNCSEiSkoGLwnJ0SqLE8R+/EEoqzOWPgFrRuVT+y9T5LEt6ze1PqfO2XVT63Dn7DrB/B5M4BZtbrC9yCq9DEFvgrxL6mfH+mBJSzqBVEfZZjeLo+eQHwa6LGHp5TYQerc1Kw9YvLO697QohQ9MJ5/fjL4EV3f6ccm/mH+QxTrkTtVjTWQlo7sLT/eaKi6+IVjs2QZjfctzm0XTEeBJYTYjngx5YKWme9sVyV9L41ROU66sKfAVzNJ0qFFNeDS3z72FlMa55Uz0dmqfQWQalmIbQMto246Zi+rrG3sCEYYy/9T93gUievg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DKcw/oKW3z/eM5T/q0PJI9H0iFU2xZYLslUGdAS7hw=;
 b=AmE1+ryrfRw0iFr761zS2n/45ItXGKTGPIkmvm2n09xlHtWaPXfZs1VNI40g5/mP6V1FPcSAZE4e2GZR1GIvdhGmhpKJ72BWkNMxeG58T0gQc8Gl5FPwcK96onTv++THNHzjIm9yR0iXa2p1+qymIf+VaM9LHSYNWRHxpwZhyZA=
Received: from BN6PR1701CA0010.namprd17.prod.outlook.com
 (2603:10b6:405:15::20) by SJ0PR12MB5455.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 30 Nov
 2021 07:43:46 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::61) by BN6PR1701CA0010.outlook.office365.com
 (2603:10b6:405:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:46 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:44 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 11/17] drm/amd/pm: correct the usage for
 amdgpu_dpm_dispatch_task()
Date: Tue, 30 Nov 2021 15:42:53 +0800
Message-ID: <20211130074259.1271965-12-evan.quan@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 528cf0c3-5ad4-4d98-2eb8-08d9b3d52418
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5455:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5455FBAE4B2A5D41BDB03798E4679@SJ0PR12MB5455.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fyA+JDcuxS7GGMBJXOVHHR5msfooLE/KHJgUu5TQYN/M06wqq1Cx0An+jAZ/9fl+vTggSyB2rrdqvOeDP+p3bRJ2E5WNK6M6JQOMeVVr7b7zpMnH14Upj+WNTi2HdL19JZQ7E0Fz3Z//we7xoo+e/iQNSYodsR4pXd1/9bKqkedqAl7B8hReGJho53Nyh+rMS3xaj6Wpm9UVMjDLEGkBt/3XPA80Z8vd2xeotNcoIDDTLDmhRJs5Nx7kn4LwtrgQzx/3zrI9ReAArjKlWI4rJybzs98RvSRiYqIrRWZQ8Oz/9xJ/EoQRADC3I3/Y+5XJ4zXKtXtmMK58zk+/1/MhLQkGUUz5hUONz2j2uWpD5fvcCpVp/6+e69qYePOIT5RhejUNIAIvTxYPWmDKGfaVU5iVUPcIMzDugBG6bh8G/RfnhmEM0A/gKHtwx+dZ88E4HEW6hpzvjg3eP94IPHetm+tGRvLFuEHKWAMdQ86kTdEBuN9fLZ3QUW4hmHmfAtSMH8Fm4ANZVkPLVGNiELOVxVGZFL/ooEDV4AyA25mQ8RWW99dTn6BRlHkxsz1jkciXHHw1F5w5dWfDHGwTgHdDPql+mbX1b4rYMUHYe/u/O2Wv3e8Z+KjCG0nZJR+xTfj18rPHFWLsFOVwhGCrzxZE958+OQmjpH3etPzSAiOc7uW1tjj99sv7/2jVZJV7cPMsOMO+XiwG7iJENrS1KgUE5LzOVQ4mV3ICksd8WKhunPwkiSqioLvKWht+qtsJfPPpkpwLcoaNqVZJyD30Vr7Cm8Jc3fZuLMVLiHpNqBiZvPw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(44832011)(2616005)(316002)(86362001)(16526019)(8676002)(1076003)(336012)(2906002)(54906003)(36860700001)(70586007)(8936002)(70206006)(4326008)(186003)(7696005)(82310400004)(47076005)(26005)(426003)(36756003)(356005)(5660300002)(83380400001)(508600001)(6666004)(6916009)(81166007)(40460700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:46.4152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528cf0c3-5ad4-4d98-2eb8-08d9b3d52418
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
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

We should avoid having multi-function APIs. It should be up to the caller
to determine when or whether to call amdgpu_dpm_dispatch_task().

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I78ec4eb8ceb6e526a4734113d213d15a5fbaa8a4
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 18 ++----------------
 drivers/gpu/drm/amd/pm/amdgpu_pm.c  | 26 ++++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c6299e406848..8f0ae58f4292 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -558,8 +558,6 @@ void amdgpu_dpm_set_power_state(struct amdgpu_device *adev,
 				enum amd_pm_state_type state)
 {
 	adev->pm.dpm.user_state = state;
-
-	amdgpu_dpm_dispatch_task(adev, AMD_PP_TASK_ENABLE_USER_STATE, &state);
 }
 
 enum amd_dpm_forced_level amdgpu_dpm_get_performance_level(struct amdgpu_device *adev)
@@ -727,13 +725,7 @@ int amdgpu_dpm_set_sclk_od(struct amdgpu_device *adev, uint32_t value)
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
@@ -753,13 +745,7 @@ int amdgpu_dpm_set_mclk_od(struct amdgpu_device *adev, uint32_t value)
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

