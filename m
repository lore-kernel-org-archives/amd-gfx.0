Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D506EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 13:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B834310E4F7;
	Thu, 15 Jun 2023 13:18:51 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A163510E4F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 13:18:47 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-55b619e0ed1so1534685eaf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686835126; x=1689427126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ST/NPFdLxb9C9YkAoS2QfAv4hA0e0A5OH5EkA6BWYdQ=;
 b=DqpWY7iZ3gHCcJSj5a5HWi7cUpng+23qNoFTkHlaVE4onbXiQojEFWzMpdmWr8DOyK
 gdtyUfKslyRIO7Lk8VToHN860Oj0TcWkCgYXpjWaIjuAcQ1dMUu4ks3gOiD+sPK9cou2
 hUa6vxcL/fh2qRCpholQO44p9CpEHS9ZH6bz7FkJuNP8FWlkQ/R94+BVwz1w9+pZJ9ss
 8yxd76ejcG9588GW4e3sVJid8kOluP5nUwMTC32mHylz/AXPUJZfUvEUdmOo/gXnHlE3
 GXRFk9Xmmr2amslwFYQ4xIigIvupEPl0UC2eiIHAF29cfAPtGZZpgew7fqFfv3/Q6qk1
 pfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686835126; x=1689427126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ST/NPFdLxb9C9YkAoS2QfAv4hA0e0A5OH5EkA6BWYdQ=;
 b=lBvJndVyTFrrFw+4/1uU8Iz5PFRBPCuCZC6tMVcK+DvGNlCcQ+CncDjwmYQTUp53VZ
 Awb+9+KzUcSWN66LL8jpFLDIvc1GQbF1ouEdtIzMc/3e5Ok3an2R61yFtz2JDq6M0bp2
 t5uYom9g6N+zFzCMgnD6N7YJdn5f+YC2I9IFY5GD+lCJ7s9hAu5tKHcl7Ci3eO8QChBJ
 fztJpOmiyhSyMl3qx3SJUTyjUc59QffWiJXt6QVexpXxL3TLtkoTwME8aAFK1DAFfVkP
 F1SOBof1dv8x8acMJ7ERU+6GAHLdk0zm36+ejXpsFikh6xqqRIufXoS0/oDBMm/8oHCb
 sFzg==
X-Gm-Message-State: AC+VfDzjuhfcq71aHi/87MQ/wet+koK3oI0KUr9ZaM6SLJM4VKPXdKff
 WoaD4be3quRQeEG5LgIpq+c7aRsi20FHk+ig/UsxOZKA
X-Google-Smtp-Source: ACHHUZ75yfk7GvcE8cXYtIu8JzSCU0M/9YdXuoF9Yq4PKx+eQU+3Ru0kMUK+9SLP5pTrSdO2Sb75cRYJpnNegLlncEE=
X-Received: by 2002:a4a:b34c:0:b0:55d:f13b:ac7d with SMTP id
 n12-20020a4ab34c000000b0055df13bac7dmr470246ooo.5.1686835126539; Thu, 15 Jun
 2023 06:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230615111837.285610-1-jiadong.zhu@amd.com>
In-Reply-To: <20230615111837.285610-1-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Jun 2023 09:18:35 -0400
Message-ID: <CADnq5_NAbitEFLyEE1ciLpW-j4RKh+qqT-+9g1=ucovaGr=0yA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip mark offset for high priority rings
To: jiadong.zhu@amd.com
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jun 15, 2023 at 7:19=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Only low priority rings are using chunks to save the offset.
> Bypass the mark offset callings from high priority rings.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring_mux.c
> index 73516abef662..b779ee4bbaa7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -423,6 +423,9 @@ void amdgpu_sw_ring_ib_mark_offset(struct amdgpu_ring=
 *ring, enum amdgpu_ring_mu
>         struct amdgpu_ring_mux *mux =3D &adev->gfx.muxer;
>         unsigned offset;
>
> +       if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
> +               return;
> +
>         offset =3D ring->wptr & ring->buf_mask;
>
>         amdgpu_ring_mux_ib_mark_offset(mux, ring, offset, type);
> --
> 2.25.1
>
