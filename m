Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53D3C38145
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 21:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A1710EB07;
	Tue,  6 Sep 2022 21:00:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5631B10E29D
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 21:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt4FjpbOxPxaJ2w1HU08OCmXGpdAlSe3Jd2gIhCNKQscaR82lNIAjiG+MyuugERktRqro+G3dlO78CPkLPISVQs01TLB3qCbPUZMkjm7ezMkup42b2aw1OpdUlD0MciDpkBq85ODJVqKek4KorpJWcJJyuIorgAtghHUQr0Z5XzOcofl7QZVQSM8n31wf3tdaYFFnudlmrdMBW6rMmT5kUiBJUp6AeETRcUJE/pnv8Wi0iATQJwGRuy2/GBBgLOJvA1YFCmtX20JdpbFjLFk3jfPPQGKNn2klz7tx+iYkIgiU14OwIgRGe3PkofjFawvM7s50Osu4TPmpYz9F5U/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cmgBiFHUk53JTpSlobJc9YaGS0HIQ8H01bjM3TVJEA=;
 b=Mvqad6Ex1Wlncs55WBwKHfMIo0fNxO4xhjA+60ClDcJczTGV/N1kqYVSgwm24kLekfaBHLnzXHWig+b5RSwMqO/5bgLasvJtYET2SQ8i6BTPPDiQ0utnSUUwzOoREQKm0vmXc4T9k5f0GjFBrFY63FsdLt8NjPKM431+lIt9OKWlYniyDxuIqMgitk8r811B6JM97vEv4drkwLz/te5JzB0mRDjQ9O+c5ioDT1k2oCdoxPuTiAlgz0rQnxQhgGTvC9oxfDSSKTT0z+qx4/Uy6rWFgi3/+tIEuCpOFYS4vferd4jFNXA6TSRURnzT0oBlm4RWLjNUmO81NKlJyWhuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cmgBiFHUk53JTpSlobJc9YaGS0HIQ8H01bjM3TVJEA=;
 b=MgukClXMF/3KHDgzDbZa4NNHKcRfFU5I2uD2NFPgEzI+R/YcZhKTijJFNyr2SzJGKpyVsU4fNi+qsOQUqyiM4JQazGfuQpw7V1yHTegXPQ0TNJGYDv4ewrBNN7O4Qsbl/mbr+1OIebOQh5FZYdB3E80gJg+gGNfPY4UYl4QBtEw=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 21:00:31 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::cd37:1141:7fec:389d]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::cd37:1141:7fec:389d%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 21:00:31 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Fix register definitions for DCN32/321
Thread-Topic: [PATCH] drm/amd/display: Fix register definitions for DCN32/321
Thread-Index: AQHYvjjs61BKmokVckGzGBkpNmngSq3SliGAgABUrOE=
Date: Tue, 6 Sep 2022 21:00:30 +0000
Message-ID: <CH0PR12MB5284EA20465E2D4EAE88B9DA8B7E9@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20220901192736.1171423-1-aurabindo.pillai@amd.com>
 <80e61ba2-e888-9ecd-d32b-5abff09a5d02@amd.com>
In-Reply-To: <80e61ba2-e888-9ecd-d32b-5abff09a5d02@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-06T21:00:30.491Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8e38477-6d70-4cc6-b07c-08da904ad580
x-ms-traffictypediagnostic: DM6PR12MB4562:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Cx490eRC+w6CiAmJwE4d9Y+LTbzjN53xoqVoRwgEFRbcnLY+NTTk/lqw89DWNFxXxKf1IGKCVlbcQHjXMUIiOGGyE+RXKKQIQY/rMLyeXFl25sRmga2pbqZt8yRXsxZ9DlpaRIFP48klJoWiKXy6/SXSn7mLI3yPtmTASHIw6YaLe3JvU13IibJbhf8erN+TABPRrQbIappg/2bXg9yBSbgGTfHZ9ZE01XLP8XlHFfOCH9O4KMR8bnFdWKbv40/rlRNVd4QHBPXGFOUCtJAA1NPw31ll9bUjRQLFrf2V99HR3kUm2Pzl3QljY6LHi7utrnLe3nmMi+3mGd4YBKBec+u4irmP+Dev4AzAqjJiXydnAq0QmjMb1Lq+WhK63j/u12hXAXr347RKXA6vrrsEy0aQVXDr2JDlAwqI7dlP1c6euttG076GJClGOTiSO0k0wZ3T8/EtOhD+oyVAieU3rl6ddKEDp6j+JVGxiVEz5VMqN1UfJqEkklATFhiwbUH3ap+lwo8jFYHHln9pyHrnLhHEcm0aBGbrWEXmsZ5uHYnDQwKM9nweu6v30IMP0/SITp9xqqD0ZN2Etnjz2v0X4b6SbNARcEx4bfFkBgggO77ybLspkOpMrIA6Yesea81A94PTpHAP/F+gmUEftdvoGF/OzsI2t1ToXIjVHSMoPn+ISyFqaXH2MbkIt7rmmyY0DQWOY9cr5VJ4u4GwVz4FU/WxyvxuCLi/a38oia4hTfrPesLSsS2m78TRbe4LcNgDCxdbUBJ/jWfBM0mCTiToA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(26005)(19627405001)(86362001)(6506007)(66446008)(76116006)(54906003)(4326008)(8676002)(66476007)(7696005)(478600001)(91956017)(66946007)(66556008)(64756008)(53546011)(186003)(2906002)(55016003)(33656002)(41300700001)(71200400001)(9686003)(5660300002)(30864003)(52536014)(316002)(83380400001)(8936002)(110136005)(38100700002)(38070700005)(122000001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?taPMWLZjbRaHBNzuB+11OUZRPJUKhLVlcvIXHxV2HPuKT0TgGlgxQlivtsmE?=
 =?us-ascii?Q?63QwN9hakjWMEp2x/Gh65JvgeD4+56lcPngPsJa7HeDUH8ebEq3cbUGKVA5K?=
 =?us-ascii?Q?6tmw7I27FbmWmPX+q3y4AWAXY82VohUkRxCCtpdnPPEKHYVHrU2emkWKOdAT?=
 =?us-ascii?Q?a4kpKb2PkICh2rBhDfwqRVcOjK0us19J3Ob/DlVY4JJJj2EyRFw2vJFoPpef?=
 =?us-ascii?Q?MZrNwU3bRpZI4Dl9VvuM4q6TW/SFPBJGlyzss/6ptv02CAMSYV61nWEzPRqg?=
 =?us-ascii?Q?StU23wIN7h68MDXmCOYCXi1dNuDPKuQEvLdzb4hFsZcyKXFigR1PTznHFDk2?=
 =?us-ascii?Q?M7uK5Tr3QfEXoLWDUrlnmyhAyjPE18h+cCL/4KaPu1RJrqrL1am4Pdsf8uuU?=
 =?us-ascii?Q?QQA+UHLA+azrBLZf/p4GdoVgir/J1d5NC/uIbaecXP0qcSdydPd365zUYv00?=
 =?us-ascii?Q?8jkPgve61AT0rSZMAI8q3mjXZb2Jds6LjOPYZDJCjcZbtsd/ObYcTHH79dA6?=
 =?us-ascii?Q?buucD6QV/vwt/GuncGBshww/3xSz/GN+iGZLMQpBYsA8hXpR3fyrWulqVrlB?=
 =?us-ascii?Q?+WG4nuE3bV3q6RrHc9P6sE5ae0v8CJfsYKfmDUyy0coF3GR3C81khLehppA6?=
 =?us-ascii?Q?f1M/vPKjCyUPydCVo+WY0WQR+7hr9/8V6SOvi567zdhMjkX21YrZHgFBwPzO?=
 =?us-ascii?Q?dZ+y4lsHOM1EKp0SoNk4MwHQ+VY7rEcDqErLik/L9rvlsLQt60bY4gUUhg3y?=
 =?us-ascii?Q?aup9Ce1J8JSwlXwsWrpvTY5iBTXNNgYuxZ2B9kJL3TATM8PAPpBnaHitu3hG?=
 =?us-ascii?Q?n8pQUaVS7SmYNYvOodEyyWIw3fdEyjuyaI3k4KRnPSzriODuuHpRj2oDTB0d?=
 =?us-ascii?Q?kWDUofjrVaBdiLalQ+U6hMhGhL6qCxHo+70aplpoyY3plm7Nb5dbFGYKyyEw?=
 =?us-ascii?Q?8ZdKf/l7T7ST7cEoP8LRLQ9NlAeeGN7p69ZIOTo6LEf0E1O0uUieEyRGKe2i?=
 =?us-ascii?Q?GOO0/+qN1WtkC1IX1LowFwOtoZNTof78je1c/yB7yc25snYKSA6Lec+PjPq+?=
 =?us-ascii?Q?gQsr5BV/oUiwyDjE2DRS5u5FIF8p8GNmCDmq9isQdSSFdLJI3gxmFjPxpdwJ?=
 =?us-ascii?Q?5eLwpzuzojiguL7Xiya0MehxPvXRCIPo6SAyDo24/5vIR9/PjUoEqNZZzfcN?=
 =?us-ascii?Q?wpa6da/RV+u1XehEPmjKvKqy19tZp5iF/7ckBTDbqM3G2wJVMNDd4IZdgGHW?=
 =?us-ascii?Q?3dp4otskPMTWBQDoDshhkPnrZ7fVAeFViJOAbFxSZ8CCSzb+vSViYHxTkSdt?=
 =?us-ascii?Q?DPqZoMSHmFAuRv+OuGtLk/eTF1WkohC58rIiGbBScnsPXRJm20nUMfnaYGgN?=
 =?us-ascii?Q?oCLFQQM+OKNLiJuS326trUQ3G38uKrg1wCVcs5vN4qOQsYO8gEiRVyJtlaub?=
 =?us-ascii?Q?pZ3ULeRN/A8e/SMz0rGUo7cSXScJFmDqpPnieZm43QClAflctNeWcmBljDSt?=
 =?us-ascii?Q?LBaLCww04PgxRMu3CfQChbHYOtgseGz6nKgU7HfBDOqOj0sABEwUFvNVF2xN?=
 =?us-ascii?Q?WiPQYgjG3UpVH8i68Hw=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284EA20465E2D4EAE88B9DA8B7E9CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e38477-6d70-4cc6-b07c-08da904ad580
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 21:00:30.9838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUvS/UBbjPdsEBpWz9UaDa8C+mll3Q1yJRC9SKgEjegnc6Gm6u1JFB843qXz6o15iHUrZZsGO3uWH8H9uBU5Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284EA20465E2D4EAE88B9DA8B7E9CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Thank you Siqueira.

--

Regards,
Jay
________________________________
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Tuesday, September 6, 2022 11:56 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix register definitions for DCN32/32=
1



On 2022-09-01 15:27, Aurabindo Pillai wrote:
> [Why & How]
> Fix the instatiation sequence for MPC registers and add a few other
> missing register definitions that were ommited erroneously when copying
> them over to enable runtime initialization of reigster offsets for
> DCN32/321
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   .../drm/amd/display/dc/dcn32/dcn32_resource.c |  27 +--
>   .../drm/amd/display/dc/dcn32/dcn32_resource.h | 216 ++++++++++++------
>   .../amd/display/dc/dcn321/dcn321_resource.c   |  24 +-
>   3 files changed, 166 insertions(+), 101 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index ef0a6d468a10..9d3b8568351e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -461,22 +461,17 @@ static const struct dcn20_dsc_mask dsc_mask =3D {
>   };
>
>   static struct dcn30_mpc_registers mpc_regs;
> -#define dcn_mpc_regs_init()\
> -             ( \
> -             MPC_REG_LIST_DCN3_0_RI(0),\
> -             MPC_REG_LIST_DCN3_0_RI(1),\
> -             MPC_REG_LIST_DCN3_0_RI(2),\
> -             MPC_REG_LIST_DCN3_0_RI(3),\
> -             MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
> -             MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
> -             MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
> -             MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
> -             MPC_MCM_REG_LIST_DCN32_RI(0),\
> -             MPC_MCM_REG_LIST_DCN32_RI(1),\
> -             MPC_MCM_REG_LIST_DCN32_RI(2),\
> -             MPC_MCM_REG_LIST_DCN32_RI(3),\
> -             MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)\
> -             )
> +
> +#define dcn_mpc_regs_init() \
> +     MPC_REG_LIST_DCN3_2_RI(0),\
> +     MPC_REG_LIST_DCN3_2_RI(1),\
> +     MPC_REG_LIST_DCN3_2_RI(2),\
> +     MPC_REG_LIST_DCN3_2_RI(3),\
> +     MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
> +     MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
> +     MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
> +     MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
> +     MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)
>
>   static const struct dcn30_mpc_shift mpc_shift =3D {
>        MPC_COMMON_MASK_SH_LIST_DCN32(__SHIFT)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/driv=
ers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> index 60d8fad16eee..4c931905223d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
> @@ -222,7 +222,8 @@ void dcn32_determine_det_override(struct dc_state *co=
ntext, display_e2e_pipe_par
>         SRI_ARR(DP_MSA_TIMING_PARAM4, DP, id),                           =
        \
>         SRI_ARR(DP_MSE_RATE_CNTL, DP, id), SRI_ARR(DP_MSE_RATE_UPDATE, DP=
, id),  \
>         SRI_ARR(DP_PIXEL_FORMAT, DP, id), SRI_ARR(DP_SEC_CNTL, DP, id),  =
        \
> -      SRI_ARR(DP_SEC_CNTL2, DP, id), SRI_ARR(DP_SEC_CNTL6, DP, id),     =
       \
> +      SRI_ARR(DP_SEC_CNTL1, DP, id), SRI_ARR(DP_SEC_CNTL2, DP, id),     =
       \
> +      SRI_ARR(DP_SEC_CNTL5, DP, id), SRI_ARR(DP_SEC_CNTL6, DP, id),     =
       \
>         SRI_ARR(DP_STEER_FIFO, DP, id), SRI_ARR(DP_VID_M, DP, id),       =
        \
>         SRI_ARR(DP_VID_N, DP, id), SRI_ARR(DP_VID_STREAM_CNTL, DP, id),  =
        \
>         SRI_ARR(DP_VID_TIMING, DP, id), SRI_ARR(DP_SEC_AUD_N, DP, id),   =
        \
> @@ -735,75 +736,6 @@ void dcn32_determine_det_override(struct dc_state *c=
ontext, display_e2e_pipe_par
>   #define MPC_DWB_MUX_REG_LIST_DCN3_0_RI(inst)                           =
        \
>     SRII_DWB(DWB_MUX, MUX, MPC_DWB, inst)
>
> -#define MPC_MCM_REG_LIST_DCN32_RI(inst)                                 =
       \
> -  ( \
> -  SRII(MPCC_MCM_SHAPER_CONTROL, MPCC_MCM, inst),                        =
       \
> -      SRII(MPCC_MCM_SHAPER_OFFSET_R, MPCC_MCM, inst),                   =
       \
> -      SRII(MPCC_MCM_SHAPER_OFFSET_G, MPCC_MCM, inst),                   =
       \
> -      SRII(MPCC_MCM_SHAPER_OFFSET_B, MPCC_MCM, inst),                   =
       \
> -      SRII(MPCC_MCM_SHAPER_SCALE_R, MPCC_MCM, inst),                    =
       \
> -      SRII(MPCC_MCM_SHAPER_SCALE_G_B, MPCC_MCM, inst),                  =
       \
> -      SRII(MPCC_MCM_SHAPER_LUT_INDEX, MPCC_MCM, inst),                  =
       \
> -      SRII(MPCC_MCM_SHAPER_LUT_DATA, MPCC_MCM, inst),                   =
       \
> -      SRII(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_B, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_G, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_R, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_B, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_G, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_R, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_2_3, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_4_5, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_6_7, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_8_9, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_10_11, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_12_13, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_14_15, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_16_17, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_18_19, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_20_21, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_22_23, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_24_25, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_26_27, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_28_29, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_30_31, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMA_REGION_32_33, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_B, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_G, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_R, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_B, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_G, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_R, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_0_1, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_2_3, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_4_5, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_6_7, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_8_9, MPCC_MCM, inst),            =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_10_11, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_12_13, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_14_15, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_16_17, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_18_19, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_20_21, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_22_23, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_24_25, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_26_27, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_28_29, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_30_31, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, inst),                        =
       \
> -      SRII(MPCC_MCM_3DLUT_INDEX, MPCC_MCM, inst),                       =
       \
> -      SRII(MPCC_MCM_3DLUT_DATA, MPCC_MCM, inst),                        =
       \
> -      SRII(MPCC_MCM_3DLUT_DATA_30BIT, MPCC_MCM, inst),                  =
       \
> -      SRII(MPCC_MCM_3DLUT_READ_WRITE_CONTROL, MPCC_MCM, inst),          =
       \
> -      SRII(MPCC_MCM_3DLUT_OUT_NORM_FACTOR, MPCC_MCM, inst),             =
       \
> -      SRII(MPCC_MCM_3DLUT_OUT_OFFSET_R, MPCC_MCM, inst),                =
       \
> -      SRII(MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM, inst),                =
       \
> -      SRII(MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM, inst),                =
       \
> -      SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, inst)                       =
       \
> -  )
> -
>   #define MPC_OUT_MUX_COMMON_REG_LIST_DCN1_0_RI(inst)                    =
        \
>     ( \
>     SRII(MUX, MPC_OUT, inst), VUPDATE_SRII(CUR, VUPDATE_LOCK_SET, inst)  =
        \
> @@ -887,6 +819,149 @@ void dcn32_determine_det_override(struct dc_state *=
context, display_e2e_pipe_par
>         SRII(MPCC_OGAM_LUT_CONTROL, MPCC_OGAM, inst)                     =
        \
>     )
>
> +#define MPC_REG_LIST_DCN3_2_RI(inst) \
> +     MPC_REG_LIST_DCN3_0_RI(inst),\
> +     SRII(MPCC_MOVABLE_CM_LOCATION_CONTROL, MPCC, inst),\
> +     SRII(MPCC_MCM_SHAPER_CONTROL, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_OFFSET_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_OFFSET_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_OFFSET_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_SCALE_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_SCALE_G_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_LUT_INDEX, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_LUT_DATA, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_2_3, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_4_5, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_6_7, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_8_9, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_10_11, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_12_13, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_14_15, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_16_17, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_18_19, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_20_21, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_22_23, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_24_25, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_26_27, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_28_29, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_30_31, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMA_REGION_32_33, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_0_1, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_2_3, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_4_5, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_6_7, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_8_9, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_10_11, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_12_13, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_14_15, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_16_17, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_18_19, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_20_21, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_22_23, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_24_25, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_26_27, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_28_29, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_30_31, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, inst), /*TODO: may need to add =
other 3DLUT regs*/\
> +     SRII(MPCC_MCM_3DLUT_INDEX, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_3DLUT_DATA, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_3DLUT_DATA_30BIT, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_3DLUT_READ_WRITE_CONTROL, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_3DLUT_OUT_NORM_FACTOR, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_3DLUT_OUT_OFFSET_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_CONTROL, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_LUT_INDEX, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_LUT_DATA, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_0_1, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_2_3, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_4_5, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_6_7, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_8_9, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_10_11, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_12_13, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_14_15, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_16_17, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_18_19, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_20_21, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_22_23, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_24_25, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_26_27, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_28_29, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_30_31, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMA_REGION_32_33, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_B, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_G, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_R, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_0_1, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_2_3, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_4_5, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_6_7, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_8_9, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_10_11, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_12_13, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_14_15, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_16_17, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_18_19, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_20_21, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_22_23, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_24_25, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_26_27, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_28_29, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_30_31, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_1DLUT_RAMB_REGION_32_33, MPCC_MCM, inst),\
> +     SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, inst)
> +
>   /* OPTC */
>
>   #define OPTC_COMMON_REG_LIST_DCN3_2_RI(inst)                           =
        \
> @@ -1121,6 +1196,7 @@ void dcn32_determine_det_override(struct dc_state *=
context, display_e2e_pipe_par
>         SR(DCHUBBUB_ARB_REFCYC_PER_TRIP_TO_MEMORY_D), SR(DCHUBBUB_DET0_CT=
RL),    \
>         SR(DCHUBBUB_DET1_CTRL), SR(DCHUBBUB_DET2_CTRL), SR(DCHUBBUB_DET3_=
CTRL),  \
>         SR(DCHUBBUB_COMPBUF_CTRL), SR(COMPBUF_RESERVED_SPACE),           =
        \
> +      SR(DCHUBBUB_DEBUG_CTRL_0),                                        =
       \
>         SR(DCHUBBUB_ARB_USR_RETRAINING_CNTL),                            =
        \
>         SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_A),                     =
        \
>         SR(DCHUBBUB_ARB_USR_RETRAINING_WATERMARK_B),                     =
        \
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> index a93dc00ebfb5..184997a5b464 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
> @@ -466,21 +466,15 @@ static const struct dcn20_dsc_mask dsc_mask =3D {
>
>   static struct dcn30_mpc_registers mpc_regs;
>   #define dcn_mpc_regs_init()\
> -             ( \
> -             MPC_REG_LIST_DCN3_0_RI(0),\
> -             MPC_REG_LIST_DCN3_0_RI(1),\
> -             MPC_REG_LIST_DCN3_0_RI(2),\
> -             MPC_REG_LIST_DCN3_0_RI(3),\
> -             MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
> -             MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
> -             MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
> -             MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
> -             MPC_MCM_REG_LIST_DCN32_RI(0),\
> -             MPC_MCM_REG_LIST_DCN32_RI(1),\
> -             MPC_MCM_REG_LIST_DCN32_RI(2),\
> -             MPC_MCM_REG_LIST_DCN32_RI(3),\
> -             MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)\
> -             )
> +     MPC_REG_LIST_DCN3_2_RI(0),\
> +     MPC_REG_LIST_DCN3_2_RI(1),\
> +     MPC_REG_LIST_DCN3_2_RI(2),\
> +     MPC_REG_LIST_DCN3_2_RI(3),\
> +     MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\
> +     MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\
> +     MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\
> +     MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\
> +     MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)
>
>   static const struct dcn30_mpc_shift mpc_shift =3D {
>        MPC_COMMON_MASK_SH_LIST_DCN32(__SHIFT)

LGTM,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

I asked Daniel to run a couple of tests with this patch. Let's wait for
his result before we merge it.

Thanks
Siqueira

--_000_CH0PR12MB5284EA20465E2D4EAE88B9DA8B7E9CH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
Thank you Siqueira.<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Siqueira, Rodrigo &lt=
;Rodrigo.Siqueira@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 6, 2022 11:56 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Deucher, Alexand=
er &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix register definitions for D=
CN32/321</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 2022-09-01 15:27, Aurabindo Pillai wrote:<br>
&gt; [Why &amp; How]<br>
&gt; Fix the instatiation sequence for MPC registers and add a few other<br=
>
&gt; missing register definitions that were ommited erroneously when copyin=
g<br>
&gt; them over to enable runtime initialization of reigster offsets for<br>
&gt; DCN32/321<br>
&gt; <br>
&gt; Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dcn32/dcn32_resource.c |&nbsp; 27 +=
--<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dcn32/dcn32_resource.h | 216 ++++++=
++++++------<br>
&gt;&nbsp;&nbsp; .../amd/display/dc/dcn321/dcn321_resource.c&nbsp;&nbsp; |&=
nbsp; 24 +-<br>
&gt;&nbsp;&nbsp; 3 files changed, 166 insertions(+), 101 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/d=
rivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c<br>
&gt; index ef0a6d468a10..9d3b8568351e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c<br>
&gt; @@ -461,22 +461,17 @@ static const struct dcn20_dsc_mask dsc_mask =3D =
{<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static struct dcn30_mpc_registers mpc_regs;<br>
&gt; -#define dcn_mpc_regs_init()\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ( \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_REG_LIST_DCN3_0_RI(0),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_REG_LIST_DCN3_0_RI(1),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_REG_LIST_DCN3_0_RI(2),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_REG_LIST_DCN3_0_RI(3),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_MCM_REG_LIST_DCN32_RI(0),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_MCM_REG_LIST_DCN32_RI(1),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_MCM_REG_LIST_DCN32_RI(2),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_MCM_REG_LIST_DCN32_RI(3),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; )<br>
&gt; +<br>
&gt; +#define dcn_mpc_regs_init() \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN3_2_RI(0),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN3_2_RI(1),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN3_2_RI(2),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN3_2_RI(3),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const struct dcn30_mpc_shift mpc_shift =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_COMMON_MASK_SH_LIST_DCN3=
2(__SHIFT)<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/d=
rivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h<br>
&gt; index 60d8fad16eee..4c931905223d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h<br>
&gt; @@ -222,7 +222,8 @@ void dcn32_determine_det_override(struct dc_state =
*context, display_e2e_pipe_par<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI_ARR(DP_MSA_TIMING_=
PARAM4, DP, id),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI_ARR(DP_MSE_RATE_CN=
TL, DP, id), SRI_ARR(DP_MSE_RATE_UPDATE, DP, id),&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI_ARR(DP_PIXEL_FORMA=
T, DP, id), SRI_ARR(DP_SEC_CNTL, DP, id),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI_ARR(DP_SEC_CNTL2, DP, id), SRI_ARR=
(DP_SEC_CNTL6, DP, id),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI_ARR(DP_SEC_CNTL1, DP, id), SRI_ARR=
(DP_SEC_CNTL2, DP, id),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI_ARR(DP_SEC_CNTL5, DP, id), SRI_ARR=
(DP_SEC_CNTL6, DP, id),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI_ARR(DP_STEER_FIFO,=
 DP, id), SRI_ARR(DP_VID_M, DP, id),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI_ARR(DP_VID_N, DP, =
id), SRI_ARR(DP_VID_STREAM_CNTL, DP, id),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI_ARR(DP_VID_TIMING,=
 DP, id), SRI_ARR(DP_SEC_AUD_N, DP, id),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; @@ -735,75 +736,6 @@ void dcn32_determine_det_override(struct dc_state=
 *context, display_e2e_pipe_par<br>
&gt;&nbsp;&nbsp; #define MPC_DWB_MUX_REG_LIST_DCN3_0_RI(inst)&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; SRII_DWB(DWB_MUX, MUX, MPC_DWB, inst)<br>
&gt;&nbsp;&nbsp; <br>
&gt; -#define MPC_MCM_REG_LIST_DCN32_RI(inst)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp; ( \<br>
&gt; -&nbsp; SRII(MPCC_MCM_SHAPER_CONTROL, MPCC_MCM, inst),&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_OFFSET_R, MPCC_MC=
M, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_OFFSET_G, MPCC_MC=
M, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_OFFSET_B, MPCC_MC=
M, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_SCALE_R, MPCC_MCM=
, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_SCALE_G_B, MPCC_M=
CM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_LUT_INDEX, MPCC_M=
CM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_LUT_DATA, MPCC_MC=
M, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_B=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_G=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_R=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_B, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_G, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_R, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_0_1, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_2_3, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_4_5, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_6_7, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_8_9, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_10_11=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_12_13=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_14_15=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_16_17=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_18_19=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_20_21=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_22_23=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_24_25=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_26_27=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_28_29=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_30_31=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_32_33=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_B=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_G=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_R=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_B, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_G, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_R, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_0_1, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_2_3, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_4_5, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_6_7, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_8_9, =
MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_10_11=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_12_13=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_14_15=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_16_17=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_18_19=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_20_21=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_22_23=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_24_25=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_26_27=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_28_29=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_30_31=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, in=
st),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_INDEX, MPCC_MCM, i=
nst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_DATA, MPCC_MCM, in=
st),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_DATA_30BIT, MPCC_M=
CM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_READ_WRITE_CONTROL=
, MPCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_OUT_NORM_FACTOR, M=
PCC_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_OUT_OFFSET_R, MPCC=
_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC=
_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC=
_MCM, inst),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, =
inst)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; -&nbsp; )<br>
&gt; -<br>
&gt;&nbsp;&nbsp; #define MPC_OUT_MUX_COMMON_REG_LIST_DCN1_0_RI(inst)&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; ( \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MUX, MPC_OUT, inst), VUPDATE_SRII(CUR, VU=
PDATE_LOCK_SET, inst)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 \<br>
&gt; @@ -887,6 +819,149 @@ void dcn32_determine_det_override(struct dc_stat=
e *context, display_e2e_pipe_par<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_OGAM_LUT_CON=
TROL, MPCC_OGAM, inst)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; )<br>
&gt;&nbsp;&nbsp; <br>
&gt; +#define MPC_REG_LIST_DCN3_2_RI(inst) \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN3_0_RI(inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MOVABLE_CM_LOCATION_CONTROL, MPCC,=
 inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_CONTROL, MPCC_MCM, inst=
),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_OFFSET_R, MPCC_MCM, ins=
t),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_OFFSET_G, MPCC_MCM, ins=
t),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_OFFSET_B, MPCC_MCM, ins=
t),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_SCALE_R, MPCC_MCM, inst=
),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_SCALE_G_B, MPCC_MCM, in=
st),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_LUT_INDEX, MPCC_MCM, in=
st),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_LUT_DATA, MPCC_MCM, ins=
t),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_LUT_WRITE_EN_MASK, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_B, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_G, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_START_CNTL_R, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_B, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_G, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_END_CNTL_R, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_0_1, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_2_3, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_4_5, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_6_7, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_8_9, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_10_11, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_12_13, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_14_15, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_16_17, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_18_19, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_20_21, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_22_23, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_24_25, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_26_27, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_28_29, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_30_31, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMA_REGION_32_33, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_B, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_G, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_START_CNTL_R, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_B, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_G, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_END_CNTL_R, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_0_1, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_2_3, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_4_5, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_6_7, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_8_9, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_10_11, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_12_13, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_14_15, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_16_17, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_18_19, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_20_21, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_22_23, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_24_25, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_26_27, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_28_29, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_30_31, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_SHAPER_RAMB_REGION_32_33, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_MODE, MPCC_MCM, inst), /=
*TODO: may need to add other 3DLUT regs*/\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_INDEX, MPCC_MCM, inst),\=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_DATA, MPCC_MCM, inst),\<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_DATA_30BIT, MPCC_MCM, in=
st),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_READ_WRITE_CONTROL, MPCC=
_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_OUT_NORM_FACTOR, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_OUT_OFFSET_R, MPCC_MCM, =
inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_OUT_OFFSET_G, MPCC_MCM, =
inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_3DLUT_OUT_OFFSET_B, MPCC_MCM, =
inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_CONTROL, MPCC_MCM, inst)=
,\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_LUT_INDEX, MPCC_MCM, ins=
t),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_LUT_DATA, MPCC_MCM, inst=
),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_LUT_CONTROL, MPCC_MCM, i=
nst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_B, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_G, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_START_CNTL_R, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_B,=
 MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_G,=
 MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_START_SLOPE_CNTL_R,=
 MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_B, =
MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_G, =
MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_START_BASE_CNTL_R, =
MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_B, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_B, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_G, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_G, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL1_R, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_END_CNTL2_R, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_B, MPCC_MCM,=
 inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_G, MPCC_MCM,=
 inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_OFFSET_R, MPCC_MCM,=
 inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_0_1, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_2_3, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_4_5, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_6_7, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_8_9, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_10_11, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_12_13, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_14_15, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_16_17, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_18_19, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_20_21, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_22_23, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_24_25, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_26_27, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_28_29, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_30_31, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMA_REGION_32_33, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_B, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_G, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_START_CNTL_R, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_B,=
 MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_G,=
 MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_START_SLOPE_CNTL_R,=
 MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_B, =
MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_G, =
MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_START_BASE_CNTL_R, =
MPCC_MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_B, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_B, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_G, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_G, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL1_R, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_END_CNTL2_R, MPCC_M=
CM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_B, MPCC_MCM,=
 inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_G, MPCC_MCM,=
 inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_OFFSET_R, MPCC_MCM,=
 inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_0_1, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_2_3, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_4_5, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_6_7, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_8_9, MPCC_MC=
M, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_10_11, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_12_13, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_14_15, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_16_17, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_18_19, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_20_21, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_22_23, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_24_25, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_26_27, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_28_29, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_30_31, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_1DLUT_RAMB_REGION_32_33, MPCC_=
MCM, inst),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; SRII(MPCC_MCM_MEM_PWR_CTRL, MPCC_MCM, inst)<=
br>
&gt; +<br>
&gt;&nbsp;&nbsp; /* OPTC */<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define OPTC_COMMON_REG_LIST_DCN3_2_RI(inst)&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; @@ -1121,6 +1196,7 @@ void dcn32_determine_det_override(struct dc_stat=
e *context, display_e2e_pipe_par<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCHUBBUB_ARB_REFCYC=
_PER_TRIP_TO_MEMORY_D), SR(DCHUBBUB_DET0_CTRL),&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCHUBBUB_DET1_CTRL)=
, SR(DCHUBBUB_DET2_CTRL), SR(DCHUBBUB_DET3_CTRL),&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCHUBBUB_COMPBUF_CT=
RL), SR(COMPBUF_RESERVED_SPACE),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCHUBBUB_DEBUG_CTRL_0),&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCHUBBUB_ARB_USR_RE=
TRAINING_CNTL),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCHUBBUB_ARB_USR_RE=
TRAINING_WATERMARK_A),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(DCHUBBUB_ARB_USR_RE=
TRAINING_WATERMARK_B),&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b=
/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c<br>
&gt; index a93dc00ebfb5..184997a5b464 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c<br>
&gt; @@ -466,21 +466,15 @@ static const struct dcn20_dsc_mask dsc_mask =3D =
{<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static struct dcn30_mpc_registers mpc_regs;<br>
&gt;&nbsp;&nbsp; #define dcn_mpc_regs_init()\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ( \<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_REG_LIST_DCN3_0_RI(0),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_REG_LIST_DCN3_0_RI(1),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_REG_LIST_DCN3_0_RI(2),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_REG_LIST_DCN3_0_RI(3),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_MCM_REG_LIST_DCN32_RI(0),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_MCM_REG_LIST_DCN32_RI(1),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_MCM_REG_LIST_DCN32_RI(2),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_MCM_REG_LIST_DCN32_RI(3),\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)\<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; )<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN3_2_RI(0),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN3_2_RI(1),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN3_2_RI(2),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_REG_LIST_DCN3_2_RI(3),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(0),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(1),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(2),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_OUT_MUX_REG_LIST_DCN3_0_RI(3),\<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; MPC_DWB_MUX_REG_LIST_DCN3_0_RI(0)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static const struct dcn30_mpc_shift mpc_shift =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPC_COMMON_MASK_SH_LIST_DCN3=
2(__SHIFT)<br>
<br>
LGTM,<br>
<br>
Reviewed-by: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
<br>
I asked Daniel to run a couple of tests with this patch. Let's wait for <br=
>
his result before we merge it.<br>
<br>
Thanks<br>
Siqueira<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284EA20465E2D4EAE88B9DA8B7E9CH0PR12MB5284namp_--
