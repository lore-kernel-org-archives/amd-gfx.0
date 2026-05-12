Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B91CD37BE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 02:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8323110E50E;
	Tue, 12 May 2026 02:48:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0rGMKzZG";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE0DC10E50E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 02:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DF2T1N5c1phw+Wx2gjcmAFeYW0gPGKiu2Gd0NVzBhLb8ortCkU6bPk9qknE9aOU1JTys4ni1zSbPU8k1+NpfPd6m8tnLTMbXMrtAtGmq7HtdFJM4teCLAOj/P6Wf73taG102ut7q6ojGTyjz4HXFkgzZuoGxgKIE4JhIgkY0pQigFeJTSZTnU2N63SNB3EWW36aD/fWXf0zQY5iCoXhd1fTN/6ZdYwD4WlVYDF8/bW/Emo+T01spvjR0yfPf7llQimhk6E4qjWEi43J7mAtINEv7jOHcPbKNPT9jTBPwEv18V0oCbUchgpk2iJbrWeU5VxWpW3r3KZiQlqjOv8xfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF9n1rbok7tHVgZkw4Tw5awUTxpaOYd2eMDxIXE5B3g=;
 b=xfZTi6U+D0EQwxC/RmmxOGCgtNueIoVaHokML6tmyji16TSjxXPerhrixhE1vk/5sAw/Wf1ACLjaaliM7GBsvWL+yGY+cpxF4vyRKi6PqgfC/OsM66Jc4sB8X3kfTfxTOcIEWKk0Mao8YfhfVnXbj2cv0PYbvpJ+M/hayNNyZ5eKtdfNAzmls7MDoRUtK+A1WEZMy/dzY1WQM3YF6h0i7OmxqkbVwvrx70n6NgsmzyDWDz8n8XUnRZeDVxqryPZvL6n/vhcnoXlfvoYkMeUJKgwuPi0+v3ibz3aGdUJlI92AGV1OnK0tmfQnaQhofLNPwaTJGj8vjubqk/30nWwLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF9n1rbok7tHVgZkw4Tw5awUTxpaOYd2eMDxIXE5B3g=;
 b=0rGMKzZGlFNzTUBeOr5nc0uGRx3j7UMRL1J6jIL96xZioQqIOCJ1nKuH2N3mMbBW2iq0JnzZQyVNJz/HxzAXBIzf2tAAcOehGl91o9a1P6IKEt6C1XfonsLalp4rSSMcEMFtdao1AVEm1ogJFgZLfcfhmz8Gb9eDLzLTw7BnaaA=
Received: from BY5PR04CA0018.namprd04.prod.outlook.com (2603:10b6:a03:1d0::28)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 02:48:40 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::51) by BY5PR04CA0018.outlook.office365.com
 (2603:10b6:a03:1d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 02:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 02:48:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 21:48:38 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 21:48:38 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 11 May 2026 21:48:37 -0500
From: Alan Liu <haoping.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <Mario.Limonciello@amd.com>, Lang Yu <lang.yu@amd.com>, Alan Liu
 <haoping.liu@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu/vpe: Force collaborate sync after TRAP
Date: Tue, 12 May 2026 10:48:34 +0800
Message-ID: <20260512024834.1945236-1-haoping.liu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b999e8-cf3c-4c81-347d-08deafd0f8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|13003099007|56012099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info: 9yHrjoLD960o39dBrZZZ/Sffvr4vbB+04w6D8r+Z2L8kHhvCd0XmuxW1kO0iVpSC5A+YAVIPKX3PVMV/CSItwJD+bbreCD+aYvA/W3pgaKO+eyshQtDfzBW+7IX8v3dUDOLR/0rUAgR8vJFTekzgJrBXl6WydZ0U9ocweV7bfKf1TqdD4Apx4xZs3RX2LKnWzZCIE2toI44VhMRbwsrBq0ENgXm8wSOJFqc5+y4Zn2gFZWNK1Q1m+2gDqchFUoyS9GMlbvVhS2M6Jjlm4DSmCpJbtC5u+7qWlUhqC68IpBxwfccQjFjt150R0ZxtHl0WhZ55+jDS6yxvohPI8o04/QVG/oF5QymbYLN3uHq3tyOIKyJWPqO8E8QnnE8v7721htS5bGGbVJ7XaBZAmvaARqK6j9VYjjNFaMLYQhmSP/ND1LQbqHbrVYnSv9A9Xgn7MsufVLJV+FEccX9S/vTn2snC8rc/J+zCvq8exmIlGBLaM7sRi6UIMSxXLDAZpNwbDU/i+gwTyYnZQ5xDGl0VdJSfYnpWKfD5vEgR2YjRUNk06xDm8cznxH+X9Fu1Bk3ki0SrfHNixkcbg5coWXq1Q8f2I3iYBuVhljDKYighiqZusOM15TmpFfNjr7ke5GZfNcF8Fq777a+7xsr28QS+E/BGkdQe7zj8Jo3fZhXwf5R6DisTElT+BIwcXDIgI6ZG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(13003099007)(56012099003)(11063799003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d2hjqPXnnIYwx26vSR0WFKkwGvca5Mym/i6Oin/X/GId75kwl98gzp4ZpUMO8yT9pa0034cP5Mob25CqraL4iomjNMUu0/ymxxDEfRVMshN5UEx0gURZoYWsYh67n8NkhD9Ujfwu1gGjBqV80gpoQ9JIh8sKC2iCEJ9Ax6gEOE3cw35n13oHds3Aujz3OpWYZMQJUX7JI/STOEr98+nRhZ+1mUnBGx6pERdH5pzQf2iDewlopyAmUgLnne2/oit8YIC5t2bLCCi8CIU7RuxdVTinrSaVe565nvLNlW7+W0SdgEnZKml+pn6Erv5LWkAJ2w5ULZphOP4Q9+aVle9cG8xh/jkJT7U6VQWg7nUfH+S/r7nutlg5i+b9pSWWb/Uoygzj2s8t1wrJy4gS2uycKoE8qfTlmlX0xvj4w1ruvAz3/oPshkmT85mk0ePtRw2D
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 02:48:39.1506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b999e8-cf3c-4c81-347d-08deafd0f8a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
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

VPE1 could possibly hang and fail to power off at the end of commands in
collaboration mode. This workaround adds a COLLAB_SYNC after TRAP to
force instances synchronized to avoid VPE1 fail to power off.

v2: adjust number of DW for ring allocation, and improve commit message.

Reviewed-by: Lang Yu <lang.yu@amd.com>
Signed-off-by: Alan liu <haoping.liu@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5171
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index fd881388d612..f27f917e3cdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -562,6 +562,11 @@ static void vpe_ring_emit_fence(struct amdgpu_ring *ring, uint64_t addr,
 		amdgpu_ring_write(ring, 0);
 	}
 
+	/* WA: Force sync after TRAP to avoid VPE1 fail to power off */
+	if (ring->adev->vpe.collaborate_mode) {
+		amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_COLLAB_SYNC, 0));
+		amdgpu_ring_write(ring, 0xabcd);
+	}
 }
 
 static void vpe_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
@@ -968,7 +973,7 @@ static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.emit_frame_size =
 		5 + /* vpe_ring_init_cond_exec */
 		6 + /* vpe_ring_emit_pipeline_sync */
-		10 + 10 + 10 + /* vpe_ring_emit_fence */
+		12 + 12 + 12 + /* vpe_ring_emit_fence */
 		/* vpe_ring_emit_vm_flush */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 6,
-- 
2.43.0

