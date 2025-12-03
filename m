Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94019D12D5B
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 13:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB2010E15B;
	Wed,  3 Dec 2025 13:05:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S6QUfBQ1";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F5A310E15B
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 13:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AEZnopVHzQrukb/ps2YM/ikY77sMR7rfzqiTRS6hXTyoyZy4zsTEWSK6W0hZukc0RwKV7uuaOcApaTqXlQEIT3//y9bKQlH6wsfR9jP11DJHRDwV8giOR8BNaN1lF4OJQ+VHvsZlb/gFsrpYMK4xEJp3i26jr2HckxjRP4+SYz2kEVxG0azYMvL1+pktfQwsQIoA8/lxuxicF/o2PvT7ovaNmiUJpwJ8cWoLl7Zxj+8e9dGXle27Yuq6dATxKsOuSsqalpTu++hcRh8G1XoFfguUgwbrEtCrAh03aDISgq60ETKfpSXQwtRxhIINvlXhxHhziCQ02u887mSe/Vhlvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX5UdDY1DEF32HUGbGq/q8sJaBx4m2Gm4R3TFxogbfc=;
 b=bOWcn5MWyKgbRNuTBW1vMpOXGZgi0gOpr2AqqOoKc1aHGJRH1+HRV7dtEW85SLqWqCuEbIjR9Ugabdp4fbfOHJMvbCRUNd8OsEhvvNXj2MQE5OZsG4RBxkpMCeVJrgwvB9Dawo1QczuEAJ23mDnqiHka176nlyAWdM5Qcpk3CUHorw9CBDwRu6cIqPWfwbISLM1Usasvs+mQP4HD5PmCF92mKtEO47ETWE6c3y/Lxy1pXWHkNkrIVDHTnngKdPuoYlMyzuLS/oLQl6Cb1isgdccQTiY6qZWCFRKiBZnqA+NJc+6DKnwbxIpUT9AMZCITHI7hqqA2AzvQ08Vn0+HG9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX5UdDY1DEF32HUGbGq/q8sJaBx4m2Gm4R3TFxogbfc=;
 b=S6QUfBQ14QKwfMLrtm0S46mcUCl83ZVCT+Wr4793Ly8KXKA6oRp15JGh4PNGIu9LzgzE3ZFQ2ngSiox0kqWL7WJcJWFBOy9f+X8Bfm56S9H3s/0ElLzCBjaNMHqQkytc9MkrMB2M4NZsveyOY5iOl9IqefOSZArOLSq7fjl6p4E=
Received: from BLAPR03CA0150.namprd03.prod.outlook.com (2603:10b6:208:32e::35)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 13:04:59 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:32e:cafe::bc) by BLAPR03CA0150.outlook.office365.com
 (2603:10b6:208:32e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Wed,
 3 Dec 2025 13:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Wed, 3 Dec 2025 13:04:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 07:04:58 -0600
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 3 Dec
 2025 05:04:57 -0800
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>
Subject: [RFC PATCH v3 00/10] Add CWSR support to user queues
Date: Wed, 3 Dec 2025 18:24:51 +0530
Message-ID: <20251203130436.745633-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cfed92-b4f1-4815-fba5-08de326c9081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aF6LTwiRHVJSH+W6xnOBSu29Wv+i4T2NBY1BlZ/VpnaRI+T+/W2GqSWTppXd?=
 =?us-ascii?Q?AIqmiwmekT7wpBgckZ5BZjsAZ+99Z0ZyXR513FQys9HxDu5UsznkNvE48nfk?=
 =?us-ascii?Q?abxLcfjZA5twDNdrwJH48QI+I9TpHEpH3M8Q/9iMiVcWVzLFWNSwIwCCUPt9?=
 =?us-ascii?Q?j9PB5mxezbcQu3lAfEC/ca/uxOlpuKumsSTNigExiTtLQsORBRSfgnmpkq01?=
 =?us-ascii?Q?eQf3WOoCeUjJ2BcffmoOWhbjOGsDVbyfE3tP6hkhRxtjNYofGiTcXkvJmOoh?=
 =?us-ascii?Q?GuqYqKNU4LVsUGXnnxtPprwCiDBTnvvH4sfAfwym7g9QjnhQKcR8x8dA5LMU?=
 =?us-ascii?Q?HwpA7rmMf9nPvSWin5L47RLMkN187SVMaF5LqniumDSA6mhI9v3Wq1LLCkyn?=
 =?us-ascii?Q?dnCA9vyC3BwIiA1t9uFqaYf9EwPVIIclGFz1EpHDfZemNFi5KP6IFfachaUU?=
 =?us-ascii?Q?84BlUrtCQ/OTM0FmQ4cDwz7uHZE/aWVBTmYROIlwg7zNX04w+yfjSVlBA1Ay?=
 =?us-ascii?Q?3EYMaX2lFg84X565ImvMRbO86ddRCvSsbqEW+S0osjZM9wX9mwTuD1nEe7RX?=
 =?us-ascii?Q?yWq8UIn17uR5YHThPgds+uBSOWVXWuGk/QN4XI9CcgKe3dp2er6ZuuB1e4Er?=
 =?us-ascii?Q?dOPMts0J44CQAXDBHI+gxq5HHKPG9Ek48pvy7ZMCPf+qq5Mp5zE7oR/nBrjW?=
 =?us-ascii?Q?88DXylvEJ0VbsBPb3XNyoSFPt8pj8++WKVVWxJXcW8MDgQMHwbuQkl2qbwdk?=
 =?us-ascii?Q?4A0hJ+k+1+FjgrHelEEVT52a11bRV4rIMzGdMFA6607Lq8fTVJRUdJsLHvJy?=
 =?us-ascii?Q?LqxiWVtyIbYjfNH+mlaNkZHmt2ZW/+hS0JHAWWXomeqSQ4x/gcXFZxD7QcHC?=
 =?us-ascii?Q?G83jddCy0MlJt7aJ/1JU6XGbLrjQdTzqUsvuZLvYJWyoJxMDUdiSC9OglJ82?=
 =?us-ascii?Q?1u/Rv1tUmVRn6vRW4kl6o8MIGPICQ/kMt886W4ROZL4pmUsTeUhtauP9BEDP?=
 =?us-ascii?Q?2ysuIQ2jCFUihawtY+u7jCdJ4ZfzZbRpTDQnqLHPG+xkSwQfttk7JczNurds?=
 =?us-ascii?Q?El8+Rt3lKb48Gn2JyzB9ZMhLTKdPQb8KLzWB6EKRBomuI/+dCeQ5XuLJMKu7?=
 =?us-ascii?Q?6vGcVw1r6gDucqGT2H4xjHnE1iHgGa5Mi7vHE0cWkmzikccSz0T1OBGyqrqr?=
 =?us-ascii?Q?ztLS+g33SoNesDNndnnfaHqV2YClb28MbtZqsZybe6atc1FXuxTVbar77HE1?=
 =?us-ascii?Q?kAfMlFC3poTSNCy+l1Ns2QbgBUT/Ti+w5RuRdaKKU9I3XasJLjcsDdWLom+E?=
 =?us-ascii?Q?mTs83K66ZY0ErGUxv1wnwgeMfw7QVcO8Vxv/qv5K1ABkHqvms6MaTgLHi1Dk?=
 =?us-ascii?Q?hvj2lXQFgPuXknZRs+CwNCiuURIRURKaWQ/0TjQudQ5dTHhX/2B8DF0kLC9k?=
 =?us-ascii?Q?H5NeDRgnZoCOpduUyYNSLVYZ48AKPDRNa5H/pftdiJ9R3uPRVOQlJ1YEi6Wm?=
 =?us-ascii?Q?UxTfhQgw8vwoNxwPoYJpnMZDK+cLMXf0IT8fHXwSGzBnjZ86JYPwYJ7ERQZw?=
 =?us-ascii?Q?f+dvKN+aI5BtBhBcZok=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 13:04:59.5057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cfed92-b4f1-4815-fba5-08de326c9081
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040
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

This series ports some of CWSR functions from KFD to KGD side for userqueues.

Things which are part of this series -

v1:
  Allocation of TBA/TMA regions for first level handler. First level handler is always from driver.
  Presently, this takes care of only dGPU allocations and is TBD for APUs. Backend to add second
  level handler is added, but there is no IOCTL provided yet. TBA is allocated only once and TMA is
  allocated per VM. It's tracked by a cwsr object which is maintained in userqueue manager.

  Adds save area and control stack calculations to KGD side. Also, support to specify save/restore
  area params while creating user queues. TBD:IOCTL parameters need to be modified to specify save
  area params. Also, need to confirm size calculations with multi-xcc and obtain the number of XCCs
  used by a userqueue manager.
 
v2:
  Remove association of cwsr with user queue manager (Christian)
  Add ioctl support to query cwsr size, set cwsr parameters for user queues and set second level
  handler.
  TBD: Handle level1 trap handler allocation for APUs.

v3:
  Removed 'TBD: Handle level1 trap handler allocation for APUs' (confirmed that APUs also use
  the same path).
  Rebase against amd-staging-drm-next.
  Fixes for issues reported by Jesse Zhang:
    Keep 2 pages for cwsr handler (TBA) and 1 page for TMA.
    Add cwsr_enabled in addition to cwsr_supported and use it for NULL pointer issues.

Lijo Lazar (10):
  drm/amdgpu: Add helper function to get xcc count
  drm/amdgpu: Add cwsr functions
  drm/amdgpu: Fill cwsr save area details
  drm/amdgpu: Add user save area params validation
  drm/amdgpu: Add cwsr to device init/fini sequence
  drm/amdgpu: Add first level cwsr handler to userq
  drm/amdgpu: Add user save area params to mqd input
  drm/amdgpu: Add ioctl to get cwsr details
  drm/amdgpu: Add ioctl support for cwsr params
  drm/amdgpu: Add ioctl to set level2 handler

 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c   | 598 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h   |  91 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  29 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  24 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  22 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  27 +
 include/uapi/drm/amdgpu_drm.h              |  56 ++
 14 files changed, 887 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h

-- 
2.49.0

