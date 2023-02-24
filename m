Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA63C61DA3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Feb 2023 05:58:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DEDB10E02C;
	Fri, 24 Feb 2023 05:58:44 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B62DB10E02C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Feb 2023 05:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1pmy3UJWdBk0mg3JSkRdBmuGZIAnX14zQPLVouI2ItrYKLka2qPf9CEGlI0qqoSxL1iNFvMrLTBZjQvPhp5XZKFK25IHOv3IYzbB1NglKVBzpJ8Ozn5yGPLXRfNfWGGinM9ls2eiyd11bqPlVVxapDp3DmTsGERYzb3aXikWsZ41/VPbnb0W4kDqBJ3BMUqL2aqqQeYWfQecaSd+2jao0Xk+CyoXz3h/K9dODCoTsWlu92yRqu7xVJ0SGy5hMpw7Cd2IsQg2wMh/aztgZKVcAVQ9zqTtkjqQdU8hoQGulOO57YRaUaGp5SzU0msPGsTtgIbhvRA4hs+am4Iw4349A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMcuKvlFaKVwC5vw90dnrkAup7QwKd7JZieNJYeZMjI=;
 b=UmiNmBsIHiArtpwlPLou4656bcDLYtokc+Jp3yLc8zXatytLBw+wunPOfnjWw0mzWlc3aWh2bIlovt0TuROacflflwFt/+Qdvf+gUmubmO47KZbaOhnSuI3w4d4MAwK0rLM0GhizajMv9LMia1S4DcsF4h50aNAqVJnAZ9CK6OstncFgnL57Pic9tX8BKlseVgtCqScxB4VG2x3AeOnm6Jjo8rr59KwzEBxBVtGyDkOyKWkfrZ1RRdZ108Q1VjkATLT9DbgOH5+hXBOrfadTlwd06NRLsTH3JeU10px7+oZX1fq2i8MdflIysgeaIV0quYSbFl4dW6dnmwdF/bJTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMcuKvlFaKVwC5vw90dnrkAup7QwKd7JZieNJYeZMjI=;
 b=fiDYMiWoDrvlkh67gF527xo5htHT9N6MRh24e3GHUhKJ1pkRyerc38uQSROT6Fe+qJwKIieO6Kfpib0mK8LJeNwmh5VsEWJ7DciAKmZ+d+QaEij2Zf2j1n3UQHTmhfz85VgWXuRLlp3aMuxDPeXimu2vOXzqN0VNKZZ5ZaA7Kzw=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 05:58:38 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::e52b:f6b6:5b71:cd92%9]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 05:58:38 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Make umc_v8_10_convert_error_address static
 and remove unused variable
Thread-Topic: [PATCH] drm/amdgpu: Make umc_v8_10_convert_error_address static
 and remove unused variable
Thread-Index: AQHZSAgNKosUVbXQA0OQAZuYok/9Qq7dmfNg
Date: Fri, 24 Feb 2023 05:58:37 +0000
Message-ID: <DM5PR12MB1770BD1FC6ECF9BC0B46068AB0A89@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230224042507.30533-1-candice.li@amd.com>
In-Reply-To: <20230224042507.30533-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|IA1PR12MB8556:EE_
x-ms-office365-filtering-correlation-id: 4cb2f737-9deb-42d5-f6d1-08db162c2c49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2txuAvmQVDAMzz8MDEqCO528/b4nAUoyXIIKMWkr5oCaDqsM8JY/drvpw7Af8n2JNWD0pZ1CA5RmuemEEW1r4dKwWY+UmNxByp8RCyV9SHBgYZODjeaPltY+qROcV3Fhf1NGyX2a0I/z93M+IGJeZnp/CEyZsgKGAHFi5EBV3nlWHCriFjvqzxZxnxj0dC0rO7jR0LJfgFDyojxRFgI87p8TX9bX8yhkyz6oa5cgzj+93J292RMkq/siw9wIkdT2ch9lAzmV4M7xZDWnfh+mADcdo3f6JSTlkDZx6cjhsLJ2Z8A48iKboQw4UzCGt+m/LdQepeksaO4igLS072eQOAf9IHNSqpp8VI4ZU/NJ5kKhFCK8lkAy3blRcbkiA+D5b5K1ix75JmY7hJtU1WF88+aDlKZak7gUZ7VOPlKAT9fDrIFDQUcuq+IKkwxqrJVJjgJOMmcuhYHIykJgXQbnCOLL9EaVKDMXGlsaBZK8Ut2EhmeGKwNYBOh85tCjHFnCMne5o23h1EyNwS7pl4pFqAk2F5hAf3xRodlM4KvhQGMwcepKFlFREQGN8RW4BBSOq62U0GchpURbljyAN0RRDVeCsoCNzPGF6V2wpc3r2Q0mGfoiYf49T3AvXURLtzyZdf6oiRVgbAr/dw2CHJyQsMAnEoFXDsVEr7Sv1CniIIQJtw7H/3j+L04ysGT6j/LTnL+RUmOsq2ZJxIMYMuBCGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199018)(26005)(9686003)(186003)(66556008)(38070700005)(71200400001)(122000001)(38100700002)(7696005)(33656002)(76116006)(53546011)(66946007)(64756008)(55016003)(86362001)(66476007)(66446008)(8676002)(4326008)(5660300002)(83380400001)(478600001)(2906002)(41300700001)(6506007)(52536014)(316002)(110136005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gv3Nz3kZFB7F4DhYsC4vdXLasgMwotvcov1C4zVC7Y1UlbmM0mwbd6NCxOxY?=
 =?us-ascii?Q?nO9GH/l7mg5Pb8AUu6m+C8zJcf4s8gn+xE+n+k6k+wWe3uYPFVjJ5dj7jdn5?=
 =?us-ascii?Q?qHEB3vn0Qus52aMp1MUf0Qp3gKFFxyf8UioeORJY/hHy6A6LgTLzOqQV9rQo?=
 =?us-ascii?Q?/TSQF52zSMM7qnMjdxjag4pm7KOY4+j9X5TpH3E1+QVJ6NYDnJqH/izCo6xh?=
 =?us-ascii?Q?IAC2+r0TF7U2x7sG5aR1w9rppkMKG7HeZy+7c6J9Q3ZqZAvM747zoLzI3CYt?=
 =?us-ascii?Q?B52TLyGTVs1GWvFZ/3lSPF3xbAiMx2j3nuKNcQJco0IdsETnPXHMK5PFrH1/?=
 =?us-ascii?Q?jGdLRkhIcUs3eApF+FeS+41LkEF+B4RnzNUQb7mnEdT/BGk7Hckl3L8GKJ6f?=
 =?us-ascii?Q?rprgsY3vqmT1tx8RJWghj8PqeE+9AzVkQBXIUuw3uQDXG3b4WIG8MbuMx4DQ?=
 =?us-ascii?Q?JqoCIXUt8XP3knQlS2tGHKgS8JlDdSS8ZdOd8kn29fOcEm54KxFsiZVbOcg3?=
 =?us-ascii?Q?oomz0wjTtIATj4k5T/yQe/C5+VloBc1uJxDZ5NGjuvGKIwrhRlit2MBbCVPa?=
 =?us-ascii?Q?ZJBOprmxJTcbt2zzPS130fBWIB/hhhBNhTPBY5zDHZO2DCtpKrLEUENd+/Xa?=
 =?us-ascii?Q?Hu7NZb/tSwL9+ZbvnlOozMHlT2ISaG9OOs481M7V0qPPjJa4q6SJJPAxG2iM?=
 =?us-ascii?Q?M8+JJzGDhobuJAQmEUjQArSqKPcHiGT2gsWbpZ1o9GdZoQ9TiP4zXzbYUz4J?=
 =?us-ascii?Q?Fco8G8yG85TO9X0UYEzmsfErDXk0HkOOt6RnT6hsarcc9It10+V/5QVg102S?=
 =?us-ascii?Q?Bi/f9HjKK7lBBUkKDmiYNDJTWg0sPsuQ5l+1I2EiadmuI/B8G7sRxAS9xT2G?=
 =?us-ascii?Q?nCxzN1CDi3G45hTQOUENS8/Sybtbr7oaMWHInuMzzHeC5hix7HE22YE4ptM1?=
 =?us-ascii?Q?D8j7P+VEFKtuNx+v49v63YDVB/wcygGviZQooz+sPawbQgrFWE2cSInrPVvI?=
 =?us-ascii?Q?vI3tT7g6lfMXPBAXqowcaYJYg/wrz2eaEztfOVpzNmCuuHcnn6jBqSzmyrlb?=
 =?us-ascii?Q?5Pqcql0ub/raGe8nqThV40OgZotK5aNlY2fY6cnXBX5RMQhk9tA5ZA4QOiTm?=
 =?us-ascii?Q?FqNWNe08Oo++is6eQulezrxUdzxiA6stpheDM7m9s0Il4vU93SvPx3q/Qgcg?=
 =?us-ascii?Q?EdpRE8KDbJk/B6oTMBPrWDOcakOTrEI6f/s5RvXhmSmVxb0eFBx/kccAKwXA?=
 =?us-ascii?Q?e+EyhxiD7tJC1yq3WeTBEGJwzr9lwtt8gftcPuGBpWNbv+FT76WBGgmvcJRQ?=
 =?us-ascii?Q?7lFYOncZyU8n0czsXjPHar7i7b4NwfW80x3g2gd4nyJUdSAtodNpYPtDAqzU?=
 =?us-ascii?Q?1V7iiyH21xAmCsL8KyqXTq0aE22LdeIWts/KGKZUTCPn5vnxA1vSIxAPF1vU?=
 =?us-ascii?Q?+Nj5dOb2l5JwqMRIedWCiXsE/6f49sLMkKz38Tix+ZAZqldh8Ee+hpchPFFq?=
 =?us-ascii?Q?xspvNm08Iz3WI2Pc0jioYW8S5fti+0JbkGrclDMlccCPKIZgENt73GmwyjHj?=
 =?us-ascii?Q?lrhVqX8W1y6xAP98g1Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb2f737-9deb-42d5-f6d1-08db162c2c49
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 05:58:38.0161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogQ/bDV5de/TupHOwEiJ9As4pN1j3PQkgrmktgHx78jvYe8+W6Zqz5oWcdazGH3U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556
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
Cc: "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e
> Li
> Sent: Friday, February 24, 2023 12:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Make umc_v8_10_convert_error_address static
> and remove unused variable
>=20
> Fixes following warnings:
> warning: no previous prototype for 'umc_v8_10_convert_error_address'
> warning: variable 'channel_index' set but not used
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v8_10.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> index 66158219f791cb..fb55e8cb9967ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_10.c
> @@ -209,10 +209,10 @@ static int umc_v8_10_swizzle_mode_na_to_pa(struct
> amdgpu_device *adev,
>  	return 0;
>  }
>=20
> -void umc_v8_10_convert_error_address(struct amdgpu_device *adev,
> -				    struct ras_err_data *err_data, uint64_t
> err_addr,
> -				    uint32_t ch_inst, uint32_t umc_inst,
> -				    uint32_t node_inst, uint64_t mc_umc_status)
> +static void umc_v8_10_convert_error_address(struct amdgpu_device *adev,
> +					    struct ras_err_data *err_data,
> uint64_t err_addr,
> +					    uint32_t ch_inst, uint32_t umc_inst,
> +					    uint32_t node_inst, uint64_t
> mc_umc_status)
>  {
>  	uint64_t na_err_addr_base;
>  	uint64_t na_err_addr, retired_page_addr; @@ -434,7 +434,7 @@ static
> void umc_v8_10_ecc_info_query_error_address(struct amdgpu_device *adev,
>  					uint32_t umc_inst,
>  					uint32_t node_inst)
>  {
> -	uint32_t eccinfo_table_idx, channel_index;
> +	uint32_t eccinfo_table_idx;
>  	uint64_t mc_umc_status, err_addr;
>=20
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev); @@ -443,11
> +443,6 @@ static void umc_v8_10_ecc_info_query_error_address(struct
> amdgpu_device *adev,
>  				  adev->umc.channel_inst_num +
>  				  umc_inst * adev->umc.channel_inst_num +
>  				  ch_inst;
> -	channel_index =3D
> -		adev->umc.channel_idx_tbl[node_inst * adev-
> >umc.umc_inst_num *
> -						  adev->umc.channel_inst_num
> +
> -						  umc_inst * adev-
> >umc.channel_inst_num +
> -						  ch_inst];
>=20
>  	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>=20
> --
> 2.17.1

