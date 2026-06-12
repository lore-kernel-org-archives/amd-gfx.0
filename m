Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990E9CD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 10:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A90510E9CB;
	Fri, 12 Jun 2026 10:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y1071e/Z";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99ADC10E9CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 10:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOzgxkL0Wgf8Wsgsl1KJzbRoMaK/OQtbZe4Zsi++14lTlRnWKOj75iyHQwH8TP+ya9YkY024nZI6JmV0fgIE4IWBrUnpU/pVQWDeYeYW2s3ZrA0Ft1N9++W4h7T4N4nl6WLRBUOP0DgljYqlotAsa7Z1vCAomlg3HfnsS2wMA2cJ25OlGN/Ep6rfzItaCqkaupR4zgFFVF0Jxpfa+eJ4bm5i6ecB+iGIPHrIjGiVoCrCP8r7/kZQcZNDcrRdcIdRK/V7+bXAzLBkwp24wOV6MFgCgSKGBbYYOR7gMCV0ukfL2b/fqpwWSptBZY4lFK3ojGo4A/v5MpgUSKSOHk/CAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/84inqhqm9iS7524Lo9qdiNGFafwGbi4Yg3waZcXkY=;
 b=BHQjcCo2KERMROxZGOxxTeso+6+XS9Vv7EC/5MuVSfArB/lehfWuldvBD/YCGnQ2n/lORjKN9b+M47J6wTBvpeACk8oChHWnwPuA1Mk2TR+k5aL4h+aYzSG7OWkvTnYTd0Rf83+fhOhDUUa/ugylbijiDzgTAmfJRInB7Ro/BtO6GGj5HcyQb5jblesbW5Pjh1bAIR0yPASRyPPuRTo8x4zBvyNKfGBucN7MOjngoDhkyZb5DsVsaipLLMCqC8jlLsin9QFe1bUPpZEgEIj2a94kdyv+WmwW2miK8FTmgkE1UhzAol36bf7m4cnnxweKjho/DR/r4msoke8Kh2kfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/84inqhqm9iS7524Lo9qdiNGFafwGbi4Yg3waZcXkY=;
 b=y1071e/ZkEIVeB5rv19V2cplSzwgdfx3JfoDXxQr1AiGfDQuk+YdngYP0IFGn/d19x2vi93+EFXtVMStJMIKgDr13aevbVWyXSQKduF/58bDRRKe2cZmxaoqch0mJ6OKmbvZry7anotvLAfX3Qy8FM49jJvO3KINDVZvo095O/o=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Fri, 12 Jun
 2026 10:57:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0113.011; Fri, 12 Jun 2026
 10:57:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add parameter to allow skip specified PCI
 devices
Thread-Topic: [PATCH] drm/amdgpu: add parameter to allow skip specified PCI
 devices
Thread-Index: AQHc+lK947cM+MGGZ0Wo3aO9AiwbZ7Y6vtsQ
Date: Fri, 12 Jun 2026 10:57:31 +0000
Message-ID: <BN9PR12MB52578E5939277F7E22EBD08AFC182@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260612100321.452007-1-kevinyang.wang@amd.com>
In-Reply-To: <20260612100321.452007-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-12T10:53:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7265:EE_
x-ms-office365-filtering-correlation-id: c456301f-3c38-488c-53d6-08dec871669d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006;
x-microsoft-antispam-message-info: 13nc8OQilBgY7EuAAfuF0xccTQWv8TF3khQ1QSQE5N7g5Kvhw5xRHTBhqKyjdJJW2hhrGUFv8ePFqTtBI0Y1tXwiwWtSSIggeDC8N4GFY9IoDQY/F7UpE1agzJBltaqm9ogDns7GQHVQjb/zx3Q1/QYBXOCgaNBAAi+xgTudJPM04py4QGlpgMnYmzFV9iz0Vz2kfey6Tjsd5tyqEVjZjDcrWUfLDuH9++rbUh2FiSqeIplf/jKbhgPEkXaJ2jpXc8JXLdFQcmruENDXjpWs8DkBM6kErhGtdzfAklHqyUcRc1+XwZIXzi7REIkNa54DqRr11Kt1f/zsd6wsMEPLO4qdDs6NGawTk6Trgsmog0GnZPqnG7fOvk2PVbTFp6b1z34FGG15u3ZjpkQ4NVenLXp4hLAmf9TtuPAM5zjb1SulryrjPGX441mzA+E6I4OdipKk6NOdTqEA1m2eh4xHFb33N6jZO6Rdc7DE1IBd2+n7w7hKtwYQYinzmvim2oZMv60tVzWqeS57aQ2A4SMR9Q07DZcpL4rfG7IVXf4fDBWIsJP7Y2t6riQKbZD71eXA+LqRUNi1D0JgDL6FcLEpLSHvB+o4xBLdnEEvFHnEdNaOWBbd6yJc5j/JrKjZY3AtsssobMoS9nRx9kWicBtEwYb0GmOK9NlKlHnQ+0MODs9jyUlk0+WXcM0snoSPQ5W42yiFq6t6nlzGhPwtt6wN49A2PJXZdr5im37MAHHmIMVCM/1Xf/Mb0mlDCsqGpNNm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JLoeOeziuR+0rQzp+E5Pls2UjXi/GjkLO9mfdgvqYurgNIUw4Ia19qRUeMMW?=
 =?us-ascii?Q?5i38xuYFOFCbZumEgwXWyCllBuAvNq7PVV/ly+j/E+HVe8F1rLzgc3yd2nEH?=
 =?us-ascii?Q?hUpyNNvPWX5SFxN2TveI2u1WbhjBC2EYBFXfP+dT1nE/IpK0AeFNOURBIP7l?=
 =?us-ascii?Q?HgbOS1tD35Zta3I+v4e7P10SAohbjA097FuH7IRp4boxXU3AgN+L2sBAM+08?=
 =?us-ascii?Q?GFN8u5i2ZqUw071S7HVXga3UxHJMZIpHV3teEW1kpW7IXd7zBWvzwS2DtVb1?=
 =?us-ascii?Q?4aKBXhsdftZ9HeE6woOYN8PJu1dAM+X2d/+9llx5Zz76Yf2S5/FHnNamekjB?=
 =?us-ascii?Q?ROyxN+rniLFmONcrtWC42XvHC4wHOHS9titkvStHz6kCSrKs+1TolPydiwQ9?=
 =?us-ascii?Q?B+VV5t5THifl+SOjIZPrjadQD5ZuDpGKsbngXVeaT3Vgay651uXrwfCV7V6S?=
 =?us-ascii?Q?uHw+z8/GjLHI92zZiAr5DtmeEJH8K3+9rfCUiHYdeVMblxp7xL7TzxGlH2Fs?=
 =?us-ascii?Q?ij9bjFtDXbrfZXXoG0qG/rffqix9ryt8NLvo0hp8w0XLIzMBsmyNv0zZHwrT?=
 =?us-ascii?Q?Msbd16Sc5ti0i+sKH+4uXyhMo4Vzc3kTtLJR1ywD2DwzwTVHP6/jTGu8SVxL?=
 =?us-ascii?Q?/00bDctsuv83CxVGI4AMwacAfk+rfpBZSzVDdcGQ6YwmqFEoxIy48x5N7PL+?=
 =?us-ascii?Q?yg8kxtzZ4Fxx9kYSTns3KGImt44avXZQE1C+RSJQv/aSRzjbzwI6PNzCpOMZ?=
 =?us-ascii?Q?/pYZ9CChAj5jhIgRlsPxDfj5m3vTEonCpcFJMz9cazvDEzwLeWeI7O+gv1by?=
 =?us-ascii?Q?l+ItbjHC2uh/PBZWdGkouXbG+nXP6rL9YJVRWXYx93QjaA5g7P44rH7p/S64?=
 =?us-ascii?Q?ZCfUE+HJfpZsvMcdEdzQDquR2MGszsQoKjeJHJIWDN7i+/4k6Ndn2b+LOQuV?=
 =?us-ascii?Q?e3/nzFEN1lJ7kuHTWxXxeibuaJGC1QQL58RVdTzbeo1qik3n3gE7cdEEOKii?=
 =?us-ascii?Q?nkV5VadzwzAExc92/RTd6xwdG5bz60i9CpXPH41rsF4SvfHb9IHhUSHvnRaO?=
 =?us-ascii?Q?0n4r8j+Tvo5eUhmTFTPCawgA5OSuoy/d7L5h3ewYv5aarKGcXrdltV3ifz4k?=
 =?us-ascii?Q?XWFZpP8Iv5y7UbL/OeOl3gJUb63CpIUCp3XhvalGqXyI49fbn6W15Jl95fcA?=
 =?us-ascii?Q?92w4W48KRo55OkvyFr0UbrcAsXuaxXI5iUSzr4wSl3+m0RGtu10L4J/WPO1r?=
 =?us-ascii?Q?zHol401/OOnk7Ix/5HfWmx+pXDPZMfRikU74fX+KgcJzx5F83e92VbYbWszk?=
 =?us-ascii?Q?88Bw9OhkXlCFgwqgypwRxY64dUw8/X/xBIB9uVJ3CGC4RxC8Jlm5cEGAqSYM?=
 =?us-ascii?Q?RdQME5U9iQzFPoNmY1A2YEKnKYJg8tHQO5ikPKFIsklQJakBVs86BvmIh9st?=
 =?us-ascii?Q?tq3WOBY5lZ/h40aPcGiqn9jJPuTHN9e7yTA9LPiayX7PXb8bi/q11HgE2dP3?=
 =?us-ascii?Q?JeM8BPxYao85hlUMhaEaMzZN2jEMNACxNcTAgNqhEhyGoaXd/DdCfWe5an21?=
 =?us-ascii?Q?N6yGbcgF4TfTGxGgg3wlvhXVijAKCOEEZsoRfATX6KeWgz9QWMFTu7JSk26b?=
 =?us-ascii?Q?zDKu9lDSeXbgvjyQpVJHEtO6+OpSp4Hck1PJJ7bbs3HwnBB2cWDjRGUkyj/V?=
 =?us-ascii?Q?7JSiEtakMHfsgXkyp3ztknkbjQ6cq0vejmPO1c4gpYXomRrE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c456301f-3c38-488c-53d6-08dec871669d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 10:57:31.1443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CrfZQridD7k70cB+0uufu4DQBekA2BvdUxHDo39nXWYvdTKDt9N5eY8qH82YbEltsAfLzTcQA/ifWacCAzo+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

pci-stub can provide the same functionality and is a common solution for al=
l PCI devices. We probably do not need to add an amdgpu specific parameter =
for this.

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, June 12, 2026 6:03 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: [PATCH] drm/amdgpu: add parameter to allow skip specified PCI devi=
ces

Add the disable_pci_ids module parameter to let amdgpu skip selected PCI de=
vices before normal device initialization starts.

This is useful on multi-GPU systems where only a subset of devices should b=
e claimed by amdgpu, and for bring-up or debug cases where early probe of s=
pecific devices needs to be avoided.

The parameter accepts a comma-separated list of hex PCI IDs. The device ID =
is required, while the vendor ID and revision ID are optional:

  device ID
  vendor ID:device ID
  vendor ID:device ID:revision ID

For example:
  # cat /proc/cmdline
  amdgpu.disable_pci_ids=3D73bf,1002:7550:c0

Kernel log:
[ 3327.298156] amdgpu 0000:63:00.0: skipping PCI device [1002:7550] (rev c0=
) by module parameter

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 175 ++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 503bb64c1e55..48aded458987 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -35,9 +35,11 @@
 #include <linux/cc_platform.h>
 #include <linux/console.h>
 #include <linux/dynamic_debug.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mmu_notifier.h>
 #include <linux/pm_runtime.h>
+#include <linux/string.h>
 #include <linux/suspend.h>
 #include <linux/vga_switcheroo.h>

@@ -183,6 +185,7 @@ uint amdgpu_pg_mask =3D 0xffffffff;  uint amdgpu_sdma_p=
hase_quantum =3D 32;  char *amdgpu_disable_cu;  char *amdgpu_virtual_displa=
y;
+char amdgpu_disable_pci_ids[256];
 int amdgpu_enforce_isolation =3D -1;
 int amdgpu_modeset =3D -1;

@@ -564,6 +567,28 @@ MODULE_PARM_DESC(virtual_display,
                 "Enable virtual display feature (the virtual_display will =
be set like xxxx:xx:xx.x,x;xxxx:xx:xx.x,x)");  module_param_named(virtual_d=
isplay, amdgpu_virtual_display, charp, 0444);

+/**
+ * DOC: disable_pci_ids (string)
+ * Comma separated list of PCI IDs to skip during probe.
+ *
+ * This can be useful on multi-GPU systems where only a subset of
+devices
+ * should be claimed by amdgpu, or for bring-up and debug cases where
+early
+ * probe of specific devices needs to be avoided.
+ *
+ * The device ID is required. Vendor ID and revision ID are optional.
+Hex IDs
+ * with or without a 0x prefix are accepted. Valid formats are:
+ *
+ * - device ID
+ * - vendor ID:device ID
+ * - vendor ID:device ID:revision ID
+ *
+ * For example: disable_pci_ids=3D73bf,1002:73df:01.
+ */
+MODULE_PARM_DESC(disable_pci_ids,
+                "Skip probing devices matching PCI ID patterns: device ID,=
 vendor
+ID:device ID, or vendor ID:device ID:revision ID"); module_param_string(di=
sable_pci_ids, amdgpu_disable_pci_ids,
+                   sizeof(amdgpu_disable_pci_ids), 0444);
+
 /**
  * DOC: lbpw (int)
  * Override Load Balancing Per Watt (LBPW) support (1 =3D enable, 0 =3D di=
sable). The default is -1 (auto, enabled).
@@ -2216,6 +2241,149 @@ static const struct amdgpu_asic_type_quirk asic_typ=
e_quirks[] =3D {

 static const struct drm_driver amdgpu_kms_driver;

+struct amdgpu_disabled_pci_id {
+       u16 vendor;
+       u16 device;
+       u8 revision;
+       bool has_vendor;
+       bool has_revision;
+};
+
+static int amdgpu_parse_disabled_pci_id_field(const char *str, u16 *id)
+{
+       if (!strncasecmp(str, "0x", 2))
+               str +=3D 2;
+
+       return kstrtou16(str, 16, id);
+}
+
+static int amdgpu_parse_disabled_pci_revision(const char *str, u8
+*revision) {
+       if (!strncasecmp(str, "0x", 2))
+               str +=3D 2;
+
+       return kstrtou8(str, 16, revision);
+}
+
+static int amdgpu_parse_disabled_pci_id(const char *str,
+                                       struct amdgpu_disabled_pci_id *id) =
{
+       char pci_id[32], *fields[3], *tmp;
+       int count =3D 0;
+
+       strscpy(pci_id, str, sizeof(pci_id));
+       tmp =3D pci_id;
+
+       while (tmp && count < ARRAY_SIZE(fields))
+               fields[count++] =3D strsep(&tmp, ":");
+
+       if (tmp || !count)
+               return -EINVAL;
+
+       id->has_vendor =3D false;
+       id->has_revision =3D false;
+
+       switch (count) {
+       case 1:
+               if (!fields[0][0])
+                       return -EINVAL;
+
+               return amdgpu_parse_disabled_pci_id_field(fields[0],
+                                                         &id->device);
+       case 2:
+               if (!fields[0][0] || !fields[1][0])
+                       return -EINVAL;
+
+               if (amdgpu_parse_disabled_pci_id_field(fields[0],
+                                                      &id->vendor))
+                       return -EINVAL;
+
+               if (amdgpu_parse_disabled_pci_id_field(fields[1],
+                                                      &id->device))
+                       return -EINVAL;
+
+               id->has_vendor =3D true;
+               return 0;
+       case 3:
+               if (!fields[0][0] || !fields[1][0] || !fields[2][0])
+                       return -EINVAL;
+
+               if (amdgpu_parse_disabled_pci_id_field(fields[0],
+                                                      &id->vendor))
+                       return -EINVAL;
+
+               if (amdgpu_parse_disabled_pci_id_field(fields[1],
+                                                      &id->device))
+                       return -EINVAL;
+
+               if (amdgpu_parse_disabled_pci_revision(fields[2],
+                                                      &id->revision))
+                       return -EINVAL;
+
+               id->has_vendor =3D true;
+               id->has_revision =3D true;
+               return 0;
+       default:
+               return -EINVAL;
+       }
+}
+
+static bool amdgpu_disabled_pci_id_match(struct pci_dev *pdev,
+                                        const struct amdgpu_disabled_pci_i=
d *id) {
+       if (id->device !=3D pdev->device)
+               return false;
+
+       if (id->has_vendor && id->vendor !=3D pdev->vendor)
+               return false;
+
+       if (id->has_revision && id->revision !=3D pdev->revision)
+               return false;
+
+       return true;
+}
+
+static bool amdgpu_device_id_disabled(struct pci_dev *pdev) {
+       const char *ids =3D amdgpu_disable_pci_ids;
+       char id[32];
+       struct amdgpu_disabled_pci_id pci_id;
+       size_t len;
+
+       while (*ids) {
+               ids +=3D strspn(ids, ",; \t\n");
+               if (!*ids)
+                       break;
+
+               len =3D strcspn(ids, ",; \t\n");
+
+               if (len >=3D sizeof(id)) {
+                       dev_warn(&pdev->dev,
+                                "invalid disabled PCI id '%.*s'\n",
+                                (int)len, ids);
+                       ids +=3D len;
+                       continue;
+               }
+
+               memcpy(id, ids, len);
+               id[len] =3D '\0';
+
+               if (amdgpu_parse_disabled_pci_id(id, &pci_id)) {
+                       dev_warn(&pdev->dev,
+                                "invalid disabled PCI id '%s'\n", id);
+                       ids +=3D len;
+                       continue;
+               }
+
+               if (amdgpu_disabled_pci_id_match(pdev, &pci_id))
+                       return true;
+
+               ids +=3D len;
+       }
+
+       return false;
+}
+
 static void amdgpu_get_secondary_funcs(struct amdgpu_device *adev)  {
        struct pci_dev *p =3D NULL;
@@ -2389,6 +2557,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
                        return -EINVAL;
        }

+       if (amdgpu_device_id_disabled(pdev)) {
+               dev_info(&pdev->dev,
+                        "skipping PCI device [%04x:%04x] (rev %02x) by mod=
ule parameter\n",
+                         pdev->vendor, pdev->device, pdev->revision);
+               return -ENODEV;
+       }
+
        /* skip devices which are owned by radeon */
        for (i =3D 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
                if (amdgpu_unsupported_pciidlist[i] =3D=3D pdev->device)
--
2.47.3

