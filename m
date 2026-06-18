Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6165CD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 20:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC9E10F3E1;
	Thu, 18 Jun 2026 20:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zn7FRkVp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E0510F3E1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 20:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fY97VMdHzIcQg4RuL6/yY9Yljs3icwJxEMTex6DckoIx/a8Wj/cs8pQKPusWk0c6QurKWGsXiWpEINynvHaMHEC4DIyMf0TRi46olrZlrziaizAb8ZG8TRhML3x7SyDv3E9tKebgYKHlSITlPXn8hrIK6qWug4x4FK6a2tuOlGSlQdpJOi6cE9+93kJYIeQZx8KE9qdjNF51w14ImukK1F3ORS9stn0Ng9wCGbBsgyl4PgZWFOx3cS0sRVLQVguWKNof4FOuSubhDmibYvGfRIAeC1boPbqVz65vDGPV6SyNEhG/qhu91/YmRGYLjFsTveNjRflTQbmHm118AFpkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YuFMcJZDBc7mn46AMvOf9TObhjORz+SeKhKnBnU4zg=;
 b=SeNH+42/eFwBPCVS3wKHYd75RZR0Z9rHezdpaJuUeauw7F0vCJzQ39kJzUnC1KWKW1fs2NuqqOgqycsF8YbWqFJ0eF1oAvHjLfcX0TnyradhtSO7kqkrVabSxOuxjQVKafOOQAXkbCiyTCXLQepp2NaH0Mt2TnniNpchL9tbZsdWZKvuO8zRf0UuEu2kFlRkXuT0+qs09cwFGARlNtzLDWlhIozf6VQyZ0+LK5PtgMxM8/ZUYjkcF4ed7xTMaVk/lTOlrU3vlVUQwsDh41OvkhYjZ/Dh+iTj6YjgV57zptXflbapBiTExhaTPSDjWNAOLmQdMB3naVHgJE4c2HkdsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YuFMcJZDBc7mn46AMvOf9TObhjORz+SeKhKnBnU4zg=;
 b=Zn7FRkVp+3HPnZBur/M1d57P34vZJj52Wieqf8wTT14rg2Q1nTh9Hj7OvoaCDQm6s0PI42zwS4D5c6SkDS3SjNkyST+vltumhK0dAh3sRHWAoPcN35idbAfB6NF69ZKDz0vHOJUEtS+rKgxHED2jaSOMCqcDK3qyUlZpqCOs8OI=
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 20:57:59 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%4]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 20:57:59 +0000
From: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: amd-gfx Digest, Vol 121, Issue 400
Thread-Topic: amd-gfx Digest, Vol 121, Issue 400
Thread-Index: AQHc/mY3MBfYyR4+T020sK2x+MEwxbZEzMpw
Date: Thu, 18 Jun 2026 20:57:59 +0000
Message-ID: <IA1PR12MB819049B8D5E277EDB2FD4FB481E32@IA1PR12MB8190.namprd12.prod.outlook.com>
References: <mailman.14348.1781706781.6453.amd-gfx@lists.freedesktop.org>
In-Reply-To: <mailman.14348.1781706781.6453.amd-gfx@lists.freedesktop.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-18T20:57:11.214Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8190:EE_|MW5PR12MB5600:EE_
x-ms-office365-filtering-correlation-id: 4946bd2b-e4ec-4c3f-0d27-08decd7c47a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|8096899003|38070700021|18002099003|22082099003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: 6DWobJiiKSAgNfot1Bt7pycjQjlLTwCC7OghoutlWs0ZFPaHhH5TIDPh6XbO5hI1vQdipbPVVKDVAiG4CONDZD/p+Du4XL4MdF0p5jLdmaMS2TtMTGB9OwU7ci4rsLJCiYmHnVsmzoNHrkTXJPKuyDCVcqzjWq0fECxrBqekZ9UhFhNFElNIiOYNjHcHMAH+/Br8NCf7dUG38ZC6OVcmkdZ8EkiAJDFWLRb73QBqdxodmuyXt8PmuRbZVnhklntDmDfZmABnx/9eidXQU6aLcYXzEVZifFVx6DpLMJWpfcene8ctDBd4RcvtauBTY742CGuRaAAQlj74mY4e0tesg3XMSyjyIu7VLJ239BX/U1HRHrCiwtkdmrLxsXweuiMKwFbgKAwle3QufeMY4e1L3kGX8rFsFSvrEWgrzkNBig8J9WMLcPMFxd3lplO+82h4Uvf3qNgM8qICzNMH2TSf48nt4eiy5c9x6RBv8MLzl4WBXPZW4p9CdjV4Rt0JiCMLg98mYC2eBJswNVY+djrb2kdYZ5paHtKx55YaNmR7vX/c63ftU+9p8zT8kndUzGuEgTjlhmMUQCGHK5O2FYiH7aUB+OAt8qmGaRPY2tHKFJJ0f/V2746P0u8PWjpbQzMg36PSmr8fcgNEfrVXTFvRKHkbugTZRaXxTe4G7lEoiLFAeMVh+C1ExBslIHaS+ZQUhKB06z1qZOEmYeGk+wJBsCDwoJu6Hhms3P1JQ54NgqQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(8096899003)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j42yrcWa9Xs+wkmuYT86u+com9EzpzZV3BOSxVHIgYRx3gaqU3qnwNeBWd?=
 =?iso-8859-1?Q?XkqYtML4tHUfv3t/NZF9Hzi49obk5Rqrown9cuZZwXL5wOGMmASqqcXRGw?=
 =?iso-8859-1?Q?no6K9gaIR1V6R1OPfe7mF4G8DzMGdGtFB2MBrggHPC3L9weovCWW7v1h/a?=
 =?iso-8859-1?Q?G0cDuh+hzTToxLnxCSfiQ27Z3lLVG/CX5vkTFGZVEJTXPVcBk7covf8aOy?=
 =?iso-8859-1?Q?w8VJPvJGGBm4rPZLYupocHpqNEPc410xPiAdUJE+Ydf9ykCQ2nKS1goEsj?=
 =?iso-8859-1?Q?Ekl/PTG4AQ/H07xwxms6gV7m3+Nz3TA/ArxycFdNbbIs3MUJ9ov7yGVa6j?=
 =?iso-8859-1?Q?In/xYY1fBdNiCMyEjljKHzic4dLaqqjf6KFAs7yqD2fuAcEWtEFIC4w7kR?=
 =?iso-8859-1?Q?EnBjuyL20RlHbXX5TvGB9X6njpbkx2PgKG/2Yr9vRkZG0lwHJFESBd8yek?=
 =?iso-8859-1?Q?NkC9/9mQdxsZGWgjyb7n3bFTAt6KRaFjocghPr8l4eSDVDwo6SuBNOPL0a?=
 =?iso-8859-1?Q?q+nbZqKUdxwTKyWDRT6Iq5JTjshNvB96aZh1Wq5u4RRgtfsgxLR7t4FoUx?=
 =?iso-8859-1?Q?bFGMOJIwk7Anep/mpvagML/VTKGTwUfWf4qXt+CD9tBo/Q9Z2dG5InMfVb?=
 =?iso-8859-1?Q?gdnNAyT6VADkl6/Aoevcrc3p5nFUzi7C/BttPH/PeBRDD4Z0Oa/PX4uAd2?=
 =?iso-8859-1?Q?IvIvmOLQOblLlO/VJUs3FwST40mtXFy51/BS/uepaloW8DGfbi/pVrPhkP?=
 =?iso-8859-1?Q?kdpmU2gf49u2sZjIyEMhhes874gAfJSTizhVfuw28FKD+dSBVKCpB++EFl?=
 =?iso-8859-1?Q?yV81haXoa4uar3o8LnoS1UPOxUEucITsCrsHquLOVOrAikLFi4kwNdT1p5?=
 =?iso-8859-1?Q?CwpI4YFV0G2eRw5V/fzECyGSwt5Q/nGkgerPFikx32bmEYnN2uoXvK23fS?=
 =?iso-8859-1?Q?Wx94Pt6mxhk1tMviCzYRYWpWgZiMu3aoF93Ih6tY+DPTCjLVBvcatU7Xt5?=
 =?iso-8859-1?Q?T5AxOmDmIF7LvBaZ9iJZuqic9AaEapR3C6zbantQbLWw1ONENOeJeYfJQw?=
 =?iso-8859-1?Q?WGMtJTQzVT0C+P1v2LzdW9kX08UAwvn2o/AftLSe7TIL4KukoDRMV3Oovb?=
 =?iso-8859-1?Q?p9wuU3GMB9vCh4AHFrnsHXzlzYVS8VXgb2bkXWRUUwg12mBm+OuLH/Do5G?=
 =?iso-8859-1?Q?ak6fVYqWdj9zWjEvRbywE/n1SkIXb0B8y2zIWfNRDwAJq4JkpEqlJk573Z?=
 =?iso-8859-1?Q?cAEfZud58RJOJAubZ450e+/V3EHVhqyWbEVLD6LZEpARA2809yelSohHCY?=
 =?iso-8859-1?Q?sdYUbxIBlaqpg5eZlwINHOY+hMpHoEyI6uEukyKs6GF1j6SIqPQzJaj6j0?=
 =?iso-8859-1?Q?WqPy+M7YjWAvDFvRDa5zcgi1STMDBb16EfQ76ZcPj9yTdRWPMrWv6oxO8/?=
 =?iso-8859-1?Q?UtZ2UI7dvJE+SOz6uSGMwzHIKkNk8c4MJrNKUO8paBvyLZlpSCAfhWPVJ/?=
 =?iso-8859-1?Q?0Go+U7yQE1hlFWTJ77ngUAeCWQAo74tOrw5J3Ams+Ct2pFIZtfuYMAXe2d?=
 =?iso-8859-1?Q?4qjqlCy/oUNsoFb+OGuYdAMJED63mwc974mTgTX+jCnOJ6g/uwLR2etqld?=
 =?iso-8859-1?Q?WagIWz/Les9vxnsdMbXSaKOc0DPuIXzs9Q5RVnJDhmhuBZV5JBNbeRFcpv?=
 =?iso-8859-1?Q?0va5/hTdAWi6EUNl+cVAiiM93GSNjm/X00IIX5PJbvlvEHIb1MSyUvx/os?=
 =?iso-8859-1?Q?6hbjtE8IM3ZImoJny/dnBUCS6RpZLaeoee1kswYllYkAbR?=
Content-Type: multipart/alternative;
 boundary="_000_IA1PR12MB819049B8D5E277EDB2FD4FB481E32IA1PR12MB8190namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4946bd2b-e4ec-4c3f-0d27-08decd7c47a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2026 20:57:59.4610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Owa83EsM07AG9y+LrODo6C0dVg70rwTnsVKYOkN1hmwUcUr2zpk0Cj7BkV+L2SIa258qvLOEpKWnSRk7yKWYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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

--_000_IA1PR12MB819049B8D5E277EDB2FD4FB481E32IA1PR12MB8190namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General


Date: Wed, 17 Jun 2026 10:12:11 -0400
From: Alex Deucher <alexdeucher@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 01/43] drm/amdgpu/gfx8: replace BUG_ON() with
        WARN_ON()
Message-ID:
        <CADnq5_NnQbH_poF4L-8PLD6unByMV6DLT_oyWwggGVTzetJs1A@mail.gmail.com=
>
Content-Type: text/plain; charset=3D"UTF-8"

Ping on this series?

On Mon, Jun 15, 2026 at 8:34?PM Alex Deucher <alexander.deucher@amd.com> wr=
ote:
>
> There's no need to crash the kernel for these cases.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 130196859ff3f..70ba81e6b4d43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6256,9 +6256,6 @@ static void gfx_v8_0_ring_emit_fence_compute(struct=
 amdgpu_ring *ring,
>  static void gfx_v8_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 a=
ddr,
>                                          u64 seq, unsigned int flags)
>  {
> -       /* we only allocate 32bit for each seq wb address */
> -       BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> -
>         /* write fence seq to the "addr" */
>         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>         amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
> --
> 2.54.0
>
Reviewed-by Vitaly Prosyak <vitaly.prosyak@amd.com>


End of amd-gfx Digest, Vol 121, Issue 400
*****************************************

--_000_IA1PR12MB819049B8D5E277EDB2FD4FB481E32IA1PR12MB8190namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, sans-serif;"><br>
Date: Wed, 17 Jun 2026 10:12:11 -0400<br>
From: Alex Deucher &lt;alexdeucher@gmail.com&gt;<br>
To: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
Cc: amd-gfx@lists.freedesktop.org<br>
Subject: Re: [PATCH 01/43] drm/amdgpu/gfx8: replace BUG_ON() with<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON()<br>
Message-ID:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;CADnq5_NnQbH_poF4L-8PLD6unBy=
MV6DLT_oyWwggGVTzetJs1A@mail.gmail.com&gt;<br>
Content-Type: text/plain; charset=3D&quot;UTF-8&quot;<br>
<br>
Ping on this series?<br>
<br>
On Mon, Jun 15, 2026 at 8:34?PM Alex Deucher &lt;alexander.deucher@amd.com&=
gt; wrote:<br>
&gt;<br>
&gt; There's no need to crash the kernel for these cases.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 ---<br>
&gt;&nbsp; 1 file changed, 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v8_0.c<br>
&gt; index 130196859ff3f..70ba81e6b4d43 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -6256,9 +6256,6 @@ static void gfx_v8_0_ring_emit_fence_compute(str=
uct amdgpu_ring *ring,<br>
&gt;&nbsp; static void gfx_v8_0_ring_emit_fence_kiq(struct amdgpu_ring *rin=
g, u64 addr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; u64 seq, unsigned int flags)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* we only allocate 32bit for ea=
ch seq wb address */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(flags &amp; AMDGPU_FENCE_=
FLAG_64BIT);<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* write fence seq to =
the &quot;addr&quot; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring=
, PACKET3(PACKET3_WRITE_DATA, 3));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring=
, (WRITE_DATA_ENGINE_SEL(0) |<br>
&gt; --<br>
&gt; 2.54.0<br>
&gt;<br>
Reviewed-by Vitaly Prosyak &lt;vitaly.prosyak@amd.com&gt;<br>
<br>
<br>
End of amd-gfx Digest, Vol 121, Issue 400<br>
*****************************************</span></div>
</body>
</html>

--_000_IA1PR12MB819049B8D5E277EDB2FD4FB481E32IA1PR12MB8190namp_--
