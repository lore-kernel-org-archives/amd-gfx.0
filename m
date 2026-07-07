Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E836FC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 13:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629EC10ED18;
	Tue,  7 Jul 2026 13:56:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X5tP97ZG";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0C7210ED18
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 13:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWCnUb0vOIygzqrJop/5Z7V9NF91L967UKs1l+wW03uTWXQh6b+n/kbeISu7nIJpy0rcQDBjv1ZIJ0VOijIpdPaO9NcMLnw40fTU9jt+KVhN+OxCLuKTBt+Zu++cgZM+uNYNZ7DGampaDNDw03a7mV3qRn3B1I9+Zg7gZ0oEMad+3v5bf6oJ7Qda2+tcWsUDrcFIiZTWpaboWE/cg5uK/AxoDryabFu4z/6zgziNZgV1LcbTrvEHxRtWHXRNv/ml/8XRgLTedve8llPw7cNGNq7u+dI8vOGRocd8WyqQf1MkqF5IHCEPx2fZx66xPtCI0jdwuDu49o3GbN/3Rtrkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAytwJJDzgBISneoDXYGAdYZGfbNw2GZ9XNIGub53xM=;
 b=NqSaTFqbRfxays/GjJNtcWNCKgvwhPoxZ7dgwQlRE73KJWybj627r1KbRkKwtfH9/qkmY4rmyfs0WQFhqQumOjXGB5KWXbrTlo0yxEBmVR/UzcU0/TfJwLbtc7Z6YIjla4cF9WsIhooKXwppcioffZeuX78HFW8ignQlk1NsefxstHU3t69AI+DOmPpx1RgWVmXa0/wjEuxiWVj/Jwv2AycUzJAUSaDp3zXhqAQQbEheJHN9VRW6FUDt2wCo/51BAKY9x1zQkFIk3+U04HkMlxzU2uuweiZmlVzkQjAKLEPFX2L3xNew1/VzmQPY+jMK8/WCXLPJo39tuCMgUl6b3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAytwJJDzgBISneoDXYGAdYZGfbNw2GZ9XNIGub53xM=;
 b=X5tP97ZGL/y7BX5W+kTubJQbvEkXEYS3ImizYTG+51aSNgs1u85bpTfbsN7VOazvCO86VMH6eLJoWvvHQ3C1KhH3JM/2a6jiGcB7s5pZZKxsPpiRPs25ougmkzg+X2ovdqNrp9rDPYQ+ocV1yLKXmsCL/wPrRIwDbSgGfODquVs=
Received: from PH7PR10CA0010.namprd10.prod.outlook.com (2603:10b6:510:23d::19)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:56:44 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::90) by PH7PR10CA0010.outlook.office365.com
 (2603:10b6:510:23d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 13:56:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:56:43 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 08:56:40 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: move uniras IP version check to
 amdgpu_ras_init
Date: Tue, 7 Jul 2026 21:56:31 +0800
Message-ID: <20260707135631.1027988-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: a655dfb9-3055-4401-3d9a-08dedc2f939f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: faGRAhpuaizc7ussbGiIwkpDnLOBJlqjDeaJ8OmCO9lfxOwBFi7h1EdlwDJ7aNoCZr+WBbLhp4Go3z7rsmTHauqv2ooBdDIz07FBWb05K67wL7I0khxRXceQVoidWCEEPbYQ7kuJTTsqB7+pMbeavW5C4sYBESW4oTSocIICb3mSbIFN2Id6tKNT/JPr6SWY1nNVF63JInP0auzBeS5uMYwbzafvYkSmTUJTVI7Au9l9wJqEkgXCE8PaOlVEaIMg/sa8gPtTVA3P1jFbYltxL7FYvLzXTdd5i1+sNCnJhu8eP4N/fCgBkS9wGCuVvnl6MYTrcYHcCEplQ5zQ/QjVcApk+tIWuVmfTHmUx/3vkFDFPZUS87VAeIYKnMCwzOKbqdOWGQ7qkRNtUdkvl9Hhn+QZ/puFQLCd52pPJXE4yq1HZEWj+M3H1p5XN9UX5zADNw2uJYMNxJyPQ90t63Cq36wEFr7eMMTHobI1mzv/B/MANGWNaduY+wmEsrEx1Fr5b77g34NCsDYpUDOnIsIeKb+xQqWzFQl0KubFzTEUTgJsMQF6noNzjH0inAvJWxjmGc/gv0MtMpIa4NqZLublGy3fUyMcHKZ6glpFtvijC/oPP5JpjZkgwdzrCCsnaPioib2Hgrrub0yIPJyZgtakKrh4cwX5vVO6tdYMntwDHOKZT6s9OKZcJkc81COSAcEueSWy/V+FtJLj0SD7j6fblQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UDnvlIb9l4Iom8M/VAvZjt/uSGaVgPzJqZR15QvOS/V3Sa1Nr0/KXDtzoS0hnSmhg7EjBN8xfcREH58BlFk9JQfdlHHo3Y8nqIDH7jkEwAt8Dg/jFVy6fD+3SNGcBCfcwLpf61mtDwFtIDxP0MllolVpS2ZmroosnPkTY+6gSYq3cG6iJkw9O390MGSh6R7BuuqBr6g7HHY9gkVL5HihwDZl1uOwq53HSODdtrQCfmcQcbFGbOBjY6Q7+S3u9CvXGAEzlOx3ehvmP3EHcQwqkdbvIEKcfz0RJP3nPFjXeyB28i7t7rKj7+w0Ih5oJBUVhhhySR8764WZMVl15EUQuRqhZEVlqbd9j2ypP0B60F9Ae0JsF4MDqW2GNQCWuzGsifQUvnPD77vskvqK4wu2/CuoHv8Bni0YC3BQvbkL+KWmSqldT3GM0EMeFTGxemKz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:56:43.0620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a655dfb9-3055-4401-3d9a-08dedc2f939f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
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

Late uniras enable in amdgpu_ras_mgr_sw_init leads to xxx_err_count
sysfs node creation failure during NPS mode switching. Move the uniras
IP version check into amdgpu_ras_init to set uniras_enabled ahead
of sysfs node creation
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 11 +++++++++++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 10 +---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e300d951898d..8ade3da6f132 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3595,6 +3595,17 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		goto release_con;
 	}
 
+	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
+	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(13, 0, 12):
+	case IP_VERSION(13, 0, 6):
+		con->uniras_enabled = true;
+		break;
+	default:
+		con->uniras_enabled = false;
+		break;
+	}
+
 	con->update_channel_flag = false;
 	con->features = 0;
 	con->schema = 0;
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index b8b831a91bc7..6224c4921a42 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -327,15 +327,7 @@ static int amdgpu_ras_mgr_sw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_ras_mgr *ras_mgr;
 	int ret = 0;
 
-	/* Disabled by default */
-	con->uniras_enabled = false;
-
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
-	    adev->debug_enable_ras_aca)
-		con->uniras_enabled = true;
-	else
+	if (!con->uniras_enabled)
 		return 0;
 
 	ras_mgr = kzalloc(sizeof(*ras_mgr), GFP_KERNEL);
-- 
2.34.1

