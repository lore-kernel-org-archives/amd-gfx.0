Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1108CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 11:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6147710E8EE;
	Wed, 10 Sep 2025 11:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cArxzla5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BBB910E8EE
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 11:37:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoS3bPmBt10VPVuyufBpLNGr30XZh5oHGwgQMK7NvWwm6dr51f5YS519ASSff/8cUoJ4/ESaYEF19JVmDuQHaSD7DZce0hdR/Z8+FRj3dQH94t7CxvJNHU/pg91248bYJZj3Xs5MpSLFHcCQuq5upTCz1lhYe7hrk1MIOAsyif3AgoigHaAqpNH3/2X+JuoUsBcJL8Mu4Zp1vgv8pcJ7/eT5Ix61dY4Fzxl6b8UFFa5RrwEYGohkVgGopJEV+EsAt7LfhVnopLy9FlaqOMKrfJ1rtTzhr+DnYoDoHfJkCe8ok9Dzv5do12dZ/+qffnj3bdTRLkUhn3BhnA964M8GYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uccYcar4jP6GIQwn4MWwxidN1XlZHWkSpomegX5S544=;
 b=mTWfK2rdRns5CrawyP4dmCbSpqnvgmqjVeTXoHovrj3Zwj9iDMLgRWXn81tyZLRg4LZlIISnJvH0bMGc8Da53TsHoMkTk3iibj3IWoqjfzLbEMfzPJ0rwJk0+aoIMguhS+xzWwjUX9DAgqoYqVrWFF0OlFbDHEl2CLq4zoRIrdkYuoIafkFEIqoSjd5ZsXwdh0oi6cFMy85j461nREW/eXNSDpNkvxGIQ2WjDGRHbOIIEsAhpF6BIm8HTvGNHC4OByDESk1ZmlhD2Nmj+f+dLme3C9fxeCGQBXm0qAmyTA/FdJfEj8byhr8XuoxEGu1lbg3gUdXwTcPYleLEoTkYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uccYcar4jP6GIQwn4MWwxidN1XlZHWkSpomegX5S544=;
 b=cArxzla5QRu+l7MoUJ0QxU9pF2GzEI1LuHLNTsmC5O6CuVt/qIjwrJqbqULuCi542xQzs4s29mTg10y2pw0BqX24VNCrqN9os9TCaVcCRbV5m+yuNADx7UuXP48iJqoH0Xh2uFMQ+fwLqvFzWrISuTlJbV4eilc6FJl14Z11xww=
Received: from CH0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:610:e6::6)
 by BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:37:45 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::8e) by CH0PR03CA0271.outlook.office365.com
 (2603:10b6:610:e6::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.23 via Frontend Transport; Wed,
 10 Sep 2025 11:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 11:37:45 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 04:37:42 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/userq: implement support for query status
Date: Wed, 10 Sep 2025 19:37:24 +0800
Message-ID: <20250910113731.2688320-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250910113731.2688320-1-Prike.Liang@amd.com>
References: <20250910113731.2688320-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df91725-d478-4571-7020-08ddf05e75d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WG0P54SPL+pf4dVCBqiadKfk7zxElvv2WvXayPMjV4Qk+lKriUMIcjk/LXHQ?=
 =?us-ascii?Q?Iyo+NZfRMDv0Vx9w8EfM1MmmMuOnvh0qlpjPb5mWvo6iBC+dAhyPK5U/8Nye?=
 =?us-ascii?Q?zNAqvV9ySSBdCWOXQx3/CK334++K0Vkt04FaXmS9kSqOkfUVd6VovCutGV5z?=
 =?us-ascii?Q?HDoLccyjkOIsGbPldSaBQw+Yk8irKbd2d25fjSTLWj7T6toWzwU2RTOBYF3u?=
 =?us-ascii?Q?enm2ZBEmCIw6g26z3Z0lH6Z8qk4+iOxQZ8qvlmCj3gGYrMTsECwE9S4HkqDo?=
 =?us-ascii?Q?9ZWkokzrcDLay6vqmfnrMKspshqKXTqU1vn8McYMW8cRBrjJePlNC1/ordP3?=
 =?us-ascii?Q?ECb6yAlt3kHcuB+gSv+f0ZdpUbb+iNHcliWIqR+UKeXECpdL5SEyqdBJvcDW?=
 =?us-ascii?Q?8ZItcYb65CxrHCl6jLTJ8UM9mQuwn+cLDQHbt7HD1kkb4aBig+bFnYDsaLBe?=
 =?us-ascii?Q?UEBqJ8/wYA9igVOAJ7rkRn32LVmrPuZi6RFlUCaXR1lkqgWf9EL7FUS3j5SS?=
 =?us-ascii?Q?1c5jxUohAYb5lvTVLOKt/IP3LUBLZjSaH66xCsdiyomOEFYKamHSKurfrQy6?=
 =?us-ascii?Q?ckH+gbCWDLM701g/Gd2vHlPEjDhYrURj9zYDekUdB6NZklh8Q17VIEWzMHwG?=
 =?us-ascii?Q?jv/a9zKNgVJRNHPXMx1TfAITMt8pEaQvLq8xP40Se/mzumDCZOGAM24mcmmo?=
 =?us-ascii?Q?Qfnni/bnr5ctI4MimjbNDgBdPmJnz6kvfFiqaqWa1wBMNtlXF6sff7Pzdln5?=
 =?us-ascii?Q?g3EFdudaETkZGli3cwZpygNo4VbTbD0bjnDP3/1QZJ4BVS8uKf8Kdb7YV3nW?=
 =?us-ascii?Q?b8tx2rzdPgrV0ocxNOF6pXQemqMs2rTbm5dUvwdGuzalEzrfrxdFCv2d58Gi?=
 =?us-ascii?Q?65jMe+kiVXHYO2ygL0VbzNbZfjKeQox2xUxG2uEs4MiFxxpZpzw6LKd6bNs0?=
 =?us-ascii?Q?3bdkqWUGoPgdiGr8nFg3/PzLEYt6T9bX1dC9g7xcITeJJCOvHFG1g5RCu66j?=
 =?us-ascii?Q?jiPc5kWO8jhEVerZ9bXmKXZBl2efxuRSG2P+EcsGZ6+8Vfse+elkK8RrOvAX?=
 =?us-ascii?Q?KoRHV8EeP+ACjEdMSdxX7/Gdn6KUSlSijrqg+gdpKpc1tUcMiuZfK/WJhmpH?=
 =?us-ascii?Q?zeHjlj6YP23EUKtuEtGhsIE2tXLmCi9NekIePNt1qrfyHqvxPSsc4lRsrvRa?=
 =?us-ascii?Q?AoUIcgs+e6O5hWEIkE499wBNaaOPRs5nV0C+qm3Uzr9dgUCbFHCSWUtu6Lfo?=
 =?us-ascii?Q?eF8sgyNd1ODVDfiQR8t2/7Wx4x6cbDICieH7U+ireqB02Br4MMbi42FONlCH?=
 =?us-ascii?Q?5UJ7RON/mbtz/CnnwLvixpfUPCxqVpbKGpjK9gzaR/liDk9FiTGDJHAb8/he?=
 =?us-ascii?Q?VakdQO8/fmEXRwZCh83iJ5Bx+TJjXqSGflXuOosyxr0gE8HhQ9py0BDoI3Xl?=
 =?us-ascii?Q?Hk55SSvgl081otoovV3EogvXZDNHTvTIQLhEKxs3ig5zeVndqtMShrfI0INF?=
 =?us-ascii?Q?3K7ZjCdTPECNL1nQFZq2ZD2QIXO09V+Nnlhn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:37:45.0394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df91725-d478-4571-7020-08ddf05e75d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244
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
index 9608fe3b5a9e..83f0ecdaa0b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -472,6 +472,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	queue->queue_type = args->in.ip_type;
 	queue->vm = &fpriv->vm;
 	queue->priority = priority;
+	queue->generation = amdgpu_vm_generation(adev, &fpriv->vm);
 
 	db_info.queue_type = queue->queue_type;
 	db_info.doorbell_handle = queue->doorbell_handle;
@@ -553,6 +554,34 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
 static int amdgpu_userq_input_args_validate(struct drm_device *dev,
 					union drm_amdgpu_userq *args,
 					struct drm_file *filp)
@@ -633,7 +662,11 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
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
index c027dd916672..2260b1fb8a22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -66,6 +66,7 @@ struct amdgpu_usermode_queue {
 	u32			xcp_id;
 	int			priority;
 	struct dentry		*debugfs_queue;
+	uint64_t		generation;
 };
 
 struct amdgpu_userq_funcs {
-- 
2.34.1

