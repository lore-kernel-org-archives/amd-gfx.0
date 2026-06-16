Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9D6CD98E4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 20:18:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3946F10ED89;
	Tue, 16 Jun 2026 20:18:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgmnEZz1";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6E5210ED87
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 20:18:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxfiv5RjQTtquvy2ae9xfNzeEg3BOioNkYHdi1cJnhpUYurUyane2rY0nQbxmFoEOryk8TTo5hOxlQcp5pNs2B6foLReIcskktzeGZjzY5wYK41PNErf7Wm18x+EqcjeHeoV892IXcVoUXZcOWTPlm0pLU4A115k4HyneC69deBS0BBYzxMwIvVE842DDdw+xN4AcEMhrdqz9x0+DmmjqO2lcTMP+Azr8cYMQLnlbKTWx5o849MTSuALDl+MGujNumOWD7uMfZ6MHsdOQzHxDLwvxLaesaFktJldP7idODUkq4Ht1MnkOjK/Gt93kJfd7uboRa55yRQN/3z40t/czQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z308HH43mfujfGPQOxCanFhZx1ZIKPVGBWNemvlSLM=;
 b=WsOluEacKCvLgA97B45AZBbbHjySbpue2nPP8peKz2zT54ngSPNFIbig2FGgR9Zo5PhsCR04xyJ3mwqtEDTxGvrG90w2peBYm7O7Jo7LnLO5nBrDGgnS+2IcFOFVOhy+AIbcd9QnLvU9GRGFR2EwDqri/NSeAjbpKiUZqw5rHAiAYo5G3c1bcrWMtig2VefolfmxTUcPMwvi8cloGrRZlxdi3lKsAmEQQ18VnwhOZLU4CNgK9FR4pk8VKgv8f7XKlUwhLzMGUWVUhOkvzpgCBQLRfeDOSzWNoM7vpZuFinVMli2gSj+DrO9jJnu97iKRipgsH0BexHXe0Pw6cpOsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z308HH43mfujfGPQOxCanFhZx1ZIKPVGBWNemvlSLM=;
 b=GgmnEZz1tkZZBI5+Q+MGLO34YzoSE8rjOOusf78rGZWXL1IuUgWH4Cd1bwYLO84RpBnHq+exWAuDDk8KJKXxHfn38jutpr1JktVlfxSwf1/u8vNOQaPwFGO0KklYB3xK6MgmfElb6pb6rL/JPHHqGR5PXZQKDIV9QvjIonLngLg=
Received: from SN7P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::32)
 by CYYPR12MB8938.namprd12.prod.outlook.com (2603:10b6:930:c7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Tue, 16 Jun
 2026 20:18:47 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::51) by SN7P220CA0027.outlook.office365.com
 (2603:10b6:806:123::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 20:18:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 20:18:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 15:18:46 -0500
Received: from flamewok (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport;
 Tue, 16 Jun 2026 15:18:45 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>, Leo Li
 <sunpeng.li@amd.com>
Subject: [PATCH 0/3] Fixes for flip_done timed outs and PSR/Replay corruption
Date: Tue, 16 Jun 2026 16:18:25 -0400
Message-ID: <20260616201828.389985-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CYYPR12MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 66aa6106-ec51-4e9b-152a-08decbe4787f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|32650700020|13003099007|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: UdupEwXTXFLo2kIk3ydMdmlLJPiRE6OZBPIN49suAFAqupQjtfmj9fRnNJ2+vuGlJf14Hk0o1K8F39JYGhnU8la4HghQNvAHgSveFKgx0WfKWWATH/W0qusL6ZqU+KFpoyMxMuYjbhD03clzHtQUevtuAR4tNUdPJI0+uKljHOVOa7l8/H2/6YZepmn5G3R9HrlMnq/GhtOoVXcKJpDDM2NCwnYrk30zQvj6G9t3x0G+Q6sBNGc7QQHhfkFimJztXG6qkgowM3fTSQoXvGUXPVJIFEKEcz8mtfSONgkZSUK6HRvpLQlTF+M1P6q8sOo33tZqi+/K8zQ/tQa6abrA/eIGnlqq6RCy6adkPrCAn29TdkOfzefwcRTvfP88nANYvD4/e1d9E2MVzu2W/CbC/plUJ2eJHTOAd/AB9gakFTzo2ldrrBARZEjNRSdhalnhYCq/ylCT3DKAZKNDF46SHPBfrxgWKFCsn/KERV6AJT8hFNQNwcUfNTrMj9h7p1aHjIHV7ZSbvTUb1D92hu2RrNnfz26zr/MkXsEF9Lmyqcay1NPLwhdYqiH0PUEElaS2rTB4/s4a+Th+w6Zd5B8qazElYl2ypdwUV2A4aB389e/DSc27H0XEknJvE5X5hdI6YpwQyBqKY2fSUoV1WOGzXP6CVm0k/u4aBQ2ILZqbg+kJ22pOFZCLQc8zEYM5JpRI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(32650700020)(13003099007)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OmvZVZtd55n7Y9eQQwmRZl0Q7cJMprrgS48qLD2QcbtWWYrmLUuv8/41IjaAVLPdChRWvfiYs24PP3pV+igMn4wQ3PiQ1GIW3g0H7v470xMXsyPW6TebP+lfQZj1ZnH93fjRL/j0k2+WEPdZoyjt46eRYTFRykrml/b+5ue58VcTzUcDn2YcnOJbiVfOsLOn80ljt0TOcZCqlBO3yGTRojM5Ib6ALNI9rAAnAFTG1uK212QgcCKSBwzruq3O7stZXEt22xsxXkbE+6PjwU6uex9vt5rBQwzRLbAkWX/BBt9fJOzwngyDNLjNEItcoLbK44IcU3Gtrt7fl0/PkCv0vv3DcLWZSI+MwHn3I8/xvWVsOMxqC38KGQUk2tShaaBAJehymaV8A2KrE7pyCUn/bUjVDAEJkeGCRQaP3pbkzLrUvkJR6UJ6DFh3rz1FjRGt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 20:18:46.7104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66aa6106-ec51-4e9b-152a-08decbe4787f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8938
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

This series can be considered as a v3 of this:
https://lore.kernel.org/amd-gfx/20260519220529.202096-1-sunpeng.li@amd.com/

However, the approach to fixing ended up being quite different, hence the new
series.

Instead of adding vline2 as an interrupt source, all existing DCN interrupt
sources are now combined to be handled in VUPDATE_NO_LOCK. This source cannot be
masked by any event (short of disabling the output timing generator), and it
fires at the HW latching point for newly programmed double-buffered registers.
This should fix a majority of flip_done timeout issues in the wild. See patch
1/3 for details.

Patch 2/3 fixes a PSR/Replay panel corruption, caused by a race between the
commit thread arming flip events then programming a flip, v.s. a interrupt
handler delivering the armed event. Also it's commit message for details.

Thanks again to everyone who helped with testing and debugging!

P.S. Since the fix is on top of some major refactors, backporting to
stable will definitely cause merge conflicts. A v7.0.12 based branch
can be found here:
https://gitlab.freedesktop.org/leoli/linux-asdn/-/commits/lileo/flip_done_timeout_corruption_fixes

Leo Li (3):
  drm/amd/display: consolidate DCN vblank/flip handling onto
    vupdate_no_lock
  drm/amd/display: check GRPH_FLIP status before sending event
  Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  75 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  75 +++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 304 +++++++++---------
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   8 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  45 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 6 files changed, 302 insertions(+), 206 deletions(-)

-- 
2.54.0

