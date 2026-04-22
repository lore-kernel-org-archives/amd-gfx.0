Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D60FA1FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6345C10EA8E;
	Wed, 22 Apr 2026 21:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hd+wRyef";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E18D10EA8B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbSkt1wkkJQaz1epuduyB48I4/YFtrHhhGJmbJzM3GBplDzM3qB1SaQ/DoFj6DAWTZWbAOfQiVecbupywtkPFBICrMjSY9w3W6YFmEJmyxwYQC365E3ytIopZQllMpDy0D1Cb3tlL7rUxZCNnJuvXoLUY2ELxlGCGwbw+Br0dN9YQFoD4wxg8nUOXNwkCeEu5wiJt34HJi+yYQuN78bl3WvPk18OED20dS2iEBkAdgRNTCuDqED0Kc1+5C8q5c8cpvZkLQu5rrqF7MJSSNF+pwV8D/d7XcrsqsC6n10U6XLHmqapGuOMBiXkMFsY+YWch59hkMfCA9HMbGMWsxhPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uLhuJikmnPrmJaQ3f9ZG5hevKIf/p+12sTW3Qd8qVw=;
 b=nBteIklMcCIJVIzhuiF/3dd/tWROuRk0NOYo6RxFg/McBBhTh10qqLxBVZtIFZu/HShfeBgxP9KDR7a3iIMnTHDav3oZVRMQrbcqxY52cfpeeWMJYj4Pl+Q5Ns0+mv+40+tR9HCP0c2QfPkfdP+c07f45jnykNm767yQ9zQYVxqtoBWfR5E578pm5M4aYRvgrIhJV0lB/1+iLZz8SjOfGO2gxG/w8gS0HTjB4dW0LOg+QudWKdhKI9BGpRzHvTLBewdUGRdPqlJfmmlbecZVtcSNB/54P5S+iEoO0SD8LlpgwJhjUVlMwiZb4+DZCjg/8IcWIjF+50CHXkhTRjq5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uLhuJikmnPrmJaQ3f9ZG5hevKIf/p+12sTW3Qd8qVw=;
 b=hd+wRyefHN6bNXWrZFOqqTNZRBJCvbdSfq7RMsEN3PG+IQ/lH5dsg/kIbVSV6g85FGqYOprT4I5zX/EBChGa7OELLjpZrVpAoHaBCm+UYM2SNxzXCPt2vAUT6g9phk9CmbVuXlJVxrxKPkaCp3vxiT2QMPGSxEv56d4vROTkHU0=
Received: from BY3PR10CA0019.namprd10.prod.outlook.com (2603:10b6:a03:255::24)
 by MN0PR12MB6056.namprd12.prod.outlook.com (2603:10b6:208:3cc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 21:42:23 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::f7) by BY3PR10CA0019.outlook.office365.com
 (2603:10b6:a03:255::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 21:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:42:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:42:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:42:22 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:42:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add doorbell range function for nbio v6_3_2
Date: Wed, 22 Apr 2026 17:42:06 -0400
Message-ID: <20260422214207.2241171-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422214207.2241171-1-alexander.deucher@amd.com>
References: <20260422214207.2241171-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|MN0PR12MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b25090-50bf-4b9c-bcdf-08dea0b809b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: vpznmwGlwAu0BMvZbUpfXUEnzjjHVtzbH61Kps8INcS2UdnIcx+wNEAD9DYlYb7EOz304brWO3Xqfut6CPpstVUn9nd8bhgoHf+yC7fKnBswWrXzR/1WVAeaOHfFhdxl9RPc/E8h88Hul27p20/uqWFtDzUzTz/zmhynvvFh8kp5LXFPvNr9k9gAsAwDBkG+T+nibn73pSDDx4ruOhcBQsSRGeoRvk/Nnejit3MTlQe9y+lZSD30YvWo2/ABTrtiPze4MTgF9xJ6LWugn7Cu2eWyqtS8KIAuqq4d3UzGyOY7iq2pWEWtltRNXkCuTsM0sy/rdh0+eeTi9IdaQ3tqKjJy7URI/DPuTUIeBNLF9AZWGkl5rei78nXFRhjgMamRZ9kiJsz2RnNujz/9NkjbVdMLdiBUKM5jhSVXyoShvEkMllE0V401q50dwxPNgkMq794FKDD30cverGwGvsRVAT0ACBdrkiL2XRDnGM8AF8QWx4Xtk/zZsUkYwQpScK+QcxApZe0XjX3+uXSSHWQVV4oybG6X2U9A+DqOMK82UklhXOzh0XkMGBP/mqabIz1b1BVPbXQSnP3GpaCeRdSgq/4CMumDSXYSQuepHS3SCyVf7COXfED6JOlw710t3fbQHkwYNwcdeQy4W8P4E2CB9hN/HiCMCC6TTeZAL01SteMADXl0m/LEJS9u4rrV80IlR2nKeF3CXDFBrIUvduzyo8v8+J1GxywicZ+biSlTTw/A0gvuX8qs/rErpOhP0RUtcvw0qcgTPZXrh+pbt93o6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6i6h0EEOx6ejTYr+1/ugcoyi+LSzaMm9MtVF7BsqDg87mDisHKZAG58Z9HUCkkpTiKkC3mq/rYfmEqSWoUAFCuXKgqI9yYw++njqmKdJ8TYUEafl3Zx5Tp/YL+51OSAgFOA67E0teqMCLVhDMdQtD3VP5vJIdLUqmkxeQZIr8l757C9ERQ5HR6WZ5Th7IAbSL2c4pu0xxABWIxtaC5LjFR3f1G9pd4ePGWOo1G5sBWVrl6LO9udFPOHskMGh5Otqf9UCoKX2LGkiBcPbyCXGrIvNeByVW8lOSi6rojvCoXBABVSLHFGybwVcdCzl/BSmVdE16JYvsr0SGY1Uvb4kXX7u/SzseHUL2mCcw1GvKV9W2vzx+J7YM0ArC64gFDyKjm/wP29G1W2IvtAd9ZEaiIakdn65vXnPu2HrhFmGlJ8ZhmKYZAdnsAYV0zN7ERVi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:42:22.9379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b25090-50bf-4b9c-bcdf-08dea0b809b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6056
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

From: Likun Gao <Likun.Gao@amd.com>

Add doorbell range and ih control related function for
NBIO version 6.3.2.

v2: squash in doorbell range fixes
v3: squash in xcd doorbell fix

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c | 201 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c    |   2 +
 2 files changed, 203 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
index c21e5d2fe8397..5e8f466f23ad3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
@@ -71,6 +71,13 @@ static void nbio_v6_3_2_mc_access_enable(struct amdgpu_device *adev,
 		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
 }
 
+static void nbio_v6_3_2_init_registers(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regXCD_DOORBELL_FENCE_1,
+		(0xff & ~(adev->gfx.xcc_mask)) <<
+		XCD_DOORBELL_FENCE_1__XCD_0_DOORBELL_DISABLE__SHIFT);
+}
+
 static u32 nbio_v6_3_2_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
@@ -114,6 +121,194 @@ static void nbio_v6_3_2_enable_doorbell_interrupt(struct amdgpu_device *adev,
 			      DOORBELL_INTERRUPT_DISABLE, enable ? 0 : 1);
 }
 
+static void nbio_v6_3_2_ih_control(struct amdgpu_device *adev)
+{
+	u32 interrupt_cntl;
+
+	/* setup interrupt control */
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
+
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL);
+	/*
+	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
+	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
+	 */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
+				       IH_DUMMY_RD_OVERRIDE, 0);
+
+	/* BIF_BX0_INTERRUPT_CNTL__IH_REQ_NONSNOOP_EN_MASK=1 if ring is in non-cacheable memory, e.g., vram */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
+				       IH_REQ_NONSNOOP_EN, 0);
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
+}
+
+static void nbio_v6_3_2_ih_doorbell_range(struct amdgpu_device *adev,
+					  bool use_doorbell, int doorbell_index)
+{
+	u32 ih_doorbell_range = 0;
+	u32 ih_doorbell_range1 = 0;
+
+	if (use_doorbell) {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_ENABLE,
+						  0x1);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWID,
+						  0x0);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
+						  doorbell_index);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_SIZE,
+						  8);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
+						  0x0);
+		ih_doorbell_range1 = REG_SET_FIELD(ih_doorbell_range1,
+						   GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1,
+						   S2A_DOORBELL_PORT1_TARGET_PORT_TYPE,
+						   0x3);
+		ih_doorbell_range1 = REG_SET_FIELD(ih_doorbell_range1,
+						   GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1,
+						   S2A_DOORBELL_PORT1_TARGET_DIEID,
+						   0x0);
+		ih_doorbell_range1 = REG_SET_FIELD(ih_doorbell_range1,
+						   GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1,
+						   S2A_DOORBELL_PORT1_TARGET_PORT_ID,
+						   0x0);
+	}
+
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1, ih_doorbell_range1);
+}
+
+static void nbio_v6_3_2_gc_doorbell_init(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1, 0x3);
+}
+
+static void nbio_v6_3_2_sdma_doorbell_range(struct amdgpu_device *adev,
+					    int instance, bool use_doorbell,
+					    int doorbell_index,
+					    int doorbell_size)
+{
+	if (instance == 0) {
+		u32 doorbell_range = 0;
+		u32 doorbell_range1 = 0;
+
+		if (use_doorbell) {
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
+						       S2A_DOORBELL_PORT6_ENABLE,
+						       0x1);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
+						       S2A_DOORBELL_PORT6_AWID,
+						       0xe);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
+						       S2A_DOORBELL_PORT6_RANGE_OFFSET,
+						       doorbell_index);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
+						       S2A_DOORBELL_PORT6_RANGE_SIZE,
+						       doorbell_size);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL,
+						       S2A_DOORBELL_PORT6_AWADDR_31_28_VALUE,
+						       0xe);
+			doorbell_range1 = REG_SET_FIELD(doorbell_range1,
+						        GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL1,
+						        S2A_DOORBELL_PORT6_TARGET_PORT_TYPE,
+						        0x3);
+			doorbell_range1 = REG_SET_FIELD(doorbell_range1,
+						        GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL1,
+						        S2A_DOORBELL_PORT6_TARGET_DIEID,
+						        0x0);
+			doorbell_range1 = REG_SET_FIELD(doorbell_range1,
+						        GDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL1,
+						        S2A_DOORBELL_PORT6_TARGET_PORT_ID,
+						        0x0);
+		}
+
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL, doorbell_range);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_6_CTRL1, doorbell_range1);
+	}
+}
+
+static void nbio_v6_3_2_vcn_doorbell_range(struct amdgpu_device *adev,
+					   bool use_doorbell, int doorbell_index,
+					   int instance)
+{
+	u32 doorbell_range = 0;
+	u32 doorbell_range1 = 0;
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+					       S2A_DOORBELL_PORT2_ENABLE,
+					       0x1);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+					       S2A_DOORBELL_PORT2_AWID,
+					       (instance % adev->vcn.num_inst_per_aid) ? 0x7 : 0x4);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+					       S2A_DOORBELL_PORT2_RANGE_OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+					       S2A_DOORBELL_PORT2_RANGE_SIZE,
+					       8);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+					       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
+					       (instance % adev->vcn.num_inst_per_aid) ? 0x7 : 0x4);
+		doorbell_range1 = REG_SET_FIELD(doorbell_range1,
+						GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1,
+					        S2A_DOORBELL_PORT2_TARGET_PORT_TYPE,
+					        0x3);
+		doorbell_range1 = REG_SET_FIELD(doorbell_range1,
+						GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1,
+					        S2A_DOORBELL_PORT2_TARGET_DIEID,
+					        (instance / adev->vcn.num_inst_per_aid) ? 0x3 : 0x0);
+		doorbell_range1 = REG_SET_FIELD(doorbell_range1,
+						GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1,
+					        S2A_DOORBELL_PORT2_TARGET_PORT_ID,
+					        0x0);
+	}
+
+	switch (instance) {
+	case 0:
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1, doorbell_range1);
+		break;
+	case 1:
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, doorbell_range);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1, doorbell_range1);
+		break;
+	case 2:
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1, doorbell_range1);
+		break;
+	case 3:
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1, doorbell_range1);
+		break;
+	default:
+		dev_err(adev->dev,
+			"amdgpu: invalid vcn instance set when program doorbell range\n");
+		break;
+	}
+}
+
 static int nbio_v6_3_2_get_compute_partition_mode(struct amdgpu_device *adev)
 {
 	u32 tmp, px;
@@ -165,4 +360,10 @@ const struct amdgpu_nbio_funcs nbio_v6_3_2_funcs = {
 	.get_compute_partition_mode = nbio_v6_3_2_get_compute_partition_mode,
 	.get_memory_partition_mode = nbio_v6_3_2_get_memory_partition_mode,
 	.is_nps_switch_requested = nbio_v6_3_2_is_nps_switch_requested,
+	.ih_control = nbio_v6_3_2_ih_control,
+	.ih_doorbell_range = nbio_v6_3_2_ih_doorbell_range,
+	.gc_doorbell_init = nbio_v6_3_2_gc_doorbell_init,
+	.sdma_doorbell_range = nbio_v6_3_2_sdma_doorbell_range,
+	.vcn_doorbell_range = nbio_v6_3_2_vcn_doorbell_range,
+	.init_registers = nbio_v6_3_2_init_registers,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 709b1669b07bc..d06953c237ed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -330,6 +330,8 @@ static int soc_v1_0_common_early_init(struct amdgpu_ip_block *ip_block)
 		return -EINVAL;
 	}
 
+	adev->nbio.funcs->init_registers(adev);
+
 	return 0;
 }
 
-- 
2.53.0

