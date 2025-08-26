Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5E7CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B5710E5EF;
	Tue, 26 Aug 2025 07:47:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ncFsHXfz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E958710E5EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZxGaSrttEYFJuu/aWyc6ag8ImKxjLrOEjPbbLyhEFcu04cjk7MmkPiSbdzLzyJ0zUl4bcAW9NNihGSr7h682QErT8priYkXzR9QKjqnT1J/m/naMA4sRMAGQTOgFYiDEA69WOaNl+ssU+ecZK+yBrnMLNRTYzw55bsJWCDTYSCCjkAgbyOkXN+prFe95+xue03CRXxEFUA5lVz/yb2bVaiX5hiHGPdVH8UQhABtrbPIFVR9xAzBtevChPAcMVj48aYLhdy1OUlLrVw+ALSWPFe04tfQiK3v2H205pGUceI+Oj3CSeCalcp5tKCGBQD2hbJCLoC2+rQP7+XoYYZ8Oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=ZKv3Ke4odivY+T0MZbxPvfv4sowsJsY8t62CPXPYSb2Jaida+hoySwVEBmEh+HxmgosmWUtNlDIOW9NNbdNLaZG5tnf7QMqcZRlQ2P7pW//maWaePhdmsuBW3wgIhg0boaNY62YedbKiS6eMp/X3Ozv/qbckcbovwSShFHzUiG8F8bf5+JD//zcoLS24cei5df2shPhOZ1cdCTEuhmlFV3GWHlPmv6taXWpLFF6olq+yyyDINYpwLtSiJ34YEL3f9oMQPKkqKlZuE4Y7pY2zh64I2XCJyTr0GL0Uxjtwg0oizWSndKqkO+1uI7N9uv9DggRUGm9xTfqoWrHOPqMe0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=ncFsHXfzbfuASaKM0aLqVS6efO3ZYlt3G2/Ee0w11zJKDX5WgQvIIU7ylt5fZd9zKEY4/QjvRP4YCUIl+Xpmozb1tqtbIBR4kCdDh+AXZYw7p+rvYdmdhF6tTKEI+h7hfCqDpzmgAfvTNONGiQS4yNXkoCHaZE/enqylcJxapeE=
Received: from BLAPR03CA0074.namprd03.prod.outlook.com (2603:10b6:208:329::19)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 07:46:59 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::b0) by BLAPR03CA0074.outlook.office365.com
 (2603:10b6:208:329::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 07:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:46:58 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:46:55 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v9 01/14] drm/amdgpu: validate userq input args
Date: Tue, 26 Aug 2025 15:46:33 +0800
Message-ID: <20250826074646.1775241-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 45659ecc-6fbd-4010-9220-08dde474bcb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V7Cuo5z1ClYDpHtivpmmzb5So4h8Q1bIDpKmAhodt0klkdBEXAxZnNoikCyr?=
 =?us-ascii?Q?m/JxlvkEmhWNIsiR1FaT9VkyiieuDrEaiTrmEeN7hY5u8f5No3g99cER/Y73?=
 =?us-ascii?Q?xdvS3pU3d8FKhcGwGNPbGVG6MaSYQ3t5yPOgC5YLHGvwTPrNqzS6kl14mpHH?=
 =?us-ascii?Q?dSiVBnljQ7/SdvsYepgzboeygYDtcguQoo/hkZiPUldMixX2CM8Le/MYUPBD?=
 =?us-ascii?Q?ceRjb1EyN3LJ5WVnmNgNjRBzpF651hk4l+Vs+2bxJ6pd+idYgZjwcqNGVBSI?=
 =?us-ascii?Q?V5KcOazXHckSBUGE/1yHq9tUYU3HAdZyt5A3P/V0z8yMXYPGWIpDXVV+I7KI?=
 =?us-ascii?Q?AT7h2lhvxTpLhfiozVJgZz8c6PTEXixaYLInjpZwcF4VqWmpga1dDt2OgQ3h?=
 =?us-ascii?Q?HGhmOf4k2pRkXqiIMd4gNQnHub60HeFgv0jHizwuJODjdupMRmR4fjlMdOo9?=
 =?us-ascii?Q?vNXXZHwGi+9klJBaQFPgj6SrFvcmNESLiaCxkYKb6RrEzVKnzTB04eXLdjp3?=
 =?us-ascii?Q?u0EqzIwyNRz89Ninhr3opNbk9TmLijMCbuJYA5JNkT82rJ8NsECmHFAX/AcF?=
 =?us-ascii?Q?Lg+pWXd2Qnt7M+jZ36tiQU3L9hOM83lAg2dGR0nQtfnGd68sUE+XooIQPZZD?=
 =?us-ascii?Q?ADjqxpP1hmrIlDUwKtRCwAgAoU/xCNMhccgSatDMfMhjwV4DyQ+IbJs4sU4C?=
 =?us-ascii?Q?1h2Fyn0A38dqRSdqo7/qlvwe+vFR0Xpt3u/2j3YdljOYNJ4LI+oxVsrvCZzQ?=
 =?us-ascii?Q?59ukztRzoSf3lmOnyPqhDbog4l5i5qeTc/MrvRGW7aUTkutcpj2uWTQCgmeC?=
 =?us-ascii?Q?TTZhKR2d7eMdwqBdKHa+XK/jrXEGCLkKYYFk5Yt63sev1Dj3Lzjg9dVqRpE1?=
 =?us-ascii?Q?SGqhI013FH05S4Gi0LhE0qm8WNrpWJUDOIaSGFoxFSVPvks8WcTENH56F0Bg?=
 =?us-ascii?Q?jHS6WQZHcw12sigagyUIOkBKbdHQ5z8gJVRh9mQm6MtPzdMZc0LhLN62tS1M?=
 =?us-ascii?Q?hTpaLwNlh4t2qpZEQkN/XiK/ZWtVIrKn5UptyyNcM5TSrpOBoQUZoBkSWI1J?=
 =?us-ascii?Q?VMbsm7gbEsK0u3m5xg06pL/W7YeE/0jX7kauKwUzaLSybPT3TJMsDJtP2eDN?=
 =?us-ascii?Q?YgbzgFiFCW+cRatnYJ2EqYGf038vMywaz+UOwRwtwg60Rewiz4FSO518qwUa?=
 =?us-ascii?Q?xW6dyPF00v3DdtRwPcusm8FS9/1pf+frjMKUO3XSGwEHn59hr8eapIcM1mQD?=
 =?us-ascii?Q?JhP/fX2Wia3w3iHbYd0uJb8MKwNyOov65mKvVLKfvefLggQK0KIv8mALwqjv?=
 =?us-ascii?Q?1+cfjb1Sq2BPyVraz+Sh5gpq5hdTJnWdMFaZSa4MgSRffzNOyL2LdeLFu1hc?=
 =?us-ascii?Q?Pm0H8Afg9+lr0ilje7VM8S1cqrh9RttnArGNq3oIfHcJwCQTAXob9ao1J3JY?=
 =?us-ascii?Q?xcbXyTmQs+47qnSQfqEULLAZp0GywVOqWCiRN+NQFJgcVA72PjANpIoskLHD?=
 =?us-ascii?Q?PZ7RvO4A1RwQOSlTCKihqxOFDi0wl20IypYW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:46:58.9329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45659ecc-6fbd-4010-9220-08dde474bcb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
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

This will help on validating the userq input args, and
rejecting for the invalid userq request at the IOCTLs
first place.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 81 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 --
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 295e7186e156..7f9dfeae4322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -359,27 +359,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
 
-	/* Usermode queues are only supported for GFX IP as of now */
-	if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
-	    args->in.ip_type != AMDGPU_HW_IP_DMA &&
-	    args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
-		drm_file_err(uq_mgr->file, "Usermode queue doesn't support IP type %u\n",
-			     args->in.ip_type);
-		return -EINVAL;
-	}
-
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
 
-	if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
-	    (args->in.ip_type != AMDGPU_HW_IP_GFX) &&
-	    (args->in.ip_type != AMDGPU_HW_IP_COMPUTE) &&
-	    !amdgpu_is_tmz(adev)) {
-		drm_file_err(uq_mgr->file, "Secure only supported on GFX/Compute queues\n");
-		return -EINVAL;
-	}
-
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0) {
 		drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed for userqueue create\n");
@@ -485,22 +468,45 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
-int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
-		       struct drm_file *filp)
+static int amdgpu_userq_input_args_validate(struct drm_device *dev,
+					union drm_amdgpu_userq *args,
+					struct drm_file *filp)
 {
-	union drm_amdgpu_userq *args = data;
-	int r;
+	struct amdgpu_device *adev = drm_to_adev(dev);
 
 	switch (args->in.op) {
 	case AMDGPU_USERQ_OP_CREATE:
 		if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK |
 				       AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE))
 			return -EINVAL;
-		r = amdgpu_userq_create(filp, args);
-		if (r)
-			drm_file_err(filp, "Failed to create usermode queue\n");
-		break;
+		/* Usermode queues are only supported for GFX IP as of now */
+		if (args->in.ip_type != AMDGPU_HW_IP_GFX &&
+		    args->in.ip_type != AMDGPU_HW_IP_DMA &&
+		    args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
+			drm_file_err(filp, "Usermode queue doesn't support IP type %u\n",
+				     args->in.ip_type);
+			return -EINVAL;
+		}
+
+		if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
+		    (args->in.ip_type != AMDGPU_HW_IP_GFX) &&
+		    (args->in.ip_type != AMDGPU_HW_IP_COMPUTE) &&
+		    !amdgpu_is_tmz(adev)) {
+			drm_file_err(filp, "Secure only supported on GFX/Compute queues\n");
+			return -EINVAL;
+		}
 
+		if (args->in.queue_va == AMDGPU_BO_INVALID_OFFSET ||
+		    args->in.queue_va == 0 ||
+		    args->in.queue_size == 0) {
+			drm_file_err(filp, "invalidate userq queue va or size\n");
+			return -EINVAL;
+		}
+		if (!args->in.wptr_va || !args->in.rptr_va) {
+			drm_file_err(filp, "invalidate userq queue rptr or wptr\n");
+			return -EINVAL;
+		}
+		break;
 	case AMDGPU_USERQ_OP_FREE:
 		if (args->in.ip_type ||
 		    args->in.doorbell_handle ||
@@ -514,6 +520,31 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		    args->in.mqd ||
 		    args->in.mqd_size)
 			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
+		       struct drm_file *filp)
+{
+	union drm_amdgpu_userq *args = data;
+	int r;
+
+	if (amdgpu_userq_input_args_validate(dev, args, filp) < 0)
+		return -EINVAL;
+
+	switch (args->in.op) {
+	case AMDGPU_USERQ_OP_CREATE:
+		r = amdgpu_userq_create(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to create usermode queue\n");
+		break;
+
+	case AMDGPU_USERQ_OP_FREE:
 		r = amdgpu_userq_destroy(filp, args->in.queue_id);
 		if (r)
 			drm_file_err(filp, "Failed to destroy usermode queue\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..1457fb49a794 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -215,13 +215,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		return -ENOMEM;
 	}
 
-	if (!mqd_user->wptr_va || !mqd_user->rptr_va ||
-	    !mqd_user->queue_va || mqd_user->queue_size == 0) {
-		DRM_ERROR("Invalid MQD parameters for userqueue\n");
-		r = -EINVAL;
-		goto free_props;
-	}
-
 	r = amdgpu_userq_create_object(uq_mgr, &queue->mqd, mqd_hw_default->mqd_size);
 	if (r) {
 		DRM_ERROR("Failed to create MQD object for userqueue\n");
-- 
2.34.1

