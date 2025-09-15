Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A4ACAC598
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 10:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E337E10E445;
	Mon, 15 Sep 2025 10:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dWrU8JwQ";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708E410E445
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 10:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnRSA92yqXFD94feedEm/kJE9AOKIzi9FzCzcFao9k7Tlc4X7jBiDCPA56SY9xBu2CZWaV2T5DW25bq9xX0LkTNzShxMs+Wf81T5Sb3vD8m+NDdLoR/Tbv6Qlw3DcohHTMFugfrLnFFrPGT2pdWMut+0Eh511Y1z1BOT5HzvqZeRsIYDr2p196cC219edHOt5Qff1aFUPLov8aisoft/9BGNnoRQD42F1bQ5RmvHObp+m9ctbKDIE5inzE2WkBVpiIPPYtygmpjOM7EsdWTKw2RQ3fZaMZNpqdwGfdfskDacACb4CQbOt2StkjKpg0Ffwb0eGNgoLmEv0UPVKoN0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79qGz/FADukULgvTdk8a0mhLaO8qwVx/ROftqD02+iQ=;
 b=Wlc4W9kc2hhLpYrGFhvKkiUPsJiZEc/s6WAz5FW+ZWIVufU41R5IUbB0CeLAZ75ZFBaKO+kC8ZwNjfOuwpE7B8mMGEZAxg2KD89+TDSegVT/NU6XI8WOGDm90UeOsIeCPT8L8N+bLIY1kkO3OL1FApE8wM6XYzqw2lCiSEDZm9fPAWliGFup13m+3bq4osKdbbCz+MYuISRZoiMMex2/hwA3dqzq+Qj34zmLk4/AjzsXeAe2+wCInCeMYirtWPxMqVFnBo3KsLpsz5+WDBKeZrqMd6i+PeEQPVJXEdxZRkFYBHfSfHnjtk42+SqIxK/PYh5mtBJJQ3ERB2smPTeBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79qGz/FADukULgvTdk8a0mhLaO8qwVx/ROftqD02+iQ=;
 b=dWrU8JwQHtRudzfO18RiP7Vb0nY1aO5Ju2NHYcHyfwkqsacgpeeL+17yuCvbQW3lfdGElh6AA5LjPEqm6645+imkHVBcqrIf+77D9pW8cQYAAPzpB7UUhFip5Kwnz5JhtzAumDJFE8sr+cCWLhJpPb00zvyZ+4vRHD/O3oNJxcE=
Received: from BN8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:408:c0::28)
 by CH1PPF351A22FF6.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 15 Sep
 2025 10:42:24 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:c0:cafe::a6) by BN8PR15CA0015.outlook.office365.com
 (2603:10b6:408:c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 10:42:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 10:42:24 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 03:42:23 -0700
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/userq: Rename waitq_id to queue_id in wait
 ioctl
Date: Mon, 15 Sep 2025 12:41:48 +0200
Message-ID: <20250915104146.11185-4-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915104146.11185-2-david.rosca@amd.com>
References: <20250915104146.11185-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH1PPF351A22FF6:EE_
X-MS-Office365-Filtering-Correlation-Id: 74daed20-2d5d-46af-a09c-08ddf4448e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NJqH9XGDVor6wVhsDeN68dGVtGHCKM+bH6Xo7gkNytWMtam9hE0YAkpsqivM?=
 =?us-ascii?Q?WtFT23fpwrVHgq19NejOfUrIaKytK0CK9xZp4MLwXo0bqqL4I8VktCodAdgE?=
 =?us-ascii?Q?V1ClWEvMOLE8Cq87YXTvS/OTw4Fb3le4pVYV574wzV4L+jrsu+2bkQ6kx3mG?=
 =?us-ascii?Q?F1sN5X+aP+N1sYFuhoGM6LlIEvX4Yu6tlhRmYtk2vON5uHhw7lc+bcbZqO5P?=
 =?us-ascii?Q?hbqbPXWS80SCtpCmH/ATQR5hU9UR4fKdD2xidJS6IRbUzim50Z3ZbX5i0R3I?=
 =?us-ascii?Q?Q6f4tgkMwsNBHkMvSjXkuygqAGrJpS/xnUWZeh+fmZbf87nb85KxnyQQBEQY?=
 =?us-ascii?Q?LsKqM1RJwoScFu2K/5YetBaJ6Ql5ZZE6PF1WP0gL2zTvCbqgChLfXz/zlDG4?=
 =?us-ascii?Q?ODjvM5wavJG850w5B2e06oHaIqUGGvm7OV+6ETczPtV/ZCzD0QEOwtlkRaYb?=
 =?us-ascii?Q?Jl7ds8vI5GIhplDPyAEWLjNYkXh8i/aqUbGM4Xu5Co7NmxEkFC89vEyUlmOy?=
 =?us-ascii?Q?D7TTZdTMMdh0X06Swu6GlUxmkzrPhokxdQEAnSo8q8y52E6Qfkzx6E+VEjuM?=
 =?us-ascii?Q?KTgZGeusbIS2ZMceYTb/I9gzbte86bDS9q6LfS+Xh9hCDNehCg/UDRjA7GQc?=
 =?us-ascii?Q?jtggz87n5T6s5cHpX3oci/xcb+u7i1jR1bIZvIJZV0HAkFEH8l/gOOvGtBYV?=
 =?us-ascii?Q?EQvuKeQF3zO5msCz2UsNT7oj+qwNNSS+VYo484/lsblAddwNgMhpiNQhu5/a?=
 =?us-ascii?Q?t9lSn0/msjSp45UCcWFyuH2dbz5jR6iz7FvJdKtqaDo8WovYE6FobX9ny1QC?=
 =?us-ascii?Q?Ve45ScHLXS4t47q97uki61Fs6FcZlCcpy0wUjwgl4AEqiFotyGUliF/Ky39E?=
 =?us-ascii?Q?/U6UAeLIMkxj8mNV1oP3P7Swt0of0DZqNUxjCn6Ng3y69k9oxqtRPXRrUAax?=
 =?us-ascii?Q?WMM6RlT7TXUwm9FBMVD3oAUllVAQ6RBEFNH1h8GcP3eRnHXGBMBA+FOoKRIT?=
 =?us-ascii?Q?ohWYYAJMRbLO1zBs81XX+1WPDiDxL+0AXRh1ykwLi7JT1Oq189blV+NAF2m5?=
 =?us-ascii?Q?wcMdtC9oq/E1F7rD3TVsVCWKHk9BksxrDf3tEHvGzqCXr6cvzNZaefE+7Reo?=
 =?us-ascii?Q?7RIL496AeRQHBXniXtiVQ3gVkdHJNZKjcJpGPyg4wMOm19fpdtA39y6YxFVw?=
 =?us-ascii?Q?ZhRoQBcMWBvlVD6ooiU+XnyCe8O2M4BzIvZJahZgM9kGl58o2Ultw1KB1o6w?=
 =?us-ascii?Q?TlAZQt5zxEmzgP9jp93LOVC9HH1hHDiZEQIo4zeeFKR758+HqX2LRvDfIClr?=
 =?us-ascii?Q?vzZzcZXTibmv2yHEqI4PgS9PBeVMiBH9t8nXDGcvML6IYDx1LmBP7wwyH9V+?=
 =?us-ascii?Q?PZvCBLxLAZ7DBg6qvzqxR0PGlkOpx/HdstPmVeCZuDyc0cPhY4j/z+lOxFRp?=
 =?us-ascii?Q?X9R9uiXG3I8yRcArlM4W50/COVz2Vo8zmqE8XDtke6B6vzUmC72EkI0ob/j5?=
 =?us-ascii?Q?uIKosdF2AZjSQyLsgzXmi3xL/DDnC0Ynzotj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:42:24.2326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74daed20-2d5d-46af-a09c-08ddf4448e88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF351A22FF6
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

To make it consistent with signal ioctl.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 8 ++++----
 include/uapi/drm/amdgpu_drm.h                   | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 5b2cdc49a28c..a9d51b38b7d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -674,7 +674,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	struct drm_amdgpu_userq_wait *wait_info = data;
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
-	struct amdgpu_usermode_queue *waitq;
+	struct amdgpu_usermode_queue *queue;
 	struct drm_gem_object **gobj_write;
 	struct drm_gem_object **gobj_read;
 	struct dma_fence **fences = NULL;
@@ -930,8 +930,8 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		 */
 		num_fences = dma_fence_dedup_array(fences, num_fences);
 
-		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
-		if (!waitq) {
+		queue = idr_find(&userq_mgr->userq_idr, wait_info->queue_id);
+		if (!queue) {
 			r = -EINVAL;
 			goto free_fences;
 		}
@@ -964,7 +964,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			 * Otherwise, we would gather those references until we don't
 			 * have any more space left and crash.
 			 */
-			r = xa_alloc(&waitq->fence_drv_xa, &index, fence_drv,
+			r = xa_alloc(&queue->fence_drv_xa, &index, fence_drv,
 				     xa_limit_32b, GFP_KERNEL);
 			if (r)
 				goto free_fences;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 197ea3bfb559..6d4bf401f783 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -530,7 +530,7 @@ struct drm_amdgpu_userq_wait {
 	 * @waitq_id: Queue handle used by the userq wait IOCTL to retrieve the
 	 * wait queue and maintain the fence driver references in it.
 	 */
-	__u32	waitq_id;
+	__u32	queue_id;
 	__u32	pad;
 	/**
 	 * @syncobj_handles: The list of syncobj handles submitted by the user queue
-- 
2.43.0

