Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2410DC0219B
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 22:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462A010E97B;
	Thu,  6 Feb 2025 22:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y9mp1a2W";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B475910E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 21:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVAIHHnnRZ2uJK3v8Cjsaq+gpac9VDxeWzpCsaR2XsIcbMu0Bt6uvZdg9kkEdF5xPU9j5gZq7cd8WG6dpIGF+N4kuS+MlcUouOxGBKdZytTRS5yi20ffKjahRpJ4j73hHfd0CdsZEypPo/IlCMtQ5Ie6rUOPKknlFsmg0z74Qu2nkPJHXTuBUwQF3QrR1fp0UgerDQQdaKE5XymxYidr3SQyTmDbGWwRaE0kLy/1yTUhMDScq9CriPkEKmYAbvc0pFR/4j21ZbkabEh8KWiXN4fS+LYxccSwXiukuVMNeK/Rxas9EOZsTE6F/qbCYwwsAlBsSbFeJXT2RyWEbPOhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/q2psTkjFUuoVxn8mGY4FbRhG0Zj/fWzdhisjvJq5g=;
 b=mP/93vDAXHYPhliYkhEkLaclPac/oARq5SUvyZUaRuU6xHARFqYotVlpXs+gDJL53cvUzPq/n+B40boAraiaefWKml1rrR9LfvwaiCmt3/sP/aDOrRn7tFmtwjrVBn1rY5ceCwyuB5YPwdXI9K0uCCovLovfC8FlG54lDJNQPHul5Jr5U6QVijV0oBKPptbAH2mTa7U0riaigxB9dCSOLI2eNm0We/N3dir9a/Kh1HRdD42ew9Ydj8YFdlVaeseDQ/otT3u3mrlQB/GoYTvgSo+w0+EmHLJWf1u/cQFupAm56ZHH9v7425WYecaShjVfcwWsWDhTJOlt5FpwHU9Ovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/q2psTkjFUuoVxn8mGY4FbRhG0Zj/fWzdhisjvJq5g=;
 b=Y9mp1a2WFNuhiaL0IXCOf58k78FzNwmuP8Y2mLq0VtlvZejBAu9x73tOST1SveAyzDjUzT5m/80ttFP4GK5WT1WbxboSPvce3fr/Rz15MO4Tdt+Mo6lF7gROnA5L2dTWaXNz3PRebTNBBHpzdfntyrzjfp2XC5Yp4UemxIuc4Kw=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by PH7PR12MB9103.namprd12.prod.outlook.com (2603:10b6:510:2f5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 21:53:59 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::1a) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Thu,
 6 Feb 2025 21:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 21:53:58 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 15:53:57 -0600
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>
Subject: [PATCH] drm/amdkfd: Fix instruction hazard in gfx12 trap handler
Date: Thu, 6 Feb 2025 15:53:32 -0600
Message-ID: <20250206215332.2019556-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|PH7PR12MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: c4793c78-e8a4-4292-88d3-08dd46f8c2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pgnv+wctK4Q3HIWAqYjQKEbtJiGBqtszEfZc1Nx1xCXRL8RrUtCeexcR7mts?=
 =?us-ascii?Q?kvCRWDAvljAj+iMuvgrRIzbd7umoyo2YFW1DRp6JDe2d2EAKb4zj7tjVSwNS?=
 =?us-ascii?Q?mzVAwIAB0dR6QjT7f9nd0DXxjh5nX9zClucIEDvxFj9JLcIh6i6faFP6Gc6t?=
 =?us-ascii?Q?mLjRrSfvailD6VANj1i5YgQ0Dk8QySZ0gP8fzGAmXXYg53vG0YARLblJT2kn?=
 =?us-ascii?Q?La3dMngQMQosTa72VT9+5J9JIeh0F9WtBvZXerhOMzqZf0lqbpk7t9/4a86V?=
 =?us-ascii?Q?/Nv7NPQd9OVKaqDJNZCulXH+MobC4/vHQ673ZuKo6T+sxE6LS57oq8zTfxUc?=
 =?us-ascii?Q?u/9Yt4V9nZCK9lGExvuZe2SOpVHJzTE4TDHaKCJdGlK8v/xViNi59drBB/2O?=
 =?us-ascii?Q?ep4b6rqzWEVH8BnBbo4/SqKUCtcr/BG+t/F+3NtsGYH76SkTaIFn3r58w+Tz?=
 =?us-ascii?Q?gwuPw6YRj2TF41LYPvhS6VhVsPQotn5AyAzgtAS4GqNsqN/6rnxM3qqf0Yf5?=
 =?us-ascii?Q?Q3SwvX54IQyQ9lEMusLeRGVsU0j2hj1oQJ8i4FnN9DU2LuUmxlTM0iLPo0DW?=
 =?us-ascii?Q?ByaCsPi/SiwtX3RljIQm0LvKZxWDrRrvMFKf2laD7yqzJzGmNdseSdCjQexC?=
 =?us-ascii?Q?XHBiH/WCOlSoCkCaBlXZjV5wI5Cn8W3KdcYydPnzJokZ5Zs6UaIDXm1rjEOs?=
 =?us-ascii?Q?N0y1OoDjOEMMwGJZHaBWcRysl8hD7Q4HF4TcAj3x5c/8Bu4PGhyXzUvmAejp?=
 =?us-ascii?Q?4ThJdRb8wGowuNfXy5YNnt4Ab3N8Cn620ZEz7FBwVyn5JKyeAKCQZYVop2ia?=
 =?us-ascii?Q?MmEIeSPYApE6AcRTG5i6Eu7MGXGuP9zX5bUlHmJt0GG8gYyXfBuMpFO3TEo+?=
 =?us-ascii?Q?OQFLglokwtmXZXm41D4H9W0VKhwuwW0E2KZvnOFX0G5JSt2YfgFq+lJF7Rs/?=
 =?us-ascii?Q?Q9RUXEMMg1zfFxtfMNh+ByCicXUFHmlBAGy89QY7WCYNBjzDbBlmx0yIOvbe?=
 =?us-ascii?Q?HUCZ6JpiC7+2gWArBjkM1SviI9pixCty9zSnJsszE326Cg2B2VFcFspUjUNx?=
 =?us-ascii?Q?4VHhaxmb/yNSNdUn9QSKZzgfMaWKVj9uuOUHkC3DEJBarMjlbQysKvkrNxk/?=
 =?us-ascii?Q?yP3vLS2AcEFXHZRZnRGnH/yF8fxEpK20loBsmOsmddyGnbhWaf4elxjJ6o53?=
 =?us-ascii?Q?KWKIPenOljox6J9ynBPoqv+LG8IX6pFk52QhPIFLmq5TE9cyQTJoSWVNL6qg?=
 =?us-ascii?Q?MMZa8wDhEwQrHCt6+NlN/znfhCKuJ3KRCickmHFutrS6Gvrp9V0T+1p24dIG?=
 =?us-ascii?Q?1smwcu3CbvKhKy42HPTfBCKaR+xc2BOYZmlAWBLWsiTGSztphg8lqN7aEINQ?=
 =?us-ascii?Q?dh6NK8nroWOBVcg4nI2xiDHZ2Q78LYNYhpjAQf5VBvDRewTCE1MrGSf6czAd?=
 =?us-ascii?Q?Q1MtGMzpXnSeg2TDdcYvwfREVccbRo1+L5Y6dJlOkIOrWAdegv2xCPMqCotl?=
 =?us-ascii?Q?PC8oKfBVsgSq+TQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 21:53:58.6836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4793c78-e8a4-4292-88d3-08dd46f8c2ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9103
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

VALU instructions with SGPR source need wait states to avoid hazard
with later instructions.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Lancelot Six <lancelot.six@amd.com>
---
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 406 ++++++++++++++++--
 .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  13 +
 2 files changed, 392 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 651660958e5b..112f28ff0018 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3644,7 +3644,7 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_hex[] = {
-	0xbfa00001, 0xbfa0024b,
+	0xbfa00001, 0xbfa0050b,
 	0xb0804009, 0xb8f8f804,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
@@ -3718,7 +3718,15 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x00011677, 0xd7610000,
 	0x00011a79, 0xd7610000,
 	0x00011c7e, 0xd7610000,
-	0x00011e7f, 0xbefe00ff,
+	0x00011e7f, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xbefe00ff,
 	0x00003fff, 0xbeff0080,
 	0xee0a407a, 0x000c0000,
 	0x00004000, 0xd760007a,
@@ -3759,33 +3767,153 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xbf94fffe, 0xb8faf804,
 	0x8b7a847a, 0x91788478,
 	0x8c787a78, 0xd7610002,
-	0x0000fa71, 0x807d817d,
+	0x0000fa71, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xd7610002, 0x0000fa6c,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x807d817d, 0x917aff6d,
 	0x80000000, 0xd7610002,
-	0x0000fa7a, 0x807d817d,
+	0x0000fa7a, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xd7610002, 0x0000fa6e,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x807d817d, 0xd7610002,
-	0x0000fa6f, 0x807d817d,
+	0x0000fa6f, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xd7610002, 0x0000fa78,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x807d817d, 0xb8faf811,
 	0xd7610002, 0x0000fa7a,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x807d817d, 0xd7610002,
-	0x0000fa7b, 0x807d817d,
+	0x0000fa7b, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xb8f1f801, 0xd7610002,
-	0x0000fa71, 0x807d817d,
+	0x0000fa71, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xb8f1f814, 0xd7610002,
-	0x0000fa71, 0x807d817d,
+	0x0000fa71, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xb8f1f815, 0xd7610002,
-	0x0000fa71, 0x807d817d,
+	0x0000fa71, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xb8f1f812, 0xd7610002,
-	0x0000fa71, 0x807d817d,
+	0x0000fa71, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xb8f1f813, 0xd7610002,
-	0x0000fa71, 0x807d817d,
+	0x0000fa71, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xb8faf802, 0xd7610002,
-	0x0000fa7a, 0x807d817d,
+	0x0000fa7a, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x807d817d,
 	0xbefa50c1, 0xbfc70000,
 	0xd7610002, 0x0000fa7a,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x807d817d, 0xbefe00ff,
 	0x0000ffff, 0xbeff0080,
 	0xc4068070, 0x008ce802,
@@ -3802,57 +3930,281 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xbe864106, 0xbe884108,
 	0xbe8a410a, 0xbe8c410c,
 	0xbe8e410e, 0xd7610002,
-	0x0000f200, 0x80798179,
+	0x0000f200, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f201,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f202, 0x80798179,
+	0x0000f202, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f203,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f204, 0x80798179,
+	0x0000f204, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f205,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f206, 0x80798179,
+	0x0000f206, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f207,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f208, 0x80798179,
+	0x0000f208, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f209,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f20a, 0x80798179,
+	0x0000f20a, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f20b,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f20c, 0x80798179,
+	0x0000f20c, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f20d,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f20e, 0x80798179,
+	0x0000f20e, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f20f,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xbf06a079,
 	0xbfa10007, 0xc4068070,
 	0x008ce802, 0x00000000,
 	0x8070ff70, 0x00000080,
 	0xbef90080, 0x7e040280,
 	0x807d907d, 0xbf0aff7d,
-	0x00000060, 0xbfa2ffbb,
+	0x00000060, 0xbfa2febb,
 	0xbe804100, 0xbe824102,
 	0xbe844104, 0xbe864106,
 	0xbe884108, 0xbe8a410a,
 	0xd7610002, 0x0000f200,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f201, 0x80798179,
+	0x0000f201, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f202,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f203, 0x80798179,
+	0x0000f203, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f204,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f205, 0x80798179,
+	0x0000f205, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f206,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f207, 0x80798179,
+	0x0000f207, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f208,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f209, 0x80798179,
+	0x0000f209, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xd7610002, 0x0000f20a,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
 	0x80798179, 0xd7610002,
-	0x0000f20b, 0x80798179,
+	0x0000f20b, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80798179,
 	0xc4068070, 0x008ce802,
 	0x00000000, 0xbefe00c1,
 	0x857d9973, 0x8b7d817d,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 7b9d36e5fa43..a952d4d4eeaa 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -30,6 +30,7 @@
 #define CHIP_GFX12 37
 
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
+#define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
 
 var SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK	= 0x4
 var SQ_WAVE_STATE_PRIV_SCC_SHIFT		= 9
@@ -351,6 +352,7 @@ L_HAVE_VGPRS:
 	v_writelane_b32	v0, ttmp13, 0xD
 	v_writelane_b32	v0, exec_lo, 0xE
 	v_writelane_b32	v0, exec_hi, 0xF
+	valu_sgpr_hazard()
 
 	s_mov_b32	exec_lo, 0x3FFF
 	s_mov_b32	exec_hi, 0x0
@@ -1059,6 +1061,7 @@ end
 function write_hwreg_to_v2(s)
 	// Copy into VGPR for later TCP store.
 	v_writelane_b32	v2, s, m0
+	valu_sgpr_hazard()
 	s_add_u32	m0, m0, 0x1
 end
 
@@ -1067,6 +1070,7 @@ function write_16sgpr_to_v2(s)
 	// Copy into VGPR for later TCP store.
 	for var sgpr_idx = 0; sgpr_idx < 16; sgpr_idx ++
 		v_writelane_b32	v2, s[sgpr_idx], ttmp13
+		valu_sgpr_hazard()
 		s_add_u32	ttmp13, ttmp13, 0x1
 	end
 end
@@ -1075,6 +1079,7 @@ function write_12sgpr_to_v2(s)
 	// Copy into VGPR for later TCP store.
 	for var sgpr_idx = 0; sgpr_idx < 12; sgpr_idx ++
 		v_writelane_b32	v2, s[sgpr_idx], ttmp13
+		valu_sgpr_hazard()
 		s_add_u32	ttmp13, ttmp13, 0x1
 	end
 end
@@ -1128,3 +1133,11 @@ function get_wave_size2(s_reg)
 	s_getreg_b32	s_reg, hwreg(HW_REG_WAVE_STATUS,SQ_WAVE_STATUS_WAVE64_SHIFT,SQ_WAVE_STATUS_WAVE64_SIZE)
 	s_lshl_b32	s_reg, s_reg, S_WAVE_SIZE
 end
+
+function valu_sgpr_hazard
+#if HAVE_VALU_SGPR_HAZARD
+	for var rep = 0; rep < 8; rep ++
+		ds_nop
+	end
+#endif
+end
-- 
2.34.1

