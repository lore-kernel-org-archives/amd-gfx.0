Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFB0C87FD3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 06:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9247210E4C9;
	Fri,  8 Aug 2025 06:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VmFAZN9I";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2FF10E4C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 06:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5b21FGXlU/h7hle/tzO5IxAoEXQndtI0/+yrUwBaloiCwQh/DVGQUdKSClDJuEJNzuDER+FXeIQ2KcAIm06lkH/9LsesWWb6TdXYcmmuFLph2d0iMkdfshP7Sw6VpINiawN+Hw2oJg4tE9VGysgA6Mr31l5VHPu+k3czCduDV3qagpGvjut64XSy6mMxSKYTgYqzlacN+cRVrK+KvmGwFIWxRfTgUb07eeU5RoOYGQawXWKEwfDiEyfs0kTpt7fH03aBi1L3vHW3yPwZcgdXCS6ApYhbNXY5655IhUp5IIvJWwx4v0yhCZye+zTbPuD7hltrURlUpNNIsJ1h0p+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rln2GpdBXqwpFo55sfp+D6/bwfDp435Y++KEGqemfLo=;
 b=QW+3T0bS3tLBz504tbaItdrnG+EiC0xquSV+SNBAhm4VqGF8mJBsF+bxAZQYGigMXa84h7D6aG9TWu8xOQmfO3Sb4OYcPaEgiKCrzIk62j7wnNObOfJveJLdFPe5Q4APnucdtFBotYKJg9rntrHNuz2jjrQ8r73VKZ2frpmxeltNKNlgl2dsZPwcSlhypTMJbm9VZaPujglS4ZDZAeHTu8qXZsGqWzkMSqqOBwP848i6/GoOLYQz6mbAqf9Wt34tRYocOYmHlLmXQzG3aQTvRyc9cD9qmXzpraFb0gZPX50dXL2sQieJTgDbYZjis0TCrhPyUAC4RoAoSQhlyOxTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rln2GpdBXqwpFo55sfp+D6/bwfDp435Y++KEGqemfLo=;
 b=VmFAZN9IbwobVZ8YNRCiYDAI6SIhzmLczJn3vUNnyzXaWQqREOHcSRgCu0Uegbc0/95Gy4qhARGEWIrIZc7XPBRurLFhBIYn68tl+/V9HVtr3vIAGZnIki/Kmk7nPWxEj9/Ey4VjBRpXeL3LSlP2mKey0KrOaCF7ItDKHQe5Bwk=
Received: from SJ0PR03CA0159.namprd03.prod.outlook.com (2603:10b6:a03:338::14)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 06:29:47 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::8e) by SJ0PR03CA0159.outlook.office365.com
 (2603:10b6:a03:338::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Fri,
 8 Aug 2025 06:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 06:29:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 01:29:43 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v8 11/14] drm/amdgpu: keeping waiting userq fence infinitely
Date: Fri, 8 Aug 2025 14:29:07 +0800
Message-ID: <20250808062910.1613453-11-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808062910.1613453-1-Prike.Liang@amd.com>
References: <20250808062910.1613453-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: a2112b43-b753-45b3-0cd6-08ddd644f889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mlqxLZRR5h62lKZqhP3m8iY/lBhgLpKI6HCfacEfsseopgrwSDlOjt//syvH?=
 =?us-ascii?Q?1GRnc3K/VORz+kokgPhj+jkm86nIjIElQ27NCFQUR65PSJC7XPOI1JjIrzOv?=
 =?us-ascii?Q?y4hPK5YUnydbBi8aYL5XQQTJMQJ5AsXF7GhkcEoXwoEv0WkSgOOsUd2HG289?=
 =?us-ascii?Q?yB8mEfCQfnNlCxqrv5EJ0sm/N1rW1Cw47UoR7GWKqVJr002TpSiIOvXHqfI9?=
 =?us-ascii?Q?p7cKGOnlZGu2h29wjG3zy3De+EIPbBFJMmxSRng9eZhDrLDnyBR8FE8efwo2?=
 =?us-ascii?Q?jG+JrJCkZRb88VyZc+AQGHIyw30oBnFWGUnmwUKyYdbzjgExHxsuqbHJPuKn?=
 =?us-ascii?Q?UoMcABbiWc/d+0rsfbuBvvOQVXF9HbUjStVdcCe5NSYrJkeYEaZL11xzPNpu?=
 =?us-ascii?Q?m3WGE6NOnxeDkTSuKG/N1V+lJxzbtEk1SzdiRv+4kM8otyKBqWratYOfOfW6?=
 =?us-ascii?Q?VemeKtEQOdQDXe5ljgbGDU9V2LFqq7q6pKQRr245H8f59fy8MuKsrhflHU6B?=
 =?us-ascii?Q?gS2PJU6ZSxcxXZjRAI849o8HmQ+tDTJuBEGzRc2v7UJiiDr6Y2m2BNh53sYe?=
 =?us-ascii?Q?QB601wNbSFguGZu3u9MDPlU3g/qAoKE9Av5vKMQ0i+EaR2p7vYw+OficR3jo?=
 =?us-ascii?Q?oAAQnggkhaFKCnm6bvcOw2ScsyYL/bghtHPXET3Dn7tcX15gmOJIkTAhUqRG?=
 =?us-ascii?Q?aQu3DGatCvj9mz8QWjktajOaDZmqEGIYyhH0EpjSpgcHr8/Zod0vrYf3Wdvu?=
 =?us-ascii?Q?XfXJ/AFswmW/QvAbzzbkY2AJ/zSmb4AMjDy9xMa6fN0RP+j+I5bUqTvNaoad?=
 =?us-ascii?Q?Prybw8BIvATEDfBQQWFARk/AOUFTb4EkD1SOG9Gto3GsCog35Exk6sV92tOA?=
 =?us-ascii?Q?GZ5TM1ctrYkM8nIf6UhVU3ImhpwvLr61x2Yo0qjyNtQHQDb1aMu03Is9DuZz?=
 =?us-ascii?Q?hvpDpQYvQHPuy8vYijgCfkxqVNtlrouJwEbsTaFu9QA4HhuhWVG+vSmT5F+4?=
 =?us-ascii?Q?6W/Hj2gR3LeCWGRN/gTEhwDe7GqM4H0wG1I7FiyPu2mcPOwu9rMCfcKXc7rR?=
 =?us-ascii?Q?StFwHGWW6q3jgCSP53WdHvSBlw1PurFH8aB+GtVwFtdGQNEmA2uvWTqjVJYk?=
 =?us-ascii?Q?A6RRKMcvAcNj2FMyOMSkGcPtIC1dqWxrRtIzl01NMYJ4LZotMMIZBgqRKGzi?=
 =?us-ascii?Q?Qg2g80fk9ExBD5INl4rAyFvacyELpQsiDOAq0JqABQLskpaalqNAWmFv+UDA?=
 =?us-ascii?Q?bff6WrRo/1O//S7Co7ptsI2CC3gEjYnDE5NOO1tKZbzL2XlGf0PYy6YyYRTO?=
 =?us-ascii?Q?DgcIaDpP1oeIiG4AoL5/OYLNSbEQPGVyR/6JxRkXoMtnMX/DOUx00x8ofJay?=
 =?us-ascii?Q?f8hzNsaO7PijWLRWR6TpV1Zwxlt0+IbqxW5BCfmmyl+zkuza1rTLO8FFDKRd?=
 =?us-ascii?Q?qUT6q64OlSD1XLUYeMkgTj6OC2lR22xu2YIP3Px/10CsOBfo4YgtoSn8gNsL?=
 =?us-ascii?Q?njGxr8Tql9sT8o8f945LtwbB3tOaSjFGFnT1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 06:29:47.0977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2112b43-b753-45b3-0cd6-08ddd644f889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767
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

Keeping waiting the userq fence infinitely untill
hang detection, and then suspend the hang queue and
set the fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e5891674b4d0..a78c2caeef41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -283,7 +283,7 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	return r;
 }
 
-static void
+static int
 amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_usermode_queue *queue)
 {
@@ -291,11 +291,16 @@ amdgpu_userq_wait_for_last_fence(struct amdgpu_userq_mgr *uq_mgr,
 	int ret;
 
 	if (f && !dma_fence_is_signaled(f)) {
-		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
-		if (ret <= 0)
+		ret = dma_fence_wait_timeout(f, true, MAX_SCHEDULE_TIMEOUT);
+		if (ret <= 0) {
 			drm_file_err(uq_mgr->file, "Timed out waiting for fence=%llu:%llu\n",
 				     f->context, f->seqno);
+			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			return -ETIME;
+		}
 	}
+
+	return ret;
 }
 
 static void
-- 
2.34.1

