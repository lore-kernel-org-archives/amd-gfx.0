Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1479C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Apr 2024 03:16:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9817E113966;
	Thu, 18 Apr 2024 03:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M283baYC";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969AF113967
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Apr 2024 03:16:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQGZwZgfiAnqllwY1Wi4mXs2j6ToJ0Q5izBGcwCf4CH0sv3KAmiJfG8JAJpshXTjrK6/BVxotX29GpXyQN5qDeBFcdX0Fr6FJAvhMJ27LXToIfojyiiCGnplpYXxdB8fclAaKCjrazgOAr9x4r+KK5ZAwMoNt6xDpLCL4ncP2fLqY2i5YQiVsGIJpJNAKmuFhfyyX3qxbbHjyy64lBjQQaFZbcsmCTm5TdzsHSf0zdVeSLC7ZlMfkXsKKZ14l7aBI19s0jnr49SndNZSHG/mkmUKjkqcEqcsVQIum8xr9pAK1Hxt9cV0z9Ugr0GYINSlRHGQYPwsu+hG42wnjEXVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQu9C5Y+8kXuO60QCPRp/js/QyoI7IZTF0kkhc0KJI4=;
 b=eqolrh8KvQPeE0K4xeVHDKsRq4f8HZeT78W0ZKEwQNtfDEKDgRdtMSmfeT1CwzIJOAejUvb7tNyUWC9r8YhcBJmPwWjQJN4nnvJJZavPf6kUdxgNx8y/YfdpleelBkAnKiYlBvuVD2uUU42b/zfdiKmhcmK86zgtdfdmlCKOF/1t8df9wHnfWpQrN2leAHYIJDI1lHhG8K85hWYLXqRPC3x/ZpAiQj72eIhjQCkp8A4XmnSVV3v6wmmIUlWJPVXa/dGkJOoiW4ZUwr5T0s6t3doOwMJyPDbB/ZfzB1mOUnoIZ8O7P0sL5N5w+FlzDlJNIIl2MTs9vvVuLC03YW/mZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQu9C5Y+8kXuO60QCPRp/js/QyoI7IZTF0kkhc0KJI4=;
 b=M283baYCr/lXtlc/DSHahlLuTDLyjxLKGYqlTaxO305wCOeO6FviJbAHUP4yutV4O1R5AtGjjDDuPCqLW1YEiR93X7Jgbbf+ay//TnDImupooR54WQDcbtCJdAcOb5vIMAvlHKTY2QWSHBf89y4NGtvyurwFIC9ahURnJ8k1gXM=
Received: from MN2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:208:23a::7)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 03:16:31 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:208:23a:cafe::f1) by MN2PR03CA0002.outlook.office365.com
 (2603:10b6:208:23a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Thu, 18 Apr 2024 03:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 18 Apr 2024 03:16:30 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 22:16:04 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <gang.ba@amd.com>, <vitaly.prosyak@amd.com>
Subject: [PATCH] drm/amdkfd: Fix eviction fence handling
Date: Wed, 17 Apr 2024 23:14:10 -0400
Message-ID: <20240418031410.2815452-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 2609a500-5d95-476a-9aef-08dc5f55f17c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v89PTVQdfYjK8JzpgFGverKJgCANGV3OUVYX9aH+ia/+GKqbvxpxis2fgWe85x5bb5TmygKN7K6JHM/0jOvMZPxiIRYMtmQODuP1Jzfroai3OOjLaID2uKbNmenoy/QtK5pBbhgSEe5cju4FQeTExih3cpE5ilEO85GORm72ER5Z+HPSwY2s1GNJEZ4oCIqGasQ5nXgtA6yoBQKR1jHpT2Mp10wXm633gj46UtTcHjP7uUomTlbwMbG+WxK+wcdRTC8jwCqjF5NRVc8zvDk/7X0rE/ZObRROdTCbakdsT/CinKOkLqUELFYcFf/PaJCwdS/Y7fpjB0Jv7lr09+oJr9H3J4bwo7vnEP/KLjnfBLGMnSselnuH/xQUOvbQ0NJaY+Q4WQoACjVsjOS011XI9CfylEysKPDWTHjIK86ua6qLtQXY9F0UO+UqJwDGxyiIumNNVVZkV7+dObSvaUvckDv9JJNRabMkYwi5OuTHUlbkNt9OSNCK5irKHTt4HOZ6cnEkNyqKvyQ0OG4dUCCp6FntvbkPA6fn/s9ua4Y3WXEZV/ulBkj5/C3cD65bFYPVcZsK3Z9x/u8/sRGxgZg9ViX+FLnkTyrOFVZ5SBGn4U/vygLjzD/eLNETUK5fQvDNI7R5hfAvOdZfoWWjA/v9ApaZzzmksAI0FbQTjYv54axKf9KjYFS/v252fn5CEWi5ihc5NqiE0lThw11ZknJy+qRFi6corPWvS4QdjL+G4HswVr/kKJ/OuKo7vBUrn8qA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 03:16:30.7164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2609a500-5d95-476a-9aef-08dc5f55f17c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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

Handle case that dma_fence_get_rcu_safe returns NULL.

If restore work is already scheduled, only update its timer. The same
work item cannot be queued twice, so undo the extra queue eviction.

Fixes: 9a1c1339abf9 ("drm/amdkfd: Run restore_workers on freezable WQs")
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index b79986412cd8..aafdf064651f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1922,6 +1922,8 @@ static int signal_eviction_fence(struct kfd_process *p)
 	rcu_read_lock();
 	ef = dma_fence_get_rcu_safe(&p->ef);
 	rcu_read_unlock();
+	if (!ef)
+		return -EINVAL;
 
 	ret = dma_fence_signal(ef);
 	dma_fence_put(ef);
@@ -1949,10 +1951,9 @@ static void evict_process_worker(struct work_struct *work)
 		 * they are responsible stopping the queues and scheduling
 		 * the restore work.
 		 */
-		if (!signal_eviction_fence(p))
-			queue_delayed_work(kfd_restore_wq, &p->restore_work,
-				msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
-		else
+		if (signal_eviction_fence(p) ||
+		    mod_delayed_work(kfd_restore_wq, &p->restore_work,
+				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
 			kfd_process_restore_queues(p);
 
 		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
-- 
2.34.1

