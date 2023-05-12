Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72AFC77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 08:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441F210E61C;
	Fri, 12 May 2023 08:16:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C94C10E61C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 08:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI5tpAMHZfANA/XWSwPJDxedDwJ2CblWUFDLaVUj0svDetUAl0EXK4iI0l+czzkJmgoj5PNNezgWDi67WNPSDZBS1y3YCMjkiCm55nYwHEdLNkQAvisV9ZNG25WiTzo+OeYerbXAWr1j/TEQPjTPUoW3BiOLN5jxcETPsjjMLddSFnfDVaS/Cmm5BrCKadkoAFPIuN7YNB72ZreoTY0EhCyMMgnnL082gcsD4ANjqSJTLqfDZm09KVeQ3JELgf2JRgyvgi1SZeYLwkRySN/dD8Vg2LMWCZ5Xxheuwo8bhq6vdUnJN83ZAcQZnHaJMvAp7fnznv6Jvwe8YNBFPDRffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm4kx4Vss6J/UAr74ljtZwkhHkHcA3PZoN2UFGWpAyg=;
 b=XzdjcsIPsnd5TuM5ZNJKPtoOmSjk3ow0B+NXmaCBfWEbJUnFkOmqRV0Vcp88/vsH68YroSZcPycr+8NXe5dgfCqx1k/XzK/+qW1OIk8CEZiZV+luyqE39gox5UMCh0Whpmz6FvkY3Lh8g/IGQB1vTkBsXe45vSWHktepgh0DeoS9NUy3M4ODgZe+HBo+Zu+/gzG0BAVWk5YSXN3HycbUHVaBG6y3ud1L7E+zLc191pnmpFFhGgbTAX+e1vkH5xedDmvbG86MnY1PnTFo2CuEA1Tta/t72bEC/J9F1xJAOcJf/mgWoITRrUPMmgHUPnlCKlp0QuMVxiR8HUSxk2yeWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm4kx4Vss6J/UAr74ljtZwkhHkHcA3PZoN2UFGWpAyg=;
 b=EqHlCFXZlTre5LDGNKbBsE6f0NS4eLf6nIG9QSsJ80l7C5EP+alvhjtu7Jjnb4xDa5NKNFjLUv2ft/ITO8G7PyTfa1IlWrT5WU13TNdHlAof5Mw23ie7uo2FAcCQGs0gIYfS/BYgcZwyRUwWlpKomb5nqazoPK1MLa4v4ODsPN0=
Received: from DM6PR12CA0030.namprd12.prod.outlook.com (2603:10b6:5:1c0::43)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Fri, 12 May
 2023 08:16:14 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::7f) by DM6PR12CA0030.outlook.office365.com
 (2603:10b6:5:1c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 08:16:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.20 via Frontend Transport; Fri, 12 May 2023 08:16:14 +0000
Received: from jackfedora30.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 May
 2023 03:16:12 -0500
From: Jack Xiao <Jack.Xiao@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
Date: Fri, 12 May 2023 16:15:47 +0800
Message-ID: <20230512081547.1006052-1-Jack.Xiao@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|DM6PR12MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b577f3b-539a-4461-b1e2-08db52c1273e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7snPf5g6FLqt3PAdMsokYxlE/HQ+2tulG5S9gCkRIi9dd325bdWcsmhyedTQl+tTOBvYWOzO+Jpj8QCR7nOX9v1bg7RLUOoV8XbZNub3NbkD1Kh+XtjUEkEt45WpZ4kyzuHbC1yEM6l+1P+Y0tFENQu1y34s7Wtj+wH2u2QUcAdyiv4OFjpTFwlZ4CCBiPNF67nMO2Fndkoa0AG2NWfK4JoJNvPalGqA1PrdPvxh5FuoadTA7NsQ8viFifHO5cgbq+GyqjzZvbRFhIV18SxJRcl6+3bk6J5saLUkRwImRkPW6mLk+m0kzEgMcykrNF2wTVwaGYwF79Jdyzp71sj6+EDQT1JSpYty5DeS2KtACHFsLqLT3BA2zsAPQsR3AFQErzba7K/i82mavSm3YIoWb48V7MD6LP9CN258JkxIUA3rlrubwiOzWhwVemSsqVYzSrDCh0ABMaEvnjTeMvliyCnZe06US5ogRSZMiCzrWECYii4gI2nj24OEJfhMyIqRTHW/VPFj10p4ygZiNsqmIY35rWFiHY5NLX1QTr5gAmrBlHLM+VDjFKmlUs6VkkUT8sVGgOKf355Vz1J8+WOXOObFcVUM2FoJNmdGAs+iu4+fUUY4uvJ4Rm0+RxRobphZkCOO3i3iLH5aTJQaWM24tqqRGC6/nrecEH7F2Wea6ZW3C7rjKezlbqQPp3w5TKTiNHL3b2YF7tnjtYzMy+yOUWWe+S/5ffxnzQJ0uRPIMVKxlWcd++46rnfKN2Vd1Are0InRjKpubR+OYFAtWmAmcx0iim6kWp4Tpqwu68lVWzk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(1076003)(186003)(26005)(16526019)(41300700001)(7696005)(6666004)(2616005)(83380400001)(36860700001)(47076005)(426003)(336012)(478600001)(40460700003)(110136005)(6636002)(82740400003)(4326008)(40480700001)(70586007)(70206006)(81166007)(316002)(356005)(5660300002)(2906002)(86362001)(82310400005)(36756003)(8936002)(8676002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 08:16:14.2861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b577f3b-539a-4461-b1e2-08db52c1273e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
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
Cc: Jack Xiao <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make the preemption optimization effect only for SRIOV,
for it caused failure to resume from S3.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 7 +++++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index a22d88a4178a..1b795b7bbf38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -385,7 +385,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
 
 	/* Only enable on gfx10 and 11 for now to avoid changing behavior on older chips */
-	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0))
+	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0) &&
+	    amdgpu_sriov_vf(adev))
 		domain |= AMDGPU_GEM_DOMAIN_VRAM;
 
 	/* create MQD for KIQ */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 4560476c7c31..5c3d3f6c7ebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -889,6 +889,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 {
 	int r, mqd_size = sizeof(struct v10_compute_mqd);
 	struct amdgpu_ring *ring;
+	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
 
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
 		ring = &adev->gfx.kiq[0].ring;
@@ -900,9 +901,11 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 	if (ring->mqd_obj)
 		return 0;
 
+	if (amdgpu_sriov_vf(adev))
+		domain |= AMDGPU_GEM_DOMAIN_VRAM;
+
 	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_VRAM |
-				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
+				    domain, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
 		dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 3adb450eec07..79a4d2bfd94a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -987,6 +987,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 {
 	int r, mqd_size = sizeof(struct v11_compute_mqd);
 	struct amdgpu_ring *ring;
+	u32 domain = AMDGPU_GEM_DOMAIN_GTT;
 
 	if (pipe == AMDGPU_MES_KIQ_PIPE)
 		ring = &adev->gfx.kiq[0].ring;
@@ -998,9 +999,11 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
 	if (ring->mqd_obj)
 		return 0;
 
+	if (amdgpu_sriov_vf(adev))
+		domain |= AMDGPU_GEM_DOMAIN_VRAM;
+
 	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
-				    AMDGPU_GEM_DOMAIN_VRAM |
-				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
+				    domain, &ring->mqd_obj,
 				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
 	if (r) {
 		dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
-- 
2.37.3

