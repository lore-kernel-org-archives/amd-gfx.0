Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB73C5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 03:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB38310E5EB;
	Mon, 10 Aug 2026 03:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jsfay3bu";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FC6910E5E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 03:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUdCZqDWLA+cRVA5CFYoElbKu3ppA8wGlNepLSbfR/2BmOpcUpzw8WpEZvhSHBSlZsPbGNAPBwnTRzt0KDSsu5U3a2SXJhsy54jwckWcFv2mqq82jz0X37KKRpoBRgI/u7ippKZOPUHzMyDZPqRd1D8nWO9dnHrbtfSuSjM4UcHuyTRx2GnoohOoYrWTkMDsRCQ17FVa9POpDCmgCKuB5VWDIUieXo+oFsiZuFu5aWLrQ6+tPrgApsVMU3qe2psACRx/VIWF/2yin0pZ4iXFYAvLr+AzWUI4HRhM6F47UhxMxoro/ARwZHNGPIVlCHD7orFtnrTZwxERXlki38247Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=odjNYnHO+Z45d78sTrIRvWMiy9xKJJpWKvq7LM8wVrw=;
 b=Ira3TRBtXtMMc1gePCqCpi1zHMtODsGsIL7CA3yU+ag48n86UK5PyD6xRIm7WHpK5cYnoTYKjNYl+T4PRJW34Khka0e5SF6CRYh/66VaMFGWrNVqkO1dEg4ht6kRASVpwRgvD2XNP+RM2/+qLDHVgc027PGI2bQQb7o7qBZKhWrbq38fqgTRLrnBAzbRP0ch67ExOs06oLMuvzRmBucrjRo3hiQ93Z9kwUg7mOjNYe6zy5Srn2ukxoMHEkf+iSjEibdUyaoYI7CfWHgHBJbhnAiQRpHfG0ndE82BWt/i+/NuGXwNjnmwodJ9ReIBufCouDgyKkv3V+o7/Liq+AdrkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odjNYnHO+Z45d78sTrIRvWMiy9xKJJpWKvq7LM8wVrw=;
 b=Jsfay3buJldO8yVibK2CId7D75mciA+TVFg2HQMRqmyjFwi8YAd8e52XjYi3yezQBddREg1lq8eQACAZQGQif1Qz9zorP2Sk4guvLBv1Juz4/2oVYuVaB35Ev/SdTV4vlAKm5ubjs6aafcjdJ8xhDAMsNcmpYiXunwrGw5CEVhg=
Received: from DM6PR06CA0084.namprd06.prod.outlook.com (2603:10b6:5:336::17)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 03:41:12 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::4d) by DM6PR06CA0084.outlook.office365.com
 (2603:10b6:5:336::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 03:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 03:41:11 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 9 Aug
 2026 22:41:07 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <leo.liu@amd.com>, <alexander.deucher@amd.com>,
 <Christian.Koenig@amd.com>, <sonjiang@amd.com>, Sonny Jiang
 <sonny.jiang@amd.com>
Subject: [PATCH 10/13] drm/amdgpu: JPEG 5_0_2 set inst_per_aid to 2
Date: Sun, 9 Aug 2026 23:36:41 -0400
Message-ID: <20260810033644.118194-10-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810033644.118194-1-boyuan.zhang@amd.com>
References: <20260810033644.118194-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: d265def3-60ea-4fda-3663-08def6913902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hJvOCxFzkQDQwKI8J4W4Vvf4qHZRa/eA0MpicN6RJr2ufi9jLFJj3ocdZR1TJodmo1W1enoRFFfSG3QWzYa4WxIio8JQvUZvaMaLGKvW50lcBUY98W1j1sjNeJ3nBw58LYePXICbh4DqS5OX/kyihYMI94ZcuAayMF0oYLYzCRMChujkZSBLK0/zDWqv6LiSLp+6bnoqHGOIzWIGNZf9R9DwNbHc/HlthItW3FIFFyTmhTem7gwrrP8nMSslNSp36mH+GH9mOYgylWwumSV2IQeAbibR515pVFQcl4CFNaR5mludeLpBqD7WoolRyuR58xENfXb1Aw4Tjd4plRo9kWcwqvPNQ7zR2NgtGhP36GuKN8zDkEtkaH+jSE2bBNmogmf8C7jhqH8g6CbBQAuR0PLKEn30mCDbM2QbSj61hTgsTOyUQvMJIK2BF+AlRwCrNxE+Ohkh6DcJBm5zAzV8oJ7CMg+a0yzU8iWMBoy1x9dRqJjrYMLEYYsWih5TjAk/4ZTsvpRFQ0TW47FmrWnLYgUL9CxOSCXLijXa7A9h2mk9+1AtFlp1OSUJ+4+xXNRvWCvzgNrnZBFNcpxCR2hMnrgVC2mk5IYEEI32+yzxsCYBF1YBjsiwcUt/t/d/F84YvgKIhSyEQoamvZEZ4Adl6kefT1qG69OR0y3FNPfha7+V6fz06Q+qjNiUWCMjvqnjed6RfxSQmE1XG1FBp7eKSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 23UbR9p01fjCdCJ+RphqDyxxzW0xj0x1vcmulcP/MpHlN5JlQMZB6yujYw6n3aCYaAbPmTKHbYoWdc7ExVJHkOW1BLqrFSOcrDpuoCeb8EJYuGuCgLLqqXpYE1adcyVde2mFYkWc4TnOzAzfT4opLdfAhcKSL+BsLHwrs8+0D0wUvXsuI0++3YRFuj3H8UColDkk7ENK1eqvXnyZ8ASSfvbamrrTUIysfTLiaMl5YwWtdeQ91yiIcz/NzXiPJ3WEwUZDHtNTZTqC+9CFkdDx3BwYLup+2VGZ6+8l0fe/+drcumzBTqhcq3qtu7EE+pxfIxnHJmg7cv7z9P0nC4dt6c7CZeOL3vVqnOUe1E0w9aMLIguTHIG3ubMnzv/HptgElmV1SCAph3873v69fmC75oKYLlTL/hfLojeKM8HjUwkVd9mIxcjVM2M+gzNna53Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 03:41:11.9457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d265def3-60ea-4fda-3663-08def6913902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

From: Sonny Jiang <sonny.jiang@amd.com>

JPEG 5.0.2 has 2 JPEG instances per MID. Report 2 JPEG instances per AID

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 0ea341c238f5..059b6b927251 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -167,7 +167,7 @@ static int jpeg_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
 			ring->doorbell_index =
 				(adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 				1 + j + 11 * jpeg_inst;
-			sprintf(ring->name, "jpeg_dec_%d.%d", adev->jpeg.inst[i].aid_id, j);
+			sprintf(ring->name, "jpeg_dec_%d.%d", i, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
 					     AMDGPU_RING_PRIO_DEFAULT, NULL);
 			if (r)
@@ -243,7 +243,7 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 		if (ring->use_doorbell)
 			adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 				 (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 11 * jpeg_inst,
-				 adev->jpeg.inst[i].aid_id);
+				 jpeg_inst);
 
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
 			ring = &adev->jpeg.inst[i].ring_dec[j];
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 39224d4c9c10..7531890ec005 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -854,7 +854,7 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 	adev->vcn.num_vcn_inst = hweight32(adev->vcn.inst_mask);
 
 	adev->jpeg.harvest_config = 0;
-	adev->jpeg.num_inst_per_aid = 1;
+	adev->jpeg.num_inst_per_aid = 2;
 	adev->jpeg.inst_mask = 1;
 	adev->jpeg.num_jpeg_inst = hweight32(adev->jpeg.inst_mask);
 
-- 
2.43.0

