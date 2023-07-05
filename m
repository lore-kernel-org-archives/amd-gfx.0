Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14502EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 07:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A3710E330;
	Wed,  5 Jul 2023 07:11:24 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F049410E330
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 07:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPYiyivKwFGSkFHwJ69VMsNW3sTtI9khitRVv52iLqQwQW7uUYS96x00bNudZoS++NKSSCBdF2LBY8347QgpyS6a6AAPr5Naw3JOwuPyC/PsFvRFwJ8uakgTQOf7i9CzofHklDVNExGaA56f7yJRZMn7Z/FbrMExj998IHDkytwM3arX/e4Dc9NafNtBYv8jlmoM49CwJi6NDk+SMk4t69h+P0W1lJTq1jwxbmQJoXCzvHauIdn0npgXmFZsw/4lSITduD3NzKOCCHdpuJhpeIvPkLXbl7BNUWAKTQRRT1PXUvCPJwZ8hj5A+SnB5HN77rq3cmd0plce0hnZRExfsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWiYSixJ9HiW4jialIiaKiTih+YUsINLV1XYn9quvVg=;
 b=KEcXm/3Ko8YQ1klULrCUoSPmxKIGLAf5FI1nxa0ZDIliuasp2xz3YBFtUEa03aCI6n/8oE3LLg2tVb552SQIjNi14Z2ttyvcrKYKmarffhER91MK4H+WkDyNE5C5kRro4kbMbyZFx63zDR5zzHz+b6eIaADNqdCyQ9hQwpquVAW71h/AJsjRKz/NUkHTgOTJByuTGtZGwRNzSObW43CAHxb6r4Ymt6lG78I+4CU5Py91o4h0f3QpK9eYVWzLtCTKxoJ0cr8oG0olos3f/CJ9rWF2G0OkFrLMOjlzXVqgvVaVelHiETlECqKDCivacihfhTbpfaBBBouSzf1m1beSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWiYSixJ9HiW4jialIiaKiTih+YUsINLV1XYn9quvVg=;
 b=Mpcxace5gQIqdwJVCCZ870mhST639ifdxgEe3ybYUtYhnOd0k8c0A9OH7Pj6JMsLEHejRmCnMS2tosk3enGQFzM3yhFNEKC3yWG6zjRgwiXs3WbkcKqOuJB7octgZljFepZBiP/KMqBsa8SqCgqnL8rppy7+rjomHULGQ0C3oh0=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 5 Jul
 2023 07:11:19 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::38f2:d04e:61b8:5720]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::38f2:d04e:61b8:5720%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 07:11:19 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Ma, Le" <Le.Ma@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove redundant GFX v9.4.3 sequence
Thread-Topic: [PATCH] drm/amdgpu: Remove redundant GFX v9.4.3 sequence
Thread-Index: AQHZrwHm/ynfIn5b7029RgUd8iavFK+qtAKAgAANowA=
Date: Wed, 5 Jul 2023 07:11:19 +0000
Message-ID: <DS7PR12MB6071C6CB38A7FE6DA2F786F08E2FA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20230705053038.2739012-1-lijo.lazar@amd.com>
 <PH0PR12MB54044D7F2C19252B2FED08D0F62FA@PH0PR12MB5404.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB54044D7F2C19252B2FED08D0F62FA@PH0PR12MB5404.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=44eaf868-1e38-4cee-a413-20a7b01b48f4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-05T06:21:40Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BL1PR12MB5826:EE_
x-ms-office365-filtering-correlation-id: c8bdc483-88a1-433d-16c7-08db7d270832
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95AtUMY9ziy5T/pnRq1Bcxv26qxfHc6uHHz3/ag6esUnXAtZH+w3mpf7LHmPRp0lsR2CNWWMFShwo2HW6rgJMMC77trNAm6ghpRTtLxSSuei7V0m3JbLX2GWQnVZf6BK3B1n+xE7lnmY9RWNlNml79uFGZl01O+/7N45JZhGA7hhCV4KIOAwqfWAmK9u/3JCqensFKFPZVD7QOKm/X2t0GgtgHK4gdcm/WNIHXKfC5EN8NR36dPYIgoHILCnwklR4xhJPtFvOwH+QYvyGCmiejI8uAwEgh6IHm834HWUrQ+b9lpIEqGK6x0Cwh1Waj/Ka9r0gchx8UKuJBFiHYH4ykBO1XFQ74k4DkCeZ52c2L0h2UecGNh9cAmtMxbnabPIyt14hx3bEfLxRufERsiyuMRwtrPC8jet6xG5CnhqDNoX5WwLr6F9BMjVpVktN+j56UwBOeog9JL9BMaDJuAfneJrTra1GuM+Yxh2nMPMKbmLOvXNb4ks5vUNdHhokGnuQCoBvrMDkihTsYPGSwp36KdH8kTlXTS/orHZ3op0zPiTEA/tLto7nu17h6TEe/tpRqOAbUqnPm2zIm7JuTb60rrLnSHPrm9dmMnIAf26IMInM8fMxJKIXvHll39qBHts
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(2906002)(8676002)(86362001)(8936002)(52536014)(26005)(66556008)(316002)(66476007)(4326008)(76116006)(66446008)(64756008)(38070700005)(66946007)(478600001)(5660300002)(41300700001)(54906003)(110136005)(7696005)(38100700002)(33656002)(71200400001)(83380400001)(186003)(122000001)(53546011)(55016003)(9686003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ex5uUFvEiZM5sf7kGKtPiYonCHUJmIU8KZKycaMInPeEUiHPRaEbYDoJdx0y?=
 =?us-ascii?Q?FIGaHHN9qr+1YDtnUBaPtQhVUkdvC1X6YMzJBugnQ/a+qpJ5WKk6QVnmNXHs?=
 =?us-ascii?Q?ORKYrqPFM7GUm1csHsI7yvPX18ltNNxkWQZkQVGkKssvK8XHvOpZ+1zLJksW?=
 =?us-ascii?Q?oKXWTNuV5WvfVdkFPDLD/X1AJMQ13JVlKxX19wQBRV4vNm3nRkgLJXdo1Hu9?=
 =?us-ascii?Q?DsNWQA5xd+1lvojwBIaoASXglg3YdW22y5IfIB8OKg78WV2apHDE4mR2CO3d?=
 =?us-ascii?Q?Py0QE26ebUvfb026542UGaAjn3GGvFUXnPVfZqrJ5d5qT9PxvIFCsHiI9Jrj?=
 =?us-ascii?Q?zTLTS2t/w4XCXwxLWnABe5sgTuX7BPMr697YCZxcxM5yxeYpoSLAR6VADq6e?=
 =?us-ascii?Q?nT5ZvXH6zjwMmkSZAo7/lRvCSV7Z/Kle+H9DdmVxIk3avmW4/ApCuho2xG6V?=
 =?us-ascii?Q?fF4PHxQbysrdfUQ39a5Wo931kzzoF/F4KGX3uMpm6Y3IxtxqKxI9RAWeo4/O?=
 =?us-ascii?Q?j7MASzeDuFfgJ8n8GyRxz+Jn3Fju3sbpIdAXSeLqEi5RwcXwxaRmQYnrRRCJ?=
 =?us-ascii?Q?wq/Qp4U89hlpdegLkl7cwMFzdLOApZavIfQGo3IyEMEvKGcm19k/9vpiKL5r?=
 =?us-ascii?Q?jXIDFubazKlpbj7RJLrtply2UOW9QSHbbIFvco3rW6uY5O0XoyyM+ZPlsH6D?=
 =?us-ascii?Q?Q//1dOoZbVdDD8MSiDAy+pGtw0C8QaznXb9AIxkG8fGgWbSAhjd3X8avNI04?=
 =?us-ascii?Q?UlW0Snid9u9A61iqyiyqrw+bigKF2cPhBh2m+HACtk9u0nFKThGko1Nkx1tj?=
 =?us-ascii?Q?B0ZYtGIKw75wT51WCc57QziG/hf1DkPxfCqkMytJYqrrMrt2mXc/0lwWMEzy?=
 =?us-ascii?Q?oF1j/eCR+zWwDpO2DDCWgnlXa99DPQ6cmV8zPNjRQu6nsR5tje0jM61UGUKf?=
 =?us-ascii?Q?LvNxPISdHfMmjBP+L0a6JkdsRU/Hpd6QgjtL/8REwRb55pIaQG7cUQemxWaE?=
 =?us-ascii?Q?2a1y+i9Zw4OWPIwC2HQ2v32p/jSnoMBNJ4L6Zz1oyL8GPU3sXFD4fn5PqzhE?=
 =?us-ascii?Q?oz2x1BrF19FHjcH8PUOAhgTGzcnPulVQLEqd1sTv5Oa5kGievJWyclvsYzV8?=
 =?us-ascii?Q?wExO8oqGYZp+liMglOSkSfwEZRkaldjUdEiN8Ze7PmkPaLU4DRd2FsRFcPyR?=
 =?us-ascii?Q?yMJ7OM4tYBwjiNS7yifIlANkOcb117L5YF/npLHS6Ozsw8KRRXZVQEcVGwBV?=
 =?us-ascii?Q?QWi6JusbmXcOAJsp6Cqp6aDhqU+oNSBSTR1yQvgSX8Xd9ImoKXH2VWyIse/5?=
 =?us-ascii?Q?guM/AlyOak9ZsJ2FAI5zIUr+Rzcy9aEbYkJj+YTk/DV8cX+LTIYhu4e7JV1Q?=
 =?us-ascii?Q?RWj9uahmypqSFJERS0KjMVG+Q181+wlmlkE91cNUCaji2MwwQZ3UQOb1AYz2?=
 =?us-ascii?Q?lpEAw3AEMIAHlb9cL796Bby5UUNEFQuQJ6+XeBxr6oeJeEvr11Wd7HdAVIqR?=
 =?us-ascii?Q?9Ynp7Im17DDhoaeVyopPnk6rB9xrf6aY71pY2uJwq5WsL4LJ/zuhe53Eo20v?=
 =?us-ascii?Q?ixAGfqpTcQYfcIDl6lo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bdc483-88a1-433d-16c7-08db7d270832
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 07:11:19.7671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjiHPumEtKy/duXQR5Cu8dClryHLTFd2ERATQkwYucdOGyfU5KGgEutz7QfRU2u/WJslraWOJ8+SrfhhqVx36Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gadre,
 Mangesh" <Mangesh.Gadre@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

-----Original Message-----
From: Ma, Le <Le.Ma@amd.com>
Sent: Wednesday, July 5, 2023 11:52 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Gadre, Mangesh <Mangesh.=
Gadre@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove redundant GFX v9.4.3 sequence

[AMD Official Use Only - General]

Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, July 5, 2023 1:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le
> <Le.Ma@amd.com>; Gadre, Mangesh <Mangesh.Gadre@amd.com>
> Subject: [PATCH] drm/amdgpu: Remove redundant GFX v9.4.3 sequence
>
> Programming of XCC id is already taken care with partition mode change.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 29
> -------------------------
>  1 file changed, 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 51532d0dd7a7..548b1123f7c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1034,32 +1034,6 @@ static void
> gfx_v9_4_3_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_
>       WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCPC_PSP_DEBUG, data);
> }
>
> -static void gfx_v9_4_3_xcc_program_xcc_id(struct amdgpu_device *adev,
> -                                       int xcc_id)
> -{
> -     uint32_t tmp =3D 0;
> -     int num_xcc;
> -
> -     num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> -     switch (num_xcc) {
> -     /* directly config VIRTUAL_XCC_ID to 0 for 1-XCC */
> -     case 1:
> -             WREG32_SOC15(GC, GET_INST(GC, xcc_id),
> regCP_HYP_XCP_CTL, 0x8);
> -             break;
> -     case 2:
> -     case 4:
> -     case 6:
> -     case 8:
> -             tmp =3D (xcc_id % adev->gfx.num_xcc_per_xcp) <<
> REG_FIELD_SHIFT(CP_HYP_XCP_CTL, VIRTUAL_XCC_ID);
> -             tmp =3D tmp | (adev->gfx.num_xcc_per_xcp <<
> REG_FIELD_SHIFT(CP_HYP_XCP_CTL, NUM_XCC_IN_XCP));
> -             WREG32_SOC15(GC, GET_INST(GC, xcc_id),
> regCP_HYP_XCP_CTL, tmp);
> -
> -             break;
> -     default:
> -             break;
> -     }
> -}
> -
>  static bool gfx_v9_4_3_is_rlc_enabled(struct amdgpu_device *adev)  {
>       uint32_t rlc_setting;
> @@ -1917,9 +1891,6 @@ static int gfx_v9_4_3_xcc_cp_resume(struct
> amdgpu_device *adev, int xcc_id)
>                       return r;
>       }
>
> -     /* set the virtual and physical id based on partition_mode */
> -     gfx_v9_4_3_xcc_program_xcc_id(adev, xcc_id);
> -
>       r =3D gfx_v9_4_3_xcc_kiq_resume(adev, xcc_id);
>       if (r)
>               return r;
> --
> 2.25.1


