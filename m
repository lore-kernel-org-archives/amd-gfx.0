Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26983CD343B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 08:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB1010E7B7;
	Thu,  7 May 2026 08:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hjf5Pd1D";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3919110E7B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 08:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izHBByQ7+kRLu6d6NpmvHQDEONfBYB/qMUwpMfTqFagddCSwBN1nvI7bL9w+0LfD7DcgLQda7o/ES94zFJqT3K3p9zWTNIDZPNdnDKSy1fRi4ESPFcaABbv9e2FCo8QSDy7aIZ60FACAGk813to2hM1DA08EhAkzSKTV7queAJomKYe8a1GZEs1/ZxZARgzYRCntaQC6JeHf/Q+P0aFYRZf5XnL0pJXxqgVg3c0HivcoQA045o56RQncPoUd/B1U1BsxzMGl58AZ25mrrKI+Fygd/8LQrkqToq869Wqdk1HAnmwn/dRK7syrotJfK/+PKDAC/Bt47ig+/OyyIQKtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuS76VP7IQWWzu+5aGqmqlom9zKmTDjFIh5Kaq90qoc=;
 b=WLIt1lYZZpnTDeXLlUqsaSEn/wYCkZAAlQGwKRhrhYatIIR6xB64XE1wEmxx3dT0Jpv4WJN/jLTn2Z1r9Qsl187Zz/lxKeptK0E2vr0EdbBU29jfeEb17IkAxUY+J/Dy//K+e+qaqQnhc2RWCUem8n4N7jid/pNUuhbttABSIOrXj7uB5kL5dESA85qM84vbigzkWyCtQYhrH8nnd7OYGFgkKBSY7Fufv1r2VhDN2YY0+i8xVY7NqnMV9My5WOqgJB1qcMi4RqtfBySljjYcXHl2uIr4Z/+cWaFQOjD5EEyiwzqTY+HiMiqdGOrOCPX2Xecll+QVSIGAk/mY5hqdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuS76VP7IQWWzu+5aGqmqlom9zKmTDjFIh5Kaq90qoc=;
 b=Hjf5Pd1DexW99Co/dFT+opl4ArohBYmV1vds3t2IbUuuQKjVMKe71J59ZfwFgSSbzqk3CbnFTRISjswGsi5fJB1mP72Ify4oeF31UseqnSOe1jcrgzCpEwxJ1lHkZAi/YjbE7MZk+FzDVr9k5d7ilXs8+QCuz4v1/vHvDVbz/SQ=
Received: from BN0PR04CA0117.namprd04.prod.outlook.com (2603:10b6:408:ec::32)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 08:02:11 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:ec:cafe::dc) by BN0PR04CA0117.outlook.office365.com
 (2603:10b6:408:ec::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.16 via Frontend Transport; Thu,
 7 May 2026 08:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 08:02:11 +0000
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 03:02:09 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 0/1] drm/amd/pm: smu_v14_0_0: fix thermal runaway under
 force_performance_level=high
Date: Thu, 7 May 2026 13:31:36 +0530
Message-ID: <20260507080137.841442-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c7457b8-1972-45a7-8f39-08deac0ef14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info: np5kpdvzvZ4Qvs7/04g0tFEdKhDoPt/3aaNgq7ORz41IW6jFsdRjtU1ka4jbuJf8xUwhh9PJti+SDOaVfpzcEifVYCDcBSqOQI8AqRgTnxwBzuHRPBpvybifmhV6D70uDtxGLcJ5Rg2vCntw7pda9nK7MU6Z8mhCYZ7ZSuqEZkejwaLf1Kc5c1tLnVHgmSk+AYxhMjN5IKeWoMONA+Ww3AhoOG2Vej7R5GPcFqAWxBJxVPQ5036o+jZD28AlafqepqV4/6CnQJ+b92odki0uE1HPhyK1iKE62wP/8Kq5qyBdE12FxoPbS40Eh8nqLLWWPMadHMr6WqYI4TzBOuXJHo8yISGSvKSzb/aTZHedtX1DJFU3VMa2VgpF1v1135m6XDGSkpQeiOcsPnxEpKAy8Anz215fsrSiEhJdRkLbtPmzFN+tMb3ku0LEkGyHB5Bki/rtUSSGRByDTO1ymHrSX2jxZdHxOKGZJWnpV03BOpRKJkpTqU/jCmm+Y1O/Z9koWQtkVzzArScY1+u25feGCDKj74YK9QzgH2d4P1RUEBqFBG6/vq+vakSVyiI6TkWsygB40sJ+MhVoUv0BlRvMAYaM1ujHblmTG/Yf/jngdHZgU7ZsM/Ui/dfq/V0UOuixUwXF83luyy28abyeaaEKTUtIq1Qy//w85Km+YM445scq7epWSdFFafrtR11xwy0idu7GHY86tLbbyncYi1LQEafXyq6/DQbA8odPmZ9WeZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vVRvx/fDRjZ4GBN4iUk7YPEpJ7A6UzbLh9MTC1AmY9JJ22foKFMyuxDm7P0W7RaIXM1k7rInjLlxJEfUUnBCTnoMDBt3rGHc7H8e6ywFRbkTYgJL0zv5nH8F2mzZc2Md6tkdRpp0Rf19xpqUwLhvZB9vGojNoYZiC9zkp4jegsSCNi5mDIo1nnaFDeuz7gN2ikaLnF3Z32HWukQ4TCgiibPozgAiOxPvFHPApLuCFdx18JtFiWfe4d7jS3CPEP7hEXyLJnpORrv5ooFzrYuFma+nKd5Gg6RLiNYkylzYoxurz9VAiZoiR2V2SjIYV4nvUY7fKzYkA+Ko+WT1vvEGIyUJhsoOV++FhqueMdUBILDUW/ITuuoETWXtIvIMNQrvLOsnwhGeBMjOdtOK/CFBrIi8UQqltCAbZxlx3YG4qw9O7XjVPzPHEnrPrgiFvden
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:02:11.0518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c7457b8-1972-45a7-8f39-08deac0ef14a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
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

Hi all,

This patch fixes a thermal runaway / emergency reboot observed on
SMU IP 14.0.x APUs when power_dpm_force_performance_level is set to
"high" and a sustained heavy compute workload is run.

Background
----------
Setting force_performance_level=high is meant to bias gfxclk towards
its maximum while still allowing the firmware's thermal/PPT throttler
to clamp the clock when limits are reached. The current driver
implements this by sending SetHardMinGfxClk + SetSoftMaxGfxClk in
smu_v14_0_0_set_soft_freq_limited_range(), pinning HardMin to peak
gfxclk.

In PMFW clock arbitration, however, HardMin has higher priority than
SoftMax. Once HardMin is pinned to peak, the throttler's attempts to
lower gfxclk through SoftMax are silently overridden. Throttling is
effectively disabled for the duration of force_performance_level=high.

Symptom
-------
Under sustained heavy compute load, gfxclk stays at peak with no
throttling headroom. GPU temperature climbs rapidly and on platforms
with aggressive thermal trip behaviour the system enters an emergency
shutdown / reboot before OS-level thermal handlers can react.

Fix
---
Replace SetHardMinGfxClk with SetSoftMinGfxclk in the APU path. The
driver still requests peak performance, but the firmware throttler is
free to clamp gfxclk via SoftMax when thermal/PPT limits are reached.
SoftMax handling is unchanged. No other clock domains are affected.

Validation
----------
Tested on an SMU IP 14.0.x APU at force_performance_level=high with
sustained heavy compute. Throttling now engages under load, gfxclk
and temperature stay within safe operating limits, and the previously
observed thermal runaway / reboot no longer occurs. Light and idle
behaviour are unchanged.

Review feedback welcome.

Thanks,
Priya

Priya Hosur (1):
  drm/amd/pm: smu_v14_0_0: use SoftMin for gfxclk in
    set_soft_freq_limited_range

 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0

