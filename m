Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37652C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F3810E64F;
	Wed, 23 Sep 2026 15:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZbsguQyO";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50F010E64F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJqtxg10bX+WkmsnxcwwpHFdWXP7z2jDjHQCcNH1DwUtxhia8tFTkbmDrpO2OgHxct6XG4T0uIOI4GDl9BlnPk+KxbG8dv/efTgPQRz1BnLsHPsZSbHs68U1rh6c1ShqsgP6vyGoSUz7sUIkIrx+aT+y+IJlMT1DbFtSuESdWmsW3J8qmoJitoQuq4RaWoOC9ISOiRbNdM6Yy2J1uMzeJG/gx+dLGOXNNqc8BGhdGy3LEzZ0VXctlkagvrAAi7CecWdhkSCvoInTdacIqGwxAR4q8TLdpWWS1e3ahKfwvHnMjTX4/qACp/UArIxT1DNm4HXGILz1dM3o+b3eA9qUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7unD7bAKJIwIk5FBxhY2q+Dm9z/d38zdGAKEJ6baCA4=;
 b=rslUcoBVVChPJ7W52zt7jiVoff/6R+nfHJMzN7aVOfl7cN4nHtdEsKbI9e53Q95oeWlfMrHTF0rTOHmKxMzcFnWGDDkQjD+BjYN+wgzUkUJcc/pCMfxhciowpzAt5JblzuLwbQUIg0PuUcxnHR8D2ibiqeT7bj66cLqGVj8QxnXgJhCSVaXvt2pBglKVbwV9pkzIqTx59nozWFCTb+1JborCQiCFd5cTWUjCaw7ZZGMysnky54HygCWpU+C+GCl3uEClIqe64FprWo/tjfb4rWeqew5lX3splyIVfvlYktVPeHtkh47pXOXlvT7YPYiUGEeg+B5vM5SAak3kb7jvXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7unD7bAKJIwIk5FBxhY2q+Dm9z/d38zdGAKEJ6baCA4=;
 b=ZbsguQyOpaOtxpvqldKnhl8hLJSs3oWtp+Lgw0wBIl8Pt7cVknxPFGVln/A2hHyv1+qz7qxq1wIzV1e2Xx/V07tRcCXAdX5VK1W5KTICDtct+Ne2EADvF8HOd6JylTmR9y66MBnET9xzqAWhL/lpxU6Y1IpXYGO1dx1r+DatHP4=
Received: from BY5PR03CA0009.namprd03.prod.outlook.com (2603:10b6:a03:1e0::19)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:13:00 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9) by BY5PR03CA0009.outlook.office365.com
 (2603:10b6:a03:1e0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed,
 23 Sep 2026 15:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:13:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/12] drm/amdgpu/psp: wait for TOS ready on all AIDs in
 v15_0_3 ring create
Date: Wed, 23 Sep 2026 11:12:26 -0400
Message-ID: <20260923151226.2778589-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 9124a87c-3384-4ee8-7d43-08df19852821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: MeuiPaNkqRL2Uk+P8ViXtjtKtYlMQqdY4lrB+bVKZzwnAB0zUiR1MEaZH14JgnoZ+P9TezL2SrDBtStDxhqxHTLw0HV1WvEjkHnmPvluGfRAo7Rli7YYECcAicZMjUpPTdAKLtdMMG3B8BuVVYKdM/qvzfE+7PIeqi0Zg45Vg3yYY8C/8jSQBCgvRw/drpNEXYTLHp7TYYGqJvhrmntB7HqOi1hdXAva1NdK8lFOvMCiWFQzhXdjBYOo4O1Fm7YW++Vvc6ElTJ+rXLncLM/0c4amWe8X2RM4chr+VyfupotLZXGFCoiytURhFaQszqSHZAgt/5Nw7o8IQ4hEsy0fmNMneh29C+t3Thf0+0KsuLycesLkAbapXgC8bdqgGofndqYXy1AzU5jh/iup93CI86hLXKd4zn7wvc/kyNNDxnAR32pkd+9LLxYeiIV+NY7aRlHamgadmjx0DgLXRw8XuETWZNDrXWhjN5qEK5bBGznSSBUbhRL1huNVXtSwTPCwTDXyE+p69upY97W3WVeywcTmRRoZw1SAwVY0jcFx5H3KRaM0/7DfVt+IacShm1d6hoYM05LpuX4HQzvGXulobNbi9L5qRcwzxOmB6CEDs83lcr0zM6Px0jWBAUu/Pw95bdZOMHk75c7+mvORVW7fNum/hC+yfsJU38Q6uZAuaUBFndThRidWgSuNbSegeEXcnvfaSlVcv/P217DQo1+ldg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PSs+LuK29eFVeF1lCtgT4TO/DJHoqKvgaA1wWsWtPgErCZxeu+1CViG3h376REuQmCfmUm76TmR/v/MzEo8+j98VpD4qFNbTPxTklsdYJ7wQVAs11ViFECu6iJX/V12RU9cwLzCFbH/FUVXu79BsA6OI09Kf/D/2TLXMyLsCUQlVeDHx+4xn3vqiTY4mTAzPEk2ufT861DbbIT47OAEGPteRKJG2uVUW7O9cqBD6FZb3asz1byEuf2KzRdpFZfaWJITSLxH/Cbzztz+ta2jblfDddx4xSt66OxNcjJRkBiCc2+ISi+mjUBSvZkovRmLB2JfRlOXtRXgRXWQg5O8yuff7cegY1v/kcdX/1q42jiaCftymWCcjPTH5ADVRXkMbetv2ezlUkrPNMAag/BV9heWo2n15pOK8o6fUFdPzTeGgMZm7fm3JKAog0uCj8fhn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:13:00.2691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9124a87c-3384-4ee8-7d43-08df19852821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588
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

From: Emily Deng <Emily.Deng@amd.com>

When aid_mask is set, poll MP0 C2PMSG_64 on each AID instance before
creating the PSP GFX command ring.  Single-die paths are unchanged.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c | 29 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
index 33662a1aad16c..029d4f4b09616 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
@@ -32,6 +32,7 @@
 //#include "mp/mp_15_0_3_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/psp_15_0_3_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_3_sos_sriov.bin");
 MODULE_FIRMWARE("amdgpu/psp_15_0_3_ta.bin");
 
 /* For large FW files the time to complete can be very long */
@@ -242,6 +243,7 @@ static int psp_v15_0_3_ring_create(struct psp_context *psp,
 				   enum psp_ring_type ring_type)
 {
 	int ret = 0;
+	int i;
 	unsigned int psp_ring_reg = 0;
 	struct psp_ring *ring = &psp->km_ring;
 	struct amdgpu_device *adev = psp->adev;
@@ -272,11 +274,28 @@ static int psp_v15_0_3_ring_create(struct psp_context *psp,
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_PCRU0_MPASP_C2PMSG_64),
-				   MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, 0);
-		if (ret) {
-			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
-			return ret;
+		if (adev->aid_mask) {
+			for_each_inst(i, adev->aid_mask) {
+				ret = psp_wait_for(psp,
+						   SOC15_REG_OFFSET(MP0, i,
+								    regMPASP_PCRU0_MPASP_C2PMSG_64),
+						   MBOX_TOS_READY_FLAG,
+						   MBOX_TOS_READY_MASK, 0);
+				if (ret) {
+					DRM_ERROR("TOS ready timeout for ring creation on aid %d\n",
+						  i);
+					return ret;
+				}
+			}
+		} else {
+			ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
+								 regMPASP_PCRU0_MPASP_C2PMSG_64),
+					   MBOX_TOS_READY_FLAG,
+					   MBOX_TOS_READY_MASK, 0);
+			if (ret) {
+				DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+				return ret;
+			}
 		}
 
 		/* Write low address of the ring to C2PMSG_69 */
-- 
2.55.0

