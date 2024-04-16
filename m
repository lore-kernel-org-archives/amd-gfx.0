Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D886C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 18:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173A0112DBE;
	Tue, 16 Apr 2024 18:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AHCf1LxY";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F44810F28B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 18:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjkDQ4pRJqfluXiWB/BcDzjhS4WYEOKbGjr/IyaUrnb9bW//nh15dtvh6rdz1GR5a0LAVioGEVJDeysIY6QLNjjqWPicksOsROeaO8gXn3Y/kqce7/lVadM4QoLDyJBKNsRFboPJUr7N8ztICx092mYljhyXCY2F95KQmN14yaA4ol2jTF4Fvb/jZaUA/vZ0l5vJFa1gUxum6U9/hK21hhU8ccyxjw+B1sbDnvDPX63777njAVk7M2q6trYBjFG4fV2ezdcPDiGPnHLkGVRSmHDDJAw29n1R1+hRaAhb2IJJyhdh+wL/T4KO7Qwu71e7DmSjCrWXxg3UYHqWsvxvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6Z8Op/u5T0M95PA5obVYdBx644kS1wjqYofiJMBL6M=;
 b=PdX7bvFXsIFxzJi61aCO0cP8LCA9Eroke/3HecdQWznaInoAtvbUcV4op2O9K4CAjJdNnuvPXxanCAuI4ubwI7jCMtPEQHqelPmm8lBKLs02+VW2aTMkvWOfapnTIbNnDL17snsOUNt/d1LO/YhnTAJGTOocxTLAE1WJJurE/GGEjhuQQx0TK+u65h9vdvZirNSDVyH5jJkxtXFOaJUYjjWRP0r7TQf0nAFCwQRAwJgPYHwOy+4Ckg+aYHVHqWbJY/5dKZ+3kOkGJ4EVpC+iT6FNWBZhYKifmDzUrdJhY5JstLu/XZ7OpXZFXSntiFNVFSMf/ZI0r0ZX0t+rbqiwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6Z8Op/u5T0M95PA5obVYdBx644kS1wjqYofiJMBL6M=;
 b=AHCf1LxY6bm4lhLX52TI1I8lupzmQUqTvlFPfZTnegLMqfKVGc01hmsRhcHO1RZCc+Bf+7eeUf4z9QScRfSwA69dCOa/A53DKAMnm2nmP01BvJCWEh50tB8f5hzz6mP+6tJ1cUKvjmO9lLzUQ9uGIE42c786ruZfyIYNfX3t7i0=
Received: from PH8PR22CA0002.namprd22.prod.outlook.com (2603:10b6:510:2d1::26)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 16 Apr
 2024 18:35:32 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::5f) by PH8PR22CA0002.outlook.office365.com
 (2603:10b6:510:2d1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 18:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 18:35:31 +0000
Received: from banff-1e707-e02-2.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 13:35:30 -0500
From: Ahmad Rehman <Ahmad.Rehman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <ahrehman@amd.com>, <lijo.lazar@amd.com>, Ahmad Rehman
 <Ahmad.Rehman@amd.com>
Subject: [PATCH] drm/amdgpu: Skip the coredump collection on reset during
 driver reload
Date: Tue, 16 Apr 2024 13:35:12 -0500
Message-ID: <20240416183512.19660-1-Ahmad.Rehman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|BL1PR12MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 443ef72a-84e2-4c3d-1b09-08dc5e43ff12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASxZgKkFmZQwRhE/cDPFb7EZXeOQG7lrtod6OUuJokGZaoKzPv/PQIV/y2MHW6vcAxNLu3kXBmE8w4uSrGSVapiszo203H9I89tb9YJ++N4AlS99+Sr3/mL1DHxOsguw3wVBKA9Vq2j+SrNblPQObesPTW2TMZTJ50z+a/c62NAKuj17EoCHAFW3799KEOgSu+uqZZ9m/Xte4fWdUVEB+6CBx/PQh+8p3Iy0IiXjlGKHO4KePu0lQlIxdIv7hmvj7LdmXmdO62F5UiGzNx7F4R2b0ljBP0duLI6kIYU/X43vPbIBZM8Y6Yi7s80JoROFSHbLchK3ta4khMHmSJehSdjLmf9Kbb/C54ny5RhrmdmeiziOWPMAZTnlCA2W9UTzosYuINr+OPyDN8bHWn4mGkGPep8mlv+owAxge2CaB+sNgxFZ7HNtjnuid2KISC7iCeGW8e8bhC0lRkZjuKB+WSyYPztRcHxEgCJL7rxZc6b69+J+55Stl2z4ONU+O5sI62HiuA4JeNfHIrFvGgsE68Plgkcm1ZiQNKl35wM+lvlDwTm47nADpEspVn33GBJFNsAKitk9ER7IBJXCrGvJQ/HhdcOCUV5IrQuRRdiw1laNPGzYXa1u9znHAqCdD9YtfSqob7VrP/AhJZDSZJLFKXCPyjt7ljYZjYNGKXiaDQI0jM0sysz6P8JpdsGQ38wFgHlGrT1NRlXTkHEpcSwiYFc9xl9OYrCEZYhWpqPPsMpJ9J+FKH9L+TJvHKPBTwSd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 18:35:31.3958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443ef72a-84e2-4c3d-1b09-08dc5e43ff12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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

In passthrough environment, the driver triggers the mode-1 reset on
reload. The reset causes the core dump collection which is delayed task
and prevents driver from unloading until it is completed. Since we do
not need to collect data on "reset on reload" case, we can skip core
dump collection.

Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1b2e177bc2d6..b4a41f075512 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5430,7 +5430,8 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 
 				vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
 
-				amdgpu_coredump(tmp_adev, vram_lost, reset_context);
+				if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
+					amdgpu_coredump(tmp_adev, vram_lost, reset_context);
 
 				if (vram_lost) {
 					DRM_INFO("VRAM is lost due to GPU reset!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6ea893ad9a36..c512f70b8272 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2481,6 +2481,7 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 
 	/* Use a common context, just need to make sure full reset is done */
 	set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
+	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
 	r = amdgpu_do_asic_reset(&device_list, &reset_context);
 
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 66125d43cf21..b11d190ece53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -32,6 +32,7 @@ enum AMDGPU_RESET_FLAGS {
 
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
+	AMDGPU_SKIP_COREDUMP = 2,
 };
 
 struct amdgpu_reset_context {
-- 
2.34.1

