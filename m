Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC205C48BE6
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 19:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCE161042
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 19:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCE161042
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A976E07F;
	Mon, 14 Jun 2021 19:27:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A76B76E07F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 19:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ4VWGu8jPZJFRGwa6l4SEHv+q5RDOq/r9BBrCmV98Buvl+02Jm9HlEu7T29mC1Dy//iivYfvrRp3ptjprkm+EYAqxyxNEgXdF1eobSqR1wVVunGOmwjDho6/MEWoTBBZUmAXciS1Da2DitKxOBM1yTltuYajEIbVKcQCjK/gNRw01/Dpx5JU3t8khneu1vqGE0b1PDY1G0TxTkOuYuDQ1OH/t64NmTrpAV7k2C5hI+6xo8msWE8rv6E2aZhlt3stcErCU1RnbxIdgdM1dSyj9uXqSo2bJndUof0Y/EB7kSExGgbQhgqsXexSY8QiFmMdC9EvIENPDH5Z94lMtkinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMN+Dd2NTxOABzAIGUfWVmgltlTgXvOMl5QKcvU32FM=;
 b=d28C82pedfhnPgdKGOFD5EOT/wrnaH1FVVKdZ9IN6hzLQ2S+mZimGm2s2FwHJJOIn7l1nDOFxdzcvb/3C9M46QJkE8DL0+z2CZtqEvbHFSG8k+nLib6U4KpxykUM35J33bI5Ip/QmnavANH4PL3h08BLpyCpTLZ55j0mArFP5Xyyp/fjHWaf11wZbRtourEcgkO1ZNMhFcPkB0cTrNZCT08qjkKvFOFfA6l3c3m/BeIb8KBWamSz4IQnCSkE9sVuI5u1XxeK6b7BzKUr7NZ0jErU719CHvFnUv2kyRGsawNJAFQCRRwgvBxhBdtC5zRqSDqQu1yZtfLCxg7yQxsQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMN+Dd2NTxOABzAIGUfWVmgltlTgXvOMl5QKcvU32FM=;
 b=Cp6EjfZYvVLwd15fOmJwfZAVSkO3fabaN6Yy4ODk25r4ktsL8v2o+cWQNMWdF8MpXmj37ZDOpjkWq6eip6Oa3LDHakhWJjnFpTfigh62T09/0U1mmsqxdA+MZFgl1G5Yui2I7n/v673T6VRqymjn2DFkMEWCC9iD3L3nD5ig1Yk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 19:27:12 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 19:27:12 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu: parameterize ttm BO destroy callback
Date: Mon, 14 Jun 2021 21:26:52 +0200
Message-Id: <20210614192653.18239-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.117.118]
X-ClientProxiedBy: PR0P264CA0072.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::36) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.117.118) by
 PR0P264CA0072.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 19:27:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aafa0e7-a61a-46d8-6f0e-08d92f6a689f
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB521366160E057F42B1D536068B319@DM4PR12MB5213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3lGiKydXFU5dITg2/uDQsC++8EcsX9qQzaOn6asXHtpo7oGihxtGnSCm6tXjd0Whe7H7rK7qhg2kFBDeXvtSBSOWCfATnXF32ax/0DdGgn4f5rAfKtDBHkO2pyGkv0ZHhNsSglf/iyDWPt6241jFZcQs9nKYJNAkDO1Be7cwZRW0Wg2TuOT5v4GjwYesGaGTEYjn9b6/++lfn+xghtaWoyphFnLY5/QiCygtr9pH8mA3T7SEoOcge9nZ/zLwYChiyhjbl2rhlmP9/pCKRfkNbLam01odJrR3rYfFVvIkwPVHLQXFg16UVioivuIkvXzQtgSuGA2ksZngEuETqcGZoyhFt9yL+ZC1CvTupoYebyU/VvFpI/zTHUeZ14uzum29JKx9+/y+jAl5EraVRmio/s03KdPZvp1b7SY4GRtP9IIy5pvRzfpKe94VugwIGePLHeugsHJmGEemirIlglkqB02qFjDCNohmjzJ65azMekYmztxvpxxbT3VjyPjPc9qsyn/7wvfST6chVBRWQETszr0DZRszOGc3Hqo1HJtxQT54R/1bhUQrDc5JckO7CuPad8wkNFGgulgcJwB8kQcyEBlzEjXPR7OpsS2Y4XO4J3aStyDCZ/hBg8HI96kvoYkgKE78nsA76DJS0MyDXl4lXw2bOnx1V2xPwolMcUCsOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(2906002)(38350700002)(38100700002)(4326008)(478600001)(6666004)(1076003)(83380400001)(316002)(8676002)(6486002)(52116002)(956004)(26005)(2616005)(16526019)(5660300002)(186003)(6512007)(6506007)(36756003)(86362001)(66476007)(6916009)(8936002)(44832011)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Jta2o9Y1x67tQ7j5wHsrDqTF6i0Q4Kbzma+MYBcit52G2/a/vC2wV+Xq+oq?=
 =?us-ascii?Q?n4l0iaGoPRkEYcRVAs1cmfbuEvWl0OQJdpzyrJ8ttstD4kjF1RR1ZlWGz2xw?=
 =?us-ascii?Q?ZbUa2ip0a39LCzHJPNrMpXxRODn5HFMXiJrMgceQIjfFMThRA0kkUsVaQUa1?=
 =?us-ascii?Q?ilCc1OPbmUqrgD0oLbvW5GGp/ieC1nv0lEUJC5hh7JSHC5SpE6gTEWBpGgdk?=
 =?us-ascii?Q?Ei3Ob4GWI7dSXOto5rIuWf6P5G1nst1UZSi0scHps84JbkHj4ZIV01jvCqHU?=
 =?us-ascii?Q?YleWqb+Uoh1C59RjA3BPX9i9JCWFiU654J2ujfq77eDw1hhaTm7mNGlB3xMt?=
 =?us-ascii?Q?Gv2ABdJvOsopMn62/HwNCu11tWDEsqzUgE0/p70nARKxtdgW9QpkhplFuJTO?=
 =?us-ascii?Q?YBkuyiaMfmf/JdWAV2Vbj/RUwMkgYdd2IFuUnKK+di4muh4kuaUi6nvMazNE?=
 =?us-ascii?Q?31qMD/Uxd8xJ74GOuP9P6PsqEaPKVgJRX7UqPhwyEfposkUP1XOezR3Xru3b?=
 =?us-ascii?Q?Q7hWhlrVLIAqVsdbl6MFQUKYvTHVJn9c0UvWXTYOr8xGIwZB+BSggVc6R7pl?=
 =?us-ascii?Q?f1+w7lAhZ4/AJykxdzy9XB1W1fxIlItCcrzlFXEoh69jzJb8dT0u3So9ABAe?=
 =?us-ascii?Q?5ZBeLJLxdjauhrJR0qvsrlH6z+zPp5Gx2eNXoJ/C8E/GLG4/01pu6t1Kc3Gk?=
 =?us-ascii?Q?gIya93MnIu+XwDsbcN24JULqkWpP6glrmdEyvAUbNN+X+6hKvJWz0rpsv+xq?=
 =?us-ascii?Q?+kFV/Xou4b90ziq3+Yv44pEcA8n0/A2aiyOfr+cteS1PslTAVW/6B4nLEdFm?=
 =?us-ascii?Q?aWb3lfje31xqqqPTRruFs8bQJ4PqY/UFiJX40WjYYZgNP2//fLYxtOnERKxG?=
 =?us-ascii?Q?XPlJdBi6Koor5yaNzfiEf2CHM2YbgTngMA94mFUmkSE4yZxPc+TH8NDK7tzG?=
 =?us-ascii?Q?APt4OKqQevhHpG+jD1EvI51jSG38Q+FfKx01I/7ul0OoSaC7MpigysIPmMCm?=
 =?us-ascii?Q?j2PYNmlSulPoKjV2BzQgDTRSXRg2GGVGr5tVFSyTL5XbYrL2wS+qVABlgGAk?=
 =?us-ascii?Q?BiGH/Qml0ipfbHD6r85SnH2OaB26xZPwd7CW6g0lAQhmUqM83V54pEpqkAJV?=
 =?us-ascii?Q?nZ4hOlurXTDilZjSos+gqglhR5WXhVoM8oD54K6zGo5d649sTbqBvspsqdS9?=
 =?us-ascii?Q?Qn/M6VC8jSuk3BbzzwETxX8Tt+1zeuVTuet8vd5HR5cRvOwvwnKQGgNkICCq?=
 =?us-ascii?Q?xdWcDBxe0xfwj09ZtvGakIUtnVVYOXKDgAulZA5jYzTKJPBorcBt/24MSVZX?=
 =?us-ascii?Q?HUctpTfRM4Cvjty5l9aK5df8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aafa0e7-a61a-46d8-6f0e-08d92f6a689f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 19:27:11.9198 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtPHvryRhaApCu1oidwFxzolHVGWSSeHrmp2burBgYWmGvrq/gRLsJ57XV7g0P/Eu9EckEfvba9pDfXeLo4UuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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

v2: pass destroy callback using amdgpu_bo_param.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 52 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 +-
 2 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9092ac12a270..f4f57a73d095 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -12,7 +12,7 @@
  *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * FITNEsS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
  * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
  * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
  * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
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
@@ -87,18 +85,40 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	if (bo->tbo.base.import_attach)
 		drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
 	drm_gem_object_release(&bo->tbo.base);
+	amdgpu_bo_unref(&bo->parent);
+}
+
+static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+
+	amdgpu_bo_destroy_base(tbo);
+	kvfree(bo);
+}
+
+static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_user *ubo;
+
+	amdgpu_bo_destroy_base(tbo);
+	ubo = to_amdgpu_bo_user(bo);
+	kfree(ubo->metadata);
+	kvfree(bo);
+}
+
+static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+
+	amdgpu_bo_destroy_base(tbo);
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

 	kvfree(bo);
 }
@@ -115,8 +135,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
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

@@ -592,9 +615,12 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
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

@@ -658,6 +684,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	int r;

 	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
+	bp->destroy = &amdgpu_bo_user_destroy;
 	r = amdgpu_bo_create(adev, bp, &bo_ptr);
 	if (r)
 		return r;
@@ -689,6 +716,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
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
