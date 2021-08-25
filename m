Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB96C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A94D60FE6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A94D60FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E06028984D;
	Wed, 25 Aug 2021 11:36:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C14A8984D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 11:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+ftk3paYGKzIC8UD8qpjx4cE72eZ1+uzGg6bao6XuZJZw2ChST/Ujvh2f4Wfd3KmGhHbhnYPlHa+OJkKcGbRlKz8Gl+FhBjRhNQDDLOm5PxIxktloZTTSWwpOhbUkrbh1S1Ux9mRjCjuyvOhv1Wk8BqAXOO5ncjUseyQIeRadLS1K6k2hyVDTkdt+3wS74EmoWc2D8eH/fChnAKgw6R9gdadEeNly57o4o2R8y7c7W/K+YeJFoIB5NoqAKrJM3mdvxQNLNvBHGgkwFsDbS3GQIpwTNHhnAiy87fdJIZjM0FGoJr5w5PeTBq2AzYqUHFOo+oHs5vhjFel2YvsGKRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjuTRMU6zFW59lLRkqbs/OmEeYeF8Etcetax4/DuGwA=;
 b=nDnSQAXyKz9pNnez1IkI6BUxvVZBjZXy1+GvBlrjVOg8K7Vowgd59E+5Xbip7sTONNGo8896/suSOlKJH09MOyyZP4oxd/Zn61Sg+lA3+w1DLUv4Vz50OdGwJwVGfo2t1jU+VsDmjuOTtt6LWQOcPywbR5TDYGJ7ksAbyHDoeEcWLyzkG9FG64hXl5LdOeBDZ7oBfL5yrTuLk1Eufv8V3Fb05phTutjnMusIKIwot3m+MvCD5D20Bnjloe4QgF4OkHqIJlBk/oULNMrbsjMwxAeoyk9H3n8KBX8BgHKO4wNa/sQBZM7O5IfVkTMvuGwG8cUoX5/g/7IGArW6ur7JlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjuTRMU6zFW59lLRkqbs/OmEeYeF8Etcetax4/DuGwA=;
 b=CM4sBWrTEwZuAp5E/YmDBh5Uutsbl/uh8jQbIEBTs+Czv8ycxiD2P8jcjgS7LKyg/DXtz1Svt3rtlVDB2nWBpBtYcUX7MjPDyJ38jFTlm6Sm+5yvb6sH7Ka4G+LVz7ZfffiOrVlcKoSNWm52rpFpCHVKNTfMKN6DmucfdRMmQys=
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 11:22:32 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::83) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 25 Aug 2021 11:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Wed, 25 Aug 2021 11:22:32 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 25 Aug
 2021 06:22:30 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <satyajit.sahu@amd.com>, Nirmoy Das
 <nirmoy.das@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: rework context priority handling
Date: Wed, 25 Aug 2021 13:22:03 +0200
Message-ID: <20210825112203.3806-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2007214e-0f67-4f18-bc4e-08d967baa1cd
X-MS-TrafficTypeDiagnostic: CH0PR12MB5265:
X-Microsoft-Antispam-PRVS: <CH0PR12MB52658CF0EEFCBBDDC1D124798BC69@CH0PR12MB5265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fN93pUpFWMUK3mdE8E1O9WM1l8F0r93VC5+6D8zdO32Fn0R8SNLTsfFLYYZIz/khBM52HiXv/v0uSVQYdMAJ+rGXDmdsyMiBb/JW1PjGNP5UoKE9xDCLSiOoDz+QKJtoBUfnRD3SUPqy7+tRXRSnR1aq5nn1VLNbA86AIyLfEZswhrIn+Aqu5nqEBB9FzuBt7e3+xzvLti8ae1boJ8aR/QakMlljmX8Yq0QMG2rEmdOMghB87mMw4Kfgl8mcVJG2H1o7ONv5CNPlZJiZwge5g/imkQvtUVfRPfoagZDHuNivyTFG5qdb5witGd1roWU8taCTK0rYtmOwcCe05Sf2pNRz97TOdbvLHKC0aVJYxfxoI0CtjXefzsYcAaIOF2PuLvYnABAHLrS8MFU7vqtJupIbQ2oGGejhyz3tdBTyrTfYqOag33wPy1giO+cc8kgclS7eho2oMf+l/XSqFJVlQZZw/rVREbBnIiuxGWsL20KQ2TjI4qo1TzHWs1Q09LONs+gfQjL9cZPOXWx+qNFjlHugTOdxYRjgdp5fWZXjY5rwKfVN//3JGvvx4s1kT0Zc6ohAuLecri1ir5kvBzhvyMeLanUfQPdbmY8ekKCYScLgv3ZNdwckNjgbJm+y5FnchdCGQTonmLCzQEXwrraWDnZOGUIG8uiie+ljYXwTvW5R2IajYPMz6gq4pZ8elQfn0aKvR3Df8mxZxMz30ieG2hM2Z0NNNlOM1p3zAUgTBsc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(54906003)(86362001)(5660300002)(6666004)(1076003)(356005)(6916009)(4326008)(7696005)(8936002)(8676002)(336012)(426003)(36756003)(44832011)(47076005)(36860700001)(83380400001)(16526019)(186003)(70206006)(70586007)(2906002)(81166007)(30864003)(82310400003)(26005)(316002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 11:22:32.3779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2007214e-0f67-4f18-bc4e-08d967baa1cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5265
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

To get a hardware queue priority for a context, we are currently
mapping AMDGPU_CTX_PRIORITY_* to DRM_SCHED_PRIORITY_* and then
to hardware queue priority, which is not the right way to do that
as DRM_SCHED_PRIORITY_* is software scheduler's priority and it is
independent from a hardware queue priority.

Use userspace provided context priority, AMDGPU_CTX_PRIORITY_* to
map a context to proper hardware queue priority.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 127 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  44 ++------
 3 files changed, 105 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index e7a010b7ca1f..c88c5c6c54a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -43,14 +43,61 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
 	[AMDGPU_HW_IP_VCN_JPEG]	=	1,
 };
 
+bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
+{
+	switch (ctx_prio) {
+	case AMDGPU_CTX_PRIORITY_UNSET:
+	case AMDGPU_CTX_PRIORITY_VERY_LOW:
+	case AMDGPU_CTX_PRIORITY_LOW:
+	case AMDGPU_CTX_PRIORITY_NORMAL:
+	case AMDGPU_CTX_PRIORITY_HIGH:
+	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static enum drm_sched_priority
+amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
+{
+	switch (ctx_prio) {
+	case AMDGPU_CTX_PRIORITY_UNSET:
+		return DRM_SCHED_PRIORITY_UNSET;
+
+	case AMDGPU_CTX_PRIORITY_VERY_LOW:
+		return DRM_SCHED_PRIORITY_MIN;
+
+	case AMDGPU_CTX_PRIORITY_LOW:
+		return DRM_SCHED_PRIORITY_MIN;
+
+	case AMDGPU_CTX_PRIORITY_NORMAL:
+		return DRM_SCHED_PRIORITY_NORMAL;
+
+	case AMDGPU_CTX_PRIORITY_HIGH:
+		return DRM_SCHED_PRIORITY_HIGH;
+
+	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
+		return DRM_SCHED_PRIORITY_HIGH;
+
+	/* This should not happen as we sanitized userspace provided priority
+	 * already, WARN if this happens.
+	 */
+	default:
+		WARN(1, "Invalid context priority %d\n", ctx_prio);
+		return DRM_SCHED_PRIORITY_NORMAL;
+	}
+
+}
+
 static int amdgpu_ctx_priority_permit(struct drm_file *filp,
-				      enum drm_sched_priority priority)
+				      int32_t priority)
 {
-	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_COUNT)
+	if (!amdgpu_ctx_priority_is_valid(priority))
 		return -EINVAL;
 
 	/* NORMAL and below are accessible by everyone */
-	if (priority <= DRM_SCHED_PRIORITY_NORMAL)
+	if (priority <= AMDGPU_CTX_PRIORITY_NORMAL)
 		return 0;
 
 	if (capable(CAP_SYS_NICE))
@@ -62,26 +109,35 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
-static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sched_priority prio)
+static enum gfx_pipe_priority amdgpu_ctx_prio_to_compute_prio(int32_t prio)
 {
 	switch (prio) {
-	case DRM_SCHED_PRIORITY_HIGH:
-	case DRM_SCHED_PRIORITY_KERNEL:
+	case AMDGPU_CTX_PRIORITY_HIGH:
+	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
 		return AMDGPU_GFX_PIPE_PRIO_HIGH;
 	default:
 		return AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	}
 }
 
-static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
-						 enum drm_sched_priority prio,
-						 u32 hw_ip)
+static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
 {
+	struct amdgpu_device *adev = ctx->adev;
+	int32_t ctx_prio;
 	unsigned int hw_prio;
 
-	hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
-			amdgpu_ctx_sched_prio_to_compute_prio(prio) :
-			AMDGPU_RING_PRIO_DEFAULT;
+	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
+			ctx->init_priority : ctx->override_priority;
+
+	switch (hw_ip) {
+	case AMDGPU_HW_IP_COMPUTE:
+		hw_prio = amdgpu_ctx_prio_to_compute_prio(ctx_prio);
+		break;
+	default:
+		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
+		break;
+	}
+
 	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
 	if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
 		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
@@ -89,15 +145,17 @@ static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
 	return hw_prio;
 }
 
+
 static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
-				   const u32 ring)
+				  const u32 ring)
 {
 	struct amdgpu_device *adev = ctx->adev;
 	struct amdgpu_ctx_entity *entity;
 	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
 	unsigned num_scheds = 0;
+	int32_t ctx_prio;
 	unsigned int hw_prio;
-	enum drm_sched_priority priority;
+	enum drm_sched_priority drm_prio;
 	int r;
 
 	entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
@@ -105,10 +163,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	if (!entity)
 		return  -ENOMEM;
 
+	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
+			ctx->init_priority : ctx->override_priority;
 	entity->sequence = 1;
-	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
-				ctx->init_priority : ctx->override_priority;
-	hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority, hw_ip);
+	hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
+	drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
 
 	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
 	scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
@@ -124,7 +183,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 		num_scheds = 1;
 	}
 
-	r = drm_sched_entity_init(&entity->entity, priority, scheds, num_scheds,
+	r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, num_scheds,
 				  &ctx->guilty);
 	if (r)
 		goto error_free_entity;
@@ -139,7 +198,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 }
 
 static int amdgpu_ctx_init(struct amdgpu_device *adev,
-			   enum drm_sched_priority priority,
+			   int32_t priority,
 			   struct drm_file *filp,
 			   struct amdgpu_ctx *ctx)
 {
@@ -161,7 +220,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	ctx->reset_counter_query = ctx->reset_counter;
 	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
 	ctx->init_priority = priority;
-	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
+	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
 
 	return 0;
 }
@@ -234,7 +293,7 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
 			    struct amdgpu_fpriv *fpriv,
 			    struct drm_file *filp,
-			    enum drm_sched_priority priority,
+			    int32_t priority,
 			    uint32_t *id)
 {
 	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
@@ -397,19 +456,19 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 {
 	int r;
 	uint32_t id;
-	enum drm_sched_priority priority;
+	int32_t priority;
 
 	union drm_amdgpu_ctx *args = data;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 
 	id = args->in.ctx_id;
-	r = amdgpu_to_sched_priority(args->in.priority, &priority);
+	priority = args->in.priority;
 
 	/* For backwards compatibility reasons, we need to accept
 	 * ioctls with garbage in the priority field */
-	if (r == -EINVAL)
-		priority = DRM_SCHED_PRIORITY_NORMAL;
+	if (!amdgpu_ctx_priority_is_valid(priority))
+		priority = AMDGPU_CTX_PRIORITY_NORMAL;
 
 	switch (args->in.op) {
 	case AMDGPU_CTX_OP_ALLOC_CTX:
@@ -515,9 +574,9 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 }
 
 static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
-					    struct amdgpu_ctx_entity *aentity,
-					    int hw_ip,
-					    enum drm_sched_priority priority)
+					   struct amdgpu_ctx_entity *aentity,
+					   int hw_ip,
+					   int32_t priority)
 {
 	struct amdgpu_device *adev = ctx->adev;
 	unsigned int hw_prio;
@@ -525,12 +584,12 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
 	unsigned num_scheds;
 
 	/* set sw priority */
-	drm_sched_entity_set_priority(&aentity->entity, priority);
+	drm_sched_entity_set_priority(&aentity->entity,
+				      amdgpu_ctx_to_drm_sched_prio(priority));
 
 	/* set hw priority */
 	if (hw_ip == AMDGPU_HW_IP_COMPUTE) {
-		hw_prio = amdgpu_ctx_prio_sched_to_hw(adev, priority,
-						      AMDGPU_HW_IP_COMPUTE);
+		hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
 		hw_prio = array_index_nospec(hw_prio, AMDGPU_RING_PRIO_MAX);
 		scheds = adev->gpu_sched[hw_ip][hw_prio].sched;
 		num_scheds = adev->gpu_sched[hw_ip][hw_prio].num_scheds;
@@ -540,14 +599,14 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
 }
 
 void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
-				  enum drm_sched_priority priority)
+				  int32_t priority)
 {
-	enum drm_sched_priority ctx_prio;
+	int32_t ctx_prio;
 	unsigned i, j;
 
 	ctx->override_priority = priority;
 
-	ctx_prio = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
+	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
 			ctx->init_priority : ctx->override_priority;
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
 		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 14db16bc3322..a44b8b8ed39c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -47,8 +47,8 @@ struct amdgpu_ctx {
 	spinlock_t			ring_lock;
 	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
 	bool				preamble_presented;
-	enum drm_sched_priority		init_priority;
-	enum drm_sched_priority		override_priority;
+	int32_t				init_priority;
+	int32_t				override_priority;
 	struct mutex			lock;
 	atomic_t			guilty;
 	unsigned long			ras_counter_ce;
@@ -75,8 +75,8 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
 struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 				       struct drm_sched_entity *entity,
 				       uint64_t seq);
-void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
-				  enum drm_sched_priority priority);
+bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio);
+void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx, int32_t ctx_prio);
 
 int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 		     struct drm_file *filp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index b7d861ed5284..e9b45089a28a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -32,37 +32,9 @@
 #include "amdgpu_sched.h"
 #include "amdgpu_vm.h"
 
-int amdgpu_to_sched_priority(int amdgpu_priority,
-			     enum drm_sched_priority *prio)
-{
-	switch (amdgpu_priority) {
-	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
-		*prio = DRM_SCHED_PRIORITY_HIGH;
-		break;
-	case AMDGPU_CTX_PRIORITY_HIGH:
-		*prio = DRM_SCHED_PRIORITY_HIGH;
-		break;
-	case AMDGPU_CTX_PRIORITY_NORMAL:
-		*prio = DRM_SCHED_PRIORITY_NORMAL;
-		break;
-	case AMDGPU_CTX_PRIORITY_LOW:
-	case AMDGPU_CTX_PRIORITY_VERY_LOW:
-		*prio = DRM_SCHED_PRIORITY_MIN;
-		break;
-	case AMDGPU_CTX_PRIORITY_UNSET:
-		*prio = DRM_SCHED_PRIORITY_UNSET;
-		break;
-	default:
-		WARN(1, "Invalid context priority %d\n", amdgpu_priority);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 						  int fd,
-						  enum drm_sched_priority priority)
+						  int32_t priority)
 {
 	struct fd f = fdget(fd);
 	struct amdgpu_fpriv *fpriv;
@@ -89,7 +61,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 static int amdgpu_sched_context_priority_override(struct amdgpu_device *adev,
 						  int fd,
 						  unsigned ctx_id,
-						  enum drm_sched_priority priority)
+						  int32_t priority)
 {
 	struct fd f = fdget(fd);
 	struct amdgpu_fpriv *fpriv;
@@ -124,7 +96,6 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 {
 	union drm_amdgpu_sched *args = data;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	enum drm_sched_priority priority;
 	int r;
 
 	/* First check the op, then the op's argument.
@@ -138,21 +109,22 @@ int amdgpu_sched_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
-	r = amdgpu_to_sched_priority(args->in.priority, &priority);
-	if (r)
-		return r;
+	if (!amdgpu_ctx_priority_is_valid(args->in.priority)) {
+		WARN(1, "Invalid context priority %d\n", args->in.priority);
+		return -EINVAL;
+	}
 
 	switch (args->in.op) {
 	case AMDGPU_SCHED_OP_PROCESS_PRIORITY_OVERRIDE:
 		r = amdgpu_sched_process_priority_override(adev,
 							   args->in.fd,
-							   priority);
+							   args->in.priority);
 		break;
 	case AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE:
 		r = amdgpu_sched_context_priority_override(adev,
 							   args->in.fd,
 							   args->in.ctx_id,
-							   priority);
+							   args->in.priority);
 		break;
 	default:
 		/* Impossible.
-- 
2.32.0

