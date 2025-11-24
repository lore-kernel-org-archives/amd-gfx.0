Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D052CFD313
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 17:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F27D10E249;
	Mon, 24 Nov 2025 17:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XTvAy4oD";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C8D10E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 17:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSXWne6f5kxEKc5IoJHRCoJrzaCbmejnbBSCauoxZYiGgRnMDVRazDvT2jgsvZK6lUDsqIz+OPE0bmUbxTzQj0B01CnAf4WlEJ246VeXEDjKqhYMyJKu0XMK65VBeNZnlrs44//WKEfYW2hqWz9dzAuVUxtzFeRDK5PbGHrrJ78J3p6TeFDzh2a2mjlvLUUoNzOE4VCof53J+4AIwIcw9LRx+Ae/a5XXJqUCpJnYZhAmZ5bcvvUv44xk1n7LH+4CmhXgbb1taaEiiGzcsBLJ0vHvndLx+4GRgbJeRX/z4jPFB7BX3U/zDWpZwBD+7YgKo4BNaAyQK0LhxRaW+ymEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpbU/uZNcFhfxitiGWI9LkNYmYQ0BrvTShNym4Hl+fc=;
 b=ybf4PgSg3REfxFqULdGLyZ6nhdCM/XdgeblfALbpmWfrGY4jPwLrxarzkphac3HbLse64zfOGmFUUG+t7lg7XGQ3/1NHRmqCx1qLk9kVxoAbEPuwsvgnqp3cNMT2Ro9BFEeykJBvo97ut0FkG+RKZpwpEI8GeU/rMgCrd6mGt0QeHkMJ7BwR9o5fzPEeCeldaGyB9blHAB2tMNTRE92EQrP9u37qx/UoqTtWoKb9InlGIoeIs7zrYRp/1iwI6zMrvy7HXoxeeVG5sc2pFALE8khmL77rG5cj2A4Vly8OYhkNn5CjeOAiKfwPpBVjA8T5tCzCwydA+MSHsFnAH1E4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpbU/uZNcFhfxitiGWI9LkNYmYQ0BrvTShNym4Hl+fc=;
 b=XTvAy4oDpxdkFm90J+u0HjSVGXC18emnCQTI9gyLIqPmQcnOcjSiNvRAViWJuuoYknXZ5AioCSGy2dYQBBK8PMw5nU4w8+nSSz8bjd+FOlfZbFcor5tjLPAKeW3vjG6ueiHA1B1pgdpWPfOZB/smd84S1GmrwjWtjaVPudPxihw=
Received: from DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) by
 CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.17; Mon, 24 Nov 2025 17:25:55 +0000
Received: from DM6PR12MB4106.namprd12.prod.outlook.com
 ([fe80::1702:d78d:f72f:b4bb]) by DM6PR12MB4106.namprd12.prod.outlook.com
 ([fe80::1702:d78d:f72f:b4bb%6]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 17:25:55 +0000
From: "Cheung, Ethan" <Ethan.Cheung@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu/hubs: cast register values to u64
Thread-Topic: [PATCH] drm/amdgpu/hubs: cast register values to u64
Thread-Index: AQHcXWaSqS+c66h5iEmDCcrJOVjHs7UCE+aS
Date: Mon, 24 Nov 2025 17:25:55 +0000
Message-ID: <DM6PR12MB41065164A6783637DF49035797D0A@DM6PR12MB4106.namprd12.prod.outlook.com>
References: <20251124170509.450426-1-alexander.deucher@amd.com>
 <c4f3454f-5509-45da-870e-c06442c03e74@amd.com>
In-Reply-To: <c4f3454f-5509-45da-870e-c06442c03e74@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-24T17:25:54.718Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4106:EE_|CY8PR12MB8363:EE_
x-ms-office365-filtering-correlation-id: ea0c6c13-e96d-4d4e-73ad-08de2b7e865e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MzFLEoHE0iwX7ZJsKmPmfwKVsVTQrjjP1xu7Wzy6tjeaEapdTctHwPUbi0Y3?=
 =?us-ascii?Q?eSryTWpP8ELXM717bNcYbkyRzE2fBouZVFQkjt6MXOW8LoR4sXQll15i4QYs?=
 =?us-ascii?Q?WqjKL3SiYNX/9fP4o2Q5EvXXItdYaRo7Fw/oirqF8uJn9yF/XGfBHBC6NpAA?=
 =?us-ascii?Q?yZnFd/+/Uvppw2inWhPexLVf1m8lhwYllEe2xDn4Exh5OvkOzQmgS5qR+SPn?=
 =?us-ascii?Q?OCRHV9j9JTqATrJUp50sqI+3TOfGv+BUcUTvA5AdIU+S/0bghFryVHr48c82?=
 =?us-ascii?Q?HuMWeTf6YuiTqsI6I1JKMVS46cF8ZuAcdyjacJDZkPq9dpXy0qXpWx71DpAt?=
 =?us-ascii?Q?CXKbI44UB60jS2iKmYF202F6rqQe0hGiGB8rGoamFEq4SQHg0QqbL7uqLUO1?=
 =?us-ascii?Q?s/sjtl8FMVPIkTeCmK2e1pUMYxdab49/WEXRtN191uzaJucrnI9oWmiIEXAE?=
 =?us-ascii?Q?beGpEcJ+iQ7fIDnpxgJkUJEE4urvqVCY821wJiYLaJjRklZTgF8ZwQaN1syr?=
 =?us-ascii?Q?px20ynoeSe27wHFiGZpGq+gA29yvsb0Em89e4KjCkD2g8zLX/NM1B5n9ghVy?=
 =?us-ascii?Q?PwcEknQ+dqGYUkqxQfZEcHUU9YOMBxhY8JB4sb9HXRHY7CMdbmKGeC2k9xzX?=
 =?us-ascii?Q?1dRCcDvVwN+vl5/YDyIeiTNlvjwbCkB7NeBcmi//2IxTB291/xORXndxJjic?=
 =?us-ascii?Q?7HlEkJGSlMWGxY2k8LvdWXgLfMo82q3P8xvn1B8vVWR9+MWsBp+2FSiy5e8+?=
 =?us-ascii?Q?Eq/ir4dSnblLBCG5HWUZIBECYPXy2w2Qp6f6if/mKVUHW+DrUQ9+lbLt3t5o?=
 =?us-ascii?Q?zvll5obkx+S5bIri4DV4UcV7V3C/x3/iRKWX42LoxIwXIsstpIfJePPPwx0v?=
 =?us-ascii?Q?5cTSXT28SqFUS3fVwp+RbbcgezlCFG2vwzxMvRXeeUoiiYPOvxFb4vIbpJIV?=
 =?us-ascii?Q?l8kaaezOnyMIcoPio2xZW2KHnapIlfeYeU0bpztOoz9LpTKfNTxuSkO9amIs?=
 =?us-ascii?Q?tWbaviln/M2xefY4xQXDHdU4kINkQXM5Yr7PDMjH5zOSrDAgkhIldkMJhtLG?=
 =?us-ascii?Q?0mbEzIVGq1bCBzSBN28xp5LPsMSldjADCFnwxDw8H/6+6HdqPdc9f++zFr0J?=
 =?us-ascii?Q?ZOWjDckBloE7QNPKQostrZVfTRVT3xBRkFGxSiqW9mfqd2dnokTXeWiov9WN?=
 =?us-ascii?Q?g8DUsYIarw3JXd7j/vLAVEzaVPeANk4N/+g/LC4y8NxEv3nhhxvr+PFHMo4Z?=
 =?us-ascii?Q?b4NYGry0+SNymV38tGazWXNeu9IvZUfmtRNJ6g1Xj7G8J/cl5EGOSkpgXvov?=
 =?us-ascii?Q?PXWk5swZDRv2Hzcv1Ed+iDmekpwKA6vuPUg4eH/c5fLdj6KyWtXWawtZhJZB?=
 =?us-ascii?Q?7mwrE68vT5qXGPAmwxddG+z8qaqhi8YDItiI5lUKmSBB7ejDdbXZYeRi7IpC?=
 =?us-ascii?Q?eZ6bk+PCdctuXIFQynOqkzO71bQn++bXKKFU0PfuHGcJ3sAviCO9HiteGDzo?=
 =?us-ascii?Q?f92mRNjCTRFpDQOvDpv+X1vN9PvaN26/NGRT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4106.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LGPjnFo9eRx8J4PffsqgxVRhf6MCCkBM91gva/ID7zRFwFgkV9+hfaBBeb4b?=
 =?us-ascii?Q?doXDkwwJF/pkbmsWEq/BpYRZ7bMtOHQYmxlZ+Z0I9QadrKBNKa22kuXADmVN?=
 =?us-ascii?Q?G2WPxxedzKbHMmsUnczOG1YC8XS9xY1fMnhjW9si5d11S2DI2gGWYnbX7or1?=
 =?us-ascii?Q?7+3FAcFGfcLhuxFzxNK73PVZ2FAZ00bChvXBlRzlTWhZbndP98jryeiHgRF9?=
 =?us-ascii?Q?8FExwZGm8wtoqdjwl0foYO4Hp8ZChJfFMo/yFUqFs1HBbRZPd2jYmY70DeXX?=
 =?us-ascii?Q?risqzU2AulepQCR9c4ibl0sOxNdBSr7bCxQ/ftvgcfAbEY67zom7Y/nTzn91?=
 =?us-ascii?Q?QlTL+leoW8Vhuebxx9Kn0OVWC4YN3m8xU8dO065qpJ/6l24+nJfCsldabrqy?=
 =?us-ascii?Q?TdjqC6St6MVTm1I+e5bxG2cf0W8MBgqnkOI4q5TnGKMj08oXHvJJqxxOCPPs?=
 =?us-ascii?Q?+Z3oaXAG7EJgCA52cjV9RgMItK3VI10JzV1LMgtKtWbmMZMhH5nLi6ipv826?=
 =?us-ascii?Q?firUR2j/1e2lCkXidEyaU9twhAY8i5jE1BLeJDC4JZEiJqrw7wCKTJ0Z4yJ2?=
 =?us-ascii?Q?g6Pxph1qKIQpiZT7+DKTee1og80IuzK2QungSVWfQO+0EDF1dfiKb2SMf765?=
 =?us-ascii?Q?9MAV7wvm9SKPUyFb64DznPoy5MzOM+PmE6DqQMDzmc3pMAu/AL7BJw4mxLw7?=
 =?us-ascii?Q?4yuqNeO5XwKQoF+p7c6EyTSRbNaHzRRFOhnNrREUKfqO20rJMnz6zKT6Kfhn?=
 =?us-ascii?Q?dKPiO7bY5WeFMLGuwrGtcO3fSbuupvj6WaOqeeP4ztMll8w8NLBcz8Hx954u?=
 =?us-ascii?Q?osJ6oZuvK7ndPZ05f/skOV2/TqBNwQHHhWnIZ1pRAChAS55EwB/ys5QhMK7N?=
 =?us-ascii?Q?mPPf6dq37uA9hRsGPcjcQ74XlseyPuoPf6rB6idBCsXBWDfLb8fHenF3WWrm?=
 =?us-ascii?Q?3YcgnDUd6zn9OaWy6omMyEJknm3YBsaEmtUCm9LorHHRXF1fDfv7JSzpstHU?=
 =?us-ascii?Q?ELfhypnz9pzqnYyQPnl98E+r/nah1cvPrkELPoZJ+AFe3mA71/fYTA+CkmgF?=
 =?us-ascii?Q?xErocfOvPYuvBllMu4BW0+FesIIgCtiozs52C3bnjWr8BavqYUQSAv7QGSxo?=
 =?us-ascii?Q?3OLuG8LqbgIoJaMjv4o8kYp9oAo+hyLsMkRkMSa4ZkSvR5iTA/LouVE/SYmL?=
 =?us-ascii?Q?tQnXRt3EemLfJaHpWm7EeI7rWj4LxcnaBkpvQ0fY3S/b8tWpLbpwW2pOJuAS?=
 =?us-ascii?Q?O+n1DB2qYowqiUJJRJDRtjVlh6mI1LyLCifUBUD3V6bi+/jUXP6unNgSrMWB?=
 =?us-ascii?Q?kGeMdngUmQ44qMMN5HQqXMlZYbkvgFkDjXyo3EJNTPpJ+Sl+uWshMiXl8U6O?=
 =?us-ascii?Q?C3ObnY+SEIGcbyMYDKWBhDt5ginscAH/jRHLSUfzugEd6/MtpbqLWglI0U/y?=
 =?us-ascii?Q?Q1jW27nUMLa+tgt/io2v/sDSdsX00+ulucmX+xzz2eMBYzOzfAsOOqJENdMj?=
 =?us-ascii?Q?Mghw9E9AFcmIXAvv30rCN6XoUiws4jaaqjEkQPJ9Bk/AGcq7+phwa9iIFpXi?=
 =?us-ascii?Q?hebEktvO38DcGF38F/A=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB41065164A6783637DF49035797D0ADM6PR12MB4106namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4106.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0c6c13-e96d-4d4e-73ad-08de2b7e865e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 17:25:55.2836 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofzjhXerML1qEVmVKK4EjP4bn1uVgdBzNbowOHCosLwKQ4cDwJzvYsqP9zwoMIUyXaEnUQj82IG7CcB5XzpFeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363
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

--_000_DM6PR12MB41065164A6783637DF49035797D0ADM6PR12MB4106namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Ethan Cheung <ethan.cheung@amd.com>
________________________________
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Monday, November 24, 2025 12:20 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org <amd-gfx@lists.freedesktop.org>
Cc: Cheung, Ethan <Ethan.Cheung@amd.com>
Subject: Re: [PATCH] drm/amdgpu/hubs: cast register values to u64


Reviewed-by: Alex Hung <alex.hung@amd.com>

On 11/24/25 10:05, Alex Deucher wrote:
> Cast the register value to u64 for the shift.
>
> Fixes: da0020bf6deb ("drm/amdgpu: Add gc v12_1_0 ip headers v4")
> Fixes: 3148d9bb913a ("drm/amdgpu: Add initial support for mmhub v4_2")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v12_1.c
> index 4c59da7f2ccb1..ceb7eb562ef0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -45,9 +45,9 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_d=
evice *adev)
>        base &=3D GCMC_VM_FB_LOCATION_BASE_LO32__FB_BASE_LO32_MASK;
>        base <<=3D 24;
>
> -     base |=3D ((GCMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
> -               RREG32_SOC15(GC, GET_INST(GC, 0),
> -                       regGCMC_VM_FB_LOCATION_BASE_HI32)) << 56);
> +     base |=3D ((u64)(GCMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
> +                    RREG32_SOC15(GC, GET_INST(GC, 0),
> +                                 regGCMC_VM_FB_LOCATION_BASE_HI32)) << 5=
6);
>        return base;
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/=
amd/amdgpu/mmhub_v4_2_0.c
> index 23f0042125008..24582b8d90ffd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> @@ -81,9 +81,9 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_d=
evice *adev)
>        base &=3D MMMC_VM_FB_LOCATION_BASE_LO32__FB_BASE_LO32_MASK;
>        base <<=3D 24;
>
> -     base |=3D ((MMMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
> -               RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
> -                            regMMMC_VM_FB_LOCATION_BASE_HI32)) << 56);
> +     base |=3D ((u64)(MMMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
> +                    RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
> +                                 regMMMC_VM_FB_LOCATION_BASE_HI32)) << 5=
6);
>
>        return base;
>   }


--_000_DM6PR12MB41065164A6783637DF49035797D0ADM6PR12MB4106namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div data-darkreader-inline-color=3D"" style=3D"font-family: Aptos, Aptos_E=
mbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); --darkreader-inline-color: var(--darkreader-te=
xt-000000, #e8e6e3);" class=3D"elementToProof">
Reviewed-by: Ethan Cheung &lt;ethan.cheung@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hung, Alex &lt;Alex.H=
ung@amd.com&gt;<br>
<b>Sent:</b> Monday, November 24, 2025 12:20 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Cheung, Ethan &lt;Ethan.Cheung@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/hubs: cast register values to u64</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
Reviewed-by: Alex Hung &lt;alex.hung@amd.com&gt;<br>
<br>
On 11/24/25 10:05, Alex Deucher wrote:<br>
&gt; Cast the register value to u64 for the shift.<br>
&gt; <br>
&gt; Fixes: da0020bf6deb (&quot;drm/amdgpu: Add gc v12_1_0 ip headers v4&qu=
ot;)<br>
&gt; Fixes: 3148d9bb913a (&quot;drm/amdgpu: Add initial support for mmhub v=
4_2&quot;)<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 6 +++---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 6 +++---<br>
&gt;&nbsp;&nbsp; 2 files changed, 6 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/d=
rm/amd/amdgpu/gfxhub_v12_1.c<br>
&gt; index 4c59da7f2ccb1..ceb7eb562ef0a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c<br>
&gt; @@ -45,9 +45,9 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgp=
u_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base &amp;=3D GCMC_VM_FB_LOC=
ATION_BASE_LO32__FB_BASE_LO32_MASK;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base &lt;&lt;=3D 24;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; base |=3D ((GCMC_VM_FB_LOCATION_BASE_HI32__F=
B_BASE_HI1_MASK &amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; RREG32_SOC15(GC, GET_INST(GC, 0),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regGCMC_VM_=
FB_LOCATION_BASE_HI32)) &lt;&lt; 56);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; base |=3D ((u64)(GCMC_VM_FB_LOCATION_BASE_HI=
32__FB_BASE_HI1_MASK &amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(GC, GET_INST(GC,=
 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regGCMC_VM_FB_LOCATION_BAS=
E_HI32)) &lt;&lt; 56);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return base;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/d=
rm/amd/amdgpu/mmhub_v4_2_0.c<br>
&gt; index 23f0042125008..24582b8d90ffd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c<br>
&gt; @@ -81,9 +81,9 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgp=
u_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base &amp;=3D MMMC_VM_FB_LOC=
ATION_BASE_LO32__FB_BASE_LO32_MASK;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base &lt;&lt;=3D 24;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; base |=3D ((MMMC_VM_FB_LOCATION_BASE_HI32__F=
B_BASE_HI1_MASK &amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; regMMMC_VM_FB_LOCATION_BASE_HI32)) &lt;&lt; 56);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; base |=3D ((u64)(MMMC_VM_FB_LOCATION_BASE_HI=
32__FB_BASE_HI1_MASK &amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RREG32_SOC15(MMHUB, GET_INST(=
MMHUB, 0),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regMMMC_VM_FB_LOCATION_BAS=
E_HI32)) &lt;&lt; 56);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return base;<br>
&gt;&nbsp;&nbsp; }<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB41065164A6783637DF49035797D0ADM6PR12MB4106namp_--
