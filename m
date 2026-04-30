Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA265CD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 16:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6612310F3B3;
	Thu, 30 Apr 2026 16:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QQ+uPxGp";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3238810F3B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 16:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfDqLAaqcaSaAT+DU74j2NVctKGA3sPUKjlwhqbE1p3dXiTUe8i0lwk+K7ceRRZ3UhkvpM7HvwhsljqBKZv71MIwE/EOulGfqgnHWEHS/jBUExMKJ4RN5YKVh+Y9ogGV50yfDdvUXri4woWp6c6gxFxz4uUb9Gg1hWJwWJm7uO+Mw72LkxmotPe9oDHEAuIlkISoDlWRx9x36tz1yyLNI5psqT++LZxqfqKrlKhmEroKPrXOVYYbFHh6IyM6Iyyj7E1gnwhEggo6gnXpXk+ogTc7COfmvlSrwhUb6u1XfVv1JteNoBNMEzXrYDX8mN3LigrENFC9UJcQ1pn+4f9Ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPBYMtzOvgwvlrqks48Ffr+jP1O0c/6pFe77oJfkW9s=;
 b=A0a9SJID87J5133dQaHXwM11GrKOdr144EUZ2kXPtKVpVjmdD0ekLqMytFiaoBdeK9Zq1aqAMbiDmyxP4u//sHioikN42mmoRKy+VFy72XROo2j4BaSWT3QS1jsFqeVxv0emQTUljwwF4I+ODuSI7Avixmmh7vBiUroA6WicYshnEvofRRlFRiY2e7JEXGZQoujelISVZULJaNsyJhdn6Muq4vd8NqqIQMX/Tb2aQre7PDE8vDOnhYKe1ol7Yp4MhzTv4syJA0nhtEkC0B7JZyFHwEQZknoNRgZKwBbrr57GyuSnkxfnivKgIhlPXNGZ0Vy0uGRHzEZ8ZrxjXqEM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPBYMtzOvgwvlrqks48Ffr+jP1O0c/6pFe77oJfkW9s=;
 b=QQ+uPxGprya2DtzqwixDF8d21wo2C+C0olkiR3kH8bf0FIkcJ2v+WxCh/8iSq12CGLWIpR8/YURAP/s1G/E2Y5UZouHwy/8VDMLNZCIGyndHmxhptAxcz/bS73CGzWJhhFH0jHQZ8AyHDNnGFXtVf01L3+K9P7NjTzMG6tb8LA8=
Received: from BN1PR14CA0014.namprd14.prod.outlook.com (2603:10b6:408:e3::19)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 16:12:36 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::2b) by BN1PR14CA0014.outlook.office365.com
 (2603:10b6:408:e3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 16:12:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 16:12:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 11:12:34 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 11:12:27 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Alex
 Deucher" <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 07/10] drm/amdgpu: Add AMDGPU_GEM_OP_OPEN_GLOBAL
Date: Fri, 1 May 2026 00:03:35 +0800
Message-ID: <20260430161146.2851078-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3f2151-414e-4abc-69f8-08dea6d34a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: B2PvHS0Fs3id79mWU0wBFXkisvryNQKsh9Gx6b9PYAQVS6h6PiT4yusefBXwtif7PVzAXFCJXI1F2Sr5IMHg8nJPAl2UtNGgqUQ6x+lTuYEwcGqydfs5yFF0THs5mcqtxu2lhR9Py5XWhZvSeuNlchX1xLmKfmdAJn8AevysBqsKaxAsp1VcpfOlmrIM04FJy1mdbQnUSlBJxpWcA6ZfeA34BDpIwhSxW4eey2Q+gc0cTh2DZcyYBiiZLcBG4lLO9Wsuf/yD3HUiXe6TzzpaiVvaIjGNAe0BsxH0/kbVxtC+15P8U/ZCKONEysNIlWnP+vkOoPwOv303RXDSM3EFctzOYzchSwQXJ1oRJn6qvf5zG3RSd3TKuvokGuBg2KnvqLGo0YWOJykyLqfiQzHWVhczWnQtAoQWAu0L/OzIm90qK2tWt6aYjHmK8qZnN2JgrB8ZY4FuSt1VxIEK0g6sNG+A6KByoaCNPl77F5TGgni/rVGHIz+9NjIY6yfcKOl+KYBNfqYJ/OoiUTSlH2vJEEMGSnTuTTBoX4h9K5H2+OHYFBuuDiYe9o6UCJguq9nxcSxPDsL6+E6zzSpT5s1oG1AuB5nfHD4mdxgj6S4v6GVS30nldU2QzLAhogi3akcr5LFREKLnrusPIj6hk77iEqxmvIugie/3kfgYxL4xbsk9dN50OxpvLEWFrlmhV2U0AmUt9wd9SsgjR2S6iokpPAuJh8Os+HIjDJfS+j6+N8Qgbzsska73DaN1MdrJ+YdcPxcqdDdzB0R1Qubt8Wavkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FwdlX9QlCACTSypgtfYMLgzfCwnBIlFhA6QbFugjSiek2ppucQYTJMzY8em0+qPrycW5TjAaFxEFkwp6xEjw/rpc55sM4t7f0oUOsV+lddY7TwuYI5x/WZ2YvPxhZ6po6x/uIJCRciiRGnfoH4CTA4Xah+HL+wsCKj3cCFMCKnIRDHN8GoMZc64f1fVJZcjCGPEagD6FtFyZQXP6cvUo1bNfawoiZ13+kyZBvD8PvfCSW3XbC2L84tFBbg5XtxxvyifvxLsTt2NrDG8/4PDMYuEsrLfMv1JjvpD6UKQzloTE2k/dY8tKR1jJmTSgGFDMO3cWP4yxNK6rUrdI2AMi3G9/U/s+4RltCNADoJhVWnFDkqHOPjBIpR1YrYrK0yqDZEsM4DLj91SBm7RgqJRGH0jP/M9V+tNbAb+TmV/DZQ1z2gd/qS2/9MvbCmkNNwAs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 16:12:35.2790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3f2151-414e-4abc-69f8-08dea6d34a9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Cc: Ruijing Dong <ruijing.dong@amd.com>
Cc: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 44 +++++++++++++++++++++----
 include/uapi/drm/amdgpu_drm.h           |  8 ++++-
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 0071d6957828..3b486f2bb2e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -999,25 +999,44 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
 	return r;
 }
 
+static struct amdgpu_bo *
+amdgpu_get_global_bo(struct amdgpu_device *adev, u32 id)
+{
+	switch (id) {
+	case AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL:
+		return adev->agdb_bo;
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
@@ -1036,17 +1055,27 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
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
@@ -1130,6 +1159,9 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		r = -EINVAL;
 	}
 
+	if (!r && args->op == AMDGPU_GEM_OP_OPEN_GLOBAL)
+		r = drm_gem_handle_create(filp, gobj, &args->handle);
+
 	drm_gem_object_put(gobj);
 	return r;
 out_exec:
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 3ffdd2f8c418..1e04771ed3e5 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -827,7 +827,13 @@ struct drm_amdgpu_gem_vm_entry {
 
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
2.49.0

