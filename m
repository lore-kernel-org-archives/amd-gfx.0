Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEAEC43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 09:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202442070A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 09:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TZ1YeUuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202442070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5C16E89F;
	Thu, 26 Mar 2020 09:47:33 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690061.outbound.protection.outlook.com [40.107.69.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB666E89F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 09:47:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdaDC/n3qyp/Th2vs15ZN6dJ7rGGJJHqKFLHiu7QiTRHeyP3Nw0jNxqXybJzJpV40IZVCYeLjLZLV/ZqD3Ssz45Tz9XYHhOBet5TscCZER9iqchxXSOgIHAoWcfBvwrjxOa8RpE+6OZCNtNIBST4CVtC2oJjquIZmBQLI0fsfONaJzU9p6KUI7lALjantfQPb6LoMPgi4imyP1XX2bkRxM+aB38iBvymp0uyqbdoLQs4qfGt4qVAn7Ls+gloPMqLyLVrc2k0hGUO6iWq9RxDunV7YXOth0QgH+akBc8ASsaE81IC/t7okMaTGosdVRHFBsZR8w+wJoOfiElL7EzfbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pKb2I5VrNkl5PHM/HNvVHg6XF8u8lHledRHo8dDax8=;
 b=m2jMsHrRjbQsKotaIYhStBWYjA7Q9rPeBMvXLNyTPOt3WaVPuTdgrqZ4QQGYlHSjIN0kqdabIaWSg6vjxq+FRRMnka/i2oTvPoI3QO5LSEC/vroIPAru9ybzVvMU34Q/YahLhV3lmw/HV9pyAOtazhnUA79yu9ltSFHDwD5WeBgKQNFgIBzGVcOfbQSPKSzn8ISchGlirwyQqdX4uNSQiUdGTkp7c8Jv6UAl0w5OZMoxrPcyCeqgg2E3fRXYzi6oTRsu3Mrzpm8i2ld4VrEVgukUnu4nqx+gVy9UXrKoDJnr7aYdBgeWvK4YGZRV1uAWnjQsgOTxE019DQMA0Vw+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pKb2I5VrNkl5PHM/HNvVHg6XF8u8lHledRHo8dDax8=;
 b=TZ1YeUuDeDseNon2vCoyOfB97tKVF6WCN/X+/zwqHK12Rs5mi+Q8zJ3XJailTMq8uyyFI/NrnfPE51a5385yVGZTig2ySiUyLYvyXrIzmWHJHn/nCAaIZ1zH+R4nLd8uMdhLxrfz0j6sozIy35gy34Rjq4eoGuCe0oAsWQTjezE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2623.namprd12.prod.outlook.com (2603:10b6:805:6f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Thu, 26 Mar
 2020 09:47:30 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 09:47:30 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 2/2] drm/amdgpu: use new job alloc variation if possible
Date: Thu, 26 Mar 2020 17:47:08 +0800
Message-Id: <20200326094708.4253-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326094708.4253-1-xinhui.pan@amd.com>
References: <20200326094708.4253-1-xinhui.pan@amd.com>
X-ClientProxiedBy: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 HK2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:202:16::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Thu, 26 Mar 2020 09:47:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb28e384-fd75-4971-ef40-08d7d16ab31d
X-MS-TrafficTypeDiagnostic: SN6PR12MB2623:|SN6PR12MB2623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB262369328B75A22597F30BB287CF0@SN6PR12MB2623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:84;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(478600001)(36756003)(16526019)(316002)(66946007)(66556008)(66476007)(26005)(2906002)(186003)(6916009)(4326008)(2616005)(956004)(8676002)(81166006)(81156014)(8936002)(5660300002)(86362001)(6486002)(1076003)(7696005)(52116002)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2623;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNZwt1AfyEcvGH7YbWdjJQ0Hcc30NKReMYGk0T2YzcgKsixLIlrabhB2/CdtQdXQh0f5XOy2wzUWMUGzkmF4WSjZJdoDG21U1mIACZkslaN5St6MnH3LBrU+fun4cq5D4lL64nmqT2nK1iyaQ6+2wtajLOJLp7pkk0Y4l0k3Az+tGbNESsY4o89oPzm0k4HOZm/cC3JnpRXK8m9+px6fXWUI/Jg6mQnO4ollwRgUoXl6EezIVEnHp7GG263hQIiaXWun3O4hCP5jc40q1YhijFIp3j50XrSOXfTI6P7nGcfDFA8jzRv9wwqyWzJrQjtGSRE0ZCy1F7PJ5aUrffrD3NFIltoFzLFoE7Ibqi1evonb6LHyH6KA50/4EjMCi6CzihX3Bus4IFwgShPZY+Po4F6B2gY5lM2WKp23LzkXHfNwFB+4o6UXzH35wmLHnSzH
X-MS-Exchange-AntiSpam-MessageData: KWPwHtWv6sbg/iykW20RS2ucTugtm7IOcndcDGq54Myez39OkQYzNhQYiU9yzM3XMKf/4KVn/xqHCpgBTFmq2zTwYWHUTUcbM3CB2176a3Uf8SYhatWQEfiPGB3SDTjzqBwEAeTfncUjdd2JD/jp4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb28e384-fd75-4971-ef40-08d7d16ab31d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 09:47:30.0115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YItHOJOfqeO8WzT5/4OA+K4qlD5grcC5vpq7Mlc/GWq4xTnwYzxTIoN++Ezvefcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

use corresponding ib pool for each job

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       | 4 ++--
 9 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 5727f00afc8e..d129da9236cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -144,7 +144,7 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring *ring, uint32_t handle,
 	const unsigned ib_size_dw = 16;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(ring->adev, ib_size_dw * 4, &job, AMD_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e192557db421..fc9ab3f61575 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2124,7 +2124,8 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
 
-	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(adev, num_dw * 4, &job,
+			direct_submit ? AMD_IB_POOL_DIRECT : AMD_IB_POOL_NORMAL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 5fd32ad1c575..1e9a6aa697ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1056,7 +1056,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 			goto err;
 	}
 
-	r = amdgpu_job_alloc_with_ib(adev, 64, &job);
+	r = amdgpu_job_alloc_with_ib_pool(adev, 64, &job,
+			direct ? AMD_IB_POOL_DIRECT : AMD_IB_POOL_NORMAL);
 	if (r)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 59ddba137946..feab5392144a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -446,7 +446,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(ring->adev, ib_size_dw * 4, &job, AMD_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
@@ -524,7 +524,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	struct dma_fence *f = NULL;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(ring->adev, ib_size_dw * 4, &job,
+			direct ? AMD_IB_POOL_DIRECT : AMD_IB_POOL_NORMAL);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index a41272fbcba2..be11599b1a50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -390,7 +390,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(adev, 64, &job);
+	r = amdgpu_job_alloc_with_ib_pool(adev, 64, &job, AMD_IB_POOL_DIRECT);
 	if (r)
 		goto err;
 
@@ -557,7 +557,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(ring->adev, ib_size_dw * 4, &job, AMD_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
@@ -610,7 +610,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(ring->adev, ib_size_dw * 4, &job, AMD_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index d30d103e48a2..663ee44e7187 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -64,7 +64,8 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 	unsigned int ndw = AMDGPU_VM_SDMA_MIN_NUM_DW;
 	int r;
 
-	r = amdgpu_job_alloc_with_ib(p->adev, ndw * 4, &p->job);
+	r = amdgpu_job_alloc_with_ib_pool(p->adev, ndw * 4, &p->job,
+			p->direct ? AMD_IB_POOL_VM : AMD_IB_POOL_NORMAL);
 	if (r)
 		return r;
 
@@ -225,7 +226,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 			ndw = max(ndw, AMDGPU_VM_SDMA_MIN_NUM_DW);
 			ndw = min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
 
-			r = amdgpu_job_alloc_with_ib(p->adev, ndw * 4, &p->job);
+			r = amdgpu_job_alloc_with_ib_pool(p->adev, ndw * 4, &p->job,
+					p->direct ? AMD_IB_POOL_VM : AMD_IB_POOL_NORMAL);
 			if (r)
 				return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9775eca6fe43..aeeb529499e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -369,7 +369,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * translation. Avoid this by doing the invalidation from the SDMA
 	 * itself.
 	 */
-	r = amdgpu_job_alloc_with_ib(adev, 16 * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(adev, 16 * 4, &job, AMD_IB_POOL_VM);
 	if (r)
 		goto error_alloc;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index e0aadcaf6c8b..7db7a62ccc7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -216,7 +216,7 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(ring->adev, ib_size_dw * 4, &job, AMD_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
@@ -279,7 +279,7 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(ring->adev, ib_size_dw * 4, &job, AMD_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 20f10a5617ca..e9e7ab78c356 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -224,7 +224,7 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(ring->adev, ib_size_dw * 4, &job, AMD_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
@@ -286,7 +286,7 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_pool(ring->adev, ib_size_dw * 4, &job, AMD_IB_POOL_DIRECT);
 	if (r)
 		return r;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
