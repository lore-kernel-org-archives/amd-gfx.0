Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1D3C5DF72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9E410F731;
	Fri, 14 Aug 2026 21:04:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cNateX15";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3396B10F725
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NL/fHcMgNxpEdPD+mCca81qUWO7JcFvMLaAXkqz9BvJcB2W99RwfyJX8sueyEWhWlAIY4InTnB8ZuwAvkHzACp2406KJ+h32dd90FJ4IqJhkJM/xMrY1PoRtwCfkKv5PnJU4X3dHMQSC2BeaMB8PHTSZ5McBEr5OgIIrjYcKNv+CbpPmyGorw63qM7NdEHT4mB95hZehWhyaJnI67+pqG3Q4PdGm0WCBlp78ez5kPIhtyLtzILTrnlv4IgFw2Sv3LwjyPAgH7IVWiXQiQTK9fNcpwIqFsUTQHMxrcn6+kN43VkKDkoBGwkX9CevSzBp2mv1WH2oFPIvqzMOmNTZe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80vjB3cwt0ZkSUz0oR+OTZm+0CSuUPPJLLbsZrEfgYo=;
 b=FYM3sp3exNH3i7Gv/EFt7nOHLk6+YSCSng7FuakFM41E+qq6qnT2HwDIP5ykxqOPq8uLj4TfSNrFnTd8XdgCe7VGjaqSWz2Nva69RDyHEYXKnSj4vW3bEh9APJbUzkDh3ZHZdBPw1pzVPVyjtCHTYr3Jcljil1FO5azG/XnLkYCoBFd/r/m/WyRYGFrDXosnC/1K6nKLEHwBOmP0P1iKLJsdTyrXl9G//ag2DIrh0Su5m4v6x3l4xa5So60igd3xHmgAl7KbK9dCwjmxYR+gS8mPy9Adr9KMhjZyT+Dsg3lY+2sgeQ8hz6YPAOmEmgXyGk3DwFPPEJe590K6WAAONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80vjB3cwt0ZkSUz0oR+OTZm+0CSuUPPJLLbsZrEfgYo=;
 b=cNateX157PZFaW+YfaSfFJxOjBqB4RkaI8kh8e9rAGDLCGQgcw8RUnU32vuwBcTUciIQSnqemQTQNVJ4ESHqK1Xz2Vmd1fRQ35/U/l+KQ+ry2kmntd/AuXMHpQuMzu4v5ZgweQFXkem4puk2fyMccUgBr16O5M4U3ZuGSYvda0Q=
Received: from BN9PR03CA0963.namprd03.prod.outlook.com (2603:10b6:408:109::8)
 by LV8PR12MB9417.namprd12.prod.outlook.com (2603:10b6:408:204::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 21:03:52 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::68) by BN9PR03CA0963.outlook.office365.com
 (2603:10b6:408:109::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiang Liu <xiang.liu@amd.com>, Tao Zhou <tao.zhou1@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 084/109] drm/amd/ras: add missing ras core block names
Date: Fri, 14 Aug 2026 17:02:21 -0400
Message-ID: <20260814210246.3067612-85-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|LV8PR12MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: bd274c3a-1c2f-419d-a379-08defa478b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: FOzjpCnm39VlswQScXW58Wwfoz6XhaeiyOZtubDRWE98/Q4vtIAPAhacaM6fDbvUnVaUNEckaz2fZ9UmPwi0AviYOPx48xr3JxQE/81rWTsWp8iytbcSmov2vEmO7nniGHZm5lhJj1au9wSACxy2WnSiORVhXd/xlFWljsg2k7ZtTa/weIeB/2oDd2K1+TJ2GNWmVPPu6v1PfVJ2Mqco+ITC+9nsK5qy/kO6hoIknebiZuhEH0ZrU2QOPvkpH32wxyZCZyBhjiD9bSUgtB6Y0YWO4QrBcDz/sCyuHHcnT7aMDyvcH+D4V5ED943Eflljk1i/9l8KmUFSnUtzE5fCeBy/ggAe1leFiXp60eqkNyDnzVsgnqEyLpV7sKtFEIbiP8E0cwqzAqaPaDc3uutyVpgvV94X4+OJMMkdO8h8o0pqKSonho9FuF2Iod/Wwr6HCqSaW0GVFD1L+okc55ElJHpkaGVpyJsK9xvr2MJbIIR6n6vDKffjW2MQesw4htKPt9HqRzvLVkglObEscyV8H034iCqyBog9BXwZSNuZri6BW1B9LdNZAG2vCvJ0grQMfBaIY4CxnxFelXwus9yVsjuuUEDqSMk+iLIDTaOQv847W3uIImuWd1VP4n1DwCqOOIGcf+sYcCjNnziexWM3n/KPi1r6JFVdfLivx58Mv0LsiAnElmZkVlEOBSclZ7F5lu5ahZRBg3OFP+eMHuPglQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: egfzZOKohVrMVW58zaoy5mzDF0pdfVGPeWAyuhfG19g/AhlRr6fZ3Fw5QOuvAnEIkNDfnyzgBEXd/J9LfqRbNJjb0hnVsI+nDMH+txYTqM7GevOa6FLF97LnScDnBG7f9MaYOZtciZm7Z03Pf/obMJnvqpHGfsXzXiDygtd+jQXeHu5eq6okTVAFfXb/2580Cdh+fyX36zAzKGo0Wwl9ZAHCG4gsWavh14zTH5wzGS1jSXBew6uBmCcQarh4KyzHbuQHBGEG7/kEyUgR3f0ulilSoaDBEQI9FljqIHUsld4lS1x8NAvE0y3ddVHqMrvLjeG+6ntvr1Js3lLaU8/9dl51l3yRCd8qCPLYe1JY8M4QuA5eYSbJi9nuOIOog6lnIkibAjBwiYFisn6FQFmvznr98TjmTBJgne4qpS7jNEuU9HBe8myiWD68uvmLaIUo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:52.4256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd274c3a-1c2f-419d-a379-08defa478b95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9417
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

From: Xiang Liu <xiang.liu@amd.com>

ras_core_get_ras_block_name() indexes ras_block_name[] directly
with enum ras_block_id values. The table only covered entries through
RAS_BLOCK_ID__MPIO, while ras.h defines additional blocks through
RAS_BLOCK_ID__UCIE_PCS.

When UniRAS reports a newer block such as RAS_BLOCK_ID__PCIE_PL,
the lookup falls past the end of the table and returns an empty string.
That leaves messages such as "new correctable hardware errors detected
in  block" without the block name.

Fill in the missing names in enum order so the indexed lookup can
resolve PCIE_PL and the other existing ras_block_id values.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index dc78e52de8869..662a3a17a6b6a 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -52,6 +52,26 @@ static const char * const ras_block_name[] = {
 	"jpeg",
 	"ih",
 	"mpio",
+	"mmsch",
+	"mp5",
+	"atu",
+	"dacc_be",
+	"eclr",
+	"kpx_serdes",
+	"lsdma",
+	"mpart",
+	"mpifoe",
+	"mpras",
+	"nbif",
+	"nbio",
+	"oxrp",
+	"pcie_pl",
+	"pcs_xgmi",
+	"pie",
+	"cs",
+	"shub",
+	"ssbdci",
+	"ucie_pcs",
 };
 
 const char *ras_core_get_ras_block_name(enum ras_block_id block_id)
-- 
2.55.0

