Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA95C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 00:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C84E6109F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 00:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C84E6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99EBD6E94E;
	Fri, 10 Sep 2021 00:38:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BC86E94B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 00:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZcmDUyHjFbpbtF4rnaGgR9fPdeIpDeoAsGI4rQhjQQj9E9G1/pC+lvVdn4WohllBTaWN7cugHnWdZ/zgB4HImPYaqpOZSFwInGq88iPsrj+JTTA+q/hFUGR6FZgIPgfzynRYab/jt5FbWas1hF5HEPpKWv9e0LuwiG+UGcmcrrUx5Sd7qYlhdUMHu9EqYOfnjDUoVPcMCWmFojQ24XFEVVTSll++LvIk8CEiWEQI1Z7rVAYvDVJz1pvSSDBBLu6YINB1IbE3zPg7KMgSEvmTnsCgQZ3VZxSr1Vzrc4I/EiyfZJSy7Ngnh5xzB5hKCmguBq5sUkwEXnCLloc0nNpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=j5F+2dgR7obaVzXX1t+En+RvlmsctTldTnQUrk4K3+M=;
 b=CMSmzibYd7Xet35GEmULj1H+MfiJWnAUuCCxtylVz28JF+sLcNUh9YrIh6s5CivYtsrADbMG7UJjFTjuIMwOnYSZuWP2sz9+Iwd8hai9+JMJqe6MDohw1iNA6s3GpmXp20xTjRVATahEibD44Yq0r/FlfN60aicu5xmlkbst7hnjgMwpv1ii38u5p2mgOx0qJfEGqfTQgOVxzgdYJygrKmlF5A6HYlzDCKMYf9Ybi/Q+HH8kp2Yc2PRaBuDy3lh7qjkFJzg4+tXU5sbcDWFYPdsx8OFBUJoF04WuwhVMKrR2iLcZLBt/rjKwq/aEXx/vncw+cfGQ7sDtVf9rz0H1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5F+2dgR7obaVzXX1t+En+RvlmsctTldTnQUrk4K3+M=;
 b=sxyLuckxdaahlwZMgVUkeqGnTi3bN34VuVaofJwA096W7wFaNFci2fmZgTy0KRZnR/xMcJ3zyjCw0oyPtx05Q4Q492HnsC1l/VcC2LRN6GlZp72b9yamksY/1PEHPfPyPpIySRQXn529HmOuoLBe8Si6ZBSAW1tOkEFh4f/Ajhs=
Received: from DM6PR18CA0022.namprd18.prod.outlook.com (2603:10b6:5:15b::35)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 00:38:49 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::9d) by DM6PR18CA0022.outlook.office365.com
 (2603:10b6:5:15b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 00:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 00:38:49 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 9 Sep 2021
 19:38:45 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: VCE avoid memory allocation during IB test
Date: Fri, 10 Sep 2021 08:38:27 +0800
Message-ID: <20210910003828.4013-3-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910003828.4013-1-xinhui.pan@amd.com>
References: <20210910003828.4013-1-xinhui.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe8c2e39-3af3-4e6e-6bb0-08d973f35b2c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5362:
X-Microsoft-Antispam-PRVS: <BL1PR12MB536272FA46189CC1D9E664D987D69@BL1PR12MB5362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eG2nqpAHCM6+DTp71L+dhl6yGBzG55tWjGHnl36zFh/Bn/8sN0OoZB21C35AYZY17H1Yc/MQHRJlmz+UzCwM1ojtutoUqtHBo06XfNut3UyFwEb/0A83iAK+4N1Sxb/UOVF//fcRnXHLQtJK/3hYZ1aKEtN320L6C++3G9CCqs3LHIVk74k22i92NwWRpEClQ3ZKjyxh3jMtacV7nrWHcEhqVqdWzlGUGtXGC6EYeOizkBq2XfpRHSYoFe+N//WF+dsNIjPW8bGatsv8wFvQ2ixBZQtMydKn4Z6NZb5DNNlWgX7ScwJW1Mf3Mu8VonFdxcR6adsqB4CoqSlGT8Fh1eB7/6u2Eu5RFJC77PePE+fS+47AKBPIPNQtnmFF23ueZot4RbYLaDdO4nKQBeKDH/qkPiaazLagc/0BkuST08/MiIAJihdD29jegqcMsDUVO+IC3RuyQYwxjKmBhtyRfi10lay0/qmT+0aq6KveiL8B/lq9tF5HEagbBALHSSnO26kiBPrd5g9idwsmQP3OrmSBWR3mj5/W55hAGBuKubpxPK+XcxCRe7q93gxr6/taIJ0VE8mm+RZ2ogYSj4ZPCWU9TJimj1ypYYY9aVOqTG3raGFB8cVikswOnMaJqgBog1q1HfYJcQJW8CdE0SBpx53QnicMWOcTwOx2dt/uSrDKAgjL1SN72mp7F9kbTBupNIT5zKn9OXndvaZVySsvddSsueus/swo3aSpxtX+KnI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(316002)(36756003)(478600001)(54906003)(81166007)(36860700001)(70586007)(82740400003)(7696005)(2906002)(6666004)(4326008)(6916009)(82310400003)(8676002)(47076005)(70206006)(86362001)(186003)(356005)(26005)(8936002)(2616005)(83380400001)(16526019)(336012)(426003)(5660300002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 00:38:49.2591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8c2e39-3af3-4e6e-6bb0-08d973f35b2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index e9fdf49d69e8..45d98694db18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -82,7 +82,6 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
 
 static void amdgpu_vce_idle_work_handler(struct work_struct *work);
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
 				     struct dma_fence **fence);
 static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 				      bool direct, struct dma_fence **fence);
@@ -441,7 +440,6 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
  * Open up a stream for HW test
  */
 static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-				     struct amdgpu_bo *bo,
 				     struct dma_fence **fence)
 {
 	const unsigned ib_size_dw = 1024;
@@ -451,14 +449,13 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
+	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4 + PAGE_SIZE,
 				     AMDGPU_IB_POOL_DIRECT, &job);
 	if (r)
 		return r;
 
 	ib = &job->ibs[0];
-
-	addr = amdgpu_bo_gpu_offset(bo);
+	addr = ib->gpu_addr + ib_size_dw * 4;
 
 	/* stitch together an VCE create msg */
 	ib->length_dw = 0;
@@ -1134,20 +1131,13 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
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
 
@@ -1163,8 +1153,6 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 error:
 	dma_fence_put(fence);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_free_kernel(&bo, NULL, NULL);
 	return r;
 }
 
-- 
2.25.1

