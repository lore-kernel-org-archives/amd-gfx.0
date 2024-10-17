Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEC7D2F7EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 06:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E79F10E7A2;
	Thu, 17 Oct 2024 06:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXAa3XbQ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD68110E7A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 06:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEW0A6XMjkwFXhzIevQWx6sEdMhHUiOekoB9PpxhoENQCrZ+7YIDK/y/bzUVksrLowYO8f+P7++NFqf+8COWX0VGnK3clvRjzlyhZkhQJur7gP9BCsHyvhPSn77YTLVedsVt/Zp2jnohn+F5X14EeKZTQg8ZRT8s/IuJsndlfNHme7HZUMQR9DYZGy3rig0pmHM6Ab5LE+SDBFuZk0CVanl0FZGiHQ0ehuRDL2g6DZoLJtim+wV8PKW4p+2v2lAbg5TC0RJXSpr0KwCMggCGP66fY9jep/skFUutt2GdBtJDq3LZtsZibU4QPbbJOQ/Y++jjRlgKNU2/5JUytr8kdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fvs11EUnyGpF8qw7CL1c3LeYehX/NvpF7vuPSm4Wey8=;
 b=Wq0UM+x66bKyZdZb4pq4xREPmMwHb4RbAmmfY/5d2L2/V6cjry4bS0Y3OGnSkDRO2JbfXthYuY/fHpL/UZDQYwqoh7+fJm9idWN5cFz2nsoUnm56N8I6zJYy8L+Vt235Cn4uFPuvqxTqdkKRPEe5aEwW8qEQAKfhBlfVDIPiPIhbP0zmVWUuSRyEXUxOotrV4lyGT1UsiDSxqkgAQwYwgWf21hpraA9H1SnpivD7WPKQilmXz1+sI8Iu6FGJbfl9uKx268L4Xy8rWUOmlz6mmoJFCZ52PCI3tNIFvalEVzqzu+glgavIHmUMxR/lfylotDjr03A7wa/deyVuoslfng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fvs11EUnyGpF8qw7CL1c3LeYehX/NvpF7vuPSm4Wey8=;
 b=LXAa3XbQtAio+fRoAgwirmBjK3u8B1lGvLW5hcqiX/xyqq/ERhSs5ggCw19atAWu1thfXOHBoOsA9I3C2wmX+1sgCgndTSH0HZwFOR2JXmKHATiVgsa1P1wo83rRTWC1UtCBSAFG3870BDn9qXgcCX8mAzb/y90Ps/kZAnBmlwU=
Received: from CH0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:610:cd::13)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 06:49:31 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::ad) by CH0PR03CA0098.outlook.office365.com
 (2603:10b6:610:cd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 06:49:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 06:49:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 01:49:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.2
Date: Thu, 17 Oct 2024 12:19:04 +0530
Message-ID: <20241017064904.3500946-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017064904.3500946-1-srinivasan.shanmugam@amd.com>
References: <20241017064904.3500946-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 006057fd-f207-46b4-8bc1-08dcee77da25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE41Vi96YzlQenpwU3BnQjhYNGJNTC91OXJwSzJYbU1RSXIxazMvcm9xaU4w?=
 =?utf-8?B?cTloRVJENzJTZElrNmJkSE5yOXJDandmc0xKdGlDZzY1NUNuN0xndGMwdWVS?=
 =?utf-8?B?bk5FVjQ1TE1OcWxPMWVxaDFQTStIYTAwSkQ4dlNrT3FhSlBnU3Z2ZVRiU3JV?=
 =?utf-8?B?SWNLeWVVUkI2dEprTTVQSmxEMldnWlBOK1BjalU4SHNjSk9zcWt3c0xybEIr?=
 =?utf-8?B?SUQvQmEyVWNYeXV5WnQyRW9ieTU2cjBabFdvU2hPd01OQjJWT2hOSXR4N0dp?=
 =?utf-8?B?TWRBSUpmTDdoS1pWTWNFUXRlZEhWcEhSbWtRRlF1MzR0VnRmTmxOd2NoWVlF?=
 =?utf-8?B?eE1vcERnMGJJTThJdWV5SG9jWUJUUlhYMGg4aW5Ub2NrY0d2aS95Z3U5NkdX?=
 =?utf-8?B?a1NnY2dNaVdLaXc3eEVZbmNUWEdRNVVwMFZSbEVTbVcrNlRzOXYwNXBUNU9Z?=
 =?utf-8?B?V3dUS2g1OEFSV1BkeUNISGxNOU5mcHRQN2dvWUprbm5CWk9QeG16ckFVQmVS?=
 =?utf-8?B?NmsxcVM1RVZXbWo3cHVjeENPbW4ydElUTmtLVStCVjBYc0NPVnFNL04vUmVK?=
 =?utf-8?B?dzZ2SHRydmZETXZvMXA4VmVuVVRDU2Nac3c0bW1hTnlNZitEbUZ4bms2eWxj?=
 =?utf-8?B?REZWOFZvcUROUHBLbk1BaThRc3E2ajMvVytlODhoZGFPOUV5UWVTSmNYRHJ0?=
 =?utf-8?B?ZDlncHptM3hOdkIzUUl2VlhsOGNKTG9sL2QvZWQ0bE1RRU83cE1mZllULzYy?=
 =?utf-8?B?YStpQ1ptNXpvVU9ZdjVtNVFBUUNOSFV5TExXVlBkdm8vZ2lUMndIaUhsT0Zo?=
 =?utf-8?B?K2RsdXZZQ1BVSHRPeTBxVEsycGN5UkpGTysrdmJYSzVRYVlXZmxoSng3ZEpQ?=
 =?utf-8?B?MmFkOVcycE1ZcEcxU24wZC93MWdwZzI4SlVtSFVxL1pVUU95bVNKZWNxNkpk?=
 =?utf-8?B?MGpJMGtYU0g1a1YxWTlxYmtOV2J3dVhvS2xTclhvMndPRHEwcEIzNnVTNy84?=
 =?utf-8?B?TUJMZy9XYnlTTm9xOUhWNEFnV0FDaUlBd0RLUkZuTlVQSUZrcC9pMUQyUldn?=
 =?utf-8?B?NGZkcnBEZnFIZDdOVzI1UmtEVDg3TEpONnFMNE9lWE1keTNRWmR0aUtuc3VX?=
 =?utf-8?B?c3d6UjdBT3hLdkpITFl5TkcreDRRSWtnYW1SRDJGUktRQXdRd2dnWkx5dmhZ?=
 =?utf-8?B?QlRIRzU3R1lTam5NR0J3andLeDllSVhNTnpNeUhxaDVFbmFVaG1OcVdjZzlZ?=
 =?utf-8?B?elUyNEFwREgyeTBOdXQ5cDhkNmtOTVl1WTFrUkN3UDVuZUNtZ1BnN2RaL1NW?=
 =?utf-8?B?QlBVVnpxOXkyM3A5bDF6TmpTL2d2MFdqWnVkQkhVSG16UWZEWFprSFNpWnVE?=
 =?utf-8?B?VWdxY21XcklXdG91KzJrWGx1U3UrZHZ3eDBUK3ZsSDcySis1UHpKdi96eHdU?=
 =?utf-8?B?SDg0cXZlMS9lNWxpVXIvMW4yTGdYR0I4aUxTMEwwRDJMb2JaSDl3eWNuVUJr?=
 =?utf-8?B?Q1pyQTVGeW4zZHJwVGJIMTZYMUNCTGlRNzhYRmpFNWlNL3VQZkxrdzdINGJl?=
 =?utf-8?B?cEVPMVc5OFh2eXZSTDlmNHBjaWlxRjc3ZXJvN283R3hCRkNLdkRkUUtZUWcx?=
 =?utf-8?B?K0RURUprOURBTkFjbWptUW5mWVpQajRkaGNkei93enh5dTZ0N2J4cnhTUU5G?=
 =?utf-8?B?bG4zVFlBQzR2QkZoZlhKYVpnNkdDUjJBUUZkZzJsQjVPSThWUTMwbTZWVzdS?=
 =?utf-8?B?VjVPSmE1bjRabloxQ1hnTHRDZVNpVmsyYXBqT1l4cXI5Umg1Z1c5YkNYT0hU?=
 =?utf-8?B?QWZMRkxOTXlmejFIKzQvZVBRQUpJOWErOGMvSWhsVXRCSGl0RnhBOEJtMHJn?=
 =?utf-8?B?VENSeGhTR0htV3hmQnRhdlA2V3lRckwyZlNTKytWODcxSGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:49:30.7399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006057fd-f207-46b4-8bc1-08dcee77da25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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

This commit adds the cleaner shader microcode for GFX9.4.2 GPUs. The
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
(`gfx_9_4_2_cleaner_shader_hex`). This array is the binary
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
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h  |  41 ++++-
 .../amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm  | 153 ++++++++++++++++++
 2 files changed, 192 insertions(+), 2 deletions(-)
 create mode 100755 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
index cfb73e729b0a..0b6bd09b7529 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
@@ -26,6 +26,43 @@ static const u32 __maybe_unused gfx_9_0_cleaner_shader_hex[] = {
 };
 
 /* Define the cleaner shader gfx_9_4_2 */
-static const u32 __maybe_unused gfx_9_4_2_cleaner_shader_hex[] = {
-	/* Add the cleaner shader code here */
+static const u32 gfx_9_4_2_cleaner_shader_hex[] = {
+	0xbf068100, 0xbf84003b,
+	0xbf8a0000, 0xb07c0000,
+	0xbe8200ff, 0x00000078,
+	0xbf110802, 0x7e000280,
+	0x7e020280, 0x7e040280,
+	0x7e060280, 0x7e080280,
+	0x7e0a0280, 0x7e0c0280,
+	0x7e0e0280, 0x80828802,
+	0xbe803202, 0xbf84fff5,
+	0xbf9c0000, 0xbe8200ff,
+	0x80000000, 0x86020102,
+	0xbf840011, 0xbefe00c1,
+	0xbeff00c1, 0xd28c0001,
+	0x0001007f, 0xd28d0001,
+	0x0002027e, 0x10020288,
+	0xbe8200bf, 0xbefc00c1,
+	0xd89c2000, 0x00020201,
+	0xd89c6040, 0x00040401,
+	0x320202ff, 0x00000400,
+	0x80828102, 0xbf84fff8,
+	0xbefc00ff, 0x0000005c,
+	0xbf800000, 0xbe802c80,
+	0xbe812c80, 0xbe822c80,
+	0xbe832c80, 0x80fc847c,
+	0xbf84fffa, 0xbee60080,
+	0xbee70080, 0xbeea0180,
+	0xbeec0180, 0xbeee0180,
+	0xbef00180, 0xbef20180,
+	0xbef40180, 0xbef60180,
+	0xbef80180, 0xbefa0180,
+	0xbf810000, 0xbf8d0001,
+	0xbefc00ff, 0x0000005c,
+	0xbf800000, 0xbe802c80,
+	0xbe812c80, 0xbe822c80,
+	0xbe832c80, 0x80fc847c,
+	0xbf84fffa, 0xbee60080,
+	0xbee70080, 0xbeea01ff,
+	0x000000ee, 0xbf810000,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm
new file mode 100755
index 000000000000..fdee6b7e3f32
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2_cleaner_shader.asm
@@ -0,0 +1,153 @@
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
+// MI200 : Clear SGPRs, VGPRs and LDS
+//   Uses two kernels launched separately:
+//   1. Clean VGPRs, LDS, and lower SGPRs
+//        Launches one workgroup per CU, each workgroup with 4x wave64 per SIMD in the CU
+//        Waves are "wave64" and have 128 VGPRs each, which uses all 512 VGPRs per SIMD
+//        Waves in the workgroup share the 64KB of LDS
+//        Each wave clears SGPRs 0 - 95. Because there are 4 waves/SIMD, this is physical SGPRs 0-383
+//        Each wave clears 128 VGPRs, so all 512 in the SIMD
+//        The first wave of the workgroup clears its 64KB of LDS
+//        The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
+//          before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
+//    2. Clean remaining SGPRs
+//        Launches a workgroup with 24 waves per workgroup, yielding 6 waves per SIMD in each CU
+//        Waves are allocating 96 SGPRs
+//          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent these waves from allocating SGPRs 0-223.
+//          As such, these 6 waves per SIMD are allocated physical SGPRs 224-799
+//        Barriers do not work for >16 waves per workgroup, so we cannot start with S_BARRIER
+//          Instead, the shader starts with an S_SETHALT 1. Once all waves are launched CP will send unhalt command
+//        The shader then clears all SGPRs allocated to it, cleaning out physical SGPRs 224-799
+ 
+shader main
+  asic(MI200)
+  type(CS)
+  wave_size(64)
+// Note: original source code from Brian (SQ team)
+
+//   (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 2176 clks)
+
+  s_cmp_eq_u32 s0, 1                                // Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3
+  s_cbranch_scc0  label_0023                        // Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s3 == 1)
+  S_BARRIER
+
+  s_movk_i32    m0, 0x0000
+  s_mov_b32     s2, 0x00000078  // Loop 128/8=16 times  (loop unrolled for performance)
+  //
+  // CLEAR VGPRs
+  //
+  s_set_gpr_idx_on  s2, 0x8    // enable Dest VGPR indexing
+label_0005:
+  v_mov_b32     v0, 0
+  v_mov_b32     v1, 0
+  v_mov_b32     v2, 0
+  v_mov_b32     v3, 0
+  v_mov_b32     v4, 0
+  v_mov_b32     v5, 0
+  v_mov_b32     v6, 0
+  v_mov_b32     v7, 0
+  s_sub_u32     s2, s2, 8
+  s_set_gpr_idx_idx  s2
+  s_cbranch_scc0  label_0005
+  s_set_gpr_idx_off
+ 
+  //
+  //
+ 
+  s_mov_b32     s2, 0x80000000                      // Bit31 is first_wave
+  s_and_b32     s2, s2, s1                          // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
+  s_cbranch_scc0  label_clean_sgpr_1                // Clean LDS if its first wave of ThreadGroup/WorkGroup
+  // CLEAR LDS
+  //
+  s_mov_b32 exec_lo, 0xffffffff
+  s_mov_b32 exec_hi, 0xffffffff
+  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0..63)
+  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         // Set V1 to thread-ID (0..63)
+  v_mul_u32_u24  v1, 0x00000008, v1           // * 8, so each thread is a double-dword address (8byte)
+  s_mov_b32     s2, 0x00000003f               // 64 loop iteraions
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
+  //
+  // CLEAR SGPRs
+  //
+label_clean_sgpr_1:
+  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop unrolled for performance)
+  s_nop 0
+label_sgpr_loop:
+  s_movreld_b32     s0, 0
+  s_movreld_b32     s1, 0
+  s_movreld_b32     s2, 0
+  s_movreld_b32     s3, 0
+  s_sub_u32         m0, m0, 4
+  s_cbranch_scc0  label_sgpr_loop
+ 
+  //clear vcc, flat scratch
+  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR 
+  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR 
+  s_mov_b64 vcc, 0               //clear vcc
+  s_mov_b64 ttmp0, 0             //Clear ttmp0 and ttmp1 
+  s_mov_b64 ttmp2, 0             //Clear ttmp2 and ttmp3 
+  s_mov_b64 ttmp4, 0             //Clear ttmp4 and ttmp5 
+  s_mov_b64 ttmp6, 0             //Clear ttmp6 and ttmp7 
+  s_mov_b64 ttmp8, 0             //Clear ttmp8 and ttmp9 
+  s_mov_b64 ttmp10, 0            //Clear ttmp10 and ttmp11 
+  s_mov_b64 ttmp12, 0            //Clear ttmp12 and ttmp13 
+  s_mov_b64 ttmp14, 0            //Clear ttmp14 and ttmp15 
+s_endpgm
+
+label_0023:
+
+  s_sethalt 1
+
+  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop unrolled for performance)
+  s_nop 0
+label_sgpr_loop1:
+
+  s_movreld_b32     s0, 0
+  s_movreld_b32     s1, 0
+  s_movreld_b32     s2, 0
+  s_movreld_b32     s3, 0
+  s_sub_u32         m0, m0, 4
+  s_cbranch_scc0  label_sgpr_loop1
+ 
+  //clear vcc, flat scratch
+  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR 
+  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR 
+  s_mov_b64 vcc, 0xee            //clear vcc
+
+s_endpgm
+end  
+  
-- 
2.34.1

