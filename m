Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4265C3F2D1
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DFA208C3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 22:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EcsLDHPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DFA208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E068F6E96A;
	Tue,  3 Mar 2020 22:02:18 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700059.outbound.protection.outlook.com [40.107.70.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5A1E6E964
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 22:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G12VggMr67JukWKmvFOqY9gTDLHh1QPl2p1/a5F7H50/e4iUVuaEEt8kuLJAWVrBX0eL0y8RRkU1DC+XCjOkG3sa8G5M9SFZJwOdOGAbunGiIqZUUygFcqOH4c67lda7jQ44WiDgafQX7ufT4Hoo8FNKdZKA/fe+gFdqOHzzMLoQDmz4SyvuqeH6SO4taE9TFAoyFhZQxmO6I7OOxyIe5XzAzCZmBYU5azEm+rHq6oihHzpnyllonlNyYYIReSVcIRLoQOUzyihLSDG3ff/SLn3+KXl8KTz8Z55kZKQH2jVoPT21UBB1iV9ubdFne9DiyrB0WPg/uCq2mQ6ukXXevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pXeskakAZCERczY24sCFSNNNA+u9kKf2SC5pC6aok8=;
 b=Z3zVxZY4CUbxw/NWOcUgGjgxT3fZLxq242LcV5A2DUNmx5bQunW7ikv5Vk5aHqbrtBxp/eY5K/036VjpbCCjQbQTM1PTvpY310pHjfeNpCYEqKvxZHF9H05CkA1KvQWPeb2gQJwdksA1HtbieK35s4Ce9cFsQi02Zijf0nIXDSU6H0UshIp73auy263WunSsiam/tTWwGNC/Oi4BlRMYjJ6HgnAgJcdVT35rN2QF1NySwh9bVdnsFAEKVQ+sA6ILkTeqYk3HJdODwBvqU4nznjfk6eYhtQlIosLcNwLWR49A04RUgp/EzyTULzMjscGE8nL18Mwode2W22V5dg6CJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pXeskakAZCERczY24sCFSNNNA+u9kKf2SC5pC6aok8=;
 b=EcsLDHPfu8XnGbEgMHlBtlErbLqvat1XkVpH4ncv5b8L86JRzIa8PlWM6hR2huo7ApMCO1X1e5SBy2I1+2H690/Ur8pdor1zpZu70nJLu7ZRnFIH8sNF6unef0sj733MabloBV5n7uiTSnfzif2p7h3OmuSnpTv7e/ZGJn+jjDE=
Received: from DM5PR07CA0060.namprd07.prod.outlook.com (2603:10b6:4:ad::25) by
 BYAPR12MB3336.namprd12.prod.outlook.com (2603:10b6:a03:d7::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Tue, 3 Mar 2020 22:02:15 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::ca) by DM5PR07CA0060.outlook.office365.com
 (2603:10b6:4:ad::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Tue, 3 Mar 2020 22:02:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Tue, 3 Mar 2020 22:02:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 16:02:14 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 16:02:14 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 3 Mar 2020 16:02:13 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 3/3] drm/amdgpu: Add support for USBC PD FW download
Date: Tue, 3 Mar 2020 17:02:09 -0500
Message-ID: <1583272929-1038-4-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1583272929-1038-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(396003)(136003)(376002)(428003)(189003)(199004)(8936002)(7696005)(26005)(44832011)(426003)(81166006)(6666004)(478600001)(2616005)(316002)(81156014)(356004)(4326008)(336012)(8676002)(2906002)(70586007)(70206006)(5660300002)(54906003)(186003)(6916009)(36756003)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3336; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86c3dc92-99b6-468f-e9ae-08d7bfbe887a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3336:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3336BEFE7F87CB3CB12489CAEAE40@BYAPR12MB3336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JM1r8hAxQuV7SLzt7nApjR1sYz5sgNXzFhP7dja7ZaLAS4LCQ1qC1O6JotMpcPw0LsrrHOSUi3bVkhN7pXyt73B2XO6oyuwUR72/Snv3iGNJeGQ17Rn9wxdyZygOoOi6YKQjyPNJl4pQUqzmHFKI6vaRcou9aom7xi6O1OXoob8F3V496bMp/LQ7l8FW6i/cqi/7ItxyNXSm1M8yOX1RvOxiqPOdSjoloRukBbeuWekPjJBDVMbcGahAZl97KTyUKtyofANUihU7fmGoPp4Qp6LYCVAdXxdqnhfbidbFPtlq4y4zg/L6MBadSCJeBOspSFSzvZHFHvxhItA63sP/hqAiMHciQid2bEeZFhdZYk5adPSwjOMqmTvdAH+k+2gv8IHcRBKwfJ6/pgwwbPBAzE6BECHnm1xIATt5wtneYbxPt/ygK0E2+rrv3HW0oE+S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 22:02:14.9833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c3dc92-99b6-468f-e9ae-08d7bfbe887a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3336
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
