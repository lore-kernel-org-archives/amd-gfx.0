Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D35C6FA8F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 311E710E5CA;
	Thu, 24 Aug 2023 21:53:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DFD10E5C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGXTm5dTQ0VK5/suhirehPxJxBWKslHcqXa0DpZ0KJtplUJJV7rn0YSDjCdLsU92BEaO6fMtsk7N5rVBhExKuP7gnVAvKUh/Wa+nRmtsCgT2h7wjEpk39WjhG24pnH9R5K+kX9IlwEIImumNtzMVVK/ce4XzhUJplFgYQDdFOukBHD9NQSzkOfwwap1U5TqgsLk/TgOVia3a8CaT9zzpPrrN9on3K5MNah/hRx3KPchM3rFnW64qntM/N9n+s353/8TTGyVhXybEUUPX+5S0GDxb/VBtt00weO3F+8P1hQ5hcOKP0csJpSsuKNNlSFQyV+u9SJnSvW+k3bUA+D84bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY8bua+vfUw8LpOQU/YLRpBf+M7cTLoAF7E6SdJ52OQ=;
 b=m1yl+B0HkMlr73JOXsH6iL0HpPAi5enSfZsBmyAhiM5i1BiAuVndBvBHQVDvLLRUHt22IvY0AdkQkn16Znsh1EwWe2njL4LUqwtdR5X7DwqLYik8gJ7e7LjrxCYtgUZuAjkRjlXg3ukEsxMbkyVBlxftX+NAM7iDX+jtUJjryyLL/GOuhBaabk3lDLIS/cr49AyHMqmfCiZJTtV3aIYlllfVhZB/kqjebJrws4C/sRK86dkq7S1s/rR8zdgizvUAV4lQ8/yZIcK5LpxLYP0ngYhwkpiiBXV7YL3KBp3LHzT1TJxZnmvTcSj9vs0LtCDz7AdsXEIXfNoSY+/UaqvHsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY8bua+vfUw8LpOQU/YLRpBf+M7cTLoAF7E6SdJ52OQ=;
 b=Mg4Co3kgppsOEJaW8316PQS7K9P1qsf3ur4Cgv+hF0YKlTE9l43BucQSyqBYhItnxuk7lcTUW/0qpY8CkLRjnnmOXjru6Jv7BOtEclDKfrN3XbJxvfeGTgpdZm0BwYEytiW2lEMm3qqQ2BAOGRiAXK4jD/d4RAcWyNde8fW/3Lo=
Received: from CYZPR12CA0015.namprd12.prod.outlook.com (2603:10b6:930:8b::15)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 21:53:14 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::f) by CYZPR12CA0015.outlook.office365.com
 (2603:10b6:930:8b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:53:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:53:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/9] VCN 4.0.5
Date: Thu, 24 Aug 2023 17:52:53 -0400
Message-ID: <20230824215301.2739707-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 722b14bc-fe71-4a68-3f18-08dba4ec846d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1AuvXV/MdnpI+A5xaTtcSiXTNd3+qDJXYi1D5T95fPS4AfrS3xIXUMELSJCpYfqz8LJouqLeN8Edt2qTqopBd8qzMtGFB1TxyfOc32NJ8A21alXaBj/fDsw506Jb3P9HkZbQa8AJoWPwuuzo3IkzdSxiEHDEpv1U1WHOL6El7AhJvQ1FyRhDMmCZeDYLtUEo87tiMU24+jbnZguHc4Y0UEGYvBRcU88MHVX4BhUNX3WaasuwNQOtginAW77OUeakLzlcaRXqYDIeQI/Mcwrp1CvsryN+bwU7JdKJqVDzqJKuAitCxBLyjuqC5qmHgM3dUcSpx9GzxPUQTo2OhC4gdWa4JMtUqd/tW25BxpxGlpSVpADwKjL9J33BNXaqHJqTt+9M9jCTQNCOEhtj984vTsGlkiwPdvMFEnqAljRODQFpfNVcRMMoKss1VU8STvboWfE5Js1JiG4SN3v1YV4TNhh6pFozxv3SPB4U7ofYewmDRzs0ytcEhWxm6QuFxuLvQATQ2lfIpd7hA3IP7bZdw1TAYoYBHq4a+9Q7JkKTKFHcGT8AO5DlNQSUZOSHFSPn/QdpXQAuZ2sSogckuW2gijXeHGrSL/vJSYuChYXDbDokqjseNbACiDsd8nK22S87zqjU3Ce70xTXgwCRRTJ/cpueXw6fJ1+ktcVFgoqB3/XEtCK+SyncF+tobtUnabhvQAzsMgWVsN9PXgcZIvlcvw1KEX0TMyajjE1AFb/ym9D4aXl1xf/nMWClFbpaE8DEIeg+scWVayfU8gbvd/kfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(1076003)(40460700003)(2616005)(5660300002)(8936002)(4326008)(8676002)(336012)(426003)(47076005)(36756003)(83380400001)(7696005)(36860700001)(26005)(16526019)(40480700001)(82740400003)(356005)(6666004)(81166007)(70206006)(70586007)(6916009)(316002)(478600001)(41300700001)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:53:14.2952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 722b14bc-fe71-4a68-3f18-08dba4ec846d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
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

This adds support for VCN (Video Codec Next) 4.0.5.
This is the video encode/decode and JPEG engine
on the GPU.

The register header patch was too large for the
mailing list.

Saleemkhan Jamadar (9):
  drm/amdgpu: add vcn 4_0_5 header files
  drm/amdgpu: add VCN4 ip block support
  drm/amdgpu/jpeg: add jpeg support for VCN4_0_5
  drm/amdgpu: add VCN_4_0_5 firmware support
  drm/amdgpu:enable CG and PG flags for VCN
  drm/amdgpu/soc21: Add video cap query support for VCN_4_0_5
  drm/amdgpu/discovery: add VCN 4.0.5 Support
  drm/amdgpu:update kernel vcn ring test
  drm/amdgpu: enable PG flags for VCN

 drivers/gpu/drm/amd/amdgpu/Makefile           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |   32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |    3 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |  621 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.h      |   35 +
 drivers/gpu/drm/amd/amdgpu/soc21.c            |    9 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 1779 ++++
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.h       |   35 +
 .../include/asic_reg/vcn/vcn_4_0_5_offset.h   | 1797 ++++
 .../include/asic_reg/vcn/vcn_4_0_5_sh_mask.h  | 8614 +++++++++++++++++
 11 files changed, 12929 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_5_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_5_sh_mask.h

-- 
2.41.0

