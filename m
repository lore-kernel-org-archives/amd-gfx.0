Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25C4C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5D510E910;
	Tue, 28 Mar 2023 15:14:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D5710E915
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3HFBFtCazie9y7fs1LWKoLuj2aZmbMIHU0LEnZnGTxdaN27RZiMbqeW4PRp/yHiYrnr2d3KaTx3M9wq20bqnvfDgNz3X1vdjH5sPxtZS3iuF3TrWHFpUcviyUscll0h/pkvYSWldwuCj/yi8cKFgx3X5cuoxTrbIt6shSbVg1D5HL6vxvqhSYPcXTnilU2wghDBHJMzVstBlvHNxJOVwYQvgueF2tDXm332fScen1tlC4uHRMt5l+7zrE3gx+/k49o2ojNFYKKC05YD9uLKV3B1pzKhzSs2hFtnVoPPE9btEnm2F+j4obTmYwzr5AtmRp7/j836tHufb3xpTVRyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D8gyblr/Nk2ShPtMZOOX/8rYAuavEGUqiIX3nAMFYE=;
 b=EKCfrsqFIMGZeWbJbnK4g/Gjt7IrwHGdze7v2xzWgFExU8/+M2z2N4rq9ZRyK4tIXZuGlLF/5/kXtOtEOutJjiWJ8AHG7JrSZB61LTFbmA7pXW0ovjd/6liPAyVgivunDH6zZPxlwaUBZh2+XQuYS/ltZ05RdtL6u3OmEDo8CEuvn2x8UepBFOs1L9HlgZcdXj8UZXmdeX8mkxzA6QdPf89VMHBycPJVXZ13GnSzSl1XQs5thrutsp70xfYRGvIMDWMkOlCOPKUXQ2hIvXQkSZIqZUKpk1xb0A1ZHKbvDI3dxtmHx+61ysE4LaXdUrSsC3kxrlmYBmqWx3lq8YDz8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D8gyblr/Nk2ShPtMZOOX/8rYAuavEGUqiIX3nAMFYE=;
 b=xkJ6BR/nTbOLQo4h9Gn1Xe8dxFh8OGaWa30tLy5+HSOrxuwV6YutGIvd7WYr4pLePX36IM5UISZvJRqNyzz5lMYKF7YJNU8GYYMEsdW3gdCegfG++HVAX/4U8t5rcTvnowRHN5tWS9Ym0s4xGVS8jGZ884Z09FpR3LgDq5rQhWQ=
Received: from BL1PR13CA0087.namprd13.prod.outlook.com (2603:10b6:208:2b8::32)
 by DS7PR12MB5863.namprd12.prod.outlook.com (2603:10b6:8:7a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Tue, 28 Mar
 2023 15:14:39 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::94) by BL1PR13CA0087.outlook.office365.com
 (2603:10b6:208:2b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Tue, 28 Mar 2023 15:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:14:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:14:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/32] drm/amdkfd: Update SDMA queue management for GFX9.4.3
Date: Tue, 28 Mar 2023 11:13:28 -0400
Message-ID: <20230328151344.1934291-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151344.1934291-1-alexander.deucher@amd.com>
References: <20230328151344.1934291-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|DS7PR12MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e40a127-c9d0-47fc-15e5-08db2f9f269f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPgPo/97LvAnpxMWScuiFOyt7AEXxFe05aPotR63EFZBaHDudipR8WuxBgUZIwnhop31oH1JDbc9c2pZcr4NjX+WhO1EjOogw8j0Z/KpPTwWFwILNIttQiCT3Bh4lJPsBJcXRnUeonPnet0v3KeD/oQPBRACfI62h2rY9m21QfhwucI2VgBoh3vBz5RsEFW9BFWkDd3aly0ci5V5+ijwwd9NeLZtXfp0izi8P8W7xrgO5SEgbSo785zN5YKwDdkqVLdwmV2+LW7n0oACXdyzAzbP5LKw6vCZoipRaZkWp7PN5HwUKcdE1XsZe1CVt2MxBt9Ikv3UD+aivDx9DcJ4KMUhptXZu18tQD+XCzm3danGSTDReQRphEHgn/X0oLZoHc/aJzhSkQEWtOswssiF4cKLgQtWMVHiV62st+758qpwN9vgyKoGgQLN3x6yd525+vJr+y9e1TMKPhveXw66tHpEaUcfJ0IORySoHYII3c07g0EnJspqGT5sQn1JsLCWg5NF3J0zW45AGloC7D90RBiPPyl3TjFh9yx/yPQ5O2kDep4x+9UHgIyrHwIunB79zKBgF4jVSKgq3agI9n7MtQ/HOPOvbccq0gvprbBcfyUphCA0qsRjdwb3c161gceP3/poH9f1Ix1WGnKwxsFzYSooDTu7u+X3/oPzLoqyvvyvXlG6Hs2nnk6VgKotCW/ALbs8ABxmZX9X5sA075UNvzCWARydP/x/iEKu2Ip3qWQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(81166007)(66899021)(36756003)(82740400003)(356005)(47076005)(40480700001)(86362001)(26005)(336012)(83380400001)(16526019)(6666004)(426003)(70206006)(186003)(2616005)(82310400005)(316002)(30864003)(36860700001)(478600001)(8936002)(8676002)(40460700003)(70586007)(6916009)(2906002)(41300700001)(5660300002)(1076003)(4326008)(15650500001)(54906003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:14:39.6854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e40a127-c9d0-47fc-15e5-08db2f9f269f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5863
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

This patch updates SDMA queue management for multi XCC in GFX9.4.3.
- Allocate/deallocate SDMA queues from the correct SDMA engines
  based on the partition mode.
- Updates the kgd2kfd interface to fetch the correct SDMA register
  addresses.
- It also fixes dumping correct SDMA queue info in debugfs.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 194 +++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   8 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  59 +++---
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +
 5 files changed, 227 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 49d8087e469e..e81bdca53f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -31,6 +31,192 @@
 #include "oss/osssys_4_0_sh_mask.h"
 #include "v9_structs.h"
 #include "soc15.h"
+#include "sdma/sdma_4_4_2_offset.h"
+#include "sdma/sdma_4_4_2_sh_mask.h"
+
+static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
+{
+	return (struct v9_sdma_mqd *)mqd;
+}
+
+static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
+					unsigned int engine_id,
+					unsigned int queue_id)
+{
+	uint32_t sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, engine_id,
+					regSDMA_RLC0_RB_CNTL) -
+					regSDMA_RLC0_RB_CNTL;
+	uint32_t retval = sdma_engine_reg_base +
+		  queue_id * (regSDMA_RLC1_RB_CNTL - regSDMA_RLC0_RB_CNTL);
+
+	pr_debug("RLC register offset for SDMA%d RLC%d: 0x%x\n", engine_id,
+							queue_id, retval);
+	return retval;
+}
+
+int kgd_gfx_v9_4_3_hqd_sdma_load(struct amdgpu_device *adev, void *mqd,
+				 uint32_t __user *wptr, struct mm_struct *mm)
+{
+	struct v9_sdma_mqd *m;
+	uint32_t sdma_rlc_reg_offset;
+	unsigned long end_jiffies;
+	uint32_t data;
+	uint64_t data64;
+	uint64_t __user *wptr64 = (uint64_t __user *)wptr;
+
+	m = get_sdma_mqd(mqd);
+	sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev, m->sdma_engine_id,
+							m->sdma_queue_id);
+
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL,
+		m->sdmax_rlcx_rb_cntl & (~SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK));
+
+	end_jiffies = msecs_to_jiffies(2000) + jiffies;
+	while (true) {
+		data = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_CONTEXT_STATUS);
+		if (data & SDMA_RLC0_CONTEXT_STATUS__IDLE_MASK)
+			break;
+		if (time_after(jiffies, end_jiffies)) {
+			pr_err("SDMA RLC not idle in %s\n", __func__);
+			return -ETIME;
+		}
+		usleep_range(500, 1000);
+	}
+
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_DOORBELL_OFFSET,
+		m->sdmax_rlcx_doorbell_offset);
+
+	data = REG_SET_FIELD(m->sdmax_rlcx_doorbell, SDMA_RLC0_DOORBELL,
+				ENABLE, 1);
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_DOORBELL, data);
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_RPTR,
+					m->sdmax_rlcx_rb_rptr);
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_RPTR_HI,
+					m->sdmax_rlcx_rb_rptr_hi);
+
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_MINOR_PTR_UPDATE, 1);
+	if (read_user_wptr(mm, wptr64, data64)) {
+		WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_WPTR,
+			lower_32_bits(data64));
+		WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_WPTR_HI,
+			upper_32_bits(data64));
+	} else {
+		WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_WPTR,
+			m->sdmax_rlcx_rb_rptr);
+		WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_WPTR_HI,
+			m->sdmax_rlcx_rb_rptr_hi);
+	}
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_MINOR_PTR_UPDATE, 0);
+
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_BASE, m->sdmax_rlcx_rb_base);
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_BASE_HI,
+			m->sdmax_rlcx_rb_base_hi);
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_RPTR_ADDR_LO,
+			m->sdmax_rlcx_rb_rptr_addr_lo);
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_RPTR_ADDR_HI,
+			m->sdmax_rlcx_rb_rptr_addr_hi);
+
+	data = REG_SET_FIELD(m->sdmax_rlcx_rb_cntl, SDMA_RLC0_RB_CNTL,
+				RB_ENABLE, 1);
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL, data);
+
+	return 0;
+}
+
+int kgd_gfx_v9_4_3_hqd_sdma_dump(struct amdgpu_device *adev,
+				 uint32_t engine_id, uint32_t queue_id,
+				 uint32_t (**dump)[2], uint32_t *n_regs)
+{
+	uint32_t sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
+							engine_id, queue_id);
+	uint32_t i = 0, reg;
+#undef HQD_N_REGS
+#define HQD_N_REGS (19+6+7+12)
+#define DUMP_REG(addr) do {				\
+		if (WARN_ON_ONCE(i >= HQD_N_REGS))      \
+			break;				\
+		(*dump)[i][0] = (addr) << 2;            \
+		(*dump)[i++][1] = RREG32(addr);         \
+	} while (0)
+
+	*dump = kmalloc_array(HQD_N_REGS * 2, sizeof(uint32_t), GFP_KERNEL);
+	if (*dump == NULL)
+		return -ENOMEM;
+
+	for (reg = regSDMA_RLC0_RB_CNTL; reg <= regSDMA_RLC0_DOORBELL; reg++)
+		DUMP_REG(sdma_rlc_reg_offset + reg);
+	for (reg = regSDMA_RLC0_STATUS; reg <= regSDMA_RLC0_CSA_ADDR_HI; reg++)
+		DUMP_REG(sdma_rlc_reg_offset + reg);
+	for (reg = regSDMA_RLC0_IB_SUB_REMAIN;
+	     reg <= regSDMA_RLC0_MINOR_PTR_UPDATE; reg++)
+		DUMP_REG(sdma_rlc_reg_offset + reg);
+	for (reg = regSDMA_RLC0_MIDCMD_DATA0;
+	     reg <= regSDMA_RLC0_MIDCMD_CNTL; reg++)
+		DUMP_REG(sdma_rlc_reg_offset + reg);
+
+	WARN_ON_ONCE(i != HQD_N_REGS);
+	*n_regs = i;
+
+	return 0;
+}
+
+bool kgd_gfx_v9_4_3_hqd_sdma_is_occupied(struct amdgpu_device *adev, void *mqd)
+{
+	struct v9_sdma_mqd *m;
+	uint32_t sdma_rlc_reg_offset;
+	uint32_t sdma_rlc_rb_cntl;
+
+	m = get_sdma_mqd(mqd);
+	sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev, m->sdma_engine_id,
+							m->sdma_queue_id);
+
+	sdma_rlc_rb_cntl = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL);
+
+	if (sdma_rlc_rb_cntl & SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK)
+		return true;
+
+	return false;
+}
+
+int kgd_gfx_v9_4_3_hqd_sdma_destroy(struct amdgpu_device *adev, void *mqd,
+				    unsigned int utimeout)
+{
+	struct v9_sdma_mqd *m;
+	uint32_t sdma_rlc_reg_offset;
+	uint32_t temp;
+	unsigned long end_jiffies = (utimeout * HZ / 1000) + jiffies;
+
+	m = get_sdma_mqd(mqd);
+	sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev, m->sdma_engine_id,
+							m->sdma_queue_id);
+
+	temp = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL);
+	temp = temp & ~SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK;
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL, temp);
+
+	while (true) {
+		temp = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_CONTEXT_STATUS);
+		if (temp & SDMA_RLC0_CONTEXT_STATUS__IDLE_MASK)
+			break;
+		if (time_after(jiffies, end_jiffies)) {
+			pr_err("SDMA RLC not idle in %s\n", __func__);
+			return -ETIME;
+		}
+		usleep_range(500, 1000);
+	}
+
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_DOORBELL, 0);
+	WREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL,
+		RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL) |
+		SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK);
+
+	m->sdmax_rlcx_rb_rptr =
+			RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_RPTR);
+	m->sdmax_rlcx_rb_rptr_hi =
+			RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_RPTR_HI);
+
+	return 0;
+}
 
 static int kgd_gfx_v9_4_3_set_pasid_vmid_mapping(struct amdgpu_device *adev,
 				u32 pasid, unsigned int vmid, uint32_t inst)
@@ -166,13 +352,13 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.init_interrupts = kgd_gfx_v9_init_interrupts,
 	.hqd_load = kgd_gfx_v9_4_3_hqd_load,
 	.hiq_mqd_load = kgd_gfx_v9_hiq_mqd_load,
-	.hqd_sdma_load = kgd_arcturus_hqd_sdma_load,
+	.hqd_sdma_load = kgd_gfx_v9_4_3_hqd_sdma_load,
 	.hqd_dump = kgd_gfx_v9_hqd_dump,
-	.hqd_sdma_dump = kgd_arcturus_hqd_sdma_dump,
+	.hqd_sdma_dump = kgd_gfx_v9_4_3_hqd_sdma_dump,
 	.hqd_is_occupied = kgd_gfx_v9_hqd_is_occupied,
-	.hqd_sdma_is_occupied = kgd_arcturus_hqd_sdma_is_occupied,
+	.hqd_sdma_is_occupied = kgd_gfx_v9_4_3_hqd_sdma_is_occupied,
 	.hqd_destroy = kgd_gfx_v9_hqd_destroy,
-	.hqd_sdma_destroy = kgd_arcturus_hqd_sdma_destroy,
+	.hqd_sdma_destroy = kgd_gfx_v9_4_3_hqd_sdma_destroy,
 	.wave_control_execute = kgd_gfx_v9_wave_control_execute,
 	.get_atc_vmid_pasid_mapping_info =
 				kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 363114edb3c0..1b5a4928eb74 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -733,6 +733,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		if (!node)
 			goto node_alloc_error;
 
+		node->node_id = i;
 		node->adev = kfd->adev;
 		node->kfd = kfd;
 		node->kfd2kgd = kfd->kfd2kgd;
@@ -1315,15 +1316,16 @@ unsigned int kfd_get_num_sdma_engines(struct kfd_node *node)
 {
 	/* If XGMI is not supported, all SDMA engines are PCIe */
 	if (!node->adev->gmc.xgmi.supported)
-		return node->adev->sdma.num_instances;
+		return node->adev->sdma.num_instances/(int)node->kfd->num_nodes;
 
-	return min(node->adev->sdma.num_instances, 2);
+	return min(node->adev->sdma.num_instances/(int)node->kfd->num_nodes, 2);
 }
 
 unsigned int kfd_get_num_xgmi_sdma_engines(struct kfd_node *node)
 {
 	/* After reserved for PCIe, the rest of engines are XGMI */
-	return node->adev->sdma.num_instances - kfd_get_num_sdma_engines(node);
+	return node->adev->sdma.num_instances/(int)node->kfd->num_nodes -
+		kfd_get_num_sdma_engines(node);
 }
 
 #if defined(CONFIG_DEBUG_FS)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d18aa01a47e4..62838d84b6f1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -124,6 +124,15 @@ static inline uint64_t get_reserved_sdma_queues_bitmap(struct device_queue_manag
 	return dqm->dev->kfd->device_info.reserved_sdma_queues_bitmap;
 }
 
+static void init_sdma_bitmaps(struct device_queue_manager *dqm)
+{
+	bitmap_zero(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES);
+	bitmap_set(dqm->sdma_bitmap, 0, get_num_sdma_queues(dqm));
+
+	bitmap_zero(dqm->xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES);
+	bitmap_set(dqm->xgmi_sdma_bitmap, 0, get_num_xgmi_sdma_queues(dqm));
+}
+
 void program_sh_mem_settings(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd)
 {
@@ -1268,24 +1277,6 @@ static void init_interrupts(struct device_queue_manager *dqm)
 	}
 }
 
-static void init_sdma_bitmaps(struct device_queue_manager *dqm)
-{
-	unsigned int num_sdma_queues =
-		min_t(unsigned int, sizeof(dqm->sdma_bitmap)*8,
-		      get_num_sdma_queues(dqm));
-	unsigned int num_xgmi_sdma_queues =
-		min_t(unsigned int, sizeof(dqm->xgmi_sdma_bitmap)*8,
-		      get_num_xgmi_sdma_queues(dqm));
-
-	if (num_sdma_queues)
-		dqm->sdma_bitmap = GENMASK_ULL(num_sdma_queues-1, 0);
-	if (num_xgmi_sdma_queues)
-		dqm->xgmi_sdma_bitmap = GENMASK_ULL(num_xgmi_sdma_queues-1, 0);
-
-	dqm->sdma_bitmap &= ~get_reserved_sdma_queues_bitmap(dqm);
-	pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
-}
-
 static int initialize_nocpsch(struct device_queue_manager *dqm)
 {
 	int pipe, queue;
@@ -1375,46 +1366,49 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 	int bit;
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-		if (dqm->sdma_bitmap == 0) {
+		if (bitmap_empty(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES)) {
 			pr_err("No more SDMA queue to allocate\n");
 			return -ENOMEM;
 		}
 
 		if (restore_sdma_id) {
 			/* Re-use existing sdma_id */
-			if (!(dqm->sdma_bitmap & (1ULL << *restore_sdma_id))) {
+			if (!test_bit(*restore_sdma_id, dqm->sdma_bitmap)) {
 				pr_err("SDMA queue already in use\n");
 				return -EBUSY;
 			}
-			dqm->sdma_bitmap &= ~(1ULL << *restore_sdma_id);
+			clear_bit(*restore_sdma_id, dqm->sdma_bitmap);
 			q->sdma_id = *restore_sdma_id;
 		} else {
 			/* Find first available sdma_id */
-			bit = __ffs64(dqm->sdma_bitmap);
-			dqm->sdma_bitmap &= ~(1ULL << bit);
+			bit = find_first_bit(dqm->sdma_bitmap,
+					     get_num_sdma_queues(dqm));
+			clear_bit(bit, dqm->sdma_bitmap);
 			q->sdma_id = bit;
 		}
 
-		q->properties.sdma_engine_id = q->sdma_id %
-				kfd_get_num_sdma_engines(dqm->dev);
+		q->properties.sdma_engine_id =
+			dqm->dev->node_id * get_num_all_sdma_engines(dqm) +
+			q->sdma_id % kfd_get_num_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
 				kfd_get_num_sdma_engines(dqm->dev);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		if (dqm->xgmi_sdma_bitmap == 0) {
+		if (bitmap_empty(dqm->xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES)) {
 			pr_err("No more XGMI SDMA queue to allocate\n");
 			return -ENOMEM;
 		}
 		if (restore_sdma_id) {
 			/* Re-use existing sdma_id */
-			if (!(dqm->xgmi_sdma_bitmap & (1ULL << *restore_sdma_id))) {
+			if (!test_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap)) {
 				pr_err("SDMA queue already in use\n");
 				return -EBUSY;
 			}
-			dqm->xgmi_sdma_bitmap &= ~(1ULL << *restore_sdma_id);
+			clear_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap);
 			q->sdma_id = *restore_sdma_id;
 		} else {
-			bit = __ffs64(dqm->xgmi_sdma_bitmap);
-			dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
+			bit = find_first_bit(dqm->xgmi_sdma_bitmap,
+					     get_num_xgmi_sdma_queues(dqm));
+			clear_bit(bit, dqm->sdma_bitmap);
 			q->sdma_id = bit;
 		}
 		/* sdma_engine_id is sdma id including
@@ -1424,6 +1418,7 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		 * PCIe-optimized ones
 		 */
 		q->properties.sdma_engine_id =
+			dqm->dev->node_id * get_num_all_sdma_engines(dqm) +
 			kfd_get_num_sdma_engines(dqm->dev) +
 			q->sdma_id % kfd_get_num_xgmi_sdma_engines(dqm->dev);
 		q->properties.sdma_queue_id = q->sdma_id /
@@ -1442,11 +1437,11 @@ static void deallocate_sdma_queue(struct device_queue_manager *dqm,
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
 		if (q->sdma_id >= get_num_sdma_queues(dqm))
 			return;
-		dqm->sdma_bitmap |= (1ULL << q->sdma_id);
+		set_bit(q->sdma_id, dqm->sdma_bitmap);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
 		if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
 			return;
-		dqm->xgmi_sdma_bitmap |= (1ULL << q->sdma_id);
+		set_bit(q->sdma_id, dqm->xgmi_sdma_bitmap);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index e554a48f3054..b11c474d4067 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -239,8 +239,8 @@ struct device_queue_manager {
 	unsigned int		total_queue_count;
 	unsigned int		next_pipe_to_allocate;
 	unsigned int		*allocated_queues;
-	uint64_t		sdma_bitmap;
-	uint64_t		xgmi_sdma_bitmap;
+	DECLARE_BITMAP(sdma_bitmap, KFD_MAX_SDMA_QUEUES);
+	DECLARE_BITMAP(xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES);
 	/* the pasid mapping for each kfd vmid */
 	uint16_t		vmid_pasid[VMID_NUM];
 	uint64_t		pipelines_addr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 1337fcdf8958..5cfebcc8b305 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -113,6 +113,8 @@
 
 #define KFD_UNMAP_LATENCY_MS	(4000)
 
+#define KFD_MAX_SDMA_QUEUES	128
+
 /*
  * 512 = 0x200
  * The doorbell index distance between SDMA RLC (2*i) and (2*i+1) in the
@@ -260,6 +262,7 @@ struct kfd_vmid_info {
 struct kfd_dev;
 
 struct kfd_node {
+	unsigned int node_id;
 	struct amdgpu_device *adev;     /* Duplicated here along with keeping
 					 * a copy in kfd_dev to save a hop
 					 */
-- 
2.39.2

