Return-Path: <SRS0=OQM/=FW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63797C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 14:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF8B23358
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Dec 2020 14:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF8B23358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4846E155;
	Fri, 18 Dec 2020 14:40:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD7F6E155
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Dec 2020 14:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrryYQSW4fOZp26rbHykJjsVQKSayC9zstno1QwcKkHYXyDW+hVeSxs23eQfSdkotE7BQRB78BqOoZn4Iol/C/XPqy5UOI6KTGnn7jo50+2g3/BemOGIsOXOuc64vlxHtTiwY19b60H0cNAKPzD7aXHhTj4HrvJ6vXb5/LrdKiO/bXPd0kd95xGGRKoChoLrIvnOOGvgGuVUSp/wL01ZnKQVV82v7s1KbpclBb1+vB1l8G1EqbYN79bO+kBViuT/t9E6nl85zG3/mKTlKUdnORd9q91GAfrsL1IybsEL4TSizPYhHQVGNOVzoNjgs3t9/ck6eawuQwfSqVO9AjbGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWhiLvEyfhw6K87RmyRdxWVNCABf86iFOcbj7ryf6C4=;
 b=JahZtFXi0HwHRZ/1aVivTr06nKCuewd4MR7WvjI54qoSeDPpxh0RbeWZSiv8cEDjSnM9nBzIduT2Gpx4JKGWV5lbUKQh2AuW2BQ2FwM0/3HWbZunhok7MDKVNwq+boqbpWvrBIWNHkOL9rhhqSFQh9PPvkjHyUW23CuEMOEWXWM1A1OxvQCNzdln+tIA6KCQdQ7hIFzKpFStB2qIZZxJLiGRKfM3jvVOublB71fwlotDX7LipY1NPrZv2VsJ0xYU3h9ot4MJkECynrKqgXlC0hPiebowESWUty5xxaTHwKBr6vriolvSpuIGwjXcICQMKg1VtB4nhtb2XaY/B4erQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWhiLvEyfhw6K87RmyRdxWVNCABf86iFOcbj7ryf6C4=;
 b=4eKzrYR90XfHuGxInrT2yRWMbuQ6gJ4i3dRF/dkKKVbFjT+MxpbDJX+9AxX3r4z9sLoa8DHIkSGAeaU5H8kRVg1OaFjrJB05ez+shAZ8aSHkJSn8vf7Q9fbwMfK4uKWELMuam3YoLJw8bFTF17Ibsnr9G/2tIGdQpMFXLktE7wo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1194.namprd12.prod.outlook.com (2603:10b6:3:6e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.18; Fri, 18 Dec
 2020 14:40:36 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::7080:fa49:2223:5f4e%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 14:40:36 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/1] drm/amdgpu: cleanup vce,vcn,uvd ring selftests
Date: Fri, 18 Dec 2020 15:40:24 +0100
Message-Id: <20201218144024.4994-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <6ef74186-56a2-6f38-b73b-b618fd1b5db0@amd.com>
References: <6ef74186-56a2-6f38-b73b-b618fd1b5db0@amd.com>
X-Originating-IP: [93.229.45.20]
X-ClientProxiedBy: AM0P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::27) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.45.20) by
 AM0P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.28 via Frontend Transport; Fri, 18 Dec 2020 14:40:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee12a7f1-8bef-41e5-c871-08d8a362e1e9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1194:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1194BD52DC8F860C390F3C8E8BC30@DM5PR12MB1194.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5d20EEfpqHQfNdPkS0JyVEt0TFop7zewm45bMhSMfJt9K7pJmTGUk2hlAzN36uKoXkdPnyKxMl4eLPqd8Bdv/x341AoeEjMujP9C4+/JrKnO/7tJT1QxDGX+JEicpMjmlJnSCVjjDIUk5SHScqF2ysNMvdPnuwHk+xPOj+ZPNiQev0PorTOCaLV1bAt1rpEgUY4liRcEl9/wB8rhjST1ZyTKk1+pvHto3Ekn8mLAUY1pigizL57cPy9kLX2GO4zZoKJs9Xme4mdB0g/hv49OX23iHy9Jnh9ERsYrb1ejh7weYI/pk12iTJ5CiaQWqCMU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(4326008)(956004)(5660300002)(2616005)(26005)(6916009)(30864003)(44832011)(16526019)(86362001)(8936002)(66476007)(1076003)(6506007)(66946007)(6512007)(478600001)(316002)(2906002)(6486002)(6666004)(52116002)(36756003)(186003)(83380400001)(8676002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?udi4zeYyNywfQb4Oq6EmETUhPVFB5wnSNexpfhk854kJ9t66bkVgJzD6hXP6?=
 =?us-ascii?Q?j8T4gEX2LmtT7kweLNIPc7CY07PezzqoWcjdwW1sSEvSJ6VnMyDoV+Im/yXr?=
 =?us-ascii?Q?RK3/WXp8Hb07rDSlumoTaZ3vg2LykpHS4QYXe2FEf+oqK/EpjhM8z/3q4q0G?=
 =?us-ascii?Q?PuL+Mt0iXlmUdisgC/iNRCF/AppEXxwVLrft0n+IiluV2mY9bggJa9v65mvQ?=
 =?us-ascii?Q?6QK8Ma6svXPDefmaHr8lbvU4ycXCHqPQgV8+jY4gJY1RYNFOM3koxe/XsyaU?=
 =?us-ascii?Q?T9X42ajcwDgY0CQzh62XUI+lCD1WKkqNl7q6+FIdEqdnhn4A5ccUO7qoMhzL?=
 =?us-ascii?Q?YrpDLVRQ1u+QjzLrENukiLSaT1lSVwyU+Otbe87gdKDZlH8D8+tbbvMh+LdH?=
 =?us-ascii?Q?yOaoI6JR0+rhDn686mRy16frt2pRKq7sPMVx/EEfCvfiMy5c9+sNH3AdZF3C?=
 =?us-ascii?Q?vA55h6yiDBM6zd/cmlUvkVUrns+awyZ/TZsb3nIhRyz58P20h+U2AdGHw3k7?=
 =?us-ascii?Q?Qh/Wv8nIk2ZlUJcoMcE6Hr9rHzYAWk1R44vxjOygpyGEwvE91EgJjC/DXeOC?=
 =?us-ascii?Q?QEFcOe/RWjO5vJJH054LvrBEyse8vfTLoXbge0EwXpNnKHkd3Z1nG72nXhQA?=
 =?us-ascii?Q?eaZhyLCTRvHk5hz4DIQeLV1CIvuxo0qk14ED+t8/ElYJaV7BD9jBEFqe9UaV?=
 =?us-ascii?Q?Y7lf76Ed1+seHX+s2EbF4RjgVEHbEY1G5TjgNAtnNfz/ismHwuKwxizNEDzD?=
 =?us-ascii?Q?OZ1l60mqe6PX55wrXJ3tlwEI6eus5T7tiHL3/Ua8ipL3FJlJJXLNYfysg23K?=
 =?us-ascii?Q?nFQXI55fA3lzFLNpp+g9jfFTsHkL6AXfYzRKn0HFawdyyAnzBYmZyawUh+m8?=
 =?us-ascii?Q?WWn8mqsZAxNygm+pZ7gvWhEMc3rc715RSGbfOobaU5Luw8kxEaFFlkdZPsGW?=
 =?us-ascii?Q?oK1IDi8cScgyPa0QQFhacx+xWaKjC7bXGfxrYil8kQJa5/1tCfqvoFdcyEuo?=
 =?us-ascii?Q?slM3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 14:40:36.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: ee12a7f1-8bef-41e5-c871-08d8a362e1e9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/0abu7B6H8Wkhsiyk2oymdN7vMt6iBP/QAM5ZAinD9MvcRIOM6EBO7WJIJxHDDmPozW0BoywAod2Nhdg5TM0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1194
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

Use amdgpu_sa_bo instead of amdgpu_bo.

v2:
* do not initialize bo to get hint from compiler for -Wuninitialized
* pass NULL fence to amdgpu_sa_bo_free if fence is undefined.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 56 +++++++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 17 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 47 ++++++++++-----------
 3 files changed, 45 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 8b989670ed66..13450a3df044 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1057,7 +1057,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
 	return 0;
 }

-static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
+static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_sa_bo *bo,
 			       bool direct, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -1071,19 +1071,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	unsigned offset_idx = 0;
 	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };

-	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unpin(bo);
-
-	if (!ring->adev->uvd.address_64_bit) {
-		struct ttm_operation_ctx ctx = { true, false };
-
-		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
-		amdgpu_uvd_force_into_uvd_segment(bo);
-		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-		if (r)
-			goto err;
-	}
-
 	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
 				     AMDGPU_IB_POOL_DELAYED, &job);
 	if (r)
@@ -1101,7 +1088,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);

 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = amdgpu_sa_bo_gpu_addr(bo);
 	ib->ptr[0] = data[0];
 	ib->ptr[1] = addr;
 	ib->ptr[2] = data[1];
@@ -1115,33 +1102,17 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	ib->length_dw = 16;

 	if (direct) {
-		r = dma_resv_wait_timeout_rcu(bo->tbo.base.resv,
-							true, false,
-							msecs_to_jiffies(10));
-		if (r == 0)
-			r = -ETIMEDOUT;
-		if (r < 0)
-			goto err_free;
-
 		r = amdgpu_job_submit_direct(job, ring, &f);
 		if (r)
 			goto err_free;
 	} else {
-		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
-				     AMDGPU_SYNC_ALWAYS,
-				     AMDGPU_FENCE_OWNER_UNDEFINED);
-		if (r)
-			goto err_free;
-
 		r = amdgpu_job_submit(job, &adev->uvd.entity,
 				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
 		if (r)
 			goto err_free;
 	}

-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, f);

 	if (fence)
 		*fence = dma_fence_get(f);
@@ -1153,8 +1124,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	amdgpu_job_free(job);

 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, NULL);
 	return r;
 }

@@ -1165,16 +1135,17 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 			      struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_sa_bo *bo;
 	uint32_t *msg;
 	int r, i;

-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, (void **)&msg);
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     &bo, 1024, PAGE_SIZE);
+
 	if (r)
 		return r;

+	msg = amdgpu_sa_bo_cpu_addr(bo);
 	/* stitch together an UVD create msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000000);
@@ -1197,16 +1168,17 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 			       bool direct, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_sa_bo *bo;
 	uint32_t *msg;
 	int r, i;

-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, (void **)&msg);
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     &bo, 1024, PAGE_SIZE);
+
 	if (r)
 		return r;

+	msg = amdgpu_sa_bo_cpu_addr(bo);
 	/* stitch together an UVD destroy msg */
 	msg[0] = cpu_to_le32(0x00000de4);
 	msg[1] = cpu_to_le32(0x00000002);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 0d5284b936e4..bce29d6975d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -81,7 +81,7 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);

 static void amdgpu_vce_idle_work_handler(struct work_struct *work);
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
+				     struct amdgpu_sa_bo *bo,
 				     struct dma_fence **fence);
 static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				      bool direct, struct dma_fence **fence);
@@ -437,7 +437,7 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
  * Open up a stream for HW test
  */
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
+				     struct amdgpu_sa_bo *bo,
 				     struct dma_fence **fence)
 {
 	const unsigned ib_size_dw = 1024;
@@ -454,7 +454,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,

 	ib = &job->ibs[0];

-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = amdgpu_sa_bo_gpu_addr(bo);

 	/* stitch together an VCE create msg */
 	ib->length_dw = 0;
@@ -1130,16 +1130,16 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
 int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_sa_bo *bo = NULL;
+	struct amdgpu_device *adev = ring->adev;
 	long r;

 	/* skip vce ring1/2 ib test for now, since it's not reliable */
 	if (ring != &ring->adev->vce.ring[0])
 		return 0;

-	r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     &bo, 512, PAGE_SIZE);
 	if (r)
 		return r;

@@ -1158,8 +1158,7 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		r = 0;

 error:
+	amdgpu_sa_bo_free(adev, &bo, fence);
 	dma_fence_put(fence);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4a77c7424dfc..1e46b2f895ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -488,7 +488,7 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
 }

 static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
-				   struct amdgpu_bo *bo,
+				   struct amdgpu_sa_bo *bo,
 				   struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -504,7 +504,8 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 		goto err;

 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = amdgpu_sa_bo_gpu_addr(bo);
+
 	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
 	ib->ptr[1] = addr;
 	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
@@ -521,9 +522,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	if (r)
 		goto err_free;

-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, f);

 	if (fence)
 		*fence = dma_fence_get(f);
@@ -535,25 +534,27 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	amdgpu_job_free(job);

 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, NULL);
 	return r;
 }

 static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-					 struct amdgpu_bo **bo)
+					 struct amdgpu_sa_bo **bo)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t *msg;
 	int r, i;

 	*bo = NULL;
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      bo, NULL, (void **)&msg);
+
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     bo, 1024, PAGE_SIZE);
+
 	if (r)
 		return r;

+	msg = amdgpu_sa_bo_cpu_addr(*bo);
+
 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000038);
 	msg[2] = cpu_to_le32(0x00000001);
@@ -575,18 +576,19 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 }

 static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
-					  struct amdgpu_bo **bo)
+					  struct amdgpu_sa_bo **bo)
 {
 	struct amdgpu_device *adev = ring->adev;
 	uint32_t *msg;
 	int r, i;

 	*bo = NULL;
-	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      bo, NULL, (void **)&msg);
+	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
+			     bo, 1024, PAGE_SIZE);
+
 	if (r)
 		return r;
+	msg = amdgpu_sa_bo_cpu_addr(*bo);

 	msg[0] = cpu_to_le32(0x00000028);
 	msg[1] = cpu_to_le32(0x00000018);
@@ -603,7 +605,7 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo;
+	struct amdgpu_sa_bo *bo;
 	long r;

 	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
@@ -633,7 +635,7 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 }

 static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
-				   struct amdgpu_bo *bo,
+				   struct amdgpu_sa_bo *bo,
 				   struct dma_fence **fence)
 {
 	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
@@ -651,7 +653,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		goto err;

 	ib = &job->ibs[0];
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = amdgpu_sa_bo_gpu_addr(bo);
 	ib->length_dw = 0;

 	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
@@ -671,9 +673,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	if (r)
 		goto err_free;

-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, f);

 	if (fence)
 		*fence = dma_fence_get(f);
@@ -685,15 +685,14 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	amdgpu_job_free(job);

 err:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
+	amdgpu_sa_bo_free(adev, &bo, NULL);
 	return r;
 }

 int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo;
+	struct amdgpu_sa_bo *bo;
 	long r;

 	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
