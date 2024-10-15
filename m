Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28290CFC274
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE0710E536;
	Tue, 15 Oct 2024 08:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q2j0H9H+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6608310E536
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 08:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1xpYmovSRxXBRuxz5rwYhyImVulBkzkvfHuy4+1XZSZip+bvfrNSy/IO5ZnnHgWDcCOXPJZQof2yIRRW2hbrRV7m7C1GQSpVs8R+EFZ35OcgPgt9gS3gLYst5hzlfYeT9z07Bkd2vfyk7faiY6Op7SbFfGLU1CCzuPLNur+VSKR6At7i4IGlALxADpp7G7Pd1s6cvcRlXe/DVHYxSUW3ku1aDOx6UURn3+eYrPC5offgEJrf1zwKs2RvfJyzJIzkdqartDffBRnL1E9leWgIJCSXJBRpWiYfZrcIT3/4L5272NS9SEe4c3kmUns0w/TcbkYuAgY+BQphjkjSzP8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj3nZT9ONWzg14Y/MlSz/c8FfPg0TL0fxwA3tnEb/6o=;
 b=ddNtURusPR7xnujoCmuCgQ2lhCVRFVVmkr3XDgq/X6qd7mnKOeVtEY+0AwlZtH/20fZlhK71NwZlYLmqK8AskaLUpoBzbPgAle3emDS1x8Qy1z6pYyA1f4WMYJFS9RSDEmvj5syFVp92Ejbcvja51eEQHJwt7C1sKgn1YLs88Qt4ozobDuEolqsTnSiNiRpB3vJgcTHG0hfDDFnhgVjINV2B4c9NFLNbQX7N7w6zJ16oJs+tfGP97mCyNnEmPNeXmwOe1MwNEjaWmEPMb0aB1BC3Gz7LXMes72xTOwjG1/cmEkaB0EwSo07K9NFnNoaXkdIm0w0hFexwxq1D6EXBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj3nZT9ONWzg14Y/MlSz/c8FfPg0TL0fxwA3tnEb/6o=;
 b=Q2j0H9H+urhTcXzBf3uaC4b/TN0GwJWXdMj7atQoD/XLsl7XUvjLoy6pH54x0Sv/a/UKg0eOnw60dbdyNGKDpNJCcuKmGRxubR3LqWbjkt1eC6A5f0HvTFMJ50Y9713hJhYN5VlOGnQk3luWTaBPclhSsjx6Qc+FJkyaBus93kI=
Received: from PH8PR05CA0019.namprd05.prod.outlook.com (2603:10b6:510:2cc::25)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20; Tue, 15 Oct
 2024 08:17:36 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::52) by PH8PR05CA0019.outlook.office365.com
 (2603:10b6:510:2cc::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Tue, 15 Oct 2024 08:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:17:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:17:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:17:35 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:17:25 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 00/10] DC Patches October 14, 2024
Date: Tue, 15 Oct 2024 16:17:03 +0800
Message-ID: <20241015081713.3042665-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 66dac639-00e1-493e-977f-08dcecf1d3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yBZ18CDwL98I602Yr+fQuvHS0Ar2fe7tkOUS4RV3TtTnNNsjnEvHOiuKBWAQ?=
 =?us-ascii?Q?N3y6xP8Z3zHF6XtUa6L4OeGGjmVVto+ZxFHMEhbvOmCJpIosv6SvopvkjjBq?=
 =?us-ascii?Q?hiW2nOuITNMPoiN/cfFQVO44qfSqyqP14YFAzYGkCgFInC2m2n3SxboJoa8b?=
 =?us-ascii?Q?dpyQs0qYfM5AvuMeCVAtgqvGeKVt5DPVfdZ09sGGMaaOPzg8xUthvE5xFUTq?=
 =?us-ascii?Q?xwDWQS31npvuCAFG74Kf501P2og0Xe3px8vN5nOQ4zzgSZ/1py5gYGT6ulAN?=
 =?us-ascii?Q?BUIUYAaIQ+n4g8Kc8k0nHmHl67upyey+6UjnT8wUZvojpCopYVMkLO9M/abv?=
 =?us-ascii?Q?fD5+2/ztSeAtFSazHxBLd54RR6sZd6MmBUQoti1PrmmIMAweADO74pGTxZrs?=
 =?us-ascii?Q?5zgXGKJJXRlj+9IilsJaGY9XyDjwRFH84ZgOphvqTOEXJ/toQHL+vHdRmvqv?=
 =?us-ascii?Q?3FmSsQDFRSFoYWS304C976KIx1YPg/cBSfS8DtZSJQEZOkzIrpyGLjAO7GOk?=
 =?us-ascii?Q?WtVixdhOiNysegYwkTJszFSdVDEZNTSnomfTgf+1EJxqUh3EucjeisdnWULY?=
 =?us-ascii?Q?X2hVRfl4x8pNxpBc08IO7poBhuwoMUKer2PbvrH7PDUf9Ior6UJezFP+SW6z?=
 =?us-ascii?Q?cdGVvqW2UEAVFXKPuYEc7GB6Ke2QNKYM45iTdf5Y2kpRtBWbeaYDCg1GIuBo?=
 =?us-ascii?Q?qQRTAew34L7lCn8PZV6Tcw/HYUIf2QKyLZUB+mHFqlt8a6Jc9Qq3QWOZjwGQ?=
 =?us-ascii?Q?rY+pPiT3Yxm/Q2pwtBqzZKr9IxzMrmV4WSasC9ELtamiPPOD85zbbXYrOj8m?=
 =?us-ascii?Q?hp8ZpB6eBTTrIRSWHjJzFEkIrmz08l1rHKlDrPUy6ddH+M47nOPmM52dAlA7?=
 =?us-ascii?Q?nv3zlL08ZO2HPS9Lft7zneY96H3XOcAE9w5vEkw/MrPokPl+SM8DvLpUh2hU?=
 =?us-ascii?Q?a33A824pg/FixwYp936La2qaPyp8b6HwIKu2G2MEOey8h9nFFOpbdLdOIh4M?=
 =?us-ascii?Q?HTlsoLlqJd5+iC529JtSNb/KU/38o88+8goRja1mdhTCRflOAFN1CXTp/ome?=
 =?us-ascii?Q?VcMPb7wmKfnQ8130E6ysvmBj+y/WtKtypPZsqgAkk8oFVZeZ+T1fX0nkKJvI?=
 =?us-ascii?Q?d/FMoHLOTc6FPGHjKpFqxVF2IVn9QZMxJlPh/OPmdiJQUGZi0g+a0k3aiKHE?=
 =?us-ascii?Q?TK45tk6KjXuBnWFL0mnupYg4UdPZmSRdmHlpu9sj4dcKqkQlQgbxqcOJ8Aqa?=
 =?us-ascii?Q?dO1K17k5+Dj6FjDUkTXVed2wKnfiS7YWSa8u4q2VoRkRFF7dWWCMOekc10gR?=
 =?us-ascii?Q?gs35IMyQePjShWnCJJykOLSNiY0YOZgfDO4w4QhwB5VQhUmH9nzgTvQX7jPN?=
 =?us-ascii?Q?XLLgcD7veVQcJymN89/WbRBXTnCU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:17:36.2002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66dac639-00e1-493e-977f-08dcecf1d3c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224
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
- Fix dcn401 idle optimization problem
- Fix cursor corruption on dcn35
- Fix DP LL compliance failures
- Fix SubVP Phantom VBlank End calculation
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Aric Cyr (1):
  drm/amd/display: 3.2.306

Aurabindo Pillai (3):
  drm/amd/display: temp w/a for dGPU to enter idle optimizations
  drm/amd/display: Reuse subvp enable check for DCN401
  drm/amd/display: temp w/a for DP Link Layer compliance

Bhuvanachandra Pinninti (1):
  drm/amd/display: To change dcn301_init.h guard.

Dillon Varone (1):
  drm/amd/display: Recalculate SubVP Phantom VBlank End in dml21

Fangzhi Zuo (1):
  drm/amd/display: Add a Precise Delay Routine

Leo Chen (1):
  drm/amd/display: Adding array index check to prevent memory corruption

Samson Tam (1):
  drm/amd/display: update fullscreen status to SPL

Yihan Zhu (1):
  drm/amd/display: w/a to program DISPCLK_R_GATE_DISABLE DCN35

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 13 +++++++++++
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  6 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 +++
 .../dc/dml2/dml21/dml21_translation_helper.c  |  1 -
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |  1 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |  1 +
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h  |  1 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  1 +
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  | 22 +++++++++++++++----
 .../amd/display/dc/hwss/dcn301/dcn301_init.h  |  4 ++--
 .../dc/link/protocols/link_dp_training.c      |  2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  3 ++-
 16 files changed, 56 insertions(+), 14 deletions(-)

-- 
2.37.3

