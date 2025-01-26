Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673C4C0218E
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jan 2025 08:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1833D10E1A2;
	Sun, 26 Jan 2025 08:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJ2tEn53";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2475110E19F
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jan 2025 08:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPIVlhQuZqLb/7bqs8ihrpvBjwJtyrKSn75fYJKRhQh2e2sqDBelNDhzcTKctawN2soBHuCiop3QXe5Rk288KJsqQ+PjiEPTtHRP9nXzkR1hZqDC8u/cI1Usm0w7BtIGX+iCGScW0OhQoZvYmYmjYgsp1egjVscEHoa/yVeM5OMEaeRbtL1cP2sfxZc3FCQ05lPJAQVvYyBPWwTZWoPhol+ENmhXKmWFHmWk+ey64JIZXIhVwqP51YneYxg20cNH8Zp1naEcfsM7xUixvB+v4VGjaBIedXb5oSgthrdhCX+SBefYXlOFdZaVDQtk4h3mqYLTyypukMcCVcBjR9hfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ifNH0KbhyuHN50SKh2JZ5twDhLqE75EbTZvUBu6Xa4=;
 b=DULDOHcPbmbtj92gS1sgCESLXOzqGb2XidzkC47F9MjGwCrz49ftb6ww5T4e/s6zO4zWC3aoNZv31xEZFb9SiGU7i+pheq3th1fuXcbdPG8xTHydhM+FEPLeEcUbjlcXAl/Mx2IFhLVWq5f3eZ9JfBZEe2DnvbRBwz5gnJv875F4n+d8tglEUEMfJ1U4nNkgDHMo8PAYx0Lvd3yI37ZTbDCvyH+c43Elm6S2pcwEa5xI4xrgnKUI1ptfs/jzxlD/hjFzJufRNSbMfGHp42E+XJfjFOml1Qm1CxX6zP1qmQ/7eA17dWDtGg2AvXFxoEigffo3D7b5N9gEV7JRwZG3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ifNH0KbhyuHN50SKh2JZ5twDhLqE75EbTZvUBu6Xa4=;
 b=KJ2tEn53vOHPE7z9B9pcVOu5ZILtlI8QBbkE5pPFPy3QZBMjoc/tV7ZrMmCkWBLSriE4yQvuqvD/XPo4YM6jt/9/4kncCN8hrZw+u0Ws9NnRCLprN4hc3fY+V7Vnu+S8f5cMeO3CDxgkTA6yvDV5azMYBmKpA9a4CtPoCQokmqU=
Received: from BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sun, 26 Jan
 2025 08:37:50 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::75) by BL1PR13CA0206.outlook.office365.com
 (2603:10b6:208:2be::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.13 via Frontend Transport; Sun,
 26 Jan 2025 08:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 08:37:50 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 02:37:48 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu/gfx12: Implement the GFX12 KCQ pipe reset
Date: Sun, 26 Jan 2025 16:37:33 +0800
Message-ID: <20250126083733.3331474-4-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 28eea661-ed4d-4f47-5d68-08dd3de4b7c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vgIPHgzoKvi1XPv9v46EhLxfPDpKURGl8cLpkVKjtXWkh44ecZcLRXKUel20?=
 =?us-ascii?Q?UIxeBlHUdIR6wWh98t/rx8iCXRvW7C4HXvZSEQeC0d1oQdvnv4PlC/tMGBK2?=
 =?us-ascii?Q?/1VD20zrGnmJhY3LoG0bU8yp2FkDKWJUE3+X0101GM7rb9p9V8FoBXkXDWAm?=
 =?us-ascii?Q?kGgxCZI1CeMOXKlnmi0vW7w039SAq8GRMWiMB57GZhPATRrHoq4I9jYRtpYx?=
 =?us-ascii?Q?kfjeeO93mcPNmgsmflbMFJPvZn/OKeJH1iKLLE/jaNWc4UssZuc+pELXrwqD?=
 =?us-ascii?Q?gBEoPj2Fy8kf+6xlcFwuzlLngPexT4+hNJd/n43s99QGBmHtyNXYnNbdVwfH?=
 =?us-ascii?Q?ZCX1IsfcYcmEbInh5rwU0CC5J4RwQ+lpaKTqpB6AffQMzIQGPyqPCWvfMxXV?=
 =?us-ascii?Q?XdBuDDuUoTSA4muG87MdvAjKYsZLUgXBWvHZDJkjFaPs/mtp+orvzbLUS0G3?=
 =?us-ascii?Q?aq/jXIYy1yAqhus5UsZnaZUbjTYBrUHituDTqaFkxo6GaaIORFkv0XkV56nf?=
 =?us-ascii?Q?wmoqcBT74AT1KgKVP8c2+VaFed33E0n4fY/KLqkfzEU5LWs2iCck4IEz7KL1?=
 =?us-ascii?Q?wG6VVIgN0Tv84+SVZbA/iNYn/YQBcfM0mMiMlk1qfeY36Nn0msQvQUUHxyOe?=
 =?us-ascii?Q?fo9qPteo4cqReCoSf1xCD1ttbUgkyjEJSDqqtrOi9/lBERwFFmHnK3vHfm53?=
 =?us-ascii?Q?kTDtp+XXSvYDY8c4UIruTEJVSSEp7rI3rdvRNmBU0IhDooOFvtBxVWEs+4Yk?=
 =?us-ascii?Q?9cl3eNikyowpab4d0y9WuSqCgCV6MDQ1TKoi/PTRshzs9QpETzwvpGxsa7KJ?=
 =?us-ascii?Q?ONi/l4tM8W6sQOdqEcJHyxyiSbYeQwwjjAp+s3pEPkD/LNe/XKfHPJzs1adp?=
 =?us-ascii?Q?mjM7Ek3TfzAZwOL2sP8KY9QPgjjyth6pzGsIe438CcqcYdkAQDMhOU+Mnqht?=
 =?us-ascii?Q?8WRi3MQ8w4udnwbYXqfEH5kfcPVewctHxQLXfGemE8+tuZGgQbmIceCkYvxG?=
 =?us-ascii?Q?AfRgwuII/vq5+lC7MUbOyPseMNm8zjjyE89NxopclkpR5++9IPwDrpBvb1Tr?=
 =?us-ascii?Q?Fkm1Gxs30c2dY4GKSDsF9snNTVijHME+vIz5X4ThgS8eQaBwAgcYG7sU8b77?=
 =?us-ascii?Q?2omPWm8R0sR4JWiMYhiMhEw9CNlWj6ut8Gj8Tl/pdE8iJwVWMCVl9I70Lhun?=
 =?us-ascii?Q?QqIOHeDs3aI6O+YAR6tVhkvdj0hp7vKxs/rK6w4dAxR/HBKMNDOpBQp2LO8Q?=
 =?us-ascii?Q?JY8nHtYBrmYjkpW9c/BPPdqC9bDeN6IFsrZZCbVCznEtIOfFAQsM1ZfBxwqU?=
 =?us-ascii?Q?zxN8zpWOof/tnwl+E2WvXiypxrujsPTPPer8aB3cDYR/tFj7k3YeVOos40iA?=
 =?us-ascii?Q?CEJCN2zd3cAl91qtLm3T0xTqRJfcsyd9+fzj4JUV7pDHJvdNktekUou9hSCN?=
 =?us-ascii?Q?iXWgZSidiPgMZvOhixLvp6TMCBu1vTobHlhC4lsTVTd6tA3/O8/hXHEaKFWv?=
 =?us-ascii?Q?sPv2TOHIjSf4704=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 08:37:50.0921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28eea661-ed4d-4f47-5d68-08dd3de4b7c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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

Implement the GFX12 KCQ pipe reset, disable the GFX12
kernel compute queue until the CPFW fully supports it.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 89 +++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 14ea7c1e827e..c5d07d5aa495 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -53,6 +53,7 @@
 
 #define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
 static uint32_t me_fw_start_pc;
+static uint32_t mec_fw_start_pc;
 
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_12_0_0_me.bin");
@@ -2127,6 +2128,7 @@ static void gfx_v12_0_config_gfx_rs64(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 0);
 	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 0);
 	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
+	mec_fw_start_pc = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC_RS64_INSTR_PNTR));
 }
 
 static void gfx_v12_0_set_pfp_ucode_start_addr(struct amdgpu_device *adev)
@@ -5356,6 +5358,87 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	return amdgpu_ring_test_ring(ring);
 }
 
+static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
+{
+
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
+	reset_pipe = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+	clean_pipe = reset_pipe;
+
+	if (adev->gfx.rs64_enable) {
+
+		switch (ring->pipe) {
+		case 0:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE0_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE1_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE1_RESET, 0);
+			break;
+		case 2:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE2_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE2_RESET, 0);
+			break;
+		case 3:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE3_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						   MEC_PIPE3_RESET, 0);
+			break;
+		default:
+			break;
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
+		WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
+		r = RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) - mec_fw_start_pc;
+	} else {
+		switch (ring->pipe) {
+		case 0:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE0_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE0_RESET, 0);
+			break;
+		case 1:
+			reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE1_RESET, 1);
+			clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE1_RESET, 0);
+			break;
+		default:
+		break;
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
+	}
+
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v12_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev,"The ring %s pipe resets: %s\n", ring->name,
+			r == 0 ? "successfully" : "failed");
+	/* Need the ring test to verify the pipe reset result.*/
+	return 0;
+
+}
 static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5366,8 +5449,10 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
-		dev_err(adev->dev, "reset via MMIO failed %d\n", r);
-		return r;
+		dev_warn(adev->dev,"fail(%d) to reset kcq  and try pipe reset\n", r);
+		r = gfx_v12_0_reset_compute_pipe(ring);
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

