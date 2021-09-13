Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D3C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F1F60F4B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 08:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08F1F60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7529D6EC90;
	Mon, 13 Sep 2021 08:43:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A476EC90
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 08:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXTtaJwBZS+EiLTF/SCf++Qx4UC4LQO+bHszvEEtlZBzmuwVQHDLf70bN5AUHylUkkXdmJocFRxOeA4aXHIN+yLQvsL1XdpuOraME4fuGfmwUGAVQRbBhvwQuBwuHxwHlD6kQ0pvpTtgWdVcP4GUKETd1Rr5Iq6cKbYKBRpyn2zWDhtsyaoeZLi4VdfW2s6oMPFZyAqcckV7HqhXsVh3tVFV3yexhD1U4qzjGKrC4aPrz7x+0X1F3LCHoSBdaiYTMfdQV9oFc855IM3ciaRM8/NMhMHIfRt7RGASnrDq/SQ6yQv6a4+ujjvlEd5QrBjUuXfnmQi9NJwGvvbiwsJvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=IVju9id/T6qC8AXAHVUjlgMICvIhv/iBiC7Gh6MufsY=;
 b=AxNdeopJnjlcVuPjOw7rp0YHweNZr/MF9GvxDf2Di1mfsxCzTMK/sdY/lritgG4sqBl9Rl6HV9Xd3vLSIa5J4Met7vtEgmkuIndrWYWa1w9yWKEfjUerX2EkPxCr6yFAAnggSgnGrxQkR1CV3Zd3JUECPzJccLeTJMPvkD/1Tb7R/W2t7bX1KChf9b0GUH0I61YLybug6sEaz1glrfaJRKMedQRNEwHBaZpGd3vUo3XfdU4bh/mHSb2iY/Nre3m7OOpgA3LaLe7yzOfUxe8T6+sqTnllxzjvmMyk6/GhlgBGolpMHlXfP50446dTEip7fNTi2IPEI54E7dHlt/P9IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVju9id/T6qC8AXAHVUjlgMICvIhv/iBiC7Gh6MufsY=;
 b=ik6PzeOKT/z/Hs6i0M2pBveKcVuEdkNgaSrAJUzTL+ZqRE9pOAXYvn8Le8skZPxmcScleC8ixZKOKBvykljTdxmuhnctF5dcLwvaKrXsaHLECYufvqRF2SoCu1767hucNI2pK3FVv39CnyC7GTs9yH5R8NQFUp4b3NTEGqEHG+o=
Received: from DM5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:4:2::34) by
 CH2PR12MB4023.namprd12.prod.outlook.com (2603:10b6:610:14::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14; Mon, 13 Sep 2021 08:43:12 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::19) by DM5PR10CA0024.outlook.office365.com
 (2603:10b6:4:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 08:43:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 08:43:11 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 03:43:09 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <leo.liu@amd.com>, <James.Zhu@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH v4 2/3] drm/amdgpu: VCE avoid memory allocation during IB test
Date: Mon, 13 Sep 2021 16:42:52 +0800
Message-ID: <20210913084253.241955-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913084253.241955-1-xinhui.pan@amd.com>
References: <20210913084253.241955-1-xinhui.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9bc2603-1471-47fc-97a0-08d976928523
X-MS-TrafficTypeDiagnostic: CH2PR12MB4023:
X-Microsoft-Antispam-PRVS: <CH2PR12MB40233A38B7D5A71AF58C3DA987D99@CH2PR12MB4023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nhs8Yq7irHx7UTERrOfO6RvIZt7FB+AL+cbcoiGqxgskH0cXIOo//X+8AGAb4b3J52/9KSXpQdpcKdkPtMFLHi1/rc2PEsJD7RE+WLqK1nuKYhsttzbiyGevRIzH6UihKLqm+NuRScvAtrpZphL/v2YXjXUKnPuu+wEtY/NDUB0/rGVSxUxMSXlOPZlfXiTc6eRK1zf9oF6hS1aoiCcsXlPlm+4Cos24WViowBfTR0v0E6Yo97UdMKwZDSUS3xTybbDiVyDXd9FwqTp+EONwKhy7vxpcWUFMBSgpemlAH5v4NY+rWpFaB5iyyJBf5ZTCeroigqXZ/aXPmm97DjOgYCS+vIzz/KnK9UCHB13hQh8OSQhKWV8JFFrXWf6oxO5mxwRKhPgbXLJ6Z7Vo3fj7A2LMc4ABx4VSIc6chKOznzUlpd3Dcsx3yxhmhA7htgrj/OCj0ejQwTT9rLC4JVZSO1fITrRVM+MEQ7b5AfSBRRj1EFJfHwfruUB/fdLdf+rmq/T9N2waT3h0c8G+sNoCvPg3oEWyUdXR3HR1knSyi6hDT5wt0rOpUgOMyh2EI7s/M+ljR3gOmkNYSQUAX3LVqzmUQIfQYMgdYpyVb8TwnVfzgGj3W/vdA10P67gt+8VZyQKTy6SO3pWgXn76D0UjYUqmWaq8PodvODs368/CyjG7R378lNxhVypan0DaUL19SJ4kApY8nmrQC13sjeODfYEabRiiHVgR+7qrQnh8bqg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(1076003)(70586007)(7696005)(508600001)(36860700001)(6916009)(6666004)(5660300002)(47076005)(82310400003)(16526019)(36756003)(86362001)(70206006)(336012)(2616005)(83380400001)(186003)(8936002)(26005)(316002)(81166007)(54906003)(426003)(2906002)(8676002)(4326008)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 08:43:11.9711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bc2603-1471-47fc-97a0-08d976928523
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4023
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

alloc extra msg from direct IB pool.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
change from v1:
msg is allocated separately.
msg is aligned to gpu page boundary
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 27 ++++++++++++-------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index e9fdf49d69e8..caa4d3420e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -82,7 +82,6 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
 
 static void amdgpu_vce_idle_work_handler(struct work_struct *work);
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
 				     struct dma_fence **fence);
 static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				      bool direct, struct dma_fence **fence);
@@ -441,12 +440,12 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
  * Open up a stream for HW test
  */
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
 				     struct dma_fence **fence)
 {
 	const unsigned ib_size_dw = 1024;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
+	struct amdgpu_ib ib_msg;
 	struct dma_fence *f = NULL;
 	uint64_t addr;
 	int i, r;
@@ -456,9 +455,17 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	if (r)
 		return r;
 
-	ib = &job->ibs[0];
+	memset(&ib_msg, 0, sizeof(ib_msg));
+	/* only one gpu page is needed, alloc +1 page to make addr aligned. */
+	r = amdgpu_ib_get(ring->adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
+			  AMDGPU_IB_POOL_DIRECT,
+			  &ib_msg);
+	if (r)
+		goto err;
 
-	addr = amdgpu_bo_gpu_offset(bo);
+	ib = &job->ibs[0];
+	/* let addr point to page boundary */
+	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg.gpu_addr);
 
 	/* stitch together an VCE create msg */
 	ib->length_dw = 0;
@@ -498,6 +505,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 		ib->ptr[i] = 0x0;
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
+	amdgpu_ib_free(ring->adev, &ib_msg, f);
 	if (r)
 		goto err;
 
@@ -1134,20 +1142,13 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
 int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
 	struct dma_fence *fence = NULL;
-	struct amdgpu_bo *bo = NULL;
 	long r;
 
 	/* skip vce ring1/2 ib test for now, since it's not reliable */
 	if (ring != &ring->adev->vce.ring[0])
 		return 0;
 
-	r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM,
-				      &bo, NULL, NULL);
-	if (r)
-		return r;
-
-	r = amdgpu_vce_get_create_msg(ring, 1, bo, NULL);
+	r = amdgpu_vce_get_create_msg(ring, 1, NULL);
 	if (r)
 		goto error;
 
@@ -1163,8 +1164,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 error:
 	dma_fence_put(fence);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
 
-- 
2.25.1

