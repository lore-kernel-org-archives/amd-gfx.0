Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3536C47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 23:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762C060FF0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 23:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762C060FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24A66E5CE;
	Mon, 31 May 2021 23:20:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D54986E517
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 23:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ht0hbZxV1ORnDc8GqNadyv+JatbGfFBPfxwUYu2QIbtbvoujTm0EKMHIU6ercl7f7YzXYw2ESEQv7JQxk14uRMt2UqfnWQ/YGDeXcgT9xVAxm81c2VsylUIpRMAGSAgLC6bN+U3slS6O/QuNMn4Juw8ShlanO13EasZ4NZwptTSQSSpZHLuvV5mq1bPX7lnAHsntXZwM80btl5jUihoXPovbiYpQheEhDrv/RLyr6e4feXIy1gXqDn9B7b45/dTQUhcts6UpOrQdMJdkPccqQ8oSJcIXN9ikObvXOhXkOlsu+/Le5W5AThpb+Hc1XED+OfiaYZgJeNotfBBSdBEIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cjjW2v5Cl+pCAkAVSgAAlFQnv6EvXoKFMPGeqT5sbs=;
 b=ce2ypFqxbo4a1j4SeMl19zsUxtRPXZKk1FS3+Ocz3yM1wWk5JPdImCVpoYMezCsJ6tP1HSNpwPNK9HbMBzKwgY7wbBCjicSF+qNu//Vri3Oyfje8DriiyjC4uTvArYsv0ANv5FbZLWAEGSpySPnvvMiY5xrZ73nzCW71a2pmvFWYZn+19XmOmGJLiauEW/Jlzn7kLW88VrYzmtp748MpcDPgzXa8Qk78C+K5P6obUL7I2Wh0zrFhlzYFpXWyzoTqWfYAtqqrL9LH1fb9VwTaHRHqf5D1NHXQTbZaJux0OS1d5yfPVOKtJfUMvm+KkmtZmA+roa4tKvolEbhFkclF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cjjW2v5Cl+pCAkAVSgAAlFQnv6EvXoKFMPGeqT5sbs=;
 b=CiEeMWm8ObqpyOf2u9ISaQUsmN7WVbrQTbDr/z2Si3lcCpT3RWrz3IyWJsODRRblA4MbJ9G//JaQQFiLUBwWmeIe387r4NZRwMbLQ0j+q8MHJ/1nDZ5Bkc4r4PXrj9MMv2eyFuIGDfWU/OtnqjRW8DeFykELrRddq++PEViJmzE=
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR1201MB0251.namprd12.prod.outlook.com (2603:10b6:4:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 23:20:12 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0%4]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 23:20:12 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function
 signature
Thread-Topic: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function
 signature
Thread-Index: AQHXVBYeoepHF8dB0UqdYhF2bLZulqr9HXOAgAEghkU=
Date: Mon, 31 May 2021 23:20:12 +0000
Message-ID: <DM6PR12MB2954B3E943CD476445C945E9F03F9@DM6PR12MB2954.namprd12.prod.outlook.com>
References: <20210528230621.16468-1-darren.powell@amd.com>
 <20210528230621.16468-3-darren.powell@amd.com>,
 <CH0PR12MB5348CD424C6F4A5E0A064598973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5348CD424C6F4A5E0A064598973F9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-31T23:20:11.960Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08ecc92d-d114-49bc-e3e6-08d9248aa40d
x-ms-traffictypediagnostic: DM5PR1201MB0251:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB02516A8B96D556B8D15B750CF03F9@DM5PR1201MB0251.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6aQsH5jim8AZhoyhhIJ2/dRe4dU3T6PhMepbHIBMDmPEjZGuhQ/4YzRZ8oNcSuXyIo+RhnbWkWHkLGQ2q3rS/ctosN7QXKwtINBlvBiI9VmkINeRe9OWQjyCU7npnylRLPDnpK5kR4QUjScwcQvn02CtrIqZEi+6kaeaUAJA/GjVQ50nTlsRwF2BT4Z1c3xi5YfBgM7U6M5cEIN2CY7e/Aj2I0LtyiYdimhUv38U0+yI/CBKK3pkqiZea0ho/MXcFNd/DsYqxP9cDI3j2zxRWufHyM9YNvJ8q0H2UdlnEh0Ul695ou6EvYWqkYkBRJE/gxsvB976C4fPeYHOHjdmm7rqQqYI4ZeARMLVUo6QmsJHZH0KtsfLS8lb11h4WQHNLcCr+E8qGNlNGim2dxB1qjQ4Kk5TDn0Ef79i41ZxA0TWF9cKnMVPlW6/zn8knfILFpAsrzN7XfOw/5EUwDtJulsKwc7cU22mjtcExNrKmKbIGXH5GiYEtltre6Or+ZOm42NYDe3dGEJ0qzivlzkGvBXCLVvl9WzW1rCq0vUvViLVUUXqDfoltl2RhpPaZHbrOFtX+6v+BCHTbnuDnJvLp2YJIQgCFruibrSqcUhvO0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(53546011)(6506007)(26005)(52536014)(478600001)(9686003)(316002)(33656002)(7696005)(5660300002)(66476007)(64756008)(66446008)(110136005)(2906002)(76116006)(66946007)(66556008)(19627405001)(83380400001)(122000001)(38100700002)(8936002)(55016002)(71200400001)(186003)(8676002)(91956017)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?99YX03rps0eGiAGKiRYozfCli7ew3EFAG6FW+QMEH+vHwL00RnxQ2+MHNR?=
 =?iso-8859-1?Q?GIDfi+CKTEbBqW/PgcTCyHBXxKrYoij4EiDi/v5mJFBDWD/QtASUDAZaD8?=
 =?iso-8859-1?Q?iJmE37SkR72pp4k8Gpw22Wpyl0z2Z7To7UaxLrgV04mB0rh2HQqxV6AXOU?=
 =?iso-8859-1?Q?9HuJrx9npJf2xI5VqNlCmMpjiHVWHTxqqdv0DRvrlC/VdIJVaiEzoalqYc?=
 =?iso-8859-1?Q?4YjfVBom60r03k6jCmiJQEASc8MuB6HLLO3k6zEXXzXreEMbCens5W6Voj?=
 =?iso-8859-1?Q?yXXIGmmPMptaUw+h7wS3ulSvTCGNnMZYFKPk2nORo46eDn7Lb1XAay2vSb?=
 =?iso-8859-1?Q?jfQ8OaUo790DbDwnlaNCGW7XzwB3QfN7ysnu84fc07Cbvqe6hOECTFl6Q3?=
 =?iso-8859-1?Q?hjVS6eqT4y4Qgpi2CEe+++05xWZBGqFo2X6+MlDosdd23E2GtdXhFOi6z5?=
 =?iso-8859-1?Q?i8+1MDrd3v1kCu4mISJE12WR7Gse01gddOrKq2wr81UJAKWR4Js83gJ4OY?=
 =?iso-8859-1?Q?hkI/UAZRvELJT6+QBo9WNj39iMZvVikm3nBO4Z0UTBMu4HvJ7EDVc4ZjwO?=
 =?iso-8859-1?Q?jo0My6p9xwJ9cUNpMOOOtfkZTJ5ZdcFoJlPs6mE4PWAw3AMQNW0qAQYKir?=
 =?iso-8859-1?Q?DQ8I39I9XdcxwPrP0/J7pNmEGvrA5GP/Gx+UaJTWeSDB25DDif9v/oEJVI?=
 =?iso-8859-1?Q?WMqLsLoBEKLxLgOdyU1vkz0LvZalWqIx8YaRS/6CdZrD+2FqyhunHgIgr7?=
 =?iso-8859-1?Q?En6I98G5l+gUTwcvl3osnJBWdILnuoH8LxLJ+UulzIPNwpi5gB77PXoAij?=
 =?iso-8859-1?Q?SFjBXKrjZN9FaEvyFI9XqLbX2h0F5TGDLVaKMEvrdqVeeAAk+oUJ85Qend?=
 =?iso-8859-1?Q?naL9U/KVKKuWDBCrNdD3+Czl08KW0MM/VnyrdEIejmt0rK+Bh6Lc9tqNGL?=
 =?iso-8859-1?Q?O5JPxK+rwfpQHVhLcB6nz3Ec/H0jpwv1s0YDG6Huo2e8mqPNBCz5I8KUtb?=
 =?iso-8859-1?Q?lLSg2iRUi1mu6ybtSYjtmcmqqAtAy4GrqDnh+HtXfNYE2I9ubsStWOTmJW?=
 =?iso-8859-1?Q?Mx+aahx6Do50cSWy1CH5qX31EF1vvfdyMNwCLwPnP/EqmbguLu4px7i+8L?=
 =?iso-8859-1?Q?Ip8/VjiJZsmPyJvfU+6PTjl8WAUPxYNrGEGnOPO0T3g/C1OaUABShR+LKA?=
 =?iso-8859-1?Q?FFkxponi56k5Rhd2Bo6+KTkB6WRTpJGTD9f7b/ZqoA5cWCFw1v2Pm8jiHr?=
 =?iso-8859-1?Q?u9U23SXRIodP9lvFoFDvFD72DK17SDtrr+03c+Lu36lj2FCPWiyU/NxMrk?=
 =?iso-8859-1?Q?Gi/8jX4Pfh82ISYT4HkDVwSpOj2CRmPX2NdK6CcDQtbIgXvCBIaxa/pzoA?=
 =?iso-8859-1?Q?tr5djydcr2?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ecc92d-d114-49bc-e3e6-08d9248aa40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 23:20:12.4976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWUcFfX1bDZn5OTGmw+bFosPR8u22x3AuTGDWiRemUXujw6aNdrYc0WaIeXwQpU/yhI6ASXmBB1L5moUxvyXuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0251
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
Content-Type: multipart/mixed; boundary="===============0754030814=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0754030814==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB2954B3E943CD476445C945E9F03F9DM6PR12MB2954namp_"

--_000_DM6PR12MB2954B3E943CD476445C945E9F03F9DM6PR12MB2954namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]


>< > The limits are not limited to sample window. There are limits like APU=
 only limit, platform limit and totally obscure ones like PPT0/PPT1 etc.
>It's better that the new enum takes care of those as well in case there is=
 a need to make them available through sysfs.

I think you mean something more like this?
+ enum pp_power_constraints
+{
+       PP_PWR_CONSTRAINT_DEFAULT,
+       PP_PWR_CONSTRAINT_FASTWINDOW,
+};
+


________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, May 31, 2021 2:04 AM
To: Powell, Darren <Darren.Powell@amd.com>; amd-gfx@lists.freedesktop.org <=
amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function s=
ignature

[Public]



-----Original Message-----
From: Powell, Darren <Darren.Powell@amd.com>
Sent: Saturday, May 29, 2021 4:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function signa=
ture

 add two new powerplay enums (limit_level, sample_window)  add enums to smu=
_get_power_limit signature  remove input bitfield stuffing of output variab=
le limit  update calls to smu_get_power_limit

* Test
 AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`  AMD=
GPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -=
f 10`  HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=3D=3D=3D power1 cap =3D=3D=3D" ; cat $HWMON_DIR/power1_cap ;       =
    \
 echo "=3D=3D=3D power1 cap max =3D=3D=3D" ; cat $HWMON_DIR/power1_cap_max =
;   \
 echo "=3D=3D=3D power1 cap def =3D=3D=3D" ; cat $HWMON_DIR/power1_cap_defa=
ult

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    | 14 ++++++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 18 +++++-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  3 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++++++--
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h
index b1cd52a9d684..ddbf802ea8ad 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -192,6 +192,20 @@ enum pp_df_cstate {
         DF_CSTATE_ALLOW,
 };

+enum pp_power_limit_level
+{
+       PP_PWR_LIMIT_MIN =3D -1,
+       PP_PWR_LIMIT_CURRENT,
+       PP_PWR_LIMIT_DEFAULT,
+       PP_PWR_LIMIT_MAX,
+};
+
+ enum pp_power_sample_window
+{
+       PP_PWR_WINDOW_DEFAULT,
+       PP_PWR_WINDOW_FAST,
+};
+

< > The limits are not limited to sample window. There are limits like APU =
only limit, platform limit and totally obscure ones like PPT0/PPT1 etc.
It's better that the new enum takes care of those as well in case there is =
a need to make them available through sysfs.

Thanks,
Lijo

 #define PP_GROUP_MASK        0xF0000000
 #define PP_GROUP_SHIFT       28

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 13da377888d2..f7b45803431d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2717,8 +2717,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,  {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int limit_type =3D to_sensor_dev_attr(attr)->index;
-       uint32_t limit =3D limit_type << 24;
+       enum pp_power_sample_window sample_window =3D to_sensor_dev_attr(at=
tr)->index;
+       uint32_t limit;
         uint32_t max_limit =3D 0;
         ssize_t size;
         int r;
@@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,
         }

         if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
+               smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_MAX,
+sample_window);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else if (pp_funcs && pp_funcs->get_power_limit) {
                 pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2757,8 +2757,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,  {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int limit_type =3D to_sensor_dev_attr(attr)->index;
-       uint32_t limit =3D limit_type << 24;
+       enum pp_power_sample_window sample_window =3D to_sensor_dev_attr(at=
tr)->index;
+       uint32_t limit;
         ssize_t size;
         int r;

@@ -2774,7 +2774,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,
         }

         if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRE=
NT);
+               smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_CURREN=
T,
+sample_window);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else if (pp_funcs && pp_funcs->get_power_limit) {
                 pp_funcs->get_power_limit(adev->powerplay.pp_handle,
@@ -2796,8 +2796,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,  {
         struct amdgpu_device *adev =3D dev_get_drvdata(dev);
         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
-       int limit_type =3D to_sensor_dev_attr(attr)->index;
-       uint32_t limit =3D limit_type << 24;
+       enum pp_power_sample_window sample_window =3D to_sensor_dev_attr(at=
tr)->index;
+       uint32_t limit;
         ssize_t size;
         int r;

@@ -2813,7 +2813,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,
         }

         if (is_support_sw_smu(adev)) {
-               smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAU=
LT);
+               smu_get_power_limit(&adev->smu, &limit, PP_PWR_LIMIT_DEFAUL=
T,
+sample_window);
                 size =3D snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000)=
;
         } else if (pp_funcs && pp_funcs->get_power_limit) {
                 pp_funcs->get_power_limit(adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h
index 523f9d2982e9..b97b960c2eac 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1262,7 +1262,8 @@ enum smu_cmn2asic_mapping_type {  #if !defined(SWSMU_=
CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYE=
R_L4)  int smu_get_power_limit(struct smu_context *smu,
                         uint32_t *limit,
-                       enum smu_ppt_limit_level limit_level);
+                       enum pp_power_limit_level pp_limit_level,
+                       enum pp_power_sample_window sample_window);

 bool smu_mode1_reset_is_support(struct smu_context *smu);  bool smu_mode2_=
reset_is_support(struct smu_context *smu); diff --git a/drivers/gpu/drm/amd=
/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8aff67a667fa..44c1baa2748d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2168,14 +2168,44 @@ static int smu_set_fan_speed_rpm(void *handle, uint=
32_t speed)

 int smu_get_power_limit(struct smu_context *smu,
                         uint32_t *limit,
-                       enum smu_ppt_limit_level limit_level)
+                       enum pp_power_limit_level pp_limit_level,
+                       enum pp_power_sample_window sample_window)
 {
-       uint32_t limit_type =3D *limit >> 24;
+       enum smu_ppt_limit_level limit_level;
+       uint32_t limit_type;
         int ret =3D 0;

         if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
                 return -EOPNOTSUPP;

+       switch(sample_window) {
+       case PP_PWR_WINDOW_DEFAULT:
+               limit_type =3D SMU_DEFAULT_PPT_LIMIT;
+               break;
+       case PP_PWR_WINDOW_FAST:
+               limit_type =3D SMU_FAST_PPT_LIMIT;
+               break;
+       default:
+               return -EOPNOTSUPP;
+               break;
+       }
+
+       switch(pp_limit_level){
+       case PP_PWR_LIMIT_CURRENT:
+               limit_level =3D SMU_PPT_LIMIT_CURRENT;
+               break;
+       case PP_PWR_LIMIT_DEFAULT:
+               limit_level =3D SMU_PPT_LIMIT_DEFAULT;
+               break;
+       case PP_PWR_LIMIT_MAX:
+               limit_level =3D SMU_PPT_LIMIT_MAX;
+               break;
+       case PP_PWR_LIMIT_MIN:
+       default:
+               return -EOPNOTSUPP;
+               break;
+       }
+
         mutex_lock(&smu->mutex);

         if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT) {
--
2.25.1

--_000_DM6PR12MB2954B3E943CD476445C945E9F03F9DM6PR12MB2954namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West Eur=
opean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robo=
to, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background-c=
olor:rgb(255, 255, 255)">
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&gt;&lt; &gt; The limi=
ts are not
 limited to sample window. There are limits like APU only limit, platform l=
imit and totally obscure ones like PPT0/PPT1 etc.</span><br style=3D"font-f=
amily:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot=
;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica=
 Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 255, =
255)">
<span style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West E=
uropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Ro=
boto, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background=
-color:rgb(255, 255, 255);display:inline !important">&gt;It's better that t=
he
 new enum takes care of those as well in case there is a need to make them =
available through sysfs.</span><br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
I think you mean something more like this?</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"margin:0px;font-size:14.6667px;font-family:&quot;Segoe UI&qu=
ot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
;background-color:rgb(255, 255, 255);display:inline !important">+ enum pp_p=
ower_constraints</span><br>
<span style=3D"margin:0px;font-size:14.6667px;font-family:&quot;Segoe UI&qu=
ot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
;background-color:rgb(255, 255, 255);display:inline !important">+{</span><b=
r style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West Europ=
ean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto=
, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background-col=
or:rgb(255, 255, 255)">
<span style=3D"margin:0px;font-size:14.6667px;font-family:&quot;Segoe UI&qu=
ot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
;background-color:rgb(255, 255, 255);display:inline !important">+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_CONSTRAINT_DEFAULT,</span><br style=3D"fo=
nt-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &=
quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helve=
tica Neue&quot;, sans-serif;font-size:14.6667px;background-color:rgb(255, 2=
55, 255)">
<span style=3D"margin:0px;font-size:14.6667px;font-family:&quot;Segoe UI&qu=
ot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
;background-color:rgb(255, 255, 255);display:inline !important">+&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_<span style=3D"background-color:rgb(255, =
255, 255);display:inline !important">CONSTRAINT_</span>FASTWINDOW,</span><b=
r style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West Europ=
ean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto=
, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background-col=
or:rgb(255, 255, 255)">
<span style=3D"margin:0px;font-size:14.6667px;font-family:&quot;Segoe UI&qu=
ot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
;background-color:rgb(255, 255, 255);display:inline !important">+};</span><=
br style=3D"font-family:&quot;Segoe UI&quot;, &quot;Segoe UI Web (West Euro=
pean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robot=
o, &quot;Helvetica Neue&quot;, sans-serif;font-size:14.6667px;background-co=
lor:rgb(255, 255, 255)">
<span style=3D"margin:0px;font-size:14.6667px;font-family:&quot;Segoe UI&qu=
ot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple=
-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif=
;background-color:rgb(255, 255, 255);display:inline !important">+</span><br=
>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Monday, May 31, 2021 2:04 AM<br>
<b>To:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;; amd-gfx@lists.free=
desktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit fun=
ction signature</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[Public]<br>
<br>
<br>
<br>
-----Original Message-----<br>
From: Powell, Darren &lt;Darren.Powell@amd.com&gt; <br>
Sent: Saturday, May 29, 2021 4:36 AM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
Subject: [PATCH 2/6] amdgpu/pm: clean up smu_get_power_limit function signa=
ture<br>
<br>
&nbsp;add two new powerplay enums (limit_level, sample_window)&nbsp; add en=
ums to smu_get_power_limit signature&nbsp; remove input bitfield stuffing o=
f output variable limit&nbsp; update calls to smu_get_power_limit<br>
<br>
* Test<br>
&nbsp;AMDGPU_PCI_ADDR=3D`lspci -nn | grep &quot;VGA\|Display&quot; | cut -d=
 &quot; &quot; -f 1`&nbsp; AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $=
AMDGPU_PCI_ADDR | cut -d &quot; &quot; -f 10`&nbsp; HWMON_DIR=3D/sys/class/=
hwmon/${AMDGPU_HWMON}<br>
<br>
&nbsp;lspci -nn | grep &quot;VGA\|Display&quot; ; \<br>
&nbsp;echo &quot;=3D=3D=3D power1 cap =3D=3D=3D&quot; ; cat $HWMON_DIR/powe=
r1_cap ;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;echo &quot;=3D=3D=3D power1 cap max =3D=3D=3D&quot; ; cat $HWMON_DIR/=
power1_cap_max ;&nbsp;&nbsp; \<br>
&nbsp;echo &quot;=3D=3D=3D power1 cap def =3D=3D=3D&quot; ; cat $HWMON_DIR/=
power1_cap_default<br>
<br>
Signed-off-by: Darren Powell &lt;darren.powell@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/include/kgd_pp_interface.h&nbsp;&nbsp;&nbsp; | 14 +++=
+++++<br>
&nbsp;drivers/gpu/drm/amd/pm/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 18 +++++-----<br>
&nbsp;drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c&nbsp;&nbsp;&nbsp;&nbsp; | 3=
4 +++++++++++++++++--<br>
&nbsp;4 files changed, 57 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/d=
rm/amd/include/kgd_pp_interface.h<br>
index b1cd52a9d684..ddbf802ea8ad 100644<br>
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h<br>
@@ -192,6 +192,20 @@ enum pp_df_cstate {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DF_CSTATE_ALLOW,<br>
&nbsp;};<br>
&nbsp;<br>
+enum pp_power_limit_level<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_MIN =3D -1,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_CURRENT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_DEFAULT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_LIMIT_MAX,<br>
+};<br>
+<br>
+ enum pp_power_sample_window<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_WINDOW_DEFAULT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_PWR_WINDOW_FAST,<br>
+};<br>
+<br>
<br>
&lt; &gt; The limits are not limited to sample window. There are limits lik=
e APU only limit, platform limit and totally obscure ones like PPT0/PPT1 et=
c.
<br>
It's better that the new enum takes care of those as well in case there is =
a need to make them available through sysfs.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
&nbsp;#define PP_GROUP_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xF00=
00000<br>
&nbsp;#define PP_GROUP_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 28<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c<br>
index 13da377888d2..f7b45803431d 100644<br>
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c<br>
@@ -2717,8 +2717,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int limit_type =3D to_sensor_dev_attr=
(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D limit_type &lt;&lt=
; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sample_window sample_wi=
ndow =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_limit =3D 0;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
@@ -2735,7 +2735,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct=
 device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, SMU_PPT_LIMIT=
_MAX);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, PP_PWR_LIMIT_=
MAX, <br>
+sample_window);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs &amp;&=
amp; pp_funcs-&gt;get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_ha=
ndle,<br>
@@ -2757,8 +2757,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int limit_type =3D to_sensor_dev_attr=
(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D limit_type &lt;&lt=
; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sample_window sample_wi=
ndow =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
@@ -2774,7 +2774,7 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct dev=
ice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, SMU_PPT_LIMIT=
_CURRENT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, PP_PWR_LIMIT_=
CURRENT, <br>
+sample_window);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs &amp;&=
amp; pp_funcs-&gt;get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_ha=
ndle,<br>
@@ -2796,8 +2796,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev_get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_pm_funcs =
*pp_funcs =3D adev-&gt;powerplay.pp_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int limit_type =3D to_sensor_dev_attr=
(attr)-&gt;index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit =3D limit_type &lt;&lt=
; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sample_window sample_wi=
ndow =3D to_sensor_dev_attr(attr)-&gt;index;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
@@ -2813,7 +2813,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(st=
ruct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, SMU_PPT_LIMIT=
_DEFAULT);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_get_power_limit(&amp;adev-&gt;smu, &amp;limit, PP_PWR_LIMIT_=
DEFAULT, <br>
+sample_window);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size =3D snprintf(buf, PAGE_SIZE, &quot;%u\n&quot;, l=
imit * 1000000);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (pp_funcs &amp;&=
amp; pp_funcs-&gt;get_power_limit) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pp_funcs-&gt;get_power_limit(adev-&gt;powerplay.pp_ha=
ndle,<br>
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/=
pm/inc/amdgpu_smu.h<br>
index 523f9d2982e9..b97b960c2eac 100644<br>
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h<br>
@@ -1262,7 +1262,8 @@ enum smu_cmn2asic_mapping_type {&nbsp; #if !defined(S=
WSMU_CODE_LAYER_L2) &amp;&amp; !defined(SWSMU_CODE_LAYER_L3) &amp;&amp; !de=
fined(SWSMU_CODE_LAYER_L4)&nbsp; int smu_get_power_limit(struct smu_context=
 *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t *limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_lim=
it_level limit_level);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_li=
mit_level pp_limit_level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sa=
mple_window sample_window);<br>
&nbsp;<br>
&nbsp;bool smu_mode1_reset_is_support(struct smu_context *smu);&nbsp; bool =
smu_mode2_reset_is_support(struct smu_context *smu); diff --git a/drivers/g=
pu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.=
c<br>
index 8aff67a667fa..44c1baa2748d 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c<br>
@@ -2168,14 +2168,44 @@ static int smu_set_fan_speed_rpm(void *handle, uint=
32_t speed)<br>
&nbsp;<br>
&nbsp;int smu_get_power_limit(struct smu_context *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint3=
2_t *limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_lim=
it_level limit_level)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_li=
mit_level pp_limit_level,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_power_sa=
mple_window sample_window)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit_type =3D *limit &gt;&g=
t; 24;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum smu_ppt_limit_level limit_level;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t limit_type;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu-&gt;pm_enabled ||=
 !smu-&gt;adev-&gt;pm.dpm_enabled)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EOPNOTSUPP;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(sample_window) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_WINDOW_DEFAULT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_type =3D SMU_DEFAULT_PPT_LIMIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_WINDOW_FAST:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_type =3D SMU_FAST_PPT_LIMIT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch(pp_limit_level){<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_CURRENT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_level =3D SMU_PPT_LIMIT_CURRENT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_DEFAULT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_level =3D SMU_PPT_LIMIT_DEFAULT;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_MAX:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; limit_level =3D SMU_PPT_LIMIT_MAX;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PWR_LIMIT_MIN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EOPNOTSUPP;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;smu-&gt;mu=
tex);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (limit_type !=3D SMU_DE=
FAULT_PPT_LIMIT) {<br>
--<br>
2.25.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB2954B3E943CD476445C945E9F03F9DM6PR12MB2954namp_--

--===============0754030814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0754030814==--
