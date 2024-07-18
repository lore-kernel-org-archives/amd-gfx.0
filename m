Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54453C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E758010E8B7;
	Thu, 18 Jul 2024 14:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="15MMsC8I";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF6E10E8B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:07:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2vXnewU0xprZ4wUZlfTP2cIFEtN4vXUxgOTWqU+h85yFRc0vhdpJzTJQ7kCoFmWJ8yxASB3o01BLYNO5C+wDgLvqhxR/V9NC6yyO3D9groZWP23rp2HAbe03yX27eY+1PstgNGDzu7H8uzrDzPYmSH0dAfjSp4fszads+qiO9Adkr5drr9IXjB+6hRc70oXG02IcM+pfILZ3TQ40wRJyeyTL643M2Uay8uQUX9Vhm131vLGk8gKD9QHq2AZddybaeVrvoN+Xixq1RFE1nlQ/XRELvUo+WScJSgnghYhYEQPkwC4K3yz3duTlJY0BUdjnvaKrT6PERzn2pL1BTOKug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGUV0KYm8L9GMCGo+Qs6e9VrToHESL9bneYCr2YGerw=;
 b=cMBDQ/nlzhv7pVfDAuJbwKxF8rqt6cvQaPWGgim4YH/DttYshaCIRirzvmkKQX1s17zXCJ5RhiMlZCkTkFHZaXiJA1B5ZbJ8oRwXuoAkootcj4XJcG9P9tbzwyOLXhpM6IO0D78B0iT2juj7QNRTcpSmbwLu5WNzBu/ZegA2dYnPlNwCK7w7+lzwViaeQQNk3FUo3CysmXQMoXykVMgNoiyqnph8U077VFpEwa3+KW8S76RtnZm83eXcWMIAg6RylCXPlcO0Y6XHHioOt5Yf+pPsqm0rLBBVE7ODRfXVk2vl9tJAqFx23BO5JT1gnoLPxjc60wrJOwJGE38PLcQdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGUV0KYm8L9GMCGo+Qs6e9VrToHESL9bneYCr2YGerw=;
 b=15MMsC8IuYApAO6XltaoNO9B00XDAK/b+F430dIn8Uj8othoTyd1zrb1tTtUiPdW+pz+UDSv1hXbJK9hOLmYsAtX/N3fywVpa2lULV8g/rDK6mciD97xScpLwMqfvbfnCTYo2pytqYfxMoFFf7sst1eokkETEL0wwtsfT94ALYo=
Received: from BL0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:207:3c::49)
 by DM4PR12MB6496.namprd12.prod.outlook.com (2603:10b6:8:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 14:07:53 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::1f) by BL0PR02CA0036.outlook.office365.com
 (2603:10b6:207:3c::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 18 Jul 2024 14:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:07:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/34] drm/amdgpu/mes11: add API for legacy queue reset
Date: Thu, 18 Jul 2024 10:07:01 -0400
Message-ID: <20240718140733.1731004-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: abb5c104-a8f4-4a63-c144-08dca73303f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WkSYUhwu8kY0Pd62VgPm6PuvKvQ7v8hMt1LcSF8Msxf6kE60lnt1l1gLR8hm?=
 =?us-ascii?Q?nPW/XKDeKhpk7wl1SWsvhliY8REF39FcBdQcQ22VvCE9BmXSquI1zs7RAyJF?=
 =?us-ascii?Q?2VZPKzKa/SB8wHGDEZ6Vp3qWxPAfBr/Q2Mo+V7xZMN1mW7G4fmd0Q0mjXYDv?=
 =?us-ascii?Q?ROcXqH/PmhUC6FsZcOkXDD6ZumM1WoiFylyQ1cn/xWLBASP8fsc1gL5LLng2?=
 =?us-ascii?Q?Og1vflFAL1ozsKZNBW38YVw251epLpaLqpPI9tMTEQzlgOFLG0KdabvEuPxJ?=
 =?us-ascii?Q?sGKdjHiX25ahjmf0lEeFYbU5J4jn5QQVSO9+wwIzn7skguFOvGngSMO4O6K5?=
 =?us-ascii?Q?+9DzuyXEuH94nQWImY1cWZqVX8i9VkrTYa5j+vdjQVaWQTXsA7D2hChuCjuI?=
 =?us-ascii?Q?9OGtP9m+EQTvz9siImjCcOyhHaNSpU1YqysMLwdBa2WkQLZCR68MAj4STFIk?=
 =?us-ascii?Q?QFpHVoMxhxEpNew9IEHsYraU2kjSU6XekCk+zI2pSWu6d2t4zmfdAOJNh1aH?=
 =?us-ascii?Q?JyyNBJvMBQyOTMmHkfK8cVX9wN2CJzWk+6rm2cmuPeyi06W8ZHaCt+rj96zM?=
 =?us-ascii?Q?37drowXDxnDHZ1STxgE0+ZH9FIpOEMaJanLRdhp+93V5FVfjS/I6LyomlQiS?=
 =?us-ascii?Q?dIzhB9jeg9ZplqPlyIwgtTwMXxGdMelEr9pl+rbDiOAWllN+flpcNxsWc8yb?=
 =?us-ascii?Q?JIHNtw/DzzJX8OUYpfx5j7pWH0te6iyrQ7CI9EWvxPp+4YC+hA9Ufxjefw9v?=
 =?us-ascii?Q?qXRiUay0GqoywDHEuq9Y2hrf8pa51IHqCXn9MBCQ6STmCbACjT+xtVtG3uFA?=
 =?us-ascii?Q?5+RpUKMZbOiJ9xWD40sOn0NxwGaguJmEFaS0D+TBIUKY/MeQxRZ+Y28k2ha2?=
 =?us-ascii?Q?sAi72v5AWMbzbZWPcw2A617As2FhXBl1eCb2IULeo2Pno/LGu3uplGWwlC8w?=
 =?us-ascii?Q?GyP82jWXDb/xXggFm7X3h4jMr1DhHgPiNGzjlpWXx9lWu8x6YrBzzr8K4x+k?=
 =?us-ascii?Q?38ZcfNgIzw2op45qb7zCH/tRzKwkTuOtwooK8409iyGhW6RGitVHVzwrmv1f?=
 =?us-ascii?Q?kMuFYjoyE7KmtAgccgfC4fR172C7q36IfexWswRDSARVjoDDJWjAGy4PCB3+?=
 =?us-ascii?Q?4X9ajhWK/MWpLBIXQq8iwmgk+pGqzUVBvDxsff5xTFML2/MaXOW7EWCzpa/m?=
 =?us-ascii?Q?XDpw+CeXxbPZ8/LvTM3D8b3PAYrsrxYKTAoMMp6cM75GcL/NPV6DdRl2lc8c?=
 =?us-ascii?Q?sxmoZaUdtM3V6D7u6UOj9lm9fJ+6zfxckWZdTFwemkysbXLL/2YeE5beRnd/?=
 =?us-ascii?Q?5jKehxQRoOAGc1sSPmzEWOz88xxo4KxfXYy0VSUyyW95Uu12UT2ybjfuspzb?=
 =?us-ascii?Q?/OIRT4W7H+GwEqvo7BDFXNo1YRLumJpakfJTeoZ7eJMxYKYd7aHlmDFjj6mW?=
 =?us-ascii?Q?L681+YkROANSKDPVhRO6106L24i8kBi+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:07:53.0529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb5c104-a8f4-4a63-c144-08dca73303f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6496
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

Add API for resetting kernel queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 27d54ec82208..f611183e1ebf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -587,6 +587,38 @@ static int mes_v11_0_set_hw_resources_1(struct amdgpu_mes *mes)
 			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
 }
 
+static int mes_v11_0_reset_legacy_queue(struct amdgpu_mes *mes,
+					struct mes_reset_legacy_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+
+	if (mes_reset_queue_pkt.queue_type == MES_QUEUE_TYPE_GFX) {
+		mes_reset_queue_pkt.reset_legacy_gfx = 1;
+		mes_reset_queue_pkt.pipe_id_lp = input->pipe_id;
+		mes_reset_queue_pkt.queue_id_lp = input->queue_id;
+		mes_reset_queue_pkt.mqd_mc_addr_lp = input->mqd_addr;
+		mes_reset_queue_pkt.doorbell_offset_lp = input->doorbell_offset;
+		mes_reset_queue_pkt.wptr_addr_lp = input->wptr_addr;
+		mes_reset_queue_pkt.vmid_id_lp = input->vmid;
+	} else {
+		mes_reset_queue_pkt.reset_queue_only = 1;
+		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
+	}
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
 static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.add_hw_queue = mes_v11_0_add_hw_queue,
 	.remove_hw_queue = mes_v11_0_remove_hw_queue,
@@ -595,6 +627,7 @@ static const struct amdgpu_mes_funcs mes_v11_0_funcs = {
 	.suspend_gang = mes_v11_0_suspend_gang,
 	.resume_gang = mes_v11_0_resume_gang,
 	.misc_op = mes_v11_0_misc_op,
+	.reset_legacy_queue = mes_v11_0_reset_legacy_queue,
 };
 
 static int mes_v11_0_allocate_ucode_buffer(struct amdgpu_device *adev,
-- 
2.45.2

