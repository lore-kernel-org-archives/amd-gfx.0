Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178F8C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:23:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E132521739
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 16:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nNkdWJcw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E132521739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2A26E073;
	Wed,  4 Mar 2020 16:23:50 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7086E073
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 16:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWQ2Du423/540s/kFZJel841nlwh3Cc0NtrY1M8X7mJzJ4W/kevCZuJQLZ3p5L9QAZU+PjCQ+A59G5bbMIn0ErKcWoQNXx7fY6+SdPp9homc9260+PiW5ex/OzHk4NGkJMhDxi8X2j6BmYWmd/KwTUYAPhlpAo9OYLgvJfA7so2vQ7502uFtyU2MesILcffyu58I33xXg/sGrJY31ZGSqn7OV7olMJUbnufwTdYRzT1C37dySNUSt0Wxm7WLm8V7BcZygBgLixvVY1UTFn9vsCjNs3P/pia5WEoz60QC/wp/9UbsZoR/AEureD+iTmeJtmqxvVy/f2PA5qS6PgrbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pXeskakAZCERczY24sCFSNNNA+u9kKf2SC5pC6aok8=;
 b=E0P79kJE2RFJnNyQ8H2LEeJGfDh7fdSyAFRRO3eh+8SwCBIe8216kYs2OAq5gmt+03j5p1jz4Im2jBmtvaqnK6fAZHzqC07MLwgAH14yFC76KA6tXSzAIwuAhkNCfyqpyOnrlIAOfsmJ3JjwBqK1VTrNiUrR54srnCSbNb3TAyF7vvoMlSL8PdOXwh/5gO0TtgJQSkaODDyG8dAonu5y45202flctjTtfx8gwVBF4Su67CQnWE++CgT6knWSATovUk3VxqBoFbcs01rs0UBj4DPK3zUFXDdbKtKCwMjgVyNrNGgI0PfstA+cCnTFTcNOFUR4Vjl/xPrOJhkQC/bp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pXeskakAZCERczY24sCFSNNNA+u9kKf2SC5pC6aok8=;
 b=nNkdWJcwoHVbtOhHRIKcxPy6GprE2OF//J78wmIabaCCP7os77IPt1XFVs3tAjtbSYf/rAdMkl1hQbfNZ6LOKPKYTD/IUtcqYDgELzAn6slXip/riamXk7RJPFYg9OsLKbVeCKYcs4QTHe6syX4pCOLvOB1vcrWEQ4A0dMVOoag=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by DM6PR12MB3099.namprd12.prod.outlook.com (2603:10b6:5:38::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Wed, 4 Mar
 2020 16:23:47 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::10) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Wed, 4 Mar 2020 16:23:47 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 16:23:47 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 10:23:46 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 10:23:45 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 3/3] drm/amdgpu: Add support for USBC PD FW download
Date: Wed, 4 Mar 2020 11:23:41 -0500
Message-ID: <1583339021-12298-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583339021-12298-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583339021-12298-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(428003)(199004)(189003)(26005)(4326008)(44832011)(36756003)(7696005)(54906003)(6916009)(316002)(2616005)(426003)(186003)(70586007)(81166006)(6666004)(356004)(5660300002)(8676002)(8936002)(70206006)(336012)(2906002)(478600001)(81156014)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3099; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed26344c-dd16-4ead-7a35-08d7c0586a8e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3099:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3099D5FA2774BD640BDF823FEAE50@DM6PR12MB3099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWNGtJU9QWs7EFstT63RjzAPhK1Gd9BRbv1txckECj+Kh7AvxY6X3Lwl72NFH809nXT6TO9sQfMW9iZhAooIMidyoJWKgnHmDCdsXWwspUNarlZVfIc61ZjYlz0WGbF+8oAQx/SUjevQNx2/H/0JqPm1Hy0NHVddkb+q3pGcMh1J6WQ6nhoh0BXDCHaM1DWdtd+k54tCt/aHwdFOYJRzI4S3pGx3xax6Jsow7t4HYQqNFHgLYParknsEE6dqUhMJ1NThGEvyapnlrzl1X/x3IFfCxsB/AZ59+LXUkkcV2tVHL68g72AOEfG61E0WUWqS16QQItspOKV4z93MWHmCW+9XSxkQI2oaxQ2IiRhVmdhIphQDrxzzBw/IJRVHlPV1xrPBkzzdI+daILxbumDAm2kHdDG1tRAA3TksoBKPz0iKjp53zn0gZIyvM5dvkgHG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 16:23:47.3162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed26344c-dd16-4ead-7a35-08d7c0586a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3099
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com, luben.tuikov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starts USBC PD FW download and reads back the latest FW version.

v2:
Move sysfs file creation to late init
Add locking around PSP calls to avoid concurrent access to PSP's C2P registers

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 110 +++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d33f741..cff0fd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/firmware.h>
+#include <linux/dma-mapping.h>
 
 #include "amdgpu.h"
 #include "amdgpu_psp.h"
@@ -38,6 +39,9 @@
 
 static void psp_set_funcs(struct amdgpu_device *adev);
 
+static int psp_sysfs_init(struct amdgpu_device *adev);
+static void psp_sysfs_fini(struct amdgpu_device *adev);
+
 /*
  * Due to DF Cstate management centralized to PMFW, the firmware
  * loading sequence will be updated as below:
@@ -113,6 +117,16 @@ static int psp_early_init(void *handle)
 	return 0;
 }
 
+static int psp_late_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (adev->asic_type == CHIP_NAVI10)
+		return psp_sysfs_init(adev);
+
+	return 0;
+}
+
 static int psp_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -152,6 +166,10 @@ static int psp_sw_fini(void *handle)
 		release_firmware(adev->psp.ta_fw);
 		adev->psp.ta_fw = NULL;
 	}
+
+	if (adev->asic_type == CHIP_NAVI10)
+		psp_sysfs_fini(adev);
+
 	return 0;
 }
 
@@ -1816,10 +1834,85 @@ static int psp_set_powergating_state(void *handle,
 	return 0;
 }
 
+static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = ddev->dev_private;
+	uint32_t fw_ver;
+	int ret;
+
+	mutex_lock(&adev->psp.mutex);
+	ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
+	mutex_unlock(&adev->psp.mutex);
+
+	if (ret) {
+		DRM_ERROR("Failed to read USBC PD FW, err = %d", ret);
+		return ret;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%x\n", fw_ver);
+}
+
+static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
+						       struct device_attribute *attr,
+						       const char *buf,
+						       size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = ddev->dev_private;
+	void *cpu_addr;
+	dma_addr_t dma_addr;
+	int ret;
+	char fw_name[100];
+	const struct firmware *usbc_pd_fw;
+
+
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
+	ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
+	if (ret)
+		goto fail;
+
+	/* We need contiguous physical mem to place the FW  for psp to access */
+	cpu_addr = dma_alloc_coherent(adev->dev, usbc_pd_fw->size, &dma_addr, GFP_KERNEL);
+
+	ret = dma_mapping_error(adev->dev, dma_addr);
+	if (ret)
+		goto rel_buf;
+
+	memcpy_toio(cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
+
+	/*TODO Remove once PSP starts snooping CPU cache */
+	clflush_cache_range(cpu_addr, (usbc_pd_fw->size & ~(L1_CACHE_BYTES - 1)));
+
+	mutex_lock(&adev->psp.mutex);
+	ret = psp_load_usbc_pd_fw(&adev->psp, dma_addr);
+	mutex_unlock(&adev->psp.mutex);
+
+rel_buf:
+	dma_free_coherent(adev->dev, usbc_pd_fw->size, cpu_addr, dma_addr);
+	release_firmware(usbc_pd_fw);
+
+fail:
+	if (ret) {
+		DRM_ERROR("Failed to load USBC PD FW, err = %d", ret);
+		return ret;
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
+		   psp_usbc_pd_fw_sysfs_read,
+		   psp_usbc_pd_fw_sysfs_write);
+
+
+
 const struct amd_ip_funcs psp_ip_funcs = {
 	.name = "psp",
 	.early_init = psp_early_init,
-	.late_init = NULL,
+	.late_init = psp_late_init,
 	.sw_init = psp_sw_init,
 	.sw_fini = psp_sw_fini,
 	.hw_init = psp_hw_init,
@@ -1834,6 +1927,21 @@ const struct amd_ip_funcs psp_ip_funcs = {
 	.set_powergating_state = psp_set_powergating_state,
 };
 
+static int psp_sysfs_init(struct amdgpu_device *adev)
+{
+	int ret = device_create_file(adev->dev, &dev_attr_usbc_pd_fw);
+
+	if (ret)
+		DRM_ERROR("Failed to create USBC PD FW control file!");
+
+	return ret;
+}
+
+static void psp_sysfs_fini(struct amdgpu_device *adev)
+{
+	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
+}
+
 static const struct amdgpu_psp_funcs psp_funcs = {
 	.check_fw_loading_status = psp_check_fw_loading_status,
 };
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
