Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F4BC25B08
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Aug 2022 02:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E2499ACE;
	Thu, 18 Aug 2022 02:18:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A72C10EC11
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Aug 2022 02:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8JfG5Q3Vb5HRWrA0EpwpoYwFw22+Gzi/nklojyGWNgFoSJdNmgu8GZxChaRuWF9X2iI0Tb/ny8SpeD7PDfUCtNnHqNvdR3KV5HAjOaydz/ogxTQj3r1FfLfmMTGMTWUCrC9mb84fbq1dStNWpm62R1+7YC44jyPPsETFe6/ghPZcXG4h4x+EdwsAzl8+YFiOJnnl3wZubBxhPYFZNy2BMW8C96XBl9hZn33jn8HbCELPp67nHTKFqKkUpH/XaHAzDq9niAlNEfM9ogEEQDI+8btVJZpQoH7kG00bZCkSFhn3TDJtSUxioKWX3qdEK2TA8WGl2szNxznH+0WHll7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSLQBfVZuaC1KxYZB42AbyimWvuNsWK7KZUQ3MOb4Ss=;
 b=O7wLp/OX6TzLOZzFCwW1s4mIfIUwDhC2PnOoOqpIhi8iBFNjPBFpnuno5vjftz911JLHULKK/gu65Cy5y4qaegVVjLSdIZ3r/nh1M4tNYaWVju3/iG/4sd436QVqyOwxA8s5VOeTNl+seMJCMKRyGCjzUX2Gb4cidc9BhfG++x7oJ2n459lTzuFYa1WlFDu2UcQp8ATDI3O4J57I9Xyx7YplTmC484rtwBI1uVGi2qt7bDY4kA3rkZ+Yg+s4Q6ZXIJtH0XFXu023yVlvmdxklsVOgjFWAL88hHs0W4v6t0bsBNXKP6rd2Snf5v/XbS1KP4clUBz4qpGiLCBYyEQmqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSLQBfVZuaC1KxYZB42AbyimWvuNsWK7KZUQ3MOb4Ss=;
 b=KeoQjCZ43Kb7JQ7/y39rtOT7FJIlMVAnaXwy/25srQXlDYpigu4CILR1poLgZ7rTW1ud0uiMa+rrQ9zSgV6yR2xQpfYJZBM8lsQLoAPil16PgQPAqNDl336n1daIdzEp3DxBQZpfdtcMewhaSuDmwpuUHIphyaYG0ZUlfqQyHz8=
Received: from DS7PR03CA0040.namprd03.prod.outlook.com (2603:10b6:5:3b5::15)
 by BN6PR12MB1635.namprd12.prod.outlook.com (2603:10b6:405:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 02:18:40 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::29) by DS7PR03CA0040.outlook.office365.com
 (2603:10b6:5:3b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Thu, 18 Aug 2022 02:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 02:18:39 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 17 Aug
 2022 21:18:30 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add NBIO IP v7.7.0 Clock Gating support
Date: Thu, 18 Aug 2022 10:17:31 +0800
Message-ID: <20220818021732.4087442-2-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818021732.4087442-1-tim.huang@amd.com>
References: <20220818021732.4087442-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aad39935-ca0b-486a-f582-08da80bff6f8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1635:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipRSiHDjENGH/WcC5YnaXD/KTEXJn6yTmZDOuAsG2Uu5tUffKk5ET9aW7G5vD9sTnOS7yOn+U0NQFpRQ9Xo22WMjirbXtuAGpi6fB5JIschJ3dok5Lh47ja8oe6KHV70gv1o5rPPisj/A16GM5hRmzM+UH+FXpPFsL8uhOn4znD+Buzui0Z0haAiGqBi/D6acbRV3ZK/7CRmT6qjfZGolcZZFlOXUKnP1pgC/WlHmXA8OblPXD6ev9tF5hsBlmvjuBhRPd9rHU2Z/MqJEx0bmf4LbnyUN6tLn/Vn5FMOxDOw6mEvjk1mnWbx5QMI6tdKGo1LLR4itck5xElTp2H5/+Z14MFH7OwP0nKWG1R16TTOQylUyEiMDABBWwFqj0yLxRmBVm0XHhml9rBpCeWGRGrq01VcE8k/d3ytV225BZ9S/B+/gVEMOzcZ90mo+fitigwRMfVn/Ol2Xy+YxT4VGdiCG4S8ROU+wPRL7Xifx4ji86VKWjL4+Dp/xcsMoNnm0wy72neZhNQJTVn1o+gFMTBAfhWyB3ZdLMAEzt5hWOQYIxY03pWloeH5fxmbBePACPu4ltlZWEXDivzqZaI3lNya0s5Z/4GOd4KHKodHxCQnvtWXQ0ceVGHXE67kCSvuy06d/j1rPmE86LcONGW3IxbtulM4f5DMhHzrp5XPSStyjWthKgjhimOopd9BaWSw+diSc5KtXFmIZUr0TDcx74+k8Uug7BkCqT190g3mKEVirtDkuGMoOw5Vc/+ntZw9NtHVbq/8iDbBBRNJQRYhrg2gpDlY1axmb6l0PVSblieIp9tmihaz+skntA1T+qla
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(40470700004)(46966006)(82310400005)(7696005)(8676002)(44832011)(356005)(4326008)(82740400003)(2906002)(81166007)(41300700001)(186003)(70586007)(1076003)(83380400001)(26005)(70206006)(16526019)(336012)(86362001)(426003)(478600001)(5660300002)(36756003)(8936002)(47076005)(2616005)(40460700003)(54906003)(36860700001)(6916009)(40480700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 02:18:39.6028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad39935-ca0b-486a-f582-08da80bff6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1635
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add BIF Clock Gating MGCG and LS support for NBIO IP v7.7.0.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 78 ++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index 01e8288d09a8..1dc95ef21da6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -247,6 +247,81 @@ static void nbio_v7_7_init_registers(struct amdgpu_device *adev)
 
 }
 
+static void nbio_v7_7_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						       bool enable)
+{
+	uint32_t def, data;
+
+	if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG))
+		return;
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF0_CPM_CONTROL);
+	if (enable) {
+		data |= (BIF0_CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
+			 BIF0_CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
+			 BIF0_CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
+			 BIF0_CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_MASK |
+			 BIF0_CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_MASK |
+			 BIF0_CPM_CONTROL__REFCLK_REGS_GATE_ENABLE_MASK);
+	} else {
+		data &= ~(BIF0_CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
+			  BIF0_CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
+			  BIF0_CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
+			  BIF0_CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_MASK |
+			  BIF0_CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_MASK |
+			  BIF0_CPM_CONTROL__REFCLK_REGS_GATE_ENABLE_MASK);
+	}
+
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF0_CPM_CONTROL, data);
+}
+
+static void nbio_v7_7_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t def, data;
+
+	if (enable && !(adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+		return;
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_CNTL2);
+	if (enable)
+		data |= BIF0_PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
+	else
+		data &= ~BIF0_PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
+
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF0_PCIE_CNTL2, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_TX_POWER_CTRL_1);
+	if (enable) {
+		data |= (BIF0_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK |
+			BIF0_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK);
+	} else {
+		data &= ~(BIF0_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK |
+			BIF0_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK);
+	}
+
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF0_PCIE_TX_POWER_CTRL_1, data);
+}
+
+static void nbio_v7_7_get_clockgating_state(struct amdgpu_device *adev,
+					    u64 *flags)
+{
+	uint32_t data;
+
+	/* AMD_CG_SUPPORT_BIF_MGCG */
+	data = RREG32_SOC15(NBIO, 0, regBIF0_CPM_CONTROL);
+	if (data & BIF0_CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_BIF_MGCG;
+
+	/* AMD_CG_SUPPORT_BIF_LS */
+	data = RREG32_SOC15(NBIO, 0, regBIF0_PCIE_CNTL2);
+	if (data & BIF0_PCIE_CNTL2__SLV_MEM_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_BIF_LS;
+}
+
 const struct amdgpu_nbio_funcs nbio_v7_7_funcs = {
 	.get_hdp_flush_req_offset = nbio_v7_7_get_hdp_flush_req_offset,
 	.get_hdp_flush_done_offset = nbio_v7_7_get_hdp_flush_done_offset,
@@ -262,6 +337,9 @@ const struct amdgpu_nbio_funcs nbio_v7_7_funcs = {
 	.enable_doorbell_aperture = nbio_v7_7_enable_doorbell_aperture,
 	.enable_doorbell_selfring_aperture = nbio_v7_7_enable_doorbell_selfring_aperture,
 	.ih_doorbell_range = nbio_v7_7_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbio_v7_7_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbio_v7_7_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbio_v7_7_get_clockgating_state,
 	.ih_control = nbio_v7_7_ih_control,
 	.init_registers = nbio_v7_7_init_registers,
 };
-- 
2.25.1

