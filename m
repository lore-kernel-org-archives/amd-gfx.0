Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A152CC7EE32
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4300810E525;
	Tue, 24 Jun 2025 08:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBiC7Yao";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B2B510E528
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5QZPsjX1rfxVxrUqfrkyIX59rJlZTJ3cAB7kjEv5iGJPX8nPgaTFP7j4QbFrDsZPJtcIReT8GlD9a+cae4a+wc4Wrdo1T/KAOBqbtBmFJGu8hjwZC3BZZ+NM60CZvKD9cRlRmS3MUlvnErJYoh3G0dt6uzwNWOyfaTCveC0eLu/nYo+UNEPipn7KYBFoUHBlYcYTXK0aXHNKULkr1RtPHWpawsCTcqZm3cpeFhTtK8nbhPD/yE4ihNzKF6+9VYtXV5lvdE2MosurkSnlZaD5oTZ+8fZ4qA/VmN4M8CeY7LlZourVnB+u1akyrleeI2he7Scj4a92qjTXMlnHf7Jjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OmwpXKhF01wSWSg9J5uRPDS+WPA8o1LJKOBUkzZKEU=;
 b=lyNDa/7mzMZKEUY+bjNuB7DzWWV8T2bO4BBrapRVWUTx0+B9MXesK/0DStswdT8Q7Ih+qkSUq3sTKpXgCCLAlIM7UWSBE6K7qvQTyyx8WomxbASheiIwze3XdEUmbg/S3NJNXV+SgjgAiEU1fAbmAjdvfdjo0pRSSjRRkiIP8UzWZ27nlHSa0I47CgxLMPs+6lPlhwsJdZoG7L2IyN8h+eGcCSd7MFymVLtuir9cFyfsR3J3dChy1YrJcONWYg/D8+wmmYkZJ9FQyKUQPzP4NvKRisHh1BQBg6DWUSJmEAIox3PIQZ5zqc+ra7+bYQ1VFJ55gfw+Jf0RjKWioTDEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OmwpXKhF01wSWSg9J5uRPDS+WPA8o1LJKOBUkzZKEU=;
 b=aBiC7Yaoo8pVyfllnDVbvfUG/g35dAyO5AN/QKfBS7i1FTZrRTCMm+x6xdbm6a4pBdZKoAtuIY+grD0g5X9T4F09h0HX+vKakrPzYCEp9pbuYck4yzwzFjrcO3w0x5aMhkFV4oYhLxw6m7Ph/O3I+bix44cuCLSmMf2VVfi8wnQ=
Received: from BYAPR11CA0070.namprd11.prod.outlook.com (2603:10b6:a03:80::47)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 24 Jun
 2025 08:45:48 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::1e) by BYAPR11CA0070.outlook.office365.com
 (2603:10b6:a03:80::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 08:45:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:45:47 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:45:45 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 01/11] drm/amdgpu: validate userq input args
Date: Tue, 24 Jun 2025 16:45:25 +0800
Message-ID: <20250624084535.1178476-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffc508d-441a-4206-eaa0-08ddb2fb83ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?86AvI7I7+xDKg6FQlkeeq3KnlnflSV+4QDL3fMx+2ySh3p1mO/rHHxRDjrNo?=
 =?us-ascii?Q?sG5CR+x44193F8+1hiQ9QHriJPBVxB45s6xGimMFkYW/FFMyjo7Suy0+VSCo?=
 =?us-ascii?Q?IgVE6uO1MAkKCX+w6+k/mOJDhaT2nuTd76F0JIpHrPWVNVIoxPCBGb/Adhqy?=
 =?us-ascii?Q?EFscV2I3f9TgGp7+CFwwEJKEIVWEdOjA70eomupg5zukxF3RzFRkaRswZ3iX?=
 =?us-ascii?Q?H8tckYA4oQneMwzt5xMeTkdnFoRaU3i37EdPi0oOwVOkudN/tAX2zOsRi2UY?=
 =?us-ascii?Q?36dcih+NuPxX5V4n+ghl9dOWj7Yqf83NFWcxuhFrRIjZvdp6zgvRDOBGSVEQ?=
 =?us-ascii?Q?NsAeVJ8QV/xUk1QRbGynCHdOoGXUUc8qPwuFxtUlUO8ydf65P1WD3bECe+5d?=
 =?us-ascii?Q?MpgJJKluakFq8Bno9K3/rXm8I0eKt/1P09LJVw9AvkIm8cfxynz3KnxnnijL?=
 =?us-ascii?Q?Lk9aQlS6PdcZ5svLc6OJPGWBqHDPnhln57Bt52mThpAdrox1U9mU56FF3RNS?=
 =?us-ascii?Q?7hf9/k5mQ+3/LgUWM2Pj2GZjZ7M8Q5MHPoKEg92cxiqPk+y2U21HMHXQSSlr?=
 =?us-ascii?Q?/sYx6WjevzFjrNGajMaMIef8BGDGqIGsEbGlt5gw6MAuTKusBNi7m1ieNhBF?=
 =?us-ascii?Q?7vq95t5I6YM4l5aYWJwY8ZA50YnSfJrG4EkzsCf8iZkYwB8FCJMVwJ1YQtI1?=
 =?us-ascii?Q?YHgamGVrFeZn1BhvjSng4DiSOBm3j2i8c9OAIQIo29UBPKJHKnlO1RI5Sl65?=
 =?us-ascii?Q?dj4PdSPJ2h+tHo8OnCSEsZd3SteoVLsrUIA2//IAjxW5/oGfZj4Mw4Z5OylQ?=
 =?us-ascii?Q?lIwLug6YvBk1jEf6EfPzQVYLZjJmPHO9q0IXIvRoQJYCGpYrV91hOyUBsFaL?=
 =?us-ascii?Q?P9eNmH4BSe840GPMr0QfkqjDdJdFXY5g3MO7Vf+zG0wOehKNG0j3L8ZlMaO3?=
 =?us-ascii?Q?plaD71O3Fumbnfo5z4HZ1OZ5nYBOWWUvtQGd2e1kx+LrrHAgnyVrzKo3ovS4?=
 =?us-ascii?Q?EUZvrI23U/RfdXoNUJOGVaaxkqCAGq9HXnSDh7D299OqTdHZJvU8g3TCJ28A?=
 =?us-ascii?Q?feJslbul4msjaaZXVSSvjysegVdow9hav6CcB5rY2QQJPBBu1yFzCqMXk3js?=
 =?us-ascii?Q?xhtK3OdkncZhHW+8FJVFcYlh4ZTvHBhJhPkp1LrMnO9d7kBREWebh1GYX4WW?=
 =?us-ascii?Q?55pc1uvVxNF+FgI1Q99TbhVXnOCf0E+U7/p4THYke5wOam+8QTbFEt96TERo?=
 =?us-ascii?Q?6yUWO+e8c0YwugcmnmZir4J2J3kiM65B4T0IQlLRCuqRrZ+DIa2KBLfW+QFd?=
 =?us-ascii?Q?qieRs03ZkC+ffsRaCfsate9IkNKb4HuK6pAMakRArBu2eIm7njb9zwk/YFnC?=
 =?us-ascii?Q?8NNB3xh5vcV6oLBzwswUVMPbotL/49Ueg5IK7Rwe9+vp4c72eNg30is2B7x9?=
 =?us-ascii?Q?EogAeJ8dyCwRDRDsaUgyw01Or7OP2hS/zXnJsNjZlsrrdo/JyXpNTZKxdnqY?=
 =?us-ascii?Q?mZryz2JRBTwj9GvBc6lTd4ulc0WqUBJctDJU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:45:47.1348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffc508d-441a-4206-eaa0-08ddb2fb83ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767
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

