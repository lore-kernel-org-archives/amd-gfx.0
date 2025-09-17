Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE8ECAC5A8
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 16:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B4A10E55C;
	Wed, 17 Sep 2025 16:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tXSHoGLq";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDFB10E54A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 16:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuRlaW7VmzcwBwWkg4xWQyL2NeTYEbe2Po6BSvSM0r5D2uz8WbNLw4Ph4I2mm97W5ri9fPOpB1Iv180QtdScXNDW9VLDb7Kwuvgd12VK3FlyqYgzQF8o7W7PnCWkIvH+i2K1rQVGB06vd5ArTUxSjg/RzZb2uAPZSYKN/Ajq1JnvZLn+fnz9TjvS1d/LBQjgHH4CDUK9C/POyG5Yy/cJrqctILfCRvgw2Owdrc6U+wZbKI/NuF/1bhi0CQ3yv4VJn/PT5bdde/YDTNCFbCKCXK8ygjrY3fh5WG+qM5MEQBHqmByjxXrwTM5QZPNMdXhcVe+QsYHdrIVHmh/dSnKH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at3+p6NodoG0NC9lLnRbIotHwsxoOiR5gx5x4AILhgU=;
 b=gZ5TplHTLk+QuDqoecH+OJ5u+kF2F61uZ/0pLM24mimEHLqpIwvVldDY82UmnOeb6tlj9eh0fbifxyoSxhgViMdjzlvzHgICoNBfDGg88JJwmUNJN5abLxNMnXcJc5+IIHhveb8jhdTBVOEFyN1x3mxXAY+S8s1u2i8WhIOF+qYBzU/YxD3B9vNqdqGOw+lNs2JBTj2JRBgt7dDavzFULZmixh4z6IQYnmhEMFD4aL5g1zcw0LwVY/5UZYLtmYSe/q3Nse9etDixL3cUYb8+08i0EIfTnGGPHm2YmAdeCskoZ/1m9dotWQ1A6MwRRQ/PpsefM7fuDSklWy/sOyT0uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at3+p6NodoG0NC9lLnRbIotHwsxoOiR5gx5x4AILhgU=;
 b=tXSHoGLqw7Ff5RskIqPZtsNAhR2MrBmKe8HOttEmH9c5B+TK5Bgge4AqbOjtjMT9msAFKmQS8n6GOeUFiowGhs0U73QuZTU1fqL6EXj33PxiBvF2pbcY64uaEZ5hnhAomWeXWs6vw/V+0zSO4llCKa+e0kAPfnnzOg2X0yLP+zA=
Received: from CH0PR03CA0440.namprd03.prod.outlook.com (2603:10b6:610:10e::29)
 by PH7PR12MB6693.namprd12.prod.outlook.com (2603:10b6:510:1b0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 16:42:30 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::4d) by CH0PR03CA0440.outlook.office365.com
 (2603:10b6:610:10e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 16:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 16:42:30 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Sep
 2025 09:42:27 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mario.limonciello@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/userq: Optimize S0ix handling
Date: Wed, 17 Sep 2025 12:42:10 -0400
Message-ID: <20250917164211.1761304-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917164211.1761304-1-alexander.deucher@amd.com>
References: <20250917164211.1761304-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|PH7PR12MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 12356cd3-c768-4d82-3598-08ddf609319a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zW0CldXC3o3PRO/Wo+Rl4VEDsghUutLwOkw4+n6RdABchu7rgqbKUCxjJ7Wn?=
 =?us-ascii?Q?tD5U2uYZjPoMU1Nq12FcOIwWKfjGNyYg32nl0wsTyjzZ3BARoWRNvi/F5fef?=
 =?us-ascii?Q?U4xSoDPgz5D4FA6mD96F1OVUpBUuC41UhaZcxP9cZ4qn3g0AVi33vybLVnJ1?=
 =?us-ascii?Q?K2acLs/eUgd40UG5VxtitI0Eci6YRRpV80OsaWhoux/6t7zGwN9HjpAVol6H?=
 =?us-ascii?Q?XnZ5mZVUwplGo3Q3x+8OHKD0lTN+4M9MHKVH0hW6FWiL5xr9D5femljtgSZX?=
 =?us-ascii?Q?cvP0o2jbwDX2MXS7tIcHK1QKSJb6rqz6kYOMyzh2U2AP8Ke4od99pjfGIgpD?=
 =?us-ascii?Q?LajLY7DJvVZEjVPrejiRD5qHOdSdb3z1L0qIVczocKuHfIaHNhsPspvUzQKW?=
 =?us-ascii?Q?Xj44nOxI2P18rBdXwuJfC3Hg8wV+/ecgVRxhpK0dU8zeoi/IUZrHxmrDJ7xG?=
 =?us-ascii?Q?I7CLQAUZiQK3XqzuVJJrhp6eQ6AxDmnQRqvawwrqHiDjm/y8FB38XEIqqqCD?=
 =?us-ascii?Q?GpYeQqB/XeqR4Q9PwUYbEhwQ/oBlztRyExl1B5hWLsH4rt6CHUqQjzuwEGWp?=
 =?us-ascii?Q?xCcPHpPDr9VFAPtl5NzGmZs8vVrZ0fgdGmLeOvUlDFsEPDg+HSV/WNnxW6F5?=
 =?us-ascii?Q?qz76ikeYkt6IE7A0LOCpKw9Aeqc5jfWitlTVh3ul0tHiJXO+qPj10TJ/ch7m?=
 =?us-ascii?Q?s/5D2KjLp7Ir1o/hWEelq8ykD6+AJO8uvvGPwKnixD+KQCCfvgcd7IwMQeFD?=
 =?us-ascii?Q?MY1kgI74Zuc/mKEi+HNuWPyNslyvbZaCYI/tRHntInyZ18HnIdRKDgz7XBzN?=
 =?us-ascii?Q?FHPhaV8Sz1lIXFeCexDycSB1WGK3jKgq0mZ1aHxzTXWrI3nevLqgwoxa/hLu?=
 =?us-ascii?Q?KDAF/in9ch7vCm5fD2SV8/jlQgxpER0G5O8uUC4tJWYfuJzbuVNAICD30i2K?=
 =?us-ascii?Q?PrR5CARLFPMZgYhTq6uizSAd8OBQV/HHS6Maa7EWjK32y+mSqPnTLA3oiGMu?=
 =?us-ascii?Q?/POPpkxnD7MSgFLky4eJZvpJbNNIz3xdiXPcqpu2zei0z91TQvLD0FOjvJFd?=
 =?us-ascii?Q?77XnfzESr9hJA9lW4LucZ2y/6nl9KILgKrXFMnOvfTnbr9yc+qztuWvF5Txv?=
 =?us-ascii?Q?vgQurrogolUYTj+YQoii61Ap5UWqkUIISqbPKKAivVG7APTVULgUeh32g7Za?=
 =?us-ascii?Q?4hH5PVEhF1ra243d5D83SEvJqnbvfSM4Wbey90yoYspgpOafJbL1tWnYLpaX?=
 =?us-ascii?Q?vHCFheLyA/vMfJOZnEDAvq0/fwDOu09gy/uIWXbuXLrpNnuFi/CzHOWUIjIL?=
 =?us-ascii?Q?sHtZSqL5J6g/r7BBZOglETrbFJ23y0JaWyl8RYv9RV4p3E84mubNIEpuct6Z?=
 =?us-ascii?Q?dgFGOAmo9yZ6ttqq1ExhKVsyNxDDME5B55Aeb4gP2aWgwcm2BbHwNnJCgCa6?=
 =?us-ascii?Q?Zf8O+rkFkaLasS2c5QVpvpZ2TFGY06vy+O5ySJPurI+5GbyHIbJJxw5Qeai+?=
 =?us-ascii?Q?LQekEo/5oYfwzTnIR00lpCG/qIgBZy1bduMM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 16:42:30.3258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12356cd3-c768-4d82-3598-08ddf609319a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6693
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

In S0i3, GFX state is retained, so it's preferrable to
preempt queues rather than unmapping them as the overhead
is lower.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3b43d062b7e0d..af7753bfa27d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -975,7 +975,10 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 		cancel_delayed_work_sync(&uqm->resume_work);
 		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			r = amdgpu_userq_unmap_helper(uqm, queue);
+			if (adev->in_s0ix)
+				r = amdgpu_userq_preempt_helper(uqm, queue);
+			else
+				r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
 				ret = r;
 		}
@@ -1000,7 +1003,10 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
-			r = amdgpu_userq_map_helper(uqm, queue);
+			if (adev->in_s0ix)
+				r = amdgpu_userq_restore_helper(uqm, queue);
+			else
+				r = amdgpu_userq_map_helper(uqm, queue);
 			if (r)
 				ret = r;
 		}
-- 
2.51.0

