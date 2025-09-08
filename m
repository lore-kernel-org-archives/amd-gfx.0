Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074F8CA1013
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F9610E47A;
	Mon,  8 Sep 2025 08:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fvSQwwOH";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2D910E47A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+ggeUaPg3bFz6nEdj0EdiP6l9X8SbaEJ+LcRfusf+M+lkurdN7Zmq5wiS4uDXq75udpFIrrgSCyyIrmomhoX6yu8XMrKJkMss7rK3g1c66Mpo08ap0sM8uXusgTR0tfBn7Y7zym0eksRMuOceID42DE+rZT0erjvvDECkYaIY4xfX4Cnc9xcnSOqmkueAp7Dqm/85dJc2VsQDplmom6Uu/GOkoU3DgIzo+8lNu5O9pyXiqgEjYyc6oBrIvOyI+AkSBuZ45yUCm6WQgwFHVkO3Je+Z7K/BMThjSyFyzT28ZFlvXPIGwganUhlBauzvtxeN7n8X594Q9rXMkWJcD3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=vo8gNWS4OWKCAN4qmaNH6mI7dPOVSDp/3/6PFpsevVwnAofYtpvHi+WG5BFKMen4+sJJfC5iBstbWzD+Q8+T3WDgTVSg5PeHHuu1qHKIt/K6bTdAe5ZfeZuacYUypisKt+0L1mjJPY8HzeWFBbzrmE6NSgqzNml6p561PHv7ekl42H29NpLYPL6x7r7jU63AdRu6CpxTOtiuLAfakA4RQKdH588NR2xSwtH0/NwxODFF5sKbS6IoxU2/CObIz8blK+ZrG+D0rCgAbBThr4jHxEoaJfgDdPvUsmB6OKd4t4xksC6QQBHvdwTigMwJdXsD8fhXbsD3dCn4y9Mjt/ZO/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=fvSQwwOHZtdpqsfeKLlHv+oJg3L2aZQzrl49coWinAsgyrwyLi6WRHp/3SICsABfVUnZEXLnWFKu7N5TYgRTs8C8Lquk+i1xl3aybL6zRJisHR4GlcjckKfEdgBK2edLIpzF8LB9mQSlax4Qt5GowxEM3VxKVC+0CVWp1SHLGvg=
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:49:01 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::59) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:00 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:48:58 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v10 01/14] drm/amdgpu: validate userq input args
Date: Mon, 8 Sep 2025 16:48:33 +0800
Message-ID: <20250908084846.1873894-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: c290ff56-a991-45cd-931e-08ddeeb48e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0PCPcbkHCENlw6RztuwMiJ3rDzFJDFObyUNN79ciJAE5RawGSTDFbafNP876?=
 =?us-ascii?Q?Oqcb6Pr4KPSz/TnRCLwYp7uirV2UV1n6lCtg4qDt8N71gl4LUb8XQT7TFJ2O?=
 =?us-ascii?Q?xlqRK59swfD61tGKWFNW0fx9shNzMc0sfFIKyULFJg4tW2lHtGLqh1H008wp?=
 =?us-ascii?Q?O6ytZn1L3CtGeVoxTrGNDTN0UQfzxfA6t9WjcMunaWhCZ1MEplxIFHtQh/pt?=
 =?us-ascii?Q?FmNwMnWMPaexnnbtiWwQ2JcEuLOYbSVeFwdUj3ChlFdF7s7MJXC0qhR11J5x?=
 =?us-ascii?Q?sy7UCIBmVvUE9Im7z72MJJVrh66/gt401FKsmE2ROYGgwB9oKDJO69N1oAAm?=
 =?us-ascii?Q?hve54cWqqplLwd46t/pxbdduSIPOYLuGn16IdxkF+kwP07roLHAp7lqMJyEr?=
 =?us-ascii?Q?J0luNn7/JmLGwMcd5rvSbAMuLTAueG1zfdf80wre8Zy/J08KhBz7S4kBIbi7?=
 =?us-ascii?Q?JE+s7RyMurW3E3B6FFklb77MCeMgbBwx+gyJwuGz5UL2FP3u0XC+q7pUxkA7?=
 =?us-ascii?Q?JWQSXgdWWROubKW+P6Uzy+KMyCH3CIYGLTMTLRFz5clZF+cBvK9fxp3IDEBd?=
 =?us-ascii?Q?v+zYB7WO2abx9+dLgIWuQgXUqAyZcpyoqZx7vzjtguEJyUw/R6agBvEod0yJ?=
 =?us-ascii?Q?GzRNglSXgXLWgfCZDuCMABCvxwoCc39lqNQMlzvZQvusoxIFZDGXFmGd3PkB?=
 =?us-ascii?Q?JBSDAPrERA98BniMIdJdGfW4RanNIkEcuJpawlKsM7O6ZpApFqmTd55yJygP?=
 =?us-ascii?Q?wUHKinO5uIU8IvfITExXPqf9l6wj0lJ+lwRdfbVUqynzQgEq9bp0YnMsdQmO?=
 =?us-ascii?Q?puZbo3LqO4bXeCMFBn4iXEZEz+Ow+9TmS4izkTaODrcZRyoVKWbJEzQM/3D8?=
 =?us-ascii?Q?530gmrSKJB3293gjIigWqVvVDmKukNoFZlBTgQXr3jzAadA61gArvWt5h8Hl?=
 =?us-ascii?Q?WS8LepGx0bxEHSUub9AsMzsE5DxnHFQKYAeMTubOONE0fVCpdNrGwu9w6q38?=
 =?us-ascii?Q?8Ron6Z05mBjAELglAGFx4mCevLnAKOD6kbT7szeK3PkksbUPapkDm6D2sZ+D?=
 =?us-ascii?Q?E/wTkvFEM2ytMhveBaUO2tW70aRF4MB2gQWREGGZyfjKrVHlqO15OJQwg1HZ?=
 =?us-ascii?Q?3QgGrCFhZxDxnqcOhKud+Ag4LYIYsppEaAk8vQ26Qg7jvbEN8Ovm5LRsBV2Z?=
 =?us-ascii?Q?7f1ZR6cu43W6Lm9RvWxRy1kG78Ct+J50XKdDID8RIjxB7TLjeY0jxO5jRWQo?=
 =?us-ascii?Q?i3mkKJ95dmMC7RqOuLfchc4sW0Q5vaSW7qjZ8QDbDaZxjCs/3UBW3/uMos2X?=
 =?us-ascii?Q?W9lgHAY4TLTG0T15O8SPCT5JqCxcmBOUTToLvkSo8WoWxErPlkEolntEsIOh?=
 =?us-ascii?Q?0Y68Cj7JZ5dUdVkp062tDy6TCoorZ3Cuqy2DJ/tUsGVO3MyLxrtq5gZGJGXS?=
 =?us-ascii?Q?P0PPbvjDZ8TokYnY4oh1rTzOx//e80yjbaGkMTS+WqclnDLY2G1n7UG4Qeei?=
 =?us-ascii?Q?g6DeKO+JQsauAHy9U1KF+qzc6TIljqznp+Sh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:00.5952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c290ff56-a991-45cd-931e-08ddeeb48e62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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

