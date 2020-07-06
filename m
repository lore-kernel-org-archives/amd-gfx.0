Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D861C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E4B20715
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 05:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qTdMeaBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E4B20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB466E314;
	Mon,  6 Jul 2020 05:05:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B296E314
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 05:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCidbei1dpOh7hTiq+EfZywJ5nB78Js0Xv9UpMpuLYe17j9o9kZljah1RTvnG5Uh51d4KFlB74TedH1kbW8VP7JSQ5uvMM5Uou+sRKgKSv86t63fOcPc8hsDh2w/2xchgatuwItM+KdN7r7F7yPPYzHFOMi6rNEuGRN6t/uYa9Vg/V988/jr9afEQcg9RmRyxd7SsXNY16mHMaELFr8AUOeFQbTWDn+cEX+AflU49l1C5cPzLbOZ2tSsLrv3zhMzgyRZXJL+/fVh/qy55XY0jyGVR5IUjG6psJXu7hV9sYxPK7Vb6bZgorJ3bCCO6E/FeXZI15EA4X/K7o5PlLAs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBgHODi+yhSFQpvapA2RppEO68RdBwKeKgxo3Wi/m2Q=;
 b=FxGmpmReAQZtwqFMJxvkhdM1ihalEpMRs9R57z6dKPiGk7RAuWI7ISq+IuOP6OJkl3dLaOL54cDIEfNt9jJH0XDvrGA2JD+x6F3UT1dGk+GfIUcEfwJQD5Jm3XHT3DFVG7tWitF3QjebzdUr1zak2UX509+ygmD9DgQaVlPqEsM3Je3OAECqzhZRPakyHIqC/pGfqcejNN9t5Uqb62OLo9o2m6dD4qpEMtMuCxIbxTpH1dx6PeLGMzacb7W6pvQGC3bNi9Yfpjkdr9pjwa/pAC0s2mD1aNzd+gWMeiLXS4+f1Pm20swwT0+RT83U9Gj/JkMr1hdA0LPL9k0WrC2k+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBgHODi+yhSFQpvapA2RppEO68RdBwKeKgxo3Wi/m2Q=;
 b=qTdMeaBT91OeDvjHWkBmuU1lYZFZ6Zn9uBCsh0st8cNObXKnb+TBmKckEkD8YGEbiPBtaGpkmq21OMzKPOAfLkTsmWn2NyBiT8gOJlBnACQBgHsDPebDVrxlqXdITGtndNsId0W1R58s7p1qQOzjLGRjLrCGobe9zODNHyAaT0I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 05:05:57 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9ca1:81ba:bd45:53f4%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 05:05:57 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/12] drm/amdgpu: use register distance member instead of
 hardcode in gfxhub v1
Date: Mon,  6 Jul 2020 13:05:04 +0800
Message-Id: <20200706050509.714975-8-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706050509.714975-1-ray.huang@amd.com>
References: <20200706050509.714975-1-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR0302CA0017.apcprd03.prod.outlook.com (2603:1096:202::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.13 via Frontend Transport; Mon, 6 Jul 2020 05:05:54 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 37b488b7-4b20-4717-4bbe-08d8216a4434
X-MS-TrafficTypeDiagnostic: MN2PR12MB4470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4470599C148EC6BA64F8ACCAEC690@MN2PR12MB4470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s32RdC9WW7IY8o9R/a0zee6FRaHNHQeKRBthuw1ZoMmzl2rMgWTjfFFR0KW/CUnnZoxR7TzuPPLRL0tgyGsa40WmpFyVx76jGNBExeMOjfodc+kOpNCmYe9NPKfD2VoJLMKEqgHyP+6Dn3cIW7VH5hdFujmsLWjor7d1uch6sClR+bfM8hn2XwOQ9nT27hvEtrKtEDtFgdfDs/A5R7FhKCHZTeW9Sz8P50Wo8z6e287Z28ZLSZ1jQzy7IzZg5jb5ButyY95pIw+bLqS9clmzV63O1jFhL9fL9l2fgU/Acal9HO+Ie6PA00D660+z2NFG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(6666004)(26005)(54906003)(66476007)(7696005)(52116002)(8936002)(66556008)(66946007)(36756003)(478600001)(5660300002)(86362001)(6916009)(2616005)(186003)(6486002)(2906002)(316002)(1076003)(8676002)(16526019)(956004)(4326008)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MZs9yLo9Y11T4TQ06IUM8FHp1f7wepxvwN+gQn1Bz/X0z90tTr9Xq3flnB0+S1X4Uy2wk4wOlG5x/4zn1W8YiLfkNocmcR3F7QlVFMbcGYbxW744ETAISxnoNc8PTmoU9JLe6a2NagbjGAcvOx7qQx8+Ph8iQ2S+upJ55L2D8iXhiFJxt31ryR4MO0MoErP3QcmBHiMsocjxpepbibu2DYo4l0RR3Q3Y9jlvC8b+DrqslWRbSYi0LAu7j7qvtgctverp/ok+p9R1xbrpewz34nggHFy9jCRHDxLEDke2EhZphpP/TEoY1javzlDHowcA+zcbD6w5TH6s14bJqo+L9CVCmdy+Ip+GINPzgi3BRiEVH43veXNaoEZQIopCpFoqIeIjJ5iYh6MIwqzc5aqOcGsKSwVailVdaHx1goPYh+Lb5l7qqZQMUah+GgDny3UUet3CswQHjpbZDWpkFjyxzpQKPumoOOaIYsHCTq4JXvuYbROZ3DkotmL5T3XKjZXm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b488b7-4b20-4717-4bbe-08d8216a4434
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 05:05:56.9991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByT23YGhHrlh6yXqkqXAGe1HTAeOvVnS32PwxRYbtv/JafybuIxNIhj+/7JChzQnnbclqtyIrnTGCEIO91kHpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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
Cc: AnZhong Huang <anzhong.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Huang Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Leo Liu <leo.liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch updates to use register distance member instead of hardcode
in gfxhub v1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Tested-by: AnZhong Huang <anzhong.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 41 +++++++++++++++---------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index c51833fefc7d..529e46386a50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -38,15 +38,15 @@ u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *adev)
 void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
-	/* two registers distance between mmVM_CONTEXT0_* to mmVM_CONTEXT1_* */
-	int offset = mmVM_CONTEXT1_PAGE_TABLE_BASE_ADDR_LO32
-			- mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32;
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 
 	WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
-				offset * vmid, lower_32_bits(page_table_base));
+			    hub->ctx_addr_distance * vmid,
+			    lower_32_bits(page_table_base));
 
 	WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
-				offset * vmid, upper_32_bits(page_table_base));
+			    hub->ctx_addr_distance * vmid,
+			    upper_32_bits(page_table_base));
 }
 
 static void gfxhub_v1_0_init_gart_aperture_regs(struct amdgpu_device *adev)
@@ -207,6 +207,7 @@ static void gfxhub_v1_0_disable_identity_aperture(struct amdgpu_device *adev)
 
 static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 	unsigned num_level, block_size;
 	uint32_t tmp;
 	int i;
@@ -245,25 +246,31 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 				    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
 				    !amdgpu_noretry);
-		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i, tmp);
-		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32, i*2, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32, i*2, 0);
-		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,  i*2,
-			lower_32_bits(adev->vm_manager.max_pfn - 1));
-		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32, i*2,
-			upper_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
+		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
+				    i * hub->ctx_addr_distance, 0);
+		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
+				    i * hub->ctx_addr_distance,
+				    lower_32_bits(adev->vm_manager.max_pfn - 1));
+		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
+				    i * hub->ctx_addr_distance,
+				    upper_32_bits(adev->vm_manager.max_pfn - 1));
 	}
 }
 
 static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 	unsigned i;
 
 	for (i = 0 ; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
-				    2 * i, 0xffffffff);
+				    i * hub->eng_addr_distance, 0xffffffff);
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
-				    2 * i, 0x1f);
+				    i * hub->eng_addr_distance, 0x1f);
 	}
 }
 
@@ -299,12 +306,14 @@ int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
 
 void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
 {
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 	u32 tmp;
 	u32 i;
 
 	/* Disable all tables */
 	for (i = 0; i < 16; i++)
-		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_CNTL, i, 0);
+		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_CNTL,
+				    i * hub->ctx_distance, 0);
 
 	/* Setup TLB control */
 	tmp = RREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL);
@@ -360,7 +369,7 @@ void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
 				CRASH_ON_NO_RETRY_FAULT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 				CRASH_ON_RETRY_FAULT, 1);
-    }
+	}
 	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
