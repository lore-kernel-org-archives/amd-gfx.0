Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0A1C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 22:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C270410E96D;
	Thu,  6 Feb 2025 22:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WYwecCu3";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D46610E96E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 22:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5x3UVww9wkSLutmTZqA4L7eRNr7L9dSxNzjMuG4fKo9werOtMn8UCNiDe/qHgXf+0zI2yTf+hG3yKhOWwH4KGloI1/2V2nGvBmH/d2Fe2LlZgSmmOQSLyb4LDEgkKtFfXENV72dE4umP0dooNlqQnrlzpk4ytyyRW09ncMpB8NguT6xTGEuoA9aSj8ezaaNQGNefEyIppQAG7nd/Yu5Rl0RCZCsz74bmNJ8veKfs4JDTv/XeaacF/nJZ6kSPYRlMshpLYYj0Q15njCzpni6ldPNAwkm4RT/TUHvDMsfYJ2TeGmLoguTyUDS8n9RYsziBmJNrYgRUuQBNl9jN2BPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqnvnx7IClzEDnpo3/NSrOcGvHNxyHXcCgghP26y7bw=;
 b=EUXh8HfMOfNO62r7UZiirVsTXxzg9xBcSxvJZlrCI4UKy8iqCZx1imwlmh/7AHw4grScDnoxmtiSgEd1pOse1b76gmEiVQYTNQqJgxVYPl1wnFz9XtQ/ydeoYdpb//0jn9TWgzXcAK4infNdiCtHDgkHmY5Aq4VGRFpIh+/4XI4EBzY1rV/ulMOF30VhFvmHzI4HxyEgCTeS0yvx3N6UrOKKPIu5cLYrpseu+iFRQeQcKqalVu0SWj7zQPks6sia4cO6/Be2EXpjzHCjbTUFImsGmFqTQcuERu5QwCiCFaKkToyOukDad+LVHLV35d/pJSw0OaJT2tT+QR1Huv32Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqnvnx7IClzEDnpo3/NSrOcGvHNxyHXcCgghP26y7bw=;
 b=WYwecCu3zw9qmn+9yvfcfrWr7FkVj6/pI4PvPEtz8+5X/ePi9qGkQ2ere82DXUlQuD2tmaAKs+twiGnaGhmh9thsXe02RmnVZf7wGuPE0RABhnTFVPhMaxBygWBtfWgxDoOoXr0fpXlJXNdLBODkMRlY2Oj3tstohHVpXG23ZoM=
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 22:27:48 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::f62:33c5:301d:edf0%6]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 22:27:48 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Sakhnovitch, Elena (Elen)" <Elena.Sakhnovitch@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Cornwall,
 Jay" <Jay.Cornwall@amd.com>
CC: "Sakhnovitch, Elena (Elen)" <Elena.Sakhnovitch@amd.com>, "Kasiviswanathan, 
 Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch, Elena (Elen)"
 <Elena.Sakhnovitch@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Set lower queue retry timeout for gfx9
 family
Thread-Topic: [PATCH 3/3] drm/amdgpu: Set lower queue retry timeout for gfx9
 family
Thread-Index: AQHbZr4Un1ZZJH3ZxkqN4Dg/Xj5Gl7M6/yUQ
Date: Thu, 6 Feb 2025 22:27:48 +0000
Message-ID: <PH7PR12MB5902C5C4122EDEA9EF11ADBA85F62@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
 <20250114195251.42661-3-Elena.Sakhnovitch@amd.com>
In-Reply-To: <20250114195251.42661-3-Elena.Sakhnovitch@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bd7b4bf0-b107-4880-8f51-0fefdcbaeb3e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-06T22:27:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|MN2PR12MB4112:EE_
x-ms-office365-filtering-correlation-id: c763ba7c-f8eb-40e2-c5b9-08dd46fd7c2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?o1Gqc4gum/d/fmkj5E00VUi50nNLYedHvvMFvHxjRMjdf2luld9XvB0vlkdd?=
 =?us-ascii?Q?c3PW9pSNblF6k5rkaJJhuFcPV49ve5/Dt7amiUHZksrCoQoSL4wnf1Kkcs3f?=
 =?us-ascii?Q?4Oy2CMCQRIbck4Rz4NB7zeFxZqSeiFr9L5pcl69loLflfTmcm+mNS7h6apSG?=
 =?us-ascii?Q?sQCoz9VD9Jw4TyRHFeKQ775FYr3O3lxpaqf3l/VqvPJd9p+kEGNOEFdpLlJj?=
 =?us-ascii?Q?2H9ysJXDE9xl4ba0F/yM+H8UJS/bYOmv/jnu/91nCub5N1BVcbzuHLbsOUuL?=
 =?us-ascii?Q?GjI5HD2kWy5t6KaAJZd02fLj3Wt1p2R/HAbUqcz4+xXRBQ1EVbfiif8pDEB1?=
 =?us-ascii?Q?D+8T6lYcmuQVevQfIW8bwfaL6jXn6Muej2PdfcGzeQZr67Lw3uB4HxTEmUtl?=
 =?us-ascii?Q?f6o3E7ZOMyRS5Ui7t9ePibXCBrFLL4O7L71DXAa0Yqv5aKU3juCJ8La4Ri40?=
 =?us-ascii?Q?wzAquSfLaCTy7Wj/RQ4AtmtKRGg/LmtU1TCaCYaFRbxuMH0dp+MiBMYG9Vma?=
 =?us-ascii?Q?d1V1F4s6/WfKBtpZ2Cwdzp8IaCg9UCdgTHIk5fa2aAduxzKI2UIJ0OFA52Hn?=
 =?us-ascii?Q?E6IPAANyMuQS872PDHxAeOc5jkphsK30ZejP5ih15Quk8TniLa6AtT2vStt8?=
 =?us-ascii?Q?19ESUO4DzFpDqvqsVgN8OYJ4KYJhFBcNqp2e6Mw57oisvptJdDz2+ukGaglB?=
 =?us-ascii?Q?7pEeLNSYTmr3uzzBm3ObQ8oPnTCqcRKvrUCCaWQuWoksilDZJoPml5prCpfS?=
 =?us-ascii?Q?yKdagq1x/N9vON1nTeqk2/I8V+dJb8kSjVBg1v0Q44Ep9t1JAKfWrZodGtJi?=
 =?us-ascii?Q?mkUcBI/9FGHjobcuy+tlx+/uBjoxmz9VeXsUiYisfZRNDfynwmHNx/oAOMbo?=
 =?us-ascii?Q?/CnvQi4/2UBGefs0CVG/h0oEQYmtY3kl25cjKr6FoSzXBixHT3a5assrs8XW?=
 =?us-ascii?Q?kRSK/3kk2gBBvQfBbZflbZ5EYfi1BTPQQ2MaaW2jsiZA6avF4JnJavnA5PLO?=
 =?us-ascii?Q?ZFdVQkAGqScemuBtYdSbzbPMVPOTuHaE8w+qJeieSNaBQQEVoOKSM0Of2IV+?=
 =?us-ascii?Q?BybxELp6uJR9kVEc4+qf7EFutGjEbdB6ODeQFtIouxuJuGUiP2fmJdwjYqQ6?=
 =?us-ascii?Q?P55pMTTyKvzGa/SQ57M4cS0pvQHeoY9Ext/dTl/59wXTTKw1j5k9Bmbgs33o?=
 =?us-ascii?Q?wsnvQ+gldNcRaNt03rnGEyI2GAG0rse3M686MhPd5RWvvmxAoq0BOQjR5kzV?=
 =?us-ascii?Q?wMCyA4WlTSIKLBoyA5We0iAJxK+0BGjGF54bFM8Ok8MdYDFvHHesYsIWJ4z6?=
 =?us-ascii?Q?HQv8soJ5AfIcABA0dUesYBf/4h2F7egDhblP7nZf6olSZyRa3eG9EylH9AmO?=
 =?us-ascii?Q?5VjqKuSymwZ+e6ZsEzXK4OageV4rZ9f1UOQ+r3OktW+J4NkhRYQLhE7STJsD?=
 =?us-ascii?Q?6VUBHC7bDPjfJzWiMQSbHpsKFMDkFlJn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5902.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j7W7dYOsJe0KmX/6OUYSTr2xSvoH35sG2h1B9wx1mPSfGNtwRry7vbRQ1N6l?=
 =?us-ascii?Q?isU8us81G2bTSeXhja30zk3FGg/gbrUW2iQtot6+Wu5mJ2dVyflZh3Ob+qi2?=
 =?us-ascii?Q?8+6lG+z0K6nRZOthTZxBcn/6Cn/BZLkwfbqzG0XMuVkICSfg82cWyuXMMy90?=
 =?us-ascii?Q?8r0Bi8D3fLb0/QWfI0myh0cle1Hq16DMO8EfFfVyKUH9BWtj+yw8C6XGp0Cy?=
 =?us-ascii?Q?cjoYj7R5BEngK2q/UYzvjH/Jw5qhUsGv9lzuV+qfixI9cCIIoQRipt6SIo9C?=
 =?us-ascii?Q?LjITu+nS5rF/SNI6PYO+0dR3BATheAt24MdFkjQfKODd9kyYzsHOuu+McMnf?=
 =?us-ascii?Q?sdvQG3ZSNZqWRT2zqMB6tnfqsrERq+ooGisDQfXIRmEIugpWQvNMNqteeQ0Y?=
 =?us-ascii?Q?QwIr6dFPfewN5KwIgVDKS3uNfUZUt6SQ8RThVpwS6EEzwmmRZRirGk2Zj34m?=
 =?us-ascii?Q?O77Kvwllz225EUmK4wJh1cY16fjEK9QSmGDYQngQWpj2YBv5SuWWjOfGRxLT?=
 =?us-ascii?Q?VP3Eg3Z7XCbLUbTA8arYTZnbiy04w9svFGTri8kc11Cw95wz9Ffut/MTcclW?=
 =?us-ascii?Q?IyIJNsJTsHNOx4igabMSSOSaNCvi0UfXTr6OXRq6Se/a+1MckA8EMXKxiN5A?=
 =?us-ascii?Q?QT4y8rgE43t/9lmSZbIW7BIwg5VJbqrTGXTf6Zv5Zappm4nGQ5BD+XxmV7Eu?=
 =?us-ascii?Q?s4ZIDHjvpBWsY9vrnpXCMS5m3aI/h0Do4LDWRBj/3lKGBO1XxXZShWKJT3dU?=
 =?us-ascii?Q?iJ8ZiUiwLMr5SCm+XBLFgn1KCHLGmLvvaCRSt19GSewrTQQTOeO9Ej2ya6dr?=
 =?us-ascii?Q?vth7jZEOcy6IM3NAncTt/Q/g9hch/SXohzgYZMcMmGaMFHd84ZbKlG/JgrZv?=
 =?us-ascii?Q?yR585uBfltuKCH+ScVqJAmgn/zquqY9mLj4kR2a1MaR2MPiRRVgtuVSmOkJg?=
 =?us-ascii?Q?FpBOz6vJItAmmSjlw8GAFju0OL8aJL9iSuWSrYUsAtCz/jmZaQafvwX+EjU6?=
 =?us-ascii?Q?FzIiToQFhpwnwFdpYJP32MOeQxooquJ/V3PTG5TGka9XSFLyd429vueVlKlk?=
 =?us-ascii?Q?3y1f/8afxCTkXAle4ns+LxChCulhuRFKjRc3g4611+r9niYNihVhtRSD9jG5?=
 =?us-ascii?Q?qDIs+QHFjWU5bdpAGeyyphvFCLT4VpNhDX1FhNtn6YtfJjHm2WfpKKvWZpX5?=
 =?us-ascii?Q?ihfrLysqZEUFNSK11tmOJ/O5xt6mZHxMBK9hJJfxsnESd38503WMkZ2mvjbf?=
 =?us-ascii?Q?VBRhLiGwhgWso//3yCLiFhEOUx9dQWYksurWHaiqOt2H0tcF1+3SYodN1O4I?=
 =?us-ascii?Q?Mi5ujNkhba0sXcyhTTadSCOv4J6hVOPY+O7WNarN9c8ZeQiGRBo2Cnn85bn+?=
 =?us-ascii?Q?bBhYSui17w2y5c9GaRFiANBqsVYtCgs+iwixiHYKN/f3rbwyjNGk197d/vRZ?=
 =?us-ascii?Q?fEymd+zOpIxm3XwPnA4VRKKQs6oueaNJqehkKOyx43ETnPu6pyZ2VnoK4+vd?=
 =?us-ascii?Q?danaSwo1Sm0z3Bnc5z8Gq0JNFobsGnd+6fCEh6Vvs6kcPg1Q82S96sTB37m6?=
 =?us-ascii?Q?aVHXr0uqKIuPh5O8lzQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c763ba7c-f8eb-40e2-c5b9-08dd46fd7c2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 22:27:48.0529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aBhhST+ti3WXFGIe4UuLgu7/fad2wt/33f3mX5frSPkuBbu6ebT6ctEv9WiIOxvD9kWKj64BKCVMXDZmy/PS+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

Ping (plus Jay)

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Elena
> Sakhnovitch
> Sent: Tuesday, January 14, 2025 2:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>; Kasiviswanatha=
n,
> Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen)
> <Elena.Sakhnovitch@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Set lower queue retry timeout for gfx9 f=
amily
>
> From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
>
> Set more optimized queue retry timeout for gfx9 family starting with
> arcturus.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Signed-off-by: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |  8 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 14 +++++++++++++-
>  drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |  1 +
>  6 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 8e72dcff8867..652c695d04e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -1024,6 +1024,7 @@ void kgd_gfx_v10_get_iq_wait_times(struct
> amdgpu_device *adev,
>  void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
>                                               uint32_t wait_times,
>                                               uint32_t grace_period,
> +                                             uint32_t que_sleep,
>                                               uint32_t *reg_offset,
>                                               uint32_t *reg_data)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index 9efd2dd4fdd7..11aedaa8a0b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -54,6 +54,7 @@ void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device
> *adev,
>  void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *ad=
ev,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 04c86a229a23..d93a0285f225 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -1080,6 +1080,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct
> amdgpu_device *adev,
>  void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
>               uint32_t wait_times,
>               uint32_t grace_period,
> +             uint32_t que_sleep,
>               uint32_t *reg_offset,
>               uint32_t *reg_data)
>  {
> @@ -1092,6 +1093,13 @@ void kgd_gfx_v9_build_grace_period_packet_info(str=
uct
> amdgpu_device *adev,
>                               grace_period);
>       }
>
> +     if (que_sleep) {
> +             *reg_data =3D REG_SET_FIELD(*reg_data,
> +                             CP_IQ_WAIT_TIME2,
> +                             QUE_SLEEP,
> +                             que_sleep);
> +     }
> +
>       *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index b6a91a552aa4..3f159d477f5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -100,6 +100,7 @@ void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_devic=
e
> *adev,
>  void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *ade=
v,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
> +                                            uint32_t que_sleep,
>                                              uint32_t *reg_offset,
>                                              uint32_t *reg_data);
>  uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index adc7f7c78a18..4de8106d14ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -305,6 +305,7 @@ static int pm_set_grace_period_v9(struct packet_manag=
er
> *pm,
>       struct device_queue_manager *dqm =3D pm->dqm;
>       uint32_t reg_offset =3D 0;
>       uint32_t reg_data =3D 0;
> +     uint32_t que_sleep =3D 0;
>
>       /*
>        * The CP cannot handle a 0 grace period input and will result in
> @@ -319,18 +320,29 @@ static int pm_set_grace_period_v9(struct
> packet_manager *pm,
>       }
>
>       if (grace_period =3D=3D SET_ASIC_OPTIMIZED_GRACE_PERIOD) {
> +             /* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> 0x40.
> +              * On a 1GHz machine this is roughly 1 microsecond, which i=
s
> +              * about how long it takes to load data out of memory durin=
g
> +              * queue connect
> +              * QUE_SLEEP: Wait Count for Dequeue Retry.
> +              */
> +             if (KFD_GC_VERSION(dqm->dev) >=3D IP_VERSION(9, 4, 1) &&
> +                 KFD_GC_VERSION(dqm->dev) < IP_VERSION(10, 0, 0))
> +                     que_sleep =3D 1;
> +
>               /* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU *=
/
>               if (amdgpu_emu_mode =3D=3D 0 && dqm->dev->adev->gmc.is_app_=
apu
> &&
>                   KFD_GC_VERSION(dqm->dev) =3D=3D IP_VERSION(9, 4, 3))
>                       grace_period =3D 1;
>               else
> -                     return 0;
> +                     grace_period =3D 0; /* 0 will keep the default valu=
e */
>       }
>
>       pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
>                       pm->dqm->dev->adev,
>                       pm->dqm->wait_times,
>                       grace_period,
> +                     que_sleep,
>                       &reg_offset,
>                       &reg_data);
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index e3e635a31b8a..1ed3fbedf50b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -316,6 +316,7 @@ struct kfd2kgd_calls {
>       void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
>                       uint32_t wait_times,
>                       uint32_t grace_period,
> +                     uint32_t que_sleep,
>                       uint32_t *reg_offset,
>                       uint32_t *reg_data);
>       void (*get_cu_occupancy)(struct amdgpu_device *adev,
> --
> 2.34.1

