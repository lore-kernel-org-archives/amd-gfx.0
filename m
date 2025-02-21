Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78536C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FAE010EAD5;
	Fri, 21 Feb 2025 15:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxQFB76o";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F6B10EAD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7t12DZiyGkV2ZPuAAAc8P74sQcwFRprcVEgUR8H51h6D8pTpoMT+UDETEbR7xH2B689B5nxlyXNFA1xRLpyDFh4Tg/hUUaavqDNRU5D0HZtd4sCLlKJj+fvmn+sS5J2Iow3mP0BCpvISzwbpq5flvynUczHnS90NkvH0p1U8nCHdpyFafYBOVu7DwbGjgumgCn9c3BHho0xMZ6q5YDfricayMDuVhq/rg8xp3GpSSZZIfFvhwZgxo6G4FwC7+FJ6bD9PxbUYG11E6+a6OE8MEo4tw0MpXnwFVrWtkIN/vIqguEF1ytnEiemVv1t8S16/WSiuWClCPxq5Zr9RNjPoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXBm7yzLnCgc+iP2L0imksFP05d0nV4+zW7OGgJJUrA=;
 b=oY2MfCNJm3mW2xrwOWwZgO/BQOZzkM5xapINFAoi5JiHzdYFQevMGLZUOz+lT7+x604NprDlgNe+Qj5kwptvCYJ/V7tPrE/iQzLpN5Lxid5TmqHkGcWHM6MIwd+sAAaCH5AjbAOQVftU4AZEaznr5/Wk6T5vN41rLa8iC/z2Nj581s9mZqkql7vdVaIZkJ5YBXdDWtKuLzZjAN5zjk13KzYcBsEwZmFX8MsiqTl2Ua7OT2WXUd2vEpfGcy4R4Xw/dUWcsCFMLjsPk94ovGofXILZ45SubK2/u60aZuEV/4kGCK3GXRfgjEsNaEZ8WGlCAKUXVI8Lnh85AQmruc+ZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXBm7yzLnCgc+iP2L0imksFP05d0nV4+zW7OGgJJUrA=;
 b=zxQFB76oOm3nNYSRi65Lo5yDZvfQDQ7WTbG9WbWYu2j5OBEHSk9n+E+dnHk5HfqVeRFUQ/MPGA5C0kLypRpsADmMGHMPaFHopZ/sIDMaEU2TTj+gicadCYoEHf2lCMQMrm1N7sr2fnz9JMkPLVEZE7v89gihy78Uc6px88fQJ6s=
Received: from BN1PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:e1::33)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 15:58:00 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::95) by BN1PR12CA0028.outlook.office365.com
 (2603:10b6:408:e1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 15:57:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:57:59 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:57:57 -0600
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
Date: Fri, 21 Feb 2025 10:57:07 -0500
Message-ID: <20250221155721.1727682-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
References: <20250221155721.1727682-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d36ff0-06e1-40e5-75cd-08dd529083b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1SNc/ZQMHK+HLgOG54eb1M4+YCR6Uls4QTM2xwcOl7VfcmOXcPVgliwTrmPz?=
 =?us-ascii?Q?drU0G1HF0SCFsuwSa+mkSNdCKB8MpiDOstOnnBmnob6TiOhynJRGqeT/seQG?=
 =?us-ascii?Q?zjxSsUOBS4GEQS6h1kMR6L8wneq7m/gPcLOLzUBlWI/X6XwCM9/3HjvXKoJL?=
 =?us-ascii?Q?bRiJ/v0buPLGc1OzbSmm07M8xDhMh3xd13W8MN+nG2B5+v87ptp5YnMdUNP9?=
 =?us-ascii?Q?CboCscEwwsn7cURBiREGk5StCMVG5UzuJ3dG/Z9eWVA9DitL+inCqZ1bmr61?=
 =?us-ascii?Q?Kb+/c1zSM7lyH2hjRNvPY895xM68KreTJ5bT9M6CRfN/m9LI/q2n3SiEvXoH?=
 =?us-ascii?Q?JhGUOZynyWZVzHCXcZipfY0ad+TikXS1SfkRzII4tuxWItxBCS6BUN9NHmxc?=
 =?us-ascii?Q?Q02Jx7j5LCFgk1yA1D0ApQWBsYAtJ98VqlNvrPZh4Du1KLhj0AQRV+NDyD7w?=
 =?us-ascii?Q?YR4aBrINuRmriYZ0mobLDqv/TzzAsaAFfzldhYzqFGfd2qGmX8eOiRkQ8awi?=
 =?us-ascii?Q?vfDvlbEnPmf6wliKW7PMX/eherW5ekv/HEVuXH1V+wJsHuKNleMaomLwAg1j?=
 =?us-ascii?Q?jHgocjhDcZDiWN5etzprNBmnjlb/RDzfaCLBDGcVz5XOnfUzaKsDhQXBCXah?=
 =?us-ascii?Q?FKfHHF/DIL5YCoJkU7XfZDiNc49SoadOG/Pke+BWIpjP1Hu1mAmtPLd0pAP0?=
 =?us-ascii?Q?n24dsDrxNV9dktzBQF/YEALtZG+j7CP+ntusTApzSVO8Fy5TwQ0O81mkVzA2?=
 =?us-ascii?Q?V9RS2sJyEeFNQ7dssqhjFyBn5/DQfRPhZNaY3xw4tRyrIQ+YGPz1AeIZ2Ode?=
 =?us-ascii?Q?gBS5JOPuS5+IuJn6d5ugWb+wcfIibMHEXl2uMGyebrGFjta59NpmpFiGIskS?=
 =?us-ascii?Q?vkt+9hekTljtgzeNRvYsf53OYQ/aTMz5hER8QlkagXHRa4PzzoK/kG5GGU7K?=
 =?us-ascii?Q?JGcouCYDPsDu4VgKgsp9fzar+kF248MNZAErb420BGvNTcHcquL3sy22LGvb?=
 =?us-ascii?Q?QzJwLZ7GkMqv+bAEWVAHzDtapUc+iWEH4ClxGOwzjc8QpbPtW/mQDq5QZACm?=
 =?us-ascii?Q?dJoTVP9+htEWpDIWKlrtnWMaAUG6/kND03a95jEJWFZRPZcMoIzIjRitQEJ2?=
 =?us-ascii?Q?KFikhhNmS8rs0n7nKOseIFjLwhICMGE8kyzoUBgoTetYxY7oJH7X63EJLKiV?=
 =?us-ascii?Q?ULgCIsrI3rAu+VFAAbPNBEfz5mSC/HR4XjqxEZ5hKUp/Aqylq8spGl7a7Nme?=
 =?us-ascii?Q?XIPutMzPVL+b6YC3MLyrxIO/EMa1MfKRJ0fig+1tQgJcGhPjNc/h8ndZ6oBf?=
 =?us-ascii?Q?An7LBEAEANagTWV4WiezpnNVrr9fqUxU6dBO+xbfZNfN8ueFpghukefPI04C?=
 =?us-ascii?Q?R1vsn1Tj8ywzhPiBsP0FRI0plVAHt7BeAxhOWN+FM4WqQYPv16MFn7kj8OJf?=
 =?us-ascii?Q?pXre3iP2qE41PzwKj6wyFHvvnJKrEzzUVmHTiAJFqdmQeP6lzs9v9At4mmEY?=
 =?us-ascii?Q?EgJewT2db4InL7Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:57:59.4238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d36ff0-06e1-40e5-75cd-08dd529083b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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

