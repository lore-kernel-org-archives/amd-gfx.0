Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148CBC3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87F720716
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 23:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PzNu9BmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87F720716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5D16E0A6;
	Tue,  3 Mar 2020 23:27:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C34D6E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 23:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWOPHk/G4u2eEfLMaA+FcTcWsjuBZexqd7z5XNWZ5r1jNN3ncpeGddc1ljCgrE+C4ndgyrhleuWIvUGmo355KX6JGx2PFeozjCx8DJOxaVse0bLOXm2wtbFwzcdwjg1PiqYoFAggeYjkieoDFH5WM5fsNpggd9ex07MFO0XcAk7BiGkkzNXbHu4jNz3uETZAmf+tNHlgCAMHlMq4vNViiqSZYlvBzyrhMnAzUNHYAjC1TOqsxs7tv2rr1jgEnGTdZq+Mgr1IGrANlXwBuM8/KaE/0vcQYqUF2fyEga3PcdgdHtCZIZTkTOzpihS8ETRGQQuK3m4MzGtwumcleXoedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6rAk2khu9/JWTELNYzHq0v5rOp3q8bOdc8ewSOwy2o=;
 b=bqiDD5dgzoHrphjALT/1b3kozzX2ZhK+Avj0mvT0iKyqz2dXIQvVR9bgr/vwauzCE6Jqeh8KFJb9eEcw285B+Wsc85HJNgAlLzVGLKq5aEklDNveY+K4cPNIoTvSv5XWbZNzEHowVnywmeTZew63zA4FpjdLoDbpNFQXshQqLrhQvYiN58bjVTNUT376I/Z9rQfN6QddDGVh0t1di+3Bhubc/8W5mk6LLS4DPv2V1psgbECFpDUqGTd7TurJOuvjmNyFrW5GKm22d5QjRNekeHzABPF29unP3ARA+1md4zJUfOS62WaHQ6RlD68uXfG/vXwwNZOsn/Y3NLXF+PO24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6rAk2khu9/JWTELNYzHq0v5rOp3q8bOdc8ewSOwy2o=;
 b=PzNu9BmACfWsvA0MaSdjV+Y+OBNuQb78600u+ORv8awleNfyzkldFNRX5Ob684pOn/CXy3ZkXf7vTNRoq6IpGKAIrmhzQUTLzTMQ7tD6/3os/F+vZ/XKzRV5oAxtOFAz/i+2TTWNztq2vP1w7bkfh5NrsRqOnGxHCxru+H02kdI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2441.namprd12.prod.outlook.com (2603:10b6:907:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Tue, 3 Mar
 2020 23:27:34 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 23:27:33 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/12] DC Patches March 03, 2020
Date: Tue,  3 Mar 2020 18:27:06 -0500
Message-Id: <20200303232718.351364-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 23:27:33 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a5d756bd-c7da-4c18-f71d-08d7bfca7343
X-MS-TrafficTypeDiagnostic: MW2PR12MB2441:|MW2PR12MB2441:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24419836B24B414B8B34E1EB98E40@MW2PR12MB2441.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(36756003)(6486002)(8936002)(52116002)(7696005)(81166006)(81156014)(316002)(4326008)(6916009)(5660300002)(186003)(66476007)(956004)(66946007)(1076003)(478600001)(86362001)(2616005)(8676002)(6666004)(66556008)(26005)(16526019)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2441;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 632S+ho5seXE8he9UR24z7FjK9gswhKTbeo3odhtYOUbw3IFne9Tk2KQm7Q7MciMOOYPUlG1OKKXDieiUWcjxYDl1diuNt+HH3LVtACUXinoVkd/N108QDDAZuFOHZd4aUjBkfo1Tq3WPz+XI/rPewnTRgFXBscIqdimMULrME06+hCSV6IHKbPp8yQ2rLZGmNj7Cdes/1Ot6k7XSM64LiPWSigtovFQAEMzLwwUXYI40X8nVVzh1SXRy7P7ZyFg1kArqkGu25PK5cUslTZpU5yLku3XTe/4+EfkAwF2xTgnktdqYuY15+jmDoswuHWPhQBAKx0zeXWu68/b5Kiw4pmfTQ+3wBaX2pNjtJ44PBtAC1UMVFdZop5NdXvbZkSOkupaUkLHBhRuoij2EClPSPR5LEs4enbiGo0qs7FmsbXdXP0RSELIwc8EvDssQfZh
X-MS-Exchange-AntiSpam-MessageData: +ZJme0dLSQ0J1T+PVRLeRutNyB7Rcg471ZEVL1hGV/wdRc/Dde1BZUuM+Nrxxy1wseYJeSIZpxt34QAfqiRNX7ryyeyrFR+woXMca1cOfF3pE6ZB8qeWjCbFJ3+Fj7qG86wYIFAsZSXebOQuRP646g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d756bd-c7da-4c18-f71d-08d7bfca7343
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 23:27:33.6646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTCTbfdGlQCsGVH0wcP1YgdANaRYuFUvD4Wlj8b5gfRaWYja9lRB91yrUDgsA0PyiefZc0uIIAFeOkxHXP1s2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2441
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
 
* Fix i2c_write issue
* Fix HDCP issues
* Update nv14 soc

Aric Cyr (1):
  drm/amd/display: 3.2.76

Isabel Zhang (1):
  drm/amd/display: Add stay count and bstatus to HDCP log

Martin Leung (2):
  drm/amd/display: update soc bb for nv14
  drm/amd/display: writing stereo polarity register if swapped

Nikola Cornij (1):
  drm/amd/display: Program DSC during timing programming

Rodrigo Siqueira (1):
  drm/amd/display: Stop if retimer is not available

Wenjing Liu (4):
  drm/amd/display: determine is mst hdcp based on stream instead of sink
    signal
  drm/amd/display: determine rx id list bytes to read based on device
    count
  drm/amd/display: fix a minor HDCP logging error
  drm/amd/display: separate FEC capability from fec debug flag

Yongqiang Sun (1):
  drm/amd/display: Not check wm and clk change flag in optimized
    bandwidth.

bradenbakker (1):
  drm/amd/display: Add registry for mem pwr control

 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  16 +--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  83 +++++++------
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   4 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  11 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  28 ++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  31 ++---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 113 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   1 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |   7 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   6 +-
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |  24 +++-
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |   8 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   4 +-
 18 files changed, 240 insertions(+), 106 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
