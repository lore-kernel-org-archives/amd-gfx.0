Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A2C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645F86145F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 11:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645F86145F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2245389D44;
	Tue, 15 Jun 2021 11:51:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4E1589CE2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 11:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTEJ5sPd5v0qrUQBsASc5JP8ghhlTFIosbQkqWLlBpNK2KrrEH8I6RXPGxNFqeHwfTN1pgm0ImlKcyYUzbFtphYJHxZ/REyFLigNvEKpJ4/pS/9OOvIqVoJy2AooKqCGld2kXrFEVBgHNs9S1d2wxuBCb/15v6qYmJ87TRkK0xfOcCveIJ6kOjFE9WdGJzZcd1NxV7BRwobgOAzOCRs2+qrHJpUoT370/dzPLIfCvvuhGJqr1jNKKUVBudfN3izE6HHLGvSUEtSHMSIi+zAQ+CwGHsOYltX7ij0asAUfd0ZGB/UVxeyJTFxUfAKJGgXS9YTrQov4S8TSe5FFmV9fQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxXdGh6R24+MQXqWVRxfg62AZzJnRoj9nkC/OLCLpXQ=;
 b=WsROjzY+tLDG0YOeAZBYhBpf8CWPpkyY2PvEuNI4XAL9naKGpMvm0frt35zKwh9ZtFaIdSgZIqIhDy286GxDKuDaLBlPfO4KSOjtlsM+XFNiyCvGRqhuWrEIFzBkPpdAJXpneQAbrq2Jsx+nPOj7QPJUCycejjV6JCtc51yvYGy498tTzkn/bdLDoNUSyyAHsvghLae49ZKB5CoGaF95xkG0bu3W1/AoB4U59ZrmbvLJFEUOi2RQv1gHKNIm6kbpiJaZeib9x3HVZhGg3kEV3M+WXI0wkUbB3TNsHXQh/umfxWY15B6QhUX+8bjOOxBACwjMT6gEcPqvj2+kNapOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxXdGh6R24+MQXqWVRxfg62AZzJnRoj9nkC/OLCLpXQ=;
 b=2QJuEjerUDIgjiWf4FqSJwMocu5fpdthP4yTt0GMNTk5e1rkEjExvqUNh8dfgkrYzhaAFnBuO9+7EN8etj0OTOQeK64XSCc+OAqlENOqP7dDPyNUacHjPSTla8emKUc0haSJXiJjE70axAEHVnDd7mDN3cRRwUj2aOiShu8t3gA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 11:51:25 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 11:51:25 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: move shadow_list to amdgpu_bo_vm
Date: Tue, 15 Jun 2021 13:51:12 +0200
Message-Id: <20210615115112.50301-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615115112.50301-1-nirmoy.das@amd.com>
References: <20210615115112.50301-1-nirmoy.das@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:404:ca::32) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR22CA0070.namprd22.prod.outlook.com (2603:10b6:404:ca::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 11:51:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f5cac42-eb19-44be-38c1-08d92ff3e725
X-MS-TrafficTypeDiagnostic: DM4PR12MB5055:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB50550267813ED6ED83DEFDCF8B309@DM4PR12MB5055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4BcVdS0dP6U4UNnihZbGR/v+AKttBkKoaux1s0RYx6KqeFPjopvznda+UZPXlAI1Qnyl7IGtKXn3vscaWUcWgZAxBwnATmsJlPXAbGC7bzEfP/UURvG8PkakrCalaJf9OyVv0QMby9/2JcbhUQfXCOiW9wemIcMwhtOJoo4yxZlsyMMH19QHGiBF1K3sne9obrkVUBBrFXSAqLM6+9N5PqPiWZiCOiIz5K5KYIHnR0X+HYZjuWbLj7CkNsC3mJnsYHc7AHkIupardl1nCkYFp9TDng3n4TlrEYKu7EzeO9/oMyU6SLzhbz61QRLpF4gNOuTbj3r3ZK/dhdqLjQXX2ErVM+aoYPSPi4ttrJp1F86DZyrL+d112+Dr4a8WZlT+9lk9SOMB94gYZ1OQxOoEtYjB2E077HXDkw0P0x7bw+JkuL5WjrLkWUmNKL5jsaz0dN8UP40pX1pZxF4DODkE0bJgGTlpXtQm39OXr4t2mh9d50aqMJVn6u11h0BA8UuRR3Yy7MlCbZV1wNIAGsgtrpgWev49TjSynKy5VtCHF4rmNtOCWzEhUeqiEtmLCo90kZs0liQdfeBZEl19RffIQW+iGT15xNmHfRITPUUH6VRlbxqDyzOnVIzAGsxsjECRUHovNsxSqGYLMbdCeU7O+Ty6LPuT2R+0Ioa8xVSLqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(6916009)(83380400001)(316002)(38100700002)(1076003)(66946007)(66476007)(16526019)(26005)(8676002)(38350700002)(66556008)(478600001)(8936002)(44832011)(2616005)(52116002)(7696005)(86362001)(956004)(4326008)(6666004)(2906002)(6486002)(186003)(5660300002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8VUxPqYnfBUV7TRtudkkiPO1wU/1xgKdwl5sonLQgPzpqieBx9DuDUzMv184?=
 =?us-ascii?Q?zHwEIgvn/nEN8ku7bBp3PDU0oxBu6ORtKGCuOBbkayCGMH9FrBb2D1YYjtiV?=
 =?us-ascii?Q?sMAUKmGMlcIJGEdsGhCz+tMa/5sVBOzHT6t+RKWkDzvPmPRmWlmti1geVxUL?=
 =?us-ascii?Q?s4FpiDQ7x+mnRnJxLUAD0SMCIoulLzcb8yjRdemzNg4apiWdov5pAPi02Bhf?=
 =?us-ascii?Q?q1EGQNCV2kHIG+qiwIYSp6RK9VQCxDZj4VVoISdEm2H2SkATjZuBSPJQQZz5?=
 =?us-ascii?Q?PHytIFMRhWm9PrB7QL9YIRHpJz7rpqOrPEQoGFWjfazJ9yoFR1gEUu34l+9q?=
 =?us-ascii?Q?PSk+bCXioAYgFqSH22WpPFxRid2mqjW9bkPsWeixxpXbaui7pscw0RZ5vYUb?=
 =?us-ascii?Q?7ywWmr90CXdWudGYacfEFKYeeG0EMKK1v1OfOG8QvWp8XmNsa+HQYtHT4rQb?=
 =?us-ascii?Q?nWPxUYwtbdf0Oy3jh/Du1tAuqdNbByuxSDsuY7jr0Oglz5HaLjf4o5QXBnQR?=
 =?us-ascii?Q?Q5Q3w/W2xxRAN12MxGAxPw6mVEcJsfGGxb84PuGqXDrWt1bMxZYbGu9PUSLm?=
 =?us-ascii?Q?wSlwyrnQrmy2NDuuzOcJ8Ye0FROlyPJEk7Mhf2VrIJhZwWGc6Z3FFJAE6vXM?=
 =?us-ascii?Q?F+JiFi5Cg8aORYsgX6GYhzgiuS2WsLlXf64oc9rsos/YR9dKuU1f+qJyoMqk?=
 =?us-ascii?Q?BhXzQIdcmVm0HOrupcHpDHFzCeyJcA0M/hNvojlDgu5pLlxnt49YqaekTm+K?=
 =?us-ascii?Q?wUPZV5GQQmVQDDUBw/LgYwLmW5LB3S6dzrjE2oQoJxnjBXq39SXpZ5+eBSgq?=
 =?us-ascii?Q?zRGBd5ytQkZsGsAD7iZf57XO6CWOgSyo0GtKIbWvIEL+bdZzno/Vpoav0P0+?=
 =?us-ascii?Q?mK6yc2D//fUoZ7xF+Vx0QRqCC2vB9mhRylrHvVlVtSVYpTV0zzWSIrMRHEyj?=
 =?us-ascii?Q?i9i3/FRzdthsQw/jEQ/2h4kz13MMt5e+FtEAfnev8fww9Q067vgXbNKL3l7r?=
 =?us-ascii?Q?p1xQ8CwBPlTRCLL0pUCIUvnA6dIB9LK5rf3qvHhQrE/7+e2if3deiXxoAlqX?=
 =?us-ascii?Q?iDBiNpB0XpQzIxOiWntom5BSci9LYZiqqffG27msRSjO8U56N6VPR3uYz2mO?=
 =?us-ascii?Q?mF6zLLOYe5u3n2E6++9yhyCsMam5XmqXI860lncdJyUmzLRPQSTaxkXp8dhM?=
 =?us-ascii?Q?X0uLUwxsFOzqOjhxCPyvZe+ZGgRgEZTjuptQ7JJPFw8NGYh+m+9qAtQMx+2y?=
 =?us-ascii?Q?xFsGsuZVayV47q/NQmX8Vz1ibb4CByWzDEM03SiCFs99EWeNmfb/4DlHN/f8?=
 =?us-ascii?Q?5fMj1Y7ybYRa6+ODcwmcOODX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5cac42-eb19-44be-38c1-08d92ff3e725
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 11:51:25.3838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wt08MFrEk8KMOfPLj7GWEKO1ntZLc41xVGPNc131XEPwVHk46s4rh4crFYyiC7RcIwDCY7PQQyAvTxdeenaPvg==
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

Move shadow_list to struct amdgpu_bo_vm as shadow BOs
are part of PT/PD BOs.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index f2636f411a25..3f51b142fc83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4063,6 +4063,7 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 {
 	struct dma_fence *fence = NULL, *next = NULL;
 	struct amdgpu_bo *shadow;
+	struct amdgpu_bo_vm *vmbo;
 	long r = 1, tmo;
 
 	if (amdgpu_sriov_runtime(adev))
@@ -4072,8 +4073,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 
 	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
-	list_for_each_entry(shadow, &adev->shadow_list, shadow_list) {
-
+	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
+		shadow = &vmbo->bo;
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.mem.mem_type != TTM_PL_TT ||
 		    shadow->tbo.mem.start == AMDGPU_BO_INVALID_OFFSET ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ea54fd739c41..ea339eaac399 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -103,11 +103,13 @@ static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_vm *vmbo;
 
+	vmbo = to_amdgpu_bo_vm(bo);
 	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
-	if (!list_empty(&bo->shadow_list)) {
+	if (!list_empty(&vmbo->shadow_list)) {
 		mutex_lock(&adev->shadow_list_lock);
-		list_del_init(&bo->shadow_list);
+		list_del_init(&vmbo->shadow_list);
 		mutex_unlock(&adev->shadow_list_lock);
 	}
 
@@ -583,7 +585,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
-	INIT_LIST_HEAD(&bo->shadow_list);
 	bo->vm_bo = NULL;
 	bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
 		bp->domain;
@@ -713,6 +714,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 		return r;
 
 	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
+	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
 	return r;
 }
 
@@ -757,12 +759,12 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
  *
  * Insert a BO to the shadow list.
  */
-void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo *bo)
+void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo)
 {
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_device *adev = amdgpu_ttm_adev(vmbo->bo.tbo.bdev);
 
 	mutex_lock(&adev->shadow_list_lock);
-	list_add_tail(&bo->shadow_list, &adev->shadow_list);
+	list_add_tail(&vmbo->shadow_list, &adev->shadow_list);
 	mutex_unlock(&adev->shadow_list_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index a8c702634e1b..18cb2f28e4de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -109,9 +109,6 @@ struct amdgpu_bo {
 #ifdef CONFIG_MMU_NOTIFIER
 	struct mmu_interval_notifier	notifier;
 #endif
-
-	struct list_head		shadow_list;
-
 	struct kgd_mem                  *kfd_bo;
 };
 
@@ -127,6 +124,7 @@ struct amdgpu_bo_user {
 struct amdgpu_bo_vm {
 	struct amdgpu_bo		bo;
 	struct amdgpu_bo		*shadow;
+	struct list_head		shadow_list;
 	struct amdgpu_vm_bo_base        entries[];
 };
 
@@ -333,7 +331,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 int amdgpu_bo_validate(struct amdgpu_bo *bo);
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
 				uint64_t *gtt_mem, uint64_t *cpu_mem);
-void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo *bo);
+void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
 int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 			     struct dma_fence **fence);
 uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4c4c56581780..812c225538a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -936,7 +936,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	}
 
 	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
-	amdgpu_bo_add_to_shadow_list((*vmbo)->shadow);
+	amdgpu_bo_add_to_shadow_list((*vmbo));
 
 	return 0;
 }
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
