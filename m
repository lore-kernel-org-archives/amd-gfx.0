Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78BAC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 07:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DEA910E727;
	Thu, 25 Apr 2024 07:08:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLNFUV5J";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0126C10E727
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 07:08:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0FXzfhOx7EV4wdn4bfTK9UxzjlTWWdQNpnMdtr/dSM6s9u6zajA8PM0mapvQUmMVJcKWskzJfACt2uzpBeXNYiYFTVxJa3n5a6y1i8LPMjOTYVuvUcTotPGsx5OBZevgCorlN4l0GPTmPQLHm/r7mlQ5bWHVotgvsjQolGevnrHYo9M+X+5aORmn52vO1u6ibYWJGrMvuoCqZfR6NM1zTUXkjUHDHhhsP9O1ls/1l0FBkuguZz8UM3xOrNn+m+TlzvPHaTw8XrjmtNcvQY3CNNrBiNIGK5cpgROQykPxOqZ3yseAgVEa5jkPRlIVg88Yh+YRWNyK3C8W7/fzfgFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cD/IRtV15ZXh/zcu5QNiuL/LhHlNhvs4BHO5FasnPxA=;
 b=YULJkbmWYaaX2WgDWjv81m/etpVW6q1gZ48E7C0KOqSxaUzP5SIWOZp5zQ1XY8W5JT2n6Cqc4bPKfsCqqpU1rGjiG9p5pVKoDwzFu0zQCehB2ep1XvLH5qZo5gCe58NIUd64r/gxJNkdGq1J24E6fDNpTBpxxf+gVkH0n2+TxrNiZFn6XQe/YMfTYOW4Bkow6RYfobJRqO5JyiobrG3qFJhNbl5M0dGh5wjU77BZ/oVaedm/CmkWq+zOrz4zsIHyXUa787PFRluL9aBP7mBptai7ylOVMt6aDfKqHXMsfcKvIdE8nIibUCBwY9QxNEtVS6VXiMPhhJZffUZ4C1ZEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cD/IRtV15ZXh/zcu5QNiuL/LhHlNhvs4BHO5FasnPxA=;
 b=VLNFUV5JYMpCTupAXFA8QH2OwPXQaE/jihoi9IjwyX1PlU9vj+7KF9gopDq079tS/Gzc+p0aJMUcM9ex08osAwQR46nXFLzx223PWky1Rd9GM9AETgpmpyqbDbo3DnPeUhgqSaK98be2L0tX9mMM9XR7Xr4h37QDp6DMW2bG+Yo=
Received: from BN0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:408:142::16)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Thu, 25 Apr
 2024 07:08:06 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::dd) by BN0PR08CA0021.outlook.office365.com
 (2603:10b6:408:142::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Thu, 25 Apr 2024 07:08:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 07:08:05 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 02:08:04 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Adjust XGMI WAFL ras enable bit
Date: Thu, 25 Apr 2024 15:07:50 +0800
Message-ID: <20240425070750.4058395-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SJ0PR12MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cfc5f1-14f6-40b3-ef7e-08dc64f67474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BqstWau3uE0DVUwk2at+KdX2ETNV80ves6NXbxyVPKpLz4dbXsen4bF7597x?=
 =?us-ascii?Q?W1mbAoHy3IwhYLQFoqpFNR7tGWuU8vcV7+h9WuLSjNMsPXqeFc3iv4Ogmzpt?=
 =?us-ascii?Q?48QNmbQ8rSKdMWDKuzmDolzVQ8/DOQ/IeLa6lDlX3VsZNqM+mV28tRvYQ2H8?=
 =?us-ascii?Q?X7UXLUCEkB+QDd1WiA/UrlnmVL8bFvIA+PBBmHf1AW+2aSfnwP8y55wui3zw?=
 =?us-ascii?Q?dtIGujEa5NWrt2YM5i0g59zK6d5CpZewf1WFsGkuQMDDzuzT6FFcdDlOgtUz?=
 =?us-ascii?Q?9inFQDx+bu8rqDkOhrdm5x43f0wio7R/dGKcxxjIiXTCj6tYgSXwu+Y6u0ni?=
 =?us-ascii?Q?BnQCwJ3Z1WlYjej8n6ymfSJBtTUaNw/aro47NSFAb5AXnZAm1a4skT1g+o1W?=
 =?us-ascii?Q?aBIYE0nJMkbGuDhCatwYq38M695au0xMsNgwb6Y07jGpHWjoJg9XY691nJ3B?=
 =?us-ascii?Q?fIDC4geX3R5+WSnfdHwZ5WSPYN0o3vsjxun/GyotExWRAia/OZpkgarSYk1O?=
 =?us-ascii?Q?lkYVzWcukphFHTOaEdiJjq01p1BaGNaZ32CkuYfAgYDV3CbVoDeK1nJ/VxP7?=
 =?us-ascii?Q?UH6qwLfMZE2HEjsr8935xPsHrEC7Dcub8vZpgrJ22l5zfo+u7ay0NVHhe1su?=
 =?us-ascii?Q?u8BdZdm1bGsPUDTtUTPRjBvelgWt152dqpeU7bwW6EZgKIWOq0xSzaxuKtq9?=
 =?us-ascii?Q?tMGPzR1mFa4y41h00YWOVlzGVbZQM70ohhkg+O/qHm/vlarcdCluZFhTVrLV?=
 =?us-ascii?Q?9A1pxny/G0ZPl6EKVwNaqwSPLOPji0OOkD8yblY7t42qkxPRxLilYWEQpCN2?=
 =?us-ascii?Q?9pGwGKrzBQj9UxIlwjEfhG58mqJiFplFpbTfcTmnCtnfAZFJE7NxZyUby3uD?=
 =?us-ascii?Q?BLkNmxJ8brhUakeUzZDlkVNw3uyEL92QEEHwoyOIvGQ+gJgk7S/RmifGiUfJ?=
 =?us-ascii?Q?npAS5aGo+B/nBqyFucwI/kkVnXd+6rB727Hb3JBRWTj5U52leFMA2hc6d901?=
 =?us-ascii?Q?AJQKfkXwPWvRtWBi+34MaFGFGFkHqHu65mi0+Cbia4f4TKHhxudmns9n33o9?=
 =?us-ascii?Q?tDH+6fvVCL2ekT39YPl8HrWUly+Cy+pefhp3fl8+BzFblSjoDvBxEQ8pqp23?=
 =?us-ascii?Q?Ti5jYSjkKGK9HgJQTeaw6ZqzC9uNqTtDWDi6OO4tHTfUSdneCxGA8tV4lUsV?=
 =?us-ascii?Q?+cwdAlyJQY6JV3O9GD4v77BPhcqQvwMiiHPPYyyoxdlEJEFOtbpi2bMNq1Iy?=
 =?us-ascii?Q?v6Loys2l4dUBUcluU/6IINaZC5Ytbl7wJnIe98429gvdFb713owGrkGtELSh?=
 =?us-ascii?Q?NGVK/BSuDBCNvmeeEUqQJxA2amwzKZENFAMdNWcQ9oORrCTtznlKLXycWVLG?=
 =?us-ascii?Q?6boHL0SKRjpnjR4X5VBxNc8vhMfB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 07:08:05.8008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cfc5f1-14f6-40b3-ef7e-08dc64f67474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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

The way to get ras capability has changed for some asics,
both of them need check XGMI physical nodes number to
set XGMI WAFL ras enable bit.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b2a883d3e19d..ea77e00cc002 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2918,13 +2918,6 @@ static void amdgpu_ras_query_ras_capablity_from_vbios(struct amdgpu_device *adev
 		else
 			adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__VCN |
 						  1 << AMDGPU_RAS_BLOCK__JPEG);
-
-		/*
-		 * XGMI RAS is not supported if xgmi num physical nodes
-		 * is zero
-		 */
-		if (!adev->gmc.xgmi.num_physical_nodes)
-			adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__XGMI_WAFL);
 	} else {
 		dev_info(adev->dev, "SRAM ECC is not presented.\n");
 	}
@@ -3002,6 +2995,13 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 	amdgpu_ras_query_poison_mode(adev);
 
 init_ras_enabled_flag:
+	/*
+	 * XGMI RAS is not supported if xgmi num physical nodes
+	 * is zero
+	 */
+	if (!adev->gmc.xgmi.num_physical_nodes)
+		adev->ras_hw_enabled &= ~(1 << AMDGPU_RAS_BLOCK__XGMI_WAFL);
+
 	/* hw_supported needs to be aligned with RAS block mask. */
 	adev->ras_hw_enabled &= AMDGPU_RAS_BLOCK_MASK;
 
-- 
2.25.1

