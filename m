Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B216EC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 16:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607C510EAD4;
	Fri, 21 Feb 2025 16:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gedJCqYW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7EAB10EAD4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 16:02:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faltCxmRMYZuxj0y7VYahZdkI2QXB8Z6FuFqzb7Ubbi89083ee6Xli421QNK1GNQE0bn9Rf9Z7TXixyZ/Lypn4rfe0OfWcu3AQ3MYPYy5D6vQ+K2zZuhbrZ1U0+qAWXrOTkDt7cenwoWGaqgpA0273ZUkJu2fCm36P53fm/cDlgcpj6sT8Sega1ILI/fAWhSN7KiQwodZcyYTBbmNKdo/rR5Gm9XYzCN/fW87aYUjkQlmksZsBwsq+0omc2yRmSdqFZubJcBDPFdkuaXAgCcMx4i5nMYEae6TooeAnQrE0c7GO/kkXGNCfrOtMLahQkcy6GQ1lUMrvW3sbWiMadv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlm9Ji92P0mOSurXHseoOAGLeVWWIgw0pJ1LR88rhTc=;
 b=pWhLWNCFz3S7kjQqCptMpQ4/11hr90P40XY5JecPB7zgjzgg4DOoVxRhtrKeSFNEfE29oZNVh1xh2fz8uPb4iVkd11M+f14GxgGgsp1brBEqdPGuJaDp6GGvx1HyTgLNZ5NfQa0vw56s+3Qu84tkX9JmkvvY2YKtjTEk2HVbJ82XaCc+Wl+YBBTGijwAGlYoZbVEYGs256DWUJFau6JtcEyWv8l/zsY8IlnhWcplixiwysfy7sxABCmxMXsKqu2J2Y3okxw5q8X9FYepcEj2zBMWricmHqrjSzCPC5geA/3k/3K988nAZsj+2PyS8VjchxM8F61xzJjEqA4hiSc4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlm9Ji92P0mOSurXHseoOAGLeVWWIgw0pJ1LR88rhTc=;
 b=gedJCqYWGLxCvuA9jqeXQBV1JVLhxwBRXKfn7r+L1Co8OUhnkPWAToV+Wq0X3y26kEHtbQ6q9Il1uJG86r6Zc350lBn7R02yjhjrnATLLmvesEDuFekNrYPvJUcGFEwnxeItrhmhstPiKaa07h3mwtTW6fjjEigdqooicJeIfIc=
Received: from PH7PR17CA0055.namprd17.prod.outlook.com (2603:10b6:510:325::16)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:02:09 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::1c) by PH7PR17CA0055.outlook.office365.com
 (2603:10b6:510:325::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 16:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 16:02:08 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 10:02:03 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 03/24] drm/amd/display: update incorrect cursor buffer size
Date: Fri, 21 Feb 2025 11:01:24 -0500
Message-ID: <20250221160145.1730752-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
References: <20250221160145.1730752-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d5956c-09b0-46c1-a3b2-08dd52911872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qwztU455kaFBYsdLX2/1CTRT+d0XLErwfOWFGKJIabWRmdgiDA5LSVGfM0Zs?=
 =?us-ascii?Q?+fRr2oXLNatTx0bXE1HoPoip1LFuBpJVKKzCQJq+FZV5dAjsqKbYungXhqgB?=
 =?us-ascii?Q?VgqKG0W8sdxp7/mnY4JOYNSeCds6W0VUancwn/5ucb3EX3H9wIuzhxQsXcvt?=
 =?us-ascii?Q?4hTmmqSuNtLujqWVp8fM3OW62cxYU1lEs/aZYE+tD7QsGg3mFvgOKogmQSO7?=
 =?us-ascii?Q?8SO7MorOqkUYCz5IEpzGEHIw9PQFwcoZm0CBGtkUAJXuGyFk572/8knrfHpZ?=
 =?us-ascii?Q?6eaBXtrBy0dkM1c7DKGGj+wrqjcNZDVVkBIhsQueJsCN7zvnmp8ADKXzakfK?=
 =?us-ascii?Q?R2rVjLwLTYMQkYoROC9utFv7nqfhKutQit2ZoQSOiYnlwRAr1JtvionE3v6Q?=
 =?us-ascii?Q?+9nL13VajUp6pfOAZWe7wXACC+Ep7LSHIpfItmfLbY5PDejS+pS7tahqdM14?=
 =?us-ascii?Q?0/NFvZGLs9Sca/EWksFmbsksPk53Gc79yqxV/7i+UiK3NZTe2tBmohB4fjdk?=
 =?us-ascii?Q?nfTzTRuDUDBpTs/WToqQKiKPKGuzT2OurpFvM/DTtTUqtM5o1eaTsa/nLTOS?=
 =?us-ascii?Q?ORwxZneGa1ihtLlrbsz3befLlVahpAfeQ+jsYfXfR5LYWk8NFVtArWh+32cW?=
 =?us-ascii?Q?Jg76hKZ7ZqATp73nkcMCvuUZidWCekHTg4EseJAXBmc09KN1Z1r/0sKyk+s6?=
 =?us-ascii?Q?+aQcH/9tq/9OO5MnY7c6diR+rX+W/ssWsKhSGX93LnxrYpHx16rfno3osyD1?=
 =?us-ascii?Q?5IBq9nPANSwy1+n/P4StQN05Heawla/mrZj/+R5j1iISqkPiV7oAWVHLnTnb?=
 =?us-ascii?Q?HpHJiOYPRrnCPWgXa4BQNwtkX0LnZO1B/ws3vGGmC+93AF69XcRD1u6Nt2IB?=
 =?us-ascii?Q?eeBscnMVLRrO/NRhyDVjX8WH4j6hLQIOaB7Lsl/1MJNcaxRBxhxLDZSS6kGh?=
 =?us-ascii?Q?RZVjT41sUmsZDu39f/7jL0f/YvHJjhhMQ536PY0JUw6jvdq/c4G3CJhu/P56?=
 =?us-ascii?Q?WoU+ZidgmtrxRlYNkOmSjQfrxclG9fQlcALyQjTnSddaRM/x4QFPFJzWS0r6?=
 =?us-ascii?Q?Plza1oKhQ+K6HBXNvdbCIQUsVVLcUJ/DSgBtLcIUzsvnfIaSAydccx4zVYs9?=
 =?us-ascii?Q?WxxOEXUeBuPjOktbMI3Ej8E1A7WAXdGNsPXpDbSsvpjCxxt9eH3WUdK/Jl7r?=
 =?us-ascii?Q?r/SDPycv2sHJkECQCQySogQ3yEWMZl9mgW2Dw78KHx1b/dMLQv5ImR/3ZVIC?=
 =?us-ascii?Q?DbT5XtG/GkcVvbTqK69J67FIwHmsLEPFFlPMPaHKvMI+eGlAfETYn02Y0WeE?=
 =?us-ascii?Q?9ukwtY3431Hg6bDFxmwIrG47EAgLXrEDo9xNdw+TbcCGcKf9KfobSpX40IHi?=
 =?us-ascii?Q?4CCXFpVROoSJ3HmfveJC51jmY0+DQDq3Q7p6nfaJ7MJ8+3PFAS0TDqTA61sc?=
 =?us-ascii?Q?rD+WYWbwHNhi6YyLKkik9DiBzf7VlCzhTsCj/2lEBFf1fT4TAS7GFe+HvQs/?=
 =?us-ascii?Q?+kuguL4Y+XJVJ90=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:02:08.8817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d5956c-09b0-46c1-a3b2-08dd52911872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
Fix the incorrect value of the cursor_buffer_size.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 3664980d1574..1020799a72ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -44,7 +44,7 @@ struct dml2_core_ip_params core_dcn4_ip_caps_base = {
 	.dppclk_delay_scl_lb_only = 16,
 	.dppclk_delay_cnvc_formatter = 28,
 	.dppclk_delay_cnvc_cursor = 6,
-	.cursor_buffer_size = 42,
+	.cursor_buffer_size = 24,
 	.cursor_chunk_size = 2,
 	.dispclk_delay_subtotal = 125,
 	.max_inter_dcn_tile_repeaters = 8,
-- 
2.34.1

