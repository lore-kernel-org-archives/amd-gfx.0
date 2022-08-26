Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F97ECAAD2
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 07:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A44AF10E6EB;
	Fri, 26 Aug 2022 07:38:16 +0000 (UTC)
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DC310E6EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 07:38:13 +0000 (UTC)
Date: Fri, 26 Aug 2022 07:38:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1661499490; x=1661758690;
 bh=rAB7sbS8TgCVg7H7gMYgtwHBY3evsKvLH4X7oqTXPZ4=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=Z7esCrVCjfgYmL8T0+mL26ZzzYB38V9x4xuVKeesOaK6y0LoeQbeYDhz5+lT0gznq
 pynarrdSTZSuli7qx2qwazF72UKlLRrb+ublmIWt2T7Dm+XRjfjW/BFNUAX9vPH4Dl
 bXFXygdsLuHlzF3/9pAKgIiOpIkjeRPAsglwmc5lYfUdquPUL6vehbRwEEU/Tdydwi
 GYerGrGsTfnbi4t6nuJrLbt678injp54IgxTbKogbVWAKvOtx4W9JiBUrD0FulwI7R
 Fvl7tvNadGb8UjvdehSEzwYKQeMhWpIk6lOYOM9LGbQl1fYKgB9U8RxBAOUOJ6RZtb
 qjgCKJs/4Ba4Q==
To: Alex Deucher <alexdeucher@gmail.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 4/4] amd/display: indicate support for atomic async
 page-flips on DCN
Message-ID: <A_ZL55UlxqGGQnHrxTxvFZMCn1HkWbIuaZvtrOnir7mO6YCY8hhyYwjwKjv79SEEBLqbosVtxx0rVeCTso1RktRjY3ECNyLssw77of_D2sM=@emersion.fr>
In-Reply-To: <CADnq5_MX0Qh7v-Wy1nBhMEWT9bhmQn4W-2Wo97CZgKcby1Xc+w@mail.gmail.com>
References: <20220824150834.427572-1-contact@emersion.fr>
 <20220824150834.427572-5-contact@emersion.fr>
 <CADnq5_MX0Qh7v-Wy1nBhMEWT9bhmQn4W-2Wo97CZgKcby1Xc+w@mail.gmail.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: daniel.vetter@ffwll.ch, amd-gfx@lists.freedesktop.org, mwen@igalia.com,
 dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, hwentlan@amd.com,
 nicholas.kazlauskas@amd.com, joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thursday, August 25th, 2022 at 20:22, Alex Deucher <alexdeucher@gmail.co=
m> wrote:

> On Wed, Aug 24, 2022 at 11:09 AM Simon Ser contact@emersion.fr wrote:
>=20
> > amdgpu_dm_commit_planes already sets the flip_immediate flag for
> > async page-flips. This flag is used to set the UNP_FLIP_CONTROL
> > register. Thus, no additional change is required to handle async
> > page-flips with the atomic uAPI.
> >=20
> > Note, async page-flips are still unsupported on DCE with the atomic
> > uAPI. The mode_set_base callbacks unconditionally set the
> > GRPH_SURFACE_UPDATE_H_RETRACE_EN field of the GRPH_FLIP_CONTROL
> > register to 0, which disables async page-flips.
>=20
> Can you elaborate a bit on this? We don't use hsync flips at all, even
> in non-atomic, as far as I recall. The hardware can also do immediate
> flips which take effect as soon as you update the base address
> register which is what we use for async updates today IIRC.

When user-space performs a page-flip with the legacy KMS uAPI on DCE
ASICs, amdgpu_display_crtc_page_flip_target() is called. This function
checks for the DRM_MODE_PAGE_FLIP_ASYNC flag, sets work->async, which
is then passed as an argument to adev->mode_info.funcs->page_flip() by
amdgpu_display_flip_work_func(). Looking at an implementation, for
instance dce_v10_0_page_flip(), the async flag is used to set that
GRPH_FLIP_CONTROL register:

=09/* flip at hsync for async, default is vsync */
=09tmp =3D RREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset);
=09tmp =3D REG_SET_FIELD(tmp, GRPH_FLIP_CONTROL,
=09=09=09    GRPH_SURFACE_UPDATE_H_RETRACE_EN, async ? 1 : 0);
=09WREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset, tmp);

I don't know how the hardware works, but I assumed it would be
necessary to do the same in the atomic uAPI code-path as well. However
dce_v10_0_crtc_do_set_base() has this code block:

=09/* Make sure surface address is updated at vertical blank rather than
=09 * horizontal blank
=09 */
=09tmp =3D RREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset);
=09tmp =3D REG_SET_FIELD(tmp, GRPH_FLIP_CONTROL,
=09=09=09    GRPH_SURFACE_UPDATE_H_RETRACE_EN, 0);
=09WREG32(mmGRPH_FLIP_CONTROL + amdgpu_crtc->crtc_offset, tmp);

Which unconditionally sets that same register.

Either way, it's not a very big deal for this patch series, DCE and DCN
are separate, DCE can be sorted out separately.

Am I completely mistaken here?

Thanks,

Simon
