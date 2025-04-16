Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6610CC369BA
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 18:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D041A10E9B5;
	Wed, 16 Apr 2025 18:47:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w4l9KvQC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6899810E9B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 18:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQCMNDZl7IHp5L4RSCroIqh40hdK8ZZHFNz0gOTtv+qv770FcmWB/ypIhO7OHUD1Sm69ib/9MV/WG1f/+IgbI18nkXq5WK0Tv04SUijVUELaVCkFoMTrGkZu2OR7RLvgU2UGtZBRAB9ra3SG01ldrugIOwti0htxiBOhJEuBuwpIEDf+/zj2YWiXZNIKHP50fZXSoIB1dPeHW/HV2hO4J1ingqsNTgQo1v1turmy/4P42iSUqRW8pVr3XGP4E6sKQdJ5EgU8QGfTZnS54iN+lWdXV1BsRV5TNP5YFmfiAEsA7sQs5ML8JutM3RcKb5Ij5Tb8OXg/lNXYILE+qPIFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEYSPohkxNMWCROTc7cX3HCaC8MuVIqWvZBCuerP6A0=;
 b=MxcpI5/rVLwwBEnY2Mgr4c8s6qgA5f2ZNy3EN9oQ3zBoubvzrBOvUZ+uZvmOUGRfpiJc1gFR/NA5vPNymd9jD8pl55mZxcfC9F5CXM8hxmNFUQPe+FwbVhfveUC8oB8O88QW8c6bqZWnIf1EC9H/LLG11tVeNEIvJ2foco04V4NEMQ42MaT0ZY/DLQtqvUuFv/eW/JZbKK5bnhomAzzedHhWhxbg02MvW9+eeFcMRy+9kxR3An+PEqGfNYTqO+EFi7TKTrxnjrcxHu3mTnEviYDcPFXavklLzEUB8dHDnpg49ttXvtIuhUFQV9Gpp0XvFl21K7nsu9Hcd0R0njaZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEYSPohkxNMWCROTc7cX3HCaC8MuVIqWvZBCuerP6A0=;
 b=w4l9KvQCokMKpccYKYM8CR98UP9H2ZS+9wFgLkebWlB0sKv5nFymloL1HkGWJZfDc/x0Ut7/nf+7Y7K0k9nCInVLGEBGbQYCn2RLbeLVS7AUHwX/iOup18w1kUFMe7wzTx3mpWsCjjk/uq+o++X6Ed6PnRkNlfAyhTQ5g73xoHU=
Received: from MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::28)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 18:47:28 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:303:80:cafe::23) by MW4P223CA0023.outlook.office365.com
 (2603:10b6:303:80::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Wed,
 16 Apr 2025 18:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 18:47:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 13:47:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/userq: unmap queues amdgpu_userq_mgr_fini()
Date: Wed, 16 Apr 2025 14:47:12 -0400
Message-ID: <20250416184713.28964-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 842ceee9-ebdb-4ee3-8e71-08dd7d1722ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q0i78EPOCDg0083Hq17BmoLKTFhosURfSTu8ecEDIcpTY4DijGzfnqCYPiWz?=
 =?us-ascii?Q?A7ScbV5SHgEhbZWpPLdzenZskMHfqMnqViTaYEujxA4z6QCBQIq0rmL38y0a?=
 =?us-ascii?Q?aIa4Zvp8w0cKs48dklvC8OIykqs0OF4BP31hQuAUaGW/c6E/6QIeD2nXtWqd?=
 =?us-ascii?Q?LZUMNuq4zHAp0AzQzoFJb8f7DWT65HP6ipuVRN1fk3OflS49ufBKPuU5Br9k?=
 =?us-ascii?Q?jVIu7O+D72fVQ+Y+QWISoZ0hVY553x4nGLBMVf+z4MNWFtKMzoBjMp+uFk4Y?=
 =?us-ascii?Q?IA+o8qX9m1J0U7XsIduzB4I+xnGoYiU6mWoepwUasRHYXQ61C20DOkgKqQa/?=
 =?us-ascii?Q?t8A4jH0IsXXPhUBcNEHPMfmtaKBYq89LkHBkEhg51N79K2NrC1WGhfhojEB5?=
 =?us-ascii?Q?jySLbF6B+zGaU5vlXoXIYW+5Cg/sOCvYNbwnuducHjigyJkVMr5STxMksqon?=
 =?us-ascii?Q?s14cAxCdgwd5D+8q/kH7BxfKvmVqm8HaAnygCXWIba4w5/O1V+Is8WfA2Mfx?=
 =?us-ascii?Q?+MwX4/1+SF2UCw+kRbqAOMHSUicYWGp31oe0wTA0gTEi+jPjeEteklhDw2it?=
 =?us-ascii?Q?0b5MfpHk5wv68fxaN2FxiscNQmhBx3B2fBGLyVmoFji7SRUbQP+RFadXPcVb?=
 =?us-ascii?Q?TKjsKa67hBBPm2Hcq2J+r/VWJa7wlXrNh9L+Ir+gecn2WkDaVWzIg+lJrcBy?=
 =?us-ascii?Q?okwsu7j6ustoF04GZLLZd5fw/N7aDo6j+sD8p3VSL/FMeoA7T2/MH6maJYt6?=
 =?us-ascii?Q?gL96Nv7mHURo9PGZ5nN0hjhVO1ztcqFET+RWFZZty5omRH9rXx3YnNZb2caq?=
 =?us-ascii?Q?t0L2arbc/5vVerommGWCX8y/jDojJSlaLQrvnx7R14a4mTkLWkam5NX4w1hP?=
 =?us-ascii?Q?bbIUI3p/vpNYofO2YFbisOWJpf60GHbRmP2mc28goLrrpLVODHLxODVg6f0v?=
 =?us-ascii?Q?1DzuX12rxfmgyMtpjpVLCk5hesJZPs8FO3Utj7FOVEjrn4TxyNfYZvghtYcw?=
 =?us-ascii?Q?zMksimdvuoSnydfTwcCuUa+lbK/PfcBx5DYOWkBgcKJP562QNN65+DFc0SPE?=
 =?us-ascii?Q?JLMwKhmxokx0X2dYfh3VEKbhKLq6oeRVTF+692d2q4WV7bcb8ZiNOyJTnzNH?=
 =?us-ascii?Q?v+4zdgRnOT12jSmPcOrF1MSGOchbFbYUMa8Gxvm9yz+lI5zAdTPRgbraKbrr?=
 =?us-ascii?Q?07EIMYyNgyFzZLo6cJ+mfnQWAX03mJaOE4kGI5v26AJ3hlrHcJV9hXCUrjIl?=
 =?us-ascii?Q?/fKj8yQwVazYVDr+EbrN/5p9n+tWhE3yofcmnFhNuM+YrBQKtifQAMB71+LU?=
 =?us-ascii?Q?f07RM8yvv+vZMJZCzjWzEQr6kmBUJ5O2QmV2jrLdyRF1QnhscBou1FRq3Ie6?=
 =?us-ascii?Q?7Bs8gDhSXYR9OSip1wEsvpBkJxxylKsjwF9SZY6UDkO4RLRs/49I2DbmSNUw?=
 =?us-ascii?Q?RlD1f/VkjbO1BGIEI7s3/mX44UkdWDeAkkkRFqvzqBHsPl0oOpmYPaAu7MTu?=
 =?us-ascii?Q?g3h+zviBIcc8uXheOkYl9c9fdZB/aD0sxtzx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 18:47:27.8745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 842ceee9-ebdb-4ee3-8e71-08dd7d1722ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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

This was missed when the map and unmap were split out
of the mqd create and destroy functions.

Fixes: 5b1163621548 ("drm/amdgpu/userq: rework front end call sequence")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 4f102837ac45b..b449c685302e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -817,8 +817,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	cancel_delayed_work(&userq_mgr->resume_work);
 
 	mutex_lock(&userq_mgr->userq_mutex);
-	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
+	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
+		amdgpu_userqueue_unmap_helper(userq_mgr, queue);
 		amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
+	}
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		if (uqm == userq_mgr) {
-- 
2.49.0

