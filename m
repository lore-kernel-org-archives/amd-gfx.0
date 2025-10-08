Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD68CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 19:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012B410E8D4;
	Wed,  8 Oct 2025 19:12:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MMCnZQlo";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41FED10E8D4
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 19:12:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpsC0VsO/6r0MXP7QzwBwCRDF96dhxnT7JMY0BwBsNO1pkYM2SOZPyNiiSX2ad6UPPQhJkVJLcYggpb75dXYv3pcd2UF04PD/RMlPFZo/78XP17OAUWYB5QRPBKdvLyiA+Hx5a+oUC4+PyVWNTwISNIs8PB63Ja7yyLGv8CaU4aHfFjhV7ysTRrR0qW3YHwHzTvVdziMMU55Gkx4qk6lNZn7LBS4ENGxKfSpynhmRbdfvfMGNeI8Ia5D15I8puNTx9TbIAH80ghOtY/I6AuSY37QpUdzsNv59gNAjCpDrovf9RVV/csvC5PWBkEsuf2tVTbuPQXRnMQ/KBOpBWLJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0jsKnBFQZKvJcK+hux6i5UOt3VDTVyid1cnbOdk9Ss=;
 b=T4O3ld/ODSP/XLLhsHPl+oWAQ1Ba6lcUkBW9vF5gRFavZKcnHkEuzVz11YaCjgA+ZUDgKBCMax55qiZTgHyjIh3BUd6QUgo9rVn3BQUr1WN68RtkcEAdUN84K0v10U09KzBcx7Hr6wH2DUnHIb0/sV1yVcrAjZ2svtBHQqSz72h9W2AIR4tuZo4+aOlX4I5OisSirnqg5IpTIyfsNS2TCo2gedgCHBnjy1yvPDxI/sKrFFCfYy2PWqwANPoBxB0EM5IFVrHFJD2v7gveyNh02cUg506poCciySzcPi01nHE9eJzpFppikyan2ZdUHeNGMekVbt8K42B+OLzP3M4doQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0jsKnBFQZKvJcK+hux6i5UOt3VDTVyid1cnbOdk9Ss=;
 b=MMCnZQloS+LC+8onCPTaqmleSigUKDQp5/07Q5yYtJ/kRbCdcK2Sg4anaZyYMfxjPbPt/EruxcvnZyV3a+W9vky1U+eS0FsInaOSn0C72rmKmJLmZCXfsZgTHd4uvGSW2MnGUTYCkqxzRT0rG1DNcsrYJoRH0aeLVke9jyyPQmY=
Received: from BN0PR08CA0014.namprd08.prod.outlook.com (2603:10b6:408:142::23)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 8 Oct
 2025 19:12:32 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:142:cafe::24) by BN0PR08CA0014.outlook.office365.com
 (2603:10b6:408:142::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.19 via Frontend Transport; Wed,
 8 Oct 2025 19:12:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.3 via Frontend Transport; Wed, 8 Oct 2025 19:12:30 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 8 Oct 2025 12:12:14 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Robert Beckett <bob.beckett@collabora.com>
Subject: [PATCH v4 3/6] drm/amd: Remove second call to set_power_limit()
Date: Wed, 8 Oct 2025 14:11:50 -0500
Message-ID: <20251008191153.3145554-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008191153.3145554-1-mario.limonciello@amd.com>
References: <20251008191153.3145554-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 779a3561-0bbc-4ccb-4898-08de069ea0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iiAoaHkh/3HT+qZLxK3PNBWIr4v2gyQUcltTq3e9TvQYoMcats93ugQKmA5B?=
 =?us-ascii?Q?vbMEK/L5iuoGAEdofX/D60kVtCxq7B4GzPKunE59ItuVdRcPqPsA2DC/aOsn?=
 =?us-ascii?Q?OnskvDspJ6YcctxUe5yYrMlB+7FW/r1BiQi02GwpSgdwZi5HlDV8CDk1IMWT?=
 =?us-ascii?Q?WPiglISL/gnKo2lOZxykJqahb2RquLp7pplfKDRBXh5rqk/6u6ZatpLup+PC?=
 =?us-ascii?Q?WL0NQf54eQTWrtoPmgh7yRWDsGiKpd/ZvDOeY+WNLuOdqmRv+u4q31NRfLX0?=
 =?us-ascii?Q?ZgLI03EoLjbvnZ7iBprXh268LCTY/sIRLqdGKoxJFaed0mHIX+LAnrgzNzAi?=
 =?us-ascii?Q?ALbSl/mQuX91ooW5go7kQFf/TpiIdmOOjSksN/LycRQrppyz+Hj/v4srtXu+?=
 =?us-ascii?Q?yB8jdjy9G9wS7NHQpOrBvosze9xtH6eqYjxdZlL7Se93e6Pm4Uklakiiu1Rn?=
 =?us-ascii?Q?qWu0TCMvXJf0jiUfBkqQk8rO1kIgVUMpQ8X3ZTxLdk28prPqyXumHjHfcl22?=
 =?us-ascii?Q?kDmDhLvU3LFhntBoQqrPBD2MV3F9Hpn8sQLMyP/k5ChJipQy967FcFEOb+7T?=
 =?us-ascii?Q?vvepQIe9xYvZ+LsUyGsghta72QeYe5ZvrWyiE1lAEZ2BywRJGY7Fs6TGXZ/x?=
 =?us-ascii?Q?VH0LxvRCSBaKwB/S0V86WmlW4mK11FBLOYgHJep0cdv/D/Ba0bzfO0P4pbjG?=
 =?us-ascii?Q?we9XCxlAe9a4QPh9gGJLThZn57S6zuhtsIsisBuewm4C+5N5lSN5zGQCLECI?=
 =?us-ascii?Q?ZEGfkbNlYlEvXw8ra0TujSyK03iJknm8tlsgY9FRIg7tkiYOnUWZ5lGcs4tI?=
 =?us-ascii?Q?unRYWjKfX39YEu8yQYpMIU/i6dxMbeCBDsyH3SiNe2YY2tPOvOuMpF9FO9BM?=
 =?us-ascii?Q?3VxF1Gy1JXJa8UAxG3Td5NGoJ0gNBR9e7qqJexN/jhygsBjk95PslSe1YvYR?=
 =?us-ascii?Q?QQT2MdnKSk6j7h/pism6o0OtU7yKqF4n02m2kaMw2klhfYUONA5/vWWvxQak?=
 =?us-ascii?Q?M9dLXRADGkYEzVlXI1seZ2kIvKVBTQOFxHFvXvlGwb427vP1Ex4pPmOALUAx?=
 =?us-ascii?Q?rbalE/HnnQ59kBAZU45JsqcJX/J7YyeCCRuJUmccSyKqABkJlPbGUsHX9mo+?=
 =?us-ascii?Q?9074xjKakIqyTENpz57hwgJhz5EbAd+mSkjEUNCPgp5ZMktQI1mIVmZECffV?=
 =?us-ascii?Q?kYJI2OULDmTB3v9+7tIQMSJgT6h2h0IrA1KCcjUWSv9Qwo8u8lc+syIKHBC+?=
 =?us-ascii?Q?6e9zySPLO+KkBGhk512ueYwhdDKH/qS+BhPYxg/D4/Qrgdkig54AJYPAkR/y?=
 =?us-ascii?Q?V2T455vNdQF50yUPkHSJsN3fbEXaUTsevW2nBYKKiydkQj4WRIpBTrC7rDTd?=
 =?us-ascii?Q?nO9WfegyD2mP1Sva8rRfCzM967nCVNOPqi/7KidWyHO1p8WFmdiSsTvJ3bEJ?=
 =?us-ascii?Q?XRxG+IKm1FpIqEEy7M8veio6vjmQ4PpBV2OSn0rr5Bf1PHjVF0+rEOiMTY5y?=
 =?us-ascii?Q?f5aP/3fvv+IgfApHIf2kSE7RZt53AD8xMoQ1nrgNzuUJWP8y3DqXKKrvEcPY?=
 =?us-ascii?Q?xp7HcNBzLat82x/Hpbw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:12:30.2419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779a3561-0bbc-4ccb-4898-08de069ea0a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD
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

The min/max limits only make sense for default PPT. Restructure
smu_set_power_limit() to only use them in that case.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 1c5f37cd5b75..f946effc1776 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2966,20 +2966,18 @@ static int smu_set_power_limit(void *handle, uint32_t limit_type, uint32_t limit
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
 		return -EOPNOTSUPP;
 
-	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
-		if (smu->ppt_funcs->set_power_limit)
-			return smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
+	if (limit_type == SMU_DEFAULT_PPT_LIMIT) {
+		if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit)) {
+			dev_err(smu->adev->dev,
+				"New power limit (%d) is out of range [%d,%d]\n",
+				limit, smu->min_power_limit, smu->max_power_limit);
+			return -EINVAL;
+		}
 
-	if ((limit > smu->max_power_limit) || (limit < smu->min_power_limit)) {
-		dev_err(smu->adev->dev,
-			"New power limit (%d) is out of range [%d,%d]\n",
-			limit, smu->min_power_limit, smu->max_power_limit);
-		return -EINVAL;
+		if (!limit)
+			limit = smu->current_power_limit;
 	}
 
-	if (!limit)
-		limit = smu->current_power_limit;
-
 	if (smu->ppt_funcs->set_power_limit) {
 		ret = smu->ppt_funcs->set_power_limit(smu, limit_type, limit);
 		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
-- 
2.51.0

