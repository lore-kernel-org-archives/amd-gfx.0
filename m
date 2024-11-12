Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD2BD597A7
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 21:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81F0E10E660;
	Tue, 12 Nov 2024 21:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pRkwNa/T";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B776A10E660
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNroJMvk8qi6t+BkMP8Nc1C6xBWvb+9K6/OBQBdmtKsx+/dBS38UDOFAMswRdT3yqScugbIHgftXiZyp6bAD68qKkt/aHufH+1ccAcw82BzfluNSDS7FNpj9efXyCUGm+0JnVzWWFSZLTrXoaYkeNA332UhCobFDdxQKwQqgTmrzBFp//oBssggSNq/ooGAEFOfuAIMt564OcttCcQi3rsq8Af3kYA/txktjfkgz6XYYeMRQkhqRsTQpG8NgLnnT+wlG5izYtmxdc6ohFyBDnl0ZZnxQcbozygntuRLgXMhjYfidS0pv3ec8ueHrBF0BSTN5I47d5MsIJzQEaHZfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bqut9JkKO6YG7Fid1GxPNuRdKnkdrTNgndoPBolqnc=;
 b=HfyDpW32Er5oIt8yEkGOY5/IbSQN22KxYENco+4sUZDjyInsJI97U/L1SlCYwPqzVrjc2iinPG+N5lgVLP33sipC26cAgdGsKr5rhPqi7Jo4p8joJCYQzGzJ62NJjc8BRzQhfcdD7X7QwGGUB+wPl0stSu8QrIAK0NpmXznoC84+MtqFuf2soRzC1V0cUB8E4nBCvCCW73PovkTwrsFI2pOZm66TfIRjRlBf23+nApZWS2V59+OIU58SRkhRgSYDLacofrqZjfc0tpFy9h1AGTBU0WGNhZT6KnhsI+J2zNrDu2XfLyiPM5arl2yEOW8oCfChMj8YG8kUhWDnvG3Ugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bqut9JkKO6YG7Fid1GxPNuRdKnkdrTNgndoPBolqnc=;
 b=pRkwNa/Tq8ECvPBoZGbspZfl/w9aFZeO1A2ZIGR/qGXzLAuAaB3vdS6VMoIuxLVMrKwHoJpNf0t6sfdtLAusWigcA16WSWug0IK+P7N4eL5/hSYsYDeswC5YAzJ9hOGSNdZK5EwyUea4WKS5NKUJ7uqaEv0DBDRlfyRWnYmXUYw=
Received: from BN0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:e7::19)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 21:37:30 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::1c) by BN0PR03CA0044.outlook.office365.com
 (2603:10b6:408:e7::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 21:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 21:37:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 15:37:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, <harry.wentland@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH V4 0/6] Add panic support for all DCE/DCN
Date: Tue, 12 Nov 2024 16:37:10 -0500
Message-ID: <20241112213716.49355-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 34775979-8259-48b6-02dd-08dd036235fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bc/UsPIoJBHaz/d2vvszSEayymn7npmM65C9ESvWBr213n9c9IeCxULS85cu?=
 =?us-ascii?Q?mTFwNWDfmGtYmZ+D3cKitDMaptWUP1OCwFHRFF+PLwh8lnlTNPM6qr7sPyBb?=
 =?us-ascii?Q?f7QvIaaYB+A9wI0z0/WQyHG1d93t+xKQGI/OBEVsxXupgIdZwp9ZL5ecDL4M?=
 =?us-ascii?Q?KpAUvFkM7djfqIXPvxjhLu8F3dH6QXZCbEF/uwSIF/lTwb1zz4uHnASh1YvG?=
 =?us-ascii?Q?GeVd94csOguCEPk9fAuUSKxS1B9eBBn8OpZw4B1YdD8mRXdca/NKCJMco0R9?=
 =?us-ascii?Q?QZxizuZqzmA/Z3EWs+zbgKOpd29A+K3I8D/Y7Uc6O6/byDXJepBx/FQLms9q?=
 =?us-ascii?Q?cecoLP9tBJFErOwH7rU+yzBkToZxCBeirUtLZzopv4ngr39Jz1DQc4PqtJzu?=
 =?us-ascii?Q?bg53wOy0YHuOx9LlGTT4coDQmQQzH80K1zIMb2LQR9ZNmz08XmAOEbel/72r?=
 =?us-ascii?Q?RGn8acAtmd+7gTsJhQuxBSHcCoxPe0Q/K3qDVt7UIBOXiclBhoF8QQiJ0on6?=
 =?us-ascii?Q?tl7ZX9QdsSwhQNaBODotW5ztZToS39gcD2zwz84Y7zJHIgSbovl2vfRVvuUq?=
 =?us-ascii?Q?C1Wy+C/ZgYtVr4R1Ae5tEYZKOw/Fc4MRVPEAjbdHcBixydGPPKx0nIyZJ2Bw?=
 =?us-ascii?Q?nYaMkfyuOd9fQBneZuO/duJFuN2SZwb6z336Fo5x7WaptQbld0MoNxRPcDra?=
 =?us-ascii?Q?rCFEkYGDSm64Hdb64w+jYJ6ngDPGJqRGwdJu0qzFxyMLQMmd32CEY3H37WMO?=
 =?us-ascii?Q?58q8elv9nZxWufYZcIbGYsiMFBtWowqtBuO8SHM8R081AflqMlMD9A5QEx8q?=
 =?us-ascii?Q?tmMQNn73rAG1sZELvykG5Ei/6+LWcavnBzHI6dBy0lz4PKeGo4emSBas5aML?=
 =?us-ascii?Q?lhvIJipXpUsEZ0NIuZjzUwHPSlVwm6nRlZP2YtfsVN1QKFXx8NkwMXIvz3Jl?=
 =?us-ascii?Q?5Ylqw2rwAMAqx/xAt2240cPLrkT3d8b0XflXJRsEJwayc7fZJVKGvzhQoOgs?=
 =?us-ascii?Q?SSYbolAnryvp7+YDFbwtvKulnldLUhuHNvwGxb1+IpkI1V+lomq6O1MAs2BK?=
 =?us-ascii?Q?ldeScSq3wLzAX5fT4BBjOTfgo1/aEtzaMrjTF+DOH6Wtn6oC7VgkKxmZj+5I?=
 =?us-ascii?Q?0hwtmPTgUv8LGH8h7j4QbewzihVx+PQJCNEVdBsjvbxzbc4CnT517WgZsMRE?=
 =?us-ascii?Q?9JZGgfRs5633f0DqLL9SOKn/NQ5/2MFyN3BmryciNfv28b+pndpddP5Gmg5J?=
 =?us-ascii?Q?1DqJMJMFBO7/FBmR9FW8/Al1at4cCasnmSMJ6IL4np/UK6EvnqpUQywJoG2K?=
 =?us-ascii?Q?2afGo6vXKAOx92qpZmc1OFxrZJXXjc1mbaGSO8cQXHw0pBWCLQnHJuJEMyA+?=
 =?us-ascii?Q?K/96NKHUVUBIA6eom+U9AnwwaRWyrMmDXNb/5Jz1Psga36k62Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:37:30.1899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34775979-8259-48b6-02dd-08dd036235fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
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

This builds on the patches from Lu and Jocelyn to fill in
panic support for all DCE/DCN variants and code pathes.

v2: refactor to provide cleaner history and share more
code to provide a more consistent experience across
DC and non-DC.

v3: resend with the missing first patch

v4: move hubp and mi code into a dc helper function

Alex Deucher (5):
  drm/amdgpu: add generic display panic helper code
  drm/amd/display: add clear_tiling hubp callbacks
  drm/amd/display: add clear_tiling mi callbacks
  drm/amd/display/dc: add helper for panic updates
  drm/amd/display: add non-DC drm_panic support

Jocelyn Falempe (1):
  drm/amd/display: add DC drm_panic support

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 80 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |  5 ++
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 27 +++++++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        | 27 +++++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 27 +++++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 26 ++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 30 ++++++-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  | 46 +++++++++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |  3 +
 .../drm/amd/display/dc/dce/dce_mem_input.c    | 34 ++++++--
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 15 ++++
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    | 15 ++++
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  2 +
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |  1 +
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |  1 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 17 ++++
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |  2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |  1 +
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  3 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 15 +++-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |  2 +
 25 files changed, 377 insertions(+), 8 deletions(-)

-- 
2.47.0

