Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8A6606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xp9ThsPo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A9C210F944;
	Wed, 28 Oct 2026 02:18:05 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECD210F94F
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 02:17:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEgEGUPCVp0jNkxYmqdTLHxTsVJJY7+4v0A9gqLuJ0cHamDDpwNlc29Gm8XbHRcb8gJ97uhy66RTkmDVJMA7GVskkWrbcLgAtJRZDRzue2MqPzPlzWQlV5C5fC0C07kkjtT4G4EUpy66eOZ6VNTlNteWsJi/xdue/pjDOCC9Gg/S7vqh1xxXT9x5E1d+BoK1huRdd/aGX/IssxCjoMXR9yglb6rv7KidI6u2Oa957XtSHGV9EtEodyt3KdXU/S6W0Nyt+taLgb/Ef2OoUyAeI5JWPprzuJRgjmPRtn0yUj0EXdkNzu5/Nw22f1nC58RVqriCGfev9/lB3pQCyRlE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut+MGepQjiW1cZir17xqoxZNNmXDDd4IyPDlciQ8q+0=;
 b=M/1Emm2H/2MbdasYjMx23qfoaO70YZlEwjTpvx7TyivfipcGIpUXawRuZa/EWVfwFwOjvgGhROKcsDJv8HEljVnA6wU1PPJUG1Y6FiK/Dc2Fk5DcTXhmNNVtxoZOToLOD180QtQSm5wWUezodCTUes5TWOSdPCu9lbqpU02EPWAd2/FGGftqfqbT+5GNBANTPY+yFJsG2kkQDQFcETz9YE2SXRghb0i6ezoemwRcZ4KzxJSLCSbW3T2TP6422c1dhiknKPHzLf7AMhPSuq7rbbtzKYWGO6KkM/IDxyk8b1z3jdCKWRgbb1yd7Q0wkpwIvCADsK6NS4TxGr5BpSKQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut+MGepQjiW1cZir17xqoxZNNmXDDd4IyPDlciQ8q+0=;
 b=xp9ThsPonRDFIMdhwX0MpsPTSE6uJircyRtEx/rU6PF7KKfTOX1yIP/Lo8apwqAulvrhwTWe51d4RctG2VBm3SX1X30hmwHTd+Q81q8lp7mklCyhfnAQiXTw/8IHTIDTv30yCcF9CbxYqlOmrd6R4hGvOcdmfd60NS1NBJFGtPk=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 02:17:55 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 02:17:54 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 1/8] drm/amdgpu: save VKMS modeset state from the system
 PM path only
Thread-Topic: [PATCH 1/8] drm/amdgpu: save VKMS modeset state from the system
 PM path only
Thread-Index: AQHdYslY4oWsTTGxN06xVKpQj4wRt7cSPgvw
Date: Wed, 28 Oct 2026 02:17:54 +0000
Message-ID: <PH7PR12MB60006BC07B279A62753C9F4EFB6F2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
In-Reply-To: <20261023083422.3049246-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-28T02:12:39.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|BY5PR12MB4321:EE_
x-ms-office365-filtering-correlation-id: 4b3b618f-0c7d-40c3-4d43-08df3499ad0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|261022075727099003|261009223027099003|261021123027099003|261021121427099003|10067099003|261022105027099003|56012099006|261026140227099003|22082099003|18002099003|261026121527099003|11063799006|38070700021;
x-microsoft-antispam-message-info: C87JDQfn0ytSlzyAJy3q0NAi6YRXS+EfJNl+/5Z6s3c/dpRPNEvjyd2pv+zVVmwIiO9QcrXDCuVU+255WKTB/e+h5au/Wml3naO6y6DnpowYbJXHtmVrhriajQp9If7Rb9grKRDCPiUQxHg+M3t9Z8VYRBkeh19P/SWEZ5JP6ruUNC8MxHCNucjydEFlJ6D2g1CmFKvx1mTvF0/fEivaEAowQJQ5NIUhBZvUtJqHWxjeidL47RiHsXOlag/lyk3LpX5zO8Qo9tC6wm3DFLm5WSAbNH+KZkO9veyajBS8leO2s3/e1Dns+LsmIkX0FOTKfMWWASIBCkEJGRN97AOJyrUVqfYhqpceWJoUJ715adGKp4lM+kl1gge2XWg2ab/P+GOAjh0ESalPolXkotz2a1cbhAxMwQFLnIQG2cezzVUNvspm8n/KOSQBKNeXzi/C69nRPKBog+DCQo5wN5oo1MUFxAF1mQ5c2cPEcNge8eJbrPFXzWdVpn/ya0LsDLoeT/Hg9dr1MOf+n8vKppqDE1A5xODSsqNYXLZQcGkY4jFHsU3CpoRCRokHJYamCRiGBuy7L03iuYYfmPFn60H8453aukit08Dvi9SeB0Urc25hLfLvRVALksQM3aOFWrn1oD22jiBKXOo7rKeSZTOivt45lWLMq/kILifvmdIMJ0utR4CuPOY7YA5CP7cvxDZh5Z++kjBy73g2AVWK09biRvlekAoHIQxQi8OqdMm7HoE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(261022075727099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(261022105027099003)(56012099006)(261026140227099003)(22082099003)(18002099003)(261026121527099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wQ4La06PIIDpNR0hdxRw5WTOlRbto4sEnH0iaM1ui38ZlTBLjn1XUH0F7s8w?=
 =?us-ascii?Q?jlwsHhT7XivOrhbLh5yZ0GZkm+Dq8MG+86VDksdK9oFN/w5eGwZVfuZKchhV?=
 =?us-ascii?Q?OP1hCe5cH2iAGrKj2vgDsyqZ0UV5rdjkB3GXYC02QSaNczsKLljQmfA28Ya5?=
 =?us-ascii?Q?JDOs4rLmdMr1GWXU4MlwYIktetD6twAh4YgbvEyzHE9jCZrmY0QlybeyqA4C?=
 =?us-ascii?Q?86yHalBt4o0qjW5Pa55ZXPHhBkrahxtIAgCKx7FfChrfl/QWFb60PhuWWSTs?=
 =?us-ascii?Q?KhGzDjjxXX5tfqZJdMATXFAzDfxzFpqOOmynlbfEiR3w2q7U9UEO+1XOe0+b?=
 =?us-ascii?Q?6Pi0nPLHxwJFdj99KXw4lgEjwaIkD29LJfxJ2+2AaGnnybw4sKLEh/N8e3zv?=
 =?us-ascii?Q?Nkdb9aXvrXefFfK+IBxx1QLvnbO5MXE6uxgSBTxRt5VPqyaJAj+nerpJRGZq?=
 =?us-ascii?Q?jmMlzHJ5EF6xbefrzXY4D+n5FcFsnOH8lWRMxNj5Kz2Ix9ht6mU0X7oZ0s5O?=
 =?us-ascii?Q?Mogpe+nw4cCf2O10vYgtQFuK8OSa7cET7Wj8SHgtL9GPa+QSCo0fOgD1AXan?=
 =?us-ascii?Q?f8yNS1Pe0iHO25pbZGr4tkUAo8zwvx1plnimrj5wy9vJwZewfHSiVZanw5/9?=
 =?us-ascii?Q?AiJ5Xt/uGnwvbDBo34efcyWvC6ufC+KQZAlGE5TqbIXIRTG6f3CPZpVPZbqc?=
 =?us-ascii?Q?c3QsVqc35gvofmuDCkV9kuEUcLe2fwMSuREuJBhn80oZH+YXFhseDU/9O/P+?=
 =?us-ascii?Q?17nLhFD3WwWvavob65ddi13QSgmCujn6Wee6qOfKUp0nJNa+Ce6wRGVvUV5m?=
 =?us-ascii?Q?BsMReuDxX45RTfG7qXW4TMqqTBXt14EeryJ7Q+Roik97/sJIZPuZ13xvDhGb?=
 =?us-ascii?Q?ngCIGL4zmhV06I8Qg8AuuxiZ0JOCbLN29YQuUw1OM5bxPGdzt76OeQ2Ds9jb?=
 =?us-ascii?Q?BhzxyOC3p9IoHrOH59pYCAVsVDipDF/FsTS15hrniZpRnCTmSnu20HQy0pxm?=
 =?us-ascii?Q?Qdmis2GuhlaYdpJVWDcNf/dY4JXZ666Bvv0IjZR61WHOnXLj4cFi9TM3pX2Q?=
 =?us-ascii?Q?cFZ5dRCD5vkuPMHUHfHiH4dVE49km6dNJgtyO7AJt1dzvEvOVhRxsgkIo9bR?=
 =?us-ascii?Q?3NuVwuwL76/G6q2Gnn1AsOTai3kbyti/UyBIA3DoyMihC2hJi9vEe6mv5H5W?=
 =?us-ascii?Q?RtU9Y/PdftXlpnjrsVG9KxIz1uVlsPu1Uhd3Yo4hHjcRYZNvXJ405g4aKjSU?=
 =?us-ascii?Q?5Wgwu8xvzEuUY+cnSXlzjlHC2u+hPrw9ubceI7QQCKajsgfcHc4b8qNvThmG?=
 =?us-ascii?Q?ia/1LAr+fpcCWKCyKlT+x152ko9eZA5C/7K4GlCe7El7l8tzqaWYxQGhLi+S?=
 =?us-ascii?Q?nQ9WAW3X/FznCpTNIvuy5gZiWPu3rSRbuU6b8Z/hOPVvHnkEOxg2guoYYg8+?=
 =?us-ascii?Q?NvwjAwsoorB48yBoM0ub9qTf71xRyYE2LHY0/vPt7XyS7Ycnd8W4JKhIZ8zl?=
 =?us-ascii?Q?VcAs29pjZUECwKX53NZxOe1yzo+M4WX7e6CVzGoRvLnUF7svEZaXVgJbj/IB?=
 =?us-ascii?Q?5oCBYjI7p8mSnkIDEWlcV1fPMoLODSXfyD4E0rrcyTeiE8akfCRVzQ+U27HY?=
 =?us-ascii?Q?WATBM0lIvy5bnZ5t89sXBVENXC+FvJVJdicghywVuSt5TO3d34t+vOJNPLjt?=
 =?us-ascii?Q?LqE3BaTYqF6AB+q3hvxmnb/FiW6ofsyuULAZ7iH/3Yj8jPUt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3b618f-0c7d-40c3-4d43-08df3499ad0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 02:17:54.7397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HyJ5JDSGJFeZBBn19fED86rG1u9a6ubz2CwrfSrm9tQ5Khs4V32iOGCl8GxSSoWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Adding Mario for his insight on moving drm_mode_config_helper_suspend()/
resume() out of GPU recovery, where they block waiting and allocate reclaim=
 under
reset_domain->sem and can deadlock with userq_mutex.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Friday, October 23, 2026 4:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak, Vi=
taly
> <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Li, Sun pen=
g
> (Leo) <Sunpeng.Li@amd.com>
> Subject: [PATCH 1/8] drm/amdgpu: save VKMS modeset state from the system =
PM
> path only
>
> amdgpu_vkms_suspend()/resume() are IP block callbacks shared by system
> suspend/resume and GPU recovery. Calling drm_mode_config_helper_suspend()
> and drm_mode_config_helper_resume() from them makes GPU recovery take
> clientlist_mutex and the modeset locks and duplicate the atomic state whi=
le holding
> reset_domain->sem. Lockdep reports:
>
>   Chain exists of:
>     &dev->clientlist_mutex --> &userq_mgr->userq_mutex --> &reset_domain-=
>sem
>
> VKMS has no hardware state that a reset can lose, so the reset path never=
 needs
> these helpers. Call them from amdgpu_device_suspend()/resume() instead an=
d
> leave the IP callbacks with only the hardware init.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Cc: Sun peng Li (Leo) <Sunpeng.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c   | 14 +-------------
>  2 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b74f9136aa2e..406c5f2fbee1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4568,9 +4568,16 @@ int amdgpu_device_suspend(struct drm_device *dev,
> bool notify_clients)
>
>       amdgpu_ras_suspend(adev);
>
> +     /* VKMS modeset state is saved here, never from the reset path */
> +     if (adev->enable_virtual_display) {
> +             r =3D drm_mode_config_helper_suspend(dev);
> +             if (r)
> +                     goto unwind_smartshift;
> +     }
> +
>       r =3D amdgpu_device_ip_suspend_phase1(adev);
>       if (r)
> -             goto unwind_smartshift;
> +             goto unwind_vkms;
>
>       amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev-
> >in_runpm);
>       r =3D amdgpu_userq_suspend(adev);
> @@ -4618,6 +4625,10 @@ int amdgpu_device_suspend(struct drm_device *dev,
> bool notify_clients)
>               return r;
>       }
>
> +unwind_vkms:
> +     if (adev->enable_virtual_display)
> +             drm_mode_config_helper_resume(dev);
> +
>  unwind_smartshift:
>       rec =3D amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D0);
>       if (rec) {
> @@ -4717,6 +4728,12 @@ int amdgpu_device_resume(struct drm_device *dev,
> bool notify_clients)
>               goto exit;
>       }
>
> +     if (adev->enable_virtual_display) {
> +             r =3D drm_mode_config_helper_resume(dev);
> +             if (r)
> +                     goto exit;
> +     }
> +
>       r =3D amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev-
> >in_runpm);
>       if (r)
>               goto exit;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> index d6b51b3f216b..6de33f14d909 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -488,24 +488,12 @@ static int amdgpu_vkms_hw_fini(struct amdgpu_ip_blo=
ck
> *ip_block)
>
>  static int amdgpu_vkms_suspend(struct amdgpu_ip_block *ip_block)  {
> -     struct amdgpu_device *adev =3D ip_block->adev;
> -     int r;
> -
> -     r =3D drm_mode_config_helper_suspend(adev_to_drm(adev));
> -     if (r)
> -             return r;
> -
>       return 0;
>  }
>
>  static int amdgpu_vkms_resume(struct amdgpu_ip_block *ip_block)  {
> -     int r;
> -
> -     r =3D amdgpu_vkms_hw_init(ip_block);
> -     if (r)
> -             return r;
> -     return drm_mode_config_helper_resume(adev_to_drm(ip_block->adev));
> +     return amdgpu_vkms_hw_init(ip_block);
>  }
>
>  static int amdgpu_vkms_set_clockgating_state(struct amdgpu_ip_block *ip_=
block,
> --
> 2.34.1

