Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02001C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64DB010F1B0;
	Fri, 29 Apr 2022 17:46:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DD8910F126
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fx5Cn2BnQjwk+mL8U8Ey4HWr4T+yyYIFvYOLXjBOgDKfxgSn0UogLSzqHisWDi777wldYXl6GlVrltGtcADPxy3s4QrXlBOK+1kQ77eSd9UY1dpNlm8xlDemyVwth55G0ljOylXo7JGYinmpA9mNb/PakXA6D8PMORMNYWALLbz6z+xddtfo5L+KNhe+6SZpWMG9zXY4Wh0nkLf0UzXfi4Xn+dDcLCv3wDq2wT+7rFlhRaVKBKNSDL9coHASUqB3i8jK1M8gHOH6CxOGeqd2K7lFcAoYTuzCbaOg6IWLqeTfWNYxhtCB1UuZw9mNyc/2oDu77jz8CpfmCOyHmdjgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuPvG1aUOuW/iosjjBKT+JE41jaOQtzx2NLglVxaWXI=;
 b=d9C2fu+qVTQVlTYfsjEBSYBYtd7wBoT+uVnriTlYv4vzADLW0z3hKRXeaIq8gjJkqByLRyfbGTio3F2uB6o5Tn75Y7yGn+01R5rFaTEjrv+XY4B7eeCHZ11z5jxLn2IV0B7kv7TVKAJSYO/o90h3PyH/VaJ/jqNd6K+ubNmTQuxek1vjPQY4M4UQEmiQQtxaGVwfkkbKV3HuUedftkGHp91sHIgS4Ilq+u7TvDmEI3NlmiYhKW4zix4eso45Rgs468nMHBX9b4ICPIUQBhFKKfUsr2dDgnhyGA2sV4TgUNsRnheMGdmiuZVar8BaHxta866NH/VYP6WAvVuxlNnTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuPvG1aUOuW/iosjjBKT+JE41jaOQtzx2NLglVxaWXI=;
 b=MJtMTQ7HOP9b/L49ZmFqUdwdRAdvzjIZQ/o5l0wCGm9g2w/DgLtEYQZnR0eyxE9wZScRymTNrKVVOxFdtU2T1W96Iw1yygnW2FGqkbx2C820X9a9qdmZKH4oT+/PrEkeFhR/m+WuvIWIgEKrzAJNZMdrJxfvgs1eG268SslNRek=
Received: from DM5PR08CA0056.namprd08.prod.outlook.com (2603:10b6:4:60::45) by
 BN6PR1201MB0244.namprd12.prod.outlook.com (2603:10b6:405:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:46:42 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::13) by DM5PR08CA0056.outlook.office365.com
 (2603:10b6:4:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/73] drm/amdgpu: assign the cpu/gpu address of fence from
 ring
Date: Fri, 29 Apr 2022 13:45:19 -0400
Message-ID: <20220429174624.459475-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ca65a2-3729-45ea-c77e-08da2a0838ab
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0244:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB02443DE9A37AD747BE358260F7FC9@BN6PR1201MB0244.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R7XxoZKisFRu5c8ztPWiZGAiohVXxTvpiVdHP4LGAin/9tovPVySFRfEPtYcZOx7uBvwh+dttqXHBqabwPTc8G5/46H365h3URvr/CxkPjVJzIxO7dnoahgRIU/y+YGMRv01NWKIkEt3ylYFWR6hK34Rdkv3BrXkShWkD6fX43353uu1Vqr/KaAouHg+4zotfuE8ams0zlLAPzkRHxjPSsGtMW/MhOg8jJUgX9Zi9ast/p48leBgCoMOtlhjwSvxyHLWiACF27+0dor3VRXoeP/GxnfH/+afJ46J50tSiwmi08GgZ8gTy7k0XI6+TXtrjvS2R/ZZo7m2towVCpAYVn5d59VSFb6oGD88FNhlMdEdf+ZTo8OcFRpJYDu3vTEAIkQr9TJoZ7+7hf8CasFNaq0/uLOuU00AfII6q8sVqyY3rmpxVG0jHU/wIfGJvuRUUt8O6j/84Bt5qxWniYkhimNlkGx/ywDb9OuAIbW4L0Uny5DSbv05Favy89RGFaQ8TY7XIkWSLDLbB2QHBVk52eUtQKzeM+jB9rPmzmGMsO0tJTTDQ8ud4DrpbWZr5FEfuNAFWgOwypvHlZznECVNGax9ZfgUYSZaJPJPHIIIA2PGredWINENsrnB5gsnvpxF5Jh2r+WDq+4NOoyHjGKk3y0Sek4jEMzHeUQeNChbNZnJ82kWJI/azVBn686E6DtIsyEXUBt/eF2HSHYJ6VUUFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(70586007)(186003)(4326008)(8676002)(36860700001)(70206006)(316002)(508600001)(7696005)(356005)(8936002)(47076005)(336012)(426003)(6916009)(2616005)(82310400005)(54906003)(1076003)(36756003)(2906002)(6666004)(40460700003)(26005)(81166007)(86362001)(5660300002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:42.4295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ca65a2-3729-45ea-c77e-08da2a0838ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0244
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

assign the cpu/gpu address of fence for the normal or mes ring
from ring structure.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 5d13ed376ab4..d16c8c1f72db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -422,8 +422,8 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
 	uint64_t index;
 
 	if (ring->funcs->type != AMDGPU_RING_TYPE_UVD) {
-		ring->fence_drv.cpu_addr = &adev->wb.wb[ring->fence_offs];
-		ring->fence_drv.gpu_addr = adev->wb.gpu_addr + (ring->fence_offs * 4);
+		ring->fence_drv.cpu_addr = ring->fence_cpu_addr;
+		ring->fence_drv.gpu_addr = ring->fence_gpu_addr;
 	} else {
 		/* put fence directly behind firmware */
 		index = ALIGN(adev->uvd.fw->size, 8);
-- 
2.35.1

