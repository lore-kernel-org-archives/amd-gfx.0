Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A295CC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jul 2022 08:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C7A711BB39;
	Fri, 15 Jul 2022 08:44:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296B211BB32
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 08:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0JlInBtBAPO/xeQciwkP9pOg4otdNNNM8W6kXhDTAmXJG6dNNpIrugr5xW9jX+uvtvPWeivRTMVNp/l1N3fF/EvxVmFN4U0qXalvVsZ2ugIDTVN7sNqbHNtrOMwllYMFZtk9DwcU2YAdFQ/IhUJNq7y/b4fqLT2EcyD7fMCnoZrHxMBIinZz/l0l0AWHvTzRZndVq11djW2LJHhQOWBW97RVFtK8lfg1hoN7Z1LRMNJMyvMV466UWBRCd1FXc21n/RUUYCySC5HypSay4yEMAkdodUyIRQlOgix8T0h1UHnDgYGvqUla6TVQrsSM4Cby1IfP+a9/vzdt83sqNbm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q5PztLpyPfrjzk6fyrU4p7kpvVXqu3NdDhs31qtwlA=;
 b=KCBClEBrBkSfNvr9yuJSLGQr+oaSa4jW67AVLbQ1JgLHPRZEs5DXqzNuWWWeqGc+PtY2fV0EWnBLtUADL6++qSkBkwME56A1RnZOzK9WQHNb2+nh/EdGolUQcQsMEiEZGRUyThiMv260JIBwzDgsuFyCagudwEVQPz+43j5AXU+Je/HESDEI961zIco0N+megioggtX2Sob+zqCrI3q7GoEhqjZBz1uqNhipTawGuTT8Zto8vOgi2IPNtJKM95MONfRwagv51hRDUeEOMfSkpVsaNYFxT+bIqBs4GjqciqPOgZc+iDbpB9U9julLNuv5haCnIgmcSl6rQ9cftT/LOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.helo=satlexmb04.amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q5PztLpyPfrjzk6fyrU4p7kpvVXqu3NdDhs31qtwlA=;
 b=cqASHmVc2qtj4j9t1mJzkWYHoOMdrPd+WuJ9+nDX1hNJz8wki0/ye6WiBqjZ/VJGSHs0/5nY+XTSOSPPQG3meGIjGaNIlgVtgVgXPqo/vme9dAy6BD2xKEMI2i0KAwNzM0N7sjtSnFxbghHU9pXfGjYZP87wlW4OapGkfkeoglY=
Received: from MW4PR04CA0109.namprd04.prod.outlook.com (2603:10b6:303:83::24)
 by MWHPR1201MB2543.namprd12.prod.outlook.com (2603:10b6:300:e2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Fri, 15 Jul
 2022 08:44:38 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::70) by MW4PR04CA0109.outlook.office365.com
 (2603:10b6:303:83::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Fri, 15 Jul 2022 08:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.helo=SATLEXMB04.amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: None (protection.outlook.com: SATLEXMB04.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 08:44:37 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 15 Jul 2022 03:44:35 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add mcbp support for sdma v4.0
Date: Fri, 15 Jul 2022 16:43:55 +0800
Message-ID: <20220715084356.427458-2-Jiadong.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715084356.427458-1-Jiadong.Zhu@amd.com>
References: <20220715084356.427458-1-Jiadong.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 889f4cbe-7ec2-4def-dcca-08da663e404d
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2543:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gupm1nWv6Lfy/sCfdSSnf/smMxdYdhw7PVPlv3LgG60NS7u7bXCjp1meeuALuGl+7DX5Tslx7b57kUJCNNNp8DVElhJmMdzuUdt5NIzzBJxPIPwItXKGVhjzzqtWbP1kX5cFOEKGatxZ91d/M9Y7wHZI3yZ8LlZyCVU44DEjgxyUftSLKoDwRvGNPXbGdTZfAZpxY0vTZbHSyi+Dj40MTLcS8wI8Fn637lDQgO0vLmWHpFUDYIeklJrvNZ3Ukn9GVGrThNKCA5qtTt79s9WQqOpBqhzC3HSqXYFdc3O56gPwevwcOhjnMLBFcu1CKDgc5LZZYfwPvr+ceEDeYoryqa4HfwCNncJaxgiN5aTUoA80fsukIdwNhdvF/aOmgMdQ4LiUwRd/GFuTEBQkPNqxYjpk83ULPr9aRwXT7l3YcrRItmA9f1VNZI3BZLOuV+1tF/j0coRL+UDZP2Un0lgvQg1GxGRcMQnDEppwBjKZfkENEawX0gsmc3CZFhDwFtj2xotml1khUiSI1+wNAq7H/Gq/ZCZEYuHrh6IhCFe0brD6n1xAPT+QBvZwcSNLu2NBvbfRbMrrxEAWGVL9bq3a83HfxiFyyxVd4epjWjRP7aLfsFhKunCIomUnIM7aYUqvlP4jLxLpzJt4+6jqgQ2PwOluXxYSnhR7eryCylxSHNJEzfXIisxOfZox/g7Pjj/8K52sXm2ypaZifEHnuIjU0r4gf1HEnrrl9TD9T+MWV5jBIeblhKISByARX4R/qX+fNdDY2RWDObQgK4dXz8RBc2yvG10fBGqyBlnr1QOVyjzzVOPqn9ayjkgeD9sBa+wf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(40470700004)(356005)(82740400003)(426003)(35950700001)(42882007)(336012)(47076005)(40460700003)(81166007)(1076003)(36756003)(4326008)(78352004)(70586007)(8936002)(40480700001)(70206006)(16526019)(316002)(5660300002)(2906002)(2876002)(41300700001)(8676002)(6666004)(7696005)(2616005)(498600001)(54906003)(82310400005)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 08:44:37.7321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 889f4cbe-7ec2-4def-dcca-08da663e404d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2543
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

