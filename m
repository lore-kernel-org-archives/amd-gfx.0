Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59347C52D6F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 03:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102FE10E087;
	Thu,  8 Aug 2024 03:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oc2PVW7e";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E25710E087
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 03:07:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfRZffkujtrndSCG2HvCvHbWAOWZm2WiiD5jJnP5k53iLy3D+RXvmFogm9tiTSXGvfOc6WEj81UsINbq+TBLVkKPuh42e+4nn0wbQtAaYOXZ8M0P3BiEEzy1Eis/rk8+/8bG8cWt7+4au0l6yzmJ1zERn6pZrtMck5Q7uIS4ZUPGXgPyTQP93ak+Bs+taXi7jqwnAb7QpPLSa3xYwtrMQsM0MGbpAyuLCqyNOkBeJZ+1GjAAZhsmWKEacSx9KyzOBesKYTgZbXSigd76pwPgPBeZd5KKGG6U4396sR4xKvJ32XXLGEwkT4slV6saO+DYQTBWeWZRRANXrFrpc5RVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxgUmnUA1aYMU5dvEkILXDAox8siFn+XOHZBCaYfK3E=;
 b=oolbu5mcJzIUdb6319//Vx2PUXtPMBsB/0p3ceJDqC/OKcA9TaNWBuFG7do+hyfW4DKySKCJ+wnrJ2lEQeW00ti61dYjjzDD1SuL7WjaKZhQjVqGN1aBoJuVhg5ZpH2LNaj1V2A4DnCewJZvrdD7dLyBivfja1dsNLb4ZpaNEqX8TXiym9ldp103+x2SuuNwscDFNhCpqhPhHNtsgy1Rixp0gZrdGuiVF8YcspB5DCgXK53ZGPv6FXcxeE6XFxqZ9lFn6ziZvvA6uf5aKxzLVSVTdWK1R08SsQsZeR4s7tk0YkX4VUooiqKt/QCRYwvFK/jZraF8tBi8FgVvqtJIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxgUmnUA1aYMU5dvEkILXDAox8siFn+XOHZBCaYfK3E=;
 b=oc2PVW7emWyyOJh5Q5ET7ijCjvWnE8lOO53MpusN6q6wJE6g1ViI0juYkrPf3xabAqAvN1uXCbmmhf3+dxIUhiPZ2OCBNkPpCH0igSGE7YA3JUQh9cVynR9rxkN/JksbXqudFyQ8fMZWjcqXExALD74cuk32ozKRNvwvO3bc7Ho=
Received: from SA1P222CA0156.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::19)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 03:07:34 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::76) by SA1P222CA0156.outlook.office365.com
 (2603:10b6:806:3c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 03:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 03:07:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 22:07:21 -0500
Received: from victor-x86-02.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 22:07:20 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, Victor Zhao <Victor.Zhao@amd.com>
Subject: [PATCH] drm/amd/sriov: extend NV_MAILBOX_POLL_MSG_TIMEDOUT
Date: Thu, 8 Aug 2024 11:07:07 +0800
Message-ID: <20240808030707.2935006-1-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Victor.Zhao@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: c54b0f85-7861-4343-f7b3-08dcb7574009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s6y3AjZupKsOmKLZ+SfquQEj90CeLUlIw32zRDTvZdZON4Onzj//iKDrbArA?=
 =?us-ascii?Q?+RrR5+hKiQvKfoWfyxZIHmEudmiA4KjPgvXvFbbCZiGroYz0zcrhlxvgiuno?=
 =?us-ascii?Q?Ds4N+obovO0G4xS7r7sBUJphACpNoUOVqvv+suNw19n6Lk/Ob5XJI8qIwnNo?=
 =?us-ascii?Q?/FrqPutvtIDqaTlBFg/gML0PcvR4mXegP+syu2Iky+BPyarHqzpQIYsCphHr?=
 =?us-ascii?Q?cEtU9vtvTeYRpmzR9qR0X2UoU15eyYZ4RIPZGYXm16c8v8qh0MNw8Gk9NqXm?=
 =?us-ascii?Q?pvvnK1re5/JILWaKaXpuVS9E39K6krKjGmHCSIL+07zIGLxXj0YAySaglWht?=
 =?us-ascii?Q?3VfytkrXrvrbD99ANKulzUPsZzHiLHV7wehjjAvg808rkYzi5AmuHIB8njgq?=
 =?us-ascii?Q?uwj50gbDtikgfOEZTmlhHxnK2oX5cU1PCMlE/mbn7k4QD5xmLHwTE8U0bAAB?=
 =?us-ascii?Q?Qfq7dgeGFpqGidd6qk3IZguFpMZ0sTWTWEMi6U4u+CnaJGHndO8XyI6Ab1Rk?=
 =?us-ascii?Q?5MqmRxxkCFCtEMpNjvXQrhvxCXJjI5wwTTH3+8aFHdSg6Owt5geKKGW3PAfr?=
 =?us-ascii?Q?Xu9P3O8FHDZkWWQqxADuO33/Spx8dKh2hau1aasXX8edRG7pGovPihC7pF1P?=
 =?us-ascii?Q?DHCiM2Sfy+LfYXHBSgNV+0LbHQtGZpaTIbJekNhyicNkqHpEQPCQWEfUIdpe?=
 =?us-ascii?Q?1i2Ctul2BMVt/VzAEOhwzD7O3s6yFUGoZ+W77RKxsPF5Pa1rO/U1/YtxftWY?=
 =?us-ascii?Q?OSHN4U9OVut5dotJY30bKtyDONCFoLZcRbbDLRfFj5DFKVw5ugWVHwDG4FBx?=
 =?us-ascii?Q?glPW9m/oyX2jiKw+cGDo5DiJcaaKUyGsBxWbMeSS4gLOkyDGz0zWijfE0NAF?=
 =?us-ascii?Q?2NUh3PApvYvOpj4uPdaqzZkp0QNw+QQApgUs43WOdjQihD2I8/p/BmkQfzAc?=
 =?us-ascii?Q?te175XqYUTcLl+jZ0T98ZqifQn+1j21ziX+wS+EAFaao1/3EzPi+lzfSCqqg?=
 =?us-ascii?Q?NmusSIgCw5FI5xXUcxLjFL2OXDE3UqIwKuus2+wF4T2EaXsMa8AXoHH4mxCd?=
 =?us-ascii?Q?RtpqFGAQgu007y4VaeGj50bvmupaxx2sp7p50V+oRa9WnaYX0bld6kJ7dpQ5?=
 =?us-ascii?Q?8NBowHpyr7NQEqWL8JIxlkv1tw/5L/EfRG9W4n1T3auiVvIUpqglMGJbndiM?=
 =?us-ascii?Q?sssU0MN8Z3oMivQEPnU3LddXiFJNSB3CL6e+tso6vk5JiPEGcXiQPR3Ycau7?=
 =?us-ascii?Q?do3juxmwPnvo1EAh/JuJ9aSsXODhMru662ItALu8URDVZcF/B+cBaUmOsYXU?=
 =?us-ascii?Q?ifRjzz0pPdUDL+zJ0c+Rq+W6rEMmupZ5K3JVhzlhK+UThFti/HpXk4Jde+Lz?=
 =?us-ascii?Q?TBQdMUlIE4OnyrA9j2eNeCypke6Tii2MRDDnsEAtJyV9Jc7iK9MUAUKgnNSY?=
 =?us-ascii?Q?GapF5XQEchH+mskZqC9zlN7b65OU32KV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 03:07:34.3419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54b0f85-7861-4343-f7b3-08dcb7574009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

on MI300/MI308 UBB products, when doing mode1 reset, since 1 gpu need to
wait all 8 gpus finish mode1 reset and then do re-init. As observed,
sometimes the gpu which triggered the reset need to wait 15s for all
gpus to finish.

If poll msg timeout, guest driver will send the reset message again, and
may mess up the following reinit sequence on other gpus.

So extend the time to cover the maximum time needed to recover.

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index caf616a2c8a6..1d099ffb3a5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -25,7 +25,7 @@
 #define __MXGPU_NV_H__
 
 #define NV_MAILBOX_POLL_ACK_TIMEDOUT	500
-#define NV_MAILBOX_POLL_MSG_TIMEDOUT	6000
+#define NV_MAILBOX_POLL_MSG_TIMEDOUT	15000
 #define NV_MAILBOX_POLL_FLR_TIMEDOUT	10000
 #define NV_MAILBOX_POLL_MSG_REP_MAX	11
 
-- 
2.34.1

