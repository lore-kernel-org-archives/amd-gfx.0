Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4A9C6FA82
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 01:23:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722C710E2A9;
	Mon,  5 Sep 2022 01:23:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A706310E2B1
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 01:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeHU9qeB7sltUOuvRqbESSvdb4xsDqbM2ChEsMrWZ19WnuW4CHyShvAwEYA5rg74h8pKcDMOhgyQ9zUXm3AKhKk8uAyF0zAXrQTBgIodIZYU4z/qLAHasDy7Vj7LEa95Qs3dYQp93zqYs9nyXTWZvNTX4yWMD7Yw73Mr06RsZ8ZMBfFNirVEdDKinZqN74X7U+jcrdWhIDW4V3xRJeZNF4ZpFEYqVcEwVlCcIN4RhG4yUDSjHHg/qBPLUwlbX0zEQPtt3eD4XxvSQkQqqzhqd8MXtgw7IShOjdQdwjbLbAz74igiVdPL7wSVeT+RHz6bPvFffxzyQE4AersXBKYs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5CNPyFaOmVWf6/zNc0EodLB5IL7f+OBItvqZhlIRq5o=;
 b=JE4aAEWW2vmCDs/JBZrdr/MtuCYHUL8jaG1ZPC5YEy9kyCgrBcW34O2s95anN8ckxGW16BnMJEOYbY0Vh6Y+c/laA/24CqoDvQ3WoYeGFRSh6ra01/bQZeFS7MNUxYYj3gX+yauu6umKJV634BOaie2ZwJMADr1RGV1HDNNeebwabJbwO/O+LNIqStLhGFxzOZYauhp/FKsUX28sn2SwjMm/0JDdIxJeQJFT/BTyQcAHGUvk2QfkAD6iOTY1jngfGhLWA/TQ7VpIheFr4iqiNqo02hTtLu1vQIAHDdlgcKbcMyckqLNlTrqwFcHr9viVHoc/k1u4vUUXbTVJbni/vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5CNPyFaOmVWf6/zNc0EodLB5IL7f+OBItvqZhlIRq5o=;
 b=yl01oUIOml/5CDCRomCvmCpiPTIDHR3dk29D/6qFZK0V4Sss5Idf4QnSLyQtmn6tnPrpwwWIwcKknVFQWGpLiKK0ye96J3jFP0HCP0pusLAqaWOMfzaIrjY7nk+obeye7EjefsnIXTwgLsWHdjpenqPD0IPqdyNJ6yRa0LxxBT4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 01:23:34 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::f00d:d41d:a454:1f6b]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::f00d:d41d:a454:1f6b%4]) with mapi id 15.20.5588.015; Mon, 5 Sep 2022
 01:23:34 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Topic: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Index: AQHYvdTSZDAs90JRMEuRDXESgfow663LLOoAgAAyX4CAAAwyAIAEo3jw
Date: Mon, 5 Sep 2022 01:23:33 +0000
Message-ID: <DS7PR12MB60058FACB01936A5DA2030AEFB7F9@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20220901072959.4085193-1-yifan1.zhang@amd.com>
 <BY5PR12MB387318D60C341DE66211E724F67B9@BY5PR12MB3873.namprd12.prod.outlook.com>
 <DM4PR12MB5248CC7BFD66675461C8C84BF07A9@DM4PR12MB5248.namprd12.prod.outlook.com>
 <CY5PR12MB6369CE86D66FA5010B56589EC17A9@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369CE86D66FA5010B56589EC17A9@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-02T01:43:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=64ec50d8-0469-49d2-8aa1-29f13023105e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58912219-5091-47ef-1a89-08da8edd4003
x-ms-traffictypediagnostic: PH7PR12MB5736:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a11QZn3uTKOXAsCnUVhfC8UsULmmfT7XhHJvRNy4cwIsHf1piF89vWCPypKvL/UwYStwQ01TEQmmeul0tEidGhjGrqXaEbJRGbuzvHUvTNhT4z1O8H9ISumE5RP5bYouoNKp3lwagj3O4mh2R2ATWQyIakKhB3uNTOHjDAfi79ikRqS+Kaa9FsuOBiZiRqd99ebj82Hj79z+SIq6tUEEw9ZiNK2wLc3YVsZQitEg+f2wwvbDm98sfHOiQhxD1FkI8L4xqKvu+02m2JEBck0x631uE7mSk+efgGmVSFrY852uFpwSz1ERDgQzIkdt8Fi+lfrM027cV8KhynNuU/hd1hrKvd36EhsXbY4PIhLzhqbzH/FqVmlVjUVfwgE12QaDaQ0YdJ6Wy2Sy+q94FdkmfSklKBsPn8XJVu5dPpAGeJEorZfbgNkbmxHwfprTCSMYHn4COl4FSShDKy4tPiqNdwhslg6PXLpKAMTu5QCn9NO6wL9G0DotqV+Le5fp7/+16jRQxcxvNx/jtBkIHAoLo7U6njDIdwyWwBHjywmGaQBqMHlQ7th/B9WXbP1l8dMT2OxAGz1qa1L4H24dD0/h8fO8HVszQy/R3Bn6VdT1Lg6ZFqOnDk7L0UrL+y+TU534vTdTC0znYMfwmFjanS9oOfr7M9A+SOAlLEBuF7b4IjjpFclaJ7iBikt7K22sRyX7eO4MpE8f1zWr+KEBaf+aq/LcowRILDNTBtg5PRp98J7ON3cjV2KGNStHKJRBWBNCbKi1yGVL1Nh8VKI2m121+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(83380400001)(316002)(26005)(6506007)(7696005)(53546011)(110136005)(9686003)(54906003)(478600001)(55016003)(38070700005)(8936002)(33656002)(5660300002)(52536014)(2906002)(86362001)(4326008)(66476007)(66446008)(64756008)(76116006)(8676002)(66946007)(66556008)(122000001)(41300700001)(186003)(71200400001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oMFBecnsrkLJQ/TqkmTWnVlU4mvU3d1au3eE8t+bHXKFqqs8RB7E+ySlTv8M?=
 =?us-ascii?Q?ndcdVsBfRtpjvXm9Oi2gidN4ZgKm42qgNB3qvzxoAg7zSw+DzYgtygz3tnFZ?=
 =?us-ascii?Q?ftMX0h6tq+/S57+p9PISogbjQ9o15J7c6LrKBPv47V+yt1uURVFeZhai6raf?=
 =?us-ascii?Q?/+5DhymL7Nv4iVHBwnm2KCd609lqe/Ow+W9JW5ZDodKIvRVvidstyH9faTv/?=
 =?us-ascii?Q?do1YpE0y5KbqQ9UgUCeR/3euui1KlClE/VAELcB0SZIN7KJLd5vuUiyNpIEt?=
 =?us-ascii?Q?H5xxGwKdjwrn+nrES1FVcaU8tmVmFn4SxexdWSVoHZPlVJRy+Q5gWHUUkDDr?=
 =?us-ascii?Q?38yqHJBA5/R6u0a+Rvmc4EdUuxQTbSaHKKA2DuKxCPzbZqoohL4yretrxaRp?=
 =?us-ascii?Q?S7FC6qaLE95XoU5KkYCDM8ClHSqdmYktn2/Uz+xvwIHotacxTAV2WOH+jICx?=
 =?us-ascii?Q?lg1TW2jowmRtGik0FKR9OaKi9YyYGvZs4sjrkGRZ9w2AarkAy0QlzhMhyOlU?=
 =?us-ascii?Q?Z0ByhK3J01KMyZOXGD2GIvPRRNUmu1NfHho+5MGy6hpL2SPX2N+HDLtPRK0b?=
 =?us-ascii?Q?gv7fucNhVox3YOg3Mi8Vd/Nu5L101QSquIdHAgB/BTdN/ogCvIwqJTJwrh53?=
 =?us-ascii?Q?jPlHYdBR4A4546vyWBIK6xW/qRiZcUgfV2mJrtZWPLZfXhacEvcwFGZ+bix7?=
 =?us-ascii?Q?aZRiA1Us2s9m7TkZN437oGXfWw1FzN514VTIQIZ1i/kPCK3ZOWeYcPXW83br?=
 =?us-ascii?Q?AgOzAqytwcqHjv6XWOiAde0XYY5sHu0FF3qrXKXEiLQl3BKtJTJFl8mzg1Ym?=
 =?us-ascii?Q?E7qFDWfz58Em5K17AzCE24axmaJIHT/vN/T4PYrEyUvmnPP5b8kOrDNI8lnD?=
 =?us-ascii?Q?h5OTRtdVv+Haub/MAHYyf7iH7+ElM2Q93VrRmiXF3ypz9RpCoqC/21QojfQ/?=
 =?us-ascii?Q?mlVkKcj8sIKuQso5Be1H1Ue3n6OsCaQAg1ZF4fGEkiq6S/2q0EBQX11H7Zdi?=
 =?us-ascii?Q?Mu/ZiEx3XX8/AplhG3utifp8bbf5aAiF0FMdBt9izpdOBJTNohGUQxHnG6tD?=
 =?us-ascii?Q?g0jkc06SIRpxzAusdKdR11lvd/uFIpuZZWsS8kFIyVavOc5OJVvW7RtobBPO?=
 =?us-ascii?Q?c4RcdWhqRC9FOXAqK0FkS0RhgZavlZQtBT5uAZZ+J6nxv+Xvh5J8ehZXrY0c?=
 =?us-ascii?Q?Xmzw1jKrjCnsyQJjQJaluOTyZuIwdXSjD4dLnFcM7bEsCGydmA6rHW99Q1gn?=
 =?us-ascii?Q?AeGaEXyGJ+hCQtGmPnR/j/T0dT5c4CU65DP94YP9q8fyhy/284zFFCYSseZl?=
 =?us-ascii?Q?bNZ1tvM46PuMXqIYA1Dydthom+u1jGTGYc4bC4gklGTXEIizHH23XyaoEl6o?=
 =?us-ascii?Q?D3MBs9O6YjmPaWC0+n4cxsiX5RCl0xcXCFBr9kDncNVbPluNDUPowIx5d9AI?=
 =?us-ascii?Q?tl+P0QK56GIzkBjxXs5fReL+GF3OM4eX2aoEP5fVMn5tNhNv/QMbe6NiUOZQ?=
 =?us-ascii?Q?wksDLZrInfv9xmnGoyWN96DUfW7GYJIZ9YZFceK1vqTDopIw7IpaoKCfewQR?=
 =?us-ascii?Q?UnF+u8WJ1i1h6Fijhgg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58912219-5091-47ef-1a89-08da8edd4003
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 01:23:33.8739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9zm2YxP5hjsmZ8c1nbE9jIdBrKvim0i8QS3ECekJLQUF+TZJVV4fT5lkinFqIJy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

How about add a dummy cache info for the NPI product in the default case an=
d notify user that's using the dummy cache configuration to make sure not m=
iss correcting the HW info in the future?=20


Regards,
--Prike

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Y=
ifan
Sent: Friday, September 2, 2022 10:28 AM
To: Liu, Aaron <Aaron.Liu@amd.com>; Huang, Tim <Tim.Huang@amd.com>; amd-gfx=
@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

[Public]

Hi Aaron,

Yes, the cache info are different. But this diff is intentional to workarou=
nd the discovery table lacks cache info in GC 11.0.1 issue. The workaround =
will be removed after discovery table finishes integrating cache info. Give=
n they already have a test version, we can pend this patch until they finis=
h integration.

Best Regards,
Yifan

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com>
Sent: Friday, September 2, 2022 9:44 AM
To: Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; am=
d-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

[Public]

Hi Yifan,

Yellow carp's cache info cannot be duplicated to GC_11_0_1.

Different point to GC_11_0_1:
TCP L1  Cache size is 32    =20
GL1 Data Cache size per SA is 256

Others looks good to me=20

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Huang, Tim
> Sent: Friday, September 2, 2022 6:44 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian=20
> <Xiaojian.Du@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow=20
> carp
>=20
> [Public]
>=20
> [Public]
>=20
> Reviewed-by: Tim Huang <Tim.Huang@amd.com>
>=20
> Best Regards,
> Tim Huang
>=20
>=20
>=20
> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, September 1, 2022 3:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim=20
> <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan=20
> <Yifan1.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
>=20
> Current discovery table doesn't have cache info for GC 11.0.1, thus=20
> can't be parsed like other GC 11, this patch to match GC 11.0.1 cache=20
> info to yellow carp
>=20
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 24b414cff3ec..1c500bfb0b28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1516,11 +1516,11 @@ static int kfd_fill_gpu_cache_info(struct=20
> kfd_dev *kdev,
>                 case IP_VERSION(10, 3, 3):
>                 case IP_VERSION(10, 3, 6): /* TODO: Double check these=20
> on production silicon */
>                 case IP_VERSION(10, 3, 7): /* TODO: Double check these=20
> on production silicon */
> +               case IP_VERSION(11, 0, 1): /* TODO: Double check these=20
> +on production silicon */
>                         pcache_info =3D yellow_carp_cache_info;
>                         num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cac=
he_info);
>                         break;
>                 case IP_VERSION(11, 0, 0):
> -               case IP_VERSION(11, 0, 1):
>                 case IP_VERSION(11, 0, 2):
>                 case IP_VERSION(11, 0, 3):
>                         pcache_info =3D cache_info;
> --
> 2.37.1
