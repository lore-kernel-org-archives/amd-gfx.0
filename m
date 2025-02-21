Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D459C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3BBA10EA98;
	Fri, 21 Feb 2025 15:09:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7lJUgqx";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA3D10E2A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxY0Vythwwl6n5SsjZJWAyZkm01lE9kz2iufq0Rje9rFQk5XzNwW1ed8/LfP3b7jj4C5OmI7aTXuo6a07OA4uAJ6PQWJwR2iwQt4B3gR7xIbFHaX1p7z2AN8qUiP87U0qFHNriHgiwRPw3yGCeP4zElwGbaWjm0pFFHz/SDf9M947N/eXgJygF+naTXCBJoYYr/za2HaUCGRg/FtUsaRgHrajGP6+zetke4XRYXeVPd8hpkHZ+PlD9qutyb5ObNSrZIX15IZnpVQCyHKESZO91Awm3LhEu6R+/B5MA6RqbiJQgsv7gwTnAG/tsr3HXM9g9cjUmPzhgy2VwOo/I5/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to1xjcul52BvZb51+Kz1ES5q6cRi0f0kcnkMphq3Sdg=;
 b=GWeH0ZHJEWgsezOP+4xgqKc1Jl3ATWwDKqGThDJ47R8LWmoh8FayUMBPVqjo7FEy9uo+EeYnU1Hx7LlLykCS7OyboJzM7UXi/yhER4mStDHmhS6hkSJHMC4jRu6co437n7TBpHPqY2zk+zn2rbsQ0WlknLiIIhzd45+Rn2C6GTQD25p33W+ZMR+ip14fW8Sh+vie7iSUVKDo6i2tkBSdEIn8o0LgQJfg0qwzE3D6LbnFSGZiEKw4TV+lYp7K7ISLoVHZZ6W2/XWxVcg0D9mc+KTQH5FBwwJ7h3Xgcn8RCH2heNx5kq2Yblrs0e9+4BSc5aVbCbuMjUSidFuF3Pwk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to1xjcul52BvZb51+Kz1ES5q6cRi0f0kcnkMphq3Sdg=;
 b=z7lJUgqxD7sDQiQ+wYk/hzN6AkdiUz3uMfd/Kds4hxgYFLDYxN9Q30p5rMTEhZ0/IFvrg9Up/vRKQ8ie/piqzjobfJLwk83F6+opOux/eFUBpg+7cH2svQk2abw8gPVzcKi5DqGHvzW3F7teC6JE6mOTQOeIEpi+jyOx8Wm6PtM=
Received: from BL1PR13CA0152.namprd13.prod.outlook.com (2603:10b6:208:2bd::7)
 by CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Fri, 21 Feb
 2025 15:09:13 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bd::4) by BL1PR13CA0152.outlook.office365.com
 (2603:10b6:208:2bd::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:09:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:09:12 -0600
Received: from aaurabin-cachy.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Feb 2025 09:09:12 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <harry.wentland@amd.com>,
 <sunpeng.li@amd.com>, <aurabindo.pillai@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: [PATCH] drm/amd/display: fix an indent issue in DML21
Date: Fri, 21 Feb 2025 10:09:04 -0500
Message-ID: <20250221150904.246929-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: ec079d80-a094-4a79-ae65-08dd5289b365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eymC6k8n+FoGRvHCY0mF7ornRqo4ZH6BLXF8/ROS0inyX3grH5cEhS0FQe89?=
 =?us-ascii?Q?p4X/F28G7TB0g4vRKpIipmleIKC2FOdKFL2fu1gNRAyVn4b5TyfbZg16Kdvv?=
 =?us-ascii?Q?qvPg0swDLHEiI5fgrSSnr/0HmvCTx14B29cVle4H08+61QhVsE9+Fsmg8lCj?=
 =?us-ascii?Q?nJg+6/rp9oLC3OlvTrb4UwxUMYLN2yrHhKMXEqqlu6J/cfdZus67gKPlpcAm?=
 =?us-ascii?Q?nob6hy2lNEC5xuS2hYzqI4pupFO2d5mOV3khYHJ1+uHpM5aclBdIU1d2rc6j?=
 =?us-ascii?Q?voz6eDgxAmI4AeXJ0cpsmP6LsRd9Ot/PJoFMJARkwjTSxNn7/ykImchH4hU0?=
 =?us-ascii?Q?wnO5Vr1L7qI6sWLHW5l3/OCEKYefDaaWA75NLCs8OentixxT2qs0ZmYvKDrw?=
 =?us-ascii?Q?xZnPXuKsdYLkJia6YtPkSXRyT7GssNLLSfHfJJxaZmgHzFEHLoIJbiT4tUI0?=
 =?us-ascii?Q?I9sAgHfogQlXBEgm6KkA3O+iswzvk+wrYYGcCsIG4kwt1Q718AmdtCIGbURH?=
 =?us-ascii?Q?pjnpMkDH2WABh1LuKPso2kZQM+jR0iYqgUk0YHkPHFo6qpO8hAm7vTLDgITe?=
 =?us-ascii?Q?hdOk6C2M0li4tz4z6ajnabY9/DrLsmVzTiZ4imPFDJLjy6GqnOuroo28jWwY?=
 =?us-ascii?Q?k0hMN5OcmxWHVKrqYaSpgYE7Gl+9sZZP2ISoxvW8MO65eIhlGzrZC/1CprI7?=
 =?us-ascii?Q?1TNIJNyNDVBg6cH3vrDAs0ZH73xnsrvFAHtKO8yzitLuTE5nUeuwyrZY654Z?=
 =?us-ascii?Q?yX/aHqvD7xLLTu8GJ5mBmeJ4KEwhxO6orwupRLLvPRtUMtx9Q8CkD8d0B6+/?=
 =?us-ascii?Q?AAi5f7u0KS1XPYS/TPpMCScgYXVagiC7NSpc9UsTL8LJ6ofx4FqaNVCndM5R?=
 =?us-ascii?Q?0B3pR0mgJJw9wfBiN+VL9ygfPatcy5KlEsBy3MU7PYiJqcGfiezyC+lgRkx1?=
 =?us-ascii?Q?eyrrAqwC0E8WVxQ0aKR/u5JjL6WxXuza4NBrUItQFdv0hkCdZVP3CV+0KLiW?=
 =?us-ascii?Q?bNcZCFH8ixXXXmi1Vtnw3QkW64Uzwm5c4hZ6LN6O2dqpNgpDy9lO2NXfxxV3?=
 =?us-ascii?Q?WdvDvguA847HpYjPYwUCam6Ra2MHdLpt44YnklwJ+YCYuxm9jLXfjTlEyyNz?=
 =?us-ascii?Q?R4DyJgfC+EVwjrXvCQGbGa2RwY5OHfte5kmG0cnr/wf7nidwlOLC026rtAZO?=
 =?us-ascii?Q?X7oODWJCCPLVgihfpD9MKos+IHd6coCGq/qXnAH62BLe351r8b9hf68lG3lm?=
 =?us-ascii?Q?Z37IddfDvW7KL0f7K4/8tbDfMzHgdWIwQJiYwTg21cWmbfpJAlSJiod0ODTd?=
 =?us-ascii?Q?K205w9ejsv6rLtxu8vTw4X+kFyEbfMXf2RI1XX8JdnmJ62G0z7Nmnl4KR/a7?=
 =?us-ascii?Q?GVgq/aHdBjcKtZV6HpeWMQ+afNnZb9lBm39LYzLX5QorB2Xs5/MF0RuFs88t?=
 =?us-ascii?Q?fgCMjQ5X/jTjd+zkQHmIB0UEcit4E9dqD0ObxznBq5ZJQ8GmoHcAcBafrWfB?=
 =?us-ascii?Q?fnczaAr2eAjaeG8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:09:12.9792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec079d80-a094-4a79-ae65-08dd5289b365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383
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

Remove extraneous tab and newline in dml2_core_dcn4.c that was
reported by the bot

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502211920.txUfwtSj-lkp@intel.com/
Fixes: 70839da6360 ("drm/amd/display: Add new DCN401 sources")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c   | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 3664980d1574..0f4ada64461e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -141,9 +141,8 @@ bool core_dcn4_initialize(struct dml2_core_initialize_in_out *in_out)
 		core->clean_me_up.mode_lib.ip.subvp_fw_processing_delay_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
 		core->clean_me_up.mode_lib.ip.subvp_swath_height_margin_lines = core_dcn4_ip_caps_base.subvp_swath_height_margin_lines;
 	} else {
-			memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn4_ip_caps_base, sizeof(struct dml2_core_ip_params));
+		memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn4_ip_caps_base, sizeof(struct dml2_core_ip_params));
 		patch_ip_params_with_ip_caps(&core->clean_me_up.mode_lib.ip, in_out->ip_caps);
-
 		core->clean_me_up.mode_lib.ip.imall_supported = false;
 	}
 
-- 
2.48.1

