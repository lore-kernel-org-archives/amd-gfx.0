Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ABDC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8566144E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8566144E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950B66EA79;
	Thu, 22 Apr 2021 12:36:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E146EA77
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 12:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw8CfsT0hOJQrIa6CJ/EBK3JVL9O6IqwodrV7YvK5ZN7f8VnOBl9r5MzBhgrcdcmvCOI72ciobjPHuucwOBWDB4Z9XcZ19kTY4q1pY4UD9jgNdgKcbzryAD3wAJfWYkwD9/tTrdrp8tcU+MOCBK1V2YGpt2WvmkAPlL3Fo7rDB8/PUQtZLEiJ2P7hTPDNw9ZgwZ6KmBX0cILlgyFXNVakBaeVsvfjIIaYXAJ7J4wFNImDX1Kw1/FFSHl0luOr3OnSInl3V469Equntv54G+RQN6NtY99n10guFtPgItCb7aNFYk0h7kbiAR5U8D+OdLLxfcTRTO7cvMMCZulCHmcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfu6Eap7ppcJ7xmWl8DFBefCgHAfNJJXRc+LwwK4DOk=;
 b=PWTf0mfd2hJFtzBE12HdhgsL5k+fs/5isVdEeknjr9f5kSUyRVdr30QqZny/5/g2kqQMMhdhIYlXlIJ7SxDp9yt5b2WfubvCXNSqccvYg+mZtjbn8bsnStmEAl+9zFREI4siVklwhBMvFIjWS8tTBf/qi5l+XCegc+YIg3nY4/MesWE7JIDTbH5MNXF8/mFbrbybkhImEMNK7tT1jrgU7L6RQGoWqNurWYThwLt8mevX2TnDJKlzW0432L9LNJoDOaaFauhp6RfnumbdakGJGPx5flj4MmeR7rrifGFVoJTUoZGudIwldt729EDrhpwEPMl+B1rPt1T7NFcBFO+qSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfu6Eap7ppcJ7xmWl8DFBefCgHAfNJJXRc+LwwK4DOk=;
 b=aq9GX0p050rGunTQOwFzcwzBGp5fKtWz4/1D+gYHOEqpIhrIegm1+6ZX1NOSOCcxkPoZ1mRk3EeoEd2bYDNZd676GiEUuWEa+r1aPZaB4jB8iQwbIlY7KI1I4gSof9cM96OZrTpS0XFkTSe6BFxF7hVwunhj6hJt9lj/Csd2Nkw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 12:36:18 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 12:36:18 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 5/5] drm/amdgpu: remove AMDGPU_GEM_CREATE_SHADOW flag
Date: Thu, 22 Apr 2021 14:35:45 +0200
Message-Id: <20210422123545.2389-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422123545.2389-1-nirmoy.das@amd.com>
References: <20210422123545.2389-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: AM8P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 AM8P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 12:36:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 942e029e-da08-4870-d131-08d9058b3a4c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02317422C397F1229EDBA2EB8B469@CY4PR1201MB0231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsB62AeAmdRO1SJdLJkaX9ZUJFYQedg1jUAZLCkc/nFsb5OtfkICwDWNk3MTKWs9QcgEhcFLAipHaprW6WolsOoNUOed8eGssfpD9ty7jxTjqr+0fTlO1oaCZ68Gru4sB6ijBK8oGMTv4SioVTmE3nBAZQexD4KwaEGDw9fDxwTBQlqe+t9A1KbI0fIVCo35DLudIy5Mso50HfUUqKMYJqq9P6jWsKqjsqcy/LCJ3r8CqXcSSjsvSWWDJZ1eTkRVdanY7ZJaF7+TIjFWA/JhKPtbbW1ozJ6ICAFVwOuJDi7bDkCxU2TC7DGRlAOXaUfaVU3m84jK6tuG9oZvh5lxnDlFCXuGQ+as2EgmuAMqp0r3RAqp00HR/Iuo9Fai9nuIHZs7qQShyvo7BUn15LWGz7VXRJVSAES9M2zTOewrvfXHBPM7+CBTl8ueBSjIJDFccvmaZK6JiWE+LBIpu2ta3kw9Intv2ucxvcW9s8l4niEp85VU+cuYJ/ewsLIPqDuptTUUdEOlinBdkKpEGhXsXdbnKJ4mDRxLGLIXSwl3MdV8H/Jr+ZlJKdEzXWTHyrEyrDnkZQ9WMXYZ+EWPle1wKkMt3v50Yh6qpvf1TKxfs9HA+5GxHHolHkX+Z6jxYnMbcm+47AOiZKHgzkDgfIrzBT+EOTYjuPeorRsNBsW+4B0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(136003)(396003)(346002)(52116002)(2906002)(26005)(38100700002)(44832011)(37006003)(1076003)(16526019)(38350700002)(36756003)(6506007)(6666004)(6512007)(8676002)(956004)(5660300002)(83380400001)(186003)(2616005)(6486002)(4326008)(6636002)(34206002)(86362001)(66946007)(316002)(66556008)(66476007)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8W71/cX9oH4UnXFk5NX6Ao8Axcd/Var9MJgGmF7013OsXlWZxhiAkWEbhFpV?=
 =?us-ascii?Q?doZ88YcVzQYL5JJR2EHhC2pf+XVQkjRhFHSxHH4XF2+PbAV2K1NZmBq3SIuo?=
 =?us-ascii?Q?e0+7oNCwLp7R09bJAAVbpcu9AB8LajPJDw7JEvpwcELCwq7gd3SvrmcK5ZrP?=
 =?us-ascii?Q?i9A7HaGMS4Pyv3TYJAXS+LWkOucWma3hRfe1Si85Rk+a8on8b6hJtTYSx4B+?=
 =?us-ascii?Q?ZIzfxTngm2uGnQBth12XYwAoNCBM94uQ442aBN0IljFp6R1gtKUAk60++dbS?=
 =?us-ascii?Q?smDSWJlTJOmzfmAwNm0ctzGbn1CgmcHemNt7uhaHwGOmnwZSAI4s03luz09t?=
 =?us-ascii?Q?TcqOy7UM6y5PVVgSloI2fYpbRgce/YnpDxBzdPsILHakajFoAvkMRN0IPevM?=
 =?us-ascii?Q?eOwcdmTmSgNyJ61YsyCY7Rq+dVyjKIm1AA3OT4p45HhU2QbJ2x53d+xgfxGP?=
 =?us-ascii?Q?wRjSrIIXJQL9taeXxPlEKMhovv2TGWJMeY3Q0pQFScH7sur/CCZuZjeSdo2v?=
 =?us-ascii?Q?4tL/HI+5IooRRTHs+vk4d69petK3cCiDanjIl+5VGeQeJXtYIuWul0/0v0Nr?=
 =?us-ascii?Q?ZzNzgu7TUyg9qnNliQfog4ovUCv52yBRwcoIsH/L7EKpe04eyeuULosizSVu?=
 =?us-ascii?Q?Za6KMVUVUxY25O6iv5MPj3rZSdAdRpULsvYTHMdlpn4L6seRnj0jvGXd61n5?=
 =?us-ascii?Q?mwuGn39wQKFpTzVUQLEsq/kAQgcMfNDbyUj2eHJv/Q7uZgLrssyn9pQa588V?=
 =?us-ascii?Q?IuBbO6lXt0pQB0NOpwWiLx3dOnrWKowM5+vDqnnXHT6P6rZ/qeIcgKTC/4qj?=
 =?us-ascii?Q?o74RWqCPsa1eJfKjW6QgaWLk8zHWjTU7ul5YSHTyQgmh0SwQJ87/vE7NPxvp?=
 =?us-ascii?Q?C8t2tOh4JUz4keGzywvrwg4BJdINopfbxRkxeDvUiHAyeZIHuIopMvepvUMQ?=
 =?us-ascii?Q?3KWKqkfCA04CEueDBlNCUQKB0eedabOByMvNRa5o8dwoyUpvNI2UxaRvkiaL?=
 =?us-ascii?Q?0tqWraNJ7tEdwSjalwao2ZVKSYbkV88V978PsjXizDenBs+52n0CXkx4dwnv?=
 =?us-ascii?Q?lrAU9CXGRnLIZZRFEfpAP81cGK/8dST/OcY69SCnyCX47oCkyH17uT2goBTn?=
 =?us-ascii?Q?ZiihNQbX7p3fs1r7ephIVpqnHLuLRb0XXgZLKaBkajp8EZ82W8PkIig064X3?=
 =?us-ascii?Q?5s7WGaIlzlVagcxKAkyKr2e/MRhPhFn0LxZ9fR+XgJRq+nn36GmwgNl2lSEK?=
 =?us-ascii?Q?ylIuIA4eP6epjKZb5rgH+7CoayYGrMus3QOadXsvPTWKItuN5j1DU02oFh3C?=
 =?us-ascii?Q?4RkTTnm9erVWdXb+El1pZ0ID?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942e029e-da08-4870-d131-08d9058b3a4c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 12:36:18.7831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGqvH8MVhuhDmd0nCfFmKapBGYH2iCqom3eqLl36q0XwfHg2NM4ggSPjvvQBFxN1bES9bOPBHuCTBOUU6uQ8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused AMDGPU_GEM_CREATE_SHADOW flag.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +----
 include/uapi/drm/amdgpu_drm.h              | 2 --
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 4256cbfec5eb..2d9bd0d4f81c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -638,8 +638,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 	memset(&bp, 0, sizeof(bp));
 	bp.size = size;
 	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
-	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC |
-		AMDGPU_GEM_CREATE_SHADOW;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
@@ -692,7 +691,6 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	struct amdgpu_bo *bo_ptr;
 	int r;
 
-	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
 	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
 	r = amdgpu_bo_do_create(adev, bp, &bo_ptr);
 	if (r)
@@ -1566,7 +1564,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
 	amdgpu_bo_print_flag(m, bo, CPU_GTT_USWC);
 	amdgpu_bo_print_flag(m, bo, VRAM_CLEARED);
-	amdgpu_bo_print_flag(m, bo, SHADOW);
 	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
 	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
 	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 8b832f7458f2..9169df7fadee 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -119,8 +119,6 @@ extern "C" {
 #define AMDGPU_GEM_CREATE_CPU_GTT_USWC		(1 << 2)
 /* Flag that the memory should be in VRAM and cleared */
 #define AMDGPU_GEM_CREATE_VRAM_CLEARED		(1 << 3)
-/* Flag that create shadow bo(GTT) while allocating vram bo */
-#define AMDGPU_GEM_CREATE_SHADOW		(1 << 4)
 /* Flag that allocating the BO should use linear VRAM */
 #define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS	(1 << 5)
 /* Flag that BO is always valid in this VM */
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
