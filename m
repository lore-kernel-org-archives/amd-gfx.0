Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0EEC369BD
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C1910E7CA;
	Tue, 15 Apr 2025 14:59:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KZSyxZ9j";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D7C510E7CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFwVf4t8WdyNzAmBBaTYnxKOeL9iF5pWdRAOkjLvneypYfFQ4HVqEbTzhKOlb32Pw6DTsL6UZ14EtCStInbBeyPw6fIy9sGffmXDs0o7LzicGNdP/e9w0Lk1qr1chRD561gjIHMnOypkxP0IidiLLQ+drmaJxnIQMtqScQX+p74UrCYtXQUlhgTm1mgpGHsK3SmsoyuHBxoNSNy6PR/gJoGRkcZFATJiX8KH+7jpkMNU4/v6fFFOiEFuGJE/zBdEmMywlrcFePC+l8Yi24ltvw4W4ABHP2lpM/yLrvJ+TlcWvpBNCGAFjtV+GIvNnnTBRSZ5T/rvY/xJ9WpN0mu7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neX9PK6hk6CQP3LHyGtwggiYaxrw464ijdVoD8nfSxM=;
 b=iuuYK6koAA0mQSjLO8c9OpL3ne1hKZH3P2JilZYD2TqcD/dgDAO+XBw6eDVcET1RdUWTLgMFtbnA8Fq0EqterG/TYcRCfz7uWItWl5GTMkxQXRNSra6rPzH1agddr/JcGBrgxLThKPy21IWEb3rslJwqg6e2H6ObMBVVwyAip2nDMpfmwmEq+hXEHKWWqiAXvDP/pkCfy02+JNVG/HznyX1M4Y8vOwYBu2kXDziqwfowr3vdtKbtl+Z60/GccTLVMpo9xC6hPsvbyScItBQVyerGcndy9xlKopKfAlAyX31kHXocGj+5hnjwKv7qmDfK1+j10aQtK6Dy2P4Q4Ez9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neX9PK6hk6CQP3LHyGtwggiYaxrw464ijdVoD8nfSxM=;
 b=KZSyxZ9jlAX7KZ/8VztoIP3viuueGlWIOLs6vnVXEAU6ZRPlmqLpWp+jJI9d1jT4nR4U4nT9Yc1I4d5j8v66j55dhpqTF+DPIpYpQBumo5/6Ol8pzB1jYP0GVF26m+QDz9oPHFcWdHxwlGnq//G6KU4ZCZCaLY7aERh/B0Kc0aw=
Received: from SN6PR05CA0027.namprd05.prod.outlook.com (2603:10b6:805:de::40)
 by BN7PPF7B4E3DFF8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 14:59:53 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::f5) by SN6PR05CA0027.outlook.office365.com
 (2603:10b6:805:de::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Tue,
 15 Apr 2025 14:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:53 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:51 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Automatic
 Promotion" <dal_dtn@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 13/22] drm/amd/display: Promote DC to 3.2.329
Date: Tue, 15 Apr 2025 10:58:59 -0400
Message-ID: <20250415145908.3790253-14-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|BN7PPF7B4E3DFF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d48bab6-a870-4442-5da9-08dd7c2e2df9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|30052699003|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jqg27rYoQRC76HSPXo5tPld60AgUFmYRDhy2sOgRTFLCwjuFEfu3oj4bel8Q?=
 =?us-ascii?Q?CZnsgMMmH41CZOyX+lVQ5zPRvj2ZXw6535FZ9YH0465aw9YF58nFNfI4W0Oy?=
 =?us-ascii?Q?2Dzs0V00Fs+hnU9RHEQ4u8imyTm+jGVNch0S92k1A/4JRJJdQ6Q2PQ2OapvJ?=
 =?us-ascii?Q?M8s5FvaUQdfsx5O01l6As3peC8niVTMAqtKzJOtnfBFqoglkvGLfUhzHgDHL?=
 =?us-ascii?Q?GY4FXsukNgQY5FeFoYOy9uQGwVjD/Rxz5s9wc6QjGEcMwi0Bgp/ygqL8PoWD?=
 =?us-ascii?Q?TlHsxjHEkHt9NTbbaczhWw8/uk4CcjCb1LkqmI0QjNGhDge9xK4OipyvF4aO?=
 =?us-ascii?Q?ZJHLuzKL9eCbZny5SVDGvbQPgVWPegJdAVop9UlByo2V/G3wfHSsIprICSw/?=
 =?us-ascii?Q?yeZXkNN9/zPt8Jjh5SeyiPogwp4prugo2O29An2ChZpCPPasCPKv7mglSQJ4?=
 =?us-ascii?Q?ohR9QQWoUDsZstQAGoHiDRu/VTe7qzhs8DIPGFbh1eZ48Y1z5mtN8P8UbdzD?=
 =?us-ascii?Q?PSwBTv9Cz0289tbAXQaYrAjfUv7wOi+CXk3Uo1XTD7WdWqMJq8xQOBD+i8X5?=
 =?us-ascii?Q?wXjBLb6cMP1MtqFmgDS3NmWCyuHHt0yMXlEoAZEApLkDxenEBEiU1ctOnRNn?=
 =?us-ascii?Q?OLaoVP4fdrENpstMH2cSmIS7B9E8kCDGmXmVX4OvcJ6HBBfI+9fU7CiVobNS?=
 =?us-ascii?Q?VoKapXIw8/9EcJOs77Zoq9a7mgFTgpTJ6+jcxQEDMXS65Dp4vvEopJONiSrB?=
 =?us-ascii?Q?P4wU4tOjLrL47blcgnNQJvu1ICT6sSxA1YcUOF/IsRCbR5lkJVhozw7DVYsw?=
 =?us-ascii?Q?a2oeEQpS7I1fUsscf7PQ7dZ8B1H/Gn/PGdQ9ZZFul5TlAPFyd1x8P1o1VJrn?=
 =?us-ascii?Q?59g+2DaGCQBdG7C6xqd0lRBDNAbIxxj7KZcX+mY7t4qBZbUDQ9JSiDS+h59w?=
 =?us-ascii?Q?PlbkVhoYfy9UfJaC+0mw+qsuSufPn7LCAJRSyvit2x6YPTmS+7Je9EDty8K6?=
 =?us-ascii?Q?vui8ktNtxnuwZQ7odxmdFI07Ja0pUDog5eHViOy/hCV3hrljsDqtupd9lAPA?=
 =?us-ascii?Q?L5lGruSDRLbzt5DXvXZWB4sPr8QQUS6xbZzEg68LrPbBFsTHP6hUEqjZf1VX?=
 =?us-ascii?Q?4WUBN1nbZTzI19VwhhfOhs79BstNmLG/BsgDpJjnMQ3Yc/4yPwh+Vbs7QOtY?=
 =?us-ascii?Q?eKQTUH6SFMJzsp7kD6UNn/dJJL/9h003rywr1HFhewnfh/e/Hi/02oUsPxUF?=
 =?us-ascii?Q?OGaNSUF0IGgzYHk8mA+VXGxYsEEyOWgexR0xt0SuiWdM81efkE7zGUZn4xJz?=
 =?us-ascii?Q?i+4OoscJ87kEnxe/UrN+B0OHmyxEOq27CMW/fACj90iNXCEumglbYuD88qrr?=
 =?us-ascii?Q?QKJXpxdi5eB4ofyXYmjjWIh972UtqOMLvN/x9MppGhDQgRToNaz+WgjxAftP?=
 =?us-ascii?Q?QRvQMWojaP4FNntg1gEnQ5WX1iNj4FgLJOdaKpdte8wU3cu0j9RkSJwFWaH3?=
 =?us-ascii?Q?WE0k1sS8o858yEGuaoLTAn2CYeFKfvtHEpDy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(30052699003)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:53.7510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d48bab6-a870-4442-5da9-08dd7c2e2df9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7B4E3DFF8
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

From: Automatic Promotion <dal_dtn@amd.com>

Summary:

* Implement HDMI Read request
* RMCM and MCM 3DLUT support
* Enable urgent latency adjustment on DCN35
* Enable phy-ssc reduction by default

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 04b1c7b331a6..a5592558fa7e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.328"
+#define DC_VER "3.2.329"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1

