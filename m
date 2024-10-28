Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B9BD3E2BB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D1910E1D0;
	Mon, 28 Oct 2024 19:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G0xrwwe/";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F0D10E1D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvqOHz6M6/VOA8um0XNvSNqvEyieG5TtzwvGW7SQ8LBgvwqx5f8Zv310tqIyWLpScF2fOcTVWwK1cnbdKgTws0yIZ72LL1u95jvP6yH1TUVhw3PdI676lc1Z14dlgQ8lawB/XE/KTFDQnFb4ro1YACAPFGXsMe3qjCtGwRFik5lBex+o2kjLmvgW+2VMKKw80YMQs5RIFln/wEJfaEojnWV5Sa1bBJ8ivnyGf7ZCphudI6ylvi1Vy2WV0hhxYtHMP/AASLngEFS7udJvTGtybuGDv8s9Hd273uHXXd1e1JLBU64e+EP0yRcA+1s4eHqZhE4KdpvSns5xF7GxqkUktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBsvRiMD9/fQlfvQzJmsMK/DJaTgCn0XRoEdNwTe2pI=;
 b=PpbhkstRrDMEUsrAeUKXVAJ/7ll/4ONyOW/dfEXaWu/Br0vzszHWVvp7zGe3msjA3WwR/lVs+co8RYlXPno7bH6PdUYCoD+eRXFg5Q8uDAaDTKtin5M9qjujFr4IvgtTA7Gzs9ogxJIpD3eeSA4n0PuRBb2hGLpKRaLVihE/JH2wB00sakphXpFHjXQeEb43t3p/gSHF3rWItkXtB3BimUqlBC5aCjBqzTCo8n9efzAe6BP+vTUUrFLm87a9/jpF5WZ7AbH/fO3gZ8MtSkXDvUpJ8qn7DYbDvQ7wFQPKoPKzalEqZ9y6kjU4nrOo/ybduhoaViNDCjjbYg+WGcN3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBsvRiMD9/fQlfvQzJmsMK/DJaTgCn0XRoEdNwTe2pI=;
 b=G0xrwwe/Xt8cpm9ixwE57XF0QpZYBGVkXNyt0lSB/U+H2qd6/jajcsx7xQsXtAVUP/346xYRtf8RPLT6lm8rbx5I2Xa+RVRuw1xOQjN2uwgybYviSmldLZltAMVB8YLyAiqDwdQLhf1hHx+cDEdeXdgwclIqq0y6hS14WSJg7qk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA3PR12MB9180.namprd12.prod.outlook.com (2603:10b6:806:39b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:37:21 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 19:37:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Boyuan" <Boyuan.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Leo" <Leo.Liu@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 20/29] drm/amdgpu: early_init for each vcn instance
Thread-Topic: [PATCH 20/29] drm/amdgpu: early_init for each vcn instance
Thread-Index: AQHbJoatG1unoVodq0Ct3nCJ7VC+sLKclHFA
Date: Mon, 28 Oct 2024 19:37:21 +0000
Message-ID: <BL1PR12MB51446018D73372E06B6540D5F74A2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-21-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-21-boyuan.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=52923325-6e6f-41f7-9f83-82000bbabb21;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-28T19:36:56Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA3PR12MB9180:EE_
x-ms-office365-filtering-correlation-id: d9750f5a-3fb4-4975-954b-08dcf787f0d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?wsd/e6LMllq7rPPGOOBBBW7qKPCkSz+dxX4UUWP6hgkl0u/4scHariGXsgWD?=
 =?us-ascii?Q?I4gw0bVU6XJRyQitxwutVJ+EWC1GUnTpd8dlTuyQsJVwVHeWA56Cwlc64B9T?=
 =?us-ascii?Q?vpqvArfK7lexqBkaR2JHS5ala1TpM/vkzo/ymvg27XVCtLu2V0lOfBi6GEFa?=
 =?us-ascii?Q?PnCWsb/fqXz5Fgnf/jhlRVwqLy9mSaLOnytfKHHv0rMxWdt4uj/ZLkIxKQB/?=
 =?us-ascii?Q?rqzrizah/1sJrg3gxl1qbptVoA6TWrZ5zz3f5rzgHsCPV73msvMScuTdDlDn?=
 =?us-ascii?Q?P9erNh/dBxnhCeLIRz8gMfLUnobYeOFjB5SQFi+wd+xBB5PA09t3h8xnF7Vf?=
 =?us-ascii?Q?DdeTiBc6LAPRPNijFoc07uAR/NCNlaIIxXRxCC5C6/vFergd5TjcWWwy0hil?=
 =?us-ascii?Q?V+jv1Rf406VrrBsnPU06LbFIU9B6mMGPrUZVxbHV7JIre+AFNX9czWX/MwxI?=
 =?us-ascii?Q?SJWus9XrBlPmmwuOf/xxcrp/ezBqBzoQNcGAztg7VJu1lm8h5alSZE715QT9?=
 =?us-ascii?Q?JkUrhag8Y/q1Th99QPJ/Azu8JWA7A1TRNMdg3/JBvaHD6IzHc5WFAVaxCtBP?=
 =?us-ascii?Q?jH55bonZY22Nqsu1i+T+skOknf8G4nDhEVhXBiWJCexesH7iIhKXi3sI/KC/?=
 =?us-ascii?Q?pge2mFNMnEsP7bH8xSSsV7PD5yLUCuBpGoytC95b/JK5Y3F0YptG0eDikXcw?=
 =?us-ascii?Q?TdQstznq0t0WJdwYK7CRKMD3RQSSzTGSX1ziETG6kyMN9OwM6bsJEW3EHGY9?=
 =?us-ascii?Q?CI15xhq4mE1XcxgPP3KuHwWKRo6CZN++gbntcNdKrxUZfDNfKAFDHl0kOhay?=
 =?us-ascii?Q?X5aIpD/wRWC14fE6Fsd8X9E4+Wu9DLqIBVVvIM9D65cPRX0suYWd6jWSKxtv?=
 =?us-ascii?Q?GPvq9m/Hv8uWcSqr6rg/3X0ZmuQfrEiyiGwNvtcJ8zxlhq3MqOp+xOrXUzCW?=
 =?us-ascii?Q?H0OgCtlHrue6Lm+xVHnAS9zTZsrvwa+pc+/Eyi6yImPO2VJuzgtA0vntdORq?=
 =?us-ascii?Q?N3SCmNIbrrXAqySbL+/BlT7e2q08ygAt0NSdyuoGPPIWd2aPt78vkZiyLWTx?=
 =?us-ascii?Q?ye1HC2NpTsKOzWLVr3N0tW+tUM2lV/IeJ5gu6SLkNZgfCrKdIx61PtNRjJRP?=
 =?us-ascii?Q?V6FfFz4vRvl//LO6Omv5bUXgmoCMzkXlBb5PML1jMWoUzZR7wr0CTtfydYdB?=
 =?us-ascii?Q?H8pi35VKnOGkyc+bG1k/iN7Ghwh+wXfVIU4nl8Ytkmm1Ac7GJ0MnRWb7M7uT?=
 =?us-ascii?Q?4P6MRC3JUZrKhNw6xeQoYYvaUgLWSxU1X6FltbpEyay0xVW274SLgR89Hby4?=
 =?us-ascii?Q?2+whKnkzAQaFK34VO1jL9EPlXGppuk4goUVAskGSN/HuMPN50/9NSB73yAXZ?=
 =?us-ascii?Q?1axK9hs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sdKE84AypAZzWK2hVC4cAoeqawzSm4UM7pbZnVVSla8idcpDNVxtvVzdNAgr?=
 =?us-ascii?Q?fLOU42CqpwusdJ1pzCRRfkkJl/w7WCThc40+rwsdJovTF98GV5xa9D5Pb4gm?=
 =?us-ascii?Q?S29ShRYcUWkxF8CEwLBHkqQC/yT1Q4F0JSG+aGX3+/6SbPOYCJxqXsc0Im5O?=
 =?us-ascii?Q?L99mt6I9SE7ldIqPeNVCa7q4GPID62VXbS1dYLmm6uOleAY/Kf8cF19M3Z0n?=
 =?us-ascii?Q?GaI23CSGuNtxjGuqQMdzyYFP/e7mFe3AOFBb8Irp0b/1v6niNlSZwNlZNtWh?=
 =?us-ascii?Q?Q/YGMTOVQ30rpb8x5Sv0W4aqSP7wBhcb55i3vYoTzr6GXBjflTyNC2FIGyF0?=
 =?us-ascii?Q?EIJx9wfXspH1CP+3OfCgpmIUboHwjdPzl0HZJnpaNL7jp8BW4Vq9m/WZ36a2?=
 =?us-ascii?Q?u10oYLRWZnQnS6W/Rk7vtBaP5N+6EDCUyN586zxdU/FDP87WrU6c+G37zJyo?=
 =?us-ascii?Q?7GA05SodNXGsKY0K/cEHG3rORuVBTjGPBoHVJtHnGwGpEF7FQ4U1cRBmqLB2?=
 =?us-ascii?Q?+VrUKpVrQumb22JI3FxWSM/u2XzhfJ8sqyGBjszjBJOP672LjhN50D9MczMF?=
 =?us-ascii?Q?tT32LRJzFWaSihO4Mj8YNQPL681+Cm0JdN21AbdLchSJg6rxjCf9CxN+1BSA?=
 =?us-ascii?Q?W5DxpkKKmwJs5M/yNmbgvwrBQcgRtyyrRH3S+tL+EF+oA+4MA5dPSqM0JI+m?=
 =?us-ascii?Q?liFa5WU0hQEG++8DYH9MzCZXsn+t9d6QDhbyIb3ITwv3AjWZnC3phxUMLil+?=
 =?us-ascii?Q?6650JNZwxVdXDbTvJ3G/5v5W19ORgsdAWsCp4Mjn4quVyiJDwN4FUg+zizv6?=
 =?us-ascii?Q?SUZ3olNmzUZPUGHcazY7727pJCsAmfKHTxLxN5XxIVbrWmcycoWutxZZQeS0?=
 =?us-ascii?Q?eK7k9zHR+i9eBW73TTNfjR2ciSjfPDbt4bS0F+MLIej3hoqlG28V7/3uRcdt?=
 =?us-ascii?Q?dZtB8TTqH4E9CD9M3tyEzDsKXDjpYnsyibh37r1hUVL6kl/GtLJh75hKspQr?=
 =?us-ascii?Q?Sk3RB/tDyVIT3bpqk2myKigt9vZOembA5OlgYYKHU4hIWEd6PMk3Ks/SKIL8?=
 =?us-ascii?Q?PES+Agy5KfnyU1wsPdJGwSbgLP0YyzVKhef2LsLJbDnVQ/kWSBeOU3yo+nr7?=
 =?us-ascii?Q?6jSjPyrDjevM0zuSpFsd+B6agkJbQYz1AyIUT85Dg0Uwm2OIBx3uY8rrgtCY?=
 =?us-ascii?Q?UyfMp0PS4Xil78kWAV647PcB0iAP8AAmeS82Gh9cAB10a6ZkTkKeoffFDqw/?=
 =?us-ascii?Q?etNlWRBavr2XEs9ZKz50BYJupWInH3i9kDZYhcxI1tDz47lW4adNcn/IXS+N?=
 =?us-ascii?Q?k0z0KfNLoGszOA35PUaZtjYZolNBNDyNBuqs9c/TxceXU/++7mGnWVCTv7l8?=
 =?us-ascii?Q?Kccbzub7uT8J6QnaPpMSTRXfgAPV+SBOiB9FKFtiI1fJZhNkc+yTagPyn7Es?=
 =?us-ascii?Q?QdQXO4WHVweH43woieGvfxlwLk/kvsYnPbZG33381K728wh7zY1GuClSROey?=
 =?us-ascii?Q?/CVnuqAXktuowaRjRGcaelZHoxTunoSzPPC92yYw+jeRIJymdQuOhTAVXior?=
 =?us-ascii?Q?p5p63JsBtflUOrJc49g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9750f5a-3fb4-4975-954b-08dcf787f0d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 19:37:21.2852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xAsBOPAzRGKWfOtO3YrIaSuS+zhlKWO8XRtBtGp4V1KmS+Vh2puq4+jnNavwcNoAUmfCTaCH4zwoG62Gza9g2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9180
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

> -----Original Message-----
> From: Zhang, Boyuan <Boyuan.Zhang@amd.com>
> Sent: Thursday, October 24, 2024 10:36 PM
> To: amd-gfx@lists.freedesktop.org; Liu, Leo <Leo.Liu@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Cc: Zhang, Boyuan <Boyuan.Zhang@amd.com>
> Subject: [PATCH 20/29] drm/amdgpu: early_init for each vcn instance
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Pass instance parameter to amdgpu_vcn_early_init(), and perform early ini=
t ONLY
> for the given vcn instance, instead of for all vcn instances. Modify each=
 vcn
> generation accordingly.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 ++++++++++++-----------
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 13 ++++++-------
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 +++++-------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  3 ++-
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  3 ++-
> drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  3 ++-
>  10 files changed, 36 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index efd6c9eb3502..21701738030f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -91,22 +91,23 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>
> -int amdgpu_vcn_early_init(struct amdgpu_device *adev)
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst)
>  {
>       char ucode_prefix[25];
> -     int r, i;
> +     int r;
>
>       amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix,
> sizeof(ucode_prefix));
> -     for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -             if (i =3D=3D 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=
=3D
> IP_VERSION(4, 0, 6))
> -                     r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[i]=
.fw,
> "amdgpu/%s_%d.bin", ucode_prefix, i);
> -             else
> -                     r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[i]=
.fw,
> "amdgpu/%s.bin", ucode_prefix);
> -             if (r) {
> -                     amdgpu_ucode_release(&adev->vcn.inst[i].fw);
> -                     return r;
> -             }
> +
> +     if (inst =3D=3D 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
> IP_VERSION(4, 0, 6))
> +             r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw,
> "amdgpu/%s_%d.bin", ucode_prefix, inst);
> +     else
> +             r =3D amdgpu_ucode_request(adev, &adev->vcn.inst[inst].fw,
> +"amdgpu/%s.bin", ucode_prefix);
> +
> +     if (r) {
> +             amdgpu_ucode_release(&adev->vcn.inst[inst].fw);
> +             return r;
>       }
> +
>       return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 2282c4d14ae7..58fbb87e5ec4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -483,7 +483,7 @@ enum vcn_ring_type {
>       VCN_UNIFIED_RING,
>  };
>
> -int amdgpu_vcn_early_init(struct amdgpu_device *adev);
> +int amdgpu_vcn_early_init(struct amdgpu_device *adev, int inst);
>  int amdgpu_vcn_sw_init(struct amdgpu_device *adev);  int
> amdgpu_vcn_sw_fini(struct amdgpu_device *adev);  int
> amdgpu_vcn_suspend(struct amdgpu_device *adev); diff --git
> a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 8b860db34584..6fd509e6744d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -104,6 +104,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_rin=
g
> *ring);  static int vcn_v1_0_early_init(struct amdgpu_ip_block *ip_block)=
  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     int inst =3D ip_block->instance;
>
>       adev->vcn.num_enc_rings =3D 2;
>
> @@ -113,7 +114,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_block
> *ip_block)
>
>       jpeg_v1_0_early_init(ip_block);
>
> -     return amdgpu_vcn_early_init(adev);
> +     return amdgpu_vcn_early_init(adev, inst);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 419ecba12c9b..8f7038190a43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -108,6 +108,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device
> *adev);  static int vcn_v2_0_early_init(struct amdgpu_ip_block *ip_block)=
  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     int inst =3D ip_block->instance;
>
>       if (amdgpu_sriov_vf(adev))
>               adev->vcn.num_enc_rings =3D 1;
> @@ -118,7 +119,7 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_block
> *ip_block)
>       vcn_v2_0_set_enc_ring_funcs(adev);
>       vcn_v2_0_set_irq_funcs(adev);
>
> -     return amdgpu_vcn_early_init(adev);
> +     return amdgpu_vcn_early_init(adev, inst);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 7e7ce00806cc..74814370ddc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -118,6 +118,7 @@ static int amdgpu_ih_clientid_vcns[] =3D {  static in=
t
> vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     int inst =3D ip_block->instance;
>
>       if (amdgpu_sriov_vf(adev)) {
>               adev->vcn.num_vcn_inst =3D 2;
> @@ -125,13 +126,11 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_blo=
ck
> *ip_block)
>               adev->vcn.num_enc_rings =3D 1;
>       } else {
>               u32 harvest;
> -             int i;
>
> -             for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -                     harvest =3D RREG32_SOC15(VCN, i,
> mmCC_UVD_HARVESTING);
> -                     if (harvest &
> CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> -                             adev->vcn.harvest_config |=3D 1 << i;
> -             }
> +             harvest =3D RREG32_SOC15(VCN, inst,
> mmCC_UVD_HARVESTING);
> +             if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
> +                     adev->vcn.harvest_config |=3D 1 << inst;
> +
>               if (adev->vcn.harvest_config =3D=3D
> (AMDGPU_VCN_HARVEST_VCN0 |
>                                       AMDGPU_VCN_HARVEST_VCN1))
>                       /* both instances are harvested, disable the block =
*/ @@ -
> 145,7 +144,7 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip=
_block)
>       vcn_v2_5_set_irq_funcs(adev);
>       vcn_v2_5_set_ras_funcs(adev);
>
> -     return amdgpu_vcn_early_init(adev);
> +     return amdgpu_vcn_early_init(adev, inst);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index ca4ee368db02..a7fb5dda51dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -124,6 +124,7 @@ static void vcn_v3_0_enc_ring_set_wptr(struct
> amdgpu_ring *ring);  static int vcn_v3_0_early_init(struct amdgpu_ip_bloc=
k
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     int inst =3D ip_block->instance;
>
>       if (amdgpu_sriov_vf(adev)) {
>               adev->vcn.num_vcn_inst =3D VCN_INSTANCES_SIENNA_CICHLID;
> @@ -147,7 +148,7 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block
> *ip_block)
>       vcn_v3_0_set_enc_ring_funcs(adev);
>       vcn_v3_0_set_irq_funcs(adev);
>
> -     return amdgpu_vcn_early_init(adev);
> +     return amdgpu_vcn_early_init(adev, inst);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index ee6c08707312..c0c2a071ea15 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -114,15 +114,13 @@ static void vcn_v4_0_set_ras_funcs(struct
> amdgpu_device *adev);  static int vcn_v4_0_early_init(struct amdgpu_ip_bl=
ock
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> -     int i;
> +     int inst =3D ip_block->instance;
>
>       if (amdgpu_sriov_vf(adev)) {
>               adev->vcn.harvest_config =3D VCN_HARVEST_MMSCH;
> -             for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                     if (amdgpu_vcn_is_disabled_vcn(adev,
> VCN_ENCODE_RING, i)) {
> -                             adev->vcn.harvest_config |=3D 1 << i;
> -                             dev_info(adev->dev, "VCN%d is disabled by
> hypervisor\n", i);
> -                     }
> +             if (amdgpu_vcn_is_disabled_vcn(adev, VCN_ENCODE_RING,
> inst)) {
> +                     adev->vcn.harvest_config |=3D 1 << inst;
> +                     dev_info(adev->dev, "VCN%d is disabled by hyperviso=
r\n",
> inst);
>               }
>       }
>
> @@ -133,7 +131,7 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_block
> *ip_block)
>       vcn_v4_0_set_irq_funcs(adev);
>       vcn_v4_0_set_ras_funcs(adev);
>
> -     return amdgpu_vcn_early_init(adev);
> +     return amdgpu_vcn_early_init(adev, inst);
>  }
>
>  static int vcn_v4_0_fw_shared_init(struct amdgpu_device *adev, int inst_=
idx) diff --
> git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 2c66a7a4ff25..1d1ee6da7647 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -105,6 +105,7 @@ static void vcn_v4_0_3_enable_ras(struct amdgpu_devic=
e
> *adev,  static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block=
)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     int inst =3D ip_block->instance;
>
>       /* re-use enc ring as unified ring */
>       adev->vcn.num_enc_rings =3D 1;
> @@ -113,7 +114,7 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_blo=
ck
> *ip_block)
>       vcn_v4_0_3_set_irq_funcs(adev);
>       vcn_v4_0_3_set_ras_funcs(adev);
>
> -     return amdgpu_vcn_early_init(adev);
> +     return amdgpu_vcn_early_init(adev, inst);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index d725c12ffdaf..81efc53e7cd3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -112,13 +112,14 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct
> amdgpu_ring *ring);  static int vcn_v4_0_5_early_init(struct amdgpu_ip_bl=
ock
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     int inst =3D ip_block->instance;
>
>       /* re-use enc ring as unified ring */
>       adev->vcn.num_enc_rings =3D 1;
>       vcn_v4_0_5_set_unified_ring_funcs(adev);
>       vcn_v4_0_5_set_irq_funcs(adev);
>
> -     return amdgpu_vcn_early_init(adev);
> +     return amdgpu_vcn_early_init(adev, inst);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 3856388179b8..7873ca91da4c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -95,6 +95,7 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct
> amdgpu_ring *ring);  static int vcn_v5_0_0_early_init(struct amdgpu_ip_bl=
ock
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     int inst =3D ip_block->instance;
>
>       /* re-use enc ring as unified ring */
>       adev->vcn.num_enc_rings =3D 1;
> @@ -102,7 +103,7 @@ static int vcn_v5_0_0_early_init(struct amdgpu_ip_blo=
ck
> *ip_block)
>       vcn_v5_0_0_set_unified_ring_funcs(adev);
>       vcn_v5_0_0_set_irq_funcs(adev);
>
> -     return amdgpu_vcn_early_init(adev);
> +     return amdgpu_vcn_early_init(adev, inst);
>  }
>
>  /**
> --
> 2.34.1

