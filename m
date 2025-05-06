Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D7CC3ABBE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 15:59:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD8410E6FA;
	Tue,  6 May 2025 15:59:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="it7D703q";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D89F10E6F6
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 15:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcGN05pk82GA6Uefx/3FJ28KsLDFuhjh9cUXHxRZpS3g6WcP1hlzUROO45NsBZHtHHcXvTo7byx+Mbq+/vZkMKxrhFZM7cvxN0Cx2NIsoRYDf+Iyxhgywdilln5kMWa3lOKtie+d6+3QI5bo7odIg82NVk2ut8Uc+6pCrAqFiXMLZctJUnyHAJ7YgmoRACi/SBdY3GkfpC4kBGk9+hkxSApteUCYS2Dt5siFzDIkkSLE4rWXDbadO2J6n62h4d4koTLLcoaq6bqU+bJgjomEXXNmc8jdljoM3FNC9fDLanN7infu0JJd5uF+vzRBz521wjgEO+P+40jTRtkcxliCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz61Tk/71Y9s7u2/4UyZlB8foBnP1K+yF5/5x6itqaI=;
 b=WAlkyKTyVsSKZ/hmYkbxZfDDSHrRGLD5qrBVXkl1AqiaEzJZ6pYISjfgcaTYwnLorXhi54DE4wQQlICYDsDrzaaaru9hOJMgyK3ohZJfN/fK81qnaEkKvP4MPpVdTI5szDctmyOhHu02yxBVuNT9n84yqD+CgtmDNNMy0qnLlL8uDVTHG8aUX1uOyMzqbYJh6L0mit9DD+0FlZRs90z9TeMK1Mwh7+7QrdQlyCQIxs1Ucrlv0VEKH7I3GxnctyCjr9ld4ZCGuiNe8SRRrLGk2+BgVUxOyfD3dlY0rbz0+dCFoxRi2/nV93LpXenZA7X8NLAESiOCeoFvQGZ0LFQVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz61Tk/71Y9s7u2/4UyZlB8foBnP1K+yF5/5x6itqaI=;
 b=it7D703qg8C+kUUiNSZyXPUK2+vEuIBhGCtpOq44cIxOiSCZfmHE4+r4MtmxoEE1zQdRpH/ERIGPnNMm3NH5qlYagQuB0VGvxA0oNS9V8gluqEmQ62vXvq6TUw2OErISBUejJ/RTkbYe83mkUXpJmor0/svEiqUyjvMI3gQ4Nzw=
Received: from BN9PR03CA0220.namprd03.prod.outlook.com (2603:10b6:408:f8::15)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 15:59:19 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::ff) by BN9PR03CA0220.outlook.office365.com
 (2603:10b6:408:f8::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 15:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 15:59:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 10:59:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/userq: implement support for query status
Date: Tue, 6 May 2025 11:58:59 -0400
Message-ID: <20250506155900.3866874-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506155900.3866874-1-alexander.deucher@amd.com>
References: <20250506155900.3866874-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f54c5e-7c10-4a1b-59c0-08dd8cb6f5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aJd+tygaPHXRfqUZ6oaLE2Y+5ka8K9UIKQQBdrkwrIfX8mbVnfJtj/f6hwqN?=
 =?us-ascii?Q?Ix+ZEVEpTDP7CcRDZ8YjN80aVX3pSp0uXRLK6iBfGy3D9i8sQnoMNII4nXHH?=
 =?us-ascii?Q?NVmZ0U8cisZjWC6fNi5/zryLaBx1+W9TWmP2RLxW0HwX6tHg8AkOIBOMV3eE?=
 =?us-ascii?Q?dgyfmJjaIhQ+onrg08ZbWtl68CDavrkwKziCY0Gnt5GQL/k2q1G65+vpo6hA?=
 =?us-ascii?Q?5af2ObaFcTZsohbpoTuNEthZRt99CK35OmyvtXb89xNpjJxKkeU1t5X5nPko?=
 =?us-ascii?Q?sgYl2Q4ZGrvlgHDYMHNcrWAVyBbd9fWmD96dmKxSaOdzxinfhu7JpiWXnROU?=
 =?us-ascii?Q?PJY/9O2KRGRhXSVd/HVaOglwSdEdthKNYdBcyiWZ0ciaJnuNhEwLuNHXcmY5?=
 =?us-ascii?Q?drSaQQr35gKG9DNf0ncFnwylHJggcxg6SH2KApLqWR+kqKtij3AC25JPr9a8?=
 =?us-ascii?Q?VnlXwoBWDKam946oDcrdmXA1lkthkxhsidupq91jNJ2EQJmxHG3s/VXY4BI3?=
 =?us-ascii?Q?Mk21KSV1AbHYJ+qM6tiveJ6Fi//q2EzEWmVxhhLugRyeQUseNc+Rx2tkY+Fr?=
 =?us-ascii?Q?OoOXAK4qKfUJsBbh2x9dMcMLWVjIQ+qSB/Uq7L1PrN10YZdtFE68oN2W+/AH?=
 =?us-ascii?Q?cExx/0oXbi6ThEwTp55gGBIb65NfjC73Q04MN4g3YTtHccTUtcXsTTgh9m23?=
 =?us-ascii?Q?NB6JdOEf29Zcw/+8tfC97d55qemo9cEU6ZcxoiRNHSzSEgACiz1u+qswULVr?=
 =?us-ascii?Q?Uq2ssX1VgvLs+cTeTuWUx0XS4dC4pVhbVj0l3gBNppawGfeNEcE9oT7Vdg1I?=
 =?us-ascii?Q?Iw9940aO3K6to4lqj5bqqvbPLW3r7v5BIe9Kh8OuSUpk0iv4WiI/3k2+KEa2?=
 =?us-ascii?Q?FypWwe9+2lksQY6zDveOyPlQK+ReqJAbo1v611+qvvIbOEy8LGKelnAbxij4?=
 =?us-ascii?Q?Doeo5Y+x/IsbqFpzEjZMFnVP9MubrK5H841eb3vyXQPEkw+2kJPNnYLAB3sG?=
 =?us-ascii?Q?QouatTJ6sHjjTHdZr/PWewZUf56T2s9seXtV8pqGd4MfZ1OiSmgHJsUDE7e1?=
 =?us-ascii?Q?b6gKxCoYXJNBDp9t9VsSbREXbAz2w7mkvMMl+28OIWkF6ZI/9vytKsJR8Xt+?=
 =?us-ascii?Q?TOYXfiK+ukN1ukZzWg3Rxn1R2iDC0P22yfsgEpIDxgKQS/nI2CNybgI/+Ude?=
 =?us-ascii?Q?VIEwteQzn5sbEm+oe2evbt1yxcLat/Pgy+kInJptNQqeFBrDjNLM6zhjw+d4?=
 =?us-ascii?Q?bshR7/F20EE2OjG7dya8ShrsEQNJe3QHVS1LVaIbjVMHk/OxIqRt1ExmjXM1?=
 =?us-ascii?Q?cfOGyrrTY/51BVpkQ8lzc91PYvtGXAVgKFlMmekjUlVc4DeociW1AGsxkFPG?=
 =?us-ascii?Q?Joi2pUS7mKcpf3oUo24YsLcAUtK0Yd7ucyTttvFYdfsLEOzmXsBQhTtKPKvH?=
 =?us-ascii?Q?lQdgL1B0neuvFSuF+gXlXoBCwvuL8JkLWf21Iq8KIbIlhcccyG7xMQfcRf4Q?=
 =?us-ascii?Q?8yQsxzQBOySYwYmKhMBp3rt1Hcys3BPahntf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 15:59:19.1904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f54c5e-7c10-4a1b-59c0-08dd8cb6f5ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440
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

Query the status of the user queue, currently whether
the queue is hung and whether or not VRAM is lost.

v2: Misc cleanups

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e09d0e5b9762a..31d8c13cf0c7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -463,6 +463,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -535,6 +536,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+	mutex_unlock(&uq_mgr->userq_mutex);
+
+	return 0;
+}
+
 int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		       struct drm_file *filp)
 {
@@ -568,7 +597,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
index 9d62befcdb24f..cdc3dcc62dce1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -65,6 +65,7 @@ struct amdgpu_usermode_queue {
 	struct dma_fence	*last_fence;
 	u32			xcp_id;
 	int			priority;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.49.0

