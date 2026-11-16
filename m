Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E5606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=YZO7CiRr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677FE10E996;
	Mon, 16 Nov 2026 07:51:22 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095A610E995
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 07:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3a5Q+Rkz8O/yra0TQYAn7whZXboOwN/WBBcPQkp4s8UIVyzS8ZMKBE/uzx5SgIPkGMHZbamtsCNbRkVbkpiLLRJYXROHKOEvze7arKlx5pWjAiQHGK1t/TLewEqVY06Ke3rKSKOdaMZaqCUu29odk1Rvpv7H/wLv7qXbVt2+3VyxzcNqG0skDvs/Bn6OS0KNCMSrBo4hm0tgkAPNA6SvFBPFhQfgdiH9rydaTIO064KI4nVZoZsN1/CmbYqQwiSA5FB4KIFsVYqnBzI20swK1BLq3gmM/wP3eKK2n2FZarCWoKsgUNPnouSTVhCrVcKukc2f/Ab/3WNJDBgpvwlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/pFZgwwMmIWGiiP/BqK3LajS5/nBfT+IPh1dYa4a9k=;
 b=oucZ6wTGH5Adny26UAYzhDRIhW4tCavgiYObRvYS0m7o8Zr+EiXmwO5jHW4NfiXPeINOtyGE+vx1lkVel5rRml3EVw5BvAgH6p1du4kB3zHeCJrPGwA3TZvYpI5U/VynD3KV+g80mzU79HaXSy/ZtGqyq9ABAuU2ElMXZpnM2o/V+sVbR6lqzxgkLG9NbX/83W+o3oNyCc7GyjA/wYf2X1G2a2w4QS01aAtbBvrVszQtq/e4WAYzwxfd1vNZMuKj/OS2WdpWRT7oq8u/ph2WF5nivYgJENb7VFhepGrI6gl2LM3OXQNTxRuAxV0M740NyHenQ+ouwREkoyn5RN1zXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/pFZgwwMmIWGiiP/BqK3LajS5/nBfT+IPh1dYa4a9k=;
 b=YZO7CiRr1NobbSN5z6It2QsIzRsT8a9wvui2vdcDuT3TPo08dOhkkOIewPdgwzNcSt5iB2tVbabeGYdPtOKI3ighqznN9t6BwnHeCQls5jqpzGrUpKGHWXIpKQLIzpa3HCybSW1Qa7fKWhXbNk/cCbvhoBSMMGJt1Z015Oqp2QI=
Received: from CH5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610:1f0::11)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 07:51:12 +0000
Received: from CH2PEPF000166BB.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::69) by CH5PR05CA0006.outlook.office365.com
 (2603:10b6:610:1f0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.7 via Frontend Transport; Mon, 16
 Nov 2026 07:51:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF000166BB.mail.protection.outlook.com (10.167.252.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 07:51:11 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 16 Nov
 2026 01:51:10 -0600
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <jesse.zhang@amd.com>, Amber Lin <amber.lin@amd.com>
Subject: [PATCH v2] drm/amdkfd: Move gpu_recovery location
Date: Mon, 16 Nov 2026 02:50:47 -0500
Message-ID: <20261116075047.35150-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166BB:EE_|DM6PR12MB4402:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b204380-d567-4cee-5dba-08df43b661d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: PWppCCBdsooUOutNMEvhlzgc/5qh5AL9P/ZHW49UCt9qR3uyhcD2WhGUhznPAZder1RjDl1ES82e3nttqaWS799oGeqeYezavI+Y0SAFquu7soH0LRq9Yaw6PbL3XIMZxwlvFV7uDwPRfNRXVBM8O3j7CL9xeCzmu7Z4bq4egfd8kbWVSA4uriFBCXMXBeCcN7ZxZn0Yojl1OjzwOcGmBJYWBKRnTtOlGMAiv/3sRmFY2nFnwwvkMAH9de04J5/XHuaSRk8zR8hAwrthxs/2dcBF3A0lEiUQ/RmFsAw192NSMNvtwSR5I2mqaOHFadei1a8ouuOYZHu8qBtHY3DJ0mQQ8nCf69+Jtu+M2qTdjsQH18E/A702H6QJgqmVTsxrriEgepc38Jp7JHTutjrIL8mnn0nWhTsfZVjildoLgWOnP13kRAp3xfOWYsOUdR33gTZwOLMqRBRRnO6xLdm4qXFP5IFnTkpH3H6SQ8eZ0M/AZgMr+D3NFqCORvGZvmM+wCr84t7a3nDFVYnEBXvtVA8prgtR5LrIV4S9jfyFfyhvw4wSQJOi+EhmBpEBbCTcj2EywehBfbC7F0889oMhK9VXglqg46nTCNx5aCZcRPcmTDwe5sQwfD92nXmJQteGzgO5bxbWjxYG/jGIk0kT3NIE3NqnfyC+J2WnR9I/1Jw5efKmb0aT5mJkUig7Keg+PNdUhUvP1Lt6id4QK8Ykew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Okx4U9fl6gZNVY09Tj2CLlCAyELgatkFrITeOtXgzMgtbD5n/1nh6rONZemxMUmFQOW4BWBk9Io9V9ZAXsN2raXz2HL/ZQjAwGqiZLBxWzz9Bj9kNuWVozPucTCu4bso8k8LfbiDsEPFXK3Uw/r/8gxcmWpqFZ+rQCNhPTBMXoW+cyO+OvmesjVlKFloiLofhhWmy2vFi/RhnYGIHHn3U0sG1HoZbv+zndSLw8PXksR1mRWYV6IhdvrLbvDBSQQ/wlG1+VBtQ9X/RLn6Ar8kOotuiD2+QttdEKupgxuWxar9NRUnykOx9zzfuGfaGsoLo3q8lrfh1+zsJX0DyrtVxz7Vx5oJrwOUpGHJ4Y16hoJj3Flhb5FlzNmLzAkTCEvhUWKfR7dmdBKEEKq2SZ4UC8IgAyUsCARDylzofNFRx0g1BBkgc2CUsH967fT2RgE4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 07:51:11.4360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b204380-d567-4cee-5dba-08df43b661d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000166BB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_gfx_reset_mes_compute combines two features into one:
1) hung queue/pipe reset - suspend all/queue reset/resume all
2) bad queue removal - suspend_all/remove_queue/resume_all
GPU recovery aims on 1)resetting hung queues/pipes. When gpu_recovery is
disabled, we need to keep 2) going. Therefore move the gpu_recovery
check from KFD's reset_queues_mes into amdgpu_gfx_reset_mes_compute
where queue reset is done.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c               | 10 +++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c5a2dcff5058..c30fecc653b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2594,14 +2594,17 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	 * reset detect will return the array of bad queue doorbells
 	 */
 	r = amdgpu_mes_suspend(adev, xcc_id);
+	dev_dbg(adev->dev, "Suspend all returns %d. xcc_id %d\n", r, xcc_id);
+
+	if (!amdgpu_gpu_recovery)
+		goto after_reset;
+
 	/* if suspend all success, it should no hang queue */
-	if (!r) {
-		dev_dbg(adev->dev, "Suspend all succeeds. xcc_id %d\n", xcc_id);
+	if (!r)
 		/* always reset the KCQ/userq since we need to signal the fence
 		 * and we could be stuck in a loop which is preemptable.
 		 */
 		goto fence_reset;
-	}
 	r = amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
 						    true, &num_hung, adev->gfx.mec.mes_hung_db_array, xcc_id);
 	if (r) {
@@ -2662,6 +2665,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 			goto out;
 	}
 
+after_reset:
 	/* MES doesn't detect any hung queue but we have a known bad queue
 	 * and it is not KCQ
 	 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 86b70748617b..b77cfd8ba907 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -471,11 +471,6 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
 	if (WARN_ON(dqm->detect_hang_count > 0))
 		return 0;
 
-	if (!amdgpu_gpu_recovery) {
-		r = -ENOTRECOVERABLE;
-		goto fail;
-	}
-
 	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
 	queue_input.doorbell_offset = q->properties.doorbell_off;
 	queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
@@ -3609,7 +3604,9 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 
 		list_for_each_entry(q, &qpd->queues_list, list) {
 			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
-				reset_queues_mes(dqm, q);
+				if (reset_queues_mes(dqm, q))
+					dev_dbg(knode->adev->dev,
+					"Fail to remove bad queue. doorbell_id 0x%x\n", q->doorbell_id);
 				q->properties.is_evicted = true;
 				q->properties.is_active = false;
 				decrement_queue_count(dqm, qpd, q);
-- 
2.43.0

