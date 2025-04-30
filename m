Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B20C3ABA9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 15:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0306C10E7EE;
	Wed, 30 Apr 2025 15:48:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cZKmczTN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671C810E312
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 15:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=coGeCLsv8U+P2c+TZSNgIY62MU/emrk7BYIbX4rfmabKww5iBkJPP+6mkJxlnDQSx1gh76Owe+AOFdVKb6HCpk9MZGIRptfdRsogVyq0/YMKEvjTebV9ICU8EcbXyMaGC65RpsYQIDXjw5eCwS27wimiajtg58bCltQ/7LQBMWs/s0/lMgx1GEiftK/ouGRAWX5IpH44ogPU0LU5G17BgIP4wqpdA3RotglncsJ7f7tDWtNl4/Jp/0gqRYYt4EyICsxvxA0EeMRtIk7QG9jlb1y7MX9TclCWcv1k2QS5W0cxtmpun4MYffT21VZ1PRC88YQrQSWFClOALiCHU9iLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VSkL6PPyzN66TG/uQOBUcxC1WyJMe8k+fJLUHSNdt4=;
 b=Vp9fclJZG9NunT1tMSoKaHZoh+JQ7iRcfnJtcCJavltbtHyX51McFBSD+SluJ2m3LA6mCQGwlIjYEu6KbTqWoMD3cRHA7lhKbuflLG+SzW6gQqd72+VBYqNuYTKz4xq/zBYmC+2pRoBN/DJWjPvJXagu6JMiEUby3qILcmtYfd6bsqX0xy/kPCdfxsxHwJ3BIKNMdTgAysD0kjKTYKZOdxMtCELiDLGBqqyDWLMiJq7iTvIsJMCZHrpm2q4kFmESk630bdZZihww7RE+Jlv/sXTb5oT+eZWWlYPxrWbExL4bnchSrX2k57EKnNGF0bT+tWKVefokUfwN88PPy2jpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VSkL6PPyzN66TG/uQOBUcxC1WyJMe8k+fJLUHSNdt4=;
 b=cZKmczTNp0HnxKnohXrQMnWzdrRRe4B+XERvzGUWBi1DHgFhaMxIJyP5jHXHZBiML7LVqBlVU1CFUkZ3oPd3pXyArsE4solGPA+Io29Do/IBgKf3HUa57s72w2/Ip0iFzEMocGvqkm2oQ/5nsanlduoszPtc4v0a6im7SB0sXU0=
Received: from MN2PR20CA0036.namprd20.prod.outlook.com (2603:10b6:208:e8::49)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 15:48:27 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::b3) by MN2PR20CA0036.outlook.office365.com
 (2603:10b6:208:e8::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Wed,
 30 Apr 2025 15:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 15:48:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 10:48:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/userq: implement support for query status
Date: Wed, 30 Apr 2025 11:48:09 -0400
Message-ID: <20250430154809.2665473-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430154809.2665473-1-alexander.deucher@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: b36f34f9-6bd8-454c-4610-08dd87fe72cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2rB5BhgGtbcyzc0x/zIm3eJOWwAmYueXT2RJXcIiAzUE7ac4iY7x9KwJ59UR?=
 =?us-ascii?Q?IucDDDNMsTFZVP2xii/AFj3FVpzs9dMcTPq45qaPlnDzmepLSNivkZqGpLf3?=
 =?us-ascii?Q?6g1QLKwjR4nnTSAlQtG7BMel3wi30wtnW9ABtrvKKU6MW3z2rQ0cD7wwXc2Z?=
 =?us-ascii?Q?40Pbri+XvPrJ2/DtR8hdIQ1ypHwFRhA5RizCgTAQ/YCnJ3RhGjMkBd+iYb+1?=
 =?us-ascii?Q?Ghu4iGS/YuLy5YvES4yI8Y1sGMDLH4KwNjH93elm2p2Jl9uVH9X+BY7E7b9v?=
 =?us-ascii?Q?EJx7wCjAX1HQx1FD+X3n9LKyYxocQK0EovM9eO9fd97SeCW2sUIHL7XUNFEJ?=
 =?us-ascii?Q?QjMkbXCfB4AMC7+XM9HhoXbIavOeNJOutFQTDR9Hura5h9a/pXjP5B7AT6MN?=
 =?us-ascii?Q?eKEKf26JaP+nlSOma3FdB5toxj/wHlG1N5K8BGEJ7a3uWLMlGRbGTZkZ/RIM?=
 =?us-ascii?Q?TiJDqKJklggGQTtiMFX6j4ogpT+q6d0HNrS/OVsDu7OGqDgAgwkYVyncBMZa?=
 =?us-ascii?Q?nZ9TZFJmPmnoK9O9sSIMRry7pufRa1oF/OwTibk7Q+kTKnqfjfPypKGs+0z3?=
 =?us-ascii?Q?xdCYGpe2mmmNvjEL/M7Qoc7FZWcX4Q589Suq88BCYlbkN69y4WrM/uTmXBm9?=
 =?us-ascii?Q?7gMdZNdiWZYzUd1M5mFpXDLoskBflYGCNwqvH2hxSpR2zYvmvP3t8f0ZG92f?=
 =?us-ascii?Q?QOei6GK/731x1uGS3Fd8CpeTmYsU45l9Gt7bCLASCs1hdbLFSdS/5oHw5p5W?=
 =?us-ascii?Q?KeX5k5fzyDMaHjIjxaWveFnvScOf2kdzprdM2xWCd8xLPCqsSjvdQqiXZtSo?=
 =?us-ascii?Q?oQwHZ+SLDKu1+P7eZm1AQpzSMf1O2CKhp4C/ZiDqp2wUCkqyJPFSSZFZTpIh?=
 =?us-ascii?Q?0VlBidD9M7zn9pnP7hQJJiZxfYfSEooEPfiyVUZm/AmRvW266WmJMciJr1y3?=
 =?us-ascii?Q?G53zbUVG7mQM88zJZIbiWAfLx7M+PV7AJyURKI9AJaMDA5pwrr9Xaz4PIlZ2?=
 =?us-ascii?Q?xz7lfeJ1zdZQUypBqtoLXfb9sbE6bhe4otEpO3A9vpiokV6+LQiHcHtoU2aB?=
 =?us-ascii?Q?lKLZ2j6XqctEBlpfyzJYNslYm4Pko6GBNc3iEIBZnTvQs8wTzQgGmIEcyDm3?=
 =?us-ascii?Q?KOD9SZMfpdKJkEM9qOM1U/qOfLp6f/tp3gUXKF7XSKIoCJJlM0e0umCKCFiJ?=
 =?us-ascii?Q?Wige7WOjSxHMpAYbT6hxyUAmEGgGwdxOe4fqxH4nOKT8khuoN08sGOWFSReC?=
 =?us-ascii?Q?Al6z/ifnij90bhqYpwzl03WSbEfnCd1p+MNU/xFIGzEeEI467uO4bO03rRPV?=
 =?us-ascii?Q?BTNs7iLfa65dDxpK0A3QJwBzO9V3lmvFSM6OUafUWyD5jZGsloDA/dWTlbu6?=
 =?us-ascii?Q?59k8ueu+PUpvqWYxbxYSY/8/d/pbxh1XifN1Re/XuhIE/D3XL/SHuuSLb3Tk?=
 =?us-ascii?Q?j8FJmr4KA28vqey9ucNhz97V6PpwDHi5VHYOzpUAaB3tAGUemBio9mZg2OZ5?=
 =?us-ascii?Q?oFT9j2wuZYfgjKdTLr3CWwdAL7r/dz3PfcjD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:48:27.3537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36f34f9-6bd8-454c-4610-08dd87fe72cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 47 ++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4be46fa76ceba..e56fae10400db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -460,6 +460,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -532,6 +533,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+		dev_err(adev->dev, "Invalid queue id to query\n");
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
@@ -565,7 +594,23 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			DRM_ERROR("Failed to destroy usermode queue\n");
 		break;
-
+	case AMDGPU_USERQ_OP_QUERY_STATUS:
+		if (args->in.ip_type ||
+		    args->in.doorbell_handle ||
+		    args->in.doorbell_offset ||
+		    args->in.flags ||
+		    args->in.queue_va ||
+		    args->in.queue_size ||
+		    args->in.rptr_va ||
+		    args->in.wptr_va ||
+		    args->in.wptr_va ||
+		    args->in.mqd ||
+		    args->in.mqd_size)
+			return -EINVAL;
+		r = amdgpu_userq_query_status(filp, args);
+		if (r)
+			DRM_ERROR("Failed to query usermode queue status\n");
+		break;
 	default:
 		DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n", args->in.op);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 6ede08dd821d2..35a08ee59d893 100644
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

