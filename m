Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0133CC02192
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A701810E777;
	Wed, 29 Jan 2025 08:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eunMZueK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E4310E773
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dv3CCI8Vk5/XIdzwtCipwXBwwA/kLPwTp6dUalH1EzMENDrVplDUJtWr6RhwS3YTzM6OmGo5bMxGrIDwGHQk+H1DnNmEuJ83VMCQb0idt6lovT0f7CRDX5TuqWuq5ivNYmWU8HIA4gj9lTRGaT5ayo2Fm+djBByDTrTceP4f3wa45yYN19gQCEuobs7c3JL0KhdHYfuhr6S7ffDaERhvXmB2PKz6PDUxPlyG4PMb8OoqKTJROs8SYOEPQ74YCS955I7iynVp0yuQe6u7DgK6GsTPrDigNe6sS1cMgL8zQS4TjcJ0LnNi8nA7bQgW/zgjgj7KluF4A45DS+JrncQ+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9QHSQtvgnO7dOhWnXIPr1dksNFXPzhn1W8NY5WM+2E=;
 b=TkKqo/S2FYQbjIBwMp8si0uMBp10EWWxlBBN2llYTIUDyYJt/tDm/MTxIQvHCW5Lh+E5b2ZU+/XLZNj8keVCtH2sxpFTGDvcAvxUEdzn8eG+kwVlzlsq8srzL4EHBBFTU/cbhFTdaIGC04Gbw6a5kkrsEB0L2JJXef1q4B1+yMBPubU7c1773ponLJJPRyZaeXboaHyExWf52hzlGPiv+Q36hLtAJF9E8t9lGcg6d1uOLUqWWlch6xEJvh+Th1xSGKLeu9o8+cicgaRhKmeNkkhuh/1/jrbyDyDHkJY1rYnuFwjTk5fVNdzDJJGy8EeIqukQIMIcV1zYZP0A248zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9QHSQtvgnO7dOhWnXIPr1dksNFXPzhn1W8NY5WM+2E=;
 b=eunMZueK38gezrwS8VO91WLQpWQ1EIq3JIQyUKbkwccRE0naV+/iQFxLA3iUOWrc9flDQgDtC2xZUkweCwQ7qTXl3pjqvSL7msw/FEai0CfCcAZIARGAAzBa42ZpCmJwKH5SpRvJzRR0MSgR1qQlIYZgj535hRSQcOI03JirBq0=
Received: from SN7PR04CA0078.namprd04.prod.outlook.com (2603:10b6:806:121::23)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 08:48:41 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::e0) by SN7PR04CA0078.outlook.office365.com
 (2603:10b6:806:121::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 08:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:48:41 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:48:38 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 6/9] drm/amdgpu: Enable devcoredump for JPEG4_0_5
Date: Wed, 29 Jan 2025 14:16:40 +0530
Message-ID: <20250129084643.507727-7-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ecc423-46a2-4885-1d67-08dd4041bb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmRXYmI4aWI3TXRRejhyZEVwMW5TOUc2NGtZVmhEYncyK0ppenNQeHBOSWdH?=
 =?utf-8?B?R3NUTGFUTGxTSHQrNU9JcHFBTk1WMS9JVEFvQmtNN29PSkJzNjBPMnVsbWI0?=
 =?utf-8?B?ZDdWVTNxUFFHYlJXajJicEJEb3gwQ0RpVWRRU2V4SGJrYmRJRGxKZlkwVWtL?=
 =?utf-8?B?WlBHZFVBM3hrWGV0eEJGa1N5akw5cUxzTkthWTliTkRMdnp1RVNLSWtFRDhi?=
 =?utf-8?B?SXRWckJ1NDBRNURSN0NweEhsTU9zRkg2bFMyR1VmbXRtbC9kWmtUNytqbG9m?=
 =?utf-8?B?clRuYzh4amdaeXZGeWlLclJpRnZDOVpNWDdJWGxBQXg0dng1a1pQdjJ2ejBW?=
 =?utf-8?B?a1VkbTJKTFZreDh5eTdDU0Ura1BhVXFGaVp6Q1d6cmJUZ1FCNHJJRytYWGlX?=
 =?utf-8?B?TWRCVnhzWE9JKy9pZEpWVHgyOENDZWliVjBSU0hCWWRZY2t2WUZYZnczdVhD?=
 =?utf-8?B?aGxVNmY1TS9GOWJ0UlhWbExSSnhyM1ZieXZPVllWMHM0Zy9hQ1lzb0tMVlBS?=
 =?utf-8?B?YWJmQW5mZisyY0xLNWpwMU54c0xQRGFiczJSdDc1azBYNjNoNFd1aDJYd09W?=
 =?utf-8?B?clRMZlQwSkYydGxJYjZVUWh3Wm1CTFVlcWk3UExPM2JVZWNMQlI0Wm9TSlZj?=
 =?utf-8?B?RjdZMVIxNmcxVFVrUXRkOExVUERWZWdjeHBTY2R1akU0UW1iMmtJWFdtaFpX?=
 =?utf-8?B?SU5iUFR4L3IwbGF3WnM1TU50UmlnNTBnMWNHSmludFhkNGNzS1dtRlc0MjN1?=
 =?utf-8?B?MmY0VjBVUFkvOXl2L2dLWGNEdHFCUXhQQlVNZnlGb0RsYWRhbGRPTTloSnBx?=
 =?utf-8?B?YTl0bUNpSUpOWmt3NVdZeWdqQlBTTnRLbmFsOUd3QzZOaEtBMWlYMW9yOTRM?=
 =?utf-8?B?TjNib1dRY3doS3ZTSVE4cm1xL3RtOFRLeWpjZWVFaVNIZkFORFFVSWI4eFE4?=
 =?utf-8?B?VXI0ZDhxc2Nibkdlb2dNbC9JU3pMRHltWUs5MWxSYnFVMW4wbGhlZCtHVnpD?=
 =?utf-8?B?a2JvMlNUSENmY3dQQWpQSFBvV0ZNMUhDMmJTNmFaOTh0SVgrWGwrTzVwYmNJ?=
 =?utf-8?B?N0g4bmsyb01xUjlwN05PaHh0OHpvMXZPbEJXM2tGeENZVlQ4T1VOUTkvZ3Z0?=
 =?utf-8?B?WnY5VlNoSXNjM0dIZEl6aEJ3cVZIN0E4cG9OMURDMC9udjlhWUVEOThOYVpD?=
 =?utf-8?B?RWxEcjk0eWMzam9WYnYvQy9uZlB4dlpzZkdvVlJjdG5YNnRpVGtYNlJQckF4?=
 =?utf-8?B?cGpEUlQxOUtseXh1TTNxUGswVGxKOVdwUTVOQkwzdDlvL0VOVXNvNXpOUElk?=
 =?utf-8?B?c3pkcVZtemFIclZMcmFYSmlhQnRtdHVPSXlWODBSOWdOeHdsS3k0VVNWL1RC?=
 =?utf-8?B?a2dhSHpyWUw3L1NJak9pMHVGandub2E4TCttelVpc1FZNE03L0RjS245aHZh?=
 =?utf-8?B?a2kvdk00RFlNbnJ6M0FKWWhQNUNsaDZsd05FTjR0UmlNZlJsU1pCamZBdmNk?=
 =?utf-8?B?VEQ3NWlnYlA4Y0x3dlBsTXgrQ1hHOUFvN2Z4VjhxcGltVVd2L1VYM2MzbWo2?=
 =?utf-8?B?UE5DWExwcllHTVRHZTBOcmh2LzdJLy9GTWRPZnF2aTNQSnZKWEZhdXpnU3E3?=
 =?utf-8?B?SmRNU2h1VFlWRzlITG9wMHVLMmJFS0VTMm5GLzhCNlZoNndvbktwUHN6ZC9R?=
 =?utf-8?B?OTJPejNldkl6eW9GZVpSQ0MrWFpWdFVaSGJSaVVTRkQ0SDNlOEduMTUwaXBN?=
 =?utf-8?B?eWdVVWFLOXZxVHgrNmt3STdIUFNkbWE2ckJrVEVqL0hzZTlSeDY0R0FSVllm?=
 =?utf-8?B?RVJLTDIrWTN2K2ZPM2lxaER0VTFCa2gyTWZXMVF4K1NzQ3pjYmwydDZuQ25N?=
 =?utf-8?B?KzQzckxtdktGNXRROUR1elFyVjNRYUk4bFFsQ2J3VjlTaWdjN1B3enlsVU9I?=
 =?utf-8?B?SG9SbzFmYXhXaFhEaWdncndwM3RKSkt2OWgzTU5QL0JMOUg2Y044MGxMaFI4?=
 =?utf-8?Q?RWVvdahhp5LornQ1RIAPGAQXdkGVjg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:48:41.2455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ecc423-46a2-4885-1d67-08dd4041bb24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
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

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 27 +++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 6b3656984957..dabc9a2401c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -46,11 +46,26 @@
 #define regJPEG_CGC_GATE_INTERNAL_OFFSET		0x4160
 #define regUVD_NO_OP_INTERNAL_OFFSET			0x0029
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0_5[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH),
+};
+
 static void jpeg_v4_0_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
-
 static void jpeg_v4_0_5_dec_ring_set_wptr(struct amdgpu_ring *ring);
 
 static int amdgpu_ih_clientid_jpeg[] = {
@@ -58,6 +73,8 @@ static int amdgpu_ih_clientid_jpeg[] = {
 	SOC15_IH_CLIENTID_VCN1
 };
 
+
+
 /**
  * jpeg_v4_0_5_early_init - set function pointers
  *
@@ -153,6 +170,10 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->jpeg.inst[i].external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, i, regUVD_JPEG_PITCH);
 	}
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_4_0_5, ARRAY_SIZE(jpeg_reg_list_4_0_5));
+	if (r)
+		return r;
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
@@ -182,6 +203,8 @@ static int jpeg_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	amdgpu_jpeg_reg_dump_fini(adev);
+
 	return r;
 }
 
@@ -759,6 +782,8 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.wait_for_idle = jpeg_v4_0_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_5_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
-- 
2.25.1

