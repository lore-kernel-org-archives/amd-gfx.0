Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952F9CF64A2
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 08:07:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3657810E70B;
	Thu, 20 Nov 2025 08:07:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gl92ICYj";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC6E10E70B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 08:07:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvxDTIQCAzK/w6fSoaKJz25IYmpkMa6bWebn0BaYyCHx5e39G+/hr85maVnBidMLWHK5yOAbSOYj7l8PrPuah2P1jcGXNG/6PS4BLzp8oaTp3LICbOz/GEvREDLpp7ZRN5RQCcwMy4uUuRKuVsopMPEe8RtsZnd+WvoDpGjJFo3x6OYL1SFljb6d6YVhabteIoja6IUJ2/NEGkvpbfs4l4RMRC5j6GPpZamfHTBYbBBjNwuNUEP+7/LlwIqL9xvX/fpLRbZnF3XAZI5cAgfDhpOeK0J6xgSZgW6xLMFicygrivjVSKsSboHTDS+s6vn2EjKaX6iKiIMuEASke8AYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEUbetwVAnj0wouuPunJxhu9WhaBvWjKEXF+8GeShuw=;
 b=O+4TuJ9+pTCI7lpL8VXkF3rei3mYM72azTjy8loeJfufQQZCFqjtMyt63eKXI1gsVC0ed/FfbXHw3enHGps0kcHo9WrDql5bn6OmVBd2sudNzneWzas/qHhl0Kq2kJdEcP0hULBjMbL1GI52YmJh8WFkhn0uG94+8sONQMHx8EPzPx8Qzear+3RxuhPplljWzaLfLgEbdndOMFTVjttMnoG9vyQU/Vre1N58kgTOGLdnZOXYW/tuFWp++oi3zTZQR7uqncKGsyVm4KW2YPTkiXSZjBMO1+fYW8omT0fnKLS2hQTr+1OqNGW5btAg8IJMCfy8B+e6D5X80NTgFGXNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEUbetwVAnj0wouuPunJxhu9WhaBvWjKEXF+8GeShuw=;
 b=gl92ICYjpMHtFJQnyikbSVz9LbHN3QbGvUqQrpXI0MB5ht9TDKl2w9p01oB8ug8by2n6BG5x47GTRRXs6mA/xDue8C6yFM5JXaNtRwo05yhw4KPsz11tTkJ6hvsk16dMooxiNjo7gxBNErgQ4kwYPYB/cn3h4zDm1tkLGfWIKto=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:07:53 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 08:07:53 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
Thread-Topic: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
Thread-Index: AQHcSTryCZvdQDmGk0GlNyL+I1sFP7T7Pr6QgAAQxwCAAACHcA==
Date: Thu, 20 Nov 2025 08:07:53 +0000
Message-ID: <PH7PR12MB5997D81F138BDA8E645326CE82D4A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251030011651.1433120-1-kevinyang.wang@amd.com>
 <DM4PR12MB6012F6F0A577D1D47A950B9082D4A@DM4PR12MB6012.namprd12.prod.outlook.com>
 <2775ac42-de6d-40c8-ac72-5e3070529d3e@amd.com>
In-Reply-To: <2775ac42-de6d-40c8-ac72-5e3070529d3e@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-20T07:42:43.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SN7PR12MB7980:EE_
x-ms-office365-filtering-correlation-id: bc8f9b10-d90e-43be-8ccf-08de280be81a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?foP6f4xGsEmbZh6FCgWJeH/HXxUwbz4dfGV0dJci2lIdJnkDSQaIuP4XPRyP?=
 =?us-ascii?Q?5rrYRods5zwYBBG4jL1xrgL65MHyK4JrB/u2S0+2CAjg3Geljz6utrFLfGRR?=
 =?us-ascii?Q?egVl+awxfTvHUziVGeCFE0NYdaPOWbUCOj1mHZfW+AkcB8KB4UlD4es8Nw6O?=
 =?us-ascii?Q?JIeec2STM1oj0g5QHrhw/EJkZbQI7eWPgdjAsxCfJVZyTkb1jMaxqpBbU+wZ?=
 =?us-ascii?Q?jaK5jQSdWYxN5JE60Mxenlj6W9omZvLGlAEXHOqnEmKrx153AA+hh7gBW1zP?=
 =?us-ascii?Q?VcN7WRFmZJnJh8H48PXku7WE2hPKUNhBoJ8o4ItIMcRv9KjaDd+ZxGwoqP4H?=
 =?us-ascii?Q?f6bvaiCWjxQl1uEuMwPssq01XTTAxfvcBiiv5u7K0g5XXuhC6mhBMZ9jQO3W?=
 =?us-ascii?Q?oS1/+mxr0pKO/lSYpkMgntFUQN7Tqb27gfvKEqwsrl3vdPyCZ88Scg3adDwW?=
 =?us-ascii?Q?FSIAJ89Fi2SS8iMbJ3kRFwtFKOXzW/AJaHEBKA7Xf4iF/jjmRXqgnTOtJ0c2?=
 =?us-ascii?Q?sJbrfHMVb5hCEwvcvsBfIzLMs+alUHoy55lAkRBo+5io472Z3DysLx3MkRyy?=
 =?us-ascii?Q?9guZSmMEHXW8PivbVQxP3dr5W4gusjJhKo6M6G4DyLZkZA/v/alV2XSiiPOj?=
 =?us-ascii?Q?WVWniAhPIFV3X2r8ociHKtFPIfyU5ETPoCaalupzphaMZgO+FJrJ5RpkbNVL?=
 =?us-ascii?Q?2EM2IGMx+uvhVV+BnUJJ4a4qv7CYTptCFfz5r4xEVZ6DQasZ1jujNGv6FXDL?=
 =?us-ascii?Q?K+f8WvWp91KNWoZm86VRCq3e+pf/r1yqbm9Dwg+D97dDimspHv4qkjMWRmZa?=
 =?us-ascii?Q?0naTPH8yX9yaDfRrlsydSDvPXMn9jshYwu4I0po7fBmJac94i8erOPKImIec?=
 =?us-ascii?Q?uaDMYJQWr6n0kIilWzvKgVZoaTu8NfdIceO6u5Nm0qYK85Yw1Of2A9EkAqKe?=
 =?us-ascii?Q?UEb4e3dYWsDPvcRLV6qnHLjACVcKeIp67rSFgunjldyksH0NtdZoImV1kYdN?=
 =?us-ascii?Q?RgxFUsqlYAYLherRySkWBa21oQjrpzhuIXXr9IBxx+lEwOHD1k2OlTmtn/RF?=
 =?us-ascii?Q?EselM3Hn17G2jQBGGv2ZR6OacyyTDuNKLseGHWdJr1A1EPvXrMlpoiX3OAuN?=
 =?us-ascii?Q?Dunv+5fzVpz1TPq7iZLDgQc2U7Jv9n2cUIHiPA1RyqxAUfortutWJYWZRPeE?=
 =?us-ascii?Q?163AaJnWXp6ezUf4HtmDrt6w+awPEIENGMC8thKnhkkj7Z2E2aY0Sz0dvIKP?=
 =?us-ascii?Q?LF3i0Ei5lr+ol7AAz66fbHDeFU89LT2yDPypGVrKVVUjB6+XUYL4A4ObPvIM?=
 =?us-ascii?Q?ax9+ccNKozClwH8GYqL5VEY9cYmOfP28jzf5cgZDUpkthV4lhb2xfYJufyEr?=
 =?us-ascii?Q?8hkWYbymY3kdUIrGWjszjVa0foRc/ZfwJ+89oo7TMqDwy3ehlj+RMkEC1sPo?=
 =?us-ascii?Q?2+3OKHBGQWjw69nBwytPC4nZ9LApnBmMtUH4+HHmKP5wWUqCGelgLsuZBqYh?=
 =?us-ascii?Q?54BmYG2mWAVuc2eI8lPixUalsp/FrN2lZ6/a?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P+M+A1o2uG6lFrP28qse7CksfwcMs40+VXdkw1by5NUuTqXTNNK7NqdL0sAw?=
 =?us-ascii?Q?1ZDo4ob3YuSGjnvJa1BEiyyhxLtCwwhkKhn5dLnc/Zb1qkMHBAVyDNECsc7k?=
 =?us-ascii?Q?/V2HMoI4tSn+6Uy4mI3PryS0Oe1VjGwYG6jkCy0LzMujtiWD8G3mfX7Zk7yI?=
 =?us-ascii?Q?0gahgYtwOyE3xQYMEpTXB9AuFFIUNkF4jZ0aPN7q0WbfIsdZ9w3X8gwFMce2?=
 =?us-ascii?Q?7dpwZC1DnpUihSzJTppTw7IbVRcEssOeu9I7/7Yvi+yE7PPt/7xWHChKuPT/?=
 =?us-ascii?Q?lW0TMAv4N8yi0t0dcLtCtcFjK9lSBG7IbR0paRqO5485Jh14dfwW0gi26W6J?=
 =?us-ascii?Q?NmDAUnbmgGTBxbUOQgNIgLKmYISNR3Gt3jVr/0b9iqK4YZEytM89PXDVQljs?=
 =?us-ascii?Q?aySg5c3fnbdnV0tIB3OJPJqJciUR8+nRfGQPbkQr3cPud2vSNve2iJYPy1o9?=
 =?us-ascii?Q?WcVrUX4TL+ZLrv4MkoEIu9SQtcqipiDtNJGcJ7tPMcrvmuQgM+hXs36QoWx7?=
 =?us-ascii?Q?CxHQs0eOpQxEzlipuyfF2mNQMIMHy4quWfbdDCdcalWhOWIEYrBvjZdOymDS?=
 =?us-ascii?Q?/nloESKeQ8gj2h4tUXBKQlxOMnDG72vXATzkCW0y5kTKWJ82xVirkQQ6zU9i?=
 =?us-ascii?Q?7BhE6sw2CjRY2u4Fb0aJsvHiU7Er6Ti3g0C7tnhI4oy3tvf5SuaM0FxuM8YP?=
 =?us-ascii?Q?mJBWK6NdpefAvg2kUvN1QgNmikxfQ2/uP3MFEpJzlH+XNjFJySUdTwF5TUZe?=
 =?us-ascii?Q?xKIp/5zrGMEWvfjBPhejH36GMjb8U3SxEGC4DAMVp289mgWuH4MoWA70Ns6Z?=
 =?us-ascii?Q?mv1U1SPzxvG4M19wCu8vM2Sqxs212/n37YS+4OS2ie4+TNPtbbs1dXSgXo8i?=
 =?us-ascii?Q?yhJ8bzdYQMdawCFmPn5l5+qDjqFkYxt+DNb8E9AunNOf4x/rAt8nL05e+Sli?=
 =?us-ascii?Q?0JHB1Jw5wkH+bYAMtDcYiivm1bbiyPgNMJDHXpJFsDf0IXBgtv6A9Kicy7Yw?=
 =?us-ascii?Q?RKVW0gJwPe6PjxuwPf8PCn1ysciIX8NIjt6BiEKpljfhNJS7XNVARxX3vJYc?=
 =?us-ascii?Q?TuPnZ78Pv0hLX5ZQVYv4l4+PbfFQvg3MQx4ZbCDp+govFGkALtoafopjOn/8?=
 =?us-ascii?Q?RApP2RHQwTI6v754XKSbJBIuu2GwRTJvGLjbfagIyzYMEjN9lQ/7frDQrNFC?=
 =?us-ascii?Q?o3QoK2VIqXUsvc/E9svSrPcNSq8iCVHBfoyW5PQdo0obHr03U6AYpgYOY3RC?=
 =?us-ascii?Q?TmUkJmXeyEqOROG7LS4/ZHwRmcnqjwMvZkhCGpOK9JAlRyC/bhC01NyP7WCh?=
 =?us-ascii?Q?F/w5T6UCGL6o5lyBgdf67HsVxfKBS9Ga0Pw77BbX6bXWxcH2hJxfvRFnw81/?=
 =?us-ascii?Q?O65QK/IxvfwepO6zub6qAQvDoq49Rt65bZquGHxYL2riiYyysslWo24uYkdm?=
 =?us-ascii?Q?Ep1cUAQaeCUasjZmCn3RE5gvZ3qDLaFj30o6Szb070Q5OpTBV8szz11zC1Hp?=
 =?us-ascii?Q?lIwMyklG+1IHjty04hirGIzW6uJjcwoC9AZZdQs0k5gKkcEIKc/8ODdFwIgY?=
 =?us-ascii?Q?aHaO7FuwgZCWxuMG8BY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8f9b10-d90e-43be-8ccf-08de280be81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2025 08:07:53.6785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXfPGnLU3WQKp3Do6nEevIerW+hPO3cvymauxcSSR6SFjxJ9fddMul6+i/zso7O5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980
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

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, November 20, 2025 15:41
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: Re: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs no=
de



On 11/20/2025 12:11 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping...
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang W=
ang
> Sent: Thursday, October 30, 2025 09:17
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>
> Subject: [PATCH] drm/amd/pm: adjust the visibility of pp_table sysfs node
>
> - make pp_table invisible on VF mode (only valid on BM)
> - make pp_table invisible on Mi* chips (Not supported)
> - make pp_table invisible if scpm feature is enabled.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/vvvvvdrm/am=
d/pm/amdgpu_pm.c
> index c83d69994380..3a14e0ff38ae 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2507,7 +2507,7 @@ static struct amdgpu_device_attr amdgpu_device_attr=
s[] =3D {
>          AMDGPU_DEVICE_ATTR_RO(pp_num_states,                            =
ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>          AMDGPU_DEVICE_ATTR_RO(pp_cur_state,                             =
ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
>          AMDGPU_DEVICE_ATTR_RW(pp_force_state,                           =
ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> -       AMDGPU_DEVICE_ATTR_RW(pp_table,                                 A=
TTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
> +       AMDGPU_DEVICE_ATTR_RW(pp_table,                                 A=
TTR_FLAG_BASIC),
>          AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,                              =
ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
>                                .attr_update =3D pp_dpm_clk_default_attr_u=
pdate),
>          AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,                              =
ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
> @@ -2639,6 +2639,21 @@ static int default_attr_update(struct amdgpu_devic=
e *adev, struct amdgpu_device_
>                  if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) =3D=
=3D
>                      -EOPNOTSUPP)
>                          *states =3D ATTR_STATE_UNSUPPORTED;
> +       } else if (DEVICE_ATTR_IS(pp_table)) {
> +               switch (gc_ver) {
> +               case IP_VERSION(9, 4, 3):
> +               case IP_VERSION(9, 4, 4):
> +               case IP_VERSION(9, 5, 0):
> +                       /* No PPTable support on Mi* chips */
> +                       *states =3D ATTR_STATE_UNSUPPORTED;
> +                       break;
> +               default:
> +                       if (adev->scpm_enabled)
> +                               *states =3D ATTR_STATE_UNSUPPORTED;
> +                       else
> +                               *states =3D ATTR_STATE_SUPPORTED;
> +                       break;
> +               }

What about using a dummy check with amdgpu_dpm_get_pp_table(adev, NULL)?

Thanks,
Lijo

[kevin]:

The linux amdgpu sysfs node provides both get and set capabilities. Therefo=
re, relying solely on the get function for speculative analysis may not be =
sufficiently rigorous.
Additionally, modifications must be implemented concurrently for the backen=
ds of both Powerplay and SWSMU.
this is purely a software logic-related adjustment and does not require low=
-level operations.

Best Regards,
Kevin

>          }
>
>          switch (gc_ver) {
> --
> 2.34.1
>

