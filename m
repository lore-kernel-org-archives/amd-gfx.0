Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FC606A327
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=STN/o88w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287EA10EC21;
	Fri, 13 Nov 2026 14:41:56 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA68910E7FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnaAvskgsaUuopqlfDcMlFynJCAHIhKheI7LH13zr6wMa4HE3GApKntIcO+DLqIaX4HFxqvJpSEhUIqzdl3Qs6OwXLvYx4SKsQ6kSmF4lvyT2XIAOKK9gxOGQW7Xj69OU2j98QlYE7WbpOntQwcZrPysslY/yB0iYnKS+CVgYO5sZSJOzF173di57E0kmpPW4iS7+HssuyLNgqyHAvqpZKRYOaq40Tg5nykUCUdMgk4P34fD13EHfLB/ArjHf6zZyIgYUTG4CGaTdzkFNBIzP3aG1latpieEucu/ffGFz9GhOgshSN7mR48R99SC6qkilg+VNw3nlNiwRy1eFCNM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R73wGaU/g7K/mCeEwBPPiBgO51nILTV5L2Y8N2VjGMw=;
 b=hLjPGRwuV2U+K7pYtzSYaNnT9Q9raopLmZBjvi1+Xc3jWl9IvbdnylUwT6XR8V4jXhOj120BBVCtY9Eghgww1hjFzXOpB91l34oZhotYz/egxPI7yvcUHSz6GuiAEKZ1wpsuqZHu2kHx2gl7kobS/bXzd6cRqMQqGpUaVhrLaoyZuBKJ8HhuG/0FMe1ctW467s6j5ReNeFhkYYfxXw7XIKjKl2H5dP4OJOREUod7nGTnCgvVR9O44LzSdBuKLWK6kd2z8qat2MeNHSo8lHrcZQXOOFoPVNwg+JftqN5zj0x61RLQyiymcnxtmBJyynd9fMhdbGOfZYvsw0xc+zU9Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R73wGaU/g7K/mCeEwBPPiBgO51nILTV5L2Y8N2VjGMw=;
 b=STN/o88wqHXsUtI3zr7/PdLQ0ON7p5k6PrQmEzUX10icz9ESl479MtYgyManDSHLYGIOvJS9yEFJcJtMmJcPx/6y/UDJh3bds/J2gSoPkxmxXApvvLJ+DvVFUVCCVWPZMnx3QgLWmoEOrFVazvYBMGLWT3+hZY+4M1PBnV0NLQw=
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 14:41:42 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::a2) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 14:41:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 14:41:42 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 13 Nov
 2026 08:41:40 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Fri, 13 Nov 2026 08:41:34 -0600
Subject: [PATCH 3/3] drm/amdgpu: release WC memtype and MTRR when
 amdgpu_bo_init() fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-superm1-amdgpu-memory-leak-v1-3-4a495cfc2c92@amd.com>
References: <20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com>
In-Reply-To: <20261113-superm1-amdgpu-memory-leak-v1-0-4a495cfc2c92@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 599a1320-a64b-4d5c-fdaa-08df41943bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|261021123027099003|261009223027099003|261026121527099003|261021121427099003|261028144727099003|261026140227099003|56012099006|261022105027099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zPmDm3oK+YEpNnQf+HlzqZw/GBX8MmgMzPMi636MaRK3D6lVozFo4AkIt5R4YCwi4NWca1ySZE9qs5l0Q852tiasrsXQvqcR9KlUnndp+sYio1qFnMUbFH+AH9W11AzJU/lSamJM08VG6Lhr6IIm6PKkXS+08jG+UzJ69TDeJDKUeXlvH9redar9WgQ0pqoVXe6oVH+diAVV0MvRGc+HQI9+I1Aq9Y5d+Xzxa6sYDnYCAwK7EO0bI+wNtwlaewMQiXYur1A21T7FBXk4nMKB0ay6jHpRC6evPAmGBQZukiOJCfbehjBGZZJUaHlVXnnHw/mXuNNDAF49HoUqxyrS4CWPUTodbFGtMJUpZfkCk6VtwrdrU2ruUua6fxflyTr29pS9xvlmCkjVWjldJAjytBdBCDvEPHBoJ3lZMeUmU6RwnQOwm3TjoqvLWqq4+b45OOLfajNZKpfg3GPMVmEHplO3YRW1llqbIVA30TlI3kReoPkPjiZgOLYQ+6oTZq6rS36P9HEXpAWQ1IveqZT4IUtcZHQH4krbs3l6Hxofeum9TM9vnCQiSF3ZVuyjihYTSaOANYq0AllvInaTwYL520KG6AROA0gjzHud9WffD0TqjHQEMF9qH/clq2CUE4yJxLCBxan4i248jf2Kv18ufHgaIeXQVel95M6y7wswM580VcrXSa5x8RKRkw3YJkaIt0FhZsqDcYzfU4Co11yRTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(261021123027099003)(261009223027099003)(261026121527099003)(261021121427099003)(261028144727099003)(261026140227099003)(56012099006)(261022105027099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H+xsWmhJ5XMHh8AJnQ4qWuFqaFUc9naB385DN7GdiBqMWvQhfQyUCKyXMjB4EqDLlZDFm5/Aijlf66lCm++Wk7Ye2Gy6Hbh6WLOGHH9FwmnASV2C4xXZq8zzPQGErYp+8W5SQJRMth28xp0pITdaZsbf3db4i3BqlmrI3aswrsbi3GmBospH0C4v9KU5JNlBk6WPSTtSOYAj8yneHgXWf+R/ffwTDe7M38kPiBQ8tKwrnac+x4a7yMeNADFtPQL6HvXZ/NbnYVlNLi82MS8waNRrJ0GKKJZUAMKlj2wZV/BehV04GpyRbXaYaNGXMi+zu8mjWxkDDEcb8i8d5Uu9+y6CwaPjjkVFjgvmVwXSxBH5XkW1HatVNUttHhahWMwEfY1+4FRi++caZs/TGbop7EtV9RkYsG8RSclBrOLH27Bw0QT7adCfzqFW9vTAA+DF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:41:42.3656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599a1320-a64b-4d5c-fdaa-08df41943bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_bo_init() reserves the WC memtype for the VRAM aperture and adds
an MTRR before calling amdgpu_ttm_init(). If amdgpu_ttm_init() fails,
the GMC sw_init callers just return the error and GMC's sw_fini is never
run, so amdgpu_bo_fini(), the only place that drops the memtype and MTRR,
is never called. A later rebind then reserves the same aperture again
with the old reservation still held.

Undo the memtype reservation and the MTRR in amdgpu_bo_init() itself when
amdgpu_ttm_init() fails.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6aa895f63aeaf..0b34458301f3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1108,11 +1108,13 @@ static const char * const amdgpu_vram_names[] = {
  */
 int amdgpu_bo_init(struct amdgpu_device *adev)
 {
+	int r;
+
 	/* On A+A platform, VRAM can be mapped as WB */
 	if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
 		/* reserve PAT memory space to WC for VRAM */
-		int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
-				adev->gmc.aper_size);
+		r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
+					       adev->gmc.aper_size);
 
 		if (r) {
 			DRM_ERROR("Unable to set WC memtype for the aperture base\n");
@@ -1129,7 +1131,19 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 		 (unsigned long long)adev->gmc.aper_size >> 20);
 	drm_info(adev_to_drm(adev), "RAM width %dbits %s\n",
 		 adev->gmc.vram_width, amdgpu_vram_names[adev->gmc.vram_type]);
-	return amdgpu_ttm_init(adev);
+
+	r = amdgpu_ttm_init(adev);
+	if (r) {
+		/* the caller does not call amdgpu_bo_fini() when we fail */
+		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu) {
+			arch_phys_wc_del(adev->gmc.vram_mtrr);
+			arch_io_free_memtype_wc(adev->gmc.aper_base,
+						adev->gmc.aper_size);
+		}
+		return r;
+	}
+
+	return 0;
 }
 
 /**

-- 
2.43.0

