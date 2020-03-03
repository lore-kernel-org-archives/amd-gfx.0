Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337D4C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0468320870
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 21:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vjFIvfOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0468320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4646E968;
	Tue,  3 Mar 2020 21:54:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFAB6E95F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 21:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtk9RGJtGQRSzQ9J/be5/fltqfVrTKDQ4IMTqR5ShMbYYpcUIrTOnPoDL8MLPezPHEDdeTCbqCJBka846g9Hb3NMBJkS+kUW5w/DJ4Kwm7N3g+rKpXALdqGrtssRSDKDKpBxWM0vi0LRZT8BLgPiScx/gM1ofANwOQyKFqwIHW/3+OSSA6ZbKOi9sytd5mTrRJArbyr1lxauFXQ+rjxejpqBlarbKeX7fDB2hKhKgLZz7XfGQNAKVNVDku80ViLbRRGpsimTYbuIzGlfGcduUwIR1h3Sfm1aOs1FCIyUwhL+IPZ5q2hymsLY2FFtG5Y/5NrJEJ2BZBe3kGygMMzYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pXeskakAZCERczY24sCFSNNNA+u9kKf2SC5pC6aok8=;
 b=kYs5kURjCwS1ISFo2OP0aLgtbgLZOnLekCuQ/5zltwFO4p/cuihrwAWMQ3bRawMwSKc0EM21IXETPmC1kqoVe8b0Jhb60K+zgJiZZjuyV4s495Dw4tI1PJjKckItvZOy+cucnAoyWeKP0yWP3yEg6Dq9JddgwQ0icAp6zY4YTGSXbnCDdyAquw+DT/p4WFr1md4+9YGIwHCXzpvz9t0uBHkvNxhS6+alLBNnVHnSiAIwCxiSa2BpfsozBtVt5qQcLBn7T10fR1nxM4T40cTJmh8/GA59gjb6aMuFoxHDpukq5HrHtNP4/nJAzhNGz+o3J++RW4OJ+QTWSiW0aPKMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pXeskakAZCERczY24sCFSNNNA+u9kKf2SC5pC6aok8=;
 b=vjFIvfOAKKEXxvREz3WQuN+6KRcjl+bFHUypfII3N4M9HsE6JKbpoOVDwJhuQM0esZXn1e7SlfB6+ZnzIGqvbOJatgW0W9TmUqEYjTHEeuTLvztTVd+qg4iuf/BTVE0Izn5Q+xDgEQ0f0IGpf3D/LwG/WenlMEgftlEyhxpVV1g=
Received: from BL0PR02CA0074.namprd02.prod.outlook.com (2603:10b6:208:51::15)
 by CY4PR12MB1336.namprd12.prod.outlook.com (2603:10b6:903:40::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Tue, 3 Mar
 2020 21:54:34 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::a0) by BL0PR02CA0074.outlook.office365.com
 (2603:10b6:208:51::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 21:54:34 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 3 Mar 2020 21:54:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 15:54:33 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 15:54:33 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 3 Mar 2020 15:54:32 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/3] drm/amdgpu: Add support for USBC PD FW download
Date: Tue, 3 Mar 2020 16:54:27 -0500
Message-ID: <1583272467-25895-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583272467-25895-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583272467-25895-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(428003)(199004)(189003)(478600001)(316002)(8936002)(2616005)(6916009)(86362001)(8676002)(81156014)(81166006)(336012)(426003)(44832011)(36756003)(26005)(54906003)(6666004)(356004)(70586007)(5660300002)(7696005)(4326008)(2906002)(186003)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1336; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed73ea6e-fea9-4385-a52b-08d7bfbd75b6
X-MS-TrafficTypeDiagnostic: CY4PR12MB1336:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1336D3C9F8EFAC227D0E8533EAE40@CY4PR12MB1336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKCAaZA+r9zDFQ/dsfXYJJKmZLbQgg8AqCr3r++gtIhWq4IVmnYgNDoN6G8AjiIFw6k3F6nsHFI+MFvuDEAa71iJwobOs3irujWwJrkeGiVMsBmL0YBPRO/7CnFRv2eJpMc/iOkjZ2R3os85UqGCYimW7aqW0QzlmwIPJ6HtDXShGw2z4e4EqMCCRhcas+lA8iZV3E0LNgb5opPA0CHbpYjLYcCYZVd4n3O8lxkcidpO/6X8bZm0TidUXis29N6Bx4SpYqBABISfwb74E67r9GdI+4PnVe8M1x6MUXn/2aiW0q6sTpIJsazxKTpLmfAk/YBFFXYL60DYUniHmRBwvj3iiDgsSgzBrLCTNRmnyD/L4bdQDgR4BUxG7Fwa6TOJ6hjiT82iSxi24AFoZRM+DTNO/qTY+XuLBtRvcRF0VnoVsp0tbe7mXtvxCNY+NFLu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 21:54:34.0413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed73ea6e-fea9-4385-a52b-08d7bfbd75b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1336
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
