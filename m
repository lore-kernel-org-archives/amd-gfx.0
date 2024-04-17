Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EFFC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 11:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C93210F680;
	Wed, 17 Apr 2024 11:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHRfnF/v";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F5A10F584
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 11:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzHylmX+MbiZvghej5PpadPnTy9+sSMpWC1O9vcain7b4WaoVwyKBlCIpyn9sc9OmQ6J3Jse8bYsKc5iOUDdFcygwZy/BF3haBA2GK/OWpIVMz5pn/HcALT+xXeadUTJvCMiHlAwGtWvm4PLCVd3FZPBJ6hE/i8cbUulbnI+Qr8gkIQ6c54vtF5wBp0NGWWIOKXcC0VhmzzO4+B4006pLsk1MQP48nYFyjmwjXi1xOBWwWZQKksTfnAU+SKWlrlu22Ru7LJ0yvXmeWXAtWUG1arnbvu88I6gaHeoaUgvoNi4RWlOUm6/RBeZR1zaN96MGbHPF5WdeCOUb9D5F7Y/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELPviqw6sOATCV2+keHnT0a9HldDh/m5QlJzFO6bU6Y=;
 b=fSn6COpNQ0b4XzoK/V0ssgjkHvMiKLs2LLBRm0ZnvJA31R7XNunqkO/B5P525fqAYvzW1pHMAibNYWZQy3ggM5Bugj6kk/7gC7JddrUbMByTO27/3m0UZ0RymNIXbM9gHoVT/yyZYRaeRF045wzpYBmtDPY+SCXjm2iUlTeqlAFcfsZs0AOPJG1dPRHwu6mzaEbkDHIWc/gnrQdVeRwO8NKasYptoE5gmePpOWRsBd+Uv1vZnr6aoYAMaL5Pi/+pNq5Dp46rNWa8iV/hCsLUivzcF91zfr0FeQ4GdphGMH6v7RpzzYwxDP5ruYvl8iwGZq6P4DJf8Spag/AbgbvtOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELPviqw6sOATCV2+keHnT0a9HldDh/m5QlJzFO6bU6Y=;
 b=ZHRfnF/vyXm+NLtjAUNKVrDd2/oeSJnMukWXWNprgzHqtBceJX+kB/eqqGpI0Faouw5tODTh76bydj2jYH3mONQ7e3qfgI40Gh2yLkGq2Llk7aInLapS+E3KN7TQLqkzaElM0dwOQNs+xIRCUzxMnAigF2h0Gud9Qw+KpfI9FYk=
Received: from CH0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:610:77::25)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:31:18 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::f8) by CH0PR04CA0050.outlook.office365.com
 (2603:10b6:610:77::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Wed, 17 Apr 2024 11:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 11:31:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 06:31:16 -0500
Received: from horace-sm-debug2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via
 Frontend Transport; Wed, 17 Apr 2024 06:31:08 -0500
From: Horace Chen <horace.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, <horace.chen@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Deucher
 Alexander" <Alexander.Deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 "Hawking Zhang" <Hawking.Zhang@amd.com>, Monk Liu <Monk.Liu@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Haijun Chang <HaiJun.Chang@amd.com>, Leo Liu
 <leo.liiu@amd.com>, Jenny Liu <jenny-jing.liu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/mes11: print MES opcodes rather than numbers
Date: Wed, 17 Apr 2024 19:30:23 +0800
Message-ID: <20240417113025.2886905-1-horace.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: horace.chen@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e76540-3bc3-44a8-feb1-08dc5ed1e5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kA1vSw9SwHKdXYV71QJuIiFDwz8F0OXGXxl48OduA75lY2fgsD2QH/dXCunVL3JheeO/l2ftCVphUbprHwU5zrwo8ObgteS1tdmdOExYA/0YodPHdazHtK4QLLinVCcBT/zgEnwooyc9TZd65ag95RMdfIMNw/sMObxmnKbX+ZRyF5kkVsf3w2g9ELLecOIzyglarTkFgrRyrzfTLNOQFhuzVwMGn3xC6xe0SV5KQS1omx1phPNkTl41NYLGTZ6HmyE7JWKsYAIZFUOt0g2ptFFRySP8rXAxPCxIWbI0x8sVrQN0Inap35Jv7kfmBbh/rgGtvHswoywSlnfzCEgx5DPNJCNxlFrEfJHqMbBA/4bIq9VfuKkoWeNvQJg7Vq/glyn/BhiHly2xB4mIExggFVeRcL5GLaPGxvnEmyCHyDjF0dGwj+/hd4T7yiAZ9xW0oQS4+WFP18mZyiH6tcPSUDIN1SgeT+m7ZcqY0RnFOfxrDhuQ+VVnl6mEoRA7Q9e9FJiJK8k7n5egGdY7auNr3mKXg77OlcYwwYmCVGv4oN7GcqBILxnI6ded1u9T0I1F37EfV8AYUU9voLo0+e8dalisdaH1qgbl2fcUpEBOEjlDEb5lU3YtFVEgQJ8wOlziHoUqWqZ0XnkBwWH5aAvcr+JQxAB0OUSb1w11pzxF4ZFfRGuCDcwtqoJdM21yDxFMvtFQfIxg7Gb82rOaSowVpu/P1dICIWo4Z6q58Lfls/2S5/MezTn9TkMtjOLmPGfJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 11:31:17.8200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e76540-3bc3-44a8-feb1-08dc5ed1e5f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
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

From: Alex Deucher <alexander.deucher@amd.com>

Makes it easier to review the logs when there are MES
errors.

v2: use dbg for emitted, add helpers for fetching strings

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 78 ++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 81833395324a..784343fb7470 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -100,18 +100,72 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_funcs = {
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
+static const char *mes_v11_0_get_op_string(union MESAPI__MISC *x_pkt)
+{
+	const char *op_str = NULL;
+
+	if (x_pkt->header.opcode < ARRAY_SIZE(mes_v11_0_opcodes))
+		op_str = mes_v11_0_opcodes[x_pkt->header.opcode];
+
+	return op_str;
+}
+
+static const char *mes_v11_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
+{
+	const char *op_str = NULL;
+
+	if ((x_pkt->header.opcode == MES_SCH_API_MISC) &&
+	    (x_pkt->opcode <= ARRAY_SIZE(mes_v11_0_misc_opcodes)))
+		op_str = mes_v11_0_misc_opcodes[x_pkt->opcode];
+
+	return op_str;
+}
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
 	signed long timeout = 3000000; /* 3000 ms */
+	const char *op_str, *misc_op_str;
+
+	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
+		return -EINVAL;
 
 	if (amdgpu_emu_mode) {
 		timeout *= 100;
@@ -135,13 +189,29 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	amdgpu_ring_commit(ring);
 	spin_unlock_irqrestore(&mes->ring_lock, flags);
 
-	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
+	op_str = mes_v11_0_get_op_string(x_pkt);
+	misc_op_str = mes_v11_0_get_misc_op_string(x_pkt);
+
+	if (misc_op_str)
+		dev_dbg(adev->dev, "MES msg=%s (%s) was emitted\n", op_str, misc_op_str);
+	else if (op_str)
+		dev_dbg(adev->dev, "MES msg=%s was emitted\n", op_str);
+	else
+		dev_dbg(adev->dev, "MES msg=%d was emitted\n", x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
 		      timeout);
 	if (r < 1) {
-		DRM_ERROR("MES failed to response msg=%d\n",
-			  x_pkt->header.opcode);
+
+		if (misc_op_str)
+			dev_err(adev->dev, "MES failed to respond to msg=%s (%s)\n",
+				op_str, misc_op_str);
+		else if (op_str)
+			dev_err(adev->dev, "MES failed to respond to msg=%s\n",
+				op_str);
+		else
+			dev_err(adev->dev, "MES failed to respond to msg=%d\n",
+				x_pkt->header.opcode);
 
 		while (halt_if_hws_hang)
 			schedule();
-- 
2.34.1

