Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D0BC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 22:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0528310E582;
	Thu, 15 Dec 2022 22:11:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE1D110E581
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 22:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2ncnZj/O0Yjt/Fm04e0zb///mNMe2tSLMIydLxa/ut8c6OSQvoEbVdTSwB9iDWi9OUIhntb6Teo3tC396hBYYa++wOC/V7XQbazzHV7Acdo/y8q9mD0DVG7bv8uIGmwpvo9Un9M3QpZqc9neDz87eWloO1BSIfQtG7pZKO9r8ioWW/rphdajZ5ZGNEvKAd1DHK7YXVx5dZVjiwfXKcoo26HJIF/Xlt3fgH5hdx38M7G90r5fnH9p2KJIsaiC4+wNG2Ps3UWd1aT+CHBhoTsE0OyApEd+fJrWNq26r26+lmSi/3OeDyhumocnYvGida3EC9oEemKH4XsC4HsWEbiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPqVgVdsR5pCAh955z20BmZoC6haD8JKIDPq+SGHPK0=;
 b=B8PYZK9togXrAi0T57ZCt3t/pQihYmMzjrHV1vtfrm1nL93IK6Gd8TopQVrMiwAgTY5D+mqsXIddL2Iut/Ara2IlGmTyta8WlnZ+xZnFua6E+f8O2dSot9bZ5R23a22d+QRAAz+NStc0Mq98xz/vGIq6RJMq39qhtEn+ADI2sJkxUbNUWajiZHtl7uHUhuArmXqeG6+ABDITiAJHYPtm63jusDonn/WqvaZw27ELuDHYF5KOm/UVEfOG80dMVCtkcxYUuaH/LZ8LAdFyaWL+htE4Ms7K9DWcI089Wc2f/ltWNOk0dNg3QBw6WSUHCnd4zt1SHO2D4VnHC5kvRQpoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPqVgVdsR5pCAh955z20BmZoC6haD8JKIDPq+SGHPK0=;
 b=LXSUincOINOrh35uYVm5YiuBA3ylfGnGVZqqw6BVJXr4TZjsYsReZv0YSKWJhDIwrnhaLYYkVxqoKRh+kWcObJJSxMTvG+Lf+CdtMuq7iLYpdahgvlI5k864DZ5YinwiRGsJl7/OI7/4azv9SVWMU3hiyukPjmRW9C9YwUidz7o=
Received: from BN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:e4::20)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 22:11:13 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::64) by BN0PR02CA0015.outlook.office365.com
 (2603:10b6:408:e4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12 via Frontend
 Transport; Thu, 15 Dec 2022 22:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.8 via Frontend Transport; Thu, 15 Dec 2022 22:11:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 16:11:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/7 v2] Improve S0ix stability
Date: Thu, 15 Dec 2022 17:10:52 -0500
Message-ID: <20221215221059.509565-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 6785db8e-2037-4698-dbe0-08dadee9474f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtBVkvmy/GQKQ0RSfVqfKzBDU4FeTTmdBSL3X+UZonGk7sE1+GkxeXGKe8+4M0GTXTpit1w6s0UazmaAMQZJRCiR58TJWKrDhMBUyWjgHjONvStczF0qs9oTCgU5Hnh587990/RO8J1cqvH+y/ZkyRs10QCWpNn5SJR83I3d6Pgg8CvbexN1GPvZecs1k5F05/+W0XW8Or595QWcwQkjF13CsyLiv0kskjwcURhIay0+j598NTqLMZ33x213vPWg8h1E4k1XQu/kDfEJYsB0ALgcIm3BfZAvDZQm+UDpH6NpmZtcWzUoFJpk5YJT+4wELvxJ2EYorfZvJIa3S6bWKgC3Su5aOiHEcaBV3R+21uew9uR2Ib3KQ9sQ0WpX4M05XoSANo/AwHQwy0ZHYQ5atE2H3idMW11d5nQAGLbDoZ7xFXLSsQYQynh9uPZxCebw02NSCLaSdo/vU6v21ShkpiwqGAsRgFtNulR3FBIB7m8v3bT+Ldc734XKc2A8K5DTSnw8xTEvwSs/gl8BtcCxR0vUoBpPswLJRZW+2esNAbu+LitS8Fmj0EZ3Al/n4E/khtlMvpUuaeLMr+kziL2DFS1PE/E0mO2Le/ycW5AvZK4Rpyqea0DVhWkKMBcGB2hE7ULJlaEzf93WDwhOWN51Ym4lYcwlKZUIL6BPM3ECvHcSPN3e3llWyyx0NEDROlIrUtpLk2qNEDJRtO2VSmCDk6yGCzZxxNaNMbErcFtwk0/FLXP0PoPG6udKRYpdL2dx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(2906002)(316002)(41300700001)(5660300002)(36860700001)(8936002)(82310400005)(36756003)(83380400001)(47076005)(8676002)(82740400003)(4326008)(6916009)(7696005)(70206006)(40480700001)(86362001)(356005)(81166007)(1076003)(70586007)(40460700003)(6666004)(2616005)(16526019)(478600001)(336012)(26005)(186003)(426003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 22:11:13.1042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6785db8e-2037-4698-dbe0-08dadee9474f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
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

This series improves S0ix stability by avoiding touching
registers that should be handled as part of gfxoff.

v2: add comments in gmc code to explain why we can
skip the vm fault state setting for gfxhub.

Alex Deucher (7):
  drm/amdgpu/gmc9: don't touch gfxhub registers during S0ix
  drm/amdgpu/gmc10: don't touch gfxhub registers during S0ix
  drm/amdgpu/gmc11: don't touch gfxhub registers during S0ix
  drm/amdgpu: don't mess with SDMA clock or powergating in S0ix
  drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
  Revert "drm/amdgpu: disallow gfxoff until GC IP blocks complete s2idle
    resume"
  Revert "drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix"

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     | 36 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     | 16 ++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 36 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c     |  8 -----
 5 files changed, 83 insertions(+), 45 deletions(-)

-- 
2.38.1

