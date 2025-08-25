Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB80FCA0FE7
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 14:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5225510E4D5;
	Mon, 25 Aug 2025 14:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A6hFhIuE";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB07F10E4D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikj2cJTmY4pusaKr/gBUFslA/EQYKIz2KzAm/r6bRcalzevSh0uFTfZ8463oyjKRG+sqTzcaTtpzW138GTuQhQM/+eFOTecvuForzsk9PSKVCKfYgbr1ZsEPxfKiThHyS1nBtmHMbtrV7Kd9stm4LeCR6fy5TWDN3FeBZ3/aEL9FIiGkThbytXKjMPh+5tDdllY03TjiMtnX4/Jn74ZTM2Ku3f87wCZYZw6yyW5zveiv1nnX8jNG1rzoBD/F8ysfmqYEOYcc8Lq9FM51GSB8dD9c+gkXXIwliJOCukXMBgvyfZV+wLLKs3h16UUHBeRMJAI3WeURKLGqS7Joi1cZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfzcWHMiteUlAT2rfV/0gTNLRzCk/+7nBQ8OT3aQi/M=;
 b=iGvup9qTqbLJAlRFsDosJzlSS9fcbEH1r5ZYwclrL++RfFmtMaZZe21DBJJTHVNTCoF0DYFZb0q8vVNaqPAgrgBAAEj5RYlywZAd+ibDynXfZRW/sv/2fUr2jveIgFplYTLI5wN5kY9DsYgjMTxJEagwlUDRbnAxu0q/TpNF7qUtCgsWP/efZr1fndOCmGBGe4sT2iTaiI/Cic/Cy0w8K/sx8Jhihu+iqhTbamkHWCEgrCGzII/6hTrZj/eocO7hZB3qXBludT2AGbTgZRXtdyvU0Fmq9t0sAHc2ah/bQYKsJQLZm18Q6xdCAoOGmwNpQHgV9yge8HzjUzCo4eWFgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfzcWHMiteUlAT2rfV/0gTNLRzCk/+7nBQ8OT3aQi/M=;
 b=A6hFhIuE7tAfRKta03hsDEYEgHYRBg/LE4GYVwUUeH5sg5YGkT9Bohj9+w0/E1jV2aCZ6/PiVf71OB98JKlt0mmUcXJHA9oJm6KX662ZL0B6cVyRjUw16tWVclzpP1EnWJ+aQiHbEUranGKOkl8/77x5sXp6yt2+occhQ81bH/k=
Received: from BN9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::34)
 by CH8PR12MB9791.namprd12.prod.outlook.com (2603:10b6:610:254::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 14:24:05 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::f7) by BN9P223CA0029.outlook.office365.com
 (2603:10b6:408:10b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 14:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 14:24:05 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 25 Aug 2025 09:24:01 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: fix p2p links bug in topology
Date: Mon, 25 Aug 2025 10:23:47 -0400
Message-ID: <20250825142347.45997-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CH8PR12MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: 737ecad7-99b1-47a2-9127-08dde3e30bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J2h3wiTdFR2f+5RXoyuvmOnEPkMR/wvHyJYUK4mUE7wEdwKsuzty0wLWIj/N?=
 =?us-ascii?Q?dMRcpBDyQrnXhq+ML5DtEuCZMuLDlJ9gveKRCGSMxj9l+KekrAQ7wpwm/0h/?=
 =?us-ascii?Q?Hf58oxqC3+h6sAkkqDFH3kQfhKBsus64sa/l692X/4Ev75x5/LIgHkV3GeZS?=
 =?us-ascii?Q?FFeJpQ++A0anSDEgFXeOjg1QaWzDfPO1jDswPoxCw6OIOxzTvnwl5b90gKWZ?=
 =?us-ascii?Q?O2DjiY9bu/+YDR+JMc4teUZlEYRQXjOh8ftHSzhMZsvcDdkNyODLvJMzPfeV?=
 =?us-ascii?Q?NXmsOgPMVGJHV6JiBDfchr+kYjzOxiKLQBeoB5HKgOOVexhb6zhI5QxtWNi6?=
 =?us-ascii?Q?S41lZjjg0+KgES5PUy844z0WdXffXnl6hz/alRnVil8A/9KeRKUX5saZxufk?=
 =?us-ascii?Q?DYrRe53X9xP79Bj0rXM+aNad3undTlCvO5FFHH72o5uL864/QUumd5g+aVnr?=
 =?us-ascii?Q?SY3+VOA9gJwFI2GSjJgVeWHUSLX0KY3hTgQIetwNTXWZcQe/fr9tRTLZM07n?=
 =?us-ascii?Q?12PK4AGIIrR+4Kd2hzQ4WUHOJFz5e47P2xYxpsSd52r3+2EJ08wyQScT+eqW?=
 =?us-ascii?Q?XXAMePKR7VPBAcYeMbFXECR3DsRsxzLT2Sx9Jy+q+OhjUluP4I48toDxa9nM?=
 =?us-ascii?Q?/8OrHF78tABljTJs54erYslzdJ+rGV/0R925u2zp/pXu4ejKe82Ioe0LKEMA?=
 =?us-ascii?Q?Mvj/ikYCxOgDGfLdKNfsAU3B4ounYaNpmQDyRTSQOVwHgJ3KxlvLh2B93sVR?=
 =?us-ascii?Q?wYbPPVgLv7iKtIxwBsbcmTeleMCl8AI4o9lqxdTnaRz/gUAccl9vuX+VnRh0?=
 =?us-ascii?Q?6dLYjzkjXSyh8BV8r8vbq7RcHJIfRwCPc5beHXQ0kQTzf41oeuFkJ/+BGr59?=
 =?us-ascii?Q?hmHPZHvVDgJqyKj6n2aZRl57SDmKXEXb9KCjM8+XKYdWaUV/KJxNg2bvB4ko?=
 =?us-ascii?Q?PetmmFk3p+Y+VGQB3u/bITMN3iSphz+5g2HTcIp6d4K7byAaP3hg7G3uoGBm?=
 =?us-ascii?Q?sFMBvgsqHGtvkqLNonzTCvIxZP/40YYEAbWsJGc0snvfoKsEOvuIQfraXAqT?=
 =?us-ascii?Q?w9xaQoOCePd0sTeSkE8NCJ4R1xnzgptzKEjis5lrnNLWaZC2vKrp5btAdUI4?=
 =?us-ascii?Q?bVeH/M4f5imZPgkS8LSgGMA9vJxebzy5Cvjtl7TW3LVqCCXTKVXgiEE3Zfq9?=
 =?us-ascii?Q?WngtQZJ5+qIdjvASherwlQTPbRMGNa5c4BRPqllXpEj4QLGEzcEWy5Pkirx+?=
 =?us-ascii?Q?F8cCohkqAxa6nWMDyPY92WNFK7gPGehv96uw81RZ99ghNliEF82fp+Jes2Xo?=
 =?us-ascii?Q?uo/+ncKfjAP9udJ9AWWLt0DRU8BQUzwCNqfnMin8mdUslYh9DhIzq+Xr3ZYb?=
 =?us-ascii?Q?vOJFaxpMtK8XQp6+NLQGakE6ZLQiQpyHPEKm8x10SkkmeB+IpfBATVkgUg+f?=
 =?us-ascii?Q?UhrHXOlGGOah68P1E7r11NMOYAKHr7d4DG2zdsdhsdKGYkNblpcMAhPuMV5W?=
 =?us-ascii?Q?XLez+Qlp+vi+pkItclB0SYH+v5ni58bPxYIm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:24:05.2274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 737ecad7-99b1-47a2-9127-08dde3e30bde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9791
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

When creating p2p links, KFD needs to check XGMI link
with two conditions, hive_id and is_sharing_enabled,
but it is missing to check is_sharing_enabled, so add
it to fix the error.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 82dbd68d8c99..5c98746eb72d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1589,7 +1589,8 @@ static int kfd_dev_create_p2p_links(void)
 			break;
 		if (!dev->gpu || !dev->gpu->adev ||
 		    (dev->gpu->kfd->hive_id &&
-		     dev->gpu->kfd->hive_id == new_dev->gpu->kfd->hive_id))
+		     dev->gpu->kfd->hive_id == new_dev->gpu->kfd->hive_id &&
+		     amdgpu_xgmi_get_is_sharing_enabled(dev->gpu->adev, new_dev->gpu->adev)))
 			goto next;
 
 		/* check if node(s) is/are peer accessible in one direction or bi-direction */
-- 
2.34.1

