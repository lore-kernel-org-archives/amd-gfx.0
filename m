Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCF0C54E58
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Mar 2024 11:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82CA10F1BB;
	Wed, 13 Mar 2024 11:03:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ghLMqpuM";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F6310F3A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Mar 2024 11:03:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6Rm5d17KZSOtFmChFhJS7krreN16IXwJtE1koGpNpPki9VbMGDslgUvuD0By3qSbkr8FuiIBCH+4UNPZWAahvQUpv9z+++rF4uI/7wM/ktM3NtSp3LOzd8Wu8UHUZlT+XUo6nWbYnf4IgwS7gZ3aCjfVZRsyymrHqNp4sSsVXqM5+btW2lDWAITym+XnE5eFnI4EbG+5Ub1iW6XaXYsOWPsJ3jjosDtdoFHp8ZPgQDVsB7c4/fTDQBVsGlyZXSaOQLpdRVILjeY2hoAFgGejt3BPwRAjICeTkRI8O26n0PT5UJbtr69RIR+KsiHrYSHT5KKnmMbTMxPQN2SPv9rLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvwRn5muYNk12IOCVV5a9Lp3ep2+kC1tEx7Qy2DUPNk=;
 b=Tusd5BmbIFv+d5Lmyw0VE/KNdVE9HwBSr5bfufWn5wbsmKMyoIsKr7WBYAs+7CFBSwlwT1B3zNU8AgaU9t+M7v+Wy//Yedjqj9ql+oOO3GMzLAMsWqulCqEkO5PYEhOCpJBjrVGmVpwOYSsjj/AcEQO3cMM0ky6kkDHbVgEAMTTg68VNVJSnxlxi17Cr7yZ4R2AHJBkG9BNEAQo6u2nT86ShPgiy9LvNSEjAXrwl65T+RpgBmDOb/Xh03GHJhurmD3gCzbj2hcywlSw20YMuPIctqN/CNpiqHdf+51qLvL9ki6iXTFnxB5TuU+eLr6eaz0AHpGHvLNc3QP5w11KgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvwRn5muYNk12IOCVV5a9Lp3ep2+kC1tEx7Qy2DUPNk=;
 b=ghLMqpuMYSEoUdYaCRrJxNN0FTueM9ctg3/VlbS0AVPMrDSsX1QZDAuZRpZxaQYdUPM3X228PXYRzKxJC/zgqprlsIdbk30He7lod/s40NPavVGCRBGWOTs3O35H5psC2ZmkXwRT3FPAtO94okPpxBGtqUWHr6GtdnS9Vs7ZzAA=
Received: from BL0PR0102CA0046.prod.exchangelabs.com (2603:10b6:208:25::23) by
 PH7PR12MB8038.namprd12.prod.outlook.com (2603:10b6:510:27c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.34; Wed, 13 Mar 2024 11:03:20 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::6d) by BL0PR0102CA0046.outlook.office365.com
 (2603:10b6:208:25::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Wed, 13 Mar 2024 11:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 11:03:20 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Mar
 2024 06:03:18 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <shuzhou.liu@amd.com>
Subject: [PATCH 0/9] Add PM policy interfaces
Date: Wed, 13 Mar 2024 16:32:47 +0530
Message-ID: <20240313110256.669474-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH7PR12MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 0118530d-c5f2-4554-7cb2-08dc434d3177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OesOBEk45ADb7S+1Pdhyo+qSW5dvKg9kshzu2s1QZXnI4O7wzs4IdVX0xMYgqO0unODflrucUY4lsBxUQv/mfATWJ7h/k1nq8B/cwnNHIbfaDrQvblCC5P/8KcEADRIoi8DiG91baYzg3hMH17CTvj8Ogv2LlbLi60KjNj76wnqdswCbyfu/Dj+mREq0Sfh+Ybv6R7rz2OIIaJ3frzrPNRTnhXX0OeG7jTd2pnYpc32PsVqXQNnasMkDdypc/WyuHPoHQ2wmleygEUup0ZdCBf6Uqc7dpfb6fo/7aMwEvYJ7qHbGK8hc2CQ56wa8K0EtKkJluRvIXpnCAoYgZ8Iq3D2r757wZ2tOxrHxVSiXFthshbIb3TwIbrujaIs0+nJY5B9H5wy8r/WXZick7/+7PQGx8pnfb1XgLqOplRgT4aCGCJRr4p5kk/u2pKMxSDJN29ps21VvjJunTN9rO/rpPdWLx9uqem9+c0BxskbXy+P17E53YuJLLHB0/L9q+HZedT+oz7SSbmM6D7ljVMvCFj9d+L4tRwlrr98Nq5j37sLbDP3qLRZK/Ll0OOwZ0Hw3YuT98a5/RYm4/yaGc9rcUsu2mTdwX0cLTZa4ceCO74SMcgHu0O8/OW9YnCcgbGbTAxJGHuYXylG771FF4S+637m/bLaUCe7CKebToVdDM5HyCEspiR4jb7FLplWhBJuUkrNdmUkNsu3DvwbQz0wTBFCdHKLmVE8LpL0Ll+HxoyenJQbJIRb6ThNWjNEzmKWm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 11:03:20.0756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0118530d-c5f2-4554-7cb2-08dc434d3177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8038
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

This series adds APIs to get the supported PM policies and also set them. A PM
policy type is a predefined policy type supported by an SOC and each policy may
define two or more levels to choose from. A user can select the appropriate
level through amdgpu_dpm_set_pm_policy() or through sysfs node pm_policy. Based
on the specific PM functional area, multiple PM policies may be defined for an
SOC For ex: a policy may be defined to set the right setting for XGMI per link
power down feature and another may be defined to select the SOC Pstate
preferences.
 
Presently, XGMI PLPD and SOC Pstate policy types are supported. It also removes
the legacy sysfs interface to set XGMI PLPD as it is not used any client like
SMI tool.


Lijo Lazar (9):
  drm/amd/pm: Add support for DPM policies
  drm/amd/pm: Update PMFW messages for SMUv13.0.6
  drm/amd/pm: Add support to select pstate policy
  drm/amd/pm: Add xgmi plpd policy to pm_policy
  drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
  drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
  drm/amd/pm: Add xgmi plpd to arcturus pm_policy
  drm/amd/pm: Remove legacy interface for xgmi plpd
  drm/amd/pm: Remove unused interface to set plpd

 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   4 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  17 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  32 ++--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  87 ++++++----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   9 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 108 +++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  37 ++++-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  64 +++++---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  59 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 153 +++++++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  57 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +
 15 files changed, 468 insertions(+), 169 deletions(-)

-- 
2.25.1

