Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D0606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=a98Rs9J8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32DB510E536;
	Fri, 30 Oct 2026 15:43:37 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B297A10E536
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 15:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHyS4z25uyQpG00lxgTmR+4LHOeQkIJvkGigIHWziYK4W5e+hOus9gVJnxpxwY6xMRjp6S4BPUaI/14ACQ+q2q4I/E3N0/2PwUmJlTCv4bMsgRp08fjjyTT3ljs3HutvAqCiZtQzz/YEdX2//r/UV6s6cgSoPAROQ5jIzRsN39EZ8Syb3Rv8rYfoc3a2Mtx/j5m7wNWd/FqJcSBQDqIz/F8yeMKy6VmOWxse8RjvjQTYlJZwWmXByq03eQCEegpQYnFlkK9IsUP9yYH4lZqGx4dTT7mWrqG5U13uRAenFwdcXOema1iug9FxpgzCwq3Uu0khVyrFOYOeXzrix570Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge5Qgoss6SprU2whGBzHf1MAdCuM9c0w7fYGj1pZCOU=;
 b=aPfhxkTJQoIcTlYZ/DS96UatZlq/TkqNNqKx5fJffbyDxzFNv/e61eNgTdDIcQVTvHr9oYaa+plhTCZU8GGL4EJNmD01dassBRJj5UcHwWxc7OJO5dA9LBSeVkzIauOQenjpC90Gh+tVADHukJcRBTqgzkY/9EDLcVwh4y9V26ES54KLw+M1e5ky++Wptvn+N4ij9pmAeCbRspzrs/54ZgjXbLLKDJZJApitnmIsT/gpQT2G+U1pGkMhkF90gA5UybcoqfsyIR2uRy1o+NojWGD2iRgZqTnRB8M5YqesboXhnUg1Kf6m3/sA60bsngdZgVivoXANTg1/TPMkiUjdfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge5Qgoss6SprU2whGBzHf1MAdCuM9c0w7fYGj1pZCOU=;
 b=a98Rs9J8e8Edh4MW3vzoLz3H5994URzLMmKh//o4MZZ/umhuWKN9yhtPYKaO5b1HJCu3u0dij78nrLu9yA+8X/OgeJTyeBi64qUMX1SlvRDfT3PVDjBVUYmutafl0581VsEWYpBdsLhsEPrFuLs/GrNBsebOey3UtNmg17ve3HA=
Received: from ROAP284CA0421.BRAP284.PROD.OUTLOOK.COM (2603:10d6:10:144::20)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 15:42:55 +0000
Received: from BN6PEPF0000006F.namprd03.prod.outlook.com
 (2603:10d6:10:144:cafe::97) by ROAP284CA0421.outlook.office365.com
 (2603:10d6:10:144::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Fri,
 30 Oct 2026 15:42:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN6PEPF0000006F.mail.protection.outlook.com (10.167.248.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 15:42:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 10:42:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 10:42:52 -0500
Received: from [10.254.93.34] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 10:42:51 -0500
Message-ID: <2ed25555-5b73-43c3-a06b-e419ea2c29a4@amd.com>
Date: Fri, 30 Oct 2026 11:42:51 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/28] DC Patches Oct 27, 2026
To: Alex Hung <alex.hung@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF0000006F:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: a29114ea-b23d-41d8-50a5-08df369c75f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|42112799006|82310400026|1800799024|22082099003|18092099006|18002099003|11063799006|56012099006|261009223027099003|261026140227099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|10067099003|10086099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5HZ0CtAX4UY28646+cLSB9m66/uC+DzGRcjhN8dETQPYWagV+mK4YRViHSKisWfJXeYcS4mx7LtsFER9UIzgmtM9v4pyTEy/cdfRDw0+uZeJnE4s3zrgEK852e1ZNcUdsQGQrafWerjElTnrx1UKjLnaVw8tmvCovX1p6sUMYW4wIMuYHI1kdGyn1ZdKo8YnoVfct6c7iGkxgU/+6atPlv36Qb9UDm4Yy2MX5h8zCHXuPj9ey9SrR/h9ZMSCYrJxyM8pN7z1ae5yARnviFL+e6HdFrzPaBPcEDIpjL2AD8mP6DwoJEFyfJ1gfRWwesd5npo3UotB1BBEM9+zwmo01UWrOSEszz5sBeWqU/rDUzkFHJTWk8aLSRyOCKsS/N3g2XjItMosrUkoARNCHfz20O4zihSZ6ySn1POmMjbR8K7/ZTC/NL80MpDDKBY4WDtZ/vYU9IJbbXGkXIRJaiwRdyPTOe/eSh37ydrffFfHMRLrDsHr8El0VYK9SUDzmlj0X43YxBaxDHJkyS0c8+4tRWWxZ3c/VPzpj1ogh9VNCs9u9RSl8j1wZhXVeKCtdJWFOV9+eyetqoBfjiznEOh1Vb2S57Bnpt5ojxNbMQEoDYDY2Once3Hh1+VdY+7yfBhhJxcQOAbQUwh20Yaj3L7PenXbZMvtA8BPRGZeZSKB81domA2cFCCI4/drlFEo+LWgVM+YNUXYeV0s2THm9gjY8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(42112799006)(82310400026)(1800799024)(22082099003)(18092099006)(18002099003)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(10067099003)(10086099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ikUSoUt78lvapNVxgAUEV8xGTHMS++QwZdWTqBeOroK4aGS7+2dwhQQZzPTfXaY550m6WEHCl599cQbybAJf7jMjafP+hqRDJUuCunmTi53I1kj0SUvly4/5pl2kgyiutVDr6dqom6yCPullUy1gUUbDLML27M3q3cQuBKlxpy9vYl6b+1arTg4LPYtC8CCi/Z6LS4uKA89Y15aKA6UX7Ups7uBeZshBYMRiG6IgyIZ3XUOMecMAysKVRXKL2df0fbhVOCce49iukuxANf1IUI3BxoaSnqqNoo8Kq5bJc7/V7HiOJlTW3YwBGi90u9zAvs+lKj0UmWtjuzPQ8509zfyFocMmFRasn2uSyHb0YNsLjuXcE5XN63N1AahRwsQ+TwtjuP5v8AL+h0XGoAbgdZxKAxpqzWPu8bdgdgI+xRnR7erFlyF982gkPB2xADp5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 15:42:53.1424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a29114ea-b23d-41d8-50a5-08df369c75f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF0000006F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026-10-27 19:16, Alex Hung wrote:
> This DC patchset brings improvements in multiple areas. In summary, we have:
> 
> * Fixes on mode detection, DSC with DPMS off and HUBP DET reset
> * Fixes on DDC pins and missing OTG_CRC1 regs for DCN3.1.x
> * Improvements on DCN6 FAMS immediate restore and PPCLK_e enum
> * Improvements on DSCCLK check and DSC slice calc policy
> * Improvements on Replay frame update interval and debug mode
> * Improvements on DML VM rounding and P-State optimizer
> * Removal of DCN401 RDPCS PHY state reads
> * New debug options for HDMI VRR and visual confirm
> * More KUnit tests for connector, CRC, color and backlight
> 
> Cc: Dan Wheeler <daniel.wheeler@amd.com>

Series is

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks,
Leo

> 
> Alex Hung (5):
>   drm/amd/display: Avoid closing unowned DDC pins
>   drm/amd/display: Add more backlight Kunit tests
>   drm/amd/display: Add more color KUnit tests
>   drm/amd/display: Add more CRC KUnit tests
>   drm/amd/display: Add more connector KUnit tests
> 
> Allen Li (1):
>   drm/amd/display: Allow bypassing link_off_frame_count check for replay
>     debug mode
> 
> Alvin Lee (4):
>   drm/amd/display: Add visual confirm full viewport debug option
>   drm/amd/display: Indicate wait_resp based on FAMS even in disable path
>   drm/amd/display: Enable immediate restore for FAMS on DCN6
>   drm/amd/display: Update alt shared lib to use dynamic state
> 
> Austin Zheng (2):
>   drm/amd/display: Update Rounding For VM stage groups
>   drm/amd/display: Parameterize FCLK/PPT/Temp Read P-State Optimizer
> 
> Dmitry Artemenko (2):
>   drm/amd/display: Add missing OTG_CRC1 reg/mask entries for DCN3.1.4
>   drm/amd/display: Add missing OTG_CRC1 reg/mask entries for DCN3.1.2
> 
> Dominik Kaszewski (1):
>   drm/amd/display: Clarify endianness error
> 
> Fangzhi Zuo (2):
>   drm/amd/display: Fix unadvertised mode detection
>   drm/amd/display: Add debugfs override for HDMI VRR
> 
> George Shen (1):
>   drm/amd/display: Skip dsc sequence for stream if dpms off
> 
> Ilya Bakoulin (2):
>   drm/amd/display: Adjust DSC slice calc. policy
>   drm/amd/display: Expand DSCCLK support check
> 
> Ivan Lipski (2):
>   drm/amd/display: Use DCN6 driver_if for PPCLK_e enum
>   drm/amd/display: Configure alternate-channel apertures
> 
> Meenakshikumar Somasundaram (1):
>   drm/amd/display: Support replay frame update interval
> 
> Rafal Ostrowski (1):
>   drm/amd/display: Decouple FAMS2 config update from dc/dc_state and add
>     BLS opcode
> 
> Roman Li (1):
>   drm/amd/display: Reset DET of HUBPs without a plane before outstanding
>     updates
> 
> Taimur Hassan (2):
>   drm/amd/display: [FW Promotion] Release 0.1.82.0
>   drm/amd/display: Promote DC to 3.2.405
> 
> Tony Cheng (1):
>   drm/amd/display: Remove DCN401 RDPCS PHY state reads
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   | 110 +++++++++++++---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  30 +++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  63 +++++++++
>  .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   2 +-
>  .../tests/amdgpu_dm_backlight_test.c          |  79 ++++++++++-
>  .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |  18 +++
>  .../tests/amdgpu_dm_connector_test.c          | 118 +++++++++++++++--
>  .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 124 ++++++++++++++++++
>  .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  37 +++++-
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +-
>  .../drm/amd/display/dc/core/dc_hw_sequencer.c |  69 ++++++++++
>  .../gpu/drm/amd/display/dc/core/dc_resource.c |  47 ++++++-
>  drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 113 ++++++++--------
>  drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  27 +++-
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +
>  .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   1 +
>  .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   1 -
>  .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  16 +--
>  .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |  22 +---
>  .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |   8 --
>  .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   2 +-
>  .../dml2_core_dcn5_funcs_mode_support.c       |  24 +++-
>  .../dml2_core_dcn6_funcs_mode_programming.c   |   1 +
>  .../dml2_core_dcn6_funcs_mode_support.c       |  19 ++-
>  .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |  25 ++--
>  .../alternate_pstate_shared_lib.c             |   2 +-
>  .../alternate_pstate_shared_lib.h             |   1 +
>  .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c    |   1 +
>  .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |   1 +
>  .../src/inc/dml2_internal_shared_types.h      |   4 +
>  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  24 +++-
>  .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |   1 +
>  drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   1 +
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  64 ++++++---
>  .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   4 +-
>  .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
>  .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   2 +-
>  .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   2 +-
>  .../drm/amd/display/dc/hwss/hw_sequencer.h    |  20 ++-
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 -
>  .../dc/link/protocols/link_dp_capability.c    |   6 +-
>  .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  18 +++
>  .../amd/display/dc/optc/dcn314/dcn314_optc.h  |  18 +++
>  .../dc/resource/dcn401/dcn401_resource.c      |  10 +-
>  .../dc/resource/dcn60/dcn60_resource.c        |   1 +
>  .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  31 ++++-
>  .../amd/display/include/link_service_types.h  |   2 +-
>  49 files changed, 987 insertions(+), 206 deletions(-)
> 

