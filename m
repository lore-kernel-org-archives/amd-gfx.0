Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83836C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7BB10E46B;
	Wed, 31 May 2023 04:48:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8192510E46C
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1OvKi6osCBtZJVsS/prFNjRh4QHxT4TwQdA2uuW9ke0+thOvzgJx01lgjxmz9dxSU1vokpHruyT2ak8nMfEvtY2P79YtWkWcofqNHTqLxYnVZZNJf6D6RJqYrjFWCRnlpCY/zyO6nsM/7axPOHk+XBzJkqNfrAE9Snr1mM24aE2+uQ51l1bUKJZgQGWt3n60tblKohcf+A/o7PfjkKzNEFTIjcwv+UiIPhDjqUbs2ewxZ0G++IyAnDtYN70PddMVnEkBrmMjHgq2XngwEnj5bwXvLc2MZUifHX64krltjTtlwvFsiNMs+ZCM4DTw7U/3F8NvItAnXAfvTIIi3QYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixVO3PS/noIwURD4dE4JsN2pdvbpxgDUmbNgEUk8s1Y=;
 b=Pa/2u2CQ7cf7+ShOe4vaf02Ugz7dH8JeB/ivEcwt3vhpLkiLzg/fz7wCOcNyOym+fDSsafCNDcVeiUQpWefcYTHvK5S0UmgcxaZryih3tx+nqIuw9xEJV4gW7SbsR0ioYkS7BffIHYgP50DpeS6ueos2H6MD4oi9+BtZGC3suDXdgIkLg5ib+6KgZRIFBuB5ohnjy/DEpOpZfd9uzk83rg+SJMTwXh5UEFlX8PPR7FrMUl40XGLiPqVoH/LKiKO61d6U8R3906ojD3xXrx1TacIEYxpybMUn8lqgVHwApRpoILFMSSX7Rc8YGagqpbadCOCFXR2PZ/gpmcizdX8ZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixVO3PS/noIwURD4dE4JsN2pdvbpxgDUmbNgEUk8s1Y=;
 b=cotk9j+LB3XGc4QYWKTg1W4wNts27vkFZfGPmX66YSgbmH9ibg5kTjnfr8777RCuMmTt8J0GbC2lWyUx/moiHbZanx1myHmJs61I3XbgXmsBOIGhjn2p4k03unI0+0vbV5v4UVM+bwybUradp11gQ2uqUHLOpV+X8gy982iIPYs=
Received: from BN9PR03CA0568.namprd03.prod.outlook.com (2603:10b6:408:138::33)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Wed, 31 May
 2023 04:48:47 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::4d) by BN9PR03CA0568.outlook.office365.com
 (2603:10b6:408:138::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 04:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:48:46 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:48:42 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches June 2, 2023
Date: Wed, 31 May 2023 12:47:59 +0800
Message-ID: <20230531044813.145361-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b245cc0-a763-4b83-2083-08db61925198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBa/9PNQfM3PYWk82p62jnWpunKtvP+zgdBiY+805Kg60J+PCYRCAEukS9ogslxf6OWerTFKgI4g4nC+TX5JLJIQtRD0AsApeeM/S+r+4fdPKlHoOhZZkr0TPvJfSVuf/wkkNkWUqn5iACtBk4F/5jwSLk7+KQX5riB3ZzZrqaTXuVAmpdszIRF14+/45icNHLgk8mX3acf5S/9S3RAA4myQUBJAWfmkBIbqF3hYBy87u8QwpHjlU0LFoJTTFa6YuM6b8uH1Zr5w4lD8gqEapeoQmjV0gJZrDHQCFtJ3YCYIdgbconqj3WKFaij3jysNcwTLLuiRIKHGewrhX4fSwTdnxsxFbtWp1wLuOMxJu4OFEbpKabqw1EdnBzC8M/FcuRC7q+BVhYSiyfU3CQuNm2rez13G6odylgHfNWxPOcxsrdXJ6UzkhBvo80Okg0fNzBq5CuhOsJFNOD4wp/+xKzfbFsq5inBxk+82DP3vyk9WGi8UY4zxKJpwBPiTJm9okVVh5INCDaFcmvQAG1zN6gOYzIP0hcOXvJWQc2+07ZkqSxlZcqSZBPapTCwqXPCDaAMJddC1elBmB3481i5sMsbfgYenlczfx/eT0i+CbqNIRE+1BotfSkHnAiic9TEL4iVODIF7OtwE7+JXutrisiRX/Uho5qLQUo/GUyzRIHhF8xlbGSYMOfVNBuQQ3u4buFk7TVFggbfyaYyYzNclD2NBOLDxL3/6SkAdM3wYakEsqbbYvuIPWIhXSeDp0l56e6H3Cvk6GAH0GdfBsoJ+WA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(70586007)(70206006)(6916009)(478600001)(40480700001)(54906003)(356005)(82740400003)(4326008)(81166007)(316002)(7696005)(40460700003)(41300700001)(47076005)(6666004)(44832011)(36756003)(26005)(426003)(1076003)(336012)(36860700001)(8936002)(8676002)(83380400001)(2906002)(5660300002)(16526019)(86362001)(2616005)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:48:46.4632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b245cc0-a763-4b83-2083-08db61925198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835
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
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Clock optimiation for DCN 3.1.4
* Performance improvements
* Improvements on power saving
* Fix screen flash in high resolution displays
* Enable Freesync video mode by default
* Bug fixed on hang or crashes in various cases
* Improved code robustness in corner cases

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Refactor fast update to use new HWSS build sequence
  drm/amd/display: Reduce sdp bw after urgent to 90%

Aurabindo Pillai (1):
  drm/amd/display: Enable Freesync Video Mode by default

Austin Zheng (1):
  drm/amd/display: Filter out AC mode frequencies on DC mode systems

Charlene Liu (1):
  drm/amd/display: add NULL pointer check

Daniel Miess (1):
  drm/amd/display: Enable dcn314 DPP RCO

Dmytro Laktyushkin (2):
  drm/amd/display: fix seamless odm transitions
  drm/amd/display: fix dcn315 single stream crb allocation

Leo Ma (1):
  Revert "drm/amd/display: cache trace buffer size"

Max Tseng (1):
  drm/amd/display: Add control flag to dc_stream_state to skip eDP BL
    off/link off

Nicholas Kazlauskas (1):
  drm/amd/display: Skip DPP DTO update if root clock is gated

Saaem Rizvi (1):
  drm/amd/display: Wrong index type for pipe iterator

Samson Tam (1):
  drm/amd/display: add ODM case when looking for first split pipe

Sridevi (1):
  drm/amd/display: DSC Programming Deltas

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  12 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  13 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 307 ++++++++++++++++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 255 +++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  20 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 +
 .../amd/display/dc/dce100/dce100_resource.c   |   5 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   3 +-
 .../amd/display/dc/dce110/dce110_resource.c   |   5 +
 .../amd/display/dc/dce112/dce112_resource.c   |   5 +
 .../amd/display/dc/dce120/dce120_resource.c   |   1 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |   6 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |  29 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h  |  28 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  11 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   1 +
 .../amd/display/dc/dcn201/dcn201_resource.c   |   1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |   8 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   1 +
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |   5 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  16 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |  16 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  26 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h |   1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 142 +++++---
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    | 144 +++++---
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  11 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h | 126 +++++++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   7 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 -
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   2 -
 42 files changed, 1071 insertions(+), 156 deletions(-)

-- 
2.40.1

