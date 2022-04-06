Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAAAC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 23:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C727D10E00E;
	Wed,  6 Apr 2022 23:08:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258E110E00E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 23:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7y+vf0nXUC2UCFrKdQReZ3NAIipN9iy5jOXA3MOq7APhdYu1O5m3TN7uxQ+DGC/Z81f9Ahi0Ma2TkfgN6q+ZA9GYm+8KclrySlhfjGtSg9AkUND8Wp9qaTHev4IohiKHxGwxbkSn1LYOEUsgoqAlgzl9+/PB+JMA+hXfzzF/mRb/HqCI9vfgVO+a8aEWI8fAvNAH4oVk+4CHB6788OZ8JvvjfiYRw8taA0G3/WJbcXGMhPQGwTe1DxGjQgclHApnsea9NxlE1EEfKyem2uLqXN9ww6n52nLou1yfNR8oHrHLh3QZxdnqlcZDvwtIHkIpVSNPxpgF4cunzN49zUG9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBMNr/JuBIT6Gp522BpyP4ecaOGOxBvs3RH8FyUtpJM=;
 b=VKH5oqYgsN56U9cN0G/39rgzxXU4Tqwg3tjNmIHx8aH58ZEd6BGxVLqUCqtDKauCbbhMRD0oE2+y2Nr+3ppfpvjBEsxYhbf7W4FgWquIiuqwwgk+v8ujzqki5CQNC9gpxGFw95VQ3gpptr8atQINOqWaOUktd+Er2AaTQsX6k4d7jh9/TeEPUnB0M60Y2DH0GXC/JRWFGeJoH+zNz50VqBhTSHuJRmAwzmGbvyZPlRwlnXqkjyOkZxRqeX+QS5ucIydWNI4xVSM0mOza+dmAgfMr+PeuwER5dG/ClPzj+sDLOcPnviZsqKht9Kfds0ELFiX9pZ9nD8h2IYDrpetehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBMNr/JuBIT6Gp522BpyP4ecaOGOxBvs3RH8FyUtpJM=;
 b=3F5yNsDQd4Nwh8dwpcfUFNVRCQrjDuRmLp3TBaDGO7qFlAiAl0XgCVJ7jnPsTIR24RDIz/ED3okEPoxZT+kYxlyiUGXqrTPTFevAQCzcaLAOU53Qgf9ha0eXsMzzQAzakgRYGsoVQNCb0PXN1UujE9AaGmGMUTUrnTDb918rbzQ=
Received: from DM5PR12MB1786.namprd12.prod.outlook.com (2603:10b6:3:112::14)
 by MN2PR12MB3358.namprd12.prod.outlook.com (2603:10b6:208:d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Wed, 6 Apr
 2022 23:08:34 +0000
Received: from DM5PR12MB1786.namprd12.prod.outlook.com
 ([fe80::c834:f82a:2d77:a83a]) by DM5PR12MB1786.namprd12.prod.outlook.com
 ([fe80::c834:f82a:2d77:a83a%3]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 23:08:34 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdkfd: Fix NULL pointer dereference
Thread-Topic: [PATCH 1/1] drm/amdkfd: Fix NULL pointer dereference
Thread-Index: AQHYSfo0y9fiYtfe1k6ZYBAmcswxwqzjgl/w
Date: Wed, 6 Apr 2022 23:08:34 +0000
Message-ID: <DM5PR12MB1786665576D6F8EDDFE97B2FEEE79@DM5PR12MB1786.namprd12.prod.outlook.com>
References: <20220406210616.133483-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220406210616.133483-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-06T23:08:32Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6052e4ae-228a-493b-a861-8afb1cb1f79d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fa6537d-7c04-48dd-1e9d-08da18226037
x-ms-traffictypediagnostic: MN2PR12MB3358:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3358FD176ABED25A8023C528EEE79@MN2PR12MB3358.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g13P2mNxC5j0r1s/yilc9HCJAesrW4yXbsI8FQkxhVVqXFQM4hx324GIn2ux97jUuQgy8NVAb0mGg7Sth+r63utf2RoCvAvE95d5btZ7ZkQNNDwK0tl/RRkV+JIQZFKUdircIsvo8B/U50HC4QftJKWuXUbQ3qm82p6S+uaCWmMzEfJit//GVJIg+4TGJcXoVPI/isl0g9GkZv7pOw95fU9mQX387bu8cpUjMJgMvBey6zcFVNssFyIeY9FChZ6MoSD7D2CrwymUP15WdSQPHiYXiagnY+7dAVrIOxpeK02pt9eKE7mZubKrN2LuvJTlxdC1bmBMDN2gYENEcGNNCVRWqYdUESHY4mh7tHRCKTt+n2cDknm6O8EcqXKGwmV6iWuJE3a0oPLcIUgOdAj1Stq1/HoRXP/g5Ww3oAy61sXKeeZjlwyOm7luEXOsDoWyXbqfbgLvowRyw8r/T3Fuw3FjmpLawM8HAh+7Tb3t0pJc4PUJEo7bVPD1zC0u3wCINV+opv094juUi7e8ZqjYWI6PYjYlteG4RvqAZXtUt8mfdSqzVQa9pS7ARQqefucYQ6r6xZHngUTqTWS6ZrKNkVZjf9VYhvE5HXEB1GKiJg2VEmbDPLYEV/j2y+rIfjB/RM+q1aMhB25sAhINRve6Dz78gLpy7AXbKw+Z8DoI/3vO5R8lTO0QNchr43c7/9exK2uqkrp/0iPJ9ftaeyQwHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1786.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(4326008)(8676002)(64756008)(83380400001)(38100700002)(38070700005)(122000001)(5660300002)(52536014)(8936002)(66556008)(66946007)(55016003)(66446008)(76116006)(316002)(508600001)(7696005)(6506007)(9686003)(2906002)(71200400001)(53546011)(33656002)(66476007)(110136005)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J+x1V8Zm6XvtZ4tMmRKBZLlxKN1u5ju9y/RPSeGVQ+ictMB4fISSJBmdwVl5?=
 =?us-ascii?Q?jDVfaiDwXSNfhyL71fGzMOcdavEZeBy2ksd1zVSQfs/FZWBT5psNvIxydTls?=
 =?us-ascii?Q?X+A2UYifiYfWeI+5Iwz2Ks53wDdwtifq8LO7YeQzdOfQxZNT/rkW1U5yzQsR?=
 =?us-ascii?Q?wKo+PImPSsAGyeaIwjmdV0tzXqnLIuVXsd1Hl7Io+32qM/HiA/j/WFfRfNsP?=
 =?us-ascii?Q?R9uyeGEGgNJdIZIDpj3j8OaAtshr2bEzMI3Je7gJgES2DiZNJoK29KS3rkW4?=
 =?us-ascii?Q?yjCODWnKXQ9HeCogd5YBCOqtqEFN+79vCRWD9DJP05mnzAhXxLXwPBcpbjHn?=
 =?us-ascii?Q?JIzG7DbooLz/rlmQM78MNjVe7upjgWr+oGm9PmSUawDuATAJSzdHDeD//V55?=
 =?us-ascii?Q?TixV5C+3si1qIN5bgaZcShYQFePpRdrH6cE9xZ+4r4yO1uqfutWETlP5n+sj?=
 =?us-ascii?Q?dMgQ9AKnMlTkfR6CJPQBJS/jIuyxPSZVE8+D6MOuzjXSavm2p3qlISSYWdnc?=
 =?us-ascii?Q?6zejJbnrGZuj4IPJk73Z1r6Bn2CLnwF1dIczYSvKz2DtZrTX9sxCZlyrrpEA?=
 =?us-ascii?Q?/zyg+BD88XJw2IVMkoUyuVwNqcPZLBmX0gXXPHWo1ZD2ST5TltoQNoCvoLzX?=
 =?us-ascii?Q?v+KdT6Aul1owulT9OgxExZC4g86R1wHpC4jM1YqoGAfu8b91pVBMnc/fQ5Mv?=
 =?us-ascii?Q?2sePHtvp6csGXoxcXDybqMskxfkTpgWmuLCjQOiIGxpUYZbst0oh6eD3PVM+?=
 =?us-ascii?Q?gWb9XzXTOfbIf6JGcypBf5o+yyaa8nL1DzAH1sAeGEx5loThwrbNeeCchI9U?=
 =?us-ascii?Q?+DzM/uT1WEzjhFvQK+0YJ3Uk+g+8BFymtsfZG/4DdPVnQKgi8l+f+ocnUAdZ?=
 =?us-ascii?Q?Ghwabx6wHKvckR1oU+Lo0vwm02P+JkNe0sT4vBzO586JAtnbId2+RU7lCpX3?=
 =?us-ascii?Q?IVm4RzGlISKhfKCuLZ2G0/VU1SHsBo56G0laSHyt6ggF2EHfU+MjZXKl6/KE?=
 =?us-ascii?Q?1165x3GS+OnhzCsgPgmI8/VcVGXhyrUAnp3ijsKZjoGJA39sneGxmmuOKnDZ?=
 =?us-ascii?Q?vhwhXRhl53mHuRm7a+dANkyUA28bvwnyZv51xSPskHXBk31x5PWt0o8gJScf?=
 =?us-ascii?Q?ai9eLpF/+CTbXzv7buwmqsPG25NQPh2ixLhP+m1RQ2oRD7Sp08uwXCN0S90H?=
 =?us-ascii?Q?A1ISzNhe1HPLbNXuSz/AjSHRRe0FOM1MkP+fwNuwDkjKu+bli5SBg1h//IMH?=
 =?us-ascii?Q?wzM4idWcEVgVy1Z+D6xvUjtEbiRhFzW3D3eT495w0vYn92It38oy2+Tdk9U+?=
 =?us-ascii?Q?eUUww+xUL1eof69nzpCc2YteoPvTl3UL7CVnxy3l0C2TwUnueyArS8TUwO7J?=
 =?us-ascii?Q?Ir8sPOfXpcFO/ap1JZrfyJs/Lek2/Jx21bqdtk1B3lz6gTSI7MI76loTJFFc?=
 =?us-ascii?Q?5fo8qfnkjPBTNS91171i21BuETmFVk/flSmHKmfbkMC7UZUjugxL5aQ/DGWI?=
 =?us-ascii?Q?05L1qk26QJ3xI/WlTZ1sIUneK3LQtM2LKCgApQ+z8AtZba0rpHORVMvhPW5Y?=
 =?us-ascii?Q?yDgc6+W9EBiRQDKEQRn+E4qhTu4v++pP+/GaQJUkfxCRA9ebbRX0UJ4PvX6X?=
 =?us-ascii?Q?3Y7Q6/8IM4biMk3syC44YJnDwFhtPYMh4a1jYLANsvFogLDl+mGHw5rvN73a?=
 =?us-ascii?Q?trZAUtIbKESIpS8mzgYUfEH1DpQFORfQaDMOg+18daYf/TbQ5fwpcAAuzIEw?=
 =?us-ascii?Q?YdIwgr5TVg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1786.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa6537d-7c04-48dd-1e9d-08da18226037
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 23:08:34.8057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TH9WS/ZELNHCG0G60YBEZcuawA4nCf1vcmbX/Ij44dKxY4gf/BRclvews37CL9z48tRf0fFmEDWzleA0fYLrAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3358
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

[AMD Official Use Only]

Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Wednesday, April 6, 2022 5:06 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/1] drm/amdkfd: Fix NULL pointer dereference
>=20
> [CAUTION: External Email]
>=20
> Check that adev->gfx.ras is valid before using it.
>=20
> Fixes: f385fc0d19ce ("drm/amdgpu: add UTCL2 RAS poison query for
> Aldebaran (v2)")
> CC: Tao Zhou <tao.zhou1@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index c18c4be1e4ac..64c6664b34e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -727,7 +727,7 @@ void
> amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device
> *adev, bo
>=20
>  bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct
> amdgpu_device *adev)  {
> -       if (adev->gfx.ras->query_utcl2_poison_status)
> +       if (adev->gfx.ras && adev->gfx.ras->query_utcl2_poison_status)
>                 return adev->gfx.ras->query_utcl2_poison_status(adev);
>         else
>                 return false;
> --
> 2.32.0
