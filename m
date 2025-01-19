Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7DDC0218A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 08:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7A410E17A;
	Mon, 20 Jan 2025 08:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="BoI8qbSw";
	dkim-atps=neutral
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205DA10E1CA
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2025 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1737318337; x=1737577537;
 bh=obc318t203nN1+0TEPdFxqLbY2WPWDqJwpACIchGvU8=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=BoI8qbSwFsMA/yY40Mt3Ag1YtI9lcK7wIULM3OlL7FBo/pZobQrZSaOUw2ofYnQ+G
 4FeE6Yt5J2kLWUQalBPHvQc9aHyog+Hk8g9ubqTfdW4PH2SlcsQYUEXyrY1BOe0EcG
 zjfULVeQqrcRq4t6RLnpVRbEBN7TrWDmklg/Pvqwi7GpCYAhClvNF6pO2UO6HdnANG
 lCYgW+V8sV7kf4/eBcbCs5loJ5q8uVzaTBp6hLRtSAT1iXVBOwvsPTyOdNRUW9SYMH
 7WN4bNpSnS60BNwxGRM6tbKYvR1G/uHd5+qGu1kV4TIFVtFkZCb969hp8vbl3QijmZ
 MPXaxdh4qO0vw==
Date: Sun, 19 Jan 2025 20:25:31 +0000
To: Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: SyntheticBird <syntheticbirdxmr@protonmail.com>
Subject: Re: drm/amdgpu: AMDGPU unusable since 6.12.1 and it looks like no one
 cares.
Message-ID: <EefQ4XqoUhDVKwtzYbP7Cwv1m6p8brSTBJzVQeojHh8X688L3QdBfGkakTuU0yf3lWfne5Bhcj90MXHhB9nblEqobkXeWvluAnwrplGkH2A=@protonmail.com>
In-Reply-To: <8o8j5o9K-GIowaV5BW0uUds5QSczbsDlObPMAEUyGjPMV1G2tq-3sdYaQwbZHt_d4p-9sqBe5OnsUkkbS2gb6eZT1d5KiOXyTdz3vy75_V8=@protonmail.com>
References: <o93Aruut7VI05oqVX7Se1udr5FAyqfyP_TGDutW0p2fXBSkRv7QkhpLmAT-buTpdWIwn8PnC8B2DNSMtaTp5kk00ZtK653PDLuK14uoUI4k=@protonmail.com>
 <CADnq5_PatAYdyKGVJpX5TrVJ451Ga9PJjCx85jna+CUxsaFAhA@mail.gmail.com>
 <8o8j5o9K-GIowaV5BW0uUds5QSczbsDlObPMAEUyGjPMV1G2tq-3sdYaQwbZHt_d4p-9sqBe5OnsUkkbS2gb6eZT1d5KiOXyTdz3vy75_V8=@protonmail.com>
Feedback-ID: 130782727:user:proton
X-Pm-Message-ID: fead886dd9461dc58b9d280cafeddcf0b0f4a792
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 20 Jan 2025 08:46:01 +0000
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


Hello,

One person on the Gitlab issue have potentially bisected the commit causing=
 the kernel freeze: https://gitlab.freedesktop.org/drm/amd/-/issues/3787#no=
te_2741901

https://gitlab.freedesktop.org/drm/kernel/-/commit/de848da12f752170c2ebe114=
804a985314fd5a6a

Also I apologize Alex I think I sent you an email without cc the mailing li=
st.

On Tuesday, January 14th, 2025 at 3:02 PM, SyntheticBird <syntheticbirdxmr@=
protonmail.com> wrote:

>=20
>=20
>=20
>=20
>=20
>=20
>=20
> On Tuesday, January 14th, 2025 at 2:44 PM, Alex Deucher alexdeucher@gmail=
.com wrote:
>=20
> > On Tue, Jan 14, 2025 at 9:05=E2=80=AFAM SyntheticBird
> > syntheticbirdxmr@protonmail.com wrote:
> >=20
> > > Hello and happy new year to all members of this list.
> > >=20
> > > I know that mailing lists aren't meant for begging for support, but a=
fter discussing this in another distribution channel, it seems to me like i=
t is the only way for me and other users to grab the attention of a maintai=
ner.
> > >=20
> > > Since 6.12.1, several users have reported a kernel freeze issue with =
AMDGPU, including a complete stack trace. It corresponds to the following i=
ssues on GitLab:
> > >=20
> > > https://gitlab.freedesktop.org/drm/amd/-/issues/3787https://gitlab.fr=
eedesktop.org/drm/amd/-/issues/3866
> > >=20
> > > I also suspect this issue may have happened to one user on the Level1=
Tech forum: https://forum.level1techs.com/t/help-with-troubleshooting-freez=
ing-with-linux-kernel-6-12-on-arch/221340/22
> > >=20
> > > Two months have passed since the first report of this bug, and no one=
 in either of the two issues has ever reached out to us. I've checked the m=
ailing list archive, and it seems like no maintainer has ever discussed it.=
 We're simply left alone with only hope.
> > >=20
> > > I perfectly understand that maintainers are busy, and I do not blame =
them, but we as users and owners of AMDGPU have no other choice but to try =
reaching out to you, to at least be sure that this issue hasn't been ignore=
d in the depths of the GitLab issue list.
> > >=20
> > > This issue is impacting versions 6.12.1 to the latest 6.13 rc. Severa=
l users are still stuck on either 6.6 LTS or 6.11.9-10. For users relying o=
n features that have been introduced between 6.6 and 6.12, they cannot down=
grade to 6.6 and also cannot upgrade to 6.12, leaving them without vulnerab=
ilities being patched on mainline and LTS.
> >=20
> > Per my comments on the bug report, did you also update mesa or GPU
> > firmware? If so, can you narrow down if any of those other components
> > had an impact? Alternatively, can you bisect the kernel? If you have
> > known good and bad kernels, it would be really helpful if you could
> > bisect to identify what commit caused the regression for you.
> >=20
> > Alex
>=20
>=20
> Hi,
>=20
> Thanks Alex for reaching out. Also per my comment on the bug report, I ca=
n't right now but will be able to bisect during this week-end.
> I do have two versions of the kernel one good (6.11.10) and one bad (6.12=
.1).
> I checked and both mesa (24.3.3) and firmware (20241210) are up to date.
>=20
> I will update here whenever I find the commit.
