Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9EEC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16672112D46;
	Tue, 12 Mar 2024 09:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CqSXUig1";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C7F112D46
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yuw6KE4hrTLpi3qe2fS1CwYyjBtL6TOR5J5OG/Nmvy7hyu0GlPYLvSmHkU45fRxCFdScBBTH1V5WO3dp5oyoGD9Zx060znUOaIsyOUVKrQO+1iA8xTOl1r9OvW95AiIf7xliSoZThHJTta8RgoTKqU3qPO1+0Sv4t1IEWJKwqSYABhOMsObbKViZ9/AL7EBT/+eRPDs1jkS2+xNrTB/u/kvQjATMY0WNJzJKbsdv846D5sqO6zODkXvMqYhw/S+IOiFLcLZvz0L5SpzjGvV7zFDAmKjpDkFBCZtq2TqgwQ84lVJQR4WugziGmADAYtv3mFCtiJvZKXhd6sbW8ygjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBPdUju1qbg/DOHXRlaDxAmGqJThIG3zCRJz4L+tEOk=;
 b=SlsvC2chBNQ8avSPZsFvp+0XtZaRE26fpiVvcDBiuXzvk+fFJRZKfQcRSwC9L/bhIBV51JiP+LJJXiyOHRJdmQVpBRG6UoyD9mgpxtaLIHq0GO4+XJTI8Y7g+frQemZwWzJhapX7TFzhyqyj9R2mLXTlHRmknp69N6Mp09SwZFh1PnUVqbvqLNfblUH6Cm0RoSUMUwB1v5VFe83Dn2jGuhMpC/AzlK+z65UQn40h71cEYxUGI5o1v9Vd6cqENobDDHMuXbiy+gyt4HnzuK/efqFivyuNiyK3u4jlrX9XV12QDjIaaZhnPKDYEUPnt/XLkJNno4bjJzMHYqfupFtdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBPdUju1qbg/DOHXRlaDxAmGqJThIG3zCRJz4L+tEOk=;
 b=CqSXUig1xfdc+yWrxo81wMxJIXTeL10eZA7TCs8BtDboTNsfp5oeziAGyxfh3He2wSE6yoIXYOFZPTRBtUHcJH0Kjq7fUxECnjQ/G7yLt3Zhs42WNnrYlQFNP6akUQTui3B5F3pPRiwrr62MkN7yigL5Jw6mJklCcg/c2XZZa/Y=
Received: from CYXPR02CA0068.namprd02.prod.outlook.com (2603:10b6:930:cd::28)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:25:16 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::5c) by CYXPR02CA0068.outlook.office365.com
 (2603:10b6:930:cd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:25:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:25:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:25:15 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:25:10 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Chaitanya Dhere
 <chaitanya.dhere@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 42/43] drm/amd/display: Add TB_BORROWED_MAX definition
Date: Tue, 12 Mar 2024 17:20:35 +0800
Message-ID: <20240312092036.3283319-43-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a81b92c-120c-436e-c3d1-08dc42765407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U06zWpW3WCyIwyIzANsXsVgq1tPiZ4c0EYS+5UjaXXHX8/OK56C3VCtgQPLv7Io9aV+6JMP+4AeyaWjkCia814yxozF7bQvNCCCssUQvVbBCojZ2fp5BpYy1x2D0xlhgzLXgF7375XbdNEm5HXDtwP4Y0SAJ4WRtf8PLLDLBBtJHrDp9sD4/VQugMciJIFQ4hleFDS8CcGKR/5SJwh5wnibNE+OayeA6UHGvaERAvLFPy0RS3QGil2KH67cqVwKLcOkDqrMEHATGB2/2lcxgObl/w8GIIfPqDmO+vwZ/uplDfrzeOR+0s0nAzyNWoh5ow3EYdyXNfBU5P4GZ7Ceom0OKQ8dPVW5rFjYyDb1HCASNleCBssHe6B5rrAzqgYq4G7jFil3llESTCutb0qT7a5oJku60ILdjAgXhUWtAhAd4CvkVgb8WD+k5u9RuMlw24QOgBf4wpBLJOwRaR8ssTkFGuepshDBnx0oe/VCd5CMRm3xoIcMLgziUmd+5+JcB7CjxgvXjisFAQgaAesr7nDg39gQe7Lvgy26bt0FSFO05VIbRZ5rs5NV10LE5x3ZbNJYln+9YCBr6Bd9ICUGkRoLSVyIZ8TjFxHiNoLpWRHgog9ucENXeCrcxf1vi9OioLOKMT3HHzSWVmi+uSg6yx9O0d743jH71ETvCZRQYDuJKXBqgkJoaTgf4IGBR4PJiAKIB2RgJiMqs+hb0uYl62XdmLSc4OfXaZobXP5hVwAM8F2/YIbmQVMlKVzXogete
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:25:16.2043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a81b92c-120c-436e-c3d1-08dc42765407
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
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

From: Chaitanya Dhere <chaitanya.dhere@amd.com>

[Why & How]
For DML2 to decouple it from other DML versions.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 9be5ebf3a8c0..9184772d2e38 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -31,6 +31,8 @@
 #include "dml_assert.h"
 
 #define DML2_MAX_FMT_420_BUFFER_WIDTH 4096
+#define TB_BORROWED_MAX 400
+
 // ---------------------------
 //  Declaration Begins
 // ---------------------------
-- 
2.37.3

