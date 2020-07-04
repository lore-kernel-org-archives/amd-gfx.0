Return-Path: <SRS0=iabP=AP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A304C433DF
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9C42075D
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Jul 2020 01:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HSQ1YUAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9C42075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48F956EBE4;
	Sat,  4 Jul 2020 01:15:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2606E3D2
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Jul 2020 01:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLiLC8VEsuqJrpHCDCRrMMxrVAdvTqj4hezsQNQ/WVzXetCDGj9LRgZw+xjdXcFr9PduRbUm7pEOety+73TVjdYZI9OcTomQfq+JUnI9ldYoXOH8d3TbbJGn4nYrzeEsrHqEish21VUPOgjpTBV8f/7mmOkjaVPFYQW3j5yUwKWhl1KW08TIVFiUgnN5gwLZZBY8CpSzeqYTvR4N9Wbxo+svO8u7YWQSqXmx8kq4GUe0U/ixTqGCOQgr704UQts6f3vOdwKYdY5RccQw7Rtt3NVXDrKrGBIHatPYg1sOJX22O2DZ/n1GCkoJoImExwAVVTY0fqOSHRPH/uv1dWwO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/+U50+TTEaL1l7/i+/WFj2JnO0BDJfTH5cMWkGhXHg=;
 b=CWmV/r1XOBhlHtb98ia2v6Uvvi4HueWHinxAa6fGPBpnGGONHNCqsv4Fs7NlAarVGb1EWXlO/QzGI3fa8v93IE4G+2cvHtIfskQp+Xg7GqSlRMjIkZ6L5bOrUDDUJeeM04EWr2moLg4lGttqRz3A7qk6nWodYPnb2YtnQU3sn7js2e4dctv8bVV7MZqXfe3ePYLSBuWVYMadn5gtzBBy5R/68jtSYcmkTSguLBv9Vg6KKlmlBez/v4mbVeogbrsY/HPV8RXXATacInKdPBT5yxQ8uBg5KYruhPrkQJ0CE///2YwJE6FQMbmp7C5LMP3TLVn8sJa9Yrx8Ykow47MkVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/+U50+TTEaL1l7/i+/WFj2JnO0BDJfTH5cMWkGhXHg=;
 b=HSQ1YUAmBOpZ06LwzNHjK7NjiJC+CIyHy7aIM7eVPpCZ7DJDk/H1GRNOWC1kZ0wZQycpsZ3GAsCPfB4rVke+ovMsTsYZhuknMKwoho7hdvk0HTEvM1BBuUPuhwdD1lLb3Osn6QlUCVdOiVK8/L2hstK20aRtximpOm2AiWJ+7k4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3768.namprd12.prod.outlook.com (2603:10b6:610:22::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Sat, 4 Jul
 2020 01:15:24 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%8]) with mapi id 15.20.3153.028; Sat, 4 Jul 2020
 01:15:23 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/8] DC Patches July 03, 2020
Date: Fri,  3 Jul 2020 21:14:49 -0400
Message-Id: <20200704011457.2368241-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::26) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTOPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Sat, 4 Jul 2020 01:15:23 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3f146e0-7193-4f62-d8f4-08d81fb7ba31
X-MS-TrafficTypeDiagnostic: CH2PR12MB3768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3768E00F5DD3FD3C2E9129CA986B0@CH2PR12MB3768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VgSEAhXuUnxf3wsgLn0duAhexQW9HZ6ak0OVoC7+v1FONY/mOoiqplzWEc2kJiwp6Sg61cVzS1im8J8o7Ngm30BN6FzDmUrPmWTNHCSvEo4CiSogUBoB2NMrBIfIWO7MH/5gNcLo5b+w4A+4aJWNAhbDvPbEZjqx5XZaP9n5Wws5ejSPs4IggyyL4kivoO+mYzK/VEZDkqwj3tmt4i1bmuSSLGsZZh3cdwe88qWZLaEpeBMQdbmht2Er9QLZ/6Yoxnufjw+xBQAmElrwL3w/oQsla2jFJBVFl0QSdSoL71X7IXQ8EPaQMN7BHcAcsT4J6K9z/lQZlrA8UAZUVknMNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(478600001)(8936002)(8676002)(6916009)(52116002)(6506007)(6486002)(316002)(66946007)(66476007)(66556008)(6512007)(2906002)(1076003)(36756003)(4326008)(86362001)(16526019)(5660300002)(83380400001)(186003)(2616005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: lNp5ooQrfL4xdyw5TieCyX9Yi+UULUKFsr+IfOzd4nM649B4Hs1PT0q3f4lpTtEYwXqdXK+t/S1fiy99lI/Hjf8q6TjzvDf3vxeWG68PkChdy6aS6SHK1P65CccJemEWgx5vG4hUaBsqqXxa7oj+ENHK/Lsbl16l9+IJE219RtW2SqRx02lWsyZIDh6L8YCYQ3/BQjWx8YGi7hrU5r04yG5ycSmQh+ac+HWQEyG9XDuyc2hj7K4Ddp9d2UuLhwJ6D9KWJa1sy6VhbzCYaUVeS16tOa/BBn9dQ/iRh2ropl7TIJK92XPPvcOLAVIxmGqMZ4mEgVXte6GUyQM9+U1kkDMmOHBxzSHaFu4nEvCEE0wl+koijjCVT05DsuXWhR6Q+Jb3IagfgqCAAnLcvA+4f09mb41hpmjtETveyxn0b1XzNtEhy2g1KgP6PDMSkFrWTTfrYD2TohYgBIaBtT4X0Wym3CydTMlEUx4luLjysGJc/WNgeFo8Ja8L/dtyxAUFvBlGfA6Ib762by8Y4BIvoQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f146e0-7193-4f62-d8f4-08d81fb7ba31
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 01:15:23.8759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plIkAEfRPamjwNVcx90iu0QYBV+m0W0Bj2LSU7fhJfv6bWFb2puYa9pHDnrXBv/+n132fn5WjXBEmKAlH3zXrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3768
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, aurabindo.pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
have:
* SMU logger messages
* DMCU improvements
* Bug fixes

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.23
  drm/amd/display: 3.2.93

Dmytro Laktyushkin (1):
  drm/amd/display: Add diags scaling log by default

Igor Kravchenko (1):
  drm/amd/display: Register init

Jaehyun Chung (1):
  drm/amd/display: Send VSIF on unsupported modes on DAL

Joshua Aberback (1):
  drm/amd/display: Request PHYCLK adjustment on PHY enable/disable

Roman Li (1):
  drm/amd/display: Remove VSC infoframe dep on DMCU

Wesley Chalmers (1):
  drm/amd/display: Add logger for SMU msg

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 ++++-----
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 35 +++++++---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 27 ++++++--
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 32 ++++++---
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  | 65 ++++++++++++++++++-
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 11 +++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 39 +++++++----
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 58 ++++++++++-------
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  3 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 18 ++---
 .../drm/amd/display/include/logger_types.h    |  4 +-
 .../amd/display/modules/freesync/freesync.c   |  2 +-
 14 files changed, 232 insertions(+), 96 deletions(-)

-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
