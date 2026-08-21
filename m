Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080CFC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969F210F4DF;
	Fri, 21 Aug 2026 19:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FGT1XemD";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9301910F4DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWDdmwv1Ch15b6NOhhRO2gyseaUBamkRhckG8r73e6+uI3l8Hc382Om3tDA8inhq62xWYoTRWtzeazlklv/xtQEO5qxbNLbxBYkvVbWtvTq+a+o1ow3eZnZ7aLOFog9vQ5MnHp/ZiF/o7+9a/6bunCRndXgJST5FCPw03y/B/xNMe2Opu4fp9oDO7WXuaa6J48hbISoOAMkDKhvIz0irPUti3SyRtNH3gdpYHgFzS0Da1llE5sPpoyK7CiaVMk5iMw6PSLh12zbI9aoFPyduWmk/hLCgRjYG9j3QZ5qipjw3/A1vOnpf0mmdBPQey206jFHg+iIpC5EMRr7wgNHmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8Oel0S+onfGWb/9LDZrQTmqbcbwoH6zfoEKlsmVDOQ=;
 b=zHhpqZ9hzhl7cwaLh/tHc+LfmZ4IssAdaJXHx5eOn/DGP8CM9DBKsRNH6j6OCAVdg+jbxmvFsNMvDWamdqbM8vfekitBb+PhVL67U8+CJacb77b2GCbdL6SDMWFKbDQZ9GljA26sMjWHrpXlbFPob8PuxTGVC0RoUqRrrbPXuMMfvDIdpoowVgcMsLx/aI7JYgUuhQT2cMgkqQpCX+V5o+MSQ+Js3AmEJelRFMPsVv2zAeGGsve+FkH8iKZJa1/Oo9y7jDeXWvcdfPHd2aX4rhMAP83UFBUKzx+yyzPh6fkAP6Uk5mv3QiRLMkMU8z8h14If9Oucg7/nF2CLTAOJ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8Oel0S+onfGWb/9LDZrQTmqbcbwoH6zfoEKlsmVDOQ=;
 b=FGT1XemDOIbaaE2DKIoV81+yvZ1oyCIfMmQnAJfkv9ZG21h31/VGHkFG2r6GTMWvg0Mk38w/vACPjLy3M/31qbUc5YnBQaMxvotKNKHDCYlRCouo9DvTbVBmiK0gJIv/bc7SWoWinigUIkoev5vInXPCyLBoDAaNG2ew1hU5ylU=
Received: from CH2PR10CA0012.namprd10.prod.outlook.com (2603:10b6:610:4c::22)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 19:35:56 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::78) by CH2PR10CA0012.outlook.office365.com
 (2603:10b6:610:4c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 19:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 60/95] drm/amdgpu: Temporarily disable sending remote TLB
 shootdowns
Date: Fri, 21 Aug 2026 15:34:23 -0400
Message-ID: <20260821193458.808626-61-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6273f1ca-1fe3-47e5-6664-08deffbb6b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GXY53Fcr3erKCE44rL4M36DPFIjShq+rLohGZ+7tMpCAZ96XLHYgYt9+oEjcNQEBeL0ERRXtyk8T+skUXsXWjsdon23V987jCgOoo04P7KgRwAiH8p/KlOhd1ROlVRp1G3GpF/ejj6+NCQJo3NfFrmcOxnTiHXT0i9+2SCZ1bNFJi26iqm77Ldw3bwLU9AC88EnKc3j66zIQ9e0x1f0mtx5y/Slg3SKABVgKdc+mWQn4RLm/D4BssMSzqZY0KgqFIwj/+p7pZyrLtyjkeaW9eYNPtyyZleK88pr7JplxI7X7YLCFEOhku9T64ofU/k+pwgwr+gX9nScBu5gHl5GczpR2+xtVpUYFwM2bNxF+BqFc5utQa1cVdd7ZotD7MFqMsHie+7uP2pwwuamCDZR0qF+jUR8E5RKVFfEj+hL2jqopTsDfRRZKSsTqGDqi1034wJw07DZZJTsgS+EO2NCvwLh0vNddstF+zQtmWJHBj4jlZWlYg3PSbnqM98U5b9eYqMnQj+rfjHe6A6aj1WEks4kbys/F0lPdy3BTUCvPYlok3DEmv+3967OAhUEEL6eik1n9aH0rH7XZMSc0imqOZVT69RXszNS0BffhDSIxIu5MmGo1eAIGjwS+RKemriXXtmS5GI+yZHMidZmSduFvDvVfL0ShdDd6lcXfG++Dx9Afyy3GvkcPDImMfl/1f0yjUK87ziP7juInZLo33WbVww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uGLk+9eZ4oNPQw5HFQ1ZSJtDWUV/EK9/YXGhjJD2q4tURSGEG2kqn8hp3CfBpe2w+fE2L+XordUpyYX3ghX+ux8sPtikDMX8hwlkabVgdfTmb3g/fs3PRv2jMbfB/q+hC5yRE5e02cSVZj7+j+kjYWwBj19XRQRFn6qPUOH8edChW+qh8HlA/H8U+vC5SjiLryAgLpg2cckMluzgJc1dioB9zFXgZ+9rP0bWauFN4seK6x9NGeJ+Qx5nMZtEYoxSW8jIN1yXVYL0dzL3J9oUN2PQS7508+vSLqolzGAtE++3FU9aEfY93aoksRs3tKrRyEarfXA/eF9XauNAnrupUyz2CbZWpnz2KpKkuS4XxfuC7HVNP5pb1s2N+93zhgd9uXCE4PWESdJyL8H7vuViX1xakeZ2ZmX/7ehHkRARph8Z9AwK8xUNQuH2SUxZqQF6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:55.6871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6273f1ca-1fe3-47e5-6664-08deffbb6b4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
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

From: Mukul Joshi <mukul.joshi@amd.com>

Remote TLB shootdown is not working currently and hangs the driver.
As a result, temporarily prevent sending the Remote TLB shootdown
messages to remote GPUs for now.
Additionally, also temporarily set PTE.X = 0 for imported memory.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c     | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 1b8f0a6162b6b..0a78a31a1391c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -4982,6 +4982,10 @@ static int amdgpu_ualink_remote_shootdown(struct amdgpu_device *adev,
 	struct amdgpu_ualink_ring *ring;
 	int r;
 
+	dev_dbg(adev->dev, "skip remote shootdown to remote_accel_id %u\n",
+		remote_accel_id);
+	return 0;
+
 	peer = &remote->peer[remote_accel_id];
 	ring = &peer->shootdown;
 	if (!ring->ready) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index 1468047687652..34d5767287d78 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -613,6 +613,7 @@ static void gmc_v12_1_get_npa_flags(struct amdgpu_device *adev,
 	*flags |= AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 |
 		   AMDGPU_PTE_BUS_ATOMICS;
 	*flags &= ~AMDGPU_PTE_VALID;
+	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 }
 
 static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
-- 
2.55.0

