Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52993C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 02:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A42310E030;
	Wed, 13 Dec 2023 02:48:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD2910E030
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 02:48:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cktf+Mc0wOTOiQSqUdfblro7P1joY0ofdZEe0K9cgYhfouufFVui/8qrAcoEARx10NkjT9mNba2P6+TPEsapitJJXHTZ6NTJlYqHBxhUw/jLXVLMpoblpemzAx37rHdV9vYdHCCwSlqivUcJcmcPbQymCHY7mJ64WUfBpa+irJ3urY6o2dZoUyIyArpO40lwfKX8mHV9Ja3+zrShrtU5tsRuDxKDPbV3XGqq04EGfzhFdapZs2ike7BGufO52IBS5flrCjQo7xDT7p482EJZU7OhaBkG9Co+JiFta/7ktpm/35HOhCUR+N5XzHle35OJUf+sb9NRzP3DHBW6wYH1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+NunRTGlt3XwGJDYlwSX8C8GX/91HGovJhn/qzSZ6o=;
 b=Vf6DayQlpAyDOrGLfh3aYt7mx2h+KwNO9kjPSfG0oiGuzoc0wnFawhlIfBv+NDr4Bw2rDAb6nmnEZWbxou/a+71YazB0ySTWTYctiKn2TpIaeVuWhs9kgx3ENLBkVW0kvp18L8IoKs0IrwJyogsg7kXuo+Hc/NvuE3ajId4yB+I9WUU5gLKNHgXK5zKRxXe+4JShBFUnbHptQ0nAbdZ+ITMH3cIlKL8dtlmwuYX9oZpH0nP6JuMAmK0KC79KZObJlSwqQS15LgrdEMPIP87xLmTFbFPNrBZJ85GdWMOlS4Akp0TpngNEk/bsZnOSt0lpsHcUAy6OSIajijp9edKI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+NunRTGlt3XwGJDYlwSX8C8GX/91HGovJhn/qzSZ6o=;
 b=y7ksMBQQhw28eUBpnDHi9ovqstW9PfS92JSXlkMTYoxDYThCcLWOE84FPp3DPtGsvLrip+vpCH22upd3tF6/QMZ20KGYjEs+GfTezZ4y2lZe1jyHZah4vGjrvbViHWRlDy0vRLanIsz+s9z7EujRVlx6iZVGQ71gcYp8A6yUqug=
Received: from MW4PR03CA0152.namprd03.prod.outlook.com (2603:10b6:303:8d::7)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Wed, 13 Dec
 2023 02:48:02 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::6e) by MW4PR03CA0152.outlook.office365.com
 (2603:10b6:303:8d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 02:48:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 02:48:01 +0000
Received: from Peytolee-HPDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 20:47:58 -0600
From: Peyton Lee <peytolee@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/vpe: enable vpe dpm
Date: Wed, 13 Dec 2023 10:49:09 +0800
Message-ID: <20231213024909.1384762-2-peytolee@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213024909.1384762-1-peytolee@amd.com>
References: <20231213024909.1384762-1-peytolee@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f7cbd5-e818-41bd-1a0a-08dbfb85ec5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hFeDEp3pnzgsGl0GN0Ut1uh4Bnr0demTrHaTY6CA7ouVVdd0EZ9sAz4bsIS0JtXs2MLwmTgBWia5aKn3Fw9cbR6vfwFQLT5yd349qw8r0jWYhmzSNgz5p5DCiZx0brVCPazgNPlXtOO8/E581lgrt8ImllbtHC8HdztgFh6cECbV+PmQlcoYZ5N4kYLrn5JkDJoPN8yHKLLGe+E0oARYqGr0M+i0ppDETZIoCfiP4Y5kFKLXPizT+C1QzhECqVk8XrqaXtKtbhjSKcDRfns21CTZ3WS4cReUtdmPlLkjgqFre0Uk0gr8cgV9ttVwi+AfcKGqFxOs948GkMhs7OGP/Sj6lZMhjIvQzpXgjx+iw7UnA2IWdqB6s5o4Cljddzxsjr8gCuaIfgOSExIwDUlo27Aw+OQF1dReepD8piTsZe/ijv2dEHcoduzRwlR61vyIFeeUfloC263EuUzORG/pJgyTVifSCDPzdfoO+cNgLSCDzUgaswJLyor8P1WsqC0iUlSbTeN8+IVw62wttA/jecf7K4TqKSccpGlhAiJ+pIRSqpr9susgmdVu+pdMBP18XRDd2wmjuQMGznzM8D98z/ZGoCzb+MoJYbgg2pxOuaK6KYEB/aKb+AlKgrvDaDkmwM/5FgIr8slhIb9j3nMV06ArUlCgDlYhQ2evS0+wnuAcyMMbpECb0TMG/NuELW4xb51ZHX0kdEheDi8Y4cciOkghx3Q4IL/a8HrLPiLQA71qVm9xO4jv0HR1QQdU5B1fwXGEAqd6zF7lUe2KDAKyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(46966006)(36840700001)(40470700004)(40460700003)(336012)(1076003)(426003)(2616005)(16526019)(26005)(6666004)(7696005)(36860700001)(70586007)(5660300002)(4326008)(478600001)(2906002)(30864003)(41300700001)(8676002)(54906003)(8936002)(70206006)(316002)(83380400001)(6916009)(47076005)(82740400003)(81166007)(36756003)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 02:48:01.6216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f7cbd5-e818-41bd-1a0a-08dbfb85ec5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, Peyton Lee <peytolee@amd.com>,
 Lang Yu <lang.yu@amd.com>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable vpe dpm

Signed-off-by: Peyton Lee <peytolee@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 250 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h |  12 ++
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c   |  15 ++
 3 files changed, 277 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index e81579708e96..2020ddb4182a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_vpe.h"
+#include "amdgpu_smu.h"
 #include "soc15_common.h"
 #include "vpe_v6_1.h"
 
@@ -33,8 +34,186 @@
 /* VPE CSA resides in the 4th page of CSA */
 #define AMDGPU_CSA_VPE_OFFSET 	(4096 * 3)
 
+/* 1 second timeout */
+#define VPE_IDLE_TIMEOUT	msecs_to_jiffies(1000)
+
+#define VPE_MAX_DPM_LEVEL			4
+#define FIXED1_8_BITS_PER_FRACTIONAL_PART	8
+#define GET_PRATIO_INTEGER_PART(x)		((x) >> FIXED1_8_BITS_PER_FRACTIONAL_PART)
+
 static void vpe_set_ring_funcs(struct amdgpu_device *adev);
 
+static inline uint16_t div16_u16_rem(uint16_t dividend, uint16_t divisor, uint16_t *remainder)
+{
+	*remainder = dividend % divisor;
+	return dividend / divisor;
+}
+
+static inline uint16_t complete_integer_division_u16(
+	uint16_t dividend,
+	uint16_t divisor,
+	uint16_t *remainder)
+{
+	return div16_u16_rem(dividend, divisor, (uint16_t *)remainder);
+}
+
+static uint16_t vpe_u1_8_from_fraction(uint16_t numerator, uint16_t denominator)
+{
+	bool arg1_negative = numerator < 0;
+	bool arg2_negative = denominator < 0;
+
+	uint16_t arg1_value = (uint16_t)(arg1_negative ? -numerator : numerator);
+	uint16_t arg2_value = (uint16_t)(arg2_negative ? -denominator : denominator);
+
+	uint16_t remainder;
+
+	/* determine integer part */
+	uint16_t res_value = complete_integer_division_u16(
+		arg1_value, arg2_value, &remainder);
+
+	if (res_value > 127 /* CHAR_MAX */)
+		return 0;
+
+	/* determine fractional part */
+	{
+		unsigned int i = FIXED1_8_BITS_PER_FRACTIONAL_PART;
+
+		do {
+			remainder <<= 1;
+
+			res_value <<= 1;
+
+			if (remainder >= arg2_value) {
+				res_value |= 1;
+				remainder -= arg2_value;
+			}
+		} while (--i != 0);
+	}
+
+	/* round up LSB */
+	{
+		uint16_t summand = (remainder << 1) >= arg2_value;
+
+		if ((res_value + summand) > 32767 /* SHRT_MAX */)
+			return 0;
+
+		res_value += summand;
+	}
+
+	if (arg1_negative ^ arg2_negative)
+		res_value = -res_value;
+
+	return res_value;
+}
+
+static uint16_t vpe_internal_get_pratio(uint16_t from_frequency, uint16_t to_frequency)
+{
+	uint16_t pratio = vpe_u1_8_from_fraction(from_frequency, to_frequency);
+
+	if (GET_PRATIO_INTEGER_PART(pratio) > 1)
+		pratio = 0;
+
+	return pratio;
+}
+
+/*
+ * VPE has 4 DPM levels from level 0 (lowerest) to 3 (highest),
+ * VPE FW will dynamically decide which level should be used according to current loading.
+ *
+ * Get VPE and SOC clocks from PM, and select the appropriate four clock values,
+ * calculate the ratios of adjusting from one clock to another.
+ * The VPE FW can then request the appropriate frequency from the PMFW.
+ */
+int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe)
+{
+	struct amdgpu_device *adev = vpe->ring.adev;
+	uint32_t dpm_ctl;
+
+	if (adev->pm.dpm_enabled) {
+		struct dpm_clocks clock_table = { 0 };
+		struct dpm_clock *VPEClks;
+		struct dpm_clock *SOCClks;
+		uint32_t idx;
+		uint32_t pratio_vmax_vnorm = 0, pratio_vnorm_vmid = 0, pratio_vmid_vmin = 0;
+		uint16_t pratio_vmin_freq = 0, pratio_vmid_freq = 0, pratio_vnorm_freq = 0, pratio_vmax_freq = 0;
+
+		dpm_ctl = RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable));
+		dpm_ctl |= 1; /* DPM enablement */
+		WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable), dpm_ctl);
+
+		/* Get VPECLK and SOCCLK */
+		if (amdgpu_dpm_get_dpm_clock_table(adev, &clock_table)) {
+			dev_dbg(adev->dev, "%s: get clock failed!\n", __func__);
+			goto disable_dpm;
+		}
+
+		SOCClks = clock_table.SocClocks;
+		VPEClks = clock_table.VPEClocks;
+
+		/* vpe dpm only cares 4 levels. */
+		for (idx = 0; idx < VPE_MAX_DPM_LEVEL; idx++) {
+			uint32_t soc_dpm_level;
+			uint32_t min_freq;
+
+			if (idx == 0)
+				soc_dpm_level = 0;
+			else
+				soc_dpm_level = (idx * 2) + 1;
+
+			/* clamp the max level */
+			if (soc_dpm_level > PP_SMU_NUM_VPECLK_DPM_LEVELS - 1)
+				soc_dpm_level = PP_SMU_NUM_VPECLK_DPM_LEVELS - 1;
+
+			min_freq = (SOCClks[soc_dpm_level].Freq < VPEClks[soc_dpm_level].Freq) ?
+				   SOCClks[soc_dpm_level].Freq : VPEClks[soc_dpm_level].Freq;
+
+			switch (idx) {
+			case 0:
+				pratio_vmin_freq = min_freq;
+				break;
+			case 1:
+				pratio_vmid_freq = min_freq;
+				break;
+			case 2:
+				pratio_vnorm_freq = min_freq;
+				break;
+			case 3:
+				pratio_vmax_freq = min_freq;
+				break;
+			default:
+				break;
+			}
+		}
+
+		if (pratio_vmin_freq && pratio_vmid_freq && pratio_vnorm_freq && pratio_vmax_freq) {
+			uint32_t pratio_ctl;
+
+			pratio_vmax_vnorm = (uint32_t)vpe_internal_get_pratio(pratio_vmax_freq, pratio_vnorm_freq);
+			pratio_vnorm_vmid = (uint32_t)vpe_internal_get_pratio(pratio_vnorm_freq, pratio_vmid_freq);
+			pratio_vmid_vmin = (uint32_t)vpe_internal_get_pratio(pratio_vmid_freq, pratio_vmin_freq);
+
+			pratio_ctl = pratio_vmax_vnorm | (pratio_vnorm_vmid << 9) | (pratio_vmid_vmin << 18);
+			WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_pratio), pratio_ctl);		/* PRatio */
+			WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_request_interval), 24000);	/* 1ms, unit=1/24MHz */
+			WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_decision_threshold), 1200000);	/* 50ms */
+			WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_busy_clamp_threshold), 1200000);/* 50ms */
+			WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_idle_clamp_threshold), 1200000);/* 50ms */
+			dev_dbg(adev->dev, "%s: configure vpe dpm pratio done!\n", __func__);
+		} else {
+			dev_dbg(adev->dev, "%s: invalid pratio parameters!\n", __func__);
+			goto disable_dpm;
+		}
+	}
+	return 0;
+
+disable_dpm:
+	dpm_ctl = RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable));
+	dpm_ctl &= 0xfffffffe; /* Disable DPM */
+	WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.dpm_enable), dpm_ctl);
+	dev_dbg(adev->dev, "%s: disable vpe dpm\n", __func__);
+	return 0;
+}
+
 int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev)
 {
 	struct amdgpu_firmware_info ucode = {
@@ -134,6 +313,20 @@ static int vpe_early_init(void *handle)
 	return 0;
 }
 
+static void vpe_idle_work_handler(struct work_struct *work)
+{
+	struct amdgpu_device *adev =
+		container_of(work, struct amdgpu_device, vpe.idle_work.work);
+	struct amdgpu_vpe *vpe = &adev->vpe;
+	unsigned int fences = 0;
+
+	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
+
+	if (fences == 0)
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+	else
+		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
+}
 
 static int vpe_common_init(struct amdgpu_vpe *vpe)
 {
@@ -150,6 +343,9 @@ static int vpe_common_init(struct amdgpu_vpe *vpe)
 		return r;
 	}
 
+	vpe->context_started = false;
+	INIT_DELAYED_WORK(&adev->vpe.idle_work, vpe_idle_work_handler);
+
 	return 0;
 }
 
@@ -219,6 +415,9 @@ static int vpe_hw_fini(void *handle)
 
 	vpe_ring_stop(vpe);
 
+	/* Power off VPE */
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+
 	return 0;
 }
 
@@ -226,6 +425,8 @@ static int vpe_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	cancel_delayed_work_sync(&adev->vpe.idle_work);
+
 	return vpe_hw_fini(adev);
 }
 
@@ -430,6 +631,21 @@ static int vpe_set_clockgating_state(void *handle,
 static int vpe_set_powergating_state(void *handle,
 				     enum amd_powergating_state state)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+
+	if (!adev->pm.dpm_enabled)
+		dev_err(adev->dev, "Without PM, cannot support powergating\n");
+
+	dev_dbg(adev->dev, "%s: %s!\n", __func__, (state == AMD_PG_STATE_GATE) ? "GATE":"UNGATE");
+
+	if (state == AMD_PG_STATE_GATE) {
+		amdgpu_dpm_enable_vpe(adev, false);
+		vpe->context_started = false;
+	} else {
+		amdgpu_dpm_enable_vpe(adev, true);
+	}
+
 	return 0;
 }
 
@@ -595,6 +811,38 @@ static int vpe_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	return ret;
 }
 
+static void vpe_ring_begin_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_vpe *vpe = &adev->vpe;
+
+	cancel_delayed_work_sync(&adev->vpe.idle_work);
+
+	/* Power on VPE and notify VPE of new context  */
+	if (!vpe->context_started) {
+		uint32_t context_notify;
+
+		/* Power on VPE */
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE);
+
+		/* Indicates that a job from a new context has been submitted. */
+		context_notify = RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.context_indicator));
+		if ((context_notify & 0x1) == 0)
+			context_notify |= 0x1;
+		else
+			context_notify &= ~(0x1);
+		WREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.context_indicator), context_notify);
+		vpe->context_started = true;
+	}
+}
+
+static void vpe_ring_end_use(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
+}
+
 static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.type = AMDGPU_RING_TYPE_VPE,
 	.align_mask = 0xf,
@@ -625,6 +873,8 @@ static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.init_cond_exec = vpe_ring_init_cond_exec,
 	.patch_cond_exec = vpe_ring_patch_cond_exec,
 	.preempt_ib = vpe_ring_preempt_ib,
+	.begin_use = vpe_ring_begin_use,
+	.end_use = vpe_ring_end_use,
 };
 
 static void vpe_set_ring_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
index 29d56f7ae4a9..1153ddaea64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.h
@@ -47,6 +47,15 @@ struct vpe_regs {
 	uint32_t queue0_rb_wptr_lo;
 	uint32_t queue0_rb_wptr_hi;
 	uint32_t queue0_preempt;
+
+	uint32_t dpm_enable;
+	uint32_t dpm_pratio;
+	uint32_t dpm_request_interval;
+	uint32_t dpm_decision_threshold;
+	uint32_t dpm_busy_clamp_threshold;
+	uint32_t dpm_idle_clamp_threshold;
+	uint32_t dpm_request_lv;
+	uint32_t context_indicator;
 };
 
 struct amdgpu_vpe {
@@ -63,12 +72,15 @@ struct amdgpu_vpe {
 	struct amdgpu_bo		*cmdbuf_obj;
 	uint64_t			cmdbuf_gpu_addr;
 	uint32_t			*cmdbuf_cpu_addr;
+	struct delayed_work		idle_work;
+	bool				context_started;
 };
 
 int amdgpu_vpe_psp_update_sram(struct amdgpu_device *adev);
 int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_init(struct amdgpu_vpe *vpe);
 int amdgpu_vpe_ring_fini(struct amdgpu_vpe *vpe);
+int amdgpu_vpe_configure_dpm(struct amdgpu_vpe *vpe);
 
 #define vpe_ring_init(vpe) ((vpe)->funcs->ring_init ? (vpe)->funcs->ring_init((vpe)) : 0)
 #define vpe_ring_start(vpe) ((vpe)->funcs->ring_start ? (vpe)->funcs->ring_start((vpe)) : 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
index 174f13eff575..d20060a51e05 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -96,6 +96,10 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 		adev->vpe.cmdbuf_cpu_addr[1] = f32_cntl;
 
 		amdgpu_vpe_psp_update_sram(adev);
+
+		/* Config DPM */
+		amdgpu_vpe_configure_dpm(vpe);
+
 		return 0;
 	}
 
@@ -128,6 +132,8 @@ static int vpe_v6_1_load_microcode(struct amdgpu_vpe *vpe)
 	}
 
 	vpe_v6_1_halt(vpe, false);
+	/* Config DPM */
+	amdgpu_vpe_configure_dpm(vpe);
 
 	return 0;
 }
@@ -264,6 +270,15 @@ static int vpe_v6_1_set_regs(struct amdgpu_vpe *vpe)
 	vpe->regs.queue0_rb_wptr_hi = regVPEC_QUEUE0_RB_WPTR_HI;
 	vpe->regs.queue0_preempt = regVPEC_QUEUE0_PREEMPT;
 
+	vpe->regs.dpm_enable = regVPEC_PUB_DUMMY2;
+	vpe->regs.dpm_pratio = regVPEC_QUEUE6_DUMMY4;
+	vpe->regs.dpm_request_interval = regVPEC_QUEUE5_DUMMY3;
+	vpe->regs.dpm_decision_threshold = regVPEC_QUEUE5_DUMMY4;
+	vpe->regs.dpm_busy_clamp_threshold = regVPEC_QUEUE7_DUMMY2;
+	vpe->regs.dpm_idle_clamp_threshold = regVPEC_QUEUE7_DUMMY3;
+	vpe->regs.dpm_request_lv = regVPEC_QUEUE7_DUMMY1;
+	vpe->regs.context_indicator = regVPEC_QUEUE6_DUMMY3;
+
 	return 0;
 }
 
-- 
2.34.1

