Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3808AEE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498FD10E45F;
	Wed, 23 Aug 2023 16:04:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C33310E45F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oajr1SQUS2d+SE9V4vcA30SBf9VbFsHa1//s3zkCO7Q/BJidbEDG7ack42PF21/N26iazaqt9NQEzZcvWNmcdMYp5cz0oiIcGGUNSbIXKMrCMa3IwRwhZXKhacvdDyG9OM+KpO2zpdcxA2EQunO4NMkpNh5mjsMwOccinBidwIRzyl9MTOHrRCNUog+pod0240zaBvt7zorXETEBnTW7svbOaF9LaNqClp/7VK8cqCltMZ+ity+CwaX+h2itZ4bR2rujVIE8QwZ3MeLGYYfCGa1gTp+YMlGaMeV/IhSgbX8uDzTHZeQtYMzS+pleCZYbFcokpgubdW52BzULaFEyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoCwqsAyFb/OjG1G+sLuw00uQZo2kt+Xfwe7NQPNvcs=;
 b=cJ4F4+S09DzAaD3mxRYZWafN6bOHPt99VetS9KHziwtrj2XDoCKSAFBPL4VAd+7ek5e6db8W1EJTatPo6atTy9gvn7HGOUbtrzn9n8qQVPq4imbwgmTlBnSRnWIujbEcSePLeai2v5eAX++eWRmL2Y7qrYv70BQOrXTs8VOyliFEqJ8swmv8cVn1UrBpkSUlJoNpo85Dfom91unodrjhT7og53z1ivNYFn/DYsVQYW0rtfZWFj2i0LuZvbveSVZ8ZWUX+VTJ/f3AKiAgWOne/RcZ1rVLaR6g/jom2eGasR1wJU9xjFVliIeWlDHOFw8NptW/fNU5SDC76Am0mnriXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoCwqsAyFb/OjG1G+sLuw00uQZo2kt+Xfwe7NQPNvcs=;
 b=vZNUJdDk+0TwqEbc9NJuIxM5ttr9NZsCWwP9kAwJa/kcnrg7yZbm3x4geJ4YkM7c0JROdpZSA5UuYw6t0y2wSYbFvez0NwGNgXfEae9t401kWEblKm6M6TpB0P0lHkXhZ7vVu7txzpyyqgJ3vfRjxxlkZ11+u2WyOHjvyxc5oVA=
Received: from PR3P189CA0013.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::18)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:04:11 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10a6:102:52:cafe::4d) by PR3P189CA0013.outlook.office365.com
 (2603:10a6:102:52::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 16:04:09 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:07 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/21] DC Patches August 23, 2023
Date: Wed, 23 Aug 2023 11:58:02 -0400
Message-ID: <20230823160347.176991-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: b060cb1f-6a2e-4f61-087c-08dba3f295d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWagxyxoMD6djKDxwrwtnpxHlFedxGQq/EmNd0KnL3mtEevHx/Q8ePMrp2q6tD0t+av4KGkrvq/sFtqohhRIf9ehQ1HtBUaEQPileFkFZlgnLoo6wiSwAcmxdA9veTpUrduqcH18GvLZYV90EJET7Gctj9SkIX4rCtd6ekrg7CN9PiIb6FzZkc+qkgn9sWCQZ6DmnkyjvWz2tbD5f4zGJ1cPFUBdLG+rOLqXT61lyK3RZ7p0LhvQIyio2HO+69LMs7VR+THn24UXRap+EH+qCwZEFmpuDLg6joYcd6YCkjFL4UZpWzMyr36PsyjPkJM4mPxv2VU7zcioJ6rEHiXjg9Z9zt8XBBLUer0z01E9LcwZHa7t1fqgou3l6myOYb1pJ0BQ2x1Y3ASM/t0niAAwZfnVMnfPqGxeNqP8UJZ9oMu2bLJ44oKbAmRX+3XZznGk7wag0y5Ny8BFYDLsWEZwCIXB4U9Xn9QxCInbXLTjK+ANSFNeZHM+DQ0Fpfyj/0zcvYmCvB0BBkKASmnuTQIgY8fGSzilZSRl9fTmo06EzJ5am6eb8zg363IKPfgy40xMQDDIdg0VMm26zjv0DU6WzVnwMVA+PR6wDvd/ODklQ3ThV30imxfGYe0+/bbZqFMi7anrrJ1zcExN4Y8SeZGbB6H7vyug8uBYezto60jiMare7iq0Bfg+Kev+8xv6cbGhIkO0mbe/zxBKeqp31suFw62FE/NefhExdYhGjJE/4Mbli3n5PYFh/pyrcka4xPmxoWpls9PRy1AilqkwdoB/91ux8Sgjw2xO/9t8V1rUjtN8BKfPH4aFLD+LstdOIP9+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(40470700004)(46966006)(36840700001)(2906002)(83380400001)(40480700001)(5660300002)(44832011)(426003)(336012)(26005)(86362001)(47076005)(36860700001)(16526019)(8676002)(2616005)(4326008)(8936002)(6916009)(70586007)(70206006)(316002)(54906003)(478600001)(81166007)(356005)(82740400003)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:09.3873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b060cb1f-6a2e-4f61-087c-08dba3f295d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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
 Daniel Wheeler <daniel.wheeler@amd.com>, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patch-set brings improvements in multiple areas. In summary, we
highlight:

* DCN315 fixes
* DCN31 fixes
* DPIA fixes
* Dump the pipe topology when it updates
* Misc code cleanups
* New debugfs interface to query the current ODM combine configuration
* ODM fixes
* Potential deadlock while waiting for MPC idle fix
* Support for windowed MPO ODM

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aurabindo Pillai (2):
  drm/amd/display: Fix incorrect comment
  drm/amd/display: Add debugfs interface for ODM combine info

Charlene Liu (1):
  drm/amd/display: correct z8_watermark 16bit to 20bit mask

Dillon Varone (1):
  drm/amd/display: Skip dmub memory flush when not needed

Ethan Bitnun (1):
  drm/amd/display: Add support for 1080p SubVP to reduce idle power

Fudong Wang (1):
  drm/amd/display: Add smu write msg id fail retry process

Gabe Teeger (1):
  drm/amd/display: Remove wait while locked

Martin Leung (1):
  drm/amd/display: 3.2.249

Mustapha Ghaddar (1):
  drm/amd/display: Add DPIA Link Encoder Assignment Fix

Wenjing Liu (12):
  Partially revert "drm/amd/display: update add plane to context logic
    with a new algorithm"
  drm/amd/display: update blank state on ODM changes
  drm/amd/display: always switch off ODM before committing more streams
  drm/amd/display: add comments to add plane functions
  drm/amd/display: rename function to add otg master for stream
  drm/amd/display: add new resource interface for acquiring sec opp
    heads and release pipe
  drm/amd/display: add new resource interfaces to update odm mpc slice
    count
  drm/amd/display: add more pipe resource interfaces
  drm/amd/display: use new pipe allocation interface in dcn32 fpu
  drm/amd/display: switch to new ODM policy for windowed MPO ODM support
  drm/amd/display: add pipe topology update log
  drm/amd/display: fix pipe topology logging error

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   36 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    1 +
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   20 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   68 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   35 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 1473 +++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   59 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   22 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |    4 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |    1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |    1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |    1 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |    1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |    1 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |    1 +
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |   32 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |    1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |   24 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |    1 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |    1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   25 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h |    1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  274 ++-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   12 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   46 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |    1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    6 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  491 ++++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   11 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  262 ++-
 .../drm/amd/display/dc/link/link_factory.c    |    4 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    8 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    3 +-
 36 files changed, 2220 insertions(+), 713 deletions(-)

-- 
2.41.0

