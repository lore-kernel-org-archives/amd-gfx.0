Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19848C32771
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 02:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF0222522
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 02:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="twBUBkZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF0222522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB886E1EC;
	Tue, 21 Jan 2020 02:22:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0810B6E1EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 02:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUJ5iUgIK0wtDFed9KKqlHREoRczGr6ULzmqsh6U4PR5wnDYkFQPSBEqVSB/KbZdZT7evnkQk3wqGDjIVbFPUJ2P/rJWBqVQ0n5o7jgXH1W25KP8W1w68e/+LYodcYRSODjSp7mBerQXQ0f7Wk5lyiZRKCQjg5Ml2bw/PEF2VNWYMAalqQYW8fRBZEJgexZm3+gtgibzMwH9Q4gqTM5K46JnekLRcWasX0ROQ323xrtFGRIkRYyhG5kDsLOM6fkB2bqrjjiZ0WpY1imf1pJ5pTuFyzWaxLNzGAEUP3OJxRVTvlHTxGRcOKwyHp1FAXhNcMoX0s99JGLdaeK3n9tSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYgabKPRalFBhvVBvD7sFHWzgLhHCsho47s++Zo4w70=;
 b=Q/vwjFdVWvug2LaTEXMddtYFT/I11X5LbgZf4UvB/bnKrdJKSJwI35G7DcgFLok5gtDWK0Qr+AELLrpfYx4Oc+HAuNWdg2MwOC2og5FhSSvuYR8RvrWw99du1zR4Y4Vfux+e4IZTDhkltLF6Zoc2SQGYwvfrxMI4CVpu1/ouegEtw8dUUhAzxaayx7qQEzxLkLSUbHOR8Szvx9F1etXCzSmA1d3B07ZDqdaIVAJAIKSsH122pj4Mp4M734gAMET4FZgYl0OG2iCLcsK3NzeaY9SwMYBh43vSggfoOmxTDTxfbX/OaBJfVRRp/r7AMGKd4mrfGnDv3a4SFOnpIAZTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYgabKPRalFBhvVBvD7sFHWzgLhHCsho47s++Zo4w70=;
 b=twBUBkZ9v4wmvvvtLd+CPv3rALU6AYdeM/bw/imWgFaj7CDypRPF/vBxP3HawLeJ2SJbK0SYj6W5TuHX7IZRB+WlNC+5zx5e/xAF+GPaXPuv9XdoOpCoKwTWnfCodQo9xVQ19cHBN6UU7AjurpmglKojYQVCnUhRq6tthhTFcBw=
Received: from DM3PR12CA0103.namprd12.prod.outlook.com (2603:10b6:0:55::23) by
 BN7PR12MB2594.namprd12.prod.outlook.com (2603:10b6:408:28::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Tue, 21 Jan 2020 02:22:16 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by DM3PR12CA0103.outlook.office365.com
 (2603:10b6:0:55::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 21 Jan 2020 02:22:16 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 02:22:15 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 20 Jan
 2020 20:22:14 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Jan 2020 20:22:12 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] Revert "drm/amdgpu: fix modprobe failure of the secondary
 GPU when GDDR6 training enabled(V5)"
Date: Tue, 21 Jan 2020 10:22:06 +0800
Message-ID: <20200121022206.5223-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121022206.5223-1-tianci.yin@amd.com>
References: <20200121022206.5223-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(428003)(199004)(189003)(70206006)(5660300002)(356004)(6666004)(70586007)(86362001)(7696005)(6916009)(4326008)(54906003)(426003)(2616005)(336012)(8936002)(81156014)(8676002)(81166006)(316002)(2906002)(186003)(26005)(1076003)(478600001)(36756003)(44832011);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2594; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fd39697-121e-420a-e903-08d79e18bb97
X-MS-TrafficTypeDiagnostic: BN7PR12MB2594:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2594A82859BAA1EA89413515950D0@BN7PR12MB2594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-Forefront-PRVS: 0289B6431E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77by8cVircHDAf4ZuvPZr8SaOXWk/eI8FCUBhpkU9S3CfvemwDevp1qscLqof2yYG0X7lsXVLxyDcmNoF2SciF2G7mjTx4QWD24DPNH0eI8TuwbbETOpTzOi4MfFIkOIDOfPUVBqVFnElSLejJKcPBwwhokLM4fEB/vckYCCIKkuM973YjiPrkqCzG89a6ZYPYSfM6JbPNGgmfpkoXMyFA5rM0yfR8eskhGnzmfCwfBQL2SAI1EolIZNVmp1/A8KdHNqFEf8aQD0JMOkk6TJLVb7OtaREVrT1YEjyaFXWFhxt08HLZxM2TGV4TNIY9hVgYddLVbdaelz86u+0gnrcjxCG81c536twPv5OVx5Bj6EfwnbP4/nFXx8zMMR3eNSgycrdtZYRwkopgTaZwm6IZc/GunClOvov15WunURw0JWl1fmaSWGiRgCn1JlQSpF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 02:22:15.8313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd39697-121e-420a-e903-08d79e18bb97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2594
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
