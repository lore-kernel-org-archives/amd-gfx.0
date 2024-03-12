Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1478C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1B8112A08;
	Tue, 12 Mar 2024 09:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVtDwKrR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E111129D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls3uKdg6eAt6yE3o7+x1r/i8PdXMlEtzPUX7bZkQ5fQ+4f/3K0DD9GEAkS4sCbsj1XBJVdWKytv49tk+4sQZliRS9RYZJKl/nHJ0RwdVLjp4xCyT0Ry1BmHcOpbLjr+gGU/CIq+m8ZXf70G559+5bN3A4wuJSNJh2BR0Gr1wBZ8AobhhvD7VF+/++FIMj0eI2uUTdirw/9b4fqY7E6JiN9JOsaBzS9jZeoLPb9r5bzxzQIWSEaZqaUNkAjqkMYKj780xFnX6PAqB9UKTfERkoburpUjwo9+Bh/NYWYtp0cj4BXBoD/C9j7Cyux3Wp1fFkDiABhLZiZRtA4e1i3xKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ncm2tuyAxyHiVyesX+od3SkP8IjFA8PUBdaWxqUxogM=;
 b=JN3nwbWrT0NeHCW778y+GbOmFHXXYBd0zvcwbD64NA11meXtiVBTirCaEBdh/X8eofuKpXHtNl6qw/k0M8Sg2SWIeXeEVw6vxw3EXqtbp0QkOh0oqtE+4Lbcn8PGpwSlgDVMsNjtOTTulO/GPjmk+4rqIQ/SS1HyGXf8nrQTl6iVxDMbZ6KOET2KFNyWpIEzTfeo3TtAsrdnMQElhdWA2e9McMwwGVqDGYh0xVIWmfEHilx20jPIcs8PUTTjQb+V507dt5J3/1LmG9IujyGJqS+hOl1TsavfjrE52kT9b9lHPDsryhO91QLQ5hR8UZAPYIsG6Moo2+fA20yIAs0ayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ncm2tuyAxyHiVyesX+od3SkP8IjFA8PUBdaWxqUxogM=;
 b=dVtDwKrRtUrIYYR7e2s1ZWa+u1AvXSfT5X7QBfU3S6v4eysLbGV2cXPlRAuXJ+bX0YWHDcW74QsJG4v0rQWyfuQVoGHcE/N8Q7xPz13R9+cNHjUbMUrrCSMHh3sxlxQkeYoYaA0h4zfRpXQG+D5RAwMypFQQd67QNj4Nu7hB8bI=
Received: from CH0PR03CA0392.namprd03.prod.outlook.com (2603:10b6:610:11b::31)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:21:49 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::c2) by CH0PR03CA0392.outlook.office365.com
 (2603:10b6:610:11b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33 via Frontend
 Transport; Tue, 12 Mar 2024 09:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:21:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:21:47 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:21:43 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 08/43] drm/amd/display: Enable fast update for DCN314
Date: Tue, 12 Mar 2024 17:20:01 +0800
Message-ID: <20240312092036.3283319-9-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 768b308c-400f-460c-8e0f-08dc4275d839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVc648SK8oF1c95SdobfHMO1ldy42IHWm3dM2TopxZV5itn7Y7GKHa6F+rdpP4dGqQQSORSowAciMY3/KFt66coZAPZZmRXJzPICOdlz70OL0dScJgmTIPHjlyBf2fgsr1asIAP8KoArBLJMHwy0Uw3gjpl0/91XOf/71vzVBqzNDxdOY41mvxt1W90xBrzDpBkqtXEgWj46LHCaSR0yeiyck44kfQtPdDaLjwzwdFetOVPFrcTtGNaCQjvFNUoHEA6osnqUuYuZhi8qubgkwYM21SB/bD8h1SoAlwYrotYz4eoTSFEGDiaTW4QQzppZjrd9DVRAhkL6JlTQulodm0s2UK+tPxyqyuTNP4zNXyyHq2o0xR+sH88CVpk1TfIGsjcu+0NfSgiglc3kQsjk4sEOD+BiHpNriDT229ugpM9tEfC22fiCJ5+x4mTRWt6052vkM/AaUSK9GerdHDqBuFA4sjgItbRFphk1vh1WDdyvqn3/vYHynDyM8/OZpDurxKc+IUpiYmETosDX5uxfIJ0F+4sCaM4JS/4nbmULORU+M4AUYxOpCrEA0lLUvpoiuKMiYPQbsIp1mUBdjp7n2vf2sqgYXcENYLKrWQqMhJFIl84+g0dVmdIuqSKVQ5XrOG4ax5OZ/vstcZrftw8EdLWenPuzSHu+uqivjGGq5oVaWHuN/zsCaYHc6Ulp6AuCqvraAWpZubpUQyuxZdzs0/h2Qpjknrv5/dcYDtmjrDVgMzML+AK8ZXd4Uk94vN2p
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:21:48.5243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 768b308c-400f-460c-8e0f-08dc4275d839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
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

[Why & How]
Enable legacy fast update for DCN314

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index c97391edb5ff..9bd0d72e74c7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -925,6 +925,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	},
 
 	.seamless_boot_odm_combine = true,
+	.enable_legacy_fast_update = true,
 	.using_dml2 = false,
 };
 
-- 
2.37.3

