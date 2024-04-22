Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70F1C07C79
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BDBE112C08;
	Mon, 22 Apr 2024 15:31:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FJXVBWXO";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3661A112C08
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:31:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4PDE9+ye0WL/kUqs2EMdoLEBmqFibEvmr3NgOefqeVbV2DDki4mNeAj5CxtybXaeqraVcacj309+zEXuqS6zhJaJ4sxK8OxXC+8retY/j72C7VPITTu/OY4FCDR6ODQq5pgUGGyUaF03RWqA4CICl4cjvvUvMDd/4SR77c3xwRi/ziPFppMq1QgyN72bLGC822k1UUSjUpIFgYWaxaZzFha9h7JnooP0pukW5AWLS4auYertw0nzgPuqMIHt1i6gGL1kMtGDcYAWyVnh8Fi+iDRsrqU5hMOEIWd5qu/580cV+zPVYmdRfagtZAtRHvESEQzwHcIYybJv5r08Bqbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0o3iKAppQ4+4gYlkmfIYJYm+1jaBGnYPWQ+nT8MXEM=;
 b=V2HVzrqAxTpAzqQwc7KSfv0DYR+I8CpIXJ2pvP9ubZ4aY2te5eArZPMxS/5s+e11SUCyQUOnqpo22XaVHSKkOd9SWzjQ7cXkWEUaYbCL2UUkGs0POe/aeMSWpWmFZrgeBqBLp5BH804P8N+pSnZxO62rl/I8X/HWHapPSX76wQDnnA9ZvUdP+To2IjRwA8mmmLvrSdjNEMf4OtUcaz7WgGgvMV+e3eZDDG1Rhh847e9/vQ1EH0/QQHjBvGGOxUM+keayCbDGyPIazPmIvbMWbNPowRpTIns283ew/vHNaZAg22L3YbxdysM5c2p3wQxUVStsQR63awErGCJ/Ipfxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0o3iKAppQ4+4gYlkmfIYJYm+1jaBGnYPWQ+nT8MXEM=;
 b=FJXVBWXOhONYOynt3/AsoOpyPIXSxbyrpVibv6Ej903sRLFiHJSaJFHzp07xBllv997CYTRLGwstbrbBohXQdd3BJB0MkZTNEPzuHbi8nu1s6tSFhN6VGsVTpXIqF06Wo3eagFGZ/DaVS3UcIW7rexSDsHmRHrSGAJxNllHjfk8=
Received: from SA1P222CA0169.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::12)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:31:37 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::9) by SA1P222CA0169.outlook.office365.com
 (2603:10b6:806:3c3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:31:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:31:31 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:31:25 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Cruise <cruise.hung@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 32/37] drm/amd/display: Disable error correction if it's not
 supported
Date: Mon, 22 Apr 2024 11:27:41 -0400
Message-ID: <20240422152817.2765349-33-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 41314100-bfde-43e5-1e9c-08dc62e14989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9c79vD8vJf1md7vJA8ThZktV1aYf1Ot69d1IQKsGQsUh0xLTV+fUCOj9jaNh?=
 =?us-ascii?Q?GCQd6mBrIJVufvZR/X1DBxK0eN96GiVioby3U4NdSmklPkR9i6jMRobHivj3?=
 =?us-ascii?Q?+eIHq1k9e/lTL+Oymi6C/969/IFK5nwe0YoPQeURWq7zlCuQF4JL+zZpNTxM?=
 =?us-ascii?Q?LP75QH1PRJln4sL78UHQq8BOl/F4uUXGWaDYHmHCoGNNfFFVvvVMl4wJ9FGz?=
 =?us-ascii?Q?KHyMyquHBdBOZj+UGU1buClDWKFYkxFcfLlD7p88rwaiF65k2bnEA7J1Dpt7?=
 =?us-ascii?Q?oX8HPgch9qTSR57IQXqUy8+6EmShiwg5/uOcP4BAqyVmyLrf/0DATSsNqQmA?=
 =?us-ascii?Q?lgf6CUl1mNYuyUXH8tOPUScwdtjigRvxua3Ei+S3UpZZOAIcCCMxq0+8wdG+?=
 =?us-ascii?Q?RiNt0ZVIa6lKfIA5toHfavb9BauCUTK7iYDyJEB0UNAO0onKao4zFxzWap7G?=
 =?us-ascii?Q?9LW+BTFWJSaCBysoGFcnCHQKPzpkaXUG75AU49c5dwFGPed39RaMLw1yIrQq?=
 =?us-ascii?Q?M+9Bs5860aYKdCs//GuNiO8Q3bHGnRIrRxLV1sFnWqqO/72F97fQz8P8wKXu?=
 =?us-ascii?Q?qf6IW7g4wUDiWv3jtwATEi4N8h2/1k8iMFT3rDJoypl7yTtT/i7PFGmCLTd3?=
 =?us-ascii?Q?hj6qTQd9dIywmDhtQnQQGQVd/4ftsq4IlEbXy4bK1B07w35imTe+GWy+dVQP?=
 =?us-ascii?Q?Jt3dT/mERfymxU12RDaQpN3YaJfddOmBTV61VDLoukO5vaajGaDNxOPPZWi8?=
 =?us-ascii?Q?7kJpyLhKcHCM9Le51xJwW0Q7XDcfI3ojZ96mffnbS8f4v7a2s8s9aor1xX+i?=
 =?us-ascii?Q?pqFsINQkWS+0SeRkzlLadYdJwJzPCgcyR1Q43DGTGlLbeZbNQYlPNB6rndds?=
 =?us-ascii?Q?Pq+IP78OttBSp7PklChJXQ/sF9G7hMVyzGc09LsfNYAXITiqFjMAmHb81n2O?=
 =?us-ascii?Q?6rvJfqnurTZwGkzIIAvVNgTtC9gtOaDO3qCt4dttY5w8JRhNyjTBcC6UOIg2?=
 =?us-ascii?Q?k9T8xH78fpAQULUVo5Trtkv/UriozL11l0q/BerHXRI32o4XuhtzNJohKywZ?=
 =?us-ascii?Q?i9+L8WvoD7/lxJhfylSb8Eo1TlRhwTgi+GP7W4HskfBan4WBsQyADXfCgMub?=
 =?us-ascii?Q?zNheIQjNbluDbUrzzCkewZUGfLuITgIdINp5GsYZieDo7cYYJ+rvMw50+h01?=
 =?us-ascii?Q?2p6zd0CzjMCei2K3cr6NQbC/uHVLytAc30aj8Od77Cm0QGNinWxy5QpypmqL?=
 =?us-ascii?Q?6IPRrVkbFNFiFHFSmpsBMQYUDUoCZ9kLEYu/zaqCBPqXcaIPzoBKpSjqPF3P?=
 =?us-ascii?Q?UgKZ1mR6teU9a4IUhjN1enAsufuHdjG15CgImUUEDzEZdvoPg6DOUJt/Oj6T?=
 =?us-ascii?Q?eMiXbZh0hxJ/5BQWPDO6GzgyH3gr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:31:32.0029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41314100-bfde-43e5-1e9c-08dc62e14989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
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

From: Cruise <cruise.hung@amd.com>

[Why]
Error correction was enabled in a monitor which doesn't support.

[How]
Disable error correction if it's not supported

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Cruise <cruise.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../display/dc/link/protocols/link_dp_phy.c   | 47 +++++++++----------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
index 2fa4e64e2430..5cbf5f93e584 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_phy.c
@@ -147,32 +147,27 @@ enum dc_status dp_set_fec_ready(struct dc_link *link, const struct link_resource
 
 	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
+	if (link_enc->funcs->fec_set_ready == NULL)
+		return DC_NOT_SUPPORTED;
 
-	if (!dp_should_enable_fec(link))
-		return status;
-
-	if (link_enc->funcs->fec_set_ready &&
-			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE) {
-		if (ready) {
+	if (ready && dp_should_enable_fec(link)) {
+		if (link->fec_state == dc_link_fec_not_ready) {
 			fec_config = 1;
-			status = core_link_write_dpcd(link,
-					DP_FEC_CONFIGURATION,
-					&fec_config,
-					sizeof(fec_config));
+
+			status = core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+					&fec_config, sizeof(fec_config));
+
 			if (status == DC_OK) {
 				link_enc->funcs->fec_set_ready(link_enc, true);
 				link->fec_state = dc_link_fec_ready;
-			} else {
-				link_enc->funcs->fec_set_ready(link_enc, false);
-				link->fec_state = dc_link_fec_not_ready;
-				dm_error("dpcd write failed to set fec_ready");
 			}
-		} else if (link->fec_state == dc_link_fec_ready) {
+		}
+	} else {
+		if (link->fec_state == dc_link_fec_ready) {
 			fec_config = 0;
-			status = core_link_write_dpcd(link,
-					DP_FEC_CONFIGURATION,
-					&fec_config,
-					sizeof(fec_config));
+			core_link_write_dpcd(link, DP_FEC_CONFIGURATION,
+				&fec_config, sizeof(fec_config));
+
 			link_enc->funcs->fec_set_ready(link_enc, false);
 			link->fec_state = dc_link_fec_not_ready;
 		}
@@ -187,14 +182,12 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 
 	link_enc = link_enc_cfg_get_link_enc(link);
 	ASSERT(link_enc);
-
-	if (!dp_should_enable_fec(link))
+	if (link_enc->funcs->fec_set_enable == NULL)
 		return;
 
-	if (link_enc->funcs->fec_set_enable &&
-			link->dpcd_caps.fec_cap.bits.FEC_CAPABLE) {
-		if (link->fec_state == dc_link_fec_ready && enable) {
-			/* Accord to DP spec, FEC enable sequence can first
+	if (enable && dp_should_enable_fec(link)) {
+		if (link->fec_state == dc_link_fec_ready) {
+			/* According to DP spec, FEC enable sequence can first
 			 * be transmitted anytime after 1000 LL codes have
 			 * been transmitted on the link after link training
 			 * completion. Using 1 lane RBR should have the maximum
@@ -204,7 +197,9 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 			udelay(7);
 			link_enc->funcs->fec_set_enable(link_enc, true);
 			link->fec_state = dc_link_fec_enabled;
-		} else if (link->fec_state == dc_link_fec_enabled && !enable) {
+		}
+	} else {
+		if (link->fec_state == dc_link_fec_enabled) {
 			link_enc->funcs->fec_set_enable(link_enc, false);
 			link->fec_state = dc_link_fec_ready;
 		}
-- 
2.44.0

