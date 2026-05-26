Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4635CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3855710E653;
	Tue, 26 May 2026 14:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BCA/xnhK";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0007210E653
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:40:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGCVsyAwqhL/eaW/wzFGm44fXR7sI3EizpSEXL+bpktIkH9R7KoFuwBbwzLC5FfFoKUN9X5kmSvj4KilWAOpW5yezf1aSyNVe4m8HdfO8FYcewxaqvtz+SxcMlOFu38pTzLGEbLeEqi6+Rwb2FH0lSBSCA01l1KRbmNHbyolMirHxoIKqsTUhI3zLD5TLWUxm5hjtlhwRUzPlis05Ep5kAzwAga5Kiay75KXVvgHHiqh9Yl0Kn8U9rJ6yqC+o3zmYdRm3f4idUHFXh6ZQNStJHIL/6gCx82K/fv+pGgo8EsMVPEbdzEOHxY+3yVpQvmxnm8k0NKexMRAB/648kOKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+qKu63Nm3LOTVu4pLQ+WTX5zrHRy4Ej1EMg7sh0ORw=;
 b=AbzDLPrQxXILv+pdDcvoxlC3tuAhe9a7P4E29sk27ib7ARCAb9fBQTcuiaFzCjMRVFnR9Hp3D+QcWLnYI/M0f7qI63pPfLO+JthOXZigvZxx8+eiM7oYiZKQaxrSXa44w7dSj5xxQtfKrrz0r3l2m6zMvpvbwLn7v0Lfhwd3/QeJTOtuEANunZwobFQ1YiqM/fK7V6s9azchmenfjY2pzmwjYlrVsYVrDDHbmVWqgW2php2yy3zS7NZKXezZnEFw/Bq5w71OFBkXdEAr9lirN1ROEePBmuk+1vMNQig8Z4PuJI5F2d0PWAcqIuk9CythM3B60Xu3HAxZdOHunknYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+qKu63Nm3LOTVu4pLQ+WTX5zrHRy4Ej1EMg7sh0ORw=;
 b=BCA/xnhK/CR0Isj/G2AZEBhpnWp3h7MJPL7x8QBac3MYPA329bS3nF1vBiVUwoyaE9Lv30cRmOtNqlUHJDUhJp790OYvdv0G0sJw5e73dd/9RRgoHTbpTVzuzxN1p4YFcFzdpj1oFNjqRjaqns8V8vPAB+PWrb5i2cHWD1tUJn0=
Received: from BN9PR03CA0781.namprd03.prod.outlook.com (2603:10b6:408:13f::6)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:40:12 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::61) by BN9PR03CA0781.outlook.office365.com
 (2603:10b6:408:13f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 14:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 14:40:12 +0000
Received: from caden-arch.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 09:40:07 -0500
From: Caden Chien <chih-wei.chien@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <Solomon.Chiu@amd.com>, <Peyton.Lee@amd.com>, <HaoPing.Liu@amd.com>,
 <Yu.Wang4@amd.com>, Caden Chien <chih-wei.chien@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/nbio: enable doorbell range init for vpe on
 v7.11.5
Date: Tue, 26 May 2026 22:32:18 +0800
Message-ID: <20260526143219.609033-3-chih-wei.chien@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526143219.609033-1-chih-wei.chien@amd.com>
References: <20260526143219.609033-1-chih-wei.chien@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdd6789-538c-4ad1-d186-08debb34b1c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: RgcspA+snD3QBXMneFLSYCJUcbyWbyItkkx7RQ/ZWctcOyO9c1o9+XEkYNf4OljoL9ZiEHI3G3JBtA/Rd++VFDG3+2boF1oyBoafs83rk7otbfkhW30vwdkYa4TrzJPaowZ2puRhVLo9QLG2I5eBvUFM/Lx0h971sFdBvzjTKQUuBggcqaBUsCbWyIa72hpzodjOdyhgwj+/OjorWIL/JnSkGvBkC0TYU6NPCwMyWY/U/JwCQQYMN5YSM+0reyteQpz/EIrx0phX1ht5gW/q+PMQk2gRQq2Ywj7MuUSX/VrwDVrY1+nn9uQI9w+s9rMYKkiLaztpEErCdHLcc92L37QCIGIGCj6/DpoRC05wqm3d8uOSbllxhHpPYag70cWjhhbYNJ+8VnWEql4Rr08e+GD8XCXYj6CG6yVMIxAl6Iy+fer8vRqH3Muf/eVef7cHiK2FW2Mt/3N+A8jQWsKRx2ykOX45PkmQOZJqZnAA/DkQsg7OMvA+zneq4YwnVfk8q/P+5F9zwb4T05moirfnZV4dl3ljVDEQe5YB4+rXvtfM0oNlW+dFRm/ilIwoaFlEF7qYpHaSYKQFNdNsv+Q65VR+8vrerj3Xrwnmuk4W4MxPOhIaDin5p8y1gs7M64AXkmJA8IBqkSJtTkX8IXegs1N8L7b4v0PU+VEtMhID2BWQafyuGenUbooE64E4aTYE8m4azpYE4auE2UMqIboINYgqyCUFDZYXS177YjSmF4Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hsm33uO+4UNEeo7samsjr1MXGRVBuIE0tG+TFXXmnZCa9Z2aXoOsDfWKg7JgcdFSKX/IqagxtD3y9ebKfE/RFOYfKUsHo0ga8ZRfZNe9Tcjt4BU7S6TWapbVcfBFgXmFvf/1MfvLEpR7R/d9khgLZVu8q4YqHGkhOSqfL5K/9UHDR9OK1WfFHkoOXNnjaudIFYh7IaOu6yf1FI6UlnlYkZmuZDzt8tcbdPMsCVt+CYuyFiOXvwuQiHkBa9Bm/pCZOxvzKytgesWLXBZCL5qofCPLkjMn72ed7D/vXlfm+JduepzrvY9m3zjKU3myHJooE4G1yHsoNQdUt70VH6BIv0mbQwDbS7kKX9ihZ+Ot+fdCI6FCMotqf+9UMpMdFG3aG98Tb+p326YEWee3Eu2uKRl0hI7FacCOfn3iz0nAmKmJqEEWPzZvHkQSIB7V6iFT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 14:40:12.7653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdd6789-538c-4ad1-d186-08debb34b1c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
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

This initializes doorbell entry 5 for vpe on v7.11.5

Signed-off-by: Caden Chien <chih-wei.chien@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index 872ebb4b3820..5c527a15c086 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -229,10 +229,12 @@ static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
 					       0);
 	}
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4) ||
+		amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
 		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10, doorbell_range);
-	else
+	} else {
 		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+	}
 
 }
 
-- 
2.53.0

