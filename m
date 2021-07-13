Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E6C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 15:30:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7C261175
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 15:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7C261175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1276B6E0DC;
	Tue, 13 Jul 2021 15:30:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831726E0E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 15:30:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBEdl05KcoJMH4QS4dodpIj6fn4tepbMKkcOYi7dr75X3r4TwUlRBXMaqddAvLP2kzuj//TTYQAHILb7bZZejWW5SnaYpx9m2pueTw/Lcc6rdYYxR5Fc4pLrNvIafU4TbX7g9TCYQLxonF/52eJsnV9fab74+i670G2NC/iuj3bH/FTkoSn54tOby+Sc+yl5Rqcvuf7WtLSeAYeavAeQEwYjqth61W2SC2b4fapPpjzE4sifDNYjpN2Xql1T9sshamVujSBy4dL9A7i+CIPFUEd65JN5SOPYYfK2TfOfzl5ZOjLBK6+eHcY0io2iLvad/pknIcXIIWkwD2hnUgcSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1cOtjDRqXmM1KxQiJQpWqD9/LjRQoNs/aHGK5l/M7U=;
 b=A0GQdu0l0sjDD+/COp1ZIXi9zEe3S0ULIHY4Fi4+OfSGOP3UL6Tvh1kXgjkUKAh3uOrMYxMhvnRIZzJgVhsVYBryyT4e1M6ZP2wSw+d2GZzYpjGbn4LLt4joyEpvX02m6IynhYrqlw3GQBkAzQmPZnREbTuQ5L0jAexnsDUzIqaBqhpYmT4s7NrCXkVONCRPkV/lMhvFGyF0lBY8PCdexroqMClDtk5F42RCEOKfDkJamX87k8YNkqJr43vMADHQG2XPhJzkemOBPJxPh6cRZO8ku7wTDzybQtfVgrwzDI6GfRzI7Eq5PTaouA/6/NqMqw7Fo2nU5fIVTTTrl0921w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1cOtjDRqXmM1KxQiJQpWqD9/LjRQoNs/aHGK5l/M7U=;
 b=saDsw0HVGeuuaq/6XYfpw1nwlwsY2Z/Wo1E6YEfi6xBFdANzPqvg98u7CkdVujYYY9wipsxpsBQSKVvpJHWmjvKq1YhWOkRp/0DlFJkERHkn7NssA5BvxIXsMrNSoZeEoPVC37l2j3a9i+2JhjvRiceR7c0YWRJ+vcCWZTQnp2g=
Received: from DM3PR12CA0075.namprd12.prod.outlook.com (2603:10b6:0:57::19) by
 DM5PR12MB1580.namprd12.prod.outlook.com (2603:10b6:4:10::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Tue, 13 Jul 2021 15:30:15 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::d1) by DM3PR12CA0075.outlook.office365.com
 (2603:10b6:0:57::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 15:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 15:30:15 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 13 Jul 2021 10:30:12 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Switch to VRAM buffer for USBC PD FW.
Date: Tue, 13 Jul 2021 11:29:54 -0400
Message-ID: <20210713152956.280078-1-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41d401d3-627d-4a85-3f6f-08d946131d42
X-MS-TrafficTypeDiagnostic: DM5PR12MB1580:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1580747B5D535E9829F32399EA149@DM5PR12MB1580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ZbPdhImHIuauA0YZSV314AsWXwtP2LcTfbb1JvDGmNyvje2ooKXvKDp5uaY5WVIueCujEi+welAcgRYXApnaygXe/81IqQ/PhPOhlCe+V4z+i8W+sZlXDp5ppfeJ3RBbCIl6ltZpiJqE7hVUiX85p4+sfLbKzZSdTZ+nH8F2VVHeLRBBvvhT9pLaMQkm33lmKdw7Az7w8+Y/AFeI6cpwH258e8hDF4Moq0MDDEmgKi+bDIOG2jXfVk2jb6bYF7P04d1I/E8tBmdNE/q3H9FgsbImmNBRqozmKs1h+Z1hylsYYbbcHdA5n3OX0s/EW6lF5QQZhkq4YyxDQp3O2ullv7res2tsn1BweTSE8Mj92UN+3K+WcNOSw6qvpUsGlppofAl2zIHOLdBuQBiGKkotEdyTFWALVNJReDdlF2KpurXBfnLWM2cxgoL+Ed5l24wUjKR0O89/LUg+O6nHLtmpc3smz4sa3tNCKO5wSMMuuG7LwylLgAxWKuzokSJqgynxU4hWZmGSAh/fl/2C7Z3VvdrgQK9Pk5fGd9Q1F64d9caE+5MQjj8J0fbDyVu8iSH3EhE+LJRIICYj9q4Zxbe42MVYUzkdB5thBHnKVHRRQaOLSYPWRORUDzsNzmFhHbRzH2MS4rY3EjoZCcLlE+8bsJ+CWGTSdfL1/EMCjqjDV3NqVKN7Ic7ANhEhNCaVh4Ws8Ooaz6XA/kkj7T73PrpxjaMGFRSxikJdx9NSjOG2TU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(7696005)(26005)(70586007)(2906002)(70206006)(16526019)(316002)(5660300002)(1076003)(44832011)(47076005)(336012)(356005)(4326008)(83380400001)(8676002)(186003)(2616005)(6666004)(8936002)(426003)(81166007)(86362001)(478600001)(82740400003)(6916009)(54906003)(82310400003)(36860700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 15:30:15.7670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d401d3-627d-4a85-3f6f-08d946131d42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1580
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
 Mugunthanvenkatachari.Nagarajan@amd.com, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

System memory-based implementation for updating the
USBCPD is deprecated for switching
to LFB based implementation for all the ASICs.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 33 ++++++++++---------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d9ddb2cfaba1..dfb481a0780f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -24,7 +24,6 @@
  */
 
 #include <linux/firmware.h>
-#include <linux/dma-mapping.h>
 
 #include "amdgpu.h"
 #include "amdgpu_psp.h"
@@ -3273,11 +3272,12 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	void *cpu_addr;
-	dma_addr_t dma_addr;
 	int ret;
 	char fw_name[100];
 	const struct firmware *usbc_pd_fw;
+	struct amdgpu_bo *fw_buf_bo = NULL;
+	uint64_t fw_pri_mc_addr;
+	void *fw_pri_cpu_addr;
 
 	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
 		DRM_INFO("PSP block is not ready yet.");
@@ -3289,31 +3289,24 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	if (ret)
 		goto fail;
 
-	/* We need contiguous physical mem to place the FW  for psp to access */
-	cpu_addr = dma_alloc_coherent(adev->dev, usbc_pd_fw->size, &dma_addr, GFP_KERNEL);
-
-	ret = dma_mapping_error(adev->dev, dma_addr);
+	/* LFB address which is aligned to 1MB boundary per PSP request */
+	ret = amdgpu_bo_create_kernel(adev, usbc_pd_fw->size, 0x100000,
+						AMDGPU_GEM_DOMAIN_VRAM,
+						&fw_buf_bo,
+						&fw_pri_mc_addr,
+						&fw_pri_cpu_addr);
 	if (ret)
 		goto rel_buf;
 
-	memcpy_toio(cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
-
-	/*
-	 * x86 specific workaround.
-	 * Without it the buffer is invisible in PSP.
-	 *
-	 * TODO Remove once PSP starts snooping CPU cache
-	 */
-#ifdef CONFIG_X86
-	clflush_cache_range(cpu_addr, (usbc_pd_fw->size & ~(L1_CACHE_BYTES - 1)));
-#endif
+	memcpy_toio(fw_pri_cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
 
 	mutex_lock(&adev->psp.mutex);
-	ret = psp_load_usbc_pd_fw(&adev->psp, dma_addr);
+	ret = psp_load_usbc_pd_fw(&adev->psp, fw_pri_mc_addr);
 	mutex_unlock(&adev->psp.mutex);
 
+	amdgpu_bo_free_kernel(&fw_buf_bo, &fw_pri_mc_addr, &fw_pri_cpu_addr);
+
 rel_buf:
-	dma_free_coherent(adev->dev, usbc_pd_fw->size, cpu_addr, dma_addr);
 	release_firmware(usbc_pd_fw);
 
 fail:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
