Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D08C83F25
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 07:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C2AE10E615;
	Tue, 22 Jul 2025 07:47:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TY+hGkKR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3740610E60E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 07:47:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB0qY7x65v9tHGxzQcDLyJSvDWYLzB6gSDKPErJz2/mmB7daY7m+zpq5dlpPqouXXeVVpEu913IGouR/wvSM2p0BrCglIxtO9kr4A5FZHuDzlJ6fYd5E3sjXs5S7kgPYoA81foa7a5gcm99FRmVbckGkJ/rT78qjtC+H1mbplsRdIAlb7z4UjuC4eImOEzGoXSsaeayGWwCfsg/EBn3i7Iyj8ss448HXWzid4y0L1sO0JpmvSgiQiClBcsaL81uZ4BFn8a/eNJ4bqrMd0dRMHvdPELLw+cMJehjlxrRI47m7A7xSjHzVK43t0kAGe8c9jFTAiVcon7rBvXp0veH7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y23nSJv47+Lqzks/VD/tf18VNBUjboxf2cdTaujfWLs=;
 b=rc6UESVqmPQaHGwJ3NoF9AWZX5uhkmpI9ILsJoS/uJplI38Vv4it60R6sOUpCotSuewLpD4eQGW/LmgS44K5pGGGSkzQ9ynCgNWqotDeI3SHnY0ECV/nN87oFaYfWfknLbswFraL5RzyxBeGsJ0aSqG22FYu+DR2JQjnypbKmBf9XudGnL/6xDCMw2Ej0jGONOQvQCgOftutePSLXN2/VOQwRxd7EJmyhAUvf4328hL4kecYFNwHiumWgvUpKxjgW0lCD/U4poru9ZfmzbdT9n/6GKCodAJ6rd21SZ61UM3wZdRVbsC7+DYs4gLAG5gaxUektA0xwcBodg1KCJtmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y23nSJv47+Lqzks/VD/tf18VNBUjboxf2cdTaujfWLs=;
 b=TY+hGkKRa/i8iuHjMklF2GAnIjCVQz3FEh4NSOAVAkvobFIXuFD5SiOvdbFHnJtIDUas7SXKQTwufhXn1+IwVhf0JrAolzRKDsMq1Xq4Kq4v9b3IzGPXNQyIZWyCkd+g92GZ/FXHCDwrHztGU8QtrREbh7EMt6URbkApjUw/ANA=
Received: from MN2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:208:23b::24)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 07:46:58 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::5e) by MN2PR11CA0019.outlook.office365.com
 (2603:10b6:208:23b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 07:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Tue, 22 Jul 2025 07:46:57 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 02:46:54 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 12/14] drm/amdgpu: clean up the amdgpu_userq_active()
Date: Tue, 22 Jul 2025 15:46:21 +0800
Message-ID: <20250722074623.1464666-12-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722074623.1464666-1-Prike.Liang@amd.com>
References: <20250722074623.1464666-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 879894e8-8bbb-44bf-267c-08ddc8f3ef5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IzVj5gFBiKljApgNISbJ6fHWsqZHj9rBSe5gGjaNCVrbHD0eznxwkzXNzBUW?=
 =?us-ascii?Q?EafDrT33QHcISCQud3/X9HFy4gV15VVwp8zLItCUKiHEVV4JKVaDgSSq/cIW?=
 =?us-ascii?Q?LNlBl7kW6vS8x3kbKlpYWi8DAVMQ1bUSkRR1WSfvIzJdmh+rivHKgoPHyL3O?=
 =?us-ascii?Q?114row4Z7d8iLVZwvt/YkKCsmDvTGoAr/0f9YDMOitf31/WisgVAKPXSTgyW?=
 =?us-ascii?Q?z41K36ocItg+EBEkA9KztXEmho44OOGkKugbFv/4rBL8/LuXe5Bu6Hi+jt0i?=
 =?us-ascii?Q?DMZrXbUe1cI/TazDp6W6zj1lR2aJXQ1gFPYDcuiEz+W+4DQYcLYEnOMJ03UL?=
 =?us-ascii?Q?UrmaxngiVFWfDXjycKnHOkqkTHu4VLgaVqlDzUw4z17GW3ustNfoEESCcEcO?=
 =?us-ascii?Q?kDrnRMkKFN5fmyQMSRVPtKH3hgQXqkCdCIIWRwRf/0yDhMAcGUZ+MvsVLD6i?=
 =?us-ascii?Q?5G3Pv9C/zTypT+4IT4FxgWXy223EslER3yIcTDj8h/ud3S59YATCw1STbKPv?=
 =?us-ascii?Q?/XQWJkIWwhRbsVnbfy0fLtlItgkbqjZFXjdq6ZJ0EkPzowNryo07qPXSY26X?=
 =?us-ascii?Q?Vqhstf8HCC1bDiXDjK3QMTlJxuUeG10RNm+E0T32XZOKo0xTldVV9YTw2DpU?=
 =?us-ascii?Q?beHQM+EK/q5hVCJ7/QKn9wqR2XY1JimP8rKS3bSTEYDUVij9vShEhm4eMUkJ?=
 =?us-ascii?Q?yupoL3wxlwl/n9poD4czVY/Gw+hFoRcZnwH9QmHY8vrKM0ykbVFRePo43QB7?=
 =?us-ascii?Q?Oy7HF1Mc+bxGQal9cXjb00rUgwX0ihTZCGBBrlo7zFY5mMWrzzT5O01ApigP?=
 =?us-ascii?Q?2ZOsPrQIzHqv0eT7aGyec2Vza/oSJHnKBOaOzd4j14Xd2hh2GCX4kPbTVK2p?=
 =?us-ascii?Q?BtJzMmdvwZUVwZjA5DWBtGHRE62FaKyaS5z8iLK/Z9Vc9B0BHjOACvJ02OKc?=
 =?us-ascii?Q?Fqh3N62Mds0wsY0CmB0sluxkkk1TdV1zryJz/DDqM/xWanZsM1D3TYnDEFs/?=
 =?us-ascii?Q?d3nC2TBLbBoF37s4+4KPe+aUqR65Ox4Gbaf6XCtLMaTA3t5NLp4Jsf+cKzwy?=
 =?us-ascii?Q?39N7847w4yfV8OmwwenA6h3Wl8KidFeKHuJFVE7+RWd9u0FczJ72dUAu8K0N?=
 =?us-ascii?Q?J2UNQAJFl1t87G2XqeRizXKpnXZOsPS7tldn8bEeznmtxIYfr82kQCCc0L4W?=
 =?us-ascii?Q?zq2UE7td8kyv/S7+NkjpGELnLJaUUoROZDQqQwKxWcY+sudycj0ja17ElDSl?=
 =?us-ascii?Q?FSGMGJiIycUWxx7ghM90xehVGzbU7KUPYRJVpe/hfIUyy+GFRobpBpCvrHpv?=
 =?us-ascii?Q?PLofHs7TVZaq6VXRZQc4aNB7prJOaDv1sbS8Iwv6HxgSVLDrWkrAdvLku5Ny?=
 =?us-ascii?Q?6P2HbUUytGU31fHRFzNObbssS+f/LCtDiQ9IBjgjcIFGUDIXVUwDac/wdXK2?=
 =?us-ascii?Q?i5l43Kdu9KGa4P8vCwGFuZ5nNI+akUV9Am3/MFTc1/btrswoOtbxfAiZytXl?=
 =?us-ascii?Q?Bl0kvQNtt0DXaFLpnPOhH1itxvt65VxVojdU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 07:46:57.4454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 879894e8-8bbb-44bf-267c-08ddc8f3ef5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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

This is no invocation for amdgpu_userq_active().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7d685f3867b1..a41aaf4aaf4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -315,22 +315,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	kfree(queue);
 }
 
-int
-amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
-{
-	struct amdgpu_usermode_queue *queue;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret += queue->state == AMDGPU_USERQ_STATE_MAPPED;
-
-	mutex_unlock(&uq_mgr->userq_mutex);
-	return ret;
-}
-
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 30067f80eadf..cf35b6140a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -123,8 +123,6 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 			struct amdgpu_eviction_fence *ev_fence);
 
-int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
-
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-- 
2.34.1

