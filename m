Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D65C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 09:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D68410E825;
	Tue, 14 Feb 2023 09:15:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D3610E825
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 09:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lwk7NUX1UMlSJ9n6zy17htozIrViem8bjEOkSJnPJ+hfhMn/S3PZDvU2cbOEywGB22c01HW29tgVpzBGAVW0ckuspzUF9nDos3J/qe1dGN7uP4fQfCxIbaFpAK0fenMuBiJQiIwkcUjWWIp3ujhnhg283Pfgb8LBmVQMIck/OL/ypcKBp83t0t9d3r8ZSH9FYZj6l6WfeoalGt0ghLgevRJIIPCODIx+juosQg9kmRKAip7KHS2pazzZPX+v0qUg1cxxtdJ2ZW7o9u67mvGmrAPr6rdHiH8qDbdKdbvvrYRslzBXDIqeinP5bSUmx/RW7b0fqlQPiWZmB/cGaw8tvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBdJzOtL9QAXHoRMtLFgsaYO0oyx0Ung+GOKDwnttuE=;
 b=RN94jRtxe0X/8ja8hHuHP74Hnm+a+1nhyWvPidU7qmf7KitzcLT7Mnuc7uLi+lG5moCF1bXV8uzArusnyVXEMAkKJVkohb17uid7CZAX+sm4EU2inqI08ctH48WEp2mmSz/tseMtie/xDrZ+5Z/u+po4M7RfGwnbIgVIfN83AOPlNtDh0ra4Lvn9HQhCUgK+YGirZ3E2hGAxFANF6ZAUD5rXOIg5Fqo2qEw5JHO4ASXA0HeaSxGT75qPgptVor4WTMCDE/ShLlwviP3mR5qsTOeMZ9DTcUJJ8x7CdhFRKtJf0rXrnxNW2K3DnG+oPxTLt8l+1l3DefAAd5rtIEUm3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBdJzOtL9QAXHoRMtLFgsaYO0oyx0Ung+GOKDwnttuE=;
 b=HxxzHMh1pJnCMngMg7lYkPPb9ruIUCrKDq7fNMEsGUbXrY6niqZKgm5sI8aFTi/Nl5m37YKU8S0yBNNKN5fnokVlbN//liCtlEf//WvCz+0gThSTPCPYBCgAU9XyflWA1BxKfiJn6MNiJae5C3uQ0etYkR7jRWemFkfHocTetyw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 09:15:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 09:15:40 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Kun" <Kun.Liu2@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "Liang, Richard qi" <Richardqi.Liang@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: added a sysfs interface for thermal
 throttling
Thread-Topic: [PATCH 1/2] drm/amdgpu: added a sysfs interface for thermal
 throttling
Thread-Index: AQHZQEmWkTnp8NfqWkulLfEehzW14a7OKQqA
Date: Tue, 14 Feb 2023 09:15:40 +0000
Message-ID: <DM6PR12MB2619A19F490DFB8A64593709E4A29@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230214075427.31127-1-Kun.Liu2@amd.com>
In-Reply-To: <20230214075427.31127-1-Kun.Liu2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-14T09:15:37Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=83109d31-18f6-4d6f-bbb1-935d3c34ce89;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SN7PR12MB7977:EE_
x-ms-office365-filtering-correlation-id: bbdb42fb-6827-405c-d4af-08db0e6c0aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lyh+lZ3+pFWgFVMaIeMzsINLH6aq4GTRVkgEFMWOvb7NFqEAYI/nBeU8vXa3HwClW7WopqtmDi8pnS2uZTpp0BYt9wAUds2WY7tSYtH9vlosTK4lFwro8LknYrdwlqfCa2t6cQuAlhMoo6yzO8rxiku731URpz3VWQY64O/iPk5DAfENImGDcBpJh+Pt864Fhn7eR30SKs+tYj6+BZclWTWOpxWI8aM971YiXA0cLKAJkfaIp0XbC+875UylTABEWAtPmsHdVyi2tyMMfk04syTMyXtzwUK94rpqoH/MSzH1QcLvGFNIM78q3HHEN6WOEC42r/oA+6wB8H7La6AScNjfXegACO2wruxVCEvo9tU2h5xcCXH7LZiv1VhTNBYrGDcBj1DgV/heguq3LTXkGCdarOGPaLzYVHq0wYRoaMKRJE0GRfjJ94IN0uqAl0jaEBpFONa/4wVUZFjK2UOpKvD9FsinbwUjL8/EQaHFGJRJsPd+em4kXxRIjRYHCaIPQ4AI3NJrcXyAsbe21suO2bZClC3xMxW3qwlBBU8L0mJBIDlDw6vNm1NnOKeL8EbuhkY00ZCbCz7F17/ZefwyBQtHcYmbjqPyGOSptVJWRq5C25FVrqWQwSNyHoCbYEPhjSdU4T6hNgCXodKCqlAGn9S8CCeS0wWXvOM68/p7mplBxqeF4hjP3Haxeh8dL/tQCfKFW38gKndUtn+e8Qj8lg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(33656002)(110136005)(41300700001)(54906003)(478600001)(122000001)(186003)(26005)(52536014)(8936002)(71200400001)(55016003)(7696005)(2906002)(38100700002)(53546011)(9686003)(6506007)(86362001)(5660300002)(83380400001)(66946007)(38070700005)(76116006)(66556008)(66446008)(66476007)(64756008)(8676002)(4326008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y6rweKoLah2x8F2/AG8wNqNFwZiZbm+EZPNjZtC72SXbNHUKwEBtfu0/htGc?=
 =?us-ascii?Q?vTPMs2LNK2GKd/KrxGxbof5Hd5pEPYOLvM8YIVKkQSwD+QlYFAxMeEmcg2qh?=
 =?us-ascii?Q?7bQb4EKW1Eu8I4ewJYoaFU7uZPhgZjlYu9VF/RNVUS5UC5eMm0sc/3Alxpbw?=
 =?us-ascii?Q?C+7uuD7zVsD6avssSBayveV6dT2j70KOjj5vkWKueQLw1rgin+fBWr7PQ3JY?=
 =?us-ascii?Q?6OdjvvVaVYQQ9mP3wCquMC3hg4XZvu8hQDz3T3bD59Gi/vXqSk/WuNan98nH?=
 =?us-ascii?Q?HyyVX3nGQoQZ1w2EBA56qtwqmM5MZrjzbRBG8vCVIztkksFyVa2Y/RXvODTu?=
 =?us-ascii?Q?LEPTAzJ7mN0V4uBo8p9ewmZ2Duc392+6dZgPaxTqmCrXaT4Ri01j8k2UcEjz?=
 =?us-ascii?Q?EJGIvX2npKvmLA2sp6E8SQGbYBcSnDi32SGnY1aUc4FzKm2HmML1vOu84Nrq?=
 =?us-ascii?Q?EaXIrjASRQjPC1NWMJKMstPcVsQ15J9Y3udkNhG7jXLQ7WKYsjfJU3cAn9c5?=
 =?us-ascii?Q?44gIFOy1OA6lU0JxN4KCZ+IHozoLYdh3ErYeSlcftpWu5MzlvrSHqWHh3Dh+?=
 =?us-ascii?Q?XHdqSj/jI/rs0/wFGEyeZGPBO8odVpFEHXSj0qN9CYsZkxtLn9fdVKoreYt3?=
 =?us-ascii?Q?Nex0LACLJ3+6gpV1aGSVtjm0ULYpzKqyXUEc0CHE/W6MGXt7CU4gwUJJvPIq?=
 =?us-ascii?Q?e5KzxMXQu1YDdIIqxrhQyXMROhjmZ1IXfzQ3Vp+3UBZBLDD43vJWPsx/PW4H?=
 =?us-ascii?Q?6V+mwGD50nM/Iv/facjrWp4B6eO+LC1IsUBxABcIqXUK4PkLKXejjrGI90Xi?=
 =?us-ascii?Q?s98OWS51tJHk7YwtHVpPfKZd7naaYoZzJTmhWjmNMerxbLEchfoXq10wl+44?=
 =?us-ascii?Q?640pHwOXqFwK4ybn21uofXn0oxZHbO3YxIiQdbi5nb1jJ0gmULzcGdKrrOLN?=
 =?us-ascii?Q?etphs66SZfy4N+j3oXptuhAKWySK2P0sLrYGeVtsN2keM5AOayBXkzt19ND+?=
 =?us-ascii?Q?w8BjPPP4jzdBKClew6u95L6pz3l2NMQ1/tlKi6nubtK4mA7S1lf7tWo0Fnqd?=
 =?us-ascii?Q?PxTpsmKnhjuEdHODCt9iZqpbpVjiw8PUl70LnGh731ubZ7EGVndaWD/5Yp61?=
 =?us-ascii?Q?z/CLP+vN/W4SjTbVkkzcU/zodgQR5U2BHeih//1nxncd5eCNkqpdOtD8R6H8?=
 =?us-ascii?Q?ehdzA5IQgi7mZXfAvTnzvR90r3ESfK6AtWqqQjQ0DkOE5zRDkVtnIsP630a3?=
 =?us-ascii?Q?qMJpwXcMD/OjfTfYin0uHX1c2l5+QRzVmvTNPbZ1XSOpzISx5EAXndTxQw4v?=
 =?us-ascii?Q?iBjrL8rIdbhRWpfB15l7ufYb5FrQBx2BuGJwWOcwwsEQdCpTy4xf+JKEthGm?=
 =?us-ascii?Q?Lz6h04gwGBieG4on7kG35xD/9KKAJKLk9XMBhdjiDW+cM0yKIL8TZuguAUkQ?=
 =?us-ascii?Q?e+7oob0kVnOrrKwIe0dVggHsd5qmMzKnuNKl7ypHi/7Y9A2/TsNV3LEk48F7?=
 =?us-ascii?Q?lfR+TULsrhVM3BU9GuLQgmCaPeK8bc/C4pCol5vRiF2zc7X0tWSEyAP6thCO?=
 =?us-ascii?Q?Y/pWIL76z4KD4DIKQcY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdb42fb-6827-405c-d4af-08db0e6c0aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 09:15:40.1387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fx1hSyn92lVukoiDQ/tMvOaziDjRXcYHCk1I320tlAwkNZFpPOM35cwdjI+hB/SB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: kunliu13 <Kun.Liu2@amd.com>
> Sent: Tuesday, February 14, 2023 3:54 PM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Liang, Richard qi
> <Richardqi.Liang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Liu, Kun
> <Kun.Liu2@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: added a sysfs interface for thermal
> throttling
>=20
> added a sysfs interface for thermal throttling, then userspace can get/up=
date
> thermal limit
>=20
> Jira ID: SWDEV-354511
[Quan, Evan] Please drop this internal link. Other than this, the patch is =
Reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
>=20
> Change-Id: I9948cb8966b731d2d74d7aad87cbcdc840dd34c8
> ---
>  .../gpu/drm/amd/include/kgd_pp_interface.h    |  2 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 28 +++++++
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 76
> +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 ++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 12 +++
>  6 files changed, 145 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index f3d64c78f..8394464ea 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -331,6 +331,8 @@ struct amd_pm_funcs {
>  	int (*get_mclk_od)(void *handle);
>  	int (*set_mclk_od)(void *handle, uint32_t value);
>  	int (*read_sensor)(void *handle, int idx, void *value, int *size);
> +	int (*get_apu_thermal_limit)(void *handle, uint32_t *limit);
> +	int (*set_apu_thermal_limit)(void *handle, uint32_t limit);
>  	enum amd_dpm_forced_level (*get_performance_level)(void
> *handle);
>  	enum amd_pm_state_type (*get_current_power_state)(void
> *handle);
>  	int (*get_fan_speed_rpm)(void *handle, uint32_t *rpm);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 1b300c569..d9a9cf189 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -438,6 +438,34 @@ int amdgpu_dpm_read_sensor(struct
> amdgpu_device *adev, enum amd_pp_sensors senso
>  	return ret;
>  }
>=20
> +int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev,
> uint32_t *limit)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +	int ret =3D -EINVAL;
> +
> +	if (pp_funcs && pp_funcs->get_apu_thermal_limit) {
> +		mutex_lock(&adev->pm.mutex);
> +		ret =3D pp_funcs->get_apu_thermal_limit(adev-
> >powerplay.pp_handle, limit);
> +		mutex_unlock(&adev->pm.mutex);
> +	}
> +
> +	return ret;
> +}
> +
> +int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev,
> uint32_t limit)
> +{
> +	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> +	int ret =3D -EINVAL;
> +
> +	if (pp_funcs && pp_funcs->set_apu_thermal_limit) {
> +		mutex_lock(&adev->pm.mutex);
> +		ret =3D pp_funcs->set_apu_thermal_limit(adev-
> >powerplay.pp_handle, limit);
> +		mutex_unlock(&adev->pm.mutex);
> +	}
> +
> +	return ret;
> +}
> +
>  void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev)
>  {
>  	const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 236657eec..99b249e55 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1685,6 +1685,81 @@ static ssize_t
> amdgpu_set_thermal_throttling_logging(struct device *dev,
>  	return count;
>  }
>=20
> +/**
> + * DOC: apu_thermal_cap
> + *
> + * The amdgpu driver provides a sysfs API for retrieving/updating therma=
l
> + * limit temperature in millidegrees Celsius
> + *
> + * Reading back the file shows you core limit value
> + *
> + * Writing an integer to the file, sets a new thermal limit. The value
> + * should be between 0 and 100. If the value is less than 0 or greater
> + * than 100, then the write request will be ignored.
> + */
> +static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	int ret, size =3D 0;
> +	u32 limit;
> +	struct drm_device *ddev =3D dev_get_drvdata(dev);
> +	struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +	ret =3D pm_runtime_get_sync(ddev->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return size;
> +	}
> +
> +	ret =3D amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
> +	if (!ret)
> +		size =3D sysfs_emit(buf, "%u\n", limit);
> +	else
> +		size =3D sysfs_emit(buf, "failed to get thermal limit\n");
> +
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +
> +	return size;
> +}
> +
> +static ssize_t amdgpu_set_apu_thermal_cap(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf,
> +				     size_t count)
> +{
> +	int ret;
> +	u32 value;
> +	struct drm_device *ddev =3D dev_get_drvdata(dev);
> +	struct amdgpu_device *adev =3D drm_to_adev(ddev);
> +
> +	ret =3D kstrtou32(buf, 10, &value);
> +	if (ret)
> +		return ret;
> +
> +	if (value < 0 || value > 100) {
> +		dev_err(dev, "Invalid argument !\n");
> +		return count;
> +	}
> +
> +	ret =3D pm_runtime_get_sync(ddev->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(ddev->dev);
> +		return ret;
> +	}
> +
> +	ret =3D amdgpu_dpm_set_apu_thermal_limit(adev, value);
> +	if (ret)
> +		dev_err(dev, "failed to update thermal limit\n");
> +
> +	pm_runtime_mark_last_busy(ddev->dev);
> +	pm_runtime_put_autosuspend(ddev->dev);
> +
> +	return count;
> +}
> +
> +
>  /**
>   * DOC: gpu_metrics
>   *
> @@ -1937,6 +2012,7 @@ static struct amdgpu_device_attr
> amdgpu_device_attrs[] =3D {
>  	AMDGPU_DEVICE_ATTR_RW(pp_features,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(unique_id,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RW(thermal_throttling_logging,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +	AMDGPU_DEVICE_ATTR_RW(apu_thermal_cap,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(gpu_metrics,
> 	ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>  	AMDGPU_DEVICE_ATTR_RO(smartshift_apu_power,
> 	ATTR_FLAG_BASIC,
>  			      .attr_update =3D ss_power_attr_update),
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index cb5b9df78..0cc379ea1 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -369,6 +369,9 @@ struct amdgpu_pm {
>  int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum
> amd_pp_sensors sensor,
>  			   void *data, uint32_t *size);
>=20
> +int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_device *adev,
> uint32_t *limit);
> +int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev,
> uint32_t limit);
> +
>  int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>  				      uint32_t block_type, bool gate);
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 2fa79f892..b612fb6bd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2514,6 +2514,28 @@ static int smu_read_sensor(void *handle,
>  	return ret;
>  }
>=20
> +static int smu_get_apu_thermal_limit(void *handle, uint32_t *limit)
> +{
> +	int ret =3D -EINVAL;
> +	struct smu_context *smu =3D handle;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->get_apu_thermal_limit)
> +		ret =3D smu->ppt_funcs->get_apu_thermal_limit(smu, limit);
> +
> +	return ret;
> +}
> +
> +static int smu_set_apu_thermal_limit(void *handle, uint32_t limit)
> +{
> +	int ret =3D -EINVAL;
> +	struct smu_context *smu =3D handle;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->set_apu_thermal_limit)
> +		ret =3D smu->ppt_funcs->set_apu_thermal_limit(smu, limit);
> +
> +	return ret;
> +}
> +
>  static int smu_get_power_profile_mode(void *handle, char *buf)
>  {
>  	struct smu_context *smu =3D handle;
> @@ -2998,6 +3020,8 @@ static const struct amd_pm_funcs
> swsmu_pm_funcs =3D {
>  	.emit_clock_levels       =3D smu_emit_ppclk_levels,
>  	.force_performance_level =3D smu_force_performance_level,
>  	.read_sensor             =3D smu_read_sensor,
> +	.get_apu_thermal_limit       =3D smu_get_apu_thermal_limit,
> +	.set_apu_thermal_limit       =3D smu_set_apu_thermal_limit,
>  	.get_performance_level   =3D smu_get_performance_level,
>  	.get_current_power_state =3D smu_get_current_power_state,
>  	.get_fan_speed_rpm       =3D smu_get_fan_speed_rpm,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 3bc4128a2..378d3df4d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -721,6 +721,18 @@ struct pptable_funcs {
>  	int (*read_sensor)(struct smu_context *smu, enum
> amd_pp_sensors sensor,
>  			   void *data, uint32_t *size);
>=20
> +	/**
> +	 * @get_apu_thermal_limit: get apu core limit from smu
> +	 * &limit: current limit temperature in millidegrees Celsius
> +	 */
> +	int (*get_apu_thermal_limit)(struct smu_context *smu, uint32_t
> *limit);
> +
> +	/**
> +	 * @set_apu_thermal_limit: update all controllers with new limit
> +	 * &limit: limit temperature to be setted, in millidegrees Celsius
> +	 */
> +	int (*set_apu_thermal_limit)(struct smu_context *smu, uint32_t
> limit);
> +
>  	/**
>  	 * @pre_display_config_changed: Prepare GPU for a display
> configuration
>  	 *                              change.
> --
> 2.25.1
