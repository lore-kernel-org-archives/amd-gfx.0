Return-Path: <SRS0=yA2I=GB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC63DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 07:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 749AB208D5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Dec 2020 07:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749AB208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B190892A9;
	Tue, 29 Dec 2020 07:32:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4161892A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Dec 2020 07:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWR6nSRbWJeEIwI7yKQptImtNqWHUGEN5kvmgbmf5TB8cq5+IXwBMfHEx/ThW2clcN54t19KFy6KUxxvAskIrP2Qy18thVakys5kbeS4hylZx8ROk+D17wGlJUTPG8U4+MMJNHX41kidWmDXlSxfDNtF5w7xs8zqQKcS5Lt6oIJRCEOFbtgWnb6KiN1rt4UaimplDcIBPeQ8Xf9pzclamyCxL5wsiJ8//0rugivSJizDC7sbCGjLJeEPeHMc1k1xfjFlkEzJ+RHS8NYaPwMkLKOAjtjFCijpDekUj9YiR4MDTCu3/+mxlaGyNegB1UMOaWAWrE0musOkwLbjhxU3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrk1LgwkF6rvNoVsdwF+6MQHMfneUEp4a2WXNzswEHY=;
 b=ItRdizubvo34nWWUDnZAgQJk79Nk/5NKfdWdaGk7iJsJ7dxfF/vJ3alfuvlm7sN9cE4AhbmtVO11UGupWB4ryfNb7RpiccIB5Tt/m57+jj5Xx2glpyv+4309Unwe+jpyQ8kfLIzEby0JyI2I1C9aLPIImvuzfnl2xBbhEOEDt+cCTE7iDHt4hO8u2Ksk+TcXFCDy8MFfhcZuAmp0bPyKvNPTp509tDGjE2TCOS57x7R7YaCRabQUbYFnmZV9VRk6wmI3XHUUzTnid6em+ds5M/DQrcN3QRypKzDsStpSA6GTzUJt5HCxXEkUGychFewQJFXXpIubtL2TqhjTHss3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrk1LgwkF6rvNoVsdwF+6MQHMfneUEp4a2WXNzswEHY=;
 b=avDc2RO3fyeqf5orI6zb9pofChm/sjXaqkPw1eZPyFHuZYpxe3KcyesDuNDI3O/QYneBc1UrHc3B3C5Gn6oOqudEHjAOCjlCHMW9NDKq3hdEvkKMlfvWkfjjTqTMBMpZLcn+mby9bCFxWd30RE3Wa8JEWC+njXx2J1A8/JkMT2k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (10.175.56.19) by
 MWHPR12MB1309.namprd12.prod.outlook.com (10.169.205.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27; Tue, 29 Dec 2020 07:32:04 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Tue, 29 Dec
 2020 07:32:04 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [V2] drm/amdgpu: switch hdp callback functions for hdp v4
Date: Tue, 29 Dec 2020 15:31:39 +0800
Message-Id: <20201229073139.3805717-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:202:2::29) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR0401CA0019.apcprd04.prod.outlook.com (2603:1096:202:2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Tue, 29 Dec 2020 07:32:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb7e3937-0cdb-4c00-648b-08d8abcbd6e7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1309A70EAFB1484A9E59334BEFD80@MWHPR12MB1309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IO1yChK2hyMrHU5cFBUp6LGtBcV3UlzFJow0WcNdo055xoGW+jJL2VfCeW4/9JYoMzs5f4UX3YSXFz1SEa4O1imxkPZ9TURrp4eK37dU1yWdOBErnp2oO2Hq3njweoI+JRpBXCo95luTD+Kvd83oy4rGjAF01bnbnhLHDaGne7dY0ZDubi+BSw62mlhGLYVNvXOtGcLVJXzBfmWTxSd8rXMJ8XhHyy7vWPFGTt5W6ypmSkVPJExr7U4NHxF6fJX5pNbJ52C+zyN1kZo1giYotxQXgc+UTyYRE16jz7pdi8jn1iTmt+loydJuuaJ+vfEAJq/FbyuK0rwLn12QVVC9qdRr2cwy4NtdmIhygza/DE2hholZhN+F4aArbkBnY+vHFnAcSfF4izZmqW/c1tyAjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(66946007)(6916009)(26005)(66556008)(16526019)(30864003)(52116002)(1076003)(956004)(36756003)(6486002)(316002)(2906002)(44832011)(83380400001)(6666004)(8676002)(8936002)(186003)(5660300002)(7696005)(478600001)(86362001)(66476007)(54906003)(2616005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vFCZ7ojw80eaZo32Kv/4mroet/WrYkQXtNBcXlSS4qi0gMhcojruYrv61k2r?=
 =?us-ascii?Q?EQDbKId1toVfZZ7nMEC7qLWxTXUA8MfXchnyqdILy5cQEDT4jikxIAa1nn22?=
 =?us-ascii?Q?SnF7Sh1nj9RTGmDNLuVmnUIZtmY+MewR8UKVz14ZFwpJ5NLldI+qm6MplvEE?=
 =?us-ascii?Q?wL8zPUHXV2SNMBVHi3Oxawm6KcH+yCNyC1s/+QLHRwlCcgOijHGpNicBQtdt?=
 =?us-ascii?Q?y9aYHFIaRf5IgMKwisW7LyLY9zBf2PTTcIS1EddxC61HWsG8nt61YjZD682S?=
 =?us-ascii?Q?BQrDUHZELzgqu9g3cF9JhKiT15y+n0lg22T/4fPYt5RM8MyZfrT5AL8hOtqT?=
 =?us-ascii?Q?Eq61eTsaIYZTJ/QCA9IT726lp7eqnnRWJnG94XD7rQZNZC9HZXfcCEV2XJy9?=
 =?us-ascii?Q?13Dd78U2jnY9sGYCJoE7UGkgO5VeIyJ8JEdFZEra8e1r2jQTFD61l5y+E3PG?=
 =?us-ascii?Q?f/G5ORmGPRGt/UBwTApOTwb5SJr75BdV9408sryaKrryVMj3J3MVCFWxcK/t?=
 =?us-ascii?Q?K+yudITRMCY3RzPWarM/KwhFOrhS59xuuON18/Cpup+6UNhvXH/59HM0D7L7?=
 =?us-ascii?Q?hOv1PJZjgBZolIw+l/GQr3cT5wQxMZA92ejUEg4lG32taKgoj6YfMSLHcsN8?=
 =?us-ascii?Q?AAPzRoNfSaxaCyp1D7yBiJXAdDSiFar0gxZXn7AtQijx/GiZZRONeUP/XeX+?=
 =?us-ascii?Q?4LL4xBssXZ6GxXuoZaFcuzmNZYkOFfsAagZz+OJg/ORqrqt895qFbJDl3VdV?=
 =?us-ascii?Q?pzaZIL0ZEmZKYu12w+U2L2dl10pGimsKzllLCgxCpgkynV0rfhGkLu2tsK2l?=
 =?us-ascii?Q?bVnp1rYGZh8A2Q6yO1jeQ4soBVR+8oeKpyr2rVpKo1kyZJIjXTGEMtB1Yx3O?=
 =?us-ascii?Q?TMobSnedPdhO+2Xylj9TNRoWp0G2R80QSqxImlR2snoHW2ACbnWbBQlwNAkp?=
 =?us-ascii?Q?JtARMjYImet4sIZOX+pi3y+NbcRBVGglAJeXJH6mCnrP+i/kDE88K/ktsygb?=
 =?us-ascii?Q?CcMW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 07:32:04.3605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7e3937-0cdb-4c00-648b-08d8abcbd6e7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDtBaGMD6Ehu1NE+Arm9afVBvu3VpEcldkABEfwUoYVQrzzTn30rgytX8yAoMxQ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
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
Cc: Likun Gao <Likun.Gao@amd.com>, Lijo Lazar <Lijo.Lazar@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Switch to use the HDP functions which unified on hdp structure instead of
the scattered hdp callback functions.
V2: clean up hdp reset ras error count function.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I70564d5053e13e119cc8fa44a40350669ed874cf
---
 drivers/gpu/drm/amd/amdgpu/Makefile   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  8 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 21 +------
 drivers/gpu/drm/amd/amdgpu/soc15.c    | 91 +++------------------------
 4 files changed, 16 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index c6262689e14e..d741fee91a37 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
 	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
-	nbio_v7_2.o dimgrey_cavefish_reg_init.o
+	nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 92e9d1f1207b..62012b4cf496 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -89,6 +89,7 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_nbio.h"
+#include "amdgpu_hdp.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_csa.h"
@@ -609,7 +610,6 @@ struct amdgpu_asic_funcs {
 	/* invalidate hdp read cache */
 	void (*invalidate_hdp)(struct amdgpu_device *adev,
 			       struct amdgpu_ring *ring);
-	void (*reset_hdp_ras_error_count)(struct amdgpu_device *adev);
 	/* check if the asic needs a full reset of if soft reset will work */
 	bool (*need_full_reset)(struct amdgpu_device *adev);
 	/* initialize doorbell layout for specific asic*/
@@ -1209,8 +1209,10 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_read_bios_from_rom(adev, b, l) (adev)->asic_funcs->read_bios_from_rom((adev), (b), (l))
 #define amdgpu_asic_read_register(adev, se, sh, offset, v)((adev)->asic_funcs->read_register((adev), (se), (sh), (offset), (v)))
 #define amdgpu_asic_get_config_memsize(adev) (adev)->asic_funcs->get_config_memsize((adev))
-#define amdgpu_asic_flush_hdp(adev, r) (adev)->asic_funcs->flush_hdp((adev), (r))
-#define amdgpu_asic_invalidate_hdp(adev, r) (adev)->asic_funcs->invalidate_hdp((adev), (r))
+#define amdgpu_asic_flush_hdp(adev, r) \
+	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))
+#define amdgpu_asic_invalidate_hdp(adev, r) \
+	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : (adev)->hdp.funcs->invalidate_hdp((adev), (r)))
 #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
 #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index e22268f9dba7..7b1f50fa9dac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -31,8 +31,6 @@
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_gem.h"
 
-#include "hdp/hdp_4_0_offset.h"
-#include "hdp/hdp_4_0_sh_mask.h"
 #include "gc/gc_9_0_sh_mask.h"
 #include "dce/dce_12_0_offset.h"
 #include "dce/dce_12_0_sh_mask.h"
@@ -1571,7 +1569,6 @@ static int gmc_v9_0_hw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool value;
 	int r, i;
-	u32 tmp;
 
 	/* The sequence of these two function calls matters.*/
 	gmc_v9_0_init_golden_registers(adev);
@@ -1590,24 +1587,10 @@ static int gmc_v9_0_hw_init(void *handle)
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, true);
 
-	switch (adev->asic_type) {
-	case CHIP_ARCTURUS:
-		WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
-		break;
-	default:
-		break;
-	}
-
-	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
-
-	tmp = RREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL);
-	WREG32_SOC15(HDP, 0, mmHDP_HOST_PATH_CNTL, tmp);
-
-	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
-	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
+	adev->hdp.funcs->init_registers(adev);
 
 	/* After HDP is initialized, flush HDP.*/
-	adev->nbio.funcs->hdp_flush(adev, NULL);
+	adev->hdp.funcs->flush_hdp(adev, NULL);
 
 	if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS)
 		value = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 0d3def7269bb..9a25accd48a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -40,8 +40,6 @@
 #include "gc/gc_9_0_sh_mask.h"
 #include "sdma0/sdma0_4_0_offset.h"
 #include "sdma1/sdma1_4_0_offset.h"
-#include "hdp/hdp_4_0_offset.h"
-#include "hdp/hdp_4_0_sh_mask.h"
 #include "nbio/nbio_7_0_default.h"
 #include "nbio/nbio_7_0_offset.h"
 #include "nbio/nbio_7_0_sh_mask.h"
@@ -59,6 +57,7 @@
 #include "nbio_v6_1.h"
 #include "nbio_v7_0.h"
 #include "nbio_v7_4.h"
+#include "hdp_v4_0.h"
 #include "vega10_ih.h"
 #include "vega20_ih.h"
 #include "navi10_ih.h"
@@ -84,14 +83,6 @@
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL                                                             0x01ba
 #define mmMP0_MISC_LIGHT_SLEEP_CTRL_BASE_IDX                                                    0
 
-/* for Vega20 register name change */
-#define mmHDP_MEM_POWER_CTRL	0x00d4
-#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK	0x00000001L
-#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK	0x00000002L
-#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK	0x00010000L
-#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK		0x00020000L
-#define mmHDP_MEM_POWER_CTRL_BASE_IDX	0
-
 /*
  * Indirect registers accessor
  */
@@ -700,6 +691,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.funcs = &nbio_v6_1_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v6_1_hdp_flush_reg;
 	}
+	adev->hdp.funcs = &hdp_v4_0_funcs;
 
 	if (adev->asic_type == CHIP_VEGA20 || adev->asic_type == CHIP_ARCTURUS)
 		adev->df.funcs = &df_v3_6_funcs;
@@ -835,35 +827,12 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void soc15_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
-{
-	adev->nbio.funcs->hdp_flush(adev, ring);
-}
-
-static void soc15_invalidate_hdp(struct amdgpu_device *adev,
-				 struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
-	else
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
-}
-
 static bool soc15_need_full_reset(struct amdgpu_device *adev)
 {
 	/* change this when we implement soft reset */
 	return true;
 }
 
-static void vega20_reset_hdp_ras_error_count(struct amdgpu_device *adev)
-{
-	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
-		return;
-	/*read back hdp ras counter to reset it to 0 */
-	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
-}
-
 static void soc15_get_pcie_usage(struct amdgpu_device *adev, uint64_t *count0,
 				 uint64_t *count1)
 {
@@ -1012,8 +981,6 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
 	.set_uvd_clocks = &soc15_set_uvd_clocks,
 	.set_vce_clocks = &soc15_set_vce_clocks,
 	.get_config_memsize = &soc15_get_config_memsize,
-	.flush_hdp = &soc15_flush_hdp,
-	.invalidate_hdp = &soc15_invalidate_hdp,
 	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &vega10_doorbell_index_init,
 	.get_pcie_usage = &soc15_get_pcie_usage,
@@ -1035,9 +1002,6 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.set_uvd_clocks = &soc15_set_uvd_clocks,
 	.set_vce_clocks = &soc15_set_vce_clocks,
 	.get_config_memsize = &soc15_get_config_memsize,
-	.flush_hdp = &soc15_flush_hdp,
-	.invalidate_hdp = &soc15_invalidate_hdp,
-	.reset_hdp_ras_error_count = &vega20_reset_hdp_ras_error_count,
 	.need_full_reset = &soc15_need_full_reset,
 	.init_doorbell_index = &vega20_doorbell_index_init,
 	.get_pcie_usage = &vega20_get_pcie_usage,
@@ -1294,9 +1258,8 @@ static int soc15_common_late_init(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		xgpu_ai_mailbox_get_irq(adev);
 
-	if (adev->asic_funcs &&
-	    adev->asic_funcs->reset_hdp_ras_error_count)
-		adev->asic_funcs->reset_hdp_ras_error_count(adev);
+	if (adev->hdp.funcs->reset_ras_error_count)
+		adev->hdp.funcs->reset_ras_error_count(adev);
 
 	if (adev->nbio.funcs->ras_late_init)
 		r = adev->nbio.funcs->ras_late_init(adev);
@@ -1422,41 +1385,6 @@ static int soc15_common_soft_reset(void *handle)
 	return 0;
 }
 
-static void soc15_update_hdp_light_sleep(struct amdgpu_device *adev, bool enable)
-{
-	uint32_t def, data;
-
-	if (adev->asic_type == CHIP_VEGA20 ||
-		adev->asic_type == CHIP_ARCTURUS ||
-		adev->asic_type == CHIP_RENOIR) {
-		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL));
-
-		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
-			data |= HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK;
-		else
-			data &= ~(HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
-				HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK);
-
-		if (def != data)
-			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL), data);
-	} else {
-		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
-
-		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
-			data |= HDP_MEM_POWER_LS__LS_ENABLE_MASK;
-		else
-			data &= ~HDP_MEM_POWER_LS__LS_ENABLE_MASK;
-
-		if (def != data)
-			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS), data);
-	}
-}
-
 static void soc15_update_drm_clock_gating(struct amdgpu_device *adev, bool enable)
 {
 	uint32_t def, data;
@@ -1517,7 +1445,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1534,7 +1462,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
 				state == AMD_CG_STATE_GATE);
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		soc15_update_drm_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
@@ -1542,7 +1470,7 @@ static int soc15_common_set_clockgating_state(void *handle,
 				state == AMD_CG_STATE_GATE);
 		break;
 	case CHIP_ARCTURUS:
-		soc15_update_hdp_light_sleep(adev,
+		adev->hdp.funcs->update_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		break;
 	default:
@@ -1561,10 +1489,7 @@ static void soc15_common_get_clockgating_state(void *handle, u32 *flags)
 
 	adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	/* AMD_CG_SUPPORT_HDP_LS */
-	data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
-	if (data & HDP_MEM_POWER_LS__LS_ENABLE_MASK)
-		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	/* AMD_CG_SUPPORT_DRM_MGCG */
 	data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
