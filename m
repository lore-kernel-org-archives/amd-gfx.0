Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9213EC3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 19:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6595B2173E
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 19:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zxtQpWNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6595B2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32BF46E7EA;
	Mon,  2 Mar 2020 19:24:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C70C89D9B
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 19:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9DSJt5mtjZ88CK+tuPnTBAkLAdwYcVjOfc4X/xClLrMmjDm2v+52gS7ETwNtBuoA4K/o82VwZLw0uaxEK95MogdMfcaAYhf/g1di9aXsmagiYMuAadT6DC4ikxxoYe11SqK5fNiCvcW0DVDuvMs+X2M3vqVM/EM022QfkrucD3gS98n9C+jEYUuIYTdS6tUdh3LV8bJ3I4DF/ZSPC8ucZ5wJOWEFvcSzTGpNIqz4XpUicUMPGaFo9IMclt1AzIJ4f6bMTLCFG3iZEMaDiyBNAvl2s68NtRwJupBaShkhBPJdJX9DjLntoxtfhD8JUGc1CfkRRFp0MLKm4ynaEqDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g+OBzx7ElBmyhTztj3PSTGFphDiE+kiBkD9ynTIHLc=;
 b=TgR5cF+wWDtV+W2zwca5+IrJg86RCGB5rD1rLRKkTdsvrndh6dzzIQPcBnkvlSbQet3Hr143Gss8csG4Ue6eH3UxdquaGDo3R1cFGXPFiv5FASoUzao5JiM0O5jXPhgxxTiGEiUt9gRX7MCjg5rUnOzMcthBsmohjs0LhbY5+nGYHWhIwTnr0dzoxdi71NnQKv5PtAkwlT+wQCQNQc1Mc3+KcEa0xyFS++BGHZ0OMnnbvA5op+Pe8chSvT3+FK1zFH+5nFEKbcD0OCgUvcjsLC2GJb1c/MB7r+Em1nvNwIFnnwtyRV12UjZsjswUVxWViNQAT7bBOHpPMJXvSFcUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+g+OBzx7ElBmyhTztj3PSTGFphDiE+kiBkD9ynTIHLc=;
 b=zxtQpWNCLeIw4oF94YM81WQha3duBXCVItXpQRl0AF4ao8zrI26zeRJIlIV9eTgKjLWPZZVKyCJPHUoqgyVC/nDxt7KNfUN9+Pmhtii+REUZfQy4x+si/9EuvZJsghLtEPcebmqCU/g6h1xJpbC2z/7ENev88WZCfMqNauvCnQM=
Received: from MW2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:907:1::27)
 by CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 19:24:32 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::9d) by MW2PR16CA0050.outlook.office365.com
 (2603:10b6:907:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Mon, 2 Mar 2020 19:24:31 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 19:24:31 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 13:24:29 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 13:24:29 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: Add support for USBC PD FW download
Date: Mon, 2 Mar 2020 14:24:21 -0500
Message-ID: <1583177061-3115-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(428003)(199004)(189003)(426003)(7696005)(336012)(36756003)(186003)(2906002)(6666004)(26005)(44832011)(2616005)(356004)(478600001)(316002)(54906003)(5660300002)(81156014)(81166006)(8936002)(4326008)(70586007)(6916009)(70206006)(86362001)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4102; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07e73ae7-1b2c-454d-57d0-08d7bedf554c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4102:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41029519D5D2ECF3A23EAB78EAE70@CH2PR12MB4102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uksShBKCvZfu4EMCj6X4C25MZrkglHQ2GMJIM1B46iX7EI+gHHpCumyqccxtAxEuTm8HgTpc2MY5YJyKEB/FjcpA75A841MP0HY3OiP92Qpsa5nL38VV8tb+f5UQa0OAxt9w/pdDCDaWREJm8gLpBoXuzBJoRkUyF5Xg+gjdp/coF7iEsrayJUeV8kwAY8fnjwo2LN/7frsUQ7QzE3wmt1YPqSRYF0eY/zRKsUNw1Zl9HiDETNi1eEK4nQt5RB4dSCSfHob/Tdhj13D536UiJE0NMsVgFLYIE/+zAofVMYMHEvtaHIPlWDnbIR63oAmILcgAl0pE7bCo8OvVDVjVLa+xKPw6FK+rSgyeDVjL4unMP4mfOKsJwUC25jv9Xs1QOfQ1orp/mFCtjxQzXXLkwIUzJZfK/HiEWrbNtE405oa/ophp9uE8cQ96c/19FYrw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 19:24:31.2666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e73ae7-1b2c-454d-57d0-08d7bedf554c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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
Cc: Alexander.Deucher@amd.com, Slava.Abramov@amd.com,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starts USBC PD FW download and reads back the latest FW version.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 94 +++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d33f741..76630b9 100644
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
@@ -94,6 +98,7 @@ static int psp_early_init(void *handle)
 		psp->autoload_supported = false;
 		break;
 	case CHIP_NAVI10:
+		psp_sysfs_init(adev);
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 		psp_v11_0_set_psp_funcs(psp);
@@ -152,6 +157,10 @@ static int psp_sw_fini(void *handle)
 		release_firmware(adev->psp.ta_fw);
 		adev->psp.ta_fw = NULL;
 	}
+
+	if (adev->asic_type == CHIP_NAVI10)
+		psp_sysfs_fini(adev);
+
 	return 0;
 }
 
@@ -1816,6 +1825,76 @@ static int psp_set_powergating_state(void *handle,
 	return 0;
 }
 
+static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
+						struct device_attribute *attr,
+								char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = ddev->dev_private;
+	uint32_t fw_ver;
+	int ret;
+
+	ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
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
+	int ret = 0;
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
+	ret = psp_load_usbc_pd_fw(&adev->psp, dma_addr);
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
@@ -1834,6 +1913,21 @@ const struct amd_ip_funcs psp_ip_funcs = {
 	.set_powergating_state = psp_set_powergating_state,
 };
 
+static int psp_sysfs_init(struct amdgpu_device *adev)
+{
+	int ret = device_create_file(adev->dev, &dev_attr_usbc_pd_fw);
+
+	 if (ret)
+		 DRM_ERROR("Failed to create USBC PD FW control file!");
+
+	 return ret;
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
