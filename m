Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC2CA601D
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 15:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A27E112161;
	Fri,  9 Oct 2026 15:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OVpWfmJE";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0EE0112161
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 15:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvZZnq31x5T3Xsazmudc55BV45/pLMSpw9DpIcn7M9lXoV5+9VtD4jhHlhO0ivmhtHSLDWaZxb1OnsEvUMNH1X7a5IOCQJFt2xVMHJJngo+BaAHDKy8VXrE8gzuVFm92Ab1LTD+ZVpLFc+oY6f8pm+D2pZn3RCxnWHzlig1jIlI+HPZjcf0SgvMgeaYOhFHH1oojoZKUz19wcH1OR2XNuNfuNKPY7gi7OoLF4ls7QpwJAJDul/UGSSgggfT0qW8l1LRiY5nGDaYofe7bLLiZZ39rxMtp3U/j3AazyV0lfZv796a8yst7DBV9PnS8HNZA3kgtSTNXziYqVU7pA1pzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APRbmLJunWewGF2dAuBQQ1rF7nCSCSxPo+ca2ZDJfM4=;
 b=qwVUui1za/mEaum7/L32rmmichBfqmcKyft61WVMYfur5YQXQlRunhFfM6gG5Ixe/ujA4sCjANiUZEzx1wBkhVo+kJ/CfXbd7Mf4T3j/XelU8G/Fg1HD4jvSzoKnjUo78UVARfFOfiILYqZGhy0LmSwj559Lcknw3UXFCa0vBzVFnJBZTGtmdIsQAASOxehHiK7JAPBtvFuXyYTykCs9vacg+Js0aM0Az1o+Fq5SVKFsGET5N4FRMll34Fu1Hk5KOa9InOoz85XcSd04TlnfF9DQAx3660yBYj7yRqR1qLuvoVTXwa6RufhSPzBCEzP7Hw8Bsrtu6tfvcDsCilJUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APRbmLJunWewGF2dAuBQQ1rF7nCSCSxPo+ca2ZDJfM4=;
 b=OVpWfmJEgXzuQXkRrfdCRnemk8xvFwThwy7sgheOzxdOCbg9FUijCm2xY4LQ93W/I1TXz1TfeE79pqGDMnNkKzsuGXyA1DvQZeWJ440GK+/ZNOvSrWWboPHvo6dTzAq7AMOq6fFTGv2f7Ugvg13GihaiASw3j3gvl2AXfHovdXY=
Received: from BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28)
 by DSVPR12MB999284.namprd12.prod.outlook.com (2603:10b6:8:41d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:02:57 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::40) by BY3PR05CA0023.outlook.office365.com
 (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 9
 Oct 2026 15:02:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 15:02:56 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 10:02:51 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Allow multiple VCE create commands with same
 handle
Date: Fri, 9 Oct 2026 17:02:33 +0200
Message-ID: <20261009150233.90598-4-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009150233.90598-2-david.rosca@amd.com>
References: <20261009150233.90598-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DSVPR12MB999284:EE_
X-MS-Office365-Filtering-Correlation-Id: c26d4c7f-cdf3-4b30-a3f0-08df26166707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|56012099006|11063799006|22082099003|18002099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: WDvDYapEjFuvKKQFOfib6vGy1RTBRXx4zvM6po4RvSF0bRnDpWqKYse4hkMx266hfY3Z4evaKM/YwNUr9uxG4DsdO0ldPT1iSj+aNkRagJ3rKN52Y6UAHLgDUUrfKEHZqKYr+WpwKBnoXA17ceJQW2zaPnGonnqptxbHkgWwRxlACdVzfUVOpuGvHqoa24sUmhPC1RK4AN4NCGCRJb4h/a143PyUGzopRMZVJrFElRTZQWmCajJRY3XCTEd746m066B+uzjjePLyk14otQgSOxtoe03xqkwv8Xr3ZSXfxpwGLBF6Jp0DG2Odr3XaBHGzBMqKQhdl3p4q4UNySlAfBXOMKIKyBXxMz5+g6mDj/10JZj9k0/ZvwHcmsDXtsGOF5Lr8BGf4AGHTZ9aiPHEZmDPXdB/gNJl5k7JZMtxuUvl81BTZdatZXuYUsomXxdrVIp6sChhqVbKsyEjkVFGSGgmc4d/eJ6pITuRro0Fx2GPwIpK0AUIaVk70HApneWG3xscXPvolNRcIcSinsBDIFJ8zKzjovqstl3gIfgwsJVCEpB3Ypb6L5SyOZZl6/N1xCm/NRjh8txsvt92841jXKYp5KVEA4pPU4OuU79LZWsPBiiQk41NHn7GjOc8lzjs/MjcqKthR03xBXrsNAi+W3YCgK8bD2rCgNlRnHqRxBCTpea2206skEe27VLz4Yu5dT/T/FCy9CcxJ/rSjcDuf2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XAujd+J//vlyj6YTavZPQDugKJ2sCanwIgXAa/QPKZujz4aI8p1jfsCSO2Qh11vdj6jWOfWMle3vYqKoXjZYR0luPMmn5RdWrPjxCYu1JugQyds84a62zQQAFHpxxQe645WvfiF4cyVQCs0Ctwf5DQY922nYb0CgKe/Ne76VvX6MM0++t2s+Sj6bTRc/WtqbJLfNJARfIgoPJPRRrZxSZi5I4OzcO2t14+rfWrEd/3BkbXcknKZoXB/footY2Y77LHkvvQvAc12vsarG0XwAL8b9rsrQtdX+MI4QGyfWaNc++pBrImXKJLMHiJdEgFUzOZU+8s+gOWG7YgT9xj05YXhCnhUFjjawY33S6Rl8kfNlUA+scG8DLAKj5BrRvmscEHJCmRvMrJjQcvh8RIajyd7HVH1Awtj8+8HbyDqb/pezSk6P9ObPsVTkybTRErD+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:02:56.8580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26d4c7f-cdf3-4b30-a3f0-08df26166707
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999284
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

As long as it is done by the process that owns the session, additional
create commands should be allowed.
This is needed for Vulkan to reset existing session.

The image size is now staged locally and only committed when the IB
parses successfully, so a failed create can't change the size of
a live session.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 28 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 39d87f3df9e0..07c4434c4948 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -788,6 +788,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 {
 	unsigned int fb_idx = 0, bs_idx = 0;
 	int session_idx = -1;
+	uint32_t img_size[AMDGPU_MAX_VCE_HANDLES];
 	uint32_t destroyed = 0;
 	uint32_t created = 0;
 	uint32_t allocated = 0;
@@ -878,7 +879,15 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 				r = session_idx;
 				goto out;
 			}
-			size = &p->adev->vce.img_size[session_idx];
+			/*
+			 * Stage the image size locally and only commit it once
+			 * the whole IB is valid, otherwise a failed create
+			 * could change the size of a live session.
+			 */
+			if (!(created & (1 << session_idx)))
+				img_size[session_idx] =
+					p->adev->vce.img_size[session_idx];
+			size = &img_size[session_idx];
 			break;
 
 		case 0x00000002: /* task info */
@@ -891,11 +900,6 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 			if (destroyed & (1 << session_idx)) {
 				destroyed &= ~(1 << session_idx);
 				allocated |= 1 << session_idx;
-
-			} else if (!(allocated & (1 << session_idx))) {
-				DRM_ERROR("Handle already in use!\n");
-				r = -EINVAL;
-				goto out;
 			}
 
 			uint32_t width, height;
@@ -1010,7 +1014,12 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 
 out:
 	if (!r) {
-		/* No error, free all destroyed handle slots */
+		/* No error, commit the image size of created sessions */
+		for (i = 0; i < AMDGPU_MAX_VCE_HANDLES; ++i)
+			if (created & (1 << i))
+				p->adev->vce.img_size[i] = img_size[i];
+
+		/* and free all destroyed handle slots */
 		tmp = destroyed;
 	} else {
 		/* Error during parsing, free all allocated handle slots */
@@ -1068,11 +1077,6 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
 			if (destroyed & (1 << session_idx)) {
 				destroyed &= ~(1 << session_idx);
 				allocated |= 1 << session_idx;
-
-			} else if (!(allocated & (1 << session_idx))) {
-				DRM_ERROR("Handle already in use!\n");
-				r = -EINVAL;
-				goto out;
 			}
 
 			break;
-- 
2.43.0

