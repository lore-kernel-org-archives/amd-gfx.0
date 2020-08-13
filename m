Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8038DC433E5
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C7D20768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aGIq3k0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C7D20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7D166E054;
	Thu, 13 Aug 2020 21:35:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964306E054
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAVE6LAV278IvavWT16CJc36HcTLqPbHHrvDnDJw6E0X4WpzsvEFIvmytpLqgpBzxzMU0W/7cF66yafdTLryyqxUWxKeAh7WsylAtTP7rf6sdxxCg3EY1l2ilWDsN3wincJ7cJatyJ74ZrLrKpFnZ3BnyiURs9V0kCQe1cR37BdnhvLfoBLpoHX1edkf8irTIcs0uCfHqyCfP8Go1xnN+xVB6FNV2YuAU3fO56yWEVZ58vifXuD+p4bs2PuW0PMXxLk12kpBhyd1kPhORwWlfS1ie8I/31w198RINnUpI/L+SrNL42iV4oAjsl2Dudz/KNKmDV2fnojjKkzursW9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpl96fYiIsGItHz0xM4z+IJ812GOQKVi+ADF9dxYW4w=;
 b=kuHl7K5DRzliGxxutZZIkcW1ww9y6HMXwJE7EgYs0bMcKJpH02oFs99ZXp4FTeI5wKB3YkAVjuqNP7lLV5CSjvhxlXYCJLrHlQOJOhhIA/lJ0HlsE5kT+YxTR00PpkRc8J8P0q3IUfDylv6rJ0qtVmPOjFzlDiqaLTCGRJvXU/gWyCqSMcM2Nr8s7U6i/2ol+t3ajJK9eqsLB8l+bVnD6NSXYJotxgZmFwuZBHaBC0dpp/sUeK19+x17eNwiVxzo05/6mJRZKfnS7aOxpseJOhCN/aGcCSskVor956evpRLhgJ4t4Lz9YMTvPHJLJyVCVWQaziHyhjaH7TaNqMX4pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jpl96fYiIsGItHz0xM4z+IJ812GOQKVi+ADF9dxYW4w=;
 b=aGIq3k0Lj0Z7H78iYQpER3pr003Y6hb9dkjmH4yy4JNtlLn9qQ19Yt2F30FkT+ySOy5JojPugsF9srxX7crKmFjip5DO9aKf9QzXYDRF1X5BBOwDiNunpkNUx8tWyQ6/Q8Pulo057lxNKuchZ36tDHKromnz173cWLsx9ybfu58=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:24 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:24 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/17] [PATCH 00/17] DC Patches August 13th, 2020
Date: Thu, 13 Aug 2020 17:33:39 -0400
Message-Id: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:24 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8643e448-c808-4076-c87f-08d83fd0c9bf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1355A6332BB8AE5EADBE9A1298430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lgd+BEkgcpzjmcwfC4ymCqi0P0G6XZkoExy7jaMMzurRbYN6ki7Avcf7gqURWqP0ihC+zA2F5YHCs0GQSVtsfPfhqs30s1IzYoxOmbC7pFQVfTR4DMP7uw/oa7q1c6qIfRCoP6WMpb5mqGgoD/psiC4/nniUQnfdKFbEBSLjeAqfPpPtVa6rzu3EadDK/P33Jc+0SZIILvLPkSvvUtBQzk3S2vp7ZhrXqalI2mwWLAu2faFXBDc5Nbyau/9KItD5ZcbE7AxbYpjt+bXHUrR0tAvJCeUkBFzDUujME1yQId0kswPZ8rCNFd+p172oE+pmpkVzXJDFHRUAmK71nHnqrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4M3XgyJku33W7VJLinXBzqmcB5WtzdxpCwjVW4sp/fo+AVqb6upRQ2pxDqvm490X1FrKBylEnYWcn23azNhYzXT3cIaogpwWnxKU2lsyR0QMdT3oqMoS0KnggHhi9DO3tjCLhwUa3tKxzCqp3SsJeAjRYaOhBDFalwBaZLDWpuRRywg8H2EC1isRLqAmialL75UtddTcXFDQibGvX4WcgDEyjHdZ9D4XexQIFIEGfpeLV8zEvOAp4Ek4nhHgJNDc6RkpfR4NBG/4akANN669GF3M6AGjEhiWZGhRQobnEQVNU1QVlG4QxYgsKnFYUJdAd257JhdJ0Wx+n6q5EXP16nKIN3U9opToB1oIDf/TGgLiHdGTIqPx99tdS56sj3c1yPmHhsoTtC33sgSXa0a1Uy74sDTfqMNUbaKPiyTqQvpUyQH5zfd+2yZahF/ZAOi05q8uulFsb71jLGp0KJEDSlIMiITRdHqhQrLpuT2BWTKTbSvSsf8HfDPjG37RvI40FKRDFchQRk5PzSHvHOmkapI/+GD7wXpTyCJOsoSEsPqqIgVtbEZR9EAnCIKCL6ekBz12Kt/mBFLhOm9WjDZRWBaP+PM2jsDMw7lZ8iK7qmSGQpixk3kLkrT2bSUzkPeYQwCVwsEwrqW+xhnU89ZU5vfXWco5hhQVdQD+knnP4V0nr9S06Sr3keVp0t8hHuD3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8643e448-c808-4076-c87f-08d83fd0c9bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:24.5721 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP/cDPNd6lNHJZvYTS050htPn45raY1Z2uCpPtuuBLm8G046CY9a+Eg0uyAiYq/Hfd8gn9mXLP/8vgpwpMGisQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Fixes on DCN3, DSC, eDP, and pow()
* Firmware version updates
* Updates on ABM
* Improvements on MST

Anthony Koo (3):
  drm/amd/display: [FW Promotion] Release 0.0.28
  drm/amd/display: 3.2.98
  drm/amd/display: [FW Promotion] Release 0.0.29

Chris Park (3):
  drm/amd/display: Call DMUB for eDP power control
  drm/amd/display: Assign correct left shift
  drm/amd/display: Reset scrambling on Test Pattern

Dmytro Laktyushkin (1):
  drm/amd/display: fix dcn3 wide timing dsc validation

Eryk Brol (1):
  drm/amd/display: Fix DSC force enable on SST

Jaehyun Chung (1):
  drm/amd/display: Mask DPCD field to avoid reading unsupported field
    value

Krunoslav Kovac (1):
  drm/amd/display: fix pow() crashing when given base 0

Lewis Huang (1):
  drm/amd/display: Add extra T3 delay

Paul Hsieh (1):
  drm/amd/display: Fix DFPstate hang due to view port changed

Qingqing Zhuo (1):
  drm/amd/display: Screen corruption on dual displays (DP+USB-C)

Wenjing Liu (1):
  drm/amd/display: create a function to decide mst link settings

Yongqiang Sun (2):
  drm/amd/display: Change ABM config init interface
  drm/amd/display: Add read backlight interface

hersen wu (1):
  drm/amd/display: PSR eDP p-state warning occurs intermittently after
    unplug DP

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++++++----
 .../drm/amd/display/dc/bios/bios_parser2.c    | 16 ++++++++-
 .../drm/amd/display/dc/bios/command_table2.c  | 28 ++++++++++++++++
 .../drm/amd/display/dc/bios/command_table2.h  |  3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 26 ++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 14 +++++---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  5 ++-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  4 +++
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  3 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  | 12 ++++++-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |  6 ++--
 .../display/dc/dce110/dce110_hw_sequencer.c   | 33 +++++++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 +--
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |  4 ++-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  3 ++
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  3 ++
 .../display/dc/dcn30/dcn30_dio_link_encoder.h |  5 ++-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  3 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  4 +++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 20 +++++++++--
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  5 +--
 .../amd/display/include/bios_parser_types.h   |  7 ++++
 .../gpu/drm/amd/display/include/fixed31_32.h  |  3 ++
 .../amd/display/modules/power/power_helpers.c | 19 ++++++++---
 .../amd/display/modules/power/power_helpers.h |  4 ++-
 28 files changed, 236 insertions(+), 33 deletions(-)

-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
