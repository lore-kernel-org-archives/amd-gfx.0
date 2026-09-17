Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4193C88E72
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Sep 2026 11:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5504910EDBF;
	Thu, 17 Sep 2026 11:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5ctPq92d";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFC810ED97
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 11:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJHIcelFZTJacdw8TaUbStdDV56vmRMG15uvGVzFhtBuDtTSL3KmwgGv/cv+oXMBTUjcrfS/7KUQbm+Who/le1CXEBXTLJCll+A4A1RmGk66liufV3lVL7a/FnhpoUg+lFKpCzlx4GjMQRFtIQfkZSqPwJ5Uf33AKZ5DOuDOPuFSkOutzJRA+w40M7NuE7ZaCryLPfmVeTsy6NayktxFfIXpgSiHHn3mUcs5YemGIJ60UQoI/13Evq4wxdAzrnCNVOaPg+2tV31rW0KbK7KDU2nxhhgv+un3x7fQgS6IrBIR0gLHJBcPnU+d4PvypmjsPLYPxEp2bjOy9ivwJM0Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMoIHxUvBY8nJEzESL+SSKgvX6wDAHcOg4MIc8wPtQY=;
 b=VrtT9UqwamFUsIxFQG9iTE3hSqW6JwihPh1mi+i2hq+gmTvHsCgSgaoCplaCx+IZJfHG7pZMlXMTgughx8nUQ1/78JdHp+kiCCeUnzGFAUzE/6miNkdbHY1WOkzyETiFiDVCD5JIrEkAOWc7aq6Kdx7Ka09ziLUaEtwnZixkMWrxhr8ATQzJ20/lNRQzNEpIEz48pnZ8ZHsS4xs/EjpsCzbvPpf7renvzC+gDar3MkXWwY0Aft48GTjep5BDY18Ptb+Or5b9m2Gfd7tlFapAIF3KusqzluZ8XfEqRIU4E1BuTa7vchWcjGs5MStYtqsx64Mni+Pcxcj1gWHQEbWRdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMoIHxUvBY8nJEzESL+SSKgvX6wDAHcOg4MIc8wPtQY=;
 b=5ctPq92dQPWVtNMTjM4dMe+HlPa7m+KcGncIDYirwiuJEO3xmAlkz5Wcma8uq6woyAd4Fut/wPqDi8sRnO6GihAIoZ9jzooQb2b8F8TjJKqIjNeJvU1nNRZ6HeMYI1VKW7EAqXfLGkHmeIXcJOIKGEsnpUO192WqaMZoHEa8yrk=
Received: from SJ0PR05CA0154.namprd05.prod.outlook.com (2603:10b6:a03:339::9)
 by SA5PPF590085732.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ca) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 11:03:09 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::3b) by SJ0PR05CA0154.outlook.office365.com
 (2603:10b6:a03:339::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.3 via Frontend Transport; Thu, 17
 Sep 2026 11:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 11:03:09 +0000
Received: from yhuang-B850M-AORUS-PRO-WIFI7.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 17 Sep 2026 06:03:06 -0500
From: Huang Yu <yhuang13@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
CC: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>, Ray Huang
 <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>, Lingshan Zhu
 <lingszhu@amd.com>, Timur Cristof <timur.kristof@gmail.com>, Natalie Vock
 <natalie.vock@gmx.de>, AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amdgpu: update the PTB itself in
 amdgpu_vm_pt_leaves()
Date: Thu, 17 Sep 2026 19:01:56 +0800
Message-ID: <20260917110158.296198-12-yhuang13@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917110158.296198-1-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 640c5ec6-5ad1-42ee-7f73-08df14ab4265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|3023799007|56012099006|11063799006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: +aGj5ydZu8AaxUFKq3a/YDFqexx1Twh+avkYxERdmuzETzMD5yri4FOoWBKJE0OqozfZ6kj2Tb+CBnm0fNL9F7R1SYMmxz7eHWaPgVhbQgNjkM9jdLgTviTQfuCzZR/pfsCaKaoBXTFKdi58EMxjd+Tsyb4VLdVpXypGZ3/q80Uq1Ga/JPGwfwvpGsOY+ua6rK1QpyA60Kp8UmbVMekUgwBUdKk5+Z55JuSymJ7Wq++xztUfCTX1j+urHGRA2nGon8I1RCZuPQ5XQuW/lj7BQkJkCfgFKV4G2c+2LcHZ0boFFUgl76DhsSBAjh2nw4M7/XJXdcDmulEZhzxYc4M1Ac09yBEQthAaBUeK12QrqjiOwt8EC40w1XMl9o/MvV/vB8fHIewuPlYXLYZbxRRWpMjl9Ne5uN6tIO8krlHoeK9U7rnaLgxni3EY7JMq5J/VU0SgkDJrQfaVzRsUvhgqNwS6WyJcREu8ilIG7ZlOCl2amL3Je/2E+BW0j8hWLAk3Qb352YDfUHQKabz2sSBAyE67v5EOQ3d30au5GMYqJ4Cj8lWFgEPFHMOvmoXDQEDYZ67JaRiG/7rMO4uWvafnXxgvYkDrAvCiii0PHcjJHcaMfAK77LKUVQ/wB7n+DlenW80Y0Im0mDU9JhoXscK+msGI1inSN+l9EnT3tm74+hzu/Ty7oGSjGLopUOkqnBTOxEy7TZFjxdQDJfgclKQ0FQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GEjsXu4Fh6ng3oDx6l2tfIkNUGBsOSOC5Batz+keO1jQxV9kHPuZorEhJ4OglFG9/ZZhXWBbQkw2qKxNLYZhWQa3nXBbobBXi2V4rpJ23Nx7CEumUhQ5yCvoaWxZhbbyjiV+mwzt0GL0GOvg12eV8fM3DcBv1kfbTpUmN3NLJ6Go0zK61z6dy0ZgkVCY9ItP1jos2ogzGXGyBknyULJgHcc3iStN3nCi6yD2F4qrhOStvNAnFgb6AVQcLVmAh+ABew5xrYSvd6emMq/8g7DOO6ADwu1PDgy7f+BUbzNwd3Zn/qxKz5yIzQmPG251k4v6cxKosz6kOIjwgYPDHQnyhfC0pYdB4W/LQpCiMrvHnrHpAO9/UQMNC79O/xodaMhCIF2LJcakCQ9zjNjL2EUzikfQh2CqzAUF8k0cTm6YOco7PbUTMpprycu62+8Qtwd6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:03:09.5152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 640c5ec6-5ad1-42ee-7f73-08df14ab4265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732
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

From: Yu Huang <Yu.Huang@amd.com>

When the walk stops at a PTB that has its own BO allocated, the update
was still aimed at cursor.parent->bo using the parent's shift and mask.
That writes a PDE in the parent table instead of the PTEs in the leaf
table the cursor actually reached, so the intended leaves are never
touched.

Target the entry's BO with its own level whenever the cursor sits on an
allocated AMDGPU_VM_PTB, and keep the parent for every other level.

Also go through amdgpu_vm_pte_update_flags() rather than calling
update_funcs->update() directly, so the flags are adjusted for the level
being written instead of being passed through verbatim.

Signed-off-by: Yu Huang <Yu.Huang@amd.com>
Change-Id: I5e3f4a1803c6a1bac10677f48f273a4ad711d760
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index ec7bdec1a3a7..d97e790396bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -951,9 +951,16 @@ void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
 		if (amdgpu_vm_pt_descendant(adev, &cursor))
 			continue;
 
-		pt = cursor.parent->bo;
-		shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
-		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level - 1);
+		if (cursor.level == AMDGPU_VM_PTB && cursor.entry &&
+		    cursor.entry->bo) {
+			pt = cursor.entry->bo;
+			shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
+			mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
+		} else {
+			pt = cursor.parent->bo;
+			shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
+			mask = amdgpu_vm_pt_entries_mask(adev, cursor.level - 1);
+		}
 
 		/* Looks good so far, calculate parameters for the update */
 		pe_start = ((cursor.pfn >> shift) & mask) * 8;
@@ -973,9 +980,11 @@ void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
 		trace_amdgpu_vm_update_ptes(params, cursor.pfn, entry_end,
 					    min(nptes, 32u), val, 0, flags);
 
-		params->vm->update_funcs->update(params, to_amdgpu_bo_vm(pt),
-						 pe_start, val, nptes, 0,
-						 flags);
+		amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
+					   pt == cursor.parent->bo ?
+						   cursor.level - 1 :
+						   cursor.level,
+					   pe_start, val, nptes, 0, flags);
 		amdgpu_vm_pt_next(adev, &cursor);
 	}
 }
-- 
2.53.0

