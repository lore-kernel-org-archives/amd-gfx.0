Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3201C02199
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 18:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F128A10E38C;
	Wed,  5 Feb 2025 18:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2lEeRRwB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFC610E387
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 18:40:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0pDDumcc5EkktSwq4ePDyo9Rglpa7s3wygf2+zom1v42ND+5vX70RnPLZsrLfTxOshHwG4VH5Jpx+nKOeHEwZjWqZ4pGy8h+0CjJbfrq+HHUx6217WU1RVxqSpio1sQ321mp5r4UD1rOPyfbCY8fgoJQeKb1A9w3732a7ZKhKoGpSBOEhBOKG9mRRnIQgKg4ns2LJmpE1w0n63Zqh6S0RZzZptkeyuOqj2cyr3tKmpy9Pm3IwspDm3PXQ7V5BG9+7QExkF5RCdTLBDSojwxQB3SlX8kBMlcVtpaY7SQ/x7j9PyxweAGYC2kDHz4uotI0Yrx8lhAdIcWkN+ZuUah8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyHj5vEbdSs5jFCKxPgVSPtQQZLodoDzWlwujXrMx5o=;
 b=pfq2ki/a4Q9AN/Wp7kYhZuzfLTMTqWvg5SHcVvYzM3hYIAwpEMG2Z02ZEyhQ79MQqJdAub7PoEQyJvj1U9bRf62GeejyjzDvLORwX3digaWp8nnDeRkCW+1PX6HvoVsTJauq9DC0GDbG0nkoAAKvr1axk7DxibjaYVStvrGrR78QkiZXC/8RFEnkDThCeYwWbKK1//90YHCkjHNjp3V3YQaEBT08Sc2ES3LqGjHRhmUjqM1tCPsGJFbrpvhSgmrjb0drFFZZ0ZX250EKhFe1Nuta//vIbLlUylfvhHziv8Ae2lWjh0jsd+LctZIDYn52b5QSpPTAxbC45CIb6HmVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyHj5vEbdSs5jFCKxPgVSPtQQZLodoDzWlwujXrMx5o=;
 b=2lEeRRwBojqwSo1v8MJpNvHDLnd/frmpj15w+OhJUVGHy7PABPhq7eKb8FuOn/kT3eGVZuvq6ggI2tlMh1eeXMmZwLiWFwyFYWagsSc1ec92UJkFRZZAIKIsEfKzXpMAcKZF4KqO0ZPIKhsA5qbqxPLdbI32+IuRQrLauHrPhFQ=
Received: from SA9PR13CA0095.namprd13.prod.outlook.com (2603:10b6:806:24::10)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 18:40:51 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:24:cafe::bd) by SA9PR13CA0095.outlook.office365.com
 (2603:10b6:806:24::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.5 via Frontend Transport; Wed, 5
 Feb 2025 18:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 18:40:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 12:40:49 -0600
Received: from aaurabin-cachy.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 5 Feb 2025 12:40:48 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/14] DC Patches for 10 Feb 2025
Date: Wed, 5 Feb 2025 13:39:15 -0500
Message-ID: <20250205184036.2371098-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 9415d892-f051-418f-4ea9-08dd46149d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q3yS/m0p4IXWfpBwx79KcZEqoV24L8gM4htSJNA3sRXbQdEEuwHmFi0Evhzo?=
 =?us-ascii?Q?eCXq5m4FHkE4aH7Q56vpUw6Nmp605I32Nn3Hp79fv+mYv+sKoPj0z5xOxe2F?=
 =?us-ascii?Q?Qzc5DTHmtrVPn8eoBygjDjakBjUmbRI63gaMVi0hjOSS0v9T2mantB/OJNTj?=
 =?us-ascii?Q?QCGq7FQt7cWBbJvYZJozpX8svyIrEWlVCczX/DFzbk2HvjvkcxluOH6e7ZI8?=
 =?us-ascii?Q?KRKH1zo9pX39RvcnrpkuhOwq2zC/xxwHiPErog7PP7p/dEluWMt5cOrI0x4w?=
 =?us-ascii?Q?PhaV2NXJGPNPZt6eDPcmf9dCL/gyiQMAKrcaNjZgNKLmD+OlEMYgjYVd9NKR?=
 =?us-ascii?Q?BfxNzH8fCjxPSd8ormwDSMumzTfzNGIS8hVG7WKIENtiag/jrUzn3O9c7rdC?=
 =?us-ascii?Q?IIMjjY2zXAyn5KGTgXBzNtuVBlluqNG/vT4qUjOpla1KrUHEcPevbfLNEOl0?=
 =?us-ascii?Q?zxAOrrwyI42LeGlZ8EzjOwZ4Jb2hO+il7QtqKAHwZbvYlSHVCNNWL2PbQRNs?=
 =?us-ascii?Q?jvw468pXCacGg47sWYmerJ1LBqUF8qV+XKwFBwM5DVYMYhbbw8txkpdaAlYM?=
 =?us-ascii?Q?EYxtETHD3XNu5bAkipWPkC/r3ZuA8c4a519+nsFuKFZGhopIaIqnKguqJmaj?=
 =?us-ascii?Q?ACfy8e240K6MVQORRa/nP8AHjC0t72V8us2h8kT+mTBxITOrc7IAr5eUE1T3?=
 =?us-ascii?Q?KE70+1rRHmui3t9KrmDQ/ov7wf2CyB+lfaBGNaqcY7qtE4P91jX9tRO3/oRh?=
 =?us-ascii?Q?TuTss/+d7SKzqirioY1Xgpu+Ts4NN8z8j7ObDLe0RYeHa2mS6GzVd+Gb5mRo?=
 =?us-ascii?Q?8446nsM7ktOz/5un9xW+hBfFS3Z6vwLujfP0MK+n7/jBtwtEA6PE27WiNgrB?=
 =?us-ascii?Q?zIJlW0VpiBuZ019OXqd3/kl/lPy+zfSN6JLh7IhCHc/loAFj1P9Hd6ghXeUu?=
 =?us-ascii?Q?fVRyJlKtWG0kYYmGvgqunk9xH88+lwnICqTe94Gz5VwbgZjdxciZfo0Lu65Y?=
 =?us-ascii?Q?mVWkENx4GwTqXohwx7pz8vvGtahXd0ttsEguXiihRx7zfLCcj7a6S5W8P2eN?=
 =?us-ascii?Q?J9TamZ/nhFgNihc0nV/D4rNisaQfbTWQg2+42nvTneFIJjiHv29jxfZ7S+1g?=
 =?us-ascii?Q?eLZMzfZ+CzS/AwZlAI80ptGeBPhNuB4eSrsR1EfObR0nDj27VuoJGSpWN8gO?=
 =?us-ascii?Q?XVuWiiCFSsuQ8tEBc/3wHt3wY39/7qWGpTJYrsKqZxDrH584/DN47eB310U9?=
 =?us-ascii?Q?Rd9949oD7OvcL5Xe/gofWWyoBFR3ofMLgQc/NxNFGEcJQbhGrafe368MK8Lx?=
 =?us-ascii?Q?rRhtH7prSjyATkyJuSqwuLJf7l/v+vsVkYViVyNT+uO/GF1ARAcGxn+F4SxP?=
 =?us-ascii?Q?b8MPMxswAfjaa7qARicXiDWiHyX7YT+3K40MbmCL5+D5312BYuY8Mh4w9Re6?=
 =?us-ascii?Q?53Zqv8kLS1Ia0nJSM3WhF1hJNdWRcUmYO46B8VrDIilNPOEVn+eaEI7r5Sfl?=
 =?us-ascii?Q?KdaeaJEFNWDwGec=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 18:40:51.0698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9415d892-f051-418f-4ea9-08dd46149d75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
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

Summary:
	* Start enabling support for 4-plane MPO
	* DML21 Updates
	* SPL Updates
	* Other minor fixes

------------------------------------------------------

Aurabindo Pillai (1):
  drm/amd/display: Make dcn401_program_pipe non static

Ausef Yousof (1):
  drm/amd/display: limit coverage of optimization skip

Austin Zheng (1):
  drm/amd/display: DML21 Reintegration

Brendan Tam (1):
  drm/amd/display: add workaround flag to link to force FFE preset

Charlene Liu (1):
  drm/amd/display: pass calculated dram_speed_mts to dml2

Ilya Bakoulin (1):
  drm/amd/display: Don't try AUX transactions on disconnected link

Leo Zeng (1):
  drm/amd/display: add new IRQ enum for underflows

Samson Tam (4):
  drm/amd/display: use s1_12 filter tables in SPL
  drm/amd/display: remove TF check for LLS policy
  drm/amd/display: add s1_12 filter tables
  drm/amd/display: sspl: cleanup filter code

Taimur Hassan (1):
  drm/amd/display: 3.2.320

Zaeem Mohamed (2):
  drm/amd/display: Expose 3 secondary planes for supported ASICs
  drm/amd/display: docstring definitions MAX_SURFACES and MAX_PLANES

 drivers/gpu/drm/amd/display/dc/dc.h           |    10 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |     2 +
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |     1 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h |     5 -
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |    22 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.h |     3 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |    94 +-
 .../dml21/src/dml2_core/dml2_core_shared.c    | 12413 ----------------
 .../src/dml2_core/dml2_core_shared_types.h    |     9 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     |     3 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |     6 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h |     2 -
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |     2 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |     5 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |     1 -
 .../dc/dml2/dml21/src/dml2_top/dml_top.c      |   354 -
 .../dc/dml2/dml21/src/inc/dml2_debug.c        |     5 -
 .../dc/dml2/dml21/src/inc/dml2_debug.h        |     6 +-
 .../src/inc/dml2_internal_shared_types.h      |     6 -
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |     1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |     2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |     4 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |     1 +
 .../display/dc/link/protocols/link_dp_phy.c   |     8 +-
 .../dc/link/protocols/link_dp_training.c      |     2 +
 .../dc/resource/dcn21/dcn21_resource.c        |     6 +-
 .../dc/resource/dcn35/dcn35_resource.c        |     7 +-
 .../dc/resource/dcn351/dcn351_resource.c      |     7 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    12 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |    31 +-
 .../display/dc/sspl/dc_spl_isharp_filters.c   |   452 +-
 .../display/dc/sspl/dc_spl_isharp_filters.h   |    18 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.c |  1058 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.h |     9 +-
 .../amd/display/dc/sspl/dc_spl_scl_filters.c  |   232 +-
 .../amd/display/dc/sspl/dc_spl_scl_filters.h  |    11 +-
 36 files changed, 1231 insertions(+), 13579 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c

-- 
2.48.1

