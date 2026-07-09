Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91DEC44508
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572A410F6AB;
	Thu,  9 Jul 2026 21:01:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fKHx3Xkd";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74AF10F699
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTX2wHgjcuuKfrPuuWRQsWDqRoxGuXe/29pGHzU4HGQ5aMHGPeRb5VZH5zMI1IpcBuNLtZbRgI+RO3Trryp1i2LkLU49Q1T9DxxmyQDst0IX54RfJGhhapq3zDu0GjRA+pvuDTl8zmVPWgvltq5M/GYxQrZOv/2bgGPQ+Qe/0H4HwsjIKQLaAmU365qo2wl/lWBBDntIvkqvh1/yJc75txljWjiAZ6a7JwUj1eX+4ylTF+AkUvJ4IB+vA8e/GWCay5mRAiqkv7smeFwJ4Hku+HXtLC1++rbLT3Y7g9ATQxV2GFwCAU/42OnUBHDrplO2SNIuA4VKZDSJ1fpPXnz85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7WE63V8YVapowmJaGRS4Dnj7KqG3+HNZ0sT03FsAZg=;
 b=nPWv6dHZHnL3baNNOmi6twr1tLmtk2A9zYa3MMj1rKAz4rqMH3ynd6Ke9qbSCMWsJp3PAj7sd6AifJggso9OUrt+AF46KIOL6JqCMwYwGwg9XUcu1fbhqod8kzIKLa6XqRMKpysBCbmpG3vREKzDFnkztuqArpPx26/8JSkVNEwk0sFCwgyuj3XahbWM1EPkXfzWETBunCkXaHwq5j1wJmY9bLTNI7l2W/lVX1Eb3b7Lp5Pem+VvdXfp8u70FZXt0/ksTNRkzR5jOu3VQRkb6mbQJoupbTLLmwDQhm/5EEWxEtml0q2ONsxYCNkg3L2eVjEzjYq0bF1AZs7lPQw9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7WE63V8YVapowmJaGRS4Dnj7KqG3+HNZ0sT03FsAZg=;
 b=fKHx3XkdcmKRJjuXnQIzgwGKFgfnH6ZduS3lML02ruV3P4psBVlB6/dSW1TJjuB4h/VuHX2HQdDKa5djZIAPpF3b8S13oTgf2rm2zgAQCVTOME19SbzADlJ3QBcPYUjINnHIg9BxuU/H5ntGw0p1Xn2rL701YKB2qZfA7PF9CMo=
Received: from PH7P220CA0085.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::26)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:01:44 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:510:32c:cafe::1c) by PH7P220CA0085.outlook.office365.com
 (2603:10b6:510:32c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:44 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:36 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, "Ovidiu (Ovi)
 Bunea" <ovidiu.bunea@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>,
 George Zhang <george.zhang@amd.com>
Subject: [PATCH 05/80] drm/amd/display: Enable IPS support for DCN4 Variant
Date: Thu, 9 Jul 2026 16:47:33 -0400
Message-ID: <20260709205936.5719-6-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc8acfd-6060-4d5d-9fc2-08deddfd4857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|22082099003|18002099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: hshZkNJjQvmxueRZtiuRWMTzWeGiSeCmbi03u63lmkOIc8ZF4wkAbjEw6Ikau45DldPp3IARzPnOmNZqTZOqq5hI31/GsEl8Jp01GjJ76DgAQvc1ehy/HTKz2XLoSJneun87+krKd2qAss4yowhdWW3suXhM0NaJMsBxDE8KfV3Gqxk9VpiNQZfp0C+c30N6vOJUaiEXqqzHeuucIBo4qc02KVuax0OrkV36QzJrbXVBGmEJ4kGj57EMKvEoIOzcqOVtRdrIlr71rsd+iFDSY4EwGIEddgpZ1KjTC3gddNFOLKE2g3qeL4f+qhNQbDw6pIubhSGQc4VLRn8qgK7utQn6oyvnQea33DucjDT1oT4CweuG6pxBcFhK7HfNumfCHLoBAgzMM4IN7YX+sqgv0PRDr+R8qF6C/X3Eif5i4D69geJQXr+N/ezWfXns07sgYbwSEnqF/L/QJcbwIFYtNsyHceLhsl9TxcKIvTuUA0L9Zdqgx99v+8C94cFKYnKuVtgvnD1/hLNFeP4qbQzEySFRGtmqUc2g+MGvBFkXYlxIgHaV3C8BIBDmtqDOQv2yjuwXp1Xzbe/SXa/mOsxiDgiskdweVVjtdm5MzjFL4DxIEgKzhB9PXXs4sxOP63yF9aAozXi5aNPoGsHdgnkevW7SvL3IiQuLIYDU3a0JgZNkrcrMEuusvNwONy5KC57L2XEnCn67ngcTx+TnnlQk5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OyYI80YM02/7QUSUU19hxnfFYU6N5NU/ERMDf+Wra55opaZAD791hH7sKZeS1sLjkkExXsLy/tH0iK1TrjgYMUhmpHfnzjtRImTdFoooMgNo92KZLVmJ5A8B8nFcdTiLAu/nvNp3w2Jr0nEnFV1tBlkNLscHGy19wILE4PDFGOejdfcOnnTiZE1Q3J0n8OodF01qlqqCeb+D3EHizpYVghzvON6lV056hJBovV+j6RsG+h/ZA6hoGnziuKMzKD/vZ0s5i/7Zg9iR8TewQVsC9gc+01V/1Nbsg2z1KdJQGkrwepHr4TWz5FIWD8wT720yyxf3P/4oZ7kS93SdnYyW4wENpcAE38XChknjFTR4DVSw0lhPhMPDnptFHljzzijOrHf/k4RgJnn9HxsXo1UoAQ2cT8nXk8148Xkk5rLj3BbeBA7OsKtHXhNMhx2j7kSf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:44.2184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc8acfd-6060-4d5d-9fc2-08deddfd4857
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
DCN4 variant had IPS completely disabled via ips_support =
false and dc->config.disable_ips = DMUB_IPS_DISABLE_ALL.
Enabling IPS for D3 allows DMUB to manage idle power savings
when the display subsystem is inactive, reducing platform
power without affecting active display operation.

[How]
In DCN4 variant resource construct:
- Set dc->caps.ips_support = true
- Remove dc->config.disable_ips = DMUB_IPS_DISABLE_ALL override
This enables DMUB to dynamically manage IPS entry/exit during
D3 power state transitions. Also enable zstate by default.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 330e82b0974b..1bc2452b271f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -1988,11 +1988,10 @@ static bool dcn42b_resource_construct(
 	dc->caps.dmcub_support = true;
 	dc->caps.is_apu = true;
 	dc->caps.seamless_odm = true;
-	dc->caps.zstate_support = false;
-	dc->caps.ips_support = false;
+	dc->caps.zstate_support = true;
+	dc->caps.ips_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
 	dc->caps.vtotal_limited_by_fp2 = true;
-	dc->config.disable_ips = DMUB_IPS_DISABLE_ALL;

 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
--
2.55.0

