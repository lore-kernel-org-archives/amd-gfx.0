Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AFCC28B28
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 03:09:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF0410E396;
	Mon, 10 Mar 2025 03:09:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d4aLk5C2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D5210E396
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 03:09:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pm2c8mIyHiAXjeOWhWOks8lomTSK1XOL9m2Ir/pZAcnxA01xU36dmCB7Ky0P6tgIQycC+w+ZaDRRYlsVfm3Xb11g5hC7XATLtOVrUi5zbCjyDnum7L0tbYdKwPT8B9onRpH07AML+c2hpNbL6dbSuCr9M0qUGhxqK2TzJERenIp1dLljx6+YKX6+ng1MRLWFWHAoSj53LvmD/WvP7hd06pmHSJSSCfVjB4X3eTxdD0oFJBLdsVGXoHkorzjlk0elRb6w4+ycOkNgQ3sUcQOP/7tnCn2Xb1+XYPmN4cxFA5mZaGndZA8+CO71LMvD54zgK2RyTsd90ma1KmAzicLleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zau5rQuB9pn3mV4zgVgkxp0a1DW7XMxzzVrkcgQc0QA=;
 b=UgZGqtm8hqBOwS4tXsYYSL+gKJcYYyj41xUwUah02k8m6CNyjq+zwqHekdzZlN+78U7JHUFOiyNJPFSL91IF1XjENb5DLx2DNkttrPdBAi1BARIg474T1sPYYJ1S7NFiBSytv+PLjyfr+XbSLDVSklhpjUlZ5X5cpKSgPa00wBUTNvnln60BgA0G+jMchvnQTuSjrOQJsS6gQWL9htCyq4ipyfoyDpXwsdgGeHXzfwjlTQh5Kaq5GIY3e9Z5UiNn+eoPMBvYYtp6JTKq8SvZiZaul2ngYaEFNLUiin/jU2vTIyOKLUxx/gk2N2CE0zcH4Slf7NtpScgvnSxnd4YukA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zau5rQuB9pn3mV4zgVgkxp0a1DW7XMxzzVrkcgQc0QA=;
 b=d4aLk5C2pgmo5QO1/CQriIQ140GcFMryeWdvHK2i5yr/RwC9zgrjFPRS6PErpnJiDsJvSk5DRpp0i/Ditmu+Kewcm2ypig6YIDXTl5IiAQdihcPNokUvSLSOdGHlLEUVqWaOgaNANUUDHvNnCqp+04SPvWQRuRHlaFL8zpr7tbQ=
Received: from LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 03:09:20 +0000
Received: from LV2PR12MB5774.namprd12.prod.outlook.com
 ([fe80::9dda:b8b4:caea:5204]) by LV2PR12MB5774.namprd12.prod.outlook.com
 ([fe80::9dda:b8b4:caea:5204%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 03:09:20 +0000
From: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
CC: "Chang, HaiJun" <HaiJun.Chang@amd.com>, "Chen, Horace"
 <Horace.Chen@amd.com>, "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>
Subject: Re: [PATCH v2] drm/amd/amdkfd: Evict all queues even HWS remove queue
 failed
Thread-Topic: [PATCH v2] drm/amd/amdkfd: Evict all queues even HWS remove
 queue failed
Thread-Index: AQHbjz/hQzGNLOmzCU+wepX2YiJyR7NoKWQAgAOLAsE=
Date: Mon, 10 Mar 2025 03:09:20 +0000
Message-ID: <LV2PR12MB5774822C42AA5DA207248EDBF9D62@LV2PR12MB5774.namprd12.prod.outlook.com>
References: <20250307085321.677381-1-Yifan.Zha@amd.com>
 <3f3b9720-5f48-4469-961c-a13772d4cf33@amd.com>
In-Reply-To: <3f3b9720-5f48-4469-961c-a13772d4cf33@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-10T03:09:20.442Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5774:EE_|MN6PR12MB8567:EE_
x-ms-office365-filtering-correlation-id: 87227c93-2d69-4012-15f4-08dd5f80f3dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IlZq8k5scQTiSLteW1WiVw6bKhupr1GaL8zUX9tZd8sf1cSwCVmHkKxGof?=
 =?iso-8859-1?Q?+pFMBIxikFKGQHeB4Rz+D+hSYm8BTewqWnnta22AREEZ2OIdfBHUhRSmf4?=
 =?iso-8859-1?Q?SMBmsE5xCjQcUudzw7X8FPue9/CnHqx23mHo+RTi7916/HUOes8IO7/eXy?=
 =?iso-8859-1?Q?r4S3u74lRZAAo4I5bBdzgEejBNZAQisUcrWjMr++yfUGJO6uoxrv1m31RP?=
 =?iso-8859-1?Q?lgKoX6+QngB+8OyeDmKnxlxrYPEkt0+UTOXPSrdzEdstJXOObO6RkEwFgp?=
 =?iso-8859-1?Q?nFcYx+BTT8LmV0x2GxBlXRP/pODkJznA4MDVt4Z/Vo7VrO5O10w+UxDYWZ?=
 =?iso-8859-1?Q?7flTjGnTGMi3lykjIUIqKHvawduL9eoD+LTVDW28hlDTB1AdDWZ/JzqXNp?=
 =?iso-8859-1?Q?6M9KYS8xXrfEMHdOuqQqPF6IsGtF3dDZsaWCy5b+r86xgNnq/6J3YwhkUk?=
 =?iso-8859-1?Q?7TV5AHJ3wsKY7nDG+GM+FQlwRcBqeEwjnBcFv+C/0t9cmrmEsC4yV7GC1M?=
 =?iso-8859-1?Q?Xphwxi2RlQNr0EyYg0wyFCqNJNdG39ZhEPny6WDD5OoYu4YlNtshJNjxut?=
 =?iso-8859-1?Q?Abw/0qmZHb+EWAUtkYmqfD8HPm+fZ4qMxn1oghqB4o+sVFAMNA182k8ZX9?=
 =?iso-8859-1?Q?59WDMyA/yD8aYeIJfQMIqBRkaaXudVWrbWv3BWgY3P52EIPwsTYZ7IkThw?=
 =?iso-8859-1?Q?xff7lDU3ZTRxQRNLABGq7WgjeM7IsG8H5uBgajeL9C723YEyKMkJFq09ov?=
 =?iso-8859-1?Q?ytow5j7afECTx8JUjR4oVE66dryWfjw2PbSxERANifPjUs0evO7ACsgiFI?=
 =?iso-8859-1?Q?Iow1nqHJOluO3l+NfY8+xWbOAOJZhz0vypEVakO2cWWSJLpPmEd8UxHNMW?=
 =?iso-8859-1?Q?opB/gv1Ipfou5UC9URfw2qR9dnTq0o1GbbGhc5lq4aI/TnIMVLDIQO4Dhp?=
 =?iso-8859-1?Q?OKJTltiRV3CoHtwpLZI9S5Kx3J2sRjutTZ33IroOzky8iRNf3j3YDWArsC?=
 =?iso-8859-1?Q?4WZ0YnXvhQMLaLjrc6P7kg9LMWA9WJ7P4vXN+nC0DJ5gaBIPfWSwLx5NjU?=
 =?iso-8859-1?Q?nP1a8QwogplXg7PKROB8TnRYJ50Mby3XWe6cdhM4/ENBBtUPsqd1kHA4bM?=
 =?iso-8859-1?Q?k/gDylBY6R1Cx8DFGLbvY49HSkxIuEk29/yQnBYFH9qUTdKcKIAVokPGVn?=
 =?iso-8859-1?Q?Wr6y8r10lIrG3U9c0YITOnHfzojNrAhgtuqwVhljZZIsU3qjSlzeK+oGj1?=
 =?iso-8859-1?Q?1hTgxl8+Xao3Viglx58ZwDHFmT/dwUI4H0F1Ydmq8rub1rONY9oiiYs+pE?=
 =?iso-8859-1?Q?CASdpFrL88sn/W623drEs4mdVAzlblBncxjMoc/G4VeCHQMTdr+cfmASqd?=
 =?iso-8859-1?Q?n6KsX8gkBVon6i57uFmd+qpaux2hxawwxZR0OZwkjbRqSISZ/al0R+tQaX?=
 =?iso-8859-1?Q?/wcxKJHVc3Q7qz7pT05RFQjc8Dw4vnDnNLssMVBFdId6qT9H4bBCsc1n1z?=
 =?iso-8859-1?Q?vi9Tz2CN9MqCiYkyzkcjg7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aEJj6ygsoYupIN/fbMS4OL90rrrVADtn5f2VpeeNIJICxKtq/gYSIakthN?=
 =?iso-8859-1?Q?OZDDD8tDemrTHl2Jgl1W9UDNBz3M6TA50ime2US9yR1u9/35KZFMnpz1il?=
 =?iso-8859-1?Q?aWt1GP2e4OiSCFd5Vd173SIvV5zu27OkGgl+EK7wiExDi0WDPL7/HR6SWn?=
 =?iso-8859-1?Q?vM4Rw1dSq6mmJ88bArUFsSljqUXHZETtEgKi0A3l5LQ3J8MpVt6CgSex+e?=
 =?iso-8859-1?Q?P/d2GMjVijOdUNLZPVisIK4rfsP0nZ6P0HrU5zyJKBt9yA/O2TCiFTNUtq?=
 =?iso-8859-1?Q?EPDGwIAqBPWx7LFKJSc3Olq3Xle99hMTV0NkBPhMPacbNO42aPVhjI4Wyi?=
 =?iso-8859-1?Q?cA2M2/MntMFh05WLVkb+KOg/lSO2VQpIbr7zzI5980VD2rtBORI4EXQ670?=
 =?iso-8859-1?Q?kFZfs2F5XTf9XR4n+gJsxj1PE55t4RpdWWURsask7ZZ8sBQQdocRggJq3s?=
 =?iso-8859-1?Q?/O0GtfL/K+8HCnao4VZWa6tpwaclYiSTXnwrT12Mr/qh2F97c0b0X9u7xs?=
 =?iso-8859-1?Q?8nHZPQwl4PJrBAj4OCFAeuKSCKbpumomVrNV4nd+RrIwIaJ49Xing8N10r?=
 =?iso-8859-1?Q?SQWxf0M4sfROrFL2sC+G0NDbIcEN3D5D4ahVhXrT+YFJhY8FvrlqxzRzdG?=
 =?iso-8859-1?Q?2SiCLI1lWcbsBtS/yxrJnkLKImZQXEKHrNeAT0jCOn+XrJU600efGmyCL5?=
 =?iso-8859-1?Q?OyS5pZNyC6L4M1N/yexCDjPbmKSCpHuEnjwhj3+emEcLplM21UKonvupDd?=
 =?iso-8859-1?Q?Rj90EC3Y9rMjjkxvIAhlICcV8/WO+tFj1GJUTDKS1TitsBCyZGuFHl9Kmk?=
 =?iso-8859-1?Q?qkzwN7BwZMvE9FWOiyjv6Sl8aLndoeETxbX4EdcVyZFKWhk2l0ikbe+tSf?=
 =?iso-8859-1?Q?Jhl64kSfWWTNbsSTDEIzgNWBlw13qKG/akW0Evfb6WEWhfsSRr9P5snx2Z?=
 =?iso-8859-1?Q?K7phYfbWAE+Ojpxg6sQ1LR1wv1KDZKt8mFoIW3Z3+oMqwsBM9V8Xt4oqjR?=
 =?iso-8859-1?Q?YmJ6Y0WR9Qm6gUq5p/oQY3mPDXxemPBlbMuHILNc9Z6CA3nNaO8RYCTRq0?=
 =?iso-8859-1?Q?UACNIxFQBEkcCaHASfpDkppXVTNO+iMn+D97S20byRAOCS8fHEsAwovwfi?=
 =?iso-8859-1?Q?VX2YVYPGbqRGIVox+wgAmjd7cOoJjPP/Zs6vDkvZQYQQtqVw7gOfdFkQGt?=
 =?iso-8859-1?Q?B96dtWQ7VHYQceAXcMLj897XQgmvDHwmNvckXr1ud29r6+5IqsgNDjnSy0?=
 =?iso-8859-1?Q?gpyRbZvmSa8q8ZOVj9HvvLIXh4WeJmX2VRI/fjCeRvl74M+NhPL+Zt/6KF?=
 =?iso-8859-1?Q?6BzLqIDq2vg1FpFewn00TYuPUcSQ+xViojTEF4W4rkWVk1gZUeYnv7olY7?=
 =?iso-8859-1?Q?h2bHNBcBncxE34P0djMWilsMB70cEt4WTZOAINvIfnfxWTOxFVusRu8Vrl?=
 =?iso-8859-1?Q?hFx+rw3LqkA9Kn0tBhHhbG2kMLlJ0RmqD1OF+uqv8tpOBauiurQgDv6eSB?=
 =?iso-8859-1?Q?T6g6WX7aopEWyue77ZLGJcuBfVEvvtvUkU10HekLBmjZPRuNJM7r99XhzF?=
 =?iso-8859-1?Q?1XCTSN7Go9WfM3pbuAPo6Ja/1JseqAFNnsqBRaEdbYS6ejb4o1lF6p3uUQ?=
 =?iso-8859-1?Q?bQN1S6XpdrC98=3D?=
Content-Type: multipart/alternative;
 boundary="_000_LV2PR12MB5774822C42AA5DA207248EDBF9D62LV2PR12MB5774namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87227c93-2d69-4012-15f4-08dd5f80f3dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 03:09:20.8068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xo2jOyAsj8s4op+X7plvvsGmT8+j6yXsQ2bWG3MY+UErymRD4FitfAgSgnC6KGN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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

--_000_LV2PR12MB5774822C42AA5DA207248EDBF9D62LV2PR12MB5774namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Thanks Felix. Declaring err inside the if block is better. I have submitted=
 patch, could you please help to review it?


Thanks.



Best regard,

Yifan Zha



________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Saturday, March 8, 2025 5:00 AM
To: Zha, YiFan(Even) <Yifan.Zha@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chang, HaiJun <HaiJun.Chang@amd.com>; Chen, Horace <Horace.Chen@amd.com=
>; Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
Subject: Re: [PATCH v2] drm/amd/amdkfd: Evict all queues even HWS remove qu=
eue failed


On 2025-03-07 03:53, Yifan Zha wrote:
> [Why]
> If reset is detected and kfd need to evict working queues, HWS moving que=
ue will be failed.
> Then remaining queues are not evicted and in active state.
>
> After reset done, kfd uses HWS to termination remaining activated queues =
but HWS is resetted.
> So remove queue will be failed again.
>
> [How]
> Keep removing all queues even if HWS returns failed.
> It will not affect cpsch as it checks reset_domain->sem.
>
> v2: If any queue failed, evict queue returns error.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f3f2fd6ee65c..b647745ee0a5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1189,7 +1189,7 @@ static int evict_process_queues_cpsch(struct device=
_queue_manager *dqm,
>        struct queue *q;
>        struct device *dev =3D dqm->dev->adev->dev;
>        struct kfd_process_device *pdd;
> -     int retval =3D 0;
> +     int retval, err =3D 0;

You should still initialize retval to 0, otherwise the function may
return an uninitialized value if there are no MES queues. err does not
need to be initialized because you're always assigning a value just
before checking it below.

In fact, you could declare err inside the if-block below, since it is
only needed in that scope. It is preferred to declare variables in a
more limited scope if they are not needed outside.

Regards,
   Felix


>
>        dqm_lock(dqm);
>        if (qpd->evicted++ > 0) /* already evicted, do nothing */
> @@ -1219,11 +1219,11 @@ static int evict_process_queues_cpsch(struct devi=
ce_queue_manager *dqm,
>                decrement_queue_count(dqm, qpd, q);
>
>                if (dqm->dev->kfd->shared_resources.enable_mes) {
> -                     retval =3D remove_queue_mes(dqm, q, qpd);
> -                     if (retval) {
> +                     err =3D remove_queue_mes(dqm, q, qpd);
> +                     if (err) {
>                                dev_err(dev, "Failed to evict queue %d\n",
>                                        q->properties.queue_id);
> -                             goto out;
> +                             retval =3D err;
>                        }
>                }
>        }

--_000_LV2PR12MB5774822C42AA5DA207248EDBF9D62LV2PR12MB5774namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks Felix. Declaring err inside the if block is better. I have submitted=
 patch, could you please help to review it?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" id=3D"Signature">
<p>Thanks.</p>
<p>&nbsp;</p>
<p>Best regard,</p>
<p>Yifan Zha</p>
<p>&nbsp;</p>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Kuehli=
ng, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Saturday, March 8, 2025 5:00 AM<br>
<b>To:</b>&nbsp;Zha, YiFan(Even) &lt;Yifan.Zha@amd.com&gt;; amd-gfx@lists.f=
reedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&g=
t;<br>
<b>Cc:</b>&nbsp;Chang, HaiJun &lt;HaiJun.Chang@amd.com&gt;; Chen, Horace &l=
t;Horace.Chen@amd.com&gt;; Yin, ZhenGuo (Chris) &lt;ZhenGuo.Yin@amd.com&gt;=
<br>
<b>Subject:</b>&nbsp;Re: [PATCH v2] drm/amd/amdkfd: Evict all queues even H=
WS remove queue failed</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;"><br>
On 2025-03-07 03:53, Yifan Zha wrote:<br>
&gt; [Why]<br>
&gt; If reset is detected and kfd need to evict working queues, HWS moving =
queue will be failed.<br>
&gt; Then remaining queues are not evicted and in active state.<br>
&gt;<br>
&gt; After reset done, kfd uses HWS to termination remaining activated queu=
es but HWS is resetted.<br>
&gt; So remove queue will be failed again.<br>
&gt;<br>
&gt; [How]<br>
&gt; Keep removing all queues even if HWS returns failed.<br>
&gt; It will not affect cpsch as it checks reset_domain-&gt;sem.<br>
&gt;<br>
&gt; v2: If any queue failed, evict queue returns error.<br>
&gt;<br>
&gt; Signed-off-by: Yifan Zha &lt;Yifan.Zha@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 =
++++----<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/d=
rivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; index f3f2fd6ee65c..b647745ee0a5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<br>
&gt; @@ -1189,7 +1189,7 @@ static int evict_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct queue *q;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev =3D dqm-&=
gt;dev-&gt;adev-&gt;dev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *p=
dd;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int retval =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int retval, err =3D 0;<br>
<br>
You should still initialize retval to 0, otherwise the function may<br>
return an uninitialized value if there are no MES queues. err does not<br>
need to be initialized because you're always assigning a value just<br>
before checking it below.<br>
<br>
In fact, you could declare err inside the if-block below, since it is<br>
only needed in that scope. It is preferred to declare variables in a<br>
more limited scope if they are not needed outside.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dqm_lock(dqm);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (qpd-&gt;evicted++ &gt; 0=
) /* already evicted, do nothing */<br>
&gt; @@ -1219,11 +1219,11 @@ static int evict_process_queues_cpsch(struct d=
evice_queue_manager *dqm,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; decrement_queue_count(dqm, qpd, q);<br>
&gt;&nbsp;&nbsp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes=
) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D remove_queue=
_mes(dqm, q, qpd);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D remove_queue_me=
s(dqm, q, qpd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;Failed to evict=
 queue %d\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; q-&gt;properties.queue_id);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; retval =3D err;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</div>
</div>
</body>
</html>

--_000_LV2PR12MB5774822C42AA5DA207248EDBF9D62LV2PR12MB5774namp_--
