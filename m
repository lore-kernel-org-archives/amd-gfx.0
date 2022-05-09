Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C84C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 20:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB5910E195;
	Mon,  9 May 2022 20:04:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8195310E195
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 20:04:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EefNw9/ejSq2qu6NkSdpsJ4O1Em2XqJDYtJF09KBEdY7nWsweBuTKd7b7nWiPe89xqEaAnVg2dUusF3GZ84O1gvP9pIN8HKzwDQMkj8z4lzloPBjhDfKSbnQo4yDo8ODLXS8ttKz2bYiSpjbSGR1zjwW5iL7lwQ759WfuYfm3AHEcdtArqaMxpYraJ36LC5TPX3aytYJt/CPdyFqKzn3B+AFxf+sFW5z2FM9332AR6qNEbm/RObOmRnRUpl40pwF14+zHPG+0LaYLIHKuAuGHlpM+tSNYqglnyF7eYeI+szqCV2zFMwdwwXdbQ1xJBri8oyDwg3cebhw9NItsU+TZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSCg67fw5NjQ8A43EdwOF9IfQ6DTNZezCAy457BUdpc=;
 b=Kuh6i3ejocIJNiORKqf1gsx2Zhp+3txmmkyaM1czdFTzqiEGB2p0a/XX/dM8nMnobfFv4BlmnXAJ4kBXMUDMxQb3Zj8Oh8mSmKc5cRfBHkcGKnW3xUdE1moyd6fNwnQJef3yISsS8MqKYoif4v7z1PiSzYRxTxaXuiKKsZsh8BxQuUxlZY2/9/Tm8Tkzw/NCUUXTXFkXllEaunRELbBT8EPZ2jYjW+K7i/lsQxfez3dI0KMT6DYbtGIRP4IHakFP+/fJ3A4MrS5pnNN5JgF2SDnPX1PkCCdfPqlAyRSPjxyvCv//JmjPFtWn5VISAS37pnkzbriFOXBxRA4ceU36QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSCg67fw5NjQ8A43EdwOF9IfQ6DTNZezCAy457BUdpc=;
 b=DMjUqpEEn/s5wLfnnpSS0qlA3ffkxO2V3dY5lE5HI6B51vjp4cYXNGEyMZ9+p3cpoP2i9g7Aaoge/p8fRnOvUYMGznicuzqRV1JyGT4V5ZNiIjrADElA7JuBnqKLaz6zEKyrYGpJnQQlG3TNFDV11DnZoH9XjQuf2QDtHY828JE=
Received: from BN1PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:e0::12)
 by MWHPR1201MB2479.namprd12.prod.outlook.com (2603:10b6:300:df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 20:04:02 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::8b) by BN1PR10CA0007.outlook.office365.com
 (2603:10b6:408:e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 20:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 20:04:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 15:04:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/ctx: only reset stable pstate if the user changed
 it
Date: Mon, 9 May 2022 16:03:35 -0400
Message-ID: <20220509200335.482514-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71c791aa-b37d-4212-d805-08da31f7100b
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2479:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB24799D1297F006084D6764B9F7C69@MWHPR1201MB2479.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YA1zIt6dljWBBpDHM0sfO5/WcKU6RdN1UELLVXvfLLhfs2EAKSdTomYaZiX+ZIdYE8hHYYgL7RGESE+3dLt1cpygLYVyu/OhyfBD3h9XdBYcJJbjRKsehbJBQWgBg27TdQ9cMYdflqVjPhW1DILNXM0FgnDzpb5Vrb21jZkDkn3t7q7mn2K/SxEGKU/JUtj+pA1+s5s3FRSaCPM2i0zU08MfGLhMyCCRP7DJ2T3ikpTO3JNCWMagLvdraNcgNslMpkD+HImSIOdpMCB0QStp/AbWvxlfa1eRN84D5N8ThPDm8ml1w69xkQ25T/MM26AW6zVBqslaBuwDHGRpQ9QJIP5h0N6oEJMNmwhZtdaWMi7IIpP7VZeN2/7aH+1LRPhdPYREwXIh7wU2VV+8H4tW0dRIYipmtrEEC3ps/9PjohtjxmmuhGbFN/q1f+wLkZpi5IJ1IsbkKv3rLTT3S8RYN8qM1/k5CZ3iQMnDhqGI+62Ndk/vX3Ea436FrgXJQnfClJSLUy8Jt3xjsZx6O4airH0HQmd5M9y9UqfuEN3MSYlG3nFoESODwxYCz1mZXVwqf1uA7C6ewgO2VVsnjxNDBTMjH1nSDesB1dbRFce1BmN+E4iD7Y/Q7LU2WHZ4M8eexDnQiFC+ppPE+F9bi5Yu9psAiVc4G2QceNTYYlhLtdQoXP1vku2gLETJBBjE6/1YaxiRZca5D13CPtQ9lSf1ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(36860700001)(316002)(36756003)(1076003)(2616005)(6916009)(83380400001)(426003)(186003)(16526019)(356005)(47076005)(40460700003)(82310400005)(336012)(4326008)(70586007)(8676002)(81166007)(26005)(8936002)(70206006)(86362001)(7696005)(508600001)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 20:04:02.1460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c791aa-b37d-4212-d805-08da31f7100b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2479
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

Track whether the user requested a stable pstate via the ctx
IOCTL and only reset the pstate on context destroy if the user
actually changed it.  This avoids changing the pstate on contex
destroy if the user never changed it in the first place via the
IOCTL.

Fixes: 8cda7a4f96e435 ("drm/amdgpu/UAPI: add new CTX OP to get/set stable pstates")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 5981c7d9bd48..e4b0c6ec227c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -330,6 +330,8 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 		adev->pm.stable_pstate_ctx = NULL;
 	else
 		adev->pm.stable_pstate_ctx = ctx;
+
+	ctx->stable_pstate_requested = true;
 done:
 	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 
@@ -353,7 +355,8 @@ static void amdgpu_ctx_fini(struct kref *ref)
 	}
 
 	if (drm_dev_enter(&adev->ddev, &idx)) {
-		amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
+		if (ctx->stable_pstate_requested)
+			amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
 		drm_dev_exit(idx);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index d0cbfcea90f7..f03e842209b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -53,6 +53,7 @@ struct amdgpu_ctx {
 	unsigned long			ras_counter_ce;
 	unsigned long			ras_counter_ue;
 	uint32_t			stable_pstate;
+	bool				stable_pstate_requested;
 };
 
 struct amdgpu_ctx_mgr {
-- 
2.35.1

