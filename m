Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDB8C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1100510F392;
	Fri, 21 Aug 2026 16:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XhEKQxu9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012026.outbound.protection.outlook.com
 [40.93.195.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7429610F38F
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:16:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVVYzuObWtDJaK+Bzyx+bzhZEo6Rede89PD61y2wqHk24CH777kFLON5foQqI2vJIdHbsgiET2kWED1KAOitCSkxCq9XI4zjQa8e0qDJWnGrrA10gCcaU2Qm23bJUErzl4cOghduKguH76RJtxf2TPjXSez1Ot3RH1hICziaTm7gYVRG1CuaZJdelmS8xAIfX//jXowxoOLHHsEkSpmo7zbXwnTchsbMXp6Lg2T4jIoOvUESGm3HCNMKxmq9qWyGQ6YSpsMikyO31yvGGh0gDJqegy+7aNZsHrwd3hg9hTg6ByopI5gd307tKjA3L+ytFYHP9rfhfRS0X8toTlI18g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cxqsl3E6bdtq6Z9SIk4/2FDlJbl4xCAjcyqqFf/T35s=;
 b=oZKtvB2uiaBA8+0otWqQXuyk8rn7KruZhQQWt26JzjeQVTo/XGIvk59NM/1Dq91e6QjpsgEvD3JELbhItLLTvrCqmeVzLtMb0swTF0T4s/BZvCNTM0NJzOmjAzk11iyVJVs4o5Id95/gkPqfWcRg1m+G9IZzsRZirdPiHNOjrEJiFIUvR+IwWDKt8eLUe41nK2i62HP3Gzsl+FcSKqAbP1gzom6ER5+LkXrZP4QgYwTN1M5l34DEeVUuXIBX0ljoiH3xx8rmmxkBNxVfhi8/Is4NGeFNLwNeVlbnDdpdfBwWFicGpFMN+p+c+fx8SK6LB2vf+Sg+/8DZutb5cV9EAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cxqsl3E6bdtq6Z9SIk4/2FDlJbl4xCAjcyqqFf/T35s=;
 b=XhEKQxu93kOr1yqKbZUbd7aBOA03wJ7k4IEVYvg8e+K1NtlNuXJDl3HoxyRG5ZK1kt4LoV6jQJ8Je1A7AQDdNLOW/UPjhQWZltTQfeAWD9jJfpaAgPoRxxQFRKuDgOlpYghVfxrOBj6isjAZjhL3N6d6JDo+fLpteX0bnBWvg2w=
Received: from BY5PR03CA0008.namprd03.prod.outlook.com (2603:10b6:a03:1e0::18)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:16:07 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6d) by BY5PR03CA0008.outlook.office365.com
 (2603:10b6:a03:1e0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:16:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:15:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: skip DPX mode for unsupported GC parts
Date: Fri, 21 Aug 2026 12:15:45 -0400
Message-ID: <20260821161546.754333-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161546.754333-1-alexander.deucher@amd.com>
References: <20260821161546.754333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 50800f2a-edd0-4dae-4aea-08deff9f8173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: eaaP6cP8+C09+28ST1ABsRP9lfwQ9d+OGPa/Rs8AMttwE5gDh6tmi4rO4cWScBptq8KKZoqif+17s/aASw++BqpsfA7DtL2w3mU3zhiwN5lCtxH0UhoOs1z2pjRWU2TbpqU/C3tJVeCDj4T91s3ob2tWa6Q726tA8x4FCkqbqBgGYwjrV3GB7MuEZaPqwggL6Rz9JriPOZj6kZUyZ61wICRE+YKZw5jgXO3HZ5vdi82Xkad0SYZ4McYKjAXtUySbi5XjwsKcCjpZODvw7ZnSOZQRRnOA3ggE3rvXVnGbRIi/Wf+YXuRU13MRgzC/PakfVCk74cYuYVdQGicRwT2d0ULewINyRU+07qBV6nJmVYfG018ZqUdx5xM0OhHRhkRAOxTXeT4tKeigmWBC7TJAn8ykTKJdm2IAETpVCkl3sLuwOyGfNvTna1IiNBW4J2CEowMRKNrULl646WdrxqUqbtQsRSsieuEPYf98beT5BKdtUEzZBIQTW1rvFp2/B4atCNtijP0p05RPe46MtmdVZh8+rmJfXkv4Q9/Nx28g7j8RZwRb+seVDcv/HlVpp6eq9UMq0opjhTQ1ipcXQe4O/3yQuc01HWB9lCDnZ948BZraS4Nuh2rKZaeu8WPLr3Dx+uqTpgciFLqpabZsQfG2OR8RxYiCSF3KdirM2cSGS8fMN8rqj/wLdBaXOzKQlqWOVkAQ/0BHEd8CDhsfkZ3XPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kKzkXkw7W2/3GBiFeI+jZvXmpG4ojdxp59Ka/gKz5Sp9oFdfzSTDpYYqWPdk85oRym79CIlDA5K2DAAw8cgOC6xYS6Mu7US+0RjI2n4HcRu1rBYV44p+5ebwFQsvtjPYmJDSnPM4D4JrJOre7LEuuIKcKLjuP+jeCV8B7CjbbPcrIUYRZTJsvG0ha2YLDCFWvXvnn7v0KS/PwOqlU4Y/Zaib/kJ274W3oyUIapvUGhj4CR2tKwBuay9jVqfeUXj5H6Q/5DgFjLlM/wC/uPxIdvdHqTW0XF2rk51U2C6Exmjrb94E3Qgkewp8UjY3b9BiaorItQ7hDkD1QDT0sECVmdYx9N+taBDY1SZNFHLDrvJbGqmPN5undRdAJS/+wuu6ftJk/FxazUrE15XCMn3gSwwfv9rrCyOPKI6MdHwdJUEAc50fcXXNibTXlyzbkir3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:16:05.9357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50800f2a-edd0-4dae-4aea-08deff9f8173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

From: Mangesh Gadre <Mangesh.Gadre@amd.com>

DPX is unsupported on GC 9.4.3/9.4.4/9.5.0
skip these 6-XCC parts,so do not advertise it.

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 14293d52cf104..18f4455ef0a8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -665,9 +665,13 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
 		break;
 	case 6:
 		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
-					  BIT(AMDGPU_DPX_PARTITION_MODE) |
 					  BIT(AMDGPU_TPX_PARTITION_MODE) |
 					  BIT(AMDGPU_CPX_PARTITION_MODE);
+
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 3) &&
+			amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 4, 4) &&
+			amdgpu_ip_version(adev, GC_HWIP, 0) != IP_VERSION(9, 5, 0))
+			xcp_mgr->supp_xcp_modes |= BIT(AMDGPU_DPX_PARTITION_MODE);
 		break;
 	case 4:
 		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
-- 
2.55.0

