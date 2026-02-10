Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B283AEA8118
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 13:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF0D10E582;
	Tue, 10 Feb 2026 13:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wqlwxPJj";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013042.outbound.protection.outlook.com
 [40.107.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3585110E582
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 13:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9ivTBqStMUptqjn27Kd57v5knj5ru4CPDNvRDPRdmAzdOxkLQPEXE/ZFUrfiPGG6YS1+23XbY7oSAA/eMD7r/yvqJ4s+OnAMP9yZ9ZjQEZTWTzCUYvC0ZVKF7fKK5Mx5KDWACDr37D4rRIQHKh81c3r3K7iyclP/qA1D8lpWX/NaLEFwZcxlY4GF+S6cylz5HLPD8zPtIQZSkrzfS4Gg7hDxCUG/EMunRc1LU9M292i4hEnyZ76SjW5OugUTHq5+q1sS41g7EHlfdkI40yQj9nksnksnbHfgOh9DOw9xQB/siqeqoE6MQjOO1x5cxuCPH6epEHb4Fczatf0Y00WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHolm4wBzV/gwirPI6/eFvAgLGXXA/c0tJJ28VqLwEA=;
 b=Q3uJ/AugDIr/WkA29LZCBT4TK2JCUA1wKHxNk1cHOShRPS2v3xGXwfKKTzdec/wGVSlSumAEQEeqxE1i6lK5HQm3V7XLXjJxXy6Et7H2TyvUoguabAWKitNBg5FFXlmjfobItDv6TycBW/DY8S6S70gtMO5XcvKVaNnoR9kuq7KMPF1HQOqoM1gWXEx0ak30wwg6vXtuO0SAqV0eIUQUnNpLmpCQRaeOce0Q1DW4G0T9CBwAyGcZysxO2N1Oax79Pq7Z9h3NZ7/KcVme4lRcrVk5JnvSHjaOHEZyKpEuKQaoMa800A2y0+ZGhqDfML4SlKqDLT5N9p66uu9td6U6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHolm4wBzV/gwirPI6/eFvAgLGXXA/c0tJJ28VqLwEA=;
 b=wqlwxPJjoZeS4tzHsdrlqxczKbZxOWdEY8kkLC0EedAsPkfqIUuhdBslCAfnUxDbqANOAOpxGJRH4+zRyJ0GgnA9ni2PF46e5+bhz4Rez8kke0jsIgrRoPyOXvzQc5S4XwTmn4nmRzm6PgxLSK8SI2i+fxNyTgQv8dN447ki+1w=
Received: from CH5PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610:1f0::26)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 13:56:12 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::de) by CH5PR05CA0013.outlook.office365.com
 (2603:10b6:610:1f0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend
 Transport; Tue, 10 Feb 2026 13:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 13:56:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 07:56:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Feb
 2026 05:56:09 -0800
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Feb 2026 07:56:01 -0600
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Wenjing
 Liu" <wenjing.liu@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 13/18] drm/amd/display: Refactor and fix link_dpms I2C
Date: Tue, 10 Feb 2026 21:50:06 +0800
Message-ID: <20260210135353.848421-14-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135353.848421-1-ray.wu@amd.com>
References: <20260210135353.848421-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 69beb7e9-8c2e-40bc-1099-08de68ac2629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0xpeHuxnxuiiHaqTBf8jtLxeLdjR6N+USaVEYbBaMQ/8gNuAZvPnuNuqwN0K?=
 =?us-ascii?Q?GyK9vj71GwBFJgujUvWnNyAnqp7U57I7sS/VLBmrJr3XU05yQ4YQyFA2w5YT?=
 =?us-ascii?Q?HkEX/ZvTQfGx5J//CkhncB7l6rsvJ8LkVtKe6kEBdtPAV2qzhNXJ/2Vl5fWY?=
 =?us-ascii?Q?3RGZMIyGBbiWfElDs4UEiXNKHY0kREdwx4iq56p7+uagDbpArEB+rI/O8+TW?=
 =?us-ascii?Q?CzeJGwdq3tUtmeR7oJnaxkauB0oR6DlMKL/Ue+S3gvrIuJ333kzWuokw49rT?=
 =?us-ascii?Q?6kvbJ5LLRgbBY7mIQhP71zlramI0Rx7ynNxoX/OdhLBCWJ12eqmBZo0eh3B8?=
 =?us-ascii?Q?lFicEVDoEplnikIlGwracC0AinfVkPAMYwTJSc7yjyQ1t0dURwtXPtDNSjZg?=
 =?us-ascii?Q?Ujz+CviVyIjYeXgsKnHyVqqv2NAehqPWRQa+S2nW/YD0Ztw28FthWXMOiJk1?=
 =?us-ascii?Q?OZrXgvzbXooSN3EnHO0sXNNDnHaZys45tDYXpBW8cpC8ygn/wpYp3VB3EmML?=
 =?us-ascii?Q?11HAEPyLmN3PZTRCw9WyuzY1SSS8kvTJ2PwdL2sj0th7DRaE4RlLSFsbRdBU?=
 =?us-ascii?Q?NILyZyh+Jjw6EcCox1n5gdcN+omSw0/H5L69qXy5I8Yde9e/TwSSfyF9RYkL?=
 =?us-ascii?Q?53c1RCef2TLs4lJ7B5jIDT4SMappMsNyxaz+oZkjKCpjoIcxB+5HQK7/rBZg?=
 =?us-ascii?Q?u+RvNWDLZxX0pKd7FHRDK1SVrmkT8mi5adOop5+IrUbIghzq5YtKiwuF39QO?=
 =?us-ascii?Q?i6BJWsdD54mSGKYqchYgcMBliWGYxQzeiLEvsI+mjLKpG6PZiCkQUF73RU4G?=
 =?us-ascii?Q?TL4OX9RGKuny08n3LK9PjnYCeb3JLkXlhVhYCUTk9E8Bx7a7ROEZA0HLr14H?=
 =?us-ascii?Q?7feOVyiTMRVrYe3nukFr4Awcqz6WByLo5QW0YiWCs2CExpohrRzxswEcVk2B?=
 =?us-ascii?Q?kpbxdqgzQQaAWIya4uH0cVQUfQvdgv/nTG6hAtmh+nieVV7/2mPHLvUKqbrl?=
 =?us-ascii?Q?2iQupH1AOftqhSsgdrzR/vQsMeB8knniYTl+2zFvg/kwJcIIViBwytPEFrO5?=
 =?us-ascii?Q?ZfhZTy1Pz2Lh0OqQ3SD/gMPifQ6dsuAMP9e3ouPOLNoZ5vNUCSoQBHKI1/xg?=
 =?us-ascii?Q?beeuvUlnixhtraFsdyPCLl+rYd6nQfjTtuE29StnH65bcIESkTWzCVbblQLK?=
 =?us-ascii?Q?limX7g+OkxVKbCM1QJ68J0aRJZQJnumZa2JSjC9bSyfwERgSglL07O+f30tS?=
 =?us-ascii?Q?iM4h33YdvlCzEQxc79OWlXSqBDDlvWyhq9uM/S3oiTpMfK2qI/FGaD+oJZw6?=
 =?us-ascii?Q?bkLRD5mbXuBb6dmLblGxDKgHg1bzJusS5IWWsLfRwLg+z068qYiACLl5znt6?=
 =?us-ascii?Q?/p1BCw0kD1XkhgWcWcAZE0P0wyyigAbbwGrKA36eb6BdEdvpLFfD3P1uB3vK?=
 =?us-ascii?Q?5J11bMB9ZGZ/prlG6QlupECw19vZPdeTGbY8Sgbj8JRuXUVPakVyXvmWUKVM?=
 =?us-ascii?Q?aFIEqtfnbxU83BdfE5LqIjiTi/GAU5t7ax20OF3VUl7jQk2gNA8Hvi2Cp418?=
 =?us-ascii?Q?Fw3B4m/u27G1BRWZKQTYxjB1CVUFNfUriYkLYStXF9UCMoBk1s5jIL0f+MZ9?=
 =?us-ascii?Q?oVAvEPNWknxhC8UTks5R5dUYs72gF1JDPkWsQ0aoO7Bsteh4qy37WGlPZY8J?=
 =?us-ascii?Q?vtJaPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4VJBtT1cRs93oyuOsTO9QfpuxXBJ/XtxwBbAIV5BveCEopRp9aDGF8gXW8PFQQ6LuvOhboeR/x0h2am3vHSUu+exhONe4GITizv0Cn4o/eoUrg2rJtOFK6Og7s/c5C1N24TWVLyAihap8dLik1nRTyO0nFWKGL8ObA7C5iII4+RO/45mjQ4RTqWxJZ8sJHnizs1cFDtP6o2bec3LcgMIzUOjiEceup9zAslqvgpMOOZXcMY8sUF0sAuSjMy+8JiXK+XowxotdJRjWUNp3oFfO0Kwo2WPvbBULfmawu8bnVG3mJdrXJVPlBjZElD8++aVIvgGRQ9Jo50QxWzLBOZ7J3TLEuuY6W87K9OyZFUvyDwRtKuGvAOSbvsmtlhEp/kDERB85twLSTmqh+qS1WLV2AiVTJqo9gOzoTjoY9iCd0S45UI5f5fKWBG/VVbRF5Xk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 13:56:11.6607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69beb7e9-8c2e-40bc-1099-08de68ac2629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
link_dpms.c issues I2C writes during HDMI link enablement. Current
implementation contains a lot of duplicated code with copy-paste
errors.

[How]
* Refactor common logic into helper functions.
* Invert logic with early returns to decrease indentation.
* Sequence writes by looping over data arrays.
* Fix write_i2c_retimer_setting is_over_340mhz checking reg_settings
instead of reg_settings_6g in the i2c_reg_index <= 0x20 check.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 475 ++++++------------
 1 file changed, 165 insertions(+), 310 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 91742bde4dc2..befbe005af68 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -320,344 +320,203 @@ static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
 	return result;
 }
 
-static bool write_i2c(struct pipe_ctx *pipe_ctx,
-		uint8_t address, uint8_t *buffer, uint32_t length)
+static bool write_i2c(
+		const struct dc_link *link,
+		uint8_t address,
+		uint8_t *buffer,
+		uint32_t length
+)
 {
-	struct i2c_command cmd = {0};
-	struct i2c_payload payload = {0};
+	struct i2c_payload payload = {
+		.write = true,
+		.address = address,
+		.length = length,
+		.data = buffer,
+	};
+	struct i2c_command cmd = {
+		.payloads = &payload,
+		.number_of_payloads = 1,
+		.engine = I2C_COMMAND_ENGINE_DEFAULT,
+		.speed = link->ctx->dc->caps.i2c_speed_in_khz,
+	};
+
+	return dm_helpers_submit_i2c(link->ctx, link, &cmd);
+}
 
-	memset(&payload, 0, sizeof(payload));
-	memset(&cmd, 0, sizeof(cmd));
+static bool write_i2c_retimer_offset_value(
+		const struct dc_link *link,
+		uint8_t address,
+		uint8_t offset,
+		uint8_t value
+)
+{
+	DC_LOGGER_INIT(link->ctx->logger);
+	uint8_t buffer[] = { offset, value };
+	const bool success = write_i2c(link, address, buffer, sizeof(buffer));
+
+	RETIMER_REDRIVER_INFO(
+			"Retimer write, address: 0x%x, offset: 0x%x, value: 0x%x, success: %d\n",
+			address, offset, value, success
+	);
+	return success;
+}
 
-	cmd.number_of_payloads = 1;
-	cmd.engine = I2C_COMMAND_ENGINE_DEFAULT;
-	cmd.speed = pipe_ctx->stream->ctx->dc->caps.i2c_speed_in_khz;
+static bool write_i2c_retimer_vga(
+		const struct dc_link *link,
+		uint8_t address
+)
+{
+	DC_LOGGER_INIT(link->ctx->logger);
+	const uint8_t vga_data[][2] = {
+		{ 0xFF, 0x01 },
+		{ 0x00, 0x23 },
+		{ 0xFF, 0x00 },
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(vga_data); i++) {
+		if (!write_i2c_retimer_offset_value(link, address, vga_data[i][0], vga_data[i][1])) {
+			DC_LOG_ERROR("Set retimer failed, vga index: %zu\n", i);
+			return false;
+		}
+	}
+	return true;
+}
 
-	payload.address = address;
-	payload.data = buffer;
-	payload.length = length;
-	payload.write = true;
-	cmd.payloads = &payload;
+static bool write_i2c_retimer_byte(
+		const struct dc_link *link,
+		uint8_t address,
+		uint8_t index,
+		uint8_t value
+)
+{
+	DC_LOGGER_INIT(link->ctx->logger);
+	const uint8_t apply_rx_tx_change = 0x4;
 
-	if (dm_helpers_submit_i2c(pipe_ctx->stream->ctx,
-			pipe_ctx->stream->link, &cmd))
+	if (index > 0x20)
 		return true;
 
-	return false;
+	if (!write_i2c_retimer_offset_value(link, address, index, value)) {
+		DC_LOG_ERROR("Set retimer failed, 3g index: 0x%x, value: 0x%x\n", index, value);
+		return false;
+	}
+
+	// Based on DP159 specs, APPLY_RX_TX_CHANGE bit in 0x0A
+	// needs to be set to 1 on every 0x0A-0x0C write.
+	if (0x0A <= index && index <= 0x0C) {
+		uint8_t offset = 0x0A;
+
+		// Query current value from offset 0x0A
+		if (index == 0x0A) {
+			// Just written correct value, so no need to read it back
+		} else {
+			if (!link_query_ddc_data(
+					link->ddc, address, &offset, 1, &value, 1
+			)) {
+				DC_LOG_ERROR("Set retimer failed, link_query_ddc_data\n");
+				return false;
+			}
+		}
+
+		value |= apply_rx_tx_change;
+		if (!write_i2c_retimer_offset_value(link, address, offset, value)) {
+			DC_LOG_ERROR("Set retimer failed, 3g offset: 0x%x, value: 0x%x\n", offset, value);
+			return false;
+		}
+	}
+	return true;
 }
 
-static void write_i2c_retimer_setting(
-		struct pipe_ctx *pipe_ctx,
+static bool write_i2c_retimer_setting(
+		const struct dc_link *link,
 		bool is_vga_mode,
 		bool is_over_340mhz,
 		struct ext_hdmi_settings *settings)
 {
-	uint8_t slave_address = (settings->slv_addr >> 1);
-	uint8_t buffer[2];
-	const uint8_t apply_rx_tx_change = 0x4;
-	uint8_t offset = 0xA;
-	uint8_t value = 0;
-	int i = 0;
-	bool i2c_success = false;
-	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
-
-	memset(&buffer, 0, sizeof(buffer));
-
-	/* Start Ext-Hdmi programming*/
-
-	for (i = 0; i < settings->reg_num; i++) {
-		/* Apply 3G settings */
-		if (settings->reg_settings[i].i2c_reg_index <= 0x20) {
-
-			buffer[0] = settings->reg_settings[i].i2c_reg_index;
-			buffer[1] = settings->reg_settings[i].i2c_reg_val;
-			i2c_success = write_i2c(pipe_ctx, slave_address,
-						buffer, sizeof(buffer));
-			RETIMER_REDRIVER_INFO("retimer write to slave_address = 0x%x,\
-				offset = 0x%x, reg_val= 0x%x, i2c_success = %d\n",
-				slave_address, buffer[0], buffer[1], i2c_success?1:0);
+	DC_LOGGER_INIT(link->ctx->logger);
+	const uint8_t address = settings->slv_addr >> 1;
 
-			if (!i2c_success)
-				goto i2c_write_fail;
+	for (size_t i = 0; i < settings->reg_num; i++) {
+		const uint8_t index = settings->reg_settings[i].i2c_reg_index;
+		uint8_t value = settings->reg_settings[i].i2c_reg_val;
 
-			/* Based on DP159 specs, APPLY_RX_TX_CHANGE bit in 0x0A
-			 * needs to be set to 1 on every 0xA-0xC write.
-			 */
-			if (settings->reg_settings[i].i2c_reg_index == 0xA ||
-				settings->reg_settings[i].i2c_reg_index == 0xB ||
-				settings->reg_settings[i].i2c_reg_index == 0xC) {
-
-				/* Query current value from offset 0xA */
-				if (settings->reg_settings[i].i2c_reg_index == 0xA)
-					value = settings->reg_settings[i].i2c_reg_val;
-				else {
-					i2c_success =
-						link_query_ddc_data(
-						pipe_ctx->stream->link->ddc,
-						slave_address, &offset, 1, &value, 1);
-					if (!i2c_success)
-						goto i2c_write_fail;
-				}
-
-				buffer[0] = offset;
-				/* Set APPLY_RX_TX_CHANGE bit to 1 */
-				buffer[1] = value | apply_rx_tx_change;
-				i2c_success = write_i2c(pipe_ctx, slave_address,
-						buffer, sizeof(buffer));
-				RETIMER_REDRIVER_INFO("retimer write to slave_address = 0x%x,\
-					offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-					slave_address, buffer[0], buffer[1], i2c_success?1:0);
-				if (!i2c_success)
-					goto i2c_write_fail;
-			}
+		if (!write_i2c_retimer_byte(link, address, index, value)) {
+			DC_LOG_ERROR("Set retimer failed, index: %zu\n", i);
+			return false;
 		}
 	}
 
-	/* Apply 3G settings */
 	if (is_over_340mhz) {
-		for (i = 0; i < settings->reg_num_6g; i++) {
-			/* Apply 3G settings */
-			if (settings->reg_settings[i].i2c_reg_index <= 0x20) {
-
-				buffer[0] = settings->reg_settings_6g[i].i2c_reg_index;
-				buffer[1] = settings->reg_settings_6g[i].i2c_reg_val;
-				i2c_success = write_i2c(pipe_ctx, slave_address,
-							buffer, sizeof(buffer));
-				RETIMER_REDRIVER_INFO("above 340Mhz: retimer write to slave_address = 0x%x,\
-					offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-					slave_address, buffer[0], buffer[1], i2c_success?1:0);
-
-				if (!i2c_success)
-					goto i2c_write_fail;
-
-				/* Based on DP159 specs, APPLY_RX_TX_CHANGE bit in 0x0A
-				 * needs to be set to 1 on every 0xA-0xC write.
-				 */
-				if (settings->reg_settings_6g[i].i2c_reg_index == 0xA ||
-					settings->reg_settings_6g[i].i2c_reg_index == 0xB ||
-					settings->reg_settings_6g[i].i2c_reg_index == 0xC) {
-
-					/* Query current value from offset 0xA */
-					if (settings->reg_settings_6g[i].i2c_reg_index == 0xA)
-						value = settings->reg_settings_6g[i].i2c_reg_val;
-					else {
-						i2c_success =
-								link_query_ddc_data(
-								pipe_ctx->stream->link->ddc,
-								slave_address, &offset, 1, &value, 1);
-						if (!i2c_success)
-							goto i2c_write_fail;
-					}
+		for (size_t i = 0; i < settings->reg_num_6g; i++) {
+			const uint8_t index = settings->reg_settings_6g[i].i2c_reg_index;
+			uint8_t value = settings->reg_settings_6g[i].i2c_reg_val;
 
-					buffer[0] = offset;
-					/* Set APPLY_RX_TX_CHANGE bit to 1 */
-					buffer[1] = value | apply_rx_tx_change;
-					i2c_success = write_i2c(pipe_ctx, slave_address,
-							buffer, sizeof(buffer));
-					RETIMER_REDRIVER_INFO("retimer write to slave_address = 0x%x,\
-						offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-						slave_address, buffer[0], buffer[1], i2c_success?1:0);
-					if (!i2c_success)
-						goto i2c_write_fail;
-				}
+			if (!write_i2c_retimer_byte(link, address, index, value)) {
+				DC_LOG_ERROR("Set retimer failed, 6g index: %zu\n", i);
+				return false;
 			}
 		}
 	}
 
 	if (is_vga_mode) {
-		/* Program additional settings if using 640x480 resolution */
-
-		/* Write offset 0xFF to 0x01 */
-		buffer[0] = 0xff;
-		buffer[1] = 0x01;
-		i2c_success = write_i2c(pipe_ctx, slave_address,
-				buffer, sizeof(buffer));
-		RETIMER_REDRIVER_INFO("retimer write to slave_address = 0x%x,\
-				offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-				slave_address, buffer[0], buffer[1], i2c_success?1:0);
-		if (!i2c_success)
-			goto i2c_write_fail;
-
-		/* Write offset 0x00 to 0x23 */
-		buffer[0] = 0x00;
-		buffer[1] = 0x23;
-		i2c_success = write_i2c(pipe_ctx, slave_address,
-				buffer, sizeof(buffer));
-		RETIMER_REDRIVER_INFO("retimer write to slave_address = 0x%x,\
-			offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-			slave_address, buffer[0], buffer[1], i2c_success?1:0);
-		if (!i2c_success)
-			goto i2c_write_fail;
-
-		/* Write offset 0xff to 0x00 */
-		buffer[0] = 0xff;
-		buffer[1] = 0x00;
-		i2c_success = write_i2c(pipe_ctx, slave_address,
-				buffer, sizeof(buffer));
-		RETIMER_REDRIVER_INFO("retimer write to slave_address = 0x%x,\
-			offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-			slave_address, buffer[0], buffer[1], i2c_success?1:0);
-		if (!i2c_success)
-			goto i2c_write_fail;
-
-	}
-
-	return;
-
-i2c_write_fail:
-	DC_LOG_DEBUG("Set retimer failed");
+		return write_i2c_retimer_vga(link, address);
+	}
+	return true;
 }
 
-static void write_i2c_default_retimer_setting(
-		struct pipe_ctx *pipe_ctx,
+static bool write_i2c_default_retimer_setting(
+		const struct dc_link *link,
 		bool is_vga_mode,
 		bool is_over_340mhz)
 {
-	uint8_t slave_address = (0xBA >> 1);
-	uint8_t buffer[2];
-	bool i2c_success = false;
-	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
+	const uint8_t address = 0xBA >> 1;
 
-	memset(&buffer, 0, sizeof(buffer));
-
-	/* Program Slave Address for tuning single integrity */
-	/* Write offset 0x0A to 0x13 */
-	buffer[0] = 0x0A;
-	buffer[1] = 0x13;
-	i2c_success = write_i2c(pipe_ctx, slave_address,
-			buffer, sizeof(buffer));
-	RETIMER_REDRIVER_INFO("retimer writes default setting to slave_address = 0x%x,\
-		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-		slave_address, buffer[0], buffer[1], i2c_success?1:0);
-	if (!i2c_success)
-		goto i2c_write_fail;
-
-	/* Write offset 0x0A to 0x17 */
-	buffer[0] = 0x0A;
-	buffer[1] = 0x17;
-	i2c_success = write_i2c(pipe_ctx, slave_address,
-			buffer, sizeof(buffer));
-	RETIMER_REDRIVER_INFO("retimer write to slave_addr = 0x%x,\
-		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-		slave_address, buffer[0], buffer[1], i2c_success?1:0);
-	if (!i2c_success)
-		goto i2c_write_fail;
-
-	/* Write offset 0x0B to 0xDA or 0xD8 */
-	buffer[0] = 0x0B;
-	buffer[1] = is_over_340mhz ? 0xDA : 0xD8;
-	i2c_success = write_i2c(pipe_ctx, slave_address,
-			buffer, sizeof(buffer));
-	RETIMER_REDRIVER_INFO("retimer write to slave_addr = 0x%x,\
-		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-		slave_address, buffer[0], buffer[1], i2c_success?1:0);
-	if (!i2c_success)
-		goto i2c_write_fail;
-
-	/* Write offset 0x0A to 0x17 */
-	buffer[0] = 0x0A;
-	buffer[1] = 0x17;
-	i2c_success = write_i2c(pipe_ctx, slave_address,
-			buffer, sizeof(buffer));
-	RETIMER_REDRIVER_INFO("retimer write to slave_addr = 0x%x,\
-		offset = 0x%x, reg_val= 0x%x, i2c_success = %d\n",
-		slave_address, buffer[0], buffer[1], i2c_success?1:0);
-	if (!i2c_success)
-		goto i2c_write_fail;
-
-	/* Write offset 0x0C to 0x1D or 0x91 */
-	buffer[0] = 0x0C;
-	buffer[1] = is_over_340mhz ? 0x1D : 0x91;
-	i2c_success = write_i2c(pipe_ctx, slave_address,
-			buffer, sizeof(buffer));
-	RETIMER_REDRIVER_INFO("retimer write to slave_addr = 0x%x,\
-		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-		slave_address, buffer[0], buffer[1], i2c_success?1:0);
-	if (!i2c_success)
-		goto i2c_write_fail;
-
-	/* Write offset 0x0A to 0x17 */
-	buffer[0] = 0x0A;
-	buffer[1] = 0x17;
-	i2c_success = write_i2c(pipe_ctx, slave_address,
-			buffer, sizeof(buffer));
-	RETIMER_REDRIVER_INFO("retimer write to slave_addr = 0x%x,\
-		offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-		slave_address, buffer[0], buffer[1], i2c_success?1:0);
-	if (!i2c_success)
-		goto i2c_write_fail;
+	DC_LOGGER_INIT(link->ctx->logger);
 
+	const uint8_t data[][2] = {
+		{ 0x0A, 0x13 },
+		{ 0x0A, 0x17 },
+		{ 0x0B, is_over_340mhz ? 0xDA : 0xD8 },
+		{ 0x0A, 0x17 },
+		{ 0x0C, is_over_340mhz ? 0x1D : 0x91 },
+		{ 0x0A, 0x17 },
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(data); i++) {
+		if (!write_i2c_retimer_offset_value(link, address, data[i][0], data[i][1])) {
+			DC_LOG_ERROR("Set default retimer failed, index: %zu\n", i);
+			return false;
+		}
+	}
 
 	if (is_vga_mode) {
-		/* Program additional settings if using 640x480 resolution */
-
-		/* Write offset 0xFF to 0x01 */
-		buffer[0] = 0xff;
-		buffer[1] = 0x01;
-		i2c_success = write_i2c(pipe_ctx, slave_address,
-				buffer, sizeof(buffer));
-		RETIMER_REDRIVER_INFO("retimer write to slave_addr = 0x%x,\
-			offset = 0x%x, reg_val = 0x%x, i2c_success = %d\n",
-			slave_address, buffer[0], buffer[1], i2c_success?1:0);
-		if (!i2c_success)
-			goto i2c_write_fail;
-
-		/* Write offset 0x00 to 0x23 */
-		buffer[0] = 0x00;
-		buffer[1] = 0x23;
-		i2c_success = write_i2c(pipe_ctx, slave_address,
-				buffer, sizeof(buffer));
-		RETIMER_REDRIVER_INFO("retimer write to slave_addr = 0x%x,\
-			offset = 0x%x, reg_val= 0x%x, i2c_success = %d\n",
-			slave_address, buffer[0], buffer[1], i2c_success?1:0);
-		if (!i2c_success)
-			goto i2c_write_fail;
-
-		/* Write offset 0xff to 0x00 */
-		buffer[0] = 0xff;
-		buffer[1] = 0x00;
-		i2c_success = write_i2c(pipe_ctx, slave_address,
-				buffer, sizeof(buffer));
-		RETIMER_REDRIVER_INFO("retimer write default setting to slave_addr = 0x%x,\
-			offset = 0x%x, reg_val= 0x%x, i2c_success = %d end here\n",
-			slave_address, buffer[0], buffer[1], i2c_success?1:0);
-		if (!i2c_success)
-			goto i2c_write_fail;
-	}
-
-	return;
-
-i2c_write_fail:
-	DC_LOG_DEBUG("Set default retimer failed");
+		return write_i2c_retimer_vga(link, address);
+	}
+	return true;
 }
 
-static void write_i2c_redriver_setting(
-		struct pipe_ctx *pipe_ctx,
+static bool write_i2c_redriver_setting(
+		const struct dc_link *link,
 		bool is_over_340mhz)
 {
-	uint8_t slave_address = (0xF0 >> 1);
-	uint8_t buffer[16];
-	bool i2c_success = false;
-	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
-
-	memset(&buffer, 0, sizeof(buffer));
-
-	// Program Slave Address for tuning single integrity
-	buffer[3] = 0x4E;
-	buffer[4] = 0x4E;
-	buffer[5] = 0x4E;
-	buffer[6] = is_over_340mhz ? 0x4E : 0x4A;
-
-	i2c_success = write_i2c(pipe_ctx, slave_address,
-					buffer, sizeof(buffer));
-	RETIMER_REDRIVER_INFO("redriver write 0 to all 16 reg offset expect following:\n\
-		\t slave_addr = 0x%x, offset[3] = 0x%x, offset[4] = 0x%x,\
-		offset[5] = 0x%x,offset[6] is_over_340mhz = 0x%x,\
-		i2c_success = %d\n",
-		slave_address, buffer[3], buffer[4], buffer[5], buffer[6], i2c_success?1:0);
-
-	if (!i2c_success)
-		DC_LOG_DEBUG("Set redriver failed");
+	DC_LOGGER_INIT(link->ctx->logger);
+	const uint8_t address = 0xF0 >> 1;
+	uint8_t buffer[16] = {
+		[3] = 0x4E,
+		[4] = 0x4E,
+		[5] = 0x4E,
+		[6] = is_over_340mhz ? 0x4E : 0x4A,
+	};
+
+	const bool success = write_i2c(link, address, buffer, sizeof(buffer));
+
+	RETIMER_REDRIVER_INFO(
+			"Redriver write, address: 0x%x, buffer: { [3]: 0x%x, 0x%x, 0x%x, 0x%x }, success: %d\n",
+			address, buffer[3], buffer[4], buffer[5], buffer[6], success
+	);
+
+	if (!success)
+		DC_LOG_ERROR("Set redriver failed");
+	return success;
 }
 
 static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
@@ -1934,15 +1793,13 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 			eng_id = pipe_ctx->stream_res.stream_enc->id;
 
 			if (get_ext_hdmi_settings(pipe_ctx, eng_id, &settings)) {
-				write_i2c_retimer_setting(pipe_ctx,
-						is_vga_mode, is_over_340mhz, &settings);
+				write_i2c_retimer_setting(link, is_vga_mode, is_over_340mhz, &settings);
 			} else {
-				write_i2c_default_retimer_setting(pipe_ctx,
-						is_vga_mode, is_over_340mhz);
+				write_i2c_default_retimer_setting(link, is_vga_mode, is_over_340mhz);
 			}
 		} else if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_PI3EQX1204) {
 			/* PI3EQX1204, Redriver settings */
-			write_i2c_redriver_setting(pipe_ctx, is_over_340mhz);
+			write_i2c_redriver_setting(link, is_over_340mhz);
 		}
 	}
 
@@ -2353,14 +2210,12 @@ void link_set_dpms_off(struct pipe_ctx *pipe_ctx)
 		if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_TISN65DP159RSBT) {
 			/* DP159, Retimer settings */
 			if (get_ext_hdmi_settings(pipe_ctx, eng_id, &settings))
-				write_i2c_retimer_setting(pipe_ctx,
-						false, false, &settings);
+				write_i2c_retimer_setting(link, false, false, &settings);
 			else
-				write_i2c_default_retimer_setting(pipe_ctx,
-						false, false);
+				write_i2c_default_retimer_setting(link, false, false);
 		} else if (masked_chip_caps == AMD_EXT_DISPLAY_PATH_CAPS__HDMI20_PI3EQX1204) {
 			/* PI3EQX1204, Redriver settings */
-			write_i2c_redriver_setting(pipe_ctx, false);
+			write_i2c_redriver_setting(link, false);
 		}
 	}
 
-- 
2.43.0

