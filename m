Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA796C27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C91310E6CB;
	Tue, 11 Jun 2024 16:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2pylUR97";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87EA110E1BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKYB3hgVnjVPa94C8Efxf3CiUHk3+EzAxb2jsGK2O5diw9lG5pb1sW+XEEG2aQc5LR8SVjWAsS/RDipUWH/Z/hxt4kg4T9KZUMxPo0CIyglWeG3s1DIIt+wS4Vq+JEzXO/yyKPG4P1HJL2D4GUZUhMPuzPAPPByJIUuK5dReTSmg/NUtsr8BIXAzxH0kMNPK7w67gRzykfPSiKbZ7Kk0nPce2Zns8SF9HfUd2T3g4x6zh/vMX0lftm6+OqpBisvV2rkwl+wpYCX6dkrBvz63BkocIqgXGVNu0siHSIr3h6hu9gPScyL2RNUmpYffaJR0XW6UykjN5LHo8OB2ddBFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xADD6aftpBHB407SmK+lH9WBjoyndO8HeqaC1/24JRs=;
 b=f6vDajvTaXeRduza8XixTkzlrbzRuiMvsWwkO43gAkk290jJ61KmIOipMInzj4nkN9etklv7dKJlz4oTXRXOcQgOXLz6MAa6znudzfko9mh3F0/RRJzDopv13YFOLSADfQ9R8zjWl9ZcOzVH2cYRhPmRoYNSaDFpJ7icHPNHDuMhE3cqg9dyjv7WCBHxY4LEBlv4OamxUcdjTZXtw2cuQdwnzy+H9mNqZO1KBSFiJWQUVlVO4WgadKHQ9m4hBQe1jjr2B12cuznQQbYYYGx/Fu3Sm+Kdx4wM3/BVcbOZqAaCHsNT+9WCMZ6a8kFcbnyHMh3zaBwZrV8LNbhTVwmZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xADD6aftpBHB407SmK+lH9WBjoyndO8HeqaC1/24JRs=;
 b=2pylUR97oDvilu3GnTWrIQRHGY3iKXu95YSS7DV7sh7soEHadjM2Bf8nxRtLHW6VTxxe6/I1Ezmah1XV94q7OAZlHFLNqUCnRRevaGOHvHgLEcM2/r5ZYt5BAb7PCrNUpF5z+JwUXV8MGiWwlxULWuN2hfR1myHK0WMlSNYDUBM=
Received: from BN8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:408:ac::47)
 by CH2PR12MB4055.namprd12.prod.outlook.com (2603:10b6:610:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:27 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::71) by BN8PR07CA0034.outlook.office365.com
 (2603:10b6:408:ac::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:27 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:25 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Mounika Adhuri <moadhuri@amd.com>, Martin Leung
 <martin.leung@amd.com>
Subject: [PATCH 09/36] drm/amd/display: Refactor DCN3X into component folder
Date: Tue, 11 Jun 2024 12:51:12 -0400
Message-ID: <20240611165204.195093-10-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CH2PR12MB4055:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1b2176-8da3-431d-7f69-08dc8a36e034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9brRYEIIMJohS6yhNRB5cX5ydfGMXKzBmgxI0/gQgrBNYlx6+ixQx1581g8x?=
 =?us-ascii?Q?5cdZmsvTZ1bOMg5XUEyOFuAfiBQLJaauS701BHzFStnxFUrISMRAbpP2LUAk?=
 =?us-ascii?Q?WFi+3LSpi7/PFbIBQ/WbF2Ju4g5qO4OimRU6w+BYVqFsILafHveCuZj/HRli?=
 =?us-ascii?Q?LM8NUTdEFnVI5jSWkX5z6Bp1u4B0Y2eVoNjk0TClIC8kJFIWdUbCoN9iTqAz?=
 =?us-ascii?Q?51oVh6cAYm+dA2nLA8fYalfDutVyd6FX3L0AqZuvpRP3RV3Oy71BrxQA8/wj?=
 =?us-ascii?Q?cg/o42xIg8FNRvjiSueOB5qledIgoVeP8IUIsn2/m4OX6w4EaRZSCIVkVUbC?=
 =?us-ascii?Q?ts/rEvi10KF+TGs5JEc+jqNlpJXyXDJ+kKfvcdT9KeRyQm1kUAdKQqVOxhUo?=
 =?us-ascii?Q?zqfY8gVrsRQCnw8ZK0mVv58Fhle9cvCtss8fLchZFHeXOD19wsnhQOhk9RnZ?=
 =?us-ascii?Q?damk6RaBnYjUtJhFAY1Rou8Eheb6I7Ov5fgyoHSVs0Efzy+k2y3zH5B8t/GR?=
 =?us-ascii?Q?Sc7wF2m8O/VdJkAN0G7dQTjPssweTy7SXO/LiT1J/EpInEN+uy9izLy9OhrD?=
 =?us-ascii?Q?xP/lq+MgECRzKJGl3ZugJ3Y4HsDDBAeVmv4rFYj9Pc7EO8AEBbTo9Vf2UrDQ?=
 =?us-ascii?Q?mylKDifsGMrnvNdvvmfhvrBWXCGjYQilPKz/9YMPU16HM2+Frv17Mm2a+k2H?=
 =?us-ascii?Q?q3bPHIsIlJBu1DtEjwqOPJq7QPDL6mr8Uzu3jplwt1TJ+z6OMM5debGrD5RO?=
 =?us-ascii?Q?tdfUK6OaY7z1VT/dvLFACafkgugJxxIPi5sL7xJ6TWD5dnOD2y6LImasJDYm?=
 =?us-ascii?Q?1PKWumEOuJehLBuYEhP65c5VQh22ii3Pnf7SsSEVF1fIVRegycoJ5wo0hFLx?=
 =?us-ascii?Q?Jlvy4GlZ/RQyOg3CtaJwjGKvPuKOS8lTVuZ2xhvSJ4xoYEv80ETBIOk1wsUS?=
 =?us-ascii?Q?72uISKJDAHvbf25CIH08DM+kocBN9r0SC0Zf+HeYgDFUibUyJugacr/meWf+?=
 =?us-ascii?Q?BzJUxoUDwylA/qEQwX6QaKwN1SmCJioi0uVdKBjZsUbdxjdYJCtjh8QMGOrN?=
 =?us-ascii?Q?/tWUjq8biNnb00xS5tAOzvNUFip1gQw52ZH15aC9wyh59oZkjxfLLLDMII3p?=
 =?us-ascii?Q?hGpnwaHfx1mn7JfT2rVzT7IpGmNE36JbO80WU6Vk9MvuPWdZb2sB8hzKaZy1?=
 =?us-ascii?Q?BrNP5ok6PiHjIqLTkABpQUW8AhM2pSET9zJxJijFxb/vLQMjfSsyKwn8le2g?=
 =?us-ascii?Q?pgOnzKdv694rhBmuHZEWxLCAJ2dEZ2dTUGqoXvYGRNzeae1YiIf9ocY39Kvd?=
 =?us-ascii?Q?XDV2L7ghR0i8TabWk0+lt4yKCF1CGkFQMLSJoONN10LHrCLrtRWf9zUH18wU?=
 =?us-ascii?Q?QoAkkTSODWzflYqtSKpO2kwnOAjS8c9jlxoC50iHE8d8yLgv/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:27.2140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1b2176-8da3-431d-7f69-08dc8a36e034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4055
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

From: Mounika Adhuri <moadhuri@amd.com>

[why]
Move DCN3X files to unique component folder.

[how]
Create respective component folder in dc, move the DCN3X files into
corresponding new folders and made appropriate changes for compilation
in Makefiles.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Mounika Adhuri <moadhuri@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |  7 +++
 drivers/gpu/drm/amd/display/dc/Makefile       |  6 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile | 19 ------
 .../gpu/drm/amd/display/dc/dcn321/Makefile    | 17 -----
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile | 19 ------
 drivers/gpu/drm/amd/display/dc/dio/Makefile   | 63 +++++++++++++++++++
 .../{ => dio}/dcn32/dcn32_dio_link_encoder.c  |  0
 .../{ => dio}/dcn32/dcn32_dio_link_encoder.h  |  0
 .../dcn32/dcn32_dio_stream_encoder.c          |  0
 .../dcn32/dcn32_dio_stream_encoder.h          |  0
 .../dcn321/dcn321_dio_link_encoder.c          |  0
 .../dcn321/dcn321_dio_link_encoder.h          |  0
 .../{ => dio}/dcn35/dcn35_dio_link_encoder.c  |  0
 .../{ => dio}/dcn35/dcn35_dio_link_encoder.h  |  0
 .../dcn35/dcn35_dio_stream_encoder.c          |  0
 .../dcn35/dcn35_dio_stream_encoder.h          |  0
 .../dcn401/dcn401_dio_link_encoder.c          |  0
 .../dcn401/dcn401_dio_link_encoder.h          |  0
 .../dcn401/dcn401_dio_stream_encoder.c        |  0
 .../dcn401/dcn401_dio_stream_encoder.h        |  0
 drivers/gpu/drm/amd/display/dc/dwb/Makefile   | 37 +++++++++++
 .../display/dc/{ => dwb}/dcn35/dcn35_dwb.c    |  0
 .../display/dc/{ => dwb}/dcn35/dcn35_dwb.h    |  0
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   | 35 +++++++++++
 .../dcn32/dcn32_hpo_dp_link_encoder.c         |  0
 .../dcn32/dcn32_hpo_dp_link_encoder.h         |  0
 .../gpu/drm/amd/display/dc/mmhubbub/Makefile  | 45 +++++++++++++
 .../dc/{ => mmhubbub}/dcn32/dcn32_mmhubbub.c  |  0
 .../dc/{ => mmhubbub}/dcn32/dcn32_mmhubbub.h  |  0
 .../dc/{ => mmhubbub}/dcn35/dcn35_mmhubbub.c  |  0
 .../dc/{ => mmhubbub}/dcn35/dcn35_mmhubbub.h  |  0
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   | 45 +++++++++++++
 .../display/dc/{ => mpc}/dcn32/dcn32_mpc.c    |  0
 .../display/dc/{ => mpc}/dcn32/dcn32_mpc.h    |  0
 .../display/dc/{ => mpc}/dcn401/dcn401_mpc.c  |  0
 .../display/dc/{ => mpc}/dcn401/dcn401_mpc.h  |  0
 drivers/gpu/drm/amd/display/dc/opp/Makefile   | 35 +++++++++++
 .../display/dc/{ => opp}/dcn35/dcn35_opp.c    |  0
 .../display/dc/{ => opp}/dcn35/dcn35_opp.h    |  0
 drivers/gpu/drm/amd/display/dc/pg/Makefile    | 35 +++++++++++
 .../display/dc/{ => pg}/dcn35/dcn35_pg_cntl.c |  0
 .../display/dc/{ => pg}/dcn35/dcn35_pg_cntl.h |  0
 .../gpu/drm/amd/display/dc/resource/Makefile  |  2 +-
 .../dcn32/dcn32_resource_helpers.c            |  0
 44 files changed, 304 insertions(+), 61 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn32/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn321/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn32/dcn32_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn32/dcn32_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn32/dcn32_dio_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn32/dcn32_dio_stream_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn321/dcn321_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn321/dcn321_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn35/dcn35_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn35/dcn35_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn35/dcn35_dio_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn35/dcn35_dio_stream_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn401/dcn401_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn401/dcn401_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn401/dcn401_dio_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn401/dcn401_dio_stream_encoder.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dwb/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn35/dcn35_dwb.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dwb}/dcn35/dcn35_dwb.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn32/dcn32_hpo_dp_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hpo}/dcn32/dcn32_hpo_dp_link_encoder.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn32/dcn32_mmhubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn32/dcn32_mmhubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn35/dcn35_mmhubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mmhubbub}/dcn35/dcn35_mmhubbub.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn32/dcn32_mpc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn32/dcn32_mpc.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn401/dcn401_mpc.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => mpc}/dcn401/dcn401_mpc.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn35/dcn35_opp.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => opp}/dcn35/dcn35_opp.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/pg/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => pg}/dcn35/dcn35_pg_cntl.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => pg}/dcn35/dcn35_pg_cntl.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => resource}/dcn32/dcn32_resource_helpers.c (100%)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 8297fbce7749..89d605de0595 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -37,6 +37,13 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dpp
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hubbub
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dccg
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hubp
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dio
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dwb
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hpo
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/mmhubbub
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/mpc
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/opp
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/pg
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 9c2f932217e4..80069651def3 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp hubbub dccg hubp
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp hubbub dccg hubp dio dwb hpo mmhubbub mpc opp pg
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
@@ -36,10 +36,6 @@ DC_LIBS += dcn30
 DC_LIBS += dcn301
 DC_LIBS += dcn31
 DC_LIBS += dcn314
-DC_LIBS += dcn32
-DC_LIBS += dcn321
-DC_LIBS += dcn35
-DC_LIBS += dcn401
 DC_LIBS += dml
 DC_LIBS += dml2
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
deleted file mode 100644
index 2d0eb203ab69..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# (c) Copyright 2022 Advanced Micro Devices, Inc. All the rights reserved
-#
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
-#
-#  Authors: AMD
-#
-# Makefile for dcn32.
-
-DCN32 = dcn32_mmhubbub.o dcn32_mpc.o \
-		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_resource_helpers.o \
-		dcn32_hpo_dp_link_encoder.o
-
-AMD_DAL_DCN32 = $(addprefix $(AMDDALPATH)/dc/dcn32/,$(DCN32))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCN32)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
deleted file mode 100644
index c195c47f58b4..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# (c) Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
-#
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
-#
-#  Authors: AMD
-#
-# Makefile for dcn321.
-
-DCN321 = dcn321_dio_link_encoder.o
-
-AMD_DAL_DCN321 = $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCN321)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
deleted file mode 100644
index d0fab60e7cd9..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# (c) Copyright 2022 Advanced Micro Devices, Inc. All the rights reserved
-#
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
-#
-#  Authors: AMD
-#
-# Makefile for DCN35.
-
-DCN35 = dcn35_dio_stream_encoder.o \
-	dcn35_dio_link_encoder.o \
-	dcn35_mmhubbub.o dcn35_opp.o dcn35_pg_cntl.o dcn35_dwb.o
-
-AMD_DAL_DCN35 = $(addprefix $(AMDDALPATH)/dc/dcn35/,$(DCN35))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCN35)
diff --git a/drivers/gpu/drm/amd/display/dc/dio/Makefile b/drivers/gpu/drm/amd/display/dc/dio/Makefile
new file mode 100644
index 000000000000..5fa905c2fe55
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dio/Makefile
@@ -0,0 +1,63 @@
+#
+# Copyright 2020 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Authors: AMD
+#
+#
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN32
+###############################################################################
+DIO_DCN32 = dcn32_dio_link_encoder.o dcn32_dio_stream_encoder.o
+
+AMD_DAL_DIO_DCN32 = $(addprefix $(AMDDALPATH)/dc/dio/dcn32/,$(DIO_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN32)
+
+###############################################################################
+# DCN35
+###############################################################################
+DIO_DCN35 = dcn35_dio_link_encoder.o dcn35_dio_stream_encoder.o
+
+AMD_DAL_DIO_DCN35 = $(addprefix $(AMDDALPATH)/dc/dio/dcn35/,$(DIO_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN35)
+
+###############################################################################
+# DCN321
+###############################################################################
+DIO_DCN321 = dcn321_dio_link_encoder.o
+
+AMD_DAL_DIO_DCN321 = $(addprefix $(AMDDALPATH)/dc/dio/dcn321/,$(DIO_DCN321))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN321)
+
+
+###############################################################################
+# DCN401
+###############################################################################
+DIO_DCN401 = dcn401_dio_link_encoder.o dcn401_dio_stream_encoder.o
+
+AMD_DAL_DIO_DCN401 = $(addprefix $(AMDDALPATH)/dc/dio/dcn401/,$(DIO_DCN401))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN401)
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn32/dcn32_dio_stream_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn321/dcn321_dio_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dio_stream_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dwb/Makefile b/drivers/gpu/drm/amd/display/dc/dwb/Makefile
new file mode 100644
index 000000000000..16f7a454fed9
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dwb/Makefile
@@ -0,0 +1,37 @@
+#
+# Copyright 2020 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Authors: AMD
+#
+#
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN35
+###############################################################################
+DWB_DCN35 = dcn35_dwb.o
+
+AMD_DAL_DWB_DCN35 = $(addprefix $(AMDDALPATH)/dc/dwb/dcn35/,$(DWB_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DWB_DCN35)
+
+
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.c b/drivers/gpu/drm/amd/display/dc/dwb/dcn35/dcn35_dwb.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.c
rename to drivers/gpu/drm/amd/display/dc/dwb/dcn35/dcn35_dwb.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h b/drivers/gpu/drm/amd/display/dc/dwb/dcn35/dcn35_dwb.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h
rename to drivers/gpu/drm/amd/display/dc/dwb/dcn35/dcn35_dwb.h
diff --git a/drivers/gpu/drm/amd/display/dc/hpo/Makefile b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
new file mode 100644
index 000000000000..c248bd86b477
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hpo/Makefile
@@ -0,0 +1,35 @@
+#
+# Copyright 2020 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Authors: AMD
+#
+#
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN32
+###############################################################################
+HPO_DCN32 = dcn32_hpo_dp_link_encoder.o
+
+AMD_DAL_HPO_DCN32 = $(addprefix $(AMDDALPATH)/dc/hpo/dcn32/,$(HPO_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HPO_DCN32)
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hpo_dp_link_encoder.c b/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hpo_dp_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hpo_dp_link_encoder.h b/drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hpo_dp_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
new file mode 100644
index 000000000000..505bc0517e08
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/mmhubbub/Makefile
@@ -0,0 +1,45 @@
+#
+# Copyright 2020 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Authors: AMD
+#
+#
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN32
+###############################################################################
+MMHUBBUB_DCN32 = dcn32_mmhubbub.o
+
+AMD_DAL_MMHUBBUB_DCN32 = $(addprefix $(AMDDALPATH)/dc/mmhubbub/dcn32/,$(MMHUBBUB_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MMHUBBUB_DCN32)
+
+###############################################################################
+# DCN35
+###############################################################################
+MMHUBBUB_DCN35 = dcn35_mmhubbub.o
+
+AMD_DAL_MMHUBBUB_DCN35 = $(addprefix $(AMDDALPATH)/dc/mmhubbub/dcn35/,$(MMHUBBUB_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MMHUBBUB_DCN35)
+
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c
rename to drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.h
rename to drivers/gpu/drm/amd/display/dc/mmhubbub/dcn32/dcn32_mmhubbub.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn35/dcn35_mmhubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.c
rename to drivers/gpu/drm/amd/display/dc/mmhubbub/dcn35/dcn35_mmhubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h b/drivers/gpu/drm/amd/display/dc/mmhubbub/dcn35/dcn35_mmhubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_mmhubbub.h
rename to drivers/gpu/drm/amd/display/dc/mmhubbub/dcn35/dcn35_mmhubbub.h
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/Makefile b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
new file mode 100644
index 000000000000..7f7458c07e2a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/mpc/Makefile
@@ -0,0 +1,45 @@
+#
+# Copyright 2020 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Authors: AMD
+#
+#
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN32
+###############################################################################
+MPC_DCN32 = dcn32_mpc.o
+
+AMD_DAL_MPC_DCN32 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn32/,$(MPC_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN32)
+
+###############################################################################
+# DCN401
+###############################################################################
+MPC_DCN401 = dcn401_mpc.o
+
+AMD_DAL_MPC_DCN401 = $(addprefix $(AMDDALPATH)/dc/mpc/dcn401/,$(MPC_DCN401))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_MPC_DCN401)
+
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.h
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn32/dcn32_mpc.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.c
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_mpc.h
rename to drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
diff --git a/drivers/gpu/drm/amd/display/dc/opp/Makefile b/drivers/gpu/drm/amd/display/dc/opp/Makefile
new file mode 100644
index 000000000000..fbfb3c3ad819
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/opp/Makefile
@@ -0,0 +1,35 @@
+#
+# Copyright 2020 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Authors: AMD
+#
+#
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN35
+###############################################################################
+OPP_DCN35 = dcn35_opp.o
+
+AMD_DAL_OPP_DCN35 = $(addprefix $(AMDDALPATH)/dc/opp/dcn35/,$(OPP_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_OPP_DCN35)
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.c
rename to drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h b/drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_opp.h
rename to drivers/gpu/drm/amd/display/dc/opp/dcn35/dcn35_opp.h
diff --git a/drivers/gpu/drm/amd/display/dc/pg/Makefile b/drivers/gpu/drm/amd/display/dc/pg/Makefile
new file mode 100644
index 000000000000..ec11d3157a57
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/pg/Makefile
@@ -0,0 +1,35 @@
+#
+# Copyright 2020 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Authors: AMD
+#
+#
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN35
+###############################################################################
+PG_DCN35 = dcn35_pg_cntl.o
+
+AMD_DAL_PG_DCN35 = $(addprefix $(AMDDALPATH)/dc/pg/dcn35/,$(PG_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_PG_DCN35)
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c b/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.c
rename to drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h b/drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_pg_cntl.h
rename to drivers/gpu/drm/amd/display/dc/pg/dcn35/dcn35_pg_cntl.h
diff --git a/drivers/gpu/drm/amd/display/dc/resource/Makefile b/drivers/gpu/drm/amd/display/dc/resource/Makefile
index abc2405b7167..4860bb2531a1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/resource/Makefile
@@ -166,7 +166,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_RESOURCE_DCN316)
 
 ###############################################################################
 
-RESOURCE_DCN32 = dcn32_resource.o
+RESOURCE_DCN32 = dcn32_resource.o dcn32_resource_helpers.o
 
 AMD_DAL_RESOURCE_DCN32 = $(addprefix $(AMDDALPATH)/dc/resource/dcn32/,$(RESOURCE_DCN32))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
rename to drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
-- 
2.45.1

