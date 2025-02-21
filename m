Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327B5C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0F610EAE1;
	Fri, 21 Feb 2025 16:02:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vTjBAZDy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026E310EADE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ki4xaf4XLTBjbvFvVzrEEW8/XowDJlZUPPxWcMG0vUmQFgOg4k7RLOZidrnQgAga4LkYoDgMXvh0oVPuyoJNTFoQvnoxHHx9jRtKnC89BSzU54AdW1UmQPpKy7IPYT4H1X9D4fpD6xOy2GvKCdMnue0kyfMs6Qb93o7V1A68j4w5Y04+SBwORfp/x+qtMKwpH8j/al+Ic07GvplBZjn2TlmRdM5VX/LPT53mAvmpZaup7sf+2Bdk9R2tpryGHzYXRfq4t+QagxoGfxSiv0c/43NXppCwS7EQ7O/jds7ggd9Q47Iu6wcC1uvDEYz/EbBJjYOrAXhFXjVjIyoo0ALjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXBm7yzLnCgc+iP2L0imksFP05d0nV4+zW7OGgJJUrA=;
 b=Tx/9eOmMayAvo5RaUdCpIlAfIhIlXhBHaX2c8lfz/eHtN/6vtxR7oqn0ote6Tmb10KPd2ZO7yI9wafXf16ix/hZZrVy2lizmNYte8J7oNKRcDg7TxlEdlyqQztRToCCfrzD1O0e+j8mloWQuYaaVtZDBePC95gnmgaRCv2uLOkcImJGIfWcZK6ab7+/Cf/W6tLHoRaZ9tXGhOGucgJmQj9RbHo5wXiJQhruEl413gx6FqYTTB2UzWMGuOZRdEqrcGgIcoNab/6NW8WZ8Uc+1x+w+x5k//TNKHZ4amPXchTBBGjRmvH3rycm9uLMGVFp+gwWjymHDmiDv86mpmEOErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXBm7yzLnCgc+iP2L0imksFP05d0nV4+zW7OGgJJUrA=;
 b=vTjBAZDyNW4RYaANUBU5bShI5dNIM+UgaKrfXeJncrByW5Agcg2Z6lJi9WX2QWsDkIRdkDGRVOMXV76RFLAT/ysiod8nYdt/2vltROFs4hO/bMaG/b930YlDnzGUckGjYHO10KC0xapbIJxgtD125b2ycQUHb4mtrMZpYS95Lb0=
Received: from PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::19)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 16:02:23 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::2f) by PH7P220CA0048.outlook.office365.com
 (2603:10b6:510:32b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 16:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:22 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:13 -0600
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
Date: Fri, 21 Feb 2025 11:01:31 -0500
Message-ID: <20250221160145.1730752-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: d083af46-6c9e-4351-6905-08dd52912091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ra+opXhIB/7zXsik0DOiASsF1u8+dTbMYWFZ21ofCZg20e2t5kxsfBVHvm6x?=
 =?us-ascii?Q?WsvhqnWKRiQAbS31YD9Jz0yyWNR0ajK9R9HdUIaJrU3HIPhIJnkezhXu2Pek?=
 =?us-ascii?Q?phd9tOa66K1ueJSPZJN7H+iIaRIKeiDc26d/az3eDuR+SzOoshILbMA0zl/M?=
 =?us-ascii?Q?H0kRHO2VNPwoilGY4T9DQeUL4QAtwo14Dbyi6nIwLjYGTXQBkIysv5jAknAU?=
 =?us-ascii?Q?xDifO7CAWKY9yUz+Vu+/ddbYK6KPaHGnvhU4lp+toAixOetuDYbb+3pyZRcd?=
 =?us-ascii?Q?Ld3WOqBQcNW5IEUWufaK/IM+CTsXjTTpukY4oSk3xmJ5ZdE4TWUK42B2RS/C?=
 =?us-ascii?Q?la6hWIHTzQ/t5v0vntm9hIn79QHRC3xV0d3+Bqo7jqkYVr4oS2uFG2DEfTKj?=
 =?us-ascii?Q?VsScxiSNkFdQ2GWt0mL95aKO/dtTnB2CG4PqOrhtI/7fYtGej4AqLdFCIu2p?=
 =?us-ascii?Q?ycWb9q/atHrZavtVErSUy8J72rDe8ixPev8s6r/fxhKMvj/DqZ9ozqwtE0Fb?=
 =?us-ascii?Q?bEOfk2FVA3VzfEjNa4Q2H6g4nfOQUKLR3PT6amsaHHXkpnNMKa313Nbnfzo+?=
 =?us-ascii?Q?Wjpquce5eoGsc/TUvpCN650Qc02AqZ4d5x2TcjnTCZnc8MuciwhQmYXSd9Fr?=
 =?us-ascii?Q?J3qmN2JQxWlJ8ID3uIdhnSqPKrzUId7hGHvtUgYHF+bU2dmLRFUumbTV5zCv?=
 =?us-ascii?Q?/7jTLhnlhmcQEMrb25cSb3V9fySsh/zKS0bcpzrpSYuq2arL/52b/OHy0av+?=
 =?us-ascii?Q?tOQ4SFmH8SMr44oPDJ+Tp+5QoaDa4b1eMvLhnXSwVKePXj1t81+GtK/O7yjH?=
 =?us-ascii?Q?v7gGx2fwMtheoOosdaEWjvm2/zTcCfM5DIBNjgiRMzYCchBB/pZVh5PtPrl2?=
 =?us-ascii?Q?CgWRneRFO+HGGkKm9l699XYpDOPgx1jJJXRVFYS44UoZRek9PrLc8DnQbcKa?=
 =?us-ascii?Q?nFdHG85QsGU6rUFCqmBbQWGsO2V8GUOG2DjeGv+kizUiDdGjrRB4VgMJMoRI?=
 =?us-ascii?Q?4wmQtvg/K4hXrUd7pj68PITGIaBZBsNGSaayDT5Y5q+DGSMGygggfg2xzU8z?=
 =?us-ascii?Q?0T4py06XBg3cCS/77z50KOK16XqsQB+u8m6n7bJ4jPFP6guNgiAPeVNnhpmc?=
 =?us-ascii?Q?ZUspXBKQcf4l0djnJnBlttljYgK4aiziCo41IJFaGui1u/WiXbz+XFCryKZx?=
 =?us-ascii?Q?dewhK7/mjNDg3w/V1nBxiN1E5FUPcBbcVzYReCtJmYBOWLJxG8jTY9SAwvUb?=
 =?us-ascii?Q?10Gm0iZ2Rbw+xLZz5Am8cILcPwjBDIZKgqpwzYw9JIMAEj+/q0XVWC8szem9?=
 =?us-ascii?Q?bHRFc6fy3mZMopfmzKIWbSg0i2LeJffWJrc6EJSzCEHvnOZNQd7ui5Y5E7iF?=
 =?us-ascii?Q?xFDJRYXyFwbGvo8RfPf1nv70bDTBnrWeApXtYVUpXxrPaLAR/17FvxQIjCgJ?=
 =?us-ascii?Q?VjF9vIi7TlsB76ThAj72b1rJ2EuZVJKbhVO2NUFVKEx0MnbBJz44L/FY2iss?=
 =?us-ascii?Q?ZfAfP9Gzp+sMZuI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:22.4895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d083af46-6c9e-4351-6905-08dd52912091
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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

