Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023A4E6FE41
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 18:04:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74EE610EABF;
	Fri,  6 Sep 2024 18:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XXka5IzN";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B57010EABF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 18:04:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL3vN5g+/1EKlYmgs4yJTpF5O1LfXh2kHpKogrHuKWi7hW9ldOhRBCxknFtN59fvpLL0p0XfrZCDPMl4l0ixB0PUMm1E+EnI6PQ4jCRJB6MX62Mj0QH5t1d42TZK1v2HYH/ziMseHE755ALvlpivfdMXrT4uMfygFEZzx0RP7LBdFCvatdX51puXf+2tVMFLSvDY6IcJjB7a9MyLBYAqErbJM5jCOlmLyPBhEBtKA9RcPTb0+05DG8uscZvHM2wpQVjIpoBhrxWyGNf2MCxVZ1eJLMtCDbaQqzeMg3UyuEKesxYdnk8+gEg7xPqOfem+qDmWH9kkeqdqL4hk1mZGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFGggnI2ODkxPqsThqG7gmmnMb2I87uoNa/oTLAiDVk=;
 b=GIu5r/YjqKAHJrXN0dfdFC3GAMwhkZp293tJemkt2H6hfAYoiO1CQEepVnegm2YVHtPVFMerdGiisn92WXp3CbPqnbF9w7NVdrp8md9Mzb4uH4w7ga5am3xqzesOL5q4u358qmlIAfwiM6xbU2yzuQIj7FGoL7dDYKBdtcmgnaLb7X4R4+nocxEVDSy1FnII50cTxX2VE7OvjZeBPO2jEoaRqkxPk5hY91/f7n4hMJ7jHZJBYxgnJXrtaYt+tf25ykSfEjJN9i5K2TgfYV9s+Oy22UwUKUCj5UUFXsXu4dcY1NmNW9D0Y8myABjEME4Jsi0DD9qIyF+XTgZZvotjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFGggnI2ODkxPqsThqG7gmmnMb2I87uoNa/oTLAiDVk=;
 b=XXka5IzNcsJJy+eO/7gP7zPbGmv3SgcwX3K9sqGOGt6GNqk/S0gEfJ3bJRKyWKDJer5ISW3vodR08/57M6nR8kALbV9A35uLyeoCU9ivYaQsu9ji32DQD3DOhVA3ezYHlkOfPUuxssq7/T0YXiKCUjXACgt2UMJpP4LlSpt6Njg=
Received: from CH2PR19CA0020.namprd19.prod.outlook.com (2603:10b6:610:4d::30)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 18:04:01 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::ee) by CH2PR19CA0020.outlook.office365.com
 (2603:10b6:610:4d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Fri, 6 Sep 2024 18:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 18:04:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 13:04:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: bump driver version for cleared VRAM
Date: Fri, 6 Sep 2024 14:03:45 -0400
Message-ID: <20240906180345.2557849-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cc0231-5130-4a9b-82a9-08dcce9e49ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0+HwaiRjU1tW+qjXkU9d3M37aIiDP/AuR3Jtu+KpCPsXEv+hUK90IseRE0LJ?=
 =?us-ascii?Q?VxgZpPyTQuVFelcd5vkRQk+0gBxo2qPLJ8J6zfycZspB/4vvnOo/YR7y5Nhy?=
 =?us-ascii?Q?EgvOTwDXiNjnQBPFQ6ntwuasgPcMS/tYLDG8GRkhODIqP0sPaUElVLCAoey3?=
 =?us-ascii?Q?uUxdVB7x7KwllOFHH5DgANQbpGNxw9W/3OrtIY3Y9iKZQuruHRlAR3O6yYqv?=
 =?us-ascii?Q?p47Si8tcRKqhDZJTAuKk6KDJN2LwRQ+2IMaZw7c3NM1hV3shQw4nTJ+xKc4x?=
 =?us-ascii?Q?nmTJyLrmYHjzxNIv1CAHQiijynl5xT1R/KqLtHxbmEXr95HOpXJCbm6hV82v?=
 =?us-ascii?Q?xqpxyEP4q5v3v+ui8KJPGsFJoArbtWQuIUp1Yl4LNeQYowVwaIeMgypGZx1C?=
 =?us-ascii?Q?H+x+3yC4nWWmGoFeTC+iW3praHvZktCKWBBhjNOR0vFslvNcgs2NdRoHshBI?=
 =?us-ascii?Q?xSqxBjXH/N8wMmOAymkeXz9uEmoQGOBps+X6HQzTaqSC9ga7HQGTfXt4R1yF?=
 =?us-ascii?Q?TYNwd8earTjna0XFuT3U/q7euNqxYrHrHxJY8KKnTlZshiJVho9tMLCQFrUW?=
 =?us-ascii?Q?CCgcFvWCCh+CTAX9KJnF4Uz8xUSC/2eXroziOfIEIfDGWRrJpzHd/N3C5aGk?=
 =?us-ascii?Q?GJaibEz76vL3vyaxVrm3odtE+MC4dldJHv0VASykrAS94K1+xpQB/JwgCp8h?=
 =?us-ascii?Q?P6sMPWYysSi9T3Rw8SMrw8Z2SRNw9KNOC8Vokmn2T1FUCT5v31jFXZC0GAob?=
 =?us-ascii?Q?9QmJ8ZjQPGyvP7/ay8jkgIX4GOkJdUhE8WSxme+9i7B4ZQt753kXy4B9m3VE?=
 =?us-ascii?Q?rxLCa7IVvetIIbp81F6pOsDq9Dr8BpipgwtMJoFD4Yt8JOW4ih84o2d+9HBx?=
 =?us-ascii?Q?J9RLseI65I3eC4+97g6ZryGTfXRSZOoQCFHiAAgqRAxTBNvGIpTM5u+t4xKK?=
 =?us-ascii?Q?QKgoabk+wQVVKq4r8B0boFx8FnHW1vqEUafNkCJm4M6j2sH7eT/71QGwrMAn?=
 =?us-ascii?Q?tuU7/wlDYEPiaYlsHZ2Z/YePbLwb1c+gF3/IVXWYVYiZCbNfCo8fblcy2oJm?=
 =?us-ascii?Q?t7txyxfgEziL5nxt+hsDVeCvLxTpT/vCRID0hL4jFXKF6A4SDozaGDKxz/nc?=
 =?us-ascii?Q?2enNhQhjOpkRnTIV1pecc+v6k/n7vZZC7TpG24xjzEimpmWnIJN5mAe7EL46?=
 =?us-ascii?Q?G3/5tp2fAVf5Y+M0l+nIoN9CvzWoDojWvFHEOf0Wk5oLFhQ4wFZ/xP8SFfyA?=
 =?us-ascii?Q?pBVRfiAy1EFBaaHpLBrK7mZOmwGWZfReeOBbDH0WuClR8iYo49x2zopO5SLy?=
 =?us-ascii?Q?OX+pmFpMGzcbp0ym+9Z1iyRvU9SdZPc/o0PgTuP8ffzwlZ+XXiEGO9gZB5Ov?=
 =?us-ascii?Q?VYDh97fOWADeG1QbPwMsyp9968OKHCgDf6NDar6ROthjsHhz1/rJZ95jAaOH?=
 =?us-ascii?Q?VC2/QqEn+v4cd2vevtmZgz3885Hiv2R6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:04:01.4961 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cc0231-5130-4a9b-82a9-08dcce9e49ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
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

Driver now clears VRAM on allocation.  Bump the
driver version so mesa knows when it will get
cleared vram by default.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d90473aec942..fad556be840b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -117,9 +117,10 @@
  * - 3.56.0 - Update IB start address and size alignment for decode and encode
  * - 3.57.0 - Compute tunneling on GFX10+
  * - 3.58.0 - Add GFX12 DCC support
+ * - 3.59.0 - Cleared VRAM
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	58
+#define KMS_DRIVER_MINOR	59
 #define KMS_DRIVER_PATCHLEVEL	0
 
 /*
-- 
2.46.0

