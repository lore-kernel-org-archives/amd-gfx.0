Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E84DC87FC5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FB310E612;
	Tue, 22 Jul 2025 07:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UrhzTXeN";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1522410E611
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ealX54UumbHdLxdRahgyDI0skO7uaa/bkyRhZcSoIjHCy+c6JFkjxCSAAGKRvUmw7g4V39pCy3LalMjDnUoejToygqOOxV2mbQGEDbBbfS+OC68kf2DbEH1Zmq8s0fCCZ96k0uEkeiutWXGZAI+GbpC0bNMbzgMnuttwT/f8CujzHZTPWgwYQyKkkpQQtlu33rWvYTVONOwCTHId7eiNJtYTmTbdzltuoMhQmVthswzdo71kK4wCU6AtHXeXkfoRw4WWgygVhBQjV2aXFkomEHmcnmBEVXW/X71FIsqXdqBaYosjjnf+vtnShfF5hbhi5xNX4RB4J1rxNc3jB0I8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrD4QyHJgmqc2tB2XpHRobWfARxjn0Kbi8jgRAJcJoQ=;
 b=s9Pi8M3mMI/u8LZCJ++qmlIbKRvTBn6Qe0ac3mHs59LcYS09C6AWZoTN1CmvHBnOqwsT0fNIpLMVnR8FGa2cfOmkCyBi1RrBGSn30kA+67lAopTxt0Ll1N4/+QbaPxDxEYpAlCgLAcVxj37Hp52KehyOsn817gwPAUNXTXE0lquwzonMX18YKsmWaEXzAF8KmtE2do6nQrnu+FpCMg03CLUJ46pURHnu8ZFt3/2ZM/15TwVgIry8TF/u1K+kxdKJG0Kem92Yc2ipou1gvSOCiENlrmf0DdQFBbCQQNQdBePdMJps/hqmCmjunDKP7ZEFEVNF40KSTJlB7sjUJ/AbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrD4QyHJgmqc2tB2XpHRobWfARxjn0Kbi8jgRAJcJoQ=;
 b=UrhzTXeNghp6F4CPUawkOaFxR0Vzgfesb0RVTCFz7987gOadmooJjV9hiQi/33i8y267oWLW59qLuzkEUgwtk3CoOmlI+r1oTXDGFiUUNEadPZw1o4HCWrQK/tCNeVuyx8/L+UxOFCA+nc1LyUrU0PsKo9CCE77mhB6eRnVWehw=
Received: from MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31)
 by IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:46:55 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::2d) by MN2PR11CA0026.outlook.office365.com
 (2603:10b6:208:23b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:55 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:53 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v7 11/14] drm/amdgpu: keeping waiting userq fence infinitely
Date: Tue, 22 Jul 2025 15:46:20 +0800
Message-ID: <20250722074623.1464666-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a0b44d-5a6f-4dee-ea8e-08ddc8f3edeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VJaKyXHynKOCj/lavegJ7UJlA0S979K3MmyWtjyBGDTXMEYcxNcFKhPQ4Jm1?=
 =?us-ascii?Q?hvZHOM4GFp+jTmHOTCVQ4MrgpsOig7bBAFrclpV2YxA7xWdyV/lsiZE0cx6G?=
 =?us-ascii?Q?z0V1dCL4VUFAi50lFlIe+ZezeOmc2EsMxNv6DcLVlqwawRiuWaYtunYYDUoK?=
 =?us-ascii?Q?/PnDZaSZRXzK4utj3qDybwATLb+/gPzZunSH/i2ayQQnbmq+evG3/SBeBkDh?=
 =?us-ascii?Q?aPztC5UAPFsRHBgZ1cb2868WJdW+Mp5I7a4TLnMWwxSB31KHLL4BIQv2z0KD?=
 =?us-ascii?Q?D0AaUL7ahiVVi75YjMii8Ev4SEHa5K/ssvHbV6iipi2ZWtubZX2kl93L81UE?=
 =?us-ascii?Q?/poakkMqVA9ufl//G+jCT6GbqYnWwE04PpBypcYyiw/rxlhbxG//TrzkTdZG?=
 =?us-ascii?Q?/SVeW3kFt1SzUn8FsMJOu47pAYAKhVXPZzz9+6VitAV8v/H55gg4GRljRPRR?=
 =?us-ascii?Q?pe+rVl7ThoS3a4KTn5aWObvhV1uAXn2GQ8QVz89vbcgAsL33glx6hBSZR89v?=
 =?us-ascii?Q?uDNBdCEVym4WbcjXYWVI5R18S2aO73sCt9JrFxPODL9WZbL3dXkO0fEi2G3+?=
 =?us-ascii?Q?rhxSCKOyOTWoSFhHwsnQfsVZD+gH9DII4hzCNjSYsgW4kfUPMrH0BkwEc0I2?=
 =?us-ascii?Q?KfJxAUGrxWX/DmjTocsZZtA2P2PO+r7pTviVKA1eZvPvKES013XC7BrrLbF5?=
 =?us-ascii?Q?q98P0Kau73sdZQtM2Qcp7W5U7N5Y7nPuQDhIgmgh6tNQDBdQlE4P6OGQZXha?=
 =?us-ascii?Q?PISU48t6H1aSm+Nd+Sqnk3X5iEyFftuxhO6POJVS8gXpUCPWBJ5SXCSJPFzG?=
 =?us-ascii?Q?myGTAwHSwhYgyQVmCsgEdHHmIpAvQ87cAm80LSjXbJWRdIM/u5ZzPhLjDdI8?=
 =?us-ascii?Q?SOl+MmkE6wkQQHMd9XGZC+CZVFcvluu5CVl2ghUCDJ8KSHL97LqzIQKnC8Qb?=
 =?us-ascii?Q?/IKRl8LvyXPULWnLZhvfHG0wSgZRTul52McR/lrTLmg9RKsocQuVPpl7rprB?=
 =?us-ascii?Q?RfHLN/E1gzBxAJTMPTBXJ0mLYzkernbBEWfF5d63/MLhL6mbxOsl4r2gS++t?=
 =?us-ascii?Q?8HTIrx19h4iq0HkLBKdhyKmRmONpt1hpyCj+Pq05SAIz6kL9k6OWgC/CaMBz?=
 =?us-ascii?Q?Vk2qur05ANpRed3twSjXAKBeaq6rEAFUU7OZv28dN3okaaL8Z56iglFcyLc8?=
 =?us-ascii?Q?CFTmeTOEq7G3jQMg+yFOWPWPACrCzf+MUNk+ii8MFDFkQuKNRCqxZFSek2+a?=
 =?us-ascii?Q?QDAJdjZWYs4j8rUCEstx5fMZYwv/OqLvfcm+6xR9VN3C8ysNU4OtJN4CWe2g?=
 =?us-ascii?Q?WQN7K5cV8bRcH4EfEBic2UBbMI2odzSgbkeVrbzCBz5c5k/RHmHhkA0zSWM4?=
 =?us-ascii?Q?C8eCnb3tD+5BPAXV7HU6Az7OWxbEjnvWGzXyrTdeKtsbqJnxNYqlEgasTBVb?=
 =?us-ascii?Q?N+HYufdHVfYEJ/PROlliXJESBloGrr9ZDmtSw7n+G0ra295L9NA8rQUPnAbb?=
 =?us-ascii?Q?aMZdWFbxgMzcxPoAltZ29LSX3HtIJF/9xb4i?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:55.0316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a0b44d-5a6f-4dee-ea8e-08ddc8f3edeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762
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

Keeping waiting the userq fence infinitely untill
hang detection, and then suspend the hang queue and
set the fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 693130bff339..7d685f3867b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -281,7 +281,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -289,11 +289,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return -ETIME;
+		}
 	}
+
+	return ret;
 }
 
 static void
-- 
2.34.1

