Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ACBC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 19:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E864F1137AC;
	Wed, 17 Apr 2024 19:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qSNitVou";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 569201137AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 19:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaGE9sYYnMPiTl5NfkpdGf2uLcuu0Hu2gJCoEjxUEVoguvrToR3AxmTEX1EZfQlSZRHKfODkb68eWzZg2oXAAe3lQRVKW7FhItKdqoqo21rVklx6nceu8vqplgSvuDDSXEfYZvPkBQnGpski1HxmGEjYCH7pOgANPy8Vp4x3iW7SfEsFfWkeuqPQF0Db3P1Z1q+k/p6h7O8ISbxvnhQ6f6jRTaXmPmxm8hFC3TqeyO/T22vC3nATlakvop9AVB36tZQ+ixslHNL87nm19t6coqi3NvkHpMtPY1veMU7R/0QT3M8Kh4+Y9jlElzs0qKPcAT65WgMSmFW8ZoG682OIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoWjhO6TIPCzNfS1CB9JvKrBUL6/vX4fIAwYlDTW/1s=;
 b=ofbVcNhdMpCD5WXIRCvGgYW5PTdHAWRxCG/oVJKvtNaDH2Yr8l2MOg3uT2CAUd4J1Ka7lSpSka0w7t+0ZyyBgMLquISC3gHg+s3WNNnASRZeICbo89IcKQRwYAiw58QCaRQng4ct3X6hlXsxUTrLo7r5OCDajnMJJOhhs82mdakpZry2KwPJGqiXRYnotpybwmXlo9YpFLfNJdDOYV6JwMLMwtnqg5lpuvJqfy7NSYz8VCKGnFzQEuWfJiefvW8Qr4Yb3AGNsFZup5jOW/IP3ubcsk1hGal+6K+9Y5umk7vksmxmpWbvvHn10MEeIMCuPOK4VFWavszQyemZPeOiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoWjhO6TIPCzNfS1CB9JvKrBUL6/vX4fIAwYlDTW/1s=;
 b=qSNitVoue40soQ1qbnbMCfh1fyLswsrk4DeqqjblyoemTVfYE6jnAxMi6d4G0Fh1opGe+JiQpWiM8+fmngWEgX3o+w35c3f50S76xwrxa8ECnz4oDp+dZ2k1cPeVWj9QNWNqJIPwOUHpqeY0Ct4q026QsruA4jhTG+CyY1xIXjs=
Received: from CH0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:610:75::22)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 19:53:51 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::4f) by CH0PR04CA0107.outlook.office365.com
 (2603:10b6:610:75::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.38 via Frontend
 Transport; Wed, 17 Apr 2024 19:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 19:53:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Apr
 2024 14:53:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: print MES opcodes rather than numbers
Date: Wed, 17 Apr 2024 15:53:34 -0400
Message-ID: <20240417195334.3718659-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a23e49-788d-460a-b884-08dc5f181a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5/H8IBmwlyBOw38Qaevv2XCPRkU1oNqm7rWlSfnuVaRCy6VVZYn6xdSsOiLx/sxyhfMYUZnQKudb4sofWeaRKs1LjVFBaqjDgdv61zaB66LTZkjQWsVvezmlSpyWm+ujlhd/vIb6d8IaOMMcBg/gwGShzoeMfgvGjl+s1qZCQUy3y37dfGiI/gFczdnFAY5DCNbvyG4Kncy3KHc1dFPKH6tODZnm8B05YouHQgTzL1YzqagZHeNlQE6iOrg1It+V6UPbYyAzrxjBIacI2jjwzowcp/pwiXNjJ3w/Qa436DZ17VKSMpJ6OfBav2d3MWYyu5DSG1tROos65g8kGoKzxlgLDNv1W3Elobtydq4TI/n3WGB7vdwQ8UravufrvWAF5WnSVYtCzYNYNStdFO7OCn3hQIgJW7HqC0gQIb2Ee1oPe1+Kg+7kNWnhscGxTqcjhScqZWE2cluNbIMc+O9t2iVtkNeZwbRuCH+rArCEDHRLmE6uXxNUxAOeLrAyevm0RifT8gnVHdlhMM2ewK4vHZToayw+7zBG1UBgU3Tkj4bnDV0AS5UodVEG4v1eGEIGKlzmEE0TuJpcfKHtirw8xCym5ReHpnjVVvRYKk7CfoQpXKalfjySHsP4FYxB1aQ+ggclpkljcOM9As0SH68lSDlFlqT3vg6yCf6+lLFx7dxgW7hOOv6g/L3C9cuuvrcH4bujKfgNOkhNUhMX2NTJ+sjTQLCt8/c9dw347rh8YKWxJZgf4Oy8p63es7vYRDh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 19:53:50.8124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a23e49-788d-460a-b884-08dc5f181a85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283
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

v2: use dbg for emitted, add helpers for fetching strings
v3: fix missing commas (Harish)

Reviewed by Shaoyun.liu <Shaoyun.liu@amd.com> (v2)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 78 ++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 81833395324a0..414b7beff397f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -100,18 +100,72 @@ static const struct amdgpu_ring_funcs mes_v11_0_ring_funcs = {
 	.insert_nop = amdgpu_ring_insert_nop,
 };
 
+static const char *mes_v11_0_opcodes[] = {
+	"MES_SCH_API_SET_HW_RSRC",
+	"MES_SCH_API_SET_SCHEDULING_CONFIG",
+	"MES_SCH_API_ADD_QUEUE",
+	"MES_SCH_API_REMOVE_QUEUE",
+	"MES_SCH_API_PERFORM_YIELD",
+	"MES_SCH_API_SET_GANG_PRIORITY_LEVEL",
+	"MES_SCH_API_SUSPEND",
+	"MES_SCH_API_RESUME",
+	"MES_SCH_API_RESET",
+	"MES_SCH_API_SET_LOG_BUFFER",
+	"MES_SCH_API_CHANGE_GANG_PRORITY",
+	"MES_SCH_API_QUERY_SCHEDULER_STATUS",
+	"MES_SCH_API_PROGRAM_GDS",
+	"MES_SCH_API_SET_DEBUG_VMID",
+	"MES_SCH_API_MISC",
+	"MES_SCH_API_UPDATE_ROOT_PAGE_TABLE",
+	"MES_SCH_API_AMD_LOG",
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
2.44.0

