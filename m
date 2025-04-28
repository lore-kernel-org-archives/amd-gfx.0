Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4D5C369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53A9910E54C;
	Mon, 28 Apr 2025 13:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yO2BQ7Yu";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B22F410E54C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoZl+OlxTCFbX8OCgA23Q5J1PdOqZIbI/WHpu0Y/6q6Ysc9ckBJMiAeoYdzUKPCyCVTL+rfHZbwptuvhKA2S20GsGwB8TCFSii/f2BwKeBYfXhmCn3YSfxr2TJIqz3tXu3qx/AN6FOWz86J8mul3fy3KORk9ZQMC/6C7VATtq0dtkIGJO8o4MU4i1f85J7aHc8227N2iD8e5RHRm6A2uVE1LV6b/6HkYT1dY4KEUZHf9nNNuyR3lUCMOUbIq9TteJN6BLx8mF5TNM4JsuKxfYFBDLQIQ8NQT5xPOWOY6ABKiYvTUVU7/k+DrtqtvbqQX0A6G0Fz2CNusJV36l0HKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LxVKczm35nNDprmOSKUVqwqRU8Mg7Rcoh9w78jEe6c=;
 b=w5Zm1176yQ+BzGUeZUxb2YiGOjLwwM/UethHgCcEB3cb0asBXO8ldhBCxOmQnTI1sgfLsh8lpn0OLFMlyAVr5Va4rxQDDEM4g1xmML6ckFHDmjVfuY2mpF3FBMUqBOPQEdhP4ZHGVhvD+s3FCdYJ7qYlQXUqwItJ4Xo1IneYSX4cFmYPiGW7Q7OUdM1mYJO6Kdk9RzxvOqSQC6IoeSAgfVA29HsGLZoupBuMMbJDTxddXstYXzvZQ7iTI09ZTaMpZVHKkqiGXRGCO59zOTyaZ46hnk0UZDoippatEwOa9CW52nu5rg3eusM/kv8UfrIhyQmbS+BZgvsoKv2YLw4NZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LxVKczm35nNDprmOSKUVqwqRU8Mg7Rcoh9w78jEe6c=;
 b=yO2BQ7YuYmZd3sRZ1Aoq/8Ah2Qi5JU9WZ9ggFfBNG4j13swc2fL+mLuSpDPXey5hzOfdti6G16NZADLq/FZEdFClleB+6ni2C6TfOJa2qWDOZghIhbY6T+h7c2PF6ELW3Dlx6g/098W3W1yv9nECQpSBPczHJ9zt6PGGTb4qzhI=
Received: from CH0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:610:11a::26)
 by SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 28 Apr
 2025 13:56:17 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::36) by CH0PR03CA0347.outlook.office365.com
 (2603:10b6:610:11a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 13:56:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:56:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:56:16 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:56:13 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Dominik
 Kaszewski" <dominik.kaszewski@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Ray
 Wu <ray.wu@amd.com>
Subject: [PATCH 07/28] drm/amd/display: Prepare for Fused I2C-over-AUX
Date: Mon, 28 Apr 2025 21:50:37 +0800
Message-ID: <20250428135514.20775-8-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: 38753590-8111-4016-8a71-08dd865c729d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UUh28Rplne7af3TRIr8yqBmQCeGNamJ6E5NGHTUkt+d9MRQRI6b2fZ/xuBAx?=
 =?us-ascii?Q?byOVXRBjoarutNHK/VbolE4syqUmwaIsQlAGZ3PcJxzX6nV0QqCme8hxtF8I?=
 =?us-ascii?Q?e85nsn3QfvvvvAQm9rbg86iA+urTRYT7t/mVer1ZxYnJX6GVse5Boc4OwmAe?=
 =?us-ascii?Q?c7o/ujO6DEfRKZVNXyPKx+3mzC1r7datOFF6CoWwPClqntQ4u/xhxbjY6jkp?=
 =?us-ascii?Q?ExT1G21n6VmhXYAuNWo81utQqyQICBfC4TMmK8rVOsqUFOwzrNzTenXVgmF4?=
 =?us-ascii?Q?tSYy4GoRsjP8HbpAUPMl6JkQcydZQZT3qbYAFkWneaf3DVWPk0h7hHLAp9gn?=
 =?us-ascii?Q?yxO0Z5+yyoLjSNcXgDtx9a139DpkAOdMOvh9sGSaUqzy5n4pueEgSUPjMB9u?=
 =?us-ascii?Q?58aYnwrcpEeoahlBW/t0n5FVCoO/9gHVH1nE/8QrUxQkVQtWovMoDK4AyZNU?=
 =?us-ascii?Q?MZsO0iK8GYpKKPSqROR5vV4VOrvr4ksENM18Odh2Xj8gULwcwPEq5XIUbUbp?=
 =?us-ascii?Q?zGkDVAYFyZe4nzj0f7gNLg0uSS0cFl9jTbALH84EjFKBnlxfugI7DKvxqbKj?=
 =?us-ascii?Q?57/vC6xhpboVzm2alk8h3FYeiqPVwx4FW9jA7ZaxohDxG0kuCZDF/y5Lj4n0?=
 =?us-ascii?Q?dbtWHmAlTmXYufNq5fdVjhf2BoCmDtFRIxtzZYshRTV0SlD5sB15d73VrZ3f?=
 =?us-ascii?Q?+Cwymzdr78jMRsuElpwZdngqpmFqkerGGvVb6SJ35+nmj2Iu2RuiEKNeCJCZ?=
 =?us-ascii?Q?/RAFlUWKdq6iTy0tBJlS0oUtJT+asW4QxQUtvtkTXYr5VahDUXV8Ple2kVid?=
 =?us-ascii?Q?erDnKyip099ec1xRTe6Dy0yt4kheYeYdarOvxe6a1MOEux9cQnjz7WQpYWOu?=
 =?us-ascii?Q?Uw2BD4qDiUwdhD5Hc2+832uj1xpMYNCZBA2PasS5GHpIT7jnVg7v538jSDBd?=
 =?us-ascii?Q?D5a03Gy5OA6XgyB6SYfP22xU8d7aTszZUMXTOHzXte68sZm/FgYgbJHJfHE5?=
 =?us-ascii?Q?Ed6ATFtu37gUcftU65mCeO+RR2UKrb+lMUiCFeLvzcC+ZW8o+UUzt7aok2L6?=
 =?us-ascii?Q?Raw2kiTWOeP/dC6sCopAwGYEs/V10O2eMCYRTegF2aE53hIADLZnFt+KoLsy?=
 =?us-ascii?Q?3tg/n1pv4NsqZ2K9e1BVl4gJAY6xHIHYov4o/E11LALzoPLGXTnffgv/2gWn?=
 =?us-ascii?Q?Vu3BZdujYwRCrUUx93Jnq6JmZEuy7H1V8P2KhbCDLvRcc+4MGswsrsq5Yu5L?=
 =?us-ascii?Q?rQjzgYxcgeS5sJYNiN38IzI1HEkE/4Ij88lAXPfqgnHYqT5L9RCgrIgvQh8k?=
 =?us-ascii?Q?BXk4oJEs7SRd+7XYwLD/Bv36KeQLE8j9o/ef3l+JUEEZwKG23ORkP6qIzEDG?=
 =?us-ascii?Q?f7zCS979uq8uvw0SXgUKFjckqHjWL2+eF9auUkI8pNEIZQ69pJVtVXtn+qxX?=
 =?us-ascii?Q?NCkjJ4HOdkmAcaAZJbJdrVsvDRRfVSvSesH11Gpz8DHaG4TYdVh88GUhMWU8?=
 =?us-ascii?Q?4GjOxVD6rmT7DF2XMvgTOFGckzqfYIPjDGzu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:56:17.3857 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38753590-8111-4016-8a71-08dd865c729d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE
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
Passive DP-HDMI dongles use I2C-over-AUX protocol which is currently
not supported using HDCP Locality Check FW path.

[How]
Prepare code for switching to I2C-over-AUX protocol. Passive dongle
detection to be added in another commit.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c    | 12 ++++++++----
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_fused_io.c b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
index fff41b0a0a5a..fee69642fb93 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_fused_io.c
@@ -11,7 +11,8 @@ static bool op_i2c_convert(
 		union dmub_rb_cmd *cmd,
 		const struct mod_hdcp_atomic_op_i2c *op,
 		enum dmub_cmd_fused_request_type type,
-		uint32_t ddc_line
+		uint32_t ddc_line,
+		bool over_aux
 )
 {
 	struct dmub_cmd_fused_request *req = &cmd->fused_io.request;
@@ -23,6 +24,7 @@ static bool op_i2c_convert(
 	req->type = type;
 	loc->is_aux = false;
 	loc->ddc_line = ddc_line;
+	loc->over_aux = over_aux;
 	loc->address = op->address;
 	loc->offset = op->offset;
 	loc->length = op->size;
@@ -100,11 +102,13 @@ bool dm_atomic_write_poll_read_i2c(
 	if (!link)
 		return false;
 
+	const bool over_aux = false;
 	const uint32_t ddc_line = link->ddc->ddc_pin->pin_data->en;
+
 	union dmub_rb_cmd commands[3] = { 0 };
-	const bool converted = op_i2c_convert(&commands[0], write, FUSED_REQUEST_WRITE, ddc_line)
-			&& op_i2c_convert(&commands[1], poll, FUSED_REQUEST_POLL, ddc_line)
-			&& op_i2c_convert(&commands[2], read, FUSED_REQUEST_READ, ddc_line);
+	const bool converted = op_i2c_convert(&commands[0], write, FUSED_REQUEST_WRITE, ddc_line, over_aux)
+			&& op_i2c_convert(&commands[1], poll, FUSED_REQUEST_POLL, ddc_line, over_aux)
+			&& op_i2c_convert(&commands[2], read, FUSED_REQUEST_READ, ddc_line, over_aux);
 
 	if (!converted)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b11cf41c2d51..3ae31449983a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -5447,7 +5447,8 @@ struct dmub_cmd_fused_request {
 		struct dmub_cmd_fused_request_location_i2c {
 			uint8_t is_aux : 1;  // False
 			uint8_t ddc_line : 3;
-			uint8_t _reserved0 : 4;
+			uint8_t over_aux : 1;
+			uint8_t _reserved0 : 3;
 			uint8_t address;
 			uint8_t offset;
 			uint8_t length;
-- 
2.43.0

