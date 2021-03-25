Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAE4C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8045E619E5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8045E619E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4956EDBD;
	Thu, 25 Mar 2021 16:38:50 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE9A6EB70
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce3myGjNbV0Pr+t3LHXQ+ztx/aTQHinucFr2ma5Ekx5oIGMvePXbzzBXdNa5KGt+n5GNnMfU0EZBoHxWcM+fONtfCOTYQQQDoqtHarsOTHxA5y6l9GpMXDowGB9MZ3ludmzlWE9OHdSlV01Zg8eo7g6Xm1QbevvigZsu3nZMwkNAF9iNTPAHb7OCaCF0vQe83X9XgRtE1DwyDt3mn+C60SCnEmOPbRxfqYCCW2Jogtjf3jkKEEExWQr6T+XoE8zVQti131PR7K6cDPLYaPGfYyy2cUV98jiI0kCgGtRAeN2xoGKFni2cAQppwG0lkvBJFzEv/4sc6vwTXwt/rmGopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPlKpatTT7eab6FS1TTKU9VO43ySd+K3gryTPUiAPvo=;
 b=kASjgLg+74AR30Wc2xoFeLX1mifmiY0edpt5KaSOZFQM5N5QLoLK/M6yphGr4skgpOs2k045EOiJsoE3e0PL6ochTs5i+3okfPLTTAmjVbMDyiaMQcI66o06V4NSD58WwHTCvizPeGODjcwP49k0DZfLkq72qqnQyvvlqzB5gujXG7zL5m5dxjNSb8cKGzuNUXVDkDb3H9G/qz+QewXr1GnS7NH1D12/DdMpff3dMTAwKGrnlH9iRjwdmDabG2aIwFXdBMdpjlDAZryiOXnfB0ylM/oxOZH2JdqWzbpu6YuBS1DPuDpmaTjC28hbhkpkXt/UVStKfrGzk2/YTj5vQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPlKpatTT7eab6FS1TTKU9VO43ySd+K3gryTPUiAPvo=;
 b=yhYx6ZyeF4HFxWhRZU7xoRgVe7xsnoqK3OcdrfOeg0ljG8myeOY/49n0AsIlPwV1MuxZZ7MMY0bs3C4gQNPh/E2gtyHZfKK9gWRIfHgr2KF4Hq38eSZgGXGQ6L+TJe1gmqPMguUMb4Wrp+aPXmWgKkfxiFx5EQF9g2TEmiEFv8U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26; Thu, 25 Mar 2021 16:38:46 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 16:38:46 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] Revert "drm/amdgpu: workaround the TMR MC address issue
 (v2)"
Date: Thu, 25 Mar 2021 11:38:37 -0500
Message-Id: <1616690318-3555-3-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
References: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 16:38:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7cb109f-2d14-4ab4-5e59-08d8efac75b7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2636CC5E652952F65D5B51AF80629@DM6PR12MB2636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqMz962yYAROqd/gQDBcXYJSD/W1bzEDqodw0LNWskqOsJ419L9FLUUICytA/U1XhdKsS/pOI41GSIpxFoKORTyzqJBoY7EJADqe3gRgjT20vRWDSu1Cc9WAZVuGFLVKK865YE09xUDN0C4XRv0v184fsd+0mXBiLqnHQ2K1hhBVSQSPAiLds6+glN9byVOFBteaGIjINBCaJ4eMOzS6lt+ALyd8F86chie9kXKyHxk4INx5Ry3Kh8D8RpcedDD5OO1TbRBXdqYmaZnhLSSnN9BL8ztw7qBmytkqHtVPnxM+9wnqV9CAnygGs26W54zVe47Y363KiMc0quAJ/ltFhlgy+ZNzI4FsLLFxfdr4M4wEl3p7rJZr4SrtvNZ8ZJddfs7GxT+OYKLKO6MTaOHErh0H3FK7gFBdaN0QQXMIrUEbHn488/rymof6smHNTd7cgqtD7qxxoNHC9C2lU4gXpTZKpWUl1kir/WzRCmLWcsUjCfYiGkMdFaKeOIGDb4RtDR4AELkpzAMI9I8DdKgSI6Y0CKcmLOwxdICBeuTXBLxtT10xLbx06ihFT1kSy/vP6ezg+6sApMqYpj13/0u9PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(8936002)(316002)(4326008)(478600001)(2906002)(86362001)(6666004)(6916009)(2616005)(8676002)(16526019)(7696005)(956004)(38100700001)(186003)(66476007)(52116002)(66556008)(36756003)(83380400001)(66946007)(5660300002)(6486002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MVDp1d9yIA5GCy6ro38TYUig0/lQnC3mdTofsEa7IlAfxbKqfSIDqqWnWZ8D?=
 =?us-ascii?Q?GgGYGWJrWGL8y3VpWXSfO5zghNzxCbf/g2YfruXhIJtPYHiybds4b/ltaXym?=
 =?us-ascii?Q?Hsh/6twHgGY8DP4L6PGld+vIc6oG5X3dkkuyc7vklCoDWd5BwIhDlH+VLltm?=
 =?us-ascii?Q?nzNtuNEzam5De0N80JXRVrcKHDiZmcDcGQa9/8BIinXps/d3kfI1G9G0cMmb?=
 =?us-ascii?Q?9KWXY3n2V+znco3z0Mc9bq/Tg5LcWOCP/ZGqqvnamRtInWzQ7jw+nrMge0Nc?=
 =?us-ascii?Q?cM9eVDZG3e5NWmi1Yfi4cU8YqqyKdQl2tS28LrckeEf4KmAFi9ARDOLxjhaK?=
 =?us-ascii?Q?/B+OkJYW4I9NcG9QY6+oEZD0Yv6L+CC5jFhfdDpRqmY18iVFYPjlu3birhiX?=
 =?us-ascii?Q?LI5jgHkAQVFzDmwASsHIH/XpJzHfv4dID4DDf90aGVSXXRc1Bs11rWGb76gs?=
 =?us-ascii?Q?orQo1ZrXDz1fOTy978okybssuleZ2SGoFTtGX5vqZv3OccHK+Y1WTQ1Au6iB?=
 =?us-ascii?Q?/QkDjqJaE74Mnz5xkD24FuORIPJHvOYrFVOmX4bsJSDuWcZOnERrIMo5OZ7q?=
 =?us-ascii?Q?/++c8tOh5iq/jVJcffxN4AqAPwR1IAMYO+umWsgRRXFQ2qcrRBo5WX9JLbsj?=
 =?us-ascii?Q?2RM3D/UKa8t3ZVa3MoQrOMH/fDZ17P2WUUlpQYm7fzS4IQ0CWSnoEua/16T5?=
 =?us-ascii?Q?lEztP9IsYSkFZxjTl3IFJESxYKt0w4pMmpSVeh099c8RsEwQKkgnn4j/t6fi?=
 =?us-ascii?Q?DJEn+LlYSkaUVa4Z8H8bKy4dNYBWHyWab7XfaXyCO6ckqUYINFXiXzvt2rg8?=
 =?us-ascii?Q?3YSjU773MbeHYVZXfxVjk5NKs0CoP3nbRI9a7ifwDRXOZbQ6Cn48RHK21C/1?=
 =?us-ascii?Q?M0nuztezdqZj8YeYVAi70FqGZ5W/PPn66YF3rhrE4TtwhXX9EJrvuqiDcn60?=
 =?us-ascii?Q?CgLt2NDcAXslqXYs/wMLT21DkCrdU0Tm8iaPECYdfKjys3jxA2FWdOU0A+6k?=
 =?us-ascii?Q?wPAeTTJe34YPtkYiUAVnOovMaI4r1SSGWPJo9woTa9MHfFgTsfRaGmXEkJXQ?=
 =?us-ascii?Q?VR1hgL22etPIKjtSOKq/4rpmoAyYAfWFbyavkqrk2NdrqHq0RDjcD+ccpZMZ?=
 =?us-ascii?Q?STMz/wyiNz93JCXg/4qgO1R0IcDsptPVe/CsG50GMEfdYjEUtGkM66CtvgFV?=
 =?us-ascii?Q?sbAtVcPATxrJgyUCYnpIiq8lLu+WzY/xuYfN+nAg7YiYox24nxeGMH4gn082?=
 =?us-ascii?Q?/k/OuNNLhGS4hNe55VVIPaA/xkL0Jh5TPRsSkSX0DGTBUex0qsyoD5cFnO2Z?=
 =?us-ascii?Q?FMiIquVkRM0333ZA0gkAmTco?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cb109f-2d14-4ab4-5e59-08d8efac75b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:38:46.2789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNlBZFkP7Y09beRSuyFyFn48vcIdMhPkWeIxdJcsWKPLVG+1jOXYizX0u0dTK2/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
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
index 7cd9d34..a9e0bba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -217,15 +217,6 @@ struct amdgpu_gmc {
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
index 5c71c5c..1005124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -410,16 +410,6 @@ static int psp_tmr_init(struct psp_context *psp)
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
index 7beef4c..8c8f0d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -154,21 +154,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
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
index 8862ac2..8bb36d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -51,8 +51,6 @@ static u64 mmhub_v1_7_get_fb_location(struct amdgpu_device *adev)
 
 	adev->gmc.fb_start = base;
 	adev->gmc.fb_end = top;
-	adev->gmc.fb_start_original = base;
-	adev->gmc.fb_end_original = top;
 
 	return base;
 }
@@ -148,10 +146,10 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
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
