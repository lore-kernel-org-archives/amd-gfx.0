Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2489C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 14:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3877B10E95C;
	Wed,  8 May 2024 14:48:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJm0yypv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F8410EFE3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 14:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuUh0i20Fq7SICs/z2wU/5d64659uiQ1nDolyPXfrvgQMcx2aNNdPYGy2VurKHTi8/H+ut9/elZNSV6BIJNQRyDR/I0I/ldFE+xW9KlnTkFfGLd15aFcvgXq6JE4XKLcQRm7LggE7BKPpDOS3CuHeOsEbJc0RFWS3FVldKobR/XTZkfgPtLJ4/oeFgEwQAFXEi5yLUOhll21Zx3hIan4fxILb8rJ087JBY0Q07Sn+HKPr2b0ryGNNJHDkLlw5r3oRYOFqZn7uC9xaZhKeJUvoizqidpNzHDUGatvYIrKRk0ITAdTuQb/19fpxpOa/u+gdOQwIwrQQ41Ck41QNYVrTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9RPAQFblv5H13ABAMwsPRzzcmWCCAqbK00Lcw1wxxA=;
 b=dNGt9iTFoPuMJkk3qbE/YCKhS9lTJBAhsG442ijs0Oqkm3e7wYB/U2hTFyqbP/Xb4REWinCqUrEQo4Tgns1zgExxi/+d/KY3JO00h+VzzPumY6Ay56rmqDhWuOel15Ff0MZ0rweIuWARr6yvo/mbE5N05HeVTxGuNlNG8OSbdq7EYI6dWaOuJTD2GA+KsYsCLufb2/QyLMpT5q1OhN8OsBWdNq3mRk5NDEhoIgRrz7QUZJMacyofwuNV/M2AUPNqNHklNjrsAJqJAKBIV7E1nG/Dr2GXDXSDEavyIvrwP4KMD1frLaew9pOxdo8bJMpTavDQokJS27S8VvoVfWzn6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9RPAQFblv5H13ABAMwsPRzzcmWCCAqbK00Lcw1wxxA=;
 b=NJm0yypv2svOB4dznDRqE/Rl1Necz2353sRFE1UOnaP8BD1Ckd56YyQhXkI/DfBHQM3GCBL4xarvnDzK2UqAXchkQkZ7zirogeOjwX8egU2+eGktv9aVhg7ufMk5V6IBIXFQL0JxzvHGPgh5gVg0W5wCcR75gBH/Uvd+InXgzpY=
Received: from BL1PR13CA0168.namprd13.prod.outlook.com (2603:10b6:208:2bd::23)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 14:48:39 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::93) by BL1PR13CA0168.outlook.office365.com
 (2603:10b6:208:2bd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 14:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 14:48:39 +0000
Received: from birman-stx1-09-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 09:48:38 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <benjamin.chan@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH 1/3] drm/amd/amdgpu: Add ISP support to amdgpu_discovery
Date: Wed, 8 May 2024 10:48:27 -0400
Message-ID: <20240508144827.254250-1-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b3943b-ef98-4a5f-9201-08dc6f6df2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Em07hXqorucMnLpfhqnVl1Ttbu3Clcrerxv1xwAqNa6h7bTrPllY6yEQDl3R?=
 =?us-ascii?Q?QizcxzzGNaLxA7es3SbPVrOUcSs37sT1hOxPKUKQIesvdvGe8KXFXCCppdiq?=
 =?us-ascii?Q?rAgG0VgB0JXAenidHUTvM9/Udvo+dkAitwQHEMx4SPVJUB16n56+IbITgOxg?=
 =?us-ascii?Q?mUivh0uVWPC9afq5RLYH7TeGQg2rke9iBRT1a2GdykQO6DdkBBtroX3LMdkw?=
 =?us-ascii?Q?HZVIwD0qgCpj/Bjcy3VPj8gO0J8SqWXiJVFOvWIa66TrzcTqsRDHjpW0EXKj?=
 =?us-ascii?Q?KnLGuZsFrk1Bf5MNYIVbmTce0Ehyrp9qiBoWIVbmTWDOYJdfUWsqnQ3WdfHf?=
 =?us-ascii?Q?wyBY6wxq5xuNOiLYHQS2ohwILyV/DNqgMRPSIp2BuMztZHGwa1CaKmO1TCdH?=
 =?us-ascii?Q?hwePZhLXuokgFm/G7Bf7pz9piXrSau0NOQweGHkQl2IupO83Nuh3CleE5OL1?=
 =?us-ascii?Q?4jYA+SU4LCxN2YfUxQK2UrJ0haa5vYQ3c3zHGJzgNgKRsB3NWZEM5J6FTy2y?=
 =?us-ascii?Q?A7ZeM4Nv/YZSAeEHYK47DVsXy3+b7RJk4ececgfBuXCy84zJyk1xGJrvwTZm?=
 =?us-ascii?Q?2QY0nHoO7PrR7MDfuBZP/9hw2MFGPuVnKEAAT/i8xmkYOgfE/Pm2DFXL0ooE?=
 =?us-ascii?Q?A78ZqJseVTLt8FPkYk6rv66ErasYEgWTvvytr3BC/njPY/fj7SSc5gfKTib0?=
 =?us-ascii?Q?A83xZA2JamIwOaOgxBL/pEz99uwn29G9yQ5MT6MUC6sFZR36xstCoRDK8GYL?=
 =?us-ascii?Q?dsF3XJNHdSBfcvHAUIssdQPtTTUs5bPVyVRvWXXnbXscZKXEqR/dlLwcXXre?=
 =?us-ascii?Q?byHlc5vzdd5UFozScLsJ+bM40vuz3p8ThmXJWPrCd5CH7s+3Tdp1ayfwUc6e?=
 =?us-ascii?Q?3EqHp333mON2/odQiq+1yLgUBVetpa3ecp3pMNN8jSvjHoSYuVwCZNzqAM4t?=
 =?us-ascii?Q?nYz9qcrWNDYci31Hcc5f8kMqZvi4rzj/OFxZeueqoosEYoKNeynoHBFOLGGu?=
 =?us-ascii?Q?fZ/ON0tA4NyuF1FDV/J/P7HrqcB4OwLhXBoHP6dpWV2LUNlsiPDJkybhHPLO?=
 =?us-ascii?Q?kuifeMFqtBlnZkZB2rgvkr2w9Zoa6CnuGcO/QtKHN80lp7XbSUC1aCD8a/Bz?=
 =?us-ascii?Q?gi13yR/G8ixM10nGarSvVS/lqur4L8YXiIgNBxAwcXKE6vOJLKOjIZZxMMqw?=
 =?us-ascii?Q?FvGoWb9b11tFSgkXE4AC+L3+SnfJmzY7JNkHxvb8RwkqTkwcWNnLPJXsZYNB?=
 =?us-ascii?Q?mXjqCtODjxzCBzJAymIJvYeLj57iaG8NREJXyAXm/dGqUlqXHVM8ivJJNqqI?=
 =?us-ascii?Q?Qx12fwqwa9tO9eAR98XYM/3wyp2IoQ3ubu3bC6CZX3f6q65LhPRmmbt7XYSn?=
 =?us-ascii?Q?gFa8srM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 14:48:39.6090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b3943b-ef98-4a5f-9201-08dc6f6df2de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661
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

