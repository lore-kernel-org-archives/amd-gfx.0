Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DACC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FB4206C3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CU70mCwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FB4206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77ABB6E0FB;
	Tue, 11 Aug 2020 06:49:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBBD6E0FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 06:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRuTi6RLFJupZmlfo6ZpqenFoixvwArm/eFZq8H/CQagbcbc6ajtvTxmJDo9RoMJFzAKbgSsBCjiEC0c4sQabGKoLFwOXkSloVtX8qjHo8V958gadusFRUo0MHMd/Y4HxFIvV/S680uSEtcwE9rHlIzA9aEnBpETIlDTlzHG/n4XA4aUUiwWGzH5F7W6+8kd1zGweO01yQPGU9a2haVHZ/27N0iprjjC6SVo1O00lsCkPOfFFABr9Y9+zbf/v5JU66ROv53kaRWetRD+UVIYW6A2LGR20tt2FeHWKUf47SR0N8w4U+ogPKCzf3RvJ1sImDZKV37/GV29+ZR9pjiA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyWbGhy0RxuncfCcucz6DF6nka/owfR/gxBWjHeF3U0=;
 b=L1Xydn9QrM+hd7M6OxVhWu76zfxQyGDbXmlcHSio5HX9cnPxrgbPzbJF4fp0+Vbk0ma8uRqmC/hnTzrSMIySaxRRxJyRPmp5Ew185cc96/Hr/PWRo5/zCWbCkKKBpdzxH0ZowRcNkQRj4sgt+IFheccWgzP6kGSpBzj453GmiE6b3FXOy4BzLYwaj1wv3WgoOFfIIol5J8MmwbpJMniSmcKWFKRH6oWwuk93lY17wJMycpLuOOp03dJphKYozPrHAMPCMwd2iTMG/SanvmulEacshslus9rzMFgzTJiACMUxkyxVaqKOQgabyQ+MAXlT0qB3ZzW4MZH1SH9GvGQjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyWbGhy0RxuncfCcucz6DF6nka/owfR/gxBWjHeF3U0=;
 b=CU70mCwyq82BD/G9PzlteM42n9wuS+Qz2924uzqbOM8tE/gPJX/wY5jxxdK5OhGHCvEbtCDX+RsJbTMzeAoOGbxCZTSTb5gS8GwJANuqv9M1z2mYcDgId1i5JEkabTTouFpz1HH2eiRUjg+Cl3LrJCk9R97P/syAVbNWIv0aJE8=
Received: from MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Tue, 11 Aug
 2020 06:49:43 +0000
Received: from MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::acd3:39ec:eda9:89d7]) by MN2PR12MB4078.namprd12.prod.outlook.com
 ([fe80::acd3:39ec:eda9:89d7%5]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 06:49:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test
Thread-Topic: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test
Thread-Index: AQHWb6jneajA3gIAJk+k4KlKGIyvFKkyd7YA
Date: Tue, 11 Aug 2020 06:49:43 +0000
Message-ID: <MN2PR12MB4078C825D386ABE930560628FC450@MN2PR12MB4078.namprd12.prod.outlook.com>
References: <20200811063007.7785-1-Wenhui.Sheng@amd.com>
 <20200811063007.7785-3-Wenhui.Sheng@amd.com>
In-Reply-To: <20200811063007.7785-3-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-11T06:49:39Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=775cf5f4-556c-48b7-9b9e-0000edef24d6;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-11T06:49:36Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f1d05172-8450-4322-b5a8-0000fa101e14
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-11T06:49:40Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6dc2a380-9990-4141-add8-0000f36c01e8
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88823298-7a0f-4e31-4f14-08d83dc2bab7
x-ms-traffictypediagnostic: MN2PR12MB4175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4175E7A693C1D3C2942DEBE6FC450@MN2PR12MB4175.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3OFLYW+X2hAHkSNmcB+vR3AOMqjnG5/CRCc07sE05hx6tPOzDCLfgZdQo/rd6tfyJRQbKqLcf+WqSN4sBAFvGOodwI4CfNdHeIUVFHocc5gN7lIgj0aiCak+BYNxctB/O338fH20Jyj52OcnvIdnL1t500nHWxzWKGB3hQjvvOlbcYaInwlj3wDeMVoPlSR0+Z1jFwZCjICTbdMayiWzAsB2TIALdEFB6sb9p54oWTN9oVJUosVxAt+J7pNqgGKiPjbseNymSKR/wWr3pDR94u50dP3mQa08uFS9hiOvsLac77WcXX6URpamDdlRboqGhSZ+AgxaY92LlVWb0mDOIUA+z1saleUcJd6Mey2KiG/2mNcWjjvVRC2Ocs9G98hG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4078.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(33656002)(2906002)(9686003)(478600001)(66946007)(5660300002)(83380400001)(53546011)(6506007)(71200400001)(76116006)(26005)(66556008)(66446008)(66476007)(64756008)(7696005)(8676002)(186003)(52536014)(316002)(54906003)(4326008)(55016002)(110136005)(8936002)(86362001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: nR89lHnX+l/HidDne8egkJJDOl2XpCBRr9L97v8QoF9WaghxbvV2QP5sfPN4KDsM4UzPDXXYye+rX3AXKzdbggI92SwCdgauNTzikydtJBfk8oQ7x4ERmCX95AptX5RXw38uofS3nyYXHU5zc5wNBEsM49fTQ/gdEs0blLBl3rugk1VCnqTg5phtkFGbzXiM7Gqem9LSbbVGxvpfE5PQ0dLkal67OQ/TRY8OZRktizeuBTzvqc0vguJBu2AE0pZ14bOwuFAwDjs2RWtTtiBXgW50RmEhJq2jJ3HFr1Ksu8Ex+IdY0ML3zLT/hHsfIqw6HcHX6TRhN70Uq4R4p/Znomjrv/bCqZ7yX0XB/BhITYQCxCmSj3ZcPYBjwdSEVDgA/HX8XTpLn+8y2+mBdPoeZAKScVLtA0YkXI4TRkT+R5S/uvS02c8hYQKDRFprYRiUhWhICong7G//DKliN5QaD68sdPoYnLinhfg6DU+zTFz+k6FBGDbcmckR3JMqDn8jOXEaEwABqWozYv3Xje4PQ0dn3RkaMqVj7bMtdHpygkzGJk2DFkrd22PF5eVti1uswh+Zg9f566V1z8VtPU60emmxeUqKLA/XSC7Q7Ueqx5SzGyYKB0F8BCWN/bq/JhQ/07pP03jWV9xtFhhUckfwag==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4078.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88823298-7a0f-4e31-4f14-08d83dc2bab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 06:49:43.7076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6kpEUsgii9o/9BFsP2PiWEFc3hCQYVu4Pw3HDRSQXWz30F33wzSSKdLq1qxzpzEuqK3iMFijZDlIuWrcmbadg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: "Clements, John" <John.Clements@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Tuesday, August 11, 2020 14:30
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test

After amdgpu driver loading successfully, we can use RAP debugfs interface <debugfs_dir>/dri/xxx/rap_test to trigger RAP test.

Currently only L0 validate test is supported.

v2: refine amdgpu_rap.h

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c     | 127 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h     |  30 +++++
 4 files changed, 161 insertions(+), 1 deletion(-)  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 0ba396e9d7e4..dec1927ca75d 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -55,7 +55,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_vf_error.o amdgpu_sched.o amdgpu_debugfs.o amdgpu_ids.o \
 	amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
-	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
+	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o
 
 amdgpu-$(CONFIG_PERF_EVENTS) += amdgpu_pmu.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 3a4b31b1c4f2..0af249a1e35b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -34,6 +34,7 @@
 #include "amdgpu_pm.h"
 #include "amdgpu_dm_debugfs.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_rap.h"
 
 /**
  * amdgpu_debugfs_add_files - Add simple debugfs entries @@ -1623,6 +1624,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	amdgpu_debugfs_autodump_init(adev);
 
+	amdgpu_rap_debugfs_init(adev);
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
new file mode 100644
index 000000000000..87cbc9011b2d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ *
+ */
+#include <linux/debugfs.h>
+#include <linux/pm_runtime.h>
+
+#include "amdgpu.h"
+#include "amdgpu_rap.h"
+
+/**
+ * DOC: AMDGPU RAP debugfs test interface
+ *
+ * how to use?
+ * echo opcode > <debugfs_dir>/dri/xxx/rap_test
+ *
+ * opcode:
+ * currently, only 2 is supported by Linux host driver,
+ * opcode 2 stands for TA_CMD_RAP__VALIDATE_L0, used to
+ * trigger L0 policy validation, you can refer more detail
+ * from header file ta_rap_if.h
+ *
+ */
+static ssize_t amdgpu_rap_debugfs_write(struct file *f, const char __user *buf,
+		size_t size, loff_t *pos)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct ta_rap_shared_memory *rap_shared_mem;
+	struct ta_rap_cmd_output_data *rap_cmd_output;
+	struct drm_device *dev = adev->ddev;
+	uint32_t op;
+	int ret;
+
+	if (*pos || size != 2)
+		return -EINVAL;
+
+	ret = kstrtouint_from_user(buf, size, *pos, &op);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_get_sync(dev->dev);
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
+		return ret;
+	}
+
+	/* make sure gfx core is on, RAP TA cann't handle
+	 * GFX OFF case currently.
+	 */
+	amdgpu_gfx_off_ctrl(adev, false);
+
+	switch (op) {
+	case 2:
+		ret = psp_rap_invoke(&adev->psp, op);
+
+		if (ret == TA_RAP_STATUS__SUCCESS) {
+			dev_info(adev->dev, "RAP L0 validate test success.\n");
+		} else {
+			rap_shared_mem = (struct ta_rap_shared_memory *)
+					 adev->psp.rap_context.rap_shared_buf;
+			rap_cmd_output = &(rap_shared_mem->rap_out_message.output);
+
+			dev_info(adev->dev, "RAP test failed, the output is:\n");
+			dev_info(adev->dev, "\tlast_subsection: 0x%08x.\n",
+				 rap_cmd_output->last_subsection);
+			dev_info(adev->dev, "\tnum_total_validate: 0x%08x.\n",
+				 rap_cmd_output->num_total_validate);
+			dev_info(adev->dev, "\tnum_valid: 0x%08x.\n",
+				 rap_cmd_output->num_valid);
+			dev_info(adev->dev, "\tlast_validate_addr: 0x%08x.\n",
+				 rap_cmd_output->last_validate_addr);
+			dev_info(adev->dev, "\tlast_validate_val: 0x%08x.\n",
+				 rap_cmd_output->last_validate_val);
+			dev_info(adev->dev, "\tlast_validate_val_exptd: 0x%08x.\n",
+				 rap_cmd_output->last_validate_val_exptd);
+		}
+		break;
+	default:
+		dev_info(adev->dev, "Unsupported op id: %d, ", op);
+		dev_info(adev->dev, "Only support op 2(L0 validate test).\n");
+	}
+
+	amdgpu_gfx_off_ctrl(adev, true);
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+
+	return size;
+}
+
+static const struct file_operations amdgpu_rap_debugfs_ops = {
+	.owner = THIS_MODULE,
+	.read = NULL,
+	.write = amdgpu_rap_debugfs_write,
+	.llseek = default_llseek
+};
+
+void amdgpu_rap_debugfs_init(struct amdgpu_device *adev) { #if 
+defined(CONFIG_DEBUG_FS)
+	struct drm_minor *minor = adev->ddev->primary;
+
+	if (!adev->psp.rap_context.rap_initialized)
+		return;
+
+	debugfs_create_file("rap_test", S_IWUSR, minor->debugfs_root,
+				adev, &amdgpu_rap_debugfs_ops);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h
new file mode 100644
index 000000000000..ec6d7632d3a0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person 
+obtaining a
+ * copy of this software and associated documentation files (the 
+"Software"),
+ * to deal in the Software without restriction, including without 
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute, 
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom 
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be 
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT 
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ *
+ */
+#ifndef _AMDGPU_RAP_H
+#define _AMDGPU_RAP_H
+
+#include "amdgpu.h"
+
+void amdgpu_rap_debugfs_init(struct amdgpu_device *adev); #endif
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
