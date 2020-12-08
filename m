Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEEFC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DD923B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DD923B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B6B26E055;
	Tue,  8 Dec 2020 19:28:58 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FE1D6E055
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEgKCLxPCRImXFIovymSCS5u2wFcTuF56ojGLUKlS5q4wBgTa+o/18geWT5gtk/WujbcVFauLISr6Ec7NnBpE5VBXHuY56d0tYkS53FjpGiF2QsPJZHVC/IxFu1oYMO7wVYO98KRWamvcBR8DgUfPdk4HrLj8hhEEupQq1CofM+bQY7VV1Onx0AofurW5caht4F4Q+zJwfPZJGYeK89xOVFtUsTP7EfPCNp1OJjzpfITuF1UyLSMt8985N6W6HI5Ldxe9vvkChAU8gQzvePciGga/FDnkJv2z/+RB3yypKEbH8h2DY3baTPV9OZFubj6F7C5tZg920ua3uZv/X0a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lchrbmgUFCIfJf8HGP0uU9YKMj5TmnUco9rg1d77Uzo=;
 b=GCLSbHSb00Sw0uZVAGmU4MY+OVi+w/BKQA50pUdRG8OF1+8g1heH9pO/IIWIXnfZxrGyLGl5u5jCA/fd4QVBtGaGKnx1F2gydDEJXYLSMErxW9fZdxAiT62EVl59h8hXVOyZ07dHrEaUg4sg1XC7velpB4p7+1pY/kkxZDVTSNANwk1Zu39q58weELzUS0Y2pE767N886yligxR/7q18Eg/3LyBEWi+xslxRsE1Jno3HZTXz2EiOtAgLc7ZiJ+paqdqIiUXTTzQd1vPHOGuFaAhhdh4fo2tn0ZTlORcBeYMaLzMz9e40+0AbcpVllqn1yccvvu8ZVOUbJSXwNRfYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lchrbmgUFCIfJf8HGP0uU9YKMj5TmnUco9rg1d77Uzo=;
 b=ySuM+/cfcV9Ran761snaNNORp3gffUlEaHzuzpLdfMAGtZztYra3zcc+e3Nk2IftP4QEb5nTFCzCgfDHhoRKYTGOX46+aK4igX98vp6/fjDRXzApJuZvf/1S64PsK0R9xpJRNFQUVUNDmn0eVZxSu/SILQUXM6IL4wWwLvpTgvU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:28:56 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:28:55 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/13] DC Patches December 14th, 2020
Date: Tue,  8 Dec 2020 14:28:31 -0500
Message-Id: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:28:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f35f380c-c8f4-4b6d-d8a0-08d89baf8111
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43887A86999DE824FA46C7ADFBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7c5AMKiMQwAertcw9M+HFL4woixKMn/Z7E0tnEwpDsCn0Q6AdVDeMKQmiU4DcWq18ckwIQXeFCRcq+UZr9oJoAlWiRFrxFhiO2LYa9XKu3GqVISd82vT4BuYhnajRmBgNvY7TmPmJDmtv3qg6yLWHTZ9SmMKGORvBn0sQ6nLkohl8zyFrWFdtqmJxJZnLn4GjI6hEMTAr0l7MDX8pUsS3ex2Gol4TpC27YRQ6+AXW8Yaa/Aw+/8wbh8yY8yk7sGCRWG+/HfhPRs8Xs4ll0Rns7lSbp2QFglmCWYnOl2EgnBV8mMvS73gttGc9GToiHH7YZhUNx1EQwY4QXgc/+YjKp7F0yz8uGZZNCtbbUr6KAHmJAVs3zLdwSgFYGa9dzZuP64d0fdgWX7b8q3kdJ53AS4nKXoyG2biXO5xIItUpgc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6HJwC3lQhKeJza7TCOAK0fl3NrqZrqYETBNboPHWTmmbK/cM2Lq3qc+Mxd3W?=
 =?us-ascii?Q?c+qT3h18Lf0ErLI8M+WzGkYRBUteKTaidcZg+vcNg9l8gIxn57IuqWvdEYct?=
 =?us-ascii?Q?8BXzBYy1TphzfsP3vr/kwGAz5Os4JMwEnp/P6gt5vn7OKBBYtJlmo1sNwINU?=
 =?us-ascii?Q?IlHztK1niDN77hbcKpgQQISvyBfMrI4IAYuy/a+HGSXLTpix6tMorF4dXmwX?=
 =?us-ascii?Q?4BGtD5wfu29hs3igXnSffcFZv9dZpbj/Hf3nFCfnGy4V7Rfo9EoAILQY7eTl?=
 =?us-ascii?Q?s2dk7PvUmbGBIKoOpIZ9JPGw7hctm/f1HA8oJ65NFMdi55qbuoE35HNFFP0e?=
 =?us-ascii?Q?jvQyLz4e5TTeBFbGGgJphovkhLl57zjVlWdsKtp/oCRe5v6avjlHEX4hk2XE?=
 =?us-ascii?Q?j1IZSkR9aDU3AZImb6TPho5ElwqbwehpGCOJ5YVHLhqjqgrFt0TDEnVSuQx1?=
 =?us-ascii?Q?VmAk7Sm8onRskUDU4aEb9JjoMYZCAcSHBFW//LF3RMFlBjEZlh6PrHfGWsys?=
 =?us-ascii?Q?5EQW6agMhOeGaXhUtmZqGiT2IHNn/IX75KSjAK/bjCY4B8l7FowlmP1vylPf?=
 =?us-ascii?Q?9dGhbb0gIQmBpxzA2xHh0/MyiDEeEZZw3ggV4aXHwHGhFk0vpv4aVpFEEuTR?=
 =?us-ascii?Q?yqsjzhnbmw12+2fy3FF3xSsCdLpRxeSFvNKh8AzxrRBXVaraXZ5UN7k4tGrc?=
 =?us-ascii?Q?J4FNxXXjyNyWGCtUESeFPo4gsNrWhygEWK3CqIkIV0bT90KkSbriWvVNneB2?=
 =?us-ascii?Q?X4SwQppzu6mvnaZgEpUl5BQbW+bHVtHe/rrBrgr5O7NduGuRAkxAQi/7pBJd?=
 =?us-ascii?Q?OrJp0na7fJWar7UdpGbCmHGkDzC+phD7o1vV4Jqle8/aWvzh8LmJXzfRozh3?=
 =?us-ascii?Q?UJNB0/vj8Do78qlGU3p+eZIQuuQXGr+DtsFfnqbyacAU1UWQLpOdcUS/UWrb?=
 =?us-ascii?Q?AoPYOaKVzLNQnF2towUZD88w75YJN5bVuxbDQVzih99H2n2aTduLyKFJvah4?=
 =?us-ascii?Q?sWwR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:28:55.7998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f35f380c-c8f4-4b6d-d8a0-08d89baf8111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJqgTmG+E+c3KqAVWd7wIFFsCJqBcSacTRtO3+Jyu/M16Ps4OjfcGG4szDvV/+ag
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* DC 3.2.116
* Firmware release 0.0.46
* Bug fixes on VR light up issues, missing register definitions, etc.
* Improvements on OGAM LUT calculation, FP2 timing and more

---

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.46

Aric Cyr (4):
  drm/amd/display: HP Reverb G2 VR fails to light up
  drm/amd/display: Only update FP2 for full updates
  drm/amd/display: Fix cleanup typo in MPCC visual confirm
  drm/amd/display: 3.2.116

Eric Bernstein (1):
  drm/amd/display: add dcn30_link_encoder_validate_output_with_stream to
    header

Felipe (1):
  drm/amd/display: Fix OGAM LUT calculation precision

Jake Wang (1):
  drm/amd/display: updated wm table for Renoir

Leo (Hanghong) Ma (1):
  drm/amd/display: Add DP info frame update for dcn30

Martin Leung (1):
  drm/amd/display: delay fp2 programming until vactive before lock

Max Tseng (1):
  drm/amd/display: Add missing DP_SEC register definitions and masks

Victor Lu (1):
  drm/amd/display: Change pstate expected timeout warning to 180us on
    linux

Wayne Lin (1):
  drm/amd/display: Fix to be able to stop crc calculation

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 13 +++-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 12 ++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 20 ++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  2 +-
 .../dc/dce120/dce120_timing_generator.c       |  2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |  6 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 15 +++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  2 +-
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  6 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 29 +++------
 .../display/dc/dcn20/dcn20_stream_encoder.h   |  2 +
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |  2 +-
 .../display/dc/dcn30/dcn30_dio_link_encoder.h |  4 ++
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  2 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 62 +++++++++++--------
 .../amd/display/modules/color/color_gamma.c   | 22 +++++--
 20 files changed, 134 insertions(+), 75 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
