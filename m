Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E51D5E15A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8858210E243;
	Fri,  8 Nov 2024 11:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sEb6bBHM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63C910E968
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkFjjrC39Y+Qk0j+RAp9nECcl5DtQzGuYgX06dFbXLmFzQDIL6EGO30k2DVjDnRXiQ82F9rB5mdHR5+7FyIP2GeddWkAIfVHYx8l7uJf2LidGmH5gwoDT1gasiNzegtPnFGS92btDyCzHoKEWQEOeDlKPfJvGxGTHorbDOrE4V5F8IUIhgyTOVgDUH/hEdz/63f1X4yq4WN81k8zpcAJa1vVDbqTg5sHlBaVbJurSKgv/I0q4G4i3t2z1tz9m95NXscLeqrzNPrHKVfPqJYHmlD3rQPYr5y5b627+aBszgKtyoT3Pc5nou2uLzWxhJBtQ4Ks2Wl/0VwMKXGgXb41cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtjOncRtT17IGO1wnMldqoPyzxzEPHFUNLfZdRsKoq0=;
 b=GqrwcO74/c44tvGy/KzrVgKHUk3jXd37NSH1boII2ByVQDj36WVV8bUXhupKd9+mULZzFaQr2JMbJXd18TOdVRKDc9JVqEFZj1UoEUno/URPwn20oVbWaOmmrXmENZTp2KwEiapuxYbtlGYjTUSplbhK5ghr1Rcy242H2mzAXSjQ2nAbAlqoFoVuye/d4XXQfHLUvdgXE5ukNGwNa+OErTQQm22Dtrq6cFS9uVz6vH5n0TejeCWqTGyZRwc+rwjFOQPgyS+HzqkM2RNVuNl57W/8pgk4Hp+1I1I84nMH2IQ4MI5IC9VIQZeBGXqtP5xYhjRwDK6948V78i/vTkZk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtjOncRtT17IGO1wnMldqoPyzxzEPHFUNLfZdRsKoq0=;
 b=sEb6bBHME5MbpaDjkRdnjAbTo6pKKX6JN5yvveZbvmtynuaTKGvxCrj91C8Z/cdxuZ7eDUfBR92oeKZMuNN06Wgr1HIlxWB79gZjImlifl2HJIKHXXlUjYTw1M6bAaqOZcv7gs6pXkisuSCqQTAaaaga7HwMCB7wscpxRLULmaI=
Received: from BN9PR03CA0269.namprd03.prod.outlook.com (2603:10b6:408:ff::34)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 11:14:49 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::6c) by BN9PR03CA0269.outlook.office365.com
 (2603:10b6:408:ff::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:48 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:47 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 14/23] drm/amdgpu: add function to find all memory pages in
 one physical row
Date: Fri, 8 Nov 2024 19:14:14 +0800
Message-ID: <20241108111423.60169-14-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbc7281-2f28-4fec-43dc-08dcffe68f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RZIpstKSezFtz/VaNxDqU8onmJeTZX6ADfyYrIN+c8DYgf/fnyKXEn3V6Acx?=
 =?us-ascii?Q?Hg4wWPLUdAtHgl/wexUSQdPoVxyOsn9LVkyh0eOlHKTXhzf+BMmeO6pZytLV?=
 =?us-ascii?Q?iaGyBxCObX6eP81k1E8atsPnXEGgO3FxMEGbZq9PT7jex1YHFteIpjuSeP6R?=
 =?us-ascii?Q?eeUY3o3F5gxUyUUHFQQsE76r3VY3RLBm/6p92S5u2/xUo1hmCkxvZHIbjgCI?=
 =?us-ascii?Q?oBQ+w2UDc6OVJmtEeZIu7JAnW0htEirjWUzW2DQa3oTIuGjSNiV49zh+Lglm?=
 =?us-ascii?Q?fSs7Ui5AJNZ2ww5rI3mgJPv8/dMYJ+JqIMikyvXz17QkvBWJ7uYLqB4cexUX?=
 =?us-ascii?Q?tLSQkQXzfFdFlI6sjLJmLfOcf36CeRLA5cYI3x6G374mDUbCmgOeFQgtEwVl?=
 =?us-ascii?Q?cVq6mWcol6IVzqRoIo41BqQHkbRGZVO7rkOQtkDHPv0Urp7+NMNy3LPoD1Ne?=
 =?us-ascii?Q?BMDAwvZCxq3a4VXLHq8tu3WHOcPnDd/AAd3QdTQiFrQlQPU9lDkv44187ad/?=
 =?us-ascii?Q?0mm15kHxfq7yuAXZp+90AZPIo7Xixyf6wHxB12CqX8kAHfqEQCuN8nn1bp+M?=
 =?us-ascii?Q?Yh1ZTMgHKIgpF73+Ju7419vQXaOxPXfiIvBbZW6AtrGzCEE7Whl4yB3qPM8i?=
 =?us-ascii?Q?BmqLuBIqEbWs4aDtgr6rtsdtEMfCgqKmx13lHvDiZlH/dIJfv/JVBEEOLqNI?=
 =?us-ascii?Q?Ze+6qA28TSbAH+JuVHJG2fNv1fqQ3UZDyiH90swBR6RpjkCd9JfEKrEyAIsp?=
 =?us-ascii?Q?RFgma7Q1bsOJrNoagXHWFxG/JjRu0GcTZTxXIzfaMIrcnsyWkz1eZieW3Ls1?=
 =?us-ascii?Q?CqgV6tDFI/8OKyHlSIjMcu4i5Aj7/Z5dYoA/18tUV2M37bXZ5PpBr18dn3B0?=
 =?us-ascii?Q?zo5JpW8hi9To9MjQTSmr5n18hRkz/PR0vsxq1eommODjdFBuWjZIXcezuZn/?=
 =?us-ascii?Q?ofdlnk+Z/XcbK2+j5myflRfaoAY6URUYoAeguNGKbP/KfRmOPZSkd1Li+Meh?=
 =?us-ascii?Q?bTDLlsjtXH60NnPSSLpWDBg68bnCB4t8ZCFRWYyvzrevv53CAZOWKsuWDJ+e?=
 =?us-ascii?Q?he34axyirs8FAwqmS8o8E7wM+uc9UbDWmh+ZMIN6F+99pEdLyQV7DUuY+tAB?=
 =?us-ascii?Q?Ip0fF96pomxCh5HjNjxzde70iTXXBv6fbksHXAS4mRcnLx2BVQoIu/NH97+L?=
 =?us-ascii?Q?LA3aIiN3z4MeGpL7cjDSSzWrasSUzLNQofjtyGYSUQHEWiOCfY8vUwjSyOWF?=
 =?us-ascii?Q?DpWPSBKnja/gL/QtqnKpG37xdNOIVa8RcKumpJ+n6+WrLsleC1Iu+hleGt+e?=
 =?us-ascii?Q?2BLxkIe9Fw4vGGzdmH+kN19swwiRSnQB8/jIQg0h84lBBMdZ8uzFdELGPJyW?=
 =?us-ascii?Q?4ZbiS7T5v3i8p/0WnZ7lDvRdbB82Qrw1bHx3cdxsB2oHzYKvGA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:48.8222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbc7281-2f28-4fec-43dc-08dcffe68f24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

And the function can be reused across amdgpu driver.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 37 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 ++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 3199dca8f1ea..11f7299f773f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -446,11 +446,27 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_umc_pages_in_a_row(struct amdgpu_device *adev,
+			struct ras_err_data *err_data, uint64_t pa_addr)
+{
+	struct ta_ras_query_address_output addr_out;
+
+	/* reinit err_data */
+	err_data->err_addr_cnt = 0;
+	err_data->err_addr_len = adev->umc.retire_unit;
+
+	addr_out.pa.pa = pa_addr;
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		return adev->umc.ras->convert_ras_err_addr(adev, err_data, NULL,
+				&addr_out, false);
+	else
+		return -EINVAL;
+}
+
 int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 			uint64_t pa_addr, uint64_t *pfns, int len)
 {
-	uint32_t i, ret = 0, pos = 0;
-	struct ta_ras_query_address_output addr_out;
+	int i, ret;
 	struct ras_err_data err_data;
 
 	err_data.err_addr =
@@ -462,24 +478,17 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 		return 0;
 	}
 
-	addr_out.pa.pa = pa_addr;
-
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
-		ret = adev->umc.ras->convert_ras_err_addr(adev, &err_data, NULL,
-				&addr_out, false);
-		if (ret)
-			goto out;
-	} else {
+	ret = amdgpu_umc_pages_in_a_row(adev, &err_data, pa_addr);
+	if (ret)
 		goto out;
-	}
 
 	for (i = 0; i < adev->umc.retire_unit; i++) {
-		if (pos >= len)
+		if (i >= len)
 			goto out;
 
-		pfns[pos++] = err_data.err_addr[pos].retired_page;
+		pfns[i] = err_data.err_addr[i].retired_page;
 	}
-	ret = pos;
+	ret = i;
 
 out:
 	kfree(err_data.err_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index f45408a6ff03..ce1e4fb385b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -139,6 +139,8 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 
 void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			void *ras_error_status);
+int amdgpu_umc_pages_in_a_row(struct amdgpu_device *adev,
+			struct ras_err_data *err_data, uint64_t pa_addr);
 int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 			uint64_t pa_addr, uint64_t *pfns, int len);
 int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
-- 
2.34.1

