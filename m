Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8067C47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959A06124C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959A06124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8706E84E;
	Wed, 26 May 2021 10:10:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D0AE6E4C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:10:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmKR29EwZNIHTH4io7As8MOcHbbKvGFZlkbtOyJsrFcs+RSKr1PUarAVsf+nwHhQhDAVkRiW6DeewCzHqSmJncBn08dAEV/bXwc4L/CB4WSNU5hlG4U4O1z6HRuBzs8FH0PGUiVXDkvs2lg1XVggobM1kMFWJmAJoPZRm3M0STBBYcDrT+dix+XW8FWPb1FVQGgAcLLMMkOtGrj33Vf/QQmThXwB0Mjij0sXYVUGMBgqgKTLBSTCW/xt5kkQFn873UTHz2paHieonpao+uHQNhrMGmwSqYZo8AxSY6f2ZTqu7kZ+1liA8vtsahrCrErxXjcgpnq0yyHf1uAGMZrj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMIiQttuq4d+b41pdmtgHLQX5pyU4TVV95ykm+wfEeM=;
 b=H3SeS643ywcAz/m86FnXpsNtAjCrb7JIWrH2V8bN6HC/aTn0jh+CSD0vc7T0bu9zfDHADIimQxFujZHbDuj1/r+CUW8ePo1bLdQZJYnLhqzZTByDIg1KJp6gYruI1/CHqPliwjgNQ7I7envh2lM/BeWtLbrl2YyDyKZAifPVD2qxt6X7Vn7zej+bLbI7Qrc2LdswbECoM8e4oolrtoKjS8stdtg/rmCZO2BXJCOGJuvUo4eOq8pFHRviWXVxqFkrnJiMhfeyjFlMf+9pV+AGytQivSVOy9hEfYKDcH2V6HSR2zBgxzDsHuQvn0H91KoRCp2xD/KBXMew9YLiCy2xgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMIiQttuq4d+b41pdmtgHLQX5pyU4TVV95ykm+wfEeM=;
 b=qjDNfrANiJwIgJ7KBWTQGUCfjzzVagfQPnGk19t1eLAGQOEcZ1qKmbcVbV/KECVuYIYVXyoaZFVxXsih/2tbR5hLe9z5dWuMgbiFr8SVdsTlhd2cKFf8Ega5cXGFq2dmbpGvhF2NCf/YMblDEw2Kx14qDs2X922DLEi8tytCrmk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 10:10:53 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 10:10:53 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu: switch to amdgpu_bo_vm for shadow pointer
Date: Wed, 26 May 2021 12:10:25 +0200
Message-Id: <20210526101027.14936-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101027.14936-1-nirmoy.das@amd.com>
References: <20210526101027.14936-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 10:10:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b1901ba-c13f-4098-afcf-08d9202e8bdb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52328E49CB21EFAFD84895E28B249@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOkpj+Gf8yYHscVWBaEMtHGreFkHwi5HTUCJ/uJfWk6OU/ettEPoAXuRQ/XlCexEUiHEWKdfZVXKjBX4CsROTaVLm1xNK3fRRUvgJ39k84aPIiDTejHiQo1ldCIrB9ytg0MQzo/vYcKNr2kXLbQvwKBaWUI58qq90fxMQj3KqD9y8fw7RG9U4OYjloEEaSzHYAkvXHnTeubuC7T+XyqthAZWbIO6IM+wUdfryerxVuOtboMyZlwpJIB3qM7+aMr2otTm7NxEPsYvJRM9R8gKb3NZEyWqtQtJj+YJ5PzyN8j6MDKV284H58bPba9WbSOBQFk4h5bWKXB35RINzacSgMSFsfpxWNbIKrZsLxmoNX2T8YahkE7qKwNBerhKVgPXl/600KYqzesY/fRWFG30d4metzQHcDxIh/NXqVLaeYiu3KJOS7n16sxxdhFzABGSbO7orO3bxcYgrRfxB10BMpveUrAIKlMykuzs33IbirOpXpEMVxZaCbiIECNoxqfX0dbUGDyx8KfroHcQvarbmranE6rMljif8N4kmrgczrAwvGDC0ME8YetGl8HrQnYwcfFiyDkQqhLV1LLrIjla/i/5Cah1gV2GjGtc90JMbB8DB6OLaufO4cqItrA7cds0C0eDBL9sq4S+OyAEIiL3NidFh7w/2cO2fpQv9dIHrfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(5660300002)(66946007)(66556008)(6486002)(66476007)(6666004)(86362001)(2906002)(1076003)(6512007)(83380400001)(16526019)(44832011)(36756003)(186003)(6916009)(26005)(956004)(2616005)(4326008)(478600001)(6506007)(8936002)(38350700002)(316002)(38100700002)(52116002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3nJAwfreLWoErhdGnfoqBWISYi7D/+Np/w+3bYkZcPIxF/RSekxT6S2tyCoK?=
 =?us-ascii?Q?107/nGPdSpjb5D1ODipQQ5HJzaxfPlGjXCwrrP5gAO/tgHq5EM0I9ryychRd?=
 =?us-ascii?Q?rhUQlLQ6sijcrIatNnwDMhwdTSpbl8Bu1kO24JiAWTCRLWjgh6mwXMfl+wPU?=
 =?us-ascii?Q?y+RcKhKhxRLcWUQuCkaF2RSnL6SK2xDi7GAXHsWKFk1BW7gcXjdcUJoWj3T8?=
 =?us-ascii?Q?J2R3UrxfMfbNRW9i47aZ3lekY5UyyLD7+eEfmMdNIznWohWxhvySApPYWsbB?=
 =?us-ascii?Q?9GQ8widN3G66V11LTJe6j++nRspu8MNBmrYydAFRzoZ4G4Oc5XbCbjBhuUx/?=
 =?us-ascii?Q?avYlXArdfri5viuRMcAXzxOS+KmM1MojGOn4DSR9OqFSI43BuYOn+EQ7PNij?=
 =?us-ascii?Q?R3uOXp4dDcgWIyGeKtvZ5j3ynJ2r4nlb9klWuQy1nQ3LAh1WTqDDwzPxrQRh?=
 =?us-ascii?Q?JtbmUDlBQm/1kh8zHFzt96uYAVFrm8PakYvvg4y6m599MiijHNvMV2kJc4Xs?=
 =?us-ascii?Q?qd8rHpVyLVOM+YB63r/2UNoD5EianIUmSp1EosXUSSXtoJaMs55YoS/5aXaS?=
 =?us-ascii?Q?x8Qn5hxNr2ZxPUKK2rFiQrbtMabmdLOVPIM1Q57LAner2h+Aqio6qhnx1k0m?=
 =?us-ascii?Q?oZa/hJA2DJVgrUMRikevk1JKzkOlvmvSCpUgK1r+cq/aUs8/MfQCS+Y0zoBF?=
 =?us-ascii?Q?bmjsdNkRsqVDEalCclKS1dTruGsNwxncZ3qO7g55zJfi2bGPjw+omcuHcwgC?=
 =?us-ascii?Q?60jhxq5hk+zyesyU5rGkjZo6EXbSAhxRUp1GQdPiGOoM+VvMZ4l9sCcxRcyk?=
 =?us-ascii?Q?kXuRkHDo2ANbvIAXMlfA9vmm55kcfai4kzr6DdezZEG8fq8kQzNgG9SFYflX?=
 =?us-ascii?Q?cq0dDLRDLgDN6KGEG9aBrV0SPeSiPoXoUNc2TtnF6G2bl9+/F1oS5hO56ItV?=
 =?us-ascii?Q?hV6Gv1PQ9GP1J6tWe1OUgPVXnvG1vBLU7uQnSvsPIIhXUIiIZKk+0cen04+m?=
 =?us-ascii?Q?PaIRvdsX8d8jjozWKZ7zQm/SLmNLfcN2jUPeI+nXVk66ArHPdCrAzg6681cZ?=
 =?us-ascii?Q?le2bDRFO4DmKsSsv/b82oo4oIbCdfl+ZjtiFGLu210Lt+LPEMspdWm0pVtRQ?=
 =?us-ascii?Q?YlnmRtZO7BiadkutMUF5axUoNXLlA+AKCxdYla/JsjAqZyTsaO7KWEfGb8AD?=
 =?us-ascii?Q?dqyttJRnxf6hAQ85iV+2nzpACxmIQMWU8aUR34alY6kmXCTWWyT97uUAJM4W?=
 =?us-ascii?Q?5Phg6ijS4Bven9YkCUFSdDB7jiwe/7BQS0dWNffv+7PnFJKNpLpco5H7ZPku?=
 =?us-ascii?Q?VUrx2ImaGh1dii5MWyFr5DZY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1901ba-c13f-4098-afcf-08d9202e8bdb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 10:10:53.7915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qpgho9ptgk5J/7YahQwbwwGTndj79hkXM4I4TheAZvGsS9e7J5Bw1Kc69bNEpT0etQX+NXipO2SJc5R5Snxi8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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

The subclass, amdgpu_bo_vm is intended for PT/PD BOs which are shadowed,
so switch to shadow pointer of amdgpu_bo_vm.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 27 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 16 ++++++------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 04cabcc3dc3d..ce17ffce9ade 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -658,9 +658,9 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 
 		ttm_bo_move_to_lru_tail(&bo->tbo, &bo->tbo.mem,
 					&vm->lru_bulk_move);
-		if (bo->shadow)
-			ttm_bo_move_to_lru_tail(&bo->shadow->tbo,
-						&bo->shadow->tbo.mem,
+		if (bo->tbo.type == ttm_bo_type_kernel)
+			ttm_bo_move_to_lru_tail(&to_amdgpu_bo_vm(bo)->shadow->tbo,
+						&to_amdgpu_bo_vm(bo)->shadow->tbo.mem,
 						&vm->lru_bulk_move);
 	}
 	spin_unlock(&adev->mman.bdev.lru_lock);
@@ -793,8 +793,9 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	if (bo->shadow) {
-		r = ttm_bo_validate(&bo->shadow->tbo, &bo->shadow->placement,
+	if (bo->tbo.type == ttm_bo_type_kernel) {
+		r = ttm_bo_validate(&to_amdgpu_bo_vm(bo)->shadow->tbo,
+				    &to_amdgpu_bo_vm(bo)->shadow->placement,
 				    &ctx);
 		if (r)
 			return r;
@@ -928,7 +929,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	mutex_lock(&adev->shadow_list_lock);
 	list_add_tail(&shadow_bo->shadow_list, &adev->shadow_list);
 	mutex_unlock(&adev->shadow_list_lock);
-	bo->shadow = shadow_bo;
+	(*vmbo)->shadow = shadow_bo;
 
 	return 0;
 }
@@ -989,7 +990,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	return 0;
 
 error_free_pt:
-	amdgpu_bo_unref(&pt_bo->shadow);
+	amdgpu_bo_unref(&pt->shadow);
 	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
@@ -1004,7 +1005,8 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 	if (entry->base.bo) {
 		entry->base.bo->vm_bo = NULL;
 		list_del(&entry->base.vm_status);
-		amdgpu_bo_unref(&entry->base.bo->shadow);
+		if (entry->base.bo->tbo.type == ttm_bo_type_kernel)
+			amdgpu_bo_unref(&to_amdgpu_bo_vm(entry->base.bo)->shadow);
 		amdgpu_bo_unref(&entry->base.bo);
 	}
 	kvfree(entry->entries);
@@ -2696,7 +2698,8 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	struct amdgpu_vm_bo_base *bo_base;
 
 	/* shadow bo doesn't have bo base, its validation needs its parent */
-	if (bo->parent && bo->parent->shadow == bo)
+	if (bo->parent && bo->tbo.type == ttm_bo_type_kernel &&
+	    to_amdgpu_bo_vm(bo->parent)->shadow == bo)
 		bo = bo->parent;
 
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
@@ -2958,8 +2961,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 	amdgpu_bo_unreserve(vm->root.base.bo);
 
 error_free_root:
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
-	amdgpu_bo_unref(&vm->root.base.bo);
+	amdgpu_bo_unref(&root->shadow);
+	amdgpu_bo_unref(&root_bo);
 	vm->root.base.bo = NULL;
 
 error_free_delayed:
@@ -3101,7 +3104,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	/* Free the shadow bo for compute VM */
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
+	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.base.bo)->shadow);
 
 	if (pasid)
 		vm->pasid = pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index a83a646759c5..3d9cff0c9dda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -41,8 +41,8 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo *table)
 	if (r)
 		return r;
 
-	if (table->shadow)
-		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
+	if (table->tbo.type == ttm_bo_type_kernel)
+		r = amdgpu_ttm_alloc_gart(&to_amdgpu_bo_vm(table)->shadow->tbo);
 
 	return r;
 }
@@ -238,8 +238,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 
 		if (!p->pages_addr) {
 			/* set page commands needed */
-			if (bo->shadow)
-				amdgpu_vm_sdma_set_ptes(p, bo->shadow, pe, addr,
+			if (bo->tbo.type == ttm_bo_type_kernel)
+				amdgpu_vm_sdma_set_ptes(p, to_amdgpu_bo_vm(bo)->shadow,
+							pe, addr,
 							count, incr, flags);
 			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
 						incr, flags);
@@ -248,7 +249,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 
 		/* copy commands needed */
 		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw *
-			(bo->shadow ? 2 : 1);
+			((bo->tbo.type == ttm_bo_type_kernel) ? 2 : 1);
 
 		/* for padding */
 		ndw -= 7;
@@ -263,8 +264,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 			pte[i] |= flags;
 		}
 
-		if (bo->shadow)
-			amdgpu_vm_sdma_copy_ptes(p, bo->shadow, pe, nptes);
+		if (bo->tbo.type == ttm_bo_type_kernel)
+			amdgpu_vm_sdma_copy_ptes(p, to_amdgpu_bo_vm(bo)->shadow,
+						 pe, nptes);
 		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);
 
 		pe += nptes * 8;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
