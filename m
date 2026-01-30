Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC298E6BF33
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 17:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17EA10EA2E;
	Fri, 30 Jan 2026 17:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u8cA3Mq9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C41410EA2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 17:31:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npojrBL7PVSH6OtpKf+qw6P9/Tf6kJizyTb2E2A8P9QEpB+U0Dv1SqWo9xcYRTMKPzU5rQmI/pxuW2UibK0wHhd5mJsAw3fAEJ5VSE2jyBlgCDEQY4d7/VloN3504dlYqfqivCUtI292kJysnbUv7lfBtlGKLES2LfcqhWbX2W4N9jG2yNrimE6XgclaRCmwJbdRQN9+MDYPqz5r1CSyiYf+jZh76bYeYodjTjn+xETbBr+SJGGRyxZbW/abnKDresJJLgkKG0I3MO7IXB8rj+pPeSdigYIiqzDyJnDOlHMfbscelFO03XDh8YPXZwQ77gWyUHqiyt5jVPNTBToYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQBUTPex+wLXzSug1A5R/EVq8YtzhW7g6eth1voshIc=;
 b=qebwoja5lu/BuTs656pdGFWuP3z2VFgaEJO2afR9YX1tSDzU8qdk0B7cLun9xv/VjAmHh85C2ZYP/17vdUyFfnA92r3SVpCYeILKKN2jzeX/J9ZJx3QjazIqmwwOcaCd0uoZIqIltxselpmvcb+9iOEswQYAjhkfFhZevSTeRGhP1uvpjbEQk2tvZ+pJaHA1UVAf8UK3WP45tFKnOFaLtcGlGgcQAQ5+jInQD87IvvTJc7RXNZNoYL9Tf1TujWMtHo5G4N94oBwDaafJB4YBAjKS5hk4Pwk9rzFOfqUFbWsFFDNS+avaYCGjdw6HmAMIcM14dtkZ3pIzy8cPMwHRCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQBUTPex+wLXzSug1A5R/EVq8YtzhW7g6eth1voshIc=;
 b=u8cA3Mq9/WbwcK+tXlBV0Jg2YyLlyOzUr5oCob1eisR19kPc239Wqqfp66szLWbNdoFrkLPaOTBstXvHqP6CE+Fdmoel1tkPgvWrQ0g+xHH9K8wHw39S/pArdbDpa1SyQjmQWlK9Z6SYetZ9mVat7flBCBZOMX4nhVxGLVirApk=
Received: from BY3PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:39b::18)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Fri, 30 Jan
 2026 17:31:02 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::50) by BY3PR05CA0043.outlook.office365.com
 (2603:10b6:a03:39b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.5 via Frontend Transport; Fri,
 30 Jan 2026 17:30:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 17:31:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:31:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 30 Jan
 2026 11:30:59 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 30 Jan 2026 09:30:59 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 08/12] drm/amdgpu: simplify VCN reset helper
Date: Fri, 30 Jan 2026 12:30:38 -0500
Message-ID: <20260130173042.15008-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130173042.15008-1-alexander.deucher@amd.com>
References: <20260130173042.15008-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: b14154f3-06ec-4099-8523-08de602556b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q+1lpOS5ugo8w9wZYSmsMEdl8cl7j4ADbyQyhab49W43niTFCi8653TzjAaT?=
 =?us-ascii?Q?Rbu7ljqk6DXFlg3yl3b56rNuaY5+H+PwPXPPGdCdhPXtpB0xJXQxrdwLEjsZ?=
 =?us-ascii?Q?gbExVjd0gXMWbMj2bdNOYZicv706LxAUWd814aavBbi4C8HyAUS0YZH6ScbJ?=
 =?us-ascii?Q?7s/4aWUT7vVfUD6VDsCBWGPXD3SN94MklYCYOwZR8C+FJIJqkhdfZie4j58+?=
 =?us-ascii?Q?AQ/vn5vWSksky3OZEXL9opyhP/wQhpge140kTw4jiva5/m4rKgwbe59xWOj0?=
 =?us-ascii?Q?qyhG2V6cqNAHShbRObuGHuaPtULg5oyfiSHvi3zh6TtEKRkE6bvAO42POvUe?=
 =?us-ascii?Q?cdmRuj6pWhhk11bAwsYRCAuCFhzoQqyz9jDniz4CiimJI/zwcCa1tA8Q2Qtv?=
 =?us-ascii?Q?oUfcAAyg20zM+jXbhoUVOJq+TTkVfwbIwATNfEqddLdRULFZJxIBBdj+iMff?=
 =?us-ascii?Q?tA64o9UkpcV9+gNc26YKo5Ar6tmBeI1BCUW5wdtwujlB3jrqpNwlKV22kOkC?=
 =?us-ascii?Q?RhFnsSlmFuaaaE9kHErfLwKS/Rs65rp6SI2+BQE0mOvwSOU/gvx65n7x4CES?=
 =?us-ascii?Q?8Pq8iFSy9tdxt18aCwgkg0xQ2Q1FK/lsWaT1OWITsFJw8eUGRMgpjeawE+Tt?=
 =?us-ascii?Q?1TnjTK97FUU8xu3jCg5QX/VuEj4S6edc+tFWaO/1vYqzxrK95xF9qLjwnEbV?=
 =?us-ascii?Q?DYf+YgK1R6xQEdh9y2BlqlnSr5dYmnG1k853ZAfd8EIyGmSE8Z4fd3JVFB1J?=
 =?us-ascii?Q?LN8YBJWGGgKwUc1y8LinDKjx1d7ZnZidvmDM5VexS1BB34122Gz6bEFvf/M8?=
 =?us-ascii?Q?EQB0JSRwJUctqd2qCV5wYYNbFo7kPMCCFwRf0NGnNXQrrg2LYEolHi45CFMX?=
 =?us-ascii?Q?PJk5jkgOTWwtYjW8q23q56x5C0ZN7VkM4evxwMfRYL8PQvwuOC4y8w1pW4RF?=
 =?us-ascii?Q?l0SbusuvRhJcEmu40nQEA9FgMrOjtjmZkSCcmQmaraIhii4dujXD9UubGxhW?=
 =?us-ascii?Q?R0AuyegwgDk3aaFUAPWnwf8IrZQKPRf8ms3fjkIwkCk+Nca38Q39iagnxwqM?=
 =?us-ascii?Q?zDHPJt7sD6YNY5QTuVmplaa7TWOSxUlH/T1xVpO+Ev1geli4jj2KYwPBmLwU?=
 =?us-ascii?Q?OVu620HcZ4e0iVJWq+zRXfeB3o24VjFhqTdGBVWdOlitXxjQKtR+3+RnPbKL?=
 =?us-ascii?Q?o8N1BzUAaTvH7hoHROw0WSJyMjuZd/oOWPnKQofX7OVR+i6wU5T4jPlgevkV?=
 =?us-ascii?Q?qvSpqnInV49FDgRrU20NKWBG+WBiVpzByTLmfAPOAXt9+lokQEs3bh30yB82?=
 =?us-ascii?Q?KsnY52giEZfRwO6lLb8cjMCWA2jRO2nQpeQsxVdMsA9umeN/ksRm+Ug++rPK?=
 =?us-ascii?Q?hbhmzWz8FdlJ/EDJ7tQOUd5Oq50SNTgYZc8E8aA1yLWbjRrPwhWm/xMFwmVI?=
 =?us-ascii?Q?suowq3P5QVCHXzAdAjDrSRx9S76CM1sB12EI60lWSoATx6OPqu4tqzn4qZtT?=
 =?us-ascii?Q?klaOo4BROUzBX/RcF92Vav6xLWeHrBvBi6ydLWjoLpztb65Lx9CtLv9Z/APM?=
 =?us-ascii?Q?rcn/maY3CUaBJODBK0GXBy35Loo3fkjTnKOEGommaiFt7UdEqT9X/SP8ycj+?=
 =?us-ascii?Q?vNTd25fpSN42XOSYnWGbFt5XMiCi5l9fnvF/Lg2NLgig?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ohFaor6q6PEJ7I2pyalGkSRp3wsBPMibnVbjYN01G3p698xkanHemQ/wge6257yiEYRhMy1My8UkLmS588cesDfReLcbbJ+vZBxPwZcIk8qDKTnh+0G8ZI5rW6ckPfU8DweaZuAXBSuxz1bwGnGB+WbIhc9X+QwUZ3Ms9k5N95sSEJmNFYM6auq6vLmJa+hKpdixyViZYzZTxVc+Jm6kpmAheF6b/tN49I8LCqQSH9x1Uj5zny35f5JY78BHsKVm0jIvunIFcuFsHM/TMquI5jUUuaPGHAZPL7yBQPBi1Aw2IU8prTtYnwrJTPqZAWN4vbr8i2dLPviMeP4TLO4ISrH2o7y0G8OP9WTxv8LiOarQt+C/ubzyzD48AbgpkwnEwSBQxzXguRJijFfVL03Evd8NmjTlIihJrr5fZ9D9F4D/z65/3l6pOPopYmazX7gO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:31:01.7349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b14154f3-06ec-4099-8523-08de602556b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592
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

Remove the wrapper function.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 41 ++++++++-----------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index d22c8980fa42b..4de5c8b9a4cc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1481,19 +1481,27 @@ int vcn_set_powergating_state(struct amdgpu_ip_block *ip_block,
 }
 
 /**
- * amdgpu_vcn_reset_engine - Reset a specific VCN engine
- * @ring: Pointer to the VCN ring
- * @timedout_fence: fence that timed out
+ * amdgpu_vcn_ring_reset - Reset a VCN ring
+ * @ring: ring to reset
+ * @vmid: vmid of guilty job
+ * @timedout_fence: fence of timed out job
  *
+ * This helper is for VCN blocks without unified queues because
+ * resetting the engine resets all queues in that case.  With
+ * unified queues we have one queue per engine.
  * Returns: 0 on success, or a negative error code on failure.
  */
-static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
-				   struct amdgpu_fence *timedout_fence)
+int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
+			  unsigned int vmid,
+			  struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
 	int r, i;
 
+	if (adev->vcn.inst[ring->me].using_unified_queue)
+		return -EINVAL;
+
 	mutex_lock(&vinst->engine_reset_mutex);
 	/* Stop the scheduler's work queue for the dec and enc rings if they are running.
 	 * This ensures that no new tasks are submitted to the queues while
@@ -1537,29 +1545,6 @@ static int amdgpu_vcn_reset_engine(struct amdgpu_ring *ring,
 	return r;
 }
 
-/**
- * amdgpu_vcn_ring_reset - Reset a VCN ring
- * @ring: ring to reset
- * @vmid: vmid of guilty job
- * @timedout_fence: fence of timed out job
- *
- * This helper is for VCN blocks without unified queues because
- * resetting the engine resets all queues in that case.  With
- * unified queues we have one queue per engine.
- * Returns: 0 on success, or a negative error code on failure.
- */
-int amdgpu_vcn_ring_reset(struct amdgpu_ring *ring,
-			  unsigned int vmid,
-			  struct amdgpu_fence *timedout_fence)
-{
-	struct amdgpu_device *adev = ring->adev;
-
-	if (adev->vcn.inst[ring->me].using_unified_queue)
-		return -EINVAL;
-
-	return amdgpu_vcn_reset_engine(ring, timedout_fence);
-}
-
 int amdgpu_vcn_reg_dump_init(struct amdgpu_device *adev,
 			     const struct amdgpu_hwip_reg_entry *reg, u32 count)
 {
-- 
2.52.0

