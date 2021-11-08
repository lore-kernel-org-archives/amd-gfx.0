Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4B8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B253A6120D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B253A6120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C9B6E457;
	Mon,  8 Nov 2021 08:15:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B999A6E489
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 08:15:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq9B0GyCrS4bPdN6exxWz9i0pdw7AtKK6sOx6ZOiLLN9CDKTARzyT/2uu+YwteJVW2U79Uv3pFuKOZsYqMGmqphbr2zrq4CrmMQ2u/x455/k7nbXxn+R/TVw4UQFQU1FAil6sES1ujJvj1YFTN/EeQlGKOD6C2vOcZ44bpMmJrMNxywzK8gE79vCv1T4S3Z9KDX73NLd1wTNsQD0jq+9+gyHWHHwe6BbGOr78cC2kAgkzDW6WE5Zl9g+YRkYDMV6LvjAPuicott2W0wUBdAW/UZ5twWf0/abVq7vuyHBSNtuWVBdPeDQU6OxAITnr1vxy9Gdrho5Bv8nxsRwNyYN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmR9iWOjxBvjw7t5QZWplo7W6rNCMCV3Es30+YvhgqE=;
 b=lQFACkJXWGSTLfWATJhm1B6+3fhH0PqfLeGD1Jvgsu9omkq2npG7DN6VcmHbaJZSDp2Hg37F2AnM7R4qy3WMZcfivU1bYrSruld2VPNfAVQ/kNwitwq5YNRUGf9EN4dnJzofIsf6BbNhlQmpuns6QwiFMvzstDdf+Tv0XQ7+ttxbd0pyzYctwUq+8uQ7oe2xxkb/Xo0MCjkCqYY7TNXU/YAgDHE2A8AeDXT/kQyrrUrRack7RuaaghutWD6sVGkdOQjlmB7C3M5/Y91KrsVpvO9SFplNdETiyVkTpxTEwhAFAx66R0xJ8z07e+vn2E+IEt5zfiQYkvn9I/mhxULThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmR9iWOjxBvjw7t5QZWplo7W6rNCMCV3Es30+YvhgqE=;
 b=EwU9JZ3B5bt6YcvQPRbV2XuPVz/4jfAb+c/i6H1uekBM7RJbN0o05fksPzBAE91YDgkoU988S9u7o3qj2Y9Pz/LPYv3MDrO4jY5h958pxi8U5GdIIae4rFXKRMM5XOullHtvyvAVECO80Jj3vTEeBSEIPacdeJytdWFNnBNlWhk=
Received: from BN9PR03CA0317.namprd03.prod.outlook.com (2603:10b6:408:112::22)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Mon, 8 Nov
 2021 08:15:37 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::a2) by BN9PR03CA0317.outlook.office365.com
 (2603:10b6:408:112::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 08:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 08:15:36 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Nov 2021
 02:15:32 -0600
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: reject both non-zero src_x and src_y only
 for DCN1x
Date: Mon, 8 Nov 2021 13:45:14 +0530
Message-ID: <20211108081514.9925-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05d5eb30-034d-4746-491f-08d9a28ff1a0
X-MS-TrafficTypeDiagnostic: CH2PR12MB4295:
X-Microsoft-Antispam-PRVS: <CH2PR12MB42954F883E1AA5B5D53912A1F2919@CH2PR12MB4295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uh4wEkiUrGyoMI72U17ehAR/nvzuf3x8EPPEiB4cMMWRXr3G/k+8Wp7lSv4SszhuyG2AdZcriDFrIwyeU0GxpS+QxMVzoeLrTf+XMXysaQhQd6okZXgM0smn4Sw7fdsJY3GToMEUkjJkOVBNohhrdbX+vj1D3E1iOD1Bk17Ztt1kBXZS3dP13/Gx/dg40OxX8J1fQa0TdXFy+wPLjWjzQ8GsVQIOy3BTIkkDroszbifHxEt/2A9SEbWoMTxMZYrTGhfkh/Ev/yNeZ+HwXa0s+UTQZu45KKqkPqiBiBcA2nOnmgoKiSp2CCuxF1DRQu1oscfJRPpnKsjP8m5vXefpvLSEepTfAAl7Enbj8gtqdQ9fU/2zNbO9AZXPIZoKTQKcsmLnVbCk3qM75vPUDtqMwLA75uwKmA/jxQsWFe9fhounZZWEJXahbTeyAkXAkC8D8z36oTUp6VgFKZo+MMZ9b9hIooIZl/ew2pX18NLwU/fw2yc9sQWQvY1Qk6M7IKq0I/VJs8Tq/fGorUH2HhrBqC4Tzms0tbvExTjs+N6W+j46phnhoD4hPUaLYptXc4YXUu5q6aRjogQw6HjO6Cpn79i3lLGL9ZI2t/htN4P5vbGgEbHf4bZxtMYdmR/nS8vGTnYtqcovnEm2x8yClalR0odWbNiTW+ZEbkhzs4GvynSVmEsk1hLY+SojzqGG2wsuJQsD3HASlCuJ1BdkZzMrTi75n2UkXTPGn17m3UVYqw2+YWL/fSMMq5Cqnrz8gW3pLwwBtUS++UQelXB6jpN5hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(26005)(81166007)(2616005)(508600001)(83380400001)(16526019)(36860700001)(6636002)(47076005)(356005)(426003)(7696005)(8936002)(36756003)(8676002)(316002)(82310400003)(6666004)(186003)(86362001)(54906003)(2906002)(1076003)(70586007)(70206006)(4326008)(336012)(110136005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 08:15:36.2905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d5eb30-034d-4746-491f-08d9a28ff1a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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

limit the MPO rejection only for DCN1x as its not required on later
versions.

Fixes: d89f6048bdcb ("drm/amd/display: Reject non-zero src_y and src_x for video planes")

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1e26d9be8993..26b29d561919 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4572,7 +4572,8 @@ static void get_min_max_dc_plane_scaling(struct drm_device *dev,
 }
 
 
-static int fill_dc_scaling_info(const struct drm_plane_state *state,
+static int fill_dc_scaling_info(struct amdgpu_device *adev,
+				const struct drm_plane_state *state,
 				struct dc_scaling_info *scaling_info)
 {
 	int scale_w, scale_h, min_downscale, max_upscale;
@@ -4586,7 +4587,8 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
 	/*
 	 * For reasons we don't (yet) fully understand a non-zero
 	 * src_y coordinate into an NV12 buffer can cause a
-	 * system hang. To avoid hangs (and maybe be overly cautious)
+	 * system hang on DCN1x.
+	 * To avoid hangs (and maybe be overly cautious)
 	 * let's reject both non-zero src_x and src_y.
 	 *
 	 * We currently know of only one use-case to reproduce a
@@ -4594,10 +4596,10 @@ static int fill_dc_scaling_info(const struct drm_plane_state *state,
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
@@ -5503,7 +5505,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	int ret;
 	bool force_disable_dcc = false;
 
-	ret = fill_dc_scaling_info(plane_state, &scaling_info);
+	ret = fill_dc_scaling_info(adev, plane_state, &scaling_info);
 	if (ret)
 		return ret;
 
@@ -7566,7 +7568,7 @@ static int dm_plane_atomic_check(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
-	ret = fill_dc_scaling_info(new_plane_state, &scaling_info);
+	ret = fill_dc_scaling_info(adev, new_plane_state, &scaling_info);
 	if (ret)
 		return ret;
 
@@ -9014,7 +9016,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			bundle->surface_updates[planes_count].gamut_remap_matrix = &dc_plane->gamut_remap_matrix;
 		}
 
-		fill_dc_scaling_info(new_plane_state,
+		fill_dc_scaling_info(dm->adev, new_plane_state,
 				     &bundle->scaling_infos[planes_count]);
 
 		bundle->surface_updates[planes_count].scaling_info =
-- 
2.17.1

