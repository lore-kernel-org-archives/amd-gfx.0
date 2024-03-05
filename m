Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B976C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 17:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A296A10E538;
	Tue,  5 Mar 2024 17:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zXtZ+Bat";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6111010E52E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 17:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+kRzeB1w1e19SKSIudCBBt82Fm6nUS++fcniGv19XYaTGkMtUD325bujKJ527cKpTf+VEm5vk7upJ9Li1AMBYlpwbnvrxwaZy9bq2NG0Xr+5Gv27WADZpfZElXDELWzfbALKZhYccs9A9XwxSJn+Hv3xDuklM13LFQ0OBgGsUjCAxMOKGrto4Q36XsyZYRpkIK0uBjKuyyq52bZjJmSdxo2GIHjhffnG2m7LOoyVvS4X2rWq+SPVu6c37bL2RSj4XsDWvJ5QNc0gfmTclm881LzSwE14hpHyOcI5LdIQbJ+bDeojzTAW/P1We2w94kcpo2upeG50xv4svXih7RmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkYYtLyMjSSUVYOZnPQR2HcM3ftA6agiaBAOGpKFbnc=;
 b=L/yPokA3jHqBoJNXloQgUSTKOfaYetMvJQsmX9f4T7yUF3aTgU/Elza8UkxycKzbjJh4IQ49/3G41W23EIZodsiivCR8u3yGPK0cL0LqRzSVXwNfFvIFCbKHPQdYVTL6fCQ1RHy2PldqgMOBicIHfq0rtC5nFyK624dN1tJVVW6EnMtZGHDw/9E/vJ3Cv/XhqxfOgiD8HaO9BNsSbtezIyX7PzMCV9rlcUl3oRpXn1+0/Lnknqhu4FUSZNhbwuccWZBp+/v0l7snYeSX0IHJEaSUsdqfLfxDfIEcIWr+Is5mZKa2/LIdWvD9eXQ1ulIUMxrZ0EJ56cyfd+3sLkpUBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkYYtLyMjSSUVYOZnPQR2HcM3ftA6agiaBAOGpKFbnc=;
 b=zXtZ+BatfsXwS4t4GbpemvtpLRXJbAVYUJpvNODNBSU/HnJyVmJNamHX1fOvfYx0of9de6O+ag/trJgbdc1yLmXpGReL3mkHiugRLXqD4+uO+prwnS4JRpHG6lqh/N9rXlc1/0ZlZKm2ff3fwltLCDwYktqPvJWfoXV3pN0PBz0=
Received: from DS7PR05CA0030.namprd05.prod.outlook.com (2603:10b6:5:3b9::35)
 by LV8PR12MB9206.namprd12.prod.outlook.com (2603:10b6:408:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 17:20:56 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::19) by DS7PR05CA0030.outlook.office365.com
 (2603:10b6:5:3b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 17:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 17:20:55 +0000
Received: from banff-1e707-e02-2.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 11:20:54 -0600
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Ahmad Rehman <Ahmad.Rehman@amd.com>
Subject: [PATCH v2] drm/amdgpu: Init zone device and drm client after mode-1
 reset on reload
Date: Tue, 5 Mar 2024 11:20:39 -0600
Message-ID: <20240305172039.479735-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|LV8PR12MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 248e76d9-5e88-4a1d-90d7-08dc3d389dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72JLlt7XlSLVfVnAtxtwnYrI5fXBnDqBO7B41cYJysQwuwnVJJ9od3a6veqF6wPiUairydycYFazp/FG0DCJGIiOpE0UQztrqRwcYp5yALF9zIKIboAA4c90I6gj66B2yfF9P6oxI19zQUmT9HXRkceUsBR3WY3/sU0HtmMoJTHBXXPsIEDKnr+A9jG+CSVNynIYkKDBjUX9H0prcTcDSp4OLH3+ng4vFu20FwOl765rYScQk9e1Av0vPPk8BVl9WvniBfOkf0jPYJ3DEua8q++4njitR/IGxkwGdFO6r51/Jxb5N3SMOA33A8t3R9688/UmOL79iJxiCVFAYPe35vxfXr4Ccgqe9Yp+U9quFY+vlUCwtMle+SKNjDPMc4XF/AcncMt7eZng0XX7e5ZlsNxeVNWd2VawHDZYA4j1v7puxjykckzaPHRsQdSJnp7eVILoxhtJHJqDIk0prdOolVBRzUtw8uMSDJJenG0uCNGGiUAs2Y27n/lDhvI3nbZmai+bnbG0vSm8rq86H+rPclVR9vqfIHIJB8k+5xX5gcT9qdqYwhmFHXGrSTYS2KcpMOR+puMlYo8uW5cGMEYVeDQrTNVt9xk1JeLa4UW7AfNGC2lIQO+UR+17Xb2xU+WfGWa4WIGgovKIwXqeAZWBIV5vn+D9H7mQfxt//1LzYJNIitiUjW2qVK/6x8bMwb9qsMVc2CyzpbjEPRDqnPrVbPyyFgvJXgrtVEGPtkBxBavsIcHR/IHa7bDZ3TKCt6aU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:20:55.5462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248e76d9-5e88-4a1d-90d7-08dc3d389dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9206
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

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 +++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f5f2945711be..c229dbdf5d47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -146,9 +146,6 @@ int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
 {
 	int ret;
 
-	if (!adev->kfd.init_complete)
-		return 0;
-
 	ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
 			      &kfd_client_funcs);
 	if (ret) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 15b188aaf681..e783f5c8f5ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2479,8 +2479,10 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 	}
 	for (i = 0; i < mgpu_info.num_dgpu; i++) {
 		adev = mgpu_info.gpu_ins[i].adev;
-		if (!adev->kfd.init_complete)
+		if (!adev->kfd.init_complete) {
+			kgd2kfd_init_zone_device(adev);
 			amdgpu_amdkfd_device_init(adev);
+		}
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
 }
-- 
2.34.1

