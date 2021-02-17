Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0737BC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 13:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40D164DCF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 13:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40D164DCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB0C6E532;
	Wed, 17 Feb 2021 13:40:22 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680063.outbound.protection.outlook.com [40.107.68.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79C76E532
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 13:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4yEnIrfkaC0UyY34wd0KYvWpO8c8ko46DvT+uYaWPhT4q+yUI8CRbErhvuCB3Qoy/F7eGjtG1/9zVp9Yeens0M1HjQeQgqGbN9cxzDZWQeAEN/Xu2jTmkC4+w/eTdtaKAV3fPiFSeMQTMspXrLcmKruv5UxkJvMK1od3CF+UhtQAyZKEbfX9Lk59cwXUQuRzY/EYuCd4M5pLfXoa9F2RgZPc2FDSZMgy+dI0YaT+Gy4g6ml5Zx4lhFOW5Ky8jVv0RBmd5tKVKIQ/IbpMLUZU7gALkGM+UxVchSsDCN9E/gzVvHrPxPKSgBq9TOFdPRGZQzWIf3dFmf3hY5llHC4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRQHAEsAuSO3BNO6SO4OuRtZNCH390PtxlM/NAUNEcE=;
 b=B8D3SE9FqMW3j7oQDhMzny5pSAkJoEzzVcp3+obP1VvFIx6otjFB2dc4LGQfT90+H1RbybU/E/XWW0PF7bhiEwOAAAv19LXJMOQ+/SAuCdO36qw/5j0BEzGpWxCiYu9cvtswaJEv/c9V6EGABWL7UNeWZLRgL0SJIo7aNdN/pMBZk8CQtitKvgZdporbc1xlEDeOqbaTEiu4IXc8AO/+XUAKyYWypxLxsOOYv+8kZMJSvq0q+XZaLp2SFCpghYfxp925YcoAOIL3n0DmB/87MQROPyM49djee5L2ikrXBBbO5khZ4V5azvRkRp1bsQMtCI9JYiRsw4XYTtIQq034fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRQHAEsAuSO3BNO6SO4OuRtZNCH390PtxlM/NAUNEcE=;
 b=uZ/oYZ8wD+xa+0VXJFerxU+ZHaXE/lK9YQnKHEYONJN44uR3d2ncTSNxDuHO9jrti/GRTLamJ0gnOm96HgaQiK/XY/XyOad0T06tP9WKSAU6oURE7dh/EYdjPTQffr+e+8V11fBEpYx2yA/3qN8G9ea1aQnfc7vhlTNhakqsTg8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.36; Wed, 17 Feb 2021 13:40:17 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.027; Wed, 17 Feb 2021
 13:40:17 +0000
Date: Wed, 17 Feb 2021 08:40:14 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH] drm/amd/display: Old sequence for HUBP blank
Message-ID: <20210217134014.4gqi6c2tliba23ze@outlook.office365.com>
References: <20210216235841.154819-1-aurabindo.pillai@amd.com>
In-Reply-To: <20210216235841.154819-1-aurabindo.pillai@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:5828:371c:d7b6:8576]
X-ClientProxiedBy: YTOPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::27) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:5828:371c:d7b6:8576)
 by YTOPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.35 via Frontend
 Transport; Wed, 17 Feb 2021 13:40:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1702cc58-f274-4085-efd5-08d8d3498ff3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB400994F78984805FCAD2551E98869@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z44r0bRFJe+tsOfzpFj/dyO7up3xmV7WB78r1zU7a05leNdTlrmjnYmkO3qv7ghwWwZHWoX3nA/clwykFA3Qz3KafV6MEP/ktikcEyIJJF70e9lGwqcjtTIRtJ7U3CUndkvvZi/md5N09wCSFvkuCakkCNYTkYRobWeyFl8jVbknGHxGHG3Mr2x/asvNVSwvKcACRgGfE2KXfkkE3N2JlNALcgg+qLxGhu0lMKLnN99YsEey14S7eUedPYgzGnFeR+skUIiVKmaa6hptHxoF6/mMa7/uj+9l4gdyzOcX8yaGb+e7IrYWYf2oYod8jrz+mBrIvu6xaAxLxy39zAmAhLb6ZSvZDtASpFHSM8qg/RPmggUniltRBWszy2nNwZVgX41htaebExLtlES1unF0+elGUP2OlF2v1K62IgpaVVN7ZycPfQHCc45izWJr9eB13uZXVticpb5s614fddMBbTwgMvJw/aGyc5lLZsuxWGogjJ7QLBJxi/5OglLOvdt9lB10chf8EXr4jst93fdkG4QgJue9vBMtzKD9ZgTgjpkwC2DQZy11yqGefb50bhKQUCY4ddCU7V3hx+ZOGqBgG+bgB6/ogn/LiLYIAJ56FC3H0wMWrN/R3NTeyTL1CP1da4I2El/pJIVz94s/SwVcHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(4326008)(6636002)(30864003)(6862004)(316002)(966005)(86362001)(7696005)(44144004)(83380400001)(478600001)(2906002)(21480400003)(6506007)(16526019)(6666004)(9686003)(186003)(52116002)(1076003)(5660300002)(8676002)(66476007)(45080400002)(55016002)(66946007)(8936002)(66556008)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mup0YSYhVDXLKM2VOiD0BrmTFYMfekYUbgOmxvwekSL4gqM4BWNu7LUMPai1?=
 =?us-ascii?Q?UOVOWKv56y+1XNdyvZB7Sd5/FsaSQJMCD8iIzXbV+/YDmFBSRzMnp+Nert/p?=
 =?us-ascii?Q?NEC1JnCimx+ReXYlj7bjOT0K457KxwmEz63cNLfHTlI/D/mrB4qIjjOVqNWv?=
 =?us-ascii?Q?pGGW7bvLbISP2n2Cd9PR6yyMF90u90DuAycrWUuzPpeQn7avGFXF9U0aKWwF?=
 =?us-ascii?Q?x/VH7+ATRYnSjjqWv++2eKwBQs2CIpcIBsCp80MyVWJW7y9ntiVlkNlWiUbN?=
 =?us-ascii?Q?wT1nE9D2H/gIymrkp06oKZpL0zNW/sHfGczZKnsMDWqRrkHmTHivVGOS+b/O?=
 =?us-ascii?Q?6uG0dQZiBklmv+X3eVe98jyYLV89GGY33pOVHG6nZ12sW+1YUiXE8U3hkBUG?=
 =?us-ascii?Q?bRfgL65p/5YOqlVA20QUjqpWm4lG7GRCOJGutK1n90s/qrIhVjEg2bPb/Y8E?=
 =?us-ascii?Q?P7++1eMoOXsFXjxE5OwV3QxO82vCi3ChPB+iDeZzbseYTCvNBDXXx9QW3H42?=
 =?us-ascii?Q?0C4RigU/15t1B91uTGQjdHyAuxmfpraYwg5CiUi4Lps1t24d9wXwOpQxN7Cg?=
 =?us-ascii?Q?1vGTK40TolEWo+S89d/fFdJvOPGgpQvrk0m6ZGni58eVxsfdLS68BhSf7Xur?=
 =?us-ascii?Q?1fRqFbbL0QySS04m9Tn2H05xMeCYjW5Q2DRpho+p/QWzDqpUfHSzu+KcdzXr?=
 =?us-ascii?Q?NUrq4Kuxx8boAT2LU3Wc6cg5gpC/vYnY78qIiZLM9FeXMEW3l5o+fejhuLXY?=
 =?us-ascii?Q?1Rm9I0Q1SJUnLbYs8MuypTPuCnBoWuqv0ec15OHfuYXupFnFqMNy4ixLGHAF?=
 =?us-ascii?Q?u0Kuca7ZlrTWGXzYh/VfJBbc5TLwMnYPx7VZcA6w3t3YzqUDKCLF0gkkPSxx?=
 =?us-ascii?Q?ItbN7GqlsTBXVU8zpVv+ROWG+7OAe0wIN6DBcUYjRTMiF5iOufVYxyh9gBZR?=
 =?us-ascii?Q?o5gdhdLsNNoYKTOEOgbCu0EwJ0s2JFyoJSaA8ZR/HzZwY6o0brnoNpR9IMaX?=
 =?us-ascii?Q?sRCVo9zO8Y+QRvC2asyhsnXMi0oKlbtAcPq0fW4byvWKOzkSw4PhIphRy+28?=
 =?us-ascii?Q?GkkzD/Mf62JcmqlXtLSExP3P3oNG44ksWtK9MzS9OK2l3ohBT5I1LYrF+M92?=
 =?us-ascii?Q?RWeeclFrcrDYZ+2X18mztwbKjeZpKwU5JtcWN+FjBLsc0XYhip3Lwquigq5H?=
 =?us-ascii?Q?S/D832JnwFDfDosJXz9tDBwQS3vLZebkZKXBx+ntOUah2+MZzfvLkNIdB4CP?=
 =?us-ascii?Q?jKR6h7atoQCbWbew1Y2RNZvtHeIohAkl6OSml+G1IGY0Gez6hfOuy1ojUYvl?=
 =?us-ascii?Q?BIlMvVDZ+BNxA8pI9l4l+22ml6Zga8CmvOCDl+uU4B+gT+Ti2WNIbBymw9SU?=
 =?us-ascii?Q?S2Yd7Uy3ImV32g3EaemD6mWrHr4H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1702cc58-f274-4085-efd5-08d8d3498ff3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 13:40:17.6125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0uB/eYr0O+pKi87cKWdMnZz6yRnb2jMTE/Y8NNlFtrMmyMhv6ucd3YSLjiIAByGiLQCjnQYeoujh3oM5leRjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
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
Cc: bhawanpreet.lakha@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1360310364=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1360310364==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kwwtpgp73sgep4tc"
Content-Disposition: inline

--kwwtpgp73sgep4tc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Is this commit a direct revert from
be7af780ef3cbb8fe1004db48dc66caf2da595cd ?

If so, I recommend you to use the standard way to identify "revert"
commits by using 'Revert "Commit header"' and the message "This reverts
commit HASH" followed by the original commit description.

Thanks
Siqueira

On 02/16, Aurabindo Pillai wrote:
> This reverts commit be7af780ef3cbb8fe1004db48dc66caf2da595cd because the
> new proposed sequence for HUBP blanking causes regressions. This change
> brings back the old sequence.
>=20
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> ---
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 +++--------
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  3 -
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 -
>  .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 13 +++-
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 -
>  .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 -
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 62 ++++---------------
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 --
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 -
>  .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 -
>  .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 --
>  11 files changed, 30 insertions(+), 97 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 89912bb5014f..361a97edc8ee 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -2635,7 +2635,7 @@ static void dcn10_update_dchubp_dpp(
>  	hws->funcs.update_plane_addr(dc, pipe_ctx);
> =20
>  	if (is_pipe_tree_visible(pipe_ctx))
> -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
> +		hubp->funcs->set_blank(hubp, false);
>  }
> =20
>  void dcn10_blank_pixel_data(
> @@ -3146,16 +3146,13 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx=
, struct dc *dc)
>  	return;
>  }
> =20
> -static struct pipe_ctx *get_pipe_ctx_by_hubp_inst(struct dc_state *conte=
xt, int mpcc_inst)
> +static struct hubp *get_hubp_by_inst(struct resource_pool *res_pool, int=
 mpcc_inst)
>  {
>  	int i;
> =20
> -	for (i =3D 0; i < MAX_PIPES; i++) {
> -		if (context->res_ctx.pipe_ctx[i].plane_res.hubp
> -				&& context->res_ctx.pipe_ctx[i].plane_res.hubp->inst =3D=3D mpcc_ins=
t) {
> -			return &context->res_ctx.pipe_ctx[i];
> -		}
> -
> +	for (i =3D 0; i < res_pool->pipe_count; i++) {
> +		if (res_pool->hubps[i]->inst =3D=3D mpcc_inst)
> +			return res_pool->hubps[i];
>  	}
>  	ASSERT(false);
>  	return NULL;
> @@ -3178,23 +3175,11 @@ void dcn10_wait_for_mpcc_disconnect(
> =20
>  	for (mpcc_inst =3D 0; mpcc_inst < MAX_PIPES; mpcc_inst++) {
>  		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
> -			struct pipe_ctx *restore_bottom_pipe;
> -			struct pipe_ctx *restore_top_pipe;
> -			struct pipe_ctx *inst_pipe_ctx =3D get_pipe_ctx_by_hubp_inst(dc->curr=
ent_state, mpcc_inst);
> +			struct hubp *hubp =3D get_hubp_by_inst(res_pool, mpcc_inst);
> =20
> -			ASSERT(inst_pipe_ctx);
>  			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
>  			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] =3D fals=
e;
> -			/*
> -			 * Set top and bottom pipes NULL, as we don't want
> -			 * to blank those pipes when disconnecting from MPCC
> -			 */
> -			restore_bottom_pipe =3D inst_pipe_ctx->bottom_pipe;
> -			restore_top_pipe =3D inst_pipe_ctx->top_pipe;
> -			inst_pipe_ctx->top_pipe =3D inst_pipe_ctx->bottom_pipe =3D NULL;
> -			dc->hwss.set_hubp_blank(dc, inst_pipe_ctx, true);
> -			inst_pipe_ctx->top_pipe =3D restore_top_pipe;
> -			inst_pipe_ctx->bottom_pipe =3D restore_bottom_pipe;
> +			hubp->funcs->set_blank(hubp, true);
>  		}
>  	}
> =20
> @@ -3747,10 +3732,3 @@ void dcn10_get_clock(struct dc *dc,
>  				dc->clk_mgr->funcs->get_clock(dc->clk_mgr, context, clock_type, cloc=
k_cfg);
> =20
>  }
> -
> -void dcn10_set_hubp_blank(const struct dc *dc,
> -				struct pipe_ctx *pipe_ctx,
> -				bool blank_enable)
> -{
> -	pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, bl=
ank_enable);
> -}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
> index 89e6dfb63da0..dee8ad1ebaa4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
> @@ -204,8 +204,5 @@ void dcn10_wait_for_pending_cleared(struct dc *dc,
>  		struct dc_state *context);
>  void dcn10_set_hdr_multiplier(struct pipe_ctx *pipe_ctx);
>  void dcn10_verify_allow_pstate_change_high(struct dc *dc);
> -void dcn10_set_hubp_blank(const struct dc *dc,
> -				struct pipe_ctx *pipe_ctx,
> -				bool blank_enable);
> =20
>  #endif /* __DC_HWSS_DCN10_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/=
gpu/drm/amd/display/dc/dcn10/dcn10_init.c
> index 2f1b802e66a1..254300b06b43 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
> @@ -79,7 +79,6 @@ static const struct hw_sequencer_funcs dcn10_funcs =3D {
>  	.set_backlight_level =3D dce110_set_backlight_level,
>  	.set_abm_immediate_disable =3D dce110_set_abm_immediate_disable,
>  	.set_pipe =3D dce110_set_pipe,
> -	.set_hubp_blank =3D dcn10_set_hubp_blank,
>  };
> =20
>  static const struct hwseq_private_funcs dcn10_private_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index b79a17f6a9cc..48d1e0e2cf75 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -1576,7 +1576,7 @@ static void dcn20_update_dchubp_dpp(
> =20
> =20
>  	if (pipe_ctx->update_flags.bits.enable)
> -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
> +		hubp->funcs->set_blank(hubp, false);
>  }
> =20
> =20
> @@ -1772,10 +1772,19 @@ void dcn20_post_unlock_program_front_end(
> =20
>  	for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
>  		struct pipe_ctx *pipe =3D &context->res_ctx.pipe_ctx[i];
> +		struct pipe_ctx *mpcc_pipe;
> =20
>  		if (pipe->vtp_locked) {
> -			dc->hwss.set_hubp_blank(dc, pipe, true);
> +			dc->hwseq->funcs.wait_for_blank_complete(pipe->stream_res.opp);
> +			pipe->plane_res.hubp->funcs->set_blank(pipe->plane_res.hubp, true);
>  			pipe->vtp_locked =3D false;
> +
> +			for (mpcc_pipe =3D pipe->bottom_pipe; mpcc_pipe; mpcc_pipe =3D mpcc_p=
ipe->bottom_pipe)
> +				mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hub=
p, true);
> +
> +			for (i =3D 0; i < dc->res_pool->pipe_count; i++)
> +				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
> +					dc->hwss.disable_plane(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
>  		}
>  	}
>  	/* WA to apply WM setting*/
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/=
gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> index 51a4166e9750..de9dcbeea150 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> @@ -94,7 +94,6 @@ static const struct hw_sequencer_funcs dcn20_funcs =3D {
>  	.optimize_timing_for_fsft =3D dcn20_optimize_timing_for_fsft,
>  #endif
>  	.set_disp_pattern_generator =3D dcn20_set_disp_pattern_generator,
> -	.set_hubp_blank =3D dcn10_set_hubp_blank,
>  };
> =20
>  static const struct hwseq_private_funcs dcn20_private_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/=
gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> index 0597391b2171..074e2713257f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> @@ -99,7 +99,6 @@ static const struct hw_sequencer_funcs dcn21_funcs =3D {
>  #endif
>  	.is_abm_supported =3D dcn21_is_abm_supported,
>  	.set_disp_pattern_generator =3D dcn20_set_disp_pattern_generator,
> -	.set_hubp_blank =3D dcn10_set_hubp_blank,
>  };
> =20
>  static const struct hwseq_private_funcs dcn21_private_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index ab93da667d51..d84164f0000c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -938,53 +938,6 @@ void dcn30_hardware_release(struct dc *dc)
>  				dc->res_pool->hubbub, true, true);
>  }
> =20
> -void dcn30_set_hubp_blank(const struct dc *dc,
> -		struct pipe_ctx *pipe_ctx,
> -		bool blank_enable)
> -{
> -	struct pipe_ctx *mpcc_pipe;
> -	struct pipe_ctx *odm_pipe;
> -
> -	if (blank_enable) {
> -		struct plane_resource *plane_res =3D &pipe_ctx->plane_res;
> -		struct stream_resource *stream_res =3D &pipe_ctx->stream_res;
> -
> -		/* Wait for enter vblank */
> -		stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_VBLAN=
K);
> -
> -		/* Blank HUBP to allow p-state during blank on all timings */
> -		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, t=
rue);
> -		/* Confirm hubp in blank */
> -		ASSERT(plane_res->hubp->funcs->hubp_in_blank(plane_res->hubp));
> -		/* Toggle HUBP_DISABLE */
> -		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, true);
> -		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, false);
> -		for (mpcc_pipe =3D pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe =3D mpc=
c_pipe->bottom_pipe) {
> -			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp=
, true);
> -			/* Confirm hubp in blank */
> -			ASSERT(mpcc_pipe->plane_res.hubp->funcs->hubp_in_blank(mpcc_pipe->pla=
ne_res.hubp));
> -			/* Toggle HUBP_DISABLE */
> -			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_re=
s.hubp, true);
> -			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_re=
s.hubp, false);
> -
> -		}
> -		for (odm_pipe =3D pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe =3D odm_=
pipe->next_odm_pipe) {
> -			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, =
true);
> -			/* Confirm hubp in blank */
> -			ASSERT(odm_pipe->plane_res.hubp->funcs->hubp_in_blank(odm_pipe->plane=
_res.hubp));
> -			/* Toggle HUBP_DISABLE */
> -			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.=
hubp, true);
> -			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.=
hubp, false);
> -		}
> -	} else {
> -		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, f=
alse);
> -		for (mpcc_pipe =3D pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe =3D mpc=
c_pipe->bottom_pipe)
> -			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp=
, false);
> -		for (odm_pipe =3D pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe =3D odm_=
pipe->next_odm_pipe)
> -			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, =
false);
> -	}
> -}
> -
>  void dcn30_set_disp_pattern_generator(const struct dc *dc,
>  		struct pipe_ctx *pipe_ctx,
>  		enum controller_dp_test_pattern test_pattern,
> @@ -994,6 +947,7 @@ void dcn30_set_disp_pattern_generator(const struct dc=
 *dc,
>  		int width, int height, int offset)
>  {
>  	struct stream_resource *stream_res =3D &pipe_ctx->stream_res;
> +	struct pipe_ctx *mpcc_pipe;
> =20
>  	if (test_pattern !=3D CONTROLLER_DP_TEST_PATTERN_VIDEOMODE) {
>  		pipe_ctx->vtp_locked =3D false;
> @@ -1005,12 +959,20 @@ void dcn30_set_disp_pattern_generator(const struct=
 dc *dc,
>  		if (stream_res->tg->funcs->is_tg_enabled(stream_res->tg)) {
>  			if (stream_res->tg->funcs->is_locked(stream_res->tg))
>  				pipe_ctx->vtp_locked =3D true;
> -			else
> -				dc->hwss.set_hubp_blank(dc, pipe_ctx, true);
> +			else {
> +				/* Blank HUBP to allow p-state during blank on all timings */
> +				pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp,=
 true);
> +
> +				for (mpcc_pipe =3D pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe =3D m=
pcc_pipe->bottom_pipe)
> +					mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hu=
bp, true);
> +			}
>  		}
>  	} else {
> -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
>  		/* turning off DPG */
> +		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, f=
alse);
> +		for (mpcc_pipe =3D pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe =3D mpc=
c_pipe->bottom_pipe)
> +			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp=
, false);
> +
>  		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp=
, test_pattern, color_space,
>  				color_depth, solid_color, width, height, offset);
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers=
/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
> index 3b7d4812e311..e9a0005288d3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
> @@ -80,8 +80,4 @@ void dcn30_set_disp_pattern_generator(const struct dc *=
dc,
>  		const struct tg_color *solid_color,
>  		int width, int height, int offset);
> =20
> -void dcn30_set_hubp_blank(const struct dc *dc,
> -		struct pipe_ctx *pipe_ctx,
> -		bool blank_enable);
> -
>  #endif /* __DC_HWSS_DCN30_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/=
gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> index 204444fead97..c4c14e9c1309 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> @@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn30_funcs =3D {
>  	.hardware_release =3D dcn30_hardware_release,
>  	.set_pipe =3D dcn21_set_pipe,
>  	.set_disp_pattern_generator =3D dcn30_set_disp_pattern_generator,
> -	.set_hubp_blank =3D dcn30_set_hubp_blank,
>  };
> =20
>  static const struct hwseq_private_funcs dcn30_private_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/driver=
s/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> index b8bf6d61005b..bdad72140cbc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> @@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn301_funcs =3D=
 {
>  	.set_abm_immediate_disable =3D dcn21_set_abm_immediate_disable,
>  	.set_pipe =3D dcn21_set_pipe,
>  	.set_disp_pattern_generator =3D dcn30_set_disp_pattern_generator,
> -	.set_hubp_blank =3D dcn30_set_hubp_blank,
>  };
> =20
>  static const struct hwseq_private_funcs dcn301_private_funcs =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/=
gpu/drm/amd/display/dc/inc/hw_sequencer.h
> index 0586ab2ffd6a..613b3e3cb46a 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
> @@ -231,10 +231,6 @@ struct hw_sequencer_funcs {
>  			enum dc_color_depth color_depth,
>  			const struct tg_color *solid_color,
>  			int width, int height, int offset);
> -
> -	void (*set_hubp_blank)(const struct dc *dc,
> -			struct pipe_ctx *pipe_ctx,
> -			bool blank_enable);
>  };
> =20
>  void color_space_to_black_color(
> --=20
> 2.30.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7C7700f89c242d4d5b837308d8d2d6cec7%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637491167330054893%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DuxidmH%2FvP7CIAaeYbJHtqQ1GM%2BZt5zfbNyfCWnSkhR4%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--kwwtpgp73sgep4tc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmAtHLoACgkQWJzP/com
vP9m7A//Z9YwHODq3L0F7unwxbutF1nOK0fa0IUiCN4DZl20w6JwYvhSE7odk4qJ
l2DDcbTUPpjOgmtaCcqiQuRUCZAO+P7srJ4LG94/4qb31DUnp1cRgQev9/ItXAyZ
OKMVPVRjsW57ObaHzWkz9EHYSDwKxiyY35Puc28cpuiyEQ3mxjsmPZr4Dc4Ohe3Q
/Fn0n+/BO0pB/SGWOzU/+IHIxqMrVOlCYs7Gd4EHVquHOfSsr9B2+OcZA7JDuTna
5S0T0hyxUKa9tvDkqtk9GTIAhzUxvYWOBHx0kju4aUDQTs3/dJVtbTdQFD73gr6J
mnng0ZoOYUh75nK9MhMaOzqejFuJ0hHwLGAMdCuQYeg4eGw1gEluoXdI/cYm38uY
m/Q6Id1zpX+FyJFaCbXTQLTu0yCy4y7+AzFZfowYcYw7AvTA+AfSYVgbUkeqPr/n
2GIZ3BJ1NsgIe1xiztwC3erWlWCUsS/s1vTNfsLWx3QRuWbRQNsxZn3617S6/yrv
MYYu4k5+UWzWO+anPXb+iNZekI5xJv+n6goHr/R80nF6scZpnPp7J398KfeCvKqh
cgpcMkvUfoWC9RbPqQznwiKQBWW6+9EFbjd2ffJlJhzLZ/Es9VCjgTUwK6apueao
cIchyF33eUVPTNtT6HeNgCG0z5tsL1OHJROpCTAWgsS+BJCCs/Y=
=YOAh
-----END PGP SIGNATURE-----

--kwwtpgp73sgep4tc--

--===============1360310364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1360310364==--
