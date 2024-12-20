Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F6CE7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A7F10F072;
	Fri, 20 Dec 2024 21:51:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sDaDv8MP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A66A10F072
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIHppnr6d276QgKc69ivROBAp0VeSfa2RGB9NyVc0QiTN2yoVwr32HUYyTFOqYkIchFHaqyFYm2gjkZVg13oz/GJdKRNJNrNOw4TMv7h2RO73IEOk88CNYzLOaxzhjDJXZ03/xRihQlYktWE2YjyFmqqV3A9aomfrYBCCFSh+yJdBxvre2dkCYXNOkJUYgoB0CUMCOMTOjlxRXeeSE0SQALTQFNEkotMyHnDgEpl3XPu+T+/taYRv9rCr8wCEXw/pjY9nSuTjv5WyEk+XD75hrL8aG+t4vMFlS77g/kuXhq+tze2joELlu3ZJGc3qtxlncKivF3itP8WProKGjcx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPPTEsQxi/bC15kAvg8A6p1leJdCBtHZ0MmBywCg1qo=;
 b=Y9NYFOU6Sh1F+0A3fvzLAtfk/xFKK88oHzEX3sUTc6ZW+V4gKwbquCMv8KSnur5LA/vhqQRneBTlBg2TdhwQF0Rv0mkXMwOaA3IUG4krD1cjLWj32BBS8GJ8FD0teQTLPqU8sHk3iKwRZaot78sVeoOprA+dG9eF7iFXiRcDLc7OfVBE751jcTkEQ9IozTQlLBO/Y6IHrYVCMJ12elD25V8MGhTRo5Gc7m8Xo6fT8ULTkqdd4brvx6LJPyp8uHA1wUI/c2JUQpFnCAHvGLvYmcEZm8xfLQqC5EhgHbZ7clNF2wjKLa65oF7Xo23JGKoGAbcgxVOwrW99nfRo4ZVENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPPTEsQxi/bC15kAvg8A6p1leJdCBtHZ0MmBywCg1qo=;
 b=sDaDv8MPiyWPpdvdW/RXAmkJ2WnVzdBKjXsOSGFkMBTzdiu9LHg4f8gdKLFIaP1HZSmNIvKfZS680LAp4gKC7xKlyq5oHI2B/7w9qoIQVkg+dSkZ4WCV4wLws9tytGWDToi17V6TGj4UMuyEj/cQKurJ/UMZYfRrmMY+jMuY5rE=
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 21:51:16 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::58) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Fri,
 20 Dec 2024 21:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:15 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:15 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:14 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Dennis.Chan
 <Dennis.Chan@amd.com>, Robin Chen <robin.chen@amd.com>
Subject: [PATCH 13/28] drm/amd/display: Implement Replay Low Hz Visual Confirm
Date: Fri, 20 Dec 2024 16:48:40 -0500
Message-ID: <20241220214855.2608618-14-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: cb211d75-7a33-4e0c-3284-08dd21406e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K0FjdaNCxm2UoRyox9yY547OyvaoCS1gYOOQRTaeBENOD8DGndTnt2Iyv2ME?=
 =?us-ascii?Q?zQNA9xd7sbrnVnizhgu9oluhlrySFWxVejiBJ3qB/IOgBsyxEgePfeKgfSmF?=
 =?us-ascii?Q?i1vM5WPbS0MgPCzqdOeHC/J6hiUBCzTeX1V6i6Fk+Q+OR3Yvgrh0LVUsbSGk?=
 =?us-ascii?Q?jXfEXSl6q1ipAg3Bodevx5WcQUQFoXQOy4+/HLehAaJnmSI8TqFKdGmYU5mq?=
 =?us-ascii?Q?N/imw9DWkgh6D2bQDwIRiO9BhXv2UbZFic64i6G9jX5fbgIwxKuEhrBkEFEF?=
 =?us-ascii?Q?wzmCbVwwFt6TD61l7QOJ5maj+3jEyFqVpU5hCru+CF91syXe0Pa9xTINr0Ei?=
 =?us-ascii?Q?ZBxwksCAFe6/nuqn5Qd/s3zltLWl3jecryKT92swDfM6I9uzIPTyEeOUjNGh?=
 =?us-ascii?Q?iLKV5PUgiN32SOBjvM2TyhZsZyh7DHyrq8scVyT1yC3t7mm1foJ+t0lj73TO?=
 =?us-ascii?Q?AA7VuHWBuFHjsPdGkiHXz+lyJDSueZAH/tzJYMaGESg2Arff3Z0exC67of3R?=
 =?us-ascii?Q?SiilrXW2Re8RL4Yy0TKBCRHEIGaEGuUY/Nag5J0fv0wbhIFDJ8oHz+WCTPXO?=
 =?us-ascii?Q?PYfrckrjhN3JZ+/jtFaosZFE/8wDSs3e7OfUX0/4tm1Xo6W0f9v0SyVEYtl2?=
 =?us-ascii?Q?ohAzhAJtS97EFFrwI9MpMIkdDCQ6Qw4xTILvbtEyiQr+CJvE6FgF5Af0kWyO?=
 =?us-ascii?Q?l5e8pjepyhjaQwOGoojGRORRLHbL1AM6Ho7Vi8/cEZWw07Nk8Z0s+eqPYwBN?=
 =?us-ascii?Q?HqXba8IPGY8a8XMO5Vhgb+R0wOdQarS65hX5k1QaFXI4skoKp+Z41GeG2zpY?=
 =?us-ascii?Q?IJ/fJt2FLip3Vj1C67LI2nEw6AVyn+FAx65fDQViqCBJtTglT8uijCYorN1G?=
 =?us-ascii?Q?9w1tCQU0WgFU/3CrfCK2JVkMlPwDeQRfobiitiiuXLkmfCAxWiXn2yQP7ldT?=
 =?us-ascii?Q?dGji5uvotjlZJz0h0woOy2yIYijYwK4K2UKepBGHlup5bHZsNUYijTyq+GUQ?=
 =?us-ascii?Q?2xljsS3iIMRUESj5Ni3rX+KCWOqG0uM3wve2s3hGVipECEuqIrrgwHRbQ97X?=
 =?us-ascii?Q?Yhm3PQMFG5akaI+j49+huF2femcGjakuI26ul1D1BJkzDZq8sUXEUwwGgjbS?=
 =?us-ascii?Q?vls7Od2/2UzrDQQChJu+lvHj7oIfSol1T+pK14ZJGy38YEgxN5UecpeiIeT7?=
 =?us-ascii?Q?DArZzEapze4vn8Yl3v0x/6/6mYXjVEAVyXkqS5GayhN/el7I2HBlw3ZpNncI?=
 =?us-ascii?Q?EG+l3/geXrX09TjK3+bpyq4nmfzgCg/gjaYNAexTJhhsKZBMIH+s/ajzSX8e?=
 =?us-ascii?Q?d1tyBxCaSXHmaO0Nl1CkGGg9IKCtoRh8W3JHFJGLVfKTDxZVnJ+hgaCDPukw?=
 =?us-ascii?Q?ECsPaxGLlu8tWGY0xf3KzFjVV7iD7HwCnUQYlDT+nHFfmdXOIEEUN7mZUpyg?=
 =?us-ascii?Q?T5UEX3w84xNh6i+bw+QkrmgieMV5MzuhAS2tEfq3tWAJaXVG9yai0g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:16.2217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb211d75-7a33-4e0c-3284-08dd21406e05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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

From: "Dennis.Chan" <Dennis.Chan@amd.com>

[why]
Add new Visual confirm color for Replay Low Hz.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Dennis.Chan <Dennis.Chan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 11 ++--
 .../dc/link/protocols/link_dp_irq_handler.c   |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 64 ++++++++++++++++++-
 3 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 81ec7c79f4c1..bdda36fe8235 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1067,10 +1067,13 @@ enum replay_FW_Message_type {
 
 union replay_error_status {
 	struct {
-		unsigned char STATE_TRANSITION_ERROR    :1;
-		unsigned char LINK_CRC_ERROR            :1;
-		unsigned char DESYNC_ERROR              :1;
-		unsigned char RESERVED                  :5;
+		unsigned int STATE_TRANSITION_ERROR     :1;
+		unsigned int LINK_CRC_ERROR             :1;
+		unsigned int DESYNC_ERROR               :1;
+		unsigned int RESERVED_3                 :1;
+		unsigned int LOW_RR_INCORRECT_VTOTAL    :1;
+		unsigned int NO_DOUBLED_RR              :1;
+		unsigned int RESERVED_6_7               :2;
 	} bits;
 	unsigned char raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 48abeaa88678..017fbc476d51 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -226,6 +226,8 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 		replay_configuration.bits.STATE_TRANSITION_ERROR_STATUS) {
 		bool allow_active;
 
+		link->replay_settings.config.replay_error_status.raw |= replay_error_status.raw;
+
 		if (link->replay_settings.config.force_disable_desync_error_check)
 			return;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 59990929e44e..904309943ec0 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -431,7 +431,67 @@ union replay_debug_flags {
 		 */
 		uint32_t enable_ips_residency_profiling : 1;
 
-		uint32_t reserved : 20;
+		/**
+		 * 0x1000 (bit 12)
+		 * @enable_coasting_vtotal_check: Enable Coasting_vtotal_check
+		 */
+		uint32_t enable_coasting_vtotal_check : 1;
+
+		uint32_t reserved : 19;
+	} bitfields;
+
+	uint32_t u32All;
+};
+
+/**
+ * Flags record error state.
+ */
+union replay_error_state_flags {
+	struct {
+		/**
+		 * 0x1 (bit 0) - Desync Error flag.
+		 */
+		uint32_t desync_error : 1;
+
+		/**
+		 * 0x2 (bit 1) - State Transition Error flag.
+		 */
+		uint32_t state_transition_error : 1;
+
+		/**
+		 * 0x4 (bit 2) - Crc Error flag
+		 */
+		uint32_t crc_error : 1;
+
+		/**
+		 * 0x8 (bit 3) - Reserved
+		 */
+		uint32_t reserved_3 : 1;
+
+		/**
+		 * 0x10 (bit 4) - Incorrect Coasting vtotal checking --> use debug flag to control DPCD write.
+		 * Added new debug flag to control DPCD.
+		 */
+		uint32_t incorrect_vtotal_in_static_screen : 1;
+
+		/**
+		 * 0x20 (bit 5) - No doubled Refresh Rate.
+		 */
+		uint32_t no_double_rr : 1;
+
+		/**
+		 * Reserved bit 6-7
+		 */
+		uint32_t reserved_6_7 : 2;
+		/**
+		 * 0x100 (bit 8) - DQE Only.
+		 */
+		uint32_t pass_low_hz : 1;
+
+		/**
+		 * Reserved bit 9-31
+		 */
+		uint32_t reserved_9_31 : 23;
 	} bitfields;
 
 	uint32_t u32All;
@@ -3644,6 +3704,8 @@ enum dmub_cmd_replay_general_subtype {
 	 */
 	REPLAY_GENERAL_CMD_DISABLED_ADAPTIVE_SYNC_SDP,
 	REPLAY_GENERAL_CMD_DISABLED_DESYNC_ERROR_DETECTION,
+	REPLAY_GENERAL_CMD_UPDATE_ERROR_STATUS,
+	REPLAY_GENERAL_CMD_SET_LOW_RR_ACTIVATE,
 };
 
 /**
-- 
2.34.1

