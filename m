Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96394C25B5C
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 01:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0009410EE80;
	Thu,  2 May 2024 01:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BDe7WIQM";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0769E10EE80
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 01:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6nPCRj7F9JhmkXMdnzoaSKNOgkrZxQ6QYPuf9lJN8pethhPpv4H9tIMrPjYmltCYLDA5sbCol5YEywyjQvm3oQONpxKKSRwgmTF95pBIIPKULA0s/S/kewLt/WcWd4XvehsXB1APkHM+PDr8Gl2lsC8UixDTVjRBXbdkb6gj5O9NH1OO1tDUviXm5URJ9Y0noz0JQfBKSEIOrBcbNJ4GH9oaOjneNicB3vYlZHNTObPAzq0zvqy9Prp0AQHZ/mtPsasIdZbVn4VzpmpCGgxTb5MMAGbFRAM2r/cxZymOnyQjJAroIO6QWecx03PWxoOzeIOMqrolFtKII+ZbHJ03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWy60zWzMOhN30rOriFjnYU33GyNAnbNACjIFmO2ozY=;
 b=JEBqgl7w/+e0s1tkMYycV4xgB1GgwXFUW6zInrEt+7VWErQ6h8y8gjkxw/gPnqw74BzHCrTdpuuYB0iBVJ62WF0Vitvtj9EQNCP4EZ88ZICPmi8H+N/O2Dl8Fgnah5t7qGy1kXZpXE2e42MHTz+I2iXEfWMKusZ1vgKhvTmmb/UPsNIV6BXOfUeCs0D9WWvfGgvoM+3PTtkNcWXxYfMRFiYllPiBlJ4mfaP0MjQmjvivD/MV3o50IEJhYWoy7ipeVr7/a7r7A12wR9BJMbknw9SBITdtgWPgmhy5qYH76JL7FIgst9QUFRrt9Kpr+kRYBgzSosszIC0nh6FYnfF5dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWy60zWzMOhN30rOriFjnYU33GyNAnbNACjIFmO2ozY=;
 b=BDe7WIQMOTNk9Gv0MWhc3yBqt5RpHhe2ccXQ996k6syKnX/hPaer/gvCgLhqneB0GFMu8YA5Ulca4UC/iax9mL/3aL+v3WyWzkfeaLjplRhTBks/fBg7QS8FXDlb0+TZzfQdPNCAkD+nrCJT92ziTFOnjgYTUvym0o5XWtgDZcg=
Received: from DM6PR07CA0084.namprd07.prod.outlook.com (2603:10b6:5:337::17)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 01:08:21 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::bd) by DM6PR07CA0084.outlook.office365.com
 (2603:10b6:5:337::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 01:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 01:08:21 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 20:08:20 -0500
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Improve chances of unique gpu_id
Date: Wed, 1 May 2024 21:08:04 -0400
Message-ID: <20240502010804.125461-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502010804.125461-1-Harish.Kasiviswanathan@amd.com>
References: <20240502010804.125461-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b4c629-4dcd-49bb-9e2e-08dc6a445bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BJP3EevnqLMwReHwkuzOqYJOtsQD+CFfQts6SJJHq4vYADqZ3ao/HjGbm8hD?=
 =?us-ascii?Q?HCE7OMyybN3kmusnvNhnRqhWxHQ+4XEI9OcpXp1o5IGdV0Z7VwoWfS/+oaYh?=
 =?us-ascii?Q?jXc+CVPhsd/mOm83pwpXHG2kodtyPRAVbqWJ5kYS1XYev9O2wj25VdXhJMHt?=
 =?us-ascii?Q?go+wA45UZUzp4Ie5kBXHJxxjt1b3hKn4sp09/ZCDruCRl+ni+P5tUMe1oBkP?=
 =?us-ascii?Q?hDchyIGCOag2WMAeva5OyTwajE2LwkKx8N3d3f9AIKHT9x85k+4/hNA5G5HS?=
 =?us-ascii?Q?J+yyCtWJbNus1fKKlm+BQxh917cDRnY6wSNvqZal5Kla333ZreU7vf9Vv+DZ?=
 =?us-ascii?Q?anQB0NXm09+fL6e340Iald1uybmPnVMSzDtlku9TgivzTn25mDLdSdccrpYo?=
 =?us-ascii?Q?DG7XFyxSEZG5PwZfM8wpWNvDMydBvQyAiTzjNQIRDTwcozo1yHPSWzD+oniz?=
 =?us-ascii?Q?ZEUUzB/4qk6GFYkT7EaH8jCLUBmkyeM7BvznUGQvacq/QkYZchg4FjHragU5?=
 =?us-ascii?Q?i2qpguhvQjNukCcqXVVifLGDzpjocMmzLsfUnvYKf+GYidB/1lKfam8EZBb7?=
 =?us-ascii?Q?WuwtUNzJKgfbm+jOxT4mnI/71ukr/+ahPOzLk4IZ32KFRsSKSr4ZNQeo8rv5?=
 =?us-ascii?Q?D8ocZzcc/gqhNFme7CyhrHxOkB4oZ3ujMMpgG58JWwYPHGWxBj1MkrPNuKfA?=
 =?us-ascii?Q?EvUzDXdqWfcvmfSEqAxoVQd6rztiJ9q8CbHt8t8VvM+QmsUNi/oDMWjZsxJv?=
 =?us-ascii?Q?jVAVXdHmwbC9h4aQNLyw1BpTPQplJHQIDGy1Tj8ZoeBeYvJ1FfOWmsQQ9FNk?=
 =?us-ascii?Q?p0gvrxs81dqvZzyCl2inmqDyKgDhFITzxq0rQ1dohXJZhH0SJDmOilyjQQxl?=
 =?us-ascii?Q?aPIPQHIlvUIZ++FFmnUSa1UaxwEOmNM2hWKpPjC4fg7+40YxlL9StQ351/1b?=
 =?us-ascii?Q?5G7wfoJPHHi84izA0EbAsNOI9c72fUe3bwtsXhiJWCOEHlgaor/SbO/1PocF?=
 =?us-ascii?Q?LvXDZsHYhiJzaHMnqchreUa6UVBTyXhqkaDHinSey7/hbuEAFvCxtGu3eDJZ?=
 =?us-ascii?Q?uMmjHoGmJLBGofNHHr8xyh86XbwuUtYnroAKyCm7jekiFtIHDesrqZHn6oGa?=
 =?us-ascii?Q?mSEvbFzosofbujwpYHbYRrg40T0CeNKf2RjRS1/eFewmRrNdQ2/ootL2yMry?=
 =?us-ascii?Q?iv4nuZGfPbXdI6rBL8kFBYni9yzogTN4Ub/VAhGHwHN0s+a2BrXx5RN8pB2H?=
 =?us-ascii?Q?z74gis/BHi9D90wVuTroRdTft6wMCby3inKVkmmx5B/4ncBsS/UpmbsDzf0/?=
 =?us-ascii?Q?5NkIMKp7AbmgPB2k0BL83wItFPrwyfW1BZ6Da89kni6W0sOensTTjQGcgHth?=
 =?us-ascii?Q?TWmKYeY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 01:08:21.0532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b4c629-4dcd-49bb-9e2e-08dc6a445bdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
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

gpu_id needs to be unique for user space to identify GPUs via KFD
interface. Do a single pass search to detect collision. If
detected, increment gpu_id by one.

Probability of collisons are very rare. Hence, no more complexity is
added to ensure uniqueness.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index b93913934b03..f2d1e82e7bed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1095,6 +1095,8 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 	uint32_t hashout;
 	uint32_t buf[8];
 	uint64_t local_mem_size;
+	struct kfd_topology_device *dev;
+	bool is_unique = true;
 	int i;
 
 	if (!gpu)
@@ -1115,7 +1117,13 @@ static uint32_t kfd_generate_gpu_id(struct kfd_node *gpu)
 	for (i = 0, hashout = 0; i < 8; i++)
 		hashout ^= hash_32(buf[i], KFD_GPU_ID_HASH_WIDTH);
 
-	return hashout;
+	down_read(&topology_lock);
+	list_for_each_entry(dev, &topology_device_list, list) {
+		if (dev->gpu && dev->gpu_id == hashout)
+			is_unique = false;
+	}
+	up_read(&topology_lock);
+	return is_unique ? hashout : ++hashout;
 }
 /* kfd_assign_gpu - Attach @gpu to the correct kfd topology device. If
  *		the GPU device is not already present in the topology device
@@ -1946,7 +1954,6 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	struct amdgpu_gfx_config *gfx_info = &gpu->adev->gfx.config;
 	struct amdgpu_cu_info *cu_info = &gpu->adev->gfx.cu_info;
 
-	gpu_id = kfd_generate_gpu_id(gpu);
 	if (gpu->xcp && !gpu->xcp->ddev) {
 		dev_warn(gpu->adev->dev,
 			 "Won't add GPU to topology since it has no drm node assigned.");
@@ -1969,6 +1976,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
 	if (res)
 		return res;
 
+	gpu_id = kfd_generate_gpu_id(gpu);
 	dev->gpu_id = gpu_id;
 	gpu->id = gpu_id;
 
-- 
2.34.1

