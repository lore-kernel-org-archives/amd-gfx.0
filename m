Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25330C88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E8610ECF2;
	Wed, 16 Sep 2026 17:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F21vk2BU";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010059.outbound.protection.outlook.com
 [52.101.193.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639CA10ED09
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCvz5zEX8IkzCWGb0r3BqIxZMX+MQ4jW/4PiFPWXG76DrjiJSaeP627tl2wGFCrDgwB8FWWzXrFn7I/MdRyb+LgJrm/Z68Q+WBgRWMeNI9P68UThBFfkcG7Ca38j803TE1z+3JE1Ej23Z/R8aEyVYoalRbIejG1WgVfOr9j1WgT3q137hqqX8kfkIr6wpV8izLGJ6NKB2r4+rMxdIQ0V1/OEBw0aRfLA9EWkGhWDff58F+0R5vwRzgUJ9DcwP00nVLuXkKTAmiUW2nHvoCO+8kqZ203GvCxEnmJ3+7XeooWQXiBpplTlZU6rQ7XSn8hvS9T911JWZk7uBrdeQCx0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmMoOn9Mo7yuAHMD4LYHTPZTXkQ/E9Z4rYrfEzYs6AM=;
 b=uvI33HwII0vDN0x9lab1cLQBiQacUrLdjsRG3fiIjmGMBkskhFNUoIBQ618baZe+h7KCObCaSMK5GKIjY/ocJfi33TWY5w3Aty34U5UqbF5hNUT+vUDqTNFmwyv3ofCElCtibZfSUy1BGJSILhDM9JPh/xDfr/v+BAaS4FgEn5ETCH1P9CGo+tOWYRCes/mqJEIqmHuj/OCsURE7/40m+uMV4zZ9Fh1Z0h4apI9Kj50P13VllUu7HUofJstdEB3AVca2MWm3GLz+tkAliXjRFzymCHORjd2phOKQq9Dx3UDriZ08qYMFe7K93jN/nqc+pLuxrGqoYcwG3xlhQqhP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmMoOn9Mo7yuAHMD4LYHTPZTXkQ/E9Z4rYrfEzYs6AM=;
 b=F21vk2BUn+Jvc7ydxuR2tYYRf7M8vSXqJIkjSriG534/kIhOMws5DYa5M2+sHoU5t4PaXK3b/RHBsXoWPNTXQKu64DHXtpOChT3eOJjGdOlbpRkRiAhZQuRQADZXmFImpG/3oDOPf/7igH28P9u6BmK8w8gOldJ3qv23onEHFi0=
Received: from CH5P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::22)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:53:05 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::80) by CH5P220CA0016.outlook.office365.com
 (2603:10b6:610:1ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:04 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:51 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 49/64] drm/amd/display: Fix KUnit MST warnings
Date: Wed, 16 Sep 2026 13:52:04 -0400
Message-ID: <20260916175301.368306-50-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fed8822-202c-4e08-e3c9-08df141b5bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: t5a4A6WAJmSrH2I0aP94XOKFrIlhYceJW6PS166LpOhQXU6WW7QGPtMvdcIRJaKPu6fwTv2yyy5Rl7lKpqRbQ0btL6yEx2TY6Y5rcrZn8n+qUEs4pxgL02Gz0V/PQ+ei0umxIINSI93FiVG7CJICDKDcXrT6hr6UyiVMei0rl+r76tUOJLcUXRUUJFACTV1VRPra9WKj1YxVO+8Ux9EpGcdAeSe5UH0OuKdTlc2JD7QhTyHUl9w0DL/mMSGkVNT4/8nM4DmOmcqAp4ZrtJHfEsGeqKDg4gK+gRAJdt6CmXdQTmP53bgN90bTWxoXZpSKDz01zb3exTKSX16xvUwlGrBkH9LJxATGxAaf9yeu0z6gL5KByTYbHDlZszVmlZdf1WEFPcV8C51VCYOyegN8uCdwsiucBHehZBJMjNqKkgBpgFnsK5KM09Bg3KdQm/tyktfnJDHN+/bhDmpqdlhJFOYaD3zCx/GMQLd9z2v1vgv4+lZP1hTaJAB6XPgtECePGxvfexO9NTD2NiX5Qa17EZYcRuMQjO6ZM3KvKt0arb9S86rG4DptemZIQ4qmJdTVf//u+zBwI7ffbpOcb9z+JrWNbkyU3l7ft6MR20DIVpPrLRYcowR/04OU9uW1vRT0B6WeuX+/LGnqGAjHe0BL2oQf1oLk1BQhd5489v771CIvqhreTlu9/vtg39OZfpx1PHWcGwfAKAxVs+0Wv0JmdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JinA13b4Njey78cx/If5ZM8lX7UD8OSGv5iGXs9g6Lqty3ZQKFd8uvU47b+tbUMsBPWJREGOV7sqTPjuI5n73+0gXUDs1KPyDD+pKa7zR5z8nXFR2rVeXHQFj8okA0N+oydOabDCzawac4+tqaNAkLxySA65om+tcY9IBcSS1wf4EJVp3dbXMDI9Cwbu+W9F7bhIQl/wKG4D5hWlDqfqfyc7fc/aqbyHT/HJPCHU5HYrVTYVKXQXkaxMYp9TFdGsAXI+5UurhmhWgltFD+HSRTPrIgCYiLcH5Ya7m2SAXEmETTxOr9M/sUvJwji/hAeZ1fl+YHLGwx1WgWpl+RU2KS3LrqwqlCowqKC0OH2y4BN6J/llfrx04P9GTHAx4EI9y1lGh/WBFoGEPQnFNxFeaLmWC6eeN40tsNi7uz0TIjs7P0Pu28DI7W/onfCQ7T+S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:04.4241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fed8822-202c-4e08-e3c9-08df141b5bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
The MST add-connector fixture registers an unmanaged master connector
but does not clean it up before its KUnit-owned storage is released.

[HOW]
Register a KUnit action after successful connector initialization to
run drm_connector_cleanup before freeing the master connector.

Assisted-by: Copilot:GPT-6-Astra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 382eafab2d43..eafa3e6733a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -1311,6 +1311,13 @@ struct dm_mst_test_add_ctx {
 	struct dc_link *link;
 };
 
+static void dm_mst_test_cleanup_add_ctx(void *data)
+{
+	struct amdgpu_dm_connector *master = data;
+
+	drm_connector_cleanup(&master->base);
+}
+
 /*
  * Stand in for amdgpu_display_modeset_create_props(), which the test module
  * cannot link against. Only the properties amdgpu_dm_connector_init_helper()
@@ -1368,6 +1375,8 @@ static void dm_mst_test_init_add_ctx(struct kunit *test, struct dm_mst_test_add_
 	ret = drm_connector_init(drm, &ctx->master->base, &dm_mst_test_connector_funcs,
 				 DRM_MODE_CONNECTOR_DisplayPort);
 	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_mst_test_cleanup_add_ctx, ctx->master), 0);
 
 	ctx->port = kunit_kzalloc(test, sizeof(*ctx->port), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, ctx->port);
-- 
2.55.0

