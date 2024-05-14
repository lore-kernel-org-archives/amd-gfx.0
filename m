Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B0EC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 11:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5EA10E56F;
	Tue, 14 May 2024 11:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EYq6vo37";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE4910E56F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 11:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2ISC8psxkUZD4RyRVDzjZAzccD3dcyg0QGIoU1cU1pbpolGxJnFhDh1aDR7yBenLmRLM27ViRhdr+8LxIyki7QsGXy2+XXUGEp7meBLCQ7G7eSfTAD4/o09OmJr5nQwav2qvNJYh6R5l+2xnvvhXfnajflBzB0L+29gXHQ9KZMTYjpN39r5fCJPK2CrGImtwh2UYI1VU2/uQQGIQLethyTSNo9+AJIrg/COP7LenelbuGVWWIIVrVJBFQ6olDASGy1NIdNV+Se3f6HLMtZi8JXc9F+g9Rwlv3/L9MeDCiZB3xxTPYBoIHeqaOABRVxvUD0PoTEzYrwo58wDTRuzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNppU+Xe3lT9No3hMjcQs00RJ5hQ7On0ZBz62uKbG5w=;
 b=PXFhmyL5JwnV3zm08viXKpFflNUI8vApjYQ3+I0vlVJ+cGZ4gL/xio6IEOxTcC828wBLfiMhDNiZEMy3VwBgOocQzieIkyvOhX9ITV0AUWH6bESwHQDN7YMb4h8RdUZPcBpOb8dbQt4duiDdstXhB00v7NtgWOIqRNoRDQfdyBKzRiNiqWZRWdG4CnK2AdZuPsKyS6Z3+xzQjl7TPOIubs3Q2rJPdt91roEh4cpEhkVmyizIRZKTMnSPEo4xD3UJCxmOkTK2QRlu0b5iK9vY0uMFEfwD9wAy/Xxo/D0sRySYv9Xky6Kd2fnKX7LGDM+QVSiQh9TUzIITv9wc7oeBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNppU+Xe3lT9No3hMjcQs00RJ5hQ7On0ZBz62uKbG5w=;
 b=EYq6vo37WzJpIxPe8f7hPYyjbe1e/j37CsFKte6DIA/25GIkMMHnCU9YgmDGQG6+XlJnYY3XSx8Hgs7Vh4hK/6bLMHjgTKSOc5LQ3o+vcbObW1AB8Ok2HEYsg32kEnshRylEViN/lnsxHzTlF043b3ta3N0PFHeRO2jCCIcA7u0=
Received: from CH0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:610:e6::13)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25; Tue, 14 May
 2024 11:06:23 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::8a) by CH0PR03CA0278.outlook.office365.com
 (2603:10b6:610:e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Tue, 14 May 2024 11:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 11:06:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 06:06:21 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Le.Ma@amd.com>
Subject: [PATCH v4 00/10] Add PM policy interfaces
Date: Tue, 14 May 2024 16:35:56 +0530
Message-ID: <20240514110606.396234-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: e32ff418-0013-4c50-5c14-08dc7405e47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PLWxNNonUd1XfljDxTEKLfQnopPxE4VgP4HsGgzv+jpN4EYbW05/xj3OGd4O?=
 =?us-ascii?Q?tfeM+FWQzg7eJkJ5pOygJsurL54o+KTZ3P1MGsABfKcKzOmWlZMkwQskVlHt?=
 =?us-ascii?Q?XgrTglQ/FKmZ7pJIteJtlUepjEUZwQx5ceIgw2zzNXDdCErBGrCjvlS+mmOd?=
 =?us-ascii?Q?1ILW2rMKN4hTIT9UrVQcfd/hKcxwCj0zwRwVOYpir2OzEZPs/5bFahfRshYH?=
 =?us-ascii?Q?OuzIHfyuvfh+LBmh+II2WmX1cpg0gkaW0lE+hWz+ov0me7Q/rFhP4U15xtYw?=
 =?us-ascii?Q?wmCwzhVgQPskcmvYXEFKc+KArtwXP96ukeL9LEXW3+DRDXhU1PGKEf/NedgH?=
 =?us-ascii?Q?OV0hbBiIZ5EPCntlaexDA1Knkm1G3/qjHXUC/JNo8+/jTnKaOuZUpelvrMXC?=
 =?us-ascii?Q?zY7wvuWguJgxD1FPvQ1S4njHTibXC4mHhDBb1di3KKUufw79tASuwwpsIdRM?=
 =?us-ascii?Q?qEs2+5meggYxDKELt7amrweZyUxghgdi7hMB3t4qKI2mGEp+7/SAJiVKAbE2?=
 =?us-ascii?Q?htQjgvvAFI3DeBAgu8jZY2GJ+3NHGWb7m3mVCEPjuMee7aIkZ5xVrjSIFU3J?=
 =?us-ascii?Q?8U2gJMQQNSNc4a8yJYZZpaDKox3cR0/vgF6vLxcTtAsTMoCR/ZSW8fdTOgpi?=
 =?us-ascii?Q?8WK3DuFc3OnFVkmoQnuTPOBdku5TE/GjPgDGNd2T+e4q7KpV5q2YyxqzBV2h?=
 =?us-ascii?Q?ZVrrd69YJL6FJNlQP0dBWT0jvtCIcajtDOO5yM02n4kQWrv9Tiy/rgLUfHRX?=
 =?us-ascii?Q?Z4tQH6W3QLLJUTDVGDOvTu0JcEkpjITMIJ+/QbEBf/hML1H/MNklUdGagaFM?=
 =?us-ascii?Q?fT3WNIU0sw3anfw9Rh9CjK0AHNRc7/yc50t53f8fC8SJr2W7G/gdnfqXuXtC?=
 =?us-ascii?Q?W7zYeFvmtoqRgXOs3mQkWkEkXhN57B/QuPRtsXPbsiKU6RkyAokbDjm4pLyr?=
 =?us-ascii?Q?ANoE8BOcuh/rH0RNrDp2hKyzhKrxwoGts3ZqkD2yinMD5zDqbEF5Uz846NBx?=
 =?us-ascii?Q?Tq4Ij9+/8dWJcRk9R0F8rPDQBBXaDKwbGNeE5G+m8ngFA0JuSM7Gvg4TqBF2?=
 =?us-ascii?Q?W3Oohl7Uei0mU/JHuZ5tdDVQqFV90AAmnpxbzI6bZlB3/a8H6yE5QhuN2gb4?=
 =?us-ascii?Q?/nJL1F7G6HvYr4yxe6q06D2V5UzLa8zvJCdwtb5VZF5jg3zeC6Si4ADtWX4j?=
 =?us-ascii?Q?QFBmccvcHS3PUaI/k9pJ8MKCNcZWs4d8Ewd7ny/A36uPcgksqVTdASNPY/bG?=
 =?us-ascii?Q?ogEWlzlRIFdyHR/66JSrdXbLvhqUzlE/BZBBbfCvTniEVum5SKmXlc7HqGah?=
 =?us-ascii?Q?XjmaODqEw6XybixZk0GO5q6ot7pkvDyLuyyad2V+yJf6CiFD1xhxVSq5d3uX?=
 =?us-ascii?Q?p9PF08I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 11:06:23.5597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e32ff418-0013-4c50-5c14-08dc7405e47d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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

v2:
 Add NULL checks to avoid access on SOCs which don't support any policy.

v3:
 Rebase and add documentation patch

v4:
 Use consistent policy type naming for read/write (Alex Deucher)

Lijo Lazar (10):
  drm/amd/pm: Add support for DPM policies
  drm/amd/pm: Update PMFW messages for SMUv13.0.6
  drm/amd/pm: Add support to select pstate policy
  drm/amd/pm: Add xgmi plpd policy to pm_policy
  drm/amd/pm: Add xgmi plpd to SMU v13.0.6 pm_policy
  drm/amd/pm: Add xgmi plpd to aldebaran pm_policy
  drm/amd/pm: Add xgmi plpd to arcturus pm_policy
  drm/amd/pm: Remove legacy interface for xgmi plpd
  drm/amd/pm: Remove unused interface to set plpd
  Documentation/amdgpu: Add PM policy documentation

 Documentation/gpu/amdgpu/thermal.rst          |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |   4 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  17 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  32 ++--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 136 ++++++++++++----
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   9 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h        |   2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 113 +++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  40 ++++-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |   3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  64 +++++---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  59 ++++---
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 153 +++++++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  57 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |   2 +
 17 files changed, 533 insertions(+), 169 deletions(-)

-- 
2.25.1

