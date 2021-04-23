Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9780C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8699361163
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8699361163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B326EB76;
	Fri, 23 Apr 2021 11:18:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3F76EB75
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 11:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFeokhGFLc9vN7Fu8IVjR5/DdmLT2ywdHxU7rGfBN9ZJVqgNw1+16RvXlL6hSioMrrupdUmE6PGDtLIKvSVLGJ0+aV4/hSTODGQO4wW8UaayHg63aKkYDnsWL/WjIfiDQnnqwygDn466/SVrc4yiX3wA0euMkz2C/61dLp6llxXPu9HZlLvH9iDuM78xWpl+dn0FEGo5qpmpJhWpe6SiWk6kwbEy8RgTcUHC6wBaJfvt648YdmQYG7qbfJfXGjTLZ0lTMGuFtamB4Nq2wKCiAHPqn6D4TPBZ5o0t0/GeSq8kyrxaY7tDKr7XyC9mECI/Aa1rsR/9ifXSz06VHPuLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0EGZ4jNQtzk1NG9aMEhvdEXM2GU0Bxs2a8f636wdqg=;
 b=FqxvdHeCqXbhUg0CY1vSTxoTyVwgl4a1qcrISNa2pd2eSQyn2mstQTHP4N91/0TPPcnxeL5XvUb5HAJef2ElxqXkgVpoyQ0/b/rpWYNfAZGYUYoUHT3geEdjzDz3MgMv2iPLK4Do1Ss7gxPbMpT8iTcwRRADo80t+C6TCIF+vOaxHe998l/fBEJA+Q/7x3LhYmhdiVKS26OJsZ4Kh6jG0qingnafkrQYk9nC27RPdUqYgOrcTMSru4yHYnalBxcam316JkT4ey3b0q68BEHUB3U+Lh+6oMlxHDP2Wu4/my4oTUV6i9O2mKk9XLMS/eAKJGFdLDqIT2gVI8RRptlE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0EGZ4jNQtzk1NG9aMEhvdEXM2GU0Bxs2a8f636wdqg=;
 b=d0lbvDnfKLIkclUFtDO+EqqJy7f+PzgHHRGI6oqMauUo8dk/+QxcM7aFqtjFDx9qYdPd6zC20wLjmFZpq+9RwHzFetmCLvcFPa89O0iWUxdfggkF10WX7ATV661jJ+/2PHeaS4XU8QaIjfmafcLts47KrpuJ66CbTLoiHhxZmns=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 11:18:04 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 11:18:04 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 4/6] create shadow bo using amdgpu_bo_create_shadow()
Date: Fri, 23 Apr 2021 13:17:28 +0200
Message-Id: <20210423111730.2345-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423111730.2345-1-nirmoy.das@amd.com>
References: <20210423111730.2345-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.34.71]
X-ClientProxiedBy: PR3P189CA0049.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (93.229.34.71) by
 PR3P189CA0049.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 11:18:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93807df1-8c60-4eb3-be7c-08d906497699
X-MS-TrafficTypeDiagnostic: CY4PR12MB1462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB14627D302C54F1D60EA6ED0B8B459@CY4PR12MB1462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCXVGC3oOb2rv6fVpwITrvGkzED6hr6dhTsi4yJUT/snTjnEg4T+HdJsVQarhYR6pFr6N7Sx/Q/QTbOqpT85NzzjngUlYE0DFA9f45Nmzz6ILIc4rnwxrihfhtVZWMNiC4hE9hTNq326nzmTUSPb6izBn3d0qo7gijald2Otc7yJF3TdSkP/YByqC79Nf0dZFAX6LNWtriER4qlHK+Hyr3kPd97V10JUsrMJ+iOnwC+A/SFeC6PmXO/jCK75pCcK8rRYWB6OqBrjnb0CPpp5HuV3gk967RMDl9yy0o8mF2yHIjJ4O1pXyqC4J+Kg8Wh8VqoGpjYucCxoEZXB9xIsW55nHTI8wnx2UciPvPPShwnASm/DHlR/bhfl2e3RzIdm6bWbqMtFPL0ZrWqxhyQePLhE+ZlzQz/a3xmHHgPVprtOrQ/a1qFIXKgrC8LFQ6dEJL/TgQYrSw1gG4FQzM4bj0Z5XYy7p3h2+B9nAS/0jvDG13sPiRqf1MI/ZN16RSP9v0IkrFz2d6X1+VJGZEIQ4IKpn0d4CnaWtW44T/ccpiNvuhN60e5MX51JUiO0Qy5bJ0q6iUarFzA61+TixcfIXDwTJLClBbWYlxgI/ZSX1Kpid3fu8v+Rh6ZWPo/CZQidWjvaNPLfElna+3XXwHDKdgZfooQAiObxmjO/7ah4170=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(478600001)(52116002)(38100700002)(16526019)(316002)(37006003)(38350700002)(186003)(6512007)(26005)(6486002)(86362001)(8936002)(6506007)(6666004)(1076003)(8676002)(4326008)(2906002)(6636002)(5660300002)(956004)(66946007)(2616005)(36756003)(83380400001)(44832011)(34206002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Thay+ibrApDQvr2H+jzHt1kh2gJILzIUmN8mnD0hBgjzjpaWoJMJ9pYgxjUc?=
 =?us-ascii?Q?8JOmBVKK9ub/hmVafSr+ihA3n0W/+7CENX7wvXtNALqnaUVZa93iuJLpbPfW?=
 =?us-ascii?Q?nPa3CO6+/yepj4QruHnZN8vT6qPl1p5HtOR3XzS+GjtfuN4nfKQGj5Y9ZNLU?=
 =?us-ascii?Q?qsBVYHznwkoK8fHRuG9+a1smWVtrQOSikEHVf9pjhsCwWiMMpddXW9oKztZK?=
 =?us-ascii?Q?nyjblbifXlNFRxZ4XQWsGz5b+4oOhlFVjRjvRySOz9kDPXvq67cfAVziHbJF?=
 =?us-ascii?Q?JdkJa2FeG3147QVqyqmfwcMrDEkQmPSj6JkFDfQhKyRYGGQtBcz2aVYtywWq?=
 =?us-ascii?Q?YyiIixtu8z+rN+fs+43yA3+IJUPQF4oP184ewinhuyd0XzRxRikW4QSSiz23?=
 =?us-ascii?Q?pS5ZRuG29Tz514hO6GFo1adJv3Cs+dxOtYBBpsXJUx0ZVpsx4inuyVXIdcCl?=
 =?us-ascii?Q?Ott7WyLChVc+57LZaC4DXjuJvBHrNjGnttB/6MeHslGmZOTr3wUUqYgUuDku?=
 =?us-ascii?Q?hBSL2GzTd4Jyqew4QIejLgd9dSU7CpC/aR8ZroSMuCxeGC5264izQxEkmVnn?=
 =?us-ascii?Q?YRcqOw4iR9iKbU2st3KqQAYjilmLivxlvmA9v6SAOaKl353aZ1r8cD3Ymn59?=
 =?us-ascii?Q?X1nWPexHOcEx5CI0wLXQGfaa/HeWBoQADIVpTMf4C1a/QlxknGGMCxow3khW?=
 =?us-ascii?Q?rHl1nwGrpLNE8AX9Qh1hQ/EepDDGFKPUiNdQ8hIrQ0nwUAzeXloYtdheP+C/?=
 =?us-ascii?Q?bji17Yq9wB9sbH1L6j9rIA9lSSH23Q/UwZ4cG1qu23NzJKjfvGQYJspbevPh?=
 =?us-ascii?Q?/WkJMS4LbWwnMzVefgSI6Cds4Ebs05/zBjOtoPMZOr3i6A2Ufr3tOLZc3STa?=
 =?us-ascii?Q?3DtQl96RJ7vZtlg9vqBNnFMPnS9V6ItQbklkFubcXCZOuudDKAsCGrr2f3XF?=
 =?us-ascii?Q?dE0nBNpS3zZMeanV8SJeXwhr9m9YE0TwB5DHHgfZYciVi+/AQuArBvkPC2QX?=
 =?us-ascii?Q?ssvWlOP5iCazmOrMyDPA/g2bhgxGeRSjwG8FSzETjfnlFckx8Wjjm0MUOgt3?=
 =?us-ascii?Q?2VWSLTUKS9ZjrOfGA2yUNKpW1EvzUXis4O/pRUQxIuP8F+5mTsdrSGZ0dje3?=
 =?us-ascii?Q?Ap6T4fuCBoPwV7tN8qGxfSnJ1xdu9I+HraGPU0T/FGPKsLxzpqmgBDE9eywm?=
 =?us-ascii?Q?gubwTZUqNIfEnOizb+ziaBfixunUAgXc1za86DeGsxSdI26fozpOLIvzTv+Z?=
 =?us-ascii?Q?BGruLvxSu2HvJ5Vibtg/xUJU1n/gNSFYNRhWSUjmb9Xo3+SAybLhZXTn/1xP?=
 =?us-ascii?Q?nJ4UyBEY+CiXgJYb+1WtBL7q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93807df1-8c60-4eb3-be7c-08d906497699
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:18:04.3081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKOcNrOLykMJ2ufdg50Mh6YjmzfoBrALfZqrp+/PtzD3gZreKlXdhS39mo8Q+8tVh2vCvlj3IBnT94tNeTfrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shadow BOs are only needed for vm code so call amdgpu_bo_create_shadow()
directly instead of depending on amdgpu_bo_create().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 69 +++++++++++++++++---------
 1 file changed, 45 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 577148a4ffaa..9a864a391170 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -850,35 +850,60 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 }
 
 /**
- * amdgpu_vm_bo_param - fill in parameters for PD/PT allocation
+ * amdgpu_vm_pt_create - create bo for PD/PT
  *
  * @adev: amdgpu_device pointer
  * @vm: requesting vm
  * @level: the page table level
  * @immediate: use a immediate update
- * @bp: resulting BO allocation parameters
+ * @bo: pointer to the buffer object pointer
  */
-static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
 			       int level, bool immediate,
-			       struct amdgpu_bo_param *bp)
+			       struct amdgpu_bo **bo)
 {
-	memset(bp, 0, sizeof(*bp));
+	struct amdgpu_bo_param bp;
+	int r;
 
-	bp->size = amdgpu_vm_bo_size(adev, level);
-	bp->byte_align = AMDGPU_GPU_PAGE_SIZE;
-	bp->domain = AMDGPU_GEM_DOMAIN_VRAM;
-	bp->domain = amdgpu_bo_get_preferred_pin_domain(adev, bp->domain);
-	bp->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
+	memset(&bp, 0, sizeof(bp));
+
+	bp.size = amdgpu_vm_bo_size(adev, level);
+	bp.byte_align = AMDGPU_GPU_PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
+	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp->bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 	if (vm->use_cpu_for_update)
-		bp->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	else if (!vm->root.base.bo || vm->root.base.bo->shadow)
-		bp->flags |= AMDGPU_GEM_CREATE_SHADOW;
-	bp->type = ttm_bo_type_kernel;
-	bp->no_wait_gpu = immediate;
+		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+
+	bp.type = ttm_bo_type_kernel;
+	bp.no_wait_gpu = immediate;
 	if (vm->root.base.bo)
-		bp->resv = vm->root.base.bo->tbo.base.resv;
+		bp.resv = vm->root.base.bo->tbo.base.resv;
+
+	r = amdgpu_bo_create(adev, &bp, bo);
+	if (r)
+		return r;
+
+	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
+		return 0;
+
+	if (!bp.resv)
+		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
+				      NULL));
+	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
+
+	if (!bp.resv)
+		dma_resv_unlock((*bo)->tbo.base.resv);
+
+	if (r) {
+		amdgpu_bo_unref(bo);
+		return r;
+	}
+
+	return 0;
 }
 
 /**
@@ -901,7 +926,6 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 			       bool immediate)
 {
 	struct amdgpu_vm_pt *entry = cursor->entry;
-	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *pt;
 	int r;
 
@@ -919,9 +943,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	if (entry->base.bo)
 		return 0;
 
-	amdgpu_vm_bo_param(adev, vm, cursor->level, immediate, &bp);
-
-	r = amdgpu_bo_create(adev, &bp, &pt);
+	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
 	if (r)
 		return r;
 
@@ -2784,7 +2806,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 {
-	struct amdgpu_bo_param bp;
 	struct amdgpu_bo *root;
 	int r, i;
 
@@ -2835,8 +2856,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
 
-	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level, false, &bp);
-	r = amdgpu_bo_create(adev, &bp, &root);
+	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
+				false, &root);
 	if (r)
 		goto error_free_delayed;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
