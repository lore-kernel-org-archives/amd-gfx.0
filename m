Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E34FD88F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64B0D10E2F5;
	Wed, 11 Mar 2026 04:03:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Klmvjgdp";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0A210E2F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRhdBsrsF183pbLmTCxgPAVQzZSdeifui4EKPpVUkO/OmB1KOsEJIWF97gRR8J2XBWZNtyMkuieS58FJDq/582yK72mkY9TysTUrheOX+Fhsl9rp1AAfmT2lPVKv2fuTdisEOjukKuzbi0q4x9h+UE4e1DtFiF2H5TRA8w7zSSOZ9dzYMDgbgeT+O7zjSELz8JoJYS+Bvf90gXlEhgEuc8Xl5N8bFHnjX7UWdIyzdd2dgPa//8LsgeRG+cDN/Mowe9tLjl3AGwIlGj/VAxwWdiwpYb10itaPP9NuEYL3JmBhbY5j15Wo0tTfEgWj47GlWqaCSa0c8aVkybO36dtxRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEH6vKYOt6JpJoeXyFhhC94NsJGiB6j3CCYTP/Sm808=;
 b=Bk4Bk4PU2L0ygZc0fKzCI8KhNsroScWDYutYdG93U2nvn4JjCpkFXZc6w6fIdGHdCCf0Ikx5SFK81so9yt+IiHOLciyfTt6nQnRAd085na3Nd2GXVkxYv8Kuqo2zweVSLmEd7S5dibCiEy8z+Tey1Zd6Yxr9nxBbJ3yQ4ro+sBaN8iyN/4rQ0yaNo+A/QeQoSISueFbSG/8PjUAcXCkR4KcFFbWM9CHCiNeVrzyeBKUBexclQpnUXdu7URhyx2E137z5JYxV3XIz1llFwZWd3819v+sKw3q1Dr9lDIVJGgjyFUWxnBbWWaEYPbe+E/oByk9kECCiToescKIiRjgHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEH6vKYOt6JpJoeXyFhhC94NsJGiB6j3CCYTP/Sm808=;
 b=KlmvjgdpjhW/XvEOu8HDvTagTv9qe58AcIYkNgcbL8j3uKQFsIfmJXCT3Iwv5ECy7UokaHBbvzRmg4EznKEm1wj0/0Aj2+fQCGPBD0iNMN3EKwhCauvOzOI4wbQfemHW1BQQgFz9q4TtkqFzfOSEXOilQb7BqlB3/RLlcRBjFyY=
Received: from PH7PR13CA0008.namprd13.prod.outlook.com (2603:10b6:510:174::15)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Wed, 11 Mar
 2026 04:03:36 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::4b) by PH7PR13CA0008.outlook.office365.com
 (2603:10b6:510:174::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.8 via Frontend Transport; Wed,
 11 Mar 2026 04:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:03:36 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:03:32 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, ChuanYu Tseng <ChuanYu.Tseng@amd.com>
Subject: [PATCH v2 0/9] DC Patches March 10, 2026
Date: Wed, 11 Mar 2026 11:32:55 +0800
Message-ID: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH2PR12MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: f2135106-72b0-4679-043a-08de7f232b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: uQ4axDyFePyGpbKd5Cig8KVwvZTYnDybr4ClCvxzvI397Hb7Bk5IutSKXHGGv/n94YxTlB0L+M8NPkYmpDh+zueU6EVTeI39e68Qfuu/YCJZ7E/Cn42sESdFJvE3KmRQuRVDa8NGv3gVQ7ENyTv9ggPZsW0WSfGW4IcYqGs6B/owWM3JkCXWAhhVQigNKWFc6yNnXzvBr4j7ok1lsA3sauT4Khn/FQ2yy7rX17bJRgJ8ltDjjbI4FBSb7DQd9xwyMOCL4/pcjpSatQHerga1+qmqjopZJZt1Gysri26ybBqudwfkcbPkJSMOEGvK2QPXU9j5c80POG64X22Nd+Yqj+f0uVE8NeqlpFZX36mCh5UyjOo5FeVBWsfsvUkxJV5ZPhRn2O/mja2sihvaGsBcntmheKcs9wDp65mYDpvpDK98yh2CZL1G9wjMUuC3E/JJ1AN0mv+W4PbxB3bggO+qXxlhgHLY0sNLI3q044xFxxOKS0K4JFupYYEcpWYEbONsmA9ZNVOsviNigwc8nCVHL4AHgGL4znTCW/+vhQ2H2LnuDuyZ55z7EdurgYRt/u1MFPHhwRxnNKB2QMSHttmGxlQlgqrFiksT9ZMD5CA8AV6G9TbO9MzI2EgNvA7nOq8L0rEjAy7PVxqYhYfkLwhfLf86g6IGbZ+GOYdQ5LTdU7EB9M8CF3MeHCQYUF61eSGPWXukGPb13oUMslBHbjVQYBl8/ddXm8S4b9svDssxoII=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BLxLbpYcdRIrZot3rmnitNt4Aco2ZG7v2XPWfcqkN/bIDl3y6XJBXSFJoHLGZG0NTwcwQJqHMWiwG3H/9YTobnciq86MI8keNjRspqlCNIKOAJ8hP/RbQXKZ81NiT+vCNYphog3dSO5XMOTRsSfYIKK17vMU7iPIow/oO3F3OaYGk5whGvnXVzIPjw2xXK6VA3acW/DuslKLKN3YwmF33ihqBC7+BWBiOCdYfIxuTsVrJwYisg0dHZxzBrmiRdsr+skM03pFNomJAlIp/UrCo1ntoBzoPXX6t/kvcOo5Co1OWUN9N0c6UxqOgjuQ6HUXJV+QCBrY3oaOpCVDy8u6GPDrXaHnhOPEyZf7VtYOiTCKtVN9CXC/M8PuLFWyH+VMEKtPkaVHQRugX9LN1Q21jdROcNstcqKoGeOGNchZL7qXRVzCwMlYAug3XLOWz9jZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:03:36.2252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2135106-72b0-4679-043a-08de7f232b75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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

- Clamp dc_cursor_position x_hotspot to prevent integer overflow
- Query DC for gfx handling when setting linear tiling
- Add a buffer for boot time crc
- Silence static analysis warnings
- Plumb MRQ programming out of DML for dml2_1
- Add dcn_mrq_present Field
- Fix number of opp
- Add debugfs to disallow eDP Replay entry

Changes since v1:
- Added back missing Reviewed-by tag for
  "drm/amd/display: Query DC for gfx handling when setting linear tiling"
- Revised the commit message and title of
  "drm/amd/display: Silence static analysis warnings"
- Reference to v1: https://patchwork.freedesktop.org/patch/710768/

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Austin Zheng (2):
  drm/amd/display: Fix number of opp
  drm/amd/display: Add dcn_mrq_present Field

Benjamin Nwankwo (1):
  drm/amd/display: Clamp dc_cursor_position x_hotspot to prevent integer
    overflow

Gaghik Khachatrian (1):
  drm/amd/display: Silence static analysis warning

Nicholas Carbones (1):
  drm/amd/display: Query DC for gfx handling when setting linear tiling

Nicholas Kazlauskas (1):
  drm/amd/display: Plumb MRQ programming out of DML for dml2_1

Ray Wu (1):
  drm/amd/display: Add debugfs to disallow eDP Replay entry

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.374

Tom Chung (1):
  drm/amd/display: Add a buffer for boot time crc

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 58 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 21 +++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 52 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 10 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 +++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 27 +++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  9 +++
 .../dc/dml/dcn21/display_mode_vba_21.c        |  2 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  6 +-
 .../dml21/inc/dml_top_soc_parameter_types.h   |  1 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |  1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 22 +++++++
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  7 ++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 .../dc/resource/dcn10/dcn10_resource.c        |  9 ++-
 .../dc/resource/dcn10/dcn10_resource.h        |  2 +
 .../dc/resource/dcn20/dcn20_resource.c        |  3 +-
 .../dc/resource/dcn201/dcn201_resource.c      |  3 +-
 .../dc/resource/dcn21/dcn21_resource.c        |  3 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  3 +-
 .../dc/resource/dcn301/dcn301_resource.c      |  3 +-
 .../dc/resource/dcn302/dcn302_resource.c      |  3 +-
 .../dc/resource/dcn303/dcn303_resource.c      |  3 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  1 +
 .../dc/resource/dcn314/dcn314_resource.c      |  3 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  3 +-
 .../dc/resource/dcn316/dcn316_resource.c      |  3 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  1 +
 .../dc/resource/dcn321/dcn321_resource.c      |  1 +
 .../dc/resource/dcn35/dcn35_resource.c        |  3 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  3 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  9 ++-
 .../dc/resource/dcn401/dcn401_resource.h      |  2 +
 34 files changed, 270 insertions(+), 23 deletions(-)

-- 
2.43.0

