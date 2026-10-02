Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D301CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9091710E6B9;
	Fri,  2 Oct 2026 19:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DvYIllAA";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010042.outbound.protection.outlook.com
 [40.93.198.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FCE510E6AA
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wce7H+wr133PiYqCG6IzUWCq9/AbunXzHjxdLvAcip6Wspzvo5nQ8VBOzTILZP6RAyunAM2OZeY4PGHU3Xe0q3JtcCa4rFVs2jGerUvoUBagfXCDW1dTobUcIwggwqjScitoKVs7mCe8V1m4mX15npcfp4BwBR3qlRn/9hfYSPbfaA+UXo6/QhHzznolIJluHmXYeLZrDQqMUDY5Gx+aZkivOpBlKqxT0ghvDXTv6vLnpGvaKgHAGMvMCbT9XMjuS6FuKB+PFEGg7FL2Z9uHq0sEw+9aL01SneKbeSr2NLUgYyXZSi1Sgo+N00pvfM/3N3rodXvxKE+iv4Apeubn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NalzUUORbPzNfF23CpgS+A4EUQKuiTyliSOiwRohGhk=;
 b=ysXplOSTFFMOGVdXcIFjd7VVMYedlwb8mUfBikVG9zsPTQjXMMQghfE9Z+d0+4XOVtf7vqLpmYYbu04TGpAT9om0AQD2xQVe+4Z512qzzayOb22dS8hzFgA9rYr17pnjfgZP5Y+d/3ix5GQIMJUvrWmLiK8mpOIpiGOWyKb9S69UEn94RQqZ2syNQpGtJkvCeNo/6GND9EjAcSJYtDX7qBUrtOhoTsbx/mpaqHQjBNOIofpGp6smNi8usCmIUafZ1LSvw1MF3Rnacrjvq8iKoUmc978gYg0SMnwMCwWYVG1llovH13j7+0FzhfyrkNGjMQWvnpbtuFRhjN0OO2fEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NalzUUORbPzNfF23CpgS+A4EUQKuiTyliSOiwRohGhk=;
 b=DvYIllAACOl/EVIjUOal6Z17yQZB4gsqaTBUgKohxxI0oiEwhVEBmuBe1IeFSU6Wt39v6uzDEAxFgWUe5mz0v9ZcHrvB2ds4eTxPPdIioBS2DAanc4YDtEuYW3pv5XtbhpDJEU0v+GhYPwiV2V+9vF2MrOxVKgm9+dH4pO7Syv4=
Received: from CH0P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::18)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 19:33:14 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::a4) by CH0P223CA0014.outlook.office365.com
 (2603:10b6:610:116::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:33:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:06 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:05 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Ilya Bakoulin
 <Ilya.Bakoulin@amd.com>, Relja Vojvodic <relja.vojvodic@amd.com>, Chris Park
 <chris.park@amd.com>
Subject: [PATCH 04/17] drm/amd/display: Add HDMI RR and SCDC skips
Date: Fri, 2 Oct 2026 15:32:27 -0400
Message-ID: <20261002193240.3441018-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6c7269-5e0e-4976-c650-08df20bc0083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|3023799007|11063799006|10067099003|5023799004|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: xpb9wHsQBYJcRQmoAhYdlyJqyYCS9njVzVD3XyqnN5BSWNo/kwwNYsToCk4ytJAjHW0dkck4dj28AmhljQIMWCju01sYIaQd/Z50cX8K2rw1esNJBUk2wsBrjp64jpFEuKTQlnuZ6xq1AXWnGLQ/mcMYo788VWBLm3jXW+0c/v2I5KCnPOPAWvZg07WfLHChh7D5qXIgeFCnvWiJrwNc3Wrt1jvN1nkhzSnR4xXlXaCYvNxDlLKzKx6J2V0UTMmKMpcr9LQ77VjgH7vU8DEgydW/64lTE3kShYx3O5lcxw1K9dq32c8LTC7wXdz/5ar1zlMrFhd14MsaGDNQ0qd+WPzQJvX74zKlUFtVSwlkqRcMH1pnOWKI1mPQH41+SHYnwhKXcVNoANtp2jZRHNNmGGZEjIb9zjj3npA953FNLoHxzxXeYopf2v12qWY0r0prih3e+j+vckoF8iAzQVsUI+TDBQyTqEHfeFqmOxCwYrBXjZJm+ny9g1scQQRbKK5w4DM+wRzM3ekvLgplEPX/HEtOY7XxNzNVSC/Yp9U+cgJImOC2Q2xcRfQWQKDpJBnPZApLs4bMtCPSpdiEkjwpLZPy26cpBuQt8Fp+cKBC4Ir6jew78+5NW1yGRPDyT3yASOms/Qft2kK5/Jdmne3K6Gf+jB/Nd2GkkzNGBw1yWXk4W3WtJ5zD1g1OoUZX8XxlnZXNgsvdLwXZ7QmPqGNt8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(3023799007)(11063799006)(10067099003)(5023799004)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3e9sDl/fSbWkxWec5NSsTVe7xDMobrhFP6HdRkqvZcdlKWMJzDqzqNkDZJUQYukmhqHHRuJhsQzMk6j2RRvEFtH/kJ0xLv8CMX+ZqxCyPr14iYEh57bUaRlrYRRfgrYPLU5kFhLU/UVyfWnmxRiu5FOLZ2bfi+zSEGeimnOuByh/PKd7wqhoeFRMQN9HCAFxcmPZYHCXbIy7KvWlpXoI2/N532EvSi0UpBCwM2c6i3y+1qSvG1JMeg0Rs05DkIc8LXUk9r18esqDaNZRhA6fPQTgICTa1CAQzZMBfDMCwocM6sCLnBZoH8hOEWMHZBEexB1rXyTNbJdaCZMLWGh72ooidE/bWega0CJZykM5IQ4X/XDx3rz034j2XucdUd0GVksRKtyweU3FG1NiDDRmH+LQHOeMCH6s/ZSg5czIal/OBJTgcp1l87zx+ZAt/A38
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:14.3908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6c7269-5e0e-4976-c650-08df20bc0083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
- Add debug key to avoid enabling RR by default.
- Skip SCDC access if sink or SCDC cap not present

Reviewed-by: Relja (Reggie) Vojvodic <relja.vojvodic@amd.com>
Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                      | 1 +
 drivers/gpu/drm/amd/display/dc/link/link_detection.c     | 4 +++-
 drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c | 9 ++++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index bed0daeb0c6f..d2256c454424 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1293,6 +1293,7 @@ struct dc_debug_options {
 	union fw_assisted_mclk_switch_version fams_version;
 	union dmub_fams2_global_feature_config fams2_config;
 	bool fams2_imm_restore_drr;
+	bool skip_hdmi_rr_enable;
 	unsigned int force_cositing;
 	unsigned int disable_spl;
 	unsigned int force_easf;
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 12fd4fd24a90..b4546f93af0c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1391,8 +1391,10 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 			read_idcc_data(link->ddc, HDMI_IDCC_SCOPE_RW_CA,
 				link->hdmi_cable_id.raw, 0, 4);
 		}
-		if (sink->edid_caps.rr_capable)
+
+		if (sink->edid_caps.rr_capable && !dc->debug.skip_hdmi_rr_enable)
 			hdmi_frl_write_read_request_enable(link->ddc);
+
 		/* When FreeSync is toggled through OSD,
 		 * we see same EDID no matter what. Check MCCS caps
 		 * to see if we should update FreeSync caps now.
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
index d87f6f377d06..3fbfc6e2594b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
@@ -580,6 +580,9 @@ void write_scdc_data(struct ddc_service *ddc_service,
 	uint8_t write_buffer[2] = {0};
 	/*Lower than 340 Scramble bit from SCDC caps*/
 
+	if (!ddc_service->link->local_sink)
+		return;
+
 	if (ddc_service->link->local_sink &&
 		(ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite ||
 		!ddc_service->link->local_sink->edid_caps.scdc_present))
@@ -617,8 +620,12 @@ void read_scdc_data(struct ddc_service *ddc_service)
 	uint8_t offset = HDMI_SCDC_TMDS_CONFIG;
 	uint8_t tmds_config = 0;
 
+	if (!ddc_service->link->local_sink)
+		return;
+
 	if (ddc_service->link->local_sink &&
-		ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite)
+			(ddc_service->link->local_sink->edid_caps.panel_patch.skip_scdc_overwrite ||
+			!ddc_service->link->local_sink->edid_caps.scdc_present))
 		return;
 
 	link_query_ddc_data(ddc_service, slave_address, &offset,
-- 
2.34.1

