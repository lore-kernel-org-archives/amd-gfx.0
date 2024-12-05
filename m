Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423B6E7716E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 20:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE90610E3D0;
	Thu,  5 Dec 2024 20:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pc3cC9qA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E76D610E3D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 20:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CiV+w2VA1dy+OneJFC4kT5r+WQb75KL8z7F/+Z2aVDo+LtxlmRZTjFO+m7ez4dK++Hi/Ek11eYQILLo+LqV4NPzXYbrxJWm+lMrF3kEck/A4wx0dHIrRnNCWG9Zh4kspV4YB6XS81dMT4UHGu4TMGjlS0E8+LKO/snBNVhR+i7ji9Po8LtGI3xAqWkZjScVtjNjWH80bnwSzdDENjV2MhYn3mzDMXe95YIwzRQzdBpnOJ2Z1OusE0OJUXrACJYg4jptqmFhw9mZ8V4v+U8JAUd4/5FnaFNgCp58ZogdCFo1ZSRnu5dXD12nBqgFvwpzHGtK0VY6AMx4QfN3ys/qxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElP7iRqx0hDbcItoq2dKQCIT2c5MDV6hW1qXsHujx3g=;
 b=Od/j54KPbsiIG1ofvite+9Blpw1XGsyPMPuuJNw1FVxEF87JeDth8jcXZA9WhijNSvxmtZJ0Oi7fzIEKNa9EAQcrUUdToKxTNPFU4FKB0gXDhc/bDEytfE4st0PNiAhH1vmaHF1ojADLj0eVbZ2NkFYkG8yS4oAd9P5G+F5zts5B3p5zniiokJjwvuH8hh1wZq0i82G+b2nw87YVXy501BdtyH1Jiarl6MO1hIZv7ZRJtRZg5gEM7A9GbN+g/ocGAWVgIxAo97HSAvr9HV4jfPe0cw67zllsuTIOQY2F6r6sQ+91Jr9fZ4xKNk61CcatJ1/xfATgB27UOD+istQvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElP7iRqx0hDbcItoq2dKQCIT2c5MDV6hW1qXsHujx3g=;
 b=pc3cC9qARjB3l2Cok1UcKIEtu5DFSOXOAlDxe48tV6c4HyaVyKXI2IG90sunJ2owIplGe9kxU4nSMtiPtfsSN64LHmJ/HHQvL6eRJmEylyqd7roAvCpIhnrGOQecQazZvkHM5aqycTymFjfrHu9f+pwsncTGPLW0Fu50Hb1sj9A=
Received: from DS0PR17CA0010.namprd17.prod.outlook.com (2603:10b6:8:191::26)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 20:17:21 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::33) by DS0PR17CA0010.outlook.office365.com
 (2603:10b6:8:191::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Thu,
 5 Dec 2024 20:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 20:17:21 +0000
Received: from maple-stxh-09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 14:17:20 -0600
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <mlimonci@amd.com>, <lijo.lazar@amd.com>, <benjamin.chan@amd.com>,
 <king.li@amd.com>, <bin.du@amd.com>, Pratap Nirujogi
 <pratap.nirujogi@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: Fix ISP HW init issue
Date: Thu, 5 Dec 2024 15:16:52 -0500
Message-ID: <20241205201705.578136-2-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205201705.578136-1-pratap.nirujogi@amd.com>
References: <20241205201705.578136-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 2348dce6-3318-474e-1642-08dd1569d366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DEIUoXDvqLVLdt9AVD8/dS0KFq2mBewCd7Z7/vtrhx2jB2bzCbVM5cqZkstu?=
 =?us-ascii?Q?dh9hSvnHYqqEwIGwAGyKdxAnOWBqbEa6y9VPaGXDKzugjFRZKGXzqeJ3+5nm?=
 =?us-ascii?Q?hw6/PdJCjjdwisqyyJK50s/mG0afX3GQojdCju8bRbwU/P3f8YgQ9M5hSkhV?=
 =?us-ascii?Q?fOvmR2SDyaftsX5Mk3AiCSx2TlyGVNNmLCBuaduwhsNiI+0gkRYVmZW8E8DG?=
 =?us-ascii?Q?VEAoxdEvuKwSBKCSIcXLy+PRdZc35+l2vtL3rc9wmGMU97s2mX1XS7TWcRys?=
 =?us-ascii?Q?gvFm2D2pa+6F9FZ5aFjHVgq7m9OXMDZYZo1QGuSkNZSuW395DOovRZGY5rsg?=
 =?us-ascii?Q?dTMgpusjyJGk51iEYpusA1xD00TexAplWw78EAKSXv9mIX4t1vpnPBoip7dO?=
 =?us-ascii?Q?7cJLPTRU3eWjvqSYuNYKrP6x6auoTJyJDlgaWE3E2JgvX5GUfbf6aEwlhuPK?=
 =?us-ascii?Q?bgNcqWmdXT4I127XF+vh9Od3avmEyHzdMqwTqsT73Bhc0kRhgG0v4m3VeseE?=
 =?us-ascii?Q?29pnab4wSMbkuRthD86C80MvHrIqvkjlnMLl1yT5GVoHbNz+tQhmVCqrQIg3?=
 =?us-ascii?Q?DRvf207b3nuDOECCbcY+DQ9p9tqDETkAmTV8KZs2Whcsxk8SVC3h3SdjKlSX?=
 =?us-ascii?Q?u7VunTsvlpNBzLJgYSP6bxodkMCeObYrz5+3O5Y0UAyMT87DkDl9lNBqNT+P?=
 =?us-ascii?Q?cAltfSsLatrXmsSJTMEwRRm06JKSsp59/0DZtDJASLR55/v0pZy4X5ikowSL?=
 =?us-ascii?Q?WmuiWO8Wp5zYpu+czkoFloJAsKQsF3AA2zbk0yfaB2iOxa4q/4IDcNrtZZiG?=
 =?us-ascii?Q?3Zv/m+sQnx0SZKRlBMquyGRnB/poXpMN/Ix2KcoDwMBX95JBy2Ab+9PFs3Aa?=
 =?us-ascii?Q?/CmDbLf8sqsoF/7cuBi7Zd3lj744oJd6pptUqLaZv4St792nvNytpTjfb0iE?=
 =?us-ascii?Q?jn3iWPd+tOkuer2H9NZ3fVWakUFF1uSwWIQi3oELS01ZI2Uoz1g6HW/SwipH?=
 =?us-ascii?Q?TCipSNDANvITKgR3NkV6JdYC7AmGf2DKJtS9hCEFKrLYs/rZKLGp6OYP8YUs?=
 =?us-ascii?Q?8itdBsj3FqZXUh7leEOFCuXWI2aqX7pF0sC0+9q2q6Tr5NgyyuQRzDcuRa0U?=
 =?us-ascii?Q?Qr9QiEok2hG6piG1Sgc0XJ2f7RWji0GLay3so6LpJjFlVKYKhlrVrS8/R5M9?=
 =?us-ascii?Q?AwuVTdB5PfI9ynt1rQbxDpDjDx2gWI2FGuLMIfWg67DS7WHGg1G3GRyMOjCn?=
 =?us-ascii?Q?LFiC/t7FE7SMPt5MPSV21dC4mCUSrieDlMOK5F5cpqlrvx3QsIKX6EvDiPUw?=
 =?us-ascii?Q?eHtKMhveBBCHolE9B5+go176wIeyeJkQ4MyeoktGuHLsm3RLXyORkG1JGNA6?=
 =?us-ascii?Q?m9FzAFjkIz3bSYLbhYx3m8ZurqeDz/6YG1HD85f1yJSlgRFvtJ9qHauhdEgM?=
 =?us-ascii?Q?Kd+/Kqsljbfq7LITJPUUnX9NXiL1/Yq0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 20:17:21.7817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2348dce6-3318-474e-1642-08dd1569d366
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120
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

ISP hw_init is not called with the recent changes releated
to hw init levels. AMDGPU_INIT_LEVEL_DEFAULT is ignoring
the ISP IP block as AMDGPU_IP_BLK_MASK_ALL is derived using
incorrect max number of IP blocks.

Update AMDGPU_IP_BLK_MASK_ALL to use AMD_IP_BLOCK_TYPE_NUM
instead of AMDGPU_MAX_IP_NUM to fix the issue.

Fixes: 14c11b71985c ("drm/amdgpu: Add init levels")
Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 735a01c58cd7..b5208a16d7d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -144,7 +144,7 @@ const char *amdgpu_asic_name[] = {
 	"LAST",
 };
 
-#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMDGPU_MAX_IP_NUM - 1, 0)
+#define AMDGPU_IP_BLK_MASK_ALL GENMASK(AMD_IP_BLOCK_TYPE_NUM  - 1, 0)
 /*
  * Default init level where all blocks are expected to be initialized. This is
  * the level of initialization expected by default and also after a full reset
-- 
2.43.0

