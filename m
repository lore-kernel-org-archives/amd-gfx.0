Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C03C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 14:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5568394D6D;
	Tue, 12 Jul 2022 14:52:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9263794D56
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 14:52:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MECxiBGdJFOJagEmOYjNwy8JbV5xs4NKXU9T3PP5I0ySWHJCod6Q8FCnm9LNq1umVSz2n/EDuBo/moN+3n6tVLVKNvckdqpLbifgCzxgt1YUqfg+eeglj8SaQssksRIpUpT570UTl8od/rz23bD9/IqOytDQHX7dVMKNLFOmuCTMRMph8zbhM42y7guEFiIK1bYJ5jrYeHOiF90Dh/63SSVJ3J+Cue+uoMaGwXxMx0/voBB5J2RN0HReynrc1vBg0UM1l2qS8eAJG42WVGv1+4keqfxVT+EvXhF+4X8CWdNVrwwyCwUgvjJn0qblFOImiMKwpCtXlsrHP7eAe4LcPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc/KHxPWtO1QP0yDCIFFDBzWhV/W4KbE1mXUkpEOIa8=;
 b=Bk5SwWO5Gr9g2S6Xqd3yO2NDmUr+JFZ9QEIFkju0xgt/Hr5WHWH7SVHtTLQf+4fq4Jcqx0o+F4s9eqQbMvI7XZ2hlXz1mW6hQHrwvFKperJ65kjsmcYlSXtlyTNqfXpWPrC41Pj3kEkufvYugEgRdp/qbkaTxyeMLGUmH6K9I9tA/e8d06htWsV0VopEmpoR0NgiBD5ShZ9hDUObt3Vf/SW3iWopplEbpARvfVWqS7YMl/9NbomXiTjeSAIBBPXWaAAN0rBzrtPXsyjUDG2DfV4W/hwDm7t+rKpLc40U5gfvqQVVfCOhzgrYSSd8B3ZlOlN/Fpt8vX42ck/wYeA2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc/KHxPWtO1QP0yDCIFFDBzWhV/W4KbE1mXUkpEOIa8=;
 b=02P3C+Y+O/lpJlElZEPRhtvNe/vuKSbMpo4/WyyGFaKHslXU+VZPEyF2/mGn8mNy1bDApCM5QeJKN6A6KqUOrdDZI7ErFy0X6S8hAq6/pnC/GrWjZkkPDsp41yL9nylsMN/xjEYplp40XIy382TVzN0NcVmNXUgjZ8Fd7ray+nw=
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 14:52:40 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::98) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Tue, 12 Jul 2022 14:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 14:52:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 09:52:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: restore original stable pstate on ctx fini
Date: Tue, 12 Jul 2022 10:52:25 -0400
Message-ID: <20220712145225.2996286-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58c355fc-712d-4e76-0813-08da64162afc
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6148:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wa+G6LxEFjtNddu3wBUxiEgDMibd0bpwM+AdeBrMbr/65rGSSTtcL7lx9+dFBrZ0Z7n+t4oXpz0cJ1zCXqMiQF/jNmQettgZ6F5wsaDk5STozrLkUMUW9TCcZAEjbMtzGL3KL6ixO2xfTqMKRe8iNIM/jqXmGXa1hp8Xx6L1p6NEK+hWL+sFBB8KXjes4uJlR3obW3fM9oi4XylUQ8mXklwhIHIcj3U0n6VYvPlbz9gveKwIWfF+AVHJE8YEL73Ns8xjxliKQZ0sAuVI/frlTZIA5Jm+G1XNKgbIbo7p8aUFHOcpjFUGbQjgBVIAd86n6OjthQxYDAKJwGUhddnIfDsS37uKXOq7PjX8xlEyz/gyWqaqO1CyoFIragsYI2CVuNnUG9mCHUxmmfW0g/f1y/fjJICAHr6MZ8XlniUBJFqpf+Blc7IyrEguzxlvlCxFhh1d8ekOvHG6n+2bqk4mzfvDnhTCY8tsKaURV0UJ2oSPb5nTvYzMzc1yBE/UdkjVMeidN8NFuaIgfrHveeo/CNPrXv3uHUK2YL+N3LTaiaDoG9TGgPNipbq+xcBT40ehWi1Ce4EQzjmJb4CBSVz8Jk3LpB0LVLFQlAHY1sR9t7hMih74oVPQshu7sPtAw9PTZngL2M9byDmo03mekOoOsrKi+ldBiQhY//PXXwXPeVF1oYFuEFke7od8VDwWRvZ06RaV3Lj/sGGcrxXk7f6Gt4DunXpIMtsXSq2qXTyGo4EofiNMd7Lu+WlrE+1t9js26pDbHAXNKB0rXi9eBqqF9nWwPGmK/yOxKwG7T0zNdkyYyaJXt74ubR3MptSSHoSZ3EVxTRk9o8UjI6sKViGdKAjY1UERxu3u2s5AL3eLvao=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(86362001)(36756003)(81166007)(40480700001)(36860700001)(47076005)(83380400001)(2616005)(186003)(426003)(356005)(82740400003)(336012)(1076003)(16526019)(26005)(54906003)(70206006)(478600001)(4326008)(70586007)(41300700001)(316002)(6666004)(6916009)(8936002)(7696005)(8676002)(5660300002)(82310400005)(40460700003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:52:39.7689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c355fc-712d-4e76-0813-08da64162afc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Save the original stable pstate on ctx init and restore
it on ctx fini so that we restore a manually selected
stable pstate on ctx exit.

v2: fix init order (Alex)
v3: don't add new variable to ctx struct (Evan)

Fixes: c65b364c52ba ("drm/amdgpu/ctx: only reset stable pstate if the user changed it (v2)")
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 58 ++++++++++++++-----------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 53f9268366f2..168337d8d4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -272,31 +272,6 @@ static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
 	return res;
 }
 
-static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
-			   struct drm_file *filp, struct amdgpu_ctx *ctx)
-{
-	int r;
-
-	r = amdgpu_ctx_priority_permit(filp, priority);
-	if (r)
-		return r;
-
-	memset(ctx, 0, sizeof(*ctx));
-
-	kref_init(&ctx->refcount);
-	ctx->mgr = mgr;
-	spin_lock_init(&ctx->ring_lock);
-
-	ctx->reset_counter = atomic_read(&mgr->adev->gpu_reset_counter);
-	ctx->reset_counter_query = ctx->reset_counter;
-	ctx->vram_lost_counter = atomic_read(&mgr->adev->vram_lost_counter);
-	ctx->init_priority = priority;
-	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
-	ctx->stable_pstate = AMDGPU_CTX_STABLE_PSTATE_NONE;
-
-	return 0;
-}
-
 static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 					u32 *stable_pstate)
 {
@@ -325,6 +300,37 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 	return 0;
 }
 
+static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
+			   struct drm_file *filp, struct amdgpu_ctx *ctx)
+{
+	u32 current_stable_pstate;
+	int r;
+
+	r = amdgpu_ctx_priority_permit(filp, priority);
+	if (r)
+		return r;
+
+	memset(ctx, 0, sizeof(*ctx));
+
+	kref_init(&ctx->refcount);
+	ctx->mgr = mgr;
+	spin_lock_init(&ctx->ring_lock);
+
+	ctx->reset_counter = atomic_read(&mgr->adev->gpu_reset_counter);
+	ctx->reset_counter_query = ctx->reset_counter;
+	ctx->vram_lost_counter = atomic_read(&mgr->adev->vram_lost_counter);
+	ctx->init_priority = priority;
+	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
+
+	r = amdgpu_ctx_get_stable_pstate(ctx, &current_stable_pstate);
+	if (r)
+		return r;
+
+	ctx->stable_pstate = current_stable_pstate;
+
+	return 0;
+}
+
 static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 					u32 stable_pstate)
 {
@@ -396,7 +402,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
 	}
 
 	if (drm_dev_enter(&adev->ddev, &idx)) {
-		amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
+		amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
 		drm_dev_exit(idx);
 	}
 
-- 
2.35.3

