Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2223C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7E5A6101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7E5A6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 246926E07D;
	Tue, 28 Sep 2021 16:43:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C5F6E07D
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:43:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOUzFbNC13Ptnwss5I7Ad2Z7q/yOmBcCOejhGab3Im6+QJrHJEl6mroucDljgaZteKkW/L7IH/dX9ezXDpxdNVYGj/avzUmvJAkG/bIl7RKEapjx06mRe/dCxEUxKHznxLejq81g2xs5I93zWW2uauO4T+Ih3MYFk/ZavFJujhUzOuIS+6FOihlrjrGi+W9yPNmCuWBb+49v3u/or2sQ0WALiL/yMwOAJz0O8LGRz4zE/9DkGybdx4N5SrJ0lcBNPoU2jzADbapf4DbeZptQYTMOTIV4N3KxX+7CmNBuOnkGVfWQYEMe54ODrnkAlYOY3K1g7v7DhI3SsdoP/DupuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/xjmPBNEPp5ZQf03glklPu6Yk251F3/KFMGZY5hD38o=;
 b=Qh+mC1qm1XEOinG/07ZlAfS4m/g7r6Z+gFSpF3qU0DlSZgJvJfKF+dM9zfQgmlyq4T7lZYe5hQZklhL8o84uUC4LcLfW9GRjakxyRhJkPNIgVa4c8NLAUxFjPR+aPn4wQ3o4zxidpaJTwYKP1H82Ixm3caZDlY98FH/+bukCzMzD+KJoADyTYy42ZIMeMsZ5/Q/CU2OAlLwUU6+MAnavSIVh+U3jF883hzWa4JJCOC5KaNtOAL9cnCW/3ww6Kh2SHpu1qKg7YK9zP6zHBoAxzc1Ts0mWD4/lRfevfEHrNo2onPxnHtWdsyYLHWWbdxV/7p05sLaaJBkxf572NFyNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xjmPBNEPp5ZQf03glklPu6Yk251F3/KFMGZY5hD38o=;
 b=YHniz7/heZzHWz2SMDV2LomG3699nRGWFVb5i/wAMyjn5gx4NQswl8d+kGa/bLOMC1X+DvX+2VussUx16ztkxzq6ARjP7wMckSwwQLJCW8/yAE27zHb4ylnjJryJrblEDailxul9guLpfEvvBnISb1yAyNesIe4ru2zX3t990fQ=
Received: from DM5PR1101CA0012.namprd11.prod.outlook.com (2603:10b6:4:4c::22)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:43:02 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::48) by DM5PR1101CA0012.outlook.office365.com
 (2603:10b6:4:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13 via Frontend
 Transport; Tue, 28 Sep 2021 16:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:43:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:42:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 00/64] Move to IP driven device enumeration
Date: Tue, 28 Sep 2021 12:41:33 -0400
Message-ID: <20210928164237.833132-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca832425-4bf5-4cb9-57b2-08d9829f09bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4958:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4958952D72711C96AE188A2BF7A89@DM6PR12MB4958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Atg8P7u+guorq5tdaz91I4XNB09AaFSEYciLIq91g2IR6ibGKrAco8Pleuq7eKRYDscjyKG8d/UAwLI+I++MP9qkUQBR5fM3JsAsMVOP+GKaAjICDw/EGEMZmCT2MOjhT2hFYMemry2RcdGRco3TpHyJmlPEvcY/gM8koS7L1k9DnrdMABJG/Azrvx7/q3ruQwgXIYujEfkWhW9LSN8WsMngvbCa1fi5PVDZX/trJwG2z2s8sm4BW9GH5xCQCjBLb+BlC93D8eu6a0Wkwg8NCdWgLyZwraYaCG4r2XNaa70ZMLJ8fM9o8wpfrKsdQWAHdaMbZkonbmrLmIX+5pldK2AGxYpkPmwt3kYgZ1nRMBVtayA1wWlyIUHghSrSDKFzd7r+VGAE+9rjpGe8lGrkmhtEt+9JR0MBBFHk7I665D09GKlG02A/+om8k7zic/EpHl7Naep9kufrelFyaftyGMH6tx42BUyb4HfN4/syBKgnIz9QioLjE35SOeryAlrDTYjYWo3UdG/lrczVejGd5vvAvoccuhnGIHIE/abn8bxYG4AzMzGZWo06ZozSlf20VtmYBqO9u/4lbG+FdbLmyaRoyqgCANIsbuvvxWNleeViMTAfImbmvG/WTnk7FV1Oy7icSbl1ZcM9bxENin9vYs9Zx/Uilmw05flMFdsmip5oZMKGJRDcxC1TqtD+F4FizJjAoOLegmOX7Ej9Gmq0ekq8vySibTc6SoVoDHxHhZw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(508600001)(36756003)(316002)(81166007)(6666004)(83380400001)(36860700001)(186003)(8936002)(336012)(2616005)(4326008)(16526019)(47076005)(8676002)(82310400003)(70206006)(426003)(1076003)(70586007)(2906002)(5660300002)(86362001)(26005)(7696005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:43:02.3630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca832425-4bf5-4cb9-57b2-08d9829f09bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
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

This patch set moves the driver to an IP driven discovery model
rather than one tied to PCI device ids.  This allows the
GPU driver to claim all ATI PCI display class devices.  The
driver will then either load or not based on the IPs (GC, SDMA,
DCN, VCN, etc.) that are enumerated on the device.  All recent
asics contain an IP discovery table which enumerates the
number and version of all IPs on the board. This avoids the need
to add new DIDs for new parts even if the driver would already
otherwise support the new chip (i.e., support for all of the IPs
are in place). It also better handles asics which have different
numbers of instances of IPs.  We can just use the IP discovery
table rather than maintaining hardcoded information in the
driver.  Finally, we can avoid adding lots of asic type checks
all over the driver to add a new asic if the IP version is
already supported.

V2: integrate cleanups and reworks from initial review

Alex Deucher (62):
  drm/amdgpu: move headless sku check into harvest function
  drm/amdgpu: add debugfs access to the IP discovery table
  drm/amdgpu: store HW IP versions in the driver structure
  drm/amdgpu: fill in IP versions from IP discovery table
  drm/amdgpu: add XGMI HWIP
  drm/amdgpu/nv: export common IP functions
  drm/amdgpu: add initial IP enumeration via IP discovery table
  drm/amdgpu/sdma5.0: convert to IP version checking
  drm/amdgpu/sdma5.2: convert to IP version checking
  drm/amdgpu/gfx10: convert to IP version checking
  drm/amdgpu: filter out radeon PCI device IDs
  drm/amdgpu: bind to any 0x1002 PCI diplay class device
  drm/amdgpu/gmc10.0: convert to IP version checking
  drm/amdgpu: Use IP discovery to drive setting IP blocks by default
  drm/amdgpu: drive nav10 from the IP discovery table
  drm/amdgpu/gfxhub2.1: convert to IP version checking
  drm/amdgpu/mmhub2.0: convert to IP version checking
  drm/amdgpu/mmhub2.1: convert to IP version checking
  drm/amdgpu/vcn3.0: convert to IP version checking
  drm/amdgpu/athub2.0: convert to IP version checking
  drm/amdgpu/athub2.1: convert to IP version checking
  drm/amdgpu/navi10_ih: convert to IP version checking
  drm/amdgpu/amdgpu_smu: convert to IP version checking
  drm/amdgpu/smu11.0: convert to IP version checking
  drm/amdgpu/navi10_ppt: convert to IP version checking
  drm/amdgpu/sienna_cichlid_ppt: convert to IP version checking
  drm/amdgpu/nv: convert to IP version checking
  drm/amdgpu: drive all navi asics from the IP discovery table
  drm/amdgpu/display/dm: convert to IP version checking
  drm/amdgpu: add DCI HWIP
  drm/amdgpu/soc15: export common IP functions
  drm/amdgpu: add initial IP discovery support for vega based parts
  drm/amdgpu/soc15: get rev_id in soc15_common_early_init
  drm/amdgpu: drive all vega asics from the IP discovery table
  drm/amdgpu: default to true in amdgpu_device_asic_has_dc_support
  drm/amdgpu/display/dm: convert RAVEN to IP version checking
  drm/amdgpu/sdma4.0: convert to IP version checking
  drm/amdgpu/hdp4.0: convert to IP version checking
  drm/amdgpu/gfx9.0: convert to IP version checking
  drm/amdgpu/amdgpu_psp: convert to IP version checking
  drm/amdgpu/psp_v11.0: convert to IP version checking
  drm/amdgpu/psp_v13.0: convert to IP version checking
  drm/amdgpu/pm/smu_v11.0: update IP version checking
  drm/amdgpu/pm/smu_v13.0: convert IP version checking
  drm/amdgpu/pm/amdgpu_smu: convert more IP version checking
  drm/amdgpu/amdgpu_vcn: convert to IP version checking
  drm/amdgpu/vcn2.5: convert to IP version checking
  drm/amdgpu/soc15: convert to IP version checking
  drm/amdgpu: add VCN1 hardware IP
  drm/amdgpu: get VCN and SDMA instances from IP discovery table
  drm/amdgpu/sdma: remove manual instance setting
  drm/amdgpu/vcn: remove manual instance setting
  drm/amdgpu: get VCN harvest information from IP discovery table
  drm/amdgpu/ucode: add default behavior
  drm/amdgpu: add new asic_type for IP discovery
  drm/amdgpu: set CHIP_IP_DISCOVERY as the asic type by default
  drm/amdgpu: convert IP version array to include instances
  drm/amdgpu: clean up set IP function
  drm/amdgpu: add support for SRIOV in IP discovery path
  drm/amdkfd: clean up parameters in kgd2kfd_probe
  drm/amdkfd: convert kfd_device.c to use GC IP version
  drm/amdgpu: add an option to override IP discovery table from a file

Guchun Chen (2):
  drm/amd/display: fix error case handling
  drm/amdgpu: add HWID of SDMA instance 2 and 3

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  44 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 822 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 655 +++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 101 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  47 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c       |   7 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c       |   9 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 380 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 227 ++---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  91 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c         |  15 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c       |  73 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |  13 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |  91 +-
 drivers/gpu/drm/amd/amdgpu/nv.h               |   2 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  44 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  14 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        | 100 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |  32 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |  51 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 163 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.h            |   2 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  27 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 259 ++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 214 ++---
 drivers/gpu/drm/amd/include/soc15_hw_ip.h     |   2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 124 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  50 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  24 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  96 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  22 +-
 include/drm/amd_asic_type.h                   |   1 +
 43 files changed, 2702 insertions(+), 1147 deletions(-)

-- 
2.31.1

