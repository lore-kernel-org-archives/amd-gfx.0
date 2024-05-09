Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D34C25B74
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 21:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F3F10F693;
	Thu,  9 May 2024 21:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywVlbrjq";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3BD510F693
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 21:50:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwdONNbfM2Eot2VX44puGHHeJfPH8rz3d2Lk37EgmtjAV5HdFv58eiEhnj5FfX0PN79WymOpPeFcGg68P2NjzNvT9QxKDE1zmawYz+v4N+MCQSofdXPjPefqUD3EV/6iOOVC0RCCgwIR+eYfZPcUgKA/uOTw0NW3DjIJeAsOtC8Pnfz1XZg/qAb7pVtZEa6hdUlpQha/MwFlDRG52n/iqQvz+/EKGbkYDplgy+yfk02ggsUW7XdaFTBiF48mUjTRvKpT8CNX3oHEsoTYUrB5A3vZKUSkgwuyj1QKYVan8P4KJbFii3yrTtYbzfLN6NMXC4FHMw42PyYLyPEyBjA1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONMSX9KWV14SLlEaifVyqgyf3/VbNm+F9aLLOj9ZgeI=;
 b=FVjQPsdyeY62Uo/pEHMzWPQHPPrP9ZVw04DS1AIq0dngAx4vjTiTy09dT+r8Yn+utolB4yhzKjJ5rNzJ9BXP1yMi24xD+VJi2WnhuXYhPedtJhIlyaywrD+AzNc+ybnCXCnITKY95MCuvxIv1dD88VaS/0hREsInwZH3vv39HF9/Q3MpIJFuhAn4vZurFIOyBCG8V4EanZ6gqYtpXUQpm//h5T+PVHOQvIB4HCp9tBKphAqNTZJSIHWVN6h5H4rgkAneR0VBW3bLjFpgOaNue6HbqUyzD7VW53mhBV8Lwk/o6jcm1ACy92xQNtZV3WFL3Fkd16EUehVrhmIBuZyi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONMSX9KWV14SLlEaifVyqgyf3/VbNm+F9aLLOj9ZgeI=;
 b=ywVlbrjqaJGuSqo865yDtjLomQhPyLwuM9C0bN/zK1p4KdnjH2QE8bCFPTm2Z5TIEMrajR6WOS/c6KEjz4Yt8Lcw3NUagysi0/IRo41o8NKccKLfGuWm06nMakzzWT8FCar5jQyMeCZrSyOf7Lbtjegbl1o0k28dWkaK70uVuO4=
Received: from BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 9 May
 2024 21:50:18 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:35:cafe::39) by BL0PR02CA0126.outlook.office365.com
 (2603:10b6:208:35::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Thu, 9 May 2024 21:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 21:50:17 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 16:50:17 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <mlimonci@amd.com>, <benjamin.chan@amd.com>, 
 <king.li@amd.com>, <bin.du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 1/3] drm/amd/amdgpu: Add ISP support to amdgpu_discovery
Date: Thu, 9 May 2024 17:49:59 -0400
Message-ID: <20240509215001.515866-2-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509215001.515866-1-pratap.nirujogi@amd.com>
References: <20240509215001.515866-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 69048d71-ad7d-41cb-8d05-08dc7072042a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sNkwDV4jEod5hhJ27OSsajXr3rqf6hh11e0ALFJZsym0TzSmI5mp+zaFMsl0?=
 =?us-ascii?Q?6dUAJErWR4QNkrSGMaZ1a8FNgxauFNb3U35ZlvTdSm+gcq2XsHFkOgWUBkNN?=
 =?us-ascii?Q?1ng4OEzyTQe4f3uJj69JWM2InrF2vfJgccV55DqWR/J+LUWM+g80OoSWbsC1?=
 =?us-ascii?Q?I5s6E8w3RSQCNDy4QeuAh/lBtCbA69tUXoni+QauLi0l+32gGhvef2w1l4kP?=
 =?us-ascii?Q?ftN4uJNz9Y5nmsJtCoZG/awIpmenPSWvgQAK20x3scy5EXvV4u9hpN54hDxZ?=
 =?us-ascii?Q?WUKUCg4VGkn22N087+4zGF/3U+bFDhFNrJPAuI22USJKUqiKm2nFzBu4wcEw?=
 =?us-ascii?Q?MLCDgYuDoeSi3mXC+pWIVkLM9yyw6Wyi58ygQihPXewfsUMMOTn/Hu7P5rat?=
 =?us-ascii?Q?9f0xoWYna2YBoC8HdPikfYGmeoKfygyKD4b6rP5S3iWJFLEF/jUaXUlXwONp?=
 =?us-ascii?Q?E95sjlSlHxEetdNKb5mD1cLTqTkjvhHp/BAKEoiqIvg3csuYMbXz6rBZ/Tgj?=
 =?us-ascii?Q?aMyZ1AgJugM1v6+ktjvxXRvYpfzd5pBiAGiePdGumRItKJvd3ViWzVFpVJoA?=
 =?us-ascii?Q?l3EPxn2DJi5sQy+LPtfyNiZfgv3yF5tcxsax1SSXRmM00WFXmV3t0vdz9fd1?=
 =?us-ascii?Q?Ud5FHva3yNFStr7gJkgkt0OET4w2jREXhq9L36Ce3VdVxjEsoIcKXfGEzcnk?=
 =?us-ascii?Q?3gJOtyDzWZZvrqeOgCDnRjZ/xP/rsPTyDhK87o1M6D+C32k2ng346CW/MTOb?=
 =?us-ascii?Q?VeG/j/ZPfE2VJR57q/XJRrMAhrhq+AwX7J083U7cUmqsfPipEwevF1lXldNP?=
 =?us-ascii?Q?dvMAsZHBAXeb0EezNVoQcPGA9MRvlp7vvkjXl9Z3HzCZ2a1fOuZSJtt8O6OK?=
 =?us-ascii?Q?VS9fPN1x8FcnVO604eCvbXDKIf3yeHmWNwJA/+q7n5X2KfFrdIX6DsbAko4A?=
 =?us-ascii?Q?Ii2HrvZRqx9JeWqdWi7ND2nq98Y8hEy/glA2QMBx57Fqhri9wNCgBRGX+D40?=
 =?us-ascii?Q?DnXj7Z+OLHycBGpyM57KGFEOG2b81G1dE6EdiVJg4zlZO3RBiMV8VMcUNRcq?=
 =?us-ascii?Q?DsvqpuX0uwqTbAM9bWneiIWPiPT5EBSC/GQn/AbTh5bHUs99GwtAC9ZH8JJm?=
 =?us-ascii?Q?hA9vtTWL6TLHwc5YMI6kD67fOEx4H1KreQKH3e5LhNnB4alregIRfY6hs+pR?=
 =?us-ascii?Q?CB/uoijNtZP4Z71lUpMr8DNgO8O7U6h3qQNZNXeYxI10ds61sWCHgQGYGYYe?=
 =?us-ascii?Q?3a3PCFnLggd0eW/TeYjDTb+cVZ2UhLVLJ/Ky7Ww9kfmoeahBKcHyAZcf31Hq?=
 =?us-ascii?Q?cUFCklNl6YZEaPnX5fCJnGosNtaA029UEIE9sOggAOOq5MbroVEm30LKS7/t?=
 =?us-ascii?Q?yM0h2T0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:50:17.7935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69048d71-ad7d-41cb-8d05-08dc7072042a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378
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

ISP hw block is supported in some of the AMD GPU versions, add support
to discover ISP IP in amdgpu_discovery.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/include/amd_shared.h      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 8bb8b414d511..eb60d28a3a13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -718,6 +718,7 @@ enum amd_hw_ip_block_type {
 	XGMI_HWIP,
 	DCI_HWIP,
 	PCIE_HWIP,
+	ISP_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ece462f8a324..6586feab8c2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -226,6 +226,7 @@ static int hw_id_map[MAX_HWIP] = {
 	[DCI_HWIP]	= DCI_HWID,
 	[PCIE_HWIP]	= PCIE_HWID,
 	[VPE_HWIP]	= VPE_HWID,
+	[ISP_HWIP]	= ISP_HWID,
 };
 
 static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev, uint8_t *binary)
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 36ee9d3d6d9c..8bc2134cdd6b 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -105,6 +105,7 @@ enum amd_ip_block_type {
 	AMD_IP_BLOCK_TYPE_JPEG,
 	AMD_IP_BLOCK_TYPE_VPE,
 	AMD_IP_BLOCK_TYPE_UMSCH_MM,
+	AMD_IP_BLOCK_TYPE_ISP,
 	AMD_IP_BLOCK_TYPE_NUM,
 };
 
-- 
2.34.1

