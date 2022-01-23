Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBECC433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:20:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A167F10E122;
	Sun, 23 Jan 2022 18:20:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DCC910E122
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:20:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A46cL7ClZBZ1edoluN9WoXOyrcQIF9mJrv+c0FR1cIo0aMkGH82AlstFajLPjymbCti25VJuwRTTNXB3TjJ/0LIQqFEHfmJ5p1GMmCakIppMNbd6Use6/dwpSVrRRxH4ZtjJCePArAAyi3k4H3m0+D9vioIftapcuyHBfzJUWC2Ja+ivF7sLLbq5BmXDd4Hks71Xw+8iod1sxCrjamzkFRAcL5slx1J/IHiZB4enxY/A5zhzNOWJ46m9j3tpv380uKRich8+CRHrJE/plMevNXqd5HFCCfbQYNZPlc6k3Q+xgKx9WMivLGOHO7ryKxhNPLyfUeHYe4oZyWFdPPzNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBKk1CKy9KP31n98eWnhjx6w+5Z0aIMLFGNTncOgJ1Q=;
 b=IrFhNbe4XVpCzX+ktsjQVvwd7qJLylEaxVe44yWn5H2HLUOzShRAM4YDAdpalXvwpbN89o7y7cK4r/GjPyHwT7adns+aLP5io4f6zat3DH5ynQ4HR6WO+uBRz/TZChG3r2T8q/hbVHXe/XKQe3DLr3PukXijLTAXA2nqRO9yrELHEUvOPmreMsZV85CVUIErImyPdDXtk+nd+wtSJGoRRbslhCkyRVeAXR5umjCJ+OzKXLthDdUpDyT99Lh6bEkjdGJppkxniPe0Q1YnVgERSOHK7HKKj6BTn9DpFzh1msoZvSMteXC2JGJo4axa6sjVKz8V51aos5DM/ZBlYEgpeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBKk1CKy9KP31n98eWnhjx6w+5Z0aIMLFGNTncOgJ1Q=;
 b=BW8KfaC1oCi0KJR5jb9HvmlciDRZD11tPZ7NA8ZOvrTGQknSnac2/RoeZ+UVFAm8qn3zz0GuxE4UBZYjUy6xfMFTqOLFQDCu1Sp6HUG3MmaPYpCj/cdvSwmtdyuWxDtEee1e+m/F21+Dq//UfVwoz6S2seIjeCVn1aOhvhCOeqo=
Received: from BN0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:ea::6)
 by DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Sun, 23 Jan
 2022 18:20:54 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a6) by BN0PR04CA0061.outlook.office365.com
 (2603:10b6:408:ea::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Sun, 23 Jan 2022 18:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:20:53 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:20:52 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/24] DC Patches Jan 23, 2022
Date: Sun, 23 Jan 2022 13:19:57 -0500
Message-ID: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13dd8db9-8d03-4b3b-bd3c-08d9de9d17c8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3930:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB39304363EB99A14013F62A51985D9@DM6PR12MB3930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WfQzBrgGzuDjmiVW7xOND7ftnoijPojurjMBx+d+18OY1YB8aSrApgF1NmI0rddPJgPNi+SIhe7yg/PiCE6ekePHcWSu6bc+CN4OQ+gWCtk2tUKrgN1mGfVgknjZLsL8032gVLde7mwav27yr8f15YsTQIoGUYATdAmubKIIZhthXfEzsobUX6OrRx6niHIaqOOz2kLYijgbtI4s1rONCycPIlzBF7ASaZN+neso3JWTjq3BwRA4+8hNpgbVM0qc20nF12MbocLg/GP/h6Km7m2dO+NKQo5P5BXQ66Mm0VC4YOhbCP6arcBBwCRL0QlWf4dbYDzyVisUBQ1CBqFSUwmS9WDVpiNGuLCOznbiBDGtprcJuNtifzZ2p7+TNbcHkSD7RXgZYZoWAFjJ1gGBSW8g7u6ZwFyW9IWMX8VX+QtSsx4szOn/IpDqwUxZru0AsMg6WHn0tjOaa+GqRscv1HMNHcluBrlFcyMghIOKTwgCOXRDznX1Jm8czQvzySJe0s+mFF4RoSkT5b5BlFrf5KfthR4xbReZO18Dsw064oHTv4xwMJi3ataNznduLWU9K73OIFHpt0D/jBJihBIXXbKGFJ3i3CwZxs8PABQdzbz+T5DyZwkevUBAcC7D/BSaU/rFfPBxBT4ZSn3lsNfa4wBGnxIHXQD6OaZfijleQZtda1D+LtufbN1+3MxOzNSpQkP7vbnWvMqUzdpxVKhcLKgADOPLtqN3VqISZXj9LiUt7fGMG5VSMBg+W6rijTKeCn4xCkVFt2HnW+B71kHETkZIROPLluYCNVVhKldUv0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(426003)(8676002)(16526019)(336012)(82310400004)(86362001)(54906003)(508600001)(356005)(70586007)(26005)(186003)(6916009)(36860700001)(70206006)(4326008)(47076005)(2616005)(2906002)(8936002)(83380400001)(316002)(81166007)(1076003)(5660300002)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:20:53.9430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dd8db9-8d03-4b3b-bd3c-08d9de9d17c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3930
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
have:
 - Z9 improvements
 - Clocks management adjustments
 - Code cleanup
 - Improve DSC and MST code

Thanks
Siqueira

Alvin Lee (1):
  drm/amd/display: Driver support for MCLK query tool

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.101.0

Aric Cyr (2):
  drm/amd/display: 3.2.170
  drm/amd/display: Remove unnecessary function definition

David Galiffi (2):
  drm/amd/display: Fix disabling dccg clocks
  drm/amd/display: Disable physym clock

Eric Yang (2):
  drm/amd/display: fix zstate allow interface to PMFW
  drm/amd/display: add debug option for z9 disable interface

Fangzhi Zuo (3):
  drm/amd/display: Add Synaptics Fifo Reset Workaround
  drm/amd/display: Retrieve MST Downstream Port Status
  drm/amd/display: Add DSC Enable for Synaptics Hub

Ian Chen (1):
  drm/amd/display: Change return type of dm_helpers_dp_mst_stop_top_mgr

Josip Pavic (1):
  drm/amd/display: do not compare integers of different widths

Martin Tsai (1):
  drm/amd/display: add protection in link encoder matching logic

Nicholas Kazlauskas (2):
  drm/amd/display: Only set PSR version when valid
  drm/amd/display: Use PSR version selected during set_psr_caps

Oliver Logush (1):
  drm/amd/display: Basic support with device ID

Reza Amini (1):
  drm/amd/display: Update VSC HDR infoPacket on TF change

Roy Chan (1):
  drm/amd/display: Support synchronized indirect reg access

Shen, George (1):
  drm/amd/display: Add Cable ID support for native DP

Sung Joon Kim (1):
  drm/amd/display: remove PHY repeater count check for LTTPR mode

Varone (1):
  drm/amd/display: Change error to warning when hpd remains low for eDP

Wayne Lin (1):
  drm/amd/display: Reset preferred training settings immediately

Wenjing Liu (1):
  drm/amd/display: allow set dp drive setting when stream is not present

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 205 ++++++++++++++++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  25 ++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  10 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   6 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  64 +++---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 128 +++++------
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  23 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  22 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  16 ++
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  60 +++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  10 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   4 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  15 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   5 -
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   3 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 106 ++++++---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   6 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |  24 ++
 .../drm/amd/display/dc/dml/display_mode_vba.h |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   4 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   3 +
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |  34 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   9 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   2 +
 .../amd/display/include/ddc_service_types.h   |   3 +
 .../amd/display/modules/inc/mod_info_packet.h |   3 +-
 .../display/modules/info_packet/info_packet.c |  25 ++-
 38 files changed, 641 insertions(+), 205 deletions(-)

-- 
2.25.1

