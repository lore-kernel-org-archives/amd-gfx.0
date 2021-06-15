Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDEEC48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2D36145D
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2D36145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8909E89CE2;
	Tue, 15 Jun 2021 11:51:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F1CC89CE2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 11:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0UCURwcs/N8qQvo7sJfGf6GrV/ALiJxhH9WvZusaJRVsNjgMNJ4dS4Fu3EBZCzRgCA9C7eL5BL9dM/VWTJtrlBiELrG0Fsrq5BAUuP2iiWQQEGaln+/Gj6rTKSETc37lPMzUo3hAC3v9tF51+98cbAO2LjI9gwPLUTrxmmASNiQ7jrgJY3ujCc72W67huvOxw95j1qHZa5nnmP64Hrca/VRyMhF8xBI/Bmb93BgIGCmkdT40jbiKqA5AvgeTOGxVzAlZeK5hK59nI+63vN60SVfsDgJ0qFlEOP6DIdkXitO0mOmtrz4OPKNkTdw4nHDKKB6noias6/tAPU9wLhoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnoo6EJoyJJiE8yA1G1zm1WN81OKpFnWqmjjVWgOhkA=;
 b=HulYKP544HWCyfZ7niMBALEtPr3w2NK83aGhMVxLoY/YzhrO+a1lE/LP5jg9jT9ph4Rju74sYbYpkWtkzYWted8t4lCzrf0xAysyyl4j0Q8IqsQjUhtKKjN7kkcWEyH0hZlLdg03sSz9LaG/WfCwAL2zRHkZ+tkvOcE4fRz7iw+0oTiTdBnDKZxQ0Ie5w8jQlE2FVY2I/o/jvZypSayqolW0bIIhxCYwcgud/lRMYqOK4sXCwxOWKfnhTFGHOC3Md41EC7SwunpfidaI3za20FatoeVFxNDtYcAklUX7wR7VDyHM8v+6dMvAXV/qBUXBnKbTXd1/+YUh72BeCSgDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnoo6EJoyJJiE8yA1G1zm1WN81OKpFnWqmjjVWgOhkA=;
 b=5Kp7anO5bm2vcp34SbSW3Eqsw0gm6d9aXdmbL9GW8X+7YXd0c+mBU/OpGcotpenc4zlbK1aRiGkWVA3vzpiNV2BUuaDHPaC13kreB8sXmtpwkAzlGfZ2m473/lQr4NMgdI4aAWjfD3ZKFPXYWcNb27UwlIBB7YIw+NhPUht6DAM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 11:51:24 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 11:51:24 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/2] drm/amdgpu: parameterize ttm BO destroy callback
Date: Tue, 15 Jun 2021 13:51:11 +0200
Message-Id: <20210615115112.50301-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:404:ca::32) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR22CA0070.namprd22.prod.outlook.com (2603:10b6:404:ca::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 11:51:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bd83c35-897a-4e69-dffd-08d92ff3e647
X-MS-TrafficTypeDiagnostic: DM4PR12MB5055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5055CE5D312A6C6FB91FB7FE8B309@DM4PR12MB5055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFBxnVplIEzXMASdzYHqwT1GhEh6vhF8URs93jDldbsLqcwLZ1j6cCC/mpvLjmcXrgTYD/coKF6djkiuK2TSkNzQKKFdBsel24/bYsi3s8LDBchMda2O5p35etwOWcbYfLiI47abVUiGwbndR7I/IukSQ3BqjO2PcYb/fRaYGcXrVcR1Ti6XwWc7bGw1WZ7Np+fkpRsVJfqFRAi6AO0zh/M70G7T5OnJJsTmDMIdIA0XR2U4d6YdZda//tLrs0wKB/sXfg6DgnkWLUeZurRScA3NiJNXZd7heUfeAyAAOih13sxMmKZ5Z/95MwgoD4IL/Oox4Zf4Gsedl9HGdOFuFFb/vg/yQUU28XHY2J3z/PnYGWEnVux34yMylCT+k3LMPUj7PaeE29Q4fZlEUB+Yp4tGgVAD/84OSz6YDhR8xmzW4QdxKCn4+cLNnmtgE1MzdZJiWyXUDMmRpgDtDnw0E7DggoTTu5q4afsP7vfFbto7Eni77w9xIh/J/3rbbTtUx06F6+F3QA//2Pv3sXWOzp22oUIZfK95mhnDoVpQ1fVciSJypJqx7UwSGFP1GcvI48QjlA1eLKbToXZwda5ncyIDacV+f28gWi2xFtTsidd2V8CvYuLlyKgQh6ZejkzUXTD7iWvAS7XtmKA2pxqgWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(6916009)(83380400001)(316002)(38100700002)(1076003)(66946007)(66476007)(16526019)(26005)(8676002)(38350700002)(66556008)(478600001)(8936002)(44832011)(2616005)(52116002)(7696005)(86362001)(956004)(4326008)(6666004)(2906002)(6486002)(186003)(5660300002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ihqdsev25R3DxxcDLVaZ+wi5bZhDJR+11egr5P4UJwlBAeH6HxsV+4kNWYEP?=
 =?us-ascii?Q?F92j3ETpdJ/cOgNRZkbA+BYvHRiNORCTiXpnAEzGnCxm+REk/eZDjexcTuBS?=
 =?us-ascii?Q?ZyeTPZPutwJSDAc6R5xdaq6tpXzPbOS+kA7hz/maoGUlo6143SnGGVhIKyln?=
 =?us-ascii?Q?lr1P9F0Gj3Kmk1YgFWr3lLw1GzujytzR3v17iHrEPbQhZ7WGcPN6IjSK7Mox?=
 =?us-ascii?Q?ygfZdSqeZdG48rnoQuk7+iZQA8ogPYVMB4dqjPoqYxnfHAcINO7hIRoosDx/?=
 =?us-ascii?Q?0a+hq7hyqD6ZJhpj8e9SF71sn9OSwWGFnNHVD6w0lFRbghE/HS/lXRKLMz6k?=
 =?us-ascii?Q?AKh5w2DSn1FCuGlDWijwfELfGf9ODPc6iCiXWStUqBPTPwwldUe76vNDrGdW?=
 =?us-ascii?Q?mKg3iDlR8ueiv1XqhPhwn15mGfMOl2i9PHIurIMocHeOxNpCcWUYq5Cijt+m?=
 =?us-ascii?Q?FvFPBmsmHnG14GrmbVqNaPrNxKMdfU4y412uB280QZyi/gfd9J8OJjfdoXpC?=
 =?us-ascii?Q?8WChuMLizppyCzWfgehoqSsMwo4ImMWC+iUCNsLfF376egG6LsNgRt5r6/Su?=
 =?us-ascii?Q?rEy08tp4mJLmcOXms1lV8Zlp759mgjJnaSh3WeS6/DDQHMNFIufyG1tOc2ak?=
 =?us-ascii?Q?6RBs0f0B+67xRpxe0IliMTka5bSq/UoAbXOEaMFiHp6dFlIC3xPIXfg7RJ+8?=
 =?us-ascii?Q?lFWZD/qGxhL4OdEp131nUDbb5GL8KZES94x262G/X1Iucyb1MjcgigZsU2hv?=
 =?us-ascii?Q?60WVUaNon743NfbeUZowkPFzGEbnjSc2SYUTldWwv6gyJ647aiYNx1SvEKBA?=
 =?us-ascii?Q?YYu+yFLa9WDOcPrqyLTRIQ7ZT7SHFWLWEajHoDAW+oO15Hi0MZzXbGfCfwZ4?=
 =?us-ascii?Q?qqRoQNqT8n63Esk8s761G2yEd+ZPZgS0OdF3SXb32RgxEz5LCDzlc8OT7s4w?=
 =?us-ascii?Q?4TyLiORM5YcuHwF6LooFHU+o6Ws3GvX7RJUyMoYgCAHZAYusNZ0KeTFJJhLP?=
 =?us-ascii?Q?xLuE4ErAI61+EphxsvL5k41PLrDqoh7hqchc9l+ER6Fhz45P3qI0PW7UYfnx?=
 =?us-ascii?Q?SmQJWL3DcZa5a7LCAqQqWr4rBLfRMtZTjILrj5qPeETeTcfit2v0GZatYyzS?=
 =?us-ascii?Q?S7zm2rWmqeYNC00Mf0fcNQ2tgbPP2eZvOL4D4LAoMzSSwYVamsYg5Oq5tY60?=
 =?us-ascii?Q?VV3iwkvnk3Z9KfSc3KNX6Pf/esJeaYBLO+guDVJEguuUgd+FXOAsZy1nRd34?=
 =?us-ascii?Q?sd6phRU/66AZR3omvaClofgVJ1JE30IgnpgkKKyWY8zOYA6EqSp52WnzSqh/?=
 =?us-ascii?Q?4TYEorpSoEtzoV8aHyHjv3O7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd83c35-897a-4e69-dffd-08d92ff3e647
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 11:51:23.9312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiW95qrP0NDPKi9C8Og5vhKXPXFSYtmheZQ4QkOqIOJGcwEGKEtv31cYVXZE92UR416GlYga4xT3tzeG2qaRsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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

v3: remove unnecessary amdgpu_bo_destroy_base.
v2: remove whitespace.
    call amdgpu_bo_destroy_base() at the end for cleaner code.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 41 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 +-
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9092ac12a270..ea54fd739c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -75,9 +75,7 @@ static void amdgpu_bo_subtract_pin_size(struct amdgpu_bo *bo)

 static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
-	struct amdgpu_bo_user *ubo;

 	if (bo->tbo.pin_count > 0)
 		amdgpu_bo_subtract_pin_size(bo);
@@ -87,20 +85,33 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	if (bo->tbo.base.import_attach)
 		drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
 	drm_gem_object_release(&bo->tbo.base);
+	amdgpu_bo_unref(&bo->parent);
+	kvfree(bo);
+}
+
+static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_user *ubo;
+
+	ubo = to_amdgpu_bo_user(bo);
+	kfree(ubo->metadata);
+	amdgpu_bo_destroy(tbo);
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
+	amdgpu_bo_destroy(tbo);
 }

 /**
@@ -115,8 +126,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
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

@@ -592,9 +606,12 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
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

@@ -658,6 +675,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	int r;

 	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
+	bp->destroy = &amdgpu_bo_user_destroy;
 	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
 		return r;
@@ -689,6 +707,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
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
