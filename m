Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95168C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AFB10EAC9;
	Thu,  6 Jun 2024 21:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iHmsKgS9";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8875210EAC1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofHcOZ7uUGGXQou2OX/qhbKcgyVBTqpX6kjZfHw5DSWq9etmOdh4+ZMDwA7o3WHJc0fWhJHsIsvLFJng206rJRh8Lwn7rRejdFc9yEufxOuZOWlzga9LiiqG2QHcvdYv0sWvWJ2Tfl//QuTGj93ndUn7+hDCK6S/SfJvUNhDTfIE/Vu19mxUbShI9JrmZe9agDWvxuwPEnQBJTIjBWfzm76pgeu3aPArig+Bglw+V4ANYtgEbsTd2M4lFRyZOi5sc+36NVU/9GzcNFq+BXPzQsZTZ66uBsfXo5HLLIaaZSEczIxB9dAjnIsK0mcUHdPYPgENExSYvwSh926I79QXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXNnAxAoy0xceKizyRbhJPoSduDBxagw9NgZkLbLg8Q=;
 b=LJN6Wfy2Nc4hX8kIjnJ7qHcYt5HmReKbFRULrSRIxEP+VWhCyBEzTrAX/hmjJyDWNcuFdt3BGEbIpR61DnZSgEGKV0FTvMik2e6FuCX7PqbDJTR6Vj67dN4+yZM/+EwFw5d4pjv4rGt7zJJuHdhm/koPlc8YPHkvAQLU4+IGgGWSUdTBI0cO2qE9p0o0ywkiBNvYRp0+V+fZexP1sygrfrsS6Pkhs6fmFzjUMv2+lzeIPSueTC8zhoBGBrmzHkygUESLLqcM9RU0mkYYa7+zyixleBECXQXPzSB7Hd0gB5YVb776ev1Qy9tHYlqJpDnJGma2vftQKQVBcOY+Xt/Qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXNnAxAoy0xceKizyRbhJPoSduDBxagw9NgZkLbLg8Q=;
 b=iHmsKgS9HmUJylnWVR7fIaXgHTvNuKjPdqA8q2/kLs3gI9TZ1a3jJq5TML1dJ3NLmh4XiEYgv56se0iN3lesAJx84nPwXQWcWzw5b/RgjLfWDtMLda0LfuyHJhjUl+8SxLtgWg46+ISyZju8PZyMWwE/PncjlYiAUt7JVTdulxQ=
Received: from MN2PR15CA0039.namprd15.prod.outlook.com (2603:10b6:208:237::8)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:56:57 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::ce) by MN2PR15CA0039.outlook.office365.com
 (2603:10b6:208:237::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:56:56 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:56:55 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, ChunTao Tso <ChunTao.Tso@amd.com>
Subject: [PATCH 04/67] drm/amd/display: Replay + IPS + ABM in Full Screen VPB
Date: Thu, 6 Jun 2024 17:55:29 -0400
Message-ID: <20240606215632.4061204-5-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef0e3d4-96c6-490b-340e-08dc867395ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Zzh1K5LtikD2j3sxNq5KI80twUxi8dU55//sMb6g5WyFRMt6ivRAM98f9wH?=
 =?us-ascii?Q?C+3JiK8bzOzX3aTTOoL7S+NBuuNe77u/I/zXJpPew19DjuPkI7ynPHgLGcEc?=
 =?us-ascii?Q?4fHCzz4rrk/K7uGTYL2c8ZoLAWTIcBgyIfek+vAaUxrrZKFLj/sem0EDmtit?=
 =?us-ascii?Q?aB99yQdSN4RbkpBi00JEXw4HPLb2md4wAjbMd8Xh8prLEUf669MTO2MQz16u?=
 =?us-ascii?Q?E4BNclVWfRbHyYkh3CgyXp8IpQUdNiXKwhKQVqbFrsizD0H1xYDSHO9YY2Kk?=
 =?us-ascii?Q?PgcOm8hwGFDk91uq7FOhvzURXSJPQQH1SchdiHtwPycOr7asC/d7U+6x3L9W?=
 =?us-ascii?Q?8A27MTNUmHsxL/OGzJNkzDhKy5HMuMqsY1dGpiaxmbjrkdcBfBVhBVD+a5O8?=
 =?us-ascii?Q?SfRTwOKFsBNcxHPye8ZpXF42ENmm8VctNlMWcPF0B+fMxiuKPIRstAArg+wZ?=
 =?us-ascii?Q?+lYjWLP0ickb0B3r0bc9QsVVmC19C4YEslYYFnISXBYRgBy2o2aBMX0qFoIL?=
 =?us-ascii?Q?usnzxthxaA5VJFK1S7x/WKCZfLitxN2uCgNuzMOfrT2T7WJaoV2qnTdkYDSW?=
 =?us-ascii?Q?Y8NT8U1cuXWQARrA7L+eVhMP0AgldpbcKA/BQp3ohMkVKOzimcJ7D3eZaTLV?=
 =?us-ascii?Q?r9v+5qt2QoaoNh7Q22j2uwLAEWbjs3rethm6bUaNED7AiO+l2YYUjLZAB+Zc?=
 =?us-ascii?Q?TfbcXWrvU/l995JUSz3am5izwu4WpXVjpfNo9N2SaReXXVYA09K6ynxaZ51y?=
 =?us-ascii?Q?fecHMQf0BAzljcO4AGEdBAxWvnraDlxQkumNtYKckkZx2EwRYmFNJboiCfqY?=
 =?us-ascii?Q?HP3Y13dFGtMX7ZKkjd6xA66w0pKBVnhA7ouAcueM1w7gaf7DQwAK9CeCX06E?=
 =?us-ascii?Q?qeOjN1Er7bS0azxtKjwwlUM0SIjQY+rYxBsYcfCGTgsrrNCHVcXz1XPOFy0r?=
 =?us-ascii?Q?zr+4d7yt9iAfITjsqbdzm41PAcCeSg/zSirjMefK/zMVTX8gB1FXCIgpclcc?=
 =?us-ascii?Q?9RNJ4s1lVw1hiY0ykYeXcp07PLKkghsJYaEPcHcy8nzxGIySwFlFsXpbsPFz?=
 =?us-ascii?Q?iMUc48aUJ1Ub2Zk5o3OOe5BTGzmin9RjE8ZQ2XR6jAvia1Mwsexyrw96LQWL?=
 =?us-ascii?Q?XH5k7WQ65FHqYhZsH2mRl9ODq4HlgYLFdqA7Xj+4GkQtdkI78z5ye+0LX4o2?=
 =?us-ascii?Q?7vz2w0QC2ICDRFw12QOFqKJB6vnL5YQCwurnE4IhepDVt51Z0L1AsJByfFbp?=
 =?us-ascii?Q?q8fNHbSm4LDFKxoZgFhpSoWKscWhl5Uu0j4JvZudohfWvNosHJYeYd7eWNj6?=
 =?us-ascii?Q?5syGlHKJvymSewWBI2ReAjxX4euc3gRA0pe4RVY/UoIODQZp7Jwv00KiE5n9?=
 =?us-ascii?Q?t9XNTqfgPKmVuWDfAdW6ODC7IxabcBnEUmgVLW+dM8qXmIpmyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:56:56.9594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef0e3d4-96c6-490b-340e-08dc867395ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375
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

From: ChunTao Tso <ChunTao.Tso@amd.com>

[Why]
Because ABM will wait VStart to start getting histogram data, it will
cause we can't enter IPS while full screnn video playing.

[How]
Modify the panel refresh rate to the maximun multiple of current refresh
rate

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: ChunTao Tso <ChunTao.Tso@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index be27ab7ef2da..958a927d0cea 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -350,6 +350,18 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_set_frameupdate_timer.data.frameupdate_count =
 						cmd_element->timer_data.frameupdate_count;
 		break;
+	case Replay_Set_Pseudo_VTotal:
+		//Header
+		cmd.replay_set_pseudo_vtotal.header.sub_type =
+			DMUB_CMD__REPLAY_SET_PSEUDO_VTOTAL;
+		cmd.replay_set_pseudo_vtotal.header.payload_bytes =
+			sizeof(struct dmub_rb_cmd_replay_set_pseudo_vtotal);
+		//Cmd Body
+		cmd.replay_set_pseudo_vtotal.data.panel_inst =
+			cmd_element->pseudo_vtotal_data.panel_inst;
+		cmd.replay_set_pseudo_vtotal.data.vtotal =
+			cmd_element->pseudo_vtotal_data.vtotal;
+		break;
 	case Replay_Msg_Not_Support:
 	default:
 		return;
-- 
2.34.1

