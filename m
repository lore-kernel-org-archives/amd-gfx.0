Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2F4CAC58C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9F010E854;
	Wed, 10 Sep 2025 05:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KY1BRQUO";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FAE10E854
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKkznPCXADVP3Pv/+UC7KvXzMAOzAHiEecZKph8tDoFwvwVy78HkRdoP5B16q3kTovrCDE2STLCixXNzabOS2ZiZQASU3wxShdxRXQahb8BGj7NVIA+dSXXbM9vqhy10TJafIM5Ce2/oMJrheY50MTgXlPfv2bMt4E45W24qcE6IPeJ9jJVjWHSNa2T5mXmnee7KyZX+7DRz/pXusvLSssxeB/ZPk9BC4hjOc1e9Uqok6vTYVYsN2IJ2DkHRCfImPDj435Gd7JrsfmC40CM80vGRDEGsPGnWMnZZGlV2ywFujkBHig2uflHvCBaYo0F8gCz5nE4pux1d5RXfG0SXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6d1Y1WJolnMOWlQudyKl5vPfgJlicWcPAi5kGu4XIw=;
 b=hgE0CrWdqFgIqjgtgzQ/Me6WEruNOHw64SN3lounqSch2zAVE1cifPOqh4KKoYhwAPzuGFNPzz1lR9owjYPjS45xm+WSI7p/37xPYt9Y7MgwG+WY3ny0slJOEF2ShweQlhi+jmmoHi8PrsPBUYbf7J8ksHGJHUR/EGRz6bFsKXdKAad1BRpf6DPER6LKXWveMSE0754I0jASQHyWGS+Dbnq81cs7DuVEcUvVnPJD7w5SOZ7Vyrg7EgMYPa0P6179Oh6oz0VZfLJ1mmQOCubtDgn/LPY2OgZgGrmcf2FQpZyK55lVzeHgoj/0W9voKn8zsaHvYxV2W3UKQY/tLsqcfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6d1Y1WJolnMOWlQudyKl5vPfgJlicWcPAi5kGu4XIw=;
 b=KY1BRQUOJsRR37IwE4RL6k3PaPllpw/YIvLtw1VHHZvSYNhNX4XDFJooRZrbcPcqNALDYq7U8DZCNxOXjM+IMW18Iln5N4hfz5lKPUPjvlPV+25CiXHwdm2lDmkuhYuO/eDNtx9+NzKVezya/V/emdQLnIDrDYEneGAzm6z4YJk=
Received: from BN9PR03CA0942.namprd03.prod.outlook.com (2603:10b6:408:108::17)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:00 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::76) by BN9PR03CA0942.outlook.office365.com
 (2603:10b6:408:108::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Wed,
 10 Sep 2025 05:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:32:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 9 Sep
 2025 22:32:57 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Sep
 2025 00:32:56 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:32:53 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Sreeja Golui
 <sreeja.golui@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 03/15] drm/amd/display: Fix DMCUB loading sequence for DCN3.2
Date: Wed, 10 Sep 2025 13:30:26 +0800
Message-ID: <20250910053222.2884632-4-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: b899ed9b-4034-4f66-e414-08ddf02b813e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?agPsHEmOIrpuYkSJ0vmbS/+wYQkHakIcuL9D4qIE41A7m77gBljxqTOIf8tG?=
 =?us-ascii?Q?TP2odyAOxpuF3yzCKQtV535ZvwWodUMFwhYI534PqM+aTGDLXs3Lspr0JNZd?=
 =?us-ascii?Q?kiHMWsoo19UIBDXMGjAReX/R7jfe9Z7tVbCgkynKouxhYE6ZnYpovGQw2/62?=
 =?us-ascii?Q?qyOY68akJ3Lmi3AD/UZ68cSDVKH3Nw9vz7SH9JRrZabbkzAdkjIpJFTpCZ1E?=
 =?us-ascii?Q?hdZJ9wLxk6CecoiHIbwHIsTnJlV18124+goYwzDQUoZ2KkLlbjGyKkEwUnk7?=
 =?us-ascii?Q?FyA4DBe0ykjFT/ROaknPpkBQSNYuJa0N745NPbCO/9bneK4Nh71CxNogsgJN?=
 =?us-ascii?Q?jCWyFl8MotPoo2GzYeJrMHSiR97UmR34DfT9AiuTFtDLmdR9n1FGCABk8mOY?=
 =?us-ascii?Q?youeszov4JyRIUu/3KpwSM4Ijj2j5822VqK+z/By6nWSn7JxbRb5V45K1lhR?=
 =?us-ascii?Q?tD1Oh4OchdQKeg3y4yQ6pTpnbYWmpC9eNI7w5MQZ6DPFvZwFBZWXpuVjLyK3?=
 =?us-ascii?Q?BHhZNym0A7nFpLoEIZki0Gt5nR1OfMMCsPo/WvPmmh8nL9nEDQGHjYZOs5IE?=
 =?us-ascii?Q?i1oqTCuZzRFottYENHx5k9H04C0b4vjG3hstW1hAFV7OTAa2KbeM8E2b0xP4?=
 =?us-ascii?Q?OolMvp94IvbzWtb9D6UJxN6789ci2WFblWbMzDKH9J+tkU1jKBHnlihC4//7?=
 =?us-ascii?Q?3xUG8SZB8/qZpxpgLPamNErSTOg9eBHXP8PkAxVTE+D7YlX1TDRSB8tbIyV2?=
 =?us-ascii?Q?ldRBVOOlAXeCvQzUo+x1IGW9yz/vqA2J7AsgtuflQ4O8OrxcgWSe9EGWS1NB?=
 =?us-ascii?Q?YPKEQIEzQI073I2wSg6fJXI3e/4oGYIVTY2E48u13PrsLovRE+JP1ZNVBFo+?=
 =?us-ascii?Q?zfvyg6GPY19KYUffx8InQqZpRb4Y0FIP1IF1PkxIuGqNXlee44NZBjoIuP6n?=
 =?us-ascii?Q?jvk42ZGLDz0ZJdeshvuYJ4s5kWPdPr+tOvPZkYCqUqnX6W13/+3WjCUjzcQE?=
 =?us-ascii?Q?SpoOKSRRBuaYfxf+IvZWdnkl1GPGZGXQvrhcaZVi1qkaJ5z+ruELoF6yNrqv?=
 =?us-ascii?Q?kN7xDjB4ScfynZsXV/ErEB5p5lMMMnOw/Arh2lyecAEqXahmZpdsSrfvT8eD?=
 =?us-ascii?Q?nW+DiTv3E80hZT2VqXPgdZlhpfi7tvDZaEb6P4NUBcI898RMNNTphnZHk+oC?=
 =?us-ascii?Q?yyu9BNy18nY2Wpw8j8hUKB4gvJrM9Fae/oFtMSEfZAmq/VqXQWQrUY3pRhRa?=
 =?us-ascii?Q?2uEpux6sFNYSH20HgFfdTQJXlShwZLelDR2Mz8H1NEPWMqW0Xc9em3aD0Slf?=
 =?us-ascii?Q?QhzFtpOCUEd9HBAThOaFdfMZPbAOhs/lOTjLidskuLH4DUMxzGtg/tEPyYMg?=
 =?us-ascii?Q?id5z001w+VvP3hZNoVSUYvbCvOuSX+W0e7vRuaMTUzINoxJRcpzdux+Tpz7o?=
 =?us-ascii?Q?nQ7aDXOPo6HnjfXyKcov1s1CwQ7lpQjYp2UmwL2uUAPqKHXLfInLIKB2CERz?=
 =?us-ascii?Q?oTk/UPRaKVQlqH9NgzAo0OBOwfUvgS6Loc4o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:32:59.8700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b899ed9b-4034-4f66-e414-08ddf02b813e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
New sequence from HW for reset and firmware reloading has been
provided that aims to stabilize the reload sequence in the case the
firmware is hung or has outstanding requests.

[How]
Update the sequence to remove the DMUIF reset and the redundant
writes in the release.

Reviewed-by: Sreeja Golui <sreeja.golui@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 53 ++++++++++---------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |  8 ++-
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index e7056205b050..ce041f6239dc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -89,44 +89,50 @@ static inline void dmub_dcn32_translate_addr(const union dmub_addr *addr_in,
 void dmub_dcn32_reset(struct dmub_srv *dmub)
 {
 	union dmub_gpint_data_register cmd;
-	const uint32_t timeout = 30;
-	uint32_t in_reset, scratch, i;
+	const uint32_t timeout = 100000;
+	uint32_t in_reset, is_enabled, scratch, i, pwait_mode;
 
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &in_reset);
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enabled);
 
-	if (in_reset == 0) {
+	if (in_reset == 0 && is_enabled != 0) {
 		cmd.bits.status = 1;
 		cmd.bits.command_code = DMUB_GPINT__STOP_FW;
 		cmd.bits.param = 0;
 
 		dmub->hw_funcs.set_gpint(dmub, cmd);
 
-		/**
-		 * Timeout covers both the ACK and the wait
-		 * for remaining work to finish.
-		 *
-		 * This is mostly bound by the PHY disable sequence.
-		 * Each register check will be greater than 1us, so
-		 * don't bother using udelay.
-		 */
-
 		for (i = 0; i < timeout; ++i) {
 			if (dmub->hw_funcs.is_gpint_acked(dmub, cmd))
 				break;
+
+			udelay(1);
 		}
 
 		for (i = 0; i < timeout; ++i) {
-			scratch = dmub->hw_funcs.get_gpint_response(dmub);
+			scratch = REG_READ(DMCUB_SCRATCH7);
 			if (scratch == DMUB_GPINT__STOP_FW_RESPONSE)
 				break;
+
+			udelay(1);
 		}
 
+		for (i = 0; i < timeout; ++i) {
+			REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &pwait_mode);
+			if (pwait_mode & (1 << 0))
+				break;
+
+			udelay(1);
+		}
 		/* Force reset in case we timed out, DMCUB is likely hung. */
 	}
 
-	REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
-	REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
-	REG_UPDATE(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET, 1);
+	if (is_enabled) {
+		REG_UPDATE(DMCUB_CNTL2, DMCUB_SOFT_RESET, 1);
+		udelay(1);
+		REG_UPDATE(DMCUB_CNTL, DMCUB_ENABLE, 0);
+	}
+
 	REG_WRITE(DMCUB_INBOX1_RPTR, 0);
 	REG_WRITE(DMCUB_INBOX1_WPTR, 0);
 	REG_WRITE(DMCUB_OUTBOX1_RPTR, 0);
@@ -135,7 +141,7 @@ void dmub_dcn32_reset(struct dmub_srv *dmub)
 	REG_WRITE(DMCUB_OUTBOX0_WPTR, 0);
 	REG_WRITE(DMCUB_SCRATCH0, 0);
 
-	/* Clear the GPINT command manually so we don't reset again. */
+	/* Clear the GPINT command manually so we don't send anything during boot. */
 	cmd.all = 0;
 	dmub->hw_funcs.set_gpint(dmub, cmd);
 }
@@ -419,8 +425,8 @@ uint32_t dmub_dcn32_get_current_time(struct dmub_srv *dmub)
 
 void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub)
 {
-	uint32_t is_dmub_enabled, is_soft_reset, is_sec_reset;
-	uint32_t is_traceport_enabled, is_cw0_enabled, is_cw6_enabled;
+	uint32_t is_dmub_enabled, is_soft_reset, is_pwait;
+	uint32_t is_traceport_enabled, is_cw6_enabled;
 	struct dmub_timeout_info timeout = {0};
 
 	if (!dmub)
@@ -470,18 +476,15 @@ void dmub_dcn32_get_diagnostic_data(struct dmub_srv *dmub)
 	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_dmub_enabled);
 	dmub->debug.is_dmcub_enabled = is_dmub_enabled;
 
+	REG_GET(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS, &is_pwait);
+	dmub->debug.is_pwait = is_pwait;
+
 	REG_GET(DMCUB_CNTL2, DMCUB_SOFT_RESET, &is_soft_reset);
 	dmub->debug.is_dmcub_soft_reset = is_soft_reset;
 
-	REG_GET(DMCUB_SEC_CNTL, DMCUB_SEC_RESET_STATUS, &is_sec_reset);
-	dmub->debug.is_dmcub_secure_reset = is_sec_reset;
-
 	REG_GET(DMCUB_CNTL, DMCUB_TRACEPORT_EN, &is_traceport_enabled);
 	dmub->debug.is_traceport_en  = is_traceport_enabled;
 
-	REG_GET(DMCUB_REGION3_CW0_TOP_ADDRESS, DMCUB_REGION3_CW0_ENABLE, &is_cw0_enabled);
-	dmub->debug.is_cw0_enabled = is_cw0_enabled;
-
 	REG_GET(DMCUB_REGION3_CW6_TOP_ADDRESS, DMCUB_REGION3_CW6_ENABLE, &is_cw6_enabled);
 	dmub->debug.is_cw6_enabled = is_cw6_enabled;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
index 1a229450c53d..daf81027d663 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
@@ -89,6 +89,9 @@ struct dmub_srv;
 	DMUB_SR(DMCUB_REGION5_OFFSET) \
 	DMUB_SR(DMCUB_REGION5_OFFSET_HIGH) \
 	DMUB_SR(DMCUB_REGION5_TOP_ADDRESS) \
+	DMUB_SR(DMCUB_REGION6_OFFSET) \
+	DMUB_SR(DMCUB_REGION6_OFFSET_HIGH) \
+	DMUB_SR(DMCUB_REGION6_TOP_ADDRESS) \
 	DMUB_SR(DMCUB_SCRATCH0) \
 	DMUB_SR(DMCUB_SCRATCH1) \
 	DMUB_SR(DMCUB_SCRATCH2) \
@@ -155,6 +158,8 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_REGION4_TOP_ADDRESS, DMCUB_REGION4_ENABLE) \
 	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_TOP_ADDRESS) \
 	DMUB_SF(DMCUB_REGION5_TOP_ADDRESS, DMCUB_REGION5_ENABLE) \
+	DMUB_SF(DMCUB_REGION6_TOP_ADDRESS, DMCUB_REGION6_TOP_ADDRESS) \
+	DMUB_SF(DMCUB_REGION6_TOP_ADDRESS, DMCUB_REGION6_ENABLE) \
 	DMUB_SF(CC_DC_PIPE_DIS, DC_DMCUB_ENABLE) \
 	DMUB_SF(MMHUBBUB_SOFT_RESET, DMUIF_SOFT_RESET) \
 	DMUB_SF(DCN_VM_FB_LOCATION_BASE, FB_BASE) \
@@ -162,7 +167,8 @@ struct dmub_srv;
 	DMUB_SF(DMCUB_INBOX0_WPTR, DMCUB_INBOX0_WPTR) \
 	DMUB_SF(DMCUB_REGION3_TMR_AXI_SPACE, DMCUB_REGION3_TMR_AXI_SPACE) \
 	DMUB_SF(DMCUB_INTERRUPT_ENABLE, DMCUB_GPINT_IH_INT_EN) \
-	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK)
+	DMUB_SF(DMCUB_INTERRUPT_ACK, DMCUB_GPINT_IH_INT_ACK) \
+	DMUB_SF(DMCUB_CNTL, DMCUB_PWAIT_MODE_STATUS)
 
 struct dmub_srv_dcn32_reg_offset {
 #define DMUB_SR(reg) uint32_t reg;
-- 
2.43.0

