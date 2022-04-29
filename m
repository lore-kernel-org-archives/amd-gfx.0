Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896B3C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEC510F2E5;
	Fri, 29 Apr 2022 17:47:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED4E10F23A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYrRc6pB6t3dC11+u8Xq8JlXOBZY6RveuAV+V5eryHYxcQ3lPZrKUh9MkMLYl2HImtP30Bpgrda4QgP0t4LdHuKjID6wdKlM8Z1dFHaKp1xEcCVaqUkiXs7mEkVoszt8BHdgJquBqpV1RSfL4cLs8B/g9en8towuq4TNfBn/bxmV/T2cI1c+fKxAHSOza0xzqUv55KskM5vehF14CaAv0YSQXEgzKOF4Lm3XBIhqEGNks0W2W5Ztx13z5nRtMeKMzYszGKsIriOjHmP4wyd2m4MP/Vv1r1lf9e6B5r+9c2B3MjGKtPHQzaTkLwm0mRBRHSjSp74kzWDe9c3fZUpTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDrRkF9eR7IS1b2+gEneTLMFlmtc9KV9TuDiBdNrCZU=;
 b=IDIG7hiWB6eemew501S0kuxE2ygxEDVg2vt7XdUn0qP/WuD59KYnq9MQ76uPUyB/a2AVcIcAPr5jcB4S0FprKcKURsEdSSBrO9/LeTN3XOZON94V/LJByVKj+b1c92fgqd4EAvO5f9Q/vw5tt45ZI4C/OWkCr07/u/ytC7gpp6sPv3rhJlhxwHnsDp/x8JVJ4CHiQFf2+1IvIO26X7QTSAXhlJPh41g3z9pYemR+FfZU/EKu4tibLXwbp9uwYFYbE+QNGVUUr8wnj5BX+dzw+1WRinhZtXmPrCnLw777QddwRfpsTd7jOUX3aqMb43gdnCW/Ixw0I7S8W4fuvtvlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDrRkF9eR7IS1b2+gEneTLMFlmtc9KV9TuDiBdNrCZU=;
 b=hfNiMfMUwcsJR1Og2bFq/N62LhL89hKs5SPLtwGBNTJ36QnNOc8SZaChn4jPZkodHTK7zMM94MGRcgTxJfNz56w41GYeuNFDY/mkOcaZFvzB+i3IrD/+MNLSR+k4Kj8EHlIgc11k4pc8hsJWnS9ZIYKV9RW5kFdpXgNIZgmGXHg=
Received: from DS7PR06CA0023.namprd06.prod.outlook.com (2603:10b6:8:2a::14) by
 MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:46:56 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::a4) by DS7PR06CA0023.outlook.office365.com
 (2603:10b6:8:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/73] drm/amdgpu/sdma5: initialize sdma mqd
Date: Fri, 29 Apr 2022 13:45:41 -0400
Message-ID: <20220429174624.459475-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 300342ec-b19e-4311-9ca8-08da2a0840a6
X-MS-TrafficTypeDiagnostic: MN0PR12MB6149:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB61491976DAE2D8DC37410BFAF7FC9@MN0PR12MB6149.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +H0QI+aIe52AZmEpoyPu+V6rQbpkoXADBD2D7ww7jdcc22Z9GnfqDWwmb+CxvMUG3zXmwDNBSrGrWiR304U0FBqqB0DWZufmMBjKdl7RgsegJFGCms8j06Luc1fzhnXvtgTJgJXoA2op4w1ylkK3Ql+5KWUwsppVR2HpUmr8OFuCGCE0PNdoxlQKprYhx+3BlzqCKKW7CBRd2GZIuyFGcndRdkFqto0Yob6ALMBclL7Vcb+0LDSOsvS1dXRDOP/Ab3Gum2XXpHcFBLCcJtrSFKpbpTZ+MqSj/QJBt6rWKtSmcDDBqfDg8Tal1QHrZLmgbet4Warnn5IOFCKFw7YLWFyYIgIzQtUVTjdr4OdKA9QBcVHr5gc5yxEG+Q4cZS5+b+TxNjjPwXeVP/QoignFoqeDuiJojG8G0T8wbQdpk8YNQCQfqQNThl8h1cKCfpSEbOh0YpdSdgXGNQDtypDyodJYNgkYHXDVfCH1SDANCDl2Sfulcz1tQ7KcQylNo9/o+fQg9Ykmai35J0NPuUqYq/JkhsqRU/6gAYiIE9olIfhOxjW/XL7DHb6k3tgWnjSC2oYEjA0Br141ec/M/aWR8LKuTWlbKRXUaD5z9YFapuaNEWTW3FG7Q7HK8r5z4mSKa5p+eiEHYBKgN/Kxu8zMcdG+VH9UMuNMItsqY9NrirlPM2vZzCWH9x4Ovns+FA8U+GNSiJuOPxoL+2MWeBJxxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(426003)(4326008)(40460700003)(1076003)(16526019)(186003)(356005)(66574015)(336012)(8676002)(36860700001)(36756003)(2906002)(83380400001)(81166007)(7696005)(86362001)(6666004)(82310400005)(6916009)(2616005)(26005)(316002)(508600001)(70206006)(70586007)(8936002)(54906003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:55.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300342ec-b19e-4311-9ca8-08da2a0840a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Initialize sdma mqd according to ring settings.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index ff359e7f1eb8..30d12c9df911 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -959,6 +959,49 @@ static int sdma_v5_0_start(struct amdgpu_device *adev)
 	return r;
 }
 
+static int sdma_v5_0_mqd_init(struct amdgpu_device *adev, void *mqd,
+			      struct amdgpu_mqd_prop *prop)
+{
+	struct v10_sdma_mqd *m = mqd;
+	uint64_t wb_gpu_addr;
+
+	m->sdmax_rlcx_rb_cntl =
+		order_base_2(prop->queue_size / 4) << SDMA0_RLC0_RB_CNTL__RB_SIZE__SHIFT |
+		1 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
+		6 << SDMA0_RLC0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_RLC0_RB_CNTL__RB_PRIV__SHIFT;
+
+	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
+	m->sdmax_rlcx_rb_base_hi = upper_32_bits(prop->hqd_base_gpu_addr >> 8);
+
+	m->sdmax_rlcx_rb_wptr_poll_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, 0,
+						  mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
+
+	wb_gpu_addr = prop->wptr_gpu_addr;
+	m->sdmax_rlcx_rb_wptr_poll_addr_lo = lower_32_bits(wb_gpu_addr);
+	m->sdmax_rlcx_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr);
+
+	wb_gpu_addr = prop->rptr_gpu_addr;
+	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
+	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
+
+	m->sdmax_rlcx_ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, 0,
+							mmSDMA0_GFX_IB_CNTL));
+
+	m->sdmax_rlcx_doorbell_offset =
+		prop->doorbell_index << SDMA0_RLC0_DOORBELL_OFFSET__OFFSET__SHIFT;
+
+	m->sdmax_rlcx_doorbell = REG_SET_FIELD(0, SDMA0_RLC0_DOORBELL, ENABLE, 1);
+
+	return 0;
+}
+
+static void sdma_v5_0_set_mqd_funcs(struct amdgpu_device *adev)
+{
+	adev->mqds[AMDGPU_HW_IP_DMA].mqd_size = sizeof(struct v10_sdma_mqd);
+	adev->mqds[AMDGPU_HW_IP_DMA].init_mqd = sdma_v5_0_mqd_init;
+}
+
 /**
  * sdma_v5_0_ring_test_ring - simple async dma engine test
  *
@@ -1289,6 +1332,7 @@ static int sdma_v5_0_early_init(void *handle)
 	sdma_v5_0_set_buffer_funcs(adev);
 	sdma_v5_0_set_vm_pte_funcs(adev);
 	sdma_v5_0_set_irq_funcs(adev);
+	sdma_v5_0_set_mqd_funcs(adev);
 
 	return 0;
 }
-- 
2.35.1

