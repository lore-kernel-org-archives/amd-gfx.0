Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AF9C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7ADC10E50F;
	Mon, 21 Sep 2026 07:53:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BMyOp0Ib";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A02E10E503
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3Y+HFA8fokQfoApzEm+SFQDQ3kS8MrCh2LP+tYSjzF8O/UkoS1p/EFweGKQUnebipt/+mwo7AXi0vyt85FZZq6eFBpJLVGeSXtxUzGMWjvXce6p8qqZhr+puk8EpyQz5v2gthQZb+tUcPmrY9/sXK1x+m3CUBIgeQFL/h3jG66m9j4s3RSSLx/3lRJpfW2CftsMU5X6p9oWIdisoG5n/4feMKlVo54lNfsJappNOxMlyQ1HZ+q/E3P19SiMbtZbcS2GFuX2IhiSvTUHWFs14tGHbnKAT6H8MAbISjRUvSoQpddh9PVXwA2Jk8opajC3dvre9teKqzKPkfRjAmnNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPMUu6c2P4StBUhHsu/4LQPuVwaNYn/9e1EsOt1NzKs=;
 b=YK7Ya2I0sOsphhyVKjhGX68T+fTsHLt31BHaUWUPA9o7f53bpdP5gxu+sEufRcQmKgXx+E/YuAFiy0bjNJDJ0/wWcb/Z4ZztDokwFrFjSnSBe+KDRoO0LoYuWUcGn5+D1MQ3ZGm8gQtG76s8eXq47JPHRDxuVsH8/eN+0uHakjTNWiiR25cVt3kB9pQNxdnyNVoM+cIINEBYbF6L7GhEe4GE/rTouN5cWC7qGnhd901x4kx0n1jSxBgGnQB93gNdxnvFR0IYWuqBl8YU/T9Og8E3VokMwPy8V0ErjY9+hc6Pu7VlT8KFQG99jLFc+DwYQj+upmN1b1E18ErQGvOe2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPMUu6c2P4StBUhHsu/4LQPuVwaNYn/9e1EsOt1NzKs=;
 b=BMyOp0IbJAAIIXlvQygRpwHfmeTcgAUmFVlz6TTeVY2U2W7p9eeNQhrBCPcBVWHbzwyTUy59b+yDkLfx2n1JRAZcxI/UsvDfBdkcCojAOaZzAjAhybUGYcT0/qqJnu+wel3Fgo/OaL8QsnDxgJ3YvlfSEyU/C778y8vKlsHhRDM=
Received: from BLAPR03CA0143.namprd03.prod.outlook.com (2603:10b6:208:32e::28)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:52 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::49) by BLAPR03CA0143.outlook.office365.com
 (2603:10b6:208:32e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 07:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:50 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 11/21] drm/amdgpu: support non-guilty job save on ring backup
Date: Mon, 21 Sep 2026 15:51:18 +0800
Message-ID: <20260921075326.2409021-11-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 21283197-dc06-47a2-9cd7-08df17b57ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|11063799006|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uXu1ui/AeMfM34faVm3xW9B0JIvHXqcU0vGFZc2Rxq/7JcgRo3urmkSkroStCY4w6polmS02HhuyP5iOvZfHL36mt3rGN8N1Whg4U99bax1mB3ZK2kQvqBpJN2a0+YJ1EUe2y6IUoKs/Sj/6svnBTOFYz//XP0JYWEqFcaQ8CzSVajvQFJdxMuWBJaJ7jyXC5xxoWaXpjyVRzpEBniA8qb8ZGU8ZWD4owwx4ipXSXgjDx2aB7LASW9z9DGOtC7QZJI38+XbQYgpDQVUMmHBW+Y7cjduQcXekX7dqx3H+YTC3OygetABGjMG/L69bYZiYNGbzJ0bSk50YrNAdJC2R51PjyW3NVPN/aWO7FhBXyNTKv0xcuwY8fBu+vvMilOtSEPDs8+Xj/ZQOjK04tZyoCh2k5buMIzmsbOfLgMIh+sl7yEn127aHybDLJgLDpuoNzfWWw0rDebOe1GJqQUdpTNrnCJTNpYZfFz/ItqLzTO7ZYjJigsgzyJsta4SOKgdJV8gRq7F1l2wwKes56MdQ1WsVpRwO9SHEZnH56VEt89gC7f1VnPyhS8AVojZhV1YHUJYwA/jPrPWwemk8WCLyDwasf7VfwQO9nqJejvJ/t4Mzaft5fHWBFtGWG44Tc7fnGnXSAfPa3WxXb+F67UxdDc3SU0GuCH66IvJaMPT4lZpTmqYg55Z76yd0TYpIuAwQ/8rv3KhGNH7z4pk26NQMCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pJzVtvM/WepLZuRq572/uUJ41wq11SmR4u5Uv1szvFOL0geRzlfjTDwPYhlubwPZfp/sV0b7CVaTkK/+Wncm5l6HKZqcRqU8a/8KdxwKe2FGMGIBLdyjI7vU0Sh1Efg/orC1tGsluc2r0+oMdfbpB8rwVR/PKIDvhV74kIjJ3F3OIet/GTyJi+BYDFmqzBbdh5wghfPcY8/N4vXbggz7ORJqMo9wVS01RPXD6N0cz5N1MaVhhKDxrm3tI/vjYtQLUo2Kj6f37OEYA5Ou8rQIRoStoDwROU4aRfHL7QrEp9lwbjVQiJLWQ37Ot/ckPgOn8C5pHLBMOPHsZ9NdDinpFXD0iiOq5syXMX0QRQjLjgma1a9svDTh2B0LETieXD9p7RFWToI2OVGAadXB6rrawRiCsAeTT886N+pav/XA5gc0dZ9Pmdv69XcdDV+NHo2w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:52.7147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21283197-dc06-47a2-9cd7-08df17b57ada
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
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

amdgpu_ring_backup_unprocessed_commands() is also used to preserve a
ring that carries no guilty command - for example a collateral kernel
gfx ring that shares the faulting pipe during a gfx user-queue pipe
reset. Such a ring is backed up with a NULL guilty_fence and all of its
unprocessed commands must be saved so they can be replayed after the
reset rebuilds the ring's MQD.

The early-return that skips an already-seen guilty fence compared
"ring->guilty_fence == guilty_fence", which is also true when both are
NULL. A non-guilty save therefore hit the early return and left
ring_backup_entries_to_copy at 0, so the pending commands were dropped
when the ring was rebuilt.

Guard the early return with a non-NULL guilty_fence so a NULL fence
never takes it and every unprocessed command is backed up.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3043ad041bb4..6537e8845fb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -733,7 +733,9 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	 * we are skipping it on purpose.
 	 */
 	if (!ring->ring_backup_entries_to_copy) {
-		amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
+		if (guilty_fence)
+			amdgpu_fence_driver_force_completion(ring,
+						     &guilty_fence->base);
 		return;
 	}
 	ring->reemit = true;
@@ -804,12 +806,11 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 	ring->ring_backup_entries_to_copy = 0;
 
-	/* if we've already seen this fence, return early.
-	 * ring->ring_backup_entries_to_copy is set to 0 so
-	 * the reemit helper will return early as well to
-	 * avoid getting stuck in a reemit loop.
+	/*
+	 * Avoid replay loops for a repeated guilty fence. NULL identifies a
+	 * collateral ring, whose pending commands still need backup.
 	 */
-	if (ring->guilty_fence == guilty_fence) {
+	if (guilty_fence && ring->guilty_fence == guilty_fence) {
 		ring->guilty_fence = NULL;
 		return;
 	}
-- 
2.49.0

