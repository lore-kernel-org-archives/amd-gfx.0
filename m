Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067F9C28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 15:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E03094F9C;
	Mon, 22 Aug 2022 15:53:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D66956DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 15:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV4MBu4hCJ90NQxsBA/iSsX9swePSiebY7kl/YJD2TAydfbpGODEGyLyAwN0cMFzzp7U9d3FyGaU45/ccdf+vsprsr99V6H51FitMKprtta9NCwDG558fRGOJO5F8FnWX+F+8YE1N6Mo5SNvocPQVMhk8aoEJa4M6xLARyLYX+ctnwP9qErofK5ZLYbKMSOPlG00e3VDJevMuf4JB6kd39FQqOxqnqX3Zm+8aUrMfB+XEBMOU1QN0npxG4Lt3Vd/jAV2EjU3EpdFmLmxd+yZGrgFHVscYlJQYxxKjgreTmUu/B19CV+ZAazt1EMPmE6BQyZgGVVew7XXXh/hVRcinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEFNQwm3PrmxZ9TvlIOCD/715tYb8H5rpvdTEyKN2K0=;
 b=HIKW6DhegCkrdNZiCLe9zNS4Ns5e8sbYuD9bDBUNtKSvziOhQKQVEGhQZaEgfdJI2rifwmdrXkutDZiL35/OF8ztIcwh7wCRMx5k4CMAvvR49m7tU8D7U4RqxBP0v40ih7ouKCJJvCQZS/IRP5s4Q3gW9a//Ms2cIHtaZ90H6qkFAL6Pz9nUmHZAA5Mx5Y+0XZ0mEqcW1kp0MSaqHSUdRHD196IFTcwN6g9viq6yZcqgVPYZc2QwmO2HDc71IBUd8kxmroVUpwOBHggJ8KLhe24jYPkLemDBMzpRQhWAqwl2B2BY4AUmdJMBdgKQI8fjvSdPE/Zn1sbMFa8jQiV3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEFNQwm3PrmxZ9TvlIOCD/715tYb8H5rpvdTEyKN2K0=;
 b=nt/tztEKegp+DDF/wIpaH37vSnOQf5Wtwk9K46CKWojiOPE+V+D/69u5jVRKPnZCRzxLKM6jKkVAAwsAJFqR1IpcWZ00/SsCe73fBEYcTtkEA5tYXXJyjl4bjS8DGPdIg5i1tt0m76D+nzl7o5WLnsMZwAtBwxcVSA/G8nFsN0U=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:53:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f%9]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:53:19 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Phillips, Daniel" <Daniel.Phillips@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Use kfd_lock_pdd_by_id helper in more
 places
Thread-Topic: [PATCH 1/1] drm/amdgpu: Use kfd_lock_pdd_by_id helper in more
 places
Thread-Index: AQHYtjwshNm5stM61k20crfyrYLGl627EYqQ
Date: Mon, 22 Aug 2022 15:53:19 +0000
Message-ID: <BL1PR12MB5144F4002937A614F35AC6B0F7719@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220822153003.6349-1-daniel.phillips@amd.com>
In-Reply-To: <20220822153003.6349-1-daniel.phillips@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-22T15:51:13Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2f57d5c2-ec6c-4786-91b0-b4c9775f57fe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-22T15:53:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e2b2ea57-b047-4691-ac0b-4cd43b47bb0a
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a751a18-3781-4154-87f5-08da84566f62
x-ms-traffictypediagnostic: DM6PR12MB4154:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3y2u59A6hDovZXNL3b++G6PmO0WglyFCUowib2q4Cte/wlQXvbIlRMm9m618xOVWsc+/hU21zTBMwDtJM8tZ6Sysaoz8DsPzesGBC0yL6abFE7dfbPsi/Avdya34Z3cr2xaLQtvomwyswOXGy+1tO6aCfXlIV2T4fIlnZb6RbMFXa24QnrG1bv7y5/0iy9RRWfThb+84aanOirVRJwSoNI65D7NRP31t+OdyOxfoBgIWO/CYZZMdCMU6y3J15JY0xpur2f6yiwzRO9f6lxs7T79o+Az0XyUGqrbCyglUmK298Fqg0s48iL1+D0HcQ6f7amcaZvet62ifFJ24TuNyofcearIsj7ZjuRhetJi3q33jyvDn9AtK9iMOg7gMHyw8mmRqNvlRQinaapr0bK4vJUuON5NidgNRoL4kVbz/TAmgk1bsUAgqVjYg7VLOUiQxPMl/HAW5GhusMpb83uZghFr4ijz5YaY9q8zNsDs3VXKNrIhyby0wVcPKveHxn0NR43BTjmQGbCsGWCgtdMTltD5ssVQa8DzcJaOML1yE3/ImzbsZPpEerFd+GKhXHnQdbabfqFJ1ERMpciB7jyIpxjUfwte41LU2+zIZpqOgFvlDmZ/IhOtrwbVOPUH39o6IAB78UFYxhEdcrhgMmaBC0Xi6yuLVvM+zOgFbC9OsgbaKGnNAM4P3ckDZiOUM5yeSlkSLm1ZT0DNSVQj+pdl84Zef8oItc8UftYI72oRg/eXTH/O5Ze8WN6ZTYQJ4E477PRoJc4U02Zpehedc6atNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(64756008)(66446008)(66476007)(66556008)(4326008)(8676002)(66946007)(76116006)(122000001)(38100700002)(38070700005)(86362001)(5660300002)(52536014)(8936002)(2906002)(53546011)(7696005)(6506007)(41300700001)(9686003)(26005)(55016003)(478600001)(71200400001)(316002)(83380400001)(186003)(110136005)(54906003)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z+osT73UYE3y5SvaBx7YAOYL4q3j5yvb+5+kes9Dr1dv5o0nrksRJlHxqpd8?=
 =?us-ascii?Q?gWpVqXVoFnbWvP8G4bO7U+iUsaw6Ytvqw5/UeqoOiYv4Ufqj8O/ZHriOj3X6?=
 =?us-ascii?Q?dyQqzOdd8ufEFhS22mZtds4qqOPHbLEKf+VA2WPNGpdsAnYcIVOMJMvjR2FO?=
 =?us-ascii?Q?4nFNzZfroSrFfOsf5W5miKVVD3pCKG+/l0yv4gGQEXzmZ7w5IieYeoy2pde/?=
 =?us-ascii?Q?eCp0pSQXi8FZmgKBOK7ZJKNqbQ/MzhGBujNf6STxSNY6lg9WIJD28pLQYqeN?=
 =?us-ascii?Q?TdsP9MTBtWyOoyZafI6PJnD3pzRoCXxcuXCl1qaqm4W4fzOZONn42twXpkxQ?=
 =?us-ascii?Q?jXBqbzoDpNl0Lvr50v+2EU2C8vFUpS7RYFkvWYV1QYQhKWSypI/A2XFKxa1Q?=
 =?us-ascii?Q?YU0muKXgxl1pn2B/qb0EI0yCDEl83629Q5nCQHp7XtM6fRaze3Ec6loG721i?=
 =?us-ascii?Q?OrUEox6xi1YauMS7JWXbbbZwKA6QK19qNFVNaOZGUfHiBurKAUcVdIr1Xc5b?=
 =?us-ascii?Q?tPC8wf/An1iWDQnfUqZ+lsEhOM8u+YEvrsIrNAR8f7CelR2lMIgljhShmZNe?=
 =?us-ascii?Q?TFDivYoNjP/MfRIwJEt5vpIn1upuysFYjtQJC8aVThWVGh8i4qf4ccKggPxY?=
 =?us-ascii?Q?mNDUe2reB9T9HgYILheA2UYCEUNAB7FbMLGk1xIFxG83V/Dxw6e6a8FmOwhF?=
 =?us-ascii?Q?Ngq5Bu2ECTSmk4hndtnfESBieqiZibaMN5gobXnxe0k0svYDqjwFBe2hfmn0?=
 =?us-ascii?Q?aonqJ7yoGiBX7mFQM02G2knbZ4mY1o63ttTO4KiZ7r04PXmuk0a2zAKtMoZ3?=
 =?us-ascii?Q?o5ZSq716SkMw0KITZXIKUVywboYqYoct+n8t566tF9iIU8KC8HmyaAV1qkvt?=
 =?us-ascii?Q?ss3dwAdg66uC78fspujei7FdYPbXOovreNT50sn/WriSqUULG5687CLAEMkX?=
 =?us-ascii?Q?+07PUZ9SkDbd3uP1YtIzpEJBEyVkxPPIsqTCSDa0cPslZ0DmyjNU6vwgSN9j?=
 =?us-ascii?Q?1iLfLuFCf6RGN7RDkmeBqm+tqLhK4nEpzqrWvmU6iT+HH5X54P+rSVtp7W5G?=
 =?us-ascii?Q?Y5GdOVSkAcMttxd1DLZZcdRU8qDsDwGRZqekzWToQAtNXKtBMUCO/imzw/VS?=
 =?us-ascii?Q?9JEucfG+qKls4wCN5ytI3gLWrpduO81nvsT7pCOnwngPED4+oqopPt6Qr99s?=
 =?us-ascii?Q?WUidRl6SD5MphW94zlwkxpR13DEPskDmjykN2FVwgW5CmpscdnEPfx+f4Xkz?=
 =?us-ascii?Q?fWZF8srZKe2DLwTLbXuFCW57R4VHcj7acvWG5r+OZiCPOQd4VJTRT2eiF7+c?=
 =?us-ascii?Q?P4CaM0IEjQGVlSmpAe7vKlZz9gOJNh+mGyUFRrkX+6FvQj/ewLRCA158E2PV?=
 =?us-ascii?Q?vrd8ruzXmTjQvGMw2NEPehKxZyThLVCWwKUOxj+vSOFMxKIVTwhU4M756b+V?=
 =?us-ascii?Q?AHaF5opLE4Lug20AtMEVzVKCjeeCrk49BR+qWAMBTRhNdoUY5UpsDE3y6jun?=
 =?us-ascii?Q?o/gWW4IVTRvU8oqlHI0yQhfmbOnqtNNwiUDna1/YdoaBT8mMW7y7Db95klML?=
 =?us-ascii?Q?argVau0rH3EKcbTfJAA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a751a18-3781-4154-87f5-08da84566f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:53:19.6503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fT7pgbYGvYTEaCz/rNA9VP567wTCxF1IvsECqfBUJ1jpcYOPHqQCuDQ/dfg0cjCLmA7qMuQvPMB+KH0uF/sNNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
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
Cc: "Phillips, Daniel" <Daniel.Phillips@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Daniel Phillips
> Sent: Monday, August 22, 2022 11:30 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Phillips, Daniel <Daniel.Phillips@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: [PATCH 1/1] drm/amdgpu: Use kfd_lock_pdd_by_id helper in more
> places
>=20
> Convert most of the "mutex_lock; kfd_process_device_data_by_id"
> occurrences in kfd_chardev to use the kfd_lock_pdd_by_id. These will now
> consistently log debug output if the lookup fails. Sites where
> kfd_process_device_data_by_id is used without locking are not converted
> for now.
>=20
> Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 96 ++++++++----------------
>  1 file changed, 32 insertions(+), 64 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2b3d8bc8f0aa..bb5528c55b73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -75,6 +75,7 @@ static inline struct kfd_process_device
> *kfd_lock_pdd_by_id(struct kfd_process *
>  	if (pdd)
>  		return pdd;
>=20
> +	pr_debug("Could not find gpu id 0x%x\n", gpu_id);

Leftover debugging code.

>  	mutex_unlock(&p->mutex);
>  	return NULL;
>  }
> @@ -311,14 +312,9 @@ static int kfd_ioctl_create_queue(struct file *filep=
,
> struct kfd_process *p,
>=20
>  	pr_debug("Looking for gpu id 0x%x\n", args->gpu_id);
>=20
> -	mutex_lock(&p->mutex);
> -
> -	pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
> -		err =3D -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd =3D kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>  	dev =3D pdd->dev;
>=20
>  	pdd =3D kfd_bind_process_to_device(dev, p); @@ -405,7 +401,6 @@
> static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process =
*p,
>  		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>  err_wptr_map_gart:
>  err_bind_process:
> -err_pdd:
>  	mutex_unlock(&p->mutex);
>  	return err;
>  }
> @@ -566,13 +561,9 @@ static int kfd_ioctl_set_memory_policy(struct file
> *filep,
>  		return -EINVAL;
>  	}
>=20
> -	mutex_lock(&p->mutex);
> -	pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
> -		err =3D -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd =3D kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>=20
>  	pdd =3D kfd_bind_process_to_device(pdd->dev, p);
>  	if (IS_ERR(pdd)) {
> @@ -596,7 +587,6 @@ static int kfd_ioctl_set_memory_policy(struct file
> *filep,
>  		err =3D -EINVAL;
>=20
>  out:
> -err_pdd:
>  	mutex_unlock(&p->mutex);
>=20
>  	return err;
> @@ -609,13 +599,9 @@ static int kfd_ioctl_set_trap_handler(struct file
> *filep,
>  	int err =3D 0;
>  	struct kfd_process_device *pdd;
>=20
> -	mutex_lock(&p->mutex);
> -
> -	pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		err =3D -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd =3D kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>=20
>  	pdd =3D kfd_bind_process_to_device(pdd->dev, p);
>  	if (IS_ERR(pdd)) {
> @@ -626,7 +612,6 @@ static int kfd_ioctl_set_trap_handler(struct file *fi=
lep,
>  	kfd_process_set_trap_handler(&pdd->qpd, args->tba_addr, args-
> >tma_addr);
>=20
>  out:
> -err_pdd:
>  	mutex_unlock(&p->mutex);
>=20
>  	return err;
> @@ -663,13 +648,12 @@ static int kfd_ioctl_get_clock_counters(struct file
> *filep,
>  	struct kfd_ioctl_get_clock_counters_args *args =3D data;
>  	struct kfd_process_device *pdd;
>=20
> -	mutex_lock(&p->mutex);
> -	pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> -	mutex_unlock(&p->mutex);
> -	if (pdd)
> +	pdd =3D kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (pdd) {
> +		mutex_unlock(&p->mutex);
>  		/* Reading GPU clock counter from KGD */
>  		args->gpu_clock_counter =3D
> amdgpu_amdkfd_get_gpu_clock_counter(pdd->dev->adev);
> -	else
> +	} else
>  		/* Node without GPU resource */
>  		args->gpu_clock_counter =3D 0;


Coding style.  Please convert the else clause to use { } as well.

Alex

>=20
> @@ -886,12 +870,9 @@ static int kfd_ioctl_set_scratch_backing_va(struct
> file *filep,
>  	struct kfd_dev *dev;
>  	long err;
>=20
> -	mutex_lock(&p->mutex);
> -	pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		err =3D -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd =3D kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>  	dev =3D pdd->dev;
>=20
>  	pdd =3D kfd_bind_process_to_device(dev, p); @@ -912,7 +893,6 @@
> static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
>  	return 0;
>=20
>  bind_process_to_device_fail:
> -err_pdd:
>  	mutex_unlock(&p->mutex);
>  	return err;
>  }
> @@ -973,12 +953,9 @@ static int kfd_ioctl_acquire_vm(struct file *filep,
> struct kfd_process *p,
>  	if (!drm_file)
>  		return -EINVAL;
>=20
> -	mutex_lock(&p->mutex);
> -	pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		ret =3D -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd =3D kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>=20
>  	if (pdd->drm_file) {
>  		ret =3D pdd->drm_file =3D=3D drm_file ? 0 : -EBUSY; @@ -995,7
> +972,6 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct
> kfd_process *p,
>  	return 0;
>=20
>  err_unlock:
> -err_pdd:
>  err_drm_file:
>  	mutex_unlock(&p->mutex);
>  	fput(drm_file);
> @@ -1063,12 +1039,9 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct
> file *filep,
>  	}
>  	mutex_unlock(&p->svms.lock);
>  #endif
> -	mutex_lock(&p->mutex);
> -	pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		err =3D -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd =3D kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return EINVAL;
>=20
>  	dev =3D pdd->dev;
>=20
> @@ -1140,7 +1113,6 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct
> file *filep,
>  	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, (struct
> kgd_mem *)mem,
>  					       pdd->drm_priv, NULL);
>  err_unlock:
> -err_pdd:
>  err_large_bar:
>  	mutex_unlock(&p->mutex);
>  	return err;
> @@ -1231,8 +1203,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct
> file *filep,
>  		goto copy_from_user_failed;
>  	}
>=20
> -	mutex_lock(&p->mutex);
> -	pdd =3D kfd_process_device_data_by_id(p, GET_GPU_ID(args-
> >handle));
> +	pdd =3D kfd_lock_pdd_by_id(p, GET_GPU_ID(args->handle));
>  	if (!pdd) {
>  		err =3D -EINVAL;
>  		goto get_process_device_data_failed;
> @@ -1304,12 +1275,12 @@ static int kfd_ioctl_map_memory_to_gpu(struct
> file *filep,
>=20
>  	return err;
>=20
> -get_process_device_data_failed:
>  bind_process_to_device_failed:
>  get_mem_obj_from_handle_failed:
>  map_memory_to_gpu_failed:
>  	mutex_unlock(&p->mutex);
>  copy_from_user_failed:
> +get_process_device_data_failed:
>  sync_memory_failed:
>  	kfree(devices_arr);
>=20
> @@ -1347,8 +1318,7 @@ static int
> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>  		goto copy_from_user_failed;
>  	}
>=20
> -	mutex_lock(&p->mutex);
> -	pdd =3D kfd_process_device_data_by_id(p, GET_GPU_ID(args-
> >handle));
> +	pdd =3D kfd_lock_pdd_by_id(p, GET_GPU_ID(args->handle));
>  	if (!pdd) {
>  		err =3D -EINVAL;
>  		goto bind_process_to_device_failed;
> @@ -1398,10 +1368,10 @@ static int
> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>=20
>  	return 0;
>=20
> -bind_process_to_device_failed:
>  get_mem_obj_from_handle_failed:
>  unmap_memory_from_gpu_failed:
>  	mutex_unlock(&p->mutex);
> +bind_process_to_device_failed:
>  copy_from_user_failed:
>  sync_memory_failed:
>  	kfree(devices_arr);
> @@ -1517,11 +1487,10 @@ static int kfd_ioctl_import_dmabuf(struct file
> *filep,
>  	if (IS_ERR(dmabuf))
>  		return PTR_ERR(dmabuf);
>=20
> -	mutex_lock(&p->mutex);
> -	pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> +	pdd =3D kfd_lock_pdd_by_id(p, args->gpu_id);
>  	if (!pdd) {
>  		r =3D -EINVAL;
> -		goto err_unlock;
> +		goto err_pdd;
>  	}
>=20
>  	pdd =3D kfd_bind_process_to_device(pdd->dev, p); @@ -1555,6
> +1524,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>  					       pdd->drm_priv, NULL);
>  err_unlock:
>  	mutex_unlock(&p->mutex);
> +err_pdd:
>  	dma_buf_put(dmabuf);
>  	return r;
>  }
> @@ -1566,13 +1536,11 @@ static int kfd_ioctl_smi_events(struct file *file=
p,
>  	struct kfd_ioctl_smi_events_args *args =3D data;
>  	struct kfd_process_device *pdd;
>=20
> -	mutex_lock(&p->mutex);
> -
> -	pdd =3D kfd_process_device_data_by_id(p, args->gpuid);
> -	mutex_unlock(&p->mutex);
> +	pdd =3D kfd_lock_pdd_by_id(p, args->gpuid);
>  	if (!pdd)
>  		return -EINVAL;
>=20
> +	mutex_unlock(&p->mutex);
>  	return kfd_smi_event_open(pdd->dev, &args->anon_fd);  }
>=20
> --
> 2.35.1
