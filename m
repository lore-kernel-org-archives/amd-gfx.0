Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050BC55185
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3182076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rAcLQO0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3182076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D5689DED;
	Wed, 22 Apr 2020 22:08:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7061589DED
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzLoY/PvMTRlZxbc+czPBK0g/wZV9vY8LJBlgfYv28ddZEZ/nE0ngabK/oBzAnY3DXerZX1UsEx9UpMa6yft1VxsJkjlJXyoENd32feEuFtp3ezZqJqQQZ2QviF3IpM5ZYdvfnGM2ZI5z98J/9xKvN193pCxByLDPEA45lY/jP6UMjVBAVxfdbrwZbtZ78RhWKxGOjVdn6FaQwclk1VbC9YFbc4eD0WxnsivWGN4DtK/tpuKoyfwnMlabPHx2I6WMw4m26PaXAPv5/HqrJ0NjXjszf7UOQrGMM7AMhM/mKO9d92gs7h58qKfwgPlbcBLvL0tlZaRLPs7HY7JX+L23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLHtl5UyqYSmb0mdk51Rcui8F1KPnEh7IqxRxo1Ccn8=;
 b=gxYDBsiXltA2T1PZFqR7Svc82oQVHAUvMD/KV5oE9tPJX1lxhFNaJwFFWgA8j7QFHcQ8B84HlYsrK4AqpTyVoCEUyX6DNinh45553JOSh0z+ORG098sCeQk4evdfrpMaTJGYASpHaYKA+cVnLTtFfqyNJ2GLgeStpvF4zoRd0lKU/aPasMSdttjQvu/L5GKPwZPrerubFpgEEk/GzHLjLgHFBg41U5ciTWWtW7EjRI7BI/HMJvKCkgcfPx4T0HniDhv6rLtF4LhKnljLo6uo6j5dXf6xtG8GAdM/PauQ6lMv0BiiofkzOlk8jMrArY4dURf3Y5XIuuVsJzvbGQNkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLHtl5UyqYSmb0mdk51Rcui8F1KPnEh7IqxRxo1Ccn8=;
 b=rAcLQO0EPGiml8E6wXr/886DVww4UT8/7qkWgAqqbJMWQburlchboCO2CXQCCGAumMXY6lh0qRdWwWBfcP7vntBPEU0kXvySskbQEpNpxeIMAmkKFzCdSvDpgh7ydGbrfx4rf23RJ8IljKqC+l43uSrSZXLSucjdo3qqhITIoxY=
Received: from MWHPR12CA0036.namprd12.prod.outlook.com (2603:10b6:301:2::22)
 by CY4PR12MB1334.namprd12.prod.outlook.com (2603:10b6:903:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26; Wed, 22 Apr
 2020 22:08:09 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:2:cafe::e3) by MWHPR12CA0036.outlook.office365.com
 (2603:10b6:301:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:08 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:07 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:07 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/19] DC Patches 20 April 2020
Date: Wed, 22 Apr 2020 18:07:46 -0400
Message-ID: <20200422220805.15759-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(39860400002)(376002)(428003)(46966005)(54906003)(81156014)(8676002)(8936002)(7696005)(47076004)(1076003)(6916009)(82310400002)(26005)(5660300002)(4326008)(6666004)(44832011)(478600001)(36756003)(70206006)(70586007)(316002)(2616005)(426003)(82740400003)(336012)(356005)(81166007)(86362001)(186003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7128f66-b038-4ed8-fdcd-08d7e709a3cc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1334:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1334A984D88635237649B7B38BD20@CY4PR12MB1334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VsZ6+xjlpff0R7uXyWBwVIDA6br7+Ml69lt5UcRl/UEZAZCCTUS+YtHdLnSWK/cvLiQENTQwNlzsyrNx3ArAu6kytKvGLpSmEzFGJTnpz9beIS0JKM5ygNYTJhdJuFCeJtmWkAVcBaZq0tczSFaPh2W0jcy4AKtCi7hq+shWkuv6fqTHvcOL/rg2vCHOuaal70jiWMPAEp+5/MEiTHp8Le5pB+h8YipsPgrn9JW/eJvyav554ByKhx15VlxBJq3Vlr5iC3c44NSvmcuIYSCxUEXEOrGlXPllRh0Yfhkj5dNy7VVIUo6EmidlCfhw7N7tjgf1CaEiWGUoJ7BVFXkUm0jM8jPNzJZ5lSWV+ayhcohBGRu55Vu0Fl2msz1YLvQvsqRI4phgRLYAEP8MLeo+SP8zvA89QdKa5rrJcxJvJAZhj4vwQkeFgfg2BeTRYf4kpnRE1ZueaIDjWz62m5GZF6HTWEPcwDtHwOVc5Rkhmnjsmw8bBGmZ8rF+L/cu/aqi85CtG35QaKAZ3QQ38Be7ew==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:08.3427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7128f66-b038-4ed8-fdcd-08d7e709a3cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1334
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we hightlight:

* DC version 3.2.83.1
* Enhancements and refactoring in DMUB
* Improvments for DCN2, backlight and others

__

Anthony Koo (1):
  drm/amd/display: clean up some header paths

Aric Cyr (4):
  drm/amd/display: 3.2.82
  drm/amd/display: Use cursor locking to prevent flip delays
  drm/amd/display: 3.2.83
  drm/amd/display: 3.2.83.1

Dmytro Laktyushkin (2):
  drm/amd/display: check if REFCLK_CNTL register is present
  drm/amd/display: fix rn soc bb update

Joshua Aberback (2):
  drm/amd/display: Add DML variable for future asics
  drm/amd/display: Add dummy p-state latency bounding box override

Krunoslav Kovac (1):
  drm/amd/display: Internal refactoring to abstract color caps

Nicholas Kazlauskas (3):
  drm/amd/display: Fix DMUB meta offset for new load method
  drm/amd/display: Defer cursor update around VUPDATE for all ASIC
  drm/amd/display: Pass command instead of header into DMUB service

Sung Lee (4):
  drm/amd/display: Do not disable pipe split if mode is not supported
  drm/amd/display: Fail validation if building scaling params fails
  drm/amd/display: Change viewport limit to 12 for DCN2
  drm/amd/display: Update downspread percent to match spreadsheet for
    DCN2.1

Yongqiang Sun (2):
  drm/amd/display: Add panel cntl id for set backlight level.
  drm/amd/display: Add set backlight to hw sequencer.

 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   7 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  62 ++++++----
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  36 ++----
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  40 +------
 drivers/gpu/drm/amd/display/dc/dc.h           |  48 +++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |  15 ++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  28 +++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  12 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  35 +++++-
 .../display/dc/dce110/dce110_hw_sequencer.h   |   4 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  19 ++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   2 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |  15 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h  |  20 +++-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  48 +++++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  12 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h  |   3 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  71 +++++++++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |  33 ++++--
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   2 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 112 +++++++++++-------
 .../amd/display/dc/dml/display_mode_structs.h |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  16 +++
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   5 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_rb.h    |   6 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_types.h |  11 ++
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  10 +-
 .../amd/display/modules/color/color_gamma.c   |  31 ++++-
 .../amd/display/modules/color/color_gamma.h   |   4 +-
 43 files changed, 523 insertions(+), 228 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
