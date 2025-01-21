Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27207C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 07:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C653110E163;
	Tue, 21 Jan 2025 07:19:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E/Gr3JCQ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9949210E163
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 07:19:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJdqfPUwGWC74H03bYAzenB/ntXW+nc7ktZFe5uxgN8MEPhSH3lqrTXwMvKkQwif8fBSYmARB4pXIL8KcK9PAqDdFaQVpHNO5G59V76PpON8e/oXatKB+jtn+benu5PO5IDdxLpTycKTQ5W0QzxuWt5Mz/XutPMnEblohXK1dQrroqakryggBnpIHA5ZmIevRgLbODDMK6IzljKEshEoyKQJndPI3nTgN2fai6H8oME5ONAtbngj9FqD2cm7jA+DTWxmLrTfaUPEQU4+0UcRJ7KLA7PaGGczno/IIT7cAh1mepuDMN0uMs+Rr0OPaUMcnpF0DOnSbo0YxHRwATAelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPnhojZLHBxDF+Itpp9AY/HmGseGWOOH84bTEnwYdAA=;
 b=Dn7SY6Mt/QbK7yKvTdFv+Ck/nIpJ0MLic1J8/+rWM/ldfP4Q7vfFqvI460/3M0qN8jAHC6VqAm0keO2zwu0VNrEh+DwqK9BQblvP9mNkrq1vdrTJb6bdC2ozJz/Quo7H1bnrLyLZMnVQ/OfL4UvfdKxCSrK42QNgGAm22XVfD/xPGoy2K+3+XaUWDIAp/qZdFu1AJ2+hUGT9/3pdNDt3ZS2tZiP+rTgA1P8AW+k4E0Kkbdnw+71n0yyIc/UvMK0avIYaxI0AViVzy01j8FMB5MJjNzPPqYgLdZGEVfshr1TPx6oxluu1ljydWk4ZPhSfedbwo7juMtUorehlQjbkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPnhojZLHBxDF+Itpp9AY/HmGseGWOOH84bTEnwYdAA=;
 b=E/Gr3JCQzAr141Mm9NE/GYz1mG1VIHwjbwboo8Oqg3TjkmFYup4D77T/Cd105QWf6ddC9oWSuMrASIA+buhKYw9Md3ZCIBd2QXPHEgCmQxcoFWutTjXNH8fo+7YRGHNtwR3yfomlYLgSbruufoHU2J+PYkDTK6OyI/IpZ/ORc6w=
Received: from MN0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::34)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 07:18:59 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52a:cafe::ab) by MN0P221CA0014.outlook.office365.com
 (2603:10b6:208:52a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Tue,
 21 Jan 2025 07:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Tue, 21 Jan 2025 07:18:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 Jan 2025 01:18:56 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: Add cleaner shader for GFX10.1.10
Date: Tue, 21 Jan 2025 12:48:40 +0530
Message-ID: <20250121071840.1846105-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: cccf474e-e399-4bc4-1d8c-08dd39ebdfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmlQQXFDOXBqaEMzNjJnWEU1T0FrN1BYcngwdUs4d1dyN0hyVTNKWW1IVzdV?=
 =?utf-8?B?VC8wb0dxNm1YN2xOcGtRMnBuOHZQNHRXRXlsM1BZK1FxeVdBZXVKb0orUnpC?=
 =?utf-8?B?WkhhTHdEejRkWnVITVhXNzhNaEE3NHM2OFlaQlBkbG83NGpnU3J4dUFXeGNN?=
 =?utf-8?B?cERTRGQxeEhCUitzcVVIbGpsallBQkJOSzFVdk01SXZzZHFxT0Y2U0h5MVp2?=
 =?utf-8?B?SVlINWFPTFY3WFRldGNHUkNCZlhsWklaVEpQZDNGaVdlSDZxeGZTY0MyeGJM?=
 =?utf-8?B?ZkFndG5QcncvNjFiNU5LNGJReXJjUmQxRGY1QnQvRHhITFUzeU5HTzBYcjhS?=
 =?utf-8?B?MmdkdjllZjVPM0I0aG92Mm1iK0h6R0hIc3k2amJXMGFTWkFEdUw2Q3VRVWJp?=
 =?utf-8?B?aTNHTjFINWxTemZPcWRIZ3BsUVljNUlqRFRFT0piTnVnN2ZwbXF5R2o5cGoy?=
 =?utf-8?B?SGtoNVNTakg4bHBUaTVjUThlczR1NmhBdnVHVjB3K29FLytDS00rdGY3T0lE?=
 =?utf-8?B?L1RDb3A1RXFNY1MyTmFLZ3FjS2Uxekt5bDJaSHlEbkQ0eEgrTGVwNll5Qkhq?=
 =?utf-8?B?ZlJGcUl3SEJRNTdrWG12RXZ5ZE1pVS9NeDBrUi9IZFNza21IZjRZUFdLZ25K?=
 =?utf-8?B?ekJMQXhmejJDS01tWHVNNE81Zm5pVDlXYVNJT3RnMW1qV0Vqd05GWHIzeUZL?=
 =?utf-8?B?K0J4dk1xZUM0VHkxMjhKZ3E0UG8yME5CRjhaWHp2MXRZT0xXRk9nK2F2RnJW?=
 =?utf-8?B?NGFOUWU4SmsxSDMxYStaZi9TU0J0a3RhUlJMWDh4RVA4N3VjdWNPUzlVSzA2?=
 =?utf-8?B?K2VoZHhZSU5FSUJRb2pGYmh4emJVQlBoczV3MzRENHhhNUxLMXI5c3F6d1RX?=
 =?utf-8?B?Z3EzeTBsRGxJQVhwd1o1ZTMvSGRvbVI3TkVKMGlhQ1p6RC83YnhBc3R6ekdp?=
 =?utf-8?B?cndUZm9WL0FyeFdvaE1wWFBxS000Q1BPZXNsbHVTeGVNTjlSeVpFeGxUTFBJ?=
 =?utf-8?B?STZQbjVOOXlvaTlGU1RHaUEvc0k3TVNEN3FITkl5ZHk3TXMxTk9OT2RxVlBv?=
 =?utf-8?B?Z3hiN1RaS21NL0VuRytqT2daTC9FVDFjTnhnSFVSa004SXZKSzlvMnZTVVFK?=
 =?utf-8?B?US9RVmFXbmlOYkVmdDduODNUMW92aUxUSmd6c05SQUJKTUtJazdkaGhDa0Fz?=
 =?utf-8?B?Z3dib1RmUThjaG8xTXFhZjZPTHQxQ09rVnFjWm9hRFMrN1pyalhJVDFIU0ZM?=
 =?utf-8?B?OHppdmpEK3VjRGhKdVNkQ2hLL0lORTAvK0hubUVZbzFVQW56dytOVWFESzZZ?=
 =?utf-8?B?Wk1LU1MrOEcwRTFINVZhN1B6MnZHcE1FMmF5NlNyTHU0bnVtVTRWS3dQNUVL?=
 =?utf-8?B?dnFnRGxZZVltaTdUeGE0eEoyWjV6WDZRdk1DeUlSaUlNbmFyRnFKUCs3bHEz?=
 =?utf-8?B?VXdnWDQyaWQ2M2pLWmFmMTZkcUxIMGhONHdOWFhBZFlMK3g0UTB1Y3RIOFhh?=
 =?utf-8?B?d3Y0dHNhVFNQTVdzbFBTMitTNVRSQlVlcmpnZWJxUHdTUWJBQmZRWHFHOTF6?=
 =?utf-8?B?c09vcUdZMkRiRmFKODM5Y3BJRndFU1FzZCtKTWdZQW4zS21xcnVIdkZ0b0Ey?=
 =?utf-8?B?MXdIcldZS0g2bWgwSGZ6NFp6djU2Q0h5RTk4aHNzUWJmMUdvVHJ2Ui8veGZ2?=
 =?utf-8?B?V0ZjRGh2eFcvdUl6T0M2R2JobkRGMkR3R3B2RHV3NEtzLzVtNlM2bGtZTXlM?=
 =?utf-8?B?YWxYV3U2eGhWL2pUTVY4SVZ6NUcxSmI0TGZwREJibjF0UjhnVWs2YTdJRGFU?=
 =?utf-8?B?RGpSOFI2bmdpYlpjTWIza2tWNENldG5RV2hMUjlza1BzUGQrQ3FjZnkzZ1Fz?=
 =?utf-8?B?KzNhOGpUTnQ4Vld1YVVDWVZZVTBkUzNCZ0xGMXdjeWxUVGtiWktGRGNiWHB3?=
 =?utf-8?B?Yncrd0lDOEdULzdsVjRYeG84cVdKWjdWamJkQUNmOFc5ekIvQnY0blRvSU5D?=
 =?utf-8?Q?aGYzkyx45JQE9cqwtef0ClBO+ydjLc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 07:18:58.8615 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cccf474e-e399-4bc4-1d8c-08dd39ebdfad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828
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

This commit adds the cleaner shader microcode for GFX10.1.0 GPUs. The
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
(`gfx_10_1_0_cleaner_shader_hex`). This array is the binary
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  14 ++
 .../drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h |  35 +++++
 .../amdgpu/gfx_v10_1_10_cleaner_shader.asm    | 126 ++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4b5e65affb81..1878c83ff7e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4794,6 +4794,20 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		break;
 	}
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(10, 1, 10):
+		adev->gfx.cleaner_shader_ptr = gfx_10_1_10_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_10_1_10_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version >= 101 &&
+		    adev->gfx.pfp_fw_version  >= 158 &&
+		    adev->gfx.mec_fw_version >= 152) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 2):
 	case IP_VERSION(10, 3, 4):
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
index 663c2572d440..5255378af53c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
@@ -21,6 +21,41 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+/* Define the cleaner shader gfx_10_1_10 */
+static const u32 gfx_10_1_10_cleaner_shader_hex[] = {
+	0xb0804004, 0xbf8a0000,
+	0xbf068100, 0xbf840023,
+	0xbe8203b8, 0xbefc0380,
+	0x7e008480, 0x7e028480,
+	0x7e048480, 0x7e068480,
+	0x7e088480, 0x7e0a8480,
+	0x7e0c8480, 0x7e0e8480,
+	0xbefc0302, 0x80828802,
+	0xbf84fff5, 0xbe8203ff,
+	0x80000000, 0x87020102,
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
+
 /* Define the cleaner shader gfx_10_3_0 */
 static const u32 gfx_10_3_0_cleaner_shader_hex[] = {
 	0xb0804004, 0xbf8a0000,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
new file mode 100644
index 000000000000..ab223fca14f3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or 256 bytes of 256 Dwords cleaner shader.
+
+// GFX10.1 : Clear SGPRs, VGPRs and LDS
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
+  asic(GFX10.1.10)
+  type(CS)
+  wave_size(32)
+// Note: original source code from Brian (SQ team)
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
+  s_cmp_eq_u32 s0, 1                                // Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_0
+  s_cbranch_scc0  label_0023                        // Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s0 == 1)
+
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
+  s_mov_b64 vcc, 0          //clear vcc
+  //s_setreg_imm32_b32 hw_reg_shader_flat_scratch_lo, 0   //clear  flat scratch lo SGPR
+  //s_setreg_imm32_b32 hw_reg_shader_flat_scratch_hi, 0    //clear  flat scratch hi SGPR
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

