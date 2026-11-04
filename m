Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4752606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wzX7YhSb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DAC10FAEC;
	Wed,  4 Nov 2026 10:22:38 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011036.outbound.protection.outlook.com [52.101.57.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D21610FAEC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 10:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmkfjSj0fdTFaFY332QSjlKKJdOk7OQekozPzcMLzsTxGGdjJPiHsL+Ew0coNX+td2pbpMdw329Gksg9Lv9Tya5c21XzeNKI3SOBaj6r42JVyv3B3TFYhwoq24CGupmLhwiuXUjkoYyDYs4UEaZxwQWFZG+hXyTBaaErHAWQysjF9d+ahSqY1xs5eHvkuN/jnEZN42mbgYUOGDnS3pm3qpv6lt0GQnUC1UHvHYNgkolt6VPfclJdXo+V1TQDlSwnneGkWYkff1dVd46XMdwwm+NQcJZJZdJ35ZeTEhHKgMUTLV0jJ+ZJ7YdgJSnfe2B3kseYj7vnaZy3hocC4TiRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hS+3cWJJs9F403zTTL/u/LeEmFjwMwnO7qZotl+gpBM=;
 b=uB2aZKizELKXS6lGu2FLcYlVLd+26Hk9Im4xFnM9FSxEb3lEwoZJBA7pTQS34Tw6jbyjXp++0dBF8TypeACWXd5c3RseO55hgQBEoP9KLoo9Xr6hEuSqawQNANC7eM3RwXa2qpFogRgPXxYD3SzzNgnYa3cBriGTm9YLiTI5Gpf+lk39hF+iHDOa6sm+B+aNZf056K6qmvRnFq4TtFw5dQZnPJ4pkiAkDWuzf0GpxEi6X5yk7ZK4q2GvHXDILtLTx93Ix7adDHveW4cFjXgXv/Z6aL7iPr0naW42EpnYhBUnkjyEKBXtRvgZ2VglV8dPLZuzu9uMxQl+UB+/5jJ2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hS+3cWJJs9F403zTTL/u/LeEmFjwMwnO7qZotl+gpBM=;
 b=wzX7YhSbCovMWm5waBHlAiDPRnmGbH3pHX0tKftCzTYtoS1Q4GbdZjKkDtrbH8EWIncllrdWY4NgT0dLxWEjQ91o2id8ek/Ivia5OABYXkkf6z0pTO4+DUicN2eqLGH/7Aj3CtQrs78X0zTU9d6Bilr1gNhLQt4Q2YIGXEgF3Tg=
Received: from PH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:510:5::22)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 10:22:26 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:5:cafe::7c) by PH0PR07CA0017.outlook.office365.com
 (2603:10b6:510:5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 10:22:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:22:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:22:25 -0600
Received: from stxhmapple1.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 04:22:23 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Kevin.Wang@amd.com>,
 <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Felix.Kuehling@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v4 0/1] drm/amd/pm: restore the forced performance level after
 a reset
Date: Wed, 4 Nov 2026 15:52:21 +0530
Message-ID: <cover.1793787406.git.Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: af275a22-5a50-458d-d740-08df3a5d85ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|10067099003|18002099003|13003099007|56012099006|11063799006|261021121427099003|261022075727099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|261021123027099003|261009221227099003|261009223027099003|260925021311599003|260925021911599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: +uYvhJoWsU4rNanasuMrrQRlDmdCD+e6D8q4P6mRFXdmyKRBKfCDDLdoUbDTO4coaon/HS860gDlmihD86AvPPac9SJGLJ2vKRow2GKZpeR2HN8K/Z4EYMSw1dWd9lsn6ud17vd/CL6ZHSyMD/ff3xxh1pYK9fFhQnLBymjfV9mxYaT8BxKQc2a+izDgeemquxdCFwS0RsPCvNfyhh5kYnwakO4sOgAHBSXSgonKOFG5pThc/z47d9rwDMKush00QOmnCUIfQclVu6ZqLLjves8al6JtMwLeS9UQtKJ9g+oeZTQVUM8JT6WHkdwLbctPNRom7Ge4YodSfv1NHhroQd4OsOEDAIG4hlCc5z63lDJJHcB0jfPUG8Bkz/Kx+yJez82v4H0dzc/6YoHgMglOdX1/s4kWNswfPJLAPTv3AylhSJThC7/5Xs63O70bov8nXW3Du5ehBaZVEl+ts4zMLtD89F+TJbKJtfOHgm2iAmyoDSvFWh1xYAktOpdBpNdyHx2UHAvmBjxD9Nzr76UIXs3lSCjdEnpEaE7i2+MRHe0CcUaU5rvfSEkUu79+cKYVmaalkbaPk3jvQ7uo3PBHzhCFr02Wu7vY5E9eJ2DZVAxi6T8x3eG1bbgvpLDnH216doDPt+NWM6M099hllRFyMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(10067099003)(18002099003)(13003099007)(56012099006)(11063799006)(261021121427099003)(261022075727099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261021123027099003)(261009221227099003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qOK7nQkmb4eTTDt2IA+/9SgrDFt/GywW/VfXFxm50qb4vcEsBU6aEqsQWzAcSHYhGyuzCozsF4/JPsQjE70ifc+y5EYoRJezZSnIMtTn79VoJVK+fUITUJqgbdmM3D9Oar+p0aPAwVfnEvQ5ETW3ZkA5mXFTNfqgi7V6mpml80CQXRfVN/IYDlUIooTR0wKTHBWqpD30Wjmzt9WpZ6P0JXwpFG7BF+l9E9RIpRKOBaFy6w+nxN9VD5VYYq27wN3VBrOQrAY+WqiCpOCrmwwOjDAmdAJCeuvporPdsiUnQ1u9mdGm4mNV3u4GjcCevF9+L5QZwoheOnQSHwYKovb3PWYHSZz+Zhn4s92HPioM303uUPcNZe7fReSP8Pv0uQa2UULMwLDgcObXfeZCzXb0gcEDlQDEhTIJy5xH823kIUgrDiejt83FZxNy9d0mX5is
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:22:26.2184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af275a22-5a50-458d-d740-08df3a5d85ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After a GPU reset the level reported through
power_dpm_force_performance_level no longer matches the hardware. The reset
reinitialises PMFW, which comes back on its default curve, while
smu_dpm.dpm_level still holds the level the user forced. On an SMU 14.0.1
APU with the level set to high, gfxclk drops from 2.8GHz to 600MHz while
sysfs still reports high.

amdgpu_dpm_reapply_umd_profile() already replays the retained level after
reset and resume, but only for the PROFILE_* levels.

v4 follows Lijo's review of v3 and restores every level through that
common path, renamed to amdgpu_dpm_reapply_performance_level(). The
PROFILE_* levels keep their UMD pstate handling, other levels only replay
the level itself. smu_reapply_power_state_dynamic() now calls
smu_adjust_power_state_dynamic(smu, level, true, true).

Tested on an SMU 14.0.1 APU (PMFW 100.113.0) on amd-staging-drm-next,
triggering resets through debugfs/amdgpu_gpu_recover and reading the level
and gfxclk before and after each reset.

Changing smu_reapply_power_state_dynamic() alone does not restore high, as
the reapply path returns early for it:

  level              before    reset 1   reset 2   reset 3
  high               2448MHz    630MHz    600MHz    600MHz

With this patch:

  level              before    reset 1   reset 2   reset 3
  high               2444MHz   2794MHz   2796MHz   2796MHz
  low                1403MHz    604MHz    600MHz    600MHz
  manual              600MHz    600MHz    600MHz    600MHz
  profile_peak       1848MHz   2237MHz   2019MHz   2318MHz
  profile_standard   1265MHz    703MHz    700MHz    700MHz
  auto                637MHz    600MHz    600MHz    600MHz

The level is retained across every reset. The "before" sample is taken one
second after the level is written. 18 MODE2 resets over the run, with no
new messages in the kernel log.

As the reapply path also runs on resume, s2idle was checked as well: high
2668MHz before suspend and 2799MHz after resume, profile_peak 2508MHz
before and 2266MHz after, with the level retained in both cases.

Notes:
  - auto is not replayed, as PMFW comes back in auto after a reset, as it
    does at probe. This also keeps the probe path, which runs the same
    function, unchanged.
  - Replaying manual does not program any clocks. The user clock masks set
    in manual are restored by smu_restore_dpm_user_profile(), which only
    runs on resume; restoring them after a reset is not part of this patch.
  - Only the swSMU path was tested. The powerplay path takes the same
    route through pp_dpm_reapply_performance_level() but I have no
    hardware to test it on, nor S3 or runtime PM resume.

v4:
  - Restore the level through the common reapply path instead of
    smu_handle_task(), so the level is restored in one place (Lijo)
  - Rename amdgpu_dpm_reapply_umd_profile() to
    amdgpu_dpm_reapply_performance_level() and replay non-profile levels
    directly (Lijo)
  - Replace the body of smu_reapply_power_state_dynamic() with
    smu_adjust_power_state_dynamic(smu, level, true, true) (Lijo)
  - Add the Fixes tag (Kevin)
  - Add the version changelog to the commit message
  - Kevin's Reviewed-by on v3 is not carried over, as it was given for
    his suggested change in smu_handle_task(), which v4 does not use
  - Add test results for the smu_reapply_power_state_dynamic() change alone
  - Link: https://lore.kernel.org/amd-gfx/cover.1793689935.git.Priya.Hosur@amd.com/

v3:
  - Use the existing force_performance_level argument of
    smu_adjust_power_state_dynamic() for AMD_PP_TASK_COMPLETE_INIT during
    reset recovery, instead of switching the cached level to AUTO first
  - Rebased on amd-staging-drm-next, which now includes Kevin's
    "drm/amd/pm: reapply umd profile state after recovery"
  - Explain in the commit message why that path does not cover high,
    low and manual (Kevin's question on v2)

v2:
  - Restore the forced level after the reset instead of reporting the
    default, as the driver is expected to keep the level the user asked
    for and the reset often goes unnoticed (Lijo)
  - Link: https://lore.kernel.org/amd-gfx/20261008104026.4102222-1-Priya.Hosur@amd.com/

v1:
  - Reset the cached level to AUTO after a reset so that sysfs reports the
    level PMFW is actually running at
  - Link: https://lore.kernel.org/amd-gfx/20261007122103.4019578-1-Priya.Hosur@amd.com/

Priya Hosur (1):
  drm/amd/pm: restore the forced performance level after a reset

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 21 +++++++++---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 39 ++++------------------
 4 files changed, 26 insertions(+), 40 deletions(-)

-- 
2.43.0

