Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81072E6748D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:53:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216B410E3B5;
	Mon, 22 Dec 2025 08:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ppe6YUX+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7A510E3B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJ93D2q8pI4znU+zYiAZKY/ybWjtEDMmUN7y9KLZw/W0FozNuoOEZcsSvXCA7UbN7/hjwE1im9uP5BPJ2lKuu3gTRQOTbfNL7tMqSB1kvDNgAPc2CARpSPJz7RsuwhRtUERJdNCIlUVIC926qbgcC6uLjEq9kkQEZThygqQ70WBLPOLLzJRFVjedOgrQ6sVNXcPQ69ylmjHehpgdKHkhaSY3Yr+l3k5iNvSjTmPN7H9QUsKp2yBg3FylaztgXJ/rpHPTgOgnA84jW5YHtCdLM9eZIf0KUZAJoRoS5n96WcaWXkg4gFuAoPBTIm6uuOmrLNu4fofzow/HDyo/3LTUKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZ7d1n6jislXG9fGxTrgyuWOQqy1uvbfZxbazEoC85s=;
 b=OBILTkWmQpxSdM/L24etwey43LD7gMqBK2u5bypjD+fSyrcoxXS2nKayS2v986wkD7AN4M7I0XPzTxSqwwP+rlryUhkFh3WUteTi/QSJ2XiWKDAve8lwh8MmWarFNJZTT0+k6/rTDRl+sQddu99KCa7vYLFn4/R4c5Rdmrs1+rNcUWVKVFzc3srLYZrXERHXgiUOpv8hlRuxYrRnCA/Lyb2jynzxQ7Ohh/qvxofDgJdlRRvhgGc3JzLuA2hll23u7DaVGlOPj5d60VZd+pW0AKl6l5adPkrSYxmZ97TvGQ8PJf/YR8HNxNRE6+2wZfpqEYxvfVJv1q5Xy+XmEoynlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ7d1n6jislXG9fGxTrgyuWOQqy1uvbfZxbazEoC85s=;
 b=Ppe6YUX+5BGssey0BkzPuDqpepqUbuY1xDRrlcNxzUYSCsAu3ouPqHn2NZuIh4JtGRz+Fc8y7fcqVHQN1YQbpDdj0nBLlGPr7PiLcNwCed2dWnjFcMaUXYjiZwZgqhO811rP+ORGN57bU8WyW8rhspPIUmYtA9fHiAQxJ19kMDg=
Received: from BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:5b5::18)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:53:28 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:5b5:cafe::87) by BL1P221CA0034.outlook.office365.com
 (2603:10b6:208:5b5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 08:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 08:53:27 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Dec 2025 02:53:25 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: only check critical address when it is not
 reserved
Date: Mon, 22 Dec 2025 16:53:07 +0800
Message-ID: <20251222085307.863322-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc37b8b-59ed-4a62-d8d0-08de41379318
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VYBe+0NHsHt40GNTSPOjeXS0vhkt7MyrR8AtuwOuACHBAVUaxS3VBm4Bmos1?=
 =?us-ascii?Q?DcnmZ3MYdMaOOcNXZlRME/YPX3gLENuYDrMxQvaZlTg8f7lotXOtSNjqYO+A?=
 =?us-ascii?Q?1jw0bA/EK8szbC0SoXadBYUyDCrOx+KtiPyLVvoEjdnzOkje4Re/BoA7XoAc?=
 =?us-ascii?Q?LFqbogz8aDWfMlHAKbQ/FFsGWUuhTsunPyao2RuG0s6cptOK0k/V3a29vszl?=
 =?us-ascii?Q?6+IVu1RL3LA/orJJzyxGLR+mmZ6ElcWturNLt3GzbWIZ3uwshFNvgh394PqJ?=
 =?us-ascii?Q?6YlYM68dDFi5xedxsZuGJu8alK7HwGXdqDrliJyZm1n7H86FM9iZRPqmIg/0?=
 =?us-ascii?Q?gV/jgKZ4oTfysfkpoCH7gYv24WN7ak65elBR/W4I99sIgUzBtGDuP2EL/6YY?=
 =?us-ascii?Q?jakjasc2/YHGbRBpnIcUWlbNOlJHgWpS9ccNh6fvY1S2QSHIZ8yWA/KJUzr7?=
 =?us-ascii?Q?nj6vAGzXppBxFsqbkxNumBGjDIXeeuZ/jVc/sQcl2QlwkHEkAiIZJ042k3aB?=
 =?us-ascii?Q?5WTm2uhuVGsMELMetE5EUAwnoPxwUDdVZQ9DgnWwdvIcn/oh23CaQ/5BDTmh?=
 =?us-ascii?Q?2568kedOX2Du3QtY2QoLe/jN4J+Q+NR0KI9fSuFP0O9JO98365TkeW1W9xOu?=
 =?us-ascii?Q?pVwT8rf3/BqAqA8D7x+pPSz57rFv5WWA8QTQnhKNriDfEFy9TZ/ipMSbxBRQ?=
 =?us-ascii?Q?8AGGLsY46H1Hc35GluofJNbEMNekgCVkywNYdwE6XL1/GHtYVvjbBr7pjltE?=
 =?us-ascii?Q?Dn4yQnu1+N7jRnxieN70nxl0FSVIMG52IwkYb5iKtRuaeKOPTHKO1RxtQDbb?=
 =?us-ascii?Q?2uiv6Po3BCAeGbWaQ0Hg1lPd98CAUoPnBfcjJvoMP2/r6InpWtYCadY+tsJF?=
 =?us-ascii?Q?lrtdQcYns3utQpW/Wa+b0XCGvCFFZotKtoyl+kWSxHBYb1ODHyn8HVZM/qnv?=
 =?us-ascii?Q?HrxElZqXBhrLzv/8dtJTEAQZVzGHjh656658Bll3KonYElM8Gg/Z7lDkBhpo?=
 =?us-ascii?Q?Jac/uOIKRrkSm7LOw3eZQFELfwi1z+h6A9MwHEMCiBkY++/n3LDxuwpUsarS?=
 =?us-ascii?Q?KE/ZvfMYrxybn/1QFn+Yd6NLRA1c3C/tEe16zzkTdFBNm5HzKI83FAkvo1PH?=
 =?us-ascii?Q?7lYbE0jUZCql+LAfk3YMpAFKv5/hCNay17XFK9DQAiIrjNwB+n/qhTZ7zcpG?=
 =?us-ascii?Q?mqTilDe6naAtpP4Qwr020irX0b5ALQN5I97OaGz1FKu1/qrs+2m6VO9FJw7f?=
 =?us-ascii?Q?mPPPwIHOpF59sxv2Lj1GDXH7SGsMqNXQagDJ517DtqU5kw33TQKaZVBehJlY?=
 =?us-ascii?Q?6NcJ7nPHpJc/mtmCqzlcLHmiknTY/BVkfy88x/tn8H+EplBQpxI8xscHIwJ6?=
 =?us-ascii?Q?IyGssCSfQphJ16IVIb1jnYJ6MwN4Zk48W52U/WjTC8dzPhveKxBJ8xtdRNE4?=
 =?us-ascii?Q?fVw/Pi7d/x7qKr4AfkCNm3zCLMH4V/Kyy36s3SlolEgbSSHtun3VBIIjzPKO?=
 =?us-ascii?Q?n5qsfC+m4Fv8Afhxige83aiqgGjrW1r5OIBQkZZZ9pLIhSs4Dht2mIDCLHjb?=
 =?us-ascii?Q?vXLobhbnHcOnQC+3J5o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:53:27.9656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc37b8b-59ed-4a62-d8d0-08de41379318
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
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

when an address is reserved already, no need to check if it is
in critical or not, to save time

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b1d1bc544998..0c84c7ab36d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1922,8 +1922,6 @@ static ssize_t amdgpu_ras_sysfs_badpages_read(struct file *f,
 
 	for (i = 0; i < bps_count; i++) {
 		address = ((uint64_t)bps[i].bp) << AMDGPU_GPU_PAGE_SHIFT;
-		if (amdgpu_ras_check_critical_address(adev, address))
-			continue;
 
 		bps[i].size = AMDGPU_GPU_PAGE_SIZE;
 
@@ -1936,6 +1934,10 @@ static ssize_t amdgpu_ras_sysfs_badpages_read(struct file *f,
 		else
 			bps[i].flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED;
 
+		if ((bps[i].flags != AMDGPU_RAS_RETIRE_PAGE_RESERVED) &&
+		    amdgpu_ras_check_critical_address(adev, address))
+			bps[i].flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED;
+
 		s += scnprintf(&buf[s], element_size + 1,
 				"0x%08x : 0x%08x : %1s\n",
 				bps[i].bp,
-- 
2.34.1

