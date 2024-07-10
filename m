Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44375C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 18:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB86710E860;
	Wed, 10 Jul 2024 18:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="11cNTcSD";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E017110E860
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 18:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOPCj2h8vrPe9UGnzFJyEtmxerIUx6mtnUTtOohBpa+hiHBWMYU5ee88wJvFLpEkqZOXBivO7eZrbLo0r3Fsxf/YOTjmqQxcTaYt4/RwGXmKGaBPX73anBbSPAf+J32PwiRFSZLKr+w8HF2DN/3H+Z/xlmTlbntFZCwNMrZc+iWDWsAncYYYZ4Y8tpF1Ltlb94vBZu5sTVOfseOCbxj0tbSN6+ymrmlK37P/o2stmobNtzYTDqyNsAkwZ3h/ENCxuFU6Xe3h6IPXb0+Jp2GloWsE76qJDuG+RKil+B+MfXbsiCrGKyD+tWHxdZ9WTk5THeE3S04Op+enEn/hv/50+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz+x5E1ht7LxjMek8F3nds9G7ZYpNb4dxBagrVmzQCI=;
 b=KFrPwMNEx5Q/XYdbFbR+sjoPisoThZ4/qcGHtFAqOlGIgdwLS5wgVRcAV2Qrp+b6PcCIh9IEohTf7hZNUsz9C2UWL46vUejGYbEEMAawvS9PwTof1X8ywK49EH5i1+8U6LEv8szUwAZKkcjfdAs/5vbuI619JXob1vj9cUVC3yVpqaFzHzLQ+hBan3OOxrECU9RQZepF9rVYwXcsK2yScIIOjysLzxswB64FNZ50B5CDoU7X7zuVBmpx+hkAxYzM4z5tOJVteAvaXSIPvmrReRNf5au6asihAg2LxKlgXjjnKoLV0YqhmgIkeT9xYlEdgVfhyn2p31SGG0dGkduY1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz+x5E1ht7LxjMek8F3nds9G7ZYpNb4dxBagrVmzQCI=;
 b=11cNTcSD78DCfPp5y9bimR+ctcxIAON+3ueb3qG36BgC9cPGybB5sLr5U18/Hg4Ky0BwidHQIw2RvjZ0Waapp+b/SG6EzLUXC1u7t1J/sz3Ek9aMeQV+3HkLkAENmkm7CBJ/y5VLB+rENZ55DANKwDkxbXagsEBwx+wH6NZKDEI=
Received: from BN9PR03CA0264.namprd03.prod.outlook.com (2603:10b6:408:ff::29)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Wed, 10 Jul
 2024 18:01:54 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:ff:cafe::5e) by BN9PR03CA0264.outlook.office365.com
 (2603:10b6:408:ff::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 18:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 18:01:53 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 13:01:52 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/vcn: identify unified queue in sw init
Date: Wed, 10 Jul 2024 14:01:39 -0400
Message-ID: <20240710180140.182275-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: b237caee-09d9-43e2-0804-08dca10a61ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hbTE11m/wndTv8qyp/3/IXWRQEjo3ykgFD8fPYpulcj7n+PoGmAdusM4KeXg?=
 =?us-ascii?Q?Sq+NH1055DKTaYNhf5CVLvWzQUaT4vpPSevYqO4D+aj9P7vCe1rUsPwh0i6N?=
 =?us-ascii?Q?vYySezPPkVa/d85KWFQpwATTyBPgqcau4IlZxjO4wo4kbGMvYEaFeFRgKTBV?=
 =?us-ascii?Q?Jdu+Mzbcm3VpLlGOzm6AiWSUUgS61X1udnvna3BGgtFo1lKe25VdLQaGUI9h?=
 =?us-ascii?Q?UCMzF771C8Vv+2xiSHpgSFne/XkkMdTEH2dlDa5wXCykD5AAbdasQskjQ6tr?=
 =?us-ascii?Q?3FiFGO2TiLEGauCMDJQ/KF7Im50nV5eXUnPfzYMTEJrhQpBPXR9zhLxMtxg+?=
 =?us-ascii?Q?1VhBaGJ1d7MvertLAMlYuzM0DcSFGr4ktr6tIdy8cn3zNcRj5f4rec/yOiiA?=
 =?us-ascii?Q?NolzEms62UvgXCntBMJeFBkewOUtAjZZjRRxC4gi1n61mUkE6BPw1rxQJhiL?=
 =?us-ascii?Q?FQKFPk0OUneNGR1hhn7jN2ukq2bXgQuz2cbC0tZw4EFT8DJvMvCOoluNb4wO?=
 =?us-ascii?Q?70i8LQ8mI0wSDWX8gwKqma12gPB9rb/oVRBVdjHMPOEdUN/OJcVJywkTFJtr?=
 =?us-ascii?Q?W854F5oGoYgmyTxk/tWK846LGBTyY25XSXg1sx2OwoVzazyyRkWTAR7VBwZv?=
 =?us-ascii?Q?qAZ/JKnMG+rhvLigUKUci1Ft4vJ9b9nVZQJuuVHpRVf+ORTH2g8A+NxPoFJ6?=
 =?us-ascii?Q?dhxbY0AMS6MWdptlvRHeHrMhYZ6xY/rZKVDlYz2QVt9kpS5eXau8jc/5AhMm?=
 =?us-ascii?Q?l73Spayd3E7N6FGcaW1GMkRE6LkBTLuBSARSoqQBGwDQDWwNd6a6gzoasp8W?=
 =?us-ascii?Q?gBp6HMaSTP6FWowVB8dIh17TsQ2sYd8LHL59yqDE7kHpdLbjwLsaHeraUgMz?=
 =?us-ascii?Q?zXYEBk62KrjZr1YTmECU7pxTGIa2x2bA3oLRLBZn2K4HIbdJou+1mRg4gtvf?=
 =?us-ascii?Q?z8A+n+iyOZyJ/GVsk8qqXlih42pTCgkIZnC3mJDHfheZkVylbsYL9zjvQWsR?=
 =?us-ascii?Q?DP83wXpQNnclkNGBvJ4jWbEkAeRff+YRJvfaETXW1zqnV59+jBtJgepYSoeq?=
 =?us-ascii?Q?a2IvqBSmKlUJQEjdaHwdueMMyqCLtQpS04clIUt76VzM+cSyIvwxoRpzgKUG?=
 =?us-ascii?Q?a9JjW6IfEEv+Yambn5XzKnsP+ZvUACOP32AOC0SeSsHJFYsW4ofM/Eh1ZquI?=
 =?us-ascii?Q?PkMoO+0fhLYA5KZVkn33I/HzBAEtoNgXB2hFrQiUi1lo55AzDHnyDALOtAxy?=
 =?us-ascii?Q?ttt5vor5oWKq7bPQ1JYTIYA3K1qsfOk2ZgaJBIPCaKBzxsXUgsHEmsvYSKm9?=
 =?us-ascii?Q?DDNpvKQPzTGg585iPV0ucxdoi+5Lnqxbum0b+v1h4yEEp+LgThHoysro15Hi?=
 =?us-ascii?Q?bI4BmWVJ+nz5HvhBqemxsGD2PpcfK2ioudPjV4r4g7p1k6iiyBzbyZm7X87P?=
 =?us-ascii?Q?9l6eDoqZDZY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:01:53.8392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b237caee-09d9-43e2-0804-08dca10a61ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Determine whether VCN using unified queue in sw_init, instead of calling
functions later on. 

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 39 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index dad5f9722e14..43bed7730bd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -139,6 +139,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		}
 	}
 
+	/* from vcn4 and above, only unified queue is used */
+	adev->vcn.using_unified_queue =
+		amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0) ? true : false;
+
 	hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
 	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
 
@@ -266,18 +270,6 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-/* from vcn4 and above, only unified queue is used */
-static bool amdgpu_vcn_using_unified_queue(struct amdgpu_ring *ring)
-{
-	struct amdgpu_device *adev = ring->adev;
-	bool ret = false;
-
-	if (amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0))
-		ret = true;
-
-	return ret;
-}
-
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
@@ -747,12 +739,11 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	uint64_t addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	uint32_t *ib_checksum;
 	uint32_t ib_pack_in_dw;
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -765,7 +756,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	ib->length_dw = 0;
 
 	/* single queue headers */
-	if (sq) {
+	if (adev->vcn.using_unified_queue) {
 		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
 						+ 4 + 2; /* engine info + decoding ib in dw */
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
@@ -784,7 +775,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack_in_dw);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -874,15 +865,15 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 					 struct dma_fence **fence)
 {
 	unsigned int ib_size_dw = 16;
+	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -896,7 +887,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -918,7 +909,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
@@ -941,15 +932,15 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 					  struct dma_fence **fence)
 {
 	unsigned int ib_size_dw = 16;
+	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint32_t *ib_checksum = NULL;
 	uint64_t addr;
-	bool sq = amdgpu_vcn_using_unified_queue(ring);
 	int i, r;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_size_dw += 8;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
@@ -963,7 +954,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 
 	ib->length_dw = 0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
 	ib->ptr[ib->length_dw++] = 0x00000018;
@@ -985,7 +976,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
 		ib->ptr[i] = 0x0;
 
-	if (sq)
+	if (adev->vcn.using_unified_queue)
 		amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 081695e74932..838c0935f683 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -329,6 +329,7 @@ struct amdgpu_vcn {
 
 	uint16_t inst_mask;
 	uint8_t	num_inst_per_aid;
+	bool using_unified_queue;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
-- 
2.34.1

