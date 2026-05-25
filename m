Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481D5CD5BB1
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 17:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65F9610E190;
	Mon, 25 May 2026 17:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R1IZL/4X";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5AC210E190
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 17:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QF9IdWdXc1h5f1EUh442W/xNZpikayacOzIAYVjMAYKZ7eo4nCynXpAvlh7EJAymCD5ZDGgSPrF5anVx6HoZIriBbPWEvoqq3lFhos1Lq1MleIP/uKAUOIJ9UFFAM+yv5jkWkbMp6tVxiY6GFHEZo2E+sooxPvnvkRm++16mhVN0+qZeAtY5LX2jwwDP6WrW61s/8k+K+suNsXwo5Ax0/xxa/1uw9jFbchlN0AHUOmTJGfK20AW+/mQ1otCzYU1O51dnhc7Lezk7SOFalny9MvZ39qEfcN6xQjOwc8t+kSAagpzMtmVudXPe5XlQDiwNrOG/LRAWZRYrwUrAlLog0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnMFetWAIZY3V8i1BeVVyM9KglG7AqLwlCLNRwrPmKc=;
 b=EA2gnUqIcoIh0yww3tmpb4fjh903FOKi6LGseXbdZ2tAjKekv6yVo0kMKJe503zFwoehjI6D5XQj2KFDLm5SWmucEZN7Q93WKGBFWN2SmtKQGXEbRh+uEOabxv140TT1gZqQ8r9Jhl9xX1Ek+ElIF4znX6umsnhyjVe7tG2pkANshPuD9m4clulD8SPVbP67NXdkTWidXVdR2bxbrWaqT18oNp0PtxR9i70ghu4Bq6k8r87lXX2EHBGUUvvhLu8OJo4yv6B7GlKxnRgs3CYVroWUHgRSkQzMkvvNQPQpDwnkexavgdMDx669be9fVoMIp/6sPKQMv3Aav0KG+BA59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnMFetWAIZY3V8i1BeVVyM9KglG7AqLwlCLNRwrPmKc=;
 b=R1IZL/4XUN03O2bRVskZ97JDCgOF7JeaXeCVvKkPXsk3orHcOWhLRIqs2u35X0Nke1stMsyI8yrqqJ2XKwyYWMykU2MRDKyuZHw2fJ9abk3G9bF9aT7ItX37BYwBIFlTH1FSEesBJ6yoXOG9l7Conwk9rOpWp6SHLiaduNodNPY=
Received: from PH7P220CA0041.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::27)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 17:33:22 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::79) by PH7P220CA0041.outlook.office365.com
 (2603:10b6:510:32b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 17:33:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 17:33:21 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 25 May 2026 12:33:21 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu/vce: fix integer overflow in image size
Date: Mon, 25 May 2026 13:33:05 -0400
Message-ID: <20260525173307.783499-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 29adfe0b-8071-438e-199e-08deba83b7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: /2v0NxGpc7QyMgWNhKj+1c6vxV10qWKvZ8PAKyvcG6NeNzdtDFfJx+8EwWDYMaDfEBx+16kbhgysZGC8nu+NkvckJeFHiMxPs4/SRyW5ct4tNxVGbEzyFhYHzdCNu2amD1ScarjPr48454koNpKHhz5pqXP6tt16k2toJtC7i3sptvoxDGuN8czQmB4DNdyQCrtgGHOZjVTv8T8CjS2yR5ptGsTe4caBaArDLsjRa1lsz4H1zV5j6uqUBqdbuP6TwrFaCHfVTD+BauPfdKVOywdbG1mHd9vBBKWBjV8/XEDtE0MfBiTQtkm30SbRpT8Vru5OBJiCVTP+VOJHBu9Th+0wVgxSnyxfUYnZ6B4a2KL+UY+AlBYcT2mcXZZJXUq6Zqvrl4uoQVVbtZRrnox2ln21/7jiaeF/K1ZimGlBZ2XaIZuU1OQ3kgLPlG5uH2ux9v3wXIZptzB5XRM1coDU1w0kucWeInDrsNHhdT13mz+/7XP2iaRkcLrQPUvocZAAFNBIsiOxGn242oSkXWgriYgpsEk304+/SG/udrknvHu/vRjU4eNoYY5YqdnpXSwzKDmsFeFcvMPnPXOWzplWQxFRKguJyDaTR/fR/dPjs8HEheK53dwfWyLOENuEg6totkqtXPs3WZd25m8mbOCQe9JLf5+HzVqKCEWjgBZXWQbBNwKCUrAlVdzGoSJT0Txj4kef0T5yIZEYVdoXUWlwwdXxvEufLpo9ynPuQaNpP4g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IKciYbitBaEMRmNjlqTPvqs4Z9apt+rjwD0fe7AKEE52jGSC5Go1RqR5inCaGVBWOjiea0h9sjmB2mELSGpIzX4iUDLzQebFhOQpGK0hFWd4ZauF18Oe5NphfOFEiYcSIuxeUe6SNhtGaTmWskqHepbX2VDaZWTvO5UW5suULwh7WN1KvYiHAZWjtDaTKB57CRefivtUaEf/mV6jIkkOX3huNQTXYu1BpayGZk+ybfXnamdaL+GioOXVFG7CSahCNx6st5g6nnW8n9Axto/U0t9+AxuBW7oR7ivb2lGrQzqWdJZM7VWPEgj3neMwnQg3E9YXXV/LFJL8RdfceBqfxi8wcA3EInkMSEAaEziB4RlyccL24MKsIQHtP7sp6GOI7YTKnaD3qoZQ1pDT+waCM+r3xmrgz8pU0bgmZK9GDWGVcx43Lcgs+qdS4+y+KbCz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 17:33:21.7773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29adfe0b-8071-438e-199e-08deba83b7ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Fix a security vulnerability where malicious VCE command streams
with oversized dimensions (e.g. 65536×65536) cause 32-bit integer
overflow, wrapping the calculated buffer size to 0. This bypasses
validation and allows GPU firmware to perform out-of-bound memory
access.

The fix uses 64-bit arithmetic to detect overflow and rejects
invalid dimensions before they reach the hardware.

V2: remove redundant check

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index efdebd9c0a1f..af18b51d4cba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -877,9 +877,21 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 				goto out;
 			}
 
-			*size = amdgpu_ib_get_value(ib, idx + 8) *
-				amdgpu_ib_get_value(ib, idx + 10) *
-				8 * 3 / 2;
+			uint32_t width = amdgpu_ib_get_value(ib, idx + 8);
+			uint32_t height = amdgpu_ib_get_value(ib, idx + 10);
+			uint64_t size64;
+
+			if (width == 0 || height == 0 ||
+			    width > 4096 || height > 4096) {
+				DRM_ERROR("invalid VCE image size: %ux%u\n",
+					  width, height);
+				r = -EINVAL;
+				goto out;
+			}
+
+			size64 = (uint64_t)width * (uint64_t)height * 12ULL;
+			*size = (uint32_t)size64;
+
 			break;
 
 		case 0x04000001: /* config extension */
-- 
2.43.0

