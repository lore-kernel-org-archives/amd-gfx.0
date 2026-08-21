Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C643C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED2C10F385;
	Fri, 21 Aug 2026 16:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kkh/cbws";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3DEB10F385
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0XOfI9lSAHR6dPFHuG4tMn8SGr5NcEY7EzoRqJ6SP/bhSkn/HsPlB1TqwTz28DEyduabi/ZqD8nTurY+HT+xXVKX1u7ggblGZHBJQzJFfXQt0zXyeX3tsEUBWfBR0WSrX7Y4LWlAeywrPimjpsvAeRGs9VUz18WGcG1mdtElP+C5dhjBr/8QV5YLouBDpHreAAwWmtxglKswq8jZk+HPpsqDEGXj2pMwbhj/1pQMJEo+O28T0NZ7m9RYXBpra0FKGCJp5yxomhqIEydwkOCBq2JKwCIgKIlAMe5gr1ugY/I1enLsQavBQWz/MS9QAqDZLLoCd/n6ktmS0RzmZAMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w49ODTIIYDCN8llbc3hHChQdOPjGHL1L1Zo2MewNJ0E=;
 b=nLmAyfWQl+IP2bjloWqcp7XT2f/QoPSK9QbhJ35xHHLhD09jibwSVHgOqMTYMFYncVQNWHegoW0BufxrH0aeqeWDLKjVw3nuACdWd7F8ttLKUXumGxRJkuZodXm7HgNR7UfuwKH2XxHK2zTA1aLFefVDgwKLNZGUtWW7znOwdqN4ImIrnn1HduBfyRfOhZpD7/yeLShKxjA1frPJjEXZXiLIYYZtAJwdZ2cCdfQ85u1O3BA50sTKOpsCOnUVbnHOqfa4M9ZNMWsAeuPvIfuCgfP3wvxPuHoDzlzahGHk8WIY9fMX90RRaH8OfyCBF5IoMa1LZSs8Am56+zGBz42DIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w49ODTIIYDCN8llbc3hHChQdOPjGHL1L1Zo2MewNJ0E=;
 b=Kkh/cbwsUJCNW1VvQpJ8qByLwRJsWbxkzoZkuO2XKFDSq+nc6ujbSwNvAfJr2pR9dSHI1D1d9rkJX+gFnEWTMF9nZNxxpD+KINwc5No5vXxfUyfbUFUNZ+gYwxa8WckzUMMqAohhaF8s3ohRn0KrwR79tnv5kkPy3dnC0rBE20s=
Received: from SJ0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:a03:333::25)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:14:31 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::92) by SJ0PR03CA0110.outlook.office365.com
 (2603:10b6:a03:333::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:14:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:14:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:14:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Feifei Xu <Feifei.Xu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 09/14] drm/amdgpu: add
 amdgpu_discovery_dump_mem_reserved_info_table
Date: Fri, 21 Aug 2026 12:13:56 -0400
Message-ID: <20260821161401.754042-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161401.754042-1-alexander.deucher@amd.com>
References: <20260821161401.754042-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: d850f880-aa7e-4947-a54e-08deff9f4855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|10067099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GwU1xDRx3PB1J9ej1Xx2uNnE1wHa6zHeJfx8h44M4FcqKxVCKqTDKK+BcEqrtFrot1nUuaguPi2doAIlWO8tiMGNDIR0HG6Lv/QHTrZvo7WxZQ7G253w//6r0CQpqpYKC1+AyG+Ek+fE3vxevwdCAtempL/MSWGwDXbAFxfpgis3oDFOBR38ho0BkIPuBBnLtKYYLnqIXLSSUM34m4xzUPy3NEHNkZKR7hoNz0f/4bILTeqET7ZhsLvYoYCAdPRwNDyM54FJ3DMgUJZO59gyVedaZzX6ahhpSZgUl2AWaXRUDtCrwU6fCorK0/5eoLNm/zIKjdsukjh14RdpG7rZk2TSGmkSSiIf26GbtrBkz9p01INWmwM3jGShg2TVRzpK7BBjwDnGVYRK21G//IxROMR8qkYTbPQHo7EyVa3Yq2lk9L7LgbC6Y0owzDsa0mQWwO8Y4ClrW9/0Hn93caSE+YtvzTNJbG+xrHp9voySzDVxcQJz/Bpnbv5tRpR3bHBOvj1Bi78ivQ4/xIwBT2XgBf0+be6VeK71TYLVu0azJifSXXFiDVmpYxf2beGF218YgB7rl1XCkeL2c+R5DBbyrTCQzluM6TDbtcLFoweKf4izIuq9gVmNTZBQhO+bZVR4Y22Jz4FxJ7QgemqbUSuzCz9S1/n38ap9eTXPCyqwBphumwssFD0v25v7mC3jb5tosOB73btABkMvD7mtIC/wUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: umESSEoWNKOJjpDkPWLt2sj7qLL769AWohe2B9rv99GSRaRpi13JbaXXHqUXZm3lVnf7vySWdxsVBQC8SbXNgNZWTNtHOqejRfaAEtgz+yFxqrx5Y/ZcjeQ/yKBzaJwd8a9lU4K3acUfQEd0twH4uTJZUoJVfB6A5WpBRTvr1iyDgjFf3MNg+IUv5BUh27UMqxpigiFKdtkCNHZyUVeW403Lyl+OdOLxp2wVRu5LotOKtOQRLwY0+B8Xh4GPIYQcUVzaA4q41+a92lB6iSn4BlL93xHUbfzeysHcDnmYUfXy3Y883AGhTB0UZ2Ks7h5RrBbwR6mh/KarF+WlmUD99g7+i53O3etkt+urRPX2fdrl/X/xzUjRIZZ8oAzx/mSW7zg1fxfUyUCYnETaBXHVaNQMMaxGLnlKqm+hnjL9j1koK56hER4k0Z7N+AsDWV1n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:14:30.4833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d850f880-aa7e-4947-a54e-08deff9f4855
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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

From: Feifei Xu <Feifei.Xu@amd.com>

Walk the cached MEM_RESERVED_INFO table once at discovery init time and
log every entry (region id, symbolic name, size, start). Add for
debugging purpose.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6cc390da10f95..7ab32e62c8a98 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -716,6 +716,9 @@ static int amdgpu_discovery_table_check(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void amdgpu_discovery_dump_mem_reserved_info_table(struct amdgpu_device *adev,
+		struct mem_reserved_info_table_v1_0 *table);
+
 static void amdgpu_discovery_log_bad_signature(struct amdgpu_device *adev,
 					       uint8_t *discovery_bin,
 					       const char *fw_name)
@@ -789,10 +792,13 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	}
 
 	/*
-	 * Resolve the MEM_RESERVED_INFO table once at init time. The table
-	 * is optional, so missing it is not a fatal error.
+	 * Resolve and dump the MEM_RESERVED_INFO table once at init time.
+	 * The table is optional, so missing it is not a fatal error.
 	 */
-	amdgpu_discovery_get_mem_reserved_info_table(adev);
+	if (!amdgpu_discovery_get_mem_reserved_info_table(adev))
+		amdgpu_discovery_dump_mem_reserved_info_table(adev,
+				adev->discovery.mem_reserved_table);
+
 	return 0;
 
 out:
@@ -2409,6 +2415,24 @@ static const char *amdgpu_discovery_mem_reserved_region_name(u32 id)
 	}
 }
 
+/* Dump all the mem_reserved_info table entries for debugging */
+static void amdgpu_discovery_dump_mem_reserved_info_table(struct amdgpu_device *adev,
+		struct mem_reserved_info_table_v1_0 *table)
+{
+	u32 list_num = min_t(u32, le32_to_cpu(table->list_num), MAX_MEM_REGION_NUM);
+	u32 id, i;
+
+	dev_info(adev->dev, "MEM_RESERVED_INFO: list_num=%u\n", list_num);
+	for (i = 0; i < list_num; i++) {
+		id = le32_to_cpu(table->list[i].reserved_region_id);
+		dev_info(adev->dev, "  [%u] id=%u (%s) size=0x%llx start=0x%llx\n",
+			 i, id,
+			 amdgpu_discovery_mem_reserved_region_name(id),
+			 le64_to_cpu(table->list[i].reserved_region_size),
+			 le64_to_cpu(table->list[i].reserved_region_start));
+	}
+}
+
 /*
  * Resolve the MEM_RESERVED_INFO table from the IP discovery binary and
  * cache it in adev->discovery.mem_reserved_table.
-- 
2.55.0

