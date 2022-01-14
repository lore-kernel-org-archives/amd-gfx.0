Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D607C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA75D10EAD0;
	Fri, 14 Jan 2022 01:37:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996D310EAD0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daWih+bkl3430FZrem8YJEyp74Sg+VHZOPsRvt09IMIxiqHScMQY8MxrRO/Y0WNxq7l+Vn5JojdeORxhk8JUIe9IGRhu1U8iYIw9E1yW5uBrfLKjNbnX71+NIuxp8hIBQmcfpSzW0wVdpy2eEEKVNYxQEEfVity9I2ntUBppq1dCTg2StJWRaZgNL8WpppJ9XYyuJQw6DWwdYtRbxDd/+vjtXR0nOPfr/VVXbxkQf70yVNsOYN8tgo7hDTCx+BEmL6ZSWFEKwkAlq7/mcufYDUJiWxUAzzlt/4m1RMbYQlAU1dPxxeSKwbX6Kk/+bGKAk8DMh6kp1HjPDY5YL5i6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcweI1Y8G0BAyp3j8mDvVDifkco2gn9s28CNhzPOfkg=;
 b=SVBKUoyhvfoYrEZBdOH2QsLiDR6u0wfPg9twTVk4fxzEhfAETc9casmBLOCOM/qrexPXD9cPs3/eaMrHucvridq0bQPCALywBVT5jy2RY6P3RadYok+uHSFxCTRugCyDSZkMTGZlGDIT7uD+Uq28y6fgH6QNaowUXRGk3t4ukcPlF59apMk3iLpCsc3xT4M6PnGFtpHAoGT6I7viWP25djQCgu19Q3vGuW/psy+F5k5dQdut3AazxacC/ih+uP4Nt1ik9bQVhZQab2ad2KfOguCB3b3ETC2oaD70bixAGvhdRRSnyenQgwIVg1035QCBFUucpuUEPDNvKgjriZzULw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcweI1Y8G0BAyp3j8mDvVDifkco2gn9s28CNhzPOfkg=;
 b=L2B15NgMg9mjA1an+9qqyZ+V5PZZ+r4GIzL2Rbn82XdcVLlrQ3a4ETqA6Ye8O0oa3Vi7b/Gp+nZisbVJDawobIXw6BcmZCPspE89CBauG91HTbfwQ2meL+M1RlJmSVkzPswFithK/sAVJUNPmNKwZyA6TwUxE0k0T+sfeD92Ydk=
Received: from BN6PR11CA0023.namprd11.prod.outlook.com (2603:10b6:405:2::33)
 by BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 01:37:10 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::53) by BN6PR11CA0023.outlook.office365.com
 (2603:10b6:405:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 01:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:37:10 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:09 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 17:37:09 -0800
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:00 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/13] DC Patches January 14, 2022
Date: Fri, 14 Jan 2022 09:36:44 +0800
Message-ID: <20220114013657.3119627-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de42ef4c-adfa-46b2-4188-08d9d6fe61dc
X-MS-TrafficTypeDiagnostic: BYAPR12MB3462:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3462110A35269A6411490B94FC549@BYAPR12MB3462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pzg1VumdFjTBVnibO8AJf/+sjN1OPm5nH/7z0YfkOcEtYA5y+BhEgH1b+iU5CoHcdQF0hX5+xolLE+A5IAcRQZSr02yAQITP3DUKeh0Z/WF5XOJQI+ydCdHbyY7pkfyoe1xftFrw1B7GVzK++8aHykaUe722+CCXrvFMJFDWv9OKbj24dVW04766nLmRrvGmhk+xOvqbz7o+4U4HoBKlVUYgb6LvRej/jo5nVw32wfCWNLXSwQKjg/2yQEtAviNS9Ykm6EMnEHR1hVvETItgO463FdJRN76LGDBIPZgoJ5cffkNfAp870SJ9yI0Mmhe0cVK4Pa/uKQ+F8B+4O7p+wQwrHlFkXTybJ4ceblwSAs4GKP9qy9vdGbHr5akOfiR0nw/+o9b9VvoTDw4qmlxXVbEAy8fKb7BRxtsNFeN3X1tMH4GthFF0bBqvE+MLlzcVDLx2dmar7kHpfsHsg9r15kP8PVSBdxolzOmdpE4R63tu6phDDOm3DQX+7mwLYvRDZvz2FrYOzoZ/QsLRWWs2trmE20tg0sACkTsylInpE5WG6Ev332ue/5Duvdp1OLjLe2P7Bu0o7jFXniy8taH7K7ssULx7VKhfauK/caLTucF0IK3sNUoM+M4EKkEWMnl5r/HXf7+O8el1ZVQY7c5T5pcheGddbMQNBJ7fx55K38EM1qhTtiuAVzEm+IKFQAmLUvJrFj41UIte1gNt0ow2EChWQ5NLYRTdEAGhG79BrTE5YlfOsoGWC7UfCU8I0cQrh3G/VJjd/iZZC3H2j2UktmBiNp1fh4pRUN4PufIFuo8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(7696005)(316002)(86362001)(508600001)(54906003)(426003)(6666004)(40460700001)(82310400004)(6916009)(26005)(4326008)(1076003)(81166007)(186003)(70206006)(83380400001)(336012)(36860700001)(5660300002)(70586007)(2906002)(8936002)(356005)(2616005)(47076005)(36756003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:37:10.0716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de42ef4c-adfa-46b2-4188-08d9d6fe61dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3462
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fix problem observed while assigning link encoder
* Constrain seamless boot on eDP only
* Improve Z9 interface
* Organize FPU associated code to DML
* Modify SMU_TIMEOUT macro
* Organize dcn201 code
* Address DS stays disabled problem under specific scenario
* Fix black screen issue
* Update DML to rev.99
* Address problem of eDP hot-plug feature

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.100.0

Aric Cyr (2):
  drm/amd/display: 3.2.168
  drm/amd/display: 3.2.169

Charlene Liu (1):
  drm/amd/display: update dml to rev.99 and smu clk_table w/a

Chris Park (1):
  drm/amd/display: DCEFCLK DS on CLK init

Dale Zhao (1):
  drm/amd/display: Add signal type check when verify stream backends
    same

Dhillon, Jasdeep (1):
  drm/amd/display: move FPU associated DCN302 code to DML folder

Eric Yang (2):
  drm/amd/display: adjust bit comparison to be more type safe
  drm/amd/display: support new PMFW interface to disable Z9 only

Felipe Clark (1):
  drm/amd/display: Fix black screen issue on memory clock switch en

Ian Chen (1):
  drm/amd/display: modify SMU_TIMEOUT macro.

Jarif Aftab (1):
  drm/amd/display: Disabled seamless boots on DP and renamed
    power_down_display_on_boot

Stylon Wang (1):
  drm/amd/display: Reset link encoder assignments in atomic check

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  16 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   1 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   6 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |  15 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  12 -
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   5 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   8 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  12 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   3 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |  12 -
 .../amd/display/dc/dcn302/dcn302_resource.c   | 316 +---------------
 .../amd/display/dc/dcn302/dcn302_resource.h   |   3 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   5 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   4 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    | 357 ++++++++++++++++++
 .../amd/display/dc/dml/dcn302/dcn302_fpu.h    |  32 ++
 .../dc/dml/dcn31/display_mode_vba_31.c        |  29 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   2 +-
 25 files changed, 495 insertions(+), 363 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.h

-- 
2.25.1

