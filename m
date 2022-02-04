Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FE3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 01:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4FED10E1AE;
	Fri,  4 Feb 2022 01:08:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8055910E1AE
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 01:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qz/mXmVs4kcNgbODbLPUxUcqgo6Fp0ofVfibvU7hIHnMeAxaPyqgDL2kSMMhGAZ05/L3YVIqpEVQcLsUNgSX8QI3tuz+grte4eepgpGGiL1othFEI53EyIHrbrkAN63R2ntFTF1RwuxOI5bRg6DSA01s9E04XwMczk8EKlhGevCu8Guw5lxcmKC4wg4Tx13nkBXx4nf9fryXfMm8vMMZ5H0ozuj4XXrAI4KG5B/Bj+AbT5JNmsA+Xt2kH20IWmsXQPlm2dE4tb/qUJk6vRTvjO/HJHdMah4KUQPgGh3uJ2d3R9OCgq3N66oj5RGgKkvnVlPmrI5jPXQXrbbFxCvIiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8byCrz8pZzZPMlADMDJUR4MnD+LVuV2rR+cQf6nmww=;
 b=ae6IgJH7bB+b+O9RQM0vZ2xmHVdlP9RmhFvCGZuEV18y4YoSg9nlYUcmeLDnlljfpb/WlFjDJTSWBHOfxW0BA6dgOMKJW1Ad/iwwAgXKKwMrdWux9/WxrVsP0V7DlN3TeURTnZq0CyJizAE8XxaZaYxFKSO819UrZPODCzrx2a+XqpaMU26kg3dG6Smqkp/I7jiI0ZJXDIh2q+Ymi9fJF+QIzO6MffhOLf0jaPjB6AtaVC4tguE0MvdIveo/9J9jjRRQvHe4HJdhZ/662IpscPGI9COWYGI21msWq4B1DsIqEEnpXJpho9d/r5gc4E16MF0Ui0lDb7JKBKedZu5pZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8byCrz8pZzZPMlADMDJUR4MnD+LVuV2rR+cQf6nmww=;
 b=HPxGTE8/iPUbxOuavnR9L5znglrK8MKkUorhzZ1ywSFVq411CO1RyTdIS7BV4wPpy+PYGQxFjIGU19TXthSwbfzpjrZlkcJnmpWeTJoPskryD1dysBxVADLRXop1irkX1d+vOAb9t1J1cTXVIhKcBkqpSmA5jOtdpkcrCWOmAFo=
Received: from DM3PR11CA0001.namprd11.prod.outlook.com (2603:10b6:0:54::11) by
 PH0PR12MB5434.namprd12.prod.outlook.com (2603:10b6:510:d5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.19; Fri, 4 Feb 2022 01:08:36 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::69) by DM3PR11CA0001.outlook.office365.com
 (2603:10b6:0:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 01:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 01:08:35 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 3 Feb 2022 19:08:34 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Prevent random memory access in FRU code
Date: Thu, 3 Feb 2022 20:08:20 -0500
Message-ID: <20220204010820.250829-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
In-Reply-To: <20220204010820.250829-1-luben.tuikov@amd.com>
References: <20220204010820.250829-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09edaa7d-2036-4aed-1683-08d9e77adeb9
X-MS-TrafficTypeDiagnostic: PH0PR12MB5434:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54341583D028781B3BBB8C5999299@PH0PR12MB5434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owiV1nkjKMlbbCxCqDNKkOMg2Cy90/hfPsIzmuEkRakXM3Vg0NQpO5VOfV+v/vWt7OZCppmmnphE7ivd0trvDVb/3gw6f5691bASb2GTTQO4ibg7ELJjAFhDH0JpPjXLw0ICW+Eo4jQyqUeT+zB7d7YnfXvi+DQ0DPllWUBES4D2hnOmLLpNNbXr3raB5DOgIvLCG3dRuo46LOPutGDoidvV75J4h0yqVe5WGDnh62bwlriI5rYUEUeK3ujLw3EOyfTeEcfJk5sdWSfHSaUIkksTT3SsMEGxjuqkvl1CKHKE8gH+ds6nm+TdFszNcgLeb/D9bl+ZI1RXQRrNV3VRu8qewNx1Iiyh7dTJ8Q4foA9jJQ0jbq+HmIay9fFf2AAas1haSMj0ljut2OB/alxGGy1itAgr5/ulI3PBHKZeTJxieDujlHt/fiQrExbdpuBra1ck6S0tc7YbSFTL4c1h0eqzo92SqlO0s+yQYCD4PAp3K5f+83YSSyFpRcQXa1C0NUtcGdWOlPo1ZyM5xMW5rHhn/o9/VJ9+M4Xjl28WpmLzTgm/Qoy35uqhTW615Nn0IeJ/fXo8SNUGGKBqCo2t5N7/Z8ywFXC4lw7Z4a8SEDpEtCxeg+xV4wxN67bHkTu52w5n7Wm4rOI5t0HV0UJ8rt74LoAAfzMm0TjtY3gLTvZJwd13Rsa9+fVhsbzxZjK7Fg0tN5vXlXPjI6GvDSkhkw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(16526019)(426003)(336012)(40460700003)(1076003)(186003)(4326008)(70206006)(26005)(8676002)(8936002)(70586007)(47076005)(54906003)(6916009)(36756003)(2616005)(316002)(36860700001)(81166007)(508600001)(356005)(5660300002)(2906002)(86362001)(82310400004)(6666004)(44832011)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 01:08:35.7240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09edaa7d-2036-4aed-1683-08d9e77adeb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5434
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
index e56d2c79b444bb..d9cc955579fa0b 100644
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
@@ -156,7 +159,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	adev->product_name[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product number, ret:%d", size);
 		return -EINVAL;
@@ -174,7 +177,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	adev->product_number[len] = '\0';
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU product version, ret:%d", size);
@@ -182,7 +185,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 	}
 
 	addrptr += size + 1;
-	size = amdgpu_fru_read_eeprom(adev, addrptr, buf);
+	size = amdgpu_fru_read_eeprom(adev, addrptr, buf, sizeof(buf));
 
 	if (size < 1) {
 		DRM_ERROR("Failed to read FRU serial number, ret:%d", size);
-- 
2.35.0.3.gb23dac905b

