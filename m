Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F362ECD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DD410ED91;
	Tue, 19 May 2026 18:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0CTREqnF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0185D10ED08
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngIZ17uBOpTcA2UowGHOcDy0i6NlHzc+CYe5W8UmqZTpkHopTLwUCqhv/HM08FpgPQaL9QaeNw/SJ8ZlwU9SMHzGSFIGSRvNX5t7sBvI35a14eNYGXosUpfpg3plXHfOvJ2+w2eqMnYwz/iUimfyxs6Gg8ORFcDJPTOwjqKMP+c7mkVGjwK25XSuQHUp5vgh4qdV1834EKr2TfX/IBP0po1yiX9z8ob2B76cG7EF8xZBcTaWkcjxXHH/tVNEkS5HwcFdoqP2AHuCb6IweISZIo1IZxHsbrCOFRTMxGWyaU9O2dlUfCILlXzVLql6rJjSGUicu2pSfQTYLKxf9nsUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTaVIaVNUpLV2MmGRCjeQrk4sCTdurCWWMfdPqRNA00=;
 b=YUrgj59OMYgkarfCpoWV/AXU9QA3YOIVsPENLsCGf5PAmOCUFTtdE10qdWQaEj55baQVwVLCFXM4uXldOts2Q6/d+exlg1Vkd9dkm9ejYKsTTPldI/RDXcd0S6odAW47OUCk68UG28lT7ZEBq+dkP5duvVbxT+698BY5eppKAfZstAuHE6IWcnp6WmtToCWwCb5tTpdYlaPcs2pCuOpWPq0Br3TkD0TSspxlH6C7qXMznuIF6V7tsJmWqoUtrxX0phPuhYmBT6CWjuvMZVYpl/xsqY32pp9Vc8KnjRCqmH2UmZo8HgprjGy1gOlieI/LR4L57vy9ZDpkBigklZqsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTaVIaVNUpLV2MmGRCjeQrk4sCTdurCWWMfdPqRNA00=;
 b=0CTREqnFP9FyxRNPr67tg9HZDS48FT8Jf9Xg8QkkXopYSmRwXHmDOZAASrDwWsQ5IsZ39O2Du3R1KL496752ERWJb+SVjpu7r2q5vIE/GDrGFVkCYBzuOmtdcW7gZAR8flAfSIV/yWUkAWYf90uQqIu6ADm+Oi3vCJ4iq63PjCI=
Received: from MW4PR03CA0051.namprd03.prod.outlook.com (2603:10b6:303:8e::26)
 by SA5PPF6407DD448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 18:30:00 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::62) by MW4PR03CA0051.outlook.office365.com
 (2603:10b6:303:8e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:30:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:30:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 13:29:59 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:29:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: don't reemit if there is nothing to reemit
Date: Tue, 19 May 2026 14:29:48 -0400
Message-ID: <20260519182953.21967-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb519c3-5162-4a4c-ca08-08deb5d4a2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|11063799006|5023799004|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 37ca3SRjWCmfv2WFmDjadber04QGd7Zi3HXo9pmvmkwm0fXiM2Pyl1UwCEzFiN2PRgp3NXgaLyEqzUL7seB+yGvtGFmcs6Y4WHapAOJTN3uwDons9D0YoBWyZqdz4IJ7UHWQVY1jA9Kq2vN5h35BleaKb/61IPBdZhrgc7hE++QpUjYT64yGSS5Zg/8+MGoOHqpSdf8EHUK38S0cFpnDP13RTfYMxn9tZFmElisqb/Js0V/yHnKTbxBPNBKLkq2dTHgD2StFtCfPfDPFVHhvmXmV3o3dZakChY4DHVUIs09WJEeu1gXDbeyC5mlQM2BdfCwkJ6AbBAeQ7IDJaiB370mCuoEi54UHLOrSFZx8jtU0ROIeMlRzkkEUWxx55yOV+PeT3IcH3CVU/ubihJy67rADVIdPAnYPOnuigXK0ZTN3HH3/z/cRodPdd/N0K7mQ2OAyPH2OVlINBzEoOHSTRrc/EO8ID9pLg1oru/rWQ+J6tMcbX86+JtRItTeIxOw9Ulh4+nJwIsJCYoeUL/Zvl+ufvIOXMSoEsYOadDNqPRA4o9s+I2ymIaytvr35s9v94O0jcZD+uYsCRXWNyhRiLVCoGTHG7XqtFIhdn2gYHb+8lVkeC6eY4p5+JpnXClaWE/LF8jFHAPwAWKWVtKkZleK3BvWLzQSmNyx8GkHf/19LgDKjXo89sI8nJ56qa6v9CaSr3jVDPol6FGOxZr4LNXyzZ+HHcTHw3PHr8DHmXWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(5023799004)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lC4wLOZiwgG+46ofx0CY57NkIYTYg047wotl2EZWBWft9npP/RrIkyOhDSMpgoD9sEspByXhWRE6CtrbnkqCJtMwZrq0kgQBBK6vm5+cVp3Rbmk+TE1Wd/HXqGluJTFxlxCNQUssz0cIZE795qeltGLjtm0WC9Jw1bQvTr5A4yT7WGZMwS6SH9/Ulfo1gzE0pTUd8VZSpdqoAS9eKbygk0srE0YsN+b/dHqed71rT0ZTiKUBLY/v48OXC9VSzPZlSAS3KixBB8uJSeGq97f190YbRncM1W5jPrqeDip22LoFUBnpOfQvIXHzOTbhS5cffihXhOKRNVOcDb4DzJ1TU77SqSdfnFMG7Wrp5nXT7VS3Xb/uM4t5inRBdmAvMRYR7PEsjD7fgcW/vsbtXqwNbT64/paaQn8f5UKXbJMs4rb8+BwdPYoyX+J8upRjVr7R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:30:00.2124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb519c3-5162-4a4c-ca08-08deb5d4a2df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448
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

Return early in amdgpu_ring_set_fence_errors_and_reemit()
if ring_backup_entries_to_copy is 0.  That means that either
the ring is idle and there is nothing to reemit, or there
some reason why we should reemit, so return early and
signal the fences (if applicable).

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index ea69b1bac7c6e..6a43c8494fa8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -727,6 +727,15 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 	last_seq = amdgpu_fence_read(ring) & ring->fence_drv.num_fences_mask;
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 
+	/* If there is nothing to reemit, return early and set an error on the fence
+	 * if applicable. If all of the fences are siganlled, this will be a nop.
+	 * if there are still fences and ring_backup_entries_to_copy is 0, then
+	 * we are skipping it on purpose.
+	 */
+	if (!ring->ring_backup_entries_to_copy) {
+		amdgpu_fence_driver_force_completion(ring, &guilty_fence->base);
+		return;
+	}
 	ring->reemit = true;
 	amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy);
 	spin_lock_irqsave(&ring->fence_drv.lock, flags);
-- 
2.54.0

