Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE330C8303D
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jul 2025 10:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CDF810E9EF;
	Fri,  4 Jul 2025 10:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LWto1+If";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863A510E9F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jul 2025 10:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOoXAEYdBmVvDu+2I4S3F8CI3nxlXQYak7bP7Na8A8DwzuNWuLIUywW2OBzcJwYjYSoi8wLKvCqMKkiBmZ2/VAUnbIcLzH4PnNvfkgIZn5Ab4Z3sVtaO/6hzpQt03wGXQNzHBzM7JSQkYvMU6dDwro9m/LSFqbJxX6odEvoFUyByWKYrTpJ3Xv1UUFAlhAqxtR0sWsSBI4Bcf/urL/tHJhBfIJTdGZdmDvMDP3jHd39K9uDzLk2gT24nILNCLfYeMWUe9yOC6eWELUs3c+O4ff/zVO0eYs8KNM1ppkB65lJG/OEJbDeAytmHvBXafackrJ8PNbQdbqVQa13Izk/hlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzLaTuWnLscNrzt68TT9mlDoOuz1lx13tN0aW/+c+b0=;
 b=mLi6gakRNA5cCPLMtURvGJsS514yC8UR5BGweNAG5HcLjW74J5Uo/8MaDf6nfP/bbFOy2fL5bA1Qads37Ulg9EXjOqUiqIRmGINcrJ3b74odZKkxhWSAxFOx+ffMN0M/bQbBHai6H0sZfboSzD/k8uvNu/WeQ0sXE8b4aEMP1dLqpq0Z0cT43ckzVxae9ql7FwxlYZexAw1t90qy7vtyTvmjFWOeSQhtcMMIp59qtbHXJp6rQozmTjEQoLe4KSkqKz/YLJjP3UaFXTcYf4foc7LyWBrWDX0vA0NLOq0HH1GZBXGQseY7Oe79FZ9r3MEUlVn+zO3/EaXi6aa5u5BILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzLaTuWnLscNrzt68TT9mlDoOuz1lx13tN0aW/+c+b0=;
 b=LWto1+IfCIqA6SK7Tw+Gt1weZJGoRJPHyULSgbyfFLBV1oYaQMdzS9XBs8Znkfu5p072G/GkVXm3f5M4B/ds3gcEM7usYMYAv0bDyFfoa3jTkNUD21Ft33u6X5ICnzJpjP2DnomuCS7HZZz47yHzxi94wQA7K/CuvPT9KgkXvbc=
Received: from SJ0PR05CA0184.namprd05.prod.outlook.com (2603:10b6:a03:330::9)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 10:33:29 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::3c) by SJ0PR05CA0184.outlook.office365.com
 (2603:10b6:a03:330::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Fri,
 4 Jul 2025 10:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Fri, 4 Jul 2025 10:33:28 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 05:33:26 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v5 6/9] drm/amdgpu: track the userq bo va for its obj
 management
Date: Fri, 4 Jul 2025 18:33:05 +0800
Message-ID: <20250704103308.1325059-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704103308.1325059-1-Prike.Liang@amd.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|CY5PR12MB6645:EE_
X-MS-Office365-Filtering-Correlation-Id: 805d7869-d064-4222-47a8-08ddbae63742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3/6cAX/SxqWSurB+coSmqy1mDKNuLcM3vxe5vB1PQJUZNHsjWQ5pHNK4qPyH?=
 =?us-ascii?Q?0kxGCoIh8cColCtI0QadX/9OYEnETysGzMmL3uiJ5ApYVsV1wtXK7/fSQFuy?=
 =?us-ascii?Q?ccSsqdOCfnti5J2Yxr/WvSEJnfow6Rjxny2m4x1iUEup7fyqKy75jWVj+mzq?=
 =?us-ascii?Q?u8B1hjJY+YobJ4jem/DoUVOSb6OBzE6/QKL1eDFSkp3gqQ3aNdAN8edu2IcX?=
 =?us-ascii?Q?EUfxSlGjIYLzKXb7kZg3IcQsr7q89J7iCrj9vHBJEi3F8Ti79A5D1MC7a3Yp?=
 =?us-ascii?Q?0cOR4l32fvGmzvoVs0mdXK+UtS0ugX2cN9FxpAON2RA6cjWbY+R0mPnAu9fQ?=
 =?us-ascii?Q?48RnvwWKZWtW5loyZnwVmZnrQgFKKPwgB79d/HhVf+5wUKyOIrNEtbvkNDfc?=
 =?us-ascii?Q?QnyRRjQAHYSdVdr5wVzLXlmrA4T8Qoio8OvBGuU7ThPHE1iuupD6BvMOHm2j?=
 =?us-ascii?Q?wwxDWoQs5jmprwOMOtyPeiTmK5UbL9EKf9LveoL37LD4gOAHYkQCPR5p+RuI?=
 =?us-ascii?Q?XKkRvve6eaOXim/sIZzwRpQTm78Qu4od6TnyBzp80Lx79EvCTcUaMAO044LK?=
 =?us-ascii?Q?ObfCNJmDKl1xIVDI7ZSEldHNcQb1e3ge6fiETPM2ajTF0m9QyIIUO0MmP3C8?=
 =?us-ascii?Q?Ua4FcWq6cZajTNXlzdGqZhwUHvHvFv43kINSttgEiKOgFIC9/WV+5cihOJGq?=
 =?us-ascii?Q?H/tBsNgvy2ptvAhJ94NQxhFDNuHPYBSo8aQ/P4k2gAi5bwcHNHfwIm6OAve0?=
 =?us-ascii?Q?qifXVzIL2tc4XjCOoEfRR03vSJKBwmI2Ljuwr0GPUrLvHGXHLJASQCDH6zpQ?=
 =?us-ascii?Q?YXOjhpzkKnIZeWcOmTqKjO3B+aWzxAlUR6iU5WKCXFfRvIMwH+hd12X9/Gmy?=
 =?us-ascii?Q?3MojUhVSpGUKQQonCYaJhkaPe5IzUvL+OPfNwCx9RBMA67/vdhlM1CTybxJd?=
 =?us-ascii?Q?6q7aZ6ZeM6k0SR+/DXsm7kpRxNmE1ZtTusbgc4jztnI17vVDf5UbTFzwgkju?=
 =?us-ascii?Q?lsKuOxH/O6W11UMiQzM4Wu2I/B45LIYddSkPCYLwA2JkSFMKJcud7RuiXyJP?=
 =?us-ascii?Q?egB7Z/HH86QAvczsCBTCG8JS2ZkvgtZbzNvdYN2u3HKITyR85j26T35clR5d?=
 =?us-ascii?Q?qhfbWhGV+Gt3W/Y9A1oMn27rDUs8m+DCQOkekd9eY6ctuFfuYE6/Dq6k29Q9?=
 =?us-ascii?Q?FiH6rx++ALhQXJoeYSyo53fPBze610hdMQ3Rhd2/JvxH93nBDkrA1He5vtcJ?=
 =?us-ascii?Q?ZpKvtgbflbuFejdoCf2SDYYXS0s9EkN7ZFQXoURAoNURQ8H8veLouIqB60VT?=
 =?us-ascii?Q?4YdyA8QfjLHcVHCt1coMMudolkHpke/5BgqAfH4Y1wiwPyM8Yi1xvPQ04kIm?=
 =?us-ascii?Q?JXtnEHma11vv3F6DDHhbt8SKjVs7a3Vux1Z7RTAt/Um2w2qvwtWLNuCloBfi?=
 =?us-ascii?Q?yZi3gAmAWgHWzUXTAM4lVNwCjPBFNftbAJq1d68bhZnYF46n7jDvSAsxWVFK?=
 =?us-ascii?Q?nVYzdhzRakClIh77ySkhtKrAmJyA+gqmXOn6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 10:33:28.7468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805d7869-d064-4222-47a8-08ddbae63742
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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

The user queue object destroy requires ensuring its
VA keeps mapping prior to the queue being destroyed.
Otherwise, it seems a bug in the user space or VA
freed wrongly, and the kernel driver should report an
invalidated error to the user IOCLT request.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9841a0b09fde..25a35ab7395b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -515,12 +515,24 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unpin(queue->db_obj.obj);
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
+
+	/*
+	 * At this point the userq obj va should be mapped,
+	 * otherwise will return error to user.
+	 */
+	if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va shouldn't be umapped here\n");
+		r = -EINVAL;
+	}
+
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for userq hw unmap error*/
 	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		r = -ETIMEDOUT;
 	}
+
+	amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
@@ -641,6 +653,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* refer to the userq objects vm bo*/
+	amdgpu_userq_buffer_vas_get(queue->vm, queue);
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-- 
2.34.1

