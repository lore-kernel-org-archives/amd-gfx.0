Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600D6C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 05:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A6010E1DA;
	Fri,  4 Feb 2022 05:27:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5475710ED63
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 05:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCxQDrr+WJY9cH5cQIOLXP151iHK/Np+uDm8OHB3YzKfAuhZjglbtgEvH0lzIuBmXSlQkwAr7K7Xn8DU5dQoFyFAzg0uRpU2Q69yxoQDHU/qzlfFDsfqQpaKaB+DmbwNAovNmV0oXv6WpgP5Q+C4m2hPosHmM6W0M8ftC9K1/WAfgXAoS6tPmwea7dX7/3s/4tHsraJc7X4u6Fd5ASr2TG2ORvw+C9CqMrjaiuv7eakbt2aFeKbz5qdp1bZ0cMm+nsJndogsV4fHC4XTyLkoe9hodFHHrWIGUWi7TWbX1LUlxwe5hDcKe6e4tzYTKf0XgS3Cxwh4rRX2gns9VG7LOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeD88uWSdtCLP8tkympSlDRXRo/Y8Ok8ArBTgTa4xk8=;
 b=mTOK7VwdSsV3kid0JErFqNO6UhhQOJ4rvqKydEYLTMe8AqpUdcGBPkCOFa/TscVzcy5HNMlCBUooDBpzzKKFr03bMKKXt4U02vyrHolpZuf2XTtIImBshyBNXlVFGgnEk6/IzIo9K/p7yJuUcC/Jfs0vB1Wlx5PvXTVHawgZM6a9Mke03v98ffojBn/hwUkda92MInltM6MEK3/j4vmP5O+zFKFwgMHn5k6G80RO0zeb2HudQUNT4kxHbc/EfnNn3/YfdWfat9uJHAjVdGAe/NttRA/1rOATYk5ZIteSMn5VqXeYQhnHJPg5DXIXgghb1C2wwK7MuugGRylHko4Amg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeD88uWSdtCLP8tkympSlDRXRo/Y8Ok8ArBTgTa4xk8=;
 b=IVjGNvsHBLhvjLdOE3hJlQjb12RIJd82a0LA6VPbfguh58yCVojPeynvSNTikNJlEU92UN7nN7dcYLeLsV7As0Hzh1jQC36t+VAxxSgWRbn0kSryP8533Ink+Sb82sm6RRLeJRkZSnLfmqrB1ZqQwemYD97cnqbKYqA810XBrMw=
Received: from CO2PR05CA0103.namprd05.prod.outlook.com (2603:10b6:104:1::29)
 by SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 4 Feb
 2022 05:27:41 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::cc) by CO2PR05CA0103.outlook.office365.com
 (2603:10b6:104:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 05:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 05:27:41 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 23:27:38 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 3/3] drm/amdgpu: Prevent random memory access in FRU code
Date: Fri, 4 Feb 2022 00:27:24 -0500
Message-ID: <20220204052724.469469-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
In-Reply-To: <20220204052724.469469-1-luben.tuikov@amd.com>
References: <20220204052724.469469-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ab81cd9-de61-45c9-b7a3-08d9e79f10a4
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB23846A25A37B987BD31F4BF099299@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5i98BGwvtzuZS/yRPJpF/EFjxVGre9xjT4Fa4wAHEz3WGrFm9BVpUK0X0qIrM0fZhAXfGF+sRcuqmEDIoFH6zM4vIoyT/ltSWgbAJrTp2sIlXDdZwdYN7f7tXXTMKSLdlNH9gVxVOR+aMtGTlLDJiMCZgLXWz19RaIph9oZ20py20TT+qXtAZf+gvCPsfOf+dXEaVva7Kp72j3OJDPGzekkHlq8iuJYvnnXdnoRMIwgPMkhlZa4gszYyPaZawLllpb5m5e9OFIujJy8vVFSHj5FOyPSRvD3e/pGE+OaUCBMeEMlxY/Xp3mqPuYo5GKl0BjUjHm22p/mqGlgLsV8Xp/PQQAqHBycIXopKaYt4xcaT7GFrqRk+xkXc5cka0QlKFhGGPr4/C80eBJZnu5MePdN+7sDiC/rvoS+l6Il6fLPpTkv9bZMQLv24bfJN3dy7LcAHePYRPzOVpOd1z8P8oCpjYb0SIrms9xxjsexj2Sz44xufhKYT0+gauIZkziwU4AiAHOCDfjNRHPRuI74y8CwNF8P/oXpk+pmZ3J0p9ER+TMqPxIFbipTQwileTA1XF85A/s9ZUrThLcrPh7agQGEajRyXK7G66Y4j8DOjrjWGrTqpuzNB6gs5hQaiXAec/HNuZWn3P015UWF2Aisa8izoyo06zookW+JlGnaJxJvEMekrPiuHEsOcUZpqmptcN88H8ZOT3WscJ+jLslhbcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(86362001)(36860700001)(40460700003)(81166007)(54906003)(6916009)(316002)(508600001)(44832011)(47076005)(356005)(5660300002)(70586007)(70206006)(8676002)(8936002)(4326008)(2906002)(336012)(426003)(83380400001)(7696005)(6666004)(186003)(1076003)(16526019)(2616005)(26005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 05:27:41.2807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab81cd9-de61-45c9-b7a3-08d9e79f10a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
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

Prevent random memory access in the FRU EEPROM code by passing the size of
the destination buffer to the reading routine, and reading no more than the
size of the buffer.

Cc: Kent Russell <kent.russell@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 61c4e71e399855..07e045fae83a9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -77,9 +77,10 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 }
 
 static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-				  unsigned char *buf)
+				  unsigned char *buf, size_t buf_size)
 {
-	int ret, size;
+	int ret;
+	u8 size;
 
 	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buf, 1);
 	if (ret < 1) {
@@ -90,9 +91,11 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	/* The size returned by the i2c requires subtraction of 0xC0 since the
 	 * size apparently always reports as 0xC0+actual size.
 	 */
-	size = buf[0] - I2C_PRODUCT_INFO_OFFSET;
+	size = buf[0] & 0x3F;
+	size = min_t(size_t, size, buf_size);
 
-	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1, buf, size);
+	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1,
+				 buf, size);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
@@ -129,7 +132,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * and the language field, so just start from 0xb, manufacturer size
 	 */
 	addrptr = FRU_EEPROM_MADDR + 0xb;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
 		return -EINVAL;
@@ -139,7 +142,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * size field being 1 byte. This pattern continues below.
 	 */
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
 		return -EINVAL;
@@ -155,7 +158,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
 		return -EINVAL;
@@ -173,7 +176,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
@@ -181,7 +184,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	}
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
-- 
2.35.0.3.gb23dac905b

