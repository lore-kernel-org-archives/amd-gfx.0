Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62319C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 07:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8371810E897;
	Fri, 13 May 2022 07:48:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6375210E897
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 07:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7jNYLzxVungm6ZlBeEq1JP1+pmlqNhXthcqApRzY6K9WPqeXSUAl+7AMjwS7EFPivKlq0Cdny3TeP9Fij1CQhbOFQk/BkCZXJVTaK0+ItMobEmifUSiyX7qhU3oAGJb5vUqsx6VJ9Zlli77qfvhqyF3YXWqM+he5okHodNJ4PaAmgFU1KuYpkZQCodBJlS15d0h1sgqbP2aHLBT277n1m98POnltddaluVG0yGkT/8+6H1h1PxYLPmXIxAIWwHMYFPugNBKz4AwJ7y491YO+XRT0HHvlJ0hxHbxTcRMRVS3Js/onPi53BZftimljvm10NHhdaQHstsz/pIJ9hdKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPJVQwTbwyH4sqdhrphDMsf7rKHbpO9htHpvx6PWc3c=;
 b=beKnwWsNtPqT+ss99VxSomMKVDIRs900y5SM2YTgtzYsoSo8uWPD8VlPvx6kl/oT0iR2JWdqmFo6HSxo7NEJ/LfUFfOhuoUTMBzPiUA4Z100fXTsKUksK6YYnTKAlJ2MAKTKYRpTT0hDnA6wUhtdRjlOgwr7RQsNroQodIsXjnFXSM++8nRo8Leu/xo9NCBn5O+QEO3sCScz0PnmTgv01ve9sV8rmnknJFzOWfhR4UTflo5hfKIWx8zFtti9kaO02tllTRQvZLL3ipiGBRo54nhYtFqgsW1whNbCe7KZoYCqAxOaocsqXSYp5759SOLs/EmZlOzL0NtlhRiGgyxngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPJVQwTbwyH4sqdhrphDMsf7rKHbpO9htHpvx6PWc3c=;
 b=Xcq/9s5TuDzk7gD+eJpQPBww0HipHo/zZWGs7COZoTrkBf3uWi4mQeokqcVu2u97pmEQUw2u3KlKnbWKclc88xMSXC7UHLavS6XF9g5OOb/RfKEIGcV6zx/lrnofBbSNBh6e0S212fmeOToXVPP3Y5uOyDyV5PsoRyamlJbEupA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 IA1PR12MB6017.namprd12.prod.outlook.com (2603:10b6:208:3d7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.14; Fri, 13 May 2022 07:48:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c429:9d84:9f6e:42bb]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c429:9d84:9f6e:42bb%7]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 07:48:19 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1 4/4] amdgpu/pm: Optimize aldebaran_emit_clk_levels
Thread-Topic: [PATCH v1 4/4] amdgpu/pm: Optimize aldebaran_emit_clk_levels
Thread-Index: AQHYZne8pr+NF2t4VUKwFLVgOK1XVK0cbn9w
Date: Fri, 13 May 2022 07:48:18 +0000
Message-ID: <DM6PR12MB2619A7BA5BBB93586313D0ADE4CA9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220513031506.52099-1-darren.powell@amd.com>
 <20220513031506.52099-4-darren.powell@amd.com>
In-Reply-To: <20220513031506.52099-4-darren.powell@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-13T07:48:16Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=446df3df-4ef9-40f7-90a3-821a4a0d93d0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83ce4fca-c5e6-45d7-2d68-08da34b4f244
x-ms-traffictypediagnostic: IA1PR12MB6017:EE_
x-microsoft-antispam-prvs: <IA1PR12MB601763BB94ABBE886A7D4FEAE4CA9@IA1PR12MB6017.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8SEhaqvXOWHfhNeUlfWRjoq3mjX7UO8b5JwUWf9FBWii1yajFoP2r5peN8zo4Hq6L3Qmb7iPCwB6jDb8K21tPeTJqQxjbHb6eAYEMPqY1w2Lx51oSSM7bix3PR1EiouHK5LvLadXuOYKHjEilZMTiLOBe0YkPASQnJoz8JlIKynF9P/YTnZoB9DuGC5/X6tsdG7LwNVW8OXIbYXJggmBByefdvaicDAjViG4gmmPXdMDNUJeTtBd8V6M0Upqo8Gi9/3jKimRUOqx3Sx6/7nYpPH4iuMqFu4jIjWPqYBtQTa1kcp6oSo6fT1CoweCOZFF1CtQhUW0KHDmkv4wuXP5rmlS53LGeSAcuCydYBMdknLjTUtHDo8OfZEHguRrvzUJ+A+iIVV7tHTKpC7xbuxOnP+BCKYV9ThUlGrz9ERtQ8xrv5nokF0fU+zJEXlzzeeCjioX9w7OJwUsNwXOvKZzNxyCKZ2ragc+yrD8ewhb3Mtcf/mjygxyrfSiEbJ3MSp6u7UJgg8ZATYTjBZzLxGh5LzyxiSfvFVfRktg3rKb49lW3prZIoyI4slRYhCWHhjU2whJ1f0u6bmj+xmcsOlFKHlT6kMaQgnxRt7HdyOQTc9Tn/fiLVVkLFHwzQXWU+uVeyUmqOFHA92NRrmwkCS7zUKqioLLDrctZ96i6cqfYDKxKv5oDyqZJ8aeGzKHF3VUxwFLeCKzDufg6l3igmZ6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(26005)(9686003)(6506007)(53546011)(7696005)(54906003)(110136005)(508600001)(33656002)(71200400001)(8936002)(316002)(86362001)(38070700005)(5660300002)(52536014)(38100700002)(122000001)(30864003)(2906002)(55016003)(83380400001)(66946007)(4326008)(66446008)(76116006)(8676002)(64756008)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OCygb/fEFQ7JBEzXOJpVlEkA1P1zLym8CuZflGNNRTnlm6tcGeGWX9S6Zi/1?=
 =?us-ascii?Q?U66vgAgKPMHY5g50o3tyljnt0BU+YMiKAR/gb+Akid5dITDxB43QsbNIXuiG?=
 =?us-ascii?Q?fFrMUcKY2cHBiT7tkXUGSKwHu6YJQNXen0RNUAtwfW6Bl3PVUtQoMK1Dj6Zv?=
 =?us-ascii?Q?56xtRtnJuynvk7KbW421xkk36NjX0F31VRWBLs4C+gT1xnkkiVjUshqvYpkG?=
 =?us-ascii?Q?bly98zAiNI1mVKz2isGnnM+JhoMxSc1OSUUgH4IPpW3u9jvNGqIe1EMaFZWG?=
 =?us-ascii?Q?yPvGasAU3M7cgGw+k4GRZ4dNsLNRFppyuUIoynHs0Rv9VzXzXPbTf+9s3D3n?=
 =?us-ascii?Q?4UQtgZIGw96cBVOBE8pEW2F849jBdP5JIQvMUPsDQCLfOw+ErGciLdyZFI64?=
 =?us-ascii?Q?dURl+/lqniyrikqQM7VZ+nNK/rHg5PtBn7QlFmwBjqkoHi4ienloRwcprGfT?=
 =?us-ascii?Q?JN6ks6jQz5te6Y2aczaUJFf1GUvkGGdjRxqWPuFxMmWCZqF9qBKz0b3SA9YL?=
 =?us-ascii?Q?2whaOSayeZDALxxH3Us3xggAePWotg1KXyz4UW3kdXtGqqPHLa14uSWwoofV?=
 =?us-ascii?Q?lV5ZncrkKGiaaA8knN7gvW9jSoOAy9UgIgGUhmLHEBzxQMzFLG36anTwwtGA?=
 =?us-ascii?Q?uJDLkfXSx+nbLGsPVda1j4Q7LbnEX48KQrRPdCe3ffPiKdgC3mjapi0D6TSy?=
 =?us-ascii?Q?A1voiez0fRh35b3BfopgDuWdVPR1V7aN9fMaR23dhSo64SqcpEiCDhJkSwfI?=
 =?us-ascii?Q?AucWBINJHndeQEvUPkNZlIeaDDgZ16FbDLLcDaLrvl0apzZJwFNSfuTE9/P5?=
 =?us-ascii?Q?JmSFoMHCjq95DcqaQlMhUWBHPbKBmROrF+lFz+TUH0/aVsSmEWfMVLfzTShq?=
 =?us-ascii?Q?60Z7Imk/eyZx7v35b8VyE4hSnH7uh40zSIUr+hISm95heTVf3CUXN+04CNDM?=
 =?us-ascii?Q?1Pq1F1CwanmFrMHhNxK2yMMHBVnfTdBcwBEUxPw9S6whlBpgezLzRpaNowgG?=
 =?us-ascii?Q?V8SezsUqSDYEF3lpMtp0jAfCy33kmZsJG2XYFNtRlQfft9W5AG2BURm9FSij?=
 =?us-ascii?Q?S6mQo00IQ0AKiume4uDvdiPfubYMKlvNERXPJQD/T2iaywZEKUtOIwFigxaC?=
 =?us-ascii?Q?l7rNyxCwNl01HQ8fFkh0tjjtdgJK+4u8AIU09agwPKlCDK4afeFAO5YrV7fp?=
 =?us-ascii?Q?xPGmxHzBYks1ceIlkAu4u8cVPufupvJjX//p9kygZZ5ufq+rK98zfUsHRqFy?=
 =?us-ascii?Q?F5Z/W+c5bP7ENU2wxWuZDJPr30X2vm0PkdrNfqZomj0/DscWXyDJM2afEtNh?=
 =?us-ascii?Q?Y22jFwIUaZenVweiO7FeDU8E92i7azCOJlQKFof8yKZ6V9OA8vkZ5NHZpeAC?=
 =?us-ascii?Q?1hwUJ6kWtPWWbv1woskZh9IZA0o8x17f4pQAb2i0Fa5jawpRX4AZBrj5oDfo?=
 =?us-ascii?Q?kTiNxBKINx1WPwo9802vRBO+kwwMWUFt2Geqn2ePCjH5CuiGzFSQgxecxEAW?=
 =?us-ascii?Q?CFHW98NxYfgq4yIPIZ2bEIstrq4KjFjU4Gl/ZT/5N/zA4+LJQSZOf4mAr4Sj?=
 =?us-ascii?Q?5faLgaGQB5adciPhZPq9BcuJiYCEqR8fnDPuagIDimunrQVSXE1Cncvvgfze?=
 =?us-ascii?Q?Ty6Fv9KYxrmGUkQCJdYBCatEkvlLQCdL1tZJmmhQXWNen/1KWTMbBXU4IAjn?=
 =?us-ascii?Q?XY2UJTES9Gir+Jpbv2OxWe9svif2DQOjS+1h4NLqRgyvpYYi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ce4fca-c5e6-45d7-2d68-08da34b4f244
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 07:48:18.9033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmuyqa0OXx/NMgwOBeIje7xNwFDYAcHmTF6J/cGZ8NwiwLI92Gi7IgnV1PLjA48q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6017
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
Cc: "Yu, Lang" <Lang.Yu@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>,
 "david.nieto@amd.com" <david.nieto@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is acked-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Powell, Darren <Darren.Powell@amd.com>
> Sent: Friday, May 13, 2022 11:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Quan, Evan <Evan.Quan@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; david.nieto@amd.com; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Yu,
> Lang <Lang.Yu@amd.com>; Powell, Darren <Darren.Powell@amd.com>
> Subject: [PATCH v1 4/4] amdgpu/pm: Optimize aldebaran_emit_clk_levels
>=20
> aldebaran_get_clk_table cannot fail so convert to void function
> aldebaran_freqs_in_same_level now returns bool
> aldebaran_emit_clk_levels optimized:
>    split into two switch statements to gather vars, then use common outpu=
t
>    removed impossible error messages for failure of get_clk_table
>    reduce size of string literals by creating static string var
>    changed unsafe loop iterator from single_dpm_table->count to
> clocks.num_levels
>        in case MAX_DPM_LEVELS > PP_MAX_CLOCK_LEVELS in future code
>    added clock_mhz to remove double divide by 1000
>    collapse duplicate case statements in second switch statement
>    simplified code to output detect frequency level match to current leve=
l
>=20
> =3D=3D Test =3D=3D
> LOGFILE=3Daldebaran.test.log
> AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
> AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR |
> awk '{print $9}'`
> HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}
>=20
> lspci -nn | grep "VGA\|Display"  > $LOGFILE
> FILES=3D"pp_dpm_sclk
> pp_dpm_mclk
> pp_dpm_pcie
> pp_dpm_socclk
> pp_dpm_fclk
> pp_dpm_vclk
> pp_dpm_dclk "
>=20
> for f in $FILES
> do
>   echo =3D=3D=3D $f =3D=3D=3D >> $LOGFILE
>   cat $HWMON_DIR/device/$f >> $LOGFILE
> done
> cat $LOGFILE
>=20
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 173 +++++++-----------
>  1 file changed, 62 insertions(+), 111 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index e593878bc173..23a87bfb4429 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -545,9 +545,9 @@ static int aldebaran_populate_umd_state_clk(struct
> smu_context *smu)
>  	return 0;
>  }
>=20
> -static int aldebaran_get_clk_table(struct smu_context *smu,
> -				   struct pp_clock_levels_with_latency *clocks,
> -				   struct smu_13_0_dpm_table *dpm_table)
> +static void aldebaran_get_clk_table(struct smu_context *smu,
> +				    struct pp_clock_levels_with_latency
> *clocks,
> +				    struct smu_13_0_dpm_table *dpm_table)
>  {
>  	int i, count;
>=20
> @@ -560,11 +560,11 @@ static int aldebaran_get_clk_table(struct
> smu_context *smu,
>  		clocks->data[i].latency_in_us =3D 0;
>  	}
>=20
> -	return 0;
> +	return;
>  }
>=20
> -static int aldebaran_freqs_in_same_level(int32_t frequency1,
> -					 int32_t frequency2)
> +static bool aldebaran_freqs_in_same_level(int32_t frequency1,
> +					  int32_t frequency2)
>  {
>  	return (abs(frequency1 - frequency2) <=3D EPSILON);
>  }
> @@ -738,9 +738,12 @@ static int aldebaran_emit_clk_levels(struct
> smu_context *smu,
>  	struct smu_13_0_dpm_table *single_dpm_table;
>  	struct smu_dpm_context *smu_dpm =3D &smu->smu_dpm;
>  	struct smu_13_0_dpm_context *dpm_context =3D NULL;
> -	uint32_t i, display_levels;
> +	uint32_t i, cur_value =3D 0;
>  	uint32_t freq_values[3] =3D {0};
> -	uint32_t min_clk, max_clk, cur_value =3D 0;
> +	uint32_t min_clk, max_clk, display_levels;
> +	bool freq_match;
> +	unsigned int clock_mhz;
> +	static const char attempt_string[] =3D "Attempt to get current";
>=20
>  	if (amdgpu_ras_intr_triggered()) {
>  		*offset +=3D sysfs_emit_at(buf, *offset, "unavailable\n");
> @@ -750,23 +753,18 @@ static int aldebaran_emit_clk_levels(struct
> smu_context *smu,
>  	dpm_context =3D smu_dpm->dpm_context;
>=20
>  	switch (type) {
> -
>  	case SMU_OD_SCLK:
>  		*offset +=3D sysfs_emit_at(buf, *offset, "%s:\n", "GFXCLK");
>  		fallthrough;
>  	case SMU_SCLK:
>  		ret =3D aldebaran_get_current_clk_freq_by_table(smu,
> SMU_GFXCLK, &cur_value);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get current
> gfx clk Failed!");
> +			dev_err(smu->adev->dev, "%s gfx clk Failed!",
> attempt_string);
>  			return ret;
>  		}
>=20
>  		single_dpm_table =3D &(dpm_context-
> >dpm_tables.gfx_table);
> -		ret =3D aldebaran_get_clk_table(smu, &clocks,
> single_dpm_table);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get gfx clk
> levels Failed!");
> -			return ret;
> -		}
> +		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
>=20
>  		display_levels =3D clocks.num_levels;
>=20
> @@ -782,152 +780,105 @@ static int aldebaran_emit_clk_levels(struct
> smu_context *smu,
>  			freq_values[2] =3D max_clk;
>  			freq_values[1] =3D cur_value;
>  		}
> -
> -		/*
> -		 * For DPM disabled case, there will be only one clock level.
> -		 * And it's safe to assume that is always the current clock.
> -		 */
> -		if (display_levels =3D=3D clocks.num_levels) {
> -			for (i =3D 0; i < clocks.num_levels; i++)
> -				*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i,
> -					freq_values[i],
> -					(clocks.num_levels =3D=3D 1) ?
> -						"*" :
> -
> 	(aldebaran_freqs_in_same_level(
> -							 freq_values[i],
> cur_value) ?
> -							 "*" :
> -							 ""));
> -		} else {
> -			for (i =3D 0; i < display_levels; i++)
> -				*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i,
> -						freq_values[i], i =3D=3D 1 ? "*" :
> "");
> -		}
> -
>  		break;
> -
>  	case SMU_OD_MCLK:
>  		*offset +=3D sysfs_emit_at(buf, *offset, "%s:\n", "MCLK");
>  		fallthrough;
>  	case SMU_MCLK:
>  		ret =3D aldebaran_get_current_clk_freq_by_table(smu,
> SMU_UCLK, &cur_value);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get current
> mclk Failed!");
> +			dev_err(smu->adev->dev, "%s mclk Failed!",
> attempt_string);
>  			return ret;
>  		}
>=20
>  		single_dpm_table =3D &(dpm_context-
> >dpm_tables.uclk_table);
> -		ret =3D aldebaran_get_clk_table(smu, &clocks,
> single_dpm_table);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get memory
> clk levels Failed!");
> -			return ret;
> -		}
> -
> -		for (i =3D 0; i < clocks.num_levels; i++)
> -			*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n",
> -					i, clocks.data[i].clocks_in_khz / 1000,
> -					(clocks.num_levels =3D=3D 1) ? "*" :
> -					(aldebaran_freqs_in_same_level(
> -
> clocks.data[i].clocks_in_khz / 1000,
> -
> cur_value) ? "*" : ""));
> +		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
>  		break;
> -
>  	case SMU_SOCCLK:
>  		ret =3D aldebaran_get_current_clk_freq_by_table(smu,
> SMU_SOCCLK, &cur_value);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get current
> socclk Failed!");
> +			dev_err(smu->adev->dev, "%s socclk Failed!",
> attempt_string);
>  			return ret;
>  		}
>=20
>  		single_dpm_table =3D &(dpm_context-
> >dpm_tables.soc_table);
> -		ret =3D aldebaran_get_clk_table(smu, &clocks,
> single_dpm_table);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get socclk
> levels Failed!");
> -			return ret;
> -		}
> -
> -		for (i =3D 0; i < clocks.num_levels; i++)
> -			*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n",
> -					i, clocks.data[i].clocks_in_khz / 1000,
> -					(clocks.num_levels =3D=3D 1) ? "*" :
> -					(aldebaran_freqs_in_same_level(
> -
> clocks.data[i].clocks_in_khz / 1000,
> -
> cur_value) ? "*" : ""));
> +		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
>  		break;
> -
>  	case SMU_FCLK:
>  		ret =3D aldebaran_get_current_clk_freq_by_table(smu,
> SMU_FCLK, &cur_value);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get current
> fclk Failed!");
> +			dev_err(smu->adev->dev, "%s fclk Failed!",
> attempt_string);
>  			return ret;
>  		}
>=20
>  		single_dpm_table =3D &(dpm_context-
> >dpm_tables.fclk_table);
> -		ret =3D aldebaran_get_clk_table(smu, &clocks,
> single_dpm_table);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get fclk levels
> Failed!");
> -			return ret;
> -		}
> -
> -		for (i =3D 0; i < single_dpm_table->count; i++)
> -			*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n",
> -					i, single_dpm_table-
> >dpm_levels[i].value,
> -					(clocks.num_levels =3D=3D 1) ? "*" :
> -					(aldebaran_freqs_in_same_level(
> -
> clocks.data[i].clocks_in_khz / 1000,
> -
> cur_value) ? "*" : ""));
> +		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
>  		break;
> -
>  	case SMU_VCLK:
>  		ret =3D aldebaran_get_current_clk_freq_by_table(smu,
> SMU_VCLK, &cur_value);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get current
> vclk Failed!");
> +			dev_err(smu->adev->dev, "%s vclk Failed!",
> attempt_string);
>  			return ret;
>  		}
>=20
>  		single_dpm_table =3D &(dpm_context-
> >dpm_tables.vclk_table);
> -		ret =3D aldebaran_get_clk_table(smu, &clocks,
> single_dpm_table);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get vclk
> levels Failed!");
> -			return ret;
> -		}
> -
> -		for (i =3D 0; i < single_dpm_table->count; i++)
> -			*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n",
> -					i, single_dpm_table-
> >dpm_levels[i].value,
> -					(clocks.num_levels =3D=3D 1) ? "*" :
> -					(aldebaran_freqs_in_same_level(
> -
> clocks.data[i].clocks_in_khz / 1000,
> -
> cur_value) ? "*" : ""));
> +		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
>  		break;
> -
>  	case SMU_DCLK:
>  		ret =3D aldebaran_get_current_clk_freq_by_table(smu,
> SMU_DCLK, &cur_value);
>  		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get current
> dclk Failed!");
> +			dev_err(smu->adev->dev, "%s dclk Failed!",
> attempt_string);
>  			return ret;
>  		}
>=20
>  		single_dpm_table =3D &(dpm_context-
> >dpm_tables.dclk_table);
> -		ret =3D aldebaran_get_clk_table(smu, &clocks,
> single_dpm_table);
> -		if (ret) {
> -			dev_err(smu->adev->dev, "Attempt to get dclk
> levels Failed!");
> -			return ret;
> +		aldebaran_get_clk_table(smu, &clocks, single_dpm_table);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (type) {
> +	case SMU_OD_SCLK:
> +	case SMU_SCLK:
> +		/*
> +		 * For DPM disabled case, there will be only one clock level.
> +		 * And it's safe to assume that is always the current clock.
> +		 */
> +		if (display_levels =3D=3D clocks.num_levels) {
> +			for (i =3D 0; i < clocks.num_levels; i++) {
> +				clock_mhz =3D freq_values[i];
> +				freq_match =3D
> aldebaran_freqs_in_same_level(clock_mhz, cur_value);
> +				freq_match |=3D (clocks.num_levels =3D=3D 1);
> +				*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i,
> +							 clock_mhz,
> +							 freq_match ? "*" :
> "");
> +			}
> +		} else {
> +			for (i =3D 0; i < display_levels; i++)
> +				*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n", i,
> +							 freq_values[i], i =3D=3D 1 ?
> "*" : "");
>  		}
>=20
> -		for (i =3D 0; i < single_dpm_table->count; i++)
> +		break;
> +	case SMU_OD_MCLK:
> +	case SMU_MCLK:
> +	case SMU_SOCCLK:
> +	case SMU_FCLK:
> +	case SMU_VCLK:
> +	case SMU_DCLK:
> +		for (i =3D 0; i < clocks.num_levels; i++) {
> +			clock_mhz =3D clocks.data[i].clocks_in_khz / 1000;
> +			freq_match =3D
> aldebaran_freqs_in_same_level(clock_mhz, cur_value);
> +			freq_match |=3D (clocks.num_levels =3D=3D 1);
>  			*offset +=3D sysfs_emit_at(buf, *offset,
> "%d: %uMhz %s\n",
> -					i, single_dpm_table-
> >dpm_levels[i].value,
> -					(clocks.num_levels =3D=3D 1) ? "*" :
> -					(aldebaran_freqs_in_same_level(
> -
> clocks.data[i].clocks_in_khz / 1000,
> -
> cur_value) ? "*" : ""));
> +					i, clock_mhz,
> +					freq_match ? "*" : "");
> +		}
>  		break;
> -
>  	default:
>  		return -EINVAL;
> -		break;
>  	}
> -
>  	return 0;
>  }
>=20
> --
> 2.35.1
