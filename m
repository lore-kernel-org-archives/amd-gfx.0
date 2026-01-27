Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77842D25955
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 07:18:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0378010E149;
	Tue, 27 Jan 2026 07:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y91aeAua";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A515710E249
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 07:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eqja4JhJNBn8eURd3cnsFvy8NWfXzVt7ilSCJXZZdSXZR5JZBWyrRQJaOfikYeBgzwsFNv0m6+sv6jocjVchxUrlLAA/ab8epJ/QvE/W0o1pXvjXt6a3w2SO4GnuhxXEqVH5p1Jr6pWcTpKZj9hsQT9djItzvPWG5r76gRAmb9Vogfz4M0/g6yS0U9MsZadgeuKOtAwjlUeTIKNDrPcccFMGU+pzcxi8iUOOwsghP1Vv4nc6TbaHObL18erp5WZWGIh7CABducZVWirHXvkt0OOKzvj4pxABMMF9HPN/un/j/piCtXAwdBfZqlJEnauy317ywRKYBKMD88Vo+PQXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxjtWHMYLsbLy72vGz6tCpWgVwupDqcGAYcBUeB0tQ4=;
 b=vy1qcanmOzRB5cmlrie1NUiugSafny9iDmlEdEysWqg1Cjams3QlN3A6+D895F2aMSxqKN3ru0QhkdDdB70ja7rEhKLFva6+RkrPpXsci/A7JPBc5PQl6bMLRB7v0RRCOc3K6IVyeCf9+IhygOxv4Krt+3QvoPaKaoZ3qrZHuiZlIcmuEDgq1b7a3aVdR7exsdlS50eevkJuacR2Yzap3qopQv8cxeqARIPRMCM9viKwULLz75lTfOl+UEiBQj5rDPblroIf+EHHMi3NyI0+ADOYt7O4ytT6nb1tsD+mi9EiyxY2uzUaJ8I1dxzLivHf1CKyHR/qVhN9t6N53TFS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxjtWHMYLsbLy72vGz6tCpWgVwupDqcGAYcBUeB0tQ4=;
 b=y91aeAua/xDTsySgfzdJXng/DXtfw4lcxmUAM2XtCxIGLwBZIkhHXoDNbaAJjNBcJwrUf/P+O6EFI+7lclT9jNe1X+H7hzW0zHVnDg7UdT2xslG1mEhlys7yNNhvamvvxOpMoQkOqICiDl6YVjCSeHHmuYrcH9/40cSd2LBHLNc=
Received: from BN9PR03CA0874.namprd03.prod.outlook.com (2603:10b6:408:13c::9)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Tue, 27 Jan
 2026 07:18:37 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::76) by BN9PR03CA0874.outlook.office365.com
 (2603:10b6:408:13c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 07:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 27 Jan 2026 07:18:37 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 01:18:36 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 26 Jan 2026 23:18:25 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 3/6] drm/amdgpu/gfx11: add CU mask support for compute MQD
 initialization
Date: Tue, 27 Jan 2026 15:17:25 +0800
Message-ID: <20260127071800.2395621-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
References: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 123901d2-f92c-471d-0abf-08de5d744a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v/XO4WJv4so0FcAQqxaNRsziWkEHKbZHCWACg2tIHVaoqP9t5Yk69oOlbUXK?=
 =?us-ascii?Q?xzNJeKrONmaGnAvcPitESkx6cgB6gbWRmEBJl+Y4p9mutXwP1RcClFT6PrgW?=
 =?us-ascii?Q?P5yZtvSIj0tHaH+ZcXnJEo3vrpNQMP8uG5dwzQP4I9y7uWk7boPIjg9qKD38?=
 =?us-ascii?Q?e1I2F3chA7nl6ayfPIMXyhu7fhQ7WiiJCuWCglZVqU6BbkCi7CEmbxnbymcv?=
 =?us-ascii?Q?zhyeYQ84RIN4llv64Cnd9v9RVd0NxLnZeVL/CoaH/2Y86FW10DRk9TFQsHKw?=
 =?us-ascii?Q?ksrNRFmAyUU4gCGYs+Wq32EUD02qwzF3pqRg6KHVEH5+YmPMZ0gYecKPT7Ua?=
 =?us-ascii?Q?5IjlLNsRJj75ty3V6qt7HMh0Cj2FS/Jlzt984prrCzFPr+407rGyqZpVuC93?=
 =?us-ascii?Q?AUQEcWSH3W+xZ7oSuuYcOmHO71HUdWpoPoK0bmfzUcjeMlwsAcXIy008TEzE?=
 =?us-ascii?Q?UKtygmZKsA6oIyXDItlkXRkqohnlWFfBqms0pSf89u4qYgCfFihe/cGSWHSN?=
 =?us-ascii?Q?e/XgYfCsFsKoo68WKwLEcvznAKqx4xyhRV7fZDO3kbD/WXLn4FOU1FloiAl+?=
 =?us-ascii?Q?duKBtPcmfOkHFcCmkKavJpTeM8PXSbjV+BXgGqnXzAIO2XPjEm2PSyWehcou?=
 =?us-ascii?Q?olbukBviLMysV7qPgWRZ9Xfv0BgtysIU3Ckua0wSAxg+gOLyjsWDaB4vgecO?=
 =?us-ascii?Q?Z/B2DcbRMRjhppQMD+Q4STfwPOwDkKjnBi1NBjwAlmYBvhU85VCDhjAe0EI5?=
 =?us-ascii?Q?Slv+YHFyzJNszaW5Gk1blYwn40Kad+IyprjSh1G137Nd8vjTCrwiHOkjqIuy?=
 =?us-ascii?Q?qvAxpboqnIEpfHDGdGQVZK9Ldt4q8NsgcVS/T8pnJ+JoAzUO0AaWqM6Vy6rP?=
 =?us-ascii?Q?k6gqdO/+bzyLXeG9hqwn/K/TyWw9jQSiUxKx4Co8OPeDD3o2IKYgfXTTFnJB?=
 =?us-ascii?Q?46NHuK7VlJjutzAHwD+pIZFfLqE0QpjbtAc3qtlEt35tCp/kVDu8hejuIPTx?=
 =?us-ascii?Q?0nfMR3SJKk6jX7nxD8b6MpZn+BiKU9RvsPUvWBOZGf38yGdtxs6cBiB3OM7p?=
 =?us-ascii?Q?VjZWazs8OOU42kMkxewH3CxFT2EtFI9YA6pjo2pS4cQL9ffztWR5ImcEvEXA?=
 =?us-ascii?Q?CKepwO5s2mK6NJsL0MDLktCcCJ7AqBHNuiWQOp+39DOvDtm4+6LWh3i6bolL?=
 =?us-ascii?Q?V5+Egp/lnSXU2pX2LUEvdDKP3CwYl/xWuEJeGDJzcK80LSXYlOZ4zZT/jKrr?=
 =?us-ascii?Q?REyIXK4lBi1+oOyTazMdXd8QlXN5/crbn2s29e4NFb3DiloT59KoBvb9Gnb/?=
 =?us-ascii?Q?b0YMgfMd5Nniysr107uun36GhBRz5yoKF/u/ZccK5+q32ibAie6zcfzGK6ic?=
 =?us-ascii?Q?GEvztZBdK9pNGuMqTBBOmd3whA5MxZghuMW/JbSY1ilKJBdN8CBkXqIpBqy9?=
 =?us-ascii?Q?Aw5wEKEgHci1+d1cCV5yGLYCr2wZ3JWFAOn7RfHNAVYVBzwaLC5egMK/PUCl?=
 =?us-ascii?Q?XhNtTXRR3OT3vr3LUIb8vJuU3PO4qJ8iQX5CTFAm2FPIclsxCYwHiE21zdwl?=
 =?us-ascii?Q?2wqLsVn7W6IteHBEpPaF5GwKUhO076i30Uy4KYZYGdnXj8qUBgRrjMq2wFOm?=
 =?us-ascii?Q?5DLXWpihAMZy3/5mGG0HWSDhp62moBey/o5k2uSVh1PBrMvphsUPG7jxMhPf?=
 =?us-ascii?Q?AyYVlg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:18:37.2999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123901d2-f92c-471d-0abf-08de5d744a11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
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

Extend the GFX11 compute MQD initialization to support
Compute Unit (CU) masking for fine-grained resource allocation.
This allows compute queues to be limited to specific CUs for
performance isolation and debugging purposes.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 3a4ca104b161..55d98b1a9ac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4238,6 +4238,37 @@ static int gfx_v11_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return gfx_v11_0_cp_gfx_start(adev);
 }
 
+static void gfx_v11_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
+					      struct v11_compute_mqd *mqd,
+					      struct amdgpu_mqd_prop *prop)
+{
+	uint32_t se_mask[8] = {0};
+	uint32_t wa_mask;
+	bool has_wa_flag = prop->cu_flags & (AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE |
+					  AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE);
+
+	if (!has_wa_flag && (!prop->cu_mask || !prop->cu_mask_count))
+		return;
+
+	if (has_wa_flag) {
+		wa_mask = (prop->cu_flags & AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE) ?
+			  0xffff : 0xffffffff;
+		mqd->compute_static_thread_mgmt_se0 = wa_mask;
+		mqd->compute_static_thread_mgmt_se1 = wa_mask;
+		mqd->compute_static_thread_mgmt_se2 = wa_mask;
+		mqd->compute_static_thread_mgmt_se3 = wa_mask;
+		return;
+	}
+
+	amdgpu_gfx_mqd_symmetrically_map_cu_mask(adev, prop->cu_mask,
+						prop->cu_mask_count, se_mask);
+
+	mqd->compute_static_thread_mgmt_se0 = se_mask[0];
+	mqd->compute_static_thread_mgmt_se1 = se_mask[1];
+	mqd->compute_static_thread_mgmt_se2 = se_mask[2];
+	mqd->compute_static_thread_mgmt_se3 = se_mask[3];
+}
+
 static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 				      struct amdgpu_mqd_prop *prop)
 {
@@ -4372,6 +4403,8 @@ static int gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set UQ fenceaddress */
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
+	/* set CU mask */
+	gfx_v11_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
 	return 0;
 }
-- 
2.49.0

