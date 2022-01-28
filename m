Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937B5C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 03:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F410F10E338;
	Fri, 28 Jan 2022 03:33:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 889AE10E338
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 03:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjXgnxzPJ35ehZ4k7MANn0dcx4oVclYAJKuTRFwP/5iEjHpTgsNWMDarBRgd54+fhVRl4d6z4Hm4djdoBOMA7HMhyuifpFzdiUcPF8XWOcPSfNik8OHuLFPJtx6vhPFE/m0h7xoW2NRXeiuQIoYtjc+qERX4RaF+kgXs5sEBSFYaJ5sXYfqivRYtuGq66aHPN5k40WInFadO5mwg76p4W2eAv0V53T50zaJS5kW3wesd1dUiWXIa5nWokdM7IJ3vWZowoSQLWpOSJFv5M9HOp0L6T9IaOzeJ+UGLWxcTJ46pYD9nYEldpv3r8ERiPmwfyXS2U59sx0xq3PJpHH15cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifIM5iDlTMlE254wX8APvCjxm66OnA7Puz+soswD6Iw=;
 b=k6uH8cafwp8fI1Wc3KnxrV1gdjD1++zlTEuN8mrBA1G5lkGfg/bnQIy2/Z7t/G+PGjjdcVvEAeO4oMh9qG0zDDdhDGPRlQ2X2w1qq3yrZ7G8z0j+nZZJVc8B7RdNiMfY6GfcRMfxaclCOp3qUtTqYbddmNOwZSAhvCRhLLZjs7zlWMupzird5Ewptf82yKZVbAwRRQM9Fj8Glx8NlCk+UyQ4ExfN5IIGvFf93ZXICZPiSj7ECixI521UKc2lR2qNj/bbWiKwaGGnpFEmPPHmxozZfIEtyaonUDWRPWk2k1PS49V2KOu4McNvbDnr1jsVJDJlkSsT8lojwFP8bCQL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifIM5iDlTMlE254wX8APvCjxm66OnA7Puz+soswD6Iw=;
 b=dhESHOPGbR76ngkeaH75OgzqJVbNnPaUorDH34RR7unCkg6TKZ50WqEwBf4NAh3iBPyxnk3wdJX+8YuRbgvq7QUsUxLtEnfmyvjJ542yheqELA48juFZ0UHpJvDduTQ1Sp2zR9nJEgWjyRn7M3a9YqNgOFy44QLyQuVxK2RF7pY=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB3819.namprd12.prod.outlook.com (2603:10b6:5:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 03:33:38 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4909.019; Fri, 28 Jan
 2022 03:33:38 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Clements, John"
 <John.Clements@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add umc_convert_error_address to simplify code
Thread-Topic: [PATCH] drm/amdgpu: add umc_convert_error_address to simplify
 code
Thread-Index: AQHYEqSR7H3/mByxn0y85cCEQo1zPax3ylKw
Date: Fri, 28 Jan 2022 03:33:38 +0000
Message-ID: <DM5PR12MB1770C05CF469FBCDD26140F0B0229@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220126110447.28973-1-tao.zhou1@amd.com>
In-Reply-To: <20220126110447.28973-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-28T03:33:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=15b21860-051d-49f4-8fd0-9032c51e688e;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-28T03:33:35Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 6ed8a1f6-1f53-46b8-9eea-5496eb260391
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de3cff32-8580-42d5-e7d6-08d9e20ef928
x-ms-traffictypediagnostic: DM6PR12MB3819:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3819547FA0BF6E63335881CAB0229@DM6PR12MB3819.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Op2iZ3YZyUyI69jqVNHvMOlDMFzWPqg8NPHe0E5phrm5lhqhf5xT7v6XqnnsBq7fV2wUqFrfD5LVYlaBo+dZgy9ii2wepu977JZ8lsHOgcj4qDg3cl/zmAcUhcAH3qe7+viUpKrH1KyClDf7ttHqEDBjTR0KAaYCamqyhhVgRsn/EhMQnn2anU5J6UZW01qW6saIppIY8EzHJCBCjx3k9FYprKmT5CSp3di32J5MeqWKOrQmWEYYO/kN5TuVDWNGrKPkZYPHL5iLILFLL4dTOb9WSJStSNpjd4MdaXScgFfEj4DCYwapANOtWwGWUGufRxYYWd7DAgvUPkUPsNwb3FRrp4zuTucHPTbPpXTvemTAC44sQw0jfh7ptJ50bmXQlJaUwO4UC4b23cN4MUfWFD2SXJYLqsHR3htFtIgVrphBlStoduocLO3qp+GZDoxwFLIfBJyjpzlRYzlGcKq36NU+9MO30rUxeh2a/2rrI/GIexjFqJRY02GS1kWmn+6bgIDVZGo8ujO3kMPGetGJwSExCLEpQitGxouScjwOv6mhtu6T1zp3/fCAteCdtLUaotxsGgGlt6DlCcAVlpVRovW3NFcDZmFHMtN2krQPs1Yy+xMWpyScc/TjVJOAMN3ESuciBg3U4xeBMWx3SoCQLs7g9BIAq7s/8RfWP3hFjrK0gS2FCAK9/jYv4wRXEigDX3f+e82p3tGQI9hFJn9b0SkDy2SwBgPJqeFhUvfwNs0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(30864003)(110136005)(52536014)(6636002)(508600001)(66946007)(66556008)(66476007)(64756008)(8936002)(316002)(76116006)(86362001)(9686003)(66446008)(5660300002)(83380400001)(8676002)(26005)(122000001)(55016003)(7696005)(53546011)(186003)(38100700002)(2906002)(921005)(71200400001)(33656002)(6506007)(38070700005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ne3cWcWZox8G3kVfsQKq/xfO3gEybhv9/LwqjoBw++Y5UbyAvxeN4UIMNmH5?=
 =?us-ascii?Q?XC1aKeqKS1aTbxUADrymjsLEsfiaRWITXBE6x37AEPk1q+GqitCrar9yRyu6?=
 =?us-ascii?Q?K/qXHfQA9sbFI+HJ8p/dfAmFWcExprqHZopqLIBxVuoldL70pGdOdI60671r?=
 =?us-ascii?Q?aKTFuuTaMF4uewh9Xue8vXpiyhndPt9pzGWILT3tMlCzJ7jnnVQ6Lw3gvXmD?=
 =?us-ascii?Q?eweljBjjW86AWoKI614hHWxu26f5U6H3OHCTwdAwgFSF2tySYAIbpCXdN1D4?=
 =?us-ascii?Q?MJsyRXUTciXGpSv1jNkHWtBN3lIwo2Bd63Qkq7DVgWKXliUeUJsfx1IZZtcC?=
 =?us-ascii?Q?c1NheQGB9dgmlL+6AqwPsOeD/t61KrAwB3eCl5frcSYp8ZZipUz6VKkT7qBh?=
 =?us-ascii?Q?mibIl88noAt9t4CC/MKaShNP+I/HId9ClaibsWq4HufLvxmETfOsZFHyuzWp?=
 =?us-ascii?Q?lmcwegiiz+NakFdejY2rUX7Fymnbs4Qx8Jw460mXAWln3C6mGnNmQGU9l15+?=
 =?us-ascii?Q?TRm6ZkdMqSDVuYAQgMxbGeGBgN6vKgBTrJ7n47XF9SHVB0RjqgwxHslx2xFD?=
 =?us-ascii?Q?m82y88EZ2g8wIibzuNrM1gMrSNjkWuvx/Aq5PEIG03f4bgYvZ3MXAKGn0bBi?=
 =?us-ascii?Q?pUyvjS/ZYT1Ts2hFOLeek+lfS0DorDUjeeiQUDksab5nWD/axgD3md3Tk8l6?=
 =?us-ascii?Q?2djsXhzUEEw185Yvkhoc8FqPcfzUJkr6rbwuHvPMwUZaZyMtagcUHNJat1G1?=
 =?us-ascii?Q?Qg9KULqjz4EbIWLBQOVpUegmCEiTFcR5Ua87+D0l5hblVm8D5JVa0XQZnuRS?=
 =?us-ascii?Q?ws0xIzhyLRlBa4eGO2x3Teo6nsrhHjb7+WOPixQeqToxPsXa45vkngoNNyO1?=
 =?us-ascii?Q?vn9HXYDjguE8imxDQpDk0jo37IbH/I0QRn+Ulsuus1xsCJndekafSJBgd7oa?=
 =?us-ascii?Q?8fDzY0eZi0vdiDa3xYZ2Y2guItQmrlIiJtmRb9qLG+tuy4h0aCC4zQtsaR86?=
 =?us-ascii?Q?3Zl9ilwalm0/YWC/XbbHgp3t/0fHIky14XpavRAezGRbfg8yxVJCqhrWq++q?=
 =?us-ascii?Q?uiYD0TB3tJLIcltCPOaOeCBW8KJRDOthtM/FohISeLGR0A2D6SoVHGgwRONk?=
 =?us-ascii?Q?EWCQ/BSExXwLMQ5Ngsy+yvSomPUZKa0T51EAeMIfnuOabh+sTZelAJRICTcW?=
 =?us-ascii?Q?c1u3jpr47Tfp0nIxgGSR2KZCILIahm+mdCgvv4EN98EpWcVaVSl3PNQfpNYe?=
 =?us-ascii?Q?tnTTUjdHh2QuXaC5UNFV3C2U+YdFhnR/2LNJVeawYp+vgOFS9zVJHKXIt8nM?=
 =?us-ascii?Q?mCxlK4qEsLsq3eD2Pnj4K2J0O3m1ZxvsZkvImQ4Q4vu/91snmn7oN2RjDuya?=
 =?us-ascii?Q?EKl7AC2OuCcQFmaSWmqcz5/0ogRSiqS4QDoyszEmEy3bGGiDK6geljcdiG/S?=
 =?us-ascii?Q?V5M7+wgJm4NaP2zs/N73qmqQqPUxyoOs0nMZcRq9aeSA//4W8oDLm+0re/Uw?=
 =?us-ascii?Q?3I1GgnwwXVTtwcdYNn/HwhuDfvwpGs3yAAuEnlp4FHOvQclm5gsxjkbe+jJ9?=
 =?us-ascii?Q?J3jGVwkZR1XtiAQxinw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3cff32-8580-42d5-e7d6-08d9e20ef928
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 03:33:38.6637 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lm9qvDo5t47La6+e2m+dAdFBy0dNRVsa4/5LkeCV/dC+qrBEOBV5G+zcX7h+1Vrg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3819
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

[AMD Official Use Only]

Ping...

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, January 26, 2022 7:05 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>; Clements, John <John.Clements@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH] drm/amdgpu: add umc_convert_error_address to simplify
> code
>=20
> Make code reusable and more simple.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 94 +++++++++------------------
> drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 82 +++++++++--------------
>  2 files changed, 61 insertions(+), 115 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 47452b61b615..4abcdda42ac6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -114,21 +114,13 @@ static void
> umc_v6_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
>  	}
>  }
>=20
> -static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device
> *adev,
> -					 struct ras_err_data *err_data,
> -					 uint32_t ch_inst,
> -					 uint32_t umc_inst)
> +static void umc_v6_7_convert_error_address(struct amdgpu_device *adev,
> +					struct ras_err_data *err_data, uint32_t
> ch_inst,
> +					uint32_t umc_inst, uint64_t err_addr,
> +					uint64_t mc_umc_status)
>  {
> -	uint64_t mc_umc_status, err_addr, soc_pa, retired_page, column;
>  	uint32_t channel_index;
> -	uint32_t eccinfo_table_idx;
> -	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> -
> -	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
> -	channel_index =3D
> -		adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num + ch_inst];
> -
> -	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
> +	uint64_t soc_pa, retired_page, column;
>=20
>  	if (mc_umc_status =3D=3D 0)
>  		return;
> @@ -136,12 +128,13 @@ static void
> umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
>  	if (!err_data->err_addr)
>  		return;
>=20
> +	channel_index =3D
> +			adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num +
> +ch_inst];
> +
>  	/* calculate error address if ue/ce error is detected */
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
>  	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)) {
> -
> -		err_addr =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
>  		err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
>=20
>  		/* translate umc channel address to soc pa, 3 parts are included
> */ @@ -173,6 +166,23 @@ static void
> umc_v6_7_ecc_info_query_error_address(struct amdgpu_device *adev,
>  	}
>  }
>=20
> +static void umc_v6_7_ecc_info_query_error_address(struct amdgpu_device
> *adev,
> +					 struct ras_err_data *err_data,
> +					 uint32_t ch_inst,
> +					 uint32_t umc_inst)
> +{
> +	uint64_t mc_umc_status, err_addr;
> +	uint32_t eccinfo_table_idx;
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
> +	err_addr =3D ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
> +
> +	umc_v6_7_convert_error_address(adev, err_data, ch_inst, umc_inst,
> +			err_addr, mc_umc_status);
> +}
> +
>  static void umc_v6_7_ecc_info_query_ras_error_address(struct amdgpu_devi=
ce
> *adev,
>  					     void *ras_error_status)
>  {
> @@ -348,9 +358,7 @@ static void umc_v6_7_query_error_address(struct
> amdgpu_device *adev,
>  					 uint32_t umc_inst)
>  {
>  	uint32_t mc_umc_status_addr;
> -	uint32_t channel_index;
> -	uint64_t mc_umc_status, mc_umc_addrt0;
> -	uint64_t err_addr, soc_pa, retired_page, column;
> +	uint64_t mc_umc_status, mc_umc_addrt0, err_addr;
>=20
>  	mc_umc_status_addr =3D
>  		SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_STATUST0); @@ -358,54 +366,10 @@ static
> void umc_v6_7_query_error_address(struct amdgpu_device *adev,
>  		SOC15_REG_OFFSET(UMC, 0,
> regMCA_UMC_UMC0_MCUMC_ADDRT0);
>=20
>  	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> umc_reg_offset) * 4);
> +	err_addr =3D RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
>=20
> -	if (mc_umc_status =3D=3D 0)
> -		return;
> -
> -	if (!err_data->err_addr) {
> -		/* clear umc status */
> -		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4,
> 0x0ULL);
> -		return;
> -	}
> -
> -	channel_index =3D
> -		adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num + ch_inst];
> -
> -	/* calculate error address if ue/ce error is detected */
> -	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> -	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
> -	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)) {
> -
> -		err_addr =3D RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) *
> 4);
> -		err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> -
> -		/* translate umc channel address to soc pa, 3 parts are included
> */
> -		soc_pa =3D ADDR_OF_8KB_BLOCK(err_addr) |
> -				ADDR_OF_256B_BLOCK(channel_index) |
> -				OFFSET_IN_256B_BLOCK(err_addr);
> -
> -		/* The umc channel bits are not original values, they are hashed
> */
> -		SET_CHANNEL_HASH(channel_index, soc_pa);
> -
> -		/* clear [C4 C3 C2] in soc physical address */
> -		soc_pa &=3D ~(0x7ULL << UMC_V6_7_PA_C2_BIT);
> -
> -		/* we only save ue error information currently, ce is skipped */
> -		if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
> -				=3D=3D 1) {
> -			/* loop for all possibilities of [C4 C3 C2] */
> -			for (column =3D 0; column <
> UMC_V6_7_NA_MAP_PA_NUM; column++) {
> -				retired_page =3D soc_pa | (column <<
> UMC_V6_7_PA_C2_BIT);
> -				amdgpu_umc_fill_error_record(err_data,
> err_addr,
> -					retired_page, channel_index, umc_inst);
> -
> -				/* shift R14 bit */
> -				retired_page ^=3D (0x1ULL <<
> UMC_V6_7_PA_R14_BIT);
> -				amdgpu_umc_fill_error_record(err_data,
> err_addr,
> -					retired_page, channel_index, umc_inst);
> -			}
> -		}
> -	}
> +	umc_v6_7_convert_error_address(adev, err_data, ch_inst, umc_inst,
> +				err_addr, mc_umc_status);
>=20
>  	/* clear umc status */
>  	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> index de85a998ef99..df15b87ae12b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> @@ -115,21 +115,13 @@ static void
> umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
>  	}
>  }
>=20
> -static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device
> *adev,
> -					struct ras_err_data *err_data,
> -					uint32_t ch_inst,
> -					uint32_t umc_inst)
> +static void umc_v8_7_convert_error_address(struct amdgpu_device *adev,
> +					struct ras_err_data *err_data, uint32_t
> ch_inst,
> +					uint32_t umc_inst, uint64_t err_addr,
> +					uint64_t mc_umc_status)
>  {
> -	uint64_t mc_umc_status, err_addr, retired_page;
> -	uint32_t channel_index;
> -	uint32_t eccinfo_table_idx;
> -	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> -
> -	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
> -	channel_index =3D
> -		adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num + ch_inst];
> -
> -	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
> +	uint32_t lsb, channel_index;
> +	uint64_t retired_page;
>=20
>  	if (mc_umc_status =3D=3D 0)
>  		return;
> @@ -137,13 +129,16 @@ static void
> umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
>  	if (!err_data->err_addr)
>  		return;
>=20
> +	channel_index =3D
> +			adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num +
> +ch_inst];
> +
>  	/* calculate error address if ue/ce error is detected */
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
>  	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)) {
> -
> -		err_addr =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
> +		lsb =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, LSB);
>  		err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> +		err_addr &=3D ~((0x1ULL << lsb) - 1);
>=20
>  		/* translate umc channel address to soc pa, 3 parts are included
> */
>  		retired_page =3D ADDR_OF_4KB_BLOCK(err_addr) | @@ -157,6
> +152,22 @@ static void umc_v8_7_ecc_info_query_error_address(struct
> amdgpu_device *adev,
>  					retired_page, channel_index, umc_inst);
>  	}
>  }
> +static void umc_v8_7_ecc_info_query_error_address(struct amdgpu_device
> *adev,
> +					struct ras_err_data *err_data,
> +					uint32_t ch_inst,
> +					uint32_t umc_inst)
> +{
> +	uint64_t mc_umc_status, err_addr;
> +	uint32_t eccinfo_table_idx;
> +	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
> +	err_addr =3D ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
> +
> +	umc_v8_7_convert_error_address(adev, err_data, ch_inst, umc_inst,
> +				err_addr, mc_umc_status);
> +}
>=20
>  static void umc_v8_7_ecc_info_query_ras_error_address(struct amdgpu_devi=
ce
> *adev,
>  					void *ras_error_status)
> @@ -330,9 +341,8 @@ static void umc_v8_7_query_error_address(struct
> amdgpu_device *adev,
>  					 uint32_t ch_inst,
>  					 uint32_t umc_inst)
>  {
> -	uint32_t lsb, mc_umc_status_addr;
> -	uint64_t mc_umc_status, err_addr, retired_page, mc_umc_addrt0;
> -	uint32_t channel_index =3D adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num + ch_inst];
> +	uint32_t mc_umc_status_addr;
> +	uint64_t mc_umc_status, err_addr, mc_umc_addrt0;
>=20
>  	mc_umc_status_addr =3D
>  		SOC15_REG_OFFSET(UMC, 0,
> mmMCA_UMC_UMC0_MCUMC_STATUST0); @@ -340,38 +350,10 @@ static
> void umc_v8_7_query_error_address(struct amdgpu_device *adev,
>  		SOC15_REG_OFFSET(UMC, 0,
> mmMCA_UMC_UMC0_MCUMC_ADDRT0);
>=20
>  	mc_umc_status =3D RREG64_PCIE((mc_umc_status_addr +
> umc_reg_offset) * 4);
> +	err_addr =3D RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) * 4);
>=20
> -	if (mc_umc_status =3D=3D 0)
> -		return;
> -
> -	if (!err_data->err_addr) {
> -		/* clear umc status */
> -		WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4,
> 0x0ULL);
> -		return;
> -	}
> -
> -	/* calculate error address if ue/ce error is detected */
> -	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
> -	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
> -	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)) {
> -
> -		err_addr =3D RREG64_PCIE((mc_umc_addrt0 + umc_reg_offset) *
> 4);
> -		/* the lowest lsb bits should be ignored */
> -		lsb =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, LSB);
> -		err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
> -		err_addr &=3D ~((0x1ULL << lsb) - 1);
> -
> -		/* translate umc channel address to soc pa, 3 parts are included
> */
> -		retired_page =3D ADDR_OF_4KB_BLOCK(err_addr) |
> -				ADDR_OF_256B_BLOCK(channel_index) |
> -				OFFSET_IN_256B_BLOCK(err_addr);
> -
> -		/* we only save ue error information currently, ce is skipped */
> -		if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC)
> -				=3D=3D 1)
> -			amdgpu_umc_fill_error_record(err_data, err_addr,
> -					retired_page, channel_index, umc_inst);
> -	}
> +	umc_v8_7_convert_error_address(adev, err_data, ch_inst, umc_inst,
> +					err_addr, mc_umc_status);
>=20
>  	/* clear umc status */
>  	WREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4, 0x0ULL);
> --
> 2.17.1
