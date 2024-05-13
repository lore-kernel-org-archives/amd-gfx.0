Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58870C25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 15:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF37B10E13C;
	Mon, 13 May 2024 15:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRfywHOW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C95310E13C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 15:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GB0wNQd9/MQZDLf8lmicExVyPeP0KmyvVKR/SWGBOumiYzy3vU+/FVA/mVdm1cQhjXTJ5soiG91lGblNRH1YQBHKKlsMEHuSia0rNjhjSJauiVusTyeczZQ7K3KOgzcf0hsQ9Nw6r6OZqTJHQIfhaL6wNggrh3vlOSpJtzT38YzQcVkgSLvwlP4TMnCGRC01yYw2hL+XHkJxKqsnOxmcX5PlJ+qobMM/1Rm2VkUyXUnpp/91BUsHg6XnzvQsWQOp4neOQWDXLCevbJB/k3sTWbKpmsbS+tfXLBf2PS0vd9dUWaumEnBUT666NRPRNjc3s+470d1zq0xR58RGXNLRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCaxoQndOi7Bx9bXXDm0NVJVMwwhTKdP8FjyAvxIMTM=;
 b=ZtQzJzGvbdFEp+eMcut9094HY/EQPD3FVFuH4d/QThh6lzBGUSxCdwDhnEjx14O7F7XXqFara+s6MfU7hyXzGdYZOwQl0aGzcHRdPYZqEnfOK6dh5STDdCx9J9dMgU6gIH0bBJ/MZocVY5n887mEoNPTXY+xd7HR096Etam/98K/s5wbkiita8rQeroPmkAGkE4mTrzlfQYeAASlIJoyfNQnWZ5FHirJLJeEWmEDNAUbI5TIGgFtOfSJOJ/52osquU+Xx6+Kj5bG6Peva7eOSEvaJPqB1HcM6a8mKQt9qetrKTmguUyENXCKdbmVsnlZAOsxociDDQDZf9aZv4zrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCaxoQndOi7Bx9bXXDm0NVJVMwwhTKdP8FjyAvxIMTM=;
 b=MRfywHOWScBt5/A7t68/nEcIltALG9ux5ubgUDaIWHK5xzhkK7j0z8FCkX9qT58/zN68fiJGofBdoVjd3zbDONxx7s47eDQZIRWEdIByMUTM18/IEygN1QFIlNcS3Jl2zhiR+B+oU5/z/Y3iIWc5kwbBfzq6kleTQy9xRHzXFbU=
Received: from MW2PR2101CA0023.namprd21.prod.outlook.com (2603:10b6:302:1::36)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 15:17:22 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::a5) by MW2PR2101CA0023.outlook.office365.com
 (2603:10b6:302:1::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.6 via Frontend
 Transport; Mon, 13 May 2024 15:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 15:17:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 10:17:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 10:17:19 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 13 May 2024 10:17:14 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <xiaogang.chen@amd.com>, Xiaogang Chen
 <Xiaogang.Chen@amd.com>
Subject: [PATCH] drm/kfd: Correct pined buffer handling at kfd restore and
 validate process
Date: Mon, 13 May 2024 10:18:42 -0500
Message-ID: <20240513151842.125976-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c0b293-bce8-42ee-5c7b-08dc735fc971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Pu3MmwU6cDcbaU27dhAawHgfsqyBX5kXHcPHpLLtzoxd1cGmZhGj5esjbdef?=
 =?us-ascii?Q?wHV4vxRyvgeD2HqrWh3eJZjgYaJexiOqy/vJnTK8RL3SDedAWh9ZqRfLpIuz?=
 =?us-ascii?Q?dIrJGiIA653c2BiNHTD+zBcJHqpnVtWE0Ri2u4NNmkApfBR58M+7Tz3V++hK?=
 =?us-ascii?Q?PW+9igpeEtZ9inr/tvRe9b03El7RmAG/CwXu4HHvbexkeknLkTcMoly4Un+0?=
 =?us-ascii?Q?mK3ofMR9GjEwnAtDd/8C+ehM2PwzjUKsVVNAXkkOL5o6ft4JsETIbAVRDWFT?=
 =?us-ascii?Q?fSv/yL/qnnzGnUdRxGD4rUHjC0ZsetWyrkRcwMwoBSW6UdNCecJhucdvI9he?=
 =?us-ascii?Q?trYDB74QHjy/LTH0cddMwthF1lxFBZnN4dDCBTnr2Wr7re6kXaD8QHkdwgtj?=
 =?us-ascii?Q?kfeWi7mt7HJtVks/CHidxwLIL0eETSRa8zdfcxUXwdeZlPJS0V3DE/1bRH1q?=
 =?us-ascii?Q?D/BRpkMlTvC00Qm8rDFh+dzwX9vs1/gWztamBACr9Vu7RQFzqTScG5/lOAWZ?=
 =?us-ascii?Q?GTCkQpBYMW5j0BFT8am5SFE5k5L0oHHx4T2IxFgKvDvw2Uu7mohgkRhZHzl5?=
 =?us-ascii?Q?9CtRnD46E/4Jy7fK8EVO87e/Ec9StCzD6hHAmVimTmd7WCiyxBvEs7ingX4X?=
 =?us-ascii?Q?2ZvmbjrlFypjR/pQbB1sQP0EKJ7wCWgi9N1kumVgWwXQ/moYdy8QstIYC9cb?=
 =?us-ascii?Q?Wq2JunZLcUboKeb0ktF75q4lVY/1LHD/ZzpVRlCFDofFOW7hW26yNnpg2t/R?=
 =?us-ascii?Q?Vh/rQVUPMoJiUc0x4/csNV7ArZ3VQYeW/x8V8BBsW2PGRo4IhTB+5g6MWJmz?=
 =?us-ascii?Q?LsOQ0ryYJMWn8vr3iwMtJD97XErUfcI1Iq7r+z3MIPGViqpGFb6sRFqTi7gu?=
 =?us-ascii?Q?3D5LSIIy2kMgZyS7DveENF3We9pNA+ot+hAQtB+GGWQgSZ0567oIu5nmXTax?=
 =?us-ascii?Q?Kax28jI+IjMkZHtdYw7SiCKal3YY1jiImieU7itpmsefqW0h1k+ACNsVVWrw?=
 =?us-ascii?Q?zH2wRbpfizUEV2kuK1qyvlIMOYbLsOGWkIcpArJQCb0PdQhKogSXOvqDLP1g?=
 =?us-ascii?Q?WFM5u1umjekYSApK0EbMqRhIWkCD4NBDdHBGC4j8g0yVglMsJrkKh7XNPG5m?=
 =?us-ascii?Q?+5ayt/RATjWNGT3lsWhib6VlB8yCMFkd98NwcjHUXfhhmxtXhLwy6AiHSuN8?=
 =?us-ascii?Q?Q/vjZKYIFQvJVM/tMibHvUceCNCnL0tLq8PvzEX1+V6lf+yS1X7Q6JqcAeLb?=
 =?us-ascii?Q?459YoL55l+MHhZ6kAOj9359MzzUt+yO63oqp5tpnnIVpVceuWPAMCbyM/iwc?=
 =?us-ascii?Q?5tceojbocw2D6IvIKCPMJfYkq+3AYQKAu4q4YSJGq88YUs5T9+9KG7zT+YhJ?=
 =?us-ascii?Q?xLDdXLU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 15:17:21.6786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c0b293-bce8-42ee-5c7b-08dc735fc971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

This reverts 8a774fe912ff09e39c2d3a3589c729330113f388 "drm/amdgpu: avoid restore
process run into dead loop" since buffer got pined is not related whether it
needs mapping. And skip buffer validation at kfd driver if the buffer has been
pinned.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 3314821e4cf3..80018738bd1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -415,6 +415,10 @@ static int amdgpu_amdkfd_bo_validate(struct amdgpu_bo *bo, uint32_t domain,
 		 "Called with userptr BO"))
 		return -EINVAL;
 
+	/* bo has been pined, not need validate it */
+	if (bo->tbo.pin_count)
+		return 0;
+
 	amdgpu_bo_placement_from_domain(bo, domain);
 
 	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -2736,7 +2740,7 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
 
 		/* keep mem without hmm range at userptr_inval_list */
 		if (!mem->range)
-			 continue;
+			continue;
 
 		/* Only check mem with hmm range associated */
 		valid = amdgpu_ttm_tt_get_user_pages_done(
@@ -2981,9 +2985,6 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 			if (!attachment->is_mapped)
 				continue;
 
-			if (attachment->bo_va->base.bo->tbo.pin_count)
-				continue;
-
 			kfd_mem_dmaunmap_attachment(mem, attachment);
 			ret = update_gpuvm_pte(mem, attachment, &sync_obj);
 			if (ret) {
-- 
2.25.1

