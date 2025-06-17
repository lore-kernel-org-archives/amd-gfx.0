Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0461C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 08:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6CF10E51C;
	Tue, 17 Jun 2025 08:02:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CIHsPwPP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3208310E51C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9sAEKfj9w73AgjZI54Jm50Nu/+lY3ZOOeYl+3kvFimyzfGHUcQhTRcs3YcPvS+oWKy1YL3622rdR0H52VFSPSMXjUQIdymvkuiQxo358XflcfePKMUO5M0DstW5WfRjtzpjZOxnF+Vy7cf5A75SgXrTGibnyJXKecWrMvpcS6ntvY19wfWBbroLvH+y3sxFHECbwi6cIi+AiJrv5V32/FmEHEPoFtpZF+r6xNeIGjB1JXCEsCMc6jDgW6m4BgFyo4P20q1n3wEzlAigZhQ3YTglmNgh/fYrRABeZagUZpFG1UUAAzNPEhvjn2oAFeBG2J0QPjNnDuyiwkp63G5k/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4kDFFL5zbqItlOJkMu3e6ZnYt0c3DuenYzylBkq+dE=;
 b=ZeHxstdodZlbHfkyw5GqC4eqKwbvrUxHcBqzYaA7I51hjs/5IEge4PWGJ87hM/wVLGeVNA4FAERRgoTJiude5thrGvtYCuCQ2mj7EDGR5/8MsfaevN9eM8v3eJs4/klY7V7sperNLlNnMZIVSma+rbW6T4kmdzLdDKrpHLSxPDzaRH7sYIvN8hjdJbtakcr7/Gl/1OGhnv2q5XHd1vHIQSrdg6NCISLGbae1mqE/fCvLFe+5djIYiKpC1c4pqc4RSuGyJFi2HgYzGSVxHgf10RB+Eij+x5Z1APLJN40FShCvl+TYeC32usdslM1IpsReDhuaABeDVH+qkVu5zL/AgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4kDFFL5zbqItlOJkMu3e6ZnYt0c3DuenYzylBkq+dE=;
 b=CIHsPwPPoBaFUp8kgB3VsO9OPBmfashmSJ7FC7VOd+lXOSNPEhNJOQx3yWT2McQxpoFNNYRKFrArhNUWgO7NifnQhGdf3pr6K/kFx0UHBuh1GZ5e6oLncJiaRJP3wPvT9i5BcJ+gSIl0SgBNQ5v7vxQwnEKAkDsvhr/76ZoSjXo=
Received: from BLAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:36e::16)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 08:02:15 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::13) by BLAPR05CA0009.outlook.office365.com
 (2603:10b6:208:36e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 17 Jun 2025 08:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 08:02:15 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Jun
 2025 03:02:00 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 01/11] drm/amdgpu: validate userq input args
Date: Tue, 17 Jun 2025 16:01:41 +0800
Message-ID: <20250617080151.1093481-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 647059f6-95cc-4f0c-4468-08ddad754601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VB+YxmoGuG83lpS7dskGH3Ti8W2jPPKSfjLBfJsKLlSxV5ygqCn0kxa8GRP2?=
 =?us-ascii?Q?LwL0Lz6bdRbKOhCdPHfAB34ESJyYbhOL9u05KBeuWPMGFVdv+V83PB/lu45t?=
 =?us-ascii?Q?2rXamKIjWaKXeh3iGEOO0UDD4LErIebj0+UpIs8gD/ihQP0jTmVC+fKALoiv?=
 =?us-ascii?Q?y9UWDTfP3h/lRajMEfOpmhLo4zaoOfis/OWHQ6vIt/9H4TIrjv91mAZJQYP3?=
 =?us-ascii?Q?mLnQEhqjtKOhVyFVQafP1KDnNtxDGlaHZOE7Caa/QHsr8fyZlpZW0xBR3afl?=
 =?us-ascii?Q?ZwJnqpyyUlBsHJQC5mrO06Vo9htbKWb60b4kau8359m4S/b7vRQr2O+W2O5L?=
 =?us-ascii?Q?CG4hbrtH4HNjzjL28KUFiQnH5G7aYYL4PlmhicNzFp5w9IeIsQiYPFqZ5G6w?=
 =?us-ascii?Q?Q+OCy7RgLTrmB4acxVqGvhxP8F6cqUJZGMWnK+WKWjVdsUPB0oB60iimGU/0?=
 =?us-ascii?Q?26W+HXS5wirK8B/dvRZK3dMuTFs4TkY6k3lH39G3HFliG5IeWisTO3WEheG+?=
 =?us-ascii?Q?g6u1aj/Q98kmXdROwG4xPEa3rJlVgAdodD2aDFj+W42TAzy7FIwdMvFIiEk8?=
 =?us-ascii?Q?hzFxT9v6L8nrR3h0HmpDPrjIdff2zRLO9LGyON9sNpshyg26jtJuahffRN9a?=
 =?us-ascii?Q?MgmhM3zUqlEor+uA/bef7KYlUhnK5nYvWtIWlo/YI4pDsv3b/I/LTm7aAgdz?=
 =?us-ascii?Q?N8Q/c7j+NSO5R8YeShgCfghA5PCzkSYaxynRHfQrGwkb8901RBryeDwqUSjU?=
 =?us-ascii?Q?Bj7jlNWAtrVuBaQBzLi2gAfpxiNQWrKthWY3DRtSDqk6SZMVqRvv0JDmgCMZ?=
 =?us-ascii?Q?oJcSoXzBwYQyolv0DCvDDCH0Bh4f6Kanz+ByMqV/KjrzVz/e/drLSJtnt6QW?=
 =?us-ascii?Q?5CbhaUi386q1G7cGfKbKya/NOduJaV+hNjfkor7DCMkL7cHFI6stbC0kAp0k?=
 =?us-ascii?Q?oRk6oIcvj2lmvptk9O3lbB5M+dOVeEWxtsGLDa/baOolbFL2uNPQ3DcnS5sd?=
 =?us-ascii?Q?lD3e6W9Q46i71WQFh54Jx3qQjTCTG/uMy7+UgydBqNtqCBpGM6mMpF3NKiKl?=
 =?us-ascii?Q?GIgSXaCKctnxLqY7bi0+zma3YUj1lsve0M+48GYFSGMhu6xG3+mRsXx2Xrmd?=
 =?us-ascii?Q?jKJe1gsNwFaTtUl9jswyxWsd2tKYkejwvCVlYPFQRUcVKCzbyFJ3MsFBy25A?=
 =?us-ascii?Q?PbvYVX2j8fgBbceKO+mwEFg/6US/ZX5499DTJrtLh2b5gVx5oVva3OX1bPEh?=
 =?us-ascii?Q?6dRBNRIwR6trGu2OuenADB3iISmudS+f+qGcTsGG2D208UtDRMfeZy/csdQl?=
 =?us-ascii?Q?uj9khQ16pjgQqg3Ujg1EwIXXNp9cKr9MlHbJec/3whE/ArDyxeL3lT9eKslB?=
 =?us-ascii?Q?EybwFKMoWEMGdRjzPW9K8PCBGnSPX8NN5Y6Qg5rX/bAr5Uq/CPTjcRvfcQ/0?=
 =?us-ascii?Q?n0RMQKxjEWpsKRDib4NURdxSRk7iORxY90mHresHhfqiVA1ygcMBqzfyJh6+?=
 =?us-ascii?Q?augOZUuNsQbxJ3md1k4Hgqlvdxnqy2+fzZQ3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 08:02:15.3209 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647059f6-95cc-4f0c-4468-08ddad754601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279
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
rejecting for the invalidate userq request at the IOCTLs
first place.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 80 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 ++--
 2 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 295e7186e156..f67969312c39 100644
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
@@ -485,22 +468,44 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+				args->in.queue_size == 0) {
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
@@ -514,6 +519,31 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
index d6f50b13e2ba..39decc0b00f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -208,6 +208,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_mqd_prop *userq_props;
 	int r;
 
+	/* validate the user va at early time to avoid the time cost on building memory resource*/
+	if (!mqd_user->wptr_va || !mqd_user->rptr_va ||
+			!mqd_user->queue_va || mqd_user->queue_size == 0) {
+		DRM_ERROR("Invalid MQD parameters for userqueue\n");
+		return -EINVAL;
+	}
+
 	/* Structure to initialize MQD for userqueue using generic MQD init function */
 	userq_props = kzalloc(sizeof(struct amdgpu_mqd_prop), GFP_KERNEL);
 	if (!userq_props) {
@@ -215,13 +222,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
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

