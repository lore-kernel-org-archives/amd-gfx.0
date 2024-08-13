Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F26C52D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 18:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8516410E3D7;
	Tue, 13 Aug 2024 18:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XIdBUdkm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC6210E3D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 18:57:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJEC8HIHwo8vrS4+DOTfjpepB1SvbuALP9imOkwtnwV8ZoqqhfJdUZPJ8dW8+zSVeAoMYTrRpKdlaX5N8YFaYrCB4YBJlICAxtMIN8NqVrdruorwAiP3sRGoCCie0C4W/5zb5MekkZ+CtPAGHiHN4Z0a7S0xQ6UdOPH5rv6jzU8H0ozB15SrIyGGjegeTVIH3np+PuKgXtd9yXEd9jJk1jVaPENOgvQEEosQ+M3f5J/Wt+IbVGJxoMF8914PEzdwSFYSsQ6AC2+xQau2F5WNEmpP6ZmPkdgpZ0uM4Pb989VEtO1IriFfxzQK0THFrDF1sHzLR9aZACyhYHAJInIcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBQPfJaomDvVBmyg8nWobPeLeNAbfUGoVWsNOrJ+sTU=;
 b=hBhuwRrH6xnAB6x/IjH0h0jq1nPvfDTf6tWo152EUNwHBDvDViZIMlSXY5tLS3YxV9EjXkqAqBvTZi5QpWVhgdLhSpPJVY8WCpyN0DXZaUfa/yzebtt/I3juvYg6kgKVePodSpv9VUXdonWEj9Pm3EJhYFLdeNItzSmyWbwbAaZxIAiL/CkUHFF9MIe/tTyOsuJfQIlTZX2SE4zFC335OO4FIwGYXLERfs5iT4y3HT1prjM+y405OH70jC2bosASxJ6dnufCkZrE48RuKhoVPsktLECu+MX2BoddGb8OFowLWud5QQRqkiat0DqD1DNCggwonImiBiAKH3+oBWWwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBQPfJaomDvVBmyg8nWobPeLeNAbfUGoVWsNOrJ+sTU=;
 b=XIdBUdkmOZQ5dEu7NZbYYrDUflL8Fi4MhgpXKWCqr6syBecNba09nyizTYkqPCxoHvlGpzwEbk88heAzLILX+yC2l1sbXBIJu5VWpFe5ilOsPATaiDZHy8LNnc5zG5uJMIuXhc8LwKPyiMB808eR0DIdP9aH+HyFi/4NablYxhQ=
Received: from CY8PR11CA0018.namprd11.prod.outlook.com (2603:10b6:930:48::7)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 18:57:24 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::31) by CY8PR11CA0018.outlook.office365.com
 (2603:10b6:930:48::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Tue, 13 Aug 2024 18:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 13 Aug 2024 18:57:24 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 Aug
 2024 13:57:23 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs for
 GFX11
Date: Tue, 13 Aug 2024 14:57:11 -0400
Message-ID: <20240813185713.942012-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b36f5de-ffb9-4f02-401a-08dcbbc9c4f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9FQOmWZAm4nRsIXXBQ175clBbj5mq0u5Z2BxHO+ci3BPeOpP3yArZZfAA8u9?=
 =?us-ascii?Q?mwm30Germ4hB/ANxffzxx+CC1ZhC/lo0YvcLYHAu5vFtNwTgLm61h+CNIfF1?=
 =?us-ascii?Q?TIc4YV7G80eQXg6xAnLBTDr7OzddxwoucpVfl4N4azXFyBdSV5Q6PpdciKov?=
 =?us-ascii?Q?i0RTCmmQlOv1SFyVVKXy54fUifcFifJpqeClv95tnoB2TnQcrywu3AQSdpbp?=
 =?us-ascii?Q?MSyy2QMv6TEbOoGBa4rrNPzNZQUHtZm95BUth/O07PVY7qUYdLbTt/W8Ygmf?=
 =?us-ascii?Q?LpUBGcSssTcVNXWHGckP+pMDyCK3Sw2UoIKlGSgElAQU24GbvYHmY4xAjF2l?=
 =?us-ascii?Q?yCcf8/qCzpHpD21qpIHBq314nB3yB8q8cehQz2+2CNnEZaUFNuWawDBvcBlv?=
 =?us-ascii?Q?ZJiqMnUuVNLCn9r0ca42bGEP/DIWNK8WQ786ybAwY2OkciJKIMWk4YdqqORa?=
 =?us-ascii?Q?8zYsEP27YAbbqSzv+uokTzgTxBU81ysP1o/PD7HgLb2apoLVjGOv8x7E0f8Y?=
 =?us-ascii?Q?yGhhMMQfCfRWUtnx8JYFAc1zlGg+HUx6h9y80THOU0+bdoG5tp4fg54klx+X?=
 =?us-ascii?Q?ACpQeBJYSedzGL88G+EhAXli3ScTSZB/iCFHtAh9DjizpAtFE/2dA8rmBST5?=
 =?us-ascii?Q?jP0TwuXY2JdemK/TUSQrmq+cFHLKkb+PBkz0U0LnKpKN9bi3NWXgNqszrQZi?=
 =?us-ascii?Q?QlUN8UuhbHEVO9nugT2xG4Cp6wdp/x9C3ZwGbwTiJq8nKrQKWh2nUnFcasAC?=
 =?us-ascii?Q?+664wELtlxuj8Bz7gRkJBW9rogzsZcs//DFSY1lKUxDycheZ7xJObMYo82YT?=
 =?us-ascii?Q?xWBmsXI9d9XEaUu1tpj8bMgMFGA24YRmIUSquajadhLFBbMJL0jGQLlpCg6n?=
 =?us-ascii?Q?PqvRk+zFLxqbENXG21YH52Ie5t8H07KReISLJ3g22EY5YJsEaxDuBkAoIdSW?=
 =?us-ascii?Q?ynceBCh8EYufOjc6zkErlW247JMC4qa3yBT4T9T1UFqXsoIPTiqsJqD1d2hi?=
 =?us-ascii?Q?uKrbNbDTIlql5mr/bWCIBlFLAxY2cGIk+PXVkAwTtGOYAm0Rag3nSLboGv2H?=
 =?us-ascii?Q?n7QFZkGekACElyPxPcIq8qwKSsSGnaqdqk5IFznoZ+pmDu8QWev9l4/Q/Vnf?=
 =?us-ascii?Q?uQK+XWM7GKLyltjdDPfVSPLtjRYWSpAZMfZVvuFYMJy+LUqQuJyOANWKZc+M?=
 =?us-ascii?Q?KmZNVA+x2OEXsnXrAhEkSp1O29Dc5B/qopaYli3uWvB06Q1qasfx5w4YhGcu?=
 =?us-ascii?Q?9bwX1rqYCG4GguabQu5dtkSiIVN5kcaghFti4O6SI/8NZWmTxxOl/OPcyLIa?=
 =?us-ascii?Q?2t+t8qC12ylWiihvXakr+wO3fg0JyzdyxxDWWSlOdfW1F7PrkNauozPbzNbY?=
 =?us-ascii?Q?HPnNOEYYTQQbGXdbkcrPLaDGlZttLiZ6PJLw//5YlIeNtlPKDA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 18:57:24.5014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b36f5de-ffb9-4f02-401a-08dcbbc9c4f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
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

Add implementation for MES Suspend and Resume APIs to unmap/map
all queues for GFX11. Support or GFX12 will be added when the
corresponding firmware support is in place.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index c0340ee3dec0..a5c582674db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -421,13 +421,41 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu_mes *mes,
 static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
 				  struct mes_suspend_gang_input *input)
 {
-	return 0;
+	union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+	memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+	mes_suspend_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_suspend_gang_pkt.header.opcode = MES_SCH_API_SUSPEND;
+	mes_suspend_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_suspend_gang_pkt.suspend_all_gangs = input->suspend_all_gangs;
+	mes_suspend_gang_pkt.gang_context_addr = input->gang_context_addr;
+	mes_suspend_gang_pkt.suspend_fence_addr = input->suspend_fence_addr;
+	mes_suspend_gang_pkt.suspend_fence_value = input->suspend_fence_value;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt),
+			offsetof(union MESAPI__SUSPEND, api_status));
 }
 
 static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
 				 struct mes_resume_gang_input *input)
 {
-	return 0;
+	union MESAPI__RESUME mes_resume_gang_pkt;
+
+	memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+	mes_resume_gang_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_resume_gang_pkt.header.opcode = MES_SCH_API_RESUME;
+	mes_resume_gang_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_resume_gang_pkt.resume_all_gangs = input->resume_all_gangs;
+	mes_resume_gang_pkt.gang_context_addr = input->gang_context_addr;
+
+	return mes_v11_0_submit_pkt_and_poll_completion(mes,
+			&mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+			offsetof(union MESAPI__RESUME, api_status));
 }
 
 static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
-- 
2.35.1

