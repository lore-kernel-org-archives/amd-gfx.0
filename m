Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE37AC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F0BD64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0BD64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388B16EB91;
	Wed, 24 Feb 2021 22:22:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9296EB98
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4pz2OWpxjHLjMhqS6Pmv8vTCW1DSq+siRZ3OhYSh8z/414w5lcU9Maocoqi1U9B7lwyhyALtKUoO6dZViB6c4CaxrGGMpytBQF0xha/C2r2W81KCDFvNQZrb6ZU1UQfhFw5O7VM46xhoDRNId+W64+Iu0ULFoVY+plFxxfyo674gLQIuzB68cN6c/uG0FUxAg4/b4kgHyWcjJNTxd3BIjmxPlDzZU+fDa9+Ik0ZjrcVAi7XUZJfxpNcqVbTdkcRv2c4gpPsCPzcHQQ7yfqn4bQiexiAVOBAAUbnlghT1d1rI1JYTPkl3reOkDx4pR+yoXB5BuX4bB7ggySNdUGcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJJPJy8CQKhECiGCiNdzbR3RPjqP3V6wn0t+YU6+LB0=;
 b=NXiezEqSa/uJxwZ8Jalh5cMcPH2Qk1MTEj5RvL4ODYSt3tWVo0tDYIhbEcNld158puSxnHynKw8jGq1KbNDXiT81Y0LQrL3lGjdTMfHu84O7DjQ70CHEteJK/If9e4dKmxO5Ena4XTK3Fd9ORltvhH1jWsqJO43J1ofKJ5ncVryYAW5mu0Yj9l9WdxOJ8s6o1XqAVQHX81eX3NAznA5elHkb0Gt+iOjvP2KuDXVjqSl6tnnnYZZi1W3Wk+7Duz18qeKHSATIlXRQWevw512QU+JHMcJQd0DRF8ass9cgUosm+CjdLcqdI/xMyOXoigaudzSBE+IUI3Zg4I3k0FIZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJJPJy8CQKhECiGCiNdzbR3RPjqP3V6wn0t+YU6+LB0=;
 b=L7+f0zMOMCXMqsnooKLM/BeigVvfAINml0aEra6NoYFNWArj5450W7t5gZohtHVg8aa+A32Vhs/vT8O7UwBVIKFvRguqjRENLQ3qcHBffOXrwdItfFhZVrXa0KQqHj8iJ7OKWUCAM0RxfDYY4od8Keoc+z2tssDBdkdaedAIamI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:22:27 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:26 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 131/159] drm/amdgpu: Use different gart table parameters for
 2-level gart table
Date: Wed, 24 Feb 2021 17:18:31 -0500
Message-Id: <20210224221859.3068810-124-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2763c4b0-8ff7-4dac-228a-08d8d9127208
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503B1CCAD1B95C8B2106C9BF79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UxC7WtSvROU9c1PvpcM1JhqoSzpkPCduVcJzF/BdbhlbEz6d2bIf7YmWC1YVt8XrKybqrrWkL5jctZgJ3kHMi5ewBrnU+3aN2pp0gtmBOEtcooW7jiGDIVyU2SehPWZbK14DIy2o8Icr6kMpWGAygESBcHGqeoDotGWiJxfcrgiA+GFlY2XxPp4ZMXN+Sx1D8c3IReSxQSoHeKrzjoHvZRQPDsw1u+6fib9Py4ILnMfu0xpI47rTjR71jAUG3p859u8rNXpdfgBJAplKUXto9K1q4w2TPe1mXgtc1IrQlVyNfo/TYFkeTTbaH/jBrgM1PpAKnwVzhirU70Dq8X0loMGF/Gta1rpALj60QRX7bnELTLjyoonRpuGb+W1/YCEod2NWRPzkWvSqCXXgKGvwHEDXMSvdL2Q1/9QLe9LL8ErcSCUT/VabMnnzB2AY/QaAlK4utvSxtPDNTSqcwjjpmXt15zxaspftGGPhWyb4ydbm2zZjuCx9G4615QOdVRXT9uw3bx0P/HJIbIcrRdOInYsjziq9+/x8sowbe1SdlASKFIvKanmr+U5xyziSAD4t5JfhNiYqI1xch30tzuxniw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RS/xet0nax7UbboKcbRhxEPUff6YhfSDJ0Os966Y8TVJrkNkSmPO0qwGLNH1?=
 =?us-ascii?Q?i0Hvg8PXTyH38edyUnjc+rVZbASz6mz9+phmxrZ4IbHbphKYpkMLe/zkikM0?=
 =?us-ascii?Q?lFouM8zyq4kr6JuIUFAoADFBW1IEkZVEdQ9el5qwoQ/H5An83jC3vxkE6Yll?=
 =?us-ascii?Q?kmxKDjzDWKyWRvSiSRjmQSkbBhkjRIiGG3TXLoMs7ayCXup3XNpjWRDUvOBg?=
 =?us-ascii?Q?NrW7vawDJH50RlWrnQfylSG0+vcg81uUUuz3Ku5n+wAFs+u0pPQjEuxkLM2q?=
 =?us-ascii?Q?y8Qjq6zyCN7Rz1ckdj/JnIxixMgmyzaolyTToj+LgO1wNfWalt0q8ACopTBX?=
 =?us-ascii?Q?9W/dZLsoDKRJs+Xv72rBZPsw2saFn87twGLH1iG750Qe+z9MHHHxAmLzCub8?=
 =?us-ascii?Q?NH2UMo6WKrM1pSLUB024H0pdV2eBOfp+uyFTVhF02CjAWEGU1zgsLWWQzPcK?=
 =?us-ascii?Q?RpLw9MsjmKGZLh0bxki0NOoehAnct3Ftswe2GELi1Bk9wvIrrtMvVOFAXqKL?=
 =?us-ascii?Q?L5VyLVp+6FFRWt7s2D+nw1Eng9j+Yi8Qyht5BsMAmqtNpIU7fARPC7EUm/1F?=
 =?us-ascii?Q?1z6uQC2u3RPg1D0JCb5RaZlgu11ReutI3owY7sxI8Ej1rIs5Sk82dhCwgC0N?=
 =?us-ascii?Q?jEbXWl54Be1orHxuUvjBVFks6YGdtRkU1h9Ae9SDKRx0Y0i6JNflknoHgMr+?=
 =?us-ascii?Q?yZqjNNPSEcCc0Zpv0nocu4AxtyK3W1gN4N60QKGulhBxzIAHm0nh0QQKfZQb?=
 =?us-ascii?Q?qc2z5eT6ngZ01WBLTGJUtfK/UtDfYnDhMl/UjEa8ciQGv+L0+a6oI7DaD24w?=
 =?us-ascii?Q?sbQIvkIQlBmlTpWpw2V6xTVJPfGaC6mxG1kTVWt/5roIt4nUH5tdjXsxUDHO?=
 =?us-ascii?Q?GrtqhA3ZJ1mC8O04plDe6y/wGL9FkcvVcfZ6pxSz3GlIjSAUMdwcSeKt9qPS?=
 =?us-ascii?Q?2IFBmJdIITcmyuQOONKnun/XuNfOf6ae6CHTmef+ACSnGSoP3UXZBfOFrxaG?=
 =?us-ascii?Q?BGVX/g7cVRIgPSJTUPbRC9kCVLmPyG37WM4275LWPp0CEsmkDqpwh5jJjrDK?=
 =?us-ascii?Q?p0SoQQODrsnNoCxBxTKQ8xSdjXwRMfpQy/FNrdd/qxblW/A9d07e0I+Tw4Yx?=
 =?us-ascii?Q?DhtkN8KT6hK+2HsoL/YX5R0SYYs5YMG60kx1tAK1wNQSXxDG/1xpplLbgFL/?=
 =?us-ascii?Q?7B+Y+i1QQkE2lsXSYAYByVqb7Pz6NhtvGYfWaZ9H08ANcyaKa/SWxa0+6PhI?=
 =?us-ascii?Q?dqgcr2LzfNG87k1xontUu4NG1/gpQXq9mPpfG7PO0jDIrwZFnhIRE69JI/LQ?=
 =?us-ascii?Q?YHvyhBzNWThLUBvUwXNUPgko?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2763c4b0-8ff7-4dac-228a-08d8d9127208
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:52.0501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8DJLPjdxil2FSYXThCM3igbhE1B2ARZxcEJaSmTVuUFZ+gGL5ZfbmpwZaTFqQcsQNLD/mgySkzWEfGegyJPfg==
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

If use gart for FB translation, we will squeeze vram into
sysvm aperture. This requires 2 level gart table. Add
page table depth and page table block size parameters
to gmc. This is prepare work to 2-level gart table
construction

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Christian Konig <christian.koenig@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  | 3 +++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 5 ++++-
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index a061a5632445..d5312b8e6abf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -244,6 +244,9 @@ struct amdgpu_gmc {
 	struct amdgpu_xgmi xgmi;
 	struct amdgpu_irq_src	ecc_irq;
 	int noretry;
+
+	uint32_t	vmid0_page_table_block_size;
+	uint32_t	vmid0_page_table_depth;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index c6687c6cf03d..5382c36c93d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -189,7 +189,10 @@ static void gfxhub_v1_0_enable_system_domain(struct amdgpu_device *adev)
 
 	tmp = RREG32_SOC15(GC, 0, mmVM_CONTEXT0_CNTL);
 	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
+			adev->gmc.vmid0_page_table_depth);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_BLOCK_SIZE,
+			adev->gmc.vmid0_page_table_block_size);
 	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
 			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
 	WREG32_SOC15(GC, 0, mmVM_CONTEXT0_CNTL, tmp);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 0fce8506fc0d..96052dc114cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1363,6 +1363,15 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 		WARN(1, "VEGA10 PCIE GART already initialized\n");
 		return 0;
 	}
+
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		adev->gmc.vmid0_page_table_depth = 1;
+		adev->gmc.vmid0_page_table_block_size = 12;
+	} else {
+		adev->gmc.vmid0_page_table_depth = 0;
+		adev->gmc.vmid0_page_table_block_size = 0;
+	}
+
 	/* Initialize common gart structure */
 	r = amdgpu_gart_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 08c50ce491e3..3a89bf76d22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -198,7 +198,10 @@ static void mmhub_v1_7_enable_system_domain(struct amdgpu_device *adev)
 
 	tmp = RREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_CNTL);
 	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
-	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
+			adev->gmc.vmid0_page_table_depth);
+	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_BLOCK_SIZE,
+			adev->gmc.vmid0_page_table_block_size);
 	tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL,
 			    RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
 	WREG32_SOC15(MMHUB, 0, regVM_CONTEXT0_CNTL, tmp);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
