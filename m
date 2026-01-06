Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1187C47BDF
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D05B10E297;
	Tue,  6 Jan 2026 10:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o2KJ9HTP";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DEB10E297
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:13:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEt1Pe6kqz1kNq6fopzIdcFq5uqKJLdIqrWHLiml71171XIeIS+bXTSTDmru+er0Nx6Y3Xtc4uubLNv88xMS+cXriGMctZKXzyH43Pzp0VlTZz9ILMhUCuy7xoMIAdfjXMjGsTvRvIJROHpHjzrWT+zx9M3R9dJj4qFnVWYeu9jqu687m6o5+fMmHm4qI7Viwrv0kgdRkLcLOoU1lvAac5yjbzqWFTLNcdnuds5vqFGuWfRzAeBUxFkEg6yGefG9h+cIb5EF3jg3eaGBrY2cGGPiE6epodRhzzpq87CW1TA4uwppf5OCfdkAGPkjE+CFly+J6ArVXnnzbtCd0399sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz0Rl8b8EInOmLHdMTsmzEeHSURUG1328olgHzYiRwI=;
 b=hq9nkeG+IS0ne4fO6SsGfAoH/cQI9AOv3EcQFeB1aLPY8pmksZpl49JXyCrPe5hnFBw0R2d0cMI+uxivjAsKzFfVCDeOmnrJQTPqalgcerLY4KhApQ6xgeU9S0jWjgF0CnloaOG2RpTWSltKDwK4k6gudVyQkSLIgrMeYR6MdlgeqHyhseMYxG6Z7WjHwWMEpnkd+FyTAXDTaeJI3v4T6nXNz40MHeN+TIAgZpcoYkvvrOe219IstgpjVuqR6TsSggLyVD9FlRcQYtN09VW56IMVRZV9a8G2sINV+X2ih0dx/d8M8EEEJiZ01/N7xt7MQyqjoI/Q8y+YnS7hlS+vAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz0Rl8b8EInOmLHdMTsmzEeHSURUG1328olgHzYiRwI=;
 b=o2KJ9HTPDV3ABxchp3YTGzfYH3qcLWxUhmHgNlu7O3wD+Mps3SsnMs7hdKWQ9goxJNYRnzmfTvJh8eBWRA2PKW2NY/BbYtBg0Loilbo9SDGKEG/5xW9tyWUl70sLqQ7t2gzQmj4dyVecOjCPoC6tovHyqTak7gyiJsdW88Za6cE=
Received: from SN7P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::8)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:13:38 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::3c) by SN7P220CA0003.outlook.office365.com
 (2603:10b6:806:123::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 10:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:35 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 00/21] Add smu message control block
Date: Tue, 6 Jan 2026 15:42:20 +0530
Message-ID: <20260106101317.3856153-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: bcca660a-52f4-4bca-e882-08de4d0c422f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3as0DsV14zKGi/hGWDYAZqMrJmLPmx8bxX10SlcVvrG5UQUJSLxCmWMgZMR9?=
 =?us-ascii?Q?AZIne4zBIMaZtsTuXReXZREuW4f8agJAEktoLHkTiSvkVRwLJy1fKqpae0pe?=
 =?us-ascii?Q?ooamvKnZhQ9tL+OiltlSyqXMa3LLmRGf430VwSxNvXyIBs4FGWOFU24uaCET?=
 =?us-ascii?Q?5oBZFi0QgL8UDwU9U+JcsJfW8UXCCY2085la4miAG7f0rFSMOrSLJ0RdnAv8?=
 =?us-ascii?Q?vM5Z5znRto2SBjNXMgoqBhJjV6FWEU+gU6zwO4LIepwm/KsqRNV92vNvOHYa?=
 =?us-ascii?Q?k53mPB/97VVDBNVZyvYlustIQ2eBWw9LiMPG0ZX6SObFbzrfpuMLp+Mkljzn?=
 =?us-ascii?Q?WsaixwfxzpkN4fzs8N1ApVrBundmKCfd8COZhcmEMhB/eM8Z0LANKYGT0S+T?=
 =?us-ascii?Q?8JHj12i7AsMnv5fMt/1PB3d4SDmTnvNqmENleFrFcpFBqS+lGnM5QkEHKA0j?=
 =?us-ascii?Q?JTDtvDSc1p0vLNYiBjT9g1BcS7dhEGmiCp8rJ+kpxbUE+7uKWFCpbPRdlwjH?=
 =?us-ascii?Q?q363UNP31fg7CJxHZHUL/0HQIGCWmr07beC1ZCw3jyBmijGqWa+X5mYxyFg3?=
 =?us-ascii?Q?fsO5MJeloyLputYpYoVI9uMwcgKHzsmNbnZu9Kw2xKG1M7Z6sh2GyKYP7R4E?=
 =?us-ascii?Q?HhBxuFM1eGMWj6eX/SjaEj8oBrepUYGPnXz+SAj8PP7Z/okQEKr4MQQcXHa0?=
 =?us-ascii?Q?ZbFuxRkeV5irFLDnJqi3AhrnoDiyzjiI7D+Sjl/QXYbwc1Qb2d9vh+gkhz5r?=
 =?us-ascii?Q?V3QmwTDF/xQUdl04PRO/+RC9cIfXA5qB8yn4c/NZifV8Onr8Uk7CdfmZWjUt?=
 =?us-ascii?Q?9ccGs8iVODbWiMQBRfx7Y7+e+LMipdqoLWppmpKf9oQzCIWL+Tw229YCkZ1O?=
 =?us-ascii?Q?rsLvytozVjnnrVEF5U7tMmJdt/8su49CcW1KOXtkO+E1U/jvan5oqpvont/k?=
 =?us-ascii?Q?OHW48dc/CCBinisxD/PvLaMLMrtHZfG/xOJh6tbLLj6q76RLlqYwQfhcHJMD?=
 =?us-ascii?Q?wqEu1A2xu97mRzbyaY7QIoAP8ij3V86e0FdcYpABK2d8agdFlw6siLeZbGdS?=
 =?us-ascii?Q?ObE/pYmFEhYnyDXlqq64uv158z8Ne1YZNhVlr90+OaXUgzJAowd2MVfdSqo/?=
 =?us-ascii?Q?/0quMnXPLvwiMJ2DEk3+n0oofXR6a3U9O75BFW9QnIe9qtpkDk32+NLXeRh4?=
 =?us-ascii?Q?uNGkd2l/Gk9TG8tTK5mDdU7//2J2gtOcRsTz4SilVjFdnlnw0B3TeFl6+OfI?=
 =?us-ascii?Q?98DF/zKmardMaG4+n+47I6cKcLI0XsY5IJmTI57e0LT6rXv9ma0q0gFQmeUH?=
 =?us-ascii?Q?XkdbxqI+0rEgz+fleCBJx4BkDLfOXit0UMgX3Md4cdoAhxeWOpkxaVFfN3Vt?=
 =?us-ascii?Q?B6MqoSmw/CzyNPhCld5bPkEabGSs5pTbBBey8q6SBDgG0rr8tW5lK5uXYC44?=
 =?us-ascii?Q?IFXh0hUos4v5OMGdBfMpxqaX7i6s+gOoGOurQLa9D44jle6ugeG6kf+9PoZD?=
 =?us-ascii?Q?JONuoXIv3i3FOgVGlDf1PECR/m1RRbk/B0scs/RjG6K6qDLWSdy5UFYh+A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:37.7942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcca660a-52f4-4bca-e882-08de4d0c422f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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

The series adds a message control block to take care of driver-PMFW mailbox communication. This
helps for individual IP version to have its own instance and differentiate if there is a protocol
mismatch with the common one.

Message control block primarily contains -
        Message config to provide mailbox register addresses
        Message operations - callback operations to support messaging protocol

Both may be overridden by IP versions for any custom handling.

The legacy ppt callback functions for messaging are removed as well as part of this series as they
are not used.

v2:
 Write all message input params and read all output values (Asad)
 Modify debug prints to print all in/out params.

Lijo Lazar (21):
  drm/amd/pm: Add smu message control block
  drm/amd/pm: Add message control for SMUv11
  drm/amd/pm: Add message control for SMUv12
  drm/amd/pm: Add message control for SMUv13
  drm/amd/pm: Add message control for SMUv14
  drm/amd/pm: Use message control in messaging
  drm/amd/pm: Add async message call support
  drm/amd/pm: Replace without wait with async calls
  drm/amd/pm: Remove unused legacy message functions
  drm/amd/pm: Drop legacy message fields from SMUv11
  drm/amd/pm: Drop legacy message fields from SMUv12
  drm/amd/pm: Drop legacy message fields from SMUv13
  drm/amd/pm: Drop legacy message fields from SMUv14
  drm/amd/pm: Drop legacy message related fields
  drm/amd/pm: Drop unused ppt callback from SMUv11
  drm/amd/pm: Drop unused ppt callback from SMUv12
  drm/amd/pm: Drop unused ppt callback from SMUv13
  drm/amd/pm: Drop unused ppt callback from SMUv14
  drm/amd/pm: Drop unused ppt callback definitions
  drm/amd/pm: Add debug message callback
  drm/amd/pm: Use message control for debug mailbox

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   2 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 111 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h  |   3 +
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   5 +-
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   5 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  21 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  18 +-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  17 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  29 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  32 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  27 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  24 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  23 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  32 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   3 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |   5 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  12 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  23 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  31 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 700 ++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   9 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   2 -
 28 files changed, 671 insertions(+), 525 deletions(-)

-- 
2.49.0

