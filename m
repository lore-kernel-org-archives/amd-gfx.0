Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A31AC3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 13:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E3510E268;
	Thu,  3 Apr 2025 13:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UivAnbT+";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32F5610E268
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 13:14:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pp7TTnZXOsKKPSX3Fl4Al8wff9IcS8tgs0LU06NVNn1JMRf6tu2k3kqphQ77EN92xyTH6+wR/jtfYtLOhlVHq2Q85KYAOM/OCgRyWSW4CZqhWglW8A2s4FfTW60W7ucLcEu9vYWDENAkLdu+JL2Tk8I4oAi1C42iJ9WBhvNmL57G9L2/Yfxeecw9m00ZaxD7OUEEnWSGP2app16r3dyv18FKKgRX0cjQzzp+Dca6YV0mJHFxDPWd1PXuTipOQy1wzl4W/r6iMV2MHppXEyJKip2TAZKiWs/U8GpAdXdDN/HcTKBTjgDf1ELObwGIKVOxJ3WfFhUYPEhE8xK5B8a0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bj6bL10z/gDUBws7JzcXGYy8JqABDk+uj/V0TQKqHM=;
 b=bQtL6wAX3k8hyz8GH4gmCRu2UasAEPlDgoEI+Kmcih7ckSeedEB2iZ6O16wobqwamq5/kBje74GYIC60A77VYnUEdBivLge5MeOpcRC3il+0CsS+hoTFwXTfZXZ/NQ3gqEfZwPaC0NZduLaFwTKkCRXnsjmwciJMGyCuF4AAs78QznZgz3MTRHwFvXcaa2yCaoANfUqUgalT6ARKpdaXWYr98J66WAcfnS0ggmQ6NSi7A89clUU0VT8C3ZVS9avk1h6l+iLHOxWG3yQDXuOa3ZkP06pOeJtBhuydQYOYnN7ZWddnDxwewDsLbJFeaYeql/dKYDt58RQBwyvo/bG2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bj6bL10z/gDUBws7JzcXGYy8JqABDk+uj/V0TQKqHM=;
 b=UivAnbT+uSRvB2sOhJkxw0820nNehIwSupKz2orSprDFJOCi+O+rKobxxvWeBgM7m+Cfg5xWA9RNCOaBeRKKqOj8E8s4k++7neJRqVTA5QSacUFoGPKSFFQ/whRkf51OQQ69RNNQ/byXzM6ySXMQ4mGBVvWZspcX57RNEWgTlR8=
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 13:14:38 +0000
Received: from SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af]) by SJ1PR12MB6292.namprd12.prod.outlook.com
 ([fe80::745c:1e06:be67:94af%7]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 13:14:38 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhao, Victor"
 <Victor.Zhao@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Disable ACA on VFs
Thread-Topic: [PATCH] drm/amdgpu: Disable ACA on VFs
Thread-Index: AQHbpBzaDrCy1jUBRUSPNykZbM8lHLORQUoAgACpyZA=
Date: Thu, 3 Apr 2025 13:14:38 +0000
Message-ID: <SJ1PR12MB6292F548541A4E067F98E68E8BAE2@SJ1PR12MB6292.namprd12.prod.outlook.com>
References: <20250402221544.110496-1-victor.skvortsov@amd.com>
 <PH7PR12MB8796818F46DFEB1AF4C16976B0AE2@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796818F46DFEB1AF4C16976B0AE2@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=47b37be9-f6fb-4cd5-87a7-f90bbb69329f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-03T03:00:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6292:EE_|SJ1PR12MB6265:EE_
x-ms-office365-filtering-correlation-id: d6ed6208-1005-4fb2-aa4c-08dd72b17cb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jhTjc56nZukzalT341WjBFhM4/ndvjiDWsZISiSzyplSP9lWghXCNn1eWJip?=
 =?us-ascii?Q?sKglbNkRFdImEEqdIJXGbQ8QUFowWxRvnb5vMnGkQiDezBVx8kNDcVJciNFd?=
 =?us-ascii?Q?qAjYCtS0cZeu3NZKTbML3OkUf5JzszXN2j/zCcTmLSrz3/iA7qfeTu46tRSS?=
 =?us-ascii?Q?ssZgHufiBYRR5RKuZZb7BdW/YkJdHp4XDja5W6NS6PVItv7yfDmxBoR2ef/F?=
 =?us-ascii?Q?N9/J0LsoqmC0Lnc0Q5jDh33LCgAqw8HNIS8d5csWz+Fy6HWLbQf1uUPuNGZ6?=
 =?us-ascii?Q?g5+ni9NWMZVMqmfpIfJkihDiFCp8XaJwvyX1N8hnkKWUirGXJ4qy+HHpBSi/?=
 =?us-ascii?Q?eEZXqUu+aJrbJkGs1CLwnA6s7PJWCzczThoQ5iaAMFpeR7b2gs1qOJ3K4DDY?=
 =?us-ascii?Q?EQEVOGjLBDVnDG13gLBTbFaUu6+Irj6qQHYnvcFNxrRAJocLJGFYLVMYcUPz?=
 =?us-ascii?Q?zrskdZEjOsbUlAUaaKfEWZfxX5IrhWeWp4SN9ymVQLPOQaptLAoCjuEFFP8e?=
 =?us-ascii?Q?4jrC+aGhC4mcRMjnnAt6YAyxXPZUNu41WX4J42Bq3ZZLfDJRm0ynrzJW9GWB?=
 =?us-ascii?Q?DCEI2W5FZtMoZTKFvpuV53vmjgOHvNK+mFeiHBVqbS6dmzG/L32wrDeLHry3?=
 =?us-ascii?Q?vxa2g9Pt5tbfaFoJDMHRAE4cgMjMcRFRMroDQKB5zxdcmILSR4jSEo93mTsc?=
 =?us-ascii?Q?rwaX/1nQ8FW5Iasb9udvse+Ue0UvcXqAQi+Pa+/IPzelrVNi4e+3Jlh5kcjg?=
 =?us-ascii?Q?OO8WLAN9tzNwJ6CxEFCyWdekLYyRxVbbSHtvnZ4kf8m2b4EztEBNJTYjGVmx?=
 =?us-ascii?Q?NYNN7wbQNQgXqT+3qoa4S3bwBtS7+9ZZlFHKa6viBPmy/F0ezWwt9w/Rv0lQ?=
 =?us-ascii?Q?/CunLiD8bCDMvFvi8eElXUkCg0UXOujcYM9Vr3VQUBllv8t+VBObOawlU/WS?=
 =?us-ascii?Q?7XVq3tOPO67WNcETi13p4KJNhBy3TspBFcplT7hekS0mJJ0njIo3DtUOrRFf?=
 =?us-ascii?Q?iS3Hoa4vZk5Y9DK3RWSvoWLKZelcbCM6SLVA6iRzVwpiIcKK36eH9Q+W2VXu?=
 =?us-ascii?Q?UHpVN14yJKyqEwIxI/zucI4N/K/STrkGuzitJz0n1YDoR1t+FrNCNC68l5LM?=
 =?us-ascii?Q?8UnEGfh/1o1x7wISkEc2h+pJDKlFac0kR5qr74iV/rv5VVy0Oio6exj/0GTY?=
 =?us-ascii?Q?nh7U6GViKwLbsmy3OJXE2/AaFKkKqtTYu4zSCVFVBOqsKUVOJHJi8JoWNqay?=
 =?us-ascii?Q?Nse7y6c229jghBx3la4NU2eeVVHsesc8Q/P3Rrg/MMRmC9kllLGfw7+yQ0w/?=
 =?us-ascii?Q?bKuvZtehA1VclDyg0ajGr5+eOgLIaq0fA51mujWnQTSAmygF87Y6Kaa0302L?=
 =?us-ascii?Q?oGvXafwONyD1bdtdzW3qkWM0bWkx4K9wL70/qt4R+MdDHtpgm0vNbyik9Kw1?=
 =?us-ascii?Q?sdbhJgA1cJrYa25RUPdQGpRk53HfXdid?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6292.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ult93GZwA2l7lRAXqdaBzbziONhdVM2lIe/fDmDxxoii9p99rlEtP/6AO4fC?=
 =?us-ascii?Q?dAKN+V0wDq8UESU6lVffTCS9gBg998RHYl0LLue43XvPnKod55J2vZP34gaY?=
 =?us-ascii?Q?h5Si+2w0kr9Qe8SuXir3nk4HqXELc6gerhuhfoZRYp/QFC7qTZalqD954f2Y?=
 =?us-ascii?Q?7XoDPH10aOWI0YbmMaULRtJozQVCv1Eb22egu4Bz4SaC+iuE8lU/NoLHmNqb?=
 =?us-ascii?Q?LaGsvSwDsaO3dBR0Hvv2bEP9HMb3dDaErtv7VQnAPPy2597IBBKZzrVYq05u?=
 =?us-ascii?Q?tKQLpZevtmnpp3s3kfIwwG5SvArA5wYOxrQnxWc7HesRr5fOHR0qI8SazDts?=
 =?us-ascii?Q?ONilH6dQ186qx3xaP9yxLo0BcoMI4HYqIlfnyN2QCfMvuqPWcvSM/S8K3SAg?=
 =?us-ascii?Q?WZBXhWGVbToCU37djM+PYyVKQH05pX+LlvFxJsKCbeXOqif6/mQasxC71RS2?=
 =?us-ascii?Q?70fTdmnmKBWYq8KxVyJi8iqltsVNO0/mw5UwMsYurPm6mbuYcu8FJoVF1ukm?=
 =?us-ascii?Q?TqOotkozAyqkKw9lBQNujSCT6qQJLqHuq22/boD9tqpsm60NJALhck3+pT/R?=
 =?us-ascii?Q?E+/kSabacEUNrQ6VOc6C2reaxqy9ZePw4Xpcc3pRLhRri0WQdWm4AJwQlEf6?=
 =?us-ascii?Q?JEq4Z/8OQ3Gj3CyKjn1zs1LhLnrgBP9mh47Bw8sxUZ8f38OCPcFYAspQzRAA?=
 =?us-ascii?Q?o+pKL+luEiiBe0G+7GD9FQGG12SiuvsPtlz+HmHzpW6SW3iMC68E/Gd0P0S2?=
 =?us-ascii?Q?o1dd4zrpu3LCFenW/Obnkim1fL4y0FKcLnt9yTNxR0Cm8bl9n2qbtUL3JVDu?=
 =?us-ascii?Q?gx315kK/LCB0/14dJs6PF6kmoWenD/vX05RE6l3RiMjfDMCENbswByAe/VWI?=
 =?us-ascii?Q?FwJ+of6JHg+0ZnSZ1wC1Ou3hgNC8Y0wx/rHiy86oCZW/aJyJ9Nj2NwOVt4TM?=
 =?us-ascii?Q?/xpwKbxAs81xyGZj0dCMVVNZOnfqBdYymcDyQLUlfaCGEdlOCP1g3bn+ujIY?=
 =?us-ascii?Q?/rn0BqbjfXFHbov/67P2A9vSYfZf+Dr4VIB56wFRGOg5wSYs0hExZ4RH3MSx?=
 =?us-ascii?Q?s+ihGBYslxIw+ofpu8W+3mNwklBaJPp+pD3sDbU6siJCfHGn+k+fU500zkAA?=
 =?us-ascii?Q?QHrTv0rv+OjXjbx7jrfIbSgikuxZ5T/ErVSXpNba5ngeM4UT9Gyf/B7mlSF8?=
 =?us-ascii?Q?OMnKTeB93AFPvHCwdthNBdWdtCt8LSjdlphF/Lp97cXK0k+5aireJiBVKL8n?=
 =?us-ascii?Q?vIQzoC+VE5+XBUeoRhgoG1+od4t5/FjK6djKL7jENGsOrZr0HrRkW5w5lPN/?=
 =?us-ascii?Q?wBLwbQ5f+zvT2sKHZXfyGULLTrGJgXuVeJnvPRWkywTLvA2LntTHygXfmjYG?=
 =?us-ascii?Q?ZYd8/1LsIphNCQppcdxxXuJddVStrYVT4KP+QaElpUcwgECBHrzscUTeeYf6?=
 =?us-ascii?Q?YcNnd0GzyPf/kbU5kqgdF7uxaCwIUyGlXqOLfPwYKyeqLpPuSo0NaIRIJAK9?=
 =?us-ascii?Q?bI4c3/HIxgOOb3C7HZMiX7O/mh65uwO4YeYBmlUguP7e3ytV6tzcZMUYTePn?=
 =?us-ascii?Q?Q2zCUbh327DsX34WF5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6292.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ed6208-1005-4fb2-aa4c-08dd72b17cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 13:14:38.3117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qsaPEepNeil/QzYAzAyQO7798IbD9D9P14g0sOiF4iXcrDI+UuD7HOlSfK2OcGK/OQvEMbLNWuGCVfw3CMGCnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, April 2, 2025 11:02 PM
> To: Skvortsov, Victor <Victor.Skvortsov@amd.com>; amd-gfx@lists.freedeskt=
op.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhao, Victor
> <Victor.Zhao@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Disable ACA on VFs
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
> > Sent: Thursday, April 3, 2025 6:16 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhao, Victor
> > <Victor.Zhao@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Skvortsov,
> > Victor <Victor.Skvortsov@amd.com>
> > Subject: [PATCH] drm/amdgpu: Disable ACA on VFs
> >
> > VFs query RAS error counts directly from host with
> > AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY. When ACA is enabled, an
> unusable
> > aca_sysfs is created rather than amdgpu_ras_sysfs_create()
> >
> > Likewise, VFs depend on host support to query CPERs, rather than ACA
> component.
> >
> > Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c |  4 ++--
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 10 ++++++----
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> > index 360e07a5c7c1..5a234eadae8b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> > @@ -549,7 +549,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)  {
> >       int r;
> >
> > -     if (!amdgpu_aca_is_enabled(adev))
> > +     if (!amdgpu_aca_is_enabled(adev) &&
> > + !amdgpu_sriov_ras_cper_en(adev))
>
> [Tao] can we put amdgpu_sriov_ras_cper_en into amdgpu_aca_is_enabled?

[Victor] This will cause problems inside amdgpu_ras_sysfs_create() since VF=
s use the legacy sysfs to report IP block error counts through AMDGPU_RAS_V=
IRT_ERROR_COUNT_QUERY.

>
> >               return 0;
> >
> >       r =3D amdgpu_cper_ring_init(adev); @@ -568,7 +568,7 @@ int
> > amdgpu_cper_init(struct amdgpu_device *adev)
> >
> >  int amdgpu_cper_fini(struct amdgpu_device *adev)  {
> > -     if (!amdgpu_aca_is_enabled(adev))
> > +     if (!amdgpu_aca_is_enabled(adev) &&
> > + !amdgpu_sriov_ras_cper_en(adev))
> >               return 0;
> >
> >       adev->cper.enabled =3D false;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > index ebf1f63d0442..5bb7673fd28e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > @@ -3794,10 +3794,12 @@ static void amdgpu_ras_check_supported(struct
> > amdgpu_device *adev)
> >               adev->ras_hw_enabled & amdgpu_ras_mask;
> >
> >       /* aca is disabled by default except for psp v13_0_6/v13_0_12/v13=
_0_14 */
> > -     adev->aca.is_enabled =3D
> > -             (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(1=
3, 0, 6)
> > ||
> > -              amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(1=
3, 0, 12)
> > ||
> > -              amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(1=
3, 0,
> > 14));
> > +     if (!amdgpu_sriov_vf(adev)) {
> > +             adev->aca.is_enabled =3D
> > +                     (amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
> > IP_VERSION(13, 0, 6) ||
> > +                     amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
> > IP_VERSION(13, 0, 12) ||
> > +                     amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D
> > IP_VERSION(13, 0, 14));
> > +     }
> >
> >       /* bad page feature is not applicable to specific app platform */
> >       if (adev->gmc.is_app_apu &&
> > --
> > 2.34.1
>

