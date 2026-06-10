Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E4ACD8C90
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 18:23:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1862310E1BD;
	Wed, 10 Jun 2026 18:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DH5ATi/O";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 559DB10E1BD
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 18:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxL2SeRe3U9imNiRo3T+Hwm5nFWUkbzRI/S6IuqNtQe94pmhdper5/E9EWDFVwitqtfxpR1x0w2bFnQkNxQKdJ/Unw+hCh/yPZLn952TOwrulQAFT7odwrhZsez4Ppy6BY5RFzp13LLyYa9605IxB8z5Njrg2tjoN5hPtN1Ptmlr7kbkFRxAwhjksFdyxMFGm9ZsikScZrU4idEQ5eSFHLGk05TDhDJeCzsuuyMJfEvr5AyYG+xG4OltvEdUQweH96hi9Wd+UR3yvClAkJ7+iggGKHuA4N4SkCaZnZr7VrRKQQNjxzAz8oRXVVdnSw93jtvxIVhZjse9Zwk7Os75/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIy07ll1V+hTmqL0N1Mhqs1gQcn4ZoWUhobVXl0kdfU=;
 b=xwbCOHH6ZuOPdhlLACKs4Wpq4bnNFwBoJuZNKPTqd8tunPx97CKVCNZPp3FpFxJ6NFVWQ0HFT0epbL+l/rM2o+blPMXHi0MpYfIO8gERfErHN25qL25wThsmm5cUNcVVeqhJ55UGyNojV5txchZ5KijF47e/sDwG4JXwyXQchRVoJrX0qSSPJ2H0nkPZK93q6o6FxDL5q4QkMTj3+taD7ttT46EiTUyZiZyDvqPmZcpaj5QUOWryGV2pAGHKU0P1un0ZQY7deWkz3NgdKWKIPh0A9lWY2EhUog7oJAlIqtx1HT7swGBrWUbAKYtICw17FmjNTZ5SU3GJu8OXxDAH1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIy07ll1V+hTmqL0N1Mhqs1gQcn4ZoWUhobVXl0kdfU=;
 b=DH5ATi/OMeabhfRkdTbsD1m54CIRvRJvxs6zCulq76n7hf8A3Z9UV2Sr4d89sTJIQ+YzoiWR1QV024fe4aEpoio1an+2/F33xsdYWbeGtBc2HpCSzYGh5QB+c1Q+cyJpeN9RMgUokMAjlW4zFwMpXDoHJrFGDc8zJpP8kEkgTPE=
Received: from CH3P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::20)
 by CH3PR12MB8545.namprd12.prod.outlook.com (2603:10b6:610:163::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 18:23:37 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::9a) by CH3P221CA0025.outlook.office365.com
 (2603:10b6:610:1e7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 18:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 18:23:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 13:23:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 13:23:36 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 13:23:34 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v2 0/4] drm/amd/pm: smu_v14_0_0: fix pp_dpm_* clock reporting
 on SMU v14.0.0/v14.0.1 APUs
Date: Wed, 10 Jun 2026 23:53:29 +0530
Message-ID: <20260610182333.3922-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|CH3PR12MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: db4028c9-3e7f-4353-e663-08dec71d63d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 104rrxPcjwjUHTprqy+nTYU61u42kaWReK7zJ/Os0fSbNVRlsGjkvhxQXj/CI1ksOyOmxF8MIbs+bcSkM32NCMyr7cvB1ipOS9PXQVwyWgBRYAq1z/BaqAiaslNHvvM4kjHwnKPBUdtd2+RoqNkYypmWOs4vRObPiL7u2YVrNGCMig79ruo3WzDzdgDTwJjupu4p7q4o3HWqo9ueHAKmo8vAIjZhAQiOguQfpUmdTsCIUaad0q34Lg6sOkoWhipPR6JLrElklfKRxAoamMWfIQuD5MKpsw+OwwSFJ/kRLJChCRrsP220hG3l0hH4G5+UjhK3HY4ca+fL01P+DhsYZx7glMNjYebhfRhOBFepY4XC4FSVflhUVe3slOX0auNh5ot/L2hAUTj8h3jy14Y2Hcjhc9KSDNgjDIBMQl7v1FpMpssPvaa/6Sil5lBxIyTdt+5m7an7Lsbn+cBRAkXBvswz67Bcp0zrrtz4p7iP3ZqWLjH6BCADC0wnVRXlDtk5xYLb9oVdGh8z6mIYvuSsbRJjOytcoeFTg4qyhgMnSIfsKCmicW9r7tjNz9WSIkGUOiXorGZb3zu023zAKjqC/WfcwNAy1lA1z551gjK+j2NhLjLoKJDd//2xa+lPL5XOpzjMtArLfHnrV6nS835cm8kE85nmgTfUUPyjyLzgt+kLI/WkHANknBt1tTuLGdDLwQl+0c/crXzrYKejJy4nzcsSN1YhHrkNwEoXbBOeshs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8FY0atU0hvmFd6P1UG+JpVTiMWAlmjvIn2glv6T8lh1+8jjvmyDrgU5mYIH4AhvIz8pIWTetu9FkWUAw6SAUyTAZ6cqXwA4agjho42ngAMN7FmDgSkyBSxVXBKIUyxa6XqcmK83c8YEGEhq+VnUlLNemJqa5K0OsnLCovDl3xSkLPvogzBT6rjUIWvvT029NIOEsiFw532WC4Y8MoYzqMwanrhnpLuziQ1vfcLfYVrn/YeuRWZ26+ILbbCpIM9jDAwwvtzupVfo8bogy5yR4getiKtC0ACHd43T+cK+qZ36y/CNUdBWoOaJtyAstSf8tCYvw6rNrQe/r1unZTqkGddHmPGvy95zTQLsX9J61CRKE7jWatdyjS8JWKf3CK2H48PlN20k4XTjUbWYLk4382D6YV+YQThDKcxK8yyDJTW0JJJFoiUHF9rXesCiOd1I0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 18:23:37.5519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4028c9-3e7f-4353-e663-08dec71d63d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8545
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

This series fixes multiple pp_dpm_* sysfs clocks reporting N/A or missing
the * current-level marker on SMU v14.0.0/v14.0.1 APUs (GC 11.5.1).

Background
----------
On GC 11.5.1 APUs, amd-smi reports N/A for VCLK, DCLK, and DCEFCLK
clocks. Additionally, MCLK and FCLK show DPM levels but lack the *
marker indicating the current level.

Fix
---
1. Merge METRICS_AVERAGE_VCLK and METRICS_AVERAGE_DCLK into a single
   fall-through case mapping both to VclkFrequency (SmuMetrics_t has no
   DclkFrequency field; DCLK tracks VCLK on VCN).

2. Add IP_VERSION(11,5,1) to pp_dpm_vclk, pp_dpm_dclk, pp_dpm_vclk1
   and pp_dpm_dclk1 whitelists. The target APU has two VCN instances.

3. Add SMU_DCEFCLK to get_dpm_freq_by_index and get_dpm_level_count
   using DcfClocks[]/NumDcfClkLevelsEnabled. Add DCEFCLK case in
   emit_clk_levels.

4. Add closest-match fallback in emit_clk_levels: on exact match, set
   closest_idx and break immediately; otherwise track the DPM level
   with the smallest absolute frequency difference, with early exit
   when the diff starts increasing. Reverse DPM index for SMU_MCLK
   since MemPstateTable stores levels high-to-low.

Validation
----------
Tested on GC 11.5.1, SMU 14.0.1 APU. All pp_dpm_* clocks now report
correct DPM levels with * markers via both sysfs and amd-smi.

Changes since v1:
- Patch 1: Dropped VCLK1/DCLK1 metric handlers; let them fall through
  to default UINT_MAX (N/A) as suggested by Lijo.
- Patch 4: On exact match, set closest_idx and break instead of
  continuing the loop. Added early exit when diff starts increasing
  (monotonic DPM levels), as suggested by Lijo.

Priya Hosur (4):
  drm/amd/pm: smu_v14_0_0: add DCLK metric handler via VCLK fall-through
  drm/amd/pm: add IP_VERSION(11,5,1) to vclk/dclk DPM sysfs whitelists
  drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in DPM frequency
    queries
  drm/amd/pm: smu_v14_0_0: add closest-match fallback for DPM level
    marking

 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  8 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 82 +++++++++++++++++--
 2 files changed, 80 insertions(+), 10 deletions(-)

-- 
2.43.0

