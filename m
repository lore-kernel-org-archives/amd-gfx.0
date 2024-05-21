Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FDBC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5682410E23A;
	Tue, 21 May 2024 07:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="118iKhU3";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE2E10E23A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJ+tafhu9fcfnJ7HYHabY6W1YyOFnxue91b7uW6/sVsRiH3VYkPeLmV9p/LqypsQICrv9nsxc/4DizbSSdHRnRyIAmFj/mfwkFBi18NMx2RjrG3L/4uGr2GKd7FtdDgypUIwnr6nl4UmthTT7oUPGcErn1q/laVpgh/434qe7BYS2jXfvISZt93XYuvVFuOGUrZMRZ/4B8lGGc9E1BIlVyWNTGwtkxXD/8h6a/QCet2SG0nxkhDh9vI5Z3PV50G6N59VhNi8mif0gwH8JQ8LZulwnI5JtjobWCDtZr4SCPwt8+yYkjp/ePx/pIWYjhOEoNj+bhBvrhvUCbIL/am6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pqdi4PQJUxrDxKq3AygR0BqagxjAWeZTD+bOQVMbOE=;
 b=Jo6wh7iQDVF5hSqAq/b0SDb9Q05IhvvmPe5dF9+bCGcAgQNt7TtvVgYQz7pDJHb+oQ75z9v5F7ndtbBWekEnn3mtTmv7yZYLAIDO9/dFS0h8BCgomNtT9lUf3A3g4sBN1U2x+1SflYPf5vxMsBb4pl2b/Y/JZEbpSaDMo36aXfPV7LhFL9qDdQy1k3NXTgQdx9ZxT/H90YF73Pc2OdQqsnFe46It1+zyKU7MAG/1wWL7Ge2+T0OGWnn3gHEuylW2j/L8o/s+hsMMlGp14PaTvo2LrBkeHmNmQaJR/Cz0aQi2Ud8dTDWbwIhqcOfBQ8y5T/j8Je3t6s2eTUFGgR24hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pqdi4PQJUxrDxKq3AygR0BqagxjAWeZTD+bOQVMbOE=;
 b=118iKhU3DM/eviegjohSgTR9TPS3cz6IlZu2Pyv/J46OWZJ7O4ibm3nW9R3qkgnKSsAbuywtDewI2ZWwylfy+5WwbWf0m7kb92z0AErbPFZzgslvhOkOnWR3P8CCy4kwWdnSiZ4k+jSRJpGcBqmEC42Fx81FuW5WMxn9trCclW8=
Received: from CH0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:76::21)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 07:37:28 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::8) by CH0PR04CA0016.outlook.office365.com
 (2603:10b6:610:76::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 07:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 07:37:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 May 2024 02:37:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix snprintf usage in amdgpu_gfx_kiq_init_ring
Date: Tue, 21 May 2024 13:07:07 +0530
Message-ID: <20240521073707.3863887-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521044331.3735728-1-srinivasan.shanmugam@amd.com>
References: <20240521044331.3735728-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: d2655f20-6d48-419c-6151-08dc7968ddc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWorVzkrT3Nmc24yaThyd2RqRTQxY0pPcHFUNU45a1krZEk4U2JBQ1dPbzRS?=
 =?utf-8?B?aEQ2eDl0akptTVlueVBHNVJCV0l4dU9TOVY0N1ViZEVpbFVHeXlPZnkvdkt6?=
 =?utf-8?B?aGNZVmoyQWZIRjlpYktZYVZtenFIanFVYnRYVTJwUFBmWjFocmpJWE9XYmdn?=
 =?utf-8?B?dForWWV6eHlJMXBIdWNSbkJ1N0FtWDJ5SEs0bHErWThZV1VtcWZaQlZkT3dE?=
 =?utf-8?B?VHdaSVhUczZjeDIxTVI1cWUxQlA0ZGI2ZmNjUFpGVHB6Z0xNTGw4V0hRNm50?=
 =?utf-8?B?aUJiSVJtanBxSDdqNFFzTjBveUdVdUZRU0RKUGJ3Y1lNRWdlTXVQZWJVRlA1?=
 =?utf-8?B?cDNYSzNrUS96bG1FNDQ3c2dVMndkdFNyeVNQRTE4dEpaVjJhQ1BiUE9FdlhV?=
 =?utf-8?B?elNzdDdSWGlyUGlrOEgwaUxpSVY0VmwrUHhUdUlnZEZnZElRQzlneEpmbFRT?=
 =?utf-8?B?VW1nWS9nODN5Q1JuSVFvK3o0cW9GNmlzVThUeW40Q2ZVaSs2bDJkWDVINCtl?=
 =?utf-8?B?ZU5IL1RCd2Z3V2hCempKZ0ExR0ttVWFLYTFIeUJNN3lCS3k5V0IxZDc0dVFN?=
 =?utf-8?B?ZDEzbTFhdmdveEhoMWhrU3ZFYmZHTFpJQlpycmJyVVk3VVBwSXpHQ2pObis0?=
 =?utf-8?B?UlhTU0ZIM21ZVm5JaFNYV2RlcDJMeVFvYndvd2dMZ3pNWXE0NG1FanlRRkpK?=
 =?utf-8?B?MXhybHVBZWh6YklWNWtkdk9CT3NHR0hyNmtVdmdnNndRazExbWw5VEZjWUEr?=
 =?utf-8?B?V1dhUFVVYVRLSTlibm9uZW1iTy9MemxWODYrekoxUzdxOEZ6elR6dGxVTmtM?=
 =?utf-8?B?ditnaDN1T09CZU1makFDcmlsamJsZEtnNDRFbmFBcmpvU1FqVGo0ZmZRL0Fa?=
 =?utf-8?B?NWIzM3N2NlVkM2JwTVZwOEx1NVZKQ3Bxem1kQXpWQi9hT1FhSDhBTDAwUlNw?=
 =?utf-8?B?dFdpK1kyWmJRV2ZrZm8vd0Q4RjY2K0FhKzJPdDdXVlRKR0dqL0lGWUhFM1hl?=
 =?utf-8?B?V3JQTE9EOE9WdTR5THZoTENiN3p1ckhnUzJoSnBpcS9xRUZuTlYyc3ZZWFBi?=
 =?utf-8?B?Qi9jMzBHRmJIU3VvYUk1QXcvb2drekJ0cWlaYjk1dXNzelE2Nkc4QzhrQUha?=
 =?utf-8?B?dThUY1pqelRZa0FQSGFwcndla2NqR3oxMzdwQkZWbUdJbFdGaGlJMkFIcHl0?=
 =?utf-8?B?SlZvZmFNSEdGUVRZTGVIQ04wbWd3WWpJNGc2SUU3Zy9hMDRrL3NubHpBNktV?=
 =?utf-8?B?NStzY3o2dzgrZ2RKaHc3VUVSNUIvcmJ1YUZTTHhwTlZTTlR6L3lybjFSa1Zr?=
 =?utf-8?B?Z05zNGlSQUVCZFBCZ0xpSldmN0pqTGw1YzhOQ0VzanlmQ0RlN1hzK2hEU1Yx?=
 =?utf-8?B?ZW5EaWwxVlp3N04wWGQvUTFnUUh6OTR1VmpQNnFvN1RSaWc1L0pRZDBmV2JU?=
 =?utf-8?B?ZU80MmNqa1J3dHo4U2k5dXB0K3BpVFJ3ZSt4WFdiTm1CbUZLVE8vS0lCYnFE?=
 =?utf-8?B?bHlJVGN3bE5MYW1rQ2NBZEVVOTU0MXlacXhqM1A2MG5JcS90eGZvR2ZJVEQ5?=
 =?utf-8?B?N0tnZVlSQllMb3VldGVtSmxDSUpDempQVVpPZVlJeGZqbXhsY1A3MElEbmdF?=
 =?utf-8?B?TFFnZVRkcS83OW1LOFpvVWc2b1J0b3Z4QkRhRDU1OFhlNGR0QThzVDdWUnJa?=
 =?utf-8?B?bUFEQVhXOGxTTkM5UGRNTTR5ZHNhZk83S1Y0RHdNTXVlVGhrbjFIY2V6SkdQ?=
 =?utf-8?B?blBwNDJCcXZKa2REcjRDYVRmOXJILzFFdVlXcmNsNGJqdUdvTWtoOEhPTWZ1?=
 =?utf-8?B?MkpPd0d2c3ZMZm9lNXdIZVhxVGZmWmZ0dnBqNWhXRlp5akFGWmxray9qeEdV?=
 =?utf-8?Q?CDkC8ul760e4U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 07:37:28.3533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2655f20-6d48-419c-6151-08dc7968ddc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

This commit fixes a format truncation issue arosed by the snprintf
function potentially writing more characters into the ring->name buffer
than it can hold, in the amdgpu_gfx_kiq_init_ring function 
  
The issue occurred because the '%d' format specifier could write between
1 and 10 bytes into a region of size between 0 and 8, depending on the
values of xcc_id, ring->me, ring->pipe, and ring->queue. The snprintf
function could output between 12 and 41 bytes into a destination of size
16, leading to potential truncation.  
  
To resolve this, the snprintf line was modified to use the '%hhu' format
specifier for ring->me, ring->pipe, and ring->queue. The '%hhu'
specifier is used for unsigned char variables and ensures that these
values are printed as unsigned decimal integers.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function ‘amdgpu_gfx_kiq_init_ring’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:332:61: warning: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size between 0 and 8 [-Wformat-truncation=]
  332 |         snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
      |                                                             ^~
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:332:50: note: directive argument in the range [0, 2147483647]
  332 |         snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
      |                                                  ^~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:332:9: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 16
  332 |         snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  333 |                  xcc_id, ring->me, ring->pipe, ring->queue);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 345a36c4f1ba ("drm/amdgpu: prefer snprintf over sprintf")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Removed width specifiers %3, %1, typecasting of unsigned char,
   s/hhd/hhu (Lijo)

 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9b7dc61c331d..0f14d4a11441 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -329,7 +329,7 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)
 
 	ring->eop_gpu_addr = kiq->eop_gpu_addr;
 	ring->no_scheduler = true;
-	snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
+	snprintf(ring->name, sizeof(ring->name), "kiq_%d.%hhu.%hhu.%hhu",
 		 xcc_id, ring->me, ring->pipe, ring->queue);
 	r = amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
-- 
2.34.1

