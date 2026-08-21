Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB2BC5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038FB10F37F;
	Fri, 21 Aug 2026 16:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GcRotkq8";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C305110F37F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbMsIEJbgjKJnSDApfL9iFJfkQ5ojHzGL7wJf8Yq8YNxffmku9AqaoTj2l8xQ8su1KDRaqh028PyUgPucvOHPNG9FhspOd1GpBmKt232uEiSvC0pSA6q+xtV/eyfsX5M2O+IFcvVpc1ii69k/bbeJwo/XH6BkFb/3Qp9yQJ0bHtC2AetFUmky/ZIKWccz+SoFR9N3bRE/ogKPAaXCnicR0njeG47demfdpfVNfKLkYE7a5xwO7748NoIc8jrTHBI+MoWVaMR0/j0L8qyr8zvlhxNe5p6gDJuCx0JtgIF3cfptizz8YP7j7TBhcwqdbmYMSjbHk5d14F5by5ERV4ilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw54V4EHoNh9P4YQjTCCDSDIxyRbWtNUXSJqJjB5zRQ=;
 b=MBoEsxFotzHf45OqAC0oiIiRdAekjEG/prMDuV9QxubKyKNita+DxTCJ1ly6aSQb+u0VomlUq6xzuZBE89a5EEvXGEO1P5bu+ODhMrcI46ECBwDjB2XoFHe8opdhAEVrAgaaCe3AWMjcTB7TeOyvEeNHu5T084YiiuSDfjBQxx1PUxOOax0ggPlWXNxz9zUks9m0wnM+tt3CeYxO7alWIquBsIBmhCB7RucplJcNoPbmeQWt2blkStBgaMA2f9JlqRwBeYFb0YbDLdX0eDubunbgvVQWsmKMcb6lAYdh4cnR5hC6ozdwNZx12oDWPwnflfEcox8/kGWzlqEBH0Nxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw54V4EHoNh9P4YQjTCCDSDIxyRbWtNUXSJqJjB5zRQ=;
 b=GcRotkq8GQ68KajIAWSy9gupw4TcKfXfjUDYramTgsqa+K/OvMegDSfTUmK1z2HCzu7Qiz05GEMofK4quycRed8zLZ1hQBZfKJokc/VdWT6RfQJihSLz3sItTrsMSupymCuu+1n00YPNiHFXDWZCFWQXUL/PExTZ88kJl2sHNOQ=
Received: from BN9PR03CA0290.namprd03.prod.outlook.com (2603:10b6:408:f5::25)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:14:30 +0000
Received: from BN5PEPF0004698B.namprd02.prod.outlook.com
 (2603:10b6:408:f5:cafe::99) by BN9PR03CA0290.outlook.office365.com
 (2603:10b6:408:f5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN5PEPF0004698B.mail.protection.outlook.com (10.167.245.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/14] drm/amdgpu: query the reserved info with
 get_fw_reserved_info
Date: Fri, 21 Aug 2026 12:13:55 -0400
Message-ID: <20260821161401.754042-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698B:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 982aa8b6-2411-44bb-f8fc-08deff9f4792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CHbeNqYul8q/bZ4um0U3dM+SUcCOy5pPMsUmQ9Wdu0uuE0TEVyIFK1/SiV9nWlJfo+VpZz370mCRI2nZyDpLPQAHPedWPcyzLjdyLyvTbJSGPpUDxVSm+EZdO7GyDiGRfbuZFlsk6SNJefbd9MAl6prZ5BH71oZra/ffrSBMfHpRQFTDxRrhaFLxug8PRTMA3B2Ntu5edxC8GglFci9k9uwVRG2Cn6uVwq+t8hAq0vZmhSHNbPGN21stJCmd7Ig3sxJoim8aT9vlM3y8vCUM8zxjevBWsy3autt4+9cOvbQHPwGhcSk832MZwoAOEHRqkrBgle5AZsuDN3Aro20KG/egqt8+q7doGyxBkQPBp1jTR3wnqcKdvvkbr+VyFuqIrYqrP1KRNc1hHsg6sd0S744BwguJGVUnam7g1jgMnt9T9oF9zdcw49tb8kH3Q6HRTrepZkXw6K1LQ+QjhXgEgw+/j7bGvgyltUxh4TNhNY0rLf55zTbMPX78zWGZhHiZF3TS3J5Uo+z59a6aVpefN+8JpB4TVZ4DbfqvZmnyvw8siKASWFJEhc6SBj9Rrr8ymoJ5E1pqbxxO+4h6vfM6vLMtanaUIzNpZq/RTBPmH48Mf+r3uKOrZOL6lpjwbccE5QXzgB8flpSHO6Eps3ARmBd+xMwRiiAQ68tw493k8WssjcYxlCR516Nc5lybIw73pBThEO8drqcGVvn4fFW8zQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LKRTuaUBJSau0knSIfUkHNebLkGEzQpUoXmFDqTh9F3ieiO07FldKODy3cFB9qe+E1tfs+e2LhrADoCiE2mw7hDi9UXbnHbRDdFYRAyRU5ojNn6rCMJpj/hixBYvFXfT1caTSKk4oh8R4LzXNC0QOnEdjU4aNyMEN/pAu4pZ/stYD6DbVrfBQb0PJFLA6NvXMVw/7sXpXJHz9mlSnWeovcXZlD+kwJ18zfboqmlCTHrfsWcWH8u3jVmbzseXnZ1WMFJ0NI2vJjak/RkNm7gKm408XIzVmskr4NE5/OrMBk0ukRnpj9dAPLT5G2OHkd19K84YVSQG6RjaEdMnwF825wyzptXcrVJtQOuB/0+dICb/JM2xNF6xyckyX1/tL5xjVUK9QIfRufADE/X159BtRHZSEv5GmQ9cGMyyCj91gKiua1N5xXuOYobqPKVg2x2b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:29.3690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982aa8b6-2411-44bb-f8fc-08deff9f4792
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF0004698B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

From: Feifei Xu <Feifei.Xu@amd.com>

Extend amdgpu_ttm_init_fw_resv_region() to honour the
->get_fw_reserved_info().

Previously the FW carveout was hardcoded and placed at the top of VRAM
(real_vram_size - reserve_size):
 - a hard-coded 144/256 MB for GC 12.1.0;
 - or DISCOVERY_TMR_OFFSET fallback.

The hard-coded GC 12.1.0 path is replaced by ->get_fw_reserved_info(),
which returns a (size, offset_within_VRAM) pair derived from the
MASTER_DIE_UMF_REGION embedded in IP discovery, and falls back only
when the discovery region is missing or invalid.

v1->v2: Remove !adev->bios check, and call the get_fw_reserved_info
    interface when it is available. (suggested by Hawking)

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Suggested-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 ++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a3e3201d61bd1..7a46a26a5fd34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1737,7 +1737,7 @@ void amdgpu_ttm_init_vram_resv(struct amdgpu_device *adev,
 
 static void amdgpu_ttm_init_fw_resv_region(struct amdgpu_device *adev)
 {
-	uint32_t reserve_size = 0;
+	u64 reserve_size = 0, offset = 0;
 
 	if (!adev->discovery.reserve_tmr)
 		return;
@@ -1749,24 +1749,28 @@ static void amdgpu_ttm_init_fw_resv_region(struct amdgpu_device *adev)
 	 * Otherwise, fallback to legacy approach to check and reserve tmr block for ip
 	 * discovery data and G6 memory training data respectively
 	 */
-	if (adev->bios)
+	if (adev->bios) {
 		reserve_size =
 			amdgpu_atomfirmware_get_fw_reserved_fb_size(adev);
+		if (reserve_size)
+			offset = adev->gmc.real_vram_size - reserve_size;
+	}
 
 	if (!adev->bios &&
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
-	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0)))
-		reserve_size = max(reserve_size, (uint32_t)280 << 20);
-	else if (!adev->bios &&
-		 amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0)) {
-		reserve_size = max(reserve_size, (uint32_t)150 << 20);
-	} else if (!reserve_size)
+	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))) {
+		reserve_size = (u64)280 << 20;
+		offset = adev->gmc.real_vram_size - reserve_size;
+	} else if (adev->asic_funcs && adev->asic_funcs->get_fw_reserved_info) {
+		dev_dbg(adev->dev, "Querying FW reserved region info through get_fw_reserved_info\n");
+		adev->asic_funcs->get_fw_reserved_info(adev, &reserve_size, &offset);
+	} else if (!reserve_size) {
 		reserve_size = DISCOVERY_TMR_OFFSET;
-
+		offset = adev->gmc.real_vram_size - reserve_size;
+	}
 	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW,
-				  adev->gmc.real_vram_size - reserve_size,
-				  reserve_size, false);
+				offset,	reserve_size, false);
 }
 
 static void amdgpu_ttm_init_mem_train_resv_region(struct amdgpu_device *adev)
-- 
2.55.0

