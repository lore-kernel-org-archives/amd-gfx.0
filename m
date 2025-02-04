Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3E5C02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 23:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 447C110E706;
	Tue,  4 Feb 2025 23:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hVihLWyS";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E7810E706
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 23:03:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhO8tpyR68u5mKOdHyFWIxsjvHA+Bw/3tVMe7Ohp1Zy2CBF327g3NSvMw0ycrGP27E/I32mpN9ppxDBVhhsGoaOOWdnKrRL1AOiC1GioZxclOoJtqu5xdUER8YpVUTZTPeyxJHBCXUvRVgMz+mh4LeQg6teu4K+c591Vjw4dmLXlHSChu/NsH9QSAwC2FoLpi9welLUVkDfekea40R7EGl54hobgaKsSsT6CZzYBLGkMfr5ihysY/lynW/yvxER1AfK3KDKVM1uyXipOcOWqV6xM/zUZVV2hzwLQiWv1PAMjNUab8NStKo688mUq3qubCzFXNDRSgmA/7+gn2VZKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I3zeiEy36dUw4jhxf8wAFf0KFohT1YfF9nPnSukS7A=;
 b=rhR9DKqeIazWa607mK0JBdrs7dz4R2VnhPNpnXvAEWJhQ+Ho5REsKX3LCq2BFvHmxxngqZMGM6CNqVKdXpMMYxRFl2bBKxnPSujVp2iUnmoJkdXdItqBGPvDiYs8H61aeNC8/WUHs/ZSeQvufYDtpbvHoXl3OY21X1OwwZLFdykkHJbWPkSIQUjdshwrlNtCvt8l4H1shMv/wF3UHAkEX7CuQMlwpUmL1iSjND5krS3nsiqVeXK1k2QaOLYLF0oybwnJ2Llz7PjTpIGppsNT0ThzZYRY0jrZoE7Mb2daDKG6cFDDF2IBTEUvXjWnH8Z+WYX2/KcFCpmTSfh7O+6sYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I3zeiEy36dUw4jhxf8wAFf0KFohT1YfF9nPnSukS7A=;
 b=hVihLWyS1+qs93cGZ8d9JMJVbGgJsxeS9inLD8ig8r3Dfsscc+8ulOJCH6AngvC2iQmH8TK+uDR8do7xB+9r9P10as8BzVdrdku8B1+fokUnadhqcsdjwYd55YkbLEqaALFy9L5XMAasry5tDXc1z0UnX5NYJN+ruYaYduUfbII=
Received: from CH0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:610:11a::29)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 23:03:26 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::2c) by CH0PR03CA0345.outlook.office365.com
 (2603:10b6:610:11a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Tue,
 4 Feb 2025 23:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 23:03:25 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Feb 2025 17:03:25 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdgpu: Set snoop bit for SDMA for MI series
Date: Tue, 4 Feb 2025 18:02:35 -0500
Message-ID: <20250204230235.150757-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 0517bc9c-366c-44fe-a3b3-08dd45702193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WOujqCTeIuw57TSRXTK/VgOI7UCxCRiqP9BDCK68oDu9ZC80kUIIMpL51SO8?=
 =?us-ascii?Q?C49yHCGkt7JiuZs4oZ8XP2kE2rI2f7pUsl4k2lNvXHn/dTSZbwz0HkJPbf8H?=
 =?us-ascii?Q?6Vgt4sYsDBYrxsgurd9H5dB1LJlkxxXz1R0loZsiW6tKBIo0ukoSgprkSKTU?=
 =?us-ascii?Q?vjwBUjDXzo31DETosHDl6ZqRm0SAIP+ucTIoksi/SfMHzjN5zu96DMqKKrzm?=
 =?us-ascii?Q?OWLHzL88ylV5k3+zV+AxZcqa3crJ9ALR/hSlJarolgwxt7k9SnZ9Adzn/LBc?=
 =?us-ascii?Q?JxD2QkYJh7wr/m9ldztBjclrqzaW0k3YXzP6a6BiYzLJu8drUkeTK1uxDtNS?=
 =?us-ascii?Q?MOSQtMxvX43ykn+amI1VGU603thwHTQjNdRu0LmNNHREDqE9aLQawxFUtkrG?=
 =?us-ascii?Q?aDNzfIhd1o8ozIItSR4fB2+PHbJRnIAFbBRew8YAp6WRgl5uGqmS4YE9XhYW?=
 =?us-ascii?Q?7SvewiKY2v8U06Jyo6LVP04yHfQuEy5LGLdhWgF6x/4XEMJ0iqvgurMmVdww?=
 =?us-ascii?Q?Rncqq42o2AqwlrJC93Ifk4wiWc1Jw1/u2yVlRe8EBcf3qIvdmZpABAxbfRwt?=
 =?us-ascii?Q?Cpu9ETmUnt9yOeLQqaoRAI03o4uRCmyXONF9gbSDn2oTZHVf/7ZJDsZBA+BV?=
 =?us-ascii?Q?dJ92PASkrGRkcG0pUQ+sd8Ku50yNilmvger9lSuP6FB55fGbtWbrLX+ez2+D?=
 =?us-ascii?Q?Wams3wh4BGU9XWrbnMej44Qxh/eXw/vg2MHdgrzgc+SBqlqO2EnX0s+G2YBh?=
 =?us-ascii?Q?EMJ3zC/EKJTzsfJNwb6ofHkw0uPfwmPuBuQyeLsfrhYE4NFZFsnh1May+GNY?=
 =?us-ascii?Q?agx/+VuamrRyj16ClP+Cog5w2jlWx7oMK9J5GslHYl160FfzjDbbFRrNWET0?=
 =?us-ascii?Q?23baurQI6ICJFZhC/oifVkmpmQamUZ79XYZj6W3wc011A9ccLTW03KnbkteN?=
 =?us-ascii?Q?U0FdhvnjwQCLbypdkXkVn9nvJtVJ6MMt/j5frox35xZ3J1cED9PpV0eAkyCL?=
 =?us-ascii?Q?aebOJamykXWN/LUphZnMxtRrisj/h2o2VGj91xzKT6AE3CPT9oECd2cnHE2+?=
 =?us-ascii?Q?H9l1aZAEKOTKxC8LNzYha/XMT+DIrtnqES/15RXqiRhLQ1RNec1OYS28gr84?=
 =?us-ascii?Q?LyJluP6pmgP8xwJGCAcittYRe1m9ekMhQ2fvShgaU3Fx1sxx/b6y/wG6NebE?=
 =?us-ascii?Q?Us2gB0hjhICQd3VLVzDSkugYpnCbcj5u3UyhdmXx3F9Mc4zaYaMPSldSvWYN?=
 =?us-ascii?Q?S34aub8mC8kJdkxciqaiCEXF6W52bTcDzUIxEEJO9k2L+Nti+32Q1O5F8OVl?=
 =?us-ascii?Q?tz+3qcjimRWRevM9vZ2DD9N8AJdSjDvYQWPTGE0g1taZkY/ji6j7M3D5LItT?=
 =?us-ascii?Q?1EEKrBdpKNGB4ju+0KJGBe/QKB1UUTYD5EZBsmwNHl7HOyEgtDY3Q0vYDobc?=
 =?us-ascii?Q?5pRtiqDILpX87JLmXWZyd9Fv3EY+cTOPwy3+li0xpxD9nJYvZo8B6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 23:03:25.7674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0517bc9c-366c-44fe-a3b3-08dd45702193
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
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

SDMA writes has to probe invalidate RW lines. Set snoop bit in mmhub for
this to happen.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c       | 25 ++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c       | 27 +++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 30 ++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_offset.h       | 32 +++++++++++++
 .../asic_reg/mmhub/mmhub_9_4_1_sh_mask.h      | 48 +++++++++++++++++++
 5 files changed, 162 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 9689e2b5d4e5..55659a4cbd10 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -172,6 +172,30 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(MMHUB, 0, regMC_VM_MX_L1_TLB_CNTL, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_7_set_snoop(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+	int j;
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	for (j = 0; j < 5; j++) { /* DAGB instances */
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j*distance);
+		tmp |= (1 << 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j*distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j*distance);
+		tmp |= (1 << 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j*distance, tmp);
+	}
+
+}
+
 static void mmhub_v1_7_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
@@ -337,6 +361,7 @@ static int mmhub_v1_7_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_7_init_system_aperture_regs(adev);
 	mmhub_v1_7_init_tlb_regs(adev);
 	mmhub_v1_7_init_cache_regs(adev);
+	mmhub_v1_7_set_snoop(adev);
 
 	mmhub_v1_7_enable_system_domain(adev);
 	mmhub_v1_7_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index e646e5cef0a2..92afffd27415 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -213,6 +213,32 @@ static void mmhub_v1_8_init_tlb_regs(struct amdgpu_device *adev)
 	}
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v1_8_set_snoop(struct amdgpu_device *adev)
+{
+	uint32_t tmp, inst_mask;
+	int i, j;
+	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask) {
+		for (j = 0; j < 5; j++) { /* DAGB instances */
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j*distance);
+			tmp |= (1 << 15); /* SDMA client is BIT15 */
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE, j*distance, tmp);
+
+			tmp = RREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j*distance);
+			tmp |= (1 << 15);
+			WREG32_SOC15_OFFSET(MMHUB, i,
+				regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE, j*distance, tmp);
+		}
+	}
+}
+
 static void mmhub_v1_8_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp, inst_mask;
@@ -418,6 +444,7 @@ static int mmhub_v1_8_gart_enable(struct amdgpu_device *adev)
 	mmhub_v1_8_init_system_aperture_regs(adev);
 	mmhub_v1_8_init_tlb_regs(adev);
 	mmhub_v1_8_init_cache_regs(adev);
+	mmhub_v1_8_set_snoop(adev);
 
 	mmhub_v1_8_enable_system_domain(adev);
 	mmhub_v1_8_disable_identity_aperture(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index ff1b58e44689..557119cd1ecc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -198,6 +198,35 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
 			    hubid * MMHUB_INSTANCE_REGISTER_OFFSET, tmp);
 }
 
+/* Set snoop bit for SDMA so that SDMA writes probe-invalidates RW lines */
+static void mmhub_v9_4_set_snoop(struct amdgpu_device *adev, int hubid)
+{
+	uint32_t tmp;
+	int j;
+	uint32_t distance = mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
+			    mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
+
+	for (j = 0; j < 4 - (2 * hubid); j++) {
+		/* DAGB instances 0 to 4 are in hub0 and 5 to 7 are in hub1 */
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance);
+		tmp |= (1 << 15); /* SDMA client is BIT15 */
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance, tmp);
+
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance);
+		tmp |= (1 << 15);
+		WREG32_SOC15_OFFSET(MMHUB, 0,
+			mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE,
+			hubid * MMHUB_INSTANCE_REGISTER_OFFSET + j * distance, tmp);
+	}
+
+}
+
 static void mmhub_v9_4_init_cache_regs(struct amdgpu_device *adev, int hubid)
 {
 	uint32_t tmp;
@@ -392,6 +421,7 @@ static int mmhub_v9_4_gart_enable(struct amdgpu_device *adev)
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_init_cache_regs(adev, i);
 
+		mmhub_v9_4_set_snoop(adev, i);
 		mmhub_v9_4_enable_system_domain(adev, i);
 		if (!amdgpu_sriov_vf(adev))
 			mmhub_v9_4_disable_identity_aperture(adev, i);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
index c488d4a50cf4..b2252deabc17 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_offset.h
@@ -203,6 +203,10 @@
 #define mmDAGB0_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB0_WR_MISC_CREDIT                                                                         0x0058
 #define mmDAGB0_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x005b
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x005c
+#define mmDAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB0_WRCLI_ASK_PENDING                                                                      0x005d
 #define mmDAGB0_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB0_WRCLI_GO_PENDING                                                                       0x005e
@@ -455,6 +459,10 @@
 #define mmDAGB1_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB1_WR_MISC_CREDIT                                                                         0x00d8
 #define mmDAGB1_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x00db
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x00dc
+#define mmDAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB1_WRCLI_ASK_PENDING                                                                      0x00dd
 #define mmDAGB1_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB1_WRCLI_GO_PENDING                                                                       0x00de
@@ -707,6 +715,10 @@
 #define mmDAGB2_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB2_WR_MISC_CREDIT                                                                         0x0158
 #define mmDAGB2_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x015b
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x015c
+#define mmDAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB2_WRCLI_ASK_PENDING                                                                      0x015d
 #define mmDAGB2_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB2_WRCLI_GO_PENDING                                                                       0x015e
@@ -959,6 +971,10 @@
 #define mmDAGB3_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB3_WR_MISC_CREDIT                                                                         0x01d8
 #define mmDAGB3_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x01db
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x01dc
+#define mmDAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB3_WRCLI_ASK_PENDING                                                                      0x01dd
 #define mmDAGB3_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB3_WRCLI_GO_PENDING                                                                       0x01de
@@ -1211,6 +1227,10 @@
 #define mmDAGB4_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB4_WR_MISC_CREDIT                                                                         0x0258
 #define mmDAGB4_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x025b
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x025c
+#define mmDAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB4_WRCLI_ASK_PENDING                                                                      0x025d
 #define mmDAGB4_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB4_WRCLI_GO_PENDING                                                                       0x025e
@@ -4793,6 +4813,10 @@
 #define mmDAGB5_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB5_WR_MISC_CREDIT                                                                         0x3058
 #define mmDAGB5_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x305b
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x305c
+#define mmDAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB5_WRCLI_ASK_PENDING                                                                      0x305d
 #define mmDAGB5_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB5_WRCLI_GO_PENDING                                                                       0x305e
@@ -5045,6 +5069,10 @@
 #define mmDAGB6_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB6_WR_MISC_CREDIT                                                                         0x30d8
 #define mmDAGB6_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x30db
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x30dc
+#define mmDAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB6_WRCLI_ASK_PENDING                                                                      0x30dd
 #define mmDAGB6_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB6_WRCLI_GO_PENDING                                                                       0x30de
@@ -5297,6 +5325,10 @@
 #define mmDAGB7_WR_DATA_CREDIT_BASE_IDX                                                                1
 #define mmDAGB7_WR_MISC_CREDIT                                                                         0x3158
 #define mmDAGB7_WR_MISC_CREDIT_BASE_IDX                                                                1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE                                                               0x315b
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_BASE_IDX                                                      1
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE                                                         0x315c
+#define mmDAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE_BASE_IDX                                                1
 #define mmDAGB7_WRCLI_ASK_PENDING                                                                      0x315d
 #define mmDAGB7_WRCLI_ASK_PENDING_BASE_IDX                                                             1
 #define mmDAGB7_WRCLI_GO_PENDING                                                                       0x315e
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
index 2969fbf282b7..5069d2fd467f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_9_4_1_sh_mask.h
@@ -1532,6 +1532,12 @@
 //DAGB0_WRCLI_DBUS_GO_PENDING
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB0_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB0_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB0_DAGB_DLY
 #define DAGB0_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB0_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -3207,6 +3213,12 @@
 //DAGB1_WRCLI_DBUS_GO_PENDING
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB1_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB1_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB1_DAGB_DLY
 #define DAGB1_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB1_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -4882,6 +4894,12 @@
 //DAGB2_WRCLI_DBUS_GO_PENDING
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB2_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB2_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB2_DAGB_DLY
 #define DAGB2_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB2_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -6557,6 +6575,12 @@
 //DAGB3_WRCLI_DBUS_GO_PENDING
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB3_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB3_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB3_DAGB_DLY
 #define DAGB3_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB3_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -8232,6 +8256,12 @@
 //DAGB4_WRCLI_DBUS_GO_PENDING
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB4_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB4_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB4_DAGB_DLY
 #define DAGB4_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB4_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -28737,6 +28767,12 @@
 //DAGB5_WRCLI_DBUS_GO_PENDING
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB5_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB5_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB5_DAGB_DLY
 #define DAGB5_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB5_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -30412,6 +30448,12 @@
 //DAGB6_WRCLI_DBUS_GO_PENDING
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB6_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB6_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB6_DAGB_DLY
 #define DAGB6_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB6_DAGB_DLY__CLI__SHIFT                                                                            0x8
@@ -32087,6 +32129,12 @@
 //DAGB7_WRCLI_DBUS_GO_PENDING
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY__SHIFT                                                              0x0
 #define DAGB7_WRCLI_DBUS_GO_PENDING__BUSY_MASK                                                                0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE__SHIFT                                                         0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE__ENABLE_MASK                                                           0xFFFFFFFFL
+//DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE__SHIFT                                                   0x0
+#define DAGB7_WRCLI_GPU_SNOOP_OVERRIDE_VALUE__ENABLE_MASK                                                     0xFFFFFFFFL
 //DAGB7_DAGB_DLY
 #define DAGB7_DAGB_DLY__DLY__SHIFT                                                                            0x0
 #define DAGB7_DAGB_DLY__CLI__SHIFT                                                                            0x8
-- 
2.34.1

