Return-Path: <SRS0=+uvl=47=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3CC10DCE
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Mar 2020 03:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6316E2074B
	for <amd-gfx@archiver.kernel.org>; Sat, 14 Mar 2020 03:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I3hPbVrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6316E2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2C66EC7D;
	Sat, 14 Mar 2020 03:05:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77E2A6E0D8
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Mar 2020 03:05:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoI0DJP4G4L+7EPOjb2Q3/v1S0ELFeCzvjBz/qMDNk097aklxgq6ienDj6k2RW2idS9uOXY4hvkJTrptF6im/5HZF+t2B4UFdEwFfe+A+km0S6wBSyeXP1HB8KZjD1sCnxrEFiurCx8/fZYpu6457FkOYLcSWAHkU14r9Z0xLoaxgLeiQlI6jGUcdXYg0WGBa4+Duq1m3nGwvKhF9lXyPA+QOQItq7mgsLmXHdsJKnqLbv/V2AO0/HT+96X22Hfist3AndKXOUX71odou+OwJLQ2Hih3+ueoIw1aC9qEXJZP5o3U4zOOG49Go74MMy0VQ208yrtUBTqfRcOSys/4HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+Rgy5Df4xiGl3mM7y/lu+a5wT09sMuVQJMESvzshqo=;
 b=YPPoK2FbnmolTus+pAfU6vFxS785yZ2ofNzBLUPK1MOJ2K7Iwo+Gh5rE94zXy9mM6cQTxF7vSGWgykQ7AsimahzgWCwRErDU7sJh3OlggHBSx6iNv9fwBzo2QLzaJJ+Tq5EWlgu0e+0pWGs9bUz9QnenAPtK4u6vrVH8APeJ2qJgLigHyK8gpwmrzk/ELi7cuftqSCeQI7NZQrx3zUusRdbU01iYS/Jh2Z7Zb/ArDFJmCHVuWfcbFASwecSLqSlHL838Xbdwlpn9ulnJKPu6/1sqk/DHQLM0HixQOTNombpBw7G/3vvEmah30URRrnCHN3zYd1MbWSv8vlFosrJTDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+Rgy5Df4xiGl3mM7y/lu+a5wT09sMuVQJMESvzshqo=;
 b=I3hPbVrDehiX4Ba/nBbuDKClDDWYJ9KqJkf5JgYlTgh1hgZb0bbnjQQQuZoe5JXzKaI1+5Mps1DpReAt2/TD+m9NNbAQ6V0+HdDkn8Oz82s3cepnXO20uWQOowgVuRC82s9NFWxi/wHuQiqfb27nptpWB0jcsQrpa1By+5rroSM=
Received: from DM5PR18CA0072.namprd18.prod.outlook.com (2603:10b6:3:22::34) by
 BY5PR12MB3891.namprd12.prod.outlook.com (2603:10b6:a03:1a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Sat, 14 Mar
 2020 03:05:40 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::a3) by DM5PR18CA0072.outlook.office365.com
 (2603:10b6:3:22::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend
 Transport; Sat, 14 Mar 2020 03:05:40 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Sat, 14 Mar 2020 03:05:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Mar
 2020 22:05:39 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Mar
 2020 22:05:39 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 13 Mar 2020 22:05:38 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device
Date: Fri, 13 Mar 2020 23:05:37 -0400
Message-ID: <1584155137-9628-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(428003)(199004)(46966005)(478600001)(36756003)(356004)(316002)(70586007)(70206006)(54906003)(6916009)(47076004)(26005)(5660300002)(4326008)(426003)(86362001)(8936002)(2906002)(81166006)(30864003)(44832011)(336012)(81156014)(186003)(7696005)(2616005)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3891; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0485a70-96fe-4210-c553-08d7c7c493a0
X-MS-TrafficTypeDiagnostic: BY5PR12MB3891:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3891881B0B47FABE8052CEE3EAFB0@BY5PR12MB3891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 034215E98F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dm81tz7tsmRyfLdaEJpr5ADs2Ko/7CW8ZVIvIBhABsTTQ4jzg+TzQB1JFeeNXJ/uBwJDcHQL4h6ELqxKYWnUlbpdA1b0nXV3iEfFjoEr0PoLya0UpAEPP0Ly+z0URDLIY9aw6vUVUQOXRUWhuykxA9PSnzX3pDFulpFowDBGQRQSAfIps2NJ8PjkAuoEash9kRk93M2xpKZtfg6ZJkoK0tb4DqrIdj/tVqGuAnGB43v/KsUTmY6Zb4KsQVAF5PahkozTAeDle7Y1GuHGPI7IqD+I0pe7DdNWYQCEsIHCPixyr8K9P73MR2GNcnRj1v2d77iScQkZDLSAXdzpVx4RzjXwYaqUZ7UaAml+kyLnY8k5LoJ2zTuXis6X5SZwOCail4WQfwjG9zHAptE7eu4IBujvjxGEvhAiVRJ0XKuB2L3taygEWXocaaevIiGA2i3b7JxzMf+fKWg85JkVGERq6r+62PuX0zE2/YmsJGS0haCdjMez/7S202stmgALV+I1dDvlx5wpVVj07mNciDR2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2020 03:05:39.9679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0485a70-96fe-4210-c553-08d7c7c493a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3891
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Kent.Russell@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Puts the i2c adapter in common place for sharing by RAS
and upcoming data read from FRU EEPROM feature.

v2:
Move i2c adapter to amdgpu_pm and rename it.

v3: Move i2c adapter init to ASIC specific code and get rid
of the switch case in amdgpu_device

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     | 48 ++++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |  2 -
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         | 14 ++++---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 10 +++++
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  4 +-
 .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   | 11 +++++
 7 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index 1685794..936d85a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -448,6 +448,8 @@ struct amdgpu_pm {
 	/* powerplay feature */
 	uint32_t pp_feature;
 
+	/* Used for I2C access to various EEPROMs on relevant ASICs */
+	struct i2c_adapter smu_i2c;
 };
 
 #define R600_SSTU_DFLT                               0
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index ed15b1f..c009609 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -25,7 +25,6 @@
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
 #include <linux/bits.h>
-#include "smu_v11_0_i2c.h"
 #include "atom.h"
 
 #define EEPROM_I2C_TARGET_ADDR_VEGA20    	0xA0
@@ -124,6 +123,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 				 unsigned char *buff)
 {
 	int ret = 0;
+	struct amdgpu_device *adev = to_amdgpu_device(control);
 	struct i2c_msg msg = {
 			.addr	= 0,
 			.flags	= 0,
@@ -137,7 +137,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
 
 	msg.addr = control->i2c_address;
 
-	ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
+	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
 	if (ret < 1)
 		DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
 
@@ -251,33 +251,18 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 			.buf	= buff,
 	};
 
+	/* Verify i2c adapter is initialized */
+	if (!adev->pm.smu_i2c.algo)
+		return -ENOENT;
+
 	if (!__get_eeprom_i2c_addr(adev, &control->i2c_address))
 		return -EINVAL;
 
 	mutex_init(&control->tbl_mutex);
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-		ret = smu_v11_0_i2c_eeprom_control_init(&control->eeprom_accessor);
-		break;
-
-	case CHIP_ARCTURUS:
-		ret = smu_i2c_eeprom_init(&adev->smu, &control->eeprom_accessor);
-		break;
-
-	default:
-		return 0;
-	}
-
-	if (ret) {
-		DRM_ERROR("Failed to init I2C controller, ret:%d", ret);
-		return ret;
-	}
-
 	msg.addr = control->i2c_address;
-
 	/* Read/Create table header from EEPROM address 0 */
-	ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
+	ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
 	if (ret < 1) {
 		DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
 		return ret;
@@ -303,23 +288,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	return ret == 1 ? 0 : -EIO;
 }
 
-void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control)
-{
-	struct amdgpu_device *adev = to_amdgpu_device(control);
-
-	switch (adev->asic_type) {
-	case CHIP_VEGA20:
-		smu_v11_0_i2c_eeprom_control_fini(&control->eeprom_accessor);
-		break;
-	case CHIP_ARCTURUS:
-		smu_i2c_eeprom_fini(&adev->smu, &control->eeprom_accessor);
-		break;
-
-	default:
-		return;
-	}
-}
-
 static void __encode_table_record_to_buff(struct amdgpu_ras_eeprom_control *control,
 					  struct eeprom_table_record *record,
 					  unsigned char *buff)
@@ -476,7 +444,7 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
 		control->next_addr += EEPROM_TABLE_RECORD_SIZE;
 	}
 
-	ret = i2c_transfer(&control->eeprom_accessor, msgs, num);
+	ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
 	if (ret < 1) {
 		DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index ca78f81..7e8647a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -44,7 +44,6 @@ struct amdgpu_ras_eeprom_table_header {
 
 struct amdgpu_ras_eeprom_control {
 	struct amdgpu_ras_eeprom_table_header tbl_hdr;
-	struct i2c_adapter eeprom_accessor;
 	uint32_t next_addr;
 	unsigned int num_recs;
 	struct mutex tbl_mutex;
@@ -79,7 +78,6 @@ struct eeprom_table_record {
 }__attribute__((__packed__));
 
 int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
-void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control);
 int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index c902f26..9bffbab 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -46,8 +46,7 @@
 #define I2C_NO_STOP	1
 #define I2C_RESTART	2
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
-#define to_eeprom_control(x) container_of(x, struct amdgpu_ras_eeprom_control, eeprom_accessor)
+#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
 static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
 {
@@ -592,7 +591,8 @@ static uint32_t smu_v11_0_i2c_eeprom_write_data(struct i2c_adapter *control,
 
 static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
-	struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
+	struct amdgpu_device *adev = to_amdgpu_device(i2c);
+	struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
 
 	if (!smu_v11_0_i2c_bus_lock(i2c)) {
 		DRM_ERROR("Failed to lock the bus from SMU");
@@ -610,7 +610,8 @@ static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
 
 static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
 {
-	struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
+	struct amdgpu_device *adev = to_amdgpu_device(i2c);
+	struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
 
 	if (!smu_v11_0_i2c_bus_unlock(i2c)) {
 		DRM_ERROR("Failed to unlock the bus from SMU");
@@ -630,7 +631,8 @@ static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
 			      struct i2c_msg *msgs, int num)
 {
 	int i, ret;
-	struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c_adap);
+	struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
+	struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
 
 	if (!control->bus_locked) {
 		DRM_ERROR("I2C bus unlocked, stopping transaction!");
@@ -679,7 +681,7 @@ int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control)
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &smu_v11_0_i2c_eeprom_i2c_algo;
-	snprintf(control->name, sizeof(control->name), "RAS EEPROM");
+	snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
 	control->lock_ops = &smu_v11_0_i2c_i2c_lock_ops;
 
 	res = i2c_add_adapter(control);
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 8de8436..0273c63 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -932,6 +932,13 @@ static int smu_sw_init(void *handle)
 		return ret;
 	}
 
+	if (adev->smu.ppt_funcs->i2c_eeprom_init) {
+		ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
+
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -941,6 +948,9 @@ static int smu_sw_fini(void *handle)
 	struct smu_context *smu = &adev->smu;
 	int ret;
 
+	if (adev->smu.ppt_funcs->i2c_eeprom_fini)
+		smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
+
 	kfree(smu->irq_source);
 	smu->irq_source = NULL;
 
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 61596e8..c6d3bef 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -41,7 +41,7 @@
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
+#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
 
 #define CTF_OFFSET_EDGE			5
 #define CTF_OFFSET_HOTSPOT		5
@@ -2190,7 +2190,7 @@ static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
 	control->class = I2C_CLASS_SPD;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &arcturus_i2c_eeprom_i2c_algo;
-	snprintf(control->name, sizeof(control->name), "RAS EEPROM");
+	snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
 
 	res = i2c_add_adapter(control);
 	if (res)
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
index 49e5ef3..16aa171 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
@@ -33,6 +33,8 @@
 #include "smu7_smumgr.h"
 #include "vega20_hwmgr.h"
 
+#include "smu_v11_0_i2c.h"
+
 /* MP Apertures */
 #define MP0_Public			0x03800000
 #define MP0_SRAM			0x03900000
@@ -406,6 +408,7 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
 	struct vega20_smumgr *priv;
 	unsigned long tools_size = 0x19000;
 	int ret = 0;
+	struct amdgpu_device *adev = hwmgr->adev;
 
 	struct cgs_firmware_info info = {0};
 
@@ -505,6 +508,10 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
 	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].version = 0x01;
 	priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size = sizeof(DpmActivityMonitorCoeffInt_t);
 
+	ret = smu_v11_0_i2c_eeprom_control_init(&adev->pm.smu_i2c);
+	if (ret)
+		goto err4;
+
 	return 0;
 
 err4:
@@ -537,6 +544,9 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
 {
 	struct vega20_smumgr *priv =
 			(struct vega20_smumgr *)(hwmgr->smu_backend);
+	struct amdgpu_device *adev = hwmgr->adev;
+
+	smu_v11_0_i2c_eeprom_control_fini(&adev->pm.smu_i2c);
 
 	if (priv) {
 		amdgpu_bo_free_kernel(&priv->smu_tables.entry[TABLE_PPTABLE].handle,
@@ -560,6 +570,7 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
 		kfree(hwmgr->smu_backend);
 		hwmgr->smu_backend = NULL;
 	}
+
 	return 0;
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
