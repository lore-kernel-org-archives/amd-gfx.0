Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCA2C02191
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2025 09:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2222D10E60B;
	Tue, 28 Jan 2025 09:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hi6pYgtF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56D9410E60B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2025 09:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChszTCHqvu3oDj/3JtfO0jhy3XY/pW36Qj2DpmRWrlkVh/xROnizALmyQwciorVxJpmEHo9m8Rv516UZHNUWvgrNmvoJ3NVXRPTNQIBovgezuF+j1VKWMS4N5tYd4oc8zQ5M9Y+dStsTIWeqJOkNCsob3DUDsdEhZU9jIYAW2VyMGPXzNjLqVBkVLXwmNZMOYknfUrBD6hEHg+vjM00d2nwx6hE5UBfM51lk4x/x/qUG13KA/DvBQhJHMChy/AeHQzwMOF+9kev0+2hx3xH4acCitqS/iCm1FM1qQazpuqiHziBeyOFPNoUop6VbPBy7OQKfAHb/oY7Us++kKMS+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aapw25tcrpvMYnyy8t7bjZDCaj7MK9923npFEXLOTBU=;
 b=dacyDynV0ir58h0cf7vPWvlxF8b6KqMa6gbRJ6j9uHYgzLnBbMl1Fa0UttruUbTRUKH9qLVgUGu1PmrBqBjQC0hSAjNvOK6hFgH8cIk3GKbOTEyTBfvO5aCJAWj1KyCGh8VKHS7JsaL0TpDmVKXP8lTm1MOAfEsgn692lt2ERpWAIFnpkKKYpa1SGOLMeMO1j8/afDPki5tqRdXzDlYrqpMlpgdNwlwBWH/R7T1IrdYR51AOr9xxtLHXEE7uzDN/tpGXSFngCmQ6b1vUn1iqIGksfCQ5yW/gstTnNm1VelsuZSmfXU/X85BDpLSyFAwtTI64sqbZzTbrjWpwd/j8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aapw25tcrpvMYnyy8t7bjZDCaj7MK9923npFEXLOTBU=;
 b=Hi6pYgtFP6wGtb3gR0NSq4GEPU7+Q/kD3uzakGns0tcNiFDdP/+AVnJ3EYnfXhqyY+8EhOMXszq8g1HXsI0emNl4hv+2SZkQLjf5pzjmBLG959+ru4aYwwjr4/VAAr1k41H/v4z1YQ0rn2TB3F0LxbNvjZcDuWPxdIU1L+HCG1A=
Received: from DS7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::11) by
 PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 09:12:51 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::e8) by DS7P222CA0009.outlook.office365.com
 (2603:10b6:8:2e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.24 via Frontend Transport; Tue,
 28 Jan 2025 09:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 28 Jan 2025 09:12:50 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 Jan 2025 03:12:48 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 9/9] drm/amdgpu: Enable devcoredump for JPEG2_5_0
Date: Tue, 28 Jan 2025 14:39:50 +0530
Message-ID: <20250128090950.461291-10-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ca7db9-1cdb-4d70-153b-08dd3f7bf09d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUZvdmJxV0U1U3pQajJkRHhwd3o4d1VXd1FocXhlNjFlNlVLLzNwZ21yR3VI?=
 =?utf-8?B?YkRtOFBzZ3ZweENzZ2VJS3BtaGJCcnlRR0RjWDlEVFhXTGhoRHlpeGVQd3o5?=
 =?utf-8?B?QkNkSDgxQzl5TTZ3ejJBUDdWM3RycVRlaG9XQW5ZVENVeUMrNFZCUzhINzJ5?=
 =?utf-8?B?SmNZc3lpZTBpRlgweFJvbE9vRktaUDFtRTlkZ21kditpVG5zWXMvQzhUWE5Y?=
 =?utf-8?B?NmkwZGhIV01Nb1ZPVUptc0xGMHRGYTd2eTkrUDFpdmZoeVplK2FrNjhVSmFx?=
 =?utf-8?B?eDFvVm4vSlMrZVZTcmRWbWE3bGcxYUxJM0ZTMjYrSEJXNktjcnhHUG95SWd4?=
 =?utf-8?B?UVFXRGl0c1FrQVBzc1ptL0hnTHNZWWVNRXVUbThNcUZVQkdYVExpQUNCdmlT?=
 =?utf-8?B?L3J1a1NGVFZoZEFkSngwREhBZVhOMlA4VU5Gd2pvVGdNcTk0N29oQnJXOG9i?=
 =?utf-8?B?R1pGTDN0Z2RBTVNXM0VXVzR6dUJBcS84b2hTU3dCS2tRNnBLZVVrQ3A5UmdC?=
 =?utf-8?B?cThPTUdxY3N5OU1IRlJxZ0Q0OVBIc3ZEczlBcEczeHJkM09SVVd4VGhiNVlw?=
 =?utf-8?B?VWdqcmh0dXhPTDh2ZkZPMUVtc2tYVXpLa1VwMXhtekVZV3pjNFhUcEt4QXpV?=
 =?utf-8?B?QkRTVnZmclpXVERyY1JIM21qbGJ2eWsvV0M1bmE3WFcwcklsb0hrZjgyWDVl?=
 =?utf-8?B?UTlLNUpib0NRMmYwRjFDUWNqSUo5S0ZMUHZkaHRsSVpHeEJCL21MdEV6aXo0?=
 =?utf-8?B?T28ydElqeVJGS0JHUFg0ZHhsUzFYVjUxVnVRRlAvUEtMVCtiSmRJRzY5VVlq?=
 =?utf-8?B?U3pUUkpMZHBwQ3p3cVFzNDZHMDB1RGFXdzJmNmsyc3Bld2l1L3hNejk2UnI5?=
 =?utf-8?B?NDNCSEFvMDBzZDhOVGNyeG1zYXM2TDZWK3BOR3dnZ2xpQ0Fqc244QXdXbmFS?=
 =?utf-8?B?WTFHcDdHSy8xT2wxcnppZHNWZEZtRzhsa0lTSFhMbUUvZXdUU2N5WXRDaHFL?=
 =?utf-8?B?N3l4R09CL3BsSjJJT3hCOXhaNFFkK21Lamd4VE1Wa3VrVG1kdTA1WlhaUXFu?=
 =?utf-8?B?L05UbTdtYWtNcWFmRDhGaWkrUmhuTmd4bmhDZDNMZ1BxbUJVbEdhTXVBTXU1?=
 =?utf-8?B?SnFRcytKbnptQkRFeVFaYks4TmprNVdmS0pZVnRhRWF5cGdCM2ZGV1c4UkY0?=
 =?utf-8?B?aFZKK1RITG5wcjdESStWd3d2MDE5TWtwOE9Qb3BpOGlUdWdsd1NvbnNlY2Zj?=
 =?utf-8?B?L082NHp0SnZZV3g4R2t5cTNoTGwzSWJocnZUcVpYeForRXBlZDZ4K0d1TWhT?=
 =?utf-8?B?cUxIQm5aOWY1VE1wdmhSOWlBVzQxRXB1TWlJb1BmaVRDMGEyMUxKbE9OM0JR?=
 =?utf-8?B?eVJkK0dVZWc2Y1pJdk9odytwNExnU2xndTU3Ump1bHlwK1F1VHYxNHovR0pB?=
 =?utf-8?B?ZjBpWDlpMW1NMHE1cHV3a3Q0MzVsbTF6dHhTS3RvYnloQ2hDblVzTXFzcEhG?=
 =?utf-8?B?c2VTWEhqOUxqSGVCY3MwK0VTS0VKMlFnU0xqZWIyUG5Bb3JJcUhHa1FNc3NJ?=
 =?utf-8?B?WmxvcHdOSmVLZ2lZMEhVVVQwUXdRMEMzNHhkOWJmZ1E3Rm1LZTNVS3NFU3M0?=
 =?utf-8?B?aWZEZzZLbXFrZUQ2WkxPb0taaWxtRDk3cDNmMW5YMWMrdzFITURPNDJXODcz?=
 =?utf-8?B?dkNtc0RXRlEwakNTamgxczY5QTY2ZTBVbGxOVTRJSjR2ZGVhamN2bEI2R1BB?=
 =?utf-8?B?blcxVTJ0UFhOV2hwRG05TUk5VHF1dk9Ld2VQWklnUDFiSGFDWVFWdVNsby9I?=
 =?utf-8?B?aFphWnpiVGZXWjVjZytER3hsek1FYnloZ2ppeFhmcXllYkZET3hUU2hvSnU3?=
 =?utf-8?B?YkpXR0plZXdVN0RhNkUzMmNUcGU5WVhDaFA0WnQ2Q0QzVENLZVdxc0d0UjVv?=
 =?utf-8?B?d0xEcExsNURiZUtyUUlEcW53MzNpdHBueHI4eXA2T3JWR2REOXZFOVVZVGY0?=
 =?utf-8?B?YTFzV0hLRE5BPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 09:12:50.5738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ca7db9-1cdb-4d70-153b-08dd3f7bf09d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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

Add register list and enable devcoredump for JPEG2_5_0

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 11f6af2646e7..ba180eeb8f7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -36,6 +36,24 @@
 
 #define JPEG25_MAX_HW_INSTANCES_ARCTURUS			2
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_2_5[] = {
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_JPEG_UV_PITCH),
+};
+static void jpeg_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block);
+static void jpeg_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p);
+
 static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -147,6 +165,12 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	adev->jpeg.ip_dump = kcalloc(adev->jpeg.num_jpeg_inst * ARRAY_SIZE(jpeg_reg_list_2_5),
+				     sizeof(uint32_t), GFP_KERNEL);
+	if (!adev->jpeg.ip_dump)
+		DRM_ERROR("Failed to allocate memory for JPEG IP Dump\n");
+
+
 	return 0;
 }
 
@@ -168,6 +192,8 @@ static int jpeg_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	kfree(adev->jpeg.ip_dump);
+
 	return r;
 }
 
@@ -610,6 +636,17 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void jpeg_v2_5_dump_ip_state(struct amdgpu_ip_block *ip_block)
+{
+	amdgpu_jpeg_dump_ip_state(ip_block, jpeg_reg_list_2_5, ARRAY_SIZE(jpeg_reg_list_2_5));
+}
+
+static void jpeg_v2_5_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	amdgpu_jpeg_print_ip_state(ip_block, p, jpeg_reg_list_2_5,
+				   ARRAY_SIZE(jpeg_reg_list_2_5));
+}
+
 static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.name = "jpeg_v2_5",
 	.early_init = jpeg_v2_5_early_init,
@@ -623,6 +660,8 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.wait_for_idle = jpeg_v2_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
+	.dump_ip_state = jpeg_v2_5_dump_ip_state,
+	.print_ip_state = jpeg_v2_5_print_ip_state,
 };
 
 static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
@@ -638,6 +677,8 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 	.wait_for_idle = jpeg_v2_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
+	.dump_ip_state = jpeg_v2_5_dump_ip_state,
+	.print_ip_state = jpeg_v2_5_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
-- 
2.25.1

