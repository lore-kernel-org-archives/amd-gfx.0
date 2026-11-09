Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED36606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nWILqZpe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67FBC10E571;
	Mon,  9 Nov 2026 18:43:41 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E4810E571
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viwM2VCbAk9HlZwLl+t23HxJ7E8cf9dCCLrxEI/z2HneOWcO3amuRd82dKrdmEtAdfzd7qsrFSecpfUwuzUvwG8ZSRmCBZ2ci2C3Xgw/a7sRPYunXJOcqLpnhY023giY1YFQ7bnxdJR1jrRcYYzQPWZWYyAQ4OasjkN5VbjaKZD+aUzAW2DpraSL+plB+m6fIZMcyo6DhrmFa7eHg0mdrZt1VqMVpK9/cLcz8us0R2WpubW7Nk0GPXKiNAGVUffmzOgnOkedIEgfpqNTbRIogtxN5rfm8fXV+t2+idiL1Cd+ugaveEd8eXOcCJeyUIq77Mv9BGUE9SLI4rerBfod0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6Up+k48LmARWXgQvNTYF6Vn+AshVKf3HwPypbbdkkA=;
 b=PG9iERLrolsXbmYHBMtAeafakJCZRwDuuRzC3h/OEsxyfaAf/T9ZfXVGNKDVSBR3INw+t4Oqs2nzYPsi2w3sB26v2QoG7n7pBFb1yfdnjWssDRrerqQDrHgSC4LUG1qQYx5Na197oNILLmNYv1DJLAVveQ2ctBlh5o3S1P8IhvhJa2JhnFVzKOrgghMktUnyMbYZROtGLdEcUFEnMnedu4j8/cONoCeuTFJy4Tc8UoSKBXp/mUH8udWw9O89woaTbYGtfhaT585b60vaXwtlYWXSprOiAWMzKdAzmFhFLzGQfLHjkZPdRwBvnBKFOVI+Ybm5WZdnEhWknoAsUUvAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6Up+k48LmARWXgQvNTYF6Vn+AshVKf3HwPypbbdkkA=;
 b=nWILqZpeBAFgdpMNaMSwbwJGUGmUjCbQYnCMW6W07rv9GuNauOBf77hIQqqGBAah/dpyrgng4V1c9GK3o/hdOjTqNSOPQTs2CPE76jjMSWS66QwNwnQnv6PFuXgbMwuzv7WnaEzVIJ+RC6x7SyUhGRRXMsxTTwoKxOa0968ZKFU=
Received: from MW4PR03CA0031.namprd03.prod.outlook.com (2603:10b6:303:8e::6)
 by MN6PR12MB8489.namprd12.prod.outlook.com (2603:10b6:208:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:41:28 +0000
Received: from EA8PEPF0000000A.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::20) by MW4PR03CA0031.outlook.office365.com
 (2603:10b6:303:8e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:41:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000A.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:41:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:41:27 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:41:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update mes max sdma pipes
Date: Mon, 9 Nov 2026 13:41:11 -0500
Message-ID: <20261109184113.3656539-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000A:EE_|MN6PR12MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f86b0f-e331-4319-0ef8-08df3e9110e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006|261021121427099003|261021123027099003|261022105027099003|261028144727099003|261009223027099003|261026140227099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: YuNcXbf7Q9uKfC58qSVdu9U2ca6UFUZuR5Mbd1JHjfxJiyY80YAR6I2jyHnh33oeL+7Cze2tZgM30u9M+1fl4UmiAsjFEn+bWmiVKEVlk5d83QKs8AnLzioHl6VEocNBCa6bUwcz0j22YHvojtrNYjkACo6vkrck1mSFpHRg+2PZRbJNn4JTQW6Mf/PHzrmlWXAM9w5ZoBGSynNmGtiOSNqrKGViTZsH2SBzDO2MI0HT5grgLRiq902oidFJJ0bMXB1VOz2Mhx62qBbAYpEtSz7xie/fLmbQdqVjNKbUvfAuONVPraH1D+nwsnexRcl37kZKfEacgJ4trrX9nU7GoyRMFBR8bI70O4aRwDVTbBQrD1hlgn7BJNiD18dWSQ5m5f40Rq6M25E5cd3nO4caa/x/rsc0GyqHJW4983jkhL7mjeWcsjvjBx/WLC86+a8jusTiiIjwtCh1CymFVIl/P34uZTLwBXmzWycN/sZN7J4lm/Z6dPo7/fmcifAK0J7rBghT0uEFP+1edKZ07NPU9TkhGFg5P65AwoqX4Uaawc5Fi/Y0nhHf6aYn3lflFgDeRA2snfe/vtf10Ag15OBAB8gvDhZyX4ioPAlqABnZE80udWb/APJltMqgLa2lNp0OCX+tAEs6I1eSxPcvx2e7KMTzMnipNGRIf5KeRXrQf6A/v1MQYE4Xh+VZRloVBKpcA11ADKBGTqeDFzLw1o/naw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261022105027099003)(261028144727099003)(261009223027099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pW3//ulpIV84tj3Ia/3TJ2AzFMBa/fd184uhGB74zPKy0efPiAisc1f2xaFO3R/xxpK4SQ1M7Y1Nl1ON3LuhKpk8fNyOH1y/ES51c3aF0q2AgtPRygzKMJfNb9kOB/ey7sNYgzdbIA6Fj26thfmEx+7vA0EKbVosEX5nlxpMSdkFAURhYbHWCoFyBu2hCQLAp1flucmOyM7ZiYUcnTCZ0QkCZmT7WO9LRItx2hRGre2sGWPnn9+DbMsGHjCNFZEZZgDs5M9taG8COkGrUOS7AXNNbHPzjgl5dxyfA1554RdrzXoXxjs05pnzENwxOvgp4fja7ORMKNtmTX5ikcGKn2L913rM/uX/01rrwx4CwWuWKXuZRvbiAAo/+U6/iip7P2VuMOFw5pYYDJZeJkEjj0tTWGL6QVfxxy4fuIhlOBS1J9DhIhGV0R7erhaHsC+H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:41:28.3103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f86b0f-e331-4319-0ef8-08df3e9110e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8489
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Min <Frank.Min@amd.com>

Newer SDMA IPs support more instances, so update mes max sdma pipe.

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0409325017a27..a00160ad7b61c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -114,6 +114,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 {
 	int i, r, num_pipes, num_queues = 0;
 	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+	int max_sdma_pipes = amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(13, 0, 0) ?
+		AMDGPU_MES_MAX_SDMA_PIPES : 2;
 	u32 gfx_hqd_mask = amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pipe_per_me,
 				adev->gfx.me.num_queue_per_pipe,
 				adev->gfx.disable_kq ? 0 : adev->gfx.num_gfx_rings);
@@ -169,15 +171,12 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 
 	num_pipes = adev->sdma.num_inst_per_xcc ?
 		adev->sdma.num_inst_per_xcc : adev->sdma.num_instances;
-	if (num_pipes > AMDGPU_MES_MAX_SDMA_PIPES)
+	if (num_pipes > max_sdma_pipes)
 		dev_warn(adev->dev, "more SDMA pipes than supported by MES! (%d vs %d)\n",
-			 num_pipes, AMDGPU_MES_MAX_SDMA_PIPES);
+			 num_pipes, max_sdma_pipes);
 
-	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
-		if (i >= num_pipes)
-			break;
+	for (i = 0; i < min(num_pipes, max_sdma_pipes); i++)
 		adev->mes.sdma_hqd_mask[i] = 0xfc;
-	}
 
 	dev_info(adev->dev,
 			 "MES: vmid_uq_mask_mmhub 0x%08x, vmid_uq_mask_gfxhub 0x%08x\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 652cd09504538..ff38e45f4ff01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -33,7 +33,7 @@
 
 #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
 #define AMDGPU_MES_MAX_GFX_PIPES            2
-#define AMDGPU_MES_MAX_SDMA_PIPES           2
+#define AMDGPU_MES_MAX_SDMA_PIPES           4
 
 #define AMDGPU_MES_API_VERSION_SHIFT	12
 #define AMDGPU_MES_FEAT_VERSION_SHIFT	24
-- 
2.56.0

