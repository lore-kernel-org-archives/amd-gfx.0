Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3434EC02181
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jan 2025 08:37:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FDD510E053;
	Sun, 26 Jan 2025 08:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DEQbO8oX";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5985910E0F1
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jan 2025 08:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmDomJ5ItWp5hMwRjJIiPC0fuvWQHVCCUGQoaCNYBrI035w65IaqUQgVejOuG+0rPHqQXwJINLVsOwgqQ6vjhqXvuGSuSSFN+1dSv+ojAs2VTtSGqcEbn50DgJ13zkDDavu0+ywPA+hqV+iL6lt9rLnO64TVU+3M6NKnpd383/NNavvnoikPy5JSptlCd2HQPVxlV5AfLuDLdZ3DeN9mLdrhKAQVlubWTg6VYPSufuVfWZqKoazIFASQl2bYxXFSQidnG5uNUE4kzbL1is29OUbFZBhoJhZrR1nEadzgUJv1ylVkI4lRIJExidf/b9G6BReItJuwoNWY7YEUEkzKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXyX2BrPMKG+8AYdpVYaj1rG7k62Y/18VCvi6Od3OrY=;
 b=olsZJQaR0mMjbTz+mh+EEe3csYy37KkqvBkPebYlMpMIKqFrl4mLNUsr/j+Amk2FEEwKlhjodDFaeJqeXdctgXmQirOB4lsUVJmanVh0lDoIqiHv/T4pyrALVid/BM0egIw0FFlSbXjbXU49CSQglw12UugrMjC3DhXCUfKx/dk5F7TBsJrWC2gVRRW9g8s81I0d3nYNYFYrm2h6A+XY1qqPTCJC4otrAAMsROtrv+49a2SuKlEOhsmfLRMC1YZzDsMx2k/0T1CsDYtKEuv5fJsqM8aohUNS8dNeGyyuLljT0daYFjTmBibvQ0aEyG1mzlwFcISe+fkWh0vjeZGuvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXyX2BrPMKG+8AYdpVYaj1rG7k62Y/18VCvi6Od3OrY=;
 b=DEQbO8oXdZLm0ja2D/wt4ZDffYpNQiDN3MzQ3mWwPK7mphICpJJbDDf6jMKJx2Pa2eJKpNkRUWKzYhrLNFvQdob4vPK3SqqaacAtOGUPn5CZCvSNRAiHHY0SFhSaSbka/RDHUqOaiZfXY0Rxbr5+wSeWc2nnFYFMcyX7tSRZBNs=
Received: from BN9PR03CA0891.namprd03.prod.outlook.com (2603:10b6:408:13c::26)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 08:37:45 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::1e) by BN9PR03CA0891.outlook.office365.com
 (2603:10b6:408:13c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sun,
 26 Jan 2025 08:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 08:37:44 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 02:37:42 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/gfx11: Implement the GFX11 KGQ pipe reset
Date: Sun, 26 Jan 2025 16:37:30 +0800
Message-ID: <20250126083733.3331474-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef5819f-1661-458a-2dbc-08dd3de4b498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BX7DaBxjzVUvuXJ9GllqwdLNuIAC+/jdEwzlwxd/bi8WTOaIzgodPelktUJX?=
 =?us-ascii?Q?ii3iIWGX9JKOYGxVc0IOnfRw8evk8bxEjKX8+XnlRinNkJ9BWTt+KRvnxSuS?=
 =?us-ascii?Q?lht2xza/9j4zG1NJ4P0eD0wgG/wu2U1Gwe77Th87qzek6OPMBTjkU8+bCiMz?=
 =?us-ascii?Q?e8/ye/qGF/Fw14qzr/qDcZvm33LyQaC5LZI0G0R0zrKDCZx3+tubI4aJ7mEn?=
 =?us-ascii?Q?rqOFVm+aS9zLTi5rl9uPw68F0jtfi+RBw1K0wh6rdqwKl2mfGzxn3RUU5FnF?=
 =?us-ascii?Q?CgmKQKbnOPRfdXx+ZTFUkbEnP6VO0GBqHSrTF6Iv7YMq2hR1eir2joPyjxfc?=
 =?us-ascii?Q?AAzMLKuPSWksjf+q2YKeMevk226lbJ8XK6c47z+Lllm72pQwSj4QuyHvj74q?=
 =?us-ascii?Q?/la2loS3TxQkIqHXFQlb1ev7wMU7uf2nxBXgoPKxHaGA8aoYJvcMYUIuhS/F?=
 =?us-ascii?Q?lAmUXexwEobGiZc5H9l3LnyZ3/dgfGPipjO4uB/OhnrXmXGWG7HP90FXfQBN?=
 =?us-ascii?Q?qkbQJe1kAp9WDSI815KvmrzU/eZ5qRh3NWRf0H/ruPnARdfnTWc4GasLN9lK?=
 =?us-ascii?Q?c69yMu/AvdZav0drbWNQMvHvgd6ZnZwyWMfQTyylv2mCd/nwRJIBA5fXqOpQ?=
 =?us-ascii?Q?r78rRhNBwSWgbO6pfhwv0IEgVPrsxget28kMXXZ2iTMPoRXgyHHs2Ugp6a/X?=
 =?us-ascii?Q?CdZcvevvK2opAHWON3snb04ygXebJvMBf0GSDBF2//D/yny6VQwUIuY7DfkF?=
 =?us-ascii?Q?Oz/HXVGhyBtYO6YIS1d9R+wSDVNmZ6+ndj1FVEpCX6EwG6TMrr6UDL1RI/L/?=
 =?us-ascii?Q?HqjCOAFphUBUEjBHv2x2FjsCKOXPyo+OhBy7qLPZLGH2dwfJSlU02jpW2PPj?=
 =?us-ascii?Q?whVqxqD2BBG0kcJeM6vm7S4jXoO5otYGBGykKbt+eK9Y/eEUHgo1xTzPGdGH?=
 =?us-ascii?Q?BwxBzpIFxezBu6Kh59DffIrm/pRnY/C+PyQ0ZbeFTHA4F4iAH86fmLAVavRI?=
 =?us-ascii?Q?SP36M06YNJABAd27nbtuXkGxCPYq5cXxrFQCOG/e9PRFrmmffchqUPcexpsJ?=
 =?us-ascii?Q?03X09BDmme58KwzaLx+ll5RTUBAHcHzImbD9XR349DlO0oMSiGRNZCj+5KEr?=
 =?us-ascii?Q?2O5a0Fi441s8GOFH5VAPGN9WGBB1eZR3SL6p584SgOmF60Oc9+eEyPK9cwOw?=
 =?us-ascii?Q?NT+p+tPrh5+XtMjYpV3dIRDCJcyUYLINwxz7B82ib7ec6fAV5+5kCsFaRIau?=
 =?us-ascii?Q?ZUX90BelrA7FR2PrjVGR/aM7QhlKxZZa7xji0xnzjmB0nGkBcunPfTQ19mXB?=
 =?us-ascii?Q?jek2lpwbTM3z2RC6WvL+tpA1u3i+FvTlMq2O9naWCPMD/Wfdtz7/H5KgExat?=
 =?us-ascii?Q?IkpQprVxMILi50mvLF6+gDoKpuJ1njnzodlqzfIpLBBkprMK5+eFUcBo/Vh8?=
 =?us-ascii?Q?iyCyJ7oN39rEvwRGpUiRRO0s7hprEdGQkVKUVlRFDbbqxFMB3bSG9C80Djzf?=
 =?us-ascii?Q?rhP02gBk0ugT5v8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 08:37:44.7563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef5819f-1661-458a-2dbc-08dd3de4b498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
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

Implement the kernel graphics queue pipe reset,and the driver
will fallback to pipe reset when the queue reset fails. However,
the ME FW hasn't fully supported pipe reset yet so disable the
KGQ pipe reset temporarily.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 76 +++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 89d17750af04..395872bb1401 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -65,6 +65,8 @@
 #define regPC_CONFIG_CNTL_1		0x194d
 #define regPC_CONFIG_CNTL_1_BASE_IDX	1
 
+static uint32_t me_fw_start_pc;
+
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mec.bin");
@@ -2932,6 +2934,9 @@ static void gfx_v11_0_config_gfx_rs64(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 0);
 	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 0);
 	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
+
+	/* cache the firmware start PC */
+	me_fw_start_pc = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1));
 }
 
 static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
@@ -6654,6 +6659,68 @@ static void gfx_v11_0_emit_mem_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }
 
+static bool gfx_v11_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/* Disable the pipe reset until the CPFW fully support it.*/
+	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
+	return false;
+}
+
+
+static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!gfx_v11_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	gfx_v11_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc21_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+	switch (ring->pipe) {
+	case 0:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE0_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE0_RESET, 0);
+		break;
+	case 1:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   PFP_PIPE1_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_CNTL,
+					   ME_PIPE1_RESET, 0);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, reset_pipe);
+	WREG32_SOC15(GC, 0, regCP_ME_CNTL, clean_pipe);
+
+	r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) - me_fw_start_pc;
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v11_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev,"The ring %s pipe reset to the ME firmware start PC: %s\n", ring->name,
+			r == 0 ? "successfuly" : "failed");
+	/* FIXME: Sometimes driver can't cache the ME firmware start PC correctly, so the pipe reset status
+	 * relies on the later gfx ring test result.
+	 */
+	return 0;
+}
+
 static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6663,8 +6730,13 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 		return -EINVAL;
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
-	if (r)
-		return r;
+	if (r) {
+
+		dev_warn(adev->dev,"reset via MES failed and try pipe reset %d\n", r);
+		r = gfx_v11_reset_gfx_pipe(ring);
+		if (r)
+			return r;
+	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
 	if (unlikely(r != 0)) {
-- 
2.34.1

