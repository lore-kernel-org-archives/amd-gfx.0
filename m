Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5B1C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 15:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8064710E57D;
	Mon, 21 Sep 2026 15:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g1UyA5Ae";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4164110E92D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 15:45:10 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a60591bb18so2157515a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790005508; x=1790610308; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bYCQzeeKTAqelEXTIWZ3vmnp5EuDIbo0THp4+0qCWBE=;
 b=g1UyA5AeLhKW5lXV50AksQ2GZ3huwOhxxCGsRzVstBGrFKW4si0w+bAzngn+fK/Tt6
 bk9sLv4F+GWgiiJzHvkGXZ0KxYGHMoldjjWdf6o/Qn0jRRtse/xeMkk7VMAO3qhGQS+D
 FmtlQhrc5/FdKxi5qiU6CQpaqakIoiKkxWZ8YSyA4CiZILT559amRJag20O0RgphxlrP
 wN0HGAFFe3ZE7hmlOF2BJdrkLy3G7Nr4SP+edxTjWW6D+jdmbkCj2edRAti2jjEHJ69X
 3R0T6nIkG0w8yrDU14ILE9aDeRzyCs3khMBH5k7UUiKLWKdxcVIhI+83OMcceaQ/I1iV
 nF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790005508; x=1790610308;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bYCQzeeKTAqelEXTIWZ3vmnp5EuDIbo0THp4+0qCWBE=;
 b=kFOJX2xre+GeYNP1gu9m5iIt/4XBrk+WNadVb1mMkVIz+4wa/cCOTU77aL2dVvWqAQ
 gBA6oGutIoMhGvZ31bk02JC7KB+ZGugWKdJdebPAdmL/xl4/vPLD539DSw2t5+cdxzSo
 L1tT2r2wIQ9/5O+sby5JwiNnaRduMep45Rt+oCPgrbmMBG5OUx66KtCh0OqC9YVsrNDX
 Aoo1kj+baGvSU6klm6BBYOTYCQCVBHkSm3xAHxNUdaXrR9J6du/WX/MdATHTdgZg1OKh
 5yIVbS2w2xvWPP19JQ64E9bo5KJNESlwMGh5aQsV1wtPGrbirZvViN3tnjTJGTKOi8N7
 xSvQ==
X-Gm-Message-State: AFuF++km7b8JZC68BsQ1lv7SblxTNNelvVpK4ABHvAPwIQdJOzzpMmli
 AaUu94HghOtCCH9AssotuvRcsGRzkkNCz+I08NLhLLNIZmZHxalIiR06vrVGzeif
X-Gm-Gg: AYBFou2o5/8dZk0jPqYF9gImw0QNvFfKax9/OmaJqgPnQaZzKkhd9laBm1bnuR/Bl7j
 5emTdADuU13kJdnEIeLVfbxUlo5BvV394ZNUCMhbhiM7ONKw05WqS14EpyAYpEiStfxbSEs4GY9
 0m17IV8SPj3CeoiTh4zPGU36aRY6Ei3DFlRukzbr8intKkEtj5afHbUW3kY3SWj1Qc5e/LN8ptJ
 W4UPgiaUk0hmyqGeyIswiUuRNvdB4vf/uJ0eY9YjbkG5v7d/9lTYmo30trriOz6hhV0qdgVty2a
 t1ONYBOf87bi0V8RMoApjeHNxIAPQENZgxTq62vR8gFliq9E/rKOGYvtmokWLVmLHii9I+nyPAi
 5FuZSkelhkt384OxPMIAglZdzHm5qQswAtdMeq7Ibj4LqXZIcs0n8+PQCLxfawunUhlh9mn0LZF
 Gw4BLeK0mJ51R3ZywRyEoopYM+MLzLi5KvELL7a/rdm5s66xzGx/TH/5olBHgOCpAfDN4TanORi
 riE0avDhF/Gg6xexaMubwjNKY+MXzAhBPfj3qNb8Rlo1zRSrAYAm1S2
X-Received: by 2002:a17:907:6e88:b0:c26:25e6:5c73 with SMTP id
 a640c23a62f3a-c2a8d44da7emr3548966b.2.1790005508218; 
 Mon, 21 Sep 2026 08:45:08 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a35238844sm343301066b.9.2026.09.21.08.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:45:07 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Leo Li <sunpeng.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix fast updates on DCE6
Date: Mon, 21 Sep 2026 17:45:06 +0200
Message-ID: <XCnQ5RUGT9OGWjHyNHZD_g@gmail.com>
In-Reply-To: <a6811dd1-d8aa-4009-b571-f4ab1327e5ed@amd.com>
References: <20260921104136.23990-1-timur.kristof@gmail.com>
 <bf98fdda-fc0b-45d5-830a-df65bef804e6@amd.com>
 <a6811dd1-d8aa-4009-b571-f4ab1327e5ed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, September 21, 2026 5:43:31=E2=80=AFPM Central European Summer Ti=
me Mario=20
Limonciello wrote:
> On 9/21/26 10:33, Mario Limonciello wrote:
> > On 9/21/26 05:41, Timur Krist=C3=B3f wrote:
> >> DCE6 should use legacy fast updates, just like all DCE8 - DCN2.
> >>=20
> >> Technically DCE6 should have been included when the fast update
> >> code was refactored, but it just happened to work until now.
> >>=20
> >> A recent commit "Attach only plane updates that actually changed"
> >> has exposed this issue because with that commit, DC accidentally
> >> took the new fast update code path for DCE6 as well, which caused
> >> it to boot into a black screen with a flip done timeout.
> >>=20
> >> This fix should be backported to all kernel versions that
> >> have "Refactor fast update to use new HWSS build sequence",
> >> but this patch won't apply cleanly to older kernels due to
> >> another refactor in "Remove dc param from check_update".
> >>=20
> >> Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new
> >> HWSS build sequence")
> >> Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from
> >> check_update")
> >> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >=20
> > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>> ---
> >=20
> >>   .../drm/amd/display/dc/resource/dce60/dce60_resource.c    | 8 ++++++=
++
> >>   1 file changed, 8 insertions(+)
> >>=20
> >> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/
> >> dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/
> >> dce60_resource.c
> >> index d2d56a1c4b8b..f4efa55952f3 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> >> @@ -448,6 +448,12 @@ static const struct dce_abm_mask abm_mask =3D {
> >>           ABM_MASK_SH_LIST_DCE110(_MASK)
> >>   };
> >> +static const struct dc_debug_options debug_defaults =3D { 0 };
> >> +
> >> +static const struct dc_check_config config_defaults =3D {
> >> +    .enable_legacy_fast_update =3D true,
> >> +};
> >> +
> >>   #define CTX  ctx
> >>   #define REG(reg) mm ## reg
> >> @@ -937,6 +943,8 @@ static bool dce60_construct(
> >>       dc->caps.max_cursor_size =3D 64;
> >>       dc->caps.dual_link_dvi =3D true;
> >>       dc->caps.extended_aux_timeout_support =3D false;
> >> +    dc->debug =3D debug_defaults;
> >> +    dc->check_config =3D config_defaults;
> >>       /*************************************************
> >>        *  Create resources                             *
>=20
> I would be remiss not to share something the code-review agent flagged
> when testing this for merge.
>=20
> ---
> Incomplete fix: this is only dce60_construct(), which
> dc_create_resource_pool() uses for DCE_VERSION_6_0 (Tahiti / Pitcairn /
> Cape Verde) only.
>=20
> dce60_resource.c has two more constructors that are reached for the
> other SI parts (see resource_parse_asic_id() in core/dc_resource.c:150-15=
8):
>=20
> dce61_construct() (line 1120) -> DCE_VERSION_6_1 (Hainan)
> dce64_construct() (line 1318) -> DCE_VERSION_6_4 (Oland)
> Neither gets dc->check_config assigned, so enable_legacy_fast_update
> stays false there (dc is kvzalloc'd in dc_create()), and both keep
> taking the new fast-update path that ac8349780c5d exposes. They should
> hit exactly the same black screen / flip-done timeout this patch is
> fixing, since all three share dce60_hw_sequencer_construct() and
> dce60_res_pool_funcs.
>=20
> Suggest adding the same two lines to both, e.g. after dc->caps.is_apu =3D
> true; at line 1144 (dce61) and line 1342 (dce64):
>=20
> dc->debug =3D debug_defaults;
> dc->check_config =3D config_defaults;
> ---
>=20
> I'll hold up the merge to decide what to do (we can just have a v2 if
> you want).

Thanks for calling that out. I'll send a second version.




