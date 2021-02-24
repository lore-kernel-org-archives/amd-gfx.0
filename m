Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25841C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81C764EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81C764EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9646EB9D;
	Wed, 24 Feb 2021 22:22:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 812706EB9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfBdbg/bLEAO7bVzd3o8Ggr1Bsg3otQhwTmxIzgagayoAHElrfRNu54fnrvSRFM6Lu6y/Jcij0aGp9jRkIJPG/hkpuz5sRFCM2W57lT3lCAyjVa8w21nDD5RbBJMPvlCzK2mwOVnHTkajEEpGdO1GrgGotW31sRkI/bpj/AzKYwnXZV1HxCZq8uDrUAtNMqBOG7qw0R93f98OSsUWNI+UOMT4KwnURfdy6Ngcm9eAuewPqw0jppc0VC5TOn3RaEc5HIwpJBV50udiGDny+5dp1UMOd4vG0ZMoAp1YIBjq3BZUvxU3enIhKZaYyFSKSl0R60a+cFsUoLvd14m+A9ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGz5v7a7KvYq+X2foJpDosQllxa+ooFAiibg/qVJ8y4=;
 b=GFm29Lv+NsO6JOHJ9eykWTtUKAbRLRfaWKS9IGVoxceey5AY6H3O4jiK35PRdMvYjwl69tGy/9g6OsBc1b7MDsXpLuVvqr6xxX4uj7GB1N4BDKE0Us6wYYFvu7hAMh2z42yFAQ+MsibIujQyUiv0bWodgLGtbvDF1YJ0MpPhZP4Sg5T/T0bFdxDy95cghxZYm3YdaUL71onSbGBo9UE/yioU6/rxHHQgDyQXIc+k+uX8IuzT2tM5JTmSXLZmh8HHeuJsTAAqG/75oFMNkCp2h3r1iTs3xezBbg1rktqmuZmt3O00RqiXM3dh0CYbIrDTT0QPzAJEbFMymB6jOnuMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGz5v7a7KvYq+X2foJpDosQllxa+ooFAiibg/qVJ8y4=;
 b=dJNMKKzR/S6k70fdeJcZTnacVGdjWlxRdFHsBDMZ6Q2CiTmGDb0Dm6aarsDaW297atqkv+BIMxFk/7pJqxZrJxe2uD13rm71QOcutgV7bnmqTcuYodWEunyICOAzYWjbrveetl6Ramj7ilxsQ07IJ8Ia44Qtn2gH8OtFFcXscIc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:22:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:28 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 134/159] drm/amdgpu: HW setup of 2-level vmid0 page table
Date: Wed, 24 Feb 2021 17:18:34 -0500
Message-Id: <20210224221859.3068810-127-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93df217a-bb1d-4de9-1d0b-08d8d9127327
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503F8B27F2E9B4CCB8F789DF79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDfsh2PJ8AgbIzvazXxteThQZFUclRoywBG+zoWXNHeVkQL/ijy/QrAtAnR2ix8B5sJBYeSdVerTKRUYO0W71ierJzC3UHxgn/RKlBQWA4dSLpBJQWAW7lY0tKhbTlsHowZEMCuSLynIMCuUob0giBKq457cbwQ3wHMbH3K948+dzgGmYmdXL940LlrSLYKH5YaVBu8Z13K/+HkLmYdcq3TYFRXcGc7c4p/0TCDz4+BhwwKQJjRFJxcshhAMx7XX3F2ZxJC5bkaWBxrRUv9k9qLeDedSm+ARpIISFerkSMXPhx7q1QzdwlMMLtqvACXPflbCkXa94zRyaclb2o8f1hkKpEm3QM4+59AWXsjpXu8vgKZMEVb6WdnNozKCYl8V3ADPxNcYu8qRO9/gd/VMcS3v3W0u3KsL4q+ygmYMa/RUOacFy8qay3R37cNadFFoUFPNX1thEBHi8KR9//LLe5ShehBGVfWKtjv5TqyOuvZ8JHC+HW1P7KV7mbT4KwG6jyptvHKm9M6gJZIcxeM/hH3z07WYYF1EUBCFknOtj47vdgm1zzxGw3Us6x3AeUTW4TH5MR0sZgj1F0PPHh0omA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GR6OhuI79HiwvQSzYe4nQB2LWqSqcrVeg9YfIcZL144rXeW8Eu7cTmckuk97?=
 =?us-ascii?Q?ps1pB71bvQiD00sHPjTwHy5dstFEbEClw/WWGpBR7V76P3NngkfKqrjuxyFi?=
 =?us-ascii?Q?6cNi1hL6SsrwXfX6UwWn1mz6J4wTk9//VfHCxG13NJ21OD4Avzkw//q//Krg?=
 =?us-ascii?Q?SQvYVTyoe+Iz6NBoR56/62mCVeeCVf+X1zPEl9YDXb8TSl5Sv+y0HSQL1pqM?=
 =?us-ascii?Q?4D80fxfx4cTLc4WogPQ1go7s7eu3Lqd1Q498Xb/47buosXVynMcLovrhY7Zd?=
 =?us-ascii?Q?01zWbUDbUfOqc19e0un5veNuldQ0aCjcMBGZ+Wki1UvFc7ZtkXGx8fptcWD4?=
 =?us-ascii?Q?Bz/roOMFhYUnuiJZMIVQ9KjyrvZCrRXtRjM6G66B2dRMSWX5DfWrMOEBNbZc?=
 =?us-ascii?Q?SsYc6FI8U14dXhet7jL8wCBXZoZcQFEHWKOFWRCx/fpxIkwpjHLJXAk6+hb0?=
 =?us-ascii?Q?Y2azTB/JjqqMZ3Mms/+gu04/75j9avpwfNVqkLkzxUQIub2qhER0Et/We+nL?=
 =?us-ascii?Q?a7Ke3FRNi2QgONbZyvdVze9CvZv4a9COvEv2AJTTK99WPf06egft1cb+Ta4i?=
 =?us-ascii?Q?JbWK3XFd+1a84i4yBPwa6ZKwNOESU9uOFZvX/qUHYGGYlFxkCPLr20GvpcCm?=
 =?us-ascii?Q?hRiB8ofOga+SpDT1QT1y7ok35DQLIFb7yQSMHHziv5flbgkax7tGxLJ3adT/?=
 =?us-ascii?Q?XUphJXI+zfEJuIhhH94M+TdgfNUsFSTB/VFG+e2ia8+yd5GoC6bkx049voIR?=
 =?us-ascii?Q?VDE+6r5a7hbhq3/MQ1StSAPkfpYP4YxqEM3k5/njEMZvVBOxdhOE+l2Yf7Dc?=
 =?us-ascii?Q?muy/wU9BzfouX09D+KJhmS0x2RKy5VKFcQGB/73Bm6Zq95bcn/mEl7TqWKGa?=
 =?us-ascii?Q?iIVsNoYJSFASiQMFISO5ZvTvBuL41a7acBrF3uxdG3V9TfUfqttqOdOKhlol?=
 =?us-ascii?Q?tApPRK7g+aV8pt/bXBeYY4hRUG002k2Vf0JlHfMzwTMA9CpFzEUQmZcm8Vmz?=
 =?us-ascii?Q?khtcu6pI6xWlJ6MxBi7QhdniEBqnTkr32gHhs5jVRgN83Ri6luvelYVIiyQ5?=
 =?us-ascii?Q?UlG4pZdbRmVfmnDcDUIwnCHhg3APKbFOGO37qNlvf8KL43jbyFkhkI3Nkq1x?=
 =?us-ascii?Q?lcNCu0XrzFoJYw9YxTntQOQsDTN+RpC1CDvMD5HU63qlokgRAtJKQfs/FsiR?=
 =?us-ascii?Q?mgrXWB+wX1DZAdlF86pEI8KnRL0ig1wDJqAmHP/nc66VJ4lq9rkkuogzW9SY?=
 =?us-ascii?Q?Cvah9vTJ4jm/Gsnwdlaf9OuCoFlMzrJUgi/oxJjQFMoK2ZQPCrdTyPE2XkzS?=
 =?us-ascii?Q?wjB/qEBhREjSAUm3lfwFTkmg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93df217a-bb1d-4de9-1d0b-08d8d9127327
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:53.9348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRXCPzLndajQHpRPpRCYM+3PVToUFFxFrH8w32lrDKedagMaKnBWvuEPy9BQey6W2+A8gklEGuR0JWCF4XdEmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Christian Konig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

Set up HW for 2-level vmid0 page table: 1. Set up
PAGE_TABLE_START/END registers. Currently only plan
to do 2-level page table for ALDEBARAN, so only gfxhub1.0
and mmhub1.7 is changed. 2. Set page table base register.
For 2-level page table, the page table base should point
to PDB0. 3. Disable AGP and FB aperture as they are not
used.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Christian Konig <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 52 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 50 +++++++++++++++++++----
 2 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 5382c36c93d7..62019885bda5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -53,19 +53,39 @@ static void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev,
 
 static void gfxhub_v1_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
-	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+	uint64_t pt_base;
 
-	gfxhub_v1_0_setup_vm_pt_regs(adev, 0, pt_base);
+	if (adev->gmc.pdb0_bo)
+		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
+	else
+		pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
-	WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
-		     (u32)(adev->gmc.gart_start >> 12));
-	WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
-		     (u32)(adev->gmc.gart_start >> 44));
+	gfxhub_v1_0_setup_vm_pt_regs(adev, 0, pt_base);
 
-	WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
-		     (u32)(adev->gmc.gart_end >> 12));
-	WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
-		     (u32)(adev->gmc.gart_end >> 44));
+	/* If use GART for FB translation, vmid0 page table covers both
+	 * vram and system memory (gart)
+	 */
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				(u32)(adev->gmc.fb_start >> 12));
+		WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				(u32)(adev->gmc.fb_start >> 44));
+
+		WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				(u32)(adev->gmc.gart_end >> 12));
+		WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				(u32)(adev->gmc.gart_end >> 44));
+	} else {
+		WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				(u32)(adev->gmc.gart_start >> 12));
+		WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				(u32)(adev->gmc.gart_start >> 44));
+
+		WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				(u32)(adev->gmc.gart_end >> 12));
+		WREG32_SOC15(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				(u32)(adev->gmc.gart_end >> 44));
+	}
 }
 
 static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
@@ -116,6 +136,18 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		WREG32_FIELD15(GC, 0, VM_L2_PROTECTION_FAULT_CNTL2,
 			       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
 	}
+
+	/* In the case squeezing vram into GART aperture, we don't use
+	 * FB aperture and AGP aperture. Disable them.
+	 */
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(GC, 0, mmMC_VM_AGP_BOT, 0xFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+	}
 }
 
 static void gfxhub_v1_0_init_tlb_regs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 3a89bf76d22e..d53b3751418d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -65,19 +65,40 @@ void mmhub_v1_7_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 
 static void mmhub_v1_7_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
-	uint64_t pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
+	uint64_t pt_base;
+
+	if (adev->gmc.pdb0_bo)
+		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
+	else
+		pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
 
 	mmhub_v1_7_setup_vm_pt_regs(adev, 0, pt_base);
 
-	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
-		     (u32)(adev->gmc.gart_start >> 12));
-	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
-		     (u32)(adev->gmc.gart_start >> 44));
+	/* If use GART for FB translation, vmid0 page table covers both
+	 * vram and system memory (gart)
+	 */
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				(u32)(adev->gmc.fb_start >> 12));
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				(u32)(adev->gmc.fb_start >> 44));
+
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				(u32)(adev->gmc.gart_end >> 12));
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				(u32)(adev->gmc.gart_end >> 44));
 
-	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
-		     (u32)(adev->gmc.gart_end >> 12));
-	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
-		     (u32)(adev->gmc.gart_end >> 44));
+	} else {
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
+				(u32)(adev->gmc.gart_start >> 12));
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
+				(u32)(adev->gmc.gart_start >> 44));
+
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
+				(u32)(adev->gmc.gart_end >> 12));
+		WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
+				(u32)(adev->gmc.gart_end >> 44));
+	}
 }
 
 static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
@@ -97,6 +118,17 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
+	/* In the case squeezing vram into GART aperture, we don't use
+	 * FB aperture and AGP aperture. Disable them.
+	 */
+	if (adev->gmc.pdb0_bo) {
+		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_BOT, 0xFFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_AGP_TOP, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_TOP, 0);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x3FFFFFFF);
+		WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0);
+	}
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
