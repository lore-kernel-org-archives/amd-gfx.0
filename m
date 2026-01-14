Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8315CD39011
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0942210E04F;
	Wed, 14 Jan 2026 20:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QfSjNFHm";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74EC310E04F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTRlaYPX3MZbrFXlWr2jsF8zX2EYxeLA9Sz6i0cVviwzMoiBjuufU50spr1pahOVILrhNiqNBq0qQJP71rk562q9l17X18FIkyxSFlB3MIIa6iVzD0e0dppiDBLwV4MVJ4zztd3tp23rMBdTw38AG7VZkKUDuyfmIPWi+WHsQCR7PqwfhNAen0RzKSUjuwu4R9fya04lxl8yfUT0J+8PdhuAUbQPupQHV0bSDwpuQJzWPdryqA7kFTx3n3jBD0kHunSILi0UlfPuB3plJovZVwLySp8f2XtaFGxZLSvP5ooC5uqCaHBzlUDCtBclDOcZB1U/gx0RsohjJbz6DwjGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI7q1YzPizUZpHe9MzxqXIcro9Z0ttiIL7VBbUzL9Vo=;
 b=seDfLhChoAJ0O6LKO//HYiVcY7AVQgF8+bIyw9zaPh6xdwXHn1SKh6V/vkkIEfizgfAntUWqcj0Zp2v/OB+MDjq6A2tP02CGdCD/UawpeWJbHaJS3okLxBPrQ8ZDWxN4jf0+bXHTWHkarUwC2EPRgGeOrTgk7/wtIYmR45wqYg+fANqwaSn6VELMmL097fFd1qwj0X7xSFrwFjJaieNQqaS5SAHkgegnfZCgxWCbk1DfwsLb5QSbYqgT06+x6FhZIRlORZZn3JewipWqsYXojKmZWPpuBaJ1v/jDir1MEBKKFfTdSyJoknllpczIQ8RlVfmwShTosNEzsojNXBD1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI7q1YzPizUZpHe9MzxqXIcro9Z0ttiIL7VBbUzL9Vo=;
 b=QfSjNFHmDZDj8jZFiEEtynkq0GfyRMBt55SOHkPWI2BySYRqtyM+fhCUVZkZAucEUlJH6l0Zg5SgZYKxnhkTbWJN0L+eQdGp8xPbK35fz8+WlJRjJv6X4NQAsi/dwWeP94ZWUXBvThVl+IM4RETjoyZD7Nuwmr68NfXp+s+OuGM=
Received: from SJ2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:a03:505::12)
 by DS5PPF884E1ABEC.namprd12.prod.outlook.com (2603:10b6:f:fc00::658)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 20:24:00 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::7f) by SJ2PR07CA0007.outlook.office365.com
 (2603:10b6:a03:505::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Wed,
 14 Jan 2026 20:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:23:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 14 Jan
 2026 14:23:58 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Jan
 2026 14:23:58 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:23:58 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>
Subject: [PATCH 00/14] DC Patches Jan 14, 2026
Date: Wed, 14 Jan 2026 15:21:41 -0500
Message-ID: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Matthew.Stewart2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|DS5PPF884E1ABEC:EE_
X-MS-Office365-Filtering-Correlation-Id: bc901058-a79b-4c48-927e-08de53aad9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NgaaWQ8b9FhXgpYZQTCY2+EbSFnwK10P1pfwjscc3mCWScZMvQKScHKPrcwK?=
 =?us-ascii?Q?14vJ4SoC0PogURF7Q/+V5U9jJXcUj2eKxYK+ExInws9eBmPeBl+ZBLxuMG9M?=
 =?us-ascii?Q?BQzROzU+fHgKNfnsQKhy3ewfeEcO3Rl23ZqJjXLFAnFmG1BeEqOnDAqSB+R3?=
 =?us-ascii?Q?xVcECzRqcUT0S2Uj3b/oLVuTdUr95Sp9OihgMh1B8rTbzV033hr052DkjWkp?=
 =?us-ascii?Q?EjV4U72XOycTDxXqPsyWoyVKtJAXEJXYGgXkr6oDshEkcbfpJeMlHRzb5Jje?=
 =?us-ascii?Q?pw0pHEYx8X6xcWcj+zPL0obmc4wtJmhGxFPvOGQFlyr0nOu1fKCT40paU8Z6?=
 =?us-ascii?Q?JjHEjbJE6SiOECeI42IoDWzOc6cF13/EIyQf/5LtRUtWtUbzQHELb5z5mIiY?=
 =?us-ascii?Q?hE07s3WOG+RNLwUinSDu8ivAXKizF275Th1A8nJU9MhG8MNHF6vMVlu3A1zz?=
 =?us-ascii?Q?ctEAHWgl7yd/o8e4cJVdgkIYgPq1AkgBgdGyNK2z485+AN5qfi/O1S56rGlh?=
 =?us-ascii?Q?hV/6ro2veIWt19r/kw115WZmZDXec7UY0OYctu9+LL/3sICaJ+UqHklBu+Pr?=
 =?us-ascii?Q?UCc1nwkrIKWnVl2u3dWWijWgJf7MuuVoxjwRd2ErpHOjts9IDJXEzhR8E3PB?=
 =?us-ascii?Q?2W+YQOUWwe+kI3lTFAIMaac3HnG+8jtGQo4UHNHSVBDWd/cLW9OWbf7hl0YP?=
 =?us-ascii?Q?68gW0yi2265S3UlMSiN7+py0SSjYDn6X3R1VnVmxQhb5+eSjD2U6zZi4BVoK?=
 =?us-ascii?Q?Lsr8DIt3TG/rdVZm5QQRa2wo2Jy6aUPahQqVTkivBt5blaFT4uYq7G/X+a3E?=
 =?us-ascii?Q?Qa3tE8GrZqfdz4Y6LFyDMCn609V/rPqAdi7pSKaP8t00feDJBZ9V77i1o2to?=
 =?us-ascii?Q?W10d/+cGvjfBIn07LTB3n5svIBWPl1QHgbR2o6WHrgHqNoRqLdbjqWvFaABB?=
 =?us-ascii?Q?7bfo7OWIvmdxZ9jMOpxc4UwddGJFeG4Uq6H6aVVSs2CvFrUvYL1s2HCmov22?=
 =?us-ascii?Q?ItSJEN5SHyPS9QKz9ePybHs6zYmBcQshivjXqgXOq/3Y9Cvfc01gg/ITdASM?=
 =?us-ascii?Q?dCeWz3fblRFfapy3nyrzSCFpo+UqgvQpfWWCnvL9uFeCsnofv97bZ2SvV8IK?=
 =?us-ascii?Q?+L6hsOexjOwTCctIfeJ3fT6RcoiUvvdJ9CG2IC5CZfteX4IiY4/i92N9H/Zr?=
 =?us-ascii?Q?h3zhCTajAAH0MFZi9meJzM7XL7+FsYDzpvkd9O1Hbzzwbhc5q76ipPNaFIqq?=
 =?us-ascii?Q?hj4QN295xWOf0zyUHsBeULln3zLWD3JB4WG2vK96wg+FSUzsDvxQdKy2gajd?=
 =?us-ascii?Q?CW8CjrKku2UFX6ogb1EvYOFjDV4jtvOQU/XRFSwctl6g2IuCeKOTzsvZQCka?=
 =?us-ascii?Q?R6TXUmadYfxsAqmJih8VbfJqY/q4QxXe3Wq9rBG7AluJhwS7zG0vdNr6JXIQ?=
 =?us-ascii?Q?UEwANXmCu1W6aMw1Fw6CcDYl9MmhItpJdXK/HEUXUNgffyE01p1NSgUSAxB0?=
 =?us-ascii?Q?OTXwVBNg8qHIgerNy1ZNOoQHVZTI4uTTzK6IxG8WtmNR2mq3HEgAghPedisO?=
 =?us-ascii?Q?O3Z1cjhJW+NUrbY5S+TROQQhdNQdQOOqMRjYlH6E4OfqgTXCqcAkw8gG+8Ot?=
 =?us-ascii?Q?7R8Nq43qxyYX3Q8QqqLA6oc90h/+65SBf6SRYCOcLzVGHrP8d0yKki2fm3/n?=
 =?us-ascii?Q?Aniskw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:23:59.5972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc901058-a79b-4c48-927e-08de53aad9d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF884E1ABEC
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

This DC patchset brings improvements in multiple areas. In summary, we have:

- Update memory QoS measurement interface.
- Panel inst for monitors.
- Disable FEC when powering down encoders.
- Detect panel type from VSDB.
- Check NULL before accessing a variable.
- Initialize a default to phyd32clk.
- Revert "init dispclk from bootup clock".
- Add IPS residency info to debugfs.
- Ensure link output is disabled in backend reset for PLL_ON.
- Remove unused code.
- Add DMU crash recovery callback to DM.
- Remove coverity comments.

Cc: Dan Wheeler <daniel.wheeler@amd.com> 

Alex Hung (3):
  drm/amd/display: Check NULL before accessing a variable
  drm/amd/display: Initialize a default to phyd32clk
  drm/amd/display: Remove coverity comments and fix spaces

Charlene Liu (1):
  drm/amd/display: Remove unused code

Mario Limonciello (AMD) (1):
  drm/amd/display: Detect panel type from VSDB

Nicholas Kazlauskas (2):
  drm/amd/display: Ensure link output is disabled in backend reset for
    PLL_ON
  drm/amd/display: Add DMU crash recovery callback to DM

Ovidiu Bunea (1):
  drm/amd/display: Disable FEC when powering down encoders

Peichen Huang (1):
  drm/amd/display: panel inst for monitors

Ray Wu (1):
  drm/amd/display: Add IPS residency info to debugfs

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.366

Wang, Sung-huai (2):
  drm/amd/display: Revert "init dispclk from bootup clock for DCN314"
  drm/amd/display: Revert "init dispclk from bootup clock for DCN315"

Wenjing Liu (1):
  drm/amd/display: update memory QoS measurement interface

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  15 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  11 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  71 +++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        | 133 +-----------------
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   5 -
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  90 +-----------
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.h        |   1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  22 +--
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  35 +++--
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  24 ++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 -
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   1 -
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   1 -
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  16 ++-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   1 -
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  38 +----
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 ++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  28 ++--
 .../dc/link/protocols/link_dp_panel_replay.c  |  32 +++--
 .../link/protocols/link_edp_panel_control.c   |  15 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  11 +-
 .../amd/display/modules/power/power_helpers.c |   5 +-
 32 files changed, 256 insertions(+), 335 deletions(-)

-- 
2.52.0

