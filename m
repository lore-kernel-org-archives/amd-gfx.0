Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38B6C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F49810E433;
	Wed,  7 Aug 2024 07:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zntKxOXo";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631E110E435
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynBN8k2zjDJWFuQi63dVHkbOpOMXQ29m8SxpdTu9dJtA8hqXwULo34ZMLPlx6vXMtAyZN3RTPPtpl/jmMQBAbY+2hdKrPAVFZdLGWXvgbYue/gGG9W+RULivuV9YU8/ug5vdUXInpndHpvNmpOXeo2c0/tFfJsx9TJnezaodOeiPkY5K1eOyLzBdPf50eCrHJmYOXWcmuAx4eRvT8o+rc7KqZ4hWCm5aOIG7GKfw/dQRI9KRANAJGJ92xiQu3DDy1IQ/i4Pl1p5IxXsRshvxnw0OXazsDyRhFlMmxFRz4Y1AM5Nfbt7BBAnjngswW+Lvdx9MM/RuywD5CviO4cVvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so3SCMIJwv0Qt815U1dtEV+aARfDDGJA1MKYDRLFIz8=;
 b=s/exOWT756srLVHja0cNTbn6bLe0YCU3y5Uf+1jnK4bdzEBf42uD9Mu+9tdtPP5aI/TYTjwRxPsU6/3ixMniqqQzbMmSOr5oKNsWSqaGQEVWJGCepQctXRnVnhNFMoQf9SdPawp9kfiKPBRkSO3/mQaFgOaB//6nAZr7Ghsf9YSrSgvoJoxta/++NNxD5pOl18XW9XDLkGJWkLmB0F0X9IpT6Ft6MXqDwDgAwYcNXLiaO8P2oA9dybwoOY5Z60dLFYTzwIL0oZtBhfe+PK7nA+c3n0hdCm5JmEo+at3KjI0kWgv9HC5QCr/qguzhhSSrAuIOtReDDZRsCNZm65QMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so3SCMIJwv0Qt815U1dtEV+aARfDDGJA1MKYDRLFIz8=;
 b=zntKxOXoD1Qf1ycUxwSgo8JqVcuo/2HYi0KbMchw7RgUaNPWZfW7v6BxkTQudgBbGg7btbNYtp+j+TJ1/O/onc+UiYYBPYmnl+fVZYP9o7BRTnD347x7FJ2tDw6RARdyOaC8aozHK+eyCQiKytclgdTiPi3sHgQc4NNlSM5qVyk=
Received: from BN9PR03CA0774.namprd03.prod.outlook.com (2603:10b6:408:13a::29)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 07:55:56 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::db) by BN9PR03CA0774.outlook.office365.com
 (2603:10b6:408:13a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:55:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:55:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:55:55 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:55:52 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Austin Zheng <austin.zheng@amd.com>
Subject: [PATCH 01/24] drm/amd/display: fix minor coding errors where dml21
 phase 5 uses wrong variables
Date: Wed, 7 Aug 2024 15:55:23 +0800
Message-ID: <20240807075546.831208-2-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2b92cf-fa81-44d7-4fe8-08dcb6b65e4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hBq4IkPtULSKk3OFIgAd4dzEbaHdaXB8KV4R8Aw2ZEe3+MGEMtH+TESzk0Uu?=
 =?us-ascii?Q?hAnzyDK5pzikgAYgB0M3fY6J3RZu0qQTCHlcJC8gghZ7TVrRswd/sTJ2FnEW?=
 =?us-ascii?Q?Re3h5F7THrTkqTQJlxs795uiYqggP1N6VLLm1N8wr4KB1j3BaOlMJdQSAU3H?=
 =?us-ascii?Q?VdKYO5aMWfL98C6+TO4rtfGDQqng36idLMafJDn1FNAAHSMs+B80QPPrnBYk?=
 =?us-ascii?Q?No4JARnDYw7JZNGMU29Xv7PhpUOb4NuP3bNOn7X+fStOI3R3NZb9nlPk24h4?=
 =?us-ascii?Q?nYqd6GFkHw+Wx6+n4poFYZZ9qhaqQjS/wkA1XCkWNw3Wkr7XR/7dPS1Q7Q+D?=
 =?us-ascii?Q?HoNqOlnLEKj7VUUBlJ2zxVZ0+NW2ZmnV5nr18u83HqOTCucEKfFtkJB15IGe?=
 =?us-ascii?Q?XwYG+bj0aFDB7TumKBsjjuSu7IWJLPkHLAhbQUeh6Qv7YyC7BoMuJKkHVrhF?=
 =?us-ascii?Q?iOeks6wWFsjnpj4X9rU6e+l1jG59YoMwtQm4Qw7Lo4d4Njaun09baE5Srhee?=
 =?us-ascii?Q?EWc/4AkMyYcon/BTuQu0oCvhzvnr5THWNWgBZaPdiG9NDjDRzxolQ/L+26Ck?=
 =?us-ascii?Q?TxZDoq2owai1ScuUEfUl31J/nBZRsL6N7YsamIAdQ+KyhrTIXHWcJNYSBBQL?=
 =?us-ascii?Q?Sk4BWEdrWgFBPrH8hIWajkvZ9U8+t95EZUaPSFvel68wQGO8oJv/W9xkMNdD?=
 =?us-ascii?Q?94KuZMkC0BX+8/877icI+UwGkcP1tcjtpFfNxRsZwe6JBejMXnfKopIl07xT?=
 =?us-ascii?Q?8WgNGhFYlf8071K1TKEiPoxyUaItLIWL2ntvP8j9YR6eqAcMuBSVf/c+Ikd3?=
 =?us-ascii?Q?e6jgGOiPX/MCD/uCyCwXlD5UrMeuoSBYMSBXnLu1Hr5u10NU85/lIbGl0YlZ?=
 =?us-ascii?Q?O9y8ukV4IqBq9WZ7ugtMYK5czMCow+l9/Z1e89Qj8TocNxzGAx2aTty5p1YY?=
 =?us-ascii?Q?jxMXBNGD8E6Ln0IAJS+GKAXISDGmRO9dChugQe8HOYD3EJE1bc1kNgkRoAVM?=
 =?us-ascii?Q?BeGjDKKkUiTrh2R/l1P0GBOts182xP49RbSfdgV1XAVGf42NGfAsHZrAB70q?=
 =?us-ascii?Q?+GKnPsK8CLEGQVpMdba9DiluVAg5LcIHE2+iv9V6bx8L9Qz18oGNket9ZOWh?=
 =?us-ascii?Q?r01PztL4orjcIqjW/q6GBO+GBdaYb5lnJwufowX+Mu4GQd4cw0aEvvvvIrnB?=
 =?us-ascii?Q?cocXCyqDQIkZ5JlCYFpg97vmmsmqTUgmhOMzRrqdDqU0ayvM7HMtUuXv+LpM?=
 =?us-ascii?Q?GqJlAnGk9sZPEwIFr6bbvRrvBynvETcWX87SloLAvhyYnQtKvROOzwFLlVbc?=
 =?us-ascii?Q?6QLNEtcjAW/7J/P9SZEYXZYbRT9ylpbUrWa3g2FR8yTi/kUUN/jdIOArlnMN?=
 =?us-ascii?Q?P/JE3cgQBXSDcXp/UayE+ARmr7YNzgD5SEjjnha4XybwnnD89vhqICI5Kfud?=
 =?us-ascii?Q?Xb58MpxNg5bZeVdJTckSEDqDmIoHkfn6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:55:56.1480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2b92cf-fa81-44d7-4fe8-08dcb6b65e4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why & how]
There is a coding error which causes incorrect variables to be assigned
in DML21 phase 5.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
index e9b40a45ffdd..a9c3ed6d50ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_top/dml_top.c
@@ -274,7 +274,7 @@ bool dml2_build_mode_programming(struct dml2_build_mode_programming_in_out *in_o
 	/*
 	* Phase 5: Optimize for Stutter
 	*/
-	memset(&l->vmin_phase, 0, sizeof(struct optimization_phase_params));
+	memset(&l->stutter_phase, 0, sizeof(struct optimization_phase_params));
 	l->stutter_phase.dml = dml;
 	l->stutter_phase.display_config = &l->base_display_config_with_meta;
 	l->stutter_phase.init_function = dml2_top_optimization_init_function_stutter;
@@ -287,7 +287,7 @@ bool dml2_build_mode_programming(struct dml2_build_mode_programming_in_out *in_o
 
 	if (stutter_success) {
 		memcpy(&l->base_display_config_with_meta, &l->optimized_display_config_with_meta, sizeof(struct display_configuation_with_meta));
-		l->base_display_config_with_meta.stage4.success = true;
+		l->base_display_config_with_meta.stage5.success = true;
 	}
 
 	/*
-- 
2.34.1

