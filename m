Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B556AC3DA62
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jul 2024 02:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6003F10E550;
	Tue, 16 Jul 2024 02:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BYPkdsUZ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84C1F10E544
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jul 2024 02:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO1l/Ts2mD8i2AxmMyHW660kLCbqdVJfjIkGjeDWEGzzmNu+xISWljaqH/qV6QFmgSW7tQKFXpwoLwh+fLSE+pG+rWc7iTMpZ1BYPePb+FqrlQy9T44GsYMs+uoq7Pd9UwEOC8BQHUL/cl1FS0AgdV1QcUP9TppRXQXR4PXaBQc9Fzu+DAaiA7P9HUaBxHT+Xx3KwVHXyzjHiIsc4nbDcXGElockZzL2MzS5vembMomvyKP5ddbV/EfB4h4D+oPGFCsapK84+ifdC8S/IQUQ+bPEkD9lrxjgD3WshSFRR1vyLhkfUirGPK6A71/gAn59Bjxm8fOrMtYELgbxNRwrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMq/ufOOv9xGH4R3goMWZSbXMl2r9zpIGuRj6dwAwjk=;
 b=IvSFx/X9PMUpCX2Q/2xOK8k3IVovfSRHLDsCPCK/Bs/mS5zvoNwMrPrXAfMSb7Zo4ElJmF/v+/5N3SL1M08auaUu78TrxIl//MUDf101PgyrL36GEirZ4bJ+09GJHw1Gzqxwu1lmI+jiNpWC0N36viq9Btq0V/ZX3nKmYUHGxpmtTnejYWfAMbhH5LoHE/dONbf0+Ik2DKQj29kDtankYMS2SOrOwvWuC3q/gUXFcr/TcRW9WzHKtJRI4KL2m2mFcPlacHNxDTurAtxsMKg3OiWVyXpUL27bIe201nupoOqXl1s+Clhz9P3MVerfPQ+F9Vuy8SrN2jU/j6wia+U/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMq/ufOOv9xGH4R3goMWZSbXMl2r9zpIGuRj6dwAwjk=;
 b=BYPkdsUZJOcStcxG6tDABF07mQbxAfz22lB/D1n9IYVm/lfbD1GtP4/dhvMFu2fBEPAvNC6wHkFl9zyKAWvP+TJkmjNxW1IUMMfll6prVVF/xAtZ9wdS2NBKm9XJNbfMWUNMYDtyElHZnZJvbWbjfXQar76TtmopLIrddbymBxg=
Received: from BN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:408:ee::16)
 by DM4PR12MB6183.namprd12.prod.outlook.com (2603:10b6:8:a7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 02:31:54 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::bc) by BN0PR04CA0011.outlook.office365.com
 (2603:10b6:408:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 02:31:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Tue, 16 Jul 2024 02:31:54 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 21:31:52 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <Roman.Li@amd.com>, 
 <Alex.Hung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 4/6] drm/amd/display: Add simple struct doc to remove doc
 build warning
Date: Mon, 15 Jul 2024 20:27:26 -0600
Message-ID: <20240716023022.100811-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
References: <20240716023022.100811-3-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|DM4PR12MB6183:EE_
X-MS-Office365-Filtering-Correlation-Id: d173cc02-1c2b-4365-eb2c-08dca53f74d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JwEt+l7OgDzI2te2vIvREgu56dA9dLLhFzUWOSQYTc4jScvDh88OyNi25KAp?=
 =?us-ascii?Q?SsPrXluJFi/9LriYBStADKoY9nmjbWcVHu4P/OGVixTycaIhoeF/YKi1Gqju?=
 =?us-ascii?Q?iYy7ypsncD3JZVdJv5AnRvL8nvZnjrhRGxYSGzXMs+Be9FKT0A4JhbrquhH4?=
 =?us-ascii?Q?eFgBs1ju16BrMvQlhI68TZxmkfnZmvvuoZUe+2XZkpSWa72ADmt7COeNATuc?=
 =?us-ascii?Q?628O1PYUgG8MznsqAPPVmWdHtOkYcv4g3vHy4QHL53bO6rS+SQi5ejvoUDJV?=
 =?us-ascii?Q?vF54k3RcAhYyDq6MZD9vIA53oo0kABo/3LrOCs0X2VOOnEIlcnzdOnHBltNZ?=
 =?us-ascii?Q?lwRJdfD15+6C0I0wmF53boQw0Ww8Ga0l3DiNW8R599A/deJRuW33k51Jtorz?=
 =?us-ascii?Q?9VXN9R5n3/Wo8jutHpQSI7NiokR62Yh8VCnT6zcCLy4w5icT66+kLt5GyKGk?=
 =?us-ascii?Q?DT8AO5BmBV3wkfaJDi0mUvqKUrgH3mVa8goae/qZ34a7UHizCdFRkq6EvviQ?=
 =?us-ascii?Q?8Z7i43vNRv/g9+jikspYT6Yc2QJDks2eWWeyXoorby4KRd8I4NImKIKUdeJ+?=
 =?us-ascii?Q?482s6Bb3h+5RNHUdNLysXH8c8AzUhJyJiLAHTmz+sJgbnppBebg2KlKTS5Y+?=
 =?us-ascii?Q?/YssbRkeult8wt438xRJSQdmDDpxPmZOn8oPExpE3ndwQgqP1ES1GoBUKlCu?=
 =?us-ascii?Q?pXSkVCMnSAKYGgABJp+zc4de3W4WVPPL52ZdQo9dbjIaHfjkHZNiUOKKD3uu?=
 =?us-ascii?Q?0CjglDbqqS4aojYP1yVWe5yQ+zrhsdZEgSQsDgIRjHDJpYMWnrj2Bjiiz2ug?=
 =?us-ascii?Q?Mt3fXcMhjQ+7xN8nNE6RocV62al9oQCJdJ5Zmb2a33C1JK+/Qfv7Yu8DENwF?=
 =?us-ascii?Q?6vkR3YX6KUk8WZXrjCGoNK7mcs/Wuazw6t19TT3uOVv+crJwzR4migaUnqqc?=
 =?us-ascii?Q?dBb3Q+sG8gLIzCVqQQreFUZG24dnjUZ1nuqRrK9A1WZBR2iiQILN5YIq5Gzj?=
 =?us-ascii?Q?ha446mR8/0FLl9ZTJdra21IUNGOLlbwleCKj0whwajlZPjHFEUTqyI1Z8Cua?=
 =?us-ascii?Q?F+taHTtxX/gi4LmHx02Ilj59DBJva260dpWv8okMhqpQl5FT5qzwWn84cIvH?=
 =?us-ascii?Q?IuyYtH4WXl7TPEpAAmNO+WZSX+dOgRrjVVJKAkaTOEPDTy2Zkc17eFt3yj/O?=
 =?us-ascii?Q?mPGFty/CAv2BhBCINBMjxnFjttgLKuW7qWYyv9swZ22LlfP0XD+vrUTKFdGi?=
 =?us-ascii?Q?XhHE4khqJCd/LzO6ed8R1iwga4tjvv3npsqOSsfNrJn3jbNpHbVSW5QlPBg/?=
 =?us-ascii?Q?p2fDZXK+kcew4QdJLZhZce8swgooP+75nmJTh5iOgMXehV9Y7XKqP/o0H2O7?=
 =?us-ascii?Q?rHINsp3Q2Ik1553pf+dx7UftUAzH2RLp0Tmh5ZwrQJ26QetHFvX0642iycLT?=
 =?us-ascii?Q?boFFe0rA9uc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 02:31:54.0710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d173cc02-1c2b-4365-eb2c-08dca53f74d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6183
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

This commit is a part of a series that addresses the following build
warning for opp:

./drivers/gpu/drm/amd/display/dc/inc/hw/opp.h:1: warning: no structured
comments found
./drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h:1: warning: no structured
comments found

This commit fixes this issue by adding a simple kernel-doc to a struct
in the opp.h and the dpp.h files.

Cc: Alex Deucher <alexander.deucher@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h | 22 ++++++++++++++++-----
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h | 15 ++++++++++++++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
index 9ac7fc717a92..0150f2581ee4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h
@@ -147,16 +147,28 @@ struct cnv_color_keyer_params {
 	int color_keyer_blue_high;
 };
 
-/* new for dcn2: set the 8bit alpha values based on the 2 bit alpha
- *ALPHA_2BIT_LUT. ALPHA_2BIT_LUT0   default: 0b00000000
- *ALPHA_2BIT_LUT. ALPHA_2BIT_LUT1   default: 0b01010101
- *ALPHA_2BIT_LUT. ALPHA_2BIT_LUT2   default: 0b10101010
- *ALPHA_2BIT_LUT. ALPHA_2BIT_LUT3   default: 0b11111111
+/**
+ * struct cnv_alpha_2bit_lut - Set the 8bit alpha values based on the 2 bit alpha
  */
 struct cnv_alpha_2bit_lut {
+	/**
+	* @lut0: ALPHA_2BIT_LUT. ALPHA_2BIT_LUT0. Default: 0b00000000
+	*/
 	int lut0;
+
+	/**
+	 * @lut1: ALPHA_2BIT_LUT. ALPHA_2BIT_LUT1. Default: 0b01010101
+	 */
 	int lut1;
+
+	/**
+	 * @lut2: ALPHA_2BIT_LUT. ALPHA_2BIT_LUT2. Default: 0b10101010
+	 */
 	int lut2;
+
+	/**
+	 * @lut3: ALPHA_2BIT_LUT. ALPHA_2BIT_LUT3. Default: 0b11111111
+	 */
 	int lut3;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index 127fb1a51654..747679cb4944 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -205,9 +205,24 @@ struct gamma_coefficients {
 	struct fixed31_32 user_brightness;
 };
 
+/**
+ * struct pwl_float_data - Fixed point RGB color
+ */
 struct pwl_float_data {
+	/**
+	 * @r: Component Red.
+	 */
 	struct fixed31_32 r;
+
+	/**
+	 * @g: Component Green.
+	 */
+
 	struct fixed31_32 g;
+
+	/**
+	 * @b: Component Blue.
+	 */
 	struct fixed31_32 b;
 };
 
-- 
2.43.0

