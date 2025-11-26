Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BE9D111A6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 21:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C56810E66D;
	Wed, 26 Nov 2025 21:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OLZwFyk9";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 742B210E6B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 21:27:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+8eGhp/4ZWC/iNZ5vEfZR5owWxI5+LofF1CgONLOtQxpMf9wvi8f/AByfcdNos8b9x+tJSdW/fskA+A1QUlxjMvGfdFA0PUxVGduupekuTzGbkjEEE9sTJ8zjhFL8+EDSZgLOzVWkIEnhRiylMwKvIui2z2R5/h433nRTf8qJjAm/INN9dccTfTlTazBJz/rKhntuBCx1SDY6G0sYKF4uzraiYyT7ziy8vVwKXJS+6xiDPEHZ7nD/DKjbJhiou85zZtVbzZVWr4SE42ROOQSDD3y12cUOo7MiOjf7pUXHgPml/q8KefcmSCHiOgqhfo2Pnj0/If/uAFLp5c9XTvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY76L2eug1j1sPK09j2tphhytb40kcTietodF8qVNDY=;
 b=ijCiWFezCWZnZchr7vLp4zaW4RSjoJcTbwN4zTMiisGEf1pjjTV8ilXE87YUFAFZysCwR7akU7znX+5Q0EGsGKY5eCCN3Hm8sOSCxCGoTUne+0Gwcyf3R8GB1vXEfANYwyjONsgUsMKoZgNfu4Ma+WMzEPqL8iucWHfRXQF4JiZZJ6WA/jLxndpX/LlBwZLnptUIDm82NNy4UDzwsBf90QRavwoVqL7IhJ6n4UqpMGdidwV6YvBRlXm0oZRLlIpZJYxzyX0x59K0B+NfuptZYdCnN48BsEDTPHHFukw7EYEChH8f+nUODjL1/0FNnC4Ivix+mqr/NEe7l4MQeecpTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY76L2eug1j1sPK09j2tphhytb40kcTietodF8qVNDY=;
 b=OLZwFyk9VNceuSyWjlMcteZPYu6rfT0SZosyoN/w3EuBHrLC4ZYYsJvYIuWHohS0KYz7Ov3BMhMrUCZkA5BmQ5dGAW6x1yfmAvvq/qN+ijQoTKaWSL1FkuFnRLsOIADEaXMBqSvqNMjqV8vfJz3DRgdfR7Ja1k13Salk2yErgmk=
Received: from DS2PEPF00004562.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::507) by CH3PR12MB8581.namprd12.prod.outlook.com
 (2603:10b6:610:15d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Wed, 26 Nov
 2025 21:27:39 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:f:fc00::207) by DS2PEPF00004562.outlook.office365.com
 (2603:10b6:f:fc00::507) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.4 via Frontend Transport; Wed,
 26 Nov 2025 21:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 21:27:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:27:37 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: Bind gfx9 MQD in GART with mtype RW
Date: Wed, 26 Nov 2025 16:26:29 -0500
Message-ID: <20251126212632.1522315-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126212632.1522315-1-Philip.Yang@amd.com>
References: <20251126212632.1522315-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: ac71be69-8600-41b2-b8a5-08de2d329fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ercoVQqa5DU4yCziD6OlK9EwpMwDF1Yp+m/LIPIeaPXDp97OctNqUgzWjbRg?=
 =?us-ascii?Q?kb45rKmzvrualCHi+OJ2ZDEW+l+t8UzmT73FOJgl6hklUww9Tk0QXWO7LlL6?=
 =?us-ascii?Q?9URtHgQMoZnCKipEfS72oOJv7GjSL+NJAXTfZd6VcO0SK0QIotre6KTqjHPX?=
 =?us-ascii?Q?hjW3yFv3u2i/s2gNy5c+s7asPXAcLfUyRXCjwc3DRrxxog7ZVEOfRqgO8uAB?=
 =?us-ascii?Q?aZdgvHgb01MI/HY+kHq4wU7JFX4em2Nr5b5W4JrRaXJAXqHdNKMNQPqta0wg?=
 =?us-ascii?Q?NGuy+cN6i1lfNJF/vNj9RkANSJtz0YpXVnRaJfH+ifrO4x9BJyyXIOtAZivv?=
 =?us-ascii?Q?8uv69rfDclQui4mvmd7YTlmfnclKI/+HcStFbdBzFvnaj/jc+M/sSSLKYY8R?=
 =?us-ascii?Q?NFezIjTgBE2sMocULjM9OG2XxucGloR10Ai9qDjY/jX7KnjkMpMiTWumwaan?=
 =?us-ascii?Q?rz/PL3nb+1WyY5MgRN+hPhTvVaOXBi4tM7Gf260542XvjIOdK8Dku1u3+IY2?=
 =?us-ascii?Q?oWO74VSN0QsUzrNk3gd7oCreskOfKoNGeH6Xszajbly9KcVj10JYJbssf/wK?=
 =?us-ascii?Q?nRSIX64HGsO6m1K8OqBzDDXuiMrnFBJAX/frgMr/FbgOSmg8m9iUE12i/uM/?=
 =?us-ascii?Q?Jrr+h7VMpwY7beCvfikELAkH/CY/kSwe9qaI3ghFuS3n6TaHtJwAO0GcDXUe?=
 =?us-ascii?Q?Qv9hSn3dqk7KIPrhDQ90lzIZQ+ZPjyoXsltrrkWdxGJLU8Cfiv8nM3TWD3rd?=
 =?us-ascii?Q?KJTm4Vs2MLSkfS6DlV/L3KAiOzeNTI8bAkPbydURZtoUQv/oL8G5PWK9nBkV?=
 =?us-ascii?Q?f3cNLtmR+y1lNjNIKRgF9Vh+6QipSKqN8mNlUrc+/1bAKj5HKVeroonSSBab?=
 =?us-ascii?Q?LirgYc4mxoK2SCLqcs5mFEdzA8tqtj6Wm2BvjeEC3gTqcuKfpFN9i1qSPSlT?=
 =?us-ascii?Q?MNF7R+/7RnMNU8cEUFGeOWeLxP0JBTmVlnMg2ggJziYmVtS/+gcXXPnllYYc?=
 =?us-ascii?Q?tFa8VXnavpRxhF2DXlg4sVXY1NSOQ5Tf3WAH+R0CmDrwNsmUhg+zRTpMLbn5?=
 =?us-ascii?Q?aem5zLocDQcJyCq7kMZwMW8vvlCbi49SPUk5G4ZiqJwoZT8LsjHbISMOz2dm?=
 =?us-ascii?Q?lY10F63gTIChOg9458h2A30HFbexLqO9ikvKHFHb7PSvb0Ku2JXEbRWlnE7Z?=
 =?us-ascii?Q?5RFfViD1+jfppMd8UUUzuuqg/s6ukIxhohM2Phc1g3hpvImP41t/shQJm7pU?=
 =?us-ascii?Q?sQufqMcDO3WWWEMHX+sPDuyUs3ImIsNg/x48Lts1QEUb6dae4flD+zgg+6SK?=
 =?us-ascii?Q?AQrNIa8THkau61wPQg2QD+m/S94Ye791gnCK9AUHH7CdUIWjsoyd27VJPKSm?=
 =?us-ascii?Q?6qjt3sEMtfOph85j9QfuNFgDEvceU2kAxD6ASE52MEoK3dJysXA3acrGkEyA?=
 =?us-ascii?Q?trmW6RzsD76W3WPCmDzCEe0itwpYi40g6iQZIdznRCFk+VmvkSLifA6Khq6v?=
 =?us-ascii?Q?BO86IIUn1soCHP4Hg49EQoXv8L1vEZ1Tv+3VJPgam96T7/IrbATTeTdFV6wg?=
 =?us-ascii?Q?PzFy8fkZtKedJChUEFU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 21:27:38.6710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac71be69-8600-41b2-b8a5-08de2d329fe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581
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

For gfx9, bind MQD in GART with mtype RW to enable caching, to
reduce queue switch latency.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b589fa9370d2..b1810d0893e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -840,6 +840,8 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	int i;
 	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
 
+	flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_RW);
+
 	pages_per_xcc = total_pages;
 	do_div(pages_per_xcc, num_xcc);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 330e4bdea387..cc546c9ef34a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -101,6 +101,7 @@ struct amdgpu_bo_vm;
 	  AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
 
 #define AMDGPU_MTYPE_NC 0
+#define AMDGPU_MTYPE_RW 1
 #define AMDGPU_MTYPE_CC 2
 
 #define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \
-- 
2.50.1

