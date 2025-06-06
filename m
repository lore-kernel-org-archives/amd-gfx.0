Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F16C61DB2
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C4CC10E9E1;
	Fri,  6 Jun 2025 06:44:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xgVCcasF";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6823410E9D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0pHOpXfmCqUljYzxKFcST4MFVfZy2n7V1n8Z9Serh9hDfHvLE0WOSATv1ht1MWz85rSKwerEVAhKi0lMhT+c2SFLxQjZn1G289L/thS7psjP0nRZW4dndQIxlARfEhmUZiP2IF9arjGhfBmq0t5AzRH4NwQfWT50n/bxC8y9ubUWa/kSAXlv/W41mj3lZuAbUCP84Gg9ypNHON/sQXwQQlClFB/nxAbZ22hsgXgExBWHn1eQtsfj955js7rrbgkK7i4VrY6vJ+IRfO5m6EOUiK5sm5tIpf2Xl16rPlWsjMx7qqrjzxD8i8/jHHZ277q3icc3OBUp7K2gvNkLprqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVMB3VFIFPjnC6JaDcnGF8JcOQkl+fYri9wfzeQQBvQ=;
 b=yir15+iP0sx2pks+8Nnjx5j1IKrXIY1cfRUsgeSik+l+u+joRWxJuaWuQNXX4Q/Ko2AQ0ODLhFOOZ0fZUtLFzjCia4bOU/Q4Zq4UKnohMK9VkmxmqMVwtTHvd6EglQ52JxVyTV0qQ8PcXbp2Th2kGwYhQp/YA0WsjCxbeHykR/+n4AnOmF8HsW+D/CEresPrsporJUTXXFfsxGQkA7pC4xwaSefq+kVvSQIuaorImoZkWEowpU1HOk/mMxawjJSaOA774N7RqGzBYWBicaj1zdbQgUN8LSsn7eUaN+DpvJLs86DFc46tMK0Vbuo8mnYlGCoo/5e0QnP2ruQ1RgeqSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVMB3VFIFPjnC6JaDcnGF8JcOQkl+fYri9wfzeQQBvQ=;
 b=xgVCcasFFltdmpI3uzArxxmfiWprDPET/TzdbhJ5m8SDjvcGwXLIwzVumH3SlWi67TLy77iDL1pTm/70VyajME4L/07CkNeu7fufNRhcAekxnnJtav64pZWz+hIFHdLiygLWUvqnmV65JA8wdEDY0Yf7CqAC+2ZJHGE2fXIzxCw=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Fri, 6 Jun
 2025 06:44:27 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::10) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Fri, 6
 Jun 2025 06:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/29] drm/amdgpu/vcn4.0.5: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:53 -0400
Message-ID: <20250606064354.5858-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: f95e165f-a948-48e9-127d-08dda4c59551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XhkPeGTF+cBFhPUxpvr2fow/+fuafQZvNHDBH7m7IWOyNcA82vBH6wIbEmj9?=
 =?us-ascii?Q?NurJLcJAvUp7aSpiNzZzkNwgIVIQAWkVoT7XSwlrGjRY+aqDZua5atPNkKi/?=
 =?us-ascii?Q?QOCh2TC1hTqDEnscGiNXJkhnASXeHWpQA7T9O2JKvYFAhgPGLKRm0X00ZwYo?=
 =?us-ascii?Q?v+dYOCe1nxT+z8BLPqYhmhxwB1Ft4AOGKUycrgaoANfe9p7e6orCgruAHLhf?=
 =?us-ascii?Q?+V4Tdm6KvpDgV9EA1QGFGHrlOf9s1QuEFi9JfmwhOw6SrI7sm8YuPBsayo6q?=
 =?us-ascii?Q?9boCKUaO0LHFmBCc4XGD3e7VsK0g1WbY28ZXVrPAD1zVTbXPWxTtl7BUb54Q?=
 =?us-ascii?Q?Fgin2LImb4IjqLhkb8X7EEJhqzV+KUvnW2zUnZoopyaRL+LMEjWVjuIEncHM?=
 =?us-ascii?Q?dluTy0G6NJiM1rGJd+JjHR4MbY29YxMHs+3Y8ZpdC/wT9jud9uBuWHU3xT7K?=
 =?us-ascii?Q?+0zdr0ahhgaYbRoC2uXs0vW98dn64m5vl0l1x9sI3pBBE3bz03eSUSQvfC28?=
 =?us-ascii?Q?1TodDZ6g5usTtDdTuwLHHiIEHANEFO1y+izGSWw5DVXz5Yec8KY1XUrWkgTo?=
 =?us-ascii?Q?snpTlwhGLg+2XKijg99VhygP3IEL6A2XnO5ORthP79iDqLd757C3ewxiHmpl?=
 =?us-ascii?Q?7Z5VnlAIrbRFqF4VE1nujn3mEG0dy1uoWQk0NLTPKIoeszCMBVHJlqwEZeBu?=
 =?us-ascii?Q?H8ILbStjm4b9ZuO6fA+9HQyPnFjnO13Tq63+Th8GzLRyLjXy6fULdqQSKwrZ?=
 =?us-ascii?Q?yA2T+2ZQESgr75do7PRBsuONeS/KB9Zo1RX7p4COsEs9sBlXOX5SkdrGWXlw?=
 =?us-ascii?Q?xU85Si6zg6UfCIzOeSSNOpg1OOKeT6mGG3q25uyZfmNqgpAEoPE918/3Id6g?=
 =?us-ascii?Q?ZGv2rtfJ2rv5nY/zcwiUkn0QZ9SHnITVjiQDWPQBaCHFYRmRBjhhaZlZ6YE8?=
 =?us-ascii?Q?H5BZ1VYLkwGolAC75eCJMeDf2bHyC/8zn3ZKUVHPq+7yBqWdWwzNtF9rmmrO?=
 =?us-ascii?Q?DRm+xHf1iQuxCA8ognHkB++g38MNsyundzxX3AnjnvNCAVOul5AY0e4oDmij?=
 =?us-ascii?Q?QDi7wIxSb0ZXY28vIiZI+n3LdUsKRBqOxy9kYFDPyps3tNJRFvxCY/nCp8We?=
 =?us-ascii?Q?yvKfVhfKLyjOkPQwtn43t/wYjCewK4q6MDxIQkoVpSbCjpNo96rsu1ysTbvL?=
 =?us-ascii?Q?QGrcR6eYh7NoLaNFOLdLeQDV/wFk9uInp46WLMaJiUplRtsUlm8lkGFxAKt1?=
 =?us-ascii?Q?m/lq/T7ynM+QBO60VYKNyD5Bq2fJJEz2MvH8BftRGblezmG//rtb4dT4Noz8?=
 =?us-ascii?Q?nzs6yO3p/xKWCKUDO/hO9wcfR13sQpRHDQfULGUlKxLIlMB/mbYHS8aL51X9?=
 =?us-ascii?Q?ZHKjC/AFx7FhNFtmkhsJZmFDsAXBtPcwJJzyOuYQUTtLLPuf/TuksF0FM7ZU?=
 =?us-ascii?Q?1s+LWY1uKx2Il2mqdi239t7bIVyebOl2N7K9XhQfJtxR+foFqj/wvtQR1Eak?=
 =?us-ascii?Q?35Fm8UHB+3rUOXl8Pw0PVgoOaoZ4zCuBtaY5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:27.5848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95e165f-a948-48e9-127d-08dda4c59551
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 93bc55756dcd6..2082336627d31 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1475,15 +1475,23 @@ static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
+
 	vcn_v4_0_5_stop(vinst);
 	vcn_v4_0_5_start(vinst);
-
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

