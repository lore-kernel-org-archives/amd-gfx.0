Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F531D6409F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 09:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2481C10E334;
	Wed, 17 Dec 2025 09:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BRSRLEzx";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3B410E1A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 09:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apCG3JPYd8wraK/aMF1eX1GOBOiR7f5Vsu0QMXLCoDfZeSq4C8r3JT1fpp/rLhhUNDkUECIq0nnQLC/a6+ldgd4NW2QxPVhe6yS7clLdcW/Nb3s8RAp5SRDjq5yO+N1pPBvNCYGSU/+ZDBn7HuD7VtIcS5fHzh5g0YDKLHhsUIYN2LGZje8D6d0qbgQs0PvOr3+qVsTQNNpgRI9dkF9juZmb0ImhrliU5MD78SYl9mPG5dLm7n6G5YvyicE3v9NYT+BuO5SRvSFY3N/zMO6KQsmAeaal/DdBtRG3Fv/HVyWVM52OPR0hl/hCQFq1g43AyjHzx1gQIZUGfZcwm6SgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkOmPhvTB4DW+4nRcmOSh00xBJnI80cUQaqWfpSHuEc=;
 b=nOJCSrDPQ+fU/21wzrwXtCWdnmTOmnLLHQ53wuLdSl1nWbKo8XWt3/dujiZA4+qbu1EDAJFI56x+N9Olu4fJJGnkQGkgmQKW+mRLQsaYf1PnICzYpJVp1WrnuS1vN/HxEKTgTBFeOcd7Ds3wpC4qZFJzM6xGjDwpQkkxEMv4qCyjvDxEhRoLthIzqw2MQghqmXXhXAzZm2E/L74CxO2CEQCxOMk0MuJObsiMy7KDwCWMbi9PDzumgvunpxBMr54X8JWDSfyw4wXuKuMqRGU60XbL9Vj+nzi2RShD1wt3Mn4V2SoyVX9TzQiN+k6WThSsMSN9Gs6jQfNOhRCGdSgmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkOmPhvTB4DW+4nRcmOSh00xBJnI80cUQaqWfpSHuEc=;
 b=BRSRLEzx3U0ozRfcr6koAf0A3hgBjVIvGioTw1Z/603lRJbmrEcxwiKylwGKd99vgWrdCHPkaqJGFZGJfw9lhT22UiyDuUhkzDrMxCsZk1C7GKYMbwYQY0v9/sw9hbQAIR8BiWdBzTmjaDExJ0vB+nlWagpgmmF5XquJAzhTbDQ=
Received: from SJ0PR05CA0173.namprd05.prod.outlook.com (2603:10b6:a03:339::28)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:22:33 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::dd) by SJ0PR05CA0173.outlook.office365.com
 (2603:10b6:a03:339::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 09:22:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 09:22:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Dec 2025 03:22:30 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <ckoenig.leichtzumerken@gmail.com>, Leo Liu <leo.liu@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, David Wu <David.Wu3@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: Add AMDGPU_GEM_OP_OPEN_GLOBAL
Date: Wed, 17 Dec 2025 14:51:59 +0530
Message-ID: <20251217092200.703080-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
References: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b34ff1-669f-4376-6316-08de3d4dcf4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFZpT2JCYnVDSFI0SkgweEd4NGQ0OWlOaWJVQWRkelVVOWJYM1Q2VGx2WHJW?=
 =?utf-8?B?Ylg1SWpJSlRkcUU2SjlTN0tGd3A3VTlrQnhjR1dxa1NPNG5sOHF3RDdCMHhY?=
 =?utf-8?B?RldLMUU1ZFNsUzhqbHVQVE1NNzVDbDFZdFJodVI0Z0VWT3BvRkMvdWgxRnZX?=
 =?utf-8?B?YXF3SHBQTmtrczZrbmQ4Sy81a0Q1VFFaZFFSM1l5STBjdU9pN2hraXl5Smx4?=
 =?utf-8?B?SGwwY21pNGZEQWF1YzRMa2M5TExGU3F5cmlGSllUK2FhdFFSaHpWWHNxTjVM?=
 =?utf-8?B?eENvS1g0VWVxQUtjQzhBa1JtY1YvaXF5YU1TRzhBL0xsSmdiSWNCK1pQd3p0?=
 =?utf-8?B?M3R4NHRxN0ZpdFNsQWE2aXVsbjJqMDA5ZkRjblFGS3BwT2NMdEJLRXlUa2hV?=
 =?utf-8?B?djdyU1YwRWxjdWw3Qk5UMTgrTDRxUEE2OWlVL1pmTnZjTmhmV2ZjbTdKb3N4?=
 =?utf-8?B?SG9hQTBDc0FUay9EN2JRQ2lFcHRndEVxdGNGSVhTd3hQMXNpSUZ1TjM5MGVw?=
 =?utf-8?B?dkwzS2h1RXF2UHNPakFwTFFsYmw2ZFZKOEhmaDlod0lLUVAvcDVxNTJLQ2Vw?=
 =?utf-8?B?d01ObzI2eFNWRkNiVllkRFhzWDlsWVAwS3F5K0lhSGF6UVk3WGZiOTdCSDV5?=
 =?utf-8?B?dDU2UDh3TlExSG1QMGg3NWhodEhmZ0hkNzg3aFVKbzZYelFJY0hMYmszT2ht?=
 =?utf-8?B?OEpqOGNuU085c21WU2FLRXRQekpWb28vemU3STZ2SjlYSDlaTWk3dHFFbXJN?=
 =?utf-8?B?RU13QTdiZ1hmSms1bG1FZnBzU2tmcnQyNk9zMWszQlhoL1pNdnNmL203WDNV?=
 =?utf-8?B?c2RTQmFXMXI4eVovc1dMcmNYakFPNHB2MjNSS2dLTmhuNnpKZHRjVDFSdlpG?=
 =?utf-8?B?WG9lVXMrOGZCb0QvNmpCbm1ML1pZMFc5cG9TS0RPMllHcEE1V3RpbGxKYWxp?=
 =?utf-8?B?V2lDNFhpL0ZTNXlwckVSU3h2VzZKZlAwcCtySDI2VThrL2hZeTdEeHdCQVcx?=
 =?utf-8?B?OXc2TU9yL282REh1WkpSdlptbXhtSjRDRVJaak1VUnlxOTEvanZlcXpuQ1B3?=
 =?utf-8?B?cWtGNE1KTEd6WHdsbGxsSW9UM1Y2eHFtZWFPMitoSUxJazZleElONFdPR280?=
 =?utf-8?B?aWgzNk5NWmtPcUxhbEM2MWo0aW5NMVg5YzBUV1ZqYnJCT242UzFuK3J3VFU3?=
 =?utf-8?B?clNTSDYxQ08zU1grTnpjSXRJT2lGNTdDNkVDaE0raDJuMGZ0aDVTYVRacVp3?=
 =?utf-8?B?VDViVVl5eFA5cnJFWUJUc09SenVoWDlnOFZINlBOd2M3NHRRMW4xYkl4U1kv?=
 =?utf-8?B?YVExUkV3clRZVUxWdFVva1hseC9maGJlbkJKK2hMQXdqMTFBKzRNTjVGdFpL?=
 =?utf-8?B?MGdCcHhWVGdPVHROK0NJZnlzNkdGSkhHdE5wVDVYUVMzYnZxUDB6M01weWc5?=
 =?utf-8?B?ZURJM1dValFZRTA5RmFybnFUY2pZT2JtNzVJd1Y3S0FhQXhXMVE1UG5XS1Uw?=
 =?utf-8?B?NXZ6Z25XSjYycXJCUDBwNnE4dGhjdnkzMWRXQ25ETFY2dVhuTzNyNjRieFZF?=
 =?utf-8?B?WWVqajdLMzhWTW0zbEpVSmxFbVg5WktBZWN1c1o1aWQxUWljeEo4cnNqbHY1?=
 =?utf-8?B?OUNzbUxkSXlhOEpZWCtnbE1ldmNmaVdTVC9TajBrYVFBYmxTTkpGU2pxbG9U?=
 =?utf-8?B?cmtmTmQzbDdpMVU3bkdQQ1MrS1ZBNTlCSTZORFhIMkkyZTd3MWRScXJKcCt0?=
 =?utf-8?B?MzBBM0ZkTGZtUDRHQUE2cVZTSFZ4NWc1elNrVnUrUlNZTUFGOHFZVjIvQjNM?=
 =?utf-8?B?MUpxUGtMcjlVeHpzbVo2NDIxRFF6TW9aelJtSC91K3Q4ZXhQYk1yRU13MFFk?=
 =?utf-8?B?RGdnRnFCWms5TDFweDloYjg0dWcyQy9aSU9uZGplV1VHV0FYa0o5dHcyK2FI?=
 =?utf-8?B?WWZScEI0TlFWNC9uVkhEd0dsNEN5S1J4Tnh0QnBUK1ROWm1Bb3d1dWI1ZDl3?=
 =?utf-8?B?b3JmbVFibXZpSDQ1WkFmRTg3R0IyRDZya0Fjb0dwcFZYamowOWd6OUxxSnIv?=
 =?utf-8?B?SmYyRExjbk9sWnYwOE9ScDByVlJ6Rnp5MjU4V2NlR281TFA2alo5a3JlUVFU?=
 =?utf-8?Q?zdfY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:22:33.1539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b34ff1-669f-4376-6316-08de3d4dcf4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605
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

From: Christian König <ckoenig.leichtzumerken@gmail.com>

Instead of abusing the create IOCTL to open global BO add a new
AMDGPU_GEM_OP_OPEN_GLOBAL functionality.

The new AMDGPU_GEM_OP_OPEN_GLOBAL functionality expects an enum which
tells it which global BO to open and copies the information about the BO
to userspace similar to the AMDGPU_GEM_OP_GET_GEM_CREATE_INFO operation.

The advantage is that we don't start overloading the create IOCTL with
tons of special cases and opening the global BOs doesn't requires
knowing the exact size and parameters of it in userspace any more.

This keeps the GEM create path simpler and avoids exposing internal
allocation details to userspace.

v2 (Srini):
- Centralize global BO ID to BO mapping into a helper.
- Return -EOPNOTSUPP if the requested global BO is not available.
- Allow args->value == 0 for AMDGPU_GEM_OP_OPEN_GLOBAL so callers that
  only need a handle can skip the create_info copy_to_user().
- Clarify the input/output semantics of the handle field for OPEN_GLOBAL
  in the UAPI documentation.
- Avoid potential NULL dereference for MMIO_REMAP on unsupported
  hardware. (David)

Fixes: dd2bf86d1383 ("drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Cc: Ruijing Dong <ruijing.dong@amd.com>
Cc: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 44 +++++++++++++++++++++----
 include/uapi/drm/amdgpu_drm.h           | 11 ++++++-
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 9b81a6677f90..a381b8ad9d29 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -965,25 +965,44 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static struct amdgpu_bo *
+amdgpu_get_global_bo(struct amdgpu_device *adev, u32 id)
+{
+	switch (id) {
+	case AMDGPU_GEM_GLOBAL_MMIO_REMAP:
+		return adev->rmmio_remap.bo;
+	default:
+		return NULL;
+	}
+}
+
 int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp)
 {
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct drm_amdgpu_gem_op *args = data;
 	struct drm_gem_object *gobj;
 	struct amdgpu_vm_bo_base *base;
 	struct amdgpu_bo *robj;
 	struct drm_exec exec;
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	int r;
 
 	if (args->padding)
 		return -EINVAL;
 
-	gobj = drm_gem_object_lookup(filp, args->handle);
-	if (!gobj)
-		return -ENOENT;
+	if (args->op == AMDGPU_GEM_OP_OPEN_GLOBAL) {
+		robj = amdgpu_get_global_bo(drm_to_adev(dev), args->handle);
+		if (!robj)
+			return -EOPNOTSUPP;
+		gobj = &robj->tbo.base;
+		drm_gem_object_get(gobj);
+	} else {
+		gobj = drm_gem_object_lookup(filp, args->handle);
+		if (!gobj)
+			return -ENOENT;
 
-	robj = gem_to_amdgpu_bo(gobj);
+		robj = gem_to_amdgpu_bo(gobj);
+	}
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
 			  DRM_EXEC_IGNORE_DUPLICATES, 0);
@@ -1002,17 +1021,27 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 	}
 
 	switch (args->op) {
+	case AMDGPU_GEM_OP_OPEN_GLOBAL:
 	case AMDGPU_GEM_OP_GET_GEM_CREATE_INFO: {
 		struct drm_amdgpu_gem_create_in info;
-		void __user *out = u64_to_user_ptr(args->value);
+		void __user *out = NULL;
 
 		info.bo_size = robj->tbo.base.size;
 		info.alignment = robj->tbo.page_alignment << PAGE_SHIFT;
 		info.domains = robj->preferred_domains;
 		info.domain_flags = robj->flags;
 		drm_exec_fini(&exec);
+		/*
+		 * For OPEN_GLOBAL, allow args->value == 0 when the caller
+		 * only wants a handle and does not need the create_info.
+		 */
+		if (args->op == AMDGPU_GEM_OP_OPEN_GLOBAL && !args->value)
+			break;
+
+		out = u64_to_user_ptr(args->value);
 		if (copy_to_user(out, &info, sizeof(info)))
 			r = -EFAULT;
+
 		break;
 	}
 	case AMDGPU_GEM_OP_SET_PLACEMENT:
@@ -1096,6 +1125,9 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		r = -EINVAL;
 	}
 
+	if (!r && args->op == AMDGPU_GEM_OP_OPEN_GLOBAL)
+		r = drm_gem_handle_create(filp, gobj, &args->handle);
+
 	drm_gem_object_put(gobj);
 	return r;
 out_exec:
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9680548ee41b..283410a19dbd 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -807,6 +807,9 @@ union drm_amdgpu_wait_fences {
 #define AMDGPU_GEM_OP_GET_GEM_CREATE_INFO	0
 #define AMDGPU_GEM_OP_SET_PLACEMENT		1
 #define AMDGPU_GEM_OP_GET_MAPPING_INFO		2
+#define AMDGPU_GEM_OP_OPEN_GLOBAL		3
+
+#define AMDGPU_GEM_GLOBAL_MMIO_REMAP		0
 
 struct drm_amdgpu_gem_vm_entry {
 	/* Start of mapping (in bytes) */
@@ -824,7 +827,13 @@ struct drm_amdgpu_gem_vm_entry {
 
 /* Sets or returns a value associated with a buffer. */
 struct drm_amdgpu_gem_op {
-	/** GEM object handle */
+	/**
+	 * GEM object handle or AMDGPU_GEM_GLOBAL_*.
+	 *
+	 * For AMDGPU_GEM_OP_OPEN_GLOBAL:
+	 *  - input:  handle = AMDGPU_GEM_GLOBAL_* ID
+	 *  - output: handle = per-file GEM handle to that global BO
+	 */
 	__u32	handle;
 	/** AMDGPU_GEM_OP_* */
 	__u32	op;
-- 
2.34.1

