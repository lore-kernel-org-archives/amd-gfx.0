Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEEBC021B7
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199CD10EABE;
	Fri, 21 Feb 2025 15:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Szi9/SdF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C23C110EAB8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdv8SGqMa53aGmMrFQ8Iaf316SnAcVRDKgCWr3glRtoXuQ4XU7NiUoxZamya4UxCL2jNLuHlVTjsZnLeQxtwOzTtlGzYfUpVSG3OclJ5Zgw8EiUxH/U9m85u9Vr4HKgRn1b2An5fb8scK5wCxzTCRAjuESqu/VgCl5AiCW+yE6PtdJIwTJL2r6PzgWJPQQweju8BkTLHSNTPD04LwpJ4CsIUiGaQYyLkl54N5R7ynxTiRkU/VOneynB4XLtlOS0DibcCQvNisfTD1t8kJShAc+eQR4VfeSIm5kdq3PULDV80qP+jUHh3O5Yjs2EgiQB01vV/gsC/WMtDPobzR/gj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXBm7yzLnCgc+iP2L0imksFP05d0nV4+zW7OGgJJUrA=;
 b=vZ3NyFQxDJUaXbmKu5SiM6CnvnlgUWunToV0I8P+521CSIUBjvsWL4qqCOQNnJLGBCIVSSFHyGJV7gLOq5qcdix+OqpI/4MGUVGhFxI2SHjIpceuEbosKfMXFybUqN8d63n225ftNCe7y9SLgCduEq50HT4O1xh2EvK5p29sObp3WIdelCvCwHtGcflrOwDpCMCL+g0pVlbdA0vdb7ayBs/PtuwpnxTpQxejRbwjgzVo359pGQt2edJI1itl7os2lBylDg8VntO3S+DztRzKoH9zy3mKd1qqXh/PT0Roxdt0xR/rRT5ygU+yCwY7uzgb/8cEDlBPCSECSGWd1dYDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXBm7yzLnCgc+iP2L0imksFP05d0nV4+zW7OGgJJUrA=;
 b=Szi9/SdFszLDvM15oT6gNn07c2P2RMVAdvNMacuA3ZAWXq3vZEUWcrpKSA+Y9wX4O9hugbm8hZknutxtlFgYR5TCaJB7L55Y8eL/7/4ruf9Aj8eM5o4g4mXjzcSngFAwx2pFycfnts3Wzqp0hNDJ6cN56z1lTZvVx5VzJQ/OLwA=
Received: from MW4PR04CA0114.namprd04.prod.outlook.com (2603:10b6:303:83::29)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:43:51 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::2c) by MW4PR04CA0114.outlook.office365.com
 (2603:10b6:303:83::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:43:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:51 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:46 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Navid Assadian <Navid.Assadian@amd.com>, Samson Tam
 <Samson.Tam@amd.com>
Subject: [PATCH 10/24] drm/amd/display: Add SPL namespace
Date: Fri, 21 Feb 2025 10:42:58 -0500
Message-ID: <20250221154312.1720736-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: e8047db0-7ce7-4738-82d1-08dd528e8a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6wdqSKi/SZlqCvNgUHnA3pqhR57++J4DrGZz80tvWgjvdmnrfrqD2vqQUfWw?=
 =?us-ascii?Q?fa8U9ncbTpsSs6OOD2b27FaGqYXv7oO+iaUFGPega187avnpCHN8whKJhBAo?=
 =?us-ascii?Q?/WqZkrkpYBErr5IJqWef/MTg1N2uP4yUYr/8RysEKMWdQjikG1VhUhPbxXuT?=
 =?us-ascii?Q?oHF8yWoDVw4uJoBfJw9rEIjXVQuTAij2+67f8lLeunlmBjhNWUcf3MgJPq9E?=
 =?us-ascii?Q?6gl5HjrB4mQmJuhFiNnqfqYpj2236FTvc0OgOXbiEG3DmW4kGDwbVqtNLMQT?=
 =?us-ascii?Q?us3mvSmz0WV4/Mc8mBnonte+6R7O+BjcKGNKMkUSXNV3oCQE0tBNWisPbdCh?=
 =?us-ascii?Q?vF/CgNZgOpUNinobu9IaorxVvRColGyiu7lyKEsefF/WeNrOOOTC9QwAK4T/?=
 =?us-ascii?Q?7W1779uUIfcEQ6Z8Bb55SaSCb14MObNoYqMwjEu252FQYB935sQGBy8L2bfa?=
 =?us-ascii?Q?MIF5RTjqPALbjC7BRwhgGcVBIRThTx2bLT7NlNChHBjppwud3hwy4zOG3a8e?=
 =?us-ascii?Q?B9xfRP/0woVuJCotrZDk6gUFMmFzQ43+D3GmhZr2m1N1bHxi+IL12dK7UomQ?=
 =?us-ascii?Q?G2UFbbzdVxmLbyIkoeraL0h0TaP5qPZykZLNQg47nJwktCVC8CgjiG99Ia4m?=
 =?us-ascii?Q?HIMUiCrc+XLB1eK1ZDzaRkCb/6Y3Nt5i6MtArP4T9WhM+RMbA91nSCWATTfC?=
 =?us-ascii?Q?2eN/V+cLslksmKP5dgt1yuzRu7y697eu7hHGJIc+qbkIyGiwDraIv2hhk4Xk?=
 =?us-ascii?Q?0yVDbVN2Lnec+AOHDdot5sYm8+VvRIOIdIXEf8j9XVJRSI32/l5QYiXoieTq?=
 =?us-ascii?Q?m2Ys6OqHOyf3y7e6of5kJfwOrSz7mXUdn7jcqIkoPItLZ1Qv4ktVpfUzooMI?=
 =?us-ascii?Q?aVNbjDjQwOr5Td/rJmt9JqDk8YjmMLxuE+BbDVkUyuWX5zFnWxbIrUeRcG+1?=
 =?us-ascii?Q?3V3fXxXqjy3RZ9EpWMgMYmYIQd3yoywlBEB9hFSFW2rgcZqaYi9j1qBb06y3?=
 =?us-ascii?Q?JrnO2Z0I951x6Nat9f7tUnenW++orEKEvgP+fn72lWeHtLe7W4HKqyg3bh+B?=
 =?us-ascii?Q?67z7/zaY0EHle7evWCIPSAYSwwJCmZwLuxf/2BsuxnyrOIya878rWc4cf+XV?=
 =?us-ascii?Q?8FRSeqtKwa7kptxRizmqY08ehQasWAyBoie8bM2b0J5sxlSwR9pB/hfEZfxr?=
 =?us-ascii?Q?9LwZE2uUqxI+nQcF1YGejAvvLqW0fuRskJReEMlLFF3CsT/HG5elO+JLidG1?=
 =?us-ascii?Q?CnU35G7s08Xg9EnEwVX9IsO4Z9Oolc8nQhkRFsknTLvkofXqZGGZSaeV5CwX?=
 =?us-ascii?Q?K0tYEdba3SIlNOdj/5R9u64Arv7G+u37ovm3ENzdX571mytut6wyTIwyy1y7?=
 =?us-ascii?Q?wNAifiVKUja1AERUR3g+g7yPYawemgQH+s4WuPayksBL8KW1IvjoRx+yLhKT?=
 =?us-ascii?Q?sWJZs6nomVNdY1tHjmLd/vF1/KS4KpC96gL5/Op7hZpkH+RZ4qlXHHFVzyOr?=
 =?us-ascii?Q?iKg0GjzGIQpTass=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:51.2643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8047db0-7ce7-4738-82d1-08dd528e8a37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722
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

From: Navid Assadian <Navid.Assadian@amd.com>

[Why]
In order to avoid component conflicts, spl namespace is needed.

[How]
Adding SPL namespace to the public API os that each user of SPL can have
their own namespace.

Signed-off-by: Navid Assadian <Navid.Assadian@amd.com>
Reviewed-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c |  4 ++--
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index ad77cef57ac7..8d80bce0738a 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -1819,7 +1819,7 @@ static bool spl_calculate_number_of_taps(struct spl_in *spl_in, struct spl_scrat
 }
 
 /* Calculate scaler parameters */
-bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
+bool SPL_NAMESPACE(spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out))
 {
 	bool res = false;
 	bool enable_easf_v = false;
@@ -1884,7 +1884,7 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 }
 
 /* External interface to get number of taps only */
-bool spl_get_number_of_taps(struct spl_in *spl_in, struct spl_out *spl_out)
+bool SPL_NAMESPACE(spl_get_number_of_taps(struct spl_in *spl_in, struct spl_out *spl_out))
 {
 	bool res = false;
 	bool enable_easf_v = false;
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
index 02a2d6725ed5..145961803a92 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
@@ -9,10 +9,22 @@
 #define BLACK_OFFSET_RGB_Y 0x0
 #define BLACK_OFFSET_CBCR  0x8000
 
+#ifndef SPL_PFX_
+#define SPL_PFX_
+#endif
+
+#define SPL_EXPAND2(a, b)         a##b
+#define SPL_EXPAND(a, b)          SPL_EXPAND2(a, b)
+#define SPL_NAMESPACE(symbol)     SPL_EXPAND(SPL_PFX_, symbol)
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 /* SPL interfaces */
 
-bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out);
+bool SPL_NAMESPACE(spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out));
 
-bool spl_get_number_of_taps(struct spl_in *spl_in, struct spl_out *spl_out);
+bool SPL_NAMESPACE(spl_get_number_of_taps(struct spl_in *spl_in, struct spl_out *spl_out));
 
 #endif /* __DC_SPL_H__ */
-- 
2.34.1

