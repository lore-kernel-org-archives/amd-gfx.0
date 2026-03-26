Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB322106F2EA
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C721C10E97D;
	Thu, 26 Mar 2026 07:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xx+8Tayf";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A87510E94A
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKMuDLExbqBJF0td73ZNkEx1dnT/1B6xwQ8/iJMlRl4LnCmoh/BaRinmYvEjo7pLD9Yq9iIlF9vbI6D+1ECSAaNqEbpjvjaKBIXdEztwXBPu/iH6aN8SK8qSOM8FU4vQL1DfbNV6nRdZNATaCeI1nMpVzPk1ZQavoc7AZjoTO0cAiblBfA8d1/ZOQeb+otYsgdB7/OE6BlBZYX0iZI76T1DDK1uhxhQDOOTFQTEulPrEm/nxELw5YvzAyuUGA1QsHvl0LaTPfOhXjSpjvn2aLra0MxcGiZGF5Ypbkdr0oRd6StKJTEDZiRrcocdpk4yPdchleDkumXCE/p6HSM+JbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usv7J3uyHRMTzcmcYmwMykYw5khpWptkKOvFTjf5Lmg=;
 b=F1dzcqz+DOdowFj4UOfTyP1CFjYipKfdsOl23+FBjNqxWshSbmgHq0BFgMuOvL9x1cfTtjkjJ95SFWNcjPA+g1ZWFtQSUwLzpYOdIylWi6S9TaNLDlNluqUIy43W2R45o4a/2UIpnq8HJ4sYbAs8bDBTwNvkGBK92+j5CUOpXfwi4q0GNk2+bFPHvrc3YJV9EMjbuEZe1mg44JYUW2JIY253+fQgGM0J7u14FnVvA+Mw1TNBFFNesSi4Da7Jh+DIQk637siWy9qk7L9hlVgvGzE+yaUOIwJlDocnquk3UBADVzPPu1/DDgh9dZmcd73r2RHdNZGcpj1CGtNp8McAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usv7J3uyHRMTzcmcYmwMykYw5khpWptkKOvFTjf5Lmg=;
 b=xx+8TayfDaLMREcGQlk8t/M4NTDfkpu75/vHcK4UNexPX2PcyP9Rp9aAVgvXP0q8xFfVjOUwKbXNKGAq26S7YsxTDvhVhKVZ4/6gcvclN/gIojgg/nBDVVy8ZkQtoqK9rT/lHKEb0lxSpCOCkwzI16RJota2M3nNnErXe5nmO+Y=
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 07:55:03 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:1f3:cafe::52) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 07:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Thu, 26 Mar 2026 07:55:03 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:54:53 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 06/14] drm/amdgpu: Add firmware extended reserve-region
Date: Thu, 26 Mar 2026 13:15:27 +0530
Message-ID: <20260326075412.1378411-7-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 73997f81-441d-4319-0715-08de8b0cfcfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 514wnApn+Wpk/IiPyXVukan2BN26aEsZoRLGG0LIfWJ6yTZa/JAzeinL71Ax8Oo5YPPPeGLBEAY2Gf6BGKB0OwTecszoU1ph5Twk4patEqZA5sZj9t/pObxjC9lBiRKUUD7ScMr+kgxUdSDpNLFjhjq9nrXzp8cQFyOLT1nkNhVr3c2K7xq0D9CCLs5lJgK5+B9jGqsAVGKOu8jycIGTgqks6V0YPBaQ712ZdsyBDjyerpKn3T7ArBFKjTdMkTOzkXPhdtUV3s+yb54XIHi/jcxkckseTIh8ckYBoyRJDH6CxBua+qAakB9nokNsMsymrw0/nsn/APEU/TzfdsaIJUXowBhrQs2WN5JX8etRMQ+CwDVZMLo4+MdRyU49QOcgdZQximWNRbIWSDaXnzgnYNUnKDBuyzsxAsR8e/H+CEFVm/Oe5Hs8ZGmwrmGo6i3ieNrZYsDfTeMVp2f2O4jg4JEq5DLPDMMAB97KvxKrIKoFVOG03c6yFTkziLEswJvKOOS6x7yA19LCF88+Q9geVkCviEbfvisJKNUOejfn6NoYg4KlOi8s1/MwYS6IBhPxcKPz578NMjVb3Di7hCbc7sA5k6gTYnK/FFLoM0JkBJoWZVp1hs8HLEUngbXeNHHdVxCIcI8CTSx4lN5Acoi5IlZ+zm3jM9ZqIpwIT4rCEcPzJxWtaOXN3IEC1IbQg48fWbqpxrcTJkF/WR1Z2rKC1Wwv2Brv1ymv2EpEns34OsL6bLp0xT9YhEo1jT2ITQCNoaEV4rlp839ASXbn4PlfQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: swPFkGi7n0Z40qyDM8TBX5436DkG6IhrvjGujYWXgVTukskp8uM4qB0A/MQoQb1j9JGyoc5+mBqkV91JEMa2XfHTl4ci80i1lYFRGP+vVmeUs5NxGssKgoc9bGw/v/uH3EbRXsQUyhySxJvy8A3NXXfG21/SbTJkjF/QuRnmvIVq3pNyFQzYLkg5SgOncCsen2cHT6jlC2BCVfrzHdWqvYOceGuzUTqY+u1OhyjMwgA4WeCv8pGCia5/ZOPsLDaoeTiHL2dw5JjudRshllJbc0MiWtMdNPS9UiVV7hWQsAkJEwgXPc3reTlqJJEpm5OUEGRwORJKXAMVdk4bcDtkXCGHr10f5ZeHxEi1B8BKX3ObJG5TPNFAKbCZq8y8kwvrAR6r8lEbfzYVwJdBAExig+mBr/OS9KstIfB4gEWc0RrZiO3iIXuXsLTregtgei+e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:55:03.2810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73997f81-441d-4319-0715-08de8b0cfcfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190
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

Use reserve region helpers for initializing/reserving extended firmware
reservation area.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 3 ---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2fa753a1fdfd..13178cd51deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1090,11 +1090,11 @@ int psp_update_fw_reservation(struct psp_context *psp)
 
 	reserv_size_ext = roundup(reserv_size_ext, SZ_1M);
 
-	ret = amdgpu_bo_create_kernel_at(adev, reserv_addr_ext, reserv_size_ext,
-					 &adev->mman.fw_reserved_memory_extend, NULL);
+	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_EXTEND,
+				  reserv_addr_ext, reserv_size_ext, false);
+	ret = amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW_EXTEND);
 	if (ret) {
 		dev_err(adev->dev, "reserve extend fw region failed(%d)!\n", ret);
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory_extend, NULL, NULL);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4d373904d071..e9a9b1832992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2341,8 +2341,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_EXTENDED);
 		/* return the FW reserved memory back to VRAM */
 		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW);
-		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory_extend, NULL,
-				      NULL);
+		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW_EXTEND);
 		amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_STOLEN_RESERVED);
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 70d4fdc54b8d..05a9422a1fd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -101,9 +101,6 @@ struct amdgpu_mman {
 
 	bool			keep_stolen_vga_memory;
 
-	/* fw reserved memory */
-	struct amdgpu_bo		*fw_reserved_memory_extend;
-
 	/* firmware VRAM reservation */
 	u64		fw_vram_usage_start_offset;
 	u64		fw_vram_usage_size;
-- 
2.49.0

