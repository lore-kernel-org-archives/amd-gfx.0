Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803B7C001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 18:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D7F510E756;
	Thu, 13 Jul 2023 18:22:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6604E10E756
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 18:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZazQrJssKMkO/ZeOorqNpD7SAJJHg+Ro5WQnGmKkB49WHJ15ruQLjTWliFTuZnSrtafeEYVaDZfrRHK3vZGbCABkWPdAd9PBwR8OWAOzDhMFuGTcBT7I7MP79nldlwHx3vU7LFyrUHACMImK3JqdsT3LleOHyiFCJlWsCUZ3Yxp7OzkNfpKT2Pq2n39pTy0iQTU4SkvVv16+weg2L9f6EPJTLuC0LKvbnY1AOwCKkby1JdD+ZgFY88ycRlM7cP+Z8ahTbKvOUhrwFqx2Pu6Dkzmcm4m3zD+UJJbLcSg4fdwm/MG7YkHukhBggHg4GVPJZ7eCJNoTSO10SK2NPDTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwtuPJD7ynGYR0cJvmVGN2a3tmYhCS9rLQ6SzTgmeFU=;
 b=Qkb4jZbk6IXGUK7zCBW1ku5pW/3DMkjFkR9YoaCKeacn7AY8ZTa5ZUfjb22sFN/0CxEjxTkpBuSZPIdCkJL1n7n3m62YdR1OuIdxXvSiRwnGEdz7CVqxgifGvL/yqN3J0BuH4X/mLuq/dUlZnwCupH7nIBNmibCkUfJ/DuJEksncW79p5ML+Dd7KvSLdVtH+qD5QOLS/cQqXGpuMg8XHVsTXkL4wnceMgnaIGuFR7eXehMBLZkJ09jy/EYY6CwQszN0Kb/W/umT+zxI/3b2rcfEeqmmF73M9ZKx5H7riyxfozkudN5VyW8xmEftJB57RRn8Z4QZz+rSSWxhJDPj1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwtuPJD7ynGYR0cJvmVGN2a3tmYhCS9rLQ6SzTgmeFU=;
 b=OF+m3/dM09oIjHpzHbfyE3gq0aWZCbHBuYbB4waHtCBdOzbfxMksk44GyztSuVgQllSoNUvk6UrRqNfwtPjh33yCNxVROM7kV7t/TvjsYGDXxQ0qvet6ym6FDXmUCHCh1Q/HwlDDrzUzZyu/3XIZlMote3NvTtYpxC2SQEt19RQ=
Received: from DS0PR17CA0002.namprd17.prod.outlook.com (2603:10b6:8:191::25)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 18:22:36 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:191:cafe::d0) by DS0PR17CA0002.outlook.office365.com
 (2603:10b6:8:191::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 18:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 18:22:35 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 13 Jul
 2023 13:22:35 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix an error handling mistake in psp_sw_init()
Date: Thu, 13 Jul 2023 00:14:59 -0500
Message-ID: <20230713051459.74044-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|MW3PR12MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a358beb-ba0d-43e5-f463-08db83ce2202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnygNiZm52V+vCFPU9DhbZ3+h5oGvDluDD153oKlAbfpaFSPf6n3L9+5Te5B51RXJdDuI8K8G6SJHuMgDbB200pcsYCcGRX08x88A3vTTSvYvqGkexbS4CABPFcv5acusd2cvDNenIw0nLhkc6o/5MfDblcgQRqcnOOm9znlxPIbTq9nqqUGEB86W5OrsPKAqNmQRs4FyxPhPp4bOeHTUeUOoIZ0RLdW2olJdQQ/NVk0bY7GTDbKg4N4XxYLVwwie3zONcREWu4Qo/4TG6coo/c2mOc+6OWcWI+a4JwVkDkpc4E8AHqYr2tPqjIN/QkduSWLsb0AjV6/wuLPkJSYZDnogG0jNiAZg9xyARF/ZTTv62E/pnyJYliRMpG2iBb3A79kXV966/oLKgSS79ToMTRb6lNLjDxfLZBoB9XRkEP60VbnpPLXvVxQdx6lJdGfwwc34HYhk7RXyf9b0Ihlf3cOYGvrQzKxs2p2Hzepf9RUCV9r8Q4JfWZORl+Jg0hpPCkdsyM+5olKDb4fxbXmPk06JFvTg5eoL26ZI08ZQc32pSb2thCZBZlkHNyX5JlrcDuioDX7XgBjxWuFiqADmXKpa6eF8+uaOv/PnBR2t2FGwAQywJWHwF7JZg/YNq35ALgKHW58pzZlsvxMOBuVic1OckHG6t8pmgFwWaMt/439SDqQ+DOVcWIZ68bCj2ogikePDtyCGh9fWDzFhV3IpH3wrtLI41H6OVUD2/TpTx6u+80iZYnpjiEvrQwndTcZUCTx8m/EYEZMOhMXWN6Oyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(1076003)(26005)(41300700001)(336012)(426003)(6916009)(44832011)(4326008)(70206006)(70586007)(316002)(47076005)(82740400003)(356005)(36756003)(83380400001)(5660300002)(478600001)(2906002)(86362001)(186003)(40460700003)(16526019)(6666004)(7696005)(8936002)(82310400005)(2616005)(8676002)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 18:22:35.8927 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a358beb-ba0d-43e5-f463-08db83ce2202
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the second call to amdgpu_bo_create_kernel() fails, the memory
allocated from the first call should be cleared.  If the third call
fails, the memory from the second call should be cleared.

Fixes: b95b5391684b ("drm/amdgpu/psp: move PSP memory alloc from hw_init to sw_init")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 1b4d5f04d968..6ffc1a640d2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -491,11 +491,11 @@ static int psp_sw_init(void *handle)
 	return 0;
 
 failed2:
-	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
-			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
-failed1:
 	amdgpu_bo_free_kernel(&psp->fence_buf_bo,
 			      &psp->fence_buf_mc_addr, &psp->fence_buf);
+failed1:
+	amdgpu_bo_free_kernel(&psp->fw_pri_bo,
+			      &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 	return ret;
 }
 
-- 
2.34.1

