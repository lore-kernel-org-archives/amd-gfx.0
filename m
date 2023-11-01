Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFAFC4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EA010E0EF;
	Wed,  1 Nov 2023 20:08:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CBDC10E0EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:08:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb8iWA0skvhE8Ibm+3nffRWZ1KbjHS3TJAWrwy9sRBruWp+BddCHZMx9ugMn1dH8fwzB5S3DXsHTpUaXzI++aI/UbGDIaL1MiCtY0UP5LIlgI6D7PUG0brr8o5rOSdyRvpLlXH44ZYPw0uP9TevwxR2wZNGgm6+xfI+RQi7UFPhtZFWSySIFEeWYmJp2ynqtg27LGBOpGBgOnkJXA6p1KL87wPrOlfGghSAApzGqmJ+ebf9E/lluDManoxtFGKRx+H/cbQv2e1ukuetZPNLFbxitwbDnbMo3PjfV6Nvf7GqKp6or8LUFruNeq51m4v1T8tdM+qwqx3kA20/HuRZnog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uvw2lB2RUZPmDAEETQ0AL128x+7IleS/tTyDhhzlEHk=;
 b=TbGf2ir0nAJjztGQEZJDg0OAFE6eI+q9IgjKKxYKLU2R2Zb5GJ/gBtvkf2SxzyVd9FwG9A2YSvHH0g0OAPqlpnG7HIUFHkRjo/Ubm+T/PDiZOgoQeV9Fsh0z70bWfZZHQFU3l19N2ZfwpuXQJYC72qStjI21OSgE9h++F4FORbTjeVsvNOV5/RXzcHMF0GeUn94KrjcEAqFmK8+wJMtPWXmdGv+vEymPPx8a+bBI1FZI+K1LYka1LJ45mbkQVsCqK5wzEWO1HMHPCINEk7dgssWkGTjyA+18vRfyqdtGc2tCE4lY74EWibZ6YeAGDlyS7TLJkKMDr+pxeaZwtpRMwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvw2lB2RUZPmDAEETQ0AL128x+7IleS/tTyDhhzlEHk=;
 b=sKKHl0MZYVV9rrkTL8RBzFT+M7GrLcllay/p5NQITFyrbhmuXfNHEAJ6AGsLTZYtjJxrlFKgKIVTZR3ULs7ZTYFav5wcKTiTunBZ3STUZxkpmBBVmQkts5YgDuNXaxU3/Onmj+tZGWH/LhdQ2n0/hpl/xvAGxHr/pBGfKMxv/OM=
Received: from DM6PR08CA0058.namprd08.prod.outlook.com (2603:10b6:5:1e0::32)
 by MW6PR12MB9018.namprd12.prod.outlook.com (2603:10b6:303:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 20:08:42 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::ec) by DM6PR08CA0058.outlook.office365.com
 (2603:10b6:5:1e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 20:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:08:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:41 -0500
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:40 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches October 30, 2023
Date: Wed, 1 Nov 2023 16:08:20 -0400
Message-ID: <20231101200832.995436-1-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MW6PR12MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b797f2-dc80-4666-cfa9-08dbdb1658a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yvkb9pw4IPV0QAJUbCoK3/FrmDZNWXFM0euTQnkOzIDxK0viasRNOMopu+iBSpd6z4G5J91x3SdNSfNcjhnmsFAHMWGKtEZx4Br5RmGWlBcIo8S07fHD5BCQ2RQRtWwfBOKfdwWTIwWKQdyZcCy8tSR4cjSEqsftONEd8TL3zWLKkugtKXMByzY/oepYGLiqSxG3iEn6HAnvzF2wU7iYhuhAWRyPQ/ELyfS+eEXSJxVVp0q5omOmkPZm3+jTGlNf8Ph+TnNy9yVZMK/JqYFb+RvcMN91CM1zggYmKfRKy09p4GsG+qpWQskNjERSuLwgjf+ptI260etvVk6blBReu91ynbqECHdp00TpGtGbSA1/aSb76HqYQxGOxky5KJKbV6L9JcwAlSuyo5mmNhybTxniKbp/t2aEna1MGQdMN2gLeeghoRj4jgAMXAQt3hlYSTUwHMNrkHIimLKF7md8Jl8wtZxZuW5BPCpasbMSmXPEuYlso++2255EBzKL5MH/HYiqgbE6DotUGee3jw+oTwkaqqxbLaZiHCaAmNAgHns08RuEGoKq+VlGTQg41Q7MmOfOX5BBjgSM/qBLd0w4sw+qHLlJdcnfH7TF0kx7QunaN2+n5WIhZzObrmfZErq2EEAajHlf0xAzkscs3gW2IUdT3L8bnMqMLih2NY7pfBW0PGOpCli/9kwjhBxJqnuLEssAVIjQ+Saf9YfyI6kP+hNp3jA6FgBOUiyi2q3Wchr72eF6xSG/bgPE7KJANjwTQ/pYf8dAJp4l6Yuqx1WvJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799009)(40470700004)(36840700001)(46966006)(2616005)(1076003)(26005)(7696005)(40460700003)(86362001)(40480700001)(36860700001)(82740400003)(47076005)(356005)(81166007)(36756003)(426003)(336012)(5660300002)(54906003)(70206006)(70586007)(4326008)(8676002)(8936002)(6916009)(83380400001)(316002)(41300700001)(6666004)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:08:42.3098 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b797f2-dc80-4666-cfa9-08dbdb1658a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9018
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Title: DC Patches October 30, 2023

Start from:
  9379d9fc18582c69862dc25fb770ae2e102f29d6
  drm/amd/display: 3.2.258

Stopped at:
  0a6aa88e926196036c7cf9edb70924b659461617
  drm/amd/display: 3.2.259

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Enable DCN35 physymclk root clock gating
- Fix DP automation test pattern bug
- Disable OTG for mode switch from TMDS to FRL
- Refactor DML2
- Revert Fix handling duplicate planes on one stream
- Revert Enable DCN clock gating
- Implement cursor P-State allow for SubVP
- Save and restore mall state while switching from ODM to Subvp


Alvin Lee (1):
  drm/amd/display: For cursor P-State allow for SubVP

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.259

Chaitanya Dhere (1):
  drm/amd/display: Remove references to unused dml arch version

Daniel Miess (2):
  drm/amd/display: Revert Enable DCN clock gating
  drm/amd/display: Enable physymclk RCO

George Shen (1):
  drm/amd/display: Set stream's DP test pattern upon test request

Joshua Aberback (1):
  drm/amd/display: Remove unused duplicate register definition

Ovidiu Bunea (1):
  drm/amd/display: Disable OTG for mode timing switch on DCN35

Rodrigo Siqueira (1):
  drm/amd/display: Create optc.h file

Sung Joon Kim (2):
  drm/amd/display: Revert Fix handling duplicate planes on one stream
  drm/amd/display: Fix handling duplicate planes on one stream

Wenjing Liu (1):
  drm/amd/display: save and restore mall state when applying minimal
    transition

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  20 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  15 --
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h | 186 +--------------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |   6 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  84 ++++---
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  10 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  |   1 +
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  22 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  16 +-
 .../amd/display/dc/dml2/dml2_internal_types.h |   1 -
 .../display/dc/dml2/dml2_translation_helper.c |  40 +---
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |  18 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  33 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   9 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  | 219 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |   2 +
 21 files changed, 380 insertions(+), 329 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h

-- 
2.25.1

