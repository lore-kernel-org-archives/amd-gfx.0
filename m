Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFECE77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F67F10EA0E;
	Mon,  6 Jan 2025 20:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ikyt6QJc";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBE4310EA1A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWW6pF7KX9zqEotqzwipTJJxFz9TYkX+Deti8VyE8DoSqkdb6cC4LcBsL0NjEikiqHPK6cb+sMhGS5MgITWpo844Q3FqQbRp7uf2oVtRdEF9976mCgVPK4/vnlXcH390/YUTEXtD5uqZ//q69zxCd4PvOaqRcTnVE/RUPDDVq7BginDWy6roWDt6EHWTQwaDqjF82Y7R9DVV3JqphqvVLwtRfPDRX3sP1LXhTasO0r6LTGvfZk9leiGz//mlB5lmU4QvcPks7pKzffj+ovbfMBjHttafIm+coeUXhPzXlZVgE2DnxlrsyxZq+/+40c8egxVvVxmGNIvsfAIskRGuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN/zr01gU/pcgdazag7ufd9SQv0DSYEaql/TG+H2uhU=;
 b=ZNt8UiYrx+rs+58HUEjRdB0QCO4f/07U7HsvCCPiokEELa1KsA9YWETyGARGXEIPvBcNKUncM6lqX+DF8zkNJ1RljSEYexY8yrXFeUPv1f2B0QRlO2Q3GzmbcRCSeQr8dIM3tdq21Btcr9FVuuB0NL7ME/OMDlsOOiYH7v5fXb+oTsP60kXZ//lhCMS7HNVEnyd9wRzdrvjSzbRDxxJZ6nkA6ccEHXzoaD9e5ucXgCb4MzbIB6gBNF0YlurolHC8gc9YW/Fg5sEMstUl+EapJmlJ+BeHic/UV9ZoShodsBUV2aJ2vk/Ub4t0sP0+1bQWgPExBXAkbNPRJfJvjKgAhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN/zr01gU/pcgdazag7ufd9SQv0DSYEaql/TG+H2uhU=;
 b=Ikyt6QJcAyoQopLo/8Y/4f63xOt3WId2ny/sRs3HwynjmB/5un+dB+t2s+BMiz1jBCvWZQO2JhPEQU8DKaphg1RjbeS9g2oqhphCBVnd/Z7T4Gy5TXDjy8XTCO9nLcBhF8RWsqmpb3nH+KH4imAwx7t0SLhPx0+/WqCULDKbboQ=
Received: from CH0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:610:33::22)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 20:33:29 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::cf) by CH0PR08CA0017.outlook.office365.com
 (2603:10b6:610:33::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 20:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 04/10] drm/amd/display/dm: handle OEM i2c buses in i2c
 functions
Date: Mon, 6 Jan 2025 15:33:04 -0500
Message-ID: <20250106203310.3349585-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b989d17-fae1-4a8f-655e-08dd2e9160fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kf56viDYbCPfX3Cp5wo2yofMFSPIdNTBtOdCzAklFffwpYWuniGNF8Fq70Hi?=
 =?us-ascii?Q?KSTa8H+4/jIZh6g35DTHUSAtboC9jAfir/jRRp/vCWz+BmTUBM887iPtYfbS?=
 =?us-ascii?Q?LOsYveHln6ieuAFr1uSFT4j7eyL6hJds6P9Wkqzhg8uLGDc8nO2hBM6SyYyc?=
 =?us-ascii?Q?UlIbIrdXBs4IG6sLv87qFW1A6ITF9jZirraCTh/FW2jug2QGX0FjN65zSDW0?=
 =?us-ascii?Q?rsMiswhYK0Pj3RpfmASUooEuyaI0C+Ql4KE4OE+yPLpNHyDvIi6MxOi9/+Hl?=
 =?us-ascii?Q?FHkwbQVL8Ix2nrJNOegtT3K3ubOIA1SA6VoLqECMBZuT7sZRXbw4Nvp287sc?=
 =?us-ascii?Q?y5sEz19Q2ScJrbEN+4FGT2vKvYnuVre2b/e0ZVIDhfl3/GbjPCxp1XM8Sz46?=
 =?us-ascii?Q?Sc+p3mqbdNW6Hx1j1fth80riuwSBAZOlSaOY6zq1eakpaQsYswN5GKRnD+UT?=
 =?us-ascii?Q?+M1MR+vimHu09YyA8YxdAuNqgYt77EAo9UuQvilQjxjBN1vydSWPhu7jqoTe?=
 =?us-ascii?Q?dVuUeQF22hNSRDwHqwrpPJ2XDcdvMQp3syigJhopcKSxMEGq+ZGMlYOsJhYX?=
 =?us-ascii?Q?HTgR5snResywuoKlz23bdGRsc7DqH7tl6p36BClC6D0S3oTQACMmgUIX7juW?=
 =?us-ascii?Q?kuLhv0VChULKCPpJlzt3ZOAQtp2iDL18sSVQJ5EyHv1+dry1Z67xXnV+Yd26?=
 =?us-ascii?Q?HY8w6FQzTzYKENcIQh+p+dS/Jf6311wqKdfr6+SbQ7m9PsQPM4B+dDYQcDdG?=
 =?us-ascii?Q?3zbxpVYuOY47HGMdJdK5x7IYcGqKGqqTpcq8KxQ9D0k3iyg9xJOia8dwqD0Y?=
 =?us-ascii?Q?F+5fBUoRXG2C/oqBb3BUxISkOS33L6gcVjQb+SkF162PYxrO3G0srWqtLT4o?=
 =?us-ascii?Q?lNJ0Dy5HtBZ2mKj8A0vZFBk6kY7wdOZp+/9/VhPXkvDYzfrRIHHuRIl97hwJ?=
 =?us-ascii?Q?c9Z0Flv/3FhGOVZ2msldxTpglAelMgAMSSMpdZ2x/SEy7eDkOiNprPZW0Hwd?=
 =?us-ascii?Q?GRxqo1/7I4aS0oj9KcxFz9d231xql6tdP/lhKcnHMBDrEtxAEiwrUjz8gZa5?=
 =?us-ascii?Q?mMwT7YrubkXH4tc3EoBySf7N9B79G4lmqyRZXZkIlAsiZgCB66rGBPJ8wZao?=
 =?us-ascii?Q?EK83Ln1biE1Q2YcU08qVJsmVlhPDkfivtdwPhiznTRsbu2xrzuzhq3NLBNbp?=
 =?us-ascii?Q?STKojLqSgYrryCvBbJd9453+59pk83zHNdVbB+x7m6qYYjO2AlMRapmlJ+WK?=
 =?us-ascii?Q?QDxeqKl0VVuSFwu1rsqNpqdz6OJXILJI4UcFIjDvaFw6/uMBcIvfXwKGQMAN?=
 =?us-ascii?Q?/LEIEKCqTRPQfZb1L2nePzA/htTGq9salOuSwPGmgkWgVfAc225cEVqND1MB?=
 =?us-ascii?Q?VojJz5puouid2XSZrXfqu47JtDPSM7/SKVhgR/0JhGBD8JHVnlYV/1L5qVn9?=
 =?us-ascii?Q?MUd7lcSY5iMD/8AwDGr6yOAGpFFqXsV/rLYzdM5DD6nHP23Pph9ZiSpx9OED?=
 =?us-ascii?Q?pO6YQ5Ad4LEqaeY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:28.7986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b989d17-fae1-4a8f-655e-08dd2e9160fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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

Allow the creation of an OEM i2c bus and use the proper
DC helpers for that case.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 +++++++++++++------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 5e3faefc55109..6da4f946cac00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -609,6 +609,7 @@ struct amdgpu_i2c_adapter {
 	struct i2c_adapter base;
 
 	struct ddc_service *ddc_service;
+	bool oem;
 };
 
 #define TO_DM_AUX(x) container_of((x), struct amdgpu_dm_dp_aux, aux)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 030edc6a29e12..5c70b512e6367 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8235,11 +8235,18 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 		cmd.payloads[i].data = msgs[i].buf;
 	}
 
-	if (dc_submit_i2c(
-			ddc_service->ctx->dc,
-			ddc_service->link->link_index,
-			&cmd))
-		result = num;
+	if (i2c->oem) {
+		if (dc_submit_i2c_oem(
+			    ddc_service->ctx->dc,
+			    &cmd))
+			result = num;
+	} else {
+		if (dc_submit_i2c(
+			    ddc_service->ctx->dc,
+			    ddc_service->link->link_index,
+			    &cmd))
+			result = num;
+	}
 
 	kfree(cmd.payloads);
 	return result;
@@ -8256,7 +8263,7 @@ static const struct i2c_algorithm amdgpu_dm_i2c_algo = {
 };
 
 static struct amdgpu_i2c_adapter *
-create_i2c(struct ddc_service *ddc_service)
+create_i2c(struct ddc_service *ddc_service, bool oem)
 {
 	struct amdgpu_device *adev = ddc_service->ctx->driver_context;
 	struct amdgpu_i2c_adapter *i2c;
@@ -8267,10 +8274,14 @@ create_i2c(struct ddc_service *ddc_service)
 	i2c->base.owner = THIS_MODULE;
 	i2c->base.dev.parent = &adev->pdev->dev;
 	i2c->base.algo = &amdgpu_dm_i2c_algo;
-	snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus %d",
-		 ddc_service->link->link_index);
+	if (oem)
+		snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c OEM bus");
+	else
+		snprintf(i2c->base.name, sizeof(i2c->base.name), "AMDGPU DM i2c hw bus %d",
+			 ddc_service->link->link_index);
 	i2c_set_adapdata(&i2c->base, i2c);
 	i2c->ddc_service = ddc_service;
+	i2c->oem = oem;
 
 	return i2c;
 }
@@ -8295,7 +8306,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 	link->priv = aconnector;
 
 
-	i2c = create_i2c(link->ddc);
+	i2c = create_i2c(link->ddc, false);
 	if (!i2c) {
 		DRM_ERROR("Failed to create i2c adapter data\n");
 		return -ENOMEM;
-- 
2.47.1

