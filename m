Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E23EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 19:27:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D92BF61001
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 19:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92BF61001
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902596E043;
	Mon, 14 Jun 2021 19:27:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED146E043
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 19:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9aPKm4MWXcu4jw3xEZTrDoSpXv7v15isEf/Mc26Pj3Vjs/v+3ioVFIMiJGlkJRowHNFS1T4LFA2jOUTPV+utneF7z7OxXRZM/9uY3O/z9bZSpBLEOxTqKMmwqmKOmndi2+JmkCSY/gPrl0gbAbKM6Kzg9z0s+nxpuSYknLAsoyLcyHVx10ehmBeigQZA/Wp4Zw1+boD7W/9ny2FBiTAtqUBYW7DdQeFeeru7pnUars/G7umSaB0mFiZ/h4jw+MBpP0WnfSn0fvj0HnkLhrTrTbUyslyL8WBqUfrEYM+3D2ZJmpKhWGIIznGhAzZ4varox7Qs8G6CzWj3tletWD/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0TWQHUpP6I+6jVdWGGFXsKQX56GLp3J8pLB7DZfUFE=;
 b=Cw0Ri+CVZLN2NcBrEYGIwNQT2MnIJE3SCTpoejALrf+fpjcwphIz1HW+G1LCdCrTCsmWQbx8hAUOzek2alrfI041JHP/HppWoyXqEfMIhsjk6vTae7VQqrk54K5o4xuoBXJs2LZ4GIUy9+ZrEcKhtD00bbBHWqROa0Ku3txdHiFF2LUo1Hy57IiCfS1mXJ8Sg7kQKdZ+uLsFascipljrskTywRtl8kcodSwkpIvE8Ve6MVmiwMhz3AWstgRpKOY7iix6kQISg3/igaLvMkC6UEH49tdVKmdSfpIhr+qb4Hi0Duriv7RekfTK+geK4pDlk9OriGUn2AGRqWFYr0oeqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0TWQHUpP6I+6jVdWGGFXsKQX56GLp3J8pLB7DZfUFE=;
 b=bBPPkWXlHPZv08bcuGY0118ez046iIUoXbZnZAYbcRycboT0A2DvDUWd345zDYaNs6YPSBnMEZ22+XjvUTvTM9hLNMci9HhGpz0de96Gg5PV7gksHLJZ8Gj4DB6Uy9ZGXpv6ygXr677VeSQ+0l8E9ml31oXU3248o7yy76rmSe0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 19:27:13 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 19:27:13 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: move shadow_list to amdgpu_bo_vm
Date: Mon, 14 Jun 2021 21:26:53 +0200
Message-Id: <20210614192653.18239-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210614192653.18239-1-nirmoy.das@amd.com>
References: <20210614192653.18239-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.117.118]
X-ClientProxiedBy: PR0P264CA0072.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::36) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.117.118) by
 PR0P264CA0072.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 19:27:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f33ec71-3a2a-406f-fa55-08d92f6a6954
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB521317C7EA419FA6AD8F4DC08B319@DM4PR12MB5213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/LiIzOj1Z/E24yExBhr/7vP0PXs4E4UDRmpXa5jiKdNiap9z2z6rmFG8PiEoRGuIFJhML65m4CYNyqOkGOP+jLfe4qeGxR4WsN1UtKQVtWNga4M6XAeRD1VXAgAO4bnDQtIDdfOUc7P2kpAN5opERU9cBn/sMxIcAUrwEm2ZKKFjX07g+Sb28moiQSdxmadsexkYuAmvrBX428NzLVwKCQMgULXvtbJkroRqhcIULT5J114eOVBv0TiJygTg4YYFHPenVNapz8lbE95XPC/1aPDBJaPWsXi1vlaSNQNqrHoXBAkTmfUPNS02rcE4Ae/RBGAuiyuLg03J8kH1tK0BArAPpikORLwbJ9wYH2h4lS0Oo6jSq7dSIGyzDDJjL7VhxfKbv26SC9gr1JnBzeaaBM8jcw4rrk90Egc3CDgi4oOVOyxkEa1S8tD6wGihyCAspqhBqj1Se/eGgTJeBHTvlNOTM+0HvDO2S2Na7M0sApBsYJS5VoYMESr+AqQK6hpLdOGdO7K2RgoBMHloteUwgZuXbaDBWQFsPDVFqcVWo5FcS6hZbYqy6P/9PzqP/o4T73bJxwcFDSopH7I0cG1bczLyCktT3vywqK+q3oF+Scw4UBWZorWwpOqZ6ks6DZH2PfdFGD6DXUsXES4JE2y98NS4CYynZ8YDmYnVEroXP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(2906002)(38350700002)(38100700002)(4326008)(478600001)(6666004)(1076003)(83380400001)(316002)(8676002)(6486002)(52116002)(956004)(26005)(2616005)(16526019)(5660300002)(186003)(6512007)(6506007)(36756003)(86362001)(66476007)(6916009)(8936002)(44832011)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bvzRwfLOKbf4VLaq2sMUr6TO8MN8oJbakkrrOGT0aHTZfH2HnZFaPUB8qUaX?=
 =?us-ascii?Q?7xVDe8qYrP6eJQ5JPov3Xz877dFoDiu0d/GRkrLDf144QHLPfpGBVAsILYBn?=
 =?us-ascii?Q?W7H1cV5dMgDpFnJ5+VYliM/wv7tJ9ducJGTPbPD4AgzMxJpiCEHlIaw6NlRu?=
 =?us-ascii?Q?4VTloB/5Fk6ey0I3I/f/JQ/sjaaLmY6LUQ/sS9PBa7OT3D1DqTeyzEfDD15u?=
 =?us-ascii?Q?JS1LpAX7ydrdmxAXSqLQiVpjc4B1O7Xjt7KrBOy3P8yur2E2V8BkoU0B6F1G?=
 =?us-ascii?Q?43PV6XimldW+vVdqWrJCNRkulplrqVjzkGGJJMZ5Mg2PWW2TUYVkDFdtssOH?=
 =?us-ascii?Q?+yRlt9gB1crtw92pLGqbwyguYfUB/Igk3Qz3sewoJ3AEQY46syHodFHM/VZH?=
 =?us-ascii?Q?W0N673aX1RVBgKbVtYLBPxx6p2L86UmyKC+xGP3Shtgnkv+QC7smnEx1YVON?=
 =?us-ascii?Q?G8u1x8TxacTiPFxslr2brwi0S/fP6qJa1ci8+XZOktPEQAx19anUIvRUPHPN?=
 =?us-ascii?Q?+4EX5OD8eYFgqgZj+8pXv7OehYDGuH1oD6Rg3x2tKQzHd9LXNDiJF/IKVe0d?=
 =?us-ascii?Q?JoXkdEMCZaZgqRny7tmMR/gi2EbzbiSx42VuurZKIZV1oEoktwEHu7KV39Z/?=
 =?us-ascii?Q?pchwqJoradOpsfx03kUeRDwwyivI9RDSCgHgbLxth2B5vDuNAEQOMp0zVvw6?=
 =?us-ascii?Q?cDhI6U01aYbk3LTD1jVYEJUFlk8sDyFtpY91ZI36+vBhh/EaYiIMrA5IGOPV?=
 =?us-ascii?Q?QABWH1I/Pb1yxxhz1uk0BmUDFcJei47a6wSB87mN1z5eY1i6NKJ7aYdQRGKz?=
 =?us-ascii?Q?mF+Ay/Jt4B+zUhicycFZ8KsWbbLcPYQfYAUmosEfgL6SGUxVHyQvYnfyRM5i?=
 =?us-ascii?Q?fTRj/ws+vkRmegW+CpBWqnU29hqWTR/nX6A93mDxTadQO7idAM4N8HeZqDTP?=
 =?us-ascii?Q?7JYuzPR58diztFA+8T8dE+BV3HaFgx6/+zj3tCwbXP8q9WoJK8uvrnzyQvvw?=
 =?us-ascii?Q?Ltp6odPhn9dkghlVZFG1ZGj3wEfz3RT9zMESVaRowECu/pQmoXfhysGtvqNa?=
 =?us-ascii?Q?NgAAetTA3Lr8PfFNoZgcrEE9Rze4/VpH9yHDFbTpq9SfbJSileJUE248EXHb?=
 =?us-ascii?Q?kWnfctk/yCNl9mo1UEpoYE17NqXefjKuGDAh67nDY7X21CWCrYUJy1TChTHA?=
 =?us-ascii?Q?/Kw7U5rToYrNlFJ8DA7FOnOe/5bPwULi8/X0PyBFSW7wEZgxcy73TRU6K8k0?=
 =?us-ascii?Q?SsbOEoUMkEYfkhA2rQTqpBdENRR9zQSNAZFgQRTb1cJ0qKlbuF8T1V4Rzs6A?=
 =?us-ascii?Q?AefWoicKZkoXzorOASC3ptO0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f33ec71-3a2a-406f-fa55-08d92f6a6954
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 19:27:13.0867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etYqNqO6kBfrvnBKj4ZQ/VgaDPkDMsumX6Tm77kCOrfNSwoNEzIBY9m5wopuJVO4ZTXuWfEdWv+bUl08NrR8Xg==
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

Move shadow_list to struct amdgpu_bo_vm as shadow BOs
are part of PT/PD BOs.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 13 +++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

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
index f4f57a73d095..9f1e6bd8601b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -111,12 +111,13 @@ static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_vm *vmbo = to_amdgpu_bo_vm(bo);
 
 	amdgpu_bo_destroy_base(tbo);
 	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
-	if (!list_empty(&bo->shadow_list)) {
+	if (!list_empty(&vmbo->shadow_list)) {
 		mutex_lock(&adev->shadow_list_lock);
-		list_del_init(&bo->shadow_list);
+		list_del_init(&vmbo->shadow_list);
 		mutex_unlock(&adev->shadow_list_lock);
 	}
 
@@ -592,7 +593,6 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
-	INIT_LIST_HEAD(&bo->shadow_list);
 	bo->vm_bo = NULL;
 	bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
 		bp->domain;
@@ -722,6 +722,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 		return r;
 
 	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
+	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
 	return r;
 }
 
@@ -766,12 +767,12 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
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
