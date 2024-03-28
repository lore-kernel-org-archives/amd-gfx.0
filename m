Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D41CD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD79D10E4F0;
	Thu, 28 Mar 2024 19:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aLMVYEmW";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDBC10E4F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNooGAVrHzUbO/RWhxHGq3cGmqZS8RMg0dXJkvnd57/NZRS9J6tTcXJcXmL/JvLIDoNjdCyKWZjJPKb4/+No63MUS8KFACOls6H0phZ4WHu00VvmHDR935njkOObLkjgg2jBG2c66G906yelGikOHA++MUVQ0ts9Ah/0MMo40pV5w91XZJZTSCIR9uvKBgAY0T87HePM2NNQSL1P6EMqx9OIjxWpH1d96sfQm6ai8ec6v9mB+Iis6K5sieOgRf/ria9D58OW1Z3aulVzkSP8M2S9dneZd+cacgYsENnqY6ivMU9UUVe0AUNJi/KpADqQhinbqEZPxLuqze+9K2Tjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3/q8CWcuPM8A9QuBvhw5CSfSCy1L5HanlasYHoC4MU=;
 b=EBOiwW3GSxTlLTzx/GUo6gyuHKsBrhnFmoYEX967uizntPmGnz0nAg5+Yo/H5+fblTfR2CmVxRaIxeFAtF7xjvOmeAd8WrkZqSLNYza/sc4Nv8o4a7G5u5+hMAlpJBscVfpAoM/iNHv7vzVzJ6tuSz0JN6Fa1TPTCiHSnPM0VKgF/Aklkuw/O7U1ATi0mZIG9Sf+1H8WEQ7HDwLw2zoYiuFH7L8qODbuC0ziTEYxvzqIbi+6zDba84Jem2TSVIIcbt75EVI+hQYCERz+pVXMdYGeV0VyoY4KZ/rsP6TFPRtvB0uo7zkRIC+IDF2mdj3666uu3vSrOIgMLFK7BvM8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3/q8CWcuPM8A9QuBvhw5CSfSCy1L5HanlasYHoC4MU=;
 b=aLMVYEmWcTZdVL14IYB8mlN1VtWXpUiFR5nWwQvmjSz7ZpMzXnlQx6gOyZwboEQi9jDc5tWCZ1nRbUF10BfZSxOtiK+FhjjbXX7unnkfh/ZIUEN1WbqWSdVLE1pPKQl7Lg5jvxYGYiIZQRgxXkxWlWTmU6mmvD9NATPTZpuMbxQ=
Received: from SJ0PR03CA0360.namprd03.prod.outlook.com (2603:10b6:a03:39c::35)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 19:51:26 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::f5) by SJ0PR03CA0360.outlook.office365.com
 (2603:10b6:a03:39c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:25 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:19 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 00/43] DC Patches Apr 1, 2024
Date: Thu, 28 Mar 2024 15:50:04 -0400
Message-ID: <20240328195047.2843715-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: a32ae00e-60ad-40e6-5bc1-08dc4f607432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUCwD9b1YaHTaIp+HI3AX+PJG5hzGS4+ubyYwh/eR0RHpbJm0MedeyvcfK3Mf8Vr77QznjjgtmFXHma1Vwna2EgrQwLstANgHC5RX0iddAW85OdzB5QHaNo5p/DbgXAFakrAVfHUHYmdFkX7cnd6qUth4VrfRAgx7uTO+jsnmjVl8PEAcPILvd/3JPlLr9i/JzXYeJgFbNFKqnFTuj+La9eHtKBNthqGzMCRVcx3UwfLYsnM85GRmnOnsSOUDiwlgHNWuqrUJ0KmXsNjkPbZwvoJ8A3V7yET8NotpTijXTJGoVivw1cxDekK+1BZKefU/JNHAfMcyQelUWQcRveB9z0mFNP4TOa6KYKSCxcrnYFEZMAXI6wx+5WXJhF8yNO6JhYlKjePtq6PZal0VCDy5Pz48a+1j9zZj1HB5QjH22df1f443kxDp0XPDLu5fbgXgzPUG3hXRO4Ap3tjwjcWb0Xp7FE+6inGNMtsbOVytcPXSEycKzegQQt06YoiL7gz2mTj7ybptLd/GLQktLht2rYHtI33BjYyKrvif0eb97YNh72MkFFg8HUINaB41xWos+YQu08YCh9M8FCp59Jwgp4eBR++oQtouFrumNjcSPYtWRPDcTnmjlAR/YBaiiBs4AFW7rGjPL7t0fC48zW175wcyYDw7h4/rGvzh/30v9r8yjAbq7B0vjJZhrnPzhDRCh3WkQNEgVktg25cOAgSYNaL2vdERceaYxCDLEYuZ2WPHQu3QyAEZMLjszjOzOO4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:26.2336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a32ae00e-60ad-40e6-5bc1-08dc4f607432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we have:

- Fix underflow in subvp/non-subvp configs
- Fix compiler warnings
- Add handling for DC power mode
- Add extra logging for DMUB, HUBP and OTG
- Add timing pixel encoding for mst mode validation
- Expand supported Replay residency mode
- Allow HPO PG and RCG for DCN35
- Update pipe topology log to support subvp
- Disable Z8 minimum stutter period check for DCN35
- Enable RCO for HDMISTREAMCLK in DCN35

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Skip on writeback when it's not applicable

Alvin Lee (2):
  drm/amd/display: Add extra logging for HUBP and OTG
  drm/amd/display: Add extra DMUB logging to track message timeout

Aric Cyr (2):
  drm/amd/display: Fix compiler warnings on high compiler warning levels
  drm/amd/display: 3.2.279

Daniel Miess (2):
  drm/amd/display: Toggle additional RCO options in DCN35
  drm/amd/display: Enable RCO for HDMISTREAMCLK in DCN35

Dillon Varone (1):
  drm/amd/display: Add dmub additional interface support for FAMS

Duncan Ma (1):
  drm/amd/display: Allow HPO PG for DCN35

Eric Bernstein (1):
  drm/amd/display: Fix MPCC DTN logging

George Shen (1):
  drm/amd/display: Add dummy interface for tracing DCN32 SMU messages

Hersen Wu (2):
  drm/amd/display: Add timing pixel encoding for mst mode validation
  drm/amd/display: FEC overhead should be checked once for mst slot nums

Joshua Aberback (3):
  drm/amd/display: handle invalid connector indices
  drm/amd/display: remove context->dml2 dependency from DML21 wrapper
  drm/amd/display: Add handling for DC power mode

Leo (Hanghong) Ma (1):
  drm/amd/display: Add OTG check for set AV mute

Leon Huang (1):
  drm/amd/display: Expand supported Replay residency mode

Mounika Adhuri (1):
  drm/amd/display: Fix compiler redefinition warnings for certain
    configs

Nicholas Kazlauskas (1):
  drm/amd/display: Disable Z8 minimum stutter period check for DCN35

Rodrigo Siqueira (15):
  drm/amd/display: Initialize DP ref clk with the correct clock
  drm/amd/display: Set alpha enable to 0 for some specific formats
  drm/amd/display: Enable cur_rom_en even if cursor degamma is not
    enabled
  drm/amd/display: Add some missing debug registers
  drm/amd/display: Update DSC compute parameter calculation
  drm/amd/display: Drop legacy code
  drm/amd/display: Add missing registers
  drm/amd/display: Remove redundant RESERVE0 and RESERVE1
  drm/amd/display: Add missing SFB and OPP_SF
  drm/amd/display: Initialize debug variable data
  drm/amd/display: Add WBSCL ram coefficient for writeback
  drm/amd/display: Add code comments clock and encode code
  drm/amd/display: Includes adjustments
  drm/amd/display: Add color logs for dcn20
  drm/amd/display: Enable FGCG for DCN351

Roman Li (2):
  drm/amd/display: Decouple dcn35 and dcn351 dmub firmware
  drm/amd/display: Allow RCG for Static Screen + LVP for DCN35

Samson Tam (1):
  drm/amd/display: fix underflow in some two display subvp/non-subvp
    configs

Sung Joon Kim (1):
  drm/amd/display: Enable DTBCLK DTO earlier in the sequence

Wenjing Liu (3):
  drm/amd/display: optimize dml2 pipe resource allocation order
  drm/amd/display: update pipe topology log to support subvp
  drm/amd/display: move build test pattern params as part of pipe
    resource update for odm

Xi (Alex) Liu (1):
  drm/amd/display: add root clock control function pointer to fix
    display corruption

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 ++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  66 +++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   3 -
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   8 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 -
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |   4 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |  11 +
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   5 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |   5 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   3 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   3 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   3 +-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |   9 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  64 +++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 105 +++++--
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  29 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  12 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  13 +-
 drivers/gpu/drm/amd/display/dc/dc_state.h     |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   8 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  16 ++
 .../drm/amd/display/dc/dce/dce_mem_input.h    |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h  |   1 +
 .../drm/amd/display/dc/dce/dce_transform.c    |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   4 -
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |   1 +
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   2 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dwb.c  |  11 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   6 +
 .../drm/amd/display/dc/dcn201/dcn201_hubbub.c |   2 +-
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |   2 -
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   3 +
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |   4 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 207 +++++++++++++-
 .../display/dc/dcn35/dcn35_dio_link_encoder.c |   1 -
 .../dc/dcn35/dcn35_dio_stream_encoder.h       |   1 -
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  10 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   2 -
 .../dc/dml/dcn30/display_mode_vba_30.c        |   1 -
 .../dc/dml/dcn31/display_mode_vba_31.c        |   1 -
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   2 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |   1 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 267 ++++++++++--------
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  14 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   2 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  12 +-
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 132 ++++++---
 .../amd/display/dc/dml2/dml2_internal_types.h |  11 +
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   6 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   6 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   3 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   8 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |   4 +
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |  69 ++++-
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.h  |   9 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |   8 +-
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   7 +-
 .../dc/gpio/dcn21/hw_translate_dcn21.c        |  13 -
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   6 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  32 +--
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   1 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  44 ++-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   4 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |   2 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |   2 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   2 +-
 .../display/dc/link/accessories/link_dp_cts.c |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   2 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   4 +-
 .../dc/link/protocols/link_dp_training_dpia.c |   4 +-
 .../link/protocols/link_edp_panel_control.c   |   7 +-
 .../link/protocols/link_edp_panel_control.h   |   2 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   3 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |   6 -
 .../dc/resource/dce112/dce112_resource.c      |   2 -
 .../dc/resource/dce120/dce120_resource.c      |   2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  86 +++++-
 .../dc/resource/dcn321/dcn321_resource.c      |  12 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   8 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  17 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   1 +
 .../drm/amd/display/include/grph_object_id.h  |   4 +-
 .../amd/display/modules/color/color_gamma.c   |   2 +-
 .../display/modules/hdcp/hdcp2_execution.c    |   2 +-
 .../include/asic_reg/dcn/dcn_3_0_0_offset.h   |  24 ++
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |   9 +
 .../include/asic_reg/dcn/dcn_3_0_2_offset.h   |  20 ++
 .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  |   8 +
 .../include/asic_reg/dcn/dcn_3_0_3_offset.h   |  28 ++
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  |  18 ++
 .../include/asic_reg/dcn/dcn_3_1_2_offset.h   |   4 +
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  |  19 ++
 .../include/asic_reg/dcn/dcn_3_2_0_offset.h   |  60 ++++
 .../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h  |  27 ++
 .../asic_reg/dpcs/dpcs_3_0_3_sh_mask.h        |   4 +-
 .../include/asic_reg/dpcs/dpcs_4_2_0_offset.h |  10 +
 125 files changed, 1354 insertions(+), 464 deletions(-)

-- 
2.34.1

