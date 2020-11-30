Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7373C71155
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3292F20725
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xjU+FyuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3292F20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC98389C89;
	Mon, 30 Nov 2020 22:48:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95AD289C89
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 22:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGNSygD83FBOdHtj1aYYpmE7uL2pUhG9W9tZ6BQnzMO8RaP8c8xazbcaizaMEyPe8AkgyLP00/tDO1d0MOtEULaCnnJlEDP2qW8eO1RTLOCGyMXCmwwgTmQ+TIir+h/NZ0HJ8oKXN5ywf7k2PleiF3sk52eMYK4CvZ2Gs4DSK8/HVODkK4WOQaG1zRHV3sPw+ubevQpXWb2WrPfQx6bxpdE5M3eq6jJcZcBuk3/+fd6EUYfR6g+9nQ3QTj+ekt9wMEVILkVpi7XLho3R8G8NOLa3/9a4ZSbjqInUgi/EwBSk4VQ4oi38TGo891x7lK/P+MjlA8yMNgSDep1WQwihtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ea19ZTz0jicOOoMO+KdfKmn/ZaG0ASrVzmkCeTZFIT8=;
 b=nOYT1PZ5ptTdB8QGoHoyA+qDyajT6PjBDAgFNF0+Cx072akKOe30the6A/GADWZ5cFm+nspaGIRtF9oFr/9+2Jo/Q4moRQ2T/6Rxu9EKcaJwAd9D8krt5qyeMsjQYp8/aISL/efxJftHi3jyQr7o2t3eT8HBr/543dKd77UJBXfUn9LKYTS+jntwfRZPB28HvTG9YDU6CSWk0ek0I/8sUG/nNmA2Qvi3VGXThguBGMnHwOQOUibHnP8XrEUUzDrYdW7jYLIYpT022eUJ0gecnU3njoQJ2gGF7PE5opv3/b7RCJs5jdJcC/JEsenBOgMsR2z4aeL+W6jbFgZkOWv3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ea19ZTz0jicOOoMO+KdfKmn/ZaG0ASrVzmkCeTZFIT8=;
 b=xjU+FyuSNy8aViYL/lnQY0MP4bzu3a11w+9d/AYA03GlYsdsjFi2qVe40wVJ/6MlDJZDHvCljNZMGRAy/g80uf4E38wPusVk165xH4CZaaYWSAmQRdMctB81G6BiFOsrHp3fPQlABZ8ODxYocm/sZIQK8okF8erm1TvoNV/emt4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Mon, 30 Nov 2020 22:48:46 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::c402:dd78:9e41:9c36]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::c402:dd78:9e41:9c36%7]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 22:48:45 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: keep BOs in system memory if restore failed
Date: Mon, 30 Nov 2020 17:48:32 -0500
Message-Id: <20201130224832.2498-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:610:4c::27) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 CH2PR10CA0017.namprd10.prod.outlook.com (2603:10b6:610:4c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 22:48:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2366603a-f10f-45ba-fdd5-08d8958217f4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46170C8AE208360F8455C140E6F50@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: darV3FWFTO5gsC+6e5DisFsGFd4FH+tyvmQt2uRBWvk8xoFXnHWz4SknfBB+rXPjW1R2WPLvq1eOC2tGvdw8qStS57XwqJTjwWWap1KnLxA7ePDJlVeElAoUKUzJw5e/UaVFy0MislmLQROhVwOP/ZSNzeYCsoUBpzcFRCnx85WIOPiuZw2skrKD0K/B48owDPzVduPYlq637uPzQd5Wn6G0Oam1SxTvvqJedEg4UyyGTF2M6fMcYgPDTFuINEvbtU4/GF2NPHesPRqL+6s/W+QsMyNJpiCJ687ldxOqyvJEcKud0Ad/ob4VMI+O2oox
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(86362001)(8676002)(6916009)(7696005)(316002)(2906002)(52116002)(6666004)(186003)(478600001)(5660300002)(66556008)(66476007)(66946007)(1076003)(6486002)(8936002)(2616005)(83380400001)(36756003)(956004)(4326008)(16526019)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+rEw9eqxOR1ctDgdePnIhiG4uJoAa7PXytXSE9fjsy8Y/XtAbD+63d60/DC0?=
 =?us-ascii?Q?u/EIpgk5F3i1EDD63FTyEBwSEa9DOQykG+vfM/B3kvkqsZGeI8hHb7JIkSOP?=
 =?us-ascii?Q?NLBn4+x2i0HQ+JGEbKKLRGsvZ+n915j514tH2fiRP/EKmGJDcOr8eHUXBlG2?=
 =?us-ascii?Q?mbD+CghHkDPyGqEMN2mfGE4/BlWsnZ4KHXJt2v8IybDbjJ64o2p5uW/Nm+EO?=
 =?us-ascii?Q?6zZ6lDsrXOVDpKlCFmjpG0XSD/7uMEWjCO23NmEVh8q9A8/9nOUcgfpFFU7V?=
 =?us-ascii?Q?K/p8GuetkRU/vstFMATTeqWcloSXPGn4f1QbxsZs/zZadLmDGJShd/L/H1cc?=
 =?us-ascii?Q?mysVPxtALgK16EuCRS/sv5AdEzO1x2AY2jE5kbwrypkFjNeFwj56ao07OGaC?=
 =?us-ascii?Q?W45VZeR5y+QWB0ygTmH9gYs3Gudvfp81cfXSASakN3a9lACz+LrO0I15rWRt?=
 =?us-ascii?Q?kqy9OeitI6U/lbiGhC0zoCsGebdVCxtYa0A8mwnw29T4iaULAdFKfeSMYTO0?=
 =?us-ascii?Q?J38ptTQAX2TXyup++BTa1nO4gxML9hvJgwjRf+jKz3lIm7ruDvg7i/yd+nXh?=
 =?us-ascii?Q?+3LH3Ek7NQ9YQchnYl/xf+Wvs+DAWNUbOCPZWUiKmm0d5tL04ofVTEMb6m67?=
 =?us-ascii?Q?CN+EdRm1td0wB06RUfHJMdDOmXdhEjme9wXhCQGbXZU6RXJvzgD2ClEC/J/q?=
 =?us-ascii?Q?c9Wm40sIG5jlpWOIcouT6LxddDJKs4xV1hYKovX6QNij3yhQOCfO498e+Yyj?=
 =?us-ascii?Q?JTAMBaD3M8iad6aQ3Up88h1sOXTPkMRiDK+7OywlEV6IsRVYmMB479UKS3Gn?=
 =?us-ascii?Q?y5LHUDSTC4CgQA/mGm24UkzH6JEWNo2VR5rQdhpVpIyOCp0hfUmrjbjWXapV?=
 =?us-ascii?Q?83QLjhpkpz3AmFpjC9mixrnfTLONxmi09l65hkUeRns0QKQgVuT0xhSsikuX?=
 =?us-ascii?Q?pKH+APjhVV9hDtACcVb35DgXxsAmK/WZQ2H4u5BqLiiECzhinTua7t+LzSg4?=
 =?us-ascii?Q?+Gph?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2366603a-f10f-45ba-fdd5-08d8958217f4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 22:48:45.7631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVq6qdiaS1JyOjUA+a3T8V/F4JBKsEm6ZAQVRUXX+o4Y5TrIdv2RoJAB5VlLdQS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If vram is used up, display allocate vram evict the KFD BOs to system
memory. KFD schedule restore work to restore BOs back to vram. If
display BOs are pinned in vram, KFD restore work will keep retry, and
may never success.

If restore BO back to vram failed, keep the BO in system memory to
prevent endless retry restore, and GPU mapping will update to system
memory.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 703cd5a7b8f7..e54883ff74d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2042,6 +2042,8 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 	int ret = 0, i;
 	struct list_head duplicate_save;
 	struct amdgpu_sync sync_obj;
+	unsigned long failed_size = 0;
+	unsigned long total_size = 0;
 
 	INIT_LIST_HEAD(&duplicate_save);
 	INIT_LIST_HEAD(&ctx.list);
@@ -2098,10 +2100,18 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 		uint32_t domain = mem->domain;
 		struct kfd_bo_va_list *bo_va_entry;
 
+		total_size += amdgpu_bo_size(bo);
+
 		ret = amdgpu_amdkfd_bo_validate(bo, domain, false);
 		if (ret) {
-			pr_debug("Memory eviction: Validate BOs failed. Try again\n");
-			goto validate_map_fail;
+			pr_debug("Memory eviction: Validate BOs failed\n");
+			failed_size += amdgpu_bo_size(bo);
+			ret = amdgpu_amdkfd_bo_validate(bo,
+						AMDGPU_GEM_DOMAIN_GTT, false);
+			if (ret) {
+				pr_debug("Memory eviction: Try again\n");
+				goto validate_map_fail;
+			}
 		}
 		ret = amdgpu_sync_fence(&sync_obj, bo->tbo.moving);
 		if (ret) {
@@ -2121,6 +2131,9 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 		}
 	}
 
+	if (failed_size)
+		pr_debug("0x%lx/0x%lx in system\n", failed_size, total_size);
+
 	/* Update page directories */
 	ret = process_update_pds(process_info, &sync_obj);
 	if (ret) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
