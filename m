Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22D7CDB474
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 01:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF2610E042;
	Wed, 18 Oct 2023 01:04:24 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F8310E042
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 01:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E29bJO5QeclWf0iF+XBgEfc33xS4xlfuM7HzmTTRiACh54trh36jQmFrgUwX5hoJQJIlHoAjuPqJotCuCloy8W4SWhdR+CGm2RwUGxFLhnQiPlNBA4ckUvxLkaplTGqWY030GV2VRcarh4A+CC+UotuHeKyTUHONSxjEMBdZuF3VXXNuOic9CJ2QprAcHiHPj+jZqo9Ia6Yqb7qMVuFWUIuZ7EcK6p8Il8er2Qb801kS5t6peVyo5/6VcmSHuut7QI/gzqCnW/6eJVAI7EaRxtsxilgHx03eLt0sntt4rzRYh8vFtjWuYZ/5I3v16Jo6rZ0pyoIfd+Wks+n/6qplHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjVSAY1eOgyslhFBfKq2ReNj+tygtswg1C2OrL7LdgQ=;
 b=oKo/C+T78EAZpu4UujwP7cbOIpXRSDbyt/uxd7EM+fP9rcU8Nbrlgjdis4gQzLpAp6TLGMHEaoxfQtfRH/Kjc9vDMqh5BJXepmZao0nnHAnAKloKs2TXpwwngUr/eXf8Usu0F9fPSiP0GVSWho0JYDErvJDQwM1fZCrDtCf/uPZzL1YfN6/5jSdb0V3vZm+ETi/0y63NYdyjUNQkUo+hftHP39g2XIOlJ7wuUynXJ63HxPwaxj0sPTJJ0D2xXTMOot66QG8LIbPZY19Aguh+M8kPuw5bIFJURa9Qws+Y5WJ4bduVXOE2Et2D1/d2lrrKxSPtArc7KHlnKYVsTcpD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjVSAY1eOgyslhFBfKq2ReNj+tygtswg1C2OrL7LdgQ=;
 b=hksi3/qe2UVOMwoNb9mPr188XS2AEIGLeRQ+GkWg5sA1bwNY6C7ksQFy4MS7039zmxYXt680yOCLq3ds6/dolEFq6vP/udjWtS5ozUPKHyvbTVlLVGu3IPJZ0VEjvqVPmFrbeDQ878+4tz7X4mjwTc9GhZ8TJ1Gbyf39+1TvO/A=
Received: from CH2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:610:20::16)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 18 Oct
 2023 01:04:19 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::b0) by CH2PR07CA0003.outlook.office365.com
 (2603:10b6:610:20::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 01:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 01:04:19 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 20:04:17 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove redundant call to priority_is_valid()
Date: Tue, 17 Oct 2023 21:03:59 -0400
Message-ID: <20231018010359.30393-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.1
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc02107-92aa-41ad-3186-08dbcf76284e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HomloGp9+GQ9BY9/mUsAvsiNn0u1cXJ5AJwbc7eqn2wu7iK4YUaRnPW+xONRhKCDQscxkIrcy+bsn3y36Av3ovEOnQv/xKA0A1dIoe4KZCTZJIYyue5t8pn3S5WecFP0HxKqBqsIhPUxLcm9l+157HRZVEW92kMduYc5k69gJAJZ4urlOzLAYvjDUX5zizF4dHSCo6R4jMpnUxvWkB6kmSibnFdwmIPvldz5LvrMFY14ODvuc9Ontp9H3i30/BUxm0RKPPWGX4J+/5qR0FcG2+XsIYcR+CPj9dW/tjDQm1Tb4Qzj8wGX4b9knf+uu0ujJ/0MVy5ECjJ1VR3nm4Dxuki95GE6nViwyDAIaR4gCAeLB/3kjdYKK/PEqirw9KVBlErr1qUSYLB+vJm9qeManfEPpaIjtevWKKt5Nsdcb0zo+xVCIpSs8WZPE1mioIlqP38I+pnAFiEXxRnLlIkUTL/TU3/Vg5hFjxeCLhFvCY27eKZFC07C7zceg2N5ggVx2q74LiTKkCGVgMSYu3cpDt2J3Ktq9u9SO+NyLid2PYFDClbiwDLMOymoyAL9wogg6q7VX+P5t95GhqyC+tUn8QtVZJNRp6tSGZbUjlC8OZBoqYYFvAQjWZANja6Y4Rwzk9vXFPtevQ6Exd2qwMHvmIcMxLOTOl/jJIVXGeSD91R9X+1hxMjMhLjVKeXkBrHG1YNBGU1taSL2EzMtnH8cqrMNVeT9hP0RQctt72O6sG+0ejzi/aJTfEFGe5lTttoFSkUfmVtE4Q17zl/hZnR2zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(46966006)(40470700004)(26005)(40480700001)(478600001)(47076005)(2616005)(16526019)(1076003)(7696005)(83380400001)(86362001)(6666004)(40460700003)(336012)(426003)(8936002)(8676002)(4326008)(70206006)(36756003)(6916009)(54906003)(70586007)(316002)(41300700001)(2906002)(44832011)(81166007)(36860700001)(356005)(82740400003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 01:04:19.1579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc02107-92aa-41ad-3186-08dbcf76284e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove a redundant call to amdgpu_ctx_priority_is_valid() from
amdgpu_ctx_priority_permit(), which is called from amdgpu_ctx_init() which is
called from amdgpu_ctx_alloc() which is called from amdgpu_ctx_ioctl(), where
we've called amdgpu_ctx_priority_is_valid() already first thing in the
function.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 68db924161ef66..4c6ffca97c4512 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -56,6 +56,10 @@ bool amdgpu_ctx_priority_is_valid(int32_t ctx_prio)
 		return true;
 	default:
 	case AMDGPU_CTX_PRIORITY_UNSET:
+		/* UNSET priority is not valid and we don't carry that
+		 * around, but set it to NORMAL in the only place this
+		 * function is called, amdgpu_ctx_ioctl().
+		 */
 		return false;
 	}
 }
@@ -96,9 +100,6 @@ amdgpu_ctx_to_drm_sched_prio(int32_t ctx_prio)
 static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 				      int32_t priority)
 {
-	if (!amdgpu_ctx_priority_is_valid(priority))
-		return -EINVAL;
-
 	/* NORMAL and below are accessible by everyone */
 	if (priority <= AMDGPU_CTX_PRIORITY_NORMAL)
 		return 0;
@@ -625,8 +626,6 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 	return 0;
 }
 
-
-
 static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 				    struct amdgpu_fpriv *fpriv, uint32_t id,
 				    bool set, u32 *stable_pstate)
@@ -669,8 +668,10 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 	id = args->in.ctx_id;
 	priority = args->in.priority;
 
-	/* For backwards compatibility reasons, we need to accept
-	 * ioctls with garbage in the priority field */
+	/* For backwards compatibility, we need to accept ioctls with garbage
+	 * in the priority field. Garbage values in the priority field, result
+	 * in the priority being set to NORMAL.
+	 */
 	if (!amdgpu_ctx_priority_is_valid(priority))
 		priority = AMDGPU_CTX_PRIORITY_NORMAL;
 

base-commit: 915718484b8fa1eede4499a939e2e4fc0d85caa4
prerequisite-patch-id: a36f628997d923f66da5342e760e8b45ff959fb8
prerequisite-patch-id: f15148c302329c0c60d86040571c61d367bd05e7
-- 
2.42.0

