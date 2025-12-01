Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C773D116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 23:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84AE10E4CD;
	Mon,  1 Dec 2025 23:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qVNVGohc";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011001.outbound.protection.outlook.com
 [40.93.194.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F15510E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 23:15:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/gkLEMPe3OTUIsCkGWKkZXMcBuGm+FoJynFU/HIOe1wFEzmInSPDn/Esv6lS0fUtrAy2KLakS3O2uCGhkMTl39oS4fRi/vJajsB7Op56WBoBwEe34MjrntOk1fbm6rEa7s4DoAlo4eRfRmmI3bNQzXzc/sprT9hGeHfztiNzcZuci9iQkosXxO55y/y+KnQubuLq7IFdFyZ26MurDExB3KbbaEOxL7qT6X2+YD3VbpTzFIrQjTJZf2SOypulkM7pi1MqgsddruTp3R/usRsV7sKGe39mE4rGCszj3KE4KdSFiF/+dwntxp8IQYWeaQe1/zluMK4yrOy3Tk692IFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAPZIKeeSXNcPO8EcVX1I808FipO1Q624c1Ipp3emqU=;
 b=M02/Vq7v/wKTAqTOe3JIx5fZJhuLBNk8sbVPYeK4xEBJvYqfvEP55jV7uCIsJwd5XBz9Am/VYBz4Ly2W6eN26VxEkTfC+lhqORdJgNYEEFEKJiCGjJMMPoh5eDoOlLhwOf25v4xO+FhhECSZkreV5BEQGfNqnAHK76+uOGfODMU6iwaFHt9wIkrLnkCF7Hu9cUI21pQP5xaajpPRTQ1haSm9NqJZbyRb4PFeJ6PQEBINcXXUY4tolrpMkHmlaJyiygtOEe/pfyl3Ck7w14zNBawvr7X8QLxPmArKZlU1b68qd0cjxwNmrOjQZEBBpd0cs2kyc5lPcK/6v1KjxokbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAPZIKeeSXNcPO8EcVX1I808FipO1Q624c1Ipp3emqU=;
 b=qVNVGohcTLcOGYrMqn+4824Gs2912ceD+EiAKi5OYOswSM6JnUqS/UAEXfLaqmGySom72MUjJs4S8w6L/uQZn8M2e5/wfrE+9Qv7ctFxFOQP8yb0f14qJZLteXk+zkmbVXYKVO6QhOnLmCS/CqifNFHx6h/C0Ha6xtzvFpzoTeQ=
Received: from SA1P222CA0047.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::20)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 23:15:31 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::37) by SA1P222CA0047.outlook.office365.com
 (2603:10b6:806:2d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 23:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 23:15:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 17:15:25 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12: set MMHUBs based on aid_mask
Date: Mon, 1 Dec 2025 18:15:07 -0500
Message-ID: <20251201231509.791954-8-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: d95b761f-1e30-4c81-a790-08de312f85e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MRUAbFqzRb1RBD4fDb9FEH3ywNbgpf750w50+7c6B/cGZPagHvVE4EGBpelk?=
 =?us-ascii?Q?UQSVhVEAeHg1MjaXwdi3v95hlXO2phwd621MsFda4WJVzrimwpj2lz4Ahga8?=
 =?us-ascii?Q?UziCObn62ImdqTg8FLIz6NcpwwLheYPxT9vbClmSI4IKQQUOYL6X9wexC4BZ?=
 =?us-ascii?Q?DJvvlpK73UGO7SxqEXzlH+WjGBN9XM3BgO3StsNNFFY8+vbbw/bq7RLgAIDl?=
 =?us-ascii?Q?eu4tVgcdzeDkIwbRivgiLMUSoU1jyKW5M5iaViMEwyiKCu/WXRILl6BvKK9C?=
 =?us-ascii?Q?ljTYh/8sKoCUWTOerVmiiT4S+Q+VOIQBiW6WRByXI6oITBYJdxMb0aMRvGrU?=
 =?us-ascii?Q?4k2Wne2k1gDHU7h6XPGw/Y9tJiGDOUAEsXQLBTb1vAwCcrZA9iGlCjtt27tj?=
 =?us-ascii?Q?l8QEWjocCd1HrZSalzgKuRHb7zWdp5kNKjohPIM9ItksY8EJuC4i0imrfvDg?=
 =?us-ascii?Q?7reYP4b9TokI3XZMq0Xiq8P4v1Tvyc04lKcB7pPS4OGgVBYg8Iq7jE2cyL3B?=
 =?us-ascii?Q?vYQwW3bNb/WTcMouLx9e0dLZWlaubsj/8MQ0hKYaao+VT/LXdWC87pINGzxZ?=
 =?us-ascii?Q?3c0MfMwGxU8RsY+LfMa4E7p4vO4/TH0nhvq6x22D6yra+aT/7QJH9pYnFEqT?=
 =?us-ascii?Q?ZrTd921J1xfSRieuc4cQ6AKUdra+uexJJ73RZuKHHNvxNmZ3yenCJ0TeQAv2?=
 =?us-ascii?Q?aJlnhgI2oA3ZA+hJJrASWsXACxBimK34CisfV37VouTpB6DuDs0RnBnBCMWV?=
 =?us-ascii?Q?wWUf6CQ3e+VI2igdykOAZjPT62nBfUXWo3+RPHHEoYGcgXRrB7jMLok/g7bM?=
 =?us-ascii?Q?CiNO5cLV2YHzFMuGFpRgJGt0SYfNLluVehTdH5Ce7g6Tq5pff4tb2fJLiiqk?=
 =?us-ascii?Q?XrPwqSR4zjdLVxyfFva79ehTDjZaUiu5Yr/tmUkrrUYaBJ6a5jFQh3p+iIL6?=
 =?us-ascii?Q?rEV67sgzCHYT/fNUDg0sHn+cpYHzVppDD5dGNewkZLmHZVdvcv9tRJdZcISJ?=
 =?us-ascii?Q?IN/7cz3bIFDdpGLjtOUU0YC2kMuoxC1LDAN8B8K/eIRUlLVYYS5JRZurEIru?=
 =?us-ascii?Q?PsNrhoS8DhPliqIchmmMfJFudFDN2d+Y+0N1yHtSF424g6C64tTHT1fvTcaM?=
 =?us-ascii?Q?zBlUNZ5451WATJT7mFkjL7z0PXgj6dmVDtuVGq2FD1stOJ7p2xSNq2bfBykx?=
 =?us-ascii?Q?H7BU15z/1soWSx3O4J7erIq1RCXO3uOr+PUSrBAEC4CpMS/B026s1kCfQeRa?=
 =?us-ascii?Q?JMOTT/Dt7NUbLsXBGjiang1PHshe7h2JRdiWKtZiWlDA5/BQG9RUUu/Jy5wG?=
 =?us-ascii?Q?ZlBToLHSZbXeQ7cZUFjiMfD90MkQDjgsZawfULyolGSxCMWAxFeA1pDLHkxw?=
 =?us-ascii?Q?ta/FSUAa5xUvjcR6u3iZXND5MFHQQFrj9jGGOUzF7d35S6WVJeyK5AknYdVb?=
 =?us-ascii?Q?E2rsF++lK5MM+zu2qqepMZHTO08vqIbHWUD7IQxVs+UOfKYrh7Lq/0yMsTtq?=
 =?us-ascii?Q?UHO/ky6UKT7VWxYL0pO2xl5XOmdzjEL9StTM5e/PbBZNWdGMh28jJea9yC8C?=
 =?us-ascii?Q?s/J711+ntAiVKtFTowM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 23:15:31.1904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95b761f-1e30-4c81-a790-08de312f85e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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

Update number of mmhub and mid_mask via reuse aid_mask.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 74bbb683cd0f1..51243dd75382e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -788,6 +788,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
 	adev->mmhub.funcs->init(adev);
 
@@ -817,7 +818,8 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 1, 0):
 		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
 				NUM_XCC(adev->gfx.xcc_mask));
-		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
+		for (i = 0; i < hweight32(adev->aid_mask); i++)
+			set_bit(AMDGPU_MMHUB0(i), adev->vmhubs_mask);
 		/*
 		 * To fulfill 4-level page support,
 		 * vm size is 256TB (48bit), maximum size,
-- 
2.51.1

