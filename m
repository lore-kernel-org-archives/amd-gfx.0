Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BD5C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991DA61157
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 11:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991DA61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524FC6EE90;
	Thu, 27 May 2021 11:54:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35706EE8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 11:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0pHu8lpsUhkZoKvenj5GzJGI6F/2T7sJoaSGved0p9n+sxU01HaFSkB2KTEXKx0rY0Dm1sU3e5nRO+NsnO5zG6pLCdtcBWuPyxTP8QdevkGmv701QmBxxTuLjvH2az2/Z00GBk7MGvqOa0StntIP9Y6aCOO6smhXDrpnDQS76GTIWos/B+vwM1r72bWcLONy0ueRG/Nm5ErjGMX96TcHV22PP3Hl8FKzlWk5kDlFFdYW/XXiGI3jkSc8naERfS1k1HLIMADqA2JeFs7/qQ65cD9gMPtiQ7rVvvQvlWBILPhkoisO5SvpB6/9DVjKstP2SpxTZnxsE0bjuTMlLfrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcij/QTgjZiIltjAP3if7d5/OtrYSHO53pCdqqx2bVU=;
 b=nF1P/s5rEZgm65eZi6CBDeHvqEGLxcynxZz2bx62Rqqkjnx4NiXHFbVmFZMW14YLTDzx67VQcTN/4lmOEGEj3A0CeuIMO5OOmVqZBG6u0UjHFiG4V1GnqDSwAXTe4h6AZTlsZ6pjrCHl8xAzS3xcO2U9omDDXG580aK15caWC4L1tjFfVd87kcEf3uG1TdkNGTi/Y0LKztB3EV9qH1np2HtmQJPWqqeiPeJU1dXNqGEsJg1mGoZX10PTNB34QEwQAiteWGi3QCD389V1JY1UmcCIy8ulvRr4OQtTwbBf56fg0+Z7UNrVBDjyTNJvtl14rtlS81kq1rJjrbv3WcpupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcij/QTgjZiIltjAP3if7d5/OtrYSHO53pCdqqx2bVU=;
 b=eCsfvPgpUlge3lSLY0wn46i2UDsRGToeIWpjzrgM6/mg11e5TWYzHVIb2O51GuQqmvPk094gd2Bh2oQSm/tWBNd88WKlcZ4uFT0MkvzwrWyLZLlWOT1DFBJhqf/z9EUsGjtYliKCXummuhXQY3PAdRPkkwViHRDUkBwsygKIxZA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5536.namprd12.prod.outlook.com (2603:10b6:5:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 11:54:03 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 11:54:03 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 4/6] drm/amdgpu: switch to amdgpu_bo_vm for vm code
Date: Thu, 27 May 2021 13:53:41 +0200
Message-Id: <20210527115343.20133-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527115343.20133-1-nirmoy.das@amd.com>
References: <20210527115343.20133-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.111.109]
X-ClientProxiedBy: AM3PR05CA0123.eurprd05.prod.outlook.com
 (2603:10a6:207:2::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.111.109) by
 AM3PR05CA0123.eurprd05.prod.outlook.com (2603:10a6:207:2::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Thu, 27 May 2021 11:54:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96922d77-dbf4-45bd-e439-08d921061f8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB5536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55362C08050836713D7D87F08B239@DM6PR12MB5536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byw/n5Xe5vjnBVqLfsYquGNU0Ntsii5rv/qaNhnFfzHFXeclzMsoxLqc7MjQwihyfZ/tXb+FiZVY0proV+1RdJxgkUgaGxtcF1yp+dfmNLqFfdH7QDYQSLkLXm56DaMWylK5AX21e5XQ17KGIbiYB/ELdPWazkhxqKicOlGk7SQxyuajM4k5zCRjm7Pa33XIleJZSR6P1v2T/lBbGQQaLjs7qSJ5DVgYm3hoBeJOI7196kXlTQ5adwx9Kql4ou8mCxMD8+FVVmL1OEq1V5CKF5gJot9KIS1LzkFuzIi4DEsASdpJmMaO1L0GIVOM9VnwYcQqwFszpNy4hVOZV/d68+yaAFWksSYFHED7xGMMwiSgEMdmS3zx/nqZdkBsKXGDs5cxdljhZQsye6ZqJ2VtXBPDEWwotWdbIEsIl/yVMT3X1ebqtSB21/IqSbo9Crq1hEnISBccX4xUGge9PdqCehUsJxvsyf/R7bZSEsaOnJJRPBalM+d1HquWle29G1TUuD39GP8hIjcwHHKVc5dNniVXyNWtpgjRS2VVF7FIAB4DNOVgX6Iyd3Gi8ccWghMqGB25CAr3gg/sXgZtaj4P4ejzPkyr2zP0Xrx0ZSMpLkwGthyZ+eaQgPXOq99aKPJzgML/dk9qckm4kHetwSdR1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(478600001)(4326008)(6486002)(8936002)(2616005)(38350700002)(6666004)(38100700002)(16526019)(956004)(316002)(186003)(6512007)(44832011)(5660300002)(86362001)(83380400001)(2906002)(8676002)(66476007)(66556008)(6916009)(1076003)(66946007)(26005)(52116002)(6506007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Kii5+1tgCwaMmMR4ye9ilPC3xFo9yV2ZKouAawYJPe2RxIe/mJOtKCpqHtY9?=
 =?us-ascii?Q?xl43K9CtMjmI9plFzjJ6bJi4Tr2k8XRormbPKQpy2o/JiqrcuUoqc2rdJHYZ?=
 =?us-ascii?Q?raiILp5BITON/3w81V0kSX+sj3OgoL5r+TtU7nqKXVffnp1GScG7uI3/2Lpa?=
 =?us-ascii?Q?5N45vyVDPUvFi5W0kOiQaa5CabyuLKjigAj0nPpiZLLo98z5IoOpVqEU9fgJ?=
 =?us-ascii?Q?BDA1QlD/YuvEbWACkBx2IGWmYL9QvxQxYNRtjjQne8JIvrNPISmHlIITxVkV?=
 =?us-ascii?Q?oMjjyxnfx6sx1q8WSPQIMMHFBa95QwLnFf5LZAC2f+P9zXGG34yDIX8qkW5S?=
 =?us-ascii?Q?i4KLE8vKzazLBnsugoddqQjRG+6trOPFvQkm8OBCNkpp1GvNkaWw9GJyzx6O?=
 =?us-ascii?Q?LPAUK+bk0ohHfqGWBYdzjtxNnylvMPtwlDqRQbOIFlaveDhvsD37GjWvJZjn?=
 =?us-ascii?Q?tmtNl7mwI+BT9FAU9iQwN8WSB+rtRhBDhN8Qy0sBVr3rFpvvaiEMQCm21zQJ?=
 =?us-ascii?Q?/z5iZQFS0JLvkgXXECwpZz93fueJDOo2EXtklrcD8EDvFGkqPvIWzIfMLr+i?=
 =?us-ascii?Q?F6FOxKkh/xQjrNqhxOvig4LRpWuFrgBr1ihX+tEyQS5yk/D1I1x6YMdwIcOa?=
 =?us-ascii?Q?946RWbDz4kopzKQufvI0gR/SFDgXSz6iMjmaM7Jwc+RnUXSJ0lALwgNlONa4?=
 =?us-ascii?Q?f4uAxKXlJjpNeZSzVjt6MwRsq5nAFgK2S5pru0o6w4Urd6aneuFIHBwgV4KK?=
 =?us-ascii?Q?qBQIoFlGVNDiZH9d8a6/sXmlnON5HreHls9tCjkFoQKRZDId5+4mgcE9WZTL?=
 =?us-ascii?Q?b6nViWuqRiERKCglPYjcMibJ5UlTXY2dJ0zOMgn52QiEpBrKNMgMsqw4IvaP?=
 =?us-ascii?Q?hjJxGhgkDl6l9KWLC2vxUv4C/qBlir/Wwgdc2nCWEp8zqv06paTO3bBz8Vnd?=
 =?us-ascii?Q?N8XKVoRGFZjFmd9vlStl6DO/DuebUwi0xFBUJJ52Y6yBypzUnXiFCVA7aol2?=
 =?us-ascii?Q?N89OJaAUWMugB7Eps4pZ5Mp+hy+tTrZuIChv/OmKW4TxF+E4nGLbCDHIUhmR?=
 =?us-ascii?Q?gwDhO34gG24mLYdDuWqyftnq94Ga/B+xr0CPYO+Tzx47q4Mz6MwM/lWhTJl2?=
 =?us-ascii?Q?0StBB4Ysxy+JRTwAazSL0RapjbHluOCk1ezI81PRC7/GX9RkF38EuG+3xIYt?=
 =?us-ascii?Q?HfZOZs1GILzN6MOfpNHIkBtEuiRd8PoIrnnHiUAeNDd5ug9WnogdBklfczBH?=
 =?us-ascii?Q?6LWpyTSHxDjWJyHR3Q1peQD85wlYFIIsyeuF2ZMwC7eJMlcsCB8xqc39oivw?=
 =?us-ascii?Q?hruQ7ODifq7aa9IZe7kuwzkp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96922d77-dbf4-45bd-e439-08d921061f8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 11:54:03.4048 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrMe39wCrwcJCaBG46fnvihN64UQ1t53+mu2mi7R8NeuhF+Goq9anrMshRa+OI74+xIN6MtOupEONIIbzeKZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5536
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

The subclass, amdgpu_bo_vm is intended for PT/PD BOs which are also
shadowed, so switch to amdgpu_bo_vm BO for PT/PD BOs.

v3: simplify code.
    check also if shadow bo exist, instead of checking only bo's type.
v2: squash three related patches.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 93 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 18 ++--
 2 files changed, 68 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6bc7566cc193..d723873df765 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -652,15 +652,15 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 	spin_lock(&adev->mman.bdev.lru_lock);
 	list_for_each_entry(bo_base, &vm->idle, vm_status) {
 		struct amdgpu_bo *bo = bo_base->bo;
+		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);

 		if (!bo->parent)
 			continue;

 		ttm_bo_move_to_lru_tail(&bo->tbo, &bo->tbo.mem,
 					&vm->lru_bulk_move);
-		if (bo->shadow)
-			ttm_bo_move_to_lru_tail(&bo->shadow->tbo,
-						&bo->shadow->tbo.mem,
+		if (shadow)
+			ttm_bo_move_to_lru_tail(&shadow->tbo, &shadow->tbo.mem,
 						&vm->lru_bulk_move);
 	}
 	spin_unlock(&adev->mman.bdev.lru_lock);
@@ -692,12 +692,13 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,

 	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
 		struct amdgpu_bo *bo = bo_base->bo;
+		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);

 		r = validate(param, bo);
 		if (r)
 			return r;
-		if (bo->shadow) {
-			r = validate(param, bo->shadow);
+		if (shadow) {
+			r = validate(param, shadow);
 			if (r)
 				return r;
 		}
@@ -754,6 +755,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 	unsigned level = adev->vm_manager.root_level;
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_bo *ancestor = bo;
+	struct amdgpu_bo *shadow;
 	unsigned entries, ats_entries;
 	uint64_t addr;
 	int r;
@@ -793,9 +795,9 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 	if (r)
 		return r;

-	if (bo->shadow) {
-		r = ttm_bo_validate(&bo->shadow->tbo, &bo->shadow->placement,
-				    &ctx);
+	shadow = amdgpu_bo_shadowed(bo);
+	if (shadow) {
+		r = ttm_bo_validate(&shadow->tbo, &shadow->placement, &ctx);
 		if (r)
 			return r;
 	}
@@ -863,14 +865,16 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
  * @vm: requesting vm
  * @level: the page table level
  * @immediate: use a immediate update
- * @bo: pointer to the buffer object pointer
+ * @vmbo: pointer to the buffer object pointer
  */
 static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 			       struct amdgpu_vm *vm,
 			       int level, bool immediate,
-			       struct amdgpu_bo **bo)
+			       struct amdgpu_bo_vm **vmbo)
 {
 	struct amdgpu_bo_param bp;
+	struct amdgpu_bo *bo;
+	struct dma_resv *resv;
 	int r;

 	memset(&bp, 0, sizeof(bp));
@@ -881,7 +885,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
 	if (vm->use_cpu_for_update)
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;

@@ -890,26 +894,41 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	if (vm->root.base.bo)
 		bp.resv = vm->root.base.bo->tbo.base.resv;

-	r = amdgpu_bo_create(adev, &bp, bo);
+	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
 	if (r)
 		return r;

-	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
+	bo = &(*vmbo)->bo;
+	if (vm->is_compute_context && (adev->flags & AMD_IS_APU)) {
+		(*vmbo)->shadow = NULL;
 		return 0;
+	}

 	if (!bp.resv)
-		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
+		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
 				      NULL));
-	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
+	resv = bp.resv;
+	memset(&bp, 0, sizeof(bp));
+	bp.size = amdgpu_vm_bo_size(adev, level);
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp.type = ttm_bo_type_kernel;
+	bp.resv = bo->tbo.base.resv;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

-	if (!bp.resv)
-		dma_resv_unlock((*bo)->tbo.base.resv);
+	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
+
+	if (!resv)
+		dma_resv_unlock(bo->tbo.base.resv);

 	if (r) {
-		amdgpu_bo_unref(bo);
+		amdgpu_bo_unref(&bo);
 		return r;
 	}

+	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
+	amdgpu_bo_add_to_shadow_list((*vmbo)->shadow);
+
 	return 0;
 }

@@ -933,7 +952,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 			       bool immediate)
 {
 	struct amdgpu_vm_pt *entry = cursor->entry;
-	struct amdgpu_bo *pt;
+	struct amdgpu_bo *pt_bo;
+	struct amdgpu_bo_vm *pt;
 	int r;

 	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
@@ -957,10 +977,11 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
-	pt->parent = amdgpu_bo_ref(cursor->parent->base.bo);
-	amdgpu_vm_bo_base_init(&entry->base, vm, pt);
+	pt_bo = &pt->bo;
+	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
+	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);

-	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
+	r = amdgpu_vm_clear_bo(adev, vm, pt_bo, immediate);
 	if (r)
 		goto error_free_pt;

@@ -968,7 +989,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,

 error_free_pt:
 	amdgpu_bo_unref(&pt->shadow);
-	amdgpu_bo_unref(&pt);
+	amdgpu_bo_unref(&pt_bo);
 	return r;
 }

@@ -979,10 +1000,13 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
  */
 static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 {
+	struct amdgpu_bo *shadow;
+
 	if (entry->base.bo) {
+		shadow = amdgpu_bo_shadowed(entry->base.bo);
 		entry->base.bo->vm_bo = NULL;
 		list_del(&entry->base.vm_status);
-		amdgpu_bo_unref(&entry->base.bo->shadow);
+		amdgpu_bo_unref(&shadow);
 		amdgpu_bo_unref(&entry->base.bo);
 	}
 	kvfree(entry->entries);
@@ -2674,7 +2698,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	struct amdgpu_vm_bo_base *bo_base;

 	/* shadow bo doesn't have bo base, its validation needs its parent */
-	if (bo->parent && bo->parent->shadow == bo)
+	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
 		bo = bo->parent;

 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
@@ -2843,7 +2867,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 {
-	struct amdgpu_bo *root;
+	struct amdgpu_bo *root_bo;
+	struct amdgpu_bo_vm *root;
 	int r, i;

 	vm->va = RB_ROOT_CACHED;
@@ -2897,18 +2922,18 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 				false, &root);
 	if (r)
 		goto error_free_delayed;
-
-	r = amdgpu_bo_reserve(root, true);
+	root_bo = &root->bo;
+	r = amdgpu_bo_reserve(root_bo, true);
 	if (r)
 		goto error_free_root;

-	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_shared(root_bo->tbo.base.resv, 1);
 	if (r)
 		goto error_unreserve;

-	amdgpu_vm_bo_base_init(&vm->root.base, vm, root);
+	amdgpu_vm_bo_base_init(&vm->root.base, vm, root_bo);

-	r = amdgpu_vm_clear_bo(adev, vm, root, false);
+	r = amdgpu_vm_clear_bo(adev, vm, root_bo, false);
 	if (r)
 		goto error_unreserve;

@@ -2935,8 +2960,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 	amdgpu_bo_unreserve(vm->root.base.bo);

 error_free_root:
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
-	amdgpu_bo_unref(&vm->root.base.bo);
+	amdgpu_bo_unref(&root->shadow);
+	amdgpu_bo_unref(&root_bo);
 	vm->root.base.bo = NULL;

 error_free_delayed:
@@ -3078,7 +3103,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}

 	/* Free the shadow bo for compute VM */
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
+	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.base.bo)->shadow);

 	if (pasid)
 		vm->pasid = pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index a83a646759c5..c9ef025c43f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -41,10 +41,7 @@ static int amdgpu_vm_sdma_map_table(struct amdgpu_bo *table)
 	if (r)
 		return r;

-	if (table->shadow)
-		r = amdgpu_ttm_alloc_gart(&table->shadow->tbo);
-
-	return r;
+	return amdgpu_ttm_alloc_gart(&to_amdgpu_bo_vm(table)->shadow->tbo);
 }

 /**
@@ -201,17 +198,20 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 				 uint64_t addr, unsigned count, uint32_t incr,
 				 uint64_t flags)
 {
+	struct amdgpu_bo *shadow;
 	enum amdgpu_ib_pool_type pool = p->immediate ? AMDGPU_IB_POOL_IMMEDIATE
 		: AMDGPU_IB_POOL_DELAYED;
 	unsigned int i, ndw, nptes;
 	uint64_t *pte;
 	int r;

+	shadow = amdgpu_bo_shadowed(bo);
 	/* Wait for PD/PT moves to be completed */
 	r = amdgpu_sync_fence(&p->job->sync, bo->tbo.moving);
 	if (r)
 		return r;

+
 	do {
 		ndw = p->num_dw_left;
 		ndw -= p->job->ibs->length_dw;
@@ -238,8 +238,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,

 		if (!p->pages_addr) {
 			/* set page commands needed */
-			if (bo->shadow)
-				amdgpu_vm_sdma_set_ptes(p, bo->shadow, pe, addr,
+			if (shadow)
+				amdgpu_vm_sdma_set_ptes(p, shadow, pe, addr,
 							count, incr, flags);
 			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
 						incr, flags);
@@ -248,7 +248,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,

 		/* copy commands needed */
 		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw *
-			(bo->shadow ? 2 : 1);
+			(shadow ? 2 : 1);

 		/* for padding */
 		ndw -= 7;
@@ -263,8 +263,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 			pte[i] |= flags;
 		}

-		if (bo->shadow)
-			amdgpu_vm_sdma_copy_ptes(p, bo->shadow, pe, nptes);
+		if (shadow)
+			amdgpu_vm_sdma_copy_ptes(p, shadow, pe, nptes);
 		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);

 		pe += nptes * 8;
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
