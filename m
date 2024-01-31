Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C375FC48285
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 20:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE1610F53A;
	Wed, 31 Jan 2024 20:12:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A62810E990
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 20:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzGSw3fjoR+UipTgWLlAgFnhTif33/rlL9tzk3yHTMop3Lmdjk/zzycyxHjLUkcvTqNoDJ8hZSD+LZ+iYEd5ntwI2KzpB6c8kfb1Bx7Z9vPYPem/RT4w1y2BdkIaE+fWwDmEDSG7h2L8bvUz4vHPMOZ8HkvwkBOq9ZPZzP/Ofca4DHXowZTDczIpDZHpvDsTwwU6/LL6RVOII6MjyH2E+BCvLCujgn+kK5TzF4qmRkqtkUsY1QyhuV59eIkeXAEVrMv1z+HtlNgWZXiZze/hVyWbtYsSr2cn82XNIvytRbAweIXmpFT7gKLios2YB6LrXiKOGckTEYIJgdTJwLuHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydWjbpGpVo13GIPOm2WfIKfBMC/ih3LdEH+Es9IitQA=;
 b=FY144H7oScscAbOHQp8bSe7rEmJWzZoj6v99v62UKMVXimBNYqTLqAb2N52l55ajGetPCUJBCSt9xtaBsb30u2h0d0A8QDd1YclYV8NIN44vMGcMb2rrv9Gvb0b0lmTKh0uQksvbZ52HITlNj1TMm8S4dmhSlG3vTJgiW3Kzeg6zxlJ6rlQDMgQhzQSDylbzsJQZstAfQsqcffLUqCylxEawh1/GIg1qI2gAM5uiUycVULledKskUKRYZt8K97cI2OEwHh8b6gKHB/yQ9960aoqII4MHchOcqSqNBzN7IKxWUpVjuV3mFel+648wbG9hdjYSQ4v9xJJqVm0pwsO/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydWjbpGpVo13GIPOm2WfIKfBMC/ih3LdEH+Es9IitQA=;
 b=tgDH6Qco6UPKdS6zWVYewth8DfzUqBYtNCsB/mbpPsb6IVsisonMOCBncsCC2gJo/7/g7SZGW691CxhIGoyJbaLm+IRFCUBxherwMdZQup5AD2bbtOZDnfTSXB6fxr+XPCvB2ZuvVtN3o/Af68q7L/GhHUPy71vgABMtRTVaeM0=
Received: from SA9P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::22)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 20:12:38 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::14) by SA9P223CA0017.outlook.office365.com
 (2603:10b6:806:26::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 20:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 20:12:38 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 31 Jan
 2024 14:12:36 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/21] DC Patches January 31, 2024
Date: Wed, 31 Jan 2024 15:11:06 -0500
Message-ID: <20240131201220.19106-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fe97e3-d5e2-4cd6-df8f-08dc2298f8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNOG/QzUjksjZEnDDHSd2CZtye7lihV6mvCC2oqO1I0yYjziOc/wAz9tWPtBWFmm9B5Auf6FDfobsV32zsi+aKHY+xuXQvjBvw7x/0z0N2K+2N+O2JnLchUm8zN8kzXqGarpxlgJMYd+IXiobQD8Jvb0X88uSU9ZadAxCmKXUgjnEyvA+uuD3reeLzsggOP72N9rftXETevGgjZ5zq4xZfUZ6rG/porYIdxSnFu1WvwdkJoncrEx9QUWAg0dMQ3oRgYJRo6T6MvwF+hxw4dfD2Er2+bUJS9VWeCwaKVLBhhpUJSjcHAACGNMgR5xh6teDjAScS/aaPmKovAwjgikqouNsRt5W38vHL50mjwA97CqJLv+XM1oSYXmRiPE6swEODmj+IkFvbm3h7mfh8mIWOBLtJt1va+ounCGynaQDTwPQ8ajISkqMXOfeiiHUB8Ej5vj6f3lTqolsweFA/tBdFXamcktlmBHHEi4Gt0VO7Lsvpiu4KNEnYdSA2ORLFnGFdOCSknpUvNo7JIxKp2uoUxPOtjpk4w3+gQv8x+rNfR3dleSHIQJHF0tB8ow255oL1eAGU++tmJ0JR9zb0I+UCPX1gngEF3g39/UxWgmbicqYMPQxa7SpLU5MhGH9zg+7DPlk6dqMix559ZGcsXY5kv5/2ZOXFN7cpKrDDS5NRHE1sOZCTZjmZQwYlxuMtSTAJTcfdWCDQJijVMxG8wskfh0KQT4o0bGKtHeiBmcCY/ZVTz993LEHA80AvKbBPeTAPo9WcTpyI2bSoMJ+LkxSTicCj7dRwbDhCywvCj5TRd63Bt0d2cPFRY6Wq/WQm7v
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(40470700004)(46966006)(36840700001)(44832011)(316002)(6916009)(356005)(2906002)(40460700003)(40480700001)(54906003)(4326008)(8676002)(8936002)(36756003)(36860700001)(47076005)(86362001)(5660300002)(70206006)(70586007)(82740400003)(81166007)(83380400001)(26005)(336012)(426003)(16526019)(1076003)(2616005)(6666004)(41300700001)(478600001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 20:12:38.1937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fe97e3-d5e2-4cd6-df8f-08dc2298f8b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449
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
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This version brings along the following:
* DCN35 fixes
* DMUB fixes
* Link training fixes
* Misc code style fixes
* MST fixes
* ODM fixes
* SubVP fixes

Allen Pan (1):
  drm/amd/display: correct static screen event mask

Alvin Lee (2):
  Revert "drm/amd/display: For FPO and SubVP/DRR configs program
    vmin/max sel"
  drm/amd/display: Update phantom pipe enable / disable sequence

Aric Cyr (1):
  drm/amd/display: 3.2.271

Camille Cho (1):
  drm/amd/display: correct comment in set_default_brightness_aux()

Ethan Bitnun (2):
  drm/amd/display: Add delay before logging clks from hw
  drm/amd/display: Adjust set_p_state calls to fix logging

Fangzhi Zuo (1):
  drm/amd/display: Fix MST Null Ptr for RV

George Shen (2):
  drm/amd/display: Add debug option to force 1-tap chroma subsampling
  drm/amd/display: Add left edge pixel for YCbCr422/420 + ODM pipe split

Michael Strauss (2):
  drm/amd/display: Remove Legacy FIXED_VS Transparent LT Sequence
  drm/amd/display: Don't perform rate toggle on DP2-capable FIXED_VS
    retimers

Nicholas Kazlauskas (4):
  drm/amd/display: Add more checks for exiting idle in DC
  drm/amd/display: Disable timeout in more places for dc_dmub_srv
  drm/amd/display: Increase eval/entry delay for DCN35
  drm/amd/display: Disable idle reallow as part of command/gpint
    execution

Rodrigo Siqueira (4):
  drm/amd/display: Drop legacy code
  drm/amd/display: Disable ODM by default for DCN35
  drm/amd/display: Trivial code style adjustment
  drm/amd/display: Drop some unnecessary guards

Wenjing Liu (1):
  drm/amd/display: set odm_combine_policy based on context in dcn32
    resource

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  12 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 -
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |   4 -
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |   4 -
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |   4 -
 .../display/dc/clk_mgr/dcn314/dcn314_smu.c    |   6 -
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   4 -
 .../display/dc/clk_mgr/dcn316/dcn316_smu.c    |   4 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 115 +++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  68 ++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  18 +
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   2 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  17 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   7 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |  14 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   3 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  26 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |   4 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  17 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   2 -
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  76 +++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  21 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 +
 .../display/dc/hwss/hw_sequencer_private.h    |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 -
 .../amd/display/dc/inc/hw/timing_generator.h  |   2 -
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  27 +-
 .../drm/amd/display/dc/link/link_validation.c |   2 -
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../link_dp_training_fixed_vs_pe_retimer.c    | 372 +-----------------
 .../link_dp_training_fixed_vs_pe_retimer.h    |   5 -
 .../link/protocols/link_edp_panel_control.c   |   2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 -
 .../dc/resource/dcn32/dcn32_resource.c        |  18 +-
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  11 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |   2 -
 54 files changed, 372 insertions(+), 572 deletions(-)

-- 
2.43.0

