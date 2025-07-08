Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFD8C83F0F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 20:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F241C10E1BD;
	Tue,  8 Jul 2025 20:15:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="obKockan";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8B110E1BD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 20:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHA0QSglKkm9sm/nl7jXiCYM1L5GdKudGBf7A7DB+xOtKY1ehiQ5U34SgOUNgnUMUSHq+i4ykH1a2u+ofxJJfsSBVasPEU680UFa+63dkBZ+t64BnqG8GyOGbvGuULhuolAASWTMTfg421OLLSj1eeLol15NkkJfHIcF3wfCiSz/2uZxkrVlo2Cn88rAEfQ9yHafRxG4Y1yBsnv+vWCgjmuyGGlHdH3FiqPm0VLr9Marqts46WGq9eowXJF64dW29evYCb8KLupWb8VtMDrTZV9+hpis/cgEL1Eg1ABSu8Rot0wq6bcUYcfMj5aDqlMfdGnVCCEzCJDViNTwWnP41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZHH82xfxMsWwKTisWmsMTfgbS4gRMt50PTWBQnzBPc=;
 b=gjX+vtGLOMTGOEJVbGolYodFI9P+Ui5FKB7tSYuEn2t8yXLvuIl6Ocj6dVoYWjozwIvE3a/K4FkdT1FkcBFiYrZpgwUDg8hqq2iEhPh48+TpYDWwqBF5TvyQ2LwyoeGyQ7juPpYzJaaHvCZ3RwIwNHfLq4GNvvKR+zaONqORAKFx5nOM5YTpr48lSiTZdE9AuPNmrNj7mo2+6GXefrTWaI5qw496k6bIDtMOFDFfnAG8IL3nkDScgEh46sRnl8Illp7Iexuga2vLSfYXZfeFFAV7GoVpGvoLv58uXvJDn74xqzGAxfgnxHNgehb/TiwaNHVslPSKsZnv/HeNjkymgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZHH82xfxMsWwKTisWmsMTfgbS4gRMt50PTWBQnzBPc=;
 b=obKockanuQYiImOEbBCCLfV1uMTaDsiKFYbCiQeNctEEP4Eo5y6MKPOp7yR/qHaNL8GYC3gIXV+P4+RkkYTos1gaLDw06PZghZ3fLqX7kKfQCpNKXlTVwbZtO6dj3ou+z5b2gkg/LaNeYA3t4TzsM8+/xfe3AOmGZq0SdVbpGqg=
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 20:15:14 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:303:86:cafe::f1) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 20:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 20:15:13 +0000
Received: from Devmachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Jul
 2025 15:15:08 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: Avoid extra evict-restore process.
Date: Tue, 8 Jul 2025 16:14:54 -0400
Message-ID: <20250708201454.1061462-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: e43fdd15-985c-447c-7c29-08ddbe5c2572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7PuSJ3Oqu7qr70DlEBAeynPo9lyp6+vC6lbZDlyb1dhWO7hQ9Y30DE5hKL8+?=
 =?us-ascii?Q?mdGYMCtAExuXzO/V9daZhTtoZ9larQ4bqZ+mz7Mh3bXMrjdp7aHMGebncPpm?=
 =?us-ascii?Q?EBQs2cpRGyKHKO9exubzJvclsOUmZSpARxNsMrpdl0/Xihp9FsIVnWO2LEpK?=
 =?us-ascii?Q?gQqPLAIFJ4t26vqXUgo88akyapvzqVweZxXs/o5TTfuOZIOOvN6FQ3aH2dCR?=
 =?us-ascii?Q?Y1Q/X1w7yK6pD5xJOxXihKMzNnUf9whOMMlqur4kPN3ss7bn2twMuoulFH4f?=
 =?us-ascii?Q?DW++JEy6mynbMIeyOYcsoqmAkFvRwutcrXc6FEG568UCJhc8FBUC8QrrgUP3?=
 =?us-ascii?Q?nV/3pDVRwI5lFxN66A6rlCmJwQauBatIqhwgGKZXyQ2dQD5TVQMZ7Kht92xe?=
 =?us-ascii?Q?qmQQ/l/iYfCV+MCnkJ1ImTtJmSV/Yl4MyyhaIRWR6FmlPzVjrD35i1ATfbwn?=
 =?us-ascii?Q?4SJquDErlSVrb9hutPHd39bzbT7G99gnf2XogO8VHdMgzze2sIWLCH3ne1aw?=
 =?us-ascii?Q?iVPQutCW/K1j0mPvJ2PTZDmgjx/xCmq6TwLtb4a/fvj43o9njOixK4jxPFxZ?=
 =?us-ascii?Q?j2pQ0V0PwEDGJO99oqCWdZZRcq2aQj2zgv4I3y93B7MKAl8RqidlU/zbB+HS?=
 =?us-ascii?Q?Z5BgT9515+m7pzunWyXnrK6BASuY9S8eBUq/+hs5NVbvi3tcDf8GthU6hHz6?=
 =?us-ascii?Q?nGR4YLbvqJ9GIhA9pBT0hctNLVUHksIbYOIf2R8g2amUi814ujUYZScrJNzO?=
 =?us-ascii?Q?zz2g94LCdCRDqwAbTFSMeP5ww4CLhbLmvuEzXEBb70Jh1s2fj83pSyzt+qHk?=
 =?us-ascii?Q?8mDFFuFgB6/YJ3dkCPvRo57y8Kzj3qN0cL4Q+QE7+Ga/+RSzK53n81y3nNIi?=
 =?us-ascii?Q?vbFxAbCDPfv9+LqdL7FPdiP+fgXgiOVHoLq+x8cSzxf11m8XkKRhUVjo8kQk?=
 =?us-ascii?Q?oOYXxgKqkUraALzn/1P8o9M95jqGuT7lHZtm9Vhjd8jFceL6Kq7VTHIlyqHD?=
 =?us-ascii?Q?5fAsGzqzh6XBQznH+rknim4ApKE1X4wdAJ1143O620qXiXP91dC91Y69l7zL?=
 =?us-ascii?Q?Qh8fTrIowVbMeGZ+7CndFfXkD87AQ3vuX8VW9dwAtbP0Wazcjfw8g6iM4YCB?=
 =?us-ascii?Q?bXNb/6hQTxntPcOJCEod9wSfThY/X8zc+BYuLh2IsF6iS0v9HGb/5iPd+3l2?=
 =?us-ascii?Q?i/VUTSzpTZ6DbEOxCtc8B04M5/Po64FIRvRSrFMGC53pQX+ryEbciX1F7CwQ?=
 =?us-ascii?Q?j+TfPZHWOihfy3jdnrArJFhFCCnp8ia10wGbMLHhGiRg/4yTNzoo9LmUC6Ah?=
 =?us-ascii?Q?deFl8MLyyVEF2oG1znWXCGuTeU9jIvWZLnrVTbO8Rlnh90WSpzNPffHrllwc?=
 =?us-ascii?Q?WRfjso9U7SyQwkIpuD7Jkw22BurdDbo28TpskBhbWa46QANo/2W7DLCL6Zdc?=
 =?us-ascii?Q?gDh1If8yDD3T1GJqNxiNd0+2UtrmhBHVPazcEh7OsdzBHRq721VvAXKRAxnU?=
 =?us-ascii?Q?oA+I5gj8UP28FLODNSytnxbLkCVpVqUkX0AW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 20:15:13.0182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43fdd15-985c-447c-7c29-08ddbe5c2572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
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

If vm belongs to another process, this is fclose after fork,
wait may enable signaling KFD eviction fence and cause parent process queue evicted.

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f042372d9f2e..8ee1b7e62dee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2410,6 +2410,13 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
+	/* If vm belongs to another process, this is fclose after fork,
+	 * wait may enable signaling KFD eviction fence and cause parent process queue evicted.
+	 */
+	if (vm->task_info->tgid &&
+	    vm->task_info->tgid != current->group_leader->pid)
+	      return 0;
+
 	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
 					DMA_RESV_USAGE_BOOKKEEP,
 					true, timeout);
-- 
2.34.1

