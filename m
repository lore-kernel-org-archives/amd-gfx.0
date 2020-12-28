Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B901AC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C13A207CC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C13A207CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FBA89A75;
	Mon, 28 Dec 2020 09:18:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28FC889A5D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 09:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nfohx8C5Yv5R6B7iAobfA+TsmCkY0IDIr8hjn4d3FTlB3FIpi514emO4iG235InVpd/KzRvRamFRK+w4eWzHHpOzF7K8MkzHN90K6TK+JpR/Ghm0sMwItLjm/4yTN6rDimy6YCcMIibRACBvwkuGCFhqUErVE4/2AOstmrhs8LZAYlduJ3PeAtpjJLYewHOy1N8wqovG11nKFP2fDq72qv7NWIRlHoVtipVcyO5vMUm9ouVTTRdSWRZqmsxFETK+uHVE4g3G/F3K+s/3RSPwumP41kepJ3pFQNflnMrda01ku1r/Km8U4pcoMYyBo0vSuzXxv2b5iiyj6/xQ3Va61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikyypUz/VWzJIXO4m1AxhKU6dA5kife0WLvwQv/zXSI=;
 b=PrzXt9PNDgYW5ZOBzB8raoAV1xlfb+UiOeLuKFlvSL1MtwURtDCBIS+WgsStwdams3AF4u16TIJIB62rJU2Tg4MSTGZ+KwV++Mpy7Wgv+ZzVN641DsxF80fs4e+eL4i8dEpzsSFr2hYQC7EQMVyAspl4A2j4MC88kb6CavoB7e7CWJZ2+vuwydl/d6h5O1ZksGIZ7AOYpS5dSoS4+iDaKaV+sVJcpEYAa5aQ1wpP9MKnDYepd+BfTsxwsUp7IoU1g9Z/yWVHDQvAXC1649o7RMfaUYKaxgYNtrJrY4OCm82AXWmZt7GnSg7gm9S4t91O+rD8snrtF7kEf3meH/6k/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikyypUz/VWzJIXO4m1AxhKU6dA5kife0WLvwQv/zXSI=;
 b=huwF72aP7Nf/bciCVpmj1PWRI9gHbDZ7ZAVd2An2v4rOjEylN3+zWuEmDYogGenAAT5RzE9DKQuSb7SdCrj+HZxbTEePTbsZYe/6zYq9gGqy5qdQYZoCPDI3ZVAwaqAOmY9UMPGm9h9ewwgBTj30oVKXh6iKrQhb9Y51h3GOW+Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 09:18:51 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Mon, 28 Dec
 2020 09:18:51 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: add hdp version 4 functions
Date: Mon, 28 Dec 2020 17:18:30 +0800
Message-Id: <20201228091834.3240927-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.12 via Frontend Transport; Mon, 28 Dec 2020 09:18:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4cdb6a7-9dc0-437c-f2e3-08d8ab11973b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45083115BC989C13593CC769EFD90@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6a/GaiRT9iKJwVJSHZFpKdH37eNXlHSKBqiCWyCLQFPSmRuy4kjE1f9+DCfP7mOw94R4gVnUjbqvvmr+/jE9TwQjUA0YRLD49hzmy7voJAZJYykn3h5gftcQiTtGgR+lta1rOVPBtf2Alu88Att7tBn7azKOt0YD1lVaCPdsUPP5qBcyFQcA8n00QMzx7Py02LNsafrzOrErs78K+DLyMwO3r5ePJAxlgTWb9bSsXLhz92aqmYyPXTlgO6XaoeeCfqzQjg9qiD8kczgDOVph6ojvv84bZTmMbaZlXSNxuI8ToiC+4dc+p8SjKJX9S432piAeIP1WbDa7SY+etbO2Hi3fIlX67xkeWnO2okgDCCE5agBT1bVscAiPDeJNgC66AmRmnfcF8Vki5csO54pLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(16526019)(66946007)(316002)(2616005)(956004)(478600001)(86362001)(83380400001)(44832011)(4326008)(6666004)(8936002)(8676002)(52116002)(36756003)(1076003)(7696005)(6486002)(5660300002)(26005)(54906003)(2906002)(186003)(66556008)(66476007)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6gUPZjDg0LDr5MumXFmRz1JPNDV2kA008Z4Pr0yKtalVu+bzOPGeoydjrJoQ?=
 =?us-ascii?Q?VJ3/54o0gP3EyXbEwPfSdLIGV09yEflIhOiQFomGLRpyq5omfde6lTXizIg8?=
 =?us-ascii?Q?BJr+CuVHimFaKoX77RnssboYKv9gJEGLcZF7a/Vox1uX5KQju09UwOYALugr?=
 =?us-ascii?Q?zVPSM0MLW5aptIDT+FJPFjg9tgGgpf2npCxEOOZOwX08ap38PyBiMjkXVOuC?=
 =?us-ascii?Q?viC7RjEkY1TjCFRDDpL4/zdQX6Fnro+WnYuhdVlNVTGKhYLutnoDZ7htK/iX?=
 =?us-ascii?Q?ojgz0TienVHX+06AaB3D25xrbHYfaGeSwHT41Tm1YiRiO9vjHUJOOxjoTbBG?=
 =?us-ascii?Q?1Ts/WjW0c4GtO+aXfrmH0h50U1L21ASHZa6pnLk0jdRWandVQG0/o8U85rSN?=
 =?us-ascii?Q?iQ8H8RpFSZ1vTXPJ0gZQJf+1kQyXNU64HLh6SjMI0tqwt2rduxQSAcPi0cir?=
 =?us-ascii?Q?ITSMEiJFfgvVuiHtyzqARNzWiPmPH0XEfMtaltwRaVzOMFAxuKEybeO/e6MB?=
 =?us-ascii?Q?qyTGDgqSXX+TEpd2h53IPjtAJ8tC6tkGyV6+hk56Xcs3sI4/1KjQVwXp02qb?=
 =?us-ascii?Q?yL42vIHSIOEFKHQ6p4yantlmE9Rp60QjBGt1QSrNzid7c6j7S8pRuaoG6yYH?=
 =?us-ascii?Q?5ptAcwNBo5IECTauaYzTgOvUcPD3qXmFiuxqjpQmn62zpdjUWNKn8AO2fOty?=
 =?us-ascii?Q?tfqi6I2nJoA+RSEnUXAnaXv1hYmkAj+V2A8jbMSjnxewYHFYZZQHgxBLEC0t?=
 =?us-ascii?Q?n48Rq5TeJ+y6C9tSsJfNLLDLL8zUT7vu9HKDuW04YWppS79rxRu6KjHgJ3QQ?=
 =?us-ascii?Q?ifB5rD1lkxk1fNNxOfrqZifm9EGBQ25E55vvyh46ddOzxVmzrpoINXHHKMOK?=
 =?us-ascii?Q?Om8ADeBDXyNh+xwoq7I22utSpXP/zGLkutanwMuDcC8c6SGrUv6crR+ixiBL?=
 =?us-ascii?Q?0TSvVW0HFmP3hO/r2TJctOtE5lT8TxrbTBtIWPXVB9OLEGJJbVEsyQUFfPRY?=
 =?us-ascii?Q?JTUs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 09:18:51.1438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cdb6a7-9dc0-437c-f2e3-08d8ab11973b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgbtl2rPSW2akA6umhS3rVMjBxKSP9eE+xJOnZIrWacNDvintVP1TV3FB/qfoGmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Unfiy hdp related function into hdp structure for hdp version 4.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I0462a24f0fae08b3d36c01a8f0df81599377c048
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 150 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h |  31 ++++++
 2 files changed, 181 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
new file mode 100644
index 000000000000..58cf0670d8af
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "hdp_v4_0.h"
+#include "amdgpu_ras.h"
+
+#include "hdp/hdp_4_0_offset.h"
+#include "hdp/hdp_4_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+#define mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL               0x00f7
+#define mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL_BASE_IDX      2
+/* for Vega20 register name change */
+#define mmHDP_MEM_POWER_CTRL    0x00d4
+#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK  0x00000001L
+#define HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK    0x00000002L
+#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK   0x00010000L
+#define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK             0x00020000L
+#define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
+
+static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	uint32_t reg_addr;
+
+	if (adev->flags & AMD_IS_APU ||
+	    adev->asic_type == CHIP_VEGA20 ||
+	    adev->asic_type == CHIP_ARCTURUS)
+		reg_addr = (adev->rmmio_remap.reg_offset +
+			    KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2;
+	else
+		reg_addr = SOC15_REG_OFFSET(NBIO, 0,
+				mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL);
+
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ(reg_addr, 0);
+	else
+		amdgpu_ring_emit_wreg(ring, reg_addr, 0);
+}
+
+static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
+				    struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_SOC15_NO_KIQ(HDP, 0, mmHDP_READ_CACHE_INVALIDATE, 1);
+	else
+		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
+			HDP, 0, mmHDP_READ_CACHE_INVALIDATE), 1);
+}
+
+static void hdp_v4_0_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__HDP))
+		return;
+	/*read back hdp ras counter to reset it to 0 */
+	RREG32_SOC15(HDP, 0, mmHDP_EDC_CNT);
+}
+
+static void hdp_v4_0_update_clock_gating(struct amdgpu_device *adev,
+					 bool enable)
+{
+	uint32_t def, data;
+
+	if (adev->asic_type == CHIP_VEGA20 ||
+	    adev->asic_type == CHIP_ARCTURUS ||
+	    adev->asic_type == CHIP_RENOIR) {
+		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL));
+
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+			data |= HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
+				HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
+				HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
+				HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK;
+		else
+			data &= ~(HDP_MEM_POWER_CTRL__IPH_MEM_POWER_CTRL_EN_MASK |
+				  HDP_MEM_POWER_CTRL__IPH_MEM_POWER_LS_EN_MASK |
+				  HDP_MEM_POWER_CTRL__RC_MEM_POWER_CTRL_EN_MASK |
+				  HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK);
+
+		if (def != data)
+			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_CTRL), data);
+	} else {
+		def = data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
+
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS))
+			data |= HDP_MEM_POWER_LS__LS_ENABLE_MASK;
+		else
+			data &= ~HDP_MEM_POWER_LS__LS_ENABLE_MASK;
+
+		if (def != data)
+			WREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS), data);
+	}
+}
+
+static void hdp_v4_0_get_clockgating_state(struct amdgpu_device *adev,
+					    u32 *flags)
+{
+	int data;
+
+	/* AMD_CG_SUPPORT_HDP_LS */
+	data = RREG32(SOC15_REG_OFFSET(HDP, 0, mmHDP_MEM_POWER_LS));
+	if (data & HDP_MEM_POWER_LS__LS_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_LS;
+}
+
+static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+	case CHIP_ARCTURUS:
+		WREG32_FIELD15(HDP, 0, HDP_MMHUB_CNTL, HDP_MMHUB_GCC, 1);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
+
+	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> 8));
+	WREG32_SOC15(HDP, 0, mmHDP_NONSURFACE_BASE_HI, (adev->gmc.vram_start >> 40));
+}
+
+const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
+	.flush_hdp = hdp_v4_0_flush_hdp,
+	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
+	.reset_ras_error_count = hdp_v4_0_reset_ras_error_count,
+	.update_clock_gating = hdp_v4_0_update_clock_gating,
+	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
+	.init_registers = hdp_v4_0_init_registers,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
new file mode 100644
index 000000000000..d1e6399e8c46
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __HDP_V4_0_H__
+#define __HDP_V4_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v4_0_funcs;
+
+#endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
