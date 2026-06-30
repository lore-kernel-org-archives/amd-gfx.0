Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B91C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 18:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEE310E236;
	Tue, 30 Jun 2026 18:37:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wA7+pHqM";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C5810E236
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 18:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9Da3rzWEIwoEGvfVzByoIGJaKdu5b6LrIUR3bSrHpw7qaqPLwwtMS9Un9beY2vd6kO8ARrWlmHKQjbv+hb7YS8vHFiekq/zGh/Eq+8WeeAhI4P+xFv+wtSJFXUb7VRtLodgQmmaD4twO3Fun81Ofe+0y6voYkd2VKRXnkBpUsFNcPoIim3LJSokZJufsOJ4aodn2WgMvVbmh6MpXvozXU1rHFG2aVWscBLmjqjHXooFjOAShn2kBVx6qwIvlXuczfc+DTPCHm1QNnXlou4R8k3669ki4DZthAUFdyJ++y8nykXqU75OVoFFXMNF10TzkjrLQt1MXuB7Glr60Ok8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFw5iaygPUnzhQQd+MDsnglT6iLVIMJkxCJ+v9EtNuw=;
 b=mWZnZafMRa4Zufk6C2n81KNPFIJQqUhZ0Y9JW5enKFQ1CYdbOofFgWAd1ct0QSUPD0SADOLPZao71dPIQpHI13zCH8KIvpmJKUvnX1mI3j6oQpfxjGWXDyp+vAnVOLmDjill2cc91L7jjAAxgz0CELGxqBsKY2N1dgX2Tt+DVeTUP3d5Kdk7mCsSir30J1N03OCOLzJpsOdXSd9zpP3hQYvsDnnQsGQXPk3sXlRY0bkA29fxx092HtYtvoageQnQdKURViZb1m1DL3sA5HZ1s2P7eesmtCVkzG0sv19oXIDlzxpfASZihM4b83Ewczdr5IbdFDZdH0S6+1P1S1fq0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFw5iaygPUnzhQQd+MDsnglT6iLVIMJkxCJ+v9EtNuw=;
 b=wA7+pHqMNLYgSznQnq7w1svyV/3LuWa2xj1Ru1Mgd3vn027Od0XWtSG4JKbHwzLqgPaDHT4GNwjTuCBCnPtM+4UnQyJsKLQ9zVknr0MjiQBu3Nnf1wX/sZZTQX/ya2Vt0xsXQ8WVOhSx60G3gYDsXkUJ0+WCk4xm/VTIxk99Jb4=
Received: from MN0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::11)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 18:37:13 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::95) by MN0P220CA0021.outlook.office365.com
 (2603:10b6:208:52e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 18:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 18:37:13 +0000
Received: from fdavid-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 13:37:12 -0500
From: David Francis <David.Francis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Francis <David.Francis@amd.com>
Subject: [PATCH] drm/amdkfd: Don't acquire buffers during CRIU queue restore.
Date: Tue, 30 Jun 2026 14:36:55 -0400
Message-ID: <20260630183655.2408549-1-David.Francis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: b97f4c03-c5e9-4fed-0bbf-08ded6d69a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: MBZs8xrcOIHNYetUQVrChQrQU8mj2CampyNTxp3WscaQP6BEIWM2rc81sl2I/JBqTyTZsjEQEUytPwKGbx3dTKTl/qBlLvO4mHOIBJ/sRahNJNEu4HC62nmMSXHAOJiCkxexud3ajfpgJ9bWV/Tpp4ICrL3ZDuTe6cAFeZwsMTvpvkIiKgJQCbxr6rPkhSkMJsv+y9KPeQLwchV1ToPkL0jJhu2NuYQdCQO45d9NvCQOL5Gv/7sykrgzIcWAoSVGHGSTOKAXkgGdcXm5gk+i2A+DUagiYklFYitxm7ZH7+Iw2jr3Iyh1jfe0gI9K90YPm3Ctw3gQSxh7J7k7EZG6GvxaPyPRkT8KtqI4ldy+AoqeQVOU5v5kTfmYoV/GdPXI4TiWzN0qLjQLLr0YYFZfGX8cJ4RB77mMVTA2QklRa38FXl9g6hGFa2Cnyt65gOjjjtceqGiH3KgBz155y00WfFzRyGcdedfcFKwRvXLatU6XVwGMLyMAEQLsz+pftT8hGFCZlymY8HS4LKqSS5z75MGe2K9d88XdBtABBk83/nmM1BRGKS4gZY8gonDtp0jtKLdXfbG7lSlmvZUgXod6AWm6ES6nHh7UhQFQnUHIvhAT9pnzo60kdu3XNo/0fivFpsYUgwj1DNLoFs+kc06WuD8zaddghD4DJIuKaYieIFhklCXfssqw4JmZ0CP07mR/sCEd6QQDTIEqa8wiDN4AFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3Iw0/znRkD4BU1ZNge6YvG0kRDLM1OP0Qr09TZq56KEbIgqIGzKVCG6kpOjYjH95sM1jb2kjDwzgk3zvnCZD0RD+b1OqX9sUdaUhimWf++FwViT5hn3AuTZ4Q9Ds+MrEtIksRhYj9+8lTP0ZNEqVi97RYin9XVbZoqNw1jsaVL3uTFs5Pbltp1iLXcpivXFrsR9W8R31OBSMoQZ2scWkZkqBPPCRHoxBY1LBuHi5Wd9TKl5wd1xXWAxsHB0/WuuzgmLnutHumyjGgGz3KUc3SkZOYvI/B0i4TIOm45x/MJlyJ4/9DUM5q/aKvvaNlzJDyi53jfB0nXPVRCVrTkNzwv5tsr3iAVbhqI/ySaD4aa6sZsGmaRNMlqnh1ZAnespt4crmiucQHS6EfXygiq4gbSgLKi1su0HZEZxba5/i4S+Pyf4TmOEBdlI3UcS6FyEy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:37:13.2315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b97f4c03-c5e9-4fed-0bbf-08ded6d69a45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
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

kfd_criu_restore_queue's call of kfd_queue_acquire_buffers was
failing for multiple reasons
- The ctl_stack_size set by the CRIU plugin doesn't match
what is expected by acquire_buffers
- The svm buffer cannot be acquired at this point because
CRIU may not have restored it, or may have restored it
to a different address.

The only reason acquire_buffers was necessary here was to
avoid a null ptr dereference in init_user_queue.

Just put in a check for that dereference; it doesn't appear to
come up in real use cases right now. That is, there is no
usage of CRIU with shared MES.

This is a partial revert of d3f670cfb535f
(drm/amdkfd: Properly acquire queue buffers in CRIU restore)

Signed-off-by: David Francis <David.Francis@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 071f956f183c..3bbda47a4439 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -265,6 +265,11 @@ static int init_user_queue(struct process_queue_manager *pqm,
 	(*q)->process = pqm->process;
 
 	if (dev->kfd->shared_resources.enable_mes) {
+		if (!q_properties->wptr_bo) {
+			pr_debug("Queue initialization with shared MES requires queue buffers to be initialized\n");
+			return -EINVAL;
+		}
+
 		retval = amdgpu_amdkfd_alloc_kernel_mem(dev->adev,
 						AMDGPU_MES_GANG_CTX_SIZE,
 						AMDGPU_GEM_DOMAIN_GTT,
@@ -1042,18 +1047,10 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 	memset(&qp, 0, sizeof(qp));
 	set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->adev->gfx.xcc_mask));
 
-	ret = kfd_queue_acquire_buffers(pdd, &qp);
-	if (ret) {
-		pr_debug("failed to acquire user queue buffers for CRIU\n");
-		goto exit;
-	}
-
 	print_queue_properties(&qp);
 
 	ret = pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_data, mqd, ctl_stack, NULL);
 	if (ret) {
-		kfd_queue_unref_bo_vas(pdd, &qp);
-		kfd_queue_release_buffers(pdd, &qp);
 		pr_err("Failed to create new queue err:%d\n", ret);
 		goto exit;
 	}
-- 
2.34.1

