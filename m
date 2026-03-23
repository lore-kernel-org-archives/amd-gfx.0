Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC07EC01A2
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 08:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2246810E2C6;
	Mon, 23 Mar 2026 08:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o9Pyl8bT";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F320A10E401
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 08:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDSAxTAckra0/U8iFYWWCqhiUFzQ1wx1F0GG5n2IAWS9pHKdKbrYyb+LLXLZBRzw6UHss9S0KAEFjUVsnW9RQgg/fncyFlphu84pbB2gKg1SaOSeDMIKQojpsU1srDi9cPgAKFRYdzRz0YQF2XHbCpB38rGwwpNC2/yczKcNZoJv3PBsbw2u1JO1FL0MBLfiztatzUMaiK65THTzgsM/89GfO7MmfILuOHTsWoExlmQ6FH865D1YOGozjiB5XJ2u07wUx+GMLqzb2nEt1ONqj6Wlo813CLJm2UhUXp/fCFFxtrYG82iRjDIutR4Tm4xALgYa401qa/6E4JiaMMiYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Hi60v7b0t5Blt6XhjuOTZ4/y157YbC7jrwj6H5K2cg=;
 b=XlPFqh1E3uYERk6IVqDNvC2xsK2M9v04qOG9TwacuTuDtL7PyXYl0h2gb0xUi7htPjzg3oGE7jUY4z6zYs2W3a+ZQq0ycggpthO+JHX9jKPIRqn216qeJqq8DVOWagqVk/VP1cpj2PpOgO05zWJ5r4XpRq0zJnYNeAN+brMb/xw5v8UNyBdz51NXESdZ5p3zeuzoW23j2JM520XkW2jA+xTUy36tvXqy1J4oQgpBoREjXTxRfQYZXy1f6NPkuf9/HhCmPYda13+W2BG+KDJVuVDQ/QqhZCkNlzeQhEYoi4tcK+J9ZISbfUkCclHTu6Ewq8P1FYTM1xqqfVWBXhzzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Hi60v7b0t5Blt6XhjuOTZ4/y157YbC7jrwj6H5K2cg=;
 b=o9Pyl8bTyP+UquGpzOn6S0mh8d0GmJYgt9WUZUIKnbvkyxBzF+niBbKDvRdltFkdZv2nEpXblFlGycmYU7tmLYx28ND/lfyIj23f7htNuiq8zDYVa+pdQ44xAYtUDy7mf2/nJ+wXR5aViZRDZQmBXSW5mDI8pUFDqRiFsD5OCRc=
Received: from DM6PR07CA0108.namprd07.prod.outlook.com (2603:10b6:5:330::14)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 08:05:54 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::e7) by DM6PR07CA0108.outlook.office365.com
 (2603:10b6:5:330::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 08:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 08:05:53 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 03:05:51 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: add support to query vram info from firmware
Date: Mon, 23 Mar 2026 16:05:25 +0800
Message-ID: <20260323080525.1877204-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: f077b392-5047-4148-d538-08de88b3018a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: MyxEmcBWipnDoQ9wQK/x8ULDig42ASxcJmLeZOLymjV/QZMuh7p6naSTCHkb1bPY5rVzyEHNsz3ONXXAkdC8334fjA7hsPLXn8FA0bv4On6//90MuKf+/tSEUPhGXZRqlho0RESbYFr6v3JzemTLllgbVf2lQtbUvjYmtM3Oloz588jb0/Jl8xmcC/aAziJaBhqOuI+l0Enxo1MVpBhYEXXiihHYKm5RKGsTluvTeQnFtJHlmN1xidWHkrB84iDcwX3yNYHY25LdOUZuOnmWrl5lv8hOcQDMiJwBO897qEkfwvsoi3YGHYgKydaeGm2t08hRPRHxYaP6XgrEH15bLapBCoXD8jyGhB6RjmRCRoim1T4fFtb4Or5J2wPR9+/fowKfXcm/4Q4oHnjx2tLoEsac68G3CaRDF2jsgQHt1u8SuRteJHGm9iaXG8SjAyRB4x9VEu4KbuH9wkLE5HKweL0z8x6SVmufx20/pAm8dBdDluvGhNy3sgLM64AUTKWtzisbCxMMBXyH90f9hjaexWLuqB6lJcxsDmt3E/QvXR02FAFSSOJruYIYe8Om/s7ISGfnaNMSyCcwQjUub/3mqNvHW/PR8RF91dwbyEHOkieazlMYLAp5ED8FAHtPKxB+Kh+O6QBfBLSNAEz+nk6xE9vVIe6D8lCWbyXsAhVg1ayo/MuOCPnZqRy4qBSFYpI2LweR1OB+fVLhiGD/55zT0V9MZVpWGR1rr+YsChzYUcpReRrHgVU3+cxt6ORuLPp9cki6KXTMd2ttGV3zUE5TZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CIz4C6oI/csVDT4CojeFCCXaV5Oh5KaCCeObkq8dQb2nB0lYWG03Y813AW7YAEYxDc2K2pYNSXnDD/MDhYfIYqYQr/p4hnawumtuL5YzxFtWsTDQbhl6cdxjdskK09FPrN7I3KD+pnjLXSSsVT/3syjBicFqEYMjELYAoRGx1g6YiAjv7uD/4bQi46yhrjJ7VUc+v039iP93FZJOEkkEJPucRZ4004VvO/lJA1k/YNYMiIcXrMJzNVQ4Bh7H8u6lXGvIWL1PV2sy3MJTSOkSKqOQ3UOhNkTWHdp4TW3jidDclluh+/h6jCIoYetiVyQgc1PsrUKrR4pKjlk58JZ+ute18XXEVlQrO5g/AmgMKkinb7aCxC6sjzGQinVRdJ5xcgZS1HupUG2V2DVXpjYpiCwr9eOeZno6rzl3s1A5gN73wOCFVg9QSsADIhReD9QT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 08:05:53.8776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f077b392-5047-4148-d538-08de88b3018a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
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

add support to query vram info from firmware

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 13 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 50 +++++++++++--------
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 7f4751e5caaf..504b5f0a74ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -399,6 +399,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
+		case IP_VERSION(9, 5, 0):
+		case IP_VERSION(9, 4, 4):
+		case IP_VERSION(9, 4, 3):
 			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
 			break;
 		default:
@@ -475,6 +478,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 			switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 			case IP_VERSION(12, 0, 0):
 			case IP_VERSION(12, 0, 1):
+			case IP_VERSION(9, 5, 0):
+			case IP_VERSION(9, 4, 4):
+			case IP_VERSION(9, 4, 3):
 				umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
 
 				if (frev == 4) {
@@ -488,8 +494,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 							*vram_vendor = mem_vendor;
 						if (vram_type)
 							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
-						if (vram_width)
+						if (vram_width) {
 							*vram_width = mem_channel_number * (1 << mem_channel_width);
+							if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
+							    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+							    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
+								*vram_width *= 4;
+						}
 						break;
 					default:
 						return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1ca0202cfdea..e6bb04dd0830 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
 }
 
-static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
+static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)
 {
 	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
+	int dev_var = adev->pdev->device & 0xF;
 	u32 vram_info;
 
-	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
-	adev->gmc.vram_width = 128 * 64;
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+	if (adev->gmc.is_app_apu) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+		adev->gmc.vram_width = 128 * 64;
+	} else if (adev->flags & AMD_IS_APU) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
+		adev->gmc.vram_width = 64 * 64;
+	} else {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
+		adev->gmc.vram_width = 128 * 64;
 
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
-		adev->rev_id == 0x3)
-		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
+		    adev->rev_id == 0x3)
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
+
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
+		    (dev_var == 0x5))
+			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
 
-	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
-		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
-		adev->gmc.vram_vendor = vram_info & 0xF;
+		if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
+			vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
+			adev->gmc.vram_vendor = vram_info & 0xF;
+		}
 	}
 }
 
@@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (amdgpu_is_multi_aid(adev)) {
-		gmc_v9_4_3_init_vram_info(adev);
-	} else if (!adev->bios) {
-		if (adev->flags & AMD_IS_APU) {
-			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
-			adev->gmc.vram_width = 64 * 64;
-		} else {
-			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
-			adev->gmc.vram_width = 128 * 64;
-		}
+	if (!adev->bios) {
+		gmc_v9_0_init_vram_info(adev);
 	} else {
 		r = amdgpu_atomfirmware_get_vram_info(adev,
-			&vram_width, &vram_type, &vram_vendor);
+				&vram_width, &vram_type, &vram_vendor);
 		if (amdgpu_sriov_vf(adev))
 			/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
 			 * and DF related registers is not readable, seems hardcord is the
@@ -1896,6 +1901,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gmc.vram_type = vram_type;
 		adev->gmc.vram_vendor = vram_vendor;
 	}
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 2, 2):
-- 
2.34.1

