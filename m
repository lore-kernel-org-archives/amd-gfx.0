Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B82C5C25B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CF410F42B;
	Tue, 28 May 2024 17:24:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FzJtTmSp";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80CC910F66B
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACMDdy1xDRz8RKLi1rlF2y4pl6tiUVtzWAhnmb+Vj4fbnP7B5P1jryWQvINxIZvqB1fSy8e5LJxU/syOj8nUyEsNjUm2eQYIV7ITn/yKyC7UJ2KQny3WDTCbU6K5FslSpRAwKY+H46SL+CZBm6VaBra+SMezEZtN6axLtG1G4AKwYEasGrB3gY+pbfNsy68Ex96LzisAz6z11SP/XzmkoQun70y4oaT0oZzWFeyHF7v3WGuHqSeNzA8/RcmqlPwGQN3L7St44g8x0zXysGwE1E/1F9X22ot7u/XZH95HRMYl3SY5olhH7hjTDr5kuCW6agt0C1gA9Kd49ujbmhtUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXU/S++Bfs1+bFKRRiv4aIC/gaXlwo2CyQvt3KzhEsg=;
 b=aRLkAUnMtqnZZSWlXMx8hPAehg5AaHWgJJxm1u7KsKArkZG/epq0jjCQsd/BkdqkfqllUUVZDEaOSzHENuD+hh22ku1EzujpXYDdD7y+KAFwdbXxVHnVY+vu56vslctTrDbPhgF9GX2bnbQnBvDBtYuJRv1tMMrro5zTdNeWYDMcKfpVR1myuub2934sVSjIx4I0fvyzKLo2uDsahLese/mg33s62WZvR+kt1bzH7g3qhhyaJxCCTLthZPIzQluHXLRpcUGo1mG+MDugeQEJLhVm68fN6Ec+gZ2blr2tMF/zXEKmhOMLdjcwX3kHdliH1fRTYrlLDJxcY1hDqATGDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXU/S++Bfs1+bFKRRiv4aIC/gaXlwo2CyQvt3KzhEsg=;
 b=FzJtTmSpxlxfEwiQ0NTjsGwkBWT3LqAbp1hBjPNeFmaY7apSS5vOKynlr+E5Mj1wBfFUtP1uSrLODpVCJ9Wp7hZXsMJGSPX39GYJBCjTQPk4jmVNdPMOoQ2XevYMqvvaBb8b2YT1fV4Wuaj7RxzE9RNUuAvaIb+Yk33sksvRx6A=
Received: from PH1PEPF000132E6.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::26)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 28 May
 2024 17:24:18 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132E6.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 17:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:17 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:13 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 07/10] drm/amdgpu: use helper in amdgpu_gart_unbind
Date: Tue, 28 May 2024 13:23:37 -0400
Message-ID: <20240528172340.34517-8-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: d27b4abe-eafd-40be-eaa5-08dc7f3b0121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wL1oGejBEPl8ECnRdFEaqtJJ3s7MiFA9sSvVflCDgHpJftGfrAmxVBwCy3+/?=
 =?us-ascii?Q?c4VdIkgTkGmvb+k4R7vfh/e5zNzjTvBZ17OAnOcoKixJZz+d9/szIUBNziTh?=
 =?us-ascii?Q?ZOzAO/GVoMaF8OUlfV+GPrszfHkgDcBM97a/ASEWFH6LJ+b3FnsyErbrNd6p?=
 =?us-ascii?Q?j8iktpuZP11daZ6HXic8jhgshWTvMPwxXGUwFd6gnZP+b1LtoqX317O/4PyB?=
 =?us-ascii?Q?iLXeC7DYXdt38SCaNckchg0EATen3MOuSH6Ew6anKpUMn8ESws0wh1EziVi8?=
 =?us-ascii?Q?Oy5OHkoE6DhOmskgMOnJhsKpi9uq/xOUVurRcthglPaf94JAEoKgZrDHJkYE?=
 =?us-ascii?Q?njYkN6gaGFLir4PZRUlw3V9Z6o4xnRApDz0L+YfooV36igNAQktk02m+/mAv?=
 =?us-ascii?Q?qAFl3Dez+a2pzlTBH+26EwfUbJ6AQPb9ymz/nUJkLOVmm5YrjeEKE1KPqW/4?=
 =?us-ascii?Q?tZJXd8pzdiK2SXx0Kg3+CROXeLucJTWeF0L+EwQdP0EblmPQ+uQ+suR1Cz3j?=
 =?us-ascii?Q?9cB3fxp8XvE82Xf7nJ2IiX/nUUXYXkM7o4IeNc2FY9IwRO4W5B+974Ob/Gkk?=
 =?us-ascii?Q?stcknjDs2dSau3xKQgvv3/VqXcEH/tuAE8HlKTorgfSAV8f8TkStl52EB56l?=
 =?us-ascii?Q?7S0U9oO+22CuP92uiYtZOZNafMkvVJl3Tn5+esysgljl3DL0tFI/b5r1jU8g?=
 =?us-ascii?Q?KN6+aaF28UjScNnBumqerBLqfsreVCcWA3Knyw8EdEg7+beew4+UZvdy/uhR?=
 =?us-ascii?Q?bigGvh/BUjkSh4pbd/6cHfweg9JoxV1vnht/hmMKrCTpHVLldA1gfU0fbFRl?=
 =?us-ascii?Q?hA7whClS1mC5I0xu7i6abN4hUTCC6YDc99EDm7Vbub2M1uFMsDZl7vmPqyYd?=
 =?us-ascii?Q?cYYihm2kxxO+vTjaCC6gnckGDmexmncAAieoRZh0UZgy+rWsm4tV05XtV8Vt?=
 =?us-ascii?Q?9gyDM1giY559udum5HFgpA+MKTmDC5+dMfU+ykCp94Ld9w/NY7EHY0FKr4eD?=
 =?us-ascii?Q?yhmHxq8t8TjZdb5Ye5pMJLJpXKQF1ofx/wlMzPdKF7uFMN4jTihlJeQ2nUqp?=
 =?us-ascii?Q?GHRMQcu+7jNdW6M8LBrWE8/3KSVG/rgddkYbWFWwuHfMZNu8IhKbjf/b5jV7?=
 =?us-ascii?Q?kAflWvqfLpe0UpZKSmjalZ2PqDnW6Av7OpoTtvwPEXpc9uycsTDySnZifjNK?=
 =?us-ascii?Q?ZVyEccZ7myTCDEDHhEtFczQv1nR22m9U88V7NO4RCu+sHEtGyfEeFveY1WKy?=
 =?us-ascii?Q?E4IHQnxvtyWW8HNqErbDUSp+S214sZIYzTF76cZC8w0Jxu9hzM4Hi7jAkK2f?=
 =?us-ascii?Q?0B1Oy33apu5bp8RC47yr+4uHjaUF0Xq8f3FdfLBCvQfpsX3jg9GlzeWe1kuT?=
 =?us-ascii?Q?xhrmhqcROkdKOYxwvzEEgxg6fThU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:17.7472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d27b4abe-eafd-40be-eaa5-08dc7f3b0121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

When amdgpu_gart_invalidate_tlb helper is introduced this part was left
out of the conversion. Avoid the code duplication here.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index c623e23049d1..eb172388d99e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -325,10 +325,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 			page_base += AMDGPU_GPU_PAGE_SIZE;
 		}
 	}
-	mb();
-	amdgpu_device_flush_hdp(adev, NULL);
-	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
-		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+	amdgpu_gart_invalidate_tlb(adev);
 
 	drm_dev_exit(idx);
 }
-- 
2.34.1

