Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17961C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 18:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 806DF10E231;
	Tue, 30 Jun 2026 18:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Phv4S/vR";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012063.outbound.protection.outlook.com [52.101.53.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED31D10E1AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 18:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5+NSK3reiadOa1Ts4bdRb98mnFAiClRtVQ+JjFZT933Py8Hbda0tLXVC9eZ9RBoYRtlJbSu4cDyc5aUXgXnXlSSZ3Xxm3vw1Oko6TrC4yLndc2kQzLqB2Ria43oZkIyyec3kGgwhgoIKmKT5v8+T3w2lWGxNunCfErvWMkBq2M3fVvBAAak3EB3cBZEUc7Q/e9KcSeFx6Pba9nASFPi8nSxv5mYltxX18obB0GsMyElrNPWdd0TwsfvOcTZGb6jZiUsaVXz/zLvWDBUWINbqGJncWthXiAdsQkVEtUacnRmsdoweuU4YGrYJwaiycHoSX4ZRJzHVGz9H4d5ArE6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xp7/4MSwtVIi08Qhqbk+utZf1X0uAnIWqDXKbebi77s=;
 b=j+ON+bjk/DmkcPuD+y2k/PuS5dbxc+VeWFOa0lehdREcjJlzIZqV5tav3cQfQlHOtWW2ckVULoheUGhR3+8RsJNeLt4v461ecWJGrxwWcSENeuHiknf0CcTILMoFoLJ4RhqvXAdcOEPmQG/GHyaqQma3YRszMsjq1rJAGrBDJ/Ca9MTlWga4TepQnSw3z4PlLS+JJZomGmIaCx0PubfvyVkq6t84zm0htm9HUlLbVgkK/tH79Ibd1YlfhdgH2yHjZGDrbA9y+0tavPBJcby1aLnorer5t2HeEu/In4eq8CaVCp0D9aXrSUsVlFBwjbhVG24KBjTW24tk0vBXjRvoBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xp7/4MSwtVIi08Qhqbk+utZf1X0uAnIWqDXKbebi77s=;
 b=Phv4S/vRnEzxyR2aMT/yJzDIzSVRI7kJRjL+GAZd9JzgTUECw8Y2A1/9cN54xAoTJNGbBIFkZs5HImU73Md5n/udQI3P/75NX68V/Yy3Z5ytag1h88wwUbGIuEh27CZxnNE3pFIBtzME10linfI6HD551VdZTrN10jed4SqUHIA=
Received: from BN9PR03CA0491.namprd03.prod.outlook.com (2603:10b6:408:130::16)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 18:03:24 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::9d) by BN9PR03CA0491.outlook.office365.com
 (2603:10b6:408:130::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 18:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Tue, 30 Jun 2026 18:03:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 13:03:23 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport;
 Tue, 30 Jun 2026 13:03:22 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>,
 <michel.daenzer@mailbox.org>, <matthew.schwartz@linux.dev>,
 <chris@kode54.net>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v3 0/3] Fixes for flip_done timed outs and PSR/Replay
 corruption
Date: Tue, 30 Jun 2026 14:02:58 -0400
Message-ID: <20260630180301.362070-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fb5e66-471b-417d-70ce-08ded6d1e0b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|32650700020|23010399003|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: c6VkIpkPPgBWlgCJJYZfg63TVH6bSFIIjtCexYExe8yxBbFpJG2kHhn0geSQS7Em91savdF8ImpQ/SGn7Hyk832Xm0wkmNq0GyBS17xV8jv3Ka8xi+9QERW39NzMtm5chdZ+dB972+Io33lqsuQKRz8QVNPmyMP75QMUsuDZFV94j+8q90f5xf9Hfnb/DDtKjkZChpCfX4mZ+klmlI0CnqIUUof7nu4xu4wKGVX3kxiMVSmhWh7SOtV/Lc54QJtRKO53OqjT1NAxHLKnMm4wafQbDXGFPjrTxffjQm8RBlPcf2WyuwdOzQ8N20co4IA9yrNmGGwNzfnTGAyNkJqBKVVjtunkesP3S6WVXk47Zo4NLIvbdg0TNI5TLxSu8TlqIA9C/CGLs6o7SkuYUfeMDE5/9tNFwo1VMvsTj0TLcsv8d5vNsHgo9GP1AjsiFv6UqR6Fpq0AuDj8fppZiuM1Q8Kp/hNuQ0QkJMS6oPJ1CowFquyONbAlfoF6QS4C70DjmXnnmLNLOdp706sJCZdxHIieRNGrBaHxeMsRdmis5HgwBh82UZbx7XIA3idJzp+FBfAnMhHrTx89IrjGorGWgsDVStElHzWlsSgM2q30Gx4fEiyrnqes9fQ+rwTtouv7unMtRWIkJ7c/CzGQoCixzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(32650700020)(23010399003)(11063799006)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MwIKfook26nJAFQfIM2ERGjBUK08jkM3DeuOkRAJ6yCfeicXlnB0tCCBWpKcDXY/194sndHgNMhyCQ7MPZyNiAJaWZAum1iBDVpdzjou1IOPEO8c5ImB6189S7Q+300zygACz9eZVpdgLAndON8CExMcrVR8Q3bRry7X0xaAErDeTaVVM0jL8QXWx/LZHStNBn/m5FE8+YfRDGPUe+5kj8zs4fqy7Wst+QdaTTvM5MfqGTem244vhMLPUbXNjF8AxyF5KRuTd0M/l1T+yDb+cR5yCgm9H9m+y1mq80R9PchjXPiM11/RO96HqvGaGbbvQ3xN9yPv8XzGSwWVyl5dg8kNE7CXpHPFcd9Rc3NGiHdS38xihuC7Hp3e+5R/vHtwonQyAsQ0pRfX+cN1i7AJh4xF3AwejRW6ihoXLRLx1Ox71fFlhb144rydMzloomN1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 18:03:23.9199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fb5e66-471b-417d-70ce-08ded6d1e0b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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

v1 here:
https://lore.kernel.org/amd-gfx/20260616201828.389985-1-sunpeng.li@amd.com/
v2 here:
https://lore.kernel.org/amd-gfx/20260622171752.73374-1-sunpeng.li@amd.com/

Summary of changes since v2:

* Fixed a regression in kms_vrr@flip-basic, which exposed a scenario in
  optimistic event delivery where wrong vblank timestamps were attached.
  See new docstrings in patch 2/3 for details.
* Readability cleanups in patch 2/3, thanks Michel!

v7.0.y based branch here (drops the revert and resolves merge conflicts
due to recent refactor of IRQ handlers from amdgpu_dm.c into
amdgpu_dm_irq.c):
https://gitlab.freedesktop.org/leoli/linux-asdn/-/commits/lileo/flip_done_timeout_corruption_fixes?ref_type=heads

A Note on LLM use:

Claude helped with code plumbing and IGT testing. The effort of
reporting, debugging, spinning up fixes, and testing them, were from
humans. Kudos to individuals who collaborated on the amd-gfx mailing
list, gitlab, 2026 Display Hackfest, and AMD internal chats, to finally
nail down a fix.


Leo Li (3):
  drm/amd/display: consolidate DCN vblank/flip handling onto
    vupdate_no_lock
  drm/amd/display: check GRPH_FLIP status before sending event
  Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 234 +++++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  70 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 299 +++++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  45 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 5 files changed, 417 insertions(+), 232 deletions(-)

--
2.54.0

