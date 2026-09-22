Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8C9C982F1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF0710EC1C;
	Tue, 22 Sep 2026 09:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g/2oFh0z";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4991010EC1C
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgX5DKv/AVMk0WGBimXx4NeF8+ko7yYO3O12z4dmbe5duWsE0PF8ZH2YAvY0hz170iGV9pRCPYYyt0NoAq7wf+gulrj5oMO5OKQGc+gKaNilIjnM6XDIBchNgYhari8I3vLGUa1z3BzJL4d/wJ67mCn/dTKwaI5T8mEYN+woDGuauv9FHEest3NNUAQZqSMTE1SdB0r4X/RHI/bgzZBjOx4ZBfiKcnqy7GI/vrKCHjytx5eDI/HrJMzco9Uuubn6vD1ojkB5GiSAQSyXlTRFF5mDANTm6t51T2e12Mnm9NNHA3QaW2NGpb1FRwVl2NVEdWV3fKcr4GEONgh4N521MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIcR/vAUqLtKko8I5wJn05ogQJFHVF8rSixrwDSAkqE=;
 b=c34IfPKmyifYiOC3i5c4oKRfp2c1YQ9nVPmgrFJOrrZqK4FYPe0LktPqSYuOeW24vjPvvDYJUb4rvWyDtXQlnCALyVg9iggN6SLicvVhMXUcHs2xShohT4WgtEHgr0yOzlX7GhjRIPCjJ3otistjVR5l9jzCxenGpnGZK0qo5esrICDiNPA62cUh6zL8oV6wZm3R2KQP26MaSBtZfODkwTyngD/omnaxe78XepTz3xwzjC6g8DdAJaafYQUh3iidaHc7WW3yVKTvs8JsR7wXrOQnQpF+eZdg/fBTvql8g1VJEWbrSCtEc9iKb5zGkQoxpg9gKl9Gdh8Q5E/qnZsleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIcR/vAUqLtKko8I5wJn05ogQJFHVF8rSixrwDSAkqE=;
 b=g/2oFh0zVrUqgpRfTxkF+BTHc13isuR8BAOsQZSR5BeHQv6sOAaCH49GbW9NxfaU8BaDHDKqzMOM7AyB0/wN3UNzHjXnjwvQDJCkcW70fkcAeCwrUzyzBYwmem6BBjeCV2teRSuFaiFHWHjUGY3Dcu7dzFIsaBlnWYbrjVHaSjo=
Received: from BN0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:e4::15)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:34:22 +0000
Received: from BN7PEPF00000096.namprd03.prod.outlook.com
 (2603:10b6:408:e4:cafe::55) by BN0PR02CA0010.outlook.office365.com
 (2603:10b6:408:e4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 09:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000096.mail.protection.outlook.com (10.167.245.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:21 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:19 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 07/10] drm/amdgpu: GFX12: set mqd->perfcount from mqd_prop
Date: Tue, 22 Sep 2026 17:34:33 +0800
Message-ID: <20260922093436.596947-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922093436.596947-1-lingshan.zhu@amd.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000096:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 88aa47e1-ad95-4223-82dc-08df188caef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: UNeRv6Z94MCNLzlozgL8O1AOtoMEdWY9Ilba8y2slJoC40G6NJb1pF2yuncAuZvglZW4zcQC0SuZDigAuWk4m06Zq2pSJBoUzVyGQMS2MtPnyiibIIOa8WGQjhMcAl1rSkcucdP8AEOGTwXiIEGS1EiLsqQR2pSLaayD+gSY6QU67HqwcOGf2HhgX94wE6aThQrJt9jwXsrYvbbb73oGkAYmsVWKvFYjA17L3XoeuvhaK5kiJgtNwkT3gZ5pfzJJG7VZi79aCC4gk1lRZXZ3m41hUISjqs26ep9Yel4fzyyPlcXIIYYHhY/Vk9DIL5hp1XBclzXalV609g2HA6LKk8jcXBUHSMs82qad/PUONFiNXYr6BX3tABJuSpWQWAntZU0Cgw1BtXDrwq6ivUFT1FB7klSa9upxJBYnTkBfYwjXZpGhZiokyaFnZB+SXkuJmekUaG8OqTUrah8wxH7+sm7jrMuYLxO99WbcTdrbm65kcRLHVWqAatCQwdg1KFCN94ZM7qwG6p1HIi24RTyAtXSiFZqitdzJy+KJrFCbENstP/hQB2+7BMrB+tcJJyDG4O9m4y/dZVVej2DQ5/0cGpGjHWdmndy9ekzOr2IYo3AnEM3ZbzhlPSnk5ti8uKV/fQ+aDT+s3LYB39w3GfzjVYk35QUU3sFC4+6MGUTfZlTA+/xA/t5WxfBCf6Di37rfe5nYJy2isvTCGMCxJO/AmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xwvgjxOvwmEcSE6ZeCH4G82S9z1cJZHEDrKQo9hIvTU8ZviA9HhKBfjiLgJBFxd8pGtscUYZ68f23oT9oHWyDrDZdj7S/kcsMopd/Q7gwQdEzfHuWg0YDb5N7sOuJM4+cKF52TxeMBbAB8Njp6Mx7ojJsZZKNjLZdzhOGtVhgzoETe2+tNtFTYn1CDkpXZDcS80Ff0Cn000g4zs1idwknH2y2yQzSkPGJ00gxXDzx8TseT56toDNbQeZhYjLQagrs5rjZsrxigUyYxDYIEM+sRqwW94NFzmmJ4hxhGsNJ4SOqBqL1G+QnKjdxUMXK+TzHSYBfdvVEjzF7pujiGl4zawSYLWt4y2W6Wwc+mLRZT0AOgdib2i9xf/lL+0OoFcfPnyKt518vm3wh4C/DBN5D6I35Di8FXuTzBaAiLHmlzTWiSph4i0iFp1er8raJoFR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:21.9554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88aa47e1-ad95-4223-82dc-08df188caef9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000096.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
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

This commit implements amdgpu_mqd->set_mqd_perfcount
for GFX12, which helps setting mqd->compute_perfcount_enable
from amdgpu_mqd_prop->perfcount_enable.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index e26c56b4216f..fe9d7feb42fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3160,6 +3160,7 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 
 	mqd->header = 0xC0310800;
 	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
 	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
 	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
@@ -3313,6 +3314,14 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static void gfx_v12_0_compute_mqd_set_perfcount(void *m,
+						struct amdgpu_mqd_prop *prop)
+{
+	struct v12_compute_mqd *mqd = m;
+
+	mqd->compute_perfcount_enable = prop->perfcount_enable;
+}
+
 static int gfx_v12_0_kiq_init_register(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5542,6 +5551,8 @@ static void gfx_v12_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v12_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v12_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].set_mqd_perfcount =
+		gfx_v12_0_compute_mqd_set_perfcount;
 }
 
 static void gfx_v12_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.55.0

