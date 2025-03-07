Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC57DC19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 18:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44C3210E234;
	Fri,  7 Mar 2025 18:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CmQeqwwv";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1545410E234
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 18:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnX2iXm7HWgt+E2AMmPa/qItYtYmHMPPWixxfbVKp93S9LoqslkxI7wzV+FWxr6qj3CuhX5KZGOuaKN8GQWRsDVW7lTb7R7YJMyP9vT1IEJU9BuJFIGmBD6P/Gz+qaNw/dNbuZgCv7vJ/Fz65UgpcGMrPnLfCzNKSIGj+SNn9AmDsBi5Y6GINCl6VvWRsZh2D/II3KC5yBTlGaGxuerWjPW8nUiotvjdH30kpvG3prrvwy0wCzuWbIvtCh6+cMvYXDGJguQImRI/qDdmUT/r320u/FnDkvkcn4aQ+F3+9TF16GNgjIJy9Q3g8QwleOYJd921BiJo3KMComtLZtlMQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/gE5M9PjEthIpgoROEjV4SLRGl04ypuvnirIvHYnao=;
 b=wFsW+cz799ZQ3mKigoiBCBcvYXU5+YYi61O4WKpYIOPml4DRPTea+NTMmsBkGqJ3D4liX3ObgZtAnl+A5u/nAQJ4hASa1+6f4IVZnhCZvnW/nG3gDO+xdLUDoDvfQy4btUSehsuGO+AO5hy386HTHUAeWMeJziHPIPCojQaU6r/bcezSno+s3Ls4JO84s5bsD6FapHOgnGpec/IA+jYB+Sh9LVOW1UyOHPqpTbsjmEcF62+JTaOqA9kyGED7axzgFMJsDa1Z9+ygAFYfZ+Y9B/7NrcwQr3dnr3j0wdRj/HD6wRo/DYtZnJ8eJ2uHewUGtDG6TINy0Ll1xJ7oKjs1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/gE5M9PjEthIpgoROEjV4SLRGl04ypuvnirIvHYnao=;
 b=CmQeqwwvVn+2MWdFxduGbQNGdBsxth5wTQN/ekg6O8vd1d2vEOD18y9bsjwwuNU6dgVvEN97H/r8VT5TqnfRgA2q/h3lgm1ywOSIgWcxYLwut18tg9p8CtlElKYGjVdZA6Hy3WOmhEYyr/sP6BwkvsG32F7hLcUV8ZIa7/WKdO8=
Received: from BY1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::9)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 18:16:00 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::1e) by BY1P220CA0014.outlook.office365.com
 (2603:10b6:a03:59d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Fri,
 7 Mar 2025 18:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 18:15:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 12:15:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add UAPI for workload profile to ctx interface
Date: Fri, 7 Mar 2025 13:15:39 -0500
Message-ID: <20250307181539.1407625-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: ae39b8a3-64a2-48c7-4563-08dd5da41cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jnerb71W3gkeT3upEjyytvIpu7TGxffOwp0/WCRe8GXha3hPDAxXvHuN6vQp?=
 =?us-ascii?Q?3JrJImxi2shfQ2SOBcXNCOtKFFhY+CwB3FANnZfviuTqvEHARD68+cYa6CZy?=
 =?us-ascii?Q?FemPvEKF3Fm9Tm3buKLQQi12AVXIZv0a5FK691UezbNXykvSQxuk7tGTCKff?=
 =?us-ascii?Q?jqkbRdJZcsi+cH2Pwe6LaTxrkNFVn35B0GAHwS/qw0Qw5r+6VyRBxcyvrcOP?=
 =?us-ascii?Q?Uut0SvY4ty/G9nyy1QoYvDwnT0Mmh8jQcXh8c5TW4nf2Km3JP7/u71Drbx5O?=
 =?us-ascii?Q?Lk2nkJR0G4TRE0dOREZs/nPhptrXSWVulhg2YX79gGT6N9oxwGPVJrxWa6/g?=
 =?us-ascii?Q?Huswz8A/kddb20d+qRsIN4VIngizGv35nquOngpAwRzQVL7yoyUeK4bfA9WU?=
 =?us-ascii?Q?sMOBMCs6uAk+Rk03xnNIa7I7FjYJ+WJJoGhAJw6P+FAWrO5N/5ZILBuK3TS5?=
 =?us-ascii?Q?FCyt6mNtTYlzZP3VvUA7OcoqO7HnfMotxH5mHAMF1h9ET4qQOuTMUIn0H8Fd?=
 =?us-ascii?Q?A5pWxU+82aGvvg7f9uD/j2O9+E6tQ9ZKP5kec53xrME8KAmqIagOijZU1cN0?=
 =?us-ascii?Q?JKCkTEUWZF++NiLOdfV9lSlAet/KiZHvSyE4WNjccMudJWZoLR4l+Wp79+jz?=
 =?us-ascii?Q?oJu6Vo8+mKZGyYvNi9oL1P3nOmzmnBl1uIEnLrxm+U3GxiaquPW7zYKHWpg6?=
 =?us-ascii?Q?0kaJu0TX4a3avZUT1a9LB4/9X2kahMqYshXpaGN0c+kUWX4VTqByp6LsxqlM?=
 =?us-ascii?Q?/UrfHRKl01MUorj4+BB7flQYqpvSB3RauWsN2Kxzu5uOMbuyc9MWkDca3GuT?=
 =?us-ascii?Q?vKjujJustX5GDb/iVRtDyK90+QmA087CINRdGDCJwsd83iCsfwJndDuv8nRA?=
 =?us-ascii?Q?/jbl93u8Cwb2Ua9TqAQstmtNnGkRetCSrrr1PYraNCxCDo4Y4SvwsDfhUUJa?=
 =?us-ascii?Q?09rCeUCYUEvbaPp2hxgkk2gQvI/V56W1+byMIScjEQMUHSNWNab4Fg08m0PY?=
 =?us-ascii?Q?CzC37OMeNiE0SInpqAnwpZHgyrjf57T45K/DvqPYeZZEJ0/VVFyrAIFudBg0?=
 =?us-ascii?Q?THmhRhUWOYbS1Lak1vfvLTMMF/TqsAJFJxuVNe5Axix07yiMR9AAy12jEEBg?=
 =?us-ascii?Q?PlJ/+pRFlXlRA2oT+naCHcMg1vgsJ+iMmDQQ5PGjEzicrKltdRrPiYAGqvQO?=
 =?us-ascii?Q?NhbSXepagxu7cnPZLj4gayNklXLjLCekYaUhJ7dOFm329PfPNj4txWrALV83?=
 =?us-ascii?Q?edzLNYNsrYxxpfZ87Gf8/GacCxB/1DUJXa3mWjULEcCyuPeuYrPxmthhFxk/?=
 =?us-ascii?Q?52NQq5mEC2qc3RRPowegPXmWDkEjtsyZYA4B5uNA9iYzQ5pBegMIyr6kEb7A?=
 =?us-ascii?Q?xEjhO+j0kCPLeP2qAatFwqzM37wB+JDdZ3kepBX1EM8EsryosYLRE+daldkB?=
 =?us-ascii?Q?D3sdzp1KTa4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:15:59.2814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae39b8a3-64a2-48c7-4563-08dd5da41cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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

Allow a rendering context to set a workload profile.  This
allows an application to select a workload profile to match
its intended use case.  Each rendering context can set a
profile and internally the SMU firmware will select the highest
priority profile among those that are active.  When the
context is destroyed, the profile is automatically cleaned up.

E.g., a compositor can select the fullscreen3d hint when it
unredirects a fullscreen game.  This hint tweaks allows the
driver to tweak the performance for a specific workload associated
with the rendering context.

Initial proposed userspace:
https://gitlab.freedesktop.org/monado/monado/-/merge_requests/2371

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3802
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 82 ++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  2 +
 include/uapi/drm/amdgpu_drm.h           |  9 +++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c43d1b6e5d66b..ccbfe4adbf9e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -339,6 +339,7 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 	ctx->generation = amdgpu_vm_generation(mgr->adev, &fpriv->vm);
 	ctx->init_priority = priority;
 	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
+	ctx->workload_profile = PP_SMC_POWER_PROFILE_COUNT;
 
 	r = amdgpu_ctx_get_stable_pstate(ctx, &current_stable_pstate);
 	if (r)
@@ -404,6 +405,49 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 	return r;
 }
 
+static int amdgpu_ctx_set_workload_profile(struct amdgpu_ctx *ctx,
+					   u32 workload_profile)
+{
+	struct amdgpu_device *adev = ctx->mgr->adev;
+	enum PP_SMC_POWER_PROFILE profile;
+	int r;
+
+	switch (workload_profile) {
+	case AMDGPU_CTX_WORKLOAD_PROFILE_DEFAULT:
+		profile = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		break;
+	case AMDGPU_CTX_WORKLOAD_PROFILE_FULLSCREEN3D:
+		profile = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+		break;
+	case AMDGPU_CTX_WORKLOAD_PROFILE_VIDEO:
+		profile = PP_SMC_POWER_PROFILE_VIDEO;
+		break;
+	case AMDGPU_CTX_WORKLOAD_PROFILE_VR:
+		profile = PP_SMC_POWER_PROFILE_VR;
+		break;
+	case AMDGPU_CTX_WORKLOAD_PROFILE_COMPUTE:
+		profile = PP_SMC_POWER_PROFILE_COMPUTE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ctx->workload_profile != PP_SMC_POWER_PROFILE_COUNT) {
+		r = amdgpu_dpm_switch_power_profile(adev, ctx->workload_profile,
+						    false);
+		if (r)
+			return r;
+	}
+
+	r = amdgpu_dpm_switch_power_profile(adev, profile, true);
+	if (r)
+		return r;
+
+	ctx->workload_profile = profile;
+
+	return r;
+}
+
 static void amdgpu_ctx_fini(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
@@ -425,6 +469,9 @@ static void amdgpu_ctx_fini(struct kref *ref)
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 		amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
+		if (ctx->workload_profile != PP_SMC_POWER_PROFILE_COUNT)
+			amdgpu_dpm_switch_power_profile(adev, ctx->workload_profile,
+							false);
 		drm_dev_exit(idx);
 	}
 
@@ -662,11 +709,36 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_ctx_workload_profile(struct amdgpu_device *adev,
+				       struct amdgpu_fpriv *fpriv, uint32_t id,
+				       u32 workload_profile)
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
+	r = amdgpu_ctx_set_workload_profile(ctx, workload_profile);
+
+	mutex_unlock(&mgr->lock);
+	return r;
+}
+
 int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *filp)
 {
 	int r;
-	uint32_t id, stable_pstate;
+	uint32_t id, stable_pstate, workload_profile;
 	int32_t priority;
 
 	union drm_amdgpu_ctx *args = data;
@@ -720,6 +792,14 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 			return -EINVAL;
 		r = amdgpu_ctx_stable_pstate(adev, fpriv, id, true, &stable_pstate);
 		break;
+	case AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE:
+		if (args->in.flags & ~AMDGPU_CTX_WORKLOAD_PROFILE_FLAGS_MASK)
+			return -EINVAL;
+		workload_profile = args->in.flags & AMDGPU_CTX_WORKLOAD_PROFILE_FLAGS_MASK;
+		if (workload_profile > AMDGPU_CTX_WORKLOAD_PROFILE_COMPUTE)
+			return -EINVAL;
+		r = amdgpu_ctx_workload_profile(adev, fpriv, id, workload_profile);
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 85376baaa92f2..1b42e6757fac9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -27,6 +27,7 @@
 #include <linux/types.h>
 
 #include "amdgpu_ring.h"
+#include "kgd_pp_interface.h"
 
 struct drm_device;
 struct drm_file;
@@ -58,6 +59,7 @@ struct amdgpu_ctx {
 	unsigned long			ras_counter_ue;
 	uint32_t			stable_pstate;
 	struct amdgpu_ctx_mgr		*ctx_mgr;
+	enum PP_SMC_POWER_PROFILE	workload_profile;
 };
 
 struct amdgpu_ctx_mgr {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 5dbd9037afe75..9fcf81ab39a94 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -247,6 +247,7 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_OP_QUERY_STATE2	4
 #define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
 #define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
+#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE	7
 
 /* GPU reset status */
 #define AMDGPU_CTX_NO_RESET		0
@@ -289,6 +290,14 @@ union drm_amdgpu_bo_list {
 #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
 #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
 
+/* select a workload profile for applications */
+#define AMDGPU_CTX_WORKLOAD_PROFILE_FLAGS_MASK  0xf
+#define AMDGPU_CTX_WORKLOAD_PROFILE_DEFAULT  0
+#define AMDGPU_CTX_WORKLOAD_PROFILE_FULLSCREEN3D  1
+#define AMDGPU_CTX_WORKLOAD_PROFILE_VIDEO  2
+#define AMDGPU_CTX_WORKLOAD_PROFILE_VR  3
+#define AMDGPU_CTX_WORKLOAD_PROFILE_COMPUTE  4
+
 struct drm_amdgpu_ctx_in {
 	/** AMDGPU_CTX_OP_* */
 	__u32	op;
-- 
2.48.1

