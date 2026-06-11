Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB93CD98C6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B3810EC91;
	Thu, 11 Jun 2026 03:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a71p6Hw8";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012066.outbound.protection.outlook.com
 [40.107.200.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724E910EC91
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRabtDsWp8HtddreT5vblPsGEe6lquGSKpHAoaPACq81JUkqn3mA5NdKwswudfqNpzWydCrMCvLozr5L8rcLcy04w/pqI+CZW701jBK5QO/+SM3cFx5g3qXX294zPBTmxfUfZsIWL8mfs+njqGS1K9yz056mplJ2d/33kLzXXW2wMUXVjW0ZwJw/XnWTBw0OIX3hiIP5jzBTtaaxR5EYIOhbhDhzmqlXc6faqqMaacx/5TkAedl8n89E9z7can3ANlDyoZB+SoSzRspu8FoYz5YYbX7Zq/INZJYQPdxeb4pRetbS/cKWLVfB6l+g7o34EXd8Q7XXS0DVUQ5csUhVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG69ruj7plmzCtzg3ARgXINjiALqlCbJoI5eB91Vwm8=;
 b=PIKV2TzqzyOPItGopG5y6zW7UU9Me2ShGVZhhloPZNY7D7RKRuZCbeoO5ufmSv+6/N8tTR+y/MYR4fQjGyF0Za0xfMbMrU3MeLqCHDqlg0iK/5Xi3YR+CLycp5Sz7mvKoXHDe/O7N4FIFs1BM/NSHuE46pREHLTXV68jM3IOqoQxT7JQy3woLE39AUQwLzWxo69e5fZLovJSKrc+yrkwvSgMufUYjOk2XkwXnpfNHmwkZT1sNdQymXiWFBkuVStzHIx2r6RnaBffuuNqpAZgV5IcwBuu/ZblqVt8I5cJlvDFVVXghqtSWY4OWkqB3U4sYFRNCSlt8poVMi1DUH1GIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG69ruj7plmzCtzg3ARgXINjiALqlCbJoI5eB91Vwm8=;
 b=a71p6Hw8275GpluhQxlILsTc4XJFqRKnUDvN8LeQ2wZWYKIXmjpXw0Mg8AvTFlzg9Jp+dZLF+NVD4kw+ElwNPAbMmGuCycc0U26wplsHR/6R7HGaBygyGKNYPdyN7AVtVjIULzsQv9Mq6bdzSZrt31k1KYxTgqnbMmaeUM3rlDo=
Received: from CH0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:610:75::24)
 by CH3PR12MB9314.namprd12.prod.outlook.com (2603:10b6:610:1c5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 03:58:22 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:75:cafe::a1) by CH0PR04CA0109.outlook.office365.com
 (2603:10b6:610:75::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 03:58:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Thu, 11 Jun 2026 03:58:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:58:21 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 22:58:15 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 5/7] drm/amdgpu/gfx12: strict (me, pipe,
 queue) match for gfx userq EOP
Date: Thu, 11 Jun 2026 11:57:32 +0800
Message-ID: <20260611035747.548780-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260611035747.548780-1-Jesse.Zhang@amd.com>
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|CH3PR12MB9314:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c94d94-7972-40a7-aa30-08dec76dae40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xlpbAjgpvD+es3AM/w2+HW3uc4t0ijubdnT90H4ILzzwRkM4I4NFnXcKSPc/jcesi36cfoFsmrojJ/fRL+QAhmcg0v7rbTxiGoGZR3UV2EZu+d43V8rGXgFbkmxEE//+dZtwJAvhnC3CqQUOQ5s3QTTDtxAs2gUZOVaEG8EQ4uO3OXGGWFOaIu/OU65mxvtR2dcO6gsCxMGvJ9b3+rqAx5L12PCwS1SVEAzrptbn0Bw1FgDs42Qcozg77hd5OxBsJzI/FwmIgCEsFCWpz5mGerkDUobHy6u0SHAkaab6XaIU41lp1/GK0ZDLLJNka+sl+NM2hQj9oAw5dzxIUW1eX/spVeZ/ayQQ908m5Hy4xgQSXsMV35PNi93lbXYBlqtLNZgmk/shqApsULUW+GMxPtPQdnR/ckmI6sDmhmIi5IgXHq3Yw6I99Sx9CA7E2w2lknGpWn8ib+BNT+uQSzktJzyKTjlPVighDkQ62i9tcOndjc9xys8PKxevGK/SxNa7oP2gkGbUOAdlSY4XflRFcAt0MmN6gNZcRx9WDr8n9ElYKKb6vGn6hqHFoyBjJYupCGwtPr8H+8Yai+nIS3ut0khW4mrdi2nskjFaGzhjZJSw1FQJaj8Qy3ceuHk0jCtXxKq2dXG+bAApyk+UMrHVBq3mTfCWpALbL02Ed/hRvQCVLxb/98dpX92bS6nEp9HabGyCGokH1uKni8c6KMfhiE2lCuE/1WlRz0Jhg/FBDHY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TlZhe/nqcqxKgGJGkyof8lNvMXkbh7xF/8lT6S3x/1VOumSpwUXzcu1SztT+KE1qlgFtPTwKMtli1CUzf+4ZsWa4+MGeFdc+nI2lMImZkCn4gGhL2hAgTTOvH6daYgM2bd1aWlRVjUJO/NtAy0lGtOsNlAIYr7cwQJCrxFfxXA7ds1oZkUJsUdl9nIx32SC++jXNnVXB+qXHgnIFYcOydADNbT42MIfhpHwkDEtj70CS31aFOV+U4nT9QW3lnAo+cRYiDRCoz5q2m6p9K8uDreJLIm+HKDDyTCnAltMH5O0LF2NG6bmSUStlbgN2Lpjrby5nJCG+M0jSJDpoJODZcn3Tirj0RQuK276S1GKS8kxbC9KcuiPjp0MwtWlvXxnCKpG0BUIe/JMfTXjrrzD9mcrQ9aDcqPq3/nL5+U0YmAESez+XtIplm51wYqgEWUrx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 03:58:22.1700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c94d94-7972-40a7-aa30-08dec76dae40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9314
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

Require a strict (me,pipe,queue) match in the gfx case.
The EOP IRQ case me_id=0 (gfx) consumed the interrupt for the kernel
gfx_ring[] based on pipe_id alone. MES splits gfx HQDs per (me,pipe):
KGQ owns queue=0, userq gfx owns queue>=1 (see amdgpu_mes_get_hqd_mask).

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index cb4d84c5f52b..d9b1fc29e9d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4858,10 +4858,17 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 
 		switch (me_id) {
 		case 0:
-			if (pipe_id == 0)
-				amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
-			else
-				amdgpu_fence_process(&adev->gfx.gfx_ring[1]);
+			/*
+			 * MES splits gfx HQDs per (me,pipe): KGQ owns queue=0,
+			 * userq gfx owns queue>=1 (see amdgpu_mes_get_hqd_mask).
+			 */
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if ((ring->me == me_id) &&
+				    (ring->pipe == pipe_id) &&
+				    (ring->queue == queue_id))
+					amdgpu_fence_process(ring);
+			}
 			break;
 		case 1:
 		case 2:
-- 
2.49.0

