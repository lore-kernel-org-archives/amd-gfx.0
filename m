Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1ACD3A681
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ECBA10E6CF;
	Tue, 29 Oct 2024 17:43:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y4tI5qVh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B947010E6BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf428YETpRCGO3ydOvib/WHofkGfVwwCCn9Jm5gvn9I9BCmpI083nhU9H7p8DP/EVk6DywZ4ttzM1QxyA4vUHgE6ZaDDsQhi+YEcTrC9yuHdi/ADXPUmYBtWg7Ci2K5oy+rl9A8kjAjq1+QnIiBu4QVvwQce2YLxuHyY3gl36/XYzA5f3Bnm85uHbZ5y8RsBy/czRDNRccXw6TeS2CY4euGeFsXRO/4C2cRNzg6dG0ynAatyQUwrGLPNJRaLEV8vKHfU4Ap0Eszal/gfattZ1DCqarBPfD5FZ7PYdXizmnTXFHsuH8caan1osgYNEMlRua5hANf7dnxPsyS2NbUwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+xvzIQNx/cKb0wN/8jnP8SlVrf1Drn4WUpG2lAHTDw=;
 b=aqlwoyjjukAseUDrJlwK6FvDqiBalVkU9vofR+TkXuQShhv8MLxXiACaO6Lk3FEsDJ0SYnnp1EGpPY6qDuqSctg+r0YtamFMhW4sKuoIGe/KUs/8jT4x7kXxXQLV2CmGqPVcQmbSVV75dmji/YZQZT0KkAe+WZZGTtIsXmKranBIKOT7ZiK2NQyfh2cWt6rDONeezNsurJ+1bfyYGjPm6ll2XBXL8/PJA6HCh9kdNmAiS5iSvX7ZAXGQptM584dlfMI+fpiJAfjgRhhC29opPvSzhradVNPxu9A2PvjyZ0v6q6MAOxnNyTjW9iT1P6m0HhMp9zZZmUdn7dw9c9VvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+xvzIQNx/cKb0wN/8jnP8SlVrf1Drn4WUpG2lAHTDw=;
 b=y4tI5qVhDZQlKJVXZfMuYLmjlf377xZ1il9Pt+D/qNv5fJjAOy6FvcasYc2rpsJ3dtPuQ1XYMLaHw3EYdKcJnANu27rSNXIojfj/2iTzKsAA+h9WOYDbDKrMSYEjjjpo9f2huPUQjm0f8nM6Koxg5blMHCMCmP5qrWrU9YoDwOU=
Received: from SN6PR16CA0059.namprd16.prod.outlook.com (2603:10b6:805:ca::36)
 by MN0PR12MB5860.namprd12.prod.outlook.com (2603:10b6:208:37b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Tue, 29 Oct
 2024 17:43:08 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:805:ca:cafe::d0) by SN6PR16CA0059.outlook.office365.com
 (2603:10b6:805:ca::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Tue, 29 Oct 2024 17:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:43:07 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:43:00 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 19/29] drm/amdgpu: set powergating state by vcn instance
Date: Tue, 29 Oct 2024 13:42:30 -0400
Message-ID: <20241029174240.682928-20-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN0PR12MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: c9580e8e-fbdc-493c-b5b8-08dcf8412636
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3lZWStJZCtSNDhXNlRJcXRHcDZtMUJaSUVpcjBqR0djUyt5UkVwZXlPa3BI?=
 =?utf-8?B?a3dMVWU5K2lLa09KNTlJYXNtUFY4a2tyM004Sld6QTlVWUw4QzFmb3B6MUJi?=
 =?utf-8?B?RmEralQ0RkMybHV4OW5YRGZyK1NBWWRERStNdjlSTlFjZlkrcDFBUm9MTmcx?=
 =?utf-8?B?VnNPb2I2UFluWFN1dW1tNFphak5tQ2k3a3FiTXJpNUFSenQ3UmQyQ1hWZk9M?=
 =?utf-8?B?TGE1TnRCazlIaEJUSUlRbDlwc1pJd1NrZEo0dGhldVhiNUw5Q2pzSUMxZ0Qw?=
 =?utf-8?B?VEhZaG9rZlRqQ2swTVdsYlNzbjY4RkovZ3B3OXJZbUxXbXlpYVVuVHE4MSsy?=
 =?utf-8?B?TDlJZXdTYXdMMTJFZFQyeVdWU1RYTGZXS0NyWmdwMEthanhnbEd4QXJzWGpw?=
 =?utf-8?B?VjZueUF0RDZLM0lrZ05tWEQvaUFHaTU1Ung5TVp0M2svVWc5cWk4TFEyUmk5?=
 =?utf-8?B?d3FZQmVBeDA0bndNaDJrby9sVlQ1U0c5NU5hdTdEbWtZMC9OTkZZaWJCMVFC?=
 =?utf-8?B?Q01VNElNMWlNcEorVjRPaHhUV0xreE1SN2EyMzdQNEdGY09waGhUUHh1N2sz?=
 =?utf-8?B?R3doaUd5QmMrQlRkOENxV2owYXBMejFuZFF3anBoUFVBZ0NxNEdmeldScDl4?=
 =?utf-8?B?Sk90N2E3SnFraXlnL010OGcweHdnaFFSTlNGV2ZxRUJSTk00Tko5MlJYOGN2?=
 =?utf-8?B?eXd5Y0IrRjhEL0ViOHJSaDZ5YzFrQ0JNbUxTOG51ZnhiQk1sbTJxclVDeFRp?=
 =?utf-8?B?cHhGSmVYTkMxM0ZNdnVWcDFrTGdKYnpxYW9KNjlpK1czaFdudkFQL21uN0k4?=
 =?utf-8?B?QjA4MU1XMnBaZ1NlNE9pOUhGdXBQZVFQNmtYUlkzY0ttcFVVZ2RVNGxwckd4?=
 =?utf-8?B?WCtZUFhUckdlbzVZa0l6bDJDa2NwUWJEZER6VVNpS0xONmtPY2x2Skg0U3R5?=
 =?utf-8?B?LzRpdnV6WldmbGlIUEw2aU5mWVYwaHFaMWdmYUVwVXZ6N2RGamZIbm1yeXQ0?=
 =?utf-8?B?NUUzbytidkVaY2ZVUTRKTm9Ob0ZuVGNFU0t5bWMveGo0eE5MN0h3M25yQ0dK?=
 =?utf-8?B?aitvbDJObnNxN2c0M3A3QThvMGE3WlFuVGRGWVRKWlhKWFJFU0ZDazNCTUgw?=
 =?utf-8?B?YnZ3TGRwSmxUQk1vcUZ2eG1NUmM5VkRwUDZRTk1rcVFYcldRRDdGQzRJMFph?=
 =?utf-8?B?cytlcXE3TjUrWWhCQVE4Sjc5cXdZUnRZbHZBVGU0eVlOQ0xqcDhyWVh6UnJn?=
 =?utf-8?B?ZjhZZllDOS9iTGtuaXY4eTNtZGJXWGZSUU5td2QyNklHL2dwVXJBM2xCak51?=
 =?utf-8?B?eEYxOFB6dmU5Rnlid2lBdi9yR25PUmdMdnBPNjRKcm9XSjJlVXl4YjVnMnEy?=
 =?utf-8?B?WE5EUVcxR3Mxb2NYUnoydnVJbVh5dndUSFJjNjZVMElKOU5rbDBiWG40VzNh?=
 =?utf-8?B?a2x3NHZDVnJVamtLQjlURmtOVHVKaytxeFdJNjRQWmp6YUFTVDAxNXlGWjNJ?=
 =?utf-8?B?TXZqNEpaOGtubVJ0alJZcHd5NGxvU0tXYWRhTXYzZTBJZTBtdzVZSEtzUDFh?=
 =?utf-8?B?SkFZcnFLMjZkOWFCRXRGT094c0JSVnJoVkkwMmRMMGNWTng1M25tcWxVa0hJ?=
 =?utf-8?B?QnVzeHVwL1Y0YjRLdWlpTW1KaXUxSmptckJ1UzJLOGNqbVFlNktXQWxZd1pF?=
 =?utf-8?B?RXhBRG1XM0hyT1cxckpjbEQvSzFEanZFTWJ3VGFSb1BHMHdUU2hjY0JPdjVk?=
 =?utf-8?B?WnhENHpRZmRYdVdXdHdWaWNETU41TU4rcVp3MnJqb0E5NHJrZVdXU2FDUTBI?=
 =?utf-8?B?MnV1bGNOYytBenRkaVduZWxjSDJ5Sm93RDV5eURPTFYwSW5pVmVINmMxNzYv?=
 =?utf-8?B?ZW4rNjM2MHVZY2JjMHB0aTFrRnNralBvaGxWYTNVL1U2R2c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:43:07.6512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9580e8e-fbdc-493c-b5b8-08dcf8412636
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5860
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Set powergating state by vcn instance in idle_work_handler() and
ring_begin_use() functions for vcn with multiple instances.

v2: Add instance parameter to amdgpu_device_ip_set_powergating_state(),
instead of creating new function.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                  |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c              |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c              | 10 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c              |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                |  4 ++--
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                  |  6 ++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c           |  8 ++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c |  6 ++++--
 .../amd/pm/powerplay/hwmgr/smu7_clockpowergating.c   | 12 ++++++++----
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c  | 12 ++++++++----
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c    |  6 ++++--
 22 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a7cb1d2d6e74..d4c8cc3c1730 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -357,7 +357,8 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
 					   enum amd_clockgating_state state);
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state);
+					   enum amd_powergating_state state,
+					   int inst);
 void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
 					    u64 *flags);
 int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 78b0a162cc7d..6027ecd28fe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2177,7 +2177,8 @@ int amdgpu_device_ip_set_clockgating_state(void *dev,
  */
 int amdgpu_device_ip_set_powergating_state(void *dev,
 					   enum amd_ip_block_type block_type,
-					   enum amd_powergating_state state)
+					   enum amd_powergating_state state,
+					   int inst)
 {
 	struct amdgpu_device *adev = dev;
 	int i, r = 0;
@@ -2187,6 +2188,9 @@ int amdgpu_device_ip_set_powergating_state(void *dev,
 			continue;
 		if (adev->ip_blocks[i].version->type != block_type)
 			continue;
+		if (block_type == AMD_IP_BLOCK_TYPE_VCN &&
+				adev->ip_blocks[i].instance != inst)
+			continue;
 		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..78fd1ff28a57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -119,7 +119,7 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 
 	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 	else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
 }
@@ -133,7 +133,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 31fd30dcd593..09844953a1fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1277,7 +1277,7 @@ static void amdgpu_uvd_idle_work_handler(struct work_struct *work)
 			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 			/* shutdown the UVD block */
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_PG_STATE_GATE);
+							       AMD_PG_STATE_GATE, 0);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_CG_STATE_GATE);
 		}
@@ -1303,7 +1303,7 @@ void amdgpu_uvd_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-							       AMD_PG_STATE_UNGATE);
+							       AMD_PG_STATE_UNGATE, 0);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 74fdbf71d95b..a061fb8a2fcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -344,7 +344,7 @@ static void amdgpu_vce_idle_work_handler(struct work_struct *work)
 		} else {
 			amdgpu_asic_set_vce_clocks(adev, 0, 0);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_PG_STATE_GATE);
+							       AMD_PG_STATE_GATE, 0);
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_CG_STATE_GATE);
 		}
@@ -378,7 +378,7 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring)
 			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 							       AMD_CG_STATE_UNGATE);
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-							       AMD_PG_STATE_UNGATE);
+							       AMD_PG_STATE_UNGATE, 0);
 
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 3d2d2a0d98c8..efd6c9eb3502 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -416,8 +416,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	fence += amdgpu_fence_count_emitted(&adev->vcn.inst[inst].ring_dec);
 
 	if (!fence && !atomic_read(&adev->vcn.total_submission_cnt)) {
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-		       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev,
+			AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_GATE, inst);
+
 		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
 											false);
 		if (r)
@@ -442,8 +443,9 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	}
 
 	mutex_lock(&adev->vcn.vcn_pg_lock);
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-	       AMD_PG_STATE_UNGATE);
+
+	amdgpu_device_ip_set_powergating_state(adev,
+		AMD_IP_BLOCK_TYPE_VCN, AMD_PG_STATE_UNGATE, ring->me);
 
 	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 0a884215f59b..cbc0347a8d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -330,7 +330,7 @@ static void vpe_idle_work_handler(struct work_struct *work)
 	fences += amdgpu_fence_count_emitted(&adev->vpe.ring);
 
 	if (fences == 0)
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
 	else
 		schedule_delayed_work(&adev->vpe.idle_work, VPE_IDLE_TIMEOUT);
 }
@@ -406,7 +406,7 @@ static int vpe_hw_init(struct amdgpu_ip_block *ip_block)
 
 	/* Power on VPE */
 	ret = amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE,
-						     AMD_PG_STATE_UNGATE);
+						     AMD_PG_STATE_UNGATE, 0);
 	if (ret)
 		return ret;
 
@@ -429,7 +429,7 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
 	vpe_ring_stop(vpe);
 
 	/* Power off VPE */
-	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE);
+	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_GATE, 0);
 
 	return 0;
 }
@@ -845,7 +845,7 @@ static void vpe_ring_begin_use(struct amdgpu_ring *ring)
 		uint32_t context_notify;
 
 		/* Power on VPE */
-		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VPE, AMD_PG_STATE_UNGATE, 0);
 
 		/* Indicates that a job from a new context has been submitted. */
 		context_notify = RREG32(vpe_get_reg_offset(vpe, 0, vpe->regs.context_indicator));
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 5830e799c0a3..0986f7a83401 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -735,7 +735,7 @@ static int uvd_v3_1_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index f93079e09215..565632478c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -249,7 +249,7 @@ static int uvd_v4_2_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 050a0f309390..ce7f205899f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -247,7 +247,7 @@ static int uvd_v5_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index d9d036ee51fb..ccf8dde8cd71 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -571,7 +571,7 @@ static int uvd_v6_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 53249d4ff8ec..c93eb5122bd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -639,7 +639,7 @@ static int uvd_v7_0_suspend(struct amdgpu_ip_block *ip_block)
 		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
 		/* shutdown the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index c633b7ff2943..4b4d295802a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -512,7 +512,7 @@ static int vce_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index f8bddcd19b68..fc7d80c2a841 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -523,7 +523,7 @@ static int vce_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 335bda64ff5b..e7b6f8cc8b74 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -589,7 +589,7 @@ static int vce_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 	} else {
 		amdgpu_asic_set_vce_clocks(adev, 0, 0);
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
 						       AMD_CG_STATE_GATE);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f07a5a8393c0..8b860db34584 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1861,7 +1861,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 			amdgpu_dpm_enable_vcn(adev, false, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-			       AMD_PG_STATE_GATE);
+			       AMD_PG_STATE_GATE, 0);
 	} else {
 		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -1891,7 +1891,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 			amdgpu_dpm_enable_vcn(adev, true, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
-			       AMD_PG_STATE_UNGATE);
+			       AMD_PG_STATE_UNGATE, 0);
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 14a4341d4f0f..0f7394a56821 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1012,7 +1012,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 		/* enter UMD Pstate */
 		amdgpu_device_ip_set_powergating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE,
+						       0);
 		amdgpu_device_ip_set_clockgating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
 						       AMD_CG_STATE_UNGATE);
@@ -1024,7 +1025,8 @@ int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
 						       AMD_CG_STATE_GATE);
 		amdgpu_device_ip_set_powergating_state(adev,
 						       AMD_IP_BLOCK_TYPE_GFX,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE,
+						       0);
 	}
 
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 67a8e22b1126..e54be4b386f2 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -1675,7 +1675,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 	if (gate) {
 		/* stop the UVD block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		kv_update_uvd_dpm(adev, gate);
 		if (pi->caps_uvd_pg)
 			/* power off the UVD block */
@@ -1688,7 +1688,7 @@ static void kv_dpm_powergate_uvd(void *handle, bool gate)
 		kv_update_uvd_dpm(adev, gate);
 
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	}
 }
 
@@ -1702,7 +1702,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 	if (gate) {
 		/* stop the VCE block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_GATE);
+						       AMD_PG_STATE_GATE, 0);
 		kv_enable_vce_dpm(adev, false);
 		if (pi->caps_vce_pg) /* power off the VCE block */
 			amdgpu_kv_notify_message_to_smu(adev, PPSMC_MSG_VCEPowerOFF);
@@ -1712,7 +1712,7 @@ static void kv_dpm_powergate_vce(void *handle, bool gate)
 		kv_enable_vce_dpm(adev, true);
 		/* re-init the VCE block */
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
-						       AMD_PG_STATE_UNGATE);
+						       AMD_PG_STATE_UNGATE, 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index a8c732e07006..41dbf043f59b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1407,7 +1407,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCN,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 					PPSMC_MSG_PowerDownVcn, 0, NULL);
 		smu10_data->vcn_power_gated = true;
@@ -1416,7 +1417,8 @@ static void smu10_powergate_vcn(struct pp_hwmgr *hwmgr, bool bgate)
 						PPSMC_MSG_PowerUpVcn, 0, NULL);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCN,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu10_data->vcn_power_gated = false;
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
index f2bda3bcbbde..b496b77153e9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
@@ -120,7 +120,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_UVD,
 				AMD_CG_STATE_GATE);
@@ -133,7 +134,8 @@ void smu7_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu7_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -148,7 +150,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 				AMD_IP_BLOCK_TYPE_VCE,
 				AMD_CG_STATE_GATE);
@@ -161,7 +164,8 @@ void smu7_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 				AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu7_update_vce_dpm(hwmgr, false);
 	}
 }
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 7e1197420873..2ccce2bc3b4a 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1985,7 +1985,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
 						AMD_CG_STATE_GATE);
@@ -1998,7 +1999,8 @@ static void smu8_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bool bgate)
 						AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_UVD,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		smu8_dpm_update_uvd_dpm(hwmgr, false);
 	}
 
@@ -2017,7 +2019,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	if (bgate) {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_GATE);
+					AMD_PG_STATE_GATE,
+					0);
 		amdgpu_device_ip_set_clockgating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
 					AMD_CG_STATE_GATE);
@@ -2032,7 +2035,8 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 					AMD_CG_STATE_UNGATE);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 					AMD_IP_BLOCK_TYPE_VCE,
-					AMD_PG_STATE_UNGATE);
+					AMD_PG_STATE_UNGATE,
+					0);
 		smu8_dpm_update_vce_dpm(hwmgr);
 		smu8_enable_disable_vce_dpm(hwmgr, true);
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index baf251fe5d82..64ef8c8398ff 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -3715,11 +3715,13 @@ static void vega20_power_gate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_GATE);
+						AMD_PG_STATE_GATE,
+						0);
 	} else {
 		amdgpu_device_ip_set_powergating_state(hwmgr->adev,
 						AMD_IP_BLOCK_TYPE_VCE,
-						AMD_PG_STATE_UNGATE);
+						AMD_PG_STATE_UNGATE,
+						0);
 		vega20_enable_disable_vce_dpm(hwmgr, !bgate);
 	}
 
-- 
2.34.1

