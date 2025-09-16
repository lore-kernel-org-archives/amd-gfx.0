Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0FDCAC598
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 06:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0052810E2FD;
	Tue, 16 Sep 2025 06:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NDBHUBt+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC21D10E2FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 06:50:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT+xY8CR6lt0OpmBaIXJrOh5cTVP02Jo70lhi4z9Q0WyZFCLeLdw+i7y5NFztXSGRp8QMzFlpYgwY8ztysq693OSfRl/aFx1nJZmBcMiF3ltodq0kB6Dgak6kJYfyVeYbVjBpuDEktklcU6G9tfVd34X8MdnoZoNNv78Eu3f2wEln7RRhqxvxP7ZY4e3H0d/l04Mlw2adJ6yzNGDJ7fBKZ8sK677IxSdZNPu640tCarfWxZvXpw6edf9nv8VerDdvg/PzhdGeBc38TqlEZ1R8Z9bzGwouTHquTl8zc/moktepE3DHwncCfR/9fwzMSDW+2pHB8906LpSMMMfryxpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cuyccuj1mhRrZQmwsfXAkw5ufn9Q8pb5HgBSS0OlF2w=;
 b=yLvD5Rj+w1jO5sSMWFWLEYMAhidnIYINQg3LH23bbDa8al0W3TTsPTzvy+5MaDGs69w51AUaXPcVK6Fuq00OW64VSKznbpxinK8O/VWOY/WHTlnc6IboPkSiK6qQK5W/vZOAbPmeD4NH6+eFXE+BDsH+Z2FdC7Ty8oDHpWV66mT1BJa5vOw2308R7Yh9S6yPq6gr5szfDB34KXx5Auf8Er7/no5HYM9cmcGj+3UMHSxHeQvv1C8DdRdnVF2qvGF8KBymk9MDgnXGYW2GLHYSefBPvdlqsJLt50nlXMJ+BiztSLoOE+XuizJSFL0KIgbULTWotEIwh64aglpCR4ApEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cuyccuj1mhRrZQmwsfXAkw5ufn9Q8pb5HgBSS0OlF2w=;
 b=NDBHUBt+H+y/idehb6j/qR8pN7K6Nc73/3WBOkotTZHLMlRMD0FqnnTPJkd9XUcKiO3juYMHtf7cK66BxslaN0eVMVEPAmOSChzXxDY/rGfUsUZIKnxQ2lBWfJC2gE9zMwTvkEYE945w/bRmuaETXhAfq4+GfLDSASJknjc53vM=
Received: from PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 06:50:06 +0000
Received: from PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196]) by PH7PR12MB7988.namprd12.prod.outlook.com
 ([fe80::ab36:388d:7b1e:a196%3]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 06:50:05 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>, "Gande, Shravan kumar"
 <Shravankumar.Gande@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check for
 RAS poison injection
Thread-Topic: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check for
 RAS poison injection
Thread-Index: AQHcEMnHr4VtWjsyxkmsdIupP5N7PLSViQ2A
Date: Tue, 16 Sep 2025 06:50:05 +0000
Message-ID: <PH7PR12MB79881316E7185028A0A972AC9A14A@PH7PR12MB7988.namprd12.prod.outlook.com>
References: <20250819052548.124897-1-xiang.liu@amd.com>
In-Reply-To: <20250819052548.124897-1-xiang.liu@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-Mentions: Victor.Skvortsov@amd.com,Shravankumar.Gande@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-16T06:44:13.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7988:EE_|DS0PR12MB9421:EE_
x-ms-office365-filtering-correlation-id: bc8af1ae-555f-40e4-6442-08ddf4ed44f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?I4SKvlzkp3kp1BR0vUZfjlQzEpJGQKL4HL5K9d2KGjW2mLz+ELMgQYLbiJ9C?=
 =?us-ascii?Q?9dsOk3ATUea8DbdOdpi0otfEGXZSgPD5aQ49mgsCSHysMSspxfeFHmyN0CWX?=
 =?us-ascii?Q?NTCMcgDcZYoBxPc2WBu2zJrxZMp1HKXaoa2bN+jmjDazznzojdNwQmlG5XBU?=
 =?us-ascii?Q?AZVhNJCidBcV/J9yMDXOIV5Cn4SFHCI5NbWnkIjQzg+poWUnNisiEhuoP7tk?=
 =?us-ascii?Q?DtTfPtrRpnodV11rfw84HIvh0BMfEQ7eYk3qd4hVGzAtOzWJ7g7xjMz5wFIh?=
 =?us-ascii?Q?fjnvxo+VdnyyTjTSgTIYz50ZoM4RkyMI86pzPmxtcSdrbLb2WkaHq81OrbkI?=
 =?us-ascii?Q?Jnr0HgbM4m2TmQs+iV8MHe7kkX3hh2GyIjTrDqj1QjYmsVIXlQWDG2BFZv4d?=
 =?us-ascii?Q?6P/COGugMG2K+ehal1AQwEcZMV3d7JPclGqwJJamgyGk0RSZfdJvWwDEDsWF?=
 =?us-ascii?Q?YRNrFzoKhenPXLnc6jAIO7fMqOO2IUHbaR4oM+ZWS/+brydTgK1HzgNza9KF?=
 =?us-ascii?Q?OynjmYhxFPLD0s1ddUOnLXAMpEUklML9uwkjexEylk1UHhsf7VTXVSw45AJX?=
 =?us-ascii?Q?oegkY2e2pJfXR7TtEIzOr2VTmBuMI7WIOIuUUTzvbay/JeiM23Ohtd98+Tex?=
 =?us-ascii?Q?x2q00AI1t4qgnlL+lt+v08aLAb1A8JXq3GmADkWz7QwqHOlIa/eAJuk9nbaR?=
 =?us-ascii?Q?uQzvnTYkorAybsnXg1brziuAdleetdRGQEoBL4BvwCB82ks2OuI8O4EWOrjL?=
 =?us-ascii?Q?2E9ugxAqaMxnaDiMcdLfDvEm2WBtzuxVtg6FAqWRd6E+fbFwVGr5zWeKp0sA?=
 =?us-ascii?Q?MNfFnSeyVL/2+j+CBPR7jNpmv/sGeuqipfsWEEJIMqdMcQfzbbRb6l4krtNZ?=
 =?us-ascii?Q?n8+ZepSLUgrL2QVRpL2hjjM3Sw2zg86ET5M5WFbQIG8fZR28h3V9sqK86boQ?=
 =?us-ascii?Q?dKQ0b+p8gWVGlZUFUN8spKZO0liA4hS9mRzQLxTAEYoIEYNjL3VM52klrkpi?=
 =?us-ascii?Q?bwoFwciBYcEZHL5dJpV6x4/9uXyCavXhTEA8MX2w6YUfwxZTqjdhzHM9IbHw?=
 =?us-ascii?Q?Xhfib4JrYqlZjiwLbQrW+OUKZghc3GgMaobgOxgoaHNM0G6m6ss5ar0vEkvV?=
 =?us-ascii?Q?khrWWgQUP8sOYV/iG/NwWmin+gwUg0dvNqymigyjldzWsiKDGQchqh1NaxdB?=
 =?us-ascii?Q?OhVHAAXYwdBlomHAf/LwSl/adhsP+b+YcR8FkMPRAnrGW0oKpjV6AAwDeaqy?=
 =?us-ascii?Q?UpuOW9ThoiZbbRF6SsYa8OjgvdjDNDCLOaZt2J2H78ohSsv3Q6VMQmczanhp?=
 =?us-ascii?Q?mofOyDA0WyJxEFVTkfX+Nx9hiO8q1DIDyV6xAVgCIUvTy2KdxHfreURa5x5y?=
 =?us-ascii?Q?4GTekpSkZQYUVYMuUlAQu5+kVeBEXS0QlcNIlGwxPui7x+7kX2bmgAB0NexO?=
 =?us-ascii?Q?3k9LbeMK/EqPnd2IbdYCJlYnyLMEMg7yY+j9zcxAoUTjHZJjyD1F9UzcILGh?=
 =?us-ascii?Q?RPrg/Ufp5dKoyuY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7988.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g0ilRIGonuosCE+ieraPlEgTJ+e30ALRqofzOhshXDLfnG6JyNFP7kwVWYz+?=
 =?us-ascii?Q?B8uVp73QNSdMJI8XUoS7X8FO4TB22iABmkQAao0SWG8tmp5TowUJVF4qvpz+?=
 =?us-ascii?Q?yrwX+sdMZkCayKPPdg53TyqbFsGJlJDje2mJCRLrywIPeddLnOm49Aopj0AV?=
 =?us-ascii?Q?0vXrBMYsh6uWZkdhtBu4AoRTloWo4rt5ycrS7ou96nIzJT8PZmGTnWC3vWsF?=
 =?us-ascii?Q?vCCSPpKRrpjNBb965P8wIcHH477EXYKtnJrEC15Lchd1eh/kNgWcH9ePqXvW?=
 =?us-ascii?Q?Y4XDVvOkhTAUF68/RerlEEH4WDqxKzUAkvD8TvjOkifX3I1Leat4zHVd35kg?=
 =?us-ascii?Q?eRiHSI0iJwxDvj94CK6gDq7Fu9tmGNkhDgGSrHTAcKO6aE0+gSUPeFnkqzlc?=
 =?us-ascii?Q?+7gvvoRtamHGVVUHt8OA2Rnny2olNQzZsZpctnVwypIT/DSA6jY2FhqP8SiR?=
 =?us-ascii?Q?BLjMqeomkOzRVZf18BzCbgY1mOtrncyA22kWBw7edEpPCr2JJduHcz89xjPq?=
 =?us-ascii?Q?8eFFVSgmpwC/+pZdIhgTml8E8eZu728XxrXewm0DRHXlgcjDpOmRNxQDZ2Fc?=
 =?us-ascii?Q?aqJS4Y3HWubhi9iGbCW6qoN7ezKIkm7c9exga1WIGpuMB7EkRSrFdz6AZW9W?=
 =?us-ascii?Q?JNb0FGgtY+no+OONRuG1di9kTXRvy1V3+MC+DPIJ2/V7uoByf71faMmRseJA?=
 =?us-ascii?Q?pOh49gk+oK6YTEgWhBh7UubbbBhbmVaCdAXiIyXhmqBMek4BwUOiaPRhpcl1?=
 =?us-ascii?Q?5N/WSBR6eTmPganllZ4Px8vrkS6PZLum2IF8GLlyeiPqN4LcMmb8V3o+x3a/?=
 =?us-ascii?Q?GqRlrURkXlZPPcNW/uOeentwoqmUmrQ7c3P9JED5wPB7bWaYwitFys9gvtx7?=
 =?us-ascii?Q?w1uC2E4aKEB0QvviVEl/71znSmmJhO/dqKP/+/Fi32ZG1HrIUutjZggCPDUA?=
 =?us-ascii?Q?MLZtjWJRcQ73TwywBPq5qz9mpslYDGXDqes6tL8bSwSsFrqtGGqwxGD67Y0n?=
 =?us-ascii?Q?4kJnxIKV/6u4HVORnqAE3igVkSqTumK0dUtLlFwgiwa31g7o000ewbw5NGKY?=
 =?us-ascii?Q?A4P4C+sxZ0sLslAVqJoC9sjBRSyCJ1wGDiQoMVdhjK/EYt7ukTefvG3GMLp7?=
 =?us-ascii?Q?y8/6J0Jul2r5TmEIQToKIxwYOt0b+7wskm82u7wvqRUIStemsuM7l67hRJ+O?=
 =?us-ascii?Q?1078NnO1S0MaiIN+0pv+cG/R0+AVJhtHB7qhqVp6zFUKEXapz18XYBewdJyh?=
 =?us-ascii?Q?kxQnbJIWFSuyPd1jC37RCQmwQR6Bc8jClZ6CYfu2Ko53fbyJyqGISwJ2XQp/?=
 =?us-ascii?Q?jCKs2aGpYchvdamvPukAlXQM61lbE5IFyYEVWO+AL0gm67xI3kII+eZUE0wB?=
 =?us-ascii?Q?hvUqhjrKA4LkDjRYbnt8T1BnT7eOBaO0h0glj0bLU6heaMVs3TXSzyKFhqFv?=
 =?us-ascii?Q?AadFHVrFh/c5eFTuCoOUuhOCcligdk2ydnpzkIGoTmIjMth0/s84HPneC3kx?=
 =?us-ascii?Q?oEYj+gTrQFN8EYQgjQFS4ny7S4rFtnqtn3wIoMo8KBHrM6oOjzJLhYyf8t6g?=
 =?us-ascii?Q?tw+FfFkPUjRFg7l19Fk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8af1ae-555f-40e4-6442-08ddf4ed44f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 06:50:05.7909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMDkTVk3Gz8yTfzFASLDSOhn7IOlIkdAlhnYQmB/DPLQ+kaRmRbZmpICjJ7LYU1k1gJP6myi8inUpS4sNcntzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

The series looks good to me, but still need @Skvortsov, Victor or @Gande, S=
hravan kumar to review.

Regards,
Stanley
> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Tuesday, August 19, 2025 1:26 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Introduce VF critical region check for R=
AS
> poison injection
>
> The SRIOV guest send requet to host to check whether the poison injection
> address is in VF critical region or not via mabox.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 55
> +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  3 ++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 ++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c       | 14 ++++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h       |  2 +
>  5 files changed, 79 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 13f0cdeb59c4..3328ab63376b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -828,11 +828,14 @@ static void amdgpu_virt_init_ras(struct
> amdgpu_device *adev)  {
>       ratelimit_state_init(&adev->virt.ras.ras_error_cnt_rs, 5 * HZ, 1);
>       ratelimit_state_init(&adev->virt.ras.ras_cper_dump_rs, 5 * HZ, 1);
> +     ratelimit_state_init(&adev->virt.ras.ras_chk_criti_rs, 5 * HZ, 1);
>
>       ratelimit_set_flags(&adev->virt.ras.ras_error_cnt_rs,
>                           RATELIMIT_MSG_ON_RELEASE);
>       ratelimit_set_flags(&adev->virt.ras.ras_cper_dump_rs,
>                           RATELIMIT_MSG_ON_RELEASE);
> +     ratelimit_set_flags(&adev->virt.ras.ras_chk_criti_rs,
> +                         RATELIMIT_MSG_ON_RELEASE);
>
>       mutex_init(&adev->virt.ras.ras_telemetry_mutex);
>
> @@ -1501,3 +1504,55 @@ void amdgpu_virt_request_bad_pages(struct
> amdgpu_device *adev)
>       if (virt->ops && virt->ops->req_bad_pages)
>               virt->ops->req_bad_pages(adev);
>  }
> +
> +static int amdgpu_virt_cache_chk_criti_hit(struct amdgpu_device *adev,
> +                                        struct amdsriov_ras_telemetry
> *host_telemetry,
> +                                        bool *hit)
> +{
> +     struct amd_sriov_ras_chk_criti *tmp =3D NULL;
> +     uint32_t checksum, used_size;
> +
> +     checksum =3D host_telemetry->header.checksum;
> +     used_size =3D host_telemetry->header.used_size;
> +
> +     if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +             return 0;
> +
> +     tmp =3D kmemdup(&host_telemetry->body.chk_criti, used_size,
> GFP_KERNEL);
> +     if (!tmp)
> +             return -ENOMEM;
> +
> +     if (checksum !=3D amd_sriov_msg_checksum(tmp, used_size, 0, 0))
> +             goto out;
> +
> +     if (hit)
> +             *hit =3D tmp->hit ? true : false;
> +
> +out:
> +     kfree(tmp);
> +
> +     return 0;
> +}
> +
> +int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev,
> +u64 addr, bool *hit) {
> +     struct amdgpu_virt *virt =3D &adev->virt;
> +     int r =3D -EPERM;
> +
> +     if (!virt->ops || !virt->ops->req_ras_chk_criti)
> +             return -EOPNOTSUPP;
> +
> +     /* Host allows 15 ras telemetry requests per 60 seconds. Afterwhich=
,
> the Host
> +      * will ignore incoming guest messages. Ratelimit the guest message=
s
> to
> +      * prevent guest self DOS.
> +      */
> +     if (__ratelimit(&virt->ras.ras_chk_criti_rs)) {
> +             mutex_lock(&virt->ras.ras_telemetry_mutex);
> +             if (!virt->ops->req_ras_chk_criti(adev, addr))
> +                     r =3D amdgpu_virt_cache_chk_criti_hit(
> +                             adev, virt->fw_reserve.ras_telemetry, hit);
> +             mutex_unlock(&virt->ras.ras_telemetry_mutex);
> +     }
> +
> +     return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 3da3ebb1d9a1..6ca83abd7a4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -98,6 +98,7 @@ struct amdgpu_virt_ops {
>       int (*req_ras_err_count)(struct amdgpu_device *adev);
>       int (*req_ras_cper_dump)(struct amdgpu_device *adev, u64 vf_rptr);
>       int (*req_bad_pages)(struct amdgpu_device *adev);
> +     int (*req_ras_chk_criti)(struct amdgpu_device *adev, u64 addr);
>  };
>
>  /*
> @@ -252,6 +253,7 @@ struct amdgpu_virt_ras_err_handler_data {  struct
> amdgpu_virt_ras {
>       struct ratelimit_state ras_error_cnt_rs;
>       struct ratelimit_state ras_cper_dump_rs;
> +     struct ratelimit_state ras_chk_criti_rs;
>       struct mutex ras_telemetry_mutex;
>       uint64_t cper_rptr;
>  };
> @@ -447,4 +449,5 @@ int amdgpu_virt_ras_telemetry_post_reset(struct
> amdgpu_device *adev);  bool amdgpu_virt_ras_telemetry_block_en(struct
> amdgpu_device *adev,
>                                       enum amdgpu_ras_block block);
>  void amdgpu_virt_request_bad_pages(struct amdgpu_device *adev);
> +int amdgpu_virt_check_vf_critical_region(struct amdgpu_device *adev,
> +u64 addr, bool *hit);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 33edad1f9dcd..3a79ed7d8031 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -405,12 +405,17 @@ struct amd_sriov_ras_cper_dump {
>       uint32_t buf[];
>  };
>
> +struct amd_sriov_ras_chk_criti {
> +     uint32_t hit;
> +};
> +
>  struct amdsriov_ras_telemetry {
>       struct amd_sriov_ras_telemetry_header header;
>
>       union {
>               struct amd_sriov_ras_telemetry_error_count error_count;
>               struct amd_sriov_ras_cper_dump cper_dump;
> +             struct amd_sriov_ras_chk_criti chk_criti;
>       } body;
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index f6d8597452ed..00c5db336c0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -205,6 +205,9 @@ static int
> xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
>       case IDH_REQ_RAS_BAD_PAGES:
>               event =3D IDH_RAS_BAD_PAGES_READY;
>               break;
> +     case IDH_REQ_RAS_CHK_CRITI:
> +             event =3D IDH_REQ_RAS_CHK_CRITI_READY;
> +             break;
>       default:
>               break;
>       }
> @@ -535,6 +538,16 @@ static int xgpu_nv_req_ras_bad_pages(struct
> amdgpu_device *adev)
>       return xgpu_nv_send_access_requests(adev,
> IDH_REQ_RAS_BAD_PAGES);  }
>
> +static int xgpu_nv_check_vf_critical_region(struct amdgpu_device *adev,
> +u64 addr) {
> +     uint32_t addr_hi, addr_lo;
> +
> +     addr_hi =3D (uint32_t)(addr >> 32);
> +     addr_lo =3D (uint32_t)(addr & 0xFFFFFFFF);
> +     return xgpu_nv_send_access_requests_with_param(
> +             adev, IDH_REQ_RAS_CHK_CRITI, addr_hi, addr_lo, 0); }
> +
>  const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .req_full_gpu   =3D xgpu_nv_request_full_gpu_access,
>       .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
> @@ -548,4 +561,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .req_ras_err_count =3D xgpu_nv_req_ras_err_count,
>       .req_ras_cper_dump =3D xgpu_nv_req_ras_cper_dump,
>       .req_bad_pages =3D xgpu_nv_req_ras_bad_pages,
> +     .req_ras_chk_criti =3D xgpu_nv_check_vf_critical_region
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> index 5808689562cc..c1083e5e41e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
> @@ -43,6 +43,7 @@ enum idh_request {
>       IDH_REQ_RAS_ERROR_COUNT =3D 203,
>       IDH_REQ_RAS_CPER_DUMP =3D 204,
>       IDH_REQ_RAS_BAD_PAGES =3D 205,
> +     IDH_REQ_RAS_CHK_CRITI =3D 206
>  };
>
>  enum idh_event {
> @@ -62,6 +63,7 @@ enum idh_event {
>       IDH_RAS_BAD_PAGES_READY =3D 15,
>       IDH_RAS_BAD_PAGES_NOTIFICATION =3D 16,
>       IDH_UNRECOV_ERR_NOTIFICATION =3D 17,
> +     IDH_REQ_RAS_CHK_CRITI_READY =3D 18,
>
>       IDH_TEXT_MESSAGE =3D 255,
>  };
> --
> 2.34.1

