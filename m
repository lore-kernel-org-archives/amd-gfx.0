Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDA8C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 406CA10FC9A;
	Tue, 12 Mar 2024 09:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3YSFUgz9";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B90B10FC9A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKG21V07t8BpJi1EeeHpuF1MiIuht326Deex696kaCfkWrxgAN8lgnI82wEm8ZjY6EGRm1T73y7bhAenquPVemm4FIcXQFDuCk3EDZjK0Y4mrQRqvvVzwt1qTfwj574+0h7k2OnW7vgzEfDZUlG3zzivTLtXsC0hjJh/8Qz6JHimIirGNJyVX+BWLLcwZhSAAmGd34f4Cin8SzvrhqKUcz870vUlZnCnfOIGDyzdFnn7JcWLHFBjZYRCnp6ynF7o0GpuQkHqm59cwGvbFsi6aI4vdAKArb2filNdDzafkJ7JdX/iAMsHjWCZTmCWYt9GQy03OOeHcqQAzx2IgEzb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kZbhlqlzvXdUb+UvKS9Lw2fKSTX3x9Ee0LcOVtow1A=;
 b=dd+ZQd42xHJdeIfEVfpmG4QVOh57+R8P1LIyCJFpqQvh9z14rbPJPPfvajj1avNxnPBpe3Sd6VtiKr3nmtRiJUsqaSZIAoirtUaFiOz4O5glLWuPN1fi2wldKAjG6idt6vLKwVuqa+QYEw8O1jQXQvXkVwF5dMSRjVyXYkchBUv+e8wA1UnUzNgNipm5ZyEy/PxH94DJ/8v53WHbHxWEigL4GXpSOPZGLxksy3JOogdI+eX2bdwTEL08mQmLycDh7iu0tr8uPAljVOSe94KJSfezhWyRjTKLoaL5JQs29SZC0tQvDUURI0pWIT6kwOrS78S2Axz2VoN4s68IT4RzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kZbhlqlzvXdUb+UvKS9Lw2fKSTX3x9Ee0LcOVtow1A=;
 b=3YSFUgz9eDp2WqGrn2g2YQSB8o8O7aBiQOBrWlrkoUDN0lGdyTHpE+aYj2Ls0CXJVk4/waR8XrJOEsQmpDKXNWDPYrtLuDaqT9QOOqiQIljSM9+3Wb0V1xp6eRyE028DvozUCOQLUMJ/VXC6DW1nB+NghPmwpUcs0dXbRZSO1+I=
Received: from MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::33)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:20:58 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::6b) by MW4P221CA0028.outlook.office365.com
 (2603:10b6:303:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Tue, 12 Mar 2024 09:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:20:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:20:56 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:20:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/43] DC Patches March 18, 2024
Date: Tue, 12 Mar 2024 17:19:53 +0800
Message-ID: <20240312092036.3283319-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6c6183-bd17-485a-371c-08dc4275ba2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luUyl6VIulmMqjw7sJRppF/w/79r5mMwO3zwBj/AuncO2WzWbfpKu2RPpMT4wAFi5JErR9Ds6o3MmiFep62Wz6/essGOoxiNf1HBpfZ2OSoEuTR0mzVhf4oA9u1vuvlkwak1jYVtXnFX18wDjlnf30+CQjkTz0YlzJYoFT7qV+ovb29drgFzKyVrgMbM+2D2k+ji3bt+g8ICyGnpezvRvqUWH/eaPPFN38OXt7XxhXa/xPtA73FxIOmdPEZZKLZE98QqbRovRmOjOXZkP0NihiB5XP+NlD9o7/duMRPONtdkao+SAvJPtMw95EALFUsAYZQ+7Cr2L/1XBT85G7ZXvYQ6RDncdUsF7WmugMi+NSnCMS8l2JhSxAZPxaAuy+lv6RPCipOK8FIa5mAlw/gYNg10cqJvCuXu7kEW+luyG6i6B26pmJNqVarxsjwwREp3CMi06I8UIHdh/u5mIIGzE+IarKsUqcv6ca4+i98/iMn0QHRmkmMQfLrkJMtERTwLchFLGAzDMQlMPJ85kytgxKKp6ntbit/14b8h8i+ISLcTU3XPC7gdhw5vbEzSf5ACsgW4vapfsPWMfLKCWWoVloe9Ib7FZL3CQAfxNYRsRNJw2xgm6EJRmBphyEZ0vvxjuJCeiA6O8HfITUZqYjQ3/vcvC/HhpX6envqYroxHyj3jIhqeTr8hPO5P5EA6VPQwthBQpbI0uf1fO/BHQybRV53IaBWLtzPDSmFzDAuIElibv0dvCrFaz9aS+d/cCMrW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:20:58.0272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6c6183-bd17-485a-371c-08dc4275ba2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Clear mpc_tree in init_pipes
- Program pixclk according to dcn revision
- Add stream clock source to DP DTO params
- Enabling urgent latency adjustment for DCN35
- To adjust dprefclk by down spread percentage
- Add debug option for idle reg checks
- Revert few patches which cause regression
- skip forcing odm in minimal transition
- Fix noise issue on HDMI AV mute
- Enable fast update for DCN314
- Enable 2to1 ODM policy for DCN35
- Fix DCN31 underflow problem
- Add the MALL size in the fallback function
- Modify coding style/errors and remove redundant codes
- Add missing registers and offset
- Fix few problems for DCN35
- Fix a bug which dereferences freed memory
- Enable new interface design for alternate scrambling
- Enhance IPS handshake
- Increase Z8 watermark times
- Fix DML2 problem
- Revert patch which cause regression
- Fix problems for dmub idle power optimization

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
---

Alex Hung (2):
  drm/amd/display: Delete duplicated function prototypes
  drm/amd/display: Correct indentations and spaces

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.208.0

Aric Cyr (2):
  drm/amd/display: 3.2.276
  drm/amd/display: 3.2.277

Chaitanya Dhere (1):
  drm/amd/display: Add TB_BORROWED_MAX definition

Charlene Liu (2):
  drm/amd/display: fix debug key not working on dml2
  drm/amd/display: change aux_init to apu version

Chris Park (1):
  drm/amd/display: Prevent crash on bring-up

Dillon Varone (3):
  drm/amd/display: add stream clock source to DP DTO params
  drm/amd/display: Program pixclk according to dcn revision
  drm/amd/display: Power on VPG memory unconditionally if off

Gabe Teeger (1):
  drm/amd/display: Revert Add left edge pixel + ODM pipe split

Leo Ma (1):
  drm/amd/display: Fix noise issue on HDMI AV mute

Martin Leung (1):
  drm/amd/display: revert Exit idle optimizations before HDCP execution

Natanel Roizenman (2):
  drm/amd/display: Added debug prints for zstate_support and
    StutterPeriod
  drm/amd/display: Increase Z8 watermark times.

Nicholas Kazlauskas (6):
  drm/amd/display: Add debug option for idle reg checks
  drm/amd/display: Workaround register access in idle race with cursor
  drm/amd/display: Detect and disallow idle reallow during reentrancy
  drm/amd/display: Add optional optimization for IPS handshake
  drm/amd/display: Enable optimized handshake for DCN35
  drm/amd/display: Enable reallow for idle on DCN35

Nicholas Susanto (1):
  drm/amd/display: Enabling urgent latency adjustment for DCN35

Ovidiu Bunea (1):
  drm/amd/display: Revert "Set the power_down_on_boot function pointer
    to null"

Rodrigo Siqueira (9):
  drm/amd/display: Remove code duplication
  drm/amd/display: Remove wrong signal from vrr calculation
  drm/amd/display: Enable 2to1 ODM policy for DCN35
  drm/amd/display: Add the MALL size in the fallback function
  drm/amd/display: Move define to the proper header
  drm/amd/display: Enable fast update for DCN314
  drm/amd/display: Remove legacy code
  drm/amd/display: Comments adjustments
  drm/amd/display: Add missing registers and offset

Samson Tam (1):
  drm/amd/display: clear mpc_tree in init_pipes

Sherry Wang (1):
  drm/amd/display: correct hostvm flag

Sung Joon Kim (1):
  drm/amd/display: Enable new interface design for alternate scrambling

Wenjing Liu (3):
  drm/amd/display: skip forcing odm in minimal transition
  drm/amd/display: Revert Remove pixle rate limit for subvp
  drm/amd/display: fix a bug to dereference already freed old current
    state memory

Xi Liu (2):
  drm/amd/display: increase bb clock for DCN351
  drm/amd/display: Remove unnecessary hard coded DPM states

Zhongwei (1):
  drm/amd/display: To adjust dprefclk by down spread percentage

 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   1 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  15 ++-
 .../display/dc/clk_mgr/dcn314/dcn314_smu.h    |  42 +++----
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |   3 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  50 ++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 118 +++++++++++-------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  40 +-----
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  44 +++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   2 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |   2 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c  |   7 +-
 .../display/dc/dcn35/dcn35_dio_link_encoder.c |   2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |   1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   1 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  12 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |  94 +++++++++++---
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +
 .../display/dc/dml2/dml2_translation_helper.c |  17 ++-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   6 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  16 +++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  10 --
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  16 +++
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +
 .../dc/link/protocols/link_dp_training.c      |  16 +--
 .../link/protocols/link_edp_panel_control.c   |  64 ++++++++++
 .../link/protocols/link_edp_panel_control.h   |   2 +
 .../dc/resource/dcn20/dcn20_resource.c        |   7 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   5 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  21 +---
 .../dc/resource/dcn316/dcn316_resource.c      |   1 -
 .../dc/resource/dcn32/dcn32_resource.c        |   3 +-
 .../dc/resource/dcn321/dcn321_resource.c      |   4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   5 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  73 ++++++++++-
 .../amd/display/modules/freesync/freesync.c   |   2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  10 --
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   8 --
 .../display/modules/info_packet/info_packet.c |   2 -
 .../include/asic_reg/dcn/dcn_3_2_1_offset.h   |  37 +++++-
 .../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h  |  16 +++
 50 files changed, 581 insertions(+), 234 deletions(-)

-- 
2.37.3

