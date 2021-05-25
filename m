Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766EEC2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 06:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15907611C9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 06:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15907611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9706D6E9AD;
	Tue, 25 May 2021 06:42:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AB96E9AC
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 06:42:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcjBnhwjsIpJOa7N5St3x2vYIfHYI0266JLhZsCCGnDH2pgntiQNXPY02sWrxftvAFHnnBF7Zwp6hVRmIQDyJmolYj3G9hPSdRY0zupZztnf8ur2lKas4Ir9pJXjGxko1thCk5MclPTVZXwUytLsZsNJiCmzLQ7Fsh7t/H/99IeNU1OPIP17G3o4Mowj98uN2hCNGB9M+v3hUN/zgC/nKO3CzoJip3na/lkBtUWDqGFRWAbJJd7tyzklRsaEsmINMftGLyvSc41M2DrADDovHQ+0HHBohxCv45torLjvuqkzmanig20ysqy5rhLKx/O+b6DDl3VwlhFGQJS2OmmKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7PgszSfyuod8nqDOMozR4vrGcFRLigioOPKc4lk8cU=;
 b=PyAf9HqNpm1TMyoLkyWsKPFlO9B8EAa8XJms2TOIxKiawV0Jk6PC7DykJRPD3JYWbc+ARmkQ9QDlOHK/YIGkiVeoMoPvFMOlvNyqHyUnPjv8GzT1tCjrf5r0MLX7JYjCR7jCBgWR6wr1kfDLC94wubbh/kNbVlWPgWF9PjHl/wN9cK0gkZamU+RjVNBzxwsjpAB4pvnJ+6foc+cs3kEai6o4yFtyBlXTJw3cVVYqaNichoq4AAVypHgOxiIqvFxi4e9MKiWARgfB/MipjybCxePjNFmaeRNUK5b+H94kvZQSgRDQCIuGrqODpT5yECuopmodCAWs02HOPBT8cdYg4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7PgszSfyuod8nqDOMozR4vrGcFRLigioOPKc4lk8cU=;
 b=T1uD6yB3nM9AIcuI3cFkpN5N/Gz4SJkLbp5LANJIRVFlyOv1n37+/5Gnrl9zpLSjfDarfahBEQW97HLSovKoNmLJV1lq3GhNqBML+qDiKcoMF4SHahgVmmI7wY6KHmdtKWnN/mAXQ2VJv/O5qyjuEySe3bCbX1E/HDxsdXll5d8=
Received: from BN9PR03CA0482.namprd03.prod.outlook.com (2603:10b6:408:130::7)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 06:42:32 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::43) by BN9PR03CA0482.outlook.office365.com
 (2603:10b6:408:130::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Tue, 25 May 2021 06:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 25 May 2021 06:42:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 01:42:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 25 May
 2021 01:42:31 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Tue, 25 May 2021 01:42:30 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: refine amdgpu_fru_get_product_info
Date: Tue, 25 May 2021 14:42:22 +0800
Message-ID: <20210525064222.32495-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef7842b4-221a-48c3-ff6d-08d91f484621
X-MS-TrafficTypeDiagnostic: MW3PR12MB4362:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4362771FAFCF36DC3B44415DEA259@MW3PR12MB4362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jrtpOzZ/2dJJuczxdKJN22VmhuZz36lSLvtFya+otS66nHssjzqUoMujOEfpqpSKN01YSl+8t+0bNLGDXOmLZJQc5A3e67LaYRvkBn6UNrx56EdQkB5vb/GlijuG2hCyS/7oYbLzMrHfBrWffHTCfsNGXCDQmyk3T+wBRUSTAnww8j/+ibKEoU0gIFYgRIuuA0LeP7KNZqZ887vklN9xhsZUe5EIMepLNmdZlzSJUS3z/vR+wjvjfSqyCjuuQ/DII3A4+aU9xQWrOzw2uUP5OYnXjgl+kpsXnksWhPcRJK63LTM3Dc4tn9OmHi+RhnsHspbuPnUStpfbMcb2Q6Hr6Y4+4/mrZ5kSSDwqQY2NispcNWwLngDhhUIqoa2I4uViGOCwRW4hyMrBVlxsvfgv4zz6rIJaTnzBucUINU8peM15hnXQJ+0vpIDphKalJUmOcUxcoQCqtybX0S2BCQyvm1Dn8ZjcTXvFYWYYv4CtQhglZ3uKhMk9NYFOASVn5nj16uVFkWjA17lEwoD569MsjqW7TSimQgxWms98uoMxmX7hw2zAk1kFoj2jATADqF0dEFEBK93dj3YXUsMVU8yROp704tZ8Tqlv1SXsCr4GD2waSfheXp2418hGNld7h7U+cyjj5b0tP+bJe72g9NIWZlCiJrQrwmb7GMw0hsWIuWZt5nbrfjafA8RexbBS2n1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(46966006)(70586007)(86362001)(426003)(7696005)(2616005)(2906002)(36860700001)(478600001)(5660300002)(186003)(81166007)(1076003)(8676002)(70206006)(83380400001)(356005)(82740400003)(316002)(336012)(26005)(36756003)(82310400003)(6916009)(8936002)(47076005)(4326008)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 06:42:32.3925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7842b4-221a-48c3-ff6d-08d91f484621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
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
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 42 ++++++++++---------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 8f4a8f8d8146..39b6c6bfab45 100644
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
@@ -128,7 +129,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
 	/* Increment the addrptr by the size of the field, and 1 due to the
@@ -138,43 +139,45 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
+	len = size;
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
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
+	len = size;
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
 	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
 	addrptr += size + 1;
@@ -182,18 +185,19 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
-		return size;
+		return -EINVAL;
 	}
 
+	len = size;
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
