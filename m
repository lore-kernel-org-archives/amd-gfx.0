Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C1DC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 19:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BB160F25
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 19:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 72BB160F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0063E6E9B0;
	Fri, 27 Aug 2021 19:02:30 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB6A6E9B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 19:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfN2ivHE6bKmdO8jEyX/AeR5QTmuboUcpr19ucAxZIPBEMKyrhMOVSSM2wHdqWuUX4fvjXwguczGSL3sLKzVdFoRAfz/yOhinEnvXrLjnvZvTJFeOKxOAEBRjLPIDb4Y0ujlCkuIozLXXdXBwsA3gBI1O+O/6i6A5uB9xxbJ4EFx+45A5J09w0aS0Gh9dK/xqIyBWuvisdlyXEuJW8VWk27aAFzyvgBcubFnfWdqOLIY5KUIVOZdCzxSfZL6rDYyDYnpeRY2J0+oevsOf2bWNvLT1s9TSmAaVsqmozjO2JIoi38RadZnlb76kNS+50ZrQ8sA7k282OtZ9xGOeas2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFFKCzQdmn0dASdOYPXzre8L+JVbFuIoaCKBHF2p0+g=;
 b=cERQMFRpdIaMpFVwyfWXeBFQDgf4EyM7zQ2/JthMmLISrO/4JUVPGxXQ+EbK4ja5EYDOmjIXs6N1GSjG3f4tMpOeJ1SxIkozOHVBYHok6ery8QZAIDOui6fAGxmhA21QddgxhCKsv299HbvvX+/c+IfZHzrmpXgHDMjIwJjfG8loQkMG5R80G4vC4KyEjmvi/BOKFMpJQb/C5Ql+Xjrt8fxAt8VUKHHkzjASc0V3irL0oYC1X3Zumt08dmVYqpAol6dnvcHEWJISXSSN236OnZEQzH0ldcDH3scADePn+hGxaLBN2CtHlJAATm/SiMIPuptQK3p79fZ+B8qMPVb4QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFFKCzQdmn0dASdOYPXzre8L+JVbFuIoaCKBHF2p0+g=;
 b=p5zi02TXtUKWz/HpvvbYjOlPvbaCEBb2TN8Wp6cxfn1QkDSidOqB1qZDKVAkEPBcwp9cOtOJjFMfkz/Wi9y58caoL7lbiPZu1xbwLzT3hC7HWl3rCVmERoGx5kl6ttkWYdgkMBiykGATCZSc6kOstUmnhIVdaAvipQinAAv/sAQ=
Received: from BN9PR03CA0505.namprd03.prod.outlook.com (2603:10b6:408:130::30)
 by BN6PR1201MB0034.namprd12.prod.outlook.com (2603:10b6:405:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 18:29:32 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::d3) by BN9PR03CA0505.outlook.office365.com
 (2603:10b6:408:130::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Fri, 27 Aug 2021 18:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 18:29:32 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 13:29:30 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>
Subject: [PATCH 00/19] DC Patches August 23, 2021
Date: Fri, 27 Aug 2021 14:29:04 -0400
Message-ID: <20210827182923.17341-1-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1a1a748-c3bc-4168-17e0-08d969889d31
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0034:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB003432CF6CB1C67DA4771BEDE4C89@BN6PR1201MB0034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7P8dBaAAZea4Kgw/ox+o+szLKO8Wt7/shPQ/ksrWBrj/5SWy0OlLzLqImeRVg7Y1yKAnvooObL/cVlBioam7pjXkJ+Zjv71cPqBtQivptEtKEg6uMfkSykU6qaVdTPajByZkY4VGUkqP94FFQuzqXgJv3o/70rGi5Dqafn7FgcFD2Ssx/gjjyVySlG/XiTy0ZS68/dc1+a+n5gBdUpk+CoA2kVFqdEIT9KK5BXXK7wDO8Kgpo2zZL60u5zb6vRS+kP4uBiaFJKBCvAK1ON/jfaWZgyc0a0HPylxLohGxCiLFO2MCY3rALTcbDyaTxdeh0+7ZOmc2GFMighV/QdrEHXgR7SX5iLz/r9pLbYOaXIlcn48whcfdyg1xIBTwugPNoqHMBBmQ+8oFzNvtU+FjQJl+x/KacqvKC7x8El0qTaYGGgJBmd7ln4S9o9YlIY0fSBsOVitJtjnJ6qiD9/iCKZdjD+LnaPEhsfRe2BKZWStbQZnbTWGKW4TkexpkDbNzSDZx3z2NV25RcLYHJZQxj6iaJO1HvBkGuYg6tN3W8Mfy7XGvdvgA6QoTCsd+JbwIyYCWu9GeD3SL0owfY7r/zS/o2VnGQX3S0uUqCA12Sk6ROHw+4/HvbC4DhDoi0ThYcZmK1CmuzxtPXK+WSJPQT0/v6yL2/eAeYq1zcKboBpHlT55MubbEZQKy+jk/Gh8r3SVr1uIgLptE4dInRfsbMzU0/MvXWCwhunfVeoVI3YA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(82740400003)(26005)(36756003)(5660300002)(186003)(70206006)(4326008)(54906003)(426003)(16526019)(2616005)(70586007)(356005)(316002)(44832011)(6666004)(83380400001)(81166007)(336012)(2906002)(47076005)(86362001)(478600001)(82310400003)(6916009)(1076003)(36860700001)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 18:29:32.2915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a1a748-c3bc-4168-17e0-08d969889d31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0034
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

* Memory leak fixes and false positive warnings removed caught by coverity

* Backlight fix for Carrizo/Stoney laptops

* Unblocking ABM when ODM is enabled on DCN31 and up

* Fork thread to offload work of hpd_rx_irq to avoid deadlocks

* Expose DSC overhead bw parameter to DM


Angus Wang (1):
  drm/amd/display: cleanup idents after a revert

Anson Jacob (3):
  drm/amd/display: Fix false BAD_FREE warning from Coverity
  drm/amd/display: Fix multiple memory leaks reported by coverity
  drm/amd/display: Revert "Directly retrain link from debugfs"

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.81

Aric Cyr (1):
  drm/amd/display: 3.2.151

Aurabindo Pillai (1):
  drm/amd/display: Add flag to detect dpms force off during HPD

Harry Wentland (1):
  drm/amd/display: Get backlight from PWM if DMCU is not initialized

Jaehyun Chung (1):
  drm/amd/display: Add regamma/degamma coefficients and set sRGB when TF
    is BT709

Josip Pavic (1):
  drm/amd/display: unblock abm when odm is enabled only on configs that
    support it

Leo (Hanghong) Ma (2):
  drm/amd/display: Add DPCD writes at key points
  drm/amd/display: Fix system hang at boot

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for null pointer access for ddc pin and aux
    engine.

Michael Strauss (1):
  drm/amd/display: Initialize lt_settings on instantiation

Oliver Logush (1):
  drm/amd/display: Drop unused privacy_mask setters and getters

Wayne Lin (2):
  drm/amd/display: Add option to defer works of hpd_rx_irq
  drm/amd/display: Fork thread to offload work of hpd_rx_irq

Wenjing Liu (2):
  drm/amd/display: expose dsc overhead bw in dc dsc header
  drm/amd/display: move bpp range decision in decide dsc bw range
    function

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 222 ++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  51 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  16 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  23 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  98 +++++---
 .../drm/amd/display/dc/core/dc_link_dpcd.c    |  11 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  13 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   9 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  12 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |  10 -
 .../amd/display/dc/dce/dce_stream_encoder.c   |   2 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |  46 +++-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   4 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  10 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |   2 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  10 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   5 +
 .../display/dc/dcn20/dcn20_stream_encoder.h   |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   6 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   6 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   6 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  17 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   1 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   6 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 196 ++++++++--------
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   6 -
 .../amd/display/dc/inc/hw/stream_encoder.h    |   2 +
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   1 +
 .../dc/virtual/virtual_stream_encoder.c       |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   2 +-
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 +
 .../amd/display/include/link_service_types.h  |  16 ++
 .../amd/display/modules/color/color_gamma.c   |  60 +++--
 40 files changed, 627 insertions(+), 272 deletions(-)

-- 
2.25.1

