Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF07C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60FB10E5F0;
	Wed, 28 Feb 2024 18:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0XUdFeZS";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5E3310E5EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:45:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9YIdXzzsf029mha08p4b6Z7UGnkem5rblU63pwdgsy8uhYMX0p83RrN/Ehy6oDV2H1jLsjrzcNOkjP0oCVT6OIHHwdQO7vbB/oHe3gGwRVrovinnwwKwkRrKQbSz94JNxgoB7MMuw8TSMDApcb2bu3w9zQ7q11UksmQEDMeJDWw8EV/TFLYPcwrdLWcy1uTTa0uK4fiBLq1MApY4RtSIo7+2ah4THIUM1gN3B3eOzDd05b5L0pvkAKjX7K3gc/BESKXb318qDZxeXxN89WnLjc4vAAkktE8zPdwpaS43jcFW1uC/559gdrFyNpESs48YVpSQRsFLB8TI10ThyLr1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sibriZz79DV2N9ZcE/EsjJwgD3EEJKIpqcawMprC9fA=;
 b=fcwdYc6iwYmcPdRvtl5+0xV6Dbxxnbc9YEGEHAxu7xMQXMm3u/t5hmAmz38g2U+wY46UEml4WnF4cse3W4WXQG/6yszotZBa3xo+hU561232ClyG20KrMMs0Y4VMKRIQsEg/uX4rz7w15e1vdkMlXZvqa4fbbkBzWFPJ9xjJ2KDWWhkeKaac9z3tygO1VidxYhDvRqu/PLITuvRADnqDk2YlYrziuHtxCzdbEQtGjDKcFZ9D6Fm6x5K9Tj17Lzx5kjPstZjJMqVeXR9zh3A2VxlBUTzMHU8vgUqn5T/TbOkmsSSRNuIzoWLAP521bXY/P3e5rljsz57roxfL85o47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sibriZz79DV2N9ZcE/EsjJwgD3EEJKIpqcawMprC9fA=;
 b=0XUdFeZS6Uj97I26Ev2K0KULsIg8Mbgy8meIZxwTZaP8hYxaXkKpj+W8YWcKteZSTWgFNBy8zdaNxHDO+/6ntZONdmu5bmblSAvl/g6qq2Sij9mwfAyiVnkeBn4O/M2O++hk3rYdwhmMqkR+jyflbxKJ0x3Ai69tyLhbIta/MGc=
Received: from DS7PR03CA0166.namprd03.prod.outlook.com (2603:10b6:5:3b2::21)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 18:45:31 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::14) by DS7PR03CA0166.outlook.office365.com
 (2603:10b6:5:3b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:45:31 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:45:28 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 21/34] drm/amd/display: Add debug counters to IPS exit prints
Date: Wed, 28 Feb 2024 11:39:27 -0700
Message-ID: <20240228183940.1883742-22-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c8cd1b-1f1e-4f25-b45a-08dc388d70b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAzhjhbO2L5aEmnRQ8emu2Da8XkQl+ki2S+8EeAIKvpARylG6WKRL3FI32kHltCgBJVcw16kOGpegwK1khyRH6M+DdPjYt+y5S5L25QY6oucxf42ylIkdLXPgf9pAWjVa+vtT1vVbxUSPAvCP3KjR/eetNmcc+Yb3cQlXSw5OXjpJAiVCh/8uQzaFKXqwZrzUkqDazqci647lrJMiEAd778bV/p86yGzKWawvOvnSNhQi5fJyht2swJ/oGJEUOjnUR693PfeBLjFpt4Vy3cYCd0YlvvQzZtdr4byIAJ6si74UILKnbN2d/cCcu9ML5k8MO5C0GS6yYni2BzHwXfimyY2cX/1TgOfErpUjBHJdEzlACXtBOmvFuHtiOqMph8qgVeGGq+YKl38tLIVZSbB+IxaUghESzwPwsUVNWs3yQEBrFqVe/DabltiZzdSZOvrldkdmjjeSbLaxYRY2E2jWQ/HvQD9jvY/FtK4wp3PrjXeX37JvWWkol59oLHywhErmkuCCbTxthpEiKmoC1nZV4VOzKVKIszCFMqznjJSsCxnnLYhM6BNi3oV8UhIjV7LfNLxzqUGlFXfnT9p1OzB/w3o9dJld2keqozNOK9F0p0UjlhIt1DiBg8ZLzygcwuin08/8Y5hZXaiL6h6248Bt/kapjFfb9Lmvar9ArMVOxV/D+0uMam7sUPDFXuFwhPWKxNie8+ETivQmirxxN0yG83t4AZJmGgyA+TeUjSQXIpS371y9ms0DCOC7dHnXLZU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:45:31.1330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c8cd1b-1f1e-4f25-b45a-08dc388d70b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049
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

[WHY]
To have a log of the entry/exit counters in case the system hangs to
measure stability.

[HOW]
Read them from firmware state and pass them to the prints.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 938e8cb2fec1..765a459d54eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1279,6 +1279,7 @@ static void dc_dmub_srv_notify_idle(const struct dc *dc, bool allow_idle)
 static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 {
 	struct dc_dmub_srv *dc_dmub_srv;
+	uint32_t rcg_exit_count, ips1_exit_count, ips2_exit_count;
 
 	if (dc->debug.dmcub_emulation)
 		return;
@@ -1295,15 +1296,22 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 			&dc_dmub_srv->dmub->shared_state[DMUB_SHARED_SHARE_FEATURE__IPS_DRIVER].data.ips_driver;
 		union dmub_shared_state_ips_driver_signals prev_driver_signals = ips_driver->signals;
 
+		rcg_exit_count = ips_fw->rcg_exit_count;
+		ips1_exit_count = ips_fw->ips1_exit_count;
+		ips2_exit_count = ips_fw->ips2_exit_count;
+
 		ips_driver->signals.all = 0;
 
 		DC_LOG_IPS(
-			"%s check (allow_ips1=%d allow_ips2=%d) (ips1_commit=%d ips2_commit=%d)",
+			"%s (allow ips1=%d ips2=%d) (commit ips1=%d ips2=%d) (count rcg=%d ips1=%d ips2=%d)",
 			__func__,
 			ips_driver->signals.bits.allow_ips1,
 			ips_driver->signals.bits.allow_ips2,
 			ips_fw->signals.bits.ips1_commit,
-			ips_fw->signals.bits.ips2_commit);
+			ips_fw->signals.bits.ips2_commit,
+			ips_fw->rcg_entry_count,
+			ips_fw->ips1_entry_count,
+			ips_fw->ips2_entry_count);
 
 		/* Note: register access has technically not resumed for DCN here, but we
 		 * need to be message PMFW through our standard register interface.
@@ -1387,7 +1395,11 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 	if (!dc_dmub_srv_is_hw_pwr_up(dc->ctx->dmub_srv, true))
 		ASSERT(0);
 
-	DC_LOG_IPS("%s exited", __func__);
+	DC_LOG_IPS("%s exit (count rcg=%d ips1=%d ips2=%d)",
+		__func__,
+		rcg_exit_count,
+		ips1_exit_count,
+		ips2_exit_count);
 }
 
 void dc_dmub_srv_set_power_state(struct dc_dmub_srv *dc_dmub_srv, enum dc_acpi_cm_power_state powerState)
-- 
2.34.1

