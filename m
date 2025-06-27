Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8E4C7EE32
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D42510E945;
	Fri, 27 Jun 2025 03:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0QFcfw7l";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3307E10E944
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 03:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIYvTtfLwD++b1z4hyyjPww5XeO7FsTB3LHeBVsmrn8yhd1C0uALoujH2dO7CqRbeTtmsWoLpN5Fx5Zf1UslxknE2lzxShZa0K8XGVSCkRPVfNLQxyhJS3Ayr1HYiXpBp62DaDC8kfHoDr3HWRu1sxt3mBlq90fZi15qdFBJmwYgoPRFnGE0QLndQZDXMT3BioLnpitsXJ7md1T3S4NaIq0fidTwRjxDEdcWYVqOB+65oCzfei+GnC3bx2G1iho8qVvGFMisc2DUG0EiCSlEAuXRhjAMo/pGzK20kYMMKSRCtn9LL4CQgL4HqQCrlbtNtO2ZoUwIiXYWqRAwAm0qDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1x6ZytdluvqGYN6PJFyaufF5Z3L305Uy8gNCAFbvQ9s=;
 b=ubIM+qWJBevT7HUd/lIUDOK7a7WqqfozsMWSHeMyJKbJxoBw8bf/dlLt4VFAUdRW8sFoOlNwhkSc2xa/YIZgv6f5MPzO3sE8u5Nkb8xAm4WaL1sezC17lj6ecUHzFsgDf+49rhk6SttbOPVvEbWR1s5g5dWa8lhdpQQbm3H3DqDJOXEn7v4OEJ+wyQINWPL0YUCw0erNBkhw4RobB3o8efYcYMVv361tViWEDulZo95m0ou8ad/vd34XGkeMWj+wVA9QlvpI/5E4DnodFNsZFgERd/8Upm5GHOakyCT+gB5gvRUyguAyy0J/dHkgsjZDqBIbX0yEJFN0RpkVZqC3XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1x6ZytdluvqGYN6PJFyaufF5Z3L305Uy8gNCAFbvQ9s=;
 b=0QFcfw7lCLUJIno8V2XGjgB+T96Gs2NBnqGHe3KzOLVMHvmoDkU74hjHCWBFBFGinTixEKYr3I72zMc7FOQUuTtfqQ/e79ULpg2CNX4SXECQNFRGtL93i7NyKsa2wPX6NBPOhXfhayx1wLqBzBSD3Uv4ytsyw87e9i2FFRwSRtU=
Received: from BL1PR13CA0203.namprd13.prod.outlook.com (2603:10b6:208:2be::28)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 27 Jun
 2025 03:40:41 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::f4) by BL1PR13CA0203.outlook.office365.com
 (2603:10b6:208:2be::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.7 via Frontend Transport; Fri,
 27 Jun 2025 03:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 03:40:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Jun
 2025 22:40:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 29/33] drm/amdgpu/vcn5: re-emit unprocessed state on ring reset
Date: Thu, 26 Jun 2025 23:39:58 -0400
Message-ID: <20250627034002.5590-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627034002.5590-1-alexander.deucher@amd.com>
References: <20250627034002.5590-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 139c2d3e-c0a2-41a6-4411-08ddb52c63c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tufsALUKF0mlUVuqEh+9obJlCDBpKXtIPue1dmHul2sbzbfxJxqZIgL3WIV2?=
 =?us-ascii?Q?Yd9M36NE83zuRgpVgmVCe4BeFjuW0W8lzu6M2uZkHrD7MW6U58Ufrwo7Ymcv?=
 =?us-ascii?Q?2uj9FEi67fzmcZTw53opBZSHOmQzAIhmJe1j9+OMuIV6etchDMm+2QlZK+Ql?=
 =?us-ascii?Q?i0giU2pryNJjdIxoeY4m1pejIRXefjHxSAcHgYPUL4X5xYM5juFb310gDsyg?=
 =?us-ascii?Q?KY80SdNSNG4EOusoPtD+44p1+8/kwPrGj1+lN9yvZA/MkDV5bgJuqdS6Zsib?=
 =?us-ascii?Q?7rRC7ELu/JpDcTFCW7tVb9dH2Y33RnunauDrfg9UqkmBRQjfZC4JNJQNIVxS?=
 =?us-ascii?Q?whIMWp+/41lBhj+Neyc5G50Cr8ZndH/zqkqq3VZFQLznjN9ZtankLMUczJe1?=
 =?us-ascii?Q?68ZyhLvOkfeCarGQkdPhsM3A0h5kmrYVwxRHPmLSNAuxhfsTNrZbm27ZRKHB?=
 =?us-ascii?Q?n5BMaIdi+aX9jsm3Js0TRcdEil//RiJdFrogwR7stBM3+KxpVtw2mNm2aeAX?=
 =?us-ascii?Q?loap0AiY/+NrJlrbp8FRksRwN0cFUR6s4lR5wXTH7fxRqhPpOS0NfwnJhPQi?=
 =?us-ascii?Q?0aTSXdv9dEFF/OHu39lxpwPaK7p/5TdMnlk21YHrphW5sHtVeFZrLM+Bh+aQ?=
 =?us-ascii?Q?Ah2C9f239L3qKQw6youiSfSaIaVWkoSwqw3FDNDiqCKYZyc3T47vh8EFNXLw?=
 =?us-ascii?Q?8LsvQfX0WDzAz7tbvePhgWT+a3U/QzTosp6ImC8gq9ifF63QWWhXs4Mhickh?=
 =?us-ascii?Q?RvZj2id0dQ0ayocLYdWl6iA3xlUKIfVQ2vurkTCYbdhqdMP6M74/+ZuxFVsB?=
 =?us-ascii?Q?lU/Mq4NbXWLaHZkslwW0xlhNY/oCl0XTc93H7QSPXGW7U+osp85JiWrXGsUG?=
 =?us-ascii?Q?RYHWa+rKbhF6Sy+xxwBCrIaWowk5XmfNYHvqSifdUXjOGz/dZMTi6M9H/Lq6?=
 =?us-ascii?Q?F5NftOAeKP979ptnldmc9DI/VnHr8Doz8bGUcZd5FV0pAbi2I5l2A/M0fQdI?=
 =?us-ascii?Q?NfG5TGsDhp2T/k5OAvQjJ5EDN0qTbDwkLNQpbcPhxhYW1/9mTTgO2y1FmUiW?=
 =?us-ascii?Q?S/3yM7rDmPRWtt7lRXKamRZOAvIkTnxsUOj6o33lw1ygHbgJEk4M4ja4363q?=
 =?us-ascii?Q?KdTA5n4DMa+nOS+UXU+zrolJVeVb1rDaFqCacApztn8liYJyza74BkLrCYO1?=
 =?us-ascii?Q?QQGPHjWvY1op52oSpej5TfR85F7nEczHr/yP7b40yEB0SXjCpKtAGDd7cwmg?=
 =?us-ascii?Q?otgVUBX0MIYm0Fszm5q5j44bDGw6PRhyHRaAiUHosBCvSK7F9c7gHn2mtWPg?=
 =?us-ascii?Q?c9/wKLrEEz51FjEvPd4011VuCg17bTKJtQgtSBo0NMOlpB11BXORMv0r0yk4?=
 =?us-ascii?Q?PnRNkyVG3RmxiU33t8+6pQExl4NOWws+JRLTRpNrWu1nmlNTTFe+VqRvtz4d?=
 =?us-ascii?Q?MjLLDy3ayeoR5WpI7OUIRpD2s4CIa9RRLULApgiHuBulyYX5OubM/Hds0JSc?=
 =?us-ascii?Q?5h/EJNgNs8LxTlH0yxA37UOwxuV7KTtkygw1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 03:40:41.2902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 139c2d3e-c0a2-41a6-4411-08ddb52c63c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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

Re-emit the unprocessed state after resetting the queue.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 47c0bcc9e7d80..5997927ac6db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -1198,21 +1198,14 @@ static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
-	int r;
 
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	vcn_v5_0_0_stop(vinst);
 	vcn_v5_0_0_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amdgpu_ring_funcs vcn_v5_0_0_unified_ring_vm_funcs = {
-- 
2.50.0

