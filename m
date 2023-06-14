Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D41EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D3710E140;
	Wed, 14 Jun 2023 17:58:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481C910E140
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/1qsM4UYyP/How9/NSslGQ85M+YfFLozYa12uV2hu4z3FZo4xfprNtah9g7Qo61MH0SKYqDyvyWaVQ8kYM0y9B8iImjejFREdHnpAD1RblZqT5F4SHIMWObp753JqWp9WVTqIotpt5bNGyyyiaFumm2G+xReSlVoc+8uqPaNyyTXOXgUhiUfuJGS+LP6eFK152T/AqMdzkC9ovuBMJUWzqVf6WOniUc1NIIfUz9dhj5o7B1Z+JQHTGbXmdLDv0NQ79i5PRxROWrqpfbj60fFn3HGswxEBDKoXZDtWnjISqWW3tVJQxvOGVbf3synbl/I8U/gg4eAEstztnG3GJm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPMwxEFiwR+p3b7tu4lNLWrYp9zqKydUjhm1zDU1hfA=;
 b=giSQn2DbYB8ni63YiB52lB1AzZaNSuifNxzHjJw3yIZxC180dAgBJUfqQ6t2VPURaS05kuJSzOosFI7Uol318s9y2I6YEYIB1xyPPOAdPrB1tQjRMztNO6WW7UkUw1A01tX4IQetFh4fj7GYLXYv5lXhvL+dnKB1CPAJjp2Tnv0LeciEJWomfm9ZaQWGOKTZGxb2NLvSOAFmC7fz9UL8SJBW4/pN9LTNJY2nYCSCs98O0EmtBEcfYeAd4frga23coiYicLfpbe67NdFy9DzbSvhHq0+nCQ2CC8AMZIg2P7GBBzWBZGKbUzvLZ2kFqqHgLJRzD4galjumkLcWx/YHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPMwxEFiwR+p3b7tu4lNLWrYp9zqKydUjhm1zDU1hfA=;
 b=LCwZZRjMD62WhuaieRXqcs3ruV0Cqr+b6xAB+xAnde+V/oOAgaWci5NAWVTPCPG2c+nK7g7zVGFxiz3SRoKHZYS66ZQDjJTQ4e+Hcqx2m5BfEvMOqxpbng0sXbSdurAJt6LhdZI6t1ygVJ6F9ZcKj4DW8pLKpktsiA+b9DII6ss=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 17:58:06 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::6d) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Wed, 14 Jun 2023 17:58:05 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:03 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/17] DC Patches June 14, 2023
Date: Wed, 14 Jun 2023 13:57:33 -0400
Message-ID: <20230614175750.43359-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DM4PR12MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2c6c1e-3cb4-4528-48d0-08db6d00e7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +slCRsqJ7p1RRJspllD9/+WqNytgwZ42qr7jitfUo3x9cxYRB26NN+rBonEDP06QaVZ0Sn/O0LB4cGOGCubK0bCZtUOnEbTPhmUpklh8vmfgeLt1Xl0J7fIiuko9yLM6HKYtJWTUUN/2yoExYBKTSvz4/Z0eKayxDPsyUhzqB07udefBmTkCm8SLgO6kphvLJug9QqqfCltddqW5/G4JKlvu/xLxfVtffdal41IlKdNGMCuCA68vCPOOPQj26r4b7KvGSYqS2V0dkOM7hZA6gLQfil7OoiwCgw0bSYwnSbcLvWchNEq/4Jx21ExraIlRZb3UZ/XPbmvff+YBJl/FqbK0YeJcTrbp+qCM5NUew6q9obFxzwFYY2xsBjMdpOgMlw2vEnbRyQ/Knvw/THTPo7dO1bjb1ul3jQqqw5priw0XF9q0Z8ypiGEQ2UGnsp8Qaob4M7CkeeALwmmNkaQYvign5c5QWo9ppKnnFRLDBsXjOqnDqvZhfG6BtpWrc4VVjEBZa3aleJvZd63+acUKBF2DNbsKPnpLKsTCFtohjL7FeRcNC7/9vcEki3e6ce68qM8/UyGY3+l0pR4+Hja10znp6AZYVgMU+mwhdcSekWdc2Toxw6QC0K3GHEf/R9SruzbToWpBqFoCuQgqBJhY2TLRmFJvuSkYBs36MsryWHmsVrAde3jN8jh0auoZSK6bW3zKztNzeZYn23PR9cQJvra/QumDYs/eZT4kIJNdywIBJ31T25jCvL1MjXZGAXhmXE7QCjqM7PIs52LIGvPDNDrhRPiV+R6Q2X4AZahklMe1AcQ1su9plzHc7pMMmxsn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(5660300002)(2906002)(8676002)(8936002)(70586007)(70206006)(44832011)(54906003)(6666004)(26005)(1076003)(41300700001)(186003)(316002)(6916009)(16526019)(82740400003)(426003)(356005)(336012)(83380400001)(47076005)(2616005)(40460700003)(478600001)(36860700001)(40480700001)(86362001)(36756003)(82310400005)(81166007)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:05.7126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2c6c1e-3cb4-4528-48d0-08db6d00e7c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patch-set brings improvements in multiple areas. In summary, we
highlight:

- DCN314 fixes
- DCN32x fixes
- New fast update sequence enablement
- DC mode clock switching enablement for DCN32x
- DP link loss fix
- New debugfs entry to set MST link settings

Alvin Lee (4):
  drm/amd/display: Fix pipe check condition for manual trigger
  drm/amd/display: Clear update flags at end of flip
  drm/amd/display: enable the new fast update path for supported ASICs
  drm/amd/display: Enable dc mode clock switching for DCN32x

Aric Cyr (1):
  drm/amd/display: 3.2.240

Austin Zheng (2):
  drm/amd/display: Add Clock Table Entry With Max DC Values
  drm/amd/display: Disable DC Mode Capping On DCN321

Daniel Miess (4):
  Partially revert "drm/amd/display: Fix possible underflow for displays
    with large vblank"
  drm/amd/display: Move DPP/HUBP power gating setting below debug
    initialization
  Revert "drm/amd/display: Move DCN314 DOMAIN power control to DMCUB"
  drm/amd/display: Prevent dcn314 RCO from enabling on unsupported chips

Dmytro Laktyushkin (1):
  drm/amd/display: fix odm k2 div calculation

Fangzhi Zuo (1):
  drm/amd/display: Add MST Preferred Link Setting Entry

Ilya Bakoulin (1):
  drm/amd/display: Fix 128b132b link loss handling

Leo Chen (1):
  drm/amd/display: disable seamless boot if force_odm_combine is enabled

Sridevi Arvindekar (1):
  drm/amd/display: add missing ABM registers

Sung-huai Wang (1):
  drm/amd/display: add a NULL pointer check

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 156 +++++++++++++++++-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  43 ++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  20 ++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |  29 +++-
 .../amd/display/dc/dce112/dce112_resource.c   |  10 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   3 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   3 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   1 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  30 +---
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   4 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  19 ++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   8 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   2 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  90 +++++++++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   4 -
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    | 102 ++++++++++--
 .../amd/display/dc/dml/dcn321/dcn321_fpu.h    |   4 -
 .../amd/display/dc/dml/display_mode_structs.h |   1 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  11 +-
 30 files changed, 474 insertions(+), 88 deletions(-)

-- 
2.40.1

