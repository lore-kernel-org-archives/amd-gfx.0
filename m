Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB38C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 21:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D642D64F70
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 21:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D642D64F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80CB6E03D;
	Fri, 12 Mar 2021 21:24:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AFDA6E03D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 21:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZiJlAuhAtRgcPxWx1+tZgCRgr/NS0KdrWC3MzXHVUxBKKorWUZNisbGVp7fGlztNBFsP9Zdy5m/YJGac1lHzMLmKsrN8zOinDoLEEdUDu9WPz9SE+GyPo36zjJegI0/ZMKOFQGikDadydEH14mJXraSsMy9knYNPLXS1WvuzIbwkGjPY9yHE/N1z9V6sghaOCfpvUqbNWAshj+cW40jYjlJOJn+V3q3Pk7VF2kebSRWdTAW06s/fCUuqQTMHVJN95Ir/u7y8cSdALEQD/7yjSmB+zpTm4z3OmCiUWi2oX+tqCZtf/Y3hFP4G3G1hLULEmGg4H8eoVCnn/iPjgJUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q5D5yY9wxGUwe3tHAtG3dUwcCkvMvn8/jNO7yZZXIU=;
 b=cDEoJVgPZ+erW0hy0h7DvJ06zsi3YAc6drr3TOxlqfVd8i8HFx51Ec9VPTmNEfu7cd2kD5Oia4/AbkNRvYsfosYV6KeQ2GOBkVjWyEBiMZ4QY/qTSWrOcZ5TjRkkmRMJJZaTAuF2nPK2SilHoZ20WGFq1s8yYuUuf9w59xJyNVtbrSzCMHqsNcfMUZdPQGKpakX0kGYf7xcw5zAqCRoHkaTWfIZOxQy4OzjocYBmT6tqgB8QZ6q5O/imQ0q5/czgrLM12vgu+HOBPZuP3cevzycqaOoutqGbgQKKZ9FYQCjiTI1sR5Tp8qKLum3Hlk19W2pzMZ0e8WjjO7Cda35/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q5D5yY9wxGUwe3tHAtG3dUwcCkvMvn8/jNO7yZZXIU=;
 b=ISb6Myc5tvI2vbGQEEuWXjfyyXfBr8vs6w39J7tmYgNVpcURkDMzcBhV1q0A2A8JO+xug3tIQPNUMqqchpxROoTkQOMLvkCCZ+IDxNW07CaRIWIPXxkyluY5NASUJe9Et7FBLcSgxQ5EfGMtFB76hhmnot8tl1vhuurvDwuh/Oc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM5PR1201MB0089.namprd12.prod.outlook.com (2603:10b6:4:50::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31; Fri, 12 Mar 2021 21:24:44 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::45a1:94ba:f88c:92e2]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::45a1:94ba:f88c:92e2%5]) with mapi id 15.20.3890.041; Fri, 12 Mar 2021
 21:24:44 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] Revert "drm/amdgpu: workaround the TMR MC address issue
 (v2)"
Date: Fri, 12 Mar 2021 15:24:34 -0600
Message-Id: <1615584275-16432-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3912.26 via Frontend Transport; Fri, 12 Mar 2021 21:24:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a53bc2a6-074d-49f3-fdd9-08d8e59d4146
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0089329853EAC3F7FAED22F1806F9@DM5PR1201MB0089.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkcprLWrHOAWunKT8e0E5V8JNH23oSX+RuNn6sRSCe3cRml1xm9tgPSi7yRAO5bSNhau7Wn06fBnU66WpQolEehuXFNgSJOJWmvk+SK2lhtrnDmrhqsz0uAyLivNqnvaYT2hFzi6dd1WMtQQeouGk9Sx92pmMYyeJMUGbjkeaRRAQY3y71Hes50AUxDB+rEEZI7zgpYjFnhGfCSH7qJ14EQVNH4CSUscpslk5SccnDDorq1HLzz6S3VGq+T/bAAb78qoAjsUtxDj61sFeEnNZzlyfUHfdg2F+asfuY6tYg6QqAKEWjwitDWg6q4Gxfm/E7TBzxwGGqumjBl+xyNmRVVFXJ46/aMRNe0f0Nqon9kI48Zu7Jihc6RaewuwZ8d6//SNV3ofxrFuJre58len8f8l2grHxaHo6EF3uApRWFx/eF0FcIWYH5VzQWdys6ZB/TJn+NTjj3ClyUpwO0c3llrqeL3lBPDkPblRshZLzf41dYIYgZowSqXZcRcliqLCEXg8ubKwVVc4Q0ORv3Am7ebXyboC3Ox9Tc7bVfu5udpeglonmVAnxnsDLObDFF3O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(7696005)(36756003)(2906002)(956004)(86362001)(2616005)(52116002)(83380400001)(6486002)(6666004)(478600001)(6916009)(8676002)(66476007)(4326008)(5660300002)(316002)(16526019)(66556008)(186003)(26005)(8936002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/VFublLKCiCNOLcpZiTxFT5MBtijomwLMuN217ejHNpROvu3/oJyeGTONfLg?=
 =?us-ascii?Q?SZhWPUn+2/zAzfPY9jK/BWy/+a3ut14B7smBRLxnwXimL55jdLFsiYuaSbBU?=
 =?us-ascii?Q?B8b3vRvPk7ZzAGeaXQGOT6D0+QGT7C53Svb9dVpKMTQG03L6ghsUPxEb9KSE?=
 =?us-ascii?Q?v5LrAaFoFxiUUSEsBupSHmXDhSdRVClyQ3EgfGQo95GBu2m3rrN2ZhoIyTLx?=
 =?us-ascii?Q?kiW0M9sFf/N5SgvRKB+7TbpZMSsOv0DsIpO728AfXMIQL+57Sy1+PpTAFR3k?=
 =?us-ascii?Q?vt/WPWbdVhdrKNtCE0wxSzLr+/ZSJu0pwNE3A3oZTl5hfmQ5gYONM6qTkZkV?=
 =?us-ascii?Q?ysnTNq90MXfUQq0BYQ41Cxo54le6qbNOrrfBRFU33zcdC7ow1XDTAJjyONcZ?=
 =?us-ascii?Q?gM2mDCL50boTkQEI13aXlAZFicUlofgPrSPiH5sW19X8RyUpXvu2Vc+HGXhi?=
 =?us-ascii?Q?qEn3IUN+QC7u9bz4k/OTM2BKP7dG20HByQS7M49PfArewcWyY2jSdsHStczi?=
 =?us-ascii?Q?vR1026xFC0jjyedp4LMR5i1JYxR4Jj8k9BrEvS8BevGuwAQqq/dFbkRGLkYj?=
 =?us-ascii?Q?qMiHC9Y5d2jnsyTuMUMBjxnJMMvztuktS2D63kradaPsBQvkeXghWhA8liMH?=
 =?us-ascii?Q?GdYk/hf75DwBAZAln5/CWAx43E16Eix/CSLOb/s1rHPSj7aAhhezYV+OJGp1?=
 =?us-ascii?Q?nr/xb/4W81UiLaiUTF3rr+YbjUBHlU4EG206lksFMcGWlY3zPXn3+ri8R08f?=
 =?us-ascii?Q?z6Ep1on4g3zhSXYcuNLyXPJspuxaOcmDCB54IhN/0pv65O3S79TecWcXM52c?=
 =?us-ascii?Q?HMd3D7o+0XtWinaEhTwrCVVvbA4AuFkn5mFmd8yYIdcJNZe1Ze5WUveoh4Fr?=
 =?us-ascii?Q?F3JYheHuCVVhBiCyzLd5yoJjc7miWdLIjoRuT85dJ1mCILMespOoX590n05N?=
 =?us-ascii?Q?iqYsd2yZH7c9Ov+D5d0pmqhrjkUgknTnaXL/8YbBkDTt8+hjuHNdHbv0XBAU?=
 =?us-ascii?Q?trNCR99BElZZ6ZkUyilN/GlkqtFkoj1KlULLHrDDDOes8d8PWkuttb0Ixovl?=
 =?us-ascii?Q?UTnKCisqbGqs7ry6e6VtjGqoJh57ZthxeYryRPa0gZcvhw7LAGHJyHFCZQgQ?=
 =?us-ascii?Q?oS9hOpONYimB40nHxTnWMD/Oe6E1os21MfOg7o02nZdQW6nH3VH+75zLatLy?=
 =?us-ascii?Q?6v61+a3A1Yha/GTLQ+bHPHrAD2yhI3Pe5Nk7XtsqulTjJJVj6xmUklMOpkng?=
 =?us-ascii?Q?5oiOw9YDtT77AHZBg4EFa4ifdaWlJlUwB/UDNzQpORCkCBS8YhGOxAudq/eg?=
 =?us-ascii?Q?FWIF5tpkI83NL7Ha0OvHzTQ+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53bc2a6-074d-49f3-fdd9-08d8e59d4146
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 21:24:44.2721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZTAiGfZTsTKW/Tnkkj6C7WxIa+fjhYNifYP4doB9M8suLx1qzmruc4CcKBzBsLM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0089
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
Cc: felix.kuehling@amd.com, Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 34a33d4683cba7ba63c894132efb1998c0217631.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  9 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 10 ----------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 21 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 10 ++++------
 4 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 7e248a4..3ed8387 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -209,15 +209,6 @@ struct amdgpu_gmc {
 	 */
 	u64			fb_start;
 	u64			fb_end;
-	/* In the case of use GART table for vmid0 FB access, [fb_start, fb_end]
-	 * will be squeezed to GART aperture. But we have a PSP FW issue to fix
-	 * for now. To temporarily workaround the PSP FW issue, added below two
-	 * variables to remember the original fb_start/end to re-enable FB
-	 * aperture to workaround the PSP FW issue. Will delete it after we
-	 * get a proper PSP FW fix.
-	 */
-	u64			fb_start_original;
-	u64			fb_end_original;
 	unsigned		vram_width;
 	u64			real_vram_size;
 	int			vram_mtrr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index bae304b..cd3eda9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -407,16 +407,6 @@ static int psp_tmr_init(struct psp_context *psp)
 				      AMDGPU_GEM_DOMAIN_VRAM,
 				      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
-	/* workaround the tmr_mc_addr:
-	 * PSP requires an address in FB aperture. Right now driver produce
-	 * tmr_mc_addr in the GART aperture. Convert it back to FB aperture
-	 * for PSP. Will revert it after we get a fix from PSP FW.
-	 */
-	if (psp->adev->asic_type == CHIP_ALDEBARAN) {
-		psp->tmr_mc_addr -= psp->adev->gmc.fb_start;
-		psp->tmr_mc_addr += psp->adev->gmc.fb_start_original;
-	}
-
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 5bb9856..91c43a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -141,21 +141,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	 * FB aperture and AGP aperture. Disable them.
 	 */
 	if (adev->gmc.pdb0_bo) {
-		if (adev->asic_type == CHIP_ALDEBARAN) {
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
-		} else {
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
-			WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
-			WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
-		}
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 29d7f50..0b056bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -47,8 +47,6 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 
 	adev->gmc.fb_start = base;
 	adev->gmc.fb_end = top;
-	adev->gmc.fb_start_original = base;
-	adev->gmc.fb_end_original = top;
 
 	return base;
 }
@@ -126,10 +124,10 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	if (adev->gmc.pdb0_bo) {
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
 		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, adev->gmc.fb_end_original >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, adev->gmc.fb_start_original >> 24);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, adev->gmc.fb_start_original >> 18);
-		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, adev->gmc.fb_end_original >> 18);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
 	}
 	if (amdgpu_sriov_vf(adev))
 		return;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
