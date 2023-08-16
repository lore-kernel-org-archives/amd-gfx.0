Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A30C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFB410E2CF;
	Wed, 16 Aug 2023 06:07:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD73310E2CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxtSe4ipI1C0Q4h5yqF9zMf3bnX9GOUZKG5D35Nv9cCY1gXqEqvpmTZ34SsPto1fXbk519707nYxlbzsDn9N0tp1o+gDj231FWpmRoYt/ZQtyUahLNjnlVeDLqUaB5ENWzFR7Q1CzUrgu6u1HCU3kqnAa0wndeCer4csMEa+38gEkAxLBtp8A5NYV7fkqGPK8AbFij55OHYjzLh1IjwboOHQST9fplnbOUZgIwCgx5mZVs7FP/NRQwq9lVxsg+4tRvyhbeCZ1HX3WX7XGM0q7wICfjdzt7BNvAGEU2ytnkOX2O3gnkb82dKH98AW8FGqBsPNj3EfUxyKZ831cXwkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGKvH2VzvTvloW2dv3AIS4qeG1RlhsNuSMrNHVbVUmw=;
 b=mHKTmVtPrhFHBqXJdElxo84clDvSxjM6zc4iXpMQS5pzGSOwolq6DfAy94eeusgBAl6zb1rzY0hTdi+4uQ2wOCoB2I4ENsaHyYgYT6jKAupptzkK2PfkRkCEG39/2SaD6pl5zrolAawkoGeIsP/9ZXMko0tPedNbM2JjTHaFbK8HSQtYjc/KPTlPUNjyym66St74YEc6PLuJT1DyKdn28zIRJtB/dzK/MxB46qdtSYXSdwdGKF2Qwkqet7EyheDOEqZ5VQyeqTrTYb/PDuJD2UINeqf7l7PBx2mcHFMFPVVs6KAhgAYs4conx3uHkQl0YaWQGeLcwH3rQmOpxVN3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGKvH2VzvTvloW2dv3AIS4qeG1RlhsNuSMrNHVbVUmw=;
 b=p1MLhnMbxgSSDJ/1sR4gL7nxnZM7MhiNkn/tPculsTLilH+IQmhL5mFQmqLBYqXO4/b05zK5/cV7PfQa8e83+D4vry3eLE4tMWh6KYd9enmrpCMNowm9UeZI3VE5wSLBZ5qwT2aWMmogiXpBy9YoydrH2f+gi6ifUU2spVAhUkQ=
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:07:12 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:303:86:cafe::6e) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 06:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:07:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:07:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 23:07:11 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:07:01 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches August 18, 2023
Date: Wed, 16 Aug 2023 14:06:42 +0800
Message-ID: <20230816060658.2141009-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 81483a43-2f6d-4d57-4c25-08db9e1f084f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlhO4AfjZgK7fq+8MEtBiJUrJNRVqQLailQf8lV0kJ+EKxj3OXgggjCFOBc0E/hMJlgDVRRMA5nrtL8k92V5xRuQhrWAcl+LWJWZgIYGydazMkh+F7gVhTJ8rhWeduyqImy20Z/qalj7iCpCbg+iS6AL06nEhmV08g6eJDXzzDfTFwTrGerYZJLIOk8GGIROFAUZQdGRcwWQHl1Koc9sCrJTAzBL9dqg8ziEVqIH1eDZa3xAFBODhABaM+PVM7D9gUrOk0CZyL8zsIu1Z8HWrhXc8AG6NNdN4BuXB4KrAqb6YbGkrFoH5JfOU7vnAuAO+EgDxbkHZWYff4wdy5JId0eBhr8/pWwhsr6FgYRKj4KhBhSTj+sUGAL6wgaToHbw/zQEprcnD3SwqXWb5VHJJM5q6NZPFOa5NiPiVeJiNegzjOk/u00bGew7lsGBHWo/A0xDRjGKttsxzhPmgYfzxTSgEg1jcS1qs5+5xIfldnXhm/0PBo9IGI5aQti69+LxYOCnQmkevwUoYguEMqvYs+Vis/kcmJzGGbqup97zTwXsNfB2/ekq4oni+JFtCgpI+vgYq5CPPvtw1nJYWa2EPoH8+9HNodB+zM7ZaUQQRT6Pdz4BQWSnBQ3ciIQbBTxVqGXLFNAk5qmY668Wfr765ag/HQNdoGXbmW30/iuxGB+tjScGbmXuWcD3faZKvSMeIgRgiLzUyA2Q69suIY/AZq1xp3mnjL3UHlSn0kCPwEoM2i5xeww9uzTZ2+61LlVV4DJqUa6xz6ek2gu4Llc6Sg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:07:12.2084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81483a43-2f6d-4d57-4c25-08db9e1f084f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
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
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

- Ensure FS is enabled before sending request to DMUB for FS changes
- Add check for PMFW hard min request complete
- Save addr update in scratch before flip
- Fix static screen detection setting
- Write flip addr to scratch reg for subvp
- set minimum of VBlank_nom
- Correct unit conversion for vstartup
- Roll back unit correction
- Enable runtime register offset init for DCN32 DMUB
- Refactor edp power control
- PQ regamma end point
- PQ tail accuracy
- Blank phantom OTG before enabling
- Expose mall capability

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Alvin Lee (3):
  drm/amd/display: Blank phantom OTG before enabling
  drm/amd/display: Write flip addr to scratch reg for subvp
  drm/amd/display: Save addr update in scratch before flip

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.180.0

Aric Cyr (1):
  drm/amd/display: 3.2.248

Aurabindo Pillai (2):
  drm/amd/display: Expose mall capability
  drm/amd/display: Enable runtime register offset init for DCN32 DMUB

ChunTao Tso (1):
  drm/amd/display: set minimum of VBlank_nom

Ian Chen (1):
  drm/amd/display: Refactor edp power control

Krunoslav Kovac (2):
  drm/amd/display: PQ tail accuracy
  drm/amd/display: PQ regamma end point

Ovidiu Bunea (1):
  drm/amd/display: Roll back unit correction

Reza Amini (1):
  drm/amd/display: Correct unit conversion for vstartup

Samson Tam (2):
  drm/amd/display: add check for PMFW hard min request complete
  drm/amd/display: ensure FS is enabled before sending request to DMUB
    for FS changes

SungHuai Wang (1):
  drm/amd/display: fix static screen detection setting

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  19 +++
 .../drm/amd/display/dc/clk_mgr/dcn32/dalsmc.h |  11 +-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  | 154 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  71 +++-----
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  23 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  22 ++-
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 104 ++++--------
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  17 ++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |   2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  17 --
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |   3 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  46 ++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   5 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   3 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |  21 ++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  18 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  15 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   1 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 +
 .../display/dc/link/protocols/link_dp_phy.c   |   3 +-
 .../link/protocols/link_edp_panel_control.c   |  29 ++++
 .../link/protocols/link_edp_panel_control.h   |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  21 ++-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  64 ++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |  17 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  13 ++
 .../amd/display/modules/color/color_gamma.c   | 115 ++++++++++++-
 39 files changed, 674 insertions(+), 190 deletions(-)

-- 
2.37.3

