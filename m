Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9E1C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5873510E2FE;
	Thu,  6 Feb 2025 13:13:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IXl3qPBZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1235E10E826
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcXnsqUNx9zHzUTowgEpr45sZRdkHgGTY/GbX9Iau/vw1zW7cFhq0XwF+GBwNVsta40pILciFdoa/dJAKJWnqWqIZnDgYvk1je5ZEQ2H9qFqRjJJmdG07d6nQsDljsJNUF2WBNsrhwOwQVfMTalqDExh6O7zqyDacwb/AM0rCkNl390mBEnzSjIGOV27GRmZmLp/rmYE+I/C4mDpGYF3OXBV8WF6T5uJlvkR6/R5+VXbb/7Tj8wpKmZeu912XP03D0r8uZPm8VJpAZHK4SUBG4YL8WluccILcpXi/QX5vrGeOmClm4EZMh+7OAYuiK+EsqVJ0XoF+EFt04KSwhVbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m53LaMik/GIm7ZULEH3lPSwQScjYtCdp3h+Zy+ECHHM=;
 b=ZUZgImipQgwb0UR+yzkuVkFdhJqRBVxg4qAJ3qPofE5op0oETYkoeS25K1St3ylx6rHL+J+RNBlJ39KdTuQ8z8x9Or+exuysLm3ve06xMvtOZiyT1ZVL3R8/0rNnCmo06vz0gAOU8o5lQzJCSEmpfTCC2hyGWVmdRJ+w4J8e5TiYP4HrgvZlqnmuQGoKPNYJjtvIKcDBwrAeE4M74zcAIGjnkMnzXjfstb/+sE/9JSybXZlOLvNF33wo6JLi63F4/6qDaNfwEKoxS+Nxc2aMRFiizMaraSb2vUuuUIQ8rxT9kAM+rAr0eIriVwG69nlTEXTWRYomDY3I6VfmGAZyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m53LaMik/GIm7ZULEH3lPSwQScjYtCdp3h+Zy+ECHHM=;
 b=IXl3qPBZ86i/NxlBW7pmUhVFo2pJVrZ6ixU60Yl63QrvVync3N9imEGSzeFEuCmB+Olhx72JXvucx+Kxe9nh0aHhNtTwB3F0gxTf0j7Ckf893cQeyRRez+SnF301O5n5yq+yVIbxvgvkF9bVXzLTgXQV/ccXDUlXt4y685FdoxU=
Received: from MW3PR05CA0008.namprd05.prod.outlook.com (2603:10b6:303:2b::13)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 13:13:22 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::d9) by MW3PR05CA0008.outlook.office365.com
 (2603:10b6:303:2b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Thu,
 6 Feb 2025 13:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 13:13:21 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 07:13:19 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>
CC: <Hawking.Zhang@amd.com>, <Jonathan.Kim@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: Use xgmi APIs to get bandwidth
Date: Thu, 6 Feb 2025 18:42:58 +0530
Message-ID: <20250206131258.1970391-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206131258.1970391-1-lijo.lazar@amd.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: 5742ff15-c99b-4843-def4-08dd46b00800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QkVsrCAjesdW7sLkTx1CMbJ5hN1uTJJgDxRyxxyWx73fZD2kEOEyheq7jyiT?=
 =?us-ascii?Q?6gYpf8sTteTf0grntYGDZovAEssbZ9AK2CRPmMtZhvwyJxoEYIw1AgycviU+?=
 =?us-ascii?Q?yMJleDL3WTb9PNfsPWpm1ppEgj3frNSfT4heCOGHhlfyyX98SG7xeVE3wxOm?=
 =?us-ascii?Q?lhLi6hq6kQ9CXyQcPd1W3UQODUDiW5vtISF4wdLYMoFpE/c3NvE24tg1Jyfo?=
 =?us-ascii?Q?kS98gUYUG6+JVacxbO3MP4lU2DOJjf0Zn0BWsWuMN4q6XhMSRV3G9cuHIaGd?=
 =?us-ascii?Q?2CRZlMVRHfBzFuxXwSnGyAnbqD1DwkaamjM9oQq3HQW3ZLuWOUTrwCZKowaK?=
 =?us-ascii?Q?uezUW3rhVI09kW39Vzh6UUL1l8HOIjjf6Cb58ImB2W6Yss13gUz2458NWmJO?=
 =?us-ascii?Q?Jx2CARZ7KkQxKBKFrkeANgJYx8BnkvzkkCKaWqN0syYTkoWrX5vNfnjyZkur?=
 =?us-ascii?Q?kolhUnKJQc3KO+FPCrn2C3QW87z8GqzCdsutdqE2acexVSDlVYO7Zi6Xr6u2?=
 =?us-ascii?Q?9iJ3WtFw4jijDWUNGt8IguzoBXhZPpaNnoQNxMAz4j0HlIfzBsrKzQ+1T22r?=
 =?us-ascii?Q?G+8Q8+1zrH1QQejYnoq2nZq8j/PThLW8ItUTGskxO3y6TQg30jx+DpAboPPp?=
 =?us-ascii?Q?w5luW0Sb2tbvOiawbqsTvDiUqA1mOJafhMLMlDWNppVRynxTKvu6YtblILVR?=
 =?us-ascii?Q?dL7DXJol9bnkuhNsv6ax3vTDEsO6ps9St/nDuVjjGvwr40uG3AAzdh2DLnS6?=
 =?us-ascii?Q?qHbhfRSyZOKtvtRCeHxXRt2sTuBWqEIp6Qxgtdotzye7z5Xkap1zyz0YX8Z0?=
 =?us-ascii?Q?gEJQVgw4MopFkvYlskzPtfm32BxO0Tx67fccy0hoVOalk6sNYzDQ2UMrmNFd?=
 =?us-ascii?Q?zY3Enk2ehfv4KWFIcJIPMeExHhictLknkUSkcuW1hEDKN1JmHOG3mrPDSXsl?=
 =?us-ascii?Q?AOKXmYCyVkrABqZxBb+WBLPz48elF2eTfyFZ26TbJXnQUutrlz+F2gpG+21f?=
 =?us-ascii?Q?izzTluT4FiFDt5vLdV0PXdVr161gp1wkHPiL4+etfvtgsNUuCF1CXL8eN8L2?=
 =?us-ascii?Q?iRCJa+I3hLkJSlP45kYxLh+yxumfnxYwjqoyhKEXyE7dqFCZxjPd4rhk+UXI?=
 =?us-ascii?Q?KK+hZzsxAlyR3xsSeIdxzc9L0Cl8IoIL6vCwzhryLAp4e+otw4EHKSXfmE1L?=
 =?us-ascii?Q?GsdLgbAEVbXrkdJN178+mTgLba4y9TK47833qOAASD7jdm/56yQvzaT14v0M?=
 =?us-ascii?Q?drlugHJCf8NVsrLmjZm8FNrzfLhtjxD3umwlba1sd2e7qTJoODPbQlGutSaX?=
 =?us-ascii?Q?GnGHziifGBhpax4E9XAUjcFccPS6MXQN3QG/zUhNEKErRAOuw1bwX+HsFwez?=
 =?us-ascii?Q?/7DUiHmX5/mhH8kUOqhiST8g7Or6XXQkqcZfduLfNXWxmIMquMHJi0YOI82X?=
 =?us-ascii?Q?o13qrh+/RxWADk+wo8fJjnao37g6D/8HgjrNjMfbBkAfc/Rvw4XXNrit/01a?=
 =?us-ascii?Q?VVHD0k0a2sWaZpI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:13:21.7379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5742ff15-c99b-4843-def4-08dd46b00800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

Use xgmi API to get max bandwidth details.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2c1b38c5cfc6..e6bc70fb1eb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -576,6 +576,7 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
 					    bool is_min)
 {
 	struct amdgpu_device *adev = dst, *peer_adev;
+	uint32_t link_max_bandwidth;
 	int num_links;
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
@@ -593,8 +594,9 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
 		num_links = 0;
 	}
 
-	/* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for bandwidth. */
-	return (num_links * 16 * 25000)/BITS_PER_BYTE;
+	link_max_bandwidth = amdgpu_xgmi_get_max_bandwidth(adev);
+
+	return (num_links * link_max_bandwidth)/BITS_PER_BYTE;
 }
 
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min)
-- 
2.25.1

