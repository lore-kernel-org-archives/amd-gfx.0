Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF8CD1288
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Mar 2024 14:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C46410E82A;
	Sat, 30 Mar 2024 14:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sR4Qnzyj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAF710E82A
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Mar 2024 14:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5tnsKG4WyEM8rfql63+OxxR4gRnSE+6mZURoPYQgM9e1RnYukCjUp5h/HUtQQPYTu1rXXw1PRRa95PR8HEPXlNwxL5ktSDu2MD93BrKER1TWcLo9x6ykt+s5vfEqV3wl8dHbKTdV9h9yG1/l6KQbDU6SL+wqR91V+MWruZF3pKvWQclwUuBgMxgyh2E4wtIhN9E2ogOT8WruZNqjNK0MS0BJrPM23E84akQBL+rxe5tRgcNz5+DUA31XH4UNwtaybkvIgRAdkCmofrJk4PcZGjTzHMSVuMfc/yo7qZDua2ipaBMs+2E9erVZo0E8YXfn1v1oES0k/irrnLRFJniKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjHfTb6H3d8Acb7Bt3L4qzdfjWLJbPcEZ98khhhkjmA=;
 b=Xq2aaVdGlVIBHcrrgQFZhJeDfmL0bwkBw9XgvLT33i6+zw6Pw5RgEhM4tptax9FFXMt+021NsulNhfbD0GFvz1I43fzlSqrVIfxBBBMXzXuh9T7VZvvP4MULUTnM0GVWMKUF4ULobDEzG4qE7tXQoHnFk7OVP1ILZW9OOCh+BoBU47gwIkXyW0YEwrg3zQdpL6rnBLyRvR+0S6MOncKxiq/ZrJwIeexu49TVU5yHRhIT2w2EVX76FmuTXC4XqYegbSCtr8xcnyriubxG/c3o3ABt6i4ADP2fQh3t3YTw045sYeauEWxuuF03nGFD5SvSvnirIZUidWfhTWU6FwAHAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjHfTb6H3d8Acb7Bt3L4qzdfjWLJbPcEZ98khhhkjmA=;
 b=sR4QnzyjgkEUNB9j+x8FkHc0r2mi/Xc/6PK/tdGhK5jokO10ty194+qKzSjttfbnnVzWvjqFjLmv33pFp3kZ9iz3VGxlx23uz4pd5YEcFFRDLC5MuHgeZGW8EbMUGGSwIGJVoTvMBArb6vrjBf4w2QEIAJ8NNo3hdO+gaPNYYBo=
Received: from SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Sat, 30 Mar
 2024 14:01:45 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::22) by SJ0PR03CA0176.outlook.office365.com
 (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Sat, 30 Mar 2024 14:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Sat, 30 Mar 2024 14:01:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 30 Mar
 2024 09:01:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers
Date: Sat, 30 Mar 2024 10:01:29 -0400
Message-ID: <20240330140129.18824-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ad5bd4-923a-4114-bfc7-08dc50c1eef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v4i+xMdodvNlUHbpdCkEy/rEUZmrAvI+NhuWn5CgpiVDA/BYXmvS7N6g4D9BlpZIJTxJonEMyqPr5MOVf8yqEvjNOjZCPuU7LrcN+6YPWHhMui5aq5Cegispcx7xvl4Z/IpmLZ9wE/OsObkrtl8apNtzT947f762HJlLili0N2oSmeLzWNV4C/6Cgj3FCHfsYVBwk9BpD6AwYeDO2ZW+UYKMtfoM+okQbKWWeogdK/tfgzeRI4OPfTtJlXaM085xnYbeD6dE2WUlJ6vChDb8MVDvlWhdkqLLBLOlIPUJNYM1/W9Q/cF1fCMwZ4RYNhbw188ToJfQ9dLdfi7u3Wst5CoNUy1umoVaSZ9kEJId5hKcTCb1Vczy2lwyDeBR4Fmd/ozCbquJZLbDvAKRSKlT9ieLy7Btphk68FQ5W9IBGSz14f/SuxdTptJihO9+szxqpIoP2dmKSAvYEIS0eYXrh/okVDbFG46B4qB3yqxM28CI7vdX0JESGZEKovXEQ9yuc7cguWtHU/1wfatKYLgKG5c0xO1hZ9wfwS98YNM32vRTbQRMAkoLra6OdS9poQF3FkkdHGu3xNbn8r55bwptERuNgwAte/veV5it2qKChEzyZgTOqcDp/n0k/HVEASfWSL83cDetibV5efiO5SvvGvWNXgenu80LC+hrX61uHDN6T7NjKgdmv1XiZQOIOIvmVdcvp1py8MNrzEOxIYSlc3M4rsRV5LIX8lPqvvWONZOXwaqlUrbRgEEPT2fuBXqF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 14:01:44.6001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ad5bd4-923a-4114-bfc7-08dc50c1eef2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
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

Makes it easier to review the logs when there are MES
errors.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 65 ++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 072c478665ade..73a4bb0f5ba0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -100,19 +100,51 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_funcs = {
 	.insert_nop = amdgpu_ring_insert_nop,
 };
 
+static const char *mes_v11_0_opcodes[] = {
+	"MES_SCH_API_SET_HW_RSRC",
+	"MES_SCH_API_SET_SCHEDULING_CONFIG",
+	"MES_SCH_API_ADD_QUEUE"
+	"MES_SCH_API_REMOVE_QUEUE"
+	"MES_SCH_API_PERFORM_YIELD"
+	"MES_SCH_API_SET_GANG_PRIORITY_LEVEL"
+	"MES_SCH_API_SUSPEND"
+	"MES_SCH_API_RESUME"
+	"MES_SCH_API_RESET"
+	"MES_SCH_API_SET_LOG_BUFFER"
+	"MES_SCH_API_CHANGE_GANG_PRORITY"
+	"MES_SCH_API_QUERY_SCHEDULER_STATUS"
+	"MES_SCH_API_PROGRAM_GDS"
+	"MES_SCH_API_SET_DEBUG_VMID"
+	"MES_SCH_API_MISC"
+	"MES_SCH_API_UPDATE_ROOT_PAGE_TABLE"
+	"MES_SCH_API_AMD_LOG"
+};
+
+static const char *mes_v11_0_misc_opcodes[] = {
+	"MESAPI_MISC__WRITE_REG",
+	"MESAPI_MISC__INV_GART",
+	"MESAPI_MISC__QUERY_STATUS",
+	"MESAPI_MISC__READ_REG",
+	"MESAPI_MISC__WAIT_REG_MEM",
+	"MESAPI_MISC__SET_SHADER_DEBUGGER",
+};
+
 static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 						    void *pkt, int size,
 						    int api_status_off)
 {
 	int ndw = size / 4;
 	signed long r;
-	union MESAPI__ADD_QUEUE *x_pkt = pkt;
+	union MESAPI__MISC *x_pkt = pkt;
 	struct MES_API_STATUS *api_status;
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
 	unsigned long flags;
 	signed long timeout = adev->usec_timeout;
 
+	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
+		return -EINVAL;
+
 	if (amdgpu_emu_mode) {
 		timeout *= 100;
 	} else if (amdgpu_sriov_vf(adev)) {
@@ -135,13 +167,38 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
-	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
+	if (x_pkt->header.opcode == MES_SCH_API_MISC) {
+		if (x_pkt->opcode <= ARRAY_SIZE(mes_v11_0_misc_opcodes))
+			dev_err(adev->dev, "MES msg=%s (%s) was emitted\n",
+				mes_v11_0_opcodes[x_pkt->header.opcode],
+				mes_v11_0_misc_opcodes[x_pkt->opcode]);
+		else
+			dev_err(adev->dev, "MES msg=%s (%d) was emitted\n",
+				mes_v11_0_opcodes[x_pkt->header.opcode],
+				x_pkt->opcode);
+	} else if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
+		dev_err(adev->dev, "MES msg=%s was emitted\n",
+			mes_v11_0_opcodes[x_pkt->header.opcode]);
+	else
+		dev_err(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
 		      timeout);
 	if (r < 1) {
-		DRM_ERROR("MES failed to response msg=%d\n",
-			  x_pkt->header.opcode);
+		if (x_pkt->header.opcode == MES_SCH_API_MISC) {
+			if (x_pkt->opcode <= ARRAY_SIZE(mes_v11_0_misc_opcodes))
+				dev_err(adev->dev, "MES failed to response msg=%s (%s)\n",
+					mes_v11_0_opcodes[x_pkt->header.opcode],
+					mes_v11_0_misc_opcodes[x_pkt->opcode]);
+			else
+				dev_err(adev->dev, "MES failed to response msg=%s (%d)\n",
+					mes_v11_0_opcodes[x_pkt->header.opcode], x_pkt->opcode);
+		} else if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
+			dev_err(adev->dev, "MES failed to response msg=%s\n",
+				mes_v11_0_opcodes[x_pkt->header.opcode]);
+		else
+			dev_err(adev->dev, "MES failed to response msg=%d\n",
+				x_pkt->header.opcode);
 
 		while (halt_if_hws_hang)
 			schedule();
-- 
2.44.0

