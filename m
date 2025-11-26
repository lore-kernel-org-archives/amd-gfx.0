Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730BCD10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC9710E243;
	Wed, 26 Nov 2025 13:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tYJUr/Ch";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871E410E243
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUYcMlw90Agabxp80p2k31g+aZ5CMOd1h7EMgWDYpt9H+FOTtzkRB+4lBn+jBwYCcmfyS1Uht92xyl8n6fdaX3W0pifs+WqjpMEq2z1NFVcjZI33POjwXD121HghLQSMx5kEHpGebD2NEpxQY1gvuVDhvis+9FlTwoQ33/wRHPlg9DIk+e+SPsonNfC9Y4ZfYlTJfwhXndGcJpnGjf/5AO2R2yoau3h9UlYSjvOFAr55JNg4/39WpstNkpQDXbinpFib4+INAb8Jg32f2Yl1Oa1/OUf2In2Qq0ZVTMDK5PFqL507P506HHm8i1XPIar+YndX6QX4WVT8VmLBcY4sOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf3u4ffeV1SoL0675BPvsmuXW28RqB0u6dHPt9tN1NE=;
 b=K0IE5lxrx76uR2FDnsLIz3YsXvM47gB/IezhMvHa3il7tVJYwChFmJ4940egAvp/jwz9ipJLetEK+SFwZBG1SBsVBA2IsWKga/yotm243eBkTKVJetNDJPWOZ+L1LY9MJDQ/Ih7QDRIDN2cdPOZqGvB5dBRls9J1P7ThwaAH1yFzBgbExXiVwFZbdrt5vHN5jIGnwCfwtYNy2c4Di4Li2+nR9PV8h02OkRFXmVX6Q81bxQUB+yl/YSzxRywez11Bn7DwEif0SOXOHsLzopxiT1QG+vkp1ZC9fP5CKyEI9z5h93cAXL1WFORTrWgBdxustWl5Qu4cDrdW7HUuOyhBXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf3u4ffeV1SoL0675BPvsmuXW28RqB0u6dHPt9tN1NE=;
 b=tYJUr/Ch9xZbpkPqzJICe2wYBVy0RXM6amDww4qN2P3MjhWfOy0D4EXjpRpl+hMr/qiTmLKn6hQhmkgmJJKTCdQTMWGXzr840eVsWq3qUKOjYOo9f8gI+v/NfJeLoNs6nm/tklzwAHKl0F3lnu3PS63DPcyjuY7RbZP4lOrhZFk=
Received: from BY5PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:180::34)
 by DS0PR12MB8217.namprd12.prod.outlook.com (2603:10b6:8:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:28:42 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::85) by BY5PR13CA0021.outlook.office365.com
 (2603:10b6:a03:180::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Wed,
 26 Nov 2025 13:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:39 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 00/20] Remove print_clock_levels 
Date: Wed, 26 Nov 2025 18:53:47 +0530
Message-ID: <20251126132822.3266730-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS0PR12MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: f0362fe6-da36-46f7-d80c-08de2cefb793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tWUVt8na6jvKuBixSEqsJYoVTTPv/6g3YpcXrjwl//VHGkfNMkzjoH+FuqaQ?=
 =?us-ascii?Q?GTDXQgRrbPVOBrbc870+pPyrcOIIx6GWH7sdl0TweOPPcVgnn0ctmGlvHz1b?=
 =?us-ascii?Q?VascYuNYHgOzLPvBpVR+t0N8jgRj2YdKGbNMbRTV5VPUMWYvDqTr79YgDHax?=
 =?us-ascii?Q?i8ttwijyif7JbzrE8oaHdp06bDSLiFCXTHBUbaP01Gf3X+fx3mXKQ3vteUqY?=
 =?us-ascii?Q?GbF49xCJc7ENl2fzpUhlkiJFxGfjh47YMv7yptwnWv9v6tH1w0/i6xRAf8fI?=
 =?us-ascii?Q?Rmi6KEwotv+F5CFu9GWK1nyr3WCdzwb7qkBblQNI5MsjXcznHQMilhnl4vK4?=
 =?us-ascii?Q?RNFhzqmZdQUV5wfJprk+gU7D/lIxeZA2yjbveMSi5jlQEhi5i+QNlgQEdk3P?=
 =?us-ascii?Q?EPEltehgYM1Y7iyGsWq6uNr1+/J7hpWwF8DdwX4GXPqT10EICxpXZ7Q4Eg8L?=
 =?us-ascii?Q?Dg+ng8XtGP7HpCDrlhjRFbGl5cz/WbwlT7/iFvvy1r6gjqzBNzQGQBHOSzH5?=
 =?us-ascii?Q?5FPU6ykWxXEaAn+sIvOpVckIwLbbWSzRj/PG9Uref2ZKQwmqACDj0+6WxlGN?=
 =?us-ascii?Q?nRvKNIiaPqoQJkXPNbH/2SauCIqfucMoBipuN5HFY2VHxI5M5DM2r6BUM0D7?=
 =?us-ascii?Q?DO1/8xlk/dBs6TR25/yDO+PRCR42u6iouaArfQa5hAr5XSURvXjWjNTf2jzs?=
 =?us-ascii?Q?ZnZ6sZJN6HBiARzqfYFeRCiPfsdQXxKFnIy9olYRdeauoe5k2gSvU0fUrn+X?=
 =?us-ascii?Q?svAahForJco/vVNg9kfl7HHRqxMybS/0U9ogTC6vR/t7zNEvj9E/ylnz/Q4E?=
 =?us-ascii?Q?SeBDo85kWTJoKMcjyDm0mw95xF9mpIFwiEmYzar0n2ReEA3JWp/p/bpPPzcZ?=
 =?us-ascii?Q?sA1mNDGq6hM0ugve4xDLxO1SJxah2XPhbvL+xKM/riq9eZ4uqRfC/sYrszE7?=
 =?us-ascii?Q?ShGqkqU3HddnVYuaYeupVIVQC1Dxfvhr8RGutTRGc2bduBytz/J8NeBXJkxP?=
 =?us-ascii?Q?Rf5J2SpNNcX811DWBR1erLyWr93DsUhFZpkyO8x13hN0d4sQrMGH2ccdgC/a?=
 =?us-ascii?Q?Lm4oSZ2KvzN6agiGg4qw5caNxbqVSwtD1Uk8PV5U7lC6g+8AIA1SVev6TaPz?=
 =?us-ascii?Q?seYjZQQLzWPRnRgiwtdQRotL/Hw6+4MtaNcPDOWRPV0KW1EsYyupmwM0QlpV?=
 =?us-ascii?Q?pJCnT6M8qfUGRU2zBYS6LDIQ9h7b2nhI9JXLljCGQ4thKlBtUQLTNSsoXcUR?=
 =?us-ascii?Q?AMpi+Hj0R/co/MD0IlsBsi/BVvffXGyAzvHbd58UMAnu4VHndtAUmP0eFkzG?=
 =?us-ascii?Q?Ztg8XqJ91ZCC84zipeHeGIGbqDv4sSuoryWsfphLUWaxD/2ew4VPV7+LYFuK?=
 =?us-ascii?Q?H8lMme6SpZio1jcGiXsybiacXcP4ulcnlc8xq7UNbmjPBkav6TNI4+x6fO6c?=
 =?us-ascii?Q?5wZF4N8B2y3DGy0TJbCEM14mRXN/E3CojHPzscO7ags4Ln030hLS5MWnEDe4?=
 =?us-ascii?Q?pY3m72D56ko5+8I2E9EWt2Gpa8Pa6IpDbHyNDjiIY723akWurQzVULnVx/uI?=
 =?us-ascii?Q?5iCrgIJfJliS+5nq0ik=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:42.0542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0362fe6-da36-46f7-d80c-08de2cefb793
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8217
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

To print the clock dpm tables to sysfs, presently there are two interfaces which provide identical
functionalities - emit_clock_levels and print_clock_levels. emit_clock_levels is more flexible since
it provides the offset along with buffer which matches closely with sysfs_emit_at interface. It is
not required to keep both, hence drop print_clock_levels. 

Lijo Lazar (20):
  drm/amd/pm: Remove print_clk_levels from navi10
  drm/amd/pm: Use emit_clk_levels in sienna_cichild
  drm/amd/pm: Use emit_clk_levels in cyan skillfish
  drm/amd/pm: Use emit_clk_levels in vangogh
  drm/amd/pm: Use emit_clk_levels in renoir
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.0
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.4
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.5
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.6
  drm/amd/pm: Use emit_clk_levels in SMUv13.0.7
  drm/amd/pm: Use emit_clk_levels in yellow carp
  drm/amd/pm: Use emit_clk_levels in SMUv14.0.0
  drm/amd/pm: Use emit_clk_levels in SMUv14.0.2
  drm/amd/pm: Use emit_clock_levels in SMUv7.0
  drm/amd/pm: Use emit_clock_levels in SMUv8.0
  drm/amd/pm: Use emit_clock_levels in SMUv10.0
  drm/amd/pm: Use emit_clock_levels in vega10
  drm/amd/pm: Use emit_clock_levels in vega12
  drm/amd/pm: Use emit_clock_levels in vega20
  drm/amd/pm: Deprecate print_clock_levels interface

 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  19 --
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  16 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  16 --
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |  65 +++---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |  87 +++++---
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  29 ++-
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 141 ------------
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |  52 +++--
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 211 +++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  28 ---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   |  17 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 193 ----------------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  27 ++-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  39 ++--
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |  52 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  21 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  |  24 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  25 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  30 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  21 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  25 +--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  24 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  21 +-
 23 files changed, 443 insertions(+), 740 deletions(-)

-- 
2.49.0

