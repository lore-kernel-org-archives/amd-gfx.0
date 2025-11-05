Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F07ECCF9F8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 06:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A0F10E2A2;
	Wed,  5 Nov 2025 06:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uBn2FONZ";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013005.outbound.protection.outlook.com
 [40.93.196.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E14910E2A2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 06:16:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tI6UalU8vbXWFjfx/5HdemzWWpshTWlMV4kyYXyPeP0oOAVVYt86QyhXlC4avBihAfZqnj+RD6T3RbMm5CgUwSs5lqSvh8Tpjwbu/TVYbJ3G6lqR3LMtAtuelqTUrD5134nCePgBBqPlmuABZlp5Ou3BIxNulh+Wvahy+PuEm/DreaVveklPqeUJAl51DeOwcB/NxFw/eE9i3EITRAL1xdfiTkBQtHABwG3fjyVUZwAaUssGcdi11wVnW+kPBrXhd3eFNnVWB8rszz3CswSHOEZU+lMcst8uZK/kcITIJI+79l9pCHhvQqhtfAZkGmkwLks2QRNz6AcnGFAlgZ0J7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK4Q9LkXP8hg3/X4gXTKVtlDNXWvWfrLbDUqEQD1AWc=;
 b=s5qbvttKIiwr0z7koOxS5PXO/h6Dwf02taFWM0XFwmv58Clf9cE60/NEK7Ye4/BwcyjuLIgXnay4+sgKyXRxjje56SmKnxOuEmfjbruFp/ghZrK65mVYbcNVRsg2OtPBfmpB0P+zVCZ7befUahKF/jn2rZKp6lkpTHk/sUmYD54UVJY9ADb9dcq038TAoasLh0zebeYcQJSUUydZfaTSpfBiSkXWG6MMnAtAErL7aySXz2Xhp/CV0d9qXNbDq6RQzBi4EtYaNOxFGL3qKWzcsLzwDZXWJF7A3TeZkwg/aNdm+9p8UqEKVYWyXS2CvA/JPv77Q94aEyL7HMi2GF9WUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK4Q9LkXP8hg3/X4gXTKVtlDNXWvWfrLbDUqEQD1AWc=;
 b=uBn2FONZokicTAOX9bIu9ci6ZKPJgWtwkRajiswAI6EJ9txlCoyBQRbVW/i+QgxkNBRgsihe5lwboJ0foWL0TyI66/d5Wo2ps9dmtdHMEPQ9JAJ6YW8eMT6Kt/yq1K1pQLqoyrDOhuhZU9N8kIH4v9I0bRW6sD+tETFtjb5RWi4=
Received: from BYAPR05CA0032.namprd05.prod.outlook.com (2603:10b6:a03:c0::45)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 5 Nov
 2025 06:16:45 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::a7) by BYAPR05CA0032.outlook.office365.com
 (2603:10b6:a03:c0::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 06:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 06:16:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 22:16:42 -0800
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: fix the vm update tlb sequence
Date: Wed, 5 Nov 2025 14:16:30 +0800
Message-ID: <20251105061630.4146604-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105061630.4146604-1-Prike.Liang@amd.com>
References: <20251105061630.4146604-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 188e929d-bb0b-46de-e3fb-08de1c32e50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BXV9hcsZnAtoRRNICL9XswrqyfO0Wjc2wX3SNBy+Me/rmlBacfUaFFNKCU7s?=
 =?us-ascii?Q?lbrN/KV4szjfawfUtw7zCZfgq+BMsycBLMWno6cFnhmbozGF6HSbHxB/ilh0?=
 =?us-ascii?Q?8Ox563nZepw6jlFUhE8rott1tuDAxOxJyzyos1zs2FKsCfpEmeDhSe7gisJb?=
 =?us-ascii?Q?9SK5XQHKE7LAXzEf2T/9ctGt5N8GNMga1RhPK/DZ8uqdLfjEOYQqI70vqFY5?=
 =?us-ascii?Q?4cKk1OMsXk7q56VbIIMqmdQyF5WpsQKTo7TsB2s/vRneRoxXW7qpVzV/gVps?=
 =?us-ascii?Q?1sM4WxyitZ9MTfZtoe+gl2q1DFfN48dMvAbBXLJjNwuJ05VYoYTOKds0kPdY?=
 =?us-ascii?Q?4hLnjsnQ0us1p5A6+FEjvjEffulWHiCnszgLj8XF8ezQyH35828LJkxzeVgB?=
 =?us-ascii?Q?i4QbNljkqtJHi0ImePx5i8n4RIpcYVe4SE2dwJzsjQpq2c89yQzhL5W8DdbO?=
 =?us-ascii?Q?SzQu+ABjMcq2zRUYAlIBCDyXBpml0uo2i/TO8jLa61zhcHM3nnD2+PMoy5AL?=
 =?us-ascii?Q?2UKKvmX4iqzPp5LnW58vtmtxtF1I5PSjPQzuOW2Ivq/t5YLw5bGeGA2JhJML?=
 =?us-ascii?Q?LccvSpFxfoPDL5qtF9cOBkKkQVnhEWQmbBTwlwht3P4boiYM1K1wC3rzIrY2?=
 =?us-ascii?Q?RCIMGiX0wVaRlYQ+GJ8XBVQTmwmK8egS8KlwjyYr9W7kLwK/Z6He6gn6NbfT?=
 =?us-ascii?Q?TtN/cbUiuqQtB0a/ZUm8Aw5qFBaRLR3BRp6qfqSLnrIrg0QEoekYtO0PcEDY?=
 =?us-ascii?Q?DF4545Xkmu5SWpXl7GK8LrO6bNpKg5h8EhHbY+WUnLkwPMCNQFFfDPm2fWai?=
 =?us-ascii?Q?3kR3XzYJcsQWNZ/zTB2d05RiAICFjY5ms8hbKO5hvfz5W3aYVYKwl0/BWRNE?=
 =?us-ascii?Q?a3ENVKeB96F1inuCF7qDiChpycKDwBysYyEfU41UdPn5jh7lhwrvjg9r3Uyv?=
 =?us-ascii?Q?CdKMcEoblvigwRjkuLq0g3WfRQjFtrdHIWt0tMW/bAxk125egEapAv1TBGqk?=
 =?us-ascii?Q?EiPJa/UUsc4g49wCtYt90YgKobgL1lYn8YimpwyGOpOx8jHJvm7ZF2GoGsuE?=
 =?us-ascii?Q?Cn2pFMdKyr0CxIND27ug2QfEI38yWfCnx84kxNMASEZdNCIq41uCTKCGkeNT?=
 =?us-ascii?Q?ukdzFFvSuAWoNJtfxhWq/7G722BdIQ7I7k94CBsbukBZvsjlU8WuO4gWceLG?=
 =?us-ascii?Q?+X54pJMrP1yPvMba73PYuZRLariB3vHSxvc4TBnvp7dBsHJxg4+EXgwU3OOy?=
 =?us-ascii?Q?aaA8Tie59Vzo1dGZfXnwu78kQfGifYeWR9BYSqd4Je+gT1EuvVSLYZScC5B9?=
 =?us-ascii?Q?xUNDKRqo3F8B4v0M4L0AqyFd5BKRR5J/ThYOm8WqMFjDq7xyaC/Y2yeO+vNI?=
 =?us-ascii?Q?ow/420EcoZxw6rYXPI5KKgdtwOQXpzK5c5LRg/S6iR0WgQ2yuOAgNWj17zOP?=
 =?us-ascii?Q?a0Svkn9X3y2k/3HQZj/Iw1Ajfu+8YwspIj8XtDJSeTiM796VI2EhImrR5kd5?=
 =?us-ascii?Q?kU7gkcSYb7yrye0tNbk8t96U9hATK0AYvMQTORZEBhloCj4hXaXzuvTolQIO?=
 =?us-ascii?Q?vAnl6T4s6l1q6z08SRc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 06:16:44.8496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 188e929d-bb0b-46de-e3fb-08de1c32e50a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

The VM TLB sequence is incremented by the VM update
commit invoker, so it should not be increased again
in the commit callback.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 0c1ef5850a5e..f7a5e71346df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -106,8 +106,6 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 				struct dma_fence **fence)
 {
-	if (p->needs_flush)
-		atomic64_inc(&p->vm->tlb_seq);
 
 	mb();
 	amdgpu_device_flush_hdp(p->adev, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 30022123b0bf..869f9cb28d94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -420,6 +420,8 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto exit;
 
 	r = vm->update_funcs->commit(&params, NULL);
+	if (params.needs_flush)
+		atomic64_inc(&vm->tlb_seq);
 exit:
 	drm_dev_exit(idx);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 46d9fb433ab2..0ceb2474a721 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -115,9 +115,6 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 	WARN_ON(ib->length_dw == 0);
 	amdgpu_ring_pad_ib(ring, ib);
 
-	if (p->needs_flush)
-		atomic64_inc(&p->vm->tlb_seq);
-
 	WARN_ON(ib->length_dw > p->num_dw_left);
 	f = amdgpu_job_submit(p->job);
 
-- 
2.34.1

