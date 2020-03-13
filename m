Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E4CC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD76E206FA
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 14:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eyjB9D4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD76E206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA366EBE4;
	Fri, 13 Mar 2020 14:57:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616636EBE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 14:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJA2rMcWy7yqCXHUTejc+aVgr7+hS5OEQ5JysdoSxjLNFAhnHABTtkLNvpInIce7ill7BWO8ZhXYqjin03p9IKIEpN3VOCM+GXNqu/4rBjcsaUQcxYSPy7U/fnf1H7QD/a18Y5hv/GLfHl9AV8I3zLV9NHkhOVB4y1Haqxvdptvj1JMxcOGTRgrYdPVpw6CCggogI4I6ZG7s+6mbiQ0xzArwKmokcpVqh4Ah0fW+N9hFrEt6hZvRjuGSQPFt1RVAvVbV93M11pbxB2EDEQ08/HbvAldSUDdOaGrzU7ljSsbrO+bcZya8I5NPfHllTmpSadW5kS681bq0vk7YE6FIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxuq5WbZzNZPxYv3/C/5riSv+MHcZUy/7x6bpTBFmE0=;
 b=E0Nb3qsvbvHXYamjTL+81yEzQ7VWg2e4XN0mZ/qW2cy6ZYARgygiA4ClOPjdNeYlS/cQjlNzqmexDZkbM9y9lrtR7UP8N1BMY4BFShGV6cdIGDvnIOxxC4bwpunPRnqzx0eN8bc5BVcYBsGa/Kc6tZqWXwhr4kUYTvuC6ULnyUCi5TPxe03eEFmHqu3E2K1W4TeeHh0StStz5OjIwp05REAEQ5bkJlZldEKaVCW4OBwT6pu22plkqr5xjdRapeMp6ly/wDwV2xpW8QwqprMSGKaeC0tHcZGWLy+2UEZzUluhE/whsROgSt33EAmElpL9nDi/IjW8X4BdYYmeFGj7iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxuq5WbZzNZPxYv3/C/5riSv+MHcZUy/7x6bpTBFmE0=;
 b=eyjB9D4EVHjr7fQ+QDAYbeAEINhGqOdqwmLjsLah192EfIXFHABBkpapephai6gGV1WZSm+Fjorg8DbHV6xjfRNUJNJXDBV2gqCl2M3zqDtsNlNYVjbaC/Jr9DzN9xi5QMN1qV4NMaonBVrd1M372KF4ybGjhf68mWjClN7TKjo=
Received: from BL0PR02CA0109.namprd02.prod.outlook.com (2603:10b6:208:35::14)
 by BYAPR12MB2616.namprd12.prod.outlook.com (2603:10b6:a03:66::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 14:57:12 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:35:cafe::af) by BL0PR02CA0109.outlook.office365.com
 (2603:10b6:208:35::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend
 Transport; Fri, 13 Mar 2020 14:57:12 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Fri, 13 Mar 2020 14:57:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Mar
 2020 09:57:12 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Mar
 2020 09:57:11 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Fri, 13 Mar 2020 09:57:11 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device
Date: Fri, 13 Mar 2020 10:57:09 -0400
Message-ID: <1584111429-16165-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(396003)(346002)(39860400002)(428003)(199004)(46966005)(5660300002)(186003)(426003)(478600001)(8936002)(44832011)(26005)(356004)(2906002)(81166006)(36756003)(2616005)(316002)(47076004)(8676002)(336012)(81156014)(70586007)(70206006)(6916009)(54906003)(7696005)(86362001)(4326008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2616; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c61899-15ec-4ea8-ca1a-08d7c75ecfe4
X-MS-TrafficTypeDiagnostic: BYAPR12MB2616:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26168903F865775053DBD084EAFA0@BYAPR12MB2616.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 034119E4F6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OF8QkBkC99puFT2N7HpwLC+FiE7J0ydDzT4SqFrPlGwvF/edQfhHao5SViqpscvCdUfcSw04OKV/AX5yY2fhMQ0diNaNhO0mkvkYAb3E7gdTZO8a+yD0VUWwDPHmYXsfymDsxst6c7YcRSA8leZP7hzFVOtSWsNafit06Yle1U4CvxEeJuUdFnmAstglIXkN9Bd2pxewdTuSODLFCuRyyHYt45Q2sROOtY5gr2W6WnyH6o+NoFMyN0zuYyv+MO6wvLW/0QDuBLJRKN6Zr6LZjTg7soUs0RxgtgRWNrPOV2w6HBVYhvQulgl1IR2AUCAEHcjqNcSgFBuPlRfmIEjC7hiNv/Hh2pV4dSFyQ6sXGRkDHa6gsncuCzjEKcQ1/+O2GbRdf1BRzMbDFGkGQ8En982Xed/8vlBz0zXbnAgPLc9L3KlOaHZKvyY7B+8axl0yfxhmmfIanubWyuRBNc39QJXjVLIWKf0eewllwquFQEhbDHUTivhoNAuTfVqx+DjTxTMpq748sSAV5Oks5i2tXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 14:57:12.4515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c61899-15ec-4ea8-ca1a-08d7c75ecfe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2616
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
and upcoming nvmlDeviceGetSerial from FRU EEPROM feature.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 35 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 48 +++++---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  2 --
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c     | 14 ++++----
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   |  2 +-
 6 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c00831f..f807237 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -979,6 +979,9 @@ struct amdgpu_device {
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
+
+	/* Used for I2C access to various EEPROMs on relevant ASICs */
+	struct i2c_adapter eeprom_accessor;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a35c899..80fcc16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -68,6 +68,8 @@
 #include <linux/suspend.h>
 #include <drm/task_barrier.h>
 
+#include "smu_v11_0_i2c.h"
+
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
@@ -1848,6 +1850,33 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
 	return r;
 }
 
+static int amdgpu_eeprom_init(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		return smu_v11_0_i2c_eeprom_control_init(&adev->eeprom_accessor);
+	case CHIP_ARCTURUS:
+		return smu_i2c_eeprom_init(&adev->smu, &adev->eeprom_accessor);
+	default:
+		return 0;
+	}
+}
+
+void amdgpu_eeprom_fini(struct amdgpu_device *adev)
+{
+
+	switch (adev->asic_type) {
+	case CHIP_VEGA20:
+		smu_v11_0_i2c_eeprom_control_fini(&adev->eeprom_accessor);
+		return;
+	case CHIP_ARCTURUS:
+		smu_i2c_eeprom_fini(&adev->smu, &adev->eeprom_accessor);
+		return;
+	default:
+		return;
+	}
+}
+
 /**
  * amdgpu_device_ip_init - run init for hardware IPs
  *
@@ -1936,6 +1965,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	r = amdgpu_eeprom_init(adev);
+	if (r)
+		goto init_failed;
+
 	/*
 	 * retired pages will be loaded from eeprom and reserved here,
 	 * it should be called after amdgpu_device_ip_hw_init_phase2  since
@@ -2196,6 +2229,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
 
 	amdgpu_ras_pre_fini(adev);
 
+	amdgpu_eeprom_fini(adev);
+
 	if (adev->gmc.xgmi.num_physical_nodes > 1)
 		amdgpu_xgmi_remove_device(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index ed15b1f..14f6571 100644
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
+	ret = i2c_transfer(&adev->eeprom_accessor, &msg, 1);
 	if (ret < 1)
 		DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
 
@@ -251,33 +251,18 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 			.buf	= buff,
 	};
 
+	/* Verify i2c adapter is initialized */
+	if (!adev->eeprom_accessor.algo)
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
+	ret = i2c_transfer(&adev->eeprom_accessor, &msg, 1);
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
+	ret = i2c_transfer(&adev->eeprom_accessor, msgs, num);
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
index c902f26..1df57ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -46,8 +46,7 @@
 #define I2C_NO_STOP	1
 #define I2C_RESTART	2
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
-#define to_eeprom_control(x) container_of(x, struct amdgpu_ras_eeprom_control, eeprom_accessor)
+#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, eeprom_accessor))
 
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
diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 61596e8..94edb29 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -41,7 +41,7 @@
 #include <linux/pci.h>
 #include "amdgpu_ras.h"
 
-#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
+#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, eeprom_accessor))
 
 #define CTF_OFFSET_EDGE			5
 #define CTF_OFFSET_HOTSPOT		5
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
