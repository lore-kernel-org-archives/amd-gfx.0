Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5EEC0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE6A10E91B;
	Thu, 30 Jan 2025 09:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KzHZowY8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91F3110E91B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNUCkBxUERHqryC3QfTjHAqB25RXKGQdrqnYgjTBbSF6W2Rgl4jaFqgqSiDOK5bKNH5mMW52RK8BNyNjjTy9KFxBr6cS/4z5azdeidqWis6p8jcIk6Ydb5WfdYXtTNRORRlPGycvBv4WNJMsRYyjHxDbozxTWc3rAXZWhagXdLNE6w4qiABMOsxOl+4XI0iQvo27hFPLLywvCaTMVevbxEhOBmxLeUrakyWyAw/Zce62MMlyePnyK0TMwOFc1oiZ8Lwg4WD0GZUzGXSjDNZpBT/wy9tl8md13wsUc0gNFQQj7hMb6wBFniDEkVEEdTO0WlEnbJCcqswwP1xHclz+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQLQKIoJKwv2Ux2NK9QrlL2AalgUfugLJhzfxhyxmv8=;
 b=j57ASlrJAJMvXrmV00MZs7gMCU4quAAzLTcCOIG7bfhVYobwJJ5LHQBEmCyuoKdjewJY5aAeaj/nROqEQXiQNHKiSu8m9pFA2FU5wQ4pXKq4RYh5Kf8N/h4xLnQPcNS2Sa3/EA6W+sYCXgBUhVUxs87GnMyk9e6FxRZawcFLa2Ed3MACfRfNy90E+gVhDo97SUjg+GIG7GAUb7ZhuaJstnR7yvWHd7PbNBt9/zJEqNXwSPB9ixDhedJYBGoobFgt8l+hVvg1j3HWsjQ2cTOYl0a1fySR6VSFeYIT4ZlcugTV4xdiAYaZL+cjrWMwomgs6iJZAn/ugFyAQxs2Vw+uzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQLQKIoJKwv2Ux2NK9QrlL2AalgUfugLJhzfxhyxmv8=;
 b=KzHZowY8SyO19MokT9rGh2qBd/z3MjUv2yrxLTbs+Ilb0Ho0ZyUo/YIYSr/rTryVR4+Anv7JAGX5pmpOYdcn4Ndr5hmfz4Rfhv2aVfhX70uCA+3H2MK9EONABleKN6VQiEoMjcixMb+Icm/IB5C2GNtMI+hsgANmnwCdkXZcH4Q=
Received: from BYAPR08CA0002.namprd08.prod.outlook.com (2603:10b6:a03:100::15)
 by CY8PR12MB8339.namprd12.prod.outlook.com (2603:10b6:930:7e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:53:14 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::1a) by BYAPR08CA0002.outlook.office365.com
 (2603:10b6:a03:100::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 09:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:53:13 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:53:11 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 06/10] drm/amdgpu: Enable devcoredump for JPEG4_0_5
Date: Thu, 30 Jan 2025 15:21:09 +0530
Message-ID: <20250130095113.534630-7-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|CY8PR12MB8339:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c7dfac-9535-4bbd-300f-08dd4113e9ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGhzSzE0YWhMcCtER1FPblk0R2hEZEw3UkdsV0FwN2NrMEtFaVZ5cldlMWtr?=
 =?utf-8?B?cnFySTNkVUMxOXNSaDRXd0x3RTA1ZVdkcGF1d1Q5UVlZWmx2bTBNVk5MQS9l?=
 =?utf-8?B?c2drZmJZNk1NT2NVQ1NHclRPT2c4M1VmYytnN3hQNDJHdkhPckxhQVlMM21E?=
 =?utf-8?B?UFlpc254R0R5aDU0ZUsrZ2FvM0dUMkVrZ2ZpQjRpSURpUUU1cUQwSm9oQldY?=
 =?utf-8?B?YTV5Z2VuUmF3UEhpTzlGSmh4UXc0ekhyR3NvcHJRUVhZRDhmdStpUWRNNU1F?=
 =?utf-8?B?RmtaN0dyRktzVlV3ZXpxWDZ1RXJKWGZFc1gwdFBQODFOTFpZYVdieXBWcWZv?=
 =?utf-8?B?Z2RoMzF0T0c2cm5pUTNMK1VBcVoyd05ReElrQ0dFcElEVjlNeVZxZEZjakQ5?=
 =?utf-8?B?ZXduNkhacHhoTEtKcUZ1cmZaNXhJOFlLSDdzT043TjAzSWFtWlpmbkxHOXdn?=
 =?utf-8?B?ZmFhUU02b0JhbkJiTzJ2emJjNjV4bjFGdlg4TTg2RUJuQVJPNzFMTDdWckJC?=
 =?utf-8?B?Y2hQNHRIYmpjWmUwc05MU3JDTUFxZGtVZkRKS1g0N0dZYS85UE9SQjFCdytX?=
 =?utf-8?B?S25HMzRQTFQzbzI4U3FJdm00aGg5TUxxSzlsTmxmdmZSR1FyTStFdFViRmxY?=
 =?utf-8?B?dGtpT3VvSWVVak0rMG1tcnVOT3FjYW5INUhVSzZ1Y2t2aDZOLytUWE1Sb0FM?=
 =?utf-8?B?TTNNYlBWVVRHLzB5OE9qT3FLNjhTKzJac09uUkdhQys1YUsvUEN0cVJKVzZP?=
 =?utf-8?B?ZGlLemZsRUY5VTA5MDQxaUF0MmVkTXo3QmVKbVoreE13dmRRd1RneTc3VDVO?=
 =?utf-8?B?TnhYVGZUeEFBU1EvUnQ2bTFsMkNTMWNXV2FROGdIejA1Mmw2R1JuSDFwdEVY?=
 =?utf-8?B?bFVQMlRhTTloUERGTzVoaVo0WTJtT0hiQ0V0K2NJL252cWVpK1hsRFovNmNt?=
 =?utf-8?B?eEpjdWF3L2RheDFraGhXcnFzcmY1OXZQV0NObStPUHRydW9xVVQ1ZG9JZ001?=
 =?utf-8?B?Nnc5TWpCQzNSQldLV3hZajNWMzhFMnBBWExnTzVPa052RG9hNkpLUVZqSmV4?=
 =?utf-8?B?UTdMcHM5MzRCRC9TNnBhWVhhT0dtK1JNRUlsWXJ2OXAySWxRY2psS1liTjYw?=
 =?utf-8?B?ZzdoWmM4RzkwWG1Fd00wNnJTL0tLZ2ptZnNua3FnYmx3RFNoUGlkWWlVZXgr?=
 =?utf-8?B?NVdJYkk5TzJHZkxTMXg0S3dzcFRLUisvSkRDUjFUMjlKOXRzMDBsWktEbHAx?=
 =?utf-8?B?cWJwamR5NDRFVHdaY3g0MldVZm9NeFZseFZkWGxZVGpxTnRSRDIveGw3Nzhq?=
 =?utf-8?B?dlNrdUZjVEZHZ2ZIWHpQbWhzTXRTV1AvbVdvM1M2RGlVYTlQYzg5dFp3V0w1?=
 =?utf-8?B?L0lwSXlNcUxCd1Z6KzZEUHhiVi9XN3Bpa012TERvcVlSOTNydEJaVnRqblg3?=
 =?utf-8?B?UTgrdXdrYWsxOXZBQzFMVE9EaVMvM2pTczBkKzRWR3M0U0VDR2Zib1FlMlZ1?=
 =?utf-8?B?Umh5V2VidE5RRG5rWlJBdmxSNXhKcWZiV0M2M1dMWkdxYnhQRSs3Y0VHbk5r?=
 =?utf-8?B?TlNYKysrUFVsNlA3RWw3NWZ0VFMvbWRBN3QxZm1PVk12R2UxeVdCT09iMEhD?=
 =?utf-8?B?ZkpyaGpRazh4QlRFRC9oYWk4akVNN05WbUpWSFlsaE9UN21NR2s2NlZTeVQy?=
 =?utf-8?B?eEQ4RVBJVjJRZ1BzZ2IzVVcwS2cwOW00RFUwOHlSaGhDMFhGRFFWQlBMazhN?=
 =?utf-8?B?bDltYlNteGNmeUo4RHJjY2huUnN2ZHZKUG1TZUIxbVQxcG5pckVQU21Fbjhk?=
 =?utf-8?B?TWIxSnRqTmtSR0JBZUlwUExpQXFjOTZWNEFkUE9jUURsZDZ5NkxhbC9jU2hw?=
 =?utf-8?B?ZHFrVFh3RE1qakN4UHJXNmtjL3pVbElZaGlVUlp0NXpsSVJkQ1VnQ3VXSEdL?=
 =?utf-8?B?dGhtaE5WbzBEdjIxTVdoakVmb01YQXpDQ3daVEwrTUs5R0tyRCt1WkxhRVJR?=
 =?utf-8?Q?w2b/xUO/Uqoqairvu3rUzECpydipaE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:53:13.6393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c7dfac-9535-4bbd-300f-08dd4113e9ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8339
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

V3: (Lijo)
- move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 25 +++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 6b3656984957..cbba1d9e8367 100644
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
@@ -759,6 +780,8 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.wait_for_idle = jpeg_v4_0_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_5_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
-- 
2.25.1

