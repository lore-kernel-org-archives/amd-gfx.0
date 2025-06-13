Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77917C71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 04:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE2D10E2D3;
	Fri, 13 Jun 2025 04:00:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VAwv5Ax9";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E9210E18D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 04:00:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oObmxqij01lRr6/0v17pdiJJXox7K2ZxIUMsx9SS4e2qwHTha0T4qJCQAvEEZ+s8VpJ8NXjLpRBpoyAmgSUtpik82VARkto5wJV/gZnlaHqJr7rbLhWvYYXziMTumQQUtRfJKQpMdbhmClXMWEno822Rov/BlrxEWtxlVof9uDcpK5bkPC0Lwejp9t07UhtjoaMfdFF/HFh1l9+cfuwzPtVbA38QUKPMaxJq4rI30xHmmNshmlgJuhRYaRuot1DTrEHd7P2pYJo8I5yAULiuoxwRPuNxey7xmQVwrTB/u0WvIi8NUIG77bSfPFhTEanFXPPaBnG32UFv6phCyYGyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd0tqWKWTVAjdgNXW531PkROGdLnvtZf54Q/nE9FGD8=;
 b=dsBsZb49n965BuK7It6e+mq5vQb6DNCJHpgIRH4Pu1W0hzeLjRLVF37T8upcavtoFdzJ6DvfBRRGkajxzKR0xDVimNZBx0ruuokuKaFAZAF+8kEjdN3h798+Q1gIsx8WlTZ65ObJ2tWPxMcXRunLIDz5b81qGnz2dkczkFN+t3vpM/dJaxqNBNywY2eDoI1feu7WfD9gnchTVUTU09uFA3p0HR5Ixrei94XoAM5QJ4AVg1uvAGQxtE0YWs20CdjF+Zclbik9wVRYZ41CJZopl79ycXAS9QQ2p6nWGiusP60cLr7BMQgkIK75fVS5dCVJAVIc1DM/lNgsMrwnOa53fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd0tqWKWTVAjdgNXW531PkROGdLnvtZf54Q/nE9FGD8=;
 b=VAwv5Ax984uQMcxEGEddFrntSMwrTS5xgxXXDZD1+ooRF4N/H7M8+OaA1ZjIdTRmvRr/wjdfEneQgMjM2pwF2vxwxC9d3b5oFqbWBXvWqf8IwBIDXuyyq8zfvFkBVuL/raPaD2FjniExLiAG6fg/BYzTi6UI4BpKf4+7gdK0I5E=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 04:00:40 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 04:00:40 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Thread-Topic: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Thread-Index: AQHb3BBEuOXqcKb+yEKFoxjA/QcGIrQAdvvw
Date: Fri, 13 Jun 2025 04:00:40 +0000
Message-ID: <PH7PR12MB8796213E4755D119062FC86EB077A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250613030636.188030-1-ganglxie@amd.com>
In-Reply-To: <20250613030636.188030-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-13T03:59:26.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA3PR12MB9197:EE_
x-ms-office365-filtering-correlation-id: d0758f75-f7a5-4d9e-f9cf-08ddaa2edc99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jkqI5ogd3CCmlVhyLgxmhBcq1Y3Byw2ZejhEqp6Casv8J/Y+U2QHItuoMG7H?=
 =?us-ascii?Q?Q/rU5MSlo9x8/FlgmzOqqHI+O1M/DFiRuwAPrgGTvmiLjr9F0EW/cTc33ZVO?=
 =?us-ascii?Q?qfASBvcrFoFXlRs8D2gMZImX3U1NnYlu7t5KM0ipP3HUFYMnWHjzjdCGxB3m?=
 =?us-ascii?Q?+I+wAlpckPOqYJyJN+2Uml7GivF43H0s+SLSnuhYFUbOUUNblAmhxUXRdL/o?=
 =?us-ascii?Q?0H1bcTFz6qIOgkhANtZdwv8hWCK2GAst4XsjHC1jfXyz+wSpidrDz3Fvgs0S?=
 =?us-ascii?Q?0sEUyjJ8NxsuNWhmCbtvCfOKEGRDZ0XxuMYKZRkXiXQigYRz20ufEhDpKXX1?=
 =?us-ascii?Q?gsVlj1qSSQ/Ul/sxhMvHC3hC9AtGWJdsovllQqBXe2w6yN6FQRibVnRcM6Y6?=
 =?us-ascii?Q?5JslO4g00uFVqTu3JXuci0It1eoPle1cDmmboteWfRlFN5m0OSg1xqQh4IpI?=
 =?us-ascii?Q?0ncnNURZ6h4A6f+UuZ1YjZtQQRHMLC8d+2X4otSNzmHTKoNk8O2LGOow92PV?=
 =?us-ascii?Q?euLTT2ZGVTZlSIiFOrp5qAEyNRi5KqgLYaWD6NJLTLkwBXg6N/95ExDLK/uC?=
 =?us-ascii?Q?L7WYdd3BNhJt+RcXdrWWaS9xcDV9TLHVLsuBrlbx4c0jnnRWAN8ZKijT7wXx?=
 =?us-ascii?Q?qjVdD2tfJUtdiCs4xVabi8MsHdDFsuEBk4BoI4Hf/abVEq55ZWL3MHbqswgT?=
 =?us-ascii?Q?2SC9qTgL4FeWh6QySSo0CHU3gPNXQxFaPWT9aY7RuiTnJATiFIbOxZ1e5HTc?=
 =?us-ascii?Q?mTiBfA+qRUwbSvAPz0hK/1NwabHP6M1hpulFDh/5de5zU97ONCHUb8gOD1aM?=
 =?us-ascii?Q?LKwEKQW31ZFZq2O0clxK6PgFajF2Gs+lY1rSXs42L0BHUgO5vTtvMl3C5vGm?=
 =?us-ascii?Q?G/2mzJuo8qQtcC9vXmJSniBseX3vqxwcC9seR61iTp/s9Ln68jVypSLlBWoY?=
 =?us-ascii?Q?QMylfMiKhYYXDKACqCYsp3JSXAZFQCsOE2CRcThUG3PQjwlJYwePm5vwd/Ie?=
 =?us-ascii?Q?Ubtbvio/8mTIKmgsTMlfgY4KhstDCohMG2p/OmzuLSV/i+4ebjbR4RV5d+sU?=
 =?us-ascii?Q?7nw/T/QLPZV5CEbGRRbDehXidlzrcjqSR/xx2fa1J7vUNdxuDghhwwuoTWR2?=
 =?us-ascii?Q?TP0TkX1N/ikZtY+iYQB3K1K3tGNMUoO7h1j5c24Xg7weXAFTOPYdjwZ/qRIt?=
 =?us-ascii?Q?ygz9pOol2dnmKKVv0l245E3Zknlv2x9ia/7YCAWEyHLRGy8C1B2pRr9gw9Xm?=
 =?us-ascii?Q?EYcfpbBL8QuBCYSZqQIIMgEQ4R+amY1qVzV8ZjdWq9KFnOGzV7MBK2vuGzXY?=
 =?us-ascii?Q?xfkt6u6FxzNSVPrdI44CN7kOrrANVvcy2q3xML4OsdaDMPcNvU0b+t+xP1zv?=
 =?us-ascii?Q?UzVZXDrGk0mD34s/zuW/29/Jlp1KKiO4APkLJUAKQ8QuI60hh2JIHZkdx2Br?=
 =?us-ascii?Q?nro5ZgNf9JtlpcY5wAOF6p+XlEo7aDUH1Sq0dqGbTOxSGQE70y/oIxSInr9k?=
 =?us-ascii?Q?N6MxPhHtt6y1huo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Obq15uveUDzAjHP6HF63abZDfpCYEUJuzJGYX5o3wSNXpE05LTy4mdmYSZXn?=
 =?us-ascii?Q?3K4r3Hb/p6azliputtKcQfpVqVo8pBZ0yYbhaCIcQ94hfY8F5yDkPUcL4LWL?=
 =?us-ascii?Q?ez9EVmlgYn12JNhvb1nRuUUSNc129kAFMJBnhFnOqneMrVVcROxXKDd0iUeP?=
 =?us-ascii?Q?nnD6OQHOEdfruFnHkA6iH9HqN6m9McP3yDYBj34/onzyNL5q0T6h7pcN+CFL?=
 =?us-ascii?Q?OMVVCzsyCTnsAoUbOr7qfTdDzVI7BQj9e+xOvBMyl4qA9lVs2wMRkfXKPvqm?=
 =?us-ascii?Q?TtJXKO2l538193YY+IhGCUpR4yr33uO+bDui7dctAiTOvfnhZvJhlwjg0opG?=
 =?us-ascii?Q?um7UZYKonIjxiC0CbNaom7CvBwPhu5R8J6BarIwTCgenqu6behmPKyQMa6FX?=
 =?us-ascii?Q?YG+3gFyxjSfeiE6SbII0YhbRjSd+SnOc77mHEBEzKtcMRwSAw+Le5Fg+Hoye?=
 =?us-ascii?Q?5DqNr4dsTK9FY0jhJ8WKudaPq/5HtJI4Kvu/mODZBd/cwp+jCQQWFmdvMlSN?=
 =?us-ascii?Q?6mCYjfOxDZGwB1iCdb2hol7Vb4WB2AcvV1KPEAA9QpgHOkBdDvCFIlBeTZAU?=
 =?us-ascii?Q?j2PfLnCgzp6XdSOyDNpKys4CaY1FSE28dux4NLPEUCS2104iV/z4lJLuJdsD?=
 =?us-ascii?Q?iIYyzMRCCiEimmP/jdox6umRhuV7OZ/kZcSQth3yuVAP0JXltQqR1cgvkDSN?=
 =?us-ascii?Q?bszwJANqDOb7ztHj9OmgyqA5Z7uBP7uFxRGLEfGBDetRi6xJmaiv9mTWXSJk?=
 =?us-ascii?Q?KS2BBKcvxYOw9O3bdzC9Pa5goGTuUs5Bx1uDn5F8dF5ds6T2KHe45P0n4VEe?=
 =?us-ascii?Q?MUhEqwPNsaaBJw20Aujxi/gV1H3QFRMAoYfsXNRgIiv4jMh/mauLXDWCBSvM?=
 =?us-ascii?Q?N3BXA09jDo3FLZA5AKdw+wwHOJ+ZEaPVIYqxCprlk8V9FLtvNn6ToLuSps1m?=
 =?us-ascii?Q?x+3DkBgGsRX9J6mKm2nl749ErpUj1KeLcE6YAA6dSACUjn5aj08vpLcqhdTd?=
 =?us-ascii?Q?4Am6YJGurg2vd8ZpgcGyCOpSEH67TOf0y9HAeM8QE8ROnS3N7ykPaCf8VzYy?=
 =?us-ascii?Q?hkqF93EUP7ywrm272UV2d8kd7wTdRgLetG6eNI6uHncpfVtgHBPLfkMRLKmS?=
 =?us-ascii?Q?gFJJFmfY7XKFStugEnQTvgx3GWCsCfvNuUleiyn9oxLXEQ25ZMJJqsgP1V0J?=
 =?us-ascii?Q?rbqcHgsBxEIGJPStW7kP/sPrj2n85SqiezTmuMk3T8PFNtw6iNQ9j2nfl+kB?=
 =?us-ascii?Q?tWY3b/LCIx7ZuvW7pKmLOjUPzY+bGglSKr4C23wkTjljogeGKX+Gza/zqb/N?=
 =?us-ascii?Q?XUAiESmmQZ9nV4QEV1236eIpDRB/Tl7Tsbg/A1wEszHTDF2PFmDf8Nax2vXC?=
 =?us-ascii?Q?Zs8ZYE2GLNXL+tCwG0BgR89IOvSVSgPQuGnZplq9X/zezAzEXWxu1TMVVTyM?=
 =?us-ascii?Q?KQkr3BoHfUmBi8+ZwCTKzuapA/Oe6132yUp0jd/mAiSHRsRNMYQq044dbh/t?=
 =?us-ascii?Q?u+DJP62aga4ewJD+1ngT97kYdbuJh+gQ2aWNIV0mvTVpWnoc2lbp15z07kRq?=
 =?us-ascii?Q?aYE9KnuggUdyFYC16D0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0758f75-f7a5-4d9e-f9cf-08ddaa2edc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 04:00:40.2211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30Bc/xbwzMzRrrPUS8j90qz+9xdGJnrE2H4N9opLqGeQnIejgkQSKBO0iIUJAz9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
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

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Friday, June 13, 2025 11:07 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
>
> when amdgpu_bad_page_threshold =3D=3D -1 or -2, driver will issue a warni=
ng message
> when threshold is reached and continue runtime services.
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 21 +++++++++----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2ddedf476542..a9246c53bde9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -763,18 +763,17 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>               dev_warn(adev->dev,
>                       "Saved bad pages %d reaches threshold value %d\n",
>                       control->ras_num_bad_pages, ras-
> >bad_page_cnt_threshold);
> -             control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
> -             if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
> -                     control->tbl_rai.rma_status =3D
> GPU_RETIRED__ECC_REACH_THRESHOLD;
> -                     control->tbl_rai.health_percent =3D 0;
> -             }
> -
>               if ((amdgpu_bad_page_threshold !=3D -1) &&
> -                 (amdgpu_bad_page_threshold !=3D -2))
> +                 (amdgpu_bad_page_threshold !=3D -2)) {
> +                     control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
> +                     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_=
1) {
> +                             control->tbl_rai.rma_status =3D
> GPU_RETIRED__ECC_REACH_THRESHOLD;
> +                             control->tbl_rai.health_percent =3D 0;
> +                     }
>                       ras->is_rma =3D true;
> -
> -             /* ignore the -ENOTSUPP return value */
> -             amdgpu_dpm_send_rma_reason(adev);
> +                     /* ignore the -ENOTSUPP return value */
> +                     amdgpu_dpm_send_rma_reason(adev);
> +             }
>       }
>
>       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) @@ -1509,7
> +1508,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control
> *control)
>                               "RAS records:%d exceed threshold:%d\n",
>                               control->ras_num_bad_pages, ras-
> >bad_page_cnt_threshold);
>                       if ((amdgpu_bad_page_threshold =3D=3D -1) ||
> -                         (amdgpu_bad_page_threshold =3D=3D -2)) {
> +                             (amdgpu_bad_page_threshold =3D=3D -2)) {

[Tao] the replacement is unnecessary, with this fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>                               res =3D 0;
>                               dev_warn(adev->dev,
>                                        "Please consult AMD Service Action=
 Guide
> (SAG) for appropriate service procedures\n");
> --
> 2.34.1

