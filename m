Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E471BC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9EC10E0E8;
	Wed, 20 Dec 2023 16:36:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 417BE10E0E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4v6wAGxq7rWv07LLzddOoftYXy/OOrWogXbZs8Cfwol+8qWYCXAfnWl8kPWAtx4kOUtVUdfscJC4kay4er/2T3TDwBwHyDdhg3AL8tQF267smH7oTUW1j1UUbASl56RbwlrKUQcHFwapHoEoIM1JJHITTDJhsggnpdES6U90CUxP2MYgT9F2H8VxWrym4OFbUh2ZonQslqoBYlNltlIVCkqiIcSn3/6SoBYSL1ZxgUNdtHmYX6/zCXdbZgXhuUdcWV6yQybDHF2ipb5+nGdNF/CV83KaQ9JRyZXBbQyI3LVZKcq+sitmb0GNrydBGGgIzQNPGjnLPgjr1l+67PjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/2EgrI7vROvxSUdu3xpjonpZ05+JViJoYabWjONATM=;
 b=hRBTv5PFdWD/YHH8IH9z1+5zFiND3F7ZM0RStmteB7BmwlGUbDOlZ4KNBqRe/XRERPnMMUhmA7Vq5JLgHMh/cMX+tQfBoZ36paXpT+6jPccsEWwwxX6RaprRLWX3Ueu+pyg0YypsSVBU7bAegP6xzBcSku99LPYT7bLdtJB22iCq0KwFblf0zPcHlVFDQUYSz5xV2PwoSpYaIXllorhSWJ5v3D6Ut6V8Z0ZjRBuhJXsyUTdGQZqKNke7/twQT3BDtJ8M+Aa21MzRvrXBnnZa0xI47/gQSqqoAIcj5AtUNcd/PJ3qBs4tDPS8f8s4R6KxBEDO+ssHT2kaFKEBx7iVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/2EgrI7vROvxSUdu3xpjonpZ05+JViJoYabWjONATM=;
 b=n3b9UwK6qQGhVnFyhYCFAchSqLNsXsnYEje/X93IUxqx+Iis4W+E8leW3sL5vQ0vHP2yCQBuFbdzTtYpLhOEqryRFNvDvbmewoWYs2C5ZH5/MXzXmMfm9ckTTa2YIVRn9OmPmrvkp2dxB0hRqbY81inq8E/FnrnywyL6VO2BIbk=
Received: from MN2PR15CA0039.namprd15.prod.outlook.com (2603:10b6:208:237::8)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:36:41 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::44) by MN2PR15CA0039.outlook.office365.com
 (2603:10b6:208:237::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:36:41 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:36:39 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/20] DC Patches December 20, 2023
Date: Wed, 20 Dec 2023 09:33:32 -0700
Message-ID: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|DM4PR12MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: e56179df-b992-456c-9279-08dc0179d869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9pEBI3tN7jO2giyY2H8BsGqi4aHzSN+xZewg7WraH259FyAFW9jHNJJYYcjbmjYoPcsorUvI8xDdNmLjvkkCwO+0caq7KuHdNGTZIZkORg5hF0ATCK7fwMvm/YCwmM0GrKNQKVyeHmzm8vHMVYSiJP+2UYSa7QiSVeIThfuhkTr109C3Xnh2166WrRX3KJarLEB8mKYfg2kRVNWcybs0YzmEN7EOomyvbp6bXZB6A/PYEAnuR2HRYyL1pFQ2KdcRLUHDCbLwRruZlBdBHzfXfH077QvjUenzQVozweIoEV0F5VPNL3Zx/JP9MCUcoO5urr5OvEDE/SAlT/DVLDZJv3EiRQGqS5IVg5hI2T1i4Zqv4w74HWp36+szjSfSFCbaKGeR4yCWTD/tJbnLLAasTNpxKDmuc0BFuXnM0s3KlyajXXTZedJPZAhjjdP7wzW9D9UsA6ODsRBr7/y7r0CACdD2MkbwlqXBEOtmOEiMUY+DmN2+AfQLY5AeD6vAz0nhEShv0JTlL+sLv1Pufr+n6Tu9I2EFu6JnOFfmf+9tsqVky3+7xgm0zx/F3U051Dnh4VaD2MjFmy1OHBOaDKT6TpPUVqirWM6Zd4QQFFKI1s2oLnVVjFLblug+7NvaFtez7p+cLnQianPYrenOzsrbjrdBfgu3XFqd1dshwRxYoiYuwsOL8UXQA6F2HoQepbm6g0ixROLBgRfvZhFoMzXdSmi7uhBZfRHFK+yv6htJy0hmoqbH2eBD71MOE6zoIghWcf0Uw2nXp0yDeg05XDF/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(86362001)(6666004)(1076003)(426003)(336012)(16526019)(19627235002)(478600001)(40460700003)(26005)(2616005)(4326008)(5660300002)(2906002)(8676002)(36756003)(8936002)(83380400001)(6916009)(316002)(70586007)(70206006)(54906003)(36860700001)(47076005)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:36:41.2767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e56179df-b992-456c-9279-08dc0179d869
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Here we are at the end of the year, the last set of patches for DC. This
DC patch set brings improvements in multiple areas. In summary, we
highlight:

* Address SubVP issues
* Update DMUB
* Improve mechanisms for test

Thanks
Siqueira

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (4):
  drm/amd/display: Fix subvp+drr logic errors
  drm/amd/display: Don't allow FPO if no planes
  drm/amd/display: Assign stream status for FPO + Vactive cases
  drm/amd/display: For FPO and SubVP/DRR configs program vmin/max sel

Camille Cho (1):
  drm/amd/display: Correctly restore user_level

Gabe Teeger (1):
  drm/amd/display: Fix Mismatch between pipe and stream

Josip Pavic (1):
  drm/amd/display: Add null pointer guards where needed

Leo (Hanghong) Ma (1):
  drm/amd/display: Add HDMI capacity computations using fixed31_32

Meenakshikumar Somasundaram (2):
  drm/amd/display: Fix minor issues in BW Allocation Phase2
  drm/amd/display: Add dpia display mode validation logic

Nicholas Kazlauskas (4):
  drm/amd/display: Always exit DMCUB idle when called
  drm/amd/display: Wait forever for DMCUB to wake up
  drm/amd/display: Switch DMCUB notify idle command to NO_WAIT
  drm/amd/display: Verify disallow bits were cleared for idle

Relja Vojvodic (3):
  drm/amd/display: Add more mechanisms for tests
  drm/amd/display: Add log end specifier
  drm/amd/display: Fixing stream allocation regression

Revalla (1):
  drm/amd/display: Refactor INIT into component folder

Tom Chung (1):
  drm/amd/display: Add some functions for Panel Replay

Wayne Lin (1):
  drm/amd/display: pbn_div need be updated for hotplug event

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  90 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  76 +++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 172 +++++----
 .../drm/amd/display/dc/core/dc_link_exports.c |   9 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  17 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  29 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  32 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   6 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  96 ++++-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   4 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |  12 -
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  37 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  73 ++--
 .../display/dc/dml2/dml2_translation_helper.c |  16 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |  28 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   7 +-
 .../display/dc/{ => hwss}/dcn10/dcn10_init.c  |   0
 .../display/dc/{ => hwss}/dcn10/dcn10_init.h  |   0
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  37 ++
 .../display/dc/{ => hwss}/dcn20/dcn20_init.c  |   0
 .../display/dc/{ => hwss}/dcn20/dcn20_init.h  |   0
 .../dc/{ => hwss}/dcn201/dcn201_init.c        |   0
 .../dc/{ => hwss}/dcn201/dcn201_init.h        |   0
 .../display/dc/{ => hwss}/dcn21/dcn21_init.c  |   0
 .../display/dc/{ => hwss}/dcn21/dcn21_init.h  |   0
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   7 +-
 .../display/dc/{ => hwss}/dcn30/dcn30_init.c  |   0
 .../display/dc/{ => hwss}/dcn30/dcn30_init.h  |   0
 .../dc/{ => hwss}/dcn301/dcn301_init.c        |   0
 .../dc/{ => hwss}/dcn301/dcn301_init.h        |   0
 .../dc/{ => hwss}/dcn302/dcn302_init.c        |   0
 .../dc/{ => hwss}/dcn302/dcn302_init.h        |   0
 .../dc/{ => hwss}/dcn303/dcn303_init.c        |   0
 .../dc/{ => hwss}/dcn303/dcn303_init.h        |   0
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   7 +-
 .../display/dc/{ => hwss}/dcn31/dcn31_init.c  |   0
 .../display/dc/{ => hwss}/dcn31/dcn31_init.h  |   0
 .../dc/{ => hwss}/dcn314/dcn314_init.c        |   0
 .../dc/{ => hwss}/dcn314/dcn314_init.h        |   0
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   7 +-
 .../display/dc/{ => hwss}/dcn32/dcn32_init.c  |   0
 .../display/dc/{ => hwss}/dcn32/dcn32_init.h  |   0
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   7 +-
 .../display/dc/{ => hwss}/dcn35/dcn35_init.c  |   0
 .../display/dc/{ => hwss}/dcn35/dcn35_init.h  |   0
 .../amd/display/dc/hwss/dcn351/CMakeLists.txt |   4 +
 .../drm/amd/display/dc/hwss/dcn351/Makefile   |  17 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  | 171 +++++++++
 .../amd/display/dc/hwss/dcn351/dcn351_init.h  |  33 ++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  11 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   2 +-
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |   1 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   6 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../drm/amd/display/dc/link/link_validation.h |   1 +
 .../dc/link/protocols/link_dp_dpia_bw.c       | 337 ++++++++++--------
 .../dc/link/protocols/link_dp_dpia_bw.h       |   4 +-
 .../link/protocols/link_edp_panel_control.c   |  30 ++
 .../link/protocols/link_edp_panel_control.h   |   2 +
 .../dc/resource/dcn32/dcn32_resource.c        |   2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |   5 +-
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |  13 +
 .../amd/display/modules/power/power_helpers.c |  28 ++
 .../amd/display/modules/power/power_helpers.h |   5 +
 drivers/gpu/drm/amd/include/amd_shared.h      |   2 +
 88 files changed, 1119 insertions(+), 397 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn10/dcn10_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn10/dcn10_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn20/dcn20_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn20/dcn20_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn201/dcn201_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn201/dcn201_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn21/dcn21_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn21/dcn21_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn30/dcn30_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn30/dcn30_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn301/dcn301_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn301/dcn301_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn302/dcn302_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn302/dcn302_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn303/dcn303_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn303/dcn303_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn31/dcn31_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn31/dcn31_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn314/dcn314_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn314/dcn314_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn32/dcn32_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn32/dcn32_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn35/dcn35_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn35/dcn35_init.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.h

-- 
2.42.0

