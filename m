Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E0CED7B8C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2026 09:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7824510E5CC;
	Tue, 14 Apr 2026 09:00:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xbKN5dDv";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8713010E5B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2026 09:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7E34PnuRqBz5G63cw6IaliiDnfZfSWyetkfP/6XRyGDBmFW4j3XULf1i+JT5l/mpdW+VV7QFK03eZQ84vKm2YfHVlT26sKEFaaEAv328RHKkZLmPvF3Wxhu16g6qVBIV3QulLif1otWM/gIChreuuaW/2stWCRXQxi7K7yEipdjWDwpgsgsy7rXnGgun9rgJ8fIgni+V/LYqYrPHD1Sxn2wRccrhaxM/cpNp9OUHznVA+bKwDnw4rstO8iMDoXtcJie0QAwFhRA64wA6x4ALprIm7wqhx/lDq1WXdApVzl//NpCU2g8LZt1ZLCUuOIAG7O7EsXvnZJzT2ZJAYJTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vx7UcTr7C4EZ8L3mHwm/FAUZzCDqBp2rWxTNdJ9d+3Y=;
 b=bE+tdtxOd4tZxnf6IeKFZ9MPWvuC7imrs6SLbn2oehnYjzUrH1SdCGhii3I1p2tO9pycxBQ6L3hEoc0Ely4GejR1791/mliCrAVIgbEehWaBjWLxzpoBYqcSzpf3bnBjmqkMubBYcIhuwT+8dEjwxbRfS1hateouzz3Z5PIYgqmaoAE24JkoC4FXFXxceSDxqTszdgkhDiXMpo0uiG9zEl0uozkjJ/DVpNswx9LTdxNAOylmN2YNS0jD5My+UsFQpuEhGniy1EZtIVjQcNjRdlTUiphRl9gwWOaeCL6shBKzKe5OawgQblAqeZHA9/tVWSx++Fx+J4bIq1TApLgXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vx7UcTr7C4EZ8L3mHwm/FAUZzCDqBp2rWxTNdJ9d+3Y=;
 b=xbKN5dDvElF/BhY3hpa/1Y0n5Qx1VH3vGc9KljMcsrewj6epINcroU+Muz2pd0brH55MWB4tqPu65EwNylAdTgWO33O5va49OB2lEaUyys+XbP4zuTtfh/yk30HWeg12w1IB6J6W61/68IpacQyNSZP9eKjXemga/UXcX0pAlVI=
Received: from SJ0PR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:334::20)
 by CY1PR12MB9625.namprd12.prod.outlook.com (2603:10b6:930:106::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 09:00:20 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::e0) by SJ0PR05CA0105.outlook.office365.com
 (2603:10b6:a03:334::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.46 via Frontend Transport; Tue,
 14 Apr 2026 09:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 09:00:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 04:00:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 04:00:09 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 03:59:58 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 4/8] drm/amdgpu/gfx11: enable per-pipe reset support for
 compute queues
Date: Tue, 14 Apr 2026 16:58:51 +0800
Message-ID: <20260414085926.3171086-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
References: <20260414085926.3171086-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CY1PR12MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db4bfbd-629b-4f1b-239d-08de9a044019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pRUAZl0qQRoT5n7mT41feFhGUOnzJMF6MwtJq+w8RDq8Qy0ku4QNVGZX1AfgsuIaY0GPg37aeY/Wnx8X+Y380oSi0MNeTSZnLwzcRPU6OC6yUNxthRjz+gi36vDLP7T9gCcAC5Io3M4hVFps2WGbSgiOpnvkBoeBi8Y65vpD3agxfDQyqv0Cb8s+o5LtuSvw0syNpU2KbfI+S61sdeMnV6o59FhSCb3NseVgQ90y1N0QQ55yuqGgpS4lcXRey+Q/MLElOfOm1wLRInlbDQ+5BO/pjyXjoUV6FGOzyQm4f1Src9IsxZ3Pon4iHS9Twa/2wuLBNA/I4Nw6sC0Z+MFtgX7ZqR75/NQ/bew1qagT6hANkg+yCjc8F0Ecpo/A5YHX4yJJydjBVQsUuuz90D4TNgLmzdJoXUHOPTwewNBD35ldpg/KtlYpYe9sRJdEqxZjnehl+BHFYM6NHlhsm9F+pLJlUIKK5kOFkwIO2WDsSZBGEaCXjG+iXddtoZuKWIrlMT4OEvBoW7gL7Iqh2Dk+cnFnkjlI5IPdK1PifyUt+NSl/3g1Z8d2b53k5kjuJi/RyYtbLwaECDJP1SXnZhuENMP+i3AyOlfp3iSzsMChKEXffAnxvSih1bKqO/UEy+jIO9TSLkWADiBZtmIdWlpTbjK5Z96QPE/rtheHU2hgZlOpBh0/TvwlFyUqYNfJbAh68gIv9WM2u9YL9M3dLh3ugR3XVy3MBx1uEDlz8Q3LjCXMGQ2bkvkeNGrV7sfNPOdzugNI1QAe21EFhxbH1m7Pxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7sJq/0Q0Dgoz3DLb6cJSPouyHYXHczUrWFJz383zRBPoho3jLWz9dkzdWhLx/UZrfFNXeNgdBo14rDQQslKA7pmvVu24wjA7hFk9AmWFIGh/lmzJbtktuWZxw7tzdt1SvaMKw9efzhlNTzHssq1QM2v6iq24QpkaDI3M7RZNVTUU3PzMSfIqN0WJ8GiynFQjaRv8K7Wz/4DlSUclfpqQ7VPY5hC26f5WOcgkBtM8CuaM9QwMXI1xx/yNzSYWUWZqjvAcast47QiE11Hy6b07PpvEgJenVQTg9L39uzjMpj4AHJiAbI533Pa5Ct2JyITkKyLO/YeX7qJ1bS0pxTmI90S61H76gRf2QJQ2cZ8e6FcxyxVkzTqNxR89w2RAyn55e/y7puKpTO/wMAR31nGgQclW5OMwYPi9G5tgSZaPLwm9IPh+yKlavfKf6S4klzn0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:00:17.8035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db4bfbd-629b-4f1b-239d-08de9a044019
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9625
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

This allows the driver to fall back to pipe-level reset when per-queue
reset fails, improving recovery success for hung compute or graphics
rings.

V2: replace both gfx_v11_compute_pipe_reset_support() and gfx_v11_pipe_reset_support() with
amdgpu_ring_is_reset_type_supported (Alex)

Suggested-by:  Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index fbef19ed46f9..d2e8c50f8fdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1851,6 +1851,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			if (adev->gfx.mec_fw_version >= 2670)
+				adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	default:
@@ -1858,6 +1860,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		    !adev->debug_disable_gpu_ring_reset) {
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 			adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
 	}
@@ -6807,13 +6810,6 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
-static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
-{
-	/* Disable the pipe reset until the CPFW fully support it.*/
-	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
-	return false;
-}
-
 
 static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 {
@@ -6821,9 +6817,6 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
 	uint32_t reset_pipe = 0, clean_pipe = 0;
 	int r;
 
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	gfx_v11_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
@@ -6884,6 +6877,10 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
 	if (r) {
 
 		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
+		if (!amdgpu_ring_is_reset_type_supported(ring,
+						AMDGPU_RESET_TYPE_PER_PIPE))
+			return r;
+
 		r = gfx_v11_reset_gfx_pipe(ring);
 		if (r)
 			return r;
@@ -6941,9 +6938,6 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_device *adev,
 	uint32_t reset_val, clean_val;
 	int r;
 
-	if (!gfx_v11_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	gfx_v11_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc21_grbm_select(adev, me, pipe, queue, 0);
@@ -7085,8 +7079,11 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
 pipe_reset:
 	if (r) {
 		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
-
 		reset_mode = AMDGPU_RESET_TYPE_PER_PIPE;
+		if (!amdgpu_ring_is_reset_type_supported(ring,
+					AMDGPU_RESET_TYPE_PER_PIPE))
+			return r;
+
 		amdgpu_amdkfd_suspend(adev, true);
 		r = amdgpu_gfx_mec_pipe_reset_run(adev,
 						     ring->xcc_id, ring->me, ring->pipe,
-- 
2.49.0

