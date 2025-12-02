Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462C3D1266A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 19:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C580310E679;
	Tue,  2 Dec 2025 19:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A4DLDGjr";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013054.outbound.protection.outlook.com
 [40.93.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A14B10E679
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 19:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZNT93rcbnCdnB6ral9aHs7p1d6wCWU96chNljEGhDy/MHRaSUjGouAS8XQqKtuMSbXzTjhpUealJmHSumgrU7VqjaYOzD6btamrDpJiXwc/zbkQPWmm+0HcqGjFd91JBR/7JaJnn7MnQHmEKb0ZeZKwLl1JJA0M4oCsoIqp1cd2/ArM1F511khzdXac8DvFjvzjqQTmjR1HbqFg0ONnI5yuEcvQ3aAEyH10c9UbsrS7aXLiafCugWcZUw9lFNna6W7Rh6NorZhCMEpquWPE6IMQtLrIagDAfvj4LqbdzzEpDAmjD3XPXS6r9sHWhubPPpcFMBGEUAzSvs6FScRG1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJmwr9HTKcNGwSASwFpOTtBVjUiesPw/LSURic708DA=;
 b=jIYfipohq9XPBjkm+gq/F/xGBwR/GDMs/tUjku0YBaIQwd4fxya42XjVCYeCkXi5WN83Kh+uBDyO6uSY2OOG2Fq1yigbJ6s4xk4RRgEumrTHTpP0R/xT5PXQULJgP2/46pFvb4HzsXUNP/DdUtwXeVUJqLlQ16bGoFJmxzMlRPit1uyy5E9Oe6G0zXZC62WhlPwkHTB6KDhcpjfcRQc0tdQUfci+bDucV9fCP/ttIj1EGKJ7321kFokyOjfeqKBqkwLsgVL8L+VDOQgfzkYl9uysDu5iMzDjtLXEGc1/ymdeoWW7nkAdqC45L4M+Jk0nSyfcFb9beUtvEkWQ/rgRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJmwr9HTKcNGwSASwFpOTtBVjUiesPw/LSURic708DA=;
 b=A4DLDGjrxvivSAvI/7sQHcxnEZQz7zskFFDX+HtVmRdFwXxYktbd4buQjFy7qoCpchbWbxg/9lFXhdvvo7MfwNvLNEwF+XdXO3aJ7UKCYw0KviYlZUT/UEo7hrJNcBN+L7gsvayOZ9QEEMKqEDdx5+YNXNlU/enpNBIqdDK1mIk=
Received: from PH7PR17CA0018.namprd17.prod.outlook.com (2603:10b6:510:324::9)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 19:29:47 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::6a) by PH7PR17CA0018.outlook.office365.com
 (2603:10b6:510:324::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Tue,
 2 Dec 2025 19:29:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 2 Dec 2025 19:29:45 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 2 Dec
 2025 13:29:44 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: don't attach the tlb fence for SI
Date: Tue, 2 Dec 2025 14:29:32 -0500
Message-ID: <20251202192932.2038495-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: b45eb7be-2136-4e9f-553b-08de31d92674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pqhHOV2i7E8JnzHffeh1YxozwzA2v3vxtYgbwL2mImriVvQAmjiAUrMr/dNa?=
 =?us-ascii?Q?8Lrb8cWCF1Or8UJVu4bZTMymCzScmizIigBE+7JscygG0yuI544i54xj7ppS?=
 =?us-ascii?Q?7St7tgDEgmIxPKpDtpfRmD1t1WxS6/8gXS78TYWVAt6mbBWI2tdWozprvq1s?=
 =?us-ascii?Q?oCGEBNeP3+iOttH5NMVyNyxByuagIvupGE5xa6GWFq+hW7axFDPq/YBY29ww?=
 =?us-ascii?Q?ynsvLYBjvpTEhanjmKs69r8w0d4PrK7Nrt2XEC/exFb3p0sEivj1K81ED8hK?=
 =?us-ascii?Q?5hEkXBi++vGl20bP1fcnfTfc6U1ijyc2hd7riqLhskpvHHOr84QavIxMMYAO?=
 =?us-ascii?Q?oup7ELxmcQPRQwj1gx8qCkT5Opt1Hh3dXF5be+GO2+BmrTrCwb+dpsUC+y0b?=
 =?us-ascii?Q?vZVwxLels5yG06gkd4FRtB8V5zOjlLbecXaTCftlRw+z5poP9voO3eqRQo+x?=
 =?us-ascii?Q?yBbilpBZyyriumVSgGVdv5+DqvftRhisak37G9niC9sHoQu6XfBwBWpuX810?=
 =?us-ascii?Q?SQnnaeghnMZZ7vAsg8x3ecyrkCcJARwi9tS4MVYBNbRaguB0gLJPSoyRzOEj?=
 =?us-ascii?Q?FaMXFL1FXRa5CzqcfHV5q4vpPnpar8ij46ydS8QKkeXMVQ/zRvFOnEqS6DOB?=
 =?us-ascii?Q?+36GD6dKY+Qw6cTtDTYZfqoXiVUcYcS01sfpBHlVADjK5JbQuy0OzvdT3xc0?=
 =?us-ascii?Q?6Ub5/7+BR7vZ2yS0HRbTGBt2wxfHibgh1cUvYjLOr1YoKnJkIfE6IwgXhg2E?=
 =?us-ascii?Q?jnWkfoqojXIApvI1vdQAmZEvKkeqRV1jxE8fgbj+rZdTzjeC6vGw2rw41KyV?=
 =?us-ascii?Q?eK1/wPxiqUJ7RWWVUD2BwtMCP7+b3QjhlhbMnDpd+oIluMlzroHs+aaT/VE3?=
 =?us-ascii?Q?khQJfIDCOyY7edeiyWuDqcvEtZlqz+9Lpx6g5ojEdCDF4P9t0sUPq4RvbUIm?=
 =?us-ascii?Q?WxdTOCk8n/Z2B83k/7KASEy1j7yKli1eYBGLhiXfvhm/ll5kEZogHscF8ymh?=
 =?us-ascii?Q?Q3wps3msLl/LX6seizMYS5ibGfp03Ny4iY9KVQYsfgxNIb9eC0UMbJlNnX2Q?=
 =?us-ascii?Q?AvpHnt+y8f6TXBVBuYX003FQXz4JkeYXJFtq7jOB4a/pwux/YbX1yQjojN6T?=
 =?us-ascii?Q?yjzz3rnKI3rmMA0RchRr3iqsEWHSM0r50lWmONADkFnMgDFNQB9xPhX7dQAn?=
 =?us-ascii?Q?Rsuz+LIYhbuQsVYT0bvMNf9ClMTuwoO8eJltgp+t1cSWMaLtEK2ZCxMJCXrm?=
 =?us-ascii?Q?6VKedVoYAl9d8QvEwKFoSYRr/tBuJ5nXsMVY6VFLvlc3z8IaD1dcumDdI2FK?=
 =?us-ascii?Q?w/BYsXnfFcCsx9zUtez3RQ/cJUGiY1ZtaBbypAK6JHLSjAZkQWp5ttyPPst6?=
 =?us-ascii?Q?Rk2h25ObZqxeD1BSg1vG7ELKGeeVZTTPgkWYfRF3ags04PbAgC1kmaiwQc+V?=
 =?us-ascii?Q?CohsDWm4ibQrKFBLF/ysCygoINDSSuQACz/hwSqqDWj4+qlhx2YQGjksXWRT?=
 =?us-ascii?Q?hH6bnzrW8WxyqgU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 19:29:45.5124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b45eb7be-2136-4e9f-553b-08de31d92674
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
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

SI hardware doesn't support pasids, user mode queues, or
KIQ/MES so there is no need for this.  Doing so results in
a segfault as these callbacks are non-existent for SI.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs update")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a2ea200d90c8..0eccb31793ca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1069,7 +1069,9 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked) {
+	if (!params->unlocked &&
+	    /* SI doesn't support pasid or KIQ/MES */
+	    params->adev->family > AMDGPU_FAMILY_SI) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
-- 
2.51.1

