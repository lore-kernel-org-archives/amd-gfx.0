Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA16BCA600B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E2110E3BE;
	Mon, 19 Jan 2026 08:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xv2IQuuG";
	dkim-atps=neutral
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6369210E2AA
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 11:42:18 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id
 4fb4d7f45d1cf-64d00702990so637608a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 03:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768736537; x=1769341337; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=te6FnboAFJ6x9uRbg9PS2os1I8lYLucGhR7IWQ0O5mc=;
 b=Xv2IQuuGmjJbkh4+e/6AG92ZAwngLTOtTzP8JimKvSxm7lLcPfmZo7z/tU/ficeLnk
 E5WDGr2qzS6aPlfKi5l9rPFXSpRUC+mGEGt7/EyCUiznGY58jOeFa7elr0Aakbe1UyXR
 boKfAiMPt4MA5R+5jNBlF2G+JkuVRoqFqrDeyRTvVY43JQrGtW4IBbY/8keofODcmEiy
 +qzaHAOg1m6fomvRZbHm9zTRTunkNSP/eBp44M/FUXahMYQ+1RKq85pZ81XKprqDvl0Q
 CODH1Rozr8NDbbNH5Ys9uKMYNacxRtVywgPYj9XCxcJLDZ5/TFyyieqZlNvNQQ53r/mQ
 g/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768736537; x=1769341337;
 h=mime-version:user-agent:content-transfer-encoding
 :disposition-notification-to:references:in-reply-to:date:cc:to:from
 :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=te6FnboAFJ6x9uRbg9PS2os1I8lYLucGhR7IWQ0O5mc=;
 b=Zwr6+IXtHGejQ2JXrF0MTNloIMXJ6n3h/WOGkXp+JUXesOMRrusnoVPt4xq5/EPrtb
 lVNI6nXNBERDWVUY5MRwpgeYcpqJkDueA4st2bTu0jviUIPNl+cE0QKR6/+ujckUHIkh
 9bOw67BMPf8J00TqhkS2GoZNTkAGCinyyRuXBdO8TXiDvWYGjlX5BElMw0dGtbAjpFOH
 vbiS9THQqJOsoQfvkWueDyv5ic/z/0KqVI/J7JMTz3VIL8uiBexwYGD6jL5P55Mv3ivA
 h9Na4I/XzcZHVUGuLLk9pCGDc8usVua9Dp6td5VTeJg65sapv4TfNlDHLeKrSynFx+ur
 XPmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmrSAc27Sryh1kUG7fmdqYyj/teMfnGXe64S8MGJg8H8unUNxDIhO4Ohzwu8Ny+VAIsUXHZzcI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzMhtdy6yY8GAcSWZ475g3XWAgr1OQ7pz2+ashmfPYKrWGEFfl1
 /gyleN2nbsOFMDsclIeS2/aF/PbL5Qn+u/V2lDKaT8lr9xCIdPM6P31m
X-Gm-Gg: AY/fxX6wmkk8Q3TMeMC3iSqfTR2qT+UpltgBdUdoJYdE443Zjh0vnUFAZ+tmBDI+uzX
 vqHbpDeDfW3Z7sNxwQkiILvGmpbG8WfunPM73usKZOlnFYkOEYLk6kpLUepiS9ciAVhIRG3aSjO
 fC30Niaacl+uXUid65gXknAVAtv/X5osN/gPT9KLrYR1YT3DrWrjX45aPwuH0rPsFJmD2VLZGqu
 q7gMTXVlGEjV2TMmpPAD1Y+rmNZqUkDN0K1gEhuSjHU0FZ6Nws+9Kvf/IoX1W9IHMVHinjnQJEN
 Kq+54Q0A3MgtagEk3LCLoZbeVNJUuArBwkUZX24mjFsT+ok9dsXI6HV1ctO875QrYBWuYsQYlhl
 eRF91w+8BN7nzy3yvSLrRj+vc/zS7raB8XlTRvSq404aRgt8VQYH7cajxLcf7HqsCbnGITMCvtL
 rgk4educfeteX1UZEfCHnwyc1D2coLZNL/UrYT0HqNItGoaoDjNAEbLN0ENnlyLZ3q6b+tRQ8=
X-Received: by 2002:a17:907:3e82:b0:b87:2780:1b33 with SMTP id
 a640c23a62f3a-b879300dde7mr389871166b.3.1768736536773; 
 Sun, 18 Jan 2026 03:42:16 -0800 (PST)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl.
 [87.205.5.123]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513ea20sm835517266b.12.2026.01.18.03.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 03:42:16 -0800 (PST)
Message-ID: <a728742803f7bef5ab5ec046b85e1cb9ff23171c.camel@gmail.com>
Subject: Re: [PATCH 0/4] amdgpu: Enable Adaptive Sync over PCON with HDMI VRR
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 bernhard.berger@gmail.com
Date: Sun, 18 Jan 2026 12:42:15 +0100
In-Reply-To: <20251220114649.169147-1-tomasz.pakula.oficjalny@gmail.com>
References: <20251220114649.169147-1-tomasz.pakula.oficjalny@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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

On Sat, 2025-12-20 at 12:46 +0100, Tomasz Paku=C5=82a wrote:
> Adaptive Sync over PCON is only available as FreeSync over HDMI. TVs whic=
h do
> not support FreeSync, do not have working VRR with DP -> HDMI 2.1 adapter=
s even
> though adapters will take care of HDMI VRR info packets.
>=20
> First two patches add generic drm edid parsing for HDMI VRR and ALLM.
>=20
> Since HDMI VRR relies on FRL modes, this will only be enabled for PCONs i=
n the
> VRR whitelist. HDMI VRR for native HDMI connector will still not be
> possible/attempted.
>=20
> I myself validated these changes with my Samsung S95B + Bernhard validate=
d on
> LG C4 + FreeSync-less Sony Bravia 8. I used Alienware AW3423DWF that only
> has HDMI 2.0 to check that FreeSync still triggers properly for "older" h=
ardware
>=20
> Tomasz Paku=C5=82a (4):
>   drm/edid: parse HDMI ALLM info
>   drm/edid: parse HDMI VRR information
>   drm/amd/display: rename PCON adaptive sync types
>   drm/amd/display: enable HDMI VRR over PCON
>=20
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +-
>  .../amd/display/modules/inc/mod_info_packet.h |  4 ++--
>  .../display/modules/info_packet/info_packet.c |  4 ++--
>  drivers/gpu/drm/drm_edid.c                    | 20 ++++++++++++++++
>  include/drm/drm_connector.h                   | 23 ++++++++++++++++++
>  6 files changed, 67 insertions(+), 10 deletions(-)

I'd like to inform you that this patch series will be superseded by
another, bigger patch series which compiles my recent work as all the
separate series/patches di conflict with each other.

Thank you.
Tomasz
