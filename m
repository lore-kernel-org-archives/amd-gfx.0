Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA423D35E5D
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2024 10:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A86110E7F5;
	Thu,  7 Nov 2024 10:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qvsKDVtX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B08810E7F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2024 10:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjiQxfZYn6IZTIBBG2g4GI8XCps1Nk9gUyMoU/oHDtZ2fNjPMZLbR4prFhT09O8pnpJU/JiI4iz3/fJ/lDKstaEirdxoh7m1vyQhM118YA6yOyOblIkYDsWEZ2IVFF0BE527SCkTHgPRUxkmePSYCB5g8cjLs10SaCtvGzfS9vX1IGNiYuy3fzfhnpqAkFvxKugd2FfMjWBKuTew25S/wsRXAj9kv73CIQUBRW3jBP9EjtlA1WGAyc1ZfwIl0jcDqSSY1CB1cfYwF2zSL/1CemTGqkdo0keEnsNAzjw8H+Ly+ozlABuaY8wToy2Ur8gxRiqXRk+nw059X6tr/coYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0/qKozmyO5+UZj8myhx/ZEvdFPABlExccvt2WLs02c=;
 b=f8N8mdGSx9J3u85mXkivbQu3INSjw3Ot8pAqBAUQQYv70CrbvokGJXA8+/jcrSEzoBrqJVe5xovj4YHd3kstH/8NT08Iozss3ZyR2d1NXJxh+t61ipf4Wn0AGfoevKFvbv9q0A7tmDbEtQclD7OqnqgoXpSZQb2OqsiqwGpHHcvUW6r21rk19A3HHr+VgFexGfh8sdFdQBlgjQ1uY5W+J40DgTfyJLdfhzAcM42G1G8DHuUDR0tYIyNX/gT4CvGW4N9hxbjZ4RqnKMLyJ9MzRuOI0CojiNWXlPYRsBtdQOkXGMwLESqyDSjauZklrTd3WraUa/NuL1bzBWTZmm7DTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0/qKozmyO5+UZj8myhx/ZEvdFPABlExccvt2WLs02c=;
 b=qvsKDVtXST1+F6wsy7p92I0ncYUkvdPnyOWR2oPzDjfnYFyKauUOr8pawfrBkjo1saRRmHeMssJxHjfic8a7iqXsNOem84082EF1HacncUudqGzhZ2gWhtN+hN9vE7YrIFzc4Rlg5NV6FrICjFrDpanowsoxWkYvt58NXCtFb2U=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 10:38:05 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 10:38:05 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Luo,
 Zhigang" <Zhigang.Luo@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2 4/4] drm/amdgpu: Implement virt req_ras_err_count
Thread-Topic: [PATCH v2 4/4] drm/amdgpu: Implement virt req_ras_err_count
Thread-Index: AQHbL7WZp4ctES8Q7UWkBYlOw13oFbKrobOw
Date: Thu, 7 Nov 2024 10:38:05 +0000
Message-ID: <PH7PR12MB879692E858DF03E10E9650B2B05C2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20241105190429.323478-1-victor.skvortsov@amd.com>
 <20241105190429.323478-4-victor.skvortsov@amd.com>
In-Reply-To: <20241105190429.323478-4-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1206fa11-e9d3-45a9-94e3-a4b83c0b7554;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-07T10:34:00Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SN7PR12MB6815:EE_
x-ms-office365-filtering-correlation-id: 854a4735-9eb2-4004-2372-08dcff184322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tJwtrzTiHFkwSPzb+1n7j+VfMqvhjIVFve0b5v65CSN6hI2GO9K08mQIl95Q?=
 =?us-ascii?Q?FlvYxhPcYXi+sKe22Gx25HjISUcYpR2slG1V3Mbnpfrm3IJ4iXBHG1gyjFnN?=
 =?us-ascii?Q?hDaIgFCGKeqwvnzXyyKJOOK7NRINThqt5CXDfLIEN0gb/l6rlp+laBWV5FWM?=
 =?us-ascii?Q?9GnnHN23btxQbqHJTkW+aJaCr8mMk34vAW8aKbZqqs4BC39uxSKK0putiMec?=
 =?us-ascii?Q?3RCbnmK4Ie+ii+riMbA522dfS+duNvlqveRt3BVMYqNQ+0DKBlvWm8q65c3Z?=
 =?us-ascii?Q?RaD23qOdXeP5eV7wA8EKFXlmj1e9FJO7VjjbDmh06S9IFhNyXhgZ24fbOAnz?=
 =?us-ascii?Q?e7NRmGpp3FBCOiqpZwMCBmb+CZ9YfbdxOgbsP+JtU/zOIN/1IuyEag57r93h?=
 =?us-ascii?Q?f91ql550xf6RcEnhPtSdc+ILNqwQm3bqbOVMBjn0wW/aUi4h4+JCt8q2I/6i?=
 =?us-ascii?Q?tE6w9cKl/FJn31AhfOdw4Wq/yxfmqycq5eylQ8aojP8ymOLw6ZZPrLy1Us7f?=
 =?us-ascii?Q?06jNICQwEmHcc5kL4SaD2lyqgHB3u5b0mB5OX5tOVrzKpIIy346sK4ChZR0J?=
 =?us-ascii?Q?uNd9/UKlyqQ6ghmxg2XFwwAjhlxr9zMl5f5yxnKNsK64Owmc5hYHdglSgVOF?=
 =?us-ascii?Q?qzSEsrUwg9xBQp58RBwkhXOiWSUuGY8pRXFsidLzB90UxRINcWn9YyHz1oFi?=
 =?us-ascii?Q?sspaBqSblUd6H/go5ZhW7p2ZQmio38VYzKJpSjc4h1k7FGguuCqoBujP6FtN?=
 =?us-ascii?Q?N4UtjmgCYQfDeVwjtCaKOr9v2MQPt8PoBXpWCKGQBLEeWfF2JTZ1sGWra/lo?=
 =?us-ascii?Q?cloZJyLZEgyxEPmD3ESXrLdbW5PGvBi52aaxZAglhHFgo3ZaRKhpCm9ue2k5?=
 =?us-ascii?Q?S8OKFujZd6/8nAlFVmN2AxVRzUuU9RQtLLbaBH80JbWFW1C5jjJEfxElKBY+?=
 =?us-ascii?Q?+sraXQoUPHkoCJkCD5z0Sqr1hvuqHZiLKOe+1OgSLdhD/nC/2KjjctNy8Qjx?=
 =?us-ascii?Q?HtuMRCzLrrtjpYRU89wo6J9gAxyTIWA+rln1buAsY5qo72HA8+1rCdRyVHNS?=
 =?us-ascii?Q?Ydkw5XimiE5dYgrMf72K9U5kcBq/b+Ue396k5PuYD2VdN10j31QvLO4QH5NQ?=
 =?us-ascii?Q?gYbvdx2LQUZmTS4TI9Swj3DC/tVZyhg6TIvX8nAhov4YGHsYA4bAFYKrJvpd?=
 =?us-ascii?Q?81/i9rxHPYt4UJu5bERPvILMz0VJFZxShD/4NmlwmYo/l0nOQGKRLSDjfipp?=
 =?us-ascii?Q?jxMB55UUw5gOSvm6wKWWXfqeXqBEd4/iKbpv0xod8ukPsFDTy0dOV/Ag3n/2?=
 =?us-ascii?Q?mSWw6V5NyoGRqbYDcmQyQRc19y7wUQWaJ0I1+vWKc18xMk0sjHqZWtAFnU+t?=
 =?us-ascii?Q?VUvHiZA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2F+EH0hhVdMeizOyzZ8uPeOMrq6oHrbYK4pj1Sfrdo/h3EJFSPKJ0oWovO2w?=
 =?us-ascii?Q?pyOmENZg6nAn/dCfT4vYRItRfkeLWl8Q/IfDW57QyyXvA5zQNaipQBBV/8iV?=
 =?us-ascii?Q?Sj7dVA9B+1zxtR/Ppn90Y9T7uneFNLNgzhAnhWzNK0jVF8gfHlIDkk82MDWQ?=
 =?us-ascii?Q?18/PNVHFLuVSun7Cn8ghRW9qXkQQTvVxJIUOAplf5k7wMlEz3RSUQxWFXygf?=
 =?us-ascii?Q?01+f5QoKuT0HyQ8kW8MdBHLOijusZowtSAe38u4zAZa64p9O9croGMUJWVDQ?=
 =?us-ascii?Q?SNTt05ekaD/B/ubux00wOriFW7d7DDgjhI3XbV0eOGOcLLoxscBZDVPT0s8w?=
 =?us-ascii?Q?wlJ7lX2jR4CesPtMldX5uWhLxzP9FTVivUzIl2XwsVgdcuPDteraeYNAf1uK?=
 =?us-ascii?Q?9xf0w9SeK6i+em6Q6YQSpnf3IU4SRqq44qWsaY2mXfQFx+qlnZn/B/7CdArd?=
 =?us-ascii?Q?QCcIwzlj3lIV2pccXN3n1Tn+WxqlkGnEuc7CXg0bMEMJFLg+QJqKP6gcIti7?=
 =?us-ascii?Q?Mf8KcyMYpmwi43KIm3h3KFbtLPIgFd6LI9EIJ05bOjTpCHCM8YaShITYVMAt?=
 =?us-ascii?Q?sfl5F3eF5gwnw1FDF9kgsckpsYYpgknHF9L+7hYA5NMVVVx0duGCdrYBVgR1?=
 =?us-ascii?Q?d+W+ttiXkYom0FKs+CKH5JHTZjTdz99H1XtAhtlMRndzhII7cY43PkLGjMXz?=
 =?us-ascii?Q?BcFeI6Jmqh3wQkhBTr5V0gDC0aClZgOATNxpaCHGLh4reaR9oVLXnzYuwrH1?=
 =?us-ascii?Q?R5o1Rp+BhBP2jDfVJHmq0bihJf1qeEnIzHtg5wEtHYDJBBKdLVSfXPSyCyz+?=
 =?us-ascii?Q?q3p4ix7s/G26rKKkBoDHkoT6SS8L/WYmbOerr19ZiGU/dB92CFebvn9fiUU7?=
 =?us-ascii?Q?0YszuFHrl+b44axLKFs+KHKWKHdr8b0+oNa3GC8ZSU+tg6j3UwwzEouBiL6m?=
 =?us-ascii?Q?6bwconasyZ4H+jEda5dnk+Oqj5ZE0VPe2qDrw04DNLoxhuOPtEzxGiAjOw+q?=
 =?us-ascii?Q?r6WbkzNZirreT1LEk5S9bjdsorlH96QU9hBs3QUBaR/RASBkSu4FfunvggU4?=
 =?us-ascii?Q?4+3T89o3IcGm3c+QzDzVLWLd0LaU+JPniGKcyVmu25uPCSb1FBEbDz8kQhjm?=
 =?us-ascii?Q?EHi9JfNGfSKFF+jC7EF0UpwVatooIOZ5Ew8tQW7OtVU+r7civsb0V2J5wGuu?=
 =?us-ascii?Q?wGmLlCaNCeUdNnSPLRbSGFFHMhresGxYkQ3l1dWuBLv7+6Ved6JiByW5d5sj?=
 =?us-ascii?Q?hMmRIYPqtaMrwtBdtTfi9dNiwmbzcIyOeArtK+oKkNCMt6ehMcyGnClnUUfP?=
 =?us-ascii?Q?TFz2BlMWivknxCwuZb/pwY+2djr7FL/+m4gROIBM9RQnFILzDg3VjI9zjuyC?=
 =?us-ascii?Q?DfENnMwW5PmjlUHjjK+k+TDOnkn7ruCoFkYY6izYgU6fuc5p8BHX2HLXeTJJ?=
 =?us-ascii?Q?Bw3tJLSZ2J1PorMm28PtHpM9W90SpAVHgwLbFcIhflrn2jWIktSsbgaAEbOU?=
 =?us-ascii?Q?pq3im4J1lL4xpc155DBoVMHgAyWD6NToszh9aXQ0kTCz+TECG+gzL8QxsR8e?=
 =?us-ascii?Q?eSYsb40TXnIpwRBl8jA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854a4735-9eb2-4004-2372-08dcff184322
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 10:38:05.0247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOiSTqVutlseFAti7LxwhGHgBepy1KaWvZc48q65sKj/PRbNXrb4z5duoyYFmbsY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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

For amdgpu_ras_block_to_sriov, can we return block directly? As the definit=
ion of enum amdgpu_ras_block is same as that of enum amd_sriov_ras_telemetr=
y_gpu_block.
Anyway, the framework is fine for me, the series is:

Acked-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
> Sent: Wednesday, November 6, 2024 3:04 AM
> To: Skvortsov, Victor <Victor.Skvortsov@amd.com>; amd-gfx@lists.freedeskt=
op.org;
> Luo, Zhigang <Zhigang.Luo@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH v2 4/4] drm/amdgpu: Implement virt req_ras_err_count
>
> Enable RAS late init  if VF RAS Telemetry is supported.
>
> When enabled, the VF can use this interface to query total RAS error coun=
ts from the
> host.
>
> The VF FB access may abruptly end due to a fatal error, therefore the VF =
must
> cache and sanitize the input.
>
> The Host allows 15 Telemetry messages every 60 seconds, afterwhich the ho=
st will
> ignore any more in-coming telemetry messages. The VF will rate limit its =
msg calling
> to once every 5 seconds (12 times in 60 seconds).
> While the VF is rate limited, it will continue to report the last good ca=
ched data.
>
> v2: Flip generate report & update statistics order for VF
>
> Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |  72 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 138 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  15 +++
>  7 files changed, 231 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 383bbee87df5..c22a9925cba7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4235,7 +4235,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>        * for throttling interrupt) =3D 60 seconds.
>        */
>       ratelimit_state_init(&adev->throttling_logging_rs, (60 - 1) * HZ, 1=
);
> +     ratelimit_state_init(&adev->virt.ras_telemetry_rs, 5 * HZ, 1);
> +
>       ratelimit_set_flags(&adev->throttling_logging_rs,
> RATELIMIT_MSG_ON_RELEASE);
> +     ratelimit_set_flags(&adev->virt.ras_telemetry_rs,
> +RATELIMIT_MSG_ON_RELEASE);
>
>       /* Registers mapping */
>       /* TODO: block userspace mapping of io register */ @@ -5185,6 +5188=
,9
> @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) =
||
>           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 0, 3)=
)
>               amdgpu_ras_resume(adev);
> +
> +     amdgpu_virt_ras_telemetry_post_reset(adev);
> +
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index b8cc4b146bdc..8c9fcfb7f22e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -885,6 +885,9 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *ad=
ev,
> struct ras_common_if *r
>               if (r)
>                       return r;
>
> +             if (amdgpu_sriov_vf(adev))
> +                     return r;
> +
>               if (adev->gfx.cp_ecc_error_irq.funcs) {
>                       r =3D amdgpu_irq_get(adev, &adev->gfx.cp_ecc_error_=
irq, 0);
>                       if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 89d87dc17ac1..a8b4f4178e5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1214,6 +1214,42 @@ static void amdgpu_ras_error_generate_report(struc=
t
> amdgpu_device *adev,
>       }
>  }
>
> +static void amdgpu_ras_virt_error_generate_report(struct amdgpu_device *=
adev,
> +                                               struct ras_query_if *quer=
y_if,
> +                                               struct ras_err_data *err_=
data,
> +                                               struct ras_query_context =
*qctx) {
> +     unsigned long new_ue, new_ce, new_de;
> +     struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &query_if->he=
ad);
> +     const char *blk_name =3D get_ras_block_str(&query_if->head);
> +     u64 event_id =3D qctx->event_id;
> +
> +     new_ce =3D err_data->ce_count - obj->err_data.ce_count;
> +     new_ue =3D err_data->ue_count - obj->err_data.ue_count;
> +     new_de =3D err_data->de_count - obj->err_data.de_count;
> +
> +     if (new_ce) {
> +             RAS_EVENT_LOG(adev, event_id, "%lu correctable hardware err=
ors
> "
> +                           "detected in %s block\n",
> +                           new_ce,
> +                           blk_name);
> +     }
> +
> +     if (new_ue) {
> +             RAS_EVENT_LOG(adev, event_id, "%lu uncorrectable hardware
> errors "
> +                           "detected in %s block\n",
> +                           new_ue,
> +                           blk_name);
> +     }
> +
> +     if (new_de) {
> +             RAS_EVENT_LOG(adev, event_id, "%lu deferred hardware errors=
 "
> +                           "detected in %s block\n",
> +                           new_de,
> +                           blk_name);
> +     }
> +}
> +
>  static void amdgpu_rasmgr_error_data_statistic_update(struct ras_manager=
 *obj,
> struct ras_err_data *err_data)  {
>       struct ras_err_node *err_node;
> @@ -1237,6 +1273,15 @@ static void
> amdgpu_rasmgr_error_data_statistic_update(struct ras_manager *obj, s
>       }
>  }
>
> +static void amdgpu_ras_mgr_virt_error_data_statistics_update(struct ras_=
manager
> *obj,
> +                                                          struct ras_err=
_data
> *err_data) {
> +     /* Host reports absolute counts */
> +     obj->err_data.ue_count =3D err_data->ue_count;
> +     obj->err_data.ce_count =3D err_data->ce_count;
> +     obj->err_data.de_count =3D err_data->de_count; }
> +
>  static struct ras_manager *get_ras_manager(struct amdgpu_device *adev, e=
num
> amdgpu_ras_block blk)  {
>       struct ras_common_if head;
> @@ -1323,7 +1368,9 @@ static int amdgpu_ras_query_error_status_helper(str=
uct
> amdgpu_device *adev,
>       if (error_query_mode =3D=3D AMDGPU_RAS_INVALID_ERROR_QUERY)
>               return -EINVAL;
>
> -     if (error_query_mode =3D=3D AMDGPU_RAS_DIRECT_ERROR_QUERY) {
> +     if (error_query_mode =3D=3D AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY) {
> +             return amdgpu_virt_req_ras_err_count(adev, blk, err_data);
> +     } else if (error_query_mode =3D=3D AMDGPU_RAS_DIRECT_ERROR_QUERY) {
>               if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC) {
>                       amdgpu_ras_get_ecc_info(adev, err_data);
>               } else {
> @@ -1405,14 +1452,22 @@ static int
> amdgpu_ras_query_error_status_with_event(struct amdgpu_device *adev,
>       if (ret)
>               goto out_fini_err_data;
>
> -     amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);
> +     if (error_query_mode !=3D AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY) {
> +             amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);
> +             amdgpu_ras_error_generate_report(adev, info, &err_data, &qc=
tx);
> +     } else {
> +             /* Host provides absolute error counts. First generate the =
report
> +              * using the previous VF internal count against new host co=
unt.
> +              * Then Update VF internal count.
> +              */
> +             amdgpu_ras_virt_error_generate_report(adev, info, &err_data=
, &qctx);
> +             amdgpu_ras_mgr_virt_error_data_statistics_update(obj, &err_=
data);
> +     }
>
>       info->ue_count =3D obj->err_data.ue_count;
>       info->ce_count =3D obj->err_data.ce_count;
>       info->de_count =3D obj->err_data.de_count;
>
> -     amdgpu_ras_error_generate_report(adev, info, &err_data, &qctx);
> -
>  out_fini_err_data:
>       amdgpu_ras_error_data_fini(&err_data);
>
> @@ -3929,7 +3984,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev=
)
>       }
>
>       /* Guest side doesn't need init ras feature */
> -     if (amdgpu_sriov_vf(adev))
> +     if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
>               return 0;
>
>       list_for_each_entry_safe(node, tmp, &adev->ras_list, node) { @@ -43=
96,11
> +4451,14 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_device
> *adev,
>               return false;
>       }
>
> -     if ((smu_funcs && smu_funcs->set_debug_mode) || (mca_funcs &&
> mca_funcs->mca_set_debug_mode))
> +     if (amdgpu_sriov_vf(adev)) {
> +             *error_query_mode =3D
> AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY;
> +     } else if ((smu_funcs && smu_funcs->set_debug_mode) || (mca_funcs &=
&
> +mca_funcs->mca_set_debug_mode)) {
>               *error_query_mode =3D
>                       (con->is_aca_debug_mode) ?
> AMDGPU_RAS_DIRECT_ERROR_QUERY :
> AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
> -     else
> +     } else {
>               *error_query_mode =3D AMDGPU_RAS_DIRECT_ERROR_QUERY;
> +     }
>
>       return true;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 871b2d6278e0..6db772ecfee4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -365,6 +365,7 @@ enum amdgpu_ras_error_query_mode {
>       AMDGPU_RAS_INVALID_ERROR_QUERY          =3D 0,
>       AMDGPU_RAS_DIRECT_ERROR_QUERY           =3D 1,
>       AMDGPU_RAS_FIRMWARE_ERROR_QUERY         =3D 2,
> +     AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY       =3D 3,
>  };
>
>  /* ras error status reisger fields */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index bb7b9b2eaac1..896f3609b0ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -318,6 +318,9 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *ad=
ev,
> struct ras_common_if *r
>       if (r)
>               return r;
>
> +     if (amdgpu_sriov_vf(adev))
> +             return r;
> +
>       if (amdgpu_ras_is_supported(adev, ras_block->block)) {
>               r =3D amdgpu_irq_get(adev, &adev->gmc.ecc_irq, 0);
>               if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 53297c40f09c..b1e584e4ef13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -524,6 +524,8 @@ static int amdgpu_virt_read_pf2vf_data(struct
> amdgpu_device *adev)
>               adev->unique_id =3D
>                       ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uu=
id;
>               adev->virt.ras_en_caps.all =3D ((struct amd_sriov_msg_pf2vf=
_info
> *)pf2vf_info)->ras_en_caps.all;
> +             adev->virt.ras_telemetry_en_caps.all =3D
> +                     ((struct amd_sriov_msg_pf2vf_info
> +*)pf2vf_info)->ras_telemetry_en_caps.all;
>               break;
>       default:
>               dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_i=
nfo-
> >version); @@ -704,6 +706,8 @@ void amdgpu_virt_exchange_data(struct
> amdgpu_device *adev)
>                       adev->virt.fw_reserve.p_vf2pf =3D
>                               (struct amd_sriov_msg_vf2pf_info_header *)
>                               (adev->mman.fw_vram_usage_va +
> (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +                     adev->virt.fw_reserve.ras_telemetry =3D
> +                             (adev->mman.fw_vram_usage_va +
> +(AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
>               } else if (adev->mman.drv_vram_usage_va) {
>                       adev->virt.fw_reserve.p_pf2vf =3D
>                               (struct amd_sriov_msg_pf2vf_info_header *) =
@@ -
> 711,6 +715,8 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev=
)
>                       adev->virt.fw_reserve.p_vf2pf =3D
>                               (struct amd_sriov_msg_vf2pf_info_header *)
>                               (adev->mman.drv_vram_usage_va +
> (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +                     adev->virt.fw_reserve.ras_telemetry =3D
> +                             (adev->mman.drv_vram_usage_va +
> +(AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
>               }
>
>               amdgpu_virt_read_pf2vf_data(adev);
> @@ -1197,3 +1203,135 @@ bool amdgpu_virt_get_ras_capability(struct
> amdgpu_device *adev)
>
>       return true;
>  }
> +
> +static inline enum amd_sriov_ras_telemetry_gpu_block
> +amdgpu_ras_block_to_sriov(struct amdgpu_device *adev, enum
> amdgpu_ras_block block) {
> +     switch (block) {
> +     case AMDGPU_RAS_BLOCK__UMC:
> +             return RAS_TELEMETRY_GPU_BLOCK_UMC;
> +     case AMDGPU_RAS_BLOCK__SDMA:
> +             return RAS_TELEMETRY_GPU_BLOCK_SDMA;
> +     case AMDGPU_RAS_BLOCK__GFX:
> +             return RAS_TELEMETRY_GPU_BLOCK_GFX;
> +     case AMDGPU_RAS_BLOCK__MMHUB:
> +             return RAS_TELEMETRY_GPU_BLOCK_MMHUB;
> +     case AMDGPU_RAS_BLOCK__ATHUB:
> +             return RAS_TELEMETRY_GPU_BLOCK_ATHUB;
> +     case AMDGPU_RAS_BLOCK__PCIE_BIF:
> +             return RAS_TELEMETRY_GPU_BLOCK_PCIE_BIF;
> +     case AMDGPU_RAS_BLOCK__HDP:
> +             return RAS_TELEMETRY_GPU_BLOCK_HDP;
> +     case AMDGPU_RAS_BLOCK__XGMI_WAFL:
> +             return RAS_TELEMETRY_GPU_BLOCK_XGMI_WAFL;
> +     case AMDGPU_RAS_BLOCK__DF:
> +             return RAS_TELEMETRY_GPU_BLOCK_DF;
> +     case AMDGPU_RAS_BLOCK__SMN:
> +             return RAS_TELEMETRY_GPU_BLOCK_SMN;
> +     case AMDGPU_RAS_BLOCK__SEM:
> +             return RAS_TELEMETRY_GPU_BLOCK_SEM;
> +     case AMDGPU_RAS_BLOCK__MP0:
> +             return RAS_TELEMETRY_GPU_BLOCK_MP0;
> +     case AMDGPU_RAS_BLOCK__MP1:
> +             return RAS_TELEMETRY_GPU_BLOCK_MP1;
> +     case AMDGPU_RAS_BLOCK__FUSE:
> +             return RAS_TELEMETRY_GPU_BLOCK_FUSE;
> +     case AMDGPU_RAS_BLOCK__MCA:
> +             return RAS_TELEMETRY_GPU_BLOCK_MCA;
> +     case AMDGPU_RAS_BLOCK__VCN:
> +             return RAS_TELEMETRY_GPU_BLOCK_VCN;
> +     case AMDGPU_RAS_BLOCK__JPEG:
> +             return RAS_TELEMETRY_GPU_BLOCK_JPEG;
> +     case AMDGPU_RAS_BLOCK__IH:
> +             return RAS_TELEMETRY_GPU_BLOCK_IH;
> +     case AMDGPU_RAS_BLOCK__MPIO:
> +             return RAS_TELEMETRY_GPU_BLOCK_MPIO;
> +     default:
> +             dev_err(adev->dev, "Unsupported SRIOV RAS telemetry block
> 0x%x\n", block);
> +             return RAS_TELEMETRY_GPU_BLOCK_COUNT;
> +     }
> +}
> +
> +static int amdgpu_virt_cache_host_error_counts(struct amdgpu_device *ade=
v,
> +                                            struct amdsriov_ras_telemetr=
y
> *host_telemetry) {
> +     struct amd_sriov_ras_telemetry_error_count *tmp =3D { 0 };
> +     uint32_t checksum, used_size, tmp_check;
> +
> +     checksum =3D host_telemetry->header.checksum;
> +     used_size =3D host_telemetry->header.used_size;
> +
> +     if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +             return 0;
> +
> +     tmp =3D kmalloc(used_size, GFP_KERNEL);
> +     if (!tmp)
> +             return -ENOMEM;
> +
> +     memcpy(tmp, &host_telemetry->body.error_count, used_size);
> +
> +     tmp_check =3D amd_sriov_msg_checksum(tmp, used_size, 0, 0);
> +     if (checksum !=3D amd_sriov_msg_checksum(tmp, used_size, 0, 0))
> +             goto out;
> +
> +     /* Copy sanitized data to guest cache */
> +     memcpy(&adev->virt.count_cache, tmp, sizeof(adev->virt.count_cache)=
);
> +out:
> +     kfree(tmp);
> +
> +     return 0;
> +}
> +
> +static int amdgpu_virt_req_ras_err_count_internal(struct amdgpu_device
> +*adev, bool force_update) {
> +     struct amdgpu_virt *virt =3D &adev->virt;
> +
> +     /* Host allows 15 ras telemetry requests per 60 seconds. Afterwhich=
, the Host
> +      * will ignore incoming guest messages. Ratelimit the guest message=
s to
> +      * prevent guest self DOS.
> +      */
> +     if (__ratelimit(&adev->virt.ras_telemetry_rs) || force_update) {
> +             if (!virt->ops->req_ras_err_count(adev))
> +                     amdgpu_virt_cache_host_error_counts(adev,
> +                             adev->virt.fw_reserve.ras_telemetry);
> +     }
> +
> +     return 0;
> +}
> +
> +/* Bypass ACA interface and query ECC counts directly from host */ int
> +amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum
> amdgpu_ras_block block,
> +                               struct ras_err_data *err_data)
> +{
> +     int ret;
> +     enum amd_sriov_ras_telemetry_gpu_block sriov_block;
> +
> +     sriov_block =3D amdgpu_ras_block_to_sriov(adev, block);
> +
> +     if (sriov_block >=3D RAS_TELEMETRY_GPU_BLOCK_COUNT ||
> +         !amdgpu_sriov_ras_telemetry_block_en(adev, sriov_block))
> +             return -EOPNOTSUPP;
> +
> +     /* Host Access may be lost during reset, just return last cached da=
ta. */
> +     if (down_read_trylock(&adev->reset_domain->sem)) {
> +             amdgpu_virt_req_ras_err_count_internal(adev, false);
> +             up_read(&adev->reset_domain->sem);
> +     }
> +
> +     err_data->ue_count =3D adev->virt.count_cache.block[sriov_block].ue=
_count;
> +     err_data->ce_count =3D adev->virt.count_cache.block[sriov_block].ce=
_count;
> +     err_data->de_count =3D
> +adev->virt.count_cache.block[sriov_block].de_count;
> +
> +     return 0;
> +}
> +
> +int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev) {
> +     unsigned long ue_count, ce_count;
> +
> +     if (amdgpu_sriov_ras_telemetry_en(adev)) {
> +             amdgpu_virt_req_ras_err_count_internal(adev, true);
> +             amdgpu_ras_query_error_count(adev, &ce_count, &ue_count,
> NULL);
> +     }
> +
> +     return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index f0ff84add692..5381b8d596e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -104,6 +104,7 @@ struct amdgpu_virt_ops {  struct amdgpu_virt_fw_reser=
ve {
>       struct amd_sriov_msg_pf2vf_info_header *p_pf2vf;
>       struct amd_sriov_msg_vf2pf_info_header *p_vf2pf;
> +     void *ras_telemetry;
>       unsigned int checksum_key;
>  };
>
> @@ -138,6 +139,7 @@ enum AMDGIM_FEATURE_FLAG {
>       /* MES info */
>       AMDGIM_FEATURE_MES_INFO_ENABLE =3D (1 << 8),
>       AMDGIM_FEATURE_RAS_CAPS =3D (1 << 9),
> +     AMDGIM_FEATURE_RAS_TELEMETRY =3D (1 << 10),
>  };
>
>  enum AMDGIM_REG_ACCESS_FLAG {
> @@ -280,6 +282,10 @@ struct amdgpu_virt {
>       struct mutex rlcg_reg_lock;
>
>       union amd_sriov_ras_caps ras_en_caps;
> +     union amd_sriov_ras_caps ras_telemetry_en_caps;
> +
> +     struct ratelimit_state ras_telemetry_rs;
> +     struct amd_sriov_ras_telemetry_error_count count_cache;
>  };
>
>  struct amdgpu_video_codec_info;
> @@ -327,6 +333,12 @@ struct amdgpu_video_codec_info;  #define
> amdgpu_sriov_ras_caps_en(adev) \  ((adev)->virt.gim_feature &
> AMDGIM_FEATURE_RAS_CAPS)
>
> +#define amdgpu_sriov_ras_telemetry_en(adev) \
> +(((adev)->virt.gim_feature & AMDGIM_FEATURE_RAS_TELEMETRY) &&
> +(adev)->virt.fw_reserve.ras_telemetry)
> +
> +#define amdgpu_sriov_ras_telemetry_block_en(adev, sriov_blk) \
> +(amdgpu_sriov_ras_telemetry_en((adev)) &&
> +(adev)->virt.ras_telemetry_en_caps.all & BIT(sriov_blk))
> +
>  static inline bool is_virtual_machine(void)  {  #if defined(CONFIG_X86) =
@@ -391,4
> +403,7 @@ bool amdgpu_virt_get_rlcg_reg_access_flag(struct amdgpu_device
> *adev,
>                                         bool write, u32 *rlcg_flag);
>  u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 =
v, u32
> flag, u32 xcc_id);  bool amdgpu_virt_get_ras_capability(struct amdgpu_dev=
ice
> *adev);
> +int amdgpu_virt_req_ras_err_count(struct amdgpu_device *adev, enum
> amdgpu_ras_block block,
> +                               struct ras_err_data *err_data);
> +int amdgpu_virt_ras_telemetry_post_reset(struct amdgpu_device *adev);
>  #endif
> --
> 2.34.1

