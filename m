Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30800C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Nov 2022 19:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E801410E1B5;
	Wed, 16 Nov 2022 19:49:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71CE410E1B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Nov 2022 19:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYKqvkhQb+BqkbzISXELxKabkGLg26OZchQkHBAZ7AfuWC0QNvUF4lDm0zsQgMYurnzNwdBMdvqt6A1Io3Zpa3kghqa+RZvTpa7+mMOUfYUfTEo/VLZaLuzFGiULWKOkzfZMEVfXuNOeXI+nnZ7q6jMHzTXxLxOCdzMPUBiu1LUs9g/B6yDge3M12dTDxtFJuyQbCCmf4aibplrb5xvTZN3v2LvnXIMcevm/Ve7iGzPzXcTIO6WBiZ4crxX1xBdUQpMwiwogo/YOAVnIAs6loxGESOrhGrg/kLfEIXkR0hSjvVA3w9Pwu845wMK8OnyG/Jiu/LgUdADE7Shc2zXAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFbnZTdJFesThFqqnhlesrIT6xmSjhETulqZT/l6GCA=;
 b=Kwr9FHorUJIPtlcwwOSCd2fHwJYACwF38zjD693H5xaW2FMrYTOevw/EQMwDDP5ZQn3MpTQ/JkUGlM3TdGGIOWwfs7v2lpHjuUeJEbiqDy0Dc/FRx5rS+g6N4PM9HH7kvpTINZmcfQ5dHxPOoaaoTBH/GTa+CJb6VyTrT+xqRjjcxC4SVWaG4LXAi4mihkkbxxqS0K8P7I1YxZKYE6TmnpAqZr96Nd+1B47n1o9hfbYiQHMQ9TZeL1L/cQIlqwC8SXod0xBhgPqZ8CKTOtpD4b6ICpmd9FUrlccMu0hMplZ2zJ1fniyvt+3n32L2itGdJuun3D/kFH0JMor76VCGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFbnZTdJFesThFqqnhlesrIT6xmSjhETulqZT/l6GCA=;
 b=3zfovOtqCSJv+TtQMFWg91yl8STGx3gipBnejxbFpMZbV/LLP04BucoTqaD6/jVK+gBXr2vRoWhi5pOozX/kuT8vsxeQwzuDLOwvI9L0BGBs2S/7zD0p2HFWkVwXh8o2eIo+yEc0k+93/gIV0W2mjB8RrybZ80jpmWBpg2Nk494=
Received: from BN1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:408:e2::11)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 19:49:08 +0000
Received: from BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::95) by BN1PR13CA0006.outlook.office365.com
 (2603:10b6:408:e2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Wed, 16 Nov 2022 19:49:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT095.mail.protection.outlook.com (10.13.176.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 19:49:07 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 13:49:07 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Read IPMI data for product information
Date: Wed, 16 Nov 2022 14:48:37 -0500
Message-ID: <20221116194838.15315-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116194838.15315-1-luben.tuikov@amd.com>
References: <20221116194838.15315-1-luben.tuikov@amd.com>
MIME-Version: 1.0
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT095:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f3cd5f9-97ed-4c87-712e-08dac80b9fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ywheC/1OYBbueIsEu5iLpYN8FREB5NKzxRi7PEId3EOEtbUvrn7ieo9KOdJg7YBx5Oj677fAyMoW8l1tYQcKRNsCdd1qZOKm/qm3v59PfuJknMnJhLsYoxkyVJDKeZvndr78iX3Z8k46FYgegECSnTGjwPbAWwFbUMnbG6DegpkBK5muijhtjYKsuaIb7byZN4Y7Qs7Dw5UGVgbg7SYIdEU+VSJSdTC8lby8EIJbnW0LIdhBGx/LTYmij3Uhy50rUfyzliYn0y8vj61wh741CTzNxSaxiXNXaJPuhWcdQ1v9wOLRWqjNyOHdfrMLm7TjXk0aJCwtAS0SvFbE8R9yA+5QtNQz5P9m7OyVh6CCY+f89feNTeWt84DYyKkV79xZqSxpkf5oheMDLV8lZEVmxsauQ6hOJyKwkGbvVUXF6B17tSobw8xuJNBpoidHWVC1XEoVsBIxhJrRF0tN3XjrU/JE8qbevW3HKp+0mTaiwXXWLidKuDJNunOqSpbU/aDrxAjYRRk4FbdSiBF3W4c9xSDKQtAwYtxtCZwmYVHTGqtTlNEfF+oh3dfW1Q+fMfgL1ZPf0blOylFOuKHZtaH6jGoaau1/JBjpD/E0lCzvlAJmkXi5Jf8ZIiJAzUNlsOaBxgTsBwVLT6L4oM2i5AEgr9qelBh1qtkwkQRW7/HqWGuHH6PqoW1T8HY8dWLKlDTPYDnZ7DH06oPRmrxlgrI4rK2GVFIGjCHXXw19OfZNGMRbqaAW9tB8yXUvmpQ/9/+nw2eUmb8yC23Dg1TISWo/BPk4JDpGZt3GCqyI8Oq4Oc6bjDBCrjSE/PXKI+Ov1I8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(4326008)(83380400001)(86362001)(70586007)(70206006)(2616005)(8676002)(186003)(36756003)(5660300002)(44832011)(8936002)(41300700001)(82740400003)(26005)(40480700001)(1076003)(478600001)(82310400005)(81166007)(16526019)(356005)(7696005)(40460700003)(426003)(47076005)(36860700001)(316002)(336012)(6916009)(6666004)(54906003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:49:07.9211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f3cd5f9-97ed-4c87-712e-08dac80b9fed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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

Read and interpret IPMI data to get the product name, product model, and
product serial number.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Tested-by: Kent Russell <kent.russell@amd.com>
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

