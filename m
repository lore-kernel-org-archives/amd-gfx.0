Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C0EC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 20:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DB510E8FE;
	Wed, 10 Jul 2024 20:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HkbOIbAf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D570D10E8FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 20:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3SvcObzsi61P1g35f2G2nSCrpMXiafjlJGamitk671WNOknJO7bFLWmqMfHEPECW1fKiGf53TbiwgNMFczYwrhQ9sPmhmf3zF2L7VLJra3H9pD1/odVqrjJ5HynJN07khVs+ZQU4v4nfAp1k+Y+4AkOnT1QuAXkd7GroFjGgUn3jRjD0krmFAppNvbpY5LrdnCqSY/rcIszQNCtFuDr++9tcjiYRlFFk9uCeaa+uH/rBwP/xTJQi9Uno8duQ9M8HixdrhMHFYi25mx7t19vGMR8tK/KBvMQY7tRmAHVUBzQqjwNGdLm5qqfn9AldoyQHnzOSvEzzHANHOJl/zQqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvIjIKAhc+gWrt8H0ofejhcxfPyTy+nMaKyeITtcSIU=;
 b=SAOZ1GQjIfoMTRUgTyu96cyAilTP1NHukPPSKf0q/Au+6o19bOvjQXk93l8Ei9t/sUOzpj68GWG4DgmlVnigwDqKI1oKRPzh7Iz75ezjdbQzJtDGTDKemM4KJWl8qKhZEfc/3Any1ntKZV9WDywjE3oVASu1gR28qHeRoKz17qIJg+BBV9KhVbXjxNOFhvnt3D2212ewOFjBny6Pt19iSSHecT2UEsng74e1PpOgaPLXOoxZdwYswNxPSIMhUACD5yg+ave+1mqC4T9YGQTpFG/CnG3/pWuSP50CGIaBKnDNvDlGN5hY8ivuZN1xMhWUFglcvU9OYASWQM95xmpZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvIjIKAhc+gWrt8H0ofejhcxfPyTy+nMaKyeITtcSIU=;
 b=HkbOIbAfstF9xH/jgO1UyP2dCVeMSewBPZDM3O3kpcVg+B988yfL5APLFiA4+eKVoRttCw52t/t0dVJwbxBpYcwNGwCZDfMU0BV7HCQUUq3WQHmi/kFnBNvSKel9+qVjc9VfuJINHSbIZv1+pGPbc1SjhSMDe42MXJfEqvbT1n8=
Received: from SA1P222CA0081.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::7)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Wed, 10 Jul
 2024 20:59:51 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::7) by SA1P222CA0081.outlook.office365.com
 (2603:10b6:806:35e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 20:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 20:59:51 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 15:59:49 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Ruijing Dong <ruijing.dong@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/vcn: identify unified queue in sw init
Date: Wed, 10 Jul 2024 16:59:06 -0400
Message-ID: <20240710205907.190580-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa7e1bb-701e-4257-224d-08dca1233dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Odz9pwuDaJcBbAhTWkoy00s0AMBc8kgC4ZeMabY6IcbagRg9XzSH5P1BTjXa?=
 =?us-ascii?Q?wq0FGV7814lZ9Xxz9ooGRWzAzft9MoNTxwLYx6yHK2OlAHS9PJBMb/IpNzN3?=
 =?us-ascii?Q?vOhV850z+cgIyP33C5v9s5ZItu/lV2Tq9Eax2H0TiQLoa5iioymsg1z87/NS?=
 =?us-ascii?Q?bxO5ryeBDVU/UONi2BMHjDjfW8mTMzPH8KitPYU41gAXe/0mPxTEAa9TZaMh?=
 =?us-ascii?Q?rkHzCGIVAN3KwNjE06erMEuOL8QsQuIA1sSb/kvg9Zk3HKI3i9Am/pgTWBDJ?=
 =?us-ascii?Q?E7FxnCNuuzehGilj9nT6AXY8LB7hiPL/sO0AAhveV0ZlrhbCh+9BoN4HTZzT?=
 =?us-ascii?Q?HdPXvDH+qxIF2HkPEkmuwyg18NaoRIugXgupuu838C3DAFKYLuXSnBUQZ/hu?=
 =?us-ascii?Q?b9xyrFMFkf1Q/0H9EGKnqo4dbgc9Esnsz11YtNLeV2MeecgG/jM/CkuX0bFT?=
 =?us-ascii?Q?AQfoVA8pS2V4jL8XpI7atpMz9mKNR5gT3Ny9kmT4LiQQtlbWigymC5yc/RGO?=
 =?us-ascii?Q?r4210PAFGdXy5q4rUmwyGJGfLZRgZIELHO5fyr9sOr/Ji/2JCt6IQVUmRcI4?=
 =?us-ascii?Q?bq0gNiAiPvjn4YNo1aq3c/XIZjlHfcAF0i/JCaeGKh036bLpZZAGwquFlw5Z?=
 =?us-ascii?Q?qySKWDAaTR54WmeDaXsV0pPIxSFOkDnhHaV1+TEdcxhzCkMg/FZroLwP5dpv?=
 =?us-ascii?Q?+qtdvCNZKbm64Lax8r8gaekmhn6RK7agAGbx+sRZxh/s1B0nF7SVaxW0SQAL?=
 =?us-ascii?Q?Pf6HWchTC9Xis51Jpb+BOt/0t4X/4ewnTLrwd0mesuaaZTfG6bIS13V3/Blr?=
 =?us-ascii?Q?GDackJzgSJwPblGOKclG4MDyenswfbmKF43evm32mdhDYFWlDW+ifZT8RQbe?=
 =?us-ascii?Q?LYJm+PRoKOwtayuWYPanoiQ+jM81JQOAn9XHJEVYskkiaN8KNoaf2JinLb17?=
 =?us-ascii?Q?4/Rq3+eOaPXWInLOEUnNQUaTYUV1V99TQ2ZNgmr7W3UlubMVQbRlvImPUmfX?=
 =?us-ascii?Q?ty3E8BYIRdaN7qSH3uXjLCab4CdQNlREYqR2E7CXSlsQvJI54Rekg9eTxbhW?=
 =?us-ascii?Q?vZ5uhG0cO24q03sZ1cLeXbr60DrxPMFcejdhBSj8SSr16MQLKiQ717NbAiyX?=
 =?us-ascii?Q?o71dgN+AA7zsRwfiMUWpc+Addu97wgu8dltVI2g7grsXvQHuFK9e8zzsbMMa?=
 =?us-ascii?Q?dQ7Gy6q2/oFkMzUc/frbI/47W9uJDBHUEQmiN07nZxaV2a/495Qs+JAePfxj?=
 =?us-ascii?Q?qPvEYaJ4XwTc3qniycuptntlj3FUh0CXnQphh/P5FTXUZL3nT4oWS5VEdujE?=
 =?us-ascii?Q?w7iZK40eaji5i05+1qf4XhXjpQ4kBYU63ZSxIbY2Nr6/qWEJm8JgAPR4axqH?=
 =?us-ascii?Q?iCl18Hri42+pcjS+Vxxa7sexEo60z23fiIMuoE5cql2TlPBwVP85whXbede4?=
 =?us-ascii?Q?q41NxqMOK2w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 20:59:51.2105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa7e1bb-701e-4257-224d-08dca1233dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502
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

v2: fix coding style

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 39 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index dad5f9722e14..f59e81be885d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -139,6 +139,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		}
 	}
 
+	/* from vcn4 and above, only unified queue is used */
+	adev->vcn.using_unified_queue =
+		amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
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

