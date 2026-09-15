Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2177EC88E77
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 18:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 912AC10E910;
	Tue, 15 Sep 2026 18:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ChonS8pE";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112EA10E910
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 18:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMMykRKjysW2+CU5jXrvvoh4VCAltwm24bUKM/BAHwSoEm5ZVW81g3IQsAK+4StxHDLcJYSr4X4Tkb2hGbgfWRzEq3qI6R4Kvu3Zb0/7HuMziDK+ReOQv/WJIygt2nAifeBi9rEjwHN7lxYQhkkd+ralQ4rSoPJAL3H3pxmiAilggL+f78gEP2RyOymTg0yj9A/yR9Z0z5U4dSFgpVPUxY/S5WbtJVlJoUNEnz2xLCngA5tMLkRjhuTFAFOTvWIQQJFbmJB+khfWIgXMtFXmi4w7src7Nyau9pLR3tUBPbwZEybj01McdQRXTCzIFXtzw8MJswnA03ICJkCNSgu/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HI1600zVI1P7NT8uIb+yIBQziwFx+GofrMMb3b9Njlo=;
 b=JDlkdrkWwmO1d1iru+QKri0vImp5qoi14DRwMO4PcMFMNPk0xGKvPRwsfHUDX4bNMoRVZX8Ugyq0N7DK29lxtQw8uOwxGZLMKhJpbmcUnE6MCle6nphHILKwzk44fNNhf9d8PLaBb1Qvw6+beUrnijXqDFenwxdxiJSrxnIEPxv7kxYr/iR177lcAfUjZlLjD19r8ISnqQDD1SW4FGNsDCzhVy10eDTB45m8RZKPFxayyIfih2lQUf0wqNSt0HcR5v0IveFjGjbuIIPYOXandHz9tXnI+4BxT0OtVewhgdRjoMrVdeIoBihKLwHoy+jNiug8XijTmvMDp/rNCAJNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HI1600zVI1P7NT8uIb+yIBQziwFx+GofrMMb3b9Njlo=;
 b=ChonS8pEgR+h6FVLt++DyUu/Us9ZxxoQtFbMgrlqgZDg9q2lHStyNFnpUxBxfbjnexlXn5uN01rZryuQ3wBgogG5e3kgS1JT0wcEW0k9BDgjtSQHZUf2bcOigjuq7rGYLr4YPpJvOL9YCpGVv4MVPp70BvTlw8hv6IuQa7iCBNk=
Received: from ROAP284CA0399.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:145::20)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 18:49:14 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10d6:10:145:cafe::69) by ROAP284CA0399.outlook.office365.com
 (2603:10d6:10:145::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 18:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 18:49:12 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 13:49:09 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH] drm/amdkfd: set CP_HQD_PQ_CONTROL.SCOPE for PM4 queues too on
 GFX 12.1
Date: Tue, 15 Sep 2026 14:48:00 -0400
Message-ID: <20260915184800.395995-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 56d9d91c-6bd6-4e00-33bd-08df135a08fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XkbU725MusdtPG/lfBT7By5usCdRUP9Mods+xrzq6IO9PyYQ08JAj03bxls2SfgFWLzmcXzIppKA0YaVpUu95B2rcY/3X4gHnZjeEpXpzYxKFEElav6s29E46GU7at3+5DXNPBjlO/LCt0FTAuaTxwHCGhrZW68dEWiBgrmTi+gD8F74QI3eZJXsvP8ZUbkYLpvuYyOeMfhfaPwVMKDZFy0dcPx3edGhvbcwkxb7iz6uBI67wBAhVLpFDyOjKxl3Lm95Dseql2/maggo+zFiKeiUK8kqauLZKGux+xpc9UPSn8OfDyfBWJXNyPwOdo7B4Y7VcwwmhZw5mRd0tLxcicZWHHcShV5nnNoqLKgyQL/0mXTMsPe2jfkpf7av5FJCpHh+Zx3rOuB0GUXenirbxxhg9+0KWHrJWTVALSk0FhFhPrnWXz0L+Qxb7KClMzYpGs3WNPoqbbn6NG+Xi2wwKsaJAPPdLUg8k48MyOeAE8Zn/+XpVuYnCctQmAv17FYx7PsHjUKhE57x3n5eFcPpZaOoztUOTIyh09kZ9PLQXyXOOIgbyOGlE2DERekBUUp+EkH9IaesdCNK/7QYTUjNr7+gZIqJGwFfjJf8AxLPE7/v6r3P4dHewQrlzILgkSrw0fSIukS310RlurBCibzStzUosE7i8h05KaA/RhZFWF5HH+4kRyo2RqS79WUJojz5VD9gY14iSQBkuWusFlOv5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g4EsBGjYOWORN1IE9WJjZw+wXkwK8JY5x7HKVAsdUzH1T2wgDVV7A7bT+XlWZSMz3zDEM44lmXqoEG28VKx7hhpAzVXzcfIVRzqkkAq7TmNl2Pa4GG2FHyIwHoyf9Hzz6qVjngEME6CDWM/gFi2YWaGy0h3MntNTBsoDpwUaWYMmtJAzmbx0YfAH/BiiiUiKgEEpdoVs/hhRu7k9sAE2x1zmi3m6qo8LLsOUrMiCcI6KqH2olwWLDducqoP8v+Dt2xs2n5k2KSu6NvMoWWctOuHxOE8Gm792G7XHI1NEisyRsudzGWuNDlTGThmsHzyEyf9mVIa45aMn8jUZ7OxjuN0rSBGm/53twzO4g57xn5z6afuSgNZ343n0I6J4kVdHpHbq67PHtBFJ6C96Avz8PIt+K4JBVZVDs7dFU5R0pNV+A/X+7Dl8iengjOhb9Yhg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 18:49:12.8381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d9d91c-6bd6-4e00-33bd-08df135a08fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
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

The previous change set CP_HQD_PQ_CONTROL.SCOPE=3 (SYSTEM) only for AQL
queues, but PM4 queues can also use non-coherently cached ring buffers
and hit the same stale-packet problem.

Move the SCOPE=3 assignment into the common path so it applies to both
AQL and PM4 queues.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
index 29c20398c60b..61e9282f3fb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
@@ -274,6 +274,7 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	m->cp_hqd_pq_control |=
 			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1;
 	m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__UNORD_DISPATCH_MASK;
+	m->cp_hqd_pq_control |= 3 << CP_HQD_PQ_CONTROL__SCOPE__SHIFT;
 	pr_debug("cp_hqd_pq_control 0x%x\n", m->cp_hqd_pq_control);
 
 	m->cp_hqd_pq_base_lo = lower_32_bits((uint64_t)q->queue_address >> 8);
@@ -335,7 +336,6 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 		/* GC 10 removed WPP_CLAMP from PQ Control */
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
-				3 << CP_HQD_PQ_CONTROL__SCOPE__SHIFT |
 				1 << CP_HQD_PQ_CONTROL__QUEUE_FULL_EN__SHIFT;
 		m->cp_hqd_pq_doorbell_control |=
 			1 << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_BIF_DROP__SHIFT;
-- 
2.55.0

