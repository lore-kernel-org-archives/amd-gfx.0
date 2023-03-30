Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8A7C74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 03:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0449A10ECC2;
	Thu, 30 Mar 2023 03:58:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E490110ECC2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 03:58:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuhMQ/q0jiG4MQKKujxJBo+41qMMjYfGENSbrhfavWac4tee4BE5hHOCnV3dp8NhF4+JRVwOZ4icyVBOJdxk9QaIXVE9LkA2KnFs6TbXOlSSkZ7u/Orcp7k5Qf1fHBwlvOD9aIZrBCrOAYflXW8iiJkx8Z61+npaclsCET7MBf55OKG+L9ziDPBHhIp2hNCvqFikRuAIVxLT4vwJC05iu4ej7AKU3/6fbpCUFQSbV7kfTDOy3KsDEZ2ywRTzhZ7qEkZBgeRc4hqkRYyD7r5dVN2Tt6yKMAO35QnX1vuD9gxm05Eg+r56Ha6I8FxwMDkPGSyqQtjyGi/sPYgF8qHfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sabH8HZ5IyQKbS3QLbJEH7EOhvH14kFwbcdXywS7/ps=;
 b=ZYpg/Kg4Nfz0WU1y/k7GYAVQ5d64j+/R2km/8o7l2pjiMsVr+7oxxNoSOh4TTgjM+nZz9ipqD/yeYt1AXoLaBN+xc71Ozh5OWhZw21Jj+2UBvXqUFAcoQlqn9+D/Y6zoepLXNR45xru3bsblFQDNu2iVcjmrnWpqTavax756Lt9o+YWyOjFEe3oQEf8udjFdQ+5ybcGfF5xfQM97fxzOD8iB1Sq+eXQH6on2+18ugJhohSGYj4J8/jzRvGVUz6Ib5IprDzXujsrQogamaP1diehUl/OZyVVjL3TtZfw+/pkb+PjT7tzzkWWowONabfYNNJae+4DmK6Ik7qY0rvFS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sabH8HZ5IyQKbS3QLbJEH7EOhvH14kFwbcdXywS7/ps=;
 b=RsE2RR7rEFNsWADm7SQTfiHRZzZTKEhWRFtmEIa/muswCB0nHB6w/L7ulmQw3tKWVW0QZZJ9jKSrgCs9rS7RZ9ZsTceNgIF4AnqODBhWhnWgi8zGzniFJIo5+BZe4sEwm6O1MAPl6YUnZf3tofsqzGat0akiGO65+g2efWm5P7k=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.32; Thu, 30 Mar 2023 03:58:44 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::3334:46b8:da25:16ad%7]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 03:58:44 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu: enable sysfs node vclk1 and dclk1 for NV3X
Thread-Topic: [PATCH 3/3] drm/amdgpu: enable sysfs node vclk1 and dclk1 for
 NV3X
Thread-Index: AQHZYrYAXanLoHjcvEizHeQft2ylta8SscTw
Date: Thu, 30 Mar 2023 03:58:43 +0000
Message-ID: <DM6PR12MB2619F79C3C38248E37BCD30EE48E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230330031513.6547-1-Tong.Liu01@amd.com>
 <20230330031513.6547-3-Tong.Liu01@amd.com>
In-Reply-To: <20230330031513.6547-3-Tong.Liu01@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T03:58:40Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4c376f9e-9774-4760-b66c-abe21a66d072;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM6PR12MB4387:EE_
x-ms-office365-filtering-correlation-id: 3d0c1046-1e15-42b8-2d9d-08db30d30e56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g8dqM2Kp18TXERKCsvt847bN5GceEssWcqFvISq0TthfOt+RIZJ6U1UyPJuxxHrq/ZnNmLYUKUORHB9iD/Glnf1x4ibE5AyC/cMR7O9tjxH1S+rjAEkp+ULqj/Oq/rd3usPC6pKtEEM3pAAkUfo1vBB+77TYMUmNO99kV2eLSuk3RS+DAwAyiDEpOMVPuYbU4fbZQvGezCYiMGG7bjoPwoBomREki4hZU/vJsud3bam9EkkHFSPEI/2vsrvjWtY9Wky/gbDz262IHmYIex+Yj1yXiFjn3pHio/2z4bEz4zTCmB6Ll8a1j0TKiazyCXz3USQMTTG8udoXmNRnH7ZMqlqSNmxkW37s4vc8t7taxL4tmy+teMagCvDmf8+Pmg8EkU5mnz4n6EO4dQO1qOKyHNYGTWPsK7v0J93QxpQjxmPgXfjTazWEvMrs8MktTIoaA1Yg//zujM6zEnZv3ULl6P95R0ee1LcYEQsIZyFJB3zrwfhVJvOoQQXmHOKHUGMTtKgyKV32pehJI19rNTFB8WP+YXhYaKZwkjWBCNFKh/Uk6XG8DZxZ62Crjvp2oFhJtbbqMoVu6InAJOx3ECMMywFpJiYEwinUwrRnVYUU21VbhuaHX3jAsteW5kg8B7Bt7pNmpesMbmD7M4WONov1cw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(2906002)(38070700005)(86362001)(38100700002)(33656002)(5660300002)(478600001)(53546011)(83380400001)(8676002)(55016003)(9686003)(110136005)(71200400001)(6506007)(186003)(4326008)(7696005)(64756008)(66946007)(316002)(66476007)(66446008)(76116006)(66556008)(8936002)(54906003)(52536014)(26005)(122000001)(41300700001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?otBBfQcnYgy5DdI7+1M39jWF+R9531WEQYNgbXD2hC6Gd/bDXmr5ZUfOTasZ?=
 =?us-ascii?Q?mEAOW/Zc0H+i/17r6mP9p9UUok+msy8BBP1uXH90ytWswplLDl6aKhUPHeEd?=
 =?us-ascii?Q?V1oL6oXc5Kn+0vDi6BO2VdoqG3B/XXtU8PR4AXqf314ayY65fBI/rEAbhuAT?=
 =?us-ascii?Q?KudYTPRBQQZior3o9f2sIiJbnu3PR6gADkh4oD4X85Clt4/+4OHdy67D5yxt?=
 =?us-ascii?Q?hX0SftWh7A/xlpr85XgRd+PalE+9ibXq3KA1Mt+SWsxzIZoL6KDmKIV9S6DJ?=
 =?us-ascii?Q?lcYtKUOji2yvcjIplP/hOxd8BBYBisd0J1/UakYlxMmm7NpLazFpXZfcyhtD?=
 =?us-ascii?Q?e+/R7ksLgHjZlnaCPr0lD7g44NB+TcBQmn+04Iml5PFqR8oeEcNRKr3ntMX7?=
 =?us-ascii?Q?VqFUfnqsBPqMMqNe0RDnezQWG7BpZhHK75U3M2fNVUKLTCrYji1erXBttLGN?=
 =?us-ascii?Q?gOflG864SMXBaokO6IYlAwd3vAKFfZPAdPhliF2QyV/ZwMNgXzyHl0YHUOuf?=
 =?us-ascii?Q?MYGGoT5aMd+yHQZFxxrJiLZ1Kh/jS6A5mLynHeltXjASqLl0l4gU7hvOYtd7?=
 =?us-ascii?Q?oAfTq4jrU4gT2b52VcyJbEfi2cFm5BfDSdXv+A/fZPnBUGQTeSwGmrnHs8lm?=
 =?us-ascii?Q?5FSdg3kxFxs6RF11rl/1Mw99iEJwMFfOVjA0gSD3zuxEFSb4MLvCxecZr4Qo?=
 =?us-ascii?Q?H5Gwb4d7Uddp72JwX09aSUpPa7T80u7XbvJ2URzmxUGngqysSYUJdkB+RoYS?=
 =?us-ascii?Q?r1GYqxCI9/UwTgVjWNVD8mW+Qs7dyZQjoT6ZxFZtSoaH90wPj8ML+yGvMqhX?=
 =?us-ascii?Q?iSw29homTPYn9jHpXprW0Yg1lK8BeX3ungEIiZICYFKwQ17Xn4apntLDDhvZ?=
 =?us-ascii?Q?Qf0woIB6AArmQKL+Qx9LxEq8LSRU78ULxoIsN/gAVsGg14hZYHH5B9Haj7hb?=
 =?us-ascii?Q?4NQFQLwUCJ/IWQJGlGrdBpgZyecBrWSVVPs9i5kmxTvHbt1C6D6wWzBe3PGz?=
 =?us-ascii?Q?ioNVCMusDlgI7suIY0zz92PPVM+wnMcugsO3K0icB+Uae42eZJuuITHV8LJU?=
 =?us-ascii?Q?WatZ7iu8aQvxZelcPcyKcJpgsTkOY2kUKDmv8tZOaQOVn5pVPg0pRQy11Wrj?=
 =?us-ascii?Q?dRTw4EtNLdiRTLAAz+TPu3CbZT3vpLxdG5XGpk+9mU+jAOkbRFSZQRxpxczE?=
 =?us-ascii?Q?SdOq3pd1CkMAgrtUlsUj5RKIaFMUQAXtRgnKZIPVqqDFN2Xiw8JdagOfwiNC?=
 =?us-ascii?Q?FtyEz+COOXc3eRzhz6SaWec30EeJ4iKCT26DWzgknAl9ncupxzw5lTmCYlG0?=
 =?us-ascii?Q?Y+gwxlz4lRQt2DDDnPyty70wZ8wwHMWUoWTQr0gNdBHDqi3Hv3oZF7d3zqNI?=
 =?us-ascii?Q?TEc7caQc82AzMHWilhT/E3MEhFFC77FnjmZzJdfmhOX0GVOJ/088KCtp2UcY?=
 =?us-ascii?Q?SOVCFNYqYMG3LeF3ZJpNuWSI/ZehEvbZsKGLQyQUGEGcJT5rD/Ti2XVPRjf6?=
 =?us-ascii?Q?8RV+koxzEG50Hq7r2Pa1IOfROtdA08AQ2hrJoAeCCinxvF/zLKzMBF4qSG39?=
 =?us-ascii?Q?Lu3+lo358zV6lGfBxZA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0c1046-1e15-42b8-2d9d-08db30d30e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 03:58:43.9389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mdit6+U3RZ43z6jGC1J7kdy24oFjmX9PNQHq0qVlwvAE8IMM4WDuIYP31PDBY5VZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Liu01,
 Tong \(Esther\)" <Tong.Liu01@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please update the patch headers for the series with the prefix "drm/amd/pm"=
 to align with other power changes.
With that fixed, the series is reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> -----Original Message-----
> From: Tong Liu01 <Tong.Liu01@amd.com>
> Sent: Thursday, March 30, 2023 11:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace
> <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang,
> Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu,
> Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: enable sysfs node vclk1 and dclk1 for
> NV3X
>=20
> Enable node pp_dpm_vclk1 and pp_dpm_dclk1 for gc11.0.2 and gc11.0.3
>=20
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index d8b9c6136fc0..e011041e3ec6 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2125,7 +2125,9 @@ static int default_attr_update(struct
> amdgpu_device *adev, struct amdgpu_device_
>  			*states =3D ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_dpm_vclk1)) {
>  		if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
> -			   gc_ver =3D=3D IP_VERSION(10, 3, 0)) && adev-
> >vcn.num_vcn_inst >=3D 2))
> +			   gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
> +			   gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
> +			   gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev-
> >vcn.num_vcn_inst >=3D 2))
>  			*states =3D ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>  		if (!(gc_ver =3D=3D IP_VERSION(10, 3, 1) || @@ -2137,7 +2139,9
> @@ static int default_attr_update(struct amdgpu_device *adev, struct
> amdgpu_device_
>  			*states =3D ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_dpm_dclk1)) {
>  		if (!((gc_ver =3D=3D IP_VERSION(10, 3, 1) ||
> -			   gc_ver =3D=3D IP_VERSION(10, 3, 0)) && adev-
> >vcn.num_vcn_inst >=3D 2))
> +			   gc_ver =3D=3D IP_VERSION(10, 3, 0) ||
> +			   gc_ver =3D=3D IP_VERSION(11, 0, 2) ||
> +			   gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev-
> >vcn.num_vcn_inst >=3D 2))
>  			*states =3D ATTR_STATE_UNSUPPORTED;
>  	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>  		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) =3D=3D
> -EOPNOTSUPP)
> --
> 2.34.1
