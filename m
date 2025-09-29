Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E7CCA468
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Sep 2025 08:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3C610E3BB;
	Mon, 29 Sep 2025 08:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UsyMh2nM";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2103F10E3BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Sep 2025 08:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IgXISBK0hihFqFwjlR8XsSH6aMwNwCGTawxbyGBEKtGKUwvqhdAvS11OgDHZaEmrM3FcxYF354qguYR1TiWdegE+SMCONSkAQU48cQ2pc2N/RrSLHFzTAWWx3ZIscrdsET4O/VgY0SIKXz7v5VLv1fb2mvCSNmTusaug7l+6EyT1R805ph6IWkG5yZvHa27k1vVHM6w8MSF3XkMLAc8bdSk9j/yLCJ2slwN9ji76e4Px7F5U1owJxmgzWJhqan2QhgtvnpBP7E473/LGo1ab8ejwzz2iI9WhgeJblLq8wOnLOWVWV42Pn8gTVWE1V3UV0X40a/kvBjU4/wS+TeSlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoHK+LH/+4/c/lLKXUwlMOPpftW4GYZZHf/K/sERPoM=;
 b=d8aMHYIvT3W2efcwqbLbLNzeW3es3bZrhsrorypMSDBCAMkMksaqPftYZJuijs3ngeahgiIX1fZGD8glKjJki4E59VIYzejNhNKnDH15Q1FMP5r4XNYj0wiDeHJ8CMdgjW5ELgflQhdHYDfiq8lf6oYFRyUF/h+uDDtvqWns4sz7fr+mzcS+chDRI7y1JFvA920y/CbG9dhHdw+fkNlub6CdZ1HR71fTxngkW5SBnK1YnEddNzmKP8clDbKe+1DXCllWsaIfdrxf7U3QTFrsmE6dmoIHV2xHQyC+6Ah0Mhak3dflVf5Oeq4W5ggkyM4tE3hE+3C5TEi1JEZIv01Jng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoHK+LH/+4/c/lLKXUwlMOPpftW4GYZZHf/K/sERPoM=;
 b=UsyMh2nMunGWukThHSGb/jKv+1StrMjjy5dj9t9mHawnmQcDpQbOJ8mwemNaKJvu/9MRNGpiXzwlrcKitzDzUgToYE17WoxxVl76UDgnly+JheQUiUF1mDi6zLYtTP3uxo0sIv6V3OPViRBimjUSddkJVrd0AoaVWYvCccmgiio=
Received: from BYAPR01CA0052.prod.exchangelabs.com (2603:10b6:a03:94::29) by
 PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 08:10:11 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::7c) by BYAPR01CA0052.outlook.office365.com
 (2603:10b6:a03:94::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 08:09:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 08:10:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 01:10:08 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH v5 8/8] drm/amdgpu/userq: implement support for query status
Date: Mon, 29 Sep 2025 16:09:44 +0800
Message-ID: <20250929080944.2892809-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929080944.2892809-1-Prike.Liang@amd.com>
References: <20250929080944.2892809-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: e39b9a1f-17af-49b9-3634-08ddff2f9ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uHWStbgJaJhQV+HEZGP/GFxNHeD95HuaLkgw7ffni0StFV17k3Bm1C83KoJr?=
 =?us-ascii?Q?i/NGoHkgHGFcCjT5hxt4+vha1fK9dxPc9BHCvxnDbi3rtOf2js6kzj3Bte3y?=
 =?us-ascii?Q?bCwY2cFph49Qj2p38AHoC8NvFzD2UkoOm6hKgYZUv2AJCqxdSkOHxKMuR/In?=
 =?us-ascii?Q?esowbFEe+WfOMlAwaqgnDC4n9ecN97g2JP++fb4q8j5Y3cPZHwa/hx2vwwM7?=
 =?us-ascii?Q?iPdRvyIsS2qvFiJcJCjT+Ver0IAEGa9b5mPf+joNaOScEq8ihJFltDhsjQrp?=
 =?us-ascii?Q?r5Kz+JKCsAGy53dWHQ2HLsrJLZWo6vUsDULY06KvfvIKYMNKIgvTX2gY1qGO?=
 =?us-ascii?Q?c6JEEagi+mTYTc650lu1vGJYLBPFVLsckZIMhRIHcoD7kFVrOXeWwm3URDG1?=
 =?us-ascii?Q?Jhou6AHB2dw4jF5Z0TPjG7zpjUIeRYDR+4jSSxLfcFxVRylGG66+lox8uNBx?=
 =?us-ascii?Q?E1SR4O7X3Hrz4emyh3Mm0K5iyez5vCR+IWlsglLDSFIyJRa50uwLcv4yHJHz?=
 =?us-ascii?Q?l6rLY6miHe9K6Vww6CPgpgqQfWDIIEoMNCTgEXAQXLfotVaaHu0pn5YFIMWR?=
 =?us-ascii?Q?m43qP0Dd18NzXtQAk9WS2pM8gGslqAUbPCRFE8+FpJhjwfU5GeZgFfIJiJD3?=
 =?us-ascii?Q?AFmY8VtpYn/ZTgKfqFkDLTJbzZ90MXBXUaghFLcXvkqtLPcysnaghm+zZwNf?=
 =?us-ascii?Q?PdIgKtlS1+8gmwiCf1zZZUSRxEyJw4xpl3bVMhFLqS+ShhAQkSKxBYDjD2E2?=
 =?us-ascii?Q?FkWXzFuZF+Z6Je6h6JWDpP+WODwmREApO4m7R6tE9+FVdUEepQAGAoLlSRZq?=
 =?us-ascii?Q?inuqBr0TKYpv534wiAb6WCBm+zzW81TtnultVoxRHEChoUh26AGdJOGFsYCZ?=
 =?us-ascii?Q?p4wcE/C/NLL6C9P1OE8YlJ6kGGTchkfuSHXAjpPT7lGgd3TQQjfRfEJBdECT?=
 =?us-ascii?Q?BUg5Pyyb+a+Tw10LcCQR8ZsgoQSUAnGZ1o7Lc7H04RMs5zVN8S4FQtMgCDpp?=
 =?us-ascii?Q?b9t9UGKlC3RILMS59aP2r98SkeX+6xtLeuRtvEs3tx8OmUBlSMSEarFLivo3?=
 =?us-ascii?Q?NtWguAzlMri1FDUWa+C6gmJSJpXRqV9S8TnqI1D1OnoR5xHfb/YYSSZ12Igo?=
 =?us-ascii?Q?+OkUoP7+5wplefRjUG54bpkQmRorhGNoAxRdO5/VBPnnSSrNeM/8OHH4sr8+?=
 =?us-ascii?Q?22YpujPLlP3Ph+3pQYET9fD3bbcO8X8KpVx8JkKPNrkO9eYoIBw9aCQKuw+A?=
 =?us-ascii?Q?krUWN6u2Un+ps8rMeL41i/UQh2O7x/j6u6FLJ2bKK/JxBnequ/963uVlAp9z?=
 =?us-ascii?Q?v/sniLwgumGoqM5jK84SMk3mFWJqG/X3jBlZBPUS6aPp9YIjEaMGUF0i/Cz6?=
 =?us-ascii?Q?ajBFuwN0zmxR0zWKf9/uZbCzXtQx//kdb7TjN3/SQB0DRfBfYiEommidaOXJ?=
 =?us-ascii?Q?SwdHLEpb4yzyYT8WhKIGm9lFvA5KhQ29cpTKkBuGSyOnYwiU96VlHilbXLAo?=
 =?us-ascii?Q?FMVWQs4bAX8kWKElSixX+I1fdBmo5qU5aZJKxN4p3qdyhNiUeKtHHc7pWe4v?=
 =?us-ascii?Q?msGGog91EP23OH1D3SY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 08:10:11.6349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e39b9a1f-17af-49b9-3634-08ddff2f9ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 include/uapi/drm/amdgpu_drm.h             |  2 ++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index d7cda252cae9..f477e2270724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -610,6 +610,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -699,6 +700,36 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+	queue = amdgpu_userq_find(uq_mgr, queue_id);
+	if (!queue) {
+		dev_dbg(adev->dev, "Invalid queue id to query\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+	args->out_qs.flags = 0;
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG;
+	if (queue->generation != amdgpu_vm_generation(adev, &fpriv->vm))
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST;
+
+	if (queue->state == AMDGPU_USERQ_STATE_INVALID_VA)
+		args->out_qs.flags |= AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA;
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -779,7 +810,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			drm_file_err(filp, "Failed to destroy usermode queue\n");
 		break;
-
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			drm_file_err(filp, "Failed to query usermode queue status\n");
+		break;
 	default:
 		drm_dbg_driver(dev, "Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 7bbbb5988fc7..e0ca466681f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -74,6 +74,7 @@ struct amdgpu_usermode_queue {
 	struct dentry		*debugfs_queue;
 
 	struct list_head	userq_va_list;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 871e0f56d61e..100ccee37d5c 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -352,6 +352,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 
 /*
  * This structure is a container to pass input configuration
-- 
2.34.1

