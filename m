Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3C4C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AAFD10F426;
	Fri, 21 Aug 2026 19:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bulLSYks";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013013.outbound.protection.outlook.com
 [40.107.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A7810F426
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DREi4f2Xb74dC1ojNEeSIVZTGLHzq1QoBlYc67xGjgswuGqZ2D5bPVVY77kvwm1QRqaiuaIacsL6otCTNLRf0ObdBkkLFjU+hYRC/m2bjKlcqBdY15edr3/mo4Cn3tx7bIQDiRlr2MOe+5yy2YzJV7nQa/mGtMR2sHB/YfUy288FVJBoikHFSJfDhTVOx63SbTxgCe08KMEf4FGaLXZ7qAsG04ke0hB652sQ0ucFyTwZzUlBOHL1vJ5yvYb3zoOJtEJS3g+f9g20aZJnXG6FH6RBckI4O+g0DMMDK25ngqdUZiIBaM2eg4mkOA5pL4ba2ua9aEOmQq8fLWYQAJqeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfSDNlqszk1dTN/2UAKExMisaXYKr8geLzbk1/MTTUs=;
 b=Vs7wWKB0QTvO+am+nCR9gIMhokTcVEpXDqFAa5eG/VnMtbP/BMWJ5rm4rX0NryofJW70ifRhoCMJbiMYIRhuMVczDhEb43ljQnr5YQ/VlUNXyar05ycMkI9VI4AW10T+E5z/rEY0Sn7HKCe9O6XhWInxj4gxr2gxKdHaod1RG0T8Tt8YH2g253uQdt18tIIdCculwCyhn6o7/L9Perv14EZbJrouVQm+zzcO3Zy3IUEOelerlIcLxwb8Qi6tbRl5CwKtifMmwN5TYDSQZYrzlCZTvZMCo9UY9196kYntzFjSkgxDoLWMY665i5C+jXV7LQda0ZPCCN/27Aql614ezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfSDNlqszk1dTN/2UAKExMisaXYKr8geLzbk1/MTTUs=;
 b=bulLSYksr6xothH7w87lipCmZxBCqAZ/vt9QWO+uHegD0NBpTbyQpTvH16sX3NSn4rLv7lRKk/vjlQnGsMhqc7UrSvPVQgBuqqLIcxMqtXdQihDFpVxLMK7T+kQI933OSMxmPxSC+6aTrjJRCRsFKeQID1ETrLyTo3QOHZZXHsM=
Received: from CY5PR19CA0068.namprd19.prod.outlook.com (2603:10b6:930:69::8)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 19:35:53 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::2a) by CY5PR19CA0068.outlook.office365.com
 (2603:10b6:930:69::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:44 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:44 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 53/95] drm/amdgpu: Cleanup imported UALink handles
Date: Fri, 21 Aug 2026 15:34:16 -0400
Message-ID: <20260821193458.808626-54-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b956b0-0519-48eb-bc56-08deffbb69a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: BKvTrS7E1IK2KKuwWoQWJav59shUhbOX/mE+APnDIj3kwWI8D7sPzgmXnhPQILDtSVioNbQTuXuQ0rOzdu2LMa/VZCBFihQp2i0c1WBT3q5Bu96NRJA15u/ISrwjHq70nLeitW7HgpehRHRBqULXOMn4J56pELmQOBOU4riv2eA3T5GFMnkQAVS8Gh7I4RGQDqU3ien1LEQu928qhZSQ7vZlostTZVCfnNnSb+KQ2qkXGGWlplD9iOuTGXKyk5cC7O0HdmF+4h/YXcyhiB7m0x0XrjCo5FQ1F0C6R8iXIMK5dYDa5NTcPm+rs/hGcBUlhu7Ftm02X1ZUvzay9hTdt/My4ys+FLV6GVcSfmHGcW9Qn4+Q7sPcOeMcvFlsX/yBAJmSktLO7dSScTW3L7PTsZkZ8fhBTWlvMWwciyAeKMDs4sBLo+Eg0ti59XTEpFybeIi3JC2fT08RNDjRwkkgBLPAPeFRM+AKE9cTl0TaT9JX8Nlgyqx0MttaHl9jndwzpdo0SE2H4MbPWAVTtewr0tcI0gkAYe0uXXEHIiDklXZVW9khKn2I5MqILV+QRWtJIDEmeMP6BQsDT+moM7c942Pzniqo9H9C2TBywJ4HTn9IyXoQdio0o4U/baqA2aBLGPdScZgkxhG+Xc/7MbbsdW/c/31ixUcFKH3tifJBqa72vpCS7gmPRq4ynJSRmbfP1m+sypd4nu4uND0Zd2NqVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j3PcE6344PgxnbmqBTVwtAR30JUv6aFeL058ecSfhhXG1sHna7Yd4ud2/U55Dv7Q3mkwOq/GGTVJhivR4VfxQzxYYPGF/8OwtPUFQhqfkANZ0VhTeIhC/gSDO76247q0p+oJltfH2OI1Htk2q8tvBaldbdjrbxGEr0plRIiM6m/vN7oHoifzSGoQiN+4aGMF+JmJSolsY6iQHB3mxMVO+8VFmDqApbPvduRVljetwaV+dnKnTrUKB8nOL5v/uxxNTeFWBoPR1UVOJBqbnYYcWML39HYa/0ypbjC/R+86uVsWY8+OBzoKRXOPGVgcmpkLrkxhS05cicyGivYM80nJcR9iD0iUMLIV3oJ4lJpFQnvH1uIt+X189WdZZzqFEGPHCwvdVnNrJU8byEuADLx8PVjoc18hL/rBuV0baujdKwkJjO1KVn92OZrUIXgyPneR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:52.8609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b956b0-0519-48eb-bc56-08deffbb69a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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

From: Mukul Joshi <mukul.joshi@amd.com>

Add implementation for cleaning up ualink handles imported
on the importer GPU and the corresponding xarray entries.
This includes cleaning up the NPA BO dmabuf and freeing the
NPA BO.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 44233e6c390ae..e151e511a460f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1236,6 +1236,37 @@ static void amdgpu_ualink_cleanup_exp_xa_node(struct kref *ref)
 
 static void amdgpu_ualink_cleanup_imp_xa_node(struct kref *ref)
 {
+	struct amdgpu_ualink_imp_xa_node *imp_xa_node;
+	struct amdgpu_device *adev;
+
+	imp_xa_node = container_of(ref, struct amdgpu_ualink_imp_xa_node,
+				   refcount);
+	adev = imp_xa_node->adev;
+
+	dev_dbg(adev->dev, "IMP-CLEANUP: Remove entry from XA for handle:%llx:%llx\n",
+		imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo);
+
+	/* Remove node from the Xarray */
+	if (!xa_erase(&adev->ualink.imp_xa, imp_xa_node->handle.handle_lo))
+		dev_err(adev->dev, "IMP-CLEANUP: Failed to find entry in XA for handle:%llx:%llx\n",
+			imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo);
+
+	if (imp_xa_node->npa_addr && imp_xa_node->size && imp_xa_node->dmabuf) {
+		dev_dbg(adev->dev,
+			"IMP-CLEANUP: dmabuf free for NPA:%llx handle:%llx:%llx, fc:%lu\n",
+			imp_xa_node->npa_addr, imp_xa_node->handle.handle_hi,
+			imp_xa_node->handle.handle_lo,
+			file_count(imp_xa_node->dmabuf->file));
+		dma_buf_put(imp_xa_node->dmabuf);
+		drm_gem_handle_delete(adev->ualink.client.file,
+				      imp_xa_node->gem_handle);
+
+	}
+
+	dev_dbg(adev->dev, "IMP-CLEANUP: Freeing XA entry for handle:%llx:%llx\n",
+		imp_xa_node->handle.handle_hi, imp_xa_node->handle.handle_lo);
+
+	kfree(imp_xa_node);
 }
 
 static int amdgpu_ualink_exp_xa_entry_get(struct amdgpu_ualink_exp_xa_node *exp_xa_node)
-- 
2.55.0

