Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCC7C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDB010E067;
	Wed, 13 Aug 2025 23:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PphzgLaE";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F0510E067
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zuzlnjkbj7kWYtnXYC/yYPlVLeOEmQ1xmuj3xJ5eSJxgVoyyYNp0qL2ncfLhpu+mbv1eOfdoohEf6H6h1pg0EstIb2tCGdmel9hwuLtQal+F34EKPdy6slnfjkt2UAVGRTC+yK0QLEgcr18O82DU4bn/qDdnvkQQk+UbKW+mGRTYZqWpt3VGJZVNq37B600neNnTe2LUOYNqWeGcvbt98bGJc2fcw/efyGq+jpVaH7j3fEEOLHpiGuMar5mgTJRpUdw0RvzLZHI+oWaehTbIJd1Dz5iv7A6WMnL+givKRu+pdRsaDOOroDB0N04p+rSorOdnxZVssC99BGjP36uokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfFO0cuT8Ui3K7SYWs9YSUfKRRg04miQHsDa7pn2Wvs=;
 b=S3jSng+DTCl7C89FEcONJaytZ4AwW+luwl8TFZk5zoXs/3GIkrF6QRmqH+kWiW7rSILvZ8a07vI9ZtnN2D3celVpfmernXDsi2R5gi0DKwYcgB73sQeoEt2gDE2t75tKhCF1j2ak0zXwKXv1kPFin+LJ7WSuD+2VTwsOp7qV8ofPB3PoYD6xt3qEKYZzaqIVJDb+giQuGLJ1KITNk6MgbC1+ufhZxMhtpdVsQLB1qAVjVEE+SUouAhS1hgnOFcCRrFj6qw9i7rKWzdLT3c87+Qs/XymgN5cYe+YQ1VhiFtsa8V2DqTsmrtzFc5HoxL46nI8xt9qkjUaUTm6R6+NlVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfFO0cuT8Ui3K7SYWs9YSUfKRRg04miQHsDa7pn2Wvs=;
 b=PphzgLaE9arO7MwDr6Ds2ik3h0XSWr4DPFBt5DsOGhW1fNN9Jla4XJHi9kzvX9ZTzZ0vkS3fob7R0qd8JBKkh9YRzu6GIfiFRVKPpdJhUYLLVJnDUMXdtglDiwScaG3DivF7ULCXCGVpDOiFULmUxUT19jqJszx9vOw+KzyotQo=
Received: from DM6PR04CA0016.namprd04.prod.outlook.com (2603:10b6:5:334::21)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 23:26:36 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::37) by DM6PR04CA0016.outlook.office365.com
 (2603:10b6:5:334::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 23:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:26:36 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:26:34 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/11] DC Patches Aug 13, 2025
Date: Wed, 13 Aug 2025 17:18:08 -0600
Message-ID: <20250813232532.2661638-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: ed513911-48b1-4ce0-4817-08dddac0d8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ETzpql3fTkhUwmYGI2cAF0xjEmJZcWkpzUw/j2ICzY646A7zHdVCkjOxRGk?=
 =?us-ascii?Q?3hgTPFVx2mJI4QR7fj3vXDEw51R5DYCETIJit8OvdInxaVWDpfq+Lp6S/YmZ?=
 =?us-ascii?Q?D6tv9zAwnRanFNoSdTGwLMGrHO/5/Ks64+66+h+Exmo/knaznIiIeLzQsAq8?=
 =?us-ascii?Q?g5LM8jeIcMFoA8g4DXAmg2KrkgkmSEF8vDo9AqBe99RJ3FfbYJjprgde2XGf?=
 =?us-ascii?Q?H7Xh39c+gTlAuuiqmLJYGZn/BZFoWajQE5GiIx6PUcfjlYpF7y0XDZrEMby8?=
 =?us-ascii?Q?a2Ib+QRUSSrtgqrZFVwlf6vnpCnDqeRjapH454/A1pOQprAOQdDCN6CC3obH?=
 =?us-ascii?Q?8RKjti6stVECmUZeiJ4398gQFL6ZTvX+T8WPi7r3vTlO8GNlMXQP2z2GTLKn?=
 =?us-ascii?Q?t9YXhlgBRLemqlkCPrIh/eN1ligwLRLd03VaO1mAevOHUo84SovkypnLEoJI?=
 =?us-ascii?Q?6gqAXdre8ugQNb0jl4CxTqBiR9/t4Tmy7ouzgwSrmUqXRd0xLNZ1UFyqzNNG?=
 =?us-ascii?Q?hjqKlhnh1bg0hYLYnuKSAwV0HjIniPFnfm97m8wpvBXYzpnxUxR/AU7reQhO?=
 =?us-ascii?Q?0n4Fn36Gb7zLkH1jiMWEwXX1u3t6Qo2SIUc/bt/BnEbg3bSd8OZU4uoJwxoC?=
 =?us-ascii?Q?KUKObCvki0FEOg2eHozi0dRfJmzxqZw8CDkgKud/9aft61l+o64KBOMQ9oDq?=
 =?us-ascii?Q?0PWctHEKPs6Yf1Ug4ZEiuz4YTyGDgombbYESK51RZL+Js7tdEOJCrsVdmFEA?=
 =?us-ascii?Q?jik1qZSBJTk/cp0WptY+bF0A7dJ5GvgzIbGEW/v40cpIyhGQw/0dSo1jytqY?=
 =?us-ascii?Q?dbg1ybC+tWtXSxWzPIGjQoKivJ8SpqLIY8W6cE57sJMRt/yuPC1NmvuTkbqc?=
 =?us-ascii?Q?Y46/Uu4x5I8j9MzjFXsE5HUW7D3/9Ffmr2qqPvsZtwM33WI1RNnGxkmHXv3D?=
 =?us-ascii?Q?kgzKl9/+2hWIaLYB/wM3kU/vD45HjoB3HNtaDRgHWgzfpOuJnSUikWxSmTUI?=
 =?us-ascii?Q?0a+wQ5jY3fyVOTS3ZxAfFEAXLOrrPO4OgiPutBIXBHFabmvGpJKhNphzZsFk?=
 =?us-ascii?Q?v6MCFoWQjpRBITz5PFyfITJplYBhF46ntnb3KFfhX1RTk6wPO1JO3NoZZohc?=
 =?us-ascii?Q?eZQInZcBEKgdE5d4ONQBPllp0eVTm+FVwegrY2AajBwEz1gygPcIi1qxkR+i?=
 =?us-ascii?Q?Pdv3snEZUgsIFvgp8predAzGRzJ7NQpx58o/DGjGwzXOLdKXxEEq4MZECq//?=
 =?us-ascii?Q?Wmu1GzVKYoVWYvU7B/6nwE8LhnmGrTerJ6enbKX6rit+jRRjtCVX2kgFQEIy?=
 =?us-ascii?Q?UnX3gfKP+Mnp52KuGYtU7r4kBHZCzkRFWn4//6dRJOs0h5/aQqgTQKICjg4U?=
 =?us-ascii?Q?uUW04dP4M3kkw9WdsV1eShF9mkAeIPET+DMukKCcwETmCE6ZC5j2VuD+F+Nj?=
 =?us-ascii?Q?RySZA5zQRhcHUU9liwQHjDx5XsM/c8GYlBwNZWRtS694qIRlSP868Uw3ZDJz?=
 =?us-ascii?Q?xAEB15uzVI1pP4IFlJdtQ6RqzqDXo7UJWuIR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:26:36.1707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed513911-48b1-4ce0-4817-08dddac0d8cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
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

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Fix Xorg desktop unresponsive on Replay panel
* Refector by optimizing functions and deleting unused code
* Attach privacy screen to DRM connector
* Other misc improvement

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Austin Zheng (1):
  drm/amd/display: Setup Second Stutter Watermark Implementation

Clay King (1):
  drm/amd/display: Delete unused functions

Lohita Mudimela (1):
  drm/amd/display: Refactor DPP enum for backwards compatibility

Mario Limonciello (3):
  drm/amd/display: Optimize amdgpu_dm_atomic_commit_tail()
  drm/amd/display: Attach privacy screen to DRM connector
  drm/amd/display: Avoid a NULL pointer dereference

Rafal Ostrowski (2):
  drm/amd/display: Add LSDMA Linear Sub Window Copy support
  drm/amd/display: Align LSDMA commands fields

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.23.0
  drm/amd/display: Promote DC to 3.2.346

Tom Chung (1):
  drm/amd/display: Fix Xorg desktop unresponsive on Replay panel

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 142 ++++++++++--------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  19 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  70 +++++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  36 ++++-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   2 +
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |   2 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   2 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h |   2 +
 .../src/dml2_core/dml2_core_shared_types.h    |  12 ++
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |  10 ++
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  36 ++---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  15 --
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |   8 -
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |   5 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  21 ++-
 16 files changed, 265 insertions(+), 128 deletions(-)

-- 
2.43.0

