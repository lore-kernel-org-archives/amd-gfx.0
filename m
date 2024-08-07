Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9A8C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F69F10E44C;
	Wed,  7 Aug 2024 07:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TzA8suDK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666A210E44C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpu9u8WFPYuulIf/bpNiXog9naVMfNviD2SZvevsmjvbsyDg0urP2Si9EZyzpYmmMa1SXUiOUHZ8XEUuUnGnyscdIAyMTEcBX2iaUHVWg9tVK+sOrmHuWqGJUPs8ERTNc1aFNmVaZTt/f2vrT2eGt2o5rOpDzHONPX7cr0X4lQkp7SAeBPVPOFDHZjOn6Vu9O0lTWg4/Wra7spNwL32wpHSci3fG8WoaWcTQFFhC07/HXVL/+CIKJ9QwZ2oziRy698Z5wcjyEJy6UST13lU4+4L3YDPLKtWZMCiGIVILk6FkZf6Bq0VDaIe0fxV3ojcxHKaiHEjxeyEwuk0bqo0rGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcjDPAO5bMuaCTV2pc1ToEcdwtWsywI4BCLYJHmfPcc=;
 b=PE2vByLtyq77mXSDXQPu/0l4kJCQB0IPwwIgX3s+QZglZErWh0duyyGHW+3UXbM/fIKgZhvSF+Qs4XRTsBIiP5D/M4lL+8oTka6HimdB2Hp16xJgPrw5JVgk4XEFU/lyD8vHYncP10FswMhJKMgOYOkLv5GFEWyFfscmTWlJL/FrhWtghx6or8o6xypADAwAV/gZ3ux/MFl4o/oHkNocRpn30mTqGC1iqn51hhVoSMkwxyKc0nUijVbg+m6sVTwadTLw2hwFw/oyJeCYY5K7zN5qGzbbSOB3H6loOTZCoMOtiq2DwixvYaUTTccIxu9GGyzYwf6YurfRzYMz7mN7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcjDPAO5bMuaCTV2pc1ToEcdwtWsywI4BCLYJHmfPcc=;
 b=TzA8suDKxHmRw3kyB6DLpnD4DEqFBDKa+mx3wB3s87vVxjL0xspRDduMqpitN5r1Q73cTKfzcrNApm/TZ8osYFJ+KH7gB9vhqd5RC8bgMNIgEO4r+ioL46kllX1WXb7vdYSiahCmMas9Asn3Zcko/9MVK/HIFVqqEFCdVcYnLvM=
Received: from BLAP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::7)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 07:57:24 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::32) by BLAP220CA0002.outlook.office365.com
 (2603:10b6:208:32c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:23 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:21 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 20/24] drm/amd/display: Improve FAM control for DCN401
Date: Wed, 7 Aug 2024 15:55:42 +0800
Message-ID: <20240807075546.831208-21-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e36c031-c8f0-4bbb-e968-08dcb6b692fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RGDrAKI7qDlOgG0FEbyEvO6QwhzGFeBHQcOikIXo1zAw0ij4ZQs6lOz1k7BZ?=
 =?us-ascii?Q?hAk0WQjpmGjgjzFFy1XSoEk+v5IChtTmkER3VJhzmQF1I4BsTGKkB0KN2qpa?=
 =?us-ascii?Q?NzAae/mskvO/day2j7EkYiYQQ706M3dM6+o6iMqm2bg2ZWVl07QTXYKQBJd5?=
 =?us-ascii?Q?kfVPU8LImuf5YQ1Dh/AmLmyNlc59omQJqyRUxwew2jKvHdkCwzDrKHIuQRsr?=
 =?us-ascii?Q?oYgAw4hd6PwTvApGWlIRZi3H7vFbJuQgMvNrwai5sP5Lb9MOVfNvSZTv0k2v?=
 =?us-ascii?Q?aSOQKsPWjLUeX96A7Ku+6UkYx7j96yKGE+6dQWva0h4xbMRIqe7Skt2FVvrq?=
 =?us-ascii?Q?w3LVO4g2SlSNhqztA+L5OhcJDiV9xE2mQkZ5eOe1qzsy2lJKDrbHTRuWfIDq?=
 =?us-ascii?Q?pUXNLssDXR6vB4iTu9yaR7xqOXzww4GeW3lhGxdQDDwBq+EXDRo1woka8jeZ?=
 =?us-ascii?Q?02fUDwGW9yLSTH0wVWqCz3wLxkafYlpI38ofuA9pahJB8pfxl1Cmv91bU9BG?=
 =?us-ascii?Q?lyyzXp6+oobKNTUXXEzsy4U4RFmUy5Bk7PFOAKI9QSr1ohFO5VjaeU33OslY?=
 =?us-ascii?Q?7k0N+0ip+z90pTSJEHgVWgZ+TCg824PnKbDvUnXG2f79cJ1AaAkkqFyxlq+f?=
 =?us-ascii?Q?0Ucj4lORpOExZOCW7/Z3ZEAZdpI+XZCaF+FSJ5QKr5pX8PjM/EKg4QxgpNEE?=
 =?us-ascii?Q?gOSNdpeD14fyP3/PMfzkdvZ2nB9Q5GP9L/FI8hWwB3U4zBzDYLxVZxkJgvWe?=
 =?us-ascii?Q?gFVl+RwUXJ0uZZa8XCNmLDckka/oBdeJ+Cf05LwL84hBiTDbDsgx/PsluofG?=
 =?us-ascii?Q?RtL0R8MMk1WSNHZs3SmkgmV1lWoutXaYgRN5rQ9SAfgROhxrNxDaZ/lAAH0O?=
 =?us-ascii?Q?p6IZW9/U0ixzt2xL8oy+DE67LL03bdtjkLWZUv0iZDPRKoHFrZGqPgKhW+7G?=
 =?us-ascii?Q?IqbfjVER7OSDN1lN09qLZAV0QTagczJHL6KKpvQRowOmOwZe2vVTP3mZ6Z31?=
 =?us-ascii?Q?cEsnII0kLNFqYtGQu9yuRj6sUHQZYr8qpR7bzpGC7aLYZcQDlA4VilL5cIYV?=
 =?us-ascii?Q?m7RI70KWhV1xji1Fo/qvbMDSqu4tjudIEkmPTXCAcbYrZ2Hpmkrd6Nu4KIAB?=
 =?us-ascii?Q?LO4kW0xHS4hSgRP0RJTpIIgHbZilKnXVjnVoxFgM3ovo0mjuhVo/5GpV158X?=
 =?us-ascii?Q?0eDBPv2BD7KP+/7RgANqTq2+NhauVnjtFJ2cdUwTUEekB7BF3G7lU9l6NvgO?=
 =?us-ascii?Q?Pctgw3wOQlcvV2Nkdwn0FD38rqvuFitz/DnXAdaPcVhSnHxzDX8FVyGjhbfR?=
 =?us-ascii?Q?o4udtTOsCoacegXZly0HeSV/GzwAocAV9WBKnWGIo/d2xGl2kZdjIkbBapdF?=
 =?us-ascii?Q?fjw3ni/t3pi1ouFF7lVyqd5Ug4o1A6F96ovFhsHKl2w1S+wwQq5udQHNroqP?=
 =?us-ascii?Q?yerN6TJ0Fa/GteOolFBgYBWdD+NSH24j?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:24.5428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e36c031-c8f0-4bbb-e968-08dcb6b692fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[why & how]
When the commit 32caf32d5b06 ("drm/amd/display: Add driver support for
future FAMS versions") was introduced, it missed some of the FAM2 code.
This commit introduces the code that control the FAM enable and disable.

Fixes: 32caf32d5b06 ("drm/amd/display: Add driver support for future FAMS versions")
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 6a40b2e2beb5..a36e11606f90 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -985,8 +985,19 @@ void dcn32_init_hw(struct dc *dc)
 		dc->caps.dmub_caps.gecc_enable = dc->ctx->dmub_srv->dmub->feature_caps.gecc_enable;
 		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
 
-		if (dc->ctx->dmub_srv->dmub->fw_version <
+		/* for DCN401 testing only */
+		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
+		if (dc->caps.dmub_caps.fams_ver == 2) {
+			/* FAMS2 is enabled */
+			dc->debug.fams2_config.bits.enable &= true;
+		} else if (dc->ctx->dmub_srv->dmub->fw_version <
 				DMUB_FW_VERSION(7, 0, 35)) {
+			/* FAMS2 is disabled */
+			dc->debug.fams2_config.bits.enable = false;
+			if (dc->debug.using_dml2 && dc->res_pool->funcs->update_bw_bounding_box) {
+				/* update bounding box if FAMS2 disabled */
+				dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
+			}
 			dc->debug.force_disable_subvp = true;
 			dc->debug.disable_fpo_optimizations = true;
 		}
-- 
2.34.1

