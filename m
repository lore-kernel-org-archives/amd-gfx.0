Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEAFC5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 19:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367E8113961;
	Fri,  8 Mar 2024 19:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZCtM2okV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2239E113961
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 19:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9ZqUWs1gvu3f3ud+7gj6QMfPyXQU31/ye3hBrF1z7+3UIQy1AizxNO3ln8v4Kmxq4Vv1vyec1Y21A5zyBwFNHJkOfODwrEcY3b6UoFw9WisesAYZRGJb7jvWtlUm/h00kMwkglVVuFLiCUSSWI9w8TbxFwkNttTyqJNF3eA8Dpoyz21Y/1AlVEx1b0diTEd048n60kCg7qrt6gWwWtgSzCX95XzgBFBORPtjE6UOvJkAPipxwGKascDZPhYvOmfURy1JyrA4AImf6LdxhyPCOmAFCiumeA8JXB7MU8CshewYE+yK53qjeD1dCtwzvDqoX+tiA2bqSJCctMKKyP7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze3CDc9X7KPHB5AbAcj66v18165oK2WesR7zZCR/czc=;
 b=G2DIrN/qAjLkWWSwMlqYxoW9P9lJ+gHo5Agrw8h/8u1n55aax69sKYv2jWgPwkmrB5eRXa7MY5Oytz2pNPLGKVV31jPc9Vl8xE6rn8PbRa5ws7Emj99AddRTGXCDZzvSywXZYcyb6BA3wa4i5XMUso7WfZd/I2TKWYUbp+2JUlUj8iUxA7LZ/mcXDwUYhpbFo6grrMVtNOhz70NOEQQQY8Vjm9BeIXLjeRkX5yCJ1eRAO7cmCO2lJT6PT6Lp17ucQJ4CtO/mv13xgmKTjG9AzNUiV6o0YU+ETh1+6f9zUQ6i+w/pY09LwO0AlytARKdnXBDUbNivfjqHwkvnKBTT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze3CDc9X7KPHB5AbAcj66v18165oK2WesR7zZCR/czc=;
 b=ZCtM2okVQnVxzzVOyTzjz1xJIzu8dfSl9s4cG8foj86l5Ml5CEoXeccGcgWKqurO0+vayLsjoCHsihVtk1w9a+HXxvEqR0bzybtObb2Q4OfkAMQFPz+Ep4CpLmJxy/GHw/rtEARknTHhKPIc7r5+PKgrIznKkpbPwHVP/EhJJos=
Received: from DM6PR10CA0028.namprd10.prod.outlook.com (2603:10b6:5:60::41) by
 CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.24; Fri, 8 Mar 2024 19:00:47 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::bd) by DM6PR10CA0028.outlook.office365.com
 (2603:10b6:5:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28 via Frontend
 Transport; Fri, 8 Mar 2024 19:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 19:00:47 +0000
Received: from banff-1e707-e02-2.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 13:00:46 -0600
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Gavin.Wan@amd.com>, <felix.kuehling@amd.com>, Ahmad Rehman
 <Ahmad.Rehman@amd.com>
Subject: [PATCH v3] drm/amdgpu: Init zone device and drm client after mode-1
 reset on reload
Date: Fri, 8 Mar 2024 13:00:29 -0600
Message-ID: <20240308190029.7678-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 91c35daa-20b3-4693-3eb4-08dc3fa2109f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KXoaxqZXJOoEQBuavrlNxuqjbP3OrwCKnHGGy4gv7EkhJCbiPaiKB5VPsQfpqsTJP73dtpFA43bRhxBSS//y//tUAIOhWMA9cxGlDrf/jXOwF052ntQRH0Ws6A13yQ+AXDBqv5Yzqdyh6AlTgpMc/6pjLNYsLbIKZLnrENgs1lGzUsuzuB6Gjwm8rWkwGpkTQv6fpnZ0W0BKJIWBOlX1GU5TLMt7vxps8UN2GDPRkb5hJn+gO73vGi7KCDhumiMZ00P3M9QbXSSDtVMdcLyYWZnp7RcF8b9TtrKxe2ChuJz4dLoVUBBDGpeI4sXBGZQPCrFXjLYabKP6bIJ8vI8oLSEGf31tdWdm6C/2Cn4+t5B7DAiQ9AMIp4gPl3P9eKW+a7zcYFzoGdxfjr5TOYqoAmF+AoAoq/+KusgdlYFeJofMno7klKo+zuerd1d+l9ieAN8hCW09f61w+zxyGXhkKFlilcfO0VP0q08Z+d/t7sDsAT6sr9VypIkZ97OlF2pX9/xN40rW2guoZccd6icQ66YgDC2Gj1lf9UDbQp5eEadwe6CgF0CILInKuglc/bM1XUvlf6sEdSDjI05sVhOPIXWOL3lbBUDVjO9nCmy7hNpjdZON4ux8DXW50ydSoY5cGZz++3WaWqPB6XP2DlXHtPS+Om4y5YuWRfavDGv3+rJb03fdBbKlT3I3IX6KtASEcQKVl/sdRR8XV2pBAG7p/HDAUK8PuFRnDqePUTjlWNPxmMR2Zi+oUtkLlz+JemJB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 19:00:47.5110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c35daa-20b3-4693-3eb4-08dc3fa2109f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340
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

In passthrough environment, when amdgpu is reloaded after unload, mode-1
is triggered after initializing the necessary IPs, That init does not
include KFD, and KFD init waits until the reset is completed. KFD init
is called in the reset handler, but in this case, the zone device and
drm client is not initialized, causing app to create kernel panic.

v2: Removing the init KFD condition from amdgpu_amdkfd_drm_client_create.
As the previous version has the potential of creating DRM client twice.

v3: v2 patch results in SDMA engine hung as DRM open causes VM clear to SDMA
before SDAM init. Adding the condition to in drm client creation, on top of v1,
to guard against drm client creation call multiple times.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f5f2945711be..4389d24f36e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -146,8 +146,8 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
 {
 	int ret;
 
-	if (!adev->kfd.init_complete)
-		return 0;
+	if (!adev->kfd.init_complete || adev->kfd.client.dev)
+                return 0;
 
 	ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
 			      &kfd_client_funcs);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 15b188aaf681..80b9642f2bc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2479,8 +2479,11 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 	}
 	for (i = 0; i < mgpu_info.num_dgpu; i++) {
 		adev = mgpu_info.gpu_ins[i].adev;
-		if (!adev->kfd.init_complete)
+		if (!adev->kfd.init_complete) {
+			kgd2kfd_init_zone_device(adev);
 			amdgpu_amdkfd_device_init(adev);
+			amdgpu_amdkfd_drm_client_create(adev);
+		}
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 }
-- 
2.34.1

