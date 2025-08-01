Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD322C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7328810E3B4;
	Fri,  1 Aug 2025 06:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukJY1lHM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9962110E3B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+F6xiLZFAtOoSh/aqxAIeXggUHasH0e7dxNRbL7bHYmRWQ0IhpweI0Y7Vv7jrV4VosdtRPT8plF7yr3CTrpDaUFIXATHZxgOSgYdyqmUXalaEPs1xaeeE5SHcNNUByefPC2GM6FXiF8x+sPOvyionTMsZn+2RnqkE5vXs5pKTJ9E/vjW+ctmf41rDBFPmsCI7TEJs1PxLbPbCloDnpzxQDisWNHSES6ND4cqask+J49axP1VOPPyfH02U0i/irsF2Zfd9yD64IgrFbuOdKMa8Kxhi0z+pOpGDDwweNMuxb0yfZXBR0uUKc8z/YYFA+1WKDJa7DaWLx8wFNodzQ1Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pej3UKJj10mWlPnGVla0XM2GxYhDp4qa+GrJDjEg/wg=;
 b=whMCD4MO81IKLN1zziQYgFazwybnaRq8BzZFtoCn5HnBNQQE4O4LbHPGJ0SIHvC58Y7LgFcsCmxDrVOPCBjpqdWJmNbnmJSeKivVCc4MvtCZ/ZhJ8dJjuQbF12AS553f0GYdrEWvO6xVq2J5713ARbF6enKbcFzyo9GqtDiIyo9J522o0JsPWGqxeK6FJ4LBrHL9Pg2PNwFOwKT0vDGwIcGdnyHarv5vtr+MQ6vytAYynCwpcn7Zi02h5q251WGYJWmW3jsDPIb3IGONCGOJA0r/mOvqB/AnelWuHq8w8EJVZSiWoSTzZHQQIaSCl3EPB1KKrV3z5AHFnekAOAGwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pej3UKJj10mWlPnGVla0XM2GxYhDp4qa+GrJDjEg/wg=;
 b=ukJY1lHMzA7f52gtHNMmFRX4riRxtiULju32P2edFY3wVgTWJDOhM1fKgqBnbx8Kj/EJ0JAutsYFBYONFdroMt0k4A0pd72iYrvm3gkeGH7TVXf/cZRdXKC4KZDxiv018BAcwBCu5zt4eyzdwW7OlMZZt9iwy1U4w7VJgSlQgWU=
Received: from BN0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:408:ee::29)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 06:26:25 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::95) by BN0PR04CA0024.outlook.office365.com
 (2603:10b6:408:ee::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 06:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:24 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:26:18 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 07/12] drm/amd: Add preempt and restore callbacks to userq funcs
Date: Fri, 1 Aug 2025 14:21:05 +0800
Message-ID: <20250801062547.4085580-7-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Alexander.Deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: f810c32e-80b2-42ab-5e5c-08ddd0c4573a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JxnmB7abX+Iqt8OhgErti1LWododfazsdGXB6GbhhEtpKhlUM3oUIlhnPhKx?=
 =?us-ascii?Q?cFGNa/e+sYb1Df1ZQ53m88WbqdsMQUFbHQ6/NazJ9O+7hPnBkRiMUMvrggQs?=
 =?us-ascii?Q?rCSA0w8dCblFpKsz9iOR3QgWnkHgqu7llFvEcJt2VWJe/O871ydsP/WRWnJy?=
 =?us-ascii?Q?T5Lqu2IxsKuA+6YUKzFjLgaE9JEq3OLapN/4GhPvORueFRby6DXTrlWKtOyu?=
 =?us-ascii?Q?SuJiEqamS5urTzj6S/pVj8mJS/CFGxOAK+NAMlUR0WktPWHJTY20LJMgwfa8?=
 =?us-ascii?Q?xj7iABPNKWKYAFO+7KkXHER8UUoSW5rI+mdeaL+bMq37V3XK3uG5AhqmiDA7?=
 =?us-ascii?Q?bVBFL7xQ1G0qRV/4bZRA07q0b7Oh/BZqK+a5iOdpe++wLV/4s2I/zJLDjMvH?=
 =?us-ascii?Q?s5xy154NbQcR+UbnUNLl65lB4NI5IAwkdYSO8M5E23Ws0H1D7ggz7ZYiMCWU?=
 =?us-ascii?Q?xpk080EagFtIs7QozPZu5zMyBbKPw1s2DfEcy9LILBzmKO7J4i0klPLqoYSI?=
 =?us-ascii?Q?lYXalaa4hUrUpA1xBxbTrCo5hSOfZ6FzUDWtsnWRrJbYZBRoGSq3SwzeH6sJ?=
 =?us-ascii?Q?2THsiMmBZkhGkkdnv6XmEIn1yjq7cZfgNRZXlgwJB6k7P91LLeZzpuJCls63?=
 =?us-ascii?Q?t0aUHrNR8ndtqshDnngRtsUxpRek/8QeUjalUlmDig0oYdpJnOH1htvSSS5x?=
 =?us-ascii?Q?QS4KyGqfy7317QihnVfxXRQnEJ15MDFSYDUV/uVGb1/hA2CjdUK1mh3rthHH?=
 =?us-ascii?Q?ENCJJ3e1rTQL0R15bbn9/49Uv8NtL/Dte4vc7ih+YttJT4hMo/E7usV7fDYp?=
 =?us-ascii?Q?xJJxF3PL4fJc5sJd4BtU09m+DH590HeuHQO4RZ0bysqXeq2HdQSy6/lQo21S?=
 =?us-ascii?Q?l1T0899bhLOhvtSZRb4YNdqT6AWdgdXpk56jver3AIaQOsuVaF7mLlBi8iz6?=
 =?us-ascii?Q?hL4uoZzrwcfME3AQlmaWjaYhRKB0P9RBJEsscGiV6pBAzFA3tMZ45d3iB6gB?=
 =?us-ascii?Q?A5C/dW489erxPKzmLauYY2FVg2ooxrOHFtItLUW3/lynFrpLjyenaKRqukO/?=
 =?us-ascii?Q?uzmSzbHWbTt25lAHIliCRzX3qb93jOYvXaipa2FXSrQ2/h1SKZ3hzy8STDYd?=
 =?us-ascii?Q?kffl1oKS49Us37lV0gJ+g4SXdYkVZNJI+q4ZDC14oJypUdq8vmFJD7RXSGZ+?=
 =?us-ascii?Q?+BGl2jltBwNqNf61uFAlAGtOn6tSf7rxp091yvRdELqORHh9b6RnEF34BAhJ?=
 =?us-ascii?Q?7YLqXlCFGQn0eBlLHSZyboqU5B8H2d2pP+7QeuXke/JRtRgDCHRQCwL4kPxp?=
 =?us-ascii?Q?eiy4pA3kRoo5wzF9Z+U1IuNYtieKQ3XMqVWKLPQJxJCY0DvLI2nS7A4je359?=
 =?us-ascii?Q?k1rIqPbN5W77OgY31TnadSLnI+HAQMzQ2tMKh1nZmKkp8uhStJpQCrpiJsAg?=
 =?us-ascii?Q?hgO57grhn7R6tisvsi/NiaCU3S6th1IrpnkqUO2aohwF4Qh64FZHgxlW8pAX?=
 =?us-ascii?Q?7GYgtXETYEyZTW/Vgk/g/lZFZuhsDG4Pg35q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:25.1620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f810c32e-80b2-42ab-5e5c-08ddd0c4573a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 0335ff03f65f..68e46d01bed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 	int (*detect_and_reset)(struct amdgpu_device *adev,
 				int queue_type);
 
-- 
2.49.0

