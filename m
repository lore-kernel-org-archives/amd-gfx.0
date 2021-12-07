Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF0DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 02:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9D1733A3;
	Tue,  7 Dec 2021 02:31:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18F5733A3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 02:31:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njVKeEucHmKaZ6HU1jZTvNMeX7p/MctSVEbpNJrciFe43nQB54MfQZ7VOOMOeq4yrciMwv9kAbdPrhiofMZGd8E4wOFHrdHUgiuyg8fam3MgbVp5ePr/JpQP0esGGDgafdpxH4EY7cmxv/0S8NxHCrAedvtvpIqhGuhXfpAqYjCxJ//HKwqrmtRbR/TivMid4dudY7XKSP2vqfOC3a+ChpP31xCofs1baHFVF70HfFcjWn1Li7TwWWuVPVW8jEULQAXsXKs/owiEzE57q5S26oz48m+2Y8Dk8cQL2GYNKRnd7Fy/Fz/J/GrsFrf1uNKwrJCBIGmvArX+nQS/NfmhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5bF2YJJjgD6boO1bZfmTtY4bPcF8kotVbadBS0a15g=;
 b=ikbKiLBFx2J2rdDuU1yRp5NwxxgAEWX+bcjjekLvfVrgiTkd1MesQfNq+2xthBvZ6FyN6s9F3sgqWX8Q9C2L+M6DPpB549qKMPLdNG21+MXgDO8LbQ2zJ1r1KOqzirSLyrqLuLXZmsFS/UTTcjMopgUIOs5udUxtiax4h+4t3FuDoqBK071s1qV25e39tN/reFZfzlLTgs5P4SZIHc/rU9t+y3xpnkz+4lNunCeuoyXHge3QsG7YiX24FYgKERcS8kK1HSXkWeeXuS0eHCKGlf22emaaI3vnQ/z6pSbGxdziUMsIqZ8AU5RNunh+aQxxDJ8dB/SnPDjZorOF0qvaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5bF2YJJjgD6boO1bZfmTtY4bPcF8kotVbadBS0a15g=;
 b=voLeSnM958ck1nbPuPixFxlqPgQZybEK8UTLsmZY9T7CW6eAf7Th0+V6m7Urq/JpEUhNHLQD0ZwBJju2Lw7QzFzzZzR8gyWuifAL/fB9rTDnwhcarKs60UTd3dkMRN+iwkakSfhcEdMctn+zHN8xpGwR5cF+fI3ICiE+ovw5JzM=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 02:31:43 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e5:e439:ff62:252a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::e9e5:e439:ff62:252a%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 02:31:43 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 02/11] drm/amdgpu: Modify the compilation failed
 problem when other ras blocks' .h include amdgpu_ras.h
Thread-Topic: [PATCH V2 02/11] drm/amdgpu: Modify the compilation failed
 problem when other ras blocks' .h include amdgpu_ras.h
Thread-Index: AQHX5qGxWiio00fZ+Ei2Ns53cI8fOKwlD4wAgAFIDAA=
Date: Tue, 7 Dec 2021 02:31:43 +0000
Message-ID: <CH2PR12MB4215799B5896C039907AAC2BFC6E9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20211201105250.298525-1-YiPeng.Chai@amd.com>
 <20211201105250.298525-2-YiPeng.Chai@amd.com>
 <DM6PR12MB46501EE5EF1932B03243BA53B06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB46501EE5EF1932B03243BA53B06D9@DM6PR12MB4650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T06:55:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1f28ac8e-6f06-4846-94a8-182b97659aff;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf6017c5-7656-4588-dcd8-08d9b929b50e
x-ms-traffictypediagnostic: CH2PR12MB4136:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4136A7EAB87B99BA392352F9FC6E9@CH2PR12MB4136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bTTPp77dYtLI6PdFE618K+DxehI/lhkdvG9hEvU6Yv2K9pHP4t/oOG4jl0ODpW81H0BjhQWhcK6hBthB7zLNrbriXiYFoddm//poCMgAXd1NT3LHMmyqYZfVsVIc/X8vkCVnxkERdxu7Gzl/j+5FKVlGusQNGvCrfE31USJt9t+f5LzEC3qrvcTD1iT3cNAjc7XGExq7IqAMC139wYw7NvdzsZh3n2HZdcL8P2NBZ0tvCDKbl7pM9D2KodolCsS8sX/RjMeaTAXtQU9CSM2MSDiaKhUnGlrzCThNL5samO8E4rwYy2RWcZ0zJww/+OP7KM9VEj6JNhSwgbhtlp362fThSj2mFwNBJsbrrNhg60GbkpdtSYX9JbG0RXKwxSh2BVrYiIqZzAOuo7Ym0fhJekzvVaXlJKJMBSVAuFRGtwAwfGtmDfhx+XWO7ybZnLucWRQ5+OZ8qINp3Q3AMxqS1p20//zWexPajAWCY52yS9TKXvX3IA64C3CRUXMkWPUuxd7Gw643juK/ieBU+bdGAcksmas4tp5+l3xEiWPiCICDioqz/WuQdL3yqpMcr5Nn50t/EPLzWwmfoQQUiGxv3gEMSo+j0d2L5c0G6o1aULc33t5V2rTj6HoJ6EA0e6nbyd3Nb8uEdv4FnMvdo9coAaLTICXMw6/MqEU6/TlD+kKt/jdBjCCCBicGjlTuhjdMZ+Xdx0NA/rpuP+ICrTevsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(71200400001)(8936002)(8676002)(508600001)(2906002)(86362001)(9686003)(52536014)(76116006)(64756008)(4326008)(66556008)(66476007)(66446008)(83380400001)(66946007)(33656002)(316002)(186003)(110136005)(26005)(5660300002)(53546011)(6506007)(7696005)(38100700002)(55016003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q0JRzIO0SQp5KbYzaLyorgz7/Xy5GGGLiOugb3UybsQcLTSSL2XSIi3u6FMi?=
 =?us-ascii?Q?FCQ9BHK3UodHArtthUhyDikApvYaIHyoJtVJ6yecBNbqNpUDg6VPTuszkZVM?=
 =?us-ascii?Q?SaHaDlAiyAJDV7a0/Lyk8I2zf8O10f7uh/GnuyIH1aN74RgQxLXIV0UOkQNJ?=
 =?us-ascii?Q?JEO2fl9Der8Ou9aLwLe652+7P3Hf7UxVbWk9wW+HqmnHrvMWaGFCf5Gg67B9?=
 =?us-ascii?Q?KkzHZ1GFzez/GSqK7F/8/O0c4fbHlKgF8LZvWkxlSuTUJmRQwLSj1IoYGNXh?=
 =?us-ascii?Q?e3ciDMjag7DTp5nlG3XFOwLJ1tm6/Ged39HN+umO8ZEQaTWuZq0siInvHb3N?=
 =?us-ascii?Q?b9/o4wdSPFdMrIQZQuBxErO+ZsudNVqhDYFjo58i7W0HfRZa4u8Lu7sXyJQd?=
 =?us-ascii?Q?1VBm4r3M6S4FobS185PHTpfrY+5Nqr8ECw9pIW5sYUjBoy1xB2cV+dJkyPKL?=
 =?us-ascii?Q?3EL1E36iqNImWuh00NrGPSL4udZi4xYS48ubI4ZlEH7SYLr3cV+dNGJ0V3jf?=
 =?us-ascii?Q?9o1j77Xvl8OXJO7MS6i0kGXoJcEimFaDmfAdJD/js/g01RMqQPNMgzQaUf6f?=
 =?us-ascii?Q?EYKrdo2UYABsRfyJMyZuQ6f4bUx7fN/iNgO5mMcJYBaifodW17Zo1IPOCgUg?=
 =?us-ascii?Q?h/B/Cw7QKWYOQUarumiua0YFazXn+T+lhRSGR3OG8sFV293O9INAtgaHLFfV?=
 =?us-ascii?Q?cPt3n8FHXkRh4iGrVGKyQ5XRhy27k1i0ljiNnN7xAbCpkYIDbm9fqDuM/s/Z?=
 =?us-ascii?Q?Ky0iYd3UV9xrTl12EkHCnm+K+11MWGCRpMRDwZzrtdae0uSN82uiJAY137eU?=
 =?us-ascii?Q?s/6KYKhv4duLECu2eI+1kGeB2pkK6fRmI+UYyt5omZpOsx6s2THMicLFgkUy?=
 =?us-ascii?Q?kNg8HvTwJCOmjvukfABsji911W6UTFHxMACnoWwlLFC+86PoHT2NapNsDeDw?=
 =?us-ascii?Q?VK3ASPbG2TUL9RqEv/ULxOvzIJ2/6KWkR6rZ8Gcf1SH51XC5VMxOJoLUMUnP?=
 =?us-ascii?Q?B1Nwp154Cs+/2DP+s7mAtMbi5fsinRcYQ6bbeFWW+UyDdG+/1p8kYKxHsOWa?=
 =?us-ascii?Q?NeqVj6r3harUtCyivV1QGF/q9P/F6V6bLxggHaqG42/1B3CrZ9ibWc4OX7Up?=
 =?us-ascii?Q?MZVLxPJghQaPO9OmX00c74gsU7av6bpJM+dKahbsXd7IrAhEODdXm43+Eqf1?=
 =?us-ascii?Q?gqy03w7QHkKXu5WmyYKWS1U5x3/VwJ32NGwub8oLAfXXNrWyP6eBpjBIuZP+?=
 =?us-ascii?Q?6MnySnJS/M39mC9BT4KEj59BSUpTfffm5R3cwliYIBcVaeQGzuRclS4GdLYh?=
 =?us-ascii?Q?TuDY4ZzPI6/aM+ElJ5w2QIUkKWTmYIydMRQpff/I72UBSsaLEuQ/MHkB/4KR?=
 =?us-ascii?Q?+lfoZlt44cS18X/CptJZoSEZZuzTK/Drsgl4cWOTWJKZnT21zVf4KifHcOjg?=
 =?us-ascii?Q?loKfKwrH7uARV88pOxDX/4VXzDbPP/CyikCmMjzHumoeo6+jxMDsvzDOfxNI?=
 =?us-ascii?Q?ilgf4FxJydXZ64IAHeJmFHPaOdQRmlw9BrIFRmvKiloNLf8bqm7vCDtrK2PI?=
 =?us-ascii?Q?xMBtLZiC/xhgWVGZP86QSien0QY5YNMBPankDxjDxoUMeskhMFguXhbmgZXj?=
 =?us-ascii?Q?rgr/KHn7R68/m5tqb5LulzA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6017c5-7656-4588-dcd8-08d9b929b50e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 02:31:43.0365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TGsn1x0vg7Fibn+oU2+2qXc7n6ewXZv4/tQ5cq9VL8wbikEYFSrbU7fWyI2X4g25gyCZLFw6mr+7NPbysdy3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, December 6, 2021 2:57 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH V2 02/11] drm/amdgpu: Modify the compilation failed pro=
blem when other ras blocks' .h include amdgpu_ras.h

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, December 1, 2021 6:53 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas=20
> <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 02/11] drm/amdgpu: Modify the compilation failed=20
> problem when other ras blocks' .h include amdgpu_ras.h
>=20
> Modify the compilation failed problem when other ras blocks' .h=20
> include

>[Tao] 'Fix' is better than "Modify" here.
[Thomas] OK.

> amdgpu_ras.h.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 ++++++++++++++++++++++=20
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 23 ++++-------------------
>  2 files changed, 26 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8713575c7cf1..1cf1f6331db1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2739,6 +2739,28 @@ static void
> amdgpu_register_bad_pages_mca_notifier(void)
>          }
>  }
>  #endif
> +
> +/* check if ras is supported on block, say, sdma, gfx */ int=20
> +amdgpu_ras_is_supported(struct amdgpu_device *adev,
> +		unsigned int block)
> +{
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	if (block >=3D AMDGPU_RAS_BLOCK_COUNT)
> +		return 0;
> +	return ras && (adev->ras_enabled & (1 << block)); }
> +
> +int amdgpu_ras_reset_gpu(struct amdgpu_device *adev) {
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0)
> +		schedule_work(&ras->recovery_work);
> +	return 0;
> +}
> +
> +
>  /* Rigister each ip ras block into amdgpu ras */  int=20
> amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object* ras_block_obj) diff --git=20
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index d6e5e3c862bd..41623a649fa1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -514,16 +514,6 @@ struct amdgpu_ras_block_ops {
>  #define amdgpu_ras_get_context(adev)		((adev)->psp.ras_context.ras)
>  #define amdgpu_ras_set_context(adev, ras_con)	((adev)-
> >psp.ras_context.ras =3D (ras_con))
>=20
> -/* check if ras is supported on block, say, sdma, gfx */ -static=20
> inline int amdgpu_ras_is_supported(struct amdgpu_device *adev,
> -		unsigned int block)
> -{
> -	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> -
> -	if (block >=3D AMDGPU_RAS_BLOCK_COUNT)
> -		return 0;
> -	return ras && (adev->ras_enabled & (1 << block));
> -}
>=20
>  int amdgpu_ras_recovery_init(struct amdgpu_device *adev);
>=20
> @@ -540,15 +530,6 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device=20
> *adev,
>=20
>  int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev);
>=20
> -static inline int amdgpu_ras_reset_gpu(struct amdgpu_device *adev) -{
> -	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> -
> -	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0)
> -		schedule_work(&ras->recovery_work);
> -	return 0;
> -}
> -
>  static inline enum ta_ras_block
>  amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
>  	switch (block) {
> @@ -680,5 +661,9 @@ const char *get_ras_block_str(struct ras_common_if=20
> *ras_block);
>=20
>  bool amdgpu_ras_is_poison_mode_supported(struct amdgpu_device *adev);
>=20
> +int amdgpu_ras_is_supported(struct amdgpu_device *adev,	unsigned int
> block);
> +
> +int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
> +
>  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct
> amdgpu_ras_block_object* ras_block_obj);  #endif
> --
> 2.25.1
