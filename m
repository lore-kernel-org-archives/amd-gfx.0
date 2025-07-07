Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0678CC8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95FBE10E536;
	Mon,  7 Jul 2025 19:04:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gXjHuUjW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 416B910E542
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOJfNj1AZCzFnYV7rt3jt+Un/ZkM4bLuu1xp7aip+2xq53J5IduISSXqy3bJqOudQa0zuLT0KR0IWPdNL6tlk57WRHFeJ6SvDlaqn19MsliC8VWm/AgLmULSlKVhC0KgX/lD9MrsvN7DNdQmc3Fi7qlWkmZ60kY2NDiXoWd/+r9D5NImdXkrhDEJgGnUekjvE7zxfgZXdZP5sz5VymsCj5h7SOfQcIHVxD26SsxLzYFKnHw7/i5ztwWEaN6FhniCbAYd1b5vkZocATCJR8Md62hOCPXimF02qZy8Eab7TaAzshDRcY9IfS+60apiNlsguqvrU2NYhRiDxAKsVrmSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjL5ojjQMJe1zB70S2x3f9Yj+9etPvvVUeOV5eNbGrU=;
 b=hhAiKpdwUop3l9Ba4OOUhbTaV4mFytyyjEaUlATcvt4RFSqVq5c6+jYD5lKJLNj8z5iyswXH/i327APxDskydohQP5vMJTbIayYSHdQzGKksENnKKSFVmNbhZN1mzZVW/THogJpKXMTQWiYpMDMex5LuRpVJ4ihK42U2EDrNlpB6UDcqZ5bGd2gdBvFv5zCoPmYQCqAmcYEeUEIiGtGaEeSBxLgxO0CT4WiC7AXOAXYjHgZRBEWokeX1sxVHfUNB9zQNpAYJhSP3BQGz3nN8O9RtoRjxST7KpbIm651ygK+J5MsFqLO0sZj405zXEzObxNU7QEVGLj31xqbByy+PSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjL5ojjQMJe1zB70S2x3f9Yj+9etPvvVUeOV5eNbGrU=;
 b=gXjHuUjWew7dcOMJYqwT/kIr7a2Sg/YJVM67FIVjmvGrphQYgsipcJw3ZS4xUfJ2jwwkaQWgYDwXTUgifwESR984IAOQPJjEGANg0lwRbSMjaWqS4KcchydFRdBXoVQjZC4bDH2NAeEuBXjlmktImJHviUjn+3SMFHkR4UsSI/A=
Received: from PH7P221CA0075.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::26)
 by DM4PR12MB7694.namprd12.prod.outlook.com (2603:10b6:8:102::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Mon, 7 Jul
 2025 19:04:30 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::f) by PH7P221CA0075.outlook.office365.com
 (2603:10b6:510:328::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 29/36] drm/amdgpu/vcn4: re-emit unprocessed state on ring reset
Date: Mon, 7 Jul 2025 15:03:48 -0400
Message-ID: <20250707190355.837891-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: beeb6328-13f9-4633-3fa1-08ddbd8919e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rEHwxI4yrOZQUekrxQ4GGla7CX3MK7pwpU+pRs/yiXn0GQBy/CPkpwS1XcO/?=
 =?us-ascii?Q?MTMUwolmqTEq4NV/AGyjeliMqaC8kpdB7pACpIeKflAi/oQKLj2ypLk8+mPj?=
 =?us-ascii?Q?FRL9hT6GLd4b32Mph6A/ZDThgfO3kKY6g/XhXXL1SuvUiSm5n7J8miQfPuVJ?=
 =?us-ascii?Q?5lvo5Vi0/rczKE0kpVG7HQMo33yZXByz74L7QPPXJ9y45BylfJ1KkI+Uaf16?=
 =?us-ascii?Q?Rl0UMWZr3+9ydHZsvkV5US9ZxxVDbBp2CJ2ornAmLnDl/HvMXhd+MYDxaC+t?=
 =?us-ascii?Q?cP/2u2f1lRVlztEey/9ZS0yXkp/6Sni0tdsXbSP7/kyRBNlORriSfjypSnlL?=
 =?us-ascii?Q?OM1krzS1cfEpMaoIrLzDqdUz44hZMqfg02SQsIJokdbnC/pqiUocTxHP8oJv?=
 =?us-ascii?Q?QCzNyuGUHeRSqqXxaRp45AxIEB+Tt66WT664CUKGDdYnrnw+CBzoNIA+wYAq?=
 =?us-ascii?Q?31m8PQQJbPiBm+TzZ4IfBwGMOqDSqfaxXyt7IhkQphuVD/JbFdec8Zl6V5mm?=
 =?us-ascii?Q?uBT4ON0pVCt2Rq0yDUPbyzvoNJYkoHk7nQZp+ARNJ5PHUUXe9WOj1TyQLIls?=
 =?us-ascii?Q?CbUJ84xzuR0bIGblQ58PX3FLNZwPIEyjkLUtZ0aDrKQFz3WuKgesNSp2yyzQ?=
 =?us-ascii?Q?G4v7C4DKkXpe5vwtUAfEYx6ODUCBfS9RUwiRZtAfKheKZnhQL6VXoPp4oK8o?=
 =?us-ascii?Q?ssDptYVpK8twzOTRxUwxi+rlRRBhuXGTvK+QztSLFehIetjmHMdxetZLpIEF?=
 =?us-ascii?Q?A9pqiV7tlUb0xtag1+G6vlheFbhjiyYoUrdZHVkC2AyVSvzr7zUkMouOdd8i?=
 =?us-ascii?Q?ZWjndL6aTQad8wxWVCSZydYXFTTwl8vexUivb0TugQVTphUVAobwGdIPOBNQ?=
 =?us-ascii?Q?i65o1Gr0hElVOZKvn4B2eWg4lMpzOCDcwhijwfcSLy3JVDq1pDH9qAEmlD5Z?=
 =?us-ascii?Q?DHhRkU4BO8i+E/rKGidvZzfPNYFPL3giVpSIfSEnbzlphbHLO/mjgsCD3xG1?=
 =?us-ascii?Q?jKxY6wSRLYqpl9OaxZE719JVE3urBZDeK1+yy7oUoUGJnipIdwi4kBgd1uO1?=
 =?us-ascii?Q?lk3rePFId/QCj81FwvepDh0dHBC9uYS4DRySUSutKuSUiBz5GWpKggWwThjN?=
 =?us-ascii?Q?Hbu+sJtpdWmEE3sPwMBQSMtvMoGo0b5ZdPxj0juHpNvQtIMpgTqxumxOp+xe?=
 =?us-ascii?Q?8IAEiEptIOtvQaRqvtR7RKHn2HfAZeEzifdpSachzZf0atAUx3Myd8Rf/Ai/?=
 =?us-ascii?Q?OdTgGoSTvYkrce7a/zkSkVyHyJJ2zdA5ln0KaO8sGeeeCYuphd1uFGLZesGI?=
 =?us-ascii?Q?OuzaLy9kvsaABxvaKv/PkFFnsgut5+MXx6LjzJdFMkPClBZlh3LWPJ9uQ2u4?=
 =?us-ascii?Q?4JoHI0yoMAVKX8pUXlK98QU28+rX4wYzV8xnK/co1ueR/0Sw3jSqBNjamKsa?=
 =?us-ascii?Q?VSzYqyj+cA2hFyFEC9ld/c7mnZkpoKzADZk17IInto3vmSs2AirZ7j4pn9vF?=
 =?us-ascii?Q?NZHrZD32Q1edSD4f2rWh3IgM7T6oefWgFyJq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:29.8409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beeb6328-13f9-4633-3fa1-08ddbd8919e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7694
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
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5bbce8544fef0..2384a03b365f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1978,20 +1978,14 @@ static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
 	if (!(adev->vcn.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
 		return -EOPNOTSUPP;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	r = vcn_v4_0_stop(vinst);
 	if (r)
 		return r;
 	r = vcn_v4_0_start(vinst);
 	if (r)
 		return r;
-
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
-- 
2.50.0

