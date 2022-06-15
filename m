Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A11C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 02:56:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE44D113800;
	Wed, 15 Jun 2022 02:56:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFAF113800
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 02:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GilMAJus+lgQEn27+8uWSll6VG8Ir0fOM+toAuKcPBs1rt3XJajVgUb2L56IN6RWHGNUT4XZ97X/xoGBTqF0QtPkImELMUNBNDdiyddOlUmInqIWVA5irb3QI+EcbpxzXGLZQFsh7OIaMDc71gcRl2iSn6NKytsv9GZdfF8CvYXX6i0c4MKSyOHi64rEtZ3O0JpzFFr4OHBURzdFFt68iw9A14fWA37k6MFwpMfAyHP1efMD3QxkbyuE53JJezc9gIIb+arQoKSQflxuwQa4lssVFf6qAd433Fp5gWPI6J0c3oWDK8MXdPNmCSP/vJKLu/IYFsdg42+odk6QSa9K9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYfhPz6BOyDA17x1+82VpUTb/GpekrOfoU0ySlDNxpg=;
 b=amave7W+w/56DMwOMAADPb90dcXF1Av1v89yiYoHKiJauX3biu0e57PwybqRp1R6H8HdyNN7HgurNVvjGaBvEeS3CVG/LAZWBtooxwcV8ioHwaxD+kl6tP4Rm9hjz2g1n3sjfRHLvhOp/YXF8hFjRvFVl3bbe223UTsy0OEuW+hvKC54RMR3seJAiUeO00yDjnNjl0a2lgSCRuRakhRLiW0w6b21WYZI+70jIHZNBRLl5sfXh6TplxZQ2Wfpc602vmsU5fno6iUa/0nuNcvnTmOZPWY7W5nOGbD3WWrzeqZYCz3jGDK+WvK7wVqyczlaZ2lLenYxyxIEwk84V9zk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYfhPz6BOyDA17x1+82VpUTb/GpekrOfoU0ySlDNxpg=;
 b=YZ668Th0UPCL6SZ5DMfrAnfZWOeiESw04wKS+xME2DUfqhe7ijF4zZEVjTCKlDEdsUi3Ve+e8Hdb040Z1JToyzhRGCu8ZREzxxV5frTJCfB6ypxIZHMln/92LnGKRUUk84pk0H8ya2SsF+LyD2IuXtT7K1utWb2ir8Gpawu4ehc=
Received: from DM5PR04CA0039.namprd04.prod.outlook.com (2603:10b6:3:12b::25)
 by CH2PR12MB3687.namprd12.prod.outlook.com (2603:10b6:610:2b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 02:56:35 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::48) by DM5PR04CA0039.outlook.office365.com
 (2603:10b6:3:12b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Wed, 15 Jun 2022 02:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 15 Jun 2022 02:56:34 +0000
Received: from ruijing-ubuntu-pc.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 14 Jun 2022 21:56:32 -0500
From: Ruijing Dong <ruijing.dong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/vcn: adjust unified queue code format
Date: Tue, 14 Jun 2022 22:56:10 -0400
Message-ID: <20220615025610.49839-1-ruijing.dong@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1415dc6c-cbfa-46ac-b359-08da4e7aa8a7
X-MS-TrafficTypeDiagnostic: CH2PR12MB3687:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB36872F44CC5914BCA4F94FEC95AD9@CH2PR12MB3687.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KczUXTrx/zcQsCJAFlSkn0bjsPqonrBcIzyrMd1vtgfOwQKqyAKTiU2tauCUX6j+NYsBFqM+bHfAufDxnU0ZY39rqh8N3UFUXkrdxIvmS33w4Ghus9ZoRLqdwvzaNg/NAjCZEMvOUC6PvdpT41MpG5Z3B1qnltSBZNnrIIK67eaF5TGmD+8B3VnPC8LiGiS5CavzJpkkCgNPGr6FbVg2wieWq55h2ydCjQH63H4LLYH9OS5wWqXzvD2AR2ae80n9CPXdb4FAtl1fvsbuVQPj1tcHwBFgBRNvOEkjeB8q/rmBM5L8tD3DBWwVPoe2mEVN9cutInZvTXqnUj2COwM0F58DIUPOUkxx/mnxXux2DvC4hcbJ8Wip/Z8RQuT2NPjL9aMbw5TeF0/FaBgcJYrq4VU4evzGEdJ8PCFfKgoV2rYmQs6XrWYFcuowaxHnIAYWHuMj3LAXJ+W4pso9A5V69svSbNX4Uz7GQlS/89qUIs0z8ojmx+vO1D/xWvxApJOQ9Ul51I1S5bvSyYdq5MakCOc69jRY0V2U1hT56rpjKLx3XIEy9qd7pUCtgYiUMEBfoEjnaC3CZBBLXVFtAUVxnseaLJU8Ps62zXIiHKo18BNgKK4nE+wLe0Po/uHiiyZwytThDqANjTDxSm9BMPxAHhmLjpk17vfLKtJS8z2oztpby0fLFWrrfstOpURmYtE0SLYYWcYyOxPIVI8/AJwIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(5660300002)(81166007)(54906003)(316002)(2906002)(82310400005)(83380400001)(86362001)(40460700003)(7696005)(26005)(6916009)(8936002)(356005)(6666004)(44832011)(2616005)(70586007)(508600001)(4326008)(8676002)(186003)(1076003)(16526019)(70206006)(336012)(426003)(36756003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 02:56:34.7792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1415dc6c-cbfa-46ac-b359-08da4e7aa8a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3687
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
Cc: alexander.deucher@amd.com, ruijing.dong@amd.com, leo.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixed some errors and warnings found by checkpatch.pl.

Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index e62ff7db4736..fea436023351 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -730,8 +730,8 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	return r;
 }
 
-static uint32_t * amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
-					  uint32_t ib_pack_in_dw, bool enc)
+static uint32_t *amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
+						uint32_t ib_pack_in_dw, bool enc)
 {
 	uint32_t *ib_checksum;
 
@@ -749,7 +749,7 @@ static uint32_t * amdgpu_vcn_unified_ring_ib_header(struct amdgpu_ib *ib,
 }
 
 static void amdgpu_vcn_unified_ring_ib_checksum(uint32_t **ib_checksum,
-				        uint32_t ib_pack_in_dw)
+						uint32_t ib_pack_in_dw)
 {
 	uint32_t i;
 	uint32_t checksum = 0;
@@ -790,7 +790,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 	/* single queue headers */
 	if (sq) {
 		ib_pack_in_dw = sizeof(struct amdgpu_vcn_decode_buffer) / sizeof(uint32_t)
-			                     + 4 + 2; /* engine info + decoding ib in dw */
+						+ 4 + 2; /* engine info + decoding ib in dw */
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
 	}
 
@@ -896,7 +896,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 					 struct amdgpu_ib *ib_msg,
 					 struct dma_fence **fence)
 {
-	unsigned ib_size_dw = 16;
+	unsigned int ib_size_dw = 16;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
@@ -962,7 +962,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 					  struct amdgpu_ib *ib_msg,
 					  struct dma_fence **fence)
 {
-	unsigned ib_size_dw = 16;
+	unsigned int ib_size_dw = 16;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d6f134ef9633..84ac2401895a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -120,7 +120,7 @@ static int vcn_v4_0_sw_init(void *handle)
 		sprintf(ring->name, "vcn_unified_%d", i);
 
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
-				  AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
+						AMDGPU_RING_PRIO_0, &adev->vcn.inst[i].sched_score);
 		if (r)
 			return r;
 
@@ -907,7 +907,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR, 0);
 	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, 0);
 
-	tmp= RREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR);
+	tmp = RREG32_SOC15(VCN, inst_idx, regUVD_RB_RPTR);
 	WREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR, tmp);
 	ring->wptr = RREG32_SOC15(VCN, inst_idx, regUVD_RB_WPTR);
 
@@ -1048,8 +1048,8 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 
 				dev_err(adev->dev, "VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
 				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-						UVD_VCPU_CNTL__BLK_RST_MASK,
-						~UVD_VCPU_CNTL__BLK_RST_MASK);
+							UVD_VCPU_CNTL__BLK_RST_MASK,
+							~UVD_VCPU_CNTL__BLK_RST_MASK);
 				mdelay(10);
 				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
 						~UVD_VCPU_CNTL__BLK_RST_MASK);
-- 
2.25.1

