Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1CAC25B7E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA8010E3A6;
	Fri, 31 May 2024 16:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2yDCwNgR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E86010E255
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luEVvY3tILLFFWL1L2DaJzxTx/BBFNMJfX+EuaKkWDFPgfmhyjeun9xR4h4YpZfa3Bh4VcjdlGsci7oi8GMQ4DAaVgJVm86eh4S5yWgVuf4ll5nzKWVOYAxYlqfU2B1GNAH7gTeeV515uvv1cldq5Xgq5SAh90zCthCU9hX2I5QyyAdpA5zNyVHmZY+Ss8/6O75Aohp2dLQg9Gj8J1+6moXCyi+4UCej4/pyOaed0tTvuSHhOd8XtfwIzznHiF9rRn+n1KXedw9HwpB6yPswrf6DeXIioVN02Anrp5dVZvnqUgrve3btYxz5pagm0nnkN/JNT4dsOo6y4pdN1sZSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU3UCs/XOqeDenGlTKkBddE2iefeM69BSWA+RtaibyY=;
 b=e2++nbmlFdZuvJ37bYo6/TSpOJeBrxN7RgD3jzQiVS9Gfwy7tb7LE4znOIiZuzignFE5BQZIBgZaKqxjHiBHgFUQ+i1WG5FG4wlUamBaTYVNJNpzj7GoN68EH0JIFxCVm0g13PKyUsJK1GMSMOAijoX/ON0n2lh5GZO9sGPPh0oibsi9x4zXGRQ4RBJpeuk0pg94BDF21sK01OMKJ+JZtY0WWNGYvmwKdj4Ji7PtDcdeTzUdfi0CIprvZ6EpwhsSCPpDFM0Ih+WnMGA32rslLmWAb4j/bNQFR1AkEHtrPszzAps9/7Tgh1x7Nk2VEzuuVWGpx99IuM0gi2mXct1wqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU3UCs/XOqeDenGlTKkBddE2iefeM69BSWA+RtaibyY=;
 b=2yDCwNgR3rFmbx+/eP6qgDxRRgdGdWUHa+NzSRumRo2w6obkznNkBAdahAC9Uv7Jg6yWmFFolLwjc9cqn7senVbx/LhAXLdslObxtpivQe58SR3uqFEuBPhdkhda2TFpcO+cRcsb17omME/8tWL6H+BucnjbgHQYpAuJ3NbS/4Y=
Received: from PH7PR10CA0013.namprd10.prod.outlook.com (2603:10b6:510:23d::9)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:52:33 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::5a) by PH7PR10CA0013.outlook.office365.com
 (2603:10b6:510:23d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:32 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:26 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Joshua Aberback <joshua.aberback@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>
Subject: [PATCH 06/32] drm/amd/display: workaround for oled eDP not lighting
 up on DCN401
Date: Fri, 31 May 2024 12:51:19 -0400
Message-ID: <20240531165145.1874966-7-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: c82db0c5-e201-448c-260a-08dc819210fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FirjUsQvX9P942AypivB37mYN2ZIbFLl0G86dj2sx0RD4v3MEmNZBaCzrvo4?=
 =?us-ascii?Q?1v5x2HWk7/lzY3jOyIZb2Al0iUWgqoKGU0OOK6n2k6kro8zh0jNvzmQBaim1?=
 =?us-ascii?Q?q03zQGoDDNuLB2WWo4JWwHM8iIOH97qUzAaI5o9HbRFeChv3qOmvqnbziYHF?=
 =?us-ascii?Q?eY9mkhvfaIJ8BB4PIhCrTExPZHZS6O5LEttZJ8bBTXXo7d2X7dFSXQVF3B3u?=
 =?us-ascii?Q?1HfcggnL09ue8pIlZSc1+1jlBYSN/AV46yk+4m7jnJF5bdGcSKxKw1Jm/jxL?=
 =?us-ascii?Q?E9TIz5o70uZvfed2YstWsFB8d0qE3+o+Bz4jc1CGzG24tncrOk+PR2o4DWNl?=
 =?us-ascii?Q?GK7fnZzkbNMdUf2qr70xpFPnP74irrustupBDcfiBY9SuVoxo0c0u5KmNDqp?=
 =?us-ascii?Q?+2PcbtrzB0bSmZ+mXS/Uz1TRRL9sSMtjknuEpfTj50ZgwISibfY7ojLR2MSf?=
 =?us-ascii?Q?uHh4P9FTpG4WwPPkPbvkoFa4aS4LBeTccZU7vncWq9/FnmH92VWJ90AbIADY?=
 =?us-ascii?Q?TTZqyTJCL1IboAVJ9nSov8peBk7vkxexiBxKKKtrqyBfAtbyvk/nUbZx1w46?=
 =?us-ascii?Q?sPYbmZ9bjfC9HA9NePwBPhcUGe6vzGBbEZz0WKLEW2cr8Z21sFlgc9U6A4Gc?=
 =?us-ascii?Q?8Y6dyhJ6E2NpCESj0a7hg/KUB/uOqmeXQISzPT+MlYEUEQ9N4J5qPRUsvIIq?=
 =?us-ascii?Q?8au4zcYUzaV0m5UE5xfqbf4D2Oefwl0c0E0HZvu8VHaSZ0DGdyO31HcCAFQE?=
 =?us-ascii?Q?wGPFdNDyveHLWKqj4uCNg3jXtVQ1PNKRsS9uKqDEfM/jdnisTvTEHhw0ptXw?=
 =?us-ascii?Q?0UIcrKz7iM+5jR9hdOxC470sIP9uWX/SlLLfj0mC37wyS7JgzuwC0/y7/Ap2?=
 =?us-ascii?Q?cto5LjUExEh/6domq+CXVo6M41JcDYVVz0o51Yr7IyWzPsP3+pSeBXDxqq/S?=
 =?us-ascii?Q?P3ZregUNFJxsxEwZfJTFIUwuJra7e18LbvKaEqNrOWmJPjy0aYEZQHS2RS6U?=
 =?us-ascii?Q?YC7Aiak1+rzKsOc6rjmvC3KIzeaZzpQhRR8mojKc9QLTe229bN0UwkzSJHjA?=
 =?us-ascii?Q?Q1UecY45OCgvcjdYIRRHjSmzJOSG3OG1xzyKeTHCdC/97lh7K9bsMR1xcaxw?=
 =?us-ascii?Q?BpcLS0NAaGRlGBskOqgVRtrfEyN5K0jlJ1Lp7KtULaI8vECkOZHzICKZ/OYd?=
 =?us-ascii?Q?QzuhnwmfGYsYr9bfGm7rxg7XS4GEFQOyic3LjaqEA9CZ9WI5VHr4VizGZ06C?=
 =?us-ascii?Q?CfY0+823mUF2Qlt0WIs/sBwGZG6UOc74JsFc+7YB8FMVA/3ClNIdox3xOS4S?=
 =?us-ascii?Q?py8WEHaezpKEPvU5AHK2KVzlS6UaHiz8IFFR6/TkmFmkW3zZPy0YsPX8PE6S?=
 =?us-ascii?Q?YNw5Rdk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:32.8867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c82db0c5-e201-448c-260a-08dc819210fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Currently there's an issue on DCN401 that prevents oled eDP panels from
being lit up that is still under investigation. To unblock dev work
while investigating, we can work around the issue by skipping toggling
the enablement of the backlight.

[How]
 - new debug bit that will skip touching backlight enable DPCD for oled

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                            | 1 +
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 +++
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c   | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d0ed01ac460d..a06015165a61 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1042,6 +1042,7 @@ struct dc_debug_options {
 	unsigned int force_easf;
 	unsigned int force_sharpness;
 	unsigned int force_lls;
+	bool edp_oled_no_backlight_enable;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index ad9aca790dd7..89f66d88c3b0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -248,6 +248,9 @@ bool edp_backlight_enable_aux(struct dc_link *link, bool enable)
 		link->connector_signal != SIGNAL_TYPE_DISPLAY_PORT))
 		return false;
 
+	if (link->dc->debug.edp_oled_no_backlight_enable && link->dpcd_sink_ext_caps.bits.oled)
+		return true;
+
 	if (core_link_write_dpcd(link, DP_SOURCE_BACKLIGHT_ENABLE,
 		&backlight_enable, 1) != DC_OK)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 247bac177d1b..92206b69b2f7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -732,6 +732,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 	.force_cositing = CHROMA_COSITING_TOPLEFT + 1,
 	.disable_idle_power_optimizations = true,
+	.edp_oled_no_backlight_enable = true,
 };
 
 static struct dce_aux *dcn401_aux_engine_create(
-- 
2.34.1

