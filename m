Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0BAC7115D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E3510E3D8;
	Tue, 17 Jun 2025 03:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JxVGio3Z";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CF610E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+s7003/7HbEGTda7NXI4VQWTx3VCTOsI+EeDH4aR0pf5XpAVavJTHWp2GWqOyBWOOIc7TosLOEvZsTLtO4FyJsnvCE2Z7VTk+wmdFkFKjW5uqr/Nsa6nRz+BZb753AV+NJ6F0OrlE7dLB5taSOnBmZ3yEm+0pk688tRgjPNSVHu03CDdrizVdEsJjtSa5onDvYWjwL2OsEoHHCs+L2Yp7mWWl6bFhPYYTsfA0G80V0FnjGyym1T4sGlOcudvlM9+g3hpwTssQijaz4ZybDAJ3NsXtxkbxAJSdY5qZgPEu8rbe7YKy3e8sOvoO2IEzGWzXbntp2GHq8gOnEfJpi+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEjkTogB1DAC6UTL235gEgfzXABqb//LjEWchGIw5K8=;
 b=Jy8dmNuvY+fg2lYHC5RVIeYMgQ5y0n9m5ndcBBHRnqclUiBN7Tj/BuDmxu9d55HPn5DyM2kS7pJSQ+HqmvqnUH/u+mRIGEo4CwWBKZ9BCIjyobeZMgDZ70iYHeedLAKngdl8mJc1JrLg/NC7P0lDCNgisoBzSp6z8kqzbrXhV1oIy9Ps09/yKz6bA4Fsn+JU6e8dW+2HrKM/94tm5P9j9b89EVSWQf0my3w/yDaAnyDY2SF8/yuCLYFXYOiP9lCgS7zT3/TSvKbndtlSGLmIngyiCdCOvbLJbtPRMnlB07NWjxr2A9WyIV5ALTgxz2HFwqvecKXQZFCf/ed6z7imJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEjkTogB1DAC6UTL235gEgfzXABqb//LjEWchGIw5K8=;
 b=JxVGio3ZPixhbp19hX8nYsoC54gboz8Dn/S4gK40Rsd7djYrKrDTvQShrD8cjm8CV//66JF9yjJbwxnVAKw3359tN0v7DjoqfvaG8xjpVlU2ygqTTcxS46/tA2HLqyZcbMnSfXoY7xd5V/qd2Mbl4rNiJoIDXrZqoQBxCcDxbaI=
Received: from MW4PR03CA0026.namprd03.prod.outlook.com (2603:10b6:303:8f::31)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 17 Jun
 2025 03:08:38 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::ea) by MW4PR03CA0026.outlook.office365.com
 (2603:10b6:303:8f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Tue,
 17 Jun 2025 03:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Tue, 17 Jun 2025 03:08:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 22:08:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/36] drm/amdgpu/sdma5.2: init engine reset mutex
Date: Mon, 16 Jun 2025 23:07:46 -0400
Message-ID: <20250617030815.5785-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617030815.5785-1-alexander.deucher@amd.com>
References: <20250617030815.5785-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: a90925b8-0dc2-4d0b-3fd1-08ddad4c4127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wEPqIoQvXFmwSdyeioWuOB8e1b+zpLIiy9WgtymbwAkmbXxXwSH832gQytg6?=
 =?us-ascii?Q?toOxemyA0EsX4+zwAZ1I8j+UEFYka1ibJ+uG62ibLlluWx1Tooi3HK120G7/?=
 =?us-ascii?Q?DPZTGnUOgV74ESsjjtwPxktQLKT4t3ldHlZbo/dHSRqGnNZN1+5xPz9j2mf3?=
 =?us-ascii?Q?rZslk2rrav0QGkJt4NTrElmbOe9nFklebigZ7hUDqKa+u/KE6YVZ9jFDtDto?=
 =?us-ascii?Q?h4pOFN4clVwQwqFiOZnHEWJpuoB+BoQ+HBmF4NU/pG+2iAlnLo6JHyQTiA4X?=
 =?us-ascii?Q?+XWCCCKEpG1XH/PiCLeILCkfOBh/4iKO7juoiUHCVSGVrhSD0gAQKVyVz2JW?=
 =?us-ascii?Q?YxrmTDOSMZsIOdhn1wYZccj5lDJM96BGAGf+H3rGc9sQJsY77XxTGa+a3WRN?=
 =?us-ascii?Q?xmc5baBQOxmbnRi2rLeZ4FeLEp3a+sIbd/EE3MtJkAOU/ypcOjaHf6YUPaG0?=
 =?us-ascii?Q?uUCTDWfR9yuY4T2A9o+ICSzZ3UYQKPhJMZYK7TvfV0+Q8lVdo7XNu0DbhOqq?=
 =?us-ascii?Q?ZAY73dLLxh64jwzBxw+UTHTeTkWoGPbmY1NTqnchi0bVRnvEETlNCIo6onpP?=
 =?us-ascii?Q?JtSUt7CWKhLxvLnnZoyWF5cKtZBc9parsFaI32HOGfXXaEr3gdK+94pPgpkW?=
 =?us-ascii?Q?yYqLtFWDDUanWHAM3CUsPNui6R5f2dDs+84UYSyv1pQ5BOp+tie8EPGJG5Ye?=
 =?us-ascii?Q?g/bBhAik6+PmTMYU/OewtHBLtwVlbp3ER43dsicS6L5QbM2azxSg6TVeoe5a?=
 =?us-ascii?Q?0X8umlnN0Mz3A3+aR3ee/EBwFciJYeuMW6txhYC1d6OmHLZZH2w8xyziaONp?=
 =?us-ascii?Q?rU9q7hZH6dwZise+/cq063ooka4TdTbxjbt7cger2c07mvjA6h0fHXLcYFIk?=
 =?us-ascii?Q?UQQUyo1EKJPRBY8WLYt8rrLJxCMq3DyyoFR8paoQTr5ohU0NYj+QXNYPn6+y?=
 =?us-ascii?Q?cy9SXX5hR+XVpief6NBtIOhYQ4cxQsQUTuNCHJywEmfjGrDWvYewi8DTPNzu?=
 =?us-ascii?Q?buqqTNx56Bb5I18NbBEXtuHe50xvu7F5HNmVEa9vZM//y8zMQfw5Pi6GPwBM?=
 =?us-ascii?Q?+HRRgpja+SKtJ0NfMsv7qRoKWR8+QW5qkoD2eYc/Va3uj+ZlH0h8oUvyu2jP?=
 =?us-ascii?Q?eyEWcvLeIjSwLBMvV2yFbzdRm6aaiLoCy69wDkVQpePETLm8LxN4fGAVoxm3?=
 =?us-ascii?Q?df6eliRFUURRU9NpA5ydQW/ydGeA1Gt8Fn+38f2bBnf4lr1YrOWfZJBppVgg?=
 =?us-ascii?Q?piBsBBOj9hNxXkfUQaKMXIu0cZAhFYOfwmnwIgWGORafpyJvxIMtxPMLJI8a?=
 =?us-ascii?Q?+ehjsGUQbt1mVnXokB0QDmQO7+YfnSfxbM6hxhe0hnN9BgXegwOriH6/MSvg?=
 =?us-ascii?Q?utmya36YaR/G+27BxotXlTIN/ibprI+VJRGX95PEhQW6OQp6rstNlHbU6nRH?=
 =?us-ascii?Q?8kZlM0GfUw2hgEoZJ1PZIB5cAqiFzs7VS1WqDk4opx2riT0qEW6wRWgDjNLG?=
 =?us-ascii?Q?qKlQVy7MLCioN1DDi4kpOJzskFja4LvpnDnh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 03:08:37.7336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a90925b8-0dc2-4d0b-3fd1-08ddad4c4127
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746
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

Missing the mutex init.

Fixes: 47454f2dc0bf ("drm/amdgpu: Register the new sdma function pointers for sdma_v5_2")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index cc934724f387c..0b40411b92a0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1318,6 +1318,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
+		mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
 		adev->sdma.instance[i].funcs = &sdma_v5_2_sdma_funcs;
 		ring = &adev->sdma.instance[i].ring;
 		ring->ring_obj = NULL;
-- 
2.49.0

