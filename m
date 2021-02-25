Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0AC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 19:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C56964EFA
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 19:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C56964EFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF5DD6ED23;
	Thu, 25 Feb 2021 19:04:19 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690053.outbound.protection.outlook.com [40.107.69.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD276ED23
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 19:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSwnN4LIaUZqQ2tq8CJ3kiwQqhGID50YfFmIBUc0CtXKJ4IHtqZhVAUBG7vRiTJWCuxCd5f74mM/rhVI7yuZRh5TVc+4UmsKEXAaa7AHZ3Ma3V2eLBhY3QH+/jtEJeixOGDK1JxeTajzUU8bip1L6La/QJ0FRoW6rWKhb4I3LbBxy0OahFUDXuAG8vkJwzGNzJBtISAVr7HXnXQQ2hT2aSjeh/vp2Zy/9hFJKka7FdXjp2StKakljo9GO1hrqD1nUhSYzc3Sbmx042GwvEMfopIg0HWsp3LQ63nTFQd2nHNeRhrcownJ35VRIQg+mMeh1+t7dAInU3tOelFvrE5gjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkQ3XEhSuwmgrcuP2bwVlIgGTNuFwpxjy4ergTg3N2M=;
 b=WPEYjuq5+cZ7QvIP0xTuSQ5K2YoiBRlTj3tdwadX4M6NFCEQe+QQAx05DlPqZ9kUdcasb7MoTJITgPZarO9CsCYacFKfRWZ7Gr4h3Rj1inXkp4UAq82/Ki032cSOwsb/sG+D/uu6wbvm/uyMKy/EnYpaBB9D6GpPrPxkl/ojcDNRF/+rDLOJMuQdCf3LO8R6OmazugJJzt3GrRR+VZPWvgx/6lcST4CTBHnyceimLYxEYh4GBtz0mgira7mhJ47Vct3JsTLWz89E2LxOSY3yHYhOvA2cpTcHf2aWA5dJuPJUiSdJL7SvZg4NyMllfRe7pGCiW3gJpkYvzJLrlEuP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkQ3XEhSuwmgrcuP2bwVlIgGTNuFwpxjy4ergTg3N2M=;
 b=1LvADKbBXKaqcSfZG9fAILKFeOnhqEV/e9VQDanQaz4yI1EZQIOOjsWOCLPRJc55ZmZZjLV1xwoRah+9RKlk35qFB/OXnqyUO48kZ1AVLSF5NY4dY5+0oUAbXmBIVXHhOMal+MbNNr6sKFcUs6PJR7bAQ3ST0FZMe493+p2/k7Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 19:04:17 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 19:04:17 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 135/159] drm/amdgpu: workaround the TMR MC address issue (v2)
Date: Thu, 25 Feb 2021 14:03:22 -0500
Message-Id: <20210225190322.661849-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BL1PR13CA0486.namprd13.prod.outlook.com
 (2603:10b6:208:2c7::11) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BL1PR13CA0486.namprd13.prod.outlook.com (2603:10b6:208:2c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend
 Transport; Thu, 25 Feb 2021 19:04:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4911e68-52b6-4ec1-20bd-08d8d9c02638
X-MS-TrafficTypeDiagnostic: MN2PR12MB4285:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4285C5C62A59D4ECAAF65BE1F79E9@MN2PR12MB4285.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fVPbsm83j62r9mwD81sLIKjIAVj8IBUdqeDIrqiWY8CMGe/wkCawrlbOBLG3/DvFAbs7qWgpqk/YI9r0FUky+Hm8Z98odOVz0yZnjCbYRXrL3Dh6aGXmleCRmE8wxl2FXUpS1hOQvvv2654CBR4rSPaKA03p+g2D1cqKsTITSuGDPDeXfrdbra4ok5qItJZFNUOYsfTYyEdC0gy9O+pXD3LWUefh5NTfnofSrcjyiB2ihCrX3itt0M7AhdORxOagMQh+X/Hn3C8hNUp8XRGlZsTXezcpBARkx42H6F7GWyoOFosoj6QH/l5zj6p9bIOjOQcmbLbaV3zzf7QoQWdbgWZ1QGJ+vLy1lUK1w08k0EqH9UsGxbSHp23OpDvvK2BU0dM8S0fgpEer36ytvF0THyBbbg1FPrAo7y6VihzCANmOHc/TKmoBsTO5fgQX7UgbPp0LeGpqKTgbfO44watrIf1gcxrmhGfi9LQ/+ACjNdqguYnP1nOJrjZrvAezU5TVB7TZkJ/RJtcwmeDwtnPNthnKHS+7NrgHxG6oILUeVJRmJbB8XAtfZ+nJYQOlrc1R4WpQf6SdDD6r4FgBS0mCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(54906003)(8676002)(6506007)(316002)(186003)(8936002)(478600001)(956004)(26005)(66946007)(4326008)(66476007)(66556008)(52116002)(86362001)(36756003)(69590400012)(16526019)(2616005)(83380400001)(6916009)(6486002)(6512007)(5660300002)(6666004)(1076003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?amt+VOBRpmpv3eOpLroQEgfyFYNUYYtyW2m5WcqjsFAS6eB1ddL38+iT19TX?=
 =?us-ascii?Q?Lk0Na10G4NTIVB2Dp/SJWNcSWuq7yIqeo7PFH9k6DtO+b9ze1cQ0MMwbVIm1?=
 =?us-ascii?Q?Q4EMQTcMYf3CAqAib9QO1m4pYaTUahpdE9bxrhizTM57Yqg8h3pxY6thCusD?=
 =?us-ascii?Q?MIK4k7+ytzmPbM2V0/VcjMupBBGLdVm3jABxqOcEB4/j7hvUihZ2yaGGzWxm?=
 =?us-ascii?Q?AW9mRC1YsEIuqRMcw/Ht0xPrWtV/kM4sFL9hi6Sqg9Qyi5yQIejpeiGaO7v1?=
 =?us-ascii?Q?mtFsgjXZX6FCLrFI/FBXyItuLghU6a57wGnOrj+Pvgif4et+Gtjn92yYsjNu?=
 =?us-ascii?Q?KVVflB6niKtn90iHpUBkyvwqU7aiaCsk+TqmqkNp2l0Zu2buwewY+s0ldPij?=
 =?us-ascii?Q?txnW8qqDkrbD8iTzYOVy+L+d8roLACuhglhTnSSqte7JGundmGISHc/CzA/z?=
 =?us-ascii?Q?ZXuu8qvYxq35RUnCUcNZt1EII0sUGQZSUxQjW9PhXmc+apFi6G+hMD8560V+?=
 =?us-ascii?Q?GCAxPE+8bsP/Sx2KaoCL+zUf8vJXXr36z02uGsheA6JAgnqe+a903pl7qnrp?=
 =?us-ascii?Q?vMwbA4LtfXAyHmKbfLH4coqwZ7w5TKMoVTSrW8mqxGAadof7eQhmgna8Wb3B?=
 =?us-ascii?Q?sEhGPFTQFSMUPx5qZrQpAWqgzrV6dhlsz3hHX9wWLW6NK0W6MmkW2Yx3C5pq?=
 =?us-ascii?Q?fXsTqtWx8WOrjuYkBIwy/xi+SCvROu/sMD6X+j6+TVHEoVOoVIEuwTz9Uxbc?=
 =?us-ascii?Q?RS6oHY80av52El/g08yeKTDOnWMTeMSBhUTZEl4rWZ3EvzEQ2EijWjstbcX/?=
 =?us-ascii?Q?YM6WFBXSihKwWZX2A95rDymJ7U8pXrMRXYRAc0TCFrlVXdr57a6XFSk4e3Od?=
 =?us-ascii?Q?yvYIo4PbCX2+r1i86JfU2eBh5KtPo8s+cJOKz8YXVHW5belAFCxNegbH4WWc?=
 =?us-ascii?Q?olvThM+50MkH8jZ+5wthV7AbzSk2SF4cH/yiGGogJN7JP6O3U+ADclu9iBBJ?=
 =?us-ascii?Q?+6lFe+2cGuwem7MTNAvrV9GP9PNDiTZxBaW8vDJgyoF/W0yGs1X6OXJ8/RT+?=
 =?us-ascii?Q?B7VLnIGpmkj97DQnfpZyjxhnyvceCi3M4RCiwWnjxV0wVGF6HI8yxbnnysDs?=
 =?us-ascii?Q?D3EP4vPVwPdxaE/DCo5HGm/fu2VNR+x9ef4doNhgnNkCdl1US6HT5PY186Gf?=
 =?us-ascii?Q?vMtJxfNfPgKL0rgAHCRnMf19sLWXroefqplVhPcLNAl4wmzUMBjpwMRlRfBh?=
 =?us-ascii?Q?BajTEEEfNzrABKhWQk/Jj67TrExjoY6wDH6idg0Frb0QIdttF7KjNFgTjWxQ?=
 =?us-ascii?Q?bz4RS0Q0dUxtEN1qjwJfOVxlvIVtjCtP34XqZ+OTInc1NQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4911e68-52b6-4ec1-20bd-08d8d9c02638
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 19:04:17.4232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0gfT7XmrdJ9tHAbfPfr1yBeafTir8/BoTrHb0ZR5+2HTPX2Oys5t3ICose11gbtW/cnRqB7uPm5rEcxIctVbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

With the 2-level gart page table,  vram is squeezed into gart aperture
and FB aperture is disabled. Therefore all VRAM virtual addresses are
 in the GART aperture. However currently PSP requires TMR addresses
in FB aperture. So we need some design change at PSP FW level to support
this 2-level gart table driver change. Right now this PSP FW support
doesn't exist. To workaround this issue temporarily, FB aperture is
added back and the gart aperture address is converted back to FB aperture
for this PSP TMR address.

Will revert it after we get a fix from PSP FW.

v2: squash in tmr fix for other asics (Kevin)

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 21 +++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 10 ++++++----
 4 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index d5f3825cd479..cd4592ff70ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -208,6 +208,15 @@ struct amdgpu_gmc {
 	 */
 	u64			fb_start;
 	u64			fb_end;
+	/* In the case of use GART table for vmid0 FB access, [fb_start, fb_end]
+	 * will be squeezed to GART aperture. But we have a PSP FW issue to fix
+	 * for now. To temporarily workaround the PSP FW issue, added below two
+	 * variables to remember the original fb_start/end to re-enable FB
+	 * aperture to workaround the PSP FW issue. Will delete it after we
+	 * get a proper PSP FW fix.
+	 */
+	u64			fb_start_original;
+	u64			fb_end_original;
 	unsigned		vram_width;
 	u64			real_vram_size;
 	int			vram_mtrr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cf8cfe620d8c..a4f96d931573 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -407,6 +407,16 @@ static int psp_tmr_init(struct psp_context *psp)
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
+	/* workaround the tmr_mc_addr:
+	 * PSP requires an address in FB aperture. Right now driver produce
+	 * tmr_mc_addr in the GART aperture. Convert it back to FB aperture
+	 * for PSP. Will revert it after we get a fix from PSP FW.
+	 */
+	if (psp->adev->asic_type == CHIP_ALDEBARAN) {
+		psp->tmr_mc_addr -= psp->adev->gmc.fb_start;
+		psp->tmr_mc_addr += psp->adev->gmc.fb_start_original;
+	}
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 62019885bda5..d189507dcef0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -141,12 +141,21 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	 * FB aperture and AGP aperture. Disable them.
 	 */
 	if (adev->gmc.pdb0_bo) {
-		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
-		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-		WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+		if (adev->asic_type == CHIP_ALDEBARAN) {
+			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
+			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
+			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
+			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
+			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
+			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
+		} else {
+			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
+			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
+			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
+			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index d53b3751418d..4df0b730774f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -47,6 +47,8 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 
 	adev->gmc.fb_start = base;
 	adev->gmc.fb_end = top;
+	adev->gmc.fb_start_original = base;
+	adev->gmc.fb_end_original = top;
 
 	return base;
 }
@@ -124,10 +126,10 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	if (adev->gmc.pdb0_bo) {
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
 	}
 	if (amdgpu_sriov_vf(adev))
 		return;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
