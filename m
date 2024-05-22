Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700D8C25B7E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 17:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0138A10E282;
	Wed, 22 May 2024 17:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zww9x7ow";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C93910E1A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 17:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbsfnPOwKzjH4ZkNsWzqhncVcJCKUek8UWq8bE34YF4kLEUP9NE50blbsi4yO2xS6Kr8GLpcmZjFKdwO+to5wqPSHxhvFNFzIGNb2BcH78HBXt3cPLP/Yivy+m4ya7FcWzn5+9hPgwC2NrCBd4+CMUc7je5B3eO+53dsD5K5JlyT+7nx2FsYOLpL7nh1EC8aZVdGTPOawnabLOlb4X8CjCSnMl/hCgcFYewlpKcmF3d4ztggqeLyw3KmKB1M4oLp5ouQtaT9L3H+3L50eh8+zqzV2Fi0BCUdg1SoSl9tjKfLLGFmbft/2pfgmSCzkDB7UbbC4+RPkZR3m4PZ5eblyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rWbwila6i4rI9BeQ8BsQkk7lbrv1SeeaUh2sJQhTAI=;
 b=JxOnSMLuvPsk/ns/W2d/W66eStrY2t+clRvseNmg5kiJk3pt2bfYccWTJiLwMBfmUkAaHPFFB8NWFXHjfTNsso7sPr6hbjiEwwBsA5sJ5JTp0xUCjYmvALAU+oOm1IZo26jPYaV6IaEPOoVriBslBy30OZbEUZHEmKm9OGa2veohbTGtcvGJ7GDY1J0oesAoWQPs3oAmGrxvzCpqvwGTgx1XUGZ//qcElt8nQfZ3f4PgHft8EwRQV16sJ9e4CWEnKxE9BcYMu+SGssDygnwvEyWzAiXjxN2bOUKC2AS5sIBtapqc7hyzvhEdPXw3uWH/+E6Lll7kM3aXMtHrbzom1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rWbwila6i4rI9BeQ8BsQkk7lbrv1SeeaUh2sJQhTAI=;
 b=Zww9x7owkEVtEp6EjXrlQ+CNnlsbHFxeKEr6x+olulI0SW3ovd+WanLtf9ZPghK6ULs+Gn3cHlIJwCVYFdMv36spmhjLGmZJM76mtgUGChDFaxHITvBeIaF5yV10SJpyk6F/PEV2NgbYvYlcpgBXDrHwHv+y7sK5/3y3IbZ40WQ=
Received: from CH0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:610:e5::28)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 17:28:00 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::82) by CH0PR03CA0263.outlook.office365.com
 (2603:10b6:610:e5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Wed, 22 May 2024 17:27:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Wed, 22 May 2024 17:27:59 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 12:27:58 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: remove tlb flush in amdgpu_gtt_mgr_recover
Date: Wed, 22 May 2024 13:27:20 -0400
Message-ID: <20240522172721.14085-3-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522172721.14085-1-Yunxiang.Li@amd.com>
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|MN2PR12MB4269:EE_
X-MS-Office365-Filtering-Correlation-Id: ed062850-e959-4d4b-48cb-08dc7a8486c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NkALpyynddrvsvXDyvQNMtjuQbHDwfTUktAxQZQ6mW7mDdEsO5Oq8aA0joBc?=
 =?us-ascii?Q?id3Epdr4qPy7sv60A4yfnf/PJJEmV7kzLyh7m2gjoRiqKTOKRmRVyEWcmqRn?=
 =?us-ascii?Q?3bQrdaXWbvo4bow6xBHR8R3YwlE/NUEaPUwl97ryykt72RC9wcNK+uriME0E?=
 =?us-ascii?Q?d5kaWOyjJUC/yksb5RvnrXxXiWKRkq+rxdxpqBQ5BTVoJPkH3+Xe8JYyZ1H+?=
 =?us-ascii?Q?QUQU+ClDU3hH74B/GVCPFC4wZPuQ2yC5B8W9iAfe+wqKIUsAk+c/yM4iWi3h?=
 =?us-ascii?Q?byhSWtApg8yWHLWtwf47xChIQYjRq+fU06MoWiPy2T73EhzjdA6DYsCaL5YD?=
 =?us-ascii?Q?e8+knG2RF+p+wBLahudheyQXYca7KcRVE5BPEZPclLVJPizZl1RlLM7nKM30?=
 =?us-ascii?Q?FgcyqW3yJ5vPEXTtdPjeNFz2TzIivYtd9q4Y26jG9fOUMrMjRmpYpW3f8SRG?=
 =?us-ascii?Q?apc7MMrPhD6U2GJQ4XMFgiqYvUsEaq2ByumhU6oUqSAHUTLvMXS0HC2qJPiP?=
 =?us-ascii?Q?HXpqv9f7Adfjwfx+oi8sSUorck5G0ITzlHYePUubGkhkDezsqBKEbmQGJzou?=
 =?us-ascii?Q?87AU44svyN4wwnCvuq5algtgmBGetCPe2sH4DBoCZQSNK/y4NLiBr11LPQQR?=
 =?us-ascii?Q?LD4TSLahUidA5ALPY6cAgZidg8Oq9/wW+m0/rFxZqceBkISfuqySXx9kVeL6?=
 =?us-ascii?Q?4rULvcDqrevaNdUhZb7N1u0WydGAeVLbFAftBcHbQgdRwp7AI4qWhDbGgt2C?=
 =?us-ascii?Q?uWFsOhVYg8Uw2/i9vMo/mFILNZQ/JnpqfkKjsEFpiHXY7+2GB0IWOJP5qx1l?=
 =?us-ascii?Q?OQ+ICFk6uqGkeTUvgSzo89etbt8Yesw4UiLOYiq2xiJjkQSdSpiNGMn4g1r0?=
 =?us-ascii?Q?sqRZZA3vmGCgY4HoS9qc5mXDt6/JB01K6R7b4+N0aiEIYeeKpcSy7K+ypBlb?=
 =?us-ascii?Q?/6mNmLqW2AbwA+KzVartZyvwk1CmxqMrOQQl5DtTWoyCHgK9tFcW9U5qkyt7?=
 =?us-ascii?Q?K0I50KAKwIVN9f0uty4N2HiD/wD9pwhH3d1ImUbH6q7su8JAs1ZbJ9TtfmdL?=
 =?us-ascii?Q?ihAlo+HlWO9NLbJEqNvp/cenCFIBq/CjWboXDEOxdgT/YbjcL+aa/2Lfc/pH?=
 =?us-ascii?Q?sNiVBRff4ODLLpf++xPir2DK4qBrbsNtDuPalFdrapPl9MzGsorm2VTg4Sv7?=
 =?us-ascii?Q?ceTR6jVgmkmW0T6E1rt9zib88RCNrosm1kpL/oA8C/BIKf43ONOQF4jsFaR2?=
 =?us-ascii?Q?jtQVP63pXnfuV0bGTcopKd8Rruy4lL2thH+WRqyfs6YcY7kGUJ275cqclEVf?=
 =?us-ascii?Q?/PRyWuHbwbyU8FBtgdBwdJEiTqmRBnPEirzgZsPvnTGkYonAsR0MAq7a9PxX?=
 =?us-ascii?Q?JEg2B5Lo1Pif/rze2dXym78r+29U?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 17:27:59.4163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed062850-e959-4d4b-48cb-08dc7a8486c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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

At this point the gart is not set up, there's no point to invalidate tlb
here and it could even be harmful.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 44367f03316f..0760e70402ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -200,8 +200,6 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
 		amdgpu_ttm_recover_gart(node->base.bo);
 	}
 	spin_unlock(&mgr->lock);
-
-	amdgpu_gart_invalidate_tlb(adev);
 }
 
 /**
-- 
2.34.1

