Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2E3C25B4F
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 01:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3414C10E0A4;
	Thu,  9 May 2024 01:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EghyMzlE";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B43DF10E0A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 01:45:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT0wzMg29bvcz0/9ixVqSRwutvPUv9E5/y14ycb/H5foQBEHJGKVqgtAa7lOuCmo1cAZwt5RYEt2DSuNHLRnu3DG1Sl7GMumys5dRZ25k2XGeUZXLB6YAKSWFC0mLyvR5VqZ4RFNxAljgDJEDaFTv268E+oQzPsOwed2xbbUABstMxK35BGK2C/2N5ICaTum/LyPHIfSGpMbuPRGm4T1a0R/LsM8kpJs3gsRiyuZ9tEpEm/El5sFMg3D4uuTwxp+8HVUSZEzyi6u3QhkDPvdZYVhdn83e0588b272xfDT8G24HLLGzU9JvgP4je4mCMiPRjEIDqMrgNFUgqszVoujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC/81vc+bdRuJ/1LFTOkzxkopeeDfc/CbHnHpDjOVfY=;
 b=Zd3kXesf56j/rpMJ4cBdl7WHUEt1hLn6MVmVxqvUl3pYXZbY9i9BE7gyXV9aKOO7BfosxXrF/zghQKvSvfRwKHWnzn7pwkfRf8QBOehOOZRUKd/ntVSVWktyuKq7R2XRP9lOVGLMCExxOXHDsPE6/N/YBrUUj+TJ3zQsaEeNI33Z+vN+LNYOkTdxubaXlhWSvR+AWR3nN4XxGrSJBIE/GDSyFMusbFZtOiYgzVwblzjJTlAvRICdcjtQcLXjb9PAdDNI6N8gFmbngf54FNr7/wDz5YPXKhAD+j6uFNYz4bu9L1UvxNVlg3sE8nnjDxOuGrBFUat9yjw8LNpbNA3JeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC/81vc+bdRuJ/1LFTOkzxkopeeDfc/CbHnHpDjOVfY=;
 b=EghyMzlEh3E/f8TOMDOppo9M88DNjTvcpv3tKhvXFRr/hblvhBR0adDcdfFNxHChu+gL5DvbTEAIzWxMLtltQu9CCL9vIUSWuHWuRaqYnkYCSTja3xD/AOx6yCaWDvmZLE2Og3xd8afD1EZUWtfzZOXs8MHzUrqFfCUyovL0sXk=
Received: from BN9PR03CA0425.namprd03.prod.outlook.com (2603:10b6:408:113::10)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 01:45:35 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::ff) by BN9PR03CA0425.outlook.office365.com
 (2603:10b6:408:113::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Thu, 9 May 2024 01:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 01:45:34 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 20:45:31 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu: enable unmapped doorbell handling basic mode on
 mes 12
Date: Wed, 8 May 2024 21:45:16 -0400
Message-ID: <20240509014516.533962-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3b614e-822c-432f-5389-08dc6fc9b821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017|43062008; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YGnjqmmBEEV+weoiFULzXBwAh+28u8GE8JHjVkMpZdpkwB+rdiovhBBR6pan?=
 =?us-ascii?Q?rcqjcOk62Ohd15yIkfCbPV7FkDN1YJJ/TC9JcGZGaJlonm/GbtTjjcWXOQCi?=
 =?us-ascii?Q?r4oJSc03qS4RLZaXIZx3LBXCCfkf74HmSMG9BahaDllX7JY7N2G6a8rJGSc5?=
 =?us-ascii?Q?tNpTLcvNJnJVErPdJSDBqzQuhh6lEb4Fz2hiim8yQZWMqzvixjkp/2v1JjXP?=
 =?us-ascii?Q?cJLYg2ajbad6zukRIoNUlPjkLZFTvkTz2TRklXe/DEz8MzEV6VY1jfYdOf3l?=
 =?us-ascii?Q?SHlop46gAlzOz/26S1AiMUYuHYnzY/o1L5lwmgjGV3VZfembsDbstNJWuHcr?=
 =?us-ascii?Q?hSjuDBdk/nj1QyGDZqy5YBh3RkKXoENH07Bcc1dQxU1XWdQn1GICQBCgNZ5q?=
 =?us-ascii?Q?+tSGoZ8c3iPmLKAIuHrXP93nEIE+MAh9JeoRiuFxWBVgSo5ZO8hDWXPMrUzu?=
 =?us-ascii?Q?2/8Rf1RMXEsSN/LOfMrJsmycdxR6wD9BIP9P8GxjN56mO5gy2oNDJFPDOiwf?=
 =?us-ascii?Q?iUgNTJ7MCVWP3iaCUI/yRbOPtcxVnO3krH3NtjkXkUmgOovZDMQfLrRi3/5D?=
 =?us-ascii?Q?LD19kVzqE856nVvM7HQbVyrt581lKXLPAzKgkk81gPAytkqCRw6xutJfdExu?=
 =?us-ascii?Q?SB31wTIrNdYFUIyn40Dmj+wNS72ffes6z0RXxQGQCmcsrD+9TtPa+Hxsezqe?=
 =?us-ascii?Q?0zdA74Sh7RxgbinE7DTsZvMrHonY1a7CdEBEEvm5wdlLFHLsMJXF2wF1Wdqk?=
 =?us-ascii?Q?swv4UJYUqWYRHFvZxuW6k0plAFh0/Rmpr2vnqtiUsdhYqvdbFre2VTe09G/0?=
 =?us-ascii?Q?Yl3a5O9+11Aj463NgJZpY0xaMHTOUAh1q7ychKujFQ2qG19Znr1NS+SCp58J?=
 =?us-ascii?Q?kUkzvqrQ1lyDqQILLfTMYw61h0TuW+aG5wiA9sSkv3zV0FL637HfkHw6G7eP?=
 =?us-ascii?Q?YEfG5bEvfmX+x9bhHx8llmwN6TEcmfB7qlrOPiLS92rQKZ3LZ2cWqUnsoIli?=
 =?us-ascii?Q?0ZZjLuu9BG5t9mBAIRfEJXiW5i2zvWdl4p+eFbevCj/0LfDTh/wauRxDcfk3?=
 =?us-ascii?Q?oK6nC6SbgHsorlKX8SkHPOToQWSf7orRKqrY8kgsFwzIBaOo+rCqV3Fdd2t3?=
 =?us-ascii?Q?UdV75phgMr3WGMCF2N6f9R00ZxfBXheII6jhCD89x6d9SsCxig1OETGJ6I8T?=
 =?us-ascii?Q?aseeryobVu2RTGrbpezqhlCq+TrZ59LNQTd7OEqkWpHOD7YYJciftwT2OlOq?=
 =?us-ascii?Q?p75FtPVKScpRZcj0q2fWWjFsPdUh+dhA75I/AYAswbR6jyhnekMpfU1pWl50?=
 =?us-ascii?Q?f/N1NROjJ09J68SvFTBDwubQxdVnQ+FvoKaYBJJv4ZduaviC234mq3t1QN2p?=
 =?us-ascii?Q?XIH0ANdGuGUcNl0HLgeiVTpcTMBm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017)(43062008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 01:45:34.7600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3b614e-822c-432f-5389-08dc6fc9b821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833
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

This reverts commit 9606c08e178f953d22e50b05c64b4b1a48051f3e.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 14 ++++++++++++++
 drivers/gpu/drm/amd/include/mes_v12_api_def.h |  3 ++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 76db85157bf9..4f123d88aa3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -525,7 +525,14 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
+
+	/*
+	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
+	 * handling support, other queue will not use the oversubscribe timer.
+	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
+	 */
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
+	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
 
 	mes_set_hw_res_pkt.enable_mes_event_int_logging = 0;
 	mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
@@ -972,6 +979,13 @@ static int mes_v12_0_mqd_init(struct amdgpu_ring *ring)
 	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
 	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
 
+	/*
+	 * Set CP_HQD_GFX_CONTROL.DB_UPDATED_MSG_EN[15] to enable unmapped
+	 * doorbell handling. This is a reserved CP internal register can
+	 * not be accesss by others
+	 */
+	mqd->reserved_184 = BIT(15);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index e3211daa9c2e..ffd67c6ed9b3 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -239,7 +239,8 @@ union MESAPI_SET_HW_RESOURCES {
 				uint32_t send_write_data : 1;
 				uint32_t os_tdr_timeout_override : 1;
 				uint32_t use_rs64mem_for_proc_gang_ctx : 1;
-				uint32_t reserved : 17;
+				uint32_t unmapped_doorbell_handling: 2;
+				uint32_t reserved : 15;
 			};
 			uint32_t uint32_all;
 		};
-- 
2.34.1

