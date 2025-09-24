Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC8BCAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 18:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587F610E258;
	Wed, 24 Sep 2025 18:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iY/tct9d";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C712710E0B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 18:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9JxEVbqeSK1AQ2QwY6rKnvQlW70AprAGvkr1SEofW1DhUrW0KMLmZ8obGs0NqQXJwYdxSc4YjnhdvzrG55uDOCmh145lQ78euEWuFjJNnzlZobvWqZ2+p++cdWHV62uK3PFaERwySOuZlLKAB9LOd9gzS39tmcisqvDJaW/uLK230CbSP5e69iadDJGmRJrc4JGs3EH3ChrzUO5eDuofyPv/tu5UWRfN1Db00NxAm6Ax2Hmf3/Ul9fjQF6tZL558/e0rHcaR17OSlPPZWqBGqkxyxJyGwVTjdcND1S3gVqTVpHCiMzprlzYBQP1kpivVODOeCZ6aqFxTekUydRAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppIqimTN/ndpSEAXTyV9Mczz7k0SGt5+FetpHXGkNeY=;
 b=HrhZ/2s7lrTwnTPhtxhhh3s9eVqSx7oScNJF36rB8iCVLMEVdonjLlCkUTSEKRUPXVrCDpMuDKF1sUQYT0hHfY3/dB3ZnjyBQIXyOUTzaW1yEPF7BB1CVjeMy0NtROG6RiUBfguLUGVnxciH/OY5mSdtD2ZkzNJKdYWTurtexkFhtqVvuq3qM5nbrAL+CodibMDYrsSP352gVat6IG6StRCSE1fqJg413aM7q0mhn66qNYG36Bslcrdws7uZIgvfesJO5mqBHO+2OIQnRh/1dF4igEISP8wUq4Bm5s02eLXLaO2tkFXUe4Bp6CSblEiIkB0qJEQze8AR7NHC9IoX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppIqimTN/ndpSEAXTyV9Mczz7k0SGt5+FetpHXGkNeY=;
 b=iY/tct9dnzlmgNzhU+GTZOZglAWQ+h8FP+A2Ee/CtCi0JJwnt6LroWzEs1SCc2DXBUkFR4QqiwEG7zQE39OTr5gr00yMKvWtxoh2UQJkuJrADCJPN4CsngIi8/lYsO84/YGXX/AXwSfA8e6poOZZJiexdNl5kxG0bsEc8WwlFZM=
Received: from CH0PR13CA0007.namprd13.prod.outlook.com (2603:10b6:610:b1::12)
 by MW4PR12MB6756.namprd12.prod.outlook.com (2603:10b6:303:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 18:22:22 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::b0) by CH0PR13CA0007.outlook.office365.com
 (2603:10b6:610:b1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Wed,
 24 Sep 2025 18:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 18:22:20 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Sep
 2025 11:22:20 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Sep
 2025 13:22:19 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 11:22:14 -0700
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 00/10] DC Patches September 24, 2025
Date: Wed, 24 Sep 2025 14:21:51 -0400
Message-ID: <20250924182201.1049389-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|MW4PR12MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d3083e-560e-46a0-b069-08ddfb974d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EYUTJIqqZmIMVHtCtfPo9qIUEFAwjVqjcDohxzXtuwvcg/fdcRhimDKNFWWC?=
 =?us-ascii?Q?yzISQ+Vo4ctrqSoqWZiCdOWPGiwXdGlrtQaKCclYcQYz/n3zlG/yY5Ufapx3?=
 =?us-ascii?Q?TxzeqPu+SabIw9jaHNehjzdmBxRXIciFCvYSZpHui8fvZwxKoG4x+Z+7tk89?=
 =?us-ascii?Q?zb+3uVqT1ZDRutHFJZQYStvGcdS1Fj2JXwiXSuaGgh/gOL+SJYuV7Yy2aoZF?=
 =?us-ascii?Q?tlwFnZoSsVUq+WlnJnH8BLTCUJn3JlxNXoBNB+/pK43lDYUHNVev6FhQMURm?=
 =?us-ascii?Q?cl9UZjxHrs68Vjs2GbYaKj6u3vNuYEB3kJ4zpC7d8bZjGqgxmU4BZMRo6dff?=
 =?us-ascii?Q?f1IhG73geiIeFLjUVasMSwxk6qEQlwgTaic/AQA/7cmpcUzKnRxDJDsWeXSq?=
 =?us-ascii?Q?VVLJn7gbj38R9Qr6OBvEb+w8o2zLjHDresjcP3tRr5Bd2WNYMwNlvK3bXirt?=
 =?us-ascii?Q?GCmsm+6NruTFmRwfQjCtdiujKPsWx/JB3y27xeHBV8bczZ/7xIjqZq3+zpjc?=
 =?us-ascii?Q?++pUSyJ+HlcTT13qWm2z3dic4pcDBKjcJbzbMoEd8/9CaQIyHAO4IGgjkK2F?=
 =?us-ascii?Q?BG28DWTmWm1hSm4Mno55FbK/UJ6cVTIYv8TxZaanikr6L4v9YX6feSUchdco?=
 =?us-ascii?Q?qOfb0tTZNVVY87HWBpigZgQc8DS3suoyP0Twop9vdh32D+AtqnfIvNDCJ/q7?=
 =?us-ascii?Q?BQ4434302I9aPaVugHFJUTLMI4id7SGEgGR/bkrmcYVU0zofrQLXo0MeP072?=
 =?us-ascii?Q?UpOcPvt4jDWUAdJ5Q9AuPzpHSM32JA4NYceL04uv2D/D1nlAqhl+/B+HDERG?=
 =?us-ascii?Q?xzq8KVprX2Y7rsjHyyyC4/q64FWMpo/0+gAvoHmZKbhzoqLLn/mKEFGSkoOY?=
 =?us-ascii?Q?PzCtUCuhP6xDVdOVJojwgyqhu6fGhaGyi3lOPYzUmosmaE4IK3XCDFYadFLi?=
 =?us-ascii?Q?HC/mhxybgQv90E7FB2MpguwoaAB+2aqhbeb4Jpe6ZROI3bk/JnDY4Ve304eU?=
 =?us-ascii?Q?Po0nwDFJL/0mfbgvCpiL3zwZ4okQPK3XHYJEXpBw9igpaqTZJDrkNTr27Nzr?=
 =?us-ascii?Q?7hV4PUnV6nzWA2ENNrL1oGfbMgee1PixCirBZ816Zwd17P60xbbW4+lOaHeY?=
 =?us-ascii?Q?CBXy/QxlCoYY2jJldWd5TDCeCuN47ZFI8+0Lm1OG0oX920JIggxRCMCuPiDM?=
 =?us-ascii?Q?RDoCs2OhkHpK2Q+Gk41qstmasIj85QvYv868VKyGzZCyJBbJfbEId797oVOQ?=
 =?us-ascii?Q?f//c0OqcUbWkQ53k9KGiF/ggouYtljCj40yeTQfOhcP9UC+za8bH1j04hyzR?=
 =?us-ascii?Q?bisTmn7xantkeElGqRchxqEw+OoEpT6qLsvmgUlOx9lXG/X8epv0vA/woopQ?=
 =?us-ascii?Q?eLDlpJFzN/sjbmCIElmkH8vl37EnsqMo9i6lnoppWf6mq/z3SEdyLxYW0Ak5?=
 =?us-ascii?Q?KjEnq1i0bmqVnLYEgXrdKbdmcea4eHuBVRNDKHK8HBCfvwhs/IW084i9j+zt?=
 =?us-ascii?Q?O+xI2Y6zOeIErTDEJqUTpku5o0/tKp2SuY3g?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 18:22:20.8300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d3083e-560e-46a0-b069-08ddfb974d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6756
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

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fix slice width calculation for YCbCr420
* Fix DTBCLK gating
* Use NRD cap as lttpr cap
* Consolidate DML2 FP guards
* DML2.1 Update
* Firmware Release 0.1.29.0 changes

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Austin Zheng (1):
  drm/amd/display: DML2.1 Reintegration

Fangzhi Zuo (1):
  drm/amd/display: Prevent Gating DTBCLK before It Is Properly Latched

Ivan Lipski (1):
  drm/amd/display: Consolidate two DML2 FP guards

Nicholas Kazlauskas (3):
  drm/amd/display: Support possibly NULL link for should_use_dmub_lock
  drm/amd/display: Rename should_use_dmub_lock to reflect inbox1 usage
  drm/amd/display: Rename FAMS2 global control lock to DMUB HW control
    lock

Peichen Huang (1):
  drm/amd/display: lttpr cap should be nrd cap in bw_alloc mode

Relja Vojvodic (1):
  drm/amd/display: Correct slice width calculation for YCbCr420

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.29.0
  drm/amd/display: Promote DC to 3.2.352

 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  33 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  24 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   2 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  29 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |  10 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   2 -
 .../dml21/inc/dml_top_display_cfg_types.h     |  11 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |   7 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |  13 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  55 ++-
 .../dml21/src/dml2_core/dml2_core_factory.c   |   2 +
 .../src/dml2_core/dml2_core_shared_types.h    |  10 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 459 +++++++++---------
 .../src/inc/dml2_internal_shared_types.h      |  36 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   1 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  18 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   4 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   4 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  10 +-
 .../display/dc/link/accessories/link_dp_cts.c |   4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   2 +
 .../dc/link/protocols/link_dp_capability.c    |  38 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 204 +++++++-
 32 files changed, 663 insertions(+), 331 deletions(-)

-- 
2.34.1

