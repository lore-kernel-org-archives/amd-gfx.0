Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22462CA6019
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 15:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B20AA10E9DE;
	Fri,  9 Oct 2026 15:03:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="si6IsyGB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012042.outbound.protection.outlook.com [52.101.43.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DAB710E9E1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 15:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVhpdsmoa5qeX3+l2RdSiR+ckUJJZD+gFMVVXxhyREoAgXUB+68rUzrgwIFEz+Nhi/n+c3WUpJRX2SvL0gnoPhM//uLA4xs076G6S0QXCzPuYjIGOSZBPaW3/NTz/F/IznFD/kjO+CbIXp4Yx8NM1kZJokXtwhw76yxNoW8jZvGZBQVm0zEgZQHbCTpuaCfxMyDhuMWLXRW9JRHHtlGsFBeH8dtTbsTtND0IPDbphUjOpLtjTTpTwAoXxkcC+aIlTxghRod0zPutqvZjEajwJVVIoLX55aYT/1L9kmnTQDgbANgYF595OnjA0WM8du3emon3aJR/7gigGIy7PBrr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ULnKP3rBQvcmDZmgXEnvHyH8Sye1vQpUim8yrnU/A8=;
 b=L7gV2JW9IoRDTU1pgIIHpGnNPW1ov5quHRmiI5XdEtFhk4gqiKoMKtNdSbSP0OWtk4zNZ5y+nim6479kuY3NghFrSdMxm4Am9Daf/NzdfwOfJZ/L95AMkDVlatMvQMWtCEak+QdpYiKMwpcZ67DOfNrHw147qE55NR2747Jm3gxKMfIXUUx3iAKWGiJ9EgqDFS8oRw8MzkVnSt1zEH8fjog5ft3Fu2u5o14CdIaV7DKOLoSwoPQa+LY1rdls4GXVQGFD+d+OFK8SQgJ5EOwX4hrEaN7/pyWBSew7sOJ2fs6elabsxVjrPDZGkuGazbmbZVvine1P4eVViVXm55cORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ULnKP3rBQvcmDZmgXEnvHyH8Sye1vQpUim8yrnU/A8=;
 b=si6IsyGB5wyB2sTv87q05ZqtPMjF8hTiIcGrVy2M7uHXhHpFLg2cgfIyWAmIZmW6oP79EF+VBqStkP+IM+8PP6P8F6Puicyj9dtEE1SrVM9Aq3aODlHbycefYo5vrPWEHG/yPfpL6FSrX6ay0n5ecFywITtrrEX4i+IugzBhGbM=
Received: from SJ0PR05CA0113.namprd05.prod.outlook.com (2603:10b6:a03:334::28)
 by DS6PR12MB803008.namprd12.prod.outlook.com (2603:10b6:8:417::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 15:03:07 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::e) by SJ0PR05CA0113.outlook.office365.com
 (2603:10b6:a03:334::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 9
 Oct 2026 15:03:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 15:03:05 +0000
Received: from work.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 10:03:00 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Fix VCE buffer size check for DPB and input
 surface
Date: Fri, 9 Oct 2026 17:02:35 +0200
Message-ID: <20261009150233.90598-6-david.rosca@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|DS6PR12MB803008:EE_
X-MS-Office365-Filtering-Correlation-Id: a622e52e-0947-4c59-51c2-08df26166c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|11063799006|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: x80bX/uqyswK6WEuRxW0riK0rVw0Sn3F4y6/51OLOts2TOYL1MzBM+XCQqI/BwYGuZ+BuYRf0OL8obvDVZsT0rGY+kX6eamUHE+KomljuY5MAzCw7342rx/1zFmRXx+kpP4TqrmBd/SyXcF9grKPV3CDbjgxxnbv6wLJjnx+lqlu8xCAhQcUbe5RLFBqgn24EJUUFplR6kMyqngk3VsBh5Wx++zg2nhLZ5jdq7Zl3yjDoiPJtmz8VegowG+pbiSIfTK9MrfyFkDwGepjCOjcTF7skXrxe5/rAZ5dqh/NfZRpEj6gM7x3u6CKW/eBbUWX4pqdPLyn/5gtFYK5D+Hhup01E+UUp70ooYiuBkthw3BbA8tCyw8S/m6EmJGl/mxRbtp8fX2UN/V5LZq4sFABe/yNS4g+hXfBMd7j7TTXKjZF/0w/MhuD/uP7VzZSaLEtigVrWG+fnpsx608ejgW8fYOjgYDIwSjSozH4LCuQAKz4lzImPejNY3I1rxB7kMlIa8nMtUoh+g9GbGcR2lllPauCPFCQ7SyoeZsDOGOgIgQSKlF/eIXxWtPUvL6I9ZVMwre9RSriGdcfrqfJ2fvM8nmUD+YtLAhhhn8Fkl7DsX8NaiSl8ohT1FEX5x15xiy12NP8wKandbD2AlbtOMaNXlA41qkH3Z0RMZv8QvHXmk+LoYnYy37fluv+z85rcl0P32AbRxnUdRMQrwNwi1Y1RA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(22082099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TSoLuifiPApaTIkc+G93CE/nnkAcxQjPDfltF2MCvL00V5h0H4MgqwjZAld7uhyR3Ga2WRRDiC6EfVSwWc9uHD5lICHtmpMcaw0YT+n89ruHcjvbbBUJRxXd+5VKplZ7Qg3u8eqya1nhcKI4oYNytkCebih24eTSaTAuhUlzpzW6v1k/RdJKCpLNNMqoKU8sBcw2mvLShHw3QteMk5Wl+4b3VPBJyqffcWPHmpcQ7T89z1aQAh0GGZ45TRjg3lH7dTEEoiEBj6zegq+DWnE2PfR3j9aIrI0RDHWkmJVmR/xrhFD67TRwg+X09UdeKWH3HuNgE0HrxJZyUcGZmbM1YoEFI6IcR8O5i37ykkN2Lp8bXU6XE0Ts/wcHgh4kduxwm53f+88OsfuKJvgCayt0P9hxsdeOmVhlncqdGO6tgvQYrUSesK2m/ZRBTEPnS0IJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:03:05.9450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a622e52e-0947-4c59-51c2-08df26166c72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB803008
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

In create command we get pitch and height for DPB, input surface
pitch and height is in encode command.
Fix the calculation to also consider different luma and chroma pitch.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 33 +++++++++++++++++--------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 07c4434c4948..2e1a48dafd21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -794,6 +794,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 	uint32_t allocated = 0;
 	uint32_t tmp, handle = 0;
 	uint32_t dummy = 0xffffffff;
+	uint32_t luma_pitch, chroma_pitch, height;
 	uint32_t *size = &dummy;
 	unsigned int idx;
 	int i, r = 0;
@@ -902,19 +903,19 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 				allocated |= 1 << session_idx;
 			}
 
-			uint32_t width, height;
-			width = amdgpu_ib_get_value(ib, idx + 8);
-			height = amdgpu_ib_get_value(ib, idx + 10);
+			luma_pitch = amdgpu_ib_get_value(ib, idx + 8);
+			chroma_pitch = amdgpu_ib_get_value(ib, idx + 9);
+			height = amdgpu_ib_get_value(ib, idx + 10); /* encRefYHeightInQw */
 
-			if (width == 0 || height == 0 ||
-			    width > 4096 || height > 2304) {
-				DRM_ERROR("invalid VCE image size: %ux%u\n",
-					  width, height);
+			if (luma_pitch == 0 || chroma_pitch == 0 || height == 0 ||
+			    luma_pitch > 4096 || chroma_pitch > 4096 || height > 2304 / 8) {
+				DRM_ERROR("invalid VCE ref image size: (%u %u)x%u\n",
+					  luma_pitch, chroma_pitch, height * 8);
 				r = -EINVAL;
 				goto out;
 			}
 
-			*size = width * height * 8 * 3 / 2;
+			*size = luma_pitch * height * 8 + chroma_pitch * height * 8 / 2;
 
 			break;
 
@@ -943,13 +944,25 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
 			break;
 
 		case 0x03000001: /* encode */
+			height = amdgpu_ib_get_value(ib, idx + 13);
+			luma_pitch = amdgpu_ib_get_value(ib, idx + 14);
+			chroma_pitch = amdgpu_ib_get_value(ib, idx + 15);
+
+			if (luma_pitch == 0 || chroma_pitch == 0 || height == 0 ||
+			    luma_pitch > 4096 || chroma_pitch > 4096 || height > 2304) {
+				DRM_ERROR("invalid VCE image size: (%u %u)x%u\n",
+					  luma_pitch, chroma_pitch, height);
+				r = -EINVAL;
+				goto out;
+			}
+
 			r = amdgpu_vce_cs_reloc(p, ib, idx + 10, idx + 9,
-						*size, 0);
+						luma_pitch * height, 0);
 			if (r)
 				goto out;
 
 			r = amdgpu_vce_cs_reloc(p, ib, idx + 12, idx + 11,
-						*size / 3, 0);
+						chroma_pitch * height / 2, 0);
 			if (r)
 				goto out;
 			break;
-- 
2.43.0

