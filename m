Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9ACC6FA99
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 18:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6EF10E318;
	Fri, 10 Mar 2023 18:34:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7421210E313
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 18:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKFhcydobVpzfGO715wiR7rJOBgk20PS6GlkBVziNCrkdVteXvDsclRmLOLpiN7Cywf5sSFmI1Bz9EM6vfJEKXkS18mMWTlSp4gc8C6n4cFK6qq/6zxmJuWriBOFF7Tiix96qGcqXJdKDoWtFhEXiR2BzUTsCCWDpjBud+DxqGAOfQyy+Het7xthQTTjX1uAR4q3sEmX0PF4yAXQDgkcKlR8/JsZqKvUs4tHWOiaQ7y6JMeqn8zNpTXe3wv/vcP0XSSwF0uc0tTqTXeXt3idmAdNiQs+dmnCNi+KWz+oS0P1D5Lwy5wfbKdzl2iw73bvRvWW5mXVrtbderQGYANw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFPh5Ygv9wIAF0gl0Y6t43YOZMvarjZV1RqDtILJhJk=;
 b=GdjRmvRGOdTJR/kMujhsqve/Zm0B42pWvsy4SVYcK+SS1xZUdloVL3vIOLZQwCmWGxZjPQPz41lQBNIXgUMGVzUrMR5DVeTkDOvXxciCa8d55Xq12GKuncnCQGmjf9ZqqdMb+T3klgXivV2OpvyGrqJI60epGVPJEZ+aBBZolrvJNOmeRqJYMBegpEXBF/HlS5SJJ23n7qVJPSwfWP65NPbmRem2Nc3RwzB2qrjkiMlkd+8VxzCiit2ipdGzdr/J9fgJPt6dQ5MRmZ/tkL7Zg6acnB8sz3cGFFzDU0DymJhl5wkiyARccMzgmEY6/9j03gaHmaI+SmwcG2lKQejOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFPh5Ygv9wIAF0gl0Y6t43YOZMvarjZV1RqDtILJhJk=;
 b=m17IJbyp1dGjfCkMyQRUUEh4rIsBSJTf12wg79G6kLwnG6VBjUGiau3G6txiSTW0/Hz87JX4w0JaD0k23nautK8RKrWKl0LOEXGelm43JNX+ype220jHsrQEhOF1YcRa80BzNqjv66z1UHuf1LwP8c6ADiAwyhKYAgdzvUie3mY=
Received: from PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 18:34:27 +0000
Received: from PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::2a8d:2702:556d:b71f]) by PH8PR12MB7279.namprd12.prod.outlook.com
 ([fe80::2a8d:2702:556d:b71f%8]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 18:34:27 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amd/display: Enable FAMS for DCN3x
Thread-Topic: [PATCH 2/2] drm/amd/display: Enable FAMS for DCN3x
Thread-Index: AQHZU3ibWtaeCWa1lEivp5rDpClLCK70TEOAgAAKGPo=
Date: Fri, 10 Mar 2023 18:34:26 +0000
Message-ID: <PH8PR12MB72795CB4230B63DCE842F389F9BA9@PH8PR12MB7279.namprd12.prod.outlook.com>
References: <20230310174849.1619771-1-aurabindo.pillai@amd.com>
 <20230310174849.1619771-2-aurabindo.pillai@amd.com>
 <dc4fe2d1-a767-7bce-795d-e13bfcad7311@amd.com>
In-Reply-To: <dc4fe2d1-a767-7bce-795d-e13bfcad7311@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-10T18:34:26.616Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7279:EE_|PH7PR12MB6787:EE_
x-ms-office365-filtering-correlation-id: b3603163-92bb-47a1-2c20-08db21961423
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0ysWYpWKkmOhfZ8ig9QDcycV4g3ajfraalyr3Ow2FtNT+tfpyucz3fGBwsSvEpnd5lbCtl+116Lv9VMrYLY+MfSKcxyI5N8pTakCnEV5mwmtPgsr1NocyM7BUHPDrz6ZpfkGjYWYnz4yi7X7YSDbF36a1RSerddbRcKt152rO192U9knALezurPJRdcVDRwv6hkx/UeJR73TEqo/hRPCixz4lB+pfruhGhY5QEt8Ga3FwD7FiXnf/vUyyXKEfnOg1Or3W76CnKrel8cqgW4qQfZxlcrCmnk681xiU/VfGxKGarvX8YLnAOKY3CphC0Nhc6MY+joKRs6legWDfKT97vNQoRHJFFvQEl+go0MW627XX3F2/XdtH0xhGTEqGM2EwWedTGt610N0cW3FwN7u3UVbVe0U2c82Zd0s49LZJ4L0jLVaNQ1ktJ14kgDw3G091xNoZgNmkDrGd29V98iGJ7kG6L/BKMzNDqZXqk+8qsNGLh9ujDPN4g2eh0G/cGBbRgkpW6opjzH0dx6JclX0ZR0doJu9mfWY7KEVMmVHy92qCK5B3YYIHiLty0luZa/HhgGiIVgKcMqvOplvdzhrnOYTy9zB2UWjSN5M0jAmioLfpbwAlMh6fbyb0p5GgyXufnBf35MzBnsYNuv+GLOszZxHI6C8HMEiIy28jnz6FWJnIflLyWPy5y3L/uDYfdJnijBCWY5QVQcFakYAlT1E0PDiUsopLcneBdw8c9JDlQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7279.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199018)(38100700002)(19627405001)(9686003)(54906003)(33656002)(110136005)(38070700005)(86362001)(55016003)(26005)(186003)(122000001)(53546011)(478600001)(6506007)(83380400001)(7696005)(71200400001)(316002)(66446008)(52536014)(66476007)(5660300002)(4326008)(41300700001)(2906002)(8936002)(76116006)(64756008)(66556008)(8676002)(66946007)(91956017)(30864003)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sg6N52OAk+PECbG7pMVVSN+VFMD2GLOeazyU3rPPgTEph/XncGkX5v1pnIdI?=
 =?us-ascii?Q?pcmrmJr8APsODKmDw/mlhvnhhdiYEmftAap0Ky4agk4x5HKeskjrtO22mia/?=
 =?us-ascii?Q?ieozc4yAmAEX5/ZH0nW3PmDaHeuqYLbaMkif1qmSOyQCLEefBxSbht3ln2ke?=
 =?us-ascii?Q?R9tQpdOr1AQ5j+5ZM81ZfNGWgfWx8Rk0BoVnV+7uqc+lOGa72R0UCdUQfj1m?=
 =?us-ascii?Q?bItAVy20jtQJv1Ju4GeVpAOxC5B+zFGJWo9Ge6rlsVo8mcAUpZG+Hwg32LKL?=
 =?us-ascii?Q?SXsewC34YmIRudg/MgplIi6Go8T0GQIuC3dMgbXLM3m7362iBgGvc/ZtHxOA?=
 =?us-ascii?Q?5fJPPcJc0r+258d+oYv1oKCGTD5ZuvfLUMrrQadRqoXf7Ldz/P57IGb7sNf9?=
 =?us-ascii?Q?qagblruwfiwqEr1NhQLpEwz1JogJZS32w/fFZFdCQ5tRvUtkCujLmtGk7VPd?=
 =?us-ascii?Q?rEk1C7jrM+/BjrC0HAFuej6P5NrU3f5xbuYiyo4DVfdC/MJWEQ2pXwTA92rH?=
 =?us-ascii?Q?QBRGzivkgj9CdI4uULN1W+mkffVP4eS3GXdp5Zdqleb0/Lm1FqdMIh4okd1Y?=
 =?us-ascii?Q?TwR6g1D3e7h15Rzga0A8TylYYblJHGaQUF2ZhNLiun9W2HErRDoc3q/jXicT?=
 =?us-ascii?Q?FvvDQlpLuYTtspI/dYVNjH8Z4hadbBTgOpDW2UEvFAPwAZ6UeBQwaQk2i/7d?=
 =?us-ascii?Q?jvlh19ps7JVHRZduosRM+WfaroDr0vKRlTUpHAskNUt5ZHZH/XXhFyDy3sWe?=
 =?us-ascii?Q?dZgsDOYoXer5pvQSpfqBYE23KRKgjilHNMvy4kd57F2jok7WF4C4Mx7tTLZB?=
 =?us-ascii?Q?tQjaV4LiQ94OqElnnLWdwTlYP2i6ufHB1pT20dJTJo0mc7xJn3aqMTNXQ12j?=
 =?us-ascii?Q?hCd8qMOSCxT8kVU8X/dnzk+d9gxtIbvLofS3mR18VGW8Osy9z1fuwJByaRqA?=
 =?us-ascii?Q?EpIWHVB8roHgQKHOgmZR5CBY12vnglB6n+HIkaIL43abKlWK8tv7HRgSGGko?=
 =?us-ascii?Q?bCKyzs7PnhlK6xng7aS8eFdPqmbK7LXJ6jI72zuw31YFT44b28VJxJjBC4DX?=
 =?us-ascii?Q?xiTPP1MExaky4/NzXkqc9gv+oDM3bOUdUdOHwmnAAUQsmDaiZK3hTOlCz0Sa?=
 =?us-ascii?Q?hehe0+STynenPLZWqqONUDi+LJRoZuZJx8XDq0hbdMI6hhrae/0bLGqvNbtG?=
 =?us-ascii?Q?vhH5LhkoIZO0eWK1KK3eeNZ0GqQ1yPKYOLhne6xr0ru/Mxs4OOckuBCz124T?=
 =?us-ascii?Q?VI85oMTWzhh1avBhl4njfKsddS53kFBzr0R3FmJ7BRCs09KYtUjqE3miGZ0b?=
 =?us-ascii?Q?jxeG66g4ei0hkSEwMafjk+npLncZ/NNaAKQela+oddqqHCUWgPe8usXeCsre?=
 =?us-ascii?Q?O86PH8L30wKJXnJWxgNKUf5udO9X5F86FM/XoQFi7knX02CS+HgFFZZ9nKhm?=
 =?us-ascii?Q?3wZ1FWwZMZquYJTWFxeo+lELXfWkIikx0CukWAWKlTwdJFTymU7x4smYjkcS?=
 =?us-ascii?Q?8RGyDv2DollEXZq2w8au5wV1WG4DbOPzhxpZCrPPT8ONGATXR02g2zOu4Y1s?=
 =?us-ascii?Q?FxTXU4SuQrJB56TaiXQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH8PR12MB72795CB4230B63DCE842F389F9BA9PH8PR12MB7279namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7279.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3603163-92bb-47a1-2c20-08db21961423
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2023 18:34:26.9405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbysWh6hpiLSmUO6vZvH2h1QcDF9kYi8ofdb+mHwPq7mwBmK64U1efqKhLU4KEvt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH8PR12MB72795CB4230B63DCE842F389F9BA9PH8PR12MB7279namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Aurabind=
o Pillai <aurabindo.pillai@amd.com>
Sent: March 10, 2023 12:56 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrigo <Rodrigo.Si=
queira@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/display: Enable FAMS for DCN3x



On 3/10/23 12:48, Aurabindo Pillai wrote:
> [Why&How]
> Firmware Assisted Memclk Switching enables lowering mclk using DMCUB
> when it cannot be normally done due to not having enough time within
> vblank. FAMS extends vblank on monitors that support variable refresh
> rate thereby allowing enough time to do an mclk switch sequence
> during vblank.
>
> When tested with 4k@144Hz monitor on DCN32, power consumption of about
> 40W was saved since multiple clocks like MCLK, SOCCLK, and FCLK
> were brought down.
>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  7 +-
>   .../drm/amd/display/dc/dcn30/dcn30_resource.h |  3 +
>   .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  4 ++
>   .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  2 +
>   .../drm/amd/display/dc/dcn32/dcn32_resource.c |  2 +-
>   .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 71 ++++++++++++++++---
>   .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  5 ++
>   7 files changed, 84 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/=
gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> index 08b92715e2e6..9963bffb1e07 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> @@ -301,7 +301,12 @@ void optc3_wait_drr_doublebuffer_pending_clear(struc=
t timing_generator *optc)
>
>   void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal=
_min, int vtotal_max)
>   {
> -     optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
> +     struct dc *dc =3D optc->ctx->dc;
> +
> +     if (dc->caps.dmub_caps.mclk_sw && !dc->debug.disable_fams)
> +             dc_dmub_srv_drr_update_cmd(dc, optc->inst, vtotal_min, vtot=
al_max);
> +     else
> +             optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
>   }
>
>   void optc3_tg_init(struct timing_generator *optc)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/driv=
ers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
> index 8e6b8b7368fd..d8805618a9a1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
> @@ -102,6 +102,9 @@ void dcn30_update_bw_bounding_box(struct dc *dc, stru=
ct clk_bw_params *bw_params
>
>   bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct=
 dc *dc, struct dc_state *context);
>   void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc *d=
c, struct dc_state *context);
> +
> +void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc=
, struct dc_state *context);
> +

This is duplicate and will remove before applying.
>   int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *=
dc, struct dc_state *context,
>                display_e2e_pipe_params_st *pipes, int pipe_cnt, int vleve=
l);
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> index 80a0c5a575a9..40080113ed5e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> @@ -295,6 +295,10 @@ void dcn31_init_hw(struct dc *dc)
>        if (dc->res_pool->hubbub->funcs->init_crb)
>                dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub=
);
>   #endif
> +     /* Get DMCUB capabilities */
> +     dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
> +     dc->caps.dmub_caps.psr =3D dc->ctx->dmub_srv->dmub->feature_caps.ps=
r;
> +     dc->caps.dmub_caps.mclk_sw =3D dc->ctx->dmub_srv->dmub->feature_cap=
s.fw_assisted_mclk_switch;
>   }
>
>   void dcn31_dsc_pg_control(
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index f87db2271924..3220f9ad8a47 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -919,6 +919,8 @@ void dcn32_init_hw(struct dc *dc)
>        if (dc->ctx->dmub_srv) {
>                dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
>                dc->caps.dmub_caps.psr =3D dc->ctx->dmub_srv->dmub->featur=
e_caps.psr;
> +             dc->caps.dmub_caps.mclk_sw =3D dc->ctx->dmub_srv->dmub->fea=
ture_caps.fw_assisted_mclk_switch;
> +

Will remove the extra newline before applying
>        }
>   }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index 100b6df33b33..b1944e49a65d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -2013,7 +2013,7 @@ int dcn32_populate_dml_pipes_from_context(
>        // In general cases we want to keep the dram clock change requirem=
ent
>        // (prefer configs that support MCLK switch). Only override to fal=
se
>        // for SubVP
> -     if (subvp_in_use)
> +     if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || subvp_in_=
use)
>                context->bw_ctx.dml.soc.dram_clock_change_requirement_fina=
l =3D false;
>        else
>                context->bw_ctx.dml.soc.dram_clock_change_requirement_fina=
l =3D true;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index 4fa636364793..53f21b0b3630 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -368,7 +368,9 @@ void dcn30_fpu_update_soc_for_wm_a(struct dc *dc, str=
uct dc_state *context)
>        dc_assert_fp_enabled();
>
>        if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
> -             context->bw_ctx.dml.soc.dram_clock_change_latency_us =3D dc=
->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us=
;
> +             if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching ||
> +                             context->bw_ctx.dml.soc.dram_clock_change_l=
atency_us =3D=3D 0)
> +                     context->bw_ctx.dml.soc.dram_clock_change_latency_u=
s =3D dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_la=
tency_us;
>                context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us =3D dc-=
>clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit=
_time_us;
>                context->bw_ctx.dml.soc.sr_exit_time_us =3D dc->clk_mgr->b=
w_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
>        }
> @@ -384,9 +386,34 @@ void dcn30_fpu_calculate_wm_and_dlg(
>        int i, pipe_idx;
>        double dcfclk =3D context->bw_ctx.dml.vba.DCFCLKState[vlevel][maxM=
pcComb];
>        bool pstate_en =3D context->bw_ctx.dml.vba.DRAMClockChangeSupport[=
vlevel][maxMpcComb] !=3D dm_dram_clock_change_unsupported;
> +     unsigned int dummy_latency_index =3D 0;
>
>        dc_assert_fp_enabled();
>
> +     context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching =3D false;
> +
> +     if (!pstate_en) {
> +             /* only when the mclk switch can not be natural, is the fw =
based vblank stretch attempted */
> +             context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching =3D
> +                     dcn30_can_support_mclk_switch_using_fw_based_vblank=
_stretch(dc, context);
> +
> +             if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> +                     dummy_latency_index =3D dcn30_find_dummy_latency_in=
dex_for_fw_based_mclk_switch(dc,
> +                             context, pipes, pipe_cnt, vlevel);
> +
> +                     /* After calling dcn30_find_dummy_latency_index_for=
_fw_based_mclk_switch
> +                      * we reinstate the original dram_clock_change_late=
ncy_us on the context
> +                      * and all variables that may have changed up to th=
is point, except the
> +                      * newly found dummy_latency_index
> +                      */
> +                     context->bw_ctx.dml.soc.dram_clock_change_latency_u=
s =3D dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_la=
tency_us;
> +                     dcn30_internal_validate_bw(dc, context, pipes, &pip=
e_cnt, &vlevel, false, true);
> +                     maxMpcComb =3D context->bw_ctx.dml.vba.maxMpcComb;
> +                     dcfclk =3D context->bw_ctx.dml.vba.DCFCLKState[vlev=
el][context->bw_ctx.dml.vba.maxMpcComb];
> +                     pstate_en =3D context->bw_ctx.dml.vba.DRAMClockChan=
geSupport[vlevel][maxMpcComb] !=3D dm_dram_clock_change_unsupported;
> +             }
> +     }
> +
>        if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
>                dcfclk =3D context->bw_ctx.dml.soc.min_dcfclk;
>
> @@ -449,15 +476,29 @@ void dcn30_fpu_calculate_wm_and_dlg(
>                unsigned int min_dram_speed_mts =3D context->bw_ctx.dml.vb=
a.DRAMSpeed;
>                unsigned int min_dram_speed_mts_margin =3D 160;
>
> -             if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][=
context->bw_ctx.dml.vba.maxMpcComb] =3D=3D dm_dram_clock_change_unsupported=
)
> -                     min_dram_speed_mts =3D dc->clk_mgr->bw_params->clk_=
table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz=
 * 16;
> +             context->bw_ctx.dml.soc.dram_clock_change_latency_us =3D
> +                     dc->clk_mgr->bw_params->dummy_pstate_table[0].dummy=
_pstate_latency_us;
>
> -             /* find largest table entry that is lower than dram speed, =
but lower than DPM0 still uses DPM0 */
> -             for (i =3D 3; i > 0; i--)
> -                     if (min_dram_speed_mts + min_dram_speed_mts_margin =
> dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts)
> -                             break;
> +             if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][=
maxMpcComb] =3D=3D
> +                     dm_dram_clock_change_unsupported) {
> +                     int min_dram_speed_mts_offset =3D dc->clk_mgr->bw_p=
arams->clk_table.num_entries - 1;
> +
> +                     min_dram_speed_mts =3D
> +                             dc->clk_mgr->bw_params->clk_table.entries[m=
in_dram_speed_mts_offset].memclk_mhz * 16;
> +             }
>
> -             context->bw_ctx.dml.soc.dram_clock_change_latency_us =3D dc=
->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
> +             if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> +                     /* find largest table entry that is lower than dram=
 speed,
> +                      * but lower than DPM0 still uses DPM0
> +                      */
> +                     for (dummy_latency_index =3D 3; dummy_latency_index=
 > 0; dummy_latency_index--)
> +                             if (min_dram_speed_mts + min_dram_speed_mts=
_margin >
> +                                     dc->clk_mgr->bw_params->dummy_pstat=
e_table[dummy_latency_index].dram_speed_mts)
> +                                     break;
> +             }
> +
> +             context->bw_ctx.dml.soc.dram_clock_change_latency_us =3D
> +                     dc->clk_mgr->bw_params->dummy_pstate_table[dummy_la=
tency_index].dummy_pstate_latency_us;
>
>                context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us =3D dc-=
>clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit=
_time_us;
>                context->bw_ctx.dml.soc.sr_exit_time_us =3D dc->clk_mgr->b=
w_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
> @@ -520,6 +561,20 @@ void dcn30_fpu_calculate_wm_and_dlg(
>                pipe_idx++;
>        }
>
> +     /* WA: restrict FW MCLK switch to use first non-strobe mode (Beige =
Goby BW issue) */
> +     if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching &&
> +                     dc->dml.soc.num_chans <=3D 4 &&
> +                     context->bw_ctx.dml.vba.DRAMSpeed <=3D 1700 &&
> +                     context->bw_ctx.dml.vba.DRAMSpeed >=3D 1500) {
> +
> +             for (i =3D 0; i < dc->dml.soc.num_states; i++) {
> +                     if (dc->dml.soc.clock_limits[i].dram_speed_mts > 17=
00) {
> +                             context->bw_ctx.dml.vba.DRAMSpeed =3D dc->d=
ml.soc.clock_limits[i].dram_speed_mts;
> +                             break;
> +                     }
> +             }
> +     }
> +
>        dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
>
>        if (!pstate_en)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index 077674be452b..ee2683200799 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -1331,6 +1331,11 @@ static void dcn32_calculate_dlg_params(struct dc *=
dc, struct dc_state *context,
>                        context->bw_ctx.dml.vba.DRAMClockChangeSupport[vle=
vel][context->bw_ctx.dml.vba.maxMpcComb]
>                                        !=3D dm_dram_clock_change_unsuppor=
ted;
>
> +     /* Pstate change might not be supported by hardware, but it might b=
e
> +      * possible with firmware driven vertical blank stretching.
> +      */
> +     context->bw_ctx.bw.dcn.clk.p_state_change_support |=3D context->bw_=
ctx.bw.dcn.clk.fw_based_mclk_switching;
> +
>        context->bw_ctx.bw.dcn.clk.dppclk_khz =3D 0;
>        context->bw_ctx.bw.dcn.clk.dtbclk_en =3D is_dtbclk_required(dc, co=
ntext);
>        context->bw_ctx.bw.dcn.clk.ref_dtbclk_khz =3D context->bw_ctx.dml.=
vba.DTBCLKPerState[vlevel] * 1000;

--_000_PH8PR12MB72795CB4230B63DCE842F389F9BA9PH8PR12MB7279namp_
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
=3D"elementToProof ContentPasted0">
Reviewed-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Aurabindo Pillai &lt;aurabind=
o.pillai@amd.com&gt;<br>
<b>Sent:</b> March 10, 2023 12:56 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Siqueira, Rodrig=
o &lt;Rodrigo.Siqueira@amd.com&gt;; Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.co=
m&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amd/display: Enable FAMS for DCN3x</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 3/10/23 12:48, Aurabindo Pillai wrote:<br>
&gt; [Why&amp;How]<br>
&gt; Firmware Assisted Memclk Switching enables lowering mclk using DMCUB<b=
r>
&gt; when it cannot be normally done due to not having enough time within<b=
r>
&gt; vblank. FAMS extends vblank on monitors that support variable refresh<=
br>
&gt; rate thereby allowing enough time to do an mclk switch sequence<br>
&gt; during vblank.<br>
&gt; <br>
&gt; When tested with 4k@144Hz monitor on DCN32, power consumption of about=
<br>
&gt; 40W was saved since multiple clocks like MCLK, SOCCLK, and FCLK<br>
&gt; were brought down.<br>
&gt; <br>
&gt; Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; Signed-off-by: Rodrigo Siqueira &lt;Rodrigo.Siqueira@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |&nbsp; 7 +-=
<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dcn30/dcn30_resource.h |&nbsp; 3 +<=
br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dcn31/dcn31_hwseq.c&nbsp;&nbsp;&nbs=
p; |&nbsp; 4 ++<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dcn32/dcn32_hwseq.c&nbsp;&nbsp;&nbs=
p; |&nbsp; 2 +<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dcn32/dcn32_resource.c |&nbsp; 2 +-=
<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c&nbsp; | 71 ++=
++++++++++++++---<br>
&gt;&nbsp;&nbsp; .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c&nbsp; |&nbsp;=
 5 ++<br>
&gt;&nbsp;&nbsp; 7 files changed, 84 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drive=
rs/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c<br>
&gt; index 08b92715e2e6..9963bffb1e07 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c<br>
&gt; @@ -301,7 +301,12 @@ void optc3_wait_drr_doublebuffer_pending_clear(st=
ruct timing_generator *optc)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void optc3_set_vtotal_min_max(struct timing_generator *opt=
c, int vtotal_min, int vtotal_max)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; optc1_set_vtotal_min_max(optc, vtotal_min, v=
total_max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct dc *dc =3D optc-&gt;ctx-&gt;dc;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;caps.dmub_caps.mclk_sw &amp;&amp;=
 !dc-&gt;debug.disable_fams)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dc_dmub_srv_drr_update_cmd(dc, optc-&gt;inst, vtotal_min, vtotal_max);<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void optc3_tg_init(struct timing_generator *optc)<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/d=
rivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h<br>
&gt; index 8e6b8b7368fd..d8805618a9a1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h<br>
&gt; @@ -102,6 +102,9 @@ void dcn30_update_bw_bounding_box(struct dc *dc, s=
truct clk_bw_params *bw_params<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; bool dcn30_can_support_mclk_switch_using_fw_based_vblank_s=
tretch(struct dc *dc, struct dc_state *context);<br>
&gt;&nbsp;&nbsp; void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch=
(struct dc *dc, struct dc_state *context);<br>
&gt; +<br>
&gt; +void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc =
*dc, struct dc_state *context);<br>
&gt; +<br>
<br>
This is duplicate and will remove before applying.<br>
&gt;&nbsp;&nbsp; int dcn30_find_dummy_latency_index_for_fw_based_mclk_switc=
h(struct dc *dc, struct dc_state *context,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; display_e2e_pipe_params_st *pipes, int pipe_cnt, int vl=
evel);<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/driv=
ers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c<br>
&gt; index 80a0c5a575a9..40080113ed5e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c<br>
&gt; @@ -295,6 +295,10 @@ void dcn31_init_hw(struct dc *dc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;res_pool-&gt;hubb=
ub-&gt;funcs-&gt;init_crb)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc-&gt;res_pool-&gt;hubbub-&gt;funcs-&gt;init_crb(dc-&g=
t;res_pool-&gt;hubbub);<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Get DMCUB capabilities */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dc_dmub_srv_query_caps_cmd(dc-&gt;ctx-&gt;dm=
ub_srv-&gt;dmub);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.dmub_caps.psr =3D dc-&gt;ctx-&gt=
;dmub_srv-&gt;dmub-&gt;feature_caps.psr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.dmub_caps.mclk_sw =3D dc-&gt;ctx=
-&gt;dmub_srv-&gt;dmub-&gt;feature_caps.fw_assisted_mclk_switch;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void dcn31_dsc_pg_control(<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/driv=
ers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
&gt; index f87db2271924..3220f9ad8a47 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c<br>
&gt; @@ -919,6 +919,8 @@ void dcn32_init_hw(struct dc *dc)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;ctx-&gt;dmub_srv)=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc_dmub_srv_query_caps_cmd(dc-&gt;ctx-&gt;dmub_srv-&gt;=
dmub);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dc-&gt;caps.dmub_caps.psr =3D dc-&gt;ctx-&gt;dmub_srv-&=
gt;dmub-&gt;feature_caps.psr;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dc-&gt;caps.dmub_caps.mclk_sw =3D dc-&gt;ctx-&gt;dmub_srv-&gt;dmub-&gt;=
feature_caps.fw_assisted_mclk_switch;<br>
&gt; +<br>
<br>
Will remove the extra newline before applying<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/d=
rivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c<br>
&gt; index 100b6df33b33..b1944e49a65d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c<br>
&gt; @@ -2013,7 +2013,7 @@ int dcn32_populate_dml_pipes_from_context(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // In general cases we want =
to keep the dram clock change requirement<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // (prefer configs that supp=
ort MCLK switch). Only override to false<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // for SubVP<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (subvp_in_use)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (context-&gt;bw_ctx.bw.dcn.clk.fw_based_m=
clk_switching || subvp_in_use)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.soc.dram_clock_change_requiremen=
t_final =3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.soc.dram_clock_change_requiremen=
t_final =3D true;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/dr=
ivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c<br>
&gt; index 4fa636364793..53f21b0b3630 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c<br>
&gt; @@ -368,7 +368,9 @@ void dcn30_fpu_update_soc_for_wm_a(struct dc *dc, =
struct dc_state *context)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;clk_mgr-&gt;bw_pa=
rams-&gt;wm_table.nv_entries[WM_A].valid) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; context-&gt;bw_ctx.dml.soc.dram_clock_change_latency_us =3D dc-&gt;clk_=
mgr-&gt;bw_params-&gt;wm_table.nv_entries[WM_A].dml_input.pstate_latency_us=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!context-&gt;bw_ctx.bw.dcn.clk.fw_based_mclk_switching ||<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.soc.dram_clock_change_laten=
cy_us =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.=
soc.dram_clock_change_latency_us =3D dc-&gt;clk_mgr-&gt;bw_params-&gt;wm_ta=
ble.nv_entries[WM_A].dml_input.pstate_latency_us;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.soc.sr_enter_plus_exit_time_us =
=3D dc-&gt;clk_mgr-&gt;bw_params-&gt;wm_table.nv_entries[WM_A].dml_input.sr=
_enter_plus_exit_time_us;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.soc.sr_exit_time_us =3D dc-&gt;c=
lk_mgr-&gt;bw_params-&gt;wm_table.nv_entries[WM_A].dml_input.sr_exit_time_u=
s;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -384,9 +386,34 @@ void dcn30_fpu_calculate_wm_and_dlg(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, pipe_idx;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; double dcfclk =3D context-&g=
t;bw_ctx.dml.vba.DCFCLKState[vlevel][maxMpcComb];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool pstate_en =3D context-&=
gt;bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] !=3D dm_dram_c=
lock_change_unsupported;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; unsigned int dummy_latency_index =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_assert_fp_enabled();<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.bw.dcn.clk.fw_based_mclk_=
switching =3D false;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate_en) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* only when the mclk switch can not be natural, is the fw based vblank=
 stretch attempted */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; context-&gt;bw_ctx.bw.dcn.clk.fw_based_mclk_switching =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn30_can_support_mclk_=
switch_using_fw_based_vblank_stretch(dc, context);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (context-&gt;bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_latency_index =3D=
 dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(dc,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; context, pipes, pipe_cnt, vlevel);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* After calling dcn30_=
find_dummy_latency_index_for_fw_based_mclk_switch<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * we reinstate th=
e original dram_clock_change_latency_us on the context<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and all variabl=
es that may have changed up to this point, except the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * newly found dum=
my_latency_index<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.=
soc.dram_clock_change_latency_us =3D dc-&gt;clk_mgr-&gt;bw_params-&gt;wm_ta=
ble.nv_entries[WM_A].dml_input.pstate_latency_us;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn30_internal_validate=
_bw(dc, context, pipes, &amp;pipe_cnt, &amp;vlevel, false, true);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; maxMpcComb =3D context-=
&gt;bw_ctx.dml.vba.maxMpcComb;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcfclk =3D context-&gt;=
bw_ctx.dml.vba.DCFCLKState[vlevel][context-&gt;bw_ctx.dml.vba.maxMpcComb];<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pstate_en =3D context-&=
gt;bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] !=3D dm_dram_c=
lock_change_unsupported;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (context-&gt;bw_ctx.dml.s=
oc.min_dcfclk &gt; dcfclk)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dcfclk =3D context-&gt;bw_ctx.dml.soc.min_dcfclk;<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -449,15 +476,29 @@ void dcn30_fpu_calculate_wm_and_dlg(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; unsigned int min_dram_speed_mts =3D context-&gt;bw_ctx.=
dml.vba.DRAMSpeed;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; unsigned int min_dram_speed_mts_margin =3D 160;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (context-&gt;bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context-&=
gt;bw_ctx.dml.vba.maxMpcComb] =3D=3D dm_dram_clock_change_unsupported)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_dram_speed_mts =3D =
dc-&gt;clk_mgr-&gt;bw_params-&gt;clk_table.entries[dc-&gt;clk_mgr-&gt;bw_pa=
rams-&gt;clk_table.num_entries - 1].memclk_mhz * 16;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; context-&gt;bw_ctx.dml.soc.dram_clock_change_latency_us =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;clk_mgr-&gt;bw_p=
arams-&gt;dummy_pstate_table[0].dummy_pstate_latency_us;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* find largest table entry that is lower than dram speed, but lower th=
an DPM0 still uses DPM0 */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D 3; i &gt; 0; i--)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (min_dram_speed_mts =
+ min_dram_speed_mts_margin &gt; dc-&gt;clk_mgr-&gt;bw_params-&gt;dummy_pst=
ate_table[i].dram_speed_mts)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (context-&gt;bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcCom=
b] =3D=3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_dram_clock_change_un=
supported) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int min_dram_speed_mts_=
offset =3D dc-&gt;clk_mgr-&gt;bw_params-&gt;clk_table.num_entries - 1;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min_dram_speed_mts =3D<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;clk_mgr-&gt;bw_params-&gt;clk_table.entries=
[min_dram_speed_mts_offset].memclk_mhz * 16;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; context-&gt;bw_ctx.dml.soc.dram_clock_change_latency_us =3D dc-&gt;clk_=
mgr-&gt;bw_params-&gt;dummy_pstate_table[i].dummy_pstate_latency_us;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!context-&gt;bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* find largest table e=
ntry that is lower than dram speed,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * but lower than =
DPM0 still uses DPM0<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (dummy_latency_inde=
x =3D 3; dummy_latency_index &gt; 0; dummy_latency_index--)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (min_dram_speed_mts + min_dram_speed_mts_margin=
 &gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc=
-&gt;clk_mgr-&gt;bw_params-&gt;dummy_pstate_table[dummy_latency_index].dram=
_speed_mts)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; context-&gt;bw_ctx.dml.soc.dram_clock_change_latency_us =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;clk_mgr-&gt;bw_p=
arams-&gt;dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;<=
br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.soc.sr_enter_plus_exit_time_us =
=3D dc-&gt;clk_mgr-&gt;bw_params-&gt;wm_table.nv_entries[WM_C].dml_input.sr=
_enter_plus_exit_time_us;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.soc.sr_exit_time_us =3D dc-&gt;c=
lk_mgr-&gt;bw_params-&gt;wm_table.nv_entries[WM_C].dml_input.sr_exit_time_u=
s;<br>
&gt; @@ -520,6 +561,20 @@ void dcn30_fpu_calculate_wm_and_dlg(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pipe_idx++;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* WA: restrict FW MCLK switch to use first =
non-strobe mode (Beige Goby BW issue) */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (context-&gt;bw_ctx.bw.dcn.clk.fw_based_m=
clk_switching &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;dml.soc.num_chan=
s &lt;=3D 4 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.=
vba.DRAMSpeed &lt;=3D 1700 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.=
vba.DRAMSpeed &gt;=3D 1500) {<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D 0; i &lt; dc-&gt;dml.soc.num_states; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc-&gt;dml.soc.cloc=
k_limits[i].dram_speed_mts &gt; 1700) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.dml.vba.DRAMSpeed =3D dc-&gt;dm=
l.soc.clock_limits[i].dram_speed_mts;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcn20_calculate_dlg_params(d=
c, context, pipes, pipe_cnt, vlevel);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pstate_en)<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/dr=
ivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c<br>
&gt; index 077674be452b..ee2683200799 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c<br>
&gt; @@ -1331,6 +1331,11 @@ static void dcn32_calculate_dlg_params(struct d=
c *dc, struct dc_state *context,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context=
-&gt;bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context-&gt;bw_ctx.dml.v=
ba.maxMpcComb]<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; !=3D dm_dram_clock_change_unsupported;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* Pstate change might not be supported by h=
ardware, but it might be<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * possible with firmware driven vertic=
al blank stretching.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.bw.dcn.clk.p_state_change=
_support |=3D context-&gt;bw_ctx.bw.dcn.clk.fw_based_mclk_switching;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.bw.dcn.cl=
k.dppclk_khz =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.bw.dcn.cl=
k.dtbclk_en =3D is_dtbclk_required(dc, context);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; context-&gt;bw_ctx.bw.dcn.cl=
k.ref_dtbclk_khz =3D context-&gt;bw_ctx.dml.vba.DTBCLKPerState[vlevel] * 10=
00;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH8PR12MB72795CB4230B63DCE842F389F9BA9PH8PR12MB7279namp_--
