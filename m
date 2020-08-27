Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E82C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 01:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6463E2075B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 01:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D5toeEEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6463E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5B46EB19;
	Thu, 27 Aug 2020 01:23:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3DB6EB19
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 01:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhbzan5xorOJK6Iq5toB0hR3NepkYQtrIHEKPS1SmYvwYnq401hlMa5POQt/FMY/ZUMALM5wrjJXvIn+x1JgsEXzkM6VnbiD6j3CMqT2swVI6h0RfPb5SBsWmiqd4cUx3D+D6PUAcWht5So2LInmdn8Aqqz9HIRu1Fu6tayPr6tFFh4ksyOO5vyGR7LP7voP246oBsnmaETyDueBY36KxZTgz5iitPx8Q+zQU4MFBZ95dlAHjhF4JOemD0K0vQkaIt17P0ftDOluKtd0sfZULo7gyhMQSz7jEqbtYH32Rl9US0woX+Jp3erj4skAMB8n+f5Cyy8poMvoh+cMkG7aMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxuYG5JZuVNwgvVOWJQOU+affEN48JoCuSdFAxdYn+s=;
 b=Tapr4mWgP5KleH0ykESuVYHZElEgd9R0VXeRMHw0sqjsVU+MyxxlA43kAi7V6m7NMJ+hoD/EMV2SfLnSqEuehloZOVEPeWu8CKPA7pCTjyjbbhxqDG1f3viROUUZtQXASrpciS6LuAASymnkAEEkqas6/etaGNVwiwViA37VEa++9B8tKQqgQDPo1azqdokfhJeW5gs7gJu3w9/Vx710moS+vS6iUwUpFlDpNDbzsFGHvA/OjlFEm7UZUv66mbqEZEmLNcXc6t1wDojEF25pqlup0EvfMbgJ4Mop9QWr4YgKb/zOP9WtjaQL6PuBsYePJTVUOhujd4QkGr5TwZk53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxuYG5JZuVNwgvVOWJQOU+affEN48JoCuSdFAxdYn+s=;
 b=D5toeEEinDNmctcuwiHGv7+WgxS9GJekA2UOkOG7y1VEEQbmu+fW490UC8jK99UeiMDRYr97GfHEYe6DStvjTY1uU+TIe/DP8+2BKnYIRRlFsedXWDrmh0Ji3GNi7Zr38UzBotuYF48NbkQGQ7NGp18aYq9xyc6sz25SQKru51U=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Thu, 27 Aug 2020 01:23:26 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 01:23:26 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/7] drm/amdgpu: Implement DPC recovery
Thread-Topic: [PATCH 1/7] drm/amdgpu: Implement DPC recovery
Thread-Index: AQHWe7e8E8UIfAvFKkyBN9zKa7WkJalLKOhw
Date: Thu, 27 Aug 2020 01:23:26 +0000
Message-ID: <DM5PR12MB2533C6CCEE16BD4BCECFF5B9ED550@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-2-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598453182-6946-2-git-send-email-andrey.grodzovsky@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-27T01:23:20Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=1d89f94e-3e0b-4755-9ad1-a549cd9e842c;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efbb9a5f-3505-4d9d-81e3-08d84a27cc49
x-ms-traffictypediagnostic: DM6PR12MB4284:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB42845D816ECCED0959AA2BD6ED550@DM6PR12MB4284.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pZDkYsHFTATzQBuPPFAxfoAXYl0YfNsEtLGh0OkUIRnlnbu3nNbVScf9EgwX49l6CUXnR2DNF0YIXkNvA/J8bKb1v1QFnvSrZA4RbPh3M/OxRinJ/+xs5d65248J3qfiAMxKXrIukOFJP+MPbIN6ctQ9zSNB1/GFu4H1QV6yOKRfP08OBJO4crfHrd3Uo9XMNbqHcxyrRMAfamM7SQvQy4c6dcToVlT3aFdDh6aloSM1TaSNCqku2Tna7yDB1LArjSZTyiJ0v0V8rI78UWtl2XcBx2RJRM7f/290LnWw8gIp7xZOdWBGwlGLxrMHSqOVe9uWmPVXaNd6MrlZvC0Me+IlyevL18upUwekaQoHox4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(26005)(5660300002)(9686003)(186003)(86362001)(30864003)(7696005)(2906002)(83380400001)(8936002)(478600001)(966005)(54906003)(8676002)(110136005)(33656002)(52536014)(316002)(64756008)(6506007)(53546011)(4326008)(45080400002)(55016002)(66446008)(76116006)(66476007)(66556008)(71200400001)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: MfhebxGWXEsVe8rOtRBMijhExqFAmzqGr/wOPwHj4dqZc7mLtnWWrHfdR+OFvQBXF/ll2CTFNPCWs/5SHfoHkXbbohv4Xk8/mfvYPWVXAq+EEyJLFwO2St1G4Yu2nZgxecpvXL3L6ZK9iz7J/wm+dgcnVVv1+SdAVpRzh90psZL4YF/xIF02FCzpywHxR+uxW1i7ANMe0xGXxquQUjUDF8Pm8F3Y6jRo6srcSeE9OZg28nhwfHzHBWe3m4uQbGRqZIvf/52eySXFwXbtCNArv7sF6bR59DFY1tq7WfQE9+mVjacV2av6B+u/UTD85BfjnaERzGYAmgZlz931MllYWtoMWkjOPe5KqWYFz2nYEdhq5/u2x/n0rSXCs/rxWhBRiM3X0r9Lf6eF0jdYoLPDzn7+c0MabkdskFBmrbnqRFp/4bLqNNgTH1eA+YQ/58jorxYxO41H5l3u0zPCRpj2BIvbGkmz9vxr1LupHbae+ToujGYDP2T5PMJ70T8jfVvupoac6Cdl8HKvJeB5TRYWk4mnmSaRjGVYdWq6ue8zEdgKuZSLngFrikzFTCzf+eVpauE2nJ2eDiEpeNTsYDCw6GzVyvJtkFZp+l5z65QVxWX2OdCCYKtpYPuaA5ZCzu4XqNs7TFceaF9kuNG6mHE0Qw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbb9a5f-3505-4d9d-81e3-08d84a27cc49
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 01:23:26.3005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJHj83/34DQymsaiooY6h7gWbiu+g+kRNuVJIYqsSFDR/oqjXIBk3XSUlbRVrbFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, Andrey,
     I found that the sequences of amdgpu_pci_slot_reset is mostly similar to amdgpu_do_asic_reset. Could help us refactor them to reuse more codes? 

Best Regards
Dennis Li
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrey Grodzovsky
Sent: Wednesday, August 26, 2020 10:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: Implement DPC recovery

Add DPC handlers with basic recovery functionality.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   9 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 181 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   9 +-
 3 files changed, 196 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 49ea9fa..3399242 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -49,6 +49,8 @@
 #include <linux/rbtree.h>
 #include <linux/hashtable.h>
 #include <linux/dma-fence.h>
+#include <linux/pci.h>
+#include <linux/aer.h>
 
 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
@@ -1263,6 +1265,13 @@ static inline int amdgpu_dm_display_resume(struct amdgpu_device *adev) { return  void amdgpu_register_gpu_instance(struct amdgpu_device *adev);  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev);
 
+pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev,
+					   pci_channel_state_t state);
+pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev); 
+pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev); void 
+amdgpu_pci_resume(struct pci_dev *pdev);
+
+
 #include "amdgpu_object.h"
 
 /* used by df_v3_6.c and amdgpu_pmu.c */ diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5a948ed..84f8d14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -350,7 +350,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
  *
  * Returns the 8 bit value from the offset specified.
  */
-uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
+uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
+
 	if (offset < adev->rmmio_size)
 		return (readb(adev->rmmio + offset));
 	BUG();
@@ -371,7 +373,9 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset) {
  *
  * Writes the value specified to the offset specified.
  */
-void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value) {
+void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, 
+uint8_t value) {
+
 	if (offset < adev->rmmio_size)
 		writeb(value, adev->rmmio + offset);
 	else
@@ -380,6 +384,7 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 
 void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)  {
+
 	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size)
@@ -407,6 +412,7 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,  void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags)
 {
+
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
@@ -461,6 +467,7 @@ u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
  */
 void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)  {
+
 	if ((reg * 4) < adev->rio_mem_size)
 		iowrite32(v, adev->rio_mem + (reg * 4));
 	else {
@@ -480,6 +487,7 @@ void amdgpu_io_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
  */
 u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)  {
+
 	if (index < adev->doorbell.num_doorbells) {
 		return readl(adev->doorbell.ptr + index);
 	} else {
@@ -500,6 +508,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)  {
+
 	if (index < adev->doorbell.num_doorbells) {
 		writel(v, adev->doorbell.ptr + index);
 	} else {
@@ -518,6 +527,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
  */
 u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)  {
+
 	if (index < adev->doorbell.num_doorbells) {
 		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
 	} else {
@@ -538,6 +548,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
  */
 void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)  {
+
 	if (index < adev->doorbell.num_doorbells) {
 		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
 	} else {
@@ -2989,6 +3000,7 @@ static const struct attribute *amdgpu_dev_attributes[] = {
 	NULL
 };
 
+
 /**
  * amdgpu_device_init - initialize the driver
  *
@@ -3207,6 +3219,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		}
 	}
 
+	pci_enable_pcie_error_reporting(adev->ddev.pdev);
+
+
 	/* Post card if necessary */
 	if (amdgpu_device_need_post(adev)) {
 		if (!adev->bios) {
@@ -3359,6 +3374,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (r)
 		dev_err(adev->dev, "amdgpu_pmu_init failed\n");
 
+	if (pci_save_state(pdev))
+		DRM_ERROR("Failed to save PCI state!!\n");
+
 	return 0;
 
 failed:
@@ -4701,3 +4719,162 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 
 	return 0;
 }
+
+/**
+ * amdgpu_pci_error_detected - Called when a PCI error is detected.
+ * @pdev: PCI device struct
+ * @state: PCI channel state
+ *
+ * Description: Called when a PCI error is detected.
+ *
+ * Return: PCI_ERS_RESULT_NEED_RESET or PCI_ERS_RESULT_DISCONNECT.
+ */
+pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, 
+pci_channel_state_t state) {
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
+
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen: {
+		/* Fatal error, prepare for slot reset */
+
+		amdgpu_device_lock_adev(adev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+	case pci_channel_io_perm_failure:
+		/* Permanent error, prepare for device removal */
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+/**
+ * amdgpu_pci_mmio_enabled - Enable MMIO and dump debug registers
+ * @pdev: pointer to PCI device
+ */
+pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev) {
+
+	DRM_INFO("PCI error: mmio enabled callback!!\n");
+
+	/* TODO - dump whatever for debugging purposes */
+
+	/* This called only if amdgpu_pci_error_detected returns
+	 * PCI_ERS_RESULT_CAN_RECOVER. Read/write to the device still
+	 * works, no need to reset slot.
+	 */
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+/**
+ * amdgpu_pci_slot_reset - Called when PCI slot has been reset.
+ * @pdev: PCI device struct
+ *
+ * Description: This routine is called by the pci error recovery
+ * code after the PCI slot has been reset, just before we
+ * should resume normal operations.
+ */
+pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev) {
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r;
+	bool vram_lost;
+
+	DRM_INFO("PCI error: slot reset callback!!\n");
+
+	pci_restore_state(pdev);
+
+	r = amdgpu_device_ip_suspend(adev);
+	if (r)
+		goto out;
+
+
+	/* post card */
+	r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
+	if (r)
+		goto out;
+
+	r = amdgpu_device_ip_resume_phase1(adev);
+	if (r)
+		goto out;
+
+	vram_lost = amdgpu_device_check_vram_lost(adev);
+	if (vram_lost) {
+		DRM_INFO("VRAM is lost due to GPU reset!\n");
+		amdgpu_inc_vram_lost(adev);
+	}
+
+	r = amdgpu_gtt_mgr_recover(
+		&adev->mman.bdev.man[TTM_PL_TT]);
+	if (r)
+		goto out;
+
+	r = amdgpu_device_fw_loading(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_device_ip_resume_phase2(adev);
+	if (r)
+		goto out;
+
+	if (vram_lost)
+		amdgpu_device_fill_reset_magic(adev);
+
+	/*
+	 * Add this ASIC as tracked as reset was already
+	 * complete successfully.
+	 */
+	amdgpu_register_gpu_instance(adev);
+
+	r = amdgpu_device_ip_late_init(adev);
+	if (r)
+		goto out;
+
+	amdgpu_fbdev_set_suspend(adev, 0);
+
+	/* must succeed. */
+	amdgpu_ras_resume(adev);
+
+
+	amdgpu_irq_gpu_reset_resume_helper(adev);
+	r = amdgpu_ib_ring_tests(adev);
+	if (r)
+		goto out;
+
+	r = amdgpu_device_recover_vram(adev);
+
+out:
+
+	if (!r)
+		DRM_INFO("PCIe error recovery succeeded\n");
+	else {
+		DRM_ERROR("PCIe error recovery failed, err:%d", r);
+		amdgpu_device_unlock_adev(adev);
+	}
+
+	return r ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED; }
+
+/**
+ * amdgpu_pci_resume() - resume normal ops after PCI reset
+ * @pdev: pointer to PCI device
+ *
+ * Called when the error recovery driver tells us that its
+ * OK to resume normal operation. Use completion to allow
+ * halted scsi ops to resume.
+ */
+void amdgpu_pci_resume(struct pci_dev *pdev) {
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	amdgpu_device_unlock_adev(adev);
+
+	DRM_INFO("PCI error: resume callback!!\n"); }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d984c6a..4bbcc70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -31,7 +31,6 @@
 #include <drm/drm_pciids.h>
 #include <linux/console.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
 #include <drm/drm_probe_helper.h>
@@ -1534,6 +1533,13 @@ static struct drm_driver kms_driver = {
 	.patchlevel = KMS_DRIVER_PATCHLEVEL,
 };
 
+static struct pci_error_handlers amdgpu_pci_err_handler = {
+	.error_detected	= amdgpu_pci_error_detected,
+	.mmio_enabled	= amdgpu_pci_mmio_enabled,
+	.slot_reset	= amdgpu_pci_slot_reset,
+	.resume		= amdgpu_pci_resume,
+};
+
 static struct pci_driver amdgpu_kms_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pciidlist,
@@ -1541,6 +1547,7 @@ static struct pci_driver amdgpu_kms_pci_driver = {
 	.remove = amdgpu_pci_remove,
 	.shutdown = amdgpu_pci_shutdown,
 	.driver.pm = &amdgpu_pm_ops,
+	.err_handler = &amdgpu_pci_err_handler,
 };
 
 static int __init amdgpu_init(void)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7Cfbaac227eff74bcab03108d849cedd81%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637340500116686286&amp;sdata=lYjIk50kyGIHG7UaAzx%2FswghLD8gc2DdCXUmTNj4EkU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
