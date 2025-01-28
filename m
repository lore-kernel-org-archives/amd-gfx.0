Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB7DC0218D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CFC10E605;
	Tue, 28 Jan 2025 09:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NfSP6qUY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E666110E605
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydGyxOy5IEH0tnE9tKscSRX3lNAEy45fkUSrufblSKWC3vqCP9oMBWsnUo4kzBEN64PdzUZkrVs7C7ZCTpyiun1DuZc/MQpki2IuDNFuzMPgHGNBGEElYHqpvwv7xsVpsvJzTJIeZm+mt8v6LDgRu/up/m9SkbKxd/JxgDm2mDb6QxBn7X6qofAHsyio3SpUmtmA9z8i7ZjZZXmBAkgp634cxekXGGOqoq+dnn/0ChhYQ9LxjiPm8R2uxPK6L0zKOg6w7xsvIXcr3GidHxWcl3wYJuewOOPyg97pmSvSAeSuDU1Gwh5EumekSJstDye+KE8FcAvE8zLXqGh3RbT4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO9o7Id/xG494Yzk8oVqSObOhDar11bLJefTFBaHkZ0=;
 b=tKXkB9S2vvQTR4wL74HRBaQBRhaxFog+FVyrVismK2qGoopic7sqeGezBH5+DBWI8Tp0zDwnivTDwblAXUF7tGDpNCD/1G2qVQ7E6EhicQZUmOkYUFO9KP2IHvLzZ7sSBlAU8jBb86X7r0tYMFdssMYhcuc1514Bw2Cy1GnN+jwFcL53Zg6qSKo/wbT4Slx9A/eAszrVseLv1zQXMt4Hew6NNwq2lOshdl/NKwXby9OejzVMOKcRyBVMuTdW+rMhxY63xPhx5toWOjsuZzwJjJOG5N/mqj14pJ75a3lKW9hOx/t/94c+NBxScBl/BWosTyn52z6Qjoz9EFTdCvMqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO9o7Id/xG494Yzk8oVqSObOhDar11bLJefTFBaHkZ0=;
 b=NfSP6qUYSPtTOsACekfXMrHXRmar9sGh7fwD8bfj1xLduxXsLEQLfLOkG8JFMeFRkteQ7pHlJTfrJzpIV2oNlL08VG0Kr/nJ5iQ48W9QZetDWELzvWV0o+kZ6i6J1GGhkALovjBXlAvLONloi6ZQY3PK1utt/4HrXCOcoh51dD4=
Received: from DS7PR03CA0014.namprd03.prod.outlook.com (2603:10b6:5:3b8::19)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 09:11:44 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::d4) by DS7PR03CA0014.outlook.office365.com
 (2603:10b6:5:3b8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.23 via Frontend Transport; Tue,
 28 Jan 2025 09:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:11:44 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:11:42 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 5/9] drm/amdgpu: Enable devcoredump for JPEG4_0_0
Date: Tue, 28 Jan 2025 14:39:46 +0530
Message-ID: <20250128090950.461291-6-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
References: <20250128090950.461291-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: e890a791-bd97-4e4c-bc76-08dd3f7bc904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUNUdWg0VkhJdXlvWXUvMVdxMytmN0xXM1EvY09RNHg1VExOMnZxL1dwL0c4?=
 =?utf-8?B?THBITzdJT0pqS3JUUS85T0RUaG4rVkVVMUxJUlAyNXVBU05sa21kOEZsZGRE?=
 =?utf-8?B?NmtqZHFtbnFqbDlaNExQWU94YXk5WkduaGpvU1RKdjhpdE1FSUUrRCs2Uk1N?=
 =?utf-8?B?Tm02VkpoczIzMU5SYlpOZDkyaUl5Mk0vRVZyRlB3bk9idFhmVGhld2E1OTVy?=
 =?utf-8?B?dkU3b0ExT285NXJqbjFwN3NiMm5TZkJNV1NhbS9neEVDMGxobTRpUGY0R3Fv?=
 =?utf-8?B?VG5GaDVhMVN6TTZiZXgweXV4aWwwYmtDeHUzMWUrSFhmSkFuamcrM01hRXlL?=
 =?utf-8?B?anJhSUJKRWtXSUhIRzk3eFpTdGwwNmpteUFHOE92bFRRMm1aNUtRRjdPdEVz?=
 =?utf-8?B?MXg1LzJTSGNZU20wMnc0RHNEL2tMTkZjY2JlMkR0eVIzNHhLbnFKamFTNy9s?=
 =?utf-8?B?TWRhSURVRlJIcE5IWkxYNEppOWQyTjFHS3hydmlIUzZIbjFjV3BBUzVoQUxK?=
 =?utf-8?B?dkdJdUlzRUFUQnNibXo4amQ3NmpXWWRoRTdFMENOaXFyS1FGWjQybzF4V2JF?=
 =?utf-8?B?Mm9uVHJDN1piY1YvTDcxdFAxRnF6TDMwdk93MURoOVBYR2pzRWMvWkVLdnhR?=
 =?utf-8?B?Sit2YjU5bFpUMXlXbU9oV2dtTU9uV3hxVUdBQTNkT216R21va0FYSHMwYmZl?=
 =?utf-8?B?Tm5GeEl2Y2lBRFlFTncrS09qWU9nclMwRmRYTkJtRnd0bjluUWxEYjVGQnBq?=
 =?utf-8?B?Q3gvL1pkdzFhK2o1WnFLakttb2lvQlplTEs0Rmk0RXJ2L0dZWVBLWHpTNjUr?=
 =?utf-8?B?bVdqNEdPYm0xbEROOXJ4Y0lYVTdlREhmVVdvUFR0UXpRNSttYTJkVXJOVlFG?=
 =?utf-8?B?aEw5NlYxbTZLK0U1NlJLd0ZqeC95U2IxTUhLU2FOVkJVbE5FWFhZRGtQN2Z6?=
 =?utf-8?B?bjAxQmlXZEtObWdCK28zeVpDOTU1RzFaTlJWSnBTZW5hWTQ3ekRhc2NNOE5S?=
 =?utf-8?B?dWVNdUhkd1NoRURnZm92RWtSaWM1RDBCTjJDY1ZFOWZpSXhTdDFuOW9YUEUy?=
 =?utf-8?B?VC9CVXhFTG45bG8ySFA0Tk9JSG9NK09CTkVtYWNVTFhvSllsZ1BNd1ZVYURG?=
 =?utf-8?B?Ymg2S0wzN0p3ekRZemp0eHM4NFBGb2JaRkNBaWlFZDNuOFJJNGxUK05sRFZC?=
 =?utf-8?B?eTArK0RHUnZSOWVpOVc1b3V4NWhuTG5VLzRwTXJ1Q3BGRlJYZ2xsc2JXTVk5?=
 =?utf-8?B?TXhKL1k2Z0tlUkwzV3VNaDY5dk4waHJBeTFkbUFXWHdGWXlscStydktJMUVa?=
 =?utf-8?B?bm5nbDJGdXpUczJ3MVRVTFhweUVSWmxldk5vNG9WS1MxcU5ST2NzTktqTDhp?=
 =?utf-8?B?Y243b01uOXlKbkw5cjNqaXFTYktNeXpZNm5ZaFBDZU41MDU1ODhzZys5NTZz?=
 =?utf-8?B?VjFDbm90S090VGdzaVFRN24wVFNoaiszeTBGekhiMjdSRm4rNGxBZTlVTVJF?=
 =?utf-8?B?ZHpQd3RGWURtdHBDRnhmUjl5S2ZJdE0zUGxFMjlwVlJFcmt3SkJaSTNUNkpD?=
 =?utf-8?B?bjhWcW9TSEpuY0xING1BdFlCVVZwbFpYc2N1WE5FZWQzOFJ6WG1YVHVQa1Fp?=
 =?utf-8?B?dEtWb2VRNlh0K0ZRelZBRFZSUnQxRU0zd0xtTThHNjhsVkpseFFzd0VUR1dL?=
 =?utf-8?B?YVkycVIyN2NHc3gwb3Fjd3psQXI1V3BKblBybk8wSWE2SnR4cUpkYzVVOXMr?=
 =?utf-8?B?djk5NkRPL3pBRkdKSm9CclZ4UVQ2dUg4cDNrMTloNlQ3aWZYR2tvc2Z4M2FG?=
 =?utf-8?B?QnVsK2ZFWU1EdEtHTEFzMWVxeXd5MVk2ejdMcjZ5bHBOME5lTDc2MmtDV3BM?=
 =?utf-8?B?NVFxVmJHSWVQV0NKVlBqRnVZWTBIK1BTREJhZnR5K1FESTVWa0psVzNFSCtC?=
 =?utf-8?B?SzFZSmVzWXVOajhUYVdISGRwU1NlZ3NqV2Rvb0x4TlhHTHBnYXY5SWpVSCt5?=
 =?utf-8?Q?spZslZWGvnl9FseKV0R57+c08G8Y5M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:11:44.1442 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e890a791-bd97-4e4c-bc76-08dd3f7bc904
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432
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

Add register list and enable devcoredump for JPEG4_0_0

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 40 +++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 0aef1f64afd0..e5803cb07925 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -36,13 +36,30 @@
 
 #define regUVD_JPEG_PITCH_INTERNAL_OFFSET                  0x401f
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0[] = {
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_JPEG_UV_PITCH),
+};
+
 static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev);
-
+static void jpeg_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block);
+static void jpeg_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 static void jpeg_v4_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -123,6 +140,12 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_jpeg_ras_sw_init(adev);
 	if (r)
 		return r;
+
+	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * ARRAY_SIZE(jpeg_reg_list_4_0),
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->jpeg.ip_dump)
+		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
@@ -152,6 +175,8 @@ static int jpeg_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	kfree(adev->jpeg.ip_dump);
+
 	return r;
 }
 
@@ -704,6 +729,17 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v4_0_dump_ip_state(struct amdgpu_ip_block *ip_block)
+{
+	amdgpu_jpeg_dump_ip_state(ip_block, jpeg_reg_list_4_0, ARRAY_SIZE(jpeg_reg_list_4_0));
+}
+
+static void jpeg_v4_0_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	amdgpu_jpeg_print_ip_state(ip_block, p, jpeg_reg_list_4_0,
+				   ARRAY_SIZE(jpeg_reg_list_4_0));
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.name = "jpeg_v4_0",
 	.early_init = jpeg_v4_0_early_init,
@@ -717,6 +753,8 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.wait_for_idle = jpeg_v4_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_set_powergating_state,
+	.dump_ip_state = jpeg_v4_0_dump_ip_state,
+	.print_ip_state = jpeg_v4_0_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
-- 
2.25.1

