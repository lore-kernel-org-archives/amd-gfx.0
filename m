Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD98C47E49
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 07:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925DE10F642;
	Wed, 24 Jan 2024 07:02:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14E6610F640
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 07:02:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjZPiXxHZ2yPtp0Ff0hfC9XeFCg9FN+IrjOIkscvtys1Nwr26Cd6VjXoAlKEZodo9PgvdJ03XHY0KfqyzQ2yjvqGou7r5wMEebLxNKNNez42/71ahsf5ycmpcWZPxh0+DlZenlw4qWScd3n7DgnIz+wWt6uavbKIVCcNjNzcxz1J05wQ78NtVFWLtUHp/UHJUYrnoIssGeX4wcnkHiHqIlGaPpoXSSNsKmnoYdCuyQEd0kQYj8a9LAIFVYW/021JJ7lnt6N4iJ8CUI1VTnPkTiomtsk65Qh7Z4/D6IhtYA4ODT0UlrD8AskbEc38ub79CLtaq8qbsIUOvAECdd+7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rph6lcE1gY1g/zE5b+8W6C3goFRL1UEgHO626MQ6xlE=;
 b=COfzUUmg5BmOuLhv/0oswkqAFJvLz4UsI8PXW0ObvJd9spoCWIuuG1EHSpNAiMFlCSvhXypku40rnar4CZ9qHR6AK4Zgf4HFzzn5QJVdfjLFpmiucDJRJ83ySs1RNMWdJKuFmUpdrJdCrQSgiaBGyXz3cGOmhnqkREqbGbDtNb5um2yhF3GlP/gTU+daK3Qay7zLxGVNkgEzrQV4mkfZkzaKIA9NjYVDMSZCP5FDlex0vvG2q1VTZFNIToBsaD+xudHgP4yIpRvvT9RAVg5+QzqbBPY9nmsrclBOYOd4OMgpCeZxfEJ3PHI+HeLOcsybM0NV8SqgmebkRCsbSUaSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rph6lcE1gY1g/zE5b+8W6C3goFRL1UEgHO626MQ6xlE=;
 b=Ru7HGJofsKNP28oNRtvocku/SsZrzhpMDh/grb/2ObbREN8SWxBgDY8yE45qN6Oqd238vGY299yDazR4ZMiRm9MjM8f3qjmVJTtyuHXXBUqTxXEEHObqVFabfXQWSQ8HDIN/5zqglRhaoVgAz0SLSajRvVV9KBTeoDP3/uCWxXI=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by DS0PR12MB7559.namprd12.prod.outlook.com (2603:10b6:8:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 07:02:13 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:114:cafe::2c) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Wed, 24 Jan 2024 07:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.0 via Frontend Transport; Wed, 24 Jan 2024 07:02:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 01:02:04 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 24 Jan 2024 01:02:02 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/22] DC Patches Jan 29 2024
Date: Wed, 24 Jan 2024 15:01:37 +0800
Message-ID: <20240124070159.1900622-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DS0PR12MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d58873-537c-4d18-bea4-08dc1caa63e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JVoJcyozZPZx4ZeVF1v5s/dbmcyeKG1QbH3g48ZUD24bXBEs+hicy55K11gE3tLLH/z6oY6VblNc+KJIwCXrc/mf5G7vjvWpNIGKeWca8g/Pk4yl6YGSgS0Sjfaa52lpKEBWGy0iMsXqH8tw25o1cKWgZY8JAEW3p+8h2WhpMF8HZy5/35xGVoh9z74Tbk/V3i3O2NjggMcu1032mIKQPxCixVLs1HzaAC4IvvvLZO1DbZDFSHcdiPwZKAYU3ycbU8a5LzoMAkn7QZ0vwEFI6Ig5Op6DcDZmYRyBdF+TBd+uEGCEdnhsqh80Kfl6zMq8B3qJtXuV1M8penoKusEnohQdZ4yF5NWi7JcoPGyi2wS9Z0xbR42cDjvztz3wUG/zAdBqYhq4rMDZJERrUImeMe8WOFaNwN/VIhgOPhfMH0nKgwRYCzju0m/F781ixxj/3GrZJd3e8ypAnt8uonWBHEr0nCNUs7mM9ahhb0D1f7k/jH5kuUcnMgy9sCehJ0MRRW57z8XxDlzMFYkISDRTols1P80QRAacvhj+xCPEwPl/XkkHthZkT0lt3hPGqs1jaGfL4x4nDWfdmHTVWcORsTw6fMwGTYuE6op03VfFWDFyohQGlYRelYGEljYv1K4g9ELusGxdRWGfbmRvNPa/3Ztqa1wQzgnjW7xp617Vcl4DZ3CNkfLygxbJf8ZWP32MLYxErCoQW7n25h8dy6bK8YpB7C4z1xWDoZtdJVn4PxmHCJ9e5ftoHLpoON8TnEnacdIy7TD/GgbJe8bTbroJXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(6916009)(70586007)(54906003)(70206006)(1076003)(316002)(36860700001)(5660300002)(2906002)(336012)(426003)(26005)(2616005)(8676002)(4326008)(8936002)(83380400001)(6666004)(47076005)(81166007)(356005)(478600001)(7696005)(36756003)(41300700001)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 07:02:12.4118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d58873-537c-4d18-bea4-08dc1caa63e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7559
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. 
In summary, we have:

- Add control flag for IPS residency profiling
- Populate invalid split index to be 0xF
- Fix dcn35 8k30 Underflow/Corruption Issue
- Fix DP audio settings
- Use correct phantom pipe when populating subvp pipe info
- Fix incorrect mpc_combine array size
- Fix DPSTREAM CLK on and off sequence
- Fix USB-C flag update after enc10 feature init
- Add debugfs disallow edp psr
- Unify optimize_required flags and VRR adjustments
- Increased min_dcfclk_mhz and min_fclk_mhz
- Fix static screen event mask definition change

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Alvin Lee (2):
  drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel
  drm/amd/display: Populate invalid split index to be 0xF

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.202.0

Aric Cyr (2):
  drm/amd/display: Unify optimize_required flags and VRR adjustments
  drm/amd/display: 3.2.270

Charlene Liu (3):
  Revert "drm/amd/display: initialize all the dpm level's stutter
    latency"
  drm/amd/display: fix USB-C flag update after enc10 feature init
  drm/amd/display: fix DP audio settings

Dmytro Laktyushkin (1):
  drm/amd/display: Fix DPSTREAM CLK on and off sequence

Eric Yang (1):
  drm/amd/display: fix invalid reg access on DCN35 FPGA

Fangzhi Zuo (1):
  drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue

Fudongwang (1):
  drm/amd/display: refine code for dmcub inbox1 ring buffer debug

Hersen Wu (1):
  drm/amd/display: add debugfs disallow edp psr

Mounika Adhuri (1):
  drm/amd/display: clkmgr unittest with removal of warn & rename DCN35
    ips handshake for idle

Nicholas Kazlauskas (2):
  drm/amd/display: Wait before sending idle allow and after idle
    disallow
  drm/amd/display: Wait for mailbox ready when powering up DMCUB

Nicholas Susanto (1):
  drm/amd/display: Underflow workaround by increasing SR exit latency

Sohaib Nadeem (1):
  drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz

Taimur Hassan (1):
  drm/amd/display: Send DTBCLK disable message on first commit

Wenjing Liu (2):
  drm/amd/display: fix incorrect mpc_combine array size
  drm/amd/display: use correct phantom pipe when populating subvp pipe
    info

Yiling Chen (1):
  drm/amd/display: Fix static screen event mask definition change

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  7 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 53 +++++++++++++++++++
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  | 53 ++++++++++---------
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  | 15 ++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 45 ++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 14 +++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 -
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  9 +++-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |  4 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 14 -----
 .../display/dc/dcn35/dcn35_dio_link_encoder.c |  4 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 15 +++---
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  4 +-
 .../display/dc/dml2/dml2_translation_helper.c | 33 +++++-------
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 20 ++++---
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 18 -------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  3 --
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 18 +++++++
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.h   |  4 ++
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 --
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  4 --
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 18 ++++---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 13 ++++-
 39 files changed, 274 insertions(+), 150 deletions(-)

-- 
2.34.1

