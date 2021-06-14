Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A88C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 14:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1396361246
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 14:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1396361246
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD6A889CD3;
	Mon, 14 Jun 2021 14:32:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B939489C9D
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 14:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMrt0rtoJOzMzsx7oDC+tW4a40T3iFcecthpFjDJnCKYCh5VCmb8qY9S9dK3TF/czsdK5MjuAIMr4Qt+InR+7HVaKRejKOKOY+9kR+XZ1NtkOBs4jAeeAoJjXopvMqPllWqlooMwn5rfrFqqfg2pRJyoKM67iDUUcN+QdaY/qH0xt6bk+MPonX5EyKi02N8ySqszVwPurPEBx2ImI7H+bUhbfwV5xaJrXjYxNWjhBLjP0wJvB7m55vFBT5+Dac3yrWsVH0BpiEeHQi8NnUzeDMfJqxV5WUChYhfAoAYRV5+rxdvvxmMPzM/2LUrH8Z2fT829Qv/1eO3ICn+A3nIRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOjv755uwMg18BIu6ZEtK6TmPorfZaqqPHaUZ1avXSs=;
 b=eS4pCfsV1zjjUvZFmMaYJr9tk7jFFcXap1VlHrAAVCfsVEEapfzHPVnpb1yosEz0s2FfSMbfbPCMvM1RL3ypiYkKJta8Gxz324lRs98fRM1cXtAlwKElqzxWDJEoXdGysCKSxqNI0Y9TdWCb5pJBylz5s+zhy0RiNwQHnfPRV17amXoR+2rxKB4pvsOadBjftWwj9E69TufKiixq9fn5gYW/Q4R2BfGxVghwIJ8pdpt+wAe9LebUTA9lfZfJt0UNw6I8mtiAZXDj6hGI4sZjpkCzlu5qsZhgIIgyXNlYNS/nzwowqNrOuvTm+QBd/6nPdUX3tWL0WwgnbPknn63cXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOjv755uwMg18BIu6ZEtK6TmPorfZaqqPHaUZ1avXSs=;
 b=xEylS8sbfnJ5giY38jHM1zI0uI0i5pQ4HGS8QDyBBfO6eq9j+Zetlnj72Bw5ZiVOik0jnZ+YugUxrsHp5lVp4B4F0CwqVuyM6C2FbEFa5OnYROsSXL5O31zpIlq7cThFvk5mo2JDBTaJBR3CwkC0iu6HHeM3uXIvtv5hWXs715A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Mon, 14 Jun
 2021 14:32:34 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 14:32:34 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: use separate ttm destroy callback
Date: Mon, 14 Jun 2021 16:32:16 +0200
Message-Id: <20210614143217.10285-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210614143217.10285-1-nirmoy.das@amd.com>
References: <20210614143217.10285-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.117.118]
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.117.118) by
 FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.9 via Frontend Transport; Mon, 14 Jun 2021 14:32:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e14464f-9cd1-41bd-db06-08d92f413fb0
X-MS-TrafficTypeDiagnostic: DM4PR12MB5328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5328A9850D987CB3057D93538B319@DM4PR12MB5328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRFW6FB0jDlpALH9OQiURuvGRozSDEBMdyBCAdNj42t4UEHRxMViXhZG4+7sJD6Jy4UvTWVIJ5K72u1V5bz963TL7CkjauyyGAkZKu1rr0AA6VWO7+qFPzhUmi3QScNdSWhLf1+D9qo+O0nRkoGQZZC/T4RwXGJp4QQPZK6g+E3xGsrOOFozOw/wggmOAqc6hiYAquEgo0y4n6dDwOA0wljr1AcroZ/T5x55pGeX0CsrxVA0UTeOCQxV/6BIXeQ/zF9FopS6yMZc86H9seu2s0fjFICqQN+7SexZAoXXYKoTd63urVyYHnw2Vz56w9MGPameCFXvFnlA0Uj47m+NNo1nAXI1JTnhdIniIfF7sFJflbMxgxM+GiyhtmCdLmysXtsNzUjNoA2OmPXae/4Ig/7yrtSRJNXfa54rHF5293byE3tC7mcqhi68FEmgCfcGPltxDBuzr50QmgsE7HTxkYadwsUGJQ79nfaQLZ0/x1n8U4nq0noA1WaClREJ4T4fWOAJpAgMjfML/tT42vSlhHvx5k3dxADXcJHfkLkGAX8nju4zKCiMrPRxszvsuNwD6cymMUkcnnXP/ft4F3qsuQStQMGQBw3b2nMZmaV58oxwhIfmz74mCaz3ctgL7tmIfKLieLeAgHkBH7r9GNMMhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(6512007)(44832011)(8676002)(83380400001)(38100700002)(1076003)(2906002)(6486002)(478600001)(956004)(6506007)(86362001)(316002)(36756003)(38350700002)(2616005)(8936002)(66946007)(6916009)(66476007)(5660300002)(26005)(186003)(16526019)(6666004)(4326008)(66556008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w4Wt7uOAChJxg1aCtx3A+BSmhz2u7X4OtyIbK8gpomvkqcbE6C63LZ5NDQy+?=
 =?us-ascii?Q?EYMCAtNFQp1jDDL+3KvDCsKALnBpvPLGlAuO+lQthAEcK/+b0VGPcLiRHEt+?=
 =?us-ascii?Q?zj+EKA86dhQOahxawwxmwl1XbCI/uJKudI+5D1WiQ0r14Xim/feWWwKKuquw?=
 =?us-ascii?Q?O/Wo58k29YM9fmw4CcGdiaNhQk+rWl+Vp6RE06UBgk6b5mxnJWiBCNZiqFj/?=
 =?us-ascii?Q?CQwJTsDcfVHIuYoWJfw4YCbOpPd25v7ePT1Ru48kqTgcXdXOgMz3PDZ+kqRN?=
 =?us-ascii?Q?sFERR/l1LSnE5afiSW/7UmnRp/+we7Bd2OURoC/xISHIyUhXHZpz/nb5wf78?=
 =?us-ascii?Q?SIoFBXuZgYFI8OabIwKo3vOviHkxgIhXaYIvwPGZb92lHV9SIczIuIUU82pv?=
 =?us-ascii?Q?FalA9GscH0RxoykEdifPEzLs8gXkZDwNCQTvVUlsJBdktqRX1gV4FkBijU44?=
 =?us-ascii?Q?VFX1RgtIg9fJtwXdIexZr+C/gnKw/yzxNWJlQA0z6rfQijMca2aAylvcQ0hm?=
 =?us-ascii?Q?d2Qtm82CVcHx+jjZQfDBEibstP36znmhs86Cvy9RNtTAZU/WsZjDO8etIw0F?=
 =?us-ascii?Q?cSver3SOFS0srJ7pQN9z6GXspqlDISyoyiwFTF7Ryx7QPHUtNGz38XNK7eci?=
 =?us-ascii?Q?PVb6iAKQrivCU3XMIDKUeku+hc+brnmWldCWWtNtGx7qr3LFaX9kZr+UVlCK?=
 =?us-ascii?Q?aE5xaVEPr3gzlTjZeZVA/9tld4DL9xyiCMcK+vCgZGfYeFM4HIPOqOA+316n?=
 =?us-ascii?Q?Fy239fWGoLONiaU7rWSA/XMhx75SEwqa1oWNBvzLx07iShoV5FZG89sfCA6J?=
 =?us-ascii?Q?W6K8R0i9YxXlycLuavza2hPxUhK+67UoJ8dMYbgTPvpqydk/C0ONrNFZob2f?=
 =?us-ascii?Q?+FUbBP5CojrCdXVAND8nwuRhh66ZlBcawtu3Y5A3HOazzYU4a3/xcR6fDeHt?=
 =?us-ascii?Q?bCSB1CUtEi3WJ4VHrSy9qqadUCvl8krU+nqTR2npduMS/ZxtvbBOttKRhzAl?=
 =?us-ascii?Q?f1H+1CH0OWN9s+v/cqBOEvsfwozJwzJcrLdWg0N1ocu6eIufg5syzkdkPXQJ?=
 =?us-ascii?Q?Jr7UrsP4FBPJMwlgjB1NULNWBqiV742QXZkCXnPcWQ1CdqjSHOBppvHdKzY7?=
 =?us-ascii?Q?PQCBhkPhxn6Rr2ZE0A7j8x6asedzLki9U6MGhLNGPIOrcNFHz17U+jxVR0XA?=
 =?us-ascii?Q?IeQTEyruUN8gHkfCJupjLYfwXqB25f6gkIFOBHbw3+XipWKohkvioV5NVZsk?=
 =?us-ascii?Q?4btiiM9hewcAwhXQqRqS7msyHZkMQWaFL2JeF1VFiEJmewVOqrGyncdM6/yQ?=
 =?us-ascii?Q?KMcF6vQOisX76MC+FnJawjf1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e14464f-9cd1-41bd-db06-08d92f413fb0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 14:32:33.9292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G9cHTpxjsh94XEsu4YgnFAGcOfJLBOq6a0zs/qplaPNzyeuM9ip+hCVZZS5wo+zGc6jdca/RA2k/BfG6bLCXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5328
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

Use different ttm destroy callback for different type of amdgpu BO.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 47 ++++++++++++++++------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 71a65525eac4..d97c20346a8c 100644
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
 
@@ -678,7 +701,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 	int r;
 
 	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
-	r = amdgpu_bo_create(adev, bp, &bo_ptr);
+	r = amdgpu_bo_do_create(adev, bp, &bo_ptr, &amdgpu_bo_user_destroy);
 	if (r)
 		return r;
 
@@ -709,7 +732,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 	 * num of amdgpu_vm_pt entries.
 	 */
 	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
-	r = amdgpu_bo_create(adev, bp, &bo_ptr);
+	r = amdgpu_bo_do_create(adev, bp, &bo_ptr, &amdgpu_bo_vm_destroy);
 	if (r)
 		return r;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
