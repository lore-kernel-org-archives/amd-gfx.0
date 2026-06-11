Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1410ACD8C9D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 03:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23DA10EC93;
	Thu, 11 Jun 2026 03:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CMFgtDpP";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DF910EC93
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 03:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd99HSUQ9TFQoTlT3fxWV0Bkh0f36KC3ipZoBdFJ38oFGxzJTDVGUsdkkrLeCkQHmnHTRuPvMR5O8XHz9aBTZ4x4DT0Ua6Zdnl/y/oYh3QPr/nCohOwk6KNyeHxOEkCIoHHUw6sz7uI/+dX2WNcxl9Wdt/WBSdsJbdZjMAm/FBq2SEkNhlX71eXmTXfWsT/dZXQFZJIFLxeUepHkCvAhRwBC98jZMFzrsKkTHBBr7J5mLFZebyQPceJeIcFOYeNRNe+87yRRKvy0abgP3aJcA10qvQdzNr34mAxR6egnOfwbvyqpLU9J4tAwhAi+T3qyJyHwAhUSk1yVhE090CaXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edJFengGKBuhbBCzsX8J0ujyEVBQj0LWrUoeT+oDJMM=;
 b=eO1ReU7Ht+xi05oBG/HPD/tUsPe/Dl8bv/4y98IyYW924D+6+K5dHzAcmyjFomwPXrMdaqnrglq43sZy/A1gGMhlJRkMPwZPQ8zCk7JBCKrdt/hmdGL+yP7ThYjAH7QLUGAj5myFuLVi1ai/oLBlO4PGX4/6sLruO/DdNZbWrb3NdPTAGi9ERoggOGIypbv4e3yZ6X4VgZFjYt4IwIoCBTn+wxbIb0ydIO4ydWQeoLqmbO0cQ/E4FETwh7Rk9rzSvsJMZyfd8peve4evM95w0Rt32qiSux6pry3UbTbPw3//kKTn1UzYMLamyPvEKfFMwah2V1vDb8AV+TbzFCPBgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edJFengGKBuhbBCzsX8J0ujyEVBQj0LWrUoeT+oDJMM=;
 b=CMFgtDpP5Qwh/k+1BEAEaaQo64Z924qsPlfV5M0gzxiKvARlw50hJOtoyf5GFuEfpJvxwQ5dRZ6aewBi4ZHH+GH1YYMckpHMX+N0HIUXjuJX/Kv3TZ7/Y8RfBBn3Z7rIFFHpZE88ggAAxajczkoLq85LoCYFZkVp+9suAsOtB9A=
Received: from CY5PR15CA0098.namprd15.prod.outlook.com (2603:10b6:930:7::7) by
 CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Thu, 11 Jun
 2026 03:58:35 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::67) by CY5PR15CA0098.outlook.office365.com
 (2603:10b6:930:7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 03:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 03:58:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 22:58:33 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 22:58:22 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 6/7] drm/amdgpu/gfx11: try KQ first in EOP IRQ
Date: Thu, 11 Jun 2026 11:57:33 +0800
Message-ID: <20260611035747.548780-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260611035747.548780-1-Jesse.Zhang@amd.com>
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: bc41f2e4-2de8-4c22-ccfe-08dec76db5af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: UTdZHD+OyKUI1DpLgGgiRgdu1SyBm8KVnJSO/9Bt/hAwTG8y6/JU21dLxBfnYSH4OkMLJasH8RmLrPVAsiIPk7eszYl5fy3HWn58miJ+UWirA6GjrEjRqPZLQJn0agypQz9lDCgBSJx8SzB+brnTFDC0pel96obKTNl38N3tF1EFVMkwlMB1y1xU/HRoj20XaESa9SHXzcgyEqbamR61L3gEhB7N80iyDU2sGn2kjrAG68GjxKvdCIFYU/qJwBZi7UCX21R8fdrSkp9/S5CQiZrZoBn6DnuF0P4a5PF1rqjncqbS0fcLWLLTE8/Seri+JiKcsDuk4/ohqrk3i8WkWFVoyYbdZdTQVeazYSnvi2l5L4uxdgKrJJNHuPWvTjyoyD+jlmQsqL1gDCezBf804vbJtvzGWOX0MaH6MnRai0oSqth8by41rKYLfk4z8TJ9+Hq68KtbXIjMNfWo++7YzCaOTOEDpe9I74KVwFh/3QoihuImTM2hBfvQX4keevm0OFkFVI6xRtJNVcI0go/d1SYJ6kAEfAzA1MWlVCsAQWCuHed40tlK9jfOfMkhjkviXLm5pAVhV1W04AdRzIvuSCrZz0Q+W/5BeS41+12XGnkOfiZKgSn+/ajAuVrY2+dFNnOxUSQKakZ+pmdXiVV/WfxeZMLNBNRRRArTfBUTuBbgVQZH0AfeXwf5DyWDruYB/Oh/eoI3b0CcWqVIUTonS+Ewo8crV3B3YN9hCXouV7w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SM+t6txNPhn+4vTG13iczBDgq4slAg2ViFwGnUTzADQ6C/J4GfijsC38IHHEui0KmO+8DgegObnlEAmBGaUM2p28GMUKILUiIrPa24bUofSrXCeTbYOH/JM/ygGPBXtIgC465l1Ym3yx3AoKCknlIBuEOcX59ErKbunea07coo5+JzmfdUPwlxkqcSz3rldsU0CHl15/xI5jRFK/Wo1G/OVGCKMKKDQWLxEoU6OuN03CLl7X5Cevz5vUt44+DnHoutik06FuzOu6KNlq3CSXXAQMurUHr3ui6gC8sLljZI5eYiY0LI1OnDyTC5Jhs8SkhkvwTZbiXnBhNTd/meZcf0SG15EJu+klITsiBNX+16/IWJ3UEvPFdAiQifHRab+3xnLaaJTQi38iqPXkIYlw30s37CfNS+qDT0K/GSZbW6WKmH3wz2cqGZ3UET3fhm7r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 03:58:34.6286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc41f2e4-2de8-4c22-ccfe-08dec76db5af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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

KQ EOPs were misrouted into the userq fence path when enable_mes
is true. Try KQ by ring_id first (KCQ and UQ never share a HW
slot); fall back to amdgpu_userq_process_fence_irq() on miss.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 30 ++++++++++++++++----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 208f9ffed60a..a3294cf96992 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6515,31 +6515,32 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 			     struct amdgpu_iv_entry *entry)
 {
 	u32 doorbell_offset = entry->src_data[0];
-	u8 me_id, pipe_id, queue_id;
-	struct amdgpu_ring *ring;
-	int i;
 
 	DRM_DEBUG("IH: CP EOP\n");
 
-	if (adev->enable_mes && doorbell_offset) {
-		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
-	} else {
-		me_id = (entry->ring_id & 0x0c) >> 2;
-		pipe_id = (entry->ring_id & 0x03) >> 0;
-		queue_id = (entry->ring_id & 0x70) >> 4;
+	if (!adev->gfx.disable_kq) {
+		u8 me_id = (entry->ring_id & 0x0c) >> 2;
+		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+		u8 queue_id = (entry->ring_id & 0x70) >> 4;
+		struct amdgpu_ring *ring;
+		int i;
 
 		switch (me_id) {
 		case 0:
 			/*
 			 * MES splits gfx HQDs per (me,pipe): KGQ owns queue=0,
 			 * userq gfx owns queue>=1 (see amdgpu_mes_get_hqd_mask).
+			 * Require a strict (me,pipe,queue) match so userq gfx
+			 * EOPs fall through to amdgpu_userq_process_fence_irq().
 			 */
 			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 				ring = &adev->gfx.gfx_ring[i];
 				if ((ring->me == me_id) &&
 				    (ring->pipe == pipe_id) &&
-				    (ring->queue == queue_id))
+				    (ring->queue == queue_id)) {
 					amdgpu_fence_process(ring);
+					return 0;
+				}
 			}
 			break;
 		case 1:
@@ -6552,13 +6553,20 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 				 */
 				if ((ring->me == me_id) &&
 				    (ring->pipe == pipe_id) &&
-				    (ring->queue == queue_id))
+				    (ring->queue == queue_id)) {
 					amdgpu_fence_process(ring);
+					return 0;
+				}
 			}
 			break;
+		default:
+			break;
 		}
 	}
 
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
+
 	return 0;
 }
 
-- 
2.49.0

