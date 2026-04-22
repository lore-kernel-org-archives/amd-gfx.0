Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051DCF94CBE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 22:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD5110EAB4;
	Wed, 22 Apr 2026 22:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bJXzMmFl";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F4C10EAB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 22:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTUt4GPXfFv0/xyNF8OKyqcmuu7hymAOa/SZ/xnYiKJ4m93+/q+VMU3/2i0kALFJEKmjaEf/VDgH4RVUwCR1FU+J1DTZD8ZC86Tr6hRG0PZ7Vx91YRPc5tSdq299+KHD7rJH0kjyd9l/e3SFZtpZP6CmjrVRpF81ojmWOduSYJZl9qYYCHJG78htbyFloktZH8Y/4jGrr7pOBClJJv4hW1hy4/VihhXeNRTyEW/+MNg+h9A3c44UXM8difvVmcO1u9QKw8VExq0oHNPUQ79QKzbuf27mfrpI4Y3ggyKfKyuJW+sWYCKsfTL6DMT/vIi+cnoUgs6m8nS2uoiewrIUsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3humxL5mw9+dg0oydFWvUQXFlu5KLKvW1vM5HbpmulE=;
 b=TN/2fKAnCPOGj09o3+LexJ4PuoQVhya+HcSfzm9/PnOgwKsd3Z97FpPVu/+YtDPntFH7IKGIeZz3Zzw5vPTjU331SJ23oHwwmKN8jcSACSf/LYKo6MxUOpA/OkbGOWsqVNoCKYm4JwS1jAzmFud9PKyHTAtsrPMjx/0rPvipikVbrm5MM6VhyIwzuucN3CSZ9tPd09kUpdL6wYvljRdTWAVH/souzbZu6A9Cs9C8q3b9QcZpc22MJ+7/8Qh6eN69itqYfLhNPbXhyzuEhqlFxAuEewUnl/XNlCdqRGzgGUSXZO2FjRZejWMI9GFULxBbmNRtpdcbAXX34oKbSykdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3humxL5mw9+dg0oydFWvUQXFlu5KLKvW1vM5HbpmulE=;
 b=bJXzMmFlX1uVjITlNc1DbwZM1WDHyy2akIuQzzIEjUttq/Xguoyg5h4CpA7CCKxzJa7GRXkuRrrvYnMcke/XBK7g56foI6B35pKGDFPwFbOxzLdGWVCbMoWLQd58zHYCf0SM94L7y22mtLf1qPU1fopqnpHyN+893E6eT9Crtj8=
Received: from BY5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:1d0::18)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 22:06:25 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::4f) by BY5PR04CA0008.outlook.office365.com
 (2603:10b6:a03:1d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 22:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 22:06:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 17:06:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 17:06:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: update mcm_addr_lut data for imu v12_1"
Date: Wed, 22 Apr 2026 18:06:12 -0400
Message-ID: <20260422220614.2259600-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422220614.2259600-1-alexander.deucher@amd.com>
References: <20260422220614.2259600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2f6a6e-3dd0-4a7b-3949-08dea0bb64d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zQ/yS6UWc0kNWaRMdayYrIlpIfiQRJ4VfquBsPI38h2eSj/cjRuVWzqJF57H9aRJAnmAoN+H82558dXEZ4XVFIuaBkt/2niWKSd/NDgyWwXJ+Mzg9tc0N6fSTQVzwL5F5GA6eIU3vq6A7QG6TisduONUxSY07d4pTX/OWx27PGuSlwSYEnr5Jg/imdViyaCvDoo9AnP9kS+YcL+FfqrtimHeU0taV09KQxXdxhtfNPouB5kxexKIWxmjgOGz/Iw4Z/+K0s0OnE3R3cEq262JEXK/ZJzrN6cME6sWp07tuFLfpdo0DaAh8omlQjsFEfWcXDXk9SW5A/P6foZVvn/4slmqii0apgYTt1jiO/HQyXsWJ1IvPx8anYVQ2dJCQ0w/oy3HEStX0URTArKv0/uEHS00MP5+SOR3ACcfmGDmhv3amCP3qkE9hvHQLOHPkIUOP8bZbgOzBeg99WkRrQjtsMj06cdegvhuRIn8TLgG00Mi/SJLRNJZJIqWGG9N6vO3Pg9exaW8ph7vhKkXOUNOmKmBRcGs2KF5NoSnB0Vyt3UvvGY9ExBG12B/wwFWgfZ/3vf3DPfLCOksa6k/XwW+i4Ppfh63sbZC5mOTwHiFeCbRXRP2bDv6RqwdxqtsdRnv62TlOYH0VJnKm3kaANA5n78/P7CMxC3PqKbas7N/h0dk5+9/ijpKUbwAknvy/h4WvsLEGDYjMODgKZlgamOIyzb2ouIsvdXDRwiMaBIkdCNOcj71qHhia4iG7cGMdbFU5CKEwqs3+i0J8DhjuEWSSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wbqnBBxsoz3suNEjsojn4C1vgS8uz3MtYOrKAkMqr1eJn/Gnl7eH1u/6WQwNIj/UHVFGmAcABhseyCWsAzMMvYWLrTpCv/tG701ur87pkIoxa+K652cxLHHR2v9QMDvj56ded6m/jriCdgPaUuVYgUJqG57yTCACVmBwbbhmaTvO71pwQCJCYXe7c9DG6TgmxdtteW70BZ52Gb9iLS9QzqRribmfQ+H8socVpp+hg1yQkoG3Q06SSsOuQ07RLGty36tO3nyF4a/VRW6dy3EoTW8n4gZw0Tjf7gx5f0lfJRUcgbzdzhQeuMmCPuNO4aq3IyG6fxxAVePSmEOrqQ6v33tmLgqUctn75i6gzTE5WOuKc8NbS8VIn6qXVo0K0xSuTuDYuIr7AcUChjMUE42Hj6hYPzQdo9krDgPRm6qO9fSJIPoC2qFRClvbr7q/G5LJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 22:06:24.2559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2f6a6e-3dd0-4a7b-3949-08dea0bb64d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

This reverts commit 60481d95ad989f556da15fa40bc6edb648324b02.
As the vBIOS support the partition switch programming.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index d06953c237ed9..e88bebd928eff 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -739,15 +739,8 @@ static int soc_v1_0_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 
 	num_xcc_per_xcp = __soc_v1_0_get_xcc_per_xcp(xcp_mgr, mode);
 	if (adev->gfx.imu.funcs &&
-	    adev->gfx.imu.funcs->switch_compute_partition) {
-		ret = adev->gfx.imu.funcs->switch_compute_partition(xcp_mgr->adev, num_xcc_per_xcp, mode);
-		if (ret)
-			goto out;
-	}
-	if (adev->gfx.imu.funcs &&
-	    adev->gfx.imu.funcs->init_mcm_addr_lut &&
-	    amdgpu_emu_mode)
-		adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
+	    adev->gfx.imu.funcs->switch_compute_partition)
+		adev->gfx.imu.funcs->switch_compute_partition(xcp_mgr->adev, num_xcc_per_xcp, mode);
 
 	/* Init info about new xcps */
 	*num_xcps = num_xcc / num_xcc_per_xcp;
-- 
2.53.0

