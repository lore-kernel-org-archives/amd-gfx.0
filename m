Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74985C001DB
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 10:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D076610E22A;
	Mon,  7 Aug 2023 10:23:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66AF810E204
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 10:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLyAqP90MTMjmL+xoectfECzvPKDGG+XFSeBU/MWp3Gn9VOD2mP61hVPGXmOFgbmi8bVCHLzuiEDGrDXFe5TXf9u/jzInSd9vThi6PV85Pehx2ul2MfSxA5fJo+YTzPM4HzUd0zuMy9Med5yxVppJEoELnKIc2lrIfNc/AW/i/A7vE2JVlVzosB7NhUGjngvj/zjzKxJx5dxC+0jo1DpDgXOMEVef6BK/5f7ieChceFkFsiQtvWsrHXg8wrCwwSzLzfVyuSQzSdk0StVWAoXtQRq12namv6GfTZvnmgv2qL9cMCsOb8YbsyMCD+0HDao5VZ/i7RxyKIkCitl2EP08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNF4FvGafQxKg01uKEWhw9naG7mImrYVfCCZPnmJyro=;
 b=Q/rgpAXCn6DLO8ol6m+bUlq37ZQlTkrnAjSWiLLy8D9iVTcs7orUFh7fmqREpV5fiR/xRWdPpPvJ5TpZeGIzcXr6wUfVJgod1XGcyHc5Kx6knN8vPXFDmOyzn+s5FxKNwuifAK2jH4V+lAKSJZIGwRZGsB7zLYcPLiNIbx/ar0/2jVn+D73f7AOOpSCO4q1YqfBH6zeLgIp0IVR78nB8C+0C5gh2Qk+WjVzMTyhFkq8XNbhdLKZGAmj2KbuKSBA7JfV2droYog8G85soxbDqCTV8jb6uwWV8Lxww0dwFJPnWUy0wl5HRBsnM5thQXPeFcxf683pfW69Kxtta84AEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNF4FvGafQxKg01uKEWhw9naG7mImrYVfCCZPnmJyro=;
 b=YHKR4DUeLB8/rsPIJGt6NXw1YCGJDxKhoTP+aca8d6PzsP4QjPZD4tEKoHp6ukDxMHnWm2bvwthmbPz3m9GvKGUFNvKReH65+yBN+OX7W8mfB6wg60MK3fAunoEw4wgBkJMgSyYybQrU70+C2w3HHisZkQvDYqMpI9KwdeSyiuU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB6929.namprd12.prod.outlook.com (2603:10b6:806:263::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 10:22:52 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 10:22:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Add FRU sysfs nodes only if needed
Thread-Topic: [PATCH v2] drm/amdgpu: Add FRU sysfs nodes only if needed
Thread-Index: AQHZyQmsDKcw2x67wUq/eaxOj6Yvg6/eoBSA
Date: Mon, 7 Aug 2023 10:22:51 +0000
Message-ID: <BN9PR12MB5257A820DFE4F997077BCDCCFC0CA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230807083153.509539-1-lijo.lazar@amd.com>
In-Reply-To: <20230807083153.509539-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8e439437-67d2-42a6-a78d-5b8441c218a3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-07T10:22:33Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB6929:EE_
x-ms-office365-filtering-correlation-id: 2b1b0f5b-3b72-49c2-2506-08db9730419c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5yU5eVK9IG6JSbrRjktbfLBZ41YeUdPTCnOF/IDviUo1/zhXue3YO9UR4sceG9peIPv2kk/dz8R9+aWpdQWG8R0A2sBAon3bxGWrOumRybYGS54eBFDdmXBZy+1CE4S5fk5YMkHnyNhXeM1TztemYf+FLPXsOBBK7PXqUqoCHtOzBu6tX5t4TZdBx9AtpLHGZrYb3wiGRd1CMcC7WqNyQGtYcYZK/4nk7oBmlM5VkTy2c5/cC9cS553AcIzTQWdkZAQuWMoliddxH85EjDVQXN42btxHW6EpDxn473Yj3Mt9ZBllYCrpGLiqFo3oyDC8zR3ZxRgCM9lkKAbS3U+6B0DGMr/CrGr3CD9qh3z0P90Fo4zC8JdO302jd+tTz5ZQ/MI/TOo/oiuA2hstSAklfoL3LosbfsiW0Kl6zDClu4KSYukyqf+db2uHNGtPUUH7CxLRg1vxDKGrJsk9fRh+rRw+njecJfXpQfa2ioPRFkN1cRwNOYrW29tX8cPc3Bxu7JsdfCHKunlRUVXAB/gQi/sJmlCRypl4pbMUB65inrLmQXhE9l/A6ZruOSEwvaBsL/ETXoUE8InM7ES2ctijbpIRu6fXTCu4wp1dNMTCUWiOL1qQC0lVZ/gSC5cMyyqo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(41300700001)(7696005)(9686003)(71200400001)(122000001)(38100700002)(83380400001)(6506007)(26005)(53546011)(55016003)(316002)(110136005)(33656002)(86362001)(38070700005)(478600001)(2906002)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(66946007)(8676002)(8936002)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ufs4g2VQlmOuFRQOVCdPAYzSkzJeOJygTs2KnRXvWSoSF1iIKXj8Cy7wPRtA?=
 =?us-ascii?Q?LxVK2Xk7w9O5qeikoxlCJjPuNdREpvo3APoOUc+UuevX5wwMjYQpqQoVv4bc?=
 =?us-ascii?Q?9uycQcqXXcr1MKRUKRe1UcCxTj5884fah/O58muZxjWT+rsKWtX6abc22Vg1?=
 =?us-ascii?Q?+utqV9BlOzVwbaKcghnk1BS6nG2f0NmQblIJNdzQB6PAACDP8PFaMI2AfZjX?=
 =?us-ascii?Q?7xNOQ8IOJRlTdi2nvJa8aSrUsQ/7xAQotZxLR0p8p1A5o1vHXwXFrYyM/FoQ?=
 =?us-ascii?Q?LkKSgG2pnmdMUNx6FBUbH1b0D6s9IFB1KfA/dHlnIrQznzojOeTsUXF+uCPO?=
 =?us-ascii?Q?CUnoL0vdVOTdZxKyFxIimn8Wdqaj7eDMflAVD0ZcbCrsA95VITlUp91nNmOS?=
 =?us-ascii?Q?5V/P7brcXvOduqwm3uKoMe7S0U0yVaTboOE37flXBU5MelunKSwBQrhg0N4U?=
 =?us-ascii?Q?JZIrSmSsFbSM79rXv93ZJfwG5N1dY3FQos09oaSY5LM+g6PQ04UHGZune0uL?=
 =?us-ascii?Q?buJ77/VmlUvYhIojF/1G3aN1u1lZr9cW6a4I2Hqid4vviLPiz4jtyMWpatFK?=
 =?us-ascii?Q?5WY5KDttFAOPCNTIgctynl3DK1jSK15u2SxJ1E9e1UCIKnwHpA5uhQJ8wtAL?=
 =?us-ascii?Q?4vDSpCE/opjahsVpIW6w7FoicfhVPr2R58nQGyuIt9O8VaEMGPSml8w2kyda?=
 =?us-ascii?Q?Klbv5XYA35D9ijZFy3+ygETSIOg5eotp2YgDTte7bahkmGpzvhrV2EXavqBP?=
 =?us-ascii?Q?CByDAPnZdQHR4K65S2FRBZh51wBobNRTrE7zQuDS8RavCMEJIYWdmOsVEXUR?=
 =?us-ascii?Q?GDr6aA4k4TUkaJ4teUZFJLCx4pcCOovHZxCY1nOSd7qcMAjLLXJGJmXQLP0H?=
 =?us-ascii?Q?cBQ24K7acT6tJdLifdf7pil1MwUxRVhO5e0GeLoBB5ZtsaLGTWJqvH9n8omu?=
 =?us-ascii?Q?UrUF5HtPzz0yGKaIPaWroaB+Qbgan2P6DISIf2Nyv+RCvEIj2n17lyOvhHdw?=
 =?us-ascii?Q?INnwTW/DiN0q1AdoFFr+0RMf+sG8lX5tc/3aikKbrG11iKYCNYsaUJm7/zwu?=
 =?us-ascii?Q?QdbLcLTksKbUoLTb6MhmU8bEqpCsLne8aWtYq5YInJHQs+vnXynTOMGth84+?=
 =?us-ascii?Q?5+GW2kaJV9QXlLxkWBv3DYDpzgOtMqj5vIib4ZVokkRt5pn5YF5JNqoYj0Tg?=
 =?us-ascii?Q?TrayUZ51pnlunHyXm40BBQuG0BwkGSStJVXHqSj0IQgtPqyMzKwt6vKqqOxv?=
 =?us-ascii?Q?BDDet1qVZecdTcAxqNboAFJuMYKFGD7U84ZHNXx9Sjnbg+g3zcO4XnZu9yU6?=
 =?us-ascii?Q?q51U8/lXrrsdVtcs+K4X1yT49o5K6HlDudkDED6WadYKbXQ+aV1DVgw4WJg0?=
 =?us-ascii?Q?cl2sg5h7tPXjjAEUaSlnh0JmRNGmd8/0De7FMkOQGoQQ08apl1uEsIMHAMMy?=
 =?us-ascii?Q?dKkEZof+2rDwHiMcVcQERZNA4HIYGvTkQl4L88hDRoTVpAl/TzPA2w3K5gGK?=
 =?us-ascii?Q?mIepF2/+BvwhOFZn6KMlp6DzkWeycWD86BNOJCr4JgVNYrf0379T598jJA3+?=
 =?us-ascii?Q?Rdc6+CruPFj7LZTlZfw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1b0f5b-3b72-49c2-2506-08db9730419c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 10:22:51.7577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CMTonuWBFlHq5Ulj6F7P0D03VpgSMDbpsBKjgnsyAB36MHzgful8VdBx31pDoO9Z8npoSBSv8fE+4HcIG6DNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6929
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, August 7, 2023 16:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add FRU sysfs nodes only if needed

Create sysfs nodes for FRU data only if FRU data is available. Move the log=
ic to FRU specific file.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---

v2: Add fru sysfs fini to take care of removing files (Hawking)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 71 +--------------
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 89 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h    |  2 +
 3 files changed, 94 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 0d602abd32ba..4f818f13dc9d 100644
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
@@ -4086,6 +4020,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev=
)
        if (adev->ucode_sysfs_en)
                amdgpu_ucode_sysfs_fini(adev);
        sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
+       amdgpu_fru_sysfs_fini(adev);

        /* disable ras feature must before hw fini */
        amdgpu_ras_pre_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index 8c3ee042556a..9c66d98af6d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -212,3 +212,92 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *=
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
+static ssize_t amdgpu_fru_product_name_show(struct device *dev,
+                                           struct device_attribute *attr,
+                                           char *buf)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       return sysfs_emit(buf, "%s\n", adev->product_name); }
+
+static DEVICE_ATTR(product_name, 0444, amdgpu_fru_product_name_show,
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
+static ssize_t amdgpu_fru_product_number_show(struct device *dev,
+                                             struct device_attribute *attr=
,
+                                             char *buf)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       return sysfs_emit(buf, "%s\n", adev->product_number); }
+
+static DEVICE_ATTR(product_number, 0444,
+amdgpu_fru_product_number_show, NULL);
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
+static ssize_t amdgpu_fru_serial_number_show(struct device *dev,
+                                            struct device_attribute *attr,
+                                            char *buf)
+{
+       struct drm_device *ddev =3D dev_get_drvdata(dev);
+       struct amdgpu_device *adev =3D drm_to_adev(ddev);
+
+       return sysfs_emit(buf, "%s\n", adev->serial); }
+
+static DEVICE_ATTR(serial_number, 0444, amdgpu_fru_serial_number_show,
+NULL);
+
+static const struct attribute *amdgpu_fru_attributes[] =3D {
+       &dev_attr_product_name.attr,
+       &dev_attr_product_number.attr,
+       &dev_attr_serial_number.attr,
+       NULL
+};
+
+int amdgpu_fru_sysfs_init(struct amdgpu_device *adev) {
+       if (!is_fru_eeprom_supported(adev, NULL))
+               return 0;
+
+       return sysfs_create_files(&adev->dev->kobj, amdgpu_fru_attributes);=
 }
+
+void amdgpu_fru_sysfs_fini(struct amdgpu_device *adev) {
+       if (!is_fru_eeprom_supported(adev, NULL))
+               return;
+
+       sysfs_remove_files(&adev->dev->kobj, amdgpu_fru_attributes); }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.h
index 1308d976d60e..c817db17cfa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -25,5 +25,7 @@
 #define __AMDGPU_FRU_EEPROM_H__

 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
+int amdgpu_fru_sysfs_init(struct amdgpu_device *adev); void
+amdgpu_fru_sysfs_fini(struct amdgpu_device *adev);

 #endif  // __AMDGPU_FRU_EEPROM_H__
--
2.25.1

