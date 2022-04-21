Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5E2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 22:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CFC010EB14;
	Thu, 21 Apr 2022 22:08:11 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 647ED10EB11
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 22:08:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxHVRC3M6CSKxl/kjhBZeVhxgjJLKssuV5StPZMY/QrS+HwJu4m24egrf4MCZmEMXLvOHQgRvSfXTnenBLpf3rpkiBE5F+IxsymOIVl4Tw2QKkZkUT9JqvPO2SDGhmafF0V6Z30D7Q6/kkssvnfHGM144vLJpLumd8zbK0a+wSEA+a37tSjsHxISv3IUnDLXg5k8gfs8vOqq+OudWaRMmXvLQGkHQ/SXa4ywHu2fOA8zDT6+/tiWg5RasCGfLmZyPb93aN3+mQnwOYGqB5W3+G2xA1OT2dC4Q1dC4O/pMp4TfP9dzpThoop6fI+Wuu2d9byUggUSt49EBs3eFHlosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=170vjJ78TLsWK5hPvaZAB+EUDu0m6wr7EiujgMaRgqU=;
 b=KJiHXKRZcntKZ1rSEUzs2W0XndRvUXQ1nrDfS8VWN6+GWriD86txoha570FGbEj/6/6fCEgS3mIwjuGiF9Rq3xpjJlv/tITnDZ4Yix8JRRfOJ7HTg83Du4ZYGQ0jiwdzjlZA1u92Z3hQ8N3diAhpArIVejzCLVA0w+2yBKr0kdnKRZJOWkD16zH29p4fplS4rBWen2y1r51JtjoyuWkWZneXzz3RaflXtlqkqJ+v2IqIvveW1Vpztkm1Ahi3QXMXzHdvZlonc5hT8CaFor6ABgCBImqT/JgKVIgXUa1iAgmwIq918nPqWn1/do6xB3k0xKj0d9xa2EW6L7BLLJA1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=170vjJ78TLsWK5hPvaZAB+EUDu0m6wr7EiujgMaRgqU=;
 b=uPtJvVDmmApmhppSNzGPHM7vswcSvg+RJchFPD3AuMBQTsvJwdeQxRUXYLtus63PbWAaCpFExmzgb0GgUGwMdbqJpDN02tJeGk3Hgc6KIUn7DKhSqa9swzZaFXtwVz/8CLXAwzyB+O9bnDubR6ueriKFjAvpFoEo3wpvEHzaE68=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by BN6PR1201MB0067.namprd12.prod.outlook.com (2603:10b6:405:57::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 21 Apr
 2022 22:08:08 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::28df:431f:d965:e6ef]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::28df:431f:d965:e6ef%7]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 22:08:08 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: use kvcalloc() instead of kvmalloc() in
 kfd_migrate
Thread-Topic: [PATCH] drm/amdkfd: use kvcalloc() instead of kvmalloc() in
 kfd_migrate
Thread-Index: AQHYVXwII/HngrqM1Eac2qP1XRNut6z6dJgAgAB4hkU=
Date: Thu, 21 Apr 2022 22:08:08 +0000
Message-ID: <CO6PR12MB5473E57B07D8A609F1B2F4F782F49@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20220421123322.1833664-1-KevinYang.Wang@amd.com>
 <cd602c09-64fc-cb13-60b9-a3a4be7a7f37@amd.com>
In-Reply-To: <cd602c09-64fc-cb13-60b9-a3a4be7a7f37@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-21T22:08:06.610Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f2d0628-cc8f-445e-e975-08da23e36aac
x-ms-traffictypediagnostic: BN6PR1201MB0067:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0067B307E52A2DFEFD6B118B82F49@BN6PR1201MB0067.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yIZ00LMPQAW74UsJV1zqHwEt2GnYtg0J5nR2EHOxXg41V7OUpziT5xSvFuSr/os5ItFCqnLGgI9fNZ5gIy4uBIwxXuudR8MNdhF2CS8mz5EEbv62f+3EPkm37zh6gTP90U+Uthly0l4L83St815cK9fcjJs3l/pqp+fMaWbf7JGGKbwr8QCwxu9RfQSEh/daADMdzVchv62VIDeYM8ROJs5kmIOphwsb28qXLjsZQeaiQJzklSDVFtdHeoTei72x2bG6KZBv09/M2cmS1XoyYaoC9yAOiDINPNjJjDVsSaRHjFVOvvdWmOz4LNLMlekKGpYZ2PpNlGFtAf569av+KzTKH/U0LYgOBLYUAyRF4pqWjt1Er0CR5QnYPhoyaCi8quwJBkymf7V0YKPbm5yVnPtSAxOmUPjwDbb7l3FAZnn7ayIEi7PPD/PVP0OvmZ9j6sAAzxyaWBzVfzTAqhmnLlZE4XeFXOK4ESf9d77aZhgGEiEIGdpQ8KSICPQKtfV/Dr66a84/5+pjSiNmvQMZyC00ld0Z6OkqVUdiNz2QiDHJtFWhAcYwcIUzr5lO2P024cN8Ti2MsVVLKAvSBtstqUnGj+PP43x2IabXRuxxZ8jCmy16ixv5bTauYvR7Mf+y24mQehOBNgipWP+QjpJRGna2QAcIJ6ykJEwPHPOvrS+9utveQH8SJYwBqO+w4bwufP5mPXaYzNHyAvQ3mT4N+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(38100700002)(86362001)(110136005)(122000001)(5660300002)(508600001)(52536014)(2906002)(8936002)(71200400001)(316002)(8676002)(66556008)(64756008)(66476007)(91956017)(66946007)(76116006)(55016003)(186003)(66446008)(83380400001)(53546011)(6506007)(7696005)(9686003)(19627405001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f4XyZJNY48pEyd9Rql/OwyqQmD/ke1CJ0ptUj2BS4WAIdlSL5jKxRGf7vj?=
 =?iso-8859-1?Q?fJKbTmsy4oWVIJXWYFclkUIoTpf8pZXtza28G7aAWSFcjq18miXW7hv6K1?=
 =?iso-8859-1?Q?sgrf6kHHIBYsgmmKpLCq5Q6gQChWQo7A7VBitnAfZjEz60fu8BnQC/QbbH?=
 =?iso-8859-1?Q?Yyc14LU8KC975NNWJF1BdYFhnXyxGcC63XG76x/T6r0S9IxFSd9fi9oDUN?=
 =?iso-8859-1?Q?VEFhHrr24HjKQmr9hY7N41Gh/FGF+rl9BeT8+VBCxjvksXkSXRQbtyEB4n?=
 =?iso-8859-1?Q?DlhFkeTVkP1Rf77sg7QCjpLYH7J2odfvr4ieGEnM55KbDcccLeiH44dsDQ?=
 =?iso-8859-1?Q?bkKcJ7tpb52OK5dxJJvfGCGWuGK5J43goddZLeR/5OXnmbfdJehqcrTAy4?=
 =?iso-8859-1?Q?pSfrXRGGch2JGkFGyhpmhOXzIygT04uWQJwQImi2RXJBbsqaAsDrkwnXV5?=
 =?iso-8859-1?Q?aWh928rb1S8+LSsgyAuzWtB9QYMasO9F1tq+EdTyhl4Set8zrOLKwOEDon?=
 =?iso-8859-1?Q?JXbtzgUHHp/k+Bw92wyUbdCtyWi9lOwsE3sIJkBya1uXyEClG8NwH9VN3v?=
 =?iso-8859-1?Q?3iKlNOmZMuGS02+FeAhZW/8EFNvOjK+40+HEoBgEdZb+DNfrWa3daOBiEf?=
 =?iso-8859-1?Q?dclnHCXEVpj3UIikIuU5So5OsjgwrfNQEQrHU2fDUTADTno2rBs4kfJ9J5?=
 =?iso-8859-1?Q?hvg/StQsaDfkHzs8AEg/cBtwpfARPPxL4NFeR3DBaAfS5e0ClDW45c7LJh?=
 =?iso-8859-1?Q?aQum6Ktegon7IJDTu+bWgmqmeyZZ8Tei8/BGRe4Ag0iItjMx56aWJmSj/B?=
 =?iso-8859-1?Q?JE+z5KbfyWU3LqikqiiIQ8/1N0mUHm+A8ybzkZDbhzV881JicFTR8/1UwM?=
 =?iso-8859-1?Q?URrr6/AlMcj9rMohtjljPSNfzWF82i/zjIzgZhyR8/v8m2e4F/NmIDfIct?=
 =?iso-8859-1?Q?MdA5c0ZCBxSqOTtogXSXUZTDqhHiOoHH0QXpD2cIigUeg0yRFK/gVbJUgD?=
 =?iso-8859-1?Q?9E01NvRLNn5V1vVbN5Q+MRkbWKLkvVRiBFDiuhfuyrtvYz5TtU0CIPAEN9?=
 =?iso-8859-1?Q?+gxPZ+tjZH/o1NGzutnStKgQnGuk3jA0U/4bSPJk0ICGZU+dAYSN11+tg+?=
 =?iso-8859-1?Q?UJ+xC5rAU/Pamj0J67aXZ9SP1+Of+CxXbvyiVIyp1nEFfYB8nfuEQ2aeVK?=
 =?iso-8859-1?Q?Z+pjvcDMPj6AEds5MZd5rh3MOBppZ4XxR51c73VTGKzL3dPry3fBF1T6bL?=
 =?iso-8859-1?Q?/oUAfjNVMk+rIrlBvRkAZgqiOQpP+MWZS+4UopYQc0G/ODL6S9kDYy28JU?=
 =?iso-8859-1?Q?G+8YBjFKM4JrpuUpknhIbsTTPfGEvtmvz8K5cqYnl19aWzQ5p3kV6WQkId?=
 =?iso-8859-1?Q?QrYd4cwiZLWgiaD8MSSNkasy8g09+XbQpR7Sop7a1VU/BABKcILhv99YgM?=
 =?iso-8859-1?Q?yVJURP46J3jxJ/4fDvb7fxr0SHlPLCB2IrJjDOgwRYmn1qHP8B4v3ofS/a?=
 =?iso-8859-1?Q?3o7SHFZAV5vW2cdDbztXg9tBxLMcM6nv0ar75PdkRwGl7wpWN5HPuBLzGe?=
 =?iso-8859-1?Q?Rn/vjNR85o3S8gEfktQ0BO6ku9C85bMLKiMCLgTQnC7/Bce5IVngGTjrn+?=
 =?iso-8859-1?Q?Q7jsMmQBCvDeQaTdnbV9eoCK+nWu0r6e1QTQ9DkFZi+ZkQU/vUjjy6imBm?=
 =?iso-8859-1?Q?2dIMcLnNTUrOC3QYQ8ejvO4u66qMhp9tKeNVcatezhQYJf9xzWUcaxsTsE?=
 =?iso-8859-1?Q?mnj31GkKGunSkbSGxa9OddorsGxhJpoSOZdh+5msvGUBGJ?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473E57B07D8A609F1B2F4F782F49CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2d0628-cc8f-445e-e975-08da23e36aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 22:08:08.0143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8a3E1p1aCu64ukkqAvf76q2+c0li3BRh8SgMekB1tF/q//oagPkNI9Rj9yRxGvc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0067
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

--_000_CO6PR12MB5473E57B07D8A609F1B2F4F782F49CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]


________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Thursday, April 21, 2022 10:55 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: use kvcalloc() instead of kvmalloc() in kf=
d_migrate

Am 2022-04-21 um 08:33 schrieb Yang Wang:
> simplify programming with existing functions.
>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

There is one more kvmalloc_array call with GFP_ZERO that could be
replaced with kvcalloc in svm_range_dma_map_dev in kfd_svm.c. Maybe fix
that one as well while you're at it.

Regards,
   Felix

[kevin]:

Thanks for reminder.
I will fix it before submitting.

Best Regards,
Kevin

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 3a29d857640b..43cd47723946 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -410,7 +410,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, s=
truct svm_range *prange,
>        struct migrate_vma migrate;
>        unsigned long cpages =3D 0;
>        dma_addr_t *scratch;
> -     size_t size;
>        void *buf;
>        int r =3D -ENOMEM;
>
> @@ -421,9 +420,9 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, s=
truct svm_range *prange,
>        migrate.flags =3D MIGRATE_VMA_SELECT_SYSTEM;
>        migrate.pgmap_owner =3D SVM_ADEV_PGMAP_OWNER(adev);
>
> -     size =3D 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_a=
ddr_t);
> -     size *=3D npages;
> -     buf =3D kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +     buf =3D kvcalloc(npages,
> +                    2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof=
(dma_addr_t),
> +                    GFP_KERNEL);
>        if (!buf)
>                goto out;
>
> @@ -665,7 +664,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, st=
ruct svm_range *prange,
>        struct dma_fence *mfence =3D NULL;
>        struct migrate_vma migrate;
>        dma_addr_t *scratch;
> -     size_t size;
>        void *buf;
>        int r =3D -ENOMEM;
>
> @@ -676,9 +674,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, s=
truct svm_range *prange,
>        migrate.flags =3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
>        migrate.pgmap_owner =3D SVM_ADEV_PGMAP_OWNER(adev);
>
> -     size =3D 2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof(dma_a=
ddr_t);
> -     size *=3D npages;
> -     buf =3D kvmalloc(size, GFP_KERNEL | __GFP_ZERO);
> +     buf =3D kvcalloc(npages,
> +                    2 * sizeof(*migrate.src) + sizeof(uint64_t) + sizeof=
(dma_addr_t),
> +                    GFP_KERNEL);
> +
>        if (!buf)
>                goto out;
>

--_000_CO6PR12MB5473E57B07D8A609F1B2F4F782F49CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 21, 2022 10:55 PM<br>
<b>To:</b> Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; amd-gfx@lists.=
freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: use kvcalloc() instead of kvmalloc(=
) in kfd_migrate</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText elementToProof">Am 2022-04-21 um 08:33 schrieb Yang=
 Wang:<br>
&gt; simplify programming with existing functions.<br>
&gt;<br>
&gt; Signed-off-by: Yang Wang &lt;KevinYang.Wang@amd.com&gt;<br>
<br>
Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
<br>
There is one more kvmalloc_array call with GFP_ZERO that could be <br>
replaced with kvcalloc in svm_range_dma_map_dev in kfd_svm.c. Maybe fix <br=
>
that one as well while you're at it.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
[kevin]:</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">Thanks for reminder.</div>
<div class=3D"PlainText elementToProof">I will fix it before submitting.<br=
>
</div>
<div class=3D"PlainText elementToProof"><br>
</div>
<div class=3D"PlainText elementToProof">Best Regards,</div>
<div class=3D"PlainText elementToProof">Kevin</div>
<div class=3D"PlainText elementToProof"><br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 15 +++++++-----=
---<br>
&gt;&nbsp;&nbsp; 1 file changed, 7 insertions(+), 8 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_migrate.c<br>
&gt; index 3a29d857640b..43cd47723946 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<br>
&gt; @@ -410,7 +410,6 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev=
, struct svm_range *prange,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct migrate_vma migrate;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long cpages =3D 0;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *scratch;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; size_t size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *buf;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D -ENOMEM;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -421,9 +420,9 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev=
, struct svm_range *prange,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate.flags =3D MIGRATE_VM=
A_SELECT_SYSTEM;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate.pgmap_owner =3D SVM_=
ADEV_PGMAP_OWNER(adev);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; size =3D 2 * sizeof(*migrate.src) + sizeof(u=
int64_t) + sizeof(dma_addr_t);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; size *=3D npages;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; buf =3D kvmalloc(size, GFP_KERNEL | __GFP_ZE=
RO);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; buf =3D kvcalloc(npages,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 * sizeof(*migrate.src) + si=
zeof(uint64_t) + sizeof(dma_addr_t),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!buf)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -665,7 +664,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev,=
 struct svm_range *prange,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *mfence =3D=
 NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct migrate_vma migrate;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *scratch;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; size_t size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *buf;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D -ENOMEM;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -676,9 +674,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev=
, struct svm_range *prange,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate.flags =3D MIGRATE_VM=
A_SELECT_DEVICE_PRIVATE;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate.pgmap_owner =3D SVM_=
ADEV_PGMAP_OWNER(adev);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; size =3D 2 * sizeof(*migrate.src) + sizeof(u=
int64_t) + sizeof(dma_addr_t);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; size *=3D npages;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; buf =3D kvmalloc(size, GFP_KERNEL | __GFP_ZE=
RO);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; buf =3D kvcalloc(npages,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 * sizeof(*migrate.src) + si=
zeof(uint64_t) + sizeof(dma_addr_t),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!buf)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto out;<br>
&gt;&nbsp;&nbsp; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473E57B07D8A609F1B2F4F782F49CO6PR12MB5473namp_--
