Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB703C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47D3910E435;
	Wed, 17 Jul 2024 20:39:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Isu0QWu6";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C521410E41C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:39:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+IdFgisdY23UzWt/sU/0l60tp+7w4KWRfFrtsMfAwPktSO7KWtn27nmfPAiYBx2+5AUr/ciaXE8kzWbmIhX7pxAt8FUOkyWzTfxAZcGJDRGydDKSqF+xIiuA+zWHyxTiKkWsa5XPt4kpB1Z2iQ9Y26GHWWbL8kfxjrE9gjrFtC/Il3jMXfTHF6xnuuLCom7ym+PgjGc7s5x3Q27AXKYQieJOXklU01mQ6Fn856achR2BZ6WRnk2tRZY0tULdS7pOdHdgPM5uVvmvl0m+8zINbxLrFe/omiAhD9WXPFkDFO00IFZAIPG3ZGwUjTZ7A/8t9rImgDpMe20LG6HHsumrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/f+/vKfnSgoX1eVyWxFLqSL4Xw3E7VrWan2+qvxxho=;
 b=sfUho/Nyf1i+2JazTQ045a8vrBmxvuyLiirWNimygWDBJTK/v5XsXzWMwCfJLZh84HD8TUql0/CDFJOCi1S2J2jqNgq6a9PDVzHEo1uPIhLYcx/tRlGh8TpcImm72iD9NfeTvtQbcz2/puIhjkUtzuzNEwK1+COzT5Cgac2j1Z8ZMkw5pgt2nUINz9ydcsufgimXt40RTRnmiZTXe7lsKaVrrr+VQTuGOiog0pr6NipPukc0UzG9Tjoy3tFrwQqQfaJ08wHuu+aoG0743+WfwNZVVSb4b8RJqMlyw94cL0EJlM4f+v9NNGMJszrQSysqAvVwzHN2vYhel+d1jhX3MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/f+/vKfnSgoX1eVyWxFLqSL4Xw3E7VrWan2+qvxxho=;
 b=Isu0QWu6+EQF6nlYn+AqXMsae9gIy0zHzd//RAuifuGS21rZ/CLVYBmKXpiLbTJxvkZFs1MrECVsbom05BEZps483Cviygtki+pAoJCfbDT3ZhZEHVdM4lndZJ3Y1EJ9XJhZb+KAhPfpIc3Nm3RKUpOpQLP6L8hkp5RMByjBXbE=
Received: from BN0PR02CA0058.namprd02.prod.outlook.com (2603:10b6:408:e5::33)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.33; Wed, 17 Jul
 2024 20:39:10 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::fb) by BN0PR02CA0058.outlook.office365.com
 (2603:10b6:408:e5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Wed, 17 Jul 2024 20:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:39:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:39:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu/gfx11: properly handle error ints on all pipes
Date: Wed, 17 Jul 2024 16:38:45 -0400
Message-ID: <20240717203847.14600-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717203847.14600-1-alexander.deucher@amd.com>
References: <20240717203847.14600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 21469cee-b305-4602-b4ba-08dca6a0829c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AtWrZEpieCVq+iD/oy2Lo6ptD0kFKzCwk9ZE1MYmckEiS1NypFDUi5qB+3d8?=
 =?us-ascii?Q?0kAzGSrUk+1tv5YIXo7MnnKmm9ItP7rc97du2XhWDpCJBEfcgQfmrVr6LvhG?=
 =?us-ascii?Q?DuWYTPOCGj0EUw57va/Bg+Wcsctrs7tvau0aQ57YoGxRY2KgwpMCQC2OZpSL?=
 =?us-ascii?Q?xYimMe4WdjkD1aLR+OVpEoAxpu4w6sZdrRsB38nPzODABJDR9Dw84dId6YgW?=
 =?us-ascii?Q?dY9NmP4uL8tiiz5/NeIDcolQS0bBMbVL4lfDPk+KcVgPC31mu5w6mG/N8BNy?=
 =?us-ascii?Q?kst8/fbziaUn2NNTDRPy3mhTJl2TdRJsiELSk8zw3A+nNKhk6Dg5w4HeSlik?=
 =?us-ascii?Q?Vif3q5Ic3iYGS1V3Ggq6ujjXXTU0dt4H4YjvLWAjnPkrTE+rUUnb2VvA84H/?=
 =?us-ascii?Q?M1IjoQOO95TqjiuY01eavcI1UoRgCxo6QaUo71dBLRVjvuLdkfLc0cm5HqT+?=
 =?us-ascii?Q?lKgBj4R/8nwHnIlV3VLT168Ha643q7W5YhPqjaTYmVBcpV/BBzOlmJltq3Gz?=
 =?us-ascii?Q?Ze4Ylc6kgDJJ1ILu3BzOlwGMsRRed3YWUuxTmyWedTdF82k3sLt8JwoiR6sY?=
 =?us-ascii?Q?mbE8dAf/SMKVZVEJc2SQs7trNB5ywxv/phOZDJTYN/nLhnl0piSb7PBifHYw?=
 =?us-ascii?Q?C4veEssLREozF7s1yoNmC8tW7tJ96TEAMOcVhDZJ21XdOyWwAjbzRwmRIeEg?=
 =?us-ascii?Q?wTTRODencqbvX7uA8NUvFoBWgzBS2XblWwMaGQGLHsYn9cpfQjKnxHlu+JVv?=
 =?us-ascii?Q?vW0teOf7xW1S+6q9Ow02jqO4cBrhBi7tS09eWBFHq/7EFGsw62hi1mCt59+W?=
 =?us-ascii?Q?QCqGkIewwLqYWWuyuV4AIyVVZMNwDA04+GNAiI5YBI3gaQzRR1dNTcLhwGDu?=
 =?us-ascii?Q?Cow4u50J2CZcqOBBqbRUuR9qx+qvfQC679QN0ehgBDPidanxnBbTNS7lQlea?=
 =?us-ascii?Q?NCpnnIQ2nqFZOs/uUsL9wwsp9zrV+WqFLOdcZ7YNvzLZEyBwk/hWymgTVsoV?=
 =?us-ascii?Q?/pz1CLXpwm32pgWmRl7vwm8f9HNeoOnLB71EYkOhcQTstqp0ZTyEGEjZWMxK?=
 =?us-ascii?Q?psRRhIsoiN201rVYpagPSfdn2B1mXy6bldyHgPvpy7isWyymPq+SqjbGWmXU?=
 =?us-ascii?Q?42VcfECZPMZ+gdGJJPjT9aWzkwf15EXzPTVEj95l5N78PkbpHoXLN9u3a0Lc?=
 =?us-ascii?Q?S8Z6KNub9K0M+YFFpRsqEmejd2jZKEb5Z+YVRzHaBIjzGcx9jvZP2pkzx4Ot?=
 =?us-ascii?Q?1ATwzAiT9gbUBNhY7g8dvCPXxirT0Cp5ZjKGtbE7h9jZXZa0Of7ndWXglECS?=
 =?us-ascii?Q?dW4qmrfLOn6pMqwTHp8TkLO+mMaOXI5Em9dKOoPZgVdYQu9Bs8V1GQZwWDcG?=
 =?us-ascii?Q?/MqF5fIe7mHKo2iVZGK0hufUaE653yVRUa63rIFo0z+PKsySAQYobrqDsWHu?=
 =?us-ascii?Q?MAyrISJd/tirLHuR3/hNdw1pAWPKa8O/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:39:09.5116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21469cee-b305-4602-b4ba-08dca6a0829c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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

v2: fix indexing (Jessie)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 134 ++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 554aae995f41..02efa475eb7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1953,26 +1953,74 @@ static void gfx_v11_0_constants_init(struct amdgpu_device *adev)
 	gfx_v11_0_init_gds_vmid(adev);
 }
 
+static u32 gfx_v11_0_get_cpg_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	if (me != 0)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING0);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING1);
+	default:
+		return 0;
+	}
+}
+
+static u32 gfx_v11_0_get_cpc_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
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
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE1_INT_CNTL);
+	case 2:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE2_INT_CNTL);
+	case 3:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE3_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
 static void gfx_v11_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
 {
-	u32 tmp;
+	u32 tmp, cp_int_cntl_reg;
+	int i, j;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
 
-	tmp = RREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0);
-
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
-			    enable ? 1 : 0);
-	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
-			    enable ? 1 : 0);
-
-	WREG32_SOC15(GC, 0, regCP_INT_CNTL_RING0, tmp);
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+			cp_int_cntl_reg = gfx_v11_0_get_cpg_int_cntl(adev, i, j);
+
+			if (cp_int_cntl_reg) {
+				tmp = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
+						    enable ? 1 : 0);
+				WREG32_SOC15_IP(GC, cp_int_cntl_reg, tmp);
+			}
+		}
+	}
 }
 
 static int gfx_v11_0_init_csb(struct amdgpu_device *adev)
@@ -6201,15 +6249,42 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 
 static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					      struct amdgpu_irq_src *source,
-					      unsigned type,
+					      unsigned int type,
 					      enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0,
-			       PRIV_REG_INT_ENABLE,
-			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v11_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v11_0_get_cpc_int_cntl(adev, i + 1, j);
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
@@ -6220,15 +6295,28 @@ static int gfx_v11_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 
 static int gfx_v11_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					       struct amdgpu_irq_src *source,
-					       unsigned type,
+					       unsigned int type,
 					       enum amdgpu_interrupt_state state)
 {
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		WREG32_FIELD15_PREREG(GC, 0, CP_INT_CNTL_RING0,
-			       PRIV_INSTR_INT_ENABLE,
-			       state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v11_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_INSTR_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
 		break;
 	default:
 		break;
@@ -6252,8 +6340,8 @@ static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
 	case 0:
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
-			/* we only enabled 1 gfx queue per pipe for now */
-			if (ring->me == me_id && ring->pipe == pipe_id)
+			if (ring->me == me_id && ring->pipe == pipe_id &&
+			    ring->queue == queue_id)
 				drm_sched_fault(&ring->sched);
 		}
 		break;
-- 
2.45.2

