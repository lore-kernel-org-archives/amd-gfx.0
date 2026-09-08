Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD2AC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E668A10EB5C;
	Tue,  8 Sep 2026 11:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q/IAR1oZ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8576F10EB5C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I43/hV/3RfXtxHOApSWwkXg7UmRw6MluyirD6AqYeb0mO8fdHHg5NY/i9X4On3j8xMK+Ia2YKVbj83LnMtxYLCKPcTg0lbgRhjkmmCNYtgO4Hq90xjMInIti4wx6qRIrOpucscfpOQhe9cXGriPF1qZUt9SZ6aCsCBblFbZ2bN1Gnk2ZGkc9BGvuIH9eAwV4CamX54RXJrCfMQ20UHQ0iGT7VxbME5CNhF1P6qUer4lY6YhokMIkuTk/WG5eQMzfeUmDP6V6Vnq3JNaHQTjMuug110q8ozOZkKzBdd1zfY2yFYDdmm95CzUsQphplhmJXf2mlFknx3Jlfd191/RiJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGeZxMwfYQQLi/hhIGGWbZatVmzXrWAVkBig9E2rQrY=;
 b=hyips+0EEBSwK6z12aC5clXUSheHPZVtForoC18ViEYSN4dCLeMLZN1AHbbfrke1VaYxMSVZ3maBaCubHHiI3wMaDtG5C84ekyMhSeJpOy141P3DOsczINMP6ZK6LUfHjmfBpE5viVfwlIlYgpNhhJnb9T/rrj+3RxKwUDQZMDY9ii5yY6ZR7lLPaqR84920KLK5dNeQn1nX8TNOc1tCsOluUqLZ/d01YTwIPveZngJxX/IOx1kqF2C9YFfKPR5UnAUNu8VAwsodnY/eaZNlIXZU1qSixRmlt4Msh+huQkJjrELocj0svZjZpSgi2TA0ra5xdxXgXcZVw0ethHE8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGeZxMwfYQQLi/hhIGGWbZatVmzXrWAVkBig9E2rQrY=;
 b=Q/IAR1oZKUMjj3JeOxYiX8ejhmaSTEQQ9IPyRF4Wi7YQMrJxpD6MxFrWtJJKYhsgtY8vONGDXs5fCGy2yl8HmHZGE7JzQpqaD/f+VPeg7G4ULyFpTlIFsHi4XznNUCbnb9DLqB2xewFgcKEmpkdCYXoFEgc1zW9wzfcE3qAGhd8=
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:39:41 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::a) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:39:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:39:34 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:39:25 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 39/66] drm/amd/display: Enable back alt-ch
Date: Tue, 8 Sep 2026 19:31:32 +0800
Message-ID: <20260908113338.2433445-40-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a0f8e10-d54b-4128-b48e-08df0d9ddf50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: p0+5NuGPhfnmSl7InI4ugN2gB/FlpyrNV/nwtGa/XRdDXICY2d4gw2S8Mz4P+melkcUsWEfhSwEyRZwE1hvYcmBaOxnWfFVf//567vLm8BRgzOxjTStMCM6nLjj6ngLscyEM7i0D9HcP5wq3KvaZyHoVVDLkZc+XH600m67+lZWLK7YABgjQrzlC5rXq7Y0V1Z3BAQcEcQfd6zW2DQWCykj5EDc8wV6yLaFVMCt2wo8OsW9Iofb9cSLNPtMZB8UrxnN9KIELgI2WqB5CN6iuYwy7B0EIxbz8mWnokPdYQ0GeTtzJmnp8yGSs5bfy3bGZdIJ30YUPpAI2w6FEzVXbBkuo6J1B6PI00QvuZ2YJMsFET4ajEz7HWuGeQad1mdrZJyYbHfPoDl/5E2D+kc4f00mWcHoKSbo8TifleGFb1Od4jpOpxSSvYY4ffgdmCC8GUoRAaAm29mWbia/ZLL6+sBddA5Q9DIVrwAAMjTIGzn9u1taTQWyLSFA7C3Wy02jcN3nI+HxIx7xIjQjW9W27Zf7jHwiXyYCdJa43IDCCzwjkprM3giDxpd89tvmxCyXJqA4vEimXj9zxTlKO5si42CZoS2sT86wDEbBcYDA4pRYebqdeKX4zKemnhqFM18S+0aFW0Sa2OjWGVnYko4hOPz9BzeZ4+ACoMM8PvjQnlDH4LsEGUXdTs60MkhZTJtjuyy4phAECtV3iXFLAL7SfCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /oFq0wSxVs9KRH1ZwkhecZUY7O1V5J+nAoq6OuQmr+g5mOZgMHcx0T/SzTN9kbr/lhH9j3ERWj1MBRdBnGZXks9vROj72aYRv/cL2oSFho46uEAp5msIAQAHKYmfYeXO0P7HLxHEi0m5ZDyMXrDUUxgGX2EKR2BQAq5eemsv+yQTC8NBZmwAdWhrcTa86zl5CjBMSx872MEr4WTyGlwSqv1XImhpmHiF3qkKyuI9JV2W1omQp4bd1G+BpaYHVEvE4YRh7FSLU20DRg9pWc0Kv2J2SoVUMypD2rAFf9pfMgkN5xrA/ALDE3tj/FVQROKUciiIfeI1wK3e2W1JtzUyu7e86cQCn6bMOQEOvQCsP/RXhdHCSbWOErc7u8hh68yAukki82b32CiuB3TnLOm/AwDPMFWU6cf+l99X9z+hfwTZzu6kM/UBCbuIHNleatOG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:39:41.6276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0f8e10-d54b-4128-b48e-08df0d9ddf50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Enable back alt-ch support since external dependencies are ready.
Also enable workaround path for better debug capability.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 4eb9f7e2d110..21292af6a0c0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -670,11 +670,10 @@ static const struct dc_debug_options debug_defaults_drv = {
 			.enable_ppt_check = true,
 			.enable_offload_flip = true,
 			.enable_stall_recovery = true,
+			.alternate_channel_workaround = true,
 		}
 	},
 	.force_cositing = CHROMA_COSITING_NONE + 1,
-	.dml21_disable_pstate_method_mask = 0x20, // disable alt-ch unconditionally until dependencies are ready
-
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0

