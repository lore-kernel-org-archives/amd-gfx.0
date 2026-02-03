Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29BEE8783F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE4410E6A1;
	Tue,  3 Feb 2026 15:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nyk3UrKa";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A753110E340
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUxDqhb2cft/IWuYMwFJ+oskYCvKO82L2y6enmAGWfgNqwo0NqSnB5tMgJ8+K49nm2R6p3ilDLvUY0alfJmTyOeUk55yEmWkXeyfwh3VY/I+KBg+JHBMswKf3A2aVw2KRqRfxcWErawUVOXlzXfh863YXLMH7XLv85+yi/6k3Vi8zvGqnHlNwIUtNQui59jGmgURis2vhe3e+eBZ0qT6x9Sp4rbPVjPHzS6zqh8vLe4pGT6BrnwHzJaexifLAB3n+AJvioH9I/syCu+eUKIHrxgHa6FM4SDtjiQuEY9QoYtn+VI+YV4WcD78SBIGMFJ9EitWBzHrvW9M3K8VeJ9krA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yXgwiZ7ctEzF/jEybCoVWgdZ1gaRusaNyiYQe8mn6Q=;
 b=GWpR9SV8SjXO4+IjTJM1BWix8esQOhHTMN6ZlSoPV8NvSqLK7vb/rdrm81BkPzXqDU4iYujlOCSojqK7TZo5JTu1dvBBOgttRebVjkn2RjIikNMCetzr8BXHoUO9BgVnWIdhAfz+XhrAxCol/v8MikaeXYQXPzp1k7M6z7dflU2YUQCbJSY0P/U4kanmO+TlNmDRFu0tlhLN/591FyrxiB9n3Cf9SN1j32XzOnfByNvhp5RMq3p5jp31Dbf9O5NkKDU0L0IB919l/tcmpOerTowDk9jfKVDRXscOQ0wbVq3zOZJr7MjfTY/B3VHNOSHE+0S5OiGRnPCau3pq2ZVRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yXgwiZ7ctEzF/jEybCoVWgdZ1gaRusaNyiYQe8mn6Q=;
 b=nyk3UrKaTIgTMMSnmTWlZBYQDNqtpO81FcCkFDpChtsGfHFEAGIKNGrPmeFS31y76zsy2PqGUe2SfVjOwgV2WtZ8L/6aor/gnL3SjCYX6WNNiCvLUGKYAogZJknS+7LrG07Iv5exE6hNxoVEoFCtMUKaNTWy7g9yVrD6OpRCIeE=
Received: from BYAPR11CA0100.namprd11.prod.outlook.com (2603:10b6:a03:f4::41)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:25 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::5) by BYAPR11CA0100.outlook.office365.com
 (2603:10b6:a03:f4::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:11 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:11 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:08 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Peichen Huang <PeiChen.Huang@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 05/16] drm/amd/display: use enum value for panel replay setting
Date: Tue, 3 Feb 2026 23:01:47 +0800
Message-ID: <20260203151229.3673042-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a594dd-b1e6-47e2-0dc6-08de6336c6dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y8pZSeflLp2u63vnd6IabzhKlQwzTNuq0Sd7EqRIjG7JcCcUaB9XEkW0Wkf4?=
 =?us-ascii?Q?Z4a1zwLCztX/Ftpf40wrR8KFM2peEawrstdaN4R0CvP7m1JwZHDTiloRSW8P?=
 =?us-ascii?Q?KEJDp50lFP4PgiMEqWxdRbShbcjEITxEFvVEgwWA9uWftJE4Xyif8ji1GnSS?=
 =?us-ascii?Q?8M+9SshoBLto5GohTz1dNNH+0OR3emyMwCFQdGVWvFKjbcfRNoeW3cE+0SXX?=
 =?us-ascii?Q?+jGJHxZ2k8X64B/tv+EOPNeJYBshKoUi32Vpucm38RukDhH7iDemjfBusagp?=
 =?us-ascii?Q?sH+ms8jKmFHpYTTZ9P4tciz2l0QkPDiDc8awdSyLmcg43phk9DA2wE8NO9rr?=
 =?us-ascii?Q?C6IY6E350o3cTOKgjzQgcCUS5fnYOE7td/UphieT9A9Kdbl/eJ5RHN1LcqAy?=
 =?us-ascii?Q?EQOgEZjmXD8ed3fwZHJ1wBbVzTOZbKhHUaEBhTbT1aySWpfUTGA5ETc7gmlL?=
 =?us-ascii?Q?miW57/dPQ49DgbhcCcKfUmm8Wu2hiXFfWQY5C/P8uNblvIjn6X8sbYwiKZBh?=
 =?us-ascii?Q?WansCqHhqDj2RfR6Z4CythVvFzmXgmaI9CsnJezWUdLl70Kk+fiyS2Yuh4DW?=
 =?us-ascii?Q?P0UhcDEiT/7q7qxOwfBg5h7zXN1nN1ocL5PXbDBlZKQnDXob0lhLGyM8TRkn?=
 =?us-ascii?Q?psE3jHo9KpVEWG7roHfqa//ugQxQuHg0GYz3YHvuzYs7hvP22PJegaqHyc23?=
 =?us-ascii?Q?rDZlsiZQvlPK4OuQT+98/muwCYZUz1aN8n8BXQ/WQx9ACNfW4GMZdfRhbB/C?=
 =?us-ascii?Q?Vft67//d7ZA2r7HwFxpeyLJEpwtwLF2xQAENLXknTZLRzO5rqA5uxyRy7RAT?=
 =?us-ascii?Q?XRx0vaDrcVZ3UWFRv2v5vysU1FoRTHEvqEDYoUXfvlQLFE+5vHs+X1DAevWl?=
 =?us-ascii?Q?l3ZcBKJHM1RtaZ+jPAfOKz9fr46OfoeLdFXMLmENVaZIYlaTy7zMeTJrl6F6?=
 =?us-ascii?Q?2Dz2AR03LZcTY3TduRc99PyhuyYX0zNzniHqnRbB58x0SyXbqRZGLenwzCay?=
 =?us-ascii?Q?5yaGZ0zZxarVCsVjuZZsomW+mnBf0XGVLclYRW8BHrN1qAkThtetzxhtPc3U?=
 =?us-ascii?Q?Xk7BHs+zEtp2sFJ7g1WIvOBG9OwcaK3Fkxs7r4c0pHS7NfmqEzmqVUtlCB1J?=
 =?us-ascii?Q?ARVBCPtyyAH6XunoFPmgKPK/K2XFNQBh0Pi73qNr3W91ViPIIqBJe/k9+YTr?=
 =?us-ascii?Q?IW5fSMPkbeH3/xs8jlj5IP/dvGq0Ii+spE5lN//+8r+14eZ/Rhr6RDpf1PKb?=
 =?us-ascii?Q?OEUsuBEbBNo5aHtSVOAg7WgK8ZDVE9aIdstpLgKo107ZhK+sy6LYgBvus2Sy?=
 =?us-ascii?Q?cOcjrNmU0Cx0lz69Z5RvONFSzqBgMi7mqULVfZ4gM9YO4Ae52E9PT7hovEMH?=
 =?us-ascii?Q?mU+yS3qEliae+/I4XgyoFd8v4+kLJkTvjwHrlhqt7EeJkTq8GmoB2sYsx7+N?=
 =?us-ascii?Q?pd8EEPE1EYlu7rGILcZnvNx8fp6lMuFI/msqMb/VzfXvFGEGH3FFnXAWy+eX?=
 =?us-ascii?Q?0np/1avCMOSoUs0gvvZnTpwF7hyoX2pfByJBfB+YJD7xocnM7YiRNAWqDIaP?=
 =?us-ascii?Q?HDnBvDVGMTP5zE50+84kJ4iR3SvEVPh2j32F+3NTQdqvkPN5fo3PD0lvRaa/?=
 =?us-ascii?Q?rPNeErb5DFejDcN+f+Na7RpjN51t2gewyPCxRt2RlVCpG0CPFEg3zmJOrcrY?=
 =?us-ascii?Q?W1KezA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RjdnOBgonPzo7QU0M9v+Td2UDUh1gmtOpeFtyCr5FPCk0qycbxYACQAc5kJsmN0Q8Clq11p2iRgiYbPw9amu3MW07k1YOm43WEAZQ3BMh4N+I3t3+Jbxi4SJsHxySE4yUFuonkdOMG6WWyQ1g1CB3eE5V/KVrA+/IpXhtVqGKropZW2Ft+35CU6BzA4QfCHuemFhl7CFBXIYCLmX6hEwNAvmQAvG8xPoLuoPr46iEQMYKEFzIjv0gS7nQ7YbOWP3wCilfmL6m41bgYwASElHMVls6ADPHnqpp3mw/F2c6tqKNY3BdXDNTK577vN/SyktGBVCRr8FT9pdv+AVEWnW3HnBdpUtfd6VDY+JjnalEWTnWFO6VfxkVrHq57aIZvK1b2mntwFdyN4G9tIOU+LOIxViZBnS4W/I0y5rCv+ALQQKoWIfuEjP1jcz8uzjckhB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:24.7783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a594dd-b1e6-47e2-0dc6-08de6336c6dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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

From: Peichen Huang <PeiChen.Huang@amd.com>

[WHY & HOW]
use enum value for Panel Replay setting.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Peichen Huang <PeiChen.Huang@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_panel_replay.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index 4a9e86d32dbb..7e45d1e767bb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -333,10 +333,10 @@ bool dp_pr_copy_settings(struct dc_link *link, struct replay_context *replay_con
 			pipe_ctx->stream->timing.dsc_cfg.num_slices_v;
 
 	if (dc_is_embedded_signal(link->connector_signal))
-		cmd.pr_copy_settings.data.main_link_activity_option = 0x03;//OPTION_1C;
+		cmd.pr_copy_settings.data.main_link_activity_option = OPTION_1C;
 	else
 		// For external DP, use option 1-A
-		cmd.pr_copy_settings.data.main_link_activity_option = 0x01;//OPTION_1A;
+		cmd.pr_copy_settings.data.main_link_activity_option = OPTION_1A;
 
 	dc_wake_and_execute_dmub_cmd(dc->ctx, &cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	return true;
-- 
2.43.0

