Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7584C5DF72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2CF10F6F6;
	Fri, 14 Aug 2026 21:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i1tSazrc";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB61910F6E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1NwMh3hzVS8nd8BYVKGCnY9q2pc4l72WxOLY83zu7/vgy93EUzkc0B2FPCIEaoJuPHOPyczbcqnp+FoWAnYNkgqyXnT1wsuOtwZ8brIEhclFylM/knk/rmGy1/ZRd0N65c3fkaz/klod4CU2XmWROYDrfi6xSV1BTrwXX6BJzWcCmIg+6zHPMN8AK7kS5AlEOBfuKF6H0nf5GOkS8+SjwuzRvKA3KocpNv4H8sJO/QcZOosOsBjNGWpHrqck6spqwnRudnUn26LUKmjVTlfHEn8CR6H5y1JlS++AYIUe+t+ivBz4Aw4sR38vL+0XtAPBRINGKQLb9MyK0vJNDsqBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gCpZKULMexrlNAPYiXQxPT07VWGCXifeenbH28vD54=;
 b=P+o3i/Dd2PwwHk3JOtYkFJUEEQqAzBlOqzK+ffUVrVJ3Ncz4FVqWzyyHqnTtTBnWuoFAvxbKiMcvj4MPGfphRv+eSngNIArTqk7Q3yrEzK/LAiK7vd8da/dMTzhzwWsoK7t8WJz1mRAyxw4kNW96vN0ISgHHUZ15JkGor7jQoeWOU8RVjGJWm61dAzMMkuRplee9ES/4QQrNhaL0v1K4wtpU9snrsvOCP8MA6T4sXVWU1yyZ/SzmsxdkvHOX/hs9DvNUvHiGV1ME7JWS6hRwhoVdM3YCAwCuWv7hJm2KuGWjrh3hnTDD/Oy0nlDWLQFETmIW/UFuSiX1j5YtUH3YvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gCpZKULMexrlNAPYiXQxPT07VWGCXifeenbH28vD54=;
 b=i1tSazrcSt9sctrX5ILsQehHAzFa/w8Ycfom/SC+Vea/XOqw6RHAGhC0tX7MoVuuLwt5HdAUC9lEfuNvjqlp88zSxrKmdArfe4F55fRgXwU/dQ+UgTKNgJWdurzsGSEc/74wrodNpNFVvSNER0sl+Gx2ltjKE3O5isRMqD6ZuyA=
Received: from CH2PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:52::11)
 by DS0PR12MB8366.namprd12.prod.outlook.com (2603:10b6:8:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:17 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:52:cafe::54) by CH2PR04CA0001.outlook.office365.com
 (2603:10b6:610:52::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 020/109] drm/amd/ras: Add ras ip configuration for A + A
Date: Fri, 14 Aug 2026 17:01:17 -0400
Message-ID: <20260814210246.3067612-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DS0PR12MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: e8143b10-52d2-46ee-9600-08defa477562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: QXwWBXUNdLmWbc8mdWYl/YsqiQZnJoVDt2mulVzd8RkttSfaJ/dl3fjTQom7q9TehbFDvgXwrXI7YhsVoJq2FAf5ZZP7DMdMK247KQvqjcToDF8wWeR0wKTSqqQ8p1f422NLWxLh38F8zQ24LaF2og+ofclxMSYuyo2kpY/DDaj1U1Fm64vi2GfjLNLgrv5KltqQopkIEMbsSpBYxCdHfFfB0+ojZzAQyIKHrjf8JoDB2zp8pqYAE2yqmdK9c9RICFhdDxA9aHYrFc9NvkYSXnAnRgZH9eI864DsdeXIxR3eSPEn3pwDpZWnXQxrIH7+XGZCSfp1htv6ZIDDyHgd9KSaf6+AaTmzt3RXJopuKcC8hM3Qrnp3sx5XLVltDJU+uaqwD+kk5/gpuor5bpH3fVAK/e0yk6zf5mq1ilJbNBxGS2mV8dFChFbFHcRB0tpy+j0FPGvS9XT1TPOQacsFgDrC24wn9CpdDqLJ1e+0ORc7tuqURAhpLSnpy8lMUdTCVCgx9FEXdlBhGBJi7HJGMWdJcuG7jZ/1lFNTVnr7lWDnn9dMFWE4gTQGIHhWT6L5jChMSvQrs/vW8Jg0yHo2ia+TiFhLYmAtL29D3iE5JQVYA1QTN952vt/JQ2hhlvZLN/IZv3kKQfAv9T+vx8/yNtmBYBko2JbZJ5Ak1w0J9bQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mSl2agc/bjutakifWDZZg7hw9bNo+pD7YIaVsB68rq6EGnw3eudI6QrYWX7DQ41ktNNztfXJ2ZQLUrX3HEFDcFoE4dB7bTAaRXTfVYJ1KtCb6ClozXEtVulvw3yWr7QPtpEHwh0I1EEP4uxnbEPcS5HuzQDBp/80HhxdHkQ+G04H6j2M6L7jxgmOGAcfGbKhTdES2K/J9CPUGw7BTA0NWuqIJHp82uZa50sxsCu72x9uFIp99HWnWcimzYjiGe7o5rn8bVT2SKw/4Yq6OpHBCl9RE6Ah5dhVkdv3clFhSk6GzHp0ZOsHXQuyttC+O3h3sqv04GN5+t8oZemoaQibkrxUotgOt5jFvW4aEpgWnwuULcANF5qOBRH6S7kx2L8gS8cVOce7K5F5RXwPXxnQ6xL4IIwDYlE4/NJSPpb8gYvRyCmGRVg98Do/ETXGC1Qp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:15.1867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8143b10-52d2-46ee-9600-08defa477562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8366
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add ras ip configuration for A + A.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c            |  1 +
 drivers/gpu/drm/amd/ras/core/aca.h            |  2 +-
 drivers/gpu/drm/amd/ras/core/core.c           |  3 +-
 drivers/gpu/drm/amd/ras/core/ras_gfx.c        | 10 ++++-
 drivers/gpu/drm/amd/ras/core/ras_mp1.c        | 11 ++---
 drivers/gpu/drm/amd/ras/core/ras_nbio.c       |  9 ++--
 drivers/gpu/drm/amd/ras/core/ras_umc.c        |  1 +
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 41 +++++++++++++++----
 8 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index e6110e02c38e9..898742e578347 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -665,6 +665,7 @@ int ras_aca_hw_init(struct ras_core_context *ras_core)
 		aca_blk->blk_info = ip_func->block_info[i];
 	}
 
+	ras_aca->ip_func = ip_func;
 	ras_aca->ue_updated_mark = 0;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index f42f408f4acfe..d81a9d0ccc6d2 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -28,7 +28,7 @@
 
 #define MAX_SOCKET_NUM_PER_NODE 8
 #define MAX_AID_NUM_PER_SOCKET 4
-#define MAX_XCD_NUM_PER_AID 2
+#define MAX_XCD_NUM_PER_AID 4
 #define MAX_ACA_RAS_BLOCK  20
 
 #define ACA_ERROR__UE_MASK			(0x1 << RAS_ERR_TYPE__UE)
diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 9d0453ba21c15..aad95bf3fa180 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -526,8 +526,7 @@ uint32_t ras_core_get_curr_nps_mode(struct ras_core_context *ras_core)
 	    ras_core->ras_nbio.ip_func->get_memory_partition_mode)
 		return ras_core->ras_nbio.ip_func->get_memory_partition_mode(ras_core);
 
-	RAS_DEV_ERR(ras_core->dev, "Failed to get gpu memory nps mode!\n");
-	return 0;
+	return UMC_MEMORY_PARTITION_MODE_UNKNOWN;
 }
 
 int ras_core_update_ecc_info(struct ras_core_context *ras_core)
diff --git a/drivers/gpu/drm/amd/ras/core/ras_gfx.c b/drivers/gpu/drm/amd/ras/core/ras_gfx.c
index 2efe18cbbe5b5..e553f1364d6c6 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_gfx.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_gfx.c
@@ -35,6 +35,9 @@ static const struct ras_gfx_ip_func *ras_gfx_get_ip_funcs(
 	case IP_VERSION(9, 4, 4):
 	case IP_VERSION(9, 5, 0):
 		return &gfx_ras_func_v9_0;
+	case IP_VERSION(12, 1, 0):
+		/* TBD */
+		break;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"GFX ip version(0x%x) is not supported!\n", ip_version);
@@ -49,8 +52,11 @@ int ras_gfx_get_ta_subblock(struct ras_core_context *ras_core,
 {
 	struct ras_gfx *gfx = &ras_core->ras_gfx;
 
-	return gfx->ip_func->get_ta_subblock(ras_core,
+	if (gfx->ip_func && gfx->ip_func->get_ta_subblock)
+		return gfx->ip_func->get_ta_subblock(ras_core,
 					error_type, subblock, ta_subblock);
+
+	return -RAS_CORE_NOT_SUPPORTED;
 }
 
 int ras_gfx_hw_init(struct ras_core_context *ras_core)
@@ -61,7 +67,7 @@ int ras_gfx_hw_init(struct ras_core_context *ras_core)
 
 	gfx->ip_func = ras_gfx_get_ip_funcs(ras_core, gfx->gfx_ip_version);
 
-	return gfx->ip_func ? RAS_CORE_OK : -EINVAL;
+	return 0;
 }
 
 int ras_gfx_hw_fini(struct ras_core_context *ras_core)
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 97ae049fea496..12c9e20098c43 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -34,6 +34,9 @@ static const struct ras_mp1_ip_func *ras_mp1_get_ip_funcs(
 	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(13, 0, 12):
 		return &mp1_ras_func_v13_0;
+	case IP_VERSION(15, 0, 8):
+		//TBD for dGPU
+		break;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"MP1 ip version(0x%x) is not supported!\n", ip_version);
@@ -82,11 +85,9 @@ int ras_mp1_hw_init(struct ras_core_context *ras_core)
 	int ret = 0;
 
 	mp1->mp1_ip_version = ras_core->config->mp1_ip_version;
-	mp1->sys_func = ras_core->config->mp1_cfg.mp1_sys_fn;
-	if (!mp1->sys_func) {
-		RAS_DEV_ERR(ras_core->dev, "RAS mp1 sys function not configured!\n");
-		return -EINVAL;
-	}
+
+	if (ras_core->config->mp1_cfg.mp1_sys_fn)
+		mp1->sys_func = ras_core->config->mp1_cfg.mp1_sys_fn;
 
 	mp1->ip_func = ras_mp1_get_ip_funcs(ras_core, mp1->mp1_ip_version);
 	if (!mp1->ip_func)
diff --git a/drivers/gpu/drm/amd/ras/core/ras_nbio.c b/drivers/gpu/drm/amd/ras/core/ras_nbio.c
index bfddd104d5486..ca543b2f36791 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_nbio.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_nbio.c
@@ -33,6 +33,9 @@ static const struct ras_nbio_ip_func *ras_nbio_get_ip_funcs(
 	case IP_VERSION(7, 9, 0):
 	case IP_VERSION(7, 9, 1):
 		return &ras_nbio_v7_9;
+	case IP_VERSION(6, 3, 2):
+		/* TBD for dGPU */
+		break;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"NBIO ip version(0x%x) is not supported!\n", ip_version);
@@ -48,14 +51,8 @@ int ras_nbio_hw_init(struct ras_core_context *ras_core)
 
 	nbio->nbio_ip_version = ras_core->config->nbio_ip_version;
 	nbio->sys_func = ras_core->config->nbio_cfg.nbio_sys_fn;
-	if (!nbio->sys_func) {
-		RAS_DEV_ERR(ras_core->dev, "RAS nbio sys function not configured!\n");
-		return -EINVAL;
-	}
 
 	nbio->ip_func = ras_nbio_get_ip_funcs(ras_core, nbio->nbio_ip_version);
-	if (!nbio->ip_func)
-		return -EINVAL;
 
 	if (nbio->sys_func) {
 		if (nbio->sys_func->set_ras_controller_irq_state)
diff --git a/drivers/gpu/drm/amd/ras/core/ras_umc.c b/drivers/gpu/drm/amd/ras/core/ras_umc.c
index 95a98b411fc79..fcf65dc5f7146 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_umc.c
@@ -72,6 +72,7 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_func(
 	switch (ip_version) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 5, 0):
+	case IP_VERSION(15, 0, 0):
 		return &ras_umc_func_v12_0;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index e2d5f3d968895..1b23ffffc415c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -34,9 +34,13 @@
 #include "amdgpu_ras_nbio_v7_9.h"
 #include "amdgpu_ras_mce.h"
 
-#define MAX_SOCKET_NUM_PER_NODE		8
-#define MAX_AID_NUM_PER_SOCKET		4
-#define MAX_XCD_NUM_PER_AID			2
+#define MAX_SOCKET_NUM_PER_NODE_GFX9    8
+#define MAX_AID_NUM_PER_SOCKET_GFX9     4
+#define MAX_XCD_NUM_PER_AID_GFX9        2
+
+#define MAX_SOCKET_NUM_PER_NODE_GFX12   4
+#define MAX_AID_NUM_PER_SOCKET_GFX12    2
+#define MAX_XCD_NUM_PER_AID_GFX12       4
 
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define TYPICAL_ECC_BAD_PAGE_RATE (100ULL * SZ_1M)
@@ -89,9 +93,22 @@ static int amdgpu_ras_mgr_init_aca_config(struct amdgpu_device *adev,
 {
 	struct ras_aca_config *aca_cfg = &config->aca_cfg;
 
-	aca_cfg->socket_num_per_node = MAX_SOCKET_NUM_PER_NODE;
-	aca_cfg->aid_num_per_socket = MAX_AID_NUM_PER_SOCKET;
-	aca_cfg->xcd_num_per_aid = MAX_XCD_NUM_PER_AID;
+	switch (config->gfx_ip_version) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+	case IP_VERSION(9, 5, 0):
+		aca_cfg->socket_num_per_node = MAX_SOCKET_NUM_PER_NODE_GFX9;
+		aca_cfg->aid_num_per_socket = MAX_AID_NUM_PER_SOCKET_GFX9;
+		aca_cfg->xcd_num_per_aid = MAX_XCD_NUM_PER_AID_GFX9;
+		break;
+	case IP_VERSION(12, 1, 0):
+		aca_cfg->socket_num_per_node = MAX_SOCKET_NUM_PER_NODE_GFX12;
+		aca_cfg->aid_num_per_socket = MAX_AID_NUM_PER_SOCKET_GFX12;
+		aca_cfg->xcd_num_per_aid = MAX_XCD_NUM_PER_AID_GFX12;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -194,6 +211,9 @@ static int amdgpu_ras_mgr_init_mp1_config(struct amdgpu_device *adev,
 	case IP_VERSION(13, 0, 12):
 		mp1_cfg->mp1_sys_fn = &amdgpu_ras_mp1_sys_func_v13_0;
 		break;
+	case IP_VERSION(15, 0, 8):
+		//TBD for dGPU
+		break;
 	default:
 		RAS_DEV_ERR(adev,
 			"The mp1(0x%x) ras config is not right!\n",
@@ -216,6 +236,9 @@ static int amdgpu_ras_mgr_init_nbio_config(struct amdgpu_device *adev,
 	case IP_VERSION(7, 9, 1):
 		nbio_cfg->nbio_sys_fn = &amdgpu_ras_nbio_sys_func_v7_9;
 		break;
+	case IP_VERSION(6, 3, 2):
+		//TBD for dGPU
+		break;
 	default:
 		RAS_DEV_ERR(adev,
 			"The nbio(0x%x) ras config is not right!\n",
@@ -300,9 +323,11 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 	init_config.mp1_ip_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
 	init_config.gfx_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
 	init_config.nbio_ip_version = amdgpu_ip_version(adev, NBIO_HWIP, 0);
-	init_config.psp_ip_version = amdgpu_ip_version(adev, MP1_HWIP, 0);
+	init_config.psp_ip_version = amdgpu_ip_version(adev, MP0_HWIP, 0);
 
-	if (init_config.umc_ip_version == IP_VERSION(12, 0, 0) ||
+	if (init_config.gfx_ip_version == IP_VERSION(12, 1, 0))
+		init_config.aca_ip_version = IP_VERSION(5, 0, 0);
+	else if (init_config.umc_ip_version == IP_VERSION(12, 0, 0) ||
 	    init_config.umc_ip_version == IP_VERSION(12, 5, 0))
 		init_config.aca_ip_version = IP_VERSION(1, 0, 0);
 
-- 
2.55.0

