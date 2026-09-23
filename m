Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C80C98304
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:51:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DCC210E934;
	Wed, 23 Sep 2026 15:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uV33eVXe";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3744A10EBF1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:51:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzqac/1yoT+Q0bLSmB+UEX85F4E3NweaxijwB3iWYSYpV4YWN2EneB0RcBFfz3Pw3JqLz09TOajIpp32jl4hlPjErxizzcu9ZHN/OaWVHieCo6qS9QVAnliSamenzPumEnlhRimMO8T/HLTLcClt0BJKb4ZSUU9CzXqlGx17SG8pyFEYzJNPIs/enYGj/E2aDGazPgb1TFcaSzrrHg4F0LBb5onx8tTjC8pX5QiyDOhdaMKQWml4/GKdf1GGBi9srVPsg1jmSJfxhs2Rg1va1ZuJXOeYUn14ciHLXjTmefABr/sQ977DDz+zRPLakXmmfZ61p/6Q4i37p6r/dIX/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWMigJ7bNwDFgBPUX9jMNxDPKz7v5IKc2s73S7Nrbmk=;
 b=MqOSe7Y2ZQmxoux3v90fe04ifuXwZoc/fiAOi/FASaHSMQmLzynCjyrQWuprinMzSw8vvfQOIhzujE4ZEznbroynqYSZGv9M+t1aMXsFCpie1jHqEstgZMmmcE9JYI7EBa78OfceS8N7P29cHBLNVP7hjJLU8IXi7s4kw/IkadYPzvU0s2zH3cmGTds4k1zbIqLK7Cd6ZYxFdA+s0jCQntyuSkDXv6CRvPoHWpEdRfRQQYMN/ErCjDcseGS76/pCUzScKQF8S+TgwAdA9c3eJPUEaW7NDNQejeYvWGR9qjX7Eit+xG3KR4OHixO7kvJ8Dd19wThO5bEOjg7iKSGG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWMigJ7bNwDFgBPUX9jMNxDPKz7v5IKc2s73S7Nrbmk=;
 b=uV33eVXezMxD8+/0sgUsNdV646SKceYGJzzeogl9iiDdjt3G2DlinKyNaVIeAZxNatMLMixYoHOdNjKlLTKgFX5JWVBuHCPWaGgigN1tN3gvk7cg2ROueAgZaLRUWGfQKY0+mJjRUNhNlJRk0i9biKHH73FAJf768STXxcppJrk=
Received: from BL1PR13CA0260.namprd13.prod.outlook.com (2603:10b6:208:2ba::25)
 by MW4PR12MB7429.namprd12.prod.outlook.com (2603:10b6:303:21b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.16; Wed, 23 Sep
 2026 15:51:14 +0000
Received: from BN7PEPF00000092.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::16) by BL1PR13CA0260.outlook.office365.com
 (2603:10b6:208:2ba::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 15:51:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000092.mail.protection.outlook.com (10.167.245.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:51:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:51:07 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:51:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Caden Chien <chih-wei.chien@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/5] drm/amdgpu/vpe: add vpe v3.0.1 support
Date: Wed, 23 Sep 2026 11:50:54 -0400
Message-ID: <20260923155056.2816021-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923155056.2816021-1-alexander.deucher@amd.com>
References: <20260923155056.2816021-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000092:EE_|MW4PR12MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: f67abc1d-dd4e-424c-3333-08df198a7f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NgWwHqs63BzX4iegPuI3YkdbnbwyvzELXGsSzKlLvxIF2Lk16cNY7syHGjruOxg4w5S/XrDKjigaI+fVFVHZ+y2s/cKTK1gyEsOP8SMZTbdAfeogxcQrVElvdgzyfMkCjLhuWwcTx8p/WCX2yCzzivmljUNodEdkpnFZ7P0DEryUbzYaynwpLWCRuzSU/1M6smM1T9TbK+0v0VwwmBkcrafluN1hK6FuZHUGA+/ZKADvEQBYmKID817XSfqQrwNUlhVqgcF5Xb9AaWVGBe/rEZbfvkcQ/KwBrSsvFQ0M0stsd3WT3p7k+HmUYm/mxaQRl+bL14chyH9EWWT2PbgTrlAT3LDDbGKu2xefstOgIF1rFHUK184E6c+MJfWXscAOyvpXKQLMh0E5//HWMnq60uNMzDbNCCrks6JKMJ4FUkz8uOsTUSEhx2ME2n5Bjs4rtMHP0lkkaP+mc30XyPGlf9WTSuAESS48tSyqHlOoD2YUCzITlYbcFuq4csZYcL1zgSjkgGfN3jiuUjPG3WUZ6tB0t5bHcOHnMvE+kk8Y6cJ3ZmX6ngnZ00wzgBI/4xS/BZQd4CoJDCw15z/e5BdBcCtQO4/vo3CIP/BpYWh+8zNyUe3wJ9ZxpBcO0syLwauDEFCpqpO1uO0g9JdDf0DGbh7S8IBabAya0C6K69BQnpzuFgrUx8qWhvANe7Agx9v0VoEyYsQbli9TxJyrkqSjKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kIAw8sEs15hWk/aLFMvFilZdMh90dHyaWLVxtN4VXnmVXrX7y7M7iyXMT0PtkfZ5MJp9KDJbivBGmgulT5UYIacipnLi2AJDmr/7+Avg6GQsltRWQo5FC9STCH3uSiCPogIHgoABehB3HQ8hPH7UBqoTSF7BfU5fWO4nRSw6yLp6xWta3mlOPSiUY/9hhMLiR1m/yQPCwkYNCtE2fcVlyY9fjzA73pfZ/0Hxc92JRsBZDmWqkkysbPF5xOJltiQH56KgX5Qe0Z7NH1o6syHCJLXvMgF701mT5LY8hYlCao5eVakTI5db/DMy9JgkieqWCFc8LUyfwx2Y5arV82odf1+lyLzMjXvTJEZ+W9ka6TMYUb+ZJX6Eh5jSRZYLnQJKDaD9tm+8PLwY9m50VivhK42s0tmtai0kKygPbsrWwLjPBJ4WBxeV/iLcYu+B9zkl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:51:14.5542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f67abc1d-dd4e-424c-3333-08df198a7f8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7429
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

From: Caden Chien <chih-wei.chien@amd.com>

This initializes VPE IP version 3.0.1

Signed-off-by: Caden Chien <chih-wei.chien@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       | 1 +
 drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c         | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index dfa6081ac89b1..a8d296d5b884e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -3348,6 +3348,7 @@ static int amdgpu_discovery_set_vpe_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &vpe_v2_0_ip_block);
 		break;
 	case IP_VERSION(3, 0, 0):
+	case IP_VERSION(3, 0, 1):
 		amdgpu_device_ip_block_add(adev, &vpe_v3_0_ip_block);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 792dca283109e..39bf218b6f7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -317,6 +317,7 @@ static int vpe_early_init(struct amdgpu_ip_block *ip_block)
 		vpe_v2_0_set_funcs(vpe);
 		break;
 	case IP_VERSION(3, 0, 0):
+	case IP_VERSION(3, 0, 1):
 		vpe_v3_0_set_funcs(vpe);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
index 4af009d469401..9077ae138d2a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v3_0.c
@@ -31,6 +31,7 @@
 #include "vpe/vpe_3_0_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/vpe_3_0_0.bin");
+MODULE_FIRMWARE("amdgpu/vpe_3_0_1.bin");
 
 #define VPE_THREAD1_UCODE_OFFSET	0x8000
 
-- 
2.55.0

