Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F89C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF3C11310F;
	Wed,  8 May 2024 17:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zVtvw+lm";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A81611310F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2uqnLf6kVNOC8ANJGYBtzCxkK88v1yLiWq8Ks2KTVwB3dupkh8fx/zdwQ3FKvOD1Wcm4/ZXW+IoFSpfoJfVoCPElqABzM1Zt3bg2ElPhIRWzUXnvpSJYqM4Zv64E7pZksBP+wwuhS8c0OWWCjUDw6Zb48/80gYBQvcf7mzcwfrB3gKYlG+hAMHmUA01nOIoSRnOSS//n8LcIErILosr9RW4Cdt0B4r8giHVGqAprVenJj8AHNMBich9k5N53Y8CUzH4fAKGWOh9mrGTdn8b4Drp97cIsjFQTxDL0ES83NnRpDis8DQ/MnTMX/nHRZWByTulREi5sHn9JW+SRClxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1gR0wgyWvJxBd0rTswxs1tjVed/kFU7/M9sbsn5Q6k=;
 b=LpL4oz5UjoR5U/WpABgbFknVOaaxRWxnFz4Cx7uiRtaDPkDFAJH1sSvar+N/jH92pN3KAoXtYGD6vwdG0tVpYZyfakBukwO7f437y1QRDd/2MV6wfvYfhtA+akvVw6kNPTYXNwdr1/m1sxmMOXLCdIgVAT+KYhOIMA6Zp/8zqqWmL7srEMq3uAJGKZH3dnZbnP9rKYu7U2uTMftMeenETMRojmhaSAhPhKxqLlznY6rQC0YacQOiRcROefhRU9QVGeoluPJC35WILmz2lxQKEhW2S92DIWXx1B5oCAms82uHYqCSNTIrgxvHbCPWybxR4H5CAObdzHoqcd2NXUGOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1gR0wgyWvJxBd0rTswxs1tjVed/kFU7/M9sbsn5Q6k=;
 b=zVtvw+lmsY+jNZsot94ck2YhnAjZ2sHnY+WSMhXud8KAnkcTjihsqVNH7c4bpQ7UkNN3QLIotF29mZAzhek0n/bwbdoqykYtcVeBl0kMRbQv6pffRnIO6vrHlccV7+kBM02PEHSbYom5VQhT8zMOtE3Y5/6O5kcSUm5LAO0M/JU=
Received: from BL1PR13CA0154.namprd13.prod.outlook.com (2603:10b6:208:2bd::9)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 17:14:59 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::fe) by BL1PR13CA0154.outlook.office365.com
 (2603:10b6:208:2bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 17:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:14:59 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:14:57 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/20] DC Patches May 08, 2024
Date: Wed, 8 May 2024 11:13:00 -0600
Message-ID: <20240508171320.3292065-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: c2973800-a37b-4613-719e-08dc6f8263d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9yZtAmuBbHXriSh5lpBZ/N/WPW2yJqM8FpOn+mmKEY2FF0gP778K4AeDxwpb?=
 =?us-ascii?Q?R+Hg3GvI+NjZ7RfAjnyHKkcy/RJk6jM58iwuahmX04elnTil1UJZzaQNyrUn?=
 =?us-ascii?Q?X/Qtc2bFvPjtj4W4ICMzTZZJjKTqIvRaePSFxc6DCwhNdqhdrOcNwq72zHzf?=
 =?us-ascii?Q?fd3v269c9Hl2S9nDkMmZzT88i/IOSqlWvBI7Bb59jZUnOTYcpcLO+kBHjCNS?=
 =?us-ascii?Q?61zmT6Rl6/z5oL06S6CquqWDgy/G/S9foDOZS4Bnbkd0r3GqNrRMQ61SbUP3?=
 =?us-ascii?Q?NDzv4JVWFz71xPNZ9XsrAvNhDNaGhjbrY9GJh7ChZRGmc5fA3bAynMsEwH+j?=
 =?us-ascii?Q?/gpSocw5yLvju0hDqtadgkDY1hadCl4P7DrOE+teCetghyL358PXR9SlFpzw?=
 =?us-ascii?Q?1RXpiGJNqE87Elb+vB6LPkT99L4XL8PH9A8iaWgiNGNZa3dyDflNXiNIz/3a?=
 =?us-ascii?Q?5JIwd3BGyX40c7ICCtmHFXtND50vxp6SfE4Olju2Bg1PrKsV6Ts9yljs96Jh?=
 =?us-ascii?Q?8bCCCFUD3cIHyom4ZLyxmFvWslHeORIpWE+yklt6eRBpmDKry93IYqsE79kD?=
 =?us-ascii?Q?A750fxKCJAKlqGQHZI7EssRoxvPV4m/ft7nYW9x1uo/13jeWDmHCrB+qlGQc?=
 =?us-ascii?Q?NTUedj4EXX2KWAYpi78ZgF4El113TF1KeEZEUe9n9L/zvd1WMJckRdOJLcmP?=
 =?us-ascii?Q?07YQGjoKRXjtWBAm7+ODsl6nHR2+SLFPQX4XaNDveH+LFRxjyj9NT5K0oIM7?=
 =?us-ascii?Q?rf3zOi+5rd9xZoWIbol99SNP2KJIgzAAoiNcl7k5Vggf3jWXi7WwxvamDhZs?=
 =?us-ascii?Q?pQfK+gbOFt9nmPTTcHNnYr1/+qBdgAQ2nvZPYmjNLcSgP0tooce7edOtgCPS?=
 =?us-ascii?Q?DiNbxyrkrPbv3uwEvvEXJCJGYLsABfFsy+5IBZUYYXaZe+C+Dmozx4SauZcJ?=
 =?us-ascii?Q?0i5k4IKhLdscCjSjOgw4i3hAvHE6tRfZLRr28o7rJCeF7qAFarKMKugxe86e?=
 =?us-ascii?Q?ZRbPw2Pdtbux7yGCTA+bxOt/q47/uHmmoPJzdVBCoihBbEzJaT98Ap98+CFg?=
 =?us-ascii?Q?QAYSVwCjbdVsw2Qux7tQaGuVMOgL1CMCcmx4ASmj26/oNzKSaufDYz+SajdT?=
 =?us-ascii?Q?/19ukEK79sSxSmvZoFMjPNKD7uqrRcmQX70XkKppUnC7WHlCdtZI8cr1mF7h?=
 =?us-ascii?Q?fYFQ8xSh3AWTudsffK2GSUWuX7vghGDVxD3FiK0bkywLk2bR1NnDPrpRw83N?=
 =?us-ascii?Q?SMyGH88FeG25eWMBAfduh1eNMUFzk7Dh2dn1ocMUn+Inll8fHoJvQEITnqwx?=
 =?us-ascii?Q?0mBLFIvp7Cx2ClTnVregCTKFnwQZu5hPovL5LDvmOAorYCHRLMdzdyv5nUZz?=
 =?us-ascii?Q?avwuN9dg9mmo/+cHXH5l1rvpHa7Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:14:59.0335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2973800-a37b-4613-719e-08dc6f8263d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
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

* Fixes on DCN401, 3dlut and I2C
* Improvements on AC/DC, link rates, DSC and ODM slice rect and pipe
* Refactoring on code styles and unused code

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Adam Nelson (1):
  drm/amd/display: Fix 3dlut size for Fastloading on DCN401

Alvin Lee (1):
  drm/amd/display: Don't offload flip if not only address update

Aric Cyr (1):
  drm/amd/display: 3.2.285

Chris Park (1):
  drm/amd/display: Reduce I2C speed to 95kHz in DCN401

Daniel Miess (1):
  drm/amd/display: Enable SYMCLK gating in DCCG

Dillon Varone (2):
  drm/amd/display: Create dcn401_clk_mgr struct
  drm/amd/display: Refactor dcn401_update_clocks

Duncan Ma (1):
  drm/amd/display: Read default boot options

Ethan Bitnun (1):
  drm/amd/display: Find max flickerless instant vtotal delta

George Shen (1):
  drm/amd/display: Check UHBR13.5 cap when determining max link cap

Ilya Bakoulin (1):
  drm/amd/display: Fix write to non-existent reg on DCN401

Joshua Aberback (1):
  drm/amd/display: Disable AC/DC codepath when unnecessary

Revalla Hari Krishna (1):
  drm/amd/display: Refactor DCN401 DCCG into component directory

Rodrigo Siqueira (2):
  drm/amd/display: Remove unused code for some dc files
  drm/amd/display: Remove USBC check for DCN32

Samson Tam (1):
  drm/amd/display: Add COEF filter types for DCN401

Sung Joon Kim (1):
  drm/amd/display: Expand to higher link rates

Wenjing Liu (3):
  drm/amd/display: Add resource interfaces for get ODM slice rect
  drm/amd/display: Add left edge pixel for YCbCr422/420 + ODM pipe split
  drm/amd/display: Allow higher DSC slice support for small timings on
    dcn401

 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 +-
 .../amd/display/dc/clk_mgr/dcn401/dalsmc.h    |   8 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 574 +++++++++++++++++-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        | 104 +++-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   |  80 ++-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |  10 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  13 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 150 +++--
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  64 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   3 -
 .../gpu/drm/amd/display/dc/dc_stream_priv.h   |  14 +
 drivers/gpu/drm/amd/display/dc/dccg/Makefile  |   7 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 102 ++--
 .../dc/{ => dccg}/dcn401/dcn401_dccg.c        |   0
 .../dc/{ => dccg}/dcn401/dcn401_dccg.h        |   0
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  |  25 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |   4 +-
 .../drm/amd/display/dc/dcn201/dcn201_opp.c    |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.h  |   4 -
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |   3 -
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn401/Makefile    |   1 -
 .../dc/dcn401/dcn401_dio_stream_encoder.c     |  20 +-
 .../drm/amd/display/dc/dcn401/dcn401_mpc.c    |   8 +
 .../drm/amd/display/dc/dcn401/dcn401_mpc.h    |   5 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   3 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |   4 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    | 412 ++-----------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  67 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   8 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  49 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  63 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |   7 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  10 +
 .../dc/link/protocols/link_dp_capability.c    |  25 +-
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |   6 +-
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |   2 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   6 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |   2 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |   8 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   7 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   7 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   7 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  22 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   5 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   3 +
 56 files changed, 1293 insertions(+), 668 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn401/dcn401_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn401/dcn401_dccg.h (100%)

-- 
2.34.1

