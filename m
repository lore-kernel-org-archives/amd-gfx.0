Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04052D0E6F9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 14:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C5610E422;
	Tue, 25 Nov 2025 14:57:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UXdJ4KvG";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F02F410E422
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 14:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/Z1X2adZiMFO3lOMLyq7hrvLZrEb6WtipDcB/ieE9HbOPooeItL1wc+Oywh24xI4s6cujIbLHnpNiZ2d5YSGTx5tbATt4VoIf6prSksCV5fhReHm1SnDbfgAgEc3/DfjjUwpAy/h6aRc1pV3ili+sNICCkn/UOJl3tCJ6jAWmEaHVIxECdvvG/vyyujOf7cJ7vw8bkw7Wv3bVDEnPkBtL6w8z46a1ECX0Venq3ff2QL19qvwXMp4PRz5KfVbDkd+T9pX6dY6oOHTYzbkGW7UAVIfZ/vFGP7FcjoNSJX2UhFKWkg2qmz26I28vPBtb53WPzRkckGdhJb6IkvL2EfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crXExUSRwJN2XjAYySRItxvKTSsolqm/dAFiYBwevVE=;
 b=GMUWMFkMBzd13YSW1iiVinY+CJNk9D/TfkO6HL0yWTqe2V7UmHngBXSjzy5p+Szp5QiefLbhxzGCevz2q8o6RF8stGYQUisL8Gk6TpldSRtGJVzmhAXR6h3Eme5tEJ/KJkzXOCli0qtY0aw6IHY/af9lFYM7faGcqIuPS7/Vbmy5OYwq8O2420WMM08HlLW0pzM8v4h0to4NIdU0uYduPnCzFlQbGtsd1KDCiM1g6XvQ4iihZotoQVdX7fLCQ8S7e3hScUpGmpUZxd5v2QUm1xasnsvJWXfpNrdUQNNMGhxP5w/5CA4AI5Ik+abVLodyhVhfbKtRuL5cfFekhLHsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crXExUSRwJN2XjAYySRItxvKTSsolqm/dAFiYBwevVE=;
 b=UXdJ4KvGVCsqHrC40AdNpk7KU+1bRWwhhzAWuaCVIcqGPZjweS3I4eGrsFjVgpXRTXU4eL7Lzy+g30pWSIHdLJoKfQSXGIQO5PfqF+Tps5+XACdmVAGYBaej/P5cwq00QB+V8b8usugI70RbVPYXXza6lZXw6SCEe9ZXULsdKzw=
Received: from SA1P222CA0063.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::12)
 by CYXPR12MB9387.namprd12.prod.outlook.com (2603:10b6:930:e6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 14:57:44 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::8d) by SA1P222CA0063.outlook.office365.com
 (2603:10b6:806:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 14:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 14:57:44 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 08:57:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: skip SDMA autoload copy if not initialized
Date: Tue, 25 Nov 2025 09:57:25 -0500
Message-ID: <20251125145725.2045485-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125145725.2045485-1-alexander.deucher@amd.com>
References: <20251125145725.2045485-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|CYXPR12MB9387:EE_
X-MS-Office365-Filtering-Correlation-Id: 204cf2af-7d42-4ba1-fc77-08de2c32fd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YfOLxlsG/g3SmWuw/Cgk4Zaxr5RH9jr/EA94bBKB8cFuWbUCNknovL+D/Urk?=
 =?us-ascii?Q?KKqpFzRKpZd0NmE7a8FsLDr+7CFjcKt2VZ5HCm2hp+p1y11v8tM2PxS9NtQA?=
 =?us-ascii?Q?p16xxRETN2IFRqIXvxq2zFlGrC3DjwEJu9DdHdwrsIzMl+xN0PVrayRX0+vp?=
 =?us-ascii?Q?HScbNTIWqUlvzyXs8ilZJ0tVwCBaBKIc3FwhZeO2NYrQB8naKZTiJQkCPrCZ?=
 =?us-ascii?Q?uiqJzc5NdYjF5OhG1wPuYO085zDie0dZG7sC8lvCUkDxbwADOPKJCF4V7pb3?=
 =?us-ascii?Q?C1SfdEwhl9f2abBw1HDysjy28Jr7DNH4/ORydFg93KpGOyn04/U2Gd6taHg0?=
 =?us-ascii?Q?8VgwAa9yuJKUBGj6ki3L/fIFXewDBIdpQH6NZMVKn/V9bSnSjjIgm1S2yi++?=
 =?us-ascii?Q?t081yylcatfDrH+km8nAMbhj7R6mWMcUO6BvkO90vUxOp1ECV5ZYNNMTCYpB?=
 =?us-ascii?Q?zSslTqtjmZOeqAKDGNzqCcdiO//l+L6DPnkQw/CliI5mB+zOTBn1nBnxL4Dj?=
 =?us-ascii?Q?sxdUv6U+TBhtMbaBqRnhu0AaFh5M0Fdo49xEMDtX1Syz1bLA5gvpQjDWvsBY?=
 =?us-ascii?Q?3vrKI9Lyn6fZETLWr/7GaWdSfqgUxJUQgZF8kYHmsWmrgtAlBfXrKlgIXfyF?=
 =?us-ascii?Q?KNOE/nRR0AOh2GqNIhxTZkGXlBDCmorPhQ9fq100+wCdLVWO3x4MM2SN5PB8?=
 =?us-ascii?Q?W3zxCVh/Jh+WlhuOx0N18t6AtFZg0rfFaXeZ2MAnfaFgDyR0C8aEpVGw7FNy?=
 =?us-ascii?Q?hvBtJ5VcH1y7tqATyGl98TqEvb9jQpyk/Os+nOINppmFMQeSAAHwcwrFTq2B?=
 =?us-ascii?Q?qbuFYMBBH5WzrfYSzk3c59xwYyHePIWEV12lLw2UkqlBZrvy/vU/gLtBwazN?=
 =?us-ascii?Q?UJIt6bqUV4rsLII3ZdYr4hvOb54i9jCVA7sTPEIYq7bJubTnVpjNPh+3JYlW?=
 =?us-ascii?Q?WdsM4WX4jeDlgkc295vEcwmVYXqgJ3jo8XhV/ZAtNip54JoFlp5IKdySkXaD?=
 =?us-ascii?Q?4sv91B2emNWPzHrbS87jrt8nv/cWK3/as4+qLjbDm5ZeaxOkQWZ73KxpnCfq?=
 =?us-ascii?Q?lVXQyruLcPKYIKv6QY2N1sy64yQbgBvpcS3UPySy+ukb+0bt0cm8Ogu3LJvG?=
 =?us-ascii?Q?8ydR+z4lxeH0JSwko9aBs0GwJhT5ZM9u9HlUAaesFwnPP2+qxqjsxRf+aqvI?=
 =?us-ascii?Q?Ge+YZ8eD6RyA2KmMu9FavuzHFm850KR+P5QztQi0S4lY/qBpFwnuiYVD5mih?=
 =?us-ascii?Q?Esm42bZYnb1TMyPKEMfJd/LGw8DTmY/nUoQD6STJoanVqpcXxnqxew6sQRDX?=
 =?us-ascii?Q?DxB598M1f7EgWVb0yA42kfB7Jk3JKg6zB4NBJQ8GuJIOVYmU1b8xsWqD23Sg?=
 =?us-ascii?Q?YclbHwIeZaUPpzRLJ/gWpR6xAfool6ZvSoZNBCzb9NRHHgLyMQcoSttkQh2i?=
 =?us-ascii?Q?F9PDzeksSco/d0gddp9lbROi5GaubVO0bj+QLqrl+w9k1qP/cNOS8TtR2365?=
 =?us-ascii?Q?6Yp5bZdxKfL4IwNEOsG0dYxjP0dmyi2aExA7lTzMQvZMwtQIf9b//bSh8lFQ?=
 =?us-ascii?Q?QWvuYsuqJmyRVnbCkNk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:57:44.5412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 204cf2af-7d42-4ba1-fc77-08de2c32fd7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9387
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

Skip SDMA firmware copy for rlc autoload if SDMA not enabled.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 96ce3f42196d9..404ddfcb0e5f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -994,14 +994,16 @@ gfx_v12_1_rlc_backdoor_autoload_copy_sdma_ucode(struct amdgpu_device *adev)
 	uint32_t fw_size;
 	const struct sdma_firmware_header_v3_0 *sdma_hdr;
 
-	sdma_hdr = (const struct sdma_firmware_header_v3_0 *)
-		adev->sdma.instance[0].fw->data;
-	fw_data = (const __le32 *) (adev->sdma.instance[0].fw->data +
-			le32_to_cpu(sdma_hdr->ucode_offset_bytes));
-	fw_size = le32_to_cpu(sdma_hdr->ucode_size_bytes);
+	if (adev->sdma.instance[0].fw) {
+		sdma_hdr = (const struct sdma_firmware_header_v3_0 *)
+			adev->sdma.instance[0].fw->data;
+		fw_data = (const __le32 *) (adev->sdma.instance[0].fw->data +
+				le32_to_cpu(sdma_hdr->ucode_offset_bytes));
+		fw_size = le32_to_cpu(sdma_hdr->ucode_size_bytes);
 
-	gfx_v12_1_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_SDMA_UCODE_TH0,
-						   fw_data, fw_size);
+		gfx_v12_1_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_SDMA_UCODE_TH0,
+							   fw_data, fw_size);
+	}
 }
 
 static void
-- 
2.51.1

