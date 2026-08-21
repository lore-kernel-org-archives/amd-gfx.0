Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349B1C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 10:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D4510E00D;
	Fri, 21 Aug 2026 10:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UaeLOu91";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9AB010E00D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 10:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YknX1qXThUHmU2KONKaKdGDtzTVRwGmZRIIWmjXyqGLbYlHgUq2I2vUvauO33lxj3Fvku3qHNpa0F2YnOsdAVo1mK8fUvzdSTR+qRN4JfXu/C85MBBdjRkIm6KR0N5LK6olHEgZhqhPghuJaZuCObkjIgULq20AqjEvBXETChr6t2Uu1hm0JrKZs0pZi+SlSqT5PYbegZwhaZ+hIg2Gmo0QBbRKvl9vDQfV7hLhzyhsRnUVI0J+4GCGX4JZLsDcs6wSJbtnVAFBkuRX7gbyh8mYuz+Xhe0Aodi+dM0/FoUvmxdH2lXbdkb/2VjtHFQY6wMGUMtkuJEeDpZa9H1rX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjhj5hud3q1LmLGlrqbZH83h3hho1soOEJwAnFWZwdQ=;
 b=jtiyBUg58Ubt+iFwO8nDxQRRwKtDIJZf2YWWswDrLzcpnVZ6M8Cdkj8MZ8k0TrP1riOF3Z6+vOaQXsZFembhS2FwssRo/lOOeiL7avw48aWLx8ojk0qTTEdbelgKr9+JUFL6DizQbZdbe40tkVEwWZYOBbNcnO8IVWSO7dYAtZi35yi+/Rvyd5mrHZ/wQ3COirZB/KHok6wd6SQPw8CT96gzKoo5kxcVznQpExclWHSHCoDvv7s80wtf+dexKb2rWQ4cdzm+wl3Q5bbop1fg8r6YliaQeGZouVesvpx77a0i04OFx8mWsL5gnhOGGNN9G5ZSd+LvtFDoQiodhRcrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjhj5hud3q1LmLGlrqbZH83h3hho1soOEJwAnFWZwdQ=;
 b=UaeLOu91WRvCNfmrXB67bHbns0vJLTYVMny3YErrwsAs/DhFjTdMNzeSDdT18Jt+8AjpzvKIYOyiqmlnELgakKmzKAWKSEfXahfc4W+etWcU0XBjmTeXFUJcp7bbVlfTeZgIApu3f6cuzBOc8b4Yivb4aowNFdBuQ+fQsmP3qiQ=
Received: from DS7PR05CA0097.namprd05.prod.outlook.com (2603:10b6:8:56::26) by
 CHXPR12MB999219.namprd12.prod.outlook.com (2603:10b6:610:2fd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 10:10:20 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::2b) by DS7PR05CA0097.outlook.office365.com
 (2603:10b6:8:56::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.4 via Frontend Transport; Fri, 21
 Aug 2026 10:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 10:10:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 05:10:19 -0500
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 05:10:18 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Christian.Koenig@amd.com>, Xiang Liu
 <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: clamp the isolation index for rings outside a
 partition
Date: Fri, 21 Aug 2026 18:09:06 +0800
Message-ID: <20260821100906.1652542-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|CHXPR12MB999219:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d12a0a-050d-4d9f-2246-08deff6c681f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|11063799006|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: tVTNxIRph/rG8cXJUuF64UILAYmXMVGXZKXfOok8rfl2uAg9/8i9GxEu3sSBJ+0sy5RoIinAXIMjl78m0UaW9AmhnA+T8xYtYOM/yu4RXF9H1dWm/t+WvkcOsM4m+6hOrX507QY28uDfcSeulgdfoeKUVdnd8JNKDCgPQr4aas+x16MukHHQVb2RcK/+IeWQvZ0FZA44tHotXNfrKvYpu4Vi9TJ+QAd5Fl9uA28NJ8Cey1JdqnFOzGFZqPFwmrTFnxAfKNRALENVlezdngYGR/6Z3wy3LSSbXQfwIEPbNULhO/5a+SM0g92ABzfMzb8j0qL6n6FKKlKigSAAAVUDLi3esrX0Woc+k0FfB82G6AjTATkA2lQawkobE0zuvQSwoclTwx5z0JppJqVGMP9b3WlzRsSY0/uYkATN24eaIwS8/8SrJplJwX9IIIThX8BjBinzhJ0pNHZwvQaiH1FFOlqVcjid0fv2jHMjk+Lbry7wgvQta1LGF4kMH18ZnXWuvMwBy+g4jyLqpn95rpdol1zST384ClCvo/indR6GwmdIRwolXlIOYlqcleVXWmQ3jUbq6qPJW48VXrkt+qTfvgu+o5WEqxHQjO7+IVRlCOWQ8agjmRJAI9yC5rAsHu87VGSynGBdIUahuJ68avq2kVLP2UWcgBbGYI/Z6Zcj22mgMAt4qmmjCw8Mxm2CrWPWutfs4iikH1VKADheiNIoaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /pTOs6H+b4gykvx9DPifAFZVga0ASCRXgU34nF2yaFJpyGugvFsUU4IkXV2ECKI/5CD/eMU+4PYODLgDP4K+EB2/+h7EyogOatvhsQFJ5SqeFpynASDTFg18X9vkg7/OKVnmV/r/wheTJpTUhYvS7XqByUC4aEZWhoyJnSiDvZeZJjYxdfuUNdt6+fGJLgKdzraweeV89kB9VGXJWH2jiLVbpIXEsz9pAsJrtKzqIL2TmWRxivMDOsMgv0SxjJe+z86j/Sv9lh2ZXkKN5cKLNbSYUs7HvPsp8VEB9tUXVmLrStMAaxsFUPwwa+QCVbTZyBy94OxJHcG3n1bNsBBJa9tjZc8+EYGmx1drr1z5UyM6gd59g8mr1nfQeYcq+lowWjKr3hAwd8jAR7uwR8wHy5bo17BiiCaHoiwGV2Z28IN/Y+YHaVScpeXNsEXzesUT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 10:10:20.1203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d12a0a-050d-4d9f-2246-08deff6c681f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999219
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

adev->isolation[] has one slot per partition, but a ring that is not
assigned to one keeps AMDGPU_XCP_NO_PARTITION, which is ~0, so indexing
the array with it is out of bounds. SDMA submissions hit this on both
the isolation enforcement and the VM flush path and trip UBSAN.

Fall back to the first slot the way the cleaner shader path already
does, and stop taking the address before the ring type check that makes
it relevant.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index baadb676f76b..d8d182599fc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6756,8 +6756,8 @@ struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
 						  struct amdgpu_ring *ring,
 						  struct amdgpu_job *job)
 {
-	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
 	struct drm_sched_fence *f = job->base.s_fence;
+	struct amdgpu_isolation *isolation;
 	struct dma_fence *dep;
 	void *owner;
 	int r;
@@ -6770,6 +6770,9 @@ struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
 	    ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
 		return NULL;
 
+	isolation = &adev->isolation[ring->xcp_id == AMDGPU_XCP_NO_PARTITION ?
+				     0 : ring->xcp_id];
+
 	/*
 	 * All submissions where enforce isolation is false are handled as if
 	 * they come from a single client. Use ~0l as the owner to distinct it
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5a6f5151c3ca..743d307c71fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -774,7 +774,9 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		     bool *emit_gds_needed)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
+	struct amdgpu_isolation *isolation =
+		&adev->isolation[ring->xcp_id == AMDGPU_XCP_NO_PARTITION ?
+				 0 : ring->xcp_id];
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
-- 
2.34.1

