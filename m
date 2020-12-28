Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4945C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF35207CC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF35207CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8111189A74;
	Mon, 28 Dec 2020 09:18:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3CC89A74
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 09:18:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb4fJcIpkAJV0bxB8QiXO0aeoXrI/7n6i/2ktVW0gf4Ez8qgtKYX21/gXhh33FoRtWeYcFD7vVheJuAADFTWO7+2cySnX9/LN4mL83eUPuyY/fEQ1j/GQc9lQZOsja9rYB33qRuLtEauOg2s4NNVuFpT6qJlOku8di5rh1zwGUpMjlAkKXnxgnz+kiSJqkfvnH71h6uXp9riQA/T/nRHKtLk9MbMvftaeZf3D3FCz6IO+2ROV/c31Y2XSSoL3+/Wy+1DPNDtA9ilH9yS1FezfIYl3T6/dCMiCC2OE33S0EvF4EFS8Q4Tkz2XAUKPcIp8Bnqa0wIrfTuGeEg4VfSB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrViPoOtosMMw15OWDsiqDqBF9tmrzGSFmoNbXqCYA0=;
 b=oe3BgCL540M9TZK/2RFMimM02Ex06NugFyd2r7mMjAQgPNSx01nXiw+g63/pi3UXh9jm5NOUqyw0Bh9NmPDM7zhahcs1cT+KHuzdMT6nNBQs2F2hAMN9S1tee+mjZ0QjgBN8+BwEtAkLf/9WOi1jNIMkSPpsAlxQcxKs0b6mmg5YUu1ZyUmb4/TfFsOCPOspAV4IkhGyUZ4F3DrHzBupvt6ycGZAcJNs91IRvwikkEkvnTYs2gK3sbNxyPb8i8jGZMEZGGCLkRVIHK9tCJsgsfLonc27K7O1LOMTDJtggtl4gRK0VKiLIv/U/C0ppggo5xLSK49K6bvMZtMNXymaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrViPoOtosMMw15OWDsiqDqBF9tmrzGSFmoNbXqCYA0=;
 b=JyqTwicxyqwKJyJ/IrWSAItYkYfgyVgeHoHLhAChEdcRYUBA+HnhkACqX/W4zvP70axndbaCsqk1XbDkNEzwuHpNJhNjTETRsvh8YVJ7HYCsjly0p4SdnQ2dKxRSlqzlUnHMnsnSXgJwJmNdVsym1p0irzIzvuO90kfrEPhNaAM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 09:18:56 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Mon, 28 Dec
 2020 09:18:56 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: switch hdp callback functions for hdp v5
Date: Mon, 28 Dec 2020 17:18:33 +0800
Message-Id: <20201228091834.3240927-4-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201228091834.3240927-1-likun.gao@amd.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.12 via Frontend Transport; Mon, 28 Dec 2020 09:18:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b74c1d1f-d431-446b-9c7d-08d8ab119a6b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB450849E95979F122629BA345EFD90@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2RPG8+1EOsAAD2Gh9X3iEbRE1Vu9PHOb+7x1M/w5cZXaY9M85WwkTNVyLmmD2fqmKR8aU0mreU9estJ69cMP1M41YKpmgAEPIheHDz0RSBtYg1cXu6BHsYHoIX8ivJYjtoBE78mg19vlhY3MW9clyUC3R2YAUo/Y+vLTNdKYDmhJKWM9tsQJDT0Kp2CuEpcFzUpAMO19ek8qsQSNeNy+S+QH6khZdBfqT2P+aBpX1ezabZ8uNIllC9z/g+D7k0HlnrX2fOw2OWWw+HZDfOlQq3UUuDDSFQUgggH0oUPiXjA8Xc4vph4DfOR4sytRHEwpMk662ZHEFgmut+PK1BKn4xwRUKHhfHqFpNcx8LFUDXkPgMkTU6fnBg9pQdsTmOEboLFouyiMPpn1A8rtAEr1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(16526019)(66946007)(316002)(2616005)(956004)(478600001)(86362001)(83380400001)(44832011)(4326008)(6666004)(8936002)(8676002)(30864003)(52116002)(36756003)(1076003)(7696005)(6486002)(5660300002)(26005)(54906003)(2906002)(186003)(66556008)(66476007)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GlyHCCkNQvewWFol1xD1oy7B+10J9NcwZs3mXb4LhJ2597njFzLoLnaPV3Xj?=
 =?us-ascii?Q?mlyaiUOuDblZdBCuLE6LzzxaDFG7irEK7ZdXWcannd/PQvzbcvCG3wM+/GH3?=
 =?us-ascii?Q?D2+Mxr5q8Iiq9/cmGg2m5e4WvxmY/Mj5RyLPN2Wmp1lchFoEuwjf0Guq8JnC?=
 =?us-ascii?Q?o52PxBiGLtKM9UiFgJNHBXHUOGNGhL5fvjlbPZsABXzsfNMpW/dxUblvo+d+?=
 =?us-ascii?Q?p/k2AtZ68fXH6psyJGCE55zoqNTbAVpuSjNdmV0mSThW4SJFOM/mtBwx6vtB?=
 =?us-ascii?Q?a2+zJ0SHTs2SjzOa1C7ru/PlFQ/IJXyt0peGvAezI+nsk5+Dt3C1NemiJ3lx?=
 =?us-ascii?Q?Pi5V1r9LkamEaqwgz90WKosOMqO4xaIsu37KX9uw8zBuo+iAUDBfU5zdiX4U?=
 =?us-ascii?Q?KbRwZIuUV2lInp3n3+f05aFbYLROsE4UQVImS9mLyDSlfy+oy8hqjH/c1c/v?=
 =?us-ascii?Q?ULSvjCNdSLbuvCUZJeLfduEk9/nW0NqefHOdnB3G0VtzQUeblPpr6Ueh3nDV?=
 =?us-ascii?Q?y6meCSgnANDxT8tAFZ5nOaV99/KmwANp3rtpIk8cmHqe3q7w1hMzpK/pbenj?=
 =?us-ascii?Q?RGJC5IWv/eMPT+Bx9lW1Vru9wd7xOFOU+0K9qMLe+VA0SOCYSPQ4H1nlQnS+?=
 =?us-ascii?Q?gcZ7wBTti/mqh9rcNhqIUf2Gjv2yvpm5If7lJjVaVn1xfptq8hHbgA+vpPrp?=
 =?us-ascii?Q?aDWjprHMwAqdASff0hUg2SQjk6iLY6Gj4RaaavFrZ1qSmmcEG6NuwySymtjL?=
 =?us-ascii?Q?I4mOOvWa4/+oegCzGIuWrqv4vJXARz5YKbR+x7Fz08mAtLmxqxkqh7Fapnf/?=
 =?us-ascii?Q?06g9PkkFYysWAg3BMeLNvK5U/ojt7zbfWGvky4fAbM7C3Q5o4NQxj81jZX8D?=
 =?us-ascii?Q?I+rT8bfvbDtb/PnjWaJd5MBWQmEXVk2T5FyHa0K4G/hZqyyEv3Wlg1dRduaH?=
 =?us-ascii?Q?hQeJwtlX9kMKM20DHTp02EoQR3bksAyXjwLBhg9f3+QNsjSVK7fIXbGunqa4?=
 =?us-ascii?Q?0RsO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 09:18:56.5602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: b74c1d1f-d431-446b-9c7d-08d8ab119a6b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ol8U4NZSsIJYYc9/1sGa3I3ZXBu8uV1jcYYQMRZCwwaPF80JUND2kUqHYrYg0bH9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Switch to use the HDP functions which unfied on hdp structure instead of
the scattered hdp callback functions.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: If70683c8cb697a9e7a1ea5a21aa2ed84567e6919
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |  14 +--
 drivers/gpu/drm/amd/amdgpu/nv.c        | 160 +------------------------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c |   2 +-
 5 files changed, 13 insertions(+), 174 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index d741fee91a37..e74cd443063a 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o
+	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ba1086784525..10aae0abcffb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -38,7 +38,6 @@
 #include "smuio/smuio_11_0_0_offset.h"
 #include "smuio/smuio_11_0_0_sh_mask.h"
 #include "navi10_enum.h"
-#include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
 
 #include "soc15.h"
@@ -5691,7 +5690,7 @@ static int gfx_v10_0_cp_gfx_load_pfp_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_PFP_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_CNTL, VMID, 0);
@@ -5769,7 +5768,7 @@ static int gfx_v10_0_cp_gfx_load_ce_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CE_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CE_IC_BASE_CNTL, VMID, 0);
@@ -5846,7 +5845,7 @@ static int gfx_v10_0_cp_gfx_load_me_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_ME_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_CNTL, VMID, 0);
@@ -6215,7 +6214,7 @@ static int gfx_v10_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_emu_mode == 1)
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_CPC_IC_BASE_CNTL);
 	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_CNTL, CACHE_POLICY, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5648c48be77f..3b7c6c31fce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -27,8 +27,6 @@
 #include "gmc_v10_0.h"
 #include "umc_v8_7.h"
 
-#include "hdp/hdp_5_0_0_offset.h"
-#include "hdp/hdp_5_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_sh_mask.h"
 #include "athub/athub_2_0_0_offset.h"
 #include "dcn/dcn_2_0_0_offset.h"
@@ -312,7 +310,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	int r;
 
 	/* flush hdp cache */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	/* For SRIOV run time, driver shouldn't access the register through MMIO
 	 * Directly use kiq to do the vm invalidation instead
@@ -995,7 +993,6 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 {
 	int r;
 	bool value;
-	u32 tmp;
 
 	if (adev->gart.bo == NULL) {
 		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
@@ -1014,15 +1011,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL);
-	tmp |= HDP_MISC_CNTL__FLUSH_INVALIDATE_CACHE_MASK;
-	WREG32_SOC15(HDP, 0, mmHDP_MISC_CNTL, tmp);
-
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL);
-	WREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL, tmp);
+	adev->hdp.funcs->init_registers(adev);
 
 	/* Flush HDP after it is initialized */
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 6bee3677394a..1d785f06c79d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -38,8 +38,6 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
-#include "hdp/hdp_5_0_0_offset.h"
-#include "hdp/hdp_5_0_0_sh_mask.h"
 #include "smuio/smuio_11_0_0_offset.h"
 #include "mp/mp_11_0_offset.h"
 
@@ -50,6 +48,7 @@
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
 #include "nbio_v7_2.h"
+#include "hdp_v5_0.h"
 #include "nv.h"
 #include "navi10_ih.h"
 #include "gfx_v10_0.h"
@@ -514,6 +513,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v2_3_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
 	}
+	adev->hdp.funcs = &hdp_v5_0_funcs;
 
 	if (adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->gmc.xgmi.supported = true;
@@ -669,22 +669,6 @@ static uint32_t nv_get_rev_id(struct amdgpu_device *adev)
 	return adev->nbio.funcs->get_rev_id(adev);
 }
 
-static void nv_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
-{
-	adev->nbio.funcs->hdp_flush(adev, ring);
-}
-
-static void nv_invalidate_hdp(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	} else {
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-					HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
-	}
-}
-
 static bool nv_need_full_reset(struct amdgpu_device *adev)
 {
 	return true;
@@ -788,8 +772,6 @@ static const struct amdgpu_asic_funcs nv_asic_funcs =
 	.set_uvd_clocks = &nv_set_uvd_clocks,
 	.set_vce_clocks = &nv_set_vce_clocks,
 	.get_config_memsize = &nv_get_config_memsize,
-	.flush_hdp = &nv_flush_hdp,
-	.invalidate_hdp = &nv_invalidate_hdp,
 	.init_doorbell_index = &nv_init_doorbell_index,
 	.need_full_reset = &nv_need_full_reset,
 	.need_reset_on_init = &nv_need_reset_on_init,
@@ -1080,120 +1062,6 @@ static int nv_common_soft_reset(void *handle)
 	return 0;
 }
 
-static void nv_update_hdp_mem_power_gating(struct amdgpu_device *adev,
-					   bool enable)
-{
-	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
-	uint32_t hdp_mem_pwr_cntl;
-
-	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_HDP_DS |
-				AMD_CG_SUPPORT_HDP_SD)))
-		return;
-
-	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
-
-	/* Before doing clock/power mode switch,
-	 * forced on IPH & RC clock */
-	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
-				     IPH_MEM_CLK_SOFT_OVERRIDE, 1);
-	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
-				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
-
-	/* HDP 5.0 doesn't support dynamic power mode switch,
-	 * disable clock and power gating before any changing */
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_CTRL_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_LS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_DS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 IPH_MEM_POWER_SD_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_CTRL_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_LS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_DS_EN, 0);
-	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-					 RC_MEM_POWER_SD_EN, 0);
-	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
-
-	/* only one clock gating mode (LS/DS/SD) can be enabled */
-	if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_LS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_LS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_DS_EN, enable);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 IPH_MEM_POWER_SD_EN, enable);
-		/* RC should not use shut down mode, fallback to ds */
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
-						 HDP_MEM_POWER_CTRL,
-						 RC_MEM_POWER_DS_EN, enable);
-	}
-
-	/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
-	 * be set for SRAM LS/DS/SD */
-	if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
-							AMD_CG_SUPPORT_HDP_SD)) {
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						IPH_MEM_POWER_CTRL_EN, 1);
-		hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
-						RC_MEM_POWER_CTRL_EN, 1);
-	}
-
-	WREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
-
-	/* restore IPH & RC clock override after clock/power mode changing */
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl1);
-}
-
-static void nv_update_hdp_clock_gating(struct amdgpu_device *adev,
-				       bool enable)
-{
-	uint32_t hdp_clk_cntl;
-
-	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
-		return;
-
-	hdp_clk_cntl = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-
-	if (enable) {
-		hdp_clk_cntl &=
-			~(uint32_t)
-			  (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			   HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
-	} else {
-		hdp_clk_cntl |= HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
-	}
-
-	WREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL, hdp_clk_cntl);
-}
-
 static int nv_common_set_clockgating_state(void *handle,
 					   enum amd_clockgating_state state)
 {
@@ -1213,9 +1081,7 @@ static int nv_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		nv_update_hdp_mem_power_gating(adev,
-				   state == AMD_CG_STATE_GATE);
-		nv_update_hdp_clock_gating(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
 	default:
@@ -1234,31 +1100,13 @@ static int nv_common_set_powergating_state(void *handle,
 static void nv_common_get_clockgating_state(void *handle, u32 *flags)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	uint32_t tmp;
 
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
 	adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	/* AMD_CG_SUPPORT_HDP_MGCG */
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_CLK_CNTL);
-	if (!(tmp & (HDP_CLK_CNTL__IPH_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
-		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
-		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
-
-	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_MEM_POWER_CTRL);
-	if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_LS;
-	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_DS_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_DS;
-	else if (tmp & HDP_MEM_POWER_CTRL__IPH_MEM_POWER_SD_EN_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_SD;
+	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	return;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index a738a7d7e383..c325d6f53a71 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -690,7 +690,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
 		}
 
 		memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
-		adev->nbio.funcs->hdp_flush(adev, NULL);
+		adev->hdp.funcs->flush_hdp(adev, NULL);
 		vfree(buf);
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
