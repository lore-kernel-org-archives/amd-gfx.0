Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7E3D116F3
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D5A10E4C6;
	Mon,  1 Dec 2025 23:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S862Szh7";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A0110E4C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Goh6tOxwSa/4TQnkNQAJ8cnARcgQMvayRDfKtYwmCoGG1B7/I7As1eSoQeNUi/wVuhWg+Xj7cv2nnOBbnzMsvJlbk7+lV6APr1qoRQt7n09DZMVglvcH6isenj7CWrY0SrObjcE/riidlGW7onhbPFQLwsFWvCqqA/jhyWi+M1NnJNqyaHSj3wZaRysPx/mircq89h+FPJqd3gZIWVjz2YVpQG+hKfiM9eBx07GwxLZWba/3aOMQ/N0eur3xxVGDLlwp7yp/9agwYRAOL7vVOxcrvr24avRaFWJRX0Bfw1AAWCw0NRhgeyOyFKaA6SjdOQXUDzabZxwFJPF/znt1SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaJPpL+cAt2ythntE2oczBYYfV3QDWXEr/YNKPE4tHs=;
 b=Mc1SKW4nnKJdvu7Z8ZnxFp8HjUGmMCO3fr1UIn+HWWxxXkWDXyYg3FRvYW8XYnkRMw81t9IlFCN5VVVZiL2/rtVKqoShqrPYUFbWlYWH0jDlUKECpJ05m2aCzo84YGZBEaXe0rhbNoq4agqt/VRVX1lu/7Fd0IJi3EwY/n5apSZ5pxJ7YTRTIHqyQ0dRmqe89FN+mlFI0gt9mhKy/ND8ERq69e7yacTeDSS6fGP4ajJ215Es1lXwvJjZio4Miq0QBBCui/v7ksJk8hDu8XYZDctWKZBVke0Uvqs29tLcszWjSCZkvsKN8x/7TKer53V62IBALuTth2qqWSlE5BUDOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaJPpL+cAt2ythntE2oczBYYfV3QDWXEr/YNKPE4tHs=;
 b=S862Szh7YpynUkdaO3n3MTZz8E3iZjYCJD19d4zRY0coiKFUCAiIS5+l7IUfusRpfrKu8aWxQuo8nEEb8eInhO5MOqd2daP43bRhBVL61VDAaWsnBztiSc+l2re7y316PddP/DfYms8Cg7JNwaNvWIjUvpQMesKQ9hf6oKaB1cM=
Received: from SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::10)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:15:28 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::31) by SA1P222CA0035.outlook.office365.com
 (2603:10b6:806:2d0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 23:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:27 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add xcc info for compute ring name
Date: Mon, 1 Dec 2025 18:15:05 -0500
Message-ID: <20251201231509.791954-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251201231509.791954-1-alexander.deucher@amd.com>
References: <20251201231509.791954-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: cc42f8ab-234e-4cea-dc65-08de312f83e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tI6O99fRZX8Zr7Qb+MzhwZ1d4Vf2pIOUP8igjNAmxIMuliPFDxTj+D8ibFT4?=
 =?us-ascii?Q?6pH+eHHuySOmqs+8vcjKGBZmgqLoHjpodvq8svpP3t+A2O6N/BtUBnvvoAAT?=
 =?us-ascii?Q?c2XY7iTZ5NGe4u3zCZeqffQ9mTVqW/ArYmQvDKt6BZKvbbAOOqx6Oaxweb7p?=
 =?us-ascii?Q?zZ9OgiNvEmGy0xj1qPIjOcVlOW+tncIfTJBC481w4Q4BJP3YYaxfLMfMmel8?=
 =?us-ascii?Q?3I/5er98I2Y24H83F/7LlLEvRotB6qnQmZsehyl7eqqMaiDJe2BKNHztcYeu?=
 =?us-ascii?Q?eAz7hJhnwr0EsgqOZ9WKvtXZ7vP/Gl3JMBUFH/Fatovy8IwG42TndfGJ0VLb?=
 =?us-ascii?Q?I0cg7ihAahqZyRMeFWABSMgQRRNxRcGANLJvbBxLg8d6LYAtYLjEMNIvOJSV?=
 =?us-ascii?Q?T5nYEZsIXY002Mdm9oi+O74Cnzt+EFqdr2klo5+rtyFhx8TJDHPfqIKAL2vA?=
 =?us-ascii?Q?yxS56mJIxcqQGOBZ4y2WvUsFbgwicQFfn2hI9Ydf55x4IGiZsSWuQp71EsgJ?=
 =?us-ascii?Q?T3wcB9yat0V0weQa8zQsduphuggNAGUihm3gcG1iUQGAS6Q+5R6G2I8XbpeL?=
 =?us-ascii?Q?X6nl5Nncu+b4Ud9X9lDKmEHDtZcZ2Wn/H8AgsA0ZgJnvJ5Gw7UZfusVlEo6A?=
 =?us-ascii?Q?VUbkS/hYf0Zrdr0/kUmeIFAi5rbYoLvP5B1hW/gnYBrUKDwjgD+L5eUaVQZm?=
 =?us-ascii?Q?NuEwdBTELyK+KhVp6O0doqEu898JIbNXgPuA47dlozkExM9MNaj4lmM3uuKh?=
 =?us-ascii?Q?ZK/7FjKJ6Xrb3o3YLp2lYnlS+57ET28rsbkpSBItAaLlM7iBU8NZk1sD6T3u?=
 =?us-ascii?Q?CgApLZFdGJgQevJLOEfaKi1UZSn7LzdupzmeQz/OM5r+F0CfZItdZDIaijwb?=
 =?us-ascii?Q?Z7XURfpkfCxmSkEXlTmJHBhJ3+VRczxaHJbnJFvbPkoLF4B7hBgSubQL7Jqf?=
 =?us-ascii?Q?C7g541s2M9KJim95s3sMV1bNFbBncLIj5mXUIUzFWy2uUSIYwVxYK6n/TkdI?=
 =?us-ascii?Q?rYI5ziQf366nLk9kvVVCmgdoA7ppveJJBU1U0AXjiAuNpCDEEgnTHXiXNJRK?=
 =?us-ascii?Q?rBxxIHALwkOSpS7+QHXdkRDvn84Bjh64sAMbAC2JWyZSZSvH9H97bh28LA0P?=
 =?us-ascii?Q?+XgkHSlXIhZy7ujHZuTIGEbxcMyWV58TgEjb8jSx+8yBwmV+1tBAxU6g4baS?=
 =?us-ascii?Q?mZ71qCoeD16A/XogPRlRE4SS3q14N6QE640GHUSc2ydCze0FTV2JDg9r+ml+?=
 =?us-ascii?Q?uSvnqQsP2dEGIjKSIwcCPLEOWLbbGcg7R6Yx5Q4gGhbefbhC7k1dGzI3N62U?=
 =?us-ascii?Q?iXCtJH5kmZt9ZccKWh865Sf7cu+6x4l9Hs/fCCZCstkfWErdwiZU6/FPVI+S?=
 =?us-ascii?Q?CeckrJQ1Z4au8vCdiITXHsXzYAHn43DJftK40m/MmM/Ynwf9b5wyZv9Rlh+8?=
 =?us-ascii?Q?tPOmQXVIpLnb+41VvxNyOQETwyDOIcOltbmUADQolsv5n8Kza6YkmArIdrDW?=
 =?us-ascii?Q?9UZDWJSN0Kpqt4JevipT/TEfP1K+ZdkQamIFFKr6ihzdDMb8WbCLfB8+fP2I?=
 =?us-ascii?Q?LKNGUgmSgiHWd8NkUOA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:27.8896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc42f8ab-234e-4cea-dc65-08de312f83e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958
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

From: Likun Gao <Likun.Gao@amd.com>

Add XCC id info for compute ring name on gfx version 12.1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index da01903113f40..a4886313d57d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -747,7 +747,8 @@ static int gfx_v12_1_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 			     (ring_id + xcc_id * adev->gfx.num_compute_rings) *
 			     GFX12_MEC_HPD_SIZE;
 	ring->vm_hub = AMDGPU_GFXHUB(xcc_id);
-	sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
+	sprintf(ring->name, "comp_%d.%d.%d.%d",
+			ring->xcc_id, ring->me, ring->pipe, ring->queue);
 
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
-- 
2.51.1

