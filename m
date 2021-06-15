Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64592C48BE8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 09:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26FE06142E
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 09:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26FE06142E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E081F6E221;
	Tue, 15 Jun 2021 09:24:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2271189C1A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 09:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A14FI1qJJbLgrxV7/Be6cJuWMst3mJXwe1R5jgzbILpT+YPPGRQhsyZrgOCNuP2yNL1tFnmLXPi4545IikNSY9BGagItTd9p5vYuOPXOj4iqRW2nRwFbOCszMwnYbXlou4bBWmz8F0pieZ1hzGGHcAlRv0kCsrBAse/DaiXXR2ap7cNR5VK9UjR6pr6vO9b5CFaGHU3nm4U0jryumurbp9dgeDUe1Szn7l6ssteM/yP7B3bHae/eiyJAGzD5gy7NvWPsVrZ7EBdNS5QUPCvr9bxYV8Ipkx92+4znVRn1OLik2Ccw7eKCDLL05so9Vjb+xhHU7LaC0fTSDpWJoqhz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXlV8sPgJxZu7VKxPdh+uSQNo9rrliKw1bJFh3K/Ng4=;
 b=aAWp1+8PJdnYaKSZ/Mca/H90IeBPtFesA4VcUc01mcwt/y1EdQs4r+3ujOv970Ld4s+QjfQxlPs334U6UxvrX5zBllRM9svMICVmdadfbZXicQYBlIhvUMx3Jgz9bFkzyS9FTeFP9937lRbmtccDOc6el/4RbXTkjPxX6boeVpLQxPDWJ8CVcg0rN3l0OBlQAjWJXWhNZtkihkBcX8hi99KKzsR4mCVB7WeJQYVNA/z9Y/WJjI8mTrm8vUqFxmo7Jz6PUt/AAENDbSYK4glmwIkJFImhpJGWkB0WP4c76u+xO6fcQ+lcOviKL85Q4GtfCHY8y1Mxn4WKvHSO+qX0DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXlV8sPgJxZu7VKxPdh+uSQNo9rrliKw1bJFh3K/Ng4=;
 b=0S0T7pGG28PhjAMzC3WxOZf9pOHCNE43gp1BV2hTPntg9u0bWuoX5zj74vr76+9Ar4edEUrMh8BkcDC5uS3mH0Ci2b6xSeycrb4DAkZu3IbA11mLJtjSg2GFQwV2PKvQl4tlaVBEC6wSk4yJL+ImsYhBzWtvc6JJ2YIeddmvm/w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5290.namprd12.prod.outlook.com (2603:10b6:408:103::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.25; Tue, 15 Jun
 2021 09:24:16 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 09:24:16 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: parameterize ttm BO destroy callback
Date: Tue, 15 Jun 2021 11:23:59 +0200
Message-Id: <20210615092400.5023-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.119.180]
X-ClientProxiedBy: PR0P264CA0126.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::18) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.119.180) by
 PR0P264CA0126.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 09:24:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6535cc1-1589-445f-817d-08d92fdf586d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5290:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52901D47DE22261CA53A38278B309@BN9PR12MB5290.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFVh8KJyLrSnkFajB9g0TY48PlkoGxaaxN2SSCOxlWYHfPeRnwQuwHbZM/NubxYrsl4jlmBpC9JOCT2Zuvj/UcYuiirvVURP47QHvIXPMzlwjZ8oztwQ7Anzxlsd+ALRBu27w4nakHdKYgjbhRQjP06qP561VCkNgY88Vbsc0g/jJLv2Rbrrp7ChRiCIuYfDKXLQmbl3krhKUUHaw75kMLKkBo40NpX0FHlIjeovyfzmIS0YakEVFwy7QAHij+GuTpre4G2gIk4s5j9a8ESMdxDfNRA62wsQ8wFbrOclcbnU4Jmzm7AbX/w8s4nZH9s+D5o7udv2G15ZWO9BqBxeuTGCOO1M+EWP8zbx1M8c990CuevY2ojqPiQxhMILZRxBw8ha2MwYtyezUWgsKqVV77SShToqas3oMcGgIrmydLsRO67OI98xGVS9KCJ64yUPnPGpESY/I61iw3sWPOwiVwjfwL8zzO9MAxnE2FbUBhlM/hCqxSmq9FXZJKBz/NGd4mTGXZGeqeMXRUg6W7IkRjkPQXnN5N/hmZuyTTYbLb7vWq8nserY/qyWhKgDtcIV88Ya93jHRxt0kqKdLI4PndSqm5LKiVJuBA5p6jR38UihEEPg37IM6yyX0pfX0zzKR/TKcD5f4mZQDueA1S/MmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(8936002)(26005)(316002)(6916009)(6512007)(16526019)(6506007)(956004)(2616005)(8676002)(4326008)(52116002)(66476007)(44832011)(1076003)(86362001)(36756003)(2906002)(6486002)(5660300002)(38100700002)(38350700002)(66946007)(66556008)(478600001)(6666004)(83380400001)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6vnFZUVGnXUIZ4fkUKcXZzs4J5MGfQLE0dE3hleij6RQFoFe1JUWTAOTo/aT?=
 =?us-ascii?Q?egjjVvNeYWvtRvd0TcdVHzDl/F5s0BcO6G8fLDR2/PAuAaViJw9X8ZrvC8x8?=
 =?us-ascii?Q?1I1uJnNqdcsNtIEpFK4nzRJCqf/8D85bnPXqSbnNAebfl+jCNfu4Oo2u5xOD?=
 =?us-ascii?Q?zqpBiyfMGuwEA8jxHR47NlCpENS2yjaCoVRh5plnyh1bEezvHL0/ZMjbJQdI?=
 =?us-ascii?Q?8G7fOOUfAPiVrb2KC8WKIeXKS2U5xsJqPaP0PgJbDbfNs1+2ACMNqkMUoFth?=
 =?us-ascii?Q?psYLqiaSdMEJ2uLg6/aEz073HmaPENtFUhoYk1lL6RhLlA+zFjzrKi+YdmnO?=
 =?us-ascii?Q?a+GNPH7iW8czUyOLpLjJnm/6PSQJEq1D/MdJXUp7MtOP2b9tnJdAUXS5HMCb?=
 =?us-ascii?Q?kwvw5OnIIJvWO+dEQOXiFdI/BCMuXGlJP2FMclNoiHLw3CsRpzQv2FVzYwow?=
 =?us-ascii?Q?DhyTyuK4ysPWiiK1y3TaEWU0HPRs8wSYXkeGv2IX8r5TexzoVQNUXkkvUlAZ?=
 =?us-ascii?Q?xIZ72ypCM4s9DtaLPWfnTWv/k6wSEvJxCreafJKOd6pEiRL5gWrzUU5/cdm3?=
 =?us-ascii?Q?oA7D1wBx2iyp//3LQxnjUExw0RaSn6/ViWWwhTaX6APSdvoPc5zmvWgz+ncu?=
 =?us-ascii?Q?4u4XXfCuKtpefCq5wS/0dI/aY6zz873obrijbWa9l6NxL+cfs8Szs14PThUk?=
 =?us-ascii?Q?wrYRog+Mwd5GdVHfz4C5+CYj74H1uzv4hRnckeqerxucBtH1Q8fFQJddhjVH?=
 =?us-ascii?Q?gRFPQjGL/dn8citFRw2ANV5V3YuKarJD+efxVCK3+xzIh6ZhE9C0UsAR9MKN?=
 =?us-ascii?Q?XnkUKGa5epJ7JldOTN1tXaIPWMcjiEBPpXyrJ3Vez4FAnLKMlYEcmzdE9J2U?=
 =?us-ascii?Q?mnmB1DpjuNAoEQyjUDkzCpkVMaFn3KKtbXEEV8ReUMRAOo6AhiteVclyFGHX?=
 =?us-ascii?Q?PSyDc9UpRr9HgC7EDwoYHpJurJpQb0Qi/LPGbz1JNQyfSO785c359rXdvQ4R?=
 =?us-ascii?Q?HTaG5Qw3yev3PijIz4ELI7nbIcd+5Tdvqf2wxG+cQElkuXZv6gxtfqrrBSsH?=
 =?us-ascii?Q?5joWMj/ezXVPtCTnajTvjPBW+VMkbQ9B0GKSP6CeZs3f6Jc7xtareThixlMS?=
 =?us-ascii?Q?FKueppW/k9O9VRRhyWp8oBe7wMemqnC7TKi89wXZgX54ctWvE9T9Xq0WOe+H?=
 =?us-ascii?Q?4HRRQ+T0DTXxg7tPRL2QzrjZu47hpXjeZzLLYxBal+f/OkQIbt6y5LykitDK?=
 =?us-ascii?Q?V3mj3TzNOI2NAoj3fGzB8CtYAJBt5Tcu9+E/v9LElBJkCaZv52VMH82INMam?=
 =?us-ascii?Q?/HUy9xlmQz+anyOvrgUFoPT/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6535cc1-1589-445f-817d-08d92fdf586d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 09:24:16.0137 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpe0FbOHw8p0J+ozn9ECduwaEhy8C6uppKIgLiNWjZbotKuZ95fuc9ZN+4Xr4IXeGCxDisDIBSiInhhfaYX3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5290
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make provision to pass different ttm BO destroy callback
while creating a amdgpu_bo.

v2: remove whitespace.
    call amdgpu_bo_destroy_base() at the end for cleaner code.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 48 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 +-
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9092ac12a270..8473d153650f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -73,11 +73,9 @@ static void amdgpu_bo_subtract_pin_size(struct amdgpu_bo *bo)
 	}
 }

-static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
+static void amdgpu_bo_destroy_base(struct ttm_buffer_object *tbo)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
-	struct amdgpu_bo_user *ubo;

 	if (bo->tbo.pin_count > 0)
 		amdgpu_bo_subtract_pin_size(bo);
@@ -87,20 +85,38 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	if (bo->tbo.base.import_attach)
 		drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
 	drm_gem_object_release(&bo->tbo.base);
+	amdgpu_bo_unref(&bo->parent);
+	kvfree(bo);
+}
+
+static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
+{
+	amdgpu_bo_destroy_base(tbo);
+}
+
+static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_user *ubo;
+
+	ubo = to_amdgpu_bo_user(bo);
+	kfree(ubo->metadata);
+	amdgpu_bo_destroy_base(tbo);
+}
+
+static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+
 	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
 	if (!list_empty(&bo->shadow_list)) {
 		mutex_lock(&adev->shadow_list_lock);
 		list_del_init(&bo->shadow_list);
 		mutex_unlock(&adev->shadow_list_lock);
 	}
-	amdgpu_bo_unref(&bo->parent);
-
-	if (bo->tbo.type != ttm_bo_type_kernel) {
-		ubo = to_amdgpu_bo_user(bo);
-		kfree(ubo->metadata);
-	}

-	kvfree(bo);
+	amdgpu_bo_destroy_base(tbo);
 }

 /**
@@ -115,8 +131,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
  */
 bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
 {
-	if (bo->destroy == &amdgpu_bo_destroy)
+	if (bo->destroy == &amdgpu_bo_destroy ||
+	    bo->destroy == &amdgpu_bo_user_destroy ||
+	    bo->destroy == &amdgpu_bo_vm_destroy)
 		return true;
+
 	return false;
 }

@@ -592,9 +611,12 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	if (bp->type == ttm_bo_type_kernel)
 		bo->tbo.priority = 1;

+	if (!bp->destroy)
+		bp->destroy = &amdgpu_bo_destroy;
+
 	r = ttm_bo_init_reserved(&adev->mman.bdev, &bo->tbo, size, bp->type,
 				 &bo->placement, page_align, &ctx,  NULL,
-				 bp->resv, &amdgpu_bo_destroy);
+				 bp->resv, bp->destroy);
 	if (unlikely(r != 0))
 		return r;

@@ -658,6 +680,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	int r;

 	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
+	bp->destroy = &amdgpu_bo_user_destroy;
 	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
 		return r;
@@ -689,6 +712,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 	 * num of amdgpu_vm_pt entries.
 	 */
 	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
+	bp->destroy = &amdgpu_bo_vm_destroy;
 	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index e36b84516b4e..a8c702634e1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -55,7 +55,8 @@ struct amdgpu_bo_param {
 	u64				flags;
 	enum ttm_bo_type		type;
 	bool				no_wait_gpu;
-	struct dma_resv	*resv;
+	struct dma_resv			*resv;
+	void				(*destroy)(struct ttm_buffer_object *bo);
 };

 /* bo virtual addresses in a vm */
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
