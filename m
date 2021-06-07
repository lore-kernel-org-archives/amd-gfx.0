Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD6C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D79A60E0B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D79A60E0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C988D6E926;
	Mon,  7 Jun 2021 16:47:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B72C6E92A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kypVr6DQkxu76x5frs/OKqRND4SP5Jtse069sa9cTdZ72p/ToGq0k3JNkjq9t2vyfDChIAHUi/TXu004B/3Nom0gN0LkaFVF82P0oqlX8uXBXExI67aDUTwiko6gqarTxqfjjfNBeRSYUzmGLJHAubZWRVgZZLaQRcKGJp6sffQp1tbIr1sqVh/1FYNNiaB0lLtTw6khnk/mXHe/Plxp8R/JK7/sGG7+fJhpvGGOOVbfuEQAhdW+hp7jtNu5aT29MW5UGU7gd5ZZrxYJJOzPwouln6qMQdlN/fUTixVutG9UNetrDAkDEiR2/zYJUZRGO8YG3FI2YMshk5ggBA2EWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Siwhq67XIBsX5oDgjbBcRIFlaOzDGyzL2FHV3mbO59I=;
 b=X3yNVnyjDHhETxP7dpB12kYeTmtTZ8NqdlKoyJR1aJMy9qN4s0TsjOuKxMdeFdARCtgE/LD2A/ZfSwxLaJ1JvFj3xrugcLr1p7L5AGr3gYwAd0YC0MQ2HhtDn8n4ZUhKdyw3BzHxjdkgQRQjO3AjuJIqZsJtXocijjoBTV8+zdVpxGTFEGDi2aKoAMm9c0ijAp3wZkUYIdbRFrl+KLJfM+NCBm5j92c2BZiQ7/oPNlYxiFzVzp2XvOg8cpsejjIAFO7ogEhMDnsl60Oi4Y4Ir8hRe5PAY00tn32az6yYhzMMAYgRF04ZiEOg8eAUmsnMWfr1D7pznmtxV7BuI33dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Siwhq67XIBsX5oDgjbBcRIFlaOzDGyzL2FHV3mbO59I=;
 b=ztpKtrQ2IFpgC1OqTKEaauFiFhuH4hyPf0bGyTJC3It6/b8S1WTd/U7mH8f+Fs3HhHMDr79Lwa9RpGr/SNRJnUJsfKlsr0vUsRjJIbxZx1eTFIPuM/lLMonnUY3qPMrwQ81WORR+URphx0ySzkro/yP372FRXfVAJcnW1f35Gfo=
Received: from BN9PR03CA0161.namprd03.prod.outlook.com (2603:10b6:408:f4::16)
 by SN1PR12MB2590.namprd12.prod.outlook.com (2603:10b6:802:2e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Mon, 7 Jun
 2021 16:47:40 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::27) by BN9PR03CA0161.outlook.office365.com
 (2603:10b6:408:f4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Mon, 7 Jun 2021 16:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:47:39 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:47:36 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/30] DC Patches June, 7, 2021
Date: Tue, 8 Jun 2021 00:46:44 +0800
Message-ID: <20210607164714.311325-1-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baa659fa-6b18-4fb0-6359-08d929d3f644
X-MS-TrafficTypeDiagnostic: SN1PR12MB2590:
X-Microsoft-Antispam-PRVS: <SN1PR12MB259077F34258CA024EA99130FF389@SN1PR12MB2590.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbUpcLuxOg+OMo06WOnAut/d22U7bZC+5kNmXF9tPnGAnvV2ceZFG8O/QoS6htw3PIGxHtVXygpmNActMvpW+Be9tfh7vGG08tzS5rFb3vaw/6iIRIe4PynlbHZlvvgSQvcu712yRWS/Cyf+VxfcpIlXm6q49tZWT3rf2q4S4MBhm0xYJ+oBinjonQfdd5fNGSNeED72l2im82TlXM/gv0JYQ5WR6Hzj8isYJRGuFFAuY+LxcTPjnRBxGSABSKWlG1Jk4JEQNd3ihD66xGvq40YDqYrz6TZDeg/ISAvaxfX+1/HwsoURg73m71rVTHPkVI/gQ/WdZiBrlXWLdbWEdfPAg//9L9eqRYYsbg6UXkKIDbOUzlRw+W7XjhmorMkMBACbDaKPYjqJAHcGUZdgAcIzTX98ymMy/1K24L9HFueikkqauW6GquTkh3w9i4jLMIBAA6OqBvxfS11f01p9UVsomso0iQGpC41h1MAJC7FdmE5h18W1ASqUtK+8OvdWyfeBVbVCvT1BYarpWAWcqa1saCPmrW8Iuu1V32CPCTZGS3g+NZcAenZ447SRx5AMK/A/mJ876AOyqYZYG2ZQPbVy8X0nQDNmJ/kFm8mXFmujkep8KQ6Kf/MtsNYqUwG/H/GBQmFEky5i00UGgQegdvrL/yX5Jc7meo1sjsGduwCW5BnVCP6le6Pdl+HrVG9y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(46966006)(36840700001)(70586007)(426003)(83380400001)(336012)(47076005)(70206006)(36860700001)(82310400003)(44832011)(5660300002)(86362001)(2616005)(7696005)(82740400003)(8676002)(36756003)(6916009)(8936002)(2906002)(54906003)(356005)(316002)(4326008)(16526019)(26005)(186003)(1076003)(478600001)(6666004)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:47:39.5726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baa659fa-6b18-4fb0-6359-08d929d3f644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2590
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* DC v3.2.139
* FW v0.0.69
* Improvements across DP, eDP, DMUB, MPO, etc

--

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.68

Aric Cyr (4):
  drm/amd/display: Change default policy for MPO with multidisplay
  drm/amd/display: 3.2.138
  drm/amd/display: Fix crash during MPO + ODM combine mode recalculation
  drm/amd/display: 3.2.139

Dingchen (David) Zhang (1):
  drm/amd/display: force CP to DESIRED when removing display

Eric Bernstein (1):
  drm/amd/display: Updates for ODM Transition Test

Evgenii Krasnikov (1):
  drm/amd/display: add visual confirm colors to differentiate
    layer_index > 0

Fangzhi Zuo (1):
  drm/amd/display: Add debugfs entry for dsc passthrough

Ilya Bakoulin (1):
  drm/amd/display: Revert "Fix clock table filling logic"

Jake Wang (1):
  drm/amd/display: Trigger full update after DCC on/off

Jayendran Ramani (1):
  drm/amd/display: Return last used DRR VTOTAL from DC

Jimmy Kizito (2):
  drm/amd/display: Expand DP module equalization API.
  drm/amd/display: Support mappable encoders when transmitting training
    patterns.

JinZe.Xu (1):
  drm/amd/display: Control power gating by driver.

Meenakshikumar Somasundaram (1):
  drm/amd/display: Remove unused definition of DMUB SET_CONFIG

Mikita Lipski (2):
  drm/amd/display: Enabling PSR support for multiple panels
  drm/amd/display: Enable PSR Residency for multiple panels

Nikola Cornij (1):
  drm/amd/display: Fix DCN 3.01 DSCCLK validation

Po-Ting Chen (1):
  drm/amd/display: Add swizzle visual confirm mode

Roman Li (1):
  drm/amd/display: Update scaling settings on modeset

Roy Chan (1):
  drm/amd/display: Revert "Disconnect non-DP with no EDID"

Vladimir Stempen (1):
  drm/amd/display: Release MST resources on switch from MST to SST

Wenjing Liu (1):
  drm/amd/display: delay 100ms before restart after failing to read
    CP_IRQ

Wesley Chalmers (4):
  drm/amd/display: Add Interface to set FIFO ERRDET SW Override
  drm/amd/display: Add interface for ADD & DROP PIXEL Registers
  drm/amd/display: Set DISPCLK_MAX_ERRDET_CYCLES to 7
  drm/amd/display: Fix off-by-one error in DML

Wyatt Wood (2):
  drm/amd/display: Refactor visual confirm
  drm/amd/display: [FW Promotion] Release 0.0.69

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  50 ++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  15 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  22 ++-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  78 ++++------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  60 +++++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 133 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  47 +++----
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  24 ++--
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  11 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   5 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  41 ++++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  17 ++-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  35 -----
 .../dc/dce110/dce110_timing_generator.c       |   1 +
 .../dc/dce120/dce120_timing_generator.c       |   1 +
 .../display/dc/dce80/dce80_timing_generator.c |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 110 +++------------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  12 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c |  36 +++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.h |  76 +++++++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  47 +++----
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   5 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  10 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |   9 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c |   3 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   3 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  37 ++---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.c |   3 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h |  17 ++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |   6 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../drm/amd/display/dc/dcn301/dcn301_dccg.c   |   3 +
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   3 +-
 .../drm/amd/display/dc/dcn302/dcn302_hwseq.c  |  34 ++---
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  78 ++++------
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   8 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   3 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  17 +++
 .../amd/display/dc/inc/hw_sequencer_private.h |   5 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  96 +++++++++++--
 .../display/modules/hdcp/hdcp2_transition.c   |   2 +-
 59 files changed, 788 insertions(+), 426 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
