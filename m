Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC7EC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDE410F47A;
	Fri, 21 Aug 2026 19:52:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AF6rqdyJ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F0310F47A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxNKTKW9390vD/kLlEUUhi7tNVsUYDRE2b9/JvvO3EeIuBpxCO/7t9VleZuGGp+3WHzDMgSn1ZoDuNL6aX3xCtULqCyRnU07oQ/ZlH0iLm1CgeGXrEZD8+uGPaFZuRvrOI385g2kcz4oSFbXNoArywxPr6mEE88edMh4fCOJ/Fu0mpftcE1PCM/AVIYseYvqs1+2S14AzbzVU+1iB5gwI7lOmksRxaf5+6R6o6Dffn3BIZS6t8RhbaiL3chj1Q8PnxRc2pPBd4WXTLu0FKtwr4RVw2TclY+udLe96mP8MZB57UtKuxOx4vlDmftwI/CIRdPEfCnD6mTj0HT0sCoNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMd5ucCHxvqkCC1PyzSQK+5ruunguxXbd3IDsROnZoY=;
 b=Qq338X7es1ZfYptHZ6h4WksPQ4P4XgZKoSd8nvAMlz5CghbEQaf/YfSzPUhU6TafCoyVbYnoZPsV/iCZO8s1XeUrEksaRpxGYcLGrts77OqPceM/hrVodCmNCVR1sdK7RVBoQ+c9kJiB3TNKeBm9BE7C5Gicp4f56nKIMpLBOyd+KAFcdjFwqDdUiGcPjgVjjTlZ0QuPMjzopZnW8I6PUUl3kt7U+8QkmB/47AWkA6otuvjSDFoP/1CVZ7m8XjD1F6njTDSdYgnjvlhWnrwp90lj+47bYH9Z+9bcPNdXuQQDMDK8vdJ5Pbxvc/4F8IZoxJjoyE6mBO/Jt390cK0oGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMd5ucCHxvqkCC1PyzSQK+5ruunguxXbd3IDsROnZoY=;
 b=AF6rqdyJMifjqrqzRl1E8QRMIS3t1CL3r25pXCbaUfDfjIb5ry0X1WRger1VgxusGO0+q6PmX+mYtDwkztzPya3kPemqNHdAly+BvcHThWGASI6nxkhK7RYqW/Lm2EXhmViEFQA/wBkH3vRQToY69FcpyayVnb0RwljNOrtm6EM=
Received: from CH5PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:1ed::12)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:59 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::71) by CH5PR02CA0019.outlook.office365.com
 (2603:10b6:610:1ed::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 68/95] drm/amdgpu: Increase UALink soft ring size
Date: Fri, 21 Aug 2026 15:34:31 -0400
Message-ID: <20260821193458.808626-69-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 19fc7185-2358-4af0-b411-08deffbb6d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uLwXS+Qbk++6mL9KVQkJmxyZfChye7LrJru/CYN+oRi2r+qq2urP/oNp+MB3vwqzm7rI3yEp6KeTnZ49tdYRkM6lxzTkj3dF229qKQPbXgK82mC+M+uogo7pyhGO93vPaIbVvQP8POuHXGL8G4q4nOzovYVIcgv8N2pqkYGpqm+6S9KbHYr3CBPo2V4MqWRhCV4mdPE1fnNHP9ho582Jv3GOTmMIkpyQg1SjBn2gPo7vn3OVTQQaWWMPCQ0M5leu6JioL9PGuQsmCRABs6jVStEEoSC60nK7ihcMNHRBJuaDA78d2l67Bzea/kg9OYcwmz6lfl+9KvAJt5PO/ZwNs9BP3DlNU17UFUOjqGiUErAcrbJaoVkzwtQQhtDjxeXJfAp6zpLQIUwaloTLCgtFAYNrkyi4eSEYryjCxwWpo0hrcRjhJ5aJWTchPtpsHeIIDsbh+x3lAN09pz0REJMYBLe65ObTWc5cPeaY8VYD9ktB3KxbsZdeVu/I1jJ2YdDYDb83Xgv326OJT+mlVcNBswuMJ3L7bvEzqg+bJndSOzPrkkjZlf5XmJDb23LvVWTp5P1nM1utObxiUXl9cEXSqqSKYmni32jM4vOFTOp6CZrqCxkERpPtMF7RxbifkvIPH7BF6CISMFBU2ktxgInBTYhnuZDVGvw3FdUBBwLDxLtjbkhXx/ryrM6WlD7zzVIm/2EHRZK/XKS2dea+n7naCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H+3qhJH/xzPzkBw04GzR7Qiw8iIYEeQ6sOOvRCfNeC+qcRBpnCmf1RuKDQ7FRkNz0gxtXnycds8tjf3TmnJIDYZ/wzN79ZfPBhAvFY1PQcoe31jb/8bhEGepG7bX7hfrNxizuUPuU1H4xBlnzadlIg1bJJsw2XfIanwNptxDTiaTc49ah3fYuWZLCflc/xcxbtmYigsuyIV4z1nGZgS3OE55bAJV9OwZrI1nok5MIvwpRVkm3GSLFqfffibITvAwsHWySvui/9FlnQsj7PZn2HrmHImfi0WVAcmcjXQrzNNssi2dTAN4Q+nAvWQG4KGZAbc7ODP6pJmw5yboQzNeET3/d7ULtJsFmR8ocJjg8vkIW9pqyV+phEYRZUOYuln5jkcR3yd/eW3D6zSGxY8RhfTWJMH7d1BS2SG0KdyVurB59O2J1+mbme1rvkzgRxKP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:59.5283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fc7185-2358-4af0-b411-08deffbb6d97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181
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

From: Philip Yang <Philip.Yang@amd.com>

The UALink soft ring overflows under bursts of interrupts from remote
GPUs. Size it at 16x the default soft ring to absorb the burst.

While here, read the source accel_id and context dwords before the
delegate path and log them, so the originating GPU is recorded for every
interrupt.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 17 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c       |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 11f834c97d937..8d74a89b40cf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -30,6 +30,7 @@
 #define IH_RING_SIZE	(256 * 1024)
 #define IH_SW_RING_SIZE	(16 * 1024)	/* enough for 512 CAM entries */
 #define IH_PSP_RING_SIZE (SZ_4K)
+#define IH_UALINK_RING_SIZE    (256 * 1024)
 
 struct amdgpu_device;
 struct amdgpu_iv_entry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index dd45c2e20be0a..147a3744cccb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -5353,13 +5353,6 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 		entry->ih == &adev->irq.ih ? "ring" : "ualink soft ring",
 		entry->client_id, entry->src_id);
 
-	/* Copy IH entry into ualink soft ring. */
-	if (entry->ih == &adev->irq.ih) {
-		dev_dbg(adev->dev, "delegate to ualink irq soft ring\n");
-		amdgpu_irq_ualink_delegate(adev, entry, 8);
-		return handled;
-	}
-
 	/* ContextID 4 dwords */
 	src_acc_id = entry->pasid;
 	dw0 = entry->src_data[0];
@@ -5367,8 +5360,14 @@ static int amdgpu_ualink_process_irq(struct amdgpu_device *adev,
 	dw2 = entry->src_data[2];
 	dw3 = entry->src_data[3];
 
-	dev_dbg(adev->dev, "src accel_id %u context id 0x%x 0x%x 0x%x 0x%x\n",
-		src_acc_id, dw0, dw1, dw2, dw3);
+	/* Copy IH entry into ualink soft ring. */
+	if (entry->ih == &adev->irq.ih) {
+		dev_dbg(adev->dev, "src accel_id %u context id 0x%x 0x%x 0x%x 0x%x\n",
+			src_acc_id, dw0, dw1, dw2, dw3);
+		dev_dbg(adev->dev, "delegate to ualink irq soft ring\n");
+		amdgpu_irq_ualink_delegate(adev, entry, 8);
+		return handled;
+	}
 
 	msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
 	local_acc_id = adev->ualink.info->ppod.accel_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 7f4ef50195f6b..87f65fd3ed08a 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -638,7 +638,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	dev_dbg(adev->dev, "ualink init ih_ualink\n");
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_ualink, sw_ring_size, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_ualink, IH_UALINK_RING_SIZE, true);
 	if (r)
 		return r;
 
-- 
2.55.0

