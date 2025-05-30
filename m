Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AA1C3ABB2
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA2610E7EB;
	Fri, 30 May 2025 07:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hse45EDB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A173910E7D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlfZQJcK5EejCrlZyl6y5rY89dv+2u4eCH70mjx/bQbPeWOcWCpU2d/nAVRpIxiCY43+OUAidpfrb99hRkwaRwi6OJE7P77p6XmeN3oRxNIWwFagsc3UnT3ITsZSP9nqGSrJ1u0FHHeEfVr/Y6QZLsvoVl+CjekdWbCMC1F/FJUpPtmg59gQy3e0v1BIjBtHgGHVkkGcNwuOj3Y26y0u01RprvxoGCJz5rPANyAlqO1FlAsUHjFwOhmlPa/sKFOIBYdTloiCzbJ8BdIu+YDHfdwAQmXHQtloHihifeF92ewdC49J3+zia8hrX1TS7JfwIEfDCD02GLORxAmi4p37RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L1v9gonnkSO2YMOj5p9/C4/aEDEIlBpukf7A0A/Wd8=;
 b=s/5NdGsL08c4CJc5aMS2vOzA1nfoeH+HYUJdfHAnyQWKYCljUMLU6P4BL21uwsOpSA6n3ccSgiMfxba85tm2TU0po4BKG/dFiIFstb2K1ibv/lQ96B81R34bVyLO0peAnxekRBUOxzunGQFm9TT8de/puVZObobl+MZZK/33AAe89hFjGLeo0i7grMPsOpKJeyRyp3ODHVDXazVSacL/ZDXb0gIRXpVYotq+hYCK/h5Mct9VHC77jJJo6ZEp3o+EUuI2jmjC34euT0bHXY7EY5igx7EvOBmgi40crbjI+aivN8GbOpAi9aJRVthPUGxIQjdshzbKMyFP2/B1Pp5byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L1v9gonnkSO2YMOj5p9/C4/aEDEIlBpukf7A0A/Wd8=;
 b=Hse45EDB/++4tYr7w/ciJ8hDBm5O6QByiqwPuEj0YpQDga7N6YgephbcTyeI2vDuh7+8uORFjaoQuaFT6Cxu9hW6m/U4WthVXap7XAqFSJFicVZiDSF1PL4nENZguucU4uefoaqdp298MQxYff8L/CXfudK9UigJMe4hE+sTr3M=
Received: from BY3PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:217::25)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 07:55:18 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::a8) by BY3PR04CA0020.outlook.office365.com
 (2603:10b6:a03:217::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Fri,
 30 May 2025 07:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 07:55:17 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 02:55:15 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: validate userq input args
Date: Fri, 30 May 2025 15:54:57 +0800
Message-ID: <20250530075505.882004-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0931e837-f374-4462-7e6a-08dd9f4f51e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TNkBtV3S/3wTsFzBQNc3/No7I3KxG2kCk9Gpwgrg5zqK6rvjmMkmzXmS8WsT?=
 =?us-ascii?Q?3JPXvDHB20VhlqNoM1Y316bYgi1Ns7y+Mfe2H3RRuaDsUMsyf8gJPuBgrgwL?=
 =?us-ascii?Q?+KzxbuH/LMtt2PHv22HevmFa74PLn/c/S4vwWTrrja2BGCrLjorqy2BKlU+M?=
 =?us-ascii?Q?D+KsbxyjGi0KFNMSZYorBXwc4SfWI2k+LPgFwwzZgUoGSaN7vTj2k48CUX3w?=
 =?us-ascii?Q?XUPwlkLzUH4hf0ikaTx+DAFbqYS+B056equ7yDMgqf2jXJ0nhVCvBWT5/Qkf?=
 =?us-ascii?Q?n9RAuquIzOjGGl0s46xqkI/LNTjhx7xmT18LlFVKqOBb7ySQHBrVX7qkeVpz?=
 =?us-ascii?Q?13ymp3XBxSG+gBEDX3LXaBpJmlAWUXSHCxeG4XSzyDVCToK7nV39WSTZrVe1?=
 =?us-ascii?Q?DfXGsinadtCw07Rw7vvn1BZ+MhsgKUuNxBSZ4FEubzePZXfhh4i43LhcuWmx?=
 =?us-ascii?Q?5fExcpVp9ICCFGKdiMvMwcNniTk9ZZXdlg7D6ZTZKRwS3emtcvRb04dGoxkS?=
 =?us-ascii?Q?yKHETzhOS4cl3kBfLC2nn1wJzuggON7aIJ+dMWpCQ02xrQWxXifJeghK9Kwt?=
 =?us-ascii?Q?w7UiCo09sn5OvIDuQ2eixaJqTR0bb4E1hndDc3TDt1RTW32/DKOG+KdMus0j?=
 =?us-ascii?Q?iA0177XNMQhlBd4TNYd9p98qcRYsw2bks6FblUIKKtXfT/wUMY3MmxeKfwDh?=
 =?us-ascii?Q?LWOp43ltQQAOh+TM07FVcArfBO475y7eELiMa6HfLO8BsWGZnyUQXiSZvWG3?=
 =?us-ascii?Q?oyhkir6ti3Lfi5uH+sPJArTFSy1ldpfpI1Zr0JihavJlTc23IFTu7h24WNqY?=
 =?us-ascii?Q?c2OvcjmtWefcfsDlaKUkhOp9coJr7rN9ji4k8o0TrbKwz+h0Lhlo+sSWhYS1?=
 =?us-ascii?Q?zcRplO69c44B8pG9/HEFuGhsmJkPl7aeqvXHQ0ECoQbeOhOlg7D6YtlvNmBn?=
 =?us-ascii?Q?ZFj/ZaiJ2cx9J78sfPTePxu8zS4qoNe+aOK9yCGUwu5cpFU5lplR95T3OI3A?=
 =?us-ascii?Q?huDQjrzuLK/lAHzfL/BH0HNAIgDKRu6kj/lpd/edLnKf/jpRn2Pms8XELPiq?=
 =?us-ascii?Q?rDebST0mimFy8wYft9TSmTsfwkfx75F++e0vPw3xHam3Qomzn4Qi6SugmNp5?=
 =?us-ascii?Q?nzlJA1xMEae+6G3z6Wae3Om6MMhz08WEIK3qFc2TyaZNQR8TB57HvElH4gNI?=
 =?us-ascii?Q?SGAbnrO6/JdCBpmG6OTzs9+fvvPLPmT41Zca2nVSb7R/443Rj1RDRQSquoOg?=
 =?us-ascii?Q?7YB9xT30Jz3YICEyJLoi2IJbC5h1fP5BCxfim6Jx1aezE2Pbr4XMUTLjVfHN?=
 =?us-ascii?Q?8/tqnbzSLEPEz/0LdRR8HoMjkzoy0SwZ4zrdSmJ+ws4xCZ8nl2G9cjq2m/OS?=
 =?us-ascii?Q?0Sw5IHbZarT3Lv5HnIkbw+xFWkx+7DnqnaMwtAjiumHNvYFXLiNG5k0iyvgl?=
 =?us-ascii?Q?MnQ4x5DXr3YXZKM/iBb7oPSGH9ErBu8jqr4fzx3f32d632iCJGLuz12wUpA1?=
 =?us-ascii?Q?7I5cfd3ko71tnB+svq3GngkIHpwp/W403RyK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:17.9943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0931e837-f374-4462-7e6a-08dd9f4f51e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 --
 2 files changed, 55 insertions(+), 32 deletions(-)

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

