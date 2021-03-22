Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E371AC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DCF6187E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DCF6187E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 462F489FD7;
	Mon, 22 Mar 2021 05:57:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A61789FD7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 05:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMQ4spn0znBDZxV86oLMyxcbM8op4LC4L9dtr26Mgk5B7sQDuGkfGsGlLHFxpKEqi75HVyFhtitc/p5NDOaVf0fJmZ5YN4w3AeXIouzU63M7t5IGc8pNFaF/+4nqk7w8M/oqvcliI8cC9u3+ln/Zo1Lz1gLOhzxW/hM+VR3+w4XP0RLzu8HHSldyqgxpU4AQ/rzgt06UgP/ZTb5IIIHAQhH8Iw7HaXE3y7HZ/ibKOmzCoobA92kq+ovJCR9NgDqdAXa7rw9RwH4/4Etl27HsjErEDaBA40d65ZPoz7c5ZzWb6lVCL2B8VdS2wLDFgmJG+9VOGm3h3knNVy1nP+mcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8B1JuT7yPUilecdvIYP8M+DC/AUFjspD/EK9r6pkRY=;
 b=VO4mUguW8QT19UWe7aB68jkz7tMTnq6KYjAaAul7IgAh6MGYjXM6TU5/RaOfky1fKtRq7fgJLXOAiWdiVZ/9ZcjN54KKNd6jg2U9CDe0RcOf51p7S9rKw68/iCbqtA+JPBugmpx1DPh2x3iXJ/gua5cNxkLTxm1uSPQQlT87iIRwxY9SwLlylFl6lCk1IBxcKAAJYZ+bMBz5FGs7EcSTnorfUn2LeVZqvhb9avLnp5Nj187pgBDWadcx0fYdQM0w83E4AT2AdwSC2Q41VwVPhFVmXSnhAjUkREVgGqpqPCZfiTtQxUcvTthb/wvZ8dWDlREIIDrMt91m4Vd/9M7krQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8B1JuT7yPUilecdvIYP8M+DC/AUFjspD/EK9r6pkRY=;
 b=gUVUzkTY4UHuBM93IbZ2O3r6HCknHizy1tTHUVJmcD/GrfkJlUuA+maw3v59lKzaaSNZGZx2g9S60L1AyTYlR5GbAf663nXpxCFXFQP1gaKKBhTdKA25k8zsdaEwXZ0SIlkxBu/eTDtRc04NA0CLuzGTs/fpmxfD0q2drHy8ynE=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 05:57:38 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:57:38 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/8] drm/amdgpu: Add reset control to amdgpu_device
Thread-Topic: [PATCH v2 4/8] drm/amdgpu: Add reset control to amdgpu_device
Thread-Index: Adce3uZQRobxmD1WSAK0nwoi0wugEw==
Date: Mon, 22 Mar 2021 05:57:38 +0000
Message-ID: <MN2PR12MB45499B46CC0A6BE415BC13D597659@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T05:57:36Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=459066c6-0b6a-4d64-ad2d-d6144a829c6a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.224.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d39c412-6d14-4f53-cef9-08d8ecf765e8
x-ms-traffictypediagnostic: MN2PR12MB4254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4254F55047EAA772697E51EF97659@MN2PR12MB4254.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2gFC+o6rTCBGkM6YzkvB/aleCLO1n+FwFa7yk7cmjD4DAclKR7hTGDMJvk+wrK/Z/xhJflN3iv3NCrjwAxG7lRTaeUJlBeqiytq/IPBp3pLEh7G/PJHWrehOQ+XvOX8zLx4BMU4YMrqGM8zTT1Bt/ki7Bn7xiI9nFT3c+jFNb5S7JhQ1g1soot2WD9gRwED8qQVC/U/GbLaP1up9IJK20eOqVTJbuxVf73WISxwJtNO6NUHAMu2ySYInSj2jmgKdMjwJRFUTN4iyB8fReXBYAN+y0LsGJSS7gvSyiQYcxMxpfYMcLf/YKinw30sfoNHgVw5TA+4sfkqG2XwC2qvYzR3NMnG2JZTwf/QbrosRijjbHeyJVu/v9emVb9C6+uT+L8lnkfFsZJUdknv6e0BrngZauSmpUkRDF2BQlzUOxwyCa3NXWWxQH2Eh3zlo9ypapcBlivAWT/m3rsNSc8mdxPZlQKVcmbE7P3pyUNga51NgqOzkiAZ2q6Us4BwjQwlMSZbqgrJBAgj86Ae7Mgb+nTvlZEUTcLT6XNPOvUHfeOtJpLl0MPlGLptp74/FrnLbXrCcTmNsfKN6dc1WKuo3d57XG6li5EZW5vyq2PzoYoCJdpQ5gvNV3UquSHNW+s5zkQOlF5AwI7RJ+nKGT05sAYavFrpeAlxnhYpldyS+N3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(33656002)(76116006)(66556008)(86362001)(66946007)(478600001)(8936002)(66476007)(8676002)(64756008)(83380400001)(66446008)(55236004)(52536014)(71200400001)(6916009)(38100700001)(2906002)(26005)(316002)(186003)(5660300002)(55016002)(4326008)(7696005)(54906003)(9686003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jfEg0nGP27mA4Xe2Qim60JsPeR4HZ5o/nSCSrg2SyyRSQvFQF3K213Drh412?=
 =?us-ascii?Q?NdRk1QeW9/e2u9r3JlWjb1TPC8XuStz0jrPpP44SY/KkN9vXDRCg61njKPUu?=
 =?us-ascii?Q?4UieHxKLaijrFXpl2+rDhHx1AhbOp+yYMMAK+rSa9IodtLFdTr91eV17eqWz?=
 =?us-ascii?Q?SK0ix77vLWWd7YubEqVZrWsJpuFwaiqGeIUlOAhV41ho3Bs8En2RiprrqbhY?=
 =?us-ascii?Q?m75BbwjHsio8iRNsDcdSXNm6fJCySytzeMd7SxtxJprCMkulvusAfIuxC/Ym?=
 =?us-ascii?Q?EXj/UIe4QdILPS9vY42DUevEa2Hy5iTln0Swo+8Dzjy7Tn9hkOMtICUGHDqv?=
 =?us-ascii?Q?u1aQ7UZQt4gZ0bIgJj2WEYGIKVJyu+HACrI94r1pMcG5+CRhhfbXYOFCjafQ?=
 =?us-ascii?Q?hXdFnAOuG2Eb3fi69vpjqeXG9CMWR7kYtQWXJXr8/6D+B7Pvhh3DgmnUE1zx?=
 =?us-ascii?Q?y00/brt4MdIdu2RelUNg59cz/08Wahv+rawhNIFKHyB6b7gqMtBQRTldsNkW?=
 =?us-ascii?Q?jjZg/wMeCUGp2bCMty6NkT4iyJ8ggdF1p2SfillOJkgU/OO7mFhy5JWFdwOG?=
 =?us-ascii?Q?6iR4H9R8/1QyrRuRF1Jl9IURfrdJFL6S0cRc1+ByunV+MIieOG9na1YTaOaG?=
 =?us-ascii?Q?7vXsDvl5sBT47A0+JlgS7vqlVwdv2llO+f/0ACHIcddv+4v9BgcdIgBmBVRJ?=
 =?us-ascii?Q?cgrU4iqVI9c9MuOVzvk107lbrCJqZF0dqlC4wipSPh5A9LvAx9+T31j5TFx4?=
 =?us-ascii?Q?P8+Vw4lilwmASvIZK1McZL7DHhi4SNaXsIROcQ37R1NbaQgkCDgRIL9ds0+v?=
 =?us-ascii?Q?tukPHcmLwNguoKM136414kWjGVVR5xVi1A4yfy2VnC5UYOUlomnL/PALTv+i?=
 =?us-ascii?Q?1lHBYxu4iFUtGZRqbwOWJSAjpauV/npG9BfyGMpE2MYxf811mHuDDEKpEOJD?=
 =?us-ascii?Q?st7eoGuCUaQTlPcyll9k+eCGLv5aWl121eDO5miqxeqx6f6l9R8HKJaS5UJ3?=
 =?us-ascii?Q?zGR+XCYGjtCm+PjbOE9D128h9U38yFGrMdOWATJZub8hqmrI/s/bKnQ8Ywtb?=
 =?us-ascii?Q?hrMwKI6tqkSBegOXf3tBzMysZRvjscyc3hUBa8E7bLxez+sbqPNkUUYo6ZqB?=
 =?us-ascii?Q?3wax9LOfP3ga78hrIxuLjcgQkGvI6iz6NCFVc/G84hbn2UNOYWpH8YA8JAJl?=
 =?us-ascii?Q?5wcpEiTjK2hMKriqfaUbQwTiyXIte46d9fggyIqHqpE5/p3Q5rR6j/2XJyNp?=
 =?us-ascii?Q?vx4u6h3jL9h81YP8fu+FPOyKQJGrBqg9S7zquptXZeECOpUaNSC32qy1lTUs?=
 =?us-ascii?Q?shXWoYsXnQhIbIW6oB6yIIbj?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d39c412-6d14-4f53-cef9-08d8ecf765e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:57:38.2324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIsXovh5KJSgTMwxy6Ub62q00Stv/5IVBksL7EEQuuvOvruh2Tm6d2iADskbFmGi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1942050282=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1942050282==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45499B46CC0A6BE415BC13D597659MN2PR12MB4549namp_"

--_000_MN2PR12MB45499B46CC0A6BE415BC13D597659MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

v1: Add generic amdgpu_reset_control to handle different types of resets. I=
t
may be added at device, hive or ip level. Each reset control has a list
of handlers associated with it to handle different types of reset. Reset
control is responsible for choosing the right handler given a particular
reset context.

Handler objects may implement a set of functions on how to handle a
particular type of reset.

prepare_env =3D Prepare environment/software context (not used currently).
prepare_hwcontext =3D Prepare hardware context for the reset.
perform_reset =3D Perform the type of reset.
restore_hwcontext =3D Restore the hw context after reset.
restore_env =3D Restore the environment after reset (not used currently).

Reset context carries the context of reset, as of now this is based on
the parameters used for current set of resets.

v2: Fix coding style

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/Makefile       |  5 ++
drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  3 +
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 82 ++++++++++++++++++++++
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 85 +++++++++++++++++++++++
4 files changed, 175 insertions(+)
create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 741b68874e53..a0a5fd1788b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -179,9 +179,14 @@ amdgpu-y +=3D \
               smuio_v11_0_6.o \
               smuio_v13_0.o
+# add reset block
+amdgpu-y +=3D \
+             amdgpu_reset.o
+
# add amdkfd interfaces
amdgpu-y +=3D amdgpu_amdkfd.o
+
ifneq ($(CONFIG_HSA_AMD),)
AMDKFD_PATH :=3D ../amdkfd
include $(FULL_AMD_PATH)/amdkfd/Makefile
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 963ecfd84347..1fba89cced91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -271,6 +271,7 @@ struct amdgpu_bo_va_mapping;
struct amdgpu_atif;
struct kfd_vm_fault_info;
struct amdgpu_hive_info;
+struct amdgpu_reset_control;
 enum amdgpu_cp_irq {
               AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,
@@ -589,6 +590,7 @@ struct amdgpu_allowed_register_entry {
};
 enum amd_reset_method {
+             AMD_RESET_METHOD_NONE =3D -1,
               AMD_RESET_METHOD_LEGACY =3D 0,
               AMD_RESET_METHOD_MODE0,
               AMD_RESET_METHOD_MODE1,
@@ -1077,6 +1079,7 @@ struct amdgpu_device {
                bool                            in_pci_err_recovery;
               struct pci_saved_state          *pci_state;
+             struct amdgpu_reset_control     *reset_cntl;
};
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c
new file mode 100644
index 000000000000..5bc94b8320ba
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#include "amdgpu_reset.h"
+#include "aldebaran.h"
+
+int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
+                                                  struct amdgpu_reset_hand=
ler *handler)
+{
+             /* TODO: Check if handler exists? */
+             list_add_tail(&handler->handler_list, &reset_ctl->reset_handl=
ers);
+             return 0;
+}
+
+int amdgpu_reset_init(struct amdgpu_device *adev)
+{
+             int ret =3D 0;
+
+             return ret;
+}
+
+int amdgpu_reset_fini(struct amdgpu_device *adev)
+{
+             int ret =3D 0;
+
+             return ret;
+}
+
+int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
+                                                                struct amd=
gpu_reset_context *reset_context)
+{
+             struct amdgpu_reset_handler *reset_handler =3D NULL;
+
+             if (adev->reset_cntl && adev->reset_cntl->get_reset_handler)
+                             reset_handler =3D adev->reset_cntl->get_reset=
_handler(
+                                             adev->reset_cntl, reset_conte=
xt);
+             if (!reset_handler)
+                             return -ENOSYS;
+
+             return reset_handler->prepare_hwcontext(adev->reset_cntl,
+                                                                          =
                   reset_context);
+}
+
+int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
+                                                    struct amdgpu_reset_co=
ntext *reset_context)
+{
+             int ret;
+             struct amdgpu_reset_handler *reset_handler =3D NULL;
+
+             if (adev->reset_cntl)
+                             reset_handler =3D adev->reset_cntl->get_reset=
_handler(
+                                             adev->reset_cntl, reset_conte=
xt);
+             if (!reset_handler)
+                             return -ENOSYS;
+
+             ret =3D reset_handler->perform_reset(adev->reset_cntl, reset_=
context);
+             if (ret)
+                             return ret;
+
+             return reset_handler->restore_hwcontext(adev->reset_cntl,
+                                                                          =
                   reset_context);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
new file mode 100644
index 000000000000..dc84d871fe72
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -0,0 +1,85 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+ *
+ */
+
+#ifndef __AMDUGPU_RESET_H__
+#define __AMDGPU_RESET_H__
+
+#include "amdgpu.h"
+
+enum AMDGPU_RESET_FLAGS {
+
+             AMDGPU_NEED_FULL_RESET =3D 0,
+             AMDGPU_SKIP_HW_RESET =3D 1,
+};
+
+struct amdgpu_reset_context {
+             enum amd_reset_method method;
+             struct amdgpu_device *reset_req_dev;
+             struct amdgpu_job *job;
+             struct amdgpu_hive_info *hive;
+             unsigned long flags;
+};
+
+struct amdgpu_reset_handler {
+             enum amd_reset_method reset_method;
+             struct list_head handler_list;
+             int (*prepare_env)(struct amdgpu_reset_control *reset_ctl,
+                                                struct amdgpu_reset_contex=
t *context);
+             int (*prepare_hwcontext)(struct amdgpu_reset_control *reset_c=
tl,
+                                                             struct amdgpu=
_reset_context *context);
+             int (*perform_reset)(struct amdgpu_reset_control *reset_ctl,
+                                                  struct amdgpu_reset_cont=
ext *context);
+             int (*restore_hwcontext)(struct amdgpu_reset_control *reset_c=
tl,
+                                                             struct amdgpu=
_reset_context *context);
+             int (*restore_env)(struct amdgpu_reset_control *reset_ctl,
+                                                struct amdgpu_reset_contex=
t *context);
+
+             int (*do_reset)(struct amdgpu_device *adev);
+};
+
+struct amdgpu_reset_control {
+             void *handle;
+             struct work_struct reset_work;
+             struct mutex reset_lock;
+             struct list_head reset_handlers;
+             atomic_t in_reset;
+             enum amd_reset_method active_reset;
+             struct amdgpu_reset_handler *(*get_reset_handler)(
+                             struct amdgpu_reset_control *reset_ctl,
+                             struct amdgpu_reset_context *context);
+             void (*async_reset)(struct work_struct *work);
+};
+
+int amdgpu_reset_init(struct amdgpu_device *adev);
+int amdgpu_reset_fini(struct amdgpu_device *adev);
+
+int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
+                                                                struct amd=
gpu_reset_context *reset_context);
+
+int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
+                                                    struct amdgpu_reset_co=
ntext *reset_context);
+
+int amdgpu_reset_add_handler(struct amdgpu_reset_control *reset_ctl,
+                                                  struct amdgpu_reset_hand=
ler *handler);
+
+#endif
--
2.17.1


--_000_MN2PR12MB45499B46CC0A6BE415BC13D597659MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">v1: Add generic amdgpu_reset_control to handle diffe=
rent types of resets. It<o:p></o:p></p>
<p class=3D"MsoNormal">may be added at device, hive or ip level. Each reset=
 control has a list<o:p></o:p></p>
<p class=3D"MsoNormal">of handlers associated with it to handle different t=
ypes of reset. Reset<o:p></o:p></p>
<p class=3D"MsoNormal">control is responsible for choosing the right handle=
r given a particular<o:p></o:p></p>
<p class=3D"MsoNormal">reset context.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Handler objects may implement a set of functions on =
how to handle a<o:p></o:p></p>
<p class=3D"MsoNormal">particular type of reset.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">prepare_env =3D Prepare environment/software context=
 (not used currently).<o:p></o:p></p>
<p class=3D"MsoNormal">prepare_hwcontext =3D Prepare hardware context for t=
he reset.<o:p></o:p></p>
<p class=3D"MsoNormal">perform_reset =3D Perform the type of reset.<o:p></o=
:p></p>
<p class=3D"MsoNormal">restore_hwcontext =3D Restore the hw context after r=
eset.<o:p></o:p></p>
<p class=3D"MsoNormal">restore_env =3D Restore the environment after reset =
(not used currently).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reset context carries the context of reset, as of no=
w this is based on<o:p></o:p></p>
<p class=3D"MsoNormal">the parameters used for current set of resets.<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v2: Fix coding style<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 5 ++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 82 +++++=
+++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 85 +++++=
++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">4 files changed, 175 insertions(+)<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu=
_reset.c<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu=
_reset.h<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/d=
rivers/gpu/drm/amd/amdgpu/Makefile<o:p></o:p></p>
<p class=3D"MsoNormal">index 741b68874e53..a0a5fd1788b5 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/Makefile<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/Makefile<o:p></o:p>=
</p>
<p class=3D"MsoNormal">@@ -179,9 +179,14 @@ amdgpu-y +=3D \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smuio_v11_0_6.o \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smuio_v13_0.o<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+# add reset block<o:p></o:p></p>
<p class=3D"MsoNormal">+amdgpu-y +=3D \<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_reset.o<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal"># add amdkfd interfaces<o:p></o:p></p>
<p class=3D"MsoNormal">amdgpu-y +=3D amdgpu_amdkfd.o<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">ifneq ($(CONFIG_HSA_AMD),)<o:p></o:p></p>
<p class=3D"MsoNormal">AMDKFD_PATH :=3D ../amdkfd<o:p></o:p></p>
<p class=3D"MsoNormal">include $(FULL_AMD_PATH)/amdkfd/Makefile<o:p></o:p><=
/p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/d=
rivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 963ecfd84347..1fba89cced91 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<o:p></o:p>=
</p>
<p class=3D"MsoNormal">@@ -271,6 +271,7 @@ struct amdgpu_bo_va_mapping;<o:p=
></o:p></p>
<p class=3D"MsoNormal">struct amdgpu_atif;<o:p></o:p></p>
<p class=3D"MsoNormal">struct kfd_vm_fault_info;<o:p></o:p></p>
<p class=3D"MsoNormal">struct amdgpu_hive_info;<o:p></o:p></p>
<p class=3D"MsoNormal">+struct amdgpu_reset_control;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;enum amdgpu_cp_irq {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP =3D 0,<o:p=
></o:p></p>
<p class=3D"MsoNormal">@@ -589,6 +590,7 @@ struct amdgpu_allowed_register_e=
ntry {<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;enum amd_reset_method {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_NONE =3D -1,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_LEGACY =3D 0,<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_MODE0,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_RESET_METHOD_MODE1,<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -1077,6 +1079,7 @@ struct amdgpu_device {<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in_pci_err_recovery=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pci_saved_state&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *pci_state;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control&nbsp;&nbsp;&nbsp;&nbsp; *=
reset_cntl;<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;static inline struct amdgpu_device *drm_to_ade=
v(struct drm_device *ddev)<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset=
.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c<o:p></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 000000000000..5bc94b8320ba<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -0,0 +1,82 @@<o:p></o:p></p>
<p class=3D"MsoNormal">+/*<o:p></o:p></p>
<p class=3D"MsoNormal">+ * Copyright 2021 Advanced Micro Devices, Inc.<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ * Permission is hereby granted, free of charge, to=
 any person obtaining a<o:p></o:p></p>
<p class=3D"MsoNormal">+ * copy of this software and associated documentati=
on files (the &quot;Software&quot;),<o:p></o:p></p>
<p class=3D"MsoNormal">+ * to deal in the Software without restriction, inc=
luding without limitation<o:p></o:p></p>
<p class=3D"MsoNormal">+ * the rights to use, copy, modify, merge, publish,=
 distribute, sublicense,<o:p></o:p></p>
<p class=3D"MsoNormal">+ * and/or sell copies of the Software, and to permi=
t persons to whom the<o:p></o:p></p>
<p class=3D"MsoNormal">+ * Software is furnished to do so, subject to the f=
ollowing conditions:<o:p></o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ * The above copyright notice and this permission n=
otice shall be included in<o:p></o:p></p>
<p class=3D"MsoNormal">+ * all copies or substantial portions of the Softwa=
re.<o:p></o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITH=
OUT WARRANTY OF ANY KIND, EXPRESS OR<o:p></o:p></p>
<p class=3D"MsoNormal">+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRAN=
TIES OF MERCHANTABILITY,<o:p></o:p></p>
<p class=3D"MsoNormal">+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGE=
MENT.&nbsp; IN NO EVENT SHALL<o:p></o:p></p>
<p class=3D"MsoNormal">+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE F=
OR ANY CLAIM, DAMAGES OR<o:p></o:p></p>
<p class=3D"MsoNormal">+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRAC=
T, TORT OR OTHERWISE,<o:p></o:p></p>
<p class=3D"MsoNormal">+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE S=
OFTWARE OR THE USE OR<o:p></o:p></p>
<p class=3D"MsoNormal">+ * OTHER DEALINGS IN THE SOFTWARE.<o:p></o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ */<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_reset.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;aldebaran.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_add_handler(struct amdgpu_reset_co=
ntrol *reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; struct amdgpu_reset_handler *handler)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* TODO: Check if handler exists? */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_add_tail(&amp;handler-&gt;handler_list, &amp;res=
et_ctl-&gt;reset_handlers);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_init(struct amdgpu_device *adev)<o=
:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_fini(struct amdgpu_device *adev)<o=
:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_prepare_hwcontext(struct amdgpu_de=
vice *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp; struct amdgpu_reset_context *reset_context)<o:p></o:=
p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_handler *reset_handler =3D NULL;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;reset_cntl &amp;&amp; adev-&gt;reset_cnt=
l-&gt;get_reset_handler)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_handler =3D adev-&gt;reset=
_cntl-&gt;get_reset_handler(<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;re=
set_cntl, reset_context);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!reset_handler)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOSYS;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return reset_handler-&gt;prepare_hwcontext(adev-&gt;r=
eset_cntl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context);<o:p></o=
:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_perform_reset(struct amdgpu_device=
 *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context *reset_context)<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_handler *reset_handler =3D NULL;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;reset_cntl)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_handler =3D adev-&gt;reset=
_cntl-&gt;get_reset_handler(<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;re=
set_cntl, reset_context);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!reset_handler)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOSYS;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D reset_handler-&gt;perform_reset(adev-&gt;rese=
t_cntl, reset_context);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return reset_handler-&gt;restore_hwcontext(adev-&gt;r=
eset_cntl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context);<o:p></o=
:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset=
.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<o:p></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 000000000000..dc84d871fe72<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -0,0 +1,85 @@<o:p></o:p></p>
<p class=3D"MsoNormal">+/*<o:p></o:p></p>
<p class=3D"MsoNormal">+ * Copyright 2021 Advanced Micro Devices, Inc.<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ * Permission is hereby granted, free of charge, to=
 any person obtaining a<o:p></o:p></p>
<p class=3D"MsoNormal">+ * copy of this software and associated documentati=
on files (the &quot;Software&quot;),<o:p></o:p></p>
<p class=3D"MsoNormal">+ * to deal in the Software without restriction, inc=
luding without limitation<o:p></o:p></p>
<p class=3D"MsoNormal">+ * the rights to use, copy, modify, merge, publish,=
 distribute, sublicense,<o:p></o:p></p>
<p class=3D"MsoNormal">+ * and/or sell copies of the Software, and to permi=
t persons to whom the<o:p></o:p></p>
<p class=3D"MsoNormal">+ * Software is furnished to do so, subject to the f=
ollowing conditions:<o:p></o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ * The above copyright notice and this permission n=
otice shall be included in<o:p></o:p></p>
<p class=3D"MsoNormal">+ * all copies or substantial portions of the Softwa=
re.<o:p></o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITH=
OUT WARRANTY OF ANY KIND, EXPRESS OR<o:p></o:p></p>
<p class=3D"MsoNormal">+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRAN=
TIES OF MERCHANTABILITY,<o:p></o:p></p>
<p class=3D"MsoNormal">+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGE=
MENT.&nbsp; IN NO EVENT SHALL<o:p></o:p></p>
<p class=3D"MsoNormal">+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE F=
OR ANY CLAIM, DAMAGES OR<o:p></o:p></p>
<p class=3D"MsoNormal">+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRAC=
T, TORT OR OTHERWISE,<o:p></o:p></p>
<p class=3D"MsoNormal">+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE S=
OFTWARE OR THE USE OR<o:p></o:p></p>
<p class=3D"MsoNormal">+ * OTHER DEALINGS IN THE SOFTWARE.<o:p></o:p></p>
<p class=3D"MsoNormal">+ *<o:p></o:p></p>
<p class=3D"MsoNormal">+ */<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#ifndef __AMDUGPU_RESET_H__<o:p></o:p></p>
<p class=3D"MsoNormal">+#define __AMDGPU_RESET_H__<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+enum AMDGPU_RESET_FLAGS {<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMDGPU_NEED_FULL_RESET =3D 0,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; AMDGPU_SKIP_HW_RESET =3D 1,<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+struct amdgpu_reset_context {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum amd_reset_method method;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *reset_req_dev;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_hive_info *hive;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; unsigned long flags;<o:p></o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+struct amdgpu_reset_handler {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum amd_reset_method reset_method;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct list_head handler_list;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int (*prepare_env)(struct amdgpu_reset_control *reset=
_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
; struct amdgpu_reset_context *context);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int (*prepare_hwcontext)(struct amdgpu_reset_control =
*reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct amdgpu_reset_context *context);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int (*perform_reset)(struct amdgpu_reset_control *res=
et_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; struct amdgpu_reset_context *context);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int (*restore_hwcontext)(struct amdgpu_reset_control =
*reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct amdgpu_reset_context *context);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int (*restore_env)(struct amdgpu_reset_control *reset=
_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
; struct amdgpu_reset_context *context);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int (*do_reset)(struct amdgpu_device *adev);<o:p></o:=
p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+struct amdgpu_reset_control {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; void *handle;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct work_struct reset_work;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct mutex reset_lock;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct list_head reset_handlers;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; atomic_t in_reset;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; enum amd_reset_method active_reset;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_handler *(*get_reset_handler)(<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control *res=
et_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context *con=
text);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; void (*async_reset)(struct work_struct *work);<o:p></=
o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_init(struct amdgpu_device *adev);<=
o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_fini(struct amdgpu_device *adev);<=
o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_prepare_hwcontext(struct amdgpu_de=
vice *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp; struct amdgpu_reset_context *reset_context);<o:p></o=
:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_perform_reset(struct amdgpu_device=
 *adev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context *reset_context);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int amdgpu_reset_add_handler(struct amdgpu_reset_co=
ntrol *reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; struct amdgpu_reset_handler *handler);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#endif<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45499B46CC0A6BE415BC13D597659MN2PR12MB4549namp_--

--===============1942050282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1942050282==--
