Return-Path: <SRS0=17Cd=5L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07432C43331
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 02:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD08820737
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2020 02:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VENWIHF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD08820737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A8C6E887;
	Thu, 26 Mar 2020 02:02:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7C66E887
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2020 02:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmDe7rjerlJNjsrp7qxh70AxpEVtb2kISsJP5h0lk+xesZLlIkpXtRytPV/3q2YIkx2CygRHI4WQDp5nHqJa53px//Kq2oyWS+cxwJ0RB83vu/z9G7v01rr1nXw3gWZ3U8D8yOjhqb2ooDsYryVphCjdd1n8nuh+tWwjbsaYTtnGkAon1GzPRZGKvEB1NbAtzIm7Nyfs3stkz8StKI/YLfRQAzAo/yQUXWqcc1kLSxxq93CcS1c1DjdfkqJkW3QzZbStofr3n8K4pscXhm4nyp3Kmb37/i2ShjRcOTpFdsrbgqAN3unV0Slz5w9nHVbbvCkCYd2t7MJ/ZbFtlU3Wgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xKkZPPK/Zej2ApfX4DDGsfruMt/PzMr6MLs9+kdm7A=;
 b=KW1s0PbI7Wa6LiAGpdiMziZBlb8dHLdIVRUmxVWzMAzXdR7Gld1qE0hy+AU3JIbtMktj66MH9UmQT/nYBtodPOnLmnBL2gLeRQJVC0MU4oknVYRupAXPK0TDRXhn3AVMcxOZWpEW1ScxFR0VsJDtS8uxcR4XZ0XXuH1HFYA3H/P3D6j/X/0fZ2z36WOHdkw3M+087QJk0vZZFdT5KNOMViv6t9SEHp42WMUsLltYAi9G5B2pZwHdGDyJZcSqf7SeNiLD85x7RAkSCLAUC0f+Wxz2RoKNlM4X/yddx596DbrMdnPGnGlrUIFyI80WCPxQZR+cqYXmJ86RW/yQYNf5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xKkZPPK/Zej2ApfX4DDGsfruMt/PzMr6MLs9+kdm7A=;
 b=VENWIHF57NIMwGibS+aefjJu6FLaAlLP5qKpGn4Cewq0wopDmYZBEzndzoJKvBgx6sZ9qpxdlgJI7YQ6UcViKo/mNv/3lEZS6LO5bJ8iSbDPmMWpYIwbVJvGFdN4uoLwa+eBjHX69N9sl1wygblSgb32WypbWbeZSclE2IFOczk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19; Thu, 26 Mar
 2020 02:02:12 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::f458:67f4:2379:b6da%5]) with mapi id 15.20.2835.023; Thu, 26 Mar 2020
 02:02:12 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 2/2] drm/amdgpu: use new job alloc variation if possible
Date: Thu, 26 Mar 2020 10:01:44 +0800
Message-Id: <20200326020144.5953-3-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326020144.5953-1-xinhui.pan@amd.com>
References: <20200326020144.5953-1-xinhui.pan@amd.com>
X-ClientProxiedBy: KL1PR01CA0104.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::20) To SN6PR12MB2800.namprd12.prod.outlook.com
 (2603:10b6:805:6c::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (180.167.199.189) by
 KL1PR01CA0104.apcprd01.prod.exchangelabs.com (2603:1096:820:3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend
 Transport; Thu, 26 Mar 2020 02:02:10 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec2a0705-8554-40b4-ebf5-08d7d129b2cb
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:|SN6PR12MB2655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26551412FE7C5E3EAA0E82D687CF0@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5;
X-Forefront-PRVS: 0354B4BED2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(86362001)(2906002)(2616005)(26005)(186003)(478600001)(16526019)(956004)(4326008)(6486002)(66476007)(66946007)(5660300002)(7696005)(52116002)(81156014)(8936002)(81166006)(8676002)(36756003)(66556008)(316002)(6916009)(6666004)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2655;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1D3qeo6AjpDGyhQoi1X0jQKZEPe9JsNJ8UdIUG1UZpKZpspffxN0HMlVr92//dbrnkgRaranV1KN5SYE8grMtq+Wg6Ef5iZtSgql36zz6276gEQ012riI/AtbN+MXdWJ9Rnk8+prWIA2RTjvZ6ID4K14uInuGkYHrVbi614egsUyyRCceva9/jCYHgnLRtnkv0yID7ErjeHb6bhNhbzC5Bd4y7GG7eLsOP7+75Cb22am45mWyGiilB4iqXJB45PfjdYcJRXpwh51yp0bWD/QhCNZQa6wNHZG1dFLTiChj77WTQW2N3X6EJd69izAZpigGY95AEzPYfVTbAMHVTlWnMoh68dvMQTg/4pzvonH9iHAa+mEL5eoibsZzBB5nnHwi4zXt0ef8fOqj+tvuq36V6SW2OvVyv/Sb8ThkcetqSQrYLrRp4itmc/xVm8AzxY
X-MS-Exchange-AntiSpam-MessageData: rA3M+uwX0U83tFTSTBgsjmXBI8eQsjGBALwoGDbE1XjnyZ3idtzM0jjYz9t/kEU8fJAq0F6+oU2A3kV9rFPR6VgMSgd6OB2XjxPorqGhf0qfY+5O86u81jd/o1uH0bk9GOJZKJ9GuW42Aq/NAzW3Uw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2a0705-8554-40b4-ebf5-08d7d129b2cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2020 02:02:12.1556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sx7m7N1YIY4nF2W7nL54QlE43MTGOV94Y6Cur8c19Nj9Esw3WZIGvSvY6+yiVBWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
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

If we scheduler IB directly, then alloc job ibs in direct ib pool.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       | 4 ++--
 8 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 5727f00afc8e..75458f15f032 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -144,7 +144,7 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring *ring, uint32_t handle,
 	const unsigned ib_size_dw = 16;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(ring->adev, ib_size_dw * 4, &job, 1);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 54cfa3a12135..3360f5eaf19f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2123,7 +2123,7 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
 
-	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(adev, num_dw * 4, &job, direct_submit);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 5fd32ad1c575..a301f8f49997 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1056,7 +1056,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 			goto err;
 	}
 
-	r = amdgpu_job_alloc_with_ib(adev, 64, &job);
+	r = amdgpu_job_alloc_with_ib_direct(adev, 64, &job, direct);
 	if (r)
 		goto err;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 59ddba137946..80b750e15c67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -446,7 +446,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(ring->adev, ib_size_dw * 4, &job, 1);
 	if (r)
 		return r;
 
@@ -524,7 +524,7 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	struct dma_fence *f = NULL;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(ring->adev, ib_size_dw * 4, &job, direct);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index a41272fbcba2..7a9d917f9704 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -390,7 +390,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(adev, 64, &job);
+	r = amdgpu_job_alloc_with_ib_direct(adev, 64, &job, 1);
 	if (r)
 		goto err;
 
@@ -557,7 +557,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(ring->adev, ib_size_dw * 4, &job, 1);
 	if (r)
 		return r;
 
@@ -610,7 +610,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(ring->adev, ib_size_dw * 4, &job, 1);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index d30d103e48a2..65e920892884 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -64,7 +64,8 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 	unsigned int ndw = AMDGPU_VM_SDMA_MIN_NUM_DW;
 	int r;
 
-	r = amdgpu_job_alloc_with_ib(p->adev, ndw * 4, &p->job);
+	r = amdgpu_job_alloc_with_ib_direct(p->adev, ndw * 4, &p->job,
+					p->direct /* direct pool has less contention*/);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index e0aadcaf6c8b..a06aead049c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -216,7 +216,7 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(ring->adev, ib_size_dw * 4, &job, 1);
 	if (r)
 		return r;
 
@@ -279,7 +279,7 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(ring->adev, ib_size_dw * 4, &job, 1);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 0995378d8263..d82b4dfa6ca4 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -224,7 +224,7 @@ static int uvd_v7_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(ring->adev, ib_size_dw * 4, &job, 1);
 	if (r)
 		return r;
 
@@ -286,7 +286,7 @@ static int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handl
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4, &job);
+	r = amdgpu_job_alloc_with_ib_direct(ring->adev, ib_size_dw * 4, &job, 1);
 	if (r)
 		return r;
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
