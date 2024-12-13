Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EB4E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE34E10F066;
	Fri, 13 Dec 2024 15:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gYc40TVF";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91EAD10F066
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpjDs10tdloNj4yoo4WDDxc6oH8/KFbyY+3aOriDsrJ/k9WyqYMNROLqnC6aQUyPy8624jtTSA+ppSdbh5di0FJPVA4+an0gV7GPpTMZxHBWg46tQ/d2gZuBMfgItJuAc6xnnGZetOW7GZisO/DExd5hBPWucZqOi7Y9zYiXoTKB5dU8xgxO0DJr5h6UmixsXcO1bZC5qubYfqJWKvnqalPWWhnRNZ58h9TE5vAZGR1wOjBp0xFUGnVipzo+es/KO9P2vEKsx4wJZyvvMXXC5T0Lgtyaz+ghLG95iOy3YEKAuikoxj0n6fvBzOPoMlauFNvEgDVH7MNos8shGLWe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V+eILuC0kO0i791NlQ7/ofcaOwtkmWKmtweMdRGyLM=;
 b=H3Ta2v+wGa3wfbhwUl3k0ywHrBypmLXyorMVZppydejZaMJLoys5WwWTY+Mk77gYYdTmY6NKUg/bgtUVqM4lgEo9/CSQtCtoRLjjst2Txc6+9+uIoYzkc0rOK4XR/oCTNZ801FbHA8ej3Iyq11nqHpdi105+lDQUtqc6w/WBVds89xX3jnk2iFBFhxcI8iL2ztzRiI0eT0aDdZoNDI6HFu/ni5kLoLTyOaE7WwvgqN2ACEUrF5TeOiRTMktoaJdoyc7XGubXZojdPeIxfsFAEaO2oqW/N1Q2MDA2JD0nNFviWvh4o9MJDyggpQKE+8EKwm+z5bZN5Kpki4WaS4y2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V+eILuC0kO0i791NlQ7/ofcaOwtkmWKmtweMdRGyLM=;
 b=gYc40TVFGo2m2Eqrfomb9sjigXXMoo1U9SMzLz2eVRV8yVC/IhuGZkf6gPERCL5sywNwXJT/l81QdneqQslr30mgpmMlzzZBzzLQXrc5FNEDDEQXYKtA6N8Sm2Pjt+ucyTi+NYaMhX/HlXo+LraElwulFenDswFLfKf1FJ7Ck84=
Received: from DS7P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::8) by
 SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 15:54:34 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:1ca:cafe::9a) by DS7P220CA0010.outlook.office365.com
 (2603:10b6:8:1ca::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 15:54:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:54:33 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:30 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, "Rodrigo
 Siqueira" <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 00/17] DC Patches Dec 13, 2024
Date: Fri, 13 Dec 2024 08:52:32 -0700
Message-ID: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 30dfb9e4-811b-4d66-e6ab-08dd1b8e7014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWlYTERIRmxGa1Z1N01NKyt1cDJhTVdDSFRPK1BhTVFXMVdGaVZFbGJxT0Nk?=
 =?utf-8?B?RTNKajFnVFhSTFI2Tzd0dUJLZlhqZGxnNUhaOWcwdXFQSFBjdWxSdDE4Y1dm?=
 =?utf-8?B?RjBackZ3aUFod0pmTGpBS2NoL09MdVV3aldtbE45c1VxUjlKTlF5RFZSN1Rv?=
 =?utf-8?B?MlNjQmxOdEVQOTBpeDVGV1JVa2VVMktldXRJN3o2TU9rOEJHQUtub3ZpaGlx?=
 =?utf-8?B?ZU5NdVE1cVY2TlhpM1djcmF6YmpLaVJDVXFjQnY2VklxNmNWa2RvV1hoMXZv?=
 =?utf-8?B?WUVXdGFhcnpzZitva1hIcWxQWEVDUmY3aVdqT3NFcDU0QmZlMEYrdkNxNmVj?=
 =?utf-8?B?Nm1DOFhJSEZkY3hkZVpSTTB5bVpNcWRka0Zxdm5xZEhOU2x5cHRLME1MSlZT?=
 =?utf-8?B?aDArSHd5dnpvOHVNVzJxUWN3dEZpa1dNenpWOU41OFlPamw3OWg3bFZ6L2Zl?=
 =?utf-8?B?citNWjVHamQxY2hJdWpkaG4zWjZHajg2WW5wNVpaM2c3a0xSbGRBOHViR01W?=
 =?utf-8?B?RHRYRlZwSjQ4SW9iTmlocnNTL1luaitXQlg5VDVSUWgvcUxwU0Nudno1bFY1?=
 =?utf-8?B?cDVJcWlWOEd6SkZnRUhtWXNWZTdZbkcvRm9rcDlBOTJyU1NzL2ZlQmlxdjM1?=
 =?utf-8?B?TXk2MXRoQ2QwdFZ6RFRScUxWQmgzZWt4RGNJeUV5WXE3RmhoTjRvU3RFc2h6?=
 =?utf-8?B?d1Z5VFNZa1o5aEV5L0czNWRsN0hzbTdVekg5Mjc2S1hYYWRJVEdRRk1VVGUz?=
 =?utf-8?B?Ujc3UjdtVkpRVURzZnJyajNUeUJ1UWIwUDlNdjY2ZUtoZTQwVmQ1eXQ5K0tT?=
 =?utf-8?B?RHB6RkhtcjJjNkxzQUJCZGFZeXpjSEVqYzMvWWtPSkU2eklGcUNHREhkdWNn?=
 =?utf-8?B?ZnVaaVRDcU5kbE9OMlJ3bzYvNTVuWDBNNTVGb0pYZFZCVWNpdk94MTlyd3lo?=
 =?utf-8?B?b3NwQ01UYklzSDZ6OWVPVDJRcE55R0xtbFdXRnEvaHVlQUl1WFJnZTVNTXZL?=
 =?utf-8?B?QllON09OQ1lIaGdmZmpPN1lvd3FDNWpXbGhjSUZIeUMzM014RWNUazBISVdj?=
 =?utf-8?B?bE9lbmlET1JMOW1QWWVlbzF1N1pjbzByYVpEZXdmeW1JYloyeFIrYmp2V2Vh?=
 =?utf-8?B?bXJydzluRm5pN1JXN1JBNVIrdEVMY2tqR0VFRXFZQzNYVnlUalFmaXlaYmxo?=
 =?utf-8?B?WDJ0U05vVmlTTkI4Y0tQQ2hnY3EvRXF4N01YSklMd2NWdW5oUWVodlpmM0k5?=
 =?utf-8?B?RG5RUGYyZFUyMVRzM2Q3VktQWlZkb0c2V2tyWW1oY0xwanJRS01ZUVRxNk83?=
 =?utf-8?B?SFVITTlFSDQ1UG9yZnlhTDN1V1FVQmI0UDhqSzFCNlpwTkZsWlhrc25ySkdn?=
 =?utf-8?B?UlVtRzNmeitCem1DMjcyajZlMU84eWFEeWZnbER6NEdLdWsvcEZJQWh6eVVi?=
 =?utf-8?B?K0VqMmdyWjRDMlRXa3RSWDNCNVppblFvdVZsUmRoMkU4U255R3VqNWlHUDN6?=
 =?utf-8?B?TGF6WHRPNy9XZjloSGozVjVsckNPSW9DOXdvd3RjZFNjTVpZY0ExeDVNcjdB?=
 =?utf-8?B?R1c5QlRBZ1dHV0tVUkV2aHlPQkRWZmxOWmtWVXNuOGhGVjBrZ05mc1pHU1lC?=
 =?utf-8?B?a2piVWdMT0NHOXBPZDJkR0kxaEhXdzVIVTZkYlBIQXZwRmo2UldaZnpJaUxH?=
 =?utf-8?B?aTRMMWI4aVNkdkpjdk5Pbzh0YUNsaWlOU2NicXB4ZWxoT1RkWElpaWxjS3hJ?=
 =?utf-8?B?Q1VIR09YMjJJcjZRaTh1VWtoUVB1dHNaVURHQmk5ZGNtckxicTNmNHNLdFJv?=
 =?utf-8?B?SUVyclJVYlNSa2JjeGhpUHhkM21wU2w5YmZ3eFd3UzVyZWhMcGc2RU80VkF5?=
 =?utf-8?B?NGJwaUpIZXZLc3dodW0xYXJ5ZHlpbG1SakxYY2E2cEsreHp4QVFkcllqbkVH?=
 =?utf-8?Q?/iQBV3KqzZUEbrlxEAbMCcODxjQCJ2tR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:54:33.5108 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30dfb9e4-811b-4d66-e6ab-08dd1b8e7014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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

* Update DML21 code.
* Fixes for FAMS2 interface.
* HDMI fixes.
* Compilation warning fixes.
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Fix uninitialized variables in amdgpu_dm_debugfs

Alvin Lee (1):
  drm/amd/display: Update FAMS2 config cmd

Aric Cyr (1):
  drm/amd/display: 3.2.314

Austin Zheng (1):
  drm/amd/display: DML21 Reintegration For Various Fixes

Charlene Liu (1):
  drm/amd/display: init dc_power_state

Chris Park (1):
  drm/amd/display: Block Invalid TMDS operation

Dillon Varone (3):
  drm/amd/display: Add support for FAMS2+ interface versions
  drm/amd/display: Add new message for DF throttling optimization on
    dcn401
  drm/amd/display: Re-validate streams on commit_streams

Fangzhi Zuo (1):
  drm/amd/display: Fix Mode Cutoff in DSC Passthrough to DP2.1 Monitor

George Shen (1):
  drm/amd/display: Disable MPC rate control on ODM pipe update

Harry VanZyllDeJong (1):
  drm/amd/display: Fix brightness adjustment on MiniLED

Meerpate Patel (1):
  drm/amd/display: initialize uninitialized variable

Nicholas Kazlauskas (2):
  drm/amd/display: Apply (some) policy for DML2 formulation on
    DCN35/DCN351
  drm/amd/display: Don't allow IPS2 in D0 for RCG Dynamic

Rodrigo Siqueira (1):
  Revert "drm/amd/display: Fix green screen issue after suspend"

Shunlu Zhang (1):
  drm/amd/display: delete legacy code

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    8 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |    6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |    3 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   46 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |    1 +
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   |   23 +
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |    3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   40 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |    1 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |    3 +
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |    1 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |   15 +-
 .../amd/display/dc/dml2/display_mode_core.c   |    6 +-
 .../dc/dml2/display_mode_core_structs.h       |  103 +-
 .../amd/display/dc/dml2/display_mode_util.c   |    6 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   16 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |   80 +-
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |    3 +-
 .../dml21/inc/dml_top_display_cfg_types.h     |   52 +-
 .../dml21/inc/dml_top_soc_parameter_types.h   |    2 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h |   77 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   42 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 1306 +++++++++++------
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |    2 +-
 .../src/dml2_core/dml2_core_shared_types.h    |  129 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     |  223 ++-
 .../dml21/src/dml2_core/dml2_core_utils.h     |    6 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |   49 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  394 +++--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |    7 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |    1 -
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   51 +
 .../dml2/dml21/src/dml2_top/dml2_top_legacy.c |    4 +
 .../dml2/dml21/src/dml2_top/dml2_top_legacy.h |    9 +
 .../src/dml2_top/dml2_top_optimization.c      |  307 ----
 .../src/dml2_top/dml2_top_optimization.h      |   33 -
 .../dml2/dml21/src/dml2_top/dml2_top_soc15.c  | 1177 +++++++++++++++
 .../{dml_top_mcache.h => dml2_top_soc15.h}    |   20 +-
 .../dml2/dml21/src/dml2_top/dml_top_mcache.c  |  549 -------
 .../dc/dml2/dml21/src/inc/dml2_debug.c        |    5 +
 .../dc/dml2/dml21/src/inc/dml2_debug.h        |   46 +-
 .../src/inc/dml2_internal_shared_types.h      |   60 +-
 .../display/dc/dml2/dml2_translation_helper.c |   54 +-
 .../display/dc/dml2/dml_display_rq_dlg_calc.c |   12 -
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   12 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   12 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    5 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |    4 +
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |   18 +
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h  |    7 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    4 +
 59 files changed, 3225 insertions(+), 1880 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_interfaces.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_legacy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_legacy.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_optimization.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_optimization.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml2_top_soc15.c
 rename drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/{dml_top_mcache.h => dml2_top_soc15.h} (58%)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top_mcache.c

-- 
2.45.2

