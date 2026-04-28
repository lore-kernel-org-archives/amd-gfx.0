Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DD4FF886D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0740A10EAF6;
	Tue, 28 Apr 2026 10:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MFD19ymG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D199E10EAF5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:03:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI5ZXZtMbXGc/z/wA85XDjvd31ZAJRxEnS+zVGZIZJ059VhoN0BIVADuzc+hafOnzE8pig4XHDCnos35oomf8A5F2i2XQ9kDZ+NCQ0FZDtgcfMmAa/vtH5lpIpbsfYxn1KyN4jjPtNAgmTyVUFDO0LGGsxdxyOdlOnxuHlKeqJI9e+JoGE+LBn59ngn08ed76b8tPFGDOfdlldpUQGrOUzmoeToUNQLW/hfrKF2IDhqwZyVQNtO02dRrugSF+Jc90QfCkt57TQOJAOUk5glCvyh8794hCKQ3JqgKLtptLW1HrWbCV6ZMKatNbax/kAGLKnQ93BMEyQyOi/5P8gU0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B17AOYQKaY5fV1Ipw39QGrzjDPgcbBiajKYUVbEjCRo=;
 b=pu38NSzmvViItU7HZwSJPlr3Sn/0hOodrSTOVDBVZgN1Rl42LI2Z8hu3ES4ZBuQA00mBPmgS6miNgBr/liYgAfW+WKCCI3wlfOIrLGftiVsohBPWliQS5JC+LRXObB9yJr47EwZG9P7Q9VoG5H40t6bC+I1YrBZnL1113oD4Iejb8TEShWISGRXQVCYCRzEs4S5nDgzkXF5E0wgdIYIEKAVpGlQTNVJTAtYK1mDmgc7xefadGcrf+368WRxFXbCzb1hqnbxKUq8Q7SVizHhDgVsUdt70yWeRB1PmIe904Fle1/ELXPDZDX9XWdAZrlC8ITQxRHZHowxBof+3JSIBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B17AOYQKaY5fV1Ipw39QGrzjDPgcbBiajKYUVbEjCRo=;
 b=MFD19ymGLtl2PuPQrHjc7JkWP7FOP93BGOFaOPNtJZqi3q+8HtOzRV+ARBRFpXOqkA11zJxvTDmblc1VIv/1X5UBuwqUD0hoXXZB61UMWEOMrFHzYpwMlXT0gwPcFWTtssE0EgeOJUk5cAZSbnaS2valI3Jyg07KJ8IzJjvWxnE=
Received: from CH0PR03CA0190.namprd03.prod.outlook.com (2603:10b6:610:e4::15)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Tue, 28 Apr
 2026 10:03:33 +0000
Received: from DS2PEPF000061C6.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::3b) by CH0PR03CA0190.outlook.office365.com
 (2603:10b6:610:e4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 10:03:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C6.mail.protection.outlook.com (10.167.23.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 10:03:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 05:03:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 03:03:29 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Apr 2026 05:03:28 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v3 08/11] drm/amdgpu/mes12: plumb is_user_mode_submission,
 unmap_flag_addr, NOTIFY
Date: Tue, 28 Apr 2026 17:58:49 +0800
Message-ID: <20260428100239.1609179-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C6:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9ec053-9998-4e16-8f3f-08dea50d67cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: lL1SRMN8+HXpDQHyeZU88sLGZI80qJ5N0phlhY9bhf5CCXVkDhaiDnboYYsvrO8HY+DNcyXyYSDRbOyHuVLl1DlHdKEFKJjcnZRYXO6gJrHkg08jvbSzw22S9swH2/lj6QT+KKuHFkuL8mpcMMHC3tYv6OEZMyahKDsKLRK4GHHC6LB8pvWKDyOdQ5H/1gKrcOPTwnkd03uNZ2lB1poyv5V/6qrZZa3AuA/wcaRhMF3imFzyUKaWLYP8vPtF4FIJqSeqNCEtq1hopyJDB2HaFt/vpbCsNvXii5MHGo8A0NFX8CDnPuEie1XDbXDGXeSTX47sbQucN1i4Yqi4w+mscgrZ0qdYvgPE851mpsHPBh9D+ia4JFLcfrkq2Q2E8xdgnF4nqezmWA05p9YZBWc/MEO8xuC7ZQNVW6Fo+2P2/Mkd8iC7G4LlhVHURkOojmGlBsXxXUMtpd3HsuHkX5zrQdwKDRYirXkQwAw7cuplKSFlSpEMYtfOG3bD+8N/m81GXBcropKzGamMicDn2+ohbb85yWfFsHDUzbF+a+y7ZvlsQqtNhwgSnMHZNvPlai0kWt903Gu590+PypqdTI7nFl4YPaOpPbFd0wdYdAV5pyx3hcf4ECNGwoGudIOpk609kOhOd540jzAPEy+Kp4of/Y6pGxcKnF4MpC2NJYVzYahwBXT/iUkVx9UlVQP65tvqB8X9Q3yEf9YxBws6OLMgM5sLD8vgS8k2r+bGVrfhW1l+ivqfbViHreQA5Vs+nUvisU6mUxvw6z5prWz6eN/T8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P2JpBomJeGwSCTWTfxcN87BLCbU3WZS4FwrcpxfBmpfHd23krPUABL4qaILw5ee5y55/WZMagtyzE42R6R0o63Hhhqo4fuKjofCL904a2nMzjniT5ZQzC/PiKVfE8BxWbEC5J3esv6pzA7bos/2hk5/tyEfYHlC1ws3rT2ZCQ4ib4K/5XX662ixIj2xcQj/ppdQvBC9dmUsoAy5wiwBL/qVr8ys5o8TqTq00/r2Mm9lMzu6FQmNRbyQldiG6xXLgcKtkd4wWzWEPK7cxHEN7lIU1nV9O2P9TiVZthTzyOSTc5MT0aZDrV6ILS8kbftpHqrurA5a/sb//aGBLamo7X0VPOASUdGi8Q9aBrMBVzKb4UTY4o7UcMlMdXju+IWosL4HX3Br2iMFPsvAccMjMaYvNvqlO8k8izCKRtz5iEPHBwlpaPExNQsrnY7F6LeJy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 10:03:32.7171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9ec053-9998-4e16-8f3f-08dea50d67cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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

Pass is_user_mode_submission and unmap_flag_addr from
mes_add_queue_input through to MESAPI__ADD_QUEUE in both mes_v12_0
add_hw_queue paths, and route MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE
to the matching MESAPI_MISC opcode.

The kernel-side caller that actually sets is_user_mode_submission for
SDMA UMQs lives in a later patch; this one is just the engine-level
plumbing.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 023c7345ea54..5acc505533f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -342,6 +342,8 @@ static int mes_v12_0_add_hw_queue(struct amdgpu_mes *mes,
 	mes_add_queue_pkt.trap_en = input->trap_en;
 	mes_add_queue_pkt.skip_process_ctx_clear = input->skip_process_ctx_clear;
 	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
+	mes_add_queue_pkt.is_user_mode_submission = input->is_user_mode_submission;
+	mes_add_queue_pkt.unmap_flag_addr = input->unmap_flag_addr;
 
 	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
 	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
@@ -697,6 +699,10 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		misc_pkt.change_config.option.bits.limit_single_process =
 				input->change_config.option.limit_single_process;
 		break;
+	case MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE:
+		misc_pkt.opcode = MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE;
+		misc_pkt.queue_sch_level = input->notify_work.priority_level;
+		break;
 
 	default:
 		DRM_ERROR("unsupported misc op (%d)\n", input->op);
-- 
2.49.0

