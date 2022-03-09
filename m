Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC5BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 07:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6711710E6A0;
	Wed,  9 Mar 2022 07:47:49 +0000 (UTC)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476AE10E6A0
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 07:47:48 +0000 (UTC)
Date: Wed, 09 Mar 2022 07:47:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1646812065;
 bh=fRARsxr9zi5NZqjUtX+i1REA45nQJNuwkujw5lkKIOM=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID;
 b=dX2Juhi4GyR0iKQyL+bAbRF4gr6EB7Z2K1IPyWXHUtsDfP4RDMxFr1mIt7d380yVw
 EvmAUD0D7PVjmKA90P3pHz4CBrtSQ8UWEX/GiGLlNlLrtaBe2CIQm64TGNpvy8rnBb
 hkBWY5YPdGDI8b3CnrD0dj55tP/poC98am+IN4HDXptcOsP5IBxlblLJ9t502poFi+
 G0kUzeBaa9uN4DxCEaIw95iLTcY1Ij+aTKufAxGNvEguZr8+qjRJ3Rc84veabtaVBi
 3jfbz1CJw6V/bjgbiR3P1JXYQYcUgv67OdSzwc81XgsNb7pCG+VjQ0xFYFjcQyj8GW
 7sGuRUDumG5rg==
To: Shashank Sharma <contactshashanksharma@gmail.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 1/2] drm: Add GPU reset sysfs event
Message-ID: <Ymb96aes4qNvdggMW_Icw6i6kbswV37jJ6T_8N6JmHlaZazbaHL8gV_LFbvLydLIawvKn1cN01mh6sWORSlLZ3BqzJtjsutf7OmCqBOzGag=@emersion.fr>
In-Reply-To: <20220308180403.75566-1-contactshashanksharma@gmail.com>
References: <20220308180403.75566-1-contactshashanksharma@gmail.com>
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
Cc: Shashank Sharma <shashank.sharma@amd.com>,
 Amaranath Somalapuram <amaranath.somalapuram@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alexandar Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Maybe it would be a good idea to state the intended use-case in the
commit message? And explain why the current (driver-specific IIRC) APIs
aren't enough?

Since this introduces new uAPI, can you point to a user-space patch
which uses the new uAPI? See this link for more info on DRM user-space
requirements:
https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspac=
e-requirements

Please use drm_dbg_* and drm_warn_* helpers instead of DRM_DEBUG and
DRM_WARN. This allows identifying on which device the uevent happens.

On Tuesday, March 8th, 2022 at 19:04, Shashank Sharma <contactshashanksharm=
a@gmail.com> wrote:

> +void drm_sysfs_reset_event(struct drm_device *dev, struct drm_reset_even=
t *reset_info)

reset_info can be const.
