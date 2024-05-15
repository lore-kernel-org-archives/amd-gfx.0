Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B38C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 13:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3711510E933;
	Wed, 15 May 2024 13:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p790lzBv";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771D210E933
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 13:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsFJEvX7gNtjRHAX8tmsWkGMul68/dhydWaf7IMJxykAY8m59vxs+Mi1Aq9dOeWpBZ6JIYT/WKlXa18lkmCTluJRlAG7tnON1maOllQZNoc8wn7vMjs2HdBBSpVT5JuJX6RKWzEXOK9cHAO2ow3W+p+X75sDJ1Iy4HGa6YFDea4VODjAuUzopbbFFPLyEhdvpGB8i2q9K6cirvnES4ukxbnfZo41yyib1MbYg/i2Fxs7edL1xmsTeD6omcd0pNP0ft1VT6WGgQw0+lTVV/GT6Wi24zMpPUMbt0VvI57KDGnUAjLK2OnC0NnyMLcZUz1ZufjIlKHiPZ3AgTSNzPhV5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXkbiiCjAmS3RSFaIvPmqaCTe5eqHvwjslN7TMA0hfA=;
 b=K1wZRELHFMx1nLIanTuohwYYF45dQfly6psql6+cYiJyPd9N/ezDJ8yL+l2/DVNVE85KJi19z/mGsy0wpbc881Ta6GI8EApqzCNoHrz5trX/HjgxVADRnjQVHFvc8LfqeQtJmIt49OhzopEApss235nNpSA6ommc7ChCZtGnu5F85rmq4V6xHU0mV3xqb0r3mCZ4O51uhUN19ySTjistVcZWxeMkxtz3DX+6Tc+pic1d7c8QsWgMjER9E+nIkHCBxmYdlyY+Kk8nAfuaRuHhTKS4vZODPENQ4r3bz6Z9SqRjYS3O/5zSn4Llegdt75xmWJnsWTFxeTl1Su0Lnet6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXkbiiCjAmS3RSFaIvPmqaCTe5eqHvwjslN7TMA0hfA=;
 b=p790lzBvN04HV5CD52/wGJJdmsfA6LACcX1nXeb79UrdIJTAkZH7MMJ4e4zXuZun8Dd5nIxarw4a4dlojvCP+tHmGIioc1HHwD5napMAcV5KEtEZuo+0IChgZX70PlEQfml6kpAmtlfI2Lnht1dozqIngQrbgawxG7/P72t4y4I=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.51; Wed, 15 May
 2024 13:04:10 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%7]) with mapi id 15.20.7587.028; Wed, 15 May 2024
 13:04:10 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: RE: [PATCH v3] drm/amdkfd: Remove bo NULL check in
 gmc_v12_0_get_vm_pte() function
Thread-Topic: [PATCH v3] drm/amdkfd: Remove bo NULL check in
 gmc_v12_0_get_vm_pte() function
Thread-Index: AQHapl9dX9IT70jSdESMw8/eLBKKRbGYQ/eg
Date: Wed, 15 May 2024 13:04:10 +0000
Message-ID: <BL1PR12MB58981E1096CC91AE03A40CD785EC2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240515003103.634408-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20240515003103.634408-1-sreekant.somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=42d844c2-6a69-459d-855e-2f02e8f41d2c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-15T13:04:01Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS0PR12MB8504:EE_
x-ms-office365-filtering-correlation-id: 7147d550-016f-49c3-b53f-08dc74df833c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ap0sfPhWtxyegLxlDxZS4LCf01ail/3XTGAo0JPT3ICl4wekh44Anrx3Fofj?=
 =?us-ascii?Q?hXPRAFmRLqjv5ht5YVwEw2L0V3e4BnHYTxeikM6b0mYQJ00h8y9FhUDWfeFE?=
 =?us-ascii?Q?QoeMPlHTPmSoUwl9NEhgSuC5yDzFKcMJRvinIez4hP/1YCIMGOA4fuFRktNT?=
 =?us-ascii?Q?s2qqqwL2Xxv8+1SRByKEB7yMnovGbedf+vSZI7eYIO+loX9hm2pgIFSV/jwo?=
 =?us-ascii?Q?bxs/m+45l0T2uzUnA5B5/l83FMtWD7eldZXIKXk3ARlt+At/GWBrQ+LIG1K7?=
 =?us-ascii?Q?4uGO7UmXePbdrQ+abHnpIw2mcbCvxX5QkL1ExZpb2URv/gkF9ls2dOnrw/io?=
 =?us-ascii?Q?cJwrrNJyqWKB7OBAriRnUDYEVe8pTmLsDkUwRRbwroyTq391fhNPhcLIdBaz?=
 =?us-ascii?Q?NdK7kFixFMSjRAliqElmj17Z8u0MBpJCJ+CH/e44U+nx+ohN3HoRoFxxZ/fE?=
 =?us-ascii?Q?H2Rov6YmI5mkdDhAhKJKJCNqeSvRJOgkFkmycFUSJeHUJZC4+SbvcJNHEPl0?=
 =?us-ascii?Q?HOqCqmPtSdNz4hWvXj4YklyEtDBNT8LfAorFMHGOTyuWlThrdFDkieA4Ikwm?=
 =?us-ascii?Q?FNPxMkFMayKEYzwQ9zRnEhtzx+x8UhCuHGUWlyfvUIKhNPDpzccllxmHU6NN?=
 =?us-ascii?Q?QzUx1UJpz4IBlnxtI9eMJ2C0CTJl7WvfhBeo9a4J6bRLjUcPiPXq4mUct9+e?=
 =?us-ascii?Q?y6oZkuuGqZIv7zDbszhb19VyJY3fBcjwGFYjm8Nc8NHTl6aUUrgRvWcJiF6x?=
 =?us-ascii?Q?IcBoUNtlzoFR/OJUpZ0J0Lk2bccv4HExZEhPKyMyIrbjiToh+CEFt/iEKySQ?=
 =?us-ascii?Q?jZJ4jQ6gmLQw3vLIGd8/IS9P6hTAlHnObsik/2v7llbVexcNY2prLNOn8ffy?=
 =?us-ascii?Q?jmNMaSouiMpj7kp7QU8pWsGlKUkj5fdgDqldROCBWAIDCLQolQXE0lvOmQad?=
 =?us-ascii?Q?pc9DfPMRoE+AE9jQJU9GnijLpeE/76FQ1iPkFqnU265F4Nu6P9z3sCJHoRXR?=
 =?us-ascii?Q?3MOMHrzHTLQXiHE5PgDdXUsyqsDEIn3O3RJ8mjfVGqfStC70OW2d2huRdIVW?=
 =?us-ascii?Q?C6U+NNydYOiLyp2Mu3PO+nwsWRWz7etvd2jEqcksrFblcjMFITFR/LbNL6YR?=
 =?us-ascii?Q?/4HGfdCtsYzxLS1KLirqL5ymmPQdReUsKT0J9cDcvx/IP7dfDjhVnPAgJI3m?=
 =?us-ascii?Q?6It6GjcRRztzl9rY5D9GBpE6jIDGVwnQNIdOL1EVtA+KNMhQA30uzs7wmc9D?=
 =?us-ascii?Q?9SVXu5t/PUjF6n5yT35emUj8hllgO+nU2QAso+dBD2/BQ7WWlJCoZ0QHbxuf?=
 =?us-ascii?Q?pQylCrHzrGtH6Gaw9Ni9AjPrgc+jgiSSpMpsUOr+2+oWKg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kLr6pD9sHDoFM/55QkP0AB4X9LhUtARGjkmexsqcp3C0Rh92H6Y6yFuxrwP1?=
 =?us-ascii?Q?8mVtxJZaF8bEyYtUnfL9C+f12v5AUuuCTm9hlER6Ab2lFJRaOj+AIieEpThe?=
 =?us-ascii?Q?acs0jPdP3pe0wR0mMv1nAQsFpnMdghSSqth4TjR5qaZRLb1u0K9E8zGnS09q?=
 =?us-ascii?Q?J/4luXd7vLYsQ7cXZ2IQsxRJQCjzeDI2YPjVAvhB0FSpaBK5NtXu2FFJnGzs?=
 =?us-ascii?Q?d7RDkbX/Y3j0YSYPWHvtWRhZiAW76ap1QXuhHSUc3Qxaiy190DxmG45jmse+?=
 =?us-ascii?Q?w1BDRVLClbbLmMtb4pQdhyqxnxxwvOMdSYej1hx3Qv+NoMjwkM1+OW7KzeXM?=
 =?us-ascii?Q?s+FMhGCrxdrOOZTuh9Y2lKy1r5L8o14cquqG/QeVkufqskI+tU4NR+LmXWoJ?=
 =?us-ascii?Q?YfzCheO2APOG2+MNGL1R+mojmS1Vz6IQxgTPG9wrLG1Ias1+AwMj+aY03Ar/?=
 =?us-ascii?Q?enZDSZ+1rHQ548F+182J+8+JnlMlbbI/r/rKHiSF8KqGSUmU6+cOv5/ltJOE?=
 =?us-ascii?Q?JnVE4M7NqUU3YvbDyQO5gcFEhR1XZDNfnbcbJSVMq5J7xVoH4jh93/IAgHpa?=
 =?us-ascii?Q?xaZ+SNN0rqnQbzl/S/1mISEVAFDOjnEPrkbFwnzc9mDFJVsZWtUjFy7mjWLK?=
 =?us-ascii?Q?xjIuq5vzGj3nJ/bkvtRj5Jc7DFDT6Pzm0ibTD4/cIvuaQjHSatp3Jhnas3K8?=
 =?us-ascii?Q?0gH3Wc9jYZ3HqWW0xW1/5qcTIehgD8+uvg1LZAPFuKZU/gEO33QlunaTIV6t?=
 =?us-ascii?Q?hLovUsBjnxjmaBNmXF27KUx3744QL7pgpvb56EfqFBarh5zKNDyruJOVFCq+?=
 =?us-ascii?Q?19pJQSafYrfDK15Bt65bYYGjFeOfP3Nc8IPHDphgeaW+stslmbFvKul3smmU?=
 =?us-ascii?Q?JZRhdb66C7di1EDLIIq/D/qbsjdIUn9saG4noEunrSe2+YPT/2u3CHWM7mkC?=
 =?us-ascii?Q?0p+SlqpTPs+sWJYn+0jkHnQB59XwYUaJx9WgK9gwrnHqOV6HAF4Dw7VZGVgt?=
 =?us-ascii?Q?PXbjma9kl05zihvS7M2F+3udWqEepFne2ShSSwODziQKj6xkbGet3b1HGlAN?=
 =?us-ascii?Q?6KBwbbxmxvPPQW1Ulvhn1j5hL7OqTcll8mgVVdCsqvbb0UGI/ST7YSyq/Ol7?=
 =?us-ascii?Q?q1S1tiv5pZAknOPRJbiCJ2h8teyw2zyBTXSMqHgn3DmCafmzgEDeIfh3PzPu?=
 =?us-ascii?Q?a8v75Snb9W5NaGuScprPOV9uXGN8USSd++pNOG7rE7zUIr3Fv+i3QzcVy3/7?=
 =?us-ascii?Q?a7yEDFgRfTM5x0u7b5GBhq2yvEQpJR+5pxW9/5/OMRRM2MV56d2WcQWmpevC?=
 =?us-ascii?Q?nMDHrtv1e7oGnAA6Ukw66pyGRdnFHdJuVlS9K+2bjSNtF3+Hlt2EUN03ELJk?=
 =?us-ascii?Q?z2DJpi9m/nmo7SfTBAmjZ5LZxcNjZG9BwjNVEFKv7fp0U2aiRl+kWoWZxvTL?=
 =?us-ascii?Q?+SKss0gd0EutNiRZJL8I1bI9U+1hwj1QyLBL6vrb174WlYLIAqTxdIKNw00s?=
 =?us-ascii?Q?ZPHnqzmsRZD9GGw9og4/OdKZtAR3fPMKyn41LLKEmILmj0vc+OFtGFqGS/oq?=
 =?us-ascii?Q?IptpsRQ8XOWmVKX6Ti0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7147d550-016f-49c3-b53f-08dc74df833c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 13:04:10.7567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qXaBcw3KIAuAd381D07O2aOkj+FrjeSIwxphJmqhCd+ESso5Iyjz2/cxB9sJwYyO4QxiLeEWRfqZwMcdJggSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sreeka=
nt
> Somasekharan
> Sent: Tuesday, May 14, 2024 8:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Somasekharan, Sreekant
> <Sreekant.Somasekharan@amd.com>; Dan Carpenter
> <dan.carpenter@linaro.org>
> Subject: [PATCH v3] drm/amdkfd: Remove bo NULL check in
> gmc_v12_0_get_vm_pte() function
>
> Remove bo NULL check in amdgpu/gmc_v12_0.c:gmc_v12_0_get_vm_pte()
> function
> to fix smatch warning:
>
> 'drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c:518 gmc_v12_0_get_vm_pte()
> warn: variable dereferenced before check 'bo' (see line 500)'
>
> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 2b7b67916c1d..0fadebec9019 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -515,13 +515,13 @@ static void gmc_v12_0_get_vm_pte(struct
> amdgpu_device *adev,
>               *flags &=3D ~AMDGPU_PTE_VALID;
>       }
>
> -     if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> +     if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
>                              AMDGPU_GEM_CREATE_UNCACHED))
>               *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
>                        AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
>
>       /* WA for HW bug */
> -     if ((bo && is_system) || ((bo_adev !=3D adev) && coherent))
> +     if (is_system || ((bo_adev !=3D adev) && coherent))
>               *flags |=3D AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
>
>  }
> --
> 2.34.1

