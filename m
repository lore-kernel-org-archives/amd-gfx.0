Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C267DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 21:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C6760EBB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 21:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 85C6760EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022A86E44C;
	Tue, 12 Oct 2021 21:03:50 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86A756E44C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 21:03:48 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id e63so972791oif.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XwlOoEugJhROTpyf+kyA8oPUmPkL/UPaxVtDNJbQJZI=;
 b=RyIhtXCiealybhRcioUdeearsZnwyd765HaIe9NJdNE0MRJCTIKJEp03wj/mLvNRG4
 qfIsuxs2XNVKdgTsiTwBQxCpwrZCDM1X6RlFuSMsmzcsT/pX3XUJfsWt3jJ790V8XdXi
 M3Qs+ssRDOgb7eSQV2CB26mP55xiX7Y3W7ZfVxNRCwQrFCZrqkPTMkXBG8dCwQymRBMO
 WrIKUSTreUkDdqlqZucvBLbpEmLt5c/8lkTXBrPiKP75GwXDZfVTxFZgQiUkNUxEsQBj
 ppW8rCyrp10EZKFCRuaYH+lg8bmZ91QnHH4zlwbQPLLyLyFzNKTyH2yBetPzOSypiAEt
 MbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XwlOoEugJhROTpyf+kyA8oPUmPkL/UPaxVtDNJbQJZI=;
 b=pXZ9Gcz3+tXvfZdtUV8qyN8BSbHJlq1XwvqgHNAYAiw3t1ekEp7PhjVpdmOa8cOeER
 ibRZD5Ugq4gmf9PZUKWhXKf0FMJdfY9SB/x+hBdYXU0/Qr6pMlNwze+53itXI4tZzRR8
 MBWxI9rhF+CsouhcTYikccSXL8SuS18lxBSS9ZiAv8W6EdFCk6IVwnRE5s0V8YKz+R4a
 r7vc7rEAswVTbRRenERiSMHQ9/S+WqC654UhqksYoLrn6odsxCNuSFDhUam/Fu6Nz8sh
 WtlXmVJrhV1VjZ+iTQd2yPkPQDe+Y0oCESjuraaLf7Z3YwxA94RASAUS/7DFXvS/zn4N
 up1A==
X-Gm-Message-State: AOAM532rLv/FSOez31Ny8mAFgChBwFquFkWaxCeMCNfQryFZbqNXSZL3
 uhqlX19BuwWGZP3gxt07KcvYWzRolC5fJTD9JYI=
X-Google-Smtp-Source: ABdhPJwryr/0IuHwr/NY/c/j6ioApiPFdzZNERu/tTtTbxBf/C+bYmK98ic4Itg5G59nH4pX5bepI3P5rulNEsS2doY=
X-Received: by 2002:aca:4587:: with SMTP id s129mr5284645oia.5.1634072627882; 
 Tue, 12 Oct 2021 14:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211011151609.452132-1-contact@emersion.fr>
 <44154452-aa21-3f08-ffe8-e68fb8036271@amd.com>
 <CADnq5_M-13Sf1g4cw0Qt=qps72GEweZM-SrhQ9obLRsVr8_zfQ@mail.gmail.com>
 <f7f76c65-8e7e-67fc-414b-761702a97fe3@amd.com>
In-Reply-To: <f7f76c65-8e7e-67fc-414b-761702a97fe3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Oct 2021 17:03:36 -0400
Message-ID: <CADnq5_PaWhieZjz_OrLUhx75erV8A+GVkU5FhPOiDfDgscyXvw@mail.gmail.com>
Subject: Re: [PATCH v5] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
To: Harry Wentland <harry.wentland@amd.com>
Cc: Simon Ser <contact@emersion.fr>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 12, 2021 at 4:57 PM Harry Wentland <harry.wentland@amd.com> wro=
te:
>
>
>
> On 10/12/21 3:57 PM, Alex Deucher wrote:
> > On Tue, Oct 12, 2021 at 10:39 AM Harry Wentland <harry.wentland@amd.com=
> wrote:
> >>
> >> On 2021-10-11 11:16, Simon Ser wrote:
> >>> Commit ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication whe=
n
> >>> using overlay") changed the atomic validation code to forbid the
> >>> overlay plane from being used if it doesn't cover the whole CRTC. The
> >>> motivation is that ChromeOS uses the atomic API for everything except
> >>> the cursor plane (which uses the legacy API). Thus amdgpu must always
> >>> be prepared to enable/disable/move the cursor plane at any time witho=
ut
> >>> failing (or else ChromeOS will trip over).
> >>>
> >>> As discussed in [1], there's no reason why the ChromeOS limitation
> >>> should prevent other fully atomic users from taking advantage of the
> >>> overlay plane. Let's limit the check to ChromeOS.
> >>>
> >>> v4: fix ChromeOS detection (Harry)
> >>>
> >>> v5: fix conflict with linux-next
> >>>
> >>> [1]: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flore.kernel.org%2Famd-gfx%2FJIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQArpQu=
7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0%3D%40emers=
ion.fr%2F&amp;data=3D04%7C01%7Charry.wentland%40amd.com%7Cf5038651be2d44b2d=
11208d98dba8a8e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63769665460234=
4329%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik=
1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D83wfZCmSw3IpY%2BRxgnVB4YqABUf8W%2Bg=
YCynDzLvFU7g%3D&amp;reserved=3D0>>
> >>> Signed-off-by: Simon Ser <contact@emersion.fr>
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Cc: Harry Wentland <hwentlan@amd.com>
> >>> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> >>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> >>> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> >>> Cc: Sean Paul <seanpaul@chromium.org>
> >>> Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication whe=
n using overlay")
> >>
> >> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >
> > @Harry Wentland, @Simon Ser Do you have a preference on whether we
> > apply this patch or revert ddab8bd788f5?  I'm fine with either.
> >
>
> Is get_mm_exe_file missing on linux-next? I'm okay either
> way but haven't looked closely at linux-next.

Yes, it was removed in 5.15.

Alex

>
> Another option, as discussed by Simon on IRC, might be
> to take this patch only on the Chrome kernels, though
> it would be nice to avoid custom patches on Chrome kernels.
>
> Harry
>
> > Alex
> >
> >>
> >> Harry
> >>
> >>> ---
> >>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 ++++++++++++++++=
+++
> >>>   1 file changed, 29 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> index f35561b5a465..2eeda1fec506 100644
> >>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> >>> @@ -10594,6 +10594,31 @@ static int add_affected_mst_dsc_crtcs(struct=
 drm_atomic_state *state, struct drm
> >>>   }
> >>>   #endif
> >>>
> >>> +static bool is_chromeos(void)
> >>> +{
> >>> +     struct mm_struct *mm =3D current->mm;
> >>> +     struct file *exe_file;
> >>> +     bool ret;
> >>> +
> >>> +     /* ChromeOS renames its thread to DrmThread. Also check the exe=
cutable
> >>> +      * name. */
> >>> +     if (strcmp(current->comm, "DrmThread") !=3D 0 || !mm)
> >>> +             return false;
> >>> +
> >>> +     rcu_read_lock();
> >>> +     exe_file =3D rcu_dereference(mm->exe_file);
> >>> +     if (exe_file && !get_file_rcu(exe_file))
> >>> +             exe_file =3D NULL;
> >>> +     rcu_read_unlock();
> >>> +
> >>> +     if (!exe_file)
> >>> +             return false;
> >>> +     ret =3D strcmp(exe_file->f_path.dentry->d_name.name, "chrome") =
=3D=3D 0;
> >>> +     fput(exe_file);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +
> >>>   static int validate_overlay(struct drm_atomic_state *state)
> >>>   {
> >>>        int i;
> >>> @@ -10601,6 +10626,10 @@ static int validate_overlay(struct drm_atomi=
c_state *state)
> >>>        struct drm_plane_state *new_plane_state;
> >>>        struct drm_plane_state *primary_state, *overlay_state =3D NULL=
;
> >>>
> >>> +     /* This is a workaround for ChromeOS only */
> >>> +     if (!is_chromeos())
> >>> +             return 0;
> >>> +
> >>>        /* Check if primary plane is contained inside overlay */
> >>>        for_each_new_plane_in_state_reverse(state, plane, new_plane_st=
ate, i) {
> >>>                if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) {
> >>>
> >>
