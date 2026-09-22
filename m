Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EACC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 07:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BAAF10E5F4;
	Tue, 22 Sep 2026 07:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zp5C7vUk";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A07B10E5F4
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 07:59:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RixbTmzoK3pDNEFuh2+IXS03sVYA7aw4jXXZpWSdsyA3IR166JsIuaV1D1HNSffE4PHjv7WwWQjNLtVLaYksw4O8P8E8q6Qe50iKUNzpGtgFNBdgbNzpCOf+bLtP6Dhrx8WWZu/7Hp6AoqDlVomwO2lLuOk05fpBIH07AcBo+Mma7Jb6WRLTQirFqoLNXSZF22YujeWlbWFmBCvccEqSSvVf0eCziwZC7LusUREQE0IaoSwehmA/gAalE7ssJWUbhAf/3e8YfGiDptfwW0yHGCzJTwAmZoRcmAjUuOJw+zz1HJaLTgZEsEsVo8o7//+vvXHnCcFhLeEWOSZWEBJX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qD62XFB12TyNgsfjxHzvylAulTT23Y9ZO77zldCmYM=;
 b=jRE0VehRi4hpBi2YDeBlgHKEZFwbOqR44lAAIBQFjAB1vTNlUrhUq8bNxnW8VcN5qda2cvyHQMQnkKQ+BQPK0IHI1GSXPZTJbCSHIbyrzakncs0x0BIpX96aQaZrRcKf4W0hjFdgPFKpRi3xcM3laz1V1J2gRJ3S9rqWPd/EP/HebJdyvbP5aZ2CqwLfIvK4SyAoFUyTe2ULRjDb9y0Q4JVVAG12ktLUXcSu/ZO9HaW7sZ+LCYpGPSGyzAjSbzDPZrwjOSn1at0oTl8DCyyHLkDK1QiM5W0E5LsUScjJUHHYhij7LSkog/wliSjCABwemCyCTjzaPRb0/XDzGq33dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qD62XFB12TyNgsfjxHzvylAulTT23Y9ZO77zldCmYM=;
 b=zp5C7vUk3YMf+WAFUoVI/Fy9kM4pp5FLxXr1J1TqFpkp7uUGQUxc+yW4hozQFAdxOcXujSSPrkYhbz0Yawff51Fk5EFzyqSolv5V4qj6I6Z2Z8a7Jx2yISBK9s11w/j7Ss5PZZ/J8dU+BqsS1yZVInDdEVxZYym5TVC1wnDLPxQ=
Received: from PH8PR15CA0019.namprd15.prod.outlook.com (2603:10b6:510:2d2::21)
 by SA3PR12MB7903.namprd12.prod.outlook.com (2603:10b6:806:307::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 07:59:07 +0000
Received: from SJ1PEPF000037B8.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::76) by PH8PR15CA0019.outlook.office365.com
 (2603:10b6:510:2d2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 07:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B8.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 07:59:06 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 02:59:03 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH v3 2/5] drm/amdgpu/userq: implement support for query status
Date: Tue, 22 Sep 2026 15:58:49 +0800
Message-ID: <20260922075852.2335748-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922075852.2335748-1-Prike.Liang@amd.com>
References: <20260922075852.2335748-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B8:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a2042c-70eb-4e2c-9a22-08df187f605f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vvTaUGQwjIqoDAYHXIiuS98I521srzdrhQjgxYaOQtjVpDN6oK7QgugdGM4dXHgr3rdDO2/l2qBnzRWZrDqXvbjrOzeq99VdG5tf+5P98PnbA9Nb/iMhdcM6buMlAyxMpam7YCpztQbL/UW1zusOYz1bwRzGW/y3RUwABA+r4kGxMamI97okXZ15OW74Q7UtmxlhPOmm9EUCcAgXZabcNhVmABsFinDwaz9or3SYuPh6VaCoFgbQqZFQpG0OQchtEsHiv7k1BQ9qQN1aHJ3OJxpKSVypq2hCkZBTj5RFQkv5Z9fOTlOxFpyJWW4F4yHyvLzBmkcBF2TfY/Xjjo2Aj9SZkHIuV5c0OFVOPb0Dvh0m/C6ZHAsY7nbE8wi4yE0C+ypsYvSIHOjhHwW30TafxtQbr6mwtpp5+hz7yd+KfOeNE30BvwpMcroM4Ln0Vgtkw3fw0sUZzquDq9E0wgqwj8uNEY4QrLcicgnmy9tLOPKwIRht/8OIuvJW3yJakLVN1jke7t2F79Vsoh9/dgyI+qRWVQcrErB/B1kgWkA83uiNZLrR7ZIKDzWsF9ZH054It/FqxPgF9dYrqRkJ3kBZjohxWLejRORB3InnGhHaXhHvPJTKOn+Q1mENyldALp4iWdssWWINfoc6x3EnO8mNeUqcfJCllQYOcO0fFujlgcBXbNyZvC8lU2XopTg8tW6mlLsiocv3L0QqClXD/KUt8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MRi2kp2m9ZOkOk7H/7Mt/lnjjEsm0m+Tc4gXlELcCCSdW5TxJ7LT9hBFRWVIzB4D1KfSW3cNonz+wCMI5vZls8PNvFV9lSxBhZYON2u4AiL/M1djKd1bnMrGkbqpajqIXJ5raGiax74Qy/nVKo2WFXrAt2OUGa8SWd0+haM97oHOKmtSEAlrDDoro/N8+578od/vUqCUnjO8wXl11p3009hy6M6Nv0hnYwIW3eyhIlCmsgr5VePNnAJRmvTYhZo1vK0MdhE6kxRI9PsBNdHYNqiBvFVuFx4WQR4v+fTx8Hx6ruIVqf9SfKntuVV9ugsohOciJCgolkP/sem7p+hyLBPs/+K2A2DTdQ5i92DItQ4YPtMKihGiQPi85HST402GRhV86L/FILXCy94Ac472Lf3FI/+RG3L0ks+5FeuyawRycHyisj1rp3Dvkso0fKkh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 07:59:06.5438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a2042c-70eb-4e2c-9a22-08df187f605f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903
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

From: Alex Deucher <alexander.deucher@amd.com>

Query the status of the user queue, currently whether
the queue is hung and whether or not VRAM is lost.

v2: Misc cleanups

Reviewed-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75d5ceaa53c6..b3287368e577 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -692,6 +692,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 	queue->xcp_id = (fpriv->xcp_id != AMDGPU_XCP_NO_PARTITION) ?
 				fpriv->xcp_id : 0;
 	queue->userq_mgr = uq_mgr;
@@ -812,6 +813,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+	amdgpu_userq_put(queue);
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -933,6 +962,12 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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

