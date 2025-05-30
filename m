Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA593C5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CE8710E823;
	Fri, 30 May 2025 09:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CbY8JC4L";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B2910E823
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iqk4pPd9cGxVY7kLa81WxlyWUTsY33XQZU8Q93e+fJAC31YyRe6rsRXEvJsh4UBufsTvsji44kb8mSfzdaLbA015anUF9L1wR3GaAd+zOmghiOEuZo+/FbI1fRZ5MMMQUDH15I6mAf/Vh71YMuW5tl9HGUCeB6B9ICzH7ieUTDWsZnkUC3K1NY7JD72dZH4kzCMU2lnWwYieUZV7tni2Ifm7jVHAidYdRPXmaVav/6QBRhreKvE4esQlxyutSLLEBGGrcOiQ38mMI5pcSQzeVqazVB0BfRiLi5VcmFoEC7ZK2jmlBT2OqHrDydJV242jhvqbO1ATYLNdOqcaTi+qXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFux9osS8Mdz9f9zGnI6SZSzdkeyfBe748rdPF0pMaQ=;
 b=SIZ8Up0YM9Yb1UJ5GDWLsP4TthmPE9HRe8PJEpzSs2/azLHJ71JEz0Gvg+xhpPmZ0yf7nCASQ4KTJm/+mPhFHVCn1Qpdy2BwFMTKnCnCbOh9iuGk7KyfC9KBk/Lt9aTy+JUTlh7Rbf/cbP3VO3qfD/5efJNPDmPx3lYmeIQwFiSAOrr0Vg8/yBHUczlKD/RDUjTnx3cx1J/2wHBPqFPI3TrAoDBHej2XfemFl6uSaDaZZj7Sw2kntp0Pc6pq2fASWjcQJYxzQMsD47hexu4A70gGIM5bNk6qflBN2V0FfYzy/9BTwFwitn378O97Q7pOjIL267pf0L9nIAqoMiBUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFux9osS8Mdz9f9zGnI6SZSzdkeyfBe748rdPF0pMaQ=;
 b=CbY8JC4LSP72KxJ8TRUMQfkcUsmL2VEGY0JMPFfMwbY2xAef1eWjiAoto3iyl+Bu0NqBCF4v+iZ2hmq4JEjBLFW2e3iYCQqv98uEYHu8E7xSbtJv/Cf/Qk6naGKfzx05GZaSarJJhep/+eI82JRHuVDGhuP3qNoIBQbcY7cN2/E=
Received: from CH0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:610:b1::21)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 09:04:11 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::4c) by CH0PR13CA0016.outlook.office365.com
 (2603:10b6:610:b1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Fri,
 30 May 2025 09:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:04:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:10 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:10 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:04:04 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 07/14] drm/amdgpu/userq: implement support for query status
Date: Fri, 30 May 2025 17:00:08 +0800
Message-ID: <20250530090322.3589364-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c98dca-24b6-4841-7142-08dd9f58f178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x24xKj1wnLB/0QzFD7pl1zZ4Fi2yRA1c/QMStSRVrgEKFqkiiVMzviIo+D8w?=
 =?us-ascii?Q?kTEEjQpX/Hmbq6IW8iISxBRYaHOPsrJyGmvmPbl2nMN+oby/ngF4+AlHEAxe?=
 =?us-ascii?Q?1wmUw1rF5WY4V1NsZm54mn/ZUEgqLSc2QG1o0rzaZKe72ik6qv8PkESqRrCP?=
 =?us-ascii?Q?8GTc2CLW+gm+UZuiPuLz9rL7uy5JEVg0Z/R628pEZjxw1yKQNra3wABK2hyy?=
 =?us-ascii?Q?6Ta3x0MZIIDTYm65HUV43OKRMd8CH5MLQL0VGu4QyHCnAJQw3w13H95T01p0?=
 =?us-ascii?Q?ElGoMgxdpzgWYfnhgG8F51jZJO9dJhZpPriyDQqfVCRVZg7WQaium81wr7p9?=
 =?us-ascii?Q?+sm1pxtqewpRYozFu10dxk495NA92gTPuTe6osLXXGxS/3XohOkThi8TF2si?=
 =?us-ascii?Q?TL35c11T2AiuCBkpN3v4tnCV+rwz9eKMvQouj3rq2tRrCSH60m/P4YlydzQ/?=
 =?us-ascii?Q?EBFONu8V2nNhATv5hqw7sszX/z7c48e9PPXKxw3tVeLMbpjaznNWYIfRNyI2?=
 =?us-ascii?Q?mWVzXqkB9MTXklHOnK1YLCK1ezELy22qShNjpTao9lHtHggVfzuYOwHctxiT?=
 =?us-ascii?Q?7KZkeLTniG/0rhPBucONHkj6FXF8RTqkdVcrn+bc9277T1GEkz7JBbMyb15+?=
 =?us-ascii?Q?wsN1mI9iHo/Hmmr4+A1DTTEZ2h/FkDTrdM/fF0Mn04MlkMg8lRP3crXl3+mE?=
 =?us-ascii?Q?dGGFEXwTj7XLZC9Olli9YvwU81k3FiH+iCghhM/1BlTHUdnFmYZNyoldsPb2?=
 =?us-ascii?Q?CYt3vt1XbHTcirdK8qudg/jpSa17mGfKrxvTTOh8G4B5L0SPqqvNthdh9Kjf?=
 =?us-ascii?Q?JfqKPfLmshqpem3ZSGJIYGL+lMuWwW8AHKJbS04kwr1HAKhleKEZxylSKXMt?=
 =?us-ascii?Q?Uzaswl/AN/B9i9vVQ+v93lIyJ/l8c/H7rrDwQHrlE1LKRCJweNPTUSqeNvSE?=
 =?us-ascii?Q?Xy9jlwnm+TRDz01zdD1Z8Mze0mDFmH2IOfLax5RfFba/l+R4o3T2hCC7pqHu?=
 =?us-ascii?Q?2jHdQutyjEJRXS98/EmNZKsDgjwtw4KRdB5tkOu363QlJ8X3HFRUKYU+hBqE?=
 =?us-ascii?Q?xPqbt/T/q3hI9+AX6rsBCKAYynkq8v4J3I/liq0hLNDVaa8nM2OC1PN6pQWE?=
 =?us-ascii?Q?qe5CvruEbcPyCTJ7c3ePsXaPPoIoIlE/9PsKcPLx2AVyCk8zwD0CfWBosY9/?=
 =?us-ascii?Q?kyRTGlnXLNioIodDYM47FgU7BWbnkEVGT1Ek/0h7TtbQ8aMpQHiyAHxl4DGW?=
 =?us-ascii?Q?czkS6KmDIscDzQsRijv+v/CYrp36373wFpkno2RnOgKxYEiJ0Y0FcWXqxhpx?=
 =?us-ascii?Q?q7werZWfAECB+4G/93t5+kSer6/BdEgAb9auwUJ2605o4A5p0vTGLdMolfH2?=
 =?us-ascii?Q?n9aeUn9vxPdR13Qiuyb8l7G4mcuP7KTIMnH6hhBaRigp8OuCnZ7u/QnBRKJM?=
 =?us-ascii?Q?/OSYAOAzwFjLk6BB0H60qv86yUM9oQQ75kdL1ZLDNnYnCbgexUvjzyzr5Dnv?=
 =?us-ascii?Q?mqKi88MmLusZXockf62mhdF45nvqFQ8xTaJT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:04:11.3060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c98dca-24b6-4841-7142-08dd9f58f178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047
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

Query the status of the user queue, currently whether the queue is hung and whether or not VRAM is lost.

v2: Misc cleanups

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 35 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index d4f807256383..b7b1c26067f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -469,6 +469,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -539,6 +540,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
@@ -572,7 +601,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
index 9d62befcdb24..cdc3dcc62dce 100644
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

