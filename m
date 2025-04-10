Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCDBC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 18:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7565A10E390;
	Thu, 10 Apr 2025 18:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3athBgtf";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F92410E390
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 18:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnqPMv5pcmk2puxlKVBcTlRux6u/nieeNn7RVAP2zcZ9GFzm3ddw0liYAbNbEgugP4N/NWgWWTtcPTdx/WxtBAfq6hknzMyj04lrzdkLBwFUVUXPvUXnL9Q3AS7VT6B86hx9wHFtyhVDR4ACUL4aKw05gm3cQtsbTufZwlCrTN4200hN02uiazTxvtuxmhZBkcvOQ+wTbmCtgcxgw5icO9gol/+20ZjgvNAuAXm5cN2GodN6jalpDZ/5D3/nf4KjXXM35ZYDyHNJOCjkGiIT8iVAsWmHN7rPjNN1QXZRC3VX/nP4Et3JZKGyz2ca5lBKUIbrOejEUl7xyrAGg651Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pIIP0nHuwQICYP9da7FMG51ylIkuIGc3YYij7bmwkU=;
 b=QJBa3Rr5VBDqQywN7MCgzOkOz6jHcIxdwJUs2eIAESQw6V2MM6QixHsMHuUQyWRbtGhL5m8noNkWobHyNBd7KuwQ/WszT0ElncNnlow9scfpyXCcWWVIpfHEZIoqqFXmkdf0v7yQu0HD5gESWyvm73oA8n8svcT7K3TIOrn2Hg1dnE1F2ePLlet0zaYpa4LsTHdxw0nr7hh+R5f2gKeHlr/l1An7ggDmgJxlHzgD+d79r0UsyKQqqi2qJt/6MsMv1XcEpwMPwlqPml+VmN4Dkgdp+mdEEsHDpi6GjCoyZsZvx+VgOalJK67zVYMutHiKIRphgQYZ//pEvBqvvBs2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pIIP0nHuwQICYP9da7FMG51ylIkuIGc3YYij7bmwkU=;
 b=3athBgtf6UNCKGUGX9k3ofdknqqy41A3ujLmpyuT11mqpCC3ZsS82AnU5k7r1vTbFUmf7OfmThYxGc1MckGn0phiFm6w+1O8hYeRlCZGIlOoiShbFVnC27sV/SMMBBf+DzvkRvQn9w01vnO+AkqO6zi96Rb4FNLUwOrSwcA8YgA=
Received: from BN0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:408:e7::11)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 18:54:15 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::3a) by BN0PR03CA0036.outlook.office365.com
 (2603:10b6:408:e7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Thu,
 10 Apr 2025 18:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 18:54:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 13:54:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/13] drm/amdgpu: convert userq UAPI _pad to flags
Date: Thu, 10 Apr 2025 14:53:50 -0400
Message-ID: <20250410185402.2352109-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: bd24fb06-17ce-4995-9f7e-08dd78611705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WiMziy5zn9iaNKWOqyFeEtRy975G0Y+lmW+fhWNiq7YxkhpgzMAFmmtagAtr?=
 =?us-ascii?Q?FxHhFjS+i3ExTIi4U22k6UCJog0TTjhBg1s2K1u3Y5veyUFza7GrSHk2LgGw?=
 =?us-ascii?Q?1pKPx4r0rMpa9SBTMiL3HL+nPIEcRWjeIrEL1uzluSpe1e18DigjxDiU0F3x?=
 =?us-ascii?Q?rLkHMAPagNdW84z1Qba1yGx/e4T3wzoyXUV6MuJVs0H//e0AIYptg6Hfc4Tx?=
 =?us-ascii?Q?3qISEvV2lrLrJzLcWYF/bbh3xyqJfQ5dnFlFLPpnMUGb7mthLYiBPGZFBuWj?=
 =?us-ascii?Q?7QAvEZiJ8kSHnoeHRgyHY7eOmWFcZtwapzjIVVrc9nUQTywHH0Hg0ZxHUqSl?=
 =?us-ascii?Q?gXgZreIykr2L1G+UhZ2c+2hgH4mM9bxRkQxUYlVMnvaUMpyQjYsGcRSl3n7w?=
 =?us-ascii?Q?1wAee45XaGaoHhwaiFKQj0t4MYbSMqsF2PN1ovLzs/r+gzm7w4BJuJ/1NCB6?=
 =?us-ascii?Q?mnZOt8kho5TpnQyyhvsO7RKVUSih4ry1+N7QvwuDUZW6ojmwSh+Fv4w741Ec?=
 =?us-ascii?Q?Lvu1QLC+S+/aNmJa8FfMOA5wtN5J0IBtXhpFmE0dl33PCWTigCDViYt6UMcx?=
 =?us-ascii?Q?0MSWvK71Xj6RCQMmpLGJwzX7P+xDYdlCIvh9+zfuZtOIAa2NFsDg37BHXlW0?=
 =?us-ascii?Q?/AX/9nb5mV3P+r0q5TRWCbUi50XCg21WkVNaIL7Exn90WG5q1pBDQDaY8IfM?=
 =?us-ascii?Q?nmEeDAY64BpeqfhP3cAoq1M27voaqyu6FZBPrRpztEKBFqnSmP10RTNEyXL5?=
 =?us-ascii?Q?2FpnL0FJd/nWha/O5Mtx2TyoDD7mDc8BxuUnkxLJhrBtTRD4n0JSSCO57G9J?=
 =?us-ascii?Q?JdwUEkIwhXEKopQHv8tLQjkoYVR0SiBTqVOY7a1d0i2rfmGFQYEovZuH+8Bl?=
 =?us-ascii?Q?443EUMOKSM4k4S1kCKnY0Lq80qZkYJKSv286GA5jEPOea6qwEUvUTYd/dDT5?=
 =?us-ascii?Q?5e0fq/4Ia+Zgvs2Ss/Jmsx2LwS3clzBPLSuxVmcuraFLQK7bhqKcPByQaTkj?=
 =?us-ascii?Q?/FaCTAbcM0QPQzF686mZFSgDDKWDNF8y4nGznD0dkE7MrVW4D7oNW7hZZqHV?=
 =?us-ascii?Q?biYO7HmD75zu2xshWAQoQ+9fcwUBAAT0h3Xbs/+9B6asaVfOi7f2ugrG2ZOf?=
 =?us-ascii?Q?XHDQjX3yo1vCogMDzzqTL6PyajTVjZ/jHHdpbBWewnhrleEKbO1lGf5Si23R?=
 =?us-ascii?Q?bkOsQLdJW2UILpnd7Bey0ItQccUC0SPnRr61YxA3WWeXUvCK28EKRZTzffIU?=
 =?us-ascii?Q?volIZLR+Z8UZ1JEI+h+ap28bxWFUJwkbnsPDD+7IoMD+NHt/HIb0gYVo0JYG?=
 =?us-ascii?Q?B/0G2wUPzlXglN1rc4h9dVQfGInEcrqW3J69dzp3KJ6H2357bcT/ovcbD6EI?=
 =?us-ascii?Q?2G95wh62Zt09KDP4K61IjzChnW1vTDFNSJEU4ft3lrMd5PK9VBiiZl0xMDtm?=
 =?us-ascii?Q?fzZfjwBFa6GOAYp/w8BYzvkSLO/mvDnVsxSH567h2A3jWaIHR48Oaz3wA5+h?=
 =?us-ascii?Q?sonGhF4PsRyO9AI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:54:14.9460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd24fb06-17ce-4995-9f7e-08dd78611705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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

Reuse the _pad field for flags.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 4 ++--
 include/uapi/drm/amdgpu_drm.h                 | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 50317fbd40e0e..57a4ef64e0b8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -377,7 +377,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
-		if (args->in._pad)
+		if (args->in.flags)
 			return -EINVAL;
 		r = amdgpu_userqueue_create(filp, args);
 		if (r)
@@ -388,7 +388,7 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (args->in.ip_type ||
 		    args->in.doorbell_handle ||
 		    args->in.doorbell_offset ||
-		    args->in._pad ||
+		    args->in.flags ||
 		    args->in.queue_va ||
 		    args->in.queue_size ||
 		    args->in.rptr_va ||
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ef97c0d78b8a0..1a451907184cc 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -355,7 +355,10 @@ struct drm_amdgpu_userq_in {
 	 * and doorbell_offset in the doorbell bo.
 	 */
 	__u32   doorbell_offset;
-	__u32 _pad;
+	/**
+	 * @flags: flags used for queue parameters
+	 */
+	__u32 flags;
 	/**
 	 * @queue_va: Virtual address of the GPU memory which holds the queue
 	 * object. The queue holds the workload packets.
-- 
2.49.0

