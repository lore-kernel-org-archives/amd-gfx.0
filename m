Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E73C18E7C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 16:52:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D2110E963;
	Wed, 26 Feb 2025 16:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t0wKlFG9";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1AB10E967
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 16:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+yEZNEV4nDOKVlB1FoEyD2jQQRDfAloF6mmpusZxNQ8dTQI4twDxGPRFMqUaNJvfVmjeRU128hIf4q6PgAI97LBr9Jfan3ErLI2PpUmXxDfAPkpbC/P7qM0SCgFNi5VKMb1mA3FBbstftt35IgyA+ihfXlykMIViXtAaf7YBxfdWkalaG3rCjtBP/nZullbPFE4lhf5gGYB56JdX5qvFL/dz1VO1THCJ4VuHOhDdji4bfMcWgdKjf6MzshpF/nLu/Frfs+M3K+JeVHgyWy8fV7BAsu1qiVjfNBwdxQKALHh2l5kitYF61TcHnGUfAjd9oksGql4n0q5LGRCkkrcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijDpEoa2oO575/wDuAE0NgdkGXLnwPPJzA8TmRG/dkw=;
 b=A6yy0wCe9LJRznsGyRz+6bbzSV8ILg++jIIoatO0Wcv3ey+0xO3tIpwgPE7WWDqPUESB42oQfXV9W6FloFzjYCR9qji5rmfMGClV44HN7QW0xHiVyjw8v7GdcpPk3zoQ5/Qhb5QvuuHcF4E1BKtMMRz2U/YiNngydv86eatrn3Syo5XScRHcIu6DMR5RHtxYRjRGBoT1FzxBS41IdkdMMdM6Hx/nD/YJ8A4t5zAzaSwpDRwmPBhQYTKc6fTeXNf1srqP48tweetdcG60i3ol4XrI3htyRXZoXi4SPw2BXvNzP0QJ5eSHxZt4k3CLCF159yuHEtgaI16rS18ehiMeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijDpEoa2oO575/wDuAE0NgdkGXLnwPPJzA8TmRG/dkw=;
 b=t0wKlFG92/xN8jZZ6FJ1wE5xKxQxT5ZzsD7o94njHN7r+2N2yoFesjFWSMKzsHbHq3wjOyRaX/kabJYChck6jjmvvCEUflltyS5CjzwEP3jeSvKpfkbI5YgVXTdKKHlgQuxzJHJVR96afpmU29Oe+P6gd0nv7kNlQeqWCYxqCX0=
Received: from BL1P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::17)
 by SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 16:52:01 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::17) by BL1P222CA0012.outlook.office365.com
 (2603:10b6:208:2c7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 16:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 16:51:58 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Feb 2025 10:51:57 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Fix core reset sequence for JPEG5_0_1
Date: Wed, 26 Feb 2025 22:20:49 +0530
Message-ID: <20250226165049.3152280-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226165049.3152280-1-sathishkumar.sundararaju@amd.com>
References: <20250226165049.3152280-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SJ0PR12MB6760:EE_
X-MS-Office365-Filtering-Correlation-Id: 72330cdd-9d7d-41f3-d0ff-08dd5685e27f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVFNMlU5VVN1NjhRK1B1S0s1Y3BhcFZEVUM2cVBTMUp3WlZtM3dBMGtDV3Nv?=
 =?utf-8?B?cVpURkpESlBhU2ZPZmJrMnczRlBzTUx0ZTNVeDFTamxGVS93MU9nYjB5T0lp?=
 =?utf-8?B?MzhUd012RjRsNlB3bElYaDhGS1VubmliWnl4N3laMWVzRm4yRU8vdzhBQWpl?=
 =?utf-8?B?UWx1QjNOeHhFWERTY2kxbWx2aTBERzQycTlUam82T3luTHYyQVBuN2dyZDls?=
 =?utf-8?B?VnZmdGJrL1N1V1NtSzdoTGJKY044ZGovckUxQ2xPZzBNZ2FvRk1Cb25kUEc5?=
 =?utf-8?B?cWVPOEdETHM2ZVlWMjJFWU5hNFJaaXhJYk1IRjhHcmhNak5ESiszQmM4a1Y4?=
 =?utf-8?B?T3dNYXZaS3NCc2lhSDlhQ0ZIZm4rNWd0c0FXVGw5eW9ib1M3V0FDVVB4bG10?=
 =?utf-8?B?ZUdUOSs4L08wb3loNXRPWE83R3pGcGpuSzhFeHhVVXZNeHR4RnNoeU5Jbnpk?=
 =?utf-8?B?SStIL1ZFb1BZeU5MRUw2alVLL3pwUko4bVdWSU9ZL0c5eXJ4VEl2bHllV1RU?=
 =?utf-8?B?RlJEb0lPNFNjNSs5cmpkNWJnd1JYeGttMVMybDZwaGNDTmkvNG5rZFg0am1u?=
 =?utf-8?B?SjJhbEtaODcwNnZEWTl3cGI1VTdHTm9nZW13U2lhcjJKeFdkTjNuMHg4MlY1?=
 =?utf-8?B?TXA5bGdZTy9uNkdqaHdrSUZ1VnNUUGZRdkVmOHE3MVJrTFMrc2VsNDlpTzRz?=
 =?utf-8?B?ckFKdXNmeG5lSFQwOGhDMHNBK0lMVm5RZmhmT05TazR2MjY5ZG9IQjJjTjJT?=
 =?utf-8?B?N25jMlVUcHR6TFNpdUVsVXU1Nzg2R2R1OFNWYklseUExRDNMc3hqb2VhM3B6?=
 =?utf-8?B?eC9DRGRCbVErcnIwd1RkNDQ0WXBvNzdacmMrVWxXd3V5T2JkNlRLamdPWTU4?=
 =?utf-8?B?R1plZzhCOWNFTkZKZk5tUFVXeURwbGNFQkpqcTB4VDkrZkVFaUoyMVdsOGd5?=
 =?utf-8?B?aFdCaXdvZjNMTjVLdm4rMEo5Z1A0QkNQdFcxRjZCOUcrYkNtRGVjeTl4MHRm?=
 =?utf-8?B?NWFCc2Uwb3ppUFNKbGNmSjQwaGFWNTJqc2RKa2ZMMmtsVWIvd1FQSWMzOFJK?=
 =?utf-8?B?STNFc1RNelRJa1hhdng4Rm5jZEQwRXI3WUdSN2N0dE5oQjZ5d2NoVnNjREll?=
 =?utf-8?B?TFVpOTJBVFVSTTJMUHBVYUQwZGh4RTVMa25qaHo1YnpmSlRVazdpVkEzbUdm?=
 =?utf-8?B?aWVJVHdndG96amhpK1ozTE1xV09sNWh6M0NWNzRsTTRwd2ZFSHN3clZmeVFC?=
 =?utf-8?B?YS85QXczTm1Dc2plM2RsamVXS1Z6Q0VWYi8xWGxBeUwyREZodHBidXlEMXJR?=
 =?utf-8?B?MGo0WEl6RUpIYlB2OWJkc3Z1d1JZblFWQk1udnZKOG1aOExZUWxib2dPTFpX?=
 =?utf-8?B?QUlmVGJtdXlTZUZ4VmVTVW1oUEhMTHprRHc2Q3JwcWIyVEZxSzBLMlRkaTFQ?=
 =?utf-8?B?RjV2WktyRmlhTjRSVTBndHFPVTI4cnI2dDdpS0lhRWxTRGNEQ1F3dmh5cnJv?=
 =?utf-8?B?VkN3RkQwTnIzMm1hYTB5THk5cFFza3JCaktreUJYY0kvWFV5b0M4TnQ0OTRP?=
 =?utf-8?B?VjhIdnJwRGFtZ3hJVTliZUxUdXVHdDZXdE9KNzkvdDNYT2thRDlCc3B2cjA2?=
 =?utf-8?B?ZjYwUHMxZHZXRlMvSTF1MDVxRWVnSEdUVjJjcm9QZEhLWitCSkllREFsTXFw?=
 =?utf-8?B?TlFhWVEyTHVsK1dqYzl5Y1VLOHB1Mmc5WHNMYVQrd0ZVMjVnZVdXbGFGVFU2?=
 =?utf-8?B?MzdQeE1oeEdLWFc4d3BLSld0SEg0Wm0yaHFnSHl5VUxRcUZrUVJ5L1hzNXlm?=
 =?utf-8?B?NHEzK21qSHpveXcrOGtma0RFeTI5SDM3ZzdaTzVsSU9BUDJ6WWk3elIyelh6?=
 =?utf-8?B?MTJsbThBUjRUREQxaW5jbmRqeEtJSmc1NjFueGZCQTdGZ080UjVKREhkV1Iw?=
 =?utf-8?B?cnlDVUJ6UWNJM25xbUtyZ0g0dmRqaFlLTXBUakxCVTNKblNoeWJaWjBOUlpa?=
 =?utf-8?Q?0oLvfYdEZ/rPDczOzBfpZJ6j694Vhc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:51:58.6676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72330cdd-9d7d-41f3-d0ff-08dd5685e27f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6760
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

For cores 1 through 9 repair the core reset sequence by
adjusting offsets to access the expected registers.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 6b8ef8e8c0eb..220f3af01748 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -669,24 +669,20 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
 	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
 			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
 			    reg_offset, 0x1F);
-	SOC15_WAIT_ON_RREG(JPEG, jpeg_inst,
-			   regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS,
-			   0x1F, 0x1F);
+	SOC15_WAIT_ON_RREG_OFFSET(JPEG, jpeg_inst,
+				  regUVD_JMI0_UVD_JMI_CLIENT_CLEAN_STATUS,
+				  reg_offset, 0x1F, 0x1F);
 	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
 			    regUVD_JMI0_JPEG_LMI_DROP,
 			    reg_offset, 0x1F);
-	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-			    regJPEG_CORE_RST_CTRL,
-			    reg_offset, 1 << ring->pipe);
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 1 << ring->pipe);
 	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
 			    regUVD_JMI0_UVD_JMI_CLIENT_STALL,
 			    reg_offset, 0x00);
 	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
 			    regUVD_JMI0_JPEG_LMI_DROP,
 			    reg_offset, 0x00);
-	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-			    regJPEG_CORE_RST_CTRL,
-			    reg_offset, 0x00);
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
 }
 
 static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
-- 
2.25.1

