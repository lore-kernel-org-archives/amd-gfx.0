Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74ADC3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C50E10E8B3;
	Thu, 25 Jul 2024 18:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MfabzgL+";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1C010E8B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+uyD/M9neJO64qjkKXULyz8c/tBWDBwziL9NxehnmU6j9/l9F4Z1Zmy8i/RzA7iT5GqRODh1WDP+gk2fYO4Y+TkrzH9TFhAXQ0O6e53uuFypBGnv70gFL8DBFXFTCdbx7fFP/nb+cXNGgWWbQ4dLGbGk8X5Rb5iOZr6kefFsO2OML95GC+aRIECN4iyGcjEu7zBxaiNp69Ubpej6OzZ1wIKGjNU714FiGyujwLHJEu9y8DFBH8Nq1y+gGnCdnmBhr6etilfFSSfUpriR8rjx3Az8ckPds5IyeDRJeabGEzNmeNa4spaLRnhFkE7DqDamRCQGqEsRuB1wshuizXnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XES76tj121BpD2NNT44rgl4zk0ngT6nxjnCPS8QWDlM=;
 b=ohHdg3l8vDJ/xCyuZA2q4JTynhY38eVS81J/q345WWsT+pNf4okGv2XhX3beRDNHuHnWsNfKxSrFg4LyvKoowK9/yG/mWLaiHB7cW3UVkF2odC16A2VbIOiV8HZ2Zf7sXIPk3FBznxyTFT7+5EJXYhB6Q12Ejy4o+60uPKaMGMi5maLeD8PjO9iVmqF0llJmYO2t3KMYR2dRC0GXrYfBeyTgYwbhdmV/itzWlDahJsWfu6AXBgZTTJAhZE6F50uBN7+Y5pS8C8DYxjgO/5Ry3DxTCUiyfSpCRhSQUpsAq9X2osYWtXQGfpKDkG/Bz8CF6enNdk/tEhyD7rE+rwj/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XES76tj121BpD2NNT44rgl4zk0ngT6nxjnCPS8QWDlM=;
 b=MfabzgL+N7Tptjjaf1Ju6R1PBc+X2Nc6mzV1S+Wwg2MOn74LLUwmkRtTO0UaNmvprzzCcqMomDWFvdarRXJ5k+gZV5l7SUuOo0AoMm6qAR7DzfAlHTUFcZMK6YHxvsHKfmjtlvL1bWPM6Sv3SHBY7/mXlNAF6aAKDODmJAJj/mQ=
Received: from CH0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:610:119::21)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 18:04:25 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::67) by CH0PR03CA0387.outlook.office365.com
 (2603:10b6:610:119::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19 via Frontend
 Transport; Thu, 25 Jul 2024 18:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:04:25 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:04:22 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 28/39] drm/amd/display: Re-order enum in a header file
Date: Thu, 25 Jul 2024 12:01:12 -0600
Message-ID: <20240725180309.105968-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f44ea5-d80c-4ccf-2a11-08dcacd43812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wFTbkbN52amWKWRZfjZqCFVhTREQ2SE1+PgnmN1n80Opz7baU/RxW9R1fkEz?=
 =?us-ascii?Q?AtthGxZqKG6+PM+/jrD93WULK84s0cMz9UkrONSSbS3fwUTpBm7rPGigSTaq?=
 =?us-ascii?Q?3oi50hXRss7KyEMUBiy36va5luCe+3AcAhQuVKrK/qyU9YM/9kmt1GDRp6Ux?=
 =?us-ascii?Q?nj5rr7ocAVVQ8z4drnA+5n7zMjt0Wchsw18a8pW8PvHVe9nS67PstAKo1krl?=
 =?us-ascii?Q?hYrDoKkQ0pnKTR7l6PdVPllt9SWUa4i9Dc2TqIH8wuGYNxfZE61/ndD6rWQA?=
 =?us-ascii?Q?1OyewuyELQWmO2RW5xnrp/LOOe7cJf2N1smsHVfV15dnRMelf1lQEZSiyHRz?=
 =?us-ascii?Q?xV0gtsg1savxhV5B2tKa19dc2Fywq3FiQ7NqS//LpVrAAntcgLT9uwM+WqmH?=
 =?us-ascii?Q?Hs8WCOrfjsB9SS1785Pr0pSAengPsUfu8BEMKKUjiSNe0LAZwQo16yv0lpLy?=
 =?us-ascii?Q?VH1OqqU/eNCwauFJq0jzSO1KCNgF2nt9gTF+7d/YaHzw7S/8Og0JVKjbDD3i?=
 =?us-ascii?Q?TNYj10kYJlvPQJ5VnZTxay0X4BUpAOegeYEsqdN2j+IJVXCn7rZo7gQvALPD?=
 =?us-ascii?Q?jHx7rjIi78zM/WtBjqhQTmHCEHwEKSzS8noACX+cj4Hzee9jKY6FAzATIYYr?=
 =?us-ascii?Q?09L1+/bWUdeu/gNd3/BUectGbdSrskz+1J2xTrMVDLlEmbwgEVd6FgKN0T7c?=
 =?us-ascii?Q?GibvzxA4jHl7EQXQfvLqg67RfYy7e7+l6e5ALBVgSVL6P9Z5eUzmp8RJPcQp?=
 =?us-ascii?Q?JQFI9+8PQ8h9d+OPvvBs+Gy1T3V+h1oUs+VwtugoPYjOQd7BaJlFabjR6bIZ?=
 =?us-ascii?Q?Z1xABFukXx7r5W6opoCBCQ41NJwGEpb9af7oTARojEKc00QSh1DweUlvBmO1?=
 =?us-ascii?Q?aCck4XIZTwYtGbyORw1MS0yCpOkweMR3iVUkEMyhzkMUyWxeRHwZgTaPYONE?=
 =?us-ascii?Q?K8lIYMRUZZ7HuywFvvZYKpXg8RnQkaAC1XEFBeN+1Jyn1eQVFB0Y3WvJ1jMG?=
 =?us-ascii?Q?hN/Oc3KLI85kT0PQ4tsCmDR3TW/aZQr1h0i2PT3ek9cVBOO+EIgKGEzPzcDQ?=
 =?us-ascii?Q?bjt0ql7cN6q1BONbPwavYnq6Atw42tmdJlQiI63HWB3crgWtp/ykwkRU25y7?=
 =?us-ascii?Q?jR8aRCwsEpUsdgEVcWhmmhua9quOhmJc3YX2t4fa8O/e3vlBdLwKlMmhsCV0?=
 =?us-ascii?Q?Nv54jPcIxy7eQYMn5bmBvYgAvaA3CbN/4icXLrurMDSOwFxdb3Jcnf96xbZV?=
 =?us-ascii?Q?4laWGj0hKWCm7yJRxQngMgsmUc2OGoReNDRCIx+alGjDho6QyWSc8JvmI8sj?=
 =?us-ascii?Q?bD6zrdnu0y45FupkaqKRuyX5TDJuMJv4ZhzVmqtcVjkmcZFQRbdu+94t0qJ0?=
 =?us-ascii?Q?o4y4CUjVuIo+0JlyIVby3tygRujClZDuGsr2l1R4KsWn4kds+jiztvvooIz3?=
 =?us-ascii?Q?wwGrzz2CuBj3uArsBZSU7K6fGnwg6I4f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:04:25.1182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f44ea5-d80c-4ccf-2a11-08dcacd43812
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
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

Move the lb_memory_config close to the pixel format enums to improve the
code readability.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
index caaa9ced2ec4..36d10b0f2eed 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl_types.h
@@ -10,22 +10,6 @@
 #ifndef __DC_SPL_TYPES_H__
 #define __DC_SPL_TYPES_H__
 
-enum lb_memory_config {
-	/* Enable all 3 pieces of memory */
-	LB_MEMORY_CONFIG_0 = 0,
-
-	/* Enable only the first piece of memory */
-	LB_MEMORY_CONFIG_1 = 1,
-
-	/* Enable only the second piece of memory */
-	LB_MEMORY_CONFIG_2 = 2,
-
-	/* Only applicable in 4:2:0 mode, enable all 3 pieces of memory and the
-	 * last piece of chroma memory used for the luma storage
-	 */
-	LB_MEMORY_CONFIG_3 = 3
-};
-
 struct spl_size {
 	uint32_t width;
 	uint32_t height;
@@ -87,6 +71,22 @@ enum spl_pixel_format {
 	SPL_PIXEL_FORMAT_UNKNOWN
 };
 
+enum lb_memory_config {
+	/* Enable all 3 pieces of memory */
+	LB_MEMORY_CONFIG_0 = 0,
+
+	/* Enable only the first piece of memory */
+	LB_MEMORY_CONFIG_1 = 1,
+
+	/* Enable only the second piece of memory */
+	LB_MEMORY_CONFIG_2 = 2,
+
+	/* Only applicable in 4:2:0 mode, enable all 3 pieces of memory and the
+	 * last piece of chroma memory used for the luma storage
+	 */
+	LB_MEMORY_CONFIG_3 = 3
+};
+
 /* Rotation angle */
 enum spl_rotation_angle {
 	SPL_ROTATION_ANGLE_0 = 0,
-- 
2.43.0

