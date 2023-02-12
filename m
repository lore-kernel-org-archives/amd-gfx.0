Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C9EC05027
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C322510E1E3;
	Sun, 12 Feb 2023 17:00:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A17710E1E3
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzqnF1Ddtm+hfM+z8Vlnu8JaTezwcESW0ZO+XBvPfO5Q8VdUEOehLVko1YuLXC4N5knvBwL0+IxxiAt3XB1g9FvqkeDz/JBlLRWf7LUbIndD+zUTYVGJ9AG/+WhMOz1G3y2ZK0V8OfyZwHH4kRu7dEaLPceTDedC3UAC5ZqFb2vxMmO4VLKjWuLuB2fHGGZJDrIoHuPJR0D6JZGr/k8j4c9Z02QYYoCbo6zT6hgcS/laniwJc4b5OjV+H96xvlmpyIQNIjYDufMns5grPGeOrMkvb5gRkUganeKV9Zwfnl1rQNmTAWRXwhIz/WSe122ECQv317RBbiMGJkW+k4WYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V913vkMUqtAWUB9qXWZKmZT63hKBWil9F7Qth3NhdzM=;
 b=UJlcDaHTv7N64C3PctCbhxSf8j3yTf5KHszfjxiuuKEe9wX3enNAt/7fm/9IqBVhTMf5Mjc5fUin0i6n5laBVI63T3YjxO+ZBBa60IuPx1CAt/ziuiUaMQtNcXCGrm1lUS9PPxUDtV+9KedSyLj4g3VY4KN96DqkrFr0KYTUhKEE1piPgr0bmcgPJBeygW1hVvwPgrfTYnJhT/j5iTnzl8H33GhBW4Xv1jLixA61bBYkKQRw2WtkVgL6s2N29HdVHq/1PWyUX2oO656dcQcCWuO7ndV96/xgGtlBZpKXX4P60vwhKmE2FHaMT5d9zix3tQHOq+EkKmOaqN+fOUnv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V913vkMUqtAWUB9qXWZKmZT63hKBWil9F7Qth3NhdzM=;
 b=kIKU28tcKyofS2hPwCO8sLtaNaGV6s+YY3pLBU84padxZzzgKaodvnIUE+xH+0Y0YvuOv/dNkZz6Wctg43OD5W1diSmw/AZ8tkKWOZAlP2xwfs0StZe8uNB4m4t44mesJvHjtygO/z1ZUyJqYwM/cxHjxjEYBDP5YjmFAHW1Aaw=
Received: from DS7PR05CA0012.namprd05.prod.outlook.com (2603:10b6:5:3b9::17)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Sun, 12 Feb
 2023 17:00:32 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::61) by DS7PR05CA0012.outlook.office365.com
 (2603:10b6:5:3b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:31 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:30 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/22] DC Patches Feb 13, 2023
Date: Sun, 12 Feb 2023 11:59:33 -0500
Message-ID: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 3100075c-e9ac-40e9-8893-08db0d1aa6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T3ad3nYx+eC35a5+XFZB2qy60VQuw+qUR3BGTwpUS93aR53s68f8oLSzRcMenG3KJHAJYsff7dMs03yspb3jNyVyRgTSI4WytzfARhZ6ep0UrkrVA17Fz6yZQMs9flxDel76CZ+QOVdhKcnk5Ehr/mo00R6B0YQSufyBen2OwEtnFjKlor9w+v2pjPvyGfTGQqa6zkuWe437hLS4kG4qKWmsHrZW7WKCSTY0ZnEObRwARGC2pHaitZSCWNtTclCwXw6D2dO8e0nVNPC+Ai2QhntHKe1SaqQyMy4EYmOP7BS1cJpjH9+OjivADEZrieepJ8TdecGql2JX6TEWwEjnr7SQsYzwHg+nYwwM22/+i7RyTRyTwtDp7Ix6rq1JIJgwIj/qzGCOY7T29qys/OTr7f5GP5mvSMS39jO/CEpZvyffW4iZH7G0sGIHHoA7sS6C9MRwaJbLUmIpktZuirdqYubDsDSNJQqppFGLMBwuu5xLh75Vz9LKOYC5+x4/Y8ETCo/WH4e1vrApvVWVu6KtsDoqlF0xk3fgDw6CO4UdTVYT4VTZw5i7cxIrbAiQHxCxAYaU4GZXr1+rJX2KJpv6UQvE34c0UVpGkdvfd3FOoLN01aQHwTs5mb0YjXMyroHmg6oVAmWueRf5s4/m9LxuM+ZfqfeurDEMjuOt23UOF80eXrMkSYovokLRjgTAM0dKjQEhyTT1rBxARLWNs6eQnRvF9CPnVXIb/9b3JV+kh74=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(66899018)(316002)(356005)(81166007)(36756003)(82740400003)(82310400005)(86362001)(26005)(36860700001)(2616005)(426003)(47076005)(336012)(1076003)(186003)(478600001)(16526019)(83380400001)(8936002)(41300700001)(5660300002)(44832011)(54906003)(2906002)(70206006)(4326008)(40480700001)(6916009)(8676002)(40460700003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:32.1770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3100075c-e9ac-40e9-8893-08db0d1aa6f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- Move domain power control to DMCUB for DCN314
- Enable P-state validation check for DCN314
- Add support for multiple overlay planes
- Fixes in prefetch, k1 k2 divider programming and more
- Code cleanup

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Alvin Lee (2):
  drm/amd/display: Set max vratio for prefetch to 7.9 for YUV420 MPO
  drm/amd/display: Fix prefetch vratio check

Aric Cyr (1):
  drm/amd/display: Promote DAL to 3.2.223

Aurabindo Pillai (1):
  drm/amd/display: fix k1 k2 divider programming for phantom streams

Ayush Gupta (1):
  drm/amd/display: temporary fix for page faulting

Bhawanpreet Lakha (1):
  drm/amd/display: Add support for multiple overlay planes

Charlene Liu (1):
  drm/amd/display: add NULL pointer check

Daniel Miess (1):
  Revert "drm/amd/display: Correct bw_params population"

Leo (Hanghong) Ma (1):
  drm/amd/display: Fix FreeSync active bit issue

Mustapha Ghaddar (1):
  drm/amd/display: upstream link_dp_dpia_bw.c

Nasir Osman (2):
  drm/amd/display: Remove stutter only configurations
  drm/amd/display: Disable unbounded request mode during rotation

Nicholas Kazlauskas (4):
  drm/amd/display: Move DCN314 DOMAIN power control to DMCUB
  drm/amd/display: Enable P-state validation checks for DCN314
  drm/amd/display: Update Z8 SR exit/enter latencies
  drm/amd/display: Disable HUBP/DPP PG on DCN314 for now

Samson Tam (1):
  drm/amd/display: enable DPG when disabling plane for phantom pipe

Tom Chung (1):
  drm/amd/display: Fix video glitch while drag window in PSR-SU

Wenjing Liu (4):
  drm/amd/display: do not set RX back to SST mode for non 0 mst stream
    count
  drm/amd/display: Extract temp drm mst deallocation wa into its own
    function
  drm/amd/display: on dp link lost event toggle dpms for master pipe
    only
  drm/amd/display: move public dc link function implementation to
    dc_link_exports

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  83 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  22 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  31 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  47 +-
 .../drm/amd/display/dc/core/dc_link_exports.c | 103 +++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 211 +++++----
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h |   3 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 136 ++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  60 +--
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 109 ++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  16 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  16 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   3 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  24 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |  61 ++-
 .../amd/display/dc/dcn314/dcn314_resource.h   |   4 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   4 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   2 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   7 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  32 ++
 .../dc/dml/dcn32/display_mode_vba_32.c        |  17 +-
 .../dc/dml/dcn32/display_mode_vba_32.h        |   3 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  31 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   5 +-
 .../amd/display/dc/dml/display_mode_structs.h |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |  18 +
 .../display/dc/link/accessories/link_dp_cts.c |  45 +-
 .../drm/amd/display/dc/link/link_detection.c  |  51 +--
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 220 ++++++++--
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |   5 +
 .../drm/amd/display/dc/link/link_resource.c   |  41 +-
 .../drm/amd/display/dc/link/link_resource.h   |   2 +
 .../drm/amd/display/dc/link/link_validation.c |  14 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       | 413 ++++++++++++++++++
 .../dc/link/protocols/link_dp_dpia_bw.h       |  29 --
 .../dc/link/protocols/link_dp_irq_handler.c   |  46 +-
 .../display/dc/link/protocols/link_dp_phy.c   |  11 -
 .../display/dc/link/protocols/link_dp_phy.h   |   4 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  27 +-
 .../amd/display/modules/freesync/freesync.c   |  12 +-
 48 files changed, 1471 insertions(+), 511 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c

-- 
2.25.1

