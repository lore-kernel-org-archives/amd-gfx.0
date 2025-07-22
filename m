Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AECC83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902C210E30A;
	Tue, 22 Jul 2025 07:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yvukc0s7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2FC10E30A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBlpbluvi++qoYk4SKLRuOlOx+drl/qD+paT2HPeCd+sqxphCmHPHvB6WEuni+UX5Cm5d/A7/OWKHNuy9dAvdvF+LhshtyQ2zedgmYS2i0Z1lHHj+M1AqiLhUDwPKuvvEROSL/eKQYxz6x3eKl180hfEuOph2VgtzoJv3OVQHXb3gi/UyopGd8oP1ajjtAMmSh7PWYS2QA8RnJJN72pUlRKAuKUda29At4vBV/+9/YbzgWQlg9ocO3m0Sk74wbtD+kpUI1sJgWVc8Fk1HOJNsgzDz43Lw5wqM77rUGzR5/wxdqY0HMi3EvvaBWi2jJdl5bvf6gf/ZnY8m0IKjAsz3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=WqrD2JLxxpmZcCY0ivQU5v22AeGXpv5APrCgAacXRkl1zSrl7fgJwmNpDF2aQJtJcFPFk9PfIHisBYNv0y9y5YZqLO0y396tpgPsk83xHvZ25jB3jqC6kn3Azznn+Tm/B3cogFZm1DRSIaBpy2d21VlJ03wsmAEG1MLPZqJodq2gIbA7kOALdo634iCer5DEgCDZpoqoNuU2oI3XxFWieQLUgmWVE/v908Mhhvak4V/JVijcJbCL4sYjXIoQRdvRl6z1+XdRsbvXnZe9BjE355aHhL788WI0+42Qo2Ii2MfJoEG8VL7czrmewWy09orhl+G91dRj6xlUl68PA2UT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=Yvukc0s7zN7e3/2wPKdAR7oGbbAG7hnZRycjpBt5MC3RNOSyYi3OMqON1Iuf9AX6g2+OZ1VeAh54KNNJyLmHudOmVdhgnA8aUmvRwMTbsPyn9AN0iC52aY/azq0qE2bs8gnj4lDZrAssM4QwlK7ZH2/SWKxgNLxWZgCRSw49oB0=
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by DS7PR12MB5981.namprd12.prod.outlook.com (2603:10b6:8:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 07:46:38 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::58) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:37 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:35 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 01/14] drm/amdgpu: validate userq input args
Date: Tue, 22 Jul 2025 15:46:10 +0800
Message-ID: <20250722074623.1464666-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS7PR12MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f514b1-62e5-4e03-fe5b-08ddc8f3e396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?akobkX6TReXyVUzmaIVZyoawpR4kxLAEDHuo43qDCqmsLgATU1WUj250gEUi?=
 =?us-ascii?Q?ToPh+6w0JhnA8rHVhgtkSl9nweAd+hzeFbZm8ysRuv/9KpWNuR7jFjRmqvuL?=
 =?us-ascii?Q?p+ED7is88miWhaMHriCZcZ5d05h0W19eX8N6h4bVqBfJMavcjLUoUcieRnfM?=
 =?us-ascii?Q?y/KMwXaSJCV61TG4ofHbnhQ9t6ClR8iRkWvjA/nWtpACVVfwIxoKgdT6BJfZ?=
 =?us-ascii?Q?PE7HqOrCgJCKvSyV+0TopD2HJVISkKs5dz/Exki40wKtdsE2bTc598M8I/UT?=
 =?us-ascii?Q?gDc43SUKgwVJyv0RkdTzKCaeZO7Y+msjGgx7FD34JSw1wbK7OgqlqEEO/wT+?=
 =?us-ascii?Q?KMVn7Rq92vJdH76LmHsnybbYARU8D7mSkyh6+MMAT6Fpj3NS3gfX4gNl7RSC?=
 =?us-ascii?Q?AjZLq4WGwUyyzyw35K9A/dSzuLCgq4DBbbIGMelV8u3a+fYcUs2NpnM1bIta?=
 =?us-ascii?Q?PDxpLu1WO3jkBEsqkYLdBAgSlfChaUQBcEShX2ZoMM5x0JNw8hSREuDPv3CL?=
 =?us-ascii?Q?xwTLKeu6fTYV1hzQj6Cq2QADEn13a2zY+r8lyu/5auE1Xcp7U78wXpdigu63?=
 =?us-ascii?Q?Y/yPuwGHwFCKgrYz77hAIlOrQf+zXS4zQLdcfsAhGN5V0M+uyo+6QAdKqX2O?=
 =?us-ascii?Q?b2txJPvk30FLhvca7/O4l50lQwYuu6VHtB/zRFHvkuqKXhU+s+mB9P0i+WRg?=
 =?us-ascii?Q?lgDEgX5m6SADoybphZfJ59fn9XvuXZW3leLxxwmDlJRvZhkYmUFhA/mSIJFf?=
 =?us-ascii?Q?idEwkDFDFf3HckAto1LvRFxI6El0eid22Ei5q+w6P6ckTnN1x42C5+d1LjdD?=
 =?us-ascii?Q?hqlnvQY9KcHjzVmhgqFFvdMCZtfZEUXJyNQ1gE/Tujev6OimYqco96Nodz31?=
 =?us-ascii?Q?SbjtIWLW4VpNbVvTQyIoROck10ziAY9Q5LA7mmUEZWogCCDeIu80YFUfooG4?=
 =?us-ascii?Q?Z3/6Qip5TSN8irf28xdkZZMvr71R8Ees6TUNtLbrxNDzIF+yX8yXooRdu/b7?=
 =?us-ascii?Q?baj+D0jtLLuizmqgLdrjiW2Xle+T7qpWTC1SQHVEX1B7xw5iHCXKbDaxmtBA?=
 =?us-ascii?Q?3LapbBV9R7NtkUsXsCWn285jbgnTTcL9hzV4BFrzFPve+IoB11jrVmXDfF8d?=
 =?us-ascii?Q?195hObFszJJJQ1xcR9AFmeXQvaoB2/f7SER2Vea2u2IKfSj/nMjfTvEbI+Xq?=
 =?us-ascii?Q?xBXJAtAucRAw+Cy2KN+aC7YV+Ti0+lA7hm8DDAqbdvSwGE+r+SopNVVzX/cI?=
 =?us-ascii?Q?vS6shNmI9LjwXSLPISSFGtWn43GasxkWMlmFfhJVFFLF8cYpjVylCH0Oo4GY?=
 =?us-ascii?Q?EdGzk9AAWm530HBteXCSY/PjsffLx23hJ6lAWE+elEWau/GW0S8oSVByHO0C?=
 =?us-ascii?Q?ib12fuMilDhyj6CRqYoyUhfQUmYxPWAkDLI+ciECEmlRjnKln6T/FdQHGpI4?=
 =?us-ascii?Q?McDk8pJaetjlQDC3iFKu61P+J/pTONX2iChZHQPRU0DpwCkYFZaa5WHs+pJp?=
 =?us-ascii?Q?5LEZs0Gis+Q6PtnooXNOGZGD5gYxlSW8U55u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:37.6976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f514b1-62e5-4e03-fe5b-08ddc8f3e396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5981
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

