Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6BFD35660
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 01:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB0C10E5E2;
	Wed, 28 Jan 2026 01:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k40BMIfA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011065.outbound.protection.outlook.com
 [40.93.194.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9755510E5E2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 01:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1DRm+zi5jeQLRccjtnNRrPEkyvHlWAekJGj8SEKJPBHoL2jLL3dcUZCT6chTTEB4655h4eo7U42gBn2QoXGEt/iwmDBZT97aLQqw86liToSOLLKlk0i6GdKh1YxtFUa8sYkL2w/DsOwXUW0keJAHAx+CUPw/Fkz1jOEZrbvT6AOIIfZoscrZ3J9WrhUW7WSFaPV0iDk4818dEPOkxFHdt68Nhpz6m7bpud8z0pCZcW497tsxwAs/dVPkn6LmRYSYZ+Wgdhzdpy4rBbF7u16dbmUJxOGFNQnofEXHA2E8zhW9XwkSzm1gVNZc4Txtf7ouctg2/HcJ2NzZMo7cyfouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vh0COXFQzcjJWkOXCMSzZY9GvgmOJ72uTYQ79qDxUs=;
 b=Tc5Rfk6CdBGV4SaNT/IuK8HCTjHj8i/ARnfXb41axc/MCk8zz3ctqAL+z46fjUmtIVF3+6wRUEh5ktMZt88F1tqzjcdOe0A2FNf3JQUGObQkziwnpv3h4w08PdxSFqkVEjhH2buc2uwX07QyMwRU9eey0rFqJ0KmQrV3GOz6dg2luumQiidMnUwMWCIhnQlkZIzHP7qnEJRZqJSdyHGZKUTqLLf/oUT1zCQtLRmf5aczeawDQQN9uK3Zs1bFDZ9kYQd0VGCae0qYvCekUqoFZ2ds1L/BQPohmZA+upMlgbVdJWeKwclBKKYMt4M9FXCq6KqAgQz+EaRW+JZ4+EkLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vh0COXFQzcjJWkOXCMSzZY9GvgmOJ72uTYQ79qDxUs=;
 b=k40BMIfASZBBsX5bA0WqXNfs6nDkB9Bs13aPhrj8X8oQLLbJ1QaPzrDO+Te5Qk7RQkgE0RYMqxBZ+w8Qt5e+bZsUsbPfFgzyeJhqOzSAWjUkO1VlnYAdmZt7wfaTBTO2/4ruYyDZGSV48B2EHpg2rkdjvoYhepzw+R3b+EOcjNI=
Received: from SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 01:59:12 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::51) by SJ0PR03CA0065.outlook.office365.com
 (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 01:59:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 01:59:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 19:59:11 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 17:59:10 -0800
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 19:59:02 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 00/21] DC Patches February 02, 2026
Date: Wed, 28 Jan 2026 09:51:25 +0800
Message-ID: <20260128015538.568712-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 1343ef3f-8e7e-4623-b852-08de5e10d4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2D/lJQVz3D6yYi+iGpO3vMezflomAVm2FoFrUNZcWkHGXv8P03K6nMzesQQW?=
 =?us-ascii?Q?/6JsBMeQB83F0KCcaWBxkTSpZpz88tixk6TeurjNnHE1Ya24dOJiBZyk2+jy?=
 =?us-ascii?Q?lrR9bCIowkozYBPza5G02cofFYhFn701avlYDZ0BTvTA/Wvud0mbGKEsXWjt?=
 =?us-ascii?Q?cMYC8aG/6qEoEoGiG6+XC9kvjD/rWBDYoB9GRpPKDtk5rCNQkYUueztAq9tm?=
 =?us-ascii?Q?dZxcEPiyMUwo8CthiIH0kQvl9L0nWJDqDOsoe9xesh5ARpR6L+/kTkrlUr/1?=
 =?us-ascii?Q?8AsciFHnBai2bvJ9NS3tjoba7YOPt8j0f9M3r8lWAp2du01Fvphar1ZqGTUC?=
 =?us-ascii?Q?rd8PX9TGyMPvMqWvHlNRnZFFpIaOeBPgJFjsHjld9lbwlLFNygSyExAftpsP?=
 =?us-ascii?Q?O5auhPoAGqnM2pxjfFWjHv2w/V4pK45zS4rj8F5rxKqQZmWiED/i/v0szvbx?=
 =?us-ascii?Q?wgSqbvhCjYHqF8ShSaXBZ0WRm+L8pMmsWqepLbhOwX7HgjCMn1uxq9skuWdB?=
 =?us-ascii?Q?udyXD0N25oQXXCXb5ZNVgiTyS1A6HtMpIIjG1uAfzUKl9akjylJZMgBV01c6?=
 =?us-ascii?Q?JZKoGO/Bp51aTguVWF4WCPZhZfrGSBNB8QtSHQG4EXGTEjFTTPRmC7LawVW0?=
 =?us-ascii?Q?3A/252EinZTkZUXi/5XplzjLqsIzTZ4c8frLuyzgaWnkHVsRV6UcFkQW+ltB?=
 =?us-ascii?Q?8dggXhcvYqxjJvZ/u3uAWlSmLOpvNh2eqQcRXyHpWkJkY8J/E/yfzckAx8g3?=
 =?us-ascii?Q?GEgSUe4JwxMuKey6COZfJjWv8JacogYzDJ4kGHKftrBcaL3I52PPoM936kGo?=
 =?us-ascii?Q?np+msK4rPFcjlOUB5VNyqmQ43xn/YhuX8oHXXhINgKxNTcMzkk1TMJe3hHoE?=
 =?us-ascii?Q?+F+T85r8pUdla1eMPC9Sr1kcEN9nUtHgAoGQknXI8nJX7q7qhOK11FctJ7IG?=
 =?us-ascii?Q?x4L7tV63YLHv4+UWexJMWzModBPuy37nGrD4LjS0yrIIz6BVTX2UGam07lH/?=
 =?us-ascii?Q?c1E/LT6D/Pqc6bK7iIAHz/RRKOToqTt53f+JQdznFlCekfERXkZ3Zd6nxZT7?=
 =?us-ascii?Q?XHtHP/Y7paUGpj0QAbDliOhVa+XO8bCN0zz/7oz84QQGzCq2NJxj9f3T1hYv?=
 =?us-ascii?Q?/qMXQCUPeQhX2q0pwRIUcGKCxC0EY11g89D6B6RzGKVktnln/v8AfylwIGLB?=
 =?us-ascii?Q?NjKyn3lZn5tYa8+al6Ihq7ZPQ+QT7g+OlCodBcsgzCJHak/SWlhh0VoLPi3i?=
 =?us-ascii?Q?QSB7m7V+a+Ryj3ILnC8wBizFPZzXwRDQGcjYPuyO5w4+Ro6xysVFbP2QKY2C?=
 =?us-ascii?Q?gXEwAl4Ogios4Y1xxqX/fWmlc2aNKvMYGhztvh/94fcf8k8QfjlX3RQ9WXX9?=
 =?us-ascii?Q?mDuju46ms2pCuO2+YGorEKfkVFSo/VGc42GxqBUgyRQdihMzDQP4yHdEZWMA?=
 =?us-ascii?Q?5WdSro5Iqlj8QPsc0yty6nGPW0uKwXRguOwbACN2DONUDPeYRsoJYvu1AI7m?=
 =?us-ascii?Q?ISqg+yhfhUzvtQhu2cH6bawcpQAEuP2WHfXAdxFHCh5qz6uIOsMNQwkSZt5/?=
 =?us-ascii?Q?LlyI/5PClhqghwKT0tGx3yhda/4M2NeofFB6fL54lX96O2aYQragQ3EGCmhw?=
 =?us-ascii?Q?b56RTcKUXeXLM95SRErTe5B6u2x2uldRHg92mW/wvTs6JP2btbaF7ftlpdMd?=
 =?us-ascii?Q?v91+cw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 01:59:11.6678 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1343ef3f-8e7e-4623-b852-08de5e10d4ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820
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

This DC patchset brings improvements in multiple areas. In summary, we have:
- Migrate DCCG register access from hwseq to dccg component
- Add lpddr5 handling to dml2.1
- Correct external panel replay fsm control
- Make DCN35 OTG disable w/a reusable
- Make DSC FGCG a DSC block level function
- Make some DCN35 DCCG symbols reusable
- Fix writeback on DCN 3.2+
- Fix IGT link training failure on Replay panel
- Fix system resume lag issue
- Add oem panel config for new features
- Fix IGT ILR link training failure on Replay panel
- Fix a NULL pointer dereference in dcn20_hwseq.c
- Add Gfx Base Case For Linear Tiling Handling
- Migrate DIO registers access from hwseq to dio component
- Match expected data types
- Add CRC 32-bit mode support for DCN3.6+
- Init DMUB DPIA Only for APU
- DIO memory leak fix
- Add Handling for gfxversion DcGfxBase

---

Alex Hung (1):
  drm/amd/display: Fix writeback on DCN 3.2+

Bhuvanachandra Pinninti (3):
  drm/amd/display: Migrate DCCG register access from hwseq to dccg
    component.
  drm/amd/display: Migrate DIO registers access from hwseq to dio
    component.
  drm/amd/display: DIO memory leak fix.

Chenyu Chen (1):
  drm/amd/display: Add CRC 32-bit mode support for DCN3.6+

Dmytro Laktyushkin (1):
  drm/amd/display: Add lpddr5 handling to dml2.1

Fangzhi Zuo (1):
  drm/amd/display: Init DMUB DPIA Only for APU

Ian Chen (1):
  drm/amd/display: Add oem panel config for new features

Nicholas Carbones (2):
  drm/amd/display: Add Gfx Base Case For Linear Tiling Handling
  drm/amd/display: Add Handling for gfxversion DcGfxBase

Nicholas Kazlauskas (3):
  drm/amd/display: Make DCN35 OTG disable w/a reusable
  drm/amd/display: Make DSC FGCG a DSC block level function
  drm/amd/display: Make some DCN35 DCCG symbols non-static

Peichen Huang (1):
  drm/amd/display: External panel replay fsm control

Ray Wu (2):
  drm/amd/display: Fix IGT link training failure on Replay panel
  drm/amd/display: Fix IGT ILR link training failure on Replay panel

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.45.0
  drm/amd/display: Promote DC to 3.2.368

Tom Chung (1):
  drm/amd/display: Fix system resume lag issue

Wenjing Liu (1):
  drm/amd/display: Fix a NULL pointer dereference in dcn20_hwseq.c

Zheng Austin (1):
  drm/amd/display: Match expected data types

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 ++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 15 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 70 +++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  1 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.h  |  6 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 24 ++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  7 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 15 ++-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 27 +++++-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    | 54 ++++++++++-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    | 18 +++-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 30 ++----
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    | 17 ++++
 .../drm/amd/display/dc/dce/dce_mem_input.c    |  3 +
 .../display/dc/dce110/dce110_mem_input_v.c    |  3 +
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |  2 +-
 .../drm/amd/display/dc/dio/dcn10/dcn10_dio.c  | 47 +++++++++
 .../drm/amd/display/dc/dio/dcn10/dcn10_dio.h  | 42 ++++++++
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |  1 +
 .../dml2_0/dml21/dml21_translation_helper.c   |  3 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |  3 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 26 ++++-
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 59 ++++++++----
 .../src/inc/dml2_internal_shared_types.h      |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |  1 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  2 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  2 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  9 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 30 ++----
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c | 10 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |  9 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  9 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   | 15 ++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  9 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 13 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dio.h   | 22 +++++
 .../amd/display/dc/inc/hw/timing_generator.h  |  7 ++
 .../dc/link/protocols/link_dp_panel_replay.c  | 52 ++++++++++
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 19 +++-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 96 ++++++++++++++++++-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    | 10 ++
 .../resource/dcn32/dcn32_resource_helpers.c   |  3 +-
 .../dc/resource/dcn36/dcn36_resource.c        | 12 ++-
 .../dc/resource/dcn401/dcn401_resource.c      | 46 +++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 10 ++
 55 files changed, 788 insertions(+), 153 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn10/dcn10_dio.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/dio.h

-- 
2.43.0

