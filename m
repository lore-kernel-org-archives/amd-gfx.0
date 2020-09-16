Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB51C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BF1208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ft9o0lGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BF1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300876E075;
	Wed, 16 Sep 2020 19:42:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5754B6E075
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwPS14jBBtZijmnHql3yZfQifoZmvgqOF2qR6Y5QxmjPNdlsPNt0niSViiIvzhGwAkrhRkb7r5ntH/NNu0J+MdhakLp0dnlWRfGnvuDyvV10qka8A5WlOq4kwLHSyMM8rwObjxUwKifzZL7aAV1SQNarPgrs5uSC/2B5N8E4dqLTu/z3XNndkzSyhn3GMuQzMUztAwE/rVgnSpfmMPubzx5P/x54F6ylm7WUqoWDIki73dcXYKDhuFA47GntnsJN29VgXfCMrvYL6pEHAFlUppmQqCHVzytHtGFRkTSiCayQc3QJS/RlzEm4kiThfIfWdwzAs2Fgq4oi+sXjOIyChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73broj28t+JIgQjILl+rPyEwTufuZxKNZudd4Q1yi3A=;
 b=eGhBiuGH+XxdJi2phthJnOUq3ABhzE1dIF3B+6nuruagTj2R9ExqQXZWSvkStn56Ng3xyFTLhNhZVZG57f9PHc1d3fdJM7tvdrH91MnsFEp9I88ar75ondH47Wi1CgWxQil7UXnkh+mkom3OlqtCIxn+aXP+hXJK71tCA1luZ3cr+JmtPJK4sP3R/kraJKZ7sIkJm2zOE8/6OHyJMlqflgmzCP4Ge5/V7DzP41ARc7dnwY2bnq4oHibbsenMlSSoQweeiwWgUI3joUspuAh07ct0Gbv56QI8XWF+8BVYb2On0BNdy4fFS0aZh33LInnIBA4J3OP3Kf2eOeKAdOSOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73broj28t+JIgQjILl+rPyEwTufuZxKNZudd4Q1yi3A=;
 b=ft9o0lGMY24KpgHTzOZoTUOCRw5Osmw3tLw6Sm+uiwsxGQgTwCXwq5WC7pF1l0N/oIMVNNf7wbZbU07+zK3844kYm1lHbiqUEyOYN7KnxosRg9r22Jn16GrnsBdZ4SvOdy4qY3PVZuApQSYNSzYd6jP+XD2n8fKfUqegBYULFNY=
Received: from DM5PR04CA0040.namprd04.prod.outlook.com (2603:10b6:3:12b::26)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 16 Sep
 2020 19:36:36 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::e3) by DM5PR04CA0040.outlook.office365.com
 (2603:10b6:3:12b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:36 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:36 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:35 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/15] DC Patches September 21, 2020
Date: Wed, 16 Sep 2020 15:36:20 -0400
Message-ID: <20200916193635.5169-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc5ce46-dbac-4178-7b32-08d85a77d35c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4120:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41209CE08F3861E8D579DAE1FB210@CH2PR12MB4120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xIXy9zCp0g5CZFsSrtCocsjvFZPYHf+UrGCgKTkkXDulgwpBf2fp/wmRY3M49zS5fafVPgzyp8K3oPd77a/lRyoo4QPEfcEIPB+Xu3YA7AiBbMNVxMTpnn7buv6+zOwp34xt8ZaKJ2GFwUROFIY7MqwSHAdRrkrvaCWs8VLRGrwz69l+cI+JwEYTOCHiI8cfwGnUECHTsukBN9A1WamMJBBhhqITBKrA74GmQC14Dm2ojiFN2fjohAcn4O+dZfy4xBE9Nn5fPYyEOtOD5qXHZ9wdlQSo8At0q3pAQDCz32U9EZhNLEFsZsCF7VNxHHySOnc1DQWbIl9UTg4vNP9HBxjvQugNK5pa2XkB9hiGWZra1gPeM5ceJHAACStY93qDBB6uMHEmq8W8Td/a44CiMegUI1dLwGN19m5euq7gxH0VixEaQsMG796H/vadfIpb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39850400004)(46966005)(316002)(44832011)(54906003)(2906002)(6916009)(186003)(8676002)(1076003)(426003)(6666004)(5660300002)(36756003)(8936002)(70206006)(70586007)(336012)(26005)(4326008)(356005)(47076004)(82740400003)(478600001)(2616005)(82310400003)(81166007)(83380400001)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:36.5767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc5ce46-dbac-4178-7b32-08d85a77d35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* DC version 3.2.104.
* DMUB Firmware release 0.0.34.
* Improve on HDMI fallback mechanism.
* Enable DP YCbCr420 mode support for DCN10 ASICs.
* Bug fixes for backlight, ODM, eDP and others.

------

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.33
  drm/amd/display: [FW Promotion] Release 0.0.34

Aric Cyr (2):
  drm/amd/display: 3.2.103
  drm/amd/display: 3.2.104

Chris Park (1):
  drm/amd/display: TMDS Fallback transition

David Galiffi (1):
  drm/amd/display: Fix incorrect backlight register offset for DCN

Gary Li (1):
  drm/amd/display: Enable DP YCbCr420 mode support for DCN10

Peikang Zhang (2):
  drm/amd/display: Bug in dce_is_panel_backlight_on()
  drm/amd/display: eDP intermittent black screen during PnP

Taimur Hassan (1):
  drm/amd/display: Check for flip pending before locking pipes.

Wenjing Liu (1):
  drm/amd/display: allow DP RX to use more cr aux rd interval delay

Wesley Chalmers (2):
  drm/amd/display: Fix ODM policy implementation
  drm/amd/display: Increase timeout for DP Disable

Wyatt Wood (1):
  drm/amd/display: Implement PSR wait for enable/disable

jinlong zhang (1):
  drm/amd/display: Replace msleep with udelay while read edid return
    defer.

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 13 +++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 11 ++------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 19 ++++++++++++-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  2 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 11 ++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  2 ++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  2 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   | 10 ++++---
 .../drm/amd/display/dc/dce/dce_panel_cntl.h   |  6 ++++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 27 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 12 +++++++--
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  2 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  4 +--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 11 +++++---
 24 files changed, 113 insertions(+), 34 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
