Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AF1C0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:53:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399E410E917;
	Thu, 30 Jan 2025 09:53:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NkxpLAyM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B46ED10E917
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RK/SQsgcQEOsDZnas1wScgEDkb5Pi1ql6B+spD9sEtbFuXbsCmYQOaQq5tBcZ0tdSy+LRsycKAn3ZXrrf47vNPHFrp5KaX7s+0A+o1l4sCz/gauKfCaFU5mzurC9DEAkfkeY5wZpUvWOjGihfwGeQ6/hxglanrRXDZLeX8yYm8Js9WMPtEpVRWwdSLV9kg8wl95v8JZlwzz8q0Ate8KeTjjybSg2q+9sMnxuBV5MjuR9tnxRQn4Mj7AtEGkrZHCvjeedVE4A91V6Ydu735Phbv33daByfX/7JpeIyqqzNbhYGhiMBs6/gMvVkGwZqfwQV7JHERN8JZm0gnWYIXmPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fec26q5epUYHRRH69V9TSi2sZxMHdQyZJNvM1BJSp34=;
 b=Wss3GMmUCADaBPbJyKYPmUqZhg+N00GFgYKxuuir5zawBymtJ1/egSEdIo7nk5A6aJ6ryDUse1u9Rx1ss9gkstpRLOm/cLNdKTT1c+TLGCifXXvUEF2SoALmyu9iR3j0UrA2xVGquJKCqewRfvQQ2q2qUFUjsz5zXuvx4UsIGFCAhu2isEeh8VupskqKBLlhhoyrPTN5gPrSdjZLXVTs/JMW1O3tLfMi9Q0mgu3OTEvp86gcDip8uLIGZ3LBn6XDQ7x94F9+hRMpy4ybHyqljuGzpfZtlwNNX3LNCOy8JmZ3JrlNm0ykSO8B947p6eJNmRQoPxy4plEBJgwverp0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fec26q5epUYHRRH69V9TSi2sZxMHdQyZJNvM1BJSp34=;
 b=NkxpLAyMLUme4+1oD2Ej3F0ufAnrvFtXe3KDZXqMzTuDJZ6ul5mCZbDdOqnVJGOHsCMhq8LbImstPiWCfvEb8YGpSTR2RudBgxNoETvLZ5TTauUFOHsJByzdbr/RXU+gWMgZZKiSvGebuO6az+cjFKYVK9Op07o2vVSm6UMJfmE=
Received: from MW4PR03CA0309.namprd03.prod.outlook.com (2603:10b6:303:dd::14)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:53:46 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::59) by MW4PR03CA0309.outlook.office365.com
 (2603:10b6:303:dd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Thu,
 30 Jan 2025 09:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:53:46 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:53:43 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 08/10] drm/amdgpu: Enable devcoredump for JPEG2_0_0
Date: Thu, 30 Jan 2025 15:21:11 +0530
Message-ID: <20250130095113.534630-9-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c3bbf2-0aa4-4ebe-0289-08dd4113fd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1RldCtvYldTSzlDejA0VTZicXZ0NDJrRnhyVGlhU2dOdGhicVAyZ2lNNFh2?=
 =?utf-8?B?b3h1NVllamtMeHdxL0RqNFA2bUJlTTU1cCtQa2Q1b2I1cmNIS0hDZGNoQ3No?=
 =?utf-8?B?aUtSUmExM1FheDBsY3ZMZWF6WXpVT21QNzlISkFMcjVRTWxSQi9XYkQ1SURr?=
 =?utf-8?B?ZVYrS1ozcEpKRkhPd1g1bWRjRGdRRFJ0SmJWOHIrSkpCLzRKVjgvaDhmc0Fw?=
 =?utf-8?B?b1praXB4MGdTaXh3aTBpMThqWEphY2ZQZ3Q4UEkyYjZKN0RtandhNEthQnRj?=
 =?utf-8?B?MmpQQnI4em42cFZ2ZTY5YWt5YWxFRHZGRm9LNTh5c1JXeWdueWxFSHpmaVZF?=
 =?utf-8?B?cnlXbjlzd2tKL0FOYk5mTlU2UTMvVnlGVjN1MFNjOGV0ZlBhalZRYXpUdnpK?=
 =?utf-8?B?anBBRGVSSWJRbk1YU1RMTU5aVkdtaXZ4Y3lxLzF0TVYzeWZXRFR6Zjc1eU8z?=
 =?utf-8?B?b3IzelJqNkVQK0JoVmlzL3VpZlFqWFZPakoranVnZCtoL0RsMTZzQkJYN2k4?=
 =?utf-8?B?WjE5KzR3bVpjWkw0Rm1razRKVkFiZlJ1elpqOUNidlltelo2a2liMjBCODhD?=
 =?utf-8?B?RDI1ZlZaNGNMSys3R04wWWlZNWprQUdLOEJyNzlDYjE1QXJobXBiNkQxZFRI?=
 =?utf-8?B?RUhEVHU0dTAxcTQrbStxbHZJdk9tenREQnFSMVNiSW1KZTZWTm9LR1BkTklR?=
 =?utf-8?B?VGNrK1FNNHU2MHJnSnh6NDRXOGRjcnpWeTlmVkJJK0NUOTFUdDZjWjdoVzht?=
 =?utf-8?B?SmNRYkRsNnozZE1QVkFWa3QzTzFBbXBSczhlV1piTDF6bkZYak9td2dieGZT?=
 =?utf-8?B?MENBZlRSbFZiRFZLYjZ4NU9xbUNvWW9ESk9neHJaRXdDa1JEUTF6c21qR2tM?=
 =?utf-8?B?cE1WdHN0cTFxZlFNVVpSdkVTRjNFU3VzaElBeVhOQWc4M0llTWI4Y05XeUpD?=
 =?utf-8?B?Z1VZcFlZMXgxREFMblZ0RFhMVTh0aHhhWWdUYU9TejRtc2QzQ0VHR1puRkdq?=
 =?utf-8?B?NlQxZUhxNE9XMnNJZDAzZ2FjbXBuUmlVSG43RUlRZFJGalZ4N1h0dTBZTzZP?=
 =?utf-8?B?U1FqZVhCdzd2dmR0NHA1VnpwLzZEbzRkUzcvSWJlcUQ2RTF2aTFOY21pWVdT?=
 =?utf-8?B?a2RwdFVwYS9lWHlXSHdoeVRIek9uZ3g2bjB4RU15UUhvKy9wTTBFbFpWUlNM?=
 =?utf-8?B?Z0Vzdi9MUkZUMDlpK2xjZFN2VkZBcUR5MzVzVlk4UFRHSmJMZUtVdG1UQVh1?=
 =?utf-8?B?RVFIMjMvaUNlaXFJNVpMalFpV1QxTHE2UFYvVSsvb216T1V2NWNjdnJtV2hS?=
 =?utf-8?B?S1EzblVQcU0wMzBHNWFKV2RRVEgwVlY0Q2NXMXdwR1FTK2xRTjQ2RVFkeFB1?=
 =?utf-8?B?c0VLZkJuQU1TQUt4bDdGRkY1QXpGa3BpMlF5VStXdHpIQ3ZUZjZ6amI4MEFE?=
 =?utf-8?B?NEdtNWJ3TnRLaCs0VHNiK29vdUhhUG5SN2xsVTRWMlozaWpwWWZQYTRuUkl0?=
 =?utf-8?B?MGNWQ1BDYWx6TURZa3lZOWRYMit1Smx6bGVhV0lYdFRNTi9abVVPaHpNZkpi?=
 =?utf-8?B?QXpFS2FmQTB6cGp0eC9USTdzbEJhcnhNSkdEWnc1RTNnUEE4cmt3K093RFQ1?=
 =?utf-8?B?d05NbUhHVFV5Vk5OZllaNE5hYkNoZTEveGIwSWE3NlhiUVdkb3B2L2JjYVNq?=
 =?utf-8?B?OFNrREVYK09LZWlwSzhjRnBhNW9JMFgwSjhreWIyUjBYRGxWZExNbnVrWDM1?=
 =?utf-8?B?S2hVV2RTQVdUZFVUNXJGSEtNSVpnRVZYUHRuclNyYzdKWE1FMFVpNnhBSi9k?=
 =?utf-8?B?MzZnbE9zM1FqUmJUdVl3RDh3VEVYamRwY0l2S21oeVRGSXJKbHV4RmhpWUxJ?=
 =?utf-8?B?NlIvWDlXZ01NazBLVU5CamZRaldGNzV6YXg5NXVob09RSkZ0M0x2b3dPZDNX?=
 =?utf-8?B?T2M2YVh1VHNHVlh0a0VMdnZWWXBvdzFDTjBwYnVRSU9xaWkxcFowSTRvU1Vi?=
 =?utf-8?B?QkVrNUQxT2NnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:53:46.3013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c3bbf2-0aa4-4ebe-0289-08dd4113fd32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
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

Add register list and enable devcoredump for JPEG2_0_0

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

V3: (Lijo)
- move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 7c9251c03815..8c61081746c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -33,6 +33,22 @@
 #include "vcn/vcn_2_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_2_0[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, mmUVD_JPEG_UV_PITCH),
+};
+
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -98,6 +114,10 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_2_0, ARRAY_SIZE(jpeg_reg_list_2_0));
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -752,6 +772,8 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.wait_for_idle = jpeg_v2_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_0_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
-- 
2.25.1

