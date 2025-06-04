Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4D0C5B543
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0204A10E7E3;
	Wed,  4 Jun 2025 19:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F9uMQ/Hb";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7342910E7E3
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zm/xNmilZl25a8OqnTRUbOoAdO9RyOg8u5CnCG+bGrZ19eao63vjyKN7VTCVrLjUpV3bPCcAowAX/4D314/GNksgxHNhVASwgwdRVN11mEaIqKFwdbEy/3scp3Q8SvRyCUeUl/dayKtcHgpkt+b6o8yGTQDSK2uD1u8XoDRoKzTRW6d/J3/KQwcnbvSiF9pb//GvKLVRQOYLvGSbMn6Hrtg+5RRPn9ns7Ev3DdOnYGN9MNJFurJmtEFgB7ZuTp5LbKSosFeMcAQh8qmQW1lLxAXFAsg9+xCmPBZCyF2ZLON1Ilc2peERkXTTsVNcQedQPUpONxRJJLdqnGMpvn4qOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N147pPdEYXCwTmnBqzRYxnG2mMtgLkI0L3Us0M1lRoY=;
 b=mBH4HXQ2cvH1FBTLt20K5xQjErEw1bhiFOUk/k8SpF8B7g0SsIAzIpcA0pynGb11DPfWglZZ54fyOXTr2K5laSUFJ8CojRtf+GduJTKtH5PAQe0SdpvFON6IlOdrGkM4/oHM+fq/2NKjSIx2KxEBqJdGix27kFbyhblWPzEeZIpJa6e7LP4oJZIcL48GuzGqDOO1Q7GPam8iIAQ6Dx9pIB/Gf9wWK06TWcsfKPtT4y1WPvSh/T8+2Ab5STadK5pg0RkqT2Ao5SRC/Ui6iN9OrI1nInZSeUQKkqufHcX54Rrs3votrdZut6VJ/HHTVw2RlBJWrwQUMuVql/6+SbILfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N147pPdEYXCwTmnBqzRYxnG2mMtgLkI0L3Us0M1lRoY=;
 b=F9uMQ/HbZfEvatRDbOEUUlbbyF2ie7WYWJ8eWUDFAGbrofADIQgAKyIICsE+OBgqU7kneL6NarV1b3bbA/yeoPT0f7nj62wk4CDf5X6bhUagravFnVkRWU+IU8ODm6+U9GANby4YHLLrtEkqGp0PQjKHz8iHVdfz/BWchFCE11c=
Received: from MW4PR03CA0317.namprd03.prod.outlook.com (2603:10b6:303:dd::22)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Wed, 4 Jun
 2025 19:42:15 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::18) by MW4PR03CA0317.outlook.office365.com
 (2603:10b6:303:dd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 19:42:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:42:14 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:42:10 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 22/23] drm/amd/display: Fix kernel docs for new struct members
Date: Wed, 4 Jun 2025 12:43:33 -0600
Message-ID: <20250604193659.2462225-23-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ec308e-bb4a-40cc-2a2c-08dda39fe810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4QceynvIkzppbVz45ks1swydWB/jhToI6uoyO06j1IzQUQxUiKKWjsvusqA6?=
 =?us-ascii?Q?bBkZ28+1DGKBpV2pDaeEGXCItsybV/EpaPCByfbn/rsJ4xwE2cA/e3GMUciZ?=
 =?us-ascii?Q?LtraWdUIqYukptbR5c65p2pGo1uqWK4wN/CLrXAKRmT3HhREQRTCiZJ6QZRv?=
 =?us-ascii?Q?mmMQXFidfiMAH5Jn7unNOFFxFuOhXVV6LtVPtqJUzJ3jJQidC0dPeK+gYj8v?=
 =?us-ascii?Q?UcGdB6SfNV7L/xWwg5vkWgOMX7xX/yYcPzmeGKjmBElZMynni8gMc3rThneE?=
 =?us-ascii?Q?FxHiOxKlZewTb3FJnzn4GtJ/FO6ZxOXdPP2fhMga2/Z30yCh4IREYHPHl/9+?=
 =?us-ascii?Q?HiEId2g+t/+KxyMAUDxRo+9NR+mdaJded6/VDmF4DUYh9t8T8/0R1fJpb6WY?=
 =?us-ascii?Q?frWyjFKQ6P7UKz8My42nwUao4MOrkGwA4sC9XNGQ+TUsd2X8mc1+fE4VIOWh?=
 =?us-ascii?Q?MqZA/e7+cuXT9Hq5oEQa2IfXgWB5i3qczhcxHtaMb3pPC8W1T1zpXoiy6qgA?=
 =?us-ascii?Q?RKO+8xLrWiCVwhoWXmF7C7dQ+AFpQwYZR82gfPo4O/bzwfJOsucmjIe5PFL/?=
 =?us-ascii?Q?5NV2dQ2hQxgH8CnXeh6GusqUWFYLpOFb9SZZcO8FVBx6bSHwn2/5PC7uOYzN?=
 =?us-ascii?Q?Ufo2R9DboHTRCHjQj1HJ7Xg0B/FlpSu04cLr/CJHgfxedq9rYGcUdatLwwxV?=
 =?us-ascii?Q?xjGTm8srEVT3lyG1gfqGjyf9Ht964N56YK0N9Fa+sMVcaJ9AQJ/gaef11+GC?=
 =?us-ascii?Q?d8d2gDhk4eVRmvIomLBDyaqupSkiq0AoCpp27GL4IxaMnh2a4b4QtFzGdNFF?=
 =?us-ascii?Q?8zLszvFt6HxKjb2WWzao87rxK4T45vNcRMD2pSNQr69HrhEBn1WW0Tbg2+oW?=
 =?us-ascii?Q?WHnOSjtF1lIWT1RR3slrKIjEG0giCL6QK0FduM2s1ElbRy4tkMTKGuN7jDxX?=
 =?us-ascii?Q?O4ZPC2N8fqEUltS+Ew2M15ZTWe63vr3zURJGeLEj7iaHJ50G0Lfymlt1mvZR?=
 =?us-ascii?Q?Uj7DEiWjFcMnydKbX4Xs1j2HMbrRWWlTq8bIpZ/XH/9TIv3lIXqltRAb7ijT?=
 =?us-ascii?Q?Hq+gezWE2Q5Md1ESCe9+zYMv0UmdotuhdLEvxc0qas6zuW5q7HHplL31Kcfd?=
 =?us-ascii?Q?dawjazFX2Lx5ZABNQRyjp4BVuVePz18jH5F3ipvHtd4a1i6X2DqCGjDI68NI?=
 =?us-ascii?Q?SHP6lettShmQhKorQx0xaALOw2xKN7wMxJfcGg/Wp/LWlwMRyscfw1t8Pe7x?=
 =?us-ascii?Q?EFChVsntFiUkx1g6misrMQNSqmpefgDx71PiCscE23wQR5C3m2by/T1Sv5rP?=
 =?us-ascii?Q?kT54xt8txnZ/TyBeuelf/2aJAQytPqdk3/8FMu7PG1eryr+RUBojXffWbrTw?=
 =?us-ascii?Q?K175X5vxMMxXLut1sU8ItE0rkNJjQAoNQthcFbXFQaatIz6YffVaXQajuRSL?=
 =?us-ascii?Q?/8bOthlFvGkm0yGm2HeDSQn9CPij7tYIMi+pLlxiD90ho73akvV9jXP77NTt?=
 =?us-ascii?Q?4SWHO9mSSPRY0nPbgzJjJztH3GH4kg+22gNe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:42:14.3569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ec308e-bb4a-40cc-2a2c-08dda39fe810
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155
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

[WHAT & HOW]
Add kernel-doc for new struct members for lut3d_caps and mpc_funcs.

This fixes the follow warnings from "make htmldocs".

./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1106: warning: Function
parameter or struct member 'mcm' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1106: warning: Function
parameter or struct member 'rmcm' not described in 'mpc_funcs'
./drivers/gpu/drm/amd/display/dc/dc.h:249: warning: Function parameter
or struct member 'mcm_3d_lut_caps' not described in 'mpc_color_caps'
./drivers/gpu/drm/amd/display/dc/dc.h:249: warning: Function parameter
or struct member 'rmcm_3d_lut_caps' not described in 'mpc_color_caps'
./drivers/gpu/drm/amd/display/dc/dc.h:249: warning: Function parameter
or struct member 'preblend' not described in 'mpc_color_caps'

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h         |  3 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d57c57cabd4d..74379edcc4b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -235,6 +235,9 @@ struct lut3d_caps {
  * @shared_3d_lut: shared 3D LUT flag. Can be either DPP or MPC, but single
  * instance
  * @ogam_rom_caps: pre-definied curve caps for regamma 1D LUT
+ * @mcm_3d_lut_caps: HW support cap for MCM LUT memory
+ * @rmcm_3d_lut_caps: HW support cap for RMCM LUT memory
+ * @preblend: whether color manager supports preblend with MPC
  */
 struct mpc_color_caps {
 	uint16_t gamut_remap : 1;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index a5510bedca4b..7641439f6ca0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -1075,6 +1075,11 @@ struct mpc_funcs {
 	*/
 	void (*program_3dlut_size)(struct mpc *mpc, bool is_17x17x17, int mpcc_id);
 
+	/**
+	 * @mcm:
+	 *
+	 * MPC MCM new HW sequential programming functions
+	 */
 	struct {
 		void (*program_3dlut_size)(struct mpc *mpc, uint32_t width, int mpcc_id);
 		void (*program_bias_scale)(struct mpc *mpc, uint16_t bias, uint16_t scale, int mpcc_id);
@@ -1087,6 +1092,11 @@ struct mpc_funcs {
 			bool lut_bank_a, int mpcc_id);
 	} mcm;
 
+	/**
+	 * @rmcm:
+	 *
+	 * MPC RMCM new HW sequential programming functions
+	 */
 	struct {
 		void (*enable_3dlut_fl)(struct mpc *mpc, bool enable, int mpcc_id);
 		void (*update_3dlut_fast_load_select)(struct mpc *mpc, int mpcc_id, int hubp_idx);
-- 
2.43.0

