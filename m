Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B9ED10F41
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 02:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C876B10E0DC;
	Mon, 18 Nov 2024 02:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iLj7nPyL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DDC010E0DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 02:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=va9C5YuxuZTYDq7wZfcUpRf4fLC1T3TcKZwswe8OeJOY7NzrpSMiGzphPLkbFz+EaSOLsOAztBev1v9QAim2uWCrfEcOgj4RHs9v7do+1nMO2IG8ROAzP8oitW44J9ZuhXnZPwRIddnTP+DD6LJn7Kx0mZX7SkZ5N/+uIqAqvBqBGY/ykC4yfOaGcGxnFNSOpFqAdyZ59HUagFboiiMSCPIv5+3EI2O8DcqZkmx58w0E0QFEYbMq438tGsLiTo6jhEC6qwtaywR/IkrHRz7oAO1XBj0Eh2bgmqnF/+zoCUiWRTEOWshiiaxnSzGbGUZKBt/FFIxWEhrY1uYTGamAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4qnIWguvJW1tAit53jQt4WQMomnPL6/MAiLd602CAM=;
 b=ssKYNVzZiSklwemzjaoyQ7UQh1TMIyNUYxzIVPPCzJHNVvvN0hBRQK810RLA6ICjmr5oyw0MBObCPo+aoLBKnnE/nDAzTZt/Pk3aEmH+ZgUMiy6dVkoBrAcDxv1CjYcqaA1qyaXMb4lJG5qwffqvXrIEOUhfdkM56JWevznkJfRHOEkKHX5gHnSq1cYM6bMTblOfZpgRjsAqzzLQRtASfU/MQi+7VjfTE/9DecRoZJlvRkSULm2Geg04uQh/BAqadWTavranJ2zQY9+YrtQ6NsOAVRSwU2aMF8Yr/sQkvhk+Rxj4i01r2YuYxhieRAaR/Ur9FO1Fg7Xng8b6YErrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4qnIWguvJW1tAit53jQt4WQMomnPL6/MAiLd602CAM=;
 b=iLj7nPyLfE/+IdoJmqzT4/3kBvX8gEsRh/gyor4dp4zzMD5u5zugzLs5AfbjmYytALSpaj/MV4n3VKDhFS99pqY/5pm2vkVdt/j+7RcvbTmx57clccD57Z3Tz6Axg7dPZAdK7Nkvn4DrEPBe7KOSXngf5EYjfxDVrOVAKk9TE14=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 02:38:32 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 02:38:31 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Dong, Andy" <Andy.Dong@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix sysfs warning when hotplugging
Thread-Topic: [PATCH] drm/amdgpu: Fix sysfs warning when hotplugging
Thread-Index: AQHbNwM1EcnSefixQEy68V2JfT0GMbK8VbSQ
Date: Mon, 18 Nov 2024 02:38:31 +0000
Message-ID: <CH3PR12MB8074995EBBA9113F0A55301BF6272@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20241115020759.3692876-1-jesse.zhang@amd.com>
In-Reply-To: <20241115020759.3692876-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=429f62af-dcd3-48a0-ab91-c7b5eea87447;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-18T02:32:15Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB6677:EE_
x-ms-office365-filtering-correlation-id: 7c3ec02d-1c60-4824-0058-08dd077a178b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?P1sB4Zu6A28XQzemWTU/lDrbo1SGw/SNzqO+AtcVsc3qwH0e/FH/vzgKTTCC?=
 =?us-ascii?Q?5wP82NdP8+Ey6d4PNR95ekZXiRO/ofukh6GzFrIYmTmC2/S8ZNtiM71Dwk72?=
 =?us-ascii?Q?F9AerxkJVwFj94QZdJMpxaesy7T26ikv8o88tsu+yN/NdtsXQRjOq9XVbi1D?=
 =?us-ascii?Q?s3UkWFomaT3RiIByeKskVGsWSMYoa7hoiYbKvColMBkz8OlVWiYWHf7maNRF?=
 =?us-ascii?Q?mDcXHwr9hsIIRMPIvcq8Gq83EymYygfNDiuX2h8nY4AiyxLIfUv33J1E9xLE?=
 =?us-ascii?Q?p9bTYT40QaBqQI3+1JasPT6sd4R7+4JiihSEZTNdlq02A1TOrxc+eEPc3tXB?=
 =?us-ascii?Q?h4dStRMR7/EGjxkp+k9OBaqciW3mGk+ATfaqTwsh7U7ojgnW3BY46D/Fzpvi?=
 =?us-ascii?Q?UOQ580tlXlrV5MxOIyE5jQt9cAU2CZBJmhJh8fynfmpThOChnakrNzTZuMFD?=
 =?us-ascii?Q?XbSkOggHDz9NneNhOISvs++QePD83n3QTuexuM124WWEHOEiaqrpw1q5/jwB?=
 =?us-ascii?Q?qsBsN/nQHaT15G0o0pKE3yAMZJojGAOzRNiM9QlNvBtco83yANfy7ZP/sYMR?=
 =?us-ascii?Q?1YfJLCGvArN/XL81ucpZNnIoX48hk2g7+6PbyGN5L1DLiEcRPN4rWw9Z818M?=
 =?us-ascii?Q?u6ySYjYrPKdIjI/fuieIzS8rSWq4LH5SQYrlNTRHZ0kpl5KzKcvMQaCTPDKW?=
 =?us-ascii?Q?Sug6NSWvsIdaZZtrHuMTylKIF3qq7gG9u6XkhebS1xopcJH5/vRbJRCl405b?=
 =?us-ascii?Q?PsSVJIsvTfCjteDLb5nez2YaplzGnXv5cZv/Z9STbgmC/U1tFksSFJLMDJUv?=
 =?us-ascii?Q?ehe23DzGwDs9QMjbxLkh1+my6Z5rd5zP1v9JYNQGgj5PDfORQs/kj5sFpbWV?=
 =?us-ascii?Q?dJxm2tm3QX2QYsQmjmgmea26j6XjIJH8GlboIPKYh4uwaUmlgc9r+sYMqPt0?=
 =?us-ascii?Q?BSEi//F2TioqwA2UrDyzYfxj/klwojrtojR/ot/5zzpKSRl36EFlBkbmTdzw?=
 =?us-ascii?Q?DfO+cXN+6mEjaB3q3TPLevH9LqA7De+HXVTir44yMwJK2J8tQYWcvbHov1Rx?=
 =?us-ascii?Q?8bYjUViUvD5lruNeHFAYZX6mrVBIeC5DcetLjnSbHaexnbnXQRwBGaNns8DJ?=
 =?us-ascii?Q?001wQFzJGBoZ+mX/uL68r0BgLdZFfK6RiuQYsjQ6yyAKP5VfDKAxQTFS6CNC?=
 =?us-ascii?Q?kTIwJZJGEn0PTxSQtDr6/CRxZbfhkhhkie17hJwddjgnmuNg6y+IMPAmtUrD?=
 =?us-ascii?Q?myK/ZLbILBJ1ChHDIJGxLQAW6Eh0VFxj6vPUiCmeYy+VU2kaLCG0YUF0KvaG?=
 =?us-ascii?Q?dNuiE69S6RmvbZyL6GRG/7QriZIhAEXZvjVuLvHOHyVTm1xd+YnP5u4A8dVF?=
 =?us-ascii?Q?2H8LP7k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9lQ8yQptsF53lr1AqhUbN4Rsgz5O+CPb70GL5XMdSW8n5mcAytSbqIQfeTmI?=
 =?us-ascii?Q?mDYZb0Adwz+TjihzCtMKcCg65g0hJgVuZGPGHYZjden1yKemRKuIlfp4OOhL?=
 =?us-ascii?Q?tc7GXNUOkOk5MQEcWfsD9YX6Qq9hXE8WLEaBlhyj9elhPYls/8KLRmG2eQv2?=
 =?us-ascii?Q?aB0BgkYfPgxSg9uWisIUKOXoM8Z2bTo92wi82Z/3AHW2lvg59LDLDN/jvbqI?=
 =?us-ascii?Q?vsc2fzF2mkMvqZ/YnCmfS0i89oi17UA/G4b5RFmfIsudm/wCCzKhGTnJap7c?=
 =?us-ascii?Q?cSG0aIU/Dlx1qJzi696mppMP+KqCETQv1dR6GfrHTQmSdbjA/BM/vkI/wzT0?=
 =?us-ascii?Q?c4oVUMrDx7DIs/96rLAPHinD9GbxNStIeqO/nNJUsfJ5EI5VvtFkA90ialWT?=
 =?us-ascii?Q?aqE95Eptu3JUBx/KdaFNGnrYOuKYmdGypg46YUVKGzWBx5zE7ikAKl8p50/J?=
 =?us-ascii?Q?FJT8vqHScesrjbwLglKrojw1hvUsgx4BAMrcaYXnYnnNc0ur9s6dlWuFuANA?=
 =?us-ascii?Q?DV2iMUOcuGrYEFqGAKWSs0bkycWzz9P2QCxEqhFaIxcVb4xPAvTuabblRqbA?=
 =?us-ascii?Q?89L3HzGN6kTUfBt1MSFu89HjzXtBYVkUBYw8EFpRGGFbfZgymSXzF5ZP9qsb?=
 =?us-ascii?Q?R7AkgicwY1iIZbvsv4wDMWkeaipZ5iOBnOsDkX0iETk1MTruNlDE0VWMihql?=
 =?us-ascii?Q?KETD8DnccwD/4y67WcsUSnTLfRZWjXikr6ClEwGiEfjNdGS7aTxvcioO1KnG?=
 =?us-ascii?Q?lHKmEM6O9QjbLfoso2fhwoZhqr/tyl/icVer8cH31QbMfAX7xGO97uAGYkgJ?=
 =?us-ascii?Q?o/A1D+XYdaeDMgGBReP+ZtCaPtqhEXx4wCV0bV/vzECVCL20ArBxGTFWqbGx?=
 =?us-ascii?Q?R3QOHFuSnX2J/OMj2mjG9d320TrlaohPAUwwksoMjbm3WmpMgvFsV2UDsT6q?=
 =?us-ascii?Q?rSnCHJptLBqW+bBHL08M7MRnH7EDVMGRVpBQLb9xKE99pDUl8XmMOzjwAZYZ?=
 =?us-ascii?Q?T4RkwaiJYOczZf4itUfMeSJYd4n6nWco7JLShB65HTxbKRDm9u6QHYEGwUwP?=
 =?us-ascii?Q?G/GaQ61N1VHIsZJF0653L/EN0oQzKqTMEBuPCLNGj8B/UPT9A8itxNiKlFNK?=
 =?us-ascii?Q?e3iJ3RH77luyQ3zgWKG7pu+m2N16iEH+NcpvxyGYyhJ7mqHW0BmiBPwUw8iI?=
 =?us-ascii?Q?Wm6YfyNS899fdNRjLKxDTmQURWFfIeKCbgW5fxOPp9ooFVTO1j2ElNNy+l6C?=
 =?us-ascii?Q?sITqB8GatqRTlH5RLgOMmxYfQoD3FeBs67KGLzVKcGX4km3hzszfDGXaOQw6?=
 =?us-ascii?Q?Fj+lUE2IcAUNStdavSEFh+L2Z+xQGFrTSM609FBuTeyMPk7/I1jEcfzk4ojF?=
 =?us-ascii?Q?qPllL6ZYaYoCBbIAxngLVdX4bKyHs8NeGzQEzLCq7atWymYOY+PYmYeC5CnC?=
 =?us-ascii?Q?m8AU4XHe9IguHZ/00N+JCB/sTMZIrb0L1ha+anHpQaudfuT1QRXacbBBjr5w?=
 =?us-ascii?Q?7ucPbxigTIW0ZHaHZJgazFI6LLhjWCETjwOkifDHpn/FssNCBDWn9F+NYuZs?=
 =?us-ascii?Q?/hPQi6TRXtcxaB6pIu0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3ec02d-1c60-4824-0058-08dd077a178b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 02:38:31.8362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11Ay7dvFYjTXN8yPsa2CvezohbzSaDCE7bCruao5JZwaK3vwzyRHgXU5CbmrwHBST5Dv2xh7+l/UkaPftkQxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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

[Public]

Hi Jesse,

I recommend reverting the old patch "[PATCH V2] drm/amdgpu: fix warning whe=
n removing sysfs" first, and then applying your change.

Thanks
Tim Huang

> -----Original Message-----
> From: Jesse.zhang@amd.com <jesse.zhang@amd.com>
> Sent: Friday, November 15, 2024 10:08 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>; Dong, Andy <Andy.Dong@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix sysfs warning when hotplugging
>
> Replace the check drm_dev_enter with sysfs directory entry.
> Because the dev->unplugged flag will also be set to true, Only uninstall =
the
> driver by amdgpu_exit, not actually unplug the device.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reported-by: Andy Dong <andy.dong@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 5 +----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 5 +----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 6 ++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 5 +----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         | 5 +----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         | 5 +----
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c            | 6 +-----
>  7 files changed, 8 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index c65feb97167d..cda0efd4d73c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1779,13 +1779,10 @@ int amdgpu_gfx_sysfs_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)  {
> -     int idx;
> -
> -     if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +     if (adev->dev->kobj.sd) {
>               amdgpu_gfx_sysfs_xcp_fini(adev);
>               amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>               amdgpu_gfx_sysfs_reset_mask_fini(adev);
> -             drm_dev_exit(idx);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index bf4dbceb18e1..7444b556e78a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -448,11 +448,8 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     int idx;
> -
> -     if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +     if (adev->dev->kobj.sd) {
>               if (adev->jpeg.num_jpeg_inst)
>                       device_remove_file(adev->dev, &dev_attr_jpeg_reset_=
mask);
> -             drm_dev_exit(idx);
>       }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index 9a0346ed6ea4..ead1ca43e14e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -130,7 +130,7 @@ int amdgpu_preempt_mgr_init(struct amdgpu_device
> *adev)  void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)  {
>       struct ttm_resource_manager *man =3D &adev->mman.preempt_mgr;
> -     int idx, ret;
> +     int ret;
>
>       ttm_resource_manager_set_used(man, false);
>
> @@ -138,10 +138,8 @@ void amdgpu_preempt_mgr_fini(struct
> amdgpu_device *adev)
>       if (ret)
>               return;
>
> -     if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +     if (adev->dev->kobj.sd)
>               device_remove_file(adev->dev,
> &dev_attr_mem_info_preempt_used);
> -             drm_dev_exit(idx);
> -     }
>
>       ttm_resource_manager_cleanup(man);
>       ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT,
> NULL); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 24e9daacaabb..11c64f087efd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -449,14 +449,11 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     int idx;
> -
>       if (!amdgpu_gpu_recovery)
>               return;
>
> -     if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +     if (adev->dev->kobj.sd) {
>               if (adev->sdma.num_instances)
>                       device_remove_file(adev->dev, &dev_attr_sdma_reset_=
mask);
> -             drm_dev_exit(idx);
>       }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 25f490ad3a85..ed9c795e7b35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1310,11 +1310,8 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     int idx;
> -
> -     if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +     if (adev->dev->kobj.sd) {
>               if (adev->vcn.num_vcn_inst)
>                       device_remove_file(adev->dev, &dev_attr_vcn_reset_m=
ask);
> -             drm_dev_exit(idx);
>       }
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> index b5f5a1a81c29..dc96e81235df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -904,12 +904,9 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct
> amdgpu_device *adev)
>
>  void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)  {
> -     int idx;
> -
> -     if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +     if (adev->dev->kobj.sd) {
>               if (adev->vpe.num_instances)
>                       device_remove_file(adev->dev, &dev_attr_vpe_reset_m=
ask);
> -             drm_dev_exit(idx);
>       }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index 54c05af2eed2..0bbeab852540 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -255,12 +255,8 @@ static void df_v3_6_sw_init(struct amdgpu_device
> *adev)
>
>  static void df_v3_6_sw_fini(struct amdgpu_device *adev)  {
> -     int idx;
> -
> -     if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +     if (adev->dev->kobj.sd)
>               device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
> -             drm_dev_exit(idx);
> -     }
>  }
>
>  static void df_v3_6_enable_broadcast_mode(struct amdgpu_device *adev,
> --
> 2.25.1

