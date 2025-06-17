Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693DAC71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D949910E3BC;
	Tue, 17 Jun 2025 03:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TpLkPCrs";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E5210E47B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUeVo+RUOJIPkH6RgSroSVB9dbuUrPfDKid4Ah2vbJHSH2Z6VzHrmpiY3zw12W+obaI8WZzL9Stg2XdWTYh02T4nus6qfreIE3YMhuSsfLa5boqGoweAom2FsvJn+A7mSlbkWKA5TEwqANEkTt3yFuu2W2RENgtu/GGg4gOp4kKdB7D/0f0lpywEidkIdyObcITUJmKqBzFOk2X6mWQqUrmLJQvvbJ9zqf52OANQ8VL76svFAP1eBYAE9l7UM+MOxxGI75qrJ8nB2AkZYfVVknNGFVZwSyjfYcgMMdK+Pvdq4Eg18YCa9PkmvGcRqA2ZBj3NioConsgIcS0tFEhMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM8GBSuq0u1hyCqaxAxj8g3XWKVLulXfKia3SVmh5FA=;
 b=CydEaxBmXt1FIJXhPHkgrLM+aaQF69/BYvDQftn4zHfs72/65JzhaYnku46okTy+N93WW8fe4gRVYEIPvE9PqAfJkcI0HiqH8Ph24uw+ggytALEmJUAuG3N1fgUEUJFH38P4qdelVMJFTGABIh+ANEqQdjcs3gVlR6oKTeoC2QsT9wAjQTWeZ26PsVyLTfgWlpOfrDPky3c23c1l4eBWyJKJsLDhB5A9NAfajFB2naCPhEUe8ng7hkEqiF/+uJ/1oj9QjXJMSP8hFBITTDS+PJ9+qiFTRR4WmMXZEtV2pTjgjogY7WbEb5Luk22krrNtoYv1IP5891ZsHpG4foU4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM8GBSuq0u1hyCqaxAxj8g3XWKVLulXfKia3SVmh5FA=;
 b=TpLkPCrsyCYhycwUGy9ZVn5RRrh+uwN0bQOo+ltJVKd45/zPlaqQt6JNbIGCArngrrmlf2jFynPzOW0zM4ypD/xzGaih9EMLjvb5KWq2CyvFBSEFnIbCSGu7o+jS42F2IvTnKN57kebvDC3HJv919BiesA342sglRgJEruO9+vU=
Received: from MW4PR03CA0008.namprd03.prod.outlook.com (2603:10b6:303:8f::13)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 03:08:36 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::a1) by MW4PR03CA0008.outlook.office365.com
 (2603:10b6:303:8f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 17 Jun 2025 03:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/36] drm/amdgpu/sdma5.x: suspend KFD queues in ring reset
Date: Mon, 16 Jun 2025 23:07:44 -0400
Message-ID: <20250617030815.5785-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: 150889fe-a43c-4f45-7d68-08ddad4c3fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JJCyUcHOqWleM1IfUpouyaO6SCn4a3Gmgik0NVAtJhXiKzck0VpEHRpRZyq3?=
 =?us-ascii?Q?NMrh/q5hDbL/81oTTUXHFeWQv9OQ+eIvsbPd+nxS+/H2IkUyYYwMvrPDTqBR?=
 =?us-ascii?Q?5P8iU49gT5Jtw/UZy/+m5eQsO8Y+AKSz5Qm4DuQXwU+BbgZKpunjfV9qa61q?=
 =?us-ascii?Q?FU8sP6wS52GKdejIN7hf5lB2gsmDpegO4aXnZ/KUj7yOrc55fSJ+NsuPcVgY?=
 =?us-ascii?Q?vBV68cmcqPNb8eEFyvK/CwhYIaPNnyiWmKyaeIjMAglxlnQdSd1BXDBMemc1?=
 =?us-ascii?Q?3LjmmR2fKoObvIKa0FT87shSHHwVvJAKxu4NunsXL8DvZX1bYN18GDSvUz5r?=
 =?us-ascii?Q?Ki7ahpPyDNsVwxClGKuwBOOlxZgTomAONsdHM1rrSyoitITjiBeYgXUlBDXe?=
 =?us-ascii?Q?m32eEoBxs9vqaMMxR7UulNrW689JtDTs+tHzfx8egR8gb2aX/5eO0ezkAGTs?=
 =?us-ascii?Q?GE49d61VGITalz4WXPvQz5Pd1JeV7ZR7mAgoHlStsnsxTM/T1KCMPg6I2DOI?=
 =?us-ascii?Q?pZMPQ1OSo52ZwuIGZ4tIJ+KQbDlBn8oCgotYeWPNPu62KuSzMArDXaORbJWY?=
 =?us-ascii?Q?Fk3ff97Oc4wmPJSlphQ+eCokLlvWuJJ3f4wy8wNatF9euYky+mF7frT1ceYm?=
 =?us-ascii?Q?MH1FXNvpVXWK2zFDT4kRwOHp0+tM6jBwB/rlmxQOijqmEnQV/LTdwmYqWQSQ?=
 =?us-ascii?Q?L/nZsppWmFe/IcC9vxWAf7ZEdf3adXOXsGvfikbFTbRhWt+uBXobZRtZTTbw?=
 =?us-ascii?Q?z8eaJ/ApU+8fva/9AYSsmsV2ZG3FaCup9/4i6QQvfMP71gEtkUwVDqX6NZ81?=
 =?us-ascii?Q?77Q0tKrwWv7JZIRdyRQKJor0u00hHCzurVtP+jiKCkA0AxbOQUzUvPu22DR2?=
 =?us-ascii?Q?gqmVV4YLpyKIQZ16BIt4tMIRDy83+6YsgUnr5mk6/apWX1sTyvSUgjaqaxnW?=
 =?us-ascii?Q?DOWNJ4zzQb/sTp1FmNLW34ZmHTtlEe8IK32tbD1kAqC5fn0V8IyJwEo7wI8U?=
 =?us-ascii?Q?qWEn3OIMLAN4sfAJfNpvXMpVQ1INuCxtSCFwj2bEtKd9/ogVlR4o9NtXOWSV?=
 =?us-ascii?Q?o/Hd1elcKr7RGBXDC/Hyx9wdgT1VqUwFERkjh4qzyVCawv7iRcaES+h3NUQv?=
 =?us-ascii?Q?vWIpDqMs9ZdD3Qk4gBWTfMqJwy28/XW8AYG2w4ZQn84DYYADMtmH1N5KHoAD?=
 =?us-ascii?Q?vrTYAC9NcljjAA/NEr7lMSaqYFOkhs23s0+5zRgxtdkCDdTGTwh6QufaS0Jv?=
 =?us-ascii?Q?AN6s+SJS8QTFS9tyuj5gH6elQVzuV8KKzPqlmB9uOnA4ig5+MI6w4Nx0Oc1A?=
 =?us-ascii?Q?vLgyhit74qBFqqfc0PwXD+P+EMdT1Igs9RCgLYO9ejQfyfNl2mjUfnBWbaTh?=
 =?us-ascii?Q?BExUoUvJEIRQYyL3gGnqxArqaMxZOkyTNHTe5Eb8RqIz4kzHinobrm0wCTTi?=
 =?us-ascii?Q?kHAhNjjus45a8A2Xc0EyKu2BcsVA5MKf7Rb5/Dpd+93V8cS1kFU9zogmqsEf?=
 =?us-ascii?Q?oGcgL8eFJzgVPo0eN+WDd9/T4nWlH8SYmKcs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:35.5135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150889fe-a43c-4f45-7d68-08ddad4c3fd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884
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

SDMA 5.x only supports engine soft reset which resets
all queues on the engine.  As such, we need to suspend
KFD queues around resets like we do for SDMA 4.x.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 9505ae96fbecc..2d94aadc31149 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1542,8 +1542,13 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	int r;
+
+	amdgpu_amdkfd_suspend(adev, true);
+	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_amdkfd_resume(adev, true);
 
-	return amdgpu_sdma_reset_engine(adev, inst_id);
+	return r;
 }
 
 static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index a6e612b4a8928..cc934724f387c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1455,8 +1455,13 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 inst_id = ring->me;
+	int r;
+
+	amdgpu_amdkfd_suspend(adev, true);
+	r = amdgpu_sdma_reset_engine(adev, inst_id);
+	amdgpu_amdkfd_resume(adev, true);
 
-	return amdgpu_sdma_reset_engine(adev, inst_id);
+	return r;
 }
 
 static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
-- 
2.49.0

