Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5BFC88E72
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 13:07:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D353510EE17;
	Mon, 14 Sep 2026 13:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JfyLMFlT";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9973210EE17
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 13:07:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWBIIac1zTbg9Os6N+u8185mcAC13lYAIkDd+qEkH0fqzjpzf1qVHOjQlsu7Bm7XN2/xLy4VSui9a8J+Nij1Y2+yuEjnPQPYJXu/0GEG/jhMZQM/GZ6FEJbejUKNWZUstEdGyScejH55xz+oZy5+GiRGqI3jT4XJY943sHKUswXS6FJ+DLp09pvARPiYcTMsJHaYK1njnzeLG93CNSrJbNfHn7mEtN7olKKKIoRni+aQBxE3sOSTHb3F518EYNVmtSHy2c+sbDV1Dv7/ciBfUrfkQA4IciwDtrauklSFsfhfUFnNhiuZw1WiDUKZODiHVQDzYMN1trVw0UkcEiw/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AeXC0ryIVW6k2iX69yZhudqcQiLEO1TcIqZE8p4p7k=;
 b=vyH+/t8fNAY4e9zzNhu0kCu4Px7Z5y0G0EUWPM0eJqcNjlywGFvpsDrhE8ERjTvS5BPBGMnsFI3k4bmzEFcAETW6Ee+y2fqFI8ct4Vb6B1g25XR9s2RvRnPslhCHtAgtZeR/xGB9WvYnN3uUHlQign0paUXiLyf8T1pOXpRSX7GYUrhor3qOBMAvUNZ0PWPZ6mTNhVyiFx5EF9IzNuA2m+kIlwBcvZm707I10hfmo2xq7rRZNQUG2febMoXJhCCoXQoDhxnjT7Uw7YsO6LNmgOyu5RrMjPfY1TcdGKr5Fw94SqUtjvTERhx2d79onGEq4HXDWEoAkyGRrz0FrsG1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AeXC0ryIVW6k2iX69yZhudqcQiLEO1TcIqZE8p4p7k=;
 b=JfyLMFlTPo2FEWHRsefKYD4w7ZSe5HjsnBywJd7mXNAaJYC6CZ2GjNOgcyOYFUsKwyDR/Zg5XqqErtn89BDrpm7n7nILCf4cDG9yrTcZKdw22x1lhrhZBJgaoUNtcqBkAFKKVY3sPjhS4cRlzp80B86jB9hpVkg/Ds2f4L8V/rk=
Received: from BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 13:07:20 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1d) by BL1PR13CA0064.outlook.office365.com
 (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 14
 Sep 2026 13:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 13:07:20 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 08:07:18 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH RESEND 10/10] drm/amdgpu: take queue kref in userq_create to
 avoid UAF
Date: Mon, 14 Sep 2026 21:07:24 +0800
Message-ID: <20260914130724.130794-11-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914130724.130794-1-lingshan.zhu@amd.com>
References: <20260914130724.130794-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 2081ff9d-8603-4a48-c7e6-08df12611c59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: f+Fsza3APl1XwHiVYby9JwUS5HYw9fisb4RJZXfakVMam5+cuJa1XPlzlUQ9Z0KOq/AZTpu5cWB9lFSnDveczeQwbnEybB1Piuv1odLKqv9PrrMLowzRrTR0Xbk5dhOY9+VpmKoT8LkR1iS/SwbKMDIcNvSRPq373P/kzKEMulHiIYg6PZIGnxBa95JR0o0oIozS5sLtoG9dMrkyl0zu9+dVMB1CbRaXfpCSgTvaMTGWoZGmPfrjzFmoOcnskCz1rdhMydDWUENtXx9X7/3soeCwhWSR6ixoyKMBAvoASlpnKixrANGTLcLHina/Se/zBM4OV9bDI+wAaC4h71FRfHSQhdHOZwZl196BnEyXcLu3D8YcOzluXlUOFQqnxaWPgRp+YLdfZCzdkBudJDm4tyVRU7y6999Zy1h5WzGg2sd4S9tc78F3RHAH+mdoDURWJFNEvmHukV05kf29sPTlPLa8bP7tKFY7Puc+rYD8djYp/fpgwsjI0RYpAHxJK8YL8sELi526moMgyoyeZ6k9Pvg48uxxUh1A6sgNAeXZgPRCKGHPNnxQLuhak/ru9FM8RV0xYt+ZdZC+eozb95bkXZGxksrtkqIw2drUBZFKvBOVWjYxf9SuYvFJPGpfc7AF88A0d+m6+EU+FRKcWZWgjiOW5hkjfSwuqSIiI7zOGR9PaJfMeeXjam4abFtcujtqXtDX2vkZpT8ZkalheJgvSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FHTrvvJBNwQunRwUK27s28PTqi5DZ58S9SLLS8m78kLpHKVX6tWgGayrRxJcY79aAaSmO0Jad8g1HtAnGhMMlKiocBr2hLrPywpXSX3SINFh2XcQa+kuTdzX3K5SRZZ6+m+VQN3AFptFbPLFfdslcpuBlKNs74Ei3qfQ0C2MUZFZSA3VoIYyea/TSkeK15rKMM6n72NWg0vrnmYWxUNasE0kkupTofW37cwJ0REOsHZKXyfacwCwRDz1xXk1Yh5rqV0ymHFKDahGa7I9ptbCZp7TnEB3XczngaV4tRQMDXOVnZjQnFi420GLu0MJ4Hi6WFrhWqwYu21NQPwZdILCsj8/uguU6IUNajrsCs/FIOMrbH2dZRx9RQ35wAheVR8sf+dx2wmymV40EECSv0UN5KUd3JluY+vLZqnGpGRoisQJER5fnFDJocjj8rmo3OGE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 13:07:20.6214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2081ff9d-8603-4a48-c7e6-08df12611c59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

In amdgpu_userq_create(), once a newly created
user queue has been assigned a qid and published
to userq_xa, a concurrent AMDGPU_USERQ_OP_FREE ioctl
can free the queue, resulting in use-after-free
issues in amdgpu_userq_create.

This is surely a user space bug, but kernel should
not crash. This commit fixes this issue by
taking an additional kref before xa_alloc()

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 21a9a2138fc8..83e6c87a5940 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -871,22 +871,32 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	mutex_unlock(&uq_mgr->userq_mutex);
 
+	/*
+	 * A concurrent AMDGPU_USERQ_OP_FREE ioctl can free the queue once
+	 * xa_alloc() publishes it and assigne a qid to it.
+	 * Take a kref to avoid use-after-free issues.
+	 */
+	kref_get(&queue->refcount);
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT),
 		     GFP_KERNEL);
 	if (r) {
 		/*
-		 * This drops the last reference which should take care of
+		 * This drops the last two references which should take care of
 		 * all cleanup.
 		 */
 		trace_amdgpu_userq_create_end(queue, r);
 		amdgpu_userq_put(queue);
+		amdgpu_userq_put(queue);
+
 		return r;
 	}
 
 	amdgpu_debugfs_userq_init(filp, queue, qid);
 	trace_amdgpu_userq_create_end(queue, 0);
 	args->out.queue_id = qid;
+	amdgpu_userq_put(queue);
+
 	return 0;
 
 clean_mqd:
-- 
2.53.0

