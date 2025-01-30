Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE67C02190
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D10C10E933;
	Thu, 30 Jan 2025 09:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FhCgNeWw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1565810E928
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:52:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfY+wnhwme+uZ0Bw5JBzT/aGL9ghGlReZNn6rGlU4zNXevvPSOnHhm88CnaC4TJNrXQn1ZVIDChUXJP0P4u60coB58SGS7imUsgjeRAr459lGC4eIdnkKp7Csa91XPxLZ8EHN7TAZoZ2NuwlP3XM9NazYMqdwE6ovYWLAFnWLeAzpefti/YpErbO8HC9EJ3iYeFfskpvWCcjiKA/J3uKienqQsrhBTnrW/V0ZH4TrsTDrtjQNz54mTUGsAwMRxPhUL0Cg7tuyPD9F0TdzBYnS91uaXouLGeUZE6GqsK/FRUBXxz1ZH2dVPn4KG7QOtwQVtL4F5sW19kivdzCsiQGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sx91vligepa25dJ63cx+mhlxKDt9b5nkb4g07UrHB9s=;
 b=HxNnG09+zTwoYdZHMKouN/kublNAjYzbdWONHYAHGLJnjivfdQ+aNuWz4rQNvLFVV2nwQaY9Ex8YTJ/M0NooLPGakxDTCHYhuHUmfRj79XwaUYUjk8jrmeuZnfsdTz8PXj/GHaFBglHs0d55H1je3gnKW9nTen+w6ZJnYgjATObwFQrVV6McUmuzebSzNQTBbWHv1TvNtilgP8Q2XyX45O+tuIVtGE/UBcqNYk40Q669HteVunRKXCi4BUHWsfmnGgdJbxe47jrtTmPE84vxd3/2atpAoFqRfhrKIOYrboM+GrKXTSJuWkoz79wCwYVl0/fXN6LaU7jqhmz2oJauyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sx91vligepa25dJ63cx+mhlxKDt9b5nkb4g07UrHB9s=;
 b=FhCgNeWw54BNPb8crQfdA0lhKMTbZZQNdG83dfInepETI8K93V6Z1+ewjgn6gPEoR1IRpnqctzO3PSywJWbHvuYfgwV40Nap4P9b1+/xLVa02Ru6bWfDr3zVnjByuEHu6eUr8o9EzrLfykq5MYfdHulxP0zdbSnnbKRgtpZu1m0=
Received: from SJ0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:a03:2ef::22)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 09:52:25 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::87) by SJ0PR03CA0197.outlook.office365.com
 (2603:10b6:a03:2ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 09:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:52:25 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:52:22 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 03/10] drm/amdgpu: Enable devcoredump for JPEG4_0_3
Date: Thu, 30 Jan 2025 15:21:06 +0530
Message-ID: <20250130095113.534630-4-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ee5895-9583-4984-09d3-08dd4113cced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVVFNmpIZDRzK05HY1dEZDJGa0l3SFovRXZGT2lHdFhyRyszbE5GRVU4NHBn?=
 =?utf-8?B?b3BFLzBkSzdFbWFVZCtnSXN2MjNqbnFVOXBwVFRUT3RSYXFPRGRabWovcnB0?=
 =?utf-8?B?RkEyMzFZUFhxaEoyYW1xNkIvZ3RvUWRhMXQ2VmNqb1JUTUZsZ2dBNEFrTllX?=
 =?utf-8?B?QVBZREhGek1oZkNBRDZrV2dDWmF4Q1VBQitlaitaWWpFLy8rV29rOXQxMTE1?=
 =?utf-8?B?RnNDbzEwUm0vbWJsSkdHdXR0ejJ1Qjl1OTVKQ1Y0NnJvVXVQOWt3ZURpOEFu?=
 =?utf-8?B?S04yeCs2a1J6OUVpbnY2YzJiM2xOQUV4ZTNMbm5iYXI3ZDZtL2RhUXl0cE5I?=
 =?utf-8?B?dkx5MjVGeHp6RmFWQmVSSTVYd1NnNVA3dzdSbXpJak9Dd09ZU3JTQmhNaHBy?=
 =?utf-8?B?WGFNQ2RhZmkwVHFQczVMQ0tuOE40Mk15K0xwUDNYdmh4ekZnbWJyY3FKWHdC?=
 =?utf-8?B?UG1oR0ErYk0vRTF6NTc4bjZLaE5HaEZPRnN3UkU4WDU3YURBNU12Nk5UbDhl?=
 =?utf-8?B?SmJXRlNpWWdDaUs1SUZIK05TYSs4M3U1aWhldjBCSFhGUXNGeFlyZzJFT2JZ?=
 =?utf-8?B?ekloS0Q5T0Nhb2diRjJKcW43aW95K3o4bjgzODFGcHdKb1hmOFZ3KzRKMGRt?=
 =?utf-8?B?QTJQd1JaNHErWEpVbFZsdnhZSWtWWjcvbWYvWnppUU0xekNNYWpHR3NHdUVm?=
 =?utf-8?B?SUlZaERJQ2tOZTI1bXBOY1BVazRCaFQrTlFIeVd4bTNMQWpJM01ZdG15cFpk?=
 =?utf-8?B?bWRNU0VKNXlBZWlEclUzNzJDTCtGc3BxWkZNWGZLZWlSd3RGVWlKZC9JR1RD?=
 =?utf-8?B?WGxwVW9sMXh6QmR0VEZRVGVCNnpnVURMeGFXbGMza2ZJMkVJeHY0QlRHakdK?=
 =?utf-8?B?aS9FVGRNSDNLYzlydmJsMlAvclJyMkpvRDd1UFFlUmFUVC9VdW03NDBCQ2NQ?=
 =?utf-8?B?ZmQ3cHVpZlB6cmlUTG00OEZlTEg1elVwMUszanNiSUdaMXNKM0RpdHl6UU5E?=
 =?utf-8?B?MDJRUjBTelVxZUswU1dXemlYczhPTzFZb0JKS2dhOVJ0dXhNakhlWHdvdW5L?=
 =?utf-8?B?YTBRWThBSnBKblNFakJzYnFoU21uSEhuNDlpaEZrRXVzY3VUSkh6VHlRQ0ds?=
 =?utf-8?B?VVNvM0NudDlMbzBvV2txbHoyZHRYcFMrSEhYaGZLS3E4aFo5bFE0dmYwWlAy?=
 =?utf-8?B?aWhIb3FpUmhXeUNadFJyS1UwY2hJbzR5Y05xeGNkWUJ3elJsckV2WC8rdUd1?=
 =?utf-8?B?MGhya2RtclY5S1djcForc2l4amJVVGVmTW8rUmFVM2QxR1JjRk1TeHRSWE90?=
 =?utf-8?B?My9NWHlpVjlTTWduMDk4UStiV1IydkI5OTUvMVdFOGNTdlYxdDlseHdvMXM2?=
 =?utf-8?B?YmwwbU9Sb3ptSWQ0WlhtOHJxZkR1VjE0YW9WWVdiY0U1ZjErZnEyMTJxNmNJ?=
 =?utf-8?B?SnR1OWJJcjY2ZC9haTVxV09EQzlwN2tackY5bVFmKzIrcDY4OTRlUHJNTU0y?=
 =?utf-8?B?Vm94MDZTWFcyQk55NjJFYnRIRXRXc0NVY0ZLdFdhZTRRTkM2Y0xkTlhVYmdp?=
 =?utf-8?B?NlpQUzFqbkU0RWEyTE1TYS8xYi8rTkcvM2lXV0YyQkJrekZxZ29rdC9Ka3BU?=
 =?utf-8?B?U2FSRXNLVEFNbGJJVTlGeU1wcnU0c3huQnNPTTVNVVJHZU5PQ0RjRXVudjF0?=
 =?utf-8?B?NXVjRlNUWUY1NGR3bEM1MlgxYmRTNjdVKy9Sd1NmV3NxY2szMzIvcys1UmJw?=
 =?utf-8?B?UE1oRmlYYXVvY3g5UjRaNm5rQW9XTWdzN1l3VUJzVG9TSVFaeWtJbGgrY0Zx?=
 =?utf-8?B?R0tVcENVWWRlUUZyUlNZc1lZT0xNV3JpVmRybnVCeFJFbVBNbHMvMkRsOHRL?=
 =?utf-8?B?SVljeWVvOVJBeEYvbVJsMU5lMWdjcGtiZHpmb3RhbmNtR0RCT0I2M1ZnZndE?=
 =?utf-8?B?QWw2QTJHbXpIZTZRd3BnRCtKbkprbWt3T252QzJaZThlVk9wQ0N6VEE4NSsr?=
 =?utf-8?Q?nthbdFWEH63yISU7TMP+g2PkHBWL38=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:52:25.3186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ee5895-9583-4984-09d3-08dd4113cced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060
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

Add register list and enable devcoredump for JPEG4_0_3

V2: (Lijo)
 - remove version specific callbacks and use simplified helper functions

V3: (Lijo)
 - move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index bc21f12daea8..2a97302a22d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -59,6 +59,42 @@ static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_4_0__SRCID__JPEG7_DECODE
 };
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0_3[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_SYS_INT_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_STATUS),
+};
+
 static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 {
 	return (adev->jpeg.caps & AMDGPU_JPEG_CAPS(RRMT_ENABLED)) == 0;
@@ -164,6 +200,10 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_4_0_3, ARRAY_SIZE(jpeg_reg_list_4_0_3));
+	if (r)
+		return r;
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
@@ -1066,6 +1106,8 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.wait_for_idle = jpeg_v4_0_3_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_3_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_3_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
-- 
2.25.1

