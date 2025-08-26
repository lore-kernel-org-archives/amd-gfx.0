Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE176CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D91710E5F8;
	Tue, 26 Aug 2025 07:47:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bn1EmHV6";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B896710E5F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI/fO8y3AsBZARfh5IeVZpZQaoNuqNJys2PDfU5MJpJI8EXC//3VRVAZUsEHm/wRRncUpesYz8m4FTkWmN+FvkaBtUA9FCMwCAT//gQqBY8jPiSqJATPG/pLK6PLK0yGvrV2YF/7mW9XsGxZKmJAtun6ljB/LYq4glbO7qA/FB/OC+9qLGHJhBrgtQQPoba4C97TEcK9lfGjgo8JcCQ8RO2m9+3c20gECDyOU541RbojiLVeJgbIUWKmhNhrTsRBJBE6LrPzN8GTa+i2ZM4X73z3XCMtdxA31OD5seb3AK3hbu5/cGrsOCalin1ZtyWJQerd61dDMgEbuKYV3Jv4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yXxqOg7MHaxzunP4jfCGGLVFOvo533ROdtAo3/lP9I=;
 b=oIrzzjW9rharKwMOfM9NI28Rho+8rg4bAKBOZCVVNBlcuqL1+JJ1Lkdok8ok6sXyT+gdqw4u8oJnK9p2L155S/TIB0nGXOIfgQVWCBKAmjOWeMCcoy2sCD11MTFkAW630VRJxIVNWglZPGJXL9wbiEH5aNjy7cTj0i1rrRCrC8C9x43pkErANnMW0qwbaoJr4T5HJHTrXpbzMKBOCmwMOSLELtfx3RnB8VZBaWxv4yLiXeU793PlykJbyUw0DUSMAbrEJjlPYZDFDijquDbTC5P91T06irtlPI4gOf8ZxopKwlzxkJfEg+1dJfAktsFJeZtXJFUR3pEfgzu9kzW7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yXxqOg7MHaxzunP4jfCGGLVFOvo533ROdtAo3/lP9I=;
 b=Bn1EmHV6kV6fMjsgLFyzbYSAaBKnl/NwIEq+KEXD7DuMD0XI3xQ0AYU2YBCcNBYA6nwB6ns40oq3IEMg3NoY9ssMyVYsNb2UEyCqc+8hcJAHbmK+W8R9rzYx5Xm6ksu3Kmcw8Gf7HTxuZsusu7BHiVC5dOvuOw9hujox7vNOvZo=
Received: from MN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:208:52f::23)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 07:47:16 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::be) by MN0PR03CA0026.outlook.office365.com
 (2603:10b6:208:52f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 07:47:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:16 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:14 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v9 12/14] drm/amdgpu: clean up the amdgpu_userq_active()
Date: Tue, 26 Aug 2025 15:46:44 +0800
Message-ID: <20250826074646.1775241-12-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826074646.1775241-1-Prike.Liang@amd.com>
References: <20250826074646.1775241-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: dab4257f-1d6b-4f79-d7c5-08dde474c6fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ngYbxz3MCgPN3r7NnwZyNrHLr+1mK40V/xwyVYBZAtgo78nWYluUn5k2Fzmj?=
 =?us-ascii?Q?Gqd3LFkXC4doTmcyG9FYOda11EREpJNCnVbnR5CJplEBJe9lZdsbClk5+IMx?=
 =?us-ascii?Q?KBsUWHjwVouYErTHIPN+fvDe91k/7+who+ilUhT1hg/WXTB0+xVseSQBRSLx?=
 =?us-ascii?Q?SNZ1veI7/nNOHY9p2QRmGZ5X32kQ+X9DvEKshA3B6nh1TdKtaq7XBCF+8BnQ?=
 =?us-ascii?Q?L+f493D2+pHB0Kk9hXlKw7YGvDlRJi0TLqOTKPEjxT0wxMPk5GY7xrAT8Rph?=
 =?us-ascii?Q?kHgO7LvWzno2RH9e3cf0Vy1tSuanZQJ0HrDz+87W3LpgEhp+FDXqWSJmTYeA?=
 =?us-ascii?Q?keGQDwNGQMHVeE/eoEDk9g0HH92sI2zYPxi09o6Bet4UJK2rNez1s57duBXc?=
 =?us-ascii?Q?Q2wRvdjW1AHwZAxDD/CTcsMWVs1QweiRI15z9MVgd7xFAPhHdPdkTOIf04qL?=
 =?us-ascii?Q?mGWmhDJP5Yw11cMiAbP7zZan7hAxVmXy2hnOmCRsWRy9zqnNDbGDGi/cTXwK?=
 =?us-ascii?Q?XIYw40E7qdPRduDo7MfvlwL1c2HdH+9EcY0rERdGRPWF56ofCBJy+p/Vd5qX?=
 =?us-ascii?Q?/x7GbdrpTH/OrID7c3EQ6yvX8Ja3ISWOG6BNbLst6x7LToUlFdTh479p2XtV?=
 =?us-ascii?Q?NiY7v6rmconhOQPbxiLZRPRYdtZANoPIA2C8L8T9Zs82ppr/JQSUAo0VpqNz?=
 =?us-ascii?Q?GenYo30W2EiAbJYGnX+MlaVCCJmurltO+rN6bFjX7xyDgSIOQ6IgBl+zJObJ?=
 =?us-ascii?Q?RvWKbLrOC0gyyjX6RgIKr/jntIqDnDNJuvHCyURLYh16nsZnQzx9s2Z117/n?=
 =?us-ascii?Q?5pR947MFN5pLUOfv12uahffhFtOhZJY3BPwv31DeSVG0Hk6IKbVNvEFny6+N?=
 =?us-ascii?Q?PAlTR1ECTtThisSI3DGgRV1TexdGa8TzqQ+mc85FtQ9likSAbOmG+mY/H+gk?=
 =?us-ascii?Q?+gyOdj8wexaRWdG3R6Z8yGOywioZNgEsq+ace/afC6RyOcizMZiaka7ocdIW?=
 =?us-ascii?Q?1JjQWjofyNH+iezU+w4UEyJ2mUcFxP0S3O7H9Tit0QH+k4NXrzpgDA5o7pvw?=
 =?us-ascii?Q?dNLIHSgbyUMxGu+vdFljuXx0rxesRMOMzYFTzhR38VLWMVtInr668Qf0IbHl?=
 =?us-ascii?Q?QvN3sJRprhcPtaCygPxurD8krnNbDLOApq/tVyKO+o4JoOZjdiSHQVLsP6wu?=
 =?us-ascii?Q?UsBXkpYQHa5+jjzAPbcOYreflaYVvdnzfq1M9jElIWr6SV8E9eliaZCjhW0b?=
 =?us-ascii?Q?4VOqTDjAID02Wv97DDhAgWAHHRJSZhY53LFAWLfl8yfvOsbIL9LQGKn+SW2H?=
 =?us-ascii?Q?83FP+hH0Gg2l5NPb5Mm2BlLAUz8zvxnkzIJ7oMdhvMJgrcwqUuzvGJbKBJXr?=
 =?us-ascii?Q?TjdeynmLSLZEjZ3U3eiRgrMxApp4N3+FXb4VYt6pvrOobG6drdVWj0cXRV11?=
 =?us-ascii?Q?3XRHj85qyIUmJj/JCSy2HaDobng8xNjxKFJ9GZqggSdbDkKQj6260vqHRknS?=
 =?us-ascii?Q?l74Z3B6gxBaDI69iRw7e2bSkCRMp1JL5aABW?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:16.1842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab4257f-1d6b-4f79-d7c5-08dde474c6fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
index a78c2caeef41..3f8343599deb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,22 +319,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
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

