Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF96DD3ABCE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 16:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F13210E1FD;
	Mon, 11 Nov 2024 16:42:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sDUaggDF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9270A10E12B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 16:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJjanVYfpOQ/ODrhzyYVd++3MCYVJKbo++piMmTZhJQXF5+5w5ba14ijdAa9is7wgbpy7z8iO2ZQcTpSvVpEnlaa3lXyN7yW6Fs21fOc2vT0vXLGP10lHeM0rplA1Mg1NHnl90xbAugBTsctN82RUWNBl3DIeHCyKsWWp/UPDgwijE1GJIdQlz97mQnSy9cOEKDCdVwsJewqSFDYWEC7EFmaDTPyRT0R2I0oWPh8WlZhCqW/u8+vHIDkp/u2CHEtQUTS/uZpzfYCuF+jYZeXWcLZgUWVx77bV8xUY2Hnq2tKzf7mB0Q9FM4PJ7bmv3j2g2MZuajGziSeJCmpCRbtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV9ZokVraEz1inGzr6b7r6/6ROyLnUjg4zovLmNzYFE=;
 b=SnXimxZqcnkokPPrHRZdQLg6gw/rFUMQIytta+KEqgpT6zRmpKaRHs0UOX/0/f78uxkzeJNusUpsmwEmSQ2hRtwnEoMDrYjEM8vFKScO29K4YkEx865RIsgD4vbZqxERCaO897BPvqgajYXZi5hJxMCh7wOGdVCDc5733idN9KaLsZifqObBz45VdTCqXvpYu5xFUITg5F4L8e06NPptrFanz0eqlERnQuG/3gkhJ0fJ/8zjgQOA0kqz+3P5I+mqoNtrUB11u/OiqpEcas3uh1T61kdt/65LTM4b23qovKPoyWq6RDXYqWdrijNJo/snt9M0pQHMWdbRNeGG1rYYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV9ZokVraEz1inGzr6b7r6/6ROyLnUjg4zovLmNzYFE=;
 b=sDUaggDFtUulY4xlON2WeaaF35HcvGRJfc9xaRD4t3iZpHnbjHvuoYwfoKeKw9WWdX/u0qwGXDQFMl8olSfMlpZNBMX1zo94H25fvskuNXWsf0wG/pN4lXY7oextzNgMpGi+BjiEWxPy1mCeWDAMbqLLYB9AE19O6LluAMTwI8I=
Received: from SJ0PR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:332::10)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Mon, 11 Nov
 2024 16:42:02 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::17) by SJ0PR05CA0065.outlook.office365.com
 (2603:10b6:a03:332::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Mon, 11 Nov 2024 16:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 16:42:01 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 11 Nov 2024 10:41:58 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add a func for core specific reg offset
Date: Mon, 11 Nov 2024 22:11:25 +0530
Message-ID: <20241111164126.2195380-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d77334-7027-4ed8-901a-08dd026fc443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWRXY00raVZjSERuZGx6S3BkbnZFUkZtdW5kUHRiVnZpL0IxSFQ4emthSzda?=
 =?utf-8?B?R05WUmRPUUtBYXV2QzNuVThzbmdTY0YxY3oyQnpkZDBuc0pBdEpBZmVXREEz?=
 =?utf-8?B?MXl4SlZ5eFEzTWtXRmVibjRFMlE3ZXhLZXdkbDBtNlRxSVlUU29URHpIZDE2?=
 =?utf-8?B?UEJ4ZXJPTmtHQlZFek5kUmxtdjFaZHhBNE9VRnVxSFVsUXQzTldYVEZhdnFT?=
 =?utf-8?B?YVhYb0FTQnFTQnVYTXNaVlcyeTlnMlZUbFVTc0t5dzMyaU90eDRwTEltNWxI?=
 =?utf-8?B?QXFqaHZvbldEamtLQzhuRXNISnNUQWdsL2VyUzR5MUZkamNQbnJkeXB1ZHlL?=
 =?utf-8?B?VElxYTlNaTZRWEkvM2dYZGJMN3RlRWdRY3hCakpIaHZLYkVmZGF6THRLdmNB?=
 =?utf-8?B?UlM4NUpFU3g5VHc3SEJneE8wbVViTHlXTGdmaFhLM3ZRQ1Fod0R2YXljSUc0?=
 =?utf-8?B?elprT3R0Y1NrWmFlNlBicVRRV3BaRlFwT3hqZUhHQ1ZZRUt1eGRQQmJmZnkw?=
 =?utf-8?B?Z0U5Nk5GdUs2S2VYelBXN1ZXK1FiNHFWbGE4eW5JZVFPS3ZLQm1mUzdPQlVl?=
 =?utf-8?B?TEUyZW9qRXBGaE1LL09QRStwY2dzSHRFUkpxdGtyU21Qbi9NL3k2UmNieklG?=
 =?utf-8?B?SXNROEZwc0R0Z3hWOVAxN0RhV0pGVEFjeVpXeURmQkVQZTR1Qkk4MHl3Ty9U?=
 =?utf-8?B?YnlCUi9yQmM2WFFPVklNbGt3WEQyTVc4ci94cHlIeFRMZWdIQVVxbURDZzVD?=
 =?utf-8?B?OHRRVFg0NEcrYWtBbm53SXFBRnREcTJZZngrMS9YeUdxUXdoT0NGcWJoclRu?=
 =?utf-8?B?TXVtTEpoL3E0bFY4aCtpRU03dnFLMGVPQWs2OWZyWWFSWGg5dlZHZGE5SGZZ?=
 =?utf-8?B?OCsvTDFlTlRvamI2WHBxN05EYkhOUU50dzZIbXl0bEpiVWZwYVZodHNzdExD?=
 =?utf-8?B?OGdTb21NVGFzWW1jb1kyQU9HWWhQY01EbStrYzV0KzdEWXEveXpQZWVsTVZq?=
 =?utf-8?B?Wm52cTNtL3IrSXR5ZmxTa0JLdU56T085eVk0Ui9GRVduUjRSSXp5R3FQWHRk?=
 =?utf-8?B?eGkvTUxCNnRXYlNIWWtnV1RzTWhYTU1PRHNGSU5TRVNIcXZocGJKSDhDZWZq?=
 =?utf-8?B?cjZxcGhPdmNpeGtxTmlmcnZkQ3RBbzFKZGVuamhxc3ZoNktid2RKSTlIZmZr?=
 =?utf-8?B?UlVFcHk3S3FoL2ZFTmYwQUpTMkJiYnlSMHBvaFlmWUtsdlhyQVNiM3hrQWNQ?=
 =?utf-8?B?WGtLbXYxa0N4cEQ1M3g1Z0s1cGtTNjdhbmZsSkVaejlscXlwNlNZcmRudnJw?=
 =?utf-8?B?R1Q1RFUzdWpFQnpVclhzRXk0Zkl3MWFtNXZSb29oT1VsVUEwakphRzVkV2Fm?=
 =?utf-8?B?Nzc0TlNRcnMwYmw5SFdvN092MzdzY1N0Yk93V1lwOGtRZXFoL2VuRytQVUtx?=
 =?utf-8?B?ZHZuQUJNK2l6MWJLOGNPT0V6Rm5ZMEczbjRDM0s1RnN0Y1F5UTc5c3AyY1la?=
 =?utf-8?B?MUQ0UjNFcEQ5c1Y4YUErelFhd0FtcTVzU1VwTnJXL0VLVmxlVGJlcGdKd1dL?=
 =?utf-8?B?UGFPVGw4SWlnbWx5WGo4dXJTS0FTRCtiM2drWnl6bVZxZ0IwSVpkWHVSYU5i?=
 =?utf-8?B?NCtOUUN4YVlhNGUxUkt6d2ozamJPMzNTQUw0SFlKc1hQWWJiYWd6UTIyN0U3?=
 =?utf-8?B?Rit6ZUJiWkxoK2pLLy9JemkxSVVTSzROREUvRHBNNk9HZDZJdE1jcG4rS0hF?=
 =?utf-8?B?YWlHV2ZoNzc2Z20yTGRvMW91NTk4UHRHMzM1OVc3aXY3NXJXS3ZFc2g0Rk5T?=
 =?utf-8?B?aU5ZWmZrcUZBamZ1WmNyaTBNeWJrN0xjT1RlM1JsWC9CZmhDWlQ1M1JHNWc4?=
 =?utf-8?B?cUt5TUxrejZldmNuZUZBN2lrczNtSWR2Qkw5blRrei9ZeVE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 16:42:01.1990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d77334-7027-4ed8-901a-08dd026fc443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538
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

Add an inline function to calculate core specific register offsets for
JPEG v4.0.3 and reuse it, makes code more readable and easier to align.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 54 +++++++++++-------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index fd040b9cc93e..5c1f288fc119 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -65,6 +65,14 @@ static inline bool jpeg_v4_0_3_normalizn_reqd(struct amdgpu_device *adev)
 	       (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4));
 }
 
+static inline int jpeg_v4_0_3_core_reg_offset(u32 pipe)
+{
+	if (pipe)
+		return ((0x40 * pipe) - 0xc80);
+	else
+		return 0;
+}
+
 /**
  * jpeg_v4_0_3_early_init - set function pointers
  *
@@ -144,10 +152,8 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->jpeg.internal.jpeg_pitch[j] =
 				regUVD_JRBC0_UVD_JRBC_SCRATCH0_INTERNAL_OFFSET;
 			adev->jpeg.inst[i].external.jpeg_pitch[j] =
-				SOC15_REG_OFFSET1(
-					JPEG, jpeg_inst,
-					regUVD_JRBC0_UVD_JRBC_SCRATCH0,
-					(j ? (0x40 * j - 0xc80) : 0));
+				SOC15_REG_OFFSET1(JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_SCRATCH0,
+						  jpeg_v4_0_3_core_reg_offset(j));
 		}
 	}
 
@@ -517,7 +523,7 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
 			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
 
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
+			int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
 
 			ring = &adev->jpeg.inst[i].ring_dec[j];
 
@@ -612,9 +618,8 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return RREG32_SOC15_OFFSET(
-		JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_RPTR,
-		ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_RPTR,
+				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
 }
 
 /**
@@ -630,11 +635,9 @@ static uint64_t jpeg_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 
 	if (ring->use_doorbell)
 		return adev->wb.wb[ring->wptr_offs];
-	else
-		return RREG32_SOC15_OFFSET(
-			JPEG, GET_INST(JPEG, ring->me),
-			regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-			ring->pipe ? (0x40 * ring->pipe - 0xc80) : 0);
+
+	return RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+				   jpeg_v4_0_3_core_reg_offset(ring->pipe));
 }
 
 static void jpeg_v4_0_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
@@ -659,10 +662,8 @@ static void jpeg_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
-		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me),
-				    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-				    (ring->pipe ? (0x40 * ring->pipe - 0xc80) :
-						  0),
+		WREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, ring->me), regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+				    jpeg_v4_0_3_core_reg_offset(ring->pipe),
 				    lower_32_bits(ring->wptr));
 	}
 }
@@ -915,13 +916,9 @@ static bool jpeg_v4_0_3_is_idle(void *handle)
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
-
-			ret &= ((RREG32_SOC15_OFFSET(
-					 JPEG, GET_INST(JPEG, i),
-					 regUVD_JRBC0_UVD_JRBC_STATUS,
-					 reg_offset) &
-				 UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+			ret &= ((RREG32_SOC15_OFFSET(JPEG, GET_INST(JPEG, i),
+				regUVD_JRBC0_UVD_JRBC_STATUS, jpeg_v4_0_3_core_reg_offset(j)) &
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
 				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
 		}
 	}
@@ -937,13 +934,10 @@ static int jpeg_v4_0_3_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			unsigned int reg_offset = (j?(0x40 * j - 0xc80):0);
-
-			ret &= SOC15_WAIT_ON_RREG_OFFSET(
-				JPEG, GET_INST(JPEG, i),
-				regUVD_JRBC0_UVD_JRBC_STATUS, reg_offset,
+			ret &= (SOC15_WAIT_ON_RREG_OFFSET(JPEG, GET_INST(JPEG, i),
+				regUVD_JRBC0_UVD_JRBC_STATUS, jpeg_v4_0_3_core_reg_offset(j),
 				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
-				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK);
+				UVD_JRBC0_UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
 		}
 	}
 	return ret;
-- 
2.25.1

