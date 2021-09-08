Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D7C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AAE460724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4AAE460724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB6B6E170;
	Wed,  8 Sep 2021 14:54:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414686E12D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl2YMV2FIA3bG4d1cGXSC93KfmktinQtFBBC4Q+KfFWWeYN/PY/lxAhiHexUyPDJIACRXIyG/WK1+hgvm8oSthhNVRdc/kgu7YpV2chjzIubCigES6OnQlNhbn9XYExc6oEtx82iHzh5eEkWPLokzzwepkAxdk2b3qoXDFHoLLyLQkiXQQBy86iHjr88SIcPTJmym5p0k3BQ57yBUkzHTRQlD8oxmIgbebQD1V8fR7OBYBDaY6jlvGU4WoDqzl87z4kFDVsuBSBmd6FGrKeGqtdTrsnLrHXYXH1sDjEpsK6qDVDicbsn5n81K/+9JbiIarmJHVavNKHZgOcwG6nvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S52FV5S0gHGiX7pF4+867hVwSmtH4MEb1N0tVjpMVk=;
 b=bGXQuQSVvxvaj+QHbBahui+IzBNMnI0nbm1uQc5mdKT+eHT5VUQ7a3ht6/dTamdi8qZAo0AZ4WN/f5oSO8sfhJyINLM1pYRjzqGSpZK3Fv7qjJxQ9bu9T33LUmFrY2l30a2woNP8YZFScdsGsgwiL+QoZy7tulx+qtiLJgKzQyUMDJaAnMAMFdawNZQahKX1xbcb7zJReIO/3JTTbX8E9Owets8ctsEk+EQeVP5Qpq6wrFZDAKU6TDh4IgX58oRwHaxEOlpQ6wewFW8BUS+W2p4vXV2ylqdZxDCa/ritr6Rvy7Gz6Jkx+ddzCZA9OZdnynAgK0IOezI2bbkOTgC5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S52FV5S0gHGiX7pF4+867hVwSmtH4MEb1N0tVjpMVk=;
 b=zIRzbfXRRKIvZ7SX61ypv+YWelt3Bfb6w+FRZGhoKcN2rR/ZJnkYopwFRiB8Gi1wiWcrs+RvIKXeymPwzK7a+VjbAHNu5L4PpEvXmC6h9Y6V1pErx/gQZhwaz+g0hI0dLJbcfqGYm8Qz6NBWFzCsDWXrs+UDLGypPcj871JLXk0=
Received: from DM5PR07CA0110.namprd07.prod.outlook.com (2603:10b6:4:ae::39) by
 BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Wed, 8 Sep
 2021 14:54:35 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::a7) by DM5PR07CA0110.outlook.office365.com
 (2603:10b6:4:ae::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:35 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:32 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>
Subject: [PATCH 00/33] DC Patches September 08, 2021
Date: Wed, 8 Sep 2021 10:53:51 -0400
Message-ID: <20210908145424.3311-1-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d70cd94-6248-4807-7b56-08d972d892d0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53779ECF801CD751FEB8E5F3E4D49@BL1PR12MB5377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/bah6AKv54zRlmjwZwIBWtY1spTcEedPBdeZd7vMGyHlZM34Y/eBMGpL4gddWN+Lw8R2X4ILtmUK6M3olITSU8bFFAhHGYMg1x3y9nyDi9JqhGAtgjOGSA9dw86dRI7gUQhwzY9bFtsCH16/xxRX4IMFeEpRont7BUCXu9adZsDke0WJlhnyEcH1Dz3lq4t2kYNgQpPXyDvQ0g/WDV1F8IjZUrLlWnHHSEBJ/UzbjHBhu5wLFTrRtN6i9lBrDgBQA4AL+mObEdQrHdULKSpJVYLWoLSm5vbgeU71rTW3KEYOBtLwKTCgeQDESQA2fL9YCRl786GWGlN6qARsKPpEj/000fbP0kc0uANsthiAo+iYyDOvOJ5i/77eOzDtODQAPlsck6d2DJZBPTjjFOBOBwlPmrMRed+WEvcOacr14KkDSh0Z8E3dkaRz+iiRukqXmY1EV+FO+cQCG1lLWg77XbPXEdHGncpyJSFECGa2Jb0xPYFonkYXyq3g5xWqDslrh9AXq5lYVBMQv6wJs83Dzvf24+sKKcnh+CYExBr5OuG4lDiRiP/A4Rs0QGMGfWy8xTjsnmfDdlCYPdmQ9Msuy6wyff0iOhpxwycB3BbXI4GuTNjYGxHk+nbICxhoxjZ/1t7wJaRzVljMlgjDyyyBzK0RsDzvTMvRbco/OazAn/sZy2aDMCCszbyVKqyZwTjitVNzJgrFNFnOKSQXLJzKZdRlHJGmUvc2MkU4QgCVdU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(36756003)(8676002)(6666004)(44832011)(4326008)(26005)(36860700001)(82310400003)(336012)(16526019)(356005)(2906002)(70586007)(8936002)(47076005)(186003)(70206006)(5660300002)(2616005)(86362001)(426003)(1076003)(6916009)(478600001)(81166007)(316002)(82740400003)(83380400001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:35.0335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d70cd94-6248-4807-7b56-08d972d892d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* bandwidth optimizations on following fast updates
* fixes and code improvements of DP connector blanking
* add thread to offload work of MST HPD IRQ function
* fix gamma coefficients
* provide backlight support for APUs without DMUB support
* coverity memory leak and warning fixes
* DSC MST bandwidth calculation fixes
* DMUB enhances

Anson Jacob (3):
  drm/amd/display: Fix false BAD_FREE warning from Coverity
  drm/amd/display: Fix multiple memory leaks reported by coverity
  drm/amd/display: Revert "Directly retrain link from debugfs"

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.81
  drm/amd/display: [FW Promotion] Release 0.0.82

Aric Cyr (2):
  drm/amd/display: 3.2.151
  drm/amd/display: 3.2.152

Aurabindo Pillai (1):
  drm/amd/display: Add flag to detect dpms force off during HPD

Dale Zhao (1):
  drm/amd/display: Refine condition of cursor visibility for pipe-split

Eric Yang (1):
  drm/amd/display: Add periodic detection when zstate is enabled

Harry Wentland (1):
  drm/amd/display: Get backlight from PWM if DMCU is not initialized

Hersen Wu (1):
  drm/amd/display: dsc mst 2 4K displays go dark with 2 lane HBR3

Ian Chen (1):
  drm/amd/display: remove force_enable_edp_fec param.

Jaehyun Chung (3):
  drm/amd/display: Add regamma/degamma coefficients and set sRGB when TF
    is BT709
  drm/amd/display: Correct degamma coefficients
  drm/amd/display: Revert adding degamma coefficients

Jimmy Kizito (1):
  drm/amd/display: Fix dynamic link encoder access.

Josip Pavic (1):
  drm/amd/display: unblock abm when odm is enabled only on configs that
    support it

Leo (Hanghong) Ma (3):
  drm/amd/display: Add DPCD writes at key points
  drm/amd/display: Fix system hang at boot
  drm/amd/display: Add helper for blanking all dp displays

Meenakshikumar Somasundaram (2):
  drm/amd/display: Fix for null pointer access for ddc pin and aux
    engine.
  drm/amd/display: Link training retry fix for abort case

Michael Strauss (2):
  drm/amd/display: Add VPG and AFMT low power support for DCN3.1
  drm/amd/display: Enable mem low power control for DCN3.1 sub-IP blocks

Nicholas Kazlauskas (1):
  drm/amd/display: Optimize bandwidth on following fast update

Qingqing Zhuo (3):
  drm/amd/display: Revert "dc: w/a for hard hang on HPD on native DP"
  drm/amd/display: Apply w/a for hard hang on HPD
  drm/amd/display: Fix unstable HPCP compliance on Chrome Barcelo

Wayne Lin (2):
  drm/amd/display: Add option to defer works of hpd_rx_irq
  drm/amd/display: Fork thread to offload work of hpd_rx_irq

Wenjing Liu (2):
  drm/amd/display: move bpp range decision in decide dsc bw range
    function
  drm/amd/display: update conditions to do dfp cap ext validation

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 266 ++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  51 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  11 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  16 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  31 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 139 ++++++++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 138 ++++++---
 .../drm/amd/display/dc/core/dc_link_dpcd.c    |  11 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |  25 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  20 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   3 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  10 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  12 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |  10 -
 .../amd/display/dc/dce/dce_stream_encoder.c   |   2 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  55 ++--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  86 ++----
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   2 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  20 ++
 .../display/dc/dcn10/dcn10_stream_encoder.h   |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  23 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  20 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   5 +
 .../display/dc/dcn20/dcn20_stream_encoder.h   |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c |  24 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.h |  24 ++
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   2 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  39 +--
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   6 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  |  11 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   6 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   3 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_afmt.c |  92 ++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_afmt.h | 126 +++++++++
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  60 +---
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  74 +++--
 .../gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c  |  87 ++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_vpg.h  | 162 +++++++++++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   4 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 126 +++++----
 .../amd/display/dc/inc/hw/stream_encoder.h    |   2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |   5 +
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   1 +
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  25 ++
 .../display/dc/irq/dcn21/irq_service_dcn21.h  |   2 +
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   2 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |   4 +
 .../dc/virtual/virtual_stream_encoder.c       |   2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   4 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   8 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  10 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   2 +-
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 +
 .../amd/display/include/link_service_types.h  |  16 ++
 .../amd/display/modules/color/color_gamma.c   |  32 ++-
 70 files changed, 1528 insertions(+), 475 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_afmt.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_afmt.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_vpg.h

-- 
2.25.1

