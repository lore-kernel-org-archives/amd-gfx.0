Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1807EE57C0
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:25:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A674E10EA59;
	Wed, 11 Sep 2024 16:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kGa/nJq+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B171610EA59
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:25:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBfvWaL48PlBdvSyNZhYyUrxhUpLXRK6vIRRgibcNwzR285AjLlfxkfDedvt63pWqNcZ6h9bhh/7mj6GgcylY5JfmH+TV67OIv/txXqjkP4Xm7cKVz/9gfr+7Zm5S3PmgO3ucITZNaKt1VeuPHLXtW2+rP2uC9qZen8DRCVH1kjJ75gqHdYxzZqR4rODXjN5NV4wI420cSEF8J0Q1ORrrb4YmE5cGUkcEesIs1gxR5l7K3bUZZ+zckdO90I53HE3ycOH23CZaGCOnvH0l/8PipM51K9hQaoe3p3XaLS35RfVuKL8jMd7ULYGfXlD9YIp9WhweKJ4qP4qvhwJgG0RZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuW+4Y6Hd1EWvPkrVY/cjoag/8+SMT3wFlo8rVtka6U=;
 b=NBYblBHGH8HomzJ9eSUTyT7cbrKD4mO2HJY3PVxjlH2RAQL+lutq+HlAu5fQytOt9OVSJ8eWz2aEhvZssvej/Wqj3n5azxO55HE3yoX1t9xY7y35qxl/EtnapyWoCOdBAOc4dTSq90OAPtRCdoPUXBUXRF6H0WDpq8SXPjNHHXnFtNLYXRX0mfIA8KeF2KnYCrhZlQVauWJ1bYGybdrLU1TKXM3O+hqSVBeFgGQ8ya7ChkrIvB6Xz059uKuP7LzrgJxWYlzg2DaVbCuH4UDy00P1OsV86itkilK6Ce0o4Xgk7gtR0DMclOkPhXyYEUXIxhrmhseDYj082Qh4+ZdWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuW+4Y6Hd1EWvPkrVY/cjoag/8+SMT3wFlo8rVtka6U=;
 b=kGa/nJq+n8EzGbxMhUV3rLMAQ+YDj3ojoaHgUE3I5PztS10l+2jljHud1ZZxuobK0e+r3jyBMLyVgafiJvA1O6MF9bw6W9Mt59P5gDTvPZK7C0UtOgM0N0RVkV0YCh7o+IaGX1K7ze3Rb+WMT7sAxKWw6maygy6GxHB6JlnlHDQ=
Received: from CH0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:610:74::16)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Wed, 11 Sep
 2024 16:25:11 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::51) by CH0PR04CA0071.outlook.office365.com
 (2603:10b6:610:74::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22 via Frontend
 Transport; Wed, 11 Sep 2024 16:25:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:25:10 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:25:04 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Aric Cyr <aric.cyr@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 15/23] drm/amd/display: 3.2.300
Date: Wed, 11 Sep 2024 10:20:57 -0600
Message-ID: <20240911162105.3567133-16-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 929961c0-8fad-492b-e0b6-08dcd27e4ece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AD7F1ttMNcAjMwUz1yk25P1t0pT5u6hnKZlf9lvGjaGxRomPSQOlyH4q0PAr?=
 =?us-ascii?Q?J16wz/XtajuPyvc88kToHFUhXigKsY8fbB2gqBNO8aMDwFaXnU+OXPu4ELvf?=
 =?us-ascii?Q?41ahee3/DoGyzvHBwich/mZPvOQFlouU8dS/YWAGNTuiujQhAe79NNah1X94?=
 =?us-ascii?Q?s9bctV1E+3FMxACVDee2Xm2cNSKqBJ1xElOCJ2t/01y9b/IR6gZ4inoLcKd0?=
 =?us-ascii?Q?4hX2tQLsOQlYGl1pCsLa1Xbudbo88Go313B4VCh9k6XQAb6o1icVsIPjMVq4?=
 =?us-ascii?Q?yz+oTY/qTLqaroV+dVwn8Oi7NxMajE1CGsKTHGoVrFDbAdO9PHw0Ju/2oSP8?=
 =?us-ascii?Q?lmBiBoPXizj2RKtYrOG4xeEkh+/RuRzjUgXwboVudEhcKwmpAh4rq7+7uBwS?=
 =?us-ascii?Q?NBLficXWDxqT7YLxk36YBLn+P9PVhE6j/XxCt9ZAYDmV2B5Gxt3ZI/LMLZnJ?=
 =?us-ascii?Q?lw+yhuMzqAyLJYfBZa5GgXKTZBLuqN80F5gQHA3+PMH7ogFcStHPLiaB2X4N?=
 =?us-ascii?Q?Dc0f4E/zeAzuaq8MM9+od5+4ZYKkNefbANf9tqox+6cMWM728MyWJ79ArQmC?=
 =?us-ascii?Q?hpH77WTp7xLTP1FOf04SmbU4kx3SBCsYvW0qbKPBPEaMUMrmuOj7LE7TXeby?=
 =?us-ascii?Q?Yhk/mNnfBK4SnYgAmwIF6q3ggGGhl5hYgCkcTohu3xYoYzYhjSACm2Oj0oZs?=
 =?us-ascii?Q?kE6pAs8WnkBDTZJn3uSYShkEjt0Z5vJ3BGp7CxtlXKdTMjCOxqzbkz52OUAi?=
 =?us-ascii?Q?Q3LGYlp1jk08M3M7t6F2tg9mDep3oREzM8tjTMo1BvuWvTYDtfCBrqtLdqog?=
 =?us-ascii?Q?U24rYY2EagDl75A/x0Xb7GkC+0tqECBq7ld+K4lZmqYBoHAopfrUVxEKeVF+?=
 =?us-ascii?Q?UVBQhn2O3mYpLB2Rmjq4A8/h/kulPx3VxXP2zXarH66TT6FgkKbq65FKVCmD?=
 =?us-ascii?Q?qVUBQZmZnMDjtt7d+NChXwf4afiqaoSq3j2IvsSQSmm/8QOL3Jeej3QkFyPl?=
 =?us-ascii?Q?ClriSfH8c11IemeTbjOZ7/DkTCL8Srpyd5qgSRxVCm/HYAf1hHzEizpK/5FC?=
 =?us-ascii?Q?O36Njb2DhoP8WBLErQr7zlC+j5TK7GXP6LMyR5GqPx48mNgUXfoMgMtNpjU+?=
 =?us-ascii?Q?98Ylnrd83Ngi/7AnqNP2M9uU5GFgkw4+oWjydz9nx2Un/xFvU6xXiBP8/dF+?=
 =?us-ascii?Q?2ALU7pKFQBN+XtXbp+xWT+PC1EoY7KXLcZ+5Qi+5mBTthIRjtnmFAXy903N6?=
 =?us-ascii?Q?VTPD7nqxeKrTkS0/UU2t2KBNLQUNViiIxSaGYdqQTSJhnjB4gO47QwHtmy+L?=
 =?us-ascii?Q?4/qHiJWJ/sxZH5MHG6aDVv6zhD686gJ2uQ+x9VVK24vdrKJIf23sCJBws5pW?=
 =?us-ascii?Q?zO8iLDVaHl+WOIp7Tr7ngDn9iEyc/Lu0sHTfJ9sWZ3WOgdNGULgI+H0up7Nh?=
 =?us-ascii?Q?tltPvVUNquhfU8SdARA7rjI8u2JTWwn6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:25:10.8879 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929961c0-8fad-492b-e0b6-08dcd27e4ece
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
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

From: Aric Cyr <aric.cyr@amd.com>

- Add HDMI DSC native YCbCr422 support
- Add fullscreen only sharpening policy
- Restructure dpia link training
- Disable SYMCLK32_LE root clock gating
- Clean up dsc blocks in accelerated mode
- Block dynamic IPS2 on DCN35 for incompatible FW versions
- Add debug options to change sharpen policies
- Block timing sync for different output formats in pmo
- Enable DML2 override_det_buffer_size_kbytes
- Add dmub hpd sense callback
- Emulate Display Hotplug Hang
- Implement new DPCD register handling
- Use SDR white level to calculate matrix coefficients
- Round calculated vtotal

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 133cac4d9fc4..e659f4fed19f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -55,7 +55,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.299"
+#define DC_VER "3.2.300"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1

