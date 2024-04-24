Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44A29C07E8E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC79C113959;
	Wed, 24 Apr 2024 08:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NFqM8zKG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E61C113958
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvMcQyT6qAF7+EwbpAZanoDyyzR8MWPZivwsNLmbH2NZXxk6O2CxK8HiQ7ORUBq26lHlnTmLTNNVWt24STe46WfKApJqf0KUQbiDLMRDKvlLUGMnUqIRRcWfM737QQfnsw1V3+0UTH/3jehdvtfMwcSUPC/W9pLE1JssPJDu7zuqM3xaC/+8kDH/Ed5vDm7Y20ZWzG21ianjdafZoyAJHxvK2+djfZ2Mqql3eKs9rljVthhbot1sPh6VX0WepQv2bgcSdGZTfyOUE7ipz8wpFnG5jN2GlvL7Qm7nuRq0rW91dq3/PDLWH5/1qMt7xdj3goLptCIfL5+ENspEWR3Vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsXdcigvVnGR+BvBGSL8Y934GBdFjUuIGRkag65G+c0=;
 b=em7EVL/x+6rKGEMWSekB8pIoEq2I35ITcQx7Rky6MUrTe1eq7sQ/0dRWb8bn41t+6SRMPqyEAobfwxu5fURGEqyFOsLr//5kxfxeniCYlpmGdKqlOxiMEkFDluPOyIWYO6CW65AXKqM3HG2VBlYReAsyS+FfHD8yqJFIfRVANL115XLL4plBsS1wyvu18OB29RzSOCEtc2M+qCJsdrFH+sPBPhQykAMAnjqEiyw2B5Yc+XXXLsDjO5eOq/QbR4flZOS5oFmXM104EjtTyZO4RTQIT6JyyHqB84i6/Z+o0AzvjmexPmAmZPnecrs1J9W3RuJiZpMxYIvWvywU8e/vUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsXdcigvVnGR+BvBGSL8Y934GBdFjUuIGRkag65G+c0=;
 b=NFqM8zKGF6MfdgDpTEGGoS1cucYIMnHTXsfGM5B+1Wmi/B0GO1Z8meb0zVI+STHmybIQyg3AMZxzhc1C4rfS9UfB6Zqv+pzoF+frpUoJn3i+O/WUmpMfILK0FFMB5arwiUK6Thw7EctAdFtLI7Q4xR8ZLBB8gXeIzy9maV+DDfQ=
Received: from BN0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:141::30)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:51:19 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::5b) by BN0PR07CA0015.outlook.office365.com
 (2603:10b6:408:141::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:51:18 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:51:18 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:51:08 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 09/46] drm/amd/display: ASSERT when failing to find index by
 plane/stream id
Date: Wed, 24 Apr 2024 16:48:54 +0800
Message-ID: <20240424084931.2656128-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef4c243-ca42-4f9a-e05a-08dc643bb544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7RDd+4MVSEMtFhsVmoZ/6yynEjDaKNQqvyl5QylCMmnCW0ABOYEjCQ6hcYkb?=
 =?us-ascii?Q?GJ5Fvgrkm6belqxjsy0TQzC8SNabYJRfk14G82TdQokdww5kC3sbC1zMKmy0?=
 =?us-ascii?Q?epvOXV2ps4PGBVi9H5vcuLtZy+ezccbp0yCs7U3/ZnLn2xdmiUyYgXb+iwgZ?=
 =?us-ascii?Q?ZllrjlsLrvl8WOpNJJ37sfgA44b7mn2ahmSQtFHWsHd/1wOCquWrdNAxL1Z8?=
 =?us-ascii?Q?yiU4iUluLcbXt5FOjbbwpE28P+p3xumqLaIWpXABRN8GNQlkAEgq8lCeTEW0?=
 =?us-ascii?Q?1DwCPGj4NB6KywG+y1sJE9brLPubOGVM/CAkpGrFgYUcTJo1qbh38QpZpUjz?=
 =?us-ascii?Q?cV0yL9hoi23Qys7cyANkw473hBWIhoSdkhDE+8K7cKr/JGpkGjRjpNmsQJIp?=
 =?us-ascii?Q?hE/fy3aa6L/kaDyH8zOQEfKqVPstZUJT1t/MiwiUbrHk0USFrM4ZIuuFj6UB?=
 =?us-ascii?Q?kEYqgGu2gER7Diq7sVk4qIIGQ+lcAO5Si6ljzie9FQTZA78ydTqT4F3oAjsj?=
 =?us-ascii?Q?L7OZKKu8XKvckezewVoF1eyJ8o/u9C62imO2DnAAb3e29xM28miUMRX+B5Zl?=
 =?us-ascii?Q?huTJhVcBnwJ6nmVyDlwKh4GZUfAyt1B2d4pcc6pjwjxJXtoaZz4kgr6xTBEd?=
 =?us-ascii?Q?hMsWBFBOJ6u4PcSC7NK67AFqFK5sW4N84AviOO7wKIC1OQz7HAAhQaJ4dSiq?=
 =?us-ascii?Q?SBQ+1qAotDH1DIIz5/5bHsw/cl/XNGKA7GDW7eLjLxMBIV8exzF5AYBVIF7t?=
 =?us-ascii?Q?s7hiOGAbjluGEoeu2njvyTQDURigRWRAoPOo57P7N1HaW9UBH9qdswkGXzLJ?=
 =?us-ascii?Q?H5Wmlb1VSFLR7UkBakrPIFziwlEi4Twa3DMwFoVMJ4svhgqZ02fyLxX/4Bm1?=
 =?us-ascii?Q?2hFw3kUKpDfx3d6miHDA3iBe3IP5r8SnmZUL4ZElLhLEHTBEi9m7IQwdyrKb?=
 =?us-ascii?Q?ups951vJOZX8aR1ormFyKPvBYGFy7aD6/TtsJTJTReIzYq7hhUKdImzl///W?=
 =?us-ascii?Q?C+w9d8n2UkHswTl4g8llPevmBc7ZqQzuRw2gSRq/uTt677i/5eRNmTd8eble?=
 =?us-ascii?Q?GO3ZvvwAtZOeNiPf2ffvwi9R1mppglkStNsLkH0ug6wQyVuuCso+o3dr2WUX?=
 =?us-ascii?Q?2Hjijl45mVhDgXDSPOFid9yPaCKI5Yk0Kcp7lxNGImEy5P7AtrRERvlLnCGc?=
 =?us-ascii?Q?oJ2uNG05stejpeChnOfbconhApW9rLDI06vg+LcZqg6/eBdMlCWuysU9EYjJ?=
 =?us-ascii?Q?B0WhNlqzWO/8csrqFvfgvAygtAoh2NSrLOlTWjQs9owJEjVXqDtl2zrHBhP9?=
 =?us-ascii?Q?EXzJqYJOHjkLXNzrBfICdjaM9llVkbxm9hmPSvjlGORO5pErkY2v3ecFI4Iq?=
 =?us-ascii?Q?cGeHWv9bkqAQRLhFnpFAUx1osrIC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:51:18.6337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef4c243-ca42-4f9a-e05a-08dc643bb544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
find_disp_cfg_idx_by_plane_id and find_disp_cfg_idx_by_stream_id returns
an array index and they return -1 when not found; however, -1 is not a
valid index number.

[HOW]
When this happens, call ASSERT(), and return a positive number (which is
fewer than callers' array size) instead.

This fixes 4 OVERRUN and 2 NEGATIVE_RETURNS issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index b82d56ed1ef4..a2ced0bc772c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -88,7 +88,8 @@ static int find_disp_cfg_idx_by_plane_id(struct dml2_dml_to_dc_pipe_mapping *map
 			return  i;
 	}
 
-	return -1;
+	ASSERT(false);
+	return __DML2_WRAPPER_MAX_STREAMS_PLANES__;
 }
 
 static int find_disp_cfg_idx_by_stream_id(struct dml2_dml_to_dc_pipe_mapping *mapping, unsigned int stream_id)
@@ -100,7 +101,8 @@ static int find_disp_cfg_idx_by_stream_id(struct dml2_dml_to_dc_pipe_mapping *ma
 			return  i;
 	}
 
-	return -1;
+	ASSERT(false);
+	return __DML2_WRAPPER_MAX_STREAMS_PLANES__;
 }
 
 // The master pipe of a stream is defined as the top pipe in odm slice 0
-- 
2.37.3

