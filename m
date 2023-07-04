Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F99EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 17:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74C210E308;
	Tue,  4 Jul 2023 17:57:15 +0000 (UTC)
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7443E10E308;
 Tue,  4 Jul 2023 17:57:14 +0000 (UTC)
Date: Tue, 04 Jul 2023 17:57:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail; t=1688493430; x=1688752630;
 bh=A2izVLmKnAOTqixZ0m4jX7wiQ2V2QLpbP3fSp42+WRM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=jLOT0tTOSkxg8LjsDKwNgrKPXhldiiJRdpMIbXZkpOBkxXNeUOuZRywdmJQ3P5Iyj
 5gS9lyB8ymKw9JkTmUADEugrz8sXHNTeCwLtupS9/s7OeQgB1AQn78MreulGdGYQlP
 jeEnR3wNf2uCLNv5pbKuOXwfqjoNiqedMqpfxmLt5Ky4be6d9eGZmEVAMAiknPZ09x
 zf2Rpba1PK1XH0rt8t3qh5e4LQielBdGT/2IM1JpXdSAxhd0zc878dNGrRObqt96k8
 7TtIV+42MtycK7nRw24lo+YlCQTldLM2P7571yupf7SyqqynFLkf2W/fHsZ9qWtnlk
 MJwvS5XEUjwaA==
To: Sebastian Wick <sebastian.wick@redhat.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v4 1/6] drm: allow DRM_MODE_PAGE_FLIP_ASYNC for atomic
 commits
Message-ID: <p-vKlt6LWsnO1-Ent-Y3sCt_NhITc2WrYQarRLJ2fIjxYFenrM9zCg6_YZxyh0gAaCXeBWGBnS5ww_aeT-EG95IsDTm5J-YegFrbINCC98w=@emersion.fr>
In-Reply-To: <CA+hFU4y+kHitNsqb1WC6dHE5hr=1S6gJeyHXC5mv9Ads5mdgWw@mail.gmail.com>
References: <20230701020917.143394-1-andrealmeid@igalia.com>
 <20230701020917.143394-2-andrealmeid@igalia.com>
 <CA+hFU4y+kHitNsqb1WC6dHE5hr=1S6gJeyHXC5mv9Ads5mdgWw@mail.gmail.com>
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
Cc: pierre-eric.pelloux-prayer@amd.com,
 =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 =?utf-8?Q?Marek_Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Italo Nicola <italonicola@collabora.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, Pekka Paalanen <ppaalanen@gmail.com>,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, hwentlan@amd.com, christian.koenig@amd.com,
 joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tuesday, July 4th, 2023 at 19:06, Sebastian Wick <sebastian.wick@redhat.=
com> wrote:

> > + * When used with atomic uAPI, the driver will return an error if the =
hardware
> > + * doesn't support performing an asynchronous page-flip for this updat=
e.
> > + * User-space should handle this, e.g. by falling back to a regular pa=
ge-flip.
> > + *
> > + * Note, some hardware might need to perform one last synchronous page=
-flip
> > + * before being able to switch to asynchronous page-flips. As an excep=
tion,
> > + * the driver will return success even though that first page-flip is =
not
> > + * asynchronous.
>=20
> What would happen if one commits another async KMS update before the
> first page flip? Does one receive EAGAIN, does it amend the previous
> commit? What happens to the timing feedback?
>=20
> This seems really risky to include tbh. I would prefer if we would not
> add such special cases for now.

This is not a new case, i915 already does this with the legacy API to
address some hw issues. Sadly I don't think we can do anything about
it.
