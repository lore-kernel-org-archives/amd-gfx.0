Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8FCC19F2D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Aug 2022 09:19:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E2DCCD39;
	Tue,  9 Aug 2022 09:17:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666CCCCAFB
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Aug 2022 09:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEyZNCkRyjaktzkulaY/hD4/cp0SIdc2fYE3yt53HB4M8JFL8/O2yVylYj4L4Tzq/JF6WYkR1s0nAY7huGAE//+dkGuwLewtkT2Se4XM+9CxFRLwPkp97uZ/Bo4GIPY+oLlho10vgR9kPZdagd6jZGKFiBd/5C9eVFboetsSCAVKts6Rg1FKZI4Q2HBKkdUuAD4u8DY96JS5V1ym8A0Im/H9Um2xA3T5CxdmIEvds6YKcP8nWZsB9XKLIVsWTonk4CE9TmKTst2nGL5T0hksdPLb5/wXfan8FUjfzEqodMZR9kNLlN6CxnHObOZlOs+Q253R71QGe17V1hzQNTQPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q5PztLpyPfrjzk6fyrU4p7kpvVXqu3NdDhs31qtwlA=;
 b=EriqE1F3UjPqnnGWKlymEilYU5UPFmZsb+YI+K7Qx6EcyunlfwLVxPJKaq6zTWPSBLp7OIClYUJxJ73cvYqoTBOVJjEhyH8+HN3iAUQHlLP/pIuqFCyoOrHoidxhJup4tkaTJaz/sHUXjLThfj17M0PsfwVtk1KytCf0j9GdFW4AxycKAyypXScQ883Vyr4QlrCKqg+wCdIUSU0NXoI1XvmEvKX2q1/lHWiFGP2MjubLip5j9I8anykwybqJhAZVdwReFzUFTjR8t9bhd2tTpkxYmPzIVWGGLmaMe+IUYe9l4QtnQMrz7IGUCym1dg/sYgsI4Ds0SNSvuvcmK+jXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q5PztLpyPfrjzk6fyrU4p7kpvVXqu3NdDhs31qtwlA=;
 b=A+boWySlDanlq56C6ZgCMd9XeEFGrnmrnwTjLDGnY+VruwSCXbuVMnEq0hGsHxWFsRWnYbGbpivQbohpbQ1LDFjWnflLFMkT0NgYj9LE8VzPefzCJIaXZq9ddzHqNIMzyeaNddOwml2fibDx1nkZIWrTykeCvF8qTYPB2oUQfcg=
Received: from BN9PR03CA0098.namprd03.prod.outlook.com (2603:10b6:408:fd::13)
 by MN2PR12MB3471.namprd12.prod.outlook.com (2603:10b6:208:c8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 9 Aug
 2022 09:15:27 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::2b) by BN9PR03CA0098.outlook.office365.com
 (2603:10b6:408:fd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Tue, 9 Aug 2022 09:15:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 09:15:26 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 04:15:20 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: add mcbp support for sdma v4.0
Date: Tue, 9 Aug 2022 17:14:48 +0800
Message-ID: <20220809091448.958375-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220809091448.958375-1-jiadong.zhu@amd.com>
References: <20220809091448.958375-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b0f898c-51b0-412c-9930-08da79e7b2cd
X-MS-TrafficTypeDiagnostic: MN2PR12MB3471:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ew4u9cm8ZfX4w43IkhPy0OZVpl2bcqIdQcB9BhERs+RkurmBsiVppCRyr6y+iHmkYk2J+f03W+YwIYI/W9Ya8pZbHZXlVx5ZyarK3rLgzKmQUmje8DVqm9+/AV+yyUQtKjg1OpOz0KV722dz/T+6oYaraba7l6PnRRe538EHAlcX0t6hB/7RyCtheter4rNzda9YQdSVhra1lu5BJ/UGPSJFdXiQY5AuMkLaKkcjBTKFSrjxMcv/FMqQOi+EjqniyfFS9UFcZekKtKNsrCOkeyZmuFxikzkROgW8NYOA5Iw6iT5aqtJEQeZqLnMmYuxr0ps0on48ZTmcfav6PXUBB3GsPdIkCGODEAFrafwRh++1Su3tC0Nkm3k3NQuBD5gLCMoWQT8soljtyhC6yyXIxrdA3Ri+LJf/4Xawf1/ZWpy3IAseVewYavWjalRP11l8WMRuyG6cPpXmouYt/uVwdfFAetqDNLmNEmCivXHNjgskWVdpJ0WggV8oW/Hvg9Qoybj7YTr77oJih3CcUXabLBFbKxt2HucY1FMv0wMwer8PeTy0EEzFI7K7OVvwMshZZzLoH/5j99I5XAN5vGndNapQgfe8aS/BUiJNVl0YkN2jLWkUOhF1nDQd6MaXy+G4Z3JiXBbgYbwYrV839E/713W1c2aTgpU54DPdwe+l2+iUapwlMLN3mILBev7sPhZAmmmsZCFzFS9j/a4sJ/H+1RN557Ze0Y52CnxBX9xW1m6mbDW4JoSrBWYKk66v+W0u6a1IP98tnW021sOo7j+A9BJr9zkWgmEtVasxNlu+maxQJ5UXTKoho5LmrmzgalqzVU0kYbVyH2r80I9BoefSCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(40470700004)(46966006)(36840700001)(336012)(186003)(47076005)(16526019)(426003)(1076003)(316002)(6916009)(26005)(41300700001)(6666004)(7696005)(86362001)(82310400005)(478600001)(2616005)(54906003)(82740400003)(40460700003)(81166007)(356005)(36860700001)(8676002)(4326008)(8936002)(5660300002)(70586007)(70206006)(2906002)(2876002)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 09:15:26.9946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0f898c-51b0-412c-9930-08da79e7b2cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3471
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

