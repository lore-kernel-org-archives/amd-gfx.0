Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF29CCD1BB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 13:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B6910E79A;
	Wed, 22 Oct 2025 13:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zgtRD7jl";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013047.outbound.protection.outlook.com
 [40.107.201.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B2210E79C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 13:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWCOQoNh/7SvRObHcmgFttPw3CicAtRcinrKXTNBjlBwHEgoSILZ8xKnyzxWxkHYbH3uoFf+1TFupH0ewKqFEQb5PxYW0lT4GUEVOfJM2fO56EIOMIFxsiLnKU2iwr9O5P7mL27lqBs1eNMhzg77lLi3fMKcNonXniOTqYv4TqUaknfrFX8EogKMxMuDPi3ZPcMpXpnDPxvTswWTUZmo5U36ewTKt0BueBZZwA1qOCkra+o7EaF42qkxiqQdRQpvhb9D8lkXbO6B8IIY5xBhbBk9sCN/Wr+G9D5akqQcNgTCrMNuyOzPONGQrGPOpYb0WpdMBf6oEHzBHz2Vfpk0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07vR9z/Ah6YByDVLIvzATbcVCTCXXVb1tOZpbr180fs=;
 b=w40/PUQ5Uxu7HPxln/wixmcr5D6whgTxgNTFLGPRodIX19GdTHE1+lTCS9r3KOadwZLkDBvryQb+laElSd8EkyeYdc5hiEXLctpAc7pBAl97kLqiL1KCIU4iMjrleXZAnvfQvqdQbZiUTsSk94o1r4NaPCYZCwFr4Cp2IOEJTY6k4T2Nqu7c3kSG+l14eNzxFpFE5sxGBSsNjpTtYBITT6Yq0H5jmoJmNOb3stc+hvVeq8GkxdBnt8lswOnneHrTHsynWazJTGbUToaSMjyRyT0gfIzwDnLWt/ffJAEEiZTUiNoWiU75F9uxqKKr/9844GjwFBCURd54bnodQ5blfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07vR9z/Ah6YByDVLIvzATbcVCTCXXVb1tOZpbr180fs=;
 b=zgtRD7jlFOdwxZjPBIgCIyDJQW0dSAb2jk8srsHHyBNNdWtyPBvXdaoGgkXr/qsCN/2xWxwED1rmqtDU+6lnSj0pnQFncJq6zAjsUph/wItELaC1tcLGHQHKREnite0RTBr+fZUyL89lHeNCu5O0reR82F5H4GlXALMW1q6Sm34=
Received: from DS7PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:3b8::7) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:34:56 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::52) by DS7PR03CA0002.outlook.office365.com
 (2603:10b6:5:3b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.13 via Frontend Transport; Wed,
 22 Oct 2025 13:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 13:34:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Oct 2025 06:34:45 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH] drm/amdgpu: Fix pointer casts when reading dynamic region
 sizes
Date: Wed, 22 Oct 2025 19:04:25 +0530
Message-ID: <20251022133425.245953-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 26be7a23-856a-4d6e-d7ac-08de116fc926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZmlTN1J3Y0xya04zckx5MkxPNTZndDhFeHNKN2lFT2JvN01MU25yTGlEWW93?=
 =?utf-8?B?blRYR29RK1ZudG94Rkw5U0UrUG5BREQ2OVRiNGZ3MDYvYmR0N2k2TWJiVzB5?=
 =?utf-8?B?K25QQ3VuRCtIL3FoeU5xUXBUbHB4N0l1RllGTVBTcXFGOVBaSEVFbjZDcG0x?=
 =?utf-8?B?NFZPRGJVRUMwamgySHFIQmkyNFVtL0V4Uno0cmhrUTBnY21FbzBCdkY2Sm1Z?=
 =?utf-8?B?bnVyTldXVWJhQ0ZNd3h1K3B1bHN0ZWpkcTFCMVVCcVQ2U1JYUUtNUFVWVGVK?=
 =?utf-8?B?Z2lseUJycExlOVhRV2lZb295aHlReGVZU1MwYTl1NW1OVWdaQTNiSXhIMjNG?=
 =?utf-8?B?UXNRUDZUWm1KVmhMakg0elg3TEZ3ZlRnTy9FcmpJWHlaMUlESlZ3WXVldjBU?=
 =?utf-8?B?dWRDMHgxRGM4THdwb21tV0FBVVl2SG9LdEY4Z0g3S05ySEFUMjN0RXZlMlBC?=
 =?utf-8?B?WmhNVitmbW90V09VQkMxN295YzNtQUNodVQxZnF1NElDaUloTXg2b0o1Zjh4?=
 =?utf-8?B?OXNSMHJjN0VCaFRBS203Q1ZOeGJST1hTd1ZkbklUZS9Kdm04VklCSUJzdVpq?=
 =?utf-8?B?UnRWS3JQS292ZmxPamlLSGlwM0VUUU45ZDJla3kwS1VrT0lGMGZab2VFU1do?=
 =?utf-8?B?RUQ3bi9sWEdSQWRLaTZwOWhWbTZtV3hoNTVOWVRSaGV2MDRET0lva1djSnll?=
 =?utf-8?B?ZW8zYTFUNmdCY0RjdkhhQ3QyVmV1bWlscXZLWVNxS1ZTTWEvM3FkblI2bzF2?=
 =?utf-8?B?R0d5OWpwc000NHpZYmY4MDg3ejhaVEdxbkJuS25XdS9JNG9NZVpWTGRUNFVR?=
 =?utf-8?B?bEV5NUw5bkpqcEhJeW1RZFowcnNYM3lRM3gydjhMa0lZT3p0OXZrV0prNS9o?=
 =?utf-8?B?NGw5QkJqUTZncWRtdmc0QWtIU3lsNmpUejRIaTZOdkVxRU16NE1ySHFmak5a?=
 =?utf-8?B?SXlEK3RFbUY2YXJ0QVhpa0hxSU9PSC9OMXJKUzdXMFlCTFdhRnRGcHNGSkEr?=
 =?utf-8?B?eVBQSzJtclNqYUV6NUJLbXkra1dpNVpnMjR1aERuMVFCZmJCb0EvV2JzemtC?=
 =?utf-8?B?QjR4eWlhVEtHVEZiaVY1a0sva25mWnkvZm9NOFNqUTBMYS9NbDNHSTFWQVpU?=
 =?utf-8?B?QU0rVlh0d2k0REo1dWtaSFh6YjZuYzlKblVmc3h4T1NKNTdLV1FjajlOS1Vi?=
 =?utf-8?B?NnNXS1FEUzJzK2xvbUlVUlZXTzdWb1V6WDA1dmpvN1k0ZWx6cEljWU5TVjFD?=
 =?utf-8?B?NjRKV053VkRKeHFJM0lNRUJTMmViQkZFZ3FKQSswL3dZcm5Na2xaT2dsUTB3?=
 =?utf-8?B?M2ZCVlN4a3VQYnNqb2tucnZLODJEU3VrNnFIdC9hMGluUUpGenErWmFFN0Ns?=
 =?utf-8?B?bzV3eDNNQXBxbmIrV0hvK01BdnBITi9sM3A5SlBmd3dYa2ZkbmV0MXZhOGZS?=
 =?utf-8?B?TmRRTDg3Ly93ajhtV29ML3kvakk5VERDWVZNamxkUHZDc1NkcjhQbDEzYUpn?=
 =?utf-8?B?OG9iaG43SG80QnA2NjNzNWJpeFB3cTBwbi8zVnowV1d3Y09weVUvN3dod2Jp?=
 =?utf-8?B?dU9xZDlONGhqeFpGVnpXcFdjb1lPc1RqdWJheTdSUDJ1ak1jNVhUUk5waHNC?=
 =?utf-8?B?ZGc5WnBSbThwNEZWVm12cHBOSEp5SFFMeTNnUGVDV2NQSUgvcWZValltZ05F?=
 =?utf-8?B?eTF0SXA2MU5mem5PQXNTeko3ZWJBZjQzWEU5NHdSY0JDZXRRdXhnQnJ2NGlC?=
 =?utf-8?B?N0d6UVpMWE4rUENrTkdkalVueU81MUNnN1hWSGd4ZWlSeGlBWDVna3JDejR0?=
 =?utf-8?B?UGFXeE1BR21CNWd1bmVsUkdWVHZON3BhTk94VGgyS21PcWIrbWdKb09yQStz?=
 =?utf-8?B?cVFMbzNrNjc2S0Y3TlJLODR6N1pkV2dmM25JaFNoU0lXcmpQeWh4eHB6Slhq?=
 =?utf-8?B?cDFMWXViaHpFLytOdk45V3pxWHgrWHQyWFFLRmJzamVMK0ZDQXVPMC85TkND?=
 =?utf-8?B?Z2dXWUhTdXN2bXBpZmpVWVZlRVVVNFFyT1JwSTFpSzhFUUJVWDZiWTRKemFp?=
 =?utf-8?B?R2dlK29veXNLb2dkSUF5aDNWbUpCc0xlTlhlNEJETmtmY0FxNXhpUHJ3SEx0?=
 =?utf-8?Q?36NQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:34:54.6255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26be7a23-856a-4d6e-d7ac-08de116fc926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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

The function amdgpu_virt_get_dynamic_data_info() writes a 64-bit size
value.  In two places (amdgpu_bios.c and amdgpu_discovery.c), the code
passed the address of a smaller variable by casting it to u64 *, which
is unsafe.

This could make the function write more bytes than the smaller variable
can hold, possibly overwriting nearby memory.  Reported by static
analysis tools.

Fix it by using a local u64 variable (tmp_size) to store the size, then
assign it to the smaller destination field.

Fixes: ae92010fb321 ("drm/amdgpu: Add logic for VF ipd and VF bios to init from dynamic crit_region offsets")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ellen Pan <yunru.pan@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index db705bf723f1..eb7ba7c593bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -104,6 +104,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 	uint8_t __iomem *bios = NULL;
 	resource_size_t vram_base;
 	resource_size_t size = 256 * 1024; /* ??? */
+	u64 tmp_size = 0;
 
 	if (!(adev->flags & AMD_IS_APU))
 		if (amdgpu_device_need_post(adev))
@@ -126,10 +127,11 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 	 */
 	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
 		if (amdgpu_virt_get_dynamic_data_info(adev,
-				AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, (uint64_t *)&size)) {
+				AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID, adev->bios, &tmp_size)) {
 			amdgpu_bios_release(adev);
 			return false;
 		}
+		adev->bios_size = (resource_size_t)tmp_size;
 	} else {
 		bios = ioremap_wc(vram_base, size);
 		if (!bios) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a7cb4665f485..87f024f72a59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -275,6 +275,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	uint64_t vram_size;
 	int i, ret = 0;
 	u32 msg;
+	u64 tmp_size = 0;
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/* It can take up to two second for IFWI init to complete on some dGPUs,
@@ -311,12 +312,13 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 			 */
 			if (amdgpu_virt_get_dynamic_data_info(adev,
 						AMD_SRIOV_MSG_IPD_TABLE_ID, binary,
-						(uint64_t *)&adev->discovery.size)) {
+						&tmp_size)) {
 				dev_err(adev->dev,
 						"failed to read discovery info from dynamic critical region.");
 				ret = -EINVAL;
 				goto exit;
 			}
+			adev->discovery.size = (u32)tmp_size;
 		} else {
 			uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 
-- 
2.34.1

