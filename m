Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366F1C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08C610E4AF;
	Tue, 30 Jul 2024 07:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X67Ictoz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9229010E4AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:19:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tazJB67qxwYyoQxozsBULbNDHtngk/DyDxtghhp3ZYTJ7+whiTJdF6h3i/YgTzlnDec1OhIeAcRvm1m9AnYiLF95/nbpGeFfAKgRgYEMQuGhUygNK164zne9u3je4atx8MXa6AZ98pZzsYbLfJX4CnF8rG+xtzjwbRZdW3GXJYZzj0NYIpWh9YMLIh/Iyex9lwYjGlomXaDxXlsbXjvfkdc4B+Y8sdaJA9Qir7PyRiXa/winBy1CrJGUUkinNnMhBVJtjXMjTCHnFwx/rvDpcoYUksHJyjcxLXDVvDH7t6HS7n4anLjacSBX8BSCl2CLyX+xGnfOzotmPHnvoapTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpfwSdiFyPOLG9/No+HvRnNEorjZAAvwlKfgtZP6IMM=;
 b=Fdz5sxwnVLYNj7cmz8AzmXLJ01DDOqyTrOZnwOnoyUmIeOlgQzBNlC0XHmJ/ALa/blPv7jLh2l4Ln8TT+sGJ/3FCiGPIjRbHW8s3/wQ0teHz0AW/rLZ8+CLPJq9lX4/REtWQ5LprqBIGDmQGWyw/b2j3VUL1bSsvcOHyeKPafgGchGTMWZKa3/LWDddwiqib3yptDmT2/V1jr/yXJ/amKnEo1ziq7m6iVs633obQcTs+Rkt9tDDvMHFpBFm7mjRI36FcTZtAMiQoWxZZ1FFRBcQNs2uI7yd2b7SErvLxjwpvcK2ue6hikrrSpEEoDINGsXGb9OBkFl3ej80Z1PbeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpfwSdiFyPOLG9/No+HvRnNEorjZAAvwlKfgtZP6IMM=;
 b=X67IctozFkGQNzxsF/F06lpL3zZo+qZjSKrWJ2kx4lnPuNg7wzWpTuRcjuBzCtNHHLfxsTbk0td8xMDyi51/pfrANJm0SxNvshdwfMYZ9ThHP/PPwwJU2rLQhY6wfJ/fztex/EPGN2xPjPeRoi3i9KrmZ81gREUxFF32wCj4ohA=
Received: from CH2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:610:60::23)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 07:19:35 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::16) by CH2PR14CA0013.outlook.office365.com
 (2603:10b6:610:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 07:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 07:19:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 02:19:34 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 02:19:28 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>
Subject: [PATCH 03/22] drm/amd/display: Remove useless defines
Date: Tue, 30 Jul 2024 15:18:24 +0800
Message-ID: <20240730071843.880430-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fee168-3596-4c0a-3478-08dcb067f6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UnXGKUQJZHbvXhqyHzwbuvIar66gQuYhP/ZPb6Jr0F+7ePpEFc5pfwAty/qW?=
 =?us-ascii?Q?6cwBWoKwtVyh/H7bEM52YMQ9r/bqzwaxl59jCSsK/GyJTC5o/BCIrk/yWVoO?=
 =?us-ascii?Q?sTKIpyb7EaFkAf4TSF/9DcYOENA8EolEALWwyFmaPj3JMgcgch2AKVRUyP5X?=
 =?us-ascii?Q?rCVxh8i3BMKOCYwz473FxVLEH1UKtWxXC/ggxY4KwePXPas/4GRd5AyNMC/V?=
 =?us-ascii?Q?t+nu56qi9cxBQPpQtcvtJrK8J0ASspA2k8KYBH18m2AmysA64PJ0+LBdfKj4?=
 =?us-ascii?Q?17+hUgdDic919qKc/5lKXY1zduJKULYX32ewG5l+53A73iPBrWwXZQ5chjhd?=
 =?us-ascii?Q?7/gv52B762gZSbIdEpjv5i45k6MMYpFJBgHh/WdTPjq9JQq4Xf7ZDmzWCKYF?=
 =?us-ascii?Q?QMpKoTK9Yx/bMcWKdQlVKxAvpVRnBzgISU0CMxNQB/VnJ+nFl+1vQKhIA1Vk?=
 =?us-ascii?Q?x4E8q0DdsGyvk+VAMVqsa1ev32S5u4ovGaYEamWnvYgDQ1Kxw3ewra22druM?=
 =?us-ascii?Q?pv52tIvQVxB4bb49nZ/0g5KB0u14LU8SOnG3L3sN4+L5WjBwlABengD01kMF?=
 =?us-ascii?Q?0A3WlbWzNd7vAamA650OHH4B/4QNGEVQRNI5tepVo6JRhx2zQib51SgRErUg?=
 =?us-ascii?Q?hZxUnXhvtTKrF/RUNKgngcTUkGa1AkG9N6NZXi78QVx5GSANmCuVyiONLF5n?=
 =?us-ascii?Q?+L+QA2tZuKYAraMVVQ5C+VNjbZJXHg7VeMm2ZrLipEQSraTyIcuJUmuaKeSD?=
 =?us-ascii?Q?LLKsz7ZPF9XscY0kQGH1zBmCRadhaaK+rJmKwXvR/gLkDge450KoNdls+Uii?=
 =?us-ascii?Q?qpPphLgAQ40mHxNmu4Eg3hLY/nasAwEUNoXddKsbUldB9irXjjcb0Qny8a+w?=
 =?us-ascii?Q?a3+znlqW3vyWUniYLOGbBPZ6t+DQ3QfJpTiV+UxiPy5W3GZ3VgafysxMcO0N?=
 =?us-ascii?Q?FKCw6sNdk82Mhao/wFWS51aj14+rsg6rW1vyKHp889PrPeyaewgA9Yd4WZnA?=
 =?us-ascii?Q?+alm6x12mdz7HdyODzzabI8yVS2XLG8Xi/GnO23DAAbg741E1gryhST3hqTp?=
 =?us-ascii?Q?gTtRhTLWz5TEANdCT2Lop6dubcE7gulYS1jBuJD9pHsez+dH/QEwFNwIs6ZS?=
 =?us-ascii?Q?6QrN6xGj1NsId0fLYzUb6oblAVrXzaMSgbMueKFpwzM1Iq+KJ5XT60VhLWzM?=
 =?us-ascii?Q?nKSi25HSZLlHOmBbBp5hamS+4VuywWumc1F9K9cyiTFJ6nTDPJib8uspisUK?=
 =?us-ascii?Q?r1LQ4WkdOI5Esmvj7LADgQHfnYnDBCEN3x3vOEjvQq3SQqifGyW6u+hqVOK0?=
 =?us-ascii?Q?ub2CQJq9yQY6WVDJsYqub6SG3UzbMB3Y7kjzk2yO4l6ZAI1uUNBOV3OYJns/?=
 =?us-ascii?Q?D/6FlFy4e4o9p8UeTCmde960JE60sA8X4J/Fh0ViOCbq6eqPS+ciOOdj4CKZ?=
 =?us-ascii?Q?pNx9ZYa5nV8BMtJpo90UmT1iyoU4l0F0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:19:35.0870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fee168-3596-4c0a-3478-08dcb067f6ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Remove __cplusplus defines added by accident.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.h b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.h
index f1fd3eb92f8a..205e59a2a8ee 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.h
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.h
@@ -9,16 +9,8 @@
 #define BLACK_OFFSET_RGB_Y 0x0
 #define BLACK_OFFSET_CBCR  0x8000
 
-#ifdef __cplusplus
-extern "C" {
-#endif
-
 /* SPL interfaces */
 
 bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out);
 
-#ifdef __cplusplus
-}
-#endif
-
 #endif /* __DC_SPL_H__ */
-- 
2.37.3

