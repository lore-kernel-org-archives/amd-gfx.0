Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475ECC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA48710E1A8;
	Wed, 25 Jun 2025 04:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Na0l1Uq/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD80C10E1A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8AzR8RP9+yAOfmL/bzwEQ35jxBRU/yeZS91yEleQi9wMWSAiisPzO/el6Arh45JNNq1WfwrYR10AgD24WjVo/kub4SmBAJhYsoEPsKODR3n1iiUqNEa/mJJezxwAxEx5Bt8SIx9/J8PVXHtfK8/ZVRXGGx37dcYS9AXUfUTNytq03e9Ydmn7usC5DTIAfcvoE89y2JpEJdcLusOhpadFmX9QvEOAlL62UNUcO4irSLbcEVzRRcFH6dT7xv5ybi7VIyyVjiRekSC18ADjMl8ydZeODmAybMJY67HBsoykx/BNibQAie1GAvSuNGpITHt4Kf91EDTfnZdgdAUWYKC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWsT+AxuG8G87nIyW6jverh/C+yxDv26KOcklXYDqG8=;
 b=DjcTv8NOqcGvU1Gc25m6TTys0Dr4LFZnlepjoTxX3UYc29Hdf2cPF8g/GQTJskL54tgYRtzF1CFhk+feCt81kog1z7leclhNo4UC+AtQkDIS1SVUa0MOt4j9ogy7ibrle/6IIdvD+e9aC0N6bidUKdHpejw99Hlxj0HfE1gKAxoOwYDbrzGuekHLvUPeDPqNoF8VZ1907YhFQK5UBwHmA9RMZbqYSaIy8RA80e4bZgVv2uWX3prtHNMleypDkqwgLiDBLCxZgPjIvvzQS2as5SGKE3q1RiYbeGyKR8YYBsCD21uYjAvCe9IrV9xojoTcLptW905Aw1NSNehtP7OVqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWsT+AxuG8G87nIyW6jverh/C+yxDv26KOcklXYDqG8=;
 b=Na0l1Uq/2jHRLMyFIWAoU6mqwEsvDGlBOIGbEhb5nomOg3dDgqSIPXlO6RaRIiUf41YngKuBxVugooiJ76LzTFNyoPsif+laCAw2YZAiOF0t3NyaSQBaz57GblZ/tIRBWSMQdywEN6xKO2pzQCM/49sQIvWaUB0lSewd2gaQwUo=
Received: from BY3PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:39b::18)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 04:05:11 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::3c) by BY3PR05CA0043.outlook.office365.com
 (2603:10b6:a03:39b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 04:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:08 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:05 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 00/11] DC Patches June 30 2025
Date: Wed, 25 Jun 2025 12:02:18 +0800
Message-ID: <20250625040420.886013-1-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: b059b025-5483-48e9-33a8-08ddb39d7abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2M99jRyS5MgFlSjbrAenwxCUKj3rTEKUskGtvtyBWNYy1HS75+BaWzV/iFoz?=
 =?us-ascii?Q?g+97G+6t8VMNRc5xzbAc06X7a4HTGx/v87q2GBHoK+F52K8kPchKFir56nTN?=
 =?us-ascii?Q?9xB/M0PCNDJhEZSIHyZg5Tmuwa0XUIob1fpc9gxWQkr3daGn7QqAnjXuqGe8?=
 =?us-ascii?Q?lUJMvbmo2npsdleKAZMOxkE6/ie+aILv5Ba53jDKV+CtnSCEFZxUrFnW5VBu?=
 =?us-ascii?Q?DBL4t+AglWVNtSjyV2M18lg6RQc9vh4jAudnfQVUpC9NCj/sP0upuO90FmHO?=
 =?us-ascii?Q?XdaOAwUBfk8GpvEH9dN6qYQLQxqS66kWDBe+TAM0wYD3B77gkz4XlEdVZ23m?=
 =?us-ascii?Q?3e4+KOZSU9vjXI9Emy72dcvy/3xqtzj6CYQTctuEqWkfpzJUgebH6P7fEEB4?=
 =?us-ascii?Q?PMasovpapL4wN8wMTnEpuazzi9nSDZ3vC4+jBia0zECb5xRKSRsUTPD+nHCA?=
 =?us-ascii?Q?Uc7MLSMHJwzYkdBslUv/+P08TDSOcDMqA1kT7QeaJN9BqpsSrV8Ft03HIkac?=
 =?us-ascii?Q?siyAs3D6Z6CeoErYZVaw5WBQ055FU+KPj6sKh5tXY3cCVlHopU1JxhPVtbs6?=
 =?us-ascii?Q?cJGamoo3xsBeBVMcreSFMS3eAJPdsJLxY9IarpGhZDGBQ9UiljGsiSGwQqMt?=
 =?us-ascii?Q?k3aDWSVDGClDEvcSVYK+msAvMnnynHEMJsxTnEFHWRBrOIxoZWkQ8XmPekSL?=
 =?us-ascii?Q?nIbEXAsobKMzMvT86V06aIGNcbf9gVc2zGbWD++nY+zJiW2VOeWyg0J/3AYD?=
 =?us-ascii?Q?JhX6iM4FBvK3LDvVeUSUQtcmHqv0gWXQSH/GD7bS/7C+s5+haIJGfHpW5SMi?=
 =?us-ascii?Q?atVao1YfiZFD+/RR9s6BCw6/MQdMn8feaw8Rto3j+f8YXGWa5+xerqnTLc8o?=
 =?us-ascii?Q?pQXJK7KEXnnvssByscBKHzAvFsyKyjj16OoIddaqCy7c0/QJF8evskJb1z7K?=
 =?us-ascii?Q?Ebspp/aozIK8ERVi7WzY/Z9V4RvtFLdA7zPs9U1LGmCbGRNTNSQrXHrMPsVd?=
 =?us-ascii?Q?6YF29fy9MRhpykNhUhGfy4twA1Vmf3iJ0CAT5wahPmUVBA5DN88Im4UJ5gnU?=
 =?us-ascii?Q?dB99+ogUWyen9W1eU7bIqUSXim2VrCn872kJIMGgItDs79Ojs9zLpFZMQ2G4?=
 =?us-ascii?Q?kFIFiRqcF3hU42oMgHlIYhHVfc3Y6+A6RBC/71k0j8HHTXdNJ5oCD9z00QWM?=
 =?us-ascii?Q?IfnXqhzfiG5nKoO1n7pokN9dL8vr7yB7w8lLh5gFKMSbtBmTb4UI+OogbWY0?=
 =?us-ascii?Q?JIHbUmprubbMKPmlbmu6WpiwOlxpSqTXsJ7LUwPbsACXA3YKtQLimSZqH0h0?=
 =?us-ascii?Q?7Z69jzlkMM3JqAYjBm976evyFDiFbHM4fzIq4GamG1WAbsPMhg5n+A7dFwwI?=
 =?us-ascii?Q?nXb7cl75K3TxByvl1L4SIekpVOtoIRLX+G+Syhp+kugLIcLsM1jAa7+GhqMN?=
 =?us-ascii?Q?i5rttspN0Ud+O1a6rZiw8Bop6Jr5a0hb43p1h0ibisufm9LTiVMf1ne+0AbD?=
 =?us-ascii?Q?GXt/DeQaM3kxuenb4T7K6ZZ3BIfORbPGiEey?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:10.5725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b059b025-5483-48e9-33a8-08ddb39d7abf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
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
 
* Remove unused tunnel BW validation
* Refactor DML21 initialization and configuration
* Fix link override sequencing when switching between DIO/HPO
* Ensure OLED minimum luminance
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

*** BLURB HERE ***

Cruise Hung (1):
  drm/amd/display: Remove unused tunnel BW validation

Harold Sun (1):
  drm/amd/display: Added case for when RR equals panel's max RR using
    freesync

Ilya Bakoulin (1):
  drm/amd/display: Separate set_gsl from set_gsl_source_select

Ivan Lipski (1):
  drm/amd/display: Add DPP & HUBP reset if power gate enabled on DCN314

Karthi Kandasamy (1):
  drm/amd/display: prepare for new platform

Mario Limonciello (1):
  drm/amd/display: Don't allow OLED to go down to fully off

Michael Strauss (1):
  drm/amd/display: Fix Link Override Sequencing When Switching Between
    DIO/HPO

Peichen Huang (1):
  drm/amd/display: add null check

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.17.0
  drm/amd/display: Promote DAL to 3.2.340

Wenjing Liu (1):
  drm/amd/display: Refactor DML21 Initialization and Configuration

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  12 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   6 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |   5 -
 drivers/gpu/drm/amd/display/dc/dc.h           |  15 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  | 512 ++++++++++--------
 .../dc/dml2/dml21/dml21_translation_helper.h  |   4 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |  58 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.h |   2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  12 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   6 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |   2 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |   4 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   9 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  37 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   5 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   3 -
 .../display/dc/link/accessories/link_dp_cts.c |  63 ++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   5 +-
 .../drm/amd/display/dc/link/link_factory.c    |   1 -
 .../drm/amd/display/dc/link/link_validation.c |  61 +--
 .../drm/amd/display/dc/link/link_validation.h |   3 -
 .../dc/link/protocols/link_dp_dpia_bw.c       | 138 +----
 .../dc/link/protocols/link_dp_dpia_bw.h       |  14 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  36 +-
 .../dc/resource/dcn31/dcn31_resource.h        |   6 +
 .../dc/resource/dcn314/dcn314_resource.c      |   4 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   4 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   4 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   4 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../amd/display/modules/freesync/freesync.c   |   8 +
 37 files changed, 520 insertions(+), 542 deletions(-)

-- 
2.43.0

