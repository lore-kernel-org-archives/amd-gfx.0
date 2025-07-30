Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35148C87FCC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE9B10E45D;
	Wed, 30 Jul 2025 19:00:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KF9q5B8n";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FAD610E45D
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:00:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjRA8OPl/A7+XiUTTNCRcwFm2BZ0y777cUW7qIp3bOpWP0Yo0ruU7IAjSW98KqxxmV4zESEBTPBovnr4aGER3o4brPWCDEXof8ZnJEjgiR4wtKdF5RSq93rslN72dkMceCTjvXgw2WFcrHP6naPs59JdM4EqpQRJY47a7fDyNHJdGsPd7plKtcbTWWwSQy0gnSMKD02bfe1g/AAzJV/CMdAo3ai5axwE3yUQURi6geyiI+cWECUfJqLmFjNZGcSEdFT4HDu3gw9l90Ybmptgb8olXCFWdDyisXJPGt9b134dPGrY2CRkaP3l34MB8nxHvENehVBTa1sbJOuxe9XtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urBLP3qwATKlCtYFuQJp+BuPEYSEIUTw8D+8RH4TX9U=;
 b=ltHdryyJMGPtL5/4ghJb/y7wb4HQ+i9gsSBSiTuu5NCsyFIPvqJqvB5vhpxQ/inMnyc0TMR1WoZbOLEf/p/YrL0Z1jVVUkM1+fB+UbzY/gk2a86EMWCMfrYFA22ze47HAkPvedQtdpaXrvx53GCO3XkZ6Cvo55Pmjun2TqyvIgnUMIkULY2DniY+RIsukc/3R20jDL9wLetHSB6O6K6jJoQ/bNuytufGDxSnIq/QK186/eM08C9MAtOgeXtvm0k+9IQIyhCV25Ef/YWDm/9Z+kg96p6xwl0DyyjMfLNSBSitzJSkR2Wa2YWB4aKanmkNf1j0EMWdGgdTFpO6r6FRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urBLP3qwATKlCtYFuQJp+BuPEYSEIUTw8D+8RH4TX9U=;
 b=KF9q5B8ncjqHdVldiV6DnNjrNBYxvUL9EzsSz5aUneJPL+/NfEtXSovRupY+DCEMHZhx6xiB4woJqHeiW9xWxshbfzIG1cS2mQz5avYsFKZPYZPPWY0bmP1Sj5gbiRs8JDT7J/YI/F9K3cSdnjnicmUOpn7vNWQObL0BjeJQoVI=
Received: from BN9PR03CA0196.namprd03.prod.outlook.com (2603:10b6:408:f9::21)
 by MW4PR12MB7438.namprd12.prod.outlook.com (2603:10b6:303:219::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 19:00:49 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::27) by BN9PR03CA0196.outlook.office365.com
 (2603:10b6:408:f9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.12 via Frontend Transport; Wed,
 30 Jul 2025 19:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:00:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:41 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:00:41 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Siyang Liu <Security@tencent.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 01/12] drm/amd/display: fix a Null pointer dereference
 vulnerability
Date: Wed, 30 Jul 2025 14:58:52 -0400
Message-ID: <20250730185903.1023256-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730185903.1023256-1-Roman.Li@amd.com>
References: <20250730185903.1023256-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|MW4PR12MB7438:EE_
X-MS-Office365-Filtering-Correlation-Id: 53e1fba2-cde5-49e7-ee78-08ddcf9b6572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J7O3bmta+jQtQY6gE3GqYBURM86W8t4t7kobf7jP//MpPmMLcGFumjKjGDgi?=
 =?us-ascii?Q?g69DboneFjFUZE71PjWi1RURcHOrWxF4mJXhQWDq69gxx4B4n1kqjCyI0tUF?=
 =?us-ascii?Q?jQg8mwav6Mk5yplaXYfywoiLCF3DtXwrcQAFWLN+I+1oEkw/tZQZtnCjVTLC?=
 =?us-ascii?Q?bghjtyG5n/Hvi4vQL8XXOgyqi8wx5kUJHJf8UsG8Y6owsUpF+BBOv41C2Nm4?=
 =?us-ascii?Q?jgDuen2vKkg3wpIbHr+kynkCk8XhK8Ys9M3oylq/lazE/gfXQjnHtf/EJZRW?=
 =?us-ascii?Q?iESSJZBjWqvT+woZHoyt7UbdLC7ws4Be2F2ACN7uowRSIoPf+gRXnFwl+kI4?=
 =?us-ascii?Q?10F3BhLJQoYvPOH2FSzsAhwHmDEybpQX81y30tZht7CefUty4k36DFZIVGnQ?=
 =?us-ascii?Q?O/GZ3/ufgd2tOj28jikPO9tH/3a9gZG4OSkBjHNuafLR2aTZltrS+F2DiKdi?=
 =?us-ascii?Q?ad0w1QcS4A+ew/Oqp2ZDhXsFHro5TP9yKF54EoAKqrPu4I8ak0OdTjZUAl52?=
 =?us-ascii?Q?qQikJFkqnz2E0WWF+jdiiQmeph3wT+bzt/FKmJegH1990VX9reGa9STmk72v?=
 =?us-ascii?Q?pilM1X/gCmEpyGBQB5PMQIGoLgF+Z0NRbgLT0DFDRASaFpbMlDfqtNzkDnYD?=
 =?us-ascii?Q?ek09JA7P2hY+MiEQL1i+W2WajAHWdYBU9eP/4h9ZcBkljPlMP8gc+TLzW2HC?=
 =?us-ascii?Q?s90k9mPagJBWPPfwDVwLyxKoTcgtOZHTsQDx1Yy/m+XXTVAqe+Tl1wydXAF5?=
 =?us-ascii?Q?TwXvQy+KFdVaJlfIBkJoYljjY9li6FGQBuJvb38uqzoMSH+XZv9Mr664BZY8?=
 =?us-ascii?Q?Xs28wB/Pn219hcsUDURxihD3uNNc48oY0/lMpJxMgK5Mw6O8GuyOSegXcDPz?=
 =?us-ascii?Q?zVziZ67P8J5AWHXr6xIwfSFiC2xZvR5Uh0dLaMf8z43oaBr5+0quEmFQ6GHB?=
 =?us-ascii?Q?PaVbEbXI2GeoND/kbZnF4PhwCaR4kjansmQRNca/Cv6VGDQCzFsUiAMespQe?=
 =?us-ascii?Q?iODW32g4m2/zoyup3o7CWdApKaeqP/W8H+F4u+EhI0d9/qOILyYJlsmjiZtU?=
 =?us-ascii?Q?/UWuCcDagVUnypHMT2eYlp9RYMYbNBpvRdSR0p26yuOSBsuJ6O0sBpKeDyrC?=
 =?us-ascii?Q?aCdcXkBMeuQlO7OtdMRXXBMqLGT39/BEVLIYV88Bz01LL7g7O+xmE+L1FFeO?=
 =?us-ascii?Q?mIWqPGngJTXEptkZmDRV1NCy2akEdxB2N/6WQ5/M+0/Jy7TS2Ait7Mo3qnP9?=
 =?us-ascii?Q?l60dDTFx6xxxqBIgSdks9ImnGDD1LH9lRg69GfoBycKjnifqC3rGICyffs4L?=
 =?us-ascii?Q?4KXbH9PvofC7fAOYbpKfcf3mDSZeLxsuDpkJBgBLTpaiyf4XqXrZtTX6GwNl?=
 =?us-ascii?Q?vd6H0CAhkwO6L8FU2U+g88Bz3u+6IHLeezWM4wbsKqopeArYe6KoQ4UtHGKo?=
 =?us-ascii?Q?7dYrZnNK+yI+YTcuQQOaD91fLfJPglpNpm0tDxhx+7zP7AIzBVr1qNYbBNnN?=
 =?us-ascii?Q?gcsPn+VQylZFZBdsu9/m8hQCycuOuAftngFbOjO2U7MUQ/+vwbgaQx+nhQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:00:48.4950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e1fba2-cde5-49e7-ee78-08ddcf9b6572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
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

From: Siyang Liu <Security@tencent.com>

[Why]
A null pointer dereference vulnerability exists in the AMD display driver's
(DC module) cleanup function dc_destruct().
When display control context (dc->ctx) construction fails
(due to memory allocation failure), this pointer remains NULL.
During subsequent error handling when dc_destruct() is called,
there's no NULL check before dereferencing the perf_trace member
(dc->ctx->perf_trace), causing a kernel null pointer dereference crash.

[How]
Check if dc->ctx is non-NULL before dereferencing.

Link: https://lore.kernel.org/r/tencent_54FF4252EDFB6533090A491A25EEF3EDBF06@qq.com
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
(Updated commit text and removed unnecessary error message)
Signed-off-by: Siyang Liu <Security@tencent.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cf3893a2f8ce..e42cc37eae11 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -940,17 +940,18 @@ static void dc_destruct(struct dc *dc)
 	if (dc->link_srv)
 		link_destroy_link_service(&dc->link_srv);
 
-	if (dc->ctx->gpio_service)
-		dal_gpio_service_destroy(&dc->ctx->gpio_service);
+	if (dc->ctx) {
+		if (dc->ctx->gpio_service)
+			dal_gpio_service_destroy(&dc->ctx->gpio_service);
 
-	if (dc->ctx->created_bios)
-		dal_bios_parser_destroy(&dc->ctx->dc_bios);
+		if (dc->ctx->created_bios)
+			dal_bios_parser_destroy(&dc->ctx->dc_bios);
+		kfree(dc->ctx->logger);
+		dc_perf_trace_destroy(&dc->ctx->perf_trace);
 
-	kfree(dc->ctx->logger);
-	dc_perf_trace_destroy(&dc->ctx->perf_trace);
-
-	kfree(dc->ctx);
-	dc->ctx = NULL;
+		kfree(dc->ctx);
+		dc->ctx = NULL;
+	}
 
 	kfree(dc->bw_vbios);
 	dc->bw_vbios = NULL;
-- 
2.34.1

