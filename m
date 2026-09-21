Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD866C982FA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471E110EAC0;
	Mon, 21 Sep 2026 20:32:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bu0OIxdM";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A90910E777
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:32:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSvHhlUyDkfAMFWHQdr2utiNRwFVQ1jfphVd+L5OQc83iLq1+Rale/9hh+NvXRVwqrE55Bi33/vzDtKCrFcyvPho0QBHL77hpeA0xjqmCOMFRbT3NIZZdV2uTSndFyn+9Df4YhtBngf0wx22KsoDev2i5tu5VIxYYAxQKBRVnKzeukgrdgrJlkH97KxOjk03TRJ+7Y5Z4zFPslPHCt2hL0jGDgvYcm52Y5zcjeoQOj16jD7F54s/LhhQi3b+NRTfXiqorCgdXTVwMYV8C8s02eamV9I7onr7BqlDqfYVzc97esK5nDHeoHHfney9GPbz1Rivl+7oAUVKSw/BCPKqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=059RSIAdyJPnHZQXfiRDLleX7Er4Ab2BsD6kZtFy7iE=;
 b=yr0qflTzBylMIc5FxVjBTky9Qs5UPZ0c2+WdmkNlfIFX6hviqpDaO1j5VJAd12TbqynJfKSBWNbYoujdX+OpoHgY1XFH3dWJb+/laCqLN4u+oqGVU2r3fih9WRRiQDyrp7NNNTRRuhUzqR1TAcu0EPJIAlPKtSfXN6sjBCWVx+L+p0qWYrQgKZeng88L1LzOIoOeIyr3Ji0vl/z4UbC/Aluc+JSRfZvO59XYkPMqFsHkHaKMP4EmMUZ1RxyTB42oD3ALVHSnGrLcQIcFKWuPywrqEciw7QOGvJYUsP400kDIxqTjYH9e8sBxNGeO3Rd8yE7Lz3mOAewUMpbTEFQyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=059RSIAdyJPnHZQXfiRDLleX7Er4Ab2BsD6kZtFy7iE=;
 b=bu0OIxdMQA+kMwRGsdliYw6XuYxLf2/kBwsReRozSFL8jwNNV5Wby47rNfX4xqwcRnpGB891//eQ7gv/WJK/pzI0JYA6Bf09UK7sHFqNSf0ORQCZ5xf5aEazCzN9XC5Owld7GXJq9VzBuN2ucZey22C1BsFc0n288Ig+pXTVjMg=
Received: from CH2PR19CA0018.namprd19.prod.outlook.com (2603:10b6:610:4d::28)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:32:18 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::18) by CH2PR19CA0018.outlook.office365.com
 (2603:10b6:610:4d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:32:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:32:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:32:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] Add NBIF v7.10 Support
Date: Mon, 21 Sep 2026 16:32:04 -0400
Message-ID: <20260921203206.2038708-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 155df3ad-d723-4b79-0f1f-08df181f6e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: GDmvx95BTnc5IfrQWaScuHwUWvKfOYo+lv3EhfkDnUHGRpLqRuzZk/i0CQ8SmwolZwS1ig4/9jSn1YUSDQo4kE7y9DlwxHPz0WDmqlcccQBZxdNpODNoMHZh94UkRHdbi7NFok4qQ8kdah989WavT/ulG3vCFMd4jZTY/enS+9JRi02yDD6bPc6NXMmrWuIWiFx3Zlii0OLSYrj6bJIeqg0mcoXkshcspVKRi48LeJKQJJI1TUDGg/IadCuUU0jwWLJnmJ4dbRRQA/z4BshVKkOKaJNC3pBXcbI330tVuMjcJ2V50/1K7qtybv8LgAeFzCPkrpJiTg9bKlRYHTixtRej7dZc2+dfqb+kD54oRmALAbrlhyZMtu9K/GkVFK7U2Y+kiW8QCKKOaAjB0B7Nshiw77XNmWFyujlT9jZ7KoHJl69HmMDq94UqFIPBH99Ukal+hZOW6i223H4MqPmBQWbTFsbORsuvfi+kJ53LE7a1OGr5mFwiWJFW0uerz5l6BlEqcMWIWh34EF2SZCkK1dJeXGxPy2T9A+7baK4SB2u+JgSX1U9vYzFXRGZzAS3adNljfURYMzguB2UbXQfVqPPU2qg2CEFJNbFMTQnCXYdMtLx8YpH9a0m747edi3SmAUpdPozGdLAlPJ6pztBRg2w0DM5rvSiYi0PnfE64vJoabpelXQu87G9EnBEzpynZuVr6WgA2dsmdrTUvYP2hEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y3ljNXXO9JgltOU0YsY5whSX3My8EUOiRgfYke76Dko6rpQRo/Y86aEw76k5FKFPxUvdyErwJ0NXB+SleLycDaeDQ0pUwdHLMK1zqyoI+BFwp7+tDBQXPDV3wKrcQLnEQuiaRtut9Fhx2uhFOtliOFUK96H+3+tMj802zSd8xri8CH8l+q3ZfKsbtr+wxJzyZgoNnZaSg0UsJzITPn+Cmt4dbmRNOqENTqxTFXiZfQOINewDftIYlKIEYfNT5knfLZvWiQ2RupHQnbMYhQyD1SMCDOBWiPRwD2AqJTcIb/AnBWEMGsdZRqxrO5zcjJaVBHvgf2ep4Q8oo+Rk0UBsdU2WRMii54bsWknXu9Dymf+XP7wwUJ66QEuDhckzb+Xtxf080h0++cDVF2bMfROVdrWHXVB5fUuPV9/qWz6wOz3Mj0LzETrH/E2tPDJit0x2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:32:18.5145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155df3ad-d723-4b79-0f1f-08df181f6e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

This series adds NBIF (New Bus InterFace) v7.10 support.
The first two patches add large new register headers.  Skip
sending them to avoid spamming the list.

Hawking Zhang (3):
  drm/amdgpu: Add nbif v7_10_0 ip headers v4
  drm/amdgpu: Add pcie v6_1_3 ip headers v4
  drm/amdgpu: Add nbif v7_10 support

ZhenGuo Yin (1):
  drm/amdgpu: fall back to RCC_HW_DEBUG for VF frame buffer size

 drivers/gpu/drm/amd/amdgpu/Makefile           |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |     4 +
 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c       |   350 +
 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h       |    32 +
 .../asic_reg/nbif/nbif_7_10_0_offset.h        | 15938 ++++
 .../asic_reg/nbif/nbif_7_10_0_sh_mask.h       | 60316 ++++++++++++++++
 .../include/asic_reg/pcie/pcie_6_1_3_offset.h |  1755 +
 .../asic_reg/pcie/pcie_6_1_3_sh_mask.h        | 10821 +++
 9 files changed, 89237 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_7_10_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_7_10_0_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pcie/pcie_6_1_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pcie/pcie_6_1_3_sh_mask.h

-- 
2.55.0

