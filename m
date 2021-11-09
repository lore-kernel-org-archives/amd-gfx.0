Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797CDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 04:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401576115A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 04:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 401576115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD2F6E42C;
	Tue,  9 Nov 2021 04:55:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608FA6E42C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 04:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYEQmvAE4IoC50XgCbTR1jDg+El8ywQb5Lg1EzZSyaR9QMYRbEg3Yg1HVFY6TeGn+2EHvFgvxSp/qqUyb7p5J1rOohedPS+yTFOjzyIlzBvHPjm+0EozA0MJSJWrgWQejCBK5d5AiagzcnfI3LSdVm12d35xyiO7PIK7HrrWHpgI07HPg3aoAVcg/+TVwa6wYJbWjFIhMeo7KDA1ZJNK305Vy8KyuOamlN0im4CaqzkkcFWOTdAePWBFs3GlWuGtCbkkF3wG2ZE9F9lh8uph4lSg/fQK2yXncqGwcZTDj9yTtI/cwnGioy0bBftznXnOpkFdbo+VgwexQ7GhrCTYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7nAsXmhdK8qbQ3ddSkA2qFVHv3CkmRJvmP7NJwZkV0=;
 b=PlUJ8jZ/fMB7tm3hEPQ7Mxg3/C7OWEJ2RxuPSI7sjA8MHYP5mMR3RCIo6q1+D5I9wCiNpbY8+54jzElikECtes5z80QsFDkKr0PP+LNtKzPg95HKuVUEMqBigzGQHKiZriYbuZpsuD4mvTsqtIgYf+lhHZ7sN8YzKnVsTApHMipKHkjgQBqCpaWb8ONbL/49HJsvXsgJcW3tNQoa8aZirQswgJwQAXASgVfpIMn1oJqN5I//z3gTwwmPs5KuJNEOdkLUg3FoTd9HBArcs4TLuPWvYPC5E2iswmZ/NVZFd3SwJhZADGPmp5jzwTYIYgx9xdspIrtH9tB69ptTaGlDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7nAsXmhdK8qbQ3ddSkA2qFVHv3CkmRJvmP7NJwZkV0=;
 b=hUchSh7r/yrVfKt9y85aKq7alEqW8Jl4Bai1dmHVlM+UW7LPMqzTiic3ikqqGaGD8JjRHYQz0NufcYdQDPw757Ou5u5u97u3QVAEvpr/DQwWCKF4yMByg4nrO6H8wBlp6gVIKpjI2EkB0ckh/Rk2zaJ5akzPA8o8STCPDEL9+ho=
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15; Tue, 9 Nov 2021 04:55:14 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::9f) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Tue, 9 Nov 2021 04:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 04:55:14 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 22:55:10 -0600
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: reject both non-zero src_x and src_y only
 for DCN1x
Date: Tue, 9 Nov 2021 10:24:54 +0530
Message-ID: <20211109045454.45550-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56722a46-eabd-4520-5930-08d9a33d1e0b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5415:
X-Microsoft-Antispam-PRVS: <DM8PR12MB54157957B85E99D43853C59EF2929@DM8PR12MB5415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erokNui1E8vN212Iwa5dE7mb5qvx4/1s/yUKFFqSg+t9ck5Kus8d7IL4JB4NpUJtm0kM0qDAoO5ViHEEgcAjV5JIptRsEhgojMdQvoxZGKIbNAmIn7S7alWPk1UWtbgT5fvbwCw3DOM0qQsY28bawK7pSV2lnGp2G0M4ZzrDK35TnHp1Nmk8oP9H5gIAiN9LVp9nIIVd26kuxNQi+/sQDwSQQcC6CEa3Db2m7o4ZbwrfXlYYlXJGs2AEgF6LARzY9QeuuWe+Zl9LhLmXHzebiyYCnqDPU4Mv3ZxzEoB2TN0JdlUxMKjgJEjWZQonsZiM2L91zpjhd+hDyUvnv0aXVR92VmtftHLm9p4HYK5MJlwCtWFBRgTZZJ/IzL9wF05P2eIxzKwobQr6SnQ/kKO7sv2Hu9cVVwtnWQYQtZXu3TgPXMvI6Hvjy97dR33Kx/xF//qYu2Uuk2VRNsTlREV+kDU5IOyytem3aaXTo5SELwAe8EiCY45JGHvWyfJoDPWfuD+RjO2GsQhVH5vhpEixm2Lbix8E0ImKGZNu6A8HjjdrmXvja2KnT+vyYGGK0Ic1ytmGzBA12R5o9g+i5kBQWv5oFFlplbhdW3Zr+rfp6KgP7Z2KjrbXrI3qDZllyGL2VkwuWO04XUSMygQnjTLOztrH5YYSEioKD8yti5vBhRvP8adNr1HJcPFstAjQ/3mA60AOd35+z9OaIdg+Slg0EXHpvSOIdPn2zeckqkgiCRZg3IqQg0bbBg8IoCiA1FdliYEeBp6Oc9Qk/8BmMxbbJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(26005)(6666004)(5660300002)(54906003)(8936002)(6636002)(316002)(110136005)(186003)(16526019)(8676002)(81166007)(336012)(70586007)(70206006)(36860700001)(36756003)(83380400001)(7696005)(82310400003)(47076005)(4326008)(2616005)(2906002)(86362001)(426003)(1076003)(508600001)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 04:55:14.0279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56722a46-eabd-4520-5930-08d9a33d1e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Video plane gets rejected for non-zero src_y and src_x on DCN2.x.

[How]
Limit the rejection till DCN1.x and verified MPO, by dragging video
playback beyond display's left (0, 0) co-ordinates.

Fixes: d89f6048bdcb ("drm/amd/display: Reject non-zero src_y and src_x for video planes")
Signed-off-by: Shirish S <shirish.s@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a54ccb794f9..00b3ef41b752 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4581,7 +4581,8 @@ static void get_min_max_dc_plane_scaling(struct drm_device *dev,
 }
 
 
-static int fill_dc_scaling_info(const struct drm_plane_state *state,
+static int fill_dc_scaling_info(struct amdgpu_device *adev,
+				const struct drm_plane_state *state,
 				struct dc_scaling_info *scaling_info)
 {
 	int scale_w, scale_h, min_downscale, max_upscale;
@@ -4595,7 +4596,8 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
 	/*
 	 * For reasons we don't (yet) fully understand a non-zero
 	 * src_y coordinate into an NV12 buffer can cause a
-	 * system hang. To avoid hangs (and maybe be overly cautious)
+	 * system hang on DCN1x.
+	 * To avoid hangs (and maybe be overly cautious)
 	 * let's reject both non-zero src_x and src_y.
 	 *
 	 * We currently know of only one use-case to reproduce a
@@ -4603,10 +4605,10 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
 	 * is to gesture the YouTube Android app into full screen
 	 * on ChromeOS.
 	 */
-	if (state->fb &&
-	    state->fb->format->format == DRM_FORMAT_NV12 &&
-	    (scaling_info->src_rect.x != 0 ||
-	     scaling_info->src_rect.y != 0))
+	if (((adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 0)) ||
+	    (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(1, 0, 1))) &&
+	    (state->fb && state->fb->format->format == DRM_FORMAT_NV12 &&
+	    (scaling_info->src_rect.x != 0 || scaling_info->src_rect.y != 0)))
 		return -EINVAL;
 
 	scaling_info->src_rect.width = state->src_w >> 16;
@@ -5512,7 +5514,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	int ret;
 	bool force_disable_dcc = false;
 
-	ret = fill_dc_scaling_info(plane_state, &scaling_info);
+	ret = fill_dc_scaling_info(adev, plane_state, &scaling_info);
 	if (ret)
 		return ret;
 
@@ -7575,7 +7577,7 @@ static int dm_plane_atomic_check(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
-	ret = fill_dc_scaling_info(new_plane_state, &scaling_info);
+	ret = fill_dc_scaling_info(adev, new_plane_state, &scaling_info);
 	if (ret)
 		return ret;
 
@@ -9023,7 +9025,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
 		}
 
-		fill_dc_scaling_info(new_plane_state,
+		fill_dc_scaling_info(dm->adev, new_plane_state,
 				     &bundle->scaling_infos[planes_count]);
 
 		bundle->surface_updates[planes_count].scaling_info =
-- 
2.17.1

