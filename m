Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA27DC54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 19:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5507A112C81;
	Tue,  5 Mar 2024 19:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wypEpWNv";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04658112C80
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 19:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzxWrCKwhzpYzhMUwV9DsGGUBG+jufkae9ehMVss3fTdfR9PF2OW8xnYes1vHOL+WCp7phX/RNFHx6wKN69Th9zUV026IEku5Mc79KA/Z2cbV0RjMSLHY+skCWXP1IOfpH+Gz64ifrM3mw8vMWizhUKwwQWOluiYqQl1n0wQ3UCCgoaCld1YUmOiMgOr0/dkxSvfLT9V9Uuaie215VyxQplpv4l5E2mr/Byk+a6kpDNbDVFswVkZ1C/heX+9X0mcZg5rBDz8eAbpiVzpZUCLzZ4s1+lXoZ30usKBkbF40HQW0gp8MyMkTWD9NFkCSjbEtI/V5m33cmf/zYQLsv2Meg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH/CyosmythBcyS9g5NrJwLrkIeqKIT7YbIFej5ulD0=;
 b=PxX8jS+k1SuEuq0N6kMrb07o68LhNoEgcgMtyX2HX10/gWiyBXhEHse5UynUDWr2o4/3obJgid6b4ramUKK0XtGANVRDSMkdQFV4EqgTa46xM1vfqXGQtxjC4Cx0C8HtlOmW6WwHSyXW+y/C29gyjXw8a2B5KZ3jesPA7mBpdpx5vSBk/0vD0Ue4z09PnYxesyaqP+wzJFZW7OmJH9V1YYb2kfmHxFrQzuQFXq8tObzGuZqs4HDiXVesBlTCV3KFzcg93LMqC429jOm4e8i5y7X3XEFRzuEvntpulBEqjqkpv4ZDATZz5i/uC7GcxrKOAG3J/P317DcJauuu34/qUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH/CyosmythBcyS9g5NrJwLrkIeqKIT7YbIFej5ulD0=;
 b=wypEpWNvmlArmemWJGuTaRos8Ld84Gk38RYDJP9iBY51Wogrh4WAPe92OUQqRdUM36a5fw7AhL6t9rc/k6pVv3u3JFECrXGMYg7VmF3zCek/2cSiWlVkLRMThrkmjUAXQgfnJPrTFGksfrwWvLmx9qbfgXCgkzBTINrlwRri72Y=
Received: from BL1PR13CA0068.namprd13.prod.outlook.com (2603:10b6:208:2b8::13)
 by SJ2PR12MB7847.namprd12.prod.outlook.com (2603:10b6:a03:4d2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 19:47:32 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::31) by BL1PR13CA0068.outlook.office365.com
 (2603:10b6:208:2b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23 via Frontend
 Transport; Tue, 5 Mar 2024 19:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 19:47:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 13:47:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/4] NBIF 6.3.1 Support
Date: Tue, 5 Mar 2024 14:47:14 -0500
Message-ID: <20240305194714.1783500-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SJ2PR12MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8f9844-6029-46a7-3526-08dc3d4d191e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1Ufpz7iBz6vtmAZVHGFAlZzGPZSs+qEPsxMH97MSroD6supn2iG1bFhMQemR6t09bbIexkT4ra375+xsYpHS/s3vmVd5yBWVrwvCs6JViXK0oYsr94T6aVl3H+IPGlweKZcVJP2LiinbqzC13CxJsrRDwxAkwjbJGpN1JQ/nWJh253DwRozUqtHJ1hYHk5GmunOAJfXZ+SnNtLaNMBfMeOTCgboySxyxD/+T0gL6cQNwbYCnK8dvn/u8Vw1VzO5D/oWd57L1PxRT77NTD0KJuPApxj5dD4IHoc5eXXw06QJr90qM+SH6zw2M+u84EqcP1YKv2ILS2Zuwr83K1zxo4bJ578Lfj/kv2pugpr3/use9rP+T200k/+YRsqsp/5oWmvca3rAORyBjzNcFoPT9L0Zy0TEE6TrqIV+Yulb6o5LtEpXd/Z8yiLncpDtsDhDk5RGItb4C2DsUYPiGxSZi5gWms2EstQUj0sxmO/DqDFgd0coZF+n5WB6O0TvXLxJRLvewcFuyeQ6tgVI2iSE20CG6bZSzaoO1HkqhsYwR9RrS7fjTvkSL3+7LOJOAKxOi0e41ykpvqSP3W76XdZ74j2n4XTU2XhUTiHfGrP9pmZLemE4L7a+vaFCpyzs9SE1sRFExGQeoaapuvc9/7XSAQSFWVetu5lNM8OiE28MTG3tOx0Xs1wJflWFpIOeWJqFr26brMiCH2rc23i19CFgfObx/NM8U0V+kao/705sD0Amr3XEc6wLmB91L4UezezZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 19:47:32.2485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8f9844-6029-46a7-3526-08dc3d4d191e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7847
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

This series adds support for NBIF 6.3.1.  NBIF handles
the PCIe Bus InterFace on the GPU.

The first two patches add new register headers and are
very large so they were not sent to the list.

Hawking Zhang (3):
  drm/amdgpu: Add nbif v6_3_1 ip headers (v5)
  drm/amdgpu: Add pcie v6_1_0 ip headers (v5)
  drm/amdgpu: Add nbif v6_3_1 ip block support

Likun Gao (1):
  drm/amdgpu/discovery: add nbif v6_3_1 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     5 +
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      |   495 +
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h      |    33 +
 .../include/asic_reg/nbif/nbif_6_3_1_offset.h | 11287 ++++++
 .../asic_reg/nbif/nbif_6_3_1_sh_mask.h        | 32806 ++++++++++++++++
 .../include/asic_reg/pcie/pcie_6_1_0_offset.h |   630 +
 .../asic_reg/pcie/pcie_6_1_0_sh_mask.h        |  4250 ++
 8 files changed, 49507 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_3_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_3_1_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pcie/pcie_6_1_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/pcie/pcie_6_1_0_sh_mask.h

-- 
2.44.0

