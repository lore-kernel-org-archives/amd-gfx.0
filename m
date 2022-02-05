Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8662C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC54A10E513;
	Sat,  5 Feb 2022 04:33:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B2B310E513
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha8PCgSwARBDTWpNUaK8N/la/f8O+PeeyLye8Lm2suit8AFNuSCkx3VJGzwaa49V7YB9obNKBXqb5Z+9jEw4M+0pH9u8LJ+k7QCzMeNt6ApJGW+nG9pqMFarNNwqWRgu2eiSxoKdh48vQ400UlI8D0wMU9zwuhy+8Qgq7BrlASK16pyrq+9K+EbAOZOZw0zT0eHyHck8t4XrBUBih2YMHoFrgE5XgQO2iYfPeKSsPX2Re3xD7DLOGI7G/Ryi+YBLnn/iY4mKgdyZK+YYChcpmNaePwrOB8CoENJ0hL3jQqMbut9a3ghhhCxZ3q/w+qo3vQz3x2javezFCoMWQm3O6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpBIT/kMeI+MKm68nyFPv0YVHFX1xAcDetL7tBxQ530=;
 b=HeOiR1fBQ/ecwChZhI2sK9dFRIsSljjD8f2+q1NFTt1aW1r85eGTRnlmloDWDC8Atsl/U/AdF2L2wQoNGPtiEsLGiShcqkdYnrOjSgNPM1hBRVFvXiiaVoqdGTnYrsvmSGZhjzg6ld+3P9xVXGoMzEb3va8FPLSj4Ar8wabEcUvVww5PLnCkclfD5DTheuTS5YskxVRcT9NLXJjSizw0vQrQxzG1IGxYSMcYym3dXyIi4nUheu46T2OzYXrFfyI0DJip2qhQIECpfP/D26An48AA6qlDbPnqLnr/Jcuf1669hF/3pxOegLqdhZRXYEvwocUdVA793tHxENqfvMRPkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpBIT/kMeI+MKm68nyFPv0YVHFX1xAcDetL7tBxQ530=;
 b=jUNZfQT0XW6ZfDyrkz7CAHcJfoJwBB9cljRgrttXwZrVLkkzsWfN5CJI2xDYK2SGrSCa/NMA53kXYklKpViLuw3wX+7aSvm/lSdmTeMx57AUmyfq+aiQQXow1INahlXSwnJaWSwtt92xtAdPheRBCMv+wlvkxd08NVGhRNvQgTc=
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Sat, 5 Feb
 2022 04:33:23 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::bd) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.8 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 04:33:22 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:20 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] DC Patchset, Feb 7 2022 v3
Date: Fri, 4 Feb 2022 23:32:57 -0500
Message-ID: <20220205043310.165991-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f3ac815-5b53-4ffa-2afd-08d9e860a4e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865AD64AADADF5B74C35707FB2A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfQb1Mryd6XrBMg/neuHkkAzr6gixNgN8d4KxoU47gRFR9z+BjrMO4PSpzmdLuEphXD1sAuQ8nEbYpbq4IWxX5z7Ns60UeysSyZYO4Il1sjWpTpNC46tuBP2arEDEqXke3LeIsltI01gx8kXiyKmnNj/v7Z0wkxP4wdLxYMsKC7/tvfV6itvqYVMb7y6sgRpJ7EzyIHdtCF1x5xqhCvO7AvpW1OyRnEQg1L3CRSp7Yhom2n5K7S0NFkV/8uWjZ+M+ek0G7NStLkZOdvf1ajjks4HjbTVTqq8H6B+85uMYIkyLPrSfV264BFWsZ8KPL2N7fycgalfwPyL/kWz8gz83ax+ABG7LPArXdgNWqr+2DSKVCzKUBzOTPC6AEUBXoDxZ4e4Wp7Au6E0Bx1ek5GqXIFsdsSvUeYjx/2BnS3AAJJAIsbV/ti8oypoAkcMQtdBJqQx0eGPRVkJWDpxi3e7ZVPtUzfU22oSpKIIeEgU35MXg+OpaQLnt95akcY5D2LKVJMKK/U5ExM3uZM7STg4Hj3jDiYs/C/Xxw/Jmq7uwcSCtURlRBo6FxWsDt7IGDopbrcwKrVOti47LShYdtvXHjnuTU8D2hrNcS9+AIsy/cot7GVSX8L59Dl1LzJfK7VPlEP5bZ0YkDIw1lghwXc32B8iJ0k0YedIlx17qk5pKyAMcJ/gwn2imDPlodfIFO0vnPxru8mnLD8+csXedZ6vHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(70586007)(6916009)(82310400004)(81166007)(356005)(16526019)(426003)(26005)(336012)(1076003)(186003)(2616005)(83380400001)(2906002)(508600001)(8936002)(47076005)(6666004)(36860700001)(5660300002)(4326008)(36756003)(40460700003)(316002)(8676002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:22.8722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3ac815-5b53-4ffa-2afd-08d9e860a4e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
-fix for build failure uninitalized error
-Bug fix for DP2 using uncertified cable
-limit unbounded request to 5k
-fix DP LT sequence on EQ fail
-Bug fixes for S3/S4

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.103.0

Aric Cyr (1):
  drm/amd/display: 3.2.172

Dmytro Laktyushkin (2):
  drm/amd/display: limit unbounded requesting to 5k
  drm/amd/display: fix yellow carp wm clamping

Eric Bernstein (2):
  drm/amd/display: Fix for variable may be used uninitialized error
  drm/amd/display: remove static from optc31_set_drr

Guo, Bing (1):
  dc: do blocked MST topology discovery at resume from S3/S4

Ilya (1):
  drm/amd/display: Fix DP LT sequence on EQ fail

Martin Tsai (1):
  drm/amd/display: handle null link encoder

Nicholas Kazlauskas (1):
  drm/amd/display: Fix stream->link_enc unassigned during stream removal

Oliver Logush (1):
  drm/amd/display: Basic support with device ID

Paul Hsieh (1):
  drm/amd/display: change fastboot timing validation

Zhan Liu (1):
  drm/amd/display: keep eDP Vdd on when eDP stream is already enabled

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 27 ++------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 27 +++++++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 11 +---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 61 ++++++++++---------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |  2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 +-
 16 files changed, 103 insertions(+), 82 deletions(-)

-- 
2.25.1

