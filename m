Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A676EC3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DC121D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lwco5f6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DC121D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A075E6E5BD;
	Mon,  2 Mar 2020 16:47:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40AB76E5BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:47:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgPnzUMwqql6Y9YWbhzhptTyy3ZQT1LOFCnjmjLrO0mno/0hPUOAIpp51pg73T1+IPbLKPnzprrMXJ41JWIzWfh9qBBg+cgqJit5SYN/goO/K0cB2EhIfHd33hhUPzKX0GHURAObgBqZ+Yi01lHVzqCrSK8w5JKke/ydZuvdbrUoglO+ElrJlmgDb1Jlvpl2OiFiMRYJDNTPeCrcbPprUYM+nDleHTDqq8iMl7+Vi+nXWE/Oc3oyPSDbhe1AzSOk9hxZHtELYmvFQ0eN+nF/rY7OL0mdnRKINGGVQkET7YnxG4gvYuCuXc+ZVofNVjoBFmaYkx1A7oZ4bS33xw7wDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzeLYsX+Gq/A9htoMNs6Hfce/aC04bC5uCRwHx9RRAM=;
 b=cJ3r4nlobKr4a9Drk78cy5FopXOVQlr1D+k6yS5ZU+UpxyTvL5oEERn0C3CFDlDn5peB4Jn1MS/1FvJ6CDZeDDDwwcXw/TDTf4Xf//ZCpssSMo8fxF2eNvCPZFKkKF9ZrjtFXGWzc0TtMO+qrbC0WZLrcGR5DteNivDd60TFVdExZan/9EFCn+CyaCdHz+g8dwFj6+NGZkU9j8iBB+XNgaCDX2DmmCdWIyYzZh34pXTJHv1S+e8lEAmRZ0wzW0ovQJxCKJcVsZx4SYv/K5kiPBbXkLLq3jx//KSvwbHzsQFCXa/K2J+e/oD4vFSBvU+w08yGWB3ZGCwehyFV5Dof/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzeLYsX+Gq/A9htoMNs6Hfce/aC04bC5uCRwHx9RRAM=;
 b=lwco5f6IXnlN3JRfJ/8ODbsMBPAc3upJbtlCkzHmgy4ToeB2ylVfEdaUH980jPnXlgq8OHIQQjnNV6+JEBsmzyRfum+90El/Og3JbNsYDU3eZIaglETxAwpkHxU09xjB3m1+pidrlM7tYIRCZyzAMFeeyPipuY/XQxBs5vp1Xas=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2540.namprd12.prod.outlook.com (2603:10b6:907:7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Mon, 2 Mar
 2020 16:47:49 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:49 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/22] DC Patches March 02, 2020
Date: Mon,  2 Mar 2020 11:47:14 -0500
Message-Id: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:48 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edf1ef35-35ea-48b2-9dce-08d7bec97100
X-MS-TrafficTypeDiagnostic: MW2PR12MB2540:|MW2PR12MB2540:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25400F81C6E05941E6C2077D98E70@MW2PR12MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(316002)(7696005)(52116002)(8936002)(6486002)(86362001)(6666004)(36756003)(81166006)(81156014)(8676002)(1076003)(5660300002)(16526019)(2616005)(4326008)(2906002)(186003)(956004)(478600001)(6916009)(66556008)(66946007)(66476007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2540;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uykorVb2ZcxY/ZzpKl2uVMgmkU7eeAY8Wm+rqVn/wpo1+rS+iaP0odm+YQ4OyUE373Was3fDD756IP4GDL26BfbNM7+4j05qj40OVRV9hu4rRRduECOeSES73hJVNNn4xkcJDwS8jgCqMmpgTG6eGIw61lcwFCWloUZbScR+ISkis4jH9EBAC7RlgHnNecfScN97YUQSVdiJbCOkpOHtYFCFUdXw4gF6nuUuQBxhpBmhKCgugwXS5KFRkQ/BH9NLOMVNapm/vLEbwpKOcjYHg8xWVJQSHMK6vLLoNFu7zr6OdNxVnKuGBDajyDYCQiJvUJr5Q/T8P6zwfgf/SBG9puJuLYbxuP1ID/dz/1k+nAOo+z083humOCvdqMCRRPWSaeKJuesjn+Chpjm9CguSFo8TipEtBgevRqPfgQhg/OdsbXqPQd2Ka2HweSdCZCIj
X-MS-Exchange-AntiSpam-MessageData: yR11+xgovuRz4EIAwd9HGxiWrAiaGoiUa/nLBZ6p/R2gkISPg4KAW6c1x60Tie3S49kUFaCVcwAq3EglWmESb/4v74Whx9sqLTK5UxplruFelI6+3t4bEH8HxVkO2q4QoqDMjgJaxtNPCsg0u0O1Vg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf1ef35-35ea-48b2-9dce-08d7bec97100
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:49.2172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSrojATxvbx8jP/3ISm+2LqnE0+9S0yui5jrdpQaHC7AQaodbclUcFvTlyJaGVQKe2cO+mXohXqJKHikpBdLHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2540
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

* Improvements on link training
* fixes on odm, dcc, and logger
* Improvements on DMCUB

Aric Cyr (1):
  drm/amd/display: 3.2.75

Bhawanpreet Lakha (1):
  drm/amd/display: Clear link settings on MST disable connector

Eric Bernstein (1):
  drm/amd/display: Fix default logger mask definition

George Shen (1):
  drm/amd/display: Workaround to do HDCP authentication twice on certain
    displays

Isabel Zhang (1):
  drm/amd/display: Move mod_hdcp_displays to mod_hdcp struct

Joseph Gravenor (1):
  drm/amd/display: add worst case dcc meta pitch to fake plane

Josip Pavic (1):
  drm/amd/display: fix dcc swath size calculations on dcn1

Martin Leung (1):
  drm/amd/display: Link training TPS1 workaround add back in dpcd

Michael Strauss (1):
  drm/amd/display: Disable freesync borderless on Renoir

Nikola Cornij (1):
  drm/amd/display: Add 'disable FEC for specific monitor' infrastructure
    to DC

Roman Li (1):
  drm/amd/display: fix typo "to found" -> "to find"

Sung Lee (3):
  drm/amd/display: Make clock table struct more accessible
  drm/amd/display: Remove DISPCLK Limit Floor for Certain SMU Versions
  drm/amd/display: Set clock optimization required after update clocks

Wenjing Liu (4):
  drm/amd/display: only include FEC overhead if both asic and display
    support FEC
  drm/amd/display: add vsc update support for test pattern request
  drm/amd/display: program DPG_OFFSET_SEGMENT for odm_pipe
  drm/amd/display: fix image corruption with ODM 2:1 DSC 2 slice

Wyatt Wood (2):
  drm/amd/display: Add driver support for enabling PSR on DMCUB
  drm/amd/display: Add ABM command structs to DMCUB

Yongqiang Sun (1):
  drm/amd/display: change number of cursor policy for dml calculation.

abdoulaye berthe (1):
  drm/amd/display: set lttpr mode before link settings

 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 16 ++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  1 +
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  8 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 14 ++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 96 ++++++++++++-------
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  2 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |  4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  6 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |  2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 14 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  |  8 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |  9 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 21 ++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |  2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 22 ++++-
 .../amd/display/dc/dml/display_mode_structs.h |  3 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |  1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 52 ++++++++++
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |  9 ++
 .../drm/amd/display/include/logger_types.h    | 63 ++++++------
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   | 12 +--
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   | 21 ++--
 .../display/modules/hdcp/hdcp1_transition.c   |  3 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   | 32 +++----
 .../drm/amd/display/modules/inc/mod_hdcp.h    |  3 +-
 33 files changed, 303 insertions(+), 143 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
