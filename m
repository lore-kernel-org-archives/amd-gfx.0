Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DD4C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88B410E9F4;
	Fri, 11 Jul 2025 09:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="paTJhBfl";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8720C10E9F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlyYTJMHkk0j6LPBxFY3uGvR5M1fNZD9OGZnPCCBcNv0ZamGajZnEpQ7Dbm3HlH6PHw94+uxYdGOMQVqHCCMyHgzC8out/b9RNPjIszouW9gpaLxD9GHkN/Z/SvNTgeeDTf2wDmhayiOXHHiiha+guBcH/ymmB9x7Bxaaa0wD5rAvfI5sKQuag7K1yw/VWjrvdPV9fFJuKIVyA9EkMVMxXZkc+A+SUzLkwrd946Z8gqTLiMmMa0vL4pc6QhSRC9rLGFmxainnWsmRYWvyYNcYkAsDDHjw59ZN4T8skf5Ejy6ZUzr2M+BfwvyZy0VDv4iP9JmugTAhVnWYRRS6W/+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=m5ZaUCtznMVkeheNWR4OO+iAjmYfiyeky8pnOR0YYnGq8bs69FiO+5mP0kwkH1MHIv4QiQSi+IomJdUCO84Pyb3jcp3fEzZtLHDgg7EDA3L2k7aWkqil2pF/XBI/7dlgPyg4LieVpXt/BxtrYg+5DaMYG6qXqNAj78YbQZKv37WdOP8BDbtvz1PC+bBkCs9LggUbkp68BjEsAHS1MiEp+F/VL0AbvxQEB3RANoRhmj1bu3oCh9J41bo6/hLTT+qWrqWrNbA/pZndGqs83r7KEgFvuXuRCNzYXiPuSdyp/suw3izw6xCfQLbUabbcJYPX7x4Bl107Eb+vziOaX8GiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbAVNy8JnxmnsBIpqIhoOAjedzgKOg+ic1N16XhiPl8=;
 b=paTJhBfl9YOaAifvoPnEyGZIEUDLy83fLOFMMBIDjDCYE44OtQAEMFjxhJdhWCarwoKzaSnZp+4I2bdJhORxq/rsRdh08Z04teiHb1vy0cX/BFb+Ddl8XP/V5O4xER8by6Q3wECKaaHwiMerPTaLL9nLVQJEZacCQuigQGfh+6M=
Received: from SJ0PR05CA0119.namprd05.prod.outlook.com (2603:10b6:a03:334::34)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Fri, 11 Jul
 2025 09:39:42 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::2c) by SJ0PR05CA0119.outlook.office365.com
 (2603:10b6:a03:334::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.6 via Frontend Transport; Fri,
 11 Jul 2025 09:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:39:41 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:39:39 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v6 01/11] drm/amdgpu: validate userq input args
Date: Fri, 11 Jul 2025 17:39:20 +0800
Message-ID: <20250711093930.1411470-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 24381cd5-7cdb-4b84-1b55-08ddc05edccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6FI90eC9LS00wv2WZSF1kmaaq2GhFjzKvvKB8/6DnbupTZ9Dtaf4npRXAVOB?=
 =?us-ascii?Q?9wtgISzHYXbWm9CV2zhbyljFsPc08xTphPBVzXzbg7zHvptDzceUwxKR0x1/?=
 =?us-ascii?Q?+acACxkqTOfEdS/MqH9FAe/QegRNNgIcLBVWF13RfkkcgO8rc5jMvrNp3dpc?=
 =?us-ascii?Q?aQIQcVH6dcb+gqVGA43cc67IPzljmIgKS2xgzXDYxJ2pCJbIXeDWq6dN49v/?=
 =?us-ascii?Q?YEro8d77SsT8mkPgxs1Ta5c/qFz8olNqxNISUol4oEtuWlcTv2cGhwywrt3i?=
 =?us-ascii?Q?sc+UgVkuMTZKMyVoDMUMCwb4WsHsOE2fnBKwq/FXwsjOWUV5CiWlInKwfSTu?=
 =?us-ascii?Q?awJUSCj9Dwa8129iGBfaGdyJ8+n0X7qy8vmaBl2i/HMPVQQ/aeioWFwmkm7O?=
 =?us-ascii?Q?gqwMvpbA1s/BKis+wTGsTcSCkNcJzc76qvmnxid+VR38xU5lpIezMDInQNnp?=
 =?us-ascii?Q?qewR8uEM4rjRrWvPQcV8CrATHjL1mrNvB9DHF5gGTQsRvjdTX1AkZz600qtD?=
 =?us-ascii?Q?SZaEh6Rfc42j70yn85xVbT4eigXa3rE4sGO75ebBpNvEBAgJkYu7HOPrjj0z?=
 =?us-ascii?Q?YRM5Z54T56jQ1jME7OOvtZZaHJXXZg0WIIVz9RvEtQodN8OfvTpHpohHaku/?=
 =?us-ascii?Q?7pqkC31Spi4EqU8huaCXhYdf5iikl6b0DwxrfphvhcV/d+88JTHnSgU/kRLv?=
 =?us-ascii?Q?NCeSXlHv6gbrkov/j0LCSxJImnIydrWhvRK5cvdIJoa2sTcKMu3sdv2hZAyH?=
 =?us-ascii?Q?At330pcVuBYrV5VcVe1Vnu4VXbUhzRoct/3cAohgy8mSbT9lao0hxXpBQQql?=
 =?us-ascii?Q?8lKj85yyyDBlPxJQrgV7OOZK23SLQhrq8ZxFc/pFM2fnjvDBIZR63W2CpzBn?=
 =?us-ascii?Q?rHLTywu2HhBrRBgc6kUKaJ3youWxuUWvImXYpTHF6V0y8h7t3IggdjZTMdnH?=
 =?us-ascii?Q?+j3l+qoJcE/emQz3n1T0i9wZFUAwlNYuyGDArQlXjFrkEBg183dLmrCexINK?=
 =?us-ascii?Q?jRQWzb/wjKHQI5htpFL1zaBqvTSdTzqlgLgldWHo9lLUp03kpD9gdfWhoUfN?=
 =?us-ascii?Q?8xBIY5Cl90Tv3ebfnlGWWyOfiq4bjr7AwxQeuMrP0/BPwXxIZMAFwxnFoQdj?=
 =?us-ascii?Q?/geeDelaEqPh9GPgs+W8InakUQZY4cdiGQJKA1Hxq23wZxfwQUmBb5salX3B?=
 =?us-ascii?Q?Q3uAV+cGCRIjIJ0UhpAQOYglHUW1Il9vlcnHzPTkiECf+eR96BHC9MXNOyP+?=
 =?us-ascii?Q?UMREJ7yED/kBIzb9FuBS1WYfPAHKXFOL141Zsyju9PLnRsX3LxwaCqfZdvFI?=
 =?us-ascii?Q?t4sfEfYmm+DZ6XitXLY7VD1zNcC4sHjegGpfS0ynWprzsrqWoS0GGj4Dg/Fb?=
 =?us-ascii?Q?QUo0x22+k0WHZpo3yjIJMAOejgoD68f1SLu0neTNsSSH4eNnEbGosi2OWfiZ?=
 =?us-ascii?Q?uWLU6cK6CxCgrsKUcvMdxwhVvKgl0k01MwFbd6NwvOT4FFPRcOhz7Vvzdpwe?=
 =?us-ascii?Q?rcm6jZ71IYfYo/0lVoaDcOmeNDO7+ZATQzsQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:39:41.9154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24381cd5-7cdb-4b84-1b55-08ddc05edccf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

