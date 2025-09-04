Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81161CA1013
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 16:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16ACC10E329;
	Thu,  4 Sep 2025 16:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XD+4P1X6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A187A10E329
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 16:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdiZoTP3wXR8GxQLw3q4IoOKDBF6VUi97ZpW1CC46d7wOxhgrlZLLRiz5xU/g8KA4AMOiySAN873/iJp3cGXtvZE4xCu+q8dQcKcBnffcORJkmiAlfVZZwfzM0Qch1vZcN9xXMQB3tN8Q/NaoIlModaK5SbdFUDMPxOemU/89p1u1yYPg3bpxDDThviL1kSP2VupFhXlKDRAvgrybrQ9Ls9sdxQtlpWsta3L54qf+ao72H2KcesFIPDfKMV1yNLiSuiZenXhE1u8L3QqeAiLocyUj0hNdt6ngH/xwyVBXoVGm4Jt6M+Q8wAJ49vu/DQ3JCmflmdA6C0U27iitahj8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTUW7HQUr0iQKtwwsMyDOctCQYAom8bmX9KUInX38Bk=;
 b=jUlG4E6w+3N2dSZ3r0IqIPHpb0CzUjZUCwTb6eT2fMz7Hk2r5wU4U+uc12yxJ2kNbbTUj7EroyBo5T8b43UWsLj7JBlsmuueV8zfbE9IQbSJv3lceRd6UjHslox5o60WNhg226dfAFsgWlnDDmAXVp0nl7894wZOCzd7/0lMmABYxgx2F9uJQJGNAnTys74LlToo6ChfJqWTGyA76QtwX/xObxK+uBw+yQVRcDab7U8TGYMLfNniTeWu4rIrlSW3VN28ZVusidUbKnExvw/g16BlN/XPH3f546YXDNO4zjT/IEEGNiP8+5ryoE7vKTAGOwQWxPWmpnj3s1h7Ynv4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTUW7HQUr0iQKtwwsMyDOctCQYAom8bmX9KUInX38Bk=;
 b=XD+4P1X6Rc1+Y98PYm4/5gcDYgU6PeSTDF6YjVOKXNWSscC7g/mpxA1ZcM6ZuOtrXk6agmVYwvuFjoSqTjBGT7rgkjw+7tudOhrNwpzwNUK/qDo+QlN0mpwxDO/uLo9ptwZcUQY6U8Pl0btia4lnEdtlat6gfswChkrTag0bIrQ=
Received: from BN9PR03CA0188.namprd03.prod.outlook.com (2603:10b6:408:f9::13)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 16:46:02 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::66) by BN9PR03CA0188.outlook.office365.com
 (2603:10b6:408:f9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Thu,
 4 Sep 2025 16:46:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 16:46:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 11:45:56 -0500
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 09:45:55 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Lin.Cao <lincao12@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: fix a memory leak in fence cleanup when unloading
Date: Thu, 4 Sep 2025 12:45:43 -0400
Message-ID: <20250904164543.97199-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 353459d2-a27d-4ed1-16a1-08ddebd2881f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG5xMUFQQS8yRVFSanNxZ0lLNnhSMG9LUWkvSmhTRlRReUdxQUdMeEhrdTQy?=
 =?utf-8?B?RW81alAxRjQyaWJYZnJjREJNQVgxa0Uyb2lTT2dRdXA0a0dhOGRiL1dJcmJn?=
 =?utf-8?B?TXRncUNpeUNFOUc1bXNoTHJUdkVzZU9CSHJ5KzkreUo0WEp5TkxIYUhFaFYv?=
 =?utf-8?B?aGRtQTBRRHQ5bmpSb1k3c3dTVEJhVXhWWlVWak82TUQ4TDlpajBDS2lqN1lm?=
 =?utf-8?B?WXV0SDBIZVZUaG1SOE9OeCtrRjVwZ29nd1F4azVjNTRnb0tieG9oNWhLLzJm?=
 =?utf-8?B?MjJCd2M4cDk0MUVteXp1K0JUUXZ4TlNnSElFTXpNaHJzU0hBcHVtYWVtNlNu?=
 =?utf-8?B?b2t6U0VLR0Nac2syUnpHTGU1SkJGVFZiQ2hSL3diMUdHa3lrT3IvTlkxZ1Y1?=
 =?utf-8?B?cWNSNW9jd3kvclFiRDFKa1RXclF5UWVVR1NHOTU0eVVzcjdMWHA5TlJjaXlV?=
 =?utf-8?B?VkRBb2JaUEFGU1J2ak5pQUYzb29vak1NWHFpNElRMXorN3QvTHJYZXNGaEkw?=
 =?utf-8?B?UjZpd09jMTdvaWJFN2t0RGI5SUtsYnBpYlQ0UDZLMTJsWUlwUVMvTzFxa2hD?=
 =?utf-8?B?RVNENER6YmxqcDZEajVwYW55TjU5WmlxLzlOenJJMG9zdG9lR21WVktKSTIr?=
 =?utf-8?B?MWVEb1lRa3pUSnh2ajAxb3Zic0NFejd1d3pGL1FuMzBKWFpMZjlzdUgxTVBs?=
 =?utf-8?B?bXRKYzJPVGo5c1FXUWJMbm5IaFo2b0YyTW1JZkRSNEw0M1ppekQ2d2JxMXEv?=
 =?utf-8?B?YmlTMkpKYkwyakxjRDBtRHhkdnREMVlhLy9Fc053cVlNYkE0cm5IK0xXNlM5?=
 =?utf-8?B?Znp3VUZYdmR0cTNxRGQ0MThIQ1BWcEFQUm1GaWpaY2lJQzFxMjJLZ21IZTBy?=
 =?utf-8?B?c29peEVvV1BmN2xaTTR0dXJCVW5nL2ZuWnJ6U3RsTVlMa1Vzd3pTMHZlWkFI?=
 =?utf-8?B?WGtGL2dOYXJSQ2F4bm1TU2xvanVxcjkyM25HdnFyV2RIdSt2RzFFWXA2Ym9x?=
 =?utf-8?B?WldLMXRXMHMyQmpvT1cxMkZDYm1EM2RLc3dtQ0paL3Jmc3AvSVZYbG9KUVNz?=
 =?utf-8?B?bEJUaEhYcXpHVTdvNGJxNXF5dWVaU3huZnVKbktpamJFcGhBUFYxd0QweHRl?=
 =?utf-8?B?aTdiM3pFTGpuRmZvUEVxQ0pFWnA2S3RYbzk0eFNrekZZaXpNZTBwVThPd0JE?=
 =?utf-8?B?ak1DMGZhNFladFNYK1JrSGpDaXNQTGIyNGhwN1JTc25UcDNZa0tIS2J0aGxC?=
 =?utf-8?B?cWlBbENPYThOMTJFWkNJRFFGOFl0V3p6Sms4RFRJT2VySHN4WklvalBYMWU4?=
 =?utf-8?B?eWlxaVhOZE5TeVY2VCtKRFhlRy9OakdyS2UxYVpUQTJTaFJxTXFYdUVrV3BR?=
 =?utf-8?B?RituV0N4aWFVU3N1d2NodE1nbHFqUTZZdm52R0lzWjIyM0MvZmJEczlZR1Ft?=
 =?utf-8?B?R2x4S1lJa3ltYjRHaU9Na2d1QTFpNmozOW04S1JLZmp1QVdNLytRMUwxQ2Fl?=
 =?utf-8?B?K3lDZXQyZFF3SUp5MXlmVlJLN2Nrb1N1bXl5Vm80SndTNGdxZUs5cGR3RkVT?=
 =?utf-8?B?RTBPTzh6NVZOaElQc2VrVTVwOWVGa0pEenlocFZMbG5aOEt1SHllbXpyZVJ3?=
 =?utf-8?B?Y2Q3Tk1iQWFjNWc3bWlUQXR6b1BJZS9WbjBoTjZiUjFUSzNMclFnRVJ6OHdK?=
 =?utf-8?B?Vm1SVE91TzRrTERSeE9lZFpESWhib1N2UnVXcW1RZ3A1NDRKOTVITnc4LzJo?=
 =?utf-8?B?TkhralFOYVFCcDBaN3BiTHRRVUR1Sk4zL0dXNGdoTTQ2amM4VGkwYXJXSTUw?=
 =?utf-8?B?Z0hGbHMvaXdNU0FnZ1hncmJJckF6Z3RqMWFxM2x4a3gxSkR3bEg2eVZVdlpz?=
 =?utf-8?B?Z3hyZVRQalZZNDN2ZXVvUWM5MGZPbkJwN0dWQ3ZQMkdQMmdHR2FhZ0FxRDNa?=
 =?utf-8?B?OEdDWU5uY202U3NNUmpsRnp2S212dXJaY3RWYW9YaGM1dzlucjFPL3MrUDR1?=
 =?utf-8?B?aGhIRzdOdVVQYkpSUzFqcmtSTFhTOS9INnZhanczbGNWdnk4Q0ZYU2VZcG9W?=
 =?utf-8?Q?9oG6VS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 16:46:01.5441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 353459d2-a27d-4ed1-16a1-08ddebd2881f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
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

Commit b61badd20b44 ("drm/amdgpu: fix usage slab after free")
reordered when amdgpu_fence_driver_sw_fini() was called after
that patch, amdgpu_fence_driver_sw_fini() effectively became
a no-op as the sched entities we never freed because the
ring pointers were already set to NULL.  Remove the NULL
setting.

Reported-by: Lin.Cao <lincao12@amd.com>
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Fixes: b61badd20b44 ("drm/amdgpu: fix usage slab after free")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 725d6437fe8e3..375f99082b407 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -421,8 +421,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	dma_fence_put(ring->vmid_wait);
 	ring->vmid_wait = NULL;
 	ring->me = 0;
-
-	ring->adev->rings[ring->idx] = NULL;
 }
 
 /**
-- 
2.51.0

