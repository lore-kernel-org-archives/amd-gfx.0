Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23741C71136
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 18:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A81F10E317;
	Wed, 11 Jun 2025 18:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zum2HTzm";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8426910E2F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 18:41:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AW5+Yr+XQ5t6VphAwGlj2AdyJJrJJXG/zdXbuLOIDWO/t7hEhNEeDBo0CkYBT4YejbBwgCrawVcSkhpkQG9dyIFO/sEC2zINq/czHwMwnhijI0NMm6n56s5T3E/S+EHXwp52BivJz4OhtXyULFSwMwnyHj9udUuI4+VUyH0ZSD78TRRbGBGfNRtn36Qo3+uCzYRntruAv8nOwVEifVE303tsIO+LF5ezhP+KM+1VbwMconQ55HfGBIrb6R/zeF2g/UX82/GKcDDnSHOtHovUocCDox7gmwm9uErEwnXD3ez7hpJYl5J3trSL65viOV7yTQun155ErT8U9JCFUjHdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HA0c27Xw52rRgVqWdt1CyIHGQwSvMcRe2QrOhR6hHiw=;
 b=rfpuuHS5aCarIYPjnlo/vpKbTZa3VrBDTbW4UVlM1QwLyJb9THAE77FUoN/HzZZGrNRQmV2RrS1kzgbIh8cRJeZGTWeAEcyys2mmXEpfriIHGa1G6ogr7rvSZfWCda7ox3YKd3uCFFIor6ZQQgDRD/0uHmQLCIcp1BCCbTVugdBuvsUR0v4OZp0LOf6NlQMRwMpwLzK5aNwALTLMZsoASEHwzeYfDzD81lUzS7kWEABMGdt7Sa3hLMIXPHU4wP+UAsxDXmdYSZnM4h7upQqvwQtmqp6Hlqzls/3fK6RHR/DnWhLrJxhLcdDTT+ZIU6k5x/sswhAHCR9zxehrQBL5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA0c27Xw52rRgVqWdt1CyIHGQwSvMcRe2QrOhR6hHiw=;
 b=zum2HTzms7Bg0J/N4yioVMtCAAdyRBqGDvRGk9DYuoYh2+1G/FSZD/P197OSojbf0SJJSt6aaYsrtA/o4AOvT/ZlSNE2RuB6SuEKGpNfoPPJOmQQqMbFKG94P7OWM2iMkghf1H6MS90HaRBRenaCcv9QI5e0N59VQ5v6pVC7onU=
Received: from BN9PR03CA0506.namprd03.prod.outlook.com (2603:10b6:408:130::31)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 18:41:14 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::fe) by BN9PR03CA0506.outlook.office365.com
 (2603:10b6:408:130::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Wed,
 11 Jun 2025 18:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 18:41:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 13:41:11 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 11 Jun 2025 13:41:11 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/10] DC Patches for 16 June 2025
Date: Wed, 11 Jun 2025 14:39:50 -0400
Message-ID: <20250611184111.517494-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c37e66-3167-4da0-5dab-08dda9178adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NDOIjhqgqs2P3JlU8Z4u3pGr4bDclRE3K9yIDKvGIJLYDON1cOKQbRS6vhcM?=
 =?us-ascii?Q?mZ3vaR/EpXuq7btQyAS7cb7mdS/B/IKGZv2XQ811VilJf5ZKh7hxQhHtWq1M?=
 =?us-ascii?Q?JgCmN47W53TV+VTk2Dh/LyizfdezyGBP/Uld/q2WLaabylDykMcGNdnnGUF1?=
 =?us-ascii?Q?vyBp3vodCsO0ocusyUkGiSY5NYGZD+PkFKpSTNM2pHvtpno4VReA4JCYaXOY?=
 =?us-ascii?Q?WerDk5KeSMjyz9uI5ONeXqX6/D6zU33PixEpHwjazWaDxS7NL8ZzXQglcOvd?=
 =?us-ascii?Q?756Urvl2+Z4aM/uIn74HeiJjb1aCUlxshgWN+qqv2mzlrd6U03kmmympTITT?=
 =?us-ascii?Q?8XP0tmWMlmAX4glDc+G9wJQaV9fm+j8GwRGRFhb3Qx1EtCn8IxFALByNX/t8?=
 =?us-ascii?Q?lzPO+zGpmeeAFR9FbuUTok0nCIQEc2LXCFNx9lKUqN0POkV66HfHGsAdVjYE?=
 =?us-ascii?Q?oNU46QIQ/JLrNSUBkhSHYgJcopk+Jghw4iH5i9LsUv3SBbM+WzIu/d4zcLQY?=
 =?us-ascii?Q?es+2X77Rg2Sxbp7NxC30ssX/tVUP/K21/Vn0EbKD6yoYKdGPpouDKls7ZboT?=
 =?us-ascii?Q?al0V7TOLE6wJ6HFGWpnbsnTG6O3ORLERMXqRxcI4UwwDNM452+OleZCV4ICG?=
 =?us-ascii?Q?M/Oq+AYiF9FGmonoBnL6oo/ZD/6anrK7GPwMby4p0Psvr6TOb57En2qwZ3kk?=
 =?us-ascii?Q?GTZvnboR7IvEavoMwR91SWWNt33IAJZT9RA2VtkykTQVWolL8B5hyr8rpQWP?=
 =?us-ascii?Q?YAX2T+Bq+AqxNrKIIOIT0JVYcPapHt0gTRkUyXiGHqgKUE0u+SilUoMGvJwJ?=
 =?us-ascii?Q?h6+Tx0+c29xSoCSzQcxENY9iP/XchGrFdZ92aM/HvmXykVRPFENPpR0eJ6/N?=
 =?us-ascii?Q?XfmX9SCkEU0GT6u1AV/EXdlFdm6z72FdALPDrFzi0nSoHOwZ7aOxsmRpyTlI?=
 =?us-ascii?Q?vNof4AVIZWsx1u+T8NnLK/c8LHjBB5bof+RtvAg1GocB5l1Nq/QHCEOI1yvg?=
 =?us-ascii?Q?Msc6ciM9FAT9D/gJhtAP9eXHwKB+vlKB9OTje6UtsdeJa9d+Rv3X1pkOgrx6?=
 =?us-ascii?Q?iHyuKT6d1Xolg/uasuEPYdzWEzm4t3gtriqBtetTFKZKfMrYDZkaFoCt47H8?=
 =?us-ascii?Q?GmvSiqMi/bKgZpXBbop75QBWsU0i0eJDo8k0d9JeGsbtCiXejsEZ0it399BF?=
 =?us-ascii?Q?FYEivJogmd5XLjcZCqZlp8PwzziPh3yIHfHwcm4PhtEFqIyb1mIJFJD87Ncw?=
 =?us-ascii?Q?JalWlAT/Jtbn3j5bVdg798jGqGhxEclxwQXmFWY98K76fVdIelAcMmraNizW?=
 =?us-ascii?Q?w9cPuxDoQUhEwEW4KILdlc35DGy2gkuW8vDiHd7PkCvYZyi+8JocAX9w7+op?=
 =?us-ascii?Q?/KUl40EY/Y4No1ghY3+3uq2B2lATCsDWsANBWYWjzBUUMwTmBIb7E46nhdSC?=
 =?us-ascii?Q?uJysziU/nNXL/Ecjrp6FM4exrFH7tYaWgU8gblkid4XzK/cJ6qEMogsKYqzX?=
 =?us-ascii?Q?IKyMlDFUon8nsRNB++ahBoTmjkM+oveH9s6z?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 18:41:13.5265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c37e66-3167-4da0-5dab-08dda9178adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659
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

DC v3.2.338 highlights:

* DML bug fixes
* Add pwait to DMCUB hang reporting
* New definitions / changes to prep for new platforms.
* Misc cleanups

_________________

Alex Hung (1):
  drm/amd/display: Check dce_hwseq before dereferencing it

Charlene Liu (1):
  drm/amd/display: add APG struct to stream_enc for future use

Karthi Kandasamy (1):
  drm/amd/display: prepare for new platform

Mario Limonciello (2):
  drm/amd/display: Use scaling for non-native resolutions on eDP
  drm/amd/display: Disable common modes for eDP

Nicholas Kazlauskas (1):
  drm/amd/display: Add pwait status to DMCUB diagnostics

Ryan Seto (1):
  drm/amd/display: Removing Unused DPP Functions

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.338

Yan Li (2):
  drm/amd/display: apply two different methods to validate modes
  drm/amd/display: remove use_native_pstate_optimization

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +-
 .../dc/dml2/display_mode_core_structs.h       |   1 +
 .../display/dc/dml2/dml2_translation_helper.c |  19 --
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 242 +++---------------
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |   2 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   2 -
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  24 --
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   2 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   2 +-
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.h  |   8 +
 .../dc/resource/dcn32/dcn32_resource.c        |   1 -
 .../dc/resource/dcn321/dcn321_resource.c      |   1 -
 .../dc/resource/dcn35/dcn35_resource.c        |   1 -
 .../dc/resource/dcn351/dcn351_resource.c      |   1 -
 .../dc/resource/dcn36/dcn36_resource.c        |   1 -
 .../dc/resource/dcn401/dcn401_resource.c      |   1 -
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |   5 +-
 23 files changed, 78 insertions(+), 269 deletions(-)

-- 
2.49.0

