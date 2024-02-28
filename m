Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBD6C5478C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E54710E468;
	Wed, 28 Feb 2024 18:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVLlc5a4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8188A10E468
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCQQM8nLh2eccQx0fi3sZmYdQStnd6mLZ+WVyqjIs55phV3UPvJdOVPIhaK468iBF84682fJyIdrx6qpuBn/WCeDgFZ7c6Tuf4aLBn3vJC54mpOWMQzKwbPbWx9Pdr/Yfw4MV3SXOo4b7IXS4uZPDM4kkRhr6UaO9LwcZMOrXjpeZnOataiefNZ2HcHxqxk3rGClPtec3TLzqFCjf925AqBEeEzjgCBP3MxwLNdksf0zgyiIc17wPkcWxexAVLkLgrTQP3KJtCuBUu1qOWLOTT68rpC0rE9gAcA44xhUMcjj0nC809qBs67n2BN3SVqex068/ioGKXJ749rxsEraqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXTh6pHbJxPT970tFl9BEaXVHfIToPqCe9EtIzuR6k4=;
 b=GHC8NiLW6e3RI0Ty2ikA+udzQP1kO5FTPu57BgiGTy9HZZ6VEFry33f71bBYfthmUuZwU8nZ3GkumrBs6Dx8hAjAWrv4S0SHbx5aXW3mc+mw3x8GRDesLco1I2rJ3f6NIgdEYa5+HRa1r657u2Ov5xGR/0B5VhpZ5uQzLWeozsMcxUhptcyXc8dzwrPe4kkQO39LmzKKj2mlvXNabhHoQvxZF6y/D5kedyJkvwBlroWbb0m68YBX4V2QTsIbcWRIfKNKB2eQtugpDO0MTn1uKxqvI8v+5r6BtxO3HHbRrZ4RkCC5Jrt+Zx+JIGNyhE/IheHVLri3GvLLuxXFrLKIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXTh6pHbJxPT970tFl9BEaXVHfIToPqCe9EtIzuR6k4=;
 b=zVLlc5a4JIuMRxiuK0AwVXvNrT1TDbmD4bcsUJaab2oKbCk7mfhBVhnMDhige5BKovCp2ujxoh4gRwBlVZpxe3nikGELZRYE1/f5Th08LHKnYb45yb2NWRwIfZH5JGPr5jdVPPK8N1TpK8GffJkbNGA+ZeVWLQUGEmmaHk2hBi4=
Received: from CYXPR02CA0071.namprd02.prod.outlook.com (2603:10b6:930:cd::26)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 18:42:35 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::5c) by CYXPR02CA0071.outlook.office365.com
 (2603:10b6:930:cd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:42:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:42:35 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:42:32 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Josip Pavic
 <josip.pavic@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, Anthony Koo
 <anthony.koo@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 08/34] drm/amd/display: Allow dirty rects to be sent to dmub
 when abm is active
Date: Wed, 28 Feb 2024 11:39:14 -0700
Message-ID: <20240228183940.1883742-9-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|BN9PR12MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9777b8-9687-455f-52bc-08dc388d07dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKUlbGzuCJQp6jKdBaWHwmWjRDqmnNLrBfbb9OdnzYAM1YZn44l+d+P3J9k5pe/olYBL/bT8bTYaVaB+S9yFMKtAy2jdNEkjxiPXC7Y1gyq1rf4bfPTco4JGLcfFyZxerRtgg3ASEGQEJjPDb20o5pNiH7XYT68FGuP0ZGfnvEXocUatZB9S3m4+eOjaP+ws5ZpOXenkUq+9UqScN8JDVs0qqs6ZvuGMrXVInt8trut8Wo06G6zwel+SVD9KhvXqMfZYnvurjpRuah7vxMYRUViuwSZ8R4tRKWKA/6/6HeSCh3sse4T1d5mbStScbQgj00Wh7EldFcKV1TMSBDyCIT+zGe0/kIk+TiOyKR2utAWuEHi1r0jZYrObGZaYF3S1gN9dlZCMQmHxKzCqmfyN5oSMbGeg2jDlfu06mHbAp/OBHSMnf/riCJufT4NrBZDmKSWRE/5EW4QzigbORYq9wpWjalLIa2iq3pfEs1zFVxhXURyHVv9b3B6Z2+wVe7Avc7N+n3YD4YMYGyKs6YUj5U6RWHlKmExPLhPjUGTW/mgA1UGge7zxiJOlT2xQQi3VHCi7oWOyNT6+LycCyIEx/SlVrngV+MPscvpcBq72fnchUcIAsxNAMZizk7YFYSRgSYadFaV3lQf159ydNyQszZK62N+zgg9faNrMuIrHLzP4UQhNKnk4AOmAswPXCUHsZKFViOHSbXOE3/C0siLe85/L4tBWRiXUEdi4KFOrYKCuZAT6j2OQ89GEnkcOuvQA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:42:35.2097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9777b8-9687-455f-52bc-08dc388d07dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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

From: Josip Pavic <josip.pavic@amd.com>

[WHY]
It's beneficial for ABM to know when new frame data are available.

[HOW]
Add new condition to allow dirty rects to be sent to DMUB when ABM is
active. ABM will use this as a signal that a new frame has arrived.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5211c1c0f3c0..613d09c42f3b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3270,6 +3270,9 @@ static bool dc_dmub_should_send_dirty_rect_cmd(struct dc *dc, struct dc_stream_s
 	if (stream->link->replay_settings.config.replay_supported)
 		return true;
 
+	if (stream->ctx->dce_version >= DCN_VERSION_3_5 && stream->abm_level)
+		return true;
+
 	return false;
 }
 
-- 
2.34.1

