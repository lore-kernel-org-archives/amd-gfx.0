Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BADC369C1
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4283A10E7B7;
	Tue, 15 Apr 2025 14:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kl5C1eMV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E5C810E7B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoQyXudyruyf9IbsmYzJf2FcRO6BDXeMcuw8qOTXPl/k4B+5Uiop5gtzBrzpZrsJcONLuC4CQrwNhb12QBfUp3FrqnGnyKZiqav+mRaGNc98x8oRZh7V2ZtjYZyIiW0+FImli30aCFatFcStrjJFF3nWgofO6d1ojzHZfYbdWI0u+IKcGE0fD+hrNIIlUwE4W64R7Za0FZrqI8+L1eYG3goAgvkN/hACRrYLQm0Zi34byerpvqrSa/2AJyHurPFUvyGk8p2tem9ag9ki2K1KD/eCBQ2K11Bw64umTWTdHA9qZz3V8Zqa87+xmw+NUUP0zalm5JoYP+X4cVz6NrECvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axw0SKNYFVmxWaPPfhcCQYTjK9OAirFl9S5S9wQdG58=;
 b=vJcvacmx4enk5Nf4lcz9qQX/T9zMoN8FE6T7ZKn9vCyuwVQDfgzC6M8AkOuD5dHwi5FLakkbTuEeXWeEezzUSa3z514k64EKezb+eUIyteW8KHDpGQnBiPvv185jw6MqjZcmysFgssnhHPKDCgW2WqvWC9XfE2XraXwplPCz6OUbRQX6XdIUQiOHnqsAaWdXGa0331t8KBqF0nF9A4o1w1MncgkyZ8y1IPD2oMoIFI+xbR5PMK+03/9TgERlzzQ4MfVd0xMPRHjkutRwqMjkzf/ZdIGQhjjyiLAe6FpYNWhmQT9NbaZks1Jo8epF1cP6gFsVzDNOzz5l3aX/z5lvQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axw0SKNYFVmxWaPPfhcCQYTjK9OAirFl9S5S9wQdG58=;
 b=Kl5C1eMVRW2uT2aJS0K6YNtAP/Oj8Tqjj6d5TybUgMYo1hbjI37+JuVSnHYzCxx/AZpCn/pzaV0ig0GXDXeMgiqgM3Wq/BCpuaAEfIg1Lhrw03dwMKb6QLN4cT0/6RlOpcXHIFmKp2jEp44Ysqf5Gw7spuTvsQNBexKVy/vT/DM=
Received: from SN6PR01CA0029.prod.exchangelabs.com (2603:10b6:805:b6::42) by
 SJ2PR12MB8807.namprd12.prod.outlook.com (2603:10b6:a03:4d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.37; Tue, 15 Apr
 2025 14:59:32 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:b6:cafe::be) by SN6PR01CA0029.outlook.office365.com
 (2603:10b6:805:b6::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Tue,
 15 Apr 2025 14:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:29 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:27 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Mark
 Broadworth" <mark.broadworth@amd.com>
Subject: [PATCH 00/22] DC Patches APRIL 7, 2025
Date: Tue, 15 Apr 2025 10:58:46 -0400
Message-ID: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SJ2PR12MB8807:EE_
X-MS-Office365-Filtering-Correlation-Id: 300fe3ce-b5c6-4af9-c8b2-08dd7c2e1f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b0xW/P2f4XEfKZ1OOKj9ebHQNj8vNa583kPPSr2gjzCfTlH5NAkx8ueQZfv6?=
 =?us-ascii?Q?Fb+wDR1sRRWV2Q5SgbzdZUdH3+AoAnSnpojJZTfVaGvgR1z34RNim0KAPSa7?=
 =?us-ascii?Q?OCQEpDHDkXCjxu3fb9Ad/4iWt9uycWb0Hjs0IQ5QogajwbfsSuBaumwObOX0?=
 =?us-ascii?Q?E/ikoKO0SGVvwVUhGk74gxbpfUVf9A0ki61+E2AdD2nyCPanMC/1itg0fL/f?=
 =?us-ascii?Q?oZQR3McsgnfNzgC0OmeiogylT1IiOi/L5IolZWpywRiic+Zj8XpDjk4dtRGt?=
 =?us-ascii?Q?Q+1Gq2DaHFCljq4uyim09v0avMsr0stgmR6/HanZd0hVhixwCG6XRKm3x8NW?=
 =?us-ascii?Q?6QgvE5VvvDB6ykqmHPvcUxozqKqtLPt10DjGeuUm5TYa1umHJ8DGfNMQfXOr?=
 =?us-ascii?Q?C1SP5mkNnZi9fkOnZAiaJq3W0KUStZLeLcJFWGIsk/EYkNcyVG67kLiuRmPe?=
 =?us-ascii?Q?5VVLPgUlsB2FOAb5pvHv1uDAHbz3WZC4uYBWhtr92pZ2D+WAVUWv8lprZIXr?=
 =?us-ascii?Q?1eQmn+i8RrtSrG7PE5PpYOcPUDzHhBBArtD4dxJBQsET/gp37hK00cKzOEgT?=
 =?us-ascii?Q?aHMeuZXi0hNSXgAiqKwF+LAFxJvH2B3gE0ma9I7BIbH1iNmu4LIpBiGi50/v?=
 =?us-ascii?Q?R7ooJbOMaRuk9R2opQiJtdyhd7UxuRq3wO+CpiSTU0slIOU/lkzF+62UBSxe?=
 =?us-ascii?Q?NPvRaF9eKwWPaWG/8tgT6PE1775H+3i/jE17UUxJR/lfN/vQPOx0vbE8Ey4P?=
 =?us-ascii?Q?+ztnQZRFnZFpcUiXkP9/fHL9UBhQ/faslu/fcnNQXR2UWLoW1v1vaAsgEdzH?=
 =?us-ascii?Q?8VeE4GTeTCBOe8gPhsH6VU5RZ7G2lAD8lB/FObUtilqYMuN9+icwsS54E9q8?=
 =?us-ascii?Q?N1IujKXmrQ70QK9oeszQkG4gowMXGOry3iQTmr3j44f0qbYSbSMLl4p9nfqA?=
 =?us-ascii?Q?F1TkyZmiRA8GIs5hMnoJrEN/SevzZ89UE1Xda0NC9DbT1GyomPYrmaFc11Yk?=
 =?us-ascii?Q?0OBW11mM2FOgGJJ8XQcXK7P37TYQdrhgTRRThRSmWHUkL108izCn8OsloeVK?=
 =?us-ascii?Q?uWIdvkOYlpQRXKURJuzTq+aeF6V/5wVLOQJVjUAKrIFlY9es3AKrsALPyrDl?=
 =?us-ascii?Q?psyyODnNuEdy6NVJrS19T601XiaANY0Wekf/4TNU7yUu5J1m9PIQn4ojtdVR?=
 =?us-ascii?Q?EDJaGpSAaJOrUWGNVs+wyW6q/O/cumOuQOvs8A2V8lZfCbcjPJjwl6r+2fTu?=
 =?us-ascii?Q?C7wfG+1MJ9CBnzQBcEX1qP5EWt91x2u9K9IKLK3kHyraxsoyzdV33YwQ11Cc?=
 =?us-ascii?Q?PhLbXGSYIx45jVA/SkoCHk+gDdFdBetuJQeycqJm7AaL7TEwkn0Poq3N1OCD?=
 =?us-ascii?Q?PamERnejyhAguB15rc3KoNV5RglURPRQJf2ogKUqUqxpgq/ZKaXnnOSbONqA?=
 =?us-ascii?Q?vCRR+mMQPtOqWm8qnqpHQwvx5Cwg9PtL1KlfHsyworNcWsbgQ5DxMj21F9pq?=
 =?us-ascii?Q?BmkuZ+Le27IqZalUOLmeKBWSiTjnTgNPFLLK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:29.5185 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300fe3ce-b5c6-4af9-c8b2-08dd7c2e1f87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8807
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
 
- Implement HDMI Read request
- RMCM and MCM 3DLUT support
- Enable urgent latency adjustment on DCN35
- Enable phy-ssc reduction by default
- Use 16ms AUX read interval for LTTPR with old sinks
- Init DCN35 clocks from pre-os HW value
- Refactor SubVP cursor limiting logic
- Various fixes  
 
Cc: Mark Broadworth <mark.broadworth@amd.com>

Aurabindo Pillai (1):
  drm/amd/display: fix incorrect return of vblank enable on unconfigured
    crtc

Austin Zheng (1):
  drm/amd/display: Move Mode Support Prefetch Checks To Its Own Function

Automatic Promotion (1):
  drm/amd/display: Promote DC to 3.2.329

Charlene Liu (1):
  drm/amd/display: Revert "not disable dtb as dto src at dpms off"

Chris Park (1):
  drm/amd/display: Implement HDMI Read Request

Dillon Varone (1):
  drm/amd/display: Refactor SubVP cursor limiting logic

George Shen (1):
  drm/amd/display: Use 16ms AUX read interval for LTTPR with old sinks

Gergo Koteles (1):
  drm/amd/display: do not copy invalid CRTC timing info

Jack Chang (1):
  drm/amd/display: Move desync error counter operation up.

Leo Li (2):
  drm/amd/display: Init DCN35 clocks from pre-os HW values
  drm/amd/display: Default IPS to RCG_IN_ACTIVE_IPS2_IN_OFF

Mario Limonciello (2):
  drm/amd/display: Avoid divide by zero by initializing dummy pitch to 1
  drm/amd/display: Fix ACPI edid parsing on some Lenovo systems

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix pixel rate divider policy for 1 pixel per cycle
    config

Nicholas Susanto (1):
  drm/amd/display: Enable urgent latency adjustment on DCN35

Roman Li (3):
  drm/amd/display: Fix gpu reset in multidisplay config
  drm/amd/display: Force full update in gpu reset
  drm/amd/display: enable phy-ssc reduction by default

TungYu Lu (1):
  drm/amd/display: Correct prefetch calculation

Yihan Zhu (2):
  drm/amd/display: DCN32 null data check
  drm/amd/display: DCN42 RMCM and MCM 3DLUT support

yi-lchen (1):
  drm/amd/display: To apply the adjusted DP ref clock for DP devices

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   46 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |    6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  121 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   52 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |    2 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   48 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   96 ++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   70 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    7 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |   20 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   11 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   10 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |    9 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |    1 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |    1 +
 .../dc/dml/dcn314/display_mode_vba_314.c      |    1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |    1 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |    4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   12 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 1277 +++++++++--------
 .../display/dc/dml2/dml2_translation_helper.c |    2 +-
 .../drm/amd/display/dc/gpio/gpio_service.c    |   14 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |    5 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   10 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    4 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  353 ++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    8 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |    3 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   29 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    2 -
 drivers/gpu/drm/amd/display/dc/irq_types.h    |    7 +
 .../drm/amd/display/dc/link/link_factory.c    |    4 +
 .../dc/link/protocols/link_dp_irq_handler.c   |    7 +-
 .../link/protocols/link_dp_training_8b_10b.c  |   54 +-
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |  380 ++---
 .../dc/resource/dce100/dce100_resource.c      |    4 +-
 .../dc/resource/dce110/dce110_resource.c      |    4 +-
 .../dc/resource/dce112/dce112_resource.c      |    4 +-
 .../dc/resource/dce112/dce112_resource.h      |    2 +-
 .../dc/resource/dce80/dce80_resource.c        |    4 +-
 .../dc/resource/dcn10/dcn10_resource.c        |    5 +-
 .../dc/resource/dcn20/dcn20_resource.c        |    6 +-
 .../dc/resource/dcn20/dcn20_resource.h        |    2 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    6 +-
 .../dc/resource/dcn30/dcn30_resource.c        |    4 +-
 .../dc/resource/dcn30/dcn30_resource.h        |    2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |    4 +-
 .../dc/resource/dcn31/dcn31_resource.h        |    2 +-
 .../dc/resource/dcn314/dcn314_resource.c      |    4 +-
 .../dc/resource/dcn314/dcn314_resource.h      |    2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   65 +-
 .../dc/resource/dcn32/dcn32_resource.h        |    6 +-
 .../dc/resource/dcn321/dcn321_resource.c      |    3 +-
 .../dc/resource/dcn35/dcn35_resource.c        |    6 +-
 .../dc/resource/dcn351/dcn351_resource.c      |    6 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    6 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   49 +-
 .../dc/resource/dcn401/dcn401_resource.h      |    2 +-
 .../display/include/gpio_service_interface.h  |    3 +
 62 files changed, 1825 insertions(+), 1062 deletions(-)

-- 
2.34.1

