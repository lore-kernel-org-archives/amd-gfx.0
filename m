Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5996FC25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED4F10EE0F;
	Tue, 28 May 2024 17:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A8d2ihxJ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9714B10EE0F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h10q8oKb8Us7FW3+Zg7DDDyU/RNlA0E890LDlEJmwibCYB1sgsOITkHooiv08XBQOFOncz7ABB1/kmkSwEPT+ljYxLtTVZbv66H8/Wz34LjMPh+S3ObWFnd1XRmqKWy1trduVZqyBDl35LYB8kd5pYas2ffetmve67xrcMXPs53l2uo6JrAK6KKA6CNKAkx4EzN9H6M+YMvliPaKYbHfG72guFoFHBiNARAoic0ZdQQ9Wvz8nhkuGuL51BC9dGXREP6+iUzzc1ak28iwl0X7l21Dr9qGa+IQbA+AWiRU3CJ9onXhhuJHn7A9GS6tTk/IDhe8DOsWVd+zhGH8jr1VIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A2/jSJ/EI9WtXIEAbVecL+731GsQ6USWnWOCU8+vNo=;
 b=Bp3cMcrsS/zWOgXC1+esMhWlEnWNDgSm8dwhkYeaz5dSLohiRr5on+QS1UoWgYeteoHZhykG7oR2p5/gnIE3mR6J7sVWkZw6tl+jhfA+fCHB/n7cgIPTS4p7LxHrSpn+UQeJoxPCQj5E6Rtg2+W4DzhcxaQtEYSu9wvsHtk+Xy5cipQC8FhcYpg9qTuYNXXod4ls6LFfbVYlAfT0xMBjtCe7x9ZOQjCPhA8k0EbFRivSR/+GOqZe+O6nhFBFm77/swLZ7blRkume16YbwWaseDbdOsMuGJmJ9VV4frlISd1z9g9a4x/FDIBmZFLgABvBZU411WmA1LmJb/kQFoYIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A2/jSJ/EI9WtXIEAbVecL+731GsQ6USWnWOCU8+vNo=;
 b=A8d2ihxJ+S3T7CCWiMn838V67oiO6LQz93aZlPGu8zDlD4QC5A81DWGsYZBtn+wGN2wRN39+zys6VVMOyrrLrN9QlNqZOuGWs+s+Edyds6R3uX7C84tGXCWhz2kGwrQzSNXnTllBDW4ofqOrtr3P8IKL297UDmSNDbFfGX8L5V8=
Received: from PH7PR13CA0016.namprd13.prod.outlook.com (2603:10b6:510:174::9)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 17:24:06 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::91) by PH7PR13CA0016.outlook.office365.com
 (2603:10b6:510:174::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17 via Frontend
 Transport; Tue, 28 May 2024 17:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:06 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:05 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 00/10] drm/amdgpu: prevent concurrent GPU access during
 reset
Date: Tue, 28 May 2024 13:23:30 -0400
Message-ID: <20240528172340.34517-1-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 158c1092-9527-43bc-19f2-08dc7f3afa58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3nv7vhlHC2DLYibpd8WzDvqXKsyc/xzZP1uayuXGdeiYkjRM9Eu0FDY9OWVz?=
 =?us-ascii?Q?gPPivZwgY/kE4kfZDJaZgmr3mxdH2qoJ5aenb3+NsMP27Ogwya3RDjNcFNZa?=
 =?us-ascii?Q?KAUTo6OCwOZ9d9NU6rEFWdS3UysGP5uC68QZ9Viupsjws2ATwpFvZ8oYaoAO?=
 =?us-ascii?Q?/a6Kkoqxyx+oM2oSQkmn/uVNS3gtST2EL/4FQRG+fJRE2JGO9i0FkGNG7tNY?=
 =?us-ascii?Q?ek8RWtw6Z4IQLZZc/Dp4r5TUK+ony7kts+3MSLsjxeiz+27zalGE8mMCzrxV?=
 =?us-ascii?Q?qanPb7w2iSOL1NQO5fDG7IRIijJmXOTDZhWXkn5jeIqoqog/vv0qePQ63bh7?=
 =?us-ascii?Q?7kexLdkf1kW+whcKPtXV33SeTerkj2AMraxTcY75kjLNIvCg5eUCaAkxwZ/O?=
 =?us-ascii?Q?j5fp58/BSdgwr5Olq7bZr5kTDAA0Tu+Pu3dORutHnDwc4f0sooDjzDU3otfa?=
 =?us-ascii?Q?U/5wExMNMBetZEFbVDg7b9TCg6DIzfAFWFmVOqqZ3Z4KFHztiy8byh+AAYf3?=
 =?us-ascii?Q?HGiOmQs8jffVv8LkjyNmJ53QsEuQO3UlMLQDLBLoYiIMSQQG6T8L26gfoCjL?=
 =?us-ascii?Q?opRmdF0BI6TBd6EYej3xDPly9qEa0p4spxs/Q28o7IynpRU5Qka0SqAiBNsp?=
 =?us-ascii?Q?CziqqbCSt3Ou+iiM4IkVy9Ds9/IJKT4nRWNnS6iO0+wbJUy3l7E/wlbpUAHz?=
 =?us-ascii?Q?XtsODFAv9dfb1RL5zyiGfXnsNMWSzt4lwo1Kd8hRE7NSTGeQkp6H8M6PJ1Jy?=
 =?us-ascii?Q?fyRBn1sVTp5wM+NpisMDPPAC2IJ6vf0Kh1nvPznSfDc/cUaMLkuFSAgxQt/m?=
 =?us-ascii?Q?eQ/fq89Lhwk6KNS3vVS7Snz01Y5b1H8qUq30knhbbtamGfh0HLfrle9DXmFG?=
 =?us-ascii?Q?ff89RcWyjNvDtozh65X6kxpto258vR1AG7UPPF31uI6Rnyj3TLZprr96Zf7z?=
 =?us-ascii?Q?LMdyBhA+bRtpx4C8Z7TfUdSRd8HpA+Sawen0pkytwYkUG4VXEfppryVItMgy?=
 =?us-ascii?Q?T2al6bVu8/RczVuJTd8HdniztsudOKJCQRRFV3h+Z3N42C1SvkCOXiyDOp77?=
 =?us-ascii?Q?7j54VPiBUhveisq7RltZrwOdCE8SX9GLYVDQwNsIXJRBzbGOHM5bJYWInfwr?=
 =?us-ascii?Q?py2NTg5ZD62+EPWCw2qF9j1ZnYsNTekuYt8auwTPgvFssqqCzZZMCWWP5Grg?=
 =?us-ascii?Q?Vf2K8WTxaJOcPZztzHscGADBEqmSu6a1cUa9tXwD14ejuJ+hGCCh699flNHT?=
 =?us-ascii?Q?9Aq9/KQZSP0X3AvHR7DXHb2PVK+fwey7nJfLK1+6DYT1BHm3X4xG2AsZ40YG?=
 =?us-ascii?Q?gepbDO0xpC0/8p3gu+YDQE6RZRJnjdiIhMrDl1njhls6K7LX/yfuSQnUKo0d?=
 =?us-ascii?Q?n380bHE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:06.3582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 158c1092-9527-43bc-19f2-08dc7f3afa58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170
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

If another thread accesses the gpu while the GPU is being reset, the
reset could fail. This is especially problematic on SRIOV since host
may reset the GPU even if guest is not yet ready.

There are code in place that tries to prevent stray access, but over
time bugs have crept in making it not reliable. This series hopes to
address these bugs.

Likun Gao (1):
  drm/amd/amdgpu: remove unnecessary flush when enable gart

Yunxiang Li (9):
  drm/amdgpu: add skip_hw_access checks for sriov
  drm/amdgpu: fix sriov host flr handler
  drm/amdgpu: abort fence poll if reset is started
  drm/amdgpu/kfd: remove is_hws_hang and is_resetting
  drm/amdgpu: remove tlb flush in amdgpu_gtt_mgr_recover
  drm/amdgpu: use helper in amdgpu_gart_unbind
  drm/amdgpu: fix locking scope when flushing tlb
  drm/amdgpu: fix missing reset domain locks
  Revert "drm/amdgpu: Queue KFD reset workitem in VF FED"

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |  9 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 66 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 25 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  3 -
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  3 -
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  4 -
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         | 37 ++++-----
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         | 37 ++++-----
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |  6 --
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 -
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++++-----------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 11 ++-
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    | 13 ++-
 27 files changed, 164 insertions(+), 177 deletions(-)

-- 
2.34.1

