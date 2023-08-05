Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E881C0015E
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Aug 2023 12:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0067610E192;
	Sat,  5 Aug 2023 12:33:22 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C79810E192
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Aug 2023 12:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GK73kfibAP9PZMCZkhR9RH/MWavum39cUEBIik5hTE3GpauBh2vyWeQwlzYbs5Hw8CI3NkUOZ9oLFK3Zxs6bEe3mZJcbJUfj7xvFbCv0I1wAfJ6Lugm2jwFIcQzasSRIDL0iQyPDIEPXrzOSgMOiO9sKyLjbwH0UzcNaZ9xJla3+yvVMeBQYriitBahs5gHaSuN3wnT68gABxOwPAR3PtjXDnVxKpmwrwMfV4x08o7dS5umjfjSjx1+tU2ZQ02KgAwuW2NASlXXv+D4aSw2H/B/02erK3xbSZAlQWS+QVa4XfpaIUhX8O0NwYUhH0NPfVG/E4O+qwPSXtB8hv/F6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPyWVzyl35oPb8Q5ClNElNELIzu9YyMF/kvtcrrGrqo=;
 b=EglastqCkW1yQeSNg+l6Mb2e5qNdatR7+Lt9MD5qj20Lh6FAl3GuJOhwu5FWWsuXOL9aM/cydqnDftF/eyxrqFZifVRTugR9o/I2i0WWy9zwdY+gsDpmtkDQmjOk284Gnqcr8BtKF9LfWrLu4Fs7s+8g6HdTTbHgoMGcNCoUZe3Q3Qm7YntlxMbwZUw459r98GnwxbFwgrSl39LnDEaBo69SuoWoleI8hkWZ2985ahGjdc8xa9OwosD/ujCWJT+ur04zJW4Csu2NvAa8/hx1gkcR0o0kB+27b3cTSZoiHtquRf7RxFTKqAXmkeXLO6e2S4cZcbuqO8ZUExgCqpGOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPyWVzyl35oPb8Q5ClNElNELIzu9YyMF/kvtcrrGrqo=;
 b=fcMsFLJvP/0/wUMg0j+7UQmtbf6yVCtzfgv6TdAITxMhDTvZf7dIu41S3ZnHcqMuCNmnrSf28BEidai7fgA7OTJndn9Q1iefBmMRwUiynHba13c6IOboREwsStO+oHxFc1o5vtFdANxEzWJKykN+ZT6Lbk/IVG4XZ5hwFdoz5y0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH3PR12MB8755.namprd12.prod.outlook.com (2603:10b6:610:17e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 5 Aug
 2023 12:33:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.022; Sat, 5 Aug 2023
 12:33:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add FRU sysfs nodes only if needed
Thread-Topic: [PATCH] drm/amdgpu: Add FRU sysfs nodes only if needed
Thread-Index: AQHZxtRdVjm0Kii770Sr4yoOy7PVlq/bodbQ
Date: Sat, 5 Aug 2023 12:33:16 +0000
Message-ID: <BN9PR12MB5257D2E351CFC35DF87BD393FC0EA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230804130516.351861-1-lijo.lazar@amd.com>
In-Reply-To: <20230804130516.351861-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2de080f1-03a8-4640-8947-98f6ce71ae66;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-05T12:24:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH3PR12MB8755:EE_
x-ms-office365-filtering-correlation-id: 0dd7e19e-231f-49ef-4ea8-08db95b024b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFK6IBpgG7f/82hDbHSAz2EMXnGSiPMmX41MJiYUxdtSHHPcDxHfNPL5r8MGJyoz4fHAGQ+W/eQsZJgwOJngVoeNvGUzZefm7Q5yrCUKp6k4MnMBVAEERV81aHCnVKS43947npmA7JP62fH4J8OglbCMdRFspCprfFnmb4qW6dj4pkWIfImZD0bUdVl+H1AXZRWcVS1b7/xjIuKC51wMCwdVo89X7LjPA3VM4yXAlAOeqJjvJO7xFWRA4npyXlPfeDqrjkEh1qbNfDY1mfuamJverkgKYcCJ12jmlwC+0s4jeU4tRfjGBBvWIwbkWG2jsuuYQFEi/x5pPcOhyyohaNjXPRRQCxX3k0jN6uiYwAWDydKykRVfHA6a3cNxrdNgKPdVRmBjrW8dZP5q3GUhtepqTrh+JIh80m4vwD9keB3VKw38Iiq4SLVk6KAc5XiST8A71L5QH0EBjcQsQL3DG1ItT9vFTSle5YZcr2RbwonO0IzTWuJQsQSE7UeevjID7yxzoG8PsTSloJh8v2Vv+x0VPRD/iI+TjiHGhSfEzJfMZcIVJcAy8EunvjKunwDnJc1Bqqd6lH0LBwaln2UCBCHIFRvfWI+CgRUBfCOWRuVG3KpaTbScYuNkGO43xyOL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(1800799003)(186006)(451199021)(55016003)(4326008)(316002)(76116006)(66476007)(66556008)(66946007)(64756008)(66446008)(122000001)(38100700002)(9686003)(7696005)(38070700005)(83380400001)(71200400001)(53546011)(6506007)(33656002)(2906002)(86362001)(478600001)(110136005)(8936002)(8676002)(52536014)(41300700001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LRqIeh4Thr7urfoxx3sKXUe4XkeENQeAc9WN/iYHhqGneaZu6REEmbqsZmsN?=
 =?us-ascii?Q?emOUjtpUBZ3Mgmbtz6dPTMWXk+LGItjsGYaK7yqwf5en+toImtYGz/gd/Muo?=
 =?us-ascii?Q?/nESSLs05Tpv0H+N+GHlqv9VkKPmXt3/GCRSHIj0ji6u7mamcMbkw86pLkrw?=
 =?us-ascii?Q?Q5/b4gyCw0mnRLaHu9uPaOiMo6idEMeZzy713Vpc9swUZLGnSLIlgrFln6oZ?=
 =?us-ascii?Q?wir9i1uOYYsP8lXjQxFPI0slJGSKJIAN+JgDI4D105GWi36Hxfd7mRc/TFrz?=
 =?us-ascii?Q?ckTO0TFVRN2BDKj20pARNxWfWa0MnTlClbpD0agzaqcrrUWJxBCmlwfbdoHk?=
 =?us-ascii?Q?IthpPYGWQIng7/h6Lxz1h2ta6d/j6Qp9hneel/xf34P9Y/gu7s/eb9itCfiA?=
 =?us-ascii?Q?wuUi2zi1VGM/4YuFTz2/n8kv541jrnql9Y5aMNl2bqGNIwLNSoxbgi74e+ik?=
 =?us-ascii?Q?zUOJaNuV83AukHrnr3K2QEx+yurTKKiK3OUerUYv6MGHt2tWZQ4GPrI8/VZk?=
 =?us-ascii?Q?1oBenqp006RMOUV3gRHLi339Mj9dDEBT+NFuC0rkDiusqW52ovIl5ppsbsan?=
 =?us-ascii?Q?bEybsKjskW0su/DS08xg4OpHGTSQ3Rppp35HtJgFlX2GQX3OJlD/ORRzjlmr?=
 =?us-ascii?Q?3+3vL4vQ6nr0in/aHoiBmxkNxSqj5fczGszhQ2t2b5sABtpb7xoF6B+l20HR?=
 =?us-ascii?Q?4LZUQ2giQJ5tWIJLwGWts060Vsc21DecNzcROq1/dKHvyzv03x4O3ACmVRo9?=
 =?us-ascii?Q?eRMCeWUTlYo/lyLUcIxZSfv+7Ea7K5rnq3P1ONqGiqPFvhsAPu4pG02Xh8hL?=
 =?us-ascii?Q?Q8nk6nTSwuZCoTG64qB88oka2hMjQKR/v6VWpWQFnN3kp5QR2a0R8g2MirzF?=
 =?us-ascii?Q?DYsqsNVoIPep4xSX3Z1B0WAqeWt0CrgdOURqsow2BaOex39L8E3gMeLQm3+Y?=
 =?us-ascii?Q?NZ+hN72fgO2RkK4bbNMzYsaulHs8TUlBnf/zp/1/osaf2KTcZmMAWis4KYJa?=
 =?us-ascii?Q?DlqyW0c8yulw+4WCFwPOPmUVJdHZ27i0WhvUm8DH41eXbkBBTM1nOuQ8GZy9?=
 =?us-ascii?Q?liBknaPADENrhu8z52N2hfX6AtEfkUzOVdvuu8BC5jts2/oPhbdKhHFQBZkd?=
 =?us-ascii?Q?p0iB+e/qozSdCwcuYZf/DxDpgPITz5ou7k8myGmncTNPi4S1HnG8mng9FDoh?=
 =?us-ascii?Q?WbRZjYHgws/SBk0XeL3OwIqM7yjpnNaUT+UbVFS/N8ukO7lgXVT9cqOorkuX?=
 =?us-ascii?Q?rQ55oT9eF4EgEcQLaFlIBg5hWhc1ZXwc4z5iwYx8giJAG7luVWh8qno6JasE?=
 =?us-ascii?Q?A1FeQIVgv5jsHaM2x7I+sAC7HKcqyg55Pc7SEgbmspgvQrgRrQzow09RXTYO?=
 =?us-ascii?Q?s5nU4b6wzkdkJb7eML7/iJuQqkk/C1LHbwwf2WyRA14cQVSK6MumlUuGdOqT?=
 =?us-ascii?Q?86rRtjYBWJ1XwW8ryjnEmetv/valTJRYS4HFwydSYzEueTWthNVew0BDGnVZ?=
 =?us-ascii?Q?4tku4mbIAWiumRvKR3YeWsK1OAKRuMp4OQ0AaXnD4Fkzfo4XlfoIjfwS5A?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd7e19e-231f-49ef-4ea8-08db95b024b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2023 12:33:16.5224 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpI7hvUnFfRJGDJMC9p0tJxdlUmDvAWWf8UE/PDKU2q6oV/7TWbowi104NQ6ssy/EobjkoJpFXiashiyMpKjvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8755
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

+       return sysfs_create_files(&adev->dev->kobj, amdgpu_fru_attributes);=
 }

We need to remove the fru sysfs nodes in hw_fini phase.

Regards,
Hawking

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, August 4, 2023 21:05
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add FRU sysfs nodes only if needed

Create sysfs nodes for FRU data only if FRU data is available. Move the log=
ic to FRU specific file.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 70 +---------------
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 81 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h    |  1 +
 3 files changed, 84 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 0d602abd32ba..37bc6ebb7fad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -164,71 +164,6 @@ static DEVICE_ATTR(pcie_replay_count, 0444,

 static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);

-/**
- * DOC: product_name
- *
- * The amdgpu driver provides a sysfs API for reporting the product name
- * for the device
- * The file product_name is used for this and returns the product name
- * as returned from the FRU.
- * NOTE: This is only available for certain server cards
- */
-
-static ssize_t amdgpu_device_get_product_name(struct device *dev,
-               struct device_attribute *attr, char *buf)
-{
-       struct drm_device *ddev =3D dev_get_drvdata(dev);
-       struct amdgpu_device *adev =3D drm_to_adev(ddev);
-
-       return sysfs_emit(buf, "%s\n", adev->product_name);
-}
-
-static DEVICE_ATTR(product_name, 0444,
-               amdgpu_device_get_product_name, NULL);
-
-/**
- * DOC: product_number
- *
- * The amdgpu driver provides a sysfs API for reporting the part number
- * for the device
- * The file product_number is used for this and returns the part number
- * as returned from the FRU.
- * NOTE: This is only available for certain server cards
- */
-
-static ssize_t amdgpu_device_get_product_number(struct device *dev,
-               struct device_attribute *attr, char *buf)
-{
-       struct drm_device *ddev =3D dev_get_drvdata(dev);
-       struct amdgpu_device *adev =3D drm_to_adev(ddev);
-
-       return sysfs_emit(buf, "%s\n", adev->product_number);
-}
-
-static DEVICE_ATTR(product_number, 0444,
-               amdgpu_device_get_product_number, NULL);
-
-/**
- * DOC: serial_number
- *
- * The amdgpu driver provides a sysfs API for reporting the serial number
- * for the device
- * The file serial_number is used for this and returns the serial number
- * as returned from the FRU.
- * NOTE: This is only available for certain server cards
- */
-
-static ssize_t amdgpu_device_get_serial_number(struct device *dev,
-               struct device_attribute *attr, char *buf)
-{
-       struct drm_device *ddev =3D dev_get_drvdata(dev);
-       struct amdgpu_device *adev =3D drm_to_adev(ddev);
-
-       return sysfs_emit(buf, "%s\n", adev->serial);
-}
-
-static DEVICE_ATTR(serial_number, 0444,
-               amdgpu_device_get_serial_number, NULL);

 /**
  * amdgpu_device_supports_px - Is the device a dGPU with ATPX power contro=
l @@ -3550,9 +3485,6 @@ static void amdgpu_device_check_iommu_direct_map(st=
ruct amdgpu_device *adev)  }

 static const struct attribute *amdgpu_dev_attributes[] =3D {
-       &dev_attr_product_name.attr,
-       &dev_attr_product_number.attr,
-       &dev_attr_serial_number.attr,
        &dev_attr_pcie_replay_count.attr,
        NULL
 };
@@ -3967,6 +3899,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        if (r)
                dev_err(adev->dev, "Could not create amdgpu device attr\n")=
;

+       amdgpu_fru_sysfs_init(adev);
+
        if (IS_ENABLED(CONFIG_PERF_EVENTS))
                r =3D amdgpu_pmu_init(adev);
        if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index 8c3ee042556a..bb1cc6830a12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -212,3 +212,84 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *=
adev)
        kfree(pia);
        return 0;
 }
+
+/**
+ * DOC: product_name
+ *
+ * The amdgpu driver provides a sysfs API for reporting the product
+name
+ * for the device
+ * The file product_name is used for this and returns the product name
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards  */
+
+static ssize_t amdgpu_fru_get_product_name(struct device *dev,
+                                             struct device_attribute *attr=
,
+                                             char *buf)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       return sysfs_emit(buf, "%s\n", adev->product_name); }
+
+static DEVICE_ATTR(product_name, 0444, amdgpu_fru_get_product_name,
+NULL);
+
+/**
+ * DOC: product_number
+ *
+ * The amdgpu driver provides a sysfs API for reporting the part number
+ * for the device
+ * The file product_number is used for this and returns the part number
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards  */
+
+static ssize_t amdgpu_fru_get_product_number(struct device *dev,
+                                               struct device_attribute *at=
tr,
+                                               char *buf)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       return sysfs_emit(buf, "%s\n", adev->product_number); }
+
+static DEVICE_ATTR(product_number, 0444, amdgpu_fru_get_product_number,
+                  NULL);
+
+/**
+ * DOC: serial_number
+ *
+ * The amdgpu driver provides a sysfs API for reporting the serial
+number
+ * for the device
+ * The file serial_number is used for this and returns the serial
+number
+ * as returned from the FRU.
+ * NOTE: This is only available for certain server cards  */
+
+static ssize_t amdgpu_fru_get_serial_number(struct device *dev,
+                                              struct device_attribute *att=
r,
+                                              char *buf)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       return sysfs_emit(buf, "%s\n", adev->serial); }
+
+static DEVICE_ATTR(serial_number, 0444, amdgpu_fru_get_serial_number,
+NULL);
+
+static const struct attribute *amdgpu_fru_attributes[] =3D {
+       &dev_attr_product_name.attr,
+       &dev_attr_product_number.attr,
+       &dev_attr_serial_number.attr, NULL
+};
+
+int amdgpu_fru_sysfs_init(struct amdgpu_device *adev) {
+       if (!is_fru_eeprom_supported(adev, NULL))
+               return 0;
+
+       return sysfs_create_files(&adev->dev->kobj, amdgpu_fru_attributes);=
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.h
index 1308d976d60e..1bfac9300ed5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -25,5 +25,6 @@
 #define __AMDGPU_FRU_EEPROM_H__

 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
+int amdgpu_fru_sysfs_init(struct amdgpu_device *adev);

 #endif  // __AMDGPU_FRU_EEPROM_H__
--
2.25.1

