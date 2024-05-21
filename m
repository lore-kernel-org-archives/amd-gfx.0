Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E4EC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 04:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEFB10E340;
	Tue, 21 May 2024 04:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yj+NvX1s";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F37C10E340
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 04:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/+f9PeiTFi3z797l1h8jmqjjQ2LtCUucnqwdrwKQAs6OU/0ssaOxXLoiSB3EQR26LHHRayscw5xUvtW4bu5kh9eY4MsRu5LhRuJSlXc8NIrjRkkIq6fx+Q8pN2MhrvDiDa3+Qm+DlylmCgu8a8lZk/mzG8yCsJO5kJOvn78zFPUqvCS387TMrL9KjkGqFoLBLAWZB/ocrEzQ4FXDVFuXvpexYEL17mxRgEr5JSTqNRaKfMdgLelt+Nc8aw2u2Lmkdze48vZ3rrMPaz20BqCJ03b7tAbHaYyyYujbs6t3H2bTqHpza03zz3JzJRHxkFgE2e9SzXuvffzmWJ2NfOALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Urnrfdh61b5VBjoz8n0lyL6lZy2mmClyD+WjYrRTo3o=;
 b=EpJ8bssc9MWWs3EzguGmanRllQXqAA8RDyhwjWNu78AuQzSMqPHrH5AovVrKbtYwzKNpTvSrFZdtfBJb9VmjDxc7ijMaNcNjxMk4iQqesWhH6bOvMu2iMokd3IHsyeRvukGaYyhDJ4lBZOhymb0QrXHXONmBQoQSQndlHfKOAfv4AOm8iErpmPpevbQTc3W5KrcYcKNrt6NpknuvMTo3Ro/coUrQe4dOR/6mwCGYQoXarMdaLF+ITS7dqbxoGf3SX8SaAPFKSxS+QGzxgxjbtY96vt9phMX/AB60tlz2R3zplpUFVRvbRjmGJxZwwnMQqgs7hoini1X3lJ335u7xGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Urnrfdh61b5VBjoz8n0lyL6lZy2mmClyD+WjYrRTo3o=;
 b=yj+NvX1spEGq0hReEMRMWktVmjnvIyno+aDRbd1M3HgfUWECLLCMIwIAUmbarJUmssW2SA9RRHHNsj7RxbznqUDCPhgC1NTsb8GtAc01Ehw1CY03p91x3Hv69aQxv7ixr9wAXYISuJUjYU00pmO2qfLGY5tlZbvR9f+XoD/LNVs=
Received: from PH7PR17CA0070.namprd17.prod.outlook.com (2603:10b6:510:325::10)
 by SJ2PR12MB8830.namprd12.prod.outlook.com (2603:10b6:a03:4d0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 04:43:47 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::f9) by PH7PR17CA0070.outlook.office365.com
 (2603:10b6:510:325::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Tue, 21 May 2024 04:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Tue, 21 May 2024 04:43:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 20 May 2024 23:43:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Fix snprintf usage in amdgpu_gfx_kiq_init_ring
Date: Tue, 21 May 2024 10:13:31 +0530
Message-ID: <20240521044331.3735728-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ2PR12MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fadad0-b051-45b4-dde9-08dc79509a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K21QaVpPZUY0djBCQTI4MTVMMnlPbGQ5OWRpMWozTGdiUkdNMGFyOW9ybGFj?=
 =?utf-8?B?ZTM5U1BrZlFBTWNIVmhCbDlFY0lKekwzbWY3T3hFUGNQbkRGakNrNFNwdnpC?=
 =?utf-8?B?OSsva241Y1BHNHNuaTgxcGtMOVVGcDNDampOYy9SUXJOMW1CT3FHcnNybm5K?=
 =?utf-8?B?SmtlSFFvWmNZcWdBY0U1T1crQlFub2gwd04rTVc5ckZOVGhrYUZ6N2lVZ3dU?=
 =?utf-8?B?WHVtZU54NjRFNFZZYkY1MmNtT0xlRmRRd2NOblFHTmNOT3o0anhkM053L2E2?=
 =?utf-8?B?MGMreGxyRzVwWlNXSTJraTNjb2VSNWRaR1VBWDJjdGJkT2VEdFMwcGRmNUdQ?=
 =?utf-8?B?WlE4ckx4VlV3M0dEemRtM0pLOTQ2MjRZZytOUjlPY1hpRG53Z2svVkxXdHV2?=
 =?utf-8?B?SmpTak5qbUJXNkdlaW5BZ25hRDVJTytUb0hwTVBnRGMxUitYNG8veGpuNGlu?=
 =?utf-8?B?TEYzQXpXV1l5QSt1YkI5ZUVvQ1RRUzRZaHZNYThDdDBPdGJNOTFKMm9sNHdV?=
 =?utf-8?B?czI2MmFPUy9uMFI5eVdGM0g4VDMwVU1IczlLRUxVZHA5RE5La2ZRb3ljWG9K?=
 =?utf-8?B?UjAyVHlqMEd1U3hDTTRCUlFQbFBVT25ERUF5c3lBRHhrK2huR0VGc0ZjaVlO?=
 =?utf-8?B?YitWRGpnOXJSUVFRb3p6aEhqNVBJQUZXNm5GU1ppemNQcjJyQ0NPTE1OcCtJ?=
 =?utf-8?B?UTlUcVA5aEhYNDg1Tk45cFk2WkpTNFJwT0ZvVUw3UnZPa1BybHNtM0pITXcx?=
 =?utf-8?B?UlJhTzV0VEt2TFVCdHMrTFM0bkpEOExQTTVNdEtpTmd0TTBZc2NjUHFscWJa?=
 =?utf-8?B?VC9ubmh3aVpqczJIMUVjaU5sdVEyMFdST2FNNVZXY2JvT1Rjd2VROGkyelB2?=
 =?utf-8?B?YmgwaGlvS2hIcHFWQkEzdjJxaUFhc3ZRWjJrUGFBdUFHdjlCQVQ2NkRjVFcx?=
 =?utf-8?B?MlRhUTFHcnloWEZPaWZHQktQbHdxaEZ4RFFoTGViTERiczRTV2FUZ0wxVkpO?=
 =?utf-8?B?V05ROFJFWlFpaFRZZnpIWmVvR3I5akhkOVU2UTBnMU55VGxUMXgzUGNYdTVY?=
 =?utf-8?B?SjN6WE8xbnIvTFRXUVRhTE5SZmJ5dUkwQmFoTDg5Z3c5UlY5THg4QTJTRjBy?=
 =?utf-8?B?Nmx5TjgrY0FucURVZk1LK1dJems5bkNBMnRTZHkrb2ROQitNak5zQlZjRWw4?=
 =?utf-8?B?Z3ZUMlhML1c3UEFoTjJZVlc2TVJjNEZRTXMvOWR6bGxmK0lNb2hWbldSeDYx?=
 =?utf-8?B?c2doTjdQRVhYVFNtZVg5S1EyTUo4aTgwYndKRUpQVkhXWHluNXlsbytPeTZj?=
 =?utf-8?B?NEhzUHVrdlZGVkhNM2lHMXpFVWtZRWZjR1JpOGFVZ2V2Sy92cDQwYUdqUVpH?=
 =?utf-8?B?WUpRSmdaek1ibERYUkhNbXBxZW1sc3Q4b2RUejB1aWJ3OHJLU1lkbzU1ckZC?=
 =?utf-8?B?M2pKb3pXZ3NkQ2t5SHZOTjZYK0Y1TWt1UTQ2TnVYcGxLQWw0N1VvYU5zallC?=
 =?utf-8?B?Yk9McWNreTJyV0xXU2tKeFN0amRiRFVWWDh0R00zRisxOVdTRmhud2doSXdD?=
 =?utf-8?B?UTlVQkUrNVVxdGJtbUhHSHFVQktzUGVtaFgwSWxxTmN1RHB6aTVLOFZmNTZw?=
 =?utf-8?B?ZmtqS3JBM1o2bzQ3d1lLMGo3N1FVOXY0VGplYUU2TUlrZ01FRTFhMEJ6YkQ3?=
 =?utf-8?B?T21UaG0vZHM5TExNZFN6eGlhQkJ4anMrWTU0K1NIVnh1UXpXcXlKUzBQTlZ5?=
 =?utf-8?B?RWkrdDRSQmRsS0pSeXRUdXNvMjF4SXNxWks1WXFNRXNHUmM2Tnd4d3hVRG5X?=
 =?utf-8?B?bUJyNUxNUHB4c0pMekR6ZkFJb0pIdmZaMzVZRFRiRnBFMjY1aDB4Tm1pN2NQ?=
 =?utf-8?Q?alC2nkhvdNQdT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 04:43:47.4706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fadad0-b051-45b4-dde9-08dc79509a72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8830
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

To resolve this, the snprintf line was modified to use the '%3d' and
'%1hhd' format specifiers. The '%3d' specifier is used for xcc_id and
ensures that it is always printed with a width of 3 characters. The
'%1hhd' specifier is used for ring->me, ring->pipe, and ring->queue, and
ensures that these values are printed as single digit numbers. This is
achieved by casting these values to unsigned char before passing them to
snprintf, which ensures that these values will always be in the range of
0 to 9.

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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9b7dc61c331d..88da17c0340b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -329,8 +329,9 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *adev, int xcc_id)
 
 	ring->eop_gpu_addr = kiq->eop_gpu_addr;
 	ring->no_scheduler = true;
-	snprintf(ring->name, sizeof(ring->name), "kiq_%d.%d.%d.%d",
-		 xcc_id, ring->me, ring->pipe, ring->queue);
+	snprintf(ring->name, sizeof(ring->name), "kiq_%3d.%1hhd.%1hhd.%1hhd",
+		 xcc_id, (unsigned char)ring->me, (unsigned char)ring->pipe,
+		 (unsigned char)ring->queue);
 	r = amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_DRIVER0,
 			     AMDGPU_RING_PRIO_DEFAULT, NULL);
 	if (r)
-- 
2.34.1

