Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0811FC02190
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA4D10E91C;
	Thu, 30 Jan 2025 09:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oz2FJAWh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D553910E91C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM/anPxCmSs43lEydbUkvc+CmztIiCQls0LQUCMQwPFzTMUc4FcEAJPIBeANgAJSU4zg3Y/Pr1cAWkPk6ZfcEuAzncfrCInGzXNrYuJE0/cMdHC5osqZn8dJwHS9q1S6RF70wZHibA+e6p/fVFZm8TcKv3u2anOfjkYAuG+lE2VucdfAxM6/q2TY8Bu/Pv1FWLk2h0+JOTrUUackHu1SCsuagpfP8K4KWQ5mHgAgNdaKwoPmTKStUePFYUp87OMVUdB7PMoO5mV/33dK2QFmp/DOtSgQsqqarProvscIn6+QZ7Rewpp5zpOWeOVQ28q1odpDDSyp7pPSBnlyAOM8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebm106m/l7h3eh9xWzLKXXdBnJPcuaRqyNpRS2XGJyQ=;
 b=uKWzVxsFMO/fbzTA18/jawKev5ySbNdyQzdEBWLbMaLbzYnqDgnDuOpgqmhmPC7/2vGsfRdgagO9srVEy+ofypAkOnPAnz16BdOLyJFxrUIu8kTV6WYiBTEMSQkzsqC2ef/pr+Ta+pEoWy0ccDsFTedj9ehA8dh30Mj7wL92MkhSsi6Lm4DdhGyOanVGSDivRSWUJ5oquArHpQv5Ba6W7uld47JpBm3PKHFV2TiZ/iN4HQZ4yNbP5wohdG/qImPgI1zMu1PBq2JY6l9e1T9dq1uOV5BXcV26aZmQT3/lGD/XYYXgZUTep3rtWK/lXgYCssGmwN3da5nZZNQtAW/Zvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebm106m/l7h3eh9xWzLKXXdBnJPcuaRqyNpRS2XGJyQ=;
 b=Oz2FJAWhoedKUlSgJpC9yyWK92abj+H3XKnqhfvXy93qyNPsLz3Al6GLQLGgU6fUdKyj+aWl7UcanAtyjYBUR4OktMTUNkK5vwj38ufDLwwIVUgiIo7ETv0NNNxCahfjM7XuuFVnSRkkKOI+u9zFxrSed8pkBUcLIqAGG52UhOk=
Received: from BY3PR10CA0009.namprd10.prod.outlook.com (2603:10b6:a03:255::14)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Thu, 30 Jan
 2025 09:54:01 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::ff) by BY3PR10CA0009.outlook.office365.com
 (2603:10b6:a03:255::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 09:54:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:54:01 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:53:59 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 09/10] drm/amdgpu: Enable devcoredump for JPEG2_5_0
Date: Thu, 30 Jan 2025 15:21:12 +0530
Message-ID: <20250130095113.534630-10-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: e50e8a19-4cb7-4ac8-5c2b-08dd41140629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGFIRDAyZi80OFhxdXE1V2FlQVYrLzhSMndFZ29DMFJxNWRlQ293a0p6S0lT?=
 =?utf-8?B?Um1TcEJva0thMHByRkJ1YWZrN1FUckUrTnNnQllkaGFFRzBnd3pFMGdFZzNO?=
 =?utf-8?B?alV4d2FSdW9hMzIzamxBTGtON3RZS2RJSVdmMVE5OUtZN3E3YjBQQVVPWExa?=
 =?utf-8?B?QWFOa3VkMU44bitGaVVnc3JaRXpFTG82bWkxeldrUmFoU0JOTkpQSHJDaFRF?=
 =?utf-8?B?S2NSLzJFMzdBWDBvd0oxNWoxY2Q3akp5b25wZ05CNk54UXB5UDFzV1hQMC8r?=
 =?utf-8?B?Z1g2NEtWRU83dy9EQTA1aWYrcTJGUm5McmZ0Rm80ZEFJY0dVbGZnN1pTcFVP?=
 =?utf-8?B?eFhOZ2gxTG5zM2lCNEVSQkN6WnpTVVdVMkgvbEh6ZmVJaEpmWHpVam81dmph?=
 =?utf-8?B?OC9iTlZTSys2VitOT0hmWmJ2cnBLTWg1Tis1Wnl4Ynd4bDZVUVZiZHlIdWNC?=
 =?utf-8?B?L2NrdmJWeUpNMlNJc01wMGd0d1krMFUwVTYxSGFWdnExekwyb25jak9xbWhY?=
 =?utf-8?B?enFHTVdSYTYwZ1pvNVZYK3ZLU29JZWJTdVp5bHRCdzVwRWFSTmhnc0huUXNE?=
 =?utf-8?B?MlR6bHVsVm14Tjg3ZUdQTVJybVR2dzNOV0ZrRTA1NFlmUXllTnVYK2ZsWmJV?=
 =?utf-8?B?UE52dE1CaGVPeHkzODdidGxOdktRMkJHSkVvd2ZldDBwNXlqdFhlVERSQWFE?=
 =?utf-8?B?dHNYUU1VUkRtbk9KWmVNamk0b3JOZVJlazZNM25QVHUyV1JWQ3J5cGdDRWd1?=
 =?utf-8?B?NTUycFdsN2VJbDRRMm9sRDNsSUNTcklISzRSdjNBd1dKYllVWDFJWmpxZXVB?=
 =?utf-8?B?N0J4U1lCM1RXdTBnZUk5NUc5MHZhbzd5Y1RKbS9CNGE2c2ZPTXRVa2RiZEVu?=
 =?utf-8?B?VDZSMXNJREI2YWIwVUd0b09OWlJ5RGhkMGVIQ09oaW5aYnF4Z2FScTRHcnlt?=
 =?utf-8?B?S1VLUE1UckQ2dDFlUDlLNDdLQWZpaXpudWgzZUZGNHlwZnVRZmxUOWNJRnh5?=
 =?utf-8?B?NkxIUWp4ditlblU3dDBGS3VMMGxUZTJzQlhpZVB4NzlZZkI0bGxBMEZCRTdZ?=
 =?utf-8?B?SnJMK1RKR0lJUmI1MGVPeXAxVWtlNWhQbmpUQjR1OHZMb1RzT090NkFkTGUz?=
 =?utf-8?B?eURzU3p0ZEp5MVFPMnFQSm1GV2FlVUltR2FvdjlvWGxyTHRUYVNJbVlyd2dt?=
 =?utf-8?B?aHpRMW92V0p2clViZDM3RUcxZHErZ011TWpkeCtUNXZhKzQxeVhpOXlNTVNj?=
 =?utf-8?B?MzRXZnJVL1pVQUsyZlNMQ1kvS3N0SVdyLzAvVVBGNWdYRkt0VGRGc2ZrY2sr?=
 =?utf-8?B?SkxaSWFxYzQzRFl0cFByTkxoVnJCM3BuUWZKWU5OUWxtcFN2ajVzemsyb0U3?=
 =?utf-8?B?Tk5ZRXdoQUVIYitJeGYrK3Z0STVYTHd4N3NDRDNsK1pmbTdUWFJJUzhwaWtC?=
 =?utf-8?B?bGtBK040NXBsQ2t1MkVibGhIaCtyUVRLOEFucHRETmFhMG0vNWQ5bTVxbExw?=
 =?utf-8?B?cGx5eUxZSXVhVmF4N1NZMmswMkhjZDBiQVQvOW9MMUV6dFdQNXl4VGFpcGJw?=
 =?utf-8?B?NkVOK1dNeVNxNnFHY09qZEQzWEE4RVZFUWZuZUc3YlRBVERFS3JNSWQwSXQ2?=
 =?utf-8?B?MFB0Y3pJMDFxb1hVbXBoMFI0aExxMVdXdWJvZVBlbkFwUGZJYUFaWmZseFVO?=
 =?utf-8?B?OXdGTkd5SWNlcE1LZWIraWdpenMrb0xtNVhYbklzekxhemkvRjNGc2hGcVNa?=
 =?utf-8?B?ZTNNMFpBM1pZRTE4ampYVDErQzJLWXBhTVpjZUFYY0ZqcUxZQWJrL2xuRitZ?=
 =?utf-8?B?WVplNFI4K2orbUU1VkpzZUhBNWgrSTBqN3VscTZ4a0NKQWRmYUFXZCtzMUYz?=
 =?utf-8?B?Nnk0aTY5NEpUT1RzLzF1TjR2WVI1Rkc4bmlKc0lsdFFiUkZZWHUxSGF1S1dq?=
 =?utf-8?B?Qk9DZUxNR2o5bmlKOURpS0o3UnlCT3k1N2tLL2xieWw0R3g5Nk9qbUJQUXZX?=
 =?utf-8?B?NVRxdllYblFRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:54:01.3441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50e8a19-4cb7-4ac8-5c2b-08dd41140629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
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

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

V3: (Lijo)
- move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 11f6af2646e7..b19724928ce4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -36,6 +36,22 @@
 
 #define JPEG25_MAX_HW_INSTANCES_ARCTURUS			2
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_2_5[] = {
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
 static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v2_5_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -147,6 +163,10 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_2_5, ARRAY_SIZE(jpeg_reg_list_2_5));
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -623,6 +643,8 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.wait_for_idle = jpeg_v2_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
@@ -638,6 +660,8 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 	.wait_for_idle = jpeg_v2_5_wait_for_idle,
 	.set_clockgating_state = jpeg_v2_5_set_clockgating_state,
 	.set_powergating_state = jpeg_v2_5_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v2_5_dec_ring_vm_funcs = {
-- 
2.25.1

