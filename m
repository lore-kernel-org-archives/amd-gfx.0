Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92129C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 15:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E86A113C11;
	Wed, 24 Apr 2024 15:29:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vab7Mpv0";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE28113C13
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 15:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmZbPktDf5nDJCUr8fC70ROfrGCkqKMwPQV+SYy1FzlpSZwj3FTK0kIlW0Aftqi9AL0x1HAYP9hin465SMw9J2ALbxVmUDtPdkGQTjmcRa9OLR9H3DgtAskQ54jn0LZnq3PFvEjvjdQOzr1/9NIt+FaKnqlBd0ivMJtfwX6uuasIYLmtQfScbu5VqysrVr5wach5tga5l+t0258GihRnEK0rDSllQ2lFtTDPpgbGPe0gECqXXqGtUvdWNkQsdXP/zjJGGE514pMnvEhgwc8gEGyEw7pVlmPZ/KQQxluiRupG5wGA5NbAGhUuCacSjkzywRlxz9okXlaHMHMh1H+AMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifc1k03xgK7eBL6WknLZ1NYMq9FcfDzrx3KqE1dh9l8=;
 b=akE5WUt6w8M1K8Sh1nbc5Gla6POmGdtbmmUft3ZSxJRAAcD4rbrg7//henHxFAOpLpVkdbRDENdaGRMV1vbYHqWd+P2TMqDtZHg6r0RQrHVoEcupy37a6NqTXTtI+4tk20I9cA46ZWm+YpUbXT15SEyDP8/sKD4gE7rpyGlE7ujGqxBkZlK9zbcLQ7IcqJJ9FTpI6Nt9iu/LAN7+z7kRQswA/5V8jnyHF2ov3xQTvNkPX2Jjo0MrTJKeh15gO+dLIQFDiaapKnTzqlxUYbgrn/8NGTaF/J8bvi+TrCzuDM1b6BHovj3oIbs+U32eNAF2KbDKjrSfaP5NH09cxr3c4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifc1k03xgK7eBL6WknLZ1NYMq9FcfDzrx3KqE1dh9l8=;
 b=vab7Mpv04JbyhtroSkGCevK3JNAZHXmMJAYcupvHOFaet8iT9v1kTgV2Y17hwc7aXNQ6cHYhV1VkG958U1SREj7peYVTSB0mX9ZZ/Y32dH2chDWSKiC/aEuEE2cpU9lm/Dc4uaUALD26KexvGxLPkTd1gxSm/ODx7sjbAvObtvo=
Received: from BY5PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:180::38)
 by CH2PR12MB4229.namprd12.prod.outlook.com (2603:10b6:610:a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:29:31 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::7f) by BY5PR13CA0025.outlook.office365.com
 (2603:10b6:a03:180::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24 via Frontend
 Transport; Wed, 24 Apr 2024 15:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:29:30 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:29:28 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <Arunpravin.PaneerSelvam@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v6 2/5] drm/amdgpu: Handle sg size limit for contiguous
 allocation
Date: Wed, 24 Apr 2024 11:27:46 -0400
Message-ID: <20240424152814.9608-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240424152814.9608-1-Philip.Yang@amd.com>
References: <20240424152814.9608-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH2PR12MB4229:EE_
X-MS-Office365-Filtering-Correlation-Id: 176a5f14-f3e8-4a95-ea4c-08dc64735616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkdKUW1WWVFDVm1xTG9JVjllSUhwQTVERWZoT0wydmE5NUQwNy91OGxpNGx4?=
 =?utf-8?B?eXdJVzVWNU5ZTmFINHAzaFVlY2lKTFJiaVo1YWJGN0pOeUFFcklObnVoUTIx?=
 =?utf-8?B?WWROc3lHRkpPRFBick1nN2FJYVJZZUVWTVZWTWxud2VpVEJScTNIU3JwRVJ0?=
 =?utf-8?B?amZiYVVtdW16ZkVIWE5wVTB5S3pnSitFcWlFdCt2WDZwNWZlVGNuS24zM1Ja?=
 =?utf-8?B?dGdyTHA1ckY1cUE0SHZHSTAwQll4WGZvd2w0ZnBIa2FwekFDZ0VkcjRzZ2x6?=
 =?utf-8?B?eDh3Wkx4UUk2WW9aV3dGZWN3WlBTMDBVTGlGa3J1Z0x4STh1L3dPT1ZNZ2xk?=
 =?utf-8?B?V2J3NVdqTC9RZytXTEc3Smc2UWJGdmlxcDFmSk5TRDU2S0dkdHRCS1M1MUta?=
 =?utf-8?B?U0FKaWNGMTlic0xlM214Mmc1UTZBM3NMT1gxN3lLR2NmWEwvY2ZNcnJXazJ4?=
 =?utf-8?B?N1pqN284cVNFTk1udWg3SEcrajY4ZTBGS0F5ZXM2M1ZtWHcrZUthQnJMdmZy?=
 =?utf-8?B?WGNqVStZMXB5bS8rNEc3Z1RyZzBHYyt2NVNWT3poRlY5Z21yOVpPNlM1ZHlO?=
 =?utf-8?B?RU9ZR2docEhaMmI0b0F6a01DYjNzNjg1RkJ4dGMySTQ0NzNSaEpiVWExWldQ?=
 =?utf-8?B?VVk5WFhwUThDR0pLVmVJWFZtRzZod0ZQTFRXUEdIUWo5UW93RGNzY2JOWjhi?=
 =?utf-8?B?bHpERytZc1Nldk9tOFY4NGt4bnlaZWhmck5pMzgraTJWSkx5eGpQcHFtK2J3?=
 =?utf-8?B?NVlPK0t6clFzejZaNlpHM3BtQldIVWprd0pjcTN3TE12SFVjQlF5U0hXOXls?=
 =?utf-8?B?aHBRK1dhVFlmM3FZNHN1aUo3a1dWa1U1NEFhY3MzblpKbE43aWpNWEc1YVNn?=
 =?utf-8?B?d2JHUjU5R3UvWGZJTkdKTXo3aUx6NU1ZUk9xbWxoekVyUXV4MFZnbytEaG4r?=
 =?utf-8?B?L3M2TDgvdXllcEFXZ3Btb3BlZVMyNGpBaFhiNDJaNm9kbEU2dDYvOVBpOC90?=
 =?utf-8?B?TnNxbWJIZUdaZGw3Ym1ybFNoMyttdGZFRjJlQnZjOU1YMFJmckJVdEJRaUxQ?=
 =?utf-8?B?ZS9oNWFvaXVoUlcrTFhQR2pacWo1VWtmZmhLRlBDR1VPaDdhQXJ6dXVmcGY3?=
 =?utf-8?B?YW5LQXFtd2hUbm1SbWNzY1VuUlFnVzZaTzVndXBCOThsRzBEelEvMTdiMUJj?=
 =?utf-8?B?RkROaFlpbUNTMzNUcWJEVkZIaXFYTTM2SURZeXBWdzFTdFNXeXFhcG1YVGk4?=
 =?utf-8?B?aXdDVXNFamlKQmU5OXdjK3ZvMnV6UDl0THJHM1RncmhXNGUvTGhPeTlERTlr?=
 =?utf-8?B?TW1pSWFOZU11KzZBTTlOYjNaUTlWY2kxbVZWalNtWG1wbEFkc2s4dUs0aEF3?=
 =?utf-8?B?cXg5NmJ6QWhPMlNHR1JXSzNBdHV2bWNEWWtlSHI4aGNteUhkc3NYWm1CVW9r?=
 =?utf-8?B?YzVUcnZOUkU5YTVLWUVzU1hXdS92aWVwUmtCcEtLZ1VFUDM2ZlNVeFpiNVU1?=
 =?utf-8?B?RmhSZklORmpFNGlEUFZZNU53T1Y5bzRWaEk4N2YzQ2dKUENleDVHc2I2TDR0?=
 =?utf-8?B?RXcxUHV1NmV2L1d4WTBiTnBOR2pIbitXWGszdDA1NXBTSmhXaHozM0x3ZVZZ?=
 =?utf-8?B?Y1ovZVZ0UkhacXdoeUZoUnQxdDZ5WWZRck03Zkxlc0MvTGl5TzVPRkxDUzZC?=
 =?utf-8?B?TUtUaGFVRkp3dFVLaUdtZ3dIRmhuRTdKdmdUTUF2aEtEOUl5YUxMeVdkVjIy?=
 =?utf-8?B?cTQyOG4zUzZWekJCSEZqbTg2SmNUTVJLOWhXZW03c0FZaWZwbzB6VW1rN0Ji?=
 =?utf-8?B?Zm9ndmdaZ0lFMlovSXFHSHlyd3NJVkE3YUJuZEZtdm1PQnZtTXBuQXdxVGhR?=
 =?utf-8?Q?bMPGi9kukDKrY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:29:30.6876 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 176a5f14-f3e8-4a95-ea4c-08dc64735616
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4229
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

Define macro AMDGPU_MAX_SG_SEGMENT_SIZE 2GB, because struct scatterlist
length is unsigned int, and some users of it cast to a signed int, so
every segment of sg table is limited to size 2GB maximum.

For contiguous VRAM allocation, don't limit the max buddy block size in
order to get contiguous VRAM memory. To workaround the sg table segment
size limit, allocate multiple segments if contiguous size is bigger than
AMDGPU_MAX_SG_SEGMENT_SIZE.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 4be8b091099a..ebffb58ea53a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -31,6 +31,8 @@
 #include "amdgpu_atomfirmware.h"
 #include "atom.h"
 
+#define AMDGPU_MAX_SG_SEGMENT_SIZE	(2UL << 30)
+
 struct amdgpu_vram_reservation {
 	u64 start;
 	u64 size;
@@ -532,9 +534,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 
 		BUG_ON(min_block_size < mm->chunk_size);
 
-		/* Limit maximum size to 2GiB due to SG table limitations */
-		size = min(remaining_size, 2ULL << 30);
-
+		size = remaining_size;
 		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
 				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
 			min_block_size = (u64)pages_per_block << PAGE_SHIFT;
@@ -675,7 +675,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	amdgpu_res_first(res, offset, length, &cursor);
 	while (cursor.remaining) {
 		num_entries++;
-		amdgpu_res_next(&cursor, cursor.size);
+		amdgpu_res_next(&cursor, min(cursor.size, AMDGPU_MAX_SG_SEGMENT_SIZE));
 	}
 
 	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
@@ -695,7 +695,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 	amdgpu_res_first(res, offset, length, &cursor);
 	for_each_sgtable_sg((*sgt), sg, i) {
 		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
-		size_t size = cursor.size;
+		unsigned long size = min(cursor.size, AMDGPU_MAX_SG_SEGMENT_SIZE);
 		dma_addr_t addr;
 
 		addr = dma_map_resource(dev, phys, size, dir,
@@ -708,7 +708,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 		sg_dma_address(sg) = addr;
 		sg_dma_len(sg) = size;
 
-		amdgpu_res_next(&cursor, cursor.size);
+		amdgpu_res_next(&cursor, size);
 	}
 
 	return 0;
-- 
2.43.2

