Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3185CF58D1
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Sep 2024 06:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D93410E7B3;
	Fri, 20 Sep 2024 06:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E3IR3lid";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3466F10E7B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Sep 2024 06:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDPyQEi91bfewgc2dIB/ddzgd4IhDNKY+b0ylJl6J/0OL/54iD1cZuDZuZFptk7Cy8MUD0bIZZcil+8eTgtiAoYiMoj9e3Z+oftefYsjpn4r6pIqiABhQMHKFwnVJb+SnCjRRHfQ+SGDhy2aFtqfGLLzGu2p0b1eotc83yi6CQgb6PZi4rl60x/hqRRr00heIuGlbryWDV7qOQZiCYTyfDHv6rnSUyvEwIUdVbeLzXJfRt83IT2ahKWL7InL8v0OrQc7+OPxxj4b5sozGuGIjuaniqHqmWxU8LhKa5QqRaFs+SrVHYRitgXjBqTVsvOvJM86aLSdOR58veSNY4uang==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T5xW2DTaAAd5fCs11M1V6VYdfep1i+VccGM70KheL4=;
 b=oLm7rl3OD62cN0Zi2XKPFYqKHPsWhOEYeFSECeP0Q1U5AIOY5xZBDUBmNOalTrYm2ufd1V4RviYwwCeUMNLBL+SiPrLUjHtX27nr2lj7vh9Tm7n8Q1eRrnnAC1+cpSOknbXFQEJgpWlU6E3VcIWU0oYHaAFNoyDXO9d9fMg+fX6uC9o9/ZBRcu2Skke1InAQc/gMKVQAF21Kqa9NjMnXZYIVxD9/ZfHJxs5eV2QMbBbnuervIcysOqasljoPb85/r7GW5DmlasHarUtFpURimVblqBc/u7PA+mIwnfuUs2jMmVKGJHSpE2D8u1S0EHX/FbMU93EG3l6b6T1gfKPulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T5xW2DTaAAd5fCs11M1V6VYdfep1i+VccGM70KheL4=;
 b=E3IR3lidmWdr0XZsiDXo9BCHITUffpAsKJXlMz6LlSgLbIejHiizrlM1+2RZWEFpI8tLocq2OPTUTAkTsmXWqCZ3OMF2jVxxDhOqudtknmpJzRtEbqAxR9c55ym2PLqAas/3l+BMCkVG14hqI+yFiXKUx00Y2goJXalVczhd3wQ=
Received: from MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 06:31:36 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::46) by MN2PR16CA0026.outlook.office365.com
 (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Fri, 20 Sep 2024 06:31:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 20 Sep 2024 06:31:36 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 20 Sep 2024 01:31:34 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/sdma5: implement ring reset callback for sdma5
Date: Fri, 20 Sep 2024 14:31:10 +0800
Message-ID: <20240920063112.370961-2-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240920063112.370961-1-jiadong.zhu@amd.com>
References: <20240920063112.370961-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea77452-5198-454e-4b2d-08dcd93de09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KsUKmAIp+FfGFR3kPICSFoqEtasYNqg0QJuc1t+AzFLOTkIGlSCaQ+d6ajTx?=
 =?us-ascii?Q?TJBcxSeiNjo3IMOF39fWlH0ZEBGlOAbt/+biMUY67KPvytCbCswakwVViGGg?=
 =?us-ascii?Q?Ev6DRDXdHID8HC02ujwVlroaSr+czTKpyKDJjlWOk2y8Swj4cyFd4Y9eWT33?=
 =?us-ascii?Q?/6gnijzFL+BUJqsWGdTBw8CUaZntCIc8DFhXvNuhtedL5GXerQ67B/Rh1dr7?=
 =?us-ascii?Q?v+qESQ0FPkLOsu9jbN/j7zNPBmhn8Do93D33BhPbr8u/MCgRCmsAy2OtVEIj?=
 =?us-ascii?Q?SsdwWNWxNsKvkNKAO/mdBHCFhK5WZO7On0q1K8UOyMQtHbzU7r23a/0aO5/f?=
 =?us-ascii?Q?pHOU1Oc8ComtmdFm1fuwm+QHL6WqrPaXHvSI+5xh7mABqDhWiRBrlQsVL5x5?=
 =?us-ascii?Q?P5GkpIqfDtgo6Q/R7oyn6CYd69YYFPEVS8Mx25QWzGolMYLtjM5npPEUccD1?=
 =?us-ascii?Q?S3PoZuxZOAsv/NDmABgC93HoiU0UnGAFQH6IOTCPaaFJPzGR8h8Nej8yPvbM?=
 =?us-ascii?Q?uivavneaM/6IYsHwLwdc3ettBTk63Utcc/y9dXvfLd10xuShkQUURIcqGG0y?=
 =?us-ascii?Q?A4vpJvbztk123sfH5mrKIg/SQNn2C8nb/pQaI6wtDv9SmCc6A7EDLtg3S2Ke?=
 =?us-ascii?Q?fhHFlKiEHqQRYy04bxPOvpbY2wgcwpe7IJpA1QlYX+ramEz+3eYDVeTL/0EU?=
 =?us-ascii?Q?tjMADwzaJODUICCHwi4wjrrYvtJEC/rzRri+K2+GMxalja3by+OJqno/Mroe?=
 =?us-ascii?Q?8/3qURivjPVAgWybNIFFwliJ6PCz2u3gbpX02KtKZLFPcD9XyKqYBNCzrJVp?=
 =?us-ascii?Q?ZjD78EN/g8cnH3wvNtYQUB9v9C5982+09dcOOLxJBGI2m3cKdsfrYyhMb7mU?=
 =?us-ascii?Q?oM4YMfYi69yxmvk4A6kIPS6polBydyTh0m4mPJVW2xJMYVM11f+Q9bRA4HS5?=
 =?us-ascii?Q?kdug5BNlHEJ6O/WLJqExMcUBvzh7i799bjEES8eBYoSiVKQq4I26DwYHPlOx?=
 =?us-ascii?Q?mmiKZdtZ6jLWioBGXH68ifP52W6THGIjMbDAdrxl7kwGBScervY3D9Fc6K/w?=
 =?us-ascii?Q?ijW1/qiyGiFuw+oDJlPcVWNdXSaepC79+kk7vZbbS2Phvcqp7h/HmzyH3P5y?=
 =?us-ascii?Q?t6fbS9bggAdZt53Y1MgbzfrTWtoWX0BBtaWre8Us1hpfuZEM+eet0yUaGsNa?=
 =?us-ascii?Q?yLTWyr9k4WD7+h95JoFkqufiexQXL/e9050vmwzPQSsdahwKGKtambxCpGaX?=
 =?us-ascii?Q?1K0xTWEhFMEdIy6XGE5m6SqOdcB5j8otHUiuTSZpw01FCIllEBlLmSDwt/tF?=
 =?us-ascii?Q?CzR2pRVka/F0p4poI6re3Qc4yOMpHohfo/PgqPioXH0TvaQrGWGLVtIFK5NF?=
 =?us-ascii?Q?yN7TXl0HYSFSbRHWkUVRGgQ0d+n/VwepImx1c7Qn/G2Q+wLX5XlIJ8I/tEEu?=
 =?us-ascii?Q?7qTXoqpZGup04spiPiOgStDMYe1KCHEH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 06:31:36.3558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea77452-5198-454e-4b2d-08dcd93de09c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
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

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Implement sdma queue reset callback via MMIO.

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 81 ++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index e813da1e48aa..7fd7ef22d571 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1555,6 +1555,86 @@ static int sdma_v5_0_soft_reset(void *handle)
 	return 0;
 }
 
+static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, j;
+	u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (ring == &adev->sdma.instance[i].ring)
+			break;
+	}
+
+	if (i == adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	/* stop queue */
+	ib_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
+
+	rb_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
+
+	/* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bit to 1 */
+	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+
+	for (j = 0; j < adev->usec_timeout; j++) {
+		freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+		if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
+			break;
+		udelay(1);
+	}
+
+	/* check sdma copy engine all idle if frozen not received*/
+	if (j == adev->usec_timeout) {
+		stat1_reg = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_STATUS1_REG));
+		if ((stat1_reg & 0x3FF) != 0x3FF) {
+			DRM_ERROR("cannot soft reset as sdma not idle\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	f32_cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
+	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
+
+	cntl = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
+	cntl = REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
+
+	/* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT = 0 mmGRBM_SOFT_RESET.SOFT_RESET_SDMA0/1 = 1 */
+	preempt = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT));
+	preempt = REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), preempt);
+
+	soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+	soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i;
+
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+
+	udelay(50);
+
+	soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << i);
+	WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+
+	/* unfreeze*/
+	freeze = RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE));
+	freeze = REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
+	WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze);
+
+	return sdma_v5_0_gfx_resume_instance(adev, i, true);
+}
+
 static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
 {
 	int i, r = 0;
@@ -1897,6 +1977,7 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v5_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v5_0_ring_preempt_ib,
+	.reset = sdma_v5_0_reset_queue,
 };
 
 static void sdma_v5_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

