Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BB6E8783D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA91810E6A4;
	Tue,  3 Feb 2026 15:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0nFWqhZN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DEB10E6A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiGofBMvKtNYFdKHJXpq6QGbCuY6oT5N3WTks9lM/t2TLFzsmB6EhpBXZmWYfRkPjqpB8DcC0/WnxV8TL+GmjD6Dj43Ianx9hBfrdp2mei+SRLcX/D/17Pxo5dtopmXj/h6m6tT1V3OYLFvYTmAHhnLnnrmz+L6vKaStdzS/0R739+t1dPtog7gttzBu7xC1YXtTjG4Cgq7QcvvPWyl2fkO0rkTtGNXWF1hpCc7M4R+sffrtLPnN9+0tSFS69nUcx6MvKI12+X7z0xLqX4RJCluxOsJgho/hAXnp5fu5qmgBBnx9okbZMAX5gJx9yXhJjtX4NyAL11eKbQfrSeXp3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4Q0wl1qHj2JAgv/ntY2GyKs+/JLJ7TrA5z8ac3h2mU=;
 b=Tc5nN+y0Nbr0ZZJevXbVpgEM2+O5ZBbPtXZtTbqunIaij9wzGJICGwPGXjuAPRAPFRLnZidPpLPhNnLV6HHiNbydshxf1PGS3wTlGBz2/Mt1sfZWvDWOfL8dLh9OJui7foFcjTdEwD0CvAjt0isExIanlX0xX7lUAEJTPwnKSGiWHLWooYziQuMxndbKVTHVI5fBENchQ/gOKlVlZwzAq59qK/wcDvb4GpmueZc7QaIhFtpK3qEemYSJIWY0rUJaecap6Elei/leHUulul0ko09fkoE3DhnvyzWBK0cdjomRIpKW7pGi/SIJlOpCDoEMHf6ZwP5y8QIiKg4R7jr+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4Q0wl1qHj2JAgv/ntY2GyKs+/JLJ7TrA5z8ac3h2mU=;
 b=0nFWqhZNy0Mmx1Yl+k2bKVEXf+a0G9SZl1DcUOS3soAg/sH1oT/nIofcoFcS5nJpRyck+aHzA8H2ZBruTvPusnnFzzBgq4G0vKPF0Fr80PQ8gLAFNoh9Md/kiKTl3rILq1IH7nfwHL7a9Lpqd2yOSZaUhloiE+Q3sa2T4I5wJ7A=
Received: from SJ0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:2c0::20)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:08 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::f4) by SJ0PR13CA0015.outlook.office365.com
 (2603:10b6:a03:2c0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:12:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:01 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 09:13:01 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:12:57 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Leon Huang <Leon.Huang1@amd.com>, ChunTao Tso
 <chuntao.tso@amd.com>
Subject: [PATCH 02/16] drm/amd/display: Check frame skip capability in Sink
 side
Date: Tue, 3 Feb 2026 23:01:44 +0800
Message-ID: <20260203151229.3673042-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8e7cb9-33ec-4998-a826-08de6336bcbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EZdbykpgtnwIJKAoEEdtERMdRsz2IBK0Mgpp2a3lKroz3erI2c/54eUe6qQs?=
 =?us-ascii?Q?xs0wwLd4YwIThcu6mIggK3AaqcdwncSuUQ0fqjURoznukH3RoyVasISBXDKk?=
 =?us-ascii?Q?TNE6YRCdpF/ess8DRMyP4WWjyCBOfXSF7dDCZ/tJH+oR3LIsb83HuikBuENR?=
 =?us-ascii?Q?9y0qaJ+J7Um0+vzekghyNToZ6EyAXotM+NLlaFPHHjMpNEdjLhTPfGFub1gX?=
 =?us-ascii?Q?d3oz15PomryQdm4E6RPlryU5K5ysT5cg6lJEqnt1EadJYqVuQfiUS5b9qyZ8?=
 =?us-ascii?Q?xJpSKqEQdGm4ATk3euquKY/niL0WYYbrriKXRFbuOJZbKiItNapYuKvuOukl?=
 =?us-ascii?Q?/dlMK/JpoQ54iG/XltlbD4Xc77HtEAtF6jF4FthcH6bCXMfTjCw4RXAZCCyO?=
 =?us-ascii?Q?tq8YYEiKT1GsGvZFNWFZEukkG4htuqEPt4ldUNmp9fruQX6WfaDqVV/0GV+o?=
 =?us-ascii?Q?ceqFVVAFGrF5g4shVK+PV76Mo7SPDgPX8Et/aL+hOfbqQbavbetMgoDQzVkI?=
 =?us-ascii?Q?1zkqqDL8KcGShA4E13vxsPyr6yit4TnqmSpxtXzzOAaMu5p1GTsMiJ1hyLlO?=
 =?us-ascii?Q?da7H/ruJqnZNxxSwM+aXQpg7A+YHq5gzld8Zzw60U/IGsE6vBEgLCXIfikzV?=
 =?us-ascii?Q?4Mxaw1vLII6ulLKXxmDcDDtl7YF9Wu9KWs5n3OdPp6JxdEHKLCg49Bm4AYQr?=
 =?us-ascii?Q?EUQfbHz890LJoKRiigIjxv8ZXqekzpbLtBj23bdlwR0HxXiFQcjxgNr5TPzt?=
 =?us-ascii?Q?BQecWkO0wvAQem3k6p+SZGGMGWx7k+qHCMsSZ9qhTZn3dn6wdqFCIvdSrXPr?=
 =?us-ascii?Q?evgdk4haDZucibj1fuO1rR69TQaB8AOJY4KTQ/ySEGhIqLCjTV1grpLJF2Mk?=
 =?us-ascii?Q?jQr8+86sIxkXHKQ1uHC5mealKwUi/7AY68iGNHFsJFgfh1JqOizlA9PyW/7G?=
 =?us-ascii?Q?6/YXAFnShs8Yl3rFYbw1iExp+0spiRbdl3pZqnQ6k60EFZUBP1j3Ayuw5H/a?=
 =?us-ascii?Q?WDIUJ0xX/hzuZzIMORaJphFq+FpEltElSORU1XDRq8yFugso4iWQos1Byu1p?=
 =?us-ascii?Q?SL7XPoBJUQx93h/j7i5/wSG2d2dJmXzSiwWnI5uDIW0yS+etcDva8xRn9Lt2?=
 =?us-ascii?Q?ETiUSrtGroLnRy2cR+z9xbzO9P5ok2SfLVlOEhJHLlXcfQ8cYCYn0UQkJPpf?=
 =?us-ascii?Q?B1SHMjS41iBFrauHEuyyX2uC0tPtlV5VwdD+dKGQ9OOQRFpUxsJO1qVqz06o?=
 =?us-ascii?Q?pZRtIbpbGulwqvj19gBiXnqfeXB7hkOBD2Pkmp/9kqXAE9ajvD7auGZbSm/Q?=
 =?us-ascii?Q?1u6MADZnC9kMHMRg1kgiN9M11i4c6hnLb8UfbCWH7n1YZMYMX2pJRRD6YkYM?=
 =?us-ascii?Q?g7tKNS9s1RwNm+A0exNl7kmdywHcV4OhbKM0owgz7R7I4PEh8IBPZOzpDtKC?=
 =?us-ascii?Q?XF2gfAb2XsnKgygdCAzAcZImBQSs6Z9ouN0VOO/znwIkR0p+1NgczWQD9mdR?=
 =?us-ascii?Q?P5kfQjmPL8uqYyYMrFM0vdQdvW8AYnCIOyoXceU6Xq9TsbBRNiBmEv5j2+xr?=
 =?us-ascii?Q?9+7TtjnCzCrnmOfUUbmsQMwFDOX2UUss7OpzQFSbcOHqzQSH7G4nDCkBUDTB?=
 =?us-ascii?Q?dau6Tus5t7ViBQYZgxhFUhyV1Begv511HWRKdMBW2ckcMUFxm4INqfcgeLez?=
 =?us-ascii?Q?ZPgQbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wdpfKel/a/suNLllPOMXXmE2xjxniT1xRNgXniDOfI7BKCs2ZzQRyY6eLqYcyNliAIBJkvLmRioWP9La58sGzZpJqA7nDR/mSdgJQTrqOj+oPLsp7Hisb/v/SjDCA8p9+S/PHCBLA1Fs/66aqRD4rh33JrEaCUTSUNfeOrHEGTQ+ZWrK7Q4VySgQccaEkEo9NvgSSFDpAspbxcjyQdLUbRsQq+LYwx9UgqsuTJpCsw4KUSCPJthLTqxlKopW6rgYqJGcgFvyaNCAmCoiot0JlmGabIAcquSsHrSfPEZG4ZfEZPfyaMnrUEoQAsIb3fGqQWK5967mapIYYUjZM/kmC4iNbJ5Xlo7NNdNKgNe21tlcZZyDFlPDbEfEZIjdjranAphDP2OIZTLFEVqlqBHsxmInsrUewg3TKNa4czBxMmDJa0Dh4snnasjjLzGFUZ7b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:07.7642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8e7cb9-33ec-4998-a826-08de6336bcbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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

From: Leon Huang <Leon.Huang1@amd.com>

[Why&How]
Frame skip capability is described in AMD VSDB in EDID.
Need to retrieve the cap and determine fr.skipping mode enablement

Reviewed-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../display/dc/link/protocols/link_dp_panel_replay.c   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
index cc3b44cf7662..4a9e86d32dbb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_panel_replay.c
@@ -34,6 +34,7 @@
 	link->ctx->logger
 
 #define DP_SINK_PR_ENABLE_AND_CONFIGURATION		0x37B
+#define DP_SINK_ENABLE_FRAME_SKIPPING_MODE_SHIFT	(5)
 
 static unsigned int dp_pr_calc_num_static_frames(unsigned int vsync_rate_hz)
 {
@@ -89,6 +90,7 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 	union panel_replay_enable_and_configuration_2 pr_config_2 = { 0 };
 
 	union dpcd_alpm_configuration alpm_config;
+	uint8_t data = 0;
 
 	replay_context.controllerId = CONTROLLER_ID_UNDEFINED;
 
@@ -186,6 +188,14 @@ static bool dp_setup_panel_replay(struct dc_link *link, const struct dc_stream_s
 			DP_RECEIVER_ALPM_CONFIG,
 			&alpm_config.raw,
 			sizeof(alpm_config.raw));
+
+		//Enable frame skipping
+		if (link->replay_settings.config.frame_skip_supported)
+			data = data | (1 << DP_SINK_ENABLE_FRAME_SKIPPING_MODE_SHIFT);
+
+		dm_helpers_dp_write_dpcd(link->ctx, link,
+			DP_SINK_PR_ENABLE_AND_CONFIGURATION,
+			(uint8_t *)&(data), sizeof(uint8_t));
 	}
 
 	return true;
-- 
2.43.0

