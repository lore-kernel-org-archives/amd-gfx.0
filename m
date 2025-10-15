Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D46CCCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 02:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C09210E17C;
	Wed, 15 Oct 2025 02:58:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E5+Z8CNg";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B9910E17C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 02:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uASBKbeq+8VPx7uSbpERUfSt+nvHpKVXM6/1R7eSITL9r/EzSdEpibKZlFjnJKXWCnhHznd5YcXy5/GuSK0YgTxYjt0/UNammaX6qdK/CrgQSHcdmuX4JjmbxvKIZXTx05n2Za5dxBczQ6wB1yx7sSvG9nUTkZ+Jn7vhPWg4dRG3QT3Px+H/D5vSkhjgR9svaUytxeaCVlQMh1TyIY+API2rgoHpJXKqvkmFWwHxc/yn5qORZvk0Iu7+NZIAkZRJGDFqBEfsipO5NzIbL0+HQzRkCqoOG3AJ1WArBqrx0yqS0PSvYvjgexoSa3rDHxG5fwFtx0DbWu2e1GgWVjYtTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nugjdc3ef2Izw8niZ79126qqmPzmyMEkoF5wM/yGuSc=;
 b=KnMkCBmh38nC6jckLt60Po2h2dfl76VvJlqqCfnmD/hA2JiiPH7tjpldGOniyO9Vuk/FSyxgOtRdFbiJJ/ydRmRAv+6AmFWQxNIiwtTlMDDtzpTo5IRkoLGRU8MyahJoj+KNc3INS+N/vsHhe4srpzhibDA5uTLmhhfh+kxd2AZroPI3An8B2fP4SEZOHpE4zZ9EsiDzzwQt2X+8z/fMWzDi8I3N/jEjRGtwRPLyraydOPE7FBRYFmetqWmwYUDj0GtHJyqH996AonHpU7uPmaRVIAVvFq1aNZB5gNeA65TV5xfN2BgqU9AADBnlKItHOVIqF/tnTaU3ZZrkxuAFkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nugjdc3ef2Izw8niZ79126qqmPzmyMEkoF5wM/yGuSc=;
 b=E5+Z8CNgRt/eUJsX8kmVQ7Mu9D14ZEDanKvjQC8mwsMVEUp8lNe1BH2RE14xv6yfJ3vbCIx3NASJvySjiN0pZFlpsFtasSfKH7fDTvlDGyfk/g7+fkquB4aT27nuPp5gWmAC1zbiIi70Pm9I5aRFsBHItIkDYi3BBQsex3WoWKM=
Received: from BL0PR02CA0106.namprd02.prod.outlook.com (2603:10b6:208:51::47)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 02:58:40 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::5f) by BL0PR02CA0106.outlook.office365.com
 (2603:10b6:208:51::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Wed,
 15 Oct 2025 02:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:58:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:38 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 19:58:38 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Oct 2025 19:58:35 -0700
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 0/8] DC Patches Oct 20 2025
Date: Wed, 15 Oct 2025 10:57:01 +0800
Message-ID: <20251015025816.1542507-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: 90610e27-4d11-478b-d12d-08de0b96bdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5sJLH173OchpE63gfrfG3SoH+HtMoKl1aPjWdxT1AW8mMfmaSB6nZEiHhTz+?=
 =?us-ascii?Q?EL7BrsXibvgw/GTetUeEFjP19SqYEWC1no3K8RJHMK8nFI3hhYEeQPUOAAfz?=
 =?us-ascii?Q?lHKfw4Huz18Yh1hx3VZPMDsi67K5TgmaLhKPqCGghvw8sI6Q1awLp2KjfCS5?=
 =?us-ascii?Q?kz47O8GjJ4/B1PGk9UG2AZUvxW1+UxsigiqWH0SFNnBZ/+YQwYnsDNKm+s2P?=
 =?us-ascii?Q?CGQBJ/RX/hjlhJEKTodm10nht84Hx1hQqktbFZKwSlM0zJzW5k6UF2qpt7Vp?=
 =?us-ascii?Q?kfQg1KrxDCvC5q+UdVTe0uF5nuH/3jvZzUhsZoTwmPiTLRirp/jGPO/FyJAY?=
 =?us-ascii?Q?nteXqk9Ap3oTDn7E09RVncV3r9kPrV2uqzCC058AT+P3QiGUxRfOdurvt0AD?=
 =?us-ascii?Q?OXBFLRKCPBGvFNKPtLgehO/Up0IvTpx6HTKffCmXSUp6jnQW1lzT77ukfD4k?=
 =?us-ascii?Q?HGXI67t736OAH0FJQTJIY9jZPDIMes0xrrJ624tzuoEwjcf3LoVoO5tK5thY?=
 =?us-ascii?Q?+LXsCY8x1/p4wEQYvgi23c4tkT88zoVXkofA+GmpGsocf43N0EciYz4czxen?=
 =?us-ascii?Q?x62DHQMKIb9uaNsQtgzJ52eVjeK6zYyq7f/atNyim3vQeqvE3S28UQuoAu4x?=
 =?us-ascii?Q?u9G2zzvk+dpA+al1Mz32J4TmjyecmZF/J7x6AtptB6DiLq8bRnAFBPCKbx80?=
 =?us-ascii?Q?zDJvNaZ6i+MaG5O3x7IZsbcT7cJCCYvhg5HY2/YvDPHBBiNTgNBYqEo+CW1H?=
 =?us-ascii?Q?xTVMdVcZOu1g/WxqVFtg1uWg4cwMoh2KPZD1dn//l4kd2MeXtzvkKV8OYgiV?=
 =?us-ascii?Q?FhnNXuCQJyYJT6bEJsi+O7AlSkdDYle04Ct2KKHAW0hqSCpy96fqGXTZctVj?=
 =?us-ascii?Q?u17Rv5Wrj6G2oZahbHnqQxjN5IfBsQNDgWIiO391u7hHzr87JiyYmphT6/AG?=
 =?us-ascii?Q?JLjsL9Z0Dovoa4xqQLSDuXmwbVVzF//1PpVdj2qEneUuaIJsVsI0Evl0oABc?=
 =?us-ascii?Q?UIggE3G1DyXXcvWf46x3eLUzvuMsP+dkmQaiViKU1DoAKlGAWhQk9CaLXP9m?=
 =?us-ascii?Q?f3jO40UJgVLO2HInX6iiCZwtTgrsH5CE+i+uSw4gBSC/p1Ai52kCUpksryjs?=
 =?us-ascii?Q?Hpa35JV+QwX02sdiSk6Yi9Y4GHglIyruk6TSaaPvg4WNFm9pFEosU+1NXmM/?=
 =?us-ascii?Q?AxC/tKVTTnI8FerTnw1uFGDYz8cV4L8wj8WRoISmxshsORfy4oC5mom0vlmB?=
 =?us-ascii?Q?GDkbZyQ60/CaPVj0S7tStMi9TLUeSiAQ4WMW2q2qLxjjvtcVMZ+6ty69XcCU?=
 =?us-ascii?Q?RuOMh9fUxOJoay079mR/L/Zmh9L2g0eipeB9MD9Iex5f5tPSnBHuwXwufrtx?=
 =?us-ascii?Q?zwqInnnqPgzL5XGK0yacaV7V98H0Woleg+DghC6cmiI/5Js5fUI1/a83v3cB?=
 =?us-ascii?Q?wghdSeXEoa18BE8SE++Qvtm234C1owdIC/JIqF04BcoVXVpcx3q3Te854+u/?=
 =?us-ascii?Q?/lZPbGmgWJOz0WHIIRo1TlMoM7sezWlwZcW5FrDiIuDdMwc3Nh+JQfSyo/+p?=
 =?us-ascii?Q?zNw11CnkrNdMFiV7epM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:58:39.0462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90610e27-4d11-478b-d12d-08de0b96bdd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
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

* Fix GFP_ATOMIC abuse
* Fix several checkpatch issues
* Set DCN32 to use update planes and stream version 3
* Write segment pointer with mot enabled for MST
* Control BW allocation in FW side
* Change clean dsc blocks condition in accelerated mode
* Check disable_fec flag before enabling FEC

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aurabindo Pillai (1):
  drm/amd/display: Fix GFP_ATOMIC abuse

Cruise Hung (1):
  drm/amd/display: Control BW allocation in FW side

Ilya Bakoulin (1):
  drm/amd/display: Fix misc. checkpatch issues

Lewis Huang (1):
  drm/amd/display: Change clean dsc blocks condition in accelerated mode

Meenakshikumar Somasundaram (2):
  drm/amd/display: Check disable_fec flag before enabling fec.
  drm/amd/display: write segment pointer with mot enabled for mst

Nicholas Carbones (1):
  drm/amd/display: Set DCN32 to use update planes and stream version 3

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.355

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   3 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  57 +++----
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   6 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  11 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 160 ++++++++----------
 .../drm/amd/display/dc/link/link_factory.c    |   3 -
 .../dc/link/protocols/link_dp_capability.c    |  10 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   5 -
 .../dc/resource/dcn20/dcn20_resource.c        |  28 ++-
 .../dc/resource/dcn201/dcn201_resource.c      |  30 ++--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   1 +
 17 files changed, 144 insertions(+), 183 deletions(-)

-- 
2.43.0

