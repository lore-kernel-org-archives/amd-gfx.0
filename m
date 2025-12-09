Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BE5D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942B010E1CA;
	Tue,  9 Dec 2025 08:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N3Lme8R/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B7C10E1CA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBpiD7iCBfK4vh5b5syqQdxmNe5ae+6e3MgACZ2FIAPqG394wBdDZ2cE0+/dU5jgoWWWVNdGZXYbAyjiQVXBvBZ+Or9jd4kPloEvWjvRqHrZAqCs9fWNys0X7S0dC9yFwMdald/yUMKgdQBz0Ol+Q7SCiWOmr8HI8KJFm8DqbVN+Soxgaek+MjsHis67nonRqHlnwZQVDtQ9yk2INVh5Z8Ql7q4M0Gg1gvpThXJoyr/KZYNNLTwxIuV7KSI50epCe87sZMPjpzH5XaBUdGd63jYmwLlZbJfti6g/4ItK9ExVGYDlbfCfFYb+5Ea2NSKx7V4VpfSD3ey/joUixpakBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGjFvIQV17k6jkaKXqyzPdEijAYqiHLYV20boKkk8EA=;
 b=c6OBkWv0/zoAsxf9xjjFaRHcVLtg9IKEGOg+e/U2MINK2eNZ0hdOvQ7NH+DyGInySTuzTwklJNGQds85rfQBwf5XqjEV8IUQbPHNvrzkulhK6sdiANIjXlNIaP+tMxWY8CEOq4x/QsPKjXDet/cIa5Th0CDsrG7FdLglB4kFOE5K+h0DQcK0CSS9tdFHaia5SYYm5Na68IS7A0BUFXZVz7k8k3GnTJ7u03fIlKA757+12EXq2ru9IKyQx86av6NBPVhIRweX5GEZYFRlNwycDLGpttOSMPLep6zDF5KWPwzhCq3OBJmy1iT/RYy3w6h0PW8hjXLEuu96E+JbTtPEog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGjFvIQV17k6jkaKXqyzPdEijAYqiHLYV20boKkk8EA=;
 b=N3Lme8R/MeKGW0Hz6lO2GY6GdKlf2qd6ZLCyqsKYALPZqDAvvokr+cmS/MLPnKHASq2vrCtjOZJTEX/yEUcP0BsO6qvIzDIa1/AgJN5n+kfE0Z7v7ZEkBCOfLS8vvKYctCzmrOyRvnXGUvzv3w6dvwrWwBq9btrVea1qaIsjNMY=
Received: from SA1P222CA0065.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::16)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:57:15 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::3b) by SA1P222CA0065.outlook.office365.com
 (2603:10b6:806:2c1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 08:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:57:14 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:57:13 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:57:10 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 00/15] DC Patches Dec 15 2025
Date: Tue, 9 Dec 2025 16:55:03 +0800
Message-ID: <20251209085702.293682-1-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0f2f5e-d423-4680-5096-08de3700f2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wv6Em/E6KnHcVETuJf/CRidFFDypKZ9pYODWuxwmZt4ChEAhMjVSARkytCz4?=
 =?us-ascii?Q?oUw3r1JbbJJMqWSPxNYuxsDTEjOsmS55XOXQgYUhn4JuFc/paKcQnn0Dt2Ny?=
 =?us-ascii?Q?Zheza9u4hV1ZCzc/CiSr3UdpO+PF6XL6YGUDPlQlWPgYKlxsb5ORQTycWFDC?=
 =?us-ascii?Q?LO4s70gteYKBV5hXn8H0vTABg7BY4eSH9WfxgBY2E646QiollLMZvzrU8B+i?=
 =?us-ascii?Q?eGJW4aJ9th63mp7H089hSX+zS4xK0cxfIKYQRmv9cUWOg8SvHd9ZsnJ+eFeO?=
 =?us-ascii?Q?TJDOmw3oeOvTr6X/HHr3s2cLEPvTv3Yh1w+DfyuHc9ZzFu5z+EYMuEt2uT6D?=
 =?us-ascii?Q?BManW4zqzp6/Vb8/inxePdbe6H0qCX324HMF5UxF3hqMpD+NJglclwd/rFx/?=
 =?us-ascii?Q?VVUKnomxeEousI9UeYJX+6k29rnTTEdav2t8bJeqiSLPsGs9iBae1jvP9kwS?=
 =?us-ascii?Q?ob4o9IIvVNcR/1FkRB/4QSNeO2Vb7rvpDp5nxhQvf3nSh+oO/yE17qCQ7H1I?=
 =?us-ascii?Q?Q1iFou5aYzPKGTyOfKGpT/MCdorjH31z9b5f0R5eJ29eJC1oExYUC0sGXD39?=
 =?us-ascii?Q?1zN+vLA19NfE9SvqqXMORsQi8EMwF8S9KTmW9+uyT34ZpPxEzSjk3Z4VuaB5?=
 =?us-ascii?Q?N1ubmN8PncFOQ4GxsaMkY7V4edhsjhlWBf+s7VcHb0SfrpRUyrCyNcgp6a3M?=
 =?us-ascii?Q?//jwALFEXJf3Cwfpujx3bHGTmTeiGjScjE0qmdVuQBozuqOCq/HT4DJWuyF5?=
 =?us-ascii?Q?WepGyeJ31QIM+AsgmZtTK3gkI28GcACHFJWazxf5xph6o79pDB3s7bbdv2XE?=
 =?us-ascii?Q?D7E9vaXxnUjcCEYZ5FVTAwjm8mbmqY2iSa/MjzqbD+6Oou//VOUg8MxLnK++?=
 =?us-ascii?Q?fJ728YaolHoSQ/AGrKND3TIRm92ZYRnNhI4i1/qw8qcUkixWSOWyLVfelTB7?=
 =?us-ascii?Q?J/D4BCNj3T+nAPmaZvE1Wyuz7qJquftirmaX+a2dZdUknbTJyzMXaEnljYKJ?=
 =?us-ascii?Q?B5UmGdtBtdYd1gE0ikxPINzK3I2RDLf8OPsjqnJDf2DAz+bWSBncSo4wnatZ?=
 =?us-ascii?Q?rdKXl9j3sA7nQ2rNAWSqUY9ydn7rr/Pccwo4Kb764sav+MjzVAycreyqCkDF?=
 =?us-ascii?Q?PCwFVnQVJh+Kit4lbYFr+tyXKQOhHpXYiZN7yT3Y4xFDKhRxy6/+k3scI6bZ?=
 =?us-ascii?Q?oxlnAll+g+J7mna8oNukeW0JKCzIPWJQy7sc2yBkG3P7qr+QMHzq9RQRHnQ6?=
 =?us-ascii?Q?Ar/zccOpuNch56asKtIm8VJj8FmWepVAWfOFvYPEC05Lk55d3itoCT53okIp?=
 =?us-ascii?Q?WP8vvUV072yBZmXj6ahbJPJfEqzJMbsMliRd3UV3PYHINA6Lko/D8vmFqSV7?=
 =?us-ascii?Q?MWxLQP9v2A6J3OeunNB+B8sMqcuC+naXSGylaktqyLs4+47gglv9pRj2ahLi?=
 =?us-ascii?Q?8s7X3J9t67GBpEYjxOuluPc5Cqyq0hC6OLivtvhnrJtU3ggauB/BM9bgERYt?=
 =?us-ascii?Q?Xl3ErUMYRHzR485aN6VRvXGOu2TqqnOewD7qLB8Vibrug2cmfP5s3NIvl2He?=
 =?us-ascii?Q?4+tyE3YHkTtRKgRiQ2k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:57:14.6394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0f2f5e-d423-4680-5096-08de3700f2d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:
   
 - Replay Video Conferencing V2
 - Fix scratch registers offsets for DCN35 and DCN351
 - Fix DP no audio issue
 - Add use_max_lsw parameter
 - Fix presentation of Z8 efficiency
 - Add USB-C DP Alt Mode lane limitation in DCN32
 - Support DRR granularity
 - Don't disable DPCD mst_en if sink connected
 - Set enable_legacy_fast_update to false for DCN35/351
 - Split update_planes_and_stream_v3 into parts (V2)
 
 Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Revert "Fix pbn to kbps Conversion"

Austin Zheng (1):
  drm/amd/display: Fix presentation of Z8 efficiency

Charlene Liu (2):
  drm/amd/display: Fix DP no audio issue
  drm/amd/display: DPP low mem pwr related adjustment -Part I

Dominik Kaszewski (1):
  drm/amd/display: Split update_planes_and_stream_v3 into parts (V2)

Fudongwang (1):
  drm/amd/display: Set enable_legacy_fast_update to false for DCN35/351

Oleh Kuzhylnyi (1):
  drm/amd/display: Add use_max_lsw parameter

Peichen Huang (1):
  drm/amd/display: Don't disable DPCD mst_en if sink connected

Ray Wu (2):
  drm/amd/display: Fix scratch registers offsets for DCN35
  drm/amd/display: Fix scratch registers offsets for DCN351

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.40.0
  drm/amd/display: Promote DC to 3.2.363

chunttso (1):
  drm/amd/display: Replay Video Conferencing V2

hewitt (1):
  drm/amd/display: Add USB-C DP Alt Mode lane limitation in DCN32

weiguali (1):
  drm/amd/display: Support DRR granularity

 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  59 +--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 351 +++++++++++++++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  31 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  31 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  14 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |  15 +-
 .../dml21/inc/dml_top_display_cfg_types.h     |   1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   5 +-
 .../src/dml2_core/dml2_core_shared_types.h    |   1 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   9 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 102 +++--
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   8 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   1 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  16 +-
 .../dc/link/protocols/link_dp_capability.c    |   7 +
 .../dc/resource/dcn35/dcn35_resource.c        |  10 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  10 +-
 .../dc/resource/dcn401/dcn401_resource.h      |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  70 ++--
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 +
 23 files changed, 613 insertions(+), 134 deletions(-)

-- 
2.43.0

