Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030DAC52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 15:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A327310EB2D;
	Thu, 22 Aug 2024 15:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l4aqRPbr";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4D910EB2D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 15:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4McDiDhHC/BB4klQ9uoMR4kEcIwFE88VAX/X582GvxJbiK6IY6RyvbHVAEUcG4ydJuwPEDBgt0RsiriHYoL9asvjJKD8XVEn7uV3nRa3Ux2fLwpY7QSm+Khu+BbTdITdvxb4GHoJXqLseHoRWPbEhVCvNVzGdbeL16Icpw3h9Ksz35YJBclHNuZbRVpEP99FP4pS0+mIBC3P/gJWkqZCUmXmYfR0ba/FMJ7Ti12NYzimQ3kC+HvFFoJ1YqLTGt9D96ib9LTDFwv411SBVFkP6h9U+xKh8YEx8veczmi31gwyZ2RFIdKZCKhXxY+il712iUUtCySCbMuAOvNZxC/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJSawqA7E8zNneu2n5BZGdZbw6NG/d+3zzpWbiZ+MNA=;
 b=Ol1V8Bmw/l7hg3TRHPVT5pkq/oMgLCkLr8Qqft29GBwBW7iwPC/OzPGXCJEu96q5G8/MUKIJh1+FjkIETlNm8abxrpqugkZa81jYdFgs75Q7y9JOdXkZsc2VNrR8er16eb6BS2DGhuWgwBh9dcsjvotWUXsqhaq2w/YqpOYb/EKMmWbaFrV8oWRzq78fWJ3SkLOr4BCF3q4XKGLt9ZNwJOKsBOyUPKrMH8u44ar9y6b4hU6402HIZagdjZB8DxuXyh2DR0wBxwindDB0Sa63QOFlWZ2Fj4qzxdzOVl4GC9Ky8q0ixFRgsa5ElGoCrMuGtyu27RztqjfW9LYueLUr5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJSawqA7E8zNneu2n5BZGdZbw6NG/d+3zzpWbiZ+MNA=;
 b=l4aqRPbrqxfrK84hUmvn536vve7nqiJWrFUAkB7f8WAg5w3xPBGxPcUvSoqufthlNGwOuIoBuT1ObHhwaanwtr2Irsxdt2pK/XGCaMH9Ng7ubg10UyeeMf+0wn2c5UkJ79lubSBwjJgfb9+W/hx8niUO2O5typLlDdCdEc7oYGk=
Received: from MN2PR19CA0014.namprd19.prod.outlook.com (2603:10b6:208:178::27)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 15:18:04 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::1f) by MN2PR19CA0014.outlook.office365.com
 (2603:10b6:208:178::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 22 Aug 2024 15:18:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 15:18:02 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 10:18:02 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Alexander.Deucher@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, "Jonathan
 Kim" <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdkfd: fix missed queue reset on queue destroy
Date: Thu, 22 Aug 2024 11:17:55 -0400
Message-ID: <20240822151755.4167439-1-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea77e57-bfcc-4c45-1871-08dcc2bd9dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eYR+tafvaW+8b5pCW6ifhSb4DiZc1C1m3dpadc4QRebs0y5Wm40R2156Gbxa?=
 =?us-ascii?Q?XZ2h6KAEX2vuZ2V34RNIAeCxb2rnOWPn8HrWLrrpueesm4sFMzFY0nnBgas9?=
 =?us-ascii?Q?rGJOJBqCy5CIPpC/xVMmZ8o1bw9QLUTsPBuA4zTqqvXbUlAAoeBuifyJx0dU?=
 =?us-ascii?Q?OioQAmXm2TCyq4ZjbjSmZJzx/an1qHsquANwM9CLeil5lx/cmtzKlNUHHU12?=
 =?us-ascii?Q?xjS5xusuMH28b53LD/uhmJa5/YoLVxyeLkXwiLgLzJt6ff64KeCL1D+sgdLQ?=
 =?us-ascii?Q?JzcKMyMqosSTiR7TlsP1D2Io8XMvxwOTe7G42R03WcZuH61A5+KekexXlhlh?=
 =?us-ascii?Q?A7/JufnSM4ffAGmtINRgEedN8GhZQO522g2mFz56dqMe98rs5F3jVyjH9Uwm?=
 =?us-ascii?Q?jTupmbx7PTK7ZtDPOqRSyCQftVCjDP/QImGvFdl5IP5tgKRZGiUQgScF4sy4?=
 =?us-ascii?Q?0Kc35JPW6gwfCnIjIMI8d80Ipza4cXZDsLYU0MMwBUNBcOr9Xhg8dWVLBfBJ?=
 =?us-ascii?Q?7vQouyp7WX6T3GxMtBvWsfWctrE0kzIu9V0wRDzJ86VpsjYlxmZeZ32BT2mn?=
 =?us-ascii?Q?IsfE4UfGkAa0OeZaT6s03jW5bKz4k2l3XZ23GuJX/nBqWxOML8KcgR43WibZ?=
 =?us-ascii?Q?7Ks1ZC+8gIWpWx20d72/eHNmOtQxANxnUifVjJAR7Ygut06LbAL7HFLuNbWU?=
 =?us-ascii?Q?lAcc2V0wy1hxukhneCWspKmLIfRys0eQsdcDYPXxofIvohKhCDdVZdM5REUQ?=
 =?us-ascii?Q?hPB8TFLEc1LwAN41IfpxdxGvsNgx9tSIFqTJ9PLCXjB95ixaDlHHdpxVOgV4?=
 =?us-ascii?Q?0mTRAyqcrTbyWPeuGKBYGB7WMKABvehLnpqVCFkAQH4KfBdX9qhx3u3T5UkF?=
 =?us-ascii?Q?fZiVO6dVSlyggu1Bke1WOOkXh1xvGT9NanQB3fNnEdFTpQqhT465yh4hBJD+?=
 =?us-ascii?Q?b/yPE2KdWmyzW7cDjbEoY42OhtA1mGRU2PPmsSnzYO9ZDZ3eCSaVYK4euqAG?=
 =?us-ascii?Q?i0slauodnjGtk9HW9Dv/EVvpL26AsxufRn0Y9Wv/SkPWJRtYjJPc/etWFoqN?=
 =?us-ascii?Q?gxTcFBLMgYBptQp+HidSDRerRYVQB9L6tnA24leSPJSq5aAeRaG6P5KfbDzk?=
 =?us-ascii?Q?HpNXk62t7CC9cFxSvoCLgXTUX7jhpnxP1J70Imscu+ICMR5A7fqsePWVu/YM?=
 =?us-ascii?Q?G8T9BnQszbiz0KxkdK66YhQ7nv3xunPJuKsKd6mh8dGVzOFg9Fve1vuqKJOG?=
 =?us-ascii?Q?SBKTReTkKom7imDXskqSzAUaBtVKKJtZhtpDCURul/IqqXUbT76mU9RVbaWB?=
 =?us-ascii?Q?piTl9kimm1iqKFsx2wiceUj+YcaMZVUk6C/QcB4i4IGDcjyyQNtT3I7nxYEa?=
 =?us-ascii?Q?AhWTQnK3wAQCVr2UJcN7ak9XLQwtaHepTix+x8FIC1ENu10bcW/Infz/lv6a?=
 =?us-ascii?Q?kb3jSlVFchkSWdd4K/Cy2G0j5IlPf5YS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 15:18:02.9182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea77e57-bfcc-4c45-1871-08dcc2bd9dae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116
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

If a queue is being destroyed but causes a HWS hang on removal, the KFD
may issue an unnecessary gpu reset if the destroyed queue can be fixed
by a queue reset.

This is because the queue has been removed from the KFD's queue list
prior to the preemption action on destroy so the reset call will fail to
match the HQD PQ reset information against the KFD's queue record to do
the actual reset.

To fix this, deactivate the queue prior to preemption since it's being
destroyed anyways and remove the queue from the KFD's queue list after
preemption.

v2: early deactivate queue and delete queue from list later as-per
description instead of destroy queue referencing hack.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 577d121cc6d1..6d5a632b95eb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2407,10 +2407,10 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 		pdd->sdma_past_activity_counter += sdma_val;
 	}
 
-	list_del(&q->list);
 	qpd->queue_count--;
 	if (q->properties.is_active) {
 		decrement_queue_count(dqm, qpd, q);
+		q->properties.is_active = false;
 		if (!dqm->dev->kfd->shared_resources.enable_mes) {
 			retval = execute_queues_cpsch(dqm,
 						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
@@ -2421,6 +2421,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 			retval = remove_queue_mes(dqm, q, qpd);
 		}
 	}
+	list_del(&q->list);
 
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
-- 
2.34.1

