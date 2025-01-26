Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D6EC02181
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jan 2025 08:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E924D10E197;
	Sun, 26 Jan 2025 08:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wp41JSFj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1DB610E197
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jan 2025 08:37:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHjs1STq/VSAA6bSZGSx8rzk8LF9n1aCP93ZobEZ3xo7CY6FHWi7iKpGjMGqgxUgZaDFVtxv7LavJqvG1iN28eS725IxA1JN9Ppubu5woEqGlH9HjBo2ccj857rfEO7JHSN0hEuiNeYqTZQiooMk9IC4TDPpQFXbcX8t3wPgRvPL7nEyVs6O741PbcOnIRCA7TRP6H4xLrjsXO5SHIvwe2MVaLTBFKcbwcmlCNH0gaU3LG+0qHLXuYU2Vv+2bA2RPMxAhWL7/EmG49mHif2wKYgECGvoQRpYEXX54jLVyWFtqyhgyTKlf7xFyzAeXFXe0bCp6ahcmbeLjeQAe11B/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f9Empio0dD1QiT2R96UNCG6F2i30tJI9YJFlgUsxW0=;
 b=a7jHhPb4xEOLsu6cljwI+N7DoanQfz8Dr1mGB9mHSExvggxAVvMYMU178MGgxzYHNPJ0j5egvL41cb8nA2dezmlIQ5GlL/FvKL8XOJi2187jwAkpPxuywytqngRc1dsFSb7I0bal3vZsXVL7GSg3OYSCbij2NLgjgNPFVAKwv8EWv0sp62rJZSH7cMVwZsb+1vbHuajR5RyCT1m3l4XpzTKunhCTNNyafcVuR1Hk/ZO5r4K3+94Ke4g60wKWffwsww/V3glJU/9aecFBvUGBaagT8GZyX71Tb6RKvo3iNFkGs+QkLSlStca42dcavO0B2n29tBQWIQIOFALBR41PUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f9Empio0dD1QiT2R96UNCG6F2i30tJI9YJFlgUsxW0=;
 b=wp41JSFjDrczaNXSn+saPCNUTQwjs+4ROsR3ORzYv3s3RkgSnxJ83hWr/gckNIvCD1cKFx6YNQlTIGnEb+JiW2t9IdDkh+GcqvP95EQ0cOCmz+hBUHd4szDosyl2TRn0NIDk2Eip0Npky8q7Scv/Cd0i9IFZJDAIK5kX8R3IC8Y=
Received: from MN2PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:fc::14)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sun, 26 Jan
 2025 08:37:48 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:fc:cafe::8c) by MN2PR02CA0001.outlook.office365.com
 (2603:10b6:208:fc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.21 via Frontend Transport; Sun,
 26 Jan 2025 08:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 08:37:48 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 02:37:46 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/gfx12: Implement the gfx12 kgq pipe reset
Date: Sun, 26 Jan 2025 16:37:32 +0800
Message-ID: <20250126083733.3331474-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126083733.3331474-1-Prike.Liang@amd.com>
References: <20250126083733.3331474-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 57203d31-b4f6-4286-d205-08dd3de4b6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8rIXt5ols75oPeQ1ySEGWlL/2b32N00hhnpBbhxdpiGnxMkTXPZJbY3XKkRX?=
 =?us-ascii?Q?e8G0aD5XR04IoXg6qSjm5AFvELvzc5Cz2rqVds6eD1TK3zIKbzH+yadSd7ka?=
 =?us-ascii?Q?580Jxh+5VannHpvPa3jrH0t6/0gbl/GMCfBoE5zFzE7Z11ftOf3SZF8O+sWV?=
 =?us-ascii?Q?tDqM7tZ6aqadLBqjVrKMb4E+y2DKPsmpj5vZTMciSWWdUAMZF/bSqBGWl8z2?=
 =?us-ascii?Q?QSQsxk7kGYe5C2RRk9HBYUWEE9Qry97CV/8il68dbbrjzTe5R/huItwlRbKg?=
 =?us-ascii?Q?FSB1fFl/q89th3AjdatBgG5NHG6l8HEb7YL1mlM6Sm9aD++8JAxkoTOOl5Ao?=
 =?us-ascii?Q?rUhiHnZNvhg8SUf6F7c0x5eUHd6Jf5xdmkNFTlm7vsMvuS0Du8b6oxmpQXEf?=
 =?us-ascii?Q?jqFWCBND49M8yV/l9yysvRiCvNLpZv+eT3XDpm2oO/gk3YC5f8IUAH2V74jr?=
 =?us-ascii?Q?le0zxQMQsgBCu1OOMlGgwfq2JTJgMik6wvLwONDpLE/CDIv+FXCQjyVzHWCL?=
 =?us-ascii?Q?E9U9Mh/zZx196hX5xbjC4ED8STh8wcB/VWT46Uo6nwBYhuYNKCUiljjYrwnD?=
 =?us-ascii?Q?Wxt74nUD3S4dB8IVT6TuyhkHSIl2AxpHKgpN13F30tdRCRF76bTIRNCrfBc5?=
 =?us-ascii?Q?uNUcTgCVTR48cgZksHN0qqt6tZbxR8Voxq+NfCFs6v9p9HA0v3lx7ycepM5N?=
 =?us-ascii?Q?wApJdJrJCftbLtq87wnm2AHDrc4smVVJcNxxq30jDsLwe4F0tyRhIzBcJH/t?=
 =?us-ascii?Q?nUSOd18EI0XXgZNB9zo+7wbrLGb6JzFBrnLAjFXE9Iu2SeqLXLu0AeEAwyM7?=
 =?us-ascii?Q?O8x5a4ccgftf4hYAFmB8lpXE3eZvBPjcMxtFxqeofXT9fUeItRWFv2KbCob5?=
 =?us-ascii?Q?hTDf+oRSVhnj9RVHQYEvTZBZkMMOJVaghykth/2lL/r4L1JJnYjRYLhVRl/n?=
 =?us-ascii?Q?26yyX3XYHEUSAQOxxnt+YUFwfGqOR4pJrHBwdK8Gy9dZ5snJMDHzdKW+7uM3?=
 =?us-ascii?Q?m/wVkOHMr2eZYMkRaS+yfd5WZamIhXmfuvFjq5e4dBClV2jM8BwZxHKdOICT?=
 =?us-ascii?Q?jCrd8E8SZsQlfdL+8q+INM08+SoO8x3nvScd+L0AQOjxnspUkj74MjlLc/kS?=
 =?us-ascii?Q?hc8yCDWG528zglvBh87UUE9glaFEwDH3jg41WIwLjBkl58C6z5dSS/4XFJ60?=
 =?us-ascii?Q?lrdlWGAydwhxt/ACgHs6OC3IGqs0jIqzvRLITS07tJ2nls/4TeSYcYQVrxup?=
 =?us-ascii?Q?IO8Bi45pNVz1AwsaitU6zs9SBmCsY2Q7HHSBtHv/88r2gulVOqPc39hXRQOZ?=
 =?us-ascii?Q?+4ybFfB0e2k95l5KM9KwbRerr0awoXhoHJDgykRKnQhP84uBT3EPLmTTtjSw?=
 =?us-ascii?Q?Kjzuiv2MM+IAMSQ55J1EMT+ZLZ+2kpwsgq32GC0tLfBdRvA2yT8yvL2m2TT3?=
 =?us-ascii?Q?pX1KQgN7B0hhT+NgO9nB5NsX7GkFGfKbx+nlIy1pew7YHQZeBn/MKTaMUXmi?=
 =?us-ascii?Q?cTlm2+2dSRj9hK0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 08:37:48.3125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57203d31-b4f6-4286-d205-08dd3de4b6b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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

Implement the GFX12 kgq pipe reset, temporarily disable
the GFX12 pipe reset untill the CPFW fully support it.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 71 +++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index db5cc060de85..14ea7c1e827e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -52,6 +52,7 @@
 #define GFX12_MEC_HPD_SIZE	2048
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
+static uint32_t me_fw_start_pc;
 
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
@@ -2210,6 +2211,8 @@ static void gfx_v12_0_set_me_ucode_start_addr(struct amdgpu_device *adev)
 	}
 	soc24_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
+	/* cache the firmware start PC */
+	me_fw_start_pc = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1));
 }
 
 static void gfx_v12_0_set_mec_ucode_start_addr(struct amdgpu_device *adev)
@@ -5249,6 +5252,68 @@ static void gfx_v12_ip_dump(struct amdgpu_ip_block *ip_block)
 	amdgpu_gfx_off_ctrl(adev, true);
 }
 
+static bool gfx_v12_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/* Disable the pipe reset until the CPFW fully support it.*/
+	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
+	return false;
+}
+
+static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!gfx_v12_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	gfx_v12_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
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
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v12_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev,"The ring %s pipe reset: %s\n", ring->name,
+			r == 0 ? "successfuly" : "failed");
+	/* Sometimes the ME start pc counter can't cache correctly, so the
+	 * PC check only as a reference and pipe reset result rely on the
+	 * later ring test.
+	 */
+	return 0;
+}
+
 static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5259,8 +5324,10 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
-		dev_err(adev->dev, "reset via MES failed %d\n", r);
-		return r;
+		dev_warn(adev->dev,"reset via MES failed and try pipe reset %d\n", r);
+		r = gfx_v12_reset_gfx_pipe(ring);
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

