Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430C5C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBF4210E435;
	Thu,  5 May 2022 20:04:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E79910E222
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLg5+NwAcYeLNe4K2KB/r84FfhwrAcTzafFIf/XXsC8vXsgPveFCK23HRS21E45V75lcNwCktfCqZBiV2vqTe47WGzTuCZSozFejkmutixT5SMVBJwRvXoxVZZtCjC8BMLEAEOuTgMs1lwFiEhfqAFB5zyjShL+8gYkLZ9a2gPm1oNjWMcKi7rRkD9QHHMOZhSrjIH7VcQ1XaIEFGfTJBXZJLbstJRfNx+2k3Z9RVejGabq7pQpRiwTOy6hAAPy4k1l/GaN/ojthkPwKsKR4Pxbk3426PH/NydkeMLaACMYFN53FprK1bARa8CJU3smoYjqwzrZmj9JxOSoCYSE9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YJiQxCBIUMUnETL5T0QFT4hrXJWi0AArexyVmv34TE=;
 b=VhokqseWDobUZJaPDckWkhVu+lJGlsAtBuHGO37xM/xYiB80dbMEFax7NQPk2GO+C+Dka/qN6HSgNBBrDG2uQHx9GKlOO/WAQvBxjwitJKHYqSigSYoNWT5J75Wb+uW6Q3bQwNz89/9TlqPoSm6W2tTYEUedR/bsuwm+FxalyHByT8VDmwQ0Y/WNuAIShSmzIsIls+r91ra7C79xMecLLPP+cZopoEapICnZlun6VgrDO/xNkA4r6Gpjf75jaSlUFWb/LoOzgUDZ6nsVSThPwfvwM6GXlc5c/M8sfcTtOSJeAA8og/o35RsoLXqWss1V6BjBM4o8T2GfMBMVL+HC8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YJiQxCBIUMUnETL5T0QFT4hrXJWi0AArexyVmv34TE=;
 b=tuQS/i81yK/Xrdc7bHPJaKZDiqby91KjSYgQfb8rZDmdwZERihhlhpTzqu5xHSh2SjTpS28zz7g2qagrqzNsOFypZeQsiBOgCJH2r+pGAl6g9inAWzLU0Ii5alyxnefFi/VJd6mHPcBc/hpyW4mi38I4cC/UKfLsHVz7k5jlq/k=
Received: from DM5PR08CA0056.namprd08.prod.outlook.com (2603:10b6:4:60::45) by
 BN6PR12MB1521.namprd12.prod.outlook.com (2603:10b6:405:f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Thu, 5 May 2022 20:04:22 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::c3) by DM5PR08CA0056.outlook.office365.com
 (2603:10b6:4:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Thu, 5 May 2022 20:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:04:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:04:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: support fill mem for LSDMA
Date: Thu, 5 May 2022 16:04:02 -0400
Message-ID: <20220505200406.1293467-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200406.1293467-1-alexander.deucher@amd.com>
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 456b3a84-77f6-4a51-085c-08da2ed27213
X-MS-TrafficTypeDiagnostic: BN6PR12MB1521:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1521E669001C7E74B26B5AD2F7C29@BN6PR12MB1521.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iud2QCTdgJjxJnO9z26xkF3f7P5uoI/53McwwBnvFeSOiRA3/SLs45A68stjVY60c3X0FPDo0+VXoP+v0G56PGHiVninRMF1zrw1opgALQFJ9AID949xw9LusAFjebPLpzf9EFrGNqVIpD+0fknKCBepr7/JlUF15R+UTmkqDrdqUFMsQ/xpZpkQ6dWyhk0Ugm3TKhnIAefsRhxyIQEF1MDQcO+rQTqh19/VmOIPmzcn/40oM8MG9tfplkMmQ1UUAFY9h5PDKpMEgDd2cQaxA+6rue8VIaXZsQbx2WTihj5VMc4u6pRKNeLbFPnq1whKzk5IsAlLKHCTfoqftTE7eXttc9dUjq0igrRzMa5Pq4Sr0PzZB6HWTq+TUv5we/+/DhnUXTflXVMJSj55mbaD+n31x3aG5yNwUpcJGgYXlNkWdMZ4AvMgrB1GxADN54E0A2U3Orchnthy61hcPjSqJG+3ygcwvnjwJOIYYfHnuRREifaY+XezdPX0fmmN4lSmPhEPYMZr2pi3GlRQ4dYp7PLRi3v1QCKOZPPp0EhYFrsP6AXAFWF4jQSVmobqCG8JGOj5oOq73kghp9OE+bOGuAIe2S1d3sv41T8upqdkD/FhPCcFhFMhJqgQ7yyPRFecZqf3BN2BhzsPp5przHPjAnpOv6RxEN6ZkFhJ+svst+8UKaRBgIz0wlkbYpiENdWK322LLFhV3DFxU2H3w7NMcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(54906003)(36860700001)(6916009)(86362001)(316002)(82310400005)(81166007)(26005)(6666004)(7696005)(36756003)(8936002)(2906002)(2616005)(426003)(1076003)(186003)(336012)(4326008)(356005)(16526019)(47076005)(8676002)(83380400001)(70586007)(70206006)(5660300002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:04:21.7268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456b3a84-77f6-4a51-085c-08da2ed27213
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1521
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support constant data filling in PIO mode for LSDMA.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c | 40 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h |  6 +++
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c   | 62 +++++++++++++++++------
 3 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
index 3f1c674afe41..223c47d1cc1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -26,6 +26,23 @@
 
 #define AMDGPU_LSDMA_MAX_SIZE	0x2000000ULL
 
+int amdgpu_lsdma_wait_for(struct amdgpu_device *adev,
+			  uint32_t reg_index, uint32_t reg_val,
+			  uint32_t mask)
+{
+	uint32_t val;
+	int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		val = RREG32(reg_index);
+		if ((val & mask) == reg_val)
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIME;
+}
+
 int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev,
 			  uint64_t src_addr,
 			  uint64_t dst_addr,
@@ -49,3 +66,26 @@ int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev,
 
 	return 0;
 }
+
+int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev,
+			  uint64_t dst_addr,
+			  uint32_t data,
+			  uint64_t mem_size)
+{
+	int ret;
+
+	if (mem_size == 0)
+		return -EINVAL;
+
+	while(mem_size > 0) {
+		uint64_t current_fill_size = min(mem_size, AMDGPU_LSDMA_MAX_SIZE);
+
+		ret = adev->lsdma.funcs->fill_mem(adev, dst_addr, data, current_fill_size);
+		if (ret)
+			return ret;
+		dst_addr += current_fill_size;
+		mem_size -= current_fill_size;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index be397666e4c1..9a29f18407b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -32,9 +32,15 @@ struct amdgpu_lsdma_funcs
 {
 	int (*copy_mem)(struct amdgpu_device *adev, uint64_t src_addr,
                     uint64_t dst_addr, uint64_t size);
+	int (*fill_mem)(struct amdgpu_device *adev, uint64_t dst_addr,
+                    uint32_t data, uint64_t size);
 };
 
 int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev, uint64_t src_addr,
                           uint64_t dst_addr, uint64_t mem_size);
+int amdgpu_lsdma_fill_mem(struct amdgpu_device *adev, uint64_t dst_addr,
+                          uint32_t data, uint64_t mem_size);
+int amdgpu_lsdma_wait_for(struct amdgpu_device *adev, uint32_t reg_index,
+                          uint32_t reg_val, uint32_t mask);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
index 0d2bdd04bd76..b4adb94a080b 100644
--- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
@@ -29,14 +29,20 @@
 #include "lsdma/lsdma_6_0_0_offset.h"
 #include "lsdma/lsdma_6_0_0_sh_mask.h"
 
+static int lsdma_v6_0_wait_pio_status(struct amdgpu_device *adev)
+{
+	return amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
+}
+
 static int lsdma_v6_0_copy_mem(struct amdgpu_device *adev,
 			       uint64_t src_addr,
 			       uint64_t dst_addr,
 			       uint64_t size)
 {
-	uint32_t usec_timeout = 5000;  /* wait for 5ms */
-	uint32_t tmp, expect_val;
-	int i;
+	int ret;
+	uint32_t tmp;
 
 	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_LO, lower_32_bits(src_addr));
 	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_HI, upper_32_bits(src_addr));
@@ -56,22 +62,46 @@ static int lsdma_v6_0_copy_mem(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 0);
 	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
 
-	expect_val = LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK;
-	for (i = 0; i < usec_timeout; i++) {
-		tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
-		if ((tmp & expect_val) == expect_val)
-			break;
-		udelay(1);
-	}
-
-	if (i >= usec_timeout) {
+	ret = lsdma_v6_0_wait_pio_status(adev);
+	if (ret)
 		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
-		return -ETIMEDOUT;
-	}
 
-	return 0;
+	return ret;
+}
+
+static int lsdma_v6_0_fill_mem(struct amdgpu_device *adev,
+			       uint64_t dst_addr,
+			       uint32_t data,
+			       uint64_t size)
+{
+	int ret;
+	uint32_t tmp;
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONSTFILL_DATA, data);
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 1);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	ret = lsdma_v6_0_wait_pio_status(adev);
+	if (ret)
+		dev_err(adev->dev, "LSDMA PIO failed to fill memory!\n");
+
+	return ret;
 }
 
 const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
-	.copy_mem = lsdma_v6_0_copy_mem
+	.copy_mem = lsdma_v6_0_copy_mem,
+	.fill_mem = lsdma_v6_0_fill_mem
 };
-- 
2.35.1

