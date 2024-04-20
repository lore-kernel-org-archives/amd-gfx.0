Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E832C4345F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Apr 2024 19:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF13010E07E;
	Sat, 20 Apr 2024 19:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pCniIKxG";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7225C10E07E
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Apr 2024 19:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaF/nWblM8a3p/qBscOxbeAr3OxKHKbkdstExt7ql5ao+4LJxkgESUoZb7H19RKmzxX5MEmAofPvjStESambPI+fBmfmFRwxh40lMryPKBs6SHJKMg2/+SfYsEcCXdsh4gkzDOLXKeE4hlZjqctfmEfAvQctfiX2X9PoeVSNk/WOCW3HIUfyWci/vPkWKdrSXp0E0NCLsLmuq2/FyGTbWt2/f/idEHDczpbuu7KtINkYc7oq0TUknqjdvM2oiSs21Ve9H2dQdMWU3yXttm/3NkiAik0mc9JBytdoulJBb9iTQ7gNIiGjnGMjN2F1WWoh/8IN8xJQpGsD6t4yEPqxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmomQUNvrINghVeWYPvRJUKaT3rv9vX1R+/WUJgN0Dg=;
 b=d9LCHZIEouGmF4eH+sg0RivB+Z/Hyq6Jnfi128j8K7DbUi7Dxg8fInz4Ahyjp8DZVyglou/9ii07IhAs4xB4p2Z0yKHSjXxU9jN03y2Ce91AuocPSSFuEekJA75hHyQjKa1poh1qJswQ4IUV0qHmVK1XcZdHiB2LR1g1vfRNQwHzeUVvK3+iXvps9GwltCYWM9ZrMHfCGic8HV3VnbUsCPcwHfVMkiR7aWMGjXY85w4++EBJUoyjPC7L+hVX4QBWfJmbK1ZKlxebvfni235Ilg4NH/7uRwwPxvrECDA+323q6CDL6lFGCrhHOrfNuSxSDgGsIhPiqgGEfm+Thf0Zpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmomQUNvrINghVeWYPvRJUKaT3rv9vX1R+/WUJgN0Dg=;
 b=pCniIKxGz8ntn3tkwZicEI6ip1HpjFhRwSquoo25C5Ha2Zug3VMUaRFWcAmWFQToL2s4oHIOyvAsBSiPR62tgY2n3G+8E6+pv464nsDkyGMN47pdN6SHe9JA5O45ba8wgellw1DSvjtPWDanOIEcNoW2gibRMXuFRPnrYSmmAfE=
Received: from DM6PR11CA0049.namprd11.prod.outlook.com (2603:10b6:5:14c::26)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Sat, 20 Apr
 2024 19:03:05 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::95) by DM6PR11CA0049.outlook.office365.com
 (2603:10b6:5:14c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.32 via Frontend
 Transport; Sat, 20 Apr 2024 19:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Sat, 20 Apr 2024 19:03:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 20 Apr
 2024 14:03:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3
Date: Sat, 20 Apr 2024 15:02:47 -0400
Message-ID: <20240420190247.3130325-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e1f657-1aeb-4cc4-bee4-08dc616c81ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z++tv4ndJgEmkH51J8Z9ki4Hyp0HolYuILwlzayqqpZPxKvlf8WMPV0ZIMVz?=
 =?us-ascii?Q?uKk6raxaQcKknXjloIYqUqEiJ62Iwt+3P/kkpUZ0C1M67JYHhG8lOWGeHUTn?=
 =?us-ascii?Q?dvrvzc+gtwe7Vzg8ViACZ/TFHWUuzTjJa/wij0zrjXEMq+rde2UM2P5pjT4b?=
 =?us-ascii?Q?4ArXfw1F9qytl4+6rJpo6JZZx9TrKgzR5Z6oeGhcLKRVoBVPrXNjbRAY8hHW?=
 =?us-ascii?Q?DMGiC+sU4vRhPNr2gCRSbGtRCTTBPfJAyU/AOpAXRGUibU2KAX42Ir/Sk745?=
 =?us-ascii?Q?D4/a8gg4sn1UEGdjxoGBlxdL6XZBT6S5AQuhjzyt5OwpCCuK4Nvv/TQL7jCr?=
 =?us-ascii?Q?1/ijnvNMLs1BuZqPNN+io3+soEgLYa8mBG5TdZnrBTqHpQhmAd+SakGu/8pi?=
 =?us-ascii?Q?FUx8HJchAHG5EC5yRl3CzaIM2tsvaFtJcX4jNLWs0eDLYlr7AX9sbNstaIhc?=
 =?us-ascii?Q?8o+zHTXzOZhBWI85scXmzJuJdhbzNCOFC8mY0Ii0dVkr322NySa78k2xLcrh?=
 =?us-ascii?Q?5jdV99TQGO06nCRzXhqJ/5v4LYUpBjgKNL/PBPtoOwNTIm3MIVC3FtxULic/?=
 =?us-ascii?Q?Js6UX6I7+mTRZbh5qZLk8KtboY03I6xP2qDPSvbfmrh/YxzLxCmOYdrVCE4c?=
 =?us-ascii?Q?lBQzxTDPXwIlzAheNCVOl/sW13OR+p3JQ3QLPyo5TBIZW/hkcw88NwvYfoD6?=
 =?us-ascii?Q?k3R2MpYh15vD5IYhuuc58xLNZqAeDAdExkovRWNEnX0/BD+rKLeiT035sf90?=
 =?us-ascii?Q?0vMf2a6M+U4+h5n6dGrtBkwbTwXv3+uuPql7U7Hszsw6aBqD2qpOpakNPzCk?=
 =?us-ascii?Q?xf1beTJ+TUMdspFbqMf3vFs529TCoNnWk5/su1tu83xZhPS4HKfdNV7KDK78?=
 =?us-ascii?Q?d+QArH2DfhcDCvXKrmQ66m3TixrV1vhWHnoZXJGCgEN0eHoYuJYEMpO/Kx7W?=
 =?us-ascii?Q?zJF0DqQPNU8Z6rhonNVhtgPHrzQUiVHphusBjLeZQWxDB/YHgnvmc0NOmLDn?=
 =?us-ascii?Q?odwSt5+XUgTGgvuuo54r75QdIEO0A3qJczNQV9rmrYZCJvhQLGPZ6d2uS89e?=
 =?us-ascii?Q?Vw12rhI3opizeVZOf34Lnk0LZI0ofJ3bE+vmYOGkmv+LgMvL6vPWbFIhgXdS?=
 =?us-ascii?Q?B1sxySfFedgO5TTVw3X6VVNb7W/DXmTPh3i7zQxtUWNKz/0fH/9/Itj2R06n?=
 =?us-ascii?Q?11GVJjl2c8ggo9aDqFkd21C4YGOgs+v44n8dnIZxnZ0pHitIkh6HjIJLYVLv?=
 =?us-ascii?Q?eUaoFIrIhUw39SN++HfAyjrTEh+xVjuK0i31W8zL4GgkU0Ky8WeVbpi+IGRE?=
 =?us-ascii?Q?wiYCxgo04JAZ4IaKy0lKlnaT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 19:03:03.9848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e1f657-1aeb-4cc4-bee4-08dc616c81ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

This avoids a potential conflict with firmwares with the newer
HDP flush mechanism.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2156
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index b2417ba4759b..c44ec41f1cb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -280,17 +280,21 @@ static void sdma_v5_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	u32 ref_and_mask = 0;
 	const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
 
-	ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
-
-	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
-			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
-			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
-	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_done_offset(adev)) << 2);
-	amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_req_offset(adev)) << 2);
-	amdgpu_ring_write(ring, ref_and_mask); /* reference */
-	amdgpu_ring_write(ring, ref_and_mask); /* mask */
-	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
-			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10)); /* retry count, poll interval */
+	if (ring->me > 1) {
+		amdgpu_asic_flush_hdp(adev, ring);
+	} else {
+		ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
+
+		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+				  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
+				  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
+		amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_done_offset(adev)) << 2);
+		amdgpu_ring_write(ring, (adev->nbio.funcs->get_hdp_flush_req_offset(adev)) << 2);
+		amdgpu_ring_write(ring, ref_and_mask); /* reference */
+		amdgpu_ring_write(ring, ref_and_mask); /* mask */
+		amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
+				  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(10)); /* retry count, poll interval */
+	}
 }
 
 /**
-- 
2.44.0

