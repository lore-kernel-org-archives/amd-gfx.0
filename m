Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10650606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h3tX4XV+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA3610E583;
	Tue, 17 Nov 2026 07:24:18 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C98F10E549
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dimtObWI4Z8vw/SHhrDzf0lq8+Vq4Q4nJxl6o83WG3GFfD/5SWe56559oVnJaG68gIWmSnkpigA0NFry4FUaoKS3Qo87bIdzyg++rg7bak7edDTxLnEJBLdz1JfEl/mKjoN6bQPM26L5wKlSAfE66ggMdSIyVXJxUmeN61FIURFdG7Vmo+CYpJ7DIQZz+JrCVK5R6WIyQsV4uSA03uiQUM+mTd6+no41Ckx1yNcVwCBN2fHqhCGl+TLb+TMN4kngJI6omkbUDg9Os/7ZD6foYVm4FHdRBGisEveJOQH+SerHkZS9Ujyj5OAAdzpYphk/AqjfBRP4U2L5agdbeJC+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD0lF8WZil9qD5vrhHC0Q+dS2HPkbhnc+WNQ3QL5lKE=;
 b=GR/ZFJgb0H8SsWCNj3ZlGDTt+FURtBY196kAMOKypGABHJq25/tPt3DAtFKesqY9Ovf5SMnsDGwDgabx1BvrRRUrOpePfgJHcjBEgclsS/exNVwf3waJKxWtYEveB0tW3wL0OS1YA0xntkjmxDbNn6nW6slD+gLSpTWPkiXBShEV1rvpCUgYOwxMNrhs+mI7dnr1weENGE8r7otZ6U3EwPPXiaA+0WtqlpgImZfPB5E3wcWz+5AxQ3PX0yKL0o+m+eXheA1SoZbHsWQB6BbYhHsQNdVx+4kIPl/RMq4fwoWT5zJf26CaqPOH906Qav4SlylUhhntoCpOSTwPM1QpbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD0lF8WZil9qD5vrhHC0Q+dS2HPkbhnc+WNQ3QL5lKE=;
 b=h3tX4XV+vGuykE45mrV0SJ8VgYO0/VH1kPNOaK62pqRbHtmkdvEcnKWmXbFKFOzOVgy5cxdJoFnJBT0oJuq1I6ugozLq/dcVBnnA3Iv2BXPH3LseI4vyucMy1rN6XZT7r7VBmlpTqAJZ57VqlidlhOblNVbiLcHQm7dzeNvSd/M=
Received: from PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::6)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:24:08 +0000
Received: from PH2PEPF00048917.namprd05.prod.outlook.com
 (2603:10b6:510:348:cafe::62) by PH8P220CA0028.outlook.office365.com
 (2603:10b6:510:348::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 07:24:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH2PEPF00048917.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 07:24:08 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:24:04 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH RESEND 2/4] drm/amdgpu/userq: implement support for query
 status
Date: Tue, 17 Nov 2026 15:23:51 +0800
Message-ID: <20261117072353.537506-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117072353.537506-1-Prike.Liang@amd.com>
References: <20261117072353.537506-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH2PEPF00048917:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: 917bd2e0-7981-4674-1f6e-08df447bc4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|261102123227099003|56012099006|11063799006|261026140227099003|261028144727099003|10067099003|261021121427099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vK5peHMNrRNb/8pg+S/7JLXRFcO02cIfgBpaa+tP5P+WDTzRKTT5L4Hx9zM21UL+QALC+0/xNa6xXl5nFFzUEN3gjIcpf0FfEgac4Vpj15RHeRNg7kgx+gbMt4l2DP6ppb7Of5V1VrdTfatEU6R4e760OXOhxRjcV9qRqX3weidACfHorG4gFU/COGO5AwJ1QsZdJ6jWWvGU3tkIy9WTBv66bSHuyxQUYBePlvdeG0MfBeWLi1wVoRR2tyCzDnzUnj2uGJ3gHnIfQtZdP5m1/zVtls1/BkZFAmwbzO5yg8gLtVv1JR3ER2fU0LnPVMdPy0vkQ1coxiu4xHOPEZV7ugoZsCaCwDWmsNAJjYl+/blL2U00QEz8zik5CkVol5rH3iMp2Ec3EyP/j++YGlgp4DCuUkDLFLW6DgU10+VcDIF+bm55Uc7xjmD74TsqsxHqnB/8htgAL0MyB8uSxAO7D1K9XWgJBhOaA9i1gnBBMeadGKSuehfxFxm7DS7ruNrySrdD8SDBmlXnxZwCE3+2QHgvSla+7ST5zOsjBJDsaEpX4RaiQzc+JpO5clHOLBxDyeMfkrkum5ix3jSI00leOjV1VBd3MOuf+vEHquHGUEzqDVJQleQ7h0pADZIqtFAlKbojXtsZErGpNQyW2Ej5gyO/ouU9sjNjkoCHIr/JmFi9oj3/flb0y4SWdxawFwsPyQst1ek+Dsh8GqjtH875tA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(261102123227099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(10067099003)(261021121427099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xGVIyMNBhQVXKxd+lFvVLWoytM++aDThKSTUTRWeGuFh4+lZiueYeC2G2/h42pqB1TV3jaygSCyicxOgjVfXHx9DyasAd5p8ySAeDBmhK4U/u0NE9fItO+qvPguIKhRZExuBPQDltuLj8MUFS0TRPZgHfsTWnNe9DvYdlt4qM2L4vzi+9OlFQa6fwSGof4T09SD52LRUOEn/J9qmM/p2caZN/IXDsPJbXXThXWX+cS7REgMgW6AvnCSIb39bB7O99pJhkn9Z9iOCaGb8X/McD22kIcJAmd3sbDWEbq1Rt/jxpOLApW9j1Yfy8lwvatNNdg0EKTgC8CTykDNlUhuoKdcS2cYJGZ9WvZAJj9eVBvJTE1t2VMbFCMKHQOWNfHQBfaT2aSMLcxcb+9Zz+p3LlX8xZJQEQkQgrejJL2jY4wAhqz/zmf1SDe/oFhmvcvxP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:24:08.0503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 917bd2e0-7981-4674-1f6e-08df447bc4ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH2PEPF00048917.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Deucher <alexander.deucher@amd.com>

Query the status of the user queue. Report BROKEN when the queue is hung
or its VM generation indicates that VRAM has been lost.

v2: Misc cleanups

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 34 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ed6f3b67e872..496137fca1f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -702,6 +702,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv->xcp_id : 0;
 	queue->userq_mgr = uq_mgr;
@@ -817,6 +818,33 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	return r;
 }
 
+static int
+amdgpu_userq_query_status(struct drm_file *filp, union drm_amdgpu_userq *args)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_usermode_queue *queue;
+	int queue_id = args->in.queue_id;
+
+	mutex_lock(&uq_mgr->userq_mutex);
+
+	queue = amdgpu_userq_get(uq_mgr, queue_id);
+	if (!queue) {
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG ||
+	    queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
+	amdgpu_userq_put(queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -938,6 +966,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_dbg_driver(dev, "Failed to query usermode queue status\n");
+		break;
+
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..d1a2e2a45861 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -79,6 +79,7 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	uint64_t		generation;
 	struct dentry		*debugfs_queue;
 
 	/**
-- 
2.34.1

