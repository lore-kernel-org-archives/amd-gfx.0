Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F4ACAC592
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7826310E3F5;
	Tue, 16 Sep 2025 19:12:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jxGZt2Ud";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012035.outbound.protection.outlook.com
 [40.107.200.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527C010E3EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDFRQGsK5Y3qu3AXgAQzl22U5DLSAQ6rRF+wpwThEcqEpDnsPq8HcoRGse030edKSqtxX1l1AjP1BDSvldj8XwlAPuCkm+Ttjco7KGbG3e9m9EpdGkbBGiDPFIh9rYOluLLmiB5fHKLa5wyOOV9MyixaZeGhogGMHzm5q3wpC4aslqL396AaKmIGWkbKLJR9b9tVxiV0lOI6r3kzTsNlTVcK2xXH5uHEsV0mO+QlyK8TRXOEQZiS2YeneIFRFA6qbF4LYkhU2UasJNhz/rmTl54h0nbXnCx3E/jxcjvfxLntBFJY4vGF2ePNwkdIAT36B8BYubTVlvBC2NwO5MAh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVmoRkTezhNokn8caGQ+lxYr+Z2OO40fpiUctsVRD4I=;
 b=L+yzDni1Avb6tBfdsA4WOv5PekRXHKYT6QONxpSSoPm+9yTTFUD2B9OTpveVf/vi5yy8hj70bLHNhTvQ3f1qGGoDVIPeQIe26mobtlir245etPeBGxVGTZAC22tgQhDWhSH6ZD0/DVSImDHxLo7eOx/atcBesKT8K32LyBM83voK7bSYkVC9CCavhzyaERTS4qjrsHgnGxD8BgmhkWMzob/zXBK/0DSjTbDmmuQ/kVEblJmsyfcQLG3sDJOhzdR545vWYNFiCHo3qbLAiMiCyg30ieNRb4qJVGVKZagymfHG/UXXwJJxx8XiYK0Ikr1N/lzMWiiypKu4IUu8xFIpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVmoRkTezhNokn8caGQ+lxYr+Z2OO40fpiUctsVRD4I=;
 b=jxGZt2UdvMlftajXUbGXQpzsb8ptrEiGwfPFeGZ1qfhHzm0DnKd/fQdUjAXD6dvY3Pot4/1sgh8DHZqP26DzRULUO6S9iueVbrRq7VtA42AksjuzDWystzAHSGA3UD+22ZRslAPfy4tE5ZcXDQ/1wJbC5xS6wT4SbFS8aMJzmts=
Received: from DS7PR03CA0336.namprd03.prod.outlook.com (2603:10b6:8:55::20) by
 SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:15 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::77) by DS7PR03CA0336.outlook.office365.com
 (2603:10b6:8:55::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 19:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:11 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Sep
 2025 14:12:10 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:10 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 07/20] drm/amd/display: Enable DTM v3 on dGPUs with DCN 3.1+
Date: Tue, 16 Sep 2025 15:09:27 -0400
Message-ID: <20250916191142.3504643-8-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f20c1c7-7d87-4239-8576-08ddf554f2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cl86AyHUMGtWVhgPSVKiEaQKV9bDj2RqLeYH9G9UrI6ZB5jmd2DrblQOC8Ga?=
 =?us-ascii?Q?nMf+unKtELWuZg3GJRt/YVNp96nqTbzTtbKM/XYW43cL+D/s1zHD52Rb9joI?=
 =?us-ascii?Q?LjziCXN8tIuxSWufDO+zRYuj9CS9T+drI1SerKvUiiB8RIwsxG9L2zJJH5rm?=
 =?us-ascii?Q?B3FI9jwSskLuerDxO4mfIXkXG0p0oJHQs4nDVWZ/62kaTau1spwiv5qqcRQE?=
 =?us-ascii?Q?y3B9+I0898hyrMzBF6b26T7vm4dqITGQ2LuDsl4bll70XMA7A3l8J7+VfVPr?=
 =?us-ascii?Q?jBVLR+rwMn+HPPEX58Bdxq/NozwqK71E7i8LDMaFJni0Su79cX9IvB9J5Not?=
 =?us-ascii?Q?kv6sNkffKCYuGHWunDCIgkWV+ZY/paPtLbJlYQtVOlLGO5ow2i4nHG9r/zNm?=
 =?us-ascii?Q?S1CrLGO4aznMPwnjwrLEsrtfcFKivl8tlnG/jfERpN+l5ycJK9el+63vhuXp?=
 =?us-ascii?Q?ffzIz8QLm7DZ8d9cipsYjSrracBQ9BGvM6bQXF/t5ljc9ufr7XxdUCDNBxtk?=
 =?us-ascii?Q?DyGVe7DyWx2gKrdPebyvDj2Lh0P1A97/Y7wPgM5sG9Ur6ZAesTIV3Yi1W9ye?=
 =?us-ascii?Q?krycSR1WsSayYEA3cTkDsO8mT+jXwVRZg5IBPyjXkdTiKAPpl3NRt1XuvQ+w?=
 =?us-ascii?Q?PXbIzVuux0XYonKp7SE6En0Z75HbBGwsFscegoauX0+IoM3Gda0yCYv8+WcD?=
 =?us-ascii?Q?jLi8aNy8fERZgK7BUdsj+EFyn4WUije4Ale6yZZm/UdW5z3HNhOLqPVUU6tv?=
 =?us-ascii?Q?OQIzL8IrQ6pHXdI2FUYm4dyUVnBSJB7swQOkM3sTl7ECsCgJP5sndZdsFYY/?=
 =?us-ascii?Q?Gy/ULz1V+/YUSyr9dxm4fhMcp117NyTPzdCqBduIV0WKjAVVVwxpWBEZruLB?=
 =?us-ascii?Q?FwFpi+QADbSgp3vUOs0x3t76mS20D+C2U0+NDqkzKoOhkYTrgC8TXOPCMVWl?=
 =?us-ascii?Q?29FHWa6ukRblV/2Ekwww9gJWuC8faLU/eT0I8Ui9pfc+jeZeFm/3W8Qe2xbE?=
 =?us-ascii?Q?ITT9AJ+L+74ZH3NL3M3eVF2r2htg6kJ91++vOxdOB2gJgIzq4oHAqJb/4B1x?=
 =?us-ascii?Q?Rb/Hm3Pn80NI+2X3vTvNEPQQsvKTv13h7fuOgg5Gnj5x4jynl4kH8orBpsYe?=
 =?us-ascii?Q?4TjUDNYviddqwohLki9bLDwdH2z2VeCY0+f8r+F/XnQgTyXVSkP4REiPFtii?=
 =?us-ascii?Q?NlSFUmI8FDLHrq/eglju/XaKktGJ/f5uxgPmFdlZ/8E7l9+RGcOEOHR8bhsK?=
 =?us-ascii?Q?HaQMRKVqNoLzBfIWwH/BCsR+CQ3JIhhi4dPrO0X3tYs8YJAo8p2wtTBUipfO?=
 =?us-ascii?Q?ZNLwChgq5YTi1RYeGUd6D+iXJ3eG8Nmbn1mA85yrabZyjNJf0Gj1WuYV9T9R?=
 =?us-ascii?Q?ZnXHjV0ba28Kvlih2qIfpc1QAkTWIYKWkrocsQ1lzMEq3ii9oORAVpii2K91?=
 =?us-ascii?Q?5GuN0ymIn05JmqCmZzIRyN/rD0gD8viiC7qT4LDJQKG1sxVUZUhfRKP462mY?=
 =?us-ascii?Q?haM92Rj6YnlEmQ5s8MHIsQsaMiYKcH5Jv0pA?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:15.6650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f20c1c7-7d87-4239-8576-08ddf554f2e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Right now, only selected APUs have enabled DTM v3, which allows to use
newer firmware for content protection.

We want to enable it on the dGPUs starting with DCN 3.2

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c   | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 30e3ba7e69f7..38eeb1211cca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -768,14 +768,18 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 		struct mod_hdcp_ddc_funcs *ddc_funcs = &config->ddc.funcs;
 
 		config->psp.handle = &adev->psp;
-		if (dc->ctx->dce_version == DCN_VERSION_3_1 ||
+		if (dc->ctx->dce_version == DCN_VERSION_3_1  ||
 		    dc->ctx->dce_version == DCN_VERSION_3_14 ||
 		    dc->ctx->dce_version == DCN_VERSION_3_15 ||
-		    dc->ctx->dce_version == DCN_VERSION_3_5 ||
+		    dc->ctx->dce_version == DCN_VERSION_3_16 ||
+		    dc->ctx->dce_version == DCN_VERSION_3_2  ||
+		    dc->ctx->dce_version == DCN_VERSION_3_21 ||
+		    dc->ctx->dce_version == DCN_VERSION_3_5  ||
 		    dc->ctx->dce_version == DCN_VERSION_3_51 ||
-		    dc->ctx->dce_version == DCN_VERSION_3_6 ||
-		    dc->ctx->dce_version == DCN_VERSION_3_16)
+		    dc->ctx->dce_version == DCN_VERSION_3_6  ||
+		    dc->ctx->dce_version == DCN_VERSION_4_01)
 			config->psp.caps.dtm_v3_supported = 1;
+
 		config->ddc.handle = dc_get_link_at_index(dc, i);
 
 		ddc_funcs->write_i2c = lp_write_i2c;
-- 
2.43.0

