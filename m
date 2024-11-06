Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00682D3E783
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 02:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2D210E661;
	Wed,  6 Nov 2024 02:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W3wZECC9";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E90210E664
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 02:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Okz7d6M1+KfxbRffjuciPNSwkZpGDtCHg1dUohl8cJOc1mUGkBKqQM1zQL6U/wrEK3VVj86uNEzjP9QQmk9jfBfMGngZyppvR4na71Q4whBRQzTMWLcrq19uY08YXBk6Lyn2Cb/4KegNMW8+OvQVdoZbaKlvi0hC1/ZRuYltjBvZUU/TYAfIFtAxBq4+CNJHDcEeJ5P7SxiJXBSLQtJxJFo45cNzi9uTCHvfVDmY0XHadYeZWG0ivz8r4a2DQ2pdZvfGb8h4yF8p2KM1zGQCm8oyBeImZ/gCgW7KAVXxohUmfHbuyPOwMLsbcIK2F5Ze0e/CrMDrx1NNUGecvSrP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzHXaH7Ghty5/gHlTp6qwaN4GnBku+NeN01tKW0nekw=;
 b=HoRxxHdTgCinpUXSMGf7pk8bUGSAtY2KbDu9zwUBOuq/TgfC8FU2t3Zw55DslMcMrXS7ozu5dpDxeJTIqAZ5FQ/nxQQwoxd6l1kKJMRJRoIlN5SHvXZXKytDZFxTWI8FBl1mY8Z0zWfoA61y7ADgxIqbViM1VQB5EkKq+JfWif8wMVo5yhTYN3wYkhBRK3LJwSiPXh7VI7BtG8mqmAkwt6mwTIrsOqUQAZw0P13vG3xFVNNzRtXc+smUKtipmcBgNHVAEVGZz+3XVcInzos7lceBlEdi+cN/wDATDAif5LUYJ4O6psrinh7IJ+v2SGwIkyqlx2k9VFmnMQhsknHEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzHXaH7Ghty5/gHlTp6qwaN4GnBku+NeN01tKW0nekw=;
 b=W3wZECC9OfIMfbvE2sS7ZUGKCgYOuQUIgOCLFArbfSOmlwOzsW72Pdm7+1gWttCplm9WWtzKPBx8MiFj0CjTbNdC9CDcRu2NKxZApSMQk5TQriiJ5rE0dHcIbAcEKWa8/AXB76dsmNduTzUg3zWGOLkn0fWHSNYNeDFItuMNiBU=
Received: from SJ0PR05CA0134.namprd05.prod.outlook.com (2603:10b6:a03:33d::19)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 02:19:13 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::97) by SJ0PR05CA0134.outlook.office365.com
 (2603:10b6:a03:33d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.14 via Frontend
 Transport; Wed, 6 Nov 2024 02:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 02:19:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 20:19:09 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: Add cleaner shader for GFX10.3.0
Date: Wed, 6 Nov 2024 07:49:00 +0530
Message-ID: <20241106021900.4104215-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: ffeb9560-9733-401f-5e75-08dcfe096856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3FpMi85RFJ1Zk1pMlNJSEN0cm9HUG82MExBRjdXUExlM1czUm9Sc29vcUNG?=
 =?utf-8?B?NC94anM2dlluQXVXTGZ4eW9lQVRMN2ZqeXRhRFJKYklaREZUNE9BZUtQcWJw?=
 =?utf-8?B?Ukc2b28wVGJnRzgvUVpQckExektSbzBRKzJkZDhtQ295MFdDdDhtVVlmWFBw?=
 =?utf-8?B?b21lWk9uZWtjZjU2Y1EwOEg1d1lac09BQ0YvT3NTNFVOdnphODdzalQxamJW?=
 =?utf-8?B?ckZsR1g3U21OYUVmNmpKTzBhNFN3MDNZbkdFeXJaUkQ5UnRhcWVwKy9YakhT?=
 =?utf-8?B?NVFFWEl6Y0JTN2pJeExnYWhWcXFBRk5PYWVBRGE0RS9Mc1Njc09NVVNhdE91?=
 =?utf-8?B?a3BvdEk5MmU2cFVqc2VoV0NrODFod3hmQUhWeUxkdUs5Wkx5ZTE0dlpxZlZz?=
 =?utf-8?B?dlFXczYxMklUbGhjRkF4OU5ZcENRdUVyNXlCbzFQQS92TDNPb0hHV2dPYTln?=
 =?utf-8?B?NENMK3Q5SG5qR3JZNk5nN2d1RXdpYVpQWDhrdmN5VFo0MG4wTUtQS29MU0w2?=
 =?utf-8?B?bzJ6U0NDQkthYTRQZmowMG9UR3JGYklFdlJvYWFwS081SmpFcWYyYktDdS9y?=
 =?utf-8?B?VHpIK3lrakVTc3lPRUN3M1RVcmw4amJnOTliRlN1a1QxdEZvNWMzMmFXSU9n?=
 =?utf-8?B?a1J3aDhuTE1xWlMzZURHcG9ndVhrOHBlZnBNZG1JellQT0xVaFlwZ0p0VjhY?=
 =?utf-8?B?Y0paQldZenJtQ2tkNkd5NHlrZDlXblRjSGJZTStIYjJxUkJwQ1ZEYkM2eDZn?=
 =?utf-8?B?VWNMbk9xd2hxZE4wVWlvL0hCdi8vK0ErMHVlUk0waW1GNzkvUlFvYi95bmdD?=
 =?utf-8?B?Rm80aU1mVEJCOVRrbzhQOFlVSlA0ZGM2T1QvOGY2Njhya0NvYkl3SzUzNmNj?=
 =?utf-8?B?aHRGSXp3bGl2aUdZR1FwaThzdkZIcGJuV2F3N041elZ2MTFFYm9aTkNQL1oz?=
 =?utf-8?B?ZUJQdFp5OFpyYzFDaEdRY1p5Q3YxR0VUZVh3VWtnS0xHVXd6N3dLYVNmY1Vk?=
 =?utf-8?B?TXRMMzFhWE55T0tSR0kvY0VURStQMk5ydlMyamNkQ0l0S2cweTczeXJTeTBx?=
 =?utf-8?B?TDhFNXdWOFZxU2cvcUlGblBVenN4TlkwRmpNMUdIbDgzdncwN2RhbDZyeENY?=
 =?utf-8?B?SlJoZGFscDlQdXk2QWRtNFY0UXVaREhiNDE4eUc0R25EbmhNTzVlN2QxTzBU?=
 =?utf-8?B?a2YrQkNCOFBVcnZmcHUvMjZsMlIzOElPTFkzWlVYTlNOVVV6TC9RTFVHOHYy?=
 =?utf-8?B?OUVUL3JYYWd4L205LzdwanN6U1dGM2NrZW5yR0JUV3dJUFpVT0FMWGthd2hG?=
 =?utf-8?B?QTdPK0x0TlRINnJENEV6NDY0b2ZuMFNHQ0FiQmY1c0d5NTlLYWxhUWQ3ZWla?=
 =?utf-8?B?d2haSTBtb3RqRkxvSCtBUDduMFJzb29FOVFwY3JyWFd1cnhncWhBOHdIZ2Fr?=
 =?utf-8?B?Z0d3bHoxTTI5ZFBMY1U5TDh1NmJsUmZmNDBPUFQxeUFPS2FJZXoyZHVRNlh5?=
 =?utf-8?B?Wkl2bnFObXRaV3pVYnBXMFo2V2J1N2x2Vk15QTBuR1ZGVEFuYnpvTVhNRVQr?=
 =?utf-8?B?S1FyUWF3b3hPTlg3RVlzczJJZ2VZTElEcjN6NjNDSS9oUFZESWh5anFwQ1Vp?=
 =?utf-8?B?WnJ5ZnA1d25nVk5URUZaci81WmVQa3dFamwwQjY0cEJZM2sxQk9jbmJRbVJH?=
 =?utf-8?B?V2pSVDluUXdDbTdKald5SGVEQVBrbktDTW5BOFVkaE8ra2tXU2p1V2ZqS0pn?=
 =?utf-8?B?bXRLU2U1NGwxSlk2Qk9wa2J1c1RLd3Vta2ZUUkZTQTVtem9YSGtobnZqYXhE?=
 =?utf-8?B?MXFVbnI5UmtzaEgrSktiby9DQjNueStMdTFGaHlpZnVOTVhxMFNvb1h3Nnpi?=
 =?utf-8?B?WXZhbnEycXVja1JmcFYwUG4zR0lTY29rbXpsU2FjNmhJL0E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 02:19:13.6856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffeb9560-9733-401f-5e75-08dcfe096856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385
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

This commit adds the cleaner shader microcode for GFX10.3.0 GPUs. The
cleaner shader is a piece of GPU code that is used to clear or
initialize certain GPU resources, such as Local Data Share (LDS), Vector
General Purpose Registers (VGPRs), and Scalar General Purpose Registers
(SGPRs).

Clearing these resources is important for ensuring data isolation
between different workloads running on the GPU. Without the cleaner
shader, residual data from a previous workload could potentially be
accessed by a subsequent workload, leading to data leaks and incorrect
computation results.

The cleaner shader microcode is represented as an array of 32-bit words
(`gfx_10_3_0_cleaner_shader_hex`). This array is the binary
representation of the cleaner shader code, which is written in a
low-level GPU instruction set.

When the cleaner shader feature is enabled, the AMDGPU driver loads this
array into a specific location in the GPU memory. The GPU then reads
this memory location to fetch and execute the cleaner shader
instructions.

The cleaner shader is executed automatically by the GPU at the end of
each workload, before the next workload starts. This ensures that all
GPU resources are in a clean state before the start of each workload.

This addition is part of the cleaner shader feature implementation. The
cleaner shader feature helps resource utilization by cleaning up GPU
resources after they are used. It also enhances security and reliability
by preventing data leaks between workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  15 +++
 .../drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h |  56 ++++++++
 .../amd/amdgpu/gfx_v10_3_0_cleaner_shader.asm | 124 ++++++++++++++++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_3_0_cleaner_shader.asm

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4607d5c071ce..4f1cc61f9c43 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -45,6 +45,7 @@
 #include "clearstate_gfx10.h"
 #include "v10_structs.h"
 #include "gfx_v10_0.h"
+#include "gfx_v10_0_cleaner_shader.h"
 #include "nbio_v2_3.h"
 
 /*
@@ -4733,6 +4734,20 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(10, 3, 0):
+		adev->gfx.cleaner_shader_ptr = gfx_10_3_0_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_10_3_0_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version >= 64 &&
+		    adev->gfx.pfp_fw_version >= 100 &&
+		    adev->gfx.mec_fw_version >= 122) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
new file mode 100644
index 000000000000..bc8417063af9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/* Define the cleaner shader gfx_10_3_0 */
+static const u32 gfx_10_3_0_cleaner_shader_hex[] = {
+	0xb0804004, 0xbf8a0000,
+	0xbe8203b8, 0xbefc0380,
+	0x7e008480, 0x7e028480,
+	0x7e048480, 0x7e068480,
+	0x7e088480, 0x7e0a8480,
+	0x7e0c8480, 0x7e0e8480,
+	0xbefc0302, 0x80828802,
+	0xbf84fff5, 0xbe8203ff,
+	0x80000000, 0x87020002,
+	0xbf840012, 0xbefe03c1,
+	0xbeff03c1, 0xd7650001,
+	0x0001007f, 0xd7660001,
+	0x0002027e, 0x16020288,
+	0xbe8203bf, 0xbefc03c1,
+	0xd9382000, 0x00020201,
+	0xd9386040, 0x00040401,
+	0xd70f6a01, 0x000202ff,
+	0x00000400, 0x80828102,
+	0xbf84fff7, 0xbefc03ff,
+	0x00000068, 0xbe803080,
+	0xbe813080, 0xbe823080,
+	0xbe833080, 0x80fc847c,
+	0xbf84fffa, 0xbeea0480,
+	0xbeec0480, 0xbeee0480,
+	0xbef00480, 0xbef20480,
+	0xbef40480, 0xbef60480,
+	0xbef80480, 0xbefa0480,
+	0xbf810000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+	0xbf9f0000, 0xbf9f0000,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_3_0_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v10_3_0_cleaner_shader.asm
new file mode 100644
index 000000000000..83c7be34515d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_3_0_cleaner_shader.asm
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2024 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or 256 bytes of 192 Dwords cleaner shader.
+//To turn this shader program on for complitaion change this to main and lower shader main to main_1
+
+// Navi2 : Clear SGPRs, VGPRs and LDS
+//   Launch 32 waves per CU (16 per SIMD) as a workgroup (threadgroup) to fill every wave slot
+//   Waves are "wave32" and have 64 VGPRs each, which uses all 1024 VGPRs per SIMD
+//   Waves are launched in "CU" mode, and the workgroup shares 64KB of LDS (half of the WGP's LDS)
+//      It takes 2 workgroups to use all of LDS: one on each CU of the WGP
+//   Each wave clears SGPRs 0 - 107
+//   Each wave clears VGPRs 0 - 63
+//   The first wave of the workgroup clears its 64KB of LDS
+//   The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
+//       before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
+
+
+shader main
+  asic(GFX10)
+  type(CS)
+  wave_size(32)
+// Note: original source code from SQ team
+
+//
+// Create 32 waves in a threadgroup (CS waves)
+// Each allocates 64 VGPRs
+// The workgroup allocates all of LDS (64kbytes)
+//
+// Takes about 2500 clocks to run.
+//   (theorhetical fastest = 1024clks vgpr + 640lds = 1660 clks)
+//
+  S_BARRIER
+  s_mov_b32     s2, 0x00000038  // Loop 64/8=8 times  (loop unrolled for performance)
+  s_mov_b32     m0, 0
+  //
+  // CLEAR VGPRs
+  //
+label_0005:
+  v_movreld_b32     v0, 0
+  v_movreld_b32     v1, 0
+  v_movreld_b32     v2, 0
+  v_movreld_b32     v3, 0
+  v_movreld_b32     v4, 0
+  v_movreld_b32     v5, 0
+  v_movreld_b32     v6, 0
+  v_movreld_b32     v7, 0
+  s_mov_b32         m0, s2
+  s_sub_u32     s2, s2, 8
+  s_cbranch_scc0  label_0005
+  //
+  s_mov_b32     s2, 0x80000000                     // Bit31 is first_wave
+  s_and_b32     s2, s2, s0                                  // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
+  s_cbranch_scc0  label_0023                         // Clean LDS if its first wave of ThreadGroup/WorkGroup
+  // CLEAR LDS
+  //
+  s_mov_b32 exec_lo, 0xffffffff
+  s_mov_b32 exec_hi, 0xffffffff
+  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0..63)
+  v_mbcnt_hi_u32_b32  v1, exec_lo, v1        // Set V1 to thread-ID (0..63)
+  v_mul_u32_u24  v1, 0x00000008, v1          // * 8, so each thread is a double-dword address (8byte)
+  s_mov_b32     s2, 0x00000003f                    // 64 loop iterations
+  s_mov_b32     m0, 0xffffffff
+  // Clear all of LDS space
+  // Each FirstWave of WorkGroup clears 64kbyte block
+
+label_001F:
+  ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
+  ds_write2_b64  v1, v[4:5], v[4:5] offset0:64 offset1:96
+  v_add_co_u32     v1, vcc, 0x00000400, v1
+  s_sub_u32     s2, s2, 1
+  s_cbranch_scc0  label_001F
+
+  //
+  // CLEAR SGPRs
+  //
+label_0023:
+  s_mov_b32     m0, 0x00000068  // Loop 108/4=27 times  (loop unrolled for performance)
+label_sgpr_loop:
+  s_movreld_b32     s0, 0
+  s_movreld_b32     s1, 0
+  s_movreld_b32     s2, 0
+  s_movreld_b32     s3, 0
+  s_sub_u32         m0, m0, 4
+  s_cbranch_scc0  label_sgpr_loop
+
+  //clear vcc
+  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR
+  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR
+  s_mov_b64 vcc, 0          //clear vcc
+  s_mov_b64 ttmp0, 0        //Clear ttmp0 and ttmp1
+  s_mov_b64 ttmp2, 0        //Clear ttmp2 and ttmp3
+  s_mov_b64 ttmp4, 0        //Clear ttmp4 and ttmp5
+  s_mov_b64 ttmp6, 0        //Clear ttmp6 and ttmp7
+  s_mov_b64 ttmp8, 0        //Clear ttmp8 and ttmp9
+  s_mov_b64 ttmp10, 0       //Clear ttmp10 and ttmp11
+  s_mov_b64 ttmp12, 0       //Clear ttmp12 and ttmp13
+  s_mov_b64 ttmp14, 0       //Clear ttmp14 and ttmp15
+
+ s_endpgm
+
+end
+
+
-- 
2.34.1

