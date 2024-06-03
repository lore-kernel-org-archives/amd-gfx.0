Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81112C27C50
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DB7510E0D1;
	Mon,  3 Jun 2024 01:42:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rPL3byfR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7415B10E048
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuNcM531xxQm7OqwxZoS/hBgcyHF3X5sN+6JKVnP7/Gj720bPzjJ5f+k4MLHjhm1skdlxflUkcpwM0YI4owTr+uAddtkoz8IVHs7lp/EjU5XmB5bCEiOo1+yRA0moi5e8ThMzjsFPD7E5uhWSWn9MBlUixlu90Wp7v+NgUI0Yx4JRLBWkRlnBONqJdkuuuOS0gDnv0evlZCYpzfuWufHlMvlfn+G1TSY14+50yz8JGEdsW97uOviFJHmSKme9aFPrMhGNXzDQDhWs83+5HUcHZtQhCAi2Ko4O5OjoqO9s3Zxj1260bzI2CqDlcnVpchUFQgE9qeeP4AzN0SPhDEK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgzrlZnDmnjkS0WNcKwA3b3FvkAmERKQE3dw6oE3IL8=;
 b=eXlxBVpGXZY5rxuS2c71yEDqgJa2qF8Kyu5wCs84ne9tG+4Z2UE+hVJHLtUBHemnfO0dS1JolGM1uYEO4tAKY9utJXYAOFKYHj4D+5fsG175E2WbiD885QePJPFIkByhnHk+XYwDoGHyy8oY4dEiCX7Gqw1oJ/OMqRgDbifqiab3v7iZomtPscD9tL2nG1kJwfBpBPPD0jqiZ/FOmvXqhwgcpY0oq/y+nLg7zCDB6TtLvPLAwbxAeU8seBjbR2MRoPMXtP+dijL6z/qOmu1Wmx3GgufKWHO7YvBrETy2bPv9h88/GVZ8E6tGGf5tdoBVOzM/mo3icKVUxjt+evee9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgzrlZnDmnjkS0WNcKwA3b3FvkAmERKQE3dw6oE3IL8=;
 b=rPL3byfRWM38LZ/UePlNtKbXw0hVWsHyASKwpLXxEk5FGGTYwBAHfozFIkllBLkoVXX7K5eXuuS+loTzm2Sn9ijPpKzuxW6skEc1u0iM6XwIrvImwC/fHwsBS7FEMO8missPXj/Zz/HmwdRBdOu3XqGME3M46STZq9nYjn9xH0A=
Received: from BYAPR02CA0049.namprd02.prod.outlook.com (2603:10b6:a03:54::26)
 by IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 01:42:41 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::e6) by BYAPR02CA0049.outlook.office365.com
 (2603:10b6:a03:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Mon, 3 Jun 2024 01:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:42:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:22 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 00/18] Enhance amdgpu_firmware_request() to improve function
 flexibility
Date: Mon, 3 Jun 2024 09:41:54 +0800
Message-ID: <20240603014212.1969546-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|IA1PR12MB6017:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b1b934-6d14-42ea-a39d-08dc836e74d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WSJDK7SsvjT27cAvgJVGbNYF7LHq0+7RalguhXiBa/zhZYtUTH8U9tc4i4tK?=
 =?us-ascii?Q?SyPRnfbeaGTRUpK/Sc5D0JcZEymDFKgJsW3Bc7FenA/X1g7ngMsz2479SsGY?=
 =?us-ascii?Q?W+YTsVglIXdPvCYQ16penjqIf7FxWxHsvwkqcn11anYl1WDmF5RDu3QtTgCS?=
 =?us-ascii?Q?yje2p1MiBAILYzWmAMPQftKioAkqzL9oTHr+EcS9TYz6I3oJIJ8fxxj/fChZ?=
 =?us-ascii?Q?OKIJ9cAa53APB37iOjNKTqEGKrM+acuSHT26pjmEbgfzLYkqOr1VyCzQL0H/?=
 =?us-ascii?Q?1iMTT/bSf5UDFsFS2TwoR75lK64zFGwdJK0fzx5xc7//JwhbxW6qTcrjPaIx?=
 =?us-ascii?Q?O3iRt9WvKDUVo6r9vEEHBWLSm9QgQrXPhd6pIBez+lwpFZSoMI/FVQdnIjGI?=
 =?us-ascii?Q?dGh0KEghnkrPESWo30q74lEAJn8vdbRcQIxj1qTYSwFN0W/j3vanh3dDayJr?=
 =?us-ascii?Q?Apuy5erkAP+RRmURpUyCy7OFDByttrtJ+M+0GMqQdpH8zwOlDQQ29NEc2Vpp?=
 =?us-ascii?Q?R8PKOAPx7iKA7xp7KbjS1aAiw9mG0qvVtmuXqDA3Asy5nk6iTGb7ukm+knMO?=
 =?us-ascii?Q?J16jzqmLD9KDudmMTEpdiGfmm1G57VA2qFYBjxSR1DusrJruC0CSldxPV3fw?=
 =?us-ascii?Q?N0OkRzFEPhXa8FayhzdgyEJzzS1TARAFaTL67C4s9q+2eU/ARhGqMMpR9rJ9?=
 =?us-ascii?Q?vXkPG3t4YxAIiaDvq2ljmOd+6BdDE4ANF5uzV5FJXKu4g4TWBnINWMCHHP0I?=
 =?us-ascii?Q?gGay6HFQF16deLAGl8aOrPzLWX5/b30wZZJXKatEd2xG6yIKtawRWQtJW5pN?=
 =?us-ascii?Q?mIDZXeDRV4kKE+E76hyYr3YIM5tq+jVQqzww6xocFftPrx0Gu0JggdZNc955?=
 =?us-ascii?Q?y6i+JXu1zn3VhFTNnR0IKdGvPUZAHiLpUaVqexhkqMF1XuASkZH9BJyK1q9W?=
 =?us-ascii?Q?6u5FhF4XIXZs/BxvG2ouCz7hFHwZaAHqfk1gdhrm+N9jgmRJA2ulEbaLeZ0h?=
 =?us-ascii?Q?9JMK5b8qV23aoNKUHP+g4cqg9v0vdqYI95mZ/qQ6xdz/8iECs+K/b9HGS1a4?=
 =?us-ascii?Q?NulSUBJxzLuvFdwlmwrd/CM9tCots8MzBfiAI8dTMj8igk6tmOk7UJOX+JND?=
 =?us-ascii?Q?5N/byPh694VDZGTpBiUK5BKSeTUyeFJBx5m9am/mhhi2H/U3K7GYopYy6nAQ?=
 =?us-ascii?Q?I0Ysd0xHAWzF4HWiYIN512zvzX+4ONEB6pPAcbFJxFok5JrSuI76+9kPgCt4?=
 =?us-ascii?Q?7mbohf2kfpjD+pQEODNoSDVLuv2Y8S/tvDrm5nz1w7cYKKmQCd2etTRLZjue?=
 =?us-ascii?Q?MTrxciFpWl4gcw+DuQYKOlTFHl/TfPqSKfy2nfvLc3Yv2oecMXcQJ+IJXgh6?=
 =?us-ascii?Q?QG5PuOCZAudLaaUDhU4beF+5OTH7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:42:40.8407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b1b934-6d14-42ea-a39d-08dc836e74d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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

Adding variable parameter support to function amdgpu_firmware_request()
to improve function flexibility.

Yang Wang (18):
  drm/amdgpu: enhance amdgpu_ucode_request() function flexibility
  drm/amdgpu: refine gpu_info firmware loading
  drm/amdgpu: refine isp firmware loading
  drm/amdgpu: refine mes firmware loading
  drm/amdgpu: refine psp firmware loading
  drm/amdgpu: refine sdma firmware loading
  drm/amdgpu: refine imu firmware loading
  drm/amdgpu: refine pmfw/smu firmware loading
  drm/amdgpu: refine gmc firmware loading
  drm/amdgpu: refine vcn firmware loading
  drm/amdgpu: refine vpe firmware loading
  drm/amdgpu: refine gfx6 firmware loading
  drm/amdgpu: refine gfx7 firmware loading
  drm/amdgpu: refine gfx8 firmware loading
  drm/amdgpu: refine gfx9 firmware loading
  drm/amdgpu: refine gfx10 firmware loading
  drm/amdgpu: refine gfx11 firmware loading
  drm/amdgpu: refine gfx12 firmware loading

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 26 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 30 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 14 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |  6 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         | 11 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 25 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 26 ++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        | 22 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 19 +++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         | 27 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         | 69 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 45 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 11 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         | 14 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  7 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  6 +-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        | 10 ++-
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c        | 10 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        | 11 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        | 11 +--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  8 +--
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  6 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  6 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  6 +-
 30 files changed, 205 insertions(+), 257 deletions(-)

-- 
2.34.1

