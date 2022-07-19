Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F42C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 02:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE4911AC19;
	Tue, 19 Jul 2022 02:09:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E981211AC08
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 02:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFEKSZcpM2+VL+tXPu81zv91tGhojZ616asW7EjbcOVQE3AQXhYrG228SbTrJ5VB0A/nh3AwjtpmJxPnxPv1BMBRMpowaYeBRgIgMnoFrsw+YqFUN0gKJoYI9ZL3uq7ystF1lYZKTIo53sZvy0uXN7ezx0LkLy7OVS6XIiGHou8jkI/5RI0I4MWvS+WcdQ2p3valapsgldvQAeIM80P6Vnl/sZjFDWosOovs7iVUg084kbabu3Mw91yTjDJqMCbtbfSQbLuDCzGtlLouZolazJmlt61KoI5Q/WwDHvrHyBjqVoKZLbe1InfaSYacg4M9tAZnI/brI5Sk826UU4ndIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q5PztLpyPfrjzk6fyrU4p7kpvVXqu3NdDhs31qtwlA=;
 b=NB/Vekd1HqOaTlQ3UCVtGObpRN9Pg1sxIGZPZn2KotUo+hHPCrCNbFDFxBxIqhDIQuHihPnP8TnPv22CKDbjJbj9tKbTPrxoVkrCo4LWKCnQ7kx+4u9eaoyYuBzD55B99UTBCjlIEO9+YSoge41WBiGf2efi3z5c3N2G1SEUD60OYgnn0EdsQn7VEiuZknlDKgm9axn+NkecA6qsFG/vFDT5tO1vJBJPu6jSwkqnp36aJ1sfE0A0UPUMI6JR1O+8CfMG4mgVv3gsr2W8yVYWICuejDtD9f9ren4YvLVgYaHRbORCCzB81wOrQSYImqu1DApZck82Yn0sugVi+DjO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.helo=satlexmb04.amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q5PztLpyPfrjzk6fyrU4p7kpvVXqu3NdDhs31qtwlA=;
 b=ScKEfG2YJXy9D0JmcpvS3BMUmTxxOGfFKTpp3v0t4ROt1Tj6Htn3jVRywKeKsc1uVeFHW+gjCp465dFG8SvY1EtR9J2RgbalHEzvih0HSt0PET7tNKpyn/EjSc/13qlDPxWPY1OPOrCknirsXcVHPboCaupR49I1jXotmZqxr88=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by BL0PR12MB4657.namprd12.prod.outlook.com (2603:10b6:207:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Tue, 19 Jul
 2022 02:09:38 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::fd) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Tue, 19 Jul 2022 02:09:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.helo=SATLEXMB04.amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: None (protection.outlook.com: SATLEXMB04.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 02:09:37 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 18 Jul 2022 21:09:35 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add mcbp support for sdma v4.0
Date: Tue, 19 Jul 2022 10:09:18 +0800
Message-ID: <20220719020918.410753-2-Jiadong.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719020918.410753-1-Jiadong.Zhu@amd.com>
References: <20220719020918.410753-1-Jiadong.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67488f65-aa96-4e15-c680-08da692bbb88
X-MS-TrafficTypeDiagnostic: BL0PR12MB4657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAQdDr7Uw6sNzk6r9cBjkWH9yXWu6x28FWl0CNThkDyT6Di1b2wMG09fxM0+9Ltq1H9dc8uYDizSJyKIUA+ozp+fd4o7Q8SvTZQPg8j/V+QSz3wrGX/FFTZRV6utC1bmSYqoggRU5yKruMEiqIYR2jKqhtFz5joNVU4TZmEEbl0NBCbQocwkBmjcGvbkW9ZrfJlZjujr29EftjyGJgbWo53ocNbNDUxIXGauvyHyDvjpZpyy9V+Ae2OelLJX36aNJaIyJWtxuzuPLISvT8vCAc7WM1T2J+eYGNMgsnVAfHYWbawDV4+80O9sSHnla+ngfEeaAgfWBq52eh4hRaMzJlVAqNgfrbmjSkk6k7yVghUIvzSD2g5hEtr915DwM0GbauD5iaovx+EJViABDzrprbXX+Uunv0BW4tTvIWP34a1Le6cNXMiLpf1YlQwTEUB+3V7xmrBYbNH6yS/dXANQaCIzPLfla5PJgPzg9b1iP2yRqgZ2bJRyKO2nhj5UryvP8cLzSNeHGw14KtQJUJR/YS2FQL89wb75fDQ8Oaiq0zH6U1xUl3smR6Jf+a6T880DBkic2ICOamVs7ax1mqY3Dw2B4WLj9J9tO8RWWbRUDcoTyvsbks16L1ZavSJwJ39PCIffwT/+16hHEiwLMLjXLPadiIrgJAsqu50koeDxU2vh8oxxtzFwtm4WCBB6gHNEDgKdjUbpqFUE9EL9q02105L/7PGZqeB91ypA37Abo60L3bPQcxDcUGnG1/ilCDC/KX20y95Z1wZUUgSiABPpXT9Y2MmxQSq7IXujyCIwWXL6cOGQ5713ADZyLbAQyo5v
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(40470700004)(1076003)(70206006)(78352004)(2616005)(356005)(70586007)(41300700001)(6666004)(36756003)(6916009)(4326008)(426003)(82310400005)(42882007)(54906003)(498600001)(336012)(8676002)(16526019)(35950700001)(47076005)(316002)(40480700001)(81166007)(8936002)(5660300002)(2876002)(26005)(2906002)(7696005)(82740400003)(40460700003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 02:09:37.6222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67488f65-aa96-4e15-c680-08da692bbb88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4657
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
Cc: Ray.Huang@amd.com, "Jiadong.Zhu" <Jiadong.Zhu@amd.com>, aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

Set register to enable mcbp according to amdgpu_mcbp.
Add sdma preempt_ib function used for debugfs test.
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 53 ++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index d35f18536da2..bc69af4b4ada 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1502,6 +1502,11 @@ static int sdma_v4_0_start(struct amdgpu_device *adev)
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, mmSDMA0_CNTL);
 		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
+
+		if (amdgpu_mcbp){
+			/* enable MCBP */
+			temp = REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_ENABLE, 1);
+		}
 		WREG32_SDMA(i, mmSDMA0_CNTL, temp);
 
 		if (!amdgpu_sriov_vf(adev)) {
@@ -2102,6 +2107,53 @@ static int sdma_v4_0_soft_reset(void *handle)
 	return 0;
 }
 
+static int sdma_v4_0_ring_preempt_ib(struct amdgpu_ring *ring)
+{
+	int i, r = 0;
+	struct amdgpu_device *adev = ring->adev;
+	u32 index = 0;
+	u64 sdma_gfx_preempt;
+
+	amdgpu_sdma_get_index_from_ring(ring, &index);
+	if (index == 0)
+		sdma_gfx_preempt = mmSDMA0_GFX_PREEMPT;
+	else
+		sdma_gfx_preempt = mmSDMA1_GFX_PREEMPT;
+
+	/* assert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, false);
+
+	/* emit the trailing fence */
+	ring->trail_seq += 1;
+	amdgpu_ring_alloc(ring, 10);
+	sdma_v4_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
+				  ring->trail_seq, 0);
+	amdgpu_ring_commit(ring);
+
+	/* assert IB preemption */
+	WREG32(sdma_gfx_preempt, 1);
+
+	/* poll the trailing fence */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (ring->trail_seq ==
+		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		r = -EINVAL;
+		DRM_ERROR("ring %d failed to be preempted\n", ring->idx);
+	}
+
+	/* deassert IB preemption */
+	WREG32(sdma_gfx_preempt, 0);
+
+	/* deassert the preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, true);
+	return r;
+}
+
 static int sdma_v4_0_set_trap_irq_state(struct amdgpu_device *adev,
 					struct amdgpu_irq_src *source,
 					unsigned type,
@@ -2435,6 +2487,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_funcs = {
 	.emit_wreg = sdma_v4_0_ring_emit_wreg,
 	.emit_reg_wait = sdma_v4_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.preempt_ib = sdma_v4_0_ring_preempt_ib,
 };
 
 /*
-- 
2.25.1

