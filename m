Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB348C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 04:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10AA710E09A;
	Thu,  2 Mar 2023 04:57:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1575D10E09A
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 04:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtCetjTGBl3bxibWNGtiuBR16rJqRZe95qyev/WgGwkalIGYSEGGvnTKLH6wlat79lcch2nRj7Y2sYB8lkbB6s4oz0tDyFaqdmj4TH/ARUqfcxKq9JM9L+mN0PnNQsVhvFOtFbVZll6Vrg1PTrB1to9KzhO+lwCPRZtQxJGmWOROKIIKBP+1/DsUiKg1+eIoaiQWC/IIoaImAOMo5SOi4QXtxz26hf2gYUwYWO2WTJmh1btM4XKyKA5j6VyuASyxNtPpiZjZUb5gBrr+KhNcH0cl3vyoUJEQsCjlZlW//BF/0Jue5tnCxwYcDim8r35INaRKv7oqLtMLu48mI9qhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1W4+IbYvUa8mIoiZf22lZ0rg6s3LG+PxRrs4ZYSDaI=;
 b=km+LkvqF80acwcw7I7JpQ085n6lDg/0/O2j78jqudqzqpg5BY1Xl3k4DsdC0JFY+R7Gxq4dIzTjQe/FyFauvo0JuPjJfZkrUG4suYtaxhOW82NEnJB6gnoNoinJk1o3EMNhj66F9uANdvf9CgNFQeh1tBzTqp2IZkani8keEEZFZQDp8jitvk6DIsuEEadQM1cozufsLtSdkiCkzJH5JQCNWMum0FkifLkSg3EvnZ5Sr/+GAJ+QAgcvsW+uYAWqAzvLgwE/2Ev/RjUCx/SpoRXGWW5M8dUu38Ne5VHrUG5Yp1OHCwRuRHmXkordAUhIXejrVwbF3jxYzawhpt9+URg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1W4+IbYvUa8mIoiZf22lZ0rg6s3LG+PxRrs4ZYSDaI=;
 b=yRoPGQl0WK1TmwS3FJT5ey8ZDX0A2q84cOlyOmldvEk6E8My+uGrO8bW3NWoIakNLSk2CSN7IX+Nlb6SDKn1+knBuaMlTiaNo0d937ll64XADCgpEPUi6G3L3kJLrSa2+22f9P0ekpl+KS2O4l+xeoaKQoTQ0uAtDWq+4zdo00g=
Received: from CY5PR15CA0035.namprd15.prod.outlook.com (2603:10b6:930:1b::22)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 04:57:16 +0000
Received: from CY4PEPF0000C964.namprd02.prod.outlook.com
 (2603:10b6:930:1b:cafe::99) by CY5PR15CA0035.outlook.office365.com
 (2603:10b6:930:1b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 04:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C964.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Thu, 2 Mar 2023 04:57:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 22:57:15 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 20:57:15 -0800
Received: from lyndon-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 1 Mar 2023 22:57:13 -0600
From: lyndonli <Lyndon.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix call trace warning and hang when removing
 amdgpu device
Date: Thu, 2 Mar 2023 12:57:07 +0800
Message-ID: <20230302045707.2299-1-Lyndon.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C964:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d066e1-f710-4068-7270-08db1ada983c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJ18U3o1uCaP4sH7pTeN5IL3otI7sZzMfkBq1OzFx+/fL8aFnt/vpnZo2Dr+drnueCOusgO2Tpcc33T/2wN/Q8RwrKY0uFvpvI5otNsTKAWqozlAoIiu//GyOgcK+QTT41lRVe9wfQ6u2XtVvBFhD57CJvnEg/ipMaAOvGWZg7vihFuRKWyPQttDcd4Y76a5KThzCICSJ9+z+wo0a28uZ1te7+959pW2dXkVn87xZbSiY78uKTlKenNp+vgGVOiJfC0BCqR6Y8T9X+hb7mPz2rAsF4SL6rSxzKSPH6YmAZtsh2YpPEvDtpkfki3tLN04qkjthWe+ebHIjROwyj9j/ze59OXu2mBNLMDDdNPw69KkB6xV5Ilem/WV7AR/eSIpdUSzs57AuRFJPOOU/U519gU+820uvw8mFazatDVdArzJYbZOL1Mc58NJlOsowf7g0bvubv9UdJ4hHE80w4kb99bXtORSpKlYqcBkNJJBBwx3jAafYJKh/EFJVMkhYuYTgasHBUN2gEvDtQGHLyYWm2mLppR71+W8hDfTfvmvtUUnJtnmsTaP/n07XRgqeF40ErcYbg6w/c/9ymzRjDphpnH2rfBOw9k+GTzmzQB4+2URzlwdG92QO/3PVK9A4wAqUhrVos6EL38cd8Xv6D6Cj9CKmfj4jr/yaJZoiIT0d8V4Y3fJGCluiHMqqnWGnb/k0SRHXezIYjfSjHsZl5p9LrVyWdsZKMMa7LpVFVoEIEvfoELkcl6lPUUSaJfSLIb6vTUfNEev774qSYjldSTV9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(36860700001)(356005)(81166007)(82740400003)(2906002)(36756003)(86362001)(41300700001)(6916009)(8676002)(4326008)(8936002)(40480700001)(82310400005)(70206006)(70586007)(40460700003)(336012)(2616005)(1076003)(83380400001)(26005)(426003)(316002)(478600001)(186003)(54906003)(7696005)(47076005)(6666004)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 04:57:16.1410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d066e1-f710-4068-7270-08db1ada983c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C964.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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
Cc: feifei.xu@amd.com, YiPeng.Chai@amd.com, christian.koenig@amd.com,
 guchun.chen@amd.com, lyndonli <Lyndon.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On GPUs with RAS enabled, below call trace and hang are observed when
shutting down device.

v2: use DRM device unplugged flag instead of shutdown flag as the check to
prevent memory wipe in shutdown stage.

[ +0.000000] RIP: 0010:amdgpu_vram_mgr_fini+0x18d/0x1c0 [amdgpu]
[ +0.000001] PKRU: 55555554
[ +0.000001] Call Trace:
[ +0.000001] <TASK>
[ +0.000002] amdgpu_ttm_fini+0x140/0x1c0 [amdgpu]
[ +0.000183] amdgpu_bo_fini+0x27/0xa0 [amdgpu]
[ +0.000184] gmc_v11_0_sw_fini+0x2b/0x40 [amdgpu]
[ +0.000163] amdgpu_device_fini_sw+0xb6/0x510 [amdgpu]
[ +0.000152] amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
[ +0.000090] drm_dev_release+0x28/0x50 [drm]
[ +0.000016] devm_drm_dev_init_release+0x38/0x60 [drm]
[ +0.000011] devm_action_release+0x15/0x20
[ +0.000003] release_nodes+0x40/0xc0
[ +0.000001] devres_release_all+0x9e/0xe0
[ +0.000001] device_unbind_cleanup+0x12/0x80
[ +0.000003] device_release_driver_internal+0xff/0x160
[ +0.000001] driver_detach+0x4a/0x90
[ +0.000001] bus_remove_driver+0x6c/0xf0
[ +0.000001] driver_unregister+0x31/0x50
[ +0.000001] pci_unregister_driver+0x40/0x90
[ +0.000003] amdgpu_exit+0x15/0x120 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d50f8bfb9be9..5554ff22d724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1314,7 +1314,7 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
 
 	if (!bo->resource || bo->resource->mem_type != TTM_PL_VRAM ||
 	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
-	    adev->in_suspend || adev->ddev.unplugged)
+	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
 		return;
 
 	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
-- 
2.34.1

