Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9473C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 05:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE64206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 05:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v6Qb1iUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE64206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04086E0E5;
	Tue, 11 Aug 2020 05:40:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 885606E0E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 05:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggDWn3S0HBIAolhv5XLwoQM0qc6RZmpFU63Lrnz2NB172M91027lijJMtwiGmKaxaa1UXM8X0cRfDz85+6eyWrumVMInVpehwFCjs1PHlN1cnenhXKkiF89JN+vw576n40XdVhHOLPmT4y+zcutaxQpxUrKyI7nJ+F+PRj8tpNnOztbF3x2CY42qECToaEq1Z85Jtpm1GfQCskJl+2cw/D2bfpea/ImTTsWlE5pkyHf4dh9YzSkBE0Riqyg0uGQ0cnb/XyoZ89MSKDjAGQF7Qp+v1Yz/4pL4EcbXOZ4okOP7H5IDScZFIhBltwZslxwgEKp+IMs3RScHAgVUHguMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci0mhL/gvlBvDe/b8gWewVhLA8El8Epl2evWYwAhKww=;
 b=Uq2LkTckeqPDFW3KZrP89goucudYjB4MU/tOMBx5KkgwMsOyW4OCB3e4rhTiYgqP/+ebJHsA7PqUgwYOdGVbcg0HgP69aezW+Nk8T+NAL4Vy2JyvG21632CSElK1wAo+Wo1XXtooFGs1D976TTCXj/q7hcnWzKaDU4FwFaqvwOJ3laJUpJ5voReKGIClJaUl0uQEdB7uKDHtUVBsMK5x1Stf50rdb6VZOq8f/UOFB/cKOtpcu+essU+7yXBdzHv1LVMN5WrtDKMJoK2+yTTwNLbiL/DBnrmF99UgKSRGl+DqQQqhOwmWgpa7+go+wdalg86LyjPFDNxr4N3nUlGYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ci0mhL/gvlBvDe/b8gWewVhLA8El8Epl2evWYwAhKww=;
 b=v6Qb1iUhXcMYp4GSgpvL+MfhLkNSjdA+6YxqzKqugR2Khswna0kmUvSYn7yEVsURcCEFJbqmv2DPaMp3Xp17YbtED4gRi8AweVZb+gRw2XfBeLg7sQwSU5fgmSNj4Pu1o1QJjl+VkeRO6Ne9K7nM4ZjC1rbF+jjnImcJRvGONe8=
Received: from CY4PR12MB1814.namprd12.prod.outlook.com (2603:10b6:903:125::16)
 by CY4PR12MB1479.namprd12.prod.outlook.com (2603:10b6:910:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 05:40:27 +0000
Received: from CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f]) by CY4PR12MB1814.namprd12.prod.outlook.com
 ([fe80::c42a:ccf3:cf89:1e1f%3]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 05:40:26 +0000
From: "Sheng, Wenhui" <Wenhui.Sheng@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test
Thread-Topic: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test
Thread-Index: AQHWb4wUwvnDjaj8tkWzZIiZ9n6CHakyQR4AgAAhybA=
Date: Tue, 11 Aug 2020 05:40:26 +0000
Message-ID: <CY4PR12MB18146458BBB550452B591CC78C450@CY4PR12MB1814.namprd12.prod.outlook.com>
References: <20200811030345.7334-1-Wenhui.Sheng@amd.com>
 <20200811030345.7334-3-Wenhui.Sheng@amd.com>
 <CY4PR12MB1287D926591767A3C6194E46F1450@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287D926591767A3C6194E46F1450@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-11T03:27:55Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=7f12ffd1-ddb7-4aa1-bd4d-0000b0eb5f1c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-11T05:40:23Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 562b491f-489b-455e-a5af-0000c895ca8b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c814027-724f-4d29-e543-08d83db90d06
x-ms-traffictypediagnostic: CY4PR12MB1479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1479167C6D42D2010355F9658C450@CY4PR12MB1479.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZyRA7PbeT66yuYmbooyo7m/Nmt69TfpfKneNIcJ+rcys/3Ozler+U7XHDs3EyidN4HfPlgP8F/6jqvVtMoFeNlkK+aa+Yq365aCGXD9yEPF1q5BgnAGWqEVs8++mGPBC+f49dGLWzWAlcPWF7hFDvBFPjVMbP9jyPa/Rwh9OeKsQxGe/1X3M/Lky9OG+JHNK88zKvjFCyW0qLEfwoyeIG0eiZDxJxHzasbC1bU1kLymm2C0ZmGt6nqou9u0rnWZ/+KRhSMASkblYo2kqpYM2nba/Y7aHw8qEXsx5T4DGTXWJAVI1Rdb9b0QdUg7U2RBezUxRhZGbHaNJ8w4l5cMvoFyHnC6UgHy71+ByvnsvTjl12XTn63nsmT0PNYkPwYdwLLNK5otUzaaXCUmh5kmizySrFlKAwJVjMAI66qY+hfI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1814.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(64756008)(53546011)(6506007)(186003)(26005)(7696005)(8676002)(45080400002)(110136005)(8936002)(4326008)(2906002)(55016002)(9686003)(54906003)(316002)(66946007)(966005)(66446008)(66556008)(66476007)(52536014)(76116006)(5660300002)(83380400001)(86362001)(33656002)(478600001)(71200400001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: G7RvhtP3WTY3sOotW82FmufjCsn+QcLIsgqnoQbGy8ZGpRu3Qrkd0F6NzNWN5rAaNnxed5QSTQr39KTRz7FQ76YV7JoJFDWR38Qpd9PB/eZxR79Nr8D2UlCLeKU+BKR1dHUKPwc3xyemQ7L8ukUDupAyQjuaYF8jaU6kviWE8gHXb3C4fpfcoX9tYQfvpXQu3n7AUCSwjA6MJPb/1m2sPEL7cRZ+CBO/CTgiKMmP8W2LLNZG/5gX10SoxHh2pGXxiixScXAmw1nRlcZ4bqZ+9VAE55JYh79m39Fdp1SE39sSY9kvin5dvrJvVWyBPSLHkzRR5VlV9vv28FCfL6FiIZXj3Xcc+UzEbU97JGJTjqQh5msALUX09SxLW5aiJdCeOCyVAQKxTeEkU5yVoOV9RmbvnEFfnfXfkoeY7P36M4w4KrD4wr5Czd/DK/trHTZPvSaO8sIK3VbylHD7G8j7uZjYmZy5r2gIvbD7tt0IU+1SuRcyL2o7deuERngif5sDWd7Gk5UkbF8fo5p96dbL1iLy+5Y1HahlWATaG5FEt1MO6JhNl/k/+WomEfKeBz0oSj6iVBedMDpR3eDuKfs6XMQoJcLBMGGjVFKhIgtmzYLsVgpDr+mQvp7m61V9G8+i6siw/LaMiNftAhXcYq+0eA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1814.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c814027-724f-4d29-e543-08d83db90d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 05:40:26.8005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdXG983wcHubIcOjbiXbQn94jGa49bunGyYgKPxeKdKRVmg8Hcop5NmhFciudCGVIgaecKmjE4rwX0Gt6EuMqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1479
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

Hi Gunchun,

Thanks for pointing this out, for rap_test file node, I thought I need to use the same file mode as ras previously,  it seems that I'm wrong, for this rap_test file node, I think only S_IWUSR is enough, what's your opinion?

Brs
Wenhui 

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, August 11, 2020 11:33 AM
To: Sheng, Wenhui <Wenhui.Sheng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test

[AMD Public Use]

One comment inline, please check.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wenhui Sheng
Sent: Tuesday, August 11, 2020 11:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Sheng, Wenhui <Wenhui.Sheng@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: add debugfs interface for RAP test

After amdgpu driver loading successfully, we can use RAP debugfs interface <debugfs_dir>/dri/xxx/rap_test to trigger RAP test.

Currently only L0 validate test is supported.

v2: refine amdgpu_rap.h

Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c     | 127 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h     |  28 +++++
 4 files changed, 159 insertions(+), 1 deletion(-)  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c
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
index 000000000000..46b2607a7bd1
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
+	debugfs_create_file("rap_test", S_IWUGO | S_IRUGO, minor->debugfs_root,
+				adev, &amdgpu_rap_debugfs_ops);
[Guchun]I believe S_IWUGO would be complained by checkpatch.pl if running it on top of your modifications, as it's one world writable permission. Perhaps, we should use S_IWUSR | S_IRUGO.

+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h
new file mode 100644
index 000000000000..4a23d30fab62
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rap.h
@@ -0,0 +1,28 @@
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
+void amdgpu_rap_debugfs_init(struct amdgpu_device *adev); #endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cguchun.chen%40amd.com%7C900c01aafb0c4fd363fa08d83da33e49%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637327118636879081&amp;sdata=OwEZNbL9khBXRmIPu714WAtEJ5bvR4nf2XU7IrsIatc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
