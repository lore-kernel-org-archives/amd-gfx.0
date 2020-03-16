Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B6FC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5485F2051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gbNum/rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5485F2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1193E6E429;
	Mon, 16 Mar 2020 13:49:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59A8C6E429
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:49:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWGsW/nuEVQr2F5aRgtg5SP8RjOeTCtl9k4WTPcmLQLj68vd+Scqjn1sIYmOHM3umHRerQ99GPMRwW2bs+vSPWuDoQuvdUAUrp3h5KYd5k0f+P/gWiINbfXOVISK47o/mmySf4eyTtq976eK65cVngR0xZRdr/qa7Ex+APBy/omoSdiw5e2QDc0M7tfiyOL7QFoBb7HIBCJMVXG4FyvBhf5b6Dxa/f7NYf6dvStJqCjikbT/jSivLY5UoZ0p8R5RMXdc0Q+luHxIABKvZaPS4mZxM0KB7Zlg/9z1+ipPdEYCgitserXbQ9x8tm7DtCyAZ+8vywnLGDWtJaYzAb/vpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV4lk5EatuNcq/HRR3AHjL4zoc6mm3FK+L6KgBKKUJ0=;
 b=br95PfUGs8hAjo9Mpr/SOdg/E1qehW6DeQStlRxc4W0ECMJeeIo85Zo4BFYqAGKRlaZu9enHj/sVdzYY0HmOJ4i2bbSV4QyXsdGiU7dTmlQ77isMBNPp/y0NQoh5cmjx0nHgE40XiiH4lu+Yft9y9Qd7MTEGMKAKxl9QOmwZto8522BBOwXT8xvtgKN96Zgi3U7XU7cURKyh4MJrE6LtdtnN5jV3DVwdivMRn5NMN11mfKGZDTF6aJ0yRQdQqTh/yVoVhWWk/IHx79dAmzT3YTnXHTvtmmjRypX2xASVepusvYU9CUY1NhGtEtqcqO3+0HyfG/5uBG1Ep+b4cktnNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fV4lk5EatuNcq/HRR3AHjL4zoc6mm3FK+L6KgBKKUJ0=;
 b=gbNum/rSuJr8XV+EmXI8I/ieRLK0zbWlX0Ar2oEuwRir9jEaWiox+REiD9a2+suRr/X8nCKFlEOv+redxH0s0ZBX+DAm6Jn/XIEYQkUmeS0X5CFXZIk0oYQIWinLtF6oVCaot1KaJI+d+81EMi/yJDhhk0ci3vT+iO1Gv5BV++A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:49:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:49:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/19] DC Patches March 16th, 2020
Date: Mon, 16 Mar 2020 09:49:01 -0400
Message-Id: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:49:51 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47a439b1-8fb1-42b9-d41e-08d7c9b0e6bb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2396ABA7020436C6DBE8FD3598F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DQyo4EHOn9gKXAKNkrHdujkuWqDye9/aIhRUs+ziyDAKCcpoSGD+zr2/wPs/HJej0uo2VTXYnSBS9BW4FNK6KuGtOW+TdOolnSbYzzUPYSyh6lvvkioZSeyozV4+4doZ6FJ9sOCJ/Ft+C5rH0K/a+od5PQu0JQpROuomTe/iFtvorR2h12tN0fpOj7WdeK7ZJvN1/jpegM0pIWHfcXI6or/MMTj/D/SC1jL5ojfppNuyErOQruqC9M8c+W3yT/k0ShaHvuQLCqn//dkzeGcQs+hk2YjBfAe3DHiedT2uZds/ktWy2HoDeMiHkjGv/OqlOOxBODWqF2ZHcrFvQTlWKoPWlN1u7y14TzaffsvAEitzrOrmOJKe96udzIcsMpaxtohn6UMcTZ/VZ6mXiSPX2LsNA5+r1smH8vGETwFiuYTvqFs/vx+dryaf8Nil/MA
X-MS-Exchange-AntiSpam-MessageData: fdaX8w8sRCNYM6ZdTz1eO2cxHFdh/1JKk3TBKEocSJsKgUHOWqjr48+fmxGvQzbj5fUdn7PrtehVdWcvv/uV+MsKjqaLIDOUg/bHHPW2q6XbKAeaKpP5+Fv3ouHZDtqftH8hjZusWyfEYyFjhw57pQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a439b1-8fb1-42b9-d41e-08d7c9b0e6bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:49:52.1369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GElKwIRr7OEzJqFX8TKLTemeIBaAIXbYHaW5iiwdM50Q9dHLg2R8NQHPwjexJx4QEkJFdhCQI031wLp5GtbhWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
 
* Updates on MST;
* Improvements in HMDI;
* Add fallback to DMCUB for PSR.

Charlene Liu (1):
  drm/amd/display: guard DPPHY_Internal_ctrl

Dmytro Laktyushkin (2):
  drm/amd/display: fix split threshold w/a to work with mpo
  drm/amd/display: add on demand pipe merge logic for dcn2+

Hersen Wu (1):
  drm/amd/display: update connector->display_info after read edid

Isabel Zhang (1):
  drm/amd/display: Remove redundant hdcp display state

Jerry (Fangzhi) Zuo (1):
  drm/amd/display: Fix test pattern color space inconsistency for Linux

Martin Tsai (1):
  drm/amd/display: differentiate vsc sdp colorimetry use criteria
    between MST and SST

Nicholas Kazlauskas (2):
  drm/amd/display: Pass triplebuffer surface flip flags down to plane
    state
  drm/amd/display: Explicitly disable triplebuffer flips

Nikola Cornij (1):
  drm/amd/display: Remove connect DIG FE to its BE during timing
    programming

Roman Li (1):
  drm/amd/display: Remove PSR dependency on swizzle mode

Sung Lee (1):
  drm/amd/display: Program self refresh control register on boot

Wenjing Liu (1):
  drm/amd/display: remove magic numbers in hdcp_ddc

Wyatt Wood (3):
  drm/amd/display: Set disable_dmcu flag properly per asic
  drm/amd/display: Fallback to dmcub for psr when dmcu is disabled
  drm/amd/display: Allocate scratch space for DMUB CW7

Yongqiang Sun (3):
  drm/amd/display: workaround for HDMI hotplug in DPMSOFF state
  drm/amd/display: combine watermark change and clock change for update
    clocks.
  drm/amd/display: DPP DTO isn't update properly.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 ++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 14 +++
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  5 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 15 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 11 +--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  9 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  7 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  5 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  7 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c |  2 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 10 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 99 ++++++++++++-------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |  9 +-
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    | 22 +++++
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.h    |  3 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  6 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  1 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  3 +-
 .../amd/display/dc/inc/hw_sequencer_private.h |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |  3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 17 +++-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  5 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   | 28 ++----
 .../display/modules/hdcp/hdcp1_execution.c    |  2 +-
 .../display/modules/hdcp/hdcp2_execution.c    |  2 +-
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   | 12 +--
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 37 +++----
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  1 -
 .../amd/display/modules/inc/mod_info_packet.h |  3 +-
 .../display/modules/info_packet/info_packet.c | 20 +---
 35 files changed, 234 insertions(+), 174 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
