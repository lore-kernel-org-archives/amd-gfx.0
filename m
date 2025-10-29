Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FD0CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D379B10E80D;
	Wed, 29 Oct 2025 17:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AOqCInnI";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012019.outbound.protection.outlook.com
 [40.93.195.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5CD10E805
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqUkYJ72GwqEf3Mb0y9+/fmpidlwc1M6A5CHkSi1qnqfHqnL9vArGRKzqvTUVuDkD5MLnAJU9weS5LPpXDhS8JP13Fzloc80szsrbSHVKioa3+cxHloXXh5+5mk80Rv2YrjlD6uZKN2Q/T8UcVES8QYhzewjL8TqyMm64yP0f73q1sF16h6nHjheTwyGhb0wT29RGqbxsmLs8IluUNmlU5/2NsHAcvWmpuXisGBb5rnJ4cU8GB9ZaW431O2h3bWurSoayJJy30YfYL7ItT8GanmFMnp7GeZOcYxbYpl0TIBzLVkAU/IY+OJES+/yIFgiyoolq2uOmgDd3K+w2358Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMER/LXscMua2umjROnzPB1jSEI0F/ilVscVdEgH9wQ=;
 b=RG4q960c23GETlYKkt+0p8XpiHC2VOaUa8QNJDj7Q+jSfb05xDUPz6cEreJNeXj0Q4sAJ7nRWxM8cM5VN57gxSTSaM4/0AOT1wNh0D6sDuYM/ieuquBoRMHmiENyfAz/c8GkgH9SvKAOoiux4YBQsfy6pYt+knyp5VBN4BJnndUHcuDAkj43Jqghi8i98Z80War0ppK073EVSZKXxY0SqGEYc8VLJHgRnxz9El7yz3Ndzhei5M7sFnn0eocalBMY727OvCSZ9EDDt/9RqQSey6mnSrSV+VK84OWcuyGF80IRBA/fU080lrGnaQ5/LQU6dEWcnQzrqlbkjIJ4j8AZkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMER/LXscMua2umjROnzPB1jSEI0F/ilVscVdEgH9wQ=;
 b=AOqCInnI+XY0xFxIyjpBGYfNxcqx/ROlE4uyJKKS6959bAx9ymRxhEmZNnFiqRADtmb6VBbHrM0QBUwRBF0p/cvOgWBrencLrXqqOBBoXhp3rg34jGCfQrhsLLIOiyZBr5GBomqYoV6dvvWNDfbA+LoVbSXAD/B2NBoh7Gw2Wm0=
Received: from BN0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:408:142::16)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:51:56 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::4d) by BN0PR08CA0021.outlook.office365.com
 (2603:10b6:408:142::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:51:56 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:55 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add hwid for AIGC
Date: Wed, 29 Oct 2025 13:51:28 -0400
Message-ID: <20251029175137.2861556-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 877b85eb-0f4d-4602-ca20-08de1713da37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AAagQiKzJrLIzJmT73HoPfDIwwTONsn/jRtneuoGMC/PaDSDxtEyH+gEAZNW?=
 =?us-ascii?Q?pPwEcvtP6Z/x0dtECvPlbK+5nzZnW7+cx0ylilkPyH1IuobDcz52ksoyXnHU?=
 =?us-ascii?Q?eWA+TwnX4tUQQXW8X9XASkgST/Bjm8wncP7TUl94ql1iyqRcVdbw5JevBF0E?=
 =?us-ascii?Q?ISxZRtkdtq+CyZVJkyLw1wF6yJGQoR/loWWt+2+vQxEoBKIHgR5FipbCgZYs?=
 =?us-ascii?Q?698+q/Zbjm207dWJwdZS+J3EqDgpuKtAEDWIoJW6rfecY/IWuJU0+dv4cjoE?=
 =?us-ascii?Q?RSp0LvnbhJ0ASvgdd9PprPw8B57jwxcLR6yFjBAWLKOYzAJHd9DJ+lHwb9eL?=
 =?us-ascii?Q?AdDx0gJ002e1TTuaWfwWsG+2s5cJV4uLxyfmPusGA/n1ZtNYptJ8dsVHljTW?=
 =?us-ascii?Q?dD26cfpw3m27MfOvV1MtBQz6Y/i5kH8H6E84Dgq4pjxoImRgWzIJ6PolTvKu?=
 =?us-ascii?Q?gQ8fBm83DJ7N90387hS5RJ8227k4tK/MQNi33Ks74vkgX08C7TsJ5HjN+y0p?=
 =?us-ascii?Q?XgY3OQ54FINxgV0NczufHx+Id4OgWNmM70pve73Ixiuk+AkzEijVYMrfa4av?=
 =?us-ascii?Q?1jIPm+5+OEYXf6iOATM3hHJ/DD5KRWK+5Ng2bxisSOXXR0K0gey4X0H+UK0z?=
 =?us-ascii?Q?izUPnFVM+L41xnpk5Z0yg1kweM44WsNjMcCf62GIRkXen0gj9RrZBSCRNGaT?=
 =?us-ascii?Q?JTslPovFbPVtzgjpBp4p8grxJDb/c3WCRWdwWqhvKCYdT6fMasaFJuc3bbyN?=
 =?us-ascii?Q?fBlYkVBLuC1pR6fPnwLnb3WvuxB90GdpkKGpSzdTPZlrt5Ye+dkt43ElEUgD?=
 =?us-ascii?Q?CarH9IIvlFVC3Tt/0Lbw/+sBzHUaOraGgr8kgbV1WVFb7AY7Ce7r3CNuPsTn?=
 =?us-ascii?Q?32cTTShmEd4Mz9YSH7FhHPDym9aviQMEuhwnKJ6j26KjPG97+DPXhhfkVYWN?=
 =?us-ascii?Q?R8D0BdJRpNE2/QktajgfkEPO6cZKcvSDAmH411FVJbAe6053hO+4pngwMswY?=
 =?us-ascii?Q?Nlq/RnrO2gVCg/uPoQNkrXhEXFQp8pJcQJNvcBGVzyPvxx+va51XNc+p83Pm?=
 =?us-ascii?Q?KYWz0gpkYMjXzkFWdBOE0J5eF+nb97U8eZF/yVOaDeFL9yBG8vsXcT3sYseD?=
 =?us-ascii?Q?jN3EVcCmFlEVDS6Msuug96sAzC5uxRnAfQn0sJ3TL+wIYf8h69+75DY8rMEd?=
 =?us-ascii?Q?hkyFs9h0F1oxPHtxbej14vOTJGMio4gfZsmYJlZSprej1z3LdkBWIpIilfah?=
 =?us-ascii?Q?scNJv1CyYzvLNtt2Ifm8aXSnnE3LhT/SUl8uZIIjFAU29pbw+zIrQjRbtZe3?=
 =?us-ascii?Q?Y49+pJa5Og1lLintPBwjb3/FE/sIO6ANDD/8rFZ8j2U/auyL2ZBIsqG23sXW?=
 =?us-ascii?Q?mPd9Jh0nTJKag/zXkdyH7GH5dQ5QGxnH77iQ5mnqNZD1qOntvUFQMw71goJq?=
 =?us-ascii?Q?xSN7U/bTfPtlRKwmXMVnUMQitxP/V37u0QMGcumrXDy9dHi+5PVQ6EukcEV8?=
 =?us-ascii?Q?UVc9+RT6uY5CTY/O2UgJ3B9nhG6uJursj+Um3NBC6NDsSJkzMGpKEpUaAfG8?=
 =?us-ascii?Q?eHcBRGzjN5fiKrEFeA4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:51:56.5676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 877b85eb-0f4d-4602-ca20-08de1713da37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add hwid for a new ip block named AIGC

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/include/soc15_hw_ip.h     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 923f44ade3d38..b0d2597d01358 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -796,6 +796,7 @@ enum amd_hw_ip_block_type {
 	PCIE_HWIP,
 	ISP_HWIP,
 	ATU_HWIP,
+	AIGC_HWIP,
 	MAX_HWIP
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 00c1d73b9a0ce..87588d0c8a13b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -210,6 +210,7 @@ static const char *hw_id_names[HW_ID_MAX] = {
 	[MP0_HWID]		= "MP0",
 	[VPE_HWID]		= "VPE",
 	[ATU_HWID]		= "ATU",
+	[AIGC_HWID]		= "AIGC",
 };
 
 static int hw_id_map[MAX_HWIP] = {
diff --git a/drivers/gpu/drm/amd/include/soc15_hw_ip.h b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
index c2efc2d2bee1c..a20e59584dde7 100644
--- a/drivers/gpu/drm/amd/include/soc15_hw_ip.h
+++ b/drivers/gpu/drm/amd/include/soc15_hw_ip.h
@@ -101,5 +101,6 @@
 #define XGBE_HWID                                        216
 #define MP0_HWID                                         255
 #define ATU_HWID                                         294
+#define AIGC_HWID                                        295
 
 #endif
-- 
2.51.0

