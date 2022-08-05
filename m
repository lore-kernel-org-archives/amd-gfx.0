Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56356C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 17:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDAFA8D123;
	Fri,  5 Aug 2022 17:58:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783AFB8A8D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:58:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJICexom5LfqpxfgsokYz8eFdEgjZD4U8bnccVXcuAMBgie1apQScKXWc6gAuUKEqH3UUkLJIb31kzFdElh+F3GmcHAK+rjxLF2cyvb94WtFvCqlfzO+XWuRD/rZ33Mn8R33ykFEyJFDwmpTzR15unWH+zrKwJXQvK9MOPvmpPrHVnNbyZVv81ycrW6w8xJDJDhW9Qa3TF4I/fSvCBtbd9wfhKOXRD7us+nkXofkHHtFZMIXlZs1J0xrchUE/bpoO0w3cg9PPm6eyfqQxW7u/f5i6dbgoiAcB3OXOh57eq8SqKGEUEd4uLpN94vyJ7kn3cCtLeLOsep+JYWOam/3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYgMcxj76hn2dLWFeS9/XFsjVKl1knlmd1RRcueMMxg=;
 b=GEYZ4a2jvhHG1hLnOyoOcpe7ZqpwIQd8X0+055lijaW3nucU6gNoQy8qFNoR34pl0l6lycMRNAmRfW4TcrKgS+XPkZqXriPaFVkecnw7DKeIdEB/n7YfwkQm5lWfINKSXDwMhkzoAqpH+JCY7yOvaBOw0dfGrReiV664bpn413ksobohniwV7nPg4XVbwV/qgj6raDuEQd9ZqomDPhIj7Dkswtjzgt7np0n+iR7ANyzmQnc7O3dHgYSGTWZHHNDDT1wbMm8zAdDniPELfz2Ckco9r2FK365wx2PgniGv5R2vPjRfJoeY/VYmC71ncQN2y5L8eASil8X5UEBezjIHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYgMcxj76hn2dLWFeS9/XFsjVKl1knlmd1RRcueMMxg=;
 b=5eJXuSGNXDxyKr/Scj2mOvClboHtZDfrWN1Swy6jtKQBC0SiPwhb+OXQbU7Z3Se+1wKeEwijIQj6QuKVSpF+Gm/YFH/wXjwc6UzSv0fPBgoCrMiwJlROedGS9vQpVFu/rTyIxA4jaFrXTnq/Jf1PJ3GSIG9iTJooXS7B41ExlD8=
Received: from MW4PR03CA0216.namprd03.prod.outlook.com (2603:10b6:303:b9::11)
 by BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 17:58:39 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::56) by MW4PR03CA0216.outlook.office365.com
 (2603:10b6:303:b9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23 via Frontend
 Transport; Fri, 5 Aug 2022 17:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:58:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:58:37 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:58:31 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/32] DC Patches July 29 2022
Date: Sat, 6 Aug 2022 01:57:54 +0800
Message-ID: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c8fb95f-f735-425e-9645-08da770c2011
X-MS-TrafficTypeDiagnostic: BN9PR12MB5211:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qm+TiOI0B/dTjOPH1TUjuKAbh1qrACRYlVGiX57VCSaAPhGEq9617VHVHTkOp/aJFH40FLMgn4j2u2ls1+TcOMe3pFg5++mJA4FBSfnNZEio+WvmaMhFnrBjGrcw9nQXfZWzNwD9/2yW0KvYvz86z6iwuGKsqxcUgCeQDwVTZNn8/b3ubZUc7ayUNWHumONIhyEMp7XY7jr/2hjaAs7RoqfP32aOLeO3POtxmAhEnwI1jjq+iDFA8BVXxFW84XPvd7tAkvQ6CgCXXCwDJCSFkaGUtIefkR0OTaEVCz+pryF3hSxnIP5A/k/0Qu/0z9FsmW+9lK32WFsnxJlxFzhFTxe1pvOLoCgqSrFnCZRhJrTG7grZfKu4BiG+8mCfp0+gxNoQc+AlRjN43zXP36+rbuwvLoV/zDPvyBeCyqLtPZI8abpKRaQ3/q9a8uNObsPEaFDYtDYvA6JUMKhFtXyzJbOY2xwIb/GheqoBS4j/6kikpYqoNUjyr5Z7V5yfqT443vBaN8N7Vix6o0lBHC5meiV9BNR0oUVvcmQbYmCaoCPkX3D49tgk0ORrciAfhcqjZtovt0odIknSoS+OdtmuXBTzp3yd8mcXGxF6Rc3JaU+M5mosjkyzmzQ3gUMFsLN/gGl7C+mT5VNB/1b+nog7DAu1KEL/9Vlj/Ykvj/gleeW4kTktUrtMp2iPoX/QBV4xmnWGJM54x1KKpHenTjcCDBuYrjbXsdDGHgvO5iZ0cdIDguVYVw7LwOK1ju82OqPeQreesy0nUyspkYzEufPcegh9HIxEWp22qs7wc0SZm5GazNkNQSZ+5O2MWU3yNtEa0cAOkhODLYByYAD00hVcig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(40470700004)(36840700001)(46966006)(47076005)(426003)(336012)(186003)(41300700001)(1076003)(26005)(7696005)(2616005)(2906002)(82740400003)(86362001)(40460700003)(40480700001)(356005)(83380400001)(81166007)(82310400005)(478600001)(36860700001)(54906003)(5660300002)(70586007)(8676002)(4326008)(70206006)(316002)(6666004)(8936002)(36756003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:58:38.5807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8fb95f-f735-425e-9645-08da770c2011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5211
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings along following fixes:

- Move fpu file to dml folder
- Fix CAB allocation for multiple displays
- Add a variable to update FCLK
- Fix TMDS 4K@60Hz YCbCr420 corruption issue
- Fix MPC tree infinite loop in some case
- Fix SubVP calculations
- Fix HDMI VSIF V3 blank screen issue
- Add some documentation to the code
- Allow alternate prefetch modes in DML for DCN32
- Fix VPG instancing for dcn314 HPO
- Check correct bounds for stream encoder instances for DCN303
- Enable SubVP by default on DCN32 & DCN321
- Fix DTBCLK not correct for dcn314
- Fix Compile-time warning
- Fix the stereo mode hang issue
- Fix display light up issue

Alvin Lee (8):
  drm/amd/display: Revert "fix 32 bit compilation errors in
    dc_dmub_srv.c"
  drm/amd/display: Add a variable to update FCLK latency
  drm/amd/display: Refactor SubVP calculation to remove FPU
  drm/amd/display: Add 16 lines margin for SubVP
  drm/amd/display: Fix subvp calculations
  drm/amd/display: Revert "attempt to fix the logic in
    commit_planes_for_stream()"
  drm/amd/display: For stereo keep "FLIP_ANY_FRAME"
  drm/amd/display: Don't try to enter MALL SS if stereo3d

Aric Cyr (1):
  drm/amd/display: 3.2.197

Aurabindo Pillai (3):
  drm/amd/display: fix CAB allocation for multiple displays
  drm/amd/display: Check correct bounds for stream encoder instances for
    DCN303
  drm/amd/display: Enable SubVP by default on DCN32 & DCN321

Chiawen Huang (1):
  drm/amd/display: Device flash garbage before get in OS

Daniel Miess (2):
  drm/amd/display: Use pixels per container logic for DCN314 DCCG
    dividers
  drm/amd/display: Fix TMDS 4K@60Hz YCbCr420 corruption issue

David Galiffi (2):
  drm/amd/display: Allow alternate prefetch modes in DML for DCN32
  drm/amd/display: Fix Compile-time Warning

Duncan Ma (2):
  drm/amd/display: Fix VPG instancing for dcn314 HPO
  drm/amd/display: Correct DTBCLK for dcn314

Fudong Wang (1):
  drm/amd/display: clear optc underflow before turn off odm clock

Josip Pavic (1):
  drm/amd/display: Avoid MPC infinite loop

Leo Ma (1):
  drm/amd/display: Fix HDMI VSIF V3 incorrect issue

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix TDR eDP and USB4 display light up issue

Rodrigo Siqueira (9):
  drm/amd/display: Create FPU files for DCN314
  drm/amd/display: Move populate dml pipes from DCN314 to dml
  drm/amd/display: Drop FPU flags from Makefile
  drm/amd/display: Add documentation to some of the cursor struct
  drm/amd/display: Add basic kernel doc to CRC code under DC
  drm/amd/display: Add some extra kernel doc to amdgpu_dm
  drm/amd/display: Document pipe split policy
  drm/amd/display: Expand documentation for timing
  drm/amd/display: Document some of the DML structs

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  16 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  46 ++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  12 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  45 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  40 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  93 +++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 148 ++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  44 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   6 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |  25 --
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  42 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   4 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +
 .../amd/display/dc/dcn314/dcn314_resource.c   | 341 +---------------
 .../amd/display/dc/dcn314/dcn314_resource.h   |   3 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  39 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   3 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 376 ++++++++++++++++++
 .../amd/display/dc/dml/dcn314/dcn314_fpu.h    |  40 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  46 ++-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   7 +
 .../amd/display/dc/dml/display_mode_structs.h |  34 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  14 +-
 .../amd/display/modules/freesync/freesync.c   |  15 +-
 34 files changed, 968 insertions(+), 498 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h

-- 
2.25.1

