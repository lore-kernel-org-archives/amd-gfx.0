Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5D6C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0117910E4AC;
	Tue, 30 Jul 2024 07:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AfufW7nF";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF26F10E4AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Os/OJsmJR1Yhw07fe6jOBlDHCq4iMpblrB82bwuOagrJFfFwtAi6cb0axq+07FzfIWJjwoXHxvZ8F3UNOWAY1dTQFEhMYqvESTsT3d58azxWrRh/1nYESaIqf7fDLfbpP32V9ImIaO89pbfZO1sAssg03dz8Fd9uESPaWcNzyxoPkCTjXGvU13eiHXKLTjPZGrFKsv+sE+UJ3ccsh7t3vwwaXVQghSFreXCdRwyEkHkxAOfvXlXQWyyr4CuZoxF2BXM4qfGYISSGKo6rVI3ZVr3WRx8PLd4joLX7j/hkUyulyDWhl1dSJiX1xtncruYMn2z2DBSBQitqnciAeGo/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uti6Gfpyhpi7CHIaJDmT8bfCY/JcTRRjHsohKJ0HtvM=;
 b=x4jaq5KoMqtfZ81NpvN0/PcVvu7d5El1dmpk2YhgXopX+zf/lwj0o5ZoC0u5OfN/oPVGW+GUnuQ1Eqw+I70rTpoulkcolfsZvK+LusCx1EZ8U2YeHmU2zU7KeD2KndSWwlv5ywxtPWyNXTnOjSwmUY3u5w33ZG5iuEcEJaIC7xf+hr7152W/lMLnXQWf5cIr+4cv18f8IyveTK5vDGMRGR7Hgjf/GqYrq6gBQKtT7uk3HtbiV7cUnPYJjyXP5np+/V5sm1xXfqaw1yHWuAL/DM6+1lnSw1fHi/kuTcXDskFv22bcQbiH5/Gqc7jVqd3frSoHxnx1+sxd2luu60bRNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uti6Gfpyhpi7CHIaJDmT8bfCY/JcTRRjHsohKJ0HtvM=;
 b=AfufW7nFT3l1mn5DP6TjDrp8xnNBbsJ1UuwfTEHo17qLro2yPCS2vswjjGQtg0EGdBz8N4T5aupLn9FJ5HCmB1w/ugW++fOe3XimoOIL8QTk9WNWpEObWxczdeiIUMf1wO5e7blKyL6XRvswcfBDg8/tqJvxmGlXs9NTSuuPlLs=
Received: from CH3P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::20)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:19:16 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::bf) by CH3P221CA0025.outlook.office365.com
 (2603:10b6:610:1e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 07:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:19:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:14 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:19:02 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/22] DC Patches July 29, 2024
Date: Tue, 30 Jul 2024 15:18:21 +0800
Message-ID: <20240730071843.880430-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 425eb348-c614-4036-6ba4-08dcb067eb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PyA7FDK2lVC7IVJPpAHwqdvUwqj69gXRzebeJHl1Eu/FsR/+W+PHkIvO0sQB?=
 =?us-ascii?Q?MxmKrj/EWSOCe7wyq1kKJTOUmgUeJmej9/5WchtYeToOq5d+A4ZqGXKBN9au?=
 =?us-ascii?Q?iXtEzfHGAyC+c+m61+dHbAD3GYVcMX6uxhaj+Y+pL5AdJtcCKBOxBOP/ROCR?=
 =?us-ascii?Q?2YdL6WbetcGDBrWRlU6CWUcJcN4fZGWaEU1rSNIHNLvdgJ10Kto7o0tnfL5w?=
 =?us-ascii?Q?MWO31fqi52towm/Q3y/ZBII8JO1AgYu26WNZCrw+SkyWbw4E1sdVb4EGi8az?=
 =?us-ascii?Q?l5VR0dAxAjSWzaBXTgw70BxDAxoZFdMhm0JnVOTWqV/hwE1pJx2+tIx3RvKJ?=
 =?us-ascii?Q?ab0rQgZVrbEo1EeoD7h69fz84q3n1+8Q+3pekJ/cILuDj/ZwSgExCyhkTBsU?=
 =?us-ascii?Q?/aPk6gIfO5GpnC19VPrGgb7Af2B3cLU4CLAMm8DDfovTqaqNGzXqB5h7PfwE?=
 =?us-ascii?Q?anas6B4ojWAb7wBDU3YadbWWJgvz6Q1M9tT9dXPHhcv1p5UIYWUUiHBvS/e0?=
 =?us-ascii?Q?WkbWAV2WfAUeLdyKvekgkWiihCzLn/JQ1a27Cyijg4lutIqql4hC9u86nnVn?=
 =?us-ascii?Q?gfFHDHOAuSp2wmMfhITIWVc+5d5IhLvSijsZC/eJyjIwU/Az7xD4znpiPnLs?=
 =?us-ascii?Q?PDzyP6ADKl6N2HbG1tFbTOAKmET8UJPVkysEvkBUIXm5CtN0H7J0GAzUxE/B?=
 =?us-ascii?Q?Pr02koi04riQVwaMrfFbkM8Jw+laLqcWFPuAPYIxKH0KEMNdRkCDsPEPozkl?=
 =?us-ascii?Q?bwfb4gSBa7JHkpqoI6/9eXxjHGfHTRbcS7/C4zHhE7NXFxLw96pudE0MqL0n?=
 =?us-ascii?Q?ozsFd0tNHz1q4EgAoAUmN5pwoXwGhkYfnl2KYfQ1PesxLI2QVOh2bp5HzXH1?=
 =?us-ascii?Q?VVaVUNs2uORgI1rzBn+xpyV0PKJOBkbHXbcclzHfldAlPcjrZtH3ie3CtD+x?=
 =?us-ascii?Q?fXh1yi69lvmXBi3OITErAsywnrTaMDSbcB+7jRbVw7D/TLKY2JNtrOySCZyS?=
 =?us-ascii?Q?8wakD7Y1zLOm2ico6PBVCyXmUf5ZRblRawKmUtKdwDwLTXygEjFRzlw33dDz?=
 =?us-ascii?Q?PDCMnkc8rO56uJjMMJrYCvaCdvIPUbwUyihDpcC/Awyeu2pcPc5vbaUP1Ptd?=
 =?us-ascii?Q?OtviMcwcU7kQUb+ceaS78Gvh9tkj68g6EtLcasQ84nAy3W3iYRPPcMXVAwNi?=
 =?us-ascii?Q?doNSQbh+TDMdw28Tc1CRz4krMxuPBJTaDj1HA+IvuAAE6/unYAdxs0+3DF0K?=
 =?us-ascii?Q?9B0GmC4C95ULhHCZ8GN5x1J9CR06/I08C5eEMXC0XDCCgEAgD2tPplqqYiol?=
 =?us-ascii?Q?MalkT76jFehbicRb0tBDiWZVZFH6mQWk3kyahpuP8ebFq4M7F0ToQsAReL8G?=
 =?us-ascii?Q?Bn3NCnPCqtDm7PYUKKhRuBo5vQkdBJxh8WcBsc3gJgspDl6ygceyVp3OwAoZ?=
 =?us-ascii?Q?mLaen55QcoQiVz6ks54rab/Wtqv8YEkk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:19:15.8012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 425eb348-c614-4036-6ba4-08dcb067eb80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468
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

- Clean up some files style problems
- Program the DET segment when initializing pipes in dcn10_hwseq
- Fix overlay with pre-blend color processing
- Disable SubVP if Hardware Rotation is Used
- Fix few things in DML
- Re-enable panel replay feature
- Fix null pointer dereference under mst+dsc

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.295

Aurabindo Pillai (1):
  drm/amd/display: fix a UBSAN warning in DML2.1

Austin Zheng (1):
  drm/amd/display: Disable SubVP if Hardware Rotation is Used

Chris Park (1):
  drm/amd/display: Address coverity change

Dillon Varone (2):
  drm/amd/display: Force enable 3DLUT DMA check for dcn401 in DML
  drm/amd/display: Add DML2.1 option to disable DRR clamped P-State
    Strategies

Fangzhi Zuo (2):
  drm/amd/display: Print Pcon FRL Link BW in Debug Message
  drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Fudong Wang (1):
  drm/amd/display: skip crtc power down when ips switch

Gabe Teeger (1):
  drm/amd/display: Revert Avoid overflow assignment

Hansen Dsouza (3):
  drm/amd/display: Add stream and char control callback
  drm/amd/display: Add clock control callbacks
  drm/amd/display: Add clock control callbacks

Joshua Aberback (1):
  drm/amd/display: Assume 32 bpp cursor in DML21

Michael Strauss (1):
  drm/amd/display: Fix overlay with pre-blend color processing

Rodrigo Siqueira (6):
  drm/amd/display: Add missing DCN314 to the DML Makefile
  drm/amd/display: Cleanup dml2 and dc/resource Makefile
  drm/amd/display: Remove useless defines
  drm/amd/display: Remove unused fields from
    dmub_cmd_update_dirty_rect_data
  drm/amd/display: Remove unused fields from dc_caps
  drm/amd/display: Add missing program DET segment call to pipe init

Tom Chung (1):
  drm/amd/display: Re-enable panel replay feature

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  20 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   3 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   2 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 528 +++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |   2 -
 .../dc/dml2/dml21/dml21_translation_helper.c  |  19 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   4 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |   1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  93 +--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  10 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   9 +-
 .../display/dc/link/accessories/link_dp_cts.c |   3 +-
 .../dc/link/protocols/link_dp_capability.c    |   2 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |   2 -
 .../dc/resource/dcn401/dcn401_resource.c      |   1 +
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.h   |   8 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   8 -
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 -
 22 files changed, 552 insertions(+), 181 deletions(-)

-- 
2.37.3

