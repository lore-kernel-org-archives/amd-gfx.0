Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7031AC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 09:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1927710E1DF;
	Thu, 15 May 2025 09:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mK2cs4s2";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D1010E1DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 09:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBSXDcMpIxezHmYgKR3XnB504WZur4BFnkxGTqgRO4mbjS9wW/Hk9EZt1rup4cQ4UgrJrEZgWS85cmTe5jyf2LoInu+rGKG1KtcN+xz/93PFCcueBovqEPWt23er0JZ7duQ5WetT7uIcqIssjiiq3ZRARQAzQ04lbKstkOeoqB0iDMeLiSbbLczW5624bna3CZaFSndIx4mCOZW8BX2uB/XNs0MwXOnhjZhu0nTSv5PP6qrKsoMf8ynLIvAMhNqXexxp06C7wSTyfBp4UoMRQCHoDaiixKldSddgyU2sgvo2g2k3XyeLEhNusmXG8Qz7Rnwa2Hk7AFiyawwyvxwXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJvbxng4E78BHrx0u3z6HkOEQOxWsgrpbNn9JuYur4E=;
 b=ZQpyW0Xbla3LKM/t1MNxTp5PCU6YkPUPWyoRArNiLyc+2Hd3LjIuaQyGl+12Akz5pjAMqStYHgZnz/AJOofgC+D2h6DyViRcFFXQifpIL84Bw8yq3ymCorGZxNcia/oFM9RRcGrDeqZcCqOoS2t/lVxf/P6PqB1BqQ1hVwqcVvNTxQnIaxVETAofSEJqZSEJ7Vu8PFLnQMYNetu6hZizRYCKDt1O0hfKJGB4xO9jjCSPCsR4kjV24AyZaPEXn4q3ZbO11LyTZ5C7InQ+8QLrsciGcMFDS/IPDJ4/xWr9Zi2sBEgclG3UXs75up5sTnAQWQQcYfPN15RlaCuGLl661Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJvbxng4E78BHrx0u3z6HkOEQOxWsgrpbNn9JuYur4E=;
 b=mK2cs4s2I+Kd2K0kwpmzE+gPou9eYjmq8Z9PLbbVTAilX/Hg9wLY7rvpoTTDkcSilmNkluD3c0yKtYO6ZXCbkiexeVgyTTtuGOpzy4sSibh1sDroytLRd78Yddwc8yI8OOeaZ4oMRgvHhcl7AxOyBL/4kdWqAhpODk4mZnWz+d0=
Received: from MW4PR04CA0259.namprd04.prod.outlook.com (2603:10b6:303:88::24)
 by BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Thu, 15 May
 2025 09:44:23 +0000
Received: from SJ1PEPF000026CA.namprd04.prod.outlook.com
 (2603:10b6:303:88:cafe::d) by MW4PR04CA0259.outlook.office365.com
 (2603:10b6:303:88::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 15 May 2025 09:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026CA.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 09:44:22 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 May
 2025 04:44:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 May
 2025 04:44:21 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 15 May 2025 04:44:15 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix user queue wait ioctl fence counting
Date: Thu, 15 May 2025 17:44:14 +0800
Message-ID: <20250515094414.1786372-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026CA:EE_|BN7PPFFF39339DD:EE_
X-MS-Office365-Filtering-Correlation-Id: a08980ef-5640-49bb-c1ae-08dd939512b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ULJ2VI0jhnkWwILNYTelex8XK7pZkZIVVRD78TZbBm5txWkDYQslBf3FXyrV?=
 =?us-ascii?Q?XYqsdDwO7mg0WINxOHBLOUUkvLMUSKRCSaoQwfzKHESECnD5d3Ty04xzQpaa?=
 =?us-ascii?Q?nE5tQw48XoI10Rj1PziATtWqGUIhFF8Hf/qBiBQ94Wtobda3Tl+9plXnvRAf?=
 =?us-ascii?Q?iCxyVfRvsXeaNZvt/5uujaeZwJlZWH8lStMs2y92NiZyWllyjjPuxvrU902Z?=
 =?us-ascii?Q?mlQfsbtz/aypuyTGCLTGJ+7ofBHPMBz8JbWgQokJil3EoH9/PKlIu5RYYQNx?=
 =?us-ascii?Q?wA39w5jbnq2ZSBqwlQOr9ASMvdxxNS5qTOI9eTegxQwf8nT5FC0V4hCvExdq?=
 =?us-ascii?Q?j6lnVnA7gkaUSYNy68oO/nEaF4KFxczdzwy+W0Dudqna5RVVRPybk0MKdhNd?=
 =?us-ascii?Q?mRg2vuykf1SoSDWXIWxU71Y+yalCnRKTQjj3rxTT27nNDSjJdhbeDfLORmZ8?=
 =?us-ascii?Q?ykiL7Oa6JpBCFgcy6S0ZO4+9ZfcwjN3mfaS1txJUJFNyXJMK8noOdbOBrWpk?=
 =?us-ascii?Q?S2O4LZIbjVqR0TLcoR17lDZuhOeBRHIo9BSToOlI4q2TGTKa9AA1G9zOxk1k?=
 =?us-ascii?Q?bhzhUUbRSWWLqsNZO3FpjABu3VS25t5AHWyB52/qo2WoLsEB60j9zlnT6F6u?=
 =?us-ascii?Q?+aQER+1jzECF1TUDbD661XDEolG4OV6FcelWgThMSylVW9Sy8tI6m7feWfpz?=
 =?us-ascii?Q?I3rFEJCKYJfz3ZPkvB27w/tuWswuCqCmHQvq7t2gh5+VV1jdXYFCO5hypJtL?=
 =?us-ascii?Q?UIRly1IL4zRc7MeTWMyjwzas8XMKBd3yuT2D/C4f60iODuSXa40bMn7kqtVY?=
 =?us-ascii?Q?5KrfckTfsBYr0JyaiMftDaM6bSVp8BicOXmwqO57s4JRvCvouR5j3Zu4PThe?=
 =?us-ascii?Q?tXw21fyDXUIVT3CFL0NhZuVNFPPZAdrVBgAhgPEoPWQYiqPBgnV5FmLFORWD?=
 =?us-ascii?Q?S00v4wFq//vhGKAhnbyLHAMAk8j+dKneLmGXPi6RBXDY46KrqivNUqtS2QRV?=
 =?us-ascii?Q?a3d+ggS/gokQHvsZta7J8FYPgGozzyMdjTsVRoKaxpCx4CxBUji4ve6OHqKL?=
 =?us-ascii?Q?Tx4e2sZq4bhXo/O9WHvgEQEPbFZYYhZAeP5cCp/ZMTxggGAekejg6A6ytkps?=
 =?us-ascii?Q?JbvN7rwxvOrdG4tyeDhoOzp5sYDZiIpmWwrqva/Rza/z5bLii5jQIuV/N4DB?=
 =?us-ascii?Q?DOkIsvHY/xasUQMYI5+qffEeD6BsHOTG33AxgsOaLm5YGSBOvDqV6AFKpBq5?=
 =?us-ascii?Q?YvJlSwzVbS+Manm4DYeeGZFhdKL57FZjW+tMQohzbh6adOUspE88CpsoF4f5?=
 =?us-ascii?Q?SiaxlM3ffOJINJroJmA8BsVOZU/qW9h6J+T8GyOVnxR2ksc0U32QgIKp3Qsf?=
 =?us-ascii?Q?BoLS48BDefx7bLgcJfBhoLLwV9l4qtbQsgONJ6s1DBXviH2wKwZ3AOnm1kR/?=
 =?us-ascii?Q?xtaHLzyVBEgMLE6eF3UP7Lw0Ef55p75/QpOgf9qwkqA4F2nRTRnkKS/GeBUA?=
 =?us-ascii?Q?+MQOValPpl9dGBtUsGoKniie8zIxHFOtqSd2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 09:44:22.8584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a08980ef-5640-49bb-c1ae-08dd939512b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026CA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFF39339DD
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

The original change "drm/amdgpu: promote the implicit sync to the dependent read fences"
(commit 714bbbf20a72) modified fence synchronization to use DMA_RESV_USAGE_READ
instead of DMA_RESV_USAGE_BOOKKEEP. However, the user queue wait ioctl wasn't fully
updated to account for this change, leading to potential synchronization issues.

This commit fixes the fence counting logic to properly account for both:
1. READ/WRITE fences (for normal synchronization)
2. BOOKKEEP fences (for eviction synchronization)

The change ensures:
- All relevant fences are properly counted before allocation

Fixes: 714bbbf20a72 ("drm/amdgpu: promote the implicit sync to the dependent read fences")

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 029cb24c28b3..8c754474882f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -735,10 +735,18 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		for (i = 0; i < num_read_bo_handles; i++) {
 			struct dma_resv_iter resv_cursor;
 			struct dma_fence *fence;
-
+			/*
+			 * We must count both READ/WRITE and BOOKKEEP fences since:
+			 * - BOOKKEEP fences are used for eviction synchronization
+			 * - The wait operation needs to synchronize with all fence types
+			 */
 			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
 						DMA_RESV_USAGE_READ, fence)
 				num_fences++;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
+						DMA_RESV_USAGE_BOOKKEEP, fence)
+				num_fences++;
 		}
 
 		for (i = 0; i < num_write_bo_handles; i++) {
@@ -748,6 +756,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
 						DMA_RESV_USAGE_WRITE, fence)
 				num_fences++;
+
+			dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
+						DMA_RESV_USAGE_BOOKKEEP, fence)
+				num_fences++;
 		}
 
 		/*
-- 
2.34.1

