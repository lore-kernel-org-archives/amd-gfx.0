Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54BAC3F2D6
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DD624695
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 09:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RoHINNf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DD624695
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478DB6E1EC;
	Mon,  2 Mar 2020 09:22:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 958FC6E1E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 09:22:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3jeLMbXdpM1LoarXbJ/1cFs16W/RWREwlwl2oDG/dL/p3pE2czYwWCaPCBLNn1o0W2sGPG9FdyUfbXG5NowJV8YchNXcBfMh168aNvsCeqqmUwVs6XjHweTsFIjA1WDP6I0C0CGnEpUr0tbUmZwGfOsN2XTcWMFNaCNjLeLdL9sxIEkxn6qJxRI/dblC2/DBixGgkK2nS+rWslNvWzb3DPv5nAAi/sSgBVY1KUy3KYPr0jjwogH/8+0u6c+gL54jlYKV6kZgIZfnCiyI4D15AJln0b50ZRRo4i4TJheTG2iZARbj/kHiJU9Gtdcg4nYfX/uV2L+YCy3gnFmgVl15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzAJFYOsMfQaqhXoADZED1u3XEirkZmTXVLQVSQg2K8=;
 b=FEQsKRMcmxO631wl3aF20hvP7lakUYOyqGoxY41+j2KtEvH8oBgZtgn1ltE0ULRnwW+p95noQhgShrKJivUevsP5fu8OxtUn1txEjRPoIkWrpf9eL2IoqjmnqshX4jdKfmEq5rgxev+SPmsg23cEj765XG4nwwKj7P98Gg+cbSg/BWh11m7peVLRylL335/sjQBb2wKKAHbqUj06JjTOPLxNbdNqVIFYo7T3I5BKUa4IsVDWq7o06s3jbwLGv3hjqkRswAQjXmV2FTSB8nnNtN1WcsPAZaQLyLc4Aj9qdReDiiMmN3wqmte8HO96WL8Dy/5U2ljkIJDH/+rvUClRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzAJFYOsMfQaqhXoADZED1u3XEirkZmTXVLQVSQg2K8=;
 b=RoHINNf3VijKgbwLrixtSh6NR58ynpUjJcSELem35S9GOZIgCb74N2e3CxgY2ecmBdk7gii8X+WBAkOCsleUtIBfB3cDXj3CQGt7SuM6UkFIyC02BhV2kFhFcw3XiMXPcu8F+RoyqMw7G9YXy5ltSaEVv6kXJ4RbdTA2qFDope8=
Received: from BN4PR13CA0020.namprd13.prod.outlook.com (2603:10b6:403:3::30)
 by MN2PR12MB3070.namprd12.prod.outlook.com (2603:10b6:208:c1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 09:22:15 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:403:3:cafe::bb) by BN4PR13CA0020.outlook.office365.com
 (2603:10b6:403:3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend
 Transport; Mon, 2 Mar 2020 09:22:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 09:22:13 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 03:22:13 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 03:22:12 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: stop using sratch_reg in IB test
Date: Mon, 2 Mar 2020 17:22:07 +0800
Message-ID: <1583140927-19809-3-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
References: <1583140927-19809-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(428003)(199004)(189003)(5660300002)(70206006)(70586007)(36756003)(316002)(4326008)(478600001)(86362001)(7696005)(8676002)(6916009)(336012)(2906002)(81166006)(26005)(81156014)(8936002)(186003)(426003)(356004)(6666004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3070; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da42c9af-53e5-48fd-61ec-08d7be8b31b6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3070:
X-Microsoft-Antispam-PRVS: <MN2PR12MB307096B808D2466B6671C2A884E70@MN2PR12MB3070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCYmaklkmCUwziTrGsjUHtQnqsEBWi0wo4aeWnbqj7e4ktioyI7qfQQ6kUz/mXv4MygKVxGNB9FrhMPu5+zBhvcZIFPRvRCNh8Rv1Lwidh5rpvLlHOBHPZHTH0QNLTOp/mDT6EbKDNu22KXOIsxjersknlvjx5ks+NwgOz6QKApQHzpCzWSFon4JuVGQvHdKsFswdLuTJDLwqs9dkdvQ0XlrR35D3nKLMuXOUrpdOdGgbrf9vClFh98DR8jNcy4oFguvpA1q1iZpjr/4Qm1ziZtHykKN7o4JLepdIW/9KdN481qAbLg2QVBT0UTwYChUbb9LyHUr3ZMFSAVxQeE30cXuEHqTC0twlvt3K/StYsPzbu2U/GRRcJvElKsUIujgbn1TFCxfVHcEPn3pUlvT/k8uhbdGDJL6m6usvEoD19EatcrLECvNmTFTutqDBV3E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 09:22:13.9562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da42c9af-53e5-48fd-61ec-08d7be8b31b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3070
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

scratch_reg0 is used by RLCG for register access usage
in SRIOV case.

both CP firmware and driver can invoke RLCG to do
certain register access (through scratch_reg0/1/2/3)
but rlcg now dosen't have race concern so if two
clients are in parallel doing the RLCG reg access
then we are colliding,

GFX IB test is a runtime work, so it is forbidden
to use scrach_reg0/1/2/3 during IB test period

note:
Although we can only have this change for SRIOV, but
looks it doesn't worth the effort to differentiate
bare-metal with SRIOV on the GFX ib test

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 38 +++++++++++++++-------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index afae4cc..b86a531 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -500,29 +500,28 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_ib ib;
 	struct dma_fence *f = NULL;
-	uint32_t scratch;
-	uint32_t tmp = 0;
+	unsigned index;
+	uint64_t gpu_addr;
+	uint32_t tmp;
 	long r;
 
-	r = amdgpu_gfx_scratch_get(adev, &scratch);
-	if (r) {
-		DRM_ERROR("amdgpu: failed to get scratch reg (%ld).\n", r);
+	r = amdgpu_device_wb_get(adev, &index);
+	if (r)
 		return r;
-	}
-
-	WREG32(scratch, 0xCAFEDEAD);
 
+	gpu_addr = adev->wb.gpu_addr + (index * 4);
+	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 256, &ib);
-	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+	r = amdgpu_ib_get(adev, NULL, 16, &ib);
+	if (r)
 		goto err1;
-	}
 
-	ib.ptr[0] = PACKET3(PACKET3_SET_UCONFIG_REG, 1);
-	ib.ptr[1] = ((scratch - PACKET3_SET_UCONFIG_REG_START));
-	ib.ptr[2] = 0xDEADBEEF;
-	ib.length_dw = 3;
+	ib.ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib.ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib.ptr[2] = lower_32_bits(gpu_addr);
+	ib.ptr[3] = upper_32_bits(gpu_addr);
+	ib.ptr[4] = 0xDEADBEEF;
+	ib.length_dw = 5;
 
 	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
 	if (r)
@@ -530,15 +529,13 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
-		DRM_ERROR("amdgpu: IB test timed out.\n");
 		r = -ETIMEDOUT;
 		goto err2;
 	} else if (r < 0) {
-		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
 		goto err2;
 	}
 
-	tmp = RREG32(scratch);
+	tmp = adev->wb.wb[index];
 	if (tmp == 0xDEADBEEF)
 		r = 0;
 	else
@@ -547,8 +544,7 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	amdgpu_ib_free(adev, &ib, NULL);
 	dma_fence_put(f);
 err1:
-	amdgpu_gfx_scratch_free(adev, scratch);
-
+	amdgpu_device_wb_free(adev, index);
 	return r;
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
