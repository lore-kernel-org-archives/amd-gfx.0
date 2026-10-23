Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD743606A31B
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 08:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VO53Y5ck
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5759410E5A7;
	Fri, 23 Oct 2026 08:34:47 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E96EE10E5A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 08:34:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJyb4Qi/FBW9dEKcno5Jqw5LzP02yTfxxE3jSrSX/zx179saXWuVZrwffec/pAua7cvv8/1G2OQHqWr1zbK1k4TrpVzlYqdfoOlQqu+7jgrS9ajlYWG9JPesqxeQmoO4o6B1qfUcQpHunB+C8krycp95GFOGlG19c7LlwfBa23HWNejEHm3ps2G1jm9CQAYRItEJJp2xMmBMMeRGoz5F1xnYRVEdv86fjZB2kMymfULuZrBhGlV8fbelYsnboEfq9vD01EFAR48t1oB0hTiNDR9E/4Qg9Wgh/0U8+nNjXtId0gZ0Nfi8OtnMa0cv3Jzm6uBR6ZzAcZ7Pr3XzLAVjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LR3rLzmDTlqHFhNV90KOCWcTJsofY2/BxLpb3qtgnw=;
 b=kToTNDXcNbwgVkZQn59IU174I8VFz9SUjQ1QM9yXjcT75e12fOxUMpY6k8hU8J0ebygIXbtDqBBjl6R8f7Yi9f7gtFPkeqsKHo+cVHUy/Nw7Gm27chplP/1QuNIqeVzn4QH0AgFUXkcHoMqN9LAKiRT4iPP+NvtwzeLqTNnflWql1zb0tA0lBQzbDFPwkGLfYkNBhjYlqvNbbzdym6lj+Z92GkIzj0egqVwxlUY0s/vCW4beBUSW2YbDVqjR6dr0CHdsbM2PPiDYlt5CBRHigMgAnzBMk3HIhv6RYKm5tf9mbzom/+z2YQr+8bctG3plp3ZMSQ2w19fgq+mqcYjPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LR3rLzmDTlqHFhNV90KOCWcTJsofY2/BxLpb3qtgnw=;
 b=VO53Y5ckCrvapDqvYnU8peykTl9jDMZQRZSLHXFloUN4u5gQfLkFMxNOU1U6WafRqq9Fxb8pfbR6Ye8V/QzoI8lMAqqUJCA0Y7uVZsU+gPInN/EzsbzJQy5zsw1xZSm+45XMse5O0bN/wgnoXlpDhOanlEoZE69g6dsaWvjaD+s=
Received: from BY3PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:254::7)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 08:34:35 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::65) by BY3PR05CA0002.outlook.office365.com
 (2603:10b6:a03:254::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Fri,
 23 Oct 2026 08:34:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 08:34:34 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 03:34:32 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Sun peng Li <Sunpeng.Li@amd.com>
Subject: [PATCH 1/8] drm/amdgpu: save VKMS modeset state from the system PM
 path only
Date: Fri, 23 Oct 2026 16:34:15 +0800
Message-ID: <20261023083422.3049246-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 952b458a-a807-461f-4e40-08df30e077ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3BfNtWq3k9X8a/qPcTyq7Wduclyex2FXxBY6aq6TRNvuoTa25ytG6ZdSKKo0MJTaJhmNChcLmNrpQuVtjuzkxNTDVt7EjiQ8hj3hfiyylXAFtNNvgrmN1M5csWxwntUX1nMqu53rep2yuVbGnMrm4f+q9f8OF8hrawykbRo5GKFANhWDc72P/upZjBNDWq4+aMUBRpzGBCg8wOOTv2yZEnDqXyKhOyRHLkBVjpvXe4U/wBGoFyBNGQZ1PqLYPjVvv/evCQzKDuXIfmLNyinqb9bMAI1L8EzP19ptUq3ccyLNRJ0DpZtCcItrHgqxQ+suoxwjvGmBUSNTKapaRhcwt0GkWCXyrbp9573QsQ+ZWYobKETvtZJKALuYb7xbNwqZ6d+Z22HtnZo19FFLzAEkfkQJX+Ux5dynHpNzVzN/bi/xSOedomAzeqA5KV5Ne9yqdmfgAjfev7XQ9m3yuPCpms764kJIEmuNJjXx7JVqo9zEgB6Q9wtZEBg5w7bE3+WiIJSO44hKCDqhOYy44f7vkNqIBkf7P++RkSG3Mt9SWbRGoslUydNmZBjre9Gh4VTj7CraxLUNUCIzWTxe3K7HE2518TYWHN1Iu/UINljlGpBUOLq7Cn6WIRaKNG//0ga+5wrGsDJABPkduKadhZFaCzUyupvN01Cs5ZE4QsWgAoYW1GeYJs0PIMVz9SzXWdHkUR8ps/yAkAYGr/2nLXL+rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4Wrr08zAbl0HCDOQb+q3HvrO/TbuRJjYQPZh2LysRuMihrjiYQhIeTk+JPpzFoelbM20t64KoQ2ExsgvwD82LK/NaBCRl60AucrRiCQDby+hPS4LUNHQmmPa3BlSAfDLOeIhk6EQpCBXuP/Ue9ncEsCq10Dx4xs2s3MAri4OeR+vo7hMWo7OjONHa9WOxxPS4p3Cn/Evq2ZGk/B6Zkx5j6a2w8xagwl2Obd8yLvW/9ZhyjactE8D3KMI2rvH22MujJl34B20JgZDq3Rvv8bqTXLO5a01mVgvTQq4O+yDDEMq80PdXeLnrHG4L5HlQGWYZBlpCPk2cGyVbOEVekFkORmNve3ZE371zGtlEEDMmwgXjOHDLLxanaMHIc/UwN5RUH9VViam4wLuBqxrfkPKGJjUIbHavE8gcX7k/vwgw9vcGnDH2aOpj689crYEPf62
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 08:34:34.9214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 952b458a-a807-461f-4e40-08df30e077ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_vkms_suspend()/resume() are IP block callbacks shared by system
suspend/resume and GPU recovery. Calling drm_mode_config_helper_suspend()
and drm_mode_config_helper_resume() from them makes GPU recovery take
clientlist_mutex and the modeset locks and duplicate the atomic state
while holding reset_domain->sem. Lockdep reports:

  Chain exists of:
    &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem

VKMS has no hardware state that a reset can lose, so the reset path never
needs these helpers. Call them from amdgpu_device_suspend()/resume()
instead and leave the IP callbacks with only the hardware init.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Cc: Sun peng Li (Leo) <Sunpeng.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c   | 14 +-------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b74f9136aa2e..406c5f2fbee1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4568,9 +4568,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	amdgpu_ras_suspend(adev);
 
+	/* VKMS modeset state is saved here, never from the reset path */
+	if (adev->enable_virtual_display) {
+		r = drm_mode_config_helper_suspend(dev);
+		if (r)
+			goto unwind_smartshift;
+	}
+
 	r = amdgpu_device_ip_suspend_phase1(adev);
 	if (r)
-		goto unwind_smartshift;
+		goto unwind_vkms;
 
 	amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	r = amdgpu_userq_suspend(adev);
@@ -4618,6 +4625,10 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 		return r;
 	}
 
+unwind_vkms:
+	if (adev->enable_virtual_display)
+		drm_mode_config_helper_resume(dev);
+
 unwind_smartshift:
 	rec = amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
 	if (rec) {
@@ -4717,6 +4728,12 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		goto exit;
 	}
 
+	if (adev->enable_virtual_display) {
+		r = drm_mode_config_helper_resume(dev);
+		if (r)
+			goto exit;
+	}
+
 	r = amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
 	if (r)
 		goto exit;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d6b51b3f216b..6de33f14d909 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -488,24 +488,12 @@ static int amdgpu_vkms_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = drm_mode_config_helper_suspend(adev_to_drm(adev));
-	if (r)
-		return r;
-
 	return 0;
 }
 
 static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = amdgpu_vkms_hw_init(ip_block);
-	if (r)
-		return r;
-	return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
+	return amdgpu_vkms_hw_init(ip_block);
 }
 
 static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_block,
-- 
2.34.1

