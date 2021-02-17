Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61E9C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 15:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6783A64E0F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 15:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6783A64E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F176E0FF;
	Wed, 17 Feb 2021 15:29:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770041.outbound.protection.outlook.com [40.107.77.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020136E0FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 15:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjn/mVIGV1CUZk3iPrZgTYsQU95pkCYdF6LET3GtwOF6wn8LcBE44Y0+QleJv+2/f7FXZB+LMf6ILlbbEHJlH6DwdRPHfd5th23SFkUYzcbZBgnSgdObw4O80cR4SQR2XqUw/y02e3TUEefGdnNKpfNFIpGeoMIqIRwn/W/MPNdJVzNhf/XsAi5MDybeA4lPrZJ0EkXIHw7oG6S8Q7XB86G9njCkKcOp/UA0w/jcaVDqFPxKnXspA22oraKmGulKVMKUgjY8ZrOOb2CXuA9YPTglieF2ZPu8nlkWjfN5VNcYNETyTTjp9/alIkxeAHEElAqLt+ZG4YChFTlR8dBdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfQCfDcbhh61vO9bZyjnTEKdrNbzhlRO4DZl/lADuR8=;
 b=mbefnbujgfGNt2Ywh1CaBziXSG6ldIjVL0CuTAIwAf07b1zXsChSvYL8SCqDm/mlnm9Kiy8ZkVvbcGjmVsmHL0ACT/MOfyuT7EY9s6iyLoknW94bR0GlqvdNwSwOgkZawmW9PdocQ8zToZUlTUPENN0e6+7Bhvb3NHbilWgWAPKOroJD3U0Cdex+ruyf/vvPoW+2uxLHviSpBfIMnpjewmLeniua/jaSlsTmzNKNHkN0J20qebJ9yAEnXBVhlOMJaaTW37OoaB0dAwID+CPHn1uAJldm/vAf3SXyKLg91zfStzrNpFtiz7nXeNgKLJ6t2yMr2BjqTi05Nc9NOrIlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfQCfDcbhh61vO9bZyjnTEKdrNbzhlRO4DZl/lADuR8=;
 b=0EDldiiMmvL/7gHzOpgrRoxVKuykBWim2RIAbgL5AQNMjmv/UvLk/c1gDwI8xBWIbEWXV2CcAp4n6x/xk88yI0834KfS0bUg3CnCgQDkdqSMGc+qE2jYN4Qzk7u/c71yiMd7Ap0Q7glVL6kz72zFb2vI7gclFOZIHMGhuJPtPRA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.25; Wed, 17 Feb 2021 15:29:13 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.027; Wed, 17 Feb 2021
 15:29:13 +0000
Date: Wed, 17 Feb 2021 10:29:10 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH] drm/amd/display: Old sequence for HUBP blank
Message-ID: <20210217152910.uyfo5b6xvsrcv4sq@outlook.office365.com>
References: <20210216235841.154819-1-aurabindo.pillai@amd.com>
 <20210217134014.4gqi6c2tliba23ze@outlook.office365.com>
 <497e82ee-af5a-11a6-7f42-4197ff449749@amd.com>
In-Reply-To: <497e82ee-af5a-11a6-7f42-4197ff449749@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:5828:371c:d7b6:8576]
X-ClientProxiedBy: BN8PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:408:60::34) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:5828:371c:d7b6:8576)
 by BN8PR12CA0021.namprd12.prod.outlook.com (2603:10b6:408:60::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Wed, 17 Feb 2021 15:29:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56325e28-5f0c-46df-a248-08d8d358c751
X-MS-TrafficTypeDiagnostic: DM6PR12MB4578:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4578BBBB532E84FAF39BB2AF98869@DM6PR12MB4578.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzaYw01G2OljtJipN+nZt8yBpyi/SEKAZKP4jCECQnRrHi01rDvZCHiCvjzYn+2mNlNDI7HS8A2hR1GExt6Cf6wkjkNUUYn2jQHpGSuRpqIDyBGexQlkpaeZ8mB1BY3Lmc66gb+151smzZTi5mS1to63E5//+hdQAWBaDpkkeSU4ooL+PDP25j30JqFT5HUGAa7NcQL4pOkprBWWPLsJzGMZOwEWO/a6oZKXeDNHVMfpvpGTS6cKK9N+bcGSH0+05hhu85rKnnYXu9QF1pJS9YuuWI2cgK0dtXHLdxT4K0djH2Ov5fgOeuMLjt8BqLGE9ihCmQO8VXkVHVYH2OAtRmFxv3M+KAfgQL5xSqokBeySg4+EiP7u3WyoRaW5BTtFjHxQuMxq9fWArDnQYgmcyhcKEw3mJ2C0E4qzIySbCe5LzOQSiHHgtk5bCB9kanLKxegnMjQzrd7EJc3Ngh7qC30IWOS9Fj4YB890xs02CtTLQMNGxnjyI2Iloaau6ni3CWJA9SQqr2rpvtFnqpdV+B3iWi2OoibxVhogPQqmjXqk1t+Cbkyi+sYFB7SBC5TRLjPZ/I8WmPppgvLwVzvVgEi88NJi85mNAEkwsn8ugZfMcliYU3e8E55elQ5JrngzZOz92JDMhsPj3YMiA60IWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(16526019)(45080400002)(9686003)(2906002)(6506007)(30864003)(4326008)(6862004)(66946007)(5660300002)(8936002)(478600001)(21480400003)(6636002)(186003)(83380400001)(86362001)(44144004)(52116002)(316002)(7696005)(1076003)(66556008)(55016002)(53546011)(8676002)(66476007)(966005)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s3dimWvANhjVaKVR0IxujPDFIGRhtwlM/Ek1dMnnnXEYS2AMFA34fGxoS6VV?=
 =?us-ascii?Q?A3GC3AXXiE7ghwFWQsCpcw8F9MepeWNBYPbiTTYTuJPFe8p1TGMkkt/44rI8?=
 =?us-ascii?Q?fDCEpdQ+rhKRYA8I5lQhgWOYd9Cv+fngQiEFxQiZdR2070+eaIeCwsXP/hAU?=
 =?us-ascii?Q?s4erl35Y51XMPqaesTVz+WSiwA7fdIBF5oGNTrHqhCerFZHj55r559wqLJ0b?=
 =?us-ascii?Q?zQAiPGQU3DEH5pT9PycZhtiw0iO40ScX4VGzeugfi5emz3tw6xStPEL7HotB?=
 =?us-ascii?Q?P0NqN92dNl1nS8LRkUQOdhNC076Uc8nowBaqTCroEnVN6ZC+5ze8UfobNbWY?=
 =?us-ascii?Q?hnWb1JEQ8dkUiOkEg9iQcgiDABT6ZejWNn+6C7TjpbKOcCgWc1loYOLZriHa?=
 =?us-ascii?Q?Eq/RrftpdylWvSS0mvMOTRJMhacKnpak++EBiCo1J2Z4h/PWt2St8orGM0Gy?=
 =?us-ascii?Q?XjGP2tY9H4RjW17stDUDwmZAc9GqJlO6xdeCGsOurRBJCHQk0ep4XgXshpwt?=
 =?us-ascii?Q?jkYnvq7ufoj3N2FlPbUKliYCfqrK29cCJzUkI3c0Sq8u9cPZ2kJTaHfdKqxE?=
 =?us-ascii?Q?BoNret0RWQ4/Db4r4MQtL/Zvi8wxR0SFJYImXXAEpBLLOx9Pm/scq29BmeTN?=
 =?us-ascii?Q?D5NJGuEQQKlJTOQhgYhHIOXU2J6f01tdffQ7j8ZjhBkizGpP3bBNolhgUf5K?=
 =?us-ascii?Q?pKEa1ZPyqhwGz/9Pj42mA8V1lT6Cz5SJtYEhkgHwvRnpWg+SDm0ii2bLzdTX?=
 =?us-ascii?Q?/I828Q8S2hw492t7hyaBtiY0Q1LiL4K0rOBiNLS3UEsUxe8t9DI2tpf2zzPh?=
 =?us-ascii?Q?uWJxQHZMeToW6AWppNOY6E7tsbTvg1KpAnG6fa8vyHqoxakDmBPcGM+93W6R?=
 =?us-ascii?Q?ojt1c6Fsrx1j33ijPghCA/bgbDn0CfRVctXObgE25j4SnNwhVRv8Dt9zMzV3?=
 =?us-ascii?Q?hZbGRIXuBGll6d1IFv7c8MygonF6Nqi0q5Xjb6Jn30bNDXLqOv1s/bF4zwbC?=
 =?us-ascii?Q?dsBB2yqdFYPs6q6JWv41xsvTHEhopdI0vbaXFPGTG86w2YudNaNGXqvRksZq?=
 =?us-ascii?Q?QuTUEdQIQlijdWBsc73ae865CrhgMcE0LC0kljPdl+YrSsYA1BUVlBhHaHgy?=
 =?us-ascii?Q?gPkgYC5L6ViQcgR4oNGHQmH/i0a4Ffd6v1mp5xVzJ4C2iXlkM7VkKcZi80/X?=
 =?us-ascii?Q?QYegW1gqalEunyvWlY6KqOzhtiJPgOSE1QByVANreHzbe/unFuI4pmJ0X2fS?=
 =?us-ascii?Q?jo9QdBDg7xmEWIYe1x+9QhUbOjnKD8V2uYpM0tPpvJlWN1g5vas/XwX8dsCY?=
 =?us-ascii?Q?JAUat0FnKKjDpyYtXrwTJ885uCy9RruprORGUklDImi3QD4/Da1MVfErWO0F?=
 =?us-ascii?Q?lkqTbbJ1Wq+KdCGfN99se+AVAZmx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56325e28-5f0c-46df-a248-08d8d358c751
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 15:29:12.9832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+VVm76+ZRhZRKjczPsfI2fzica03aFQmRCnDtj2bzhnq7zoqXvbcQyWJw/LoAfiFr4MTDYfhf/tH0vjhkik+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4578
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
Content-Type: multipart/mixed; boundary="===============1826556531=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1826556531==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cfbh5rfw6zl5djjf"
Content-Disposition: inline

--cfbh5rfw6zl5djjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02/17, Aurabindo Pillai wrote:
>=20
>=20
> On 2021-02-17 8:40 a.m., Rodrigo Siqueira wrote:
> > Hi,
> >=20
> > Is this commit a direct revert from
> > be7af780ef3cbb8fe1004db48dc66caf2da595cd ?
> >=20
> > If so, I recommend you to use the standard way to identify "revert"
> > commits by using 'Revert "Commit header"' and the message "This reverts
> > commit HASH" followed by the original commit description.
>=20
> This is not an exact revert. It includes two more hunks which were not pa=
rt
> of the original commit. But logically this should be one unit, and hence
> having them separated might introduce regressions.

Ok,
In this case, remove the "revert" in the commit description to avoid
misleading information and add the Fixes tag at the end. With these
changes:

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
=20
> >=20
> > Thanks
> > Siqueira
> >=20
> > On 02/16, Aurabindo Pillai wrote:
> > > This reverts commit be7af780ef3cbb8fe1004db48dc66caf2da595cd because =
the
> > > new proposed sequence for HUBP blanking causes regressions. This chan=
ge
> > > brings back the old sequence.
> > >=20
> > > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > > Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> > > ---
> > >   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 +++--------
> > >   .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  3 -
> > >   .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 -
> > >   .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 13 +++-
> > >   .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 -
> > >   .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 -
> > >   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 62 ++++------------=
---
> > >   .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 --
> > >   .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 -
> > >   .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 -
> > >   .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 --
> > >   11 files changed, 30 insertions(+), 97 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.=
c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > > index 89912bb5014f..361a97edc8ee 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> > > @@ -2635,7 +2635,7 @@ static void dcn10_update_dchubp_dpp(
> > >   	hws->funcs.update_plane_addr(dc, pipe_ctx);
> > >   	if (is_pipe_tree_visible(pipe_ctx))
> > > -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
> > > +		hubp->funcs->set_blank(hubp, false);
> > >   }
> > >   void dcn10_blank_pixel_data(
> > > @@ -3146,16 +3146,13 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe=
_ctx, struct dc *dc)
> > >   	return;
> > >   }
> > > -static struct pipe_ctx *get_pipe_ctx_by_hubp_inst(struct dc_state *c=
ontext, int mpcc_inst)
> > > +static struct hubp *get_hubp_by_inst(struct resource_pool *res_pool,=
 int mpcc_inst)
> > >   {
> > >   	int i;
> > > -	for (i =3D 0; i < MAX_PIPES; i++) {
> > > -		if (context->res_ctx.pipe_ctx[i].plane_res.hubp
> > > -				&& context->res_ctx.pipe_ctx[i].plane_res.hubp->inst =3D=3D mpcc=
_inst) {
> > > -			return &context->res_ctx.pipe_ctx[i];
> > > -		}
> > > -
> > > +	for (i =3D 0; i < res_pool->pipe_count; i++) {
> > > +		if (res_pool->hubps[i]->inst =3D=3D mpcc_inst)
> > > +			return res_pool->hubps[i];
> > >   	}
> > >   	ASSERT(false);
> > >   	return NULL;
> > > @@ -3178,23 +3175,11 @@ void dcn10_wait_for_mpcc_disconnect(
> > >   	for (mpcc_inst =3D 0; mpcc_inst < MAX_PIPES; mpcc_inst++) {
> > >   		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst])=
 {
> > > -			struct pipe_ctx *restore_bottom_pipe;
> > > -			struct pipe_ctx *restore_top_pipe;
> > > -			struct pipe_ctx *inst_pipe_ctx =3D get_pipe_ctx_by_hubp_inst(dc->=
current_state, mpcc_inst);
> > > +			struct hubp *hubp =3D get_hubp_by_inst(res_pool, mpcc_inst);
> > > -			ASSERT(inst_pipe_ctx);
> > >   			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
> > >   			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] =3D=
 false;
> > > -			/*
> > > -			 * Set top and bottom pipes NULL, as we don't want
> > > -			 * to blank those pipes when disconnecting from MPCC
> > > -			 */
> > > -			restore_bottom_pipe =3D inst_pipe_ctx->bottom_pipe;
> > > -			restore_top_pipe =3D inst_pipe_ctx->top_pipe;
> > > -			inst_pipe_ctx->top_pipe =3D inst_pipe_ctx->bottom_pipe =3D NULL;
> > > -			dc->hwss.set_hubp_blank(dc, inst_pipe_ctx, true);
> > > -			inst_pipe_ctx->top_pipe =3D restore_top_pipe;
> > > -			inst_pipe_ctx->bottom_pipe =3D restore_bottom_pipe;
> > > +			hubp->funcs->set_blank(hubp, true);
> > >   		}
> > >   	}
> > > @@ -3747,10 +3732,3 @@ void dcn10_get_clock(struct dc *dc,
> > >   				dc->clk_mgr->funcs->get_clock(dc->clk_mgr, context, clock_type,=
 clock_cfg);
> > >   }
> > > -
> > > -void dcn10_set_hubp_blank(const struct dc *dc,
> > > -				struct pipe_ctx *pipe_ctx,
> > > -				bool blank_enable)
> > > -{
> > > -	pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp=
, blank_enable);
> > > -}
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.=
h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
> > > index 89e6dfb63da0..dee8ad1ebaa4 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
> > > @@ -204,8 +204,5 @@ void dcn10_wait_for_pending_cleared(struct dc *dc,
> > >   		struct dc_state *context);
> > >   void dcn10_set_hdr_multiplier(struct pipe_ctx *pipe_ctx);
> > >   void dcn10_verify_allow_pstate_change_high(struct dc *dc);
> > > -void dcn10_set_hubp_blank(const struct dc *dc,
> > > -				struct pipe_ctx *pipe_ctx,
> > > -				bool blank_enable);
> > >   #endif /* __DC_HWSS_DCN10_H__ */
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/driv=
ers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
> > > index 2f1b802e66a1..254300b06b43 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
> > > @@ -79,7 +79,6 @@ static const struct hw_sequencer_funcs dcn10_funcs =
=3D {
> > >   	.set_backlight_level =3D dce110_set_backlight_level,
> > >   	.set_abm_immediate_disable =3D dce110_set_abm_immediate_disable,
> > >   	.set_pipe =3D dce110_set_pipe,
> > > -	.set_hubp_blank =3D dcn10_set_hubp_blank,
> > >   };
> > >   static const struct hwseq_private_funcs dcn10_private_funcs =3D {
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/dri=
vers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > > index b79a17f6a9cc..48d1e0e2cf75 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>=20
> Additional hunk 1
> > > @@ -1576,7 +1576,7 @@ static void dcn20_update_dchubp_dpp(
> > >   	if (pipe_ctx->update_flags.bits.enable)
> > > -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
> > > +		hubp->funcs->set_blank(hubp, false);
> > >   }
> > > @@ -1772,10 +1772,19 @@ void dcn20_post_unlock_program_front_end(
> > >   	for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
> > >   		struct pipe_ctx *pipe =3D &context->res_ctx.pipe_ctx[i];
> > > +		struct pipe_ctx *mpcc_pipe;
> > >   		if (pipe->vtp_locked) {
> > > -			dc->hwss.set_hubp_blank(dc, pipe, true);
> > > +			dc->hwseq->funcs.wait_for_blank_complete(pipe->stream_res.opp);
> > > +			pipe->plane_res.hubp->funcs->set_blank(pipe->plane_res.hubp, true=
);
> > >   			pipe->vtp_locked =3D false;
> > > +
> > > +			for (mpcc_pipe =3D pipe->bottom_pipe; mpcc_pipe; mpcc_pipe =3D mp=
cc_pipe->bottom_pipe)
> > > +				mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res=
=2Ehubp, true);
> > > +
> > > +			for (i =3D 0; i < dc->res_pool->pipe_count; i++)
> > > +				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
> > > +					dc->hwss.disable_plane(dc, &dc->current_state->res_ctx.pipe_ctx=
[i]);
> > >   		}
> > >   	}
> > >   	/* WA to apply WM setting*/
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/driv=
ers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> > > index 51a4166e9750..de9dcbeea150 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
> > > @@ -94,7 +94,6 @@ static const struct hw_sequencer_funcs dcn20_funcs =
=3D {
> > >   	.optimize_timing_for_fsft =3D dcn20_optimize_timing_for_fsft,
> > >   #endif
> > >   	.set_disp_pattern_generator =3D dcn20_set_disp_pattern_generator,
> > > -	.set_hubp_blank =3D dcn10_set_hubp_blank,
> > >   };
> > >   static const struct hwseq_private_funcs dcn20_private_funcs =3D {
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/driv=
ers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> > > index 0597391b2171..074e2713257f 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> > > @@ -99,7 +99,6 @@ static const struct hw_sequencer_funcs dcn21_funcs =
=3D {
> > >   #endif
> > >   	.is_abm_supported =3D dcn21_is_abm_supported,
> > >   	.set_disp_pattern_generator =3D dcn20_set_disp_pattern_generator,
> > > -	.set_hubp_blank =3D dcn10_set_hubp_blank,
> > >   };
> > >   static const struct hwseq_private_funcs dcn21_private_funcs =3D {
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/dri=
vers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > > index ab93da667d51..d84164f0000c 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> > > @@ -938,53 +938,6 @@ void dcn30_hardware_release(struct dc *dc)
> > >   				dc->res_pool->hubbub, true, true);
> > >   }
> > > -void dcn30_set_hubp_blank(const struct dc *dc,
> > > -		struct pipe_ctx *pipe_ctx,
> > > -		bool blank_enable)
> > > -{
> > > -	struct pipe_ctx *mpcc_pipe;
> > > -	struct pipe_ctx *odm_pipe;
> > > -
> > > -	if (blank_enable) {
> > > -		struct plane_resource *plane_res =3D &pipe_ctx->plane_res;
> > > -		struct stream_resource *stream_res =3D &pipe_ctx->stream_res;
> > > -
> > > -		/* Wait for enter vblank */
> > > -		stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_V=
BLANK);
> > > -
> > > -		/* Blank HUBP to allow p-state during blank on all timings */
> > > -		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hub=
p, true);
> > > -		/* Confirm hubp in blank */
> > > -		ASSERT(plane_res->hubp->funcs->hubp_in_blank(plane_res->hubp));
> > > -		/* Toggle HUBP_DISABLE */
> > > -		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, true);
> > > -		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, false);
> > > -		for (mpcc_pipe =3D pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe =3D=
 mpcc_pipe->bottom_pipe) {
> > > -			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.=
hubp, true);
> > > -			/* Confirm hubp in blank */
> > > -			ASSERT(mpcc_pipe->plane_res.hubp->funcs->hubp_in_blank(mpcc_pipe-=
>plane_res.hubp));
> > > -			/* Toggle HUBP_DISABLE */
> > > -			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plan=
e_res.hubp, true);
> > > -			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plan=
e_res.hubp, false);
> > > -
> > > -		}
> > > -		for (odm_pipe =3D pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe =3D =
odm_pipe->next_odm_pipe) {
> > > -			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hu=
bp, true);
> > > -			/* Confirm hubp in blank */
> > > -			ASSERT(odm_pipe->plane_res.hubp->funcs->hubp_in_blank(odm_pipe->p=
lane_res.hubp));
> > > -			/* Toggle HUBP_DISABLE */
> > > -			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_=
res.hubp, true);
> > > -			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_=
res.hubp, false);
> > > -		}
> > > -	} else {
> > > -		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hub=
p, false);
> > > -		for (mpcc_pipe =3D pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe =3D=
 mpcc_pipe->bottom_pipe)
> > > -			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.=
hubp, false);
> > > -		for (odm_pipe =3D pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe =3D =
odm_pipe->next_odm_pipe)
> > > -			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hu=
bp, false);
> > > -	}
> > > -}
> > > -
> > >   void dcn30_set_disp_pattern_generator(const struct dc *dc,
> > >   		struct pipe_ctx *pipe_ctx,
> > >   		enum controller_dp_test_pattern test_pattern,
> > > @@ -994,6 +947,7 @@ void dcn30_set_disp_pattern_generator(const struc=
t dc *dc,
> > >   		int width, int height, int offset)
> > >   {
> > >   	struct stream_resource *stream_res =3D &pipe_ctx->stream_res;
> > > +	struct pipe_ctx *mpcc_pipe;
> > >   	if (test_pattern !=3D CONTROLLER_DP_TEST_PATTERN_VIDEOMODE) {
> > >   		pipe_ctx->vtp_locked =3D false;
> > > @@ -1005,12 +959,20 @@ void dcn30_set_disp_pattern_generator(const st=
ruct dc *dc,
>=20
> Additional hunk 2
> > >   		if (stream_res->tg->funcs->is_tg_enabled(stream_res->tg)) {
> > >   			if (stream_res->tg->funcs->is_locked(stream_res->tg))
> > >   				pipe_ctx->vtp_locked =3D true;
> > > -			else
> > > -				dc->hwss.set_hubp_blank(dc, pipe_ctx, true);
> > > +			else {
> > > +				/* Blank HUBP to allow p-state during blank on all timings */
> > > +				pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.h=
ubp, true);
> > > +
> > > +				for (mpcc_pipe =3D pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe =
=3D mpcc_pipe->bottom_pipe)
> > > +					mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_re=
s.hubp, true);
> > > +			}
> > >   		}
> > >   	} else {
> > > -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
> > >   		/* turning off DPG */
> > > +		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hub=
p, false);
> > > +		for (mpcc_pipe =3D pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe =3D=
 mpcc_pipe->bottom_pipe)
> > > +			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.=
hubp, false);
> > > +
> > >   		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res=
->opp, test_pattern, color_space,
> > >   				color_depth, solid_color, width, height, offset);
> > >   	}
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/dri=
vers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
> > > index 3b7d4812e311..e9a0005288d3 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
> > > @@ -80,8 +80,4 @@ void dcn30_set_disp_pattern_generator(const struct =
dc *dc,
> > >   		const struct tg_color *solid_color,
> > >   		int width, int height, int offset);
> > > -void dcn30_set_hubp_blank(const struct dc *dc,
> > > -		struct pipe_ctx *pipe_ctx,
> > > -		bool blank_enable);
> > > -
> > >   #endif /* __DC_HWSS_DCN30_H__ */
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/driv=
ers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> > > index 204444fead97..c4c14e9c1309 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
> > > @@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn30_funcs =
=3D {
> > >   	.hardware_release =3D dcn30_hardware_release,
> > >   	.set_pipe =3D dcn21_set_pipe,
> > >   	.set_disp_pattern_generator =3D dcn30_set_disp_pattern_generator,
> > > -	.set_hubp_blank =3D dcn30_set_hubp_blank,
> > >   };
> > >   static const struct hwseq_private_funcs dcn30_private_funcs =3D {
> > > diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> > > index b8bf6d61005b..bdad72140cbc 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
> > > @@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn301_funcs=
 =3D {
> > >   	.set_abm_immediate_disable =3D dcn21_set_abm_immediate_disable,
> > >   	.set_pipe =3D dcn21_set_pipe,
> > >   	.set_disp_pattern_generator =3D dcn30_set_disp_pattern_generator,
> > > -	.set_hubp_blank =3D dcn30_set_hubp_blank,
> > >   };
> > >   static const struct hwseq_private_funcs dcn301_private_funcs =3D {
> > > diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/driv=
ers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
> > > index 0586ab2ffd6a..613b3e3cb46a 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
> > > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
> > > @@ -231,10 +231,6 @@ struct hw_sequencer_funcs {
> > >   			enum dc_color_depth color_depth,
> > >   			const struct tg_color *solid_color,
> > >   			int width, int height, int offset);
> > > -
> > > -	void (*set_hubp_blank)(const struct dc *dc,
> > > -			struct pipe_ctx *pipe_ctx,
> > > -			bool blank_enable);
> > >   };
> > >   void color_space_to_black_color(
> > > --=20
> > > 2.30.1
> > >=20
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRo=
drigo.Siqueira%40amd.com%7C7700f89c242d4d5b837308d8d2d6cec7%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637491167330054893%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp=
;sdata=3DuxidmH%2FvP7CIAaeYbJHtqQ1GM%2BZt5zfbNyfCWnSkhR4%3D&amp;reserved=3D0
> >=20
>=20
> --=20
> Regards,
> Aurabindo Pillai

--=20
Rodrigo Siqueira
https://siqueira.tech

--cfbh5rfw6zl5djjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmAtNkEACgkQWJzP/com
vP9G/w//SPqyaDBzL9YQTGrU5QuewCcC8FTYaY+N1D41zaYNhB6PMbPo3dd4NUn2
VAN8US+N12HQ1rm3+CnJnzRGLycWWsRJulHCyzvfwTR5qL7KOGurxh+t10zSC/Yl
Kb0SsmY5DjJeSoirHMrWfNNMcPqL6rms2wbXl7O07LXNUviUs5VfR8fhdcBF6F5O
dB3Y0kiYVYERyM3PxnAFPjwkr6b8CUVwyOw1Llgmnjm4TNH0XupoK67A0qU45aPG
JDeDvSWax3PT6q/g1VuwGS/dfMhJ7eyXyTTndtY0h18n31MAYMTqtuMTrIcOAm5G
88T/udibWMrmGHJeZnSS8ZaB8a37c2lfskzM6GSWQq4wayMCxqEQQ8yl87YKbAC0
FDwg/UsxcAkl/D83FMXtSrI/3bgXNGixesnJWgvr6vw3G7n7ofoB3I1A6sRJ7CpC
RKBo4mLFQVVmVG3TcHOgpwlZyjaPI1u7LsDdNnP3j44+ZeftXB+FEFjGiscwjiE+
Ckk6slQIuhQ2BHGzVKnq8pRjTT+TgaHqp4I25+CSxxn6IqJl/HtAx64eoLxdo9El
CQBXQPttHaEx2B/nNbhk6nwppE4avXBZIxe/kyweHVZZW04I43NSpKmWgz9lSBy8
B/9bC93L2l3Dz/1gd7H7blgN3Tuyiusz9WPB5WboZeJuocrd2pM=
=xEp8
-----END PGP SIGNATURE-----

--cfbh5rfw6zl5djjf--

--===============1826556531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1826556531==--
