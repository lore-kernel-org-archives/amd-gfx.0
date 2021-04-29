Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958B9C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCB1613F7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCB1613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985936ED6B;
	Thu, 29 Apr 2021 07:54:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFC56ED6B
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3CaYokRo7CuyDgFOBxzykEciPURSpplANQF/0BsbKGZOhjhNmaqQcDSamSDid/KJ08eA7MhP1JrAyO6E5728mZ3MNLUvLQD2jogJTQHVTbYtJ2GOfItAms24tp2eRY6qxg78aX42b5BRQlDm3Em9IPh0qHJrChN5xr2QNfYeNTfYB2+lEAjESOGPs89S4ZLkTDUsVZOn9mn7bAZWcnqonPTmSzx/YN1SPOyhRveCgnEaDLICELKlqYiy7BVAKfXD6M/n84+2uqjinhVDE+80i3toFLK6oD7gbpwsRciPx5vvA/aPbe9PcxUZ1LyRIIrLvxJNK8yKLLDlh+uaByQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF4BhKWcZVfblZrK7NoHzWX1zwttX+7s/h8Y6CqSMVM=;
 b=iRQOQ/6kpGCV/D4OTTGi/cruRCda1N8bbvEB3XCp+i37TwuaCoAjrqLbJTQ2WJaYlG43iCTZ31MDIk/yro966RRYi7nCVjhcr5ITiPDAun8IehSd28YTlPPgEg+5P/Sj39KtT9xNrckQglmX9mdcGQSNKBHe7g3Q1bJvOgRAt4PD+ytJKEBTtztZJotmah6wFF2v2bqOx0m+NP+SzQBFWcxZzXy+cgUpHOTLP0Tm2YFM79N0FVDpxc/ofkrRJtZD2L0Hyf1wIafx6W2pmchCo7ezjMaK7e+7crk6Ay7P9pI9a/WKyrgIh9MHLWg9hC9SpckNeRtn8UJNZbQ3H25vCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF4BhKWcZVfblZrK7NoHzWX1zwttX+7s/h8Y6CqSMVM=;
 b=rCACkpDcOlKitAWJfPfBsfzUbKAvzuFGakZ60ePDDHzQ1Z77/PLint9fp8J2Anh7xgFGiRF+6W6FMcMZUwYRyFXwvr4YLLQCPHxCSEr50cdQoIFICSHDnOgv+yTCTQErxHka1ZLcWt27/KCWtakLE/gVXDyDrrYM3ZvbaP8qx7Q=
Received: from DM6PR05CA0056.namprd05.prod.outlook.com (2603:10b6:5:335::25)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 07:54:06 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::7d) by DM6PR05CA0056.outlook.office365.com
 (2603:10b6:5:335::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:04 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:02 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches May 03, 2021
Date: Thu, 29 Apr 2021 15:51:52 +0800
Message-ID: <20210429075206.15974-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9334785d-2101-4981-8722-08d90ae3f676
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2411FDF971C3BBD29CC2C145FC5F9@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbeU9SprNoqsgyG71cqgBv2Vd37ujl+u1w7yswfMRThAfOQTqa7lhn28vm8Smn84W757FnlD6fo/beCn8JXlQzK3DSpQeBfvsJJIJ5+cvbW1+WW2LYMSTCI8ow8A7SQvdghfyL1FSMdY9i0BtvgyADYfUM53fBqmIHUk+EY6jlBqFk7E6H1wS1jAUJmvdUAiMdVWj9OReiOmPxI28yBmUZEwZUSKiL91JH+zS3u7zHjGSuSDLHqBxq9FvtEWTht0UaOkWAziB0eCVm1b+c5uh3yklDMBiuMj/q/hdZDKoxkpe8FqiQkrQi8UinjDx+MePNTeSUL4ztGN4qgx4e2MEwcanRUz2NKnPZ9PUiOjJzp342xwGWpRcuLqyLOgQoJapCVEfJNZjFu3aOQD3/RJLzqsgvf+5g81cpnSBOqiouoJ5jZdh6ZnTDD6sY0NuVIZUtc+Z5lSLLIKOq7ZnT1BaDKMvZWeAz7juqss9RsSqagRcglFNvwD6Ny9sHUOPxuakbfIwOmNu1ZP0eVi+3KpNFMOpkJSBF86K3BuR4E/dEWyg/6x+M0UygqRVpmNozhPUcW5z8JrmOx2KYojmn2EWazkHWbZPCYH21kVx9cX8N5uvLpwZ+G2i7JdOIwJUZK4/lLcNWL20EkliwtWqfGvX8gq57jkc7+QQ/trOKgxbnQa9MQJtUiIi0bhA89slA0+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(36840700001)(82310400003)(83380400001)(82740400003)(1076003)(5660300002)(54906003)(6916009)(356005)(81166007)(426003)(36860700001)(316002)(4326008)(2616005)(26005)(70586007)(70206006)(7696005)(6666004)(186003)(86362001)(36756003)(8676002)(47076005)(336012)(8936002)(2906002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:05.7513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9334785d-2101-4981-8722-08d90ae3f676
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we 
highlight:

* DC v3.2.134
* Fw v0.0.64
* Improvements across DP, eDP, DMUB, DSC, etc

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.64

Aric Cyr (2):
  dc: Revert commit "treat memory as a single-channel"
  drm/amd/display: 3.2.134

Calvin Hou (1):
  drm/amd/display: remove checking sink in is_timing_changed

Dale Zhao (1):
  drm/amd/display: Add audio support for DFP type of active branch is DP
    case

Eric Yang (1):
  drm/amd/display: Extend DMUB HW params to allow DM to specify boot
    options

George Shen (1):
  drm/amd/display: Filter out YCbCr420 timing if VSC SDP not supported

Jude Shih (1):
  drm/amd/display: Support for DMUB AUX

Mikita Lipski (1):
  drm/amd/display: multi-eDP backlight support

Paul Hsieh (1):
  drm/amd/display: update DCN to use new surface programming

Paul Wu (1):
  drm/amd/display: Set stream_count to 0 when
    dc_resource_state_destruct.

Roman Li (1):
  drm/amd/display: fix potential gpu reset deadlock

Wenjing Liu (1):
  drm/amd/display: add dsc stream overhead for dp only

Zhan Liu (1):
  drm/amd/display: Avoid gpio conflict on MST branch

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 250 +++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  86 +++---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  13 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  27 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  48 +---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  20 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   5 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  20 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   7 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  19 ++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |   3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 155 ++---------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   5 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   9 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  41 ++-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |   1 +
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  18 +-
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  37 +--
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   4 +
 34 files changed, 448 insertions(+), 376 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
