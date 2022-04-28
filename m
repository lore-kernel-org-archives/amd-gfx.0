Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D20C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F33810EA11;
	Thu, 28 Apr 2022 18:52:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC25E10EA11
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLx9fKf32ggx63k4bjsnU9MRGtZtyFakwcH9U+lwdXtbvjjk/ef0Q8W3l2AokPmlktPqnoPfVYI6YNCMb31BP+fYOinnq7CzqTy0Kptw3V03ugvWEZgY1Oxx7sxXrvWH61P+ItG75UdaTHQMLwdyQ+Q6b1in75otEkmBbg5Wg/aPNVO124oAtJRc0ULKlAa1eSfvyGL1fFH914ISowKaU67Zq+yDJPBsxXLx49EpuGCpQOYEalvSuNnoGzN7ujZ4Ovz40KUYL2G76y4wA20YMhiB6wekgr/ZQQI253VgpYfW6BevN+HqN/bNmMH+Q6V+aqBCmPmgGqc+lVT2Q+D35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVqh2G/ARYkTn7SQ2Mz8Gk2Fv1i+fU48RagTy+wsA2s=;
 b=XV146W7jzjSzEzaxdJNKX916YCTHE5h+xu4ryM8Ifcjrs9nCrixzzRELCZ4OOL7P2ALlcmnsg0HdZTAWaT/GrXJ2tOE/SI2hfPhcvWaa19WxAYkDBDK8oOLxxLgOinZAYyrN2X1O/n1LYHPhTZFB2Z3unjQVd+up9QKty/Jm76pA8aZ/MLubky5NS87O1cT3hkBSMfbvau9B5f67UFzUdiXhes9BLQZh0lVFCAXgUpMvU5R1Yv5tzVQikrPJ5DaKr+FBz5uxc1EhEiAL73TzmiLRdLn6xI8iUyo+bqE7QeM8St00+RQaYrxcyEtpUSaaQxa07rOYhKmGX9Nz6DWFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVqh2G/ARYkTn7SQ2Mz8Gk2Fv1i+fU48RagTy+wsA2s=;
 b=miI9TIizRQPqgICI/wyH4hZEfOAmib3PpHD+Wa4Hj2yK3DEhm45FhYV0r4sHWFbN0pMsTKuWqDb2eDwH1ZkVBBYJri95AS1WJYFf/rxKy/lGejH0WxNCtLQ9of6aLnM6X7WVLuabxGWJgTdmozAUEXWS3dP15Kehsk/SdRBGgNg=
Received: from MW4PR04CA0275.namprd04.prod.outlook.com (2603:10b6:303:89::10)
 by CH2PR12MB3765.namprd12.prod.outlook.com (2603:10b6:610:25::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 18:52:18 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::ab) by MW4PR04CA0275.outlook.office365.com
 (2603:10b6:303:89::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 28 Apr 2022 18:52:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 18:52:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 13:52:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] Add MMHUB 3.0 support
Date: Thu, 28 Apr 2022 14:52:05 -0400
Message-ID: <20220428185206.652448-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa6d5fa5-1d95-408d-d190-08da2948384e
X-MS-TrafficTypeDiagnostic: CH2PR12MB3765:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB37655D8FE1B0C159759F00FEF7FD9@CH2PR12MB3765.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pdshizu1geqgRduoUr8T47PnIIXJT/mDBxVaRvhFsQxKCX8+yvZU2eCQAczDx6fO/AOPOYC+FDZiNRCzV4Qd7sOrOzeMT8v8Uw7NpbYNexMnJ9ZNUac1MEOzYKPj/oHYwOu3AAF+Nf1fMw8YzYkZzjqAogX0rlhg1ivYTSzRLG/w4YiK5NXop7OG3MeOHDbj78XlJuunjs1QD8WKeoVL7qOmuQmZM3NDqfx9rtEO0eohKFB4K8Y/Cq0R/y0oSFZl2cfAkgF+bRSNGTwI6/Y78vUxj/OqA6wx43Gv7/IPBVTNB5fd1DI6VdFPfm3YudYBsCN4hB/FjihwJAdpRdX5guum68Xxr6LRN6kqykG78m3P8LKRYmbyhu8WnRU2ChZmQt1dZL//JDn1X9t6mRacN1A40HvxVmYF2/+gGNjVWEd3fbmzVkMaAmpxeMIZgPsEZJ4DnNkVVnJfFlYO/pGTTVzkQJu4R5BoGaNxViws3OAsZTaCgOogfmUQOao43ujfNAmKsfkfBMwq7WTkH50ctK2NPe2NJxgAqGkwobcZO+COBFlOOyMLaJuXsa0yn8ybOzP8fFmMvSksl5AkqtvH/NSelsINzr+Uv8Py11esafKSnB4ptXVq0iiPbVDnDvBd2+C2sVl/89+J4WoutJEDnqTUHV4KbgAxMcBPbk8omhYVOqpNpBO75vS5zImj4wgxUGpbhH6wJwe4eBKmovDd+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(316002)(6666004)(81166007)(2616005)(4326008)(26005)(8936002)(5660300002)(70586007)(70206006)(2906002)(1076003)(86362001)(508600001)(7696005)(426003)(336012)(83380400001)(6916009)(47076005)(16526019)(356005)(8676002)(82310400005)(186003)(40460700003)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:52:18.3545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6d5fa5-1d95-408d-d190-08da2948384e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3765
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

MultiMedia Hub (MMHUB) is the memory hub for media engines on the
GPU.  This adds support for version 3.0.  Patch 1 is register headers
and is too large for the mailing list so I did not include it.

Hawking Zhang (1):
  drm/amdgpu: add mmhub v3_0_0 ip headers v6

Tianci.Yin (1):
  drm/amdgpu: add mmhub v3_0 ip block

 drivers/gpu/drm/amd/amdgpu/Makefile           |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h     |    1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c       |  576 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.h       |   28 +
 .../asic_reg/mmhub/mmhub_3_0_0_offset.h       | 1529 ++++
 .../asic_reg/mmhub/mmhub_3_0_0_sh_mask.h      | 7478 +++++++++++++++++
 7 files changed, 9614 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_3_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_3_0_0_sh_mask.h

-- 
2.35.1

