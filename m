Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8D2C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 08:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4764910F282;
	Fri, 12 Apr 2024 08:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yhuZQr+7";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606B510F2A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 08:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8FJwZseJ7Kd67lQCVof/qDkGseaCkt5ziWBPoy2ypnzbXsv+WHBxz2P+sHRAJ2N3tdsHjpbTE1Oj5fyYg4SCWEzS+1nP5oDFFM2OtwoDxUI/OkeCj4PVk2H0jfXyMc9YwFO9nOfstSFeq50BdvjLw3liMxgwSVw3HwxdUYlOsRrpd4qdY1N2NEzjdhWw/Qmt54xmg6KiQtz5mrpGGf/7mv7v7PX5v5xZwWZw43PvFIoOutwcs4z88Brt0njQkqZQMNNDr1ck4SUQNpDpmxat+HA8Z14s32Y/9rF/sjbiDjL5gLC378ASGbsyoKO6P1WrfCQrT+CBxGv9hjmvrh4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CM5RyYIDbnLmCZffdUsA8XjOpGrm1K4Vd0SWQxkazs=;
 b=YOKk6PYUknPZRSBmrdJ8q6qr7mDN0Jbv49rcy7kHXdV4GQKtr4GnCdWDqBo6fUTDOcz72hsQ/jjGnkzCAC/Cylvn8cTL0x70hZjdcj/GJeFzwUg9++qRfApTYFX9ZHNeWevFAmDaGwXB2kXLRdctvZO7+RDx72y/zkZYxT5ixaFVXDe4onCGayfOZ2Nx5WtpGnPRI0WDdSKFn0oSg7+4lVOGVjO/Hz1uUrwwGVB3YsIe/xVMdVttGGnVh244hpiqxyqOQIJHr3p4Z46Sv+uPrTtYpeSLXChN24fczeuNClkeTPRiPkD+dcYF50Y3alMUvZ2GW4YbrHEFrYz9b8M9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CM5RyYIDbnLmCZffdUsA8XjOpGrm1K4Vd0SWQxkazs=;
 b=yhuZQr+7CEvo+SC2xiD/f0khL2ARUYkPbxXr5r8jhUM4pCFZ9GWM1bip2BQ0YYIYos9TyDNa0QVEKLpI6OsUHayvxCoi0VrwjfvAqpV5SxaeGFr1emOGrwrzhM9QyF2kjBQ7GVDxDPuRrHt2qDfHoMU352h4C8K4G7gdBqkI1+8=
Received: from BL1PR13CA0450.namprd13.prod.outlook.com (2603:10b6:208:2c3::35)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 08:57:01 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c3:cafe::6a) by BL1PR13CA0450.outlook.office365.com
 (2603:10b6:208:2c3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.13 via Frontend
 Transport; Fri, 12 Apr 2024 08:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:57:00 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Apr
 2024 03:56:58 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Candice.Li@amd.com>, <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: Fix incorrect return value
Date: Fri, 12 Apr 2024 16:55:46 +0800
Message-ID: <20240412085546.1459735-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: b7bee86a-f47f-4101-660b-08dc5ace8449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C27Ki4VtQWEUBKHzr7y05Fs0gv66lKCkoQiq2DUUcGUVW3KqsS6xA0sl+hPj1JvtcWcEj7BhGeW+JIuAHKR+rcSVxByGxDBfGyiAoa7LK4vL9Cahaxwx/1jo7d3SyM1REo6EHKy0HhpNZxf2UU6ahzZ84dQ/20nUxgn10UpCo5U6NVEnOiGfoejYs47aABCVh9fYFLCLUlDwym12ELhRCc3ZRgLK+r/T1C1g0OmpHI13sQOovF8EKa7/pQ48uKLUbaEHoFsT3mI5FL0ckNT5+5/rGUTuL5TS99JDqNwbLKrU//D3KRvgIGn+yNwlh3tXz9QNQVc9M+GZyac/B8ExYJTlfa2SDoWK0i5QSaGWGxaJy9a8cw7TR1rYTcQ5mcX8hXsarFKvSOBsr9sBg2rJ9cipCHTcx1zYn2HdIJezjqnjVSPHwS2m2drSIfT1yxiSh1yvbmbX8vE2UfBEdyTPP9kE8f/Hk4j95KIEpdQzCnIb837hMOHztk3r6EyWyg7G2t0WTup+dD5a8MTSIMhv0ZIfgN9sWy4LvfJaVEuzlv3a3v+wBy7jbolyM1MX/HRjCIM/S6+9Ha2JQVRr4t3dK1jxbsfIMsDnwvYQP4OZDDrxQHR//yZbfhp2v/Tt3atIBJBcV9hjxLIu1Ctz9uMFjxGqTvy8NqBHXrXx0yfl9vZcM6cF3b43LDBvD5LVV4AR1DZNDSffG4yJMTt/HqvHJvFvbphgPrpxzlCap6phdTRaO3smThUlBfqwFoYR/PTU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:57:00.8620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7bee86a-f47f-4101-660b-08dc5ace8449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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

V2:
 Avoid repeated locking/unlocking.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 25 +++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 1e36c428d254..a636d3f650b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -317,7 +317,6 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 
 		dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
 			rsv->start, rsv->size);
-
 		vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
 		atomic64_add(vis_usage, &mgr->vis_usage);
 		spin_lock(&man->bdev->lru_lock);
@@ -340,19 +339,27 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
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
 
-	INIT_LIST_HEAD(&rsv->allocated);
-	INIT_LIST_HEAD(&rsv->blocks);
+	if (ret == -ENOENT) {
+		rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
+		if (!rsv)
+			return -ENOMEM;
 
-	rsv->start = start;
-	rsv->size = size;
+		INIT_LIST_HEAD(&rsv->allocated);
+		INIT_LIST_HEAD(&rsv->blocks);
+
+		rsv->start = start;
+		rsv->size = size;
+	}
 
 	mutex_lock(&mgr->lock);
-	list_add_tail(&rsv->blocks, &mgr->reservations_pending);
+	if (ret == -ENOENT)
+		list_add_tail(&rsv->blocks, &mgr->reservations_pending);
 	amdgpu_vram_mgr_do_reserve(&mgr->manager);
 	mutex_unlock(&mgr->lock);
 
-- 
2.34.1

