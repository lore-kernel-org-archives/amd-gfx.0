Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F772C43461
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF7D613AC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 12:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF7D613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59DC86E4C7;
	Fri, 21 May 2021 12:46:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EEE06E4D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 12:46:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ch49jxDAfXCdQmmr/U2/27KaAmf/JaogmUPhlKR5r3HmXdRVKN9RV1Dqfa0W0SPGAPq85HklFDzX1k4dsz2gOnr/ikrK3x9EBRkE+wSTg/UzFB4PnE1d3A6NLBkC3Ocaqe1rYHbQYbOlW7AsOXCa++IxxJ8e50loB9DdZaz5DU0K/+HHSz6fGst2IXPR2mySwOf+seisDICemqQLklk8MsMeYAZ9BOoL8dqXB2+gA1h/WXHCKHrXyH20PR54rTa4Walao+hXj+CPqFN3lG5SVVGueeC/b63HtX5LzA+5DuXhHjSeP9EOVkpn5BUJ83p0g75z6aCGM5jb+GxRt/lu8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGFKdAqhPJOxP0trdtnqEjImURO2Q9Issdfd0Q4T+jw=;
 b=amjLobYUEz8lnv62RkuYnvTvpN3U99tZOMErKD+DIS4VTEobcDesxgpJaHMl3KniygcjZN0y1AmWxyr2QWFWiXM3IYJv6lXRbRJIPrymF22OhqUjnkmH7BT+rmCbu9pKKefYaBlHUbzi/F+KROg6C1qZyP6aLNrIrrFQ+Ud4CfHqSZ+OcCsLAfeqZuBrRYiEOgCsSPAGAJhnnFlUh+YM/QfDV6yaup9vlDgBckQkvsezbb7BKNnQXYIgFrsf5lwzoG1CbVd3M6eBB7BEcpKS5xuj2n3/c4A10W6SBxmQGAlKpYJVy7krx+LlxyUThBoA0GF33GOR2A4mbZdUaZ4sIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGFKdAqhPJOxP0trdtnqEjImURO2Q9Issdfd0Q4T+jw=;
 b=0afgr7RMvAaEsGYDHpfE3sc6k93Q/DFnL1GCom/Z6scBy9vrBptxsWWDM/a1ZFQhUKK4afiAhKgPcdU+ePVcBuq+7D7yXkDFXvT5a/PsR5qpqqw8j0pU88t8GT8irKAKTH9YPoqKCqmHKG8UZ033XXJWJnsghucYjIWWAuRG10A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 12:45:55 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 12:45:55 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: use amdgpu_bo_vm for vm code
Date: Fri, 21 May 2021 14:45:29 +0200
Message-Id: <20210521124533.4380-3-nirmoy.das@amd.com>
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
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 12:45:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55ce954d-f3dc-4fe7-a84e-08d91c566024
X-MS-TrafficTypeDiagnostic: DM4PR12MB5133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5133D13D819251603A9D80998B299@DM4PR12MB5133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSdAT5kgS7qoVdmdQ4xz1GAhU1NMlLl4k2yiMSmHLeWv7VyBWphf8LlaslobJS6H3qGbmA7uJSpFPTzO+KhE1sqRZJugkqObcexFJnLAfUCGubuGfaiMjFFPCP2jPtMpE9muwjBmn7tYGqUZ/Io7yHEa+MDDyal1DxrfyHAONMiMPYT+GtO5WLpvsJPz5RsfZFtVLm79RPcmMweZR/qe5jfKVySMzL0zPWWpnqc0G+co0rYWw1cHTjF3jPPUkUpaSm0Qe6cnUGpz9+wDJYHYdhXZDT+SyR8W0mFLZKMzxjPt2ULGDv4WdrV4RQlAIJ1D/9MkLUWW1S9/41cw8HjTD6LZt6bq7ufKpu2xBKnCysv1qk3NRWBZiEqs9UbcMKnijRl4kjEpvRmsiz8pKK+MI/L7t4Gs7IrO+icS1WzMVb1S/kmG4S+9ra3EKydISHnHA+gWdMYbFz6mPRVaFLcLnyCJ7x2cmdawcXL+fywLDVqDZjgr8HZF2NFparXA2cpKWrFiSvm/8bxQpi4HCJCLzwFpyWnmv3LBrAZ1GQlFY5NtIOm0kmdQ8unqUkoaU99+en6tBPCkXk2v33z2/aDhqKFQexBFGXpq21A5kA9Vd3ADY4NSniW1Oz/Facuq+mIU6Smj/Lkvm0SZGFYjdodCJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(6506007)(66946007)(66556008)(316002)(38100700002)(8936002)(26005)(6486002)(83380400001)(66476007)(2906002)(6512007)(52116002)(8676002)(86362001)(478600001)(38350700002)(36756003)(5660300002)(4326008)(6666004)(956004)(44832011)(1076003)(2616005)(186003)(16526019)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vnH43i1OWdzCzJ7/XGin/5h89q4EdCBOTITAOYMHZUa3RJgJ2n09bIoccFJW?=
 =?us-ascii?Q?Q48+x+WEFFmtfcbEx7Abou0YGgV6mcDY7BHqdB2+fUnzBWGr73xfJFJTAzFG?=
 =?us-ascii?Q?LPupXuqn9BfWUJvK2LW4qGQFUvkTjLzQOhoqRg+dLPMOA9fEEaCy6/F8TQ9b?=
 =?us-ascii?Q?4P85ONNA19OjM5u/+rz+AMThgjBYcPgw5DsZeYLUKVJ80eEEnCTSMCN4AD4d?=
 =?us-ascii?Q?bJc2Th68NSX5EZ+exGW+AhPldEIItNdJxt53ZB1HE2JkiFLELqAoPg/aFkVz?=
 =?us-ascii?Q?DDBL4gTjI6a3enC5sqoDBVB74bEvRirvJ/31jvng2uym8KCTy804hQdLjjGi?=
 =?us-ascii?Q?gILoaQqP1Z7Bh9xZWtpNHo6jFEziPB6PGnz72x/YYzwUMLbipUin0Gzzphkf?=
 =?us-ascii?Q?yudFdq6YHmbP7VWsSbRg2CNWvRxToIJ0XI++hjZWaGUb7K7/ga08PmsLZeSO?=
 =?us-ascii?Q?WM/rW1lb+e3abOzMDBJ+B/ab9AQYl1kD0tp7MPszrmARilOPrRqMixHhgsXx?=
 =?us-ascii?Q?RKDDSQbQHdkuBKMH7MeO9bZ1+M788w9UmXuaONNiFo3Oda4RPzIqfwxdQirz?=
 =?us-ascii?Q?SmAwuJ7qhJKTR01DFScQ78VpSNECBIRztK1pR4GdFI/1ls/k9DI3tmpWwa6P?=
 =?us-ascii?Q?n6m/xJa+r73Naj2EAWK8+6Cb9MY2amJ3URrT4IP5lSnLxai5dDWUvJE6SYjO?=
 =?us-ascii?Q?XmdNUUvfd88Dl7eruG2gxhHb+W8o33so8zZwDolJhXZVL9W/ZWQCAkNNxay1?=
 =?us-ascii?Q?AhsmNUgUG+7eb+0igmhpg/PcdqC+A+uvUPuVHr9y1lv4anrG7dNYq3nmWG8I?=
 =?us-ascii?Q?bswWo7i8vgc4et60GE699lJ6f4W8LV/6Wa3w/EmuoSlkpThYEZIEd1L6RQ7A?=
 =?us-ascii?Q?Dad0Lj3f9GrXfoXlwC9umNc6misAlW5tS58x1hNuwS4TWCiR+RcWIReET3/d?=
 =?us-ascii?Q?MwKcz/9nkeARukKF4nMLdCEbB28gN7a6PYv0yT6W6QpNCDLCxeOpYI9U+41n?=
 =?us-ascii?Q?CjP5BP4M+tIuK0dQ44hbbT6/rQRZAlsIhzW1F4Uvo6N+Jy3hqWv9cWlKvKSu?=
 =?us-ascii?Q?Atfe9DY1B2OnUN5b/cn1xWbQE9zCS5PRnsXW2Is/P/01FzDcwCu4qvNy/yna?=
 =?us-ascii?Q?jZUDoCNnLy1fsx6kSJBLWXCpjh2sudjCPbnpFUH3IqXxGf/S0Xjt0ppDQwxf?=
 =?us-ascii?Q?facZC/V2gZJpseDN4pTZ6fWVCoTkRmfsrU8kwwfcW9KH04chT22Wza2hHQyk?=
 =?us-ascii?Q?fTOwzxDz0OjDt7NMJHk8Q+ti6RNVeD+4R7Z147orQBaAd3zuEBTYHzkcfq+4?=
 =?us-ascii?Q?wmuPKEgaTM4jbFAwcqCJJt2m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ce954d-f3dc-4fe7-a84e-08d91c566024
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 12:45:55.6839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLaDTUex1ZviVy9A4akQe8v5OG+Okl1jmcTMBkjuwFs4q1fvlVyqd0fddhAd6+dFfeOce+t59qpFvuFuUbnJzg==
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

Use amdgpu_bo_vm for BO for PT/PD.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 43 ++++++++++++++------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 55991f393481..1ac0293e5123 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -863,9 +863,10 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 			       struct amdgpu_vm *vm,
 			       int level, bool immediate,
-			       struct amdgpu_bo **bo)
+			       struct amdgpu_bo_vm **vmbo)
 {
 	struct amdgpu_bo_param bp;
+	struct amdgpu_bo *bo;
 	int r;
 
 	memset(&bp, 0, sizeof(bp));
@@ -876,7 +877,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
 	if (vm->use_cpu_for_update)
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
@@ -885,23 +886,24 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	if (vm->root.base.bo)
 		bp.resv = vm->root.base.bo->tbo.base.resv;
 
-	r = amdgpu_bo_create(adev, &bp, bo);
+	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
 	if (r)
 		return r;
 
+	bo = &(*vmbo)->bo;
 	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
 		return 0;
 
 	if (!bp.resv)
-		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
+		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
 				      NULL));
-	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
+	r = amdgpu_bo_create_shadow(adev, bp.size, bo);
 
 	if (!bp.resv)
-		dma_resv_unlock((*bo)->tbo.base.resv);
+		dma_resv_unlock(bo->tbo.base.resv);
 
 	if (r) {
-		amdgpu_bo_unref(bo);
+		amdgpu_bo_unref(&bo);
 		return r;
 	}
 
@@ -928,7 +930,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 			       bool immediate)
 {
 	struct amdgpu_vm_pt *entry = cursor->entry;
-	struct amdgpu_bo *pt;
+	struct amdgpu_bo *pt_bo;
+	struct amdgpu_bo_vm *pt;
 	int r;
 
 	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
@@ -952,18 +955,19 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
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
 
 	return 0;
 
 error_free_pt:
-	amdgpu_bo_unref(&pt->shadow);
-	amdgpu_bo_unref(&pt);
+	amdgpu_bo_unref(&pt_bo->shadow);
+	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
 
@@ -2837,7 +2841,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 {
-	struct amdgpu_bo *root;
+	struct amdgpu_bo *root_bo;
+	struct amdgpu_bo_vm *root;
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
@@ -2891,18 +2896,18 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
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
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
