Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD7BC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 23:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6F910E98F;
	Thu,  6 Feb 2025 23:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yh1i5dGc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA0A10E98F
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 23:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKr1K4TmhSbzx8Pu3UJl8jkHFdFok2tHfh8SelrlJn9ty5NO1FdfG6Vkzwpxot8XBdQ2oTiRTZU4T7rKz+YFu9u4nUcBKRfMCk1em5BSszfSUY+YUtN/4jEGrasLRSVgijfuGO1gufNKh/wljzBpYpHMdAJ/esnOYE85dzWEwJ2cdLR80kjAZU6/ivHxJbr2LV/jLx3QBX0I3G9Jgh4tzdhl6oGUS+l4K/wXBhtQQejeoEKAzRhchUDPJdKGFpFDx0sAfOPBOEU6KWFWrSHlV44pX9x+UBT/+G1q2/fORoOPmZoMassZVXnxov3P8SIc33itEpMujl5R0xvT18DWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fJWdGQe5uJkl8xG8hno1cx/LQGKTYa67342QIp7HBM=;
 b=dTIWNtlncNYAjikn8amVGVKi60lkDVsIvx0wO1haaDIqeoWTV0u4s/aZbKgXg8pkbOy+mwBZUZ/P5gJdXSneeZKF88mmJElQHIS2Y9e25oEJIYxsLgjWdnwag/gi4Iv7K/YpDCJbhHYSP0w/1CbnR646H3IRsGy1jh1KO3PTafotqayT34dfJbz8XelTKoPDKCSQJULfaks/Jkdq7F3FvI+67ZnavEuMEx6rtqlUU4CrlB46m80RriDcpbU2rqrK6OGS+Z01/FmclrX+bT25B661e/IIm1ok08C9UxXprZlwZ4453hI503CJH+i3PFZ+zHrL2TPrEmIkadPWsWg3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fJWdGQe5uJkl8xG8hno1cx/LQGKTYa67342QIp7HBM=;
 b=yh1i5dGcDSS4OXz7oCd3+1/gkHBv9a0sHt8i6NX8pBXri1xkpFfFJ/eHdFXqDQ8UKAO7m/+CZ6KHE6lZkj0XbRFqLERxHAOOSwtzlmNgArFp3spEG6B9IeVSyIOzEK/+HMhwTv0/VgSOV+WZ43vq3SnbOowg9VAJciZMAm0u9iQ=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Thu, 6 Feb 2025 23:26:26 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 23:26:25 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
Thread-Topic: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
Thread-Index: AQHbeJjqEAQYK3gZHESFnP5YTVHCkbM66RyQ
Date: Thu, 6 Feb 2025 23:26:25 +0000
Message-ID: <CY8PR12MB74358ACE4AA9BA563D3219E985F62@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-2-lijo.lazar@amd.com>
In-Reply-To: <20250206131258.1970391-2-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=b3990443-0f35-4d2d-ad8a-3b1ac1939072;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-06T23:25:44Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DM4PR12MB6472:EE_
x-ms-office365-filtering-correlation-id: e326ccfa-b153-482d-1c27-08dd4705accb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?g8Va2LwlDXAWT93oYCVRSqyhP5RkddQW7GkLcr+VUCfLmRivgja8t0ZVTRze?=
 =?us-ascii?Q?mkcHYwqaCH5HMeLSG4T3/+wo2w0bfkv9IYeXzH8w1p6gEhmcz+zSOfIavbbL?=
 =?us-ascii?Q?SGn6HBxpK6jv6HJ/aFrkFZwepmi/ETnkurnrJ9bw/xZfJTN6Oz5j5ynYb5/f?=
 =?us-ascii?Q?+wXZ6KF3nPJi93Gf0sZQfIC8E0i3/5kmHgJVFpDVJavEZuSyWxsfjELguttV?=
 =?us-ascii?Q?ggeVGu4xg1gIqosPLjJ7qizXl8t02OpRSUZ/qamQESKau1zaaavDuOdvAT0L?=
 =?us-ascii?Q?bLsopMZkeNlZZ5Gqd5NYdTldJ7W9GoFxO6zL2FRiveGy2LtrZKLibMD5Sdp0?=
 =?us-ascii?Q?k4Qj2aWJu3WSEJQeGwr/e6P7b0MFMDP7McpovrAYgBpxFWszoog9ainBurX1?=
 =?us-ascii?Q?qRQTfTAwmN4/HffWNlajOskwdzKYJ1bCYyK7uixjs5lh5A1qnSv1uCkey4vm?=
 =?us-ascii?Q?bodI6z94U+BDYETXbc7Ucb69qjeoyWP0Q+Esju9qooDAB2vXbEB4B9MAoykZ?=
 =?us-ascii?Q?V+/Ae4vzvSDgcT7Ds4GFU9tjfMpRCDr+xfgcpzXjlTxPPfxA/3yd3xyHYBxB?=
 =?us-ascii?Q?PR6XsL+WwcehUNMInMVcc4ayKdXXIaot142XfrF+yk/z8woQ1PQKJ2NW5GPp?=
 =?us-ascii?Q?K3lHTtglUobxRrmvCz8tB2jXcX6Tt9l4y59UVyqndqwcFK7d2j6eGlEcYn4S?=
 =?us-ascii?Q?VL13+Z2MlDXDcWaW3AOscqLQ8inl5RxrQ+tpIzsiUBdOF7Q6iLvpACYEZibR?=
 =?us-ascii?Q?ATeSM0Jv2Tr62BeszDtETDaJmV/nrBZHR39oup9Apa+Dg/nkejY7zXroTj9v?=
 =?us-ascii?Q?or6dJ+CeEggk1LQ5koU5BQ0REegtWGtILRO4m3hpyCqnNiGM6xRktThY+KFb?=
 =?us-ascii?Q?9WeBtjczzlGvbCy8MZQuDGmsLbTO+XYJBRZI9W8iuS/EJjk2nTcjBpno0vRo?=
 =?us-ascii?Q?W9XRbdBXKga6xT+nmNM03gVtnzbgmer8MaJGNeh9gUansIirsf/lb0anRc86?=
 =?us-ascii?Q?qamPjOSzX/Pq1Np9SDUHp4OtcUmT02s4QVx5jxNiIC1fn/EELo/qOc8shRUm?=
 =?us-ascii?Q?xtrBHYtPEZ3D8AByd8ls3yu0p229Ij3XpXouA/e+AO++qWjHJAdz4+owwLS7?=
 =?us-ascii?Q?cXy0YL2jRVLa7LWb0Igaw1DX9d5/CcRVIyf3vathTrPVlS/tt9fxU3ZEjjKa?=
 =?us-ascii?Q?ouDL1fFKsqlOafQ613XxyyrGnWdUtIRyO9B/487ZVpDlOloA9J+QetNwU1Ga?=
 =?us-ascii?Q?B3KF+OzJ7d3CqkPy5hSn3LMWobEWD3Xd/Q0ZKsP7cpk7BM890mslPYKhj1bz?=
 =?us-ascii?Q?lI5qYDZdJjbsiXbXYTf+JejK29Rk/ew2EZAInhjFq5EaV86/A2YzQ7JZa5qH?=
 =?us-ascii?Q?lCM04ivRWWWZZDCO5FK+BE15j4wBAs+4i/5Cuev7tNMh8dwO8zb/PiqRCcn1?=
 =?us-ascii?Q?EiaRJlqOXo/FLDjfN/nV2Sg6yeXuK+DM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Bn8FLT62+jkG1uaBc00tUJ96SkhHS4yQUnLegd4ICSlZaqQKYRev0wc/6RZ?=
 =?us-ascii?Q?okZPYgaaHHpsdKh6vevuzJxrOE3CzGgFqkiZUfYXXr1CKjJCoEAEOrZX3W1Q?=
 =?us-ascii?Q?AXMWC/H8aaxVPzjNFUKwnKxj09tpbwnms6l8bSE9yAmRoaXSKd2U4vZbCb7V?=
 =?us-ascii?Q?KoF7h9n0fwKZcAQkmbtjBKmf4OvYv+FGpUn0FjYVm98CrKNkuY8Ic3sjWzKM?=
 =?us-ascii?Q?i1rJ75NhYLVVPQg1BrtgONmARG1ukKMZaWha6Qp7/vjehsb+hXgVOVT2I1PQ?=
 =?us-ascii?Q?FLyv1JBPR2cE5zRugIT8qv8Waa70s1YJ8Mw8mfO03LGh49+uhvMhCbJ6hzPU?=
 =?us-ascii?Q?eaFAB9TPEUrWpk4MQvX7OKdLV6caF25su0IBfdzcJ3Ide55AgURXweSa8YUD?=
 =?us-ascii?Q?Eq9/R9i358UNu5RIvePV2MXw5W9RMsJ9GJ8uEWFM5zZQkHYxr5M09Vj9pVBH?=
 =?us-ascii?Q?YyFfkBAx+NQfMZBYvGMNyOruk4Tt0xNPiIoAhu76WjIMhSon2z3r0MeiDMbJ?=
 =?us-ascii?Q?L3ggLasoz1tofy6Oz8Mn10l4lOJBZH6UZkz3JpV7TtJIAb9HRcwDO1ikHOmD?=
 =?us-ascii?Q?A7hwJTphMtw9VKHUJfDUcxHBRb1MSo9zBLXnuJ1xfJw13xjeRiGrbkomK0Vc?=
 =?us-ascii?Q?8G70h3QoHNuVja0jzpoMQpiGcxWbxFj3Iu6OT4BDBJkhgAF+mrZAyk4GJUR/?=
 =?us-ascii?Q?85gmq52yugk8leJuNMat8SY9IH3om6wodhCt/lXh8XL/kO0/gAhtwod/Wtkh?=
 =?us-ascii?Q?WPPWaJyDOE3ZYVaRESxQItTXnWcN8JOWPSFJnGn7NdqmZqPurjRT4mGclZd9?=
 =?us-ascii?Q?za5TQ5yehiX3kKIKPUvRkcNllZb+K/L1+BIlSjuVXGN2dudKQBt/9EumaW4H?=
 =?us-ascii?Q?ycZrxIFhZCUZy5oPhb3nEbaq5HSOetW/goJ0xwbxx4al4l7f7cnSqEoZizb9?=
 =?us-ascii?Q?vI9qNWelB1db4gNDpU4w4I7tLFjIsDU6d0xrX4CPr+Nj6TN0uccEUqkq0F2s?=
 =?us-ascii?Q?vfG3V0JO5NUYPfMD+VL/NIRez7PLi66QFXopQjSKrl5M9UKduP/5gUF5F+Im?=
 =?us-ascii?Q?H6njhLCZzrKjB5Fmv4N+LvOsjgQoxdE2RbUpWU3gxw6zGUTzDc5mUomkYbUU?=
 =?us-ascii?Q?HDuTqN0eDPotsuz9zKyBfO59SISF46IL5gWkIHAbiQVbMBmcXcxrOPPRy7ck?=
 =?us-ascii?Q?yu5yXxh6rNB7/N+3+icpkD23AOFYEd0+3dzbLyg9n9Q3S5hW/PXes1NN+31o?=
 =?us-ascii?Q?yBI9GAozAI5+61Nzb5RMgcLBq8hwuQjqsXPE03H5+zakYOWU7xgzx74ItIvO?=
 =?us-ascii?Q?tC7xRH4BisNee9f9PJ25sxDxgpzqnKqqGDw90wqVzTaG80QasM95wD2gVAEu?=
 =?us-ascii?Q?126w1rG0CG69qzzpd/kCL2nd0ZbHaGvJgKdUKREncXLt1oSePUQJxdl8y7UV?=
 =?us-ascii?Q?PMhzLO5/ko+odTZpApdlJB4L3eQcIyOFEwohEWl9BW+UaVKF8FyEie3KpnJK?=
 =?us-ascii?Q?jMsdXhrwW7SQ6wRukem/ovrdyB+bstIuIobSl4nYvknXs6tJ5uh0fGL66tFM?=
 =?us-ascii?Q?AGn5wjVTRpzk5qqyJBk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e326ccfa-b153-482d-1c27-08dd4705accb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 23:26:25.5840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtYjvGchwm1z8sN4H4YtOlB1RY/N6QbWB/SAgYp9vz+20q5hsCYopayqtgeJ89Js
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, February 6, 2025 8:13 AM
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>
> Subject: [PATCH 2/4] drm/amdgpu: Add xgmi speed/width related info
>
> Add APIs to initialize XGMI speed, width details and get to max
> bandwidth supported. It is assumed that a device only supports same
> generation of XGMI links with uniform width.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 41 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 11 +++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 03d909c7b14b..edef5763e2b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1679,3 +1679,44 @@ bool amdgpu_xgmi_same_hive(struct amdgpu_device
> *adev,
>               adev->gmc.xgmi.hive_id &&
>               adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi.hive_id);
>  }
> +
> +static inline uint32_t
> +__amdgpu_xgmi_get_max_bandwidth(uint8_t link_width,
> +                             enum amdgpu_xgmi_link_speed max_speed)
> +{
> +     /* Returns unidirectional bandwidth in Mbps */
> +     return max_speed * 1000 * link_width;

Instead of wrapping this in a new static, would it work to declare a new me=
mber adev->gmc.xgmi.max_bandwidth?
Then in amdgpu_xgmi_init_info, you can define max_bandwidth directly after =
the switch.

> +}
> +
> +/**
> + * amdgpu_xgmi_get_max_bandwidth - Get max possible bandwidth of a singl=
e
> XGMI
> + * link of the device in Mbps
> + * @adev: Target device.
> + *
> + * Gets the max possible bandwidth of a single XGMI link of the device i=
n Mbps.
> + * Assumption is all links of the device have the same width and are of =
the
> + * same XGMI generation.
> + */
> +uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev)
> +{
> +     if (!adev->gmc.xgmi.supported)
> +             return 0;
> +
> +     return __amdgpu_xgmi_get_max_bandwidth(adev->gmc.xgmi.max_width,
> adev->gmc.xgmi.max_speed);

If you do the suggested above, both tests can be simplified into 1 line as
-> return =3D xgmi_supported ? max_bandwidth : 0;

> +}
> +
> +void amdgpu_xgmi_init_info(struct amdgpu_device *adev)
> +{
> +     switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
> +     case IP_VERSION(6, 1, 0):
> +             adev->gmc.xgmi.max_speed =3D XGMI2_5_SPEED_GT;
> +             adev->gmc.xgmi.max_width =3D 16;
> +             break;
> +     case IP_VERSION(6, 4, 0):
> +             adev->gmc.xgmi.max_speed =3D XGMI3_SPEED_GT;
> +             adev->gmc.xgmi.max_width =3D 16;
> +             break;
> +     default:
> +             break;
> +     }
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 044c4f6be44a..384c4ddef78a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -25,6 +25,12 @@
>  #include <drm/task_barrier.h>
>  #include "amdgpu_ras.h"
>
> +enum amdgpu_xgmi_link_speed {
> +     XGMI2_SPEED_GT =3D 16,
> +     XGMI2_5_SPEED_GT =3D 25,
> +     XGMI3_SPEED_GT =3D 32

Why not declare and define them as units of Mbps to begin with so you don't=
 have to do the calculation later?

Jon

> +};
> +
>  struct amdgpu_hive_info {
>       struct kobject kobj;
>       uint64_t hive_id;
> @@ -75,6 +81,8 @@ struct amdgpu_xgmi {
>       struct ras_common_if *ras_if;
>       bool connected_to_cpu;
>       struct amdgpu_xgmi_ras *ras;
> +     enum amdgpu_xgmi_link_speed max_speed;
> +     uint8_t max_width;
>  };
>
>  struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev=
);
> @@ -102,4 +110,7 @@ int amdgpu_xgmi_request_nps_change(struct
> amdgpu_device *adev,
>  int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev,
>                               int global_link_num);
>
> +void amdgpu_xgmi_init_info(struct amdgpu_device *adev);
> +uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
> +
>  #endif
> --
> 2.25.1

