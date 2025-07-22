Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8899C83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CAC310E5DA;
	Tue, 22 Jul 2025 03:07:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v0KtapwJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7548210E5DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/d2dw/fvRbWlIt9fh3nmdxzjvb2EjeHHRD5xNkCP6hrixBQNBB8ZJINmOYND6aLJjKvQZ3Mp2OnFOS3ZxYLHBo5yNtVvyqcOqAQ5Jg6kB9988rLl3RgQ8jhhB0HEuEp+Ag7CRwHo2PTaHPf829e6nJIlNUB1SyeNK5fGk25TU7U1yockqsvJHJNnIX3sWXq8epnO2eKpRj4X03p+NFPYQODR68BdGVvMuyp3jEgnq2S6c3YprbX7cpTUtkvr9xW09UhyQBHi56sD8eVjyZvx6T4yDQm5RH8DA0ALAr3pUMTKSep69xcwged3bhnLt8proQtY1CrcIqYLwiwKlci7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=IsDEmvieWA8DS4no5mayzK4Gryyrmg6dXtyHpGnEpfLxOj0TFHLqNwt+zW5dQCdJE/nYZziq75n9sTQ9MIyjqwPGz6SCkU4bmzMaQvnpH6d71645gjpoRojus7CtdPSVXp0cO4MW8/xXcDUSl/z8xKD1lhQf5X3NhYpX5wOpU+F4DZvJl9qjDhNyScaA2SrCt86BfiKyIaub+JnzgeSCn9CygdwrH2HntGdHZkVJxI2kmmMQe5fKx2/1RDeCbsI/mejut8waoBx/Xz/1cRLEVMO4WTq2sIfxHnMdsLfwmDZvmBdglU3N1wVZTqE7WETOQ0kkPJQo0s4qAVVoSFSc9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdsTfCHUNqZvyGaRYC+QBT9ccuJqZaVDZj/SQZksYVY=;
 b=v0KtapwJnuuhcG/TIu5bpuOBc4F3m9S8HEPuQlHcfnEJEm9cy6eiLMuaLo0J6z+BMg2PqE5U3bZ0T4uFN+JvmoVIQkPiD/KmDRhj3gzwImwwBglq+4do5luQwikXgmPm0W0gsSj0kF8Bhs188CpjEv5bv5pmWUK0l+atMwAeZug=
Received: from DS7PR03CA0288.namprd03.prod.outlook.com (2603:10b6:5:3ad::23)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:06:51 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::30) by DS7PR03CA0288.outlook.office365.com
 (2603:10b6:5:3ad::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Tue,
 22 Jul 2025 03:06:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 03:06:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Jul
 2025 22:06:49 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 21 Jul 2025 22:06:43 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v5 8/9] drm/amdgpu/userq: add force completion helpers
Date: Tue, 22 Jul 2025 11:03:44 +0800
Message-ID: <20250722030605.2741435-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
References: <20250722030605.2741435-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: f46f8fd6-80da-4c7e-b7c3-08ddc8cccd73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xA7k20iUfQmYEdSdWGuuC8AXoUcQYIjIW+GqoTPQVE9em61ovRQm65SJPtFD?=
 =?us-ascii?Q?4RfT4drdPjpW/idmaVEX9yW20byZRkg6G7/zA+FUvHAMK/d0IuxbZNWYw5SH?=
 =?us-ascii?Q?tZEx8Rp8/yjHAqx9JkwcIJRFdYWBkisKSOtsSYcyFKpeV+muqas07LBKpTMq?=
 =?us-ascii?Q?C8/nnLVAAL42C9O1wLf23T3VR308Mm/2cNUxPOE2gqIiIfNRJvSA4AjGU1Ad?=
 =?us-ascii?Q?o7/zLz+KdK6x39PK0MAUFn1wDSe6Hq7C5bGpuGFBjI1bP6UqSHF+Ub7stvbf?=
 =?us-ascii?Q?h8kAtyKY1vBsFgrzG67vSuq50jcEqxBxaIiNUSp0NYh/9jJm2bg8W4Td/TBB?=
 =?us-ascii?Q?tLLmy2uPkVAw0OaF6oog3FQLto6J9qh9CcIXZ9VTuGD0uaAsMy+VX87cl6jv?=
 =?us-ascii?Q?ZsuJ4zSPu4R26+xZvPhVLq50Gb6IQPMiKNFCQY1U2rngf19/LhaJ8cTem7Qm?=
 =?us-ascii?Q?TVMO286TE7J7YKwXWLKobaSVTUthbHF1C1lXs0PO1WDhzJlgw1qu3lkmmYN9?=
 =?us-ascii?Q?IDeOgQ3wZjF3UNRTfl/F4vyUZEZvZDBc1bgHJXnHVMwXdiNzF1fIxku0JSml?=
 =?us-ascii?Q?TWfFURv1XwHzOG2EVe16d3oUHKv9deroAahNiFNerYhsOBPi7Zr9u0v3jnb2?=
 =?us-ascii?Q?KBWnZfD9/7IqBq1EkwtR5weHUT/Xso6EFXZ04z31d4glF0oGNYMl11gbQjDc?=
 =?us-ascii?Q?VnEe4+OP3oL23fDrFUR+iVWXbc66ZqFdKtZK7GnTgOTaqvWF37ZdRgXvANZk?=
 =?us-ascii?Q?HJqBCpAomul58p8zTFq6FhhkC4GBkk6dNqzAmtB4O0aEgZiiglp+FyMBOoHM?=
 =?us-ascii?Q?uexo4aFII/D4vWhqFC1LR0IOrmGyI9FJGhI+yXx9/jJMaugiiqukBJq6efso?=
 =?us-ascii?Q?R9MsmczRe05FRbCt35lw1SA3ZYvH5SjlSfSyjn80eXVfssvIIoVWHpZc1SvC?=
 =?us-ascii?Q?U8Ez9hEscRJ1Wma1mtGZu3J2Rp8ESNNiAdWkZ6vv/bVrfXxVaszEFZBpjPL0?=
 =?us-ascii?Q?ce9MSSwYrn6wh8rwyBoiTbccUx/HCf31aVuY8T34yj6ICraq+V6xauZmGqRZ?=
 =?us-ascii?Q?FuIfPe3K3rsWPOgTzV1Yn9rdTDSqcPqD1njDVe0YW5qeIBnCP0rYq8S+AZxT?=
 =?us-ascii?Q?fwZGPMfAXneOuRBPwstobdC54HHjy/52WKP8/d1lTwxepAPUGZfatHc5Ti3z?=
 =?us-ascii?Q?QOI9sKYp7fHkwzaFXH5LdLbDo6Jf86DJBX5PPWBcN7UWBC8OvVzPA+BOWeZt?=
 =?us-ascii?Q?lDf8lGm77A8aNdksTzgOkKf2mhQIxSNtGD8mK1c59jvrPQkp0GAISo5BJvRM?=
 =?us-ascii?Q?uD0oIFapYZ4en1aL2nEzxsnCXxd7XQiXS2BnWcchJc2shYnmAbwfgPa76y/j?=
 =?us-ascii?Q?/hA44XkeCghr5mBatguswK++Hol7S51oG72PcDcK9Kagt3aCb/P0tVgvyue+?=
 =?us-ascii?Q?Nwf61ezvuNGbX1YU9jMqb7eRKCV6/ADhOvzNpa/Bw0HGrUrZ9FuvMG+f1wb5?=
 =?us-ascii?Q?G1UNy6Ptg+9m3sbe33GufjGPXb4Nv15aPqUO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:06:50.1460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f46f8fd6-80da-4c7e-b7c3-08ddc8cccd73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
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

Add support for forcing completion of userq fences.
This is needed for userq resets and asic resets so that we
can set the error on the fence and force completion.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 42 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a86616c6deef..01688bbf3f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -67,6 +67,14 @@ static u64 amdgpu_userq_fence_read(struct amdgpu_userq_fence_driver *fence_drv)
 	return le64_to_cpu(*fence_drv->cpu_addr);
 }
 
+static void
+amdgpu_userq_fence_write(struct amdgpu_userq_fence_driver *fence_drv,
+			 u64 seq)
+{
+	if (fence_drv->cpu_addr)
+		*fence_drv->cpu_addr = cpu_to_le64(seq);
+}
+
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq)
 {
@@ -409,6 +417,40 @@ static void amdgpu_userq_fence_cleanup(struct dma_fence *fence)
 	dma_fence_put(fence);
 }
 
+static void
+amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
+				    int error)
+{
+	struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+	unsigned long flags;
+	struct dma_fence *f;
+
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+
+	f = rcu_dereference_protected(&fence->base,
+				      lockdep_is_held(&fence_drv->fence_list_lock));
+	if (f && !dma_fence_is_signaled_locked(f))
+		dma_fence_set_error(f, error);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
+}
+
+void
+amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq)
+{
+	struct dma_fence *f = userq->last_fence;
+
+	if (f) {
+		struct amdgpu_userq_fence *fence = to_amdgpu_userq_fence(f);
+		struct amdgpu_userq_fence_driver *fence_drv = fence->fence_drv;
+		u64 wptr = fence->base.seqno;
+
+		amdgpu_userq_fence_driver_set_error(fence, -ECANCELED);
+		amdgpu_userq_fence_write(fence_drv, wptr);
+		amdgpu_userq_fence_driver_process(fence_drv);
+
+	}
+}
+
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index 97a125ab8a78..d76add2afc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -67,6 +67,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 			      struct drm_file *filp);
-- 
2.49.0

