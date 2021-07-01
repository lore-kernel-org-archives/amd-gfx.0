Return-Path: <SRS0=TGuI=LZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B7C11F64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 08:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDF6361452
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jul 2021 08:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF6361452
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF586E841;
	Thu,  1 Jul 2021 08:38:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042EA89C96
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jul 2021 08:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+fe8xlfU3Pk7vaI3+dsTq2MnLT2Tcd9ZN8oqdcWI+XqCmURAC8EcEXG7lllD5T8KY5WDlM7spe0JxxvabLPzKU+Az6qy3zvGksnVfhirZSbXppsTiclbejsuA6CtC+PuB2Kc4Gx4B24dCG4ms5kMzMttrl3ak0dXbenGJBJp8qBpFH+Ev8EnU1Zg9zJk/8kSvv5DtbGNRS1g6k2idchviOXa7XRut+/jdNxSjIqc50DihUneAZmmOVRTeZDb3OKIo4wLjSpydHLK6qPdmC6lSPXu8o1IctX6uNq5YOFUtu1hrlaRpd/jHReiTHDmyDXZGnc34wTB4zChML2aqaYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJTA/Y+s+R0T0l+n5YHZg7zNnx2d3QS6o/Yin6NO9Tc=;
 b=OvUX+a/YlGSIkMbNpJ8Q2LPZCoAErVwtrt2qRS6ckVrftnCAYAd1wA+5NAOYtB5IeaHfl81sshfHtM4A2sVw/yk5vhXsr6eKyYNfQeK3VbylkWDPxEJPwrY544rUMfDGADiZBfqxifdo05ZiHhmjLSdt5eDF2QIKU+n0qcTj7eXrYC7hXye/4L3eQchVihoVe6Dz0OqN7DeS309d6nsqXproC0s/ZNl7BGsDwNzv6GfdcoGiIMrfxoeFvDFjHKpQ4pcpqqRoI2VejMu8P06SPv1tWUgvlFNy90ectXyH2zc1F51GzMWOc2JRoruzx2w+ojkAShalt2BbhcwsfDyojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJTA/Y+s+R0T0l+n5YHZg7zNnx2d3QS6o/Yin6NO9Tc=;
 b=hUZgy3lLZ514kkoL7Qf7iVobcLXFQcoadKhKuSE/RtnPANU4f5VQtazYk5ZcGHWJQakyfwRdhLrBvoHTC0UyUZRI1lSsgyQVOV/Hye++v5SZsHlX6RdwpWrQjjho2mBZ13VgVv6kpbePmlgf+mOsYGv4rPWaMqPyaqwHhywOGww=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Thu, 1 Jul
 2021 08:38:29 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::4117:5516:ddb7:1514]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::4117:5516:ddb7:1514%7]) with mapi id 15.20.4287.021; Thu, 1 Jul 2021
 08:38:29 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/pm: drop smu_v13_0_1.c|h files for yellow carp
Thread-Topic: [PATCH] drm/amd/pm: drop smu_v13_0_1.c|h files for yellow carp
Thread-Index: AQHXblOP860U2Zh8ZEaQzPbE2tVGB6stzDIR
Date: Thu, 1 Jul 2021 08:38:29 +0000
Message-ID: <CO6PR12MB5473E8076417AACEE7949961A2009@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20210701083121.10437-1-Xiaomeng.Hou@amd.com>
In-Reply-To: <20210701083121.10437-1-Xiaomeng.Hou@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-01T08:38:27.659Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD-Official
 Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [112.65.12.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a0b45bd-8e3d-406f-805c-08d93c6b99f2
x-ms-traffictypediagnostic: CO6PR12MB5394:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO6PR12MB5394AE0147343D184575A9FCA2009@CO6PR12MB5394.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHGhrGMYb91EnZHc70qu5VMwPbZ3mVoGbGoNu08hVmwHJbQ1lyqACDL3L8JNYgoCFDo7YTtwqNcUUCoBY6/rgeCUiTEPdWzI80VrFq5rfUOAdZymOLG+ocrM15MI3rw4sVW1d+KpQy03fsQsJX8fSasS2ijhf5Xuatg/kE5vP0JVBnQU/0ldeATAK6LGbGh+QJvPbqWHE1ObZ43QJf2GXAiCnDmO5vKBGnxvrDCriA//M+tMu4qx1rL0CeNMbyweUgHTOoD7995kFVQA9H4i/5CI/ulyqiiGTkKQJ02tT1SthQ7sYGic3KhsJRjOt7JxaKmG7P4RyrgY43O/rOtGtHgg8YY3Rk0CGxXdMg8H7ihHqWSdkpkqbNSyjvs60aq9enbsfK2XzwG9iAs69JK3rSQ4B6v5E07iNo3NpYZEJKQHlqEjOwWN/O/9uQKBw4FbhG28/6bOoSKUy0FvARIfhgpAlfrtrQh+Ib4V/egrjqhUNIEM7eqKYrI/7hVyU8XonVW6+i86b1566YrQ7igPgfu2kZqBc0H/ZAB4dqA3F4CL1c6geYVRIHL/YvaqWXn38bSrYYiU6PqaOEV5lFiWopnRfHXrftBN2V+EvcdsFlbnBSF1zTXr0G0I1Spkc2n6isSQS0ynio7EYax77Guffw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(53546011)(6506007)(5660300002)(86362001)(122000001)(4326008)(30864003)(316002)(26005)(33656002)(186003)(38100700002)(66446008)(64756008)(2906002)(55016002)(8936002)(52536014)(19627405001)(66556008)(8676002)(66476007)(110136005)(54906003)(478600001)(7696005)(83380400001)(71200400001)(91956017)(66946007)(76116006)(9686003)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?denb0KheHchtPzQV//oloFh13+OWqGdIIZmXQ/Rh6EgjNri8EQGrz4lJPk?=
 =?iso-8859-1?Q?rYc4KIkrtX+MRCpAJe+0c1NsCUTRPXiH15OlaTgdoB8sNZmdO8tG1Fe11Y?=
 =?iso-8859-1?Q?oP+U1LEaMelD4/iSDQnX8jc3YthZVSBrvzb9SQs5OwGB39Rx3O6vdLjbs8?=
 =?iso-8859-1?Q?/hrZtMeps7+c9X3nipRv9zQBB7JaLspOU51kKQ3oFC2SzQRKyiE+5ikuN8?=
 =?iso-8859-1?Q?/uwP/PeHIEY0llV9ZUowAXKktpo/ZCifSF8j8uJPPo/H1Gz+HstvWXRNHQ?=
 =?iso-8859-1?Q?w4AzktRBZWWyNlFOnYaRKkdDo7WOyUzuOJ849R02mceAB+TQFfhwc0oyWz?=
 =?iso-8859-1?Q?Vl+WEXDEegFdgVaNlbGh2Y33LvpJhutOBC1W+35e34x/iekleknHzgwmgg?=
 =?iso-8859-1?Q?ID0YyNv5sMqEO0dAMPUYzkWcXgc4lXIr04BI54On2+Ne9xO6fgT+LBmK7g?=
 =?iso-8859-1?Q?QQQi0MxqFwbM6sG0YfVh/OHSgXa72BiXHITGqESPD96trxbh3uPT6kGuva?=
 =?iso-8859-1?Q?OGqoP50KeZ5PpwCOibhAFwgWBNbB5KV13jseQDzgBdUKSPhbAJyom8jsGL?=
 =?iso-8859-1?Q?PxA4EF5BrLLVEbkbVmEvHJ1vbKE4dOytZfxzGwOgBrw6XrHDw6ZfXUCMyi?=
 =?iso-8859-1?Q?+FdRiAParkpL771F2JdikNUCpGkIpBLLs5jJcFL0OQ3efbVh7zyY63BZl4?=
 =?iso-8859-1?Q?SdPZV0gE0KhimFYcMCPzpSj3Pi6TfEs2mVExHcXTr5BxVAx8obQojrWFR2?=
 =?iso-8859-1?Q?rl/GxN7y1J3HnBhhDMv12Mz/XZbDKeUCUrrBK/7qwfRik/I9sFx0KZIXKT?=
 =?iso-8859-1?Q?Z6RAHqXJOUkhkqEClbgf18bnU7yYqU3s/92MK8Nr89ws8m6mD4Si0JqPY0?=
 =?iso-8859-1?Q?1Gz5ABia/rQIKZK6a3WYAlpYfvJ6GweGhFs8k4Ei3SlSJGdeLeoNflScuj?=
 =?iso-8859-1?Q?bP62PlPvuLQpOkKBZo4nuY92ACxOrVaH2n2rDuPOATbCReFe98+ERbD4Lj?=
 =?iso-8859-1?Q?FhUyYB7GCG6T9YWrX6xNoPVVTDlArLkghW7R5MRynHn4va8J46IaYSVsNU?=
 =?iso-8859-1?Q?QKDHJKzOcNpq5pQM9wKLEhml2UoYj06+ud+3YcQRBE4QMKg8g93sZISdNN?=
 =?iso-8859-1?Q?eKO+W4MFncDu5FMcK1t2cuHUKwFHaZA6XF/I70sK6lK3lEcOsRGfRJVhpb?=
 =?iso-8859-1?Q?Tm2R3N/vjdKlTiPsJEy13mzgvF+ILLFAbeRxrGasL4v+p2LhVFfnZM7Tmv?=
 =?iso-8859-1?Q?BmYK8Z1+cgu3PW2nBN7ayZD6zy9Uhew2dFpZWwbN88cetd4sBCG3Ghw95u?=
 =?iso-8859-1?Q?R9RRpXeLdYJucgNmvUNS9MOC9o5BNNIIsCwgcJfgCz7Dx6s=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0b45bd-8e3d-406f-805c-08d93c6b99f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 08:38:29.0404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NHfhVGuD+okWl5ZBU9V0dWh98QvqltLaiWCwdHbIbZRENu/WCxcMHJTvWbAxPv1v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============1959850284=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1959850284==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CO6PR12MB5473E8076417AACEE7949961A2009CO6PR12MB5473namp_"

--_000_CO6PR12MB5473E8076417AACEE7949961A2009CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Best Regards,
Kevin

________________________________
From: Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
Sent: Thursday, July 1, 2021 4:31 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.co=
m>; Liu, Aaron <Aaron.Liu@amd.com>; Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@a=
md.com>
Subject: [PATCH] drm/amd/pm: drop smu_v13_0_1.c|h files for yellow carp

Since there's nothing special in smu implementation for yellow carp,
it's better to reuse the common smu_v13_0 interfaces and drop the
specific smu_v13_0_1.c|h files.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h        |   1 +
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h      |  57 ----
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  26 ++
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c  | 311 ------------------
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  39 ++-
 6 files changed, 59 insertions(+), 377 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
 delete mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v13_0.h
index 6119a36b2cba..3fea2430dec0 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
@@ -26,6 +26,7 @@
 #include "amdgpu_smu.h"

 #define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF
+#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x03
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x07

 /* MP Apertures */
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h b/drivers/gpu/drm/amd=
/pm/inc/smu_v13_0_1.h
deleted file mode 100644
index b6c976a4d578..000000000000
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/*
- * Copyright 2020 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-#ifndef __SMU_V13_0_1_H__
-#define __SMU_V13_0_1_H__
-
-#include "amdgpu_smu.h"
-
-#define SMU13_0_1_DRIVER_IF_VERSION_INV 0xFFFFFFFF
-#define SMU13_0_1_DRIVER_IF_VERSION_YELLOW_CARP 0x3
-
-/* MP Apertures */
-#define MP0_Public                     0x03800000
-#define MP0_SRAM                       0x03900000
-#define MP1_Public                     0x03b00000
-#define MP1_SRAM                       0x03c00004
-
-/* address block */
-#define smnMP1_FIRMWARE_FLAGS          0x3010024
-
-
-#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)
-
-int smu_v13_0_1_check_fw_status(struct smu_context *smu);
-
-int smu_v13_0_1_check_fw_version(struct smu_context *smu);
-
-int smu_v13_0_1_fini_smc_tables(struct smu_context *smu);
-
-int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu);
-
-int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu);
-
-int smu_v13_0_1_set_driver_table_location(struct smu_context *smu);
-
-int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool enable);
-#endif
-#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/=
amd/pm/swsmu/smu13/Makefile
index 9b3a8503f5cd..d4c4c495762c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
@@ -23,7 +23,7 @@
 # Makefile for the 'smu manager' sub-component of powerplay.
 # It provides the smu management services for the driver.

-SMU13_MGR =3D smu_v13_0.o aldebaran_ppt.o smu_v13_0_1.o yellow_carp_ppt.o
+SMU13_MGR =3D smu_v13_0.o aldebaran_ppt.o yellow_carp_ppt.o

 AMD_SWSMU_SMU13MGR =3D $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index a3dc7194aaf8..cbce982f2717 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -41,6 +41,8 @@

 #include "asic_reg/thm/thm_13_0_2_offset.h"
 #include "asic_reg/thm/thm_13_0_2_sh_mask.h"
+#include "asic_reg/mp/mp_13_0_1_offset.h"
+#include "asic_reg/mp/mp_13_0_1_sh_mask.h"
 #include "asic_reg/mp/mp_13_0_2_offset.h"
 #include "asic_reg/mp/mp_13_0_2_sh_mask.h"
 #include "asic_reg/smuio/smuio_13_0_2_offset.h"
@@ -210,6 +212,9 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
         case CHIP_ALDEBARAN:
                 smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_ALD=
E;
                 break;
+       case CHIP_YELLOW_CARP:
+               smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_YELL=
OW_CARP;
+               break;
         default:
                 dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n",=
 smu->adev->asic_type);
                 smu->smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_INV=
;
@@ -694,6 +699,27 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu=
)
         return ret;
 }

+int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
+{
+       int ret =3D 0;
+       struct amdgpu_device *adev =3D smu->adev;
+
+       switch (adev->asic_type) {
+       case CHIP_YELLOW_CARP:
+               if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
+                       return 0;
+               if (enable)
+                       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxO=
ff, NULL);
+               else
+                       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowG=
fxOff, NULL);
+               break;
+       default:
+               break;
+       }
+
+       return ret;
+}
+
 int smu_v13_0_system_features_control(struct smu_context *smu,
                                       bool en)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
deleted file mode 100644
index 61917b49f2bf..000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c
+++ /dev/null
@@ -1,311 +0,0 @@
-/*
- * Copyright 2020 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- */
-
-//#include <linux/reboot.h>
-
-#define SWSMU_CODE_LAYER_L3
-
-#include "amdgpu.h"
-#include "amdgpu_smu.h"
-#include "smu_v13_0_1.h"
-#include "soc15_common.h"
-#include "smu_cmn.h"
-#include "atomfirmware.h"
-#include "amdgpu_atomfirmware.h"
-#include "amdgpu_atombios.h"
-#include "atom.h"
-
-#include "asic_reg/mp/mp_13_0_1_offset.h"
-#include "asic_reg/mp/mp_13_0_1_sh_mask.h"
-
-/*
- * DO NOT use these for err/warn/info/debug messages.
- * Use dev_err, dev_warn, dev_info and dev_dbg instead.
- * They are more MGPU friendly.
- */
-#undef pr_err
-#undef pr_warn
-#undef pr_info
-#undef pr_debug
-
-int smu_v13_0_1_check_fw_status(struct smu_context *smu)
-{
-       struct amdgpu_device *adev =3D smu->adev;
-       uint32_t mp1_fw_flags;
-
-       mp1_fw_flags =3D RREG32_PCIE(MP1_Public |
-                                  (smnMP1_FIRMWARE_FLAGS & 0xffffffff));
-
-       if ((mp1_fw_flags & MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK) >>
-           MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED__SHIFT)
-               return 0;
-
-       return -EIO;
-}
-
-int smu_v13_0_1_check_fw_version(struct smu_context *smu)
-{
-       uint32_t if_version =3D 0xff, smu_version =3D 0xff;
-       uint16_t smu_major;
-       uint8_t smu_minor, smu_debug;
-       int ret =3D 0;
-
-       ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
-       if (ret)
-               return ret;
-
-       smu_major =3D (smu_version >> 16) & 0xffff;
-       smu_minor =3D (smu_version >> 8) & 0xff;
-       smu_debug =3D (smu_version >> 0) & 0xff;
-
-       switch (smu->adev->asic_type) {
-       case CHIP_YELLOW_CARP:
-               smu->smc_driver_if_version =3D SMU13_0_1_DRIVER_IF_VERSION_=
YELLOW_CARP;
-               break;
-
-       default:
-               dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", =
smu->adev->asic_type);
-               smu->smc_driver_if_version =3D SMU13_0_1_DRIVER_IF_VERSION_=
INV;
-               break;
-       }
-
-       dev_info(smu->adev->dev, "smu fw reported version =3D 0x%08x (%d.%d=
.%d)\n",
-                        smu_version, smu_major, smu_minor, smu_debug);
-
-       /*
-        * 1. if_version mismatch is not critical as our fw is designed
-        * to be backward compatible.
-        * 2. New fw usually brings some optimizations. But that's visible
-        * only on the paired driver.
-        * Considering above, we just leave user a warning message instead
-        * of halt driver loading.
-        */
-       if (if_version !=3D smu->smc_driver_if_version) {
-               dev_info(smu->adev->dev, "smu driver if version =3D 0x%08x,=
 smu fw if version =3D 0x%08x, "
-                        "smu fw version =3D 0x%08x (%d.%d.%d)\n",
-                        smu->smc_driver_if_version, if_version,
-                        smu_version, smu_major, smu_minor, smu_debug);
-               dev_warn(smu->adev->dev, "SMU driver if version not matched=
\n");
-       }
-
-       return ret;
-}
-
-int smu_v13_0_1_fini_smc_tables(struct smu_context *smu)
-{
-       struct smu_table_context *smu_table =3D &smu->smu_table;
-
-       kfree(smu_table->clocks_table);
-       smu_table->clocks_table =3D NULL;
-
-       kfree(smu_table->metrics_table);
-       smu_table->metrics_table =3D NULL;
-
-       kfree(smu_table->watermarks_table);
-       smu_table->watermarks_table =3D NULL;
-
-       return 0;
-}
-
-static int smu_v13_0_1_atom_get_smu_clockinfo(struct amdgpu_device *adev,
-                                               uint8_t clk_id,
-                                               uint8_t syspll_id,
-                                               uint32_t *clk_freq)
-{
-       struct atom_get_smu_clock_info_parameters_v3_1 input =3D {0};
-       struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
-       int ret, index;
-
-       input.clk_id =3D clk_id;
-       input.syspll_id =3D syspll_id;
-       input.command =3D GET_SMU_CLOCK_INFO_V3_1_GET_CLOCK_FREQ;
-       index =3D get_index_into_master_table(atom_master_list_of_command_f=
unctions_v2_1,
-                                           getsmuclockinfo);
-
-       ret =3D amdgpu_atom_execute_table(adev->mode_info.atom_context, ind=
ex,
-                                       (uint32_t *)&input);
-       if (ret)
-               return -EINVAL;
-
-       output =3D (struct atom_get_smu_clock_info_output_parameters_v3_1 *=
)&input;
-       *clk_freq =3D le32_to_cpu(output->atom_smu_outputclkfreq.smu_clock_=
freq_hz) / 10000;
-
-       return 0;
-}
-
-int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu)
-{
-       int ret, index;
-       uint16_t size;
-       uint8_t frev, crev;
-       struct atom_common_table_header *header;
-       struct atom_firmware_info_v3_4 *v_3_4;
-       struct atom_firmware_info_v3_3 *v_3_3;
-       struct atom_firmware_info_v3_1 *v_3_1;
-
-       index =3D get_index_into_master_table(atom_master_list_of_data_tabl=
es_v2_1,
-                                           firmwareinfo);
-
-       ret =3D amdgpu_atombios_get_data_table(smu->adev, index, &size, &fr=
ev, &crev,
-                                            (uint8_t **)&header);
-       if (ret)
-               return ret;
-
-       if (header->format_revision !=3D 3) {
-               dev_err(smu->adev->dev, "unknown atom_firmware_info version=
! for smu13\n");
-               return -EINVAL;
-       }
-
-       switch (header->content_revision) {
-       case 0:
-       case 1:
-       case 2:
-               v_3_1 =3D (struct atom_firmware_info_v3_1 *)header;
-               smu->smu_table.boot_values.revision =3D v_3_1->firmware_rev=
ision;
-               smu->smu_table.boot_values.gfxclk =3D v_3_1->bootup_sclk_in=
10khz;
-               smu->smu_table.boot_values.uclk =3D v_3_1->bootup_mclk_in10=
khz;
-               smu->smu_table.boot_values.socclk =3D 0;
-               smu->smu_table.boot_values.dcefclk =3D 0;
-               smu->smu_table.boot_values.vddc =3D v_3_1->bootup_vddc_mv;
-               smu->smu_table.boot_values.vddci =3D v_3_1->bootup_vddci_mv=
;
-               smu->smu_table.boot_values.mvddc =3D v_3_1->bootup_mvddc_mv=
;
-               smu->smu_table.boot_values.vdd_gfx =3D v_3_1->bootup_vddgfx=
_mv;
-               smu->smu_table.boot_values.cooling_id =3D v_3_1->coolingsol=
ution_id;
-               break;
-       case 3:
-               v_3_3 =3D (struct atom_firmware_info_v3_3 *)header;
-               smu->smu_table.boot_values.revision =3D v_3_3->firmware_rev=
ision;
-               smu->smu_table.boot_values.gfxclk =3D v_3_3->bootup_sclk_in=
10khz;
-               smu->smu_table.boot_values.uclk =3D v_3_3->bootup_mclk_in10=
khz;
-               smu->smu_table.boot_values.socclk =3D 0;
-               smu->smu_table.boot_values.dcefclk =3D 0;
-               smu->smu_table.boot_values.vddc =3D v_3_3->bootup_vddc_mv;
-               smu->smu_table.boot_values.vddci =3D v_3_3->bootup_vddci_mv=
;
-               smu->smu_table.boot_values.mvddc =3D v_3_3->bootup_mvddc_mv=
;
-               smu->smu_table.boot_values.vdd_gfx =3D v_3_3->bootup_vddgfx=
_mv;
-               smu->smu_table.boot_values.cooling_id =3D v_3_3->coolingsol=
ution_id;
-               break;
-       case 4:
-       default:
-               v_3_4 =3D (struct atom_firmware_info_v3_4 *)header;
-               smu->smu_table.boot_values.revision =3D v_3_4->firmware_rev=
ision;
-               smu->smu_table.boot_values.gfxclk =3D v_3_4->bootup_sclk_in=
10khz;
-               smu->smu_table.boot_values.uclk =3D v_3_4->bootup_mclk_in10=
khz;
-               smu->smu_table.boot_values.socclk =3D 0;
-               smu->smu_table.boot_values.dcefclk =3D 0;
-               smu->smu_table.boot_values.vddc =3D v_3_4->bootup_vddc_mv;
-               smu->smu_table.boot_values.vddci =3D v_3_4->bootup_vddci_mv=
;
-               smu->smu_table.boot_values.mvddc =3D v_3_4->bootup_mvddc_mv=
;
-               smu->smu_table.boot_values.vdd_gfx =3D v_3_4->bootup_vddgfx=
_mv;
-               smu->smu_table.boot_values.cooling_id =3D v_3_4->coolingsol=
ution_id;
-               break;
-       }
-
-       smu->smu_table.boot_values.format_revision =3D header->format_revis=
ion;
-       smu->smu_table.boot_values.content_revision =3D header->content_rev=
ision;
-
-       smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-                                       (uint8_t)SMU11_SYSPLL0_SOCCLK_ID,
-                                       (uint8_t)0,
-                                       &smu->smu_table.boot_values.socclk)=
;
-
-       smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-                                       (uint8_t)SMU11_SYSPLL0_DCEFCLK_ID,
-                                       (uint8_t)0,
-                                       &smu->smu_table.boot_values.dcefclk=
);
-
-       smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-                                       (uint8_t)SMU11_SYSPLL0_ECLK_ID,
-                                       (uint8_t)0,
-                                       &smu->smu_table.boot_values.eclk);
-
-       smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-                                       (uint8_t)SMU11_SYSPLL0_VCLK_ID,
-                                       (uint8_t)0,
-                                       &smu->smu_table.boot_values.vclk);
-
-       smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-                                       (uint8_t)SMU11_SYSPLL0_DCLK_ID,
-                                       (uint8_t)0,
-                                       &smu->smu_table.boot_values.dclk);
-
-       if ((smu->smu_table.boot_values.format_revision =3D=3D 3) &&
-           (smu->smu_table.boot_values.content_revision >=3D 2))
-               smu_v13_0_1_atom_get_smu_clockinfo(smu->adev,
-                                               (uint8_t)SMU11_SYSPLL1_0_FC=
LK_ID,
-                                               (uint8_t)SMU11_SYSPLL1_2_ID=
,
-                                               &smu->smu_table.boot_values=
.fclk);
-
-       return 0;
-}
-
-int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu)
-{
-       struct smu_table_context *smu_table =3D &smu->smu_table;
-
-       return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table-=
>clocks_table, false);
-}
-
-int smu_v13_0_1_set_driver_table_location(struct smu_context *smu)
-{
-       struct smu_table *driver_table =3D &smu->smu_table.driver_table;
-       int ret =3D 0;
-
-       if (!driver_table->mc_address)
-               return 0;
-
-       ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                       SMU_MSG_SetDriverDramAddrHigh,
-                       upper_32_bits(driver_table->mc_address),
-                       NULL);
-
-       if (ret)
-               return ret;
-
-       ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                       SMU_MSG_SetDriverDramAddrLow,
-                       lower_32_bits(driver_table->mc_address),
-                       NULL);
-
-       return ret;
-}
-
-int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool enable)
-{
-       int ret =3D 0;
-       struct amdgpu_device *adev =3D smu->adev;
-
-       switch (adev->asic_type) {
-       case CHIP_YELLOW_CARP:
-               if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
-                       return 0;
-               if (enable)
-                       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_AllowGfxO=
ff, NULL);
-               else
-                       ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_DisallowG=
fxOff, NULL);
-               break;
-       default:
-               break;
-       }
-
-       return ret;
-}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 7664334d8144..a28352149daa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -25,7 +25,7 @@

 #include "amdgpu.h"
 #include "amdgpu_smu.h"
-#include "smu_v13_0_1.h"
+#include "smu_v13_0.h"
 #include "smu13_driver_if_yellow_carp.h"
 #include "yellow_carp_ppt.h"
 #include "smu_v13_0_1_ppsmc.h"
@@ -186,6 +186,22 @@ static int yellow_carp_init_smc_tables(struct smu_cont=
ext *smu)
         return -ENOMEM;
 }

+static int yellow_carp_fini_smc_tables(struct smu_context *smu)
+{
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+
+       kfree(smu_table->clocks_table);
+       smu_table->clocks_table =3D NULL;
+
+       kfree(smu_table->metrics_table);
+       smu_table->metrics_table =3D NULL;
+
+       kfree(smu_table->watermarks_table);
+       smu_table->watermarks_table =3D NULL;
+
+       return 0;
+}
+
 static int yellow_carp_system_features_control(struct smu_context *smu, bo=
ol en)
 {
         struct smu_feature *feature =3D &smu->smu_feature;
@@ -658,6 +674,13 @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_=
context *smu,
         return sizeof(struct gpu_metrics_v2_1);
 }

+static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)
+{
+       struct smu_table_context *smu_table =3D &smu->smu_table;
+
+       return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, smu_table-=
>clocks_table, false);
+}
+
 static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_=
OD_DPM_TABLE_COMMAND type,
                                         long input[], uint32_t size)
 {
@@ -1202,17 +1225,17 @@ static int yellow_carp_set_fine_grain_gfx_freq_para=
meters(struct smu_context *sm
 }

 static const struct pptable_funcs yellow_carp_ppt_funcs =3D {
-       .check_fw_status =3D smu_v13_0_1_check_fw_status,
-       .check_fw_version =3D smu_v13_0_1_check_fw_version,
+       .check_fw_status =3D smu_v13_0_check_fw_status,
+       .check_fw_version =3D smu_v13_0_check_fw_version,
         .init_smc_tables =3D yellow_carp_init_smc_tables,
-       .fini_smc_tables =3D smu_v13_0_1_fini_smc_tables,
-       .get_vbios_bootup_values =3D smu_v13_0_1_get_vbios_bootup_values,
+       .fini_smc_tables =3D yellow_carp_fini_smc_tables,
+       .get_vbios_bootup_values =3D smu_v13_0_get_vbios_bootup_values,
         .system_features_control =3D yellow_carp_system_features_control,
         .send_smc_msg_with_param =3D smu_cmn_send_smc_msg_with_param,
         .send_smc_msg =3D smu_cmn_send_smc_msg,
         .dpm_set_vcn_enable =3D yellow_carp_dpm_set_vcn_enable,
         .dpm_set_jpeg_enable =3D yellow_carp_dpm_set_jpeg_enable,
-       .set_default_dpm_table =3D smu_v13_0_1_set_default_dpm_tables,
+       .set_default_dpm_table =3D yellow_carp_set_default_dpm_tables,
         .read_sensor =3D yellow_carp_read_sensor,
         .is_dpm_running =3D yellow_carp_is_dpm_running,
         .set_watermarks_table =3D yellow_carp_set_watermarks_table,
@@ -1221,8 +1244,8 @@ static const struct pptable_funcs yellow_carp_ppt_fun=
cs =3D {
         .get_gpu_metrics =3D yellow_carp_get_gpu_metrics,
         .get_enabled_mask =3D smu_cmn_get_enabled_32_bits_mask,
         .get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask,
-       .set_driver_table_location =3D smu_v13_0_1_set_driver_table_locatio=
n,
-       .gfx_off_control =3D smu_v13_0_1_gfx_off_control,
+       .set_driver_table_location =3D smu_v13_0_set_driver_table_location,
+       .gfx_off_control =3D smu_v13_0_gfx_off_control,
         .post_init =3D yellow_carp_post_smu_init,
         .mode2_reset =3D yellow_carp_mode2_reset,
         .get_dpm_ultimate_freq =3D yellow_carp_get_dpm_ultimate_freq,
--
2.17.1


--_000_CO6PR12MB5473E8076417AACEE7949961A2009CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Hou, Xiaomeng (Matthe=
w) &lt;Xiaomeng.Hou@amd.com&gt;<br>
<b>Sent:</b> Thursday, July 1, 2021 4:31 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Lazar, Lijo &lt;L=
ijo.Lazar@amd.com&gt;; Liu, Aaron &lt;Aaron.Liu@amd.com&gt;; Hou, Xiaomeng =
(Matthew) &lt;Xiaomeng.Hou@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: drop smu_v13_0_1.c|h files for yellow c=
arp</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Since there's nothing special in smu implementatio=
n for yellow carp,<br>
it's better to reuse the common smu_v13_0 interfaces and drop the<br>
specific smu_v13_0_1.c|h files.<br>
<br>
Signed-off-by: Xiaomeng Hou &lt;Xiaomeng.Hou@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu_v13_0.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 57 ----<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile&nbsp;&nbsp; |&nbsp;&nbsp;=
 2 +-<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c&nbsp;&nbsp;&nbsp; |&nbsp; =
26 ++<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c&nbsp; | 311 ------------=
------<br>
&nbsp;.../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c&nbsp; |&nbsp; 39 ++-<br>
&nbsp;6 files changed, 59 insertions(+), 377 deletions(-)<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c<b=
r>
<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h b/drivers/gpu/drm/amd/p=
m/inc/smu_v13_0.h<br>
index 6119a36b2cba..3fea2430dec0 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0.h<br>
@@ -26,6 +26,7 @@<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
&nbsp;<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_INV 0xFFFFFFFF<br>
+#define SMU13_DRIVER_IF_VERSION_YELLOW_CARP 0x03<br>
&nbsp;#define SMU13_DRIVER_IF_VERSION_ALDE 0x07<br>
&nbsp;<br>
&nbsp;/* MP Apertures */<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h b/drivers/gpu/drm/amd=
/pm/inc/smu_v13_0_1.h<br>
deleted file mode 100644<br>
index b6c976a4d578..000000000000<br>
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1.h<br>
+++ /dev/null<br>
@@ -1,57 +0,0 @@<br>
-/*<br>
- * Copyright 2020 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- */<br>
-#ifndef __SMU_V13_0_1_H__<br>
-#define __SMU_V13_0_1_H__<br>
-<br>
-#include &quot;amdgpu_smu.h&quot;<br>
-<br>
-#define SMU13_0_1_DRIVER_IF_VERSION_INV 0xFFFFFFFF<br>
-#define SMU13_0_1_DRIVER_IF_VERSION_YELLOW_CARP 0x3<br>
-<br>
-/* MP Apertures */<br>
-#define MP0_Public&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03800000=
<br>
-#define MP0_SRAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x03900000<br>
-#define MP1_Public&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x03b00000=
<br>
-#define MP1_SRAM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x03c00004<br>
-<br>
-/* address block */<br>
-#define smnMP1_FIRMWARE_FLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x3010024<br>
-<br>
-<br>
-#if defined(SWSMU_CODE_LAYER_L2) || defined(SWSMU_CODE_LAYER_L3)<br>
-<br>
-int smu_v13_0_1_check_fw_status(struct smu_context *smu);<br>
-<br>
-int smu_v13_0_1_check_fw_version(struct smu_context *smu);<br>
-<br>
-int smu_v13_0_1_fini_smc_tables(struct smu_context *smu);<br>
-<br>
-int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu);<br>
-<br>
-int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu);<br>
-<br>
-int smu_v13_0_1_set_driver_table_location(struct smu_context *smu);<br>
-<br>
-int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool enable);<br>
-#endif<br>
-#endif<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/=
amd/pm/swsmu/smu13/Makefile<br>
index 9b3a8503f5cd..d4c4c495762c 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile<br>
@@ -23,7 +23,7 @@<br>
&nbsp;# Makefile for the 'smu manager' sub-component of powerplay.<br>
&nbsp;# It provides the smu management services for the driver.<br>
&nbsp;<br>
-SMU13_MGR =3D smu_v13_0.o aldebaran_ppt.o smu_v13_0_1.o yellow_carp_ppt.o<=
br>
+SMU13_MGR =3D smu_v13_0.o aldebaran_ppt.o yellow_carp_ppt.o<br>
&nbsp;<br>
&nbsp;AMD_SWSMU_SMU13MGR =3D $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_M=
GR))<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
index a3dc7194aaf8..cbce982f2717 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c<br>
@@ -41,6 +41,8 @@<br>
&nbsp;<br>
&nbsp;#include &quot;asic_reg/thm/thm_13_0_2_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/thm/thm_13_0_2_sh_mask.h&quot;<br>
+#include &quot;asic_reg/mp/mp_13_0_1_offset.h&quot;<br>
+#include &quot;asic_reg/mp/mp_13_0_1_sh_mask.h&quot;<br>
&nbsp;#include &quot;asic_reg/mp/mp_13_0_2_offset.h&quot;<br>
&nbsp;#include &quot;asic_reg/mp/mp_13_0_2_sh_mask.h&quot;<br>
&nbsp;#include &quot;asic_reg/smuio/smuio_13_0_2_offset.h&quot;<br>
@@ -210,6 +212,9 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_ALDEBARAN:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU13_DRIVER_IF_VER=
SION_ALDE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU13_DRIVER_IF_VERSION_YELLOW=
_CARP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;smu unsupported a=
sic type:%d.\n&quot;, smu-&gt;adev-&gt;asic_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU13_DRIVER_IF_VER=
SION_INV;<br>
@@ -694,6 +699,27 @@ int smu_v13_0_set_allowed_mask(struct smu_context *smu=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
+int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (enable)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
&nbsp;int smu_v13_0_system_features_control(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; bool en)<br>
&nbsp;{<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c<br>
deleted file mode 100644<br>
index 61917b49f2bf..000000000000<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_1.c<br>
+++ /dev/null<br>
@@ -1,311 +0,0 @@<br>
-/*<br>
- * Copyright 2020 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- */<br>
-<br>
-//#include &lt;linux/reboot.h&gt;<br>
-<br>
-#define SWSMU_CODE_LAYER_L3<br>
-<br>
-#include &quot;amdgpu.h&quot;<br>
-#include &quot;amdgpu_smu.h&quot;<br>
-#include &quot;smu_v13_0_1.h&quot;<br>
-#include &quot;soc15_common.h&quot;<br>
-#include &quot;smu_cmn.h&quot;<br>
-#include &quot;atomfirmware.h&quot;<br>
-#include &quot;amdgpu_atomfirmware.h&quot;<br>
-#include &quot;amdgpu_atombios.h&quot;<br>
-#include &quot;atom.h&quot;<br>
-<br>
-#include &quot;asic_reg/mp/mp_13_0_1_offset.h&quot;<br>
-#include &quot;asic_reg/mp/mp_13_0_1_sh_mask.h&quot;<br>
-<br>
-/*<br>
- * DO NOT use these for err/warn/info/debug messages.<br>
- * Use dev_err, dev_warn, dev_info and dev_dbg instead.<br>
- * They are more MGPU friendly.<br>
- */<br>
-#undef pr_err<br>
-#undef pr_warn<br>
-#undef pr_info<br>
-#undef pr_debug<br>
-<br>
-int smu_v13_0_1_check_fw_status(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp1_fw_flags;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mp1_fw_flags =3D RREG32_PCIE(MP1_Publ=
ic |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smnMP1_FIRMWARE_FLAGS &a=
mp; 0xffffffff));<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((mp1_fw_flags &amp; MP1_FIRMWARE_=
FLAGS__INTERRUPTS_ENABLED_MASK) &gt;&gt;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MP1_FIRMWARE_=
FLAGS__INTERRUPTS_ENABLED__SHIFT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIO;<br>
-}<br>
-<br>
-int smu_v13_0_1_check_fw_version(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t if_version =3D 0xff, smu_ver=
sion =3D 0xff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t smu_major;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t smu_minor, smu_debug;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_get_smc_version(smu, =
&amp;if_version, &amp;smu_version);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_major =3D (smu_version &gt;&gt; 1=
6) &amp; 0xffff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_minor =3D (smu_version &gt;&gt; 8=
) &amp; 0xff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_debug =3D (smu_version &gt;&gt; 0=
) &amp; 0xff;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (smu-&gt;adev-&gt;asic_type) {=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU13_0_1_DRIVER_IF_VERSION_YE=
LLOW_CARP;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;smu unsupported asic type:%d=
.\n&quot;, smu-&gt;adev-&gt;asic_type);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smc_driver_if_version =3D SMU13_0_1_DRIVER_IF_VERSION_IN=
V;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(smu-&gt;adev-&gt;dev, &quot;=
smu fw reported version =3D 0x%08x (%d.%d.%d)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_versio=
n, smu_major, smu_minor, smu_debug);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 1. if_version mismatch is not=
 critical as our fw is designed<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to be backward compatible.<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2. New fw usually brings some=
 optimizations. But that's visible<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only on the paired driver.<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Considering above, we just le=
ave user a warning message instead<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * of halt driver loading.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (if_version !=3D smu-&gt;smc_drive=
r_if_version) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(smu-&gt;adev-&gt;dev, &quot;smu driver if version =3D 0=
x%08x, smu fw if version =3D 0x%08x, &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;smu =
fw version =3D 0x%08x (%d.%d.%d)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;sm=
c_driver_if_version, if_version,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_versio=
n, smu_major, smu_minor, smu_debug);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(smu-&gt;adev-&gt;dev, &quot;SMU driver if version not m=
atched\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
-int smu_v13_0_1_fini_smc_tables(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_table =
=3D &amp;smu-&gt;smu_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;clocks_table);<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;clocks_table =3D NULL;<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;metrics_table);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_table =3D NULL;=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;watermarks_table)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;watermarks_table =3D NU=
LL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int smu_v13_0_1_atom_get_smu_clockinfo(struct amdgpu_device *adev,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t clk_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t syspll_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *clk_freq)<br=
>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_get_smu_clock_info_parame=
ters_v3_1 input =3D {0};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_get_smu_clock_info_output=
_parameters_v3_1 *output;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, index;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input.clk_id =3D clk_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input.syspll_id =3D syspll_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input.command =3D GET_SMU_CLOCK_INFO_=
V3_1_GET_CLOCK_FREQ;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D get_index_into_master_table=
(atom_master_list_of_command_functions_v2_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; getsmuclockinfo);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_atom_execute_table(ade=
v-&gt;mode_info.atom_context, index,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint32_t *)&amp;input);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output =3D (struct atom_get_smu_clock=
_info_output_parameters_v3_1 *)&amp;input;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *clk_freq =3D le32_to_cpu(output-&gt;=
atom_smu_outputclkfreq.smu_clock_freq_hz) / 10000;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int smu_v13_0_1_get_vbios_bootup_values(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t frev, crev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_common_table_header *head=
er;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_firmware_info_v3_4 *v_3_4=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_firmware_info_v3_3 *v_3_3=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_firmware_info_v3_1 *v_3_1=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index =3D get_index_into_master_table=
(atom_master_list_of_data_tables_v2_1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; firmwareinfo);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_atombios_get_data_tabl=
e(smu-&gt;adev, index, &amp;size, &amp;frev, &amp;crev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t **)&amp;header);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (header-&gt;format_revision !=3D 3=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(smu-&gt;adev-&gt;dev, &quot;unknown atom_firmware_info v=
ersion! for smu13\n&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (header-&gt;content_revision) =
{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; v_3_1 =3D (struct atom_firmware_info_v3_1 *)header;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.revision =3D v_3_1-&gt;firmware_re=
vision;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.gfxclk =3D v_3_1-&gt;bootup_sclk_i=
n10khz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.uclk =3D v_3_1-&gt;bootup_mclk_in1=
0khz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.socclk =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.dcefclk =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.vddc =3D v_3_1-&gt;bootup_vddc_mv;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.vddci =3D v_3_1-&gt;bootup_vddci_m=
v;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.mvddc =3D v_3_1-&gt;bootup_mvddc_m=
v;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.vdd_gfx =3D v_3_1-&gt;bootup_vddgf=
x_mv;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.cooling_id =3D v_3_1-&gt;coolingso=
lution_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 3:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; v_3_3 =3D (struct atom_firmware_info_v3_3 *)header;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.revision =3D v_3_3-&gt;firmware_re=
vision;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.gfxclk =3D v_3_3-&gt;bootup_sclk_i=
n10khz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.uclk =3D v_3_3-&gt;bootup_mclk_in1=
0khz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.socclk =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.dcefclk =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.vddc =3D v_3_3-&gt;bootup_vddc_mv;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.vddci =3D v_3_3-&gt;bootup_vddci_m=
v;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.mvddc =3D v_3_3-&gt;bootup_mvddc_m=
v;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.vdd_gfx =3D v_3_3-&gt;bootup_vddgf=
x_mv;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.cooling_id =3D v_3_3-&gt;coolingso=
lution_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 4:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; v_3_4 =3D (struct atom_firmware_info_v3_4 *)header;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.revision =3D v_3_4-&gt;firmware_re=
vision;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.gfxclk =3D v_3_4-&gt;bootup_sclk_i=
n10khz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.uclk =3D v_3_4-&gt;bootup_mclk_in1=
0khz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.socclk =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.dcefclk =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.vddc =3D v_3_4-&gt;bootup_vddc_mv;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.vddci =3D v_3_4-&gt;bootup_vddci_m=
v;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.mvddc =3D v_3_4-&gt;bootup_mvddc_m=
v;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.vdd_gfx =3D v_3_4-&gt;bootup_vddgf=
x_mv;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu-&gt;smu_table.boot_values.cooling_id =3D v_3_4-&gt;coolingso=
lution_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.format_=
revision =3D header-&gt;format_revision;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;smu_table.boot_values.content=
_revision =3D header-&gt;content_revision;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_1_atom_get_smu_clockinfo(sm=
u-&gt;adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)SMU11_SYSPLL0_SOCCLK_ID,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;smu-&gt;smu_table.boot_values.socclk);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_1_atom_get_smu_clockinfo(sm=
u-&gt;adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)SMU11_SYSPLL0_DCEFCLK_ID,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;smu-&gt;smu_table.boot_values.dcefclk);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_1_atom_get_smu_clockinfo(sm=
u-&gt;adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)SMU11_SYSPLL0_ECLK_ID,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;smu-&gt;smu_table.boot_values.eclk);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_1_atom_get_smu_clockinfo(sm=
u-&gt;adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)SMU11_SYSPLL0_VCLK_ID,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;smu-&gt;smu_table.boot_values.vclk);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_v13_0_1_atom_get_smu_clockinfo(sm=
u-&gt;adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)SMU11_SYSPLL0_DCLK_ID,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (uint8_t)0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;smu-&gt;smu_table.boot_values.dclk);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((smu-&gt;smu_table.boot_values.fo=
rmat_revision =3D=3D 3) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (smu-&gt;smu_=
table.boot_values.content_revision &gt;=3D 2))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_v13_0_1_atom_get_smu_clockinfo(smu-&gt;adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t)SMU11_SYSPLL1=
_0_FCLK_ID,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t)SMU11_SYSPLL1=
_2_ID,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;smu-&gt;smu_table=
.boot_values.fclk);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int smu_v13_0_1_set_default_dpm_tables(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_table =
=3D &amp;smu-&gt;smu_table;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_update_table(smu, SMU_=
TABLE_DPMCLOCKS, 0, smu_table-&gt;clocks_table, false);<br>
-}<br>
-<br>
-int smu_v13_0_1_set_driver_table_location(struct smu_context *smu)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *driver_table =3D &a=
mp;smu-&gt;smu_table.driver_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!driver_table-&gt;mc_address)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_SetDrive=
rDramAddrHigh,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(dr=
iver_table-&gt;mc_address),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_smc_msg_with_par=
am(smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMU_MSG_SetDrive=
rDramAddrLow,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(dr=
iver_table-&gt;mc_address),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
-int smu_v13_0_1_gfx_off_control(struct smu_context *smu, bool enable)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&g=
t;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_YELLOW_CARP:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!(adev-&gt;pm.pp_feature &amp; PP_GFXOFF_MASK))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (enable)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg(smu, SMU_MSG_AllowGfxOff, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_=
send_smc_msg(smu, SMU_MSG_DisallowGfxOff, NULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
index 7664334d8144..a28352149daa 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c<br>
@@ -25,7 +25,7 @@<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_smu.h&quot;<br>
-#include &quot;smu_v13_0_1.h&quot;<br>
+#include &quot;smu_v13_0.h&quot;<br>
&nbsp;#include &quot;smu13_driver_if_yellow_carp.h&quot;<br>
&nbsp;#include &quot;yellow_carp_ppt.h&quot;<br>
&nbsp;#include &quot;smu_v13_0_1_ppsmc.h&quot;<br>
@@ -186,6 +186,22 @@ static int yellow_carp_init_smc_tables(struct smu_cont=
ext *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;}<br>
&nbsp;<br>
+static int yellow_carp_fini_smc_tables(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_table =
=3D &amp;smu-&gt;smu_table;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;clocks_table);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;clocks_table =3D NULL;<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;metrics_table);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;metrics_table =3D NULL;=
<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(smu_table-&gt;watermarks_table)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_table-&gt;watermarks_table =3D NU=
LL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int yellow_carp_system_features_control(struct smu_context *sm=
u, bool en)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *featur=
e =3D &amp;smu-&gt;smu_feature;<br>
@@ -658,6 +674,13 @@ static ssize_t yellow_carp_get_gpu_metrics(struct smu_=
context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sizeof(struct gpu_m=
etrics_v2_1);<br>
&nbsp;}<br>
&nbsp;<br>
+static int yellow_carp_set_default_dpm_tables(struct smu_context *smu)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *smu_table =
=3D &amp;smu-&gt;smu_table;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_update_table(smu, SMU_=
TABLE_DPMCLOCKS, 0, smu_table-&gt;clocks_table, false);<br>
+}<br>
+<br>
&nbsp;static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enu=
m PP_OD_DPM_TABLE_COMMAND type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; long input[], uint32_t size)<br>
&nbsp;{<br>
@@ -1202,17 +1225,17 @@ static int yellow_carp_set_fine_grain_gfx_freq_para=
meters(struct smu_context *sm<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static const struct pptable_funcs yellow_carp_ppt_funcs =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_status =3D smu_v13_0_1_chec=
k_fw_status,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_version =3D smu_v13_0_1_che=
ck_fw_version,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_status =3D smu_v13_0_check_=
fw_status,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .check_fw_version =3D smu_v13_0_check=
_fw_version,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_smc_tables =3D yello=
w_carp_init_smc_tables,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_smc_tables =3D smu_v13_0_1_fini=
_smc_tables,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_vbios_bootup_values =3D smu_v13_=
0_1_get_vbios_bootup_values,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .fini_smc_tables =3D yellow_carp_fini=
_smc_tables,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_vbios_bootup_values =3D smu_v13_=
0_get_vbios_bootup_values,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .system_features_control =
=3D yellow_carp_system_features_control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg_with_param =
=3D smu_cmn_send_smc_msg_with_param,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .send_smc_msg =3D smu_cmn_=
send_smc_msg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpm_set_vcn_enable =3D ye=
llow_carp_dpm_set_vcn_enable,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .dpm_set_jpeg_enable =3D y=
ellow_carp_dpm_set_jpeg_enable,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D smu_v13_0_=
1_set_default_dpm_tables,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_default_dpm_table =3D yellow_car=
p_set_default_dpm_tables,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D yellow_ca=
rp_read_sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_dpm_running =3D yellow=
_carp_is_dpm_running,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_watermarks_table =3D =
yellow_carp_set_watermarks_table,<br>
@@ -1221,8 +1244,8 @@ static const struct pptable_funcs yellow_carp_ppt_fun=
cs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_gpu_metrics =3D yello=
w_carp_get_gpu_metrics,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_enabled_mask =3D smu_=
cmn_get_enabled_32_bits_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pp_feature_mask =3D s=
mu_cmn_get_pp_feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_driver_table_location =3D smu_v1=
3_0_1_set_driver_table_location,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gfx_off_control =3D smu_v13_0_1_gfx_=
off_control,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_driver_table_location =3D smu_v1=
3_0_set_driver_table_location,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gfx_off_control =3D smu_v13_0_gfx_of=
f_control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .post_init =3D yellow_carp=
_post_smu_init,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .mode2_reset =3D yellow_ca=
rp_mode2_reset,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_dpm_ultimate_freq =3D=
 yellow_carp_get_dpm_ultimate_freq,<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473E8076417AACEE7949961A2009CO6PR12MB5473namp_--

--===============1959850284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1959850284==--
