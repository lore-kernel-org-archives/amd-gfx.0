Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BA0C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16EDE61164
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EDE61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A906A6E209;
	Tue, 13 Apr 2021 20:57:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2036E209
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 20:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4QC9/vRmax5m9sQAJ+yQ+hb2X9Ni2DlQbACMbZzsb5M5GWxyaDByBXzJv++jxWjKZjI2SegtOiByvPWmnsOk8TMmFPzjqfhtMwhDA0hJWy9EvdFnHNT4Dq/uV6LKjNZkvxQ9MQ5ohupmBn/JNvM8rmGh3bWO0iF3XUFxI52orwzrGo2BbSiZfQytD4k6MxvDjagKOQJp555LArnUBxzXNZZ8dn2rsBA8PFRqgIDKSJEDM87w9rPEX4ajeJPIJRdmVwxI8b0FAXy+MtSnR3OytCHhXFKgqnnJaRkQ86xue8pmTTszujKPwg6tTsKOHQiVjVnQNm4ZmvVhvrnXE1f3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9Kidxyzpb4L6EYSjRRA2NFexvUWeVNFKt50pdHnuVE=;
 b=T/kjh04D+Z9MX0wGEJq3FUqOZ3LLLtVuvZ4pWqdFmbPYls6Xr21RqeW/lPy9eLiFeuo2Z7/dhjIEmaM8JcmOulZz+9tNjs0hm1UF90qz8HlH85Q3uaDRNc2qZnVXoHr2bYTcsuNKU9ZrC8Qyctuiu1JkbxocKEnUQ0lfWrhVlttn5jcddRD/2XwPCnKTMmqLqhU4mEmUumV4x6fFfJ+uaMAbAtUhtzhtAbiQ8LJj8jz/8kxcZoWvsJSW4Pu2c45KoxNmQMaPxWBfQZo8o/xZmgmlufXCJTA3VMmeH7+sAeXYEJjplMrNhElW4LyQK4pL9bxmKSF/hfCpN+4TtWeDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9Kidxyzpb4L6EYSjRRA2NFexvUWeVNFKt50pdHnuVE=;
 b=FJHWHTHceitxqHjlJJntFzZtfawBNZdaFfNYCOxryFqsj9GX8Y2zeOgYDruSQ/A5YOUP17ExCQvI7cCKS4ooGsy3alzj6IKYEWsykL8V1NQ+eDGEUTckge/k/ZXaFPwFB3ILBE7rOLNw6YEZ3AvmfcQ/HRrcaG1UyAbuJXzVaGA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1846.namprd12.prod.outlook.com (2603:10b6:903:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 20:57:51 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 20:57:51 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/2] drm/amdgpu: use pre-calculated bo size
Date: Tue, 13 Apr 2021 22:57:39 +0200
Message-Id: <20210413205740.24120-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [217.86.119.233]
X-ClientProxiedBy: PR3P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::22) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.119.233) by
 PR3P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 20:57:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ef5f94e-0b21-4620-247b-08d8febecd15
X-MS-TrafficTypeDiagnostic: CY4PR12MB1846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18468FB486200A197379F10B8B4F9@CY4PR12MB1846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cx9FX39LieDFE/nFDvYd9P2eNjbRcWFaunWPOpBeqlba2OzrkizEnlcv4KhzUHRZbFpRPRzLFr9VehmXlRTc3EQVBgGMSXnB0CHnHvDsqAhQM1eSDpNSpdnAmqw70QcjxvNx0h/dMwsdQ3QjMCQ3TLVYfar16eBdAPZ7iLcFqh/OP6UlkxiP10hS13Sqm03tQrM7grw4fVRVpYEHI7HcuzBP0aCyKczQFRNc5xnAfBjjHc0IujubGNwQOOw2ugN14tDAIfTN9EEIAgZLBzJSDa6YrnJG2FJAuZaScNJ/PlsXS7qbz0KH6WA3Y752GZTTSD2pRYAh7Ov0cq8KN3kcE4X72kbGBlTPbGtJtHa8ybyt+fqmSQs+4XIq1gDSuDbzwNSeBhDDHRXkulNGwkJGY5DKzdXpoHVjZi9dCxZ3qS+J2XbJLv7iJuiyxzcr5tzJUDQjsdCZuTzPcwkOwwiL+pfwwVneXWiP5BkUey6vzWojadTxkCptok54Bl3Ye22UwFQedp05nMPsvfROfrG3H05IW9D2knG4eoDzjaXsBlhRVvMK/gwy/An62kI9PDto44yUNECweE3yVAg/sGhLTx2ooYmSrcgKnbJC30B6FiMQQKNySR1DroQVOpjUtRMSkM1HSzk3i8BEmvPp9TarLcKBdx536JWrRLeINiu7t4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(8676002)(66556008)(66476007)(36756003)(44832011)(66946007)(38350700002)(186003)(6506007)(6512007)(956004)(6486002)(478600001)(86362001)(2616005)(2906002)(37006003)(5660300002)(16526019)(6636002)(83380400001)(6666004)(8936002)(4326008)(1076003)(316002)(26005)(34206002)(38100700002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2s504BePr2OOnynsBMfRdxBAy7FqkfcxRKS2eTolvlxeX1o1K0UdbVNFDpn0?=
 =?us-ascii?Q?kvKWrASZti7xv6VKMttYg3BTF+k1cGp/GLJW2SOFVbzBGm9Z+G9jErBaQL/v?=
 =?us-ascii?Q?H6cdgOPi0JPkxBJ8m+UKDVc7dxolZig57r1aZqWyTGKIk1fMe5u3B542oXp4?=
 =?us-ascii?Q?RjukTj45hTSYCuyrhsuQ2NYbsttvfowN2JWr86NB7gT2oMRXi8IrH6SkrV/t?=
 =?us-ascii?Q?jLz9g1BAQrwB5rMQfKm/bKtM6rTGP1ndwvX8uoQJA3Rjv8GT7a6u1xXN2fmB?=
 =?us-ascii?Q?Y7dTWL15+AfA0ejKI3tPa1hgIykDhRFWcAL/XvT3QOW6M/4KRQShujUReyJQ?=
 =?us-ascii?Q?rcUIsD8jR7u/asP3o1QPm2rpNC8LsE/uu8s0NUl5bNUWeNlV3WrMvp6t5YQW?=
 =?us-ascii?Q?xK1VD5QsjO/gXQCHOsi3uFJI1keSE4ltKb3Ecqd41swEPB2JtSgNdOo5zIDX?=
 =?us-ascii?Q?9+neBghqfTgN7RVzLn2XtKiUKm+GBOUllIz2QCG2tGPg9L0YCXWeZc122BUi?=
 =?us-ascii?Q?QcSac9eskUyxtN+u/jJmVFG0ykQjFM5uwxes/k5VyvDnZ3iV8mx8549Gv/Xx?=
 =?us-ascii?Q?OhiHnRJFlRnRSeZOzrSllkKk5nI8623kMHMWYV4I8l3jEQeh1Mhr0QJ5eECK?=
 =?us-ascii?Q?icYiRrB1D9rNqXP97/RbfjxOyp2p8mPVzHICQCiJGpqPwZFZliZZI4vO8sDf?=
 =?us-ascii?Q?BT2ctFR+zWZCzaeqKKIl/FfCGtgseZRAsxezb8NlbePXYOKBXIquuGCKPj+z?=
 =?us-ascii?Q?/YdU1dbde+dB29BbvTXy1eFzpD0Q8Vola8ouif8LzZ2OKvlZ8SPKM8k4A9Rt?=
 =?us-ascii?Q?Lg/NnyXBo+Z3PtfJF/SprTb6cnjgJ2HxpiL8wxYwNkkP0Eic3k/XywyNg9sz?=
 =?us-ascii?Q?gECmlFVXUqglGH4RB0V37J2x5VNfsFfQZ9zlx1R9rA0YatVlEgdi5wH74fet?=
 =?us-ascii?Q?xjqBJ5MPHIqROYopkwCzq3OA0Mpfzd3dLnZuREJeaQs81U3p28iPG9ypWtJO?=
 =?us-ascii?Q?F70nWOO0jB1OxiwkAm+pY8cqRO6y6CKw0zD3zTDAOrFGE0uLA8VbOStwXh+I?=
 =?us-ascii?Q?VUq5gXIeSB+savXPLwwTBfbkzQnPQLxPKFor1xCB50hSwr+c1DMUhs1YJplI?=
 =?us-ascii?Q?6Nw7ZC8/XTMB283QgCXfrRErfpF1IJ3z8BnzOJtd3dQFOlbS9kDjIEYWgVPf?=
 =?us-ascii?Q?udx7y12RmaV372ZH6nnAubFLsdxKavzYtU1OiPdgDGc8J3HdmYkNDzQLy83m?=
 =?us-ascii?Q?VDWNQ/13rbcyGrfU1etEphvASukS1AoPkc1TFf8urt8O8JueE5AUwVv0Qhkt?=
 =?us-ascii?Q?4U5K7B+eqOs2yzV7geW4LY5D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef5f94e-0b21-4620-247b-08d8febecd15
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 20:57:51.4799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLDDU6/MwP9kpjKcwqGSJdODddkdTxBoRWukOUhgm4uRbmknA6NzDo/IN1JIM/diIKdpPqq3HdgbNMr/nKxHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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

Use bo->tbo.base.size instead of calculating it from num_pages.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1345f7eba011..74ecc0c1863f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1371,7 +1371,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 	if (bo->mem.mem_type != TTM_PL_VRAM)
 		return 0;
 
-	size = bo->mem.num_pages << PAGE_SHIFT;
+	size = bo->base.size;
 	offset = bo->mem.start << PAGE_SHIFT;
 	if ((offset + size) <= adev->gmc.visible_vram_size)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 936b3cfdde55..26deace78539 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2048,7 +2048,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 			return r;
 	}
 
-	num_bytes = bo->tbo.mem.num_pages << PAGE_SHIFT;
+	num_bytes = bo->tbo.base.size;
 	num_loops = 0;
 
 	amdgpu_res_first(&bo->tbo.mem, 0, num_bytes, &cursor);
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
