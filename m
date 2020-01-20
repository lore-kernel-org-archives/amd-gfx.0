Return-Path: <SRS0=J303=3J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2D0C2D0DB
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 11:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3812073D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2020 11:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V281VZJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3812073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E0216E8CC;
	Mon, 20 Jan 2020 11:08:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238D56E8CC
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2020 11:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3F7rxWLGx1/4YE4arS01Q7bYFI1I9VTeQOu8DeQf6U+PDD8UhDu1QbI2KNWJNUnV7D6I8yTQD1cEtIuTyJivvexznfp7596M/8DidEF2DJlqaJO003G2+i00qpL89EWp3FjyoPU/Ro+ztQj7x1/tXcq+rX63jF8uMVuSWhNY+vJICS9PZbWX6zL+tezblqaD9TGeG9QvDz+17UboIM3xdjs4HFbcyEER5gAWAT6RRAds6U4Dk9Mm0gZMufrUl3PfUyY4E57P2TuzbwwrvVUwxarUsnCH93nMIFGV2QjH4eIAlE7EA1sDYuj5vQzKixuSMW0zyzdciVpUDUe0q62sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYgabKPRalFBhvVBvD7sFHWzgLhHCsho47s++Zo4w70=;
 b=VVWqkAcg0EQcKRAUn+C5L2uHGiprsVvvkkFyopcLl+PgYRtWWplq9q4rfwD4aqwX+nYUI3h1dDl5qqFNmfrhzNR8PEUMXQDPJeriCNfi94QthTo0tTYtArOFJsZc3tPYJzW8Iv1NzYiuawppVQZWkaKy6b+F195u1cbLn60/KNqzh93EFR5/zxi2TR1Nz4hd/9DLkJ3aMuLKg6K36OlgJ4co+ApxSZShm/JPBwT+qgokl8QNlE9XFLRL7a7d0TmgyZZWf25e2YhWvtCnwQ4eoHEUB+jpVqYoLeE3aQnoIinnwvhcQcOnkFs8k6LiKLzgUT5SDMM/0bCtjWbw0cTNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYgabKPRalFBhvVBvD7sFHWzgLhHCsho47s++Zo4w70=;
 b=V281VZJgFy/rQq/xO/jN7VFNNotjaciw0rzyqi0eWV6PODGTagsyTyUUGdJ0N9jP/cFY8XzghMUEoCKrMStcG4avOt8N2W0kk3llVxZIsHMfBzgBdC92kgpqRs+eBLpYfqSPDh3tAvQgAAB3TjQQIo34DtFoiOMksjeq2KbIpzU=
Received: from SN1PR12CA0064.namprd12.prod.outlook.com (2603:10b6:802:20::35)
 by BN6PR1201MB0097.namprd12.prod.outlook.com (2603:10b6:405:54::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Mon, 20 Jan
 2020 11:08:31 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::206) by SN1PR12CA0064.outlook.office365.com
 (2603:10b6:802:20::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Mon, 20 Jan 2020 11:08:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Mon, 20 Jan 2020 11:08:31 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jan
 2020 05:08:30 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Jan 2020 05:08:28 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] Revert "drm/amdgpu: fix modprobe failure of the secondary
 GPU when GDDR6 training enabled(V5)"
Date: Mon, 20 Jan 2020 19:08:21 +0800
Message-ID: <20200120110822.30163-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39860400002)(428003)(199004)(189003)(4326008)(81166006)(8676002)(426003)(26005)(186003)(5660300002)(81156014)(316002)(478600001)(336012)(8936002)(1076003)(44832011)(70586007)(70206006)(36756003)(54906003)(2616005)(2906002)(86362001)(6916009)(7696005)(6666004)(356004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0097; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cf41db1-8fa6-4b31-0a0b-08d79d991591
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0097:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0097FCA6BBBEE70C4E0611C395320@BN6PR1201MB0097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-Forefront-PRVS: 0288CD37D9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UM/21a7ZObOjsAof/eEeo1YMBo+bQzuzBHW4D4t8jBRxqPQcphbO4f95frkbKMHfxcdjBXOxrb21AnBQzT2ewFcwdIE0KpIgyOt79fYH8Po5qm0dSuSyOxUB/7K/D/8m1fatzsRlTKQD9ym6prjFV1rYpKejoVDuJgWnBv6Z9vVc25yOqEv85OLhsUSsDK9VDYok1Orryhw0FN6rMPupkzzhS/4zq5GW2k6EUHgD7MbPlCFgrJ6pJTs1mH2XxQnAZOV/UfbXErJGicVayvIlNYvgTmSZahp7qYLtMaYLgHZNTJCgLDG5/UuEpq/9MStDdTeGamIhBxTy1WPhJPDPJtz23P5dZfeZLm5NzEniLbk8FTtclxt9ktnqGYswBO1sQcu9Ymgu1ywqcREKCXDtDbPb0igB3HW9QOP52QCVuM3zWNX1vd4FaCudWwzuuUno
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 11:08:31.2637 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf41db1-8fa6-4b31-0a0b-08d79d991591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0097
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
Cc: Long Gang <Gang.Long@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

This reverts commit 2ad857d7b82081736c078997ba0542acfdd50099.

The patch will be replaced with a better solution, revert it.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 -----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 27 +------------------------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 86267baca07c..d3c27a3c43f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -60,11 +60,6 @@
  */
 #define AMDGPU_GMC_FAULT_TIMEOUT	5000ULL
 
-/*
- * Default stolen memory size, 1024 * 768 * 4
- */
-#define AMDGPU_STOLEN_BIST_TRAINING_DEFAULT_SIZE	0x300000ULL
-
 struct firmware;
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 86f4ffe408e7..0c5bf3bd640f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -641,12 +641,7 @@ static int gmc_v10_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	/*
-	 * Can't free the stolen VGA memory when it might be used for memory
-	 * training again.
-	 */
-	if (!adev->fw_vram_usage.mem_train_support)
-		amdgpu_bo_late_init(adev);
+	amdgpu_bo_late_init(adev);
 
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
@@ -830,19 +825,6 @@ static int gmc_v10_0_sw_init(void *handle)
 
 	adev->gmc.stolen_size = gmc_v10_0_get_vbios_fb_size(adev);
 
-	/*
-	 * In dual GPUs scenario, stolen_size is assigned to zero on the
-	 * secondary GPU, since there is no pre-OS console using that memory.
-	 * Then the bottom region of VRAM was allocated as GTT, unfortunately a
-	 * small region of bottom VRAM was encroached by UMC firmware during
-	 * GDDR6 BIST training, this cause page fault.
-	 * The page fault can be fixed by forcing stolen_size to 3MB, then the
-	 * bottom region of VRAM was allocated as stolen memory, GTT corruption
-	 * avoid.
-	 */
-	adev->gmc.stolen_size = max(adev->gmc.stolen_size,
-				    AMDGPU_STOLEN_BIST_TRAINING_DEFAULT_SIZE);
-
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
 	if (r)
@@ -882,13 +864,6 @@ static void gmc_v10_0_gart_fini(struct amdgpu_device *adev)
 static int gmc_v10_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	void *stolen_vga_buf;
-
-	/*
-	 * Free the stolen memory if it wasn't already freed in late_init
-	 * because of memory training.
-	 */
-	amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga_buf);
 
 	amdgpu_vm_manager_fini(adev);
 	gmc_v10_0_gart_fini(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
