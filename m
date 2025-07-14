Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AD2C83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 16:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E7C10E21E;
	Mon, 14 Jul 2025 16:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4jV/AMr7";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C1210E21E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 16:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu8c1gROes1fYk9Mh3PlB7BmSOsHM8EY7LLYXpEEXuw76Z0WQEa8fK7moZSOK3O9cJQGvxvFGDNzHzqYbgakK20+nM8QsJVu7DX4wzLUD8lVn0IWDZwfoyyTGJBAq3VUie7MPLx5doHifPqbYh5kca80gJBynFyJCCYyITwZtrNgwrbWaeIDZ7jHXduYktJNQ9UdZkNhSpckuW19yAGXIsc8b5ee/yxVgjJ7TUcEw3PxxgmJ7nmk2//xIESL5DDsszwqMHbNCNYuQ0MSLJJQrNQsIFHE4GnOtS+FTtCvCNDyUbP3s5lBgcAEI4z750qP4EEoEn3sh+nnfmXSdO4fUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsY/8uk8qgXIDzNUdnyXH5gaeZBN9lfdPEbLybYgqiQ=;
 b=nQI+y/BjEsHrJZwhcmBlXG5yQzOo3xnuq+VHgAAIMf4GOlodjMPPaT3d6OrcDWoDgwPQ6J8ON8JbMhePHQOUvQSQ/qXuf8/BeGQE6HhzmbjdO/nzCATbW3/GZMuEsKKoIWXzzkE8fTA8sy7pkcWTcom3M3LvmMf6pNwvjJg5/2X1ljgmpQretlz/MbJf6q9reo2uLZfRDI6ZXJ+f0qfYZ5DWwa4Y6ltoAax2bFSZLTTphfgVyEwu9NXN2ZA0swiG66Yar7+62zSqiMWShyxWK9W0mT5+3gArAMugznnRpFNN2I5PispjwC5R+Sej4KZqq0RU+QtHh9UzZrVZ7RAGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsY/8uk8qgXIDzNUdnyXH5gaeZBN9lfdPEbLybYgqiQ=;
 b=4jV/AMr7WE2ZNBvcVx4LUlyl9LpijDDe3WPA574y1ZH694Vr5euUSh2xq9vY/7ZgfW2DdmWCE5k/3/D68367cndk585mN4Vs+HFX4mlPHOBf+Lrt2M7I/rrCZUh+RHOQpCL7IGfXxsN/8I0FdJt1mFFD0t85OxztKIruHoy5UGw=
Received: from MW4PR03CA0355.namprd03.prod.outlook.com (2603:10b6:303:dc::30)
 by MW4PR12MB6999.namprd12.prod.outlook.com (2603:10b6:303:20a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 16:06:43 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::9) by MW4PR03CA0355.outlook.office365.com
 (2603:10b6:303:dc::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 16:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 16:06:41 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Jul 2025 11:06:40 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <mlimonci@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <phil.jawich@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amd/amdgpu: Fix isp_user_buffer_alloc() warnings
Date: Mon, 14 Jul 2025 12:05:55 -0400
Message-ID: <20250714160623.1302980-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|MW4PR12MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc4afd8-1abd-4142-b0a8-08ddc2f06bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M089ZCk1sr7wDl38Z5uZjc9bJCTW6AexRSritx4wPapbMq5BmXBzltwvF+1k?=
 =?us-ascii?Q?ba6hYtzPDEq98MEfaa+Mx8KRwG5aU7KjkpZym0hLeINiO8/3mo1INAscHLeK?=
 =?us-ascii?Q?8MrLp23M4kPuNRFY24xlN7ps2Wll3LOJzk3RenHdOthcW/uR8xa6FGxncQdq?=
 =?us-ascii?Q?oMDzifVi0orWbVHDfBssykF3wwkNkM4rloajepBwytfDpDgaZCb7e027GoWz?=
 =?us-ascii?Q?v2BguTFLtoEziefvw5jbhX5eAqPpr60v0EJeoZs2H4MLN7TKGyUQQrc+GBIL?=
 =?us-ascii?Q?ZJS9zB3PFHJawibytwM6dmu9NeTFh2zapKIvjPia9rPM3+1MBh13K4HfVJdo?=
 =?us-ascii?Q?HmPWt1/hxvLTjNvxhlrDQ5aiXtzZT/4JkzmCM51oyqz9DtZRZtkiK0MmELdy?=
 =?us-ascii?Q?jW2UtKDdoreuM54HMAlJxkYOknsxqwmZDV7o6mvXDfLdLV2VwKbyY+ICJbTs?=
 =?us-ascii?Q?nNVFwpAvMIuai0ddDuyl3nTp0GvKcXRAMoaj3w4fEFP6kWSvwIp9Eexb+hI9?=
 =?us-ascii?Q?xmp4TnStVzz3t8payrqCEPCwX1A9f8U3GUlILThD5lVAlNNXlSRXkrv0nWl2?=
 =?us-ascii?Q?wvE1JjvaGChTReCpX3B4WL7IGiudeUGPCZ2pafpw5LFVou+9WLc5t+Je31+U?=
 =?us-ascii?Q?8FQ7EyCY34UZsGD28LYbLdTnN+T6qio2S8UUDx9nWfoIe1s+37JqPt0e6hvK?=
 =?us-ascii?Q?QuS8j0MnCBDiPOH7e+tZvEcpwGyoDiUTGP4Xa/zeK3+WLP2a51Ib8WKc2AcW?=
 =?us-ascii?Q?yDLXIt9R/qrjawyQCDHms+fy/Qe+Fc0rc85bI0aweggYC7a8MVArQnzGdgja?=
 =?us-ascii?Q?2bzt2l/tVAEGHO/Bw1v7gn+j/C2LQsmRkIONwnzZXGDlBQsUpbFaHZTn0Jdw?=
 =?us-ascii?Q?3gd6OOo6snThDyvR4RFnwf1xUWm2iw/UhY4TFmUwuOPMTwc4Wz71Iur7RET9?=
 =?us-ascii?Q?0M886hiZJNCMl9S6eJN2eJBlKjRXumgwCGMMR1+OQ7uUrTv2WlmKbh7WeJXR?=
 =?us-ascii?Q?InV0VlKl234KB2zVop9z0ublmNCbb7LmGiS7xxX7k0vCkcBxWVJqMB1KkInq?=
 =?us-ascii?Q?Oz69caB/MhSX8OnwXwWAUs+9xipyp3rL2x8Q06W1ygxVCc6BQGWCPfqMJCYJ?=
 =?us-ascii?Q?X3husxjDK5mAJLKiYCXyUV4VmlEmNskmwEhn2pOZQMfnZAa5EA7DdYVHNo6/?=
 =?us-ascii?Q?ornMhlK1YLXK7Gx+ZuOPWJ5ZheQxu2BRQEZ/0qxyS82zRNMeAcIm7k3v0o2y?=
 =?us-ascii?Q?sBYiXNDNr+ZCWtkiSRoVOrPLwfm6lzbmxm1tIEwg31Wbi1/5TBQiSxyc+UQP?=
 =?us-ascii?Q?L6UCwdwddqdl3TqvJqDP/A2Ed+zaNoNaPYXBgZBHvMvE8sJaVKITbjGtFnq4?=
 =?us-ascii?Q?jBYyyZ3//wSTtQjx00ZWbques/a4ZKQUtx0CkqT3Bbq2mHbDg/oq0jIJB7wS?=
 =?us-ascii?Q?hFoHcCL5RUKW65+4Xur6CGc1E03jFpdP3tz65libWepREsRWrLo4EnhKe0Cm?=
 =?us-ascii?Q?tyUKOZDbKZ8Uz/z289uSDc0BFcMt0nc5oOmAyZSdmS9MozLh4gB5LROnmg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 16:06:41.4913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc4afd8-1abd-4142-b0a8-08ddc2f06bfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6999
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

Fix the warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c:174: warning: Function parameter or struct member 'dmabuf' not described in 'isp_user_buffer_alloc'
drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c:174: warning: Excess function parameter 'dma_buf' description in 'isp_user_buffer_alloc'

Fixes: 5cab8cc383a5 ("drm/amd/amdgpu: Add helper functions for isp buffers")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507131324.TKf4iSOn-lkp@intel.com/
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index f9cabeae1c717..9cddbf50442a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -155,7 +155,7 @@ static int is_valid_isp_device(struct device *isp_parent, struct device *amdgpu_
  * isp_user_buffer_alloc - create user buffer object (BO) for isp
  *
  * @dev: isp device handle
- * @dma_buf: DMABUF handle for isp buffer allocated in system memory
+ * @dmabuf: DMABUF handle for isp buffer allocated in system memory
  * @buf_obj: GPU buffer object handle to initialize
  * @buf_addr: GPU addr of the pinned BO to initialize
  *
-- 
2.43.0

