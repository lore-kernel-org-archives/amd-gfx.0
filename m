Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AACD277CD
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Jan 2026 03:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26FED10E074;
	Sat, 10 Jan 2026 03:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f77AfAZN";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EDA410E074
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Jan 2026 03:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYL3cod2OLOUJ+5k4HsWRXdbMKwAjxRrBb0DzbQRiA1uW225d7bAR7CqjsvyPvHZoMPfXCmgzJlGNYm8BoDCzVgbCS7zfFljSqZYk3YpvbqVqg9adrah1dl5Y9od+c19Sg4UhnzU/23YFI7tDc1YFcHyxUBRu8/+rZniRmrj8abfR/NNxhCgW6UDmGzvqoKh8a5+ZjuiGP/Fv70pQgm6YusuB5HKm2lMO7fuuFvhXXY74hmUFVPbR2ix7TWB4wPTl5DDy/T3rktIfYQOt58cLZ0wlHjZ2lsCGLaqMbuRLbeV5jVwiPvDKAiBYdJ3wgPIHMg7clU3QkvE5Lc6nUdcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioKIC1RSLJB/kcCyb6sDyKLNxacqKU0+BG8jN4UVipk=;
 b=atB+Q2EXjUj9/UHfqE27BciGc56QCZ5vAWuJ2zA2maQSdEYpjzJ3kCXRlZMVeYqofGzZvHtOrWNZUvTT5kMhFovOefgdpXej8GE/rvap07kChpkDpqfQkNxLCW7bAWM8gGsvJae+bDHkSnn9YeWtQnhuxXvA/qYNlr8D+8VMRT5oU9VNv6k5RjyxjncfTE5FOPOCr/4Ais55Hbse15X5d4CmmzmqgSBeFqUPA40zUbXzfyB/rDEe7sZm11FD2YZ4re9Nw1zF+5dDI0Kk/qRFy2OdQT3WqLuS5xIxKKvtpJP+kyAI7VSfuAXco6hk6k9nZfNvCJTMB7dnGMiYsg0Xeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioKIC1RSLJB/kcCyb6sDyKLNxacqKU0+BG8jN4UVipk=;
 b=f77AfAZNl327Tjt+b7WnJ7/8UiL52zut1dXOpx3aN9blfmilGdw+8WGDXy8WF/hKUVoykk8EmsWR6eI+WJfbvsFLJyBGZe0XfOYrqx8V64VQJ+8LVEkZUgSjBUc8wZSq1UvzJkikTxHschCNWl1h6dINIxMokvfAN8VfW/qc43s=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 10 Jan
 2026 03:26:36 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.20.9499.003; Sat, 10 Jan 2026
 03:26:36 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: make sure userqs are enabled in userq IOCTLs
Thread-Topic: [PATCH] drm/amdgpu: make sure userqs are enabled in userq IOCTLs
Thread-Index: AQHcgW/zEunqh76D70uoJ7YHLLHoFLVKvcZA
Date: Sat, 10 Jan 2026 03:26:36 +0000
Message-ID: <DS7PR12MB6005FB96E1549C1293D90351FB83A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260109135743.3241773-1-alexander.deucher@amd.com>
In-Reply-To: <20260109135743.3241773-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-01-10T03:22:24.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB6696:EE_
x-ms-office365-filtering-correlation-id: 9a5613b9-00bc-4e43-49f0-08de4ff80f97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3+MboEHoMT2uqkI3EMq+D6ReVp3dYcar/BrHhe1cQoJtlg8MYLWVgcy9g3u0?=
 =?us-ascii?Q?Ma6ALx1FblhKLJVOwKqDSsVsnKgShHj+Wr2daZxDx3cfemD0fj2zCRiX4IO5?=
 =?us-ascii?Q?3VRgDr0Ye3rkUEgBZDrw7V/vprQS5CTIehetEa6CgSF4G8GDIBQsWYDJ82cM?=
 =?us-ascii?Q?w8Q0F/q9zCMKbN8IyMjDGzZ5vrdfPR4xKC0Rv9y0sLwAJorkMf4+RArM95wW?=
 =?us-ascii?Q?9tKsYbQvdrujpzUa4+NaxbDrmQFiBxUh5pko+Cf2cnTpgJk2pm6EyVgZd3/o?=
 =?us-ascii?Q?cIWUMmVbUdXgNTzA+50RWSWMR1ibcSVFZPE3zSs1g/XqtkaGNlixhW1g/yWz?=
 =?us-ascii?Q?2MdOvHqNRSIqDvfgnB9lb09R90EItSbfh+Cw8gHZXy6QdONzdmT8ii3inrKs?=
 =?us-ascii?Q?0jhFo0iVsMLxPfG+0Ogr9fXTgE4/othbJl+7qhuFqDZFHvj6H+V4e9vNGkmx?=
 =?us-ascii?Q?OxlAtgES9kN2qozxWiltrq3wArn9YqhL5/NdHIgzlesEG/YhsaOaR4enwKZp?=
 =?us-ascii?Q?jS4lVDyn3dorp4oCa8H/pgP6O26d7VGSpju8qW6IZMQT79t2EJLUt4gy+eYf?=
 =?us-ascii?Q?UPvXUjNJsVX5TBkD0UumHiIsRjZeN8bOfuDuVx7r3lmgGdEe529/Y/rOOF1W?=
 =?us-ascii?Q?kNYjmq3MSe/Qf8gHjng0RsLTtBYlnsj0mbivRVA3FP/S93JXGfdRidtZ8Rnk?=
 =?us-ascii?Q?Y8v00z0hz17mFuCxF981lypAkKyfeEQcuCZfdkcBZZdO2MW8BqU6hsO1NWpB?=
 =?us-ascii?Q?q1Smj6Vc+xmoFaDS0vMEYUAyl7JnBsbgcLmrEux2ntYg9BDFafYthKJpVtYp?=
 =?us-ascii?Q?yI2igFWmY2xs00R6W+e2/keJzC3alHzYYT+pFZ6tonU2Ho8vBDRak3HY/heJ?=
 =?us-ascii?Q?y7/cE4b9HdvQa1+JMYnZeALIxAuXQpzT+Xb51JN0zDyZ1H5ySC+B03ipwgcO?=
 =?us-ascii?Q?OOdqxPOoti7uUxQUfQ1ZiXrJMyUEUHfjTWjdblbvh0C3Bcg1oFKz2TxG7oDe?=
 =?us-ascii?Q?GtX+N5ZHy2iosQ+GdvI8NyYm0omBxa4aGrJzf8b+J8P6CdIA3E/w7kqqClBY?=
 =?us-ascii?Q?U2+hYlww2DzPaY771MQHe73YU4ZS0wmCAxVO9asBQn6qW4A87T2ww3KA3PIG?=
 =?us-ascii?Q?kGidzZLR2vogqz0S1dGjOwuj5iXnQmFt9i0/0NGkfbD2Bwe5yWK5kBbWgnqd?=
 =?us-ascii?Q?BL6dL7aSv2os0fnAiwsGLMzWZxiIfo8hdaFwfVeIcMJl5R/1B98CDgBBUFpF?=
 =?us-ascii?Q?s0RlbMNfxHnVOMio83+4ETFSS75SZx2w3T6717koZd6ef0DDyjsrUagDSxKl?=
 =?us-ascii?Q?rHNYa+WIpn3EGj/tIRx1zsj3GjkJhk1Tcwp2cz2qAftJCpog0XLuT+4T6cCb?=
 =?us-ascii?Q?ghhgVVQ1J9vECzw5UgrfGA1mVdWhW9BnZGgMGinqGZoQf+oFJOkTYSwIXsfC?=
 =?us-ascii?Q?uzeGiecy6oTc0myziooICA3Iqrj6x/NE0lK6BK2EAZXVxh9t4hYGUjcE7PLm?=
 =?us-ascii?Q?cGU1Nl7zz51bhbZ1mQE1rcLuJwdlYGW1H1BV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QdMPLR2/1U9v3/vF4CsJME0ao8HnLGhSV3ctSrXNRJuchYlDXrFBkBt6dRMY?=
 =?us-ascii?Q?Ls0JNEsrreFG4JmR0PKM6TpQnTb7NBqLtDj2m1G+6UZyCQEvGcbQSp6s/oQj?=
 =?us-ascii?Q?dCYjYhr97ony9QYJ3M2o2yalF3EVCzcs1qAl9wg1eeqYhRnqbCVmABQTfQ+B?=
 =?us-ascii?Q?TfU0lOxRop2wADUKt0vIObMNF5cnGPmtYq7Z+TOrP3U7/RbreQFwqThivHQV?=
 =?us-ascii?Q?hfpD1ho8iL42y99YkWdaKkBlGC93OC8nfuLcFeynZNKtjOPVfc/4EpGLnYOg?=
 =?us-ascii?Q?HFsQuSSXLj+rQYFajlvOC93iM77kRsBZa5xmjTHGVclAw9FB8ZoesXxcgcty?=
 =?us-ascii?Q?nmGqS88NgT32lpGgAxAg2+lcEHH6VBkc7bX78nMyhRzqBuUt6YC1NqfHVbC2?=
 =?us-ascii?Q?YGO2ppZzCfc6i1Qsld4LULSUDRufHan1W/Xup8xP+QMmkLoZNa6uXG/gJvRG?=
 =?us-ascii?Q?rZyZRveEUilRSFiawY2+DClUP09KqZQzx9jSzHP9CKvCrGj3L9dO+d3CCYkG?=
 =?us-ascii?Q?pACAwiOEtysbYLtOovUGP8Nl4GVFTWwNHzBlyYMXztg9GASqqUuVCIdxDa/a?=
 =?us-ascii?Q?sol9W/kvi57TYPNEXtc/g+TenjKa+hjKi5aqC/AXkPum22li0xyfBJ+vtfIb?=
 =?us-ascii?Q?gV0BCAyMAZ+ZTWswV7ZGPZ0lmyzO6LqJEXG7HTcj2ag9ewDZ6qFKoN5rIswQ?=
 =?us-ascii?Q?ESEBhvvqP6wB1vk+yURmYjvo3tMCwkzxyhl5UwDp9xtB7geTAvYCyztBUbNK?=
 =?us-ascii?Q?AtbjWU6Pz4aVrFkQMa3e7wcv/OwbJd3jWOLqy+IwJu4doHSvUAJxEeqXYECx?=
 =?us-ascii?Q?VkVAiK2sHdsnIYkSE/YunZmMpdamLDnW3hzfITS0mwz5jta8+COKUGeXhNi2?=
 =?us-ascii?Q?ONdGMtqJLVwmmcEfZFz3tRGQAKqP2e/PbDcz6JBE2zoy6Ud7U8oUnR8cALOv?=
 =?us-ascii?Q?kyMFkDCaqN8S7m9oDhWrUSwbmxBGYlzrjWDtmyU7dts7iPqQ+8cttCRJwD/6?=
 =?us-ascii?Q?+bwGjg3KRCFJjrXsiWpDshJfGCscDTPE5IxqI/E8lqjE9Np4ohPkWrmjVwIj?=
 =?us-ascii?Q?Pg5AEp15MVrhZyDqdPUYF3aUq4IGjehAUs7BwxVwUCRYJE0B7h53uGlB4+cT?=
 =?us-ascii?Q?j6WbMIym9hdyjimZmMGINti0mXCkwxC6ohc2pS1YnOnvY+qIwaBoG6PaI9r0?=
 =?us-ascii?Q?rdwMfZxEN6Km+jKRQtgM6CMijAP6U/bfOEoroweu2bYBHpqlDzHxPr/K1Yo5?=
 =?us-ascii?Q?Co1W0LvvIzSnadQoZoNszFXnrJef9wxShf1J8M5n3Ps+hDyxvwAyHDzkaSS3?=
 =?us-ascii?Q?JTkfq4qDVJlF1+v9WBX3w/tWoXn+SmoO65cXF8w90PQ2wZBJkYGEZG9zVufO?=
 =?us-ascii?Q?0jMeZ5ztF9U8eLqrvSYULO18yvNxOzltE5dB+ZOPY0KjwR9ilIBcSr3Z6kwU?=
 =?us-ascii?Q?5nqdEqL4ay43FALqjfw1F25jcjhPlcrDnI5CGhOxoj1wByfT/4aMjV37beax?=
 =?us-ascii?Q?AHDGlXgDJqlKjg/SFIj048RD0oSFdvrk8USvg6fmJ0niP8V76Ut+epxJEE0J?=
 =?us-ascii?Q?QhVOqiGZLc0mZJfGY5MHWyC9/3v79PlAV+00fYBwrUxbM8kt7csO1yRt1gm7?=
 =?us-ascii?Q?KsN5adfE6jzld8jvIZNYZ0CwQM3Am0cqHWH4t6UaSm8PDU2TRDMMVi6kjlWR?=
 =?us-ascii?Q?zBdsVlEjF3RN7oQca8Kfo3df4vDYAn8nn0n0EWL9K1dH8mCP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5613b9-00bc-4e43-49f0-08de4ff80f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2026 03:26:36.4695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAfc9vhMpJWF4/aYSHfrdUXeW3dA4Km2F58xcn528o7IuuK3wZO3+/z5dWbMY/vu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
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

Should we validate support for the specific target queue type, rather than =
allowing the userq IOCTL to proceed as long as any one queue type is valid?

Regards,
      Prike

> -----Original Message-----
> From: Alex Deucher <alexander.deucher@amd.com>
> Sent: Friday, January 9, 2026 9:58 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: make sure userqs are enabled in userq IOCTLs
>
> These IOCTLs shouldn't be called when userqs are not enabled.  Make sure =
they are
> enabled before executing the IOCTLs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c       | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c |  6 ++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 98110f543307d..256ceca6d429b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -888,12 +888,28 @@ static int amdgpu_userq_input_args_validate(struct
> drm_device *dev,
>       return 0;
>  }
>
> +bool amdgpu_userq_enabled(struct drm_device *dev) {
> +     struct amdgpu_device *adev =3D drm_to_adev(dev);
> +     int i;
> +
> +     for (i =3D 0; i < AMDGPU_HW_IP_NUM; i++) {
> +             if (adev->userq_funcs[i])
> +                     return true;
> +     }
> +
> +     return false;
> +}
> +
>  int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>                      struct drm_file *filp)
>  {
>       union drm_amdgpu_userq *args =3D data;
>       int r;
>
> +     if (!amdgpu_userq_enabled(dev))
> +             return -ENOTSUPP;
> +
>       if (amdgpu_userq_input_args_validate(dev, args, filp) < 0)
>               return -EINVAL;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 7a5ec17704567..468b65d953b0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -136,6 +136,7 @@ uint64_t amdgpu_userq_get_doorbell_index(struct
> amdgpu_userq_mgr *uq_mgr,
>                                            struct drm_file *filp);
>
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev);
> +bool amdgpu_userq_enabled(struct drm_device *dev);
>
>  int amdgpu_userq_suspend(struct amdgpu_device *adev);  int
> amdgpu_userq_resume(struct amdgpu_device *adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 1a23e7709dea9..d6fc65803a309 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -493,6 +493,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,=
 void
> *data,
>       struct drm_exec exec;
>       u64 wptr;
>
> +     if (!amdgpu_userq_enabled(dev))
> +             return -ENOTSUPP;
> +
>       num_syncobj_handles =3D args->num_syncobj_handles;
>       syncobj_handles =3D memdup_user(u64_to_user_ptr(args->syncobj_handl=
es),
>                                     size_mul(sizeof(u32), num_syncobj_han=
dles));
> @@ -680,6 +683,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, v=
oid
> *data,
>       int r, i, rentry, wentry, cnt;
>       struct drm_exec exec;
>
> +     if (!amdgpu_userq_enabled(dev))
> +             return -ENOTSUPP;
> +
>       num_read_bo_handles =3D wait_info->num_bo_read_handles;
>       bo_handles_read =3D memdup_user(u64_to_user_ptr(wait_info-
> >bo_read_handles),
>                                     size_mul(sizeof(u32), num_read_bo_han=
dles));
> --
> 2.52.0

