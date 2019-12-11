Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7A2C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B212077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ID45BaU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B212077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B576EB7A;
	Wed, 11 Dec 2019 15:33:41 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D7E6EB82
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWziZkhx6wZFSXjMAnh/JOlCrPQPpBNDh3mDcnUlHfCjf2Le/Hes5qgQVfQckEU2aQeKwYBCggt+KaWI4uE8BTawm9KMHSynZpwn2UJh0U08thG7zZeTbQ3s/+vF4Xqx5OKilSxlN4GTqBuV7Iv2o9U8Hl8uBVCLNp4O2uZ1RtMXvYcOfZI/dv/5NCbE9WrAcs+5uK1+tkWxORnGlaag7IQzktR5IIBkdFnBmJk18oy+VugSkvib+H+d1C+7xLZha1cOZO6dU8wJhFbPHMhbYIn9iOdUbvRbr6UUqdDmWLJuipa+WLW2pLU5uGc59v+8+BywVMMEYTU2m0U1VLybtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGCjWuyKd4efprrbCGqqYU2ONcIyYZ7zPnPLYgxqHKM=;
 b=Bk4rr96xi39nY+wPVIo2n74LzmbWRdUV74XhO4bgJw4HdVZQePKyiyW4BjlLIUOHBLNKH6cQOUoQXF0YNFgf4mDmP9yJUDKC0IPJOaRx7JVqb5CKK+QMiNJ5TCnILmAvTDSMdHmTc32JhVR9FTU61kaAtAwKegTBlpE+fY32/NXEURJj/VjqTt+6vtbAZiwzIZB3DCfazDOLbeaPvAFNOq5pNuXgUvVksxj/DUJ526sQJNY056oUhkL7ZwFBW2bi2TT/KZB2cLU7tw6G3RxkI5A2QjPdDAZq41Tl67w5FHUpwNovWfal0MbRp5s2UMmbKMOpKMb2nMYuACgpktE89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGCjWuyKd4efprrbCGqqYU2ONcIyYZ7zPnPLYgxqHKM=;
 b=ID45BaU8nKrRo1l/KXbNErn/PKjOjcX42b1sz1spLqVgWppeh3FvYmOpfAVP5LcS7M8j/vk5Xf5r9la316y8YPHiLyYfAuN+ytdE4uCJuo7zAfWG3w1XYNI4hRe6QmKBSIuFWcz6Mo9kjCJQpbEaSWjatb+4/UJJSlciFVY1ouk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:36 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:36 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/39] drm/amd/display: Perform DMUB hw_init on resume
Date: Wed, 11 Dec 2019 10:32:36 -0500
Message-Id: <20191211153253.2291112-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a2a9b29-17e1-440a-21f0-08d77e4f7cf0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491BDBCE173F0D687DBA88D985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(30864003)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nj/o2TVDaIfMuL9i/wQtUUyygvHyhh9p+XS+UGrAumH+LjXSb8QArecbF3xe1Syb5U0FHSghEQD0/4lhm9k98xGw2IzYZ2tdiE4CCgBP8yx6xaxY3MQ6Lp6VQhDISh4y5JgF4DYfn0xqcZ17kooY0m8wij7f6/ps/rtAoUI2xA1IhCuUPlrlZegAbjvzp0VDk/Wyt52EJDHL32VUuwQwuo/qWZJiEIm5Ul3z8VsQbbZVvcBJQUoMYdByo6k4BiOTILmKGFED96pBbNSMuKxSWvebfaLhpVtOnrm9Yr6yjk2pBvMdWWNCkK3Yr5OpMXd/kcITMHmDwfQ3rH5iNKQDNNL4Yy55yI4z4DGyPiX6ucTxQC7hmgg10gPLpIXN7F8U8H2MlRbVIj4wu0GPOEPnCzykDxlvBGIccnKG/37LP6e/sAvlfT1BS9A1ETHVToyO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2a9b29-17e1-440a-21f0-08d77e4f7cf0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:36.2511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X0LoNrH4SOicavlw9MvdYwgOibiFZlUCyZkDtGSqSNOjJMEMSEyaX+DWPYfTDPNfkqM0qLZvfI6OOv1LWMq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Roman Li <Roman.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
The DMUB is put into reset on suspend and is not running on resume,
disabling PSR/ABM features.

[How]
Move the allocation of the framebuffer to sw_init.

Do DMUB hardware init and framebuffer filling only from hw_init.

On resume the contents of the framebuffer will be invalid so those
should be cleared.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 196 +++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +
 2 files changed, 128 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7972286bac23..8cdfb3ccb710 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -98,6 +98,12 @@ MODULE_FIRMWARE(FIRMWARE_RENOIR_DMUB);
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
 
+/* Number of bytes in PSP header for firmware. */
+#define PSP_HEADER_BYTES 0x100
+
+/* Number of bytes in PSP footer for firmware. */
+#define PSP_FOOTER_BYTES 0x100
+
 /**
  * DOC: overview
  *
@@ -741,28 +747,27 @@ void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 
 static int dm_dmub_hw_init(struct amdgpu_device *adev)
 {
-	const unsigned int psp_header_bytes = 0x100;
-	const unsigned int psp_footer_bytes = 0x100;
 	const struct dmcub_firmware_header_v1_0 *hdr;
 	struct dmub_srv *dmub_srv = adev->dm.dmub_srv;
+	struct dmub_srv_fb_info *fb_info = adev->dm.dmub_fb_info;
 	const struct firmware *dmub_fw = adev->dm.dmub_fw;
 	struct dmcu *dmcu = adev->dm.dc->res_pool->dmcu;
 	struct abm *abm = adev->dm.dc->res_pool->abm;
-	struct dmub_srv_region_params region_params;
-	struct dmub_srv_region_info region_info;
-	struct dmub_srv_fb_params fb_params;
-	struct dmub_srv_fb_info fb_info;
 	struct dmub_srv_hw_params hw_params;
 	enum dmub_status status;
 	const unsigned char *fw_inst_const, *fw_bss_data;
-	uint32_t i;
-	int r;
+	uint32_t i, fw_inst_const_size, fw_bss_data_size;
 	bool has_hw_support;
 
 	if (!dmub_srv)
 		/* DMUB isn't supported on the ASIC. */
 		return 0;
 
+	if (!fb_info) {
+		DRM_ERROR("No framebuffer info for DMUB service.\n");
+		return -EINVAL;
+	}
+
 	if (!dmub_fw) {
 		/* Firmware required for DMUB support. */
 		DRM_ERROR("No firmware provided for DMUB.\n");
@@ -782,60 +787,36 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	hdr = (const struct dmcub_firmware_header_v1_0 *)dmub_fw->data;
 
-	/* Calculate the size of all the regions for the DMUB service. */
-	memset(&region_params, 0, sizeof(region_params));
-
-	region_params.inst_const_size = le32_to_cpu(hdr->inst_const_bytes) -
-					psp_header_bytes - psp_footer_bytes;
-	region_params.bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
-	region_params.vbios_size = adev->dm.dc->ctx->dc_bios->bios_size;
-
-	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
-					   &region_info);
-
-	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error calculating DMUB region info: %d\n", status);
-		return -EINVAL;
-	}
-
-	/*
-	 * Allocate a framebuffer based on the total size of all the regions.
-	 * TODO: Move this into GART.
-	 */
-	r = amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_VRAM, &adev->dm.dmub_bo,
-				    &adev->dm.dmub_bo_gpu_addr,
-				    &adev->dm.dmub_bo_cpu_addr);
-	if (r)
-		return r;
-
-	/* Rebase the regions on the framebuffer address. */
-	memset(&fb_params, 0, sizeof(fb_params));
-	fb_params.cpu_addr = adev->dm.dmub_bo_cpu_addr;
-	fb_params.gpu_addr = adev->dm.dmub_bo_gpu_addr;
-	fb_params.region_info = &region_info;
-
-	status = dmub_srv_calc_fb_info(dmub_srv, &fb_params, &fb_info);
-	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error calculating DMUB FB info: %d\n", status);
-		return -EINVAL;
-	}
-
 	fw_inst_const = dmub_fw->data +
 			le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
-			psp_header_bytes;
+			PSP_HEADER_BYTES;
 
 	fw_bss_data = dmub_fw->data +
 		      le32_to_cpu(hdr->header.ucode_array_offset_bytes) +
 		      le32_to_cpu(hdr->inst_const_bytes);
 
 	/* Copy firmware and bios info into FB memory. */
-	memcpy(fb_info.fb[DMUB_WINDOW_0_INST_CONST].cpu_addr, fw_inst_const,
-	       region_params.inst_const_size);
-	memcpy(fb_info.fb[DMUB_WINDOW_2_BSS_DATA].cpu_addr, fw_bss_data,
-	       region_params.bss_data_size);
-	memcpy(fb_info.fb[DMUB_WINDOW_3_VBIOS].cpu_addr,
-	       adev->dm.dc->ctx->dc_bios->bios, region_params.vbios_size);
+	fw_inst_const_size = le32_to_cpu(hdr->inst_const_bytes) -
+			     PSP_HEADER_BYTES - PSP_FOOTER_BYTES;
+
+	fw_bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
+
+	memcpy(fb_info->fb[DMUB_WINDOW_0_INST_CONST].cpu_addr, fw_inst_const,
+	       fw_inst_const_size);
+	memcpy(fb_info->fb[DMUB_WINDOW_2_BSS_DATA].cpu_addr, fw_bss_data,
+	       fw_bss_data_size);
+	memcpy(fb_info->fb[DMUB_WINDOW_3_VBIOS].cpu_addr, adev->bios,
+	       adev->bios_size);
+
+	/* Reset regions that need to be reset. */
+	memset(fb_info->fb[DMUB_WINDOW_4_MAILBOX].cpu_addr, 0,
+	fb_info->fb[DMUB_WINDOW_4_MAILBOX].size);
+
+	memset(fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].cpu_addr, 0,
+	       fb_info->fb[DMUB_WINDOW_5_TRACEBUFF].size);
+
+	memset(fb_info->fb[DMUB_WINDOW_6_FW_STATE].cpu_addr, 0,
+	       fb_info->fb[DMUB_WINDOW_6_FW_STATE].size);
 
 	/* Initialize hardware. */
 	memset(&hw_params, 0, sizeof(hw_params));
@@ -845,8 +826,8 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	if (dmcu)
 		hw_params.psp_version = dmcu->psp_version;
 
-	for (i = 0; i < fb_info.num_fb; ++i)
-		hw_params.fb[i] = &fb_info.fb[i];
+	for (i = 0; i < fb_info->num_fb; ++i)
+		hw_params.fb[i] = &fb_info->fb[i];
 
 	status = dmub_srv_hw_init(dmub_srv, &hw_params);
 	if (status != DMUB_STATUS_OK) {
@@ -1174,6 +1155,11 @@ static void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address,
 static int dm_dmub_sw_init(struct amdgpu_device *adev)
 {
 	struct dmub_srv_create_params create_params;
+	struct dmub_srv_region_params region_params;
+	struct dmub_srv_region_info region_info;
+	struct dmub_srv_fb_params fb_params;
+	struct dmub_srv_fb_info *fb_info;
+	struct dmub_srv *dmub_srv;
 	const struct dmcub_firmware_header_v1_0 *hdr;
 	const char *fw_name_dmub;
 	enum dmub_asic dmub_asic;
@@ -1191,24 +1177,6 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	adev->dm.dmub_srv = kzalloc(sizeof(*adev->dm.dmub_srv), GFP_KERNEL);
-	if (!adev->dm.dmub_srv) {
-		DRM_ERROR("Failed to allocate DMUB service!\n");
-		return -ENOMEM;
-	}
-
-	memset(&create_params, 0, sizeof(create_params));
-	create_params.user_ctx = adev;
-	create_params.funcs.reg_read = amdgpu_dm_dmub_reg_read;
-	create_params.funcs.reg_write = amdgpu_dm_dmub_reg_write;
-	create_params.asic = dmub_asic;
-
-	status = dmub_srv_create(adev->dm.dmub_srv, &create_params);
-	if (status != DMUB_STATUS_OK) {
-		DRM_ERROR("Error creating DMUB service: %d\n", status);
-		return -EINVAL;
-	}
-
 	r = request_firmware_direct(&adev->dm.dmub_fw, fw_name_dmub, adev->dev);
 	if (r) {
 		DRM_ERROR("DMUB firmware loading failed: %d\n", r);
@@ -1238,6 +1206,76 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	DRM_INFO("Loading DMUB firmware via PSP: version=0x%08X\n",
 		 adev->dm.dmcub_fw_version);
 
+	adev->dm.dmub_srv = kzalloc(sizeof(*adev->dm.dmub_srv), GFP_KERNEL);
+	dmub_srv = adev->dm.dmub_srv;
+
+	if (!dmub_srv) {
+		DRM_ERROR("Failed to allocate DMUB service!\n");
+		return -ENOMEM;
+	}
+
+	memset(&create_params, 0, sizeof(create_params));
+	create_params.user_ctx = adev;
+	create_params.funcs.reg_read = amdgpu_dm_dmub_reg_read;
+	create_params.funcs.reg_write = amdgpu_dm_dmub_reg_write;
+	create_params.asic = dmub_asic;
+
+	/* Create the DMUB service. */
+	status = dmub_srv_create(dmub_srv, &create_params);
+	if (status != DMUB_STATUS_OK) {
+		DRM_ERROR("Error creating DMUB service: %d\n", status);
+		return -EINVAL;
+	}
+
+	/* Calculate the size of all the regions for the DMUB service. */
+	memset(&region_params, 0, sizeof(region_params));
+
+	region_params.inst_const_size = le32_to_cpu(hdr->inst_const_bytes) -
+					PSP_HEADER_BYTES - PSP_FOOTER_BYTES;
+	region_params.bss_data_size = le32_to_cpu(hdr->bss_data_bytes);
+	region_params.vbios_size = adev->bios_size;
+
+	status = dmub_srv_calc_region_info(dmub_srv, &region_params,
+					   &region_info);
+
+	if (status != DMUB_STATUS_OK) {
+		DRM_ERROR("Error calculating DMUB region info: %d\n", status);
+		return -EINVAL;
+	}
+
+	/*
+	 * Allocate a framebuffer based on the total size of all the regions.
+	 * TODO: Move this into GART.
+	 */
+	r = amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM, &adev->dm.dmub_bo,
+				    &adev->dm.dmub_bo_gpu_addr,
+				    &adev->dm.dmub_bo_cpu_addr);
+	if (r)
+		return r;
+
+	/* Rebase the regions on the framebuffer address. */
+	memset(&fb_params, 0, sizeof(fb_params));
+	fb_params.cpu_addr = adev->dm.dmub_bo_cpu_addr;
+	fb_params.gpu_addr = adev->dm.dmub_bo_gpu_addr;
+	fb_params.region_info = &region_info;
+
+	adev->dm.dmub_fb_info =
+		kzalloc(sizeof(*adev->dm.dmub_fb_info), GFP_KERNEL);
+	fb_info = adev->dm.dmub_fb_info;
+
+	if (!fb_info) {
+		DRM_ERROR(
+			"Failed to allocate framebuffer info for DMUB service!\n");
+		return -ENOMEM;
+	}
+
+	status = dmub_srv_calc_fb_info(dmub_srv, &fb_params, fb_info);
+	if (status != DMUB_STATUS_OK) {
+		DRM_ERROR("Error calculating DMUB FB info: %d\n", status);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1257,6 +1295,9 @@ static int dm_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	kfree(adev->dm.dmub_fb_info);
+	adev->dm.dmub_fb_info = NULL;
+
 	if (adev->dm.dmub_srv) {
 		dmub_srv_destroy(adev->dm.dmub_srv);
 		adev->dm.dmub_srv = NULL;
@@ -1559,7 +1600,7 @@ static int dm_resume(void *handle)
 	struct dm_plane_state *dm_new_plane_state;
 	struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
 	enum dc_connection_type new_connection_type = dc_connection_none;
-	int i;
+	int i, r;
 
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
 	dc_release_state(dm_state->context);
@@ -1567,6 +1608,11 @@ static int dm_resume(void *handle)
 	/* TODO: Remove dc_state->dccg, use dc->dccg directly. */
 	dc_resource_state_construct(dm->dc, dm_state->context);
 
+	/* Before powering on DC we need to re-initialize DMUB. */
+	r = dm_dmub_hw_init(adev);
+	if (r)
+		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+
 	/* power on hardware */
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ae36d99d0fb2..a30c231f0148 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -132,6 +132,13 @@ struct amdgpu_display_manager {
 	 */
 	struct dmub_srv *dmub_srv;
 
+	/**
+	 * @dmub_fb_info:
+	 *
+	 * Framebuffer regions for the DMUB.
+	 */
+	struct dmub_srv_fb_info *dmub_fb_info;
+
 	/**
 	 * @dmub_fw:
 	 *
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
