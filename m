Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC40C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 15:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C111D10F0B2;
	Thu, 20 Aug 2026 15:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dr9G/HEk";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A61310F0B2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 15:25:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIjMFZioFNKUCx+oyo2WmKJB4DKiSeA03rzJt6xBEoUfvb2hWDb/22sT884phwW8QpLckag7i0uzFgmSU5UCV0TwEdh6uOMdIKOWS4APh3osqUbPQipUDJKYqTdT58baIIwGBtIONNlvqIGEM2mmSG5yRi6w5fkTTDYDRPdpRaslSBbyPy4ngX567Nebtm+uJ82BW8xY72SvlRNjyZ6StqT1mLkXZpEQvqH3z6snnPcKPMXOfPun19wMSdo+gjzQ5iguGxuv51NfWcSbsYdPA14/qfvQI2gIvcjjV1k+ixblGVJ4gx1ePwbUsexT4wJjbEJnGIC1jsny8sE/MMTXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bnm8cZ+HI3NR4TC8CtY3Bwx4xKMCbVvZM/aRaYD/X48=;
 b=zSgBh33JhkWK1JzYaYxlqPFnaT33rmZo1ns//FFlH80S6rls29w5eqGUy6DOUstkSvgVfRDgEPQYu2aH4LE/677NiOmtao5FRX+VljX4y4HutPFHZ6C/5cNoRXuAZfy8fb+OJN/JFzj52epDG/wXPSw0iRgp/IMrzSZ/qm/jx5MIK3DahBBZZroDQJaPzXT2Mp2YMSiTc9UGBCX5kZSNfOTUCwvBRkDyy4Zq0XzgJHBeFypYLxEYWiXvdcFSWWlkfr06Y/WF3YC+8eK1Pz+tO3QfS4UAqt2A3KmtU+p5rpDaP6HC4nmgeQXsYIrmk08hUljOD1s5xdna4HUM0L33Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bnm8cZ+HI3NR4TC8CtY3Bwx4xKMCbVvZM/aRaYD/X48=;
 b=Dr9G/HEk9RpR4rlV276e2wTDdsBTw0ilDE+MHWty/0rMabHiQCf5o66fT5r3IZpdcw924wSq2AcXPowfdW7QPzmhYqdq0TZLX4BVU/U51o0HJt+f+ZXeePMdQQGstb2Dz06Sghbhki/GdJrav/8Nr7KTDR7aINYQ1YOdnB3XgfU=
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 15:25:26 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::a9) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 15:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 15:25:25 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 10:25:25 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <shaoyun.liu@amd.com>,
 <alexander.deucher@amd.com>, <Jesse.Zhang@amd.com>
CC: Amber Lin <amber.lin@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Fix reset_hw_queue on MES 12.1
Date: Thu, 20 Aug 2026 11:25:03 -0400
Message-ID: <20260820152504.1160822-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d3aa61-587c-4f5d-8e19-08defecf426e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: AeerG71Q//ZukuFVzYmN2jKkRiC2SXh7mP5/vmTawYL0N5FTF2B2712wl4AxeDOnIRrTRbuxwwEFyXttnGRQ5KbVTnYpYvryZOkBTgOdUQ5xv676oKrTdbTAeEHsZoyx0PjC+xuboO0gD5wUPmDaseRn4IenIo84layMt3EcHpckmXlnJRcMhwVvK+JfoCybZQtylXQV57u813zJYNgPg9FkIrPYYldEzdI+RSbeALnrayDLrluySypMNBzhwSVOc3hiA/35B1qV9FOZMMW+tN51a5kyYAuH7zzuX2PrgZaSRQOhfPYj8JqAT58J75WzgLYxMvurnxEP/UsJGGshE095ZOtJM7RCKUrMUltdrpqo6qAyOOldM3j0g8M7aMNqHE0cn0emdwc52qpwcFs6yBjlLH0ERu/4Q36epQyZlCc1xLYn7iYYGFQcacqk79OP3112sSARKY3rLweoR57JRQMy/rNaKkHtLFfO+9R98HgdhKxIsb9KpzPaoJVd4Q6DGDaijslJFQNG6HW6ndlWqvcpvyxM8Mvk9tj3PWNMauB24rZ6YqfoPUY/BDFgvIcN3HXEX9gt5TWBuT8/YngcTUNVmDi2jovEDD0SK0Cz5GKwNwvDeZ1CCqhaGgg6APeMqZc7EYTKovhe4FXq8RGSTm7xFsqhoWkhPSgO4WINkmRip4gX57ijNglSiy1nsPppcixknyV83oB46f6zVRTEkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UBCEIcVH2R2g442KrsWg+htAXgzDMnKgz9jL2RPHUaSnJwHGenOVqycIKPxXl//w28T3xbuL4uDTAbRiWXmFRhzNaHMQNSgywQC3xSeHiarRWMkmmrFWdLy0EKu3gsJar7PowKYdl40IuZ2BZGAO7IgGVcyUjlWwVhWPepbt7ZaZyyVCXCMJVb9ijLoTm9KXDOxUpCd0g+RWugTRuZ00L4S9d8jNHCrSpVIKspvfQgxAN6FFAQ2yUx362sLeMdRi75UMr6/ZYPDAuQFudyy3+hciOD+Vu6UzcLCPBdIqCOvt7r3mRail+BhO53+Uoure5dq4xjbUjLXoqfinBzLjDx0c1VJassea52oNaGjp/4oBnqskGsXWn4zLnnX12ytDWQeJT2/OLT7w7hVtYYyMOG4cNK1VqfyqV3oZhnsn/m62DTjyZJNP5DswEyAeiB2S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 15:25:25.8321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d3aa61-587c-4f5d-8e19-08defecf426e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
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

Different from detect_and_reset, reset_hw_queue performs per queue
reset. Per queue reset setting requires reset_queue_only=1 and hung
queue's doorbell_offset in RESET packet. This packet must be sent to MES
pipe 0(SCHED_PIPE).

We also need to set enable_compute_pipe_reset=1 in SET_HW_RESOURCES so when
queue reset fails, MES will proceed pipe reset.

This patch also fixes a bug in mes_v12_1_reset_hw_queue function. Instead of
using MESAPI__RESET offset for api_status, the existing code uses
MESAPI__REMOVE_QUEUE.

Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index f1098118d5c0..8ecd9cc85cd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -378,7 +378,6 @@ static int mes_v12_1_reset_hw_queue(struct amdgpu_mes *mes,
 				    struct mes_reset_queue_input *input)
 {
 	union MESAPI__RESET mes_reset_queue_pkt;
-	int pipe;
 
 	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
 
@@ -388,17 +387,12 @@ static int mes_v12_1_reset_hw_queue(struct amdgpu_mes *mes,
 
 	mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
 	/* mes_reset_queue_pkt.gang_context_addr = input->gang_context_addr; */
-	/*mes_reset_queue_pkt.reset_queue_only = 1;*/
-
-	if (mes->adev->enable_uni_mes)
-		pipe = AMDGPU_MES_KIQ_PIPE;
-	else
-		pipe = AMDGPU_MES_SCHED_PIPE;
+	mes_reset_queue_pkt.reset_queue_only = 1;
 
 	return mes_v12_1_submit_pkt_and_poll_completion(mes,
-			input->xcc_id, pipe,
+			input->xcc_id, AMDGPU_MES_SCHED_PIPE,
 			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
-			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+			offsetof(union MESAPI__RESET, api_status));
 }
 
 static int mes_v12_1_map_legacy_queue(struct amdgpu_mes *mes,
@@ -743,6 +737,8 @@ static int mes_v12_1_set_hw_resources(struct amdgpu_mes *mes,
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
+	/* proceeds pipe reset if queue reset fails */
+	mes_set_hw_res_pkt.enable_compute_pipe_reset = 1;
 
 	/*
 	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
-- 
2.43.0

