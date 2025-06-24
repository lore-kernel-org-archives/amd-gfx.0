Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CBAC77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40DD10E532;
	Tue, 24 Jun 2025 08:45:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FKFvJFWi";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8043910E530
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:45:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufXwOGVXUrIGiA0Ixt7H7/Hi09gtaYzLKXTsloCIlkQihkaWaHFCRmWY2GVJgtHBzIbrMvyjtKwKk8Jsxsg5pLQ9uv0diLIKNrhFXKYws5ebWFNvLya+Hd33t/YPpOTQCei/QgsPZI3uY4Hr6gd5uCPEd8wmhM8gfa02IHWMKzbGV3Tkwkw+qKSxoYztVtLPxjP5dBbWyd//yy4M6faFsWVx7EXiqOc27LVGrWqtXfAh1C8H5XWDtepJxexu0FR75/Pta1ad8Jy01x5A5CsiPRWuhDu/PT2q5S1fHCyNHiSx6RpPWQOgh1Wtmy0QpeOzNdVSHDxCvtMiADw7xlaKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkBwX4bfsHL66lU9elGmfpHnQ0AtrF0i9BVBshlA6lo=;
 b=dkQfCOt9nzdubv5m3R9fHnQrNGSIZRVVZd+6db3mFZMHW1kiKJCg5Zg1C9R1YGJEHnzlGOoZhX2hwlYMnqQNuTeVgQUsep4+Pd4sb1FkEmq1l2sq+J4YF/BdCmGDwuvyDcQAIBlJwFIDJ0nWbUcARYoZ08w+8QZ7bqpbCl3XFNuyQGixOyDYmmqqQje5okEuM50SSM59TmDLQ7azKKRKrKEjh6o6roQ5BHTqbSqe+4hQFIxJ1zK0gZQv5HmgS4cLFdgPgqC4vUUJ0Liji7WhFlwjLmSbHMN3DhYGQzG9ZPt6elcl0oMODl7yp1cDQuza9Vx8/CLjKrNxPrVXsC0plQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkBwX4bfsHL66lU9elGmfpHnQ0AtrF0i9BVBshlA6lo=;
 b=FKFvJFWiHZP3NRQPke0TGMhtwZ2ZuF/qUsT98po3yxeO32h/ZtvIv1lweabdPqj8HC90ObKzM7LNIEH1yGlaWVxreF80FOWEbaF7uaWs26vCM63DQ+8Od/o+/aadTvH/aNIniPUCy50negNDUxXHOv+PfFbynbkUfu2HVuJfBkE=
Received: from BYAPR11CA0069.namprd11.prod.outlook.com (2603:10b6:a03:80::46)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 08:45:51 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::bf) by BYAPR11CA0069.outlook.office365.com
 (2603:10b6:a03:80::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 08:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:45:50 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:45:48 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v4 03/11] drm/amdgpu: unify the userq doorbell object destroy
Date: Tue, 24 Jun 2025 16:45:27 +0800
Message-ID: <20250624084535.1178476-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 149048c0-b7f4-43c7-d0b6-08ddb2fb85c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hxeEKdDqMj0z8iP8Ou4iXuEfW48xAJxOetcorTZqFlrWfsKoq8kHC4p0/b5r?=
 =?us-ascii?Q?MJjalMa0qM5KlEE0LZfdM4R7qq/MtyimmMWojHXGndG8g+9tdYPZBVwrUeK6?=
 =?us-ascii?Q?O9gxXp0T8VHpu/bztlDmy+p2JDTVPdQZFbDtZCTE0P7xBWQpg8VKW+dy4h1y?=
 =?us-ascii?Q?t116e6uh36kC27lTOxUUD2y+idw4Ub/Mo694cW7A2ZGxz7b4ZkiIMbMAm/QH?=
 =?us-ascii?Q?Wr0g+88TWxGClF5DnOffcmn1WYPIZauxz3DYP4I7do9EzPaXjJrA2KOCN7Ad?=
 =?us-ascii?Q?PsuwMZt1wFc2CVNygHj+knvu0UW4UL1lOIPplrGV7o07n2ppZ4l0oLknpoE2?=
 =?us-ascii?Q?zfDQaJ8HWzu9AcJ8cbonlBACVQ9bwTQU1cJNczkhwQ1Ro/P01wi9Z2qr3nZc?=
 =?us-ascii?Q?rvtzHnRu+fA7d8SPWK9yCjJoLjQbjqWqhNe1UjGO1ObyuFkV13PSMnw1vOB1?=
 =?us-ascii?Q?hav1KIsS+ZqNtgJI5zh9neuWaYe8u7IgBWRQ1Pk6V59oa8C8ZE+pzLJz83wK?=
 =?us-ascii?Q?REO1PCAINu5BbAcgENACIUpZzNBFTBN+cxTT3fj/RU8ZtOqLKFsNSYRjDSy1?=
 =?us-ascii?Q?8ZPBQgTUXTvdgHauPoDUyqPsug7DMo7/AIM8TjiCy7EgosF4mC4xDLMHh9bH?=
 =?us-ascii?Q?K0Jlm7obulZa28y6kgjMBGOd2BLferiIAkCe9E5EXnTIodJ/C56SfO6/xIbJ?=
 =?us-ascii?Q?csOPHwRaM6YBg9fOeg5QKKD9t63pZgcypFmZA7vqRL8tLCAuDbiZXAodpWFZ?=
 =?us-ascii?Q?ON/nmgz5IyJUtU3ASxLeCKVuksMSbgOWmSgGRNzw+uLLgGu94Hkwtz8PCn+6?=
 =?us-ascii?Q?zFe6QOu7RgkbLV6RV/g9EhoX/AODPwu7p38RU1IzNDBbHs7bL1EJHigQ0tiz?=
 =?us-ascii?Q?R/hDwVeMs6RucxozUW/NaBeoUBkTLEU78EOPJ8yDNKKWw2dApmK0vY10LjG9?=
 =?us-ascii?Q?SFWcym62c0CNndrh3cJ8VePkvIYMI3H6nzHzHuNwsY3hJMDnjjsbVYxX8ay8?=
 =?us-ascii?Q?KIOeh1yiTjKGXqnyWRVsNK9oNz0Xn5oszy4F6cHNYvmGzhXn5GXdBLzn38hh?=
 =?us-ascii?Q?FvgyOyHClGX72i5r5L2jDV195zGnSFrurxQAZsxEcFRQ+pP99+klrGlsuk1p?=
 =?us-ascii?Q?T/BbAPUtllhRFjCC4assvW5CLlTje8StXKyErCdrcluow4WSAwwbA/AWS1vn?=
 =?us-ascii?Q?nghkJ+OaAyXPYDFeAUZLzZNBsNEuVwdyGAUYs6kz0gxiP2fqafryvdimg6e2?=
 =?us-ascii?Q?RQ+F3wMRuiTWw5HLHTexlMnZY1eoEzXweJxC1G/zwydqVBy4FZcxKThfIOwo?=
 =?us-ascii?Q?lhOYgBv5vQFI6fInAamLapeY3rm555k40B6UiZUlTtaQmSUSDaShBvKSV8Fn?=
 =?us-ascii?Q?40jGuDlj5DyChVsGP2wdGNqQBBVX8tD/dP91hPA926OsQ82Wjz7x7DDq74FC?=
 =?us-ascii?Q?eSEIDov/cX4cv7kWF6/Y1oEtvU/IH9YQkjz5ePwSjissxyf/YuNM6RRZNtH2?=
 =?us-ascii?Q?6xrjQhM2Kq/jfrJry+ChkSsPTf8bCUzImDaj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:45:50.6666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149048c0-b7f4-43c7-d0b6-08ddb2fb85c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
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

Unify and refine the userq doorbell object destroy.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c7c9f9e597f1..acaea4416ed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -317,7 +317,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unpin(queue->db_obj.obj);
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
-	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for unmap error*/
 	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1457fb49a794..dbacdfcb6f7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -336,6 +336,10 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_usermode_queue *queue)
 {
 	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	/*Validate the doorbell obj whether has unpinned by amdgpu_userq_destroy()*/
+	if (queue->db_obj.obj->tbo.pin_count)
+		amdgpu_bo_unpin(queue->db_obj.obj);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
-- 
2.34.1

