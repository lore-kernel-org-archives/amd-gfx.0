Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B167EC02180
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 02:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3D810E838;
	Tue, 14 Jan 2025 02:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1IjxuWfI";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C78FF10E838
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 02:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSQeoLl5Qw4OolBdtqZD5Pu0n5OoIqegZyV5vVAQp+unCurxQY5ZBh64ue4wgXw26CQrsi43dyO4kz3p9y1ocQnGHMoP5gEd9mu9XYqHqeLd2Cqyh5MpkScN8STypK/2ObF72FuqMlyo1RfUAsrmvbcls3L1r7V4M24mFlPZEKA6/hRx9MzJpuxgAV+gU9KyyYtwi+J6V7h1lahRH+tekVkMLJKBDeQJbt5H1mH+G6ffd3hXWKV2YC2q8SbKLpMUrUuleE+uj1jfuEVD1Dt9mg7XYH+r8MvYh6yExzrhXQf2Z1v9cvzm3SRI+cn7I8oZW1BFlJ47hwq9Wkz9IxbCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI2K9KlifyxeWlntqKofvYCuC4EwbVVQRrHVYcvXj9o=;
 b=XzGwQbwrbLjIoSp3Xd7kVrjZYeqycatLcIT/LEPlvgKNZYUp1QJ+hWDhaHTcmKPAzSBsaj/UOevFWCFEvjhWtVdR8wt+k/zuvkG6gN3cKYwBMd+MMkPrdDu6HPsDv5PAX4Uz5ptRw8u9YwpnT6pGwQhAuCZXdSVV4Uu0AFlJuVI2CZDcrqUaRAPc8ZhrzljW0ZuQadk3feRyZQ6ufv+bOgYxg2ewJmi0ZF9FK6DLFxI6ouJnL/0NqPRKrUZonyYcShFhgNE8zqCWxKqhOHBRG08N+kEv918aVxNRHmuW9imE/KTb80raB2cgY+yr+iWcu8AmwaTHS5rGMWd2VG5T5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI2K9KlifyxeWlntqKofvYCuC4EwbVVQRrHVYcvXj9o=;
 b=1IjxuWfI5mtZB8UX2iRskJK6WBaJf10vOnMKUMPwDFnMn+NkVi5U38XVc/+blWM1ml96k1L9NXDZO8YMMR1WiPpjq9eT5Wu3IhQ6w5Xqhyhg6rHjOh+iPwadrHYRRsag6Ws+171lVvLmJR/+w9PhwjBeTTKkd8LQnN43RvCdVBI=
Received: from BL0PR01CA0026.prod.exchangelabs.com (2603:10b6:208:71::39) by
 DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.18; Tue, 14 Jan 2025 02:09:26 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::ec) by BL0PR01CA0026.outlook.office365.com
 (2603:10b6:208:71::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 02:09:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 02:09:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:09:23 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 13 Jan
 2025 20:09:12 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 13 Jan 2025 20:09:02 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 00/11] DC Patches Jan  20 2025
Date: Tue, 14 Jan 2025 10:08:49 +0800
Message-ID: <20250114020900.3804152-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf216d3-a2a3-4ceb-bb4c-08dd3440787c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SbJgPIBOEPDgNnA8Fcr+t8ZfbixabsJLgcQ38OdXARTC55kgarq+xy3JLymZ?=
 =?us-ascii?Q?WEGwDH3ODU+L3BXr7sxwfjoDW/UNr53twxZpBfQezNVTCi4NmfrC1FzOqipz?=
 =?us-ascii?Q?GyXXAT3c+QDuXxA2m4o8dwHVADzkQIJ/vsxJq3r16oKZVCA09VC4Yq9PIa5L?=
 =?us-ascii?Q?qu5IC9UUJDDgExNglPuUAGYWtRxSxYGmdq6KEBphjF8HcYYXus+awTnwlpcX?=
 =?us-ascii?Q?nXvKSy+jrDuScsmuuq4EfqHZ0GwH4GFlM2DIyXp9hm/Gbw43o0nNz88leDXe?=
 =?us-ascii?Q?A2ZGhALk6xtF/nZRZL7rEOzqvo40DcodgjxLTFmkoZCrE7C+pf3nvUjujSgo?=
 =?us-ascii?Q?oOBZCi0zUYd5EJCBW3+96Y9ePHcKs+6Kmgjpg7S63Tt5rK4HXEdKwGva+/44?=
 =?us-ascii?Q?rwfuwo9mMp5TcjhCSEXpxUCgs75pbtZhqU9Gs7aU2Xsehyx4s+c+zGl6Uwh7?=
 =?us-ascii?Q?SeOYSnyAkd3ujzS6ova6L+RclZ1thh7jIB5eQknTW5Ook9WLQ67fNSKk8jJy?=
 =?us-ascii?Q?SMqHMzffTjZazrXD/SNRtnmCeZhkWxac/V3bZuWGZiTgiQrGQjMDRrelx0hN?=
 =?us-ascii?Q?yjxh+RwPkJcJC2Lcx8Xrb69ozExJNcwS/pH1mA7Az55Ohn+PsYdYX7OL0Rmu?=
 =?us-ascii?Q?J1t4a/KmDPaQPqHI/ajKsgMs2t2i0OkndB2EiGSc52pWxuJnV3V8yexjFW39?=
 =?us-ascii?Q?TRWx9o1dFt3qqaReq322RAAMhLboOpMQWjNviu2kGnvI2XtNbUOVoMyUVpHZ?=
 =?us-ascii?Q?RlHkpgpPUhY2na69ENFncbKEe5Mj/BsH9fFwCbePy1q8g933WiRoqay55/5J?=
 =?us-ascii?Q?O+P8r/DI4oLTIeKOU+I2mN17TMQJNiU6cYemBtyMmlLvV25hWyPGPlMEfR2J?=
 =?us-ascii?Q?KnAUCqeQGPsmFXiglXmeNyb1cif8Ng0OswP+RcXXnPU/kAN51Jm399tcs5XJ?=
 =?us-ascii?Q?ubndm6NxsJ2YNggTgfEiU7OZqVfS78vpcLyzWZlX+SjzdmiDXm032GKacjnD?=
 =?us-ascii?Q?W28XUe7IMgkT6WfqPG93+kH3fKpuhTUSPbxb6mFP6C13SGFwlRfS3/6Xi9O0?=
 =?us-ascii?Q?Q0jWyj0DQ9ZLOHlcF+tPGqPdGBQU0RjT41F5GxlJzmHI2JLCZvn6mcLmOsiO?=
 =?us-ascii?Q?oFsSg1Nupo1xgKstyIpnzYrgu19wAJQAWsDwoYJ0RaJYqqi4cHLU58jEEwDd?=
 =?us-ascii?Q?3pRm4/lyU0SGgUaowX9aR8q/0qK73Or+jRN3134OkrWmf5Ssd80LFbXJv1Jx?=
 =?us-ascii?Q?KnoQdaHOkSqhSXRxL0WBz7MMycTLysDvZmx+XjI7gJ8RTLJboFbxiHLYXw9B?=
 =?us-ascii?Q?ANEttbIOEIsI5PNLPGma7jYyOiSL6tPFs/8eJswOH7S6/L2ktK9m1+s6d3ia?=
 =?us-ascii?Q?79zmcvX81CRq/I8BSqdrksTLcm31UpJUPwZrTykL4l1FADWoxzd15KGNTboD?=
 =?us-ascii?Q?QfC0xUwrPjYkUGPpLoccOhrL1mI9bI+ZuX70we7PDLCwoNNZ2htd4srMZ6X2?=
 =?us-ascii?Q?m74s//GpenI8z+0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 02:09:25.9688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf216d3-a2a3-4ceb-bb4c-08dd3440787c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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

- Reverse the visual confirm recouts
- Exclude clkoffset and ips setting for dcn351 specific
- Fix cursor programming problems
- Increase block_sequence array size
- Use Nominal vBlank to determine vstartup if Provided
- Fix clock frequencies incorrect problems for dcn401
- Add SDP programming for UHBR link as well
- Support "Broadcast RGB" drm property

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Aric Cyr (3):
  drm/amd/display: Optimize cursor position updates
  drm/amd/display: Add hubp cache reset when powergating
  drm/amd/display: 3.2.317

Austin Zheng (1):
  drm/amd/display: Use Nominal vBlank If Provided Instead Of Capping It

Charlene Liu (1):
  drm/amd/display: Exclude clkoffset and ips setting for dcn351 specific

Dillon Varone (1):
  drm/amd/display: Populate register address for dentist for dcn401

Ian Chen (1):
  drm/amd/display: Add AS SDP programming for UHBR link rate.

Joshua Aberback (1):
  drm/amd/display: Increase block_sequence array size

Josip Pavic (1):
  drm/amd/display: log destination of vertical interrupt

Peterson Guo (1):
  drm/amd/display: Reverse the visual confirm recouts

Yan Li (1):
  drm/amd/display: Support "Broadcast RGB" drm property

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 67 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 50 +------------
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  7 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  5 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  | 10 ++-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  6 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 10 ++-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  9 ++-
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |  1 +
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |  3 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  3 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |  1 +
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  1 +
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 13 ++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 53 ++------------
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  5 ++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 48 +------------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  | 30 +-------
 .../amd/display/dc/inc/hw/timing_generator.h  | 30 ++++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  7 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  2 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |  1 +
 .../amd/display/dc/optc/dcn201/dcn201_optc.c  |  1 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |  1 +
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |  1 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    | 71 +++++++++++++++++++
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  7 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |  1 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |  4 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  3 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |  3 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |  3 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 .../dc/resource/dcn35/dcn35_resource.h        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  3 +-
 50 files changed, 308 insertions(+), 208 deletions(-)

-- 
2.37.3

