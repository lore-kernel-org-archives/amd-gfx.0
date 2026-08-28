Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E5CC61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 04:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490C010E454;
	Fri, 28 Aug 2026 04:16:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XaIbuEWq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A5610E454
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2rjMqemZH2oJpKkyXkFpoRZBD2/qoYsMilA5xWpIyQIWqH3vLRbkh9Xd0MiqIjjhrAj9WAE8N3Dnnef2sJwJZaIVmPZ0OQpSd4q7rFAZsxo5k2h2D3FrXy4LDrdOekAAR4qnzYTRwDwjQ388tjQ8qoqe0rY2HXYNlvdLHBbndJyRelt0A8O7ikr1SM6ZMpCtsT55KvqMgcHtyWZyVEfkK9eLSflm6wPFENdR9wBu64QPT7Jddm8nVxLYAFkTCnK+dFTG2znCBmBNhbg+BYEY4nBeOklZDHD1NCRi1zZzrwkngyslB12GLZ4b88tZd94J4y4Greh7EFt/9l9ORHABQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nxFLaAX1n8hAxqJT4t1opZR5X0O8BIg3l+UVy49kJM=;
 b=wwEXLuHF4gN8cKxDWHBzEpdI9lfHrqkA6IxJ68y69zUaPSyUIgDnX0cp/TqHktUEnPrqdxGnETRlh1WiUnwI493n5Yqy5oL7hysXc/99EUxS2UHI1veGeh7wqCz4oqULAyADFBsKwHg2Mq6Gzb7c1/aBG7r7bn2hCS1TV44xKPCYYRRcL6zoyk4KSYvExzOVNSaYkbA9Z7dQbHTT6W2AQH/cGgwpywIDkX8Hj/pyVvD8DBwuTH1EriJkXHCL9OhhEnTWwZAtWEoT+X62x1sXNSSe0dqoFCJrjXq8XeA1RauaJaY2t6Vm9ESoIoPh27mioeAFQIYLOOqZKWA60/Vqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nxFLaAX1n8hAxqJT4t1opZR5X0O8BIg3l+UVy49kJM=;
 b=XaIbuEWq7skrXrQmsqP0k+dKMfHb8vujXWMRyvZ8/0r7GS527INXrNm8Tgh7zZYKSRIAQCWzrzDP1I+0p0kt8QupIqEumuskoBAz6TdjgwdbTtzQGZ9Mp1DovpCcJpRiEodzx86M8x8M9CsKyH7vVvdHdjT0FLMS1tsHAjDt4oA=
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 04:15:56 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::1a) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 28 Aug 2026 04:15:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:15:55 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Thu, 27 Aug 2026 23:15:54 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 08/10] drm/amdgpu/mes_userqueue: route compute MODIFY
 through update_mqd
Date: Fri, 28 Aug 2026 12:15:14 +0800
Message-ID: <20260828041537.3464782-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
References: <20260828041537.3464782-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: c51cf622-3728-4f47-9a0b-08df04bb0ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: hVKT41mmf1ItjTGDYViYVSrQ4SsbnL+1KNJW/jOafBpBCvxWtoTEzbMqKu0GnTLh/IFXN0NmFg4qZp9BCizX23N+88BbWt156EVTx372GRuZ7gS/G+2Jg/b3VNcJe7q9JvBZ5/rrVkjHOh+Rrlx491qXvYugDUvAJzr3YR1cDrtg1b5XvtCqFM+keIhTPtldH3QILRZEodiNG28djVWLI0eGTMvuvEO9wSuBcE32dC1E/Uh34mqaIQC22W3B18DwU1NmYAODGWvFL7Y4u7whBIcxyh6FsMNrgX8IrKoxIyEUXuGMZ0YL15/qJHbRYedruITPvrTH6I1yr39cNEB5Ogy7sqGNmfbaIRNjFwSDzdcd3KemOMbIOLvcH2mkKc+my/4DJvmo4eTK0yGv8HdFX0AeBL9AnRTu1IC4O0Hs1f2JHS6jV8oCn+LEJ9bzLCk+XWH71v6LNc/vxGwvXwrQzohi5zVheCw3b/Ya/vCChpsKS1MyHzCAS2kPWrUOWNRzoF2LhGguznJ/Ix/8q0mfT1XIKSQdXjAOwhiHtWudRfRc3FvsZ3XibDeiRR0MEczen/C1qX+cQAFJ0pp87Lcaqs+HgZ9FcRr57Wji26vuFcAgURHpifRa5bEqgI/8UAryvp5i7i+XTD24V6RgojDeb7Rb4eRuBrrQME5JjIpw3+8bfYORNYE/t1WV8xSs/VmjkcK+7DV27BwQNt8RwCRsYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LO9A4YVrcyhZCa1m2MlqbiXZXCL8kJIsKwmyykFfYWydwxchV0cqMvdPMDRTdCOqnQpfgd4ALRvEAIJEMV3JiMj+z2iQZl/rZX5LnfcEdY2hqYEnHoqLqSami2vVM7nTQwfeyAok4vzZqpUAGjkmJkOzPA6G7Gn32ursdxuhekvRaTSZsRAZFJ9abd3JdnUq+H3VyWjIOekBqz9kbK5QhwueYgv/hLPE808UjE7Y2l83QsdXHTY2eM4XvrQ3j5HAIKVKVQ8Q08F1uXEBFb1DD3WwPD1fYdly9bLhG+SrxNHkpJIrKl9VeaBH+1SL7YLa113yPcW+wJhV8oI1sOYP85SSCz1B5YdbILpFZ+dm8bfrUsvMVPnycCtW+em42LY6+1V5h6SkZuQzVfYS5Sz4ezU2pCr8fQRTPXVrVyHVnR3uzdjQ3FYX7PceiBuXjpaN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:15:56.2753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c51cf622-3728-4f47-9a0b-08df04bb0ec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
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

Call the per-IP update_mqd callback instead of init_mqd for a compute
MODIFY, so a queue re-enabled after a queue_percentage == 0 disable keeps
its ring position instead of wedging into a GPU reset (see the update_mqd
callback commit for why). Add mes_userq_read_user_wptr() to read the
current user wptr and forward it to the callback.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 82bb4369451e..f2742fa28dc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -681,6 +681,25 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+/*
+ * Read the queue's current user wptr from its wptr poll BO. Packets queued
+ * while the queue was disabled advanced this value but not the MQD; the per-IP
+ * update_mqd callback forwards it back into the MQD so a re-enabled queue picks
+ * the work up. Returns 0 if the BO is not mapped.
+ */
+static u64 mes_userq_read_user_wptr(struct amdgpu_usermode_queue *queue)
+{
+	u64 user_wptr = 0;
+	void *wc = NULL;
+
+	if (queue->wptr_obj.obj &&
+	    !amdgpu_bo_kmap(queue->wptr_obj.obj, &wc) && wc) {
+		user_wptr = *(volatile u64 *)wc;
+		amdgpu_bo_kunmap(queue->wptr_obj.obj);
+	}
+	return user_wptr;
+}
+
 static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 					struct drm_amdgpu_userq_in *args_in)
 {
@@ -695,6 +714,11 @@ static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 		return -EINVAL;
 	}
 
+	if (!mqd_hw_default->update_mqd) {
+		DRM_ERROR("Compute MQD update not supported on this IP\n");
+		return -EOPNOTSUPP;
+	}
+
 	compute_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
 	if (IS_ERR(compute_mqd_v11)) {
 		DRM_ERROR("Failed to read user MQD\n");
@@ -708,7 +732,9 @@ static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *queue,
 	userq_props->queue_size = args_in->queue_size;
 	userq_props->hqd_base_gpu_addr = args_in->queue_va;
 
-	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
+	retval = mqd_hw_default->update_mqd(adev, (void *)queue->mqd.cpu_ptr,
+					    userq_props,
+					    mes_userq_read_user_wptr(queue));
 
 free:
 	kfree(compute_mqd_v11);
-- 
2.49.0

