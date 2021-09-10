Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF010C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 12:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EB8611C0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 12:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66EB8611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450BA6E9ED;
	Fri, 10 Sep 2021 12:30:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A326E9E9
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 12:30:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvwgWXAwnp8Sf7L4UhFVRIcu51AxNxoBPCpmVVRB3zDzUZinzhrEaf0asaSpDJ+mS+uaDKTYHjWUVfBbbQkeWevmO6LDIT/IJGzGThL3R6CP3bcpU+biGLvN/shqlyGANgCVSG7APyo+BrA8cYjwf+n5c+FQRroDfxNQlVzZqdORn2JZ4mBHqFB/rW+CrbTobz8by6w27JCkZQLNdN4qUDLJ0VomncfIhXsJ+DQzm30Rr+LAVfaUetgvUwCmJs7C3R9I1JNAE+w/+E42NXRSCy0qse8uTyDS4pnnryTpbC2aTGjfcYysQIJ9yFzdcb30/WuE6U8vULsfIP6qTPQbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=SXpbgraCUSl/taytA3VRF2/zVRpWAj5W3zDPn0FKNas=;
 b=K/zUdVTjLMF/l12TMLn/gmyyE8zH1bG2rzm8FV0MBSd77RfCHQ6F1lQoH5CvRz4/kbUgXoWQFV1NGgglHdGbqAZvIjG3BXpCl7QDyg7/UF+fi5EZXMuqODjh/ARLDM1Kr8ew4G06nXaGLkKIzgP6PbT/0GRL2NgZdoE/V0a/m2dZM8gOWa3r7fSvXN+S/adjRdzK6cDX/bGCh1nS9T7B/0lYxct4bKbkU83JxeqMef4fdRFKw7h7VRNFqJOOKPJ5LRX0DxGA+5DRjYT/t8PDLqf4VrUm51SkOEy3+wp2DlkC6a6MBTL4OSIESWGWmVTep/DBu/2812ZPQInXwPJmQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXpbgraCUSl/taytA3VRF2/zVRpWAj5W3zDPn0FKNas=;
 b=G2H4hrBYBIoMU3FuJ7dPr64aiWVLoS9cMQtAukZQvyNDQ5X6Uag0x3hdd/MdKWa2fODNbVDv+TsnzG+ZT3tY6AgkghzodSA+LaiQYxvfw+3YdqAdLE92s6+D3869C7+4d8PUDwzLB+TQwubdhuGKx9BiA1v34dhtUSLS97XGl5g=
Received: from DM5PR06CA0040.namprd06.prod.outlook.com (2603:10b6:3:5d::26) by
 BY5PR12MB4903.namprd12.prod.outlook.com (2603:10b6:a03:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Fri, 10 Sep
 2021 12:30:11 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:5d:cafe::c9) by DM5PR06CA0040.outlook.office365.com
 (2603:10b6:3:5d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Fri, 10 Sep 2021 12:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 12:30:09 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 10 Sep
 2021 07:30:07 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: VCE avoid memory allocation during IB test
Date: Fri, 10 Sep 2021 20:29:39 +0800
Message-ID: <20210910122940.15699-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210910122940.15699-1-xinhui.pan@amd.com>
References: <20210910122940.15699-1-xinhui.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44732f77-0334-48c7-5ef8-08d97456ba9a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4903:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49030697EC076C7A81B9D9F887D69@BY5PR12MB4903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qStdwy06RlENQFHwl4uV3sqdyOoPXRJYyD3gqrL50adFv4PNace9T+e6GOk31WQOr6u39iCqRekglQ11oWKp9oIy8Sr/GBCiwgJmyxl9aaHxbUWEDY4Y11Rfrj/JZEaWmitVMdng6VlKjdGMMKKsTRlXUEOgWvZ/yWPmNvdT/UMutq7MBToVoHWyqQjtMFcPziD0aMT9vBEvkauAbSOsq4iSY4J8JEJ58bJoVF5+yIkRAk5CgjgOrXVqdUt7AXga/wSSremSxuRbb+humX4VgS1qy8JIyqOuZaNFQqalXaDR8gCErfR7r5BBuRY6Hweo8ltnyxDstejch5G/23Ed1QpiTadMiRfEEdFjNzZuVkt/CjWdI7QFSBzZduYN4L53iqI5wQpmHyi101q2b2l/Mmvv8dBxmC2WvgS274WFPsEWsSumYJoRu84cnfJofFXtaFW0rRMrB+Mdw4IpxMPPRc8zdSnNC6azmEau5UKDx134Ny9EzAbPssCeRTV8pwtBqOUpUscB3QumXsTjUw0+PDFRAdms+wK4ca7ioXOt/0dVmUnZFo6b9SLLNl3QsBtWbxUie7lcxfOvxIqp2614bIgWZP7TAOgWNWzbigY803CnwIAbDviAFSwKzyIynkWB4RgRzghQdkoZp+gRTXsLzUDstiQt/+Y0/bRjKJCDEbZzllIqULfzLBDhYzZ725SG8LU3vy6w08Udl1mw1bWzxzul6ad/5nA/ktYX2xOc+eM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(36840700001)(81166007)(36860700001)(426003)(16526019)(70586007)(186003)(26005)(2616005)(7696005)(82310400003)(83380400001)(6916009)(478600001)(86362001)(54906003)(316002)(47076005)(4326008)(6666004)(70206006)(2906002)(5660300002)(1076003)(8936002)(8676002)(356005)(82740400003)(336012)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 12:30:09.5394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44732f77-0334-48c7-5ef8-08d97456ba9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4903
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
let addr align up to gpu page boundary.
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

