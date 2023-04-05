Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C70C7619A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Apr 2023 15:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 647D310E9EA;
	Wed,  5 Apr 2023 15:24:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB02810E9E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Apr 2023 15:24:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfA3zEEvkTl+NUgfwYi24h7aVs35z9w7aBeDqzNaccIqm9R4NnZTaMpE7q6WNOX+63endQVZL/16osmM7bTs90xYhiP7Vnyt1Owa9x/2hbEx5SMGDzAUYm9XWmtezXWwGXJyroGl7t4A26PG5k58XGqfRJUFs0UtaEK03c89118yrOIcjQR/walW67PD7VdAjPfxtMNv9m/WQE16yjrc/FzynlK4s24D58mIN2LHVqwAbhKZhbZ0ttZvZ/dVdnMdha1mbM3WoDtT1EmiagErVG8s7Q9zTD2mKMwwmx7j9rzi07dSco3wrgy7VM228OW9Uu9X1wtqGmOX+S3SoMhAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ybq3wjmg/BgOek3jpaVstYGk8qFyjEfig7ExdBHZjE=;
 b=KE++cU3xEU0UFH9IVuU9ik0VLQaZUCsMzA9/Q+Tcek1JU4Frs20bZSXEdXzXm2cNQTxrBUX7RapgHT58igPRyFa1nQy2WNKedPW8u27d2jwAuNDgcupG1PlcYjl6shq/qQwr60CjrsuU1CM6CE7JfAYNOEAAzTRKtszFCPbZFPXZzDeb8L1P+Lrj8Ncqi714MfHILQTpQltC8gTm+nnn6AC6nsQR6uHohvpCiwJCfQ+xJrqG9zgp3cMgViKbxhaycwXi3n8Y5CKoDQ5Ukc/Mo0t+3RcWOI0Qj1xsBLJsuBXfXz48sWYgurF2bwP3ZMURHQymjovlTex9+d/SSPYPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ybq3wjmg/BgOek3jpaVstYGk8qFyjEfig7ExdBHZjE=;
 b=GqF/EGhiT312Q1ohwZ03TCL0er3+j4QSHNL55mBxxgprykcvr9tFTG5sywAdCAiWlpjE3E4itslUoYbpc8SiAV3Cs+8VLup7J+2rrxTaOSNJGOgSZyhLPxrmFYph+YpAGwquNzRdNuBUbKTFSzPrqycK6Iu1+x+OQ9D4n+r/ye0=
Received: from DM6PR07CA0040.namprd07.prod.outlook.com (2603:10b6:5:74::17) by
 MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.29; Wed, 5 Apr 2023 15:24:51 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::ee) by DM6PR07CA0040.outlook.office365.com
 (2603:10b6:5:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37 via Frontend
 Transport; Wed, 5 Apr 2023 15:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.16 via Frontend Transport; Wed, 5 Apr 2023 15:24:51 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 5 Apr
 2023 10:24:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH v3] drm/amd/amdgpu: Drop the hang limit parameter
Date: Wed, 5 Apr 2023 20:53:52 +0530
Message-ID: <20230405152352.457978-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|MW4PR12MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: bca27d98-982a-4b24-52bf-08db35e9e662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrNxGmf7Ynd8aZapFSUS0O/Bsn8Gk5WehJ2iDjGivMKTSXf4Bk/rWzxm/4aTt2P3aN45zOsX9wKzemDEjIqgR/0WzltnztOCpGt+m6SCjsftSDTpAsG1D9X11WWCk5nhD2o5r9XVRo4Y998xi3WzEiBfcsLWrHHsWU0vQKdkutHW8ErTKw2YEOkq7klawym0m1QKIf7+gP7qReaUs0Cl6q4KjQQ2sGUeDK+pvacvYEg1I2wNU/uoW+W7E3CI1DIQcRoqO+0TtTaTTL5s5HH3sO6V4NRxixOXHE14vpD0b3y6zkzsfG/GCOxVZCRlkarAOjPWugg6wnZSzYlnLNS8HDjp+7Ee9itPqa8OLzAimfNIjBqgdzAeaYShxVl7lHQggLFs43C1PGysPjRkFHBY7SLj5KMRTfy2kuu+f4zReAuTE2Pi/dqKCVYvv8Sn924A+7Pi1CpzAysY6LBLUm/7AO1LyALB60tc4vyncEYccTmdtn44hpnD+tv79+kIn+51c7MoCMvfqj1EpciYLdZpNdeOQdELDdQY3WKR8kcV2WjOfFywfJ3Sbm7IeowGp+EzBMuFLUgi8z6aGTXzfUp1qYUE5GYZ/maH6lBPxlOR/SL1CIK3uzFwQxSHLGD+ZeyqpjKmnYCxSTL82S5M485tJhKEZwsfUtJnfrwDq/FBUlyd8MN0FJAfi0b/Kw9NBWp7o7mYRkPGtQyaT+olDnmiHZg1xD8Mz7wBknzbHNP4d6s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(426003)(8936002)(40480700001)(66574015)(40460700003)(2616005)(81166007)(41300700001)(4326008)(36860700001)(70586007)(316002)(8676002)(110136005)(82740400003)(356005)(54906003)(5660300002)(6636002)(70206006)(47076005)(16526019)(336012)(7696005)(44832011)(26005)(83380400001)(6666004)(478600001)(1076003)(186003)(86362001)(36756003)(2906002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 15:24:51.1131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca27d98-982a-4b24-52bf-08db35e9e662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The driver doesn't resubmit jobs on hangs any more, hence drop
the hang limit parameter - amdgpu_job_hang_limit, wherever it is used.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 --------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index bbac4239ceb3..35a0474ccdb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -186,7 +186,6 @@ extern char *amdgpu_disable_cu;
 extern char *amdgpu_virtual_display;
 extern uint amdgpu_pp_feature_mask;
 extern uint amdgpu_force_long_training;
-extern int amdgpu_job_hang_limit;
 extern int amdgpu_lbpw;
 extern int amdgpu_compute_multipipe;
 extern int amdgpu_gpu_recovery;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3b6b85d9e0be..051b9e231cf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2364,7 +2364,7 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 		}
 
 		r = drm_sched_init(&ring->sched, &amdgpu_sched_ops,
-				   ring->num_hw_submission, amdgpu_job_hang_limit,
+				   ring->num_hw_submission, 0,
 				   timeout, adev->reset_domain->wq,
 				   ring->sched_score, ring->name,
 				   adev->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e652ffb2c68e..03e928123d71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -158,7 +158,6 @@ char *amdgpu_virtual_display;
  */
 uint amdgpu_pp_feature_mask = 0xfff7bfff;
 uint amdgpu_force_long_training;
-int amdgpu_job_hang_limit;
 int amdgpu_lbpw = -1;
 int amdgpu_compute_multipipe = -1;
 int amdgpu_gpu_recovery = -1; /* auto */
@@ -521,13 +520,6 @@ MODULE_PARM_DESC(virtual_display,
 		 "Enable virtual display feature (the virtual_display will be set like xxxx:xx:xx.x,x;xxxx:xx:xx.x,x)");
 module_param_named(virtual_display, amdgpu_virtual_display, charp, 0444);
 
-/**
- * DOC: job_hang_limit (int)
- * Set how much time allow a job hang and not drop it. The default is 0.
- */
-MODULE_PARM_DESC(job_hang_limit, "how much time allow a job hang and not drop it (default 0)");
-module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
-
 /**
  * DOC: lbpw (int)
  * Override Load Balancing Per Watt (LBPW) support (1 = enable, 0 = disable). The default is -1 (auto, enabled).
-- 
2.25.1

