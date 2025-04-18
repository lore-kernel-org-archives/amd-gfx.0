Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D55C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 13:04:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F9EB10E004;
	Fri, 18 Apr 2025 13:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pa+FY6Gp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3097210E004
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 13:04:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0Dzj9YSb+WJCAWSncT88rjPB32J6n75Z6EJsUu8VjmLJa8t1ZLJA7MZOdmkfGr2bGguEcxHNxHTaC1dY7YHipkOiMTSpY7rXoHppCOzJNXdlP+a2XvNTJTV8nl4artmecIsrQrtspuRnhXgLQAifvm0Vlx45sP0YEd3S0bFBWFklzuxWpQJs4FXD7pgc0wJJkGaGAdg6RAHsMJ2H5emQ8n6keUbyxHy6jzoIWiUikzTvPMgEHmNCLArChn5oJ7vgQx+GSzlqQz1QPm8DEwJItwK9oANErRaN4yFfeXV/GxO5p5EVcUSRuLerasgiUI1CjLMZSuoWxfpA/Ov6bUxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1K32dohc8x6cCWZyhePVpSWaM844o8tlfTeJXJBVpQ=;
 b=x+6nV1y1zH394ivx3UViHljxkSMopwLnCv8pHkCiFAzNrpHVit4Z8k037Q0XTFgEc5zxb9m55sVIrOqP7qXOVdOhkNCfjdw7gPjrLPjJ+XULxSzn/Ouk/q0CtKgSAr5G6rcdOgEf42E071f1SpJwBjzc1wsEWrOb921EOCgBSrM//oi1BxcTcaBXQ6XiMu2cMpXGAGmylWfJK3NI305WRObDUKIEjRqxTJPFeLTlzjsn+S8qojXjKqUaf5qCjRhgM0VCJsABxjbDno+FnKNEiPK83IWTGIGcJ1JoeU3Wbrs6ObEwDaBRLXtnkpgE1QJnyQlyz6IMZsAo0uHCHymtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1K32dohc8x6cCWZyhePVpSWaM844o8tlfTeJXJBVpQ=;
 b=Pa+FY6Gp/wFNBQFddx319EXBBnI/YEdLXvokXTjJnXK08Qq05I3dRlO3xMqjeAvHxxLjBscnIgnzcwo57fMemwcITdgdjOxZ8oxFofUvyl44Jqaq+YHSVNjnIHnwmv9XqcE6y9RSfYCsrIa8TD8cp1avcjxEmVmst+iP1mJ6SL0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Fri, 18 Apr 2025 13:04:43 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8655.024; Fri, 18 Apr 2025
 13:04:43 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/7] drm/amdgpu/userq: optimize enforce isolation and s/r
Thread-Topic: [PATCH 2/7] drm/amdgpu/userq: optimize enforce isolation and s/r
Thread-Index: AQHbrx3hKgappiTTeEuGAHwZYP1KmrOpZpbw
Date: Fri, 18 Apr 2025 13:04:43 +0000
Message-ID: <DS7PR12MB6005239809991FA2BBADCCEAFBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
 <20250416222046.1142257-2-alexander.deucher@amd.com>
In-Reply-To: <20250416222046.1142257-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=575569d1-50be-4440-8c3d-adadeae0dbb7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-18T13:04:37Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DS0PR12MB8786:EE_
x-ms-office365-filtering-correlation-id: e825c639-ebb0-4533-52ae-08dd7e799678
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NGQXqiHh2cKLFtcTyQuGeD63Q9JwylgepU1/zTFad1Z+CRou66/7TQZau/Q9?=
 =?us-ascii?Q?awfhfRZRl3ipxxSvEZ2Bv8+FIoVF0amZGf2g14FE4jVoPZUgsIOtP/J5aW6Q?=
 =?us-ascii?Q?CrsxQ4uWS/a9VoaJ5CvE03ewtYwUXCbJuNE85aoGeZKGLCcNoUA7n9cPq4mf?=
 =?us-ascii?Q?+QBSD4pJeI0Ko0/zX3QuG7xxh9BZBPvnRWJcJwD4crNB6qVqnA6b26EaV4A/?=
 =?us-ascii?Q?/19hKfGVHLXFB1YElFaDlCIaZnYmQe/arqhi+AYPFtXtsVxXkwHLpXpAZyL9?=
 =?us-ascii?Q?UVUbvv/PARCBlzVyzWVFiIC+ewRg/xYDx95LcUZaUAQk18NV6BEksrNnQaHt?=
 =?us-ascii?Q?WGJgByOFVFeN2NHSDZBEDTpt9GPoBGxsZiSkHoXH29SSS3FxMyQTIQ2l6TPh?=
 =?us-ascii?Q?BS7YyD8nIG7pxi9bWRYQD6FFdZZAVZRM04sOOCYwINe/lGzUIRM7/28C78vt?=
 =?us-ascii?Q?SJEuW1JprpMIy7szkz5vNCi9NHJ/8gMoWfnJwea9jWe5+hhp8aEpLHCnjVG+?=
 =?us-ascii?Q?UtjRa9qEfDlLBY9KYBN2BkelGGAM9rxtbjpcNzKMPh2D9WFLiFpykWltIjht?=
 =?us-ascii?Q?7BTpFgBIdMDw5GRMksadF8PejfPjSU4gxlj1sHhI2BG0k9rpd3Ce2Nc5cwh/?=
 =?us-ascii?Q?Gde+c+myPmggi0FwwDznUYxqvOAVYNJokbILjPK/ZeB88k+y8L3NjpKW1OR/?=
 =?us-ascii?Q?KNfzbBiMHpDQACPXncR68Vuw9C7EHx55z0dktiaiZNcTAgGt3JRo0L/LcTyi?=
 =?us-ascii?Q?M/8TfpB5TBh7apavAUk6U3vCAWvwCLiDW/1/o0HMcQfN2QJLkmzREEJRW6KT?=
 =?us-ascii?Q?CI2OBDwUdKMcR/xn0o3tAOenSA0QFYWw0AK+RWPkzjVnm8xl8WJVO17G8LGV?=
 =?us-ascii?Q?icxFur2qu/RRZWf2U5iWxKHCY78OvqGpI7pXuJWCGBvFe97gaF0olO7zvuYX?=
 =?us-ascii?Q?S7Lnn4CLGVt4kHQGEHuDsfS4UPW9jttONOE7ZlYbsjbErR3VWqxtw5TAt7Ba?=
 =?us-ascii?Q?WU04P9bqayi53axv1pqwCVEvnB0o2N9BNBDnetAiwQenQD12Iq8ZDvlqLXc8?=
 =?us-ascii?Q?cv3JTzcnKCKjvFumYE2lhHpnXoeJu7YlIpleOKZpsvFSqqgEijha2ARDN3W4?=
 =?us-ascii?Q?fo25+klatg4lGGhhLw8yuSL9B0qOoxDOqy04QCt7sFBcyL0iEWHwV/+QU+uC?=
 =?us-ascii?Q?uQLHirtILhGHT/3gV/jTc5yvCcB5P/pfS9lKyShfI0FWCisUdQe/NlVFq6Ek?=
 =?us-ascii?Q?oGlqEsuMZsGhAMuOw/38fdiaqoJGZMyPpGNFXO9hh0wAK9LbMaNHMhbvE25z?=
 =?us-ascii?Q?QR+899UeVc3GYFuG7vLAO8m/DcCtxbpLC7BK4qyTEJlawp/q0XyUSNNUg0vD?=
 =?us-ascii?Q?anZhQLQezl4D6ul6hkVbZcv5uztD9bdeppYu+1/vaw+pLsoq7T1/s2sVJUX/?=
 =?us-ascii?Q?mmrRlwGjzjeAujs7RlAyc5PhYdZDt/qsf6wd06lPSqDeAlIfd8LKAw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?beu2Q6nIcoY5Vzq83uSIaXMnJii4SEOSVS+YuUliwGac3FIe6RKsRRSFW2Nt?=
 =?us-ascii?Q?qsTuvJsqDxmtdo+ekhyUVvtlUvFfRUOp7v4SH8fbEaaoMzyYJMNbh3xSEdYP?=
 =?us-ascii?Q?YdCp0BZbFJCqDcmPolR+dlEauiGz/5ixl6SWuVVKaIG/hdGx0gNyVQuCUPrQ?=
 =?us-ascii?Q?PSgbEMq1xkoS4+mzafmZr9uLmt98/2/H7isR1gSWj6tgSdq30ZYOMInYKeW4?=
 =?us-ascii?Q?Zvrs4KB0nX+5DbqzY8DHKGgHPVlWFrKL2JrXIq8l6bDQnyZZl8rASzoAUqnG?=
 =?us-ascii?Q?IoHMe5EOcKfy2nlYN9z/WXDcVAS7AQ0DKn8x6jRZhGwVAqTq3M1J146Ssu8S?=
 =?us-ascii?Q?DwFvtDvQGInfcolTP116+Fcy/MAZYNfUvUBwvft3FbWyPs7wjeAbeHMMq2zx?=
 =?us-ascii?Q?/iD64DOcSlPz1jb2x2DF1Iwh1qE1eBVKOQjxuqmZD1b55J86eB/CiWlJwcai?=
 =?us-ascii?Q?aAXRq3+c5p0MSIGaQBjpNw8b5r3Pz6RJsXyuVq24PiT+81W5IlMH689RvvGX?=
 =?us-ascii?Q?Nq15ggEypmoHZiC8atbTJrdN/OfDOUoAJ+/JO+s1imWW3DTBjjCCzvgUd6mL?=
 =?us-ascii?Q?vhEkH4+YKHlPsiNOg3OWpsFwLKux/yh6dm6pBB40t2zC07mElW7Yb7edSf1B?=
 =?us-ascii?Q?o1ygXfesaBhPuc0W6l4MSM51RyB3+YT5g08vUzRy7c6MKAYKY4i/5SAQfgF/?=
 =?us-ascii?Q?QiagngbYNAVVf6scsgBWvF5+Jyku2IEoGy5m796aAtOHQsurXoqDZeM3KMl2?=
 =?us-ascii?Q?Mhs4xyjiBQhj4+JH7bUiT8xnfF+s9R4ka3XI7+s7lGtqDingM8ZiIoKWEEwn?=
 =?us-ascii?Q?0ZEz2TN0G3x3J9V4V+FOVUXfP2RXAMH9PKUaKDDqV8sP5wqPule18IkVz9Tl?=
 =?us-ascii?Q?9NWXTSdkFohInw+NYRUFlJB5506hhkpq5UYd9YzCZJOmCUL31jy0MsiMvsdL?=
 =?us-ascii?Q?/40TuPf6k/Umwruoiia8ssAKxE4gZfCMd5Co6JCp1YVcc92qJM5vmDwlEftG?=
 =?us-ascii?Q?5Hea5ovvKrAZD0ZNHWSVku5ZVG9BbgJLdsMCherh5KZKw0bVe7EIz3YH3VMC?=
 =?us-ascii?Q?4BkukYUNcNZDGws+BFH6+dEhOOQUPE2HAQoQFjG3Gy9jqQs72Cq80BdQRwik?=
 =?us-ascii?Q?GyvA9i3ICHJ/WfwlduPQs/Q0N9VMOY9+bhSkW7M2kTEWUHN2XW9jkAnrbATb?=
 =?us-ascii?Q?MYZOpg7l7zg5giYlvreUhn4UG3Jcu/2FKnWbYiorxITqBDiwt5QPRG3NvfGs?=
 =?us-ascii?Q?B01hxl13sNEp5Mqh9AtI+Tk+rZ86qFfAmb0mDZ9JfrsS9tAytOsT80thX383?=
 =?us-ascii?Q?hz+b1EUJ7DHhv4JeLJteBr3EiK6T2GAaPbRdANljhw+8HKh5592WM7ShK2vk?=
 =?us-ascii?Q?K6C8rUBgbIgG7LmSgD/ulCqzbDIO/W0yX6c+cfSWCu4XmZ/wYXsOQjoJwedd?=
 =?us-ascii?Q?GBkUNpSQ2hRKjAB4guTSCKGcCC6gTLT268Few9dH+bBrNxdR9ThHhE+aCHWR?=
 =?us-ascii?Q?khJsq5xKR64vsn0IHRmtdfB2t3S72yc1O1jNcwxKijQaWY6TnmadZc7yEuLQ?=
 =?us-ascii?Q?6lq+ka1oAIX8Z5gLPNk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e825c639-ebb0-4533-52ae-08dd7e799678
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 13:04:43.6776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8i3B1Rh425d3JHPfPqNJ65oWBdssxSiWuqEpj3gB1s+qN9uOUVRR9+lQh5JD73z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 17, 2025 6:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/7] drm/amdgpu/userq: optimize enforce isolation and s/r
>
> If user queues are disabled for all IPs in the case of suspend and resume=
 and for
> gfx/compute in the case of enforce isolation, we can return early.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index dbc1fcdc0f73b..04583f9d134f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -758,12 +758,16 @@ void amdgpu_userq_mgr_fini(struct
> amdgpu_userq_mgr *userq_mgr)
>
>  int amdgpu_userq_suspend(struct amdgpu_device *adev)  {
> +     u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
>       const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
>       int ret =3D 0;
>
> +     if (!ip_mask)
> +             return 0;
> +
>       mutex_lock(&adev->userq_mutex);
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>               cancel_delayed_work_sync(&uqm->resume_work);
> @@ -778,12 +782,16 @@ int amdgpu_userq_suspend(struct amdgpu_device
> *adev)
>
>  int amdgpu_userq_resume(struct amdgpu_device *adev)  {
> +     u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
>       const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
>       int ret =3D 0;
>
> +     if (!ip_mask)
> +             return 0;
> +
>       mutex_lock(&adev->userq_mutex);
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) { @@ -
> 798,12 +806,17 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)  in=
t
> amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>                                                 u32 idx)
>  {
> +     u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
>       const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
>       int ret =3D 0;
>
> +     /* only need to stop gfx/compute */
> +     if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 <<
> AMDGPU_HW_IP_COMPUTE))))
> +             return 0;
> +
>       mutex_lock(&adev->userq_mutex);
>       if (adev->userq_halt_for_enforce_isolation)
>               dev_warn(adev->dev, "userq scheduling already stopped!\n");=
 @@ -
> 826,12 +839,17 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struc=
t
> amdgpu_device *adev,  int
> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev=
,
>                                                  u32 idx)
>  {
> +     u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
>       const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
>       int ret =3D 0;
>
> +     /* only need to stop gfx/compute */
> +     if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 <<
> AMDGPU_HW_IP_COMPUTE))))
> +             return 0;
> +
>       mutex_lock(&adev->userq_mutex);
>       if (!adev->userq_halt_for_enforce_isolation)
>               dev_warn(adev->dev, "userq scheduling already started!\n");
> --
> 2.49.0

