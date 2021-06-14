Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C0C48BE8
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 14:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D59D61246
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 14:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D59D61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F5989CDD;
	Mon, 14 Jun 2021 14:32:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D977289CBE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 14:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZNFMkehvavl6MOF04eCExmsc8lj7W5Fs+ORkVozEyaWuxX9RleVVzgI784LxyxElpKBM6FEFS+Uu+8zEuPuRTgkUCuxOyOibsr9sj5MY43S51/It+ZMBk7H/eoNWeHWCxnUKlrwt5pozSSVbLKuQhnH7I4pJUonAY7GzLskVTtEDoPpTa8/K91dI1+3yIwm5tV8A1qNXmGpEsGGk+gfc0G+FN5n45xtiAjYxsWWjQVN/NLZ0SpuKNOLfXdnIj3mRXaWjmLXiXL1GHCapmD76qtMkmvPsJfapiZ9bf9X6gqZxJoa0G50WfLTIJef+j/SFhEq7DkisNsErazj5ijgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQrBx6qxPHgdMCTIz9npccgt+RKQdRXgM9qA0t+gGY0=;
 b=V6WrWprxsbiwZ3rsuvnubUMPgVsSoA/DI+f2RTFEAOseLHWnKJe+hjEk/gBzPxw9PIyhW+8sReEz3SmoStEIPWE8+Xh66E2UJeuBWH4tprGQ6DjTn/zESa8nsOT8uo72BXBs0grpwr0/0w2Q4/R9mZsmS7v1vXtDunLFxrUAIZeiExN+yY5mJTaTTBBUZtTP4zv6pFBADUvCIgR5F4DKmMA9q3UhGiBJBqzenuTHmdWPYM2g6DhhvGNaMiopJyDjFT98S3t5xk3NIYL7QDWniU4rPYKHF4DsPfwKznpzGCr0iVrCmmI0HhOHC5bdAay33WifriEFcYXfBhXjsp36Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQrBx6qxPHgdMCTIz9npccgt+RKQdRXgM9qA0t+gGY0=;
 b=b+oh/YXMIGFlrlgrU9OBOwyikkNooQb474esgpGwiCQAu+mSbKabH/kHPCSsyzFUImWrz2xI1dgHNVy8xSqbSC0tnTpvunn34WGdt8vLQqc6ceitC/B3Mxpdjw90PuGvOmhNMMNRHeo3+j36HdTyeAl8kmWwDxBC1s+ls3DpFZs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5328.namprd12.prod.outlook.com (2603:10b6:5:39f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Mon, 14 Jun
 2021 14:32:35 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 14:32:35 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: move shadow_list to amdgpu_bo_vm
Date: Mon, 14 Jun 2021 16:32:17 +0200
Message-Id: <20210614143217.10285-3-nirmoy.das@amd.com>
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
 15.20.4242.9 via Frontend Transport; Mon, 14 Jun 2021 14:32:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34a34c8b-3309-4824-7615-08d92f41405b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB532815601BE8B0CD1CDAA7BC8B319@DM4PR12MB5328.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/pH8nLd3uLAHeL0VW9HW4Mc1Baihx+nWhtCntSCVprZXPKIi7uNeOcaLRufIebhK3b+S0NXTS4hj9XQ/ndU5ffg2ZH2yr+mUpv0l56UCRjTevKWvA7/vDwwu5jw8+GpIJ/VXemz+8DcpP428Y2kC4HVx+0YRtbxedfv6ss7znK00Z/Thfdm1lQtGSgXOq3GfIFhp9AFJT/3WQ4IaFci/FkNgznWngXLUZYH7sIMPrsFuqdHn+GjimmVd6+H4TUG8Xji1naHZqWTwCkto+o7ITsc3UYPnBib/98hIUmlCU5KsQeqeZUYG9OtF6ZbY1bA+ShgFLi18vNYi9x8V1auQDQOK0Hf4rtzU46JM6HH0A93hLExE86KOeE9UD7PS/NcvAJamKJdd3dGHxlZCYBVslLs4Of09xtqa1M3vVTQt5vE/kIMPcgYtA6viieqD/TH7joLBbpO320/aeKOXQo2tPkWs4x+MoJs2gn7i1ejlMGSaRZ2ZSz93V2rH93tNtJa6TJeoSrboWpNt5DfElrIxfwJIAP/93dg7p8thP/lXOj8oWkL1GVIaSvBoV6Kb431aB5BNHaUSPXXElvox0APYHoIxiR7M1ttjSAnBiADEwRIs3D/Euqc8268c4LP9Xfd0ODq5pv7vFphu+rfQ0LN/h1po+7nuXK8vPIxYMDVCpw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(6512007)(44832011)(8676002)(83380400001)(38100700002)(1076003)(2906002)(6486002)(478600001)(956004)(6506007)(86362001)(316002)(36756003)(38350700002)(2616005)(8936002)(66946007)(6916009)(66476007)(5660300002)(26005)(186003)(16526019)(6666004)(4326008)(66556008)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BrDciOuBssCPvPdkuwSVPGslMH1B+Dl7urkGQSFq2p7geRmY2AGoCQKd+RZw?=
 =?us-ascii?Q?diibySPSgTeckx8zb9HHxqjPA0A0/WpHeP4Supoma9mLgaKm6WS1k0PNockZ?=
 =?us-ascii?Q?EZdBL6e2IbrsEwAbBGnkyVJKGbqRA5djsvAfC3mmr9XTS0rc80xaJGmtw8Sv?=
 =?us-ascii?Q?+8wwhq+zI0yuhyQDDCPkeGJIan0ywNfm4qtsgi/stOOTceazd7mYyc7si5Ae?=
 =?us-ascii?Q?YDEnhNGQfzOYJNtnf1LGbc5TLtI7o21gtC85t6oKZVre8tbeYOXXyO6Cnd7m?=
 =?us-ascii?Q?j1UpTtCj/8YSNUg+IH2l+4dBMPQn3x/91nCDQawiCqvQrCm7rXUCxccCrdsC?=
 =?us-ascii?Q?BFtljeWMgwjzfT/HrxRD1Jjdwx0i2fr+pYBVmt7t+PvrMCA/Q7Uok6lpb//B?=
 =?us-ascii?Q?YR/zPKPexhCxZKDa6lKfn99lAYYng0lcf6E4hFT169mCmcvDuxJ+r/FBikHw?=
 =?us-ascii?Q?so7gqi5d1qWEsmICWU/j4OBbu5Ccn7VRpuJaYET7KziO2ZE8OxK9ZVI28y22?=
 =?us-ascii?Q?RZ2Ilb1IwS8BeDY/x6u5T+PR+NlCeWfmK3+Hlw3zkXyq7ljsVGZ4VCKoiyVU?=
 =?us-ascii?Q?PVF6SBhXEqe29D//1XQZ/GMLPSNEgMYIb7YKm7qorXqa2S2RLp1HYXE4TFtg?=
 =?us-ascii?Q?9I2VlBHWFdjiSgMDm0yyGJmyIklzlVU/Ua3TGyYGlRBNnhq9XFKd5eA1KGij?=
 =?us-ascii?Q?30IEeGCU4lCQ0mfErM5j+Qtm1nYI4CNfHrXYIXIDigcqXqKhLvSoxuj5K2mV?=
 =?us-ascii?Q?xlBRbyOWWjIdEPQUPGKmHH1IT0hY6SziLzz35PBJNiZHUPLnl5Nn2+EvSmkD?=
 =?us-ascii?Q?r8NGudsYkrxWo81eVFMvDjUv120SvDS5rQhylEomT8ZbmupX6Q6T6Qt4Tr/f?=
 =?us-ascii?Q?4pE8RyTMEvf0rLKVR2CSWkGO4v52G/7qYwQIBV5Ny1rPmz9V/F3/ZyT+rDT+?=
 =?us-ascii?Q?dOAWjCxqvBMGOvS7leRc4uzCDk5SW+sjd49gug53MjldpszJWp79z4l4qYmZ?=
 =?us-ascii?Q?6LOKc55fyvUJbrYfT4nR2PQe1dgmwPqnuT6O9rbYFzLrKZb4/Xzbyv1bdnQM?=
 =?us-ascii?Q?pfGT/GIeMcY9mWxNM5J88LvmDsdYNPUhU6bUg0NPzrxXF7sF/9/QbIUvBh8Z?=
 =?us-ascii?Q?bzPwrZE5/EcCsSDUAa0/Eay7zviyEBwvF57P4j0iX3VEi9N0911N5TDyA1jf?=
 =?us-ascii?Q?aWDkHF1DWYXBXW87woJUTbpfFvN56cbQsNAKqWfLYdjwlVmFkwka0iS9v4Ed?=
 =?us-ascii?Q?U7svt8+n5NFUSBJLLcWoy8N1+b8BHYOuY3tKxeLhvvdlCaief9UeWxWcTFAn?=
 =?us-ascii?Q?zWn2ZLbT/FEO7O/apsHtWakC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a34c8b-3309-4824-7615-08d92f41405b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 14:32:35.0523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSmTeZt5WIbW0GPEG3IVfN/xIIzbcsm9DdYpEHI+kC1feA19/4DLjE2GVrjqhQb1Zron5VwieKJjPmlvhWWZEA==
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
index d97c20346a8c..cb543e8abe35 100644
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
 
@@ -594,7 +595,6 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
-	INIT_LIST_HEAD(&bo->shadow_list);
 	bo->vm_bo = NULL;
 	bo->preferred_domains = bp->preferred_domain ? bp->preferred_domain :
 		bp->domain;
@@ -737,6 +737,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
 		return r;
 
 	*vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
+	INIT_LIST_HEAD(&(*vmbo_ptr)->shadow_list);
 	return r;
 }
 
@@ -781,12 +782,12 @@ int amdgpu_bo_validate(struct amdgpu_bo *bo)
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
index e36b84516b4e..a08a34351f12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -108,9 +108,6 @@ struct amdgpu_bo {
 #ifdef CONFIG_MMU_NOTIFIER
 	struct mmu_interval_notifier	notifier;
 #endif
-
-	struct list_head		shadow_list;
-
 	struct kgd_mem                  *kfd_bo;
 };
 
@@ -126,6 +123,7 @@ struct amdgpu_bo_user {
 struct amdgpu_bo_vm {
 	struct amdgpu_bo		bo;
 	struct amdgpu_bo		*shadow;
+	struct list_head		shadow_list;
 	struct amdgpu_vm_bo_base        entries[];
 };
 
@@ -332,7 +330,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
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
