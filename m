Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B21EC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E5961168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34E5961168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7E16EA2F;
	Tue, 21 Sep 2021 18:07:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48896EA16
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A75GVSy1fpidvoBurOtozQqXueIwAYilPWHow4DKuUgpqX7pQR5YUb03108rzXPUEGWcQCAdN44s8zMMoN2Xe3V3AgOPEHlYnJDr/xeFFnrNHY6gtFJ3KjBuiq40N7Krylkb6BxOdwj2NQTLaTF5q9CXIzahPwvvXGgyOfKZXwzkA3RGT3NabknjtAJFbQ0R8BJUrUDKxZKkRf+nwx8Sey2XnNILT+ZrLvXzK/6yHHiv6nq+XIxTVTzjmKmpBoCcFhI/CciDWJO2tNP+linWwqlz8TOdiOelCF/mki05HV3ttT39hFqNcy6/7IHuiZ2JLYLbfQZz/akfHJ4AFqROrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=UFPorUYioww0gcNnChYKPLUOqVLFP1U8mKuSsoOqdjA=;
 b=agSd89nqx6UL7l8pKOVfPrtwiEvTleoAYjEaoxD0tRxUSn2Tbp3uOel90IE9HGN0thppwPsvbpVnJeclQrkLwWDlRXMocYDhioZ1ONK1pQm8qVb9kKhWgwt0qx8D9hesbvbiEdIcZtF0v9jQ9S25rcJsPuej61IkTmoZUgJle/jk04SdCj7GtPnzGs2j88GWJE/8ZAhMnaURnz5uVOzWuI4cAkGgPscTQQbnuI8wqJG/KGHw/J/Dpry06U4HsRmqWDzCditBiSr4MjKbd+zvpjysLHyQTt2wqUjAqCJ8gX+WFvNkyCmXKwSQ48+Cf2Ef7FoZpsd+StVny7zU4hcV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFPorUYioww0gcNnChYKPLUOqVLFP1U8mKuSsoOqdjA=;
 b=Tj5bx4CwfMLq602taodTSqICoHo7RcvZjjIt8umh4w3OD4XEsgz51ThXxZR7+TTNK9pMCXF4KRb5atOw0yCKKDjw4f8THcDLk6Jxa/UxIYOvFbIMRB8MNPwoVAd3S0qar9JY4WhvAesD0/f92P4l2RoR+/RRfxVs2WCnIS/wfyk=
Received: from DM5PR11CA0014.namprd11.prod.outlook.com (2603:10b6:3:115::24)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:40 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::51) by DM5PR11CA0014.outlook.office365.com
 (2603:10b6:3:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/66] Move to IP driven device enumeration
Date: Tue, 21 Sep 2021 14:06:19 -0400
Message-ID: <20210921180725.1985552-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 327f0001-8347-43bf-4e44-08d97d2ab3ad
X-MS-TrafficTypeDiagnostic: DM4PR12MB5182:
X-Microsoft-Antispam-PRVS: <DM4PR12MB51820D133177F234895935EDF7A19@DM4PR12MB5182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJGzrVrrF4Yjks3VkYfkRZiHpOj10s6YiLyCnW/capPOfJWo6JtiyJQiReU/DZTgvxWtnp7CgpRSLmdJK+v5j4hcJwmKb8dw+/AyjRBIY5CeQu8AYXC22nYwlNBXNajGeGTlzTGPNn2ackjpxgLsoeN5P3apYo/75ieAnkNMLBaZB/NMJjsofQPAreTw68FDLSAWIlzxloBJbIIyJeCqV5XgP9vwLupcnKv0BlEpnZqZaQbUokKVUF1XgyJL3wnQbKndy5EWxIZnjgPl5aZbAOq5pYPa5aCoerk8NMnHP19hhoGXPgNpUZu23xE3IVGPhIs6Eq6u98P/c6B2/RpGhzmbizbluj4rtS6usnQT9z1fLf1gHtFYi7dfeBs70eMb7xMyS/zkH7OeWApOxtbfHoT3cd7wYMpxV837jGwuaUidBsngUkAkM44JSSx9Rza/+wfYPQ7rCnPZSEoIAGaR0tXohUwpAGrQuyprRLlr0prv5BJtg6hnaV6lFVU3T6UJ+U1jMevEpfWvC42Lxh230z1vFjJ4/kbpLjOTzC6kHrjTz/D+56iu60njAZaeBijOikf5/iK3zNSOo2GWDgmuYFxGQsFGXWSm6Dgkj/yAs4KRVsmpATmmkSQtW5FjN2avo+CDHLD/xM9oUj5KRIUG2cssCIKIJgMnmzTdBPHd7IpY2pBSdQ2LMvywP7l6EbDyKIBFvwM6KCPu59zZ74VjkyZnpDZIM6Z2DmPkOkQLuqQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(316002)(83380400001)(6666004)(4326008)(2616005)(508600001)(356005)(426003)(47076005)(336012)(82310400003)(36860700001)(70206006)(8676002)(70586007)(26005)(16526019)(186003)(2906002)(8936002)(86362001)(7696005)(1076003)(5660300002)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:40.5424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327f0001-8347-43bf-4e44-08d97d2ab3ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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

Alex Deucher (64):
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
  drm/amdgpu: drive all navi asics from the IP discovery table
  drm/amdgpu/nv: convert to IP version checking
  drm/amdgpu/display/dm: convert to IP version checking
  drm/amdgpu: add DCI HWIP
  drm/amdgpu: make soc15_common_ip_funcs static
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
  drm/amdgpu: store all instances of IPs in the IP version table
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 818 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 578 ++++++++++++-
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
 drivers/gpu/drm/amd/amdgpu/soc15.c            | 167 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.h            |   4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  12 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 259 ++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 216 ++---
 drivers/gpu/drm/amd/include/soc15_hw_ip.h     |   2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  89 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  50 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  24 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  96 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  22 +-
 include/drm/amd_asic_type.h                   |   1 +
 43 files changed, 2595 insertions(+), 1131 deletions(-)

-- 
2.31.1

