Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97159CD4F5E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 20:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2976610E249;
	Wed, 20 May 2026 20:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GYfQQDYz";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6486910E249
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 20:29:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT1HxYfC4dmmqa6IT2k2AWDG2U/1NDNsZ73Pltc8/ygswZVir9pklKHkje+sAcnI1+Eq6QqtiwmQFXQty9FpCHItlBSfy948xOAcKWvSzmvyhK5X6wH0YG6tyI0YaDivPuwO1Mu9WuMGv6B3fQCQHzevtxWUWiY8a5wbzF59AtwmnhVAEwJjHvtKKGpInM9R9xVfrKDI80q/i+k5Z9+Qa8+7mV6t4KXWOj9KVasMcqXNx7OlqMqtA4+LPb7kWyM/oHWegHX90d/hpVIvri+m7JWQruC0yC+Af9RkA+MJ9tZ4DFy2b6r/vqtcpf9lh191eyzMXDSgMD8HmzxwxBCXJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2JvzOiL3dt383n1Nwy8c3cD2BGzE9dL3vIts6+i16M=;
 b=Um6EQLCAqF9vT+H8RJAD5k1r+sj9m5o2TkFlhjiyGUnBGC2g0J9A3Pk+hTU6VjYr8Ei4zgsknIGxmcMgqKOwybxwdf/Qr3bOaaE0I7QoCma/wN0hK1X1f52k6f2WNZ7RNXTGseF7E8n4Xy7R6OzycK7IiL37HVRVu/m4R4KH3Vc6L/+KPIYkqyjic2IptYahME+JmhX5i8daURPAjbRWTa/WzKGaeR8ibk9m+SfZHnzPhIoP4+Fx3DmdzngVYl1bx5OU0VgCR6K7CL8IR+dea98DtKqr9A0I5eukFi72sFWLFwRw3nlVQkAm4MP0uwsKxH3n9phPf+LrZEW1RR1iWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2JvzOiL3dt383n1Nwy8c3cD2BGzE9dL3vIts6+i16M=;
 b=GYfQQDYzWDKSzxjnfvkbbJziJ0QvkhWqOq3izc5Ft4V/HGzuzTp9CuUQfmxeSY8/f/E1okyE1WoUlwzOpuppxuhKdSn71ljwSnhW52irvuN1nWGM+DmCGF9HdHkB003GL+RMuvg2WmuQSsuZX7Np9SloQMYamqlXU65QEhmKrrQ=
Received: from BY1P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::16)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 20:29:34 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::66) by BY1P220CA0021.outlook.office365.com
 (2603:10b6:a03:5c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 20:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 20:29:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 20 May
 2026 15:29:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 May
 2026 15:29:33 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 20 May 2026 15:29:32 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v6 00/15] HDMI FRL and DSC Support for amdgpu
Date: Wed, 20 May 2026 16:29:13 -0400
Message-ID: <20260520202929.555119-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b820d6-b72e-4997-7f13-08deb6ae8158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 8EFBrli8/7+meaCvnUjWmrQViFPp3BulQJNO6XwzfkjXoUb7rwoFV0RSZOgUFAY3NLeq+0yOn7hgwhWimcEwBXaED9PxZEuZbF8R5LI9t90za0nSf/JpGl8EqTaiKuDwLu/gjiFwPdd+2CW78UhlhN3cFOIdDGWoe0Wrdj0f45uMDqwUIMtJLLc37JYvU2UalqntbuLK7su+M83gXwVlzXOGGIodQq0iGv3r92skRsDSxVWchb8+ia4UTeoT3gxZ7j6b8zQqGgJl5KFRYy/mbK0dliqhUeIOyTA+JiuSc7bfIMJwGpeE4FeZPFjm3GoQ3RlN92F6kznuvvV/ARRtywTayRsi625kg1jxtulUeS+kgudxwUf+v2JnLgdZ19TPBNcezYwpKCL48iD1LvHbcd879L0qCwDBdTvwEQhPun6hV2HFazE31oa0Py8wZzJOnDgnZO6/bChh0jur+dWrmLLhtFX/B6pLAd2AL5YXKQAtG8LpYrZG4VaMlvmIeP01xa43kEh8CtgFzVyHn4AoNyXt4on5MXtQhHmj8lj6v5AtBgSL2+/zGApJJQbf8arMC5wJKgRnCdu1EEAOGkqrgSQ4g93nfankUpw/+QfJ+G8abjGKbBivWeaULmygb9BUK7aSLbSDyVMo+0Ui4DNPcnRzcAeJq3HfJYEBJWURu/jNza60MuJC1vS7dka+1j5Sft6IupiHcQnYPj68WLR9sq09ri86w9dsDdTlhnH2/mY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(3023799007)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aMISb3mzasrj6anqL1pyeaoQuaXmfEJCoVeP2XKa9qSWdmVk4jLbIp21nbLDisg5HCbqmuhahMKjwvc7CB+WlTyxWgqhMX7sIl3ahpFUhHiGZ/lzco3b3B3zp9aggp7g5ytQLY9U2d69SldZSCrNfHVyJX2ggoHfaibR8X3QPn9t+s6iijHI3ysOswwmTV577VUVd0ycZ9ssk5wYnBD3SGF1CEPe0rCSr7bdkpo7yBcv4VzX9hYlNprCcgHwrbOAIKepOFgUD32DVvWVQX1gzocEGDNRPncJK0Tnf2gjixCn83Wv2vmn6vLR1qujEi8Xwu8gkCZE+R66hZwTzWSO4edlvFcYYkoUZM+48cj4oPzfkhOQYcxcPqRPUIWnix2J/ChI81cydEd2zoThRznwrO0t6HAEU97TXE8t8QzQwaBMFECVo5In4MUoaZcnDZxt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 20:29:34.3189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b820d6-b72e-4997-7f13-08deb6ae8158
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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

This patch series adds HDMI FRL and FRL DSC support to the amdgpu
display driver.

This work passed a representative subset of HDMI compliance and a full
compliance run on this branch is in the works. We don't expect the full
run to show any failures since it passes in other environments.

Thanks to Siqueira who prepared this work a couple years back and
unfortunately didn't manage to send them while he was still working
at AMD.

Thanks to Jerry who has been making this code solid on Linux and
running the compliance tests.

FRL will be disabled by default since we don't have the VRR bits yet.
Without those VRR will regress for users with FRL displays since we
don't support VRR with FRL yet. Once VRR patches are ready we'll
enable FRL by default.

v6:
- Disable FRL by default and add dc_feature_mask 0x400 to enable
- Add FP guard to new DSC code
- bug fix for DSC

v5:
- One more missing FP compilation fix

v4:
- Disable FRL over DP MST due to lack of testing
- FP compilation fix
- squash fixup commit

v3:
- Add missing DML2 bits
- Merged register headers to asdn and removed from patchset

v2:
- Add missing function pointers on DCN 3.x
- Add DSC

Fangzhi Zuo (2):
  drm/amd/display: add HDMI 2.1 Compliance Support
  drm/amd/display: Disable FRL and add module param to enable it

Harry Wentland (12):
  drm/amd/display: Add HDMI FRL definitions to includes
  drm/amd/display: Add DML changes to support HDMI FRL
  drm/amd/display: add HDMI 2.1 FRL base support to DML 2.0
  drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC support for FRL
  drm/amd/display: Add FRL support to clk_mgr, dsc, hdcp
  drm/amd/display: Tie FRL programming together in HWSS
  drm/amd/display: Add DC resource support for FRL
  drm/amd/display Add DC link support for FRL
  drm/amd/display: Add support for FRL to DC core
  drm/amd/display: Update HDCP and info_packet modules for FRL
  drm/amd/display: Tie FRL support into amdgpu_dm
  drm/amd/display: add HDMI 2.1 DSC over FRL support

Ivan Lipski (1):
  drm/amd/display: Initialize dsc_caps to 0

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  165 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   28 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   74 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   79 ++
 .../drm/amd/display/dc/bios/bios_parser2.c    |   21 +
 .../drm/amd/display/dc/bios/command_table2.c  |    6 +
 .../dce112/command_table_helper2_dce112.c     |    3 +
 .../bios/dce112/command_table_helper_dce112.c |    3 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |    3 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |    3 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    3 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |    3 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   12 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   14 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   18 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   32 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |    4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   49 +
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    3 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   45 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  289 ++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   35 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  129 ++
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    8 +
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |  164 ++-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    8 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   24 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |   40 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.h    |    8 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   88 ++
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   13 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   25 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   68 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  321 +++++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   73 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |    4 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   33 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |    8 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |   30 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |    3 +-
 .../display/dc/dio/dcn20/dcn20_link_encoder.h |    1 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |  250 ++++
 .../dc/dio/dcn30/dcn30_dio_link_encoder.h     |   17 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |   18 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |  114 ++
 .../dc/dio/dcn31/dcn31_dio_link_encoder.h     |    8 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |  214 +++
 .../dc/dio/dcn32/dcn32_dio_link_encoder.h     |   16 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |   20 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   21 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |  220 +++
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |   16 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |   21 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |    1 +
 .../drm/amd/display/dc/dm_services_types.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |    3 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    5 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  127 ++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |   22 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  280 +++-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |    1 +
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |    1 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |  243 ++++
 .../dc/dml/dcn314/display_mode_vba_314.c      |  241 ++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   10 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |    2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |   16 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  127 +-
 .../amd/display/dc/dml/display_mode_enums.h   |    1 +
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |  790 +++++++++++
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h |  173 +++
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |    2 +
 .../amd/display/dc/dml2_0/display_mode_core.c |  104 +-
 .../amd/display/dc/dml2_0/display_mode_util.c |    3 +
 .../dml2_0/dml21/dml21_translation_helper.c   |    4 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |    1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   29 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    3 +
 .../lib_frl_cap_check.c                       |  396 ++++++
 .../lib_frl_cap_check.h                       |   90 ++
 .../dc/dml2_0/dml2_translation_helper.c       |    4 +
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |    2 +
 .../amd/display/dc/dml2_0/dml_frl_cap_chk.c   |  413 ++++++
 .../amd/display/dc/dml2_0/dml_frl_cap_chk.h   |  109 ++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  704 ++++++++++
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |    5 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |    1 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |   10 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c |  286 ++++
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h |  146 ++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  | 1043 +++++++++++++++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.h  |  436 ++++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.c    |  907 +++++++++++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.h    |  335 +++++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |  207 +++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.h  |   59 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   99 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   37 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   19 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   49 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   13 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    1 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   42 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   13 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   38 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   34 +
 .../display/dc/hwss/hw_sequencer_private.h    |    3 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |    2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   10 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  176 +++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  231 ++++
 .../amd/display/dc/inc/hw/timing_generator.h  |    5 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   15 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    7 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    2 +
 .../display/dc/link/hwss/link_hwss_hpo_frl.c  |  113 ++
 .../display/dc/link/hwss/link_hwss_hpo_frl.h  |   34 +
 .../drm/amd/display/dc/link/link_detection.c  |  111 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  223 +++-
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |    1 +
 .../drm/amd/display/dc/link/link_factory.c    |   44 +
 .../drm/amd/display/dc/link/link_validation.c |  298 +++++
 .../drm/amd/display/dc/link/link_validation.h |   13 +
 .../amd/display/dc/link/protocols/link_ddc.c  |   90 ++
 .../amd/display/dc/link/protocols/link_ddc.h  |    4 +
 .../display/dc/link/protocols/link_hdmi_frl.c | 1187 +++++++++++++++++
 .../display/dc/link/protocols/link_hdmi_frl.h |   53 +
 .../amd/display/dc/link/protocols/link_hpd.c  |    1 +
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |    1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    5 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |    8 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |    8 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    2 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    2 +
 .../dc/resource/dce112/dce112_resource.c      |    3 +
 .../dc/resource/dcn30/dcn30_resource.c        |  126 ++
 .../dc/resource/dcn301/dcn301_resource.c      |    1 +
 .../dc/resource/dcn302/dcn302_resource.c      |  109 ++
 .../dc/resource/dcn303/dcn303_resource.c      |  109 ++
 .../dc/resource/dcn31/dcn31_resource.c        |  127 ++
 .../dc/resource/dcn314/dcn314_resource.c      |  127 ++
 .../dc/resource/dcn315/dcn315_resource.c      |  128 ++
 .../dc/resource/dcn316/dcn316_resource.c      |  126 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  131 ++
 .../dc/resource/dcn32/dcn32_resource.h        |   79 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  132 ++
 .../dc/resource/dcn35/dcn35_resource.c        |  121 ++
 .../dc/resource/dcn351/dcn351_resource.c      |  121 ++
 .../dc/resource/dcn36/dcn36_resource.c        |  121 ++
 .../dc/resource/dcn401/dcn401_resource.c      |  121 ++
 .../dc/resource/dcn42/dcn42_resource.c        |  121 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    5 +-
 .../gpu/drm/amd/display/include/audio_types.h |    1 +
 .../amd/display/include/bios_parser_types.h   |   14 +-
 .../drm/amd/display/include/logger_types.h    |    2 +
 .../drm/amd/display/include/signal_types.h    |   12 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |    2 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |    6 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |    2 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |    2 +
 .../amd/display/modules/inc/mod_freesync.h    |    3 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |    1 +
 .../amd/display/modules/inc/mod_info_packet.h |    2 +-
 .../display/modules/info_packet/info_packet.c |  122 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    4 +
 180 files changed, 15147 insertions(+), 117 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h

--
2.54.0

