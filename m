Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7DCC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 05:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DDBB10ED31;
	Fri,  4 Feb 2022 05:27:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2652310ED2A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 05:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDoxX+XtkW/hkRwYEa6+0L1zXOrY9vzm6cWJn1n/8ohSAocsi/hXNOaJa9kCravgpzmiZqajnlR+X8QENKetHw+26BCAcm0qsF3VM5m1nyw36IWeXHKEfrReWI03nHGGN/rn2YNr8aKsaTK+eAgljps827RtAgcw8LSZtgDaDol76Ami4Ee+1clY2lt/X4Nv2Dwgk36WunZWXyavUkT+hzMZxOFDpojn5ZfRmdLMANobf1GBOGKFzUxGgW/PJF1/lKNC5CPWfWDYX08xK3F1YOXmwWMfpK314BVoPMvvwV17pdZ9XVOlCuPT1eJvYMZKTQXPkqICQ2tXm8+jHYxAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS1PJ2aW4RuN9eI+e58TTbeyNQVLUY56Jv9Jk9rBtFg=;
 b=HX2XRBac/QksYUrMLaAEef4WnaRhdTx0LIZ9nEzUrtaiLp5suq0ZH7q5cEi67GlCnhpemGjJpcxzL8dRsoK601t7GpeRBwM5j+SawE2riioqJUScPrEEAqWKiHgULk1IOkA7mbC2FgH7aXnMMiQWT+qlSnNDeYeci56LYB3OD14o/siCOQV50aIRaJpYcgazPft21jUImZS6J0hXgk8BGKmINUyTBmkT2o0ceGr57jO+OFE5e3Xd7qhYt9504ntvRU8XGvJwQvs/a0fiqush/fNKtBTsAss3S9Bcj2a0vcDcoox5HdDlENcw+P/RK2FmuuGfaDULfeU+Z4URSw3QHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS1PJ2aW4RuN9eI+e58TTbeyNQVLUY56Jv9Jk9rBtFg=;
 b=tVJDvPp+QtAly/fM7wRWPL2C11sgkGnhRLVUltQSRTTt5h9m/B34GDEU1JiWvSL26A1ZL3Zm/R1nSk83jMtbo0HDoUuthWy2GKH3TFe3u0dSCgxaYqPaTx4SMIp+vM1EKoomKJ60YocRkBkpkKJBVAiMLjFnkJ42NMni/h74HpI=
Received: from CO2PR05CA0085.namprd05.prod.outlook.com (2603:10b6:104:1::11)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 05:27:39 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::1c) by CO2PR05CA0085.outlook.office365.com
 (2603:10b6:104:1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Fri, 4 Feb 2022 05:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 05:27:39 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 23:27:37 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 1/3] drm/amdgpu: Nerf "buff" to "buf"
Date: Fri, 4 Feb 2022 00:27:22 -0500
Message-ID: <20220204052724.469469-2-luben.tuikov@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3904734-a494-44e4-19a2-08d9e79f0f7d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4177:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB417707C325409D4EC59D505099299@BY5PR12MB4177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTNe/fcvC34WqP19fzl4QRRdyFrD57T9p/ug/DoVBZVV3aqXd3ETDhDctp5ThxwG19fpOjSbyG5gubN+8t0/mBLTet/96sL7TtZbeCvIXmATjpGtNRUBSCPuJ+dyH161/SsmylA+CDGFIjnGuwCSQWvffpjpSrqPWgm35VtRX5JtFiN4WWlPQpCU5hKNIsMg4O3VMpbMWARtPXLrWdKzbjaIwNumiPKDsjaZT20sHgLK0RIKi8vRUMpxiX5KvYzF1Fin8WvwNNXfoXHdqSMJO7WTdHtAGG13Ma3UvjWkfGfrRUmzVgbTwO2RF/sZW4Vx4ol+2QdkyCPHESu/N7x8FChsHh3C44ibrpM9zRwqpOWNF4hrRH1RVrkkY+LnANSW4dULw8NHdGthHZ3cPJwXTwBktjylDkJbdmYZsOVscJ9tsVe26uV1mIxAg9F+CAGzo2U7QVpXvCoel04ZYqOT3L9v/RYVCDvLsbpTfflHIP5tNgDzQzqugeOn4N9vyhkfCSuISB/saVSv/+Voj1ffB6KPS9pxePsSoma982UHOJ+aKOph14W2zjgghGVEkE9HvnbzZ8cZwEYaIk9PErB3GbkK1gMJ8jRj0aPYZsYBAHZg8GXEuQggzWSs6cQgDHRN3g9cAI583UfdrtNYHKWBZVeuCOcubxGzDKDruYpcmohw2DnZbueeo6HVAXgJTlyTDBvQO9RI75IXKNc6FN8THw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(7696005)(2906002)(82310400004)(40460700003)(47076005)(16526019)(356005)(83380400001)(36860700001)(86362001)(81166007)(2616005)(1076003)(336012)(26005)(36756003)(8936002)(316002)(186003)(70206006)(508600001)(70586007)(54906003)(5660300002)(8676002)(426003)(6916009)(4326008)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 05:27:39.3277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3904734-a494-44e4-19a2-08d9e79f0f7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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

Buffer is abbreviated "buf" (buf-fer), not "buff" (buff-er).
This is consistent with the rest of the kernel code.

Cc: Kent Russell <kent.russell@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index ce5d5ee336a990..792337433a9ee5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -77,11 +77,11 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 }
 
 static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
-				  unsigned char *buff)
+				  unsigned char *buf)
 {
 	int ret, size;
 
-	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buff, 1);
+	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buf, 1);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get size field");
 		return ret;
@@ -90,9 +90,9 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	/* The size returned by the i2c requires subtraction of 0xC0 since the
 	 * size apparently always reports as 0xC0+actual size.
 	 */
-	size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
+	size = buf[0] - I2C_PRODUCT_INFO_OFFSET;
 
-	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1, buff, size);
+	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1, buf, size);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
@@ -103,7 +103,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 {
-	unsigned char buff[AMDGPU_PRODUCT_NAME_LEN+2];
+	unsigned char buf[AMDGPU_PRODUCT_NAME_LEN+2];
 	u32 addrptr;
 	int size, len;
 	int offset = 2;
@@ -133,7 +133,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * and the language field, so just start from 0xb, manufacturer size
 	 */
 	addrptr = FRU_EEPROM_MADDR + 0xb;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU Manufacturer, ret:%d", size);
 		return -EINVAL;
@@ -143,7 +143,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	 * size field being 1 byte. This pattern continues below.
 	 */
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product name, ret:%d", size);
 		return -EINVAL;
@@ -155,12 +155,12 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 				AMDGPU_PRODUCT_NAME_LEN);
 		len = AMDGPU_PRODUCT_NAME_LEN - 1;
 	}
-	/* Start at 2 due to buff using fields 0 and 1 for the address */
-	memcpy(adev->product_name, &buff[offset], len);
+	/* Start at 2 due to buf using fields 0 and 1 for the address */
+	memcpy(adev->product_name, &buf[offset], len);
 	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
 		return -EINVAL;
@@ -174,11 +174,11 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Product Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->product_number) - 1;
 	}
-	memcpy(adev->product_number, &buff[offset], len);
+	memcpy(adev->product_number, &buf[offset], len);
 	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
@@ -186,7 +186,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	}
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buff);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
@@ -201,7 +201,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		DRM_WARN("FRU Serial Number is larger than 16 characters. This is likely a mistake");
 		len = sizeof(adev->serial) - 1;
 	}
-	memcpy(adev->serial, &buff[offset], len);
+	memcpy(adev->serial, &buf[offset], len);
 	adev->serial[len] = '\0';
 
 	return 0;
-- 
2.35.0.3.gb23dac905b

