Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69466C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 262716187E
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 262716187E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CD089FF9;
	Mon, 22 Mar 2021 05:58:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9610F89FF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 05:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b23p7PihTNiLKZWUuXOwuHf0AVxEaOM5MCusUHU0ja2uNizQavGLaMJXt1cNHUzvKuAaL1XzwSkir3jVSdsQUaHCt4XmypC//Eztid8jIng8kzZ2sMGZG7iSz8fj6ENv4lFzukBS8XXw5DWTWmpFkIAk2uoI7dTh26ehSXu0UsbLmR08HtY3vxpZqGgkBhOmCOWyC7tLpUzSHRAaxkI/jG8QaG1RirCSZ5Mu8ZirA9jaV5SQtr00bqlcFYdlouDybmWez+5o1Ai8ivHu6N2OKqXe3sN3i/dTQLRkzSIQOsSYpDQOrrP5q7kyHL+uOVbRJQis5CnHNowGVyFfZSw8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ9kW7GD+Wcz8Fne/40oyxQ2Xpdh+a8gq/8folSWc3I=;
 b=EDCyvnVX/itwGKGZkwEngibfmcDDU4B2PGj2UzVRKmH7ygHVaEEw1emjHaz6NHeBbyhK5fgKMy8lAcpWh0r60/UuyFcCW/lCmlOH+tHHHJU3SQG7iTAg8Ftlc4g8JhQxqvVh3Xp5S2qT9YZSTUND2yWUOS9wCTOaea5CT+qC2YjD69bb/KHauibMSfLcPlGDt6Jz+xxzlDdchBULNPfBbMuzrhcDwg17hO39+bcir0wSucHdVnxKF3Rkld3Q6NlinoE3t9EVJ+shWza+3lCsEyb0Tltt0sr5vx2NueUrKf0SwhjHFzB3jKDgH9wRxyzcLQZl141PpZCednJTfxHYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ9kW7GD+Wcz8Fne/40oyxQ2Xpdh+a8gq/8folSWc3I=;
 b=b/4cWVM/fQhejCAdLWGzBh4XwGqF07afEXYDzMmqi1FyjX+QtLb5UxbmbkK7E5EnR1IJNvuaxUA+Uo4XLNMykM9QWsPpSDzz/+k4PYLcRd8cxjxxEcwUl97xDjN3teKyMpdt/uC8VLVvtw3i6CXW7RfrWbfOIY6fjg8CWZqn7Fg=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB3967.namprd12.prod.outlook.com (2603:10b6:208:16c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 05:58:07 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:58:07 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 8/8] drm/amdgpu: Add mode2 reset support for aldebaran
Thread-Topic: [PATCH v2 8/8] drm/amdgpu: Add mode2 reset support for aldebaran
Thread-Index: Adce3lbuZ1F/paO9S+yMNXYt/X2OQQ==
Date: Mon, 22 Mar 2021 05:58:07 +0000
Message-ID: <MN2PR12MB45496D2DC3284EC1A4D363D297659@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T05:58:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fa4052f2-3948-4db7-8b87-0997612a40c2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.224.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84f2f861-6fb1-4df8-df84-08d8ecf77726
x-ms-traffictypediagnostic: MN2PR12MB3967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB39671CA66A157C79D0CAEFF897659@MN2PR12MB3967.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIkbPzEzDW/X8ve0hzSRDXEyBPrcsUt+xKkgFPPfBsM+fKwHeLYHeR0EfLjhK0ZwoWUWJ2WiLV5PXL//YNvpTvumhygukGGYpMB/dWLlRKQLgHEqaWUBHR/EPycjGmToescKum3/9z9kxmrwbL12dLEaFussU1Rr9dLn4kAjGoFOA8jL8tnL4hY5vMmavSd1tsB0fp/Yy8c0lO6FUZQbwlc02umL5Pdbheykre2TkczJO0jQzoohInbbSM0+pDi19gvO+YSYLeALOimZXTspFB3XVqGFPahCdkFYUGkvrSRywWwJFaMPdpMZj+95lbxrGDkwG12hB7PMwB4tEoj9svQzt5UYxie8qfAxq7quiT2m1SdJ9raxPWQSuPEPvG9R8WvNAMhUTBxgIY/5oO4vMSqSpShDWKK6LrJfYcRcA9AZniKuWkQusZfxp5w0+NIZVsPVGQVAQ3p+l7EcMMzvWirNabftr/bNvD8xNLWSUmnS4telRdEQrirPvlC+izR0vA9nssgs+pyPcfCRsVt9EJvq0N44GCN7YnDkTU9V5uzKqVRZ3pZJczlb5WDHimMWcBUIKPYLxLOzhgSriLEXZQjFlIRGdHp336cFJ21S0uEAJF5TzBAuoLkfKpQGcm6w2xekmXMG7zJHUjv/+ndXd7MXr8W4mKnfsxaDFTe1nIY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(30864003)(478600001)(8936002)(5660300002)(52536014)(86362001)(83380400001)(4326008)(76116006)(316002)(33656002)(9686003)(2906002)(6916009)(7696005)(54906003)(26005)(55236004)(186003)(38100700001)(66476007)(66946007)(55016002)(6506007)(71200400001)(66556008)(64756008)(66446008)(8676002)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?I0DOJIVhtxKyxbInHdxX6kcsIJW5a6zHgju3r04uHdSd3liByzg6G66+E6cw?=
 =?us-ascii?Q?Jc1RJmZ6Vw23IOJoXP/5xIc/GoCmsXuEw4XJYkEX2CXZeumGqh59qijzcQpC?=
 =?us-ascii?Q?RcLM3cuc37OpboQXnMK4N+O0E2zDbcAZM2hkxDGI2rNSx8btOI9CAHljqZM4?=
 =?us-ascii?Q?2G/P/tea/CNYllPjl0FqGpyZt1ZxrOaU/Q2UKLRwXc2PguRjUCqlDUTKf0jj?=
 =?us-ascii?Q?g9OSv0nXdbk0Peqtw+TJQNqEyLK/ii/oO0E/mLzwVMzovbBkcrQ7/FtrOUgc?=
 =?us-ascii?Q?mOZ1rTGU/IaVnKS3CVsJDXB8S+SL9XViryWjYS/TMs2zcqnWx3DSO2pnMELl?=
 =?us-ascii?Q?xHkZJEFWK9zkgwRm+hH6QIvDujB7K74IdvVSMr82mkJSUTCYc61+CN/+sQyq?=
 =?us-ascii?Q?o0rU93WA6XgY3maM+2uI31IFtmZDs1CPrI6n8Cv+kjZqQswdoNdl0SoUValQ?=
 =?us-ascii?Q?mdKtaYglHvQ5qDKK9c2b6TZfbUR3+zVVrIJuGcjGbt0CRdnWbv7CkJHLNirb?=
 =?us-ascii?Q?s9LLl37UrLGphBP7n659MiZ+obocd3wTMbTmEcMtPmJ3TQf5sGHEpPdpB1ff?=
 =?us-ascii?Q?2UBuk9xU/d837eo5ZVq9ZgdFU73g1iTHJX7iCFxNuXYOOgAjHWeI3w/65S0q?=
 =?us-ascii?Q?NIP0zXRIpHOi1k641BdAVUmY0smttIWzrhl+FZyIorMyQt1Mn6vX7gHB+stC?=
 =?us-ascii?Q?+G5qsy6NOzSSZ/q1cPS3f0EbCqFwAf4CVGy1BntA6uZUaRGFVw4BXqlHEkq7?=
 =?us-ascii?Q?4k5gBCuVvZDnEK/MBhmJdTQ78WurqLRM2KJsuPmQ11FmtKRnvWtYDJ8GAwV8?=
 =?us-ascii?Q?M39TntZi+BS8PRSqmqI06Y/G2mPg8UFpjBCrstey7KPPo+OOREzoH9YnMs44?=
 =?us-ascii?Q?wLkmzfutVmGTKl2XcuoUq++fWoyHFYxy9zd+NNVzrhBcx8BhI75+czH/qf03?=
 =?us-ascii?Q?erjmyrEGYHKYTOzLGSgEf4R2BQ4aFmoc+Cb+1xcRcH1QXopYxjjG9JVyEhjS?=
 =?us-ascii?Q?Zj6nnnMEbCnhd5Cnu9SxxkFz33kZNU2Cj4kKHe/aW4IZ19mU4H7j34C3rE4l?=
 =?us-ascii?Q?tW8Qs1MVD+I0kcUC1rfjC1bDNTNLHWvBS0ZJK9j+NbQu2mSXuUs5oz5hm+vG?=
 =?us-ascii?Q?8wfzRrDm+5MUdGg0lUmuGFlC52PEDmUuHhdnbyg03N86pt3rpKBFr78fWD3X?=
 =?us-ascii?Q?JVvhIsKQInU/wilY7cdNeHqC1DyIuyjr3ozWjILMKjUZasiU1eURM3SC2+eZ?=
 =?us-ascii?Q?012DjLGPdyiYvXzLtubkJM9wzA46s9yUUtBDGOZ5xIeeCKmJYZ+an7Q0xqDg?=
 =?us-ascii?Q?GNrvcqbZ52okYA/QnNDVuW5w?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f2f861-6fb1-4df8-df84-08d8ecf77726
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:58:07.0937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOQP7Bdv/f9H52Ns9e3IXNytOysz29WCQTMsxdW0AF/7pTWGJweFIoMKx5mJZUfb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3967
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
 Feifei" <Feifei.Xu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1825717739=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1825717739==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45496D2DC3284EC1A4D363D297659MN2PR12MB4549namp_"

--_000_MN2PR12MB45496D2DC3284EC1A4D363D297659MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

v1: Aldebaran uses reset control to support mode2 reset. The sequences to
reset and restore hardware context are specific to a particular
configuration.

v2: Clear bus mastering before reset.
Fix coding style issues, drop unwanted variables and info log.

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/Makefile       |   2 +-
drivers/gpu/drm/amd/amdgpu/aldebaran.c    | 407 ++++++++++++++++++++++
drivers/gpu/drm/amd/amdgpu/aldebaran.h    |  32 ++
drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  16 +
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c     |   8 +-
5 files changed, 463 insertions(+), 2 deletions(-)
create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran.c
create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index a0a5fd1788b5..42153638a55c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -71,7 +71,7 @@ amdgpu-y +=3D \
               vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbi=
o_v7_0.o vega10_reg_init.o \
               vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_in=
it.o navi14_reg_init.o \
               arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_=
reg_init.o vangogh_reg_init.o \
-              nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.=
o aldebaran_reg_init.o
+             nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hdp_v5_0.o=
 aldebaran_reg_init.o aldebaran.o
 # add DF block
amdgpu-y +=3D \
diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.c
new file mode 100644
index 000000000000..39604a461bf5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -0,0 +1,407 @@
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
+#include "aldebaran.h"
+#include "amdgpu_reset.h"
+#include "amdgpu_amdkfd.h"
+#include "amdgpu_dpm.h"
+#include "amdgpu_job.h"
+#include "amdgpu_ring.h"
+#include "amdgpu_ras.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_xgmi.h"
+
+static struct amdgpu_reset_handler *
+aldebaran_get_reset_handler(struct amdgpu_reset_control *reset_ctl,
+                                                 struct amdgpu_reset_conte=
xt *reset_context)
+{
+             struct amdgpu_reset_handler *handler;
+             struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_=
ctl->handle;
+
+             if (reset_context->method !=3D AMD_RESET_METHOD_NONE) {
+                             dev_dbg(adev->dev, "Getting reset handler for=
 method %d\n",
+                                             reset_context->method);
+                             list_for_each_entry(handler, &reset_ctl->rese=
t_handlers,
+                                                                  handler_=
list) {
+                                             if (handler->reset_method =3D=
=3D reset_context->method)
+                                                             return handle=
r;
+                             }
+             }
+
+             if (adev->gmc.xgmi.connected_to_cpu) {
+                             list_for_each_entry(handler, &reset_ctl->rese=
t_handlers,
+                                                                  handler_=
list) {
+                                             if (handler->reset_method =3D=
=3D AMD_RESET_METHOD_MODE2) {
+                                                             reset_context=
->method =3D AMD_RESET_METHOD_MODE2;
+                                                             return handle=
r;
+                                             }
+                             }
+             }
+
+             dev_dbg(adev->dev, "Reset handler not found!\n");
+
+             return NULL;
+}
+
+static int aldebaran_mode2_suspend_ip(struct amdgpu_device *adev)
+{
+             int r, i;
+
+             amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+             amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
+
+             for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
+                             if (!(adev->ip_blocks[i].version->type =3D=3D
+                                                   AMD_IP_BLOCK_TYPE_GFX |=
|
+                                   adev->ip_blocks[i].version->type =3D=3D
+                                                   AMD_IP_BLOCK_TYPE_SDMA)=
)
+                                             continue;
+
+                             r =3D adev->ip_blocks[i].version->funcs->susp=
end(adev);
+
+                             if (r) {
+                                             dev_err(adev->dev,
+                                                             "suspend of I=
P block <%s> failed %d\n",
+                                                             adev->ip_bloc=
ks[i].version->funcs->name, r);
+                                             return r;
+                             }
+
+                             adev->ip_blocks[i].status.hw =3D false;
+             }
+
+             return r;
+}
+
+static int
+aldebaran_mode2_prepare_hwcontext(struct amdgpu_reset_control *reset_ctl,
+                                                               struct amdg=
pu_reset_context *reset_context)
+{
+             int r =3D 0;
+             struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_=
ctl->handle;
+
+             dev_dbg(adev->dev, "Aldebaran prepare hw context\n");
+             /* Don't suspend on bare metal if we are not going to HW rese=
t the ASIC */
+             if (!amdgpu_sriov_vf(adev))
+                             r =3D aldebaran_mode2_suspend_ip(adev);
+
+             return r;
+}
+
+void aldebaran_async_reset(struct work_struct *work)
+{
+             struct amdgpu_reset_handler *handler;
+             struct amdgpu_reset_control *reset_ctl =3D
+                             container_of(work, struct amdgpu_reset_contro=
l, reset_work);
+             struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_=
ctl->handle;
+
+             list_for_each_entry(handler, &reset_ctl->reset_handlers,
+                                                  handler_list) {
+                             if (handler->reset_method =3D=3D reset_ctl->a=
ctive_reset) {
+                                             dev_dbg(adev->dev, "Resetting=
 device\n");
+                                             handler->do_reset(adev);
+                                             break;
+                             }
+             }
+}
+
+static int aldebaran_mode2_reset(struct amdgpu_device *adev)
+{
+             /* disable BM */
+             pci_clear_master(adev->pdev);
+             adev->asic_reset_res =3D amdgpu_dpm_mode2_reset(adev);
+             return adev->asic_reset_res;
+}
+
+static int
+aldebaran_mode2_perform_reset(struct amdgpu_reset_control *reset_ctl,
+                                                   struct amdgpu_reset_con=
text *reset_context)
+{
+             struct amdgpu_device *tmp_adev =3D NULL;
+             struct amdgpu_device *adev =3D (struct amdgpu_device *)reset_=
ctl->handle;
+             int r =3D 0;
+
+             dev_dbg(adev->dev, "aldebaran perform hw reset\n");
+             if (reset_context->hive =3D=3D NULL) {
+                             /* Wrong context, return error */
+                             return -EINVAL;
+             }
+
+             list_for_each_entry(tmp_adev, &reset_context->hive->device_li=
st,
+                                                  gmc.xgmi.head) {
+                             mutex_lock(&tmp_adev->reset_cntl->reset_lock)=
;
+                             tmp_adev->reset_cntl->active_reset =3D AMD_RE=
SET_METHOD_MODE2;
+             }
+             /*
+             * Mode2 reset doesn't need any sync between nodes in XGMI hiv=
e, instead launch
+             * them together so that they can be completed asynchronously =
on multiple nodes
+             */
+             list_for_each_entry(tmp_adev, &reset_context->hive->device_li=
st,
+                                                  gmc.xgmi.head) {
+                             /* For XGMI run all resets in parallel to spe=
ed up the process */
+                             if (tmp_adev->gmc.xgmi.num_physical_nodes > 1=
) {
+                                             if (!queue_work(system_unboun=
d_wq,
+                                                                          =
   &tmp_adev->reset_cntl->reset_work))
+                                                             r =3D -EALREA=
DY;
+                             } else
+                                             r =3D aldebaran_mode2_reset(t=
mp_adev);
+                             if (r) {
+                                             dev_err(tmp_adev->dev,
+                                                             "ASIC reset f=
ailed with error, %d for drm dev, %s",
+                                                             r, adev_to_dr=
m(tmp_adev)->unique);
+                                             break;
+                             }
+             }
+
+             /* For XGMI wait for all resets to complete before proceed */
+             if (!r) {
+                             list_for_each_entry(tmp_adev,
+                                                                  &reset_c=
ontext->hive->device_list,
+                                                                  gmc.xgmi=
.head) {
+                                             if (tmp_adev->gmc.xgmi.num_ph=
ysical_nodes > 1) {
+                                                             flush_work(&t=
mp_adev->reset_cntl->reset_work);
+                                                             r =3D tmp_ade=
v->asic_reset_res;
+                                                             if (r)
+                                                                          =
   break;
+                                             }
+                             }
+             }
+
+             list_for_each_entry(tmp_adev, &reset_context->hive->device_li=
st,
+                                                  gmc.xgmi.head) {
+                             mutex_unlock(&tmp_adev->reset_cntl->reset_loc=
k);
+                             tmp_adev->reset_cntl->active_reset =3D AMD_RE=
SET_METHOD_NONE;
+             }
+
+             return r;
+}
+
+static int aldebaran_mode2_restore_ip(struct amdgpu_device *adev)
+{
+             struct amdgpu_firmware_info *ucode_list[AMDGPU_UCODE_ID_MAXIM=
UM];
+             struct amdgpu_firmware_info *ucode;
+             struct amdgpu_ip_block *cmn_block;
+             int ucode_count =3D 0;
+             int i, r;
+
+             dev_dbg(adev->dev, "Reloading ucodes after reset\n");
+             for (i =3D 0; i < adev->firmware.max_ucodes; i++) {
+                             ucode =3D &adev->firmware.ucode[i];
+                             if (!ucode->fw)
+                                             continue;
+                             switch (ucode->ucode_id) {
+                             case AMDGPU_UCODE_ID_SDMA0:
+                             case AMDGPU_UCODE_ID_SDMA1:
+                             case AMDGPU_UCODE_ID_SDMA2:
+                             case AMDGPU_UCODE_ID_SDMA3:
+                             case AMDGPU_UCODE_ID_SDMA4:
+                             case AMDGPU_UCODE_ID_SDMA5:
+                             case AMDGPU_UCODE_ID_SDMA6:
+                             case AMDGPU_UCODE_ID_SDMA7:
+                             case AMDGPU_UCODE_ID_CP_MEC1:
+                             case AMDGPU_UCODE_ID_CP_MEC1_JT:
+                             case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
+                             case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM=
:
+                             case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM=
:
+                             case AMDGPU_UCODE_ID_RLC_G:
+                                             ucode_list[ucode_count++] =3D=
 ucode;
+                                             break;
+                             default:
+                                             break;
+                             };
+             }
+
+             /* Reinit NBIF block */
+             cmn_block =3D
+                             amdgpu_device_ip_get_ip_block(adev, AMD_IP_BL=
OCK_TYPE_COMMON);
+             if (unlikely(!cmn_block)) {
+                             dev_err(adev->dev, "Failed to get BIF handle\=
n");
+                             return -EINVAL;
+             }
+             r =3D cmn_block->version->funcs->resume(adev);
+             if (r)
+                             return r;
+
+             /* Reinit GFXHUB */
+             adev->gfxhub.funcs->init(adev);
+             r =3D adev->gfxhub.funcs->gart_enable(adev);
+             if (r) {
+                             dev_err(adev->dev, "GFXHUB gart reenable fail=
ed after reset\n");
+                             return r;
+             }
+
+             /* Reload GFX firmware */
+             r =3D psp_load_fw_list(&adev->psp, ucode_list, ucode_count);
+             if (r) {
+                             dev_err(adev->dev, "GFX ucode load failed aft=
er reset\n");
+                             return r;
+             }
+
+             /* Resume RLC, FW needs RLC alive to complete reset process *=
/
+             adev->gfx.rlc.funcs->resume(adev);
+
+             /* Wait for FW reset event complete */
+             r =3D smu_wait_for_event(adev, SMU_EVENT_RESET_COMPLETE, 0);
+             if (r) {
+                             dev_err(adev->dev,
+                                             "Failed to get response from =
firmware after reset\n");
+                             return r;
+             }
+
+             for (i =3D 0; i < adev->num_ip_blocks; i++) {
+                             if (!(adev->ip_blocks[i].version->type =3D=3D
+                                                   AMD_IP_BLOCK_TYPE_GFX |=
|
+                                   adev->ip_blocks[i].version->type =3D=3D
+                                                   AMD_IP_BLOCK_TYPE_SDMA)=
)
+                                             continue;
+                             r =3D adev->ip_blocks[i].version->funcs->resu=
me(adev);
+                             if (r) {
+                                             dev_err(adev->dev,
+                                                             "resume of IP=
 block <%s> failed %d\n",
+                                                             adev->ip_bloc=
ks[i].version->funcs->name, r);
+                                             return r;
+                             }
+
+                             adev->ip_blocks[i].status.hw =3D true;
+             }
+
+             for (i =3D 0; i < adev->num_ip_blocks; i++) {
+                             if (!(adev->ip_blocks[i].version->type =3D=3D
+                                                   AMD_IP_BLOCK_TYPE_GFX |=
|
+                                   adev->ip_blocks[i].version->type =3D=3D
+                                                   AMD_IP_BLOCK_TYPE_SDMA =
||
+                                   adev->ip_blocks[i].version->type =3D=3D
+                                                   AMD_IP_BLOCK_TYPE_COMMO=
N))
+                                             continue;
+
+                             if (adev->ip_blocks[i].version->funcs->late_i=
nit) {
+                                             r =3D adev->ip_blocks[i].vers=
ion->funcs->late_init(
+                                                             (void *)adev)=
;
+                                             if (r) {
+                                                             dev_err(adev-=
>dev,
+                                                                          =
   "late_init of IP block <%s> failed %d after reset\n",
+                                                                          =
   adev->ip_blocks[i].version->funcs->name,
+                                                                          =
   r);
+                                                             return r;
+                                             }
+                             }
+                             adev->ip_blocks[i].status.late_initialized =
=3D true;
+             }
+
+             amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
+             amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
+
+             return r;
+}
+
+static int
+aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
+                                                               struct amdg=
pu_reset_context *reset_context)
+{
+             int r;
+             struct amdgpu_device *tmp_adev =3D NULL;
+
+             if (reset_context->hive =3D=3D NULL) {
+                             /* Wrong context, return error */
+                             return -EINVAL;
+             }
+
+             list_for_each_entry(tmp_adev, &reset_context->hive->device_li=
st,
+                                                  gmc.xgmi.head) {
+                             dev_info(tmp_adev->dev,
+                                             "GPU reset succeeded, trying =
to resume\n");
+                             r =3D aldebaran_mode2_restore_ip(tmp_adev);
+                             if (r)
+                                             goto end;
+
+                             /*
+                             * Add this ASIC as tracked as reset was alrea=
dy
+                             * complete successfully.
+                             */
+                             amdgpu_register_gpu_instance(tmp_adev);
+
+                             /* Resume RAS */
+                             amdgpu_ras_resume(tmp_adev);
+
+                             /* Update PSP FW topology after reset */
+                             if (reset_context->hive &&
+                                 tmp_adev->gmc.xgmi.num_physical_nodes > 1=
)
+                                             r =3D amdgpu_xgmi_update_topo=
logy(reset_context->hive,
+                                                                          =
                                   tmp_adev);
+
+                             if (!r) {
+                                             amdgpu_irq_gpu_reset_resume_h=
elper(tmp_adev);
+
+                                             r =3D amdgpu_ib_ring_tests(tm=
p_adev);
+                                             if (r) {
+                                                             dev_err(tmp_a=
dev->dev,
+                                                                          =
   "ib ring test failed (%d).\n", r);
+                                                             r =3D -EAGAIN=
;
+                                                             tmp_adev->asi=
c_reset_res =3D r;
+                                                             goto end;
+                                             }
+                             }
+             }
+
+end:
+             return r;
+}
+
+static struct amdgpu_reset_handler aldebaran_mode2_handler =3D {
+             .reset_method                 =3D AMD_RESET_METHOD_MODE2,
+             .prepare_env                    =3D NULL,
+             .prepare_hwcontext      =3D aldebaran_mode2_prepare_hwcontext=
,
+             .perform_reset                 =3D aldebaran_mode2_perform_re=
set,
+             .restore_hwcontext        =3D aldebaran_mode2_restore_hwconte=
xt,
+             .restore_env                      =3D NULL,
+             .do_reset                            =3D aldebaran_mode2_rese=
t,
+};
+
+int aldebaran_reset_init(struct amdgpu_device *adev)
+{
+             struct amdgpu_reset_control *reset_ctl;
+
+             reset_ctl =3D kzalloc(sizeof(*reset_ctl), GFP_KERNEL);
+             if (!reset_ctl)
+                             return -ENOMEM;
+
+             reset_ctl->handle =3D adev;
+             reset_ctl->async_reset =3D aldebaran_async_reset;
+             reset_ctl->active_reset =3D AMD_RESET_METHOD_NONE;
+             reset_ctl->get_reset_handler =3D aldebaran_get_reset_handler;
+
+             INIT_LIST_HEAD(&reset_ctl->reset_handlers);
+             INIT_WORK(&reset_ctl->reset_work, reset_ctl->async_reset);
+             /* Only mode2 is handled through reset control now */
+             amdgpu_reset_add_handler(reset_ctl, &aldebaran_mode2_handler)=
;
+
+             adev->reset_cntl =3D reset_ctl;
+
+             return 0;
+}
+
+int aldebaran_reset_fini(struct amdgpu_device *adev)
+{
+             kfree(adev->reset_cntl);
+             adev->reset_cntl =3D NULL;
+             return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.h b/drivers/gpu/drm/amd/a=
mdgpu/aldebaran.h
new file mode 100644
index 000000000000..a07db5454d49
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.h
@@ -0,0 +1,32 @@
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
+#ifndef __ALDEBARAN_H__
+#define __ALDEBARAN_H__
+
+#include "amdgpu.h"
+
+int aldebaran_reset_init(struct amdgpu_device *adev);
+int aldebaran_reset_fini(struct amdgpu_device *adev);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c
index 5bc94b8320ba..02afd4115675 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -36,6 +36,14 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
{
               int ret =3D 0;
+             switch (adev->asic_type) {
+             case CHIP_ALDEBARAN:
+                             ret =3D aldebaran_reset_init(adev);
+                             break;
+             default:
+                             break;
+             }
+
               return ret;
}
@@ -43,6 +51,14 @@ int amdgpu_reset_fini(struct amdgpu_device *adev)
{
               int ret =3D 0;
+             switch (adev->asic_type) {
+             case CHIP_ALDEBARAN:
+                             ret =3D aldebaran_reset_fini(adev);
+                             break;
+             default:
+                             break;
+             }
+
               return ret;
}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 63512370a51b..99f58439f3d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4024,8 +4024,14 @@ static int gfx_v9_0_hw_fini(void *handle)
               }
                gfx_v9_0_cp_enable(adev, false);
-              adev->gfx.rlc.funcs->stop(adev);
+             /* Skip suspend with A+A reset */
+             if (adev->gmc.xgmi.connected_to_cpu && amdgpu_in_reset(adev))=
 {
+                             dev_dbg(adev->dev, "Device in reset. Skipping=
 RLC halt\n");
+                             return 0;
+             }
+
+             adev->gfx.rlc.funcs->stop(adev);
               return 0;
}
--
2.17.1


--_000_MN2PR12MB45496D2DC3284EC1A4D363D297659MN2PR12MB4549namp_
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
<p class=3D"MsoNormal">v1: Aldebaran uses reset control to support mode2 re=
set. The sequences to<o:p></o:p></p>
<p class=3D"MsoNormal">reset and restore hardware context are specific to a=
 particular<o:p></o:p></p>
<p class=3D"MsoNormal">configuration.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v2: Clear bus mastering before reset.<o:p></o:p></p>
<p class=3D"MsoNormal">Fix coding style issues, drop unwanted variables and=
 info log.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.c&nbsp;&nbsp;&n=
bsp; | 407 ++++++++++++++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/aldebaran.h&nbsp;&nbsp;&n=
bsp; |&nbsp; 32 ++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |&nbsp; 16=
 +<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nb=
sp;&nbsp; |&nbsp;&nbsp; 8 +-<o:p></o:p></p>
<p class=3D"MsoNormal">5 files changed, 463 insertions(+), 2 deletions(-)<o=
:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/aldeba=
ran.c<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 drivers/gpu/drm/amd/amdgpu/aldeba=
ran.h<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/d=
rivers/gpu/drm/amd/amdgpu/Makefile<o:p></o:p></p>
<p class=3D"MsoNormal">index a0a5fd1788b5..42153638a55c 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/Makefile<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/Makefile<o:p></o:p>=
</p>
<p class=3D"MsoNormal">@@ -71,7 +71,7 @@ amdgpu-y +=3D \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_so=
c.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o =
nv.o navi10_reg_init.o navi14_reg_init.o \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arct_reg_init.o navi12_reg_init.o mxgpu_nv=
.o sienna_cichlid_reg_init.o vangogh_reg_init.o \<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_=
0.o hdp_v5_0.o aldebaran_reg_init.o<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; nbio_v7_2.o dimgrey_cavefish_reg_init.o hdp_v4_0.o hd=
p_v5_0.o aldebaran_reg_init.o aldebaran.o<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;# add DF block<o:p></o:p></p>
<p class=3D"MsoNormal">amdgpu-y +=3D \<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c =
b/drivers/gpu/drm/amd/amdgpu/aldebaran.c<o:p></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 000000000000..39604a461bf5<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -0,0 +1,407 @@<o:p></o:p></p>
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
<p class=3D"MsoNormal">+#include &quot;aldebaran.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_reset.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_amdkfd.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_dpm.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_job.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_ring.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_ras.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_psp.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu_xgmi.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static struct amdgpu_reset_handler *<o:p></o:p></p>
<p class=3D"MsoNormal">+aldebaran_get_reset_handler(struct amdgpu_reset_con=
trol *reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; struct amdgpu_reset_context *reset_context)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_handler *handler;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct amdgpu_device =
*)reset_ctl-&gt;handle;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;method !=3D AMD_RESET_METHOD_NO=
NE) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Gett=
ing reset handler for method %d\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_conte=
xt-&gt;method);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(handler, &am=
p;reset_ctl-&gt;reset_handlers,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; handler_list) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (handler=
-&gt;reset_method =3D=3D reset_context-&gt;method)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return handler;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu) {<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(handler, &am=
p;reset_ctl-&gt;reset_handlers,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; handler_list) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (handler=
-&gt;reset_method =3D=3D AMD_RESET_METHOD_MODE2) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; reset_context-&gt;method =3D AMD_RESET_METHOD_MODE2;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return handler;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Reset handler not found!\=
n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int aldebaran_mode2_suspend_ip(struct amdgpu=
_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int r, i;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip_blocks - 1; i &gt;=3D 0; i=
--) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;ip_blocks[i].vers=
ion-&gt;type =3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_GFX ||<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;ip_blocks[i].version-&gt;type =3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_SDMA))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;ip_blocks[i].vers=
ion-&gt;funcs-&gt;suspend(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(ade=
v-&gt;dev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &quot;suspend of IP block &lt;%s&gt; failed %d\n&quot;,<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].status.hw =
=3D false;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int<o:p></o:p></p>
<p class=3D"MsoNormal">+aldebaran_mode2_prepare_hwcontext(struct amdgpu_res=
et_control *reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp; struct amdgpu_reset_context *reset_context)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int r =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct amdgpu_device =
*)reset_ctl-&gt;handle;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Aldebaran prepare hw cont=
ext\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Don't suspend on bare metal if we are not going to=
 HW reset the ASIC */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D aldebaran_mode2_suspend_ip=
(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+void aldebaran_async_reset(struct work_struct *work=
)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_handler *handler;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control *reset_ctl =3D<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of(work, struct amdgpu=
_reset_control, reset_work);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct amdgpu_device =
*)reset_ctl-&gt;handle;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_for_each_entry(handler, &amp;reset_ctl-&gt;reset=
_handlers,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; handler_list) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (handler-&gt;reset_method =3D=
=3D reset_ctl-&gt;active_reset) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(ade=
v-&gt;dev, &quot;Resetting device\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; handler-&gt=
;do_reset(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int aldebaran_mode2_reset(struct amdgpu_devi=
ce *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* disable BM */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci_clear_master(adev-&gt;pdev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_reset_res =3D amdgpu_dpm_mode2_reset(ad=
ev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return adev-&gt;asic_reset_res;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int<o:p></o:p></p>
<p class=3D"MsoNormal">+aldebaran_mode2_perform_reset(struct amdgpu_reset_c=
ontrol *reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context *reset_context)<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev =3D NULL;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct amdgpu_device =
*)reset_ctl-&gt;handle;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int r =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;aldebaran perform hw rese=
t\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;hive =3D=3D NULL) {<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wrong context, return error *=
/<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, &amp;reset_context-&gt;=
hive-&gt;device_list,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; gmc.xgmi.head) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;tmp_adev-&gt;res=
et_cntl-&gt;reset_lock);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;reset_cntl-&gt;acti=
ve_reset =3D AMD_RESET_METHOD_MODE2;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * Mode2 reset doesn't need any sync between nodes in =
XGMI hive, instead launch<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; * them together so that they can be completed asynchr=
onously on multiple nodes<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, &amp;reset_context-&gt;=
hive-&gt;device_list,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; gmc.xgmi.head) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI run all resets in pa=
rallel to speed up the process */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_adev-&gt;gmc.xgmi.num_ph=
ysical_nodes &gt; 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!queue_=
work(system_unbound_wq,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;tmp_adev-&gt;reset_cntl-&gt;reset_work)=
)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; r =3D -EALREADY;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D aldeb=
aran_mode2_reset(tmp_adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(tmp=
_adev-&gt;dev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &quot;ASIC reset failed with error, %d for drm dev, %s&quot;,<o:p=
></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; r, adev_to_drm(tmp_adev)-&gt;unique);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* For XGMI wait for all resets to complete before pr=
oceed */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!r) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev,<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &amp;reset_context-&gt;hive-&gt;device_l=
ist,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; gmc.xgmi.head) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tmp_ade=
v-&gt;gmc.xgmi.num_physical_nodes &gt; 1) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; flush_work(&amp;tmp_adev-&gt;reset_cntl-&gt;reset_work);<o:p></o:=
p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; r =3D tmp_adev-&gt;asic_reset_res;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, &amp;reset_context-&gt;=
hive-&gt;device_list,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; gmc.xgmi.head) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;tmp_adev-&gt;r=
eset_cntl-&gt;reset_lock);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;reset_cntl-&gt;acti=
ve_reset =3D AMD_RESET_METHOD_NONE;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int aldebaran_mode2_restore_ip(struct amdgpu=
_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_info *ucode_list[AMDGPU_UCODE_=
ID_MAXIMUM];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_info *ucode;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_ip_block *cmn_block;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ucode_count =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int i, r;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Reloading ucodes after re=
set\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;firmware.max_ucodes; i+=
+) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode =3D &amp;adev-&gt;firmware=
.ucode[i];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ucode-&gt;fw)<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ucode-&gt;ucode_id) {<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA0:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA1:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA2:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA3:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA4:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA5:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA6:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA7:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1:<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1_JT:=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_RESTORE=
_LIST_CNTL:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_RESTORE=
_LIST_GPM_MEM:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_RESTORE=
_LIST_SRM_MEM:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_G:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode_list[=
ucode_count++] =3D ucode;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Reinit NBIF block */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cmn_block =3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_get_ip_block(ad=
ev, AMD_IP_BLOCK_TYPE_COMMON);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(!cmn_block)) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;Fail=
ed to get BIF handle\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D cmn_block-&gt;version-&gt;funcs-&gt;resume(adev=
);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Reinit GFXHUB */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfxhub.funcs-&gt;init(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;gfxhub.funcs-&gt;gart_enable(adev);<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;GFXH=
UB gart reenable failed after reset\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Reload GFX firmware */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D psp_load_fw_list(&amp;adev-&gt;psp, ucode_list,=
 ucode_count);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;GFX =
ucode load failed after reset\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Resume RLC, FW needs RLC alive to complete reset p=
rocess */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;resume(adev);<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Wait for FW reset event complete */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D smu_wait_for_event(adev, SMU_EVENT_RESET_COMPLE=
TE, 0);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev,<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Faile=
d to get response from firmware after reset\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num_ip_blocks; i++) {<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;ip_blocks[i].vers=
ion-&gt;type =3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_GFX ||<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;ip_blocks[i].version-&gt;type =3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp;AMD_IP_BLOCK_TYPE_SDMA))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;ip_blocks[i].vers=
ion-&gt;funcs-&gt;resume(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(ade=
v-&gt;dev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &quot;resume of IP block &lt;%s&gt; failed %d\n&quot;,<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;name, r);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].status.hw =
=3D true;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num_ip_blocks; i++) {<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;ip_blocks[i].vers=
ion-&gt;type =3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_GFX ||<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;ip_blocks[i].version-&gt;type =3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_SDMA ||<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;ip_blocks[i].version-&gt;type =3D=3D<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE_COMMON))<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].versio=
n-&gt;funcs-&gt;late_init) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D adev-=
&gt;ip_blocks[i].version-&gt;funcs-&gt;late_init(<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; (void *)adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dev_err(adev-&gt;dev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;late_init of IP block &lt;%s&gt; faile=
d %d after reset\n&quot;,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;funcs-&gt;=
name,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].status.lat=
e_initialized =3D true;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);<=
o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static int<o:p></o:p></p>
<p class=3D"MsoNormal">+aldebaran_mode2_restore_hwcontext(struct amdgpu_res=
et_control *reset_ctl,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; &nbsp; struct amdgpu_reset_context *reset_context)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int r;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_adev =3D NULL;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;hive =3D=3D NULL) {<o:p></o:p><=
/p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wrong context, return error *=
/<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, &amp;reset_context-&gt;=
hive-&gt;device_list,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;&nbsp; gmc.xgmi.head) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(tmp_adev-&gt;dev,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GPU r=
eset succeeded, trying to resume\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D aldebaran_mode2_restore_ip=
(tmp_adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto end;<o=
:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Add this ASIC as tracked as re=
set was already<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * complete successfully.<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_register_gpu_instance(tmp=
_adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Resume RAS */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_resume(tmp_adev);<o:p=
></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update PSP FW topology after =
reset */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset_context-&gt;hive &amp;=
&amp;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;&nbsp;tmp_adev-&gt;=
gmc.xgmi.num_physical_nodes &gt; 1)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_xgmi_update_topology(reset_context-&gt;hive,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tm=
p_adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_=
gpu_reset_resume_helper(tmp_adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgp=
u_ib_ring_tests(tmp_adev);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dev_err(tmp_adev-&gt;dev,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ib ring test failed (%d).\n&quot;, r);=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; r =3D -EAGAIN;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; tmp_adev-&gt;asic_reset_res =3D r;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; goto end;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+end:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+static struct amdgpu_reset_handler aldebaran_mode2_=
handler =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .reset_method&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D AMD_RESET_METH=
OD_MODE2,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .prepare_env&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D NULL,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .prepare_hwcontext&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D =
aldebaran_mode2_prepare_hwcontext,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .perform_reset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D aldebaran_mod=
e2_perform_reset,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .restore_hwcontext&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D aldebaran_mode2_restore_hwcontext,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .restore_env&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; =3D NULL,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .do_reset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D aldebaran_mode2_reset,<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+};<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int aldebaran_reset_init(struct amdgpu_device *adev=
)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_control *reset_ctl;<o:p></o:p></p=
>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reset_ctl =3D kzalloc(sizeof(*reset_ctl), GFP_KERNEL)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!reset_ctl)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reset_ctl-&gt;handle =3D adev;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reset_ctl-&gt;async_reset =3D aldebaran_async_reset;<=
o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reset_ctl-&gt;active_reset =3D AMD_RESET_METHOD_NONE;=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reset_ctl-&gt;get_reset_handler =3D aldebaran_get_res=
et_handler;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;reset_ctl-&gt;reset_handlers);<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;reset_ctl-&gt;reset_work, reset_ctl-&g=
t;async_reset);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Only mode2 is handled through reset control now */=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_reset_add_handler(reset_ctl, &amp;aldebaran_mo=
de2_handler);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_cntl =3D reset_ctl;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int aldebaran_reset_fini(struct amdgpu_device *adev=
)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kfree(adev-&gt;reset_cntl);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;reset_cntl =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.h =
b/drivers/gpu/drm/amd/amdgpu/aldebaran.h<o:p></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 000000000000..a07db5454d49<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.h<o:p></o=
:p></p>
<p class=3D"MsoNormal">@@ -0,0 +1,32 @@<o:p></o:p></p>
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
<p class=3D"MsoNormal">+#ifndef __ALDEBARAN_H__<o:p></o:p></p>
<p class=3D"MsoNormal">+#define __ALDEBARAN_H__<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#include &quot;amdgpu.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int aldebaran_reset_init(struct amdgpu_device *adev=
);<o:p></o:p></p>
<p class=3D"MsoNormal">+int aldebaran_reset_fini(struct amdgpu_device *adev=
);<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+#endif<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset=
.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 5bc94b8320ba..02afd4115675 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">@@ -36,6 +36,14 @@ int amdgpu_reset_init(struct amdg=
pu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_reset_init(ade=
v);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">@@ -43,6 +51,14 @@ int amdgpu_reset_fini(struct amdg=
pu_device *adev)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_reset_fini(ade=
v);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; default:<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b=
/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 63512370a51b..99f58439f3d5 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<o:p></o:=
p></p>
<p class=3D"MsoNormal">@@ -4024,8 +4024,14 @@ static int gfx_v9_0_hw_fini(v=
oid *handle)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_cp_enable(adev, false);<o:p=
></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;stop(adev);<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Skip suspend with A+A reset */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.connected_to_cpu &amp;&amp; amd=
gpu_in_reset(adev)) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(adev-&gt;dev, &quot;Devi=
ce in reset. Skipping RLC halt\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.funcs-&gt;stop(adev);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45496D2DC3284EC1A4D363D297659MN2PR12MB4549namp_--

--===============1825717739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1825717739==--
