Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E99C33CAF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E60820663
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 20:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S5bCXIdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E60820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3586E270;
	Thu, 16 Jan 2020 20:14:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 848886E25A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 20:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlKqJoNX4D0bKdWYOUF19T+TEA4j1KzsavUkJhyFKognKR7/CEtoIpJCI3j2GYYKUdL5q8MIuUyds1tnRfhjA72vPqdPtX97SalPfFgo/ZZRwHMHMRUBLVYCrfJd6x7BHUAg0+7JrUXDEbODhfkgvdAH17OT2G682O6tiSA12RCJWUTqwNRZJKUMDAiwoEfCjEKtX15zncrMsHQZ3dCy4IEnkKECM2JZWTNvolmb05lkIi1Qnd4FSY0qfHcN7ISlR3xRypketYv7HWPf9h7YwFe2BPsK6Q6Mucr2RhoujUWR4DrxOY34dvFkTqZ7B1WID2sHAKDBzMoEHslXz3qY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxet/GjI5sbephx6GPpIjD2g9obfGN5HPZ82VIC2hl4=;
 b=deq3Azqu8zMa7GdMoW/A9Vb/BA0RksNW0hsCTWA/Ia1W0EzUhZcR71r3SNUCXCuJ8z6t6l7PnaKfmp4ncC/bNd6mDJjWyx322dEle7VeP30mzrldbvoTFkIp8cqV5Y+o7agGx/UJ8Hs7d2Uzxs553hHc/sYxPGlBwOAVOqW919FEon4Dfp/mvzUpRtSLq7KBoKD/Srm3r/sV3mAfptSMqG0iyaxx6xdJB23Y3Vei3AftYwO37yTLGhn+02XD6Hz1aQebWTAV+nFH+VtbnNi88zPZ7jXiko96Trn4dPBCNQEYECbmIq8oI8Iw3DJZJHc67I/1v+UUb1ZOm4+h/CiSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxet/GjI5sbephx6GPpIjD2g9obfGN5HPZ82VIC2hl4=;
 b=S5bCXIdHYzKU1gJhL+7wn9+TkG89nTQy/T23RxwpWoCmhnI8QitLb51IkhAav4jnODsTtzA42GNWcy9tVUrwZ2C5QGG9/KzNLLBtqBcFJk2z2DjRt7Bfs/ngc3MQq3wF+eYxFvreW4RA7ycLK3GqTHgvnRzc6Cvi/MnmnCbJ7BE=
Received: from BN6PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:405:4c::13) by DM5PR12MB2438.namprd12.prod.outlook.com
 (2603:10b6:4:b5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19; Thu, 16 Jan
 2020 20:14:23 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::203) by BN6PR1201CA0003.outlook.office365.com
 (2603:10b6:405:4c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Thu, 16 Jan 2020 20:14:23 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 20:14:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:22 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 14:14:21 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 16 Jan 2020 14:14:21 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/22] DC Patches 16 Jan 2020
Date: Thu, 16 Jan 2020 15:13:56 -0500
Message-ID: <20200116201418.2254-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(428003)(199004)(189003)(8936002)(26005)(54906003)(316002)(2906002)(5660300002)(8676002)(336012)(426003)(6916009)(2616005)(86362001)(7696005)(81166006)(81156014)(356004)(6666004)(4326008)(478600001)(186003)(1076003)(70206006)(36756003)(70586007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2438; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d50f341c-5d76-4d71-5ba8-08d79ac0ad9a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24383C718BA3D0C1A67BA09DF9360@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BWnBMnKj5ySN01D/AAQ6badhvyTz4hkxOjt1GEAdApGzSKEUxU7drXtp5rpUd3+A3oUUy9ep70cJcLIWWam7gCCBJwWqQNlCe2FB6Z6tVNLLm7LrgofW4PB0H/GTAhSbLWpwZLBNgFtTQN4JmoN6HVxTY4XZYjoxHZ9yuix6TYKpZ71+F/DSxhm5sL9Vm779arFncalEWdv3bNJf/NZKcUwoo99GEAL/H2NWOyqu+0tdbIt9gTsGBtyYnzAndV9BrMN554S6VmuXbkU17YQLKCfX5o+l6tFW6bFRiYp/TlKs4cHG676NUyEkgmHj+fhxKSegDX7ut3bWH2L2WPfYd4oz6J8LN9tXsDHdZdHI4G75JIwkMxaG/XoZ3DHMB8Ic9Dvloy5vc6qd31z63nTz7SOPPt45atXm7eGvwJR0+cyTOD3kmULXlxRncQ77sk04
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 20:14:23.1606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d50f341c-5d76-4d71-5ba8-08d79ac0ad9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Summary Of Changes
* Code fixes/cleanups
* i2c frequency refactor
* DMCUB changes
* Update type fix

Anthony Koo (1):
  drm/amd/display: Refactor to remove diags specific rgam func

Aric Cyr (1):
  drm/amd/display: 3.2.69

Brandon Syu (1):
  drm/amd/display: fix rotation_angle to use enum values

Haiyi Zhou (1):
  drm/amd/display: Fixed comment styling

Isabel Zhang (1):
  drm/amd/display: changed max_downscale_src_width to 4096.

Jerry (Fangzhi) Zuo (1):
  drm/amd/display: Fix DML dummyinteger types mismatch

Lewis Huang (2):
  drm/amd/display: Refine i2c frequency calculating sequence
  drm/amd/display: init hw i2c speed

Nicholas Kazlauskas (7):
  drm/amd/display: Get fb base and fb offset for DMUB from registers
  drm/amd/display: Fallback to DMCUB when command table is missing
  drm/amd/display: Do DMCUB hw_init before DC
  drm/amd/display: Add hardware reset interface for DMUB service
  drm/amd/display: Call ATOM_INIT instead of ATOM_ENABLE for DMCUB
  drm/amd/display: Reset inbox rptr/wptr when resetting DMCUB
  drm/amd/display: Check hw_init state when determining if DMCUB is
    initialized

Paul Hsieh (1):
  drm/amd/display: check pipe_ctx is split pipe or not

Roman Li (1):
  drm/amd/display: Fix update type for multiple planes

Sung Lee (1):
  drm/amd/display: Do not send training pattern if VS Different

Wenjing Liu (4):
  drm/amd/display: update MSA and VSC SDP on video test pattern request
  drm/amd/display: Add debug option to disable DSC support
  drm/amd/display: support VSC SDP update on video test pattern request
  drm/amd/display: use odm combine for YCbCr420 timing with h_active
    greater than 4096

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  68 ++--
 .../drm/amd/display/dc/bios/command_table2.c  |  78 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  17 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  34 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |  73 +----
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.h   |   1 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |  12 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        |  19 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  24 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  24 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |   4 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |  17 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  25 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   8 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  19 ++
 .../amd/display/modules/color/color_gamma.c   | 307 ++++++++----------
 .../amd/display/modules/color/color_gamma.h   |   4 -
 .../amd/display/modules/freesync/freesync.c   |   2 +-
 21 files changed, 426 insertions(+), 318 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
