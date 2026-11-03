Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861EE60A383C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MUMgLaUC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 098BA10F4BC;
	Tue,  3 Nov 2026 10:28:47 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8748810F4BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 10:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xS6FVOZ0YrA6CP/Yi70Q0j8xzxpqk16tIWdgMii5WVYj8TyfUBDPjSLrk4JOQxyg60yDTgl0gLta8wKaQz7M/5dVCr9ls8lbcqm4HsqCoXZHkRC4q38gAHfRrrgorMKJwqbmTy3DPRGdbJKvgyjsAAZcDxW1XlqoGrx7g7YCme8NMio3aCiuMpWaQXQOOH9nfvqK0YSt7DQeysAn1++dJ7v6dUUx+HzJGHbolnzQUQ0c+8qdUKmr0qWlKX3sGoSo3KCtV3w7DM58WdaWavVmNPNsJr2ou41YuenVemp5jc6ralSHlSFtycSQMi9Qc22Em/JT2uQu9FwYWza+PzlXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bft9SXbEj2Kc6OQxMPs0JeSLZTLQYnObfbBpXV/pJLg=;
 b=m3THTdOJztLlW9RK2Debstm6vqrY2GJPck8aV4E0i4KadqXmqgn26JNm8nh4Tq1vd5juSv7FdrIM8koirTc58gfkCX/Km8O6l5/TSJVD92vT3OgqcDRTVjbu2R7rIQZaS8kzzxaENT2OhU/P/FFe+EKCBrcqLTTVxp7uFZ2scfF39s0dW1c+oDz9bQgE15JblrBByhse1BdnZj7jVGDVfoeX3vGfAo5aZhNkkuxktQxWPauDHILzgewg3hgq+shPGeXfn3jvizB2fDPIv0JptnnZfZ4u5Omraa17hHp9D+UAhMv40+eLlL1G6gdqG6p5rbea8+FiO40XkPCl2GzLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bft9SXbEj2Kc6OQxMPs0JeSLZTLQYnObfbBpXV/pJLg=;
 b=MUMgLaUC+cg5EUvLRtYVxwdKctb7I2zxTdxVWMgxivQsCgDK1NpUMFm3JFQwqAzCwOEAKJkh6BpldsxPFRgF5SRHDqGMOzzM0LRp3TRAdPDJdqHx/svsDe3wKAtWfiP5VaJjWnL1IVJIcMCZQhK5XoYyuM13PlQGuRKFIb7tHiE=
Received: from PH7P220CA0112.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::33)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 10:28:34 +0000
Received: from PH3PEPF00059617.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::9) by PH7P220CA0112.outlook.office365.com
 (2603:10b6:510:32d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 10:28:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF00059617.mail.protection.outlook.com (10.167.243.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 10:28:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 04:28:32 -0600
Received: from stxhmapple1.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 04:28:29 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Lijo.Lazar@amd.com>, <Kevin.Wang@amd.com>, <Christian.Koenig@amd.com>,
 <Felix.Kuehling@amd.com>
CC: <Priya.Hosur@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v3 0/1] drm/amd/pm: restore the forced performance level after
 a reset
Date: Tue, 3 Nov 2026 15:58:28 +0530
Message-ID: <cover.1793689935.git.Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF00059617:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: d08f9de3-a474-4b78-27f8-08df3995368b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|261026140227099003|261026121527099003|261028144727099003|261009223027099003|261009221227099003|261102123227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|56012099006|11063799006|6133799003|10067099003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: iirjx2qWHRcH+Ri+glJoquu9UVZlXYit08iA1JWqTfm9zWqSLH08t0g9Mg94wDyJjV/Q/CA+1OmRANrvR7UWvJJHjizNCWK2oawyhcFRXc3U4CJNEt6k3xblWdE5DR//cHZAOd82nE58Od6blL/CHBGku3pyLlv3iMDhkao7CdO1KweFWjBbMv1C6DX13IEdBREv7WNO+FAwFAoSYcFVgTY0R31VXj2d3KN4klMGxgqf4iDL+61tBV1V1KxSgbsRdMtqEOYaDt9hrX9UNrfypPWOSv7LG1GyIAjkxeqqjADStynY10nl6ODo1wFbU065DSL0jdpXTGw4L1RLmteqcepQlv+/vpj48IyV/aSdwm4YTOYkDtnmlvsTDKlIXMmGE8ohkuIx2t7AB+eokjT2yzH7tftCXUQ6ThnkwDWZS90fn+D2OiZnfGI44N2jwtoUtVMN+opdDz7dpsPh/sOaQPC5iwu3sjEIIJJ/wgAACPMTK+UYxt2Rgz1wPjC2xzmLfy3D+xx2EZU2CvUf7uc3DDUDZ4uhddSmkW864CRghOTNLkwJfYxmylY+aAbsVbw0uQPWYORXgNMjpV64BgQxRZyEBF8GHr73Y8kqFPejxIUFkJrCg9Obu77h4zNxqQxM3RHZt3mzQgRZCIGlfUpdUA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(261026140227099003)(261026121527099003)(261028144727099003)(261009223027099003)(261009221227099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(56012099006)(11063799006)(6133799003)(10067099003)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c+Ix8TLTfQ31RzOIjb1EY1s0qWNKvd3MPV6zrRdbGgZK+EsNMOLqmY/Ql7ZYLU5DxOtUGq3L5YcUh86RH1RKCaR9dhaRUgbtmOVzBHOlGriYVlp0BAmmnDoMKt5VVK5yKsoJqBo9l6xjo4jzTuWQ9wIRDd/UFLqV8yx0xKOiDEdt7WkPMO3JhHSebVT+SX8+ajtLxwtiXuwxf5YxbID+TQAHQ0M+45e16e9wkNPQx/61MbuazFXLRbxE1bwbnvsjacWtw32HXRa5uXGwmRIJVagVzIl0CL3umQpvMqb8xORpAnuWVZIaIIk/oRMTj79OkTAV6HuRmNcwPsMoDiDdOJvykUhGoL1LpSx1Q8OMhC4S8oKSefX10WMJHPSMhT95u+L+xA+T/ORhO1WSbkTq7hex2+YAlPxo159cqRsnNhFCMpHVntQTaumN59o692BL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 10:28:33.6767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d08f9de3-a474-4b78-27f8-08df3995368b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH3PEPF00059617.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
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
smu_dpm.dpm_level still holds the level the user forced.

On an SMU 14.0.1 APU this shows up as gfxclk dropping from 2.8GHz to 600MHz
while sysfs still reports high, with no thermal or power event involved.

smu_late_init() already tries to re-apply the level after the reset through
AMD_PP_TASK_COMPLETE_INIT, but smu_adjust_power_state_dynamic() compares
the cached level against itself and force_performance_level is false for
that task, so the hardware is never programmed.

amdgpu_dpm_reapply_umd_profile() covers the PROFILE_* levels after
recovery, but returns early for high, low and manual.

v3 forces the level to be programmed for AMD_PP_TASK_COMPLETE_INIT during
reset recovery, using the existing force_performance_level argument.

Tested on an SMU 14.0.1 APU (PMFW 100.113.0) on amd-staging-drm-next,
triggering resets through debugfs/amdgpu_gpu_recover and reading the level
and gfxclk before and after each reset:

  without this patch
  level              before    reset 1   reset 2   reset 3
  high               2449MHz    630MHz    600MHz    600MHz

  with this patch
  level              before    reset 1   reset 2   reset 3
  high               2446MHz   2794MHz   2796MHz   2794MHz
  low                1399MHz    604MHz    600MHz    600MHz
  manual              600MHz    600MHz    601MHz    601MHz
  profile_peak       2016MHz   2289MHz   2137MHz   1644MHz
  profile_standard    834MHz    700MHz    700MHz    700MHz
  auto                636MHz    601MHz    600MHz    600MHz

The level is retained across every reset, and auto is left on its own
curve. The "before" sample is taken one second after the level is written.
The profile_peak readings vary from sample to sample both with and without
this patch. 18 MODE2 resets over the run, with no errors in the kernel log.

An s2idle cycle also keeps the level: high at 2667MHz before suspend, high
at 2799MHz after resume.

This is the only configuration I have available to test. The change is in
generic SMU code, so it applies to every ASIC going through
smu_late_init().

v3:
  - Use the existing force_performance_level argument of
    smu_adjust_power_state_dynamic() for AMD_PP_TASK_COMPLETE_INIT during
    reset recovery, instead of switching the cached level to AUTO first
  - The cached level is no longer modified, so if programming fails the
    level the user asked for is still retained and the failure is logged
  - Rebased on amd-staging-drm-next, which now includes Kevin's
    "drm/amd/pm: reapply umd profile state after recovery"
  - Explain in the commit message why that path does not cover high,
    low and manual (Kevin's question on v2)
  - Add test results without the patch on the same base

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

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.43.0

