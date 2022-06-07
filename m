Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979D7C43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 18:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B3810F5A2;
	Tue,  7 Jun 2022 18:36:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BADAC10F5A2
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 18:36:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/1o9MQ/wqph5Nx2cECUzuaxC1I+SuBrd2Dr76rGruSrATK7TEuvcrQSNtpPmLQr6epPwjdLbb2n7pp/C2+3QukoYgHFUCVLl8q3AS8SrB7qlRhSidqkzr0Kt/ZSM9PYY+AQZrw4pZ5xKCNdQnDCB82eJ4Fxa4vf4ikpCbfd5EYcYqNXXkZVkSTbERsjGvG/hEI087WMfI2iANcss7BflQ+lY1KiHwIGGuZHToRkuGyaNacYXddaJnUs5PIj25hvFpf082lRUqRQknSMGEjFUyqJXO9YmE4k5/aSgUfHsIODFcE9F4BywiW2JrV9t2WO/MS05MBgdBfzz3ujkZbmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LdzH+3/WMvhxBcN8Y6EPuMGOLamskyRZu0i/2SfipQ=;
 b=iTL/yw+nBWV+LPggbHTVuP0Mdq4FyapFBbXzl18ZwAWOu2O3V97bNBexV9AyZI4uSsXJlvvdtDhRAzULNARNvTxAar1QCI0CHttaHlARytXA9FC96a51MQdpLYyHG4dH0/gr5SZEo9EGXfeJZGCqCZQZGPltzL0trgC34L6lBMsKtKafY6uO+N68eeQAHYZ6FT2IQ5+5neCuJTYT4At/SL2vFj/5AxQcTRexbiCFKtJFwJGQjhCHdrJVJdkw+i7PHTceewQudphMRBKdTABXe7DfejpDeBPuT7/RUQ2+rOdwOo7UFyHB5TaEBvhEjVuENhyOjzj6kxNX81ohfzhlaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LdzH+3/WMvhxBcN8Y6EPuMGOLamskyRZu0i/2SfipQ=;
 b=vQjKgDpQrzcdvTVe7M4MgA5GNOptPtQrijl+k4+2XHPS2l8dycVjR2bruQRJaDwKa+P8rQX59NyDG+fWBgiOG2elkb1KFbTCYfocHqTttfuQue9O9SzB+uMKCmyVEJ7EqXeJVCi/kO4muRSMgiSEEEP79ozyTkXKneI7qu3jQUI=
Received: from BN9PR03CA0585.namprd03.prod.outlook.com (2603:10b6:408:10d::20)
 by CY4PR12MB1189.namprd12.prod.outlook.com (2603:10b6:903:38::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Tue, 7 Jun
 2022 18:36:48 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::13) by BN9PR03CA0585.outlook.office365.com
 (2603:10b6:408:10d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Tue, 7 Jun 2022 18:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 18:36:47 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 7 Jun 2022 13:36:46 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <Christian.Koenig@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/vcn: add unified queue ib test
Date: Tue, 7 Jun 2022 14:36:32 -0400
Message-ID: <20220607183633.27942-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79c1b0b3-5368-4fa5-f479-08da48b4ae22
X-MS-TrafficTypeDiagnostic: CY4PR12MB1189:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1189AE107BF05346988D551095A59@CY4PR12MB1189.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGVgakI42sCimWV3FaAI31mTKD+ejwWxt3FsVrrdPioxm2iA+acnoQ05t9Bl13G4aG5OZp/oHsdKLXjn0dPxoSreV8VwItpp1SmGmvhBST28Q9xU3HZwbbkHfeQcDr2LygqsiNG7UCOW49zA9Wzn31rc1/wKnIv5ABR+zhqSC/9KkjvVtTOrgNyAJAuO6sXM6sEIhDthX/dklY0TBE4phc/khN7BZkEjwqPV13LZ+/yXcaXZVjRcv8nlXKkIoJj1NINEV5F+habuuBZhfbHCSCWe+hjp5/nnmpBn2L2zRGfATEY3AcWEld4zjBsZxlBkRLHOffw7SKanNPc+Nv8YZaep+BVlatL4r41cfulgz9yiBIWVfSWLCUn8nroDB3yPU307RmBPDasrirdExDHneA4a5T38yG76vuinBbpgatR607lcHroXtVPz3XD2R/9YCcrkeIsE7hDS6ESzMTyFveVsJLRKHfV+4AI/s/Tgia65+drR3rHpASU9zWBjmlKjTS2FfE3DTdfWDqltyDIkIAbM9HbX9WTf9/afDHuDC02xYJeWtbpjJcFKt3H5+2ZjYNTVLuBHpIG/rw3f+zKF3O5q0vT7d/Y5ryBr8DLavocuP8Zy8ce5Ga03gvlSo6eKF7588futUj60AU8Uo4k50xSaB2wuh7HMPgfY0SZLlJ+DceDX+FI0CcPhlsPNFDseYUpOAMmhC4qX5PtPf998Cw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(44832011)(6666004)(86362001)(336012)(508600001)(316002)(83380400001)(426003)(1076003)(40460700003)(186003)(16526019)(2616005)(54906003)(110136005)(7696005)(26005)(2906002)(5660300002)(36756003)(36860700001)(81166007)(8676002)(8936002)(4326008)(47076005)(356005)(70206006)(70586007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 18:36:47.8404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c1b0b3-5368-4fa5-f479-08da48b4ae22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1189
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
Cc: thong.thai@amd.com, sonny.jiang@amd.com, boyuan.zhang@amd.com,
 alexander.deucher@amd.com, ruijing.dong@amd.com, james.zhu@amd.com,
 leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- add unified queue headers
- add unified queue ib tests.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 102 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   1 +
 2 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index aa7acfabf360..e62ff7db4736 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -329,6 +329,18 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
+/* from vcn4 and above, only unified queue is used */
+bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	bool ret = false;
+
+	if (adev->ip_versions[UVD_HWIP][0] >= IP_VERSION(4, 0, 0))
+		ret = true;
+
+	return ret;
+}
+
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
@@ -718,19 +730,55 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	return r;
 }
 
+static uint32_t * amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
+					  uint32_t ib_pack_in_dw, bool enc)
+{
+	uint32_t *ib_checksum;
+
+	ib->ptr[ib->length_dw++] = 0x00000010; /* single queue checksum */
+	ib->ptr[ib->length_dw++] = 0x30000002;
+	ib_checksum = &ib->ptr[ib->length_dw++];
+	ib->ptr[ib->length_dw++] = ib_pack_in_dw;
+
+	ib->ptr[ib->length_dw++] = 0x00000010; /* engine info */
+	ib->ptr[ib->length_dw++] = 0x30000001;
+	ib->ptr[ib->length_dw++] = enc ? 0x2 : 0x3;
+	ib->ptr[ib->length_dw++] = ib_pack_in_dw * sizeof(uint32_t);
+
+	return ib_checksum;
+}
+
+static void amdgpu_vcn_unified_ring_ib_checksum(uint32_t **ib_checksum,
+				        uint32_t ib_pack_in_dw)
+{
+	uint32_t i;
+	uint32_t checksum = 0;
+
+	for (i = 0; i < ib_pack_in_dw; i++)
+		checksum += *(*ib_checksum + 2 + i);
+
+	**ib_checksum = checksum;
+}
+
 static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 				      struct amdgpu_ib *ib_msg,
 				      struct dma_fence **fence)
 {
 	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
-	const unsigned int ib_size_dw = 64;
+	unsigned int ib_size_dw = 64;
 	struct amdgpu_device *adev = ring->adev;
 	struct dma_fence *f = NULL;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
+	bool sq = amdgpu_vcn_using_unified_queue(ring);
+	uint32_t *ib_checksum;
+	uint32_t ib_pack_in_dw;
 	int i, r;
 
+	if (sq)
+		ib_size_dw += 8;
+
 	r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
 				AMDGPU_IB_POOL_DIRECT, &job);
 	if (r)
@@ -739,6 +787,13 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib = &job->ibs[0];
 	ib->length_dw = 0;
 
+	/* single queue headers */
+	if (sq) {
+		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
+			                     + 4 + 2; /* engine info + decoding ib in dw */
+		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
+	}
+
 	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
 	ib->ptr[ib->length_dw++] = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
 	decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib->ptr[ib->length_dw]);
@@ -752,6 +807,9 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
+	if (sq)
+		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
+
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
 		goto err_free;
@@ -838,13 +896,18 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 					 struct amdgpu_ib *ib_msg,
 					 struct dma_fence **fence)
 {
-	const unsigned ib_size_dw = 16;
+	unsigned ib_size_dw = 16;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
+	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
+	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
+	if (sq)
+		ib_size_dw += 8;
+
 	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
 					AMDGPU_IB_POOL_DIRECT, &job);
 	if (r)
@@ -854,6 +917,10 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
 	ib->length_dw = 0;
+
+	if (sq)
+		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
+
 	ib->ptr[ib->length_dw++] = 0x00000018;
 	ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
 	ib->ptr[ib->length_dw++] = handle;
@@ -873,6 +940,9 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
+	if (sq)
+		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
+
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
 		goto err;
@@ -892,13 +962,18 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 					  struct amdgpu_ib *ib_msg,
 					  struct dma_fence **fence)
 {
-	const unsigned ib_size_dw = 16;
+	unsigned ib_size_dw = 16;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
+	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
+	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
+	if (sq)
+		ib_size_dw += 8;
+
 	r = amdgpu_job_alloc_with_ib(ring->adev, ib_size_dw * 4,
 					AMDGPU_IB_POOL_DIRECT, &job);
 	if (r)
@@ -908,6 +983,10 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
 	ib->length_dw = 0;
+
+	if (sq)
+		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
+
 	ib->ptr[ib->length_dw++] = 0x00000018;
 	ib->ptr[ib->length_dw++] = 0x00000001;
 	ib->ptr[ib->length_dw++] = handle;
@@ -927,6 +1006,9 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
+	if (sq)
+		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
+
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
 		goto err;
@@ -977,6 +1059,20 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	return r;
 }
 
+int amdgpu_vcn_unified_ring_test_ib(struct amdgpu_ring *ring, long timeout)
+{
+	long r;
+
+	r = amdgpu_vcn_enc_ring_test_ib(ring, timeout);
+	if (r)
+		goto error;
+
+	r =  amdgpu_vcn_dec_sw_ring_test_ib(ring, timeout);
+
+error:
+	return r;
+}
+
 enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
 {
 	switch(ring) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 6f90fcee0f9c..60c608144480 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -364,6 +364,7 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
+int amdgpu_vcn_unified_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
-- 
2.25.1

