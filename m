Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1B7EE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C84A810E438;
	Wed, 23 Aug 2023 15:51:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F0210E439
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHL1yXkuxqIWj8yjsd7OLZ//a0eLlaouLH0boFmAAUtp3I0aBFJAEkFSdz2qUBT5DQ09srtKXRNcwEZXNXwn7vtdTL8qbQ7S0zRaQrzSVj/RTfSCn7lCGAqbHBHblX81HF7lYqI7xt+o+Z3JUXe7fzQYOya15raCAL5z5FlSjTTIHsq1iPjfhTAiXH4N2tKEnMpHOFtcxcd6sTBZPKNZ0jKZCLM+fRiixZSpp1EWeKfwcPiNp0oewnukxisRVnkGv6eYM+JToFyYXoVLjsekW1OzhKhTq9Pmwpl9BbkDzSoTRzc2kT/NGuHBuuwugh6pL7nacFoPN88ObhZlI9uV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHzQWy1Snd6BfGh7tg5D7CGrP8PqYqAU8UtNLBYAEGE=;
 b=Pavj/NkuJs680oQRO3a+rpBA7lpAwynjAm4DmjXbFXXnSFj7ZZ2jEhPsSg394vZVoNtoTjDT1Peu2Gl3PtjktILGcrebAseO9il3nqZkwIrKBxLOf4ZC6FercXFosjdqYqnMo7TOsEnobUCG0KZVGzZmjK0/K0j8KOKB50WY5N8flMLmTne7AhsEk7+QSygN2z7Uwp1pvyI8s09a2Eea72FmUlDa9zaBall2jCU5Rv+57oB3zdA9mWL5vm9ptfXQ2NDNc5c3Yi8n4vRqfSb2vpGeEK7qJ1ORyPLoZ+bCaBvM7Ik4HQd5oFB/zEdbe15h1BYy/F39qVVslTZfZD2rEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHzQWy1Snd6BfGh7tg5D7CGrP8PqYqAU8UtNLBYAEGE=;
 b=mwUpH7FlFytgJJyLnyGVouoKKJvhp+xp/wuf4kVh0hZ5PJGwFQWMQn8Bp8wepy//8ugBbgeCB5G8MEXqZ0UB0Xq/UFIAyPkRSH1yMtMxRkmz0MHCo8xppT735SGitX99XrU7kZnv22Gsch/EhvStE0rrxxxpniYmxnc9JZxQTBo=
Received: from DM6PR21CA0029.namprd21.prod.outlook.com (2603:10b6:5:174::39)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 15:51:04 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::bc) by DM6PR21CA0029.outlook.office365.com
 (2603:10b6:5:174::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.10 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/35] Add support for DCN 3.5
Date: Wed, 23 Aug 2023 11:50:14 -0400
Message-ID: <20230823155048.2526343-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: d86ed594-dd1d-4ac7-ae3f-08dba3f0c1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJ+dYW10xdNDVvF8oS0tiKkImtMv1hP4c/KxWO4Lw6Q+uMLsGbXEHMXE6NrhFn1JKhPZXwNWp8RVgm3tFz0M2fetuHrwRjbCJZ5645Jy7FFR+G7PJx/M29Yg7OWsWlB9Y0LOI1xnUUOq8nynDhtCF51Q1tWa4EXQlXM0i1S0MVtOsJNmlsZs15It5hs4gKlJhEUTJ/IYUdo9/B8r/vDsrvIcbmHR4GV2UeZIORS+gkN3KnbQsSfOX2yQ2EVx+5bv71bGBY9N6JiHr+jOx86/EjxyUqrLreLU8W7ayZo9KI5J2HL0XJ7FjyckWCsoebgcDs1VlaQfdCTsYDAO957EjdTEcB6A+Gz8Nm5EiVwJ56mSNfCBpdQ+Q7sZBbM5rRReVtECm8HlZagOD5GGFnPXJ679gGnhmcSP4rwcSDm0FlXDpXx+wXIA0jFGIGAeczVqYigjXTl1jDx3dmQ5o4sSviVhQENSVjoDnAzDDPE4QqnLyrs5DGk/C9qKEOeIPyQt2f0UCX8fAr2rG3QB/LUAhvsX/eyNmafe88hy1G7U7IQiGRS18E23wcjxkGOTYcs/F5mWZA40gvrJ0SaUgoKLUa+z9JBmexnR6F5KGQ8mKO1y8IBVUf/6B89jIzokTde0g4ZWhAEH9gMVm5FLutrfVrG8nK7owWGAIZ154JptcvtlTkLB1GQdL7mnI95rx6ncU1ynZU/yUpDw/WqoYBiatGudJ/WICNAHNRIryigqOCNF3q4bTVYpjhh5pXYzFU/W9vROcmgS4dl0ys2PSwYV/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(7696005)(6666004)(40460700003)(83380400001)(426003)(336012)(82740400003)(356005)(81166007)(86362001)(36860700001)(36756003)(47076005)(16526019)(26005)(40480700001)(2616005)(2906002)(316002)(70206006)(70586007)(6916009)(30864003)(5660300002)(41300700001)(1076003)(4326008)(8676002)(8936002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:04.0621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86ed594-dd1d-4ac7-ae3f-08dba3f0c1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for DCN (Display Core Next) 3.5.

The new register headers were too big for the mailing
list.

Aaron Liu (1):
  drm/amdgpu/discovery: enable DCN 3.5.0 support

Qingqing Zhuo (34):
  drm/amd/display: Introduce DML2
  drm/amd/display: Add dcn35 register header files
  drm/amd/display: Add DCN35 family information
  drm/amd/display: Update DCE for DCN35 support
  drm/amd/display: Update DCN10 for DCN35 support
  drm/amd/display: Update DCN20 for DCN35 support
  drm/amd/display: Update DCN30 for DCN35 support
  drm/amd/display: Update DCN31 for DCN35 support
  drm/amd/display: Update DCN314 for DCN35 support
  drm/amd/display: Update DCN32 for DCN35 support
  drm/amd/display: Update dc.h for DCN35 support
  drm/amd/display: Add DCN35 BIOS command table support
  drm/amd/display: Add DCN35 GPIO
  drm/amd/display: Add DCN35 DCCG
  drm/amd/display: Add DCN35 DIO
  drm/amd/display: Add DCN35 PG_CNTL
  drm/amd/display: Add DCN35 OPTC
  drm/amd/display: Add DCN35 OPP
  drm/amd/display: Add DCN35 DPP
  drm/amd/display: Add DCN35 DWB
  drm/amd/display: Add DCN35 HUBP
  drm/amd/display: Add DCN35 HUBBUB
  drm/amd/display: Add DCN35 MMHUBBUB
  drm/amd/display: Add DCN35 DSC
  drm/amd/display: Add DCN35 HWSEQ
  drm/amd/display: Add DCN35 CLK_MGR
  drm/amd/display: Add DCN35 IRQ
  drm/amd/display: Add DCN35 DMUB
  drm/amd/display: Add DCN35 init
  drm/amd/display: Add DCN35 Resource
  drm/amd/display: Add DCN35 DML
  drm/amd/display: Add DCN35 blocks to Makefile
  drm/amd/display: Add DCN35 CORE
  drm/amd/display: Add DCN35 DM Support

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    32 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |     1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |     1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |     2 +
 .../display/dc/bios/command_table_helper2.c   |     1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |     8 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |     5 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  1001 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h  |    63 +
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |   453 +
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |   180 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    29 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    23 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    63 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |    64 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |     3 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |     4 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |     1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |     9 +-
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |    20 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |     4 +
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.h   |     6 +
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |     5 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |    33 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |    30 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |    19 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |    64 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |     8 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |     5 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |     2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |     2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |     1 -
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.h      |    10 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c |     6 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.h |     3 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |     2 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.h   |     6 +
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |    22 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.h     |    40 +
 .../drm/amd/display/dc/dcn32/dcn32_mmhubbub.h |     4 -
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h  |     2 -
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |    61 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |     2 -
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |    20 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |   737 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h |   190 +
 .../display/dc/dcn35/dcn35_dio_link_encoder.c |   267 +
 .../display/dc/dcn35/dcn35_dio_link_encoder.h |   137 +
 .../dc/dcn35/dcn35_dio_stream_encoder.c       |   528 +
 .../dc/dcn35/dcn35_dio_stream_encoder.h       |   326 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c  |    51 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h  |    55 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c  |    58 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h  |    57 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dwb.c  |    58 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h  |    59 +
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   |   573 +
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.h   |   150 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c |   104 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |    59 +
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.c    |  1193 +
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.h    |    82 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   167 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.h |    32 +
 .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.c |    57 +
 .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.h |    73 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.c  |    51 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.h  |    65 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.c |   284 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.h |   219 +
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |   553 +
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  |   193 +
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  2085 +
 .../drm/amd/display/dc/dcn35/dcn35_resource.h |   307 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |     3 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |    80 +
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |    81 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   484 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.h  |    44 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |    69 +
 .../gpu/drm/amd/display/dc/dml2/cmntypes.h    |    92 +
 .../amd/display/dc/dml2/display_mode_core.c   | 10275 +++
 .../amd/display/dc/dml2/display_mode_core.h   |   199 +
 .../dc/dml2/display_mode_core_structs.h       |  1968 +
 .../dc/dml2/display_mode_lib_defines.h        |    75 +
 .../amd/display/dc/dml2/display_mode_util.c   |   796 +
 .../amd/display/dc/dml2/display_mode_util.h   |    74 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |   734 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.h   |    48 +
 .../drm/amd/display/dc/dml2/dml2_dc_types.h   |    40 +
 .../amd/display/dc/dml2/dml2_internal_types.h |   121 +
 .../amd/display/dc/dml2/dml2_mall_phantom.c   |   913 +
 .../amd/display/dc/dml2/dml2_mall_phantom.h   |    50 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |   311 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.h |    47 +
 .../display/dc/dml2/dml2_translation_helper.c |  1109 +
 .../display/dc/dml2/dml2_translation_helper.h |    39 +
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   452 +
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.h  |   143 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   730 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   210 +
 .../gpu/drm/amd/display/dc/dml2/dml_assert.h  |    30 +
 .../drm/amd/display/dc/dml2/dml_depedencies.h |    31 +
 .../display/dc/dml2/dml_display_rq_dlg_calc.c |   585 +
 .../display/dc/dml2/dml_display_rq_dlg_calc.h |    63 +
 .../gpu/drm/amd/display/dc/dml2/dml_logging.h |    29 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     1 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |     1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |     3 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |     1 +
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |    52 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |     5 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |    10 +
 .../amd/display/dc/inc/hw_sequencer_private.h |     2 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |     9 +
 .../dc/irq/dce110/irq_service_dce110.c        |    12 +-
 .../dc/irq/dce120/irq_service_dce120.c        |    12 +-
 .../display/dc/irq/dce60/irq_service_dce60.c  |    12 +-
 .../display/dc/irq/dce80/irq_service_dce80.c  |    12 +-
 .../display/dc/irq/dcn10/irq_service_dcn10.c  |    14 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |    14 +-
 .../dc/irq/dcn201/irq_service_dcn201.c        |    14 +-
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |    16 +-
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |    16 +-
 .../dc/irq/dcn302/irq_service_dcn302.c        |    16 +-
 .../dc/irq/dcn303/irq_service_dcn303.c        |    14 +-
 .../display/dc/irq/dcn31/irq_service_dcn31.c  |    16 +-
 .../dc/irq/dcn314/irq_service_dcn314.c        |    16 +-
 .../dc/irq/dcn315/irq_service_dcn315.c        |    16 +-
 .../display/dc/irq/dcn32/irq_service_dcn32.c  |    16 +-
 .../display/dc/irq/dcn35/irq_service_dcn35.c  |   427 +
 .../display/dc/irq/dcn35/irq_service_dcn35.h  |    34 +
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |     2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |    23 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    23 +
 drivers/gpu/drm/amd/display/dmub/src/Makefile |     1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   552 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |   282 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    76 +-
 .../gpu/drm/amd/display/include/dal_types.h   |     2 +
 .../include/asic_reg/dcn/dcn_3_5_0_offset.h   | 15255 +++++
 .../include/asic_reg/dcn/dcn_3_5_0_sh_mask.h  | 53412 ++++++++++++++++
 143 files changed, 101257 insertions(+), 148 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_smu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/cmntypes.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_lib_defines.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/display_mode_util.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_mall_phantom.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_policy.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_assert.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_depedencies.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml_logging.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/pg_cntl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn35/irq_service_dcn35.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_5_0_sh_mask.h

-- 
2.41.0

