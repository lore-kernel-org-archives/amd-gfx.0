Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB554C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 19:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B8310E1D6;
	Fri, 10 Nov 2023 19:08:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C906610E1D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 19:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6wc+yn/8ahYN8tyrq3LpyTbMYXMT7QzLb0gyHe2t9h/vQDZckpjFbVkweV7/NGtO06GEZpiSposMRVcRMZh1zemBxFRG8Nl3EWnpXuOb5kH+4aTqZGx1xxSU7Qj4FhJVy+1C1e3OtM3BqQc+/rIZavr4lm0r2HV4R3NFnVn7IpmEUxUb4lMXpCBn3H78yrMH2dKwR4iUjlJiSc39wUPhiiFWwgwcAQh3Hbj4OzYjbvnH/qN0Di2ObDivWP+x+8jcui72CtR5hHg8qcrnqrQkHM6heSaIwFLA9jV7+PJtsdd4L0ORS2tAJwQJQVsW0q2BQ85YaIDzUT9NuHcZ782Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO+LB+2gNFl+DfznVAlexIEKQf8yAzrnmfZjORv6Png=;
 b=CEfgVXvt3/5OppD/XrjnYRTH7fO2rtIUCIAxoHv1k3fm+OFVw/Y8oTTZqsQ39JLU+8Hm8E5DxOsnyuC/sKcQplx0JG3N8VmJa6iZWPfMDQEdVpUoVaAfap2pYmJoOeiKIDaUPnlqzHvR+9qdOuvMnEnE9QG2Rbmd1nldtqpskt3g1C5xNj2ydQqS4c5JfxXA1c9yoc73bwD8LwcD+AMCt96V/1+PNyH8BymJy1FrsTvzi4q0awIoaykaXopHV3KwuThbLEjN6vIdlu+fvraysjs4fBAsYk1q0mncL6QocTVMrc4rhpWPu+Jbo1ciZ49e/AP4C3Jrfty0tYn37rZMxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO+LB+2gNFl+DfznVAlexIEKQf8yAzrnmfZjORv6Png=;
 b=0Vnzair80AsBrqzugP65jIGeTLZKmvpse3uilDE3+YzINmlTmw79sTO9eW6x3sl+8Xuz+qBpf7hDQJY+5NYbTUvoh3ZwYktnC+mwbCid/tXWmovt/dZhT0IIqSsI1sCdo7oJLG0EMRoF2DDCDVFX4vIH+R7mat1ru/zQV70jzZU=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 19:08:41 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8ff:474a:c306:f230%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:08:41 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 15/24] drm/amdkfd: trigger pc sampling trap for aldebaran
Thread-Topic: [PATCH 15/24] drm/amdkfd: trigger pc sampling trap for aldebaran
Thread-Index: AQHaDldaYqajdAPMs0e5ih2DMTBtEbBzxX5A
Date: Fri, 10 Nov 2023 19:08:41 +0000
Message-ID: <DM6PR12MB502197027C8B46DB6A4CDDB695AEA@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-16-James.Zhu@amd.com>
In-Reply-To: <20231103131139.766920-16-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7572a412-d8ea-44da-86a8-9d1e2399111d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T16:15:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5021:EE_|CH2PR12MB4311:EE_
x-ms-office365-filtering-correlation-id: 542fb860-7ed4-4996-804b-08dbe2207410
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XE5Jm97jSSmGqUXqrYaz0Au9O8hpq68/dRqvYuvKJBPXPaoGZxBg0Y6GsKY0jQ3X4ijUXB2IOLkyjzFw9CipR7sAyAeelpijGj2o+M3Jdqu18o/wb8NrPLAas5S7TInzBwAvGwgKIPnE2lHMXs5CanbNNFEk/PhQ/SMjr0Q4vh2bK0ChYbaXngfNaEBfWm7ZqCfM0cmCALcFtwIp+7E32BOJNMxaMYrUwaQAnYZMeHsmyoMJCNdEqg+//N9lg18NtF+taToEwSvrXicLmYIExrA1BOJfZm/T6K+5JFhcYv0FltgtUHOVOnqKsKuJdGv57WbKtqhKgeR4ZZqhmGZt1ce5RBebg1x5I7Bofd4z4Uj0SVhDbz7KaWZwMoF+d/C9REbDcbWxVEsl0j77cFVPKoYzTiBYyfLHD9S2fx0IakeLspKjcunjwFleGoAq3L76ijnd+7OjUnJtHKhW+PKsTdzj4T/XsD/zCjAJ3S4uYGw1nf0HY3rgE29ItsXsX9cG4N18vcrk/mOB+yGkTbX9qpwEsQgGenvmx1B9nlI2qcaBVOmVbiooi0iM9ziWmBTMnWmEzARQqpoYciY5/9eQDTGCcsL/beG9Jz/tJg3Cp9PZ5+uTKcULx0LK4eHCKG8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(346002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(110136005)(8676002)(478600001)(52536014)(4326008)(8936002)(55016003)(83380400001)(6506007)(53546011)(5660300002)(76116006)(66476007)(64756008)(54906003)(26005)(316002)(66446008)(66556008)(71200400001)(41300700001)(66946007)(2906002)(122000001)(86362001)(38100700002)(7696005)(33656002)(38070700009)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MrglnepHbl2yGA5nP7I7vpEokrBzoEMiCTLrv54EpUtXw0v94dLH0gYl8nrW?=
 =?us-ascii?Q?5c+tokuFnAzZ54gLxQYIaviPG0afblMC0ASI5qZFuAqdvDJXjzMJ7nwPutzE?=
 =?us-ascii?Q?hxxu9Ds2gAcpx2hxcFnK+6PZVO1L/PrxHUQ4sot3xVwIfsoPLzAtMaG9Tkbk?=
 =?us-ascii?Q?EMDOcfaHPJHgYZlORfRV94JRjdzraKE82iKnQ8jLJ5ARbyg11HE2iqzxxhQ2?=
 =?us-ascii?Q?CXng5oFin0hYsCugvS9I2I9uSCnHVyONtnkMbuaKW7GnefIMSBwEx276NEq3?=
 =?us-ascii?Q?v+Npg/ZkqsIqRW7/iRFXZylu8crQTuYXnpC0Czpb1/6UkY8J1LK/l3MLBfmc?=
 =?us-ascii?Q?A7ulzLm11ayQh98addvPkKzdtoeKQpo1Y1VuOap1FPiB6dL4FDDTCEaT09Lz?=
 =?us-ascii?Q?cfru+sAS+IyZhBeQ9il8etLmFoOOEqXlTJ5tRnjpj2w1RWjrUJEUOfh8/I8A?=
 =?us-ascii?Q?2EUqwWvATZAz2ZWUMGBCr39QvxWyUmjP1XvmnUZhsL8VY2+uRw4qERFD7y2T?=
 =?us-ascii?Q?NVXGegHW0NG02RonwiuJLykNISX9GZZqV8emad8DebM5mDgbdzUyntr3LP7x?=
 =?us-ascii?Q?YFygksPtawtMoIaMXApFrveGAkiid/2DX3/BFii4xOzKTOUnegyv70QLy7pI?=
 =?us-ascii?Q?oo5a+dEqClsn7IhvNp+zy+1S+giPsmwmxfR1rI2vrrcGpUO6N5JeiUQV0nrh?=
 =?us-ascii?Q?Iwn034VCvG49uLZy5rCqp4kfruniRPToXtv/XTpemzNGSX3pwN3TeO6hPRZg?=
 =?us-ascii?Q?7sygDg9XQhVcBsA4TFqeEXJK9QEl2/8P4cKGHFt87qrC4hdBJddwXQ2BAV5e?=
 =?us-ascii?Q?RPu8ZwvQz6g63BoA2pEqtvY/yXZYQYXEmayDt2pUkhi9ER+SC57tgEv/w3jP?=
 =?us-ascii?Q?I7myTXIxcb26xeJF1yLE9l/wR027tFp3rDPbrVMfIdTcXKa5YWbCkS88jxBZ?=
 =?us-ascii?Q?2OsLTrIz4rwyZtUCDt4oZNHO56+rFKSwnI5qHXJUQyIen3/VvAcfo26qv2Oy?=
 =?us-ascii?Q?OUNYbRfS+tYS4ZF1ohVNuhs94i8wuRO6AseRHw/cXnTWSiCHp4NTBlInsdmJ?=
 =?us-ascii?Q?ZEiHaUWvZ+ElMpZ66Ks8kvXL9vWILYH435VYLuu2PjZ1Z/7f58So3hOr0DzO?=
 =?us-ascii?Q?vWDoltbKlCJS9995qX20/cbqvTkr63OtRDRe5yyDyp5IaMOTPIuxi+g03BWE?=
 =?us-ascii?Q?YYwFIuifAhSAuDpnwWG3yUvNdQEucyEpANj7kIju6fzbMH4WYAY0KTIbgB5l?=
 =?us-ascii?Q?51mCMoKSYqyKgRiNFG2WjMHuWRFOdUrKzVlVAPka2k12oKbK3aFtyUD5u0rN?=
 =?us-ascii?Q?JZZUIc/CDU6d2Oyzmwr10qizSQ6FJDXoM8+gjy8UCa3Ry96DeNzCfn+wM/7J?=
 =?us-ascii?Q?85l1pLK32GFcawBxqaJxWzkQI+xsQjshrfF6sTKrfqEmKTUpJ8yrvt+VLPJA?=
 =?us-ascii?Q?YGIUGvk/Zt0pXnLmlqqdvzrdX1UQ5s4vxfpyPDR9Vp1RFGn9s+djr2Flo7nj?=
 =?us-ascii?Q?cCHC1QDkjdnaCzw2e9RuTc1H+UtGw77zoO0L2zK1cQevWEjIlqsFpZQGvFUt?=
 =?us-ascii?Q?iXTK0pPhpV3QxoU3A4c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542fb860-7ed4-4996-804b-08dbe2207410
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:08:41.6782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYg+lw/J14ii7be/UW6GWv+HgrZnMx8Q1VTCI3Op2lvl8NHn7Qng4FOBM2Z6o/jNnGjW+7GQiuLs4iMT5tYyFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Greathouse,
 Joseph" <Joseph.Greathouse@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I would merge this with patch 14 of the series

> -----Original Message-----
> From: Zhu, James <James.Zhu@amd.com>
> Sent: Friday, November 3, 2023 9:12 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Greathouse, Joseph
> <Joseph.Greathouse@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Zhu,
> James <James.Zhu@amd.com>
> Subject: [PATCH 15/24] drm/amdkfd: trigger pc sampling trap for aldebaran
>
> Implement trigger pc sampling trap for aldebaran.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 11
> +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index aff08321e976..27eda75ceecb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -163,6 +163,16 @@ static uint32_t
> kgd_gfx_aldebaran_set_address_watch(
>       return watch_address_cntl;
>  }
>
> +static uint32_t kgd_aldebaran_trigger_pc_sample_trap(struct amdgpu_devic=
e
> *adev,
> +                                         uint32_t vmid,
> +                                         uint32_t *target_simd,
> +                                         uint32_t *target_wave_slot,
> +                                         enum kfd_ioctl_pc_sample_method
> method) {
> +     return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 8, 4,
> +                                     target_simd, target_wave_slot,
> method); }
> +
>  const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
>       .program_sh_mem_settings =3D kgd_gfx_v9_program_sh_mem_settings,
>       .set_pasid_vmid_mapping =3D kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -191,4 +201,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd =3D {
>       .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
>       .build_grace_period_packet_info =3D
> kgd_gfx_v9_build_grace_period_packet_info,
>       .program_trap_handler_settings =3D
> kgd_gfx_v9_program_trap_handler_settings,
> +     .trigger_pc_sample_trap =3D kgd_aldebaran_trigger_pc_sample_trap,
>  };
> --
> 2.25.1

