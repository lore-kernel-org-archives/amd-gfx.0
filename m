Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD429CA0FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 07:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5651310E5F6;
	Tue, 26 Aug 2025 07:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vLACkmbp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C139C10E5F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:47:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcnqrLXSuVIohlFn8EBhnH7Gu6tgXHt9bfBWYokdI97qW+BBjg8Lpd4rf2znFl6p8wOrKROF79kJBxrdIsIDXEP/ou+T+FVxZEgElCeKh/32bhWoU4T7nMUIK7vy9G9EL0qwLEdBD3gWAx04JeKDiVc92Sa+tSlQBZtyPifJE6/Fam4z2uXZKl08tFvnUBA3flkcwRVtzeOYkaGd6Ft3QBhsJg24lGGEjXOwXidBPlDCAObaZWD41zLn1vAj4WGKwLcR9/Q1DwQfDKSVXskYtMGXL9HjXhUADFZ76RPDxTqPH+2EVxTB2Cw7lJUAK/KoMnS7ZgJw0I9hHI705il63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/UuEIhPQ7hYzNQrP6uhCHqrFELrDunHgeqg5dKW1Rs=;
 b=r+MjNAN1wzqpcqGt6oP6nyT40EhrIxL0zvFxLRLMjs+Y4iHePBAKgHEdNoMXyGDtRbRM6W7rE2cfJhV5ihCNgLe5aqBWO0UGupuEc2Ezjkn12vuQxftRTo3KlhJYN9cabfRBDdItw4B/q0qVG82ixAWTt6qxUMN7+DLqiniTKLdiuSYwpSV9JCfWpoVCOI8PqepEx+s4nv7qTiDjltE1+EzVU+cb2h9vzbeNHCr0XTK+cJdNSeEY0h+ra9n7Zfruc1BJI9iqZsnjed1YYNG8Y0MEbDOCMOE8WT9oU0/yVwh7x3Y3xJAAOF4TfBdYhMnIMLxOwC1WdlTb3Gpcbpd8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/UuEIhPQ7hYzNQrP6uhCHqrFELrDunHgeqg5dKW1Rs=;
 b=vLACkmbpXH15+wtCqaYwGWGuKiCoJOZv14lPbRmUmSyLsjM+12kETZnRd7rmHYNDtihzuD+5QNWjbH+qFL+kmQSLJwqTN8Q1gQVfiwEotfJjsEzUxTbUpcDg1bQZc9C9mP+kV0GIaGRebzGP19pSLrQlsOVXSS9f1GpVhXGfP6c=
Received: from BN8PR04CA0011.namprd04.prod.outlook.com (2603:10b6:408:70::24)
 by CH0PR12MB8463.namprd12.prod.outlook.com (2603:10b6:610:187::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 07:47:11 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::61) by BN8PR04CA0011.outlook.office365.com
 (2603:10b6:408:70::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 07:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Tue, 26 Aug 2025 07:47:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 02:47:09 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v9 09/14] drm/amdgpu: track the userq bo va for its obj
 management
Date: Tue, 26 Aug 2025 15:46:41 +0800
Message-ID: <20250826074646.1775241-9-Prike.Liang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CH0PR12MB8463:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b62eb8-058c-49cd-0270-08dde474c444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b0PjzGL7u1i8IiVdDQxdpmW2pzdjVVl6Fy38dhOgDGIiOgWdmxF6VWjRm87G?=
 =?us-ascii?Q?5YRHiZNWEXCbYbKG/pTuQTeJw4TKzJBQI3aJdkaEG2aNktDQcLzXnH+zFciG?=
 =?us-ascii?Q?oMN4gOwJbii8pSP9pUPfkRYkLeLEBtG8KGMOyxfFyzn0Eq+796SnYjPd9jCA?=
 =?us-ascii?Q?893N+LXfOdPIlKMh3HSfHwGgCQVPfewMKciYysFw7Y4fwYCIvdF9ILnZFU5q?=
 =?us-ascii?Q?0EJbbgfGFeU3hpHzZcRCGhvz1LYIX8Sd8la/8Xqh5LsfwRCYNNSqK9iNC3XX?=
 =?us-ascii?Q?ppz4nj45Kc5WJEGSKKq6BnD71TfAPJ4gl/wYvZ97bJURk4rMy+9w3vZt2XWC?=
 =?us-ascii?Q?OhCgo/DXNTPzQHeWjO/+nJZLH7+7ZSHbSBFKknhM3hxT6ohpYYy6b+EJKiku?=
 =?us-ascii?Q?eVngZtyBuCVfv8GZvJuTZnGXQ8H9QKZwWSHeGe495DrPmtX1dMgunpWCjybc?=
 =?us-ascii?Q?ky0P9rnogaaMBar6+bfOHtQriBdRN4xsO2tzKous4zm8040KgizDpTPRPzg+?=
 =?us-ascii?Q?faKZDrPP2oReU7ufPZdZSxpKH884NpWsuO38cbBGcsXo51sX8WMA3GaaG5d5?=
 =?us-ascii?Q?VzjbDzL1d+Wu1TZxNmcZS/qN3hqOR5bnVvQHPWUJyHt+PVN/8ItjRJKdoxh5?=
 =?us-ascii?Q?yTO2taU+JRCY2ldhaE40GMneZMor0V2+lSLixMD16850FcDVoqmhoPh4Q8oK?=
 =?us-ascii?Q?lQSVMGqhfc/aNQp1y/zyKgc+0qEJF+dqLRMXpmW6+H4W7pmWUYvPCuBx2quU?=
 =?us-ascii?Q?AT9KAujAGZ1ele/iF2go6Qne/AHVaJfQnQ+JyRzsMLw/NGCVOhtdZMTwlb/T?=
 =?us-ascii?Q?d+WDY+W7HbkmOehR/rbN1cz6Xa+qnndtelgTr89fquYmvvsPefHuYPk/K4Zk?=
 =?us-ascii?Q?U3cRZcMioXWauhsdrFJ4haNWQQkfwBbhHqVWqSUVfjjltoIC3evJrrvCq+Uv?=
 =?us-ascii?Q?xd4XiyMORiysQLu+5kTAEolUXyJkUHO3iyP++n0LnDxlVJsVGz4eeLshUDW0?=
 =?us-ascii?Q?JtWBKawH8mEsr004qlR/bkrCKqVouaoth07WiHp6jvLGue7Mja5obEtCo1BM?=
 =?us-ascii?Q?D+6xVO5+lWTioT9d2SzmUCXjA+N7x8PfYQiUBwRGFLi1N2xd5X/Fn3kZizfD?=
 =?us-ascii?Q?sotvhpP+EW0TITr8AfW6PoV7ZscXm77RFlzz5SxJ2ZiwohCzvN8wi7MmcETf?=
 =?us-ascii?Q?+pgW91RLYywAwLz1cjZGO5590uP5djtxEP4Xpe+OH7Oh4VB46ob48u0JnqHs?=
 =?us-ascii?Q?GxQ2goS6iDydUXuUVvZhdOgVeWQ+rxvhZlA/+J4Upbwc9zLXofpsgaupgaDK?=
 =?us-ascii?Q?ORRwAOdD9XfI3+2Z03r6+Yqp3ajM4RBr0AYzKZ5k601FzXN3Fg8b9v07kCiy?=
 =?us-ascii?Q?5SiUEETHKwIWBh8cIb4wlp0Nz102d8JcpipdVrKCmfEihEqiVWUWCvM4q86X?=
 =?us-ascii?Q?EhWv6jZhKkzqk5hbVcdqHG2A9ZUc01MFjFFV8/22f7DH+wzLLEH+Rklp44eQ?=
 =?us-ascii?Q?vHu9KK7MyYz/jC32ecFddAZ97ZMcyF8wBXTE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 07:47:11.6161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b62eb8-058c-49cd-0270-08dde474c444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8463
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

Track the userq obj for its life time, and reference and
dereference the buffer counter at its creating and destroying
period.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 562d12f9d0d2..6cdfeb224f6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -306,6 +306,8 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
 
+	/* Drop the userq reference. */
+	amdgpu_userq_buffer_vas_put(queue->vm, queue);
 	uq_funcs->mqd_destroy(uq_mgr, queue);
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
@@ -646,6 +648,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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

