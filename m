Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC6BC33C99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 05:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365942072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 05:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1YIWmh6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365942072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D54696E14D;
	Fri, 10 Jan 2020 05:30:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4FE6E14D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 05:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4HvMb8ZxJseS0gzgA+qdCVn881scgbRKIZxTPaHnhVX8Wv4/YBR4pr0Oyy2wSS6kZxaRNnhankqq552QgyjBqA9cWK2i0kCJH2+/hw+BicAah5AHtpfZfRG5+VX0IsAzd7c67Il3fZuyKv2Dk0mDvazXhbL8W6+Td8ISw62BlmN+S3MmqGIJo904s0yHnfQC7StwWTx9yg1s9XE4ycH42NhqOnn9YyOZx8SZ+nTaDmYiqQixgViQvI6vunUUeHRKtyJnZO3QPEbyPboXCKIcDKM0taLJqN0iyz4nySLEK3xaGoakc0Qo7NFyaamAafhCC+uYsCLrnqjEXRxm345IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS5m6cXWaUAL9DbiMgMCzIvquZrxK67/JxN1TbjvfdY=;
 b=hIKWBotYXxsMlFDDVXIypnPPDXEOwXgpPiBlSpffT+HyW2IaCFPh3+WWiNMrM1xjwgfFDPJ22BYfZYWKmXzbRK70izuCZvQSBQ8goXQ7+87B49ZGWUZGaD6REBhM8+uozWekOl5pq2xZ/tsaTdICj3xCns+q9qQbToASuuQFuPP8I6MGxzFAU2yaojLEOIPWyPzcEv1DXjFvlLiEDFmx5r2E84aca8qiTV3LdJoGfqG8/gMqQSmDtN6xxaKFvgW0/3RkJyRDjoOM4gZnXqmnaUFVK9MpAuaQ9pAPHb5EVtBJdm9o0Ichb1F7ft1VvzyLgS6x/vxuZ8wv8jdi+JX5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS5m6cXWaUAL9DbiMgMCzIvquZrxK67/JxN1TbjvfdY=;
 b=1YIWmh6xUSF8dz9uqVLFOJS18O9c9C6QQK1D8d/UprAiWIDpfxdA1Pze2jaElZXd+AtHOqB+29+VAlbB5tCxWq9w0hsM/R4r95IfmbIHfSBXq5pLfsrxuD/4N1p3bSwtDd582kByQg5rdRHnuLX8oUplIw2LsCpMaIlty9LTWgU=
Received: from SN1PR12CA0051.namprd12.prod.outlook.com (2603:10b6:802:20::22)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Fri, 10 Jan
 2020 05:30:17 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::206) by SN1PR12CA0051.outlook.office365.com
 (2603:10b6:802:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15 via Frontend
 Transport; Fri, 10 Jan 2020 05:30:17 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Fri, 10 Jan 2020 05:30:16 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 9 Jan 2020
 23:30:14 -0600
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 9 Jan 2020 23:30:12 -0600
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix modprobe failure of the secondary GPU when
 GDDR6 training enabled(V4)
Date: Fri, 10 Jan 2020 13:30:10 +0800
Message-ID: <20200110053010.29132-1-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(428003)(199004)(189003)(8936002)(7696005)(70586007)(70206006)(426003)(2616005)(86362001)(336012)(186003)(5660300002)(36756003)(478600001)(44832011)(2906002)(316002)(4326008)(6916009)(81156014)(26005)(81166006)(8676002)(356004)(54906003)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2500; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d74c80e9-ca40-49ca-609c-08d7958e2d0c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2500BB2F7E01169291A3D8A395380@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 02788FF38E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0MZtOIa4Flrn+Mx3+CrHH33J8KtKXQ24YCjXueZHDR05EExMdM5/wMif+c1oGtOxDoa0U1G5od8YC7HaqJow2mKg/keqybrOQo9S1Hm4OFe4gb+D1yBaE+XWijFcEMuB2uvEVc3eiLDo+BUibwZoLcQEyydPVf4G/8PlR8dF4zRI2+ORYCslE4xWAxPQnkwO/hgvsaWysTYte4wSO3iz8RNAEamDTMzjxQkAsHyjGbqlP6hH7ws9FcbK9J2CT+3HIKT9/8dAVdkqgr5VjjzyJSIOo+i3EEmxnZtyRRThPE/9JcFq2sxtw6lez2s5+MFj3FL7q8LHCSxk2cUzBY+tBFPONqTDQIy0mtewx/t5KQxUE7We9FmhJ66BzSjPU/PhAsM5iFxwki1Z9nvZmRkpifEBPxptjESMfBx441NZZ3f6ixvMqhdgeOtzjoFSuFN8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 05:30:16.8283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d74c80e9-ca40-49ca-609c-08d7958e2d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
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

[why]
In dual GPUs scenario, stolen_size is assigned to zero on the secondary GPU,
since there is no pre-OS console using that memory. Then the bottom region of
VRAM was allocated as GTT, unfortunately a small region of bottom VRAM was
encroached by UMC firmware during GDDR6 BIST training, this cause page fault.

[how]
Forcing stolen_size to 3MB, then the bottom region of VRAM was
allocated as stolen memory, GTT corruption avoid.

Change-Id: I310a72ba0402994defbe50839842a8edb025a868
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 27 ++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index c91dd602d5f1..e4b2f9bcaeb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -60,6 +60,11 @@
  */
 #define AMDGPU_GMC_FAULT_TIMEOUT	5000ULL
 
+/*
+ * Default stolen memory size, 1024 * 768 * 4
+ */
+#define AMDGPU_STOLEN_VGA_DEFAULT_SIZE	0x300000ULL
+
 struct firmware;
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5ad89bb6f3ba..14961f1ebfab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -566,7 +566,12 @@ static int gmc_v10_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
-	amdgpu_bo_late_init(adev);
+	/*
+	 * Can't free the stolen VGA memory when it might be used for memory
+	 * training again.
+	 */
+	if (!adev->fw_vram_usage.mem_train_support)
+		amdgpu_bo_late_init(adev);
 
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
@@ -750,6 +755,19 @@ static int gmc_v10_0_sw_init(void *handle)
 
 	adev->gmc.stolen_size = gmc_v10_0_get_vbios_fb_size(adev);
 
+	/*
+	 * In dual GPUs scenario, stolen_size is assigned to zero on the
+	 * secondary GPU, since there is no pre-OS console using that memory.
+	 * Then the bottom region of VRAM was allocated as GTT, unfortunately a
+	 * small region of bottom VRAM was encroached by UMC firmware during
+	 * GDDR6 BIST training, this cause page fault.
+	 * The page fault can be fixed by forcing stolen_size to 3MB, then the
+	 * bottom region of VRAM was allocated as stolen memory, GTT corruption
+	 * avoid.
+	 */
+	adev->gmc.stolen_size = max(adev->gmc.stolen_size,
+				    AMDGPU_STOLEN_VGA_DEFAULT_SIZE);
+
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
 	if (r)
@@ -789,6 +807,13 @@ static void gmc_v10_0_gart_fini(struct amdgpu_device *adev)
 static int gmc_v10_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	void *stolen_vga_buf;
+
+	/*
+	 * Free the stolen memory if it wasn't already freed in late_init
+	 * because of memory training.
+	 */
+	amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga_buf);
 
 	amdgpu_vm_manager_fini(adev);
 	gmc_v10_0_gart_fini(adev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
