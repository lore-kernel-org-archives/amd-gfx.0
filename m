Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF92C47E49
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 23:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DFBF10F097;
	Wed, 24 Jan 2024 23:22:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DB7A10F097
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 23:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiYLHRleQsVeSGngk+VgsOwe2DhQm2Tupz129Ss0tYlV61qRUe4TuT+XiahifefVRiXS5mAJ9EPeVZk1Ld4pq8hcs5vDqXn514ucF9icomRVvOtGeAv1B+vKWKgCXZey0bU/EIWyLbbBoeidLU1JO4a8SECpBaDiZXLfE9YFt7cS7aOKi2waUlYZwmyUsv18GjEzV4jGe/WFcJvHGk6K7l5GQuJ/FeFY80HotVdnjaED0ONfAf/u+UhLonESayi+ZVnFEZWIpGkvghyvGpij0+2zYDS67O59jL9Fd8v4+6l7Lyv+AFC12fo372P6cTGWZUwfcAyi8p2i+U9/ryxR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvtXFI8CwzHL/0KgfNT5Kui6AWeJMq0yDNlc0zrJUaU=;
 b=mMDSn2OcAK8XSzpV62e/Pv7J0NAB+FAL4uET4YDkQsJni09xz36lA2ZAx8zoSaPhGWlUnOUSuZ6n01vorYwz4t5aVVgJ4kISWnjFxuBDyWl9FBl2NRrg+g+p9NKbxLJFoXQsrr3YQCzKy4ZGfW6zrNkseqWZJkoWoUw2zNySdJ5HsLxUK+hPYYNdfZIHuPWXyh7PrgGgKGboCoxJCQ/4hKm0s5I1kG6B2OAwI9hBcpw40pwkMWnMjSy5BDLI5aTOmMPV/UqUDYqkP85miiaWuiT15+iPzTZ6dPZ3MMqruplwaYAQm8ghMyYOWG6AmQyVaaCXZja4rLLcbM4w2AlLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HvtXFI8CwzHL/0KgfNT5Kui6AWeJMq0yDNlc0zrJUaU=;
 b=CiYR8Fu9cszCcHAw5zl3uFdVvtiveyYI1OErk3VJz7cArzLHAJJ3qsSzJWW8F3+aTAaU+ojBafMljkVaaFPWh7NxL12RGKJV1dnhfqeR5aLccxE/g0+HMoj0yLrA5otOf9/tl1ee/cZfh0hE1G/c4qv3OKlWLpDFlvdpyfo1wv4=
Received: from CH0PR03CA0343.namprd03.prod.outlook.com (2603:10b6:610:11a::14)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.29; Wed, 24 Jan
 2024 23:22:14 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::5) by CH0PR03CA0343.outlook.office365.com
 (2603:10b6:610:11a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37 via Frontend
 Transport; Wed, 24 Jan 2024 23:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 23:22:13 +0000
Received: from MKM-L1-ZHLUO987.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 24 Jan
 2024 17:22:12 -0600
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] amdgpu/drm: Use vram manager for virtualization page
 retirement
Date: Wed, 24 Jan 2024 18:21:43 -0500
Message-ID: <20240124232143.7201-3-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240124232143.7201-1-Zhigang.Luo@amd.com>
References: <20240124232143.7201-1-Zhigang.Luo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e8c870-4a12-41e6-ed45-08dc1d334c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: de3gyZDN2JBrvbsYJJIcp/2b+cFOIWczdZFGL+fTMD9pWFiN5Ne7Ye5XjQsjNDeW5+km7jHZ2LMbB9pVSfxsFnErQaXxGYa5WNnJHmm3wi1nlQgiQcdef+t0OkIbdUCQ/GOQThtWlF3eWLGyXfhqpBTdGjNxQZDazv9I3LvFHyAtHGVF+tihF/rzgXoc2AKEqgxDuP8HzW6tdIlrHcA+YD45VVJCYSsIm2vv5ODxtMqBc/xdUeIPYXgehqP0sCfOW8x59TQPsURIdDqItM5bqXGlUsarJMpC8jUJQLWyu9zaLg1OVt/xLwJbykhFDVx5EKPfsu367g4nKgnZZig3OYEwCYUKrItdQI6j0tpUXa4S/tu2PS/pRcjybTAl+r23HHifVU697J+/gYCGPIIkVS4c4kZN4q5sYYMBykqP4EYuqdVJd61+4TG+TFvRkFhlxMZFFS8GpfMlAme/G3da0MTNXsBc1AFSk79WXQ6ocSS/2pfyJ/eU078lWb9QvJ3a3rdwk1iqfgjKVZS3Fd9MFnVQJxECgDMFhDdo9PIPhsqJZN8jkstb3LfabKO3vmvrTJY0KP++zcijCNROjlK3flPZymK3pRDo70n0S6Ki5fs3ah2jHBi1oliJemjJTzE6fBWlnb1BDQ61eIOtXfpEs686mDXR4XTSR76VtdhN93YtbQvq0eZutJQOfbCV0s/Jti2jRsRmzwXlKn+bieG4IFua3VqHICJ1mF8mO2Qw5HjxyTmX5OPBFYh1pBUhhi/uzYhtHr22XiiyUjURN54Yvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(82310400011)(186009)(64100799003)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(16526019)(47076005)(336012)(1076003)(36756003)(83380400001)(41300700001)(86362001)(356005)(70206006)(26005)(36860700001)(426003)(2616005)(70586007)(6666004)(2906002)(54906003)(81166007)(7696005)(316002)(478600001)(6916009)(8936002)(82740400003)(4326008)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 23:22:13.8257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e8c870-4a12-41e6-ed45-08dc1d334c37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
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
Cc: YiPeng.Chai@amd.com, Sashank.Saye@amd.com,
 Victor Skvortsov <victor.skvortsov@amd.com>, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Skvortsov <victor.skvortsov@amd.com>

In runtime, use vram manager for virtualization page retirement.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Change-Id: Ia8fe6c7d4e4acae9d3a953b3ba4567e8fc6de0fa
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 30 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index f5c66e0038b5..6ff7d3fb2008 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -250,11 +250,11 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
 	if (!*data)
 		goto data_failure;
 
-	bps = kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERNEL);
+	bps = kmalloc_array(align_space, sizeof(*(*data)->bps), GFP_KERNEL);
 	if (!bps)
 		goto bps_failure;
 
-	bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
+	bps_bo = kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP_KERNEL);
 	if (!bps_bo)
 		goto bps_bo_failure;
 
@@ -287,8 +287,10 @@ static void amdgpu_virt_ras_release_bp(struct amdgpu_device *adev)
 
 	for (i = data->last_reserved - 1; i >= 0; i--) {
 		bo = data->bps_bo[i];
-		amdgpu_bo_free_kernel(&bo, NULL, NULL);
-		data->bps_bo[i] = bo;
+		if (bo) {
+			amdgpu_bo_free_kernel(&bo, NULL, NULL);
+			data->bps_bo[i] = bo;
+		}
 		data->last_reserved = i;
 	}
 }
@@ -328,6 +330,8 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 {
 	struct amdgpu_virt *virt = &adev->virt;
 	struct amdgpu_virt_ras_err_handler_data *data = virt->virt_eh_data;
+	struct amdgpu_vram_mgr *mgr = &adev->mman.vram_mgr;
+	struct ttm_resource_manager *man = &mgr->manager;
 	struct amdgpu_bo *bo = NULL;
 	uint64_t bp;
 	int i;
@@ -343,12 +347,18 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 		 * 2) a ras bad page has been reserved (duplicate error injection
 		 *    for one page);
 		 */
-		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
-					       AMDGPU_GPU_PAGE_SIZE,
-					       &bo, NULL))
-			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
-
-		data->bps_bo[i] = bo;
+		if  (ttm_resource_manager_used(man)) {
+			amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
+				bp << AMDGPU_GPU_PAGE_SHIFT,
+				AMDGPU_GPU_PAGE_SIZE);
+			data->bps_bo[i] = NULL;
+		} else {
+			if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
+							AMDGPU_GPU_PAGE_SIZE,
+							&bo, NULL))
+				DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
+			data->bps_bo[i] = bo;
+		}
 		data->last_reserved = i + 1;
 		bo = NULL;
 	}
-- 
2.25.1

