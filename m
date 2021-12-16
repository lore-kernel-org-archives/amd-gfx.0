Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A51C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 14:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC1410FDD0;
	Thu, 16 Dec 2021 14:14:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464C510FDD0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 14:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Opg6B5wrP1UfVAC/nda3IB41hxOG9CiokBaVTtI8UJpU9Fd0C8JrMORIMpw9bju6TYDGY+jFIFB/ihvtnmBZJWSOMf+ejaSVGt8EHGf2OfoI2s5+bKpsN03GUp5hkTNJTwd297/qsKpIQXN0YYct0wJ0ZXKHYJvCO72f7qT1JEnhc/af/pcfu1prCoL9LW0uROkPF1TuoxqvbcyMHtAIPycs7uloEoQdL1vvUkYu7r7ee4KEYaUAGnkii1Oc2HP3wegfZ1SPWtkvnYo/oUecT/QdRkL0jMpbRk/TQRU+vMYIOdcfdO6KPi8lkY3eYipz4m6yM0UWe57hi8XSOqMwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/rZosKDbBr8i+IBunILwXq2etNOSkTIrEqvc4aVm1A=;
 b=M2jHywxXnHT6LbFpYWXUeZa3yUmB0mqMEbTTxcStWsArF3/sdMO7NG6X39nrms4+nWAvSbV2OyHIvsY8Xd7c85kyLLK7k4uNOTQs0RSeBwLAugdjsL8ZgJCtU0ijPx2h59Mnlw0k4Ya5N58IjtH4bITUv6eFre/Wj1J0WpK43TlDltctn1IcRFxcJqbT/203O86d8EyS/F+jeFcmwjVyNxAFSYmvroIO/JNtfX1o9sq0N3RcpNa6t0P7sh1dwrTEHj/2CD0uLKFlKU8ntGisvmoZ9TT8jUZa6V9xUvcOJ9k6AABz7d8CbH+wcdSApirwOJZnr1ffbMFdzo7kzrcieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/rZosKDbBr8i+IBunILwXq2etNOSkTIrEqvc4aVm1A=;
 b=0nqOmZCzH3a0q5O1Yw/TBdR28WKyzVqpQk2Cu5K4zqJEJ6IUdb3Pod/3DMJQvihBylHwfKiA7u9DAYWHz2TP06H1otrH3aQYV+DqC9ec/tHRVOjtblaUvoqOef3bvF0FtR8uB9HwMjMPKEl4Px5NaaQs0kE0TV02F5KpUSxnugQ=
Received: from DM5PR13CA0070.namprd13.prod.outlook.com (2603:10b6:3:117::32)
 by BN7PR12MB2771.namprd12.prod.outlook.com (2603:10b6:408:29::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Thu, 16 Dec
 2021 14:14:32 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::2e) by DM5PR13CA0070.outlook.office365.com
 (2603:10b6:3:117::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.7 via Frontend
 Transport; Thu, 16 Dec 2021 14:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 14:14:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 08:14:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates
Date: Thu, 16 Dec 2021 09:14:17 -0500
Message-ID: <20211216141418.299554-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5ac8e6d-1138-4a7b-1c5c-08d9c09e61a6
X-MS-TrafficTypeDiagnostic: BN7PR12MB2771:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2771F6702EEFA5896DC664B7F7779@BN7PR12MB2771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JxxMW3Oqqk+nGrql5NGb0SNEET5hvq0a/+ntZGVi5VPKOHVq/2Z4xOa9bHcw1zrmiIzXwwD7O8jPC2paalEuQWkCSa/DAccBQgSH4aiN8SfxMDA9YQhhwcfycm60/o7K9LQnq94aRCOTNcEJrbCR920/i+7tPuRUlyt+K/1+PHFF8miyf3H2vZdDdwP/i7ZFm0DXpuK/U6V+WkFqmWtbDRs4zMzUH20aHKiFrASULwI9LKT9OaQ3plyw1/XVWrnCovfF7cY2vd8wJa0K8ZSOo8IBvxvflNWiU77pUbh4VIpb6jJ/XiyD+UCmVgM/lGT0KvZqpH5kMxZCM2FYHze4IBhV4nDMSrYW0K2Coqw7pOQEKAclaB0Y8ebAcLqofr6igRaECLBqMQ75uWnVXum4fmwQx7fcxqBPydwBIsGiVWc/5uUEwlogEU1gzkEu+IBKCliwmuXDWHXpJSRnRu0yCwjLS0BXt8eHdi/M1d+zsRGAR5iALt/9Gx59XJROdK7T37S8iM1mIYaP2xoeIxZ6GgRzfr6j9d6jjJ083LnqzRUVo2CEc/Lp+aX4hjJ5sPNpVXAgDdnPTH2jak5XXBFYxKZk7WDyVAEahJNA6VCNQzDtBXpmq6qtLLZSHjvQhPEs/I2ZURl9zFfeQZ2WXaTfNaQpacHmbS30A/EhwfcdiaI5pE2Dp67P42K30NNPHvP0kUNR/zeREn5O52vZPAILTm3XMX7EeLD4yDDfPMMsWAEEDf33XH7/+sXt+C+AsymjUlqCyM1wUVFA9C+AGIIREhU/2RQKv6nJICYOg/yEFs0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(966005)(83380400001)(6666004)(47076005)(86362001)(26005)(8676002)(186003)(426003)(70206006)(70586007)(16526019)(1076003)(2616005)(30864003)(36756003)(336012)(36860700001)(508600001)(4326008)(356005)(82310400004)(40460700001)(8936002)(7696005)(316002)(81166007)(5660300002)(2906002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 14:14:32.4404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ac8e6d-1138-4a7b-1c5c-08d9c09e61a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2771
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a new CTX ioctl operation to set stable pstates for profiling.
When creating traces for tools like RGP or using SPM or doing
performance profiling, it's required to enable a special
stable profiling power state on the GPU.  These profiling
states set fixed clocks and disable certain other power
features like powergating which may impact the results.

Historically, these profiling pstates were enabled via sysfs,
but this adds an interface to enable it via the CTX ioctl
from the application.  Since the power state is global
only one application can set it at a time, so if multiple
applications try and use it only the first will get it,
the ioctl will return -EBUSY for others.  The sysfs interface
will override whatever has been set by this interface.

Mesa MR: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/207

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 145 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c         |   7 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |   3 +
 include/uapi/drm/amdgpu_drm.h              |  17 ++-
 6 files changed, 171 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 468003583b2a..327cf308c2ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -237,6 +237,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
 	ctx->init_priority = priority;
 	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
+	ctx->stable_pstate = AMDGPU_CTX_STABLE_PSTATE_NONE;
 
 	return 0;
 }
@@ -255,6 +256,102 @@ static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
 	kfree(entity);
 }
 
+static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
+					u32 *stable_pstate)
+{
+	struct amdgpu_device *adev = ctx->adev;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum amd_dpm_forced_level current_level;
+
+	if (!ctx)
+		return -EINVAL;
+
+	if (pp_funcs->get_performance_level)
+		current_level = amdgpu_dpm_get_performance_level(adev);
+	else
+		current_level = adev->pm.dpm.forced_level;
+
+	switch (current_level) {
+	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
+		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_STANDARD;
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
+		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK;
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
+		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK;
+		break;
+	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
+		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_PEAK;
+		break;
+	default:
+		*stable_pstate = AMDGPU_CTX_STABLE_PSTATE_NONE;
+		break;
+	}
+	return 0;
+}
+
+static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
+					u32 stable_pstate)
+{
+	struct amdgpu_device *adev = ctx->adev;
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	enum amd_dpm_forced_level level, current_level;
+	int r = 0;
+
+	if (!ctx)
+		return -EINVAL;
+
+	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
+	if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx != ctx) {
+		r = -EBUSY;
+		goto done;
+	}
+
+	switch (stable_pstate) {
+	case AMDGPU_CTX_STABLE_PSTATE_NONE:
+		level = AMD_DPM_FORCED_LEVEL_AUTO;
+		break;
+	case AMDGPU_CTX_STABLE_PSTATE_STANDARD:
+		level = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
+		break;
+	case AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK:
+		level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
+		break;
+	case AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK:
+		level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
+		break;
+	case AMDGPU_CTX_STABLE_PSTATE_PEAK:
+		level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
+		break;
+	default:
+		r = -EINVAL;
+		goto done;
+	}
+
+	if (pp_funcs->get_performance_level)
+		current_level = amdgpu_dpm_get_performance_level(adev);
+	else
+		current_level = adev->pm.dpm.forced_level;
+
+	if ((current_level != level) && pp_funcs->force_performance_level) {
+		mutex_lock(&adev->pm.mutex);
+		r = amdgpu_dpm_force_performance_level(adev, level);
+		if (!r)
+			adev->pm.dpm.forced_level = level;
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	if (level == AMD_DPM_FORCED_LEVEL_AUTO)
+		adev->pm.stable_pstate_ctx = NULL;
+	else
+		adev->pm.stable_pstate_ctx = ctx;
+done:
+	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
+
+	return r;
+}
+
 static void amdgpu_ctx_fini(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
@@ -270,7 +367,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
 			ctx->entities[i][j] = NULL;
 		}
 	}
-
+	amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
 	mutex_destroy(&ctx->lock);
 	kfree(ctx);
 }
@@ -467,11 +564,41 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	return 0;
 }
 
+
+
+static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
+				    struct amdgpu_fpriv *fpriv, uint32_t id,
+				    bool set, u32 *stable_pstate)
+{
+	struct amdgpu_ctx *ctx;
+	struct amdgpu_ctx_mgr *mgr;
+	int r;
+
+	if (!fpriv)
+		return -EINVAL;
+
+	mgr = &fpriv->ctx_mgr;
+	mutex_lock(&mgr->lock);
+	ctx = idr_find(&mgr->ctx_handles, id);
+	if (!ctx) {
+		mutex_unlock(&mgr->lock);
+		return -EINVAL;
+	}
+
+	if (set)
+		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
+	else
+		r = amdgpu_ctx_get_stable_pstate(ctx, stable_pstate);
+
+	mutex_unlock(&mgr->lock);
+	return r;
+}
+
 int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *filp)
 {
 	int r;
-	uint32_t id;
+	uint32_t id, stable_pstate;
 	int32_t priority;
 
 	union drm_amdgpu_ctx *args = data;
@@ -500,6 +627,20 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 	case AMDGPU_CTX_OP_QUERY_STATE2:
 		r = amdgpu_ctx_query2(adev, fpriv, id, &args->out);
 		break;
+	case AMDGPU_CTX_OP_GET_STABLE_PSTATE:
+		if (args->in.flags)
+			return -EINVAL;
+		r = amdgpu_ctx_stable_pstate(adev, fpriv, id, false, &stable_pstate);
+		args->out.pstate.flags = stable_pstate;
+		break;
+	case AMDGPU_CTX_OP_SET_STABLE_PSTATE:
+		if (args->in.flags & ~AMDGPU_CTX_STABLE_PSTATE_FLAGS_MASK)
+			return -EINVAL;
+		stable_pstate = args->in.flags & AMDGPU_CTX_STABLE_PSTATE_FLAGS_MASK;
+		if (stable_pstate > AMDGPU_CTX_STABLE_PSTATE_PEAK)
+			return -EINVAL;
+		r = amdgpu_ctx_stable_pstate(adev, fpriv, id, true, &stable_pstate);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index a44b8b8ed39c..142f2f87d44c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -53,6 +53,7 @@ struct amdgpu_ctx {
 	atomic_t			guilty;
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
+	uint32_t			stable_pstate;
 };
 
 struct amdgpu_ctx_mgr {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a24b4c374188..e0fc943e9f9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3486,6 +3486,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	init_rwsem(&adev->reset_sem);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
+	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 
 	r = amdgpu_device_init_apu_flags(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 082539c70fd4..bcbc3190ed47 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -390,12 +390,14 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return -EINVAL;
 	}
 
+	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
 	if (pp_funcs->force_performance_level) {
 		mutex_lock(&adev->pm.mutex);
 		if (adev->pm.dpm.thermal_active) {
 			mutex_unlock(&adev->pm.mutex);
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
+			mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 			return -EINVAL;
 		}
 		ret = amdgpu_dpm_force_performance_level(adev, level);
@@ -403,6 +405,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 			mutex_unlock(&adev->pm.mutex);
 			pm_runtime_mark_last_busy(ddev->dev);
 			pm_runtime_put_autosuspend(ddev->dev);
+			mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 			return -EINVAL;
 		} else {
 			adev->pm.dpm.forced_level = level;
@@ -412,6 +415,10 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
 
+	/* override whatever a user ctx may have set */
+	adev->pm.stable_pstate_ctx = NULL;
+	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
+
 	return count;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index c464a045000d..629cb1ec6c03 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -468,6 +468,9 @@ struct amdgpu_pm {
 	 * 0 = disabled (default), otherwise enable corresponding debug mode
 	 */
 	uint32_t		smu_debug_mask;
+
+	struct mutex            stable_pstate_ctx_lock;
+	struct amdgpu_ctx       *stable_pstate_ctx;
 };
 
 #define R600_SSTU_DFLT                               0
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0b94ec7b73e7..7f01f9830bf8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -206,6 +206,8 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_OP_FREE_CTX	2
 #define AMDGPU_CTX_OP_QUERY_STATE	3
 #define AMDGPU_CTX_OP_QUERY_STATE2	4
+#define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
+#define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
 
 /* GPU reset status */
 #define AMDGPU_CTX_NO_RESET		0
@@ -238,10 +240,18 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_PRIORITY_HIGH        512
 #define AMDGPU_CTX_PRIORITY_VERY_HIGH   1023
 
+/* select a stable profiling pstate for perfmon tools */
+#define AMDGPU_CTX_STABLE_PSTATE_FLAGS_MASK  0xf
+#define AMDGPU_CTX_STABLE_PSTATE_NONE  0
+#define AMDGPU_CTX_STABLE_PSTATE_STANDARD  1
+#define AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK  2
+#define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
+#define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
+
 struct drm_amdgpu_ctx_in {
 	/** AMDGPU_CTX_OP_* */
 	__u32	op;
-	/** For future use, no flags defined so far */
+	/** Flags */
 	__u32	flags;
 	__u32	ctx_id;
 	/** AMDGPU_CTX_PRIORITY_* */
@@ -262,6 +272,11 @@ union drm_amdgpu_ctx_out {
 			/** Reset status since the last call of the ioctl. */
 			__u32	reset_status;
 		} state;
+
+		struct {
+			__u32	flags;
+			__u32	_pad;
+		} pstate;
 };
 
 union drm_amdgpu_ctx {
-- 
2.33.1

