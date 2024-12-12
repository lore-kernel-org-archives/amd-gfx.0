Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6DBE77183
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 22:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A13610E305;
	Thu, 12 Dec 2024 22:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n29R2iEK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B28ED10E214
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 22:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHBf2DzYPW/cMmByWrHCvDr8I6qRwHehNZPvqCtjgdagR584uWeevNqGJC6gFuqGA+ZsxEGt02IH3jR35XCQXvw4l+Xx68RmgL1alyO4Ra9B3gFYX+B4d3xPHpdzDUxecBJz/vHbzVz6C2LT1LquGA4StYD7MnO9aWMDJXVAiHSv6zMUAMBhvNmcd/ZRTPZ42Ym5Me26vsCy9KIDKcr1C257yMYu+4uaRQUWLzLlKixB9LAFL0Qoyl3xS+zM4BkAHMpAGp+7NpxqDsTb7Jrz9LIqu7ZFI0inhqwV/uuReVAhhk/x2FVSmMOasUT6yq++g14RBy5f2goKvqkjFhIlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sy+5EPf3SUrKe7ZU311Oo8yXJe5Ry8iNJqn80pLdSOQ=;
 b=IXe31W+fMnaak/ytCENt1MRljl8+QUas6C6QkHUgXneP8260hG6cJWleB9Ck53K4BQZ2HgwvkKc3AHGT7VJDK5u8zeJJ2yVpm0MBoIvOD3o3WaaZQCFUTeSqbipur6PfkhpUAdkWCk0yDjyKXeaHjQMQs7gUaPu5ARsTbSajnk3A22bA7xdlw4CAekqf/fUgaqTGhVHvLZ3lIFkMwQpLkqKzHHkOhFqcUTO7NnWi9VwVXNJO8WxHaa1E9RR2QzO9T5vpMRhp6qx1ObUTJ/11362GuQ2utrIK50OsLOuiegk0PS7N+/yDqaKuLt0XX6mTyFVj+KTozkigddAPPJL3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sy+5EPf3SUrKe7ZU311Oo8yXJe5Ry8iNJqn80pLdSOQ=;
 b=n29R2iEKmyC+t6WFf1/T8lZ1SeYLXxLBZAaHaTWnCF7ivl80XuyRhaIcn3svxqnzPuMX6EJOI2Uj+sQs1WHMN9fBQRZyxZaYr9+flmi/0FDan4vi7aWRQbIT95NcqnltTa89HfHhccjJTAUj+3Nj+CX1caARvJWhSue5rMW/tbo=
Received: from BL1PR13CA0260.namprd13.prod.outlook.com (2603:10b6:208:2ba::25)
 by PH0PR12MB7958.namprd12.prod.outlook.com (2603:10b6:510:285::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 22:09:11 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::13) by BL1PR13CA0260.outlook.office365.com
 (2603:10b6:208:2ba::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 22:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:09:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 16:09:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/6] drm/amdgpu/nbio7.7: fix IP version check
Date: Thu, 12 Dec 2024 17:08:50 -0500
Message-ID: <20241212220855.790502-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|PH0PR12MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0891da-33e5-4164-86d2-08dd1af99b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O/O6M3yJq/rNoklXeHuHr52pvCOwxKsjbY8VnZoe6CpZU+Nccn+qkZkhUQMX?=
 =?us-ascii?Q?WBbgoYc14RlfcjncoU4KhYEpfSW3GuEjgxPlzPaZZRCk5d/Usyow6mtQ8qz4?=
 =?us-ascii?Q?+BdNNUuZae5T9lffWb3jCMXXPj+8q6yyNV0whTPeKIiS6jrV6vfqx7xAdIdK?=
 =?us-ascii?Q?XrWDZFMpnXU6PerxHwUWDhwuQImStwypYzpcZPihhH9t2X66a1/qOrzmyJuB?=
 =?us-ascii?Q?DGiJi2kELMKSdtw3aMhLyWwS7PkWKmoXT8viNIhp2cLTc2MlaDDt59p+4nLL?=
 =?us-ascii?Q?5fmV8lM7r2SSrNDzuXglicElk2x7KqHZqZKcldRk6sFxIZTPSl4hhbfb9x0V?=
 =?us-ascii?Q?0xvhqdwKpeLgk+RVm8AFEvvaTqyZXNd6yNuA+O+0hr+vodaNQ3pl89a80/0w?=
 =?us-ascii?Q?zJyUIRueunhAvdGk0W86TpJzUYkCU6t3UL2K5aRYLoBh1u/5C6EhLfEQ/cLB?=
 =?us-ascii?Q?fCBstt17LhRclSMVhwmOXEp3JQz/2t0xyPtVTYQg5oGY1ktXn6oIlgkepf36?=
 =?us-ascii?Q?ePmW6bpDxIZPOm3zSwOwLwEyOAOpNrXmsthD/1bThjIfevTv3RZ1tiHeimtF?=
 =?us-ascii?Q?CPo+jqx+qFhtfzGPSvn3z0RqYm6rLpY2UJsqcFN0JByT66u2436Byr9UrDcn?=
 =?us-ascii?Q?YJUhqeBY5maAqU7IQFBnO9bUShe36PqoFvY5CpKWPUFEKxhR09R3f+erKrm7?=
 =?us-ascii?Q?fNdxCJl1jq5o4Dks5LI/ep5FAJEanMEJ8KghvUJYhtmsdoKzTg94J8MM5tSW?=
 =?us-ascii?Q?TIwxaTjLbmYb7r0ZJXyXwt4dUvli4rKfWqGqjw1Ace5dphdCRs6+I22g+xDs?=
 =?us-ascii?Q?xejZYM4iWR0hJuKWt9UFzas+GOndTTbel8UEb/IlaCruchMhdlGaUPSr/Suh?=
 =?us-ascii?Q?mAZy0krVy8LJZuTNkAXza7ZB4bDtF5Cpi8GiKqIdryJz0Ym5Bo7l/Pm8zWfx?=
 =?us-ascii?Q?5gMitWu68pd+tc3xO9oIqGsM9d8PDw/XvpZh3aT2mZqyvTxk/Vm0/toJsXrG?=
 =?us-ascii?Q?84VSLnCfup8QvvCq9bA0PxA+iO7Fzz3jXBOXQ1XF/5RyRKzKsLiNf3bPs/1c?=
 =?us-ascii?Q?c44SasJtmYtfxVFyfCbJTNeOhlQ95KFhruh0yK5qaHu2BPxHKDSMQgJrDsLJ?=
 =?us-ascii?Q?AiNAQIg3v997LjphNt1buT4O+JEvVMLhEtVbz5wfnGyWGsqZ/5htvFKf/ACR?=
 =?us-ascii?Q?qN3bad79vVKbyNT9uDlcCLBCbqSX45AWPd4UhwE43J6u34TxwuOC9V16NEK8?=
 =?us-ascii?Q?gSeCkbFcS0he7Bqb2oCUoVf+0zdsKSQVbmyb73C7zCUN+d92EEM7PxBT2TW2?=
 =?us-ascii?Q?ZVLg8YhxfQZyPZdrBKiaxJdqTeklSBxJiadfiyYsbBGtA65qwgl+CueoM/5y?=
 =?us-ascii?Q?6l3PrFRvP2PRH88WjHXnAX2GSI0vW3oeIeiUkn3gUC7cFrCz1WAfBAlk9cQO?=
 =?us-ascii?Q?SxJV6+WVyFvg7egnnzTcgRLwmCUap2bU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:09:11.2875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0891da-33e5-4164-86d2-08dd1af99b70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7958
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

Use the helper function rather than reading it directly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index 1ac730328516f..3fb6d2aa7e3b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -247,7 +247,7 @@ static void nbio_v7_7_init_registers(struct amdgpu_device *adev)
 	if (def != data)
 		WREG32_SOC15(NBIO, 0, regBIF0_PCIE_MST_CTRL_3, data);
 
-	switch (adev->ip_versions[NBIO_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
 	case IP_VERSION(7, 7, 0):
 		data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4) & ~BIT(23);
 		WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF5_STRAP4, data);
-- 
2.47.1

