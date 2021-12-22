Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBD8C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 22:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0935610E33A;
	Wed, 22 Dec 2021 22:05:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0771710E33A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 22:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNKs6PFUgb/HXctQBL1k2RZfr7cWgTVuD6hYDpxK14B61IT3uQ1k2N89XjBhd6RoIe7oTwYayi02Rle2ZmnqHmuUAbJoFVwQ5COyh5F5JhMwpMWvkrA6K+sC5xyp1u9slmj15EKC1gag3dpvukT3zLltvqJAalsbHTbEQCjSr6ntVWUAjsWbMhNe+oAICIsPoSl9AQdSiS7GQO87+9p9pFOWayZXqKyPSeUW+mlu/SOtrrWnuxp0DIinJ4YypqiYzUBU+RM/brCyw48aAn1adXlSb3p3HzGdDxoTmOJpz/oIN7xsnUeWteZBJjeDZS/wufVtRa0IhRmIbpPVxZzhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eQs+IrzngSZ8/5wCQ16Irs1Kv9kXh3tAnGKx3U1Dts=;
 b=XH3rX3Sw39Eyh9f0Acnli2D7pUY6lfD3yn7a4uqltfWYckyZ93oX9tjqAavOlaDFzGVirmD9VYjF1daogVJEc+xPGhw+blLW80YX96RF0F1SLG3AjMw7n+ej1dr3jeZ80QTPxIvUZGYEWeYlEMevbW98OTRHPSFA0at+meKDyhC1SE6R8/b2XnruuEe+HMv204BMYttO2sFwwlzjofosm2hf+9jFerHIGCOvnjxrk5ITzyh1UeI2tbjsGHr8wthi3YuPagk5HUDz67/DkIm0b8d6y8qB7I8NqnWfPmEo4owodeqe37O1SKMIeZ1AYpyGahYD8CYNlwng8rSI3NkWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eQs+IrzngSZ8/5wCQ16Irs1Kv9kXh3tAnGKx3U1Dts=;
 b=nkQvWZ0DKlVUio/z0yMg6Pe+Lg5z+ooBG3G5PVSeT+G2crdVwfvme93qXLi9GFzjHtg9X/djZeATw7v/KwGviac9AhMvVhZjchY8ETv5rlLdgHEe8EkvefsnJ8ZsBv6w1Yz+tecK9ct0+mcnvBj723QwwWfOrUAN8M/6gUlnKbE=
Received: from MWHPR22CA0064.namprd22.prod.outlook.com (2603:10b6:300:12a::26)
 by CY4PR12MB1910.namprd12.prod.outlook.com (2603:10b6:903:128::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Wed, 22 Dec
 2021 22:05:44 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::67) by MWHPR22CA0064.outlook.office365.com
 (2603:10b6:300:12a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Wed, 22 Dec 2021 22:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Wed, 22 Dec 2021 22:05:44 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 22 Dec
 2021 16:05:42 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/6] DC Patches December 22, 2021
Date: Wed, 22 Dec 2021 17:05:13 -0500
Message-ID: <20211222220519.1682537-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f34b5c5-e020-4923-b86d-08d9c5973356
X-MS-TrafficTypeDiagnostic: CY4PR12MB1910:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB191039145E88B050FDA6E93F987D9@CY4PR12MB1910.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiuQJBjAZhmZJYpnMQvQykU957P+O+vU7MSmSLUSjrhjf5tH+FxovN2FG65NdlpKpSjd80C6trWwLNlXp11Cju4mxTX818awl0M8Vtc/sWZtkXCdlKENcgBMvN0yaQAZevJVS1kXKjQeDZhw/ocXj9jDtyaRR0sXwsNH8lJW0q1nbkdZiBnlRmwRBax14Rfwb4t5SZ6P0p8GTGQrtrX/x29CijTwwrCIH4/pEehUQgH9MhHkl6+FJYtohOd19XlRtzd0Xr0WJWBHF9Jzr+FRLz1CoaGZbb6Xr8otX6w1aojUJYAbFZHrNln8Q0dyXvehmkngujERZ0tD/vN0Iy6VM5U+pJqfxu5ohttU95LTyYMj/aUrBBt84u0Xgj8VGOxN1eA1bHoO0XFnwxUaGR+adBwy3/Zgn3eNoQ/N6uKPT3GWYExo+EXeLQ+3Y/wHo94SFTII54pxagaazJmSmYgMHjlFMssVBg36bHpySzi8uqqJF1E98sQGhY+HyhEe0mExPmFEYfDy+qS7V8/61/khMZbeh0qHwNXPzirxIRyTQQvuy7cliia632lQwu3WELr0Vye8MHGc7vOUR9r2DDZXqNgiZuk3ObjKA+FuxerOIaCY/WEbBVttAe1Rvs6e4AfbmCHILK1s+XCP8YT3SsHGGsfujKXrzKO1BRuOWmWqNnvGfsU7fEp7AU5kTevMIsiRtaSdSv2JdNfeUJh+/qTBqzkc35bonsisdgQ0yA1knRIcbvcBNtGaHumLbWtyrUIeeEOMeYnsG/5qGwLJe9DA+4nAPI+1T1GhokbrLMTG8fA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(6666004)(83380400001)(1076003)(8676002)(508600001)(86362001)(186003)(2906002)(16526019)(26005)(36756003)(40460700001)(6916009)(2616005)(8936002)(54906003)(81166007)(36860700001)(70206006)(356005)(70586007)(5660300002)(4326008)(426003)(336012)(82310400004)(316002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 22:05:44.0128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f34b5c5-e020-4923-b86d-08d9c5973356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1910
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

This is the last DC upstream of this year. As a result, it is a very
tiny one with a few bug fixes.

Just for curiosity, I decided to calculate how many patches we upstream
via this weekly process in 2021, and it was approximately 740 patches
where Daniel Wheeler tested each patchset. Thanks to everybody for
helping with this process, and special thanks to Daniel that validate
each patchset :)

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Best Regards
Siqueira

Charlene Liu (1):
  drm/amd/display: Add check for forced_clocks debug option

Mikita Lipski (1):
  drm/amd/display: introduce mpo detection flags

Nicholas Kazlauskas (2):
  drm/amd/display: Don't reinitialize DMCUB on s0ix resume
  drm/amd/display: Add version check before using DP alt query interface

Wenjing Liu (1):
  drm/amd/display: unhard code link to phy idx mapping in dc link and
    clean up

Yi-Ling Chen (1):
  drm/amd/display: Fix underflow for fused display pipes case

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  40 ++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 145 +++++++-----------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  33 ++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   7 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c | 114 +++++++++++---
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   2 +-
 10 files changed, 234 insertions(+), 116 deletions(-)

-- 
2.25.1

