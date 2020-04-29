Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336D5C83007
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 20:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDB342083B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 20:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2Qx5u/EY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB342083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B166F3FB;
	Wed, 29 Apr 2020 20:13:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6241C6F3FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 20:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYyaCFQ9BxGn8F6pSscsnPdWAuEGlLnl/fc9JCWgiuT9RFCjwLMpUHXEsFNM05kdjY422b0jVCorXGEF7vI4AvxlgCPWRudkYarLn1l1JAOBOTbN9T1tcrsXUvj7cxV/A9yGAp0OVIBT02rHtfnhc2iv4QCL3lhycdn5treGoyF+khzPJqoaYJT3RQ+EzxmAhkCTNN8PrBAZkY7cE+J3uM5iW18bNnXGcdU9ARnl6QsZdSmRHTMTu/EL6aOT9w61LBvF2wkURyga6tUIEfTpLQjudqsrzP/h8pKiMcxSdSmo+ceBdkotGTj9nYqfRHZjIX+TNVjLxzL66RE0szaeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QccjFEKsPBDLQvoxtuVwUAz5KEcxU+2LSaNqYaHKPU0=;
 b=PLFTfOhsVNj23+65IxrqbmvBWqXKi2rAkKfNQYi5KrBAeTS1wP/ckQ1QmPUqAsAaSp+IcCAWSeW8JLNsX3YukdeiPuJEN+qhP7fnR77jYZylIy41Rlp1+GDUezIIPrOtcqbbi2QYBen2vzD7MZ45OJWyUxuemjnoCzJOEPo4ECm7T3NVL98+qq3A3/J0O2r9XCUGgGOrZxEIgzg7jdgA9yPfaHlqNLDglsMjF6yLLpqjzpPXr9j6TgquzhdzsgXjgv75vtRj/fGa73bNNqhwdvd9Ov1BFpWkiT68OsYIjvnOb79hPgAY3W3xBT1QvVqULcRS64wR+e5p555PkAoBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QccjFEKsPBDLQvoxtuVwUAz5KEcxU+2LSaNqYaHKPU0=;
 b=2Qx5u/EYD2JRNAgidVnPc0pW7SceARWrN+AoV2atC3g73qve6bzRiZ3lduTYUNttEtPDReWaH1lWZ5yISRBqg8OeKolJmC8EvrVddgiS2Gx/noJi7MKzYRPuQIBjCLSJ2klVVXsWxfkami1gV/pVzOvTujQ0QqFM0sxHJ9OtlGg=
Received: from DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23)
 by DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 20:13:41 +0000
Received: from DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a]) by DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a%3]) with mapi id 15.20.2937.025; Wed, 29 Apr 2020
 20:13:41 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Ba, Gang" <Gang.Ba@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd: add Streaming Performance Monitor feature
Thread-Topic: [PATCH] drm/amd: add Streaming Performance Monitor feature
Thread-Index: AQHWHWUzkxXTedRAPk2d7xlNWen9waiQftVu
Date: Wed, 29 Apr 2020 20:13:41 +0000
Message-ID: <DM6PR12MB44826ACFD413B62FEBB5F202F0AD0@DM6PR12MB4482.namprd12.prod.outlook.com>
References: <1588082294-21523-1-git-send-email-gaba@amd.com>
In-Reply-To: <1588082294-21523-1-git-send-email-gaba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-29T20:13:39.812Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [66.220.193.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a10c382-411e-4546-4a6a-08d7ec79cf97
x-ms-traffictypediagnostic: DM6PR12MB3097:|DM6PR12MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3097E19FB0B76048ED6F23E8F0AD0@DM6PR12MB3097.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(478600001)(64756008)(316002)(71200400001)(966005)(9686003)(66946007)(19627405001)(66446008)(76116006)(66476007)(66556008)(86362001)(55016002)(8676002)(45080400002)(30864003)(110136005)(186003)(52536014)(2906002)(33656002)(6506007)(8936002)(5660300002)(53546011)(26005)(7696005)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BmqQVnhhd41BeCzi9N30RJGUslKdEvDH92KdewBsoeK/dPsvMkCcN4J4BxIrJvzT4UHiqyf+nWo+A9CLcaL9LSuAenbhaB9EaGyIyuU4b7cH7NcIW03iY5eusqcf4dJa3r//ZEkqem07hC19oYPUH65Chwp2pCHEUKNUzij5FnYC4Deq5cdAOds+oBzsc6EHARxJ5zPZur55K088l1VLlhSVPJHZ0HcRFrk57JGVgG1TvJkYi885PG7f+PXONp/a1GPmIG9zX3sSUzg6dXGOz3AYbBIal0WDvJRf7SYYYLurqKAkBaNQ5eQm7WRPHp8S+te4683I3+LbqhByQywXgwlhZiKKvXksSPtmK87y3Sc4qTHEltOCQpsiy9XJ02YzwBBRpnQPHQxr5pJg6v5kTAksPv32rByzNAYj3F1yCazsZYHRgzju+Ktsf0f4i08wrsRPg0incabjfXHauVaw6e0DeZyZPRFWH2Y03Uwg7uM=
x-ms-exchange-antispam-messagedata: lTXlqj/RmENq4gxZyOCjgAWAEfWJXL41ELCb6K4VvsvjgyvCAP15PAhYMpCVJMAQVHelO0w+IiwOZizywZ2WTwLHSZKBIIA0CaD3OpzmQY4oAsy8DJXJK/viVbuNE5jMbcF/jvqCBA/rrJCldyBJCJ4O2VrS7VezAOr9n5eETbGpMtswtsBR9+8dHg3qps7omWG3CRq6KJHjDURCkV3LskEhj+rrI+qqMdSVDW0fTPguqoNHglYCFaTATAzeC64Ek8URMJS9vTUEZtPd//7JsGL75suBdPE0GJdKJKcUT4DlXZRTFuMF172ZO7Nvj8XLPyp9sboUhSVbk/ig7OyUmRRwO+H7HmBoCD+3N6+9Cm60IJUYaufsCKf7omiQqR6uGp9qT9OphXhu2c6p7B6NSQ1QlU08MG1FVsN+by2ZYflKNwoROK9HUTncfPTCXaW6sxFJ/v172dHDHKMzVAddav0SwPLIhIOtSYoICB4fiJ0SA28VH35Z4zhv/EcQboo3gICofwxd2QJ4np+uqa2DF065U8VkIs+x0aaQ+KBUhCEyjiDa9dnFlEfAaZjrbzl7IfF7hH4KdPwEy6EOe9VUAkNWotFE+SeUMVzwuaWcfY+TT4Uh7iNyWDHV31RRnUdPirknp8hx0FJngCbIyJPeLIwhCTSb1USphBIWX70qwSEp8B3nQZOCnT1QZYJ/HUCa3irTSjB5MQz/BucgZg8Na+ilQ/ZFYDqpzEteOOqdf3+q5ynP3CKuKunDDuFG/+YiMIekmVMnklD/Sf0WlKDlEK/UUI6dQ8hrHhtGOXeh0ZI=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a10c382-411e-4546-4a6a-08d7ec79cf97
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 20:13:41.3195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tauVrGWbWCIEomOhyUseBKK264hVVjwzAkDfpcZ1gaI5ynZ5cJsVeg/kkoFo4Dtq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3097
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
Content-Type: multipart/mixed; boundary="===============1295026741=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1295026741==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB44826ACFD413B62FEBB5F202F0AD0DM6PR12MB4482namp_"

--_000_DM6PR12MB44826ACFD413B62FEBB5F202F0AD0DM6PR12MB4482namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

I spotted two cosmetic issues when browsing it. see them inline [yz].

Yong

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Gang Ba =
<gaba@amd.com>
Sent: Tuesday, April 28, 2020 9:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: add Streaming Performance Monitor feature

Signed-off-by: Gang Ba <gaba@amperd.com>
Change-Id: If83ee0a14ef834699de6733eeab0f140159bbd6e
---
 drivers/gpu/drm/amd/amdgpu/Makefile                |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |  10 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c | 165 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |  27 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 175 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 176 +++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 168 ++++++
 drivers/gpu/drm/amd/amdkfd/Makefile                |   3 +-
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  17 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  20 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_spm.c               | 577 +++++++++++++++++=
++++
 drivers/gpu/drm/amd/amdkfd/soc15_int.h             |   1 +
 include/uapi/linux/kfd_ioctl.h                     |  55 +-
 16 files changed, 1413 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_spm.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 210d57a..1498b18 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -177,7 +177,8 @@ amdgpu-y +=3D \
          amdgpu_amdkfd_gfx_v8.o \
          amdgpu_amdkfd_gfx_v9.o \
          amdgpu_amdkfd_arcturus.o \
-        amdgpu_amdkfd_gfx_v10.o
+        amdgpu_amdkfd_gfx_v10.o \
+        amdgpu_amdkfd_rlc_spm.o \

 ifneq ($(CONFIG_DRM_AMDGPU_CIK),)
 amdgpu-y +=3D amdgpu_amdkfd_gfx_v7.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h
index d065c50..fdc438a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -246,6 +246,16 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct amdgp=
u_bo *bo);
 int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,
                                 struct tile_config *config);

+void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl);
+int amdgpu_amdkfd_rlc_spm(struct kgd_dev *kgd, void *args);
+void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, u32 =
size);
+int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd);
+u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd);
+void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr);
+u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd);
+void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr);
+int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 value=
);
+
 /* KGD2KFD callbacks */
 int kgd2kfd_init(void);
 void kgd2kfd_exit(void);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
new file mode 100644
index 0000000..b492c1e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c
@@ -0,0 +1,165 @@
+/*
+ * Copyright 2014-2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/list.h>
+#include <linux/pagemap.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
+
+#include "amdgpu_object.h"
+#include "amdgpu_vm.h"
+#include "amdgpu_amdkfd.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+
+
+void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl)
+{
+        struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+        struct amdgpu_spm *spm =3D &adev->gfx.spm;
+        struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+        spin_lock(&adev->gfx.kiq.ring_lock);
+        amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+        cntl =3D=3D true ? adev->gfx.spm.spmf->start(adev):adev->gfx.spm.s=
pmf->stop(adev);
+        amdgpu_ring_commit(kiq_ring);
+        spin_unlock(&adev->gfx.kiq.ring_lock);
+}
+
+u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd)
+{
+        struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+        struct amdgpu_spm *spm =3D &adev->gfx.spm;
+        struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+        u32 rptr =3D 0;
+
+        spin_lock(&adev->gfx.kiq.ring_lock);
+        amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+        rptr =3D adev->gfx.spm.spmf->get_rdptr(adev);
+        amdgpu_ring_commit(kiq_ring);
+        spin_unlock(&adev->gfx.kiq.ring_lock);
+
+        return rptr;
+}
+
+void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr)
+{
+        struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+        struct amdgpu_spm *spm =3D &adev->gfx.spm;
+        struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+        spin_lock(&adev->gfx.kiq.ring_lock);
+        amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+        adev->gfx.spm.spmf->set_rdptr(adev, rptr);
+        amdgpu_ring_commit(kiq_ring);
+        spin_unlock(&adev->gfx.kiq.ring_lock);
+
+}
+
+u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd)
+{
+        struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+        struct amdgpu_spm *spm =3D &adev->gfx.spm;
+        struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+        u32 wptr;
+
+        spin_lock(&adev->gfx.kiq.ring_lock);
+        amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+        wptr =3D adev->gfx.spm.spmf->get_wrptr(adev);
+        amdgpu_ring_commit(kiq_ring);
+        spin_unlock(&adev->gfx.kiq.ring_lock);
+        return wptr;
+}
+
+void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr)
+{
+        struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+        struct amdgpu_spm *spm =3D &adev->gfx.spm;
+        struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+        spin_lock(&adev->gfx.kiq.ring_lock);
+        amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+        adev->gfx.spm.spmf->set_wrptr(adev, wptr);
+        amdgpu_ring_commit(kiq_ring);
+        spin_unlock(&adev->gfx.kiq.ring_lock);
+}
+
+void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, u32 =
size)
+{
+        struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+        struct amdgpu_spm *spm =3D &adev->gfx.spm;
+        struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+        /* init spm vmid with 0xf */
+        if (adev->gfx.rlc.funcs->update_spm_vmid)
+                adev->gfx.rlc.funcs->update_spm_vmid(adev, 0x0);
+
+        /* set spm ring registers */
+        spin_lock(&adev->gfx.kiq.ring_lock);
+        amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+        adev->gfx.spm.spmf->set_spm_porfmon_ring_buf(adev, gpu_addr, size)=
;
+        amdgpu_ring_commit(kiq_ring);
+        spin_unlock(&adev->gfx.kiq.ring_lock);
+}
+
+
+int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd)
+{
+        struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+        struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+        struct amdgpu_spm *spm =3D &adev->gfx.spm;
+
+        /* stop spm stream and interupt */
+        spin_lock(&adev->gfx.kiq.ring_lock);
+        amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+        adev->gfx.spm.spmf->stop(adev);
+        amdgpu_ring_commit(kiq_ring);
+        spin_unlock(&adev->gfx.kiq.ring_lock);
+
+        amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
+
+        /* revert spm vmid with 0xf */
+        if (adev->gfx.rlc.funcs->update_spm_vmid)
+             adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
+
+        return 0;
+}
+
+int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 value=
)
+{
+        struct amdgpu_device *adev =3D (struct amdgpu_device *)kgd;
+        struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+        struct amdgpu_spm *spm =3D &adev->gfx.spm;
+
+        pr_debug("[%s]\n", __func__);
+
+        /* stop spm stream and interupt */
+        spin_lock(&adev->gfx.kiq.ring_lock);
+        amdgpu_ring_alloc(kiq_ring, spm->spmf->get_spm_data_size);
+        adev->gfx.spm.spmf->set_reg(adev, uReg, value);
+        amdgpu_ring_commit(kiq_ring);
+        spin_unlock(&adev->gfx.kiq.ring_lock);
+
+        return 0;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index ee698f0..ba4da52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -105,6 +105,31 @@ struct amdgpu_kiq {
         const struct kiq_pm4_funcs *pmf;
 };

+struct spm_funcs {
+       void (*start)(struct amdgpu_device *adev);
+       void (*stop)(struct amdgpu_device *adev);
+       void (*set_reg)(struct amdgpu_device *adev, uint64_t reg, uint32_t =
val);
+       u32 (*get_rdptr)(struct amdgpu_device *adev);
+       void (*set_rdptr)(struct amdgpu_device *adev, u32 rptr);
+       u32 (*get_wrptr)(struct amdgpu_device *adev);
+       void (*set_wrptr)(struct amdgpu_device *adev, u32 wptr);
+       void (*set_spm_porfmon_ring_buf)(struct amdgpu_device *adev, u64 gp=
u_rptr, u32 size);
+
+       /* Packet sizes */
+       int set_spm_config_size;
+       int get_spm_data_size;
+};
+
+struct amdgpu_spm {
+       const struct spm_funcs *spmf;
+       u64              spm_gpu_addr;
+       u32              spm_gpu_size;
+       u32              spm_ring_rptr;
+       u32              spm_ring_rptrsize_to_read;
+       struct amdgpu_bo *spm_obj;
+       void             *spm_cpu_addr;
+};
+
 /*
  * GPU scratch registers structures, functions & helpers
  */
@@ -256,6 +281,7 @@ struct amdgpu_gfx {
         struct amdgpu_me                me;
         struct amdgpu_mec               mec;
         struct amdgpu_kiq               kiq;
+       struct amdgpu_spm               spm;
         struct amdgpu_scratch           scratch;
         const struct firmware           *me_fw; /* ME firmware */
         uint32_t                        me_fw_version;
@@ -292,6 +318,7 @@ struct amdgpu_gfx {
         struct amdgpu_irq_src           priv_reg_irq;
         struct amdgpu_irq_src           priv_inst_irq;
         struct amdgpu_irq_src           cp_ecc_error_irq;
+       struct amdgpu_irq_src           spm_irq;
         struct amdgpu_irq_src           sq_irq;
         struct sq_work                  sq_work;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index 63ac430..9c507d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4121,6 +4121,13 @@ static int gfx_v10_0_sw_init(void *handle)
         if (r)
                 return r;

+       /* KIQ SPM */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+                             GFX_10_1__SRCID__RLC_STRM_PERF_MONITOR_INTERR=
UPT,
+                             &adev->gfx.spm_irq);
+       if (r)
+               return r;
+
         /* EOP Event */
         r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP,
                               GFX_10_1__SRCID__CP_EOP_INTERRUPT,
@@ -6603,6 +6610,7 @@ static int gfx_v10_0_hw_fini(void *handle)

         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
 #ifndef BRING_UP_DEBUG
         if (amdgpu_async_gfx_ring) {
                 r =3D gfx_v10_0_kiq_disable_kgq(adev);
@@ -6768,6 +6776,126 @@ static void gfx_v10_0_ring_emit_gds_switch(struct a=
mdgpu_ring *ring,
                                     (1 << (oa_size + oa_base)) - (1 << oa_=
base));
 }

+static void gfx_v10_0_spm_start(struct amdgpu_device *adev)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       uint32_t data =3D 0;
+       u8 se;
+
+       for (se =3D 0; se < adev->gfx.config.max_shader_engines + 1; ++se)
+       {
+               uint32_t mux_addr_reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM=
_GLOBAL_MUXSEL_ADDR);
+               data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
+                       INSTANCE_BROADCAST_WRITES, 1);
+               data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
+                       SA_BROADCAST_WRITES, 1);
+               data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
+                       SE_BROADCAST_WRITES, 1);
+
+               if (se < adev->gfx.config.max_shader_engines) // SE else GB
+               {
+                       data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_IND=
EX, se);
+                       mux_addr_reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_=
SE_MUXSEL_ADDR);
+               }
+               gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_O=
FFSET(GC, 0, mmGRBM_GFX_INDEX), data);
+               gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_re=
g, 0);
+       }
+
+       data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
+       data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1=
);
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0, mmGRBM_GFX_INDEX), data);
+
+       data =3D 0;
+       data |=3D CP_PERFMON_STATE_DISABLE_AND_RESET <<4 ;
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0, mmCP_PERFMON_CNTL), data);
+
+       data =3D 0;
+       data |=3D STRM_PERFMON_STATE_START_COUNTING <<4 ;
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0, mmCP_PERFMON_CNTL), data);
+
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0, mmRLC_SPM_INT_CNTL) ,1);
+}
+
+static void gfx_v10_0_spm_stop(struct amdgpu_device *adev)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       uint32_t data =3D 0;
+
+       data =3D CP_PERFMON_STATE_STOP_COUNTING;
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0, mmCP_PERFMON_CNTL), data);
+
+       data |=3D (1<<10);
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0, mmCP_PERFMON_CNTL), data);
+
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0, mmRLC_SPM_INT_CNTL), 0);
+}
+
+static u32 gfx_v10_0_spm_get_rdptr(struct amdgpu_device *adev)
+{
+       return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_RDPTR);;
+}
+
+static void gfx_v10_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0, mmRLC_SPM_RING_RDPTR), rptr);
+}
+
+static u32 gfx_v10_0_spm_get_wrptr(struct amdgpu_device *adev)
+{
+       return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_WRPTR);
+}
+
+static void gfx_v10_0_spm_set_wrptr(struct amdgpu_device *adev,  u32 wptr)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0, mmRLC_SPM_RING_WRPTR), wptr);
+}
+
+static void gfx_v10_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev,=
 u64 gpu_addr, u32 size)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC=
, 0,
+                       mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_bits(gpu_=
addr));
+
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_BASE=
_HI), upper_32_bits (gpu_addr));
+
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false,
+                       SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE=
), size);
+}
+
+static void gfx_v10_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32=
 value)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       uint32_t grbm_cntl;
+       grbm_cntl =3D adev->reg_offset[GC_HWIP][0][1] + reg;
+
+       gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, grbm_cntl, value);
+}
+
+static const struct spm_funcs gfx_v10_0_spm_funcs =3D {
+       .start =3D gfx_v10_0_spm_start,
+       .stop =3D gfx_v10_0_spm_stop,
+       .get_rdptr=3D gfx_v10_0_spm_get_rdptr,
+       .set_rdptr=3D gfx_v10_0_spm_set_rdptr,
+       .get_wrptr=3D gfx_v10_0_spm_get_wrptr,
+       .set_wrptr=3D gfx_v10_0_spm_set_wrptr,
+       .set_spm_porfmon_ring_buf =3D gfx_v10_0_set_spm_porfmon_ring_buf,
+       .set_reg =3D gfx_v10_0_spm_set_reg,
+       .set_spm_config_size =3D 3,
+       .get_spm_data_size =3D 128,
+};
+
+static void gfx_v10_0_set_spm_funcs(struct amdgpu_device *adev)
+{
+       adev->gfx.spm.spmf =3D &gfx_v10_0_spm_funcs;
+}
+
+
 static int gfx_v10_0_early_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
@@ -6776,6 +6904,7 @@ static int gfx_v10_0_early_init(void *handle)

         adev->gfx.num_compute_rings =3D AMDGPU_MAX_COMPUTE_RINGS;

+       gfx_v10_0_set_spm_funcs(adev);
         gfx_v10_0_set_kiq_pm4_funcs(adev);
         gfx_v10_0_set_ring_funcs(adev);
         gfx_v10_0_set_irq_funcs(adev);
@@ -6794,6 +6923,10 @@ static int gfx_v10_0_late_init(void *handle)
         if (r)
                 return r;

+        r =3D amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+        if (r)
+               return r;
+
         r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
         if (r)
                 return r;
@@ -6860,6 +6993,7 @@ static void gfx_v10_0_update_medium_grain_clock_gatin=
g(struct amdgpu_device *ade
                 if (def !=3D data)
                         WREG32_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data=
);

+
                 /* MGLS is a global flag to control all MGLS in GFX */
                 if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGLS) {
                         /* 2 - RLC memory Light sleep */
@@ -8018,6 +8152,39 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ri=
ng *ring)
         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
 }

+static int gfx_v10_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+                                            struct amdgpu_irq_src *src,
+                                            unsigned int type,
+                                            enum amdgpu_interrupt_state st=
ate)
+{
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+               WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 0);
+               break;
+       case AMDGPU_IRQ_STATE_ENABLE:
+               WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 1);
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
+static int gfx_v10_0_spm_irq(struct amdgpu_device *adev,
+                            struct amdgpu_irq_src *source,
+                            struct amdgpu_iv_entry *entry)
+{
+       u8 me_id, pipe_id, queue_id;
+
+       me_id =3D (entry->ring_id & 0x0c) >> 2;
+       pipe_id =3D (entry->ring_id & 0x03) >> 0;
+       queue_id =3D (entry->ring_id & 0x70) >> 4;
+       pr_debug ("IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n",
+                                         me_id, pipe_id, queue_id);
+       return  0; /* This prevents sending it to KFD */
+}
+
+
 static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
         .name =3D "gfx_v10_0",
         .early_init =3D gfx_v10_0_early_init,
@@ -8189,6 +8356,11 @@ static const struct amdgpu_irq_src_funcs gfx_v10_0_k=
iq_irq_funcs =3D {
         .process =3D gfx_v10_0_kiq_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v10_0_spm_irq_funcs =3D {
+    .set =3D gfx_v10_0_spm_set_interrupt_state,
+    .process =3D gfx_v10_0_spm_irq,
+};
+
 static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 {
         adev->gfx.eop_irq.num_types =3D AMDGPU_CP_IRQ_LAST;
@@ -8197,6 +8369,9 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_dev=
ice *adev)
         adev->gfx.kiq.irq.num_types =3D AMDGPU_CP_KIQ_IRQ_LAST;
         adev->gfx.kiq.irq.funcs =3D &gfx_v10_0_kiq_irq_funcs;

+       adev->gfx.spm_irq.num_types =3D 1;
+       adev->gfx.spm_irq.funcs =3D &gfx_v10_0_spm_irq_funcs;
+
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v10_0_priv_reg_irq_funcs;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 14790f8..1125b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1955,6 +1955,12 @@ static int gfx_v8_0_sw_init(void *handle)
         adev->gfx.mec.num_pipe_per_mec =3D 4;
         adev->gfx.mec.num_queue_per_pipe =3D 8;

+       /* KIQ SPM */
+       r =3D amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS3=
0_IV_SRCID_RLC_STRM_PERF_MONITOR,
+                             &adev->gfx.spm_irq);
+       if (r)
+        return r;
+
         /* EOP Event */
         r =3D amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS=
30_IV_SRCID_CP_END_OF_PIPE, &adev->gfx.eop_irq);
         if (r)
@@ -4927,6 +4933,7 @@ static int gfx_v8_0_hw_fini(void *handle)
         amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);

         amdgpu_irq_put(adev, &adev->gfx.sq_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);

         /* disable KCQ to avoid CPC touch memory not valid anymore */
         gfx_v8_0_kcq_disable(adev);
@@ -5291,6 +5298,126 @@ static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_f=
uncs =3D {
         .select_me_pipe_q =3D &gfx_v8_0_select_me_pipe_q
 };

+static void gfx_v8_0_write_data_to_reg(struct amdgpu_ring *ring, int eng_s=
el,
+                                      bool wc, uint32_t reg, uint32_t val)
+{
+       amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
+       amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
+                               WRITE_DATA_DST_SEL(0) |
+                               (wc ? WR_CONFIRM : 0));
+       amdgpu_ring_write(ring, reg);
+       amdgpu_ring_write(ring, 0);
+       amdgpu_ring_write(ring, val);
+}
+
+static void gfx_v8_0_spm_start(struct amdgpu_device *adev)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       uint32_t data =3D 0;
+       u8 se;
+
+       for (se =3D 0; se < adev->gfx.config.max_shader_engines + 1; ++se)
+       {
+               uint32_t mux_addr_reg =3D mmRLC_SPM_GLOBAL_MUXSEL_ADDR;
+
+               data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
+                       INSTANCE_BROADCAST_WRITES, 1);
+               data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
+                       SH_BROADCAST_WRITES, 1);
+               data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
+                       SE_BROADCAST_WRITES, 1);
+
+               if (se < adev->gfx.config.max_shader_engines) // SE else GB
+               {
+                       data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_IND=
EX, se);
+
+                       mux_addr_reg =3D mmRLC_SPM_SE_MUXSEL_ADDR;
+               }
+               gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmGRBM_GFX_I=
NDEX, data);
+               // init addr
+               gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg=
, data);
+       }
+
+       data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
+       data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1=
);
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmGRBM_GFX_INDEX, da=
ta);
+
+       data =3D 0;
+       data |=3D CP_PERFMON_STATE_DISABLE_AND_RESET <<4 ;
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, d=
ata);
+
+       data =3D 0;
+       data |=3D STRM_PERFMON_STATE_START_COUNTING <<4 ;
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL,  =
     data);
[yz] unnecessary spaces here
+
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_INT_CNTL ,=
1);
+}
+
+static void gfx_v8_0_spm_stop(struct amdgpu_device *adev)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       uint32_t data =3D 0;
+
+       data =3D CP_PERFMON_STATE_STOP_COUNTING;
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, d=
ata);
+       data |=3D (1<<10);
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmCP_PERFMON_CNTL, d=
ata);
+
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_INT_CNTL, =
0);
+}
+
+
+static u32 gfx_v8_0_spm_get_rdptr(struct amdgpu_device *adev)
+{
+       return RREG32 (mmRLC_SPM_RING_RDPTR);
+}
+
+static void gfx_v8_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_RING_RDPTR=
, rptr);
+}
+
+static u32 gfx_v8_0_spm_get_wrptr(struct amdgpu_device *adev)
+{
+       return  -1;
+}
+
+static void gfx_v8_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, =
u64 gpu_addr, u32 size)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RI=
NG_BASE_LO, lower_32_bits(gpu_addr));
+
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RI=
NG_BASE_HI, upper_32_bits (gpu_addr));
+
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmRLC_SPM_PERFMON_RI=
NG_SIZE, size);
+}
+
+static void gfx_v8_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 =
value)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, reg, value);
+}
+
+static const struct spm_funcs gfx_v8_0_spm_funcs =3D {
+       .start =3D gfx_v8_0_spm_start,
+       .stop =3D gfx_v8_0_spm_stop,
+       .get_rdptr=3D gfx_v8_0_spm_get_rdptr,
+       .set_rdptr=3D gfx_v8_0_spm_set_rdptr,
+       .get_wrptr=3D gfx_v8_0_spm_get_wrptr,
+       .set_spm_porfmon_ring_buf =3D gfx_v8_0_set_spm_porfmon_ring_buf,
+       .set_reg =3D gfx_v8_0_spm_set_reg,
+       .set_spm_config_size =3D 3,
+       .get_spm_data_size =3D 128,
+};
+
+static void gfx_v8_0_set_spm_funcs(struct amdgpu_device *adev)
+{
+       adev->gfx.spm.spmf =3D &gfx_v8_0_spm_funcs;
+}
+
 static int gfx_v8_0_early_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
@@ -5298,6 +5425,8 @@ static int gfx_v8_0_early_init(void *handle)
         adev->gfx.num_gfx_rings =3D GFX8_NUM_GFX_RINGS;
         adev->gfx.num_compute_rings =3D AMDGPU_MAX_COMPUTE_RINGS;
         adev->gfx.funcs =3D &gfx_v8_0_gfx_funcs;
+
+       gfx_v8_0_set_spm_funcs(adev);
         gfx_v8_0_set_ring_funcs(adev);
         gfx_v8_0_set_irq_funcs(adev);
         gfx_v8_0_set_gds_init(adev);
@@ -5338,6 +5467,10 @@ static int gfx_v8_0_late_init(void *handle)
                 return r;
         }

+       r =3D amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+       if (r)
+               return r;
+
         return 0;
 }

@@ -6845,6 +6978,41 @@ static void gfx_v8_0_emit_mem_sync_compute(struct am=
dgpu_ring *ring)
         amdgpu_ring_write(ring, 0x0000000A);    /* poll interval */
 }

+static int gfx_v8_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+                                            struct amdgpu_irq_src *src,
+                                            unsigned int type,
+                                            enum amdgpu_interrupt_state st=
ate)
+{
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+               WREG32(mmRLC_SPM_INT_CNTL, 0);
+               break;
+       case AMDGPU_IRQ_STATE_ENABLE:
+               WREG32(mmRLC_SPM_INT_CNTL, 1);
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
+static int gfx_v8_0_spm_irq(struct amdgpu_device *adev,
+                            struct amdgpu_irq_src *source,
+                            struct amdgpu_iv_entry *entry)
+{
+       u8 me_id, pipe_id, queue_id;
+       struct amdgpu_ring *ring =3D &(adev->gfx.kiq.ring);
+
+       me_id =3D (entry->ring_id & 0x0c) >> 2;
+       pipe_id =3D (entry->ring_id & 0x03) >> 0;
+       queue_id =3D (entry->ring_id & 0x70) >> 4;
+       pr_debug("IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n",
+                       me_id, pipe_id, queue_id);
+
+       amdgpu_fence_process(ring);
+       return 0;
+}
+
 static const struct amd_ip_funcs gfx_v8_0_ip_funcs =3D {
         .name =3D "gfx_v8_0",
         .early_init =3D gfx_v8_0_early_init,
@@ -7005,11 +7173,19 @@ static const struct amdgpu_irq_src_funcs gfx_v8_0_s=
q_irq_funcs =3D {
         .process =3D gfx_v8_0_sq_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v8_0_spm_irq_funcs =3D {
+       .set =3D gfx_v8_0_spm_set_interrupt_state,
+       .process =3D gfx_v8_0_spm_irq,
+};
+
 static void gfx_v8_0_set_irq_funcs(struct amdgpu_device *adev)
 {
         adev->gfx.eop_irq.num_types =3D AMDGPU_CP_IRQ_LAST;
         adev->gfx.eop_irq.funcs =3D &gfx_v8_0_eop_irq_funcs;

+       adev->gfx.spm_irq.num_types =3D 1;
+       adev->gfx.spm_irq.funcs =3D &gfx_v8_0_spm_irq_funcs;
+
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v8_0_priv_reg_irq_funcs;

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 2767c6d..bfde274 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2249,6 +2249,13 @@ static int gfx_v9_0_sw_init(void *handle)
         adev->gfx.mec.num_pipe_per_mec =3D 4;
         adev->gfx.mec.num_queue_per_pipe =3D 8;

+       /* KIQ SPM */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_RLC,
+                             GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRU=
PT,
+                             &adev->gfx.spm_irq);
+       if (r)
+        return r;
+
         /* EOP Event */
         r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__=
SRCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
         if (r)
@@ -3907,6 +3914,7 @@ static int gfx_v9_0_hw_fini(void *handle)

         amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+       amdgpu_irq_put(adev, &adev->gfx.spm_irq, 0);
         amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);

         /* DF freeze and kcq disable will fail */
@@ -4617,6 +4625,121 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct a=
mdgpu_device *adev)
         return r;
 }

+static void gfx_v9_0_spm_start(struct amdgpu_device *adev)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       uint32_t data =3D 0;
+       u8 se;
+
+       for (se =3D 0; se < adev->gfx.config.max_shader_engines + 1; ++se)
+       {
+               uint32_t mux_addr_reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM=
_GLOBAL_MUXSEL_ADDR);
+
+               data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
+                       INSTANCE_BROADCAST_WRITES, 1);
+               data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
+                       SH_BROADCAST_WRITES, 1);
+               data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,
+                       SE_BROADCAST_WRITES, 1);
+
+               if (se < adev->gfx.config.max_shader_engines) // SE else GB
+               {
+                       data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_IND=
EX, se);
+
+                       mux_addr_reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_=
SE_MUXSEL_ADDR);
+               }
+               gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OF=
FSET(GC, 0, mmGRBM_GFX_INDEX), data);
+               // init addr
+               gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg=
, data);
+       }
+
+       data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, 0);
+       data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES, 1=
);
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0, mmGRBM_GFX_INDEX), data);
+
+       data =3D 0;
+       data |=3D CP_PERFMON_STATE_DISABLE_AND_RESET <<4 ;
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0, mmCP_PERFMON_CNTL), data);
+
+       data =3D 0;
+       data |=3D STRM_PERFMON_STATE_START_COUNTING <<4 ;
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0, mmCP_PERFMON_CNTL), data);
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0, mmRLC_SPM_INT_CNTL) ,1);
+}
+
+
+static void gfx_v9_0_spm_stop(struct amdgpu_device *adev)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       uint32_t data =3D 0;
+
+
+       data =3D CP_PERFMON_STATE_STOP_COUNTING;
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0, mmCP_PERFMON_CNTL), data);
+       data |=3D (1<<10);
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0, mmCP_PERFMON_CNTL), data);
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0, mmRLC_SPM_INT_CNTL), 0);
+}
+
+static u32 gfx_v9_0_spm_get_rdptr(struct amdgpu_device *adev)
+{
+       return RREG32_SOC15(GC, 0, mmRLC_SPM_RING_RDPTR);;
+}
+
+static void gfx_v9_0_spm_set_rdptr(struct amdgpu_device *adev,  u32 rptr)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0, mmRLC_SPM_RING_RDPTR), rptr);
+}
+
+static u32 gfx_v9_0_spm_get_wrptr(struct amdgpu_device *adev)
+{
+       return -1;
+}
+
+static void gfx_v9_0_set_spm_porfmon_ring_buf(struct amdgpu_device *adev, =
u64 gpu_addr, u32 size)
[yz] porfmon -> perfmon
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFFSET(GC,=
 0,
+                               mmRLC_SPM_PERFMON_RING_BASE_LO), lower_32_b=
its(gpu_addr));
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                               SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_R=
ING_BASE_HI), upper_32_bits (gpu_addr));
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false,
+                               SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFMON_R=
ING_SIZE), size);
+}
+
+static void gfx_v9_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, u32 =
value)
+{
+       struct amdgpu_ring *kiq_ring =3D &adev->gfx.kiq.ring;
+       uint32_t grbm_cntl;
+       grbm_cntl =3D adev->reg_offset[GC_HWIP][0][1] + reg;
+
+       gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, grbm_cntl, value);
+}
+
+static const struct spm_funcs gfx_v9_0_spm_funcs =3D {
+       .start =3D gfx_v9_0_spm_start,
+       .stop =3D gfx_v9_0_spm_stop,
+       .get_rdptr=3D gfx_v9_0_spm_get_rdptr,
+       .set_rdptr=3D gfx_v9_0_spm_set_rdptr,
+       .get_wrptr=3D gfx_v9_0_spm_get_wrptr,
+       .set_spm_porfmon_ring_buf =3D gfx_v9_0_set_spm_porfmon_ring_buf,
+       .set_reg =3D gfx_v9_0_spm_set_reg,
+       .set_spm_config_size =3D 3,
+       .get_spm_data_size =3D 128,
+};
+
+static void gfx_v9_0_set_spm_funcs(struct amdgpu_device *adev)
+{
+       adev->gfx.spm.spmf =3D &gfx_v9_0_spm_funcs;
+}
+
 static int gfx_v9_0_early_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
@@ -4626,6 +4749,7 @@ static int gfx_v9_0_early_init(void *handle)
         else
                 adev->gfx.num_gfx_rings =3D GFX9_NUM_GFX_RINGS;
         adev->gfx.num_compute_rings =3D AMDGPU_MAX_COMPUTE_RINGS;
+       gfx_v9_0_set_spm_funcs(adev);
         gfx_v9_0_set_kiq_pm4_funcs(adev);
         gfx_v9_0_set_ring_funcs(adev);
         gfx_v9_0_set_irq_funcs(adev);
@@ -4677,6 +4801,10 @@ static int gfx_v9_0_late_init(void *handle)
         if (r)
                 return r;

+       r =3D amdgpu_irq_get(adev, &adev->gfx.spm_irq, 0);
+       if (r)
+               return r;
+
         r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
         if (r)
                 return r;
@@ -6657,6 +6785,39 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu_rin=
g *ring)
         amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
 }

+static int gfx_v9_0_spm_set_interrupt_state(struct amdgpu_device *adev,
+                                            struct amdgpu_irq_src *src,
+                                            unsigned int type,
+                                            enum amdgpu_interrupt_state st=
ate)
+{
+       switch (state) {
+       case AMDGPU_IRQ_STATE_DISABLE:
+               WREG32(mmRLC_SPM_INT_CNTL, 0);
+               break;
+       case AMDGPU_IRQ_STATE_ENABLE:
+               WREG32(mmRLC_SPM_INT_CNTL, 1);
+               break;
+       default:
+               break;
+       }
+       return 0;
+}
+
+static int gfx_v9_0_spm_irq(struct amdgpu_device *adev,
+                            struct amdgpu_irq_src *source,
+                            struct amdgpu_iv_entry *entry)
+{
+       u8 me_id, pipe_id, queue_id;
+
+       me_id =3D (entry->ring_id & 0x0c) >> 2;
+       pipe_id =3D (entry->ring_id & 0x03) >> 0;
+       queue_id =3D (entry->ring_id & 0x70) >> 4;
+       pr_debug("IH: RLC_RPM_INT, me:%d, pipe:%d, queue:%d\n",
+                       me_id, pipe_id, queue_id);
+
+       return 0; /* This also prevents sending it to KFD */
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs =3D {
         .name =3D "gfx_v9_0",
         .early_init =3D gfx_v9_0_early_init,
@@ -6825,12 +6986,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9_0_c=
p_ecc_error_irq_funcs =3D {
         .process =3D amdgpu_gfx_cp_ecc_error_irq,
 };

+static const struct amdgpu_irq_src_funcs gfx_v9_0_spm_irq_funcs =3D {
+       .set =3D gfx_v9_0_spm_set_interrupt_state,
+       .process =3D gfx_v9_0_spm_irq,
+};

 static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 {
         adev->gfx.eop_irq.num_types =3D AMDGPU_CP_IRQ_LAST;
         adev->gfx.eop_irq.funcs =3D &gfx_v9_0_eop_irq_funcs;

+       adev->gfx.spm_irq.num_types =3D 1;
+       adev->gfx.spm_irq.funcs =3D &gfx_v9_0_spm_irq_funcs;
+
         adev->gfx.priv_reg_irq.num_types =3D 1;
         adev->gfx.priv_reg_irq.funcs =3D &gfx_v9_0_priv_reg_irq_funcs;

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdk=
fd/Makefile
index 6147462..43edba0 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -53,7 +53,8 @@ AMDKFD_FILES  :=3D $(AMDKFD_PATH)/kfd_module.o \
                 $(AMDKFD_PATH)/kfd_int_process_v9.o \
                 $(AMDKFD_PATH)/kfd_dbgdev.o \
                 $(AMDKFD_PATH)/kfd_dbgmgr.o \
-               $(AMDKFD_PATH)/kfd_crat.o
+               $(AMDKFD_PATH)/kfd_crat.o       \
+               $(AMDKFD_PATH)/kfd_spm.o

 ifneq ($(CONFIG_AMD_IOMMU_V2),)
 AMDKFD_FILES +=3D $(AMDKFD_PATH)/kfd_iommu.o
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu=
/drm/amd/amdkfd/cik_event_interrupt.c
index 9f59ba9..cd394cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -24,6 +24,7 @@
 #include "kfd_events.h"
 #include "cik_int.h"
 #include "amdgpu_amdkfd.h"
+#include "ivsrcid/ivsrcid_vislands30.h"

 static bool cik_event_interrupt_isr(struct kfd_dev *dev,
                                         const uint32_t *ih_ring_entry,
@@ -37,6 +38,11 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
         uint16_t pasid;
         bool ret;

+       vmid =3D f2g->read_vmid_from_vmfault_reg(dev->kgd);
+
+       if ((ihre->source_id =3D=3D VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONIT=
OR) && (vmid =3D=3D 0))
+                return (kfd_spm_interrupt_isr (dev, ihre->source_id, ihre-=
>source_id));
+
         /* This workaround is due to HW/FW limitation on Hawaii that
          * VMID and PASID are not written into ih_ring_entry
          */
@@ -49,7 +55,6 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
                 *patched_flag =3D true;
                 *tmp_ihre =3D *ihre;

-               vmid =3D f2g->read_vmid_from_vmfault_reg(dev->kgd);
                 ret =3D f2g->get_atc_vmid_pasid_mapping_info(dev->kgd, vmi=
d, &pasid);

                 tmp_ihre->ring_id &=3D 0x000000ff;
@@ -95,6 +100,9 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
         if (pasid =3D=3D 0)
                 return;

+       if ((ihre->source_id =3D=3D VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONIT=
OR) && (vmid =3D=3D 0))
+               kfd_spm_interrupt_wq(dev, ihre->source_id);
+
         if (ihre->source_id =3D=3D CIK_INTSRC_CP_END_OF_PIPE)
                 kfd_signal_event_interrupt(pasid, context_id, 28);
         else if (ihre->source_id =3D=3D CIK_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index f8fa03a..bfc83beb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1732,6 +1732,20 @@ static int kfd_ioctl_import_dmabuf(struct file *file=
p,
         return r;
 }

+static int kfd_ioctl_rlc_spm(struct file *filep,
+                                  struct kfd_process *p, void *data)
+{
+       struct kfd_ioctl_spm_args *args =3D data;
+       int err;
+
+       err =3D kfd_rlc_spm(p,
+                       (void __user *)args,
+                        args->buf_size,
+                        args->op);
+
+       return err;
+}
+
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
         [_IOC_NR(ioctl)] =3D {.cmd =3D ioctl, .func =3D _func, .flags =3D =
_flags, \
                             .cmd_drv =3D 0, .name =3D #ioctl}
@@ -1827,6 +1841,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[]=
 =3D {

         AMDKFD_IOCTL_DEF(AMDKFD_IOC_ALLOC_QUEUE_GWS,
                         kfd_ioctl_alloc_queue_gws, 0),
+
+       AMDKFD_IOCTL_DEF(AMDKFD_IOC_RLC_SPM,
+                       kfd_ioctl_rlc_spm, 0),
 };

 #define AMDKFD_CORE_IOCTL_COUNT ARRAY_SIZE(amdkfd_ioctls)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index e05d75e..481f0ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -24,6 +24,7 @@
 #include "kfd_events.h"
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
+#include "ivsrcid/gfx/irqsrcs_gfx_9_0.h"

 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
                                         const uint32_t *ih_ring_entry,
@@ -35,12 +36,15 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,

         /* Only handle interrupts from KFD VMIDs */
         vmid =3D SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
+       source_id =3D SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+       client_id =3D SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
+       if ((source_id =3D=3D GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRU=
PT) && (vmid =3D=3D 0))
+                return (kfd_spm_interrupt_isr (dev, source_id, client_id))=
;
+
         if (vmid < dev->vm_info.first_vmid_kfd ||
             vmid > dev->vm_info.last_vmid_kfd)
                 return 0;

-       source_id =3D SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
-       client_id =3D SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
         pasid =3D SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);

         /* This is a known issue for gfx9. Under non HWS, pasid is not set
@@ -95,6 +99,9 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
         vmid =3D SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
         context_id =3D SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);

+       if ((source_id =3D=3D GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRU=
PT) && (vmid =3D=3D 0))
+               kfd_spm_interrupt_wq(dev, source_id);
+
         if (source_id =3D=3D SOC15_INTSRC_CP_END_OF_PIPE)
                 kfd_signal_event_interrupt(pasid, context_id, 32);
         else if (source_id =3D=3D SOC15_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index 43b888b..707d672 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -309,6 +309,9 @@ struct kfd_dev {

         /* Global GWS resource shared b/t processes*/
         void *gws;
+
+       /*spm process id */
+       unsigned int spm_pasid;
 };

 enum kfd_mempool {
@@ -740,6 +743,13 @@ struct kfd_process {
         struct kobject *kobj;
         struct kobject *kobj_queues;
         struct attribute attr_pasid;
+       /* spm data */
+       struct kfd_spm_cntr *spm_cntr;
+       bool is_spm_acquired;
+       /* Work items for tranfer data to user */
+       struct delayed_work copy_to_user_work;
+       /* spm-related data */
+       struct mutex spm_mutex;
 };

 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
@@ -1045,10 +1055,20 @@ int dbgdev_wave_reset_wavefronts(struct kfd_dev *de=
v, struct kfd_process *p);

 bool kfd_is_locked(void);

+void kfd_spm_init_process(struct kfd_process *p);
+int kfd_rlc_spm(struct kfd_process *p,  void __user *data,
+                      uint32_t buf_size, __u32 op);
+
 /* Compute profile */
 void kfd_inc_compute_active(struct kfd_dev *dev);
 void kfd_dec_compute_active(struct kfd_dev *dev);

+/* spm interrupt */
+bool kfd_spm_interrupt_isr(struct kfd_dev *dev,
+                                       uint16_t source_id,     uint32_t cl=
ient_id);
+void kfd_spm_interrupt_wq(struct kfd_dev *dev, uint16_t source_id);
+
+
 /* Cgroup Support */
 /* Check with device cgroup if @kfd device is accessible */
 static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index fe0cd49..338868d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -746,6 +746,7 @@ static struct kfd_process *create_process(const struct =
task_struct *thread)
         INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
         process->last_restore_timestamp =3D get_jiffies_64();
         kfd_event_init_process(process);
+       kfd_spm_init_process(process);
         process->is_32bit_user_mode =3D in_compat_syscall();

         process->pasid =3D kfd_pasid_alloc();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_spm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_spm.c
new file mode 100644
index 0000000..773e2ee
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_spm.c
@@ -0,0 +1,577 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/device.h>
+#include "kfd_priv.h"
+#include "amdgpu_amdkfd.h"
+#include "soc15_int.h"
+#include "ivsrcid/gfx/irqsrcs_gfx_9_0.h"
+#include "ivsrcid/ivsrcid_vislands30.h"
+#include <linux/delay.h>
+
+#define SAMPLING_MAX 4
+
+struct user_buf {
+        uint64_t __user *user_addr;
+        u32 ubufsize;
+
+};
+
+struct kfd_spm_cntr {
+        struct kgd_dev *kgd;
+        u64    spm_gpu_addr;
+        u32    spm_ring_buf_size;
+        u32    spm_ring_buf_mark;
+           u32     spm_ring_rptr;
+        u32    spm_ring_wptr;
+        u32    spm_ring_size_copied;
+        void   *spm_obj;
+        u32    *spm_cpu_addr;
+        struct user_buf ubuf [SAMPLING_MAX];
+        u32    buf_count;
+        bool   is_uesr_buf_filled;
+        bool   is_nowait;
+        struct task_struct *thread;
+        bool   thread_ready;
+        char   *name;
+        wait_queue_head_t spm_wq;
+        int    wanted_cluster;
+        bool   is_timeout;
+};
+
+static int kfd_spm_data_cocy (struct kfd_spm_cntr * spm_cntr, u32 size_to_=
copy)
+{
+        u32 user_buf_space_left;
+        int ret =3D 0;
+        u32 bufSize;
+        uint64_t __user * user_address;
+        uint64_t * ring_buf;
+
+        pr_debug("[%s]\n", __func__);
+
+        bufSize =3D spm_cntr->ubuf[0].ubufsize;
+        user_address =3D (uint64_t*)((uint64_t)spm_cntr->ubuf[0].user_addr=
 + spm_cntr->spm_ring_size_copied);
+        ring_buf =3D  (uint64_t*)((uint64_t)spm_cntr->spm_cpu_addr + spm_c=
ntr->spm_ring_rptr);
+
+        if (user_address =3D=3D NULL)
+               return -EFAULT;
+
+        user_buf_space_left =3D bufSize - spm_cntr->spm_ring_size_copied;
+
+        if (size_to_copy <=3D user_buf_space_left) {
+               ret =3D copy_to_user(user_address, ring_buf, size_to_copy);
+                 if (ret) {
+                 pr_err("copy_to_user failed, ret =3D %x\n", ret);
+                       return -EFAULT;
+                }
+               spm_cntr->spm_ring_size_copied +=3D size_to_copy;
+       } else {
+               size_to_copy =3D spm_cntr->spm_ring_buf_size - spm_cntr->sp=
m_ring_size_copied;
+               ret =3D copy_to_user(user_address, ring_buf, user_buf_space=
_left);
+               if (ret)
+                       return -EFAULT;
+
+               spm_cntr->spm_ring_size_copied =3D bufSize;
+               spm_cntr->is_uesr_buf_filled =3D true;
+       }
+
+       return ret;
+}
+
+static int kfd_spm_reag_ring_buf_polling (struct kfd_spm_cntr * spm_cntr, =
long timeout)
+{
+       u32 size_to_copy;
+       int ret =3D 0;
+
+       pr_info("[%s]\n", __func__);
+
+       while (spm_cntr->is_uesr_buf_filled !=3D true){
+               spm_cntr->spm_ring_rptr =3D amdgpu_amdkfd_rlc_spm_get_rdptr=
(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
+#if 1
+               spm_cntr->spm_ring_wptr =3D amdgpu_amdkfd_rlc_spm_get_wrptr=
(spm_cntr->kgd) & spm_cntr->spm_ring_buf_mark;
+#else
+               spm_cntr->spm_ring_wptr =3D spm_cntr->spm_cpu_addr[0] & spm=
_cntr->spm_ring_buf_mark;
+#endif
+
+               if ((spm_cntr->spm_ring_rptr >=3D 0) &&  (spm_cntr->spm_rin=
g_rptr  < 0x20))
+                               spm_cntr->spm_ring_rptr =3D 0x20;
+
+               if (spm_cntr->is_uesr_buf_filled =3D=3D true)
+                       goto exit;
+
+               if (spm_cntr->spm_ring_wptr > spm_cntr->spm_ring_rptr) {
+                       size_to_copy =3D spm_cntr->spm_ring_wptr - spm_cntr=
->spm_ring_rptr;
+                       ret =3D kfd_spm_data_cocy(spm_cntr, size_to_copy);
+               } else if (spm_cntr->spm_ring_wptr < spm_cntr->spm_ring_rpt=
r) {
+                       size_to_copy =3D spm_cntr->spm_ring_buf_size - spm_=
cntr->spm_ring_rptr;
+                       ret =3D kfd_spm_data_cocy(spm_cntr, size_to_copy);
+
+                       /* correct counter start point */
+                       spm_cntr->spm_ring_rptr =3D 0x20;
+                       size_to_copy =3D spm_cntr->spm_ring_wptr;
+                       ret =3D kfd_spm_data_cocy(spm_cntr, size_to_copy);
+               }
+
+               if (!ret) {
+                       if (spm_cntr->is_uesr_buf_filled =3D=3D true) {
+                               /* stop */
+                               amdgpu_amdkfd_rlc_spm_cntl(spm_cntr->kgd, 0=
);
+                               amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->k=
gd, 0);
+#if 0
+                               amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr->k=
gd, 0);
+#else
+                               spm_cntr->spm_cpu_addr[0]=3D 0;
+#endif
+                               return ret;
+                       } else
+                               amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->k=
gd, spm_cntr->spm_ring_wptr);
+
+                       if (spm_cntr->is_timeout =3D=3D true) {
+                               /* stop */
+                               amdgpu_amdkfd_rlc_spm_cntl(spm_cntr->kgd, 0=
);
+                               amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->k=
gd, 0);
+#if 0
+                               amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr->k=
gd, 0);
+#else
+                               spm_cntr->spm_cpu_addr[0]=3D 0;
+#endif
+                               break;
+                       }
+               }
+       }
+exit:
+       return ret;
+}
+
+static int kfd_spm_reag_ring_buf (struct kfd_spm_cntr * spm_cntr)
+{
+       u32 size_to_copy;
+       int ret =3D 0;
+
+       pr_debug("[%s]\n", __func__);
+
+       spm_cntr->spm_ring_rptr =3D amdgpu_amdkfd_rlc_spm_get_rdptr(spm_cnt=
r->kgd) & spm_cntr->spm_ring_buf_mark;
+#if 1
+       spm_cntr->spm_ring_wptr =3D amdgpu_amdkfd_rlc_spm_get_wrptr(spm_cnt=
r->kgd) & spm_cntr->spm_ring_buf_mark;
+#else
+       spm_cntr->spm_ring_wptr =3D spm_cntr->spm_cpu_addr[0] & spm_cntr->s=
pm_ring_buf_mark;
+#endif
+       if ((spm_cntr->spm_ring_rptr >=3D 0) &&  (spm_cntr->spm_ring_rptr  =
< 0x20)) {
+               spm_cntr->spm_ring_rptr =3D 0x20;
+       }
+
+       if (spm_cntr->is_uesr_buf_filled =3D=3D true)
+               goto exit;
+
+       if (spm_cntr->spm_ring_wptr > spm_cntr->spm_ring_rptr) {
+               size_to_copy =3D spm_cntr->spm_ring_wptr - spm_cntr->spm_ri=
ng_rptr;
+               ret =3D kfd_spm_data_cocy(spm_cntr, size_to_copy);
+
+       } else if (spm_cntr->spm_ring_wptr < spm_cntr->spm_ring_rptr) {
+               size_to_copy =3D spm_cntr->spm_ring_buf_size - spm_cntr->sp=
m_ring_rptr;
+               ret =3D kfd_spm_data_cocy(spm_cntr, size_to_copy);
+
+               spm_cntr->spm_ring_rptr =3D 0x20;
+               size_to_copy =3D spm_cntr->spm_ring_wptr;
+               ret =3D kfd_spm_data_cocy(spm_cntr, size_to_copy);
+       }
+               if (!ret) {
+                       if (spm_cntr->is_uesr_buf_filled =3D=3D true) {
+                               /* stop */
+                               amdgpu_amdkfd_rlc_spm_cntl(spm_cntr->kgd, 0=
);
+                               amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->k=
gd, 0);
+#if 0
+                               amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cntr->k=
gd, 0);
+#else
+                               spm_cntr->spm_cpu_addr[0]=3D 0;
+#endif
+                               return ret;
+                       } else
+                               amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cntr->k=
gd, spm_cntr->spm_ring_wptr);
+               }
+exit:
+       return ret;
+}
+
+static int kfd_spm_sched_main(void *param)
+{
+       struct kfd_spm_cntr * spm_cntr =3D (struct kfd_spm_cntr *)param;
+
+       while (!kthread_should_stop()) {
+               wait_event_interruptible(spm_cntr->spm_wq,
+                               spm_cntr->wanted_cluster !=3D false ||
+                               kthread_should_stop());
+
+               kfd_spm_reag_ring_buf (spm_cntr);
+
+               spm_cntr->wanted_cluster =3D false;
+       }
+       return 0;
+}
+
+static void transfer_data_process_worker(struct work_struct *work)
+{
+       struct kfd_process *p;
+       struct delayed_work *dwork;
+
+       pr_debug("[%s]\n", __func__);
+
+       dwork =3D to_delayed_work(work);
+
+       /* Process termination destroys this worker thread. So during the
+        * lifetime of this thread, kfd_process p will be valid
+        */
+       p =3D container_of(dwork, struct kfd_process, copy_to_user_work);
+
+       p->spm_cntr->is_timeout =3D true;
+}
+
+
+/**
+ * kfd_spm_init - init driver ring struct.
+ * Returns 0 on success, error on failure.
+ */
+int kfd_spm_shed_init(struct kfd_process *p, struct kgd_dev *kgd)
+{
+       int ret =3D 0;
+       init_waitqueue_head(&p->spm_cntr->spm_wq);
+       p->spm_cntr->wanted_cluster =3D false;
+       p->spm_cntr->kgd =3D kgd;
+       INIT_DELAYED_WORK(&p->copy_to_user_work, transfer_data_process_work=
er);
+
+       /* Each scheduler will run on a seperate kernel thread */
+       p->spm_cntr->thread =3D kthread_run(kfd_spm_sched_main, p->spm_cntr=
, p->spm_cntr->name);
+       if (IS_ERR(p->spm_cntr->thread)) {
+               ret =3D PTR_ERR(p->spm_cntr->thread);
+               p->spm_cntr->thread =3D NULL;
+               DRM_ERROR("Failed to create scheduler for %s.\n", p->spm_cn=
tr->name);
+               return ret;
+       }
+
+       p->spm_cntr->thread_ready =3D true;
+       return ret;
+}
+
+/**
+ * amdgpu_ring_fini - tear down the driver ring struct.
+ *
+ * @adev: amdgpu_device pointer
+ * @ring: amdgpu_ring structure holding ring information
+ *
+ * Tear down the driver information for the selected ring (all asics).
+ */
+void kfd_spm_shed_fini(struct kfd_process *p)
+{
+       if (p->spm_cntr->thread)
+               kthread_stop(p->spm_cntr->thread);
+
+       cancel_delayed_work_sync(&p->copy_to_user_work);
+       p->spm_cntr->thread =3D NULL;
+       p->spm_cntr->thread_ready =3D false;
+}
+
+void kfd_spm_init_process(struct kfd_process *p)
+{
+       mutex_init(&p->spm_mutex);
+       p->spm_cntr =3D NULL;
+       p->is_spm_acquired =3D false;
+}
+
+static struct kfd_spm_cntr *allocate_spm_cntr_data(void)
+{
+       struct kfd_spm_cntr *cntr;
+
+       cntr =3D kzalloc(sizeof(*cntr), GFP_KERNEL);
+       if (!cntr)
+               return NULL;
+
+       return cntr;
+}
+
+int kfd_acquire_spm(struct kfd_process *p, struct kgd_dev *kgd)
+{
+       int retval;
+       int count;
+
+       pr_debug("[%s]\n", __func__);
+
+       if(p->is_spm_acquired =3D=3D true)
+               return EINVAL;
+
+       if (!p->spm_cntr) {
+               p->spm_cntr =3D allocate_spm_cntr_data();
+               if (!p->spm_cntr)
+                       return -ENOMEM;
+               /* git spm ring buffer 128KB */
+               p->spm_cntr->spm_ring_buf_size =3D order_base_2(128 * 1024/=
4);
+               p->spm_cntr->spm_ring_buf_size =3D (1 << p->spm_cntr->spm_r=
ing_buf_size) * 4;
+               p->spm_cntr->spm_ring_buf_mark =3D p->spm_cntr->spm_ring_bu=
f_size -1;
+               for (count =3D 0; count < SAMPLING_MAX; ++count) {
+                       p->spm_cntr->ubuf[count].user_addr =3D NULL;
+                       p->spm_cntr->ubuf[count].ubufsize =3D 0;
+               }
+               p->spm_cntr->buf_count =3D 0;
+               p->spm_cntr->is_uesr_buf_filled =3D false;
+               p->spm_cntr->is_nowait =3D false;
+               p->spm_cntr->thread_ready =3D false;
+       }
+
+       retval =3D amdgpu_amdkfd_alloc_gtt_mem(kgd,
+                       p->spm_cntr->spm_ring_buf_size, &p->spm_cntr->spm_o=
bj,
+                       &p->spm_cntr->spm_gpu_addr, (void *)&p->spm_cntr->s=
pm_cpu_addr,
+                       false);
+
+       if (retval)
+               return EINVAL;
+
+       memset(p->spm_cntr->spm_cpu_addr, 0, p->spm_cntr->spm_ring_buf_size=
);
+
+       amdgpu_amdkfd_rlc_spm_acquire(kgd, p->spm_cntr->spm_gpu_addr, p->sp=
m_cntr->spm_ring_buf_size);
+
+       if (p->spm_cntr->thread_ready =3D=3D false) {
+               p->spm_cntr->name =3D "spm";
+               retval =3D kfd_spm_shed_init(p, kgd);
+               if (retval) {
+                       DRM_ERROR("Failed to create spm thread %s.\n",  p->=
spm_cntr->name);
+                       return retval;
+               }
+       }
+       p->is_spm_acquired =3D true;
+
+       return 0;
+}
+
+int kfd_release_spm(struct kfd_process *p, struct kgd_dev *kgd)
+{
+
+       kfd_spm_shed_fini(p);
+
+       amdgpu_amdkfd_free_gtt_mem(kgd, p->spm_cntr->spm_obj);
+
+       kfree(p->spm_cntr);
+       p->spm_cntr =3D NULL;
+       p->is_spm_acquired =3D false;
+
+       return 0;
+}
+
+int set_dest_buf_polling(struct kfd_spm_cntr *spm, struct kgd_dev *kgd, vo=
id __user *data)
+{
+       struct kfd_ioctl_spm_args __user *user_spm_data =3D
+                       (struct kfd_ioctl_spm_args __user *) data;
+       u32 i;
+       int ret =3D 0;
+       unsigned long timeout;
+
+       pr_debug ("[%s]\n", __func__);
+
+       timeout =3D msecs_to_jiffies(user_spm_data->timeout) + 1;
+
+       /* if buf =3D NULL, stop spm */
+       if (!user_spm_data->destptr) {
+               amdgpu_amdkfd_rlc_spm_cntl(kgd, 0);
+
+               user_spm_data->bytes_copied =3D spm->spm_ring_size_copied;
+               spm->spm_ring_size_copied =3D 0;
+               user_spm_data->spmtptr =3D (uint64_t)spm->ubuf[0].user_addr=
;
+
+               for (i =3D 0; i < spm->buf_count; ++i) {
+                       spm->ubuf [i] =3D spm->ubuf [i+1];
+               }
+               spm->ubuf[spm->buf_count].user_addr =3D NULL;
+               spm->ubuf[spm->buf_count].ubufsize =3D 0;
+               spm->buf_count --;
+               if (spm->buf_count < 0)
+                       spm->buf_count =3D 0;
+               return ret;
+       }
+
+       if (!spm->buf_count) {
+               /* First time save user spm buffer, then start spm sampling=
 */
+               spm->ubuf[0].user_addr =3D (uint64_t*)user_spm_data->destpt=
r;
+               spm->ubuf[0].ubufsize =3D user_spm_data->buf_size;
+               user_spm_data->bytes_copied =3D 0;
+               spm->spm_ring_size_copied =3D 0;
+               spm->buf_count ++;
+               spm->is_uesr_buf_filled =3D false;
+               amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);
+
+               ret =3D kfd_spm_reag_ring_buf_polling (spm, timeout);
+               user_spm_data->bytes_copied =3D spm->spm_ring_size_copied;
+               user_spm_data->spmtptr =3D (uint64_t)spm->ubuf[0].user_addr=
;
+               spm->buf_count --;
+       } else {
+               spm->spm_ring_size_copied =3D 0;
+               spm->is_uesr_buf_filled =3D false;
+               amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);
+               ret =3D kfd_spm_reag_ring_buf_polling (spm, timeout);
+
+               user_spm_data->bytes_copied =3D spm->spm_ring_size_copied;
+               user_spm_data->spmtptr =3D (uint64_t)spm->ubuf[0].user_addr=
;
+               spm->buf_count --;
+
+               for (i =3D 0; i < spm->buf_count; ++i)
+                       /* Repeated dest buf */
+                       if (spm->ubuf[i].user_addr =3D=3D (uint64_t*)user_s=
pm_data->destptr)
+                               break;
+               if (i =3D=3D spm->buf_count) {
+                       spm->ubuf[i].user_addr =3D (uint64_t*)user_spm_data=
->destptr;
+                       spm->ubuf[i].ubufsize =3D user_spm_data->buf_size;
+                       spm->buf_count ++;
+               }
+
+               for (i =3D 0; i < spm->buf_count; ++i)
+                       spm->ubuf[i] =3D spm->ubuf[i + 1];
+               spm->ubuf[spm->buf_count].user_addr  =3D NULL;
+       }
+
+       user_spm_data->bytes_copied =3D spm->spm_ring_size_copied;
+       return ret;
+
+}
+
+int kfd_set_dest_buffer(struct kfd_process *p, struct kgd_dev *kgd, void _=
_user *data)
+{
+       struct kfd_ioctl_spm_args __user *user_spm_data =3D
+                                                       (struct kfd_ioctl_s=
pm_args __user *) data;
+       struct kfd_spm_cntr *spm =3D p->spm_cntr;
+       unsigned long timeout;
+
+       pr_debug("[%s]\n", __func__);
+
+       if(p->is_spm_acquired =3D=3D false)
+               return -EINVAL;
+
+       timeout =3D msecs_to_jiffies(user_spm_data->timeout) + 1;
+       spm->is_timeout =3D false;
+       schedule_delayed_work(&p->copy_to_user_work, timeout);
+       return set_dest_buf_polling(spm, kgd, data);
+}
+
+int kfd_config_spm(struct kfd_process *p, struct kgd_dev *kgd,struct kfd_i=
octl_spm_args *data)
+{
+       struct kfd_ioctl_spm_args __user *user_spm_data =3D
+                       (struct kfd_ioctl_spm_args __user *) data;
+       struct kfd_spm_set_reg *spm_reg;
+
+       pr_debug("[%s]\n", __func__);
+
+       spm_reg =3D kvmalloc_array(1, sizeof (struct kfd_spm_set_reg), GFP_=
KERNEL);
+
+       if (copy_from_user(spm_reg, (void __user *)user_spm_data->destptr, =
sizeof (struct kfd_spm_set_reg))) {
+               pr_err("copy_from_user Fail\n");
+               goto exit;
+       }
+       amdgpu_amdkfd_rlc_spm_set_reg(kgd, spm_reg->reg, spm_reg->value);
+exit:
+       kfree(spm_reg);
+       return 0;
+}
+
+int kfd_rlc_spm(struct kfd_process *p,  void __user *data,
+                      uint32_t buf_size, __u32 operation)
+{
+       struct kfd_ioctl_spm_args *args =3D data;
+       struct kfd_dev *dev;
+       int r;
+
+       dev =3D kfd_device_by_id(args->gpu_id);
+       if (!dev)
+               return -EINVAL;
+
+
+       switch (operation) {
+       case KFD_IOCTL_SPM_OP_ACQUIRE:
+               dev->spm_pasid =3D p->pasid;
+               r =3D kfd_acquire_spm(p, dev->kgd);
+               break;
+
+       case KFD_IOCTL_SPM_OP_RELEASE:
+               r =3D kfd_release_spm(p, dev->kgd);
+                               break;
+
+       case KFD_IOCTL_SPM_OP_SET_DEST_BUF:
+               r =3D kfd_set_dest_buffer(p, dev->kgd, data);
+               break;
+
+       case KFD_IOCTL_SPM_OP_CONFIG:
+               r =3D kfd_config_spm(p, dev->kgd, args);
+                               break;
+
+       default:
+               r =3D -EINVAL;
+               break;
+       }
+       return r;
+}
+
+void kfd_spm_interrupt(unsigned int pasid)
+{
+
+       struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
+
+       if (!p) {
+               pr_info("kfd_spm_interrupt p =3D %p \n", p);
+               return; /* Presumably process exited. */
+       }
+
+       mutex_lock(&p->spm_mutex);
+
+       p->spm_cntr->wanted_cluster =3D true;
+       wake_up_interruptible(&p->spm_cntr->spm_wq);
+
+       mutex_unlock(&p->spm_mutex);
+
+       kfd_unref_process(p);
+}
+
+bool kfd_spm_interrupt_isr(struct kfd_dev *dev,
+                                       uint16_t source_id,     uint32_t cl=
ient_id)
+{
+       pr_debug("[%s]\n", __func__);
+
+       if (source_id !=3D GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT)
+               return 0;
+
+       /* Interrupt types we care about: various signals and faults.
+        * They will be forwarded to a work queue (see below).
+        */
+
+       return source_id =3D=3D GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTER=
RUPT ||
+               source_id =3D=3D VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR =
||
+               client_id =3D=3D AMDGPU_IRQ_CLIENTID_LEGACY ||
+               client_id =3D=3D SOC15_IH_CLIENTID_RLC;
+}
+
+void kfd_spm_interrupt_wq(struct kfd_dev *dev, uint16_t source_id)
+{
+       uint16_t pasid;
+
+       pr_debug("[%s]\n", __func__);
+
+       pasid =3D dev->spm_pasid;
+#if 0
+       if ((source_id =3D=3D GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRU=
PT) ||
+                               (source_id =3D=3D VISLANDS30_IV_SRCID_RLC_S=
TRM_PERF_MONITOR))
+               kfd_spm_interrupt(pasid);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/a=
mdkfd/soc15_int.h
index 0bc0b25..fb4ad60 100644
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h
+++ b/drivers/gpu/drm/amd/amdkfd/soc15_int.h
@@ -30,6 +30,7 @@
 #define SOC15_INTSRC_SQ_INTERRUPT_MSG   239
 #define SOC15_INTSRC_VMC_FAULT          0
 #define SOC15_INTSRC_SDMA_TRAP          224
+#define AMDGPU_IRQ_CLIENTID_LEGACY     0


 #define SOC15_CLIENT_ID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[0]) & 0xff=
)
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h
index 4f66764..f7cb7d4 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -442,6 +442,56 @@ struct kfd_ioctl_import_dmabuf_args {
         __u32 dmabuf_fd;        /* to KFD */
 };

+/**
+ * kfd_ioctl_spm_op - SPM ioctl operations
+ *
+ * @KFD_IOCTL_SPM_OP_ACQUIRE: acquire exclusive access to SPM
+ * @KFD_IOCTL_SPM_OP_RELEASE: release exclusive access to SPM
+ * @KFD_IOCTL_SPM_OP_SET_DEST_BUF: set or unset destination buffer for SPM=
 streaming
+ */
+enum kfd_ioctl_spm_op {
+       KFD_IOCTL_SPM_OP_ACQUIRE,
+       KFD_IOCTL_SPM_OP_RELEASE,
+       KFD_IOCTL_SPM_OP_SET_DEST_BUF,
+       KFD_IOCTL_SPM_OP_CONFIG
+};
+
+/* Don't wait for previous buffer to fill up */
+#define KFD_IOCTL_SPM_FLAG_POLLING 1
+
+/**
+ * kfd_ioctl_spm_args - Arguments for SPM ioctl
+ *
+ * @op:     specifies the operation to perform
+ * @destptr:used for the address of the destination buffer in @KFD_IOCTL_S=
PM_SET_DEST_BUFFER
+ * @buf_size:size  of the destination buffer in @KFD_IOCTL_SPM_SET_DEST_BU=
FFER
+ * @timeout: timeout to wait buffer get filled
+ * @gpu_id: gpi ID
+ * @bytes_copied: byte copied from streaming performance ring buffer
+ *
+ * If @ptr is NULL, the destination buffer address is unset and copying of=
 counters
+ * is stopped.
+ *
+ * Returns negative error code on failure. On success, @KFD_IOCTL_SPM_OP_A=
CQUIRE and
+ * @KFD_IOCTL_SPM_OP_RELEASE return 0, @KFD_IOCTL_SPM_OP_SET_DEST_BUF retu=
rns the fill
+ * level of the previous buffer.
+ */
+struct kfd_ioctl_spm_args {
+       __u64 destptr;
+       __u64 spmtptr;
+       __u32 buf_size;
+       __u32 op;
+       __u32 timeout;
+       __u32 gpu_id;   /* to KFD */
+       /* from KFD: Total amount of bytes copied */
+       __u64 bytes_copied;
+};
+
+struct kfd_spm_set_reg {
+       __u64 reg;              /* to KFD */
+       __u32 value;
+};
+
 /* Register offset inside the remapped mmio page
  */
 enum kfd_mmio_remap {
@@ -546,7 +596,10 @@ enum kfd_mmio_remap {
 #define AMDKFD_IOC_ALLOC_QUEUE_GWS              \
                 AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_args)

+#define AMDKFD_IOC_RLC_SPM             \
+               AMDKFD_IOWR(0x1F, struct kfd_ioctl_spm_args)
+
 #define AMDKFD_COMMAND_START            0x01
-#define AMDKFD_COMMAND_END             0x1F
+#define AMDKFD_COMMAND_END             0x20

 #endif
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cyong.zha=
o%40amd.com%7C326c22b09293444c1a3f08d7eb7c3c2b%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637236791554300056&amp;sdata=3D70Ud36avjI1hPHwGX0Enfo8YiRo=
kubqepxdL3HLsocU%3D&amp;reserved=3D0

--_000_DM6PR12MB44826ACFD413B62FEBB5F202F0AD0DM6PR12MB4482namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I spotted two cosmetic issues when browsing it. see them inline [yz].</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Gang Ba &lt;gaba@amd.com&gt;<=
br>
<b>Sent:</b> Tuesday, April 28, 2020 9:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH] drm/amd: add Streaming Performance Monitor feature<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Signed-off-by: Gang Ba &lt;gaba@amperd.com&gt;<br>
Change-Id: If83ee0a14ef834699de6733eeab0f140159bbd6e<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 &#=
43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp; 10 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c | 165 &#43;&#43;&#=
43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 27 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 175 &#43;&#43;&#43;&#43;&#43;&#=
43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 176 &#43;&#43;&#43;&#43;&#=
43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 168 &#43;&#43;&#43;&#43;&#=
43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 &#=
43;-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c&nbsp;&nbsp; |&nbsp; =
10 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c&nbsp;&nbsp;&nbsp; |&n=
bsp; 11 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_spm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 577 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/soc15_int.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 &#43;<br>
&nbsp;include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 55 &#43;-<br>
&nbsp;16 files changed, 1413 insertions(&#43;), 6 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c=
<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_spm.c<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile<br>
index 210d57a..1498b18 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
@@ -177,7 &#43;177,8 @@ amdgpu-y &#43;=3D \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gfx_v8=
.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gfx_v9=
.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_arctur=
us.o \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gfx_v10.o<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gfx_v10.o \<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm.o \<b=
r>
&nbsp;<br>
&nbsp;ifneq ($(CONFIG_DRM_AMDGPU_CIK),)<br>
&nbsp;amdgpu-y &#43;=3D amdgpu_amdkfd_gfx_v7.o<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.h<br>
index d065c50..fdc438a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h<br>
@@ -246,6 &#43;246,16 @@ void amdgpu_amdkfd_unreserve_memory_limit(struct a=
mdgpu_bo *bo);<br>
&nbsp;int amdgpu_amdkfd_get_tile_config(struct kgd_dev *kgd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct tile_config *config);<br>
&nbsp;<br>
&#43;void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl);<br>
&#43;int amdgpu_amdkfd_rlc_spm(struct kgd_dev *kgd, void *args);<br>
&#43;void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, =
u32 size);<br>
&#43;int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd);<br>
&#43;u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd);<br>
&#43;void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr);<b=
r>
&#43;u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd);<br>
&#43;void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr);<b=
r>
&#43;int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 v=
alue);<br>
&#43;<br>
&nbsp;/* KGD2KFD callbacks */<br>
&nbsp;int kgd2kfd_init(void);<br>
&nbsp;void kgd2kfd_exit(void);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c<br>
new file mode 100644<br>
index 0000000..b492c1e<br>
--- /dev/null<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_rlc_spm.c<br>
@@ -0,0 &#43;1,165 @@<br>
&#43;/*<br>
&#43; * Copyright 2014-2020 Advanced Micro Devices, Inc.<br>
&#43; *<br>
&#43; * Permission is hereby granted, free of charge, to any person obtaini=
ng a<br>
&#43; * copy of this software and associated documentation files (the &quot=
;Software&quot;),<br>
&#43; * to deal in the Software without restriction, including without limi=
tation<br>
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>
&#43; * and/or sell copies of the Software, and to permit persons to whom t=
he<br>
&#43; * Software is furnished to do so, subject to the following conditions=
:<br>
&#43; *<br>
&#43; * The above copyright notice and this permission notice shall be incl=
uded in<br>
&#43; * all copies or substantial portions of the Software.<br>
&#43; *<br>
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS OR<br>
&#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,<br>
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO E=
VENT SHALL<br>
&#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR<br>
&#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,<br>
&#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR<br>
&#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&#43; */<br>
&#43;<br>
&#43;#include &lt;linux/dma-buf.h&gt;<br>
&#43;#include &lt;linux/list.h&gt;<br>
&#43;#include &lt;linux/pagemap.h&gt;<br>
&#43;#include &lt;linux/sched/mm.h&gt;<br>
&#43;#include &lt;linux/sched/task.h&gt;<br>
&#43;<br>
&#43;#include &quot;amdgpu_object.h&quot;<br>
&#43;#include &quot;amdgpu_vm.h&quot;<br>
&#43;#include &quot;amdgpu_amdkfd.h&quot;<br>
&#43;#include &lt;uapi/linux/kfd_ioctl.h&gt;<br>
&#43;<br>
&#43;<br>
&#43;<br>
&#43;void amdgpu_amdkfd_rlc_spm_cntl(struct kgd_dev *kgd, bool cntl)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kgd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_spm *spm =3D =
&amp;adev-&gt;gfx.spm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_rin=
g =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx=
.kiq.ring_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(kiq_ring,=
 spm-&gt;spmf-&gt;get_spm_data_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cntl =3D=3D true ? adev-&gt=
;gfx.spm.spmf-&gt;start(adev):adev-&gt;gfx.spm.spmf-&gt;stop(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(kiq_ring=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;g=
fx.kiq.ring_lock);<br>
&#43;}<br>
&#43;<br>
&#43;u32 amdgpu_amdkfd_rlc_spm_get_rdptr(struct kgd_dev *kgd)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kgd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_spm *spm =3D =
&amp;adev-&gt;gfx.spm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_rin=
g =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rptr =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx=
.kiq.ring_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(kiq_ring,=
 spm-&gt;spmf-&gt;get_spm_data_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rptr =3D adev-&gt;gfx.spm.s=
pmf-&gt;get_rdptr(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(kiq_ring=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;g=
fx.kiq.ring_lock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rptr;<br>
&#43;}<br>
&#43;<br>
&#43;void amdgpu_amdkfd_rlc_spm_set_rdptr(struct kgd_dev *kgd, u32 rptr)<br=
>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kgd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_spm *spm =3D =
&amp;adev-&gt;gfx.spm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_rin=
g =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx=
.kiq.ring_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(kiq_ring,=
 spm-&gt;spmf-&gt;get_spm_data_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm.spmf-&gt;s=
et_rdptr(adev, rptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(kiq_ring=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;g=
fx.kiq.ring_lock);<br>
&#43;<br>
&#43;}<br>
&#43;<br>
&#43;u32 amdgpu_amdkfd_rlc_spm_get_wrptr(struct kgd_dev *kgd)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kgd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_spm *spm =3D =
&amp;adev-&gt;gfx.spm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_rin=
g =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 wptr;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx=
.kiq.ring_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(kiq_ring,=
 spm-&gt;spmf-&gt;get_spm_data_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr =3D adev-&gt;gfx.spm.s=
pmf-&gt;get_wrptr(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(kiq_ring=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;g=
fx.kiq.ring_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return wptr;<br>
&#43;}<br>
&#43;<br>
&#43;void amdgpu_amdkfd_rlc_spm_set_wrptr(struct kgd_dev *kgd, u32 wptr)<br=
>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kgd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_spm *spm =3D =
&amp;adev-&gt;gfx.spm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_rin=
g =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx=
.kiq.ring_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(kiq_ring,=
 spm-&gt;spmf-&gt;get_spm_data_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm.spmf-&gt;s=
et_wrptr(adev, wptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(kiq_ring=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;g=
fx.kiq.ring_lock);<br>
&#43;}<br>
&#43;<br>
&#43;void amdgpu_amdkfd_rlc_spm_acquire(struct kgd_dev *kgd, u64 gpu_addr, =
u32 size)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kgd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_spm *spm =3D =
&amp;adev-&gt;gfx.spm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_rin=
g =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* init spm vmid with 0xf *=
/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-=
&gt;update_spm_vmid)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0x0);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set spm ring registers *=
/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx=
.kiq.ring_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(kiq_ring,=
 spm-&gt;spmf-&gt;get_spm_data_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm.spmf-&gt;s=
et_spm_porfmon_ring_buf(adev, gpu_addr, size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(kiq_ring=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;g=
fx.kiq.ring_lock);<br>
&#43;}<br>
&#43;<br>
&#43;<br>
&#43;int amdgpu_amdkfd_rlc_spm_release(struct kgd_dev *kgd)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kgd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_rin=
g =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_spm *spm =3D =
&amp;adev-&gt;gfx.spm;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stop spm stream and inte=
rupt */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx=
.kiq.ring_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(kiq_ring,=
 spm-&gt;spmf-&gt;get_spm_data_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm.spmf-&gt;s=
top(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(kiq_ring=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;g=
fx.kiq.ring_lock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;a=
dev-&gt;gfx.spm_irq, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* revert spm vmid with 0xf=
 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.funcs-=
&gt;update_spm_vmid)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid(adev, 0xf);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;int amdgpu_amdkfd_rlc_spm_set_reg(struct kgd_dev *kgd, u64 uReg, u32 v=
alue)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D (struct amdgpu_device *)kgd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_rin=
g =3D &amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_spm *spm =3D =
&amp;adev-&gt;gfx.spm;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[%s]\n&quot;=
, __func__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stop spm stream and inte=
rupt */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx=
.kiq.ring_lock);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_alloc(kiq_ring,=
 spm-&gt;spmf-&gt;get_spm_data_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm.spmf-&gt;s=
et_reg(adev, uReg, value);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_commit(kiq_ring=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;g=
fx.kiq.ring_lock);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h<br>
index ee698f0..ba4da52 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
@@ -105,6 &#43;105,31 @@ struct amdgpu_kiq {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct kiq_pm4_funcs=
 *pmf;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;struct spm_funcs {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*start)(struct amdgpu_devic=
e *adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*stop)(struct amdgpu_device=
 *adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_reg)(struct amdgpu_dev=
ice *adev, uint64_t reg, uint32_t val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_rdptr)(struct amdgpu_de=
vice *adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_rdptr)(struct amdgpu_d=
evice *adev, u32 rptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_wrptr)(struct amdgpu_de=
vice *adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_wrptr)(struct amdgpu_d=
evice *adev, u32 wptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_spm_porfmon_ring_buf)(=
struct amdgpu_device *adev, u64 gpu_rptr, u32 size);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Packet sizes */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int set_spm_config_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int get_spm_data_size;<br>
&#43;};<br>
&#43;<br>
&#43;struct amdgpu_spm {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct spm_funcs *spmf;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_gpu_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_gpu_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_ring_rptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_ring_rptrsize_to_read;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *spm_obj;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *spm_cpu_addr;<br>
&#43;};<br>
&#43;<br>
&nbsp;/*<br>
&nbsp; * GPU scratch registers structures, functions &amp; helpers<br>
&nbsp; */<br>
@@ -256,6 &#43;281,7 @@ struct amdgpu_gfx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_me&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; me;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_mec&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 mec;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 kiq;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_spm&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_scratch&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scratch;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct firmware&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *me_fw; /* ME firmw=
are */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me_fw_version;<br>
@@ -292,6 &#43;318,7 @@ struct amdgpu_gfx {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv_reg_irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv_inst_irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cp_ecc_error_irq;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sq_irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sq_work&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; sq_work;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c<br>
index 63ac430..9c507d2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
@@ -4121,6 &#43;4121,13 @@ static int gfx_v10_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* KIQ SPM */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC=
15_IH_CLIENTID_RLC,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; GFX_10_1__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.spm_irq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* EOP Event */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC15_IH_CLIENTID_GRBM_CP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFX_10_1__SRCID__CP_EOP_INTERRUPT,<br>
@@ -6603,6 &#43;6610,7 @@ static int gfx_v10_0_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&g=
t;gfx.spm_irq, 0);<br>
&nbsp;#ifndef BRING_UP_DEBUG<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_async_gfx_ring)=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D gfx_v10_0_kiq_disable_kgq(adev);<br>
@@ -6768,6 &#43;6776,126 @@ static void gfx_v10_0_ring_emit_gds_switch(stru=
ct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&=
lt; (oa_size &#43; oa_base)) - (1 &lt;&lt; oa_base));<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void gfx_v10_0_spm_start(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 se;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (se =3D 0; se &lt; adev-&gt;g=
fx.config.max_shader_engines &#43; 1; &#43;&#43;se)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t mux_addr_reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_=
GLOBAL_MUXSEL_ADDR);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INSTANCE_BRO=
ADCAST_WRITES, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SA_BROADCAST=
_WRITES, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SE_BROADCAST=
_WRITES, 1);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (se &lt; adev-&gt;gfx.config.max_shader_engines) // SE el=
se GB<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mux_addr_reg=
 =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SE_MUXSEL_ADDR);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OF=
FSET(GC, 0, mmGRBM_GFX_INDEX), data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg=
, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM=
_GFX_INDEX, SE_INDEX, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM=
_GFX_INDEX, SE_BROADCAST_WRITES, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D CP_PERFMON_STATE_DISABL=
E_AND_RESET &lt;&lt;4 ;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D STRM_PERFMON_STATE_STAR=
T_COUNTING &lt;&lt;4 ;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL) ,1);<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v10_0_spm_stop(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CP_PERFMON_STATE_STOP_CO=
UNTING;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (1&lt;&lt;10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 0);<br>
&#43;}<br>
&#43;<br>
&#43;static u32 gfx_v10_0_spm_get_rdptr(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(GC, 0, mmRLC_=
SPM_RING_RDPTR);;<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v10_0_spm_set_rdptr(struct amdgpu_device *adev,&nbsp; =
u32 rptr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);<br>
&#43;}<br>
&#43;<br>
&#43;static u32 gfx_v10_0_spm_get_wrptr(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(GC, 0, mmRLC_=
SPM_RING_WRPTR);<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v10_0_spm_set_wrptr(struct amdgpu_device *adev,&nbsp; =
u32 wptr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_WRPTR), wptr);<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v10_0_set_spm_porfmon_ring_buf(struct amdgpu_device *a=
dev, u64 gpu_addr, u32 size)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, SOC15_REG_OFFSET(GC, 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_SPM_PE=
RFMON_RING_BASE_LO), lower_32_bits(gpu_addr));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OF=
FSET(GC, 0, mmRLC_SPM_PERFMON_RING_BASE_HI), upper_32_bits (gpu_addr));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OF=
FSET(GC, 0, mmRLC_SPM_PERFMON_RING_SIZE), size);<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v10_0_spm_set_reg(struct amdgpu_device *adev, u64 reg,=
 u32 value)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t grbm_cntl;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_cntl =3D adev-&gt;reg_offset=
[GC_HWIP][0][1] &#43; reg;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_write_data_to_reg(kiq_r=
ing, 0, false, grbm_cntl, value);<br>
&#43;}<br>
&#43;<br>
&#43;static const struct spm_funcs gfx_v10_0_spm_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v10_0_spm_start,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v10_0_spm_stop,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_rdptr=3D gfx_v10_0_spm_get_r=
dptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_rdptr=3D gfx_v10_0_spm_set_r=
dptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wrptr=3D gfx_v10_0_spm_get_w=
rptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wrptr=3D gfx_v10_0_spm_set_w=
rptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_spm_porfmon_ring_buf =3D gfx=
_v10_0_set_spm_porfmon_ring_buf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_reg =3D gfx_v10_0_spm_set_re=
g,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_spm_config_size =3D 3,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_spm_data_size =3D 128,<br>
&#43;};<br>
&#43;<br>
&#43;static void gfx_v10_0_set_spm_funcs(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm.spmf =3D &amp;gf=
x_v10_0_spm_funcs;<br>
&#43;}<br>
&#43;<br>
&#43;<br>
&nbsp;static int gfx_v10_0_early_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
@@ -6776,6 &#43;6904,7 @@ static int gfx_v10_0_early_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_compute_r=
ings =3D AMDGPU_MAX_COMPUTE_RINGS;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_set_spm_funcs(adev);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_set_kiq_pm4_func=
s(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_set_ring_funcs(a=
dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v10_0_set_irq_funcs(ad=
ev);<br>
@@ -6794,6 &#43;6923,10 @@ static int gfx_v10_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, =
&amp;adev-&gt;gfx.spm_irq, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev,=
 &amp;adev-&gt;gfx.priv_inst_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -6860,6 &#43;6993,7 @@ static void gfx_v10_0_update_medium_grain_clock_g=
ating(struct amdgpu_device *ade<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (def !=3D data)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG3=
2_SOC15(GC, 0, mmRLC_CGTT_MGCG_OVERRIDE, data);<br>
&nbsp;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* MGLS is a global flag to control all MGLS in GFX *=
/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_GFX_MGLS) =
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* 2 =
- RLC memory Light sleep */<br>
@@ -8018,6 &#43;8152,39 @@ static void gfx_v10_0_emit_mem_sync(struct amdgp=
u_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, gc=
r_cntl); /* GCR_CNTL */<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int gfx_v10_0_spm_set_interrupt_state(struct amdgpu_device *ade=
v,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *src,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int type,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<b=
r>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_INT_CNTL, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int gfx_v10_0_spm_irq(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 me_id, pipe_id, queue_id;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me_id =3D (entry-&gt;ring_id &amp=
; 0x0c) &gt;&gt; 2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_id =3D (entry-&gt;ring_id &a=
mp; 0x03) &gt;&gt; 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id =3D (entry-&gt;ring_id &=
amp; 0x70) &gt;&gt; 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug (&quot;IH: RLC_RPM_INT, =
me:%d, pipe:%d, queue:%d\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; me_id, pipe_id, queue_id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return&nbsp; 0; /* This prevents =
sending it to KFD */<br>
&#43;}<br>
&#43;<br>
&#43;<br>
&nbsp;static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;gfx_v10_0&=
quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D gfx_v10_0_=
early_init,<br>
@@ -8189,6 &#43;8356,11 @@ static const struct amdgpu_irq_src_funcs gfx_v10=
_0_kiq_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v10_0_kiq=
_irq,<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static const struct amdgpu_irq_src_funcs gfx_v10_0_spm_irq_funcs =3D {=
<br>
&#43;&nbsp;&nbsp;&nbsp; .set =3D gfx_v10_0_spm_set_interrupt_state,<br>
&#43;&nbsp;&nbsp;&nbsp; .process =3D gfx_v10_0_spm_irq,<br>
&#43;};<br>
&#43;<br>
&nbsp;static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.eop_irq.num_t=
ypes =3D AMDGPU_CP_IRQ_LAST;<br>
@@ -8197,6 &#43;8369,9 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu=
_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq.irq.num_t=
ypes =3D AMDGPU_CP_KIQ_IRQ_LAST;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.kiq.irq.funcs=
 =3D &amp;gfx_v10_0_kiq_irq_funcs;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm_irq.num_types =
=3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm_irq.funcs =3D &a=
mp;gfx_v10_0_spm_irq_funcs;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v10_0_priv_reg_irq_funcs;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 14790f8..1125b91 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -1955,6 &#43;1955,12 @@ static int gfx_v8_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_pipe_=
per_mec =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_queue=
_per_pipe =3D 8;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* KIQ SPM */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, AMD=
GPU_IRQ_CLIENTID_LEGACY, VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.spm_irq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* EOP Event */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, AMDGPU_IRQ_CLIENTID_LEGACY, VISLANDS30_IV_SRCID_CP_END_OF_PIPE, &amp;ad=
ev-&gt;gfx.eop_irq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
@@ -4927,6 &#43;4933,7 @@ static int gfx_v8_0_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.cp_ecc_error_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.sq_irq, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&g=
t;gfx.spm_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable KCQ to avoid CP=
C touch memory not valid anymore */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_kcq_disable(adev)=
;<br>
@@ -5291,6 &#43;5298,126 @@ static const struct amdgpu_gfx_funcs gfx_v8_0_g=
fx_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .select_me_pipe_q =3D &amp=
;gfx_v8_0_select_me_pipe_q<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static void gfx_v8_0_write_data_to_reg(struct amdgpu_ring *ring, int e=
ng_sel,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; bool wc, uint32_t reg, uint32_t val)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(P=
ACKET3_WRITE_DATA, 3));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, WRITE_DAT=
A_ENGINE_SEL(eng_sel) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_DATA_DST_SEL(0) |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (wc ? WR_CONFIRM : 0));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, val);<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v8_0_spm_start(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 se;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (se =3D 0; se &lt; adev-&gt;g=
fx.config.max_shader_engines &#43; 1; &#43;&#43;se)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t mux_addr_reg =3D mmRLC_SPM_GLOBAL_MUXSEL_ADDR;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INSTANCE_BRO=
ADCAST_WRITES, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SH_BROADCAST=
_WRITES, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SE_BROADCAST=
_WRITES, 1);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (se &lt; adev-&gt;gfx.config.max_shader_engines) // SE el=
se GB<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mux_addr_reg=
 =3D mmRLC_SPM_SE_MUXSEL_ADDR;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mmGRBM_GFX_IN=
DEX, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; // init addr<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg,=
 data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM=
_GFX_INDEX, SE_INDEX, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM=
_GFX_INDEX, SE_BROADCAST_WRITES, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmGRBM_GFX_INDEX, data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D CP_PERFMON_STATE_DISABL=
E_AND_RESET &lt;&lt;4 ;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmCP_PERFMON_CNTL, data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D STRM_PERFMON_STATE_STAR=
T_COUNTING &lt;&lt;4 ;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmCP_PERFMON_CNTL,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data);=
</div>
<div class=3D"PlainText">[yz] unnecessary spaces here<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmRLC_SPM_INT_CNTL ,1);<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v8_0_spm_stop(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CP_PERFMON_STATE_STOP_CO=
UNTING;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmCP_PERFMON_CNTL, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (1&lt;&lt;10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmCP_PERFMON_CNTL, data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmRLC_SPM_INT_CNTL, 0);<br>
&#43;}<br>
&#43;<br>
&#43;<br>
&#43;static u32 gfx_v8_0_spm_get_rdptr(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32 (mmRLC_SPM_RING_RDP=
TR);<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v8_0_spm_set_rdptr(struct amdgpu_device *adev,&nbsp; u=
32 rptr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmRLC_SPM_RING_RDPTR, rptr);<br>
&#43;}<br>
&#43;<br>
&#43;static u32 gfx_v8_0_spm_get_wrptr(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return&nbsp; -1;<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v8_0_set_spm_porfmon_ring_buf(struct amdgpu_device *ad=
ev, u64 gpu_addr, u32 size)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmRLC_SPM_PERFMON_RING_BASE_LO, lower_32_bits(gpu_addr));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmRLC_SPM_PERFMON_RING_BASE_HI, upper_32_bits (gpu_addr));<br=
>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, mmRLC_SPM_PERFMON_RING_SIZE, size);<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v8_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, =
u32 value)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_write_data_to_reg(kiq_ri=
ng, 0, false, reg, value);<br>
&#43;}<br>
&#43;<br>
&#43;static const struct spm_funcs gfx_v8_0_spm_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v8_0_spm_start,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v8_0_spm_stop,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_rdptr=3D gfx_v8_0_spm_get_rd=
ptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_rdptr=3D gfx_v8_0_spm_set_rd=
ptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wrptr=3D gfx_v8_0_spm_get_wr=
ptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_spm_porfmon_ring_buf =3D gfx=
_v8_0_set_spm_porfmon_ring_buf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_reg =3D gfx_v8_0_spm_set_reg=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_spm_config_size =3D 3,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_spm_data_size =3D 128,<br>
&#43;};<br>
&#43;<br>
&#43;static void gfx_v8_0_set_spm_funcs(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm.spmf =3D &amp;gf=
x_v8_0_spm_funcs;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int gfx_v8_0_early_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
@@ -5298,6 &#43;5425,8 @@ static int gfx_v8_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings=
 =3D GFX8_NUM_GFX_RINGS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_compute_r=
ings =3D AMDGPU_MAX_COMPUTE_RINGS;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.funcs =3D &am=
p;gfx_v8_0_gfx_funcs;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_set_spm_funcs(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_set_ring_funcs(ad=
ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_set_irq_funcs(ade=
v);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_set_gds_init(adev=
);<br>
@@ -5338,6 &#43;5467,10 @@ static int gfx_v8_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;a=
dev-&gt;gfx.spm_irq, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -6845,6 &#43;6978,41 @@ static void gfx_v8_0_emit_mem_sync_compute(struc=
t amdgpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x=
0000000A);&nbsp;&nbsp;&nbsp; /* poll interval */<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int gfx_v8_0_spm_set_interrupt_state(struct amdgpu_device *adev=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *src,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int type,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<b=
r>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmRLC_SPM_INT_CNTL, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmRLC_SPM_INT_CNTL, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int gfx_v8_0_spm_irq(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 me_id, pipe_id, queue_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp=
;(adev-&gt;gfx.kiq.ring);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me_id =3D (entry-&gt;ring_id &amp=
; 0x0c) &gt;&gt; 2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_id =3D (entry-&gt;ring_id &a=
mp; 0x03) &gt;&gt; 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id =3D (entry-&gt;ring_id &=
amp; 0x70) &gt;&gt; 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;IH: RLC_RPM_INT, m=
e:%d, pipe:%d, queue:%d\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me_id, pipe_=
id, queue_id);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_process(ring);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct amd_ip_funcs gfx_v8_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;gfx_v8_0&q=
uot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D gfx_v8_0_e=
arly_init,<br>
@@ -7005,11 &#43;7173,19 @@ static const struct amdgpu_irq_src_funcs gfx_v8=
_0_sq_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v8_0_sq_i=
rq,<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static const struct amdgpu_irq_src_funcs gfx_v8_0_spm_irq_funcs =3D {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v8_0_spm_set_interru=
pt_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v8_0_spm_irq,<br=
>
&#43;};<br>
&#43;<br>
&nbsp;static void gfx_v8_0_set_irq_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.eop_irq.num_t=
ypes =3D AMDGPU_CP_IRQ_LAST;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.eop_irq.funcs=
 =3D &amp;gfx_v8_0_eop_irq_funcs;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm_irq.num_types =
=3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm_irq.funcs =3D &a=
mp;gfx_v8_0_spm_irq_funcs;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v8_0_priv_reg_irq_funcs;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 2767c6d..bfde274 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -2249,6 &#43;2249,13 @@ static int gfx_v9_0_sw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_pipe_=
per_mec =3D 4;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.num_queue=
_per_pipe =3D 8;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* KIQ SPM */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC=
15_IH_CLIENTID_RLC,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; GFX_9_0__SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.spm_irq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* EOP Event */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(ad=
ev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &amp;adev-=
&gt;gfx.eop_irq);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
@@ -3907,6 &#43;3914,7 @@ static int gfx_v9_0_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.cp_ecc_error_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_reg_irq, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;adev-&g=
t;gfx.spm_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_put(adev, &amp;=
adev-&gt;gfx.priv_inst_irq, 0);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DF freeze and kcq disab=
le will fail */<br>
@@ -4617,6 &#43;4625,121 @@ static int gfx_v9_0_do_edc_gpr_workarounds(stru=
ct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void gfx_v9_0_spm_start(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 se;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (se =3D 0; se &lt; adev-&gt;g=
fx.config.max_shader_engines &#43; 1; &#43;&#43;se)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t mux_addr_reg =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_=
GLOBAL_MUXSEL_ADDR);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INSTANCE_BRO=
ADCAST_WRITES, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SH_BROADCAST=
_WRITES, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM_GFX_INDEX,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SE_BROADCAST=
_WRITES, 1);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (se &lt; adev-&gt;gfx.config.max_shader_engines) // SE el=
se GB<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG=
_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mux_addr_reg=
 =3D SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_SE_MUXSEL_ADDR);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, SOC15_REG_OFF=
SET(GC, 0, mmGRBM_GFX_INDEX), data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; // init addr<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ring, 0, false, mux_addr_reg,=
 data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM=
_GFX_INDEX, SE_INDEX, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FIELD(data, GRBM=
_GFX_INDEX, SE_BROADCAST_WRITES, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D CP_PERFMON_STATE_DISABL=
E_AND_RESET &lt;&lt;4 ;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D STRM_PERFMON_STATE_STAR=
T_COUNTING &lt;&lt;4 ;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL) ,1);<br>
&#43;}<br>
&#43;<br>
&#43;<br>
&#43;static void gfx_v9_0_spm_stop(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data =3D 0;<br>
&#43;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D CP_PERFMON_STATE_STOP_CO=
UNTING;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (1&lt;&lt;10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, SOC15_REG_OFFSET(GC, 0, mmCP_PERFMON_CNTL), data);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_INT_CNTL), 0);<br>
&#43;}<br>
&#43;<br>
&#43;static u32 gfx_v9_0_spm_get_rdptr(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return RREG32_SOC15(GC, 0, mmRLC_=
SPM_RING_RDPTR);;<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v9_0_spm_set_rdptr(struct amdgpu_device *adev,&nbsp; u=
32 rptr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_RING_RDPTR), rptr);<br>
&#43;}<br>
&#43;<br>
&#43;static u32 gfx_v9_0_spm_get_wrptr(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1;<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v9_0_set_spm_porfmon_ring_buf(struct amdgpu_device *ad=
ev, u64 gpu_addr, u32 size)</div>
<div class=3D"PlainText">[yz]&nbsp;<span style=3D"font-family: &quot;Segoe =
UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -=
apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-=
serif; background-color: rgb(255, 255, 255); display: inline !important">po=
rfmon
 -&gt; perfmon</span><br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, SOC15_REG_OFFSET(GC, 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmRLC_SPM_PERFMON_RING_BASE_LO), lower_=
32_bits(gpu_addr));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFM=
ON_RING_BASE_HI), upper_32_bits (gpu_addr));<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_PERFM=
ON_RING_SIZE), size);<br>
&#43;}<br>
&#43;<br>
&#43;static void gfx_v9_0_spm_set_reg(struct amdgpu_device *adev, u64 reg, =
u32 value)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ring =3D =
&amp;adev-&gt;gfx.kiq.ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t grbm_cntl;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grbm_cntl =3D adev-&gt;reg_offset=
[GC_HWIP][0][1] &#43; reg;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg(kiq_ri=
ng, 0, false, grbm_cntl, value);<br>
&#43;}<br>
&#43;<br>
&#43;static const struct spm_funcs gfx_v9_0_spm_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v9_0_spm_start,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v9_0_spm_stop,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_rdptr=3D gfx_v9_0_spm_get_rd=
ptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_rdptr=3D gfx_v9_0_spm_set_rd=
ptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wrptr=3D gfx_v9_0_spm_get_wr=
ptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_spm_porfmon_ring_buf =3D gfx=
_v9_0_set_spm_porfmon_ring_buf,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_reg =3D gfx_v9_0_spm_set_reg=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_spm_config_size =3D 3,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_spm_data_size =3D 128,<br>
&#43;};<br>
&#43;<br>
&#43;static void gfx_v9_0_set_spm_funcs(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm.spmf =3D &amp;gf=
x_v9_0_spm_funcs;<br>
&#43;}<br>
&#43;<br>
&nbsp;static int gfx_v9_0_early_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
@@ -4626,6 &#43;4749,7 @@ static int gfx_v9_0_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_gfx_rings =3D GFX9_NUM_GFX_RINGS;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_compute_r=
ings =3D AMDGPU_MAX_COMPUTE_RINGS;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_set_spm_funcs(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_set_kiq_pm4_funcs=
(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_set_ring_funcs(ad=
ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_set_irq_funcs(ade=
v);<br>
@@ -4677,6 &#43;4801,10 @@ static int gfx_v9_0_late_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev, &amp;a=
dev-&gt;gfx.spm_irq, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_get(adev,=
 &amp;adev-&gt;gfx.priv_inst_irq, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
@@ -6657,6 &#43;6785,39 @@ static void gfx_v9_0_emit_mem_sync(struct amdgpu=
_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0x=
0000000A); /* POLL_INTERVAL */<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int gfx_v9_0_spm_set_interrupt_state(struct amdgpu_device *adev=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *src,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int type,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state state)<b=
r>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (state) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_DISABLE:<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmRLC_SPM_INT_CNTL, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_IRQ_STATE_ENABLE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmRLC_SPM_INT_CNTL, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int gfx_v9_0_spm_irq(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 me_id, pipe_id, queue_id;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me_id =3D (entry-&gt;ring_id &amp=
; 0x0c) &gt;&gt; 2;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_id =3D (entry-&gt;ring_id &a=
mp; 0x03) &gt;&gt; 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_id =3D (entry-&gt;ring_id &=
amp; 0x70) &gt;&gt; 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;IH: RLC_RPM_INT, m=
e:%d, pipe:%d, queue:%d\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me_id, pipe_=
id, queue_id);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0; /* This also prevents s=
ending it to KFD */<br>
&#43;}<br>
&#43;<br>
&nbsp;static const struct amd_ip_funcs gfx_v9_0_ip_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;gfx_v9_0&q=
uot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D gfx_v9_0_e=
arly_init,<br>
@@ -6825,12 &#43;6986,19 @@ static const struct amdgpu_irq_src_funcs gfx_v9=
_0_cp_ecc_error_irq_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D amdgpu_gfx_cp=
_ecc_error_irq,<br>
&nbsp;};<br>
&nbsp;<br>
&#43;static const struct amdgpu_irq_src_funcs gfx_v9_0_spm_irq_funcs =3D {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set =3D gfx_v9_0_spm_set_interru=
pt_state,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D gfx_v9_0_spm_irq,<br=
>
&#43;};<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.eop_irq.num_t=
ypes =3D AMDGPU_CP_IRQ_LAST;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.eop_irq.funcs=
 =3D &amp;gfx_v9_0_eop_irq_funcs;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm_irq.num_types =
=3D 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.spm_irq.funcs =3D &a=
mp;gfx_v9_0_spm_irq_funcs;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
num_types =3D 1;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.priv_reg_irq.=
funcs =3D &amp;gfx_v9_0_priv_reg_irq_funcs;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdk=
fd/Makefile<br>
index 6147462..43edba0 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/Makefile<br>
@@ -53,7 &#43;53,8 @@ AMDKFD_FILES&nbsp; :=3D $(AMDKFD_PATH)/kfd_module.o \=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_int_process_v9.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_dbgdev.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_dbgmgr.o \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; $(AMDKFD_PATH)/kfd_crat.o<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_crat.o&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; $(AMDKFD_PATH)/kfd_spm.o<br>
&nbsp;<br>
&nbsp;ifneq ($(CONFIG_AMD_IOMMU_V2),)<br>
&nbsp;AMDKFD_FILES &#43;=3D $(AMDKFD_PATH)/kfd_iommu.o<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu=
/drm/amd/amdkfd/cik_event_interrupt.c<br>
index 9f59ba9..cd394cd 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c<br>
@@ -24,6 &#43;24,7 @@<br>
&nbsp;#include &quot;kfd_events.h&quot;<br>
&nbsp;#include &quot;cik_int.h&quot;<br>
&nbsp;#include &quot;amdgpu_amdkfd.h&quot;<br>
&#43;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;<br>
&nbsp;<br>
&nbsp;static bool cik_event_interrupt_isr(struct kfd_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const uint32_t *ih_ring_entry,<br>
@@ -37,6 &#43;38,11 @@ static bool cik_event_interrupt_isr(struct kfd_dev *=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid =3D f2g-&gt;read_vmid_from_v=
mfault_reg(dev-&gt;kgd);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((ihre-&gt;source_id =3D=3D VI=
SLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR) &amp;&amp; (vmid =3D=3D 0))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return (kfd_spm_interrupt_isr (dev, ihre-&gt;source_id=
, ihre-&gt;source_id));<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This workaround is due =
to HW/FW limitation on Hawaii that<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * VMID and PASID are=
 not written into ih_ring_entry<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
@@ -49,7 &#43;55,6 @@ static bool cik_event_interrupt_isr(struct kfd_dev *d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *patched_flag =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *tmp_ihre =3D *ihre;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vmid =3D f2g-&gt;read_vmid_from_vmfault_reg(dev-&gt;kgd);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D f2g-&gt;get_atc_vmid_pasid_mapping_info(dev-&=
gt;kgd, vmid, &amp;pasid);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp_ihre-&gt;ring_id &amp;=3D 0x000000ff;<br>
@@ -95,6 &#43;100,9 @@ static void cik_event_interrupt_wq(struct kfd_dev *d=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pasid =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((ihre-&gt;source_id =3D=3D VI=
SLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR) &amp;&amp; (vmid =3D=3D 0))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kfd_spm_interrupt_wq(dev, ihre-&gt;source_id);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ihre-&gt;source_id =3D=
=3D CIK_INTSRC_CP_END_OF_PIPE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd_signal_event_interrupt(pasid, context_id, 28);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (ihre-&gt;source_i=
d =3D=3D CIK_INTSRC_SDMA_TRAP)<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index f8fa03a..bfc83beb 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -1732,6 &#43;1732,20 @@ static int kfd_ioctl_import_dmabuf(struct file *=
filep,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static int kfd_ioctl_rlc_spm(struct file *filep,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p=
, void *data)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_spm_args *args =
=3D data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D kfd_rlc_spm(p,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void __user=
 *)args,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&=
gt;buf_size,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&=
gt;op);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
&#43;}<br>
&#43;<br>
&nbsp;#define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [_IOC_NR(ioctl)] =3D {.cmd=
 =3D ioctl, .func =3D _func, .flags =3D _flags, \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; .cmd_drv =3D 0, .name =3D #ioctl}<br>
@@ -1827,6 &#43;1841,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioct=
ls[] =3D {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKFD_IO=
C_ALLOC_QUEUE_GWS,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_i=
octl_alloc_queue_gws, 0),<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDKFD_IOCTL_DEF(AMDKFD_IOC_RLC_S=
PM,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_ioctl_rl=
c_spm, 0),<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#define AMDKFD_CORE_IOCTL_COUNT ARRAY_SIZE(amdkfd_ioctls)<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c<br>
index e05d75e..481f0ae 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c<br>
@@ -24,6 &#43;24,7 @@<br>
&nbsp;#include &quot;kfd_events.h&quot;<br>
&nbsp;#include &quot;soc15_int.h&quot;<br>
&nbsp;#include &quot;kfd_device_queue_manager.h&quot;<br>
&#43;#include &quot;ivsrcid/gfx/irqsrcs_gfx_9_0.h&quot;<br>
&nbsp;<br>
&nbsp;static bool event_interrupt_isr_v9(struct kfd_dev *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; const uint32_t *ih_ring_entry,<br>
@@ -35,12 &#43;36,15 @@ static bool event_interrupt_isr_v9(struct kfd_dev *=
dev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only handle interrupts =
from KFD VMIDs */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid =3D SOC15_VMID_FROM_I=
H_ENTRY(ih_ring_entry);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; source_id =3D SOC15_SOURCE_ID_FRO=
M_IH_ENTRY(ih_ring_entry);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id =3D SOC15_CLIENT_ID_FRO=
M_IH_ENTRY(ih_ring_entry);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((source_id =3D=3D GFX_9_0__SR=
CID__RLC_STRM_PERF_MONITOR_INTERRUPT) &amp;&amp; (vmid =3D=3D 0))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return (kfd_spm_interrupt_isr (dev, source_id, client_=
id));<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vmid &lt; dev-&gt;vm_i=
nfo.first_vmid_kfd ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm=
id &gt; dev-&gt;vm_info.last_vmid_kfd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; source_id =3D SOC15_SOURCE_ID_FROM_IH=
_ENTRY(ih_ring_entry);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; client_id =3D SOC15_CLIENT_ID_FROM_IH=
_ENTRY(ih_ring_entry);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasid =3D SOC15_PASID_FROM=
_IH_ENTRY(ih_ring_entry);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This is a known issue f=
or gfx9. Under non HWS, pasid is not set<br>
@@ -95,6 &#43;99,9 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid =3D SOC15_VMID_FROM_I=
H_ENTRY(ih_ring_entry);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context_id =3D SOC15_CONTE=
XT_ID0_FROM_IH_ENTRY(ih_ring_entry);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((source_id =3D=3D GFX_9_0__SR=
CID__RLC_STRM_PERF_MONITOR_INTERRUPT) &amp;&amp; (vmid =3D=3D 0))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kfd_spm_interrupt_wq(dev, source_id);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (source_id =3D=3D SOC15=
_INTSRC_CP_END_OF_PIPE)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfd_signal_event_interrupt(pasid, context_id, 32);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (source_id =3D=3D =
SOC15_INTSRC_SDMA_TRAP)<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index 43b888b..707d672 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -309,6 &#43;309,9 @@ struct kfd_dev {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Global GWS resource sha=
red b/t processes*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *gws;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*spm process id */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int spm_pasid;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum kfd_mempool {<br>
@@ -740,6 &#43;743,13 @@ struct kfd_process {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kobject *kobj_queue=
s;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct attribute attr_pasi=
d;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* spm data */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_spm_cntr *spm_cntr;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_spm_acquired;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Work items for tranfer data to=
 user */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work copy_to_user_=
work;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* spm-related data */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex spm_mutex;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */<br>
@@ -1045,10 &#43;1055,20 @@ int dbgdev_wave_reset_wavefronts(struct kfd_dev=
 *dev, struct kfd_process *p);<br>
&nbsp;<br>
&nbsp;bool kfd_is_locked(void);<br>
&nbsp;<br>
&#43;void kfd_spm_init_process(struct kfd_process *p);<br>
&#43;int kfd_rlc_spm(struct kfd_process *p,&nbsp; void __user *data,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t buf_size,=
 __u32 op);<br>
&#43;<br>
&nbsp;/* Compute profile */<br>
&nbsp;void kfd_inc_compute_active(struct kfd_dev *dev);<br>
&nbsp;void kfd_dec_compute_active(struct kfd_dev *dev);<br>
&nbsp;<br>
&#43;/* spm interrupt */<br>
&#43;bool kfd_spm_interrupt_isr(struct kfd_dev *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint16_t source_id,&nbsp;&nbsp;&nbsp;&nbsp; uint32_t client_id);<b=
r>
&#43;void kfd_spm_interrupt_wq(struct kfd_dev *dev, uint16_t source_id);<br=
>
&#43;<br>
&#43;<br>
&nbsp;/* Cgroup Support */<br>
&nbsp;/* Check with device cgroup if @kfd device is accessible */<br>
&nbsp;static inline int kfd_devcgroup_check_permission(struct kfd_dev *kfd)=
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c<br>
index fe0cd49..338868d 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
@@ -746,6 &#43;746,7 @@ static struct kfd_process *create_process(const str=
uct task_struct *thread)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;pro=
cess-&gt;restore_work, restore_process_worker);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;last_restore_t=
imestamp =3D get_jiffies_64();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_event_init_process(pro=
cess);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_spm_init_process(process);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;is_32bit_user_=
mode =3D in_compat_syscall();<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;pasid =3D kfd_=
pasid_alloc();<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_spm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_spm.c<br>
new file mode 100644<br>
index 0000000..773e2ee<br>
--- /dev/null<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_spm.c<br>
@@ -0,0 &#43;1,577 @@<br>
&#43;/*<br>
&#43; * Copyright 2020 Advanced Micro Devices, Inc.<br>
&#43; *<br>
&#43; * Permission is hereby granted, free of charge, to any person obtaini=
ng a<br>
&#43; * copy of this software and associated documentation files (the &quot=
;Software&quot;),<br>
&#43; * to deal in the Software without restriction, including without limi=
tation<br>
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>
&#43; * and/or sell copies of the Software, and to permit persons to whom t=
he<br>
&#43; * Software is furnished to do so, subject to the following conditions=
:<br>
&#43; *<br>
&#43; * The above copyright notice and this permission notice shall be incl=
uded in<br>
&#43; * all copies or substantial portions of the Software.<br>
&#43; *<br>
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS OR<br>
&#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,<br>
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO E=
VENT SHALL<br>
&#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR<br>
&#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWIS=
E,<br>
&#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE =
OR<br>
&#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&#43; */<br>
&#43;<br>
&#43;#include &lt;linux/device.h&gt;<br>
&#43;#include &quot;kfd_priv.h&quot;<br>
&#43;#include &quot;amdgpu_amdkfd.h&quot;<br>
&#43;#include &quot;soc15_int.h&quot;<br>
&#43;#include &quot;ivsrcid/gfx/irqsrcs_gfx_9_0.h&quot;<br>
&#43;#include &quot;ivsrcid/ivsrcid_vislands30.h&quot;<br>
&#43;#include &lt;linux/delay.h&gt;<br>
&#43;<br>
&#43;#define SAMPLING_MAX 4<br>
&#43;<br>
&#43;struct user_buf {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user *user_addr;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 ubufsize;<br>
&#43;<br>
&#43;};<br>
&#43;<br>
&#43;struct kfd_spm_cntr {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kgd_dev *kgd;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp; spm_g=
pu_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; spm_r=
ing_buf_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; spm_r=
ing_buf_mark;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;=
&nbsp;&nbsp;&nbsp; spm_ring_rptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; spm_r=
ing_wptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; spm_r=
ing_size_copied;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp; *spm_obj;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; *spm_=
cpu_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct user_buf ubuf [SAMPL=
ING_MAX];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; buf_c=
ount;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp; is_uesr_bu=
f_filled;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp; is_nowait;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct *thread;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp; thread_rea=
dy;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char&nbsp;&nbsp; *name;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wait_queue_head_t spm_wq;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp; wante=
d_cluster;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp; is_timeout=
;<br>
&#43;};<br>
&#43;<br>
&#43;static int kfd_spm_data_cocy (struct kfd_spm_cntr * spm_cntr, u32 size=
_to_copy)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 user_buf_space_left;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bufSize;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t __user * user_addr=
ess;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t * ring_buf;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[%s]\n&quot;=
, __func__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bufSize =3D spm_cntr-&gt;ub=
uf[0].ubufsize;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_address =3D (uint64_t*=
)((uint64_t)spm_cntr-&gt;ubuf[0].user_addr &#43; spm_cntr-&gt;spm_ring_size=
_copied);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring_buf =3D&nbsp; (uint64_=
t*)((uint64_t)spm_cntr-&gt;spm_cpu_addr &#43; spm_cntr-&gt;spm_ring_rptr);<=
br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (user_address =3D=3D NUL=
L)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EFAULT;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_buf_space_left =3D buf=
Size - spm_cntr-&gt;spm_ring_size_copied;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size_to_copy &lt;=3D us=
er_buf_space_left) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D copy_to_user(user_address, ring_buf, size_to_copy);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;copy_to_user failed, ret =3D %x\n&q=
uot;, ret);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAU=
LT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_size_copied &#43;=3D size_to_copy;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; size_to_copy =3D spm_cntr-&gt;spm_ring_buf_size - spm_cntr-&=
gt;spm_ring_size_copied;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D copy_to_user(user_address, ring_buf, user_buf_space_=
left);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAU=
LT;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_size_copied =3D bufSize;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm_cntr-&gt;is_uesr_buf_filled =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int kfd_spm_reag_ring_buf_polling (struct kfd_spm_cntr * spm_cn=
tr, long timeout)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 size_to_copy;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;[%s]\n&quot;, __fun=
c__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (spm_cntr-&gt;is_uesr_buf_f=
illed !=3D true){<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_rptr =3D amdgpu_amdkfd_rlc_spm_get_rdp=
tr(spm_cntr-&gt;kgd) &amp; spm_cntr-&gt;spm_ring_buf_mark;<br>
&#43;#if 1<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_wptr =3D amdgpu_amdkfd_rlc_spm_get_wrp=
tr(spm_cntr-&gt;kgd) &amp; spm_cntr-&gt;spm_ring_buf_mark;<br>
&#43;#else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_wptr =3D spm_cntr-&gt;spm_cpu_addr[0] =
&amp; spm_cntr-&gt;spm_ring_buf_mark;<br>
&#43;#endif<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if ((spm_cntr-&gt;spm_ring_rptr &gt;=3D 0) &amp;&amp;&nbsp; =
(spm_cntr-&gt;spm_ring_rptr&nbsp; &lt; 0x20))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_rptr =3D 0x20;<br=
>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (spm_cntr-&gt;is_uesr_buf_filled =3D=3D true)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto exit;<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (spm_cntr-&gt;spm_ring_wptr &gt; spm_cntr-&gt;spm_ring_rp=
tr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_to_copy=
 =3D spm_cntr-&gt;spm_ring_wptr - spm_cntr-&gt;spm_ring_rptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kfd_=
spm_data_cocy(spm_cntr, size_to_copy);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } else if (spm_cntr-&gt;spm_ring_wptr &lt; spm_cntr-&gt;spm_=
ring_rptr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_to_copy=
 =3D spm_cntr-&gt;spm_ring_buf_size - spm_cntr-&gt;spm_ring_rptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kfd_=
spm_data_cocy(spm_cntr, size_to_copy);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* correct c=
ounter start point */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_cntr-&gt=
;spm_ring_rptr =3D 0x20;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_to_copy=
 =3D spm_cntr-&gt;spm_ring_wptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D kfd_=
spm_data_cocy(spm_cntr, size_to_copy);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spm_cntr=
-&gt;is_uesr_buf_filled =3D=3D true) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stop */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_cntl(spm_cntr-&gt=
;kgd, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cnt=
r-&gt;kgd, 0);<br>
&#43;#if 0<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cnt=
r-&gt;kgd, 0);<br>
&#43;#else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_cntr-&gt;spm_cpu_addr[0]=3D 0;<br>
&#43;#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cnt=
r-&gt;kgd, spm_cntr-&gt;spm_ring_wptr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spm_cntr=
-&gt;is_timeout =3D=3D true) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stop */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_cntl(spm_cntr-&gt=
;kgd, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cnt=
r-&gt;kgd, 0);<br>
&#43;#if 0<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cnt=
r-&gt;kgd, 0);<br>
&#43;#else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_cntr-&gt;spm_cpu_addr[0]=3D 0;<br>
&#43;#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;exit:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int kfd_spm_reag_ring_buf (struct kfd_spm_cntr * spm_cntr)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 size_to_copy;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[%s]\n&quot;, __fu=
nc__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_rptr =3D am=
dgpu_amdkfd_rlc_spm_get_rdptr(spm_cntr-&gt;kgd) &amp; spm_cntr-&gt;spm_ring=
_buf_mark;<br>
&#43;#if 1<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_wptr =3D am=
dgpu_amdkfd_rlc_spm_get_wrptr(spm_cntr-&gt;kgd) &amp; spm_cntr-&gt;spm_ring=
_buf_mark;<br>
&#43;#else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_wptr =3D sp=
m_cntr-&gt;spm_cpu_addr[0] &amp; spm_cntr-&gt;spm_ring_buf_mark;<br>
&#43;#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((spm_cntr-&gt;spm_ring_rptr &=
gt;=3D 0) &amp;&amp;&nbsp; (spm_cntr-&gt;spm_ring_rptr&nbsp; &lt; 0x20)) {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_rptr =3D 0x20;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spm_cntr-&gt;is_uesr_buf_fill=
ed =3D=3D true)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto exit;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spm_cntr-&gt;spm_ring_wptr &g=
t; spm_cntr-&gt;spm_ring_rptr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; size_to_copy =3D spm_cntr-&gt;spm_ring_wptr - spm_cntr-&gt;s=
pm_ring_rptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D kfd_spm_data_cocy(spm_cntr, size_to_copy);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (spm_cntr-&gt;spm_ring_=
wptr &lt; spm_cntr-&gt;spm_ring_rptr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; size_to_copy =3D spm_cntr-&gt;spm_ring_buf_size - spm_cntr-&=
gt;spm_ring_rptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D kfd_spm_data_cocy(spm_cntr, size_to_copy);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm_cntr-&gt;spm_ring_rptr =3D 0x20;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; size_to_copy =3D spm_cntr-&gt;spm_ring_wptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D kfd_spm_data_cocy(spm_cntr, size_to_copy);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!ret) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spm_cntr=
-&gt;is_uesr_buf_filled =3D=3D true) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* stop */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_cntl(spm_cntr-&gt=
;kgd, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cnt=
r-&gt;kgd, 0);<br>
&#43;#if 0<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_set_wrptr(spm_cnt=
r-&gt;kgd, 0);<br>
&#43;#else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_cntr-&gt;spm_cpu_addr[0]=3D 0;<br>
&#43;#endif<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_set_rdptr(spm_cnt=
r-&gt;kgd, spm_cntr-&gt;spm_ring_wptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;exit:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;static int kfd_spm_sched_main(void *param)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_spm_cntr * spm_cntr =
=3D (struct kfd_spm_cntr *)param;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (!kthread_should_stop()) {<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; wait_event_interruptible(spm_cntr-&gt;spm_wq,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_cntr-&gt;wanted_cluster !=3D false =
||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kthread_should_stop());<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kfd_spm_reag_ring_buf (spm_cntr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm_cntr-&gt;wanted_cluster =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static void transfer_data_process_worker(struct work_struct *work)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work *dwork;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[%s]\n&quot;, __fu=
nc__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dwork =3D to_delayed_work(work);<=
br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Process termination destroys t=
his worker thread. So during the<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * lifetime of this thread, =
kfd_process p will be valid<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p =3D container_of(dwork, struct =
kfd_process, copy_to_user_work);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;is_timeout =3D=
 true;<br>
&#43;}<br>
&#43;<br>
&#43;<br>
&#43;/**<br>
&#43; * kfd_spm_init - init driver ring struct.<br>
&#43; * Returns 0 on success, error on failure.<br>
&#43; */<br>
&#43;int kfd_spm_shed_init(struct kfd_process *p, struct kgd_dev *kgd)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_waitqueue_head(&amp;p-&gt;sp=
m_cntr-&gt;spm_wq);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;wanted_cluster=
 =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;kgd =3D kgd;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;p-&gt;copy=
_to_user_work, transfer_data_process_worker);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Each scheduler will run on a s=
eperate kernel thread */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;thread =3D kth=
read_run(kfd_spm_sched_main, p-&gt;spm_cntr, p-&gt;spm_cntr-&gt;name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(p-&gt;spm_cntr-&gt;thr=
ead)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D PTR_ERR(p-&gt;spm_cntr-&gt;thread);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;thread =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to create scheduler for %s.\n&quot;, =
p-&gt;spm_cntr-&gt;name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;thread_ready =
=3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&#43;/**<br>
&#43; * amdgpu_ring_fini - tear down the driver ring struct.<br>
&#43; *<br>
&#43; * @adev: amdgpu_device pointer<br>
&#43; * @ring: amdgpu_ring structure holding ring information<br>
&#43; *<br>
&#43; * Tear down the driver information for the selected ring (all asics).=
<br>
&#43; */<br>
&#43;void kfd_spm_shed_fini(struct kfd_process *p)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;spm_cntr-&gt;thread)<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kthread_stop(p-&gt;spm_cntr-&gt;thread);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cancel_delayed_work_sync(&amp;p-&=
gt;copy_to_user_work);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;thread =3D NUL=
L;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;thread_ready =
=3D false;<br>
&#43;}<br>
&#43;<br>
&#43;void kfd_spm_init_process(struct kfd_process *p)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;p-&gt;spm_mutex);=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;is_spm_acquired =3D false;<=
br>
&#43;}<br>
&#43;<br>
&#43;static struct kfd_spm_cntr *allocate_spm_cntr_data(void)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_spm_cntr *cntr;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cntr =3D kzalloc(sizeof(*cntr), G=
FP_KERNEL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cntr)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return NULL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cntr;<br>
&#43;}<br>
&#43;<br>
&#43;int kfd_acquire_spm(struct kfd_process *p, struct kgd_dev *kgd)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int count;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[%s]\n&quot;, __fu=
nc__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(p-&gt;is_spm_acquired =3D=3D t=
rue)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p-&gt;spm_cntr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr =3D allocate_spm_cntr_data();<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!p-&gt;spm_cntr)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOM=
EM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* git spm ring buffer 128KB */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;spm_ring_buf_size =3D order_base_2(128 * =
1024/4);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;spm_ring_buf_size =3D (1 &lt;&lt; p-&gt;s=
pm_cntr-&gt;spm_ring_buf_size) * 4;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;spm_ring_buf_mark =3D p-&gt;spm_cntr-&gt;=
spm_ring_buf_size -1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (count =3D 0; count &lt; SAMPLING_MAX; &#43;&#43;count) =
{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cn=
tr-&gt;ubuf[count].user_addr =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cn=
tr-&gt;ubuf[count].ubufsize =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;buf_count =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;is_uesr_buf_filled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;is_nowait =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;thread_ready =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D amdgpu_amdkfd_alloc_gt=
t_mem(kgd,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cn=
tr-&gt;spm_ring_buf_size, &amp;p-&gt;spm_cntr-&gt;spm_obj,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;p-&gt;s=
pm_cntr-&gt;spm_gpu_addr, (void *)&amp;p-&gt;spm_cntr-&gt;spm_cpu_addr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(p-&gt;spm_cntr-&gt;spm_cpu=
_addr, 0, p-&gt;spm_cntr-&gt;spm_ring_buf_size);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_acquire(kgd=
, p-&gt;spm_cntr-&gt;spm_gpu_addr, p-&gt;spm_cntr-&gt;spm_ring_buf_size);<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;spm_cntr-&gt;thread_rea=
dy =3D=3D false) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;name =3D &quot;spm&quot;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; retval =3D kfd_spm_shed_init(p, kgd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (retval) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&q=
uot;Failed to create spm thread %s.\n&quot;,&nbsp; p-&gt;spm_cntr-&gt;name)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retva=
l;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;is_spm_acquired =3D true;<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;int kfd_release_spm(struct kfd_process *p, struct kgd_dev *kgd)<br>
&#43;{<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_spm_shed_fini(p);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_free_gtt_mem(kgd, p=
-&gt;spm_cntr-&gt;spm_obj);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(p-&gt;spm_cntr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;is_spm_acquired =3D false;<=
br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;int set_dest_buf_polling(struct kfd_spm_cntr *spm, struct kgd_dev *kgd=
, void __user *data)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_spm_args __user =
*user_spm_data =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct kfd_=
ioctl_spm_args __user *) data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long timeout;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug (&quot;[%s]\n&quot;, __f=
unc__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D msecs_to_jiffies(user=
_spm_data-&gt;timeout) &#43; 1;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if buf =3D NULL, stop spm */<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!user_spm_data-&gt;destptr) {=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_cntl(kgd, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; user_spm_data-&gt;bytes_copied =3D spm-&gt;spm_ring_size_cop=
ied;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;spm_ring_size_copied =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; user_spm_data-&gt;spmtptr =3D (uint64_t)spm-&gt;ubuf[0].user=
_addr;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; spm-&gt;buf_count; &#43;&#43;i) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm-&gt;ubuf=
 [i] =3D spm-&gt;ubuf [i&#43;1];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;ubuf[spm-&gt;buf_count].user_addr =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;ubuf[spm-&gt;buf_count].ubufsize =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;buf_count --;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (spm-&gt;buf_count &lt; 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm-&gt;buf_=
count =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!spm-&gt;buf_count) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* First time save user spm buffer, then start spm sampling =
*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;ubuf[0].user_addr =3D (uint64_t*)user_spm_data-&gt;d=
estptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;ubuf[0].ubufsize =3D user_spm_data-&gt;buf_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; user_spm_data-&gt;bytes_copied =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;spm_ring_size_copied =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;buf_count &#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;is_uesr_buf_filled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D kfd_spm_reag_ring_buf_polling (spm, timeout);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; user_spm_data-&gt;bytes_copied =3D spm-&gt;spm_ring_size_cop=
ied;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; user_spm_data-&gt;spmtptr =3D (uint64_t)spm-&gt;ubuf[0].user=
_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;buf_count --;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;spm_ring_size_copied =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;is_uesr_buf_filled =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_cntl(kgd, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D kfd_spm_reag_ring_buf_polling (spm, timeout);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; user_spm_data-&gt;bytes_copied =3D spm-&gt;spm_ring_size_cop=
ied;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; user_spm_data-&gt;spmtptr =3D (uint64_t)spm-&gt;ubuf[0].user=
_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;buf_count --;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; spm-&gt;buf_count; &#43;&#43;i)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Repeated =
dest buf */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spm-&gt;=
ubuf[i].user_addr =3D=3D (uint64_t*)user_spm_data-&gt;destptr)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (i =3D=3D spm-&gt;buf_count) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm-&gt;ubuf=
[i].user_addr =3D (uint64_t*)user_spm_data-&gt;destptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm-&gt;ubuf=
[i].ubufsize =3D user_spm_data-&gt;buf_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm-&gt;buf_=
count &#43;&#43;;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; spm-&gt;buf_count; &#43;&#43;i)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm-&gt;ubuf=
[i] =3D spm-&gt;ubuf[i &#43; 1];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; spm-&gt;ubuf[spm-&gt;buf_count].user_addr&nbsp; =3D NULL;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_spm_data-&gt;bytes_copied =
=3D spm-&gt;spm_ring_size_copied;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;}<br>
&#43;<br>
&#43;int kfd_set_dest_buffer(struct kfd_process *p, struct kgd_dev *kgd, vo=
id __user *data)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_spm_args __user =
*user_spm_data =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct kfd_ioctl_spm_args __user *) data;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_spm_cntr *spm =3D p-&g=
t;spm_cntr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long timeout;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[%s]\n&quot;, __fu=
nc__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(p-&gt;is_spm_acquired =3D=3D f=
alse)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D msecs_to_jiffies(user=
_spm_data-&gt;timeout) &#43; 1;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm-&gt;is_timeout =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_delayed_work(&amp;p-&gt;=
copy_to_user_work, timeout);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return set_dest_buf_polling(spm, =
kgd, data);<br>
&#43;}<br>
&#43;<br>
&#43;int kfd_config_spm(struct kfd_process *p, struct kgd_dev *kgd,struct k=
fd_ioctl_spm_args *data)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_spm_args __user =
*user_spm_data =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct kfd_=
ioctl_spm_args __user *) data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_spm_set_reg *spm_reg;<=
br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[%s]\n&quot;, __fu=
nc__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spm_reg =3D kvmalloc_array(1, siz=
eof (struct kfd_spm_set_reg), GFP_KERNEL);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_from_user(spm_reg, (void=
 __user *)user_spm_data-&gt;destptr, sizeof (struct kfd_spm_set_reg))) {<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_err(&quot;copy_from_user Fail\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto exit;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_rlc_spm_set_reg(kgd=
, spm_reg-&gt;reg, spm_reg-&gt;value);<br>
&#43;exit:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(spm_reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;int kfd_rlc_spm(struct kfd_process *p,&nbsp; void __user *data,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t buf_size,=
 __u32 operation)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_spm_args *args =
=3D data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_dev *dev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev =3D kfd_device_by_id(args-&gt=
;gpu_id);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!dev)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (operation) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SPM_OP_ACQUIRE:<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev-&gt;spm_pasid =3D p-&gt;pasid;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D kfd_acquire_spm(p, dev-&gt;kgd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SPM_OP_RELEASE:<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D kfd_release_spm(p, dev-&gt;kgd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SPM_OP_SET_DEST_BU=
F:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D kfd_set_dest_buffer(p, dev-&gt;kgd, data);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case KFD_IOCTL_SPM_OP_CONFIG:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D kfd_config_spm(p, dev-&gt;kgd, args);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;}<br>
&#43;<br>
&#43;void kfd_spm_interrupt(unsigned int pasid)<br>
&#43;{<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p =3D kfd_loo=
kup_process_by_pasid(pasid);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!p) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_info(&quot;kfd_spm_interrupt p =3D %p \n&quot;, p);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return; /* Presumably process exited. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;p-&gt;spm_mutex);=
<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;spm_cntr-&gt;wanted_cluster=
 =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up_interruptible(&amp;p-&gt;=
spm_cntr-&gt;spm_wq);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;p-&gt;spm_mutex=
);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(p);<br>
&#43;}<br>
&#43;<br>
&#43;bool kfd_spm_interrupt_isr(struct kfd_dev *dev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint16_t source_id,&nbsp;&nbsp;&nbsp;&nbsp; uint32_t client_id)<br=
>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[%s]\n&quot;, __fu=
nc__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (source_id !=3D GFX_9_0__SRCID=
__RLC_STRM_PERF_MONITOR_INTERRUPT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Interrupt types we care about:=
 various signals and faults.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * They will be forwarded to=
 a work queue (see below).<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return source_id =3D=3D GFX_9_0__=
SRCID__RLC_STRM_PERF_MONITOR_INTERRUPT ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; source_id =3D=3D VISLANDS30_IV_SRCID_RLC_STRM_PERF_MONITOR |=
|<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; client_id =3D=3D AMDGPU_IRQ_CLIENTID_LEGACY ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; client_id =3D=3D SOC15_IH_CLIENTID_RLC;<br>
&#43;}<br>
&#43;<br>
&#43;void kfd_spm_interrupt_wq(struct kfd_dev *dev, uint16_t source_id)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t pasid;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;[%s]\n&quot;, __fu=
nc__);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasid =3D dev-&gt;spm_pasid;<br>
&#43;#if 0<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((source_id =3D=3D GFX_9_0__SR=
CID__RLC_STRM_PERF_MONITOR_INTERRUPT) ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (source_id =3D=3D VISLANDS30_IV_SRCID_R=
LC_STRM_PERF_MONITOR))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kfd_spm_interrupt(pasid);<br>
&#43;#endif<br>
&#43;}<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/soc15_int.h b/drivers/gpu/drm/amd/a=
mdkfd/soc15_int.h<br>
index 0bc0b25..fb4ad60 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/soc15_int.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/soc15_int.h<br>
@@ -30,6 &#43;30,7 @@<br>
&nbsp;#define SOC15_INTSRC_SQ_INTERRUPT_MSG&nbsp;&nbsp; 239<br>
&nbsp;#define SOC15_INTSRC_VMC_FAULT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0<br>
&nbsp;#define SOC15_INTSRC_SDMA_TRAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 224<br>
&#43;#define AMDGPU_IRQ_CLIENTID_LEGACY&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp;<br>
&nbsp;<br>
&nbsp;#define SOC15_CLIENT_ID_FROM_IH_ENTRY(entry) (le32_to_cpu(entry[0]) &=
amp; 0xff)<br>
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.=
h<br>
index 4f66764..f7cb7d4 100644<br>
--- a/include/uapi/linux/kfd_ioctl.h<br>
&#43;&#43;&#43; b/include/uapi/linux/kfd_ioctl.h<br>
@@ -442,6 &#43;442,56 @@ struct kfd_ioctl_import_dmabuf_args {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dmabuf_fd;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<br>
&nbsp;};<br>
&nbsp;<br>
&#43;/**<br>
&#43; * kfd_ioctl_spm_op - SPM ioctl operations<br>
&#43; *<br>
&#43; * @KFD_IOCTL_SPM_OP_ACQUIRE: acquire exclusive access to SPM<br>
&#43; * @KFD_IOCTL_SPM_OP_RELEASE: release exclusive access to SPM<br>
&#43; * @KFD_IOCTL_SPM_OP_SET_DEST_BUF: set or unset destination buffer for=
 SPM streaming<br>
&#43; */<br>
&#43;enum kfd_ioctl_spm_op {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOCTL_SPM_OP_ACQUIRE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOCTL_SPM_OP_RELEASE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOCTL_SPM_OP_SET_DEST_BUF,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_IOCTL_SPM_OP_CONFIG<br>
&#43;};<br>
&#43;<br>
&#43;/* Don't wait for previous buffer to fill up */<br>
&#43;#define KFD_IOCTL_SPM_FLAG_POLLING 1<br>
&#43;<br>
&#43;/**<br>
&#43; * kfd_ioctl_spm_args - Arguments for SPM ioctl<br>
&#43; *<br>
&#43; * @op:&nbsp;&nbsp;&nbsp;&nbsp; specifies the operation to perform<br>
&#43; * @destptr:used for the address of the destination buffer in @KFD_IOC=
TL_SPM_SET_DEST_BUFFER<br>
&#43; * @buf_size:size&nbsp; of the destination buffer in @KFD_IOCTL_SPM_SE=
T_DEST_BUFFER<br>
&#43; * @timeout: timeout to wait buffer get filled<br>
&#43; * @gpu_id: gpi ID<br>
&#43; * @bytes_copied: byte copied from streaming performance ring buffer<b=
r>
&#43; *<br>
&#43; * If @ptr is NULL, the destination buffer address is unset and copyin=
g of counters<br>
&#43; * is stopped.<br>
&#43; *<br>
&#43; * Returns negative error code on failure. On success, @KFD_IOCTL_SPM_=
OP_ACQUIRE and<br>
&#43; * @KFD_IOCTL_SPM_OP_RELEASE return 0, @KFD_IOCTL_SPM_OP_SET_DEST_BUF =
returns the fill<br>
&#43; * level of the previous buffer.<br>
&#43; */<br>
&#43;struct kfd_ioctl_spm_args {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 destptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 spmtptr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 buf_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 op;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 timeout;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 gpu_id;&nbsp;&nbsp; /* to K=
FD */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* from KFD: Total amount of byte=
s copied */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 bytes_copied;<br>
&#43;};<br>
&#43;<br>
&#43;struct kfd_spm_set_reg {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 reg;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to KFD */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 value;<br>
&#43;};<br>
&#43;<br>
&nbsp;/* Register offset inside the remapped mmio page<br>
&nbsp; */<br>
&nbsp;enum kfd_mmio_remap {<br>
@@ -546,7 &#43;596,10 @@ enum kfd_mmio_remap {<br>
&nbsp;#define AMDKFD_IOC_ALLOC_QUEUE_GWS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMDKFD_IOWR(0x1E, struct kfd_ioctl_alloc_queue_gws_ar=
gs)<br>
&nbsp;<br>
&#43;#define AMDKFD_IOC_RLC_SPM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; AMDKFD_IOWR(0x1F, struct kfd_ioctl_spm_args)<br>
&#43;<br>
&nbsp;#define AMDKFD_COMMAND_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x01<br>
-#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x1F<br>
&#43;#define AMDKFD_COMMAND_END&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x20<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cyong.zhao%40amd.com%7C326c22b09293444c1a3f08d7eb7c3c2b%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637236791554300056&amp;amp;sdata=3D70Ud36av=
jI1hPHwGX0Enfo8YiRokubqepxdL3HLsocU%3D&amp;amp;reserved=3D0">https://nam11.=
safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org=
%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cyong.zhao%40amd.co=
m%7C326c22b09293444c1a3f08d7eb7c3c2b%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637236791554300056&amp;amp;sdata=3D70Ud36avjI1hPHwGX0Enfo8YiRokubqep=
xdL3HLsocU%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB44826ACFD413B62FEBB5F202F0AD0DM6PR12MB4482namp_--

--===============1295026741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1295026741==--
