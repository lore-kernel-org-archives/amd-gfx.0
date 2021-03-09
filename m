Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F340C43332
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381576525D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381576525D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1732088810;
	Tue,  9 Mar 2021 08:47:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDDF6E8B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 08:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/qK8Y0uGVKX+4v85czD7KDsGCiiASueNUT/23upZcLIlLGEk+tW3fdidfr/P8iBhI6ll4IlqNwBjfcSj8kck5aRLgsqoK3IREpFyTiOBtQAHRgXLLZGWKA3gHLt/g/U1xyVN9s9D4kDpB21FISgxAtkpyaOGqKhY5EV2gO8GSfpJ31LZ66tT34kYVQxi79/FN1j2sdp9byEttiqbzLJOWg5o0KgHzYonEcOVd/g9zzerKlUCvX2WyKErFZQgNE82czcHgqjhQ3hXw+Az+E44Rj6bzdLmXakUPEmH/fU/TqCCiS9KCzzOIQxTdn/K3nAsICFpUxwurqAbHnPOjIewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRQFAbsHvN0G/ZfdppYIE3oOKVnVJWzMH1N++NWlBsI=;
 b=lAm2NCt/pxxG2gjS0qoFwN5u1pdiQCSv5zJkmRzVE4GB3BLkY2Xk4hN17PnVU3xJ8FCMiWg/40XQ7SPHpsvWEgd0t8hdRdEKlTU6LSzY463UIZoj6ULF2VBgUiNhNlLe/6+K3tS+Ay+EpiJCGDwE06oYX5g3KxzaYuEH++swpkjJKG4+Qdul32EHU1Q4MRYvKuJNyELoqT10fiAB3yEVvUb60xbAodrctlEy5lM14JviZOcf3PnsnBrD40U10e07jUT7j6OioBQmHMSOUU1Pk1IN5/Wgju4Wzye2nI5eKqRnOE7wU8KiOer41mCzGw1SNKAojhThM9GCcfWr6LeKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRQFAbsHvN0G/ZfdppYIE3oOKVnVJWzMH1N++NWlBsI=;
 b=UBaKMIQfk2OpyhqkKH2n1EhfIkxAq9s+jruu8YnRvaS2J/XLbOSr4Gwd3qjRXcGkHTqOJZ2kLbixer/l/iBvmEfIG4JfuYlOI/L+ADWX49xsMvA7Cc++hhaEKwDJGtncxlEreLy+t4m/LDV36lXldr5duMC5LX7qSRAqF7Mf8Cw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) by
 BN6PR1201MB0017.namprd12.prod.outlook.com (2603:10b6:405:53::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 08:47:11 +0000
Received: from BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460]) by BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 08:47:11 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH v2 1/5] drm/amdgpu: allow variable BO struct creation
Date: Tue,  9 Mar 2021 09:46:55 +0100
Message-Id: <20210309084659.37649-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [217.86.127.127]
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To BN6PR12MB1459.namprd12.prod.outlook.com
 (2603:10b6:405:e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.127.127) by
 AM9P193CA0028.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:47:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bea1c024-1c33-4b9a-f220-08d8e2d7eda5
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0017:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00179FF508BDD081B5BFBB9F8B929@BN6PR1201MB0017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JXVm4JZCrXPIHJ7xV4RQ2d3IPGQ1sqyCoU5wgAO4aZ8yW1ZFEFuEl3fAVZQklMsbQuluiqlpweDFuB2hKdWRm58d9tkcVk3Ct7AInJrg1wlV56kVasg5mSlv6HUN44rl7OKzNO4O0oPoQzffURlW+tq5hqXhrqdcaN6P1AVKcpc8yP8UBdffpNeQKZ/Faskweyl5OVfj9mW/PJHI85V2j9IoFSEr90lGIbxYYmbfPk4PQQaQlh1IzDmCd9LgLIGHQFalW4xadHL2WJzpMbRwUn1/4X0pvFOilAWWnTKDMLltWeUPeb5HTleS+tGoyew52LA5vaWZhGC4nYRw3715U8od4ZcTYmb3z/MhTX41ajepC1UcCbP9xviVZ5t9FsJmTSLzP+VIjLwNEL3wffpvTO5YQT6g2rByuT6wBGUiKGFtMABDaWU/gWHHB+fN0Klj0sz0K+Rq9SQOi1pG6fXNodWBF7M8t/O4Hrifl7QRJkDJvg3CX9SUq2lKl/VrEzaXneohCi27QUEv5MSBichQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1459.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(36756003)(83380400001)(956004)(66556008)(6666004)(6486002)(1076003)(26005)(16526019)(2616005)(478600001)(2906002)(66476007)(66946007)(5660300002)(4326008)(186003)(6512007)(8676002)(44832011)(6636002)(6506007)(316002)(8936002)(37006003)(34206002)(86362001)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?x22IwiQ9rjcUeX2F6rZHDH/Hu6CXnqX8j92W+IjiP3A9WMVG3dezz3sKeDQn?=
 =?us-ascii?Q?A46RswiGxPEsdj37Fxo2yX3U/Az31ooZxTERiBfoZEMQY3YIsA7cGK2UevbY?=
 =?us-ascii?Q?+CDk4W3NgYw12eqfYGcOE6IvwHcebaVKjVdJe8KgBeNOOHxdFTzVaKOxNshx?=
 =?us-ascii?Q?iO9Z+F+HcHgLoSnmD2oA9cfSB9UJq2uM1pOQt773hU8Zk4HJVJpGGizwepFK?=
 =?us-ascii?Q?wDSqZSIEASzAUMPQLuvQKkmvEPxoNlM+nnHNp+nludFV06fHln+kuqbhbJCy?=
 =?us-ascii?Q?cbc6SPNr3/AYZUTULMhXJERf9kneJFuFpPE6qcSkH+b56gkR18+0lTtCrop5?=
 =?us-ascii?Q?Vl9QYlE8E153uT/kosVPs1dQ5+qvChQCemUIs8dN6OCszXiEOHmg5u43LsHM?=
 =?us-ascii?Q?7QVhM755OtC8M80n30VRpgrfCFKfZhq9vYyfCQNNZG1GisZPk5P4trtizAbo?=
 =?us-ascii?Q?J5h8qLzIY88rKCae8t4lnu0WXs2+SRsWhUd7GZX/M+UE+UG2bF37mUO6Ge6Z?=
 =?us-ascii?Q?nqTbEgOMbC8xdBjt+AjJf6qC1tlIpzHp0FrxTkZBG8jf3phWzEJd92I4dJgL?=
 =?us-ascii?Q?FIHZF7om7mFiNxuvKRShfeIedVeBq/dlEj7Kx33VyCWcOQKyha4FYjRhUBsc?=
 =?us-ascii?Q?5hE0wH2ds4+UIMsAqM9M33nz1ngmlNKiLw9s3N5sArFLfg0OJAZ/NWk3k1te?=
 =?us-ascii?Q?zeGcRtgn8Aicfz4RwXQfnpt/HoFoVGa5Hgod15BEd3f4vLvlOMyqVjsQAG04?=
 =?us-ascii?Q?iwCCaq4/gdODREI+dOl+IBqmQKZ25PuKXuPdty5RDgXXXAnH4KxgxBQixgNq?=
 =?us-ascii?Q?Y0/Je5TSw7m530Jd0raltPcEAFEnONGhD0O38z7AjT66/MAlVVuB1aCkuDT9?=
 =?us-ascii?Q?itFGlI3WSkJ5zUIfs2rPcVnhrIxEFJWWQqmKasDo+cFxWfTbt36QpUR3uupS?=
 =?us-ascii?Q?jAFDUE7hebEDXm878Jaub7iTS9Lw3hs5/bCxMpdRaclbWtGgWjtWXY2G/eAB?=
 =?us-ascii?Q?MtbY/Zpb1HWCC6n0uiiAVNZ/8vfvSn7YpBCFIIBVrFaDI7+k88EQeYReu1ez?=
 =?us-ascii?Q?yZpzeqRQLkoIUKQGG0BL6pMIxM3oQqJciqm7vLnkIVvQA7ufzkhcwsVBJ1eb?=
 =?us-ascii?Q?IHxP1Vrwt6Vdt77EISkFlhu6BTt7LDC4sAORrzfFwL0x50gTlH7LU1o9udm4?=
 =?us-ascii?Q?bs8HX6QlnY6ZWv1DEH5X4b4NwQAtQskaIeNWqJXtT1q2DkGRajthwV0z5ulm?=
 =?us-ascii?Q?eX9v2CahpVPGvGMawM9JOS6Pk2lrc93GRyc1KywJGdevQkAF7VhQRF/eEk2F?=
 =?us-ascii?Q?QdCVip7rHzbyeu88xOibahlb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea1c024-1c33-4b9a-f220-08d8e2d7eda5
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1459.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:47:10.8495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FksMS88bYOPEliMDd7Hah+1ssH0pGKq54Iuh3FF65CAGTWLTTMn9fyB5OZWPIvF40k2epGhxScavxpdhwCuRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0017
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

Allow allocating BO structures with different structure size
than struct amdgpu_bo.

v2: Check bo_ptr_size in all amdgpu_bo_create() caller.

CC: felix.kuehling@amd.com
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 1 +
 9 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f44185f512de..2151fcb1e19d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -245,6 +245,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
 	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

 	if (cp_mqd_gfx9)
 		bp.flags |= AMDGPU_GEM_CREATE_CP_MQD_GFX9;
@@ -326,6 +327,7 @@ int amdgpu_amdkfd_alloc_gws(struct kgd_dev *kgd, size_t size,
 	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
 	bp.type = ttm_bo_type_device;
 	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

 	r = amdgpu_bo_create(adev, &bp, &bo);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index d9b35df33806..313517f7cf10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -85,6 +85,8 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 	bp.flags = 0;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
 	n = AMDGPU_BENCHMARK_ITERATIONS;
 	r = amdgpu_bo_create(adev, &bp, &sobj);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 5807cad833d3..c5a9a4fb10d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -126,6 +126,8 @@ int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
 			AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 		bp.type = ttm_bo_type_kernel;
 		bp.resv = NULL;
+		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
 		r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
 		if (r) {
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index fb7171e5507c..bca260d56f76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -71,6 +71,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 	bp.preferred_domain = initial_domain;
 	bp.flags = flags;
 	bp.domain = initial_domain;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
 	r = amdgpu_bo_create(adev, &bp, &bo);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 6f7995293a1e..1e07c66676c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -55,6 +55,8 @@ int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev)
 		AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
 	r = amdgpu_bo_create(adev, &bp, &adev->gmc.pdb0_bo);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ac1bb5089260..c30f10f931fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -248,6 +248,7 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 	bp.flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

 	if (!*bo_ptr) {
 		r = amdgpu_bo_create(adev, &bp, bo_ptr);
@@ -543,9 +544,10 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	if (!amdgpu_bo_validate_size(adev, size, bp->domain))
 		return -ENOMEM;

-	*bo_ptr = NULL;
+	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo));

-	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
+	*bo_ptr = NULL;
+	bo = kzalloc(bp->bo_ptr_size, GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
@@ -635,6 +637,7 @@ static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 		AMDGPU_GEM_CREATE_SHADOW;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

 	r = amdgpu_bo_do_create(adev, &bp, &bo->shadow);
 	if (!r) {
@@ -669,6 +672,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	int r;

 	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
+
 	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 54ceb065e546..8e2b556f0b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -40,6 +40,7 @@
 struct amdgpu_bo_param {
 	unsigned long			size;
 	int				byte_align;
+	u32				bo_ptr_size;
 	u32				domain;
 	u32				preferred_domain;
 	u64				flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index 7b230bcbf2c6..909d830b513e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -62,6 +62,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 	bp.flags = 0;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

 	r = amdgpu_bo_create(adev, &bp, &vram_obj);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9d19078246c8..a8f8b9a06899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -869,6 +869,7 @@ static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	bp->domain = amdgpu_bo_get_preferred_pin_domain(adev, bp->domain);
 	bp->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp->bo_ptr_size = sizeof(struct amdgpu_bo);
 	if (vm->use_cpu_for_update)
 		bp->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	else if (!vm->root.base.bo || vm->root.base.bo->shadow)
--
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
