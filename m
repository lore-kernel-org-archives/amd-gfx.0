Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F67EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 13:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11B4112B03;
	Mon, 22 Apr 2024 13:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hYMfNv1q";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C904112B03
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0kyP4Qr7KONCHoitoFF77979f8SvpAY27k8VENX191GW+QMojkzZJdEZPQwYOANAocysIrToQh/Epm7ArlRSB45kqb9+37ZVXTXnIAeqGstGSEWt0g1zkxr1x1P6do7WirBOvSazxCJkbWMSPtfbIEbQEQeXsKzF+UAIlSYpfZd2R8qocKU9xR7c/ztJ4cVBRF7jzWaW32cviOVTzmUqptueRTrOYJjslZ0EcKQh1tI4WBmxHs5Epbypb+pBYlqJUkaXJb3aUQyzRBxV24wmjL80b8Q1ZRVsAvPuonVPtFUN/j/3Jd7VWkfglSuFlVS0dmNi5BDiStLC5sT5vu06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX2JfyLO3HRNDgBg6ICLzgqre895UXLhSw5gnrQSsos=;
 b=ggaxrtir5uJpW2awFPQhw84YjL5jhv6YPw3u/zGBi3UlXBOB58aQb6x0fzlXkBURlt3oB82p80zxJheTiLfXcjM2YXks2HysfClpNZuw/Zt0O3OPsDAiESIAjA2naxVV6i8Ushk2z68mfXHqRhu2mnIM/RDk4UHdQT8Clj/+fPT8+7nttiIaSYjYmdx6LvXrPh1emMrvbUDlKxMf+mh2PowLIGwRplFExPmA1GfOxBKlOA4jEPg8z0pehdiLXXDf5C+fOL/JWNbP/QIQBSvhoVpGNM0UpntCki414ZyqX2lXAxXcpacoZnX5URv0svhJamfJtY1cuvq8yZ0eeQBdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX2JfyLO3HRNDgBg6ICLzgqre895UXLhSw5gnrQSsos=;
 b=hYMfNv1qdyVytrdXNw0jmLdvGBI3/uffJSe/YH7NKLgozco7JE9gwC2qy9K1MrELsrYBqkeqbAg/3Od/dd7XkNmogXbfCbN0qvb8FV/7203sVRvjJB2fgqbk5fc8cww8khwUQLYgCnwnCfZnMFqewbsuo4ZyTwuj0IpZX/nHSj4=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 13:54:15 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a702:68e0:aa54:fb87]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::a702:68e0:aa54:fb87%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 13:54:15 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: add the amdgpu buffer object move speed
 metrics
Thread-Topic: [PATCH 3/3] drm/amdgpu: add the amdgpu buffer object move speed
 metrics
Thread-Index: AQHaj9tc8LCAmLiVAEy/P/VRbSObiLF0WDPg
Date: Mon, 22 Apr 2024 13:54:15 +0000
Message-ID: <DS7PR12MB600574D2CB0EE0E87AE12265FB122@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20240416085150.2459820-1-Prike.Liang@amd.com>
 <20240416085150.2459820-3-Prike.Liang@amd.com>
In-Reply-To: <20240416085150.2459820-3-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6ab4630c-7f21-45ca-be2e-877dabf2a3f7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-22T13:49:55Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM6PR12MB4153:EE_
x-ms-office365-filtering-correlation-id: c738902e-ea84-4018-4615-08dc62d3b2c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?JjLuIQ396wpvvg7IDs1ftw4MZv7iaB1CF08AuKg7PVJbwhQZ3rRLXiHVFMTA?=
 =?us-ascii?Q?DZHYG/yXHcvITP5j1Y7C7qVFt136YL9oa6ksxxpjDTe1VTSrGh4+qul3ugWt?=
 =?us-ascii?Q?6dhsXo2/Cl1KXtpcbmgBay4eLHA9vLDkchbsukIm5R0eRzica5IDrc1JHJMz?=
 =?us-ascii?Q?imVH+42FMLc/fhkBfOO0FQboGT4MFuT0FFcDTBLNbaLV0B5M5DQQqmgowBzP?=
 =?us-ascii?Q?swd1pygANBDydKeFy1tjW0vM+H+bYfVW94tlx1C4higlXJEAdi6nkCVk6TjU?=
 =?us-ascii?Q?FsvYT+1AjNvifPcvgl7feLsmNgSs0H9tw0HAb0c1GW11X1cUdMtI0CkDFihV?=
 =?us-ascii?Q?9irTGnsVjrRtCN79UkZydemVVabo1I0gHTH2p2Tmx7OP20zXPw3a2RZxMX4i?=
 =?us-ascii?Q?P+TJ3u4laPfCiRgIIq09s4odJfxewbqq8LC+wplk07chIN4ANy5cy0D57lCO?=
 =?us-ascii?Q?G6JirhHfBklayXADkTk5oJToBgakxJzpDSn4jPWn5i9dHbMjR6LOJP8ViJqE?=
 =?us-ascii?Q?L0G1qHBGQiramr0XXDaEia49OlMKDGLYE0euccQ8ZFzKHtJ0j3i7XhjisE2r?=
 =?us-ascii?Q?j+BDfsl023a4bLj9YWZOOt3bCp5g01Rg0N/OLuwMhJgAEiiwx8suf7NBkI/b?=
 =?us-ascii?Q?4TIWjSBrujLwo7tkSMKt63lUzAwW0FpxvF5Z+V3ySRn4et2hT0Pb+E4mFAg1?=
 =?us-ascii?Q?VcCpMyzpb0yMPfurRoEaKAMuIckU5fl2ih4sQqmPoaNku3HB2M2pQlFydGOR?=
 =?us-ascii?Q?Zd8UoSzS0H/3qaGX3tA67AuObIrms2dS7eQD/lgMTMUOIp7FSkCT7fHzwUYv?=
 =?us-ascii?Q?0VIKbMYaVAHE9QzE3nF5M0TL0jQnbLjK3naFbP8fbGtUoP6BwY95asa/5Sso?=
 =?us-ascii?Q?LQO0xNimoQ5V6S5krahaJSSsOuJ31QdGNRtL18wIogDti2Avl3BiRl9ZOOOU?=
 =?us-ascii?Q?ak0MATzw0rrUG4/Hke85OR/IWMrqjfWE9b19CO+WBNGdSiiaBNaayZ1QvgMH?=
 =?us-ascii?Q?o322GQNbivgkV5jbjAOLycMjF1d/gl6slIKdFgQ6uRDaUq+JFjHakAOm3Tbm?=
 =?us-ascii?Q?BYOTS5Em+sw9dIZt+avycRGvz4ZLOPsdYjOX7cDaxvF+87d08ZlDNrFQGjUx?=
 =?us-ascii?Q?ILzw0UAWMw4uCZnOnXltE3KYeCB+sFPkfJuCzCGDtj/c+zzJuTFghcEXHknx?=
 =?us-ascii?Q?oIf7+8vc53wzWgJI74DgZAc+QDaqA0mE/zmajKn4DPcVFDD27l3hlBkquDI+?=
 =?us-ascii?Q?HTRBup/pph1zLlWOb4pdNvBUdTU9BdzvQk/xKssoBCpMqAdg/Cxa4wkE52v7?=
 =?us-ascii?Q?DmRvl05zDmbY3WkDUAEI8N41m+II4U610wB9qU4WHndfkQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1f59xbCMg2qVXCTQXGbH3pm5bFUZ+NZRUTkmUI2FbTikdX+HN0X0lUk9XBe7?=
 =?us-ascii?Q?V7MsaswA/q9TdB1Qw7Xs28KzN1KYb09LLN0zpf9hphd/9/0BMw8Ir+2ccq0z?=
 =?us-ascii?Q?VXtvO8GY00b9O15j/da3ZCkVZcVAuG5CGDBAKaskpztunPWK0jSOBXXKC/3m?=
 =?us-ascii?Q?0PHzZvuigD3uFLB87GarW7nTHzBxUvZgCGxNecnOXuhuonWhpgJu6BDviYN6?=
 =?us-ascii?Q?LjwGoFnzqOmoP0WHG2IE96EsQKpyVkFEpb53Vs1czPsRDoPcD2r/rkzHiecG?=
 =?us-ascii?Q?8LYYT6QbXXRGq1452RV60dzNodTVId99p4lvKDX+I4Ro2a6RaX412+mGyd1H?=
 =?us-ascii?Q?mydqKNpRo28+F/yx84Pq7AwuAFVlj5WvbsXYhGQQMYbQdaHTUxnde8VgCKHD?=
 =?us-ascii?Q?nP6e2wybnSDt71W7NzAb75dduuqFxoCbwOFQpwkBo0R2Az/l3SBKCW8x2XSq?=
 =?us-ascii?Q?6Vyv5VufDQkmH4miiZ+TONsz2UFNXLXDU/mvhIMTcBHGLJoN9INny7Exz2s3?=
 =?us-ascii?Q?SUpZTRCF5k1/X3+cUa1F98bnNkU/Ff8gex8clS6jg1wWSfQcPVTO4nnOgtUy?=
 =?us-ascii?Q?qwjfVE9Ef619QPKNgOyPSV6CXIfdmXQl2Zhb54sSi2BV/1z1raNgGRxC0J3J?=
 =?us-ascii?Q?LYD/27ACQCGeNW7iNa3mrBzI55MD2NJB2HQE+qMRiCxqK3rdmereJsy9vDKU?=
 =?us-ascii?Q?oq12W2aE/y1sKwgyoNi8f9/bjzl6QBdDNaLFmM6DtigmhchX21FeeLFX0CoS?=
 =?us-ascii?Q?qMPKgjELOFHn6Sx2BZI/K+9M9l0lQ1CjqlCFYV4WSB0Brmhv3VzqE5EbM5cj?=
 =?us-ascii?Q?XJw7NgTIbnC6tTpmmVOvTCe0rzewPELd8thSJQocb4p9c8EXwmJSOOEe2cmV?=
 =?us-ascii?Q?Dlp8Z6JKl5+uiX9oGP0A1c/MpgBoQW32XW7XPxV9yeTblUyIvldf4OUco14g?=
 =?us-ascii?Q?+7fmKlp13BzuehHHY6bPbz3ZJxrrMmHatzhsV1I0DSUDhd14Nz9pOeySQUtu?=
 =?us-ascii?Q?GhOJvD3qVQDUWVroBiGbXpK1Hz/Eq0MF9Z4wgmlgbeLCdp11rqTmfLxT+ipe?=
 =?us-ascii?Q?qL6+xMAsm11iJLNo7A5JTgU8QszcDoakiVRQbtTV8ygSUx4FIIkTWtOnT4iC?=
 =?us-ascii?Q?X6hI/gnU9bIVV5r91bWyM2yxRr9AKn3VaQ1/KB5bTrbV6+K0EOJQJTzT8I1U?=
 =?us-ascii?Q?6asKziPKWlZ54sX5OtqWqh532kETAF1MyNBpN2qblDJ0j96UslxkROIZ5c/D?=
 =?us-ascii?Q?CDBMfuJvyp+EcfnIb67+wW7I1uLifOs94xtX95eTgAH3pvuwdukauAh7KdPJ?=
 =?us-ascii?Q?SXC2eH+KmgREd9XaY0OYQHJRjLGnXzBUdzerc03+6BRhz6PS1CBh61rVnkWS?=
 =?us-ascii?Q?6CG2Zwiqy8eDQhG1Y9VRvmG1LANpMYifqID4/XtWWxlGJ9OAPPVE47j9KyQs?=
 =?us-ascii?Q?g9w9/0g/ozcavrKtduwCJBdoaIRx1Z+DMMDTqXJ4TRvrOlXWjY5fQ8ZBcdJQ?=
 =?us-ascii?Q?k6Ps8pSFY2n4Zwb74tvgF1aSGgbP3+7nApWPx8ozxe1h5LKtkRSuD7ARVort?=
 =?us-ascii?Q?SRHUv9Y1YUYAnibt+uk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c738902e-ea84-4018-4615-08dc62d3b2c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 13:54:15.6319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5z+1PLpv8gg3l3wr49nUIqGYrWr8ohNVLZlc16YyS83Kb+Wu30rQFDlxIY2Fo79n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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

[AMD Official Use Only - General]

Soft ping for the series.

Thanks,
Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Tuesday, April 16, 2024 4:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: add the amdgpu buffer object move
> speed metrics
>
> Add the amdgpu buffer object move speed metrics.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 78
> ++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
>  3 files changed, 61 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 163d221b3bbd..2840f1536b51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -502,7 +502,7 @@ void amdgpu_device_wb_free(struct amdgpu_device
> *adev, u32 wb);
>  /*
>   * Benchmarking
>   */
> -int amdgpu_benchmark(struct amdgpu_device *adev, int test_number);
> +int amdgpu_benchmark(struct amdgpu_device *adev, int test_number,
> +struct seq_file *m);
>
>  int amdgpu_benchmark_dump(struct amdgpu_device *adev, struct seq_file
> *m);
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index f6848b574dea..fcd186ca088a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -65,20 +65,27 @@ static void amdgpu_benchmark_log_results(struct
> amdgpu_device *adev,
>                                        int n, unsigned size,
>                                        s64 time_ms,
>                                        unsigned sdomain, unsigned
> ddomain,
> -                                      char *kind)
> +                                      char *kind, struct seq_file *m)
>  {
>       s64 throughput =3D (n * (size >> 10));
>
>       throughput =3D div64_s64(throughput, time_ms);
>
> -     dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
> -              " %d to %d in %lld ms, throughput: %lld Mb/s or %lld
> MB/s\n",
> -              kind, n, size >> 10, sdomain, ddomain, time_ms,
> -              throughput * 8, throughput);
> +     if (m) {
> +             seq_printf(m, "\tamdgpu: %s %u bo moves of %u kB from"
> +                      " %d to %d in %lld ms, throughput: %lld Mb/s or %l=
ld
> MB/s\n",
> +                     kind, n, size >> 10, sdomain, ddomain, time_ms,
> +                     throughput * 8, throughput);
> +     } else {
> +             dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB
> from"
> +                      " %d to %d in %lld ms, throughput: %lld Mb/s or %l=
ld
> MB/s\n",
> +                     kind, n, size >> 10, sdomain, ddomain, time_ms,
> +                     throughput * 8, throughput);
> +     }
>  }
>
>  static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned
> size,
> -                              unsigned sdomain, unsigned ddomain)
> +                              unsigned sdomain, unsigned ddomain, struct
> seq_file *m)
>  {
>       struct amdgpu_bo *dobj =3D NULL;
>       struct amdgpu_bo *sobj =3D NULL;
> @@ -109,7 +116,7 @@ static int amdgpu_benchmark_move(struct
> amdgpu_device *adev, unsigned size,
>                       goto out_cleanup;
>               else
>                       amdgpu_benchmark_log_results(adev, n, size,
> time_ms,
> -                                                  sdomain, ddomain,
> "dma");
> +                                                  sdomain, ddomain, "dma=
",
> m);
>       }
>
>  out_cleanup:
> @@ -124,7 +131,7 @@ static int amdgpu_benchmark_move(struct
> amdgpu_device *adev, unsigned size,
>       return r;
>  }
>
> -int amdgpu_benchmark(struct amdgpu_device *adev, int test_number)
> +int amdgpu_benchmark(struct amdgpu_device *adev, int test_number,
> +struct seq_file *m)
>  {
>       int i, r;
>       static const int
> common_modes[AMDGPU_BENCHMARK_COMMON_MODES_N] =3D { @@ -
> 153,13 +160,16 @@ int amdgpu_benchmark(struct amdgpu_device *adev, int
> test_number)
>               dev_info(adev->dev,
>                        "benchmark test: %d (simple test, VRAM to GTT and
> GTT to VRAM)\n",
>                        test_number);
> +             if (m)
> +                     seq_printf(m, "\tbenchmark test: %d (simple test,
> VRAM to GTT and GTT to VRAM)\n",
> +                      test_number);
>               /* simple test, VRAM to GTT and GTT to VRAM */
>               r =3D amdgpu_benchmark_move(adev, 1024*1024,
> AMDGPU_GEM_DOMAIN_GTT,
> -                                       AMDGPU_GEM_DOMAIN_VRAM);
> +                                       AMDGPU_GEM_DOMAIN_VRAM,
> m);
>               if (r)
>                       goto done;
>               r =3D amdgpu_benchmark_move(adev, 1024*1024,
> AMDGPU_GEM_DOMAIN_VRAM,
> -                                       AMDGPU_GEM_DOMAIN_GTT);
> +                                       AMDGPU_GEM_DOMAIN_GTT, m);
>               if (r)
>                       goto done;
>               break;
> @@ -167,9 +177,13 @@ int amdgpu_benchmark(struct amdgpu_device
> *adev, int test_number)
>               dev_info(adev->dev,
>                        "benchmark test: %d (simple test, VRAM to
> VRAM)\n",
>                        test_number);
> +             if (m)
> +                     seq_printf(m, "\tbenchmark test: %d (simple test,
> VRAM to VRAM)\n",
> +                      test_number);
> +
>               /* simple test, VRAM to VRAM */
>               r =3D amdgpu_benchmark_move(adev, 1024*1024,
> AMDGPU_GEM_DOMAIN_VRAM,
> -                                       AMDGPU_GEM_DOMAIN_VRAM);
> +                                       AMDGPU_GEM_DOMAIN_VRAM,
> m);
>               if (r)
>                       goto done;
>               break;
> @@ -177,11 +191,15 @@ int amdgpu_benchmark(struct amdgpu_device
> *adev, int test_number)
>               dev_info(adev->dev,
>                        "benchmark test: %d (GTT to VRAM, buffer size
> sweep, powers of 2)\n",
>                        test_number);
> +             if (m)
> +                     seq_printf(m, "\tbenchmark test: %d (GTT to VRAM,
> buffer size sweep, powers of 2)\n",
> +                             test_number);
> +
>               /* GTT to VRAM, buffer size sweep, powers of 2 */
>               for (i =3D 1; i <=3D 16384; i <<=3D 1) {
>                       r =3D amdgpu_benchmark_move(adev, i *
> AMDGPU_GPU_PAGE_SIZE,
>
> AMDGPU_GEM_DOMAIN_GTT,
> -
> AMDGPU_GEM_DOMAIN_VRAM);
> +
> AMDGPU_GEM_DOMAIN_VRAM, m);
>                       if (r)
>                               goto done;
>               }
> @@ -190,11 +208,14 @@ int amdgpu_benchmark(struct amdgpu_device
> *adev, int test_number)
>               dev_info(adev->dev,
>                        "benchmark test: %d (VRAM to GTT, buffer size
> sweep, powers of 2)\n",
>                        test_number);
> +             if (m)
> +                     seq_printf(m,"\tbenchmark test: %d (VRAM to GTT,
> buffer size sweep, powers of 2)\n",
> +                             test_number);
>               /* VRAM to GTT, buffer size sweep, powers of 2 */
>               for (i =3D 1; i <=3D 16384; i <<=3D 1) {
>                       r =3D amdgpu_benchmark_move(adev, i *
> AMDGPU_GPU_PAGE_SIZE,
>
> AMDGPU_GEM_DOMAIN_VRAM,
> -
> AMDGPU_GEM_DOMAIN_GTT);
> +
> AMDGPU_GEM_DOMAIN_GTT, m);
>                       if (r)
>                               goto done;
>               }
> @@ -203,11 +224,14 @@ int amdgpu_benchmark(struct amdgpu_device
> *adev, int test_number)
>               dev_info(adev->dev,
>                        "benchmark test: %d (VRAM to VRAM, buffer size
> sweep, powers of 2)\n",
>                        test_number);
> +             if (m)
> +                     seq_printf(m, "\tbenchmark test: %d (VRAM to VRAM,
> buffer size sweep, powers of 2)\n",
> +                              test_number);
>               /* VRAM to VRAM, buffer size sweep, powers of 2 */
>               for (i =3D 1; i <=3D 16384; i <<=3D 1) {
>                       r =3D amdgpu_benchmark_move(adev, i *
> AMDGPU_GPU_PAGE_SIZE,
>
> AMDGPU_GEM_DOMAIN_VRAM,
> -
> AMDGPU_GEM_DOMAIN_VRAM);
> +
> AMDGPU_GEM_DOMAIN_VRAM, m);
>                       if (r)
>                               goto done;
>               }
> @@ -216,11 +240,14 @@ int amdgpu_benchmark(struct amdgpu_device
> *adev, int test_number)
>               dev_info(adev->dev,
>                        "benchmark test: %d (GTT to VRAM, buffer size
> sweep, common modes)\n",
>                        test_number);
> +             if (m)
> +                     seq_printf(m,"\tbenchmark test: %d (GTT to VRAM,
> buffer size sweep, common modes)\n",
> +                             test_number);
>               /* GTT to VRAM, buffer size sweep, common modes */
>               for (i =3D 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N;
> i++) {
>                       r =3D amdgpu_benchmark_move(adev,
> common_modes[i],
>
> AMDGPU_GEM_DOMAIN_GTT,
> -
> AMDGPU_GEM_DOMAIN_VRAM);
> +
> AMDGPU_GEM_DOMAIN_VRAM, m);
>                       if (r)
>                               goto done;
>               }
> @@ -229,11 +256,14 @@ int amdgpu_benchmark(struct amdgpu_device
> *adev, int test_number)
>               dev_info(adev->dev,
>                        "benchmark test: %d (VRAM to GTT, buffer size
> sweep, common modes)\n",
>                        test_number);
> +             if (m)
> +                     seq_printf(m,"\tbenchmark test: %d (VRAM to GTT,
> buffer size sweep, common modes)\n",
> +                             test_number);
>               /* VRAM to GTT, buffer size sweep, common modes */
>               for (i =3D 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N;
> i++) {
>                       r =3D amdgpu_benchmark_move(adev,
> common_modes[i],
>
> AMDGPU_GEM_DOMAIN_VRAM,
> -
> AMDGPU_GEM_DOMAIN_GTT);
> +
> AMDGPU_GEM_DOMAIN_GTT, m);
>                       if (r)
>                               goto done;
>               }
> @@ -241,12 +271,15 @@ int amdgpu_benchmark(struct amdgpu_device
> *adev, int test_number)
>       case 8:
>               dev_info(adev->dev,
>                        "benchmark test: %d (VRAM to VRAM, buffer size
> sweep, common modes)\n",
> -                      test_number);
> +                     test_number);
> +             if (m)
> +                     seq_printf(m,"\tbenchmark test: %d (VRAM to VRAM,
> buffer size sweep, common modes)\n",
> +                             test_number);
>               /* VRAM to VRAM, buffer size sweep, common modes */
>               for (i =3D 0; i < AMDGPU_BENCHMARK_COMMON_MODES_N;
> i++) {
>                       r =3D amdgpu_benchmark_move(adev,
> common_modes[i],
>                                             AMDGPU_GEM_DOMAIN_VRAM,
> -                                           AMDGPU_GEM_DOMAIN_VRAM);
> +                                           AMDGPU_GEM_DOMAIN_VRAM,
> m);
>                       if (r)
>                               goto done;
>               }
> @@ -449,7 +482,7 @@ static void
> amdgpu_benchmark_mem_metrics_dump(struct amdgpu_device *adev,
> struct
>                       &adev->mman.gtt_mgr.manager;
>       struct ttm_resource_manager *vram_man =3D
>                       &adev->mman.vram_mgr.manager;
> -     uint32_t l1_cache_size;
> +     uint32_t l1_cache_size, j;
>
>       seq_puts(m, "amdgpu benchmark mem metrics dump:\n");
>
> @@ -483,6 +516,13 @@ static void
> amdgpu_benchmark_mem_metrics_dump(struct amdgpu_device *adev,
> struct
>                       atomic64_read(&adev->gart_pin_size));
>       seq_printf(m, "\tGTT heap usage size:%lld KB\n",
> ttm_resource_manager_usage(gtt_man));
>
> +     seq_printf(m, "\t--------amdgpu buffer object move speed test begin=
---
> -----\n");
> +     for (j =3D 1; j < 8; j++) {
> +             /*TODO: Add the cases of gfx and CPU move cases.*/
> +             amdgpu_benchmark(adev, j, m);
> +     }
> +     seq_printf(m, "\t--------amdgpu buffer object move speed test
> +end--------\n");
> +
>       seq_printf(m, "\n");
>
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 7e935b9736c1..4d710c5f8465 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1760,7 +1760,7 @@ static int amdgpu_debugfs_benchmark(void *data,
> u64 val)
>               return r;
>       }
>
> -     r =3D amdgpu_benchmark(adev, val);
> +     r =3D amdgpu_benchmark(adev, val, NULL);
>
>       pm_runtime_mark_last_busy(dev->dev);
>       pm_runtime_put_autosuspend(dev->dev);
> --
> 2.34.1

