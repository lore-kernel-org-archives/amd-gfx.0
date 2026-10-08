Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E3CCA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 10:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 513BB10E4FC;
	Thu,  8 Oct 2026 10:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="08jobkGy";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E9910E4FC
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 10:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whrJUFO6Io3nnNq+bZgIANc30eFuVImX39m99+B87boRFj3oZMYrvb4emWphTYo/L0GtTNqoBqm+I4KQlsdcvAWuVwGm3s7W9K+OhTO5XnwXg69J5haUJIyBG0hwcjJYCPdtJhifQGsAcRgVBeBe76/a57ubfc5nOo4bVNGsksdFLHDdCLns9hbTH1eM96dnEWYheouYBTYg3LAM99+z/kZb+o5dq/NlEe3PbJS+qhKpV29z22IzhAVyH+JvJCiWSgZ59rfWokFk15b1kWQac49p+boU+Fci94uAQfUqhOuTBPniAgvXu0PdF34ni31fXK2CMu3vIZMSULDhPO+tEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5I7gbha37e4lO6NiflmCcA6IXwvSH6pd8lWJm2E5MA=;
 b=j5dhZyop9aiXfaSNfY2xEMp2RizhXuwqsHoYiTDAmm/Shx0diywJOrSSSHreGFBDdNyXsmhO7B9gUwZw9iFSH7Buxdv3U5mK7fzo2UP5AG+CA8ULvF0yLqjOEM6XSt9oVPA01mg+BJsaYXEHY442GLHR2FoDLDCNy6XxFiRSv5N6y6poKWOkqttPbY6ojrCIJ5hg99m7ci+3HhQVtEkt2pkLgr5853AI9tfQdC2jqWft8i81Vuv6aeAVh03wfHwiuQzUxAnW9jH/8ThEvX07iXerSCEx+vnBZiBfpAgaQtELA/znA5hRVyNzdv2mCakbuKBDsgUQG5h6VHcruTB2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5I7gbha37e4lO6NiflmCcA6IXwvSH6pd8lWJm2E5MA=;
 b=08jobkGyoiscVBIg/e/H+zQT9q22y8QH0CHoOnyXvtu6kd0AksuL/DCuzx7MlZS1cl//oeONKYN3PIfbzuNgxQXIgqeN+qC84fIewEaTm94S5RW0r4pEpVM+0EquYJaJp7XQz35pSFBttGw1o/TNU+f12P83WH8tUacIEuHBRO0=
Received: from SJ0PR05CA0199.namprd05.prod.outlook.com (2603:10b6:a03:330::24)
 by SA3PR12MB7784.namprd12.prod.outlook.com (2603:10b6:806:317::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 8 Oct
 2026 10:40:32 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::f) by SJ0PR05CA0199.outlook.office365.com
 (2603:10b6:a03:330::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 10:40:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 10:40:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 05:40:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 05:40:24 -0500
Received: from rtg-Cloudripper.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Thu, 8 Oct 2026 05:40:23 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Felix.Kuehling@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v2 0/1] drm/amd/pm: restore the forced performance level after
 a reset
Date: Thu, 8 Oct 2026 16:10:25 +0530
Message-ID: <20261008104026.4102222-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SA3PR12MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5997e5-9dec-4a38-9fa7-08df2528930e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|10067099003|260925021311599003|5023799004|11063799006|260925022911599003|56012099006|260925021911599003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: HwTb9SCv+p1QuljuqdGZdonu/lXEpZgqwETKfAu2dVZMVCUaPMr9UYaeQWc0Ke57pF9Y3q1JUzNGu8/dDOmg/fjld7jNFQn7WrOGyfJ3jHEamxZ6VSCHKDaUhxXan9UzYkLizpuiTDS8FvIcvFt8gkNXu5PiyqbdBUaULiiDqgIVfH8eakg9bywB7ZFbuQfc+nJF9lLlpMxHEsp9tCmLLT90hn4E1dawT3Og9PQtTq2XbWQQZ82+psfIF8HPNf2CTyxZNeXJE5XORfcqrKFgIbf4xlLtgH6RxUUcWgu5gpY2Y8wPxUppNXRY0fGib/WMT1/zU/YttK4FJ89ijjo2ZqQ7AwMU814R+BHM0PwxCvIwiYoi8WHiU/mNDTHWGrEXEs71uIFNvMjlG24hy+uVItztao3a+RMpxS5rNlsIfA6z86FbnFQ4MqqKzhiJqs2lKsNTvI8IaonX2+8gbA3jFVuTSpv0qX2gUg2Sm+B8TPG4AXGbQaW9XN1oUN2bT7BAi+UnSH9YiMnDDdg/NvlDGCIqgU/uhBOJiRJUO4gdP22pzkhweVXake7NOYATfPOs0jo0AGKmN7CoT8Q3/Rm+FFR8NrB6rVCFYLb5rrliWFMRPqc5ysvaVnUp1yTdW95sF1WlunySCNELsUZ52lB2dGIM5svKFg7efrev+Taorw6V50c+Qp2sGWQ6Ct7pb8VOfXAD2BgGafV4u9av+qH4EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(10067099003)(260925021311599003)(5023799004)(11063799006)(260925022911599003)(56012099006)(260925021911599003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Yk2wmJiUdf9rxXcASPIBWxaeGRjhHwPxYwQqqB2g1DghuN3zB3rSIeKNlpFNKsgKOhKkcdBL5XMmb3X2q4u2HMGYb3VhX6vA09gzEpThT07dYnULwW1M7CbZl/oe21Fir9yIuHUYCOv4E4o6ia45M6JA5zVRmpwOv9cadYNLvE+R5I5mpBFysO7okP41PzSTYEFlCc3U9i/JJKHqBJKsrI5fTYExmGdYxw8HR7OU7KKpH2x2rJ6oQU0Eo+fcNERCny8PawJQA142Y7m2escolsYM998TDiuivOMxXs42+rwI+u+ZZM2obhx0JarsRruulPXROtAKooti5IQt/kVN6WF7m+FA3A1/UZEYVhpblLzSt13LsisUSo6z4FtAllpsPtHv3Isni6VtYC8zQ7jK2TsErV1CuBB5dSAst4Uf9Zs7Hr226tWrq+grftK2j3Mt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:40:30.4934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5997e5-9dec-4a38-9fa7-08df2528930e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7784
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

After a GPU reset the level reported through
power_dpm_force_performance_level no longer matches the hardware. The reset
reinitialises PMFW, which comes back on its default curve, while
smu_dpm.dpm_level still holds the level the user forced.

On an SMU 14.0.1 APU this shows up as gfxclk dropping from 2.8GHz to 600MHz
while sysfs still reports high, with no thermal or power event involved:

  before  level: high   freq: 2799000000
          amdgpu 0000:c5:00.0: MODE2 reset
          amdgpu 0000:c5:00.0: SMU is resumed successfully!
  after   level: high   freq:  600000000

smu_late_init() already tries to re-apply the level after the reset:

  smu_handle_task(smu, smu->smu_dpm.dpm_level, AMD_PP_TASK_COMPLETE_INIT);

but smu_adjust_power_state_dynamic() only programs the hardware when

  if (smu_dpm_ctx->dpm_level != level)

and smu_dpm_ctx is &smu->smu_dpm, so the level is compared against itself.
The branch is never taken for this caller and
smu_asic_set_performance_level() is never called.

Syncing the cached level with the state PMFW came back in, before
re-applying the forced level, makes that call effective again. The reset
then no longer changes the level the user asked for.

Tested on an SMU 14.0.1 APU, triggering resets through
debugfs/amdgpu_gpu_recover and reading the level and gfxclk either side:

  level              before    reset 1   reset 2   reset 3
  high               2784MHz   2799MHz   2799MHz   2799MHz
  low                 605MHz    600MHz    600MHz
  manual              600MHz    600MHz    603MHz
  profile_peak       2260MHz   2799MHz   2799MHz
  profile_standard    705MHz    700MHz    700MHz
  auto                600MHz    601MHz    600MHz    600MHz

The level is retained across every reset, with no drift over repeats, and
auto is left on its own curve rather than being pinned high. profile_peak
sets a ceiling rather than a floor, so its sampled clock varies with load.
17 MODE2 resets over the run with no instability.

A suspend/resume cycle also keeps the level: high at 2784MHz before suspend,
high at 2799MHz after resume.

The change is scoped to reset recovery. PMFW retains its state across
s2idle, so on resume the forced level still applies and nothing needs
re-applying.

This is the only configuration I have available to test. The change is in
generic SMU code, so it applies to every ASIC going through
smu_late_init().

v2: restore the forced level instead of reporting the default after the
    reset, as the driver is expected to keep the level the user asked for
    and the reset often goes unnoticed (Lijo)

Priya Hosur (1):
  drm/amd/pm: restore the forced performance level after a reset

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.43.0

