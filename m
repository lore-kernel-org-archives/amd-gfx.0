Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D86C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Nov 2022 21:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BCF110E265;
	Thu, 24 Nov 2022 21:14:08 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F3A10E259
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 21:14:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7BiVs6NvfO6iftujCZxhemmOk/Uqeh4nAPRi2ZcuqifgDvf7B10vxxevBHdwWHEUrEyfySQOxDaNahl6z82w7nHyuOr4xtyX8PUPNyHPlqvgRq2c3uYdYmN4C5FRipbCyllnfmVl0ZoL80k3gUW5WDj5p14HEYh/uzia/bU0AwVnI96DkunxzQkeapzUONjp52OoWIlASg9wd55qbq2yTQXN+Sv4wZwI9sunaS/nAw9uAy8PLjdwz8oOV7wsC8JjKPToetK6KeiDqTe5G/zqIgrYG8p07AqwPTwWwAeUlTtfVWto0w+LoWzZglgP814Ij83AuQztO4Sy2miU7YDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0L9GVi7ZhC/cPh5L+uzbHbG0K9UbJRf40P79lgvPx0=;
 b=Q5mTtVxPtSF02csjckPWplbgY9bmCFRD8pt/22IfrsxDHTx+F1dMZgYl8hYZoCgxek0MzN8txfIjD94j1NYyX4H+VdfYL5wnbyctUaml7T09MjhBO4kz5c4RL2y7Rffw+UrmeTFLpU1NdfEIIV3knPNfkyZR66vfwAFHFoX2mYaJefQofuC2pTxRtim6KJP8cK5F2VOPyQjbUwlepxGgdBHZaxquGQ++hEwrfZDSb+36Db95ChtDBAw4ObqjD22uXV4+Jl8xvgQPyNwSGwk1Xhf/eG9RdoaWUuBMlNirJRMj7tgefkb/m6MmxlRVN1whLDqxD6qxvwQ8NL67wcUzdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0L9GVi7ZhC/cPh5L+uzbHbG0K9UbJRf40P79lgvPx0=;
 b=rYupydPAeZ96ZIEq9RqtQszMLeRdVQw22u0YM6ZcVvDij5l2dCMqVnHLkuJPUKbLGj8kpQrg8U4CymeGo5gA3nX0XFWHfj6FGn06dvDxOSIGKmNkK8lj9UXrqDwAcFcNoDWkkO0S6rrkY8sMyHUvbGu2sUyb7YbTlPFcp0NxZL4=
Received: from BN9PR03CA0460.namprd03.prod.outlook.com (2603:10b6:408:139::15)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 21:14:01 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::db) by BN9PR03CA0460.outlook.office365.com
 (2603:10b6:408:139::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 21:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.19 via Frontend Transport; Thu, 24 Nov 2022 21:14:00 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Nov 2022 15:13:59 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches November 28 2022
Date: Thu, 24 Nov 2022 16:13:36 -0500
Message-ID: <20221124211348.214136-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 6688dbd5-5047-4811-aa9b-08dace60cedd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvGi0rbBePJ4rARgYqlrlqCr3uwTAtwbgVlPC1VqMZ4lEOJ3KD3JW5GjvBRU5A+r1V8+Vf5qugyokqSeiqBBet7dC7yXLl38iiSkS77gYlkRvHmRGFEWOB+BhopmafrYr3gvn6faJow8AnVKmsxALqj51a2TFwNAiPweN+0a4Yk7/7AhHcOJDmq0B1/EC/+ijPLNv0Ybiu7b2+UZ+EXEmhbeqsZou0QE/zt2QMKtR4Z4QSEU7clP4921vuqlXw++nb86Nee1SvcUL+4d9Ufp5YZGOMHYHB5g0cmNKZYGSBG2gWp7sDJL4lDQlwn9k0kG08r4kS8Xf6KkJjZnFav/6XYnfCAwty+sbsKvBydif9vUgiBQljiH4TirMaYstH3rEQD0FkYUtJ/Ohw8SmHmdii0QarlWWNJ+/ZIbDx7C7fSgEjpOIr1eknN+Zs/Xq7Ggh1CWcdJU7SFu95nQBl7WwfFCtlhWErE29JvY0LcOPIbhbMfCoHMj45Q7amRMc5cNA8xykhC+vBkq6eP58bSNZuzgRUZEvdWyumRbMVsI8gVCTLmEWPwbC1ZYQjiR2OdZaANAl7/jY6zPnaWpd5hruIaphfWI0Kc50blPj9oNYi1mC5r3oml8S0WkxaJuZHnQh5AorMGPGN9h8234msUArE/rJftgbqbzIUtokZu0BA9x93/kXcdh2HylScwAnhtPri5hi1SuncNG8ZGiOKzymt75WNDc/NYNfcF0B9kBb98=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(26005)(36756003)(356005)(54906003)(81166007)(41300700001)(4326008)(82310400005)(8676002)(82740400003)(40460700003)(70206006)(70586007)(40480700001)(36860700001)(336012)(16526019)(2616005)(186003)(1076003)(6666004)(478600001)(316002)(6916009)(8936002)(83380400001)(47076005)(426003)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 21:14:00.8693 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6688dbd5-5047-4811-aa9b-08dace60cedd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, jdhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Program output transfer function when required
* Fix arthmetic errror in MALL size caluclations for subvp 
* DCC Meta pitch used for MALL allocation 
* Debugfs entry to tell if connector is DPIA link 
* Use largest vready_offset in pipe group 
* Fixes race condition in DPIA Aux transfer


Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Alvin Lee (3):
  drm/amd/display: Retain phantom pipes when min transition into subvp
  drm/amd/display: Don't overwrite subvp pipe info in fast updates
  drm/amd/display: Fix DTBCLK disable requests and SRC_SEL programming

Aric Cyr (1):
  drm/amd/display: 3.2.214

Dillon Varone (4):
  drm/amd/display: MALL SS calculations should iterate over all pipes
    for cursor
  drm/amd/display: Use DCC meta pitch for MALL allocation requirements
  drm/amd/display: Fix arithmetic error in MALL size calculations for
    subvp
  drm/amd/display: program output tf when required

Dmytro Laktyushkin (1):
  drm/amd/display: set per pipe dppclk to 0 when dpp is off

Stylon Wang (2):
  drm/amd/display: Fix race condition in DPIA AUX transfer
  drm/amd/display: Create debugfs to tell if connector is DPIA link

Wesley Chalmers (1):
  drm/amd/display: Use the largest vready_offset in pipe group

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 151 +++++++++---------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  23 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  10 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  23 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  30 +++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  34 +++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |   6 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   8 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  66 +++++---
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  13 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  15 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   2 +
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |   3 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   9 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +-
 19 files changed, 277 insertions(+), 152 deletions(-)

-- 
2.34.1

