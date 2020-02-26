Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E74EC4BA18
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6270224656
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 17:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pGtaD12l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6270224656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AA76EB47;
	Wed, 26 Feb 2020 17:58:28 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750050.outbound.protection.outlook.com [40.107.75.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC97F6E442
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 17:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et5LFoegSieg5vjP4kifUeGYwLOqQqouNOwxltciLwg2pAFw0H17eKifJ9dDfYcbFCpRILkcJ7oDIQYA2JPPKV1ZmYWUooFL/3Y0cagVqVzrDBFUg4nl13KcmEqEepqcKV1SoJMqAZdXQbvD+G/Dmdh0plstvhPn5z2IZGIgNrDtMJieO7MYypKQ2rja/84mG97aH5GM79Woom3glkcmwqPmrdsQ0gSlSKy9d+YSRJVI8WYpyHjM1B4tm1oIQlbLvJM+u8tTQFNMpCpOcMACrClXeIyMRm8lV7wEkJTs61RVAhxoMVopYlgE60UBNIgZ2LdRgu2FAsRSrmy0PROB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2XbJkL8co3JIo6k0EjGOLjD1Hi3nlAEPJhSvQ+XFMw=;
 b=B/hODhIKs7VQ5NyTf5Gzj8BXCqEL13ca7qXzU2hRU2vBN3VW/4sVCpAGbAESrejqF0DPklIcUi2Twk87L4Tzu7SXlY5NgxTQCGwXk5/o62SpgX4PrN6edsyIUJziKl3ZR9xDRa/3rhMCPsYIuWDacMw+zuWVms8+QesrYXeCswNJVFVjQw4NdGXHALS5UJOtwpEu0FXw/GoxmYP3nX7DHsTkiyyrVpmGkuUq7pX+wZIa2lFCVot3T3+9NV76uxQ/pNRviZcGcWrNaf5RS0qhOgWACh2UqoYQZFqEM110pcq6lTAAw8VsCBFgSgUDbnI9AlM8zzn8xwz1V46nBfGE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2XbJkL8co3JIo6k0EjGOLjD1Hi3nlAEPJhSvQ+XFMw=;
 b=pGtaD12lBAnQ0Uf5NKvhY5LmGKfR7S9nUBqF6nNhQWl9Bhzc8ZfEJZow9cYtTLUXJhSE/snP5hXvn8ewDIwCqmZ94/gLgKXlLJVHNR9OgxnIREPiS4/V6Yvvz6ayBOLxkOlSrDykyFy59ZN0Ip7VZ0sKLrMwjLguJQ1uVw5ky2w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3831.namprd12.prod.outlook.com (2603:10b6:610:29::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 17:58:26 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 17:58:26 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: Make get_tile_config() generic
Date: Wed, 26 Feb 2020 12:58:12 -0500
Message-Id: <20200226175812.31788-2-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226175812.31788-1-Yong.Zhao@amd.com>
References: <20200226175812.31788-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35)
 To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YT1PR01CA0022.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 17:58:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a871a029-063f-408d-c8dd-08d7bae57a31
X-MS-TrafficTypeDiagnostic: CH2PR12MB3831:|CH2PR12MB3831:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3831F1A1F59962A965825F42F0EA0@CH2PR12MB3831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(956004)(66476007)(4326008)(81166006)(8676002)(2616005)(2906002)(26005)(478600001)(81156014)(8936002)(30864003)(7696005)(1076003)(5660300002)(36756003)(6486002)(186003)(66946007)(86362001)(6666004)(16526019)(52116002)(316002)(6916009)(66556008)(41533002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3831;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4y8EX77odQj02nHTFGz7fdQ06zRNYoSg+SdXyjVHB6ze80yRUpLOL1bIKf/wchnDf/D7pfAXI84ba39DUFKGsL/TeXzR4G94p5T6nNxnswL5IcEtwbEIvt8BNhlNCfUN37GWm7fqAVQox8Mrx5Cv2U3Abj0YGJBfB7lJWu4jZ2I6cVvqeyu348Hc0a3xZSzaFIZFpB0WMrnRB8/KNHL5hAkOy82m3X/lNqVdHrH4kK7Wz0X95aY5gr6oDgTSKZGGrBIHOWDjCmpojte46PdKr1WP2Is7kbyurmaqaCtX20AUvO8bs6XLQlNr/gb+yPRQ9yLXKD2N5KrHbEASoPNNEb995TDBm2V+Hx6oT40TI1tMc7QwvTGRkQUMOXFoW1dH4Lt2SMPqgngNDuLSLlviI/5U9CtsnREOWewmgEMNehG8IpnFAL95UN7jHHRB3yyZdQV/vIKqxCHMz9NXoeMXNdM8acEePV5T/BW7h7hJbzuIJ38b+v5YHRDOepyxJpFA
X-MS-Exchange-AntiSpam-MessageData: Am+JrpMR4Inj/TNrtfn+qbKYmf4LB6JUEiwgYgH2IuNHP8pKJgJuzAAtiEqLqzOL7IclKVbiatlO9CGVg4EZHmTmBEMg5zAA5sAnAwgYvfqr4ZSejfhJgjur+nigrtyL5CNJRcYBjzqVjPuRL6kEfA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a871a029-063f-408d-c8dd-08d7bae57a31
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 17:58:25.8333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOxomlcEZZ1vKApgJJcuy9pjEDNp+pv813jzwjxrBZyhCmDbfCOBGxjhmt9CswZ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3831
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Given we can query all the asic specific information from amdgpu_gfx_config,
we can make get_tile_config() generic.

Change-Id: I1080fec4d50c51bc84bb49b0145f8fec50081fce
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 ++
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  1 -
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 33 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 26 ---------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 26 ---------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 23 -------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  2 --
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 22 +++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  4 ---
 10 files changed, 26 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b0ad3be0b03f..13feb313e9b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -242,6 +242,9 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
 
+int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
+				struct tile_config *config);
+
 /* KGD2KFD callbacks */
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 4bcc175a149d..d6549e5ea7e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -319,7 +319,6 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.address_watch_get_offset = kgd_gfx_v9_address_watch_get_offset,
 	.get_atc_vmid_pasid_mapping_info =
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
-	.get_tile_config = kgd_gfx_v9_get_tile_config,
 	.set_vm_context_page_table_base = kgd_set_vm_context_page_table_base,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index ca91fffb8a36..4ec6d0c03201 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -42,38 +42,6 @@ enum hqd_dequeue_request_type {
 	SAVE_WAVES
 };
 
-/* Because of REG_GET_FIELD() being used, we put this function in the
- * asic specific file.
- */
-static int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
-		struct tile_config *config)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
-	config->gb_addr_config = adev->gfx.config.gb_addr_config;
-#if 0
-/* TODO - confirm REG_GET_FIELD x2, should be OK as is... but
- * MC_ARB_RAMCFG register doesn't exist on Vega10 - initial amdgpu
- * changes commented out related code, doing the same here for now but
- * need to sync with Ken et al
- */
-	config->num_banks = REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-				MC_ARB_RAMCFG, NOOFBANK);
-	config->num_ranks = REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-				MC_ARB_RAMCFG, NOOFRANKS);
-#endif
-
-	config->tile_config_ptr = adev->gfx.config.tile_mode_array;
-	config->num_tile_configs =
-			ARRAY_SIZE(adev->gfx.config.tile_mode_array);
-	config->macro_tile_config_ptr =
-			adev->gfx.config.macrotile_mode_array;
-	config->num_macro_tile_configs =
-			ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
-
-	return 0;
-}
-
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 {
 	return (struct amdgpu_device *)kgd;
@@ -805,7 +773,6 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.address_watch_get_offset = kgd_address_watch_get_offset,
 	.get_atc_vmid_pasid_mapping_info =
 			get_atc_vmid_pasid_mapping_info,
-	.get_tile_config = amdgpu_amdkfd_get_tile_config,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 	.get_unique_id = amdgpu_amdkfd_get_unique_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 8f052e98a3c6..0b7e78748540 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -84,31 +84,6 @@ union TCP_WATCH_CNTL_BITS {
 	float f32All;
 };
 
-/* Because of REG_GET_FIELD() being used, we put this function in the
- * asic specific file.
- */
-static int get_tile_config(struct kgd_dev *kgd,
-		struct tile_config *config)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
-	config->gb_addr_config = adev->gfx.config.gb_addr_config;
-	config->num_banks = REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-				MC_ARB_RAMCFG, NOOFBANK);
-	config->num_ranks = REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-				MC_ARB_RAMCFG, NOOFRANKS);
-
-	config->tile_config_ptr = adev->gfx.config.tile_mode_array;
-	config->num_tile_configs =
-			ARRAY_SIZE(adev->gfx.config.tile_mode_array);
-	config->macro_tile_config_ptr =
-			adev->gfx.config.macrotile_mode_array;
-	config->num_macro_tile_configs =
-			ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
-
-	return 0;
-}
-
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 {
 	return (struct amdgpu_device *)kgd;
@@ -730,7 +705,6 @@ const struct kfd2kgd_calls gfx_v7_kfd2kgd = {
 	.address_watch_get_offset = kgd_address_watch_get_offset,
 	.get_atc_vmid_pasid_mapping_info = get_atc_vmid_pasid_mapping_info,
 	.set_scratch_backing_va = set_scratch_backing_va,
-	.get_tile_config = get_tile_config,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
 	.read_vmid_from_vmfault_reg = read_vmid_from_vmfault_reg,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 19a10db93d68..ccd635b812b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -41,31 +41,6 @@ enum hqd_dequeue_request_type {
 	RESET_WAVES
 };
 
-/* Because of REG_GET_FIELD() being used, we put this function in the
- * asic specific file.
- */
-static int get_tile_config(struct kgd_dev *kgd,
-		struct tile_config *config)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
-	config->gb_addr_config = adev->gfx.config.gb_addr_config;
-	config->num_banks = REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-				MC_ARB_RAMCFG, NOOFBANK);
-	config->num_ranks = REG_GET_FIELD(adev->gfx.config.mc_arb_ramcfg,
-				MC_ARB_RAMCFG, NOOFRANKS);
-
-	config->tile_config_ptr = adev->gfx.config.tile_mode_array;
-	config->num_tile_configs =
-			ARRAY_SIZE(adev->gfx.config.tile_mode_array);
-	config->macro_tile_config_ptr =
-			adev->gfx.config.macrotile_mode_array;
-	config->num_macro_tile_configs =
-			ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
-
-	return 0;
-}
-
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 {
 	return (struct amdgpu_device *)kgd;
@@ -676,6 +651,5 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
 	.get_atc_vmid_pasid_mapping_info =
 			get_atc_vmid_pasid_mapping_info,
 	.set_scratch_backing_va = set_scratch_backing_va,
-	.get_tile_config = get_tile_config,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 7f91feff7c4f..df841c2ac5e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -48,28 +48,6 @@ enum hqd_dequeue_request_type {
 	RESET_WAVES
 };
 
-
-/* Because of REG_GET_FIELD() being used, we put this function in the
- * asic specific file.
- */
-int kgd_gfx_v9_get_tile_config(struct kgd_dev *kgd,
-		struct tile_config *config)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
-	config->gb_addr_config = adev->gfx.config.gb_addr_config;
-
-	config->tile_config_ptr = adev->gfx.config.tile_mode_array;
-	config->num_tile_configs =
-			ARRAY_SIZE(adev->gfx.config.tile_mode_array);
-	config->macro_tile_config_ptr =
-			adev->gfx.config.macrotile_mode_array;
-	config->num_macro_tile_configs =
-			ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
-
-	return 0;
-}
-
 static inline struct amdgpu_device *get_amdgpu_device(struct kgd_dev *kgd)
 {
 	return (struct amdgpu_device *)kgd;
@@ -736,7 +714,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.address_watch_get_offset = kgd_gfx_v9_address_watch_get_offset,
 	.get_atc_vmid_pasid_mapping_info =
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
-	.get_tile_config = kgd_gfx_v9_get_tile_config,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 	.get_unique_id = amdgpu_amdkfd_get_unique_id,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 63d3e6683dfe..aedf67d57449 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -60,5 +60,3 @@ uint32_t kgd_gfx_v9_address_watch_get_offset(struct kgd_dev *kgd,
 
 bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
 					uint8_t vmid, uint16_t *p_pasid);
-int kgd_gfx_v9_get_tile_config(struct kgd_dev *kgd,
-		struct tile_config *config);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e1d1eed7a25f..e4481caed648 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2242,3 +2242,25 @@ int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem)
 	kfree(mem);
 	return 0;
 }
+
+/* Returns GPU-specific tiling mode information */
+int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
+				struct tile_config *config)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
+
+	config->gb_addr_config = adev->gfx.config.gb_addr_config;
+	config->tile_config_ptr = adev->gfx.config.tile_mode_array;
+	config->num_tile_configs =
+			ARRAY_SIZE(adev->gfx.config.tile_mode_array);
+	config->macro_tile_config_ptr =
+			adev->gfx.config.macrotile_mode_array;
+	config->num_macro_tile_configs =
+			ARRAY_SIZE(adev->gfx.config.macrotile_mode_array);
+
+	/* Those values are not set from GFX9 onwards */
+	config->num_banks = adev->gfx.config.num_banks;
+	config->num_ranks = adev->gfx.config.num_ranks;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 675735b8243a..f8fa03a12add 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1169,7 +1169,7 @@ static int kfd_ioctl_get_tile_config(struct file *filep,
 	if (!dev)
 		return -EINVAL;
 
-	dev->kfd2kgd->get_tile_config(dev->kgd, &config);
+	amdgpu_amdkfd_get_tile_config(dev->kgd, &config);
 
 	args->gb_addr_config = config.gb_addr_config;
 	args->num_banks = config.num_banks;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index abc0eb4ac493..0cee79d56075 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -223,8 +223,6 @@ struct tile_config {
  * @set_scratch_backing_va: Sets VA for scratch backing memory of a VMID.
  * Only used for no cp scheduling mode
  *
- * @get_tile_config: Returns GPU-specific tiling mode information
- *
  * @set_vm_context_page_table_base: Program page table base for a VMID
  *
  * @invalidate_tlbs: Invalidate TLBs for a specific PASID
@@ -310,8 +308,6 @@ struct kfd2kgd_calls {
 	void (*set_scratch_backing_va)(struct kgd_dev *kgd,
 				uint64_t va, uint32_t vmid);
 
-	int (*get_tile_config)(struct kgd_dev *kgd, struct tile_config *config);
-
 	void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t page_table_base);
 	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
