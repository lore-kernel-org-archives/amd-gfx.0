Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C5CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 21:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD08E10E150;
	Thu, 24 Feb 2022 21:46:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C820110E150
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 21:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8NkE8y9nnium3ymPQA49azo6QU5BX3aOGKvyHDHtl4OFWV7CmYgG+o0c0NPUnviQ2j09S8/6txaaIMdKamUnblucUbFv+dP+srnJhxdj1Nv9q2c/gyy2s9+EYQUg5RJovYwjZ0HpQuij23i+povWNfc/yYjlTlkBhNL8pmUh4k+DKlkV/jjUE1bqepXHYcNe8V0NNkNPLxASVG7n8WtZo8WBnRtIneo78O8SbWnSvoUryzW5xxAF+zpCI1I6JjK9kszbfGQQDQR0A23u81XsqbxZllGrJl/l4WGjtw13DlpV/KO0lrlq1Hr4mQg0Zjrjg9cqgzkzwTV8FYvjBru5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn0PxcSR/JgHvpMZjbsA3SUOIhLmnj1Y8bqkmpl3o2w=;
 b=EWmOF9vUPw7d7j7xA0S8qgJDiVm87x1VnSzHvdeTpk//U/87e7oyPEGTvSkXLLmE/TG5fn5Nvv5NFyE8ZZxWlBYtGY2y3XmVUm2W8nihnD5HC4Pi1u4p2LPt5VjNxgZQu1xZCNETm6DT6P8lcCEdFn7cnCmyLjNH7WCjIFoVb418ko0w/dtXB3qJ5qCiyEWJ384t9UCehL7Dhhn7NMmKcKBTXyBwABa689ylx2aIw7uvO8+BPRrjuszcd101UMz5eFmQqCDcnNlY0BwbTWmB+yUfqA6P9oTmL6JbBstfPlUbzMLHBXTvDz0slZS0Y65A6P/0cGkuXTs8UkxYnRhfKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn0PxcSR/JgHvpMZjbsA3SUOIhLmnj1Y8bqkmpl3o2w=;
 b=KlBHlRHFQHEu/XFgdhh4rHdnN9ZVU6haBShMMARUfGY0YbeUOAnYzXBcrQ8Pvcr3Sc+YQrKxrcp8kyPFS8lxxKqsjzlkaHPFfwl9AgbGNgksxyGvjn9fwR6JDrVadll4q1uMHrdonTl5thXk9x0xrfDGT0fauwGsFzF+8LaqswY=
Received: from MWHPR14CA0067.namprd14.prod.outlook.com (2603:10b6:300:81::29)
 by BN8PR12MB3140.namprd12.prod.outlook.com (2603:10b6:408:67::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 21:46:25 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:81:cafe::46) by MWHPR14CA0067.outlook.office365.com
 (2603:10b6:300:81::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Thu, 24 Feb 2022 21:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 21:46:24 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 15:46:14 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Don't fill up the logs
Date: Thu, 24 Feb 2022 16:45:31 -0500
Message-ID: <20220224214531.6397-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.129.gb80121027d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfe68556-59c2-42c7-a458-08d9f7df1a76
X-MS-TrafficTypeDiagnostic: BN8PR12MB3140:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3140AC76AFC45C6BAB3A172C993D9@BN8PR12MB3140.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMIxfLqFtKXYWEfTQ3ZOmHhGdQpAn2gVhOONEI0OlJWUl+Dxli3dKY7ACyOIx+MEr5SK9ZjTUZXfYXk6LD+65ua4GCFNKwePTtTfccDfor2dQQSlVNrACUtdeJL3P7vzM3r3xVMYgU5rZueNvjkRZfB2BSk1V+xrXXiKkZqwSlegpYfCw/8jo6C06Wvva7ffYyizYpbOcGu9RgKfAcLMV/+hhf0RD5WSPUwYVMMVNy8udO+Nq8TlZiHDUkQ0t5PzWKIwsAojrnq0FR9TrScifkxa2V2Mrqs5t6h3aBgKmJNZJZyO1Q7W0S7KuD6GIXkclpBcjrRJWNrDrJPGo51p4GNQG3SOMtdTU9FERfxwXJ/xYlLSLOIE+sRK94Ku5dNh2CLt9g9wfZNtRgYWv6+Hmpf6Jp57WyhslHhHRbyCT5qzYzZHCit9K81RZ7UyS1bXYOrDahcUe0LFeG1VWrnV8Bx96nxGcesRcN8KNxFwbgHXnjD2thfvKGycW6w5GwUiw+pCYHrwBG/Sz33zNiuShJjShacLpHxLOoVpjSXmyV6OE5WUOiqf61ikf4lMivOQwilC7/kk3ygxCEg8VUip0Yb7M+4lXVBj1Q/idFl1qMuKRSQwpL9E7+g93+fP70Z9CjAANsuUbLqmZsy6JKByJL/dPdY6yIWru+WgVDuvofffhQYfl7UrHYbkIuJnR39uJ8zeV56fBeM64ct5DWuB8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(26005)(186003)(2616005)(1076003)(8676002)(6916009)(54906003)(70586007)(16526019)(70206006)(508600001)(82310400004)(316002)(86362001)(6666004)(36860700001)(356005)(81166007)(83380400001)(426003)(336012)(4326008)(47076005)(8936002)(36756003)(5660300002)(40460700003)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 21:46:24.1667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe68556-59c2-42c7-a458-08d9f7df1a76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3140
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
Cc: Felix Kuehling <felix.kuehling@amd.com>, Roman Li <Roman.Li@amd.com>,
 Hersen Wu <hersenwu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't fill up the logs with:

[253557.859575] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
[253557.892966] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
[253557.926070] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
[253557.959344] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.

which prints many times a second, when the kernel is run with
drm.debug=2.

Instead of DRM_DEBUG_DRIVER(), make it DRM_INFO_ONCE().

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Roman Li <Roman.Li@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Hersen Wu <hersenwu@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Fixes: 5898243ba7acdb ("drm/amd/display: Add dsc pre-validation in atomic check")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 05573f073b21f7..0542034530b1b0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1198,11 +1198,11 @@ void pre_validate_dsc(struct drm_atomic_state *state,
 	struct dc_state *local_dc_state = NULL;
 
 	if (!is_dsc_precompute_needed(state)) {
-		DRM_DEBUG_DRIVER("DSC precompute is not needed.\n");
+		DRM_INFO_ONCE("DSC precompute is not needed.\n");
 		return;
 	}
 	if (dm_atomic_get_state(state, dm_state_ptr)) {
-		DRM_DEBUG_DRIVER("dm_atomic_get_state() failed\n");
+		DRM_INFO_ONCE("dm_atomic_get_state() failed\n");
 		return;
 	}
 	dm_state = *dm_state_ptr;
@@ -1245,7 +1245,7 @@ void pre_validate_dsc(struct drm_atomic_state *state,
 	}
 
 	if (!pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars)) {
-		DRM_DEBUG_DRIVER("pre_compute_mst_dsc_configs_for_state() failed\n");
+		DRM_INFO_ONCE("pre_compute_mst_dsc_configs_for_state() failed\n");
 		goto clean_exit;
 	}
 
@@ -1258,7 +1258,7 @@ void pre_validate_dsc(struct drm_atomic_state *state,
 
 		if (local_dc_state->streams[i] &&
 		    is_timing_changed(stream, local_dc_state->streams[i])) {
-			DRM_DEBUG_DRIVER("crtc[%d] needs mode_changed\n", i);
+			DRM_INFO_ONCE("crtc[%d] needs mode_changed\n", i);
 		} else {
 			int ind = find_crtc_index_in_state_by_stream(state, stream);
 

base-commit: bff980c7632ef3b0099ba230cf7d5c864db3e1a3
-- 
2.35.1.129.gb80121027d

