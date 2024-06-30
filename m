Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B82C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81AF710E1D2;
	Sun, 30 Jun 2024 14:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sg/48NSn";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC91C10E1D2
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWvska+hA5f787l6SxbG9Arl4yIF6yKdmr3sZFQHpIh1c/ydCC0ouxucLBLYJOLgbcLaX9ICD9CGQZhESlHK+knQFyQAunkyqCB3KahVPrTSiEoQqBrKWXU4McEJLkS/DSVWMrC6G4glpVBPLgTTAUV+nD9p6B8OCkeIq9vHYjMWLSSXHxpfOZGD429JTU3/1k7gxPO94fhOgwW2xVVDT1BPlKR62dvpwHJEBXr2kZaXFyoF8hYnAJkmBIPR04vwc1MLdGw0OXZLrTgDQ81eu8m7yQCfq9/dEcAZ3F7Z21eR0qTxVZb/rDJHXruthJWS2gzqOCgvhCaxpxz6tLjaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hyTU1L7OZecgTjlOFcq+whOwR8LzHlyNOd/LmeJiWE=;
 b=K6qTjReHHvm9Meim1dQmw2CwhOaWqPvY6+KKFD+bg4XIADMb7rIAORZAiJqwDv+zTMLyPsaWJbLEryCcB2h028hCLulOw8vOSqMTSTvawJ93m25n9IIcdnuI8CKScG9Y5oWEs1VfuhcBJI26XzSDUV38nzgiBjSEPByIrUjkDG2W7FRuYcYjEE0wLGHG8uICror6qLjkBioRbX0pz7+3IloA565GwU1hhGXkim2yMNz5nLOZQgi4BTGxJfTzRQrVTpYu5p0C9STeb3gMQXlZ3xbFC+a0uxMGB08x4I5GwDtA+um+KF7nuJlbfIyIfiC7svsPT7ucwzovzGQW8EL82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hyTU1L7OZecgTjlOFcq+whOwR8LzHlyNOd/LmeJiWE=;
 b=Sg/48NSnrfwi5u6QE1Qda89xLXM4zQqKwPEF6ByTz0QuOTD79LmHjptSKC4xYrQLnVLxqKQJOAc/aP/+OLFlFJVCJxMAGh97mvj9QkoBh0rQ5kxSnTT/iUnzHFv9K5rSIR9GR1XJ/aipPJBQoY8Lf/0StKgXOQ2UynaKhGpgWZs=
Received: from SN7PR04CA0238.namprd04.prod.outlook.com (2603:10b6:806:127::33)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:54:20 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::a6) by SN7PR04CA0238.outlook.office365.com
 (2603:10b6:806:127::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:54:19 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:54:17 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add firmware for VPE IP v6.1.3
Date: Sun, 30 Jun 2024 22:50:46 +0800
Message-ID: <20240630145046.2021348-3-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630145046.2021348-1-Tim.Huang@amd.com>
References: <20240630145046.2021348-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b330d4-5e10-47ac-eb77-08dc9914855b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tSHUiHhhvv1tFGY8zz7eyiP/OFNg8XfCzrLYEsO9mBAbsS/7tdN8PeejQAUI?=
 =?us-ascii?Q?FGcluXnxxKHpB9gyq9Q6S/IcKDsUK0JWwqe+O46yE5QMUMbi/z1lJ9fuKyJm?=
 =?us-ascii?Q?GVKSuntn214Md6sm1kaVK8lct2WcClX7wkSrsHZ+P5l1zQ5BA2tAC9bHC+4d?=
 =?us-ascii?Q?gsQnHPoUFFDSPB0bc/BrTYed+5BxqG3eQ0TJuSrZYs2AW6XUsKCe2ApAu/H7?=
 =?us-ascii?Q?JkouZrq2trcdNRVbrtD3aTSybrJXLUYi0Q0gpf9OfE8Mxyve8uYx1BEP751W?=
 =?us-ascii?Q?qGlDXC49DY1Sbo/RzO6fyfGNT2+nyKLesRTIvgdMNAUPRDv3nYqOOih8WPht?=
 =?us-ascii?Q?wDpOPCbOS0KDmZuXfX7doxrzLbs/W/lnRrjt2ye+W4u//F8cNkUFr0teBD4d?=
 =?us-ascii?Q?mD9pVSOCqw7Mts7cBvyTs3FuE7YTw02bhZr7gYO8lIiwR7J6X24X6S43areD?=
 =?us-ascii?Q?9qz5ogIx14BomFG1B71wWDibrXIewTOfAs6w7v8+3JcXLkyuL0PIapdSJw73?=
 =?us-ascii?Q?1hU8qt14OSQvA8+uZaVLZF0IwlSaZKeDS/2JmkKIb8rVX+DN/9nAfrMUwU2K?=
 =?us-ascii?Q?zLAzSFjC7gujxRluNDSpuS6gP5aupug8710Y2cW0IgYJ1a8eJ+UtTplGOGaX?=
 =?us-ascii?Q?1JWHluWae6qDNOjWEdlmqLQp1aGi7MxZpoU68iD+3iAeW0lmPgRMWbkm90wD?=
 =?us-ascii?Q?pc48VSm698HMztkASnaZGD87UgnkA6vbG3Pc8Y67QLVhAriIEgNzLLFMtnOG?=
 =?us-ascii?Q?ofH9cv5YdfklRnanSaDy5sS434Pq1sBuM1qHjP7+mAJ3Gz42sPSADjlIxJiu?=
 =?us-ascii?Q?l+uEBJq5CvJfyh4YnGwUAoMJVamrEqieNKXm3qR/AST2spGzOhV4mBflC92X?=
 =?us-ascii?Q?NIKIHadT4D6KgFWPRatn9YIMQdNeBCOHhiLojxbKQACFs64X0VsXN8+BgxAf?=
 =?us-ascii?Q?GqMxj1smpb8euiaHANwg98BmlXdUWISzr4vvuO/zi6vMAqzo4fZYQoyfSBUe?=
 =?us-ascii?Q?EVbBCBoAGohIwoz6MTi/Faz3FVXwuGEzcJyJVOTxPlhQWsAbIFIcUI8hBGqD?=
 =?us-ascii?Q?lTYrqmljS+NO/c9p2B6HKbgzKvz6r7VxohJM4lmEbEBMggGl3VpZ8i9Eq1ij?=
 =?us-ascii?Q?IvaYpP3pg5sanpRCj2SzSsOF1j584gDG1FKc+jTBion0GwZmjN6zk5NKJJRe?=
 =?us-ascii?Q?Cm+i+kEqZy7W60PYIXwvk7iMhXOjjIZJmO/5WSBWooTMqhE9Kk7L3ill63CF?=
 =?us-ascii?Q?Dh2wG9Pzv59zJq5SmTuK4o4wV+oabv/6XL+rb6loHgL62gzDxoj3ZhPHt0Oo?=
 =?us-ascii?Q?A3nixTpRh6x3ajitbi2HoGBwTuN247/iwOm76UcEn2tBU37qDv7gf2EMtX/R?=
 =?us-ascii?Q?SMTNpcZkP0G5qMuGgFzgXLPiJcKv+MwScU6IyO3ZtOsewij53aV67AOiwg4e?=
 =?us-ascii?Q?7WV6tjYkV/j7b/jw62AQsLiHJmdNSdf7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:54:19.4619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b330d4-5e10-47ac-eb77-08dc9914855b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666
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

This patch is to add firmware for VPE 6.1.3.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
index 09315dd5a1ec..45876883bbf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -34,6 +34,7 @@
 
 MODULE_FIRMWARE("amdgpu/vpe_6_1_0.bin");
 MODULE_FIRMWARE("amdgpu/vpe_6_1_1.bin");
+MODULE_FIRMWARE("amdgpu/vpe_6_1_3.bin");
 
 #define VPE_THREAD1_UCODE_OFFSET	0x8000
 
-- 
2.43.0

