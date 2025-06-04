Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A74BC5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F008E10E7F4;
	Wed,  4 Jun 2025 19:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qpeGz40g";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D034010E7FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHGQRHnlQOrhgLm3s9wrrVILVpje5NDePdTb1GNhxcP8BP9URJebjSQpqbncHD2ZdW2XzHQrl5GLqiqRAEKTOW2DUOTr8+bj11cRb5RKcDB7HyVJ0prwt0PEB4rHY4yB7edOJ4VWrfrNQ3A12R0DTnw3Cc+eb2veJzCgggSDSjzqFhba1gujQ5HX4DmJ6OGmbt1qiXfZL+K1uOc4AhETX+83jvq9MLpnQKg4K/1HLRNKvAECHpuvFrxJ725MfR56oYRWpb37NrCLcTezLr/ne9gsT5YyyTuWkw6ZpTsLy2+7oh2Atq5vG9AtPJdJtNn/2FH35KxTEWzno1Sswe4JTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rijaKawbBRYPy+dH5uRJPFH/v+C3Es64RJzYmgvWxUE=;
 b=SQMgIOMJOtb1ygIF/dvuPjrl78v1xQVGEyGp9v3WZutiFDo4f1fihQYvxU4GP08UPjeUXtr4G5mqoCrQQCi6BOPDFlfxwEcMqeuwNAsp3tJjwkziVWLEEaks0AerGj4R4njigQ+GtZ3b2aCEHTz8OlJfbvfCWZnnpS+X7yI97FHAiDHhqk7Ht17AySoVuT++QGJSmrwSyF9u9s25Mw0KVuHmxdhFCif1Hzwj+6rP1HvSU07hUMGJuF4l2WcJiNXAksC1vUzttx3Q7KYi9KJD+PA3BgFZ/EcnCIHqjFw6KzwA0ov0D+cv+ilEKbyYSKoO/vRTA3jJqCVDB/F+frE06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rijaKawbBRYPy+dH5uRJPFH/v+C3Es64RJzYmgvWxUE=;
 b=qpeGz40gwoEvyezJrq26wdcw/yckZcFgbcdwdCJrgV8b+igwXQbImkNeZy1GYVgNcmOmRq6Vkb6S9V5aO5C1mr0d70BwEDJHX/a4XQ1mdFiy21mJnFdi6lAy7tgiLEzrZQnf7ZbZdK/fYq7c8+/CZC5Mk2sw9S0HAbRRggMiEZU=
Received: from MW4PR04CA0196.namprd04.prod.outlook.com (2603:10b6:303:86::21)
 by CH3PR12MB9341.namprd12.prod.outlook.com (2603:10b6:610:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 19:41:34 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::84) by MW4PR04CA0196.outlook.office365.com
 (2603:10b6:303:86::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 4 Jun 2025 19:41:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:41:34 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:41:31 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Yihan Zhu
 <Yihan.Zhu@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, <stable@vger.kernel.org>, "Dmytro
 Laktyushkin" <dmytro.laktyushkin@amd.com>
Subject: [PATCH 19/23] drm/amd/display: Fix RMCM programming seq errors
Date: Wed, 4 Jun 2025 12:43:30 -0600
Message-ID: <20250604193659.2462225-20-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|CH3PR12MB9341:EE_
X-MS-Office365-Filtering-Correlation-Id: fca48de9-047f-4731-6bf2-08dda39fd02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dzB+LNQ660Pw5BvBoYfIoj3jmcDxbZDSXUTz83AnRj5SP0DgiwIlbkVEfBUm?=
 =?us-ascii?Q?ihSZ77k/dOp2+zgWM08h/4v8plZr+8uAQMSfBopb9JDlrmospQW61jX4a5qU?=
 =?us-ascii?Q?S9HqUk9krPr7WCjhSJBKssCChyRRGW15yG80BBfZPpJQRyPg8/fcVxmQ60E5?=
 =?us-ascii?Q?rVst0TIBQa6EN7S3OSgMjYAIkLUEduhSjxpz8rFyPygzwiUbnZEdAh4gzLXW?=
 =?us-ascii?Q?3DwquFm0/y8yIn2ukeQjRj0eplrHUjLoa06hj2AgBLk96MXfNSHVhca7+TNk?=
 =?us-ascii?Q?zu85lxvSrRZFPiudieTewUZKrwabZOhzdQ021ohDz35Jqg3GuJ1hpi7sTOe8?=
 =?us-ascii?Q?BX/81ZDHkObqgkqiv6jSbrqfEtpEjR7OFGMSzZeV+1zVfmLN6oN5QzOucNuQ?=
 =?us-ascii?Q?4ESp1+SVCUN+9isYgTpc7g+/qOuaDpTyTLh9asJdaMesM6ITR3qxnvZsAswJ?=
 =?us-ascii?Q?P9NqyianmWY3mxynGPPM+A0D9jWGZ4yue4MAoPjBlKYTqG647uT1a60PR9lV?=
 =?us-ascii?Q?zypEIyvRkjo1W9me90GC/2UUYJAt58sEYL25KnGP1LSZ+tF8x0BohjdgDuMm?=
 =?us-ascii?Q?9dzll5iKpJHlHN52IyZ/YvpONnxW3TBGFYqOsgJ4FvyIIExKZnWdAfn3OMPA?=
 =?us-ascii?Q?HsTPNmG8VhnP0vHIJhRMrEfo9M6mjjf9DS8tq6oXTP3tgNVZWmnMl+SDOY4f?=
 =?us-ascii?Q?8jV4vuxi6SUQZFjRWUXMoD5Oy3gotl5ahAzz6R+9Z9FrjXoe+k50Cvw6ezSD?=
 =?us-ascii?Q?qzJd0fIAAJ2XOn9t4KGaofsaXugJYN5zZlE8AscT+RBDJMvtn6/cerXvlty+?=
 =?us-ascii?Q?ias2nUV+/M5bXzzi6HhoE4cet7Dc+vMP0YNaxuwqbJr7MTImaEek/jqsx9Yd?=
 =?us-ascii?Q?3OoXTfwy02u0OWfZ8aNlRq4Ht1jgoCIhFt/r7D6+yTwQUMUs1+qRHRCWpmNz?=
 =?us-ascii?Q?LgF3w0jCbxdp+Fxth7uBdDaXsMpmZ3KK0+nQ/4NFjarswWuCL/PZqSjXk02+?=
 =?us-ascii?Q?nU/naAckArsgFv3HrVnpNb2dGSKDFuTgl9YMLMnodw6EyXpZY9qu4+W/Jygr?=
 =?us-ascii?Q?tJtHiIuZ94w+0PLPXPFptGEnkLr+tFDxPhD5URvH04IjcuEf/sCopIj2AfjZ?=
 =?us-ascii?Q?0+4uqkAdjDxFI7R+iaRVN9aRtoV57fW1JqTZyVm81mzQmV6lmiex/1toxWAP?=
 =?us-ascii?Q?eKBKVDNXTyU56LdtjfzJcZl3w/qy4zZCkhuVXsjONXxiA4HZ+ZVXNCDG5GN8?=
 =?us-ascii?Q?HoEJRD7KhtSf6FS3K/FSrsZDTNvFG/BLoWZdQPfuZ81mGGDMarpJsJrvjjZN?=
 =?us-ascii?Q?FNCKjQfniayp+r+dgmI0Ez2/m8X6XK98sOhwoXrW05ap4U+eQJyRE271S+Q6?=
 =?us-ascii?Q?4ApKSiVcwkrIAhH4/XbWAJrTuklONfSDuLeSE30W3EgGp8UIwWUk0hIKjd6n?=
 =?us-ascii?Q?Yip8SrIxPPeT277un5aL3/4ktv28tKSBUeXxoZwtwavBkF+mPdeDE3nr59j4?=
 =?us-ascii?Q?K4w58GHTdgTfGbJ3xpjtROkFvmIOcBoB7Jx9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:41:34.3048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fca48de9-047f-4731-6bf2-08dda39fd02f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9341
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
Fix RMCM programming sequence errors and mapping issues to pass the RMCM
test.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c       | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 0addef1f844e..5dceab1208f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -4685,7 +4685,10 @@ static void calculate_tdlut_setting(
 	//the tdlut is fetched during the 2 row times of prefetch.
 	if (p->setup_for_tdlut) {
 		*p->tdlut_groups_per_2row_ub = (unsigned int)math_ceil2((double) *p->tdlut_bytes_per_frame / *p->tdlut_bytes_per_group, 1);
-		*p->tdlut_opt_time = (*p->tdlut_bytes_per_frame - p->cursor_buffer_size * 1024) / tdlut_drain_rate;
+		if (*p->tdlut_bytes_per_frame > p->cursor_buffer_size * 1024)
+			*p->tdlut_opt_time = (*p->tdlut_bytes_per_frame - p->cursor_buffer_size * 1024) / tdlut_drain_rate;
+		else
+			*p->tdlut_opt_time = 0;
 		*p->tdlut_drain_time = p->cursor_buffer_size * 1024 / tdlut_drain_rate;
 		*p->tdlut_bytes_to_deliver = (unsigned int) (p->cursor_buffer_size * 1024.0);
 	}
-- 
2.43.0

