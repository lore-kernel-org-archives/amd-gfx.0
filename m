Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BB4E77185
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 04:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC18B10E161;
	Thu, 12 Dec 2024 04:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Aa5WnGcn";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7D010E161
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 04:24:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqob7EGHayBYAwZjJZshd4svzTLbrqspBwk7JVQJ5OHkywodXbOU3DxL0tkBhhTkl3PM0DBhTDyt/ko0mzlqlFdoQ2QIKu2EU8TXEvW9Dw/xceTxwPBLNKNooKpo91oThdDJTaY4aWfN2wotjV2oH4QK3nvNCRZCtyCIJVlVAtthyqtArUp0jnXtqWTscxaoFNis4/T61JJ4aHHGJEiFKCe7oO3ZSwUoLPQuuhxex3HQJ+5sn+s9O4w+ZX3O57f8O76HVMtrCQnxq3FCTRU6cqRKhTKpKw7KxpQiL5/gsOWZd9PiZbUJd1d1HqTLbggUYmFEPuAH6P1mkOy7PGw/ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbjvSWjGeDrxThB5byq2ILfSbXjLUj9Epu2fQPkaAO4=;
 b=Q6nsUCI/hvlnLoJ0LGckii8JtbZZh9PQhK+e7U9Xur17HKLHXSsrGiKqz8Zw2vF1moI7/a0VXj6RT6D6Ks7TuJ6vmZ2qBT7WDWV49Z4XQRnDfxCwNYvGh7mXzCyNh/8ruf8JO4BieD7NK+V10v2tp7BD5IRatygUGqxauIQVlzD30HfvX9hA1XtV11K6Lk2TZnLMOBi2EmHUCZrjQqsIrVXmL/rw6vHGT6vo9OIW9voOpmfHrS52kZjNm5O7ytbVEb86urrPyH8eb4fWWcQHlesrP+kHdC7zc4RXHEYyOvDDK/15tECUZRYreHEJFfR7KuwOKaefM/1V4dzvukfAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbjvSWjGeDrxThB5byq2ILfSbXjLUj9Epu2fQPkaAO4=;
 b=Aa5WnGcn3LOzse7rEl51Hp9Vv0HS7+DMSx6EJI5DNd7AvJlCIpg3KYf1tbfg9tZ2Al07mBSG4MtV4FvRqwcqxxPs4en9ABg7D//cdG+y8E7vh2RWXeOWPy+8qK+9KfDMzOiKDvcj3J6nDYgqu+tyiIYlKW47TsvsWpbsTy7rVF4=
Received: from CH3P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::7)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 04:24:14 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::4b) by CH3P220CA0005.outlook.office365.com
 (2603:10b6:610:1e8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 04:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 04:24:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 22:24:04 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Use dbg level for VBIOS check messages
Date: Thu, 12 Dec 2024 09:52:47 +0530
Message-ID: <20241212042247.3782090-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b94c8d9-5e0d-48fc-9778-08dd1a64d611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o3YLXMiFmMZZc3fj21vsmdENubYUBQN7pdCzo/n1agtG2u/whYdac3k0ID3T?=
 =?us-ascii?Q?ObuNu2Kmw/y/QnXbeYY0GTT7AyZeXqTZ0lgKtuyU+S2f73Jx3s2fg44BUKYB?=
 =?us-ascii?Q?aweQhcWwadckk8tahjBZtZDFhhsu7eaRGd+MNzvnMqFss5z4alhUToeseRXV?=
 =?us-ascii?Q?5VlVSdIaiVMfS/G1XKV4veAK7LL/6GEVhYjpAabyZMVQGS8FbgJe5J27mjId?=
 =?us-ascii?Q?5N4bk1Lw8CCmE36D8RwGGxvUFPmPbARiaQLDX5rNeim63YUWIeRkA0GO8uPu?=
 =?us-ascii?Q?lG3WTDRRzSbNm5qTUIVZeJ8j6eK3ayJLKBIVubnCEObc34VoVteyDNDGtL8a?=
 =?us-ascii?Q?QXVm+n3fOqc19/viySKSvUKE250JtJs6hhG5sDqyjZm9SCAkOW4HVWpQjIpr?=
 =?us-ascii?Q?OCdYBSCkjF7WqGQaOPdyFsBDArJOR7VQ7jqBL/ih+rp+nHHDaWp2yGiTIx3g?=
 =?us-ascii?Q?87S0HneWjsb1LkrIwwZKdJxG2Eu5Zi5BI393RjZqQYGIXz0d6sgSTsCpJbF3?=
 =?us-ascii?Q?Qx4HuRPi5ecZ+XHKYFMDqbTL8KnQ1bLONDxMcZ6k0iReA2TgkQHciBauiaS5?=
 =?us-ascii?Q?y6xM5CFO4YOCvo0HwjoAto5tTzY6HJbYhkQ72lyzI/N/VP3U5emzdURPiUQt?=
 =?us-ascii?Q?w/zZ1XoLO5rZB/e237dh5G114R2tFGa1FD5blq0MpciW/xPRdDO7rdz7qsMD?=
 =?us-ascii?Q?BAW7sxjNzM1xk2qZh41JnY3XqEEbzc+QVrFzCAuCXmmhGJ7p/ux4CUl8BiP3?=
 =?us-ascii?Q?UeyDcqIquBGuJ/Ufi1Vbxru0rEDfo4MFuJOIV90jg2TwH0KXczDODYf5+juY?=
 =?us-ascii?Q?/1TPqIVMp/uxgg1CEDkdzV85mG+Mr285eg2Q4wjwfQieaAYzRHItAQO26VOg?=
 =?us-ascii?Q?KAL93p7mQnGf9icPvPRgX3NGUzDcGx/yHmfx8n4W8nEFi0rLTlSYV1HFSciZ?=
 =?us-ascii?Q?4FOEK08U37PajgcJuLoQKy7hkxmFSKfKbpnm491XPmZCatO4gvigIIb/vqgI?=
 =?us-ascii?Q?r127n1rUyY0QiahNofU/KdVA4nd7032reF0vNfqcQzUgVP+QADYiy0PrGzzU?=
 =?us-ascii?Q?MqSlrF9ZKXWtTzwDj4CxPvLutH2Bl6moK7BlcYSENiQyN/DDVBmplbkXwPdu?=
 =?us-ascii?Q?24j79MzWVFlA98KcbIT1V0BIzVdF9SDfAnzKt53HrDDBG7UGQq7bECt7MzXK?=
 =?us-ascii?Q?SKBHqePp6mcrvpJ/9DhSFSC3Tzkh57JfXZ7BY1sidTTliL8qemZ6tI0zQxn5?=
 =?us-ascii?Q?smoX6cyIkg1xfk85hKuWaXaLLN0EBQqbat5BGn1kaFDVFXWPzckMyFLhGCQ2?=
 =?us-ascii?Q?h5JZLhEOsS+MjlNOYumA8bARR3a9lbRub8xr8EKHQk2WhCmRrEhYYoda18Dm?=
 =?us-ascii?Q?ZeY9/5Nu2jTgZgaWq0SuUXs8oRSWPawqSHJJ02sNeFn2W/oio2SV28klQlyb?=
 =?us-ascii?Q?ovMrcGwjuf7VZFKPN/5qWCBZodiKFNge?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 04:24:14.6226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b94c8d9-5e0d-48fc-9778-08dd1a64d611
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
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

Driver has different ways to fetch VBIOS. If one of the methods doesn't
find an authentic one, it will show misleading info messages eventhough
a subsequent method finds a valid VBIOS. Keep the message level at debug
and add device context.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 26 +++++++++++++-----------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 45affc02548c..423fd2eebe1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -47,35 +47,37 @@
 /* Check if current bios is an ATOM BIOS.
  * Return true if it is ATOM BIOS. Otherwise, return false.
  */
-static bool check_atom_bios(uint8_t *bios, size_t size)
+static bool check_atom_bios(struct amdgpu_device *adev, size_t size)
 {
 	uint16_t tmp, bios_header_start;
+	uint8_t *bios = adev->bios;
 
 	if (!bios || size < 0x49) {
-		DRM_INFO("vbios mem is null or mem size is wrong\n");
+		dev_dbg(adev->dev, "VBIOS mem is null or mem size is wrong\n");
 		return false;
 	}
 
 	if (!AMD_IS_VALID_VBIOS(bios)) {
-		DRM_INFO("BIOS signature incorrect %x %x\n", bios[0], bios[1]);
+		dev_dbg(adev->dev, "VBIOS signature incorrect %x %x\n", bios[0],
+			bios[1]);
 		return false;
 	}
 
 	bios_header_start = bios[0x48] | (bios[0x49] << 8);
 	if (!bios_header_start) {
-		DRM_INFO("Can't locate bios header\n");
+		dev_dbg(adev->dev, "Can't locate VBIOS header\n");
 		return false;
 	}
 
 	tmp = bios_header_start + 4;
 	if (size < tmp) {
-		DRM_INFO("BIOS header is broken\n");
+		dev_dbg(adev->dev, "VBIOS header is broken\n");
 		return false;
 	}
 
 	if (!memcmp(bios + tmp, "ATOM", 4) ||
 	    !memcmp(bios + tmp, "MOTA", 4)) {
-		DRM_DEBUG("ATOMBIOS detected\n");
+		dev_dbg(adev->dev, "ATOMBIOS detected\n");
 		return true;
 	}
 
@@ -118,7 +120,7 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 	memcpy_fromio(adev->bios, bios, size);
 	iounmap(bios);
 
-	if (!check_atom_bios(adev->bios, size)) {
+	if (!check_atom_bios(adev, size)) {
 		kfree(adev->bios);
 		return false;
 	}
@@ -146,7 +148,7 @@ bool amdgpu_read_bios(struct amdgpu_device *adev)
 	memcpy_fromio(adev->bios, bios, size);
 	pci_unmap_rom(adev->pdev, bios);
 
-	if (!check_atom_bios(adev->bios, size)) {
+	if (!check_atom_bios(adev, size)) {
 		kfree(adev->bios);
 		return false;
 	}
@@ -186,7 +188,7 @@ static bool amdgpu_read_bios_from_rom(struct amdgpu_device *adev)
 	/* read complete BIOS */
 	amdgpu_asic_read_bios_from_rom(adev, adev->bios, len);
 
-	if (!check_atom_bios(adev->bios, len)) {
+	if (!check_atom_bios(adev, len)) {
 		kfree(adev->bios);
 		return false;
 	}
@@ -216,7 +218,7 @@ static bool amdgpu_read_platform_bios(struct amdgpu_device *adev)
 	memcpy_fromio(adev->bios, bios, romlen);
 	iounmap(bios);
 
-	if (!check_atom_bios(adev->bios, romlen))
+	if (!check_atom_bios(adev, romlen))
 		goto free_bios;
 
 	adev->bios_size = romlen;
@@ -324,7 +326,7 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 			break;
 	}
 
-	if (!check_atom_bios(adev->bios, size)) {
+	if (!check_atom_bios(adev, size)) {
 		kfree(adev->bios);
 		return false;
 	}
@@ -389,7 +391,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
 					     vhdr->ImageLength,
 					     GFP_KERNEL);
 
-			if (!check_atom_bios(adev->bios, vhdr->ImageLength)) {
+			if (!check_atom_bios(adev, vhdr->ImageLength)) {
 				kfree(adev->bios);
 				return false;
 			}
-- 
2.25.1

