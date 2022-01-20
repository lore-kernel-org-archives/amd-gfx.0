Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C62DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 09:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D924B10E660;
	Thu, 20 Jan 2022 09:07:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D61410E895
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:07:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDeyPmxj7laOB1LbWWUi1+uU/03hu3rec/oAT/AZU8c/oHgBERYzIWZf5FXPiFkrDKj19rWA8SZyaPo8TYtlpWv9KE7gvXHXno80HaSXTDrOjQm1hPdn6NtkdRZyHbhgX8PYyltPEzfXnHjXunAoWVsx9+md5doi42uhYqFF20wJS8h692Euh3dMVjqmovxPFY0tYIBJ4dteNcfJ4JAkamBuyfr2vcEiZDUmYLatffbsezfJqLfNsTm/6c7wVLaqIzZtFDuH+uo7KrW2JQsw3pDQuELS2FOyC+ox3qg6OPdM730R6hWuTRNS6+j0xNd5WrDhRThsPN3VPww5IFpbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d6nsLZaiHgycGzNLKi0FgK5SWTdoIMyUb9BmHdBzkc=;
 b=Zh4lUvKCC85iouJBQ7wA6YPJg2dBGCHVUnnakl6m2QgiOZG5nSeeGPt+0VyZou/es79i2DMbrYAKG5Kr0PIbkSX/Hed2JHwQ3qW7l6/CpXW4cRCRjP5e1eQKXvMSTov+zt7YY8/NuWDKvHmI/7pq3j7FeHekk8hSOK7dex5OVG6yVngYTu8TeQ4LXlYqP37nOgwYEuqnW113UXIV2AwlJDU929K2exDEBewUdyOJKsqVNdaXl6RyPhZHLmWb//HMU64Lfv0yoArQWVpqU24PGRdqOOY0ueUHDR7YiJzADsukjYfTkUUziUp51H7QvyHIrOwSCwhUauhTV/d+qT+xoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d6nsLZaiHgycGzNLKi0FgK5SWTdoIMyUb9BmHdBzkc=;
 b=WmY5W7NGKmoWHn35fyU38UGexZ5c18BOSUtKeKT6mRRtRV2SsJTW1sbhx7fMyC+NRjQuvsINAwh1b7T/cZk+vY/UPDMmUbRUvMo1e/V+FE6HKvBJk6RV2bx+LOIXAT8TUZ7+Fr8xIP7tueeB5pMFntsZop0F5Ox00qZ3k4he1es=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 09:07:22 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::b49d:d2e4:875b:e881%5]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 09:07:22 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: force using sdma to update vm page table when
 mmio is blocked
Thread-Topic: [PATCH] drm/amdgpu: force using sdma to update vm page table
 when mmio is blocked
Thread-Index: AQHYDOLz9NJJp1Ao/ket4CY+uhKskaxrmDUXgAAF6ICAAACajg==
Date: Thu, 20 Jan 2022 09:07:22 +0000
Message-ID: <CO6PR12MB54735F709AACC151C3B66900825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220119031610.832211-1-KevinYang.Wang@amd.com>
 <CO6PR12MB54731E9FBF54A2E86A320419825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
 <95be3a20-ac92-9acd-9600-3caf9223c67a@amd.com>
In-Reply-To: <95be3a20-ac92-9acd-9600-3caf9223c67a@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T09:07:21.790Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8cede66-5fc9-4522-8443-08d9dbf4451a
x-ms-traffictypediagnostic: CO6PR12MB5441:EE_
x-microsoft-antispam-prvs: <CO6PR12MB54417FC2D501A9AAFC732BEC825A9@CO6PR12MB5441.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wfeHfexTa2AbcW8yN4jiVFyKM/4Fm5Nw6UHiNNB+KYL52JAMBCDiQYuomdyrutvo83Lzg5tjiwaHrCICe2Xu1ImoTGBCBsPOcYaIxeIM1DTbzp6hmF+Pc+8fJ2Z1+5HxF0YNRmPVLqM8mhV3acJev2VoSMR5Wx4yaUCdl2iy/eHojrp4732gPUDd702E/C2piVZ0HyMpAk9+tByzifuyP+AqCTwQDJzqZIApJeynaDC3GrA9XqNPGP1gXgK1eIc6rfinkxYErVoK+x/hoRMglc+I8PlCTfLsPpvE6kmIS8xFzIPUYXYbAxhO3zAPnqbk1zGFx4xp1vYIJDUtRTaka/kuT0j4VfujAmXp9t4erFmbuTXTas7/rAYJ9Ynu7j6gMnkyVsJ99ZPz8rAQCsEyYpH87QTt5jAfY/VnH597vYXATEYhi3GSxPzePhMfdMc6ttCrBXxFqUZgjZFkf+oP0pAiBmarsFwCqd18n+cnYJe3IwfuOf0M9IgFdI7YVr1gYJKabo46pQdhzA2detSrV8CwjG79wSr6eFEoSXIlEBYsNUDH1o1ul2APW18mM8ypDxsOShvGEHjkNCYIzuXPavrkOlU2chG+SiRqXB0RAmtWgz5t4y7rmeAQNcCNo43m0H7gaih3TgVlislHhoM2L71IoD1l+cgFAUcnxWcohTtsxAdX/qqhxVK3IIaiAK35ZTK4tzphKC1xue3Kl8mtTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(5660300002)(110136005)(316002)(33656002)(508600001)(83380400001)(71200400001)(4326008)(8936002)(7696005)(53546011)(6506007)(15650500001)(26005)(186003)(6636002)(64756008)(8676002)(55016003)(9686003)(19627405001)(52536014)(122000001)(66946007)(86362001)(38100700002)(66476007)(76116006)(66556008)(2906002)(66446008)(91956017)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rHpJRDADGSJ0rHwsX82LJzQYX/m6HcdvZfG4IZfVZTZC4K9HTdxDdrXhYA?=
 =?iso-8859-1?Q?HFsyIdKzY4sNW3Ll1yFhEK14tLAMd1hj8FjYYV0NboMH4MO6wONmB7E7jM?=
 =?iso-8859-1?Q?eCSkR1nBS3HlpTGijFFO0f97ZyyIzabKqsMYfHMxgxaC87nvjghgBVh2yr?=
 =?iso-8859-1?Q?nCmAyJI1zumhlOCFRsymO1MvF6wWCCil22CO6aLbmMgz4hiPUmdskmLj60?=
 =?iso-8859-1?Q?Q6lTKou9SMl+UIJZP39njdOlZ2ls4eX+pL7dvChD1dVA7UJjaw8YfKUldE?=
 =?iso-8859-1?Q?Fb58iKoU0ddCtjiOVtqht9PKQASVhvFkigP48k9oYCH66T8XFfxYZF/5aV?=
 =?iso-8859-1?Q?pZ3NB5JQ293zN0ishGciHNHeOYX+tidQhmKKGpS5/i+E7HWXWqdzYI3r0T?=
 =?iso-8859-1?Q?W6P1msKgvXDmB3OZBLDGm+KLZL1b0kBvRSYB2N3F6WluOcUBQUcIhm4mI6?=
 =?iso-8859-1?Q?aDQQmIZK45vSZs5iprDyFwPa3uDbczSWiDLgtjcJgv2RwNs2GBWRqWFdlG?=
 =?iso-8859-1?Q?mO6ModOalPSyyX/z/k1GE0VvZFdZfNcNBzn1IlzqCqvkcF0aW8NOXJh+26?=
 =?iso-8859-1?Q?PIZzsoXI8uyQSzBCRpVrMYJZO4VRj1xOHdIKxZHzg5jTvZApFR65cTkDM7?=
 =?iso-8859-1?Q?uAPzX8jxrXmr2jJYFwiQCvbZ2t/KachxPa71MQucggCQezfoQGXQwlAraO?=
 =?iso-8859-1?Q?v5x4zo/5MC/hLM3+lkzzXciEajuo1f0lu6Vvy06yv+//6EV1K/1JbQLogS?=
 =?iso-8859-1?Q?mhD6/N/hBkAtr6/n09Fj6xPi1wWQc3I/6XVIzgg0lMg6QMJU7wPzQoGgD4?=
 =?iso-8859-1?Q?+VB+UDo3ggcv8cHz73Mpapl87RBy1QEZKrGCVMa1MNuNXSpJLTw1RQAEiA?=
 =?iso-8859-1?Q?PXGo50S9Ixy5Vi9vZyJsYHwhPDSSfPkHZ9TmWPTvSA3d5M1AKxobt7M3xk?=
 =?iso-8859-1?Q?wxPyAhIHYkQy4eFDaQ6zcuesOQWxM5yA4AkrN+/Tufd2NL0KLtv83NdJqA?=
 =?iso-8859-1?Q?9UbKBTH9E/Ep22KJzWoqPXpgk3+Ax8bR4lwA9BQdvB/SajJMwyMDMlGeGT?=
 =?iso-8859-1?Q?9v17FizNED5U4mAWuvBepW+86mLgEis9/K0bvndRcekPP169AKrAHn3PxX?=
 =?iso-8859-1?Q?8KAneKR8O52I4Xpgj8TuXDgTRq9auz1bKvVgJWYZNI2/3ON2pd0nrkAj8m?=
 =?iso-8859-1?Q?ZpLaq9O2hYO5JlhOJO0ESUHQnU0F0D3SMdBISjuOM3q7ECC4b+Nn4kKVoh?=
 =?iso-8859-1?Q?+p83bGQjWIHjX+Cl5WFk4U+fXOvYAPfsigt2L2KI1dbIgSf8GCeufZiKUw?=
 =?iso-8859-1?Q?ZPZ/zb3sTqmXnQYczxArs2oN+PkhA8C/e+8ZzKg5PiczhRRldXi5KMsh+f?=
 =?iso-8859-1?Q?KOwTI9kEtsSGM52NV2DhCCgGu1Ql7s23yTYZ1//HzqkymIp50A5PtwoAtt?=
 =?iso-8859-1?Q?CGsHpbkd19kbUpy9Yj3vedBMy65mDeywhfRN1VaL8x9EBI0CmKaOOwD9K2?=
 =?iso-8859-1?Q?x3fpNzWsySWcLElOcXwC2ie9O4CtY47+kiEvctuFniTWxWjNUjAqELDyQE?=
 =?iso-8859-1?Q?AaGJfl6cpzyisH5rm5WTR4vSxOPVc6F86G14+Nlz3DQWvMkk4mRtn5cU7d?=
 =?iso-8859-1?Q?/jQv/gugK4/SE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB54735F709AACC151C3B66900825A9CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cede66-5fc9-4522-8443-08d9dbf4451a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 09:07:22.5473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3ChJEEFyrNoBMxwPaFBjq9O5QG21O0IH98ax5EDWHGg1bxWq1IjRJlX4oa3Hein
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Min, Frank" <Frank.Min@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CO6PR12MB54735F709AACC151C3B66900825A9CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Chris,

yes, I agree with your point.
and another way is that we can use KIQ to write HDP register to resolve HDP=
 can't R/W issue.
but it will cause some performance drop if use KIQ to programing register.

what is your ideas?

Best Regards,
Kevin
________________________________
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Thursday, January 20, 2022 4:58 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Liu, Monk <Monk.Liu@amd.com>
Cc: Min, Frank <Frank.Min@amd.com>; Chen, Horace <Horace.Chen@amd.com>
Subject: Re: [PATCH] drm/amdgpu: force using sdma to update vm page table w=
hen mmio is blocked

Well NAK.

Even when we can't R/W HDP registers we need a way to invalidate the HDP or=
 quite a bunch of functions won't work correctly.

Blocking CPU base page table updates only works around the symptoms, but do=
esn't really solve anything.

Regards,
Christian.

Am 20.01.22 um 09:46 schrieb Wang, Yang(Kevin):

[AMD Official Use Only]

ping...

add @Liu, Monk<mailto:Monk.Liu@amd.com> @Koenig, Christian<mailto:Christian=
.Koenig@amd.com> @Deucher, Alexander<mailto:Alexander.Deucher@amd.com>

Best Regards,
Kevin
________________________________
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com><mailto:KevinYang.Wang@amd.=
com>
Sent: Wednesday, January 19, 2022 11:16 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Cc: Min, Frank <Frank.Min@amd.com><mailto:Frank.Min@amd.com>; Chen, Horace =
<Horace.Chen@amd.com><mailto:Horace.Chen@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com><mailto:KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: force using sdma to update vm page table when =
mmio is blocked

when mmio protection feature is enabled in hypervisor,
it will cause guest OS can't R/W HDP regiters,
and using cpu to update page table is not working well.

force using sdma to update page table when mmio is blocked.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com><mailto:KevinYang.Wang@amd=
.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index b23cb463b106..0f86f0b2e183 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm)
         vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
                                     AMDGPU_VM_USE_CPU_FOR_GFX);

+       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && amdgpu_virt_=
mmio_blocked(adev))
+               vm->use_cpu_for_update =3D false;
+
         DRM_DEBUG_DRIVER("VM update mode is %s\n",
                          vm->use_cpu_for_update ? "CPU" : "SDMA");
         WARN_ONCE((vm->use_cpu_for_update &&
@@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm)
         /* Update VM state */
         vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode &
                                     AMDGPU_VM_USE_CPU_FOR_COMPUTE);
+
+       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && amdgpu_virt_=
mmio_blocked(adev))
+               vm->use_cpu_for_update =3D false;
+
         DRM_DEBUG_DRIVER("VM update mode is %s\n",
                          vm->use_cpu_for_update ? "CPU" : "SDMA");
         WARN_ONCE((vm->use_cpu_for_update &&
--
2.25.1



--_000_CO6PR12MB54735F709AACC151C3B66900825A9CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Chris,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
yes, I agree with your point.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">and another way is that we can use KIQ to wr=
ite HDP register to resolve HDP can't R/W issue.</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">but it will cause some performance drop if u=
se KIQ to programing register.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
what is your ideas?</div>
<span></span>
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
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 20, 2022 4:58 PM<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;<br>
<b>Cc:</b> Min, Frank &lt;Frank.Min@amd.com&gt;; Chen, Horace &lt;Horace.Ch=
en@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: force using sdma to update vm page =
table when mmio is blocked</font>
<div>&nbsp;</div>
</div>
<div>Well NAK.<br>
<br>
Even when we can't R/W HDP registers we need a way to invalidate the HDP or=
 quite a bunch of functions won't work correctly.<br>
<br>
Blocking CPU base page table updates only works around the symptoms, but do=
esn't really solve anything.<br>
<br>
Regards,<br>
Christian.<br>
<br>
<div class=3D"x_moz-cite-prefix">Am 20.01.22 um 09:46 schrieb Wang, Yang(Ke=
vin):<br>
</div>
<blockquote type=3D"cite">
<p align=3D"Left" style=3D"margin-top: 0px; margin-bottom: 0px;font-family:=
Arial; font-size:10pt; color:#0000FF; margin:5pt">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
ping...</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
add <a id=3D"OWAAM160069" class=3D"x_P8b7u5KH31KY6Eljcf5yw x_mention x_ms-b=
gc-nlr x_ms-fcl-b" href=3D"mailto:Monk.Liu@amd.com">
@Liu, Monk</a>&nbsp;<a id=3D"OWAAM254265" class=3D"x_P8b7u5KH31KY6Eljcf5yw =
x_mention x_ms-bgc-nlr x_ms-fcl-b" href=3D"mailto:Christian.Koenig@amd.com"=
>@Koenig, Christian</a>&nbsp;<a id=3D"OWAAM277931" class=3D"x_P8b7u5KH31KY6=
Eljcf5yw x_mention x_ms-bgc-nlr x_ms-fcl-b" href=3D"mailto:Alexander.Deuche=
r@amd.com">@Deucher,
 Alexander</a></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Best Regards,</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wang, Yang(Kevin)
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:KevinYang.Wang@amd.com"=
>&lt;KevinYang.Wang@amd.com&gt;</a><br>
<b>Sent:</b> Wednesday, January 19, 2022 11:16 AM<br>
<b>To:</b> <a class=3D"x_moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@l=
ists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Cc:</b> Min, Frank <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:F=
rank.Min@amd.com">
&lt;Frank.Min@amd.com&gt;</a>; Chen, Horace <a class=3D"x_moz-txt-link-rfc2=
396E" href=3D"mailto:Horace.Chen@amd.com">
&lt;Horace.Chen@amd.com&gt;</a>; Wang, Yang(Kevin) <a class=3D"x_moz-txt-li=
nk-rfc2396E" href=3D"mailto:KevinYang.Wang@amd.com">
&lt;KevinYang.Wang@amd.com&gt;</a><br>
<b>Subject:</b> [PATCH] drm/amdgpu: force using sdma to update vm page tabl=
e when mmio is blocked</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">when mmio protection feature is enabled in hyper=
visor,<br>
it will cause guest OS can't R/W HDP regiters,<br>
and using cpu to update page table is not working well.<br>
<br>
force using sdma to update page table when mmio is blocked.<br>
<br>
Signed-off-by: Yang Wang <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailt=
o:KevinYang.Wang@amd.com">
&lt;KevinYang.Wang@amd.com&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++<br>
&nbsp;1 file changed, 7 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index b23cb463b106..0f86f0b2e183 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct=
 amdgpu_vm *vm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
=3D !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_V=
M_USE_CPU_FOR_GFX);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&a=
mp; amdgpu_sriov_vf(adev) &amp;&amp; amdgpu_virt_mmio_blocked(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vm-&gt;use_cpu_for_update =3D false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM =
update mode is %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 vm-&gt;use_cpu_for_update ? &quot;CPU&quot; : &quot;SDMA&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_=
for_update &amp;&amp;<br>
@@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update VM state */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
=3D !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_V=
M_USE_CPU_FOR_COMPUTE);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&a=
mp; amdgpu_sriov_vf(adev) &amp;&amp; amdgpu_virt_mmio_blocked(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vm-&gt;use_cpu_for_update =3D false;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM =
update mode is %s\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 vm-&gt;use_cpu_for_update ? &quot;CPU&quot; : &quot;SDMA&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_=
for_update &amp;&amp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_CO6PR12MB54735F709AACC151C3B66900825A9CO6PR12MB5473namp_--
