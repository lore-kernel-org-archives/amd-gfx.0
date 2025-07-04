Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245CEC83F03
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 10:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB30910E9EC;
	Fri,  4 Jul 2025 10:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GLtAvbIn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B11F10E9EC
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 10:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4CaqJp/06Lt21n2wqfPhkgh3P6vc2pRj92F0Nq70YQGUfxxlkWYKb+8Ls+rhGAtODFJCxxfpEHZPyIA2ViT1hQ1LZGgv7Nsi6Ydqm94+Sz8LgP1zQp9nor091qtjlrx8LaVBj2LvBx4SkPAjUvn4yZswiq96ASKutf8FJQv3Yi+sBSgw9hT2uRwoRuYLj8liPWinLlVPCOTn5R69Nvsy8WEMiAT8s5jN0BqBdkhE4Nl7S/Yih/KiijEMw5MbzGTLzNXAAkcwEg24WeXRXAtxCLKMgnZfC7prWWSjUxiU+JP2NZsUiI8Eah78QemFahBimR4khmkRYXVbkaqVvnnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=VimEmWDnQTFtRh0bDjWIXnqIYHnEMZzZXcgpzJqFjsBZrqgc9f+uXtYg5r28OL+n1LN4ocvhB4gR6Li5T00ItcbjQZAePQ0ROijzTPckVEYKRRdh/ie2OfJgNDlAuroudk5p6DvPd09KtXcc3/LmMnrH5v91dmZbQuvgY/JzXrAWXbe09YhioBjOqWorNXsdE6nIWaGJvtDEH0h66GfVb0pee2yeoLfSriHvOmg4ujse/JHBxlAKtoRyIdKG8KuitHvUoK+oy7bR3ieNB6HE2zQ2Soe6fnS790wMw0DD9wpsygxeT63LYKKpYGB3A+IXLO4IPp+KMxBlE34CEYknzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=GLtAvbIn7jgdXqLgaT3ar6ZBhHpFPvED7rZEVvnRZR4UjUy+34GtXJMkswk7PpJDtw533s2Kwdu5TRbMHFMICeGd58bxfXJ+48ghDxR7n1mocxzXVYecVBkM2doXJJ9kcU/SfN3d0zrH/Q75MLNh3rjE71l2D7rgryUVS3XHkYU=
Received: from MW4PR04CA0119.namprd04.prod.outlook.com (2603:10b6:303:83::34)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 10:33:20 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::db) by MW4PR04CA0119.outlook.office365.com
 (2603:10b6:303:83::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Fri,
 4 Jul 2025 10:33:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 10:33:19 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:33:17 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v5 1/9] drm/amdgpu: validate userq input args
Date: Fri, 4 Jul 2025 18:33:00 +0800
Message-ID: <20250704103308.1325059-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|MW3PR12MB4475:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e75241-6b6b-440a-5014-08ddbae631e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O09wnf/CBUSFl2zTtQUE/sfCnTy8ZInsyQFomsvePUjEHajwzGta26FAJhxt?=
 =?us-ascii?Q?aHMDT6lM6GY5A6TjbCOMVM27zGB+xNkxkmaxDEdNExYD60Kq2Xp42SiuPojw?=
 =?us-ascii?Q?t2f/7eAb6Ezo0IZlCpJ5LJmxYyXVMbnZDt5xV7zLEDcjREwZBO/PShI9yYWt?=
 =?us-ascii?Q?3oxAQYQuiTChyuFWMbpX/od9TjlO3pYseZQNvZXDPo4vSAmmbbdSspT1UR38?=
 =?us-ascii?Q?OjX/YirfEfcHTKSget+6+QppFe2WgPlJ2OE/nTqkNwoq4utNz32ZWgCKDkp9?=
 =?us-ascii?Q?OS/vnEbzguvH5wV7xD/YOtU5rclmqleIq7RNT5ctGiNypdamq5jTYezQNhM7?=
 =?us-ascii?Q?R5/SOr2ZeRwstDUUUQ+qhYFmDfxPLvXuFcqPccSPKKZInAanl0k0phq+o2RS?=
 =?us-ascii?Q?EBuZ4m/OrWs4EPX05rK+Vcnn0r1u044Ei7rC8fbuqhf1LnEDTq6+KmoWurIv?=
 =?us-ascii?Q?RLI6rsiXalx0lKwvo06Ka+RYq7p1NJvwpVcaylZypQhUk6F2kQndSeZuBzYl?=
 =?us-ascii?Q?1TAw89kE/57u7lDpcJgCvRQBbTdlxZwLKjlLwFHqHGXExME5yLiMGTW5EREJ?=
 =?us-ascii?Q?wmFrq+fHDHhbqy/39Uc0MTuB24FGewqmCh7xfWveUkm1QwyjovL2HcWsVCBp?=
 =?us-ascii?Q?wcuqMMthRLsXwzmhkwNSU5+we2MDzTXYtNEcyUR6zOyFrTt88EoAe7H7Zhqf?=
 =?us-ascii?Q?6uGsvLk/qcPuRWATGypEjPw0axhKRY/1qX+E5KnEE+0KPKzIlixCsMH8Ultf?=
 =?us-ascii?Q?LKxFFmMjgIF/Ca9vVAVk10sVjGO7zb/EECCAgpbAvsNgT8nn5eUTsXL2+/ow?=
 =?us-ascii?Q?DDkwYJDAz24RrjxkrOOnFgcBC5OL4okdHpfrkJUmAU2twvqC974SZgeCpreg?=
 =?us-ascii?Q?fcestQgtDZjwhyc5kP1GBJDtoaAja33udN5TmUk+8D4ef3w2h5Y8+vvMKJmL?=
 =?us-ascii?Q?mJeNXLDrsLJYxmqoIFPd2XIH/wA++mPevFTI1FKcxluaiCCbkCW3qRO4nEbl?=
 =?us-ascii?Q?Gk9w6kI5FKz6k8N5tkLhUPwKv957XEKgnk8MC1Uog29sYIX00FYCXCvtQbjo?=
 =?us-ascii?Q?R1ZkmY9Fb1mCYTJsaFFvxfa/NaORgzAEvngSwDnLwEvU8QD9ZLJhsvrw8tuV?=
 =?us-ascii?Q?l2hs72K5JmCILhVNSFQyb5Ku4eWEie2XMiY/YgFD7/iwnZdoa+XMna6kMQir?=
 =?us-ascii?Q?pD/wftTL1dxwlVYJRbW33hcydYPaK3LAmhqXhdJcyFCqpfc1a2pGSPd+Ihdf?=
 =?us-ascii?Q?sFJS7ahXeQVOpesBfaXmz2rcARd1eB95zeZ4lX/N8v6Jk7h7hAZ87ClIiE6F?=
 =?us-ascii?Q?l3CdlEh4b4UK9iXE71xO3KserGtPyRg2x+J79ZHmO2V++H+8qWo+Dg1oUfWm?=
 =?us-ascii?Q?cxd071LmT97qg7VHKLsUP4BOGSRfqFpVzKDEBrL3p/mVKDp+8cZj+dY7oDF+?=
 =?us-ascii?Q?2Rljfcg4rdcMC1dsNuh4Ln9pJZJt4G/s8CXASUZyltEkvBfb0fpszFiOoGmo?=
 =?us-ascii?Q?rTUru0ZOu8Wy3QPvB2jKPkdhAeOnw91G2Iji?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:33:19.7745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e75241-6b6b-440a-5014-08ddbae631e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
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
rejecting for the invalid userq request at the IOCTLs
first place.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 81 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 --
 2 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 295e7186e156..7f9dfeae4322 100644
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
@@ -485,22 +468,45 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
+		    args->in.queue_va == 0 ||
+		    args->in.queue_size == 0) {
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
@@ -514,6 +520,31 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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

