Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE30C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 13:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17D610E3B4;
	Tue, 13 Jun 2023 13:27:39 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC93710E265
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 13:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7xDXlM3RKPY5Pqj5qHg2FuU7L60MGeMBxxVSgNiuecoVC+VyZJZUALfPTgdkUnANqwJtntkBedPmX1hXeJMKXTvRA+Mk4a5ccKA46BPDzO/VEw4iu3a99ZNMyA5uXqi1GujZx1j6jDeuXzaW4a4nBIZOO5P+Ys6D8bLSjyW9nfPI/egR0aMMAkJeCnA6etHW0+gkSNGG6zD9o6BLI9KpGUwZjKs2FlwUuHkV69m2YOu+4/AE6vxeSa8Sxe84AUiP5UseXWg+jqaNNE15ybLVHm31gJ6wWSmDMqqAtUYAMRzqxzXj0RZ1Yz9FNHtIw6DopZVWRM285wxUxwzICPjBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEGFOfPLFx1+ZPANl0r1UyD1l5RdEMtsbv0Va789KvQ=;
 b=Rq9yaNOpSdFvJnA+mEHfYVZB+rkZRfOXD8B9XYPBLFUnOzsu5AU0g4PmYAhG3koqcdhcM3D8vX3Bb4LqR0HX5nBl1L7g9qRax7tdu1hd4fcM+omDvtDShV199DI6S9UTe7Rct0tcl6NDOxpIUzli/GRtuHuSyRKsncfGF6sP8mNeI23WiUPIvO3XGyJDa6szLrzhO+IAsWMonz+fGhVS8MFos4JNgFJPd9KTQIGbBc8CkKJn1TfMMB4RblmhGLL8sG2UnMc3NZ1VR4m4l7Yv4ZSFkO37gzrW5nn8kwjMqbHvqY/NRGnZuQ4oR1H1q8v+bnKLXimOGKi0G+IDS5nTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEGFOfPLFx1+ZPANl0r1UyD1l5RdEMtsbv0Va789KvQ=;
 b=Cripf5R9R3U0+WU/4mRNhcfX/NxFWFA1u59TvntM7nWJYlJYOK+tgkppA0h+BY3VoAUmo+MN4gLyRFGSlpB8FwVHzr4RSYcBsfxKwM1SWtuYFQhBdOUOeJOpB4zfSxbKzvvocd4lmYRczIOKT8yhxFjYWpMnvTtpTUgL1mLXTPg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 13:27:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 13:27:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface
Thread-Topic: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface
Thread-Index: AQHZneVlsFJsx+LSWEGf1mE5Nc86ra+IuUX+gAAAb/M=
Date: Tue, 13 Jun 2023 13:27:35 +0000
Message-ID: <BL1PR12MB514483C91159FFA26C0FDA91F755A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230613105354.1561876-1-lijo.lazar@amd.com>
 <20230613105354.1561876-3-lijo.lazar@amd.com>
 <BL1PR12MB5144D9F55EA2C1E8DCCAE572F755A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144D9F55EA2C1E8DCCAE572F755A@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-13T13:27:34.730Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN0PR12MB6200:EE_
x-ms-office365-filtering-correlation-id: 19f559bd-ae38-45f4-d093-08db6c11f35b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u0/MjboVrkNIC7RqAi3PTH6CSPxrdYhF4XA6C1/L4wLSQLSc90ft0DlO0AqZa76lU8JxBIWfJQ+1WdHlrpGA1aMLzhlewfwWZrV5tVyEbxNS1jubqbSO2vlZLTrfugknL0kx2L+MxwamnVMvl1O/5wogfWkrFFRLEd8a4qikOBTC0I54+CI5zLBQT4IAxgr17eAsvZdxcQT+54nv7mGZAGty4ME5yjMbjIvmJK6fRJCi3IXnDG9fokj40MhRbNVvAeVXJkIyAUO/w+zxHZmQNDIUcGn2dGPotUjGJBksWUR15KknTSc7Qa0qNELTFFXXyjj69FtNBNoF5YepN5c5+uWhuPnX6pRopZD0wXTa838oTs49n6pnhVxXZhoGqPdfJsHHaAX5yR4rXRvTAMYD2xzmvFJucL426HsEuwp8nX9xh83zw41j+eFRXehZhDquQiWR7C0gkGDuXS2tUiKcubW1dCiuePS3KTwTBPKt0zkGcsP4x0Qdn2OP0OP61AMlfATm2FRI0Q9NXMziB/QTbuft1Zhp0Se57Aw2RuiPSZDJS7Ix1TJgI49vcYiGU7mT/s4xfOJaLycs43bPS7/mgj82cSr5or+5hsneYAsB1eqJt9+jCpFDMvRs9kl5KQQl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(19627405001)(64756008)(83380400001)(55016003)(122000001)(4326008)(33656002)(316002)(7696005)(66476007)(66446008)(41300700001)(38100700002)(38070700005)(71200400001)(9686003)(6506007)(53546011)(66946007)(26005)(76116006)(2906002)(86362001)(5660300002)(478600001)(8936002)(8676002)(52536014)(66556008)(2940100002)(54906003)(110136005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xqLwd2GBSKf3W5UeNvOry07yIpGJHoOvX4RhB4n69TAnr1xLkf2SAFK2kIQp?=
 =?us-ascii?Q?nsj0jBNC0qsXQMeCtYgm43HJsyzKTzq24nDLXktrA9p6lruuyOHxTZszqS9+?=
 =?us-ascii?Q?N4oM8are5XyinfUgOGQW1PmShGwMXWF9kjSBelVBZJ9KU2sMi5HxYUiHRFu7?=
 =?us-ascii?Q?Clu1XHC7RNGGbD8JFO/zJpwPYLadi/LpWaUWvsA7olNpuTTa4RGGHO/gxSDJ?=
 =?us-ascii?Q?/Uq2Z8AOKfSf4s8ZZfnOnZTMjNxImDxFwqgpfTGHWLHeVwEiD/0DkSquQQxF?=
 =?us-ascii?Q?tAJxam6kLTTR5jHDIsCPSgj0kzCTD7aqn8/8ZELyOLNUWVlOeyLczMqHA3mK?=
 =?us-ascii?Q?PruyNnGhyLudEAxzMR7OIVuzBSf3LZm+pINIB2ohp08Q6gmO0yxva+0cE/6R?=
 =?us-ascii?Q?Rauwc3OEQmbvlOhCEf3yrfP4a23qxuVisJfprR4C7PodpwcTVfv2aQnBiOwR?=
 =?us-ascii?Q?aSv0zPXrPBIRhyV+DcPMUs7W9sRD0XupYS9aPd/N0nG3wKaR/SiRRFSMc7iu?=
 =?us-ascii?Q?eNwhq88N9Ds8DY9r2ujM0zSCWTbuSlj999q7en6gJxDQHb/g0FYwUb5Mt7b4?=
 =?us-ascii?Q?KoEoZuoZOc5d7qs9YHgFz5jmPdQZVxngAeExevpA8/emDFwsAa4fr9hJbLX9?=
 =?us-ascii?Q?zvx0uIl//+ly3smFEolAIBcIZOOxPEUNT1E1NDQ2WjGZbm5kexXhqAs0appx?=
 =?us-ascii?Q?jGJPpOvL4Eji71SMeYppl5stAoYqkSmmX99JRf8Z+mML+pAIMe6hYxlbxNnX?=
 =?us-ascii?Q?wjjyVTGzcpqlTG2dpjtQIHM2ifksfljQKfA+VdMQkTarkgeUX0n3J4obMxvO?=
 =?us-ascii?Q?dZVE+ewuleXVPUJoGb63V3bOOnYvxI1Ot9G17U3h1TfUbdIsUpjYW0nyWeO7?=
 =?us-ascii?Q?xcFsRpsOHFHwpVeaR1qmz0kmkGghdg4oeHV0kKva3/8nlYElU7VSdSvGov/V?=
 =?us-ascii?Q?09qY2UjqI1TpKdHomh8akl7tO6c5ypqdc7oJsjVKHSHRG1sQGXLmFrIChKnJ?=
 =?us-ascii?Q?bYjlDgTblkd77sCkUBTH+NRhmbMhhcV0DBkJWM9mo0TWpYYSGGIyx5rByldZ?=
 =?us-ascii?Q?PC7r4r70nEvC3Vc0zCZXkWLYhfnaoO5nNcKdG45D6IXCmmgHonXCPoM8cVAw?=
 =?us-ascii?Q?5XvtazCYncTSY2Pry1Cqsua+rBf2CgdiOstOM9WGovp9OyqXsBMyUSq8Ndrk?=
 =?us-ascii?Q?XSsmoZI74xDUCIzKYyzevXATj1oDKu5DBQrQGqbl5M/ANEN1KmXHzRZ7ASlV?=
 =?us-ascii?Q?z8KGA5UahTLjNz7sUjTouNAKLtbYu45BxyaXjuKxoxjjj4sURy7cY+9swdGi?=
 =?us-ascii?Q?DR7rfhuPSIPmLNk0xmyUwEDuz6vD14LbR83hbkwQ9MNlU2wBbKbDYpfTLC+t?=
 =?us-ascii?Q?fMWAamfaEozGiAtBh/1TXPjChEngScCnOODJ+hjBgq0zILTHynSBdM05A0i0?=
 =?us-ascii?Q?m21nK2UITyEXs681UVKR2x1wwBOuKMDvHhhXjGv1ydXTgmK6k+To1RgAagFJ?=
 =?us-ascii?Q?cTcLTpDeIt3M7DnEIm9jjltN22ewsBcICNP4ojtI4Pc6xgFgHvMX8IGzYcOV?=
 =?us-ascii?Q?22L1SX3MY/1QoVaXilw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514483C91159FFA26C0FDA91F755ABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f559bd-ae38-45f4-d093-08db6c11f35b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 13:27:35.5989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w3wI7wh8B+Evyjd2RQbgeIwSBG3S18OazTXxm+cMzcwXVm4ssr4dr2aafBScA+rdZ6P1sDKufc7UQRmQ8LXtLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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
Cc: "Ma, Le" <Le.Ma@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514483C91159FFA26C0FDA91F755ABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Sorry, replied to the wrong rev of the patch.  my AB applies to v2 as well.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, June 13, 2023 9:25 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Ma, Le <Le.Ma@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawkin=
g <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface


[Public]


[Public]

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, June 13, 2023 6:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface

Set compute partition mode interface in NBIO is no longer used. Remove
the only implementation from NBIO v7.9

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  2 --
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.h
index 095aecfb201e..8ab8ae01f87c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -99,8 +99,6 @@ struct amdgpu_nbio_funcs {
         int (*get_compute_partition_mode)(struct amdgpu_device *adev);
         u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
                                          u32 *supp_modes);
-       void (*set_compute_partition_mode)(struct amdgpu_device *adev,
-                                          enum amdgpu_gfx_partition mode);
 };

 struct amdgpu_nbio {
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c
index b033935d6749..cd1a02d30420 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -393,19 +393,6 @@ static int nbio_v7_9_get_compute_partition_mode(struct=
 amdgpu_device *adev)
         return px;
 }

-static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *ade=
v,
-                                       enum amdgpu_gfx_partition mode)
-{
-       u32 tmp;
-
-       /* SPX=3D0, DPX=3D1, TPX=3D2, QPX=3D3, CPX=3D4 */
-       tmp =3D RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATU=
S);
-       tmp =3D REG_SET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
-                           PARTITION_MODE, mode);
-
-       WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
-}
-
 static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev,
                                                u32 *supp_modes)
 {
@@ -461,7 +448,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {
         .ih_control =3D nbio_v7_9_ih_control,
         .remap_hdp_registers =3D nbio_v7_9_remap_hdp_registers,
         .get_compute_partition_mode =3D nbio_v7_9_get_compute_partition_mo=
de,
-       .set_compute_partition_mode =3D nbio_v7_9_set_compute_partition_mod=
e,
         .get_memory_partition_mode =3D nbio_v7_9_get_memory_partition_mode=
,
         .init_registers =3D nbio_v7_9_init_registers,
 };
--
2.25.1


--_000_BL1PR12MB514483C91159FFA26C0FDA91F755ABL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Sorry, replied to the wrong rev of the patch.&nbsp; my AB applies to v2 as =
well.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Deucher, Alexander &lt;Alexan=
der.Deucher@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 13, 2023 9:25 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Ma, Le &lt;Le.Ma@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com=
&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface</f=
ont>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#008000=
; margin:15pt; font-style:normal; font-weight:normal; text-decoration:none"=
>
[Public]<br>
</p>
<br>
<div>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#008000=
; margin:15pt; font-style:normal; font-weight:normal; text-decoration:none"=
>
[Public]<br>
</p>
<br>
<div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,Arial,Helvetic=
a,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Series is:</div>
<div class=3D"x_elementToProof" style=3D"font-family:Calibri,Arial,Helvetic=
a,sans-serif; font-size:12pt; color:rgb(0,0,0)">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Lazar, Lijo &lt;Lij=
o.Lazar@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 13, 2023 6:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Deucher, Alexander=
 &lt;Alexander.Deucher@amd.com&gt;; Kamal, Asad &lt;Asad.Kamal@amd.com&gt;;=
 Ma, Le &lt;Le.Ma@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu: Remove unused NBIO interface</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Set compute partition mode interface in NBIO is =
no longer used. Remove<br>
the only implementation from NBIO v7.9<br>
<br>
Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |&nbsp; 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c&nbsp;&nbsp; | 14 -------------=
-<br>
&nbsp;2 files changed, 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_nbio.h<br>
index 095aecfb201e..8ab8ae01f87c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h<br>
@@ -99,8 +99,6 @@ struct amdgpu_nbio_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_compute_partitio=
n_mode)(struct amdgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 (*get_memory_partition=
_mode)(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; u32 *supp_modes);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*set_compute_partition_mode)(st=
ruct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; enum amdgpu_gfx_partition mode);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amdgpu_nbio {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c<br>
index b033935d6749..cd1a02d30420 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c<br>
@@ -393,19 +393,6 @@ static int nbio_v7_9_get_compute_partition_mode(struct=
 amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return px;<br>
&nbsp;}<br>
&nbsp;<br>
-static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *ade=
v,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum amdgpu_gfx_partition mode)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SPX=3D0, DPX=3D1, TPX=3D2, QPX=3D3=
, CPX=3D4 */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(NBIO, 0, regBIF_=
BX_PF0_PARTITION_COMPUTE_STATUS);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, BIF_BX_PF0=
_PARTITION_COMPUTE_STATUS,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; PARTITION_MODE, mode);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_P=
ARTITION_COMPUTE_STATUS, tmp);<br>
-}<br>
-<br>
&nbsp;static u32 nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *supp_modes)<=
br>
&nbsp;{<br>
@@ -461,7 +448,6 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ih_control =3D nbio_v7_9_=
ih_control,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .remap_hdp_registers =3D n=
bio_v7_9_remap_hdp_registers,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_compute_partition_mod=
e =3D nbio_v7_9_get_compute_partition_mode,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_compute_partition_mode =3D nbio_=
v7_9_set_compute_partition_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_memory_partition_mode=
 =3D nbio_v7_9_get_memory_partition_mode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .init_registers =3D nbio_v=
7_9_init_registers,<br>
&nbsp;};<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB514483C91159FFA26C0FDA91F755ABL1PR12MB5144namp_--
