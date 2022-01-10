Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EC9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 20:20:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2FA510E6D1;
	Mon, 10 Jan 2022 20:20:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63F810E6D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 20:20:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw170b30tZFXi7gohCVW1BUgIw4dN4DNiXtAVt6ILOJgZoHhLL+JU5i/s4Uwna9/L9j7wg4L3uazigcWRzJ8kaJ+ViPL1EkZe43E7Xfw34aU2lnEId8LM+CdYqAUvHfr8FRkkcMlEKojCgFi+vjCXaFccNFFoQ6mB3k+mg7bUFB9mAbq4bEq5hWfRGWjNK2AhbPF2u7KfV85XFUICsBrrcXZotnKWE0RhkMjsq3pLDw5Ta2DwHHIeiIMQ6f3/eqVqedQC3WOSTUfyPBhNOgbnKQbNqyelWwaDz98R+OoM4jJ/7DcPtpBtBVUkLcC1199+wl5aAcLGYZdIpr6YgBeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8/bvyKKi60pG4kiv6S4Sk5u2w5jRXLchnuk0laU5PI=;
 b=Z8gxoRkHFj8LoTcboI0EygKjS+XKC9kvy375voMTGAAs8vSqQLtlldfCih3ufWQfWczUIND/ElbYH8RLIjYEoBS1eB7GcYSiaEhtWBfuAjtARctYTD8o0VxGXXiMezu41w/tQQAqQKIs7dwsw0qOgmtG3ihjHV9/D338bWxlw7Oib4ICmAsG76fNbvRnS9hjhjb+Dj8bgwoMkLa/TZgiGc2uOQmq88f79srfhfv+BUycAcpbn2fRaGMnlmPrvTUHDKCqZG0QhdldXNTXwSR3RwH2PcqWwHQmD2bL9VHtPdg8YFHoXBFTwoDC4FCQRBn9AtjiqTGoR21qGLR4Efi4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8/bvyKKi60pG4kiv6S4Sk5u2w5jRXLchnuk0laU5PI=;
 b=QRTf4JgkR31RFldDzhsyaONlV7NOTMM1vXXcef5ne4Rkz0parsWxAxPCz4Dl+FNYryh0UR+H5KBqU2M43jHHKT9z18zKYnnWOU9aQfMQecpIo3IVKldqkRjSouPuFPmlnS+Z8IpXAiUtpD13apR6zS7bGGXJwMPrhABcsVDdRQg=
Received: from CO2PR04CA0172.namprd04.prod.outlook.com (2603:10b6:104:4::26)
 by CY4PR12MB1765.namprd12.prod.outlook.com (2603:10b6:903:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 20:20:40 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::c1) by CO2PR04CA0172.outlook.office365.com
 (2603:10b6:104:4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Mon, 10 Jan 2022 20:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Mon, 10 Jan 2022 20:20:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 10 Jan
 2022 14:20:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates
Date: Mon, 10 Jan 2022 15:20:26 -0500
Message-ID: <20220110202027.1949684-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110202027.1949684-1-alexander.deucher@amd.com>
References: <20220110202027.1949684-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 516e65eb-9fd9-43ec-0bea-08d9d476ac06
X-MS-TrafficTypeDiagnostic: CY4PR12MB1765:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB176574B207AFC75EABD3BDE7F7509@CY4PR12MB1765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r06Cm6me2s2FRrx6bcbhKqDaLFGUmHQloeCkGINQfFxuXW/+LO2zhpkGTeN8EgPyJUOcVu3bkgbnMRWJscpspsUxEbP3+yl8ngZ46aeHnWncFJbZfiuE8bB2kK2Q1TXPrK1dGV5k+FVk2JjwS6zZ3ZQU1rJ0TbEDAyF0gA/g0DxfA9QkXa9SNtYk3Aa3d4G2NrTld3486o7Ksur5cCNqXXIPvRITBzfFMl/Sv94lvZlF+8pIh7EybLNTg8MOszjwoMVIaUb21FEpNnRvzlLGV6uzjicAieBO6qAiEXNXJ//pzBMADqP1EEqwYQpBkr7cFoU9ufpamHsWfhCXUiLJehdhHZJ/NZoGsbiUhXQr6Yt5G9y8ZLcTZXXcNeHxJa6XsgYLbQNawPETk6NRQQSVdTHcNgijDVn5MWfrDLTlI8tAEgcK9SFIQfi/PNmIS7D/IW/oJiX8W0GZwY/VxBjD9MuziwvNXU0kKsvwDM9pTFvoMZGun0UOsKDpNelxa2i7X3bCgY6vJ/vVEh6s1o0FuNYUHIRs05CAuzjeI5VzMEGFpnXFhoGS27E9FIwKDo1b4rqg08rrJkvFQec7Y3qsdqY5b3GT+vKBJWp3ny0oJWz2rEX2LMHYVfhM8bu5ge3p3DdQpPm/OJY7SLjOSn8GgjOaq9weQHYaiY6OzPEMbkE+gMDya9nMCJORw2P3WVWjTMmrO0hAVWOpU/w0Aw9h2ga7+KZICKSuviizM94jOPil+APzB0vGdOT2s/9OGMBw5L80+IJtT+skKt5bWRSOSJq8MPv2xjy/jfs8rs2p+LQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(1076003)(8936002)(26005)(4326008)(36756003)(70586007)(356005)(70206006)(83380400001)(6666004)(6916009)(86362001)(336012)(7696005)(81166007)(508600001)(5660300002)(47076005)(82310400004)(40460700001)(426003)(966005)(36860700001)(16526019)(2616005)(186003)(8676002)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 20:20:40.5380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516e65eb-9fd9-43ec-0bea-08d9d476ac06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1765
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

v2: don't default r = 0;
v3: rebase on Evan's PM cleanup

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 129 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c         |   5 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |   3 +
 include/uapi/drm/amdgpu_drm.h              |  17 ++-
 6 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 468003583b2a..2c929fa40379 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -237,6 +237,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
 	ctx->init_priority = priority;
 	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
+	ctx->stable_pstate = AMDGPU_CTX_STABLE_PSTATE_NONE;
 
 	return 0;
 }
@@ -255,6 +256,86 @@ static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
 	kfree(entity);
 }
 
+static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
+					u32 *stable_pstate)
+{
+	struct amdgpu_device *adev = ctx->adev;
+	enum amd_dpm_forced_level current_level;
+
+	if (!ctx)
+		return -EINVAL;
+
+	current_level = amdgpu_dpm_get_performance_level(adev);
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
+	enum amd_dpm_forced_level level;
+	int r;
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
+	r = amdgpu_dpm_force_performance_level(adev, level);
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
@@ -270,7 +351,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
 			ctx->entities[i][j] = NULL;
 		}
 	}
-
+	amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
 	mutex_destroy(&ctx->lock);
 	kfree(ctx);
 }
@@ -467,11 +548,41 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
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
@@ -500,6 +611,20 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
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
index 257593bd1c40..3229381bf3fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3497,6 +3497,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	init_rwsem(&adev->reset_sem);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
+	mutex_init(&adev->pm.stable_pstate_ctx_lock);
 
 	r = amdgpu_device_init_apu_flags(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d2823aaeca09..7731dbbcb288 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -336,11 +336,16 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
 		return ret;
 	}
 
+	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
 	if (amdgpu_dpm_force_performance_level(adev, level)) {
 		pm_runtime_mark_last_busy(ddev->dev);
 		pm_runtime_put_autosuspend(ddev->dev);
+		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 		return -EINVAL;
 	}
+	/* override whatever a user ctx may have set */
+	adev->pm.stable_pstate_ctx = NULL;
+	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ba857ca75392..64e54d0daa15 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -328,6 +328,9 @@ struct amdgpu_pm {
 	uint32_t		smu_debug_mask;
 
 	bool			pp_force_state_enabled;
+
+	struct mutex            stable_pstate_ctx_lock;
+	struct amdgpu_ctx       *stable_pstate_ctx;
 };
 
 u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
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

