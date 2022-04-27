Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA52C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:24:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9602D10EAEA;
	Wed, 27 Apr 2022 15:24:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B463710EAEA
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj86y/OBVGNC3MI7zyvSji+XV2GfaTMoR8KToj9jRKfLN3coa6jDut1ZEaYb9GGEKuBhsfRaMiv5l8cHGvQ93nPRh+qASHyzI6KbvsQKEbxNN5YjXi3zp50eYhFMhLSz4sX7fuJ33lf74NESoOqGHUMWz7MKyoj+uvtoJzh/MRxlG/zSs8ZenxIwp+qbQ+JefVLQ1OoPR8Z8Lo9FPwZduwS6HsxLR8OkI3Lc7nlnCrDRqe1MVotLx3VFwzKziHYguWthVqSeQFj2iisM39M0EXneJaWnBZniruK3Np2A+IRfs0nWsCSWXf2fUFFTJkHNlWAOu7dBC41EZkgGmzUphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avb0J+LfhcsFGJ+epS2w5h0VHbpb4IAGf4+uRItKvcY=;
 b=Svmow3mRPCCEQfvft/o9ZesfHsnxwndHNFfTHC5Hkf9k1wzE0zN/yvTlXpw0Ldyji2MACmARFhrqThfoZgOZIa0ri426eGGWo2r1TWvDOBL1wN0V3v+SPJSsxVIdIXNDLYHIBQjihsqzt7TRUrFxmWfs5fyFEe2BG7BJDFx0ASNBfpbzpoEdl6cmw2bVp9Z2691wJUa+oU+03p1TyDjTrE6DQ16OVW6a6CtRTpJq5rgSXC9RZiRAUAopBDN8Ul1h+S2BjJd0kuxd33NXiD425bxZ1koELcg0n7WB8/1j+A5gyWLQH3AI72U95dHH1VCmDc62ey3TlASiTGW7LC1PFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avb0J+LfhcsFGJ+epS2w5h0VHbpb4IAGf4+uRItKvcY=;
 b=SIu0iNq6uiFWhkT4xq+LCfOpFSLROZ3iOfJLiETeP3ascMUVS++zRThoGNJIkQ+7BUGCG8Y4yikHNuTdY+oLAgryXlXiJOMuYdGVfJcZA8MfXwZBXscJXQuVhXrzdckN4VgjAV/L2UByWBZFvjZ09ocInItmA/QdEPxyrvgyU1Q=
Received: from BN9PR03CA0747.namprd03.prod.outlook.com (2603:10b6:408:110::32)
 by SN6PR12MB2781.namprd12.prod.outlook.com (2603:10b6:805:67::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 15:24:19 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::ec) by BN9PR03CA0747.outlook.office365.com
 (2603:10b6:408:110::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 27 Apr 2022 15:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:24:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:24:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add HDP v6.0 support
Date: Wed, 27 Apr 2022 11:24:02 -0400
Message-ID: <20220427152404.3107627-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4859c6e6-f772-4b6d-c86d-08da2861ffb9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2781:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2781BFA21034A35549458D2CF7FA9@SN6PR12MB2781.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /fw71xHvJbMCOAg4SnSwT2wNhLpeZCdCy3OxUl3Iasa3hFjI0VWoEgI7QLZdTLrYVY0cOd/LzLr8+S1l2ncG4wQ8KjxPrAYQtEKWWSFk+lczASeQEowcGisaowcqrGuNy7lM8xe5HVw/ajwcYtgn0pYFrX8cudBXw3DTstdY10v9yp2nAcA7AZ9MXesw+R/sg7VkGwxquzfgUNQ3ZrDBlgsv3Y73+Jz/FN5X+yB4RRdBbPo1C97efiFqDOettQBcIZ0AdlQ5/NUdWAmg0HOfWbDKzLAp/j5KmqHycXcAB5S5rj4FnOBT87bpO3Z45GQgOxjg3sLoyW4p9cDB/jxFqPUr+K2rHMj7+y5b7RnFnlWD+PA9KEsU6cpmjXoK3sdtPpEspNGlvG4cJLWw2r6eGF/Vn37CMet6BW/cMDRZp0bvkiuAUbfNRw0lwyZCECJ17qMJ5Y1sVmdNhNbqn7SvvrlcjcpFoTRCiyDdiwPd/9h/kD1MLjf1Fa0kMwpqnI1Sx/juaO++ELfIJJ2yx0geUSKFUpdTDeAU7Mxs1CwugqUWclZwbXP2XifqMXy9F0NMNyx/krXoLgKYgFzWcxgZeCJZTtrWNTRE0G/Sv8ZmMTQBH4OKmewJbVXa+0AtKcmt/0rZEClqyrF4wrOHS3/UOIkRMtAoyGA+KHw1cG+HNreghI6tVgnQWGugSQyqJaU4u5FfSTA5NfFSjkC9wvOjjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(83380400001)(7696005)(70586007)(2906002)(426003)(1076003)(336012)(47076005)(316002)(6666004)(81166007)(356005)(5660300002)(16526019)(186003)(508600001)(26005)(8936002)(36860700001)(82310400005)(40460700003)(6916009)(36756003)(70206006)(4326008)(8676002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:24:19.3025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4859c6e6-f772-4b6d-c86d-08da2861ffb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2781
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set adds support for Host Data Port version 6.0.
This block provides the interface from the CPU to VRAM (e.g.,
the PCI BAR).  The first patch is register headers and is too
large for the mailing list.

Hawking Zhang (1):
  drm/amdgpu: add hdp v6_0_0 ip headers v4

Likun Gao (2):
  drm/amdgpu: add hdp version 6 functions
  drm/amdgpu/discovery: add HDP v6

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c         | 100 +++
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.h         |  31 +
 .../include/asic_reg/hdp/hdp_6_0_0_offset.h   | 209 ++++++
 .../include/asic_reg/hdp/hdp_6_0_0_sh_mask.h  | 646 ++++++++++++++++++
 7 files changed, 993 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_6_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_6_0_0_sh_mask.h

-- 
2.35.1

