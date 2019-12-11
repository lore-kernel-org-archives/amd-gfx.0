Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E07CC2D0C6
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4FA82077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xe1BJvjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FA82077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA1E6EB70;
	Wed, 11 Dec 2019 15:33:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5492C6EB70
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEe9tbUM2HKKaonC7Y9FMUJWpt2inBSSxsW8YWiyuQRk+JXW3LvzHuQ+6dI5lo6VeWMcWSl3PbwUSARhaVmKpygp0PvEFBSTdJ4OUh1sakoMfjCM9ohnn8DL9mWT1pZiMRorBCDfBXnOcwR2YHlu9mVJQ82VPVTRavIkA+ACfpxM5KgxSm44h5zaS3jbIO6lVMlPgLy8NRPP5pApgFS/jmeEwNhMrT0IfjVEx8c+aed/rmPYF1ORwioLj/rvBbqR/MHZ55i5M39dzOPjbRd3M0GMr9qN82ioBxpYGXUAWGfZOZtCyZvQP8hu1qyco2t3S03k3JO+Wv9rxzA3pX3L+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydgLSgEB+52YbMl4YDdRmR/M8GyjEhunvtPyXPAcpfk=;
 b=LBMeTFIchcYjDuhL8mL7DYQf3+hx9GkoZbN0sKW0UJrogqfufxSnADkPeEoDEH8XSQr4hmD2p71yaxp4gdEcYVw9pICzPN6zHb0ZqYQeIOfmQ3lHRkGAzEQkpSWjbKqyfZNM3FwdsEoInVF2bHjRyZLYjSVny3ElQ0ozjYPK43hxnqH4HT/Q/8Vpozh0EumKaagxyN4cI+lvkGSWIWYBd5eVeT4ZQRg7qnGJkasXCfFEWNRPKege9QSyZBAd4T6/W6uGTQ0U+7izz56avnYKtPKROUUroCU221yUZjOOEHSaA4TIxMD6jLfNypbkhspV5GPolDq04E+I+ZNmbAOgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydgLSgEB+52YbMl4YDdRmR/M8GyjEhunvtPyXPAcpfk=;
 b=xe1BJvjXbWNtynROzzUswm1Cw06ntJOCgJe19sLoIYRVJYt2vbD//iz67w0/tP5lwKB02zwunD9PGeJFuuwhIIBGIhbW8tGC9GWZHnYuZIez6502Yk0rJhI1bLqzBZB/REpjLwl4Si1QUK6QHHZon1Ebx7QePmhDxoUts6MYL5c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2570.namprd12.prod.outlook.com (52.132.181.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:16 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:15 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/39] DC Patches 11 Dec 2019
Date: Wed, 11 Dec 2019 10:32:14 -0500
Message-Id: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5ebf160-02c3-474c-a2c7-08d77e4f7084
X-MS-TrafficTypeDiagnostic: MW2PR12MB2570:|MW2PR12MB2570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25707FD28B48E524BA14429C985A0@MW2PR12MB2570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(81156014)(81166006)(36756003)(66946007)(4326008)(66476007)(498600001)(8676002)(186003)(66556008)(6506007)(26005)(1076003)(52116002)(86362001)(8936002)(2616005)(5660300002)(2906002)(6916009)(6486002)(6512007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2570;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZP7rLL/xdZWhCvyiywmqSKrpG31R2NwuLBKUHOplINYoQuxHK2TaSMPtoC1OlYbgg2hMl+rwSsusANXc1SO8q8ZBME6gvB6gp6tmprKZIlLzBuho2dLAlVpTq756OHkRt8yW/QSOr4+Fht9TVELz6MSr5sXVV0XZ6d0PT429JJ30cVPfoExZEidwMrjp8JDsNeRDdgkfgEdI4DBpKCWyKWJdaoODvBCHhVKFBmfu072xUcdUeccYQc4X0VIsyKhBA6QyHLS8TqmJkBLX8GZCijDCBdV0fihHz5ucozf0O2hPLAdnYGC1lwVzJs14ZftW/ozV0d+Fw8CZs9FLC5CqGdoYfZshzCBbxNJaHJIOdlXMV8bZ4ev4RtOuQPTmHK9kLDFyWmkKkxUhZoBDV03EUGkvaCYc8zNu5FXXvfjUUMN73n7Qi48kB8S4BjMGub+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ebf160-02c3-474c-a2c7-08d77e4f7084
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:15.4239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqpIZ7Nu9XLo5BASU6yNr1mSNJIMJj1pAgMWkTsYcoMYjdJwB1VwGN/0o9XCuQZZC5Akb8waC2VdBLrxkmbKgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2570
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

* Fixes on DCN2, bounding box calcs, regamma, and other;
* Enhancements in DMUB;
* Improvements on DCN20/21, freesync, DSC and others.

Aidan Yang (1):
  drm/amd/display: Disable integerscaling for downscale and MPO

Amanda Liu (1):
  drm/amd/display: Reinstate LFC optimization

Anthony Koo (1):
  drm/amd/display: Do not handle linkloss for eDP

Aric Cyr (5):
  drm/amd/display: Remove integer scaling code from DC and fix cursor
  drm/amd/display: 3.2.63
  drm/amd/display: scaling changes should also be a full update
  drm/amd/display: 3.2.64
  drm/amd/display: Fix manual trigger source for DCN2

Camille Cho (1):
  drm/amd/display: Add definition for number of backlight data points

Charlene Liu (2):
  drm/amd/display: HDMI 2.x audio bandwidth check
  drm/amd/display: Add warmup escape call support

Dale Zhao (1):
  drm/amd/display: Use absolute time stamp to follow the eDP T7 spec
    requirement

Derek Lai (1):
  drm/amd/display: Specified VR patch skip to reset segment to 0

Eric Yang (1):
  drm/amd/display: update chroma viewport wa

Hugo Hu (1):
  drm/amd/display: disable lttpr for Navi

Joshua Aberback (1):
  drm/amd/display: Add interface to adjust DSC max target bpp limit

Josip Pavic (1):
  drm/amd/display: fix regamma build optimization

Jun Lei (1):
  drm/amd/display: support virtual DCN

Martin Leung (1):
  drm/amd/display: Enable Seamless Boot Transition for Multiple Streams

Nicholas Kazlauskas (4):
  drm/amd/display: Get DMUB registers from ASIC specific structs
  drm/amd/display: Use physical addressing for DMCUB on both dcn20/21
  drm/amd/display: Perform DMUB hw_init on resume
  drm/amd/display: Get cache window sizes from DMCUB firmware

Nikola Cornij (2):
  drm/amd/display: Map ODM memory correctly when doing ODM combine
  drm/amd/display: Add debug option to override DSC target bpp increment

Noah Abradjian (4):
  drm/amd/display: Add wait for flip not pending on pipe unlock
  drm/amd/display: Use pipe_count for num of opps
  drm/amd/display: Collapse resource arrays when pipe is disabled
  drm/amd/display: Remove reliance on pipe indexing

Paul Hsieh (1):
  drm/amd/display: check link status before disable stream

Qingqing Zhuo (1):
  drm/amd/display: AVI info package change due to spec update

Roman Li (1):
  drm/amd/display: Default max bpc to 16 for eDP

Samson Tam (2):
  drm/amd/display: fix 270 degree rotation for mixed-SLS mode
  drm/amd/display: fix missing cursor on some rotated SLS displays

Sung Lee (3):
  drm/amd/display: Fix update_bw_bounding_box Calcs
  drm/amd/display: Lower DPP DTO only when safe
  drm/amd/display: Formula refactor for calculating DPP CLK DTO

abdoulaye berthe (2):
  drm/amd/display: disable lttpr for RN
  drm/amd/display: Update extended timeout support for DCN20 and DCN21

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 209 +++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  46 ++-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h  |   6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 177 ++++++----
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  10 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 145 ++++++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  59 ++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   7 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  13 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |   4 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  68 ++--
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c |  20 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  36 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  24 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |   1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 314 ++++++++++++++++--
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.h |   1 +
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  31 +-
 .../drm/amd/display/dc/dm_services_types.h    |   3 +-
 .../amd/display/dc/dml/display_mode_structs.h |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  33 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   7 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   2 +
 .../inc/{dmub_fw_state.h => dmub_fw_meta.h}   |  64 ++--
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |   7 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  84 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h | 117 +++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c | 107 +-----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |  13 +-
 .../gpu/drm/amd/display/dmub/src/dmub_reg.h   |  10 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  57 +++-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   6 +-
 .../amd/display/modules/color/color_gamma.c   |   6 +-
 .../amd/display/modules/freesync/freesync.c   |  32 +-
 .../amd/display/modules/inc/mod_freesync.h    |   1 +
 46 files changed, 1261 insertions(+), 514 deletions(-)
 rename drivers/gpu/drm/amd/display/dmub/inc/{dmub_fw_state.h => dmub_fw_meta.h} (57%)

-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
