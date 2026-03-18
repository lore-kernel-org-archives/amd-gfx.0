Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CFC103E17A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF27810E83A;
	Wed, 18 Mar 2026 14:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gF87dkLJ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498D810E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmacS5+aMNOPHLMC55KmocEZbuSJrZLPPO3EDzncnqqm6mbXJWm64twMKDTtDgYGL0ERVDAvdidATZsoBO1U56kt8jMVzRlSUSkw0/ygL2N9ESa6sTpzIZYbq6ioyoeZq+4OlGhMJUcYgRlynMM3H3jJJAUGnhP9QeR/Oi5oYPDdozpeI8qmmTeRHTjY1/F//0nbwBZgPOWsBavMcIR4rquYqUH2EgMQHI+mslFcPT0FNj3B83xia2CC3QwHkV9ulkdIkLp+C9McucyLQhqOYhmKiiy4Wova8K4H4PjqefPx1ojYpauoMJTEaoXs0LPhdQMbNCFfmRlqks7KhisZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INq471NoupzTNRXgDCEXZu22ZCzuuNjEuizEVNgJh9s=;
 b=dIeIq1KSuiNHCPCou6bYH0KhY3tX2R/y2Zmg6xk/pOnu0LnFOe/bbjZVdwVm2GSEY43AvAVg0pSeZFHXkh6rKwEdQVWAVArAwS2K6c7zvo6Y/GDT/6/+NK/QpI/J7K44xxHlQ3CWLgIxqnQJIZ4rTmMBaGIEAHuOY2HTjqkhFMH0z/acXKA8mdmNkOJ1TIEmLoOdbMgaNb75yaYoyh5X9QshhExb3ucOKZjIE6/ZsZTXVN5bJldJtllHf7TQLQHDRQ4gdoT4IsdQfqofLgaaW0zjQhQVBLmNJft69px5F24Z0HALejqHPWtl+MNUG70WYNpLEUUo2nIfE+ase9VcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INq471NoupzTNRXgDCEXZu22ZCzuuNjEuizEVNgJh9s=;
 b=gF87dkLJ39G4IhiyCWP00iQXJXcXV9YQdXiKrhOKWDrij+5m+4C2z87cu3aq6XrRvC7ua8S+sHRmTrtw3v8nvIgT6QSJGNCCh/0UxPHUlMhP0ZE0z3+xJmzB7lV3nQmyPGefVKkBCzsUKVeC30oLOKnx3Ze/84qm1cB4q1Uiw40=
Received: from BYAPR07CA0038.namprd07.prod.outlook.com (2603:10b6:a03:60::15)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:11:44 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::49) by BYAPR07CA0038.outlook.office365.com
 (2603:10b6:a03:60::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:11:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:42 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:11:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/9] drm/amdgpu/sdma_2.4: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Wed, 18 Mar 2026 10:11:23 -0400
Message-ID: <20260318141129.583333-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141129.583333-1-alexander.deucher@amd.com>
References: <20260318141129.583333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 447862ee-f9e1-4444-e18b-08de84f848da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: AzlFHa30hmo6cjSrWM6KUfjTkI9VY/QFICvWrQeR45UGw/rg1VhE2fZfCh8PUyuBLsT3ojqKkKHdyyhC6WTmd86BhcO/Hw/vIwtZJ2pxK5XJ6lQ1mN4CL4nN6HnppSWf2+zRbuqiIHcyN4s2wRMLPDu83zakyYv+kWoKSMkivMpU8MFjtCWv6WrJkFx4p9Y/+hE0vyU6ds7hSuKIrd89YysS6acibaS17OOTxy6aCgeSIJNF4XCLgEUdS4q8z3fZ0+oyqCxS9MNalaSCDPR26Uq2e3iDrJUkFVWq1faoDLPBZDudsBiJ/u1zKVr0N0GG5tasHKo8/UBdfI08NzuBA6lmS9qMHLOrgnhDgHAAieXKwep5D9Jb62Iqa2uwARLAywZRpcQ1bYQhijathhJ2MDHZZT2mtoVAMGqF8K6zs0dFPN/Q6uVx7oGoV0rA8oXG4YxOlcgERGh5z26OFRRaBOwF05YuSzFJFCtX83SfXazqWHoKdU1XlVjmN/9wNzjIFVxa3+f75JpHbxzFFvhxgMq9W7HHjCdk7HveXU4r31vFYumYeN9aQ06O6QyY7h4QbJZJoK0/4Y+wonlazaGqn3G0YvqpsXS/O7yrUYsjEeGqEj2CH77ALxsFCn2vqnSZYTgfKjKI4D8KJiwL4kKoUp2Qf2e6kUbODhfdc504XtDAXpW83W6+Pub9cAhonfb817zQ27p8H8HZr1HpK5NboaJ5/r1576ZYhU3LErwqHlePZ+g2QjznS1UZkJRJYNzA+05NVqyqwde9lxjodeFM/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KKsF6pVT8RF7mx0Xy23oz3juim/EHaeXYOTf4TekDemmKGSnekXw4pCQP4ZqpfPphni2ZF4YS1+ExHxc5EBZL/OkyQNsQS58mjMTP1hpPz+ZyzmUCOTKK+gm8Fr9Iwa2o39u6Q/7u9GjAbVjOgfaNjd2dQGt5ve0EupEToRCgcJY11bRE0Sn6yhmcqIbAHDtQtjPpBT3O7keDc2UX/etREyTeOjt1434zHLMWwDxrl/e0h9wRFzUeyv1+qgYUTMzesalZS+5k4kNVSD7xT4lYfyBmtKgwWyTLFNo5d9Ux81QNmzMpCX8G2THRfSMa0VkAqqGzkh7hQdQZNdliFDZ4S6ES6u2vqIOUz8b6ppo1lrnCYOp6S2bWwEdKUbxVbuauaMmSBSj/Phlx03Q694TvdFgjlesvIuZPEOUnnjrxYLoNKFil7Kp5F/59wvEj8hn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:11:44.0836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447862ee-f9e1-4444-e18b-08de84f848da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 0090ace49024f..ff03cbae1c59c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -420,7 +420,7 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
 		WREG32(mmSDMA0_TILING_CONFIG + sdma_offsets[i],
 		       adev->gfx.config.gb_addr_config & 0x70);
 
-		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 10);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

