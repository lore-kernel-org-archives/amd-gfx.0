Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C8AC5B56A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 19:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED2C10ED7D;
	Tue, 11 Aug 2026 19:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lMQDnR4Y";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CEB10ED7D
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 19:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qw9/u5sF19Pin+Zo9pvmPMAuhI0qG15RLoyVoalqwBBAtA2Hjuq1ef30bjjHsxc47wBjwjXLd4Y1ZhopJ0eBdcs9yfIA4gAZvtltEdUR/QlLkPjT79H1OKPVoGFPhUm6MXX/a/sIM9Di7/sAvAwi/aao1bd1g6zgO3ec6frbw4E04SxeTnMAr8nWzRmDrX+tcynSzu9OFrrYqOyThnf/P8BBeegdtNJPIMbdrDs+W2q6CSQ0g6mr8ejRws48AiZZLgv0K1M6S9DfyCdUPgVMBHI03txirvAqkbIr11lT1PyzF6o5MbP39f99KVg/oPX02WTV5wZoIMLpU4fP+5wsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yR1lkEvNjYMvZ303upUEPQ4jDKqTgEsGGJ5UIZS/pQ=;
 b=A2/nlbMAw4/f7hXH/87FGbeCgCiKM6+BVKm9EKFJoMHeULonU/zXLvWqN7Hz7tloci64MtmXqMDNw8+N2v+0pGidFcTxjk/5NAXhSH4QtP4MxuVLLOuCqJdOzsrZWlukOfAaSQQmSv6lpPxbOsJwzGYr5RLlSWTDOAC0byYGrY3sDqXbs3wUtL0FbVYrp7MA6RlZGcAZ5KPxmhdQknNwalDaVGUMufFRfg64XyWZ+w0WAGUQJxOMLVIVKk8QfRZ2A2RM8MnO0Vnc6iFHPsQOlTweOAPpjSG5Fx0PB3OeJ9/e6kJE9YlJXKCiKEfe4wBFNN43zx8GNXJ3LiF2a7SkyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yR1lkEvNjYMvZ303upUEPQ4jDKqTgEsGGJ5UIZS/pQ=;
 b=lMQDnR4YoXffbLTLGbazVCVgM0nc/1+QolHs90ec3VdJ2YPZjwdvzLU8qoRymiwWUz3ZcPSdR1wgze0ZAHnnHW3Hat75HT9AFnb+qy93IBhmelePY3ZfKJFy+wQyDB5IjJTiGJHN9chlCqsIlt+ncTLZloQAKGvbhT9GiVfCk/k=
Received: from SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) by DM4PR12MB5890.namprd12.prod.outlook.com
 (2603:10b6:8:66::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 19:54:28 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::44) by SN6PR2101CA0023.outlook.office365.com
 (2603:10b6:805:106::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.2 via Frontend Transport; Tue, 11
 Aug 2026 19:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 19:54:27 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 14:54:25 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <shaoyun.liu@amd.com>
CC: Amber Lin <amber.lin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix per queue reset on MES 12.1
Date: Tue, 11 Aug 2026 15:54:07 -0400
Message-ID: <20260811195408.1000488-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 33449f29-82c9-41e7-4514-08def7e259ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 1rzXV2QAvuaANGlnZPBo0BTzVqWGn60aBlDnTPFsJvuTb9iAtLfkdjy/TD1MnWPXnMN7m/4574N0QFI0xhf8f2Y5bKt76tWGuTJP7P4RoaMwxK3HoR/d/noe9WGs1zcUxxgf0h5nTlm62kQunuhsWKaiV55raF8LeaREpYRrPLIa/IlvWbGdb4wfMQpjx/zRgomVk2pvxNSPA7WD7Kaj7eQwWFB7ED25oyxxrBaM2Hqme7nmyJB3sQzcaH+Iyh88e4FZEIF2twRSY5VdRcCLTVberzivM28JdLn4w7hW6wpJ1rYU8dYs1ojBO9sDZFk3/qrPcoNJ3qLpscQB2698lZ5DXKrsFq+SFD8L4qus1U5YUrZJjdwFF62+25linU4c9tVLFIGJyq92OlihJ485yeJ99W1ECiYsJ+KNzbaGmRm5gCO95SUJ3eECvN3wU8m+2OoTBZQbVpEnMijlml2sxQt4aPgYQ1QiRzCL/QbKW7TNqwEiL5ITCODkALESG/EBM7D/gB61oBBJum/BZNNrm/YNZIL+/DFVus/IF4FGLFTj2ZhM7fHyucnU1yRK/UDVIyNzn/OsotZD73kxB4Im6YuS+CB//bn/mvMVZL+JFWFLCUmrnsbw+Oma0W4NFJ/380V5zvxf5TtH5Ld7+RigjPAhk9o/ncISZr4VaZosqqhZphcJsv6kHxJQ/uUPdo5q0QYJZqJtFy6fztxMApnpxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YDU06VAjItBF1ggLGQHeUh7lwPBzqvgy/CLRwG7rFoDk6piVLSOabvbHN+UElN6RwH5PybRnA6rJGCYfGihRWL27N/vm3QUCk0QJdO5fxSrPv4gCSw3EQdVznhmv4ocJ/jSUKkHXlXcGduzSJWYZG6qXNFmxFVRvziRXy0fcrGIhL1Jbn07YDcJswpPRc6rjsAu1jMLSmEudQ6M1l7FZMDIqFRmAMf8BtyXk9jFir/jIdGTG+KSSx8UME5HnqGu0EY9wg/654xetPpsjGMQqbTf95TWipWqzDROZsJ21cnxWUI72/1QpHUOz/JXopFuT4h5TIA5eGbrfVkVi2UczZ1aKVbxzs2fFmj8ovjYzTRgj2U4rasUI+WZm35fBn55iJQEoH2BxoYkEJqlzxdXJNzI0BdXQ/ROAfHF7uKZSBd/1etAjPUJ+zDCGX7cJMiAM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 19:54:27.3641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33449f29-82c9-41e7-4514-08def7e259ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
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

Different from detect_and_reset, reset_hw_queue performs per queue reset
by sending reset_queue_only=1 and hung queue's doorbell_offset to MES
in RESET packet. enable_compute_pipe_reset=1 also needs to be set in
SET_HW_RESOURCES so when queue reset fails, MES will proceed pipe reset.

This patch also fix a bug in mes_v12_1_reset_hw_queue function. Instead of
using MESAPI__RESET offset for api_status, the existing code uses
MESAPI__REMOVE_QUEUE.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index f1098118d5c0..9c01dc97d271 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -388,7 +388,7 @@ static int mes_v12_1_reset_hw_queue(struct amdgpu_mes *mes,
 
 	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	/* mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr; */
-	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
+	mes_reset_queue_pkt.reset_queue_only = 1;
 
 	if (mes->adev->enable_uni_mes)
 		pipe = AMDGPU_MES_KIQ_PIPE;
@@ -398,7 +398,7 @@ static int mes_v12_1_reset_hw_queue(struct amdgpu_mes *mes,
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
 			input->xcc_id, pipe,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+			offsetof(union MESAPI__RESET, api_status));
 }
 
 static int mes_v12_1_map_legacy_queue(struct amdgpu_mes *mes,
@@ -743,6 +743,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
+	/* proceeds pipe reset if queue reset fails */
+	mes_set_hw_res_pkt.enable_compute_pipe_reset = 1;
 
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
-- 
2.43.0

