Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A6BC35FFF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 13:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F33210E473;
	Tue, 17 Sep 2024 13:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qnnRlBTn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92A410E473
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 13:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwNG/0SiRwKWttil/LhDhFBJh7NE+jBVzr4iDsv+IF4PLOKRcJBmKsijRqXQc3kOFEzfpnSq+Mu+/DBKX4cXLyp+3zcmCOtDTBRlx7PY/zolDyUzMYGOKMNEX167y6Ua3CaNWfDhHStoBYo7M/SZkWyUo91ock2On6qB6kn7SCeZJI1HEe1EyFaKhnjcoTX4d4gCTxuBPSGrQRVU0r0TMf3X68EHOh+srcmOwBqQid/hC3FVTdhcfgEwvWsebKwHGOur5rbkEcsBiWEbt/JuLKLOdp8ZY2rrxma5V0soIvgPbB3gW2VQpsRCxmB0ueRIkdfC49CT6X71ROdG+jtqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8ixXGiiOdOKK/dvl14HstIEtlHhkRd+8kwbVG2nAc8=;
 b=Z7k9rA4cVrk/qx1QoNayD1BdyOBMMaGzFxa5mEXEGwAuyKBQ3JtjGBX7ErvN4W1cfgHJT7imKihg95MChQsutK57k5LOuOCpBucWhKR+muhxegwoKD8BfLmibX7+4ZHzLRp1e95wsmFvutQKeRyeKhd7nm5iPAvz8jNPoXDItfjAuOgwFgJi0R455/xjgjhs5PLVbQS2LuwcIkTO6C0kVY5bl0avgvJsZ7hymU9lWOUqHSp0AiiTgIB/CMXdWgCJBPBy4+jW8ZQBlB+OV8ztLkmSPCw2Z8jxSPfIsWj2Hd757KDirutysUeyp7mipKqgVtS0RhavAsWZ253LUKYegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8ixXGiiOdOKK/dvl14HstIEtlHhkRd+8kwbVG2nAc8=;
 b=qnnRlBTnp8Ht8GP8OCVNE/CIUKBppfe9bb8xP6RSlbybhqu9Mw220EY4NypTd9eiXzvd0KKBs7bCH4x8bp3hs05CgsNQFxEDgs+10Oc6QIL9hQJud4zkNLhyAom159TQIC5V/HO970cssKZ97KF4bI65ICbYcmQZts4xfSatfeo=
Received: from DM6PR12CA0016.namprd12.prod.outlook.com (2603:10b6:5:1c0::29)
 by MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 13:13:55 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:5:1c0:cafe::da) by DM6PR12CA0016.outlook.office365.com
 (2603:10b6:5:1c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 17 Sep 2024 13:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Tue, 17 Sep 2024 13:13:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 17 Sep 2024 08:13:51 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Fix kdoc entry for 'tps' in
 dc_process_dmub_dpia_set_tps_notification
Date: Tue, 17 Sep 2024 18:43:37 +0530
Message-ID: <20240917131337.3362425-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 2556c69c-8163-451d-036a-08dcd71a9516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rnlmAERvND+7pXbvBWRm+YvPS2/r6ZRqOe3Lq9ga88nysR7pk8gj3K+ZAH6I?=
 =?us-ascii?Q?FGSc2vTjkhZcrSP+ZKmh6qoe+iwQiG9dImp1ImTfQjqSR4GMYr+fULtflIb6?=
 =?us-ascii?Q?UECRlR7AKFRHdwsBGebfzSFsyavzPlYPeaZPVBriJjT4hxdR8kGX8H1nZakv?=
 =?us-ascii?Q?YG4D7nEeBpVpEsJLGqy5Ekhn/Sinln/3G8BImBO3ljLsVkrFcAPDScjeRR3b?=
 =?us-ascii?Q?ktfBKEpRu1QbmYiMcZoW7C0WB7tHdCtjM6eHlUGXtPAoSDrbla6oqrL4Z4Hw?=
 =?us-ascii?Q?rK2Aw8msLJHBwvGxuhb8LnYpc37TPZ7TX1rB94gD0AzCIVvpOvHNPFCuBeHj?=
 =?us-ascii?Q?GSLdmOYDJxhFIfCttjrXlEJSWwQyiB/g0gmEmRAKFm7tSQ0nBKXdYwZoxRRL?=
 =?us-ascii?Q?R4dyS9tjhVbykyFNM8+Cup/kVy8xv/Rm7jqDBUheMykrhK3v8I0/DoiwZIPt?=
 =?us-ascii?Q?R6JEByJUoLxijE3AAK69HZAEjSuHDXpv6ar6ZhQsT3cgF1K4WK/pBfBykQY4?=
 =?us-ascii?Q?YaVfpv17zoipc+9upROgBnW2W2AOxtor4ImaKu7v01NX1Kskd36jXeLdRAmo?=
 =?us-ascii?Q?+uXYOSvihLpP25ILgjNCThooOOgX8i1X+qX0aZQ0Oo5Ly+4YtlCK1t6PZS3g?=
 =?us-ascii?Q?YF4PNNRtbTb4L6ANh1Fa9Bj8eL52y1cWypAVjtFLZX6Z0h6k/NRAau7sbsbs?=
 =?us-ascii?Q?jzdW48da+5zW2BGTHjOBYy52yKgmMhznOM0EwItUGbEtzlaaBwmJScSx6PrH?=
 =?us-ascii?Q?f9pDREcAf3r65ZYGwbatc1dk+VHXUlSTI2lBNt/tlFFUx4LNCpnOr4LsO/Sa?=
 =?us-ascii?Q?4cQYGos+XhesZtQrJ7LTwzCM/nyFSV6aFsvMpd5AAlocdL0QJP4t0jcgFChT?=
 =?us-ascii?Q?mKt+5wy9zk49/yDkzpvziaWuw76J5yOfvftwwBgAYO8sk7pUU9vv2SdXbjLm?=
 =?us-ascii?Q?NcNlA2sNzInuB2aK9lZiHz+K8eFhmsG020WUbQNmkiHrUaTpQPdzTICPbHuc?=
 =?us-ascii?Q?eje6fpbpN8UWj1Px+RtHnrVlJDcaoImmYxVaxWXhm2EyMaYYI134jEwRYV8n?=
 =?us-ascii?Q?MtVAyxk3JxybABKhSfgRoPJTFyXKobvyhBwYLXvEWYEeVkMwXkJIAg3Gh5qX?=
 =?us-ascii?Q?Te66c4vguihvNzCjoYaISHvj0X6HC6nx2eSLtyMHngYeTuBkeItlG9j3QSMq?=
 =?us-ascii?Q?Fv8chctnbclZtK0Qnu2Axd1K+nD48PME1Ycw4Avtf/ZEjrFPGmPUvc5rf0OS?=
 =?us-ascii?Q?+l0hZWzn6IUdjtLDjP3CpDHuhXS8h8R+PDj39Gv+lmS5J7G/EL34MA9ha+Td?=
 =?us-ascii?Q?zBm4jLr1s2vHjjcJcHtoTcDve3kUuyiFR5W3BUnbVvcvTEdVqToCCJcuSjIr?=
 =?us-ascii?Q?sQvTttp3J3p7SC4dCTKNJIACJTAaqFD0q+xScdwnVdB/xTFIaecRaOLdf6J4?=
 =?us-ascii?Q?HAloyBNzyDGMymEO6VVelVVvumMUTynb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 13:13:54.7949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2556c69c-8163-451d-036a-08dcd71a9516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

Correct the parameter descriptor for the function
`dc_process_dmub_dpia_set_tps_notification` to match the actual
parameters used.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:5768: warning: Function parameter or struct member 'tps' not described in 'dc_process_dmub_dpia_set_tps_notification'
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:5768: warning: Excess function parameter 'ts' description in 'dc_process_dmub_dpia_set_tps_notification'

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index a1652130e4be..5c39390ecbd5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5760,7 +5760,7 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
  *
  * @dc: [in] dc structure
  * @link_index: [in] link index
- * @ts: [in] request tps
+ * @tps: [in] request tps
  *
  * Submits set_tps_notification command to dmub via inbox message
  */
-- 
2.34.1

