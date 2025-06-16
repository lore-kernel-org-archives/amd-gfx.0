Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAABC71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 09:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2510910E30A;
	Mon, 16 Jun 2025 09:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rbIPmAbE";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F9D10E30B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 09:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjhseomdoX4G8n/5Mlk9lR0oVQYQji/iQ7RYvlqVa172mciTXNcK7XfPvAEETtTt4KQEHObNuX5iqoctFi4akTCyxa1uv+QyiF7DpU9rS5CG3NVfbapMa53JNdJaSNfuUqTgOSwO665wB6mYvR9JbXz1pszcQaDIiwNupOdNmGHqsh+ZLjqni1jywu1KV3cc5ZClVov8VbuaeEw16Z6l4tBVT3IpAaDGgBs1kxOKNa0vZGX0+4iOk9LXySLiUffE/UN/tzHmn3KJuFDKiyKR5OjsN0RU4Rn3cRNCu9DuwaiS7Urdcg+L6uLOdhuGTv14kktqeJ2Dw4Zsc64YgQHDJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6teJhntFjI/Ffm8Jz06REmkoe3ARStBZUFaRk+xv/6Q=;
 b=LoEvNYAaUqtXkfJTePsNpDygMxs4l5sC0H/QiV6reRaTXKnVr1g0Y3DD7AbqDoTXsvEzuepRVRZ+7LaxSU0Q4KIadp0WNr3XJNc1RWZ/Q8Rj5CXHNtnUT3LyeDSaHo5SJlzlmSpNc9yUnU1Qrxki189y4CnfBIGhNGLu3bw8HYLklEOM7l3IWr4jc5c5T6C1hyBHURPlLcyO6qD11ZsvdK9+tPXO0G4UBGPiqDOrkpUVWmXuW6I4cYLRQ79iT84+oqQrRHsL/Kl9X8eOGqrCVG//CjGxJ2O7JFxdbqLBzGtBnhJLXpIVGThazT34aeveod7yEj3HlKTWxcQb4YF3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6teJhntFjI/Ffm8Jz06REmkoe3ARStBZUFaRk+xv/6Q=;
 b=rbIPmAbEaHwdrg/ifKOVPQINOZLfG2NE/T27IVbyurbNErSXdcPDme+qqSMWh+YsBcMMDmG5zvYlsPWsP2meOa6W+ePyowNZvEg6gLe1LT2u47iLdwYv9ISbCtLeU85oFRZoiviABL0PdJRFXWoMZUexKca3KAAqR3Pm65UxreM=
Received: from DM6PR07CA0114.namprd07.prod.outlook.com (2603:10b6:5:330::29)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 09:38:22 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:330:cafe::5a) by DM6PR07CA0114.outlook.office365.com
 (2603:10b6:5:330::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 16 Jun 2025 09:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 09:38:22 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Jun 2025 04:38:20 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, Le Ma
 <Le.Ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 00/10] Refactor ip mapping,
 compute and memory partition callbacks
Date: Mon, 16 Jun 2025 17:37:46 +0800
Message-ID: <20250616093756.16200-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f770f1-9e1d-46f2-a1d7-08ddacb9891a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HFV6pxmS8Q4AnRDUksrDbdKMclaRz7ykgf/yNXd+w1zIaqckA7JX27UWQ4QA?=
 =?us-ascii?Q?kncEnzkdRdEE9F2UNoIX3DYKdfdjt4wVNP73h6kY7b3C/n80Y+ss7b7AJhBH?=
 =?us-ascii?Q?wOvcc1Q2N8kuUxbmXSINBCbmmeZgyCf+HNpOti5R9DxRWSYZrcdWNW3OsrDW?=
 =?us-ascii?Q?XuH4z/ACcVYtRuz+Bz/N1hAO3gcW9ctQfqhSn85edu5ze8VEp1UmzFED1CwP?=
 =?us-ascii?Q?f4gtCZ50ZQeiq9oeXFYXLJ138vugKVoq0vPkAZiXvKJ7TNcP1ZaS8ENQ7fIF?=
 =?us-ascii?Q?2On/ZxBtLSUs4+fkREmQn/tG+Cmr+xFLgMRoyPzss9iudCMHOhov0UAa7prQ?=
 =?us-ascii?Q?FNVvnRB8hLkM+7Uz8Tb37nTLRXWB2G4AXRoROUz26POeCFCd3osgI/see3fm?=
 =?us-ascii?Q?1Kt/UWSWGlVoH4oPxV96aSQTAahkI9653+x/WERSAunt4p9lIA3rZZsC5zJw?=
 =?us-ascii?Q?EjRXKnZu37O6IfRmE+2m1eBpjomOlL2T+Zvv89vnR7DUFqngHd8BOH7cQfJG?=
 =?us-ascii?Q?gurz/OTd3XaVWbL3+9aMW8ivyA2QDp1ezekH0bjeb2XJS1uDyhkRVNao1v0k?=
 =?us-ascii?Q?a14vYiG5FxGeU/sorrTa/dnE3XsO2i5UQUAsWJdgfY5kG5ulguwtIYJwqzAQ?=
 =?us-ascii?Q?IIYXudnGuIQi+r6c+LAMSjt75uGmSTqhdJ9g/eQy17H0JzZvPUlW1JWP061X?=
 =?us-ascii?Q?QXv+0ahCt6/fZjdJO0WfYPSuivkbQZuIJ88qwe3te7DqgXgY+ysj45X23G49?=
 =?us-ascii?Q?KNZh8iqvX/5IkoaCxXi0l8Orvwii81NRvcxziqFWd2j4eOPas+oXnQk1+fUK?=
 =?us-ascii?Q?8lro5jhl2X2BPgU2j/0remoH2f5qmM1usdpakcI+VnHRibksEp526hB6fzZB?=
 =?us-ascii?Q?/KdEL9zswziyUMT245tsua8h2vMPNLCbLZhebn7qOFwMQWFWwzGIW2UHE8zm?=
 =?us-ascii?Q?chxZHL3Rkz55qNkrqB98LWLKysdhm2SpbQt9UIWuZTXFou9GeRNaLg5k/wMs?=
 =?us-ascii?Q?hjDIOnwuB3WG2S3LZSt5rlfTkWz+ohkbHtlkVuV34dXQRQWD0Tri7Ma2YXBl?=
 =?us-ascii?Q?kYQJznsZihsJQJ9SCcLmtlPjuYXMnJzfdFJjK2kgRzFj/I72kAMzZ/zer42c?=
 =?us-ascii?Q?ZE7ZOfpJttqSJ37tZGsl493/HFGiLGOrv2WSjZzjWpVJtkseNLYqNwAsl75q?=
 =?us-ascii?Q?NUo3mplPUJ2ViDe962sehnzggFxMYU90AzPXtgz9yxgtfUgDXjcRKslsWekX?=
 =?us-ascii?Q?nBQ+eUniO9/+fKam5EwuEPKk50n+Pc+1P/KuPxkzShqnWcnJ68rzBJaR9sp8?=
 =?us-ascii?Q?cX0ZqGT8WpNesBfDx2KPPzzfYztvEaNmbY7ARk2JQWMc5bIOP2+VzQlD5Kff?=
 =?us-ascii?Q?5O9/5Um0oRO9ujM4pY9jcG6pSYC073uAoe2FE0YjKi6LxfrMoFv4YNLmRvKB?=
 =?us-ascii?Q?0j1XX+jYnAGm1zdFUqaP+yB5zFDXb5SunGKXHEyxonwaoYpnCnSonIyvVEQ8?=
 =?us-ascii?Q?e6XeZWcin2saVSmsCm/ro6Ue2tw5hziah2rO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:38:22.4832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f770f1-9e1d-46f2-a1d7-08ddacb9891a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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

Convert IP mapping, compute, and memory partition-related callbacks
into common helper functions to enable sharing across multiple products

Hawking Zhang (8):
  drm/amdgpu: Convert select_sched into a common helper v3
  drm/amdgpu: Convert update_partition_sched_list into a common helper
    v3
  drm/amdgpu: Convert update_supported_modes into a common helper
  drm/amdgpu: Convert pre|post_partition_switch into common helpers
  drm/amdgpu: Move MAX_MEM_RANGES to amdgpu_gmc.h
  drm/amdgpu: Convert query_memory_partition into common helpers
  drm/amdgpu: Generalize is_multi_chiplet with a common helper v2
  drm/amdgpu: Convert init_mem_ranges into common helpers

Likun Gao (2):
  drm/amdgpu: make ip map init to common function
  drm/amdgpu: use common function to map ip for aqua_vanjaram

 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 228 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c     |  96 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h     |  29 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 213 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  25 +-
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 308 +--------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 255 +----------------
 drivers/gpu/drm/amd/amdgpu/soc15.h         |   1 -
 12 files changed, 614 insertions(+), 563 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h

-- 
2.17.1

