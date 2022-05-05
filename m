Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C51C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012FA10E222;
	Thu,  5 May 2022 20:04:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47D1510E222
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYtIt6uA3Yt2UWZseGb2qZCJOeiHyFMI0tkekz44ra3fRWO5ER7jcYn4Mf5CH5oOdHi/P1R/xUmzb4Zg5bRhlBdilhDlT0w9mow6KcQACwzASbvJBYHw6ZHts9Fi0W/2h7jGpDhGmEGYKVQJQaHNj2ZjJYYqkgdbEnKfjCEFlH+ZwxqhkNPFEnJNksOoSzCjgJY4KQknwGFOA1xP3jT7Lo75xjRatWhGqntcTu88HHt8tgZQYyCukWkftvttt4V4TqbaV2KFSvzziXZNl2GC9+NA9pQiEYwqSEYfnBQPYILzhN3vIo3S10eQRVTqPwhQUlEAmDRc6f7VdezPf0VdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfX4Q+5QsEgt+v3Ut+itdYizxtDoW9VVQvexi54hYlM=;
 b=dfd8WFNuyN85qVAUOdbiozppsSGOnlFyamZy3i7AASpX668pb8CpO69k7JbEdvq5P5wKu/bqueKRILI3TzizdnNEurs4dN190jACLWX9bVa6l9teAioTZGU3Md+LtO3Pt31/yBVRDdVQ2i98w1Zx2pn5PYHwp4aYuEcYD6nh0nZY25L6LJWDHDeixPe3/cx6kUMdtSCZb8Nkm5LhPUW0HfqAt0Ez7CQlXemSmtGPUw33wdbciA/5KANvhv0227MsaeBLPngDfQD7nLH5G5plQzXzySeJIh2OADuHS0RxQUIca5DSjXq3+N5xY6OOg2AqlLdKmGASCjzBKMt9RM1cBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfX4Q+5QsEgt+v3Ut+itdYizxtDoW9VVQvexi54hYlM=;
 b=3nTmHq182Vo9rZ60gxit5zxVfy+gWM1D6Cb6eC6zlvV2JZV53VuY1mangQ7iZlP5vTkyQsiwM3WIzebW9ssVIIv2lsCUhGHjTsASlnOEb/zVC6A6vw7fN3V/BVfYtC93PqgLLCvr8MCNnV/R/WojJQmFSxCSkJ5DnQeWD9HePEU=
Received: from DM6PR07CA0048.namprd07.prod.outlook.com (2603:10b6:5:74::25) by
 BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 20:04:21 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::30) by DM6PR07CA0048.outlook.office365.com
 (2603:10b6:5:74::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Thu, 5 May 2022 20:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:04:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:04:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/8] drm/amdgpu: support mem copy for LSDMA
Date: Thu, 5 May 2022 16:04:01 -0400
Message-ID: <20220505200406.1293467-3-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90929ec1-22b7-493f-cd4c-08da2ed2719c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5921:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB59210BEAADAA3F11058299EEF7C29@BL1PR12MB5921.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKxm/Mf+hw9j8aHvIoriZuirfas+C2hOWggIvAwMdT1j40RbNIJDT9bsfyffNCjLBG7GLCun7q4ujuXr2UrDJqrTirtEiyPCghHQXlN5UAG3Ioe9qPZBAxFgs8et1KwVwC61jxtzQzVUyItgXO4CJYTx2SNyxB2mNkY6iusioSd7Bn+Jf0qOFZ+l4+8HyXXnU3lgqSolCY7objWXf4vrzyrxPMX8QsUbnFmU1n8Lc4tWrMHCJJ3SPoFgZf92DVkfyhTH6uBgl9p0FY8GuKtkmeo5UqcPzTvblSZVFM4sQkYd+h5WohgsIFc/KcSkJS7tsNuguZw6lBROdLzn49l4gc1kArKPncOSckM/2b7vzOJUCiTZEpc1DIYSv3wTUMFmaC5In1nPeP7er5oUEBy/7KPnVGyfcnvbrwG0JDVnXIGFtRiphq1P6NBrh8NwJ2vOlLASslGwpFus1GDgCvD22hxoFeSnh3RFD7vIzZCoKjC8RUUOP3go6kH5CJh/UzTzBSgOxYQG+oFbDtOHqLoaN5S0f0zq2fz2Mjl2+nT0J83T5lCTsN2nYZdqM1PROemEwQ+GkltcUe9BspEWhYfeGPr4E4L45Fc3KJaZDNjHon5fvYbWdzeb1cFz8lCfN05ZJzgh1GJKXaDOJwEuo6dqPdZQPsXQ5WlesOSIfS01KXbdBgkS94/TW9UfXtAm5riJYjPCdNDg8wXfsIgmYZiADQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(336012)(26005)(2616005)(186003)(47076005)(7696005)(16526019)(54906003)(1076003)(6916009)(8936002)(70586007)(70206006)(4326008)(8676002)(2906002)(6666004)(316002)(5660300002)(508600001)(356005)(40460700003)(81166007)(82310400005)(36860700001)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:04:20.9364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90929ec1-22b7-493f-cd4c-08da2ed2719c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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

Support memory to memory linear copy in PIO mode for LSDMA.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c | 26 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h |  5 +++
 drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c   | 44 +++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
index af00a66f8282..3f1c674afe41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
@@ -23,3 +23,29 @@
 
 #include "amdgpu.h"
 #include "amdgpu_lsdma.h"
+
+#define AMDGPU_LSDMA_MAX_SIZE	0x2000000ULL
+
+int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev,
+			  uint64_t src_addr,
+			  uint64_t dst_addr,
+			  uint64_t mem_size)
+{
+	int ret;
+
+	if (mem_size == 0)
+		return -EINVAL;
+
+	while(mem_size > 0) {
+		uint64_t current_copy_size = min(mem_size, AMDGPU_LSDMA_MAX_SIZE);
+
+		ret = adev->lsdma.funcs->copy_mem(adev, src_addr, dst_addr, current_copy_size);
+		if (ret)
+			return ret;
+		src_addr += current_copy_size;
+		dst_addr += current_copy_size;
+		mem_size -= current_copy_size;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
index 4df4da423181..be397666e4c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
@@ -30,6 +30,11 @@ struct amdgpu_lsdma {
 
 struct amdgpu_lsdma_funcs
 {
+	int (*copy_mem)(struct amdgpu_device *adev, uint64_t src_addr,
+                    uint64_t dst_addr, uint64_t size);
 };
 
+int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev, uint64_t src_addr,
+                          uint64_t dst_addr, uint64_t mem_size);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
index b611ade53be2..0d2bdd04bd76 100644
--- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
@@ -29,5 +29,49 @@
 #include "lsdma/lsdma_6_0_0_offset.h"
 #include "lsdma/lsdma_6_0_0_sh_mask.h"
 
+static int lsdma_v6_0_copy_mem(struct amdgpu_device *adev,
+			       uint64_t src_addr,
+			       uint64_t dst_addr,
+			       uint64_t size)
+{
+	uint32_t usec_timeout = 5000;  /* wait for 5ms */
+	uint32_t tmp, expect_val;
+	int i;
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_LO, lower_32_bits(src_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_HI, upper_32_bits(src_addr));
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
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	expect_val = LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK;
+	for (i = 0; i < usec_timeout; i++) {
+		tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
+		if ((tmp & expect_val) == expect_val)
+			break;
+		udelay(1);
+	}
+
+	if (i >= usec_timeout) {
+		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs = {
+	.copy_mem = lsdma_v6_0_copy_mem
 };
-- 
2.35.1

