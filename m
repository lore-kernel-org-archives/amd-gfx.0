Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E9C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 08:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8611D10FA28;
	Thu, 21 Apr 2022 08:51:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2054.outbound.protection.outlook.com [40.107.96.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E670710FA28
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 08:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWNN1Nw8GS5KIwIO3+esYMzBYDujMelJfRpbmBp0dEwV75ltDA9HY4de5hqrf3H/ghqg5zQuHacg0kzVhOJhYoAXLzK0/Cy3PgfTm4fQzQYRW3P6XwO3PT+pbVuZMWVWqdPbu63JT5H6euHNaCgcHW5N85uJ6Je/W0w9msMPHkwMwY8AUQYyusAVbj/afeZHyqbZtTZXWSi3IU8O051GDBOL+U4XZ3iyEfVGQrhQTWL7/Kp0h7fEwj2P6NFKGa+eEO7E+8DmZE/Cu98CMF6T6XRbMoJs2Xl4D9akihbuW5QRO+qsH8OXKWtTYA5KOs3jCIXnsDw5amF3Ao0T4CLIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zduZdAdHqGCiItxoTa/z/ohdrkzco1zwSi6xn1wtxZA=;
 b=Mk4t8UVdZhilunOis8ooqq11ffqB3aHIj06odxO1WRn/qISeNYPDvopWHw8dTSVYZ2MQXvgl9Icl7fEenTM8DBaWb2MotRbp7lq5jz6Nf3oYCltEL2KXbfGstm2Y5EQYeFniw0Ig9r31KnNeuQaFdyYZ/go0iFQsGd4wX4Us2xAHqEc08HSC0PKsUcKz7MAjhgTBajKiNV364pPkv3EZHeRsg6nnGVwY4FQq6NU5isG+p873BqueSTauJnPJZftxXiZA8vX86u38Zj9SD9WMFe1j9KGXrd08OSI10OC8Qy06kUOkz3YCSCw4yL0ildvGOfJGKd+xQ5Z3o87eUC9YJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zduZdAdHqGCiItxoTa/z/ohdrkzco1zwSi6xn1wtxZA=;
 b=zyYYi1YbIhGMc8KHY6JkZX2q/WTOcx+ECxrNVf5scydk+YOzG4JXdUS00SHqTZyTC3u9q533DHg7xvLjpugX8iWDTi+DpHOZ4rpe7mBO3umSyBMXPCIsihdGsl04L4cciPUYnss4Dt27f1Lj/WfPvKg2pHfVey5WKsH6Mea9wwQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 08:51:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::a561:6b71:55fa:ed2d%8]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 08:51:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke
 support
Thread-Topic: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke
 support
Thread-Index: AQHYVKfMc3AcDnJ5jEWhg9bcKhxdMKz6EKLg
Date: Thu, 21 Apr 2022 08:51:42 +0000
Message-ID: <BN9PR12MB5257C0B2D90A6C5AA12E8514FCF49@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220420111357.9488-1-candice.li@amd.com>
 <20220420111357.9488-2-candice.li@amd.com>
In-Reply-To: <20220420111357.9488-2-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a57eec60-15f0-4a68-b06d-528a3030c2ee;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-21T08:51:21Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9d0ba05-5360-4461-5914-08da23742893
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_
x-microsoft-antispam-prvs: <BN9PR12MB514631EF550CDB01855D0BAEFCF49@BN9PR12MB5146.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7YIeRlrwKku5+FtugokSYrW5zhRqQZf3OTxaA84gE9ouZeX3sOHTg5o88wEgFPzjGkdhdN0AdD5R38OhRK3rskmrtxmxlytvLqt7tB+MXKjmQ5Ixp3ff+34LKNvW+gNL8GvhRsa9vT/skuZFbcF5Q/ZSALlnpRzCz3mHmZQY1pmRyNf1z1GImMP5Q+2Bpy2q9V3Pkidr1rjdzJFt7PzCtYJRyKYWeB4vsufmfX02OV0YuHh+YwP2vUHf9xfoB7HDg2eSXcOTDTK2yGiQOu4DRedI15rxVAOHVa7GtwP6SChGN0+FZvJhILNOsj+uN1yplt8cD6vt1QRu6o0hURk6T4IvAKIYczKc+1OyM3nENBMEzPZglGef1upwIs/gjrg1o7bC9f3ni1ZmRMg0ot23TIgWepFlUmHlWpJciT72Z5BXWEW5LlJRFwp9gVSroejp2t2jq8N3DKIwtJ9haQuC3Db9drdCyWtWR8OGfXxx7PNYOnK++iKkt9DcOvBOi3et1SQjLDPf85TenZ7FI5AKwbHCpbnCoLgiSh9ppUyKWx0YqsQOfDwpBnCSuJDpqa2m+M1iHINY3GR9NndeIsVJIXtz13dhAG0n9TFTQVCHWNIZBpRrFwFXdx+1ALYgqaXpBFgA+H/gWHxxJE2ApKeDZ8qReEUZQmzFybnhynyJzJrSXik7dma4oHVdVg+9MKfQzKnZc9dN9yBDwCTNbUUJes0Bsw++M3pKu8cV5Jupg3s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(508600001)(66946007)(76116006)(5660300002)(38070700005)(8936002)(26005)(66556008)(66476007)(86362001)(4326008)(9686003)(71200400001)(6506007)(8676002)(66446008)(110136005)(54906003)(316002)(7696005)(53546011)(38100700002)(64756008)(186003)(55016003)(83380400001)(33656002)(122000001)(30864003)(2906002)(461764006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z/ZJxealogsyaDa3bgqqEnWyLszp4JYxGeKdMa/FQb9jefNF7SebWwiMsHQ6?=
 =?us-ascii?Q?givpdeLYpUO/GKWAU9hDmPrL5qaULb8Q27RfVXQT9fdn16Vwknmq+6baD+g6?=
 =?us-ascii?Q?BFOkczlMwRanfic5A872j9U0vT5mMa1N8zS58HK809m8SOYL6XtDxYJYaRfa?=
 =?us-ascii?Q?CHpIf0+NInJu8UuJryhep2e6h4FUR/euKBT0oK6yj7gFxV/kRUJJ3nhTgW73?=
 =?us-ascii?Q?y7mCeA8kU070hCifmMGh5Q2gbUafmg7fM3UNi4S536hD09D1PX/0Lvufidym?=
 =?us-ascii?Q?kAdex1LYEpfSLaZ/p++WoKxi/+beMLKtvvXgVvgxblMLlukUCQk3Ao52gTCV?=
 =?us-ascii?Q?Zwv7RExbhFdhX4KAA6I8Zwb103NV4Lp3ijrZI9Nd015mLtan2jF350/t+Tg+?=
 =?us-ascii?Q?3AmC551Smz4rg7kd8Rsice9nMLcA3DEFJDKz7O2iu16y3YnBPmPKGRWyXXpo?=
 =?us-ascii?Q?l/1J5ujsr+IZ4XjMtY7xQXlde6a1x5NmFhaOpatCKunmpi6qsnEIlgbEz3Y8?=
 =?us-ascii?Q?jF+6W9371X8sTlegk6QVXNZjRy/KLydaeIDgDH7dOHJrILVZQbywsPmbRxB8?=
 =?us-ascii?Q?jvOAHOdJT3gRTqMeWcr93aJcgty3d20VnTIE7TpDNZmvFHer126xaX5mBR6o?=
 =?us-ascii?Q?5trHFq9IOhSFOo6IthONDqrjUwbrE8AIwUQIzkgShogufhfLfcgCXGUF1AHW?=
 =?us-ascii?Q?5cbmUZkSQ+qWy5aqTxhD+sE+0Y+uNmEHjDmtExOr1vDo4nJEdi9MAv+kN4OK?=
 =?us-ascii?Q?/19jIseGY2GOjzomtj2R+uQGknMqDY/Ia/8QxUf5myyNkKhJOwhhTWG2mTuW?=
 =?us-ascii?Q?+EPp/smEQMO8ckfrwJDIgi9q0z0FGd9HEVjcCxBBxwODXX50M+uC0Xr/OuO8?=
 =?us-ascii?Q?z5yCBfAa0M/Q9KwphFR7pWB2bnyGHkJbmhqKxhYhJxYybHxFMYR811q+Ax2s?=
 =?us-ascii?Q?+bjzRxSlVvMqxEgYPIBUd+QYBOjWsSW3r+HRkfF+a4MKjHnCWjkxhflCxoNs?=
 =?us-ascii?Q?sTooOnlz7ABGwBhRDGmfda7i5NkjHMWPUhtTrS6YzIfDnXJZ+KVI/bQSZLE1?=
 =?us-ascii?Q?O4gVj6KizIMAoUFSFn7/cxpR5Z945NrhJBW378/GXR49OCsywVLjVe8jQ2g3?=
 =?us-ascii?Q?jC4g2OBH4LLqkBzgJ42iXMylgWrasmcCUGKbipiJ5yWc7vQPEYz3PkfGcTca?=
 =?us-ascii?Q?T/uMI5sG6lmyGqQKMAi+BnZPy/9quOGSxJ0N4lkdceWGHf2Djt53F9kN9BCh?=
 =?us-ascii?Q?ls8O7As9vu8Hk+jb88Gvr6126HUzWH0pQ5an4Rh+L2RDiPVjtlSlQuwCVQkr?=
 =?us-ascii?Q?k1w5SLXVkvrNozI4VLgQgwEfgesmRm4PS8Ywc8EeAHXSZo/hvNd1LC0cq8SK?=
 =?us-ascii?Q?lLCLcvoDZOp32eqI8WRKS82nC1mF8XcuPCq2WnjbpBeB2SCd4O6QKq0uuUOI?=
 =?us-ascii?Q?6/90pBPsn9Kd2cOpdKY/8C/UzzUi/Hz49XkQZUr5E4LgCyH53FlYdBvoTMog?=
 =?us-ascii?Q?ktf2iwltg6u/to80NGjtzCn8vEXd/KnPtU2Abd6MOZvCAxx6o8JsK02vdSbH?=
 =?us-ascii?Q?7rHnxruavnPnb580yAQqdmSGVmQVt1ZH2TNFnDFUU7Igid1NNO5ddFqtJGCj?=
 =?us-ascii?Q?e1jE2tODNleB3xlhBICspbva5VkUWZ9EkF7oVujxWSnj+lbv0kyHM3OpFpZC?=
 =?us-ascii?Q?1K+ftsFr/O6RR3Gu954qvaQAIh5Hk6DaHdd0thDU6pGYhWyrghzDxWoICYKW?=
 =?us-ascii?Q?qwYgucbPmg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d0ba05-5360-4461-5914-08da23742893
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 08:51:43.0113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbYopCHtmPjEeB5bwqnMTqE6WpaGiGgNxeLEV1oL6T2H5RTBLtSueNJ8lInvXZV0EH5rLC2zD84JNHfM9XGdWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candice =
Li
Sent: Wednesday, April 20, 2022 19:14
To: amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>; Clements, John <John.Clements@amd.com=
>
Subject: [PATCH v2 2/2] drm/amdgpu: Add debugfs TA load/unload/invoke suppo=
rt

v1:
Add debugfs support to load/unload/invoke TA in runtime.

v2:
1. Update some variables to static.
2. Use PAGE_ALIGN to calculate shared buf size directly.
3. Remove fp check.
4. Update debugfs from read to write.

Signed-off-by: John Clements <john.clements@amd.com>
Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 308 ++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h  |  30 ++
 4 files changed, 341 insertions(+), 1 deletion(-)  create mode 100644 driv=
ers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 7d7af43a258f83..b525f9be9326f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,7 +58,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
        amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio=
.o \
        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
        amdgpu_fw_attestation.o amdgpu_securedisplay.o \
-       amdgpu_eeprom.o amdgpu_mca.o
+       amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o

 amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 13e4d8f9b87449..eedb12f6b8a32d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -38,6 +38,7 @@
 #include "amdgpu_umr.h"

 #include "amdgpu_reset.h"
+#include "amdgpu_psp_ta.h"

 #if defined(CONFIG_DEBUG_FS)

@@ -1767,6 +1768,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
                DRM_ERROR("registering register debugfs failed (%d).\n", r)=
;

        amdgpu_debugfs_firmware_init(adev);
+       amdgpu_ta_if_debugfs_init(adev);

 #if defined(CONFIG_DRM_AMD_DC)
        if (amdgpu_device_has_dc_support(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.c
new file mode 100644
index 00000000000000..247a476e63544c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -0,0 +1,308 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_psp_ta.h"
+
+static const char *TA_IF_FS_NAME =3D "ta_if";
+
+struct dentry *dir;
+static struct dentry *ta_load_debugfs_dentry; static struct dentry
+*ta_unload_debugfs_dentry; static struct dentry
+*ta_invoke_debugfs_dentry;
+
+static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf,
+                                           size_t len, loff_t *off);
+static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char *buf=
,
+                                           size_t len, loff_t *off);
+static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf=
,
+                                           size_t len, loff_t *off);
+
+
+static uint32_t get_bin_version(const uint8_t *bin) {
+       const struct common_firmware_header *hdr =3D
+                            (const struct common_firmware_header *)bin;
+
+       return hdr->ucode_version;
+}
+
+static void prep_ta_mem_context(struct psp_context *psp,
+                                            struct ta_context *context,
+                                            uint8_t *shared_buf,
+                                            uint32_t shared_buf_len)
+{
+       context->mem_context.shared_mem_size =3D PAGE_ALIGN(shared_buf_len)=
;
+       psp_ta_init_shared_buf(psp, &context->mem_context);
+
+       memcpy((void *)context->mem_context.shared_buf, shared_buf,
+shared_buf_len); }
+
+static bool is_ta_type_valid(enum ta_type_id ta_type) {
+       bool ret =3D false;
+
+       switch (ta_type) {
+       case TA_TYPE_RAS:
+               ret =3D true;
+               break;
+       default:
+               break;
+       }
+
+       return ret;
+}
+
+static const struct file_operations ta_load_debugfs_fops =3D {
+       .write   =3D ta_if_load_debugfs_write,
+       .llseek =3D default_llseek,
+       .owner  =3D THIS_MODULE
+};
+
+static const struct file_operations ta_unload_debugfs_fops =3D {
+       .write   =3D ta_if_unload_debugfs_write,
+       .llseek =3D default_llseek,
+       .owner  =3D THIS_MODULE
+};
+
+static const struct file_operations ta_invoke_debugfs_fops =3D {
+       .write   =3D ta_if_invoke_debugfs_write,
+       .llseek =3D default_llseek,
+       .owner  =3D THIS_MODULE
+};
+
+
+/**
+ * DOC: AMDGPU TA debugfs interfaces
+ *
+ * Three debugfs interfaces can be opened by a program to
+ * load/invoke/unload TA,
+ *
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_load
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_invoke
+ * - /sys/kernel/debug/dri/<N>/ta_if/ta_unload
+ *
+ * How to use the interfaces in a program?
+ *
+ * A program needs to provide transmit buffer to the interfaces
+ * and will receive buffer from the interfaces below,
+ *
+ * - For TA load debugfs interface:
+ *   Transmit buffer:
+ *    - TA type (4bytes)
+ *    - TA bin length (4bytes)
+ *    - TA bin
+ *   Receive buffer:
+ *    - TA ID (4bytes)
+ *
+ * - For TA invoke debugfs interface:
+ *   Transmit buffer:
+ *    - TA ID (4bytes)
+ *    - TA CMD ID (4bytes)
+ *    - TA shard buf length (4bytes)
+ *    - TA shared buf
+ *   Receive buffer:
+ *    - TA shared buf
+ *
+ * - For TA unload debugfs interface:
+ *   Transmit buffer:
+ *    - TA ID (4bytes)
+ */
+
+static ssize_t ta_if_load_debugfs_write(struct file *fp, const char
+*buf, size_t len, loff_t *off) {
+       uint32_t ta_type    =3D 0;
+       uint32_t ta_bin_len =3D 0;
+       uint8_t  *ta_bin    =3D NULL;
+       uint32_t copy_pos   =3D 0;
+       int      ret        =3D 0;
+
+       struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode=
(fp)->i_private;
+       struct psp_context   *psp    =3D &adev->psp;
+       struct ta_context    context =3D {0};
+
+       if (!buf)
+               return -EINVAL;
+
+       ret =3D copy_from_user((void *)&ta_type, &buf[copy_pos], sizeof(uin=
t32_t));
+       if (ret || (!is_ta_type_valid(ta_type)))
+               return -EINVAL;
+
+       copy_pos +=3D sizeof(uint32_t);
+
+       ret =3D copy_from_user((void *)&ta_bin_len, &buf[copy_pos], sizeof(=
uint32_t));
+       if (ret)
+               return -EINVAL;
+
+       copy_pos +=3D sizeof(uint32_t);
+
+       ta_bin =3D kzalloc(ta_bin_len, GFP_KERNEL);
+       if (!ta_bin)
+               ret =3D -ENOMEM;
+       ret =3D copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len);
+       if (ret)
+               goto err_free_bin;
+
+       ret =3D psp_ras_terminate(psp);
+       if (ret) {
+               dev_err(adev->dev, "Failed to unload embedded RAS TA\n");
+               goto err_free_bin;
+       }
+
+       context.ta_type             =3D ta_type;
+       context.ta_load_type        =3D GFX_CMD_ID_LOAD_TA;
+       context.bin_desc.fw_version =3D get_bin_version(ta_bin);
+       context.bin_desc.size_bytes =3D ta_bin_len;
+       context.bin_desc.start_addr =3D ta_bin;
+
+       ret =3D psp_ta_load(psp, &context);
+
+       if (ret || context.resp_status) {
+               dev_err(adev->dev, "TA load via debugfs failed (%d) status =
%d\n",
+                        ret, context.resp_status);
+               goto err_free_bin;
+       }
+
+       context.initialized =3D true;
+       ret =3D copy_to_user((char *)buf, (void *)&context.session_id,
+sizeof(uint32_t));
+
+err_free_bin:
+       kfree(ta_bin);
+
+       return ret;
+}
+
+static ssize_t ta_if_unload_debugfs_write(struct file *fp, const char
+*buf, size_t len, loff_t *off) {
+       uint32_t ta_id  =3D 0;
+       int      ret    =3D 0;
+
+       struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode=
(fp)->i_private;
+       struct psp_context   *psp    =3D &adev->psp;
+       struct ta_context    context =3D {0};
+
+       if (!buf)
+               return -EINVAL;
+
+       ret =3D copy_from_user((void *)&ta_id, buf, sizeof(uint32_t));
+       if (ret)
+               return -EINVAL;
+
+       context.session_id =3D ta_id;
+
+       ret =3D psp_ta_unload(psp, &context);
+       if (!ret)
+               context.initialized =3D false;
+
+       return ret;
+}
+
+static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char
+*buf, size_t len, loff_t *off) {
+       uint32_t ta_id          =3D 0;
+       uint32_t cmd_id         =3D 0;
+       uint32_t shared_buf_len =3D 0;
+       uint8_t  *shared_buf    =3D NULL;
+       uint32_t copy_pos       =3D 0;
+       int      ret            =3D 0;
+
+       struct amdgpu_device *adev   =3D (struct amdgpu_device *)file_inode=
(fp)->i_private;
+       struct psp_context   *psp    =3D &adev->psp;
+       struct ta_context    context =3D {0};
+
+       if (!buf)
+               return -EINVAL;
+
+       ret =3D copy_from_user((void *)&ta_id, &buf[copy_pos], sizeof(uint3=
2_t));
+       if (ret)
+               return -EINVAL;
+       copy_pos +=3D sizeof(uint32_t);
+
+       ret =3D copy_from_user((void *)&cmd_id, &buf[copy_pos], sizeof(uint=
32_t));
+       if (ret)
+               return -EINVAL;
+       copy_pos +=3D sizeof(uint32_t);
+
+       ret =3D copy_from_user((void *)&shared_buf_len, &buf[copy_pos], siz=
eof(uint32_t));
+       if (ret)
+               return -EINVAL;
+       copy_pos +=3D sizeof(uint32_t);
+
+       shared_buf =3D kzalloc(shared_buf_len, GFP_KERNEL);
+       if (!shared_buf)
+               ret =3D -ENOMEM;
+       ret =3D copy_from_user((void *)shared_buf, &buf[copy_pos], shared_b=
uf_len);
+       if (ret)
+               goto err_free_shared_buf;
+
+       context.session_id =3D ta_id;
+
+       prep_ta_mem_context(psp, &context, shared_buf, shared_buf_len);
+
+       ret =3D psp_ta_invoke_indirect(psp, cmd_id, &context);
+
+       if (ret || context.resp_status) {
+               dev_err(adev->dev, "TA invoke via debugfs failed (%d) statu=
s %d\n",
+                        ret, context.resp_status);
+               goto err_free_ta_shared_buf;
+       }
+
+       ret =3D copy_to_user((char *)buf, context.mem_context.shared_buf,
+shared_buf_len);
+
+err_free_ta_shared_buf:
+       psp_ta_free_shared_buf(&context.mem_context);
+
+err_free_shared_buf:
+       kfree(shared_buf);
+
+       return ret;
+}
+
+static struct dentry *amdgpu_ta_if_debugfs_create(struct amdgpu_device
+*adev) {
+       struct drm_minor *minor =3D adev_to_drm(adev)->primary;
+
+       dir =3D debugfs_create_dir(TA_IF_FS_NAME, minor->debugfs_root);
+
+       ta_load_debugfs_dentry =3D debugfs_create_file("ta_load", 0200, dir=
, adev,
+                                                    &ta_load_debugfs_fops)=
;
+
+       ta_unload_debugfs_dentry =3D debugfs_create_file("ta_unload", 0200,=
 dir,
+                                                    adev, &ta_unload_debug=
fs_fops);
+
+       ta_invoke_debugfs_dentry =3D debugfs_create_file("ta_invoke", 0200,=
 dir,
+                                                    adev, &ta_invoke_debug=
fs_fops);
+       return dir;
+}
+
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev) { #if
+defined(CONFIG_DEBUG_FS)
+       dir =3D amdgpu_ta_if_debugfs_create(adev);
+#endif
+}
+
+void amdgpu_ta_if_debugfs_remove(void)
+{
+       debugfs_remove_recursive(dir);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_psp_ta.h
new file mode 100644
index 00000000000000..883f89d57616d0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef __AMDGPU_PSP_TA_H__
+#define __AMDGPU_PSP_TA_H__
+
+void amdgpu_ta_if_debugfs_init(struct amdgpu_device *adev); void
+amdgpu_ta_if_debugfs_remove(void);
+
+#endif
--
2.17.1

