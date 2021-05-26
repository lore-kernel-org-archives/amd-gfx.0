Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C722CC4708B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9422F61090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 13:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9422F61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9AD6E4CD;
	Wed, 26 May 2021 13:07:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 618896E128
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 13:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRHLffLynDEbvQr5INZ0paSAi4EhQrqPjohWpClQUs33d3RKaI7gKYFYB71BBG7OCgwYGDYYDvdK3Kz7Agto7DDhZtFR/LJP1xr5eJtQ1RqAQmMFSrnqx8IlKd0kHbTCUhtMVjHALFRizsFcOsV5OQc7q7PDypBuODhKfTsacqwdxd8xNFmeCTRE21ZzObsweyLRhiYiVaCa6JDeccF1M5hcS5lUrXOpmbPDu+utn2hjuugDoIBLq8Ybv2J9NPE09hgLSoaVbe5CPENv1gNYvTjuEpvsGMP0SCkehKYXb4skMHakS6QisSWDlTu0kM9pLxLOxmARggrdZqbSUaF1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWJrDbIlMDxBZBrVEJxICKuo1dGnATlXIEVfA+ajhpw=;
 b=JvR4R2s9bnatg6IfNRZIP+nrNtHVFYNlY9CMIzxft4jupzqKbnXczorc/pfclbClNAlzuGQJ11mS30fjeH+PK49iCmzk8dUdXpjvkYaSQDP/Rnz44+qGw7tN6bLHTChXvVVjhW+ev1JNbxuPMMQsu1QpQ41ufEb6WXpzkVxH87Czjx6WRDbQq4GUuoeuoRp0txSHuez0ZFOfw7iWhyk6SRRbXn0SeEdraQhoh8NIBncbL+Y4LKBSGLwNC1P9vsVZm12VvUTOr0S2n7GjpKBu0gnS6udqAn3mUm5NDSC6fxUFF4IR95yJ6BAIMjETjw0sMuPz+57Lxrlr0bb7sH5QhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWJrDbIlMDxBZBrVEJxICKuo1dGnATlXIEVfA+ajhpw=;
 b=DLBBStnqZzmmc8pr7I+HeJS+g1QPTsKPfY4a7rpJLqDwzb0LngaWgh6eFa0eUFwgL4xeQP1Hi2DIu1joxrGbPLTkCPE8j7MMZQBDssJtJH4Ij/I7Kiq/uGeCOei8i9vBZfxu15QqYVtLfD7lsXR05KFw3q8ZUmIxXkCGrR98/LY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5568.namprd12.prod.outlook.com (2603:10b6:5:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 13:07:18 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 13:07:18 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/5] drm/amdgpu: move shadow bo validation to VM code
Date: Wed, 26 May 2021 15:06:55 +0200
Message-Id: <20210526130658.4237-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526130658.4237-1-nirmoy.das@amd.com>
References: <20210526130658.4237-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: PR2P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::35) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 PR2P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101:1::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 13:07:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75cc8137-2a9b-4ce8-ce0d-08d9204730b1
X-MS-TrafficTypeDiagnostic: DM6PR12MB5568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55689A8360427CB95C878A018B249@DM6PR12MB5568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUsrypnoeonyjVfpLtyGWhXG5wIA9MmSv1J7JkmyKN8I5gLLJaufbpRjPRmHwEUiyHJgl3dJtOwfF+C2pw7Y/6vKnC4ASm6Zko8heysq9AM37TeuxyvUxxyYdFFYq+SazFWCvLO/603DzH6c13bJNSsnPNcqxHhW3UgIGg1nSQTAd6WCQjk0cHPX3aMR/+3ndav0I5oUyzBqYHD/pkgh35IrqJIw9ZcMu9VmumAP6f2nDOLHJsfj/gVDSnt7LJvh01Tqb84iADvVnvKNDnWyQfdHq6/tf5Jb4sAELbnNcDJK6T1OMXbuR2tr9+F4pstdNmJcnU9Oa/NxJnQ5105owgPoAi38avAkLp1nU5zbf8bmFbCAZODLSkHVmFF8R8ZkSAsBDmrgJ6WJvD5GtUMil5KE2WhL+21FZ+yvyvHrUO/xgsk7Oj7nfWt1SiaxTgudv6c3R79T+pkjX6g8RdoG0mDbfAStL9fCokHtR28DJ/FVhLhImBYIPEZCgopAoGOjvMsBP3Y1DyOP7XcnUxQtQc2SubvK9C1f4imhdY+bkQYls3hVQ+hH7jib2yyZDYLCCz9H9Aljv+erPHCenahkWuKmBMUC5jlv+35ETxKtfMk2C7PW0WVf0CL+mxMZ7c+KIM63wnOVIl3eDoG2V+ws3yhYytnxRF8wj/mSSLlm61E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(8936002)(86362001)(6486002)(38350700002)(186003)(6666004)(44832011)(83380400001)(478600001)(52116002)(38100700002)(6916009)(66556008)(956004)(2616005)(66476007)(316002)(4326008)(66946007)(16526019)(8676002)(26005)(1076003)(5660300002)(6512007)(36756003)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?blsv0BmPYxBABTfuvwF9oyi2oYMof1cVwjVtMnk6fCIJaq9/tKIGnqc6f0+9?=
 =?us-ascii?Q?FfAi6zVf2GafgMiF/7a3HmkByb8Hr+nL7hXSWFHZvc6+d9DHR1UW0HSUNa4N?=
 =?us-ascii?Q?sVPd+VGB1QukqODDNVqdTUp4S7dF9Fg4NI2687dCmSA5QENoQk0qWNe/JFY4?=
 =?us-ascii?Q?StoTqKE1+NGtdW6MfqjzwomXFTCOQ9j1zW18Lkh9JMMvyZmC9Gg4Jqk5Lqxj?=
 =?us-ascii?Q?QDotOCGGJlJwamMsZDJBM/azHumF3Te5mEJNAO0k9jsDB7/4Wdfqod0R8pCs?=
 =?us-ascii?Q?iA6a2oxu7IfuKeCSC9oy7pasdrZvW52wUCfiD1VMVTgFKopS2UaT/77tzMI7?=
 =?us-ascii?Q?DTXlZYC0Myh6fXNaU5nrk+RjgKIyeKVZCrYlLAUHLhBFli1dsNbJUapWSPlV?=
 =?us-ascii?Q?f4B8g8HrF6oAi9U4+s/EqcPtPqnnVoYkA0iaTp5RB9LklEUalFAxOjMRwqdo?=
 =?us-ascii?Q?BJPczekrwytOjfUSUcIWZmlWu3xJZQ+8Qu+W6XTiVNr+iuOk5/4nsVTe/pY+?=
 =?us-ascii?Q?XSgsCUOQg5q9no+gCmrNUtMlauTgUD1wkLTxgCjIfCU3XfuOpPhOMBJv8aM+?=
 =?us-ascii?Q?IrkuMZYliPeyeEtaMUqFNMik79mjqOsNNhth0/TI1VqCazEbFgSgKAIz9zuE?=
 =?us-ascii?Q?FsppdfuKVSZgPEFJZ7jYwxW+Ry5Whi5sEHzbBBsLeJUXWzSTRtmChkSaYC5K?=
 =?us-ascii?Q?6eGzIF3flrYPbWqL3H0IwdwxIodA+Dyyf6No7ni5SXOiohv/9Mkpad0Fp+d6?=
 =?us-ascii?Q?17c9UmLVbaY4y6650/eY6aapmwHMybtc6KzMnV0T/BokYnq/t6Kcc5djFgyb?=
 =?us-ascii?Q?cYP21AYPUQpjedYrn7DnNbgefDmLblFW3ZXYzIqvU+Mxd6yqo4vke1SM+Ia6?=
 =?us-ascii?Q?tG3+aQOnTbvUB9WD8Y4UgIDMrpKot4WiWPClfYxtvUVFcZh5A/zsJVIxRHkL?=
 =?us-ascii?Q?W9TXQWOy5G1Bu9/odXTYORveh/9l+gpg1fQ9jh4XF8AkLj4mtjAmHltDKvwH?=
 =?us-ascii?Q?APMOanEw/U7zwS4J8P+HmDOKB7dQlMmcRsIwAfWyUKOzBp7Kx3yNtCOgNwW+?=
 =?us-ascii?Q?fzCqb1Jl6fuZY2lNCivNtryTBm8Z8lpRnb5AQFyJNYb7bV1GxzIq0Ae9MTIJ?=
 =?us-ascii?Q?21W8MK1/Gd0vMNonkrz+Wya1mJP6eK/xcxq/yNxEcZk3r9nnPSLjWlGDB7qV?=
 =?us-ascii?Q?uGkbdoWVcuGlJ7Qp4VtM9RTNabTu0drR9JKu8LUpEiscriXy8HjEItJImRba?=
 =?us-ascii?Q?y77awcQ36M+aHf/ksmX2y9Jetdep5wzENpuIr1oGDH2gbHhkrtboGDiGsDJL?=
 =?us-ascii?Q?Z4R3He5pROIVJnqktvSEP6yD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cc8137-2a9b-4ce8-ce0d-08d9204730b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 13:07:18.2466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJHY8Cyed87iwnsYfwCAJNgorpxT/X+s/Tm8dhZL6BXNnSEUy5KONwckqzww50EMnjZ7M98h0rEPPqrlMBpo5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5568
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do the shadow bo validation in the VM code as
VM code knows/owns shadow BOs.

v2: Fix a typo.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 23 ++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++++
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 90136f9dedd6..f6a8f0c5a52f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -396,10 +396,10 @@ void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
 	spin_unlock(&adev->mm_stats.lock);
 }

-static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
-				 struct amdgpu_bo *bo)
+static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_cs_parser *p = param;
 	struct ttm_operation_ctx ctx = {
 		.interruptible = true,
 		.no_wait_gpu = false,
@@ -451,21 +451,6 @@ static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
 	return r;
 }

-static int amdgpu_cs_validate(void *param, struct amdgpu_bo *bo)
-{
-	struct amdgpu_cs_parser *p = param;
-	int r;
-
-	r = amdgpu_cs_bo_validate(p, bo);
-	if (r)
-		return r;
-
-	if (bo->shadow)
-		r = amdgpu_cs_bo_validate(p, bo->shadow);
-
-	return r;
-}
-
 static int amdgpu_cs_list_validate(struct amdgpu_cs_parser *p,
 			    struct list_head *validated)
 {
@@ -493,7 +478,7 @@ static int amdgpu_cs_list_validate(struct amdgpu_cs_parser *p,
 						     lobj->user_pages);
 		}

-		r = amdgpu_cs_validate(p, bo);
+		r = amdgpu_cs_bo_validate(p, bo);
 		if (r)
 			return r;

@@ -593,7 +578,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	p->bytes_moved_vis = 0;

 	r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
-				      amdgpu_cs_validate, p);
+				      amdgpu_cs_bo_validate, p);
 	if (r) {
 		DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
 		goto error_validate;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index da155c276c51..6bc7566cc193 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -696,6 +696,11 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = validate(param, bo);
 		if (r)
 			return r;
+		if (bo->shadow) {
+			r = validate(param, bo->shadow);
+			if (r)
+				return r;
+		}

 		if (bo->tbo.type != ttm_bo_type_kernel) {
 			amdgpu_vm_bo_moved(bo_base);
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
