Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EF9C531EA
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Feb 2026 23:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D759910E012;
	Thu, 19 Feb 2026 23:24:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BhEoV7zv";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867B310E012
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Feb 2026 23:24:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2HuUgrO39F8I9FYh2OPSrOx3ZTsLIooUnphOq5qqLNOiyQCDUSD/IvveFIoNZgLLoaiKYzv7Wwj16WuLgyGV1zMZND9o6lUN8LD6NmYjPK40ZmiDt2VDND5OnMoUUIaqcn0j9RKO8K8IA6NRopV0YELx3rCwF2EfGMYCsiSg7pyws3nOjSpDRjO8fXXGLzXAHZEEkZ/5koyD8W8+OfB0QN5sHSzT4FCf016dgh8bP+4CFiljDCfWqdGhRvnkA+/SZOc9rREWNzTaoXFZuljWyxZv/PUpbmd0H7aNFEqIr+ZvADskMcLO4c8EsHX1xec3pH294TWPirWRUkOWXMo6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxN9dtwcx72PPIcB0eyukD4aQReH++F88NsbkIL1w6U=;
 b=BzEtIFa7owY70FA8PVzjyc3t/+J8HalyhuYostbWkmhv4XY9yTdiwSZn9Lx5qUudUEYwdLUBcr7HcBUejheP3+YWv0zl92+g4aCJggYSo4fXCcG2Oz5Pdn2jz0i7IcXJaq09GQMq7hXZaK+XUPLY6P/V1+4ZvKVJfl8pUJsx1gN6hzLSupCPMZyj+asAm4q1s7QSFCKtKUO4sZybHXbBZ0L5R20nfCC4Qzha6wExUdSxcY6L3yBTIqPPtPXfeIHSRsoko2wC9MwTIhn0w+Yn8MBEiZXaPI4neKhYgopTj7iKlFQLk0J3smVKe5AXbCnVyJ449tMEnNsMTSFpJj6UHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxN9dtwcx72PPIcB0eyukD4aQReH++F88NsbkIL1w6U=;
 b=BhEoV7zvGVFdK6gwBRIbf1AWsj1YvQmLyNB9KpMMhc10/DXFYAuWFh14hPdk/vfnPHVJVoqNkq+B/fYFtfKfA7YQfnykYv7JGm1YWr594rUaaAKsWtDgEB0UFQjGVbytNH8WZFRb+IWqm2cL90P7viB7+yD8EPkP4wVniu43ESM=
Received: from MN2PR18CA0013.namprd18.prod.outlook.com (2603:10b6:208:23c::18)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 23:24:47 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::31) by MN2PR18CA0013.outlook.office365.com
 (2603:10b6:208:23c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 23:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 23:24:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 19 Feb
 2026 17:24:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Feb
 2026 17:24:47 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 19 Feb 2026 17:24:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx10: look at the right prop for gfx queue
 priority
Date: Thu, 19 Feb 2026 18:24:31 -0500
Message-ID: <20260219232433.31453-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: 469b9d2b-ec0d-4e99-400a-08de700e128a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ruk7hgmGWIDsnRwaKwFUVYJKDwaDMRU7JQQ4QCojnTcEvy0rhzy3FR2F5/C7?=
 =?us-ascii?Q?2aPjY2J/DzlsNobTJe6IoaW4rZdve0ydIrApeEfxWEZxER25v/AmcG9qpHpo?=
 =?us-ascii?Q?j+mUxAcIHyr1I12kRYgi6d+jd2ekL0ADQyWBOo7Y+SKvnM5xZe9ukFgqW7CB?=
 =?us-ascii?Q?Wr799Vhjoy+Eli7pjv7yNdB89PHQB5/R8jIqVIBaQ/cEyLcr3dg7l4cZ1xDn?=
 =?us-ascii?Q?5nl9pOFsj//nm6wQGMK+lohpDsBtff46vDQZLBbalGdyXpYDL/ydpmtG0hin?=
 =?us-ascii?Q?GFm1UX8yiswVTSr7LhCk2YCxhXh6QIon4N5Zt06ys1uJc7ROWhiE/GSBv0Jd?=
 =?us-ascii?Q?8KeB7JZKn6GNsktW7L6oPvHjAo6Vi4sALGG9lKRD/3j6e60DWFigAXbHnovM?=
 =?us-ascii?Q?LQzp7VlA8N8Ic7lg//yO0vUAJXyU3AGwdyLB/lCstrwRhqz/8FzMr7GW/pij?=
 =?us-ascii?Q?RxGlMymKB+Q0Pgdar5cQEgEPC7SrLF3qgbq5he7oMrUrYNvbBafsAdRibZko?=
 =?us-ascii?Q?1LNuC0NDOWxyQ8XXt2SAG0/HmKCC22mwN+9sq+5JXyoaLmkDAGUYbeWNrf0x?=
 =?us-ascii?Q?gF6saCBsvcm0gVVxm58VJIxZZvtRYrejx9yMUKjhxB5gJRKTwyeZ1eloAipL?=
 =?us-ascii?Q?5dqL20dGyMl7YFWRV3TIKRXS0738Dkod2C9YcxM9a7LYsVrn+ift8tPvw3GP?=
 =?us-ascii?Q?sLrUOA7qx1zmb5kHd5anR+2bRGSialpSqEX66tkbIWdLU0yFPEg3Gum3dfVX?=
 =?us-ascii?Q?3Lgu4liGybNDZk0ltS3aM/e6vmAXaInDm5WCIt5p6z+35IAle/4Rp/wNkPvb?=
 =?us-ascii?Q?Rpk5/1Z+Bj9FhXg4EBDAoDd9nXoL0LyUVtb8HzcMB2/4RVuGyhBZLkPmOgpd?=
 =?us-ascii?Q?7P1RPnqTzKxwv2xRQbQA9b2e3+JvTh8XZprhVgnHKWMJKIRWNtXF4ofu9Yiw?=
 =?us-ascii?Q?+tYpG+YcyJoeloze+Da8mvYmjHxX925s17FftcD4hGpc0jZ7GW1OpW5t8zrr?=
 =?us-ascii?Q?mu8bIOgax6BVZWc6DRZDi5QrhhTSkXZSv7P9y5RT5E7XOszezw7A239nCvM8?=
 =?us-ascii?Q?3gt2VIRAuL8wgLkWgUkX/H5ZBeY9HC8l1P3jZulruTD/kPyMTslBdf2ub1sF?=
 =?us-ascii?Q?EwNYlhliE9b4qzHRNOrzXW0kv4VeD3RlEi+hnI67zV90aMYrWNBCkSq599ew?=
 =?us-ascii?Q?ed3rzHPTkhpo+jbHcSJdsVgOiMCSYqAhoiDJVlpwl6Rk+O1tm8DsmfyGjzyP?=
 =?us-ascii?Q?sCC6R+spg0mghbnyqdhfesqiZc5rZx60PwhJhZtjFQcO2/ySKa2xrT0U2+VM?=
 =?us-ascii?Q?9xDW6fa6iqu/iHKlZr2/Ub7xBGhmphmRPjMH4kz7/HSA0kQ81efHNtoagOLB?=
 =?us-ascii?Q?IV2ldVwth65oOU9e0j0JW7wdxilgMQycmql35cD+oHQSrSAlE+4olyEesDKp?=
 =?us-ascii?Q?VKB0pcQyl02WdsPpd1xdRzgQARlB0KFy3/zdxCuXU+qqW4PzrZfRSpwqW6vB?=
 =?us-ascii?Q?wp4Cnd3z87I9COi7AhcjakvrjoHzG0SZQLCjPr3WWTNh7XL8qIu2OUaH+hOk?=
 =?us-ascii?Q?GKV/X5VGk4IulW8Lze62AWDCPn/PxyPTVV2VzihQBgM95vJ8rY6pT7+DVzRd?=
 =?us-ascii?Q?XIDxFtmOOezJh/aky/3meuc1HarBsdy0bpKRyDp/B76S2vl9Lae2lfu39HsN?=
 =?us-ascii?Q?gEwUGg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GUyVOI3if/fBlLGVv+vV+iMxwBnkYr+17N97McGYdmQbwla6aqxx28fUQE54Ib9BKWBYL3/z/BdDqwlmeV0VmMhR64x+5oPBiREZzplNikx8wAwulMrNO4Oqb2/B9LC+Juf1vPC9FRXeh1gbtIx6EoFx6uYG03uF6E1bXhe393KDUV0gu3ToG6J5vvVzBLzB6/qM/9cX9m6FtjOKqOVgNteX3YvB7J+jJ40vKLcCss3iWV55FlZm/r/zAFHJVSbJ+4G2AzpNzuIx/+R/lqUbDEb5y+8v7JsCMWJwycQyFtffUIOTkt+1wHL8z0i221ZN/ZtnyUwuOxdBQ3OrungQyYXr2KTYMwk3jBT70cvqrH5wenmPeTrVTUoMb2AWhsoNNRR+AaYhLcMofHLmk+M7Puoikk1nfsdbWYPpHs6WA/ox7sCtRCVVDUn1tlWrArRA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 23:24:47.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469b9d2b-ec0d-4e99-400a-08de700e128a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048
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

Look at hqd_queue_priority rather than hqd_pipe_priority.
In practice, it didn't matter as both were always set for
kernel queues, but that will change in the future.

Fixes: b07d1d73b09e ("drm/amd/amdgpu: Enable high priority gfx queue")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index afa9cb46ffd21..1a2deff420f4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6755,7 +6755,7 @@ static void gfx_v10_0_gfx_mqd_set_priority(struct amdgpu_device *adev,
 	/* set up default queue priority level
 	 * 0x0 = low priority, 0x1 = high priority
 	 */
-	if (prop->hqd_pipe_priority == AMDGPU_GFX_PIPE_PRIO_HIGH)
+	if (prop->hqd_queue_priority == AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM)
 		priority = 1;
 
 	tmp = RREG32_SOC15(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY);
-- 
2.53.0

