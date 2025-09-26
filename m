Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AB9CAC5BB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 23:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F40D10E174;
	Fri, 26 Sep 2025 23:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="INeKzxM5";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4CE510E174
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 23:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irIv4lDwrlPWzBh2z4DoxnYBqZBVDlq4o8birRgwAMfaGhH/NWY7fkYWvENpyKgwmVgXhIdnHeEFkraipgcN1N8sIbkBUEFTIJO49SD1HEm0kqBrRPUB8zepkMRiXDCy/ATBzX1Uf0pCe1xxi7dSeLFYUMdSc7pj05ye+XUC/aWBI1ag8GWlFBQ8euxW2MAT2+rNkSL3eOp7j7byKg+ibKSFVUkTt1lky665NNEW81ccTrGYq6K9PQIysZFkZie1n7/XzTaD4HFslwL4oB9TR6sHtRTCmxlBvg/vufU/2SaWRA07l0vijoIvkhyQiYJsuLkDl1GBDzLNs/lziE+beQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7eN3NF3dvLnzUwboZ5AY7ao1CNC3xKU51+e7XKpDoM=;
 b=cRH1L+2p9B78N/7WP8nKHa7A+4ejqikTk4XeiXuxTNhZq1w9pLgzhekp5a5ZZEClIih78YA6KO9WoIijNJlnu8Nf1nlkKtor4IICBpXv2FiiAt/DflPLrNid6RDjZGBz5JFWLwEtVuxknZKVlMAKZTtPgwWxoYPaYgipg7RfS6O2DSuh+aRRkK5hAwzNb2psBkmT7lhZVOFi+LJ8uSiAeRTpwsKxUEISon88dsI6pkxktL3CjT+oBGt05hKpuRGx3CqXn7TJc5cUYOA/CO2oHvz+IOZQBNs+fbR6Zrv6WZ57s4jt45eWP/i2MT1L/z2EzP67CeR6huqwEcSWPs14bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7eN3NF3dvLnzUwboZ5AY7ao1CNC3xKU51+e7XKpDoM=;
 b=INeKzxM59rizcG3kebJYO8pddkBRWmh1EKIkPWr+86JITKn4W9tMNBmb4ShT71X4rRdTq7eaPilPq9Zf86RL8la8a/rkgP8RphAOYha+KIcmrtDlCCOtuueR5bx0MjilVjFVYqeFH9NVUxkjDZngUx0Pe3Jh9E+7RYVUKz7Oc+o=
Received: from MN0P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::8)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 23:05:55 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:208:531:cafe::20) by MN0P222CA0005.outlook.office365.com
 (2603:10b6:208:531::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.13 via Frontend Transport; Fri,
 26 Sep 2025 23:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 23:05:54 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 16:05:49 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Tom St Denis
 <tom.stdenis@amd.com>
Subject: [PATCH] drm/amdgpu: fix handling of harvesting for ip_discovery
 firmware
Date: Fri, 26 Sep 2025 19:05:35 -0400
Message-ID: <20250926230535.5632-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e0f39a-c66b-48bf-b65c-08ddfd513f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3IOgs99JMy7WlO18vDICqAsvG4yOC5FRC/ef182TO6QIkvHMug84kLGdhYXT?=
 =?us-ascii?Q?pLEddGDKCjZbR47I6hAbhLdsMhxX3yM47ypmOsT19IKCOQClQ4hG6HF2qpPx?=
 =?us-ascii?Q?JXRNDTmCONP3dmd8INQQXOJg9Uer6nhm+BFEqyCEKU3Mkd2dSqWm9VbTleU+?=
 =?us-ascii?Q?Jj/xorQ51jQ4I03FYNDNSVgiW/PlMQ1LPbMCZfwcAjP7v+SguJ82bzG4v/H0?=
 =?us-ascii?Q?FOnNbuhB3j3T3FswFDoRPt2x230EAEiY6ldP5nc2XMx6yU5bnRBLyft+lNkw?=
 =?us-ascii?Q?5lRqzikEAMphG9mJkhNCLREWXCkNmA2qeTQHGslNlhc2qIdWFFDpI/Xtl1LJ?=
 =?us-ascii?Q?9ecChsU0XmbvOoUVyXTXsw8R5VelVoXsTUaKW8QlSbqBBiIbnGmuEmVQ3Ja2?=
 =?us-ascii?Q?aGEafPfmLBAuJbVFvWX/YQaNiQWioKsdDwKQHX99Ez2iiDe37Blb9RcXXrPc?=
 =?us-ascii?Q?j0yFY4F7SwNLoyBolG1W9ar0Fi5kPjVz/HKtz/pPn/gqo3PapLnt8hmQ05o6?=
 =?us-ascii?Q?JSoEr8RNXrx1RX6DzFeOSwFq2cskC5eNOaXnExvbxE0jkbbxs92z/P3Bg+rS?=
 =?us-ascii?Q?CZ7OZ5wpMCjELdQ2hP5ObZJXIi0rjgl3HA0yR2Q099buEgP6kxxdIW18lfGd?=
 =?us-ascii?Q?QkB5cIDkLn3qv7D8TrvfC1z/zJq18Z2q6LL72C1ewgiyicB5Q1ylARSyf37M?=
 =?us-ascii?Q?9dkneaybX+IVDnPr2cEYIRWVwQfBznTlZs9AHuI8HTLTJ6bq7zcbBZpZjOZi?=
 =?us-ascii?Q?TfX9gE2RAqw3QFcPB4hvsVu+YzhwxE7qQAQ+GXNCtIZFioCJTYKhc7rek10G?=
 =?us-ascii?Q?D1882eECuXq7nYcZaExWoor5gJLdTYIxCJ95a7Zrq4T3b1Adamgpc/PbN2Vm?=
 =?us-ascii?Q?YrmU3GAWS+wKv5V3s5PWB6tqhj0uLGUIN4/NO3jseb8cSx0UZmfuBpm3c4NY?=
 =?us-ascii?Q?Ih8G3rg/tJrp3U3ctokCrEBP7+kjbgMCROwWbDMmjn/9YWm8ULhysA8K2WbV?=
 =?us-ascii?Q?+EbwD3bqr3CheuJ3/2vb7zEYFPTEhNEPbLj0SA13lQ3/myssVJEl5ao2jPb6?=
 =?us-ascii?Q?WdqgHaNFzslPSJAqtPFFkG1xlCvNEWR45Joj0xf4OyXqFysIRsGL+5RJKfd0?=
 =?us-ascii?Q?IM+QLT/7Ckfkfek2XJVvPEAAl7jboZeA4z1GtOfekn2Sywz63bunOYewcHSB?=
 =?us-ascii?Q?Ciqu+I0r/Lt5OaYl5K8Zb2cawJu4SMxgbTwkV2ug1sNPmA3VzuA3KDEno6BY?=
 =?us-ascii?Q?xbhlzTitF7CjjJ/hEpGFtERcFcw8PgyMy1QXv9Rny3l34JKCE5zGQNbWcpcr?=
 =?us-ascii?Q?ymCBkJxlAhv+wfRdgj4Ypl7xs8Gw2lHONzZhFlAtO7LuQmDitHDdchvqKo8l?=
 =?us-ascii?Q?GJQyfbv9I4LoMgq90ouuPnqgiTN++eTVbRCoaZEHY/O7wWAqXIKdZxNS5aGe?=
 =?us-ascii?Q?DTwPhahc9FkEdY6jcPUmJtGGC/+ZzCKK1rwKQHroH7wjjIcPHD92jS0mcxA7?=
 =?us-ascii?Q?Ghg1sgjmCdQrY6UwAECtXovFYaRrkvpP5Md99lv0U1xELHgCoCUIAjLkAxz7?=
 =?us-ascii?Q?trmDGc5j4x/dK9zebSo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 23:05:54.9817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e0f39a-c66b-48bf-b65c-08ddfd513f27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
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

Chips which use the IP discovery firmware loaded by the driver
reported incorrect harvesting information in the ip discovery
table in sysfs because the driver only uses the ip discovery
firmware for populating sysfs and not for direct parsing for the
driver itself as such, the fields that are used to print the
harvesting info in sysfs report incorrect data for some IPs.  Populate
the relevant fields for this case as well.

Fixes: 514678da56da ("drm/amdgpu/discovery: fix fw based ip discovery")
Cc: Tom St Denis <tom.stdenis@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 73401f0aeb346..dd7b2b796427c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1033,7 +1033,9 @@ static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
 	/* Until a uniform way is figured, get mask based on hwid */
 	switch (hw_id) {
 	case VCN_HWID:
-		harvest = ((1 << inst) & adev->vcn.inst_mask) == 0;
+		/* VCN vs UVD+VCE */
+		if (!amdgpu_ip_version(adev, VCE_HWIP, 0))
+			harvest = ((1 << inst) & adev->vcn.inst_mask) == 0;
 		break;
 	case DMU_HWID:
 		if (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
@@ -2565,7 +2567,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
+		adev->sdma.sdma_mask = 3;
 		adev->gmc.num_umc = 4;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 0);
@@ -2592,7 +2596,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
+		adev->sdma.sdma_mask = 3;
 		adev->gmc.num_umc = 4;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 1);
@@ -2619,8 +2625,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 1;
+		adev->sdma.sdma_mask = 1;
 		adev->vcn.num_vcn_inst = 1;
 		adev->gmc.num_umc = 2;
+		adev->gfx.xcc_mask = 1;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
 			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 2, 0);
 			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 2, 0);
@@ -2665,7 +2673,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		vega20_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
+		adev->sdma.sdma_mask = 3;
 		adev->gmc.num_umc = 8;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 0);
@@ -2693,8 +2703,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		arct_reg_base_init(adev);
 		adev->sdma.num_instances = 8;
+		adev->sdma.sdma_mask = 0xff;
 		adev->vcn.num_vcn_inst = 2;
 		adev->gmc.num_umc = 8;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 1);
@@ -2726,8 +2738,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_discovery_init(adev);
 		aldebaran_reg_base_init(adev);
 		adev->sdma.num_instances = 5;
+		adev->sdma.sdma_mask = 0x1f;
 		adev->vcn.num_vcn_inst = 2;
 		adev->gmc.num_umc = 4;
+		adev->gfx.xcc_mask = 1;
 		adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 4, 0);
@@ -2762,6 +2776,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		} else {
 			cyan_skillfish_reg_base_init(adev);
 			adev->sdma.num_instances = 2;
+			adev->sdma.sdma_mask = 3;
+			adev->gfx.xcc_mask = 1;
 			adev->ip_versions[MMHUB_HWIP][0] = IP_VERSION(2, 0, 3);
 			adev->ip_versions[ATHUB_HWIP][0] = IP_VERSION(2, 0, 3);
 			adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(5, 0, 1);
-- 
2.51.0

