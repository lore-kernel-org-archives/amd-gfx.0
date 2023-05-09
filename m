Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F3DC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 13:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50B710E150;
	Tue,  9 May 2023 13:34:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8569C10E150
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 13:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdn8cm0S73yynhbOHBSYSjdalw2wCNFP7i2fcZJ3I9zCmLEey0XzubPdb/BWqIXkEUBXZRskqTCYeLDyn6W17jh8Pqy3EsLIVipHX4N9TuSaRMY5/WyfrVqXYw5dN6DWj2UWxfMO9LpNmFPWDPE10WY5aUiCCVF7d+DVFSnr/jI+Kwku3aO23FwEbVf5zd5XHU1lw6rdkxdpBkY545HKMnlTnqPhP4qhgnX6waetUAgOYS6hJRpn1TVxdyWmTB0B8uEiUOgaQkOyhLaQfpWQZXFcdGZ+zlh69xwZCUgZd1ocAaRs7/SRxQ5PxoeSkDiWfAsfasZwgEfSPmUjsb1m/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5vLsXr28TJ1ZLxGvx9AC3I6mU4JuiRZgpX2CNHanQk=;
 b=Claqn01sVLLuKcApSYePP/mvQxYKp+W83e7mqfts60t66Zi1pJlFuJh0a6NgK1msEY3YRZTZ6PJuJWHNSwwPKMvWV2yyVO5H9SVH5O/tvadvvRhF/vJ+eLTOxlsGiU6N39e46rymwCThqlFZECKydkJ/nt2Idr4PbQM1MVCXax9MN1phiZ54zMMVUOPXWDVv6Xkeslo7MPfAr8Hac9ZRi3ZluJk3oV7TI7kLRcv8lITTSi0gWcS6M63LXKReuqI9W3n72fAMfse04mSlfAZwEMm8q32V4+S8FVsTQvSYEI3nK2Q5X3GKw2inW/JAnmr8Vj1cJSEbBc11fdooExKBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5vLsXr28TJ1ZLxGvx9AC3I6mU4JuiRZgpX2CNHanQk=;
 b=rBcUjdZtEfVydLPD8i7h6DcXNTZwuHz8J04uz5rn67QPgeE1qaAc2EGmc/MPdLeHPKB0qw27wVbuev6cTU4qmV0WggA+cK2DgbJME9+Ywj5rBWkOieYrS70Xm9Fmt57uXTelxLetFA/8PZt0i5FJlU6HCazYYYrVRvSWJpjjLyI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 13:34:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 13:34:47 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when
 enabling legacy gfx ras
Thread-Topic: [PATCH] drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when
 enabling legacy gfx ras
Thread-Index: AQHZghWKSCxEWMxmgEyKp4jJfmHEza9R8dGA
Date: Tue, 9 May 2023 13:34:46 +0000
Message-ID: <BL1PR12MB5144BAA16D0BCE1FEAB85596F7769@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230509012803.2096152-1-guchun.chen@amd.com>
In-Reply-To: <20230509012803.2096152-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-09T13:34:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0d846a92-b522-4c27-a35e-d38a2a83c5bb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-09T13:34:45Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 306a7a73-71b4-41dc-b76c-d20d240b142f
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ0PR12MB7006:EE_
x-ms-office365-filtering-correlation-id: fc82c2d0-c224-4a7b-71ba-08db509227f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G3o7Q615ykcsaDRHsQE51ixJMMPBrgFqDpaVQEUTd8RskeOEjvKFT1CsfEBdyxExyfjhmeBeZHoMG21sfuawoiEOhTlI1mKzjmxJRwDxVuY/5rwWbzlE/wNEh2j20eINtyJQste8k2pJTHeeCoKnbkpSKTG+oO0fltk5bsOvvgZNPDb4Qi0C2Pklrju6qhsqJHkjBvvtfKjlwlZyFRXuo95sPcf6Thrlgwaq1XW4Awgfs4EEHptGb2bw6Dq+L+/Z/PSNbJB0VwDLb2o7FkS/vvjv2u6FqFMXx7ijwz5hOrU85eC3CpH5jkxOaNfaNFkBbPXbAn0jkg/MVXcVU5Qad6AR+Vw/bKqPtSRe79D3B/se+lq10HeMtcXV92zRbHYokB9Y7onGHhOidq9cPSCmm05LyBftscBf/VVlBT+X9Z6x+PuscUjsZdAZafFs/LXIkp0xJw1CfhQuSickTgFKg5/w3WLJFA/dh758x8PZxnybCNr2t6kA/VqmgQFAj1sKRUXS/PvapsUVGDOtBquVuSP7GXoLxDqYdHbF9/sxN2HQVWAOyJHcoe2Lifo5Dt0U+dtTn8XSaiAVMlD44EjQ6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(33656002)(52536014)(66556008)(122000001)(38100700002)(2906002)(55016003)(316002)(86362001)(8676002)(6636002)(64756008)(76116006)(66946007)(4326008)(8936002)(5660300002)(66476007)(38070700005)(66446008)(921005)(41300700001)(966005)(83380400001)(186003)(53546011)(6506007)(26005)(9686003)(478600001)(7696005)(110136005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yc3NH6tbXTBBrI8QcRWNBrEYHrvd+cu8e4/UP8hN7D8bql0nqeV4qfERuktX?=
 =?us-ascii?Q?oZQYJyvVJj1z6Eei4z4s7xzolH5LV1eCegGkMrnqwLeX2yAcGdsjTkjAfIyc?=
 =?us-ascii?Q?AU2P9EAuAX5oTK0tpk6PNfiCW77jjOyeJlImck+E5D8Mj3Er6gYdYxADqoBt?=
 =?us-ascii?Q?vG3NUTl5J91vfmYXZ+Fi96SrRl5EA46VaO/g9B4iChbh7jjYgjozsDBobSJY?=
 =?us-ascii?Q?pxFzcuJtcH3qFVKDrBmAML1ScAMbRWp5Jk0fhc/DF8RYqqSSioYkkwQeJ9ZJ?=
 =?us-ascii?Q?2McB1OOmPCtL8v9Hswfqc7lMRRTfHPvNhPqGay9pheOfIsS8zbvhIBA4a17K?=
 =?us-ascii?Q?OYut7dk1E9rQDw56NBEvY8xjf9WzDvph8bZvBcJ99IV+u0aQ4Yx2Ze0mDraR?=
 =?us-ascii?Q?S8bZML+s01pOetbFmGSScgIqIF912S4nUMXczeEZOE/5L/Uc412bQXyRwc4Q?=
 =?us-ascii?Q?On26Ua+6LQxaQf3o2gp3dpnyWSfZpkSvVJTPwGGdvKA2sYyV/vM3cGjOEOd0?=
 =?us-ascii?Q?VYkY2WM8pc6VL3LLBpOYTJPGyJBVFJF0ZEBnJfM1CfO7/koPR37AAbFYUuH3?=
 =?us-ascii?Q?BezIeFjXbkJWtWf2UQ/DKPOwiLVFaRc0wvP9ebxMN+NopYHnRPh5CUkXEJp7?=
 =?us-ascii?Q?Mc0oFbt8ND9AJ/zZH/QqzAyIqcMntMQ7FYmafPVyZ8aowVMUa/2ukV44mbjp?=
 =?us-ascii?Q?lUtSPk8Lsxw1eK5N86hXdHZI4korIvgt0FDoBGjP/s5qRaDUME0Bd1zKXAAR?=
 =?us-ascii?Q?p5xx2QK0l8M8zksSm4+p0TAHct6iDeGYSlGo0RwMmHuUPVAdTPMIggo6ZT3Q?=
 =?us-ascii?Q?gTNUB2xi9334eF0Y0pDgy3Aoyj3PVxL1UEr1QxTyjC7blot8qML63PULvnC4?=
 =?us-ascii?Q?GppxXbT+KPD40Se+0r3KNmQTTtNE8hNHlkSttpmkEulJlb7sdbONgLu7W1gT?=
 =?us-ascii?Q?DdNji1UubzSVYWBDltO2NkdNwzz6+rVzKteJLqRxMXsdUgXQ2bImY78AG7D/?=
 =?us-ascii?Q?JIv+PiogDmOi/jS6/brXecH5kwxaVqA5P0FI9Ij7PwEJXUxlRPhD8FwMtBXE?=
 =?us-ascii?Q?aB/OM5NtvPkZBX+dYHx9+bHDZwJI6DWfs97j+gNn5VMIk9Q7D3XsBD8FiHO9?=
 =?us-ascii?Q?rqHR5pjigAefDEvpzimu+oDzy19JZ7D0LWN9H4KoFq5JgC5rBYXSfBnIu/oj?=
 =?us-ascii?Q?B19WwXziaMzjTQQFF5I9IKevdbiIF+M3ASQK1NQ/5IAcZN2waBOh1BwsGBoY?=
 =?us-ascii?Q?gTsK3Z8aSxeGngchdrZiFmlte7rATvQ0yQTa6nUMML7gtIeCUMX6fbIhiOnt?=
 =?us-ascii?Q?AvMeO9w6igoaGJBrzvXs+h2qveJpMbYweH870WPxNd6X8g686IiuhkgJUorG?=
 =?us-ascii?Q?5IyKD/nwSDEUL0Ha9yMzbZX3h5ioeNS1jHfhAOspnIuDNhsBf0XpxjUe8t+y?=
 =?us-ascii?Q?yJi7LUVTCeoVFWXfhBYMIhxBQ1JEcsypinvYXi/7t8NHeX2Wngjm++iQMFDX?=
 =?us-ascii?Q?bWJL0R8V6aLraGNz5HzgKh7OUvs9wYtsaPBUd3SFBgN/9DnX8wk4Jaf7g5tK?=
 =?us-ascii?Q?v+Csp5aZoB7Es+PaIUc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc82c2d0-c224-4a7b-71ba-08db509227f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 13:34:46.9134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iji+gUzH6Fw9pyo3ruMhJRuOvfPakg/3+MkDgaDEmBJYfnX2XZsNvUbbJKVF5uaCP0Kqklaj8LxWW1s9uKCd2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, May 8, 2023 9:28 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when
> enabling legacy gfx ras
>=20
> gfx9 cp_ecc_error_irq is only enabled when legacy gfx ras is assert.
> So in gfx_v9_0_hw_fini, interrupt disablement for cp_ecc_error_irq should
> be executed under such condition, otherwise, an amdgpu_irq_put calltrace
> will occur.
>=20
> [ 7283.170322] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu] [
> 7283.170964] RSP: 0018:ffff9a5fc3967d00 EFLAGS: 00010246 [ 7283.170967]
> RAX: ffff98d88afd3040 RBX: ffff98d89da20000 RCX: 0000000000000000 [
> 7283.170969] RDX: 0000000000000000 RSI: ffff98d89da2bef8 RDI:
> ffff98d89da20000 [ 7283.170971] RBP: ffff98d89da20000 R08:
> ffff98d89da2ca18 R09: 0000000000000006 [ 7283.170973] R10:
> ffffd5764243c008 R11: 0000000000000000 R12: 0000000000001050 [
> 7283.170975] R13: ffff98d89da38978 R14: ffffffff999ae15a R15:
> ffff98d880130105 [ 7283.170978] FS:  0000000000000000(0000)
> GS:ffff98d996f00000(0000) knlGS:0000000000000000 [ 7283.170981] CS:  0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [ 7283.170983] CR2:
> 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0 [
> 7283.170986] Call Trace:
> [ 7283.170988]  <TASK>
> [ 7283.170989]  gfx_v9_0_hw_fini+0x1c/0x6d0 [amdgpu] [ 7283.171655]
> amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu] [ 7283.172245]
> amdgpu_device_suspend+0x103/0x180 [amdgpu] [ 7283.172823]
> amdgpu_pmops_freeze+0x21/0x60 [amdgpu] [ 7283.173412]
> pci_pm_freeze+0x54/0xc0 [ 7283.173419]  ?
> __pfx_pci_pm_freeze+0x10/0x10 [ 7283.173425]
> dpm_run_callback+0x98/0x200 [ 7283.173430]
> __device_suspend+0x164/0x5f0
>=20
> v2: drop gfx11 as it's fixed in a different solution by retiring cp_ecc_i=
rq
> funcs(Hawking)
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ae09fc1cfe6b..c54d05bdc2d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3751,7 +3751,8 @@ static int gfx_v9_0_hw_fini(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> -	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> +		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>  	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>=20
> --
> 2.25.1
