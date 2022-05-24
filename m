Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E86C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 17:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2A010F0E8;
	Tue, 24 May 2022 17:57:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EA110F0E8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 17:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2KqoKCh6r5hZKS/KyxQ/UxQftO9z6Up6lUvZ5nWm6pLkPfhty3NgnVZc4zFCyRokPHEmJdj9Zn2PbXQWiHwhsyENGVm8phxKI21iFHTG/pqSgIj6YpGFPnGO2cl2D84V0+1GFVc4rlOqD5MSqluhgpP1iauW+lPElSlPnqktwzBuyFGijWGGByaqT0v1b5F55svubUdYKgS2iK2+Vlp543OaIuPQZ8+x3Ng4gBo+5/5W7I6ftYUTnXTdaB9ZOF3VoqnH9xqXqCQoz2JwikXXeEM3RSVRBxyPJZSZKiab+TVwqvRW4v+uTtEwUaQA9ev3pxySS6NNFm1H6Cf1enhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4XPoTI/yiu2uIwAE5TQ+RcXzBLSM60yttcM+2VhNFo=;
 b=a09gOpkVIGB3LFAlm+8jFZnwaP1oLbmRXSyQrHQCGNOszL6TUBMx1jjecGEeuyFgWiNyYNJmTHuCx1ilakfpaPXMev0pBXBaUzYXX+zHLIxskRYZ01nYNauxmLUqxXzKez+dFNyRAv1j2uWTzandMf5N0lqckh1Xho09TCL6+MRa1hlGaqpJPI9OU5wxouM+4eJ4JzOG18+TAGP+JtCp8p3cdBK7YvgdvXuBGlZnsMZZVV5R6fZXpRwIOng3v7p80zDnyIihmQMNZ6Eq8wa6lyCVqrop1UZKbK5/AdaoEdDSHSMUhx/aiU8rQs1xsrofu+dIbEujfWlKJkkyEs0pEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4XPoTI/yiu2uIwAE5TQ+RcXzBLSM60yttcM+2VhNFo=;
 b=3Os8csZOcRyDiEs4aOlBqXkavAWaOGD6p0JOjDiq30cXM+kogSE7JdvxKq/8QHyHxtACnutyljKcACpRuht1zbgD4GL2Zi7Ml29BFebO7EMdtqDjvFMe2cZONbkB5CFfh9r8M10C+dMjlUTsw6yZ2icBoobBM7dZ3w9IhQPDMDs=
Received: from BN0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:408:ec::16)
 by MW2PR12MB2395.namprd12.prod.outlook.com (2603:10b6:907:3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 17:57:42 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::5d) by BN0PR04CA0101.outlook.office365.com
 (2603:10b6:408:ec::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 24 May 2022 17:57:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 17:57:41 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 12:57:40 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] May 24, 2022
Date: Tue, 24 May 2022 13:57:16 -0400
Message-ID: <20220524175724.126380-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02f62938-e74a-412c-857e-08da3daee5f5
X-MS-TrafficTypeDiagnostic: MW2PR12MB2395:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2395B7CFDD6473DB58C5D224FBD79@MW2PR12MB2395.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ckJHnMrK/WjRgSETDHNSZUtWZKMS0UfmO3XeevZOVGi7kAM7xYvKq2CaMLvGgdM7dVbPG5PUWg5HdBElViPy3AMDlumOqT4EJjojjZoGrAU+CTlTLqcxoE4sPKhHRuSve+bMbuvpqZfLX922ptVfhGB8rbd9eP5GsZmjesjdjyVXDbU8k6ZnMqmXKs11rfWGsCPRDItFrXJcNmlEKGNrAnpHDK+V5e4h7/vbMsyvseryVsVQi6z6M2swn84HJX1ST/AjQK1nMoZ0i/qWOWoB2Ohietkstpzn5N0zBYydXPtnSFYpx8qrQ1HrMvHl/LyJZhGJ4Q3WP+5pgUTQjP4Ydi7g2sm975IHTOUeciiZU3C2CQNzRx9BifMBSKAoARiXOLbyv/9InnJGmsKSw36orxTLqE4LjDS2sRo2npDCgYH1svJ5926yxLIUHYTjPBcCES94tVu0HeoJ2m4JsxnZoWDx1fahi69ZULARoeGUHpHQD2m83wWFQDajn0TFVBMTpwRh2pBK1gkasRh1lxe5IeGM84thLHGIgXy5EmUgRu6V2qpTdmZ8CQZjORd6krFt3MFTDAe+UvDsXR0qcw8kfCaw+IoMsrAw4rNx9UL9wp4g8lmlSYk7dw4cdfRm9FdMzAmsaKGbB6CnmvuB60PMsGLLKD2vZ7Ie7HQHZYdNR/LTcmq0mgpPZ9HkwUxP3szz900+KXn9cZNlcxoLB48WtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(2906002)(186003)(336012)(47076005)(426003)(83380400001)(1076003)(2616005)(8936002)(16526019)(36860700001)(40460700003)(5660300002)(36756003)(6916009)(81166007)(8676002)(4326008)(54906003)(70206006)(70586007)(316002)(26005)(508600001)(356005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 17:57:41.7398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f62938-e74a-412c-857e-08da3daee5f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2395
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Changes to DP LT fallback behavior to more closely match the DP standard
* Added new interfaces for lut pipeline
* Restore ref_dtblck value when clk struct is cleared in init_clocks
* Fixes DMUB outbox trace in S4
* Fixes lingering DIO FIFO errors when DIO no longer enabled
* Reads Golden Settings Table from VBIOS

Alvin (1):
  drm/amd/display: Don't clear ref_dtbclk value

Aric Cyr (1):
  drm/amd/display: 3.2.187

Hung, Cruise (1):
  drm/amd/display: Fix DMUB outbox trace in S4 (#4465)

Ilya (1):
  drm/amd/display: Fix possible infinite loop in DP LT fallback

Leung, Martin (2):
  drm/amd/display: revert Blank eDP on disable/enable drv
  Prepare for new interfaces

Nicholas Kazlauskas (1):
  drm/amd/display: Pass the new context into disable OTG WA

hengzhou (1):
  drm/amd/display: Wait DMCUB to idle state before reset.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  19 ++-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  |   2 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  13 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  17 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 158 +++++++++---------
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  23 ++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  79 ++++-----
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  20 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   5 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |  19 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   3 +-
 .../amd/display/include/ddc_service_types.h   |   2 +
 19 files changed, 233 insertions(+), 162 deletions(-)

-- 
2.25.1

