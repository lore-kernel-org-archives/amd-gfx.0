Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB95C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 18:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95ABE10E276;
	Thu, 27 Jan 2022 18:54:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA4E10E266
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 18:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwnggxhhUxzLYaRfh348YGHj/XhGrVJR2TtlcbVU844f6PeAFDIiMji10sDs3dPuHhT0uyCHtTtZ8twXExtcByLsc1tOSXk6bc37xkDEBZD6fqet1G2/goIIhTf0u0TgnxoFKxDq1DxVKuJ9Jw9UzFBM8x33EIf1hWg5ReFkkV7rQqDKGuYc4A6K84+SZ6XXRbw3b2xNz5dmr0N6HyCbGsCHsZEqbDzp1k51HMEdZ2FOiamWpyVrwtkBMHdxMkWPnFPZlJZdR+2aGMcVnzOgM9VPUMANHO9DDY70uxPx7/ZHDCG5N0hycwhrkaLEcLyfUVBHuo0Zzpq741KPlH/Xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwyrMi3s0eXJ7XhC5P1iBC4zjSSqrMeqU/ePg3XoQt0=;
 b=dwKANTJOd0vEzEmk49TECehIt8F4JsbNikdZ08X8lsIkOx7O0PqBQ+9gGLOkmPQ4Ke8EK0eAgM1P6OsU4tE5EOeunU2EXRU486OqCAaVx8jWvmz03UkpB6GMdi49RfGgJr0FD0hdaFrCHR7DkWgLrEx7DMayXQFEnOUaVWy18JiEiDisHikp2cGllebry9tE6FTZLCx0frswCiLaQhBAYfbD//nGWqDdyxXAvH/KxILGAgMhz56Li8xTwzjPR73Utd7GrBo5BltbRHWZWJfQfM5mt9jTAi2CxLAdsif4EL1uFTyYERUQjHdSAPxvHWw+EzXIy9vh2Gqm6gJvZ+sDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwyrMi3s0eXJ7XhC5P1iBC4zjSSqrMeqU/ePg3XoQt0=;
 b=K9MZxVzcEOLftsHKFvJW2S9sSKE4hOUjJtPhqZbUUMN0lCZnSSPl1vxM+LsUHtHIsxtJx2lwIEcdeXP+Ur0P3bsjbFgAY9tTnTOc23A0wMjCQDDsOBaMXdKq33WyggYaAZI9UePAu8xYtJmIZwm5uDGHPP1Gv25IsfnhGBIb3bM=
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 27 Jan
 2022 18:54:09 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::7) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.19 via Frontend
 Transport; Thu, 27 Jan 2022 18:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 18:54:09 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 27 Jan
 2022 12:54:08 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd: Expose the FRU SMU I2C bus
Date: Thu, 27 Jan 2022 13:53:48 -0500
Message-ID: <20220127185350.66455-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c0d422b-7de8-4143-88b6-08d9e1c666df
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366A125C68FEDB9FE69A2A699219@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfVuO4kD9a68jWra9fYdunzxbVgylZ6lcVlbbURzVeoM65P0aBtH1iOyL+SdXH5slTNoWh0Cukr963eenvHlLWkHwX9rQ7I1XqMQPX2iVQrowO2A/IfL7LWJb1bzAngSTfBmjhJUHOxdcCnorp6Nsx+9MBflS6Wa7me5N6gihT2FHkv27Q6xTdQhzMZ425o4PGjtJKuu7zkTJFPKXq+jJ8F6z6AlMlW7G454CJoJ6MGH+Q+yVQx1aC9MmZolVX5cX0CZ9oVNs3KJO0OeZabM9QFYduTUMbw6QQbvIiOIZHQEDY2OxHy/C8vvLq0vhWu0gHZh8opbmDdSaIqAY/tv1V7aphvyKY8p4dnQHrgRahgll6LmifUZn57KYDG0yaNUl7KeuesdON1oFUHXiefsaWkcEm0PjPTI7konH7YY5irL/14zm5dW0P8L84akmTQT6HsDGJjiLj+sSp+eGQA+1S/wpUEn2x/fXsW6O4DCFnmlSltaKUV5yB5Iztbu7KHS8C537397SYuCp75wxBuI3N9/wcZaXMizPlQhfdEefZ8nDdo+pYpr7H2fNP6BU+UyIFIWIn7y16KT87u/2mB+9QEPft1KRXeolqAcX6oUICLXWp9vSav3ZXzLivak2fW1QLowrqTtGnwTPWirrtBrOVB84aP55MuixRID4Q0uFnfJSN1PEj3miwIESuDz1gRy0+RnE926r3ckpmE9WBzXw2DDc62W74/fDl6GX7yeKcG7basxNMLNINJVCC+XffZI30j/nsOetVS3jVDjfpQ5OGHu2+cSbMmY0DaN2ceomh9W6qSNqS+MlGicy8bIMwAY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(7696005)(336012)(54906003)(426003)(44832011)(5660300002)(86362001)(508600001)(30864003)(40460700003)(2616005)(316002)(47076005)(81166007)(83380400001)(8936002)(70586007)(16526019)(4326008)(70206006)(1076003)(36860700001)(36756003)(26005)(2906002)(6666004)(6916009)(186003)(82310400004)(356005)(8676002)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 18:54:09.4241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0d422b-7de8-4143-88b6-08d9e1c666df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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
Cc: Alex
 Deucher <Alexander.Deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Roy Sun <Roy.Sun@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expose the FRU SMU I2C bus.

Cc: Roy Sun <Roy.Sun@amd.com>
Co-developed-by: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    |  6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 14 ++--
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    | 80 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h    |  6 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       | 14 +++-
 .../amd/pm/powerplay/smumgr/vega20_smumgr.c   |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 69 +++++++++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 68 +++++++++++-----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 71 +++++++++++-----
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 44 +++++++---
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  4 +-
 13 files changed, 273 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 60e7e637eaa33d..40180648be3811 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -75,7 +75,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 {
 	int ret, size;
 
-	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr, buff, 1);
+	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr, buff, 1);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get size field");
 		return ret;
@@ -86,7 +86,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 	 */
 	size = buff[0] - I2C_PRODUCT_INFO_OFFSET;
 
-	ret = amdgpu_eeprom_read(&adev->pm.smu_i2c, addrptr + 1, buff, size);
+	ret = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addrptr + 1, buff, size);
 	if (ret < 1) {
 		DRM_WARN("FRU: Failed to get data field");
 		return ret;
@@ -109,7 +109,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		offset = 0;
 
 	/* If algo exists, it means that the i2c_adapter's initialized */
-	if (!adev->pm.smu_i2c.algo) {
+	if (!adev->pm.fru_eeprom_i2c_bus || !adev->pm.fru_eeprom_i2c_bus->algo) {
 		DRM_WARN("Cannot access FRU, EEPROM accessor not initialized");
 		return -ENODEV;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 05117eda105b55..c09d047272b207 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -194,7 +194,7 @@ static int __write_table_header(struct amdgpu_ras_eeprom_control *control)
 
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
-	res = amdgpu_eeprom_write(&adev->pm.smu_i2c,
+	res = amdgpu_eeprom_write(adev->pm.ras_eeprom_i2c_bus,
 				  control->i2c_address +
 				  control->ras_header_offset,
 				  buf, RAS_TABLE_HEADER_SIZE);
@@ -389,7 +389,7 @@ static int __amdgpu_ras_eeprom_write(struct amdgpu_ras_eeprom_control *control,
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
 	buf_size = num * RAS_TABLE_RECORD_SIZE;
-	res = amdgpu_eeprom_write(&adev->pm.smu_i2c,
+	res = amdgpu_eeprom_write(adev->pm.ras_eeprom_i2c_bus,
 				  control->i2c_address +
 				  RAS_INDEX_TO_OFFSET(control, fri),
 				  buf, buf_size);
@@ -548,7 +548,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 	}
 
 	down_read(&adev->reset_sem);
-	res = amdgpu_eeprom_read(&adev->pm.smu_i2c,
+	res = amdgpu_eeprom_read(adev->pm.ras_eeprom_i2c_bus,
 				 control->i2c_address +
 				 control->ras_record_offset,
 				 buf, buf_size);
@@ -644,7 +644,7 @@ static int __amdgpu_ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
 	/* i2c may be unstable in gpu reset */
 	down_read(&adev->reset_sem);
 	buf_size = num * RAS_TABLE_RECORD_SIZE;
-	res = amdgpu_eeprom_read(&adev->pm.smu_i2c,
+	res = amdgpu_eeprom_read(adev->pm.ras_eeprom_i2c_bus,
 				 control->i2c_address +
 				 RAS_INDEX_TO_OFFSET(control, fri),
 				 buf, buf_size);
@@ -1009,7 +1009,7 @@ static int __verify_ras_table_checksum(struct amdgpu_ras_eeprom_control *control
 		return -ENOMEM;
 	}
 
-	res = amdgpu_eeprom_read(&adev->pm.smu_i2c,
+	res = amdgpu_eeprom_read(adev->pm.ras_eeprom_i2c_bus,
 				 control->i2c_address +
 				 control->ras_header_offset,
 				 buf, buf_size);
@@ -1045,7 +1045,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 		return 0;
 
 	/* Verify i2c adapter is initialized */
-	if (!adev->pm.smu_i2c.algo)
+	if (!adev->pm.ras_eeprom_i2c_bus || !adev->pm.ras_eeprom_i2c_bus->algo)
 		return -ENOENT;
 
 	if (!__get_eeprom_i2c_addr(adev, control))
@@ -1057,7 +1057,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 	mutex_init(&control->ras_tbl_mutex);
 
 	/* Read the table header from EEPROM address */
-	res = amdgpu_eeprom_read(&adev->pm.smu_i2c,
+	res = amdgpu_eeprom_read(adev->pm.ras_eeprom_i2c_bus,
 				 control->i2c_address + control->ras_header_offset,
 				 buf, RAS_TABLE_HEADER_SIZE);
 	if (res < RAS_TABLE_HEADER_SIZE) {
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 73ffa8fde3df3f..87acb089cfccd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -26,6 +26,7 @@
 
 #include "smu_v11_0_i2c.h"
 #include "amdgpu.h"
+#include "amdgpu_dpm.h"
 #include "soc15_common.h"
 #include <drm/drm_fixed.h>
 #include <drm/drm_drv.h>
@@ -43,11 +44,10 @@
 
 #define I2C_X_RESTART         BIT(31)
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
-
 static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	uint32_t reg = RREG32_SOC15(SMUIO, 0, mmSMUIO_PWRMGT);
 
 	reg = REG_SET_FIELD(reg, SMUIO_PWRMGT, i2c_clk_gate_en, en ? 1 : 0);
@@ -75,7 +75,8 @@ static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
 
 static int smu_v11_0_i2c_enable(struct i2c_adapter *control, bool enable)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 
 	WREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_ENABLE, enable ? 1 : 0);
 
@@ -100,7 +101,8 @@ static int smu_v11_0_i2c_enable(struct i2c_adapter *control, bool enable)
 
 static void smu_v11_0_i2c_clear_status(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	/* do */
 	{
 		RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_CLR_INTR);
@@ -110,7 +112,8 @@ static void smu_v11_0_i2c_clear_status(struct i2c_adapter *control)
 
 static void smu_v11_0_i2c_configure(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	uint32_t reg = 0;
 
 	reg = REG_SET_FIELD(reg, CKSVII2C_IC_CON, IC_SLAVE_DISABLE, 1);
@@ -131,7 +134,8 @@ static void smu_v11_0_i2c_configure(struct i2c_adapter *control)
 
 static void smu_v11_0_i2c_set_clock(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 
 	/*
 	 * Standard mode speed, These values are taken from SMUIO MAS,
@@ -154,7 +158,8 @@ static void smu_v11_0_i2c_set_clock(struct i2c_adapter *control)
 
 static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, u16 address)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 
 	/* The IC_TAR::IC_TAR field is 10-bits wide.
 	 * It takes a 7-bit or 10-bit addresses as an address,
@@ -165,7 +170,8 @@ static void smu_v11_0_i2c_set_address(struct i2c_adapter *control, u16 address)
 
 static uint32_t smu_v11_0_i2c_poll_tx_status(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	uint32_t ret = I2C_OK;
 	uint32_t reg, reg_c_tx_abrt_source;
 
@@ -216,7 +222,8 @@ static uint32_t smu_v11_0_i2c_poll_tx_status(struct i2c_adapter *control)
 
 static uint32_t smu_v11_0_i2c_poll_rx_status(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	uint32_t ret = I2C_OK;
 	uint32_t reg_ic_status, reg_c_tx_abrt_source;
 
@@ -262,7 +269,8 @@ static uint32_t smu_v11_0_i2c_transmit(struct i2c_adapter *control,
 				       u16 address, u8 *data,
 				       u32 numbytes, u32 i2c_flag)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	u32 bytes_sent, reg, ret = I2C_OK;
 	unsigned long  timeout_counter;
 
@@ -360,7 +368,8 @@ static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
 				      u16 address, u8 *data,
 				      u32 numbytes, u32 i2c_flag)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	uint32_t bytes_received, ret = I2C_OK;
 
 	bytes_received = 0;
@@ -431,7 +440,8 @@ static uint32_t smu_v11_0_i2c_receive(struct i2c_adapter *control,
 
 static void smu_v11_0_i2c_abort(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	uint32_t reg = 0;
 
 	/* Enable I2C engine; */
@@ -447,7 +457,8 @@ static void smu_v11_0_i2c_abort(struct i2c_adapter *control)
 
 static bool smu_v11_0_i2c_activity_done(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 
 	const uint32_t IDLE_TIMEOUT = 1024;
 	uint32_t timeout_count = 0;
@@ -508,7 +519,8 @@ static void smu_v11_0_i2c_init(struct i2c_adapter *control)
 
 static void smu_v11_0_i2c_fini(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	u32 status, enable, en_stat;
 	int res;
 
@@ -543,7 +555,8 @@ static void smu_v11_0_i2c_fini(struct i2c_adapter *control)
 
 static bool smu_v11_0_i2c_bus_lock(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 
 	/* Send  PPSMC_MSG_RequestI2CBus */
 	if (!amdgpu_dpm_smu_i2c_bus_access(adev, true))
@@ -554,7 +567,8 @@ static bool smu_v11_0_i2c_bus_lock(struct i2c_adapter *control)
 
 static bool smu_v11_0_i2c_bus_unlock(struct i2c_adapter *control)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(control);
+	struct amdgpu_device *adev = smu_i2c->adev;
 
 	/* Send  PPSMC_MSG_ReleaseI2CBus */
 	if (!amdgpu_dpm_smu_i2c_bus_access(adev, false))
@@ -587,16 +601,17 @@ static uint32_t smu_v11_0_i2c_write_data(struct i2c_adapter *control,
 
 	if (ret != I2C_OK)
 		DRM_ERROR("WriteI2CData() - I2C error occurred :%x", ret);
-	
+
 	return ret;
 
 }
 
 static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(i2c);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(i2c);
+	struct amdgpu_device *adev = smu_i2c->adev;
 
-	mutex_lock(&adev->pm.smu_i2c_mutex);
+	mutex_lock(&smu_i2c->mutex);
 	if (!smu_v11_0_i2c_bus_lock(i2c))
 		DRM_ERROR("Failed to lock the bus from SMU");
 	else
@@ -611,13 +626,14 @@ static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
 
 static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(i2c);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(i2c);
+	struct amdgpu_device *adev = smu_i2c->adev;
 
 	if (!smu_v11_0_i2c_bus_unlock(i2c))
 		DRM_ERROR("Failed to unlock the bus from SMU");
 	else
 		adev->pm.bus_locked = false;
-	mutex_unlock(&adev->pm.smu_i2c_mutex);
+	mutex_unlock(&smu_i2c->mutex);
 }
 
 static const struct i2c_lock_operations smu_v11_0_i2c_i2c_lock_ops = {
@@ -706,19 +722,26 @@ static const struct i2c_adapter_quirks smu_v11_0_i2c_control_quirks = {
 	.flags = I2C_AQ_NO_ZERO_LEN,
 };
 
-int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
+int smu_v11_0_i2c_control_init(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[0];
+	struct i2c_adapter *control = &smu_i2c->adapter;
 	int res;
 
-	mutex_init(&adev->pm.smu_i2c_mutex);
+	smu_i2c->adev = adev;
+	smu_i2c->port = 0;
+	mutex_init(&smu_i2c->mutex);
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &smu_v11_0_i2c_algo;
-	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	snprintf(control->name, sizeof(control->name), "AMDGPU SMU 0");
 	control->lock_ops = &smu_v11_0_i2c_i2c_lock_ops;
 	control->quirks = &smu_v11_0_i2c_control_quirks;
+	i2c_set_adapdata(control, smu_i2c);
+
+	adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
+	adev->pm.fru_eeprom_i2c_bus = NULL;
 
 	res = i2c_add_adapter(control);
 	if (res)
@@ -727,9 +750,12 @@ int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 	return res;
 }
 
-void smu_v11_0_i2c_control_fini(struct i2c_adapter *control)
+void smu_v11_0_i2c_control_fini(struct amdgpu_device *adev)
 {
+	struct i2c_adapter *control = adev->pm.ras_eeprom_i2c_bus;
+
 	i2c_del_adapter(control);
+	adev->pm.ras_eeprom_i2c_bus = NULL;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h
index 44467c05f6421d..96ad14288a0c34 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.h
@@ -26,9 +26,9 @@
 
 #include <linux/types.h>
 
-struct i2c_adapter;
+struct amdgpu_device;
 
-int smu_v11_0_i2c_control_init(struct i2c_adapter *control);
-void smu_v11_0_i2c_control_fini(struct i2c_adapter *control);
+int smu_v11_0_i2c_control_init(struct amdgpu_device *adev);
+void smu_v11_0_i2c_control_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ba857ca75392c0..2766b88ecf961f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -284,6 +284,15 @@ enum ip_power_state {
 /* Used to mask smu debug modes */
 #define SMU_DEBUG_HALT_ON_ERROR		0x1
 
+#define MAX_SMU_I2C_BUSES       2
+
+struct amdgpu_smu_i2c_bus {
+	struct i2c_adapter adapter;
+	struct amdgpu_device *adev;
+	int port;
+	struct mutex mutex;
+};
+
 struct amdgpu_pm {
 	struct mutex		mutex;
 	u32                     current_sclk;
@@ -316,8 +325,9 @@ struct amdgpu_pm {
 	uint32_t pp_feature;
 
 	/* Used for I2C access to various EEPROMs on relevant ASICs */
-	struct i2c_adapter smu_i2c;
-	struct mutex		smu_i2c_mutex;
+	struct amdgpu_smu_i2c_bus smu_i2c[MAX_SMU_I2C_BUSES];
+	struct i2c_adapter     *ras_eeprom_i2c_bus;
+	struct i2c_adapter     *fru_eeprom_i2c_bus;
 	struct list_head	pm_attr_list;
 
 	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
index 9ad26c285ecd6d..a5c95b18067297 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
@@ -520,7 +520,7 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
 	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].version = 0x01;
 	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size = sizeof(DpmActivityMonitorCoeffInt_t);
 
-	ret = smu_v11_0_i2c_control_init(&adev->pm.smu_i2c);
+	ret = smu_v11_0_i2c_control_init(adev);
 	if (ret)
 		goto err4;
 
@@ -558,7 +558,7 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
 			(struct vega20_smumgr *)(hwmgr->smu_backend);
 	struct amdgpu_device *adev = hwmgr->adev;
 
-	smu_v11_0_i2c_control_fini(&adev->pm.smu_i2c);
+	smu_v11_0_i2c_control_fini(adev);
 
 	if (priv) {
 		amdgpu_bo_free_kernel(&priv->smu_tables.entry[TABLE_PPTABLE].handle,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 264eb09ccfd512..9861d70a5dada1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -886,7 +886,7 @@ static int smu_smc_table_sw_init(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_i2c_init(smu, &smu->adev->pm.smu_i2c);
+	ret = smu_i2c_init(smu);
 	if (ret)
 		return ret;
 
@@ -897,7 +897,7 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
 {
 	int ret;
 
-	smu_i2c_fini(smu, &smu->adev->pm.smu_i2c);
+	smu_i2c_fini(smu);
 
 	smu_free_dummy_read_table(smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 18f24db7d20241..4c585241ef66a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -816,12 +816,12 @@ struct pptable_funcs {
 	 * other devices. The i2c's EEPROM also stores bad page tables on boards
 	 * with ECC.
 	 */
-	int (*i2c_init)(struct smu_context *smu, struct i2c_adapter *control);
+	int (*i2c_init)(struct smu_context *smu);
 
 	/**
 	 * @i2c_fini: Tear down i2c.
 	 */
-	void (*i2c_fini)(struct smu_context *smu, struct i2c_adapter *control);
+	void (*i2c_fini)(struct smu_context *smu);
 
 	/**
 	 * @get_unique_id: Get the GPU's unique id. Used for asset tracking.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 2c78d04d561141..0cf385e8b4e9d5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -25,6 +25,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_dpm.h"
 #include "amdgpu_smu.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
@@ -45,6 +46,7 @@
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
 #include "smu_cmn.h"
+#include "amdgpu_dpm.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -56,8 +58,6 @@
 #undef pr_info
 #undef pr_debug
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
-
 #define ARCTURUS_FEA_MAP(smu_feature, arcturus_feature) \
 	[smu_feature] = {1, (arcturus_feature)}
 
@@ -2062,7 +2062,8 @@ static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
 static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 			     struct i2c_msg *msg, int num_msgs)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(i2c_adap);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *table = &smu_table->driver_table;
@@ -2074,7 +2075,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (!req)
 		return -ENOMEM;
 
-	req->I2CcontrollerPort = 0;
+	req->I2CcontrollerPort = smu_i2c->port;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
 	dir = msg[0].flags & I2C_M_RD;
@@ -2153,28 +2154,60 @@ static const struct i2c_adapter_quirks arcturus_i2c_control_quirks = {
 	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
-static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
+static int arcturus_i2c_control_init(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	int res;
+	struct amdgpu_device *adev = smu->adev;
+	int res, i;
+
+	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		smu_i2c->adev = adev;
+		smu_i2c->port = i;
+		mutex_init(&smu_i2c->mutex);
+		control->owner = THIS_MODULE;
+		control->class = I2C_CLASS_HWMON;
+		control->dev.parent = &adev->pdev->dev;
+		control->algo = &arcturus_i2c_algo;
+		control->quirks = &arcturus_i2c_control_quirks;
+		snprintf(control->name, sizeof(control->name), "AMDGPU SMU %d", i);
+		i2c_set_adapdata(control, smu_i2c);
+
+		res = i2c_add_adapter(control);
+		if (res) {
+			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			goto Out_err;
+		}
+	}
 
-	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_HWMON;
-	control->dev.parent = &adev->pdev->dev;
-	control->algo = &arcturus_i2c_algo;
-	control->quirks = &arcturus_i2c_control_quirks;
-	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
+	adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[1].adapter;
 
-	res = i2c_add_adapter(control);
-	if (res)
-		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+	return 0;
+Out_err:
+	for ( ; i >= 0; i--) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
 
+		i2c_del_adapter(control);
+	}
 	return res;
 }
 
-static void arcturus_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
+static void arcturus_i2c_control_fini(struct smu_context *smu)
 {
-	i2c_del_adapter(control);
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		i2c_del_adapter(control);
+	}
+	adev->pm.ras_eeprom_i2c_bus = NULL;
+	adev->pm.fru_eeprom_i2c_bus = NULL;
 }
 
 static void arcturus_get_unique_id(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 84834c24a7e9c5..16a5d4d3598166 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 #include <linux/i2c.h>
 #include "amdgpu.h"
+#include "amdgpu_dpm.h"
 #include "amdgpu_smu.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
@@ -57,8 +58,6 @@
 #undef pr_info
 #undef pr_debug
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
-
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
@@ -2746,7 +2745,8 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
 static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 			   struct i2c_msg *msg, int num_msgs)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(i2c_adap);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *table = &smu_table->driver_table;
@@ -2758,7 +2758,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (!req)
 		return -ENOMEM;
 
-	req->I2CcontrollerPort = 0;
+	req->I2CcontrollerPort = smu_i2c->port;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
 	dir = msg[0].flags & I2C_M_RD;
@@ -2836,28 +2836,60 @@ static const struct i2c_adapter_quirks navi10_i2c_control_quirks = {
 	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
-static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
+static int navi10_i2c_control_init(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	int res;
+	struct amdgpu_device *adev = smu->adev;
+	int res, i;
+
+	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		smu_i2c->adev = adev;
+		smu_i2c->port = i;
+		mutex_init(&smu_i2c->mutex);
+		control->owner = THIS_MODULE;
+		control->class = I2C_CLASS_HWMON;
+		control->dev.parent = &adev->pdev->dev;
+		control->algo = &navi10_i2c_algo;
+		snprintf(control->name, sizeof(control->name), "AMDGPU SMU %d", i);
+		control->quirks = &navi10_i2c_control_quirks;
+		i2c_set_adapdata(control, smu_i2c);
+
+		res = i2c_add_adapter(control);
+		if (res) {
+			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			goto Out_err;
+		}
+	}
 
-	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_HWMON;
-	control->dev.parent = &adev->pdev->dev;
-	control->algo = &navi10_i2c_algo;
-	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
-	control->quirks = &navi10_i2c_control_quirks;
+	adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
+	adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[1].adapter;
 
-	res = i2c_add_adapter(control);
-	if (res)
-		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+	return 0;
+Out_err:
+	for ( ; i >= 0; i--) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
 
+		i2c_del_adapter(control);
+	}
 	return res;
 }
 
-static void navi10_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
+static void navi10_i2c_control_fini(struct smu_context *smu)
 {
-	i2c_del_adapter(control);
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		i2c_del_adapter(control);
+	}
+	adev->pm.ras_eeprom_i2c_bus = NULL;
+	adev->pm.fru_eeprom_i2c_bus = NULL;
 }
 
 static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index dcd35c68e59b25..1c71ea97d06f1d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 #include <linux/i2c.h>
 #include "amdgpu.h"
+#include "amdgpu_dpm.h"
 #include "amdgpu_smu.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
@@ -59,8 +60,6 @@
 #undef pr_info
 #undef pr_debug
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
-
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
 	FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT) | \
@@ -3441,7 +3440,8 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 				   struct i2c_msg *msg, int num_msgs)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(i2c_adap);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *table = &smu_table->driver_table;
@@ -3453,7 +3453,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (!req)
 		return -ENOMEM;
 
-	req->I2CcontrollerPort = 1;
+	req->I2CcontrollerPort = smu_i2c->port;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
 	dir = msg[0].flags & I2C_M_RD;
@@ -3531,28 +3531,61 @@ static const struct i2c_adapter_quirks sienna_cichlid_i2c_control_quirks = {
 	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
-static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
+static int sienna_cichlid_i2c_control_init(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-	int res;
-
-	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_HWMON;
-	control->dev.parent = &adev->pdev->dev;
-	control->algo = &sienna_cichlid_i2c_algo;
-	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
-	control->quirks = &sienna_cichlid_i2c_control_quirks;
+	struct amdgpu_device *adev = smu->adev;
+	int res, i;
+
+	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		smu_i2c->adev = adev;
+		smu_i2c->port = i;
+		mutex_init(&smu_i2c->mutex);
+		control->owner = THIS_MODULE;
+		control->class = I2C_CLASS_HWMON;
+		control->dev.parent = &adev->pdev->dev;
+		control->algo = &sienna_cichlid_i2c_algo;
+		snprintf(control->name, sizeof(control->name), "AMDGPU SMU %d", i);
+		control->quirks = &sienna_cichlid_i2c_control_quirks;
+		i2c_set_adapdata(control, smu_i2c);
+
+		res = i2c_add_adapter(control);
+		if (res) {
+			DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+			goto Out_err;
+		}
+	}
+	/* assign the buses used for the FRU EEPROM and RAS EEPROM */
+	/* XXX ideally this would be something in a vbios data table */
+	adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[1].adapter;
+	adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
 
-	res = i2c_add_adapter(control);
-	if (res)
-		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+	return 0;
+Out_err:
+	for ( ; i >= 0; i--) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
 
+		i2c_del_adapter(control);
+	}
 	return res;
 }
 
-static void sienna_cichlid_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
+static void sienna_cichlid_i2c_control_fini(struct smu_context *smu)
 {
-	i2c_del_adapter(control);
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		i2c_del_adapter(control);
+	}
+	adev->pm.ras_eeprom_i2c_bus = NULL;
+	adev->pm.fru_eeprom_i2c_bus = NULL;
 }
 
 static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 8c02adbf446a7a..450049bcedcba6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -25,6 +25,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_dpm.h"
 #include "amdgpu_smu.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
@@ -56,8 +57,6 @@
 #undef pr_info
 #undef pr_debug
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
-
 #define ALDEBARAN_FEA_MAP(smu_feature, aldebaran_feature) \
 	[smu_feature] = {1, (aldebaran_feature)}
 
@@ -1465,7 +1464,8 @@ static bool aldebaran_is_dpm_running(struct smu_context *smu)
 static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msg, int num_msgs)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
+	struct amdgpu_smu_i2c_bus *smu_i2c = i2c_get_adapdata(i2c_adap);
+	struct amdgpu_device *adev = smu_i2c->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *table = &smu_table->driver_table;
@@ -1477,7 +1477,7 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (!req)
 		return -ENOMEM;
 
-	req->I2CcontrollerPort = 0;
+	req->I2CcontrollerPort = smu_i2c->port;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
 	dir = msg[0].flags & I2C_M_RD;
@@ -1555,28 +1555,52 @@ static const struct i2c_adapter_quirks aldebaran_i2c_control_quirks = {
 	.max_comb_2nd_msg_len = MAX_SW_I2C_COMMANDS - 2,
 };
 
-static int aldebaran_i2c_control_init(struct smu_context *smu, struct i2c_adapter *control)
+static int aldebaran_i2c_control_init(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = to_amdgpu_device(control);
+	struct amdgpu_device *adev = smu->adev;
+	struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[0];
+	struct i2c_adapter *control = &smu_i2c->adapter;
 	int res;
 
+	smu_i2c->adev = adev;
+	smu_i2c->port = 0;
+	mutex_init(&smu_i2c->mutex);
 	control->owner = THIS_MODULE;
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &aldebaran_i2c_algo;
-	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
+	snprintf(control->name, sizeof(control->name), "AMDGPU SMU 0");
 	control->quirks = &aldebaran_i2c_control_quirks;
+	i2c_set_adapdata(control, smu_i2c);
 
 	res = i2c_add_adapter(control);
-	if (res)
+	if (res) {
 		DRM_ERROR("Failed to register hw i2c, err: %d\n", res);
+		goto Out_err;
+	}
+
+	adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
+
+	return 0;
+Out_err:
+	i2c_del_adapter(control);
 
 	return res;
 }
 
-static void aldebaran_i2c_control_fini(struct smu_context *smu, struct i2c_adapter *control)
+static void aldebaran_i2c_control_fini(struct smu_context *smu)
 {
-	i2c_del_adapter(control);
+	struct amdgpu_device *adev = smu->adev;
+	int i;
+
+	for (i = 0; i < MAX_SMU_I2C_BUSES; i++) {
+		struct amdgpu_smu_i2c_bus *smu_i2c = &adev->pm.smu_i2c[i];
+		struct i2c_adapter *control = &smu_i2c->adapter;
+
+		i2c_del_adapter(control);
+	}
+	adev->pm.ras_eeprom_i2c_bus = NULL;
+	adev->pm.fru_eeprom_i2c_bus = NULL;
 }
 
 static void aldebaran_get_unique_id(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 59f9cfff3d6151..a290b578919525 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -78,8 +78,8 @@
 #define smu_dump_pptable(smu)						smu_ppt_funcs(dump_pptable, 0, smu)
 #define smu_update_pcie_parameters(smu, pcie_gen_cap, pcie_width_cap)	smu_ppt_funcs(update_pcie_parameters, 0, smu, pcie_gen_cap, pcie_width_cap)
 #define smu_set_power_source(smu, power_src)				smu_ppt_funcs(set_power_source, 0, smu, power_src)
-#define smu_i2c_init(smu, control)					smu_ppt_funcs(i2c_init, 0, smu, control)
-#define smu_i2c_fini(smu, control)					smu_ppt_funcs(i2c_fini, 0, smu, control)
+#define smu_i2c_init(smu)                                               smu_ppt_funcs(i2c_init, 0, smu)
+#define smu_i2c_fini(smu)                                               smu_ppt_funcs(i2c_fini, 0, smu)
 #define smu_get_unique_id(smu)						smu_ppt_funcs(get_unique_id, 0, smu)
 #define smu_log_thermal_throttling(smu)					smu_ppt_funcs(log_thermal_throttling_event, 0, smu)
 #define smu_get_asic_power_limits(smu, current, default, max)		smu_ppt_funcs(get_power_limit, 0, smu, current, default, max)

base-commit: b2fd523e574e8f92515f16cc08aa44101903c3be
-- 
2.34.0

