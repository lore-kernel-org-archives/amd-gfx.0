Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40C0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 09:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D9960EFE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 09:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 73D9960EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EF506E824;
	Tue, 12 Oct 2021 09:16:04 +0000 (UTC)
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E36486E824
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 09:16:02 +0000 (UTC)
Date: Tue, 12 Oct 2021 09:15:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1634030160;
 bh=QZW3z27uTjk7iq1mE4l0Td3zpbgtO4lx9r20xXMvZBQ=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=OxXkrvIIhUrTXokMzEe7uZ3DAyYDQ9cTydVQfi4OdV9POrbQ2wx7ZG+ahdhxrIF7Q
 I0P9KNkCIqwimpdmRo1FYQMWhrC5Qb0TdtLHabNsXrY9JYHR8tk/UZbFNf/k6onWR2
 EOe89yr7fk8LcrbyISI+t7KGIImPE5SgvSPSKhMNUY0nX0+aiaFG535sNV5D2udt+8
 BjPKYFxlE/J5JHpBGrmZOcnSwgutYL7o5vDAe0fFtqUCDdClEC7EsQ8f3QirGDNCil
 CtmIs6oab8XmJZ7wwCBp1vl0dTIfESPeSk0b4M3RvIeVIkS4sn0z6ugSRDrSKRYok2
 YJ7EuyX+iQ4hg==
To: Paul Menzel <pmenzel@molgen.mpg.de>
From: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Sean Paul <seanpaul@chromium.org>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v5] amd/display: only require overlay plane to cover whole
 CRTC on ChromeOS
Message-ID: <L-g5Eua556aLUOp3ikTg8s3Te9CMSKsDoO14SNj3-A7yn0jRNgzGovqdBFKgpKavD_LtHh6Yeig8FOO_kLG9uCcFxP5887tZWH3NROlQtyY=@emersion.fr>
In-Reply-To: <0ad9c8ef-974f-8b94-d8c9-35efd9f1f1b3@molgen.mpg.de>
References: <20211011151609.452132-1-contact@emersion.fr>
 <0ad9c8ef-974f-8b94-d8c9-35efd9f1f1b3@molgen.mpg.de>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, October 12th, 2021 at 11:08, Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:

> > the cursor plane (which uses the legacy API). Thus amdgpu must always
> > be prepared to enable/disable/move the cursor plane at any time without
> > failing (or else ChromeOS will trip over).
>
> What ChromeOS version did you test with? Are there plans to improve
> ChromeOS?

No idea, I haven't received feedback from the ChromeOS folks.

> > As discussed in [1], there's no reason why the ChromeOS limitation
> > should prevent other fully atomic users from taking advantage of the
> > overlay plane. Let's limit the check to ChromeOS.
>
> How do we know, no other userspace programs are affected, breaking
> Linux=E2=80=99 no-regression in userspace policy?

Actually this is the other way around: the ChromeOS fix which landed
has broken my user-space. This patch tries to fix the situation for
both ChromeOS and gamescope.

That said, it seems like amdgpu maintainers are open to just revert the
ChromeOS fix, thus fixing gamescope. ChromeOS can carry the fix in their
kernel tree. More on that soon.

> > v4: fix ChromeOS detection (Harry)
> >
> > v5: fix conflict with linux-next
> >
> > [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxuc=
x8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=
=3D@emersion.fr/
> >
> > Signed-off-by: Simon Ser <contact@emersion.fr>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Cc: Sean Paul <seanpaul@chromium.org>
> > Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when =
using overlay")
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 ++++++++++++++++++=
+
> >   1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index f35561b5a465..2eeda1fec506 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -10594,6 +10594,31 @@ static int add_affected_mst_dsc_crtcs(struct d=
rm_atomic_state *state, struct drm
> >   }
> >   #endif
> >
> > +static bool is_chromeos(void)
> > +{
> > +=09struct mm_struct *mm =3D current->mm;
> > +=09struct file *exe_file;
> > +=09bool ret;
> > +
> > +=09/* ChromeOS renames its thread to DrmThread. Also check the executa=
ble
> > +=09 * name. */
> > +=09if (strcmp(current->comm, "DrmThread") !=3D 0 || !mm)
> > +=09=09return false;
> > +
> > +=09rcu_read_lock();
> > +=09exe_file =3D rcu_dereference(mm->exe_file);
> > +=09if (exe_file && !get_file_rcu(exe_file))
> > +=09=09exe_file =3D NULL;
> > +=09rcu_read_unlock();
> > +
> > +=09if (!exe_file)
> > +=09=09return false;
> > +=09ret =3D strcmp(exe_file->f_path.dentry->d_name.name, "chrome") =3D=
=3D 0;
> > +=09fput(exe_file);
> > +
> > +=09return ret;
> > +}
> > +
> >   static int validate_overlay(struct drm_atomic_state *state)
> >   {
> >   =09int i;
> > @@ -10601,6 +10626,10 @@ static int validate_overlay(struct drm_atomic_=
state *state)
> >   =09struct drm_plane_state *new_plane_state;
> >   =09struct drm_plane_state *primary_state, *overlay_state =3D NULL;
> >
> > +=09/* This is a workaround for ChromeOS only */
> > +=09if (!is_chromeos())
> > +=09=09return 0;
>
> I would have expected the check to be the other way around, as no the
> behavior on non-Chrome OS is changed?

This function performs a check which is only necessary on ChromeOS. On
non-ChromeOS, this function prevents user-space from using some hardware
features. The early return ensures non-ChromeOS user-space can use these
features.
