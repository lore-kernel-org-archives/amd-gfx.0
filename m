Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CC0C98318
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 17:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C026410F6DA;
	Thu, 24 Sep 2026 17:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iHcZxQNb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE55D10F6DA
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMa9A1w9CO6wPCYwqp2JguMBmaPd+r2lPesdLGrFJTn25d7eWa+7zwn1SVXjb4kidpLX3c9zEVTMX8o/rbpVul835WUlk0zb175Gg9/FUNxpbt1uf6Hp+Acsm1f3I/gCqPbXDs84PP8CTzimv4V3q0Efzku25/+LiyMmMO8NmuIWsMoEKwSJRQ+zdXfpqv8dOETSpB5Dj1Ijo3qVhxejaWOHjX5iNVNJuHXrproHwUtuZFpsrtsICAjm87/p+DNRYLaGZ6H4yftebkZA9/LqwDzXycLrpPaHtUwdumcheYpub4shhjIfNg2KgfuFdGhDgJ+vOKF4Ykc/lTL5qOp+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vb+lSISDD0SFo/ihLd7cEs9yd2bT9zi008M7568QrTQ=;
 b=KBwmH8eoKBLWLbm8MaZViXE7XyjJi0u2j36SFdRRpY+gh3unW9+LtVG+bUNtKFgWOoobFBrhz+aE9cvmsB/47aIm02WyMpD7k1QqHXN2IsnnnLTYOPiHIp3imVE+lx6bhXauGrG/+IkGhairtdAEtJfJhJuzJC8jtBJNQycS0JWOenpC/iDS+mxT8OfwGuJMNmahXWWH+IpWae0CEjjki11diRLnhwi5beQNZ2e7hr/6P0C8UpLWA4sjyGPTVRIF6wHC4xrxiCGsFHtOS894MiVjVqyzCaFhNnGaC97wpVRp/emFQTbWXVDNYgNW1L8PG23Aib+gIhK0VduE9C2uOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vb+lSISDD0SFo/ihLd7cEs9yd2bT9zi008M7568QrTQ=;
 b=iHcZxQNbiinwLzVFMbz6T9pFydh1EwWHO5CZ9KK0S/awaTMqiWgHboY471CL/TUvR/lUC7SIZIkeE4QmSMYxN3dxHZHgLReODxZEG34g2H1IxIyV6KPPVqEm6hKSL2UE48ymZJWFRx/DQDKjIqRUH8dAiFUOE5IKJzZwEDZ6w6o=
Received: from BN9PR03CA0244.namprd03.prod.outlook.com (2603:10b6:408:ff::9)
 by SA1PR12MB6799.namprd12.prod.outlook.com (2603:10b6:806:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 17:55:07 +0000
Received: from BN7PEPF00000090.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::4b) by BN9PR03CA0244.outlook.office365.com
 (2603:10b6:408:ff::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.15 via Frontend Transport; Thu,
 24 Sep 2026 17:55:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000090.mail.protection.outlook.com (10.167.245.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 17:55:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:55:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 12:55:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 24 Sep 2026 12:55:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gangliang Xie <ganglxie@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/ras: add support for GC 13
Date: Thu, 24 Sep 2026 13:54:39 -0400
Message-ID: <20260924175443.636193-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924175443.636193-1-alexander.deucher@amd.com>
References: <20260924175443.636193-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000090:EE_|SA1PR12MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: 26bbd898-e105-4a3e-fa0a-08df1a64f867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BEoCmTkEjs8vv1kWGvidrcut6k1RslMMkk7lCggz6QFF16WgeM/B791Bxq1QyzEW3m9svyIQBQ7EDjGtHg6EX73DffEBJnE/iAgPp1KrBC4IisAyFeufA8YvnB/17GYNU5RVRxLUm27v2zJl/g2x9v1sjWxo8xeUS3dSkVrqSRO1KKhOY+HllpsYDdZ6IyVV0d5T9ziIHkKCVgt7R1fefhb42jOx7Mhxhlea18GmqlJu9iJzBYFSDjfcf52aVejXKEUHKrOMU6rHI8ClYlBR7NeWsnEbbRxSDNrMSEAX16nBB82d1mZugkEi0QDFzy/SbKg3hvsuhUWQW9gU0YBPQPYWjQuGrVfvPLLPkKuObbWVJH9Hw1a2sQit3ME4EW2KEsgXg4D7AzzxcI/xdR5+AG1nDMGaqaXhg/3gMT4TIY2FqRh5jk37Rem7YeC9d1iZV09fA04fOAMLW+Y71f+4YhaGM6Ppp5jupIPItjSV8X4PM+INKBbFbnXG82m9aYJznBlHaTaXJ6a16UzIuO0vMBJPC09yQdYwS8rMqYqyIe4q4wFEyL/d7I3Xick2hpDkoStzOh0H3NqkxhhrJNRtWoIDjaJviAMPkFQG0a0k5uAQg0ReoiAv50o+L73i5T6/IBBmxOzcfAlOTKkR5Jo6Ng4pjL0tOeFz9OO7MU9XAZWOg6o2qnjRhErzrsD7m1Rv/FqfBG8088I1m6c4Uw0e2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7dL8/K5YL9xg9Pg/E4XXG/6Y4Q1cWf2Wp5srBQiABcv0zvL9k4o6JzC1hHdVQFaikt8u+nr1EGjn9mKWyHgUsgLgY0VY1oj8EQ7kIxMSAQrxGDjE9EABGWsit3t9CddAt9+XaAZ4hmW0zdCVunbC6mGqgAR4RyMaYF4sn73W8eG+ainIVqCUp8EkyAzeNTDxraFnmv6jiLlpXOGZIkQt4rQ9ZmoWnJn9xcaCogN2AMBnYWyFxw6sfMglma6zBwyGu+hHKzz3vnZEfSAx/rYAjOn3UNYC7xtHy8+6fNJYTtUJWTJ/4IXD162ReD56fh/embbVjF21XPtRsyiE3tRy8/6+NTHqi1MxE60m5ZoQp13HQ60REI63NixSQTPuHpdhEOLNJwfZvmBQ7d1NaQi6FfDLSxuKJeEfIsj8+8kAo795D177t27fOYSVRmnu9jxB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 17:55:07.6071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bbd898-e105-4a3e-fa0a-08df1a64f867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6799
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

From: Gangliang Xie <ganglxie@amd.com>

add uniras support for GC 13

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras_gfx.c           |  3 +++
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/core/ras_gfx.c b/drivers/gpu/drm/amd/ras/core/ras_gfx.c
index e553f1364d6c6..39ae38a89486b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_gfx.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_gfx.c
@@ -38,6 +38,9 @@ static const struct ras_gfx_ip_func *ras_gfx_get_ip_funcs(
 	case IP_VERSION(12, 1, 0):
 		/* TBD */
 		break;
+	case IP_VERSION(13, 0, 1):
+		/* TBD */
+		break;
 	default:
 		RAS_DEV_ERR(ras_core->dev,
 			"GFX ip version(0x%x) is not supported!\n", ip_version);
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index eb5722a597863..2ae3e8c293167 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -41,6 +41,9 @@
 #define MAX_AID_NUM_PER_SOCKET_GFX12    16
 #define MAX_XCD_NUM_PER_AID_GFX12       4
 
+#define MAX_AID_NUM_PER_SOCKET_GFX13    1
+#define MAX_XCD_NUM_PER_AID_GFX13       1
+
 /* Reserve 8 physical dram row for possible retirement.
  * In worst cases, it will lose 8 * 2MB memory in vram domain
  */
@@ -115,6 +118,10 @@ static int amdgpu_ras_mgr_init_aca_config(struct amdgpu_device *adev,
 		aca_cfg->aid_num_per_socket = MAX_AID_NUM_PER_SOCKET_GFX12;
 		aca_cfg->xcd_num_per_aid = MAX_XCD_NUM_PER_AID_GFX12;
 		break;
+	case IP_VERSION(13, 0, 1):
+		aca_cfg->aid_num_per_socket = MAX_AID_NUM_PER_SOCKET_GFX13;
+		aca_cfg->xcd_num_per_aid = MAX_XCD_NUM_PER_AID_GFX13;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -281,7 +288,8 @@ static struct ras_core_context *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
 	init_config.nbio_ip_version = amdgpu_ip_version(adev, NBIO_HWIP, 0);
 	init_config.psp_ip_version = amdgpu_ip_version(adev, MP0_HWIP, 0);
 
-	if (init_config.gfx_ip_version == IP_VERSION(12, 1, 0))
+	if (init_config.gfx_ip_version == IP_VERSION(12, 1, 0) ||
+	    init_config.gfx_ip_version == IP_VERSION(13, 0, 1))
 		init_config.aca_ip_version = IP_VERSION(5, 0, 0);
 	else if (init_config.umc_ip_version == IP_VERSION(12, 0, 0) ||
 	    init_config.umc_ip_version == IP_VERSION(12, 5, 0))
-- 
2.55.0

