Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E75F94CA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 18:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE7510E8D5;
	Tue, 21 Apr 2026 18:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZwFsm8Rd";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013001.outbound.protection.outlook.com
 [40.93.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A40810E8D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 18:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqCID7kYkCx+Y+6EPmGKr/O4WpCnYKCFm3M42XGlhsjwL85f+kEE0eeqvxTjyOIPpLZJx4JQ5KD2DgH58HFCFJ4tOIonau10UgLUx/83cweXrzGR2yyADQ20W1iwnh4Hk4CIE2Pl8iod2BTbsHY3+eQ7Mh0zdkGrhmtNlR6xEg2jfCC9SAdmGuLGEd5sS61M3N3BsC8xnGF4S3ZLakp2arSOsH7YEvT/K6UQtI3jZNUfjl5IcjCcRDz6nDWhESlYd8b8EIWRvEqBi+9esoIjBkn0aAO9f12i+9xE7uyrgPswlIMF7KLnAlpDHvT4DI//6zSYmTdgjpEZf1RbU59vNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWFt/RNUMCwJueL8ehlf9O5NMLfkbg6H+pbGP8GPM6Y=;
 b=YILiLsEcUWT/KFJfqJaMwvcwcW+m6LEAuDQ2wQFhk4Ing6z7eL5mQRJLsoyzd60N+AA9+za7VqCM3s2KNAV7EzZobYGGsOcDlBtsNpb7lmCKUIxGmxr9kq19PGI+kyBEde7Pv4ZCNekxfkAUHz3dfJ80eKqTvgrbiafjOeex46OMyZ2PxB7uiAAOe0OWT19wXd+03hkSXo5ILYcjoiRwdgrDGG0GIFk0Vr1AQw0m4DwLdx4rJz6TyHUq3nO+2EtnBeIt2AnvPa8Tkohk3A1p7/7Z2XF5Mx4W9RnRRrUGvy8J7dwoJKIkT8NhDEdxNlUpX1axBs3Rm+a1mvdpvULAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWFt/RNUMCwJueL8ehlf9O5NMLfkbg6H+pbGP8GPM6Y=;
 b=ZwFsm8Rd7K/50UcMNn3QZVo39H/8eI2l1ls9IfZlZF/Xrpbe6V1+8+7S4sPBhBApOMF/pIgsahioG4co6jTfDV2QEBvPTmeh1BmDcKSb9cuHa2QNWKGe4qhk6vCDrxZD7j0ojrBP7mJCSAuPyNl7aB3CldeY3pf0kKNnXJM+DZY=
Received: from BN0PR10CA0008.namprd10.prod.outlook.com (2603:10b6:408:143::27)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 18:06:44 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::e7) by BN0PR10CA0008.outlook.office365.com
 (2603:10b6:408:143::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 18:06:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 21 Apr 2026 18:06:43 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Apr 2026 13:06:41 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 03/11] drm/amdgpu: Register WAIT_EVENT ioctl
Date: Tue, 21 Apr 2026 23:36:19 +0530
Message-ID: <20260421180627.2402093-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
References: <20260421180627.2402093-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: c36e440a-e669-43c0-0377-08de9fd0be82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q1dd6T9Q4rhbmtkIP453E9/Km0eEIbKhb7x3O1KfUIwGP5jyayJYndJaOXKg6YMSzy7lnSM5SduqQb8KmX6uKaKX1QAMis1JbQgCdnWOQ32kyOFRTHMVThPC2WOK3vIWvLUYF+MpR9HubJiq8P+ILlWh931RPAsEP+aCbv44ZdWbyd6LGSHmBVFHAiPIPJpcGz9b8VjjllTNWOtBrLlxIHrczI5TM1trDK4YykKbH5OtpSzcMgDgAq2R7t4rsokRTO/FFA9fZkmFsjE2pd3Mc8hkj2EyH2L6j+Og5JFRfFe5jnDYeL676GjCSCB4yBrwFqCJSqsIa2uIfBqlXronGTgjThDZZvoLXybFWIBYDlWy1LiC5SG3FhHTvqc0SSwQjusrIOrA+SZkJfyA6MtidDBez4s5wQeztypOswbuBDZ0E6k097T8Oytt6hZC30p0vjadAHLe2R60SApbllNHjnOmPcRkicqakKDF0wKME86P1u3+0Rfnn1t/iQQrlHlia1zan41tQVq+7h2If1DsysT+mM2hlh6rmVlya7vNii44z4ejxJf2ZYj7QLfmFv2SeX0hxhyxp1bspsDsZz9miQSmvJlCxiq6MS60AVC3rp7TnQzgiipVpGZ85j9UWumVWDWk6VDO7HrmHU72bF4VxLsQ3OiIywm9M2W8Wr00c6BU+xH/rQgdvr5hw4NeR5p22N6hUxa8RqXSyZw42w5F3hkZH7L7vExjAG29a0CrJ4LDK1HD7u50ihYxDJudEHnVlw9CBRqO/BBABSeGrNUxgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hjSrGwSxYwhbxq7gBb2y0Xx2i+SVR708zy/yKjp35P+q/wCVmDyNfAIucu7m/bWLTP1XbkZCS4x45/YCZZ9sOjufmCvTg3R/OEjO2LTXlXuQsm31kJR9QQGuqYFcvHe95e5/4TWIrpLqKWGA6/03DN4n6KfYEXT2RVpiRifDy6eC2uQ/+qd6qr60b9nrDhOpEMOr8YzveSpHOdmOHasjo0uEcrx/JhmWfgvRM70ouWNdf/BGMgpeZkSlueg5+j9gafc7Bnl5ewKz0emt9NoHiOfUQXr0UJwRNvI2FzBsG8BVGxsaL5XAFdN77DWoccOeMp+NxlBKB9hm2ZiW3RmOLBBpjFYveUxeh7LehiJcVe2rVTl7XBkYspuJqpFs68New9k/H+L6tMfjJRCxKQdq6PvrQsQs+d1OnmkaoA+NETb+plDaTqv/2nJbXlcnARCy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 18:06:43.0969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c36e440a-e669-43c0-0377-08de9fd0be82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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

Register the WAIT_EVENT ioctl for render-node event consumption.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f4acb785b3fb..91b143c3683e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3079,6 +3079,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_WAIT_EVENT, amdgpu_wait_event_drm_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
-- 
2.34.1

