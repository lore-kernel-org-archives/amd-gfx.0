Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1CCC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 01:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DC810E51C;
	Thu, 17 Nov 2022 01:25:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F6410E513
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 01:24:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHSk97a/lwdajDXX+5rtgfx+mcKF8oINFiJxqdXhAqFAa8cHTq5/MxFBXNgEpUpvXztdYOIEcJ2BY+ArtQf9N/K/T90EZMqSW6AMdZtZWWbjfQrDCwVWWY6kVW1062qX50KYLfol2i/xLEGMx5qD6l0Q0E7wpltJHO9/oii8uQqi+usXVEdYUT2kzR2BAm/1uXqJScGI9OpSVz6cfndAVk7IzcjOt/fFhG6JfvQbtsTHwQtHwMuWpnHgdpZG42R4gDavzkUWMpoAaPehJwhAnx/LpyKg2NmtzG+yCJkI9RLdvTblrObWiieo83VWrcXK8O9+Gx1Tyb/97gOyWTs9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrC6nqVcxY5zs3vm9WFS6A5LztsZE9uaGNgR+CcqRYM=;
 b=Rf/N8kXS0JyUSz69wJtRYBrsuHaFtHVAfgmcR2u8ToOjG61Ytu+frk3DCm2JxZkYBL85tJ+RLdSpe93ruS9iE3Vay/0Ul0RzdN8ELvwRvQBxdl+VrnpSo1GCv9445NNhpj2rPI6NpA4V1XQ5xX+cSbFEYMHnENA1MWiUZx01oAtVf5kpkqnpC0BGH6G03aw30mUjzbx9J9U0/b5mZoymJ2DIQV+oueEBA6HfmPRlXcJ2ES3uN83yJQk2UsaXIkDNJitH541TM/KdcAb8WwF+jaQOI3i7cXaTL3+1X/Q4z9sIL6YiUoCB3gSJJuJswhfaqL+p4un9YRGa+zE0+n5/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrC6nqVcxY5zs3vm9WFS6A5LztsZE9uaGNgR+CcqRYM=;
 b=qizffk+Cx0ScvQ4M3IlVeyFt/A3bqMXksXHGOsae2IgVZs5AI616l+K6H+rgNYD8LygM0QCb0jvGZtkEgN54pYwe1RZD0R0aMpPttKTD16fB1jhnqsPuR87cx8v69AwzVGDEasPbiG8unRoJhlKUy2wD3EuSLLThr2GMXxV25D0=
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by DS0PR12MB7509.namprd12.prod.outlook.com (2603:10b6:8:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Thu, 17 Nov
 2022 01:24:52 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::f8) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19 via Frontend
 Transport; Thu, 17 Nov 2022 01:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 01:24:51 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 19:24:49 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Interpret IPMI data for product information
 (v2)
Date: Wed, 16 Nov 2022 20:24:05 -0500
Message-ID: <20221117012406.33268-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117012406.33268-1-luben.tuikov@amd.com>
References: <20221117012406.33268-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|DS0PR12MB7509:EE_
X-MS-Office365-Filtering-Correlation-Id: 4346825a-9a41-49d7-3f45-08dac83a86b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/5n2btTsBP7ll6ttzuodZu3piBAsRIeO/B3hcYtVqxcT39hC3kre9eTBUi04rQUK0h1IGrAdwMeTrjxVZ99wMKX3JK/KGvj72C7V322wFxDakef25nCdIOR0UR/FZEV3pyww3KZ3o55VYC95LzkwYxbedmX0Df+p0ktfcFKyjCGa5umt7d+h7/2Ris29x/NcdXe+V58gPPjoXnaNTO8XFN7wiswTP2ER7duA2okwN6bvDXru29EJO0LAS+8p3fT8tQW+NYeZ3KTrnesl7b8ZqcxOSher3wHJQX8Ea7zwscwdcyZhVzPRFz+Yn5utwZcHbq6Tc4m32EROSvj0n30Ph9MXCskCQ4C591kYbWevZr/Ec5hOETIAKoZBvGbNBPGszsvkp8UhE7fBshcenpiCaIvFiTVyrVpcQkryIHN7hhR/YeBxBwsFCpBiNo8ozYJl90ifvkgC3MfttEn+G49jgXE2p2RmYeSqtgK8WOV9gDoX+p5h0SJQBKhMWSfmmz9sVldXHS88AdAPU269Dyk3uIm8+6/JGKDlT9q1Ld5yVOQS8seBBTTuIO4wcLY0TyfPhw1qcdfqwzCUinTJjmMikAd9qoQe+hLBwVeHUklU7GgXFOb1ZoO8fUYxnuGgYC3mg0a6GcFkXjpFF3oPFXIL2zsRykdumZvzKHvWEP8FvUCDbGjOCnUooeIcdt4CleBKGBg2tY5/VuUE/bmslP3IN0XcejRBRDOZ7HIM1vxPYzgv/GwI2jed8CskMI2pbeRKlmZT454YUxbwg9HGMa8AVvk9pZ71sPLUs9QM8QJRbXA7jVZ3OIbAfGDvHGGPnNf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(478600001)(86362001)(82740400003)(83380400001)(40480700001)(82310400005)(36860700001)(2906002)(4326008)(47076005)(44832011)(7696005)(426003)(26005)(6666004)(81166007)(70206006)(8936002)(6916009)(356005)(54906003)(2616005)(5660300002)(186003)(8676002)(70586007)(40460700003)(16526019)(316002)(336012)(1076003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 01:24:51.7267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4346825a-9a41-49d7-3f45-08dac83a86b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7509
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Kent Russell <kent.russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't assume FRU MCU memory locations for the FRU data fields, or their sizes,
instead reading and interpret the IPMI data, as stipulated in the IPMI spec
version 1.0 rev 1.2.

Extract the Product Name, Product Part/Model Number, and the Product Serial
Number by interpreting the IPMI data.

Check the checksums of the stored IPMI data to make sure we don't read and
give corrupted data back the the user.

Eliminate small I2C reads, and instead read the whole Product Info Area in one
go, and then extract the information we're seeking from it.

Eliminates a whole function, making this file smaller.

v2: Clarify changes in the commit message.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Tested-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 183 ++++++++----------
 1 file changed, 85 insertions(+), 98 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 9b2ff386b7c4f8..2c38ac7bc643d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -94,39 +94,12 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 	}
 }
 
-static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-				  unsigned char *buf, size_t buf_size)
-{
-	int ret;
-	u8 size;
-
-	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buf, 1);
-	if (ret < 1) {
-		DRM_WARN("FRU: Failed to get size field");
-		return ret;
-	}
-
-	/* The size returned by the i2c requires subtraction of 0xC0 since the
-	 * size apparently always reports as 0xC0+actual size.
-	 */
-	size = buf[0] & 0x3F;
-	size = min_t(size_t, size, buf_size);
-
-	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1,
-				 buf, size);
-	if (ret < 1) {
-		DRM_WARN("FRU: Failed to get data field");
-		return ret;
-	}
-
-	return size;
-}
-
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
-	unsigned char buf[AMDGPU_PRODUCT_NAME_LEN];
-	u32 addrptr, fru_addr;
+	unsigned char buf[8], *pia;
+	u32 addr, fru_addr;
 	int size, len;
+	u8 csum;
 
 	if (!is_fru_eeprom_supported(adev, &fru_addr))
 		return 0;
@@ -137,88 +110,102 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		return -ENODEV;
 	}
 
-	/* There's a lot of repetition here. This is due to the FRU having
-	 * variable-length fields. To get the information, we have to find the
-	 * size of each field, and then keep reading along and reading along
-	 * until we get all of the data that we want. We use addrptr to track
-	 * the address as we go
-	 */
-
-	/* The first fields are all of size 1-byte, from 0-7 are offsets that
-	 * contain information that isn't useful to us.
-	 * Bytes 8-a are all 1-byte and refer to the size of the entire struct,
-	 * and the language field, so just start from 0xb, manufacturer size
-	 */
-	addrptr = fru_addr + 0xb;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
-		return -EINVAL;
+	/* Read the IPMI Common header */
+	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, fru_addr, buf,
+				 sizeof(buf));
+	if (len != 8) {
+		DRM_ERROR("Couldn't read the IPMI Common Header: %d", len);
+		return len < 0 ? len : -EIO;
 	}
 
-	/* Increment the addrptr by the size of the field, and 1 due to the
-	 * size field being 1 byte. This pattern continues below.
-	 */
-	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
-		return -EINVAL;
+	if (buf[0] != 1) {
+		DRM_ERROR("Bad IPMI Common Header version: 0x%02x", buf[0]);
+		return -EIO;
 	}
 
-	len = size;
-	if (len >= AMDGPU_PRODUCT_NAME_LEN) {
-		DRM_WARN("FRU Product Name is larger than %d characters. This is likely a mistake",
-				AMDGPU_PRODUCT_NAME_LEN);
-		len = AMDGPU_PRODUCT_NAME_LEN - 1;
-	}
-	memcpy(adev->product_name, buf, len);
-	adev->product_name[len] = '\0';
-
-	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
-		return -EINVAL;
+	for (csum = 0; len > 0; len--)
+		csum += buf[len - 1];
+	if (csum) {
+		DRM_ERROR("Bad IPMI Common Header checksum: 0x%02x", csum);
+		return -EIO;
 	}
 
-	len = size;
-	/* Product number should only be 16 characters. Any more,
-	 * and something could be wrong. Cap it at 16 to be safe
-	 */
-	if (len >= sizeof(adev->product_number)) {
-		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
-		len = sizeof(adev->product_number) - 1;
-	}
-	memcpy(adev->product_number, buf, len);
-	adev->product_number[len] = '\0';
+	/* Get the offset to the Product Info Area (PIA). */
+	addr = buf[4] * 8;
+	if (!addr)
+		return 0;
 
-	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
+	/* Get the absolute address to the PIA. */
+	addr += fru_addr;
 
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
-		return -EINVAL;
+	/* Read the header of the PIA. */
+	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, buf, 3);
+	if (len != 3) {
+		DRM_ERROR("Couldn't read the Product Info Area header: %d", len);
+		return len < 0 ? len : -EIO;
 	}
 
-	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
+	if (buf[0] != 1) {
+		DRM_ERROR("Bad IPMI Product Info Area version: 0x%02x", buf[0]);
+		return -EIO;
+	}
 
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
-		return -EINVAL;
+	size = buf[1] * 8;
+	pia = kzalloc(size, GFP_KERNEL);
+	if (!pia)
+		return -ENOMEM;
+
+	/* Read the whole PIA. */
+	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia, size);
+	if (len != size) {
+		kfree(pia);
+		DRM_ERROR("Couldn't read the Product Info Area: %d", len);
+		return len < 0 ? len : -EIO;
 	}
 
-	len = size;
-	/* Serial number should only be 16 characters. Any more,
-	 * and something could be wrong. Cap it at 16 to be safe
-	 */
-	if (len >= sizeof(adev->serial)) {
-		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
-		len = sizeof(adev->serial) - 1;
+	for (csum = 0; size > 0; size--)
+		csum += pia[size - 1];
+	if (csum) {
+		DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
+		return -EIO;
 	}
-	memcpy(adev->serial, buf, len);
-	adev->serial[len] = '\0';
 
+	/* Now extract useful information from the PIA.
+	 *
+	 * Skip the Manufacturer Name at [3] and go directly to
+	 * the Product Name field.
+	 */
+	addr = 3 + 1 + (pia[3] & 0x3F);
+	if (addr + 1 >= len)
+		goto Out;
+	memcpy(adev->product_name, pia + addr + 1,
+	       min_t(size_t,
+		     sizeof(adev->product_name),
+		     pia[addr] & 0x3F));
+	adev->product_name[sizeof(adev->product_name) - 1] = '\0';
+
+	/* Go to the Product Part/Model Number field. */
+	addr += 1 + (pia[addr] & 0x3F);
+	if (addr + 1 >= len)
+		goto Out;
+	memcpy(adev->product_number, pia + addr + 1,
+	       min_t(size_t,
+		     sizeof(adev->product_number),
+		     pia[addr] & 0x3F));
+	adev->product_number[sizeof(adev->product_number) - 1] = '\0';
+
+	/* Go to the Product Version field. */
+	addr += 1 + (pia[addr] & 0x3F);
+
+	/* Go to the Product Serial Number field. */
+	addr += 1 + (pia[addr] & 0x3F);
+	if (addr + 1 >= len)
+		goto Out;
+	memcpy(adev->serial, pia + addr + 1, min_t(size_t,
+						   sizeof(adev->serial),
+						   pia[addr] & 0x3F));
+	adev->serial[sizeof(adev->serial) - 1] = '\0';
+Out:
+	kfree(pia);
 	return 0;
 }
-- 
2.38.1

