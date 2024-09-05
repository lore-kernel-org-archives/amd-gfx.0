Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A06CD4F5E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Sep 2024 08:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A66610E123;
	Thu,  5 Sep 2024 08:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ArAt63Zt";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E953D10E123
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 08:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr7+7IetcFssIegrSMmKcH1ncqFktmxlF22IIpgroatzyEbRxbKHOLoIyHVrQEwCTBED8xohTPJGoQDxlBZWh9uWvrZlqcV6e33rQZ8NmL4/cAG70VhFviw5Odh1DzJ3+rlDWHWcHleNAmjjhRxxevw9lIAIggFVKkbMg33pnOtQ7L+gNS+41zBKO7KjGQA+s4VY4alLz2RZqTwh0u82hIuWftwzYYt896FJYgXJ15pJtXMMOq6WgZZBydqH4gHdKOt/LUqfXlxOOciKRqlL19oRB8BS/rapmKCHU2DV9d85NGglSZ2EzLaOoansS/7Vp+O9uBh8xsxewm3qOPN87w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJLXo7b1q7J37b+n2MXJaH6/arW9TQ/TnV8f1XXwnfo=;
 b=h4GXlj6ZWU69IyksIPEYGohIREZRV2dV/OEbBPL9aX+Qpxg3h32qWTF99eS/5qD0OGntOhIOey4nCToutybpy6/uF8D5QTfb4qs3YE4HzBVF7lJrDjigSCMES768sNLr6irq0cFly0HF9jOVTzMf9myqMt/+F+XaAgFS89AfIJHAUz4txUeDlMQ/srpdZTnAe0B44ZsUqXMxMLMrUJbRE/RGs67T6U9diO64fZCvLmxaMddgfVbjAiGpOMCW+ojWTSkO0zhK2ZvSEzvQPpw7w1htaGRREhoyC5t7SoUxaB87SJdiRShwFdmAwAPtXO+etIrb/92ZEjGtMpl50tynZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJLXo7b1q7J37b+n2MXJaH6/arW9TQ/TnV8f1XXwnfo=;
 b=ArAt63Zt4PByKegNyPLRmDvEEoFY6FmUi2HUN/MkrhFXTPii3ztaHmyot94AGxRONT6Npe9Y/qtmqShgS/ZckktcXe2aCSe/THSVdUserVVlXjqN1ez2vGzHMEctdU7SWpdjxV8GgwMvw66wbZYshfasFzqo4EHwPSx0OXb2pfE=
Received: from CH0P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::11)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 08:58:19 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:610:11c:cafe::b1) by CH0P221CA0009.outlook.office365.com
 (2603:10b6:610:11c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Thu, 5 Sep 2024 08:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 08:58:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 03:58:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 03:58:16 -0500
Received: from RSNDADJELK01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 03:58:15 -0500
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <nikprica@amd.com>, <felix.kuehling@amd.com>, <christian.koenig@amd.com>, 
 <emily.deng@amd.com>, Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence
Date: Thu, 5 Sep 2024 10:58:41 +0200
Message-ID: <20240905085841.18189-1-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d805f6-12c0-4a1e-a0c5-08dccd88e2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kXorElnYDAlSwbQnzEdJg/wJjREuLYMWK1jbVLaW2g7xkGrbbQiwbcxkoXzI?=
 =?us-ascii?Q?oNkeZz5ESdq55ZOLjEzFUPmDlydDD4nEyJuBXLYcgnbanlwl99dC1+Kr2fuG?=
 =?us-ascii?Q?4h4jTZKSLaYqncYdHjjr2Fx3r3DmKcCeeXhBuesIk8EnoFSkUDV/6uvuLn1Z?=
 =?us-ascii?Q?KcPw4npTk4DllY3sJsMnDGPPQ/WHP9U6q8lqaBLcK7HCE124BpIGw4BE09uD?=
 =?us-ascii?Q?Tobu6P3M/8849xd7h7q/C00sYd4CmSN5tq3FnmAHMicyMBli5LbhAX/Fys3C?=
 =?us-ascii?Q?aAJON6I90IxIXE7ksK9ljLtvG8UGgK0/FiNUluEi0syCnykzEQ4dVO5PzS1L?=
 =?us-ascii?Q?lj2WLXpFdON3DRc1SSvGnCNX5BdHqMbICC/YmjIEMqDUiSUxyCgkInEOwRhL?=
 =?us-ascii?Q?iE+nm9aWVWdtTcC0lIJbGQhKZXSBtDMjpaC+3ixe0giUzPzd3ggCC8NUDQoy?=
 =?us-ascii?Q?AEcJezSq3xqcA0tIman7wvcLZTVii7PwqzVYbzt2VFxm05fkpFpoAGDgd3Lq?=
 =?us-ascii?Q?P+7XZZAc0QR4/nnCd72lmWNy2qzeEguOYY8i5kssLbpLhENVLMXwzz5U2kwu?=
 =?us-ascii?Q?/JrB9XxeE98EG2/XwAvqDDTj82x9F0QmJSgMtW0cJe/zuu8l2xom/Qrhz2dr?=
 =?us-ascii?Q?rAzq9vGTghMEUdIp1e5vVttDZOfm/VtFAvEJ36Sei1WHW1X8CQmjYqtf7v6Y?=
 =?us-ascii?Q?kAPSBgzrdbHm1OnwgYdhmBxDj1I6Wr7uzFtHNnhBFXS5wEkczMXL+i+HyH3U?=
 =?us-ascii?Q?c/bwzMLE4d/60F8Crfn9cmbVHXYkKydSZcqQ3/cpK8ww72hy9MJ0gHp+m6Iq?=
 =?us-ascii?Q?xT2QREvHKr8pasTtDQfs7+oVnCiezTaJ5WiY9d2bxBGNafGiTolMSyh1+gO3?=
 =?us-ascii?Q?aWzJcbn4HY46AVn4AW/DcjMTDHmfdq/p19J27AQdQMiMhbjxUnhFR3++MV+d?=
 =?us-ascii?Q?gIW3waRXkVgLyasYwITD0p85SMigo5dbHJgBXvqChquFqmrbGe5sZcpru382?=
 =?us-ascii?Q?daiax9CWOnsr3SNziPzOt47IAW9Ka8Y25Sjgr2okuYqDUOYIqv2VUsxFDNRp?=
 =?us-ascii?Q?SIeS/EV2Q6Rkb6OaR1syQMOdAqsk9mL7nMTYe8Q+II5bcjA2h8lXqKCWIzqq?=
 =?us-ascii?Q?6rUTEbw2KO7cMDHpLx8sUGi6QnTQjax0Nw9D6QIUnVqPJuiaCZnfMCwrVgIk?=
 =?us-ascii?Q?AyGq7kNDqU9ziXfQ5XPwSfysMcTT93yx7vBePIilzmJSeP9bBp7oOHt+GyAU?=
 =?us-ascii?Q?wKAAOUwsjiXlnsKD1F7FTje5fRVMKlSm84uND7bCuFL0qA5T576NtV/nxfHf?=
 =?us-ascii?Q?/yI/S8XXOAdR8J01pkilT+itkMvgEgMRfvKF0hyjTBusH71wALjokxFi4Fxj?=
 =?us-ascii?Q?ow9x54GfkVDDsOh3MyvaVUyCycA+ANyENj0Vp3MTaFNzzoTqjy/xefqU+7CT?=
 =?us-ascii?Q?DTCmIjTfYSj3AuVSp2occqgjveP6TndX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 08:58:18.3339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d805f6-12c0-4a1e-a0c5-08dccd88e2db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179
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

When using SDMA for PT updates, a TLB fence hooked to a buffer
objects dma resv object with usage declared as BOOKKEEP leaves a
chance for TLB flush to occur prematurely. This will lead to a page
fault. Raising the usage from BOOKKEEP to KERNEL removes this
possibility.

Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f93804902fd3..8efc2cf9bbb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -928,7 +928,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 
 		/* Makes sure no PD/PT is freed before the flush */
 		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
-				   DMA_RESV_USAGE_BOOKKEEP);
+				   DMA_RESV_USAGE_KERNEL);
 	}
 }
 
-- 
2.43.0

