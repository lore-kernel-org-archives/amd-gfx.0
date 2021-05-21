Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9743C43460
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C5C613AC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C5C613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3A26E4D7;
	Fri, 21 May 2021 12:46:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC106E4C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 12:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3RVrN9H4ubugJRBclybgPlFF/JKE30j+agDWi4ueVqg8Kv2VFx0DBdVHDZHLIQlfPQDXJARuyf9b1cH8Vz8mM++kV7GdzXhAwgR3cNCZPGecRecJC81lRBX5spLTexqVxTuwU5hdww/HVjW/yujAe2ZQUwFFwswGxz0kBjdR+LAXrFpmU/9zvYMKsbmE27brUyIu55N/uvip/PJ7t7gV3UuxaeDMpbgdRD7JV8vmPnz/23vP8lO4R7NCPYSRtZ7ZU0jZXDONQE6WnwxuzJs3qppWGu5pdG2hwPGFMDt+F34lG9HUodhABMU/w0JnJ8bkrLIb/xDFZnsvF4Gq5M+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pKYeEjR9P0XpIxt+pmTAKkAyOUP592emDD5vmqCqSw=;
 b=OQCWh/fIUD+3WkBBfxQchfEYamntp2WaG3gb1/Irn04CPhFvHyo9uZCqQt/pt1kvmmE64cyDyjAJHvAddFD3+ZWl31UQZo/76ckiKV1uTD/Xwj8OL/4yXK7kCd4rN3F0JaVsVDeH2ozEfER0mKfQ/AKdd3jlfX4o09Yc9Er6wNi2mGMh4UzcHmmlWXICSNQ8NaogGyhra+5m5T1zuZR01RwG6UQbSBjTKq0VDAUI/kg/lNX+f0PmOdhluonlaBVTIusE1bUy25763WTVTzc2V8KEnBQbax8svH5DxpCZTgY8F+brqB6xL2+ZEG4eYQ+QmMy43kcEnMR4g6XrANlTYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pKYeEjR9P0XpIxt+pmTAKkAyOUP592emDD5vmqCqSw=;
 b=XiIJzojWMVGMvtsUFXu3MY06dhwNaSh2WnIEAT7iIzsRPlYTqmmBSLfTEfdc8WnVHxM/kwHkiHj9ZM2hc/PTqf58OgJ3frEcSef3mNDp5adXDTJCGkZ5CdIJJZnsCSKYZ/vzoUZTfUN5uNclZw4vt2PySv+VwDouGKGYiK2DOfY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 12:45:58 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 12:45:57 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu: switch to amdgpu_bo_vm's shadow
Date: Fri, 21 May 2021 14:45:31 +0200
Message-Id: <20210521124533.4380-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521124533.4380-1-nirmoy.das@amd.com>
References: <20210521124533.4380-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.105.51]
X-ClientProxiedBy: PR3P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::12) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.105.51) by
 PR3P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 12:45:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e302aa-511c-49d3-7380-08d91c56617c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51331ADCA64849A63AA6FF168B299@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9MgP6+Riu4q98E3StPDSvSjC7RZJ0RdebVsYCG59keTZFfi6l4V6adMD8xkT6U/TTyEN0tc5guoHEDPt4GNY0yBOlCPwEtBZiU+EKKmsxUFJlJrT581SKd7pibUuMy3o939intKbusyXyrIEVlh49redrqV9AlVznRSeTbpC0+f/GZH2x5Zt8hDOP0E04MsLI5xYBBDehjKXFruL8BTzqjsxA8+gtqxuJKfiP42raKkpse2tHt0DN1Pbd67abxluUWqJxfQDtOgRfVM9r4iYxn0QtK3uUfoY5uMBjKGx1hwvT5UTqonQ0eDS2red0hcviw2cgwkEoPZz/0OdF5CExzK/g+WTbDehU+NU4n2kwDVwR3Adf+q1wDG7z8Rxp3hwV3d4wp0f8DYOu3haubzRZWSmRcXmwxTiByN3b7n90RDH/LsHE088cSAoOZyfA46pnk3GyqCTWkq5MTOxba7ytFl6/TSGPJlAB/Bwr8zEzBtFB78nsUvBVL/qCbT93lLQxq4ZhYiLYtSSniq7lrxu2Lwii/lRs+HqPxTrqwRMtUEHDHSeI4vqNt3gx5Ylz2Oqrqf0reLMmjXNwThgIe693xOc+enPf88zHi3XZpGrdtVuL6wxlxo8Su6rzxDkuBnJ/foIe98o2bWRi/Yyi0f7uKgQPSIDEPeduKOCF1nGj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6506007)(66946007)(66556008)(316002)(38100700002)(8936002)(26005)(6486002)(83380400001)(66476007)(2906002)(6512007)(52116002)(8676002)(86362001)(478600001)(38350700002)(36756003)(5660300002)(4326008)(6666004)(956004)(44832011)(1076003)(2616005)(186003)(16526019)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8AU8cbVRTSRe54uquA3qykUHBa2tu8nnKdvMXIbF8TGs97CR1S7SfPctYN7i?=
 =?us-ascii?Q?4gFJP3uMGOqnTy+a9FjmkiodLqOHEOEi7TgHOa+s6HNkI6JXdX1fKaUn25rC?=
 =?us-ascii?Q?Cgfgn9xVgRv3h/8KeNxHkYIHYC2wTB2gL4F+8S3PkqFPmTaL4c9hdNnAd/U2?=
 =?us-ascii?Q?m8itGxwm4y1r2cT+PhfOX3TEST0OFGRyscsQEb/gOyiLxezYQ8N+C2vtGGr8?=
 =?us-ascii?Q?H9TIWJwQOfpUid0B0M1L9Jk0R40ExlFXf99oUc7axhN6ktCcLE7f+nA7zJKs?=
 =?us-ascii?Q?sMImNNHNTBKcQpQHUp2+x/fPOpEDe5sPLwVzKQD4b1mPezX52VvO3PqEi0kv?=
 =?us-ascii?Q?PB9k9vu99kE//XiGUV4SCgrhR/x4+AOwGNG7J0BXwZm2EZMsIoza/zd/twQl?=
 =?us-ascii?Q?+4dGSTBtzOxZYvOlJtcih6CoIT6XrhI1q4s8/kkakjFwdmhpMV5qVkodfAmB?=
 =?us-ascii?Q?jgd1nbwux9g2B33pQKC9rnvnmGU0knWaIrIcLeuZpTgiJt+y8RP6SutnRgMf?=
 =?us-ascii?Q?F9rgoF67Yo1+NA7Na3YwKIzJv/z8p2jHzWyyQ1+9W/MrCf9fAY6TVm1TZRh4?=
 =?us-ascii?Q?OgmgAvu4Qtqp8VfnrhykgGpnAtEk5LNw9L1Sb4xrJqQeW/E/BSz33CPDGVfE?=
 =?us-ascii?Q?P3MBJNKIrLMkGpVegGd5SJZy20AR0HsR/Ehh9GQa1V37sVRi2BYoKbAujmDO?=
 =?us-ascii?Q?3SMp4CKZ8lCWlo75XAotHbqUI1f5nRwS/a5RAkfp6h79LViswYDpr4Sid+zD?=
 =?us-ascii?Q?DpJTxLtyb3UZlPQEZGkKUlVsY1ztW1DmDdTmh1oJws7kZRGUdJMwWGonWSGe?=
 =?us-ascii?Q?TnSMatlsI29Yr+Qr8mQSQADHElTUUGrJwq3oe4BpP76eiCHc1gqlFGJx/6ZI?=
 =?us-ascii?Q?EKq89CTGAc1+XO9UXm6YSyGfxVQjRxSgJK/hvx1m+Rt07R2ooEnWjeob7Pyk?=
 =?us-ascii?Q?1orxUan6IAp8b4PGAdndmBDljvV8fR7zwWM5eYbMmlFKgvoNuzPyI6ZCqOvM?=
 =?us-ascii?Q?vfpTbqORgRdYisQhBM/NlMRDvzJvJEzVszB2DPsuS04RniauJCNwrWdvtkNc?=
 =?us-ascii?Q?OxH/SUdcCAMyj5yeekG9mTu8EF42GTEqb7UPLJDj0h1B5NBO26V9X3Icub0y?=
 =?us-ascii?Q?09pfDjtnDUL6qBUqaC8VhvMbXWs+p02SsoOkXbN08n/STcyLjc1I5uz2lILF?=
 =?us-ascii?Q?Zg3UmO80D9shNH5ozyPPwSloM9SCUDTybDfc5RsHLpKEq0ul00efWKIkxODd?=
 =?us-ascii?Q?EVo7i0SNTlP6kj+tM+aau4PBG6QcwkEvGEqtA3aPZfUM4g8wWliTjDeQa9sQ?=
 =?us-ascii?Q?AX6+7wpnv6iYA/92QYJRg6ky?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e302aa-511c-49d3-7380-08d91c56617c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 12:45:57.9430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pua7r22vt+NCCVFCodb2wl1cda4F8/FaIFqd3NjQMdpUzu/cg9ANQXcngJXMF4nnvzNQ3h+jQ+I30AIJC9zvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5133
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

Use shadow of amdgpu_bo_vm instead of the base class.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 27 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 16 ++++++------
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 90136f9dedd6..46ccd43566e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -460,8 +460,8 @@ static int amdgpu_cs_validate(void *param, struct amdgpu_bo *bo)
 	if (r)
 		return r;
 
-	if (bo->shadow)
-		r = amdgpu_cs_bo_validate(p, bo->shadow);
+	if (bo->has_shadow)
+		r = amdgpu_cs_bo_validate(p, to_amdgpu_bo_vm(bo)->shadow);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index cead68181197..120e6b7a0286 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -658,9 +658,9 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 
 		ttm_bo_move_to_lru_tail(&bo->tbo, &bo->tbo.mem,
 					&vm->lru_bulk_move);
-		if (bo->shadow)
-			ttm_bo_move_to_lru_tail(&bo->shadow->tbo,
-						&bo->shadow->tbo.mem,
+		if (bo->has_shadow)
+			ttm_bo_move_to_lru_tail(&to_amdgpu_bo_vm(bo)->shadow->tbo,
+						&to_amdgpu_bo_vm(bo)->shadow->tbo.mem,
 						&vm->lru_bulk_move);
 	}
 	spin_unlock(&adev->mman.bdev.lru_lock);
@@ -788,8 +788,9 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
-	if (bo->shadow) {
-		r = ttm_bo_validate(&bo->shadow->tbo, &bo->shadow->placement,
+	if (bo->has_shadow) {
+		r = ttm_bo_validate(&to_amdgpu_bo_vm(bo)->shadow->tbo,
+				    &to_amdgpu_bo_vm(bo)->shadow->placement,
 				    &ctx);
 		if (r)
 			return r;
@@ -924,7 +925,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	mutex_lock(&adev->shadow_list_lock);
 	list_add_tail(&shadow_bo->shadow_list, &adev->shadow_list);
 	mutex_unlock(&adev->shadow_list_lock);
-	bo->shadow = shadow_bo;
+	(*vmbo)->shadow = shadow_bo;
 
 	return 0;
 }
@@ -985,7 +986,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	return 0;
 
 error_free_pt:
-	amdgpu_bo_unref(&pt_bo->shadow);
+	amdgpu_bo_unref(&pt->shadow);
 	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
@@ -1000,7 +1001,8 @@ static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 	if (entry->base.bo) {
 		entry->base.bo->vm_bo = NULL;
 		list_del(&entry->base.vm_status);
-		amdgpu_bo_unref(&entry->base.bo->shadow);
+		if (&entry->base.bo->has_shadow)
+			amdgpu_bo_unref(&to_amdgpu_bo_vm(entry->base.bo)->shadow);
 		amdgpu_bo_unref(&entry->base.bo);
 	}
 	kvfree(entry->entries);
@@ -2691,7 +2693,8 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	struct amdgpu_vm_bo_base *bo_base;
 
 	/* shadow bo doesn't have bo base, its validation needs its parent */
-	if (bo->parent && bo->parent->shadow == bo)
+	if (bo->parent && bo->parent->has_shadow &&
+	    to_amdgpu_bo_vm(bo->parent)->shadow == bo)
 		bo = bo->parent;
 
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
@@ -2953,8 +2956,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 	amdgpu_bo_unreserve(vm->root.base.bo);
 
 error_free_root:
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
-	amdgpu_bo_unref(&vm->root.base.bo);
+	amdgpu_bo_unref(&root->shadow);
+	amdgpu_bo_unref(&root_bo);
 	vm->root.base.bo = NULL;
 
 error_free_delayed:
@@ -3096,7 +3099,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	/* Free the shadow bo for compute VM */
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
+	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.base.bo)->shadow);
 
 	if (pasid)
 		vm->pasid = pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index a83a646759c5..f92260594c72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -41,8 +41,8 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo *table)
 	if (r)
 		return r;
 
-	if (table->shadow)
-		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
+	if (table->has_shadow)
+		r = amdgpu_ttm_alloc_gart(&to_amdgpu_bo_vm(table)->shadow->tbo);
 
 	return r;
 }
@@ -238,8 +238,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 
 		if (!p->pages_addr) {
 			/* set page commands needed */
-			if (bo->shadow)
-				amdgpu_vm_sdma_set_ptes(p, bo->shadow, pe, addr,
+			if (bo->has_shadow)
+				amdgpu_vm_sdma_set_ptes(p, to_amdgpu_bo_vm(bo)->shadow,
+							pe, addr,
 							count, incr, flags);
 			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
 						incr, flags);
@@ -248,7 +249,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 
 		/* copy commands needed */
 		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw *
-			(bo->shadow ? 2 : 1);
+			(bo->has_shadow ? 2 : 1);
 
 		/* for padding */
 		ndw -= 7;
@@ -263,8 +264,9 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 			pte[i] |= flags;
 		}
 
-		if (bo->shadow)
-			amdgpu_vm_sdma_copy_ptes(p, bo->shadow, pe, nptes);
+		if (bo->has_shadow)
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
