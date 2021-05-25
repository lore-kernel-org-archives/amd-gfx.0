Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175ADC2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 06:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D416128B
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 06:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D416128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47FDE6E9A5;
	Tue, 25 May 2021 06:17:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3206E9A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 06:17:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp2tjKEm24HCj9S+bsJv8FQySJSkSANs5sR9JOxAoSx4RqRJnpIzCSMCbvFhS2BDq9TNyl7Tf+FvlVuvg9Vu/cLOD1D/VEHKcqeMxpAkd+uTsqTCo3PM5Ud4YFKx1AiFYeknW82Ct2mVYBTF9kD3HROdCLcyyot3A1UqJaWMGENCUZGdnw1iDRl1G7DaOWJs5POvDXWRoqjr96GQB21GgF9dyN40FdhRPU/HztR8VEhwteTdW6LEPtJ8jtlrSO4cSmnf4eyUh+n9ws1RCWqzOSyxE0VXZEVKTskq6VXiEObkvwF1CCH8e1NebTDBaxx/vVULdQ3rpr3zdvZbSVtYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hgqcfSBM2W8O828exHvpnN9uF8jrSyQwgtarIZhq8w=;
 b=BdvmPPDUu90q8q0yBGJooQ5T5V1UNCQjBOEPaXA+jl4WX58FzQHFKcE/v088894t1GPZg5ouJauqk93egp6Z4yZyMOs/0FDk/B6EofN2x7m/BTwl3qByTNlwhd0+XbrQxtXL+N8xV5qCYlRGZvNyO53S5bk3rALZsCTO4b2lHeTcSXgVF6Z8WbrsWjpOI9AL5kgBXn924aO1q9p13+BCrAW0wtSzp7y0KyanJ8wRzW8ZbFhnL5U9xZ3XKJ0Xnc8XNCE3I7hgRdZA/5HJJMWeZ+iv4UT1x+v+I4aZQCmdd55ZR2/ByE1yK7xyiWjywogD1RVijTrU9JArYH2khh3i5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hgqcfSBM2W8O828exHvpnN9uF8jrSyQwgtarIZhq8w=;
 b=JiIYYU6tfoXuzVg5Y3pfiT+6KsENgYZCFSxow3R3660AF1O4Q+ZiEctAssPV1I85NiQHU/k1mfBywATmvaYOE53SYMA5EagD/fcWj4vvOEGFTuuhp1AHnD3QI2Nbv7qLogxJ+nZxdQLlBBad5/WgMlzevzBeycri0P7lKMi2YE8=
Received: from DM5PR12CA0019.namprd12.prod.outlook.com (2603:10b6:4:1::29) by
 BN6PR12MB1442.namprd12.prod.outlook.com (2603:10b6:405:f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Tue, 25 May 2021 06:17:07 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::62) by DM5PR12CA0019.outlook.office365.com
 (2603:10b6:4:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend
 Transport; Tue, 25 May 2021 06:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 06:17:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 01:17:06 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 01:17:05 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Date: Tue, 25 May 2021 14:16:54 +0800
Message-ID: <20210525061654.3002-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0a53dd8-8b57-41ff-ca97-08d91f44b8f7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1442:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1442339A792C27F21853A058EA259@BN6PR12MB1442.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPC6950wCgNwx9jNYQrFtV2mcelN/l7cPsihFfBj++rsMJtzHsMrZO6HDtD7cZWViS0aCBXwbXS4sRfim2cUE1OEvU6ZRmjntQMK5BDj/Z6vihCwryBcP3V5t+vPp0sGBMHBoLT6Wtnkwy6xQyD0kDxWrZd014pqHIufF/Yu48EjwlEIXKgVqYUEUlJnXSBLs7AwqfZEGpSshKyXo8qHOFjskAIrIDFCydWifc503ndku/sHf7I+allbY97y+Sv/xUt1rZ6JyCw41+DnEW4LWTPtqAukTwa+BKM4qxXjzkeauSZyH+cHUfG4vB3a++I96NC471IDYtEtlIzaNodfubi9ImAAbTEnVUjzr+ydR/JRywrpd1rtDf//bsbfGZIkTb3QgWtl0io40uKjMuUe8QWPp1WsKFCAu7qV3nlRTIBJIGWe2QOlEBRcTyzaPOgjrdyxUxD+wNkSrZhn8358j/GYAoVyZUvLFoNueXT2J6ZC0wkypb6Wb0NO/ncrmLHeD+nMnQA3okJzUTm/gNm8XJIWsTk88m1AvgIphFn2Rvgx4jt+mB6gs7V7fa28V5LoIhigfCYadQFjR2yPtrznKf0cdcTwTAQZ24/Nr4eIlmDd7kvzNBMz2+vmKIAC6XW4qdmjxnnpCaannNjhXSXj1+f1b8b217BS4x8x/BT6goAfxw6zcAha4OJFg4rvS9ME
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(83380400001)(186003)(356005)(2906002)(82310400003)(5660300002)(81166007)(8676002)(8936002)(82740400003)(36756003)(1076003)(316002)(6666004)(7696005)(478600001)(86362001)(426003)(70206006)(336012)(70586007)(4326008)(26005)(2616005)(36860700001)(6916009)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 06:17:07.0200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a53dd8-8b57-41ff-ca97-08d91f44b8f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1442
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
Cc: Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. eliminate potential array index out of bounds.
2. return meaningful value for failure.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I9be36eb2e42ee46cd00464b0f2c35a4e4ea213e3
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 69 ++++++++++---------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 8f4a8f8d8146..5c2b4403a5b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -101,7 +101,8 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
 	unsigned char buff[34];
-	int addrptr = 0, size = 0;
+	int addrptr, size;
+	int len;
 
 	if (!is_fru_eeprom_supported(adev))
 		return 0;
@@ -109,7 +110,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	/* If algo exists, it means that the i2c_adapter's initialized */
 	if (!adev->pm.smu_i2c.algo) {
 		DRM_WARN("Cannot access FRU, EEPROM accessor not initialized");
-		return 0;
+		return -ENODEV;
 	}
 
 	/* There's a lot of repetition here. This is due to the FRU having
@@ -125,75 +126,75 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * and the language field, so just start from 0xb, manufacturer size
 	 */
 	addrptr = 0xb;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
-		return size;
+	len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	if (len < 1) {
+		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", len);
+		return -EINVAL;
 	}
 
 	/* Increment the addrptr by the size of the field, and 1 due to the
 	 * size field being 1 byte. This pattern continues below.
 	 */
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
-		return size;
+	len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	if (len < 1) {
+		DRM_ERROR("Failed to read FRU product name, ret:%d", len);
+		return -EINVAL;
 	}
 
 	/* Product name should only be 32 characters. Any more,
 	 * and something could be wrong. Cap it at 32 to be safe
 	 */
-	if (size > 32) {
+	if (len >= sizeof(adev->product_name)) {
 		DRM_WARN("FRU Product Number is larger than 32 characters. This is likely a mistake");
-		size = 32;
+		len = sizeof(adev->product_name) - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buff[2], size);
-	adev->product_name[size] = '\0';
+	memcpy(adev->product_name, &buff[2], len);
+	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
-		return size;
+	len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	if (len < 1) {
+		DRM_ERROR("Failed to read FRU product number, ret:%d", len);
+		return -EINVAL;
 	}
 
 	/* Product number should only be 16 characters. Any more,
 	 * and something could be wrong. Cap it at 16 to be safe
 	 */
-	if (size > 16) {
+	if (len >= sizeof(adev->product_number)) {
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
-		size = 16;
+		len = sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buff[2], size);
-	adev->product_number[size] = '\0';
+	memcpy(adev->product_number, &buff[2], len);
+	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
-		return size;
+	if (len < 1) {
+		DRM_ERROR("Failed to read FRU product version, ret:%d", len);
+		return -EINVAL;
 	}
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	len = size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 
-	if (size < 1) {
-		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
-		return size;
+	if (len < 1) {
+		DRM_ERROR("Failed to read FRU serial number, ret:%d", len);
+		return -EINVAL;
 	}
 
 	/* Serial number should only be 16 characters. Any more,
 	 * and something could be wrong. Cap it at 16 to be safe
 	 */
-	if (size > 16) {
+	if (len >= sizeof(adev->serial)) {
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
-		size = 16;
+		len = sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff[2], size);
-	adev->serial[size] = '\0';
+	memcpy(adev->serial, &buff[2], len);
+	adev->serial[len] = '\0';
 
 	return 0;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
