Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8EDC30658
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 14:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F14210E297;
	Tue,  2 Jul 2024 14:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z26UbgaI";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C62C010E273
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 14:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQAFB3pEei0nemfoe9e4eGRq0ikL9yVr7WaQzMo0UO2XctNoYe3XfwtcOe+HxqA1cSejyE51f0puHJahjEJSi38lLhJcXYjV/57iRdiJcDoZzo+EMpt5AAVV/w/DlbNqIymyeYhh3KUht6p1z0RwpzKJLUZICaR0XjnUz9nERiX1tPLSDLulKqM2bh344RHj2Pr5mctxtLiG0msB3VZwcPeTC32hhBbSK7mfz8hLAd4BkAMmYYK4+gVxY69ohsU/DWitDcuFiHsKRaCQAql5RNIxdXJRv+HLJDu3p1MYnJyHrHN/IUrExuVaMmaMvt0PD3759nEvcmjWufbHuDsFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFpCvOheY7H5VYltlEIHYtl6YGTZSxHlbus81ALRlwg=;
 b=glYceJe7BP+bwcvvtEag4MrJHTJfD0nefQfnk67t0Vjqdd8yNZ1YZpSLqNRozO592HNVnNlfFhNgdUm0DWGSFv8mwHVqp8MYan9I8nsWBz8GaxNwjm6sW5SMo7G7jMBPiZFu1uxnN1q1Zt1Semx1Mli/jjKhOTbUlPdQbWL0FbJs1vyzWk/Py0vy64Y48b9DTv1q7PI6fziSCHeLKOGrgr4EmzVecawB3P+/Ny5ewZbwXZOVj8c+kGz0V3cojcc7gCnNod8tJ6Z1i8yGR/zfhZw2L2/l2X4hIl6VvECmDer0UeDkEThJ/1xn2nwbSo2epY+SkrCzrUzhJCFFdAxcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFpCvOheY7H5VYltlEIHYtl6YGTZSxHlbus81ALRlwg=;
 b=Z26UbgaIHO0uo4Dw6GLsTIBrbFBAF94LOs2wpPneCaB2iiKzVJj4KJQEQytqj+tjbBYYYzBGG5OnEVeroMjhY1OtoNHhHg0CSeKr3WR8rGjTT2KGWgzFGu4iUm102rj7ePO3dq/vN8WJSPTYQ4PrZj1ayG9/fft3ed/mbaDYIpY=
Received: from SA9PR10CA0023.namprd10.prod.outlook.com (2603:10b6:806:a7::28)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 14:28:47 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::5b) by SA9PR10CA0023.outlook.office365.com
 (2603:10b6:806:a7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33 via Frontend
 Transport; Tue, 2 Jul 2024 14:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 14:28:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Jul
 2024 09:28:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/gfx9: properly handle error ints on all pipes
Date: Tue, 2 Jul 2024 10:28:28 -0400
Message-ID: <20240702142829.705019-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702142829.705019-1-alexander.deucher@amd.com>
References: <20240702142829.705019-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: a12c70e6-28fc-4b72-6a70-08dc9aa3492d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JS5vqQPjTeAp3Xwz+3C/N8BL8mByr4/R4w4+2V7k2FwPygW8NgHTsb8jUh5o?=
 =?us-ascii?Q?mxnkAW8KjDXiIDlZX3XZvns2QBpcyWSMl4a3uqnkzM+wTt0D8YREhzQg22sj?=
 =?us-ascii?Q?XggxRmIOL3My+ZC6TNuk74A2+Sdv7LHAB8q1SyOPTrVCexhlDBh4YcFkWOcU?=
 =?us-ascii?Q?pkIFCu95ZHc/gwIRtAe6ZVOHdZN7uqX6BwYx8COuF3/GqXgbxHVc7ZeNOikW?=
 =?us-ascii?Q?gvarRSoczKj1z4fhEYop+Df7vifrEDqOoGW01yofA2Vb4V6/xfr8QHz3FD9/?=
 =?us-ascii?Q?PK3Nzhg2V8gU/iqxDCrfI2k13/jKOzYOiC/zsiAIHPtORY7cEFsw6IDHTL9U?=
 =?us-ascii?Q?6f+L7X7DmeJUsXcVRxVkPg3zdt6fc6hwnrflnaapLcGMIIGgRsy7kBWnPJ9d?=
 =?us-ascii?Q?zJop4gK4J2Tuh7BeLtVaJzLhkBoKht7gBseyrJjbsMkdO+OFQjIeOW/BW4Jo?=
 =?us-ascii?Q?c+ldIby63F8omjGt7QHHVF/R+U3sWo3qQHgaAdy2UG5bImDG1e0mr/5IqRhL?=
 =?us-ascii?Q?HP8VHzgpMA0NwffXiKANc6Y/FbErvY6/XkSAb2URDzBMSq54Caib7xiRrE81?=
 =?us-ascii?Q?8X+y7HrYfwsZX+cgOd9E3o0GDwGZq3j1AVp9jpTNWl6Or2gRvzyYlVhnGtun?=
 =?us-ascii?Q?qZcRkALqFG7bugizCUPb+a6VIuQ4Mx677Gt3xkmyKWWLqiEiYK+pQ2C3Rv0O?=
 =?us-ascii?Q?BkhOdM1E/SfJFLyHYTD6uVh8GhWjdshWq4yz/gLVA0cSd1QjsnjX2QHA8iub?=
 =?us-ascii?Q?pTuA9bx2Xc/ZGpWwwTd7cRF4csXUQ7S66c6BNkX5isSMYKAX16uRNX1cXeyU?=
 =?us-ascii?Q?TW3474VruF2tHzMa31BLSK7n0eEpKR9lAEJw4wQbut/InUAVjBk7z5rfVje5?=
 =?us-ascii?Q?pBmmkjgeMXaRzdzU3uhdg+eUO7qtpv0tAiPg/D0VTzOJgy0l2b4Ji/Y5bayD?=
 =?us-ascii?Q?Ol2NYjGFmyorAKbC7mw4205m6umZzSyK83L8t7P/emsLa8NIp2WQg3nVJtFE?=
 =?us-ascii?Q?fyORTGtKVVj4pnU6zJtV57vcP/8IiFLzbIqXPfE5TtPpcSgg0B6vGTTlcxOO?=
 =?us-ascii?Q?FvRx7n5zhy7t7ERWAvWUwI05UMrCa7WPccXD62qxjja9o3KbZg9W2kLN6ntG?=
 =?us-ascii?Q?Z5YehJhR24iajbnpE2I+194Xep2xh/V4iZFDzmdAwbHCN40/UA/JvA5AHNMg?=
 =?us-ascii?Q?OgGOBQDOJ0IxRJCtKAH6+iC+O9u1WhYBcfO6UK4DXFkqDgxXMXlsetbG1XZn?=
 =?us-ascii?Q?45IMhzylVSTkpk0afZESVuFYJbaRxfY4O1J0IZnp77RsonFhqS2jKum+qNeR?=
 =?us-ascii?Q?CDYv+h8Aqkd/kMAepukn9xXrtIz5xkJI5BexidxiDEX+B5rf3pRrHeZdyKAs?=
 =?us-ascii?Q?SCOLHNMa+Yc9hdaDqn9zmC8FtVq6xI2FvgqZ5JTubbcQ05EqzqeQ4q8Byiyt?=
 =?us-ascii?Q?VGMa1wru5zLN36zV48mCCenYFUMB7ZXY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 14:28:47.6265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a12c70e6-28fc-4b72-6a70-08dc9aa3492d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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

Need to handle the interrupt enables for all pipes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 44 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 50 +++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 41d61887f272..3f197d861aac 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2634,7 +2634,7 @@ static void gfx_v9_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE, enable ? 1 : 0);
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE, enable ? 1 : 0);
-	if(adev->gfx.num_gfx_rings)
+	if (adev->gfx.num_gfx_rings)
 		tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE, enable ? 1 : 0);
 
 	WREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0, tmp);
@@ -5929,17 +5929,59 @@ static void gfx_v9_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
 	}
 }
 
+static u32 gfx_v9_0_get_cpc_int_cntl(struct amdgpu_device *adev,
+				     int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *source,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
 		WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
 			       PRIV_REG_INT_ENABLE,
 			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v9_0_get_cpc_int_cntl(adev, i + 1, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 008791bb0dcf..0a4ba7d624af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2827,21 +2827,63 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 	}
 }
 
+static u32 gfx_v9_4_3_get_cpc_int_cntl(struct amdgpu_device *adev,
+				     int xcc_id, int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static int gfx_v9_4_3_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					     struct amdgpu_irq_src *source,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
 {
-	int i, num_xcc;
+	u32 mec_int_cntl_reg, mec_int_cntl;
+	int i, j, k, num_xcc;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		for (i = 0; i < num_xcc; i++)
+		for (i = 0; i < num_xcc; i++) {
 			WREG32_FIELD15_PREREG(GC, GET_INST(GC, i), CP_INT_CNTL_RING0,
-				PRIV_REG_INT_ENABLE,
-				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					      PRIV_REG_INT_ENABLE,
+					      state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+			for (j = 0; j < adev->gfx.mec.num_mec; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					/* MECs start at 1 */
+					mec_int_cntl_reg = gfx_v9_4_3_get_cpc_int_cntl(adev, i, j + 1, k);
+
+					if (mec_int_cntl_reg) {
+						mec_int_cntl = RREG32_XCC(mec_int_cntl_reg, i);
+						mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+									     PRIV_REG_INT_ENABLE,
+									     state == AMDGPU_IRQ_STATE_ENABLE ?
+									     1 : 0);
+						WREG32_XCC(mec_int_cntl_reg, mec_int_cntl, i);
+					}
+				}
+			}
+		}
 		break;
 	default:
 		break;
-- 
2.45.2

