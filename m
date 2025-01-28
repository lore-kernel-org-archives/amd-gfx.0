Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFABC0218D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8973B10E607;
	Tue, 28 Jan 2025 09:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YqqudVzJ";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E765E10E607
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDm2DMoge/YJq3DttnTyIlBsRjxQODgNftDGfVkmnWV0kpITC3l95tJPpt8O2W68s4v9gXdes2QE+dfRRvQSbtdZb4wpklwg474rsoM/kZTKIz3sptSv/GfOVB6tlAJVOYUI4W3qeVMNFTfUX28FFz4B8p7iqp13ldyc+6E6vNQDQDailXzXAskJCTtefpKrN6ZhofKoUgjui1JJmJc9gzJX/rhXFw6NKQ3F6L8eCd1iVovxVi1Tprv+HF3xfLXBRHuYC3+BJpVUoms6Vb5hBHkRU36p6noJd2rmVEQs7enQs4L7tfIpeUbqJ49Zv7xYPY+eh2jILF1sq5PoaXfDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0Z86uuQCBTk6+sNNoOKyCvJyF5qVv0I97URUvVOF3I=;
 b=Aabr34gNuY3/FeOEKzyvEb+0AaZUL5uSEoj92TLw4yxvovUGVpDvFKUoz1csJ6isvdAm58pbk3+cSpHaNKJz4iEy6GffEIWnaGCWXZuF49XKkvnd0TMcfdM/2PUfEn+Bem42l85e06uMyQES/liNkGlwRrgVcbdApgxeVJSiiZYzhOabo6omWOufcc346V7lKBr0Xp5dZQSWg+OlAiRld6eOCWdhawnFEt9ykmzj3K2tBVnaUxskxeEQKFI8FVdpWewBkfARuo0NHet2+CRqv3IRtby46X+BreNyBsDqFLwrjIqYsaK7SKNNJ/hYlt/S9V+WoQS+6LlB2/sDHXyEfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Z86uuQCBTk6+sNNoOKyCvJyF5qVv0I97URUvVOF3I=;
 b=YqqudVzJcq2jvIKZQ6o2ZGOalrf1jLAGBeT0n6QQp9q0PHjD/pm2cYK98YLcVU6zwxHEc2uabH3JF9rsK8N8zmDYvnZl0Rk+cWkpOvJQ0NCtihnzeBBcfP5BflBIm6u2mU2XRORYSsi8bgnH6TF71an+3gIQ4G90qosgZ4FEJcg=
Received: from DS7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::22) by
 PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 09:12:00 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::f1) by DS7P222CA0013.outlook.office365.com
 (2603:10b6:8:2e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.24 via Frontend Transport; Tue,
 28 Jan 2025 09:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:11:59 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:11:57 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: Enable devcoredump for JPEG4_0_5
Date: Tue, 28 Jan 2025 14:39:47 +0530
Message-ID: <20250128090950.461291-7-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfeb9e3-0339-49e7-7b59-08dd3f7bd239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWQ2UW1ucXkrNGtQVXdkUC9WYmhxbzNGSjRwNDZNMGR3S083U3VyZk40MkFH?=
 =?utf-8?B?Qy9qd1hDRmxEeE9IcVpDVElnUkRWWnFEY1d5Q0VSejR6WWtFcUlkaGdYNXJI?=
 =?utf-8?B?eGFKUjZLNHVUM0UwVm5COERXVnNjTHp5SFUwOWxBNGdKaHB5dzIyaVprNmhS?=
 =?utf-8?B?Y3l2RmVEeFlxRUlwMTlVWEI5c1RhM3BURDYxQmI0V0RsSVN4a0FJL1ozTXhK?=
 =?utf-8?B?SFlGZGZ2OWdJczA5dHVvNktTSi9VTHdMcmkvbTJlTDYyZnUvNjJJZkxjMmFx?=
 =?utf-8?B?NkRxOUMvRnlZMXAxd3o1TjBHVU5sK05NRXpESkc3eHpoOXJUZDJQdHBlWE8w?=
 =?utf-8?B?aFlka05HMHQ1NzllQnpVdlVrMWR5amdYb2JaaFJXY0gzOHlqbjVZdjlmSm9i?=
 =?utf-8?B?d0RHcHN5WW84TDdaRVhMb21MUjFhZGZmNUVKeGRKQ3ozaUdaaHcwa29FTjVr?=
 =?utf-8?B?OHRVUzRtZVFneWNMbUtMWkYxNXN6ZGNsWUwybXR6cVdBVmJFSU03VEplamNX?=
 =?utf-8?B?dU5SNFplOFN4UjY0Q3RtYTdKYnNHTGhUUWwxSzZGQlNCWVczSGlLWXF0c01I?=
 =?utf-8?B?bXpQei8yZUZoL3oydlNYN2I2TGxvTlVmRlNvNUpuRHRTL3RiRUg5WXYvTUR3?=
 =?utf-8?B?SzZxTWNiUi9Ydm5WcjVtTldCOG0ydWR2Y29uWXZQdytJWm1Wd2dCbWpuZUNR?=
 =?utf-8?B?bVNESXhCUlpWUFY1ZnhWR1FkcDVMUmVzYW93ZGlUeUVkejljV002am5FU3BF?=
 =?utf-8?B?SDB0OEx5bUJvcURYVllXQ0Y0YklRdThqRGhETXgxc2FoQkV5dHAxL0ZBRG1v?=
 =?utf-8?B?S2ZKY2x2UXp5SFU4eHU2dE0zNzRvYVlLeEZ5TGlybkFkbXd2a256TmtTOGxP?=
 =?utf-8?B?ak1NYjlqVVZFMkpZZXNOMFZFOThyOUZjN1ZiTFErQUdMVWFlNGNaclRpLzA3?=
 =?utf-8?B?aU5wVUJ0LzhvZEtULzl4NEtESy9ud1hVMURicVVQWDZTVzEvR255bm1aMkNL?=
 =?utf-8?B?elkwNGtjQS9oUG40bHdERzhYQVMyZHlpOGFZUS82Q2FEWjBSd3o4dWdURkpm?=
 =?utf-8?B?Y3FTQ2c0M0NMNlhWZGw5WFcwcURLZ01OLzBvT3B6c1dPbVBDQUI3bk91bDYr?=
 =?utf-8?B?NENWV0dTRHVlT3BxUU10dXB5RWZvcFVGbHdwVG45anJvUk9TeUxrZWZNY081?=
 =?utf-8?B?Q096MVh2RFRCWUVVeSs5Z3k1VThnaHJJOG1VNnV6MWF6V0x4d0p4Z1ptRTNN?=
 =?utf-8?B?eXBsR1hWMEtMNk5rWFdERHZRWFBkUC9QRXhtTUJ0UlhicnFSMkJOQXZ1ZU1j?=
 =?utf-8?B?VFk3ZVhpdWRyMGliMVUwUEhaWU8weG10QTE1SGFXcWlDTjBXcHNSMFFaWEk0?=
 =?utf-8?B?eW5pd0dFVHNBTDg2WHV2aUU3b2dFcG5kOWlXWXlZL2pkQzhEeHZlNWRqOWl1?=
 =?utf-8?B?MGRJNitzSjl2NzNHMXBvUzBzeklETTR5ZS9rQVhKRUhGTHh6NUZLbHpYWnJ2?=
 =?utf-8?B?S29uVGExUkhHOG1DNnpZWDR3R3lYTFczY1dPSkNvMHhLTzV6SlNaQUVVdHVp?=
 =?utf-8?B?MXpqbjN0YmxzRVhyeEEvVFh3Y0xtOXh1eTRJblhxMzFNVW1wdStSWUdod2xz?=
 =?utf-8?B?dWNMQTJJZVhwV0ZRL3dRTVNDNjNkMkhyR1poZlpwMGNZemRkUytIdmo1ZENJ?=
 =?utf-8?B?dnphZXEwK01KSGJIMjJPRlcwZ2ZwVEVhZ0paYkFVOEJ4TnJPNWprYTNYNTdI?=
 =?utf-8?B?RERXbEZMWjVxQnhrS1hleUVYeVhlY2NUaTJFVWI3YXp1NzB5M3V3bmpkL095?=
 =?utf-8?B?RWtaRGc3anNhdHVjS3l3VHI0OFNhZm1zckpDWjBOa0Z3NHZvMzRmaFNqZUxB?=
 =?utf-8?B?RWMzTEJ3SWl6a29XRzdRYTNVTjAyZUd0eUxOT0RTTndIb2JRekMrM1YzZ2NX?=
 =?utf-8?B?RHJhT0pvTXAwVGZNWkRFYVJMWnRabjFBcFpOWU45dHBxUHhTYTRTTmdTOWQ2?=
 =?utf-8?Q?y0Omjerdq11683zycJtjI+5FpuxsAE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:11:59.6050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfeb9e3-0339-49e7-7b59-08dd3f7bd239
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
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

Add register list and enable devcoredump for JPEG4_0_5

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 41 +++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 6b3656984957..8fbbfe66b139 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -46,11 +46,28 @@
 #define regJPEG_CGC_GATE_INTERNAL_OFFSET		0x4160
 #define regUVD_NO_OP_INTERNAL_OFFSET			0x0029
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0_5[] = {
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
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
-
+static void jpeg_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block);
+static void jpeg_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
 static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring);
 
 static int amdgpu_ih_clientid_jpeg[] = {
@@ -58,6 +75,8 @@ static int amdgpu_ih_clientid_jpeg[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
+
+
 /**
  * jpeg_v4_0_5_early_init - set function pointers
  *
@@ -153,6 +172,11 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->jpeg.inst[i].external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, i, regUVD_JPEG_PITCH);
 	}
 
+	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * ARRAY_SIZE(jpeg_reg_list_4_0_5),
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->jpeg.ip_dump)
+		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
@@ -182,6 +206,8 @@ static int jpeg_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	kfree(adev->jpeg.ip_dump);
+
 	return r;
 }
 
@@ -746,6 +772,17 @@ static int jpeg_v4_0_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v4_0_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
+{
+	amdgpu_jpeg_dump_ip_state(ip_block, jpeg_reg_list_4_0_5, ARRAY_SIZE(jpeg_reg_list_4_0_5));
+}
+
+static void jpeg_v4_0_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	amdgpu_jpeg_print_ip_state(ip_block, p, jpeg_reg_list_4_0_5,
+				   ARRAY_SIZE(jpeg_reg_list_4_0_5));
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.name = "jpeg_v4_0_5",
 	.early_init = jpeg_v4_0_5_early_init,
@@ -759,6 +796,8 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.wait_for_idle = jpeg_v4_0_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_5_set_powergating_state,
+	.dump_ip_state = jpeg_v4_0_5_dump_ip_state,
+	.print_ip_state = jpeg_v4_0_5_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
-- 
2.25.1

