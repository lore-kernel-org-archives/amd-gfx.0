Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D902CC02197
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:13:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97F3E10E721;
	Wed,  5 Feb 2025 03:13:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oPcPZAsh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D253210E12C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HnFpenW7MlOnP2yjRLZThyPHRV9+m+QAjRUSW18MjpzYB/W48lznXqS8ljaYU0BMW80IkP2A2Hxh2gwOPTDP1VsWWuw+w+R2nmB5UA5qVtpiVgQtflGsWNmqV3dVHmN/08s+AUmpfYTaTthys01Bjji0+lLVSFLqZq+XvfXBMWBqviASpgeuIfRXl1lFhBH5ZM1wx3xfG61cIziBmeDBC8wYz9J/ZoJr7wJp8h4ofuB0NK1iClBx/lpI3d1MGwO+7T472N2xG7u4uDP76J5rKRwcc8ATRqjknxzBbDPpQb7E8ZWSxRNSlLD3XX+JHyQC2+/C/6PdezEWcxaAvvZhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAUYe6RjCtwdrORpthoxehW6wfPrq8IgyADbG/G13KE=;
 b=Jkkpk6r+pMNA0AOJyXBjBxLe2+lP13ge/gRKN5kgM6/VKZThgQr69e3jeI3tDWvI4K9UtCkYMd9DBRTmT6Q1umwp17B2+n5cUfYsRuvRqGIuZ+/3nEuPmDKaa3YhwFsSjn36L0QzSD94Wnuv8M4FdBu0fqVzuhDXxTpJr2+8C8QLcsRJC0iBD0lG3gWh7kIARIFSmLT6JNDis7+EpA7O9Pkig8iyVGMX13Ja5hXBmViQpQCmXrOrUXMXsejk5DMg5Iss8i4eaCTwbyGDyGvDeZsARGx3LkM6mpaGZ2RafRjQdtB+Upxk47/p0mRpMwrJ/8/VtkB0TLE5s4UXeQWpag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAUYe6RjCtwdrORpthoxehW6wfPrq8IgyADbG/G13KE=;
 b=oPcPZAsh8qz9tz1ZE5brmRJ+nKX1tkOUa0zavqlaqExJMemay+uhKPvGoi+2Nt1l/9vMI6fYtxOnJIAmiIJRuziMxEr/CDOJJcyFVJYtUpgsNQ+D+GyVR+zTKg1oyRIPdUgMOei/urnnrsNyjwJHpYrQfAp8HaG7AxDVQbkN0FA=
Received: from CH0PR03CA0429.namprd03.prod.outlook.com (2603:10b6:610:10e::13)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Wed, 5 Feb
 2025 03:09:24 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::3d) by CH0PR03CA0429.outlook.office365.com
 (2603:10b6:610:10e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 03:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:09:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:09:01 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:08:57 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 "Zaeem Mohamed" <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, 
 "Wayne Lin" <Wayne.Lin@amd.com>
Subject: [PATCH 00/12] Patch set to support dcn36
Date: Wed, 5 Feb 2025 11:08:45 +0800
Message-ID: <20250205030857.2608094-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1a13f8-45f2-4eb1-6dd0-08dd45927dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y8P1dQHmR4zj4shsCArNNBmMQJEd0c9kVHiZApbn/JLN0t+vEa1zQ3TcNdxm?=
 =?us-ascii?Q?x9SXhlonf9QGJ1+1ZNypqIKufRH29n76Lqiv/WDjZv7J+Q1Fstxy/H38NYpS?=
 =?us-ascii?Q?tf8jtV9T41HYdL5w0dG9KTZmmA5uS/Hd1ug4eSquykHtXFlr1wYWWPCusCCv?=
 =?us-ascii?Q?bl/Zs9QnOhDIPfKCRo2rH08skyhKMZEJ+M2nqYA1LyEKrG5MaX2kRYNKlWun?=
 =?us-ascii?Q?YV165QWQqMEAoEb05HrleBgQn9ObrB+Efyhb+HgKc7uZ+UGCHFLytgY9HUb+?=
 =?us-ascii?Q?VE3bNZEy5KhEnuBE01xu2zfPusYmIIaNXbOuccKrCjSy2CzQ0Bj+2GAxjjOs?=
 =?us-ascii?Q?TocwoJ8A8jK9uCvBJ6Ozuzfit5zNW/1Jne1tfEzYrwZJEdIdJbFJH/WJpS/i?=
 =?us-ascii?Q?1wY1+bv7XpNt2nodncZ5pmE0iukXSXnjYOAbzpcDZIuND1B1sZkx3J3tDRvG?=
 =?us-ascii?Q?UcGhEYww81TSE7re1jF5BQsOOqmIAx+79Y6gLSyhi19IlrAFAk/thADSk2uj?=
 =?us-ascii?Q?NTP6l1BT9gH3xDavLxyET696SYCw+s7RXw6Ktc8KzTrWg3KeV2PzscwibmDp?=
 =?us-ascii?Q?Th7d59bVieOlNllsysMZAbx0ecbv5DR0dW8g5IZ8XAWdCB/nU5fddH+m7AUw?=
 =?us-ascii?Q?kSUZPTYoruG8JJ46TKR2tEAXon6Y48VHSnKXCVCk+0ciyPCpL4QAQ19pGYFN?=
 =?us-ascii?Q?wQ+7DHKonflAGoZ7V+DRtYQby7KuoerYZIFHuU0jDcJdsQ7tasCVDFl+bqU9?=
 =?us-ascii?Q?LSY0T6RoYC9A88lJLlhhQxH6h7pqaBiTUappobTZu0QL7mwIUdEZQieEgl8p?=
 =?us-ascii?Q?3wDhihJjP24lfZUNH9UKJBEuMO8JnHa7BIQL+bGCLcjAo5U0JFAsF/U4py2O?=
 =?us-ascii?Q?DUIj8ghQi5kyLg7TOSlyq1tzviFMXKCsY8ENWghZ6dYkT3vR01Z7q04yRQOr?=
 =?us-ascii?Q?++s756FQZ31YJDMc3zViD5lAFe86hHOTdcdqEBwTfZDL0aZBzCiT608WntXZ?=
 =?us-ascii?Q?3QV20PA6vhZFzBRdbZRAIQ0YyMozw77vEuram9OY//cXQw3/kCCnPh31R13v?=
 =?us-ascii?Q?LayprPfCenKL8y6CNBHWE5PMnGRgWPQ2Vs7LHGs6GFPhTegBhpHGyOe5Gs4y?=
 =?us-ascii?Q?nbxrWYrtcjye0pXRrBRJ4Wgf6m/1ol+oMh4C1hO6HxITcVpLPB8yOuLk92+6?=
 =?us-ascii?Q?cSNBdoFTksCIgVjGpkodOF4I9ELhzB/hQ1s8NVx53Ke/SJj6Cd9zltRPjkC+?=
 =?us-ascii?Q?II1fLipiVqhCEG7ZcFmadEhP7Rj1tA+sxiPtnbzWZ1vmHX2airu8FtPQ1zqo?=
 =?us-ascii?Q?rZuokcROGrWaqiuQAiVanqEFoTMw9ve8J8pxSItQzA+Zz1DrYFCev7BXxspl?=
 =?us-ascii?Q?yHmHbHeLPZHhEyCzfoDGaAEWKzi/yFNgHSddrleyqIGVfT201XTuz4sI7rzv?=
 =?us-ascii?Q?Bwpx4CgngkYJEBzWrXx8KO9O5MpyLJku1KU+O4FD38IXzdIec66d0zd30wth?=
 =?us-ascii?Q?02CCq/4VQfxl1WY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:09:23.2739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1a13f8-45f2-4eb1-6dd0-08dd45927dbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
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

This patchset brings support for dcn36.

---

Wayne Lin (12):
  drm/amd/display: Add dcn36 register header files
  drm/amd/display: Add DCN36 version identifiers
  drm/amd/display: Add DCN36 BIOS command table support
  drm/amd/display: Add DCN36 IRQ
  drm/amd/display: Add DCN36 Resource
  drm/amd/display: Add DCN36 GPIO
  drm/amd/display: Add DCN36 DML2 support
  drm/amd/display: Add DCN36 DMCUB
  drm/amd/display: Support DCN36 DSC
  drm/amd/display: Support DCN36 HDCP
  drm/amd/display: Add DCN36 CORE
  drm/amd/display: Add DCN36 DM Support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    18 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |     1 +
 .../display/dc/bios/command_table_helper2.c   |     1 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |     6 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |     2 +
 .../dc/dml2/display_mode_core_structs.h       |     1 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |     1 +
 .../display/dc/dml2/dml2_translation_helper.c |     3 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |     4 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     1 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |     1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |     1 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |     9 +
 .../display/dc/irq/dcn36/irq_service_dcn36.c  |   408 +
 .../display/dc/irq/dcn36/irq_service_dcn36.h  |    12 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |     8 +
 .../dc/resource/dcn36/dcn36_resource.c        |  2171 +
 .../dc/resource/dcn36/dcn36_resource.h        |    73 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     1 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |     1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn36.c |    34 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn36.h |    13 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |     4 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |     1 +
 .../gpu/drm/amd/display/include/dal_types.h   |     1 +
 .../include/asic_reg/dcn/dcn_3_6_0_offset.h   | 15485 ++++
 .../include/asic_reg/dcn/dcn_3_6_0_sh_mask.h  | 61940 ++++++++++++++++
 27 files changed, 80201 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn36/irq_service_dcn36.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn36.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_6_0_sh_mask.h

-- 
2.37.3

