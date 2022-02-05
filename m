Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C31C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:50:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 868EC10E11C;
	Sat,  5 Feb 2022 01:50:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5603110E11C
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6Sim8VQXWI8bz4aITwEYWsNkeLfGVGwZaczjMOMAqMMvUjNfv9jzSuWp5hR2QX8RR5YQuMQ2xXB2wBUL5zRncgE5s4yJercOWqw3o1oD+bJVyGB9wtjGg9ZYxHvTw9Hs6zuVzK85KadtEmZndAE0kolReYWejKwbJEs6GwanHol4cLPDvK6cjrgaTGJWfz7MMa2GBfox2h1r6ZjQk6pz/g7BH2ENOKVO/T2ixDF3V3wAXj9HxtOfotk7o+Mb4T7cDO/xQXrmlnbNZMGkuyxr0HINhrvpIWho44AuDwHKX+AsBibSaJsQZBwNn+cNFLfIYuBXnRJxVgkZmTv/Arobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjB2u2IpX2wPmzNIPARI48t60gIATsVd/0dL7SIhsBs=;
 b=E9a4VgudlPkzW7N1DhdoElKtS25SwTLcjnRPpGmC2i4Q6bKLy04r/rytp4vmd8JpIOI8EEMdUYOYQNhscRWK5LyVHdSc+xIRZZTAk81GZwlUnEaiA9DqZE6gYrSeYqkBHI5Kgb3VDDdHX4nrD30jPQ1Zirkfim8dp1iJ/9gVYd2XKT0hOjqqSku1WFzq/GUU7Y5iCrFtC/52cFHmLc+cX2E8bpTHVbJs6QURoY/2j/dQ1lJZhY7w9V5TAUs062jCe9/RSYqHfJ0T+gyuMTxc4q/QjR5KX/AmqPwhFaYXpfi7A3/iL5OfN9hoKApqAKjcCjjD1eHRJ7Jgt4p7OH9G/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjB2u2IpX2wPmzNIPARI48t60gIATsVd/0dL7SIhsBs=;
 b=xuXCA2cy0AdFiA2ioHnD55wydbcYRi5Vhc4O2r1BvTwikufB0l6Isc55R+HQ/TRyZ9eln0jN/syxCxV+qbgjQ+okj9kxM/Fx+80UctU6c/lUQIlCrvsXCmgU6iAPwZXJav8VzOdFxQnhQ3Na5T9zDrVuf8ucNM7nWcFsK5ky3Lo=
Received: from CO2PR04CA0137.namprd04.prod.outlook.com (2603:10b6:104::15) by
 DM5PR12MB1513.namprd12.prod.outlook.com (2603:10b6:4:d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Sat, 5 Feb 2022 01:50:43 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::6b) by CO2PR04CA0137.outlook.office365.com
 (2603:10b6:104::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 01:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:50:42 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:50:40 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patchset, Feb 7 2022 v2
Date: Fri, 4 Feb 2022 20:50:15 -0500
Message-ID: <20220205015029.143768-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5674411-71e7-41f8-b3a0-08d9e849eb82
X-MS-TrafficTypeDiagnostic: DM5PR12MB1513:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1513F0918471A901C9D08AAFFB2A9@DM5PR12MB1513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tD5PDtEJN2b11oRwdb/evizN/EMdZ8xM7S2gSTlvdu0gP7zto+sUTYWk26qVMpuVvW0bJQ6KhBe1/ILUJwoosgubGrPz4x/ovNqOjNXj4WWgy0vGxvEy/dyb60RdATPZjOzSlSwRXxNMIzVvMr2goPbn9DwaJEcuuxQl4Yaw/gMHOOG2FmrzcIJ7yX0Eaxb6+BeilJTDwp6N3B2FwDTDTaXL374918nE9WT4aLdeu7wcOs6wPIlY1TYYSVH1UWpJzGpXkjqi1ktTMhyl3LqfW4b61dj/zWMWFqbYudnhFUNlumy8WFjG2Hsv7eqGnQgaTV4S+Bov8GQVFf2rnIwhci3OKMPIfL6zeAciKL8nYzfImz3xMGly0r4fkaI/umwnxbELWxVdqiDzIg09x/6Gde126fzgMWyk0fZqyKitst+ZuMnpQntjYnv3AOqSuvPxHz/aqYvjy+Hka8rQwpk5/IxsTQOE37ql4euwQF2bv5nvsFaW9loA+WU1UnTexIEj+aENdMmWfikaVRsaRpeR7IqOYFMFLbshfXibuwTN9gVJ7F4RklPMYiEKSooZf540+D3Vz6a/h0DF8KMiWa+hnzSvzqjvPm+yMpG3zap3RLmF53NGvqRp2mHZecXvczEnRncUuPzIFkIGzmQfGrPBoWiyW1Whk9H1Z6CtlIHgC6FVgLqFMNdhDv2UIxFdFsIcWKRE5J43/44QkV1RW/+Tzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(36860700001)(70206006)(186003)(2906002)(5660300002)(70586007)(8936002)(4326008)(82310400004)(8676002)(47076005)(6666004)(36756003)(6916009)(54906003)(2616005)(26005)(356005)(81166007)(508600001)(316002)(426003)(83380400001)(336012)(16526019)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:50:42.9229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5674411-71e7-41f8-b3a0-08d9e849eb82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
-fix for build failure uninitalized error
-Bug fix for DP2 using uncertified cable
-limit unbounded request to 5k
-fix DP LT sequence on EQ fail
-Bug fixes for S3/S4


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.103.0

Aric Cyr (1):
  drm/amd/display: 3.2.172

Dmytro Laktyushkin (2):
  drm/amd/display: limit unbounded requesting to 5k
  drm/amd/display: fix yellow carp wm clamping

Eric Bernstein (2):
  drm/amd/display: Fix for variable may be used uninitialized error
  drm/amd/display: remove static from optc31_set_drr

Guo, Bing (1):
  dc: do blocked MST topology discovery at resume from S3/S4

Ilya (1):
  drm/amd/display: Fix DP LT sequence on EQ fail

Martin Tsai (1):
  drm/amd/display: handle null link encoder

Nicholas Kazlauskas (1):
  drm/amd/display: Fix stream->link_enc unassigned during stream removal

Oliver Logush (2):
  drm/amd/display: Basic support with device ID
  SWDEV-321758 - dc: Code clean

Paul Hsieh (1):
  drm/amd/display: change fastboot timing validation

Zhan Liu (1):
  drm/amd/display: keep eDP Vdd on when eDP stream is already enabled

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 27 ++------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   | 27 +++++++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 11 +---
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 61 ++++++++++---------
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.h |  2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  4 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 +-
 17 files changed, 104 insertions(+), 83 deletions(-)

-- 
2.25.1

