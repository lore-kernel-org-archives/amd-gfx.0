Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F3EC0218E
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Jan 2025 08:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF44910E0F1;
	Sun, 26 Jan 2025 08:37:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LOrYB+5b";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25B8A10E053
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Jan 2025 08:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF05KYpBURKaJegYkF05NZn2pGXDkj6c9EdiVz/6hW22vi5ji0Tbl7GZI1aKHrcNByWPhMNCpQfnT+rlEAorHqChGUFZs+db58Bs5lVi5IT3JokWKWSuiW+Ym6WQ7UbcHXinctoRHgVkXfqOYWJF66dWmdemDFEITb7FW3xykdwt16UNYiXol46Zotp2FUw/1Isbw+Ar+mLbKbvfsh0ryXxDMf1wAX8TklvxxpsLm1mZwTqgs9paaw341Hlmx+f3JP3CEvDvSjvOyjZzU7fvmabHBRILEQx+Zf7mBQd/IV8f8BJk4a9vzAD5mQRVb9zzMzKAaCZxA1XJeB4PwD+Obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3REnQLGYsoEzQE6lbsDBuxqk9o/UEdlbrT/gc2o2vhA=;
 b=mOiPZaitOMM2QDyOwLDXlmahLYwzvAiN6F/q4JgE1PkEQIcueu8ca7ScDrASjIeaXshA5/01s2C/hZwngZ4Nf/RCbL7XuABwu2Xf0Zu0Kq/hfvLoF//F1Dq4SNbAwKUU1zREMAci5JsOaB4cESdcM/sLiT7XYsIsajDxz3Asv7QnRs0cwTUBPrzxkxIx5hPJTHFDoV3M411FnI9it9n5DTwj3VAWSZ78q1OvxJSkR93Q27elfgY+GwwPWve678b6QhI9ZTNEKKVp4R5q0/uk+IBXR7iJlzl5c/gHmzQEp0g7AK5n2GkURN8l0Y+LhGDXnhqvMqEgPpvP5hJnP9Hbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3REnQLGYsoEzQE6lbsDBuxqk9o/UEdlbrT/gc2o2vhA=;
 b=LOrYB+5bH9GrnSiQiesMPMkamjOGOqhUn1+yRajrZIDvAnHfb1HybYZvAMWFsjgDmkQhefKL6tRMY44jpS5rVVTGVN3rl9hXEuejE716+MeWpDAdmKLDnhcihoiZth+jxcBgPiua02p0oWjc3LoflcVUf6Va8gkdDn+plV7V/9s=
Received: from MN2PR02CA0006.namprd02.prod.outlook.com (2603:10b6:208:fc::19)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 08:37:47 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:fc:cafe::e9) by MN2PR02CA0006.outlook.office365.com
 (2603:10b6:208:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Sun,
 26 Jan 2025 08:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 08:37:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 26 Jan
 2025 02:37:44 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/gfx11: Implement the GFX11 KCQ pipe reset
Date: Sun, 26 Jan 2025 16:37:31 +0800
Message-ID: <20250126083733.3331474-2-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 0184eb9b-f84d-454f-42e2-08dd3de4b5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KIMSmzOtzV5t/RT/EquqULOFdrOnYyFnAgfc7Ox8ROg/VB1ygvDPTfuPIqzM?=
 =?us-ascii?Q?biOR7DJgn+yzQ4X8eDJy2XAsQPGnWUZxQXvuUjwo3sLyFthuLinXPk+I9Ru8?=
 =?us-ascii?Q?IR3rhXKwp5L4X2NA6afGxD+cXd2wtUzH6CBn8M38+ae27IPNDwYCP0dK3pOd?=
 =?us-ascii?Q?7vE9tXf9YxUB/bCqr5O30d6Ups7s3pZ9VVxyuB7/Olk/0UU7Uip9B/1ABXI4?=
 =?us-ascii?Q?CQrwlY8lxgIc/61a4zMV6usAgU8dnr5NEnXy/NXzPqUFKzXNgmtcRhOQ4qg8?=
 =?us-ascii?Q?UZYY/afEGhtH0CzHiMAjlcEvNePdskNQJsyV7RS9vH9K+l9k0lbXdacdTsFp?=
 =?us-ascii?Q?vCoXA5AOYgoxw8Y7/8RqnMLvaMHmvzw6DSo26Q9nK8e/M/0Y4S3FaGXOFE3u?=
 =?us-ascii?Q?ito0KmcmzjIVFvdhcxfJ+XZ76f2/oNS+IlGmFGPAvyceGJBQTrZWS8WF/rfP?=
 =?us-ascii?Q?TmlydPar0GOFaxdUx1wJcGG4CelGmen1yBO8rmcpabzNjlv/F2MFgMNBPJTm?=
 =?us-ascii?Q?uQLadd/A6amDJ6iM2H8bbRMmLp5d7RJ+xEy0lwOd0Ad2xRATu/5O0eUxBVqQ?=
 =?us-ascii?Q?IJbHo9Iek5Zs+TC05aP1/m84WXWjR49UWlQik2wn87IIYQd/qEUmwsMH9haQ?=
 =?us-ascii?Q?LTM79kzUpxJZSOWppZBBrsYlfYcEND8MAM5GNYAH9iGK04v4eOzuvTk5i/wS?=
 =?us-ascii?Q?xWfyulH7FFA1GoLOTPEwmTnt3AKh11lpHaDQ4dckfZ/dMtV8AdCQiwPwWNLL?=
 =?us-ascii?Q?y6Czwj9Ne3eTHucWR7wmqR68EbFggVYpomAGtph9rV61aQuEcjhLgV/iSmlD?=
 =?us-ascii?Q?fPdc4Hvv69ZDlRXh1OJjruHpUaNUDrKvjSXHjawEeKgWogzMA0zfLgAMaiKT?=
 =?us-ascii?Q?1Z6v2BvTI1Vuyel5BYUkR4yFOosYmWmxaX6Ez+uFofIcC2yTbRBJABzAjfJs?=
 =?us-ascii?Q?iulimsxaC9ZD69yeeJv/Z2QXnNps63KalLezAgQS8rS4TKUlboqNBaoEXPMQ?=
 =?us-ascii?Q?wpTGzDzKSo6EvJPoWuXOD3zbiO+dI53TmLv7tVTeSK9nBmtgpBT2z3S9aWcb?=
 =?us-ascii?Q?eXOzwCcn1vF2WtSQEsIGMP4EJbThAPa7QnE7jpY0CAvZJRFLEkIApqsfuLVN?=
 =?us-ascii?Q?HAveuC6ZWWFozAKYAsIdYTsklFVnbW49muGhu5r8AoNHg0Ll43EFJK2WokJ7?=
 =?us-ascii?Q?c8jE9DahL2rpC2hE9/nj5RexlQyHKtNk6AkabSe3z0q92uQHc4muJAQnJ3WE?=
 =?us-ascii?Q?hEs9Hs+6Kj8LcKt7dkM2KM9p8EAnVNcub6xTnvA5sVJ6ANMwg9E7HQSXWWBh?=
 =?us-ascii?Q?pDkwfhPOXeH0TUFM/LpGgofZu9bq+NU0yPrxfT2c4In71r2Efo9kym2hQPI5?=
 =?us-ascii?Q?Z2zasI84HJ7hPFxarWyInpaYGgQ7hN/svRCO3ztwS/8HpHULxWgLYKyZiuJQ?=
 =?us-ascii?Q?woQaVvbxk6gQxzRP+X1mM53q9FAey4vo84CZvGr0DLzLi8iQcODjMCI/Y7fj?=
 =?us-ascii?Q?d5w5jbjpxsL0fF8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 08:37:46.6770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0184eb9b-f84d-454f-42e2-08dd3de4b5bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

Implement the GFX11 compute pipe reset. As the GFX11 CPFW
still hasn't fully supported pipe reset yet, therefore
disable the KCQ pipe reset temporarily.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 139 ++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 395872bb1401..39fd3ce67ec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -66,6 +66,7 @@
 #define regPC_CONFIG_CNTL_1_BASE_IDX	1
 
 static uint32_t me_fw_start_pc;
+static uint32_t mec_fw_start_pc;
 
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_pfp.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_me.bin");
@@ -2937,6 +2938,7 @@ static void gfx_v11_0_config_gfx_rs64(struct amdgpu_device *adev)
 
 	/* cache the firmware start PC */
 	me_fw_start_pc = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1));
+	mec_fw_start_pc = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC_RS64_INSTR_PNTR));
 }
 
 static int gfx_v11_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
@@ -3812,7 +3814,7 @@ static int gfx_v11_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 			     le32_to_cpup(fw_data + mec_hdr->jt_offset + i));
 
 	WREG32_SOC15(GC, 0, regCP_MEC_ME1_UCODE_ADDR, adev->gfx.mec_fw_version);
-
+	mec_fw_start_pc = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR));
 	return 0;
 }
 
@@ -6764,6 +6766,135 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	return amdgpu_ring_test_ring(ring);
 }
 
+static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
+{
+
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
+		if (ring->me == 1) {
+			switch (ring->pipe) {
+			case 0:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE0_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE1_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE2_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE3_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME1_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec1 fw pc: CP_MEC1_INSTR_PNTR */
+		} else {
+			switch (ring->pipe) {
+			case 0:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE0_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE0_RESET, 0);
+				break;
+			case 1:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE1_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE1_RESET, 0);
+				break;
+			case 2:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE2_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE2_RESET, 0);
+				break;
+			case 3:
+				reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE3_RESET, 1);
+				clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_CNTL,
+							   MEC_ME2_PIPE3_RESET, 0);
+				break;
+			default:
+				break;
+			}
+			/* mec2 fw pc: CP:CP_MEC2_INSTR_PNTR */
+		}
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, reset_pipe);
+		WREG32_SOC15(GC, 0, regCP_MEC_CNTL, clean_pipe);
+		r = RREG32(SOC15_REG_OFFSET(GC, 0, regCP_MEC1_INSTR_PNTR)) - mec_fw_start_pc;
+	}
+
+	soc21_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v11_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev,"The ring %s pipe resets to MEC FW start PC: %s\n", ring->name,
+			r == 0 ? "successfully" : "failed");
+	/*FIXME:Sometimes driver can't cache the MEC firmware start PC correctly, so the pipe
+	 * reset status relies on the compute ring test result.
+	 */
+	return 0;
+}
+
 static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -6774,8 +6905,10 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
 	if (r) {
-		dev_err(adev->dev, "reset via MMIO failed %d\n", r);
-		return r;
+		dev_warn(adev->dev,"fail(%d) to reset kcq and try pipe reset\n", r);
+		r = gfx_v11_0_reset_compute_pipe(ring);
+		if (r)
+			return r;
 	}
 
 	r = amdgpu_bo_reserve(ring->mqd_obj, false);
-- 
2.34.1

