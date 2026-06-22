Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6E4CDB46F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 17:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547DF10E620;
	Mon, 22 Jun 2026 17:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VDAN5r6c";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B338710E620
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 17:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTaQa/Z3v7nNMQJgZ+haYFnII6DOE8kbEz1qjVs5XH+enulY1JTbVkjfhZg9KKpookFH6x+UbCjjDcz9mbRTdzGGlFTok7Lf57l/FtYR2/kH0ra5eoQIgn2wcQhbdi94TLsAmXW9aeg9q2rC+Lgy8ZzHkIKvGz9lpwwIoDbI/qUFit8G2Y+Xm6tNHKWOvTZrATbIibJkKpa7UFpQPeRJsKvPYtafJkgCMhoiWe/PCh6IJ2TQMUGGDdDo6sWVagMversC9euYdoYfD6lKxhnO2+19Q+FequGLQVHFyTy3VPzaWRATcNMAgRcmC9u5TO2XFMUIWLQC+BfEfyjRfPFzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/Rhkl8odxMoLReOPT+4FBQnlAXxJn1o2mG2SvHjo14=;
 b=TE+Cm2KDpKUXFxV+AKq6XHPPJf1Vs7qn14yvnzndrcao4WcylhyorxgNT9A4dPUTgUiwcLZmZk4fpWRleHfj+y/WV514oLLyqEbdHbSLcoxTPFcExe0uw0gq82wbQ3WiZhzLzmTAG06Khm/wDOKmL6m7nhsopNA5H6djJgdbDkm8itwdlR/m3/K333gUTtW9R0avp+C3YhE/IR/gUQ1HJRygdHYkYVCpn5+Qw5OzZlsY3BdEmulpZAD1nq3UV2ljoIu8KI8OHMKkcX6pr6OUzxXQo5pMvWEaCh8FKJqHduGJ1REQmtF+7mShZ2/BGydSSooAsciN1+t5y1gHSORGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/Rhkl8odxMoLReOPT+4FBQnlAXxJn1o2mG2SvHjo14=;
 b=VDAN5r6c+vNyf60j9I6YEN+WqRQiFqegTgvsO+c4IiQFNNhEOEmQKzI5Nqu2vN4NbFAQzXuBSq6W+HKCZ/VGtrkFQFfd8+3DmmFuW+E2TZyBexyuCtio4SEUUrOwU9CDtXFgagvN40kp4WGpymJwa5fXUok7UK/x2cW9N9+m4IA=
Received: from CH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:610:32::24)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 17:18:01 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::16) by CH0PR07CA0019.outlook.office365.com
 (2603:10b6:610:32::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Mon,
 22 Jun 2026 17:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 17:18:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 12:18:00 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport;
 Mon, 22 Jun 2026 12:17:59 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
 <wiagn233@outlook.com>, <sysdadmin@m1k.cloud>, <timur.kristof@gmail.com>,
 <xaver.hugl@kde.org>, <mario.kleiner.de@gmail.com>,
 <michel.daenzer@mailbox.org>, <matthew.schwartz@linux.dev>,
 <chris@kode54.net>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 0/3] Fixes for flip_done timed outs and PSR/Replay
 corruption
Date: Mon, 22 Jun 2026 13:17:47 -0400
Message-ID: <20260622171752.73374-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a782995-8e2f-4e73-89a6-08ded082363a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|32650700020|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: t+s9200KVInaVdKEf/d5kIDW75FwcbYkCWot/uaQo4Grquc5xGtjSWduuKED4ljEqFpdE7IaCVm3mj6qMTz+KTFCmxQj7NrhmZir8oCyvyDTVPlNGkFOsR+S4hu0+4bJbT1acVLPvIu3STmk1V5Ho7b/4qAPHGemNeN1s4tjvc0EjXuPue+BIt08OD8YTiPo6HQwlR96bLUKtlofz51+e/tmaRNXo7obmIWs4iqwJ/5f1jgNdXSHvT/dZYraQ1kcp4n9xD0LFg6JBfc2MpubR2mg22dpDeT5xDpIFeP+c/4DH3TI8XwGenYYikq4JQ6bZGAQ8NFJn6trCjTMn0QLnDGhgPZUaO86iAWx8SfGReKksXfJOwv3h8viuHYQi2lE59Fp+JkeEJgl97vOhFj1S8+jCfbARLE7xvfk9jjGT6Ip6GgM0hhVfc6phdSJDs4UHpi01ich+7QZ1J/1fIwVvpsoSmnYZp64dTK1K+q88j6hSlT/1pv3BzgilsW0yz0QbkWmQiQq//Z6e2OVswtq98WDsIiRNmX6E91LoS9jvysE8wZTVkbsraTJ0MK/tSihfoGzovIfh1EO9m6fZARd4qODNRXQnsLe7g1kyAxLpbW1GxUo2lFLfnVJA7V+fybE7zWK+Jeprc78/yaWNZiYjnGL9nbKSboUzlZS7bWqm9c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(32650700020)(376014)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pv3ORI/6KVMpWmcEnQtOL9Xnhsr0a0IHgisHv5OYXhqFXMyeH0tm0KA0U/YjVZyAVYuYorVzHb3EmZbZUqtRPQ0NntEasv+VqYa6qiZn8pNQxNQMrQnwEdGSnB6K6HJZYeYuGTY7Eq333d+AFhMRBD6y6ZkwP25l8Zr43RCIMDNlBJxijwXvD0LFT445j6VyOM7X7Z3HNYHq9vqxMY4EdFx9CO/EmOP+kcCCBx2CjelQNW6ggZqdy7nMsHT4Y7YxA9TItK8VNSniM47ENz0s2Bsc6CauzHPSzJ4Ce7LB8xa+gWumooP6+YIleeHM/f+6WnGJa2XcO31spOglQ5YRfDpunndp9rL1xI+Y5X2/rPXFJr0XavWilP1odlG/O+iqhR4wXJlxfIXM2J4A9SA4dRCkYiCeKOymJ46G3o0iuKLPlnNaniDnyQKgGCqm4zpK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 17:18:00.6707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a782995-8e2f-4e73-89a6-08ded082363a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
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

v7.0.y based branch here:
https://gitlab.freedesktop.org/leoli/linux-asdn/-/commits/lileo%2Fflip_done_timeout_corruption_fixes

Summary of changes since v1:

* Clean up old IRQ stuff from switch-over to VUPDATE_NO_LOCK in
  dm_handle_vrr_transition() and dm_gpureset_toggle_interrupts() (suggested by
  Matthew Schwartz)

* Drop flip_programmed completion object. Instead, move event/pflip_status
  arming to after programming returns (suggested by Michel Dänzer)

* Update vblank event timestamps for immediate (tearing) flips via
  drm_crtc_accurate_vblank_count()

* Check for HW latch after programming returns, and if latched, send event with
  timestamp updated by the most recent VUPDATE_NO_LOCK IRQ. This avoids waiting
  an extra frame for event delivery on the next immediate IRQ.

# A Note on LLM use:

Claude helped with code plumbing and IGT testing. The effort of reporting,
debugging, spinning up fixes, and testing them, were from humans. Kudos to
individuals who collaborated on the amd-gfx mailing list, gitlab, 2026 Display
Hackfest, and AMD internal chats, to finally nail it down.

Leo Li (3):
  drm/amd/display: consolidate DCN vblank/flip handling onto
    vupdate_no_lock
  drm/amd/display: check GRPH_FLIP status before sending event
  Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 193 ++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  70 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 299 +++++++++---------
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  45 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 5 files changed, 375 insertions(+), 233 deletions(-)

--
2.54.0

