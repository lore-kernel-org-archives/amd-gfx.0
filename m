Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9152DCCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 13:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B0F10E16B;
	Wed, 22 Oct 2025 13:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j7YWXCVc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D767F10E780
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 13:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfkL06ktK/jcKC1bbmCfGIt3qjJl2dHEkOiq8+ZVSQYQ+pTCQuoNTSbB4oKilAQb2wn2UKGth5JmiLajkvoJFl8fhoeGbquAlLj7WIGzeO0FEZ3MuIcquRc3UIr+yT8jTGiK3kbZsWaMEsL+EjArqhfCy2DHuLxVAUPeDYvd7HRtB1HKGQbfHoyJNm0Psk6AsRtn6ONGlwY/iu5U9JV8qfoszoYggZIiC+THJ9dB13+QgFL0QupzOcs7Yy9pt+xjUaNL+N9DHqwoIiSRqRjj0JXv55SnnJJ/9uXhkrO+P4zbS6TdO3zBgQvo7haqtGWmfHerjN0gkQCIyfI+kqDB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxyb0KDdX66M7S9DjTzD3UIwSO44FYVzTZRPH4VWyYg=;
 b=x5giSz9S0+8zoHwNVmjkGuRK/TjG2d29ar2RpvCPoAUqZ+koUy6SgJkd/x8LuValxtM1pgngpavJ2cqXFWnI7AL6YsKLlHfxBWTrrEJJ2T6nHPhNaGysnRcj++hGA+B+/F0yrFigEzblivFlLjxvLQX/nDmDg+Y3d3kk6tztfnoJKAkQFHSUYlzgyDyMGdDGYiYh+Woyj5/1dWvWogKDEh6wbakxtokvms6K/y2Rp4j9+iRPVQVk2NaVq2VTpyky9jqHAZjrwtpbzPvNXqanVsFKUJFlNy3oz3bZbOxKp5SaU23liAEnoLsjfjZWlOMMzsBFO94QCVKOibwa8bT6Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxyb0KDdX66M7S9DjTzD3UIwSO44FYVzTZRPH4VWyYg=;
 b=j7YWXCVcfHVH5ONrvI3rc1MD1OxiizCQAkIPVp1JsWths8ePz5IjJkDcKHy5dUkg8orPXYdxtIXlTgzQLNjqD0yYF9EP/G63VHiif/885yX8qZAUyiOGRz/JA1zEvCHlPQLn5RZf7Txue3EKCWi0DK4a2YI7L6+No9ExfXnVYzw=
Received: from BYAPR11CA0080.namprd11.prod.outlook.com (2603:10b6:a03:f4::21)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 13:23:53 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::c8) by BYAPR11CA0080.outlook.office365.com
 (2603:10b6:a03:f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 13:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 13:23:52 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 06:23:50 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: fix SPDX headers on amdgpu_cper.c/h
Date: Wed, 22 Oct 2025 09:23:31 -0400
Message-ID: <20251022132334.977886-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afa49dd-5f2d-47d5-4767-08de116e3e4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dkYXM3M4Z1anEM2J13gkg6bmliUZkG+je7Ulf/03a72zzdiQzhx9rZ+rFEgP?=
 =?us-ascii?Q?C0290Rn0twhXkxuOjB01UEOCAuv3PG0B2sRPfPB/GugCqZe7bvwmGxBG9vrG?=
 =?us-ascii?Q?iNAkQcRxwbfUo02DpVG+dRVbVdcYw0XCVfbYKlAJ0s+0LWYoVma48eQeUn4h?=
 =?us-ascii?Q?670zg+OWqEhcnU4T5RjOu/HCZSEPKUs66RcXjJDPWPKsrawbav0w69/bTQNO?=
 =?us-ascii?Q?btB9bOHQwBabfzAYJmWN0KKQtN8+mMzLDVw9pXhE4Cv9Bgmp6P/ueZXD7lR+?=
 =?us-ascii?Q?j1VljfNhVr3wRBu4mQpUJVRUAUEi8E0CW2Ge524xiXCco8FbkZI6OfbrwfRs?=
 =?us-ascii?Q?ktfBNuSsjWXoGInZStNatbfV7ZB3th2TRdVAUneJindPmRN3S24WTVPjqH3V?=
 =?us-ascii?Q?dQtJoIi2KgwsiH4gbBrkgsq9Ozq0jn89zkw1ysdl5nY3xQDOphG4egU2TF+E?=
 =?us-ascii?Q?ZpI5YaHlxfMc+pUDURb1QKUdoXC6QwD3jy0nDTRRF95clfm7YcpWp7oiyIJo?=
 =?us-ascii?Q?IjcObDrykL1O8vVKRbG0mq+ZgcBwzaJ1GEYhRM5rKsRKLcxSiqFgCqrjvgEP?=
 =?us-ascii?Q?dejheMBMppTWAJW0Gr2MW3oew01CyYsLInTOLXcN7QxiL5/gfwRUAc+kg8mc?=
 =?us-ascii?Q?EPSsJigrPxMpbvcMnWHe2Sfk1JLc82MbOsx2tvCQ6WIypqOetD8B+fcI2tRN?=
 =?us-ascii?Q?oDTvWGxh+e9ctIhxMFjujtYeCvT3znGViwV3tBfXQListLnj4WESNim063KN?=
 =?us-ascii?Q?ViVEJugMslK0yuxDSKYhaz3v+B7pq6COnAThYKEsH08T0Cs9mmPvEfGAgRUp?=
 =?us-ascii?Q?hWZTru/yS5ESnRXmjg5h7EozIvu9oEnA6NJmUNPiRVM3iyV0CmcyuUfPrw4q?=
 =?us-ascii?Q?PhdZEQmeeiU5TipfmxHlNQV32V2Pz2iX7NR1DOGU76d5tU6HrudygZFLhXQ7?=
 =?us-ascii?Q?0WDnkk3eAtQVmjFq2MJiXblWD443RboA8Kt7KFqk9RO9YdVKxPB8FWYhluJ5?=
 =?us-ascii?Q?WHGF9I1jSCohUJ772iYUduRBOqRxvmkAFBPusjbOt4sD48bzdXubtPKQHkq/?=
 =?us-ascii?Q?J/fCOxRkVZ+/iU2r9ztHseaxhF7BRlO/xsDUxgidikVozOYocCPicDb7sV+X?=
 =?us-ascii?Q?6YanENG7jVkPwmKquork9/I1QQN7W7s+dtjqtYpsxz5uI62GE0gWXyb88ifL?=
 =?us-ascii?Q?Zagi2u5VwWs5SBG84ramjd0wG7VmRh/Q/FlccHDZRzC0upRDEPLcy06xdSEm?=
 =?us-ascii?Q?rUAJhbr+oXDWyGgvOlTp3wh8Gj5L3GbAbj7qc/oCLN2aCMutJuZfWpux+ssD?=
 =?us-ascii?Q?FNVvn/JQ/keEYUEfw8NtKONDaR5T5kqHz5R0dcyCWoa+yKU+hj87nWp3wwSh?=
 =?us-ascii?Q?ChkH3NsP8IaveOuBZ4XsV3xO24ipSqD9udUAi6ZEAi2SJBNRTA24cfFuoXeY?=
 =?us-ascii?Q?tEtdLL4Kb77eQr9vv++kjP33raPbguPmvgh59gwwMcmYVVtCCEeWctYMQKxq?=
 =?us-ascii?Q?J60tLQh5WSAZHvQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 13:23:52.1310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afa49dd-5f2d-47d5-4767-08de116e3e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
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

These should be MIT.  The driver in general is MIT and
the license text at the top of the files is MIT so fix
it.

Fixes: 92d5d2a09de1 ("drm/amdgpu: Introduce funcs for populating CPER")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4654
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index ef996493115fa..425a3e5643608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2025 Advanced Micro Devices, Inc.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index bcb97d245673b..353421807387e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2025 Advanced Micro Devices, Inc.
  *
-- 
2.51.0

