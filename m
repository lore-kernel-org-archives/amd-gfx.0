Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB27C04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AE920720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gDTnTSg0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AE920720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EDBC6FD02;
	Fri,  7 Feb 2020 15:48:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C7536EACC
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8AL7U+5kJtm1Q7zOECPd/xmjS1Eyz5B7Wrd88DDML/P2zgxWu1cJBZQDmPc+FI5f9YwVBr04b51tBw6zkNZKP84XCdhAkht1PjO6AQaHebmQppbY9atuomnfNiWKDosj729V3obwgHyRfB9MvNdiQsNfBPItEIaiPAXW+JpEzPX4cs7UDK0JD+ZXPCS7IE3fIiofPdPT3iGKKu+HGDPCCYq+wdi99479JHcdUM3hp37YN1eiMPjLY/XKk5K4cAMFryB9DteEj3OgFICVnP9KxPAN5daBgMk2upJyyTJC22qud9FDqVD5sBmIrq4/WmqRpu78LMubSKHOU8E1K9uww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0twGU/5XFSWlAQfHBHCEtWZPdShYM7trCz84iJWjgLk=;
 b=AwDyy+PrMZuEyFl6LPunlDH6DwEBaxboXtMzt5PxvTlpi1UZf1mF7gNg5K6o3TZb1yXDXokX6JYP6m3jdXxSw+XWpHSRzgXALa8scISxNvtOs9FF3hIzZm1yb6W1lw12H0JalBT62vZ4vM42bHbL07AyBF2/i8Q4RottFVhflvJIWctuJfIuCN1GzSFajc+JFUnGH2zPVKd5vd4QDABDIZ5StwuqRCdiQ8freJv6JUMrCceBQgmk5JnE4yjSI6aLHle51DXP/OkY3sU6V8DXmLKZH8KiwFyd/rVKEN8uxwSX3ggb3ZvjMvLZ+aCJKoZ33Cj4oh9tXJTQ0JaVzlWgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0twGU/5XFSWlAQfHBHCEtWZPdShYM7trCz84iJWjgLk=;
 b=gDTnTSg091NktVG9bTAjARqcfP23s0B6somoKdilIAAXzfE3KLPorPjBToQoqWZAg2bXkpF0lb6ZJdBOSZrNE+0j3T36Y/Kl9mVLHfZ6SB02yOfg92RTAoBRQ0+nEuNrudimMPcjs9mMwgoZyXr/PJhD1ldyPcZpz60fffqjvFU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:48:19 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:48:18 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/17] DC Patches February 07, 2020
Date: Fri,  7 Feb 2020 10:47:41 -0500
Message-Id: <20200207154758.1070385-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 15:48:18 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 995b1beb-4586-4138-72fc-08d7abe526e0
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440241B72F654F909156B44981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuYopt2x/l1TGymcNg50CsaMlTOtR01pePsM9w933w4hYNIHZNQW5h/tDNJhZ2HlJcFEJUnaM0lE6O06E0uBSfe/vP4MPD34QDqTbgSG1m5Tq04MWPsg2m8ciWOtd/WN6f0rcUjG/RxPNBN9nHbe9xY8dx2LZxoEEMyuJ4AZgzfIp6CsJ5xpraQjb5ZHLwz0Vu1u2qpFmYB65DebZEPxeuVT3VXM9nQsnMbAjZp2yKTfxOVb1DJ1xqKuN5MsxWcRo/g8X6fBwWiDiqJy+a7BumRvRGv1LnDzow2t7GC2ep2nruNLVkk/YTONgwpWp3/szSs3EnOpYaq10cMPoRqFso+Obe/vCFq9MoRlNR381IoghorVcGU0TpG1vl7AXxTgPKXnptZ2wNdDpUJ4T+vGnq7kPdB5c//s9LIlqDaC+Zzx0+bOzA+fLP05uiMeeVsg
X-MS-Exchange-AntiSpam-MessageData: sRUzcjBpxVI9Dea2lDuzMHmhX91NUM4cOaJl5O991muDm+uutBnoiAFXKaTZn2lGqnfCXSFoe7ZQ2HMgBcghqzfndUs+TrVb//06xpnnufMy7HujaWP9YVR1VxC0qyeC1FcufhgnYhC0ljABxwecqw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995b1beb-4586-4138-72fc-08d7abe526e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:48:18.7087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrVMNTVmo7YCkivoyszOAmFiBhBkp8BRO+w5wxKtT/NBo5zwrcUXERy+HM43/67d7m225Fdv0XcV+NGOZmeaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
 
* Enable backlight support via AUX for OLED displays.
* Improvements in the PSR.
* Improvements in the dmub code.
* ODM calculation improvements.

Anthony Koo (2):
  drm/amd/display: Update register defines
  drm/amd/display: 3.2.72

Calvin Hou (1):
  drm/amd/display: Pass override OUI in to dc_init_data

Dmytro Laktyushkin (1):
  drm/amd/display: add odm split logic to scaling calculations

Martin Leung (2):
  drm/amd/display: always apply T7/T9 delay logic
  drm/amd/display: add monitor patch to disable SCDC read/write

Nicholas Kazlauskas (3):
  drm/amd/display: Don't treat missing command table as failure
  drm/amd/display: Don't map ATOM_ENABLE to ATOM_INIT
  drm/amd/display: Use fb_base/fb_offset if available for translation

Nikola Cornij (1):
  drm/amd/display: Drop unused field from dc_panel_patch

Peikang Zhang (1):
  drm/amd/display: Toggle VSR button cause system crash

Rodrigo Siqueira (2):
  drm/amd/display: Add AUX backlight register
  drm/amd/display: Add backlight support via AUX

Sung Lee (1):
  drm/amd/display: DCN2.x Do not program DPPCLK if same value

Wyatt Wood (3):
  drm/amd/display: Remove unused values from psr struct
  drm/amd/display: Hookup psr set version call
  drm/amd/display: Add psr get_state call

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 161 ++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  34 +++-
 .../drm/amd/display/dc/bios/command_table2.c  |   8 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   6 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   8 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  49 +++--
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  56 +++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 171 +++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  14 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  43 ++---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   3 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   8 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   5 +
 .../drm/amd/display/dc/dcn20/dcn20_mmhubbub.h |  20 --
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  40 ++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h |   7 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  10 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   6 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   8 +
 24 files changed, 433 insertions(+), 235 deletions(-)

-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
