Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759C3CD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 07:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D892911257B;
	Wed,  3 Apr 2024 07:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PxGtfgmB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DFBA10FFA8
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 07:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agLjrv6QX/tFexGNxsG7pKsn3hf4c4Pd10z/KSC5vRcKNno71CH9M7XkhTpv/y80YhPozWi59GjbIxrlF88wmZmrCU8iOFkCIPKnja0o57IgE9mL9QiCf7Rsih97vdzniV+726G+HUiRKnoewH0Ns/bx2BvQUwB8ugpA5PLrG/wjP7LO/6DkZAML3sWxjX6hiaHvOhn4dNMin2pKzXS6RDGRI+JUrGRxB2vOS2xz2dpTQMZCKLkeNhzGQBmszdgE39uNaFKqdXDw8OFAtqMN1QFpD+SQ+5uhjSITvw1o3Z+WfbS71/omVoqDc1OaBNItqrCNlr6+G21SERAxYqk99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPQXYwLRxyGbNJv4D6A1P+v6vNTJRyAqVdOJZTSuktQ=;
 b=IvWqgLKKqV0KvyMCr4X77sYq5QP1XwJqONDaOH/jaAVz3tHUwR45Bh3ZMzghyemPQNiJeEwtp8c/8QJhm7nJo01sPjAx4efqOpeCC6hznCRFmINOV8ZJ4hlmSaxY0PvNfIE1/o77wh9V822Jo4HhkmNs79/oTZyQrEvyg5cQtlgzMImcy/w4qHtA6x2HPCwxZvmGrdPfqU2T9U8q6ww38cPvzycdm3VyeyFM7pK4rk53naCH4c8humjllcVpoPI1AsqvCR1t/C+q8QcRHGJ7EuBu5jlPsXI3QkskBUjGWIzaf+Q37CF/dQxAsd2cU4WS7mBPaFmm6TWBiAxUOvj+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPQXYwLRxyGbNJv4D6A1P+v6vNTJRyAqVdOJZTSuktQ=;
 b=PxGtfgmBULPR2TvokuhjukXDFkTbKGbOnjSJfUdAzLFVebOXd5PzOwlfu8315UFemsz1SM1vkUxe5T1ISyAnzpyWpL46XjR01m6ElfnhESMo580l0EydIPY9c9EBy17JjYA/VRPADmPJhDoz+pF709ml/3RN1+X3vCcISoKNDsQ=
Received: from BN0PR04CA0089.namprd04.prod.outlook.com (2603:10b6:408:ea::34)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 07:07:23 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::21) by BN0PR04CA0089.outlook.office365.com
 (2603:10b6:408:ea::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 07:07:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7472.0 via Frontend Transport; Wed, 3 Apr 2024 07:07:22 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 02:07:20 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Fix incorrect return value
Date: Wed, 3 Apr 2024 15:06:49 +0800
Message-ID: <20240403070649.685497-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 29152214-814f-419b-4198-08dc53acb5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nG8Et97XB9YRy6RexJNYyRBM7upQ67DjunU6s/8WAKHUXJPfUI75l5vI7BtXj5QoOOwQwm3dLFPmuMvcdCFDmyojQq98rMinodrwfNji7I0FtXxL4Nw9af8sqBOrWoO0fG6rqdvz+HWXh7fCYqP669dUOsSmncQ59RiYeRNDzxlcCRe6abXQ9lOKqtKJi/sj6mw/R5dbYtUgcy0XgOQ+q+Hhl3dhlCA2p7tVc71ZiwZOJhHxorJjN9OS3fRS42/Uof+aeSpD2Cf+Tvkqt0y9cjUjf2SYTaBA1qYEpPDZ1oKszuAuaXzKKiy9eDerSF64yI8m8/oyrG4GfikxxJfXopZ8julidBdoYzC2B/Lml8m7iGYGZKLqIv3Jyqd87BUYxYAl9WL6UuRu14K8/IEPJPct33UmBoFKy+aha40HD6nt3zWkCfcbysZMck8RgqGLpniaevDlrMXIYVWWldj3VGF03he13A8Smwmvkn9UWzvxGnrW2GblkihRPNDhkJcL8usUW5pTF2OPROBjyRcKxpsm7rJCfn1Lqhd06hIbCbwUv9oqaFCU4zf5udtjS0GrecJ/IvIoG6ZoKcZM/SarHV7mPGGYINoTX+nM1O2T+L5j8cDUCjSiBjc7VwN8MltTfkoaZPCIF208YuT88uh3FjzSEdA9Nfhw4EwfAwwEHFZC/SqMepTSNNkq//VQCzGh9kxxchBhcxXh6FPw7ZG2Q7wQD7pt/dCa9vt0nt6vcq8Z01bdF4K9VGFjV1itB/Pj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 07:07:22.9824 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29152214-814f-419b-4198-08dc53acb5db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
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

[Why]
  After calling amdgpu_vram_mgr_reserve_range
multiple times with the same address, calling
amdgpu_vram_mgr_query_page_status will always
return -EBUSY.
  From the second call to amdgpu_vram_mgr_reserve_range,
the same address will be added to the reservations_pending
list again and is never moved to the reserved_pages list
because the address had been reserved.

[How]
  First add the address status check before calling
amdgpu_vram_mgr_do_reserve, if the address is already
reserved, do nothing; If the address is already in the
reservations_pending list, directly reserve memory;
only add new nodes for the addresses that are not in the
reserved_pages list and reservations_pending list.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 28 +++++++++++++-------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 1e36c428d254..0bf3f4092900 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -317,7 +317,6 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 
 		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
 			rsv->start, rsv->size);
-
 		vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
 		atomic64_add(vis_usage, &mgr->vis_usage);
 		spin_lock(&man->bdev->lru_lock);
@@ -340,19 +339,30 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 				  uint64_t start, uint64_t size)
 {
 	struct amdgpu_vram_reservation *rsv;
+	int ret = 0;
 
-	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
-	if (!rsv)
-		return -ENOMEM;
+	ret = amdgpu_vram_mgr_query_page_status(mgr, start);
+	if (!ret)
+		return 0;
+
+	if (ret == -ENOENT) {
+		rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
+		if (!rsv)
+			return -ENOMEM;
 
-	INIT_LIST_HEAD(&rsv->allocated);
-	INIT_LIST_HEAD(&rsv->blocks);
+		INIT_LIST_HEAD(&rsv->allocated);
+		INIT_LIST_HEAD(&rsv->blocks);
 
-	rsv->start = start;
-	rsv->size = size;
+		rsv->start = start;
+		rsv->size = size;
+
+		mutex_lock(&mgr->lock);
+		list_add_tail(&rsv->blocks, &mgr->reservations_pending);
+		mutex_unlock(&mgr->lock);
+
+	}
 
 	mutex_lock(&mgr->lock);
-	list_add_tail(&rsv->blocks, &mgr->reservations_pending);
 	amdgpu_vram_mgr_do_reserve(&mgr->manager);
 	mutex_unlock(&mgr->lock);
 
-- 
2.34.1

