Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2755DC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E856E20774
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 06:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v5Y64okr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E856E20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82836E0FB;
	Tue, 11 Aug 2020 06:33:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2064.outbound.protection.outlook.com [40.107.95.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A8D6E0FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 06:33:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SEuTeUZw6RmcC0kZBMQ3mIemYamZ1irOWEfN+3mL7r0/85AbiebW3v9ccey1tPWcByhCbqF97A9Hx2e35qvo+nF29mR1NpK8NWT10INZbvKb0o0jbGweZRZ9O811HsUqaHUUGlXV/n/NuyrGdKN0qEJloLqQoA8yJhXMpcfsGHAyq6ZQVAvNiWwb8svbkUkAKJcipzvN3anF3IDoN6S+ulMiMBoQ9f9Lx2h9FRG0pLJV/uLHYl6UT1Ckvkk7HMG6AIVDbytOybLJ//saq66HLSoNrtcdaTPaOd89tFRJZMDBLP71rJEUldS8JBagONuUD0IShvOU6HrU8JlJ2xhV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRQhts//Oq3ARxBHN6Z3kviGPR1sITnFgMfHlz/oBXE=;
 b=EaMXzXmfxZhSGmWJScI9RfwDeK8nWMs7uXbsgTR0oksg1MYnabCdVhG4OA2aWh9pMTAJGJzKv35ylWNtdmK74/iRDkGL21wMt+1l6KAz5bEJgXtvEP5MZ4PDhRH7qvojvClMHsscEIxiZDQreA/zjOklu9MDKwni3qwMEUUtBfY5RBJ/Lu1Kph/ZFA4xRCJwsj6TuU3hmh1SvCjYS7pp+wGynewb6WTAgXmajJh8Fp7LFnsJ2/GI0G3ZlFWjoTTtqvVM/Q88Nr3sfvY8ZD6cLrFt6fNXoUkFPwTqy6AhXwCcy5HRlhe6spOjARXPgKeCT6EqZg0gQTr/ie3ik3DUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRQhts//Oq3ARxBHN6Z3kviGPR1sITnFgMfHlz/oBXE=;
 b=v5Y64okrucQAVZhai8QCbWY7bdY4ioP2SD6n4aQaUvcnPT4dEPrQQt8WwNVKre2vxf+tLfU/I7peuB8pD1Y2kwIXSfVeu4zoEc7wpxz7RCRZfn/zhWzvKNM6zJKD2w2F0C0M85DoTewVvByjSjachrXeWUWyjGtFfqHZYyzPkig=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0120.namprd12.prod.outlook.com (2603:10b6:910:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Tue, 11 Aug
 2020 06:33:18 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::e181:b736:5067:12f2%9]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 06:33:18 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test
Thread-Topic: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test
Thread-Index: AQHWb6jn47zqf0tBE0mh1DHDXo0Zoakycx/g
Date: Tue, 11 Aug 2020 06:33:18 +0000
Message-ID: <CY4PR12MB1287E925DC6659A9A37766D8F1450@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200811063007.7785-1-Wenhui.Sheng@amd.com>
 <20200811063007.7785-3-Wenhui.Sheng@amd.com>
In-Reply-To: <20200811063007.7785-3-Wenhui.Sheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-11T06:33:08Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=091ff8da-8e30-4a70-a253-0000e6b9c2ac;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-11T06:33:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 62240354-dd74-4c07-90c3-000077985fbf
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ee704d4b-1692-41b9-eb08-08d83dc06f74
x-ms-traffictypediagnostic: CY4PR1201MB0120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01204A61F96722103AE94A54F1450@CY4PR1201MB0120.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4KgpFnom1jh2Tak5e8LGEpt+R0l67hM+ImtH0UadUIw23gt8cyrOCTsMaEMym0tr3KMldVkY7RXFnxWg/e8ssq5WH8FFUxO6W55NmT1YMs94Q60IYhz64nfRNKtUMRdn9FL/WeLnRyX39+dw7Gj66BAYUcozueFFJe1tmbuUE9syFRjIvBLhnytk9qek5n0i+7bRr6ftpc2oQ4Ovu8TY+eHQPIM4lZyTtmOl1shszstRPVCloxZ7RVjiEnFDoME2uAYsl1yyOILc+WwSqhTFiDg5jlrdWO0Fpdcf1UZNsQbRFOiuYYSxyOM3VHCob0Co+FKG0EnXvuOVxkKgmYuSYuDzCwFogQSSA/36tpRwSLzwgcaFsqFO9vUN1RjfsbQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(4326008)(83380400001)(186003)(26005)(8936002)(71200400001)(66946007)(66446008)(8676002)(66476007)(64756008)(66556008)(52536014)(76116006)(55016002)(9686003)(86362001)(110136005)(5660300002)(33656002)(6506007)(53546011)(478600001)(2906002)(316002)(54906003)(7696005)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: K+KEHULsAgUiqJ6CRbXCNuVfoWfnULeBCLKcrA8r2LhgzUMJ3h6SnLpGGBx+/4PG1QptQ9QP+mcS5gpsLLLz8L1HqFjn6yAsjmH9XS96myL1u58L5uUgsRn1bgxmRTCJ12Y69FNGgwGXc9rk6NZgL+hBATlXN3zThbjYhwgdjpkZQf/I/n1tldmrOPJ67CNjlRz3D81NpTXE+keLWz8opndU99hzMonn+CsBJGd0q7LC2bMXEtb8ULGvy+StF2rk58rxcaettFItiqsjJUpVafFS5akWiMmU6m9yP7ZIlICkqwdJndFhrfyIIdsbVXV6OHE1C32u3KdRyT0evfXFnSPjet7rHN4bnCfb4EdzoA8STdtnCaTo4LAVTfqenZuMqDhyoWlNSYljZoc3OEkZesu1nnGrBGiAtN28S+jJ9Kz+QVxcjFJW6N6OgUovNCb5PMV4GAwuCD4aXAnb2AgP+VgbLPfyhIfxqL1CpSd/4fc6s2lE+w0RNSdJU726xG377O1KioTVHM617jftkVxqMO+GzcWkEd5p0Fr03D7DRmQ/Rx7PTrlWgywYT87Fif3bAGkTW1DeZObqV3nwzGJVdYY7hIyr/iLSvG0WkkO9E41OZNz4jS8QwA4WCzC3U5PswTPlu7epxF6/HavE9zA3hg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee704d4b-1692-41b9-eb08-08d83dc06f74
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 06:33:18.4464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+U2T7TghxDzUMmRHa1EF5mo8YT0KcrfoBTS6bKHt97F1aZQD7MOghL3xHsO6XlhPWSfBW6QFEmQQjwYMLIgZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is:
Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Sheng, Wenhui <Wenhui.Sheng@amd.com> 
Sent: Tuesday, August 11, 2020 2:30 PM
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
