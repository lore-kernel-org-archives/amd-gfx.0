Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE42EE9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DF010E607;
	Wed, 18 Feb 2026 16:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="47O9uJdK";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E9A10E605
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfgabQU6Q0lUi5Oru0PRekOAVd3kJwUbDsF3s240UXHj67/jkEXBSgIlrifk+zNKvay55lFsCzzIKttJGxmjwxOS3fHkEKIZBrfjRD1LjQ59Jv6AukMDzOQ4rcoMjVx7IlRUZ6El9NA9EljjJV3aAMfoa9dLbirwYXBYqQIrUmMtmeNKduKZv+j4xSLvE4XyjWuwBy8HNGJugqtYve50k+wFMj7hpWeaRmhtEextcryYazJj8VqTGfYmciBGHvUiy96slcsREjszQX0bU4dXRmV6TYf/oD8JTLC8BIN+8pr2UJGIAnUQXA+ddOBZifhUur1ylYkYZ+jE/+Fnwu8Pgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9GdIOU12gzKnjYMIAM8D4eHyXNVbjgRz5nFqIJRWEE=;
 b=k7NbaW1/FEjLLEqFACXOsQJQ1edc2g/ixXQWHoQ99C5OT3BU991W9R5Ex62eOJO3O53CLOBZJlOG1Xvp5dniTL/0BaKQoGiTjbbYAoj9OxNNRv6D3T8ViQ5fGthhU1qNpKbSSpky3ZKfGurZ9hD2VuRv9abG7Dti44e3zysGetAq5hsqnwHb5a55lDud2Xt90k+bw8Jjz9NYAxxV/cECs1gOCcttxnlT1EELA1NGC5sliDivd+yNZGLBRuN+i7xCfY1adg201bFTB9flLqxWhR1EV5/ae3hbKZs99/QFz8zJo7Fj2XpQtiy5sssfvXsfY5T/8c3a4l4LTj+Y2vw8dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9GdIOU12gzKnjYMIAM8D4eHyXNVbjgRz5nFqIJRWEE=;
 b=47O9uJdKUwe9eWTP/s9rE7EA6Lk07t4cuiIt9hXIAUEyMKgf6IoQBPojWB5FnnGsviHTTFipHh38OC2PquIWMsGbzvkkZ6wWTs5KT34sFEMyG+cE9Di+0VXux5BB6o+dIP1TuR6Bto8UeNm7YMnjaL/YJbTBTRAXgrlxKP5htEI=
Received: from SJ0PR03CA0261.namprd03.prod.outlook.com (2603:10b6:a03:3a0::26)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 16:51:42 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::37) by SJ0PR03CA0261.outlook.office365.com
 (2603:10b6:a03:3a0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 16:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:51:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Feb
 2026 10:51:27 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Feb
 2026 10:51:26 -0600
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:51:26 -0600
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 9/9] drm/amd/display: Promote DC to 3.2.371
Date: Wed, 18 Feb 2026 11:48:10 -0500
Message-ID: <20260218165116.155001-10-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
References: <20260218165116.155001-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 57702b22-01b4-44be-1463-08de6f0dfd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zuQg2DwKjj+5+syCU9O2vcqN5lAjoUaLpqQ2khb5uMjtspCjgnKjEmvGYpPu?=
 =?us-ascii?Q?//b8iXBZhIFksJv5om5N4YEz5bH5z5Bp1eX1GijCxY3PkihwUu0ESSYbrInQ?=
 =?us-ascii?Q?1/B9ndGxreFZ+E7LlmKmoHnEUzyw6xp8fLVFN5TodiwcJXzAe3sobikZcIIX?=
 =?us-ascii?Q?LK1netgLKJGusqap0WmKJuMbQvhWIqvlDBjsc8aRnCkr6l8ak3fY+7xxo7CO?=
 =?us-ascii?Q?AHafj8HrJaLHy5rFCAnBy3idZEzBkgxeFvvPTMSuqQ5oVLC7auBOAVch6Ua/?=
 =?us-ascii?Q?++Zk42v5RVZK092xHAjlNQ8jH9ZEVZ4UQrRYBe6orxhCgt1VDflFsRomKcYU?=
 =?us-ascii?Q?5xFEUkYXGTvDNXoesfQlD4Kxz5o8b9yjbiWiQSckN3roL1dGwbbNJP4pmVGn?=
 =?us-ascii?Q?hYkWu+N4oO9nI6imYXYeQyvojQFboqVva1IaCUIMd6eIferYf+ZjuxNEYlz2?=
 =?us-ascii?Q?UUKBUgv+2lkFwYT1kJk8qVdfpHS1ArRSa+F4Hp++jYqP5I5zN1AUY1DS3biI?=
 =?us-ascii?Q?WweFYTIJbSsL6qQyj2eH5kK9Dl7jkOv5MGYOUno/LXawyoj8OYf8mGZu7aEo?=
 =?us-ascii?Q?3kMimUxXFIP/qKLLC/XRajTkhmUlX4tX89ktwwldeSDA2JtaYI1jHE8TVJZ1?=
 =?us-ascii?Q?ouDzc1lFd9jP+LjnSTp/RnxC9cVWbRrOi9iE49v4i3XsMpsXsu6cvCRsCnXe?=
 =?us-ascii?Q?CzVnLjN8QGGPiPf0bc8A2mGGomahmz2Eh5oL/N7ygVV3EeYMSKEyuhS7FZuC?=
 =?us-ascii?Q?OezGV3yuxJFr8nLihLf2LxbUIPbAS2YSrc8dmdHVqVT8MYDsBloR8Ovry9pg?=
 =?us-ascii?Q?H2uU5kmD8b2aDVSsrhCs2akFAbjky8H57x4IcnYK0NKM73ZNrcandFQD+rst?=
 =?us-ascii?Q?ELXBiYrkgKR1jRpAOTV0KC+MJxLV/7JDBHzKc+TWsbIIUQX97accy7X32O5c?=
 =?us-ascii?Q?hdAYFl8Opu02Xy3b0r4yYdocmrV47To7YpH15PVAf+CtEmy936YoWrwWXxcs?=
 =?us-ascii?Q?7uO1hBnjnqrxwt0ubFFkugiZubVOauCOKJgLTLtMq1Rs2x6Qb245BqzFgZcy?=
 =?us-ascii?Q?6paBx+gtwGwNfB0YRW27cT0gaMf0ReuN4GpDBMQznL/4I0NMmM+r8UcuF7yy?=
 =?us-ascii?Q?3n+4h6Cbc3wbPlk3+BYBvDKXRbHPY6LClYLV9GzKQn7WFQALXEjJwehWVlZU?=
 =?us-ascii?Q?cp7EFxIVZfdhgVartmM+UntDp6boQ4TmxFMze26WX0OcPI/eaX/x4Fy2ZEvc?=
 =?us-ascii?Q?qSXGzZ7ooQJHT/hEFpzxfHaQxBmM8C5OU5ZovZEyPHT0nwlBe8uSq/61UNk9?=
 =?us-ascii?Q?SMPvIeX3aBpGxBvBYCTnnQlq1BCdBFrCPYDGTEzE88ZBui+JDbVbN8uuK4lt?=
 =?us-ascii?Q?QzW7bhQQvFfkZgUS3ZCREUnvWY1fjvJyyLmyw/boiv0diixAOrYgPNSqgo/N?=
 =?us-ascii?Q?8Bf/uLjC3cL+fSCbcyW/BQO8TFARF9iOsAVDzZF4Pj52wJUIxAlGRS50egnf?=
 =?us-ascii?Q?pFNsscmtlERre+snk0LrqRuR5EdmEIlfRtUygti9pqWcWsgkysrc6rACJEVz?=
 =?us-ascii?Q?8kTPEDtwcve3XXxScb1ookcxRgsB5oDAxr0vWSdQLrF9dNcTwerCzDspxBYc?=
 =?us-ascii?Q?YYCFjvHUIcJl607hdG+vznE4CSt16nSYXLPTlbqxwqTrMroY+EZXibuiGWAY?=
 =?us-ascii?Q?1XUS7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rdua6pbRNBdV2G56qBfYMWcMk81TTpdfztP8z6+n8+s1V/6c0DSK99qZ2VQA+lslkO628TbIm3LK9gZ/oNc9p2nT1jrR36CDVNgFYwYaksPjYY5EqIuY67yiN7n1WBVhBZn9Ulvs+30MNIAV2nV5uiJUfUPTcdoo6pePgQ6SrJ8fg9QlAW3zPmK0IXS7pTGPhTlynJfi60DukuZVK/iKVtCLSX2p5VE2PxKcotTvXTbMJE1JyjLLGHqUznKyvgykC16X/61qGqi7c29K1fiapM6NtLc98PBKhMkkgzB1lSzor1yL8ZgzhbEQGmFnBP3myr/WcXAqVK+hjdgYVZtiapLj3koQVmAAdHNKggVIaJynQeUcslLXOxAKvi4f1l2PEsrwHlaTvVw2PHnxUPQQobda7Rcgpaok8LVCEgNUwp+slZFcmAJ5jgatZdOL0ldi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:51:41.0665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57702b22-01b4-44be-1463-08de6f0dfd88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along the follwing updates:

- Add visualconfirm support for refresh rate change testing.
- Fix IPS exit with DC helper for all dc_set_power_state cases.
- Fix cursor position at overlay plane edges on DCN4.
- Introduce DMUB IHC command.
- Add missing dprefclk and dtbclk clock types and fix formatting.
- Fix DPIA number and driver ID field sizes per spec.
- Minor code fixes.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7126dc278a53..32fcbedd82d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.370"
+#define DC_VER "3.2.371"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

