Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F91606A333
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4HLgWspv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631EC10E413;
	Tue, 27 Oct 2026 12:14:35 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A05310E413
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 12:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2oZJNemnV8wj41BXjfFRlY+mbuRz7IOv48zNd4G9IM9mWJWARbxPvF6c9ej2HHcnCYN1H/p/b3/K+QMYihXKzeTwlGFStYOAXLIKealH/baR7+o9clbolekaO9QTUadBQcFRK/5XzwDzC1TVG4UZIIFg2G8zgL3XJkbumQDRqM5gDnAgtnt6Al4BYXFKgz4dj6wkV3IQm5vWeek/BUUoapY+tYHpKP2sCkp3mR9CNMSxcZyo2VLm1WhepksfyYWoCDudbeI1DhDBooLkUf0q1vrah43BQigu0+6umQXNd2zORVS5CpoD/81HJ/0nRo3pDKw7gI5NgJQPfG4sgKVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvswTBy48pbTZLZJT5Rc7GqNrJ7/sFVVUv9cOgVxwLU=;
 b=TzpM9JzEDiHq4KxoWyJufivoliU4ADDWFyAyIac23q5SELl744np8Sq4u5SAViCsQVi+nMka1DpxSKm2zDfZbbwW9zIDgFK7KY6VDF6P8csMWmktweVyZEDBk9EuNjRTefjBKfIulBFN5Xrx/2Ox9jbK5QdG6Fa2tljxMCce3V4M6N+h8PjHk5x7Ei3Y/JhfP54GG+cNEZoZ0e8edFm4k61pqtNNMyw/A5r7/oEwPCzqgzJ4i0c4J3Wjeox0De7KPjn/imoYGbqgbFRSBVpvTikUm6zZVhtsqb96vSAsstlNjYkI71GsCk5bGp11cjgoRbcVuhXtH0XxThLXSgIbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvswTBy48pbTZLZJT5Rc7GqNrJ7/sFVVUv9cOgVxwLU=;
 b=4HLgWspvAzGRXZNDDxDcKd0eWCU5367eERXsKfHlsO9JGBqMjF/VFLfVsl5vtpsyEVQq3ECGh52oJuembcekWDwOzoPJxKE0ml5BRkHT7aaBUaaIFTTiZBwlhJ9ORb6j1ivKhnUFyLRm5Lsd8r7vlOW5t+DP+M0AqeD31/VHLB8=
Received: from MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13)
 by CHBPR12MB790180.namprd12.prod.outlook.com (2603:10b6:610:33d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 12:13:57 +0000
Received: from MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a]) by MW6PR12MB7072.namprd12.prod.outlook.com
 ([fe80::a786:e93f:6c7b:ad9a%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 12:13:55 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Rosca, David" <David.Rosca@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Rosca, David" <David.Rosca@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Use feedback buffer for VCE destroy
 message
Thread-Topic: [PATCH 1/4] drm/amdgpu: Use feedback buffer for VCE destroy
 message
Thread-Index: AQHdV/9IkwMm9uyHLUWXg9pRRdklLLcRaQ+w
Date: Tue, 27 Oct 2026 12:13:55 +0000
Message-ID: <MW6PR12MB707209CFB707272B1DE6A9C4E5602@MW6PR12MB7072.namprd12.prod.outlook.com>
References: <20261009150233.90598-2-david.rosca@amd.com>
In-Reply-To: <20261009150233.90598-2-david.rosca@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T12:13:07.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB7072:EE_|CHBPR12MB790180:EE_
x-ms-office365-filtering-correlation-id: 4db15dae-e174-403a-8bfc-08df3423c5e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|42112799006|1800799024|38070700021|11063799006|56012099006|261021123027099003|261021121427099003|261009220027099003|261009221227099003|261009223027099003|261009221727099003|10067099003|261009223327099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info: d+3UmOvwjdMiomdIXAeLMMZ5J0YV13ctRE2S0McKdUIIR8wj7XilUWRYBAf/MZ2XWgft61JYv0gwrsPUGc8vPNWEiWNWLIoANKoYFEXiiGbE6sxHEcZbzQ5vhElrK4ECtUl1ZUIL5eQNTI0MTqs5iiTAvfPeAhFtlfFV7aD+98xWvCczBSQKpAG/UgfePjtVL2XbL0cAdhc4Gv0i+B+73Hwd+VJHPBhdxCQzKpDuiE8ZSBEiF7Y72ololMlER2LKzEn1boPUglG3u4a64xL5fyd4ro1RdjyO+9zw+MWcx6X/OeWMAzuqe6/QkWk9ILEMDZjo3nhNPJKRMUOM652ytGTRTsJpuU0sY7BEjQIwuVJn3QQnw1UcHgxzcMlNmU7cNn0BBzalcHLC1ovLCu9DcIfswFaVQgjo+egh1gPA/xZl71RT00TtY62ZO3ayH9+/E0NC2zA5mztnL3QKaK76HCXFhZk2gQvoUO9X/t0PTedWIW90o374pjY26mzUNak4w9uj8Z7zeRuyK4Fcxroaz45o0tRvW3rkuug7O4/XkKDOWiI8USHcoQI7UzQz4nU4d3ntH5S/FaGcq2QmlFZUtdZihVjlMb86qR+3GV/lESITeP6fFTRhjtC8YyEOGSqRkEu6IFbua4hNoAYfo23B0YM9wk14l20cLPWKbtUrCb7u1iP1bK8WQbAnfY7dCnCTxEH/oRM0O9sJjiDAktivN1j3vlJqN/rDyuR2nyexqmU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB7072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(42112799006)(1800799024)(38070700021)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009220027099003)(261009221227099003)(261009223027099003)(261009221727099003)(10067099003)(261009223327099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nVBRv88RqplJ82uNsLcxwFJpK9J/sMdX+LD1qb6GJ6oGQfz53lRZLKcoLqVe?=
 =?us-ascii?Q?+0e6Y0pdWC6jC66kmVEw2W6tYru/r175zHDtxRrudhIcqMoD8VPqv2uYvISY?=
 =?us-ascii?Q?1OPK1AqoTDoirciUMSGY9sfqUzkiM5oKjLT0GLVOXfGOzZmkszoD6SxEctM2?=
 =?us-ascii?Q?HPfxo4WSdHzpO8U8ggOkW9UH6A88hhomXP7Q1CMkS2gnDSU1CyY9HJwCsi9e?=
 =?us-ascii?Q?+sAkqIxiY8cw1OugjSdxPeNThfD5pRS8eieshVHtZMaUiasqUEfDqWlWsrHk?=
 =?us-ascii?Q?JVOsb03tKxGLF5JMJbV21f4i995wvq1u7KRj9AX3LJ6/VCdYOuh71DBYGjdn?=
 =?us-ascii?Q?hpeOEz5xvq3aqRHDgJeO4ZYv8hAZa2bQ5o9h2RVv9IiFdyTt7jD7IVPAmQtT?=
 =?us-ascii?Q?78ifPRPaNpadgoeVII/4bxB62coL2nFZATD7jHe6ITN10TyNEqu/BpwTNltE?=
 =?us-ascii?Q?TwwTfa0pV9F9FYZ8TYcL4Qittj1giEArAjpAtAhNOsVgiV1DknP0eWo/Ba0K?=
 =?us-ascii?Q?1mZl6dcEiygS8mrTpycCNTgCIftB12D6wjRKDNiHOwFQeCDzzk9JWppFNZem?=
 =?us-ascii?Q?BNE2VkUXt1YnFC67S76zhtV8rFXCKmvPEr+YBWOSzIStAWTkoTn41nvrIo4g?=
 =?us-ascii?Q?E92yP0rnSqykuj2ichp/SmJOsdMicTqO75ebsga/StePQaYvi4b9OLrN0moU?=
 =?us-ascii?Q?FwZzLo/IZIeM6Ub0aOp68MFVUHdpYHW7CWfQ+A6AOl7qX1AE1lme6ovmKIgy?=
 =?us-ascii?Q?XnlWYU/uEBLURKOeN3/vxqAjDaxU5NZ5uUjfQyrClQvn54ZiCLxyXxpwyHIL?=
 =?us-ascii?Q?zeL6hLynzsCQaVnHPt5zEb8lpt+PEhqag0+OK50BOjNn7B73KKvinyj2RKzJ?=
 =?us-ascii?Q?+Gp97aPyv467j/wgOdioSuxSGaz1hEf7bkFMfFv2XsAiwfivzjNDxqxPIDru?=
 =?us-ascii?Q?NYkwmIt+WnA2eP7NgHiVE/N5NjTesq6L47Q3kjQqh+7yO6sP2pAz1rV2Js4I?=
 =?us-ascii?Q?DPeGsUUPgsAC7W65FVJRGWPUhWQR45WSeBc0FiFhczECoN8Te/l4+64HOf5q?=
 =?us-ascii?Q?VOgNt1JCO6wR30nmST/TIglfkpNDpMFzcTn2QeI8O+Kwvn5tN4+JaCgcD0/L?=
 =?us-ascii?Q?h7CfV5TQ6F+34gcYOuvT2xbt8q/uaCMODNNanKYxpJMVvjM7KQ8lkxhHs6zU?=
 =?us-ascii?Q?ciMi7+68ZlryNsIuUxrdcG8QVFKdIE+M/Kc+HV48/sjXQMRFk2BVPEEJPQIN?=
 =?us-ascii?Q?IqhHr7xUtuD5tMjH4lqr/IFy2GAebtxjuuixe3PIsHhEhkDfomtDrJAppgJ7?=
 =?us-ascii?Q?m6fzRYHAEBq/vL2vCtI+P6mBNoNz2pvk1CRp6R2tnk6oHEFbw9MV1rya8kK5?=
 =?us-ascii?Q?fbChMgFKDE0yTQLWS2mmsgLilETnJeT+FpdcIi+5whsnmFRVRH4zTt6bOGLt?=
 =?us-ascii?Q?B7c4S3BYmqE7Kk8X8V0m91W5+2dx5EyNneCo42OWqaMrhG3a290NAfajO4n8?=
 =?us-ascii?Q?Mq137nWj/SKheSesJuROeaCJZwWeODLrMsvXfUYdOzcDVtzvAwaamXhcDBjy?=
 =?us-ascii?Q?UdZLd+ki9YljqUx6DbswCAMMw4ar7llX6iDsDmbY7ILltfSeyRZSHZiRHwsU?=
 =?us-ascii?Q?Mmhz3KkR03V+JxmdTZLpPs1pEWZumCgeROr+I90sF3UPw38W7pPySXYhWudL?=
 =?us-ascii?Q?GSJlRXhMN8cAHT8u/mOMhAwdRXd9+evuNYNRnkRKGzTTBRYg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db15dae-e174-403a-8bfc-08df3423c5e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 12:13:55.7849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XoY/1HSnJdyb0tkUq3uNFAzcqYZVPzQCp+2G4LW1TgmxdXxfAKM20I2PfBr/Bywn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB790180
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

The series is:
Acked-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of David
> Rosca
> Sent: Friday, October 9, 2026 11:03 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Rosca, David <David.Rosca@amd.com>
> Subject: [PATCH 1/4] drm/amdgpu: Use feedback buffer for VCE destroy mess=
age
>
> VCE 1 and 2 always output feedback, same as for create message we must
> provide a valid buffer.
>
> Signed-off-by: David Rosca <david.rosca@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 1f7a98cdce5a..39d87f3df9e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -558,7 +558,9 @@ static int amdgpu_vce_get_destroy_msg(struct
> amdgpu_ring *ring, uint32_t handle,
>       const unsigned int ib_size_dw =3D 1024;
>       struct amdgpu_job *job;
>       struct amdgpu_ib *ib;
> +     struct amdgpu_ib ib_msg;
>       struct dma_fence *f =3D NULL;
> +     uint64_t addr;
>       int i, r;
>
>       r =3D amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,=
 @@
> -571,7 +573,17 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_rin=
g
> *ring, uint32_t handle,
>       if (r)
>               return r;
>
> +     memset(&ib_msg, 0, sizeof(ib_msg));
> +     /* only one gpu page is needed, alloc +1 page to make addr aligned.=
 */
> +     r =3D amdgpu_ib_get(ring->adev, NULL, AMDGPU_GPU_PAGE_SIZE * 2,
> +                       direct ? AMDGPU_IB_POOL_DIRECT :
> AMDGPU_IB_POOL_DELAYED,
> +                       &ib_msg);
> +     if (r)
> +             goto err;
> +
>       ib =3D &job->ibs[0];
> +     /* let addr point to page boundary */
> +     addr =3D AMDGPU_GPU_PAGE_ALIGN(ib_msg.gpu_addr);
>
>       /* stitch together an VCE destroy msg */
>       ib->length_dw =3D 0;
> @@ -585,9 +597,15 @@ static int amdgpu_vce_get_destroy_msg(struct
> amdgpu_ring *ring, uint32_t handle,
>       ib->ptr[ib->length_dw++] =3D 0x00000001; /* destroy session */
>       ib->ptr[ib->length_dw++] =3D 0x00000000;
>       ib->ptr[ib->length_dw++] =3D 0x00000000;
> -     ib->ptr[ib->length_dw++] =3D 0xffffffff; /* feedback is not needed,=
 set to
> 0xffffffff and firmware will not output feedback */
> +     ib->ptr[ib->length_dw++] =3D 0xffffffff;
>       ib->ptr[ib->length_dw++] =3D 0x00000000;
>
> +     ib->ptr[ib->length_dw++] =3D 0x00000014; /* len */
> +     ib->ptr[ib->length_dw++] =3D 0x05000005; /* feedback buffer */
> +     ib->ptr[ib->length_dw++] =3D upper_32_bits(addr);
> +     ib->ptr[ib->length_dw++] =3D addr;
> +     ib->ptr[ib->length_dw++] =3D 0x00000001;
> +
>       ib->ptr[ib->length_dw++] =3D 0x00000008; /* len */
>       ib->ptr[ib->length_dw++] =3D 0x02000001; /* destroy cmd */
>
> @@ -598,6 +616,7 @@ static int amdgpu_vce_get_destroy_msg(struct
> amdgpu_ring *ring, uint32_t handle,
>               r =3D amdgpu_job_submit_direct(job, ring, &f);
>       else
>               f =3D amdgpu_job_submit(job);
> +     amdgpu_ib_free(&ib_msg, f);
>       if (r)
>               goto err;
>
> --
> 2.43.0

